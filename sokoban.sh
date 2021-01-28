#!/bin/bash

clear
tput civis

#echo -en "\e[y;xftext"

#printf "\e[?251"

key=" "

x=6
y=6

board=( " " " " " " " " " " " " " " " " " " " "
	" " "#" "#" "#" "#" "#" "#" "#" "#" " "
	" " "#" " " " " " " " " " " " " "#" " "
	" " "#" " " " " " " " " "H" " " "#" " "
	" " "#" " " " " " " "H" " " " " "#" " "
	" " "#" " " " " " " "+" " " " " "#" " "
	" " "#" " " " " " " " " " " " " "#" " "
	" " "#" " " " " " " " " " " " " "#" " "
	" " "#" "#" "#" "#" "#" "#" "#" "#" " "
	" " " " " " " " " " " " " " " " " " " ")

for i in {1..11}
do
	for j in {1..11}
	do
		pos=$((($i-1)*10+($j-1)))
		echo -en "\e[$i;${j}f${board[pos]}"
	done
done

while true
do
	y_move=0
	x_move=0

	read -rsn 1 key

	case $key in
	q) clear; exit ;;
	i) y_move=-1 ;;
	j) x_move=-1 ;;
	k) y_move=1 ;;
	l) x_move=1 ;;
	*) continue ;;
	esac

	x_target=$(($x+$x_move))
	y_target=$(($y+$y_move))

	target_pos=$((($y_target-1)*10+($x_target-1)))

	if [ "${board[$target_pos]}" = "#" ]
	then
		continue
	elif [ "${board[$target_pos]}" = "H" ]
	then
		x_behind_target=$(($x+$x_move*2))
		y_behind_target=$(($y+$y_move*2))
		behind_target_pos=$((($y_behind_target-1)*10+($x_behind_target-1)))

		if [ "${board[$behind_target_pos]}" = "#" ] || [ "${board[$behind_target_pos]}" = "H" ]
		then
			continue
		fi

		board[$behind_target_pos]="H"
		board[$target_pos]=" "
		echo -en "\e[$y_behind_target;${x_behind_target}fH"

	fi

	echo -en "\e[$y_target;${x_target}f+"
	echo -en "\e[$y;${x}f ";

	x=$x_target
	y=$y_target
done

tput cnorm
