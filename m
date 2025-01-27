Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87742C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 15:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C40581436;
	Mon, 27 Jan 2025 16:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="liqLK2Mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE7D81436; Mon, 27 Jan 2025 16:17:32 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7D98164E
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 16:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6f95d2eafso522696185a.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737991048; x=1738595848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGmdl6WgO0MTPeZ59EEMkedXeCg8bahMv/M44Kw+w9E=;
 b=liqLK2MzaM265wfVp8rqftqTWP/Y2oE1L68Bm/Z0vv7XIZxp5svOypcWbrtv93Mn9O
 eWiTw/3WHnoPDKwhVsQ61AqQXYMDqvWA7AfWFi+7Q2mbOXpkkT3vPLJYCjrq7T0PZ+nq
 nb/kYUiXIEGtvQ9uVlS8Qz9FcEzxKFXzqbT4PI/3o1wNHo08MYfDjRTIHdVqiYXfurBt
 74FEJqRl1eCsXuRE4RXdUBI52Lpy5V99Epjqh9aTxQGhoGGf2A+UumB01qsAOJQ5WtWs
 Mpdl0EXIzrYU8nKD487NnRrF3qm5o7b0Pp04gYLuWPwYkSxjpBrNEF2VLu90sSSopYvK
 wCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991048; x=1738595848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGmdl6WgO0MTPeZ59EEMkedXeCg8bahMv/M44Kw+w9E=;
 b=Py4jTNJmQq/1xvdRIux5wbLntxTHHwTUIARXz6dGbP8uZ5aeKPgzf/UsbaIvZGHlgV
 KL/bc7I/z/y304P+SrNcteyLZz2Boo5Eg9PKwcWpXh0NyKd8Cu7pwBaD5kkHg6Evr1DF
 qy2nCyGYiJdkob6PGJlGpdRTHLlGlEH+NGKoUPf7x4orjTRQMp20YzsleYDtlphJl3kb
 /7HblWMd1bP9M85p1ofP5Gy0iQaKT2YPu/hct9u4KfYU0pgP0lQV9C4tF4mpXsKjfWkz
 /M8lPvHe6Q8C5vkhp9I283XSjgE7v1b1PRpb6AuRU8/ehtAWrglpFyp92b90F8/LMCm1
 XosA==
X-Gm-Message-State: AOJu0YytDt9sThuXL1uCby9ZwGXIUwOYQa7V7hmcOjDS5NaW+qJcHqq/
 yLpHPX/LexqPxToHlFV6wquNcgEvCSxC2RZC123+9H3DPBVPUR9fThxsYX8QCXITSH7tgAM5Ayd
 jXxQ=
X-Gm-Gg: ASbGncucFTEFJVpf1IhYwIsdO5E//1jTYIVtn/CpxNILjLJjvcGFtL3YH2Kaar5l9Sg
 lo8aicJP4f0Z34KM7nmcIvVBqlq6iLmwga5/pHgRbo6Htyb4/wP5jy7Gn73EhK9/RBxRywaEa0l
 jUSSY9jrWVtIKrdVv3jj5I4H0JyvwpXD4BAOIOPewM+uqxItmnmR3gC3WKBMxkbE6bEwqsVAX68
 0kB/ysgV96ZVIzTjZE4Mr0gV00gxtFfxUOv+DFSS7dED5aIxsWvDpIPw4B7ctpyGqEJi73b4ut3
 5zvKXztDO13VlSyMLY+h3XQzV0uG6Ioq2jpNwFVGmBvjLaLo1K66idKvRnuf0tZTbdvKH6axfrP
 TD74=
X-Google-Smtp-Source: AGHT+IEvJNxsgNviUOCpBtKWyOfI83Rlh+hHo2C6zF0UGQRcmNVeJCg4HLmeSPh0jqYl2wWg11TRjA==
X-Received: by 2002:a05:620a:43a6:b0:7b6:d939:f958 with SMTP id
 af79cd13be357-7be63247d43mr7464454185a.25.1737991048278; 
 Mon, 27 Jan 2025 07:17:28 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af11709sm396693385a.112.2025.01.27.07.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:17:27 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 3/3] mbedtls: refactor mbedtls build for XPL
Date: Mon, 27 Jan 2025 07:16:50 -0800
Message-Id: <20250127151657.648255-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127151657.648255-1-raymond.mao@linaro.org>
References: <20250127151657.648255-1-raymond.mao@linaro.org>
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

