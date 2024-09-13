Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF1CFC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396B188E60;
	Sat, 14 Sep 2024 03:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t8sXgaJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E27C88706; Fri, 13 Sep 2024 18:15:56 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8165887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c35a23b378so14396196d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244152; x=1726848952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9tTHh1Gj8tQE2LLyqJE+RGCCW3ysQNc++oGKBANGRk=;
 b=t8sXgaJGqlBceVdptMUsjgBOUcpzJigV1usqaEj6MQzMBFP2F4E4P6gUV4VIrT8Epj
 XglCE8BwaoR5E9pqB0pwCLTZ6/LkB97UilH/yiSoosvdWyrLXEq8vNNpy3yawjpYBsVQ
 pyPrRAyMCreRhPITrkwXyVRgZiORGcCckT6nM0A1FpEsf5bF+Ub1w3+NB1XuMrVMaRw4
 uTIN50nN/FfqDp5ud5UbB2GFQthZyUBB+e+BmB0jVnPTggPvT8sxUGGvihpSSz69b3Jn
 Ej5CCd4crxsAy4EQ7P/euLLAp2zreh/y7RJqeaKu6mgzJfdCTimaitcm7TbXfHvSVbCj
 +w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244152; x=1726848952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9tTHh1Gj8tQE2LLyqJE+RGCCW3ysQNc++oGKBANGRk=;
 b=vgg0aOTTHkcgMjkZCp/jkFom9sLomwXfU6+GkTtid21xFU/HHdBNRdJaxHzbHZzTbZ
 69rWFYItz+fWCwspaFhlZK9oqn66m8yyxjs3kqGiOmAEgG1wlHQrwdDi32s9HF7kUM5J
 wrmf0z0aiHLE8Wm7N+LzkTCOLlxE6Wexd9K8yN9UC0PjsImm49mE37eXjbeQIeddQ+GN
 gATfQv/cT5kElkbPTaHrsuos2Ad9cv0d4vrQyJOP6w87QE6BDkfJBdkGZdGKcokfpTUx
 Phc3khOmo6DL24S8ev0MQOMrxRmEIoCP46a3BMu/xEtXnv2cuHA5XaPl/8E4C8u/oCdc
 a55w==
X-Gm-Message-State: AOJu0YxJvEmnGQH4apCZIRnev2buDNkoAfMXuSxT4z6imvnqEJiJGcVD
 uioZcex4QErbxJnK9/de7QIbc+comKpOmXc9XNZENhZz/8Zd+hLLRqoPjTgUq2/wHS+VzAo5yEg
 b
X-Google-Smtp-Source: AGHT+IEMeIoM+ytzsSwejTpfPEETwup/3+0S9uYU0XuZysYvAfKFYRAhrhQXPD8CoKP7o/D0iUxw+A==
X-Received: by 2002:a05:6214:3a8b:b0:6c5:1151:8cbe with SMTP id
 6a1803df08f44-6c57357bf88mr88753846d6.38.1726244152442; 
 Fri, 13 Sep 2024 09:15:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:15:52 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 25/27] asn1_decoder: add build options for ASN1 decoder
Date: Fri, 13 Sep 2024 09:03:42 -0700
Message-Id: <20240913160408.2199558-26-raymond.mao@linaro.org>
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

When building with MbedTLS, we are using MbedTLS to decode ASN1 data
for x509, pkcs7 and mscode.
Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Initial patch.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for ASN1 decoder legacy and
  MbedTLS implementations respectively.
- Update the commit subject.
Changes in v5
- Correct kconfig dependence.
- Refactored MbedTLS makefile.
Changes in v6
- None.
Changes in v7
- None.

 lib/Makefile         |  2 +-
 lib/mbedtls/Kconfig  | 30 ++++++++++++++++++++++++++++++
 lib/mbedtls/Makefile |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 33755778283..561e0d44a16 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -81,7 +81,7 @@ obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
-obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+obj-$(CONFIG_$(SPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 77959f01fdd..6dbf1898d12 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -117,12 +117,14 @@ endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
+	select ASN1_DECODER_LEGACY if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select RSA_PUBLIC_KEY_PARSER_LEGACY if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
+	select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
@@ -131,6 +133,12 @@ config LEGACY_CRYPTO_CERT
 
 if LEGACY_CRYPTO_CERT
 
+config ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder.
+
 config ASYMMETRIC_PUBLIC_KEY_LEGACY
 	bool "Asymmetric public key crypto with legacy certificate library"
 	depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -172,6 +180,13 @@ config MSCODE_PARSER_LEGACY
 
 if SPL
 
+config SPL_ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library in SPL"
+	depends on LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder in
+	  SPL.
+
 config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
 	bool "Asymmetric public key crypto with legacy certificate library in SPL"
 	depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -317,12 +332,14 @@ endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
+	select ASN1_DECODER_MBEDTLS if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select RSA_PUBLIC_KEY_PARSER_MBEDTLS if RSA_PUBLIC_KEY_PARSER
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
+	select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
@@ -331,6 +348,12 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config ASN1_DECODER_MBEDTLS
+	bool "ASN1 decoder with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
+	help
+	  This option chooses MbedTLS certificate library for ASN1 decoder.
+
 config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	bool "Asymmetric public key crypto with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -372,6 +395,13 @@ config MSCODE_PARSER_MBEDTLS
 
 if SPL
 
+config SPL_ASN1_DECODER_MBEDTLS
+	bool "ASN1 decoder with MbedTLS certificate library in SPL"
+	depends on MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
+	help
+	  This option chooses MbedTLS certificate library for ASN1 decoder in
+	  SPL.
+
 config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
 	depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 40031994708..14bc59f6cf3 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -36,7 +36,7 @@ mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
-- 
2.25.1

