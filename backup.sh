# !/bin/bash
#
# Backup Script
#

# Global Vars
#
# Leave as `hostname` or menually set what you would like the files hostname to be set to
#

host=`hostname`

#
# Set the location of the secondary media mount point
#

location="/mnt/backup/"

#
# Set the retention policy in days
#

retire_after=7

#
# Get current date
#

bdate=`date +'%Y-%m-%d'`

#
# Set location of exclude list
#

exclude_list=$PWD/exclude_list

#Functions
retire(){
	files=(${location}*)
        rdate=`date -d -${retire_after}days +'%Y-%m-%d'`
	valid="\*$"
	if [[ ! ${files[0]} =~ $valid ]]
	then
		for item in ${files[*]}
        	do
                	fdate=`stat -c%y $item | cut -c1-10`
                	if [ $rdate == $fdate ]
                	then
                        	`rm $item`
                	fi
        	done
	fi	
}
backup(){
	`tar cpzf "$location$host"-system_backup-$bdate.tar.gz -X $exclude_list /`
}

#
# Main
#
retire
backup
