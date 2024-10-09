Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E4CEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB3B89114;
	Wed,  9 Oct 2024 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kb4Yf/qm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16A0890B4; Wed,  9 Oct 2024 16:50:35 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F32A288FA4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43056d99a5aso6334375e9.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485432; x=1729090232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ubG2lit5fRTcucj61zb2aJsODDvivlWu5jnadR9Ty0=;
 b=Kb4Yf/qm1H4YNizIFV6NB6iiSW7GKVaPHlZNoKcvXriVWzpVAFo5rfsdtiCbZ9XWnr
 N9eAqjq6/JQium5M2A5L7sqJbV4arzJi+fzgAwnaFcmvK2HrLpzxVO5yhmxWWtEeOGbF
 NreFwGBCkaV0ux/L4BcfKDnACzP+k9KWzyhFJTBFxue1d0HDSD3HqSGXvh68eLu+F0uG
 sW+akYap9E0I6ZmkiZiqHD6lK9xyKnY/g7fXmw5bsFOHH0IwTz6+BJA7EMoqC6Whl6q5
 m1u71fb8hGU1bdvq0Lj3RXCRYZQk/wDJA3l+RVVwJgiOUBxPaozsVauO3c268A8vK6HF
 e9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485432; x=1729090232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ubG2lit5fRTcucj61zb2aJsODDvivlWu5jnadR9Ty0=;
 b=h+LsNBi2yaAa3stIytIj3YMgrhDWRYviNf5AaJ/mO//sRMgjuijlvgnhIc/m2EIvBI
 9y4suJOIEXkbRmJ2f6ZlBmI0YFZCR7TX/9XUUKxBCbIFvuZzfnRkbdl4cgpcSdZCZ8sy
 DIqLSvB6YMzywiwkOCtRq8HrrX+bjqset8OPVOwDDYejSI3F6EzHMrUdrBZeEXEcA0aR
 hGjExNuofZVmatBFyBjDxkQKKF1bLkIgsrZ/R/jnqOBSHOz58wjSiCz3ZUzvgFjvqpki
 sGLaq5htkrVi/9lHWmZRRE8taOiqzFsI9wfz62Lz0l83TSDhlmXrghHtcvzf+eACDBxP
 l3+Q==
X-Gm-Message-State: AOJu0YwJDh65zbLdwKtATzncnUFC+NKOhfyDUCbp+1qblVTU9gRJRirL
 +5/ECm0QlfGb/J1GBFH/hg6xC2lFPgj04CP/9iPuDnNT2Jsz5cF7ewt0hWc8hooHLtx3aWsLHUZ
 343Gmzdjm
X-Google-Smtp-Source: AGHT+IEuRQ+tY/fDaE2CAGggTYBeBqfzA2ZraGwLrvLXr3IKh6PLvw71oVUfgiTQM7w5y2vVKuKksg==
X-Received: by 2002:adf:eac7:0:b0:37c:c4c0:4545 with SMTP id
 ffacd0b85a97d-37d3a3681aamr2000025f8f.10.1728485432185; 
 Wed, 09 Oct 2024 07:50:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:31 -0700 (PDT)
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
Subject: [PATCH v12 13/21] net: lwip: add dns command
Date: Wed,  9 Oct 2024 16:49:54 +0200
Message-Id: <6e81886b923e3d7c59fc9996b164b4399f65f14a.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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
index 132835e43f8..6a3920a162b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2042,11 +2042,6 @@ config CMD_SNTP
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
@@ -2094,6 +2089,12 @@ config CMD_DHCP
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

