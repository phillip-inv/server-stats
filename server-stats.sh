#!/bin/bash

# Uptime
echo "Uptime: $(uptime -p)"
echo "--------------------------------------------"

# Load Average
echo "Load Average (1, 5, 15 minutes): $(uptime | awk -F'load average:' '{ print $2 }')"
echo "--------------------------------------------"

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Usage: $CPU_USAGE%"
echo "--------------------------------------------"

# Memory Usage
MEMORY_STATS=$(free -h | grep Mem | awk '{print "Used: " $3 ", Free: " $4 ", Total: " $2 ", Used Percentage: " int($3/$2 * 100) "%"}')
echo "Memory Usage: $MEMORY_STATS"
echo "--------------------------------------------"

# Disk Usage
DISK_STATS=$(df -h | grep '^/dev' | awk '{print $1, "Used: " $3, "Free: " $4, "Total: " $2, "Used Percentage: " $5}')
echo "Disk Usage:"
echo "$DISK_STATS"
echo "--------------------------------------------"

# Top 5 Processes by CPU Usage
echo "Top 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6
echo "--------------------------------------------"

# Top 5 Processes by Memory Usage
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6
echo "--------------------------------------------"
