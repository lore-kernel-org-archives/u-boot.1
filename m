Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1998C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 22:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B674801DE;
	Mon,  3 Feb 2025 23:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFonflGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B23080050; Mon,  3 Feb 2025 23:09:00 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15B680285
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 23:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7be44a90468so591386285a.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738620535; x=1739225335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+nLRvqnIXTVfzHxozpltACyZbcT5tzvnfW4XCZtFLk=;
 b=JFonflGtE3To6tiJwqS072VAKNSDt8YfU5cXdl0J5JMIY404zCivEEJDPtcmjFSXho
 apZvpUtY+1NEv537SiLU34ICDoJyUGgcJqF9Tvnqq8bL1JHVObDc8LNYc3LyFqwrYi4N
 0fmrvQcUhFwEylGZAYauvV+BwBWydN+56BcQEGA59i+TaR/I3hG8Zs9pP2jESi72CA4u
 oHUbrZpCjxRePKK/Utqx28APiUwqok4vO0owdZbw60YqkcNMd9uWnFUjkGLMVW67f88w
 Tn7Dg3ex9WkUaNOP/7x24Ah1pvY4LUxLgwFys8gxXjI2ADc9XgnmiphN6L5NJ/7r9YIm
 cfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738620535; x=1739225335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+nLRvqnIXTVfzHxozpltACyZbcT5tzvnfW4XCZtFLk=;
 b=tBYzI96AWC0lX8UcyCkZRSCcnf9BUG4JgD+6yyzTPp/WWKp+mL+tEXJteoBRnokP1W
 6GNkX62wPBzpdDlX/nmALxI6aIWMl9qTE3BBaRZdhPaUzMP1vkvzLzxIT1lxas/Mrnua
 kfZBgbh26YrdEvV9k2um89GEXJmMZR4Jyp1+7d4q2K9PqbHFa3YSn4ob9g3DWC5Dl6hH
 e5TYpB2CBRxvXbFaoSTcqmky0TVvx9RNdrhLo0wteLXhVaEPdwEZswc7q5CGUpcomg6T
 6NHbMl/Q7qwvMeFUHTDHcoUyoZHvKRwjQ0kbb4vgWN0gvProWMCzcNxiVAKOvx78FJv2
 s6Bw==
X-Gm-Message-State: AOJu0YytRyKjYJKxCrtYuP7lYhW2yRmzkMAJ+TWvUFk2AVAwyj0us7Qz
 cHcDeyVqxPZLGsRKaEKm41sPtc6i8IYqBlK3gj8uyP6jMepqpVi/YVr6NewDc/aD7LUEhiYsd+i
 nTmE=
X-Gm-Gg: ASbGncvGe0p3uRcrA36PA+7J5ZUlJ73HKotioO8zEuHohPvaU5Ocnte3BJe4CdS00Nj
 bbDkaH7/G6VYq2K3ZwEzS+tKFNUn5XKG1zhzKEtFIW9eqbtId3q8uXFZ6EZ5KayLXHMl18h4uJp
 tKgblIKr//JkNBMmKNQdlQAgaaeUGoMcTD0mTrhyrT+TjNfhH7y3juRQvhx7bFquWutntTcbkUb
 qEuguBTVO3KH7CZ+0Fap3l22pGZomDEcqULsCFQ8Q/wiMWA7Xb1ilt9u0ZxIydhmfkpdOOFUfzQ
 m1CLDRpYtBvzfBjnMJX788jsPITE45+Z7cPt8ceISEHjJyPpZhHXwF331M7yknh8iMhESgiJO3W
 2gUNBVbF7yWGmDg==
X-Google-Smtp-Source: AGHT+IGQasi+cXHpH7mR7AbAsnq3cwgkssh6Mq4YoGeKaSVghN4bMftUVAOBwK+OQtkLcnNVROektQ==
X-Received: by 2002:a05:620a:8086:b0:7b7:142d:53d4 with SMTP id
 af79cd13be357-7bffcd9b7d2mr3293059385a.39.1738620534803; 
 Mon, 03 Feb 2025 14:08:54 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d8700sm569781085a.49.2025.02.03.14.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 14:08:54 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 3/3] mbedtls: refactor mbedtls build for XPL
