Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEF910F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBC583FE9;
	Fri, 27 Mar 2026 17:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ivHyF/vS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B7E83F14; Fri, 27 Mar 2026 14:52:07 +0100 (CET)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30A683C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-899fac9caabso25633096d6.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619522; x=1775224322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKHPmFog7lSlLPkQmErWeyuLdzDtxJZAJJsxWMWXvTo=;
 b=ivHyF/vSFNSIIl9cSEHMfBlyuLCRtFBe9lUmdUhPOJt7APhgE6Bv4V1/bRoC+y8jRW
 vduf3PxvoShHnE8uztuzqMYQrOzCptRYo68KQPO4uNLS7QkpJBJ+0SDpzCmSxaxkzxDB
 K61kAnOyetThtOSqUpA9lNXvG1VjctkQ+ZJkCmJFlVgdGxpMyAk16RvcYyf+4DcWIIzj
 D7v5Ao3dQySPiuNHx9bocph61hIM35oiBTp1LK0NstZTBQto23I1WdQfqrme/6LYhXxD
 snQXF4Ca1wXMI86xSX680sEr9RS55c/vdgpomdZmPhB9Bkz1n5/3iRVFQiYtb/5XjEYR
 7YCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619522; x=1775224322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wKHPmFog7lSlLPkQmErWeyuLdzDtxJZAJJsxWMWXvTo=;
 b=XTMnGEiwia2VWkFJ8wM7Pf59dtHSuUIcr/PSYHEkX1QinVKI8iLqUw7P+76jAp70v6
 OnRh16EqT9z43GrEqQtfiIv+qOJ9QeJ5G0QPAToTU2HcvqDBTLFIPJMN0u9iRGjR212B
 adptLYc/qeCGrqCDRMZdqNMB7RAti1uhZGfp/xfWozQCgwKZnGjHJc2wZelztRlcrWTA
 EllasPN/hi1zkJAjS0PT1I6kyLbw7pcbrRKn6AeGg/JsfhZPpWp68Qwu6KMxr/SfwtEI
 IMtjnA3MAfbcR/RiuqX0/egJpTy+MDqeuvfDExaI78IiYTbP1TVAjc08EFIYpysEZvo3
 szwQ==
X-Gm-Message-State: AOJu0YyItTOvNEmcJHe1P9WUA2qTIstM7F1cQyChSkePkXHBkEkG9N/5
 P5qh4oRHSAPKQU2wz8/ODsp3BIuRCGw986y7oJFWvngal+T/h4DiZ4JlUJU/CBqA
X-Gm-Gg: ATEYQzx1w7iKowWvq1p2x1Yt5sLSAqqtVXsTazmv+Clq3pyykFj5/clGgeyodFKAqHN
 vwVwIqut8UePeTa6NVPSxkirIJfGU5m8FCcNI3WhlISCMf2x6Rc9dUS8ZWx+PRu7DJv2kkIOEgF
 ooOwcFYmq25GLqffms4+H2ouc1iwqAULIZ+MviV//VkhR0IvlrTvqtXROucn2bxl2d+QibgPZwf
 GLWleF1vjwkfQC8NBBm4wnE7Mn9Nens2fpxaBIEYfnFprvyAPJ1fyYjUpLC1f2YnRU+GIF9r2/F
 GR61K8EdE/E6Qkv6rB6IJYW3/9Ubya8O/Nh3YIS40k7a8jm/jzikTSIGX1XcGYJYD/WTa2SSrq2
 3/DStRG4fXHZzB5FGZWHMO13WuI8/mgNnnTAaspqbWelEa8AYHzjIakBAmiFcwiA5q/X/H+4kP7
 2HOaxuYjtfUnb9V59dESuiezFJRX1YYpOfFA==
X-Received: by 2002:a05:6214:451e:b0:89c:cf63:437b with SMTP id
 6a1803df08f44-89ce8d9e1fdmr35000026d6.18.1774619521647; 
 Fri, 27 Mar 2026 06:52:01 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:52:01 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v2 12/13] arm: sc5xx: remove LOADADDR and use kernel_addr_r
Date: Fri, 27 Mar 2026 09:49:27 -0400
Message-Id: <2f99f5a27a203e6cfe1ae93a1f735dcf66ab6a94.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774618658.git.jcethrid@gmail.com>
References: <cover.1774618658.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

Remove the SC5XX_LOADADDR Kconfig option, replace its users with
CONFIG_SYS_LOAD_ADDR, and update the ADI boot environment to use
`kernel_addr_r`.

