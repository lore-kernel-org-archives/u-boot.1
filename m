Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81340CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 04:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B118586C3F;
	Mon, 16 Oct 2023 06:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g/HmHsnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B6185423; Mon, 16 Oct 2023 06:24:45 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1009086940
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso968187b3a.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697430261; x=1698035061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=g/HmHsnZuaeQd/8VbXQdJFJuRpg37dw66ubWleKVPdK8ms6DxiWIOqalVyVwbmTcmZ
 iszy9aUpC8mdL0pJTQgZz25iyJm9VS0DOGNO4l/wZ/PbAB58ZJjGGkctjqzjC23SHYV6
 Y/i8TEzxoLvyfF8HKK3Z5oGVnCgpnRgvIfIvMX5RBCM+0SBe5+TZxaFP4558Yna4J6mJ
 XNftIjj5oruSUD86BPUoOUvYtqEpplse4fsOUv0/amgJw6Xj/OGOK4ZNxxp+7ruI1gdc
 MRLQH+WHfPeNxg3DIc7SaqSdsatOjGz3/qyISrN95xXLDUxa5TSskEcDNC5TUqq80p0v
 ILrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697430261; x=1698035061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=NcyXyRUk87HvpjXwSuz8NtZGbUFzOrTo4jr3u3wc3pu2pYpP4OBXYHPZWR/bENwPsd
 xfPvJuNbEaReY0ssP3n6i8c6go81sKW2l1NNJ4baUvj7CwJNDgeorsP2XL5/rLMMYKrU
 zATke/ZAUxUSagFvxyCheY2IWtG6yPLUwateZ0gihpjE7BViyia8SzkQyixmPuQS4R+V
 FV1SJmBRo5Ozsu4pKvQPMeVByEMdtuYt5Q3civn5it61wDHQGwjleGdo0xd/irWtxMaW
 VQsnVfx8X/aXN3f7+OPSvOR3dQfRj+DH88o+M3kvz0+0vg+Jb4NCED2JHkVf0kAnaX+c
 Fktw==
X-Gm-Message-State: AOJu0Yzs12k08ScTmfew2Nh7LGLMYc7HSjdjwLA2FvquBnEXiJH1OLV4
 ldQWKZeqZANM1mu47HAAWTneuz6O9mjKam2CMtk=
X-Google-Smtp-Source: AGHT+IFyP7KcZNghHcu3oFnMNmLegYd3G7N+NFc49MyOhXF/xCUbL/ObeUmK+GnAsjwf0OMCLGgR0g==
X-Received: by 2002:a05:6a00:21c5:b0:692:af9c:d96a with SMTP id
 t5-20020a056a0021c500b00692af9cd96amr31095618pfj.5.1697430261579; 
 Sun, 15 Oct 2023 21:24:21 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 f6-20020a637546000000b0057c29fec795sm6993559pgn.37.2023.10.15.21.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 21:24:21 -0700 (PDT)
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
Subject: [RESEND PATCH v6 2/9] net: wget: add wget with dns utility function
Date: Mon, 16 Oct 2023 13:23:01 +0900
Message-Id: <20231016042309.2386387-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
References: <20231016042309.2386387-1-masahisa.kojima@linaro.org>
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

