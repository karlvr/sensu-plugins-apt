#!/bin/bash
#
# Check for APT updates available

if [ ! -x /usr/lib/update-notifier/apt-check ]; then
	echo "APTUpdates UNKNOWN: /usr/lib/update-notifier/apt-check not available"
	exit 3
fi

OUTPUT=$(/usr/lib/update-notifier/apt-check 2>&1)
if [ $? != 0 ]; then
	echo "APTUpdates UNKNOWN: Failed to run /usr/lib/update-notifier/apt-check"
	exit 3
fi

PACKAGES=$(/usr/lib/update-notifier/apt-check --package-names 2>&1 | tr '\n' ' ')

if [[ ! "$OUTPUT" =~ ";0" ]]; then
	echo "APTUpdates WARNING: Security updates available: $OUTPUT $PACKAGES"
	exit 1
fi

if [[ ! "$OUTPUT" =~ "0;" ]]; then
	echo "APTUpdates OK: Updates available: $OUTPUT $PACKAGES"
	exit 0
fi
