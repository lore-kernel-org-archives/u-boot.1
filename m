Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE5E95A86
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 02:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754E086A0B;
	Sun,  8 Oct 2023 03:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHKWQhzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D37086D3C; Sun,  8 Oct 2023 03:54:04 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E822E8477A
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 03:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-775751c35d4so218749185a.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 18:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696729995; x=1697334795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LnsFRl6drRhqjMVVBgHI2vTZE4h6KsKjIESddoLp6kM=;
 b=jHKWQhzcUd1iLCZPM9nficcYeUoYOYXRbXoixTA5ehBNKdvV7bd6OMmAbnjQcexLZu
 fRzTGf0aEot35R9mR+ZZJ0+iw8kS4NwIb071Dzfswvnbaw9VcMjGJzp/yURY5CdEej4X
 stqP+TqbBkuXG4K1EyI9obbKb63UT5r60wH0r+EKuGXJl3LNioQIuQzk74KDq6fF9mNZ
 nMGo4B+xYJXvFjPCSFj7PoH7iwtBAI8PFL172+RU5KHVs/OhxQQUIin0dkiQhZnSUPh+
 N2qhy6B5tomE9IyikabPqhsEIiCWYE9dzmwOC3hCVM7lRaA6H/mnRjWifTXk/EEQwUB8
 SZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696729995; x=1697334795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LnsFRl6drRhqjMVVBgHI2vTZE4h6KsKjIESddoLp6kM=;
 b=NrlPo2y5Pls5OG6p1O54NKUXXkPK6tvtPITSiOBM3iMg7gsHUz2F1GFbnFwDXX3KxJ
 YRmxhY91UZG95oX/a9Wlx6tL6lwH4WvuWP4TF/BCRWTBGAzgh0T0KDMBRZufwF0UmU8N
 OlIRPmT0sBgK1V58jCQau7XGqTbrnnrDPhPS8jRVtGTBqoK3rpN7OPSw3iIRCOqwYjJs
 fiwQIrnevo7+civHgD+89TrHbE5POkjKA2IbXi6HsdRPlN/mexAzl8TgqRDNJt4nAol/
 7U1cG63fTti/4kJEFGsb1mD346szTBnYpQUeRTvJDCTiNKgE5IjLrpp6CDn09bzR35iu
 /IfA==
X-Gm-Message-State: AOJu0YwcQXgk8P5vTUaqOWSO2LnVAQzuccAzpX0nUEUqqFTCaEdnA64D
 yJzInTo8Q/kM5iP6EwJN1+0=
X-Google-Smtp-Source: AGHT+IGNsuIHl2NhxfSkX0WUqyRpMqO/+AgPCcMX7aL/FiYvoEmSloe1iPQVgRQt2DMxM+vltqDlxw==
X-Received: by 2002:a05:620a:b47:b0:767:915a:ccf6 with SMTP id
 x7-20020a05620a0b4700b00767915accf6mr11532739qkg.65.1696729994957; 
 Sat, 07 Oct 2023 18:53:14 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 h23-20020a05620a13f700b00767d6ec578csm2475787qkl.20.2023.10.07.18.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 18:53:14 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] net: Add option for tracing packets
Date: Sat,  7 Oct 2023 21:53:12 -0400
Message-Id: <20231008015312.1988866-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add an option to trace all packets send/received. This can be helpful when
debugging protocol issues, as the packets can then be imported into
wireshark [1] and analyzed further.

[1] https://www.wireshark.org/docs/wsug_html_chunked/ChIOImportSection.html

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 include/net.h | 4 ++++
 net/net.c     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/net.h b/include/net.h
index e254df7d7f4..e63a946002d 100644
--- a/include/net.h
+++ b/include/net.h
@@ -16,6 +16,7 @@
 #include <asm/cache.h>
 #include <asm/byteorder.h>	/* for nton* / ntoh* stuff */
 #include <env.h>
+#include <hexdump.h>
 #include <log.h>
 #include <time.h>
 #include <linux/if_ether.h>
@@ -29,6 +30,7 @@ struct udevice;
 #define DEBUG_DEV_PKT 0		/* Packets or info directed to the device */
 #define DEBUG_NET_PKT 0		/* Packets on info on the network at large */
 #define DEBUG_INT_STATE 0	/* Internal network state changes */
+#define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
 
 /*
  *	The number of receive packet buffers, and the required packet buffer
@@ -640,6 +642,8 @@ uchar * net_get_async_tx_pkt_buf(void);
 /* Transmit a packet */
 static inline void net_send_packet(uchar *pkt, int len)
 {
+	if (DEBUG_NET_PKT_TRACE)
+		print_hex_dump_bytes("tx: ", DUMP_PREFIX_OFFSET, pkt, len);
 	/* Currently no way to return errors from eth_send() */
 	(void) eth_send(pkt, len);
 }
diff --git a/net/net.c b/net/net.c
index 43abbac7c32..53eb9ef1324 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1201,6 +1201,9 @@ void net_process_received_packet(uchar *in_packet, int len)
 	ushort cti = 0, vlanid = VLAN_NONE, myvlanid, mynvlanid;
 
 	debug_cond(DEBUG_NET_PKT, "packet received\n");
+	if (DEBUG_NET_PKT_TRACE)
+		print_hex_dump_bytes("rx: ", DUMP_PREFIX_OFFSET, in_packet,
+				     len);
 
 #if defined(CONFIG_CMD_PCAP)
 	pcap_post(in_packet, len, false);
-- 
2.37.1

