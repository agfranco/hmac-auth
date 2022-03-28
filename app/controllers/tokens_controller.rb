class TokensController < ApplicationController
  def new; end

  def create
    respond_to do |format|
      format.turbo_stream do
        @token = calculate_token

        render turbo_stream: turbo_stream.replace(
          :result,
          partial: 'tokens/create'
        )
      end
    end
  end

  private

  def calculate_token
    Base64.strict_encode64(
      OpenSSL::HMAC.digest 'sha256', params[:key], params[:body]
    )
  end
end
