Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A4C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A12988CA7;
	Sat, 17 Aug 2024 00:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uuXzBPJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D5988C14; Fri, 16 Aug 2024 23:52:15 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC8688AA9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-44fdcd7a622so14317541cf.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845131; x=1724449931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSFFwdWChXBI2gnwsg6z3GO9LetQJ2fTQW6jC50/rkk=;
 b=uuXzBPJkPdD2G5kPfu2Xu1FBukiY8Bc4aUZClEd8BQPeayJH4GXuETko6nuzJ9jxQ7
 y4VBNOWdxQk50kbc7Q9NYXYUQeKPdZd89AVs2Tvvz5GhDZ2z0kY5OnO3fmRFX0EyRo+5
 s2PpZQOBuaDTSY31UNxWeKynUL6chOBACIKXlKFbMv3ukP4lbQakPXyT0s8AJkGwNJBH
 mz1F0l36bvpE6rtlcQsLmslBUBVGAbNsTJMhjxDRoSm988+kN9GcXW9UFI/IaVIxzT9d
 d+Q5m/xJzB1eEWUChIY+XUXs4Vww75K/idXexwNkQT4qBpHkMrxF/C/+5j/kA0ELPAlW
 F/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845131; x=1724449931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSFFwdWChXBI2gnwsg6z3GO9LetQJ2fTQW6jC50/rkk=;
 b=UzeagSInVm+xHhJQ5MgSYlJBMeTOJuSdK9Rcccw+jufuGhgR02DkP8pZH3yIGSSLJw
 EzlkuH1vBFblpniGerhyRlxMa7KsJBItsj4Ex2+UutZ24Lpfy9IM+Vp2rHnnsUqv4Bdc
 gSv+R2mU7/C9Vg3HQX7cmVibFkJ9MoGrPQhhrnVwV0O1Y7WVe79UnzV4rYfG88LPh1ya
 8s2cyT9ZanINs0CRACE2yuHDBu9wFtuelmuqe/QC1WN3d150GpzkOeE63oHvvh18b/yb
 YxQeHzbYLwardDQsLyFsQJAiOeEDMRx6Gj88NU71NLhXeMmh88pz8tn638yYZGcpEEae
 NskA==
X-Gm-Message-State: AOJu0YynOAwyHxpMF3PPmuHQOxcXRPj6jO9lFXnrYOlbs1d+ZqNpKjal
 UpWUXhlSz554om6bnYLSI9jSrtDxTkV9tOLvZnVTdmqSyxaJjETQjn7Kbxfz2A6cizSP20G3OO1
 WSm4=
X-Google-Smtp-Source: AGHT+IGcAvf8icYUK91iCVzgOf4kvhBnbt/IB3gAe8JVMKnwa087GFk8RL4OiId72ap2ekI+eNffNA==
X-Received: by 2002:a05:6214:2b96:b0:6bb:841c:ec5e with SMTP id
 6a1803df08f44-6bf7cd996d2mr39280266d6.13.1723845131457; 
 Fri, 16 Aug 2024 14:52:11 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:52:11 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 19/28] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Fri, 16 Aug 2024 14:44:08 -0700
Message-Id: <20240816214436.1877263-20-raymond.mao@linaro.org>
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

 include/crypto/x509_parser.h | 55 ++++++++++++++++++++++++++++++++++++
 lib/crypto/Kconfig           |  2 +-
 lib/crypto/Makefile          |  4 +--
 lib/crypto/x509_public_key.c |  2 ++
 4 files changed, 60 insertions(+), 3 deletions(-)

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
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 6e0656ad1c5..6106190677e 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ASYMMETRIC_KEY_TYPE
 	bool "Asymmetric (public-key cryptographic) key Support"
-	depends on FIT_SIGNATURE
+	depends on LEGACY_CRYPTO_CERT || MBEDTLS_LIB_X509
 	help
 	  This option provides support for a key type that holds the data for
 	  the asymmetric keys used for public key cryptographic operations such
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

