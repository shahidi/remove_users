#!/bin/bash

# WARNING: This script will permanently remove cPanel accounts.
# There is no undo option. Use with extreme caution.
# It is strongly recommended to back up all data before proceeding.

# Check if a file is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# The file containing usernames, one per line
USER_FILE="$1"

# Check if the user file exists
if [ ! -f "$USER_FILE" ]; then
    echo "Error: File '$USER_FILE' not found."
    exit 1
fi

# Loop through each line (username) in the file
while IFS= read -r username
do
  # Ensure the line is not empty
  if [ -n "$username" ]; then
    echo "Attempting to remove account: $username"
    # Execute the removeacct script with the --force flag
    /scripts/removeacct --force "$username"
    echo "Account removal for '$username' process completed."
    echo "----------------------------------------"
  fi
done < "$USER_FILE"

echo "All usernames from '$USER_FILE' have been processed."
