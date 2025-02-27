Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB39C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B407C81120;
	Thu, 27 Feb 2025 17:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e/4GFmWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2454E81111; Thu, 27 Feb 2025 17:09:35 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB3D81112
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43989226283so8117815e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672571; x=1741277371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Re+AIhSqVR2ln817oLU/Fn0F9chtKdySN7kwMbfuTZA=;
 b=e/4GFmWWxteNLpDNJhzvsrgGLRmqs0dcCO42OTihIwz4DlVf+RfyeCGiqagbpU7uAe
 rkdPsnjveTbqHMlfJwjNejrPjttWpS+nser02hzlZn204j1uLVYGydM+4Dx+Xo3Dd7GJ
 GWrlCBor6IJbs7irD5CNE8ccmUxSKJFRNu6Oo8RtRs/SJYbtjzIpxsg110duMFeY0l/3
 lBuMi0MgNaa7iqbtNl7nWu2jDWPmO0Kgdqk1WLjpFRk7VnnOeIpVm7gQi6wFHFOnO8CN
 O9KW4wJCV3raTDJjDoSMjwVC0cJ0/Ix2xayQTiQjwPDRxP8p/0u6x3VwrofGtE3Nidmk
 Z0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672571; x=1741277371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Re+AIhSqVR2ln817oLU/Fn0F9chtKdySN7kwMbfuTZA=;
 b=tlqEDOA1KRBJ7ugWEmH6/vM8zGy0YyFCnzchwXcYNZ77Z8LJrUKvJdJOltHhJbV04o
 906Z2OXp5wnY/3UjABo4OeT9GCHDNg6YIuN0jCvPj/Umgg4310+GbFk11Cs3kd6nYpCI
 ov4Up/lQAI4mIIcZaQvSAdwBSZTDIRSSTmOcQ5q1gEfsBuVqNVpcY01rafbDjeN1HPqO
 rQKlPykxe5UD/1WnRhj08+VB+fIeajwQ199v9declBYU6K5wxkrVdCzjIMIbwhOoa1cW
 NDxrhDa6TF9UDEkTI5dVdxdUo/uPNS57dgZVrt8ysoplqcppkxBja0oAzCxCxoamaL3t
 2QAA==
X-Gm-Message-State: AOJu0Yxq/f7LO0dET7tN27i/1QNaHIe4hqAGcqhXWdNFDGPQF37uuXzc
 yCCpcaOotim4gePN76ZbXevRmgDhaU+K7AIMIyqO0bYs1N7gYSWoih7PbMBCx8IJuB47c258luH
 oEoA=
X-Gm-Gg: ASbGnctY3DrajLaUBVxsdp7/aoTW+pYhIplcarYkPTwV2ipBaU03Fo47JxqfomKKxna
 6xhmrbYnJOTnzmIbHcDW6VHeJQuB9uzgaC5Fe5KjQOASIS9ATVjERMeOjthZ0tz4QQqEsLfTq9K
 ZnVDB5QmrMjawStzLQz3V6TffeEx3/v2bIAZlW96CtZ2hgeQESMUqDnWiVSF1wWtdSk4KAMTQrZ
 au/wvXJrA4N1qewWnUZJmcZSs/ORFVIyOXmdrgW+ZFdPNqla005vuWC4T8rvHNoCCbDpexB1oyw
 kXYy2zrVC9B5WV3v/3IaV2XFvoQb7s/T0qI=
X-Google-Smtp-Source: AGHT+IFNika7MW0aSbaG3WHfYHgiMcTa0lJt5vTZhvnkFJ2LU60K/6PuSBbuYws2079sX6oU+xQ/iQ==
X-Received: by 2002:a05:600c:5253:b0:439:a093:fffe with SMTP id
 5b1f17b1804b1-439ae1e9601mr233538455e9.7.1740672570578; 
 Thu, 27 Feb 2025 08:09:30 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b925sm59506795e9.7.2025.02.27.08.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:09:30 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/5] net: lwip: extend wget to support CA (root) certificates
Date: Thu, 27 Feb 2025 17:09:01 +0100
Message-ID: <3a93751157801fe709d995eae1883f9e3219733c.1740672437.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740672437.git.jerome.forissier@linaro.org>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
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

Add the "cacert" (Certification Authority certificates) subcommand to
wget to pass root certificates to the code handling the HTTPS protocol.
The subcommand is enabled by the WGET_CACERT Kconfig symbol.

Usage example:

 => dhcp
 # Download some root certificates (note: not authenticated!)
 => wget https://curl.se/ca/cacert.pem
 # Enable certificate verification
 => wget cacert $loadaddr $filesize
 # Disable certificate verification
 => wget cacert 0 0

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig                      | 15 +++++++++
 cmd/net-lwip.c                   | 15 +++++++--
 lib/mbedtls/Makefile             |  3 ++
 lib/mbedtls/mbedtls_def_config.h |  5 +++
 net/lwip/wget.c                  | 55 +++++++++++++++++++++++++++++++-
 5 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8dd42571abc..a188a2ef24b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2177,6 +2177,21 @@ config WGET_HTTPS
 	help
 	  Enable TLS over http for wget.
 
