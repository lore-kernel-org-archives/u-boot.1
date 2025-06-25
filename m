Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B0C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 544E882E50;
	Wed, 25 Jun 2025 15:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZjuYJGZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB5A82F10; Wed, 25 Jun 2025 15:21:47 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E191D82E35
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so6308453f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857698; x=1751462498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=ZjuYJGZdcbn1IUxMXoqLlPD+quLfheT/BWPVRKjNSdBElgvflRAjRGusyQhaW+hnMt
 JwbP+GQp9dKgAeDhHq0/cag5KCldkp3Zq6PZThB2Pm4qlJ4eePANdhFIULHt1J3hjwdE
 QcLxQ+0SWCSKNxxr6Yryjqpd3ZSTpfatTjx2oYuyYFu+t71fKBXx8IxwzUC+NUBE3bfP
 8suJ1n9PyQ9PMvsuJPrh1HoQA7Eky5obdLtlDKbCSkLgpt1dsIfwELI9BpbBonHIk2sK
 hreVEr2/PwAttpF9fxiGsxB6rP3o6npgeJ+soTqiaMaDYub2gLPRv48BcrTSFp/5RXIj
 YyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857698; x=1751462498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=bc/qr0hE69lsCLiT0zVT9Ufhiu3/iST9l7/GRjBHMF1sAe3wsO943aeC4MqnHBxQID
 gorzS1zwMqojsMPHnXMMD8yU1Muexz8nkSe71tnu7FosvA0eyvRwh1Gstj+NmIVfj8rQ
 MqkI+4NaCpP9AA/t/FzTiQyJiG7BuVIm8zTh73HCJV0I+NwvrjOYNWNmEHX616/XlkVe
 9OeUgpxjDIFpCnap8sdU5dpCyC5i+du/NldLYGzFGasNXkKi/KD2Us/KVlLmncrqZeYn
 Q8QigyCyjrpKh/I0dqcFuZuQQILlIhF5hiFy8OfXXZmDoBmzJ5rzmpmG1WNwhmpflAo7
 C0lQ==
X-Gm-Message-State: AOJu0YynVwWZRlff1TDHaYLdZsNlAQthZmOFjYUGZjO+ZL/xcAAkY4Fm
 mgEz8fWSCUZuQpeRsUO+CzbLulDBtq6IicP9r2mfdqgzTFbVeGPoO8T5hAUfyUgCdoA43wC0/z2
 8WeJglaM=
X-Gm-Gg: ASbGncu0QCGCd0zhtcqVvv2YzOeIsWY3eMS6RKmQOSWUeNoiEfnB557Qn5MIINc5ce9
 Adatpj/wcIZRwEV9FnvqqStAidyIDIGoVwXn0pHevC4jvnIfNPKhYE3L02Tc1G1BvDXtYih6gex
 7ES141XDFZOLjtSOTS3l6rNxiF+mMHSxtzzZJxvpu6HvIXpjZbtaQc+3G9r+vHxtXEXMlfai04F
 GXTpFjgqADh8ft09HdI2dYDH7dnEakjsLcOw/SfaPTkdbypC2Zc9hIKYVwrWzTBXe6u2vmTre9I
 YfaEVSK8Cd2JOxn4VVGHWsdJm0Wyz5f2mmY17g0R/wxmqeur/NE9zU7LZZp9TL4onn0YMB8=
X-Google-Smtp-Source: AGHT+IGOh6mL09+0BdulYbOYH9MCnOyqKkBUEsA7o/0DDGeNBQWT7+zzlGwj7RISsqeLJ53QZkcvYA==
X-Received: by 2002:a05:6000:26d2:b0:3a5:2cf3:d6ab with SMTP id
 ffacd0b85a97d-3a6ed6464d7mr2626679f8f.39.1750857698029; 
 Wed, 25 Jun 2025 06:21:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:37 -0700 (PDT)
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
Subject: [PATCH v4 11/13] lwip: add sntp command
Date: Wed, 25 Jun 2025 15:19:19 +0200
Message-ID: <20250625132108.3292932-12-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

