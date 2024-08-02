Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16949C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E9F88BCB;
	Fri,  2 Aug 2024 15:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gGEZvHdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0DC88BBE; Fri,  2 Aug 2024 15:15:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A45E88AF0
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so72004955e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604500; x=1723209300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liNOrP4fi32OZHlw0xvVHR8PgC7suxawfXafIc8h+m8=;
 b=gGEZvHdjGiK5gaAY887fhseVo6QWLLKhFkxUEW8dff1Rh5njm0/+bvVlMY0Cp2U2vs
 YNP3Rre8ImLSBo3PqjnJb3UQwdzV30AnfLmFvbMQPR4GrkleoRfDJOGhwRoLDMb55L1V
 wWCx0HDpUrLRNzPgmn2bNLY/ipsa8SZsVMYek/IHL7ixgHGnX9UH7W5Tq0ZGHzbVpeQi
 LsJNmsDjJH6N+ZFPFLhlDgwdK0z1ocs17Ipu6YLaBaM8Rr3Wbg0CSyipY+/3117pSDr6
 1LoXQjCFaR/kZeslhWRQYgLMynGbWEvJGVIuxpbhk8Is0nFMcOKn1CDpXWGXotelcORe
 xY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604500; x=1723209300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=liNOrP4fi32OZHlw0xvVHR8PgC7suxawfXafIc8h+m8=;
 b=NEMv+y+KvRiS3PV3lwmmjmheRyX39oP6x673973KIHx24Mc3a/itF8agG/ZITLUdgG
 4wlYM10WN3uZ/2QIMR1/KTu/BAnPalT/RdswHck7uWqaPdgYmcLT0f+XO1y4CoY720U1
 ccBfXnCrjqVovaFdXxVLj5vwgnOPi0qoyZy20oMneM8Jhz32wGHzNFsnT1DyCM9vpmlI
 p8p4aohfyaBfCxkcrjUy2ffLSMKC4CCaeRytO9p7eNpLXbRnSM5EwyJFai/W85kdbLiY
 9R1SJg7/EIXDYltp84n7aPTnnxXZM+yQbAvavc1d3/Kz2wQ98RQ0etXAg571locbGXab
 gb6g==
X-Gm-Message-State: AOJu0YyhjrlIZVUnrSe5lSRO7H6oNdo4BT9pIgh1wWIIr2rpprzGietZ
 MxgZ5J67XWetBnQG5oVUpj5SAi9bhIUf/xr3hIl06Pi9F7L+x/IzYfldm1lPDntTmR/9gcif9X4
 tcNRz1GUj
X-Google-Smtp-Source: AGHT+IE3sQNsq0KtiTGSqrCQKz/Mz02JADs0/nGCHK+hEqdmaYDCbzRRQD4n/0Jnsr2pLjgmSR9DWg==
X-Received: by 2002:a5d:6945:0:b0:360:75b1:77fb with SMTP id
 ffacd0b85a97d-36bbc0e0c33mr2461037f8f.8.1722604500351; 
 Fri, 02 Aug 2024 06:15:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v6 10/20] net-lwip: add ping command
Date: Fri,  2 Aug 2024 15:13:57 +0200
Message-Id: <ef2578d4d31ae79d9f7abfbeae5f5e4957d3b14c.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index 02243138515..27d592cd853 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1993,11 +1993,6 @@ config CMD_WGET
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
@@ -2098,6 +2093,12 @@ config CMD_MDIO
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

