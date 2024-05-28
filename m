Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A0C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146FF88551;
	Tue, 28 May 2024 16:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLUjDl66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5BBA884D1; Tue, 28 May 2024 16:17:10 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7363884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-792bdf626beso76936185a.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905827; x=1717510627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohS1pAG+BccuG/X5ENF/lT3slYVnRvmMLV1c1oEjtjM=;
 b=eLUjDl66ygDcajXL53OjsHcrSyx5Pz/4oim4kHEzJiVh7lMDOKROJmqTYpy0/bMi20
 VHx1yiWwDcBivK8TgJ74e1DgCooBMzv2op0lYZ8DONQu0OyLIoKH/JhqSDDfEe+GT8zh
 A/c+pENK127GAVb4JLuqUMu1eiARczB8efq+NhK3DCuyEd1UOLFvh7dfoJ+BnAUrAHc6
 gH8633lFERa/vp4a0TF+PPO66OHRSQELONb1ibFbUhlxKkRkTYJMloDCduEFMNBLSaHz
 tyJQFl27NAmUutOtOtCiOTNXnOgb+LHr7d7oEtG/RtdRyjh81Biqa8U5Rp9SQxanVwnY
 bxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905827; x=1717510627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohS1pAG+BccuG/X5ENF/lT3slYVnRvmMLV1c1oEjtjM=;
 b=qTSKExInHID/qwGDovqJJdAzcFyJUux1qsI13d1zJ8HtOioCyfh4eW5UbEwmlN2J2Z
 TDgZ4CEctF+XKyjSVyRENTL2tT8oAxAwIa7p8mF7cN+ad6g4gxsPkvgcGC5BRUlias2X
 qeDjS28Gg948QfFbJI4Ni33sYV+f+SBPOUuyZSXj2c1jUrxMjoVFGAaaVSOn5kvYFwxp
 YpcWU9NzN8VGxy8UebaYKPZcbuwPgtSbCD02qWMwZ+rAKBU9WAGGKwoDiwhmi0i9ZHNF
 erZly2ZfHTzEXLAyrC6T9fU8vkKWp4yZrrfBmZgCqOTCOYuDdJm8nY6gJkBp9CzEZlGH
 HK+w==
X-Gm-Message-State: AOJu0Yx64kwkCgQpXipZZHWIWfzHZLLWLl/Ntt+27zoDB7Fe9ZD7sVI2
 mNVoIf4EIXx09JciFL8Ida4L80Pltu4G5OOYfv8WFnNUw+O8zHdWvERDTt+VkCY4TboaYlITVU6
 nafo=
X-Google-Smtp-Source: AGHT+IH6F3kNMwk3GV5dMlRHYcM+LsfAVvxNwti2VKHDS7FEvXvi4RvyGh710QUFmhrvAkVCIzyNOg==
X-Received: by 2002:a05:620a:25cb:b0:792:8df3:8be6 with SMTP id
 af79cd13be357-794a0a2d655mr2451800885a.33.1716905825690; 
 Tue, 28 May 2024 07:17:05 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:17:05 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 19/25] mbedtls: add MSCode parser porting layer
Date: Tue, 28 May 2024 07:09:30 -0700
Message-Id: <20240528140955.1960172-20-raymond.mao@linaro.org>
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

Add porting layer for MSCode on top of MbedTLS ASN1 library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- None.

 lib/mbedtls/Makefile        |   1 +
 lib/mbedtls/mscode_parser.c | 111 ++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 lib/mbedtls/mscode_parser.c

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 005b8a25320..f0b8a1c4003 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_MBEDTLS_LIB_X509) += x509_mbedtls.o
 x509_mbedtls-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
 x509_mbedtls-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_cert_parser.o
 x509_mbedtls-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_parser.o
+x509_mbedtls-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode_parser.o
 
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
diff --git a/lib/mbedtls/mscode_parser.c b/lib/mbedtls/mscode_parser.c
new file mode 100644
index 00000000000..34715f3a137
--- /dev/null
+++ b/lib/mbedtls/mscode_parser.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MSCode parser using MbedTLS ASN1 library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <crypto/pkcs7.h>
+#include <crypto/mscode.h>
+
+/*
+ * Parse a Microsoft Individual Code Signing blob
+ *
+ * U.P.SEQUENCE {
+ *    U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.15 (SPC_PE_IMAGE_DATA_OBJID)
+ *    U.P.SEQUENCE {
+ *       U.P.BITSTRING NaN : 0 unused bit(s);
+ *       [C.P.0] {
+ *          [C.P.2] {
+ *             [C.P.0] <arbitrary string>
+ *          }
+ *       }
+ *    }
+ * }
+ * U.P.SEQUENCE {
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <digest algorithm OID>
+ *       U.P.NULL
+ *    }
+ *    U.P.OCTETSTRING <PE image digest>
+ * }
+ *
+ */
+int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
+		 size_t asn1hdrlen)
+{
+	struct pefile_context *ctx = _ctx;
+	unsigned char *p = (unsigned char *)content_data;
+	unsigned char *end = (unsigned char *)content_data + data_len;
+	size_t len = 0;
+	int ret;
+	unsigned char *inner_p;
+	size_t seq_len = 0;
+
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	/* Sanity check on the PE Image Data OID (1.3.6.1.4.1.311.2.1.15) */
+	if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_PEIMAGEDATA, inner_p, len))
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	ret = mbedtls_asn1_get_tag(&p, p + seq_len, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+
+	/*
+	 * Check if the inner sequence contains a supported hash
+	 * algorithm OID
+	 */
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_MD5, inner_p, len))
+		ctx->digest_algo = "md5";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA1, inner_p, len))
+		ctx->digest_algo = "sha1";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA224, inner_p, len))
+		ctx->digest_algo = "sha224";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA256, inner_p, len))
+		ctx->digest_algo = "sha256";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA384, inner_p, len))
+		ctx->digest_algo = "sha384";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA512, inner_p, len))
+		ctx->digest_algo = "sha512";
+
+	if (!ctx->digest_algo)
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_OCTET_STRING);
+	if (ret)
+		return ret;
+
+	ctx->digest = p;
+	ctx->digest_len = len;
+
+	return 0;
+}
-- 
2.25.1