SC5XX_LOADADDR and the corresponding `loadaddr` usage were ADI-specific
duplicates of standard U-Boot load address handling. U-Boot already uses
CONFIG_SYS_LOAD_ADDR for the default load address and `kernel_addr_r`
for boot commands, so keeping separate SC5XX-specific names is
redundant.

Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig                   |  6 ----
 board/adi/sc573-ezlite/sc573-ezlite.env       |  3 --
 board/adi/sc584-ezkit/sc584-ezkit.env         |  3 --
 board/adi/sc589-ezkit/sc589-ezkit.env         |  3 --
 board/adi/sc589-mini/sc589-mini.env           |  3 --
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  3 --
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  3 --
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  3 --
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  3 --
 configs/sc573-ezlite_defconfig                |  2 +-
 configs/sc584-ezkit_defconfig                 |  2 +-
 configs/sc589-ezkit_defconfig                 |  2 +-
 configs/sc589-mini_defconfig                  |  2 +-
 configs/sc594-som-ezkit-spl_defconfig         |  2 +-
 configs/sc594-som-ezlite-spl_defconfig        |  2 +-
 configs/sc598-som-ezkit-spl_defconfig         |  2 +-
 configs/sc598-som-ezlite-spl_defconfig        |  2 +-
 include/env/adi/adi_boot.env                  | 32 +++++++++++--------
 18 files changed, 27 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index e42ea85ca9b..efb3c66675a 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -137,12 +137,6 @@ config SC5XX_ROOTFS_OFFSET
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
index ee76172ec00..942978e5571 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index b2ae08a97d0..059b4ebfb1d 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 1f3c74da544..197df99cadf 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_RAM
 #define USE_MMC
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 89e8babbe37..3acc51fc206 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_RAM
 #define USE_SPI
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 5b8711a233e..e98a346e9c0 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 301aed61d8a..6507b6916b7 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 5b8711a233e..e98a346e9c0 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,9 +4,6 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index d39c4262618..0955229a49f 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -4,7 +4,4 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0x100000
-loadaddr=CONFIG_SC5XX_LOADADDR
-
 #include <env/adi/adi_boot.env>
diff --git a/configs/sc573-ezlite_defconfig b/configs/sc573-ezlite_defconfig
index 28dbc7df2a5..802f0e52400 100644
--- a/configs/sc573-ezlite_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -6,7 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SC5XX_LOADADDR=0x83000000
+CONFIG_SYS_LOAD_ADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
 # CONFIG_EFI_LOADER is not set
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 7c9ddb3b47e..471f38fbb70 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,7 +10,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_LOADADDR=0x89300000
+CONFIG_SYS_LOAD_ADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index f42ee15fbed..f5e3c7e28b3 100644
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
index b2249ac14d8..3ecdee91892 100644
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
index 4aaace6ad39..0cbce440e01 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -10,6 +10,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
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
index e1842089588..34f9c65ebe0 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK=0x200E4000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
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
index d71ea76a242..a1a200092a1 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -11,6 +11,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
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
index 101b86d5a69..b96ae6d33fc 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -11,6 +11,7 @@ CONFIG_SPL_STACK=0x200E4000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
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
index 046f4f8a410..76e4d30a242 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -2,7 +2,7 @@
  * A target board needs to set these variables for the commands below to work:
  *
  * - adi_image_offset, location of the fitImage on the SPI flash
- * - loadaddr, where you want to load things
+ * - kernel_addr_r, where you want to load things
  */
 
 #ifdef CONFIG_SC59X_64
@@ -12,6 +12,7 @@
 #endif
 
 /* Config options */
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
 httpdstp=8000
@@ -21,6 +22,11 @@ initrd_high=0xffffffffffffffff
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
@@ -34,43 +40,43 @@ rootpath=/romfs
 nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath},tcp,nfsvers=3 ${adi_bootargs}
 nfsboot= run nfsargs;
 	run addip;
-	wget ${loadaddr} ${serverip}:/fitImage;
-	bootm ${loadaddr}
+	wget ${kernel_addr_r} ${serverip}:/fitImage;
+	bootm
 #endif
 
 #if defined(USE_MMC)
 mmcargs=setenv bootargs root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait ${adi_bootargs}
 mmcboot=mmc rescan;
-	ext4load mmc 0:1 ${loadaddr} /fitImage;
+	ext4load mmc 0:1 ${kernel_addr_r} /fitImage;
 	run mmcargs;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_SPI)
 spiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
-	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-	bootm ${loadaddr}
+	sf read ${kernel_addr_r} ${adi_image_offset} 0xF00000;
+	bootm
 #endif
 
 #if defined(USE_OSPI)
 ospiargs=setenv bootargs rootfstype=ubifs root=ubi0:rootfs ubi.mtd=3 rw ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
 ospiboot=run ospiargs;
 	sf probe ${sfdev};
-	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
-	bootm ${loadaddr}
+	sf read ${kernel_addr_r} ${adi_image_offset} 0xF00000;
+	bootm
 #endif
 
 #if defined(USE_RAM)
-ramboot= wget ${loadaddr} ${serverip}:/fitImage;
+ramboot= wget ${kernel_addr_r} ${serverip}:/fitImage;
 	run ramargs;
-	bootm ${loadaddr}
+	bootm
 #endif
 
 #if defined(USE_USB)
 usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
 usbboot=usb start;
-	ext4load usb 0:1 ${loadaddr} /fitImage; run usbargs;
-	bootm ${loadaddr}
+	ext4load usb 0:1 ${kernel_addr_r} /fitImage; run usbargs;
+	bootm
 #endif
-- 
2.34.1

