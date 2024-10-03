Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C81CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7AE8912E;
	Fri,  4 Oct 2024 06:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ua8nUhCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9E287BF4; Fri,  4 Oct 2024 00:03:52 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE6388ED2
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4582f9abb43so9868921cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993027; x=1728597827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTr113vVrdomQhXIdWvbhTV2ppfH9FCIzHZq+dkXUXw=;
 b=Ua8nUhCS0LsoMIOqFdME07tHkKaKY4AyQwmEYVSxScsbz2N20tIS6nwq9fHzsE0ymu
 J5I4RlaYJsuZb1uOIJi5fBDzBxg69+qbp55b+KjwhX5jaCKt7tFPZiQCqgstvJpKUtiS
 kDKb7dfXUWpIPq+wB84kWK/PlOw7K6PuZIDp5BFzfOay09prtb1XTs6D4caDtvqVRhvu
 lUVF93TPjvnvEZEw1fTRGgKyzzIpV7TqtXNm7BIM/eAud7pndnNc9hzQHmbjahtpZU3L
 gYiMgxr1pWnV5oY8XONKz3CLY2TB5ydtyMO47ExgeeZioRvQQvRewiYq37G0mpTVP5+j
 Dbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993027; x=1728597827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTr113vVrdomQhXIdWvbhTV2ppfH9FCIzHZq+dkXUXw=;
 b=nj11hDvESQ4gtPnjJWZgV60UzK6rnuGgBScmo67NSvS3da5HTp5Sv4FlaG1R2H6Bnp
 54khm1E48C8GvVCWq155Y2tpge7olVIL1+03H0zES4zdDPLLqlBtQgx0j4CXpEB4hNKl
 N+jZNAFPH/hLegjLeYHgvf0apZnftIQp7GQQ6drAffAcGKvdr2AkkQxASgUUd6tEXDXO
 ZLHwDIA+ki1joPn9dKyNDNqvzSA1LkMkHHMZ39cVx0j8VpfQoWidY1DrPGOZpvtdB2Nk
 9LvqY8LR4446G6o7SYrG2ER/UeDnRaLGZUaZilsL919M7K9mKVdwI7xwckQjAeAbxWSV
 Z5fw==
X-Gm-Message-State: AOJu0YyaZBnpeqxrOORufLYNEzr8lgYWXWAexmj2CHvUVQZAMaXatSb5
 qq0id4KgGQJ/uv0kCT4s74yeqWW8YuiHnqJA0K0Vco8FgGzdc3dsusLYBGwBsAmOpDezDgVlp9H
 T
X-Google-Smtp-Source: AGHT+IEWZILBeOeJFYeBRxuJf7sWk3OJtD0p0NCd6kvoaI79Rit6mGHPKVIOuE7/GxHLncxb2tSgqw==
X-Received: by 2002:a05:622a:18a7:b0:45b:5cdf:54b8 with SMTP id
 d75a77b69052e-45d9ba9fa48mr9702551cf.19.1727993026662; 
 Thu, 03 Oct 2024 15:03:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:03:45 -0700 (PDT)
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
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 23/27] mbedtls: add RSA helper layer on MbedTLS
Date: Thu,  3 Oct 2024 14:50:36 -0700
Message-Id: <20241003215112.3103601-24-raymond.mao@linaro.org>
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

Add RSA helper layer on top on MbedTLS PK and RSA library.
Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
  MbedTLS implementations respectively.
- Remove unnecessary type casting.
Changes in v5
- Correct header file include directories.
- Correct kconfig dependence.
- Kconfig rename.
- Refactored MbedTLS makefile.
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

 lib/mbedtls/Kconfig      | 36 +++++++++++++++
 lib/mbedtls/Makefile     |  3 +-
 lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/rsa_helper.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index efeaed50385..ab50ad4ebe9 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -118,11 +118,13 @@ config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable legacy certificate libraries.
 
@@ -135,6 +137,14 @@ config ASYMMETRIC_PUBLIC_KEY_LEGACY
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm.
 
+config RSA_PUBLIC_KEY_PARSER_LEGACY
+	bool "RSA public key parser with legacy certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_LEGACY
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for RSA public key
+	  parser.
+
 config X509_CERTIFICATE_PARSER_LEGACY
 	bool "X.509 certificate parser with legacy certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_LEGACY
@@ -168,6 +178,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm in SPL.
 
