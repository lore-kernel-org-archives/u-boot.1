Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD5CD6AAE6
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD86D8415D;
	Thu,  2 Apr 2026 17:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W0WAkuKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934AF839DF; Thu,  2 Apr 2026 17:29:10 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35BC83D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 17:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8cfc085395fso93560885a.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775143746; x=1775748546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGtz91Zbi+1ltihSubfFj4jXviHR5rGir4ozIvpb5Qg=;
 b=W0WAkuKtD5EAsqwh19wKEaKdiSJp4yPiAHK4qXLmyXWHTHUA/ahit7+xsMdbMBMxbv
 xA0rAeU/l999M4Drc5ZSKQtsO54rV0OjrcJdRZqskiH5PmCfYaWW2dD1jdyYU2/zW4et
 WAXJQVtP3gIWahbyTCUyVyHpVBvlhisgsl28G+krlveqpFB2l39kNn7XEfU414PMo71k
 jeD0kf1+lQH/v4ZuSKvuodloOe4Ywp7tkeyzHlvrjBowaNnjRtxJJy0HAIroRPWNdr1E
 GhDJcxAvNNGZDtAcFaR/2srWoVnK491BJq1lG6ylWcQB3A4BOZg+IUbIVeYoKryLgwiT
 RJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143746; x=1775748546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dGtz91Zbi+1ltihSubfFj4jXviHR5rGir4ozIvpb5Qg=;
 b=AE/yqsdEwdgwuyPSEnm8sEKfqNu4pqNvVMCOOIQG9m+ieLHx6lwHVi011QiPYHeDC2
 q0qLlYC+zInHsBuJNwJR41/Ivnz704NG8WR7fGTVeyI8Q5EmXLZT+SnQV/5Qyhh9oJDc
 XKZ8eJfzvxd/yk5uXrJ/3huQgmNT/xrlNS2ZhTgn8nxz2sMmDr4vwEY6mqoDSsNWLuxL
 shk/aYdWKgf8SpZz0sJ5u5CKYCxmv5Us+2pm366yWKBcl22DpN87Bc7Iw2SN1rILmUNS
 MrUQ2eZ4G0ePCrWnaRoog/dMq6lR6n3pXJ39GGiAC5d+PiriJXjkFOlN3yrNdCmor2FH
 Gatw==
X-Gm-Message-State: AOJu0Yxanf/QE7OnXZc/HRlvshfnxDK8Mcims6zd4vHNHuyNmhYClD83
 U1SE+qDorE8eS8nRp9V2suow0aX3O1E7SFU4dsE6L9EAkU9bGrsjt169tLNWNGZK
X-Gm-Gg: ATEYQzzQyDL7jAUt6hICl6mawztYW7uUTYohCXZN8wspRAMCdHXs7iTjyZbMUn44LMZ
 Cxp9KPb2DxjLNfMjX5tKchORKwf/uYd5IaI8/SAk2t5o8WCh8/PihYJ5hshxqG/9IDieVgLWJlV
 hNIOsoDohYOEg4bUlWk+A1kQKMWUBv1kFzqYRiqyLM5bQalje9IQ/CmgjWpjRSOlYL2vS6iaPUa
 qmCpPHQshNyhfYfRF4ofxLmPMwdoO4sE5SXhdbySXLoXNMWQS5XAxhyYJWWzqedNgENHLFPupx2
 7Ujz3woTEnqr4lG3irajrxUOXEq01Naprcm4kqCXU0fweaZPkTA9SiGSwhuZRayxvHs0h6eochX
 988WDhI7pktmDuphVvxPixrGSZqkSWTwZMSD6Lh70FJftDOKI5qFESsI9GSkTkQXWL3zfCKEhcu
 24+hr52W00wc+n1KzGglK8NlaN0TppnQES1YNrRsc5MpqV
X-Received: by 2002:a05:620a:1712:b0:8cd:bff9:67ed with SMTP id
 af79cd13be357-8d1b593a92bmr1165291585a.0.1775143746501; 
 Thu, 02 Apr 2026 08:29:06 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5393a07sm239037485a.4.2026.04.02.08.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:29:06 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [RESEND v2 12/13] arm: sc5xx: remove LOADADDR and use kernel_addr_r
Date: Thu,  2 Apr 2026 11:28:35 -0400
Message-Id: <fd5c3fa01abc2601af1ac11a168ba685526b80b1.1775143241.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775143241.git.jcethrid@gmail.com>
References: <cover.1775143241.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:48:00 +0200
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
 configs/sc584-ezkit_defconfig                 |  2 +-
 configs/sc589-ezkit_defconfig                 |  2 +-
 configs/sc589-mini_defconfig                  |  2 +-
 configs/sc594-som-ezkit-spl_defconfig         |  2 +-
 configs/sc594-som-ezlite-spl_defconfig        |  2 +-
 configs/sc598-som-ezkit-spl_defconfig         |  2 +-
 configs/sc598-som-ezlite-spl_defconfig        |  2 +-
 include/env/adi/adi_boot.env                  | 32 +++++++++++--------
 17 files changed, 26 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 776a8548117..3a76e528ee8 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -138,12 +138,6 @@ config SC5XX_ROOTFS_OFFSET
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
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 3a55a50544a..c3f6240d07a 100644
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
index fbf29ac32bb..82e03093dfb 100644
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
index d812e6ec4fa..fc4383f172e 100644
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
index cbed13bbf0d..8c9ab87d042 100644
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
@@ -71,4 +72,3 @@ CONFIG_SPL_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
-CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 9c3f400f8c5..d17c6dacff6 100644
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
@@ -80,4 +81,3 @@ CONFIG_USB_DWC2=y
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
index 585a35d2789..ba53dee1214 100644
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
@@ -103,4 +104,3 @@ CONFIG_USB_DWC2=y
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

