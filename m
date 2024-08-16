Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE8C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 21:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFBA288C50;
	Fri, 16 Aug 2024 23:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mytihsyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3611C88C59; Fri, 16 Aug 2024 23:53:50 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1083F88498
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6aef423f80aso23242737b3.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845223; x=1724450023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ij2Vgv6xSmf3owDJNtY7mL/UClyFTZTxXeQD8V7eKuw=;
 b=mytihsyql3QxSZN8vvRWbk4EreadVoPhpghKbrGf5YL2N6Hyve22jMM8/ozZPVKJIo
 1hzIpn7VbbujI20CO/VF3aFSTxsEdyf1Jm8pxftEtNfDObp4SO1uvZ5qkhO2T6E85L9U
 6qt75QGemrHoPsgrqcg5no3BHydTKmdmBrLfElcAM53pLbIzvhRsM00IF0mTcmw3gPiG
 s03ufhmKL7sGieHlHdlzSd6KCP9yFSaA/zJT7bmjQEuIbvGBL0YSdyCq1DZog1XZR+j5
 LF5TPWJ5kGS1faLnFn90Ptjkp0q8Z11Xt6gcRgKXiqLRK6HPalIVgyi6oJ/qyDNQxYOC
 rNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845223; x=1724450023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ij2Vgv6xSmf3owDJNtY7mL/UClyFTZTxXeQD8V7eKuw=;
 b=AeGOvav319uslXhQLQPc/0b1+B2htYci2j23fx0gJ2j+06uSz8cHwqjY6l2hJqaqjz
 A3rG10YekN1D9ieNnm0BXjonIf6L2Kg+J1TNmWRAOhR3+9HmNE8ozpRNmAQ+Wzppn7dp
 F+W+y6/a2WpVJjBdz1cOt5qrJfTmd+X7D7nr4Z1xqfpbnNskePnXwNQQJvXvki9gbYRV
 YMhzEUcLuW7/LPnFZH3npLE89RT+77o79zubqm2xIV1W+2HCx6W93iYZa4hnLW1pzqQ4
 OfKfUwP7/Ho3h/d/LO2EbiAgHlJFYyAnbBGA8iOfL+ZzWllfh1H32FiA20MBwXPmnV7y
 YUZg==
X-Gm-Message-State: AOJu0YwYYk8Rrmn3c27Jk8V3XnKkaw0/b4xegW0SYT3FUNBu8LhhUy0A
 tx6ulH8Y8Bfy9fWAIZiu87Wo/Hl80FEu7CspMcWcc0Xje6qTkO3iIGIWogFHbtzx+WhIYQ0d3HH
 7eTo=
X-Google-Smtp-Source: AGHT+IHLLh1XtxBKPuEOr+ua3xJJ0J1a5M57lOUnRQoY4iW3Md1i2p6qE/CiJEVNIhxIF0CNMLfM9g==
X-Received: by 2002:a05:690c:2706:b0:647:88ba:f91b with SMTP id
 00721157ae682-6b1b805084dmr41810667b3.11.1723845223579; 
 Fri, 16 Aug 2024 14:53:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:53:43 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 23/28] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Fri, 16 Aug 2024 14:44:12 -0700
Message-Id: <20240816214436.1877263-24-raymond.mao@linaro.org>
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
index f03fb752d3f..ecdf4d3008f 100644
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

