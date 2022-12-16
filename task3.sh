#!/bin/bash

build_bord(){
    HORIZONTAL_LINE="-----------------"
    S="%s\n|%3s|%3s|%3s|%3s|\n"
    printf $S $HORIZONTAL_LINE ${M[0]:-"."} ${M[1]:-"."} ${M[2]:-"."} ${M[3]:-"."}
    printf $S $HORIZONTAL_LINE ${M[4]:-"."} ${M[5]:-"."} ${M[6]:-"."} ${M[7]:-"."}
    printf $S $HORIZONTAL_LINE ${M[8]:-"."} ${M[9]:-"."} ${M[10]:-"."} ${M[11]:-"."}
    printf $S $HORIZONTAL_LINE ${M[12]:-"."} ${M[13]:-"."} ${M[14]:-"."} ${M[15]:-"."}
    echo $HORIZONTAL_LINE
}

init_game(){
    RANDOM=$RANDOM
    EMPTY=
    M=()
    
    for i in {1..15}
    do
        j=$(( RANDOM % 16 ))
        while [[ ${M[j]} != "" ]]
        do
            j=$(( RANDOM % 16 ))
        done
        M[j]=$i
    done
    for i in {0..15}
    do
        [[ ${M[i]} == "" ]] && EMPTY=$i
    done
    build_bord
}

quit_game(){
   exit
}

exchange(){
    M[$EMPTY]=${M[$1]}
    M[$1]=""
    EMPTY=$1
}

check_win(){
    for i in {0..14}
    do
        if [ "${M[i]}" != "$(( $i + 1 ))" ]
        then
            return
        fi
    done
    echo "Вы выиграли."
}

start_game(){
    while :
    do
        echo "Ваш ход (q - выход). Используйте WASD для перемещения пустой ячейки"
        read -n 1 -s
        case $REPLY in
            w)
                [ $EMPTY -lt 12 ] && exchange $(( $EMPTY + 4 ))
            ;;
            a)
                COL=$(( $EMPTY % 4 ))
                [ $COL -lt 3 ] && exchange $(( $EMPTY + 1 ))
            ;;
            s)
                [ $EMPTY -gt 3 ] && exchange $(( $EMPTY - 4 ))
            ;;
            d)
                COL=$(( $EMPTY % 4 ))
                [ $COL -gt 0 ] && exchange $(( $EMPTY - 1 ))
            ;;
            q)
                quit_game
            ;;
        esac
        build_bord
        check_win
    done
}

init_game
start_game
