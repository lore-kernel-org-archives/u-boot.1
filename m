Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1900DC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99ACE887C0;
	Tue,  2 Jul 2024 20:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xv0IcMe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E685887CD; Tue,  2 Jul 2024 20:32:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1564887D74
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so4255192a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945115; x=1720549915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PF091OcruIWFIVedk0xEdKWelHWz1rP8nNq0+l81Vc=;
 b=xv0IcMe4VabBk7+AgrNNcbdoPmhEKFsw0MIgRRUVSf9KjnsZ4XANEaC/Hnu3Jm5Wng
 FmZS3HZUtt003gk0WMPQahD+aHBNgD2eHPttgVMs+HM1lzQqj1SEngfH2KID+2SVuc96
 9co8dy3C7MlvoUzZwNYMs9F5d164xmrpxSjqsmLuhe5OHLCokM5iGcjIMDhUBsX2Bj9h
 VIzHmH82kBJduwhKhlinQ/vhxyRb61fEzrcKDKluHsadjBh1aHUbID0TKCcEtRvwQK9g
 Dgp2geXNg04m0y34ld9uHjv7raIotad9jei4rIx4vBb04mDMrUb2K2HL3fJnw+Ef/FJN
 t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945115; x=1720549915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PF091OcruIWFIVedk0xEdKWelHWz1rP8nNq0+l81Vc=;
 b=Iwr+5hWALv1vcgxFEWcRTK05iNZ6QzNDVt5i3Ic+fO3YD7WXpVKgWTpJATvddOXOOC
 qgvEKWa0AAgW/D0jOKzHRgVXwTzSti/nH0ImNxuieNZSGYCNYeGRhFGRiStVNaj6BJlJ
 QQ0EVEPOC/7+UmYYTdtofM7rAEzjaCPauejArUfhc37Lw3SKfGw+7ZvcFuh/C3EMTHOJ
 QbdgBA7t7aZTElLBkBV8R6EJ8g+SmcUuZOpuM0ELGb6V85RYJWhi6+i9uo0htv4+KUBg
 qI7plBaHYsy+LcA6lUXWNekMao1M0TSP2QGqlaEz8sDp5mf9eHT96Y86Z7iEXOzIPAJy
 +T2Q==
X-Gm-Message-State: AOJu0YxTmxxQrexpdEVlCnpnf0mR79JLUgNkHr1NwKqCRuR+ZuVkr0ak
 7PRH7LBoHfJv4JJ9NDoqJCEq4R09AvlWXXH48OxAe71vT9fjVPe6OJQxb/KkPqSDTbdUx/zltzE
 d
X-Google-Smtp-Source: AGHT+IEKSw0ENgs0MhezWbKV/Mz0HPUtED/kBvxnsY+rqHvQ2XoAp/xRDR215WBte/HW3PaM0Fvp5Q==
X-Received: by 2002:a05:6808:1507:b0:3d5:5fdc:ac7c with SMTP id
 5614622812f47-3d6b30f52d9mr12607313b6e.15.1719945115235; 
 Tue, 02 Jul 2024 11:31:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:31:54 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 20/29] lib/crypto: Adapt x509_cert_parser to MbedTLS
Date: Tue,  2 Jul 2024 11:22:56 -0700
Message-Id: <20240702182325.2904421-21-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
- Add function comments for the new APIs.
- Update the dependence of ASYMMETRIC_KEY_TYPE.
- Minor fix of the include directories.

 include/crypto/x509_parser.h | 56 ++++++++++++++++++++++++++++++++++++
 lib/crypto/Kconfig           |  2 +-
 lib/crypto/Makefile          |  4 +--
 lib/crypto/x509_public_key.c |  2 ++
 4 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/crypto/x509_parser.h b/include/crypto/x509_parser.h
index 4cbdc1d6612..3f917da5430 100644
--- a/include/crypto/x509_parser.h
+++ b/include/crypto/x509_parser.h
@@ -11,8 +11,36 @@
 #include <linux/time.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <image.h>
+#include <mbedtls/error.h>
+#include <mbedtls/asn1.h>
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
@@ -48,6 +76,32 @@ struct x509_certificate {
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
@@ -56,6 +110,8 @@ extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
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
index 228ae443a27..7f5f04d582c 100644
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

