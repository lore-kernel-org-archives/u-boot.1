Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E429C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 10:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A41F835FD;
	Fri, 18 Jul 2025 12:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JQ5v/xGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A3283623; Fri, 18 Jul 2025 12:49:14 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51EFD835B3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so904403f8f.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752835751; x=1753440551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i7/kERlNBthTia83by5thLhVXgZMWXVXxt9yrFyV1R8=;
 b=JQ5v/xGMiINvD7HKywqPiFULjKOwB7kFljqRU7WQRahdd6KhlzhXzRg6p8eYnXlapd
 H6cg6aoD6WNZavdMP5BqCTKJboMtBwYL4mo5IqofSgeEOyRlKT7bjt7m+Kip3VzsZMyb
 M4HuB5XDpj40D2eKJAOGgEZm05iEOqzgbrSbcFJ3OOMRjh25KqIQkTSyzvUPfy8HIkXQ
 2IYdM8Tb/wY0QRjEG3Tb2/p1riy47JyiQFt8/4lV+o0WWCGSCjCn1/RFyiD7uegd2yFy
 tv+VKG6rY8oCmtvdRIfkqFyl9rkuM52DznJ51xMo4e0ZnGTZdCo7eksXRfeJwCdpOfP/
 nx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752835751; x=1753440551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7/kERlNBthTia83by5thLhVXgZMWXVXxt9yrFyV1R8=;
 b=cMROUi6pGDEKN6Ykzqzvn0YfrSNo36nToTuHUZGlr+0o33zlY/qd/sYRGJFzuhgpkB
 +mEggVN8F6FL0xZHs9uZyzCWuOWlLgAQVOy0xe/JfTNZNd6Hr7csoKzzkaPD2rjv055B
 UcTsXBKbv1Na5iKMZ7EqcXH927z7cYUKHZlCZw82d3AKSgvH2fMaxVp5txquh9tXeyiA
 fj4yZjB6+pzzIpiYK+3pC0pSZ3ifzMOK/+NOmSOC/bosmQ2qsPXIUSvBsMLmKa6dpA2Q
 zKGfCLuN5SQOIF6Nuu8eJLxUZJotUdWYse+9yps0ECCwkJVtn3mgr8aLGrkGOE6+Ehde
 GSJA==
X-Gm-Message-State: AOJu0YzeSRD5TJCsIAxkN1xNi1l3jotFsHQQey9y5DFLdoCbyPcxRMb1
 2H2LgBo8db0PRQrD0roy0EtAxucNMT0M6A20qqh7Cdwne33oOtHjFguuelYaUAcUwW8R03U/X9/
 /ctuVtcQ=
X-Gm-Gg: ASbGncvAaJsyZKuosNb9EcMQkcZjCq2iNAarum9SxXkroY0sDdKJ5AF7CA/kDbsTDAH
 1hhQIgZMcYLQcUQupEcEHVfAg0U3+7q38NeE8BKCUqC32KcWrZHK9HoM/RrEulwfpbVYq02sMqv
 znXxQKRZm8uJS1Rqxp7Bvled0trQBowpeE6daZruPshXlKBnZ03sOLCvRSBKn84NijSv+FhSlLB
 kmfa80eLtNVLZp2fYZKQ5+SeLggHfZDtNeHrIhvQ0l2sltZGKQRoW6nYwil6a/tLPEgjRFBL7Wo
 vv3jkiOCoUsbY1MTtAzD8Eov1+J7BbSCKYSX4ejszMykHqJImMUwudfJoGgw8+MuCanHL/JGSRm
 QzVgqP5E5zXrwZ6I9eJ4z6vf8kVNT1A==
X-Google-Smtp-Source: AGHT+IHgVQLtLr784qKCB8oJhaquzIVKmAvlcuQ2x9ZtLECH/NvJj/rXRrHq0/H7oLW9z/KSQbq08Q==
X-Received: by 2002:a05:6000:490c:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3b60e5531d6mr6569830f8f.58.1752835751145; 
 Fri, 18 Jul 2025 03:49:11 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2f7f:79e1:d80d:c17])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c8dfsm1476577f8f.82.2025.07.18.03.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 03:49:10 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, E Shattow <e@freeshell.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: introduce CONFIG_DNS
