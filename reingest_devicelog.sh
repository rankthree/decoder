#!/bin/bash
LOG_DIR="/var/log/devicelog"
DELAY=0.05

echo "🚀 Starting processing of old log files in $LOG_DIR"

for old_log in "$LOG_DIR"/*2025*.log; do
    if [[ -f "$old_log" ]]; then
        # Tạo file log mới để ghi lại
        new_log="${old_log%.*}-current.log"
        touch "$new_log"
        chmod 644 "$new_log"

        echo "📂 Processing: $old_log"
        echo "     → Copying to: $new_log"
        
        # Đọc từng dòng và ghi thêm (append) để trigger Logcollector
        tail -n +1 "$old_log" | while IFS= read -r line; do
            echo "$line" >> "$new_log"
            sleep $DELAY
        done
        
        echo "✅ Completed: $new_log"
        echo "----------------------------------------"
    fi
done
echo "🎉 All files have been processed successfully!"
