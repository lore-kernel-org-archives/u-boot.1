Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0687D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1EA893B0;
	Tue, 12 Nov 2024 03:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbsToLrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88CBF89393; Mon, 11 Nov 2024 22:09:14 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E5589390
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-211a4682fcaso7753145ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359351; x=1731964151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe6U34LuFSeoZ4IHnli480pAA45RaY6CL4/SpJ6SA2I=;
 b=CbsToLrPPIJKLL5wCa4xjqNLnkkqw9BsCw2YFuCdsF5gJRMdMT+smFr9tpv/WtD2IB
 VRc+CtlSrg2ESXyF7EPGc7L0CVtmX8aFyqq9c5njZp7KgdtoYrFNN/7rsR2ob/cFq/va
 nMWAZF73OQg+MuhlrSyZFD+Nimt8htVmnbkqphCqrHNZ0TcsPl9hsB7r9kj8hRqcIiOq
 19uuihoTticbXKaOJbxTCoD6hzP0+xfVhj66xhk0hmWRX5X96uQ9kJexp7SxTwwmvyZu
 mxeU7OIt5+wMJdGXHY9RVFz5jp4QJZwx5rvOBflfnHNo/HF/FQcDWQ7SkIXxXm1dKfP/
 6bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359351; x=1731964151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe6U34LuFSeoZ4IHnli480pAA45RaY6CL4/SpJ6SA2I=;
 b=MHi7Ai+s3IhIChiMTJWUiCRc5yPOMALgzpI2x/rmN7UjFRo9mmUmaIkbAuxE1gPM/f
 XwPLv9xh2USB8vmo0JvIZHPIYyXxEyb+KglCIvFPhGGk9gphqeAQyJGXjPRALwIW6ndu
 EyFGCP3t9lRDvm7tj6g9K9HYj2uZqQbU/MZe+QsijIzBbTXAHsTpalZullkIi32hL3Za
 /5VL5FEGexMJAJMbQ0WHPKH4TOANtMD3jsurLH5lWk8YcGcQXUCLF3H9mWYHFrXQF21T
 vVpIfgSNV1sU0uRwaXxV3pOlBDFIE2kCwoF+lxE1zOot4dI0ovposz2RUhwczD1/hKoI
 gxpQ==
X-Gm-Message-State: AOJu0Ywp4pBwRj4O3D95rw+ew+8zSwvG7nDuAMaD+q+JB11yjLEat2SF
 toyG0l+KprhhptpCen+ON4kYn/i8znq3QPNmqKtGnkAwiElSKLIiQd/XYyZw
X-Google-Smtp-Source: AGHT+IH9RrUpuqvyooJUn8valz22x8XgzAJrJzl1+/m3t1XjP6WnUteqz8uxbxw5zkHcvBlWLqpZJA==
X-Received: by 2002:a17:902:f60a:b0:202:26d:146c with SMTP id
 d9443c01a7336-211834e6b57mr213482425ad.5.1731359350705; 
 Mon, 11 Nov 2024 13:09:10 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:10 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 2/7] net: wget: add definition of struct wget_http_info
Date: Mon, 11 Nov 2024 18:08:56 -0300
Message-ID: <20241111210901.560691-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

The struct wget_http_info exposes the HTTP information of the last HTTP
request issued by wget, and it controls whether the efi bootdevice is set,
and whether the buffer size needs to be checked (lwip stack only). This
information is otherwise discarded. The wget_http_info struct can be used
by HTTP drivers to have more control over HTTP requests.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- Add Sphinx style documentation
- Change status_code in wget_http_info from ulong to u32

 include/net-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index fd7c5e7b48..8985b81c2d 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <hexdump.h>
 #include <linux/if_ether.h>
+#include <linux/sizes.h>
 #include <linux/types.h>
 #include <rand.h>
 #include <time.h>
@@ -506,4 +507,51 @@ int wget_with_dns(ulong dst_addr, char *uri);
 bool wget_validate_uri(char *uri);
 //int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
+/**
+ * enum wget_http_method - http method
+ */
+enum wget_http_method {
+	WGET_HTTP_METHOD_GET,
+	WGET_HTTP_METHOD_POST,
+	WGET_HTTP_METHOD_PATCH,
+	WGET_HTTP_METHOD_OPTIONS,
+	WGET_HTTP_METHOD_CONNECT,
+	WGET_HTTP_METHOD_HEAD,
+	WGET_HTTP_METHOD_PUT,
+	WGET_HTTP_METHOD_DELETE,
+	WGET_HTTP_METHOD_TRACE,
+	WGET_HTTP_METHOD_MAX
+};
+
+/**
+ * define MAX_HTTP_HEADERS_SIZE - maximum headers buffer size
+ *
+ * When receiving http headers, wget fills a buffer with up
+ * to MAX_HTTP_HEADERS_SIZE bytes of header information.
+ */
+#define MAX_HTTP_HEADERS_SIZE SZ_64K
+
+/**
+ * struct wget_http_info - wget parameters
+ * @method:		HTTP Method. Filled by client.
+ * @status_code:	HTTP status code. Filled by wget.
+ * @file_size:		download size. Filled by wget.
+ * @buffer_size:	size of client-provided buffer. Filled by client.
+ * @set_bootdev:	set boot device with download. Filled by client.
+ * @check_buffer_size:	check download does not exceed buffer size.
+ *			Filled by client.
+ * @hdr_cont_len:	content length according to headers. Filled by wget
+ * @headers:		buffer for headers. Filled by wget.
+ */
+struct wget_http_info {
+	enum wget_http_method method;
+	u32 status_code;
+	ulong file_size;
+	ulong buffer_size;
+	bool set_bootdev;
+	bool check_buffer_size;
+	u32 hdr_cont_len;
+	char *headers;
+};
+
 #endif /* __NET_COMMON_H__ */
-- 
2.43.0

