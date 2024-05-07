Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F94C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5660F887F1;
	Tue,  7 May 2024 20:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E+K3oOof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A166B887F3; Tue,  7 May 2024 20:02:11 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ADDF8839D
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a077a861e7so24855366d6.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104928; x=1715709728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sUdsP5rBx1A7+KoO39A0HWAGZRUbc+CjtkAF9JBf/Q=;
 b=E+K3oOof7zRzxoQdlevYpCy9P2bCiKjAgWDjYhbsaWnoQYdizsXI38gogWDuKm2fst
 UQWEkPEwiHk7BYlTaFd0sVjS9wf6zmqdPcaPUPaPLwXKLWYgekytkA3SlqIn3aZZ13BZ
 LS7hbws+4cL4A5DYjng+V/UhyDP8MxngOrowJhdJwhCZIV0fsdugMDm9GQx23k8HlBLL
 JNkMw6zSdjulqNKCSV1rkBJTEeRoXMQ7Kp1ThUDCownQ60O+CkfdaW0/WRI11R2708BN
 YpukiGtjcKFwJwXEssE+yyuoTr3uQnYvxkkZ/FYRY8atuP6EAWMEbLRit2ugYQe1vxDf
 odWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104928; x=1715709728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8sUdsP5rBx1A7+KoO39A0HWAGZRUbc+CjtkAF9JBf/Q=;
 b=esD2vgArBY0NRPhawqWd1MoD4ynqrP6Q9sziVFb19FQF+oH2Zp1O10xnZ2lR33ndLE
 IFnE/X+bbZetfKC4/k66Ers0EtuN5ylWVVmOxxQpHs0VcowuBrAKo90yR4QtcL864pTx
 5u2uM2teXHHawtuipwSHRiHBHtEQwg8+/HvCKIvWqt6qCan4sbzKQX47sbHidjK7wHG3
 j5Y48wJg/CnNI2lcifFW2bVGFv4LjXkSG5uonritQF3kefwa81OadQLq7hPbh2Euw6kN
 9afO8iTAPnEWesxJLnmOI/PCgv5t7w0+2fNWQRQRpl/HDN0AYcPQIws+/HjQaN18Z3i7
 qBjw==
X-Gm-Message-State: AOJu0YyYkTA21vHnmHuQxfk3sYu+Iwp878c5rCOjCJWJg13tfBaApNcf
 qolt6dC8suv6xUTtB1nZH9kmLUrSgF+wTGUcOMlPRMUuFDTZUnD9hfxd5GJKEVR580D9WEy0p4l
 t
X-Google-Smtp-Source: AGHT+IHadfv0gbuW3dOvH2GTSpHZREp999Zz51TkjcYsID8IN1PiPIz0a9lW7qtX8gK6tPBTbEV9HA==
X-Received: by 2002:a05:6214:2483:b0:6a0:6dce:fe3 with SMTP id
 6a1803df08f44-6a1514986a4mr7574346d6.34.1715104927690; 
 Tue, 07 May 2024 11:02:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:02:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 24/28] mbedtls: add RSA helper layer on MbedTLS
Date: Tue,  7 May 2024 10:51:06 -0700
Message-Id: <20240507175132.1456512-25-raymond.mao@linaro.org>
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

Add RSA helper layer on top on MbedTLS PK and RSA library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.

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

