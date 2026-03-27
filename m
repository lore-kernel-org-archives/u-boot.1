Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3890210F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D073383FC6;
	Fri, 27 Mar 2026 17:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VSrLWbG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA928394E; Fri, 27 Mar 2026 14:51:44 +0100 (CET)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959478394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-509006c070eso16550371cf.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619501; x=1775224301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rNJb1xybe2gRDuXYphLxpaNIafPBWqj0g/AehcFMBg=;
 b=VSrLWbG0/O+oAMuqpi0JQ2YG3qR3typN0L7imcjQMxSNMyJfkZDKnq9b0N1mLz7BwL
 S0wS8pCFn43/fa3bBLC1Smg42OMcwsQnAVdwJIhmHAKgDMepFGxc/Ja9QZXd1YrRlYZk
 hFCsQ5e5SSjoFY+7UM4pQPSHuLJulxp+eBH80EsAVlDdTe4BfI2Un9+2ANYWcO6nxRu9
 07HjuGcytw2qN1eZO2hggJdIMLr2s3Y8l8IV/5I+Z8rBlSdF162yNwxQlzsRRs8IBZkz
 PAwRJsa5EUF9tPTcxuGrLicjoYbCJZzpvBfwy55NxV84IKDVhmrRwzhtF3yIM26/7wji
 7zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619501; x=1775224301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rNJb1xybe2gRDuXYphLxpaNIafPBWqj0g/AehcFMBg=;
 b=AisTjYXuItwO2azlCdxWhlI8HJWM6iqqdHnBJgJ4Tf/Czej7cO7qs+tjOIbdYBsVCU
 jtsD0q8mmfPqgMS0zrbbnIvlExVwAhbfA2JT+X2ZIo5d4zZCh1lM4QcHYq6gvQ/AJODr
 i8ncHAcooVIujEViCjYJqTzirdfV0oeRJoSfn8YKcrziM8ZDrh+7PdVpPoww/WwLH/UV
 ojOiXRrr91RxzwmFUJ8ySAbiag8dx5hh+dnhSlbn2FgDMtqYKwuVFtWrqbI9vHo9xPWU
 AbRp5Olzf+y6KfGEzVN5holve0iKLWkqweGb/E65bxQTylyZ8wFLvMjPAEQHjrs2yd+s
 1fXw==
X-Gm-Message-State: AOJu0YzBnIZSZrn46bnY31EexkCE1i910FAK0EVK7IyFl1iJRdL76KoJ
 Kzw5AixvJPQWaxvsP8tWT9LIsyRTZAv4OYqYDq8w98mVBs5AmEER2KkqUVTUAz1r
X-Gm-Gg: ATEYQzy1uALtDbEW4KIvBgD/7JIHjUSfA6TF/QfvjrBZMZali1yCFc0MwNYJtrk2rtE
 BJpOb9JJLE418uPVz3MgoyB5bFl2xfikjld+na6P7e/vM0QD4AQdXZgnGFOHFXf6aPvty19WnlV
 VeRWkd5hSx9Djjwd2NvGlDU/Fwiv2zK0mYdHlMf/+ks3JFQsDsJIJeizMqWmL9ghoRuPVQEmtM8
 2I8MjW6SzDGz9rOBjPUI+OY9amhtFNZA+h5G5TqcTGa3amvK95MysYXahlSPOKFZ5WWOTFGjUU2
 Xj+fBXlbN05A7SdAk5gQ70hoLSSqMF1gWVHnpno+fSdg3WsiV5pbL4R/bXDpBy48au4i1z2uILO
 YOFYaau35hJOBZN0baG25tZQvz+E31kDFGaBMCj/MjGxFP+gtC+MFwr1cRizLanvU3IqyMzjtgO
 jUybeppWsx1z2QZsxfXXfx1g93ySI4+TfPmw==
X-Received: by 2002:ac8:5814:0:b0:509:120d:4311 with SMTP id
 d75a77b69052e-50ba398fb32mr30233211cf.60.1774619501263; 
 Fri, 27 Mar 2026 06:51:41 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:40 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 02/13] mach-sc5xx: Remove update commands from default
 environment
Date: Fri, 27 Mar 2026 09:49:17 -0400
Message-Id: <c9472d3087ef3514a848e0e351fb8045e4922d84.1774618658.git.jcethrid@gmail.com>
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
 configs/sc573-ezkit_defconfig                 |  2 -
 configs/sc584-ezkit_defconfig                 |  2 -
 configs/sc589-ezkit_defconfig                 |  2 -
 configs/sc589-mini_defconfig                  |  2 -
 include/env/adi/adi_boot.env                  | 53 -------------------
 13 files changed, 77 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index d53a72dca57..3d57c5737ae 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 59b776cea6f..653c4ea6daf 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 3705bbd5b4d..7e37f041e63 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 6cd251746b0..e3ce291cb01 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 6113df11736..cd6b6466dde 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index e591027eace..a07598c8b4a 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index a07fb9edc45..3f9ec69303b 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
 loadaddr=CONFIG_SC5XX_LOADADDR
 
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 64eff88df5e..54c00085c45 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -4,9 +4,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_stage2_offset=CONFIG_SC5XX_UBOOT_OFFSET
 adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
-adi_rfs_offset=CONFIG_SC5XX_ROOTFS_OFFSET
 loadaddr=CONFIG_SC5XX_LOADADDR
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezlite.jffs2
 
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 66d6d4b1155..86ea8145528 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SC5XX_UBOOT_OFFSET=0x20000
 CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
-CONFIG_SC5XX_ROOTFS_OFFSET=0x6E0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index c34e467b005..4dc6c30b21d 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,9 +10,7 @@ CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
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
index b23cc803d34..e364ac14888 100644
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
index 8c0d68755ad..ee96b88f673 100644
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

