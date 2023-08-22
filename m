Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7AFEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3E9864A8;
	Tue, 22 Aug 2023 11:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TrjO2mgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580AA864A2; Tue, 22 Aug 2023 11:38:30 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382C88648C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso41416111fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697106; x=1693301906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6f7RLIHmekK8JpCtje4OLhfP/tn1/GhDcm/uDsXsCY=;
 b=TrjO2mgnVsAIWEcyjSZs7DaIwfDaADVmBbCOveHSKDCRQmQU4nMb9b1q1q5AASA2ic
 pov0LBcmmL1iKnWl3ria83RTu7NiLWTJ6Zm7IPv2FEe54TocIs+y4taVken7wsOG54hn
 ErNNDXrL63Dw5Sgz5JaRiawLXoZiTewlRj3rM5/4sTOb/E0+5MkpSJ3u2dU3ZB0oJ5GB
 FHAGZYSYGQESJJr6/3dZBIDL6R4gszRIhkM33ZgroTa/ofQpYXqdtKO/LnPh3W4af3tr
 T6BlTarsEG3nrWMO/5HT48mQfWkl4E5M9omTpKfrpQTKUtsne1g/TQkcdfS45qF1w7/K
 zYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697106; x=1693301906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6f7RLIHmekK8JpCtje4OLhfP/tn1/GhDcm/uDsXsCY=;
 b=Y3VX53QYASdxrtpXXQgWs8eKp1Wu3+pvJCnj3Gj1bakh2m3quQ6YFPzANtpRKOLJxw
 i0TJ2DT00Q9UOiIBXWXl+RAm0TkzTgVEVwQJJNvLCIjUrNoTWVKjEy6RY1vTSJQPKfE8
 pELei7CHRlkqf7+M/Pmc2ux/HgLs49Uhs28nJDzwICSlrDXXA/0ks86D1G8KGAKlkA9R
 LdSzuqFsxvptMwlEl+r7dXYrve5Zj37dVkFJ5X2xaJqrhWjEHrljry9lZFWQlqs9eC9N
 Dy+E5KGcVqyPXupGXsLAQK5adzngRiiPNS2UFHdncm1gjvFz4zk4b/1CvJ5Db66nHNZB
 7Y/w==
X-Gm-Message-State: AOJu0YxJlljTptiXzRP6g5UY2rm/9oNE0pVxobf3CU916FX3if5y5iUp
 WBH+IQlMSG+8fiHi/F3yW16oteinpPnO98JM4zorLA==
X-Google-Smtp-Source: AGHT+IE2ylAwK9hSPoULfC3qNgjZBhSxw6IhRSsFUBqjvAbQ+1AcOzmowZ4cG0M5g8++Hpy/XF1Qrw==
X-Received: by 2002:a2e:988f:0:b0:2bc:b557:cee9 with SMTP id
 b15-20020a2e988f000000b002bcb557cee9mr5398802ljj.43.1692697106243; 
 Tue, 22 Aug 2023 02:38:26 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:26 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 02/15] net/lwip: integrate lwIP library
