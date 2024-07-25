Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26BAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F88B87C86;
	Thu, 25 Jul 2024 14:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NsN8ZHxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC69E87C86; Thu, 25 Jul 2024 14:59:02 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8503787FFB
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso1323151fa.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912340; x=1722517140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGWTOXqNdRIperYSS8DoFfsaCh1i2R1ngqFOlmQG2xQ=;
 b=NsN8ZHxWrmbvsuMSdcm5VbWa1guocNPr4TmknNewO2s2q6oy4r4i+aTyem3/y6z0AU
 HfUEkY9I/IiTZlgTRwxvuHLYZsYEd7wRkSYb/N4iizsOzkhjasaW8uYjAD2yUT/TC3ou
 kwRYHftQ62UnCGh5iiaM1zQaIWfK0TLXA8FvUmGT4WZMMas6rn4mgw/WWWPtR3vfXwU6
 L04XPiiOAhdlkyRA3F2uGoqVW0gyp5+IDboDmcjsFbJrsPwdcSzfkKACXFnPvdFBgDvW
 5RpsX3+OiS4jhyhSudFQ+/A4HPxlGmReqSRz8y6MZEseU4haJ6p7aTPRhe0NC0jH7rLD
 og5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912340; x=1722517140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGWTOXqNdRIperYSS8DoFfsaCh1i2R1ngqFOlmQG2xQ=;
 b=Fd2J2KZqJvlWBacWQqmN53fyM36Yb/d4bZyj3rWhXrI5FGb0W2lHGMmZF781zxB45z
 Ww+hBJWghQPd14ULF7l11U3lOl2EhYBMlAWjnozcVQbQuJBBXkudmqRGCWcqORschvbR
 VHf7N2Xh2PzGSqjntW935Zy/wtVtfzytxFbao+PkQ0jc4xLX+YwAk46lvQIGsddiDvKB
 A8tWhcYjj+m7bb/SFlwdMhUcqinApRk8vOFcPvbWeppx/GoRCePp8nly8zkoAOwhexqB
 jwB8SSSyRO8l0mB+3d+EvLred0cM7rrN/ez2mJ5yzyqb8pv4vnCFWAu6N4uAvrRSI3G8
 DJUg==
X-Gm-Message-State: AOJu0YwpXHJnA05Rs6MKKi6W+daQCqqYC3g0c9lxc3VD1bjuEhh48+Gv
 2URDsNfiCKkP0bb+UAgfC6klmafwDQSGrjoosxuVrfrgWV5V8u4RRE0OF1Vb58WLgcMQ4lUb6JZ
 cauK8/A==
X-Google-Smtp-Source: AGHT+IHl+mT6+gO19PIDBgxTQAPV87BkWPnX2sigobZ5XjPl5M2+HtiTfxccTAXTB0fiCfuy3qGzoQ==
X-Received: by 2002:a2e:9990:0:b0:2ef:2b08:1742 with SMTP id
 38308e7fff4ca-2f03dbf3baamr11951911fa.48.1721912339550; 
 Thu, 25 Jul 2024 05:58:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:58:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v5 11/20] net-lwip: add dns command
Date: Thu, 25 Jul 2024 14:57:32 +0200
Message-Id: <418eacfeff8442106d3df8a5bf787fb5eb6fbf09.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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
index 21188a763cf..a862b6415dd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2034,11 +2034,6 @@ config CMD_SNTP
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
@@ -2093,6 +2088,12 @@ config CMD_DHCP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_DNS
+	bool "dns"
+	select PROT_DNS_LWIP if NET_LWIP
+	help
+	  Lookup the IP of a hostname
+
 config CMD_PING
 	bool "ping"
 	select PROT_RAW_LWIP if NET_LWIP
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
index 58640c04a7f..cb60537f9f3 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -13,6 +13,7 @@ struct netif *net_lwip_get_netif(void);
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

