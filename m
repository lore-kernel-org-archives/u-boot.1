Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B76D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 12:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E06B83B34;
	Mon,  8 Dec 2025 13:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ArSIL4RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8003283B72; Mon,  8 Dec 2025 13:52:14 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BD283B43
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 13:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso21842735e9.0
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765198332; x=1765803132; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kLKPaUn9C3OcyJ1grvuAzWVXvSROYT3QKdyVXmEDa6w=;
 b=ArSIL4RMHowmq/rlBUZhP8LFfkzVM5Tr9pLhkURlpPIzzT16B61S9Tgk8qwNv4LTTf
 WXL/u0Exe3Q+q8bLeLc/Hzasdf9lbwTDF7ZInYsoecxeEThfJUbWvPEnlGHZBt3w9f27
 453NLXv8LjyUr6xoa3vNgEqUUDyZhXID1uHN3kp1T/Kq0VoruNbOyZWCKEUSt9qo2jb+
 5kYFmlUZNAsJ6x2eILGaw4xxMywiFiMHwcQZ1dwQOcmLq2+9EAPBal332EOCKlplOIbB
 ndxDvZmmKgDrnxzJzFoBsR3T+CXjg2x6H5okKCFwOhfXuALOtSa4lLMOnTy549rvStnm
 9uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765198332; x=1765803132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kLKPaUn9C3OcyJ1grvuAzWVXvSROYT3QKdyVXmEDa6w=;
 b=tY74cp3BIlXKPkkWqz+Z9rv1ngqxGPBWaucJCObuD9FXSMVlXmmT1RDw0LJK0EhyAG
 Z414lwQw5YNTgiS5/Kfbut04fGzhYz1IDAu+Nf2WjyM9VowQ+1acLoyc18XgP28dzSJL
 0xlXKClO+m6tiEBz/ps2O96dZ6CSPm0P/+UAUCSJ02myHaW8SiLO/N/wnn6Pn6XXGlKj
 shbdpVVPhR/PW90w4pjz1EH1R9b/F2D0eRTuPttKMXd2QZkUOYmeArXZRkw5ADeZ4bpc
 v+K0F6m7zSG20i+Ro6akZ6JWi3IWYUg5jTl0r0o0XdvNdPUQflWR+6KtJ0MSsnEB3yQ6
 TlSw==
X-Gm-Message-State: AOJu0YypNR2XZN+k0+aGN6kKzQE7UL4qC3nrkGJ88sWvC+AD0qsW0bzN
 /Dt6i93eZd/F7BoSDLWVLwoiUAq5MTPJHdmDsMPyb5gXH5LbqGXP24SGESw0425Ul6U=
X-Gm-Gg: ASbGncvqG/VRq1q+NOiD6E3IreB0HnlwzcFYApgnDYEAJ0otcJYW2T/Cjc/Vlc63ANy
 uC4wcxNayWaXIohmuA7RuAjvvUFcrH9fmm5kdcxM47Zpj/UqBxqPz9BWZYnKrcChMA4M6RuA//T
 xaklyTzaB8skikdtS7uaVwMx/Eq5qdMjwcLlvzABjOiZ2uH62eYq6iP9flBGhrB6YlnvhFCw0+1
 WnWM17lDkPcOViOidAD3cPAxl3v1mmzoR90ON5keh8TE1UDcFJKl8Sj25BBzRjxlR6IuvOX+EOR
 FGLMxh7LIbJR6LkJk0wOkEyZRGj912mR4PUeGz4nivrh+pXUI33KT3ckNTrBZ+5QXNRYsISdKWO
 0LSi9X7sN1xLYwO73q7CpBt0a5VzwgUXYiMfe/kKBlWtz3Rxdw8lfk7S7rjq9lNE+R/0ZytFx2e
 XoK5l0Kiew7Xe4IiXmAyMznUnqDy+a6RLalTH2gj8=
X-Google-Smtp-Source: AGHT+IGgVdFd9m/GuQrzBn18HlFyCtY1+2dciNTCcJnsfCBTtyLbd+0yOyQyF9+kYfro1c5/Pc+CSQ==
X-Received: by 2002:a05:600c:8b34:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-47939e3d14amr79673945e9.25.1765198331652; 
 Mon, 08 Dec 2025 04:52:11 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f7b:b001:fd05:11bc:5c24:a865])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930920b6dsm260113645e9.1.2025.12.08.04.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 04:52:11 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 08 Dec 2025 12:52:08 +0000
Subject: [PATCH 2/5] net: Move some variables to net-common files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-lwip_nfs-v1-2-1f5d31e15d00@linaro.org>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Make some variables available to be used by either the legacy network
code or LWIP by moving them into the net-common files. This also allowed
removing a small number of duplicated variables from the LWIP code.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/net-common.h | 21 +++++++++++++++++++--
 include/net-legacy.h |  9 ---------
 net/lwip/net-lwip.c  |  5 -----
 net/net-common.c     | 18 ++++++++++++++++++
 net/net.c            | 21 ---------------------
 5 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index d7a0f7dff7e50527e77419ead9a9ff30deeea545..ea43c72ab06a782c621f61811b9774c1185d88fc 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -132,13 +132,30 @@ static inline void net_set_state(enum net_loop_state state)
 }
 
 extern int		net_restart_wrap;	/* Tried all network devices */
-extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
+extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
+extern uchar		*net_rx_packet;		/* Current receive packet */
 extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
-extern char	net_boot_file_name[1024];/* Boot File name */
 extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
 /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
 extern char *pxelinux_configfile;
 