+config WGET_CACERT
+	bool "wget cacert"
+	depends on CMD_WGET
+	depends on WGET_HTTPS
+	help
+	  Adds the "cacert" sub-command to wget to provide root certificates
+	  to the HTTPS engine.
+
+config MBEDTLS_LIB_X509_PEM
+	depends on WGET_CACERT
+	bool "Support for PEM-encoded X509 certificates"
+	help
+	  This option enables MbedTLS to parse PEM-encoded X509 certificates.
+	  When disabled, only DER format is accepted.
+
 endif  # if CMD_NET
 
 config CMD_PXE
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 0fd446ecb20..0672f48a7a8 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -27,9 +27,18 @@ U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
 #endif
 
 #if defined(CONFIG_CMD_WGET)
-U_BOOT_CMD(wget, 3, 1, do_wget,
-	   "boot image via network using HTTP/HTTPS protocol",
+U_BOOT_CMD(wget, 4, 1, do_wget,
+	   "boot image via network using HTTP/HTTPS protocol"
+#if defined(CONFIG_WGET_CACERT)
+	   "\nwget cacert - configure wget root certificates"
+#endif
+	   ,
 	   "[loadAddress] url\n"
-	   "wget [loadAddress] [host:]path"
+	   "wget [loadAddress] [host:]path\n"
+	   "    - load file"
+#if defined(CONFIG_WGET_CACERT)
+	   "\nwget cacert <address> <length>\n"
+	   "    - provide CA certificates (0 0 to disable verification)"
+#endif
 );
 #endif
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index e66c2018d97..8a0a984e149 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -57,6 +57,9 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
 mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
+mbedtls_lib_x509-$(CONFIG_MBEDTLS_LIB_X509_PEM) += \
+	$(MBEDTLS_LIB_DIR)/base64.o \
+	$(MBEDTLS_LIB_DIR)/pem.o
 
 #mbedTLS TLS support
 obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index fd440c392f9..7b6a7f482f0 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -138,6 +138,11 @@
 #define MBEDTLS_ECP_DP_BP384R1_ENABLED
 #define MBEDTLS_ECP_DP_BP512R1_ENABLED
 
+/* CA certificates parsing */
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509_PEM)
+#define MBEDTLS_PEM_PARSE_C
+#define MBEDTLS_BASE64_C
+#endif
 #endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
 
 #endif /* #if defined CONFIG_MBEDTLS_LIB */
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 14f27d42998..14466598d7c 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -285,6 +285,53 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 	return ERR_OK;
 }
 
+#if defined CONFIG_WGET_HTTPS
+static char *cacert;
+size_t cacert_size;
+#endif
+
+#if defined CONFIG_WGET_CACERT
+static int set_cacert(char * const saddr, char * const ssz)
+{
+	mbedtls_x509_crt crt;
+	ulong addr, sz;
+	int ret;
+
+	if (cacert)
+		free(cacert);
+
+	addr = hextoul(saddr, NULL);
+	sz = hextoul(ssz, NULL);
+	sz++; /* For the trailing '\0' in case of a text (PEM) file */
+
+	if (!addr) {
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_SUCCESS;
+	}
+
+	cacert = malloc(sz);
+	if (!cacert)
+		return CMD_RET_FAILURE;
+	cacert_size = sz;
+
+	memcpy(cacert, (void *)addr, sz - 1);
+	cacert[sz] = '\0';
+
+	mbedtls_x509_crt_init(&crt);
+	ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
+	if (ret) {
+		printf("Could not parse certificates (%d)\n", ret);
+		free(cacert);
+		cacert = NULL;
+		cacert_size = 0;
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
 #if defined CONFIG_WGET_HTTPS
@@ -316,7 +363,8 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	if (is_https) {
 		tls_allocator.alloc = &altcp_tls_alloc;
 		tls_allocator.arg =
-			altcp_tls_create_config_client(NULL, 0, ctx.server_name);
+			altcp_tls_create_config_client(cacert, cacert_size,
+						       ctx.server_name);
 
 		if (!tls_allocator.arg) {
 			log_err("error: Cannot create a TLS connection\n");
@@ -369,6 +417,11 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 	ulong dst_addr;
 	char nurl[1024];
 
+#if defined CONFIG_WGET_CACERT
+	if (argc == 4 && !strncmp(argv[1], "cacert", strlen("cacert")))
+		return set_cacert(argv[2], argv[3]);
+#endif
+
 	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-- 
2.43.0