Date: Fri, 18 Jul 2025 12:48:48 +0200
Message-ID: <20250718104852.724720-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Introduce the DNS Kconfig symbol so that various network commands may
use host names without the dns command (CMD_DNS) being selected.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
CC: E Shattow <e@freeshell.de>
---

 cmd/Kconfig            |   2 +-
 cmd/lwip/dns.c         | 108 ---------------------------------------
 doc/usage/cmd/sntp.rst |   8 +--
 doc/usage/cmd/wget.rst |   2 +-
 include/net-legacy.h   |   2 +-
 net/Kconfig            |   8 ++-
 net/Makefile           |   2 +-
 net/lwip/Makefile      |   1 +
 net/lwip/dns.c         | 113 +++++++++++++++++++++++++++++++++++++++++
 net/lwip/net-lwip.c    |   6 +--
 net/net.c              |  10 ++--
 net/wget.c             |   2 +-
 12 files changed, 138 insertions(+), 126 deletions(-)
 create mode 100644 net/lwip/dns.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b3b5be1ea79..7a9c4ddb215 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2110,7 +2110,7 @@ config CMD_DHCP
 
 config CMD_DNS
 	bool "dns"
-	select PROT_DNS_LWIP if NET_LWIP
+	select DNS
 	help
 	  Lookup the IP of a hostname
 
diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index b5fccc7433e..3eb698b3f82 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -2,115 +2,7 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
-#include <console.h>
-#include <env.h>
-#include <lwip/dns.h>
-#include <lwip/timeouts.h>
 #include <net.h>
