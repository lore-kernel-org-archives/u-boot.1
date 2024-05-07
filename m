Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF5C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB97887C2;
	Tue,  7 May 2024 19:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OdQOo2gJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A178887D1; Tue,  7 May 2024 19:58:47 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDB1883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6a0e72e19b5so8826486d6.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104723; x=1715709523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP8K1qiE3OcayfXBkogw8zIxhrqod/VhZuSBAVOQBRo=;
 b=OdQOo2gJXIQJWTGD5mZ94WxFnDn0UM2YZ+d60366ktiw72jjGRAtRI8YhJTxjkKSO5
 +Kpq7sTQeeUyACb5DKSeN79utB/RyurOt4/8vfAmRgG3eD1KRTcY/IYvtn1AYWIov2Rc
 CrH3DdG4/SYhbPNaqivTsuh8/6c49nyIoLmEt+mnX8M0VNrfILrmfIlzZQsj+kmoQUfX
 zI9HOomFTunBhSYon0uOGl2gZP1gJQbnBezk8J2+nJfwdSyBFOYKcirKIRHhBv7EMG6I
 z5ruGAc7bPtDAydJL/Tkug+yUoi1ao98oo83BBYxqPXQ+XNTsa14TemfJdSgd5Xnr9dS
 0Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104723; x=1715709523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kP8K1qiE3OcayfXBkogw8zIxhrqod/VhZuSBAVOQBRo=;
 b=M23+DWZvn8qDKgL+XqmrCWbxQgwKTJbzJBvJSD5Z2Sd4T78k2KNSO2s+Ef8ysGoVqI
 zNA04K6tMx0nqR0psDkpU9QtbhRbRplRIIRpZZqU8i9ThxS8YIhzWUl5oECA7y+yoVTC
 ILNOUoJOkHnqyfYsiMCiIm35xIxpPCeQMIXhYnOKIZhvl0uM/XCG+LDBB4WoLbfSCVe0
 8XmMmhchDXPAf4BsGME8Zl1qL3xnQhQonbIKg56AH1ewhcJPJnH73Ybsd1pVWhCDIQTQ
 yt84D4tXMmUKlyc1xfFnCcer890Kn+4qguhaTZCjWrkw5WW666gnz5ymekg3ZUhEn8US
 ERRw==
X-Gm-Message-State: AOJu0Yxibyam/YybdgD1TPRFQZxFfwWLdabtLCWSP2Knny21/+AqTWJ2
 XAV4U4zTgZbzmzKDMXsCIEisO3ARjI+Xwg44dfrgJX9mrKZPxvkkz5gNY2qZywn+VhA6WtoDu/c
 +
X-Google-Smtp-Source: AGHT+IGC3VX8gyF5gaytSOCJ9O5HsxH68QVp8JbMOKfb1OgIGx6T4Ptqj0T6QhTdymcpvEEu5v5FqA==
X-Received: by 2002:ad4:5b86:0:b0:6a0:caba:7e36 with SMTP id
 6a1803df08f44-6a15147d471mr5427806d6.29.1715104723448; 
 Tue, 07 May 2024 10:58:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:58:43 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 16/28] mbedtls: add public key porting layer
Date: Tue,  7 May 2024 10:50:58 -0700
Message-Id: <20240507175132.1456512-17-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.

 lib/mbedtls/Makefile     |   4 ++
 lib/mbedtls/public_key.c | 105 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 lib/mbedtls/public_key.c

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index b8eda9638f4..cd0144eac1c 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -21,6 +21,10 @@ hash_mbedtls-$(CONFIG_$(SPL_)SHA1) += sha1.o
 hash_mbedtls-$(CONFIG_$(SPL_)SHA256) += sha256.o
 hash_mbedtls-$(CONFIG_$(SPL_)SHA512) += sha512.o
 
+# x509 libraries
+obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
+x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/aes.o \
diff --git a/lib/mbedtls/public_key.c b/lib/mbedtls/public_key.c
new file mode 100644
index 00000000000..2297b4397ba
--- /dev/null
+++ b/lib/mbedtls/public_key.c
@@ -0,0 +1,105 @@
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
+void public_key_free(struct public_key *key)
+{
+	if (key) {
+		kfree(key->key);
+		kfree(key->params);
+		kfree(key);
+	}
+}
+
+void public_key_signature_free(struct public_key_signature *sig)
+{
+	int i;
+
+	if (sig) {
+		for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
+			kfree(sig->auth_ids[i]);
+		kfree(sig->s);
+		kfree(sig->digest);
+		kfree(sig);
+	}
+}
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
-- 
2.25.1

