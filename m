Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA28EEAA55
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A357986A50;
	Thu, 14 Sep 2023 18:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bkO6trnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFC886A50; Thu, 14 Sep 2023 18:20:47 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA4286A9C
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso18082901fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708445; x=1695313245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=bkO6trnApQ8vHjzOStkMMkxmbBA+rIOYSGch/J4lTeml5R16vWxi6Ea04GlN5HfzJZ
 xwN2T2dwPvEH4yz7fOckDtJrb8FzvBp9TebrDNO+c9tNcnKxvmgaQnvx+gF5GaALCTet
 38HxCF844cedPYjA+QhxgvIoVx4s+hpV3l/QGiu5f8sOYRZoSiLsIege2m0jcbhOBdZS
 50TVFlLDyVDPqOaJIjzSXzZcCvKj3NXllgo0sliPXwEC6BqtQxzzGqUuqaTtqnttVpLq
 zIY5Z/iOv0xq2arlOou0MbSQ8ShMjOoZESxR916N2/bbpus/ExikCiFEVV9dhFCWfMxY
 e3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708445; x=1695313245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=HZDSqsyJlsv2YDsZpA6EBEamD/QxSfC5qFm0eZhsd6Uqp7Tvws71Rn793jsFhvkDeF
 X4AdPasJxNkbSwTBF+quKMEmMVvD/buXGDbV090sfXQ2TZUhXHkpG5vKPM5Cwn0dQfeZ
 mrBqQJ++uHYujQPhkD9klD+xFcHuYoFc6WOivPLBelF4Ji3PZ/+MPdrLfNDK+rsJ92TR
 t7chrOOzmsn1U9Ps7Hq1BHpkwsJFIreNvOr6oC6DDYY8EoRmErRk6KJqYdjMMObcd7uw
 0vOc/ctFHKhA9KoeNEqLcf5xwoYBnWuKGgDFdkVleQd9zDr8lhHCp/Rv7bGhT9KONh3o
 ermA==
X-Gm-Message-State: AOJu0YwDG1TwqQFBbqBAs4fFTDG0XGlholyxMNnkV7ZyhePGKAwZkKux
 TDr59PLNoqfZ+rjGmqzE6j5X+AjjCMjkJarfrEirzQ==
X-Google-Smtp-Source: AGHT+IHngziXi0ob2uY+T1pXnrdjmSZW2tynmAEajwMm/rcvgunaLamzSAMCMIG0H0Yke9lIAAoWTg==
X-Received: by 2002:a2e:80d3:0:b0:2b6:df23:2117 with SMTP id
 r19-20020a2e80d3000000b002b6df232117mr6067969ljg.43.1694708445018; 
 Thu, 14 Sep 2023 09:20:45 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:44 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 04/15] net/lwip: implement dns cmd
Date: Thu, 14 Sep 2023 22:18:17 +0600
Message-Id: <20230914161828.3662-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

