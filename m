Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38328C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD26588AC1;
	Wed, 31 Jul 2024 19:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qoYeHLMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877DD88ACA; Wed, 31 Jul 2024 19:36:00 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736F08841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1d067d5bbso382658385a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447356; x=1723052156; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3flZ7wvuIxs9SdTd+tAVj8GGhox95DzzuN7ejoP6HQU=;
 b=qoYeHLMs+afrmrKb0W0/zAF4j100BjiKTwhFfFvh1mLc0t/YodAA3pWsyqSJL2J5B6
 z6HixqkxasJScBDHxd6+VYnCvtjTYGVUgglE7EgKlYLTdpctYAPtL2jCLObnGKzc7c3b
 OWs9N5ZuUCU1T7A0uMzzI+a3enIxCoznsbsGHlyvkM66bpU0Fvt5RxJ6V+ylMXFkvyKF
 AybYaA82MR5JkSeke66CR6wgrc0aygdotLflsKcdDdOjZ2ZrRw38X3+0yttZtC7QV92X
 ssy6B+ENavt+9RA1zF7MleNFJtxBX0EkiH/I62ZUGOjCztXzb43JK7AJ305hb4u0rIzH
 s/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447356; x=1723052156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3flZ7wvuIxs9SdTd+tAVj8GGhox95DzzuN7ejoP6HQU=;
 b=cEnmX3zbQJL3vHH45Hgxw3TURewZ+f84I/MRndCBQpMoyEM1tuwqUXNXTPi+JhgjMW
 em8yx03O1nkkyFTv5ZdzZIUYbZ0UZQ1rtl/Xrbml4blI/MUfI/PJYoqsWWPO75UfGiDV
 M2CoZx+HK/TsixHwN5o67ZO594VSBjrX+KhS9xKCJ+Rfx7K7rDELiQQNnFK41SibEAGJ
 UVGL5S1U1mV1s6wSkq1Y/aCeH/Y/PhO5TqYOW6q6hkoLn8DVi65MomEaUqsp6K8tNX8+
 uJbceVwkkmRUYKY3dSb/76OmryDEhuVanRiKBl15hpGeuFO8/xd7k6++71FHBxGnZcRZ
 5aTw==
X-Gm-Message-State: AOJu0YzuEXIeeWmGv/mqCOZ/xzAM/71Ya489J4RyaUpD7AK3Hg6yxAue
 qK2++XRqPAEz8oIEC14MvxSrRUyZhDLEBuZeW7cJTRRIF0tZY2/2U7RbXUY9Tbe8S+bHhsPnBNL
 PFxM=
X-Google-Smtp-Source: AGHT+IFJHxAhjxUa8RRHHjMf52ijq2rozr4UqG8jnnXA1Rl84rK9kBCCZwY9yjFTGlLGhFRTiWd8VA==
X-Received: by 2002:a05:620a:4051:b0:79d:6039:783c with SMTP id
 af79cd13be357-7a1e526b3f7mr2012607385a.41.1722447326064; 
 Wed, 31 Jul 2024 10:35:26 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:35:25 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 25/27] asn1_decoder: add build options for ASN1 decoder
Date: Wed, 31 Jul 2024 10:25:35 -0700
Message-Id: <20240731172556.1348487-26-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

 lib/Makefile         |  2 +-
 lib/mbedtls/Kconfig  | 30 ++++++++++++++++++++++++++++++
 lib/mbedtls/Makefile |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 35b73d8d00c..f0c5b9a9bb4 100644
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
index ea306e07ee4..336c5220805 100644
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
@@ -293,12 +308,14 @@ endif # MBEDTLS_LIB_CRYPTO
 
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
@@ -307,6 +324,12 @@ config MBEDTLS_LIB_X509
 
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
@@ -348,6 +371,13 @@ config MSCODE_PARSER_MBEDTLS
 
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

