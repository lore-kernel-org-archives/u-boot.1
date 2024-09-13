Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093A2FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1136488E41;
	Sat, 14 Sep 2024 03:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D7ctFR4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B9288706; Fri, 13 Sep 2024 18:14:35 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D43788B27
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so18592026d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244072; x=1726848872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9LygqglF0ThxTYqVdMNTM1skkdSKM9+b3v5KJ+3abY=;
 b=D7ctFR4gm7z6fgWf3JIpLp6SMskpAUlD76lNOK9HoRabh8uAOCKo+ma7w4nnd4gN1r
 ntQbZTMafRjGTpxTWPe26JcMu3ISUBIIqizz5cWJvfpuzW+es2HouBCepxtWCYrJV0GU
 6AAWWRaEV/UCYP9gPb0h0KVxvJIC4vzm05eufwnoiZ7Tg22eXIF64jDJk8RXOzwN3Z2V
 NDmBsm8R2ltO++a2OAijQgbD+eHnaJweu2N0IWDIoU0SFshRmBjynmV0AFBi9x6BJz5B
 DVh41MTEMXUqr37vX3bMN5OBmtPx4xL5GrTyRmVhcLUJLmVB9arqo6sSeINlRludfU+N
 ax1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244072; x=1726848872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9LygqglF0ThxTYqVdMNTM1skkdSKM9+b3v5KJ+3abY=;
 b=apuwEtnp9SrXy6CfTeTV+zKqSHMrXSp/TZJ/waLapAe1GjuVI2Wj7cLpSobayMFJ+A
 q7Sr8lRrWw91a6+CM9nwCgyVnhNKkrMva5zOXXM6SKG7vwbCjrEd+tlX3kf6nGSbfBWq
 pKXwfoutMnOXFYxGXSMuBwRsUFYFBk+TETJoR7wzURb6D5q9atncTzSo0CxCzZt2cp80
 DDPUjfnEgTPVAM9csFBraS4/YtUYzUsZZSkuZC+7Tm3MuX5cTgHpWkrWTxuNrOU/YE06
 GPmykYtztTb0zMv1gaptE9OhLvwqd/xyMuvvrynFy3f92MvhCZefiKgSzEgF35xvvjbi
 l+YA==
X-Gm-Message-State: AOJu0YyezbfZlY7Ags/dmLRTUfSN5Iiz3iRlkTpVgyqnPG1/Lvs+4+gh
 w3kbIBbOCA/cG90Y85/78xcpQzCX3v4EMBiZy/CGvfeZkc62RCSbCNUx/mh9Xu+LI7DdGEcx+W7
 m
X-Google-Smtp-Source: AGHT+IGNR6Tdi94z7VRB4EItqygjktzsk/On1+72aZv6Iq/yQenxiuYfUSdCBW/87yUPtTEkZVzy5g==
X-Received: by 2002:a0c:f40e:0:b0:6c5:3b71:c7b4 with SMTP id
 6a1803df08f44-6c573803c2amr80519886d6.53.1726244072105; 
 Fri, 13 Sep 2024 09:14:32 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:14:31 -0700 (PDT)
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
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 22/27] lib/crypto: Adapt mscode_parser to MbedTLS
Date: Fri, 13 Sep 2024 09:03:39 -0700
Message-Id: <20240913160408.2199558-23-raymond.mao@linaro.org>
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
index e6139eb8f8b..f60bb140bd9 100644
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

