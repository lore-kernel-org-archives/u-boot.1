Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B74C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 04:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4C287792;
	Fri, 10 Nov 2023 05:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YiETNyz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BFF87783; Fri, 10 Nov 2023 05:27:17 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ECA87787
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 05:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdc185c449so1268890a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 20:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699590431; x=1700195231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGZQU+HctrKKVXmy2gttea3yHpOHmqPE2LoEebzQakY=;
 b=YiETNyz7Bc80OKS5Sg6l0WGhoDF7mPpD73TSR20FprorxQS38VyMIGRv4s5ia+5AP8
 6yB+X2gCuY+PSyDwxQ7iTja8CGx4VGX43V+AsT/9ZUtGHwpGiuvULQxmRXEhrBAR0F0+
 wXJg+1EIbzBWiU7PSCUHa45gcghRGZRy54jypCNBWUxt3N33bSvsczenQrQrAvQE4E8P
 jRWcfx2qkOcklBXIBfh8LKK9d2CTaR1mo3GRFqk4cF/HkQnvmAFJh2gCqTypm+OnJWFR
 /E1kL31LkwQk+wm+xEGCuH8cd9eHF+V7r16t+qZy4Kvtghkn+lKyNn8ePGEHR6T5NB4u
 os3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699590431; x=1700195231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGZQU+HctrKKVXmy2gttea3yHpOHmqPE2LoEebzQakY=;
 b=niSkusljml7RGyncjYvccpv3C0uQpUZnYaJ3AMVfp53ZJSuKOXUGU82kN6jgjs3Enn
 12NqutRV6iSTi5yEP01fcCqCvE0ZcA2wVRhHq8NK9HGPE6NB6I1D+mOW8J6ZRat/Swuk
 FV23Z6JZ7E01KEzwy5bnbFplopux+cUzn6IuZ8IkQPTWdVqv4WTAasJPsbMpm1iam7ya
 1yfM0MJ7L+PA/tWI0NmP+SJn4lmmrHW7qZK6a2LdLWvXFf9pWSxOPFVyhgxt1KvJ/9Zy
 m/yVYjdJr06DUttAFgJyTO2WyZ5B6DmOwNGZ2wsqmNbJxsar5DB+bgVJUBvjZzqPYUYS
 tX3Q==
X-Gm-Message-State: AOJu0YxcEIz6cunRlfyxKJGiXjNjOn/bDOtvt+XCBc3HSTI4NpDJNHXr
 vG7v5axcyJBbyJG0KWZ9HHxR22KPnwOhewW8W+w=
X-Google-Smtp-Source: AGHT+IEPDKLJbmnNGTo1QvUn6bgIdCU4gdttKgfvbBgyF4vZnH/Whi7jgKGi/71l8SNTiLwpAMzkUQ==
X-Received: by 2002:a17:902:8488:b0:1cc:8b4c:9ba1 with SMTP id
 c8-20020a170902848800b001cc8b4c9ba1mr6218726plo.50.1699590431228; 
 Thu, 09 Nov 2023 20:27:11 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ix22-20020a170902f81600b001cc32261bdfsm4332568plb.38.2023.11.09.20.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 20:27:10 -0800 (PST)
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
Subject: [PATCH v12 2/9] net: wget: add wget with dns utility function
Date: Fri, 10 Nov 2023 13:25:35 +0900
Message-Id: <20231110042542.3797301-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

