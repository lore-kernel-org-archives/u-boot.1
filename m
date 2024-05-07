Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA7C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD410887E7;
	Tue,  7 May 2024 20:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wroAMwHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07E4887E8; Tue,  7 May 2024 20:00:02 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847C9887E4
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b50b8239fso140376d6.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104799; x=1715709599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1G+80RleBUOmVWgeSMYMPBgeYu2q4fQlK4pieUQVio=;
 b=wroAMwHSHfQgBbBXfLnzwNsB75+0yMmXlBkDo3BSJrqmWitbtKU3DBAmk2H7XO/Dtv
 PiwWGtTTfDc2GRekxFYKeibbi8Ean7kdBofQYQmQEXavjZlCjGrIxhpXrAcMYKryrT8c
 2PrWMwx69aSjXf1UAArQpoOihqmipjHOFUESyqkiGCQMFEVTv/cAy2YMOR4D7IBgF20v
 iCpdADFT5VkyA3QlBIgQya47h+1HE5caltiotj98YObTKaktXpaojRykbty1cIXwC9EB
 hSTkdFLhflLgasJx5r3blPpKIVL1yR973edHuRX8ce40UI6y47UGz9tB62AVW8IY3noZ
 5oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104799; x=1715709599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1G+80RleBUOmVWgeSMYMPBgeYu2q4fQlK4pieUQVio=;
 b=wxUkuDzj+QZuNQyoNI1NcaHs6HhbfG1cFrIhhitCKHRmHEw+p7TkuMJ3mwTvnp6NPB
 4fNk3KJ5R57Vw0v0Px+dwRiI+MHl3T0XOzloeWcYEGDZ5W3Kya9IFx+aQ/Go0ZZm8NRB
 GSJPvqyj1K+itzI2ZI1AglkBOiOs1O/F9aFr/Z6B3ArVOAWpylDkfF4N8wOPF7tIoyxq
 su0k+6QP8k3OHZLFm7yWJ39zj0qpRvL7YDpyOORQoRBA/qfSyxdNGKupxV7imJKB7f8t
 YajrQUMDoDKDRCLKcjmz6Ta3MMqXWox8RIrQRIpSvS48QfM86XdDIFDZXnzTAvTtfR+m
 em/g==
X-Gm-Message-State: AOJu0YwhpxaOXnkbJ6YAnd+LhJJC3o44CjEOfZcKSryVo1R+uApvEwja
 AqFNeui6sMJtjM/+GOHUQkLKikfMi2vhfTfFTueVoKVbR/qgxsO83d4WVLJsy8e+4JcqO6DQmdO
 S
X-Google-Smtp-Source: AGHT+IF47VWrX51QO+rgTeI3QOZnil6mh8dGxTPr/X/iXItp3Dtumv7DqdE6x1b62hZaPs/0v1EBxA==
X-Received: by 2002:a0c:fbac:0:b0:6a1:dfe:bdcb with SMTP id
 6a1803df08f44-6a14601546emr55784896d6.13.1715104799166; 
 Tue, 07 May 2024 10:59:59 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:59:58 -0700 (PDT)
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
 Andrew Davis <afd@ti.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 19/28] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Tue,  7 May 2024 10:51:01 -0700
Message-Id: <20240507175132.1456512-20-raymond.mao@linaro.org>
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

Adapt x509_cert_parser and x509_public_key for building with MbedTLS

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.

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

