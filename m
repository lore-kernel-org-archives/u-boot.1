Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F19E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB958419C;
	Sat, 11 Apr 2026 09:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BHA4EQUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E73B7841B9; Fri, 10 Apr 2026 15:58:36 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C8884105
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d63635d80so16671831cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829513; x=1776434313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2WYoWbJLLRkRMpGSeoB8IUvOcET6v70Fq92dKbpFBU=;
 b=BHA4EQUqYvZhbk+ouLvpGHTy5NT+TtWCFSBCdH6Tbl5fE0VANEe0VgcKJDdSa8OHew
 Nj8o2ShoCnvIbzeKh5aKiC2POgR4evOIKat197dh/yWgTo3Deb/m8/cvteVTD4ytwBq6
 /AZM+aTEAUb0/n8Gtazjsr11iAyI+2HYgKU0tWmnFzWicHnoAb+VYrQe/i6C9PNhgGMO
 qXWHfEgDAdm872tdHdU/bAOKoZniGFJn9FF2SaZda3XQDms5Jw3GxxApySs2XgN39jok
 ythMYP6MvcoRuPayQvORdNEAZoyPWIZ0w8kgLQUf2eVcYFXZLe2OFe08GRPJGg2d+RKt
 PWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829513; x=1776434313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v2WYoWbJLLRkRMpGSeoB8IUvOcET6v70Fq92dKbpFBU=;
 b=jQ3Qi21wIpynM+ijeO5Hh0doxgm3TgKyklT2oMDq5FkS42ojHEftaW4ydVL4FMgLUZ
 RrqPvbGS6kF9FuxA7T22oCBK/AdT3uAU2oirxegErsPAGhhmHUqFSdA03v6vAvaT1HQD
 8quHu0G5NQLlVRvEFNx4Fl6DRw/Wa24LHIl/nUo+Gxu/ejbczxi0PJ+DCYPh6dZEim9Z
 bpz7D4blMGWt+4PTozY7/380ITkR9RRUsctNNEycpmu+KxmMEQyKuBJgASFxYGDlZW6f
 RPYPWb6UjkzDon1jDKA7kJ3V6dyTnu5lGQh9Y/HbIPTDwweTpnko88yNBOuqcDlsmTLH
 GkAw==
X-Gm-Message-State: AOJu0YzhkyUroeMNSh35Rtjq7a0LIX9UmzTQJ4IlDjelRJZNpMFAXmhr
 50fcDSaNo9M6SzgLBEWy+/2Uw93lZGSGO4W4TSSTcwVefplArQ08jcHE/4dYDdqw
X-Gm-Gg: AeBDievd2li6Dixjl9x3nyUnZR4qVOW90M9iRReojjUiKDBQm2HK10Z7aMkriEIN7wB
 hY8yvMQAvAt5rVNZQFEok+P0OUm05Ic7bIkNDIRkTfP61//MZVN8jSPprjf1Pt58qydg3gbrNay
 H89252ZnhNxHmlrE+erFn68J/JP28WeGCok6aNDW6/1v4thaBC/kcYf36ES9txVmLv29GZKsYzp
 JWd60PZjW+vToXpdmYb/uRGP4HmJBx0yTaijsPDV8pdOCi9t5p2/YgR6VRkVhrZfafe/R3RBh+c
 SuNwbXlnmdaBv8CzB4qweb52APVoZYxY9bUKeqrI3TwAKZ19c/pgWSTNgoJmK8fyl+1K/4Gmf84
 C+1x6Pd9mJCUzyYQYBLr6w2/ps4KzDrqnuUmKGgxtYTZMWrw20Czy+hMbtsYegRLSroNn4Z1Y1Z
 lpmV5HBscvo8QyNB4iAi9PeaNFW+UjDHH4ok5rkJ6TqTXN
X-Received: by 2002:ac8:584a:0:b0:4f0:131f:66fe with SMTP id
 d75a77b69052e-50dd5cce105mr46271231cf.59.1775829513138; 
 Fri, 10 Apr 2026 06:58:33 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:32 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 02/14] mach-sc5xx: Remove update commands from default
 environment
Date: Fri, 10 Apr 2026 09:57:57 -0400
Message-Id: <5dd2cbc6dd82ab4c4136bea83683b71fc12778f9.1775829166.git.jcethrid@gmail.com>
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

