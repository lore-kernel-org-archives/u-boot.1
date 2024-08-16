Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EFC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C251B88CB1;
	Sat, 17 Aug 2024 00:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewRg25T1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD1388C21; Fri, 16 Aug 2024 23:53:24 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0727788C5D
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf6dedbfe1so13576616d6.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845200; x=1724450000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmMvO7v5mQhKXXvGJK4pZ4FqBurAKYvTH/U0blBeOh8=;
 b=ewRg25T1AigzoEppnOXMBsjSrmbFGPIhwVe9ACkedtBKsN4HYr6CXuPhnUQTth5VE/
 U6eLfcTLb2vwEhHJvwifa9lBl3IcZrXYKdbz8/7pyiaIyaLtJhUohwqvJzutfquDMgEZ
 TekK2eYMSsX6F+DGyRo0i2nOebHxsEhOPi2RkhfUKFGBT0WxaNFIhgsUQ7HMXEdwwy2Z
 6FbSNYo0sgEWM3DDSObHrv1KC8/6I4Q3NieTb9W5Ray6cx7ydOyBiDzOuy1XtmJlnLLH
 tl8SQ1QwxOfUZzNrF1Ms2QyNTQhE3co2H6b5b8MzrQvZC1IoCQ/5Pn3BEBNNY7ZUCynE
 HtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845200; x=1724450000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmMvO7v5mQhKXXvGJK4pZ4FqBurAKYvTH/U0blBeOh8=;
 b=Kha3SJu0GZiONNJNrVtYfER3U7FvS1g8rmww7Rg5UOM7uoBIrDVWf/P9vB2/114Zra
 tguwhnqaG4ZwEdNE8movuo0qunSdjhJh+tCh8a7zB2I4CaA6xvVY+fGAe44LlS5125JY
 n2ZhZYiStC19eAp6+jA3uCLDK0tLkuZziLGqBmBtzLcOCeSdfpjqZMOdsVPwnSN1pY1k
 r19BorbEQuSxk0D6VpaqoylrHLbmLUhLDrdDCL99DRUoOcpk+CAt3DEg3a8HyRjB7nbR
 QsuVeZDkkm0GxhRAdWUMvURIB7l+akPIvq0RVMowbfqjXvHIhKfwBVD8B9tVBLe9gVv+
 M4Tg==
X-Gm-Message-State: AOJu0YyjjMFTUFn3yusDvjtqj7MbDs/igxUZuIjcFw95XmZW2tj5BSy5
 NDIPvIzoM7GsyyZ3orOC0XgJgBUcXXdqHeIE94V/H6mP2vaUw1LTRyJbolDeRn5rVAZ21aLFVXx
 Hc3g=
X-Google-Smtp-Source: AGHT+IECrOXJZ2VnKGRXdSBP/7VuX8Uc2OuXtDVRzmUBGhO44z0vTchJ3vqJK3kMgYUEvENCk8OlrQ==
X-Received: by 2002:a05:6214:5882:b0:6ae:ba6:2136 with SMTP id
 6a1803df08f44-6bf7ce5f002mr39947146d6.36.1723845200337; 
 Fri, 16 Aug 2024 14:53:20 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:53:19 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 22/28] mbedtls: add MSCode parser porting layer
Date: Fri, 16 Aug 2024 14:44:11 -0700
Message-Id: <20240816214436.1877263-23-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

Add porting layer for MSCode on top of MbedTLS ASN1 library.
Introduce _MBEDTLS kconfigs for MSCode MbedTLS implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
  MbedTLS implementations respectively.
- Fix a few code style.
Changes in v5
- Correct kconfig dependence.
- Refactored MbedTLS makefile.
- Move mscode legacy kconfig to the next patch.
Changes in v6
- None.

 lib/mbedtls/Kconfig         |   9 +++
 lib/mbedtls/Makefile        |   1 +
 lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 lib/mbedtls/mscode_parser.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index e759cc20832..f03fb752d3f 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -294,6 +294,7 @@ config MBEDTLS_LIB_X509
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -324,6 +325,14 @@ config PKCS7_MESSAGE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for PKCS7 message
 	  parser.
 
+config MSCODE_PARSER_MBEDTLS
+	bool "MS authenticode parser with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && MSCODE_PARSER
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for MS authenticode
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 36eba07bf43..83333b1b6a5 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
+obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
new file mode 100644
index 00000000000..c3805c6503c
--- /dev/null
+++ b/lib/mbedtls/mscode_parser.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MSCode parser using MbedTLS ASN1 library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <crypto/pkcs7.h>
+#include <crypto/mscode.h>
+
+/*
+ * Parse a Microsoft Individual Code Signing blob
+ *
+ * U.P.SEQUENCE {
+ *    U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.15 (SPC_PE_IMAGE_DATA_OBJID)
+ *    U.P.SEQUENCE {
+ *       U.P.BITSTRING NaN : 0 unused bit(s);
+ *       [C.P.0] {
+ *          [C.P.2] {
+ *             [C.P.0] <arbitrary string>
+ *          }
+ *       }
+ *    }
+ * }
+ * U.P.SEQUENCE {
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <digest algorithm OID>
+ *       U.P.NULL
+ *    }
+ *    U.P.OCTETSTRING <PE image digest>
+ * }
+ *
+ * @ctx: PE file context.
+ * @content_data: content data pointer.
+ * @data_len: content data length.
+ * @asn1hdrlen: ASN1 header length.
+ */
+int mscode_parse(void *ctx, const void *content_data, size_t data_len,
+		 size_t asn1hdrlen)
+{
+	struct pefile_context *_ctx = ctx;
+	unsigned char *p = (unsigned char *)content_data;
+	unsigned char *end = (unsigned char *)content_data + data_len;
+	size_t len = 0;
+	int ret;
+	unsigned char *inner_p;
+	size_t seq_len = 0;
+
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len,
+				   MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	/* Sanity check on the PE Image Data OID (1.3.6.1.4.1.311.2.1.15) */
+	if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_PEIMAGEDATA, inner_p,
+				len))
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	ret = mbedtls_asn1_get_tag(&p, p + seq_len, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+
+	/*
+	 * Check if the inner sequence contains a supported hash
+	 * algorithm OID
+	 */
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len,
+				   MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_MD5, inner_p, len))
+		_ctx->digest_algo = "md5";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA1, inner_p,
+				      len))
+		_ctx->digest_algo = "sha1";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA224, inner_p,
+				      len))
+		_ctx->digest_algo = "sha224";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA256, inner_p,
+				      len))
+		_ctx->digest_algo = "sha256";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA384, inner_p,
+				      len))
+		_ctx->digest_algo = "sha384";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA512, inner_p,
+				      len))
+		_ctx->digest_algo = "sha512";
+
+	if (!_ctx->digest_algo)
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_OCTET_STRING);
+	if (ret)
+		return ret;
+
+	_ctx->digest = p;
+	_ctx->digest_len = len;
+
+	return 0;
+}
-- 
2.25.1

