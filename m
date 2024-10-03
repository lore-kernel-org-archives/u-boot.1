Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894CCCFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2358911E;
	Fri,  4 Oct 2024 06:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WkjGxAhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB0387BF4; Fri,  4 Oct 2024 00:02:45 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71CF188CC5
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7ae3e3db294so84764585a.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992962; x=1728597762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogpAL5OWdHqEz0W+SP94H3IGBFnb9UrrFaQ9n/v5a8s=;
 b=WkjGxAhGw2Q9weJRuoXX3vDZNP19COxGaYywwoGRfgU7vb/besMEzsv3ouiix4d9/A
 GbgDSB033qjz4gTfb0hOGSjebIc/QPtPPQcUxp1FNMXfdZ1tDbIbLHzIS+6ZMG793Tf5
 EDOtTzdf0jnXOQ8hJzrhWuCvs2SVMjVwPOGLTfGl6MajQPvrdPL5r9mZetc7LyEXsCqb
 XV0ik9XUUmE/R8LbzEYdpn2B1oAYxlyZhQkifUEsTQMR/kWHj1adxj626QlHv4muVO6v
 UgEU0Exl2QyrxIuUmNbThtRqRgcW9GQktvOG5CQZ1fQIb4C9UAgX9x6KWCvcshocTjHm
 P0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992962; x=1728597762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogpAL5OWdHqEz0W+SP94H3IGBFnb9UrrFaQ9n/v5a8s=;
 b=WOzpUTuK+q0vt/9N7mA3F8xq3U7GRy4m1RmPzw+limRGpccf8x8Ntvk/0c/Af7mAMY
 VIPnGAPe15I0LTACXTttSPFYGXgqPqhvE626rz8Bnp7f9HQ3woj2AwM8dZ51iYuIiXdJ
 hYF9/Sw8XGxtQzhT0X9CtPRoUug6HZ89W8/tLt+67UESlbizSKl++HAC5AQNyccuqaeU
 RJVeMBfZtxMhQdb2e6ZODUmETh3QZOXhl7M8OK1S5PckRHofgTsOo2wWyz8Pd+V0eoKf
 UQI3eW6nJ6HhM9qtzaADxzUEWleAg3wpiOclLh0P/x0pGCYVBuc5TBkg4/WCDOLSI7lK
 nr9Q==
X-Gm-Message-State: AOJu0Yxqfy58JJbPOyX7VmCD5krP4zXkbIiJyCwLWhXBCKpePotVu2TS
 UN7M2vrDQr29BdbaJrLPz5AfQgJep/e9wmengiAL14HhqqPdy2sszvXEzNi3TE8Nzt8kQIn4p9R
 1
X-Google-Smtp-Source: AGHT+IGsoDxxFMAHMQyPuNxZ00XO5py1yoPe3l2uTjWtl1E8pOu5Duef3s1Gs/LpcZwPRhWGBxH62g==
X-Received: by 2002:a05:620a:31a5:b0:7a9:c129:297a with SMTP id
 af79cd13be357-7ae6f44cb1fmr122149985a.32.1727992961972; 
 Thu, 03 Oct 2024 15:02:41 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:02:41 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 21/27] mbedtls: add MSCode parser porting layer
Date: Thu,  3 Oct 2024 14:50:34 -0700
Message-Id: <20241003215112.3103601-22-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
Changes in v7
- None.
Changes in v8
- None

 lib/mbedtls/Kconfig         |   9 +++
 lib/mbedtls/Makefile        |   1 +
 lib/mbedtls/mscode_parser.c | 123 ++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)
 create mode 100644 lib/mbedtls/mscode_parser.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 189bb3186b6..fd7263f9616 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -303,6 +303,7 @@ config MBEDTLS_LIB_X509
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -333,6 +334,14 @@ config PKCS7_MESSAGE_PARSER_MBEDTLS
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
index 128a29c512f..488b66402b3 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
+obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
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

