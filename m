Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5468EC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FD58754D;
	Mon, 27 Nov 2023 14:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G0Zbb2Kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C617187515; Mon, 27 Nov 2023 14:00:22 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B38587515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50aab20e828so5951066e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090015; x=1701694815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Am6ez1WrIYIpKk0zuBnm3QiH1AVPiHMx/qG6Y41M3wc=;
 b=G0Zbb2Kpf04px7P33s28ZHSHA2m03wVu0bxQ2ioLnlqSk85i8FZuzMhYoSN3yO1fih
 GnvpZUzg4BG32jMFqvDj2l3UIhhB45qvfM9buwEIPs4oLrEjS7gcZhywQWQkGxwV4vMy
 NgPmntfmGForv/Hm1EHCN+NAGi/xpYIfwwmWGb9ItuO1L3pjL1HyTa4L81gzXT03e0Vl
 YcnrCBxc4uV3a7slYFr0JwHLiJkaqAm0zAPNLr26ecvThscYIy+vGpIGXLpsNO/IMJRA
 qJMf8RyhCQKXsX7hn8yv9dAN426fUrexqjkbSYdlRRvPli9VuuXNJBiWxQvQvmFvluyc
 9PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090015; x=1701694815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Am6ez1WrIYIpKk0zuBnm3QiH1AVPiHMx/qG6Y41M3wc=;
 b=fvGjdrdivaIN3IYSMCdJr6KFPN8C3tGf3m7E4RGSmAS+D00zW/rZvj4z13wlDoTgNU
 anDK17r4FT+NwPGcQ17joEQkDwANCwPt8WJM+7beAZa7/8pNIJfrVVx0sUiqNDwQioXg
 LN38ElUwBFEZPbw10BCgJHJWCsq8m6JV0+ip0xVCMXwYdn/195X9NHeuuH9ENBQeQ0Pb
 eXOwHuvuKDCFhkrqXQnn6LddanPKFy23UWd3eoBRWZVGlMZNEjMDTRa21Gm9nAaxGVs6
 me/8bIMFx8pQl170wQSRak6FGfMMO2/avEEN84/s5BmQrZ4Y8w+9ZWd5p9NKGFhMkMDs
 IImQ==
X-Gm-Message-State: AOJu0YztpCApYYJv1uBKe9KoD4FuOoGcB4PycWc5MIYpZg9Wq5Atg9ZU
 hs3WanmGFAt9nUBDsr1Q47D9IRVslrUTfcoQeQnV0A==
X-Google-Smtp-Source: AGHT+IFNhzfksAIVpTtGnodDdXh13l6KZxjQ3jvSxBQ88D4faFUvaBWFyUMfmbITOcUiJzOGOEonyg==
X-Received: by 2002:a05:6512:23a7:b0:500:a66b:b189 with SMTP id
 c39-20020a05651223a700b00500a66bb189mr6721791lfv.51.1701090015615; 
 Mon, 27 Nov 2023 05:00:15 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:15 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 03/43] net/lwip: integrate lwIP library
Date: Mon, 27 Nov 2023 18:56:46 +0600
Message-Id: <20231127125726.3735-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Define Makefile and Kconfig to build lwIP inside the U-Boot. We compile
lwIP the same as the main code, plus we can do optimization for size at
compile time with disabling not needed debug asserts, or not used protocols.
So we can tune lwIP configuration specially for U-Boot environments.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/Kconfig            |  3 ++
 net/Makefile           |  1 +
 net/lwip/Kconfig       | 33 ++++++++++++++++++++++
 net/lwip/Makefile      | 64 ++++++++++++++++++++++++++++++++++++++++++
 net/lwip/lwip-external |  2 +-
 net/net.c              | 44 ++++++++++++++++++++++-------
 6 files changed, 136 insertions(+), 11 deletions(-)
 create mode 100644 net/lwip/Kconfig
 create mode 100644 net/lwip/Makefile

