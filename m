Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D12C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3456A8852A;
	Tue, 28 May 2024 16:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QKkzN5ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF78B88543; Tue, 28 May 2024 16:17:52 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C39884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-794ab181ff7so55160785a.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905869; x=1717510669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdkuRqczP+Um9XGzlJSI5B1JzrYXX6wTmt/qz3Jwsf4=;
 b=QKkzN5ewKmsnt+CU0AmRsccGmOKsbrWx8V81XqvaME/c5ckQT7g4M/K67S3r36fk5F
 R18v179hQgaoVOnkBU/iXRGNVlrC1eYGZrtnB2mLGuzGyOJPfqNvtJjVqgeOTzhEuhSM
 zi2I8GGDveYUdccampebREqMCkp0kxtwTV3aUxgz1Opk1zw48wf+p/+SWcF8eqUS4/Ih
 kLzNSfj8rCQVFOtVl3yMrXcXpKkKmZtFW6ifo/xtnzpuhFNbPYRvjGOwcGi8EuaUT+tc
 0MaHgqYPWcHcwMdfDvr6l0FSPCKuT/C9cvu3Wq0OahI55WjEqyI/FTViDMKvicz5Q4a2
 0XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905869; x=1717510669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdkuRqczP+Um9XGzlJSI5B1JzrYXX6wTmt/qz3Jwsf4=;
 b=b5dBjHBnKpAiY1UqiHvbzc+eh0xfLnbCDJXmWUExaJny5YZ7N0Fvbogix6FpDzokX7
 7hUlxekIh1VvgA6ZLtxC6ZNQtPlE5eWEet1/gdf+hp1K9LMTzZq/mfoEfiw/RttINNy3
 2nox7y39NZJgWRbkeWyyTSHYgO2qae1glJTtEU/j3EeB4CaJmXuGjlCL/cwBq0OO0u3V
 xrmW4Gy13kfk7idy13dELA76XGMSsqdf6ZZwjDrzZUVJggQ8rorbMYuOL6O8i2avl0AR
 4atCxWWTbycpqfDidI8eNlEDY38+WxekiIiuctJBkQdN3wRxU5rGRuEEI0q2DCEaOHfI
 LpUA==
X-Gm-Message-State: AOJu0YwbjoTUmdACLj6QPf8mXa1UGBT15gNORFjxAH2ZxycjyPitxsgv
 1qFk7+vwgdj9FhFVB/h8YF9G29978niBNH8gYc7NwJEJerJrk7/kXW/xkXi0IgcwGwkWPCVglr+
 Q1CY=
X-Google-Smtp-Source: AGHT+IEEwhEWl09ISivE/QfuA0chQmkLM3z9jNT3BSA75A/qeKafMAz0Z2kmhO8hHpouzOdsEKjLAQ==
X-Received: by 2002:a05:620a:e87:b0:793:fdb:ca4 with SMTP id
 af79cd13be357-794ab099db0mr1143999985a.35.1716905868758; 
 Tue, 28 May 2024 07:17:48 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:17:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 21/25] mbedtls: add RSA helper layer on MbedTLS
Date: Tue, 28 May 2024 07:09:32 -0700
Message-Id: <20240528140955.1960172-22-raymond.mao@linaro.org>
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

Add RSA helper layer on top on MbedTLS PK and RSA library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.

 lib/mbedtls/Makefile     |  1 +
 lib/mbedtls/rsa_helper.c | 99 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 lib/mbedtls/rsa_helper.c

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index f0b8a1c4003..dab110891af 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -27,6 +27,7 @@ x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
 x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_cert_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode_parser.o
+x509_mbedtls-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += rsa_helper.o
 
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
diff --git a/lib/mbedtls/rsa_helper.c b/lib/mbedtls/rsa_helper.c
new file mode 100644
index 00000000000..956e550c856
--- /dev/null
+++ b/lib/mbedtls/rsa_helper.c
@@ -0,0 +1,99 @@
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
+#include <external/mbedtls/library/common.h>
+#include <external/mbedtls/include/mbedtls/pk.h>
+#include <external/mbedtls/include/mbedtls/rsa.h>
+#include <external/mbedtls/include/mbedtls/asn1.h>
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
+		pr_err("Failed to parse public key, ret:-0x%04x\n",
+		       (unsigned int)-ret);
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
+		pr_err("Failed to get RSA key context, ret:-0x%04x\n",
+		       (unsigned int)-ret);
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
+		pr_err("Failed to parse modulus (n), ret:-0x%04x\n",
+		       (unsigned int)-ret);
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
+	pr_err("Failed to parse public exponent (e), ret:-0x%04x\n",
+	       (unsigned int)-ret);
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

