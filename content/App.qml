import QtQuick
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtQml 2.0

Window {
    width: 420
    height: 500
    visible: true
    title: "CoffeeMachine"
    color: "lightyellow"

    // variables to track item selection and status
    property string selectedItem: ""
    property bool itemReady: false
    property bool processing: false
    property int remainingTime: 0
    property int preparationTime: 5000 // 5 seconds in milliseconds

    // Initialize currentState property
    property string currentState: "MainOptions"

    // Define the main screen
    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        // Define the clock component

        Text {
            id: clockLabel
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            font.pixelSize: 16
            color: "red"
            text: " "
            visible: true


            Timer {
                interval: 1000 // Update every second
                running: true
                repeat: true
                onTriggered: {
                    var currentDate = new Date();
                    clockLabel.text = currentDate.toLocaleString(Qt.locale( "fi_FI"));
                }
            }
        }


        // Welcome message
        Text {
            text: "Welcome! Please select an option:"
            font.pixelSize: 25
            color: "black"
            visible: currentState === "MainOptions"
        }

        // Water selection
        Rectangle {
            width: 300
            height: 100
            Text {
                id: water
                text: qsTr("Water")
                font.pixelSize: 30
                //anchors.centerIn: parent
                x:10
                y:30
            }
            color: "#87CEEB" // Set the desired color here
            radius: 5 // Optional: Set corner radius for rounded corners
            visible: !processing
            Image {
                id: waterImage
                width: 150
                height: 80
                source: "images/water.png"
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: 67 // Path to the water image
                anchors.centerIn: parent


            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!processing) {
                        selectedItem = "Water"
                        processing = true
                        currentState = "WaterSubOptions"
                        startPreparationTimer()
                    }

                }
                 cursorShape: Qt.PointingHandCursor
            }
        }

        // Hot chocolate selection
        Rectangle {
            width: 300
            height: 100
            Text {
                id: hotchoco
                text: qsTr("Hot\nChocolate")
                font.pixelSize: 30
                //wrapMode: Text.Wrap
                //anchors.centerIn: parent
                x:10
                y:10
            }
            color: "#ffeecc" // Set the desired color here
            radius: 5 // Optional: Set corner radius for rounded corners
            visible: !processing

            Image {
                id: chocolateImage
                width: 130
                height: 85
                source: "images/hot_choco.png"
                anchors.verticalCenterOffset: 1
                anchors.horizontalCenterOffset: 71 // Path to the chocolate image
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!processing) {
                        selectedItem = "Hot Chocolate"
                        processing = true
                        currentState = "ChocolateSubOptions"
                        startPreparationTimer()
                    }
                }
                 cursorShape: Qt.PointingHandCursor
            }
        }

        // Coffee selection
        Rectangle {
            width: 300
            height: 100
            Text {
                id: coffee
                text: qsTr("Coffee")
                font.pixelSize: 30
                //wrapMode: Text.Wrap
                //anchors.centerIn: parent
                x:10
                y:20
            }
            color: "lightgray" // Set the desired color here
            radius: 5 // Optional: Set corner radius for rounded corners
            visible: !processing
            Image {
                id: coffeeImage
                width: 150
                height: 85
                source: "images/coffee.png"
                anchors.verticalCenterOffset: 1
                anchors.horizontalCenterOffset: 67 // Path to the coffee image
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!processing) {
                        selectedItem = "Coffee"
                        processing = true
                        currentState = "CoffeeSubOptions"
                        startPreparationTimer()
                    }
                }
                 cursorShape: Qt.PointingHandCursor
            }
        }

        // Display status message
        Text {
            text: processing ? "Preparing " + selectedItem + "..." : (itemReady ? "<b>" + selectedItem + " is ready!</b>" : "")
            font.pixelSize: 27
            color: processing ? "blue" : (itemReady ? "green" : "black")
        }

        // Timer display
        Text {
            text: remainingTime > 0 ? "Remaining time: " + Math.ceil(remainingTime / 1000) + " seconds" : ""
            font.pixelSize: 27
            color: "black"
        }
    }

    // Define function to start the preparation timer
    function startPreparationTimer() {
        remainingTime = preparationTime
        preparationTimer.start()
    }

    // Timer to track preparation time
    Timer {
        id: preparationTimer
        interval: 100 // 0.1 second
        running: false
        repeat: true
        onTriggered: {
            remainingTime -= interval
            if (remainingTime <= 0) {
                itemReady = true
                processing = false
                preparationTimer.stop()
                // Reset variables to allow selection of another drink
                currentState = "MainOptions" // Reset to show menu options again
               // selectedItem = ""
            }
        }
    }
}
