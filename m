Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD9CE7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17198667B;
	Fri, 22 Sep 2023 09:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VeX6Gd4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCE686290; Fri, 22 Sep 2023 09:12:04 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BFA68667B
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27499bb759cso1265185a91.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366720; x=1695971520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGdSB+1Sc+3rE1pD5ZrEOwcyiOX7+KHT5RdxLZLHyek=;
 b=VeX6Gd4sOBuZWt1hkrIcL+9apfO/B6Dq9PEp17bKw6yh444y/SeYIdzTTR1NSO8fby
 WcDBsrlQhto8U5evDcJ5adygr/9YWne3Y8soPHOjOg7NbXxilQ5V++uGjji1tzPkikJ+
 StKdtI4zhE8f3wTt+9jTX0X6ptjMzCRS463QulGc+wTK6F8HGenmax7HcvthrHU4A+wS
 J/KF5sHblE/DvM5KfIapSxfIeOGndX/vNqRZ6ieyFrhcRjGX/YGHfjPtPldNGIjNHfBo
 FRztdingdtt1FJ0DNPyq0KQYG/t2igfVTtx5L4j5B+zt6I/s7nIWcUQwD7CgzPv/PrJ5
 DNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366720; x=1695971520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGdSB+1Sc+3rE1pD5ZrEOwcyiOX7+KHT5RdxLZLHyek=;
 b=t69MqgVgJm9q4lNQsSrCEogS/Z8s9Y9t4lggUL/INsr6uQlk2R4XRHWH1vQtEoqNW4
 XPfu57uaWGAz4iWq3bKnNaOpaJtOr6m0yAox9s4zKqhGLYwPWJQGtOXhn/CJB/4vP2/T
 MPa1byOxi3jasxOY31AOg2TS9D2fo0yPNxXQCgw9j1f7dlDQQV/i8J+Iff8GpxWinXp7
 99C3mGNQkUF3Aj6gmDlUbeliRqQMTajry0/BEJksb8Y69iJ9uqa0tBc185yzhhzb8jzz
 gTAzES0Ml6sxmcn4qttj9Hpg1cG+q+SFdctK0Jg7A7q3bQG7ibfWTqLXAHwPEr7BLbFh
 SDDg==
X-Gm-Message-State: AOJu0YyFLKu9t3T0vZRuuEurs2gO9lBVffMRTTyHaKfWRngRNNb/+Uof
 1OY9nVWBnv+6iRjVz7JrObES9q/hwFAUWwP/qME=
X-Google-Smtp-Source: AGHT+IH9SbN6yHfrGj9xq813KkbdYlrt1SJr43E1tLF0sDgvQJcdHUkFPLw7XnqA4LBmb0lfWm4bCg==
X-Received: by 2002:a17:90a:b78e:b0:26d:3d86:9a8e with SMTP id
 m14-20020a17090ab78e00b0026d3d869a8emr8032816pjr.25.1695366720408; 
 Fri, 22 Sep 2023 00:12:00 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 6-20020a17090a194600b002684b837d88sm2812464pjh.14.2023.09.22.00.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:11:59 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 2/8] net: wget: add wget with dns utility function
Date: Fri, 22 Sep 2023 16:11:13 +0900
Message-Id: <20230922071119.1439482-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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
index a48a8cb624..4801e28eb9 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -15,6 +15,7 @@
 #include <net.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <stdlib.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -504,3 +505,56 @@ void wget_start(void)
 
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

