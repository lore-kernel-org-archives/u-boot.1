Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53DBC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BDD88266;
	Thu,  6 Jun 2024 15:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DtKKr3MT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A803C88266; Thu,  6 Jun 2024 15:37:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE7D878E2
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42133f8432aso6315245e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681028; x=1718285828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDHlmzHpl+YHOey8NZnyOe5HApQ/zxd2XbG7XaVrT+8=;
 b=DtKKr3MTTJ/LheK6hY2BnwYXvAGrqTK50P2Kb6gY3SB75RY64vgcjidIdVvQ90WOxK
 /V75UvetYzX6TFqUY0QQDWqr4eySMElFPZTECTNu3bPhyhedKIn60JeOjMzKmm4tpbtW
 IV4jCQncCZyCyvxPXRLL3pKc+EEgruoMPL89ayygzZ2CRexe+nCkArULBkfIHStb3pbJ
 nkh/8aO5pPho7LVGJbTcpM9JAmSCajixBb6uZyIaKqNMNLRB3lp9bNgrCpYO9Ig3HKy1
 em7SGIG/Ys28EwBR7nLopcFUuJ3tscQ3iOqxXQj1biSFuPzw7XqvpIOTWoj5xFNUvGWI
 +qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681028; x=1718285828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDHlmzHpl+YHOey8NZnyOe5HApQ/zxd2XbG7XaVrT+8=;
 b=AHoJTO3nvsizYHkMwV4XVfHB7itEpt3ciG9wULBFKd+OkmfkKIKCTTTuHfp3c3+49Z
 RnTH1qGEHKr03TAP9WjmyqRxtiwjFiWfZwooQssXg+Skk5crD6Ai0gza5AX8LOlg+wFJ
 Qb8xv6r+PyjtclN9qFTih79KP5D9ZCnkDxeVteq9OtVsulAtHKUkEe4mla3l3PFHPYW7
 Ivqzkyj7PihyZAirw+IrJiXIaGLQRa4GV4wMJNhPsP2cNomJrSsfgyIWtfwyDgZdqTK9
 zzpayuKiee2B1ZkQBX/6Qb5fnwdU/qrlDSbAMg/Qcs6elbdXyi45uQm/Npxh7PpIiAI4
 LPCQ==
X-Gm-Message-State: AOJu0YzA7s9gZlbeFxX/9UC2ekY82Pue99nsOEFTMEYYne1jtLodbwhe
 pEV+H1mLi6ghoqQN9TM61qjwg+CkSodr02g7pbNEk92ZhHJV0H6cIcMxz1q3+Z09HpDkOLwKUy/
 UO8z6MT8T
X-Google-Smtp-Source: AGHT+IHzk/ulfZZ/tCjuY3Es2lsZiPgiHPyDzuSaac6CiMazAkHYKshlE7WvUng02pCoe8xQOOCCSA==
X-Received: by 2002:a05:600c:4515:b0:416:7b2c:df0f with SMTP id
 5b1f17b1804b1-421562cf4admr53805745e9.7.1717681028040; 
 Thu, 06 Jun 2024 06:37:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 06/12] net-lwip: add dns command
Date: Thu,  6 Jun 2024 15:36:01 +0200
Message-Id: <a81309b7d6f3a5bbccc7a5ad45b11f071a3f50b1.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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
 cmd/Kconfig        |   6 +++
 cmd/net-lwip.c     |   8 ++++
 include/net-lwip.h |   1 +
 net-lwip/Makefile  |   1 +
 net-lwip/dns.c     | 107 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 net-lwip/dns.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 07cfe824e3f..6ef0b52cd34 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2098,6 +2098,12 @@ config CMD_DHCP
 	help
 	  Boot image via network using DHCP/TFTP protocol
 
+config CMD_DNS
+	bool "dns"
+	select PROT_DNS_LWIP
+	help
+	  Lookup the IP of a hostname
+
 config CMD_PING
 	bool "ping"
 	select PROT_RAW_LWIP
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 13856703fcf..3abafdf7969 100644
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
index 2abaaa3b4e3..0019d1524e5 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -82,6 +82,7 @@ int net_lwip_init(void);
 struct netif *net_lwip_get_netif(void);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
index e68d4e24197..aa247859483 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
 obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
 
diff --git a/net-lwip/dns.c b/net-lwip/dns.c
new file mode 100644
index 00000000000..24a5149343a
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
+	const char *var = arg;
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

