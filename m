Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00011CE7AA3
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C492988CF5;
	Fri,  6 Sep 2024 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xgp/h38X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3A988C5C; Fri,  6 Sep 2024 14:35:11 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC91B88A1B
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-371ba7e46easo1222953f8f.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626109; x=1726230909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6UoK0GW2wBAOGrWoZP36IXGwuRg6upu/HX/ki4CUrY=;
 b=Xgp/h38XG8haUeH3v2yRoONbgZB5M09bwfuywkSDcLOiv0fCPqkzevpqw3dUi8G3rm
 +kCJ7tcMIpywsbLt/K5gCcg4VNh4xnvR2u77MhpYFHmkQMD+2XaGsX6trKEFDul08JkJ
 jb78KRnr4ZdiBoWABxx5aNNb7zBP+4AUJaAFCt4ShUpycn8AjExcZM3+YI+OeIzLWJFW
 /c+L534K37zhya31SyYshg0im0YA3Jn0S1/15Ih6PmGzeWN+w9ZfbPbiKy0MQ+mbla6+
 igKmXbZDtCOMt10370SvTOo5ywM+GDNHS2Z0BQAvKt5kp/YdSetoy5vfOK2YXj9rm3IG
 0hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626109; x=1726230909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6UoK0GW2wBAOGrWoZP36IXGwuRg6upu/HX/ki4CUrY=;
 b=RxPVyWSHrKEBTzGGENgM4Udbjmef5P9LQ4pR4MjCGiX87FUoeqJL3k7X6K/cqlzz94
 zPa9E94ZoyeyJZaBx4bikkwn+P4ZTenfzxc66jr2ziFD1mfbtdk6qQlFBcSJ00RfGxYk
 UMQs3sYic4hEsFX3ZKBI9uwWD4cVg1p5PiJIFlWeUCFaHOTFxOHpmRi+6qEzLployYAl
 NyRz3do808Hi7lkePAUW2NSqT+3qIfsVLdaFPQwe6CoJANYzpX4SXadQE83COJ8SI8/C
 LVWy0/HXsl7yZjvHHADdnmtKdMx/7vxfFVjM8yYGXTQJQYQcfCKL+ckbdPT70Ls56lrw
 aYBA==
X-Gm-Message-State: AOJu0YymJqBpTen4V2WnFgkPsuevcmaWRDGRIgv3APV8lPvhkB2ua9A3
 Jou/t+ScHyIuwD0EQyWPQ4BiJYd90sP/IA0qSiRBxksPpp9iPDDS1Pn+DRmpB5nAwmv5aEO9Nvz
 p94YtjKjA
X-Google-Smtp-Source: AGHT+IFuy57OUpPXtS3TMZZomp3SqGjLEyyh1lwtTY0V8CQrFj3kP3E7lcdC3frOKKUn2sUYJWn39g==
X-Received: by 2002:adf:ab0d:0:b0:374:b31e:3b3b with SMTP id
 ffacd0b85a97d-378895c5c65mr1572961f8f.1.1725626108860; 
 Fri, 06 Sep 2024 05:35:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v10 10/25] net-lwip: add ping command
Date: Fri,  6 Sep 2024 14:33:26 +0200
Message-Id: <81528d7cde52099f1bedfef40b39f1dd90e7ca80.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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
index 6691c2d6fa6..53e03a85b12 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2008,11 +2008,6 @@ config CMD_WGET
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
@@ -2113,6 +2108,12 @@ config CMD_MDIO
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
index 37744b0e2cd..9aa371e962c 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -17,5 +17,6 @@ struct netif *net_lwip_get_netif(void);
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

