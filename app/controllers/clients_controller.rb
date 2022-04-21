class ClientsController < ApplicationController

    def index
        @clients = Client.all

        render(
            json: {clients: @clients},
            status: 200            
        )
    end

    def show
        @client = Client.find_by(id: params[:id])

        if !@client.nil?
            render(
                json: { client: @client},
                status: 200
            )
        else
            render(
                json: {message: "El cliente solicitado no existe"}
                status: 404
            )
        end
    end

    def create
        @client = Client.new(client_params)

        if(@client.save)
            render(
                json: { client: @client},
                status: 201
            )
        else
            render(
                json: {error: @client.errors.details},
                status: 400                
            )
        end
    end

    def update
        @client = Client.find(params[:id])

        if !@client.nil?   
            if @client.update(client_params)
                render(
                    json: {client: @client},
                    status: 200
                )
            else
                render(
                    json: {error: @client.errors.details},
                    status: 400
                )
            end
        else
            render(
                json: {message: "El cliente solicitado no existe"}
                status: 404
            )
        end
    end

    def destroy
        @client = Client.find(params[:id])

        if !@client.nil?   
            if @client.destroy 
                render(
                    json: {status: 204}
                    )
            else
                render(
                    status: 400,
                    json: {message: @client.errors.details}
                )
            end
        else
            render(
                json: {message: "El cliente solicitado no existe"}
                status: 404
            )
        end
    end

    #Sirve solo para restringir los parametros que enviamos en una request
    private
    def client_params
      params.require(:client).permit(:first_name, :last_name, :age)
    end
end
