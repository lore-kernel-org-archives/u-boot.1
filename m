Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7EAD5E12F
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 11:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A3B8903B;
	Fri,  8 Nov 2024 12:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tgr4PhVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16198890B1; Fri,  8 Nov 2024 12:40:44 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF3788FD0
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 12:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so1622589a91.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 03:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731066040; x=1731670840; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj7OUThxbpNUC9gMU+wSVQmCleFZkncn0zfgo7VjPMo=;
 b=Tgr4PhVgIgR/CfKb+wx0C8m+fkMLTpkP9yotlv+VtLNehE+BJ03wZGD3RESozXRrsh
 FFrdFEh1mt6MQ7vHTy81OZL8psCO1Lw5Upv+gR2AltMQhEs5L3ERwfqDixuz7O6CdQ/u
 sXi+bLCeLY4hAiqJ3doYBG/0X3sQvK5Adkwtpod1pMYVVPUwRm2C+Z7pkni3JGCF6Ck2
 nAt8plPue9vbAggySWFR+J7RG43+g5Q7vMwk4xGTckaVCqWtOoobGeMiyUKW9tqFUmC/
 8wr4qzpU9QN+2ZUGwdxGEI0cMsqYhr0eORT1YuppYbzD7biPtZSeaJ/PFuSFn3A7lDF2
 gxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731066040; x=1731670840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dj7OUThxbpNUC9gMU+wSVQmCleFZkncn0zfgo7VjPMo=;
 b=B4n2RSQLBmVVS2ph3puj4LEQShtXYfHFmFTkB6MrWuCZkzllVJ0BMbhe0SG1tJrCm5
 lPcWIztlkXiv6g5oK13SAU5L8LF5bQEEAxjGxCTqTQJyaIaJ67qYVUIMlrM7le6wuJZA
 UUAZzpOT1Jb1gj0KuHsF89oAFq1vyAc1YZPruGfKtQvl/CS+SOix+OwBfDOQ8ITC/hIX
 4z0Z4RjKmj4F1JmSvSNMfFkC6j5AqPhAhPMLNQKZOKd8V3qqcmzMJqpW8++bbPtGBQTP
 i5DryCABLO0TF1FiYXSRo4HzgxsW51Ltl830IB0jGNxSO4tcFLEy85Uo/YtUAbiUd65x
 1Cgw==
X-Gm-Message-State: AOJu0Yw2ZbRa1Jzoxmo5/tr9yAE7OlVoloMPJvgTp6b9GQqb0JH3wdQz
 D0XSmrt0hwEJdEsDwa8VmcMjMUF5kZAilH5yOo3sZKeD6bWz9S2vLG6z70rO+8x+ciRhD1wSgaW
 x+qHAjVTK7/76ddZxnmo9E/DNiJlnLticSzq0/g==
X-Google-Smtp-Source: AGHT+IFM2W9ZNS+5fnFz5tINiUpFeshck326VDmv0zDM9Nrd4Z+fl+GtVvvKhEANOhW3NizhlZaW59CwkyYIS3OgEvs=
X-Received: by 2002:a17:90b:2ece:b0:2e2:d33b:cc with SMTP id
 98e67ed59e1d1-2e9b172e0bemr3315800a91.21.1731066039446; Fri, 08 Nov 2024
 03:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20241107112801.543992-1-jerome.forissier@linaro.org>
