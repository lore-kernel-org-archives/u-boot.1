Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74459F364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0C2841C2;
	Sat, 11 Apr 2026 09:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTsXidTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6B584154; Fri, 10 Apr 2026 15:58:38 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC8784120
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-506aa68065eso16402461cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829515; x=1776434315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwH2FFN0X+VLAS4BTnzNuOWAWHAa3qLVsFtUFfm+k4Y=;
 b=rTsXidTkjTu6je5tAT8IwCn7hvK6Df1G9eUshFs2MkMdTEpO3QZ1CmAY0mVPWgScDh
 DUOOAPg5rkUB8NbYV9xGADqgexfq+pO1iJSpNElh0HembVm6ptkPB2J0x90qkRDNFOLG
 DFGPv9/pGg8ApAyPYh/nUmK9DOYTxiH0wv/VuUWbxlCsTARjIixeOit3HPi4m6d2+Mpk
 c+8Y0ZYclgcUkHA8OkkfBzNHk4hP1WGCD0moNPWs/56xXMy+TYMq7tO/qMKppTMjtkYf
 LQgPTEk6DNw8N/4wwgXvlpnTQYQheNHRvLrDNR/6rOpzQfUfzgmg1+6T1wj/qDMBq58U
 A6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829515; x=1776434315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwH2FFN0X+VLAS4BTnzNuOWAWHAa3qLVsFtUFfm+k4Y=;
 b=fi2+zkBuV1Vo+dIdsp1bWhIO4FZnhzhDvV50SmAfTYCiE00EIhp9EImSSWEvsxSyue
 ii4EQOw0cPHk+LTBRa1EsD6q0jA3F8gn9LMU1AVmAlqJfthNQBTWlfyEhSwXOwSKuQzT
 nz10QZkuzO2xnauFVYrJkYE5dWqAmu4PJfboNxzsF6TbPoW6QPRq1CX4M32OPeUtjXW/
 AvJHxgav+sUjN5IgqBObJGVJb2lDWvyF2NNCOyBCBX7X/Ea6sne5PSbc7e/6gVyUECkh
 RXMQr9in0ZZJ5ivSZNYj6BAIiavnHiS8iTr72WEwiNLJHTc1jn9gsXBew6rlnyEWKuBt
 A15A==
X-Gm-Message-State: AOJu0YxRdEw0ZCsWhezj/58EM1aETWIQZoMoic7TAqUmkDnkcysQmxjB
 GHKyttyz6vtEZhCRwbGHI04Il/5D1x+7EYykL8fOkmSfB7xbffvoTf1n88nwUAea
X-Gm-Gg: AeBDietU5CMHn0vfEzcAoJ+jinEjR8hv30Pr8+2TQOBt24AgJMyPTYqD1F3rWcjoSA0
 uMQY+dFPRbt8vfHpcqwSl55bsxL7d57yKoJLuhp/q9gn3oSvwL6HhXRK9WqXQBO0FRLdlwfnnTo
 o0rkIBfArhEeQHuA1agMbshkbAr1zbV0Kcuiqff5LD+hvdrTpr9sChh6+zI7g/QdxV/65fzwkxr
 Gy8EsNH0n9aOjdIwbTQvOkaCp7tcvUVXocjH85hroh1DdVj1Vbt0G4sMJfxszb9NbIL+neVTX28
 0rnytgSU92z6RyUWvYH/lR8VYlvkEgypjpSU/KKirmf2mYg6SpR/FTV21cofZQUEkOQFyK7sV19
 ukKc8GjL735DB0irUuTgm/pUbYEamqxmBDgkW7U6WKzOPAMfEDh08N5dasHrrdiMy0x1ebP3RKl
 9tHMxMlbNF86atMhZdwdriM5lgR6TddcKVDQ==
X-Received: by 2002:ac8:5741:0:b0:4f1:bacc:151 with SMTP id
 d75a77b69052e-50dd5c61847mr44657691cf.60.1775829514499; 
 Fri, 10 Apr 2026 06:58:34 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:34 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 03/14] mach-sc5xx: Update boot commands
Date: Fri, 10 Apr 2026 09:57:58 -0400
Message-Id: <80e41b4f36588f8bb34c41eef6a1a7cb68520ee7.1775829166.git.jcethrid@gmail.com>
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

Update the default boot commands to match the expected
bootargs in Linux and new SPI partitioning scheme.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env           |  2 +-
 board/adi/sc584-ezkit/sc584-ezkit.env           |  2 +-
 board/adi/sc589-ezkit/sc589-ezkit.env           |  2 +-
 board/adi/sc589-mini/sc589-mini.env             |  2 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 +-
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 +-
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 +-
 configs/sc573-ezkit_defconfig                   |  1 -
 configs/sc584-ezkit_defconfig                   |  1 -
 configs/sc589-ezkit_defconfig                   |  1 -
 configs/sc589-mini_defconfig                    |  1 -
 configs/sc594-som-ezkit-spl_defconfig           |  1 +
 configs/sc594-som-ezlite-spl_defconfig          |  1 +
 configs/sc598-som-ezkit-spl_defconfig           |  1 +
 configs/sc598-som-ezlite-spl_defconfig          |  1 +
 include/env/adi/adi_boot.env                    | 16 ++++++++++------
 17 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index c8781aaad82..51157ff36aa 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 2a76c005d1c..6d4b20d70f6 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 8eaa776cc6e..d068b44573f 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index a7addcd3957..3827cf4e9a5 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 85fa8c8d49c..69d2ec3ba03 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index f2ee8d06801..f915175e041 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 080afaef406..b6f477c8402 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index a3486de503e..cbf5d5e60f1 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index a58e74d3a45..e0ce5fabd78 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 7975a610ca3..52ab7c9337b 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,7 +10,6 @@ CONFIG_SPL_STACK=0x200C0000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 0ceb57f1f42..a249fe8df7b 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -13,7 +13,6 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_EZKIT=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 32678b63a9f..25285695367 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -12,7 +12,6 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_MINI=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index c379de2c146..89ef08c1a72 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -74,3 +74,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 54b26ed85c2..9e907d31136 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -83,3 +83,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index 7027a7f8a2a..ea1e0b6202c 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -108,3 +108,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 0b59b36f264..0b47f6febba 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -106,3 +106,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index b574892e0a0..3c196e40603 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -40,23 +40,27 @@ nfsboot=run init_ethernet;
 #endif
 
 #if defined(USE_MMC)
-mmcargs=setenv bootargs root=/dev/mmcblk0p1 rw rootfstype=ext4 rootwait ${adi_bootargs}
+mmcargs=setenv bootargs root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait ${adi_bootargs}
 mmcboot=mmc rescan;
-	ext4load mmc 0:1 ${loadaddr} /boot/${imagefile};
+	ext4load mmc 0:1 ${loadaddr} /fitImage;
 	run mmcargs;
 	bootm ${loadaddr}
 #endif
 
-#if defined(USE_SPI) || defined(USE_OSPI)
-spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}
+#if defined(USE_SPI)
+spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
-	sf read ${loadaddr} ${adi_image_offset} ${imagesize};
+	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
 	bootm ${loadaddr}
 #endif
 
 #if defined(USE_OSPI)
-ospiboot=run spiboot
+ospiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
+ospiboot=run ospiargs;
+	sf probe ${sfdev};
+	sf read ${loadaddr} ${adi_image_offset} 0xF00000;
+	bootm ${loadaddr}
 #endif
 
 #if defined(USE_RAM)
-- 
2.34.1

