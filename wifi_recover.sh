#!/usr/bin/env bash
# Go crontab, setup running every 2 minutes
# */2 * * * * /usr/local/bin/wifi_recover.sh
# Read log at sudo tail -f /var/log/wifi_recover.log


# Interface name
IFACE="wlp37s0"

# Target to ping
TARGET="8.8.8.8"

# Log file
LOGFILE="/var/log/wifi_recover.log"

# Ping 3 times with 1s timeout
ping -c3 -W1 "$TARGET" > /dev/null

if [ $? -ne 0 ]; then
    echo "$(date): No connectivity, restarting WiFi..." >> "$LOGFILE"
    nmcli dev disconnect "$IFACE"
    sleep 2
    nmcli dev connect "$IFACE"
else
    echo "$(date): Connectivity OK." >> "$LOGFILE"
fi
