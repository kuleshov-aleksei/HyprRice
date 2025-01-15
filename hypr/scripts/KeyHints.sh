#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keyhints. Idea got from Garuda Hyprland

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi is running and kill it if it is
if pgrep -x "rofi" > /dev/null; then
    pkill rofi
fi

# Detect monitor resolution and scale
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Calculate width and height based on percentages and monitor resolution
width=$((x_mon * hypr_scale / 100))
height=$((y_mon * hypr_scale / 100))

# Set maximum width and height
max_width=1200
max_height=1000

# Set percentage of screen size for dynamic adjustment
percentage_width=70
percentage_height=70

# Calculate dynamic width and height
dynamic_width=$((width * percentage_width / 100))
dynamic_height=$((height * percentage_height / 100))

# Limit width and height to maximum values
dynamic_width=$(($dynamic_width > $max_width ? $max_width : $dynamic_width))
dynamic_height=$(($dynamic_height > $max_height ? $max_height : $dynamic_height))

super=' '

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad --width=$dynamic_width --height=$dynamic_height \
    --center \
    --title="Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" \
"=" "SUPER KEY (Windows Key)" "(SUPER KEY)" \
"$super enter" "Terminal" "(kitty)" \
"$super SHIFT enter" "DropDown Terminal" "(kitty-pyprland)" \
"$super SHIFT K" "Searchable Keybinds" "(Keybinds)" \
"$super A" "Desktop Overview" "(AGS Overview)" \
"$super D" "App Launcher" "(rofi-wayland)" \
"$super E" "Open File Manager" "(Thunar)" \
"$super Q" "close active window" "(not kill)" \
"$super Shift Q " "kills an active window" "(kill)" \
"$super Z" "Desktop Zoom" "(pyprland)" \
"$super Alt V" "Clipboard Manager" "(cliphist)" \
"$super B" "Hide/UnHide Waybar" "waybar" \
"$super CTRL B" "Choose waybar styles" "(waybar styles)" \
"$super ALT B" "Choose waybar layout" "(waybar layout)" \
"$super ALT R" "Reload Waybar swaync Rofi" "CHECK NOTIFICATION FIRST!!!" \
"$super SHIFT N" "Launch Notification Panel" "swaync Notification Center" \
"Print" "screenshot region" "(grim)" \
"ALT Print" "Screenshot active window" "active window only" \
"CTRL ALT P" "power-menu" "(wlogout)" \
"$super L" "screen lock" "(hyprlock)" \
"CTRL ALT Del" "Hyprland Exit" "(SAVE YOUR WORK!!!)" \
"$super F" "Fullscreen" "Toggles to full screen" \
"$super ALT L" "Toggle Dwindle | Master Layout" "Hyprland Layout" \
"$super Shift F" "Toggle float" "single window" \
"$super ALT F" "Toggle all windows to float" "all windows" \
"$super Shift B" "Toggle Blur" "normal or less blur" \
"$super SHIFT G" "Gamemode! All animations OFF or ON" "toggle" \
"$super ," "Rofi Emoticons" "Emoticon" \
"$super ALT V" "Clipboard Manager" "cliphist" \
"$super H" "Launch this app" "" \
"" "" ""
