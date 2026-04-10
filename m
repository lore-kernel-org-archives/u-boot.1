Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3938F364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C86384246;
	Sat, 11 Apr 2026 09:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WTDkkGVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBBF84198; Fri, 10 Apr 2026 15:58:52 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77ABD84105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50d63635d80so16673911cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829527; x=1776434327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qSDi642U8Ol68OeASspzKXPINOZMQVDY9n0Ko0lYHc=;
 b=WTDkkGVxSzgw1lo6JdLUrwEvIfo6ZYBwejcmXWtjkrvaAziEuCyvq76D9Ga7hj8vpp
 fGWC/GscJvEOmwp0TfwGIj53tzAs0if0JzMxVxyQGF0qEvwRAKA/owNHirNhrER8Wdal
 yVeNRqzfWBpmaSpgyKWBhrC3JU/YTZ01LT5YJUDjMI8C9NnsxgajUE0HKgCR8CzmR4Gs
 nBML5/QOeemhI2Ti0gCaFTbuTrxW29l8mON8F3ZnXfdmtGVSxkrYmiJTYalcfl34727Z
 L4OAXpXgQADsK720hkB1/V8BI97s56k417oJQU4fCssZNbnsAIJR3FPWiK5vCN61XCZc
 fqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829527; x=1776434327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5qSDi642U8Ol68OeASspzKXPINOZMQVDY9n0Ko0lYHc=;
 b=IXFHVvIxyEdmbmTVigKPfv8ukHDyytVw6oGYfFEBqFdMrA/Zi/Vho/XiaaEOD+UwD4
 j2MrxRs06xxp1dsm9MrSJpnX/dicED/+FWe4iJRHvxX0cuPFMNvEAcAR1Emt/AB3oKyJ
 A13xE3Ry9Fs9B9gmNKBREBWR2w2xDtFm3q9+uZiFVY6pt3GDRQzQI4g0KC/XRHM3Vk1L
 JYf+Xi6EJ2NCEoybLOLauEyh3TH9dTjkP1S/vzZEeI7sMg84ouWgRqTk9tZRwQQBibX0
 +9b3sw8xoH7/S8TYZFwwszMO6t4Lpt9bWURaMF6nx+qf4m1O6Yj0gTgRAtCrVcBL2hbB
 f5UA==
X-Gm-Message-State: AOJu0YzRRepTO04UeZlk0M2nKo1xde1lKZxHfUbyKXe837ZQ6itbauzU
 2MR7Oi5w5ewtR8p4uODhogeCeWtOQHcY4oIVE5LZnxQ5r417rAGJabpRBs4I9BD+
X-Gm-Gg: AeBDieuOYI6NvuweS/5c0b/lu3pzGJ8BZZhtPT6Ra3vWdUKhgQwu3b0dC7K7NYeASSl
 9xmPhlMbzg+KFUsWj1+lLfO0pzu370ASSaqvqPjjFlLL+v6vJk+30gOiKfJIOvn6SaDbv62vkCc
 iddBgqm38HyLXmXAkx/d2z69Hf5vd+8ZnR4ZkP77gZP3+xim/EKCNcMTacVHesv9TEz+5GeXc22
 xmggPVEK9e1blcJb0pmqoMsjFcNm0SuQATuCSM4om2lff4z2A8Z92oFuUkHQaH6Jkqk965BT89p
 nWcRlHzYc0GhgmaiZFMX9EfzF3mCozbZEK+zGWjp9Y2zafu4/Gvk6NwBvBm4q4k4Yfao5QJmG36
 lvM+2nocfwd000yb0Vg7WR6SwG5fkwxo3On8pa61ggAX9M/HfrUQf2hyiBom5w2hJ140LlOhEzo
 VpMdEjh5mN5S6gdEriwiWt6YFKygLa5t/3r/C1KUIlMYv4
X-Received: by 2002:ac8:7f01:0:b0:50d:835f:3407 with SMTP id
 d75a77b69052e-50dd5c76543mr47189791cf.45.1775829527030; 
 Fri, 10 Apr 2026 06:58:47 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:46 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v4 12/14] arm: sc5xx: Remove SC5XX_LOADADDR
Date: Fri, 10 Apr 2026 09:58:07 -0400
Message-Id: <758243098fff1c2fc1b486dbb590922a822a4167.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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
index d3f775b13e8..6fc863cda65 100644
--- a/configs/sc573-ezlite_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
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

