class API::V2::SirenController < ApplicationController
  include PayloadSerializer

  def show
    result_siege = Etablissement.where(siren: siren_params[:siren], is_siege: '1')
    result_sirets = Etablissement.select('siret').where(siren: siren_params[:siren], is_siege: '0').pluck(:siret)

    payload = SirenPayload.new(siren_params[:siren], result_siege, result_sirets)

    render json: payload.body, status: payload.status
  end

  private

  def siren_params
    params.permit(:siren)
  end
end
