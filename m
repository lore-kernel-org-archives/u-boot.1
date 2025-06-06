Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC18C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B1B82B18;
	Fri,  6 Jun 2025 08:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rUBV1uot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1D9803DF; Fri,  6 Jun 2025 08:42:31 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC20803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a510432236so1351742f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192148; x=1749796948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hObdKgzLhPbT1YUCiTVtdT4NqReLZaHxWJZV/E5DEs0=;
 b=rUBV1uots1h1N4xEqQZIJs1Rm5midkjPyvEUQ1GpjRWXwGyB7PoOeijq3y3pvw+2jH
 teOLLqchyXTBUFNpp/qu1GS1NOhCzRXFMkIQON15LZ5YFEqS9iHzw3X3Cw8EEpZr8hLa
 Bcr56vFZDKYcpus+8IRfjY+WT/72iTdxFmFOVgC8o+S237UlWfBGAnU91N/+hHWUaLhx
 XHVXRQDb+Wp6DOC8vhlBXF+7JzgeoWCNfFw2G9ld95DwaPHNaAAiJDpeYG/wxUkUuMxB
 ClKVUbhO9s0sFGWJmowXlpM9NDMxOUmY0TjeW4W/IAx6WISeo53eYmexTgTa7Ak2FltO
 gm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192148; x=1749796948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hObdKgzLhPbT1YUCiTVtdT4NqReLZaHxWJZV/E5DEs0=;
 b=t+5ZlLbsNgCt/HdNK7Qr9hZHnNsFxdZ2IN1tv0G6i77XwvZh3qwuPdbWLqiN2e1eyA
 en3hZJv4k1YsX8c8CcTmviRHdlCMDdLP8NeZ2wbwRxtL50YNt+BK6nCYN+Hsl1EZ8AVA
 s5U973am2e+oqmRIeUZqZUAeFhhcEErhiKUqolmI5KbwxZwKxaJizFH6upM9UohgXmK1
 t+qY3J2JtWD34sdQMQ1931F4DonqHKYeRM0THX7VH6t9/vFC4S+dMtLtmE83MTm7mBO2
 HVhiPXM7nIwddiJkJV4hXVF+yNLfJ/IHT63kZwv89JaQTh6ktWui5sEZCTFewwXSRN4u
 hKmQ==
X-Gm-Message-State: AOJu0YxJp39+AjUVaVzipr50/0ET4n73Bwowmcc8+GoApBLNJRtbPwD1
 aU+lXyrZf+Pvgv47BXqRxbOssOZeUUoTpOEVa71xJo925MjOuNoQ3/H8Xz2m+4y8GScCxwYJjv7
 R5TES
X-Gm-Gg: ASbGncv1TsnbO0AeRtjCvpYWCQ8n6OWJB0Xkqc4OmKKJb468KZa7zRWiH3cvuFykoQL
 LlTxOPdLxWkKC7LFJf1vrDqkCdrzhjGqvds3LX1FMXhdaC1wmdmRqju2kP42J53AyT7j0ekI0nZ
 4fNmQZDk5rnQS3gHMTiZyozTvxpqFVX6gfgOSa3sMq2IrFjbDGDO/wnG2nvuprMDVKcZeRAhBJ1
 KtpJQgt1b49z6eH7QNMTOltWz1iTbQ5ByKjqL2JRkV5mc7Ozrk++n57CrfsZXvrU4Dyad674Sbh
 IZBjF975RnSCI4f9nGGVzfjaE1d/DV9cv9JDJoxQ4DM4FSmDY0NqTFzvN6QukmHQaBYZwSw=
X-Google-Smtp-Source: AGHT+IH6jce6KAWQF8Quo/IE5Fhwtqy1MO+EIBtHmvk45H2jj0RhziRS5ahlKTamYpgNOR85m40D0g==
X-Received: by 2002:a05:6000:430c:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3a531ce75b5mr1819319f8f.53.1749192148362; 
 Thu, 05 Jun 2025 23:42:28 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:28 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/13] lwip: move net/lwip/ping.c to cmd/lwip
Date: Fri,  6 Jun 2025 08:41:41 +0200
Message-ID: <20250606064211.3091237-6-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Move the implementation of the ping command under cmd/.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 cmd/lwip/ping.c   | 175 ++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/Makefile |   1 -
 net/lwip/ping.c   | 180 ----------------------------------------------
 3 files changed, 175 insertions(+), 181 deletions(-)
 delete mode 100644 net/lwip/ping.c

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index af5c022f55f..21931821521 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -2,7 +2,182 @@
 /* Copyright (C) 2024-2025 Linaro Ltd. */
 
 #include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <lwip/icmp.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/raw.h>
+#include <lwip/timeouts.h>
 #include <net.h>
