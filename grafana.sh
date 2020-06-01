action=$1
process="grafana-server"
scriptName="grafana.sh"
result=`ps -ef | grep "$process" | grep -v "$scriptName" | grep -v grep`

case $action in
    "start")
        if [ -z "$result" ]
        then
            echo "Starting $process..."            
            bin/grafana-server &>$process.log &
        else
            echo "$process is already running."
            echo "$result"
        fi
        ;;
    "stop")
        if [ -z "$result" ]
        then
            echo "$process is not running."
        else
            echo "Stopping $process..."
            echo "$result"
            ps -ef | grep "$process" | grep -v "$scriptName" | grep -v grep | awk '{print $2}' | xargs kill
        fi
        ;;
    "status")
        if [ -z "$result" ]
        then
            echo "$process is not running."
        else
            echo "$process is running."
            echo "$result"
        fi
        ;;
    *)
        echo "Usage: ./$scriptName <start|stop|status>"
        ;;
esac


