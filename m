Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672FEC52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA0988BFF;
	Fri,  2 Aug 2024 18:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xAjEdkz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E0088BE0; Fri,  2 Aug 2024 18:28:26 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4356288BCA
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso4860260f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616103; x=1723220903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6wPvdZLRRreJ8TsT+Gs5e2K2j4tRFI76KR4QnRah+A=;
 b=xAjEdkz3RbsIEEK7q7Ha5AfYOrnzFw1+dqW3jGMcqzeKC3y/PCArw6c4+gEWm4QFV4
 Rg5U3hf2zlBLeBqp3akAeTgM1uVSuaRb32Kyp9ZE8L0UlH6TPJ0cj3AgorQsGWc+M1zA
 Ukjgq0JtDxlFk+CA7maIkHaYwAXZga0iDEueYuhteU7iPE/qQ+81prQUydHst83eC7Q5
 zRwuEC9Oki8QIKVIzu4QEn0Z2vnuJPm8e6JV6z/v0jsCXnn1eXAgF9a7RyaxxAKZW8iB
 nU4rOWYL6VmU4XvHP3a0t0iKuySCbzgxeGQwYVBZ5Eg3gcBw/pUBC2gZNngiYXTDt/tM
 a+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616103; x=1723220903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6wPvdZLRRreJ8TsT+Gs5e2K2j4tRFI76KR4QnRah+A=;
 b=gNdVAj0TrX4SIqKnfbLY8m6/bm8+VOBXMG+OD56S+Uxu6n//m2Je+XiDjrgP4t6xgc
 +9PGCrNixyxq7KtjmJpPttk5LKxB0p67Ir1vaZ+csBWYiyavsdPhmfrL7neFyUddMp8o
 Mbq3XOE4dwrTj2k1sLRNz4oMMnS60He6CSb6/xVZKf9WRlHragSR59qIdSdI73iTXJeN
 XiDC+FrizzsAC0BD/2aDv43YAWANcXOnG/Mhro8YCKtCUxkCuvXDb63ZQUqNY58jqvY5
 hQab2ikK9+vtvV/PSDbb/5dTq4GAx3oxn+A3aY7TZLSUTZplSz3F9RDmTjeM02mWXLVD
 JFYw==
X-Gm-Message-State: AOJu0Yz7XqXJBfn5qZMw7kt+V8xqXDt5gJvf+h1xKmGagyhDPibHNv4X
 45ZiMxhr9gpOhJd68KTWC+697vTihIhZG3B/aeBzxiRJPeiu+3Co+QbbqRbdxKReIIfo7q5cGAK
 nvesLrF9o
X-Google-Smtp-Source: AGHT+IFe5npUKoIw8HdWsyVCjzhzlT5rWVJS9Agpbe/93fv+z7uLCGwgF/avwH3Yj+Y10GCDw4ww9g==
X-Received: by 2002:a5d:4912:0:b0:367:947a:a491 with SMTP id
 ffacd0b85a97d-36bbc110b84mr2599364f8f.26.1722616103279; 
 Fri, 02 Aug 2024 09:28:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH v7 10/20] net-lwip: add ping command
Date: Fri,  2 Aug 2024 18:26:37 +0200
Message-Id: <e665c21c0a86ae0cab81c1af3f746ffcf8d375ce.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

Add support for the the ping command with NET_LWIP. The implementation
is derived from lwIP's contrib/apps/ping/ping.c.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig        |  11 +--
 cmd/net-lwip.c     |   8 ++
 include/net-lwip.h |   1 +
 net/lwip/Makefile  |   1 +
 net/lwip/ping.c    | 177 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 net/lwip/ping.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 9a8b5926ec9..e2d55a82385 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1999,11 +1999,6 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
-config CMD_PING
-	bool "ping"
-	help
-	  Send ICMP ECHO_REQUEST to network host
-
 config CMD_PING6
 	bool "ping6"
 	depends on IPV6
@@ -2104,6 +2099,12 @@ config CMD_MDIO
 	  The MDIO interface is orthogonal to the MII interface and extends
 	  it by adding access to more registers through indirect addressing.
 