Date: Mon,  3 Feb 2025 14:08:14 -0800
Message-Id: <20250203220825.707590-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203220825.707590-1-raymond.mao@linaro.org>
References: <20250203220825.707590-1-raymond.mao@linaro.org>
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
mbedtls kconfig options in U-Boot Proper, SPL, TPL and VPL.
User can choose legacy or mbedtls libraries for them independently.

Set mbedtls native hashing libraries as default when MBEDTLS_LIB,
SPL_MBEDTLS_LIB, TPL_MBEDTLS_LIB or VPL_MBEDTLS_LIB is selected.

If users prefer using U-Boot legacy hashing libraries, please select
MBEDTLS_LIB_HASHING_ALT, SPL_MBEDTLS_LIB_HASHING_ALT,
TPL_MBEDTLS_LIB_HASHING_ALT or VPL_MBEDTLS_LIB_HASHING_ALT for U-Boot
Proper, SPL, TPL and VPL respectively.

Moreover, rename a few kconfig options and update their descriptions to
improve the consistency of terminology.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Rename a few kconfig options and update their descriptions.
- Add kconfig options for TPL.
- Rebase on top of the changes which is adding the kconfig options for VPL:
  '[PATCH 01/19] mbedtls: Add SHA symbols for VPL'
  https://lore.kernel.org/u-boot/20250126184333.4058848-2-sjg@chromium.org/

 Makefile                         |   2 +-
 lib/mbedtls/Kconfig              | 785 ++++++++++++++++++++++---------
 lib/mbedtls/Makefile             |  44 +-
 lib/mbedtls/mbedtls_def_config.h |  37 +-
 4 files changed, 612 insertions(+), 256 deletions(-)

diff --git a/Makefile b/Makefile
index 33bb86343c5..7496dd585d0 100644
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
index bb8ac5f862b..789721ee6cd 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -1,57 +1,54 @@
+# For U-Boot Proper
+
 choice
-	prompt "Select crypto libraries"
-	default LEGACY_CRYPTO
+	prompt "Crypto libraries (U-Boot Proper)"
+	default LEGACY_HASHING_AND_CRYPTO
 	help
 	  Select crypto libraries.
-	  LEGACY_CRYPTO for legacy crypto libraries,
+	  LEGACY_HASHING_AND_CRYPTO for legacy crypto libraries,
 	  MBEDTLS_LIB for MbedTLS libraries.
 
-config LEGACY_CRYPTO
+config LEGACY_HASHING_AND_CRYPTO
 	bool "legacy crypto libraries"
-	select LEGACY_CRYPTO_BASIC
-	select LEGACY_CRYPTO_CERT
+	select LEGACY_HASHING
+	select LEGACY_CRYPTO
 
 config MBEDTLS_LIB
 	bool "MbedTLS libraries"
 	select MBEDTLS_LIB_X509
 endchoice
 
-if LEGACY_CRYPTO || MBEDTLS_LIB_CRYPTO_ALT
+if LEGACY_HASHING_AND_CRYPTO || MBEDTLS_LIB_HASHING_ALT
 
-config LEGACY_CRYPTO_BASIC
-	bool "legacy basic crypto libraries"
+config LEGACY_HASHING
+	bool "Use U-Boot legacy hashing libraries"
 	select MD5_LEGACY if MD5
 	select SHA1_LEGACY if SHA1
 	select SHA256_LEGACY if SHA256
 	select SHA512_LEGACY if SHA512
 	select SHA384_LEGACY if SHA384
-	select SPL_MD5_LEGACY if SPL_MD5
-	select SPL_SHA1_LEGACY if SPL_SHA1
-	select SPL_SHA256_LEGACY if SPL_SHA256
-	select SPL_SHA512_LEGACY if SPL_SHA512
-	select SPL_SHA384_LEGACY if SPL_SHA384
 	help
