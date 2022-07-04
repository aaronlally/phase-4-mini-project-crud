class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # wrap_parameters format: []
    # GET /spices
    def index
        spices = Spice.all
        render json: spices
    end

    # POST /spices
    def create
        spice = Spice.create!(spice_params)
        render json: spice, status: :created
    end

    # GET /spices/:id
    def show
        spice = find_spice
        render json: spice
    end

    # PATCH /spices/:id
    def update
        spice = find_spice
        spice.update!(spice_params)
        render json: spice
    end

    # DELETE /spices/:id
    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found_response
        render json: {  error: "Spice not found"}, status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

end
