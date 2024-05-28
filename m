Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED313C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9AA884D1;
	Tue, 28 May 2024 16:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fuWiWZ6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB7788540; Tue, 28 May 2024 16:15:00 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638CB88485
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-794db1ee9f1so9121685a.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905697; x=1717510497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlZHj2LaMV4wNeQ7EE0kPl41+f3nkiFlyYFPBdvqsnM=;
 b=fuWiWZ6WN724NZoJDCpNWG6jKiDyXqArdQVumvkZEm0PcmjL33OeDMXY262cb1+3k+
 J0Eeg8D0WhXXiwMWo2kBP6NvDZEMScDZBFS4a9Unz+SEw0cdYsH3pjDyBVvIQ8cdaEpH
 lB+DDFsWM6SUZnaeoIdeM8b1G0VX3PLfZ+NNEAbT8LuDoAcubNFPrB2uumwoGEV/60UC
 TuCwdZQ8FnnjLxajkGJOhNMTogNWM0jKP8tgFDVbRZq9xkoRW8aGACIdWWbU1eCh1ur+
 bleIH79PzbpfhnF7kxkyQow7FhoaoHUJKlaX3Om5qAcx8Zt7JxMEgr1KRcQH1Bfx2o8y
 MEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905697; x=1717510497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlZHj2LaMV4wNeQ7EE0kPl41+f3nkiFlyYFPBdvqsnM=;
 b=UsvaFoiFbnIyFYOdXNJ0xtlIVKLdXiNUZWP15ewE4dMto4yOFC+OHZKg1jcxo0KCLi
 JGX1uRf7RyI0D++ibEKiTuZN/tZp7IQ+Ff+4bqTeM18uqFODBx1q6WrQ2lwFB83wJr99
 QgMWpM2oR1p9ykkZcHkj3TVb9MOL08i+7MJFaDY5v0tegE0tkhD4V9MulMt+MycOBsD7
 Dwa5PtvhHvYFg3U2BuG06R7imChjxt/b4b1nbvskbKxaDO3UrhfZs4UkaNe/6FShkIsn
 5skc1dsxPAGnP/bi8xW8ffaLyWdwc6T/7h6YgWL0tYGXcJJ8byzB9OFZyaaCU7WU1Nvo
 lhzw==
X-Gm-Message-State: AOJu0Yyd7Bzl/clVfOh0uV3iKXFqh59GMrnhDIkr7sX5mlYgHCTAruD7
 bqehIiXYdceqUb57o9gnPl9z/nA9w7gouDFRg6e9Q7jy2uBUvNuxhNq7Njr60J0WO4D+eKpXLQV
 /1i0=
X-Google-Smtp-Source: AGHT+IH7RIdXJ9uKCmzwLsI0/3sgilWoR9GbUCLmb7bofm6aJWzm9I6yXkhCT+2a/o61speE0RacJw==
X-Received: by 2002:a05:620a:e85:b0:792:9148:95a with SMTP id
 af79cd13be357-794ab122388mr1132384085a.72.1716905696696; 
 Tue, 28 May 2024 07:14:56 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:14:56 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 13/25] mbedtls: add public key porting layer
Date: Tue, 28 May 2024 07:09:24 -0700
Message-Id: <20240528140955.1960172-14-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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
Changes in v3
- None.

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

