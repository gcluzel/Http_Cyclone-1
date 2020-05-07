with Common_Type;  use Common_Type;
with Interfaces.C; use Interfaces.C;
with Net_Mem;      use Net_Mem;

package Tcp_Type is

   TCP_MAX_SYN_QUEUE_SIZE     : constant unsigned := 16;
   TCP_DEFAULT_SYN_QUEUE_SIZE : constant unsigned := 4;

   TCP_MAX_RX_BUFFER_SIZE : constant unsigned_long := 22_880;
   TCP_MAX_TX_BUFFER_SIZE : constant unsigned_long := 22_880;

   type Tcp_State is
     (TCP_STATE_CLOSED,
      TCP_STATE_LISTEN,
      TCP_STATE_SYN_SENT,
      TCP_STATE_SYN_RECEIVED,
      TCP_STATE_ESTABLISHED,
      TCP_STATE_CLOSE_WAIT,
      TCP_STATE_LAST_ACK,
      TCP_STATE_FIN_WAIT_1,
      TCP_STATE_FIN_WAIT_2,
      TCP_STATE_CLOSING,
      TCP_STATE_TIME_WAIT);

   type TCP_Congest_State is
     (TCP_CONGEST_STATE_IDLE,
      TCP_CONGEST_STATE_RECOVERY,
      TCP_CONGEST_STATE_LOSS_RECOVERY);

   subtype Tcp_Flags is uint8;

   TCP_FLAG_FIN : constant Tcp_Flags := 1;
   TCP_FLAG_SYN : constant Tcp_Flags := 2;
   TCP_FLAG_RST : constant Tcp_Flags := 4;
   TCP_FLAG_PSH : constant Tcp_Flags := 8;
   TCP_FLAG_ACK : constant Tcp_Flags := 16;
   TCP_FLAG_URG : constant Tcp_Flags := 32;

      -- TODO: use preprocessing instead of 14 to be coherent with the C code.
   type Chunk_Desc_Array is array (0 .. 14) of Chunk_Desc;

   type Tx_Buffer_Size is range 1 .. TCP_MAX_TX_BUFFER_SIZE;
   type Rx_Buffer_Size is range 1 .. TCP_MAX_RX_BUFFER_SIZE;

   type Tcp_Tx_Buffer is record
      chunkCount    : unsigned;
      maxChunkCound : unsigned;
      chunk         : Chunk_Desc_Array;
   end record
   with
      Convention => C;

   type Tcp_Rx_Buffer is record
      chunkCount    : unsigned;
      maxChunkCound : unsigned;
      chunk         : Chunk_Desc_Array;
   end record
   with
      Convention => C;

   type Tcp_Timer is record
      running   : Bool;
      startTime : Systime;
      interval  : Systime;
   end record
   with
      Convention => C;

   type TcpQueueItem is record
      length : unsigned;
   end record
   with
      Convention => C;

   type Tcp_Sack_Block is record
      leftEdge  : unsigned_long;
      rightEdge : unsigned_long;
   end record
   with
      Convention => C;

   type SackBlockArray is array (0 .. 3) of Tcp_Sack_Block;

end Tcp_Type;
