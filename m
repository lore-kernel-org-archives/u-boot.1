Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0CFC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EC788651;
	Tue,  2 Jul 2024 20:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zT0ALUh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F939887E3; Tue,  2 Jul 2024 20:34:31 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1568187D74
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-445033fbc24so37891101cf.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945268; x=1720550068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2jG28HQvrpdaLIv60CC5Z8Kits60c/nbSykyt6+Jmw=;
 b=zT0ALUh/xC7OUr5+//gqzg0lfpKi+QeQZPMQRfaaL79YlsUbZnbTxfe2dJfAVTX5Wt
 8R9ffufp7I5d0X9EVBJJM3JMnZf4o3JvHl4Woa2olskzd2hNCvf6hKCFEsFKFoUZSqQw
 tGeFuI3NhBUrnU98/fnODLi0rknq+7ifp4AeEmVDdWRHa38gtJU7fVDIlqNSO59MZRAs
 3l6WS7ykCE/PcTaRfgeTw8OpjMXczG89jjOJl4AMfkLmqdHw2nRl3+9gULEDDxtS3L6q
 TX+KQDrkT2oVIUyXhaTaG4+TAq6yCEkWqXM+u/yo9eIx4DgePrBOaVip8XeYPk2qgyWZ
 P3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945268; x=1720550068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2jG28HQvrpdaLIv60CC5Z8Kits60c/nbSykyt6+Jmw=;
 b=Wpq/g2mUJYAPtTr4eo3t8jEWRWZ7AWXFb1V2pdVDbrL22e5j4AC7GaImEJzhlLGNqW
 yT7OFozDT3M1pivOkmMOXA63OnZKtHTZdCTh7djW/Eps2yTpopeyvAOdxhSbc48LCEaq
 t4d6Q9dje6cNzME6LUtV21qzq9Knr/GlENl2ZcWXAcydlG7eZEzNOCqk89ff2wj9eCaY
 pjlt8obVa/nAQrO9NdZiIenfQKVVdHB4C73P3Y4M2lc1uSc7kXU7mhZKZXxMyI32G3NX
 jg6vlfSfxjnxEgAaTH3uip6DkcY8i5EgycxhJQ69bfKXy8cnX5GX2ra14a4x3k6N61bF
 LtPg==
X-Gm-Message-State: AOJu0YxuCqD2o2G64FKQXyI8coNSy/NaMVmvvP9rrDSc7f2tsrg3wr5M
 ZtpPWpJ29q5qd7NPGsVk3il9EUy7LdDUEC5vd5+1C3gn8RRy0qcK2dirtZHqTwBZRitTpJn4RsD
 Q
X-Google-Smtp-Source: AGHT+IGNgk4ynfaFGb3ZPqzsQDiNTQB9A9Ba5jxcH/3El/d8+tR9xVdQAR5YqB/sQT44TYUXX6dK6g==
X-Received: by 2002:ac8:5809:0:b0:446:4a6d:44aa with SMTP id
 d75a77b69052e-44662e481aamr102705821cf.52.1719945267730; 
 Tue, 02 Jul 2024 11:34:27 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:34:27 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 27/29] asn1_decoder: add build options for ASN1 decoder
Date: Tue,  2 Jul 2024 11:23:03 -0700
Message-Id: <20240702182325.2904421-28-raymond.mao@linaro.org>
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

When building with MbedTLS, we are using MbedTLS to decode ASN1 data
for x509, pkcs7 and mscode.
Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
  MbedTLS implementations respectively.
- Update the commit subject.

 lib/Makefile         |  2 +-
 lib/mbedtls/Kconfig  | 28 ++++++++++++++++++++++++++++
 lib/mbedtls/Makefile |  2 +-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index f76af77a969..c3b44c3c9ae 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -80,7 +80,7 @@ obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
-obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+obj-$(CONFIG_$(SPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 87c500d6ca9..4dd2fe07a1f 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -122,12 +122,14 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	select ASN1_DECODER_LEGACY if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
+	select SPL_ASN1_DECODER_LEGACY if ASN1_DECODER && SPL
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER && SPL
@@ -136,6 +138,12 @@ config LEGACY_CRYPTO_CERT
 
 if LEGACY_CRYPTO_CERT
 
+config ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder.
+
 config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
 	bool "Asymmetric public key crypto with legacy certificate library"
 	depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -177,6 +185,13 @@ config MSCODE_PARSER_LEGACY
 
 if SPL
 
+config SPL_ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library in SPL"
+	depends on LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder in
+	  SPL.
+
 config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY
 	bool "Asymmetric public key crypto with legacy certificate library in SPL"
 	depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -303,12 +318,14 @@ endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
+	select ASN1_DECODER_MBEDTLS if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
+	select SPL_ASN1_DECODER_MBEDTLS if ASN1_DECODER && SPL
 	select SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE && SPL
 	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER && SPL
@@ -317,6 +334,11 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config ASN1_DECODER_MBEDTLS
+	bool "ASN1 decoder with MbedTLS certificate library"
+	help
+	  This option chooses MbedTLS certificate library for ASN1 decoder.
+
 config ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
 	bool "Asymmetric public key crypto with MbedTLS certificate library"
 	help
@@ -356,6 +378,12 @@ config MSCODE_PARSER_MBEDTLS
 
 if SPL
 
+config SPL_ASN1_DECODER_MBEDTLS
+	bool "ASN1 decoder with MbedTLS certificate library in SPL"
+	help
+	  This option chooses MbedTLS certificate library for ASN1 decoder in
+	  SPL.
+
 config SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE_MBEDTLS
 	bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
 	help
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 9c6991f8783..9b09fbcea28 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -46,7 +46,7 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y += $(MBEDTLS_LIB_DIR)/x509.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
-- 
2.25.1