Date: Tue, 22 Aug 2023 15:36:01 +0600
Message-Id: <20230822093614.4717-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
 net/lwip/Kconfig  | 55 +++++++++++++++++++++++++++++++++++++++
 net/lwip/Makefile | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 net/net.c         | 20 ++++++++++++++
 5 files changed, 145 insertions(+)
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
index 0000000000..f07e26f7d9
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,55 @@
+menu "LWIP"
+config LWIP
+	bool "Support LWIP library"
+	help
+          Enable the lwIP library code with
+          all dependencies (commands are implemented with lwIP
+          library. This option is automatically enabled if CONFIG_NET=y.
+	  lwIP library (https://git.savannah.nongnu.org/git/lwip.git) provides
+          network stack and application code for U-Boot commands.
+	  Please see doc/develop/net_lwip.rst for more details.
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
+
+config LWIP_LIB_TCP
+        bool "tcp"
+        default y
+	help
+	   Compile lwIP with TCP protocol support.
+
+config LWIP_LIB_UDP
+        bool "udp"
+        default y
+	help
+	   Compile lwIP with UDP protocol support (needed for TFTP).
+
+config LWIP_LIB_DNS
+        bool "dns"
+        default y
+	help
+	   Compile lwIP with DNS protocol support.
+
+config LWIP_LIB_DHCP
+        bool "dhcp"
+        default y
+	help
+	   Compile lwIP with DHCP protocol support.
+
+config LWIP_LIB_LOOPBACK
+        bool "loopback"
+        help
+	   Increases size by 1k.
+	   Compile lwIP with loopback interface support.
+endmenu
+
+endmenu
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
new file mode 100644
index 0000000000..d1161bea78
--- /dev/null
+++ b/net/lwip/Makefile
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+
+LWIPDIR=lwip-external/src
+
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+
+obj-$(CONFIG_NET) += $(LWIPDIR)/core/init.o \
+	$(LWIPDIR)/core/def.o \
+	$(LWIPDIR)/core/dns.o \
+	$(LWIPDIR)/core/inet_chksum.o \
+	$(LWIPDIR)/core/ip.o \
+	$(LWIPDIR)/core/mem.o \
+	$(LWIPDIR)/core/memp.o \
+	$(LWIPDIR)/core/netif.o \
+	$(LWIPDIR)/core/pbuf.o \
+	$(LWIPDIR)/core/raw.o \
+	$(LWIPDIR)/core/stats.o \
+	$(LWIPDIR)/core/sys.o \
+	$(LWIPDIR)/core/altcp.o \
+	$(LWIPDIR)/core/altcp_alloc.o \
+	$(LWIPDIR)/core/altcp_tcp.o \
+	$(LWIPDIR)/core/tcp.o \
+	$(LWIPDIR)/core/tcp_in.o \
+	$(LWIPDIR)/core/tcp_out.o \
+	$(LWIPDIR)/core/timeouts.o \
+	$(LWIPDIR)/core/udp.o
+
+# IPv4
+obj-$(CONFIG_NET) += $(LWIPDIR)/core/ipv4/acd.o \
+        $(LWIPDIR)/core/ipv4/autoip.o \
+        $(LWIPDIR)/core/ipv4/dhcp.o \
+        $(LWIPDIR)/core/ipv4/etharp.o \
+        $(LWIPDIR)/core/ipv4/icmp.o \
+        $(LWIPDIR)/core/ipv4/igmp.o \
+        $(LWIPDIR)/core/ipv4/ip4_frag.o \
+        $(LWIPDIR)/core/ipv4/ip4.o \
+        $(LWIPDIR)/core/ipv4/ip4_addr.o
+# IPv6
+obj-$(CONFIG_NET) += $(LWIPDIR)/core/ipv6/dhcp6.o \
+        $(LWIPDIR)/core/ipv6/ethip6.o \
+        $(LWIPDIR)/core/ipv6/icmp6.o \
+        $(LWIPDIR)/core/ipv6/inet6.o \
+        $(LWIPDIR)/core/ipv6/ip6.o \
+        $(LWIPDIR)/core/ipv6/ip6_addr.o \
+        $(LWIPDIR)/core/ipv6/ip6_frag.o \
+        $(LWIPDIR)/core/ipv6/mld6.o \
+        $(LWIPDIR)/core/ipv6/nd6.o
+# API
+obj-$(CONFIG_NET) += $(LWIPDIR)/api/api_lib.o \
+	$(LWIPDIR)/api/api_msg.o \
+	$(LWIPDIR)/api/err.o \
+	$(LWIPDIR)/api/if_api.o \
+	$(LWIPDIR)/api/netbuf.o \
+	$(LWIPDIR)/api/netdb.o \
+	$(LWIPDIR)/api/netifapi.o \
+	$(LWIPDIR)/api/sockets.o \
+	$(LWIPDIR)/api/tcpip.o
+
+# Netdevs
+obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
+
+obj-$(CONFIG_NET) += port/if.o
+obj-$(CONFIG_NET) += port/sys-arch.o
diff --git a/net/net.c b/net/net.c
index 43abbac7c3..7f868ee516 100644
--- a/net/net.c
+++ b/net/net.c
@@ -125,6 +125,7 @@
 #endif
 #include "dhcpv6.h"
 #include "net_rand.h"
+#include <net/ulwip.h>
 
 /** BOOTP EXTENTIONS **/
 
@@ -452,7 +453,11 @@ int net_loop(enum proto_t protocol)
 #endif
 
 	bootstage_mark_name(BOOTSTAGE_ID_ETH_START, "eth_start");
+#if defined(CONFIG_LWIP)
+	if (!ulwip_enabled() || !ulwip_in_loop())
+#endif
 	net_init();
+
 	if (eth_is_on_demand_init()) {
 		eth_halt();
 		eth_set_current();
@@ -649,6 +654,16 @@ restart:
 		 */
 		eth_rx();
 
+		if (IS_ENABLED(CONFIG_LWIP) && ulwip_enabled()) {
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
@@ -1213,6 +1228,11 @@ void net_process_received_packet(uchar *in_packet, int len)
 	if (len < ETHER_HDR_SIZE)
 		return;
 
+	if (IS_ENABLED(CONFIG_LWIP) && ulwip_enabled()) {
+		ulwip_poll();
+		return;
+	}
+
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 	if (push_packet) {
 		(*push_packet)(in_packet, len);
-- 
2.30.2

