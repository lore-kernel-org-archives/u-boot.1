Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE6C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437B9888B5;
	Fri, 24 May 2024 18:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LluGMCPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E67B888D6; Fri, 24 May 2024 18:22:19 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC8A8888B2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-354f51ac110so2723264f8f.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567736; x=1717172536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPSo6ax9gRpD4wFrRQ8eVep44TzYcZH73cIZqamJ2Y8=;
 b=LluGMCPJ1yAuEdr1hO0CeQODkJbWip2LgHeSEkVSLcS0UBE0EFjcEa7G6cvoDHpgLu
 myehcaVYi7g+Zco9SZBaN5yeX0Bg5ZpLRGSpCNJT9/SXX/kqM+kw96laYLq88Jt5gNCv
 e0n/hxWbvmImFMtDsFQ2+GtSfPtXppGUWyfo7twe+ztF1aR0ANIgg26E5efOER+ZK+6R
 FqSllx75BGTZ1wcfBK+/gqAULpZpX58kQWsOVrGFUj9ouhhBELkz40iWuXNnEzFQAbuh
 Wtwf9XIRQME834QZKmgWBGPrX3nIu3X3Tc0XJ5yJel/nHaUqLJiC1gFBlxXsa5pIwxbr
 YlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567736; x=1717172536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPSo6ax9gRpD4wFrRQ8eVep44TzYcZH73cIZqamJ2Y8=;
 b=lfmsJCcginAG8fe2mGHalwotx+tNKKVHVaFfVvlktSoHt0PpWvq6kOMUU5ZZjH8KEM
 78BShcTbM9FJ8AXljWGLCG+cOvcfAsNeUbpbuHg9wwZvwYRlP10L52ij/4MnFWQFrbRn
 n+3td36ppmm6+9wDzWhhBWGoWtM+oawn5tdzmy7FgewmUaDiUjwvDm71c8n+iGRioq75
 6dBUnLEXmOw+YgkEOwPBUFLhv4dsab3DDeInB6obMRx//Ouz1Oe+7wX3hre8vJqqmnAR
 MO7cPir/wbmOXkJXm2C6DWIl1Vo39ACw8dabmw/LiRzN4z5K5a6d1foQpKjUCtVTqJ+M
 y6zA==
X-Gm-Message-State: AOJu0YyrcIFoHysXamCN49ylt3iDl1vBhkegrayRk4Z6mbEGhxx0jOXf
 M7HQfKhsBo3nkmA5LbZ0ybVRiVBDLO7FieOmXaLM/Ao3Y57DJIRwu2iaXbSHdV0GCxpnpAS7jSA
 s3NeCcObx
X-Google-Smtp-Source: AGHT+IF8oyu8MoWy2JpnPJt/jPzb2YN+aMPfV3aRz0R0770s0GqHjAvTBgtJp8Cw1nkKiyP+/VLc8Q==
X-Received: by 2002:a5d:5254:0:b0:355:1bf:98c7 with SMTP id
 ffacd0b85a97d-3552fda9edcmr2272816f8f.34.1716567736014; 
 Fri, 24 May 2024 09:22:16 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 06/14] net-lwip: add ping command
Date: Fri, 24 May 2024 18:20:00 +0200
Message-Id: <284076d79cd331cf1a4923e0cea32fefc4c14fba.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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
 boot/Kconfig       |   2 +-
 cmd/Kconfig        |   6 ++
 cmd/net-lwip.c     |   8 +++
 include/net-lwip.h |   3 +
 net-lwip/Makefile  |   1 +
 net-lwip/ping.c    | 171 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 net-lwip/ping.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 004e69dd92a..983a284ec52 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -379,7 +379,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_FS_GENERIC
 	select CMD_PART if PARTITIONS
 	select CMD_DHCP if CMD_NET || CMD_NET_LWIP
-	select CMD_PING if CMD_NET
+	select CMD_PING if CMD_NET || CMD_NET_LWIP
 	select CMD_PXE if CMD_NET
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 94a8de266f6..07cfe824e3f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2098,6 +2098,12 @@ config CMD_DHCP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_PING
+	bool "ping"
+	select PROT_RAW_LWIP
+	help
+	  Send ICMP ECHO_REQUEST to network host
+
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 490a2e4ac5c..13856703fcf 100644
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
index 2308703e46b..2abaaa3b4e3 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -5,6 +5,7 @@
 
 #include <asm/cache.h>
 #include <linux/types.h>
+#include <lwip/ip_addr.h>
 #include <lwip/netif.h>
 #include <time.h>
 
