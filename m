Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55ADD49201
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 575D1839B7;
	Fri, 12 Dec 2025 12:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rtUhFbTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD642837F2; Fri, 12 Dec 2025 12:32:31 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BE0837F2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so8720265e9.0
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539148; x=1766143948; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=drqCWXGIvc6g2B7eoAzXCwMapcMX83m1YjHcjgm4I78=;
 b=rtUhFbTpl3TiQtmQSRttAwQwJXg4vRrvFAGi+cZWaLc8ut2uOMGnD6khXDFJrmTbYa
 Ry6F/mRn7T3tCRPYKpbiMtezc+kUHLP6eJUojVyw2zhDrRSh8Keifck1dbKK3IrfzHM7
 /nvX4DE6t7M7kWOQb36FVjaclJ7HkTePK3SKLM+N4bhQLVn7/fCqTPtFY5GdOIQ6s2wv
 oyvXjPP1TPGS/S+Dqq0UCQL/9URrqPqBL29pArDIAVr2uXQNpe0oaKSKi1LjeN+nZH2G
 CAaNrjEnLOTVWzrTPGZok4OAWkgaKUMXhXG36v7X4C2lfO8IdrParSpNpAv1/YhzL7+i
 NJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539148; x=1766143948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=drqCWXGIvc6g2B7eoAzXCwMapcMX83m1YjHcjgm4I78=;
 b=fqI30d1muz4mWOUqseOYDfvRctkJfWf3TlvWpSe9HnfVcDqHHiJqXc26JbSA1HgshN
 Jicn7qR0/PnAWqpp9fhnS2zNoKsFD7i4l9rqMnIXzF49ysj5Smh/5qvUQJ5l78+kAoJW
 pSnIrUzgjWnsUXK42lTR6aOpWfjCILZxTLfm8gUCExneEalPKlO7xZyCLZ2l9gCQ0tiI
 3YtFJlw9UUCd+JbIIrhOaiqmmdyrzLGggoJPnk5VlrOaPZq1KJsHqJMrFKqra4XkWzqO
 dLD5bbZY6A3wSLgwvU8Qpy64a5TVqyqMD115hanvJjnvXxjwumvTRJTwSAtD81VxHBLF
 48mA==
X-Gm-Message-State: AOJu0YyiAvocZ7TdCeQ0WYNzYFSCP6wRdLBVpAl914ZgHaZs8pvGAwNe
 d67auHl8t5HLZlzZcOKB4vAM6B28rg1U1PDncZHj1knTTUNyRMP0pr5A6iSCVrd9t4I=
X-Gm-Gg: AY/fxX44HM4z0g09abgQYP0bIJoIlaTnqnbiesbUxze667Mxy0hdp4zOTo9aN/LlFBL
 6sUpDxMDf6d4VKrSKAyAaCg2kIm4YDJQuOa2h1udCrtrNvoSuMpzRu+0VRXS0/9krQOsQYx3Msm
 lXUUv67RujkZ+ee6/gLtJb67bMDJPeWuH+3xMe8gm/OT/oTVxjSq3uL14QJoeSyWxp7WW9VTvqI
 FCL0QKIOYr8lyfQekVvFwurhCyPyl20s6bE4/41XWclGcK6ulWXs+m3io3WE3FwuTdzIwG5715e
 SdBeY9C0myxoB5WP2N2MqcyldMC9bVlyxUP+LlNpD2Ab6nMhYNniGNkdWEb/7rUD77Sm5p9fpI1
 ErwzVaILrmnijxptg8pviTaFUERhuc88tC/ZRGDOBdoOGIosMCT/F3eGppVI4BWtW82krfu9olS
 BIRsbwm49q1cnU4PLcTEUna2hNzSBYUROMYrOdy8w=
X-Google-Smtp-Source: AGHT+IFYoiaSwpmPY9f+4UpGQLYrRBQ1IZqndSbL3jWCmV4EgdH7S42VaSXNEOL/MIFB4bddgpEQWg==
X-Received: by 2002:a05:600c:860b:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47a8f91d91fmr18199465e9.35.1765539147682; 
 Fri, 12 Dec 2025 03:32:27 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:27 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 12 Dec 2025 11:32:25 +0000
