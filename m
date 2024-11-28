Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A106BD69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A70891F5;
	Thu, 28 Nov 2024 15:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DX3prC/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E4DD893D7; Thu, 28 Nov 2024 15:35:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3279489CE1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91AA440C4B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732804545;
 bh=ZkSLHTXNSm+aWBLrXb0xkW9jM7P+FLf2jmLcJJevs60=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=DX3prC/KAk0b7dnXhbwMYXAjFVB43qzaVtuP72TESnP4izl50b4Jrcnlg+kty5SWt
 v9Z2C5JVszDA479DCczVSsfau4ZIwPyIHRq5+aSrAqIlJcAHnMhmMPMpcP9MyR7WTm
 UVjUby8awUktGHmzhoIO/CIgET/gHtVF0Tef8+Ls4FDX/rSR8AlfgEHcMyi6hacBME
 FaCcIqfed+DyD/YOK75DF17M1hBp7c9Wc/GbRN8rdMeOxdrAbS+0rz/wiPbaGOAYWJ
 Ucxt40enxKhAHkt4O6LHbbQ2NWqUaIRphfUG/te5oCmZzMHCcBwrg80kgHDqzmtrt3
 WNTtLA3i73Vuw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d80576abso69880f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732804545; x=1733409345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkSLHTXNSm+aWBLrXb0xkW9jM7P+FLf2jmLcJJevs60=;
 b=VgikB8ayWwjJUeipyo6vcZpxoFmp4Dj6DiAf9bYKizEF0EjBFwKdoow0/boxBbPrut
 nATTe9slWHM1vOK1Rh8Gt65z5kPtjGFFKz2itabhSJiZoKwe6PYgkEmbxviy6wgwm3wA
 iL/q1prgQeSmQ/yTtk5GFZZVBJs/5h7Dcz7aSs1Me8nI05iGojH03wS8y1NJNMYxND/W
 4+dlA5IZNKz33tm8g+wMIW+hP/gB3C90cJivlf6VLCeqPnHPI+llcVpgRLptUjEoanTJ
 3k5l50JydQ2w1/CJDVBuVkN7InxUUlD5sD2hXb+zRlLzwHfvhLcYYdQwPdOzFR7Bk/zo
 lUpg==
X-Gm-Message-State: AOJu0YxcWXROeCMaMk4B/G6KYSw6P5ZpKOa5Ri8lvHchusRLIK/aGUwE
 ltj3jDB8MSyZhg/jfyYZ/w2nCGZ/jRQMNJBGnOB2VH6eOMUcOIm/u3uq9U4JGoIwYWo4GneCv9N
 oGbdRokIa0MsDPawC6cKAqvZVq/YVzTwDLMeWIgigB/hP+LjizXGFlvV7YKFYKfUBQwOapju/oL
 IL+0WhsGucJJFT93bSIlc0qbK/LyLpdI2oX9ng5bdLNg==
X-Gm-Gg: ASbGncuNz+k/6tTaX3Up1L1LOOPtBNzvTeKYemEZD3AABZyOSArIS4BnTdpBf3sMtew
 9pxRx2JU2JxlONuksOq4fcIWtntnwtw==
X-Received: by 2002:a05:6000:2a0a:b0:382:442c:2c7c with SMTP id
 ffacd0b85a97d-385c6eb7a47mr5240808f8f.18.1732804545015; 
 Thu, 28 Nov 2024 06:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFblTMDmyZZ0ZwyGAUIW6Bn0EEXRcqfB6UpMDJMeiakBOn2djinIxO8LNMhB3YajiEnkXK2+61XxiiCAimAj9w=
X-Received: by 2002:a05:6000:2a0a:b0:382:442c:2c7c with SMTP id
 ffacd0b85a97d-385c6eb7a47mr5240790f8f.18.1732804544613; Thu, 28 Nov 2024
 06:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20241107112801.543992-1-jerome.forissier@linaro.org>
