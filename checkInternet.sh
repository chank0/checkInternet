#!/bin/bash

# Check for internet access and report it to stdout
# Adapted from answer to https://stackoverflow.com/questions/17291233/how-to-check-internet-access-using-bash-script-in-linux


INTERNET_STATUS="UNKNOWN"
TIMESTAMP=`date +%s`
changed=`date +%s`
while [ 1 ]
do
     now=$(date +%s)
     ping -c 1 8.8.4.4 > /dev/null 2>&1
     if [ $? -eq 0 ] ; then
         if [ "$INTERNET_STATUS" != "UP" ]; then
	     echo " Duration: "$(($now - $changed))" seconds"
             echo -n "UP   `date +%Y-%m-%dT%H:%M:%S%Z`  ip: $(curl https://api.ipify.org 2> /dev/null) ";
             INTERNET_STATUS="UP"
	     changed=$now
         fi
     else
         if [ "$INTERNET_STATUS" = "UP" ]; then
	     echo " Duration: "$(($now - $changed))" seconds"
             echo -n "DOWN `date +%Y-%m-%dT%H:%M:%S%Z`";
             INTERNET_STATUS="DOWN"
	     changed=$now
         fi
     fi
     sleep 1
done;