Subject: [PATCH v2 2/6] net: Move some variables to net-common files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-lwip_nfs-v2-2-9cb5a60520d8@linaro.org>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
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
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
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
code or lwIP by moving them into the net-common files. This also allowed
removing a small number of duplicated variables from the lwIP code.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/net-common.h | 12 ++++++++++--
 include/net-legacy.h |  5 -----
 net/lwip/net-lwip.c  |  5 -----
 net/net-common.c     |  9 +++++++++
 net/net.c            | 10 ----------
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index d7a0f7dff7e50527e77419ead9a9ff30deeea545..f293b21bc0bb3c8e1a04ffd8f5188e5ce67d1d12 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -132,13 +132,21 @@ static inline void net_set_state(enum net_loop_state state)
 }
 
 extern int		net_restart_wrap;	/* Tried all network devices */
-extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
+extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
 extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
-extern char	net_boot_file_name[1024];/* Boot File name */
 extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
 /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
 extern char *pxelinux_configfile;
 
+/* Our IP addr (0 = unknown) */
+extern struct in_addr	net_ip;
+/* Boot File name */
+extern char	net_boot_file_name[1024];
+/* The actual transferred size of the bootfile (in bytes) */
+extern u32	net_boot_file_size;
+/* Boot file size in blocks as reported by the DHCP server */
+extern u32	net_boot_file_expected_size_in_blocks;
+
 /**
  * compute_ip_checksum() - Compute IP checksum
  *
diff --git a/include/net-legacy.h b/include/net-legacy.h
index 0a10121b0cf50898a90bb1179966f01dbdda65ad..d489c2480cd89adec6026b4fcb0b1165f8a28081 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -289,7 +289,6 @@ extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
 extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
 extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
 extern uchar		*net_tx_packet;		/* THE transmit packet */
-extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
 extern uchar		*net_rx_packet;		/* Current receive packet */
 extern int		net_rx_packet_len;	/* Current rx packet length */
 extern const u8		net_null_ethaddr[ARP_HLEN];
@@ -309,10 +308,6 @@ enum proto_t {
 
 /* Indicates whether the file name was specified on the command line */
 extern bool	net_boot_file_name_explicit;
-/* The actual transferred size of the bootfile (in bytes) */
-extern u32	net_boot_file_size;
-/* Boot file size in blocks as reported by the DHCP server */
-extern u32	net_boot_file_expected_size_in_blocks;
 
 #if defined(CONFIG_DNS)
 extern char *net_dns_resolve;		/* The host to resolve  */
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
index ec1e179f7d9cdd459dc3b8c2d13f6e478ad4ce87..f21a80357f6c6d923c9485969d4c4c80bbb98bfb 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -8,6 +8,15 @@
 
 /* Network loop state */
 enum net_loop_state net_state;
+/* Our IP addr (0 = unknown) */
+struct in_addr	net_ip;
+/* Boot File name */
+char net_boot_file_name[1024];
+/* The actual transferred size of the bootfile (in bytes) */
+u32 net_boot_file_size;
+/* Boot file size in blocks as reported by the DHCP server */
+u32 net_boot_file_expected_size_in_blocks;
+uchar *net_rx_packets[PKTBUFSRX];
 
 void copy_filename(char *dst, const char *src, int size)
 {
diff --git a/net/net.c b/net/net.c
index 03a39419d10817aff5f12badc0f604a403fe7fb2..62f03a84a6c076bc431acdcf7390220cb85359f8 100644
--- a/net/net.c
+++ b/net/net.c
@@ -147,8 +147,6 @@ char *pxelinux_configfile;
 u8 net_ethaddr[6];
 /* Boot server enet address */
 u8 net_server_ethaddr[6];
-/* Our IP addr (0 = unknown) */
-struct in_addr	net_ip;
 /* Server IP addr (0 = unknown) */
 struct in_addr	net_server_ip;
 /* Current receive packet */
@@ -176,18 +174,10 @@ ushort		net_our_vlan = 0xFFFF;
 /* ditto */
 ushort		net_native_vlan = 0xFFFF;
 
-/* Boot File name */
-char net_boot_file_name[1024];
 /* Indicates whether the file name was specified on the command line */
 bool net_boot_file_name_explicit;
-/* The actual transferred size of the bootfile (in bytes) */
-u32 net_boot_file_size;
-/* Boot file size in blocks as reported by the DHCP server */
-u32 net_boot_file_expected_size_in_blocks;
 
 static uchar net_pkt_buf[(PKTBUFSRX+1) * PKTSIZE_ALIGN + PKTALIGN];
-/* Receive packets */
-uchar *net_rx_packets[PKTBUFSRX];
 /* Current UDP RX packet handler */
 static rxhand_f *udp_packet_handler;
 /* Current ARP RX packet handler */

-- 
2.47.3

