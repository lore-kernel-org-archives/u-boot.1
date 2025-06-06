Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB4C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CAA82998;
	Fri,  6 Jun 2025 08:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MWrlgUpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D41682AF6; Fri,  6 Jun 2025 08:42:30 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9AF82998
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1623518f8f.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192148; x=1749796948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtFyoCe52O7bO5f3J4thUTSaZ+n8yqsiDvoMPvl6Nuk=;
 b=MWrlgUpa8/Hdv9EJdLdzcWRxPQBV2sv8IgrGOrnexq8qtYKbyWdsW2UIP8eJN/OkoH
 G3dUXXAV8sdzVdoRVfyYqIfeyK9qKUTmXqmCy8D29nHS8FYfRFuiYwpN8jpdLfrKLzTr
 k/V1KZmapLcucPbl7HT5r8i5JqBWo+/yjYUnqOO+KQHRa2w6ge/n7JvoEr+5+czB/AFP
 XnTzQBqA3PwDPIcSitDBVJe8bjWOsRPPln5Y/KKQU4RBmv+MwbMworiq9ZJhp8n4u8gd
 cIx9rSeGXDqNf95AQbG3sZTJPH1iJjU/orSWI1/YASYhLL4uJm8jb8VrhE86+RU6GYA2
 hpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192148; x=1749796948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtFyoCe52O7bO5f3J4thUTSaZ+n8yqsiDvoMPvl6Nuk=;
 b=O78+4Yp3UaYJT4+GXOpvL+z7WnITA1MWhM0wdWaXotrrLfspm0zwPGYmlCVdSGB4KW
 6OtPinJtxP11qa0/ViqfCDZLJzY7L2lzUw8zpmqWlkmW9eA2mL5eqwNGAQXUF9lrn++a
 S3AWNluCN4sQg7aCyDXdmLjmfVi+hBCNAvZEuUfL88zOaH+5yPf4VLbnxiYME9VSKCN3
 2RpCrp5qYXhMd5MdLpNFXMg6+kJIolmguTHAsZ+GMUAjapZ+6mmT5xBlxSZBLmbpAoPc
 AmGlgtP+wctkD3JRzqlxM6MzELKZHnocl2uC/UAW35J8eMAJzZ0pRduiJMN4qFhL+T7T
 0e+Q==
X-Gm-Message-State: AOJu0YxWpIdqTvtJmbQYPx2ADtLmp2Minu2+k9oYhqJH9Er+6AOaD8Gx
 sBrTNs8SnGSrQVhs1c0pNQYBehkFJtW3iVmMMNttziOfPmN3lcgW2tFE+XqAzoi0sxvo8TwQN2L
 RmdMD
X-Gm-Gg: ASbGncs4641XFjBMoYsqvFt6/kGdBbZBIXIEgQkP30SQ/C3vJnFv/QwC0g1Ch0OqFfa
 q2ng24tp780TKr7kTSrrcD6t8dfFwX95yMoi09u5NHyx9VHsAZ6rGyFMdxoOy4MiVpPi1ViofBx
 2ZN7iDYOPA/qj7vTljQ4tTVAT/9vngViGCm+0lbA/d3nUxKO39fI7npL7nEXXFaWABeIzOR8iOz
 uNZLb6aLeHGYkIPcuTKjDFKpmm2ZL3fRDj3yIk8IgEen7ui/88LW41jAWooAk+eKMbJTLbI8Laz
 7CYq9tJ1ZR8EGsLgDjns9k56sFDURAKILc0F+Aao6o8Ue0kwN8vyzq2OJIW0
X-Google-Smtp-Source: AGHT+IH/NGdiNnmU5wOoW1Oft2YWWUF5/zUzoDHrg8wvgpsKPmZv5LvSocRtLiPl5d+Hmbb8WDMM7w==
X-Received: by 2002:a05:6000:18ab:b0:3a5:2ef8:3512 with SMTP id
 ffacd0b85a97d-3a53188d037mr1804394f8f.14.1749192147551; 
 Thu, 05 Jun 2025 23:42:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/13] lwip: move net/lwip/dns.c to cmd/lwip
Date: Fri,  6 Jun 2025 08:41:40 +0200
Message-ID: <20250606064211.3091237-5-jerome.forissier@linaro.org>
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

Move the implementation of the dns command under cmd/.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 cmd/lwip/dns.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/Makefile |   1 -
 net/lwip/dns.c    | 128 ----------------------------------------------
 3 files changed, 123 insertions(+), 129 deletions(-)
 delete mode 100644 net/lwip/dns.c

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 31642b864af..be57a4d1b88 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -2,7 +2,130 @@
 /* Copyright (C) 2024-2025 Linaro Ltd. */
 
 #include <command.h>
+#include <console.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
 #include <net.h>
+#include <time.h>
 
 U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
 	   "hostname [envvar]");
