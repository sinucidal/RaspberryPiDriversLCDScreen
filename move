#!/bin/sh

##################################################################
#

# This script will move the cursor to a specified point based on  #

# user selected row and column.                                   
#

# Written By:...........Sinucidal                                 #

# Date:.................04-08-2017                                #

# Hardware:.............SainSmart 20x4 character LCD on a         #

#			Raspberry Pi B+ running Moebius OS        #

# Restrictions:.........None. This code is open to the community  #

#			to use and modify at will. If you make it #

#			better please feel free to message me. It #

#			It should work on other Raspberry Pi OSes #

#			and similar LCDs but was only built and   #

#			tested on the hardware mentioned above.   #

#
##################################################################

row=$1

col=$2


case $row in

	1)						#  The first address at this row is 128

	pos=$((col+127))				#  add column to 127 (128-1)

	;;

	2)						#  The first address in this row is 192

	pos=$((col+191))				#  add column to 191 (192-1)

	;;

	3)						#  The first address in this row is 148

	pos=$((col+147))				#  add column to 147 (148-1)

	;;

	4)						#  The first address in this row is 212

	pos=$((col+211))				#  add column to 211 (212-1)

	;;

	*)

	echo -e "please enter a valid column number"	#  There are only four columns

	;;

esac

echo -e "obase=16; $pos" | bc

exit 0
