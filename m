Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8AFC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D54888C91;
	Sat, 17 Aug 2024 00:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="phKvPkJh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0549088C50; Fri, 16 Aug 2024 23:51:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DD188AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6bb84ac8facso12045976d6.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845063; x=1724449863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hs2OK/tYSOoOoZzKf/k9YYA7uvgNRuNIufcZPLot2HE=;
 b=phKvPkJhpC4H2K48SUGpNyvTMx5PMnsY+ds4xNA/f+Aar22k+fdsIaRV6LqgimiHPa
 aiZKtbU+28VmYvTk1zTU+Rk75z6e8kzTedmQkMiAdH2T5V9dHdMsGJX+sgztWSfWZnJY
 RwN4DLHf+hLGK1LpXmtNG+LWD1VPCCoGAALl2/V7waY02rb6Z0IM9RUjblLR0FbGgs8T
 fplLy/JC0uKV3SKKYjDm1rTrju4dEJ2yuDQyQ/0TXB/sQZSXNUSIZvR1o+nwGepyxgAw
 VNRiNUHV2MICpt0rLzlSnlOuH9Bq2Jg/4kOAuKUQfVkEFNXsuUbfIrjZct6YdSw32MZW
 D+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845063; x=1724449863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hs2OK/tYSOoOoZzKf/k9YYA7uvgNRuNIufcZPLot2HE=;
 b=IVH0dAmheBWa9au6skZGK0JGntrmAGrC5IV1BWs32MgCHL83eSApMn3HZs3TQcwJw9
 cv6jpDtnFfqCP+PgHEyCcYCaZqa6mA2OR7a1+txGWPimxTPVzMYYLQLz+vhp8fzVKext
 QHH64QYKTgYmdWf9ANQDg32liBkBXWRlGgNBxEaDyLkyHnVb3AGQUfO0+824vqejSVi6
 bayLKJN2gohkToHKkJ4kP20haB2aSUvobeQLy8Tpfoh8mWq/+25SK9C05d6rrQy87vzC
 9lXRYtq2llsaEeUV8/siIVLf0Y5yYZLC5oqrMEQWFvVQ9eEsM/5C1nIIJjHkKJRNfvtl
 gEsg==
X-Gm-Message-State: AOJu0YyIOv58CXN0j1+eq9OZvkcOTEuC0iv5KAQdaHd2TjJD7Lnmklvi
 cCXJiXXu4oNBRAUTB48CccGwhmRSOaazp3R8OQHgpSRllKf+JsnDmljfBQEB6r+5YvJ1G3AXYu1
 xyxM=
X-Google-Smtp-Source: AGHT+IHh6wS6EkKAaSkl++G0pufTkZEzIya34+G1OcGTKBdx5O1hBrpcKXTmoUWgDnJTO0AjMQkX1A==
X-Received: by 2002:a05:6214:459e:b0:6bb:bd1c:f558 with SMTP id
 6a1803df08f44-6bf7cdbe65fmr62804546d6.22.1723845062776; 
 Fri, 16 Aug 2024 14:51:02 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:51:02 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Anand Moon <linux.amoon@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 16/28] mbedtls: add public key porting layer
Date: Fri, 16 Aug 2024 14:44:05 -0700
Message-Id: <20240816214436.1877263-17-raymond.mao@linaro.org>
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
Changes in v6
- None.

 lib/mbedtls/Kconfig      | 52 +++++++++++++++++++++++++
 lib/mbedtls/Makefile     |  6 ++-
 lib/mbedtls/public_key.c | 82 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/public_key.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 0e22edf1b6c..dbbcdba8bc6 100644
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

