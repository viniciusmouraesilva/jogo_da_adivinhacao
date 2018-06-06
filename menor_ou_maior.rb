def da_boas_vindas
	puts
	puts "        100           >>Bem vindo ao jogo<<           ?          "
	puts "      ?                   da adivinhaçao         15              "
	puts "                 10                             menor            "
	puts "  200                                                     ?      "
	puts "          maior           ?                                      "
	puts
	
	puts "Qual é o seu nome?"
	nome = gets.strip
	puts "\n\n\n"
	puts "Vamos preparar o jogo para você #{nome}"
	nome
end

def pede_dificuldade 
	puts "\n"
	puts "(1) Fácil (2) Médio (3) Meio Difícil (4) Dificíl (Qualquer outra tecla) Super-Hard"
	puts "Qual o nivél de dificuldade se deseja jogar: "
	dificuldade = gets.to_i
end

def sortea_numero_secreto dificuldade

	#if dificuldade == 1
	#	maximo = 30
	#elsif dificuldade == 2
	#	maximo = 60
	#elsif dificuldade == 3
	#	maximo = 100
	#elsif dificuldade == 4
	#	maximo = 150
	#else
	#	maximo = 200
	#end

	case dificuldade
	when 1
		maximo = 30
	when 2
		maximo = 60
	when 3
		maximo = 100
	when 4
		maximo = 150
	else
		maximo = 200
	end

	puts "Escolhendo um número secreto entre 1 e #{maximo}..."
	puts "Escolhido... que tal adivinhar hoje nosso número secreto?"
	sorteado = rand(maximo) + 1
	puts "\n\n\n"
	sorteado
end

def pede_numero_jogador chutes, tentativa, numero_tentativas
	puts "\n\n\n"
	puts "Tentativa #{tentativa} de #{numero_tentativas}"
	puts "chutes até agora #{chutes}"
	puts "\n"
	puts "Me diga um número: "
	chute = gets.strip.to_i
	
	loop do 
		for chute_guardado in chutes
			if chute == chute_guardado
				puts "Esse número já foi usado. Digite outro"
				chute = gets.strip.to_i
				usado = numero_ja_usado chutes, chute
			end
		end
		break if !usado
	end

	puts "Será que você acertou? Você chutou #{chute}"
	chute
end

def numero_ja_usado chutes, chute
	for chute_guardado in chutes
		if chute_guardado == chute
			return numero_usuado = true
		end
	end
	false
end

def verifica_se_acertou numero_secreto, chute
	acertou = numero_secreto == chute

	if acertou
		ganhou
		puts "Acertou em cheio meu camarada."
		return true
	end
	maior = numero_secreto > chute 
	puts "Errouuuuuu!"
	if maior
		puts "O número é maior!"
	else 
		puts "O número é menor!"
	end
	false
	puts "\n\n\n"
end

def nao_quero_jogar
	puts "Deseja jogar novamente? (S/N)"
	quero_jogar = gets.strip
	nao_quero_jogar = quero_jogar.upcase == "N"
end

def ganhou 
	puts
	puts "         0000000000000000000000      "
	puts "       0000000000000000000000000     "
	puts "     00000   0000000000000   000"
	puts "    000000       0000000     0000"
	puts "   0000000        00000      000000"
	puts "  00000000   #    00000   #  0000000"
	puts " 000000000        00000      00000000"
	puts "0000000000        00000      000000000"
	puts "00000000000000000000000000000000000000"
	puts "00000000000000000000000000000000000000"
	puts "0000  00000000000000000000000  00000"
	puts " 0000  000000000000000000000  00000"
	puts "  00000 0000000000000000000  00000"
	puts "   0000  000000000000000    00000"
	puts "    000000 00000000000000  000000"
	puts "     000000               000000"                
	puts "          0000000000000000"
	puts
end

def perdeu_por_um numero_secreto, chute
	perdi_por_um = (chute - numero_secreto).abs 
	
	if perdi_por_um == 1
		puts "Você quase perdeu por uma. Ganhou uma nova chance."
		return true
	end
	false
end

def calcular_porcentagem_sobre_vitorias total_de_vitorias, total_de_derrotas
	if total_de_vitorias > 0
		partidas = total_de_vitorias + total_de_derrotas
		vitorias_em_porcentagem = (total_de_vitorias * 100) / partidas
		return vitorias_em_porcentagem
	end
	return 0
end

def perdeu
	puts
	puts "                              "
	puts "   \|/  ____  \|/             "
	puts "    @~ / .. \ ~@              "
	puts "   /__( \__/ )__\             "
	puts "       \__U_/                 "
	puts "                              "
	puts "Você perdeu! Tente novamente! "
	puts 
end

#while quero_jogar
#	joga nome, dificuldade
#end

def joga nome, dificuldade
	numero_secreto = sortea_numero_secreto dificuldade
	pontos_ate_agora = 1000
	limite_tentativas = 5
	chutes = []
	tentativa = 1

	for tentativa in 1..limite_tentativas
		
		chute = pede_numero_jogador chutes, tentativa,
			limite_tentativas

		chutes << chute	
	
		if nome == "Vinicius"
			puts "Acertou em cheio meu camarada."
			break
		end

		pontos_a_perder = (chute - numero_secreto).abs / 2.0
		pontos_ate_agora -= pontos_a_perder

		vitoria = verifica_se_acertou numero_secreto, chute

		break if vitoria

		if tentativa == 5
			if perdeu_por_um numero_secreto, chute
				tentativa += 1
				limite_tentativas += 1
				chute = pede_numero_jogador chutes, tentativa, limite_tentativas
				vitoria = verifica_se_acertou numero_secreto, chute
				break if vitoria
			end
		end
	end

	puts "Você ganhou #{pontos_ate_agora} pontos"
	vitoria
end

def start
	nome = da_boas_vindas
	dificuldade = pede_dificuldade
	total_de_vitorias = 0
	total_de_derrotas = 0

	loop do 
		vitoria = joga nome, dificuldade
	
		if vitoria
			total_de_vitorias += 1
		else
			perdeu
			total_de_derrotas += 1
		end

		porcentagem_das_vitorias = calcular_porcentagem_sobre_vitorias total_de_vitorias, total_de_derrotas

		puts "Total de vitórias: #{total_de_vitorias}"
		puts "Total de derrotas: #{total_de_derrotas}"
		puts "Suas vitórias em porcentagem é: #{porcentagem_das_vitorias}%"

		break if nao_quero_jogar
	end
end

start