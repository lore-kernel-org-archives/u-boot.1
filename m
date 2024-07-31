Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24478C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A821288A08;
	Wed, 31 Jul 2024 19:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EeJ79/kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828AC88AA6; Wed, 31 Jul 2024 19:31:55 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11BE88841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a1d3e93cceso117317185a.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447112; x=1723051912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAUKilCGppY+di/qpqZ9Ygk5gZDtUdVNE53flRR/YmM=;
 b=EeJ79/kfgyye81zlySbGmCM7vuvpn5DnTai8XkGUt5zPb2QsXLitYmVgUsrKND6fNF
 edjUPT0MLUoD5hEhkCNMwOqb+9jQAMjI1rGySvPJe+S18PhCKsV4pi25h1kjLlsie0xD
 6uII1OUNZZIjDDRyOkeR6f+/NZZvVzHGu11ZnRPf+EGWjX7Hi60jYYHx+2uKXIlu7sSh
 tWPZCMSYSSR5nuhJtTRfj6IE7RWHQrTc9mwaHN/Tgbr4jQPDfSvEKyVtOqzf0qkGcoTy
 xsnf0Xaa41wrMJifmWSBloThzwOFWLIrgJuyWMWhfnZ7Lpc6UEmA+V63isfaPcZyZ9IT
 0hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447112; x=1723051912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAUKilCGppY+di/qpqZ9Ygk5gZDtUdVNE53flRR/YmM=;
 b=Ie5TrsWQOys9H7+MeJoIWGGx3NOu1VdodJpPYoLEP+FGhiYk/+IJrdWKV9IIi8KFT/
 2zuA1Y7WVjiZkeZZ3fB427BAGLwBasZGl0OnhpH8YZvJbIOdUvMms6sbL1KKt5yOvSIH
 S1gm7rLn2kJjxPHWUTpvUUfZExS3pwTi6OCzknrG4ep2dUJM0HDjh2xyP9+nwbPWDqzP
 PoKoReMPiISwDAQoi2cGuaZtOzmoBeFuo+68pkjx77jSDkSh9qElZwHUGYcmkqNowcrn
 WG/luPiPIiYQZ48YlPmBywwzO0mLRknKXPW13bp0+zkaQRNrIVCPD9ACUFuP8bZODpM4
 LxCQ==
X-Gm-Message-State: AOJu0Yz1Cajj44REmzUtuDrEgCHaSEa151lNFgwV4f7NSOuZwatPVrsy
 sG5FBuwqjIUXuQdG6xMXvIaWqgvrRUsCNo3mAVfFz8iViFQkyFmgnQjV0lvCDe7JnTP+BodHutz
 b9A4=
X-Google-Smtp-Source: AGHT+IGZMpfhliRl/Cycdmvq7FQwOkOdE5w1hXxBX+2hMYEQhbbgJmPeSMUFRLKYF9hSK0bS7kpyww==
X-Received: by 2002:a05:620a:4009:b0:79f:e0d:e052 with SMTP id
 af79cd13be357-7a200ca7813mr1049961585a.9.1722447111653; 
 Wed, 31 Jul 2024 10:31:51 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:31:51 -0700 (PDT)
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v5 15/27] mbedtls: add public key porting layer
Date: Wed, 31 Jul 2024 10:25:25 -0700
Message-Id: <20240731172556.1348487-16-raymond.mao@linaro.org>
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

Add porting layer for public key on top of MbedTLS X509 library.
Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for public key legacy and
  MbedTLS implementations respectively.
- Move common functions to helper.
Changes in v5
- Correct kconfig dependence.
- Kconfig rename.
- Refactored MbedTLS makefile.
- Adjust a few inline comments.

 lib/mbedtls/Kconfig      | 52 +++++++++++++++++++++++++
 lib/mbedtls/Makefile     |  6 ++-
 lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/public_key.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 12f8c965f5a..e95b722c6e8 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -117,9 +117,35 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
+		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
 	  Enable legacy certificate libraries.
 
+if LEGACY_CRYPTO_CERT
+
+config ASYMMETRIC_PUBLIC_KEY_LEGACY
+	bool "Asymmetric public key crypto with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses legacy certificate library for asymmetric public
+	  key crypto algorithm.
+
+if SPL
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
+	bool "Asymmetric public key crypto with legacy certificate library in SPL"
+	depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses legacy certificate library for asymmetric public
+	  key crypto algorithm in SPL.
+
+endif # SPL
+
+endif # LEGACY_CRYPTO_CERT
+
 endif # LEGACY_CRYPTO
 
 if MBEDTLS_LIB