Remove the update_spi family of commands from the U-boot
environment. These commands are not standard in U-boot,
and boot media programming has moved to Linux, so the
commands can be safely removed.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env         |  2 -
 board/adi/sc584-ezkit/sc584-ezkit.env         |  2 -
 board/adi/sc589-ezkit/sc589-ezkit.env         |  2 -
 board/adi/sc589-mini/sc589-mini.env           |  2 -
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  2 -
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 -
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  2 -
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 -
 configs/sc573-ezkit_defconfig                 |  3 --
 configs/sc584-ezkit_defconfig                 |  2 -
 configs/sc589-ezkit_defconfig                 |  2 -
 configs/sc589-mini_defconfig                  |  2 -
 include/env/adi/adi_boot.env                  | 53 -------------------
 13 files changed, 78 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 8b03a3d5da9..c8781aaad82 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 8a6f7edd5e8..2a76c005d1c 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index b8206e85179..8eaa776cc6e 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index f7628b0b335..a7addcd3957 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 069edc717da..85fa8c8d49c 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index e5382b67c81..f2ee8d06801 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 2cb475e1001..080afaef406 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 1d9ea6d188b..a3486de503e 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,9 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 976d8e0306a..a58e74d3a45 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -5,10 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_SERIAL=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 27f55804199..7975a610ca3 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,9 +10,7 @@ CONFIG_SPL_STACK=0x200C0000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 180b6904d95..0ceb57f1f42 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -13,9 +13,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_EZKIT=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 92c2741f701..32678b63a9f 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -12,9 +12,7 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_MINI=y
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x8E0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index db4148b1af9..b574892e0a0 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -1,9 +1,7 @@
 /*
  * A target board needs to set these variables for the commands below to work:
  *
- * - adi_stage2_offset, the location of stage2-boot.ldr on the SPI flash
  * - adi_image_offset, location of the fitImage on the SPI flash
- * - adi_rfs_offset, location of the RFS on the SPI flash
  * - loadaddr, where you want to load things
  * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2
  */
@@ -15,7 +13,6 @@
 #endif
 
 /* Config options */
-imagefile=fitImage
 ethaddr=02:80:ad:20:31:e8
 eth1addr=02:80:ad:20:31:e9
 uart_console=CONFIG_UART_CONSOLE
@@ -25,11 +22,6 @@ initrd_high=0xffffffffffffffff
 initrd_high=0xffffffff
 #endif
 
-/* Helper routines */
-init_ethernet=mii info;
-	dhcp;
-	setenv serverip ${tftpserverip}
-
 /* Args for each boot mode */
 adi_bootargs=EARLY_PRINTK console=ttySC0,CONFIG_BAUDRATE vmalloc=512M
 ramargs=setenv bootargs ${adi_bootargs}
@@ -73,48 +65,3 @@ ramboot=run init_ethernet;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
-
-/* Update commands */
-stage1file=stage1-boot.ldr
-stage2file=stage2-boot.ldr
-
-#if defined(USE_SPI) || defined(USE_OSPI)
-update_spi_uboot_stage1=tftp ${loadaddr} ${tftp_dir_prefix}${stage1file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} 0x0 ${filesize}
-update_spi_uboot_stage2=tftp ${loadaddr} ${tftp_dir_prefix}${stage2file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_stage2_offset} ${filesize}
-update_spi_uboot=run update_spi_uboot_stage1;
-	run update_spi_uboot_stage2;
-update_spi_fit=tftp ${loadaddr} ${tftp_dir_prefix}${imagefile};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_image_offset} ${filesize};
-	setenv imagesize ${filesize}
-update_spi_rfs=tftp ${loadaddr} ${tftp_dir_prefix}${jffs2file};
-	sf probe ${sfdev};
-	sf update ${loadaddr} ${adi_rfs_offset} ${filesize}
-
-start_update_spi=run init_ethernet;
-	run update_spi_uboot;
-	run update_spi_fit;
-	run update_spi_rfs;
-start_update_spi_uboot_only=run init_ethernet;
-	run update_spi_uboot;
-#endif
-
-#if defined(USE_SPI)
-update_spi=setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL;
-	setenv bootcmd run spiboot;
-	setenv argscmd spiargs;
-	run start_update_spi;
-	saveenv
-#endif
-
-#if defined(USE_OSPI)
-update_ospi=setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL;
-	setenv bootcmd run ospiboot;
-	setenv argscmd spiargs;
-	run start_update_spi;
-	saveenv
-#endif
-- 
2.34.1

