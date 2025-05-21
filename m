Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B0C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEE282F8A;
	Wed, 21 May 2025 17:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zCxZeSvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A583582F40; Wed, 21 May 2025 17:15:55 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B238E82F10
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so53067375e9.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747840552; x=1748445352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpTkdD3W+TlrBZwzq3MGkTyrJylZI6D54JapYuPoE0o=;
 b=zCxZeSvgUp5BVZZH+IPghR3npLVh6ZBwnofpt2BVMaHdlSabiHHKYGD+uoWv4Fo495
 XwdYrIN5xb/YtKNZQl/QEkH6bQ+oONFImo6z4pfVkZw08cuc3dF/VPtaBQjddcrd5MUH
 Moyyk8rkT2vJW32EGKFHUaNb9UEiwBYEIxljJgWWEywzf72dFRDIqqS8w1rbSY/KvKNc
 t7dB7nQkVCRgfSXwbB2TOp+mQB4AdBw7uthoIO9ZVafxUTSZS8g9xoZd5Wuw/air88kj
 Z4cMfqc/LxLkxLZzhiAPMgupD3rdLbRYTbYniLJEm9AtXvojOrWiGfsYyb/WsOiJbuWE
 ne8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840552; x=1748445352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpTkdD3W+TlrBZwzq3MGkTyrJylZI6D54JapYuPoE0o=;
 b=vn3rGxgC45BuNrHhStUJBt/uEOdRObRsTmGPdDqofzi578O6QGcz7Q4zFQfEMsl2RB
 tCihZkAhzMvGx1uNpipUuiQQ2OKXZr+/s8qibnd7jzj4D1n44b3Wr0MHI6ROTVNXWmj7
 v7Yky/mCEmKUkwsc9V6dpPWC2Imk9gEnh+UCf8hiMiM1+W1KrrD0IUIcMZy4OsFT7RF6
 HWIFrWOxUvQOkysY+CQiLq1g0LroJbDyg9ESLUYznzYeolQpj1KdVkMGviZzciSdbOdZ
 B1XZILuKm5CDpPZpaviJ+yHPYVXPrL10MKdwRF5P9SPA4iXHqRByJKnBOrHR0axXkhNY
 yYaA==
X-Gm-Message-State: AOJu0YzP6RIHBMbYEBakgYfnN2ZNcYPQPMJAt0VAY5sA5W6NW4h5ggMk
 6p5cJHb4bXIwzACwa9eKtYfvXQxeMfVXPUXBGpr5oichzt8flV2setEar6sZ84vLVdh0XMXcmY8
 mHWZyRlk=
X-Gm-Gg: ASbGnctLcAD71APd3GvU2Y2ELWcf0Q8RdmrMUH0BOnXL+Ps4p6uxX6XB8onhjusx2nX
 8ApPcLTYqjaJMw8Bm2Zh5MauRsZPdP1fRoZZQoAEbSmRIPTN8xIhccjUZZwShWNehfk0igyFstL
 6SpTXt3X1HMVfLEsZhtaqiPjkDRe1BxyUSxxHdmmxt/s23HCb6gqQ1tWrxFSJaafVhdwLd0xH7j
 uogAKIMZelWySP8+OvoFa5KhY7nIcpJKoA0okl7kbzppCglK2l2YKruMHzSIo5EQgw7i+mrqcF7
 IfOJpf5avwlU2+s575bQCdTej04KKZOtWgDUjcjGPD3Zn4TQY1OntdvHRl1m
X-Google-Smtp-Source: AGHT+IE419A0Cw2GhTkfncmWyD5elBpvl3JT/FIuK9DPhFE3nHJXPro9XD/VmF+pnwhYk9wy3cv3yA==
X-Received: by 2002:a05:600c:3c99:b0:43b:4829:8067 with SMTP id
 5b1f17b1804b1-442f84cb4famr229532425e9.6.1747840551803; 
 Wed, 21 May 2025 08:15:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f65b:56f4:360e:9fce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3632a2bffsm18505226f8f.32.2025.05.21.08.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:15:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] net: lwip: add sntp command
Date: Wed, 21 May 2025 17:14:42 +0200
Message-ID: <20250521151516.16729-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521151516.16729-1-jerome.forissier@linaro.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
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

 cmd/Kconfig                |  13 ++--
 cmd/net-lwip.c             |   5 ++
 include/net-common.h       |  11 ++++
 lib/lwip/Makefile          |   1 +
 lib/lwip/u-boot/arch/cc.h  |   4 ++
 lib/lwip/u-boot/lwipopts.h |   4 ++
 net/lwip/Makefile          |   1 +
 net/lwip/sntp.c            | 128 +++++++++++++++++++++++++++++++++++++
 8 files changed, 161 insertions(+), 6 deletions(-)
 create mode 100644 net/lwip/sntp.c

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
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index cecf8d02555..2ffee64f97e 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -21,6 +21,11 @@ U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
 #endif
 
+#if defined(CONFIG_CMD_SNTP)
+U_BOOT_CMD(sntp, 2, 1, do_sntp, "synchronize RTC via network",
+	   "[NTP server IP]");
+#endif
+
 #if defined(CONFIG_CMD_DNS)
 U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
 	   "hostname [envvar]");
diff --git a/include/net-common.h b/include/net-common.h
index a021bf503ff..b06cafb497e 100644
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
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5df222589b8..5bb98dc4d98 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
+obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
diff --git a/net/lwip/sntp.c b/net/lwip/sntp.c
new file mode 100644
index 00000000000..3b2bc3c679d
--- /dev/null
+++ b/net/lwip/sntp.c
@@ -0,0 +1,128 @@
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
+	ip_addr_t *srvip = NULL;
+	char *server_ip = NULL;
+	ip_addr_t ipaddr;
+
+	switch (argc) {
+	case 1:
+		server_ip = env_get("ntpserverip");
+		break;
+	case 2:
+		server_ip = argv[1];
+		break;
+	default:
+		return CMD_RET_USAGE;
+	}
+
+	if (server_ip) {
+		if (!ipaddr_aton(server_ip, &ipaddr)) {
+			log_err("error: ipaddr_aton\n");
+			return CMD_RET_FAILURE;
+		}
+		srvip = &ipaddr;
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
-- 
2.43.0

