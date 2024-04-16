Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F1EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5118847C;
	Tue, 16 Apr 2024 21:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CyvPQwUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB53A88478; Tue, 16 Apr 2024 21:02:20 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E708843F
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-699320fcbc1so25447486d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294125; x=1713898925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8o2dz6grj+fNiGrx6B/bngSgi7+QdEVslXlEopONBU=;
 b=CyvPQwUIydEijoWGzT1lHnDx52eg1k3ata2cYKyHs2lbIlnILBhxsRsdohMmUWXFsa
 9uyFo1q2XLvqZyiCGu7Iu+5m6fKcMURomB7KRcOUd67n3oI9Q2OOnmzCju0c9H+u6rK4
 VukLRPze+pqxe+4+HHESSscoAXw6dknl8Sqd9jXVWTYgNwpRjvKuT/O126C7S3p9Y8V/
 n2JKiCJj2BqS2nExhPMmPYLF6rz08/kU5OBxwrhjLZGfvkszvqdUNuWr45dbS3hvtOvp
 9EK9rurVnt3zeoArkrKp3xxHlWje3MIr/xvnXafNPyeJXtFK3hDfJmdG7y7Cde6sMO9u
 ASTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294125; x=1713898925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8o2dz6grj+fNiGrx6B/bngSgi7+QdEVslXlEopONBU=;
 b=RbWLmD/zbaM1Q4DCVRZ8UXjQ7AHO3HcdlHZQwt8MViyPwAth+Mke15uB8H9S0XPsT1
 RvQAhJ3TZm01P647gRpDCa6gUQ2GGm1ngnhUuh+OGMhsHS5toM37ZZeiws9cVCeb7FHf
 szWoWtB5HcIJPhk9OriUwj/wBURGShiDJfKarcWCG6mYy/Vq+GmwgwgCDcNTaz9Ssujq
 uAKFtU6ipO2nwacRZYhXqOcZMSeJwpKuC5wpDyJEs35AHB2DBqPY54BNNuymiew8YjBf
 mFRfhNR1pjm8Nn2C1rjhaELt4ZNdWJYbXNK7ay9S6pV0JRNgqUx6YVg2zM23R8ZO9g5G
 J2eg==
X-Gm-Message-State: AOJu0Yz4PL+HaZFJ5VrmvYLMbDHLMOfSUrvpuqTuIUeZHSMZ02DXaoAh
 jn0/E42NzEljNse+Ny7uNATqRg2u9x88ExGWB9deHlOw3W3piC8PV2suWAYxr/Pnuvh4UMdizv7
 G
X-Google-Smtp-Source: AGHT+IHe30VGT5ygSsQ2ZRGzi603BxBk49EvEI3Mjz7Bj3cObeEr7GshdDKtZLVM7LIZ1FsWF77pvA==
X-Received: by 2002:ad4:51d0:0:b0:69b:3661:6d34 with SMTP id
 p16-20020ad451d0000000b0069b36616d34mr14452747qvq.25.1713294125451; 
 Tue, 16 Apr 2024 12:02:05 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:05 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 17/23] lib/crypto: Port public_key on MbedTLS
Date: Tue, 16 Apr 2024 12:00:13 -0700
Message-Id: <20240416190019.81016-18-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Integrate function public_key_verify_signature on top of MbedTLS
pk library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/crypto/public_key.h  |  6 +++
 lib/crypto/asymmetric_type.c |  2 +-
 lib/crypto/public_key.c      | 75 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 3ba90fcc34..55cd4c2b01 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -12,6 +12,12 @@
 
 #ifdef __UBOOT__
 #include <linux/types.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/library/common.h>
+#include <external/mbedtls/include/mbedtls/pk.h>
+#include <external/mbedtls/include/mbedtls/x509_crt.h>
+#include <external/mbedtls/include/mbedtls/md.h>
+#endif
 #else
 #include <linux/keyctl.h>
 #endif
diff --git a/lib/crypto/asymmetric_type.c b/lib/crypto/asymmetric_type.c
index 24c2d15ef9..95b82cd8e8 100644
--- a/lib/crypto/asymmetric_type.c
+++ b/lib/crypto/asymmetric_type.c
@@ -12,7 +12,6 @@
 #include <keys/asymmetric-subtype.h>
 #include <keys/asymmetric-parser.h>
 #endif
-#include <crypto/public_key.h>
 #ifdef __UBOOT__
 #include <linux/bug.h>
 #include <linux/compat.h>
@@ -26,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #endif
+#include <crypto/public_key.h>
 #ifdef __UBOOT__
 #include <keys/asymmetric-type.h>
 #else
diff --git a/lib/crypto/public_key.c b/lib/crypto/public_key.c
index 6efe951c05..29576684f1 100644
--- a/lib/crypto/public_key.c
+++ b/lib/crypto/public_key.c
@@ -94,6 +94,80 @@ EXPORT_SYMBOL_GPL(public_key_signature_free);
  *
  * Return:	0 - verified, non-zero error code - otherwise
  */
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
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
+		pr_err("Failed to parse public key, ret:-0x%04x\n",
+		       (unsigned int)-ret);
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
+#else	/* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig)
 {
@@ -142,6 +216,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	pr_devel("<==%s() = %d\n", __func__, ret);
 	return ret;
 }
+#endif	/* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 #else
 /*
  * Destroy a public key algorithm key.
-- 
2.25.1