-	  Enable legacy basic crypto libraries.
+	  Enable U-Boot legacy hashing libraries.
 
-if LEGACY_CRYPTO_BASIC
+if LEGACY_HASHING
 
 config SHA1_LEGACY
 	bool "Enable SHA1 support with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SHA1
+	depends on LEGACY_HASHING && SHA1
 	help
 	  This option enables support of hashing using SHA1 algorithm
 	  with legacy crypto library.
 
 config SHA256_LEGACY
 	bool "Enable SHA256 support with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SHA256
+	depends on LEGACY_HASHING && SHA256
 	help
 	  This option enables support of hashing using SHA256 algorithm
 	  with legacy crypto library.
 
 config SHA512_LEGACY
 	bool "Enable SHA512 support with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SHA512
+	depends on LEGACY_HASHING && SHA512
 	default y if TI_SECURE_DEVICE && FIT_SIGNATURE
 	help
 	  This option enables support of hashing using SHA512 algorithm
@@ -59,7 +56,7 @@ config SHA512_LEGACY
 
 config SHA384_LEGACY
 	bool "Enable SHA384 support with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && SHA384
+	depends on LEGACY_HASHING && SHA384
 	select SHA512_LEGACY
 	help
 	  This option enables support of hashing using SHA384 algorithm
@@ -67,96 +64,16 @@ config SHA384_LEGACY
 
 config MD5_LEGACY
 	bool "Enable MD5 support with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && MD5
-	help
-	  This option enables support of hashing using MD5 algorithm
-	  with legacy crypto library.
-
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
-if VPL
-
-config VPL_SHA1_LEGACY
-	bool "Enable SHA1 support in VPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && VPL_SHA1
-	help
-	  This option enables support of hashing using SHA1 algorithm
-	  with legacy crypto library.
-
-config VPL_SHA256_LEGACY
-	bool "Enable SHA256 support in VPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && VPL_SHA256
-	help
-	  This option enables support of hashing using SHA256 algorithm
-	  with legacy crypto library.
-
-config VPL_SHA512_LEGACY
-	bool "Enable SHA512 support in VPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && VPL_SHA512
-	help
-	  This option enables support of hashing using SHA512 algorithm
-	  with legacy crypto library.
-
-config VPL_SHA384_LEGACY
-	bool "Enable SHA384 support in VPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && VPL_SHA384
-	select VPL_SHA512_LEGACY
-	help
-	  This option enables support of hashing using SHA384 algorithm
-	  with legacy crypto library.
-
-config VPL_MD5_LEGACY
-	bool "Enable MD5 support in VPL with legacy crypto library"
-	depends on LEGACY_CRYPTO_BASIC && VPL_MD5
+	depends on LEGACY_HASHING && MD5
 	help
 	  This option enables support of hashing using MD5 algorithm
 	  with legacy crypto library.
 
-endif # VPL
-
-endif # LEGACY_CRYPTO_BASIC
+endif # LEGACY_HASHING
 
-config LEGACY_CRYPTO_CERT
+config LEGACY_CRYPTO
 	bool "legacy certificate libraries"
-	depends on LEGACY_CRYPTO
+	depends on LEGACY_HASHING_AND_CRYPTO
 	select ASN1_DECODER_LEGACY if ASN1_DECODER
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
@@ -164,24 +81,20 @@ config LEGACY_CRYPTO_CERT
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
-	select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
-	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
-		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable legacy certificate libraries.
 
-if LEGACY_CRYPTO_CERT
+if LEGACY_CRYPTO
 
 config ASN1_DECODER_LEGACY
 	bool "ASN1 decoder with legacy certificate library"
-	depends on LEGACY_CRYPTO_CERT && ASN1_DECODER
+	depends on LEGACY_CRYPTO && ASN1_DECODER
 	help
 	  This option chooses legacy certificate library for ASN1 decoder.
 
 config ASYMMETRIC_PUBLIC_KEY_LEGACY
 	bool "Asymmetric public key crypto with legacy certificate library"
