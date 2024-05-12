#!/bin/bash
#
#
#
#################################################################################################
#Author: Mayuri Pakhe
#Date: 12-May-2024
#Vesrion: V1
#This script helps to show list of people who have access for perticular repository
#################################################################################################

#helper()


# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
     local endpoint="$1"
     local url="${API_URL}/${endpoint}"

     # Send a GET request to the GitHub API with authentication
     curl -s -u "${USERNAME}:${TOKEN}" "$url"
}
# Function to list users with read access to the repository
 function list_users_with_read_access {
     local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

      # Fetch the list of collaborators on the repository
      collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

        # Display the list of collaborators with read access
	     if [[ -z "$collaborators" ]]; then
	     		echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
	     else
	                echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
	                echo "$collaborators"
	    fi
	}

#function helper{
#	cmd_arg=2
#	if [ $# -ne cmd_arg]; then
#	echo " please execute the script with required arg"
#	echo "$collaborators"
#	fi
#}

	echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
	list_users_with_read_access













