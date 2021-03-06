module Artoo
  module Adaptors
    # The Adaptor class is the base class used to  
    # connect to a specific group of hardware devices. Examples 
    # would be an Arduino, a Sphero, or an ARDrone.
    #
    # Derive a class from this class, in order to implement communication
    # with a new type of hardware device.
    class Adaptor
      include Celluloid::IO

      attr_reader :parent, :port

      def initialize(params={})
        @parent = params[:parent]
        @port = params[:port]
        @connected = false
      end

      def connect
        @connected = true
      end

      def disconnect
        @connected = false
        true
      end

      def reconnect
        connect unless connected?
      end

      def connected?
        @connected == true
      end

      def connect_to
        if port.is_tcp?
          connect_to_tcp
        else
          port.port
        end
      end

      def connect_to_tcp
        @socket ||= TCPSocket.new(port.host, port.port)
      end

      def connect_to_udp
        @udp_socket ||= UDPSocket.new
      end
    end
  end
end