Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4E1CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9367F890BE;
	Fri,  4 Oct 2024 06:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hyoW9IVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19DA88CC5; Fri,  4 Oct 2024 00:01:06 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C3288D94
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4582a0b438aso10973861cf.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992863; x=1728597663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4PRLmgfWGtyip0K/VS+OKGmjGKhDIHYu9eP1SXY52o=;
 b=hyoW9IVjEC1H+LeRHGRa0Tv9LgmiLqc1V+vDeN1eLuZfhuPdOEPKYaXjmn/abunFm0
 jL/2BI7IlfRe+vHB97UY299a6/n8Y+wXQlNT0+XPssPRU4zjT9VIRBEzIuwuJHla96UJ
 XScGQ9A4pSrCGpd6ya62fp7fqwV8Co3CL+eDKehog1Oii5CoOM+M5RvX08ZsL+bTx7+T
 2wO0JgNROAOh+qHj6EpajEID+EwoAG37Z7fzvTJ9fPoraCCZOPp6kACV7CUIQXfNtbw3
 XnYJb2XR8J69apqBfqWVDKagEMH7xj3XfMj+jFnR5u0+IkhqDNQCGphX/d8+docb6Tf3
 lPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992863; x=1728597663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4PRLmgfWGtyip0K/VS+OKGmjGKhDIHYu9eP1SXY52o=;
 b=qozLNQvmFso3tGtA+FQUnzC1OMVxJiNv6EEuiascQwqOV6B+tWCHO8fVkzQrRNdnOG
 EvACEyddysMvXxjFNaQ6IYoXWRMw6f0X5dqgTAzvlq35+l8em5lfls6n680NCgWqcWq/
 BvRZmbekI++Dw7be3hfZsX1hDoovfYyWMbT9rh4ko4Fvbk55bmaGgUrxbLd8p64SqwWk
 EC8XjVgEzPgZamBkh1Mo16R7AYkeDTeZkCvi3jp+eyD053mplFYfqX1ZmpWIQPDHT5cL
 TPNfbWO3JY+pl9TriR5a/2WKgjY+v+aTKYlcjDvZi/gqvdkQrlNOYIUu28+XVE8zPhF+
 X6EA==
X-Gm-Message-State: AOJu0YyPqcrsfujq5qVXnDFZJ3SgxKT8fCRL6cRfDQny53olN6Z0CA5H
 mylFL5174vsuwQiAf+yAJ0wy+8IGLbNhQ2mXmbbrFGI9zLmKG+FVwKwtDV06vdboaLUi3zgNERJ
 q
X-Google-Smtp-Source: AGHT+IHrZbXLMB7nQQRPH/E7MjV3LWaVsbLZbK2KbxVYtlenuMHGePqa+CV2M9CIJR1ppQb69HiQGw==
X-Received: by 2002:ac8:7d92:0:b0:458:4aec:2749 with SMTP id
 d75a77b69052e-45d9bafd280mr9872151cf.57.1727992863086; 
 Thu, 03 Oct 2024 15:01:03 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:01:02 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 18/27] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Thu,  3 Oct 2024 14:50:31 -0700
Message-Id: <20241003215112.3103601-19-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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

Previous patch has introduced MbedTLS porting layer for x509 cert parser,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
- Add function comments for the new APIs.
Changes in v5
- Correct kconfig dependence.
- Correct header file include directories.
- Adjust a few inline comments.
Changes in v6
- None.
Changes in v7
- Drop the changes in kconfig.
Changes in v8
- None

 include/crypto/x509_parser.h | 55 ++++++++++++++++++++++++++++++++++++
 lib/crypto/Makefile          |  4 +--
 lib/crypto/x509_public_key.c |  2 ++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/crypto/x509_parser.h b/include/crypto/x509_parser.h
index 4cbdc1d6612..0e22e33f66b 100644
--- a/include/crypto/x509_parser.h
+++ b/include/crypto/x509_parser.h
@@ -11,8 +11,35 @@
 #include <linux/time.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <image.h>
+#include <mbedtls/error.h>
+#include <mbedtls/asn1.h>
+#endif
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+struct x509_cert_mbedtls_ctx {
+	void	*tbs;			/* Signed data */
+	void	*raw_serial;		/* Raw serial number in ASN.1 */
+	void	*raw_issuer;		/* Raw issuer name in ASN.1 */
+	void	*raw_subject;		/* Raw subject name in ASN.1 */
+	void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+};
+#endif
+
+/*
+ * MbedTLS integration Notes:
+ *
+ * Fields we don't need to populate from MbedTLS context:
+ * 'raw_sig' and 'raw_sig_size' are buffer for x509_parse_context,
+ * not needed for MbedTLS.
+ * 'signer' and 'seen' are used internally by pkcs7_verify.
+ * 'verified' is not in use.
+ */
 struct x509_certificate {
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+	struct x509_cert_mbedtls_ctx *mbedtls_ctx;
+#endif
 	struct x509_certificate *next;
 	struct x509_certificate *signer;	/* Certificate that signed this one */
 	struct public_key *pub;			/* Public key details */
@@ -48,6 +75,32 @@ struct x509_certificate {
  * x509_cert_parser.c
  */
 extern void x509_free_certificate(struct x509_certificate *cert);
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+/**
+ * x509_populate_pubkey() - Populate public key from MbedTLS context
+ *
+ * @cert:	Pointer to MbedTLS X509 cert
+ * @pub_key:	Pointer to the populated public key handle
+ * Return: 0 on succcess, error code on failure
+ */
+int x509_populate_pubkey(mbedtls_x509_crt *cert, struct public_key **pub_key);
+/**
+ * x509_populate_cert() - Populate X509 cert from MbedTLS context
+ *
+ * @mbedtls_cert:	Pointer to MbedTLS X509 cert
+ * @pcert:		Pointer to the populated X509 cert handle
+ * Return: 0 on succcess, error code on failure
+ */
+int x509_populate_cert(mbedtls_x509_crt *mbedtls_cert,
+		       struct x509_certificate **pcert);
+/**
+ * x509_get_timestamp() - Translate timestamp from MbedTLS context
+ *
+ * @x509_time:	Pointer to MbedTLS time
+ * Return: Time in time64_t format
+ */
+time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time);
+#endif
 extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
@@ -56,6 +109,8 @@ extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 /*
  * x509_public_key.c
  */
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 extern int x509_get_sig_params(struct x509_certificate *cert);
+#endif
 extern int x509_check_for_self_signed(struct x509_certificate *cert);
 #endif /* _X509_PARSER_H */
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 7e877214aa8..4302f197297 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -32,11 +32,11 @@ endif
 # X.509 Certificate handling
 #
 obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
-x509_key_parser-y := \
+x509_key_parser-y := x509_helper.o
+x509_key_parser-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_LEGACY) += \
 	x509.asn1.o \
 	x509_akid.asn1.o \
 	x509_cert_parser.o \
-	x509_helper.o \
 	x509_public_key.o
 
 $(obj)/x509_cert_parser.o: \
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index 4ba13c1adc3..310edbd21be 100644
--- a/lib/crypto/x509_public_key.c
+++ b/lib/crypto/x509_public_key.c
@@ -30,6 +30,8 @@
 #include "x509_parser.h"
 #endif
 
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+
 /*
  * Set up the signature parameters in an X.509 certificate.  This involves
  * digesting the signed data and extracting the signature.
-- 
2.25.1

