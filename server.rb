require 'roda'
require 'securerandom'

class PortierDemo < Roda
	use Rack::Session::Cookie, secret: SecureRandom.hex(64), key: "_myapp_session"
	plugin :portier

	route do |r|
		r.get '' do
			if authorized?
				"Welcome, #{authorized_email}"
			else
				render_login_form
			end
		end
		
		r.get 'secure' do
			authorize!         # require a user be logged in

			authorized_email   # email authenticated by portier
		end

		r.get 'logout' do
			logout!

			redirect '/'
		end
	end
	
end
