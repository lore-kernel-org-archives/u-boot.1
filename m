Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D0BC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4598088651;
	Tue,  2 Jul 2024 20:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="okyn1pZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E3288651; Tue,  2 Jul 2024 20:33:45 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C86887F3
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-446883be273so4565331cf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945222; x=1720550022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/AsRuYvZzjSnj9xSL7lz/6l5OFv0vCjgMjCFb21VUw=;
 b=okyn1pZyfCIETAkXxakSnexrBMMWLaeq6ViZznl0Cdq3qr8Xj2RV1aNA1hpJJj/LXq
 dAOWq49IHVEAgiDwJNDTcZyADL6vrNHB6QP0uFBhEjwOjfM8anxPhRMVEHId+p98k74X
 rW/CPT4CKQGm8IJqP7MTVFHLjzqCbkynvHtVmrjHY60DU0qv3SodZyPvT0GEwFT5Uzvy
 9Gpmb2Ps+/Dh/da5yIL+UKPw4i1mXQAkxhUW7G8X7DjB3lg75HqsflZ7ZA9lZCIW3/qy
 erj7/1UgEwlWIZ0Ys4sX8YzZE1ff9E5QIbyT09OIbOnnvauIiBcP5e4Fp+GCu3DDz3+Y
 9CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945222; x=1720550022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/AsRuYvZzjSnj9xSL7lz/6l5OFv0vCjgMjCFb21VUw=;
 b=An2MSwEaXQ4V+GVrnCqqyZnCkRpcEbC8/1/RyQxmE222o9Fk1nkV4PsshAW3kPTs96
 xb4vWoYydb4AjYEXgvz+WgEeSl3ER1elf8Wj6iRawYEBmPfexEzKoenaQsJh7lW7Oobv
 m2+numnjdVBcR0q69X9oJSF3pmBoT8mAUSCkJNqE64LT1fDjTG9/8b2HcqfodZWJaJby
 g4GefVqzoX9dg7sq8kwoUEEv1kFqsqrZxiUnFOx1acNxmhggIHP4Gh++Ch6YNM9lSXul
 a0tJKlwiWYpGm1MIf3VUfd6sY5xgk2jn74dmuKUpW25HNYVtjTWA9+okxHVx6iraFIIu
 lwdw==
X-Gm-Message-State: AOJu0Yz6u3pJVXaKXd//Yux9hiYbgKHpYXXQ2ye2PlE0kzZ+Fsb5G2C7
 k5swlLeayl3s36E5Am1tn2a62hgW04T+he02NhooU1R+AuqqB44UEmTfJcHt4hvVSPPDjyOaGeE
 2
X-Google-Smtp-Source: AGHT+IGSD6vopZ25mStrJPpde9yUSv/m+u53LSbJNZrESrYHzre9PqjeNRrodO+i+Rz2k5a0r3ClKg==
X-Received: by 2002:a05:622a:138d:b0:446:5fe5:5e6e with SMTP id
 d75a77b69052e-44662da0de5mr107956421cf.17.1719945222113; 
 Tue, 02 Jul 2024 11:33:42 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:33:41 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 25/29] mbedtls: add RSA helper layer on MbedTLS
Date: Tue,  2 Jul 2024 11:23:01 -0700
Message-Id: <20240702182325.2904421-26-raymond.mao@linaro.org>
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
- Minor fix of the include directories.

 lib/mbedtls/Kconfig      | 36 +++++++++++++++
 lib/mbedtls/Makefile     |  3 +-
 lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/rsa_helper.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index d8a8f87e031..87c500d6ca9 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -124,11 +124,13 @@ config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
+	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER && SPL
 	help
 	  Enable legacy certificate libraries.
 
@@ -141,6 +143,14 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm.
 
+config RSA_PUBLIC_KEY_PARSER_LEGACY
+	bool "RSA public key parser with legacy certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for RSA public key
+	  parser.
+
 config X509_CERTIFICATE_PARSER_LEGACY
 	bool "X.509 certificate parser with legacy certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
@@ -174,6 +184,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm in SPL.
 
+config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
+	bool "RSA public key parser with legacy certificate library in SPL"
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
+	select SPL_ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for RSA public key
+	  parser in SPL.
+
 endif # SPL
 
 endif # LEGACY_CRYPTO_CERT
@@ -287,11 +305,13 @@ config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
+	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER && SPL
 	help
 	  Enable MbedTLS certificate libraries.
 
@@ -303,6 +323,14 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm.
 
+config RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	bool "RSA public key parser with MbedTLS certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for RSA public key
+	  parser.
+
 config X509_CERTIFICATE_PARSER_MBEDTLS
 	bool "X.509 certificate parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
@@ -334,6 +362,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm in SPL.
 
+config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	bool "RSA public key parser with MbedTLS certificate library in SPL"
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
+	select SPL_ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for RSA public key
+	  parser in SPL.
+
 endif # SPL
 
 endif # MBEDTLS_LIB_X509
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index ac7c487449d..9c6991f8783 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -28,6 +28,7 @@ x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
+x509_mbedtls-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
@@ -49,7 +50,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
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

