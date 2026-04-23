Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE6CFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 22:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC5C84150;
	Sun, 26 Apr 2026 00:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUNFI522";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13288435C; Sat, 25 Apr 2026 23:20:23 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663EA84178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50e5ad864a6so64247931cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777152020; x=1777756820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJB7xOeQkGDZLOodkKiLGnA707rwehsAL3Raiq0hJEs=;
 b=XUNFI522OV5BHspjHX1cp1rKAYEP195/5D1oK6MqdEhhN8NvAWLZDsIJvTpxIrL8AM
 vVeKrfxPteFhmR22uRDgYlHy2oKdlNKhsyA1ie8+2Ko/iT/vYL3SEjVSlZx+C/xirxzx
 EVY065DURmvR4l/6gNFY8Cb1W3UJGrmqooFTDcYbCT8G7K+VArvbYzeAIOfLObYebuXk
 SyBXkzt8JVGYkdCdSh5gLNZItyQ10jLAGOE86KTL6N2ka3MXl+EsR0rOvq9t9irWTeyN
 xbkiAwBo+e08PDaFLZNj4TeyPkYxYYAfvomPtIoEMSI0jWO/3ZQRrEKqhkWoMub6RT08
 2+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777152020; x=1777756820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJB7xOeQkGDZLOodkKiLGnA707rwehsAL3Raiq0hJEs=;
 b=AZU3Ox2DD4tuIHFpl7QOYsn4LkAIWC0yY5OKdWGPYeuOu4pnfco8g5aMzSdT114Rry
 r3FZbvzHM6y06DQRmhOcgdX1XLsnTHkF17IWBZQI+bMX+Hci0en6oOmCmNOO71wDoIbW
 I8UumI6rd51gNET9JQMHbzRjncEsdRW3bEg9X3LIENn6adST+TXjaKDnEAovUspYAz4V
 M1BuydAap3CMl5l6msCgAoU+CygJO5/3dpiXFZxA0QkIN2kygUA+sPtONB4MGJvlWBsB
 lw/DKykdRBSIEaDvOe2HfPbiDjJ+RnugVtwXoSDMSCF41J8yQdfNXbx8OkZRO9KzfLAR
 Qzgw==
X-Gm-Message-State: AOJu0YwjNMDfmmVSXGRvr9WA55ciDQPKi5JPGK8cWQb35KraUOfCWGPu
 uS7xeujI5nsurrZlEjFarzwUHTNJLFZm+DOWN1LvU8bZr5M5vBqNJBuzpc+LwBQt
X-Gm-Gg: AeBDieuq8XksujRWMOG7YROvqcDD1D0qkwJQjrPgqF1BNn+u1R2WzTxBte4LtniW4v6
 54gWAy6HYhqkCJ/wK/qtyUay/PTuagWWEWQrG4mGL/LcGSGnptuyIJnHVJKQkCJ/oDcFloRf5Ph
 S6h2iUWumBpozdzBuKvf7KAcYVD57DpYUxrD5oMVmfBn1vHJmE/2ZDQaq6j1n5GyqYuPYosgjf7
 a9pXuJLZF9FVhmzf0NjsF6ri1K5+zb72+KtgcyA/P4WqFC+7DoqjcGx72EA6CrCq6XZPNbP0nSl
 e8HUgkqH8U/g0H97hESUErrkBggoso8eY+vBVHh9xfeLYwvXT8Sslu2g180d1ENTntV3t2+4cY4
 efeIEbrN7f2VJ5+9qYuuD7koGswNTsdngwJuRNaJjdxM9rqhiEmHvnVhWpleh1Exl50LEEBTHln
 uJs0M6+HlbmbmTRJx1YZji4/4ro3vM6pGC1QSENk1GlYAs
X-Received: by 2002:a05:6214:4345:b0:8a4:c1ef:d727 with SMTP id
 6a1803df08f44-8b027fccc49mr437843236d6.10.1776954343519; 
 Thu, 23 Apr 2026 07:25:43 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:43 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 03/15] mach-sc5xx: Update boot commands
Date: Thu, 23 Apr 2026 10:24:38 -0400
Message-Id: <7771d2ff3f10bcb9a2453849b51a195f9301bc21.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 00:34:30 +0200
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
index 7a0c7d04e84..4320c73fd39 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
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