@@ -222,7 +248,33 @@ endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
+	select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
+		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
 	  Enable MbedTLS certificate libraries.
 
+if MBEDTLS_LIB_X509
+
+config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	bool "Asymmetric public key crypto with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses MbedTLS certificate library for asymmetric public
+	  key crypto algorithm.
+
+if SPL
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
+	depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses MbedTLS certificate library for asymmetric public
+	  key crypto algorithm in SPL.
+
+endif # SPL
+
+endif # MBEDTLS_LIB_X509
+
 endif # MBEDTLS_LIB
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 50c1ba5f88e..2d2220dd4fd 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,10 @@ obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
 
+# x509 libraries
+obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+	public_key.o
+
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
@@ -36,7 +40,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
 	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
diff --git a/lib/mbedtls/public_key.c b/lib/mbedtls/public_key.c
new file mode 100644
index 00000000000..5f73b99d4f2
--- /dev/null
+++ b/lib/mbedtls/public_key.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Public key helper functions using MbedTLS X509 library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <linux/compat.h>
+#include <crypto/public_key.h>
+
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	mbedtls_md_type_t mb_hash_algo;
+	mbedtls_pk_context pk_ctx;
+	int ret;
+
+	if (!pkey || !sig || pkey->key_is_private)
+		return -EINVAL;
+
+	/*
+	 * ECRDSA (Elliptic Curve Russian Digital Signature Algorithm) is not
+	 * supported by MbedTLS.
+	 */
+	if (strcmp(pkey->pkey_algo, "rsa")) {
+		pr_err("Encryption is not RSA: %s\n", sig->pkey_algo);
+		return -EINVAL;
+	}
+
+	/*
+	 * Can be pkcs1 or raw, but pkcs1 is expected.
+	 * This is just for argument checking, not necessarily passed to MbedTLS,
+	 * For RSA signatures, MbedTLS typically supports the PKCS#1 v1.5
+	 * (aka. pkcs1) encoding by default.
+	 * The library internally handles the details of decoding and verifying
+	 * the signature according to the expected encoding for the specified algorithm.
+	 */
+	if (strcmp(sig->encoding, "pkcs1")) {
+		pr_err("Encoding %s is not supported, only supports pkcs1\n",
+		       sig->encoding);
+		return -EINVAL;
+	}
+
+	if (!strcmp(sig->hash_algo, "sha1"))
+		mb_hash_algo = MBEDTLS_MD_SHA1;
+	else if (!strcmp(sig->hash_algo, "sha224"))
+		mb_hash_algo = MBEDTLS_MD_SHA224;
+	else if (!strcmp(sig->hash_algo, "sha256"))
+		mb_hash_algo = MBEDTLS_MD_SHA256;
+	else if (!strcmp(sig->hash_algo, "sha384"))
+		mb_hash_algo = MBEDTLS_MD_SHA384;
+	else if (!strcmp(sig->hash_algo, "sha512"))
+		mb_hash_algo = MBEDTLS_MD_SHA512;
+	else	/* Unknown or unsupported hash algorithm */
+		return -EINVAL;
+	/* Initialize the mbedtls_pk_context with RSA key type */
+	mbedtls_pk_init(&pk_ctx);
+
+	/* Parse the DER-encoded public key */
+	ret = mbedtls_pk_parse_public_key(&pk_ctx, pkey->key, pkey->keylen);
+	if (ret) {
+		pr_err("Failed to parse public key, ret:-0x%04x\n", -ret);
+		ret = -EINVAL;
+		goto err_key;
+	}
+
+	/* Ensure that it is a RSA key */
+	if (mbedtls_pk_get_type(&pk_ctx) != MBEDTLS_PK_RSA) {
+		pr_err("Only RSA keys are supported\n");
+		ret = -EKEYREJECTED;
+		goto err_key;
+	}
+
+	/* Verify the hash */
+	ret = mbedtls_pk_verify(&pk_ctx, mb_hash_algo, sig->digest,
+				sig->digest_size, sig->s, sig->s_size);
+
+err_key:
+	mbedtls_pk_free(&pk_ctx);
+	return ret;
+}
-- 
2.25.1

