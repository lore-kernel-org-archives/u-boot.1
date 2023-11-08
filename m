Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A788FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9372187703;
	Wed,  8 Nov 2023 12:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XdrcCPJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8968754B; Wed,  8 Nov 2023 12:08:04 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB18875DB
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b52360cdf0so3223063b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441669; x=1700046469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=XdrcCPJeUA9V2Ggn6UqA591AXAwvtYnO5IzNZ96EYTJPUBu8xy+mo0lPp+N7MN5psf
 aE2tRBgPyRTnn7Re2SlDeXSazAOPTskcqFLvKjUC8fAWu8ynmLSs8Q4SEDzSzJAmJ+jR
 mC7X1+cgnyR2oAccQ+n+UCU90KtO8hEwGpqsjUrjKGZoWJnpRGRrbwXI8vJ38R475t5k
 TBdlV3zyEi51VQBl+t8b4u/iVfjWPhvWyoHkVMrxuXMda5ZWo3XjDhm10FUei9PJWfOV
 XRo6JLRvCjuw/lJIPqkA/kVPvYtJ5/6JEky8XvwAUgLYQOuexPAcMzUgHFhRqE4hjNnn
 95cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441669; x=1700046469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=RPSVaYrsao5mMkTDshE+b8ddi9NWd1Ts6TUsGYs/N4QzAD9IO08CTRH3iAMkZ3Q9mx
 TcsLbdmtLjcALj5UXHf8KDiym8cEQYFGZjgPXJw/edLIQTOotE/ls7u+frW/alHPR7fC
 0usvM/mSSJeLLhI7q11olOAZ65ZJC0lm8Zh318c4OLTBy3+TyoHsVLe0V8vw3gGnAKkH
 4vXdnH7M2Km0gah0D8lhRRIlQK1B04V46HbBbv/CoxBRk1sRTRlvJ4lNp49tSwXQSyRW
 V7K+FplBW1qe0wWtH2hUTEIJvQBCniGJvWMK0mkYGeuIHWK2hHU+R54Xgv20YF9Z4xFE
 HYUw==
X-Gm-Message-State: AOJu0YwvNfeMrI6pxwWpUf3DliOH9t6Z3LjvwoP41FhKLOOhqGZqMeL4
 2uTpgaK6mJJL429ptkbKg0ULqSQXfi4nqzvC5Is=
X-Google-Smtp-Source: AGHT+IFaH5fIjSoO6C5Arnf6qPhI5Mr86HfEG0RI8usCgULeGCUrD/+FB/xb7nQHR1P8/MBzQyPrLw==
X-Received: by 2002:a05:6808:1154:b0:3ac:b73a:757f with SMTP id
 u20-20020a056808115400b003acb73a757fmr1974618oiu.39.1699441668851; 
 Wed, 08 Nov 2023 03:07:48 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 m29-20020a634c5d000000b005bd2b3a03eesm2916497pgl.6.2023.11.08.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:07:47 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v11 2/9] net: wget: add wget with dns utility function
Date: Wed,  8 Nov 2023 20:06:29 +0900
Message-Id: <20231108110637.3691441-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

Current wget takes the target uri in this format:
 "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
The http server ip address must be resolved before
calling wget.

This commit adds the utility function runs wget with dhs.
User can call wget with the uri like "http://foo/bar".

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
---
 include/net.h |  9 +++++++++
 net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/net.h b/include/net.h
index e254df7d7f..57889d8b7a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -926,4 +926,13 @@ void eth_set_enable_bootdevs(bool enable);
 static inline void eth_set_enable_bootdevs(bool enable) {}
 #endif
 
+/**
+ * wget_with_dns() - runs dns host IP address resulution before wget
+ *
+ * @dst_addr:	destination address to download the file
+ * @uri:	uri string of target file of wget
+ * Return:	downloaded file size, negative if failed
+ */
+int wget_with_dns(ulong dst_addr, char *uri);
+
 #endif /* __NET_H__ */
diff --git a/net/wget.c b/net/wget.c
index 6f97eb1d12..2087146b37 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <stdlib.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -512,3 +513,56 @@ void wget_start(void)
 
 	wget_send(TCP_SYN, 0, 0, 0);
 }
+
+#if (IS_ENABLED(CONFIG_CMD_DNS))
+int wget_with_dns(ulong dst_addr, char *uri)
+{
+	int ret;
+	char *s, *host_name, *file_name, *str_copy;
+
+	/*
+	 * Download file using wget.
+	 *
+	 * U-Boot wget takes the target uri in this format.
+	 *  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/sample/test.iso
+	 * Need to resolve the http server ip address before starting wget.
+	 */
+	str_copy = strdup(uri);
+	if (!str_copy)
+		return -ENOMEM;
+
+	s = str_copy + strlen("http://");
+	host_name = strsep(&s, "/");
+	if (!s) {
+		log_err("Error: invalied uri, no file path\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	file_name = s;
+
+	/* TODO: If the given uri has ip address for the http server, skip dns */
+	net_dns_resolve = host_name;
+	net_dns_env_var = "httpserverip";
+	if (net_loop(DNS) < 0) {
+		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
+		ret = -EINVAL;
+		goto out;
+	}
+	s = env_get("httpserverip");
+	if (!s) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
+	strlcat(net_boot_file_name, ":/", sizeof(net_boot_file_name)); /* append '/' which is removed by strsep() */
+	strlcat(net_boot_file_name, file_name, sizeof(net_boot_file_name));
+	image_load_addr = dst_addr;
+	ret = net_loop(WGET);
+
+out:
+	free(str_copy);
+
+	return ret;
+}
+#endif
-- 
2.34.1

