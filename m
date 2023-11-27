Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49240C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E33D8757D;
	Mon, 27 Nov 2023 14:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KzoZiYzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C728757C; Mon, 27 Nov 2023 14:00:24 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FE987569
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50ba71356ddso3382730e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090018; x=1701694818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=KzoZiYzjExJgGljbru+NQWEmeDZyMiFcXdE4AY1SoeuI0u/qv+YNw3F3XEofIfCBUi
 MDVbSKZru41K/VbN+J9FVBcl5mOxfHo3/B1rHK2SbXuqbFcvHMaSpy0IRpIDPii0HNlt
 m5oKOIamr5S5JnDdylQD/MMGZgTXkv/P/4voRCf8q0k3rJ8IupDNrTYdaoqbP6avKBbk
 N4VGR0z3CLyQH+5zxIkEVm4++uO+lcGvwHIMOAGZ1F8bhqOVxPIg1KRg1zFpJrR+LO2k
 Cuiu98n1wslaX55OHl5xiWRFGte+KanWAyiiZvJWtFwgBx2WdZar39cjmQiXW7ZKU5DL
 AG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090018; x=1701694818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=mcOcAp+u61J6VaMVVq4aVOS8RqiSlj82jXOOkb0Fvi3L3RR7wlFKO4dnBrhNil/nAZ
 Kk3YIkZwcnVCceKEj+IiDFC37ZQ+YdVdSkRa9+OIlgoA0/VI5P0VsZUJFT/YPAAVeK2k
 ZLq3kyzcLxfeO0V9I3ZCvI2uX0Vgm96Fuu6aaJ5xmz+DGSVZrrn93GMTwMSMnukeyRP9
 vefYq39SQJHUQzH7wj7gtr0JhrfOBnLQgLDBtuqVAZjPapCnUvcH4u8PG7vDwhpwnMOC
 HATMm6x8lFFqSqgg5/JALoOl0j1CRWWOLfb1IsPFrmSsknTvF9WB113yq6Jf+YPdw/Tz
 XTUQ==
X-Gm-Message-State: AOJu0Yw6LVL+w7lWhEG7AJbwKr6xlbJiKUmvdBlmdcvel7ywcPQXwO4e
 UBA86ObQGgeSlyXIwOC+l+JczxN15AC70miDUZQ36A==
X-Google-Smtp-Source: AGHT+IER0ZPmyF317zYUCjuB95UKZ7iSgP6ENPZyxS21qqCUi1gcA5Mb05ZLojIowhVcFEZJbhaYBA==
X-Received: by 2002:a05:6512:b07:b0:4f8:7513:8cac with SMTP id
 w7-20020a0565120b0700b004f875138cacmr7553451lfu.48.1701090017933; 
 Mon, 27 Nov 2023 05:00:17 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:17 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 04/43] net/lwip: implement dns cmd
Date: Mon, 27 Nov 2023 18:56:47 +0600
Message-Id: <20231127125726.3735-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

U-Boot recently got support for an alternative network stack using LWIP.
Replace dns command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h           | 19 +++++++++++
 net/lwip/Makefile            |  2 ++
 net/lwip/apps/dns/lwip-dns.c | 63 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 include/net/lwip.h
 create mode 100644 net/lwip/apps/dns/lwip-dns.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
new file mode 100644
index 0000000000..ab3db1a214
--- /dev/null
+++ b/include/net/lwip.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
+		char *const argv[]);
+
+/**
+ * ulwip_dns() - creates the DNS request to resolve a domain host name
+ *
+ * This function creates the DNS request to resolve a domain host name. Function
+ * can return immediately if previous request was cached or it might require
+ * entering the polling loop for a request to a remote server.
+ *
+ * @name:    dns name to resolve
+ * @varname: (optional) U-Boot variable name to store the result
+ * Returns: ERR_OK(0) for fetching entry from the cache
+ *          -EINPROGRESS success, can go to the polling loop
+ *          Other value < 0, if error
+ */
+int ulwip_dns(char *name, char *varname);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 3fd5d34564..5d8d5527c6 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -62,3 +62,5 @@ obj-$(CONFIG_NET) += lwip-external/src/netif/ethernet.o
 
 obj-$(CONFIG_NET) += port/if.o
 obj-$(CONFIG_NET) += port/sys-arch.o
+
+obj-y += apps/dns/lwip-dns.o
diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
new file mode 100644
index 0000000000..3ee6e24ef4
--- /dev/null
+++ b/net/lwip/apps/dns/lwip-dns.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+
+#include <lwip/dns.h>
+#include <lwip/ip_addr.h>
+
+#include <net/ulwip.h>
+
+static void dns_found_cb(const char *name, const ip_addr_t *ipaddr, void *callback_arg)
+{
+	char *varname = (char *)callback_arg;
+	char *ipstr = ip4addr_ntoa(ipaddr);
+
+	if (varname)
+		env_set(varname, ipstr);
+	log_info("resolved %s to %s\n",  name, ipstr);
+	ulwip_exit(0);
+}
+
+int ulwip_dns(char *name, char *varname)
+{
+	int err;
+	ip_addr_t ipaddr; /* not used */
+	ip_addr_t dns1;
+	ip_addr_t dns2;
+	char *dnsenv = env_get("dnsip");
+	char *dns2env = env_get("dnsip2");
+
+	if (!dnsenv && !dns2env) {
+		log_err("nameserver is not set with dnsip and dnsip2 vars\n");
+		return -ENOENT;
+	}
+
+	if (!dnsenv)
+		log_warning("dnsip var is not set\n");
+	if (!dns2env)
+		log_warning("dnsip2 var is not set\n");
+
+	dns_init();
+
+	if (ipaddr_aton(dnsenv, &dns1))
+		dns_setserver(0, &dns1);
+
+	if (dns2env && ipaddr_aton(dns2env, &dns2))
+		dns_setserver(1, &dns2);
+
+	err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
+	if (err == ERR_OK)
+		dns_found_cb(name, &ipaddr, varname);
+
+	/* convert lwIP ERR_INPROGRESS to U-Boot -EINPROGRESS */
+	if (err == ERR_INPROGRESS)
+		err = -EINPROGRESS;
+
+	return err;
+}
-- 
2.30.2

