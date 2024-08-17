Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0136C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8857088901;
	Sat, 17 Aug 2024 17:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="grfnCwPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD81B889C1; Sat, 17 Aug 2024 17:58:35 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A510886F9
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf705959f1so24050866d6.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910312; x=1724515112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z91sAztnN0yFXCR0RWW0ULvWFtPKYmuaTeaDVhiECg4=;
 b=grfnCwPxe+bEZGDWb5i3rWvxEi2xP95wfAnqk06f/n8dac1mB11EC4j+nszbLwUCrU
 L36CX4UNQQ5ZOhpcS6febytQlVQObCCillHLsJX/N12K/X65RiAoDUHInyWcPJCihms0
 7zwWqeAbij23tkb3FXvr1omzjuqxZ21k3++vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910312; x=1724515112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z91sAztnN0yFXCR0RWW0ULvWFtPKYmuaTeaDVhiECg4=;
 b=pza4DUdgr4j5LVXALaGvv09QoFvX15Lb78zae6exX2x1f5U0CWkirqEBHHgdXztYR7
 zGbP8tOh1MFH5fSz4pbP8DdBIhav93i1yeXnRpzVu/hgW42NJvcOcjbelZf9gCDA9Kzz
 IPDolHVqurGBInWE4w36JrIdAhG6LvCe7pCDL5UuqFOkiOp4kjZ4iaa1SyyteckhtnTK
 eK+G/A6it+Fvq+BF3/JgFNFiHPOD+5hY6qN764q7AsRJ52CVvZ6a8379MZy1vdDDfCD6
 03ANLzCnaUDdpjta+up0R7glDwPCG6NivI7hGif59L1vkEvI31qzUpbEGPKFWixN4BYC
 G8og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUukGmC36CnPGXLTtw1Dkvsrq4iLEcuqz0+jTjfOi72eNcaA6oHJNGAxE72eJb8NMNfGMCA0xPKWAix9JJrmPyFhaOdPQ==
X-Gm-Message-State: AOJu0YyNgZIFo1dthdU+i5SFnbawr6+duDhBl34mSlcTEb3B4cLjuyiF
 YCM97URznUWksYVgUFxD/2pDR/yqDvBxgD+NXXAixlz3rLHhx86PZTZ95gh83ycaUZ/KHZij7A6
 fJxps4ll0BYlO6832E4wgECUdNMugDCytYwEx
X-Google-Smtp-Source: AGHT+IH6D+l6AIvc4JSZyTgmJn4f9EueTk/oM/K31B+5GTASdzBv1ZeIffMnmVFNtrSs2iy9rP6gpXpNLOplh6zYbdU=
X-Received: by 2002:a05:6214:d45:b0:6bd:6a90:6472 with SMTP id
 6a1803df08f44-6bf6dd08cb5mr169284096d6.1.1723910311755; Sat, 17 Aug 2024
 08:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-5-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-5-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:21 -0600
Message-ID: <CAFLszTgNG6hWXMxbLv1pw=bzm6D7SskZKL9+=dbD100hyn-dPw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 4/9] net/tcp: add connection info to tcp_stream
 structure
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Mikhail,

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Changes:
>  * Avoid use net_server_ip in tcp code, use tcp_stream data instead
>  * Ignore packets from other connections if connection already created.
>    This prevents us from connection break caused by other tcp stream.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net.h      |   5 +-
>  include/net/tcp.h  |  57 +++++++++++++++++---
>  net/fastboot_tcp.c |  46 ++++++++--------
>  net/net.c          |  12 ++---
>  net/tcp.c          | 129 ++++++++++++++++++++++++++++++++++-----------
>  net/wget.c         |  52 +++++++-----------
>  6 files changed, 201 insertions(+), 100 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits below

