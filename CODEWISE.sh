#!/bin/bash

# Function to display the banner
display_banner() {
  clear
  echo "   █████████     ███████    ██████████   ██████████ █████   ███   █████ █████  █████████  ██████████"
  echo "  ███░░░░░███  ███░░░░░███ ░░███░░░░███ ░░███░░░░░█░░███   ░███  ░░███ ░░███  ███░░░░░███░░███░░░░░█"
  echo " ███     ░░░  ███     ░░███ ░███   ░░███ ░███  █ ░  ░███   ░███   ░███  ░███ ░███    ░░░  ░███  █ ░"
  echo "░███         ░███      ░███ ░███    ░███ ░██████    ░███   ░███   ░███  ░███ ░░█████████  ░██████"
  echo "░███         ░███      ░███ ░███    ░███ ░███░░█    ░░███  █████  ███   ░███  ░░░░░░░░███ ░███░░█"
  echo "░░███     ███░░███     ███  ░███    ███  ░███ ░   █  ░░░█████░█████░    ░███  ███    ░███ ░███ ░   █"
  echo " ░░█████████  ░░░███████░   ██████████   ██████████    ░░███ ░░███      █████░░█████████  ██████████"
  echo "  ░░░░░░░░░     ░░░░░░░    ░░░░░░░░░░   ░░░░░░░░░░      ░░░   ░░░      ░░░░░  ░░░░░░░░░  ░░░░░░░░░░"
  echo
}

# Function to display the menu and get user input
display_menu() {
echo "+-----------------------------------------+"
echo "|        Main Menu                        |"
echo "+-----------------------------------------+"
echo "| 1. Scan for End of Life componets [EOD] |"
echo "+-----------------------------------------+"
echo "| 2. Scan for Direct Dependnecies in Code |"
echo "+-----------------------------------------+"
echo "| 3. Scan for Code level vulnerbailities  |"
echo "+-----------------------------------------+"
echo "| 4. Quit                                 |"
echo "+-----------------------------------------+"
}

read -p "Enter the path to your project: " project_path

while true; do
  display_banner

  echo "Project Path: $project_path"
  
  display_menu
  read -p "Enter your choice (1/2/3/4): " choice
case $choice in
  1)

   echo "+-----------------------------------------------------+"
   echo "| Performing Recursive Scan & saving data in EOD.json |"
   echo "+-----------------------------------------------------+"
sleep 2
    retire_output=$(retire --outputformat json --includeOsv  --path "$project_path")
    jq '.' <<< "$retire_output" > "EOD.json"
    ;;
  2)
    echo "+----------------------------------------------------------------------------------------------------------+"
    echo "|                       Performing Scan for Direct Dependnecies in Code                                    |"
    echo "+----------------------------------------------------------------------------------------------------------+"
    
    echo "+----------------------------------------------------------------------------------------------------------+"
    echo "| lease check Vulnerable-Dependencies.txt to find vulnerabilities affecting your project’s dependencies    |"
    echo "+----------------------------------------------------------------------------------------------------------+"
    
    
    # Add code for Action A here
    osv-scanner -r "$project_path" > Vulnerable-Dependencies.txt
    ;;
    
  3)
  
    echo "+----------------------------------------------------------------------------------------------------------+"
    echo "|        Performing Scan for Code-level vulnerabilities & Saving data in Code-Scan.txt                     |"
    echo "+----------------------------------------------------------------------------------------------------------+"
      
      # Add code for Action C here
      
      trivy fs --scanners vuln,secret,config $project_path > Code-Scan.txt
      sleep 5
      ;;
    4)
      echo "Exiting CODEWISE. Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please try again."
      ;;
  esac
done





