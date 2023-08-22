Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD388EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF76386485;
	Tue, 22 Aug 2023 11:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AxQUFThd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9348649B; Tue, 22 Aug 2023 11:38:31 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF7386485
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b9db1de50cso65669331fa.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697108; x=1693301908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6UvL/rAJyqCCWVnLAimtdrnI9zk3ZWPC9W5qOPWfBs=;
 b=AxQUFThdqPdHuz3NYIB10y/Exrx1omftlDJ4ii7YZVi5LToToYotwqzfqyafTCSifD
 0hSkJ2ty8ArC76XIDW5Kmd0HReRNQ3EizZD7HDskG7sHf2GIdJT/8AS+Ndlwu7Q8oBmS
 aWZKj69Q6/emrime9DQYxZurpa+0nS3waevRTQWw1AWiIsLi3GdI06DMYsiwpRDnAANY
 8TsIdC5otBumYGH18GycB9XQA0Hp3tQmtxfH837WP1/xM0g3i+FVY9oh/hYcwN5gFl89
 ATznhPsfbT5x+NJD861waPtLdUB9OkT+Ule6SW7l/uHUaSYL7FSkMDtyphEgIW8sWFL/
 lOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697108; x=1693301908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6UvL/rAJyqCCWVnLAimtdrnI9zk3ZWPC9W5qOPWfBs=;
 b=cePNt+CWVagf8vB0AE3r2yABd6qDfoGW5H10QP8X8vYSucZjBcS3ANvzoWyYGFbTDU
 zaF5SlVDinHvFQ8QEkk9GrAVRJ+N/ZttQ1LT22nYHWlQTYl1BFyK91GK6va2401jC6Lk
 iEdBYwqhc/SX5V6tXHtNnGKuxNqeQqsWNcOgoksEsnTnCr6Y7+fXmY61IXE99cRTXSVm
 eM+P41azaPax8rUvVg7QP0HpI1hSd52ff5z3lc67E1TfW4uyUaTPRnG71XxSsVEro4EI
 rYMUzKGDZUxrIoy+xQ06GKZ05LefxOaHULBDrJzxlZfMDSku89ryVvI9rak7MB/CFbIC
 1YsA==
X-Gm-Message-State: AOJu0Ywr6euqjdEevNmQS34OwG28yPK9h0UJ0EqunvZKLyqTniDqYHO9
 onzk7f08zK+w+2V3ZtFGELbrazMOAusGy6Cjbrw+qg==
X-Google-Smtp-Source: AGHT+IGdcSJ/BRxoNnNsd8tNqSwiortwi0f2yD9uT7tDI69tErY16Slup9NzXN8C6IaHQAeEnBeRGg==
X-Received: by 2002:a2e:2404:0:b0:2b6:df8a:d44b with SMTP id
 k4-20020a2e2404000000b002b6df8ad44bmr6159251ljk.36.1692697108422; 
 Tue, 22 Aug 2023 02:38:28 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:28 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 03/15] net/lwip: implement dns cmd
Date: Tue, 22 Aug 2023 15:36:02 +0600
Message-Id: <20230822093614.4717-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
 include/net/lwip.h           | 19 +++++++++++++++
 net/lwip/Makefile            |  2 ++
 net/lwip/apps/dns/lwip-dns.c | 46 ++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 include/net/lwip.h
 create mode 100644 net/lwip/apps/dns/lwip-dns.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
new file mode 100644
index 0000000000..cda896d062
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
+ *         ERR_INPROGRESS(-5) success, can go to the polling loop
+ *         Other value < 0, if error
+ */
+int ulwip_dns(char *name, char *varname);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index d1161bea78..6d2c00605b 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -64,3 +64,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
 
 obj-$(CONFIG_NET) += port/if.o
 obj-$(CONFIG_NET) += port/sys-arch.o
+
+obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
diff --git a/net/lwip/apps/dns/lwip-dns.c b/net/lwip/apps/dns/lwip-dns.c
new file mode 100644
index 0000000000..6e205c1153
--- /dev/null
+++ b/net/lwip/apps/dns/lwip-dns.c
@@ -0,0 +1,46 @@
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
+
+	if (varname)
+		env_set(varname, ip4addr_ntoa(ipaddr));
+
+	log_info("resolved %s to %s\n",  name, ip4addr_ntoa(ipaddr));
+	ulwip_exit(0);
+}
+
+int ulwip_dns(char *name, char *varname)
+{
+	int err;
+	ip_addr_t ipaddr; /* not used */
+	ip_addr_t dns1;
+	ip_addr_t dns2;
+
+	ipaddr_aton(env_get("dnsip"), &dns1);
+	ipaddr_aton(env_get("dnsip2"), &dns2);
+
+	dns_init();
+	dns_setserver(0, &dns1);
+	dns_setserver(1, &dns2);
+
+	err = dns_gethostbyname(name, &ipaddr, dns_found_cb, varname);
+	if (err == ERR_OK)
+		dns_found_cb(name, &ipaddr, varname);
+
+	return err;
+}
-- 
2.30.2

