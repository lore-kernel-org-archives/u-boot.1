Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49537C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE7688543;
	Tue, 28 May 2024 16:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lkKLgNni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016228854E; Tue, 28 May 2024 16:16:05 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF7A884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-794ab10d07aso36296685a.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905761; x=1717510561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsIOAjm1nmNEpBx2aDm3CiiCbOI7adp+sZZNKBECaEo=;
 b=lkKLgNniAqzwK5NBq7JIN/rOk8FgSa4hzSsVExMyLVpbSRshL1Uwr+iVG5XQLFvvYf
 PJyQIF+sLiEvjp7edBFmVhmbFHlFWgW56INc9xN2n9/ZmD7UUbDFUx5mvdZnGJxnBUPI
 oEe1KljjbwuoafJNsPBBDpRkcyUvkGto+P775yOcOeyg8ocgHlbFXYf86stDYYYiI8cB
 Y/M8rMNmBa/Bq2jwlLBDR60lxuMIUmdE+AZZdftj3+jfECMbCMsFVRr6fzY0EsohFvNR
 9ZL2D+J353pI4UyXKWU7sHMccw5T997XuVVHOSW53aETe4yKs09+28x4jCtfLth3MtqQ
 u/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905761; x=1717510561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsIOAjm1nmNEpBx2aDm3CiiCbOI7adp+sZZNKBECaEo=;
 b=hr0BcLQOuLtKHodFf9e6N4E5B9q6jv7/qBp5JfLeSFJVnjYdtyCkKThomr+JORRjFt
 ZBBdfmo3DLjN+oI/n5PItPGGl518WH9RCECYqtY9SUTVYYF1kYnTKk6K8QHLABp6E4c3
 UQORQKPZUUVZkg7/8HeEczozxNDsNdAXssicXQOxNjCJvLEpUgcdVQJcnGiRuz1sVj1F
 1BTjzHf9a4r8twNVd8QeEdTCOl+rwgj840RxKbdpMJnAdhhzKH4iLag8YFfRR9LX9RLQ
 JN+xr85vfJKa0Bmj2hQsmdznFEa/LfJyZ7K3hbuSB0/nod339gqvpO3NS8HNFwG7BbxG
 TJWA==
X-Gm-Message-State: AOJu0YydRZodg9u32EdtHf6gRlG5c8yxXzoUTBvSGyd/QmWqazEyr7S+
 ZBqiGPPgXLtLlATIkX4o6wpaGYp6aMoUsCIS3CkF62nK5+pVrCBG8S7TDjwA2gerJsCn9fWqu+A
 J7Mw=
X-Google-Smtp-Source: AGHT+IGZ0p+pthVE7BkQDKikPp6gm481eYbvEYVduflI27Z+dWyW9VPyxKbN4xyOCejN06mcsMzGHw==
X-Received: by 2002:a05:620a:3916:b0:794:a0ec:6a0a with SMTP id
 af79cd13be357-794ab060b47mr1473128685a.8.1716905761406; 
 Tue, 28 May 2024 07:16:01 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:16:01 -0700 (PDT)
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
Subject: [PATCH v3 16/25] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Tue, 28 May 2024 07:09:27 -0700
Message-Id: <20240528140955.1960172-17-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for x509 cert parser,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.

 include/crypto/x509_parser.h | 36 ++++++++++++++++++++++++++++++++++++
 lib/crypto/Makefile          |  2 ++
 lib/crypto/x509_public_key.c |  4 ++++
 3 files changed, 42 insertions(+)

diff --git a/include/crypto/x509_parser.h b/include/crypto/x509_parser.h
index 4cbdc1d6612..32ca9d5db79 100644
--- a/include/crypto/x509_parser.h
+++ b/include/crypto/x509_parser.h
@@ -11,8 +11,36 @@
 #include <linux/time.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <image.h>
+#include <external/mbedtls/include/mbedtls/error.h>
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#endif
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+/* Backup of part of the parsing context */
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
+ * Fields we don't need to populate from MbedTLS:
+ * 'raw_sig' and 'raw_sig_size' are buffer for x509_parse_context,
+ * not needed for MbedTLS.
+ * 'signer' and 'seen' are used internally by pkcs7_verify.
+ * 'verified' is not inuse.
+ */
 struct x509_certificate {
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+	struct x509_cert_mbedtls_ctx *mbedtls_ctx;
+#endif
 	struct x509_certificate *next;
 	struct x509_certificate *signer;	/* Certificate that signed this one */
 	struct public_key *pub;			/* Public key details */
@@ -48,6 +76,12 @@ struct x509_certificate {
  * x509_cert_parser.c
  */
 extern void x509_free_certificate(struct x509_certificate *cert);
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+int x509_populate_pubkey(mbedtls_x509_crt *cert, struct public_key **pub_key);
+int x509_populate_cert(mbedtls_x509_crt *mbedtls_cert,
+		       struct x509_certificate **pcert);
+time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time);
+#endif
 extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
@@ -56,6 +90,8 @@ extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 /*
  * x509_public_key.c
  */
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 extern int x509_get_sig_params(struct x509_certificate *cert);
+#endif
 extern int x509_check_for_self_signed(struct x509_certificate *cert);
 #endif /* _X509_PARSER_H */
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 8f7d9811f03..c89cef5685c 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -29,6 +29,7 @@ ifdef CONFIG_SPL_BUILD
 CFLAGS_rsa_helper.o += -I$(obj)
 endif
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # X.509 Certificate handling
 #
@@ -45,6 +46,7 @@ $(obj)/x509_cert_parser.o: \
 
 $(obj)/x509.asn1.o: $(obj)/x509.asn1.c $(obj)/x509.asn1.h
 $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
+endif
 
 #
 # PKCS#7 message handling
diff --git a/lib/crypto/x509_public_key.c b/lib/crypto/x509_public_key.c
index a10145a7cdc..962611f3fee 100644
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
@@ -139,6 +141,8 @@ error:
 	return ret;
 }
 
+#endif /* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
 /*
  * Check for self-signedness in an X.509 cert and if found, check the signature
  * immediately if we can.
-- 
2.25.1

