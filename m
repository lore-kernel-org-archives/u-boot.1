Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3DFF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756E5843DC;
	Fri, 17 Apr 2026 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QdQMbcLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 337918420C; Thu, 16 Apr 2026 17:20:17 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE465841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8a15ebb3abbso116251206d6.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352813; x=1776957613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+qcl9zJpyKHayKivoi/kLPUpyPv9fGApWOwQuTlw88=;
 b=QdQMbcLAfHQQ6HarCH3dWKf/pJTNsIEznsrfbBkBUTwRbzG2A/o3ceqIVEgvTcZL6f
 CyGlzwEWolWx9i2vi2wsL6ah2zmKIYPH3+Nv1nDJO14IndP/WyyWjJ/Zfq+7K3NXzFOJ
 DqlYMSQAikNVtTV8FIYlkY3uK1GRxzpeDDaf7ER4nVCJI5w212GS9gHs4Q4VtsnjxDdK
 HmF8nd68hpv862/LWLRrOOyU1WH9X4hriDqmx5+6Q+AEhnuc2mjqPEzgX5WFcLCVyjeZ
 J1xjQtvhoOpjDmb9pwNeSjE6VmxNZ2rrNWLZ6jy0utBcBvXms7N7F9Jghrwe5Tbe/LYa
 pa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352813; x=1776957613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+qcl9zJpyKHayKivoi/kLPUpyPv9fGApWOwQuTlw88=;
 b=oYdnnM9YJvxWg8qJPFCqGHv4Sq6vW/wUIeZwM4dkfohqvbyUrssHI79q939tJRNzgI
 Hg9Sa3j65IJS4rEcMyAqYdWu8PKRbqlzqAIwWmMyzKB+8t7NNeVFd5LIfK5xpZUWungl
 qAzCD5IXJakDhw3S7vv2DGTwAru7EHyn+sSLbGZ2TzJH2scJIVXP4CorLdoP0vp8NQiE
 Bz9/pJ4i5pvyBAG/pW1dHxzR8PaESQmbxgdS0979uAYfczn1HocSAE4pPi+gwDAWFMFk
 f57Os8wmAUdu1LkiUrFdn7iuwX1z0ylxmo8+cEvINZPSVmIhoMTa1qHYYFeZldiRXqEa
 yjgA==
X-Gm-Message-State: AOJu0YwEhini+D+VLOiqimvXc64ScXeCNje7RduJwuDERDcQOchiS3Oq
 Qk5e0th971+phP58aMB/CAPs3/bIv+GFG0NSUAPlPkV1UeoB8A6yT02SsZIlci2h
X-Gm-Gg: AeBDiet4ZHdkdDPt9oVYAFaCCFcKErRhNTuiqChd/LkI1NjglNoB1UFVfH1vb0/xyVq
 nZIU/xztPVX31Q+1u6ZvJ8xz4QJ/A5CcDKoKXPxPryTd4ffkuDJwG9Sj/HyrxojhW7GtkZH3jmv
 iqj5rTN09Bbox+ynS6/gaZKJhpcTND3VIAR/Y9DclrBCkC6z39ju+TtwTPNOrP5b34n8nlnEd+d
 8/f5hVJYf+14szdXtDG40Cg9X1O3qkMN2TgmUYKiNDJY1jP6D19rEwN4k5YjAff1M8cqn6iZ/5C
 kL8BQTbR7nfmjGxcbrEUYmqsrj0fKPWJcQZW6J5Z1gW6oXi5urgojBr/20cPzLzlbFS+43iY7Lt
 x+FVT4HHOuw5ue3JbTbzjI8+qEBXnt1ca0+v6qCEf9CHq16wqjgxw4f4FgJyJMjTxWOH1iEXoC4
 m5DsADZREfhpynuw5qKkxBxjMv6BdSU4mGl0ZYoMdW5t6h
X-Received: by 2002:a05:6214:3481:b0:8ac:a0b0:64cc with SMTP id
 6a1803df08f44-8aca0b068famr281062866d6.16.1776352813397; 
 Thu, 16 Apr 2026 08:20:13 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:13 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 02/14] mach-sc5xx: Remove update commands from default
 environment
Date: Thu, 16 Apr 2026 11:19:37 -0400
Message-Id: <bb86af2e00b7f1ad7f5ef1831b64f2d120ae6dc7.1776344788.git.jcethrid@gmail.com>
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
index 976d8e0306a..7a0c7d04e84 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,9 +6,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
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

