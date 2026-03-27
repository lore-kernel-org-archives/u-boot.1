Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC910F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A61E83FEC;
	Fri, 27 Mar 2026 17:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kDXcYUM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080BF83DA7; Fri, 27 Mar 2026 14:51:48 +0100 (CET)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C2383DBF
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-89c5446f3caso25365436d6.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619503; x=1775224303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlNZLo3fHC3IP8s1BfQoSp/W8NeZ0SGqvJ3Xibc5kc0=;
 b=kDXcYUM77hGAQ+KpivMqCaLg/3YKKGAe6VKc+D+qXNWpoxwXnV/piXGAPdje5088BP
 V+A35xU5TM7iqdMbiZ9j8+f4CORasvqbA5eI3dg/pMqktvbYFVsHbmd8RML/Vq+htdxP
 HLIX6rawQop5fDHHQShIkdUEBY6kORXVEGCK6UnkBTicovKe+aBmljvb1NP0svun0adO
 lSWyoGrbv6Rxb2TiKPb5xrn75jzAeKXEqenAfODIg1zHnxw2F291du+qKe39Z4+BxWh3
 krqJdkbLzTjPwBu7Vb/0a9I+ATh2OEg1Z6x/WtXdf8vqKfG4J3BmSsdDBmZWmEkFBdB9
 pEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619503; x=1775224303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HlNZLo3fHC3IP8s1BfQoSp/W8NeZ0SGqvJ3Xibc5kc0=;
 b=dhTfBuyigg3R/1b/7d8CA9/4jzSi6wW1J9PXLv10czrWioypNwOFEQWKq7gatoq6La
 qbtycQuTSCc5+kSo1gRKFTerwIhJRWopaF1bA5St1KcCWRDr22SJQjvBzcf81YRM7cUj
 V6kIUckqSAcdTnaHU7uAVDcea9sfDiHkvuGcvNgefLRWzW5zp2A4ZDpFv5DDKR21N8d9
 q9R6hDDJMnhE7YwIZSoC493cCmwakFRdMg9tPuJz+mRNCEM+/T6SdhqFeX+kQANFICvi
 hVsk5krv8x3OIcBU9SNqafo1gsmc3EMU8d6c+D72fV4dnUxpfBNtzz/rJ2CE9yPwLg9X
 Wn8g==
X-Gm-Message-State: AOJu0YwMdq+CjgT7jG8wxoBZoOy8aYiRbLPBcCZNjNXCdapQM0GhdMXg
 latpKl6mZtLMk0UEXESGhTRN+F6+0iawERFEaQOh24LQXqNjeBAgRr6rTAhONh0B
X-Gm-Gg: ATEYQzyGGvDqzUjIJFsEB7XkbBhDwzqJMzj6B1UW2uuF96HSfs52rMd4Gyp0Skr5H62
 PBqES6vfl+I/L6pNqwG67vDlLyrwILB7wgsYzHg/LTyuKP7uFx3q59li50nedWf6llSdFEek1p3
 GxOGtFgwdSjz116b1pjz5YEaawjzlFhpS58CI32OfRIi2rP/+ZOOyGRKKJfATqSmvT14Kes0t4A
 slF+xM385chvL+7ITnf9IpB3uWJCSVBuM0WNxNpqPWoRNGhe8o0R07lfsufMXw1EVX3HVmZg1Ry
 akcHGd/biF5VzLZZSqLTEAwkFzJ4eusPYyhw4otwFxu3/QDlcZiTU1jPWmDQlbPT/cOWBLgUUSR
 jDTUA2BVR3TYz/EcKtEhkSyQMGLVw5kVoQcE8UTxu/O91lTUMm3K46lWm6dEkiM9NRXr3ABe8Ne
 ykXHFJmcp9KP1DJ9tSN1mdqn7jtXJl6V4qvg==
X-Received: by 2002:a05:6214:4783:b0:89a:686:cb4c with SMTP id
 6a1803df08f44-89ce8e17b5dmr29721996d6.28.1774619503258; 
 Fri, 27 Mar 2026 06:51:43 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:42 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 03/13] mach-sc5xx: Update boot commands
Date: Fri, 27 Mar 2026 09:49:18 -0400
Message-Id: <5fab88e3d5282ec1f4fc4a1c144ccc6cdc476743.1774618658.git.jcethrid@gmail.com>
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
index 3d57c5737ae..9562b9a68a8 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 653c4ea6daf..da64ebe093c 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 7e37f041e63..43f5d7a5565 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index e3ce291cb01..7726939946d 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index cd6b6466dde..e3f25043856 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index a07598c8b4a..2fd2295e1e0 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 3f9ec69303b..1da4a585b1c 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,8 +4,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 54c00085c45..f8c5b8472d1 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -4,7 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 86ea8145528..6023bbb420c 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 4dc6c30b21d..7c9ddb3b47e 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,7 +10,6 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index e364ac14888..42942eb7517 100644
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
index ee96b88f673..e03d647d4d1 100644
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
index 5c0f7844630..e576c56909d 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -74,3 +74,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 7840b47a1aa..7a021ad345c 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -83,3 +83,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0xA2000000
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index d19c3c6018d..d71ea76a242 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -108,3 +108,4 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
 # CONFIG_TOOLS_MKEFICAPSULE is not set
+CONFIG_SC5XX_LOADADDR=0x90000000
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index cce06cd931a..101b86d5a69 100644
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

