Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1175BEE8000
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D3E86A40;
	Fri,  8 Sep 2023 15:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f+88xNSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF0F86A43; Fri,  8 Sep 2023 15:55:41 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD77A86A63
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2be5e2a3c86so38309531fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181337; x=1694786137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTROnAHtoOcj9HwLA+i64O3iQOqf+PBBq8BxgaJV7hY=;
 b=f+88xNSBoh3xNDVqTlFJ17zdO6TTgMUp+znf2m3Oo361liT2VbFwlGefOzcOS2oDfv
 Qi44mMbdVytSNCLYcRonHKh1YPDgyE9zKmOcCYM2soul7SwTgvyu5BebR7Pcx3nX1f+M
 9g/cH/zMd6u1tRZw/+bqbP0o7S2GTRzIyKXy8YwHQM494wDJTwD6Ho3wUVRHiQ0ZWjdA
 muPbq61/1cn3d74EkTHrNkDXQwgCAMMWkGb3c8ucOnlCMJRtA/Ink7LK/R9geT9xx5bU
 KIYyi0uLnjbHDf25b3DPt+oByY9gx7U5Esw44G7suU5hg1So2VyscH/QHJCPltgxRyiT
 Qm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181337; x=1694786137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTROnAHtoOcj9HwLA+i64O3iQOqf+PBBq8BxgaJV7hY=;
 b=DE5wdgnSz+teXQR3a0Gz9JfBFkKH7uJ5YVsQ5eX/K32hXZqOECiRwZx98tu+zWH/7o
 g2yr1WBxlnC64JcSi6/0r+Azjw+ogd0Om/VKSvJGWBcXuUL2GZyIOgYe77aO7FvEdA+i
 ZUJHRtzrtxXe7qW0ri6cqoJupACjbQl3HxTSRHHTp2/e8q8ISSB26nnM6LpJgo0DQFvC
 i/7ECqe6bCdEcK4bOWf4n+FSW8h8MAlbXV5qo1bkJxffad0A3wN4XimXo81/mNTDJKIx
 cM5CpB86/vd/KDRU4N3PufSJeI3YtvZxs1lDiV/ryKlAS5b+xRQgYhp26eZUmBfc3vBW
 8Egg==
X-Gm-Message-State: AOJu0YxrXLoBQz5oRKuFVv3y+rhikgvUmy1qUAAmaeD1pvkvIGUzeeaq
 m9TXI+Nxaku0ROvnYh+HkkX9qPRiFw46qJDKmwqtjA==
X-Google-Smtp-Source: AGHT+IHuT1C9VGdNescFqE2Cl5fkBpo9gYXuV++9pnZ0rCccItbIaVgugSaiSoNGLheFKa3lQM2Jvw==
X-Received: by 2002:a2e:8285:0:b0:2b6:eceb:9b8 with SMTP id
 y5-20020a2e8285000000b002b6eceb09b8mr960059ljg.10.1694181336766; 
 Fri, 08 Sep 2023 06:55:36 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:36 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 03/15] net/lwip: implement dns cmd
Date: Fri,  8 Sep 2023 19:53:08 +0600
Message-Id: <20230908135320.7066-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
index 0000000000..b340302f2c
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
+	if (ipaddr_aton(dns2env, &dns2))
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

