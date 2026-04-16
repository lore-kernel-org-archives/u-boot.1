Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE1AF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2DB844A9;
	Fri, 17 Apr 2026 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OcP5xTwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452D8840AB; Thu, 16 Apr 2026 17:20:30 +0200 (CEST)
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com
 [IPv6:2607:f8b0:4864:20::941])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA2A841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-ua1-x941.google.com with SMTP id
 a1e0cc1a2514c-953c5738c03so4748305241.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352826; x=1776957626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgTY18106HCDboHbRKsQ2fd+yy0O5m6itO7CRJOaFm0=;
 b=OcP5xTwMEgMkJ6XB4TJbb3REdABfaMUtcJPgJK9SgdyJ/VeN0Z7DHF7gg2V6RO3wsc
 sCCaDI9KTb5V5aZqu98OnrrbhMQW122Ex6s/h+rdzGqa/1/sLnmkv0OhOcCJExVx715O
 Eo/svgQMJhHmIACb2+/ov9jxefUUu9cQdR2aXnWu2xSCk+WTDktWZBg9aUH5GMCdnr8b
 aCGKiiIG6wvOxOfLvlng0zBep+O29tlQ4VRLMBWRn+13P92WfAY4ftfa2CUyddL0EIVP
 1NwP/ZHw+mvg9bxICvvXEFQolv055a+ke6JQGzne4rLN+jBQg7I1PIlAU2YLcjn/kBfF
 Qn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352826; x=1776957626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hgTY18106HCDboHbRKsQ2fd+yy0O5m6itO7CRJOaFm0=;
 b=ruYzMms06PClo2LTq0uo6hDaYuCXdKBNBuFbMlWqbai7OGZAqx1Wu2kjfRE90NuYxL
 56liA7KfTl17lCr/OWA4cl/OS/LiYLa3aDFtozw+Wib8CrdQVDqb2AV3I6VoC4FxLhCW
 JpPS3QuRyKis1BnMNz0BOJnZhiIKF7RDwGj1DBwCEARq7OX1B0Fk0wgaUL3TNCLD35CG
 OZukNuzjMSMX+q6rLb0zUJDlxQoBXxcTc008/gn48Xy4N1CxhxJ0IaJjXf/gGXlu8a2D
 uiHYB7erovbEGeML0bNS8JXcYRhx2haVkPDs8LjBeyrZR2Xi76GInNii4TUdsEkXUMcF
 yTmQ==
X-Gm-Message-State: AOJu0YxkUStFg0hEPPpfyfKJShNphtxdliBhG0EyxtfYAy+i8Fc+Tbt1
 Wy1icuNxXd3oqK+bCOcOGFYOi/rL/UNhQEczIdfvePRLTK3rijs7L9R51rV1K8fi
X-Gm-Gg: AeBDiesAe+LuGiOjTI+aJSd64e1UTY39ZtmZhSvK+8TfVmObrmbMeH7J7sZ4LExU4lI
 ZM7x84qPd2y56uUFqU1oiJHbJPZ9ca0oj++Q6lNXWCBRDGf7chO5bAOMsrQHSyBmC3S1Hox5r6f
 aM7fL1mov11H6p3zXs6HjMUeyFINYxZd8J2vRVJuS26uIONCR5YxvDOgQXQ/XH0WFD/lZ4CBWQn
 bo7RW9UOlsISiu73wH3BAUE9w/r6aaYZqCd5TyLNDVISQ6IXxn7jjYPFZxJG7UhcQehBwACdIjQ
 7YqjF0RxsPpf4eSWsU9Yp/D0cfx5nhoIqWqpoesbHwdBxe66pe9cEAKiVpDx0KxIWVdvD4WfKDj
 LJX7t0CZTLFuVJRUCw/+Mb1fcbx3Fjx4LZRrDW6yKZhw0o74YW/kXEf2ufBGjAAVdVWAhABu8pb
 MBkroPH5SOuu9ppiLPkV/SbUBjkFwQDtF9BqkxDFJxzV++
X-Received: by 2002:a05:6102:32d3:b0:604:f029:224c with SMTP id
 ada2fe7eead31-609ff2c36cbmr12689202137.8.1776352826411; 
 Thu, 16 Apr 2026 08:20:26 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:26 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [RESEND v4 12/14] arm: sc5xx: Remove SC5XX_LOADADDR
Date: Thu, 16 Apr 2026 11:19:47 -0400
Message-Id: <5255631b1c9316fcc36273a70e19a65cba0c95d1.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

SC5XX_LOADADDR was an ADI-specific duplicate of standard U-Boot
load address handling. U-Boot already uses CONFIG_SYS_LOAD_ADDR
for the default load address and `loadaddr` for boot commands,
so keeping separate SC5XX-specific names is redundant.

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig                    |  6 ------
 board/adi/sc573-ezlite/sc573-ezlite.env        |  3 ---
 board/adi/sc584-ezkit/sc584-ezkit.env          |  3 ---
 board/adi/sc589-ezkit/sc589-ezkit.env          |  3 ---
 board/adi/sc589-mini/sc589-mini.env            |  3 ---
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env  |  3 ---
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env  |  3 ---
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env  |  3 ---
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env  |  3 ---
 configs/sc573-ezlite_defconfig                 |  2 +-
 configs/sc584-ezkit_defconfig                  |  2 +-
 configs/sc589-ezkit_defconfig                  |  2 +-
 configs/sc589-mini_defconfig                   |  2 +-
 configs/sc594-som-ezkit-spl_defconfig          |  2 +-
 configs/sc594-som-ezlite-spl_defconfig         |  2 +-
 configs/sc598-som-ezkit-spl_defconfig          |  2 +-
 configs/sc598-som-ezlite-spl_defconfig         |  2 +-
 include/env/adi/adi_boot.env                   | 18 +++++++++++-------
 18 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index e311a8adf9a..44402b2568d 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -140,12 +140,6 @@ config SC5XX_ROOTFS_OFFSET
 	help
 	  The default offset where the rootfs is located.
 