+/* Our IP addr (0 = unknown) */
+extern struct in_addr	net_ip;
+/* Server IP addr (0 = unknown) */
+extern struct in_addr	net_server_ip;
+/* Our subnet mask (0=unknown) */
+extern struct in_addr net_netmask;
+/* Our gateways IP address */
+extern struct in_addr net_gateway;
+/* Boot File name */
+extern char	net_boot_file_name[1024];
+/* Indicates whether the file name was specified on the command line */
+extern bool	net_boot_file_name_explicit;
+/* The actual transferred size of the bootfile (in bytes) */
+extern u32	net_boot_file_size;
+/* Boot file size in blocks as reported by the DHCP server */
+extern u32	net_boot_file_expected_size_in_blocks;
+
 /**
  * compute_ip_checksum() - Compute IP checksum
  *
diff --git a/include/net-legacy.h b/include/net-legacy.h
index 0a10121b0cf50898a90bb1179966f01dbdda65ad..3a07cb53839d458a6eeaa1fcc935b29ac928aad8 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -289,8 +289,6 @@ extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
 extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
 extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
 extern uchar		*net_tx_packet;		/* THE transmit packet */
-extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
-extern uchar		*net_rx_packet;		/* Current receive packet */
 extern int		net_rx_packet_len;	/* Current rx packet length */
 extern const u8		net_null_ethaddr[ARP_HLEN];
 
@@ -307,13 +305,6 @@ enum proto_t {
 	WOL, UDP, NCSI, WGET, RS
 };
 
-/* Indicates whether the file name was specified on the command line */
-extern bool	net_boot_file_name_explicit;
-/* The actual transferred size of the bootfile (in bytes) */
-extern u32	net_boot_file_size;
-/* Boot file size in blocks as reported by the DHCP server */
-extern u32	net_boot_file_expected_size_in_blocks;
-
 #if defined(CONFIG_DNS)
 extern char *net_dns_resolve;		/* The host to resolve  */
 extern char *net_dns_env_var;		/* the env var to put the ip into */
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8741f65fe12e23cc30068506453a762533f8a67f..b3b6c796976ea9d7aec4148992f7cd41cd8f8743 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -33,13 +33,8 @@ static int net_restarted;
 int net_restart_wrap;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
 	__aligned(PKTALIGN);
-uchar *net_rx_packets[PKTBUFSRX];
-uchar *net_rx_packet;
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 char *pxelinux_configfile;
-/* Our IP addr (0 = unknown) */
-struct in_addr	net_ip;
-char net_boot_file_name[1024];
 
 static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 {
diff --git a/net/net-common.c b/net/net-common.c
index ec1e179f7d9cdd459dc3b8c2d13f6e478ad4ce87..155149c80439306cb02b7c3e4080d210ae0991fb 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -8,6 +8,24 @@
 
 /* Network loop state */
 enum net_loop_state net_state;
+/* Our IP addr (0 = unknown) */
+struct in_addr	net_ip;
+/* Server IP addr (0 = unknown) */
+struct in_addr	net_server_ip;
+/* Our subnet mask (0=unknown) */
+struct in_addr net_netmask;
+/* Our gateways IP address */
+struct in_addr net_gateway;
+/* Boot File name */
+char net_boot_file_name[1024];
+/* Indicates whether the file name was specified on the command line */
+bool net_boot_file_name_explicit;
+/* The actual transferred size of the bootfile (in bytes) */
+u32 net_boot_file_size;
+/* Boot file size in blocks as reported by the DHCP server */
+u32 net_boot_file_expected_size_in_blocks;
+uchar *net_rx_packets[PKTBUFSRX];
+uchar *net_rx_packet;
 
 void copy_filename(char *dst, const char *src, int size)
 {
diff --git a/net/net.c b/net/net.c
index 03a39419d10817aff5f12badc0f604a403fe7fb2..bd7f12248fa3fcdf1ecdced31559dc805e151ba1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -128,10 +128,6 @@
 
 /** BOOTP EXTENTIONS **/
 
-/* Our subnet mask (0=unknown) */
-struct in_addr net_netmask;
-/* Our gateways IP address */
-struct in_addr net_gateway;
 /* Our DNS IP address */
 struct in_addr net_dns_server;
 #if defined(CONFIG_BOOTP_DNS2)
@@ -147,12 +143,6 @@ char *pxelinux_configfile;
 u8 net_ethaddr[6];
 /* Boot server enet address */
 u8 net_server_ethaddr[6];
-/* Our IP addr (0 = unknown) */
-struct in_addr	net_ip;
-/* Server IP addr (0 = unknown) */
-struct in_addr	net_server_ip;
-/* Current receive packet */
-uchar *net_rx_packet;
 /* Current rx packet length */
 int		net_rx_packet_len;
 /* IP packet ID */
@@ -176,18 +166,7 @@ ushort		net_our_vlan = 0xFFFF;
 /* ditto */
 ushort		net_native_vlan = 0xFFFF;
 
-/* Boot File name */
-char net_boot_file_name[1024];
-/* Indicates whether the file name was specified on the command line */
-bool net_boot_file_name_explicit;
-/* The actual transferred size of the bootfile (in bytes) */
-u32 net_boot_file_size;
-/* Boot file size in blocks as reported by the DHCP server */
-u32 net_boot_file_expected_size_in_blocks;
-
 static uchar net_pkt_buf[(PKTBUFSRX+1) * PKTSIZE_ALIGN + PKTALIGN];
-/* Receive packets */
-uchar *net_rx_packets[PKTBUFSRX];
 /* Current UDP RX packet handler */
 static rxhand_f *udp_packet_handler;
 /* Current ARP RX packet handler */

-- 
2.47.3

