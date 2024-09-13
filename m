Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05B5FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3C488DF4;
	Sat, 14 Sep 2024 03:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WiFsnO6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFA888706; Fri, 13 Sep 2024 18:11:23 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010AB887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c35357cdacso15519696d6.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243880; x=1726848680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIYXrew8fQP2spZQlmIhvQuHj4q6rdhFHTQLidy5JlE=;
 b=WiFsnO6wqnqY7QT5wud9lD+rAMUsXT6L64e9cwfETxiz8ET46ryQ4CtgWFelx6iUn5
 +lW66MuZzQTHYSi+jfcqx6Jq1wMM9li0iPssHbb6+QPzXP0wVgcfvkKD6N5GEzB/qDU3
 IRS4DSEZfV9PJwktOOjlDuLOG0/rG11cwEjZEIaB9X3d7GgsxiNS1M2aM9cb13PhzEpG
 VSp8w1as+I9SjPJF9wOEATWMCKi0t3TvUZFHLOTWqJJzGdPIKv6YzeMfOKtf/UyzB89T
 YdyyfGru/Q79hq/Kq5kSgI0+9n5gvsERv4bVAIqQADivDDcO88sVSuI94EPbfGMmUSSj
 Vs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243880; x=1726848680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIYXrew8fQP2spZQlmIhvQuHj4q6rdhFHTQLidy5JlE=;
 b=MKMsvfPIMi5fc1w0rnbaiPkV8TZHZKlhu3aFEEDqlV9PLxtrgYLrxURJ/v6hss0Xr0
 YEXyWFEQHHZ0m0xp+6FDgZA3IBiRka2ZtdvfmxtYgPNHbNBefWpd3UOyg1VP2JAOhn/h
 fTeBIyEc6ne0n7ajkBkxoGt4L2UR6ZJhXUIYGjyzgPjSh+XAHj5xNryrrfYKEAPFzNUJ
 rTLyez64OR+M1MdY7fdyz/5AWbyFe39o71jjGNdLda2IORTa+Yu5a21jojGN5q/k/lKS
 RHjn89YG2dcwbFwxVb1lRDwtRn0WKziznzSMJWlKPgwnBt4KfR4/z7SSL0UhqgVyg6QK
 83Ww==
X-Gm-Message-State: AOJu0YykbVEz8AmFdQR31Mpghkaf3k0sWY8zRNaaTt32USnBdnp9VPPO
 hY7MIENsmf4sy2IzYvl5FjsslZHi3Sg2VED9aOU8WMVotVabvXS0o/qPqZMWugfEhvM1V4wt6ws
 g
X-Google-Smtp-Source: AGHT+IGmRN8ZUUFySCVogJ1Z2lSbVkpGTVlzJe+pBhKTugNAggs/1AUT6WdJsNluxY6mFvk5uunsvg==
X-Received: by 2002:a05:6214:4606:b0:6c3:6d91:c363 with SMTP id
 6a1803df08f44-6c57356b3efmr100062696d6.27.1726243879573; 
 Fri, 13 Sep 2024 09:11:19 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:11:19 -0700 (PDT)
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
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 15/27] mbedtls: add public key porting layer
Date: Fri, 13 Sep 2024 09:03:32 -0700
Message-Id: <20240913160408.2199558-16-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
Changes in v6
- None.
Changes in v7
- None.

 lib/mbedtls/Kconfig      | 52 +++++++++++++++++++++++++
 lib/mbedtls/Makefile     |  6 ++-
 lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/public_key.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 7ee1139568b..4f710640885 100644
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
@@ -246,7 +272,33 @@ endif # MBEDTLS_LIB_CRYPTO
 
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

