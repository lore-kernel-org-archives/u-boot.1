Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DECEC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F7B88AA7;
	Wed, 31 Jul 2024 19:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bIV1ogd/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9578D8841E; Wed, 31 Jul 2024 19:34:47 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3421C88AB3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so354129285a.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447284; x=1723052084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOKnlw/P9Y3GYCdXrTLiF89hUsi+QfVR8QlNbQRE/eM=;
 b=bIV1ogd/7KpOYhL648M3r/kvE3C4ZO7H11JhLPiWkmbl90XbdMH3QsGzG7GT3hWejI
 fFu8XkdYkyLiycJ6aiyfagyIVLSsWVGizf7eOsnihaOqJsU+BnuRlufQ1VtKucP2Cj5x
 SoHrWy7fWo1JxYFru315oVCbMSJ9bGeO7h7xyg8M07RrUhC6smP+YEhnfxsJZHzsXcmb
 jypyAurm5pEm9gZDuuK2+KGmqjSWM7CnGXf7NmQIHO/ncE8ofSPcA+3ONIz+31RlbqGX
 5K/kyCGOl6QDQaYDDU2s+O/27YqCyY+CHwz+1QWAM3VrEZldUipHy1hse0740ydcXhkH
 KZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447284; x=1723052084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOKnlw/P9Y3GYCdXrTLiF89hUsi+QfVR8QlNbQRE/eM=;
 b=OjZF7fz/7OFQHNm7zsMyc1Jt/zzIykCIT4ykZ+oTEz7QoF79Y7PFf0QNRgHy0hZUth
 yN22nZHsh1Y6/Pl5F2Hp5aZ36beoI1n0yoipnbyqMafTASRVVwiKPpe2A4VWc44fvFP9
 YKmfULkbbFV5SEww4RLRJmMFOqZ2iloV025WQvqL0dSkoq27l24mvGUwwcjhUFW4UG8N
 weesqnBzT3WbNZZn1eY28Ec++W1MAcwGnM7hjr6b9jVLPtNp31fyyNU2QfOM7QBMginJ
 v+E9OuLyJ1ehwVc9neeNSm0af5shH4y0DTr3eZ12QIp6C67UmMDZCbUz/3fbYQ1qqpvm
 buAg==
X-Gm-Message-State: AOJu0YxNrpYCTCK3XPYGkqthYIzxVu1xtx6gwiK4BdgKdcTC4rWntzd/
 +Ef8U1+V4zJ62SUnjWtz/NNQM11bbKr9O+F/MtBhPdriWBlOUlSsluE9r8UYg0lfJ6QBUO8UPq5
 R+6o=
X-Google-Smtp-Source: AGHT+IHslwj/TrhAG/HN8EiVgPPzWSv5sLbek7mLCYZm8Bokwhi7BvzZU9GMv2jgkjbaRRcv30SvIg==
X-Received: by 2002:a05:620a:4007:b0:7a1:3ffb:e88e with SMTP id
 af79cd13be357-7a1e522ff32mr1865592385a.9.1722447283807; 
 Wed, 31 Jul 2024 10:34:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:34:43 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 23/27] mbedtls: add RSA helper layer on MbedTLS
Date: Wed, 31 Jul 2024 10:25:33 -0700
Message-Id: <20240731172556.1348487-24-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

 lib/mbedtls/Kconfig      | 36 +++++++++++++++
 lib/mbedtls/Makefile     |  3 +-
 lib/mbedtls/rsa_helper.c | 95 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/rsa_helper.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 436fd7d1f94..ea306e07ee4 100644
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
@@ -277,11 +295,13 @@ config MBEDTLS_LIB_X509
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
 
@@ -294,6 +314,14 @@ config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
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
@@ -327,6 +355,14 @@ config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
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

