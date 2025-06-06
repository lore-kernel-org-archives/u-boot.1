Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C36C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C1982B37;
	Fri,  6 Jun 2025 08:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gqy0KZ9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EF182B00; Fri,  6 Jun 2025 08:42:35 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD852828A2
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so1530225f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192153; x=1749796953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=gqy0KZ9znMl2k8QyIm/BgZjAFA+ejw3GHgki/cdR72d5u5ehjiZSK8xeIUIyD3qRpX
 1/2k4FJFjd1weP/QYq4yITEx0NeNajN9nHX8rXfBdFMAeduVVM6Lty/faTo+3Q3WM6ZB
 cdIKkdLy8VbI6913m8O9cYb+r1dvxurFw8FFXLF+KG42XnrnZHrSV+hrDy3ZK5nJecDV
 e19dp3soz63zUnMgelkVtZTM6wT7xtlsLSLIqn8oM5o6U701kr4t1//zLwzFc9Hi/wxi
 tDhkoMf+DPBAribQwVauqdsn/nEJY76ytGziV+p93Ynuu2wIvWHzFUzk68uShjFoep2e
 BUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192153; x=1749796953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6FRdVmrBijhW1AWivYtwFjvoXrM75h+S+QcFgTAOkCA=;
 b=AzAx8uUjJWA9sCiOB6gxuE3wV6Sh9J0vS9KQcUh+CLP0oP/P7J7cewCbW1acXLsr0m
 7+ZAgF436XrjV50JMKEmAaxjX9YF4cqK2lv8gszG3XznKAy0/ghfYEGRiWAYtrf/WQ+X
 8yV/5xyoEgUkmsDIQdaSrjfouMyg29GKm1WKSvaiSxHyLx5zYjXAxmMpqiUgMvH/8wtt
 kPkQYwxytW7iPFXkC+zvqCPP84ZzgJCOwMC+yvVcKhOfErafS/PRi0Q/EQXOxl5FgZOV
 XaHBvJu5oXJmD091jfA08oquFiVsVosziNmcHkHqkXrkHbb3YVRlN2mZ2qWMUCo9mWvy
 tX8Q==
X-Gm-Message-State: AOJu0YxJl0kWlj2uoWBZ/MB5muLsCoPBJpyzWDldra6VDpv3M7GWcYYY
 BkFvUlzEBcmClDHA45ZvBcEzVm36bXWAN3KpzbS2XAOFKTeNF8ydlTOVveIqtNJc8D0tE4PpP2N
 4rD+T
X-Gm-Gg: ASbGncsgXP9XOA8FNPQtM006TcoxU5ImDO8eWySiHrXtCLCBCPgyXGqGwuvO3YiIoVG
 3eI6Yq8YxZTAJPgXUKBkMW7fef6wXloJPfAs6IJQRMHuLSx7YkMEFQm0J7ilXI4HPHWeHyKeMBB
 zsG95mCdnlFZ5kPb3kmcxnmDrf+EvyJ405vwDiphMB9qbE4yPYvSU/58z+lQq/bvVUKEsMcOY3U
 cjxnDykjEV0UULBkzPCjeq+nF7UG7t9RgDWLGHGvyePh/anMZ28/R3Op3v0/BzKS3Ip5EQCdGqm
 Uf9GWMr/cNO+vBGvdXU7onPCHmkI2xBB11koxh8rciVWa7kC3mVYvsvAwK3MKocUYH2p+EQ=
X-Google-Smtp-Source: AGHT+IFMv7jGiq7VTLCIz3lw3CeWk4rTGqFR1XikMJvY/ry8NmQtvzXIbS/Xx5cIa5DHZL/+152EMg==
X-Received: by 2002:a05:6000:2210:b0:3a4:d0fe:428a with SMTP id
 ffacd0b85a97d-3a5319a0d80mr1870600f8f.28.1749192152888; 
 Thu, 05 Jun 2025 23:42:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:32 -0700 (PDT)
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
Subject: [PATCH v2 11/13] lwip: add sntp command
Date: Fri,  6 Jun 2025 08:41:47 +0200
Message-ID: <20250606064211.3091237-12-jerome.forissier@linaro.org>
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

