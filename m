Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F33FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E9988E1F;
	Sat, 14 Sep 2024 03:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sN89vPxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902AD88706; Fri, 13 Sep 2024 18:12:46 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C95D887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c36ff6e981so16696866d6.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243963; x=1726848763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/o2CC/Hebn+1sWSHdv9pwsbbKaixSO0xtcK8bntVr4=;
 b=sN89vPxH2Wg7yCtJJPzSIx8gEA7cr6d0XdNXwDMhzpeEjJuXoPDqgIu/WkG5sQu+JE
 PDunthxHZUiVKLSY66Bp0A6t7EapPe73F2k+MXOc4FfpdsO3IxAagppfqcEMVDetTN6Y
 FIqKnvL1GW+uYpcAoQaHSnZfRvxaXoBH7pqqmrWNmZqgwcmTbQIDV4PUKYM76RG7T92r
 hdVAAok6Qua9vgYVNJNqjF42Pdenrncr/ZXtNSObHGKe8H0pPO4LN/AlKemXyaa715uH
 aIPZPxi6Dn9qq8YgD/isflfVXbSONv6Wgp97TyG+UwNob6akCkrMT/gMGnl7Q0O3wH0P
 lNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243963; x=1726848763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/o2CC/Hebn+1sWSHdv9pwsbbKaixSO0xtcK8bntVr4=;
 b=PAzUlpzH5C6SRWaU4HcbyxigQ0478TkrExKXj1EszL1HAaNaixnMgo16mW5WPY2jGq
 YicwvoiHD+ok3faYyDrrd4c8up/Mve0y2nVFuO8ArzntbGh/Ms9pyn/T3pPRluYfQCpT
 aI1zwI+26Rf6za8z83hHLMAwvlouUp+lI2QO+rmq8OdiEfaGJZCZYNH+f9wB8YRykjIM
 GhnPo99K9lrkNydPrRuFu5kUVWz0rEjL9T//IwgdFtaidvyzxrXB8Vfh1UAtDSB8G4pK
 iKAvQGSzQeox//lII0a7yjFAR7PlyN1xTWwpJ4c5FipUdM5q8qyqDgTBjWnq2YcO6gRx
 0HVw==
X-Gm-Message-State: AOJu0YykEeS1t0S6K6UurPfEjVMKY7XAVsSdMX0l2vsXFXRP6GkzvbT1
 JG+fhM01IAJoe97s2sb++iN0D0akjQsm6gAX8e1o1078GM913Wbk9KH8kT6TmCZrT6e2crDkMIu
 p
X-Google-Smtp-Source: AGHT+IFEFXXgUI3672L+9j7EjiroD1DMZvMxgOv6rll2bjFodhJNrKxOwL25n9NBwqNlILfKKgy2CA==
X-Received: by 2002:a05:6214:4891:b0:6c5:508d:7f81 with SMTP id
 6a1803df08f44-6c57358fa87mr112978366d6.26.1726243963126; 
 Fri, 13 Sep 2024 09:12:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:12:42 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 18/27] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Fri, 13 Sep 2024 09:03:35 -0700
Message-Id: <20240913160408.2199558-19-raymond.mao@linaro.org>
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

