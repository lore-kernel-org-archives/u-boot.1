Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D1EC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40AE282D60;
	Tue, 17 Jun 2025 12:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qcSAWByy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185EE82D83; Tue, 17 Jun 2025 12:07:56 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954AA82C87
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so51914705e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154873; x=1750759673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=qcSAWByyhF4iRRDRasmqaSCAnVBUMtkTIi96foUFg+iF90mqO4NyxG6EEoMsX8pflA
 UldpuV3kUuHy++c07RKAxCQ/+7OeW2zrVL89CP65ZsABgnfLf0LHwLQxB62u0tJ29YMt
 2o5gZQ+CGeWEoYcJWmyHC8QxX6J0QJK3gZNCxuO45t1mwg5CZtd7jf6tX0vOUR7DAPbA
 S01MqIcKueqTtwUrAsrdbCKtnUPLQI4rr+FsIqezwvM0i/mgv1xDf6l+qqAzBHZvPQ7T
 8dQooamhlg8wK/2VtlIvk4s9O1Ot0EbqS4KIHNO/XOsZ7pikSUN9+XqmJu8pu+GBl3DB
 IhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154873; x=1750759673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=Nwz8jypGs2+uvfB5O+pYYXVaDDPrqFfabG6AD0DxrNyg0IKtYsW22KebBSe8FFNDiY
 zm3ji8iE50E9tNR9ehMBR2LXZ+HNAjZStNlxKdbh2HUvAUI2CR+x6B3ym9OMDG9YCOFh
 iaJdc+2yZPFaod31yY6LOFTI9UPvAzgFyUAQwWs8bZU0h692iagJ3TXIuruqPzCzWgLI
 lBN2fTG989UZVmEZ/rl89yxGPbpIvhyNZ8j0BS8tbpFFFc5Wkcb45bbTC/SZN4qksv5i
 LKJI0+IuSwNjuxTaIc1j++eMVUfkjTS6ePd9XB0U2Dbou0CwklYUhDRH7fWLqbpnPaXO
 6d4Q==
X-Gm-Message-State: AOJu0YywX9xIDOtV6+YX+mVd81VXKizgv7QbrLnPA7/bTkYEweGcjgld
 0eLdKNF1YAmhVzgfL1DTIkvCOOZosvI0mu+5DCWVFZGaNmy1nnN83BMv8LrqJxkab9Lyr0sH2np
 V28fW
X-Gm-Gg: ASbGncv4t7R3YaX/G8+2/Qsiuw/yIgvfeJ6Pxu6TTtRlZqv+gCHivhZ1A64pmnRruXW
 U5+NsZ4i/MRxAEbbOQlFdHyhtPvuYQD4/xJ72J0FPrNaGPLm6c665IniW3wwvArNJcLIdkyZxT+
 +iwZbJfYFzx+OPkt2VELXfh1xQc9UQLE0JF/ME7pT6675bUOUN+vfh6DFr5rP1XrR0D09+0xAKU
 ZqmkBxarvBnYhW8IWc9AuGDR3MYfuOTrPoWw7p1eqpEnu/3vsuBmvkXQ1Zcu2bA2Gc/y8+E3qtq
 5ueidb1T9YxxVCtCqaAZkWIWOhYqt8/Lw2k+ul1orQNuoeKXlJfKBzsjDM18nCXUHD3NeHU=
X-Google-Smtp-Source: AGHT+IEMcX3zpBAPugLuBQCQgel36AuhkVh8KXWaPGtsytU7P0S05Y4Ble5rdQG4dttdOg4HSlToNw==
X-Received: by 2002:a05:6000:650:b0:3a5:8c27:8644 with SMTP id
 ffacd0b85a97d-3a58c2786ffmr383576f8f.24.1750154872698; 
 Tue, 17 Jun 2025 03:07:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/13] lwip: add sntp command
Date: Tue, 17 Jun 2025 12:04:01 +0200
Message-ID: <20250617100720.2544758-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

Implement the sntp command when NET_LWIP=y.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 cmd/Kconfig                |  13 ++--
 cmd/lwip/Makefile          |   1 +
 cmd/lwip/sntp.c            | 133 +++++++++++++++++++++++++++++++++++++
 include/net-common.h       |  11 +++
 lib/lwip/Makefile          |   1 +
 lib/lwip/u-boot/arch/cc.h  |   4 ++
 lib/lwip/u-boot/lwipopts.h |   4 ++
 7 files changed, 161 insertions(+), 6 deletions(-)
 create mode 100644 cmd/lwip/sntp.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..58f629e1c34 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2061,12 +2061,6 @@ config CMD_CDP
 	  and to retrieve configuration data including the VLAN id using the
 	  proprietary Cisco Discovery Protocol (CDP).
 
-config CMD_SNTP
-	bool "sntp"
-	select PROT_UDP
-	help
-	  Synchronize RTC via network
-
 config CMD_LINK_LOCAL
 	bool "linklocal"
 	depends on (LIB_RAND || LIB_HW_RAND)
@@ -2144,6 +2138,13 @@ config CMD_PING
 	help
 	  Send ICMP ECHO_REQUEST to network host
 