In-Reply-To: <20241107112801.543992-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Nov 2024 11:40:03 +0000
Message-ID: <CAC_iWjJ+WHXu1h_m=LwXvdOdGPqeoTAorzBA0K0zwZVfTrthbA@mail.gmail.com>
Subject: Re: [PATCH] lwip: fix code style issues
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Thu, 7 Nov 2024 at 11:29, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Fix various code style issues in the lwIP code.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/net-common.c          |  9 +++-----
>  cmd/net-lwip.c            | 37 +++++++++++---------------------
>  include/net-common.h      | 22 ++++++++++----------
>  include/net-legacy.h      | 44 ++++++++++++++++++++-------------------
>  lib/lwip/u-boot/arch/cc.h |  5 +++--
>  net/lwip/eth_internal.h   |  2 +-
>  net/lwip/net-lwip.c       | 29 +++++++++++++-------------
>  net/lwip/ping.c           |  8 +++----
>  net/lwip/tftp.c           |  8 +++----
>  net/lwip/wget.c           | 14 ++++++-------
>  10 files changed, 82 insertions(+), 96 deletions(-)
>
> diff --git a/cmd/net-common.c b/cmd/net-common.c
> index 1c9fb83b896..1c6f11cd435 100644
> --- a/cmd/net-common.c
> +++ b/cmd/net-common.c
> @@ -101,9 +101,6 @@ static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         return cp->cmd(cmdtp, flag, argc, argv);
>  }
>
> -U_BOOT_CMD(
> -       net, 3, 1, do_net,
> -       "NET sub-system",
> -       "list - list available devices\n"
> -       "stats <device> - dump statistics for specified device\n"
> -);
> +U_BOOT_CMD(net, 3, 1, do_net, "NET sub-system",
> +          "list - list available devices\n"
> +          "stats <device> - dump statistics for specified device\n");
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 42f8bd6b259..6f5fc743030 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -5,41 +5,28 @@
>  #include <net.h>
>
>  #if defined(CONFIG_CMD_DHCP)
> -U_BOOT_CMD(
> -        dhcp,   3,      1,      do_dhcp,
> -        "boot image via network using DHCP/TFTP protocol",
> -        "[loadAddress] [[hostIPaddr:]bootfilename]"
> -);
> +U_BOOT_CMD(dhcp, 3, 1, do_dhcp,
> +          "boot image via network using DHCP/TFTP protocol",
> +          "[loadAddress] [[hostIPaddr:]bootfilename]");
>  #endif
>
>  #if defined(CONFIG_CMD_PING)
> -U_BOOT_CMD(
> -       ping,   2,      1,      do_ping,
> -       "send ICMP ECHO_REQUEST to network host",
> -       "pingAddress"
> -);
> +U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
> +          "pingAddress");
>  #endif
>
>  #if defined(CONFIG_CMD_TFTPBOOT)
> -U_BOOT_CMD(
> -       tftpboot,       3,      0,      do_tftpb,
> -       "boot image via network using TFTP protocol\n",
> -       "[loadAddress] [[hostIPaddr:]bootfilename]"
> -);
> +U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
> +          "boot image via network using TFTP protocol\n",
> +          "[loadAddress] [[hostIPaddr:]bootfilename]");
>  #endif
>
>  #if defined(CONFIG_CMD_DNS)
> -U_BOOT_CMD(
> -       dns,    3,      1,      do_dns,
> -       "lookup the IP of a hostname",
> -       "hostname [envvar]"
> -);
> +U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
> +          "hostname [envvar]");
>  #endif
>
>  #if defined(CONFIG_CMD_WGET)
> -U_BOOT_CMD(
> -       wget,   3,      1,      do_wget,
> -       "boot image via network using HTTP protocol",
> -       "[loadAddress] URL"
> -);
> +U_BOOT_CMD(wget, 3, 1, do_wget, "boot image via network using HTTP protocol",
> +          "[loadAddress] URL");
>  #endif
> diff --git a/include/net-common.h b/include/net-common.h
> index fd7c5e7b488..524ed4ad131 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -68,7 +68,7 @@ struct ip_udp_hdr {
>         u16             udp_dst;        /* UDP destination port         */
>         u16             udp_len;        /* Length of UDP packet         */
>         u16             udp_xsum;       /* Checksum                     */
> -} __attribute__((packed));
> +} __packed;
>
>  #define IP_UDP_HDR_SIZE                (sizeof(struct ip_udp_hdr))
>  #define UDP_HDR_SIZE           (IP_UDP_HDR_SIZE - IP_HDR_SIZE)
> @@ -84,13 +84,13 @@ struct ip_udp_hdr {
>   */
>  #define ARP_HLEN_ASCII (ARP_HLEN * 2) + (ARP_HLEN - 1)
>
> -#define ARP_HDR_SIZE   (8+20)          /* Size assuming ethernet       */
> +#define ARP_HDR_SIZE   (8 + 20)        /* Size assuming ethernet       */
>
>  #   define ARP_ETHER       1           /* Ethernet  hardware address   */
>
>  /*
>   * Maximum packet size; used to allocate packet storage. Use
> - * the maxium Ethernet frame size as specified by the Ethernet
> + * the maximum Ethernet frame size as specified by the Ethernet
>   * standard including the 802.1Q tag (VLAN tagging).
>   * maximum packet size =  1522
>   * maximum packet size and multiple of 32 bytes =  1536
> @@ -129,7 +129,7 @@ extern char *pxelinux_configfile;
>   * @nbytes:    Number of bytes to check (normally a multiple of 2)
>   * Return: 16-bit IP checksum
>   */
> -unsigned compute_ip_checksum(const void *addr, unsigned nbytes);
> +unsigned compute_ip_checksum(const void *addr, unsigned int nbytes);
>
>  /**
>   * ip_checksum_ok() - check if a checksum is correct
> @@ -140,7 +140,7 @@ unsigned compute_ip_checksum(const void *addr, unsigned nbytes);
>   * @nbytes:    Number of bytes to check (normally a multiple of 2)
>   * Return: true if the checksum matches, false if not
>   */
> -int ip_checksum_ok(const void *addr, unsigned nbytes);
> +int ip_checksum_ok(const void *addr, unsigned int nbytes);
>
>  /**
>   * add_ip_checksums() - add two IP checksums
> @@ -150,7 +150,7 @@ int ip_checksum_ok(const void *addr, unsigned nbytes);
>   * @new_sum:   New checksum to add
>   * Return: updated 16-bit IP checksum
>   */
> -unsigned add_ip_checksums(unsigned offset, unsigned sum, unsigned new_sum);
> +unsigned add_ip_checksums(unsigned offset, unsigned sum, unsigned int new_sum);
>
>  /*
>   * The devname can be either an exact name given by the driver or device tree
> @@ -185,7 +185,7 @@ int eth_env_get_enetaddr_by_index(const char *base_name, int index,
>   * Return: 0 if OK, other value on error
>   */
>  int eth_env_set_enetaddr_by_index(const char *base_name, int index,
> -                                uchar *enetaddr);
> +                                 uchar *enetaddr);
>
>  /*
>   * Initialize USB ethernet device with CONFIG_DM_ETH
> @@ -231,7 +231,7 @@ static inline void net_send_packet(uchar *pkt, int len)
>         if (DEBUG_NET_PKT_TRACE)
>                 print_hex_dump_bytes("tx: ", DUMP_PREFIX_OFFSET, pkt, len);
>         /* Currently no way to return errors from eth_send() */
> -       (void) eth_send(pkt, len);
> +       (void)eth_send(pkt, len);
>  }
>
>  enum eth_recv_flags {
> @@ -327,7 +327,7 @@ struct ethernet_hdr {
>         u8              et_dest[ARP_HLEN];      /* Destination node     */
>         u8              et_src[ARP_HLEN];       /* Source node          */
>         u16             et_protlen;             /* Protocol or length   */
> -} __attribute__((packed));
> +} __packed;
>
>  /* Ethernet header size */
>  #define ETHER_HDR_SIZE (sizeof(struct ethernet_hdr))
> @@ -445,10 +445,10 @@ void net_process_received_packet(uchar *in_packet, int len);
>  int update_tftp(ulong addr, char *interface, char *devstring);
>
>  /**
> - * env_get_ip() - Convert an environment value to to an ip address
> + * env_get_ip() - Convert an environment value to an ip address
>   *
>   * @var: Environment variable to convert. The value of this variable must be
> - *     in the format format a.b.c.d, where each value is a decimal number from
> + *     in the format a.b.c.d, where each value is a decimal number from
>   *     0 to 255
>   * Return: IP address, or 0 if invalid
>   */
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index ca1efd17af7..1f62ebff51d 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -43,9 +43,9 @@ struct udevice;
>   * @param sport  source UDP port
>   * @param len    packet length
>   */
> -typedef void rxhand_f(uchar *pkt, unsigned dport,
> -                     struct in_addr sip, unsigned sport,
> -                     unsigned len);
> +typedef void rxhand_f(uchar *pkt, unsigned int dport,
> +                     struct in_addr sip, unsigned int sport,
> +                     unsigned int len);
>
>  /**
>   * An incoming ICMP packet handler.
> @@ -57,8 +57,9 @@ typedef void rxhand_f(uchar *pkt, unsigned dport,
>   * @param pkt  pointer to the ICMP packet data
>   * @param len  packet length
>   */
> -typedef void rxhand_icmp_f(unsigned type, unsigned code, unsigned dport,
> -               struct in_addr sip, unsigned sport, uchar *pkt, unsigned len);
> +typedef void rxhand_icmp_f(unsigned type, unsigned int code, unsigned int dport,
> +                          struct in_addr sip, unsigned int sport, uchar *pkt,
> +                          unsigned int len);
>
>  /*
>   *     A timeout handler.  Called after time interval has expired.
> @@ -87,7 +88,7 @@ void eth_halt_state_only(void); /* Set passive state */
>   * Return: 0 if OK, other value on error
>   */
>  int eth_env_set_enetaddr_by_index(const char *base_name, int index,
> -                                uchar *enetaddr);
> +                                 uchar *enetaddr);
>
>  /*
>   * Get the hardware address for an ethernet interface .
> @@ -99,7 +100,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
>   *     Return true if the address is valid.
>   */
>  int eth_env_get_enetaddr_by_index(const char *base_name, int index,
> -                                uchar *enetaddr);
> +                                 uchar *enetaddr);
>
>  int eth_send(void *packet, int length);           /* Send a packet */
>
> @@ -127,7 +128,7 @@ struct e802_hdr {
>         u8              et_snap2;
>         u8              et_snap3;
>         u16             et_prot;                /* 802 protocol         */
> -} __attribute__((packed));
> +} __packed;
>
>  /* 802 + SNAP + ethernet header size */
>  #define E802_HDR_SIZE  (sizeof(struct e802_hdr))
> @@ -141,7 +142,7 @@ struct vlan_ethernet_hdr {
>         u16             vet_vlan_type;          /* PROT_VLAN            */
>         u16             vet_tag;                /* TAG of VLAN          */
>         u16             vet_type;               /* protocol type        */
> -} __attribute__((packed));
> +} __packed;
>
>  /* VLAN Ethernet header size */
>  #define VLAN_ETHER_HDR_SIZE    (sizeof(struct vlan_ethernet_hdr))
> @@ -160,7 +161,7 @@ struct ip_hdr {
>         u16             ip_sum;         /* checksum                     */
>         struct in_addr  ip_src;         /* Source IP address            */
>         struct in_addr  ip_dst;         /* Destination IP address       */
> -} __attribute__((packed));
> +} __packed;
>
>  #define IP_OFFS                0x1fff /* ip offset *= 8 */
>  #define IP_FLAGS       0xe000 /* first 3 bits */
> @@ -205,8 +206,7 @@ struct arp_hdr {
>         u8              ar_tha[];       /* Target hardware address      */
>         u8              ar_tpa[];       /* Target protocol address      */
>  #endif /* 0 */
> -} __attribute__((packed));
> -
> +} __packed;
>
>  /*
>   * ICMP stuff (just enough to handle (host) redirect messages)
> @@ -239,14 +239,14 @@ struct icmp_hdr {
>                 } frag;
>                 u8 data[0];
>         } un;
> -} __attribute__((packed));
> +} __packed;
>
>  #define ICMP_HDR_SIZE          (sizeof(struct icmp_hdr))
>  #define IP_ICMP_HDR_SIZE       (IP_HDR_SIZE + ICMP_HDR_SIZE)
>
>  /*
>   * Maximum packet size; used to allocate packet storage. Use
> - * the maxium Ethernet frame size as specified by the Ethernet
> + * the maximum Ethernet frame size as specified by the Ethernet
>   * standard including the 802.1Q tag (VLAN tagging).
>   * maximum packet size =  1522
>   * maximum packet size and multiple of 32 bytes =  1536
> @@ -307,6 +307,7 @@ enum proto_t {
>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
>         WOL, UDP, NCSI, WGET, RS
>  };
> +
>  /* Indicates whether the file name was specified on the command line */
>  extern bool    net_boot_file_name_explicit;
>  /* The actual transferred size of the bootfile (in bytes) */
> @@ -360,16 +361,16 @@ int net_update_ether(struct ethernet_hdr *et, uchar *addr, uint prot);
>  void net_set_ip_header(uchar *pkt, struct in_addr dest, struct in_addr source,
>                        u16 pkt_len, u8 proto);
>  void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
> -                               int sport, int len);
> +                       int sport, int len);
>
>  /* Callbacks */
>  rxhand_f *net_get_udp_handler(void);   /* Get UDP RX packet handler */
> -void net_set_udp_handler(rxhand_f *);  /* Set UDP RX packet handler */
> +void net_set_udp_handler(rxhand_f *f); /* Set UDP RX packet handler */
>  rxhand_f *net_get_arp_handler(void);   /* Get ARP RX packet handler */
> -void net_set_arp_handler(rxhand_f *);  /* Set ARP RX packet handler */
> +void net_set_arp_handler(rxhand_f *f); /* Set ARP RX packet handler */
>  bool arp_is_waiting(void);             /* Waiting for ARP reply? */
>  void net_set_icmp_handler(rxhand_icmp_f *f); /* Set ICMP RX handler */
> -void net_set_timeout_handler(ulong, thand_f *);/* Set timeout handler */
> +void net_set_timeout_handler(ulong t, thand_f *f);/* Set timeout handler */
>
>  /* Network loop state */
>  enum net_loop_state {
> @@ -378,6 +379,7 @@ enum net_loop_state {
>         NETLOOP_SUCCESS,
>         NETLOOP_FAIL
>  };
> +
>  extern enum net_loop_state net_state;
>
>  static inline void net_set_state(enum net_loop_state state)
> @@ -429,8 +431,8 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
>
>  #if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
>  void nc_start(void);
> -int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
> -       unsigned src_port, unsigned len);
> +int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned int dest_port,
> +                   unsigned int src_port, unsigned int len);
>  #endif
>
>  static __always_inline int eth_is_on_demand_init(void)
> @@ -522,7 +524,7 @@ void vlan_to_string(ushort x, char *s);
>  ushort string_to_vlan(const char *s);
>
>  /* read a VLAN id from an environment variable */
> -ushort env_get_vlan(char *);
> +ushort env_get_vlan(char *var);
>
>  /* check if serverip is specified in filename from the command line */
>  int is_serverip_in_cmd(void);
> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> index 563d3bfa98b..de138846358 100644
> --- a/lib/lwip/u-boot/arch/cc.h
> +++ b/lib/lwip/u-boot/arch/cc.h
> @@ -29,8 +29,9 @@
>
>  #define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
>
> -#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
> -                                   x, __LINE__, __FILE__); } while (0)
> +#define LWIP_PLATFORM_ASSERT(x) do { \
> +       printf("Assertion \"%s\" failed at line %d in %s\n", \
> +              x, __LINE__, __FILE__); } while (0)
>
>  #define atoi(str) (int)dectoul(str, NULL)
>  #define lwip_strnstr(a, b, c)  strstr(a, b)
> diff --git a/net/lwip/eth_internal.h b/net/lwip/eth_internal.h
> index 0b829a8d388..87561d5b214 100644
> --- a/net/lwip/eth_internal.h
> +++ b/net/lwip/eth_internal.h
> @@ -25,7 +25,7 @@ void eth_common_init(void);
>   * Return: 0 if OK, other value on error
>   */
>  int eth_env_set_enetaddr_by_index(const char *base_name, int index,
> -                                uchar *enetaddr);
> +                                 uchar *enetaddr);
>
>  int eth_mac_skip(int index);
>  void eth_current_changed(void);
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 5c2bb2e0361..470217781a4 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -203,7 +203,6 @@ struct netif *net_lwip_new_netif(struct udevice *udev)
>
>  struct netif *net_lwip_new_netif_noip(struct udevice *udev)
>  {
> -
>         return new_netif(udev, false);
>  }
>
> @@ -224,24 +223,24 @@ int net_init(void)
>
>  static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
>  {
> -        struct pbuf *p, *q;
> +       struct pbuf *p, *q;
>
> -        /* We allocate a pbuf chain of pbufs from the pool. */
> -        p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
> -        if (!p) {
> -                LINK_STATS_INC(link.memerr);
> -                LINK_STATS_INC(link.drop);
> -                return NULL;
> -        }
> +       /* We allocate a pbuf chain of pbufs from the pool. */
> +       p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
> +       if (!p) {
> +               LINK_STATS_INC(link.memerr);
> +               LINK_STATS_INC(link.drop);
> +               return NULL;
> +       }
>
> -        for (q = p; q != NULL; q = q->next) {
> -                memcpy(q->payload, data, q->len);
> -                data += q->len;
> -        }
> +       for (q = p; q != NULL; q = q->next) {
> +               memcpy(q->payload, data, q->len);
> +               data += q->len;
> +       }
>
> -        LINK_STATS_INC(link.recv);
> +       LINK_STATS_INC(link.recv);
>
> -        return p;
> +       return p;
>  }
>
>  int net_lwip_rx(struct udevice *udev, struct netif *netif)
> diff --git a/net/lwip/ping.c b/net/lwip/ping.c
> index 8dafa25959f..aa617530749 100644
> --- a/net/lwip/ping.c
> +++ b/net/lwip/ping.c
> @@ -39,8 +39,8 @@ static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
>             pbuf_remove_header(p, IP_HLEN) == 0) {
>                 iecho = (struct icmp_echo_hdr *)p->payload;
>
> -               if ((iecho->id == PING_ID) &&
> -                   (iecho->seqno == lwip_htons(ctx->seq_num))) {
> +               if (iecho->id == PING_ID &&
> +                   iecho->seqno == lwip_htons(ctx->seq_num)) {
>                         ctx->alive = true;
>                         printf("host %s is alive\n", ipaddr_ntoa(addr));
>                         pbuf_free(p);
> @@ -93,7 +93,7 @@ static void ping_send_icmp(struct ping_ctx *ctx)
>         if (!p)
>                 return;
>
> -       if ((p->len == p->tot_len) && !p->next) {
> +       if (p->len == p->tot_len && !p->next) {
>                 ctx->iecho = (struct icmp_echo_hdr *)p->payload;
>                 ping_prepare_echo(ctx);
>                 raw_sendto(ctx->pcb, p, &ctx->target);
> @@ -113,7 +113,7 @@ static void ping_send(void *arg)
>         }
>  }
>
> -static int ping_loop(struct udevice *udev, const ip_addr_t* addr)
> +static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
>  {
>         struct ping_ctx ctx = {};
>         struct netif *netif;
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index f4d0a6aa19a..fc4aff5f2ba 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -71,7 +71,7 @@ static int tftp_write(void *handle, struct pbuf *p)
>         struct tftp_ctx *ctx = handle;
>         struct pbuf *q;
>
> -       for (q = p; q != NULL; q = q->next) {
> +       for (q = p; q; q = q->next) {
>                 memcpy((void *)ctx->daddr, q->payload, q->len);
>                 ctx->daddr += q->len;
>                 ctx->size += q->len;
> @@ -130,7 +130,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>
>         printf("Using %s device\n", udev->name);
>         printf("TFTP from server %s; our IP address is %s\n",
> -                ip4addr_ntoa(&srvip), env_get("ipaddr"));
> +              ip4addr_ntoa(&srvip), env_get("ipaddr"));
>         printf("Filename '%s'.\n", fname);
>         printf("Load address: 0x%lx\n", ctx.daddr);
>         printf("Loading: ");
> @@ -187,7 +187,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         char *server_port = NULL;
>         char *end;
>         ip_addr_t srvip;
> -       uint16_t port = TFTP_PORT;
> +       u16 port = TFTP_PORT;
>         ulong laddr;
>         ulong addr;
>         int i;
> @@ -228,7 +228,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         if (arg) {
>                 /* Parse [ip:[port:]]fname */
>                 i = 0;
> -               while ((*(words + i) = strsep(&arg,":")))
> +               while ((*(words + i) = strsep(&arg, ":")))
>                         i++;
>
>                 switch (i) {
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b495ebd1aa9..7bfcdadbacc 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -17,9 +17,9 @@
>  #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>
>  enum done_state {
> -        NOT_DONE = 0,
> -        SUCCESS = 1,
> -        FAILURE = 2
> +       NOT_DONE = 0,
> +       SUCCESS = 1,
> +       FAILURE = 2
>  };
>
>  struct wget_ctx {
> @@ -122,7 +122,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>
>         if (rem < n)
>                 return -1;
> -       strncpy(p, server, n);
> +       strlcpy(p, server, n);
>         p += n;
>         rem -= n;
>         if (rem < 1)
> @@ -133,7 +133,7 @@ static int parse_legacy_arg(char *arg, char *nurl, size_t rem)
>         n = strlen(path);
>         if (rem < n)
>                 return -1;
> -       strncpy(p, path, n);
> +       strlcpy(p, path, n);
>         p += n;
>         rem -= n;
>         if (rem < 1)
> @@ -273,7 +273,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>                 return CMD_RET_USAGE;
>
>         dst_addr = hextoul(argv[1], &end);
> -        if (end == (argv[1] + strlen(argv[1]))) {
> +       if (end == (argv[1] + strlen(argv[1]))) {
>                 if (argc < 3)
>                         return CMD_RET_USAGE;
>                 url = argv[2];
> @@ -283,7 +283,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>         }
>
>         if (parse_legacy_arg(url, nurl, sizeof(nurl)))
> -           return CMD_RET_FAILURE;
> +               return CMD_RET_FAILURE;
>
>         if (wget_with_dns(dst_addr, nurl))
>                 return CMD_RET_FAILURE;
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
