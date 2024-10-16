Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9F4D1AD3B
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549DA88FD8;
	Wed, 16 Oct 2024 12:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tqBKtzYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8230C88FF7; Wed, 16 Oct 2024 12:05:06 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7151388FCF
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so3942520e87.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073103; x=1729677903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a16hgTGIRnm047tRjSQePaRdLFWpRxqync/ll9wn4W0=;
 b=tqBKtzYv0xnfdbrEMfLM91JBgGAKv9527ZoJVxwHiMvZdNbzmRtjDPeUkGG1l8VTJy
 sOIIpc4tJ5LczMLtVHUgLucOJeXSMImiCw88wlwW7xShmYyoqW+5iAGSpI4gzA5O/81y
 6xLZ4M1mnIP/4WfJUBiwcRRJ+M0QzHvYg6FC6b7+CKUGGaJAF3fzWadj8x0Tzrxe9pR8
 7lac8s8aICxx8fmr1EK1ToKCBXLD90c/AMuXlDfll9/l2gkRT6O5DW25bzkzZ8RfyOvx
 te1cU09vPFLEvRujutiRyCQ05+NkcJ3QPF0jm+Dta7MF9JvTkE3/TqB4TWpudGI+mU0g
 GTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073103; x=1729677903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a16hgTGIRnm047tRjSQePaRdLFWpRxqync/ll9wn4W0=;
 b=h9FahdqwOpfYH4wYkrHyTveGv1hjWyjBY1hjMVLNRyxpJWKZljOoravjG5oUwTGI1U
 4GLGPWhmiAlMN6JFnxKWV2/ECKAokdo4R0FrNa/jw/lHMrRL5W8d3y0M/+L6EsrhKd4v
 n4AP43f8zNxKDeVvt9Bf39NFtEkIoPagc5cfEXzjCn/HMsS5IZjlXz63HcmX2rKR3pzd
 AebNEHREWAic18+eanFAzVIOFQQ2ANZk0viZ9HIQ2gCw6oH1lmJyphX52T9HuhlME2A2
 NpX8M6Dxwq2im2ivIwZiZVWPax+nWSBaIaZ20rv1BL+u7AhldboUSadQt2bhDuyf/Dit
 u6Rg==
X-Gm-Message-State: AOJu0YxECIoR9RjgGCzMup9o16bwPpnIuRRMitIYqBCY7CeR9oAdigbI
 ATnZz5lml5ksApV2H/k2qRZ9dUiFW3+WfBOsHB9a+nKihj2Dj6T29nCRRK0SU2ECQIJbH8f+nN+
 kFq8Wj6X3
X-Google-Smtp-Source: AGHT+IHqssyIUrHmUUKNcfB6E2hyn2qU5korfDrULM/XsX2c8y9n5LBKrvWcSlqu0/EFyayqZKYoNA==
X-Received: by 2002:a05:6512:318b:b0:539:f699:bb29 with SMTP id
 2adb3069b0e04-53a03f18c46mr2315203e87.15.1729073103396; 
 Wed, 16 Oct 2024 03:05:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:05:03 -0700 (PDT)
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>
Subject: [PATCH v13 13/21] net: lwip: add dns command
Date: Wed, 16 Oct 2024 12:04:07 +0200
Message-Id: <6a7582ab314aca691738c0a0ec68d45b9bf335eb.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

Add CMD_DNS when NET_LWIP is enabled to provide the dns command using
lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig        |  11 ++--
 cmd/net-lwip.c     |   8 +++
 include/net-lwip.h |   1 +
 net/lwip/Makefile  |   1 +
 net/lwip/dns.c     | 127 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 net/lwip/dns.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b7d1dd028a1..2791ad5393c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2027,11 +2027,6 @@ config CMD_SNTP
 	help
 	  Synchronize RTC via network
 
-config CMD_DNS
-	bool "dns"
-	help
-	  Lookup the IP of a hostname
-
 config CMD_LINK_LOCAL
 	bool "linklocal"
 	select LIB_RAND
@@ -2079,6 +2074,12 @@ config CMD_DHCP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_DNS
+	bool "dns"
+	select PROT_DNS_LWIP if NET_LWIP
+	help
+	  Lookup the IP of a hostname
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index feed719beef..c021da6a674 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -27,3 +27,11 @@ U_BOOT_CMD(
 	"[loadAddress] [[hostIPaddr:]bootfilename]"
 );
 #endif
+
+#if defined(CONFIG_CMD_DNS)
+U_BOOT_CMD(
+	dns,	3,	1,	do_dns,
+	"lookup the IP of a hostname",
+	"hostname [envvar]"
+);
+#endif
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 9aa371e962c..ff9d03b23e8 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -17,6 +17,7 @@ struct netif *net_lwip_get_netif(void);
 int net_lwip_rx(struct udevice *udev, struct netif *netif);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index b5af37a9b18..645d8a8c457 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,5 +2,6 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
new file mode 100644
index 00000000000..4b937feaee1
--- /dev/null
+++ b/net/lwip/dns.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
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
+		return -1;
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
+	eth_set_current();
+
+	return dns_loop(eth_get_dev(), name, var);
+}
-- 
2.40.1