+#include <time.h>
 
 U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
 	   "pingAddress");
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
+	u16 seq_num;
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
+		if (iecho->id == PING_ID &&
+		    iecho->seqno == lwip_htons(ctx->seq_num)) {
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
+	if (p->len == p->tot_len && !p->next) {
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
+static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
+{
+	struct ping_ctx ctx = {};
+	struct netif *netif;
+	int ret;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -ENODEV;
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
+restart:
+	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
+		if (net_start_again() == 0)
+			goto restart;
+		else
+			return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 255c7d018b0..97299d9b542 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,7 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
-obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
diff --git a/net/lwip/ping.c b/net/lwip/ping.c
deleted file mode 100644
index d8042ceecf9..00000000000
--- a/net/lwip/ping.c
+++ /dev/null
@@ -1,180 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright (C) 2024 Linaro Ltd. */
-
-#include <command.h>
-#include <console.h>
-#include <dm/device.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <lwip/icmp.h>
-#include <lwip/inet_chksum.h>
-#include <lwip/raw.h>
-#include <lwip/timeouts.h>
-#include <net.h>
-#include <time.h>
-
-#define PING_DELAY_MS 1000
-#define PING_COUNT 5
-/* Ping identifier - must fit on a u16_t */
-#define PING_ID 0xAFAF
-
-struct ping_ctx {
-	ip_addr_t target;
-	struct raw_pcb *pcb;
-	struct icmp_echo_hdr *iecho;
-	uint16_t seq_num;
-	bool alive;
-};
-
-static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
-		      const ip_addr_t *addr)
-{
-	struct ping_ctx *ctx = arg;
-	struct icmp_echo_hdr *iecho = ctx->iecho;
-
-	if (addr->addr != ctx->target.addr)
-		return 0;
-
-	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
-	    pbuf_remove_header(p, IP_HLEN) == 0) {
-		iecho = (struct icmp_echo_hdr *)p->payload;
-
-		if (iecho->id == PING_ID &&
-		    iecho->seqno == lwip_htons(ctx->seq_num)) {
-			ctx->alive = true;
-			printf("host %s is alive\n", ipaddr_ntoa(addr));
-			pbuf_free(p);
-			return 1; /* eat the packet */
-		}
-		/* not eaten, restore original packet */
-		pbuf_add_header(p, IP_HLEN);
-	}
-
-	return 0; /* don't eat the packet */
-}
-
-static int ping_raw_init(struct ping_ctx *ctx)
-{
-	ctx->pcb = raw_new(IP_PROTO_ICMP);
-	if (!ctx->pcb)
-		return -ENOMEM;
-
-	raw_recv(ctx->pcb, ping_recv, ctx);
-	raw_bind(ctx->pcb, IP_ADDR_ANY);
-
-	return 0;
-}
-
-static void ping_raw_stop(struct ping_ctx *ctx)
-{
-	if (ctx->pcb)
-		raw_remove(ctx->pcb);
-}
-
-static void ping_prepare_echo(struct ping_ctx *ctx)
-{
-	struct icmp_echo_hdr *iecho = ctx->iecho;
-
-	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
-	ICMPH_CODE_SET(iecho, 0);
-	iecho->chksum = 0;
-	iecho->id = PING_ID;
-	iecho->seqno = lwip_htons(ctx->seq_num);
-
-	iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
-}
-
-static void ping_send_icmp(struct ping_ctx *ctx)
-{
-	struct pbuf *p;
-	size_t ping_size = sizeof(struct icmp_echo_hdr);
-
-	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
-	if (!p)
-		return;
-
-	if (p->len == p->tot_len && !p->next) {
-		ctx->iecho = (struct icmp_echo_hdr *)p->payload;
-		ping_prepare_echo(ctx);
-		raw_sendto(ctx->pcb, p, &ctx->target);
-	}
-
-	pbuf_free(p);
-}
-
-static void ping_send(void *arg)
-{
-	struct ping_ctx *ctx = arg;
-
-	ctx->seq_num++;
-	if (ctx->seq_num <= PING_COUNT) {
-		ping_send_icmp(ctx);
-		sys_timeout(PING_DELAY_MS, ping_send, ctx);
-	}
-}
-
-static int ping_loop(struct udevice *udev, const ip_addr_t *addr)
-{
-	struct ping_ctx ctx = {};
-	struct netif *netif;
-	int ret;
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return -ENODEV;
-
-	printf("Using %s device\n", udev->name);
-
-	ret = ping_raw_init(&ctx);
-	if (ret < 0) {
-		net_lwip_remove_netif(netif);
-		return ret;
-	}
-
-	ctx.target = *addr;
-
-	ping_send(&ctx);
-
-	do {
-		sys_check_timeouts();
-		net_lwip_rx(udev, netif);
-		if (ctx.alive)
-			break;
-		if (ctrlc()) {
-			printf("\nAbort\n");
-			break;
-		}
-	} while (ctx.seq_num <= PING_COUNT);
-
-	sys_untimeout(ping_send, &ctx);
-	ping_raw_stop(&ctx);
-
-	net_lwip_remove_netif(netif);
-
-	if (ctx.alive)
-		return 0;
-
-	printf("ping failed; host %s is not alive\n", ipaddr_ntoa(addr));
-	return -1;
-}
-
-int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	ip_addr_t addr;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	if (!ipaddr_aton(argv[1], &addr))
-		return CMD_RET_USAGE;
-
-restart:
-	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
-		if (net_start_again() == 0)
-			goto restart;
-		else
-			return CMD_RET_FAILURE;
-	}
-
-	return CMD_RET_SUCCESS;
-}
-- 
2.43.0