-	depends on LEGACY_CRYPTO_CERT && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	depends on LEGACY_CRYPTO && ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm.
@@ -212,68 +125,41 @@ config PKCS7_MESSAGE_PARSER_LEGACY
 
 config MSCODE_PARSER_LEGACY
 	bool "MS authenticode parser with legacy certificate library"
-	depends on LEGACY_CRYPTO_CERT && MSCODE_PARSER
+	depends on LEGACY_CRYPTO && MSCODE_PARSER
 	select ASN1_DECODER_LEGACY
 	help
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
-endif # LEGACY_CRYPTO_CERT
-
 endif # LEGACY_CRYPTO
 
+endif # LEGACY_HASHING_AND_CRYPTO || MBEDTLS_LIB_HASHING_ALT
+
 if MBEDTLS_LIB
 
-config MBEDTLS_LIB_CRYPTO_ALT
-	bool "MbedTLS crypto alternatives"
+config MBEDTLS_LIB_HASHING_ALT
+	bool "Replace MbedTLS native hashing with U-Boot legacy libraries"
 	depends on MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
-	select LEGACY_CRYPTO_BASIC
+	select LEGACY_HASHING
 	default y if MBEDTLS_LIB && !MBEDTLS_LIB_CRYPTO
 	help
-	  Enable MbedTLS crypto alternatives.
+	  Enable MbedTLS hashing alternatives and replace them with legacy hashing
+	  libraries.
+	  This allows user to use U-Boot legacy hashing algorithms together with
+	  other MbedTLS modules.
 	  Mutually incompatible with MBEDTLS_LIB_CRYPTO.
 
 config MBEDTLS_LIB_CRYPTO
-	bool "MbedTLS crypto libraries"
+	bool "Use MbedTLS native crypto libraries for hashing"
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
-	  Mutually incompatible with MBEDTLS_LIB_CRYPTO_ALT.
+	  Enable MbedTLS native crypto libraries.
+	  Mutually incompatible with MBEDTLS_LIB_HASHING_ALT.
 
 if MBEDTLS_LIB_CRYPTO
 
@@ -345,53 +231,6 @@ config HKDF_MBEDTLS
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
@@ -403,10 +242,6 @@ config MBEDTLS_LIB_X509
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select MSCODE_PARSER_MBEDTLS if MSCODE_PARSER
-	select SPL_ASN1_DECODER_MBEDTLS if SPL_ASN1_DECODER
-	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
-		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-	select SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS if SPL_RSA_PUBLIC_KEY_PARSER
 	help
 	  Enable MbedTLS certificate libraries.
 