Refactor the entire kconfig page for mbedtls, adapt mbedtls makefile
and default config file using 'XPL_', in order to have independent
mbedtls kconfig options in both U-Boot Proper and SPL.
User can choose legacy or mbedtls libraries in SPL independently.

Set mbedtls native crypto libraries as default when MBEDTLS_LIB or
SPL_MBEDTLS_LIB is selected.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 Makefile                         |   2 +-
 lib/mbedtls/Kconfig              | 381 +++++++++++++++++++------------
 lib/mbedtls/Makefile             |  44 ++--
 lib/mbedtls/mbedtls_def_config.h |  37 +--
 4 files changed, 276 insertions(+), 188 deletions(-)

diff --git a/Makefile b/Makefile
index 5c6f467153c..406cd28595a 100644
--- a/Makefile
+++ b/Makefile
@@ -829,7 +829,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
-	$(if $(CONFIG_MBEDTLS_LIB), \
+	$(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
 		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
 		-I$(srctree)/lib/mbedtls \
 		-I$(srctree)/lib/mbedtls/port \
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 17ed2bc71de..821d13a0dd2 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -1,3 +1,5 @@
+# For U-Boot Proper
+
 choice
 	prompt "Select crypto libraries"
 	default LEGACY_CRYPTO
@@ -25,11 +27,6 @@ config LEGACY_CRYPTO_BASIC
 	select SHA256_LEGACY if SHA256
 	select SHA512_LEGACY if SHA512
 	select SHA384_LEGACY if SHA384
-	select SPL_MD5_LEGACY if SPL_MD5
-	select SPL_SHA1_LEGACY if SPL_SHA1
-	select SPL_SHA256_LEGACY if SPL_SHA256
-	select SPL_SHA512_LEGACY if SPL_SHA512
-	select SPL_SHA384_LEGACY if SPL_SHA384
 	help
 	  Enable legacy basic crypto libraries.
 
@@ -72,46 +69,6 @@ config MD5_LEGACY
 	  This option enables support of hashing using MD5 algorithm
 	  with legacy crypto library.
 
-if SPL
-
-config SPL_SHA1_LEGACY
-	bool "Enable SHA1 support in SPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SPL_SHA1
-	help
-	  This option enables support of hashing using SHA1 algorithm
-	  with legacy crypto library.
-
-config SPL_SHA256_LEGACY
-	bool "Enable SHA256 support in SPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SPL_SHA256
-	help
-	  This option enables support of hashing using SHA256 algorithm
-	  with legacy crypto library.
-
-config SPL_SHA512_LEGACY
-	bool "Enable SHA512 support in SPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SPL_SHA512
-	help
-	  This option enables support of hashing using SHA512 algorithm
-	  with legacy crypto library.
-
-config SPL_SHA384_LEGACY
-	bool "Enable SHA384 support in SPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SPL_SHA384
-	select SPL_SHA512_LEGACY
-	help
-	  This option enables support of hashing using SHA384 algorithm
-	  with legacy crypto library.
-
-config SPL_MD5_LEGACY
-	bool "Enable MD5 support in SPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SPL_MD5
-	help
-	  This option enables support of hashing using MD5 algorithm
-	  with legacy crypto library.
-
-endif # SPL
-
 endif # LEGACY_CRYPTO_BASIC
 
 config LEGACY_CRYPTO_CERT
@@ -124,10 +81,6 @@ config LEGACY_CRYPTO_CERT
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
-	select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
-	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
-		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable legacy certificate libraries.
 
@@ -178,35 +131,9 @@ config MSCODE_PARSER_LEGACY
 	  This option chooses legacy certificate library for MS authenticode
 	  parser.
 
-if SPL
-
-config SPL_ASN1_DECODER_LEGACY
-	bool "ASN1 decoder with legacy certificate library in SPL"
-	depends on LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
-	help
-	  This option chooses legacy certificate library for ASN1 decoder in
-	  SPL.
-
-config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
-	bool "Asymmetric public key crypto with legacy certificate library in SPL"
-	depends on LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	help
-	  This option chooses legacy certificate library for asymmetric public
-	  key crypto algorithm in SPL.
-
-config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
-	bool "RSA public key parser with legacy certificate library in SPL"
-	depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
-	select SPL_ASN1_DECODER_LEGACY
-	help
-	  This option chooses legacy certificate library for RSA public key
-	  parser in SPL.
-
-endif # SPL
-
 endif # LEGACY_CRYPTO_CERT
 
-endif # LEGACY_CRYPTO
+endif # LEGACY_CRYPTO || MBEDTLS_LIB_CRYPTO_ALT
 
 if MBEDTLS_LIB
 
@@ -221,19 +148,15 @@ config MBEDTLS_LIB_CRYPTO_ALT
 	  Mutually incompatible with MBEDTLS_LIB_CRYPTO.
 
 config MBEDTLS_LIB_CRYPTO
-	bool "MbedTLS crypto libraries"
+	bool "Use MbedTLS native crypto libraries"
+	default y if MBEDTLS_LIB
 	select MD5_MBEDTLS if MD5
 	select SHA1_MBEDTLS if SHA1
 	select SHA256_MBEDTLS if SHA256
 	select SHA512_MBEDTLS if SHA512
 	select SHA384_MBEDTLS if SHA384
-	select SPL_MD5_MBEDTLS if SPL_MD5
-	select SPL_SHA1_MBEDTLS if SPL_SHA1
-	select SPL_SHA256_MBEDTLS if SPL_SHA256
-	select SPL_SHA512_MBEDTLS if SPL_SHA512
-	select SPL_SHA384_MBEDTLS if SPL_SHA384
 	help
-	  Enable MbedTLS crypto libraries.
+	  Enable MbedTLS native crypto libraries.
 	  Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
 
 if MBEDTLS_LIB_CRYPTO
@@ -306,53 +229,6 @@ config HKDF_MBEDTLS
 	  This option enables support of key derivation using HKDF algorithm
 	  with MbedTLS crypto library.
 
-if SPL
-
-config SPL_SHA1_MBEDTLS
-	bool "Enable SHA1 support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA1
-	help
-	  This option enables support of hashing using SHA1 algorithm
-	  with MbedTLS crypto library.
-
-config SPL_SHA256_MBEDTLS
-	bool "Enable SHA256 support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA256
-	help
-	  This option enables support of hashing using SHA256 algorithm
-	  with MbedTLS crypto library.
-
-config SPL_SHA512_MBEDTLS
-	bool "Enable SHA512 support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA512
-	help
-	  This option enables support of hashing using SHA512 algorithm
-	  with MbedTLS crypto library.
-
-config SPL_SHA384_MBEDTLS
-	bool "Enable SHA384 support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO && SPL_SHA384
-	select SPL_SHA512
-	help
-	  This option enables support of hashing using SHA384 algorithm
-	  with MbedTLS crypto library.
-
-config SPL_MD5_MBEDTLS
-	bool "Enable MD5 support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO && SPL_MD5
-	help
-	  This option enables support of hashing using MD5 algorithm
-	  with MbedTLS crypto library.
-
-config SPL_HKDF_MBEDTLS
-	bool "Enable HKDF support in SPL with MbedTLS crypto library"
-	depends on MBEDTLS_LIB_CRYPTO
-	help
-	  This option enables support of key derivation using HKDF algorithm
-	  with MbedTLS crypto library.
-
-endif # SPL
-
 endif # MBEDTLS_LIB_CRYPTO
 
 config MBEDTLS_LIB_X509
@@ -364,10 +240,6 @@ config MBEDTLS_LIB_X509
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
-	select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
-	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
-		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable MbedTLS certificate libraries.
 
@@ -418,44 +290,249 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+endif # MBEDTLS_LIB_X509
+
+config MBEDTLS_LIB_TLS
+	bool "MbedTLS TLS library"
+	depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	depends on X509_CERTIFICATE_PARSER_MBEDTLS
+	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	depends on ASN1_DECODER_MBEDTLS
+	depends on MBEDTLS_LIB
+	help
+	  Enable MbedTLS TLS library. Required for HTTPs support
+	  in wget
+
+endif # MBEDTLS_LIB
+
+# For SPL
+
 if SPL
 
+choice
+	prompt "Select crypto libraries (SPL)"
+	default SPL_LEGACY_CRYPTO
+	help
+	  Select crypto libraries in SPL.
+	  SPL_LEGACY_CRYPTO for legacy crypto libraries,
+	  SPL_MBEDTLS_LIB for MbedTLS libraries.
+
+config SPL_LEGACY_CRYPTO
+	bool "legacy crypto libraries"
+	select SPL_LEGACY_CRYPTO_BASIC
+	select SPL_LEGACY_CRYPTO_CERT
+
+config SPL_MBEDTLS_LIB
+	bool "MbedTLS libraries"
+	select SPL_MBEDTLS_LIB_X509
+endchoice
+
+if SPL_LEGACY_CRYPTO || SPL_MBEDTLS_LIB_CRYPTO_ALT
+
+config SPL_LEGACY_CRYPTO_BASIC
+	bool "legacy basic crypto libraries (SPL)"
+	select SPL_MD5_LEGACY if SPL_MD5
+	select SPL_SHA1_LEGACY if SPL_SHA1
+	select SPL_SHA256_LEGACY if SPL_SHA256
+	select SPL_SHA512_LEGACY if SPL_SHA512
+	select SPL_SHA384_LEGACY if SPL_SHA384
+	help
+	  Enable legacy basic crypto libraries in SPL.
+
+if SPL_LEGACY_CRYPTO_BASIC
+
+config SPL_SHA1_LEGACY
+	bool "Enable SHA1 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA256_LEGACY
+	bool "Enable SHA256 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA512_LEGACY
+	bool "Enable SHA512 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA384_LEGACY
+	bool "Enable SHA384 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_BASIC && SPL_SHA384
+	select SPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_MD5_LEGACY
+	bool "Enable MD5 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_BASIC && SPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library in SPL.
+
+endif # SPL_LEGACY_CRYPTO_BASIC
+
+config SPL_LEGACY_CRYPTO_CERT
+	bool "legacy certificate libraries (SPL)"
+	depends on SPL_LEGACY_CRYPTO
+	select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
+	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
+		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
+	help
+	  Enable legacy certificate libraries in SPL.
+
+if SPL_LEGACY_CRYPTO_CERT
+
+config SPL_ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_CERT && SPL_ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder in
+	  SPL.
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
+	bool "Asymmetric public key crypto with legacy certificate library (SPL)"
+	depends on SPL_LEGACY_CRYPTO_CERT && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	help
+	  This option chooses legacy certificate library for asymmetric public
+	  key crypto algorithm in SPL.
+
+config SPL_RSA_PUBLIC_KEY_PARSER_LEGACY
+	bool "RSA public key parser with legacy certificate library (SPL)"
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
+	select SPL_ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for RSA public key
+	  parser in SPL.
+
+endif # SPL_LEGACY_CRYPTO_CERT
+
+endif # SPL_LEGACY_CRYPTO || SPL_MBEDTLS_LIB_CRYPTO_ALT
+
+if SPL_MBEDTLS_LIB
+
+config SPL_MBEDTLS_LIB_CRYPTO_ALT
+	bool "Use legacy crypto libraries as MbedTLS alternatives (SPL)"
+	depends on SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
+	select SPL_LEGACY_CRYPTO_BASIC
+	default y if SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS crypto alternatives and replace it with legacy crypto
+	  libraries in SPL.
+	  Mutually incompatible with SPL_MBEDTLS_LIB_CRYPTO.
+
+config SPL_MBEDTLS_LIB_CRYPTO
+	bool "Use MbedTLS native crypto libraries (SPL)"
+	default y if SPL_MBEDTLS_LIB
+	select SPL_MD5_MBEDTLS if SPL_MD5
+	select SPL_SHA1_MBEDTLS if SPL_SHA1
+	select SPL_SHA256_MBEDTLS if SPL_SHA256
+	select SPL_SHA512_MBEDTLS if SPL_SHA512
+	select SPL_SHA384_MBEDTLS if SPL_SHA384
+	help
+	  Enable MbedTLS native crypto libraries in SPL.
+
+if SPL_MBEDTLS_LIB_CRYPTO
+
+config SPL_SHA1_MBEDTLS
+	bool "Enable SHA1 support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with MbedTLS crypto library in SPL.
+
+config SPL_SHA256_MBEDTLS
+	bool "Enable SHA256 support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library in SPL.
+
+config SPL_SHA512_MBEDTLS
+	bool "Enable SHA512 support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with MbedTLS crypto library in SPL.
+
+config SPL_SHA384_MBEDTLS
+	bool "Enable SHA384 support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_SHA384
+	select SPL_SHA512
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with MbedTLS crypto library in SPL.
+
+config SPL_MD5_MBEDTLS
+	bool "Enable MD5 support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO && SPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with MbedTLS crypto library in SPL.
+
+config SPL_HKDF_MBEDTLS
+	bool "Enable HKDF support with MbedTLS crypto library (SPL)"
+	depends on SPL_MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library in SPL.
+
+endif # SPL_MBEDTLS_LIB_CRYPTO
+
+config SPL_MBEDTLS_LIB_X509
+	bool "MbedTLS certificate libraries (SPL)"
+	select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
+	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
+		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
+	help
+	  Enable MbedTLS certificate libraries in SPL.
+
+if SPL_MBEDTLS_LIB_X509
+
 config SPL_ASN1_DECODER_MBEDTLS
-	bool "ASN1 decoder with MbedTLS certificate library in SPL"
-	depends on MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
+	bool "ASN1 decoder with MbedTLS certificate library (SPL)"
+	depends on SPL_MBEDTLS_LIB_X509 && SPL_ASN1_DECODER
 	help
 	  This option chooses MbedTLS certificate library for ASN1 decoder in
 	  SPL.
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	bool "Asymmetric public key crypto with MbedTLS certificate library in SPL"
-	depends on MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	bool "Asymmetric public key crypto with MbedTLS certificate library (SPL)"
+	depends on SPL_MBEDTLS_LIB_X509 && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm in SPL.
 
 config SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
-	bool "RSA public key parser with MbedTLS certificate library in SPL"
+	bool "RSA public key parser with MbedTLS certificate library (SPL)"
 	depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select SPL_ASN1_DECODER_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser in SPL.
 
-endif # SPL
+endif # SPL_MBEDTLS_LIB_X509
 
-endif # MBEDTLS_LIB_X509
-
-config MBEDTLS_LIB_TLS
-	bool "MbedTLS TLS library"
-	depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
-	depends on X509_CERTIFICATE_PARSER_MBEDTLS
-	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on ASN1_DECODER_MBEDTLS
-	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on MBEDTLS_LIB
+config SPL_MBEDTLS_LIB_TLS
+	bool "MbedTLS TLS library (SPL)"
+	depends on SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	depends on SPL_X509_CERTIFICATE_PARSER_MBEDTLS
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	depends on SPL_ASN1_DECODER_MBEDTLS
+	depends on SPL_MBEDTLS_LIB
 	help
-	  Enable MbedTLS TLS library. Required for HTTPs support
+	  Enable MbedTLS TLS library in SPL. Required for HTTPs support
 	  in wget
 
-endif # MBEDTLS_LIB
+endif # SPL_MBEDTLS_LIB
+
+endif # SPL
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index e66c2018d97..4bbe7ceec45 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -6,60 +6,60 @@
 MBEDTLS_LIB_DIR = external/mbedtls/library
 
 # shim layer for hash
-obj-$(CONFIG_$(SPL_)MD5_MBEDTLS) += md5.o
-obj-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += sha1.o
-obj-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += sha256.o
-obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
+obj-$(CONFIG_$(XPL_)MD5_MBEDTLS) += md5.o
+obj-$(CONFIG_$(XPL_)SHA1_MBEDTLS) += sha1.o
+obj-$(CONFIG_$(XPL_)SHA256_MBEDTLS) += sha256.o
+obj-$(CONFIG_$(XPL_)SHA512_MBEDTLS) += sha512.o
 
 # x509 libraries
-obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+obj-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
-obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
+obj-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
-obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
+obj-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
+obj-$(CONFIG_$(XPL_)MSCODE_PARSER_MBEDTLS) += mscode_parser.o
+obj-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += rsa_helper.o
 
 # MbedTLS crypto library
-obj-$(CONFIG_MBEDTLS_LIB) += mbedtls_lib_crypto.o
+obj-$(CONFIG_$(XPL_)MBEDTLS_LIB) += mbedtls_lib_crypto.o
 mbedtls_lib_crypto-y := \
 	$(MBEDTLS_LIB_DIR)/platform_util.o \
 	$(MBEDTLS_LIB_DIR)/constant_time.o \
 	$(MBEDTLS_LIB_DIR)/md.o
 
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA256_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(XPL_)MD5_MBEDTLS) += $(MBEDTLS_LIB_DIR)/md5.o
+mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA1_MBEDTLS) += $(MBEDTLS_LIB_DIR)/sha1.o
+mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA256_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha256.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(XPL_)SHA512_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/sha512.o
-mbedtls_lib_crypto-$(CONFIG_$(SPL_)HKDF_MBEDTLS) += \
+mbedtls_lib_crypto-$(CONFIG_$(XPL_)HKDF_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/hkdf.o
 
 # MbedTLS X509 library
-obj-$(CONFIG_MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
+obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASN1_DECODER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(XPL_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(XPL_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/bignum.o \
 	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(XPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(XPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crl.o \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
+mbedtls_lib_x509-$(CONFIG_$(XPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
 
 #mbedTLS TLS support
-obj-$(CONFIG_MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
+obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_TLS) += mbedtls_lib_tls.o
 mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index fd440c392f9..2da88c95454 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -11,12 +11,12 @@
  * Author: Raymond Mao <raymond.mao@linaro.org>
  */
 
-#if defined CONFIG_MBEDTLS_LIB
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB)
 
 #if CONFIG_IS_ENABLED(MD5)
 #define MBEDTLS_MD_C
 #define MBEDTLS_MD5_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
 #define MBEDTLS_MD5_ALT
 #endif
 #endif
@@ -24,7 +24,7 @@
 #if CONFIG_IS_ENABLED(SHA1)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA1_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
 #define MBEDTLS_SHA1_ALT
 #endif
 #endif
@@ -32,7 +32,7 @@
 #if CONFIG_IS_ENABLED(SHA256)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA256_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
 #define MBEDTLS_SHA256_ALT
 #endif
 #if CONFIG_IS_ENABLED(SHA256_SMALLER)
@@ -48,7 +48,7 @@
 #if CONFIG_IS_ENABLED(SHA512)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA512_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO_ALT)
 #define MBEDTLS_SHA512_ALT
 #endif
 #if CONFIG_IS_ENABLED(SHA512_SMALLER)
@@ -60,7 +60,7 @@
 #define MBEDTLS_HKDF_C
 #endif
 
-#if defined CONFIG_MBEDTLS_LIB_X509
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_X509_USE_C
@@ -89,9 +89,9 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
-#endif /* #if defined CONFIG_MBEDTLS_LIB_X509 */
+#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
-#if IS_ENABLED(CONFIG_MBEDTLS_LIB_TLS)
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
 #include "rtc.h"
 
 /* Generic options */
@@ -106,25 +106,36 @@
 #define MBEDTLS_ENTROPY_C
 #define MBEDTLS_NO_PLATFORM_ENTROPY
 #define MBEDTLS_SSL_PROTO_TLS1_2
+#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_SSL_SERVER_NAME_INDICATION
+#endif
 #define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
 
 /* RSA */
+#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER) && \
+	CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
 #define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
 #define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
 #define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
+#endif
 #define MBEDTLS_GCM_C
 
 /* ECDSA */
+#if CONFIG_IS_ENABLED(ASN1_DECODER)
 #define MBEDTLS_ECDSA_C
+#define MBEDTLS_ECP_C
 #define MBEDTLS_ECDH_C
+#endif
 #define MBEDTLS_ECDSA_DETERMINISTIC
 #define MBEDTLS_HMAC_DRBG_C
-#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
-#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
+
 #define MBEDTLS_CAN_ECDH
 #define MBEDTLS_PK_CAN_ECDSA_SIGN
-#define MBEDTLS_ECP_C
+#if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
+#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
+#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
+#endif
+
 #define MBEDTLS_ECP_DP_SECP256K1_ENABLED
 #define MBEDTLS_ECP_DP_SECP192R1_ENABLED
 #define MBEDTLS_ECP_DP_SECP224R1_ENABLED
@@ -138,6 +149,6 @@
 #define MBEDTLS_ECP_DP_BP384R1_ENABLED
 #define MBEDTLS_ECP_DP_BP512R1_ENABLED
 
-#endif /* #if defined CONFIG_MBEDTLS_LIB_TLS */
+#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
 
-#endif /* #if defined CONFIG_MBEDTLS_LIB */
+#endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB) */
-- 
2.25.1

