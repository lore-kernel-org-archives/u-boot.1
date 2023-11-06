Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B029EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E371F86C33;
	Mon,  6 Nov 2023 12:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ed/YwHgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49EE586FBD; Mon,  6 Nov 2023 12:16:47 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 154ED86F68
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b3e7f56ca4so2383707b6e.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269402; x=1699874202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=Ed/YwHgdQOj18GvQzcDhIJ/B3Eh7/Uos7vfe4bJ1esnwI0buMclQthdWyNs5qQPnGA
 aHexe4uJYHfJKLY4mX0jc9atFJGeuQGEVjbGYEhGeHbr+UqHyQXniX3n9pOhy2DMPFx8
 ONWbdMEiVHxgvNXaKAyd+mHSUGL8x4LUMBcBL5HHxQdcvlnUh+ngWDX9NYGgXHFYEUIV
 VCqLAszhkORO0a148JBeTwcRJN70pFZcKUki65Pj5rbRM8+e3z6ZtD9eCkTDgbIwlyBX
 v8SUcM5yEgfvh+SEKs5V9ITiBPKNUb7qD1UTmupkXqH0QIYDzgkG4bgXUpZekBawXv/U
 THdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269402; x=1699874202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpkU9wk3gj829EVx8p2lHMNKkbubof1kR3KeYVvX1vo=;
 b=Pr1lZtbkdTjtiAljvquD4Uhk/T/T4Zq21PYa+8CLXWbkYb0mxWcaMcB3L7jq93yMOF
 DSgAv4PRaOB+4+bGKo1Ri2gi0JxxlIY+bXl5WfbHe348FddLrHTRmLoYkIFLSia8mJ81
 q51HMw81ZTvk19dY6w4EMd5cjchxaoq22L49SuOl8IEqLgPBSIzSBqJrSwd+MkzH6h7J
 obLa3WgrREnOVKmIOjEVGcbGUDkSJ2m9ddvt6O+KzWHEzFXIFt6GyxKiAnciW7XDR/6t
 MtW2miT9mMHdsw7ZKtpSyN9+mjPBDXfDVy8mVPBcsjqa5Ueb4Z3IfEGa9Of1gLKYMyhz
 +xdA==
X-Gm-Message-State: AOJu0YzILWn4g/sEbPojUppR5RGqJBuMvEH/bx41x4hl9tpJLgCbSLTu
 sY4IWwR69nDq6ZNMgq1WMbzZvas3EOzpcWtYgyk=
X-Google-Smtp-Source: AGHT+IEIv2/a9IarLJJ+3cR8msojih8lX+9SS3C0Kiw264LsYwnRWS6JR5eWuzQcMIihLjPGTXKsIg==
X-Received: by 2002:a05:6808:8f6:b0:3ae:511e:179e with SMTP id
 d22-20020a05680808f600b003ae511e179emr28702985oic.54.1699269402466; 
 Mon, 06 Nov 2023 03:16:42 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 u4-20020aa78484000000b006bd8f4e398csm5437676pfn.135.2023.11.06.03.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:16:41 -0800 (PST)
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
Subject: [PATCH v10 2/9] net: wget: add wget with dns utility function
Date: Mon,  6 Nov 2023 20:14:57 +0900
Message-Id: <20231106111504.3631058-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106111504.3631058-1-masahisa.kojima@linaro.org>
References: <20231106111504.3631058-1-masahisa.kojima@linaro.org>
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