+config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
+	bool "RSA public key parser with legacy certificate library in SPL"
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
+	select SPL_ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for RSA public key
+	  parser in SPL.
+
 endif # SPL
 
 endif # LEGACY_CRYPTO_CERT
@@ -310,11 +328,13 @@ config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable MbedTLS certificate libraries.
 
@@ -327,6 +347,14 @@ config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm.
 
+config RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	bool "RSA public key parser with MbedTLS certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for RSA public key
+	  parser.
+
 config X509_CERTIFICATE_PARSER_MBEDTLS
 	bool "X.509 certificate parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
@@ -360,6 +388,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm in SPL.
 
+config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	bool "RSA public key parser with MbedTLS certificate library in SPL"
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	select SPL_ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for RSA public key
+	  parser in SPL.
+
 endif # SPL
 
 endif # MBEDTLS_LIB_X509
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 488b66402b3..04d450afd82 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
 obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
+obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
@@ -39,7 +40,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/bignum.o \
 	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
diff --git a/lib/mbedtls/rsa_helper.c b/lib/mbedtls/rsa_helper.c
new file mode 100644
index 00000000000..3d94eee9954
--- /dev/null
+++ b/lib/mbedtls/rsa_helper.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * RSA helper functions using MbedTLS
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <crypto/internal/rsa.h>
+#include <library/common.h>
+#include <mbedtls/pk.h>
+#include <mbedtls/rsa.h>
+#include <mbedtls/asn1.h>
+
+/**
+ * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in the
+ *                       provided struct rsa_key, pointers to the raw key as is,
+ *                       so that the caller can copy it or MPI parse it, etc.
+ *
+ * @rsa_key:	struct rsa_key key representation
+ * @key:	key in BER format
+ * @key_len:	length of key
+ *
+ * Return:	0 on success or error code in case of error
+ */
+int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
+		      unsigned int key_len)
+{
+	int ret = 0;
+	mbedtls_pk_context pk;
+	mbedtls_rsa_context *rsa;
+
+	mbedtls_pk_init(&pk);
+
+	ret = mbedtls_pk_parse_public_key(&pk, (const unsigned char *)key,
+					  key_len);
+	if (ret) {
+		pr_err("Failed to parse public key, ret:-0x%04x\n", -ret);
+		ret = -EINVAL;
+		goto clean_pubkey;
+	}
+
+	/* Ensure that it is a RSA key */
+	if (mbedtls_pk_get_type(&pk) != MBEDTLS_PK_RSA) {
+		pr_err("Non-RSA keys are not supported\n");
+		ret = -EKEYREJECTED;
+		goto clean_pubkey;
+	}
+
+	/* Get RSA key context */
+	rsa = mbedtls_pk_rsa(pk);
+	if (!rsa) {
+		pr_err("Failed to get RSA key context, ret:-0x%04x\n", -ret);
+		ret = -EINVAL;
+		goto clean_pubkey;
+	}
+
+	/* Parse modulus (n) */
+	rsa_key->n_sz = mbedtls_mpi_size(&rsa->N);
+	rsa_key->n = kzalloc(rsa_key->n_sz, GFP_KERNEL);
+	if (!rsa_key->n) {
+		ret = -ENOMEM;
+		goto clean_pubkey;
+	}
+	ret = mbedtls_mpi_write_binary(&rsa->N, (unsigned char *)rsa_key->n,
+				       rsa_key->n_sz);
+	if (ret) {
+		pr_err("Failed to parse modulus (n), ret:-0x%04x\n", -ret);
+		ret = -EINVAL;
+		goto clean_modulus;
+	}
+
+	/* Parse public exponent (e) */
+	rsa_key->e_sz = mbedtls_mpi_size(&rsa->E);
+	rsa_key->e = kzalloc(rsa_key->e_sz, GFP_KERNEL);
+	if (!rsa_key->e) {
+		ret = -ENOMEM;
+		goto clean_modulus;
+	}
+	ret = mbedtls_mpi_write_binary(&rsa->E, (unsigned char *)rsa_key->e,
+				       rsa_key->e_sz);
+	if (!ret)
+		return 0;
+
+	pr_err("Failed to parse public exponent (e), ret:-0x%04x\n", -ret);
+	ret = -EINVAL;
+
+	kfree(rsa_key->e);
+clean_modulus:
+	kfree(rsa_key->n);
+clean_pubkey:
+	mbedtls_pk_free(&pk);
+	return ret;
+}
-- 
2.25.1

