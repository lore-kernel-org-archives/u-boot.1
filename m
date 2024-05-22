Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53BC25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8904B87F19;
	Wed, 22 May 2024 18:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QoXM0yp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9772E87E06; Wed, 22 May 2024 18:04:35 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5A08884F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so737598566b.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393872; x=1716998672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUPG4lj0pxaUd87pLoDdYDp33QqrXCu/d9Wl46gZF60=;
 b=QoXM0yp+fEryXnmZO2zTN+/IpeKjN639niz1FzoQ3rNnyFYcYRF9h2iu3GKe9NaKvg
 6CdZ7EdJSLdQuw4vFR7NiW6P5PWXj61JZ9YP3himoilZho/fspQ1tIqt54upRuRByodU
 qKJJxRKnaYNEUDmFKjzRAwsYBunx59DPnKddcP/257b4KzX83xcXTHGxotQV6ONDufuI
 dmRSCYmRa4vPzowgCiwRSPlwCleJpVIBA1J4o/fUqZnRmPui/fyVu7/4oqcKzqn3O57y
 6gJ4HG9byFp3spyrTF7tN3JvqS8MbVzigEPeGRFEJnQerekGYsbJingIRQVUSbR8lQ+0
 2W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393872; x=1716998672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUPG4lj0pxaUd87pLoDdYDp33QqrXCu/d9Wl46gZF60=;
 b=u52fhemMFK8rkeug4SjZmbCoJh1keS9DYKd9cRdXJ1ybrujhuVQ1QXu0hi/p7htSD4
 fRVbaxfN8++xUmpUudb4tTYO64fKnekVISBATNXcoZcS0Zx/vpmXA1XxuTHUsU4vA3nk
 lvnppc2vz+zMpb6HnGEWV3kak836SaEqNyTS4qOgXO1haUHRsFBJl+nRh/kNMxOkVnx3
 YQ9LrtxdgdhqJeCt+ZzUhi/WuH1Zko544V3QjDvJypvKTVAEtnf4NctQ5bzk5w3VzJag
 ucru+5eh994OEfQmee1ifmwSt89wEUx4mSATKERQDqxrI+J1nPg+Yw9MmfKgboNHVOgV
 UFgg==
X-Gm-Message-State: AOJu0YwPxYwT9Onw470vK1lQzuRbb7Fs2ze9EvnY5mCUeoH6JrnveYH1
 P3JdHrBbsrhwPiz7FOPxUW6FcdQaDycedvmCysrUQ5OG+XNDmqK2q81zgoaw9qDovzaPTv2zUe7
 cqpFrDtLg
X-Google-Smtp-Source: AGHT+IH9EivgLIY8bWxcHJMk1HNMb0XGBA7bl0rgOPlOtwVd1sLIkQF0QaMqxkTKFiSnVhr9CFcVzQ==
X-Received: by 2002:a17:906:5cd:b0:a59:9e01:e784 with SMTP id
 a640c23a62f3a-a62280b0cdfmr158038166b.5.1716393871929; 
 Wed, 22 May 2024 09:04:31 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 06/15] net-lwip: add dns command
Date: Wed, 22 May 2024 18:00:06 +0200
Message-Id: <2983260a10f0323d5e2d2ee2399d68b995f2d1cd.1716393035.git.jerome.forissier@linaro.org>
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

Add CONFIG_CMD_DNS_LWIP depending on CONFIG_NET_LWIP to provide the
dns command using lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig        |   6 +++
 cmd/net-lwip.c     |   8 ++++
 include/net-lwip.h |   1 +
 net-lwip/Makefile  |   1 +
 net-lwip/dns.c     | 107 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 net-lwip/dns.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6840f7319b..1aba10b14c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2098,6 +2098,12 @@ config CMD_DHCP_LWIP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_DNS_LWIP
+	bool "dns"
+	select PROT_DNS_LWIP
+	help
+	  Lookup the IP of a hostname
+
 config CMD_PING_LWIP
 	bool "ping"
 	select PROT_RAW_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index fbe04048cd..4179861b2d 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -27,3 +27,11 @@ U_BOOT_CMD(
 	"[loadAddress] [[hostIPaddr:]bootfilename]"
 );
 #endif
+
+#if defined(CONFIG_CMD_DNS_LWIP)
+U_BOOT_CMD(
+	dns,	3,	1,	do_dns,
+	"lookup the IP of a hostname",
+	"hostname [envvar]"
+);
+#endif
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 2abaaa3b4e..0019d1524e 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -82,6 +82,7 @@ int net_lwip_init(void);
 struct netif *net_lwip_get_netif(void);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
index 676615fe17..a1f2842855 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP_LWIP) += dhcp.o
+obj-$(CONFIG_CMD_DNS_LWIP) += dns.o
 obj-$(CONFIG_CMD_PING_LWIP) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT_LWIP) += tftp.o
 
diff --git a/net-lwip/dns.c b/net-lwip/dns.c
new file mode 100644
index 0000000000..6ef9d0b510
--- /dev/null
+++ b/net-lwip/dns.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
+#include <net-lwip.h>
+#include <time.h>
+
+#define DNS_RESEND_MS 1000
+#define DNS_TIMEOUT_MS 10000
+
+static ulong start;
+static ip_addr_t host_ipaddr;
+static bool done;
+
+static void do_dns_tmr(void *arg)
+{
+	dns_tmr();
+}
+
+static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
+{
+	char *var = (char *)arg;
+	char *ipstr = ip4addr_ntoa(ipaddr);
+
+	done = true;
+
+	if (!ipaddr) {
+		printf("DNS: host not found\n");
+		host_ipaddr.addr = 0;
+		return;
+	}
+
+	if (var)
+		env_set(var, ipstr);
+
+	printf("%s\n", ipstr);
+}
+
+int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	bool has_server = false;
+	ip_addr_t ipaddr;
+	ip_addr_t ns;
+	char *nsenv;
+	char *name;
+	char *var;
+	int ret;
+
+	if (argc == 1 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (argc >= 2)
+		name = argv[1];
+
+	if (argc == 3)
+		var = argv[2];
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
+		return CMD_RET_FAILURE;
+	}
+
+	done = false;
+
+	ret = dns_gethostbyname(name, &ipaddr, dns_cb, var);
+
+	if (ret == ERR_OK) {
+		dns_cb(name, &ipaddr, var);
+	} else if (ret == ERR_INPROGRESS) {
+		start = get_timer(0);
+		sys_timeout(DNS_RESEND_MS, do_dns_tmr, NULL);
+		do {
+			eth_rx();
+			if (done)
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
+	if (done && host_ipaddr.addr != 0)
+		return CMD_RET_SUCCESS;
+
+	return CMD_RET_FAILURE;
+}
+
-- 
2.40.1

