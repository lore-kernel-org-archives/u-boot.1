Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1018C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1D088D4D;
	Wed,  7 Aug 2024 19:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w71mq0D6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E7888D44; Wed,  7 Aug 2024 19:13:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842C687873
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-428119da952so775055e9.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050795; x=1723655595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOmsSXS08sF0OcQZkL4LJBt/O56FWaK33ak+u6PKiV8=;
 b=w71mq0D6zP7LY7uWFGPPn8MyjVhYJ+IeSKzG0WRxs/a3SUGfGVBsqlatpnDdW9eCjU
 z1tYr5hMVmtA0OjOWZL5DP/GbESMP5tGyQWhdnVMCtW1eqfCDvv63HYPWQA1yjBBMIfX
 1orGT6AeXAMX2SS1QBzve7nsyq+p2jdQuVTsYIUvejFBYDW25ESyZsUIke2eZlbB+buG
 WQ37LUoG4kx48flLhENVw56fKa5klTX+xgm/+AmnpLUCRA7aTuUEnWdKHJfqzYqNARB8
 B3iKYUJ9uQwjzqYsqHqeGquAKL4VyEfClRSavPEWcNYsvF7ZlBfgzlVobqESe+sapKmb
 w+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050795; x=1723655595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOmsSXS08sF0OcQZkL4LJBt/O56FWaK33ak+u6PKiV8=;
 b=Y5Na29D8AJSliLif4Bti5LY0afMbJqFXqv6qSCrLyUX3RVkByL9SaWFtRTVyxf7i+X
 lPIB1fzW2Ogc+vhD5b3qVpqk5Dzm//OXas63Bz7B2TMI09vVVs66X5Kti8J1XQGLYMpb
 bgvfeanswUw2a9EfA9MsE86Z8OLEGu0ZXM8qM5xI3xQ35gAMy4zGkK5rZ9YFgBCUMEYH
 oWKoESXD7uLRzSp9FNuxfVnhM3LZlUjedQ1dEv0VWlNcPIE0BPZb0G1AOk8JryBcWYni
 YisNPRoymA78hxjgKh2GWR0QDq1U1DCoNkKei5SDg/j92MYducJenMPomSE7K8sfERFV
 DKaA==
X-Gm-Message-State: AOJu0Yzi4zHhBEBiMW8yrlUDuJF4H7cgQQMIw7uuSpq6rAwsqit1OY4b
 R1jZguQVuTuapfCYjK1hsneYs0EysWEJhguhxXbSKM5ScyJhWcU6HABAxKC2KWyShNKwS/9p8yz
 wPAcTbPiW
X-Google-Smtp-Source: AGHT+IFe+cJnYeB/l4Siej1tiROHsEUNzTr2sseJzMAuLNXI4WC/3Ka6HrmxTHjWxDcVHIEWuOk8eg==
X-Received: by 2002:a05:600c:4fc9:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-428e6b2f79fmr145310055e9.20.1723050794746; 
 Wed, 07 Aug 2024 10:13:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:14 -0700 (PDT)
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
Subject: [PATCH v8 12/23] net-lwip: add ping command
Date: Wed,  7 Aug 2024 19:11:56 +0200
Message-Id: <af521221eef071f1f0309eb8551a09aa356eb307.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
index fd841cd4e53..844f3d25c4e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2000,11 +2000,6 @@ config CMD_WGET
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
@@ -2105,6 +2100,12 @@ config CMD_MDIO
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

