Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1137CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C2E8914C;
	Fri,  4 Oct 2024 06:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IY0SI+bK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC6888D7F; Fri,  4 Oct 2024 00:04:58 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D527C88D94
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a9aec89347so93590485a.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993094; x=1728597894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4ap8kl7kPPIp9BjPt3nlYqSldtHzIqGBmfNID5Z+/Q=;
 b=IY0SI+bKwSyUgVxu/Ej717D8BXO/7y4mwVwwgWN5aRflwSrzeTt7ZOofkyfssudNOs
 Ds9NFHeD8LINeHzhSqKH215RFSudA8lyTteBI43VpHhZMQHE4t/QJ6ldZY58HBQiAGMT
 d2a+PM8y5eTBulKaOHjS4OL/he+ZK96sEKIlxeHbPrt681xm05BPO2tF3t2rwbEuTW1I
 OuoC2ZWbJ+1WC5CVn/rsDSPG5TOuQ/T7KaHbWgwoKQTMfj60UDZu2ciHdLtkGpCCXvz5
 Ji7PFZxmnLVD6QYsO9npN9SUBciyOm2mQQlZFqD6H5dsWK1I9TnlFsyFxz8N2CK6U7Uf
 nBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993094; x=1728597894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4ap8kl7kPPIp9BjPt3nlYqSldtHzIqGBmfNID5Z+/Q=;
 b=f2L2zGQUtAgquuJocMODQic8Jdk5M8e2ZxBTzo4qPrVQq6ZwH8UiQbK4eGwAoPEIA8
 mgVRRnGkGwslsWsAO0KrKlEn4GE2IkfXv1eod/jYyQ6XVWI/GH3zZ0N9N4GPjgOCg9u+
 dSSBUecmH718IIExFt15T5OC9P+Z5IS2qmx06PoaH7g/WWpBsm1LBAfXftBvdbZXk2j5
 PrK6MmbqvnfSnmypSPuatoh+lnzx2o9RtaxnDQPY2/TKEPhFjD8Cov2Dru6lNQXCmEUd
 QHBrmlFgKr+u9l8Pxg8OppFWE/RyQ0bDnF1W6f8OK2lt6KxyUeOBeNPRfx+JOhWq3VUa
 DyZg==
X-Gm-Message-State: AOJu0YzCqop+z0NPzP5PJ1O06YhrxObcF9aK/tdzx98Nai/EGrH26pig
 Eey3rfY/kUbwksdAImQ0WbgkHiDMrgoqGDNVbGEi7JwkPF40itthB70ylA5pXLOR6itjhOKMD3D
 D
X-Google-Smtp-Source: AGHT+IFFrm88f9VLZoQS/bWzF6/kLZitk02C8qu6WIZjJxAAUChrwskOkaaYv/mykpgoZWXzLuDhGQ==
X-Received: by 2002:ac8:58d0:0:b0:45d:9357:1cca with SMTP id
 d75a77b69052e-45d9ba46f56mr9843291cf.14.1727993094495; 
 Thu, 03 Oct 2024 15:04:54 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:04:54 -0700 (PDT)
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
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 25/27] asn1_decoder: add build options for ASN1 decoder
Date: Thu,  3 Oct 2024 14:50:38 -0700
Message-Id: <20241003215112.3103601-26-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v8
- None

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
index ab50ad4ebe9..d71adc3648a 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -116,12 +116,14 @@ endif # LEGACY_CRYPTO_BASIC
 
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
@@ -130,6 +132,12 @@ config LEGACY_CRYPTO_CERT
 
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
@@ -171,6 +179,13 @@ config MSCODE_PARSER_LEGACY
 
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
@@ -326,12 +341,14 @@ endif # MBEDTLS_LIB_CRYPTO
 
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
@@ -340,6 +357,12 @@ config MBEDTLS_LIB_X509
 
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
@@ -381,6 +404,13 @@ config MSCODE_PARSER_MBEDTLS
 
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
index 04d450afd82..83cb3c2fa70 100644
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