+config CMD_PING
+	bool "ping"
+	select PROT_RAW_LWIP if NET_LWIP
+	help
+	  Send ICMP ECHO_REQUEST to network host
+
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP if NET_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 80f0872bb8f..feed719beef 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -12,6 +12,14 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_PING)
+U_BOOT_CMD(
+	ping,	2,	1,	do_ping,
+	"send ICMP ECHO_REQUEST to network host",
+	"pingAddress"
+);
+#endif
+
 #if defined(CONFIG_CMD_TFTPBOOT)
 U_BOOT_CMD(
 	tftpboot,	3,	0,	do_tftpb,
diff --git a/include/net-lwip.h b/include/net-lwip.h
index cfd06726577..58640c04a7f 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -13,5 +13,6 @@ struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 4e92a101ddb..b5af37a9b18 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,4 +2,5 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
new file mode 100644
index 00000000000..8dafa25959f
--- /dev/null
+++ b/net/lwip/ping.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <lwip/icmp.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/raw.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
+
+#define PING_DELAY_MS 1000
+#define PING_COUNT 5
+/* Ping identifier - must fit on a u16_t */
+#define PING_ID 0xAFAF
+
+struct ping_ctx {
+	ip_addr_t target;
+	struct raw_pcb *pcb;
+	struct icmp_echo_hdr *iecho;
+	uint16_t seq_num;
+	bool alive;
+};
+
+static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
+		      const ip_addr_t *addr)
+{
+	struct ping_ctx *ctx = arg;
+	struct icmp_echo_hdr *iecho = ctx->iecho;
+
+	if (addr->addr != ctx->target.addr)
+		return 0;
+
+	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
+	    pbuf_remove_header(p, IP_HLEN) == 0) {
+		iecho = (struct icmp_echo_hdr *)p->payload;
+
+		if ((iecho->id == PING_ID) &&
+		    (iecho->seqno == lwip_htons(ctx->seq_num))) {
+			ctx->alive = true;
+			printf("host %s is alive\n", ipaddr_ntoa(addr));
+			pbuf_free(p);
+			return 1; /* eat the packet */
+		}
+		/* not eaten, restore original packet */
+		pbuf_add_header(p, IP_HLEN);
+	}
+
+	return 0; /* don't eat the packet */
+}
+
+static int ping_raw_init(struct ping_ctx *ctx)
+{
+	ctx->pcb = raw_new(IP_PROTO_ICMP);
+	if (!ctx->pcb)
+		return -ENOMEM;
+
+	raw_recv(ctx->pcb, ping_recv, ctx);
+	raw_bind(ctx->pcb, IP_ADDR_ANY);
+
+	return 0;
+}
+
+static void ping_raw_stop(struct ping_ctx *ctx)
+{
+	if (ctx->pcb)
+		raw_remove(ctx->pcb);
+}
+
+static void ping_prepare_echo(struct ping_ctx *ctx)
+{
+	struct icmp_echo_hdr *iecho = ctx->iecho;
+
+	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
+	ICMPH_CODE_SET(iecho, 0);
+	iecho->chksum = 0;
+	iecho->id = PING_ID;
+	iecho->seqno = lwip_htons(ctx->seq_num);
+
+	iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
+}
+
+static void ping_send_icmp(struct ping_ctx *ctx)
+{
+	struct pbuf *p;
+	size_t ping_size = sizeof(struct icmp_echo_hdr);
+
+	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
+	if (!p)
+		return;
+
+	if ((p->len == p->tot_len) && !p->next) {
+		ctx->iecho = (struct icmp_echo_hdr *)p->payload;
+		ping_prepare_echo(ctx);
+		raw_sendto(ctx->pcb, p, &ctx->target);
+	}
+
+	pbuf_free(p);
+}
+
+static void ping_send(void *arg)
+{
+	struct ping_ctx *ctx = arg;
+
+	ctx->seq_num++;
+	if (ctx->seq_num <= PING_COUNT) {
+		ping_send_icmp(ctx);
+		sys_timeout(PING_DELAY_MS, ping_send, ctx);
+	}
+}
+
+static int ping_loop(struct udevice *udev, const ip_addr_t* addr)
+{
+	struct ping_ctx ctx = {};
+	struct netif *netif;
+	int ret;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	printf("Using %s device\n", udev->name);
+
+	ret = ping_raw_init(&ctx);
+	if (ret < 0) {
+		net_lwip_remove_netif(netif);
+		return ret;
+	}
+
+	ctx.target = *addr;
+
+	ping_send(&ctx);
+
+	do {
+		sys_check_timeouts();
+		net_lwip_rx(udev, netif);
+		if (ctx.alive)
+			break;
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			break;
+		}
+	} while (ctx.seq_num <= PING_COUNT);
+
+	sys_untimeout(ping_send, &ctx);
+	ping_raw_stop(&ctx);
+
+	net_lwip_remove_netif(netif);
+
+	if (ctx.alive)
+		return 0;
+
+	printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
+	return -1;
+}
+
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	ip_addr_t addr;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (!ipaddr_aton(argv[1], &addr))
+		return CMD_RET_USAGE;
+
+	eth_set_current();
+
+	if (ping_loop(eth_get_dev(), &addr) < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
-- 
2.40.1

