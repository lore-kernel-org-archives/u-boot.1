Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168F0E7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5403386D7C;
	Tue, 26 Sep 2023 11:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hZASqPvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F4F86DA6; Tue, 26 Sep 2023 11:43:54 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6059586AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5042f391153so9749941e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721431; x=1696326231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=hZASqPvAFS1l9sQrWqa5Rq1qb1UC8J829/+Y/P6jW+IEaYkus49x+pPPGL2Mb5JoAH
 wRZfyixHj2oG9KpbclhSqCbX6CCsNtVrsZLmoim8HCwgzJ1Jp5tZRxZ5GQ9wFWQ2Ioea
 WIMWY80sKd7cFPz6XqV3awUTbW2pqsNCDctVLtGun4aAuNulsrh7IvJwi4zwNgMSQkuK
 BSWCih1jpwxyYBebsQl5u/jvJlv8gsFnxhE/CtHs5VLZkVpLXQl65Zjvp3+CkgQTKyEW
 6fzLFqit5bcJejwE5WlfRQGq0z6ISSTkx9W/znHMo1ndmMsyPPpCJtdojpACcXCp+kQ1
 6fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721431; x=1696326231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUWP4Vp2l/kcF70jt1z+yuWxjmiAQYDKKzCdYrFjBMU=;
 b=EPvod0lNhxRyZypi6JiuNFnus2igtjlMQa2OpoqRMPJU1cqOlL6PkWjIcSRt8fs0wd
 W15lTm5PSV9l+NBeGD3vKpLM5RO93uyEgV0bbyCpUCM5HERnzmH/QmAg4SSwH0Mtrdol
 exqI6DIU+m0bcZbrvLxaLkEADm4jqTq/KOUiatdNCod+tav22ar4rpt8wFXsiXci+UH0
 dwLt0h1rx439G4waReddbLcgEek2TN91K40a3gFrPRgFHOMp8cfKzEZiuJujcaEeu+CJ
 RhQslEYtJc78AizEVoZ5YtKOOQTfasouH1dlWG9OPWe8gyDDqW5eC2Q+0R2EHydoztIS
 l01Q==
X-Gm-Message-State: AOJu0YzsT6n5i9Xh6OZTKsVLGZrBB7iD4kzdeqxW6YJMEqGb3w6Gj3MS
 m59P2V2xoAviuXMbMTjbMsif6DTiRVHl3dchXfti0A==
X-Google-Smtp-Source: AGHT+IGvsCGvMBVLRAQjcpMHA01PDVG2Zo2gopk13FxRSbcCzIY49Z4hpc96mdxaoUxTZ5lMS+QBbw==
X-Received: by 2002:a05:6512:2508:b0:500:91f6:f129 with SMTP id
 be8-20020a056512250800b0050091f6f129mr970916lfb.26.1695721431556; 
 Tue, 26 Sep 2023 02:43:51 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:51 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 05/15] net/lwip: implement dns cmd
Date: Tue, 26 Sep 2023 15:41:14 +0600
Message-Id: <20230926094124.7024-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

