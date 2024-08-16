Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18966C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E36C88C21;
	Fri, 16 Aug 2024 23:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nBB9JYjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F7688C50; Fri, 16 Aug 2024 23:55:09 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA8988498
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a50313f785so130244385a.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845295; x=1724450095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HLrweiYHGXqR27ZlwBAvtTvDJDZUXKl0cqQjPoKHn0=;
 b=nBB9JYjGlNe5vrZQL62C6+q7y+mxQRaOfs+Z9jERrSHFOODZcH4ZF3NjOwR+I5Elz6
 OG9oorf8n/h0ogEsTOCwtMjEX1pwUwdoifitgI0iaq/Uu8iTKuRfC5SO5iqri7ltrr89
 o2KPA+vRdIIJ+cXPHvnG4vReSgghDK1ta6QQeMDBToDvcMFgBjCWCWL4yCGBix2adnoK
 /et+pHrbzvjiVgsSk2MilYhvQ0N00Sl6NqnmkCxUzDWAJ5P7Rw7XruQYgjia7uJ+gxxD
 qWFH3XERppw/YTxBP6/gYodE0vM691r0SOi96A7CPxjp1feWzlvEI4CyzBnXzcr/CsP4
 fqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845295; x=1724450095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HLrweiYHGXqR27ZlwBAvtTvDJDZUXKl0cqQjPoKHn0=;
 b=Vm0zkF7lqbw1aj8+MstcBPP2oSthHMc1UWK4lEsgqGjIUsanWxtT2aycWPFFUEHz6B
 sDLZ5GPMy4ZHVGKTpoip3jmCx4WmycilZ83hE6wi+VEst7+HpmUUA2Thj5WDvOTqAl3I
 rM6KVhB+2QSHXIHfNZIUXRSlbzqXiYPSw4m/Jy7q8pMA4z5dMhpgAcV64p8bu0av0a84
 ue9etSuxs1gJI2uH4PiFmRSDduC/+FE9HDj0z2zkLlujA2MEUeztLG48P6XOlOF5zxek
 kqaAbIY1zCmav0PqwMHEJUtGIC/lorLHDiihaw+vhP4xX6eNCBKiumB7/XbIYcgg257O
 bnGg==
X-Gm-Message-State: AOJu0Yx9EkzxGcL0ddMLNFLPy4nBkBbAv8c6RHTbl4uoAc59cur1jFqh
 g8BAzGmDsslP4+/IChtjdw0R3T2H1z/RQxky8oKT0m1kwv+MB3MWsZR4JGnpbGPRJyyP7qatYIW
 geGc=
X-Google-Smtp-Source: AGHT+IHWCHd0DHh6HNvh5JesT5ZHLIkfxa/4rWgzeJl8BOg0H1Nw6wP+lGJOXc5BRSprhRrgRTMlYw==
X-Received: by 2002:a05:6214:418d:b0:6bf:7fd7:36ce with SMTP id
 6a1803df08f44-6bf894defe3mr8578466d6.21.1723845295093; 
 Fri, 16 Aug 2024 14:54:55 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:54:54 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 26/28] asn1_decoder: add build options for ASN1 decoder
Date: Fri, 16 Aug 2024 14:44:15 -0700
Message-Id: <20240816214436.1877263-27-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
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
Changes in v5
- Correct kconfig dependence.
- Refactored MbedTLS makefile.
Changes in v6
- None.

 lib/Makefile         |  2 +-
 lib/mbedtls/Kconfig  | 30 ++++++++++++++++++++++++++++++
 lib/mbedtls/Makefile |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 617f5a55de0..2f5c0a01b9a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_$(SPL_)SHA256_LEGACY) += sha256.o
 obj-$(CONFIG_$(SPL_)SHA512_LEGACY) += sha512.o
 
 obj-$(CONFIG_CRYPT_PW) += crypt/
-obj-$(CONFIG_$(SPL_)ASN1_DECODER) += asn1_decoder.o
+obj-$(CONFIG_$(SPL_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(SPL_)ZLIB) += zlib/
 obj-$(CONFIG_$(SPL_)ZSTD) += zstd/
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 797da0df938..b51f46014a7 100644
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

