import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Item {
    id: root
    implicitWidth: 400
    implicitHeight: 180

    // Noctalia injects this into the widget settings automatically
    property var pluginApi: null
    
    // Instance-specific settings (local to this one widget)
    readonly property var cfg: pluginApi?.pluginSettings ?? ({})
    readonly property var defaults: pluginApi?.manifest?.metadata?.defaultSettings ?? ({})
    
    // Internal state to track the toggle before "Apply" is pressed
    property bool startOnMonday: cfg.startOnMonday ?? defaults.startOnMonday ?? true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Style.marginL
        spacing: Style.marginM

        NText {
            text: "Widget Instance Settings"
            font.bold: true
            font.pointSize: Style.fontSizeM
            color: Color.mPrimary
        }

        RowLayout {
            Layout.fillWidth: true
            NText { 
                text: "Start week on Monday"
                Layout.fillWidth: true
                color: Color.mOnSurface
            }
            
            NToggle { 
                checked: root.startOnMonday
                onToggled: root.startOnMonday = checked
            }
        }
        Item { Layout.fillHeight: true }
    }

    // MANDATORY: The shell calls this when "Apply" or "OK" is clicked
    function saveSettings() {
        if (pluginApi) {
            pluginApi.pluginSettings.startOnMonday = root.startOnMonday;
            pluginApi.saveSettings();
            Logger.i("CalendarPlugin", "Instance settings saved.");
        }
    }
}
