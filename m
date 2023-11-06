Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCDDC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F4086FF7;
	Mon,  6 Nov 2023 12:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZM4fmkxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6AE38653E; Mon,  6 Nov 2023 12:40:35 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C1786BA9
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso27453935ad.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270831; x=1699875631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=ZM4fmkxat6q5m3uZNmDecL6N31sTNVUG+Hoax2bC9Plhx6o2+f3hb0/GcxsFAqAixG
 1V+SxNpPhYrSgDf72Hl2/Dum75NivHAODdJQSsDFhJSvuKqNGTzFdnD13rEPz5XTluj+
 Jq+olNoF7xGHUaV97nI4LkIFptHZUlwKholXv61yKNiP5IWc0wU2cy1+e6EbgN6R13Jv
 +HRgX/ryjQbB7DL744VjEYoAgC4UwvMYhuNoEV5LzkTzZUHmBta+mXMn5SnO6+hvi+41
 TC1R1NNhQ6GRQqyfR4CJxwBUXBEoxv+jXf0lKSWJuX5MzXcZCDTkLaK1R4kKg5bC70Yr
 Mx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270831; x=1699875631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=sdS4nTSG+F1im16v3vS8hTctYhOeOfYqX/3WIY2m5jPll25+XvggV/6CipqTXeXUO7
 o4D/cLnvJBGsIBMN1BUbSXVSFJJP/BsYtXRKzW94nYOqxC8HsDlD+ipLR934k0O4esGM
 xGeNkGOxZRZlbfowqxVrHAwaXTqjpTeo4iRrCXi4KxkgEFXD7ygNAZEMboP6+VbgiWAW
 Jgvcu9bHpW4TnpAQBpdNnybkvHKWLZb3j1ar+AF5XIX5sU9Ul43evXBPzyjDgbX6Y+WZ
 jhnPVLvF7fbIe6q7jUiDncGwZXX7mVkpJgejXHdfAVhhjApod/2JmTKEIUy5gDs0BMQ7
 KmMw==
X-Gm-Message-State: AOJu0YxmA3wTwKd6M2v80IjCWa+DWCGJM4nL3BDqJbX55Lj4U7tl3aTD
 uagzA2R6kYSLSi3zewohh+uzLohWnoFs18muCDk=
X-Google-Smtp-Source: AGHT+IFBthv2fPT7dYaPXzFbMk1kcsXr8ua3zRH+fGPxvQHwE7wqSebAc0hmQsdQCiyVy4trqezq6A==
X-Received: by 2002:a17:902:db0f:b0:1cc:5ef7:e3dd with SMTP id
 m15-20020a170902db0f00b001cc5ef7e3ddmr18197030plx.47.1699270831326; 
 Mon, 06 Nov 2023 03:40:31 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 e19-20020a170902f1d300b001b9da42cd7dsm5745534plc.279.2023.11.06.03.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:30 -0800 (PST)
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
Subject: [RESEND PATCH v10 2/9] net: wget: add wget with dns utility function
Date: Mon,  6 Nov 2023 20:39:13 +0900
Message-Id: <20231106113920.3631591-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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

