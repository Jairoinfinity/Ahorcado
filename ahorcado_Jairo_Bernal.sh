#!/bin/bash
clear

#Variables globales
puntos=0 #Puntos que optendra el jugador mientras juega
fallos=0 #Fallos que va cometiendo el jugador. Un maximo de 6
acierto=0 #Si acierto es igual a la longitud de la palabra el jugador acerto la palabra completa
ac=0 #Si ac es igual a 1 es que acerto una letra de la palabra
nd=1 #El numero del dibujo a mostrar del ahorcado
lu="" #Aqui se almacenaran las letras usadas del jugador
letra="" #Letra que introduce el usuario
pa=() #Array donde se almacenara la palabra
aux=() #Array auxiliar para ir almacenando y comprobando lo que introduce el usuario
vu=0 #si vu es 0 es la primera vuelta si es 1 yo no rellenara mas de lineas en las siguientes pasadas en el array aux


#Mostramos el menu
cat doc/Menu.txt

#Almacenamos la opcin elegida en la variable op
read op

case $op in
    1)
        clear

        #Escogemos aleatoriamente la categoria y la palabra
        ncg=$[RANDOM%10+1] #Categoria
        npg=$[RANDOM%10+3] #Palabra

        #Almacenamos la categoria y la palabra en las siguentes variables
        categoria=$(grep -w $ncg doc/Palabras.txt | cut -d "," -f2)
        palabra=$(grep -w $ncg doc/Palabras.txt | cut -d "," -f$npg)

        #Contamos la cantidad de letras de tiene la palabra
        nlc=$(echo -n "$palabra" | wc -c)

        #Metemos la palabra en el array
        for ((i=0; $i<$nlc; i++)) do
            pa[$i]="${palabra:i:1}"
        done

        #Iniciamos la partida
        while [ $fallos -lt 6 ] 
        do
        
        
        #Rellenamos el array aux con lineas, pero solo si el la promera vez que se ejecuta el juego
        if [ $vu -eq 0 ]; then
            for ((i=0; $i<$nlc; i++)) do
                aux[$i]="_"
            done
            vu=1

            #Mostramos por pantalla como queda la palabra
            for ((i=0; $i<$nlc; i++)) do
                echo -n "${aux[i]} "
            done

        else
            #Mostramos un banner de la opcion elegida
            cat doc/menuop1.txt

            #Mostramos el dibujo del ahorcado
            cat doc/cor$nd.txt
            echo ""

            #Mostramos por pantalla la pista al usuario
            echo "La categoria es $categoria y la palabra tiene $nlc letras"

            #Mostramos por pantalla como queda la palabra
            echo ""
            for ((i=0; $i<$nlc; i++)) do
                echo -n "${aux[i]} "
            done

            #Mostramos las letras usadas por el jugador en la partida
            echo ""
            echo ""
            echo ""
            echo "Has usado las letras: $lu"
            echo ""
            echo ""

            #Pedimos al usuario que introduxca una letra
            
            echo "Introduce una letra"
            read -t 20 letra

            
            
            if [ "$letra" == "a" ] || [ "$letra" == "b" ] || [ "$letra" == "c" ] || [ "$letra" == "d" ] || [ "$letra" == "e" ] || [ "$letra" == "f" ] || [ "$letra" == "g" ] || [ "$letra" == "h" ] || [ "$letra" == "i" ] || [ "$letra" == "j" ] || [ "$letra" == "k" ] || [ "$letra" == "l" ] || [ "$letra" == "m" ] || [ "$letra" == "n" ] || [ "$letra" == "ñ" ] || [ "$letra" == "o" ] || [ "$letra" == "p" ] || [ "$letra" == "q" ] || [ "$letra" == "r" ] || [ "$letra" == "s" ] || [ "$letra" == "t" ] || [ "$letra" == "u" ] || [ "$letra" == "v" ] || [ "$letra" == "w" ] || [ "$letra" == "x" ] || [ "$letra" == "y" ] || [ "$letra" == "z" ] || [ "$letra" == "" ]; then
                lu="$lu""$letra "
                #Comprabamos la letra instroducida por el usuario y la añadimos si acierta.
                for ((i=0; $i<$nlc; i++)) do
                    if [ "$letra" == "${palabra:i:1}" ]; then
                        aux[$i]="$letra"
                        acierto=$[acierto+1]
                        ac=1
                        puntos=$[puntos+150]
                    fi
                done

                #Comprobamos si ha acertado o ha fallado
                if [ $acierto -eq $nlc ]; then
                    clear
                    cat doc/win.txt
                    echo ""
                    echo "Felicidades, has acertado la palabra $palabra!!!"
                    echo ""
                    echo "Introduce tu nombre"
                    read nombre
                    echo "$nombre,$puntos" >> doc/ranking.txt
                    echo ""
                    echo "Pulsa enter para volver al menu"
                    read ppp
                    bash ahorcado_Jairo_Bernal.sh
                    fallos=6
                else
                    if [ $ac -eq 0 ]; then
                        fallos=$[fallos+1]
                        nd=$[nd+1]
                        puntos=$[puntos-15]
                    fi

                    ac=0

                    if [ $fallos -eq 6 ]; then
                        clear
                        cat doc/cor7.txt
                        echo ""
                        echo "Lo siento, pero has perdido. La palabra era $palabra"
                        echo ""
                        echo "Pulsa enter para volver al menu"
                        read ppp
                        bash ahorcado_Jairo_Bernal.sh
                    fi
                fi
                clear
            else
                clear
                echo "Introduce una letra valida"
                echo ""
            fi
        fi
        done
        ;;

    2)
        clear
        #Preguntamos al jugador 1 cual es la palabra y la pista
        echo "Introduce la palabra a adivinar en minusculas"
        read palabra
        echo ""
        echo "Introduce una palabra o frase que de una pista"
        read categoria
        clear
        #Contamos la cantidad de letras de tiene la palabra
        nlc=$(echo -n "$palabra" | wc -c)

        #Metemos la palabra en el array
        for ((i=0; $i<$nlc; i++)) do
            pa[$i]="${palabra:i:1}"
        done

        #Iniciamos la partida
        while [ $fallos -lt 6 ] 
        do
       
        
        #Rellenamos el array aux con lineas, pero solo si el la promera vez que se ejecuta el juego
        if [ $vu -eq 0 ]; then
            for ((i=0; $i<$nlc; i++)) do
                aux[$i]="_"
            done
            vu=1

            #Mostramos por pantalla como queda la palabra
            for ((i=0; $i<$nlc; i++)) do
                echo -n "${aux[i]} "
            done

        else
            #Mostramos un banner de la opcion elegida
            cat doc/menuop1.txt

            #Mostramos el dibujo del ahorcado
            cat doc/cor$nd.txt
            echo ""

            #Mostramos por pantalla la pista al usuario
            echo "La pista es: $categoria  --la palabra tiene $nlc letras"

            #Mostramos por pantalla como queda la palabra
            echo ""
            for ((i=0; $i<$nlc; i++)) do
                echo -n "${aux[i]} "
            done

            #Mostramos las letras usadas por el jugador en la partida
            echo ""
            echo ""
            echo ""
            echo "Has usado las letras: $lu"
            echo ""
            echo ""

            #Pedimos al usuario que introduxca una letra
            
            echo "Introduce una letra"
            read -t 20 letra
            if [ "$letra" == "a" ] || [ "$letra" == "b" ] || [ "$letra" == "c" ] || [ "$letra" == "d" ] || [ "$letra" == "e" ] || [ "$letra" == "f" ] || [ "$letra" == "g" ] || [ "$letra" == "h" ] || [ "$letra" == "i" ] || [ "$letra" == "j" ] || [ "$letra" == "k" ] || [ "$letra" == "l" ] || [ "$letra" == "m" ] || [ "$letra" == "n" ] || [ "$letra" == "ñ" ] || [ "$letra" == "o" ] || [ "$letra" == "p" ] || [ "$letra" == "q" ] || [ "$letra" == "r" ] || [ "$letra" == "s" ] || [ "$letra" == "t" ] || [ "$letra" == "u" ] || [ "$letra" == "v" ] || [ "$letra" == "w" ] || [ "$letra" == "x" ] || [ "$letra" == "y" ] || [ "$letra" == "z" ] || [ "$letra" == "" ]; then
                lu="$lu""$letra "
                #Comprabamos la letra instroducida por el usuario y la añadimos si acierta.
                for ((i=0; $i<$nlc; i++)) do
                    if [ "$letra" == "${palabra:i:1}" ]; then
                        aux[$i]="$letra"
                        acierto=$[acierto+1]
                        ac=1
                        puntos=$[puntos+150]
                    fi
                done

                #Comprobamos si ha acertado o ha fallado
                if [ $acierto -eq $nlc ]; then
                    clear
                    cat doc/win.txt
                    echo ""
                    echo "Felicidades, has acertado la palabra $palabra!!!"
                    echo ""
                    echo "Introduce tu nombre"
                    read nombre
                    echo "$nombre,$puntos" >> doc/ranking.txt
                    echo ""
                    echo "Pulsa enter para volver al menu"
                    read ppp
                    bash ahorcado_Jairo_Bernal.sh
                    fallos=6
                else
                    if [ $ac -eq 0 ]; then
                        fallos=$[fallos+1]
                        nd=$[nd+1]
                        puntos=$[puntos-15]
                    fi

                    ac=0

                    if [ $fallos -eq 6 ]; then
                        clear
                        cat doc/cor7.txt
                        echo ""
                        echo "Lo siento, pero has perdido. La palabra era $palabra"
                        echo ""
                        echo "Pulsa enter para volver al menu"
                        read ppp
                        bash ahorcado_Jairo_Bernal.sh
                    fi
                fi
                clear
            else
                clear
                echo "Introduce una letra valida"
                echo ""
            fi
        fi
        done
        ;;

    3)
        clear
        var=()
        con=0
        cat doc/top.txt

        #Cogemos todas las puntuaciones
        for i in $(cat doc/ranking.txt | sort -n -r -k2 -t",")
        do
            var[con]=$i
            con=$[con+1]            
        done
        
        #Mostramos el top 5 de los que mas puntuaciones tienen
        for ((i=0; $i<5; i++))
        do
            echo "${var[i]}"
        done

        #Volvemos al menu
        echo ""
        echo "Pulsa enter para volver al menu"
        read ppp
        bash ahorcado_Jairo_Bernal.sh
        ;;

    4)
        echo "Adios!!!"
        ;;
esac