In-Reply-To: <20241107112801.543992-1-jerome.forissier@linaro.org>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Thu, 28 Nov 2024 11:35:33 -0300
Message-ID: <CAFQa3MJhrSuLYdqfe58qntRc1uzm521yWxzaRoiHn33DscX6rg@mail.gmail.com>
Subject: Re: [PATCH] lwip: fix code style issues
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailman-Approved-At: Thu, 28 Nov 2024 15:48:54 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 7 Nov 2024 at 08:29, Jerome Forissier <jerome.forissier@linaro.org>
wrote:

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
> @@ -101,9 +101,6 @@ static int do_net(struct cmd_tbl *cmdtp, int flag, int
> argc, char *const argv[])
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
> +U_BOOT_CMD(wget, 3, 1, do_wget, "boot image via network using HTTP
> protocol",
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
> @@ -140,7 +140,7 @@ unsigned compute_ip_checksum(const void *addr,
> unsigned nbytes);
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
> -unsigned add_ip_checksums(unsigned offset, unsigned sum, unsigned
> new_sum);
> +unsigned add_ip_checksums(unsigned offset, unsigned sum, unsigned int
> new_sum);
>
>  /*
>   * The devname can be either an exact name given by the driver or device
> tree
> @@ -185,7 +185,7 @@ int eth_env_get_enetaddr_by_index(const char
> *base_name, int index,
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
> @@ -445,10 +445,10 @@ void net_process_received_packet(uchar *in_packet,
> int len);
>  int update_tftp(ulong addr, char *interface, char *devstring);
>
>  /**
> - * env_get_ip() - Convert an environment value to to an ip address
> + * env_get_ip() - Convert an environment value to an ip address
>   *
>   * @var: Environment variable to convert. The value of this variable must
> be
> - *     in the format format a.b.c.d, where each value is a decimal number
> from
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
> -               struct in_addr sip, unsigned sport, uchar *pkt, unsigned
> len);
> +typedef void rxhand_icmp_f(unsigned type, unsigned int code, unsigned int
> dport,
> +                          struct in_addr sip, unsigned int sport, uchar
> *pkt,
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
> @@ -99,7 +100,7 @@ int eth_env_set_enetaddr_by_index(const char
> *base_name, int index,
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
>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP,
> FASTBOOT_TCP,
>         WOL, UDP, NCSI, WGET, RS
>  };
> +
>  /* Indicates whether the file name was specified on the command line */
>  extern bool    net_boot_file_name_explicit;
>  /* The actual transferred size of the bootfile (in bytes) */
> @@ -360,16 +361,16 @@ int net_update_ether(struct ethernet_hdr *et, uchar
> *addr, uint prot);
>  void net_set_ip_header(uchar *pkt, struct in_addr dest, struct in_addr
> source,
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
> +void net_set_timeout_handler(ulong t, thand_f *f);/* Set timeout handler
> */
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
> @@ -429,8 +431,8 @@ int net_send_udp_packet(uchar *ether, struct in_addr
> dest, int dport,
>
>  #if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
>  void nc_start(void);
> -int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
> -       unsigned src_port, unsigned len);
> +int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned int
> dest_port,
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
> -#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at
> line %d in %s\n", \
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
> @@ -39,8 +39,8 @@ static u8_t ping_recv(void *arg, struct raw_pcb *pcb,
> struct pbuf *p,
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
> @@ -130,7 +130,7 @@ static int tftp_loop(struct udevice *udev, ulong addr,
> char *fname,
>
>         printf("Using %s device\n", udev->name);
>         printf("TFTP from server %s; our IP address is %s\n",
> -                ip4addr_ntoa(&srvip), env_get("ipaddr"));
> +              ip4addr_ntoa(&srvip), env_get("ipaddr"));
>         printf("Filename '%s'.\n", fname);
>         printf("Load address: 0x%lx\n", ctx.daddr);
>         printf("Loading: ");
> @@ -187,7 +187,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int
> argc, char *const argv[])
>         char *server_port = NULL;
>         char *end;
>         ip_addr_t srvip;
> -       uint16_t port = TFTP_PORT;
> +       u16 port = TFTP_PORT;
>         ulong laddr;
>         ulong addr;
>         int i;
> @@ -228,7 +228,7 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int
> argc, char *const argv[])
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
> @@ -122,7 +122,7 @@ static int parse_legacy_arg(char *arg, char *nurl,
> size_t rem)
>
>         if (rem < n)
>                 return -1;
> -       strncpy(p, server, n);
> +       strlcpy(p, server, n);
>
strlcpy expects the size of the destination buffer, not the bytes to be
copied. In this case, it will copy n-1 bytes and put a zero at the end.
I think strncpy is fine here, as the buffer overflow is watched by rem. I
will send a patch

>         p += n;
>         rem -= n;
>         if (rem < 1)
> @@ -133,7 +133,7 @@ static int parse_legacy_arg(char *arg, char *nurl,
> size_t rem)
>         n = strlen(path);
>         if (rem < n)
>                 return -1;
> -       strncpy(p, path, n);
> +       strlcpy(p, path, n);
>
same

Best,
Adriano

>         p += n;
>         rem -= n;
>         if (rem < 1)
> @@ -273,7 +273,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc,
> char * const argv[])
>                 return CMD_RET_USAGE;
>
>         dst_addr = hextoul(argv[1], &end);
> -        if (end == (argv[1] + strlen(argv[1]))) {
> +       if (end == (argv[1] + strlen(argv[1]))) {
>                 if (argc < 3)
>                         return CMD_RET_USAGE;
>                 url = argv[2];
> @@ -283,7 +283,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc,
> char * const argv[])
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
>
