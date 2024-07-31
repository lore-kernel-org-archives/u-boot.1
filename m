Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A7AC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5149888A08;
	Wed, 31 Jul 2024 19:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QE48k1KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F9D8841E; Wed, 31 Jul 2024 19:34:25 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0959488ABE
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a1dd2004e1so377598385a.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447262; x=1723052062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fko0igODnehceTLNa33JhTcaJ0RcH6q0aW3gGT7IO60=;
 b=QE48k1KIr0DKTASd7ZdRNozCTz48npt+/iei4kHcn7b8iunmC3nkeFuPVme9HDDao3
 xv8YUR1Q7IUFN66MRm9krZHAkm8QWf8XY44nC/e4n/L9k+guxPMAPguvaCpAHV0uC/p6
 wf1ujvNI4WIacuukMhedupgwJeqksuyLf/L9t/CQJF/PmZh0EVHeWVlmUMsjwF7h5HKF
 boxY3BV18iGUirERCiA2Ga9sKWeddOJ8XjN69ivAIj901lQsy2xZUACZ9YnGOcAD+v6y
 GDaEK7luQV5A/ivglj9BmOUnWF86Ukro4c4QEwAZkNDVpJQk2+vKYZRFCH09v2n2Xi8x
 gLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447262; x=1723052062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fko0igODnehceTLNa33JhTcaJ0RcH6q0aW3gGT7IO60=;
 b=SyKDDsUwhJjXF02dyu0K7BYgosn5Hhx2HgaLOpnmvBeJtY4YfWeqQ8Sa70oDG1hSzI
 D1GlhAtMRXQkfOWpWCzVVPyOjvb5WxG9vOVhyhxIagk5GfU79GWgwcElpyhtRB5m9LUc
 ru0EeIE2apFNClRzm1EPYyS2cwbK/sPA4VeKA8X/k7xF6BqQlk6yyvJS3NVaZVrFD/Ty
 UdURl+rNNOh+0UOxfojtSgeTbkTrjtcnZ5RWbmvVyTfK1F29L/DNH+bLZ60KO6TvQdUb
 rYjCDRSPoPX5TJrM7AjMf5xpecAtMtFzGSpLmTblkm72w9yyDVFGqj+1bcMmXEZrgajY
 qnyw==
X-Gm-Message-State: AOJu0Yy+sKpiRJ1oGyab9ttEjhaTy+zcIfOZHrkstB1vj5TpPK+Cp3JA
 JGaQqep0sw/5YAPoLVJqysrK0gui/sYUdZw4eEPCzpnbzzOzUzeDq+7IAEYG2++JnwW9C9YUjAr
 7dqo=
X-Google-Smtp-Source: AGHT+IExusBnTaqvUHyftlA+hJMdue+TMOPL5Dh8hFmVD7RYYMlmkhEmVfwVQjU7j4n6Q+aYRUOqsg==
X-Received: by 2002:a05:620a:430e:b0:7a1:e9f9:d4fa with SMTP id
 af79cd13be357-7a1e9f9d8b9mr1469698785a.31.1722447261714; 
 Wed, 31 Jul 2024 10:34:21 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:34:21 -0700 (PDT)
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
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 22/27] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Wed, 31 Jul 2024 10:25:32 -0700
Message-Id: <20240731172556.1348487-23-raymond.mao@linaro.org>
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
index a80e996fe90..436fd7d1f94 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -121,6 +121,7 @@ config LEGACY_CRYPTO_CERT
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
+	select MSCODE_PARSER_LEGACY if MSCODE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -151,6 +152,14 @@ config PKCS7_MESSAGE_PARSER_LEGACY
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

