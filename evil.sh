#!/bin/bash
# By Sultan

# A tool that gives you the process most using CPU or Memory
# 1. currently using most CPU
# 2. currently using most MEM

#Get p with most CPU usgae
mostCPU(){
	#Get process ID
	read PID <<< $(ps -e -o pid -r | head -n 2 | cut -d' ' -f 2)
	#Get process CPU usage percentage
	read CPU <<< $(ps -e -o %cpu -r | head -n 2 | cut -d' ' -f 3)
	
	echo "$(tput setaf 5)The process that is using the most CPU is"

	#Print process info
	while read p;
	do
		echo "$(tput setaf 7)$p"
		
	done < <(ps -ef -o command ${PID})

	echo "$(tput setaf 4)It's using ${CPU} %"
	
	echo "$(tput setaf 2)"
}

mostMEM(){
	#Get process ID
	read PID <<< $(ps -e -o pid -r | head -n 2 | cut -d' ' -f 2)
	#Get process MEM usage percentage
	read MEM <<< $(ps -e -o %mem -r | head -n 2 | cut -d' ' -f 2)
	
	echo "$(tput setaf 5)The process that is using the most Memory is"

	#Print process info
	while read p;
	do
		echo "$(tput setaf 7)$p"
		
	done < <(ps -ef -o command ${PID})

	echo "$(tput setaf 4)It's using ${MEM} %"
	
	echo "$(tput setaf 2)"
}

main(){
	# If argument is 1 show process currently using most CPU
	if [ $1 -eq '1' ]; then
		mostCPU
	# If argument is 2 show process currently using most MEM		
	elif [ $1 -eq '2' ]; then
		mostMEM
	# Else promte user
	else
		echo "$(tput setaf 2)What do want to see?"
		echo "$(tput setaf 3)1. Currently using most CPU."
		echo "$(tput setaf 3)2. Currently using most Memory."
	    read -p "" options
	    case $options in
	        [1]* ) mostCPU;;
			[2]* ) mostMEM;;
	        [exit]* ) exit;;
	        * ) echo "Please select an option.";;
	    esac
	fi
}

main $@
