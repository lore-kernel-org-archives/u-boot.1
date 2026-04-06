Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C07F46C79
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9828406D;
	Mon,  6 Apr 2026 21:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrGfm9v5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C508083F98; Mon,  6 Apr 2026 21:21:26 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8028352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50d87610513so17842051cf.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503283; x=1776108083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOF9e4DC88WJ58O6jBid0z10PEomJKyRFM1wozQNXTI=;
 b=TrGfm9v5Z4bQy1/ltvbd8VQPz42M8gaHubJARGfP9HbAZJCLh3SUmxZtTyYW/NrtMW
 oOqQBBAMUycblAdOVElGIpm0x9E9eCEfUoDESjDzsp2Ds+PVAAh4pQBnT0Yf9QqI3gzR
 S8ouXHKVX5JGeBa3O7xFm8wi7wN9DqQkly40TP80SCv+yrF17jTeJarWL6u+HcwmyYPs
 96nAMa9uliYZ0OBbkJ3HhigDogia9pG/n+rQ0VdcZITK8M66mOH68ZmWDZ04xLGdU80o
 K+qlNlnNLzBJEsgOSg68rDi16Rs+32dmXZbEaXTO7n+2FTT55D92p4Vu9gWeU7bw6OvE
 A1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503283; x=1776108083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tOF9e4DC88WJ58O6jBid0z10PEomJKyRFM1wozQNXTI=;
 b=XmJOYbrtCcp4+v6dDWliEPNTWJi0NtLCKN8vz+yUkk5avfuJ9smxBjTYA9wKwmxYEg
 D/5D92N+yqTYFfumwEbs5MvKEuHYALSyzqPd1VKWQpF0SEIVV1nXlnr6NUWRWBq62o9U
 vjDjVqn5bQNGbI0oky2Pr9ykeh30HOxEGoCv0U5SbcwPtSF7qSOAiwi8SNoZXTzJUGZ3
 uMumsMETqhHGPn3VMnbBQI0FF3W0Cqbt4IjJOpvRXAveWhtmBe/5z9e6x4VwFHSzmLb+
 fNJD33ShGR5JHSVw0wg6gX33VWNDhkhZme7JVoQ2o4yTXf9bpO3aeHiy47l6O8fTqI98
 jOBw==
X-Gm-Message-State: AOJu0Yw4iMmnZ65Vzc415EmSGuym7nX9PSoVOFrnXiP43gpnkiRfYeDz
 y9M1gHF9EjLJOp8Sqdml2OIhwlMHypMk4r9Ln8n4/rAmCZhbMDEGR6L53biFGxHp
X-Gm-Gg: AeBDietB2pZl14NOBgOeh1vbpUpKzXgHNg9fhlhmjIPVYBe5Qekjbf3losvpUfYy09o
 YoTddHTl9dAoKZjnKkZvaxVADKKtE0riooGw5cc6ldE1B+c6+nyxB3yH1f2aSPkDVg8/KovR2Sd
 NeVv1HQAXB1tBZSK7r5G75OaOWhju5BdZzBdOOAttff4UdujWoR6+7Yj7w4P3B4f8ySaHuO64cs
 9oFDCpOBhLH6EcSuRgE8tyaO/CZYX4ur0ESNjEnG9hAAWZwBGJKf0P1R9RbiaIcBfP9qJy3qzBm
 m/sLqp9rhi7yWL/kEu1hp1RiD537WoJX75rm+vOp+7Xg2oUV0QqtFNTNI/Ra++kzIzrS0K/Zp7f
 UO/Ek6JTFykYtAsPEsDc50Pc3ZB8u1yXjLP/py5uW6ciXTd4MneH0qn6qZUeosFGog7BieR9Ji1
 TYCrO9suXNnejys4nUrWBKa1p3LKxJeglJcg==
X-Received: by 2002:ac8:6150:0:10b0:509:35d1:ca3c with SMTP id
 d75a77b69052e-50d62adf8edmr159898911cf.5.1775503283075; 
 Mon, 06 Apr 2026 12:21:23 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:22 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 02/13] mach-sc5xx: Remove update commands from default
 environment
Date: Mon,  6 Apr 2026 15:06:04 -0400
Message-Id: <661a6b556768a253d3ffae3de843ec6a72119ac5.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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
index e5924b858fb..905c22e1f6b 100644
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
index 60fbc2f9b83..b327389ba54 100644
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
index e4f9144167d..836f2a39bee 100644
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
index 2241808b6ef..02c9a10ef07 100644
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

