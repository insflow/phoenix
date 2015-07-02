HOSTNAME=`hostname`
IMAGE=insflow/pmail:v1.5
Name=pmail

kill -9 $(lsof -i:25|tail -1|awk '"$1"!=""{print $2}') 1>/dev/null 2>&1
echo "create mailserver now,please wait..."
docker run -dti  -p 25:25 -p 110:110 -p 143:143 -p 993:993 -p 995:995 -p 3306:3306  --name ${Name} -h ${HOSTNAME} ${IMAGE} 1>/dev/null 2>&1
while true 
do
    str=`docker logs ${Name}`
    result=$(echo $str | grep "enjoy")
    if [[ "$result" != "" ]]
    then
        break
    else
        sleep 1
    fi
done
docker logs ${Name}
