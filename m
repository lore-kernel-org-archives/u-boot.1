Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F7AC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAEF88651;
	Tue,  2 Jul 2024 20:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T/FW/9sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5877787D74; Tue,  2 Jul 2024 20:33:03 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13E6F887E7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d8470bd455so880211b6e.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945179; x=1720549979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9tG+fKNPYNl49KLLuPmJ+TDNzUs80bQ9CvdGzAeQWA=;
 b=T/FW/9sy+2yfoQQmTvjhFvLonag9MFQbXhJeTwDHuQCf4VOFPUymCHhR4Oh7sITh2P
 VGPYP225aeBCekpWSBNOGCsZhyX2KoIEEgEkHW1uwDgq5mzith1yHfjgqMicPaMFgJLS
 8QL5UCRzkVMA/RQ6njzAJh6XJMh/NoYLmxFzNXkHZ281qbcltQBBN+/7fq52OulJx+zB
 x8k3gTTMNAj9aJBi86qjeHDLoDUifU2T+Fi5SKPn4+pgrSM2R4zt5NOvo1DX7OP0ZzMb
 Qx/78RGXY8sOrsVmr024JbWNONGth3jLaPPtW7psNjz9vkQurl/CUSLyH8FE8LFUIj4p
 cLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945179; x=1720549979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9tG+fKNPYNl49KLLuPmJ+TDNzUs80bQ9CvdGzAeQWA=;
 b=UYKn1R03SkFQGvuOm62vi3r6q1VKfYNQmGy4GDRYByXa64f5WH2iuh5obT+Jzy1baE
 zyx+AfDjUSVrmc0kgLqSXQo7qUv0gJjIENJIyV9VOgoCLZPFhpuv+fG4STe5KJOfRgrh
 xX2Zljzwi0CUvO2tFecSpEX4OAIP+jT0ClsxWUS/9rQHessIj7GKgGX+ugNyFO5BgfIb
 UlX7TOktRG3kXtrNkLDGG53cxdgLsCw/z98bqsNX9FsgrAK+4yY1MwsSZBBTHe5kCRbR
 4rpMj2syJXXXw/P+74U4FJi/kHtKZ/3Ll+CRMHnlGDZ63Uhm0MQggOLGcb7mtME568zY
 cteA==
X-Gm-Message-State: AOJu0YwOp58IdrxcDOzm+AyXYWwoQD1eMFXlHFh5K5OMioZTZfuJOoiF
 EZcBkP5OOw/o8/1w4pZpIcPOWC26NXTCXjdEqvLTIs+o5temgcFdS7iA0qALH6di1hrWnG+BzKc
 3
X-Google-Smtp-Source: AGHT+IEG3cWdiPL/9um9QkET2OOUopsTxF4d83HACVlViRKHU5aMh0+aDTj3VAcFTWP18ERCco1P6A==
X-Received: by 2002:a05:6808:f8d:b0:3d6:32b4:b8fa with SMTP id
 5614622812f47-3d6b30f45cemr12001738b6e.13.1719945179608; 
 Tue, 02 Jul 2024 11:32:59 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:32:59 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 23/29] mbedtls: add MSCode parser porting layer
Date: Tue,  2 Jul 2024 11:22:59 -0700
Message-Id: <20240702182325.2904421-24-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

Add porting layer for MSCode on top of MbedTLS ASN1 library.
Introduce _LEGACY and _MBEDTLS kconfigs for MSCode legacy and
MbedTLS implementations respectively.

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

 lib/mbedtls/Kconfig         |  17 +++++
 lib/mbedtls/Makefile        |   1 +
 lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 lib/mbedtls/mscode_parser.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 8c5b617bb48..d8a8f87e031 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -126,6 +126,7 @@ config LEGACY_CRYPTO_CERT
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	help
@@ -156,6 +157,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
 	  This option chooses legacy certificate library for PKCS7 message
 	  parser.
 
+config MSCODE_PARSER_LEGACY
+	bool "MS authenticode parser with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && MSCODE_PARSER
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for MS authenticode
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
@@ -280,6 +289,7 @@ config MBEDTLS_LIB_X509
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	help
@@ -309,6 +319,13 @@ config PKCS7_MESSAGE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for PKCS7 message
 	  parser.
 
+config MSCODE_PARSER_MBEDTLS
+	bool "MS authenticode parser with MbedTLS certificate library"
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for MS authenticode
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 7b40ff0c467..ac7c487449d 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -27,6 +27,7 @@ x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
 x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
+x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
 
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

