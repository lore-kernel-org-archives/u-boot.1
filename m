Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA06C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9947E8842C;
	Thu,  6 Jun 2024 15:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RAHnKjit";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B2E883F4; Thu,  6 Jun 2024 15:37:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922C1878E2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4215f694749so4439925e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681026; x=1718285826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOKNHUQAF/z7uYw9BKC26r4hFcJWPHxgcCrB35CBXwE=;
 b=RAHnKjitxm+sPpJrJy8GPIoHXcvdkTUN6Nd9Col7uW5RIqG6GOdIkFyaOWr1d3Koy+
 XKnXcMMs+3KHoFIypuZYv4qvJBwW/WKQdL5HJpU6tccDi0IG17ua/KgcT0pBRJsh8c3V
 brj+NudEmX5DcLSi+roPnDLDpkHb2d25hnBrK4qqFg9PGgQ11LomE5UqTV288d94y652
 wyo1DWgoxlp/Iv4Thw3zjnUP5pk+BypMXd4iNlcGRKVhxG/D9POwVDNuzsFYD86M2cL+
 19/QSFrUK2itXcYGZlHo8IHjTErjARskVtJoEBf9SB0wP4MGFICtH1NK8PHwLfzW3q/a
 Xp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681026; x=1718285826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOKNHUQAF/z7uYw9BKC26r4hFcJWPHxgcCrB35CBXwE=;
 b=Xw1LA4VHyMUiM38VDvdBJA1V/xMkd3O14CdbOSp4br+QlIQbrbOJK/glj7Fx2mFSOf
 uX86XH5rULmwPTYCbPqWkBlRFaSsrs2JJOr/aDaqnug+7DvoSa/esYP6WcmJC//h5rtN
 YXXILQwHZJ+Xws9dULPKoAmT4F4MdMa5cx0WspyvKJRq6rUgOmrzs7v2LpZy9A6j8JEy
 ZdDIZhCVb44qLVCgahnsQeuRubdIL67KF5tyPAhFW/ofqxg4fe/lyNdYyCT9XbvggUUO
 px4ULe6yHONBCpmBQlRKmtVeJ662TpjXet/pzB61bvdxSuZMZUimjR5VRNfkaAySplRW
 OXVQ==
X-Gm-Message-State: AOJu0Yz2y2Ha83UmzlifsNUEcjbJU2Y9vAD+uTKm+WnTgCEd3hNOAvPX
 iyeRPzGMGZPewesQ33gtzMHubCc6qjAqeiBsF1wm1WZ8NZ0JuGUlwLAyLOkoAZeWbl03nk5ux3m
 UG5wkekJI
X-Google-Smtp-Source: AGHT+IEaWjHKXfEdNzA6V6OKQ3OM5srhEJw3coZ93RBX2IjVC3BrdCK6u5KY6WvyUwovbTe2VrQX6Q==
X-Received: by 2002:a05:600c:470f:b0:421:e89:dd07 with SMTP id
 5b1f17b1804b1-421562c66dcmr46477605e9.2.1717681025789; 
 Thu, 06 Jun 2024 06:37:05 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:05 -0700 (PDT)
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
Subject: [PATCH v3 05/12] net-lwip: add ping command
Date: Thu,  6 Jun 2024 15:36:00 +0200
Message-Id: <7ae6750ee1319cafa8b5b86f34394d597439b610.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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
 net-lwip/ping.c    | 163 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+), 1 deletion(-)
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
index 00000000000..51947d615ed
--- /dev/null
+++ b/net-lwip/ping.c
@@ -0,0 +1,163 @@
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
+/* Ping identifier - must fit on a u16_t */
+#define PING_ID 0xAFAF
+
+static const ip_addr_t *ping_target;
+static struct raw_pcb *ping_pcb;
+static uint16_t ping_seq_num;
+
+static u8_t ping_recv(void *arg, struct raw_pcb *pcb, struct pbuf *p,
+		      const ip_addr_t *addr)
+{
+	struct icmp_echo_hdr *iecho;
+	bool *alive = arg;
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
+			*alive = true;
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
+static int ping_raw_init(void *recv_arg)
+{
+	ping_pcb = raw_new(IP_PROTO_ICMP);
+	if (!ping_pcb)
+		return -ENOMEM;
+
+	raw_recv(ping_pcb, ping_recv, recv_arg);
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
+static void ping_prepare_echo(struct icmp_echo_hdr *iecho)
+{
+	ICMPH_TYPE_SET(iecho, ICMP_ECHO);
+	ICMPH_CODE_SET(iecho, 0);
+	iecho->chksum = 0;
+	iecho->id = PING_ID;
+	iecho->seqno = lwip_htons(++ping_seq_num);
+
+	iecho->chksum = inet_chksum(iecho, sizeof(*iecho));
+}
+
+static void ping_send_icmp(struct raw_pcb *raw, const ip_addr_t *addr)
+{
+	struct pbuf *p;
+	struct icmp_echo_hdr *iecho;
+	size_t ping_size = sizeof(struct icmp_echo_hdr);
+
+	p = pbuf_alloc(PBUF_IP, (u16_t)ping_size, PBUF_RAM);
+	if (!p)
+		return;
+
+	if ((p->len == p->tot_len) && (p->next == NULL)) {
+		iecho = (struct icmp_echo_hdr *)p->payload;
+		ping_prepare_echo(iecho);
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
+	bool alive;
+	ulong start;
+	int ret;
+
+	printf("Using %s device\n", eth_get_name());
+
+	ret = ping_raw_init(&alive);
+	if (ret < 0)
+		return ret;
+	ping_target = addr;
+	ping_seq_num = 0;
+
+	start = get_timer(0);
+	ping_send(ping_pcb);
+
+	do {
+		eth_rx();
+		if (alive)
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
+	if (alive) {
+		alive = false;
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