-config SC5XX_LOADADDR
-	hex "Load address"
-	default 0x90000000
-	help
-	  The default load address for u-boot.
-
 config ADI_IMAGE
 	string "ADI fitImage type"
 	help
diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index c909b3b476a..ab1acabef53 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 1090d2731a5..740b7b554cb 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 02567830c16..00f90c7942e 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_RAM
 #define USE_MMC
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 661c130b835..13079ed7527 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_RAM
 #define USE_SPI
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index f787d972339..324bfae4571 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 9db35ac8d59..bdbfaf0dabe 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index f787d972339..324bfae4571 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,9 +3,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index d5364df1613..c7d7932064a 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,7 +3,4 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #include <env/adi/adi_boot.env>
diff --git a/configs/sc573-ezlite_defconfig b/configs/sc573-ezlite_defconfig
index f6305451c27..cbf24234cc3 100644
--- a/configs/sc573-ezlite_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
-CONFIG_SC5XX_LOADADDR=0x83000000
+CONFIG_SYS_LOAD_ADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 52ab7c9337b..bb24b31b2c0 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,7 +10,7 @@ CONFIG_SPL_STACK=0x200C0000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_LOADADDR=0x89300000
+CONFIG_SYS_LOAD_ADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index d8982f62d82..d3f0380bfed 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -13,7 +13,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_EZKIT=y
-CONFIG_SC5XX_LOADADDR=0xC3000000
+CONFIG_SYS_LOAD_ADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 78b39b6dd73..1bdede4b739 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -12,7 +12,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_MINI=y
-CONFIG_SC5XX_LOADADDR=0xC3000000
+CONFIG_SYS_LOAD_ADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 23951d0b5f1..4f8be110ee4 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
 CONFIG_SC59X=y
 CONFIG_TARGET_SC594_SOM_EZKIT=y
+CONFIG_SYS_LOAD_ADDR=0xA2000000
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
@@ -74,4 +75,3 @@ CONFIG_SPL_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
-CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index b4e71b5d2eb..c045c67569b 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200E4000
 CONFIG_SC59X=y
+CONFIG_SYS_LOAD_ADDR=0xA2000000
 CONFIG_CGU1_DIV_S1SELEX=16
 CONFIG_CDU0_CLKO10=5
 CONFIG_SF_DEFAULT_BUS=0
@@ -83,4 +84,3 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index ea1e0b6202c..3c22ee299b9 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -11,6 +11,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SC59X_64=y
 CONFIG_TARGET_SC598_SOM_EZKIT=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x90000000
 CONFIG_CGU1_PLL3_DDRCLK=y
 CONFIG_CGU1_PLL3_VCO_MSEL=64
 CONFIG_CGU1_PLL3_DCLK_DIV=2
@@ -108,4 +109,3 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 0b47f6febba..d93ed06f65e 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -11,6 +11,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200E4000
 CONFIG_SC59X_64=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x90000000
 CONFIG_CGU1_PLL3_DDRCLK=y
 CONFIG_CGU1_PLL3_VCO_MSEL=64
 CONFIG_CGU1_PLL3_DCLK_DIV=2
@@ -106,4 +107,3 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 046f4f8a410..abf7726ab94 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -2,7 +2,6 @@
  * A target board needs to set these variables for the commands below to work:
  *
  * - adi_image_offset, location of the fitImage on the SPI flash
- * - loadaddr, where you want to load things
  */
 
 #ifdef CONFIG_SC59X_64
@@ -21,6 +20,11 @@ initrd_high=0xffffffffffffffff
 #else
 initrd_high=0xffffffff
 #endif
+#if defined(CONFIG_SC59X) || defined(CONFIG_SC59X_64)
+adi_image_offset=0x100000
+#else
+adi_image_offset=0xd0000
+#endif
 
 /* Args for each boot mode */
 adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
@@ -35,7 +39,7 @@ nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfs
 nfsboot= run nfsargs;
 	run addip;
 	wget ${loadaddr} ${serverip}:/fitImage;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_MMC)
@@ -43,7 +47,7 @@ mmcargs=setenv bootargs root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait ${adi_bo
 mmcboot=mmc rescan;
 	ext4load mmc 0:1 ${loadaddr} /fitImage;
 	run mmcargs;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_SPI)
@@ -51,7 +55,7 @@ spiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_boo
 spiboot=run spiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_OSPI)
@@ -59,18 +63,18 @@ ospiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bo
 ospiboot=run ospiargs;
 	sf probe ${sfdev};
 	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_RAM)
 ramboot= wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_USB)
 usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
 usbboot=usb start;
 	ext4load usb 0:1 ${loadaddr} /fitImage; run usbargs;
-	bootm ${loadaddr}
+	bootm
 #endif
-- 
2.34.1

