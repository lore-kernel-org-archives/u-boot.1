Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDFCC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438AA887A1;
	Tue,  2 Jul 2024 20:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjgd298V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECAD887D7; Tue,  2 Jul 2024 20:30:42 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4623387D33
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-79c076c0e1aso270502285a.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945039; x=1720549839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZZ3bXfhSiOht+/fa97+XfGPJlvbLXlnm8V/28V+bw4=;
 b=yjgd298VN9RTwbN4NKT6SCjGBpH5rzf3QwpTFsDNqMGa2k2jHrR/zyBN4JrUYNq5UE
 oPMRdf3+Lgvm357ClADg7XPVeEoJ/FpF2GWS+RqowesKHLAunEl5RNztJQHCNdLk1R/a
 yNr1OBf4XFLb5k6Wk3RGQIyyfz8tjuOUyOXrv/jZW+8OGe3NsI9bWNLLXJD018CysepW
 TjH9UEtW/OMVcV8JgaywAuPSSyRHRpwfTwVcRXgNnlO8zauA8VatZgIeSXxdUSiny9EL
 D7iKYg7xV0SwGVjb3Vs743+UTyaVXjq5/qDhjGo9n2aWhFEtewVkwBYFzMRJLf+ODrqW
 gq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945039; x=1720549839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZZ3bXfhSiOht+/fa97+XfGPJlvbLXlnm8V/28V+bw4=;
 b=RnOUvEwfQNgD9a71TR1e21CU1W0rL3zU/HOOJySjZbHa1HrVIXOXKImGVOGkBpFjkC
 v/OjmAKqukKtGmQhfUl9gdAWLtnXx/n5zFjwizP4tCzxczx0vOGDa3Xq5mEPtYr8WLgh
 gCjba7b+5Jpur67DqiXnxnNeAi+hjWQJtimoZmpNRasw3pc75aNSSZ3ZcV5dtDxcNuv/
 is8y2W0tL7pCWdoiqndd+AcJnssUqQC+E+zq/bAZlgG4jUKoki1AHc/4SqoOR+rt3mbk
 EzOX0zU3jtOl7M4E6wOR5f5lXyeAH3eHZi4oHibLqdi968u3ae0S5zLwi4dm3UAPko9h
 Sddg==
X-Gm-Message-State: AOJu0YwztYRuOTME1CTcEVUmrSbh3RdIb59iMg0x63D52SqJDVJt2nsT
 CdxrHYzCH3l+omcuU+xL0h7X9CQXJSTgEG2kkhgW8CndNV8Lm7rGEa4v+dupSUASn315Fuv0kvP
 Y
X-Google-Smtp-Source: AGHT+IEKfXOLo3bQ7R7MFpDNnVLn9/KFRy3afeWK0FrAq+fkeWY649yOs02JeOx/lfub9Vtwh8JsIQ==
X-Received: by 2002:a05:620a:941:b0:79d:6039:784c with SMTP id
 af79cd13be357-79d7b9de31fmr1180330185a.30.1719945038898; 
 Tue, 02 Jul 2024 11:30:38 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:30:37 -0700 (PDT)
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
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 17/29] mbedtls: add public key porting layer
Date: Tue,  2 Jul 2024 11:22:53 -0700
Message-Id: <20240702182325.2904421-18-raymond.mao@linaro.org>
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

 lib/mbedtls/Kconfig      | 50 ++++++++++++++++++++++++
 lib/mbedtls/Makefile     |  7 +++-
 lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/public_key.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 0cdf0135667..6f29b0c81a2 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -122,9 +122,35 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	help
 	  Enable legacy certificate libraries.
 
+if LEGACY_CRYPTO_CERT
+
+config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
+	bool "Asymmetric public key crypto with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses legacy certificate library for asymmetric public
+	  key crypto algorithm.
+
+if SPL
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
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
@@ -232,7 +258,31 @@ endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
+		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	help
 	  Enable MbedTLS certificate libraries.
 
+if MBEDTLS_LIB_X509
+
+config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
+	bool "Asymmetric public key crypto with MbedTLS certificate library"
+	help
+	  This option chooses MbedTLS certificate library for asymmetric public
+	  key crypto algorithm.
+
+if SPL
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
+	bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
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
index 32a98b7f4ca..f06d0704502 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -20,6 +20,11 @@ hash_mbedtls-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
 hash_mbedtls-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
 hash_mbedtls-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
 
+# x509 libraries
+obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
+x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
+	public_key.o
+
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y += \
@@ -45,7 +50,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += \
 	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
diff --git a/lib/mbedtls/public_key.c b/lib/mbedtls/public_key.c
new file mode 100644
index 00000000000..076a61862cb
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
+	 * ECRDSA (Elliptic Curve RedDSA) from Red Hat is not supported by
+	 * MbedTLS
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