+config CMD_SNTP
+	bool "sntp"
+	select PROT_UDP if NET
+	select PROT_UDP_LWIP if NET_LWIP
+	help
+	  Synchronize RTC via network
+
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP if NET_LWIP
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index 4c28d2b28e5..a7f8976af3f 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
+obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
new file mode 100644
index 00000000000..32cbdfbffdf
--- /dev/null
+++ b/cmd/lwip/sntp.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2025 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <lwip/apps/sntp.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+
+U_BOOT_CMD(sntp, 2, 1, do_sntp, "synchronize RTC via network",
+	   "[NTPServerNameOrIp]");
+
+#define SNTP_TIMEOUT 10000
+
+static enum done_state {
+	NOT_DONE = 0,
+	SUCCESS,
+	ABORTED,
+	TIMED_OUT
+} sntp_state;
+
+static void no_response(void *arg)
+{
+	sntp_state = TIMED_OUT;
+}
+
+/* Called by lwIP via the SNTP_SET_SYSTEM_TIME() macro */
+void sntp_set_system_time(uint32_t seconds)
+{
+	char *toff;
+	int net_ntp_time_offset = 0;
+
+	toff = env_get("timeoffset");
+	if (toff)
+		net_ntp_time_offset = simple_strtol(toff, NULL, 10);
+
+	net_sntp_set_rtc(seconds + net_ntp_time_offset);
+	sntp_state = SUCCESS;
+}
+
+static bool ntp_server_known(void)
+{
+	int i;
+
+	for (i = 0; i < SNTP_MAX_SERVERS; i++) {
+		const ip_addr_t *ip = sntp_getserver(i);
+
+		if (ip && ip->addr)
+			return true;
+	}
+
+	return false;
+}
+
+static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
+{
+	struct netif *netif;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	sntp_state = NOT_DONE;
+
+	sntp_setoperatingmode(SNTP_OPMODE_POLL);
+	sntp_servermode_dhcp(CONFIG_IS_ENABLED(CMD_DHCP));
+	if (srvip) {
+		sntp_setserver(0, srvip);
+	} else {
+		if (!ntp_server_known()) {
+			log_err("error: ntpserverip not set\n");
+			return -1;
+		}
+	}
+	sntp_init();
+
+	sys_timeout(SNTP_TIMEOUT, no_response, NULL);
+	while (sntp_state == NOT_DONE) {
+		net_lwip_rx(udev, netif);
+		sys_check_timeouts();
+		if (ctrlc()) {
+			printf("\nAbort\n");
+			sntp_state = ABORTED;
+			break;
+		}
+	}
+	sys_untimeout(no_response, NULL);
+
+	sntp_stop();
+	net_lwip_remove_netif(netif);
+
+	if (sntp_state == SUCCESS)
+		return 0;
+
+	return -1;
+}
+
+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	ip_addr_t *srvip;
+	char *server;
+	ip_addr_t ipaddr;
+
+	switch (argc) {
+	case 1:
+		srvip = NULL;
+		server = env_get("ntpserverip");
+		if (server) {
+			if (!ipaddr_aton(server, &ipaddr)) {
+				printf("ntpserverip is invalid\n");
+				return CMD_RET_FAILURE;
+			}
+			srvip = &ipaddr;
+		}
+		break;
+	case 2:
+		if (net_lwip_dns_resolve(argv[1], &ipaddr))
+			return CMD_RET_FAILURE;
+		srvip = &ipaddr;
+		break;
+	default:
+		return CMD_RET_USAGE;
+	}
+
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
+
+	if (sntp_loop(eth_get_dev(), srvip) < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
diff --git a/include/net-common.h b/include/net-common.h
index c212d2f9b3b..885ba97fdf3 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -505,6 +505,17 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
  */
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
+/**
+ * do_sntp - Run the sntp command
+ *
+ * @cmdtp: Unused
+ * @flag: Command flags (CMD_FLAG_...)
+ * @argc: Number of arguments
+ * @argv: List of arguments
+ * Return: result (see enum command_ret_t)
+ */
+int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 /**
  * do_tftpb - Run the tftpboot command
  *
diff --git a/lib/lwip/Makefile b/lib/lwip/Makefile
index e9e8caee93a..c3f0e916f66 100644
--- a/lib/lwip/Makefile
+++ b/lib/lwip/Makefile
@@ -13,6 +13,7 @@ obj-y += \
 	lwip/src/api/sockets.o \
 	lwip/src/api/tcpip.o \
 	lwip/src/apps/http/http_client.o \
+	lwip/src/apps/sntp/sntp.o \
 	lwip/src/apps/tftp/tftp.o \
 	lwip/src/core/altcp_alloc.o \
 	lwip/src/core/altcp.o \
diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index 6104c296f6f..f91127ac565 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -43,4 +43,8 @@
 #define BYTE_ORDER BIG_ENDIAN
 #endif
 
+#define SNTP_STARTUP_DELAY 0
+void sntp_set_system_time(uint32_t sec);
+#define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
+
 #endif /* LWIP_ARCH_CC_H */
diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
index edac74ff7a2..14ba7bd7ae2 100644
--- a/lib/lwip/u-boot/lwipopts.h
+++ b/lib/lwip/u-boot/lwipopts.h
@@ -162,4 +162,8 @@
 #define LWIP_ALTCP_TLS_MBEDTLS          1
 #endif
 
+#if defined(CONFIG_CMD_SNTP)
+#define LWIP_DHCP_GET_NTP_SRV 1
+#endif
+
 #endif /* LWIP_UBOOT_LWIPOPTS_H */
-- 
2.43.0