>
> diff --git a/include/net.h b/include/net.h
> index bb2ae20f52a..b0ce13e0a9d 100644
> --- a/include/net.h
> +++ b/include/net.h
> @@ -667,6 +667,7 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>  /**
>   * net_send_tcp_packet() - Transmit TCP packet.
>   * @payload_len: length of payload
> + * @dhost: Destination host
>   * @dport: Destination TCP port
>   * @sport: Source TCP port
>   * @action: TCP action to be performed
> @@ -675,8 +676,8 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>   *
>   * Return: 0 on success, other value on failure
>   */
> -int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
> -                       u32 tcp_seq_num, u32 tcp_ack_num);
> +int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
> +                       int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
>  int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
>                         int sport, int payload_len);
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 14aee64cb1c..f224d0cae2f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -279,6 +279,9 @@ enum tcp_state {
>
>  /**
>   * struct tcp_stream - TCP data stream structure
> + * @rhost:             Remote host, network byte order
> + * @rport:             Remote port, host byte order
> + * @lport:             Local port, host byte order
>   *
>   * @state:             TCP connection state
>   *
> @@ -291,6 +294,10 @@ enum tcp_state {
>   * @lost:              Used for SACK
>   */
>  struct tcp_stream {
> +       struct in_addr  rhost;
> +       u16             rport;
> +       u16             lport;
> +
>         /* TCP connection state */
>         enum tcp_state  state;
>
> @@ -305,16 +312,53 @@ struct tcp_stream {
>         struct tcp_sack_v lost;
>  };
>
> -struct tcp_stream *tcp_stream_get(void);
> +void tcp_init(void);
> +
> +typedef int tcp_incoming_filter(struct in_addr rhost,
> +                               u16 rport, u16 sport);
> +
> +/*
> + * This function sets user callback used to accept/drop incoming
> + * connections. Callback should:
> + *  + Check TCP stream endpoint and make connection verdict
> + *    - return non-zero value to accept connection
> + *    - return zero to drop connection
> + *
> + * WARNING: If callback is NOT defined, all incoming connections
> + *          will be dropped.
> + */
> +void tcp_set_incoming_filter(tcp_incoming_filter *filter);
> +
> +/*
> + * tcp_stream_get -- Get or create TCP stream
> + * @is_new:    if non-zero and no stream found, then create a new one
> + * @rhost:     Remote host, network byte order
> + * @rport:     Remote port, host byte order
> + * @lport:     Local port, host byte order
> + *
> + * Returns: TCP stream structure or NULL (if not found/created)
> + */
> +struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
> +                                 u16 rport, u16 lport);
> +
> +/*
> + * tcp_stream_connect -- Create new TCP stream for remote connection.
> + * @rhost:     Remote host, network byte order
> + * @rport:     Remote port, host byte order
> + *
> + * Returns: TCP new stream structure or NULL (if not created).
> + *          Random local port will be used.
> + */
> +struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport);
> +
> +enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp);
>
> -enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp);
> -void tcp_set_tcp_state(struct tcp_stream *tcp, enum tcp_state new_state);
> -int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
> -                      int sport, int payload_len,
> +int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num);
>
>  /**
>   * rxhand_tcp() - An incoming packet handler.
> + * @tcp: TCP stream
>   * @pkt: pointer to the application packet
>   * @dport: destination TCP port
>   * @sip: source IP address
> @@ -324,8 +368,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>   * @action: TCP action (SYN, ACK, FIN, etc)
>   * @len: packet length
>   */
> -typedef void rxhand_tcp(uchar *pkt, u16 dport,
> -                       struct in_addr sip, u16 sport,
> +typedef void rxhand_tcp(struct tcp_stream *tcp, uchar *pkt,
>                         u32 tcp_seq_num, u32 tcp_ack_num,
>                         u8 action, unsigned int len);
>  void tcp_set_tcp_handler(rxhand_tcp *f);
> diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
> index d1fccbc7238..12a4d6690be 100644
> --- a/net/fastboot_tcp.c
> +++ b/net/fastboot_tcp.c
> @@ -8,14 +8,14 @@
>  #include <net/fastboot_tcp.h>
>  #include <net/tcp.h>
>
> +#define FASTBOOT_TCP_PORT      5554
> +
>  static char command[FASTBOOT_COMMAND_LEN] = {0};
>  static char response[FASTBOOT_RESPONSE_LEN] = {0};

It will be 0 anyway, since BSS is zeroed.

>
>  static const unsigned short handshake_length = 4;
>  static const uchar *handshake = "FB01";
>
> -static u16 curr_sport;
> -static u16 curr_dport;
>  static u32 curr_tcp_seq_num;
>  static u32 curr_tcp_ack_num;
>  static unsigned int curr_request_len;
> @@ -25,34 +25,37 @@ static enum fastboot_tcp_state {
>         FASTBOOT_DISCONNECTING
>  } state = FASTBOOT_CLOSED;
>
> -static void fastboot_tcp_answer(u8 action, unsigned int len)
> +static void fastboot_tcp_answer(struct tcp_stream *tcp, u8 action,
> +                               unsigned int len)
>  {
>         const u32 response_seq_num = curr_tcp_ack_num;
>         const u32 response_ack_num = curr_tcp_seq_num +
>                   (curr_request_len > 0 ? curr_request_len : 1);
>
> -       net_send_tcp_packet(len, htons(curr_sport), htons(curr_dport),
> +       net_send_tcp_packet(len, tcp->rhost, tcp->rport, tcp->lport,
>                             action, response_seq_num, response_ack_num);
>  }
>
> -static void fastboot_tcp_reset(void)
> +static void fastboot_tcp_reset(struct tcp_stream *tcp)
>  {
> -       fastboot_tcp_answer(TCP_RST, 0);
> +       fastboot_tcp_answer(tcp, TCP_RST, 0);
>         state = FASTBOOT_CLOSED;
>  }
>
> -static void fastboot_tcp_send_packet(u8 action, const uchar *data, unsigned int len)
> +static void fastboot_tcp_send_packet(struct tcp_stream *tcp, u8 action,
> +                                    const uchar *data, unsigned int len)
>  {
>         uchar *pkt = net_get_async_tx_pkt_buf();
>
>         memset(pkt, '\0', PKTSIZE);
>         pkt += net_eth_hdr_size() + IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
>         memcpy(pkt, data, len);
> -       fastboot_tcp_answer(action, len);
> +       fastboot_tcp_answer(tcp, action, len);
>         memset(pkt, '\0', PKTSIZE);
>  }
>
> -static void fastboot_tcp_send_message(const char *message, unsigned int len)
> +static void fastboot_tcp_send_message(struct tcp_stream *tcp,
> +                                     const char *message, unsigned int len)
>  {
>         __be64 len_be = __cpu_to_be64(len);
>         uchar *pkt = net_get_async_tx_pkt_buf();
> @@ -63,12 +66,11 @@ static void fastboot_tcp_send_message(const char *message, unsigned int len)
>         memcpy(pkt, &len_be, 8);
>         pkt += 8;
>         memcpy(pkt, message, len);
> -       fastboot_tcp_answer(TCP_ACK | TCP_PUSH, len + 8);
> +       fastboot_tcp_answer(tcp, TCP_ACK | TCP_PUSH, len + 8);
>         memset(pkt, '\0', PKTSIZE);
>  }
>
> -static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
> -                                     struct in_addr sip, u16 sport,
> +static void fastboot_tcp_handler_ipv4(struct tcp_stream *tcp, uchar *pkt,
>                                       u32 tcp_seq_num, u32 tcp_ack_num,
>                                       u8 action, unsigned int len)
>  {
> @@ -77,8 +79,6 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>         u8 tcp_fin = action & TCP_FIN;
>         u8 tcp_push = action & TCP_PUSH;
>
> -       curr_sport = sport;
> -       curr_dport = dport;
>         curr_tcp_seq_num = tcp_seq_num;
>         curr_tcp_ack_num = tcp_ack_num;
>         curr_request_len = len;
> @@ -89,17 +89,17 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>                         if (len != handshake_length ||
>                             strlen(pkt) != handshake_length ||
>                             memcmp(pkt, handshake, handshake_length) != 0) {
> -                               fastboot_tcp_reset();
> +                               fastboot_tcp_reset(tcp);
>                                 break;
>                         }
> -                       fastboot_tcp_send_packet(TCP_ACK | TCP_PUSH,
> +                       fastboot_tcp_send_packet(tcp, TCP_ACK | TCP_PUSH,
>                                                  handshake, handshake_length);
>                         state = FASTBOOT_CONNECTED;
>                 }
>                 break;
>         case FASTBOOT_CONNECTED:
>                 if (tcp_fin) {
> -                       fastboot_tcp_answer(TCP_FIN | TCP_ACK, 0);
> +                       fastboot_tcp_answer(tcp, TCP_FIN | TCP_ACK, 0);
>                         state = FASTBOOT_DISCONNECTING;
>                         break;
>                 }
> @@ -111,12 +111,12 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>
>                         // Only single packet messages are supported ATM
>                         if (strlen(pkt) != command_size) {
> -                               fastboot_tcp_reset();
> +                               fastboot_tcp_reset(tcp);
>                                 break;
>                         }
>                         strlcpy(command, pkt, len + 1);
>                         fastboot_command_id = fastboot_handle_command(command, response);
> -                       fastboot_tcp_send_message(response, strlen(response));
> +                       fastboot_tcp_send_message(tcp, response, strlen(response));
>                         fastboot_handle_boot(fastboot_command_id,
>                                              strncmp("OKAY", response, 4) == 0);
>                 }
> @@ -129,17 +129,21 @@ static void fastboot_tcp_handler_ipv4(uchar *pkt, u16 dport,
>
>         memset(command, 0, FASTBOOT_COMMAND_LEN);
>         memset(response, 0, FASTBOOT_RESPONSE_LEN);
> -       curr_sport = 0;
> -       curr_dport = 0;
>         curr_tcp_seq_num = 0;
>         curr_tcp_ack_num = 0;
>         curr_request_len = 0;
>  }
>
> +static int incoming_filter(struct in_addr rhost, u16 rport, u16 lport)
> +{
> +       return (lport == FASTBOOT_TCP_PORT);
> +}
> +
>  void fastboot_tcp_start_server(void)
>  {
>         printf("Using %s device\n", eth_get_name());
>         printf("Listening for fastboot command on tcp %pI4\n", &net_ip);
>
> +       tcp_set_incoming_filter(incoming_filter);
>         tcp_set_tcp_handler(fastboot_tcp_handler_ipv4);
>  }
> diff --git a/net/net.c b/net/net.c
> index 6c5ee7e0925..b33ea59a9fa 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -414,7 +414,7 @@ int net_init(void)
>                 /* Only need to setup buffer pointers once. */
>                 first_call = 0;
>                 if (IS_ENABLED(CONFIG_PROT_TCP))
> -                       tcp_set_tcp_state(tcp_stream_get(), TCP_CLOSED);
> +                       tcp_init();
>         }
>
>         return net_init_loop();
> @@ -899,10 +899,10 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>  }
>
>  #if defined(CONFIG_PROT_TCP)
> -int net_send_tcp_packet(int payload_len, int dport, int sport, u8 action,
> -                       u32 tcp_seq_num, u32 tcp_ack_num)
> +int net_send_tcp_packet(int payload_len, struct in_addr dhost, int dport,
> +                       int sport, u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>  {
> -       return net_send_ip_packet(net_server_ethaddr, net_server_ip, dport,
> +       return net_send_ip_packet(net_server_ethaddr, dhost, dport,
>                                   sport, payload_len, IPPROTO_TCP, action,
>                                   tcp_seq_num, tcp_ack_num);
>  }
> @@ -944,12 +944,12 @@ int net_send_ip_packet(uchar *ether, struct in_addr dest, int dport, int sport,
>                 break;
>  #if defined(CONFIG_PROT_TCP)
>         case IPPROTO_TCP:
> -               tcp = tcp_stream_get();
> +               tcp = tcp_stream_get(0, dest, dport, sport);
>                 if (tcp == NULL)
>                         return -EINVAL;
>
>                 pkt_hdr_size = eth_hdr_size
> -                       + tcp_set_tcp_header(tcp, pkt + eth_hdr_size, dport, sport,
> +                       + tcp_set_tcp_header(tcp, pkt + eth_hdr_size,
>                                              payload_len, action, tcp_seq_num,
>                                              tcp_ack_num);
>                 break;
> diff --git a/net/tcp.c b/net/tcp.c
> index 6646f171b83..9acf9f3ccb2 100644
> --- a/net/tcp.c
> +++ b/net/tcp.c
> @@ -26,6 +26,7 @@
>
>  static int tcp_activity_count;
>  static struct tcp_stream tcp_stream;
> +static tcp_incoming_filter *incoming_filter;
>
>  /*
>   * TCP lengths are stored as a rounded up number of 32 bit words.
> @@ -40,40 +41,95 @@ static struct tcp_stream tcp_stream;
>  /* Current TCP RX packet handler */
>  static rxhand_tcp *tcp_packet_handler;
>
> +#define RANDOM_PORT_START 1024
> +#define RANDOM_PORT_RANGE 0x4000
> +
> +/**
> + * random_port() - make port a little random (1024-17407)
> + *
> + * Return: random port number from 1024 to 17407

Where does 17407 number come from? I see that this is code you are
copying, though.

> + *
> + * This keeps the math somewhat trivial to compute, and seems to work with
> + * all supported protocols/clients/servers
> + */
> +static unsigned int random_port(void)

uint

> +{
> +       return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
> +}
> +
>  static inline s32 tcp_seq_cmp(u32 a, u32 b)
>  {
>         return (s32)(a - b);
>  }
>
>  /**
> - * tcp_get_tcp_state() - get TCP stream state
> + * tcp_stream_get_state() - get TCP stream state
>   * @tcp: tcp stream
>   *
>   * Return: TCP stream state
>   */
> -enum tcp_state tcp_get_tcp_state(struct tcp_stream *tcp)
> +enum tcp_state tcp_stream_get_state(struct tcp_stream *tcp)
>  {
>         return tcp->state;
>  }
>
>  /**
> - * tcp_set_tcp_state() - set TCP stream state
> + * tcp_stream_set_state() - set TCP stream state
>   * @tcp: tcp stream
>   * @new_state: new TCP state
>   */
> -void tcp_set_tcp_state(struct tcp_stream *tcp,
> -                      enum tcp_state new_state)
> +static void tcp_stream_set_state(struct tcp_stream *tcp,
> +                                enum tcp_state new_state)
>  {
>         tcp->state = new_state;
>  }
>
> -struct tcp_stream *tcp_stream_get(void)
> +void tcp_init(void)
> +{
> +       incoming_filter = NULL;
> +       tcp_stream.state = TCP_CLOSED;
> +}
> +
> +void tcp_set_incoming_filter(tcp_incoming_filter *filter)
> +{
> +       incoming_filter = filter;
> +}
> +
> +static struct tcp_stream *tcp_stream_add(struct in_addr rhost,
> +                                        u16 rport, u16 lport)
> +{
> +       struct tcp_stream *tcp = &tcp_stream;
> +
> +       if (tcp->state != TCP_CLOSED)
> +               return NULL;
> +
> +       memset(tcp, 0, sizeof(struct tcp_stream));
> +       tcp->rhost.s_addr = rhost.s_addr;
> +       tcp->rport = rport;
> +       tcp->lport = lport;
> +       tcp->state = TCP_CLOSED;
> +       tcp->lost.len = TCP_OPT_LEN_2;
> +       return tcp;
> +}
> +
> +struct tcp_stream *tcp_stream_get(int is_new, struct in_addr rhost,
> +                                 u16 rport, u16 lport)
>  {
> -       return &tcp_stream;
> +       struct tcp_stream *tcp = &tcp_stream;
> +
> +       if ((tcp->rhost.s_addr == rhost.s_addr) &&
> +           (tcp->rport == rport) &&
> +           (tcp->lport == lport))
> +               return tcp;

Drop the internal brackets

> +
> +       if (!is_new || (incoming_filter == NULL) ||

!incoming_filter

> +           !incoming_filter(rhost, rport, lport))
> +               return NULL;
> +
> +       return tcp_stream_add(rhost, rport, lport);
>  }
>
> -static void dummy_handler(uchar *pkt, u16 dport,
> -                         struct in_addr sip, u16 sport,
> +static void dummy_handler(struct tcp_stream *tcp, uchar *pkt,
>                           u32 tcp_seq_num, u32 tcp_ack_num,
>                           u8 action, unsigned int len)
>  {
> @@ -222,8 +278,7 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>         b->ip.end = TCP_O_END;
>  }
>
> -int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
> -                      int sport, int payload_len,
> +int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>  {
>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
> @@ -243,7 +298,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>         case TCP_SYN:
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
> -                          &net_server_ip, &net_ip,
> +                          &tcp->rhost, &net_ip,
>                            tcp_seq_num, tcp_ack_num);
>                 tcp_activity_count = 0;
>                 net_set_syn_options(tcp, b);
> @@ -264,13 +319,13 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>                 b->ip.hdr.tcp_flags = action;
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num,
> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
>                            action);
>                 break;
>         case TCP_FIN:
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>                 payload_len = 0;
>                 pkt_hdr_len = IP_TCP_HDR_SIZE;
>                 tcp->state = TCP_FIN_WAIT_1;
> @@ -279,7 +334,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>         case TCP_RST:
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
> -                          &net_server_ip, &net_ip, tcp_seq_num, tcp_ack_num);
> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>                 tcp->state = TCP_CLOSED;
>                 break;
>         /* Notify connection closing */
> @@ -290,7 +345,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &net_server_ip, &net_ip,
> +                          &tcp->rhost, &net_ip,
>                            tcp_seq_num, tcp_ack_num, action);
>                 fallthrough;
>         default:
> @@ -298,7 +353,7 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>                 b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
> -                          &net_server_ip, &net_ip,
> +                          &tcp->rhost, &net_ip,
>                            tcp_seq_num, tcp_ack_num, action);
>         }
>
> @@ -308,8 +363,8 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>         tcp->ack_edge = tcp_ack_num;
>         /* TCP Header */
>         b->ip.hdr.tcp_ack = htonl(tcp->ack_edge);
> -       b->ip.hdr.tcp_src = htons(sport);
> -       b->ip.hdr.tcp_dst = htons(dport);
> +       b->ip.hdr.tcp_src = htons(tcp->lport);
> +       b->ip.hdr.tcp_dst = htons(tcp->rport);
>         b->ip.hdr.tcp_seq = htonl(tcp_seq_num);
>
>         /*
> @@ -332,10 +387,10 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int dport,
>         b->ip.hdr.tcp_xsum = 0;
>         b->ip.hdr.tcp_ugr = 0;
>
> -       b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, net_server_ip,
> +       b->ip.hdr.tcp_xsum = tcp_set_pseudo_header(pkt, net_ip, tcp->rhost,
>                                                    tcp_len, pkt_len);
>
> -       net_set_ip_header((uchar *)&b->ip, net_server_ip, net_ip,
> +       net_set_ip_header((uchar *)&b->ip, tcp->rhost, net_ip,
>                           pkt_len, IPPROTO_TCP);
>
>         return pkt_hdr_len;
> @@ -616,19 +671,26 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>         u32 tcp_seq_num, tcp_ack_num;
>         int tcp_hdr_len, payload_len;
>         struct tcp_stream *tcp;
> +       struct in_addr src;
>
>         /* Verify IP header */
>         debug_cond(DEBUG_DEV_PKT,
>                    "TCP RX in RX Sum (to=%pI4, from=%pI4, len=%d)\n",
>                    &b->ip.hdr.ip_src, &b->ip.hdr.ip_dst, pkt_len);
>
> -       b->ip.hdr.ip_src = net_server_ip;
> +       /*
> +        * src IP address will be destroyed by TCP checksum verification
> +        * algorithm (see tcp_set_pseudo_header()), so remember it before
> +        * it was garbaged.
> +        */
> +       src.s_addr = b->ip.hdr.ip_src.s_addr;
> +
>         b->ip.hdr.ip_dst = net_ip;
>         b->ip.hdr.ip_sum = 0;
>         if (tcp_rx_xsum != compute_ip_checksum(b, IP_HDR_SIZE)) {
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP RX IP xSum Error (%pI4, =%pI4, len=%d)\n",
> -                          &net_ip, &net_server_ip, pkt_len);
> +                          &net_ip, &src, pkt_len);
>                 return;
>         }
>
> @@ -640,11 +702,14 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>                                                  pkt_len)) {
>                 debug_cond(DEBUG_DEV_PKT,
>                            "TCP RX TCP xSum Error (%pI4, %pI4, len=%d)\n",
> -                          &net_ip, &net_server_ip, tcp_len);
> +                          &net_ip, &src, tcp_len);
>                 return;
>         }
>
> -       tcp = tcp_stream_get();
> +       tcp = tcp_stream_get(b->ip.hdr.tcp_flags & TCP_SYN,
> +                            src,
> +                            ntohs(b->ip.hdr.tcp_src),
> +                            ntohs(b->ip.hdr.tcp_dst));
>         if (tcp == NULL)
>                 return;
>
> @@ -676,9 +741,9 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>                            "TCP Notify (action=%x, Seq=%u,Ack=%u,Pay%d)\n",
>                            tcp_action, tcp_seq_num, tcp_ack_num, payload_len);
>
> -               (*tcp_packet_handler) ((uchar *)b + pkt_len - payload_len, b->ip.hdr.tcp_dst,
> -                                      b->ip.hdr.ip_src, b->ip.hdr.tcp_src, tcp_seq_num,
> -                                      tcp_ack_num, tcp_action, payload_len);
> +               (*tcp_packet_handler) (tcp, (uchar *)b + pkt_len - payload_len,
> +                                      tcp_seq_num, tcp_ack_num, tcp_action,
> +                                      payload_len);
>
>         } else if (tcp_action != TCP_DATA) {
>                 debug_cond(DEBUG_DEV_PKT,
> @@ -689,9 +754,13 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
>                  * Warning: Incoming Ack & Seq sequence numbers are transposed
>                  * here to outgoing Seq & Ack sequence numbers
>                  */
> -               net_send_tcp_packet(0, ntohs(b->ip.hdr.tcp_src),
> -                                   ntohs(b->ip.hdr.tcp_dst),
> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport,
>                                     (tcp_action & (~TCP_PUSH)),
>                                     tcp_ack_num, tcp->ack_edge);
>         }
>  }
> +
> +struct tcp_stream *tcp_stream_connect(struct in_addr rhost, u16 rport)
> +{
> +       return tcp_stream_add(rhost, rport, random_port());
> +}
> diff --git a/net/wget.c b/net/wget.c
> index c0a80597bfe..ad5db21e97e 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -27,9 +27,8 @@ static const char http_eom[] = "\r\n\r\n";
>  static const char http_ok[] = "200";
>  static const char content_len[] = "Content-Length";
>  static const char linefeed[] = "\r\n";
> -static struct in_addr web_server_ip;
> -static int our_port;
>  static int wget_timeout_count;
> +struct tcp_stream *tcp;
>
>  struct pkt_qd {
>         uchar *pkt;
> @@ -137,22 +136,19 @@ static void wget_send_stored(void)
>         int len = retry_len;
>         unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
>         unsigned int tcp_seq_num = retry_tcp_ack_num;
> -       unsigned int server_port;
>         uchar *ptr, *offset;
>
> -       server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
> -
>         switch (current_wget_state) {
>         case WGET_CLOSED:
>                 debug_cond(DEBUG_WGET, "wget: send SYN\n");
>                 current_wget_state = WGET_CONNECTING;
> -               net_send_tcp_packet(0, server_port, our_port, action,
> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>                                     tcp_seq_num, tcp_ack_num);
>                 packets = 0;
>                 break;
>         case WGET_CONNECTING:
>                 pkt_q_idx = 0;
> -               net_send_tcp_packet(0, server_port, our_port, action,
> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>                                     tcp_seq_num, tcp_ack_num);
>
>                 ptr = net_tx_packet + net_eth_hdr_size() +
> @@ -167,14 +163,14 @@ static void wget_send_stored(void)
>
>                 memcpy(offset, &bootfile3, strlen(bootfile3));
>                 offset += strlen(bootfile3);
> -               net_send_tcp_packet((offset - ptr), server_port, our_port,
> +               net_send_tcp_packet((offset - ptr), tcp->rhost, tcp->rport, tcp->lport,
>                                     TCP_PUSH, tcp_seq_num, tcp_ack_num);
>                 current_wget_state = WGET_CONNECTED;
>                 break;
>         case WGET_CONNECTED:
>         case WGET_TRANSFERRING:
>         case WGET_TRANSFERRED:
> -               net_send_tcp_packet(0, server_port, our_port, action,
> +               net_send_tcp_packet(0, tcp->rhost, tcp->rport, tcp->lport, action,
>                                     tcp_seq_num, tcp_ack_num);
>                 break;
>         }
> @@ -339,10 +335,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>
>  /**
>   * wget_handler() - TCP handler of wget
> + * @tcp: TCP stream
>   * @pkt: pointer to the application packet
> - * @dport: destination TCP port
> - * @sip: source IP address
> - * @sport: source TCP port
>   * @tcp_seq_num: TCP sequential number
>   * @tcp_ack_num: TCP acknowledgment number
>   * @action: TCP action (SYN, ACK, FIN, etc)
> @@ -351,13 +345,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
>   * In the "application push" invocation, the TCP header with all
>   * its information is pointed to by the packet pointer.
>   */
> -static void wget_handler(uchar *pkt, u16 dport,
> -                        struct in_addr sip, u16 sport,
> +static void wget_handler(struct tcp_stream *tcp, uchar *pkt,
>                          u32 tcp_seq_num, u32 tcp_ack_num,
>                          u8 action, unsigned int len)
>  {
> -       struct tcp_stream *tcp = tcp_stream_get();
> -       enum tcp_state wget_tcp_state = tcp_get_tcp_state(tcp);
> +       enum tcp_state wget_tcp_state = tcp_stream_get_state(tcp);
>
>         net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>         packets++;
> @@ -441,26 +433,13 @@ static void wget_handler(uchar *pkt, u16 dport,
>         }
>  }
>
> -#define RANDOM_PORT_START 1024
> -#define RANDOM_PORT_RANGE 0x4000
> -
> -/**
> - * random_port() - make port a little random (1024-17407)
> - *
> - * Return: random port number from 1024 to 17407
> - *
> - * This keeps the math somewhat trivial to compute, and seems to work with
> - * all supported protocols/clients/servers
> - */
> -static unsigned int random_port(void)
> -{
> -       return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
> -}
> -
>  #define BLOCKSIZE 512
>
>  void wget_start(void)
>  {
> +       struct in_addr web_server_ip;
> +       unsigned int server_port;
> +
>         image_url = strchr(net_boot_file_name, ':');
>         if (image_url > 0) {
>                 web_server_ip = string_to_ip(net_boot_file_name);
> @@ -513,8 +492,6 @@ void wget_start(void)
>         wget_timeout_count = 0;
>         current_wget_state = WGET_CLOSED;
>
> -       our_port = random_port();
> -
>         /*
>          * Zero out server ether to force arp resolution in case
>          * the server ip for the previous u-boot command, for example dns
> @@ -523,6 +500,13 @@ void wget_start(void)
>
>         memset(net_server_ethaddr, 0, 6);
>
> +       server_port = env_get_ulong("httpdstp", 10, SERVER_PORT) & 0xffff;
> +       tcp = tcp_stream_connect(web_server_ip, server_port);
> +       if (tcp == NULL) {

!tcp

> +               net_set_state(NETLOOP_FAIL);
> +               return;
> +       }
> +
>         wget_send(TCP_SYN, 0, 0, 0);
>  }
>
> --
> 2.39.2
>

Regards,
Simon
