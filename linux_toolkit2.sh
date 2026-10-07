#!/bin/bash

# ============================================
# FUN WITH LINUX - DEVOPS TOOLKIT
# ============================================

while true
do
    clear

    echo "========================================"
    echo "     FUN WITH LINUX - DEVOPS TOOLKIT"
    echo "========================================"
    echo
    echo "1. System Information"
    echo "2. CPU & RAM Monitor"
    echo "3. Disk Usage"
    echo "4. Process Monitor"
    echo "5. Network Checker"
    echo "6. File Backup"
    echo "7. Log Management"
    echo "8. User Information"
    echo "9. Server Health Check"
    echo "10. Exit"
    echo

    read -p "Enter your choice: " choice

    case $choice in

    # =========================================
    # 1. SYSTEM INFORMATION
    # =========================================

    1)
        echo
        echo "========================================"
        echo "        SYSTEM INFORMATION"
        echo "========================================"

        echo
        echo "Hostname:"
        hostname

        echo
        echo "Operating System:"
        grep PRETTY_NAME /etc/os-release

        echo
        echo "Kernel Version:"
        uname -r

        echo
        echo "CPU:"
        lscpu | grep "Model name" | head -1

        echo
        echo "Memory:"
        free -h

        echo
        echo "System Uptime:"
        uptime
        ;;


    # =========================================
    # 2. CPU & RAM MONITOR
    # =========================================

    2)
        echo
        echo "========================================"
        echo "        CPU & RAM MONITOR"
        echo "========================================"

        echo
        echo "CPU Usage:"
        top -bn1 | grep "Cpu(s)"

        echo
        echo "Memory Usage:"
        free -h

        echo
        echo "Top CPU Processes:"
        ps aux --sort=-%cpu | head -6
        ;;


    # =========================================
    # 3. DISK USAGE
    # =========================================

    3)
        echo
        echo "========================================"
        echo "           DISK USAGE"
        echo "========================================"

        echo
        echo "Disk Space:"
        df -h

        echo
        echo "Current Directory Size:"
        du -sh .

        echo
        echo "Largest Files/Folders:"
        du -sh * 2>/dev/null | sort -hr | head -10
        ;;


    # =========================================
    # 4. PROCESS MONITOR
    # =========================================

    4)
        echo
        echo "========================================"
        echo "         PROCESS MONITOR"
        echo "========================================"

        echo
        echo "Running Processes:"
        ps aux | head -10

        echo
        echo "Top CPU Consuming Processes:"
        ps aux --sort=-%cpu | head -10

        echo
        echo "Top Memory Consuming Processes:"
        ps aux --sort=-%mem | head -10
        ;;


    # =========================================
    # 5. NETWORK CHECKER
    # =========================================

    5)
        echo
        echo "========================================"
        echo "          NETWORK CHECKER"
        echo "========================================"

        echo
        echo "IP Address:"
        hostname -I

        echo
        echo "Network Interfaces:"
        ip -br addr

        echo
        echo "Internet Connectivity:"
        
        if ping -c 2 -W 2 google.com > /dev/null 2>&1
        then
            echo "STATUS: CONNECTED"
        else
            echo "STATUS: NOT CONNECTED"
        fi

        echo
        echo "Default Gateway:"
        ip route | grep default
        ;;


    # =========================================
    # 6. FILE BACKUP
    # =========================================

    6)
        echo
        echo "========================================"
        echo "            FILE BACKUP"
        echo "========================================"

        mkdir -p backup

        echo
        echo "Creating backup..."

        BACKUP_FILE="backup/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

        tar --exclude="./backup" -czf "$BACKUP_FILE" . 2>/dev/null

        if [ $? -eq 0 ]
        then
            echo
            echo "Backup completed successfully!"
            echo
            echo "Backup file:"
            echo "$BACKUP_FILE"
        else
            echo
            echo "Backup failed."
        fi
        ;;


    # =========================================
    # 7. LOG MANAGEMENT
    # =========================================

    7)
        echo
        echo "========================================"
        echo "          LOG MANAGEMENT"
        echo "========================================"

        mkdir -p logs

        LOG_FILE="logs/devops.log"

        echo "$(date) - Log check performed" >> "$LOG_FILE"

        echo
        echo "Project Log File:"
        echo "$LOG_FILE"

        echo
        echo "Recent Log Entries:"
        tail -10 "$LOG_FILE"
        ;;


    # =========================================
    # 8. USER INFORMATION
    # =========================================

    8)
        echo
        echo "========================================"
        echo "          USER INFORMATION"
        echo "========================================"

        echo
        echo "Current User:"
        whoami

        echo
        echo "User ID and Groups:"
        id

        echo
        echo "Home Directory:"
        echo "$HOME"

        echo
        echo "Logged-in Users:"
        who
        ;;


    # =========================================
    # 9. SERVER HEALTH CHECK
    # =========================================

    9)
        echo
        echo "========================================"
        echo "         SERVER HEALTH CHECK"
        echo "========================================"

        echo
        echo "Checking system health..."
        echo

        # CPU
        CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')

        echo "CPU Usage: $CPU_USAGE%"

        # Memory
        MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.1f", $3/$2 * 100}')

        echo "Memory Usage: $MEMORY_USAGE%"

        # Disk
        DISK_USAGE=$(df / | awk 'NR==2 {print $5}')

        echo "Disk Usage: $DISK_USAGE"

        # Network
        if ping -c 1 -W 2 google.com > /dev/null 2>&1
        then
            NETWORK_STATUS="OK"
        else
            NETWORK_STATUS="FAILED"
        fi

        echo "Network: $NETWORK_STATUS"

        echo
        echo "System Uptime:"
        uptime

        echo
        echo "========================================"

        if [ "$NETWORK_STATUS" = "OK" ]
        then
            echo "       SERVER STATUS: HEALTHY"
        else
            echo "       SERVER STATUS: CHECK NETWORK"
        fi

        echo "========================================"
        ;;


    # =========================================
    # 10. EXIT
    # =========================================

    10)
        echo
        echo "========================================"
        echo " Thank you for using Linux DevOps Toolkit"
        echo "========================================"
        exit 0
        ;;


    # =========================================
    # INVALID OPTION
    # =========================================

    *)
        echo
        echo "Invalid choice!"
        echo "Please select a number from 1 to 10."
        ;;

    esac

    echo
    read -p "Press Enter to continue..."

done
