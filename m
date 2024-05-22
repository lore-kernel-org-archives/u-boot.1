Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D3FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244D888860;
	Wed, 22 May 2024 18:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f6N4jg13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE1E88435; Wed, 22 May 2024 18:04:31 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F66587E06
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59cc765c29so110992066b.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393868; x=1716998668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/AH6ZT/ga5ET8MyoRKr8FtR1gRj5gqa/+M+L/AxTo0=;
 b=f6N4jg13gKnxKtX3uXqGXth0ISgJZJIpCfPSCjcLO5Bk5N3sO9ZRe2rqVSoESK9V9t
 E0TUglkqflZBtei8NjbCq4ZE8shcLV9K93oRsxt6CCcEt7vld7uqRsZ6wrZR+PdS9PzL
 7nr1fLpwqo8ZCD5+xnAl6UzKm/L+ooVdT7z4zJ8gkYBXsVsJwaVgFtug54ABxyUBGVsT
 Vl65o2j6RA/RPNJZE6+szAJTdidxcCJyGT/rOnGM+C+6aRVv7CyDV50IMAoBKebWv+2P
 A/0MCUyZY9d7jJyw0qPCyF57Jt4A4M0MIeg4wanXf8UxDlvArZ+GC6OtMkk4oaQmKvm0
 SkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393868; x=1716998668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/AH6ZT/ga5ET8MyoRKr8FtR1gRj5gqa/+M+L/AxTo0=;
 b=rQ9MB+zsfRjHIt3eyvY2R0pW5JFoBGpQ3HDFaic2KzpDSKKvxblelNvANaBJImQX5Q
 vAeNh9fQP0ByDhuIyKsj+jyN/7XGMy637UbAxp91t2spDmtoS2vNZawecTBPgImFpXWN
 DpAlnn8WK4XScM2sSiKQ6vrPZIDPHXemSdxppx4/SpjRYBw+LJHv/dHFJwo54D5jcUaK
 9nqAlel/4XmylXqJYwy5R19lxQchy1/irhYBH2OLV/WIfYt+uO+YrNRfVD+pMx0AXfI/
 ioviU9p9Iqg8MbvFINyMFQG2sVp2d+jeqs9PrxVEEniTKB9dNNG6ZEc41EHjLQ7a7iMz
 HLhA==
X-Gm-Message-State: AOJu0YzXFxgtJtmijDhjloP3W/xR/VeIRKdqbpIXkFy4zdjWDGHngIIY
 QLPQ/g85aT1rBdrd3Bzw+YH9nKWFnF/U07Kns4Pe+2bFESZU14V74Iiwx5NA6JDUOJ3Z6V42Ve7
 sZnsvbXOy
X-Google-Smtp-Source: AGHT+IGaC+j2aYWYzr74+P0G1JkKDF/HRtwZlPxUcactam+1jlg65X0cQ61qsrEepZ9b9rf798ie3A==
X-Received: by 2002:a17:907:11c6:b0:a5f:d17d:cddf with SMTP id
 a640c23a62f3a-a62280a12dbmr147936166b.44.1716393868146; 
 Wed, 22 May 2024 09:04:28 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:27 -0700 (PDT)
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
Subject: [PATCH 05/15] net-lwip: add ping command
Date: Wed, 22 May 2024 18:00:05 +0200
Message-Id: <b22bfbbf3087936d0d4eeff890efc926d8a02722.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Add CONFIG_CMD_PING_LWIP depending on CONFIG_NET_LWIP to provide the
ping command using lwIP.

The implementation is derived from lwIP's contrib/apps/ping/ping.c.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 boot/Kconfig       |   1 +
 cmd/Kconfig        |   6 ++
 cmd/net-lwip.c     |   8 +++
 include/net-lwip.h |   3 +
 net-lwip/Makefile  |   1 +
 net-lwip/ping.c    | 171 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+)
 create mode 100644 net-lwip/ping.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 649fd454a2..9f220fa75c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -382,6 +382,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_PING if CMD_NET
 	select CMD_PXE if CMD_NET
 	select CMD_DHCP_LWIP if CMD_NET_LWIP
+	select CMD_PING_LWIP if CMD_NET_LWIP
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7bb6269b7a..6840f7319b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2098,6 +2098,12 @@ config CMD_DHCP_LWIP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_PING_LWIP
+	bool "ping"
+	select PROT_RAW_LWIP
+	help
+	  Send ICMP ECHO_REQUEST to network host
+
 config CMD_TFTPBOOT_LWIP
 	bool "tftp"
 	select PROT_UDP_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 30b396f2d0..fbe04048cd 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -12,6 +12,14 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_PING_LWIP)
+U_BOOT_CMD(
+	ping,	2,	1,	do_ping,
+	"send ICMP ECHO_REQUEST to network host",
+	"pingAddress"
+);
+#endif
+
 #if defined(CONFIG_CMD_TFTPBOOT_LWIP)
 U_BOOT_CMD(
 	tftpboot,	3,	0,	do_tftpb,
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 2308703e46..2abaaa3b4e 100644
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
index 79bdaecee5..676615fe17 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP_LWIP) += dhcp.o
+obj-$(CONFIG_CMD_PING_LWIP) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT_LWIP) += tftp.o
 
 # Disable this warning as it is triggered by:
diff --git a/net-lwip/ping.c b/net-lwip/ping.c
new file mode 100644
index 0000000000..763a9bb1e3
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

