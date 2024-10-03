Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC269CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435F98911B;
	Fri,  4 Oct 2024 06:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hK7Hvrho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2858187BF4; Fri,  4 Oct 2024 00:03:18 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEC188D94
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-45d8f781d05so14235301cf.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992993; x=1728597793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g33bt9BCdR+eNArNjlr8skVBpdilcPL72pJ6E/NWBmk=;
 b=hK7Hvrhocz+WkW3AMhSqKHn/mm2+x2CjQudmXYL9DVxgU8ffNq+LC+PBPNIWo/912n
 QzIAOINeAj4ntigIGEzMqNxfD90A/AmW1Fnp/Oqm8GyvRET2Se7ftYRAGYyJ0cM8DZ6u
 m7ZWnsFFo/V1cssvRah5rlKJqjtkoIyLZGmjIR3xeDtkqJvB7bP+PPZPzGrLyZPZwpl0
 j5htfeZz0UkNyg6gxf7sG5I1MDbnqSGC9CxwM0ABvsLmt6g9QGXtM0v+qy1TNz7Gmi9V
 60SDxMzzaJqmXJiF1DyOM3QiVs0we7oina0HLY/JDdo4/RxtV5QM3KJjwnwpxirq3boD
 WBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992993; x=1728597793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g33bt9BCdR+eNArNjlr8skVBpdilcPL72pJ6E/NWBmk=;
 b=sE7elxlpyPtoRbd/oJomCF69ETfeh+G28071qY2PA4XOc2Ujd8gJU9d/Ihi+nFkTVI
 dpYr6ENicDjINleHq3qVeoahfkw6Lna2fwPi2u+eeeyZ5bDB2Pu+26b9yB1lhgTm0bpI
 0FMN2ir7QKWtA6GHI+4rRh51CToNRLtInz02ySYcLUtJd0/V3bRSuhAktA7XegX7/izF
 mlcMZUn/8E4lNeNuB3B1pDk+81moU7DjeqWf5tjnZDXqqjHMql2Vtq/U6ScmXG15Z6w1
 F/dZnsLHrMjLUU/ZbjW9t8QCyAgsus/+SuEJBBjZK+1DgsPUMN/+x9FbQbEM8BKeU+hZ
 w0LQ==
X-Gm-Message-State: AOJu0YxXzxn+I5hHCnzERII08+mJkPWt6GXns7Of0J9Zxq1+3QZEKKrA
 FpbK/a2J3T/ANEn1y3btzK4jDjcp3+5qK41QakSKzDsa28nr27qbx8VRf2wjut+CkGBL9GNr0Kb
 X
X-Google-Smtp-Source: AGHT+IG+Rzxl1TnqEf6HAbzUla1a6OI+n8oGfYwsEZv7/3l3SH6Xm13BxX/3G1cDt7LNh9ZOHr/uIg==
X-Received: by 2002:ac8:5715:0:b0:458:2479:b599 with SMTP id
 d75a77b69052e-45d9ba7b2f0mr8480151cf.36.1727992992812; 
 Thu, 03 Oct 2024 15:03:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:03:12 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 22/27] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Thu,  3 Oct 2024 14:50:35 -0700
Message-Id: <20241003215112.3103601-23-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for mscode parser,
here to adjust the header and makefiles accordingly.
Adding _LEGACY Kconfig for legacy mscode implementation.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- Add kconfig for legacy mscode parser.
- Correct header file include directories.
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

 include/crypto/mscode.h | 4 ++++
 lib/crypto/Makefile     | 2 +-
 lib/mbedtls/Kconfig     | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 551058b96e6..678e69001b9 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -9,6 +9,10 @@
 #ifndef __UBOOT__
 #include <crypto/hash_info.h>
 #endif
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <mbedtls/asn1.h>
+#include <mbedtls/oid.h>
+#endif
 
 struct pefile_context {
 #ifndef __UBOOT__
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 7129315393f..3caa45dc2a8 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 #
 # Signed PE binary-wrapped key handling
 #
-obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
+obj-$(CONFIG_$(SPL_)MSCODE_PARSER_LEGACY) += mscode.o
 
 mscode-y := \
 	mscode_parser.o \
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index fd7263f9616..efeaed50385 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -120,6 +120,7 @@ config LEGACY_CRYPTO_CERT
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -150,6 +151,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
 	  This option chooses legacy certificate library for PKCS7 message
 	  parser.
 
+config MSCODE_PARSER_LEGACY
+	bool "MS authenticode parser with legacy certificate library"
+	depends on LEGACY_CRYPTO_CERT && MSCODE_PARSER
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for MS authenticode
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
-- 
2.25.1