@@ -457,44 +292,554 @@ config MSCODE_PARSER_MBEDTLS
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
+	prompt "Crypto libraries (SPL)"
+	default SPL_LEGACY_HASHING_AND_CRYPTO
+	help
+	  Select crypto libraries in SPL.
+	  SPL_LEGACY_HASHING_AND_CRYPTO for legacy crypto libraries,
+	  SPL_MBEDTLS_LIB for MbedTLS libraries.
+
+config SPL_LEGACY_HASHING_AND_CRYPTO
+	bool "legacy crypto libraries"
+	select SPL_LEGACY_HASHING
+	select SPL_LEGACY_CRYPTO
+
+config SPL_MBEDTLS_LIB
+	bool "MbedTLS libraries"
+	select SPL_MBEDTLS_LIB_X509
+endchoice
+
+if SPL_LEGACY_HASHING_AND_CRYPTO || SPL_MBEDTLS_LIB_HASHING_ALT
+
+config SPL_LEGACY_HASHING
+	bool "Use U-Boot legacy hashing libraries (SPL)"
+	select SPL_MD5_LEGACY if SPL_MD5
+	select SPL_SHA1_LEGACY if SPL_SHA1
+	select SPL_SHA256_LEGACY if SPL_SHA256
+	select SPL_SHA512_LEGACY if SPL_SHA512
+	select SPL_SHA384_LEGACY if SPL_SHA384
+	help
+	  Enable U-Boot legacy hashing libraries in SPL.
+
+if SPL_LEGACY_HASHING
+
+config SPL_SHA1_LEGACY
+	bool "Enable SHA1 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_HASHING && SPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA256_LEGACY
+	bool "Enable SHA256 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_HASHING && SPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA512_LEGACY
+	bool "Enable SHA512 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_HASHING && SPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_SHA384_LEGACY
+	bool "Enable SHA384 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_HASHING && SPL_SHA384
+	select SPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library in SPL.
+
+config SPL_MD5_LEGACY
+	bool "Enable MD5 support with legacy crypto library (SPL)"
+	depends on SPL_LEGACY_HASHING && SPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library in SPL.
+
+endif # SPL_LEGACY_HASHING
+
+config SPL_LEGACY_CRYPTO
+	bool "legacy certificate libraries (SPL)"
+	depends on SPL_LEGACY_HASHING_AND_CRYPTO
+	select SPL_ASN1_DECODER_LEGACY if SPL_ASN1_DECODER
+	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
+		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select SPL_RSA_PUBLIC_KEY_PARSER_LEGACY if SPL_RSA_PUBLIC_KEY_PARSER
+	help
+	  Enable legacy certificate libraries in SPL.
+
+if SPL_LEGACY_CRYPTO
+
+config SPL_ASN1_DECODER_LEGACY
+	bool "ASN1 decoder with legacy certificate library (SPL)"
+	depends on SPL_LEGACY_CRYPTO && SPL_ASN1_DECODER
+	help
+	  This option chooses legacy certificate library for ASN1 decoder in
+	  SPL.
+
+config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
+	bool "Asymmetric public key crypto with legacy certificate library (SPL)"
+	depends on SPL_LEGACY_CRYPTO && SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
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
+endif # SPL_LEGACY_CRYPTO
+
+endif # SPL_LEGACY_HASHING_AND_CRYPTO || SPL_MBEDTLS_LIB_HASHING_ALT
+
+if SPL_MBEDTLS_LIB
+
+config SPL_MBEDTLS_LIB_HASHING_ALT
+	bool "Replace MbedTLS native hashing with U-Boot legacy libraries (SPL)"
+	depends on SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
+	select SPL_LEGACY_HASHING
+	default y if SPL_MBEDTLS_LIB && !SPL_MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS hashing alternatives and replace them with legacy hashing
+	  libraries in SPL.
+	  This allows user to use U-Boot legacy hashing algorithms together with
+	  other MbedTLS modules.
+	  Mutually incompatible with SPL_MBEDTLS_LIB_CRYPTO.
+
+config SPL_MBEDTLS_LIB_CRYPTO
+	bool "Use MbedTLS native crypto libraries for hashing (SPL)"
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
 
+endif # SPL_MBEDTLS_LIB_X509
+
+config SPL_MBEDTLS_LIB_TLS
+	bool "MbedTLS TLS library (SPL)"
+	depends on SPL_RSA_PUBLIC_KEY_PARSER_MBEDTLS
+	depends on SPL_X509_CERTIFICATE_PARSER_MBEDTLS
+	depends on SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	depends on SPL_ASN1_DECODER_MBEDTLS
+	depends on SPL_MBEDTLS_LIB
+	help
+	  Enable MbedTLS TLS library in SPL. Required for HTTPs support
+	  in wget
+
+endif # SPL_MBEDTLS_LIB
+
 endif # SPL
 
-endif # MBEDTLS_LIB_X509
+# For TPL
 
-config MBEDTLS_LIB_TLS
-	bool "MbedTLS TLS library"
-	depends on RSA_PUBLIC_KEY_PARSER_MBEDTLS
-	depends on X509_CERTIFICATE_PARSER_MBEDTLS
-	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on ASN1_DECODER_MBEDTLS
-	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
-	depends on MBEDTLS_LIB
+if TPL
+
+choice
+	prompt "Crypto libraries (TPL)"
+	default TPL_LEGACY_HASHING_AND_CRYPTO
 	help