+
+#define DNS_RESEND_MS 1000
+#define DNS_TIMEOUT_MS 10000
+
+struct dns_cb_arg {
+	ip_addr_t host_ipaddr;
+	const char *var;
+	bool done;
+};
+
+static void do_dns_tmr(void *arg)
+{
+	dns_tmr();
+}
+
+static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
+{
+	struct dns_cb_arg *dns_cb_arg = arg;
+	char *ipstr = ip4addr_ntoa(ipaddr);
+
+	dns_cb_arg->done = true;
+
+	if (!ipaddr) {
+		printf("DNS: host not found\n");
+		dns_cb_arg->host_ipaddr.addr = 0;
+		return;
+	}
+
+	if (dns_cb_arg->var)
+		env_set(dns_cb_arg->var, ipstr);
+
+	printf("%s\n", ipstr);
+}
+
+static int dns_loop(struct udevice *udev, const char *name, const char *var)
+{
+	struct dns_cb_arg dns_cb_arg = { };
+	bool has_server = false;
+	struct netif *netif;
+	ip_addr_t ipaddr;
+	ip_addr_t ns;
+	ulong start;
+	char *nsenv;
+	int ret;
+
+	dns_cb_arg.var = var;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	dns_init();
+
+	nsenv = env_get("dnsip");
+	if (nsenv && ipaddr_aton(nsenv, &ns)) {
+		dns_setserver(0, &ns);
+		has_server = true;
+	}
+
+	nsenv = env_get("dnsip2");
+	if (nsenv && ipaddr_aton(nsenv, &ns)) {
+		dns_setserver(1, &ns);
+		has_server = true;
+	}
+
+	if (!has_server) {
+		log_err("No valid name server (dnsip/dnsip2)\n");
+		net_lwip_remove_netif(netif);
+		return CMD_RET_FAILURE;
+	}
+
+	dns_cb_arg.done = false;
+
+	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
+
+	if (ret == ERR_OK) {
+		dns_cb(name, &ipaddr, &dns_cb_arg);
+	} else if (ret == ERR_INPROGRESS) {
+		start = get_timer(0);
+		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
+		do {
+			net_lwip_rx(udev, netif);
+			if (dns_cb_arg.done)
+				break;
+			sys_check_timeouts();
+			if (ctrlc()) {
+				printf("\nAbort\n");
+				break;
+			}
+		} while (get_timer(start) < DNS_TIMEOUT_MS);
+		sys_untimeout(do_dns_tmr, NULL);
+	}
+
+	net_lwip_remove_netif(netif);
+
+	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
+		return CMD_RET_SUCCESS;
+
+	return CMD_RET_FAILURE;
+}
+
+int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	char *name;
+	char *var = NULL;
+
+	if (argc == 1 || argc > 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+
+	if (argc == 3)
+		var = argv[2];
+
+	if (net_lwip_eth_start() < 0)
+		return CMD_RET_FAILURE;
+
+	return dns_loop(eth_get_dev(), name, var);
+}
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5df222589b8..255c7d018b0 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,7 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
-obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
deleted file mode 100644
index 19172ac959a..00000000000
--- a/net/lwip/dns.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/* Copyright (C) 2024 Linaro Ltd. */
-
-#include <command.h>
-#include <console.h>
-#include <lwip/dns.h>
-#include <lwip/timeouts.h>
-#include <net.h>
-#include <time.h>
-
-#define DNS_RESEND_MS 1000
-#define DNS_TIMEOUT_MS 10000
-
-struct dns_cb_arg {
-	ip_addr_t host_ipaddr;
-	const char *var;
-	bool done;
-};
-
-static void do_dns_tmr(void *arg)
-{
-	dns_tmr();
-}
-
-static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
-{
-	struct dns_cb_arg *dns_cb_arg = arg;
-	char *ipstr = ip4addr_ntoa(ipaddr);
-
-	dns_cb_arg->done = true;
-
-	if (!ipaddr) {
-		printf("DNS: host not found\n");
-		dns_cb_arg->host_ipaddr.addr = 0;
-		return;
-	}
-
-	if (dns_cb_arg->var)
-		env_set(dns_cb_arg->var, ipstr);
-
-	printf("%s\n", ipstr);
-}
-
-static int dns_loop(struct udevice *udev, const char *name, const char *var)
-{
-	struct dns_cb_arg dns_cb_arg = { };
-	bool has_server = false;
-	struct netif *netif;
-	ip_addr_t ipaddr;
-	ip_addr_t ns;
-	ulong start;
-	char *nsenv;
-	int ret;
-
-	dns_cb_arg.var = var;
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return CMD_RET_FAILURE;
-
-	dns_init();
-
-	nsenv = env_get("dnsip");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(0, &ns);
-		has_server = true;
-	}
-
-	nsenv = env_get("dnsip2");
-	if (nsenv && ipaddr_aton(nsenv, &ns)) {
-		dns_setserver(1, &ns);
-		has_server = true;
-	}
-
-	if (!has_server) {
-		log_err("No valid name server (dnsip/dnsip2)\n");
-		net_lwip_remove_netif(netif);
-		return CMD_RET_FAILURE;
-	}
-
-	dns_cb_arg.done = false;
-
-	ret = dns_gethostbyname(name, &ipaddr, dns_cb, &dns_cb_arg);
-
-	if (ret == ERR_OK) {
-		dns_cb(name, &ipaddr, &dns_cb_arg);
-	} else if (ret == ERR_INPROGRESS) {
-		start = get_timer(0);
-		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
-		do {
-			net_lwip_rx(udev, netif);
-			if (dns_cb_arg.done)
-				break;
-			sys_check_timeouts();
-			if (ctrlc()) {
-				printf("\nAbort\n");
-				break;
-			}
-		} while (get_timer(start) < DNS_TIMEOUT_MS);
-		sys_untimeout(do_dns_tmr, NULL);
-	}
-
-	net_lwip_remove_netif(netif);
-
-	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
-		return CMD_RET_SUCCESS;
-
-	return CMD_RET_FAILURE;
-}
-
-int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	char *name;
-	char *var = NULL;
-
-	if (argc == 1 || argc > 3)
-		return CMD_RET_USAGE;
-
-	name = argv[1];
-
-	if (argc == 3)
-		var = argv[2];
-
-	if (net_lwip_eth_start() < 0)
-		return CMD_RET_FAILURE;
-
-	return dns_loop(eth_get_dev(), name, var);
-}
-- 
2.43.0

