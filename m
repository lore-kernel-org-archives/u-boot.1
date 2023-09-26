Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1580E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D1A86D8F;
	Tue, 26 Sep 2023 11:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j8vpCJpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF8086D7D; Tue, 26 Sep 2023 11:43:52 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056EF86AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so13920060e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721429; x=1696326229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=j8vpCJpTszuKskeaCliy5IUuYbHV7oKIaoaYT8s9eeVH4iaArz4VwaQKs9oHYFtUIM
 7UuijL0eAM8Tbi1qYwQCQJt3m4WHN3rIZR7qgnAX/wqDjo2eDSikMmkNmf+h7egYO6E/
 tRBW1Pti5m135oarPyC8rDC+TMVxfepL3eyYDpMhq+y2ZA214xs+3xMZL7BHLVMRZz59
 V7wVJTpNRQRqG8yjY0A2PkXq4qanEIviKh7VgYN883wgcj7GhidVmYU8fRUscM4I4+oF
 C56USfo0gYq3TPMRNpr86tx9qKUecRJL55xb6HVhTTeZCn8fmleC6fBihD3KSxQsSEM1
 S2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721429; x=1696326229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=AKzMFFXK8RV7j719NeG7T6s0sa8Mp4AyFej7R9VC/iIKdH6aNYBj7Z99HhCbn9qCjE
 ykfaicGfC9Kfv8gbAxfzhNtbZSG3CRW3JZ9M9tdpo5Pb/kam4Qdi8H/GdQGYCQUDggua
 ts4hLTEdqPvjiamxAdkTLvQBaw93d0RAZVHPdsG67Pb2AXrEPJ4rnvH1h5mD+AweXXWX
 8+uo7nuLBSoxSuhXuOhwJbROG5gGpLI3f6LSYjzfaXu+zv18Hg8fXJTlJbwG9DZKWwis
 jBEI4zjhxd0fiGbi2Wdt9EkkI252SKgrgSoWtSQaYcTezoFYFSEOYRvt/j6AAcSXbKWN
 /WAg==
X-Gm-Message-State: AOJu0Yw/JovofsQIlOjdYeGYVZjAU9UDWiehGp+1hGFTHqAxFik2cDZ8
 WgezQjZL9ZieufhnOB6QtF2bYqxwFziViPcWg/MDhQ==
X-Google-Smtp-Source: AGHT+IGZKitUwviABTciwSknFqb5oCnfnf0kzTIbaUI0Hhb90K7B9O21cvkFJovnAMP0mgyVv9k2KA==
X-Received: by 2002:ac2:5298:0:b0:500:9a45:63b with SMTP id
 q24-20020ac25298000000b005009a45063bmr7003615lfm.13.1695721429130; 
 Tue, 26 Sep 2023 02:43:49 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:48 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 04/15] net/lwip: integrate lwIP library
Date: Tue, 26 Sep 2023 15:41:13 +0600
Message-Id: <20230926094124.7024-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

