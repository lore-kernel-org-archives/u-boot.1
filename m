Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4FFC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A67688C61;
	Fri, 16 Aug 2024 23:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XSL+mtR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67D788498; Fri, 16 Aug 2024 23:54:09 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7845188C67
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf6beda038so14437846d6.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845246; x=1724450046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1Sv3F2dWvNjUl+hfOcYjr7iAs202twLOgelq8etZlM=;
 b=XSL+mtR5RY0uyaqtD8/PUgRK6MtlSrs1I0JMVTsfAlYArOk76KxnX2lIIAfkxehRBq
 1r4UXCntpmFXoUO3QChNR3eMQNcWI9WEeKlcP6kuPHeZwYTi3KJ3XQB0/DUdCvFH2sMf
 n2ZewBw7vpTxOzpupz2llSlIdvex8C7zrwadupquT7a4ddWAs121r1FK8GlNLAv3sNqC
 S0bbYwdFrICR7ROIG7f79Xs4bXyQVK9q4qT1q2FFxhdGWM4twgqrDV7wie5WSxW7Vc3G
 y82aqor8+dds2DJVwvhKkfcL+jQ/nf+2Xn1lO4Zes25QcwHJ61we+4Z+Z9PBiDjF03VL
 mXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845246; x=1724450046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1Sv3F2dWvNjUl+hfOcYjr7iAs202twLOgelq8etZlM=;
 b=nvDc4knYdwyiQdK5itvjhF4FumMhIMC0U1zA/olVIRelpzsZn4nHMzxeGNOV+VCRlL
 PbeHSfNnFc/W1ilaHGT8pVZea4ky6q7PC+mxOIdiuO61Ud8I9rLareY3W1jeIOrgfLm/
 Pq4YAYYgXJgKJNwEYjHuTTa5AM28uR4hi5iIz1J5cQN5ggI9+ug1uoiLTfBjYuBr9u/K
 ISPRiYoxsKDMGFtL+DN7r8jUFujGNbgfvTtiURG9fPuknXtxVD90sBGfEchCKPHLdSyD
 G3wn7DPehDSOiOjMwU63HZfTeV/iMATMaPFOqGZsSeUH0aOZ0FnzsRTQuQNFNCljdfRT
 356w==
X-Gm-Message-State: AOJu0Yxxtf6k9GDri65elLu9jt+UlfHlFm59+yhdGTUd1pS2s6uwwk5w
 fVsnHi5IFlQCYg2iuXj3kfgs/9SFOih+liRccsfuJVX8H0okFRRuqkUyjr13FFKId4z8cKjsDJO
 LM/c=
X-Google-Smtp-Source: AGHT+IFq8Z9e8OtzsK1MXVeKhEjS71/jbeJl8cP7h7hU385u/ikaz+MQIzn9fnEzXyNjBfs+RiBGKg==
X-Received: by 2002:a05:6214:32b:b0:6bf:7fd5:5c1e with SMTP id
 6a1803df08f44-6bf7fd5605amr26187086d6.31.1723845246042; 
 Fri, 16 Aug 2024 14:54:06 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:54:05 -0700 (PDT)
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 24/28] mbedtls: add RSA helper layer on MbedTLS
Date: Fri, 16 Aug 2024 14:44:13 -0700
Message-Id: <20240816214436.1877263-25-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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

Add RSA helper layer on top on MbedTLS PK and RSA library.
Introduce _LEGACY and _MBEDTLS kconfigs for RSA helper legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
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

 lib/mbedtls/Kconfig      | 36 +++++++++++++++
 lib/mbedtls/Makefile     |  3 +-
 lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/rsa_helper.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index ecdf4d3008f..797da0df938 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -119,11 +119,13 @@ config LEGACY_CRYPTO_CERT
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
 
@@ -136,6 +138,14 @@ config ASYMMETRIC_PUBLIC_KEY_LEGACY
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
@@ -169,6 +179,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
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
@@ -301,11 +319,13 @@ config MBEDTLS_LIB_X509
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
 
@@ -318,6 +338,14 @@ config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
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
@@ -351,6 +379,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
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
index 83333b1b6a5..40031994708 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
 obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
+obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
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

