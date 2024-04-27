Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD4DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC4D88411;
	Sat, 27 Apr 2024 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NyXc87A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01EE4885A1; Sat, 27 Apr 2024 16:11:33 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B044288427
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78edc3ad5fdso274587885a.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227089; x=1714831889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bQJ6usMVxWGPcqDELI+EPGJrlC3+JXo7hWbZGsoTw1g=;
 b=NyXc87A/MHcISpcseNl82VNm/0gmwvdXk8Jm96XLG4hP5jyWASW04ZaL5gizZBSkB5
 87mb79D0jmFvKBSQC2KzEcFJS5rTfjW7lsjppPLtuSWkkFHh02hm9xEoATorSf3HN5Nv
 V6zeWEyDm26g0P/zOPWMafo3osK4S6HqFadFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227089; x=1714831889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQJ6usMVxWGPcqDELI+EPGJrlC3+JXo7hWbZGsoTw1g=;
 b=l4ClNtLEAb2Ujggi4fZrRe2CRlskWPnCcjMuEqkt9C72Dpofx6DoMkalywx/c1wIrg
 aPUksWG9vQOYQUVJijoqIqG/wVCjUhmtAgE7IH0QHcOQ6azx49kVcxS39IKyfGFMKASU
 DGCAREZJtMX+zbMUDRUSpv9e8E6R3eZ0ur3PJFEl1T9OPc8JJnz8F9u0sRFUNTwelsSo
 U4cko6kgSExZNSeVB/vx3v+O4n+LppwwSWv9UMQVLfIDBDmmVvS3MRO4MpHKzJGPMIvi
 ElctH4vfjS0T2ZHV1psiI9gr2ko6A0HiCOYkmSik01R8SwZpiLtGFL1b0Rov7V68j1pI
 6yBg==
X-Gm-Message-State: AOJu0YzjmKmOH5HobdMlSxYzao8+5PBtn1ad/JUwu/PkLEcaDu64goDR
 hp7KnBzPLCNEieUu7KfougzytNKuUUa75VzMd69Y2ALwODrFD1gyEbSTRtXYpVlCIW2r2xRg0VN
 chETM/w==
X-Google-Smtp-Source: AGHT+IE8igT/M9SjzWE/ZmBQr3wCCYWulk40jArMxQi+HmKx6/yW4TZRXSIouxDiIGCZcF9aF61EDg==
X-Received: by 2002:a05:620a:19a3:b0:78a:3ccc:8140 with SMTP id
 bm35-20020a05620a19a300b0078a3ccc8140mr11106727qkb.28.1714227089222; 
 Sat, 27 Apr 2024 07:11:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 16/18] net: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:04 -0600
Message-Id: <20240427141106.3406000-17-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all "net/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 net/arp.c             | 2 +-
 net/bootp.c           | 1 -
 net/cdp.c             | 1 -
 net/dhcpv6.c          | 1 -
 net/dns.c             | 1 -
 net/eth-uclass.c      | 1 -
 net/eth_bootdev.c     | 1 -
 net/eth_common.c      | 1 -
 net/fastboot_tcp.c    | 1 -
 net/fastboot_udp.c    | 1 -
 net/link_local.c      | 1 -
 net/mdio-mux-uclass.c | 1 -
 net/mdio-uclass.c     | 1 -
 net/ndisc.c           | 1 -
 net/net.c             | 1 -
 net/net6.c            | 2 +-
 net/nfs.c             | 1 -
 net/pcap.c            | 2 +-
 net/ping6.c           | 1 -
 net/rarp.c            | 1 -
 net/sntp.c            | 1 -
 net/tcp.c             | 1 -
 net/tftp.c            | 1 -
 net/udp.c             | 1 -
 net/wget.c            | 1 -
 net/wol.c             | 1 -
 26 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/net/arp.c b/net/arp.c
index 37848ad32fbd..bc1e25f941f7 100644
--- a/net/arp.c
+++ b/net/arp.c
@@ -9,10 +9,10 @@
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <net.h>
+#include <vsprintf.h>
 #include <linux/delay.h>
 
 #include "arp.h"
diff --git a/net/bootp.c b/net/bootp.c
index c15472f5d37f..5efee7f37776 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -8,7 +8,6 @@
  *	Copyright 2000-2004 Wolfgang Denk, wd@denx.de
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <env.h>
diff --git a/net/cdp.c b/net/cdp.c
index a8f890e75226..d4cfc587ee35 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -9,7 +9,6 @@
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
  */
 
-#include <common.h>
 #include <net.h>
 
 #include "cdp.h"
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 4aea779f6f24..54619ee69836 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -7,7 +7,6 @@
 
 /* Simple DHCP6 network layer implementation. */
 
-#include <common.h>
 #include <net6.h>
 #include <malloc.h>
 #include <linux/delay.h>
diff --git a/net/dns.c b/net/dns.c
index 5b1fe5b01037..c2f0ab98c8d0 100644
--- a/net/dns.c
+++ b/net/dns.c
@@ -22,7 +22,6 @@
  * this stuff is worth it, you can buy me a beer in return.
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 3d0ec91dfa49..4e3933fd05f3 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_ETH
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index 869adf8cbbd3..6ee54e3c7901 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <command.h>
diff --git a/net/eth_common.c b/net/eth_common.c
index 14d4c07b695d..89b5bb371897 100644
--- a/net/eth_common.c
+++ b/net/eth_common.c
@@ -5,7 +5,6 @@
  * Joe Hershberger, National Instruments
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <dm.h>
 #include <env.h>
diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index 2eb52ea25679..d1fccbc72386 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2023 The Android Open Source Project
  */
 
-#include <common.h>
 #include <fastboot.h>
 #include <net.h>
 #include <net/fastboot_tcp.h>
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index 6fee441ab3b6..d1479510d61a 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 The Android Open Source Project
  */
 
-#include <common.h>
 #include <command.h>
 #include <fastboot.h>
 #include <net.h>
diff --git a/net/link_local.c b/net/link_local.c
index 8aec3c79969b..179721333ffc 100644
--- a/net/link_local.c
+++ b/net/link_local.c
@@ -11,7 +11,6 @@
  * Licensed under the GPL v2 or later
  */
 
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <net.h>
diff --git a/net/mdio-mux-uclass.c b/net/mdio-mux-uclass.c
index 94b90e065762..ee188b504d16 100644
--- a/net/mdio-mux-uclass.c
+++ b/net/mdio-mux-uclass.c
@@ -4,7 +4,6 @@
  * Alex Marginean, NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <miiphy.h>
diff --git a/net/mdio-uclass.c b/net/mdio-uclass.c
index 0ebfb2f1343a..4f052ae432c6 100644
--- a/net/mdio-uclass.c
+++ b/net/mdio-uclass.c
@@ -4,7 +4,6 @@
  * Alex Marginean, NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <eth_phy.h>
diff --git a/net/ndisc.c b/net/ndisc.c
index d1cec0601c83..d417c5987ac4 100644
--- a/net/ndisc.c
+++ b/net/ndisc.c
@@ -9,7 +9,6 @@
 
 /* Neighbour Discovery for IPv6 */
 
-#include <common.h>
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
diff --git a/net/net.c b/net/net.c
index 0fb2d2507734..23b5d3356afa 100644
--- a/net/net.c
+++ b/net/net.c
@@ -81,7 +81,6 @@
  */
 
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <console.h>
diff --git a/net/net6.c b/net/net6.c
index 2dd64c0e1618..4cff98df15cf 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -9,12 +9,12 @@
 
 /* Simple IPv6 network layer implementation */
 
-#include <common.h>
 #include <env_internal.h>
 #include <malloc.h>
 #include <net.h>
 #include <net6.h>
 #include <ndisc.h>
+#include <vsprintf.h>
 
 /* NULL IPv6 address */
 struct in6_addr const net_null_addr_ip6 = ZERO_IPV6_ADDR;
diff --git a/net/nfs.c b/net/nfs.c
index c18282448ccd..acc7106f10d4 100644
--- a/net/nfs.c
+++ b/net/nfs.c
@@ -30,7 +30,6 @@
  * September 27, 2018. As of now, NFSv3 is the default choice. If the server
  * does not support NFSv3, we fall back to versions 2 or 1. */
 
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #ifdef CONFIG_SYS_DIRECT_FLASH_NFS
diff --git a/net/pcap.c b/net/pcap.c
index 4036d8a3fa53..c959e3e4e511 100644
--- a/net/pcap.c
+++ b/net/pcap.c
@@ -3,10 +3,10 @@
  * Copyright 2019 Ramon Fried <rfried.dev@gmail.com>
  */
 
-#include <common.h>
 #include <net.h>
 #include <net/pcap.h>
 #include <time.h>
+#include <linux/errno.h>
 #include <asm/io.h>
 
 #define LINKTYPE_ETHERNET	1
diff --git a/net/ping6.c b/net/ping6.c
index 4882a17f510b..2479e08fd82f 100644
--- a/net/ping6.c
+++ b/net/ping6.c
@@ -9,7 +9,6 @@
 
 /* Simple ping6 implementation */
 
-#include <common.h>
 #include <net.h>
 #include <net6.h>
 #include "ndisc.h"
diff --git a/net/rarp.c b/net/rarp.c
index 231b6233c07a..a6b564e314d4 100644
--- a/net/rarp.c
+++ b/net/rarp.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <net.h>
diff --git a/net/sntp.c b/net/sntp.c
index dac0f8ceea1b..73d1d87d38b1 100644
--- a/net/sntp.c
+++ b/net/sntp.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <log.h>
diff --git a/net/tcp.c b/net/tcp.c
index a713e1dd6096..b0cc8a1fe3ed 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -17,7 +17,6 @@
  *                      - TCP application (eg wget)
  *      Next Step       HTTPS?
  */
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <env_internal.h>
diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492b..6b16bdcbe4c2 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -5,7 +5,6 @@
  * Copyright 2011 Comelit Group SpA,
  *                Luca Ceresoli <luca.ceresoli@comelit.it>
  */
-#include <common.h>
 #include <command.h>
 #include <display_options.h>
 #include <efi_loader.h>
diff --git a/net/udp.c b/net/udp.c
index a93822f511cd..37162260d175 100644
--- a/net/udp.c
+++ b/net/udp.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Philippe Reynes <philippe.reynes@softathome.com>
  */
 
-#include <common.h>
 #include <net.h>
 #include <net/udp.h>
 
diff --git a/net/wget.c b/net/wget.c
index abab371e58ed..f1dd7abeff69 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -6,7 +6,6 @@
 
 #include <asm/global_data.h>
 #include <command.h>
-#include <common.h>
 #include <display_options.h>
 #include <env.h>
 #include <image.h>
diff --git a/net/wol.c b/net/wol.c
index 0a625668a992..96478ba5751e 100644
--- a/net/wol.c
+++ b/net/wol.c
@@ -3,7 +3,6 @@
  * Copyright 2018 Lothar Felten, lothar.felten@gmail.com
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <net.h>
-- 
2.34.1

