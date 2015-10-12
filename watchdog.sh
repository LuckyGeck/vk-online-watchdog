#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <vk_id>"
    exit 1
fi

function notify
{
    TEXT="offline"
    if [ "$2" -ne 0 ]
    then
        TEXT="online"
    fi
    notify-send -a VK "VK Status for $1" "$1 is now $TEXT"
    echo "$(date -R): $1 is now $TEXT"
}

STATUS=
while true
do
    NEW_STATUS=$(curl -s 'https://api.vk.com/method/users.get?user_ids='"$1"'&fields=online' | grep -c '"online":1')
    if [ "$NEW_STATUS" != "$STATUS" ]
    then
        STATUS=$NEW_STATUS
        notify "$1" "$STATUS"
    fi
    sleep 10s
done
