#!/bin/bash

# 인수 개수 확인
if [ $# -ne 3 ]; then
    echo "입력값 오류"
    exit 1
fi

# 명령줄 인수 할당
input_month=$1
input_day=$2
input_year=$3

# 월을 대문자로 변환
input_month=$(echo "$input_month" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

# 월 변환
case $input_month in
    jan|1|january) month="Jan" ;;
    feb|2|february) month="Feb" ;;
    mar|3|march) month="Mar" ;;
    apr|4|april) month="Apr" ;;
    may|5) month="May" ;;
    jun|6|june) month="Jun" ;;
    jul|7|july) month="Jul" ;;
    aug|8|august) month="Aug" ;;
    sep|9|september) month="Sep" ;;
    oct|10|october) month="Oct" ;;
    nov|11|november) month="Nov" ;;
    dec|12|december) month="Dec" ;;
    *) 
        echo "$input_month is not a valid month"
        exit 1
        ;;
esac

# 윤년 판별
if (( input_year % 4 == 0 )); then
    if (( input_year % 100 == 0 )); then
        if (( input_year % 400 == 0 )); then
            leap_year=1
        else
            leap_year=0
        fi
    else
        leap_year=1
    fi
else
    leap_year=0
fi

# 각 달의 일수 설정
if [ "$month" = "Jan" ] || [ "$month" = "Mar" ] || [ "$month" = "May" ] || [ "$month" = "Jul" ] || [ "$month" = "Aug" ] || [ "$month" = "Oct" ] || [ "$month" = "Dec" ]; then
    max_day=31
elif [ "$month" = "Apr" ] || [ "$month" = "Jun" ] || [ "$month" = "Sep" ] || [ "$month" = "Nov" ]; then
    max_day=30
elif [ "$month" = "Feb" ]; then
    if [ $leap_year -eq 1 ]; then
        max_day=29
    else
        max_day=28
    fi
fi

# 날짜 유효성 확인
if (( input_day < 1 || input_day > max_day )); then
    echo "$month $input_day $input_year는 유효하지 않습니다."
    exit 1
fi

# 유효한 날짜 출력
echo "$month $input_day $input_year"