-	  Enable MbedTLS TLS library. Required for HTTPs support
-	  in wget
+	  Select crypto libraries in TPL.
+	  TPL_LEGACY_HASHING_AND_CRYPTO for legacy crypto libraries,
+	  TPL_MBEDTLS_LIB for MbedTLS libraries.
 
-endif # MBEDTLS_LIB
+config TPL_LEGACY_HASHING_AND_CRYPTO
+	bool "legacy crypto libraries"
+	select TPL_LEGACY_HASHING
+	select TPL_LEGACY_CRYPTO
+
+config TPL_MBEDTLS_LIB
+	bool "MbedTLS libraries"
+
+endchoice
+
+if TPL_LEGACY_HASHING_AND_CRYPTO || TPL_MBEDTLS_LIB_HASHING_ALT
+
+config TPL_LEGACY_HASHING
+	bool "Use U-Boot legacy hashing libraries (TPL)"
+	select TPL_MD5_LEGACY if TPL_MD5
+	select TPL_SHA1_LEGACY if TPL_SHA1
+	select TPL_SHA256_LEGACY if TPL_SHA256
+	select TPL_SHA512_LEGACY if TPL_SHA512
+	select TPL_SHA384_LEGACY if TPL_SHA384
+	help
+	  Enable U-Boot legacy hashing libraries in TPL.
+
+if TPL_LEGACY_HASHING
+
+config TPL_SHA1_LEGACY
+	bool "Enable SHA1 support with legacy crypto library (TPL)"
+	depends on TPL_LEGACY_HASHING && TPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library in TPL.
+
+config TPL_SHA256_LEGACY
+	bool "Enable SHA256 support with legacy crypto library (TPL)"
+	depends on TPL_LEGACY_HASHING && TPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library in TPL.
+
+config TPL_SHA512_LEGACY
+	bool "Enable SHA512 support with legacy crypto library (TPL)"
+	depends on TPL_LEGACY_HASHING && TPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library in TPL.
+
+config TPL_SHA384_LEGACY
+	bool "Enable SHA384 support with legacy crypto library (TPL)"
+	depends on TPL_LEGACY_HASHING && TPL_SHA384
+	select TPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library in TPL.
+
+config TPL_MD5_LEGACY
+	bool "Enable MD5 support with legacy crypto library (TPL)"
+	depends on TPL_LEGACY_HASHING && TPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library in TPL.
+
+endif # TPL_LEGACY_HASHING
+
+endif # TPL_LEGACY_HASHING_AND_CRYPTO || TPL_MBEDTLS_LIB_HASHING_ALT
+
+if TPL_MBEDTLS_LIB
+
+config TPL_MBEDTLS_LIB_HASHING_ALT
+	bool "Replace MbedTLS native hashing with U-Boot legacy libraries (TPL)"
+	depends on TPL_MBEDTLS_LIB && !TPL_MBEDTLS_LIB_CRYPTO
+	select TPL_LEGACY_HASHING
+	default y if TPL_MBEDTLS_LIB && !TPL_MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS hashing alternatives and replace them with legacy hashing
+	  libraries in TPL.
+	  This allows user to use U-Boot legacy hashing algorithms together with
+	  other MbedTLS modules.
+	  Mutually incompatible with TPL_MBEDTLS_LIB_CRYPTO.
+
+config TPL_MBEDTLS_LIB_CRYPTO
+	bool "Use MbedTLS native crypto libraries for hashing (TPL)"
+	default y if TPL_MBEDTLS_LIB
+	select TPL_MD5_MBEDTLS if TPL_MD5
+	select TPL_SHA1_MBEDTLS if TPL_SHA1
+	select TPL_SHA256_MBEDTLS if TPL_SHA256
+	select TPL_SHA512_MBEDTLS if TPL_SHA512
+	select TPL_SHA384_MBEDTLS if TPL_SHA384
+	help
+	  Enable MbedTLS native crypto libraries in TPL.
+
+if TPL_MBEDTLS_LIB_CRYPTO
+
+config TPL_SHA1_MBEDTLS
+	bool "Enable SHA1 support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO && TPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with MbedTLS crypto library in TPL.
+
+config TPL_SHA256_MBEDTLS
+	bool "Enable SHA256 support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO && TPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library in TPL.
+
+config TPL_SHA512_MBEDTLS
+	bool "Enable SHA512 support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO && TPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with MbedTLS crypto library in TPL.
+
+config TPL_SHA384_MBEDTLS
+	bool "Enable SHA384 support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO && TPL_SHA384
+	select TPL_SHA512
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with MbedTLS crypto library in TPL.
+
+config TPL_MD5_MBEDTLS
+	bool "Enable MD5 support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO && TPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with MbedTLS crypto library in TPL.
+
+config TPL_HKDF_MBEDTLS
+	bool "Enable HKDF support with MbedTLS crypto library (TPL)"
+	depends on TPL_MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library in TPL.
+
+endif # TPL_MBEDTLS_LIB_CRYPTO
+
+endif # TPL_MBEDTLS_LIB
+
+endif # TPL
+
+# For VPL
+
+if VPL
+
+choice
+	prompt "Crypto libraries (VPL)"
+	default VPL_LEGACY_HASHING_AND_CRYPTO
+	help
+	  Select crypto libraries in VPL.
+	  VPL_LEGACY_HASHING_AND_CRYPTO for legacy crypto libraries,
+	  VPL_MBEDTLS_LIB for MbedTLS libraries.
+
+config VPL_LEGACY_HASHING_AND_CRYPTO
+	bool "legacy crypto libraries"
+	select VPL_LEGACY_HASHING
+
+config VPL_MBEDTLS_LIB
+	bool "MbedTLS libraries"
+
+endchoice
+
+if VPL_LEGACY_HASHING_AND_CRYPTO || VPL_MBEDTLS_LIB_HASHING_ALT
+
+config VPL_LEGACY_HASHING
+	bool "Use U-Boot legacy hashing libraries (VPL)"
+	select VPL_MD5_LEGACY if VPL_MD5
+	select VPL_SHA1_LEGACY if VPL_SHA1
+	select VPL_SHA256_LEGACY if VPL_SHA256
+	select VPL_SHA512_LEGACY if VPL_SHA512
+	select VPL_SHA384_LEGACY if VPL_SHA384
+	help
+	  Enable U-Boot legacy hashing libraries in VPL.
+
+if VPL_LEGACY_HASHING
+
+config VPL_SHA1_LEGACY
+	bool "Enable SHA1 support with legacy crypto library (VPL)"
+	depends on VPL_LEGACY_HASHING && VPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with legacy crypto library in VPL.
+
+config VPL_SHA256_LEGACY
+	bool "Enable SHA256 support with legacy crypto library (VPL)"
+	depends on VPL_LEGACY_HASHING && VPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with legacy crypto library in VPL.
+
+config VPL_SHA512_LEGACY
+	bool "Enable SHA512 support with legacy crypto library (VPL)"
+	depends on VPL_LEGACY_HASHING && VPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with legacy crypto library in VPL.
+
+config VPL_SHA384_LEGACY
+	bool "Enable SHA384 support with legacy crypto library (VPL)"
+	depends on VPL_LEGACY_HASHING && VPL_SHA384
+	select VPL_SHA512_LEGACY
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with legacy crypto library in VPL.
+
+config VPL_MD5_LEGACY
+	bool "Enable MD5 support with legacy crypto library (VPL)"
+	depends on VPL_LEGACY_HASHING && VPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with legacy crypto library in VPL.
+
+endif # VPL_LEGACY_HASHING
+
+endif # VPL_LEGACY_HASHING_AND_CRYPTO || VPL_MBEDTLS_LIB_HASHING_ALT
+
+if VPL_MBEDTLS_LIB
+
+config VPL_MBEDTLS_LIB_HASHING_ALT
+	bool "Replace MbedTLS native hashing with U-Boot legacy libraries (VPL)"
+	depends on VPL_MBEDTLS_LIB && !VPL_MBEDTLS_LIB_CRYPTO
+	select VPL_LEGACY_HASHING
+	default y if VPL_MBEDTLS_LIB && !VPL_MBEDTLS_LIB_CRYPTO
+	help
+	  Enable MbedTLS hashing alternatives and replace them with legacy hashing
+	  libraries in VPL.
+	  This allows user to use U-Boot legacy hashing algorithms together with
+	  other MbedTLS modules.
+	  Mutually incompatible with VPL_MBEDTLS_LIB_CRYPTO.
+
+config VPL_MBEDTLS_LIB_CRYPTO
+	bool "Use MbedTLS native crypto libraries for hashing (VPL)"
+	default y if VPL_MBEDTLS_LIB
+	select VPL_MD5_MBEDTLS if VPL_MD5
+	select VPL_SHA1_MBEDTLS if VPL_SHA1
+	select VPL_SHA256_MBEDTLS if VPL_SHA256
+	select VPL_SHA512_MBEDTLS if VPL_SHA512
+	select VPL_SHA384_MBEDTLS if VPL_SHA384
+	help
+	  Enable MbedTLS native crypto libraries in VPL.
+
+if VPL_MBEDTLS_LIB_CRYPTO
+
+config VPL_SHA1_MBEDTLS
+	bool "Enable SHA1 support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO && VPL_SHA1
+	help
+	  This option enables support of hashing using SHA1 algorithm
+	  with MbedTLS crypto library in VPL.
+
+config VPL_SHA256_MBEDTLS
+	bool "Enable SHA256 support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO && VPL_SHA256
+	help
+	  This option enables support of hashing using SHA256 algorithm
+	  with MbedTLS crypto library in VPL.
+
+config VPL_SHA512_MBEDTLS
+	bool "Enable SHA512 support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO && VPL_SHA512
+	help
+	  This option enables support of hashing using SHA512 algorithm
+	  with MbedTLS crypto library in VPL.
+
+config VPL_SHA384_MBEDTLS
+	bool "Enable SHA384 support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO && VPL_SHA384
+	select VPL_SHA512
+	help
+	  This option enables support of hashing using SHA384 algorithm
+	  with MbedTLS crypto library in VPL.
+
+config VPL_MD5_MBEDTLS
+	bool "Enable MD5 support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO && VPL_MD5
+	help
+	  This option enables support of hashing using MD5 algorithm
+	  with MbedTLS crypto library in VPL.
+
+config VPL_HKDF_MBEDTLS
+	bool "Enable HKDF support with MbedTLS crypto library (VPL)"
+	depends on VPL_MBEDTLS_LIB_CRYPTO
+	help
+	  This option enables support of key derivation using HKDF algorithm
+	  with MbedTLS crypto library in VPL.
+
+endif # VPL_MBEDTLS_LIB_CRYPTO
+
+endif # VPL_MBEDTLS_LIB
+
+endif # VPL
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
index fd440c392f9..dda3f4dd6e4 100644
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
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_HASHING_ALT)
 #define MBEDTLS_MD5_ALT
 #endif
 #endif
@@ -24,7 +24,7 @@
 #if CONFIG_IS_ENABLED(SHA1)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA1_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_HASHING_ALT)
 #define MBEDTLS_SHA1_ALT
 #endif
 #endif
@@ -32,7 +32,7 @@
 #if CONFIG_IS_ENABLED(SHA256)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA256_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_HASHING_ALT)
 #define MBEDTLS_SHA256_ALT
 #endif
 #if CONFIG_IS_ENABLED(SHA256_SMALLER)
@@ -48,7 +48,7 @@
 #if CONFIG_IS_ENABLED(SHA512)
 #define MBEDTLS_MD_C
 #define MBEDTLS_SHA512_C
-#if defined CONFIG_MBEDTLS_LIB_CRYPTO_ALT
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_HASHING_ALT)
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

