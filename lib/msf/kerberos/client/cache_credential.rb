# -*- coding: binary -*-
require 'rex/proto/kerberos'

module Msf
  module Kerberos
    module Client
      module CacheCredential

        # Builds a MIT Credential Cache
        #
        # @param opts [Hash{Symbol => <Fixnum, Array<String>, Rex::Proto::Kerberos::CredentialCache::Principal, Array<Rex::Proto::Kerberos::CredentialCache::Credential>>}]
        # @option opts [Fixnum] :version
        # @option opts [Array<String>] :headers
        # @option opts [Rex::Proto::Kerberos::CredentialCache::Principal] :primary_principal
        # @option opts [Array<Rex::Proto::Kerberos::CredentialCache::Credential>] :credentials
        # @return [Rex::Proto::Kerberos::CredentialCache::Cache]
        # @see Rex::Proto::Kerberos::CredentialCache::Cache
        def create_cache(opts = {})
          version = opts[:version] || Rex::Proto::Kerberos::CredentialCache::VERSION
          headers = opts[:headers] || [Rex::Proto::Kerberos::CredentialCache::HEADER]
          primary_principal = opts[:primary_principal] || create_cache_principal(opts)
          credentials = opts[:credentials] || [create_cache_credential(opts)]

          cache = Rex::Proto::Kerberos::CredentialCache::Cache.new(
            version: version,
            headers: headers,
            primary_principal: primary_principal,
            credentials: credentials
          )

          cache
        end

        # Builds a MIT Credential Cache principal
        #
        # @param opts [Hash<{Symbol => <Fixnum, String, Array<String>>}>]
        # @option opts [Fixnum] :name_type
        # @option opts [String] :realm
        # @option opts [Array<String>] :components
        # @return [Rex::Proto::Kerberos::CredentialCache::Principal]
        # @see Rex::Proto::Kerberos::CredentialCache::Principal
        def create_cache_principal(opts = {})
          name_type = opts[:name_type] || 0
          realm = opts[:realm] || ''
          components = opts[:components] || ['']

          principal = Rex::Proto::Kerberos::CredentialCache::Principal.new(
            name_type: name_type,
            realm: realm,
            components:components
          )

          principal
        end

        # Builds a MIT Credential Cache key block
        #
        # @param opts [Hash<{Symbol => <Fixnum, String>}>]
        # @option opts [Fixnum] :key_type
        # @option opts [Fixnum] :e_type
        # @option opts [String] :key_value
        # @return [Rex::Proto::Kerberos::CredentialCache::KeyBlock]
        # @see Rex::Proto::Kerberos::CredentialCache::KeyBlock
        def create_cache_key_block(opts = {})
          key_type = opts[:key_type] || Rex::Proto::Kerberos::Crypto::RC4_HMAC
          e_type = opts[:e_type] || 0
          key_value = opts[:key_value] || ''

          key_block = Rex::Proto::Kerberos::CredentialCache::KeyBlock.new(
            key_type: key_type,
            e_type: e_type,
            key_value: key_value
          )

          key_block
        end

        # Builds a times structure linked to a credential in a MIT Credential Cache
        #
        # @param opts [Hash<{Symbol => Fixnum}>]
        # @option opts [Fixnum] auth_time
        # @option opts [Fixnum] start_time
        # @option opts [Fixnum] end_time
        # @option opts [Fixnum] renew_till
        # @return [Rex::Proto::Kerberos::CredentialCache::Time]
        # @see Rex::Proto::Kerberos::CredentialCache::Time
        def create_cache_times(opts = {})
          auth_time = opts[:auth_time] || 0
          start_time = opts[:start_time] || 0
          end_time = opts[:end_time] || 0
          renew_till = opts[:renew_till] || 0

          time = Rex::Proto::Kerberos::CredentialCache::Time.new(
            auth_time: auth_time.to_i,
            start_time: start_time.to_i,
            end_time: end_time.to_i,
            renew_till: renew_till.to_i
          )

          time
        end

        # Builds a MIT Credential Cache credential
        #
        # @param opts [Hash<{Symbol => <>}>]
        # @option opts [Rex::Proto::Kerberos::CredentialCache::Principal] client
        # @option opts [Rex::Proto::Kerberos::CredentialCache::Principal] server
        # @option opts [Rex::Proto::Kerberos::CredentialCache::KeyBlock] key
        # @option opts [Rex::Proto::Kerberos::CredentialCache::Time] time
        # @option opts [Fixnum] is_key
        # @option opts [Fixnum] flags
        # @option opts [Array] addrs
        # @option opts [Array] auth_data
        # @option opts [String] ticket
        # @option opts [String] second_ticket
        # @return [Rex::Proto::Kerberos::CredentialCache::Credential]
        # @see Rex::Proto::Kerberos::CredentialCache::Credential
        def create_cache_credential(opts = {})
          client = opts[:client] || create_cache_principal(opts)
          server = opts[:server] || create_cache_principal(opts)
          key = opts[:key] || create_cache_key_block(opts)
          time = opts[:time] || create_cache_times(opts)
          is_skey = opts[:is_skey] || 0
          tkt_flags = opts[:flags] || 0
          addrs = opts[:addrs] || []
          auth_data = opts[:auth_data] || []
          ticket = opts[:ticket] || ''
          second_ticket = opts[:second_ticket] || ''

          cred = Rex::Proto::Kerberos::CredentialCache::Credential.new(
            client: client,
            server: server,
            key: key,
            time: time,
            is_skey: is_skey,
            tkt_flags:tkt_flags,
            addrs: addrs,
            auth_data: auth_data,
            ticket: ticket,
            second_ticket: second_ticket
          )

          cred
        end
      end
    end
  end
end