@@ -50,6 +51,7 @@ int eth_env_get_enetaddr_by_index(const char *base_name, int index,
 int eth_init(void);			/* Initialize the device */
 int eth_send(void *packet, int length);	   /* Send a packet */
 int eth_rx(void);
+const char *eth_get_name(void);
 int eth_get_dev_index(void);
 int eth_init_state_only(void); /* Set active state */
 void eth_set_current(void);		/* set nterface to ethcur var */
@@ -80,6 +82,7 @@ int net_lwip_init(void);
 struct netif *net_lwip_get_netif(void);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
index a56c32bfa74..e68d4e24197 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 
 # Disable this warning as it is triggered by:
diff --git a/net-lwip/ping.c b/net-lwip/ping.c
new file mode 100644
index 00000000000..763a9bb1e38
--- /dev/null
+++ b/net-lwip/ping.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <lwip/icmp.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/raw.h>
+#include <lwip/timeouts.h>
+#include <net-lwip.h>
+#include <time.h>
+
+#define PING_DELAY_MS 1000
+#define PING_TIMEOUT_MS 10000
+/* Additional data size to include in the packet */
+#define PING_DATA_SIZE 32
+/* Ping identifier - must fit on a u16_t */
+#define PING_ID 0xAFAF
+
+static const ip_addr_t *ping_target;
+static struct raw_pcb *ping_pcb;
+static u16_t ping_seq_num;
+static bool ping_target_alive;
+
+static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
+		      const ip_addr_t *addr)
+{
+	struct icmp_echo_hdr *iecho;
+
+	if (addr->addr != ping_target->addr)
+		return 0;
+
+	if ((p->tot_len >= (IP_HLEN + sizeof(struct icmp_echo_hdr))) &&
+	    pbuf_remove_header(p, IP_HLEN) == 0) {
+		iecho = (struct icmp_echo_hdr *)p->payload;
+
+		if ((iecho->id == PING_ID) &&
+		    (iecho->seqno == lwip_htons(ping_seq_num))) {
+			ping_target_alive = true;
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
+static int ping_raw_init(void)
+{
+	ping_pcb = raw_new(IP_PROTO_ICMP);
+	if (!ping_pcb)
+		return -ENOMEM;
+
+	raw_recv(ping_pcb, ping_recv, NULL);
+	raw_bind(ping_pcb, IP_ADDR_ANY);
+
+	return 0;
+}
+
+static void ping_raw_stop(void)
+{
+	if (ping_pcb != NULL) {
+		raw_remove(ping_pcb);
+		ping_pcb = NULL;
+	}
+}
+
+static void ping_prepare_echo(struct icmp_echo_hdr *iecho, u16_t len)
+{
+	size_t i;
+	size_t data_len = len - sizeof(struct icmp_echo_hdr);
+
+	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
+	ICMPH_CODE_SET(iecho, 0);
+	iecho->chksum = 0;
+	iecho->id = PING_ID;
+	iecho->seqno = lwip_htons(++ping_seq_num);
+
+	/* Fill the additional data buffer with some data */
+	for(i = 0; i < data_len; i++) {
+		((char *)iecho)[sizeof(struct icmp_echo_hdr) + i] = (char)i;
+	}
+
+	iecho->chksum = inet_chksum(iecho, len);
+}
+
+static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
+{
+	struct pbuf *p;
+	struct icmp_echo_hdr *iecho;
+	size_t ping_size = sizeof(struct icmp_echo_hdr) + PING_DATA_SIZE;
+
+	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
+	if (!p)
+		return;
+
+	if ((p->len == p->tot_len) && (p->next == NULL)) {
+		iecho = (struct icmp_echo_hdr *)p->payload;
+		ping_prepare_echo(iecho, (u16_t)ping_size);
+		raw_sendto(raw, p, addr);
+	}
+
+	pbuf_free(p);
+}
+
+static void ping_send(void *arg)
+{
+	struct raw_pcb *pcb = (struct raw_pcb *)arg;
+
+	ping_send_icmp(pcb, ping_target);
+	sys_timeout(PING_DELAY_MS, ping_send, ping_pcb);
+}
+
+static int ping_loop(const ip_addr_t* addr)
+{
+	ulong start;
+	int ret;
+
+	printf("Using %s device\n", eth_get_name());
+
+	ret = ping_raw_init();
+	if (ret < 0)
+		return ret;
+	ping_target = addr;
+
+	start = get_timer(0);
+	ping_send(ping_pcb);
+
+	do {
+		eth_rx();
+		if (ping_target_alive)
+			break;
+		sys_check_timeouts();
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			break;
+		}
+	} while (get_timer(start) < PING_TIMEOUT_MS);
+
+	sys_untimeout(ping_send, ping_pcb);
+	ping_raw_stop();
+	ping_target = NULL;
+
+	if (ping_target_alive) {
+		ping_target_alive = false;
+		return 0;
+	}
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
+	if (ping_loop(&addr) < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
-- 
2.40.1

