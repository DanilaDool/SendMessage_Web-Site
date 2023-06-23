require 'rubygems'
require 'sinatra'
require 'pony'

get '/main' do
  erb :main
end

get '/success' do
  erb 'Вы успешно отправили почту!'
end

get '/failed' do
  erb 'Увы, но отправить сообщение не удалось :('
end

get '/' do
  "Фисташковое мороженное самое вкусное! :)"
end

post '/main' do
  begin
  Pony.mail({
      :subject => params[:subject],
      :body => params[:what_to_write],
      :to => params[:whom_to_send],
      :from => params[:Your_mail],
      :via => :smtp,
      :via_options => {
        :address => 'smtp.mail.ru',
        :port => '465',
        :tls => true,
        :user_name => params[:Your_mail],
        :password => params[:password],
        :authentication => :plain
      }
   })
  rescue
    redirect '/failed'
  else
    redirect '/success'
  end
end
