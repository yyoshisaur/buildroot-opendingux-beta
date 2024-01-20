#!/bin/sh

PLATFORMS=$(sed -n 's/^opkPlatforms="\(.*\)"$/\1/p' /usr/share/gmenu2x/gmenu2x.conf)

MODEL=$(sed -n 's/.*,\(.*\)ingenic.*/\1/p' /sys/firmware/devicetree/base/compatible)
case $MODEL in
	rs90|gcw0)
		;;
	*)
		PLATFORMS=$MODEL,$PLATFORMS
		;;
esac

[ -f ~/.gmenu2x/gmenu2x.conf ] && sed -i '/^opkPlatforms=".*"$/d' ~/.gmenu2x/gmenu2x.conf
echo "opkPlatforms=\"$PLATFORMS\"" >> ~/.gmenu2x/gmenu2x.conf

exec /usr/libexec/gmenu2x
