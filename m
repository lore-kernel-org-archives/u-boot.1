Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 20:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B734987525;
	Thu,  9 Nov 2023 21:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rsC+rQtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6180787525; Thu,  9 Nov 2023 21:13:17 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE52871A7
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 21:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-586753b0ab0so689538eaf.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699560794; x=1700165594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXvW2Lc4CJfK/DIMKay0qe116EfhDSfaf1gzrazqpBU=;
 b=rsC+rQtBUpomGpIjBn7beX6i4hktvzip7WTOpNuK4OKM9OMwxaBcED31frWMYClCcu
 6cyfynjEkvF/91lrRr8XPus3kTsABCXiDD825xYj3b/Nb4TAFBHjzrsPV1R8ynyh73r1
 XyRG03w2CxXIRUF1WOOMBWv+IUapMiEpR/k0hOtDCD1FNmvkgGRaPfvm+fCVuo4z+qci
 bFT+nI672mXdbgcNY6Ro5RHjJYMPIIOmUABk3NCRpq4/bgazJQJaCO6u4STZIGsbvd2d
 5eCSfVKK+EdvNwQ1n2tIKAZ/a8p4NWoxlAc3O2Ch05TCGqP+6b6BVqRlZwDpPfntu/DO
 j8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699560794; x=1700165594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXvW2Lc4CJfK/DIMKay0qe116EfhDSfaf1gzrazqpBU=;
 b=kGRjNk+2Uv7lwq+rCKbeRxs3jcvvcpzCkJMpHkL8ZXB1k0nm794dF2jYJZmfFmkkuz
 n5xXHfFm98TR0S+5fLMkhBCu1p8FQXA0u5KUxRl438AMQiUwJ70N1xsMRvEEQXI18ocd
 PKcd4P94/fypIiDZUVmJpw8fJ7EqMr7h+3oO86Rhpn+1JNmLelcDr6wohZrALrWh1MFl
 RUZtxPKGesI1L5NcTBX8sAAenoJ0RslPIJqkG1Hst5Yf2+kz5yWJtlnnlnDXO/X1rafg
 SHynkUCiXa6MO5AEOZtfgb5GqarZlL97SXDkp3IZuNBqwAUtyIjJynxg59Jem832GzN0
 vT6Q==
X-Gm-Message-State: AOJu0YyNtqKoTaLuIrmDhht51QlSygduOE3wgxn2Lbb8cyNcmeMPj1wG
 GV03OrvROatpcYYNtNyRJMynMA==
X-Google-Smtp-Source: AGHT+IE/Wa7V1MNqxF+ilj2TBqVJkon3eGBCYvcmW1+heSJhSNmKVXmZIJi1gHpmyLLt4TUX6ulnsQ==
X-Received: by 2002:a4a:dd97:0:b0:581:d922:e7f3 with SMTP id
 h23-20020a4add97000000b00581d922e7f3mr5622177oov.9.1699560793841; 
 Thu, 09 Nov 2023 12:13:13 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 u1-20020a4a8c01000000b00584078d1e17sm882015ooj.45.2023.11.09.12.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 12:13:13 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] board: samsung: Fix SYS_CONFIG_NAME configs in
 axy17lte Kconfig
Date: Thu,  9 Nov 2023 14:13:12 -0600
Message-Id: <20231109201313.29791-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

There is a couple of issues related to SYS_CONFIG_NAME config in
axy17lte Kconfig.

1. The global SYS_CONFIG_NAME in axy17lte Kconfig overrides
   SYS_CONFIG_NAME for all boards specified after this line in
   arch/arm/mach-exynos/Kconfig:

       source "board/samsung/axy17lte/Kconfig"

   Right now it's the last 'source' line there, so the issue is not
   reproducible. But once some board is moved or added after this line
   the next build error will happen:

       GEN     include/autoconf.mk.dep
     In file included from ./include/common.h:16:
     include/config.h:3:10: fatal error: configs/exynos78x0-common.h.h:
                            No such file or directory
         3 | #include <configs/exynos78x0-common.h.h>
           |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     compilation terminated.

   That's happening because axy17lte Kconfig defines SYS_CONFIG_NAME
   option in global namespace (not guarded with any "if TARGET_..."), so
   it basically rewrites the correct SYS_CONFIG_NAME defined in the
   hypothetical boards which might appear after axy17lte in mach-exynos
   Kconfig.

2. Another side of the issue is that SYS_CONFIG_NAME is defined
   incorrectly in axy17lte Kconfig:

       config SYS_CONFIG_NAME
           default "exynos78x0-common.h"

   The .h extension should not have been specified there. It's leading
   to a build error, as the generated include file has a double '.h'
   extension.

3. Each target in axy17lte/Kconfig defines its own SYS_CONFIG_NAME. But
   all of those in fact incorrect, as corresponding
   include/configs/<CONFIG_SYS_CONFIG_NAME>.h header files don't exist.

4. The global SYS_CONFIG_NAME pretty much repeats the help description
   from arch/Kconfig and doc/README.kconfig.

Corresponding defconfig files (a*y17lte_defconfig) fix above issues by
overriding SYS_CONFIG_NAME and correctly setting it to
"exynos78x0-common".

Fix all mentioned issues by removing the incorrect global
SYS_CONFIG_NAME and instead specifying it (correctly) in SYS_CONFIG_NAME
options for each target instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 3e2095e960b4 ("board: samsung: add support for Galaxy A series of 2017 (a5y17lte)")
---
Changes in v2:
  - Don't just remove global SYS_CONFIG_NAME, also fix SYS_CONFIG_NAME
    for each target in Kconfig

 board/samsung/axy17lte/Kconfig | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kconfig
index a018547ff5d4..64a4ffa7e673 100644
--- a/board/samsung/axy17lte/Kconfig
+++ b/board/samsung/axy17lte/Kconfig
@@ -1,11 +1,3 @@
-config SYS_CONFIG_NAME
-	string "Board configuration name"
-	default "exynos78x0-common.h"
-	help
-	  This option contains information about board configuration name.
-	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
-	  will be used for board configuration.
-
 if TARGET_A5Y17LTE
 config SYS_BOARD
 	default "axy17lte"
@@ -16,7 +8,7 @@ config SYS_VENDOR
 	default "samsung"
 
 config SYS_CONFIG_NAME
-	default "a5y17lte"
+	default "exynos78x0-common"
 
 config EXYNOS7880
     bool "Exynos 7880 SOC support"
@@ -33,7 +25,7 @@ config SYS_VENDOR
 	default "samsung"
 
 config SYS_CONFIG_NAME
-	default "a5y17lte"
+	default "exynos78x0-common"
 
 config EXYNOS7880
     bool "Exynos 7880 SOC support"
@@ -50,7 +42,7 @@ config SYS_VENDOR
 	default "samsung"
 
 config SYS_CONFIG_NAME
-	default "a3y17lte"
+	default "exynos78x0-common"
 
 config EXYNOS7870
     bool "Exynos 7870 SOC support"
-- 
2.39.2

