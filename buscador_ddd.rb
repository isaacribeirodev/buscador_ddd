require 'faraday'       # importa a gem faraday para fazer requisições HTTP
require 'json'          # importa o módulo json para que possamos usar a classe JSON e suas funções

puts 'Digite um DDD:'   # apresenta uma mensagem no terminal de comandos
ddd = gets.chomp        # lê uma string do terminal de comandos

# envia uma requisição HTTP com o verbo GET para o endereço https://brasilapi.com.br/api/ddd/v1/#{ddd}
# #{ddd} será substituído pelo valor da variável ddd
resposta = Faraday.get("https://brasilapi.com.br/api/ddd/v1/#{ddd}")

# parse é uma função da classe JSON que transforma uma string (resposta.body) para um hash
# isso facilita acessar as propriedades do corpo da resposta HTTP usando corpo['nome_da_propriedade']
corpo = JSON.parse(resposta.body)

# apresenta no terminal o status da resposta HTTP
puts "Status da resposta: #{resposta.status}"

# avalia o valor contido em resposta.status
case resposta.status

# quando resposta.status for 200, então apresente os dados do DDD
when 200
    # apresenta na tela o estado do DDD
    puts "Estado: #{corpo['state']}"
    # apresenta na tela as cidades do DDD
    puts "Cidades: #{corpo['cities']}"

# quando a resposta.status for 404, então o DDD é inválido
when 404
    puts "DDD não encontrado. Digite um número com 2 dígitos."

# quando resposta.status estiver entre 500 e 599, isso indica que houve um erro de servidor na API
when 500..599
    puts "Erro na API. Tente novamente mais tarde."

end
