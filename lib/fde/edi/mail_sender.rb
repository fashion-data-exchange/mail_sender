require 'fde/edi/mail_sender/version'
require 'fde/edi/mail'
require 'mail'

module FDE
  module Edi
    module MailSender

      class Config
        attr_accessor :address,
          :port,
          :domain,
          :user_name,
          :password,
          :authentication,
          :enable_starttls_auto,
          :from

        def attributes
          {
            address: @address,
            port: @port,
            domain: @domain,
            user_name: @user_name,
            password: @password,
            authentication: @authentication,
            enable_starttls_auto: @enable_starttls_auto
          }
        end
      end

      def self.config
        @@config ||= Config.new
      end

      def self.smtp_account
        @@smtp ||= ::Mail.defaults do
          delivery_method :smtp, FDE::Edi::MailSender.config.attributes
        end
      end

      def self.configure
        yield self.config
      end
    end
  end
end
