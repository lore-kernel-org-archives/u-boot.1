Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC001EEAA55
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5268086A43;
	Thu, 14 Sep 2023 18:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LCdS3Wfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D310786672; Thu, 14 Sep 2023 18:20:45 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F4F869AC
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bfc8c02e82so14869361fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708442; x=1695313242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=LCdS3WfuEtpd6hKfMCBrQ4wcmzlxmPYEiPlJc8Z9GLOBM4fw7tqoSMAFk8IH2JjgSS
 tklPxxrdIo2Yb+zV5mD0hhsQOd6p6ii38du1/iUz+whwSvnWice9HIsV7BsQs7KyvgKN
 JMw1UcSj0GG3LO4RH9c8GNxD1OznA5Ep51b9xmSDAuSrCvSw0v7p3aROpoO6tGe90RbX
 lCIR9S6jWWf/PgVxIvCZ6O/T1xeBkqSh3tZHP5SJM4xJeLkwZyPm8wTfrcHJanl/zGnL
 JsmNhtDIWz50m/rsW2fD9gVtyiUZWEoWghjDT0t/5PXYyrKpqXXyH2YHgunAvDDfG43E
 HrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708442; x=1695313242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZWczJJ29oeFznXyVz4JvMIzBmThqxBGAsYRNpDOANo=;
 b=wfy2YrZ1ljOXcqyiTjQcMN4hDVLaE0ALqJw9LTK92+wG7XZDQDtp/KHFboY3cDejXV
 WouVS82Xh5RGBNYShXBoxTJnSYYu2njOYHCw+ZgvUun3Lyx4HDfpFSEi8axg0hS38sjR
 TLNEie/4CNEqFfIN7cIyGY5fc8s679dQXXAe8nMhYyOm0jFysnh7dEv6nqAQYqkvMlSs
 fdysLENqbgMCL0gtHMqiW76Tq26SIacJro32S0/YIYs/7IeTbjZoKs/WACdhauerRsBT
 CuniOhQy1Ub8Jj1YyU+zXhQbN8jscc4/W59LJj6iOYblAo3hj+fwLX4au69LRPMUfb5W
 OB5w==
X-Gm-Message-State: AOJu0YxwA4kiJDhmxQLbyrbICgQhvtYEDQE027nH9zp0KfMeczALw4Yv
 sAtQCmmiGgWUfArovsWlKVk8Wm7Fhp5093+6q4GJoA==
X-Google-Smtp-Source: AGHT+IF+md0WWQPdjmOHkg48twBMKM3VFgwQSQWu5VfQ9zRWdSrNuIiW+aqKPKokbG6+MUCYVH2S2g==
X-Received: by 2002:a2e:9dc2:0:b0:2bf:ac97:df26 with SMTP id
 x2-20020a2e9dc2000000b002bfac97df26mr5198357ljj.25.1694708442643; 
 Thu, 14 Sep 2023 09:20:42 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:42 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 03/15] net/lwip: integrate lwIP library
Date: Thu, 14 Sep 2023 22:18:16 +0600
Message-Id: <20230914161828.3662-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

