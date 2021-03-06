class ChartsController < ApplicationController
    before_action :set_chart, only: %i[ show edit update]
    def show
    end

    def edit
        if current_user == @chart.arrangement.owner
            render 'charts/edit'
        else
            redirect_to current_user, alert: "You can only edit charts you created" 
        end
    end

    def update
        if current_user == @chart.arrangement.owner
            @chart.update(chart_params)
            if @chart.save
                redirect_to @chart
            else
                render 'charts/edit'
            end 
        else
            redirect_to current_user, alert: "You can only edit charts you created" 
        end
    end

    private 
        def set_chart
            @chart = Chart.find(params[:id])
        end

        def chart_params
            params.require(:chart).permit(:instrument, :chart_pdf)
        end
end