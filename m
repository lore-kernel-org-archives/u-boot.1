Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A340C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 15:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2E482D21;
	Fri, 20 Jun 2025 17:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KQFEP/X8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F92680E9A; Fri, 20 Jun 2025 17:10:49 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB5882DBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6fb0a05b56cso40315836d6.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750432245; x=1751037045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naN9n4mnV2DwSuSXps7XR0edESNGhZpRS5iI6bm47Zs=;
 b=KQFEP/X8EvU+WtARRUIkVZSfOPOpwmFMZ/+K7VOpbDuXLZlM6M567DZoMERquSU7Dh
 rN3rddk2noPjg3YphgsI7UzW02S0b5JaJQ0j3psmwHTK2I6w4nU/ca+qoPhdEqodOcqd
 gEh6KIUMRxZXJIp3Pa5kMsf6HZgXcrnXlRFjotSQ1LJwjbgIn6YP2lpsmTtefkGwQHUH
 ox+WYsffjY1wjVpTA93yaMFoqM0tjQSm/QXnuwP1JRn46ZpGO4d5YRp3xe8Nkk1oe/RU
 UYYTrJhzcD5ah4bs+x/SGdHD/12+w3uMIWaMVbhgmxjCm+2IapMoLR0yq5Qx05tKq/3w
 erLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750432245; x=1751037045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naN9n4mnV2DwSuSXps7XR0edESNGhZpRS5iI6bm47Zs=;
 b=fhZh9PJwmFscu42XxU7HQnyo53kL2x0qGG19KyN3xrthQ8tBKzegASuG4PUBOfYmPI
 y8XKIXpKEumr7IYfSTXcCU+lPHtLCxEH2v6hgwCFstklqJ20dwYbeRdRMKSjDK3A2BR0
 /0cgLwy2CU2ar2GfxJy9yycFLolki+UvSLjynugGKancVjFYuGIPyZxsBn87t4VFASDg
 Jbm76MViZKJ0Rozf+ChpJx4zEvmBHU0qZxTwq8eiwGP1gsgpe3Mjnzapwi66loPRgAnN
 7Lm1E93+CmdLxon46UsxB2o2AZcxpjRdDMyt/gYWTl5Vemc34hSF3oTAUueloH4xGpYl
 ek1A==
X-Gm-Message-State: AOJu0YzUOCbisCIwcNgVT1wNMIkXEtRlS3kxxswNqdxn4wTwZyyTZlom
 WpUsNSImrg3sqUr5l0i/czaksdubakgXabBO4F1FAOAC+TShT6ZEmXkn3VJeB5jg18WVNELW3YK
 ElDPN
X-Gm-Gg: ASbGncs4YdGoz+FZbtb6vMQNFDLqd2omEnNF2A+q2gQG8ZUbgHGS90TYyM70ZDLWmSQ
 61lhyyCyCvOHwRUwwAryABEFKjFtf94XTVeXVvpYBz9J96UWfi+/yOEMRJmGUbkERdk49rNu3Qv
 N9mKc8CI/tzCP54mv3evRoG45lQNDYZ5T8BLlLL90iA+VxKflQCZZzDBz/IbBJOQZTe5vdsuRgX
 0AqVahoPfVpw9+qilwo6r/qH4Xz74xmR9eKqVthTmS1rdH26C2ppzkVIkHTOZjCSfkEAikrdBFe
 WvuDZdDLDQ9NGGyDjoVboKbAGtItjoG4hXJBNqQspjPzouC7/bLqWmJmnElCP3/xLLQYTw7MQYo
 DKiGCawQAlsBj7zUfyIUSUITLcyckuf74pgrNV2LUAkNUEmU=
X-Google-Smtp-Source: AGHT+IHvz4DjQr8uJj7FDyALBzOt8DYnnjQ6lUXv8VYcx39tH8Qyf/1dXbrEpnfOXbGLZHvTcrtt3w==
X-Received: by 2002:a05:6214:cc1:b0:6fb:4e9a:663d with SMTP id
 6a1803df08f44-6fd0a4c1508mr55997376d6.17.1750432244693; 
 Fri, 20 Jun 2025 08:10:44 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3f99fc0a8sm99405085a.80.2025.06.20.08.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 08:10:44 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 2/3] mbedtls: Add compiler-rt subset into the MbedTLS build
Date: Fri, 20 Jun 2025 08:10:09 -0700
Message-Id: <20250620151021.2711542-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250620151021.2711542-1-raymond.mao@linaro.org>
References: <20250620151021.2711542-1-raymond.mao@linaro.org>
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

Add compiler-rt subset into the MbedTLS build for Clang to solve the
link error due to missing '__udivti3' when RSA_PUBLIC_KEY_PARSER_MBEDTLS
is selected.

Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/Makefile                                  | 10 ++++++++++
 lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..80cccf13d5f 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,16 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# Clang compiler-rt
+ifdef CONFIG_CC_IS_CLANG
+# Built-in macros for int128 or 64bit target will enable CRT_HAS_128BIT
+CLANG_RT_LIB_DIR = port/compiler-rt/lib/builtins
+obj-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
+	$(CLANG_RT_LIB_DIR)/udivti3.o
+obj-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
+	$(CLANG_RT_LIB_DIR)/udivmodti4.o
+endif
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h b/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
index 48862f36421..6f290574c1f 100644
--- a/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
+++ b/lib/mbedtls/port/compiler-rt/lib/builtins/int_types.h
@@ -16,6 +16,7 @@
 #ifndef INT_TYPES_H
 #define INT_TYPES_H
 
+#include <linux/types.h>
 #include "int_endianness.h"
 
 // si_int is defined in Linux sysroot's asm-generic/siginfo.h
-- 
2.25.1

