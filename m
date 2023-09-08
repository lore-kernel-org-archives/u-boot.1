Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CBEEE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E6D86A6D;
	Fri,  8 Sep 2023 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tSsP4sqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B537B86A68; Fri,  8 Sep 2023 15:55:38 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9053286A40
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso37227131fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181334; x=1694786134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=tSsP4sqRmaIrrMe365hwESTQHrvGTdI8W8u/ebu9n2jM2qx5hqlu4AuIBw0vfJI5gt
 8gHm23W0zEc/8T2ICcg6eN70z4BO/Lyig7D5Yg6Rq5EVMOq7MDr2E2kzlfzxgDTPPPAt
 Pda8qPv2FgM6yhL77dFQSfC4qUz/zHBmPcgdY8+xqq5wSbZVGZd3b1/cXNuUsLQ3vRIf
 Dm7rwGF56bTZJtoeRLz9IDfnmINO1DlI/a+dCCoy5C8rStztd78kqNM2sBlCoP5cKUr1
 fm93CjqMbucPWryh3M5u31K4lzJhW+RCWqY6ZxE03DXYNBf6a1ECHE73joZUMD9wXb80
 EV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181334; x=1694786134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=T1Plz1xV7vrb0PpPpbkZfHdBcJEn5v1kk77fh+awN+InYT5tHr1Tw8ehIEvESvBpYK
 B3/QmHnPRxioHezKrc6GNYBVTqldDKtQPmyEHkql5Ld0/1CfmnOzzjXYJbJ6f0Gvy93g
 HTpIOQqGi1kS+TAgbR2c/+9zmZ5AgOmX3f3pA1BoT9eZ0LvDjulVpcALjiLRFdz4sv1z
 EJzJqCiCBQKCkly1BK6O+QP531PV5za9nX1f+LKLkXq7dWy1LYFG7PCO8nexwHC4sade
 zjKTaGoZKik+HrhvgoLNcDl6d1v+bVzqzasRIaySMaIND5zrl90XH0NCukYRtmNk/9WA
 QtpA==
X-Gm-Message-State: AOJu0YzAvmYExHcxRREQ37UKcTIRgObUO+GCnzWHgUGQ1TiXRZZOEh++
 lkRpJjc+LpuDiPP5Go3Zgopf5yIylWyO9u70tnsMuQ==
X-Google-Smtp-Source: AGHT+IHyRJq6mBaqGO67CeCF27TbVujkbjSroj8NkCKtDr71tNt1lABDHcf4j3EgbuN2SFwDFAZZwQ==
X-Received: by 2002:a2e:7a0a:0:b0:2b5:7f93:b3b0 with SMTP id
 v10-20020a2e7a0a000000b002b57f93b3b0mr1841172ljc.17.1694181334549; 
 Fri, 08 Sep 2023 06:55:34 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:34 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 02/15] net/lwip: integrate lwIP library
Date: Fri,  8 Sep 2023 19:53:07 +0600
Message-Id: <20230908135320.7066-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
 net/Kconfig       |  3 +++
 net/Makefile      |  1 +
 net/lwip/Kconfig  | 25 ++++++++++++++++++
 net/lwip/Makefile | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 net/net.c         | 20 ++++++++++++++-
 5 files changed, 112 insertions(+), 1 deletion(-)
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
index 3e2d061338..61930c244e 100644
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
index 0000000000..19f987a074
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,25 @@
+menu "lwIP"
+config LWIP
+	bool "Support LWIP library"
+	help
+	Enable the lwIP library code with
+	all dependencies (commands are implemented with lwIP
+	library. This option is automatically enabled if CONFIG_NET=y.
+	lwIP library (https://git.savannah.nongnu.org/git/lwip.git) provides
+	network stack and application code for U-Boot commands.
+	Please see doc/develop/net_lwip.rst for more details.
+
+menu "LWIP options"
+
+config LWIP_LIB_DEBUG
+	bool "enable debug"
+	default n
+
+config LWIP_LIB_NOASSERT
+	bool "disable asserts"
+	default y
+	help
+	    Disabling asserts reduces binary size by 16k.
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
diff --git a/net/net.c b/net/net.c
index 43abbac7c3..d9e566081c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -125,6 +125,7 @@
 #endif
 #include "dhcpv6.h"
 #include "net_rand.h"
+#include <net/ulwip.h>
 
 /** BOOTP EXTENTIONS **/
 
@@ -452,7 +453,9 @@ int net_loop(enum proto_t protocol)
 #endif
 
 	bootstage_mark_name(BOOTSTAGE_ID_ETH_START, "eth_start");
-	net_init();
+	if (!ulwip_enabled() || !ulwip_in_loop())
+		net_init();
+
 	if (eth_is_on_demand_init()) {
 		eth_halt();
 		eth_set_current();
@@ -649,6 +652,16 @@ restart:
 		 */
 		eth_rx();
 
+		if (ulwip_enabled()) {
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
@@ -1213,6 +1226,11 @@ void net_process_received_packet(uchar *in_packet, int len)
 	if (len < ETHER_HDR_SIZE)
 		return;
 
+	if (ulwip_enabled()) {
+		ulwip_poll();
+		return;
+	}
+
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 	if (push_packet) {
 		(*push_packet)(in_packet, len);
-- 
2.30.2