diff --git a/net/Kconfig b/net/Kconfig
index 4215889127..34c1e43c87 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -5,9 +5,12 @@
 menuconfig NET
 	bool "Networking support"
 	default y
+	imply LWIP
 
 if NET
 
+source net/lwip/Kconfig
+
 config ARP_TIMEOUT
 	int "Milliseconds before trying ARP again"
 	default 5000
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740..bda6b383b5 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_LWIP) += lwip/
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
new file mode 100644
index 0000000000..295261a042
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,33 @@
+menu "lwIP"
+config LWIP
+	bool "Support LWIP library"
+	help
+	  Enable the lwIP library code with
+	  all dependencies (commands are implemented with lwIP
+	  library. This option is automatically enabled if CONFIG_NET=y.
+	  lwIP library (https://git.savannah.nongnu.org/git/lwip.git) provides
+	  network stack and application code for U-Boot commands.
+	  Please see doc/develop/net_lwip.rst for more details.
+
+menu "LWIP options"
+
+config LWIP_LIB_DEBUG
+	bool "enable debug"
+	default n
+	help
+	  Enable DEBUG information for IP stack.
+	  File net/lwip/lwipopts.h can be modified
+	  to enable specific debug message like
+	  raw packets or IP debug.
+
+config LWIP_LIB_NOASSERT
+	bool "disable asserts"
+	default y
+	help
+	  Disabling asserts reduces binary size by 16k.
+          lwIP assers are useful for testing, but for
+	  the production code we can fight for the size
+	  and reduce it with compile out asserts.
+endmenu
+
+endmenu
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
new file mode 100644
index 0000000000..3fd5d34564
--- /dev/null
+++ b/net/lwip/Makefile
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+
+obj-$(CONFIG_NET) += lwip-external/src/core/init.o \
+	lwip-external/src/core/def.o \
+	lwip-external/src/core/dns.o \
+	lwip-external/src/core/inet_chksum.o \
+	lwip-external/src/core/ip.o \
+	lwip-external/src/core/mem.o \
+	lwip-external/src/core/memp.o \
+	lwip-external/src/core/netif.o \
+	lwip-external/src/core/pbuf.o \
+	lwip-external/src/core/raw.o \
+	lwip-external/src/core/stats.o \
+	lwip-external/src/core/sys.o \
+	lwip-external/src/core/altcp.o \
+	lwip-external/src/core/altcp_alloc.o \
+	lwip-external/src/core/altcp_tcp.o \
+	lwip-external/src/core/tcp.o \
+	lwip-external/src/core/tcp_in.o \
+	lwip-external/src/core/tcp_out.o \
+	lwip-external/src/core/timeouts.o \
+	lwip-external/src/core/udp.o
+
+# IPv4
+obj-$(CONFIG_NET) += lwip-external/src/core/ipv4/acd.o \
+        lwip-external/src/core/ipv4/autoip.o \
+        lwip-external/src/core/ipv4/dhcp.o \
+        lwip-external/src/core/ipv4/etharp.o \
+        lwip-external/src/core/ipv4/icmp.o \
+        lwip-external/src/core/ipv4/igmp.o \
+        lwip-external/src/core/ipv4/ip4_frag.o \
+        lwip-external/src/core/ipv4/ip4.o \
+        lwip-external/src/core/ipv4/ip4_addr.o
+# IPv6
+obj-$(CONFIG_NET) += lwip-external/src/core/ipv6/dhcp6.o \
+        lwip-external/src/core/ipv6/ethip6.o \
+        lwip-external/src/core/ipv6/icmp6.o \
+        lwip-external/src/core/ipv6/inet6.o \
+        lwip-external/src/core/ipv6/ip6.o \
+        lwip-external/src/core/ipv6/ip6_addr.o \
+        lwip-external/src/core/ipv6/ip6_frag.o \
+        lwip-external/src/core/ipv6/mld6.o \
+        lwip-external/src/core/ipv6/nd6.o
+# API
+obj-$(CONFIG_NET) += lwip-external/src/api/api_lib.o \
+	lwip-external/src/api/api_msg.o \
+	lwip-external/src/api/err.o \
+	lwip-external/src/api/if_api.o \
+	lwip-external/src/api/netbuf.o \
+	lwip-external/src/api/netdb.o \
+	lwip-external/src/api/netifapi.o \
+	lwip-external/src/api/sockets.o \
+	lwip-external/src/api/tcpip.o
+
+# Netdevs
+obj-$(CONFIG_NET) += lwip-external/src/netif/ethernet.o
+
+obj-$(CONFIG_NET) += port/if.o
+obj-$(CONFIG_NET) += port/sys-arch.o
diff --git a/net/lwip/lwip-external b/net/lwip/lwip-external
index 0a0452b2c3..5e3268cf3e 160000
--- a/net/lwip/lwip-external
+++ b/net/lwip/lwip-external
@@ -1 +1 @@
-Subproject commit 0a0452b2c39bdd91e252aef045c115f88f6ca773
+Subproject commit 5e3268cf3ea16ed4907a55e167fcf7e2b544fb20
diff --git a/net/net.c b/net/net.c
index 0fb2d25077..038ccd8933 100644
--- a/net/net.c
+++ b/net/net.c
@@ -125,6 +125,7 @@
 #endif
 #include "dhcpv6.h"
 #include "net_rand.h"
+#include <net/ulwip.h>
 
 /** BOOTP EXTENTIONS **/
 
@@ -393,7 +394,7 @@ static void net_cleanup_loop(void)
 	net_clear_handlers();
 }
 
-int net_init(void)
+void eth_init_rings(void)
 {
 	static int first_call = 1;
 
@@ -409,6 +410,17 @@ int net_init(void)
 			net_rx_packets[i] = net_tx_packet +
 				(i + 1) * PKTSIZE_ALIGN;
 		}
+		/* Only need to setup buffer pointers once. */
+		first_call = 0;
+	}
+}
+
+int net_init(void)
+{
+	static int first_call = 1;
+
+	eth_init_rings();
+	if (first_call) {
 		arp_init();
 		ndisc_init();
 		net_clear_handlers();
@@ -453,16 +465,18 @@ int net_loop(enum proto_t protocol)
 
 	bootstage_mark_name(BOOTSTAGE_ID_ETH_START, "eth_start");
 	net_init();
-	if (eth_is_on_demand_init()) {
-		eth_halt();
-		eth_set_current();
-		ret = eth_init();
-		if (ret < 0) {
+	if (!ulwip_active()) {
+		if (eth_is_on_demand_init()) {
 			eth_halt();
-			return ret;
+			eth_set_current();
+			ret = eth_init();
+			if (ret < 0) {
+				eth_halt();
+				return ret;
+			}
+		} else {
+			eth_init_state_only();
 		}
-	} else {
-		eth_init_state_only();
 	}
 
 restart:
@@ -633,7 +647,7 @@ restart:
 	 */
 	for (;;) {
 		schedule();
-		if (arp_timeout_check() > 0)
+		if (!ulwip_active() && (arp_timeout_check() > 0))
 			time_start = get_timer(0);
 
 		if (IS_ENABLED(CONFIG_IPV6)) {
@@ -649,6 +663,16 @@ restart:
 		 */
 		eth_rx();
 
+		if (ulwip_active()) {
+			net_set_state(NETLOOP_CONTINUE);
+			if (!ulwip_in_loop()) {
+				if (ulwip_app_get_err())
+					net_set_state(NETLOOP_FAIL);
+				else
+					net_set_state(NETLOOP_SUCCESS);
+				goto done;
+			}
+		}
 		/*
 		 *	Abort if ctrl-c was pressed.
 		 */
-- 
2.30.2

