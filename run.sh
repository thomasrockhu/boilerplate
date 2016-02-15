#!/bin/bash

port=8000
count=`netstat -ant | grep LISTEN | grep -c ":${port}\W"`
uname=`uname -s`
if [ $count -gt 0 ]; then
    echo "You're already running a server"
    exit 1
fi

# Start the devserver.
pkill -U $UID -f 'manage.py runserver'
while true; do
    python ./manage.py runserver_plus 0.0.0.0:$port
    sleep 1
done