-#include <time.h>
 
 U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
 	   "hostname [envvar]");
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
-	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
-
-	if (dns_cb_arg->var)
-		env_set(dns_cb_arg->var, ipstr);
-}
-
-static int dns_loop(struct udevice *udev, const char *name, const char *var)
-{
-	struct dns_cb_arg dns_cb_arg = { };
-	struct netif *netif;
-	ip_addr_t ipaddr;
-	ulong start;
-	int ret;
-
-	dns_cb_arg.var = var;
-
-	netif = net_lwip_new_netif(udev);
-	if (!netif)
-		return CMD_RET_FAILURE;
-
-	if (net_lwip_dns_init()) {
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
-	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
-		if (!var)
-			printf("%s\n", ipaddr_ntoa(&ipaddr));
-		return CMD_RET_SUCCESS;
-	}
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
diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
index d97f83053f7..2046828130d 100644
--- a/doc/usage/cmd/sntp.rst
+++ b/doc/usage/cmd/sntp.rst
@@ -12,7 +12,7 @@ Synopsis
 ::
 
     sntp [serverip]
-    sntp [servername]  # NET_LWIP=y && CMD_DNS=y only
+    sntp [servername]  # NET_LWIP=y && DNS=y only
 
 
 Description
@@ -27,8 +27,8 @@ The address of the NTP server does not need to be given if the DHCP server
 provides one. The legacy network stack (`CONFIG_NET=y`) can only use the
 first NTP server provided in the `ntp-servers` DHCP option.
 
-When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and the dns command
-is enabled (`CONFIG_CMD_DNS=y`), then the sntp command accepts a server
+When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and DNS resolution
+is enabled (`CONFIG_DNS=y`), then the sntp command accepts a server
 name as an argument.
 
 The network time is sent as UTC. So, if you want to set the RTC to any local
@@ -61,7 +61,7 @@ Examples
     => date
     Date: 2025-06-16 (Monday)    Time: 17:19:57
 
-With `CONFIG_NET_LWIP=y` and `CONFIG_CMD_DNS=y`:
+With `CONFIG_NET_LWIP=y` and `CONFIG_DNS=y`:
 
 ::
 
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 06df2842549..8feda0248b2 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -38,7 +38,7 @@ address
     memory address for the data downloaded
 
 host
-    IP address (or host name if `CONFIG_CMD_DNS` is enabled) of the HTTP
+    IP address (or host name if `CONFIG_DNS` is enabled) of the HTTP
     server, defaults to the value of environment variable *serverip*.
 
 path
diff --git a/include/net-legacy.h b/include/net-legacy.h
index a7dbcec1506..7ba5148a75a 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -316,7 +316,7 @@ extern u32	net_boot_file_size;
 /* Boot file size in blocks as reported by the DHCP server */
 extern u32	net_boot_file_expected_size_in_blocks;
 
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 extern char *net_dns_resolve;		/* The host to resolve  */
 extern char *net_dns_env_var;		/* the env var to put the ip into */
 #endif
diff --git a/net/Kconfig b/net/Kconfig
index 24508026200..40ec6bbce76 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -244,11 +244,17 @@ config NET_RANDOM_ETHADDR
 	  generated. It will be saved to the appropriate environment variable,
 	  too.
 
+config DNS
+	bool "Enable DNS resolutions"
+	select PROT_DNS_LWIP if NET_LWIP
+	help
+	  Selecting this will allow the network stack to use server names
+	  in addition to IP addresses.
+
 config WGET
 	bool "Enable wget"
 	select PROT_TCP if NET
 	select PROT_TCP_LWIP if NET_LWIP
-	select PROT_DNS_LWIP if NET_LWIP
 	help
 	  Selecting this will enable wget, an interface to send HTTP requests
 	  via the network stack.
diff --git a/net/Makefile b/net/Makefile
index d63f62b7c8a..468820186cf 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -10,7 +10,7 @@ ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_NET)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
-obj-$(CONFIG_CMD_DNS)  += dns.o
+obj-$(CONFIG_DNS)  += dns.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net.o
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 97299d9b542..90d3300bd12 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -2,6 +2,7 @@ ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
 
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_DNS) += dns.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 obj-$(CONFIG_WGET) += wget.o
 
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
new file mode 100644
index 00000000000..9964003195f
--- /dev/null
+++ b/net/lwip/dns.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <env.h>
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
+	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
+
+	if (dns_cb_arg->var)
+		env_set(dns_cb_arg->var, ipstr);
+}
+
+static int dns_loop(struct udevice *udev, const char *name, const char *var)
+{
+	struct dns_cb_arg dns_cb_arg = { };
+	struct netif *netif;
+	ip_addr_t ipaddr;
+	ulong start;
+	int ret;
+
+	dns_cb_arg.var = var;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	if (net_lwip_dns_init()) {
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
+	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
+		if (!var)
+			printf("%s\n", ipaddr_ntoa(&ipaddr));
+		return CMD_RET_SUCCESS;
+	}
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
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 3918d57d7e5..7069e56065f 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -147,7 +147,7 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
  */
 int net_lwip_dns_init(void)
 {
-#if CONFIG_IS_ENABLED(CMD_DNS)
+#if CONFIG_IS_ENABLED(DNS)
 	bool has_server = false;
 	ip_addr_t ns;
 	char *nsenv;
@@ -369,7 +369,7 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
  */
 int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
 {
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 	char *var = "_dnsres";
 	char *argv[] = { "dns", name_or_ip, var, NULL };
 	int argc = ARRAY_SIZE(argv) - 1;
@@ -378,7 +378,7 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip)
 	if (ipaddr_aton(name_or_ip, ip))
 		return 0;
 
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 	if (do_dns(NULL, 0, argc, argv) != CMD_RET_SUCCESS)
 		return -1;
 
diff --git a/net/net.c b/net/net.c
index 5219367e391..382a27e0a77 100644
--- a/net/net.c
+++ b/net/net.c
@@ -115,7 +115,7 @@
 #include "bootp.h"
 #include "cdp.h"
 #include "dhcpv6.h"
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 #include "dns.h"
 #endif
 #include "link_local.h"
@@ -288,7 +288,7 @@ static int on_vlan(const char *name, const char *value, enum env_op op,
 }
 U_BOOT_ENV_CALLBACK(vlan, on_vlan);
 
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 static int on_dnsip(const char *name, const char *value, enum env_op op,
 	int flags)
 {
@@ -582,7 +582,7 @@ restart:
 			nc_start();
 			break;
 #endif
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 		case DNS:
 			dns_start();
 			break;
@@ -1507,7 +1507,7 @@ static int net_check_prereq(enum proto_t protocol)
 		}
 		goto common;
 #endif
-#if defined(CONFIG_CMD_DNS)
+#if defined(CONFIG_DNS)
 	case DNS:
 		if (net_dns_server.s_addr == 0) {
 			puts("*** ERROR: DNS server address not given\n");
@@ -1540,7 +1540,7 @@ static int net_check_prereq(enum proto_t protocol)
 			return 1;
 		}
 #if	defined(CONFIG_CMD_PING) || \
-	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
+	defined(CONFIG_DNS) || defined(CONFIG_PROT_UDP)
 common:
 #endif
 		/* Fall through */
diff --git a/net/wget.c b/net/wget.c
index 3c0fff488eb..e65ce15ccb3 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -393,7 +393,7 @@ int wget_do_request(ulong dst_addr, char *uri)
 	if (string_to_ip(host_name).s_addr) {
 		s = host_name;
 	} else {
-#if IS_ENABLED(CONFIG_CMD_DNS)
+#if IS_ENABLED(CONFIG_DNS)
 		net_dns_resolve = host_name;
 		net_dns_env_var = "httpserverip";
 		if (net_loop(DNS) < 0) {
-- 
2.43.0

base-commit: 0f83825802d8938fb584c12f115bde900efe71c1
branch: introduce-dns-kconfig
