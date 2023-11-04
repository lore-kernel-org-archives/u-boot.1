Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CD0C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E725787442;
	Sat,  4 Nov 2023 21:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7QvciiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CE387214; Sat,  4 Nov 2023 21:38:18 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B564F8710B
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67572f4b17cso10469586d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130287; x=1699735087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nSyIqZvohYXenct9icGa0/AWk/cqfcSqunGrILSWa4=;
 b=L7QvciiX+hEWE3EWrxGidxuUqB/wGw2lHUBY69xH/mGCdp9FTH0G9jJEjnaFJVZk7P
 B7+XYmp5k3i3z+ENWA9gJYQ8trlMldIeWdii21uVWQYj1PbdKVWKJ7xVMaT4ZviZFqv8
 TuJSlkx7jbohlA1Z5QYbH8hNedZEJmiwpTi5Dsc3G5TenqpDVgvXrTQg53/1fEsO9H4r
 tgvvOkMA7KCQcmVp3jzj6X32rWd2nE3Hrf0MrSSgUfGCjxeNP/Y6f8cE4gX5NVmu5oll
 S0kwFQyW9XXpvNeTe32K+z0M0quOckhnbCAvtc8XVsWtqaFkkh55vpJGZ6El+D/ibw6D
 Gl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130287; x=1699735087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nSyIqZvohYXenct9icGa0/AWk/cqfcSqunGrILSWa4=;
 b=VjAgMVQFE0dmW9UpyS75HT93kCFVsMX4Zkky71OsrXnDwZaL7dVZqb/cEafGUlEbZQ
 Z8HTh8Ix2zSKKEexytkpQ9rh/X7+g/JHjiA1PLjqOeWt1VZhZGAfU/6nI4Vxz9ZfBjGS
 y4dwoaX9RogBx2Hj7e/AsGIq7hQdxiDfWhbXDgdGWLY693nWDGxCufS/zSFwDCgpPMPM
 VCp2zKQXE/oOfyPlsFbbTAFq4J6q1dpM+GRJBy87AwPjANupivc2i7+kYPXcOZPeM19J
 Aw4rHepIm69UKY2kwSQAk/iTr+1fOLld7eTBi7Psfvtth8544i3OMJpdPTY0yk6XpVX2
 x5hw==
X-Gm-Message-State: AOJu0YycCuq7vosYvKV1kJP08k7ARjQAbNRLDQRiEbA0k8CuYWuqu7m4
 nxAs3DYlc1c9Th9gm2P/ytv+r8neiqIyhg==
X-Google-Smtp-Source: AGHT+IF8ZRCQN277Qmx7RaaehOUaYyVgpduoyp0dczS3iRhzlR5MNCFieot+mgnk3yly+tpE1bcLKg==
X-Received: by 2002:a05:6214:5005:b0:658:65ed:7e8 with SMTP id
 jo5-20020a056214500500b0065865ed07e8mr33407660qvb.57.1699130286819; 
 Sat, 04 Nov 2023 13:38:06 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 cv15-20020ad44d8f000000b0066d1d2242desm1924281qvb.120.2023.11.04.13.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:06 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 09/15] mtd: Rename SPL_MTD_SUPPORT to SPL_MTD
Date: Sat,  4 Nov 2023 16:37:47 -0400
Message-Id: <20231104203753.1579217-10-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rename SPL_MTD_SUPPORT to SPL_MTD in order to match MTD. This allows using
CONFIG_IS_ENABLED to test for MTD support.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 common/spl/Kconfig                        | 2 +-
 configs/am335x_baltos_defconfig           | 2 +-
 configs/am335x_evm_defconfig              | 2 +-
 configs/am335x_evm_spiboot_defconfig      | 2 +-
 configs/am335x_hs_evm_defconfig           | 2 +-
 configs/am335x_hs_evm_uart_defconfig      | 2 +-
 configs/am335x_igep003x_defconfig         | 2 +-
 configs/am335x_sl50_defconfig             | 2 +-
 configs/am3517_evm_defconfig              | 2 +-
 configs/am43xx_evm_defconfig              | 2 +-
 configs/am43xx_evm_rtconly_defconfig      | 2 +-
 configs/am43xx_evm_usbhost_boot_defconfig | 2 +-
 configs/am43xx_hs_evm_defconfig           | 2 +-
 configs/am62ax_evm_r5_defconfig           | 2 +-
 configs/am65x_evm_a53_defconfig           | 2 +-
 configs/cm_t43_defconfig                  | 2 +-
 configs/igep00x0_defconfig                | 2 +-
 configs/imx6ulz_smm_m2_defconfig          | 2 +-
 configs/imx8mn_bsh_smm_s2_defconfig       | 2 +-
 configs/j7200_evm_a72_defconfig           | 2 +-
 configs/j7200_evm_r5_defconfig            | 2 +-
 configs/j721e_evm_a72_defconfig           | 2 +-
 configs/j721e_evm_r5_defconfig            | 2 +-
 configs/j721s2_evm_a72_defconfig          | 2 +-
 configs/j721s2_evm_r5_defconfig           | 2 +-
 configs/omap35_logic_defconfig            | 2 +-
 configs/omap35_logic_somlv_defconfig      | 2 +-
 configs/omap3_beagle_defconfig            | 2 +-
 configs/omap3_evm_defconfig               | 2 +-
 configs/omap3_logic_defconfig             | 2 +-
 configs/omap3_logic_somlv_defconfig       | 2 +-
 configs/phycore-am335x-r2-regor_defconfig | 2 +-
 configs/phycore-am335x-r2-wega_defconfig  | 2 +-
 configs/socfpga_secu1_defconfig           | 2 +-
 configs/stm32746g-eval_spl_defconfig      | 2 +-
 configs/stm32f746-disco_spl_defconfig     | 2 +-
 configs/stm32f769-disco_spl_defconfig     | 2 +-
 configs/stm32mp15_basic_defconfig         | 2 +-
 configs/stm32mp15_dhcom_basic_defconfig   | 2 +-
 configs/stm32mp15_dhcor_basic_defconfig   | 2 +-
 drivers/mtd/Makefile                      | 2 +-
 include/mtd/cfi_flash.h                   | 2 +-
 42 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 25cd18afda7..00332cf243a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -857,7 +857,7 @@ config SPL_MPC8XXX_INIT_DDR
 	  allows DRAM to be set up before loading U-Boot into that DRAM,
 	  where it can run.
 
-config SPL_MTD_SUPPORT
+config SPL_MTD
 	bool "Support MTD drivers"
 	help
 	  Enable support for MTD (Memory Technology Device) within SPL. MTD
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 3891e48e9c7..0599ae217e6 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -22,7 +22,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 73f221d55bc..5d38dad35bb 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -26,7 +26,7 @@ CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_MUSB_NEW=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 9866246aa51..b5b11fb62c8 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -28,7 +28,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index b961b6c41f0..ea46e58be2d 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -27,7 +27,7 @@ CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_ENV_SUPPORT is not set
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index b5d8eac9f3d..7886557c8da 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -29,7 +29,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
 # CONFIG_SPL_ENV_SUPPORT is not set
 # CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index 4c5c82f9bdd..e2c5b70c405 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 9ba376feda8..fb61dd71c69 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -28,7 +28,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 111929fb912..a96936c92d2 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -26,7 +26,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 5f2356bcd32..d5ce2995548 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -22,7 +22,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 30681e7eeb6..a0a9e8ac584 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -21,7 +21,7 @@ CONFIG_SPL_MAX_SIZE=0x439e0
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 6c4cc99e5ff..cd47806204e 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -20,7 +20,7 @@ CONFIG_SPL_MAX_SIZE=0x37690
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index 49ecb4c9e66..d721664ecb1 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -28,7 +28,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_ETH=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index d52de8bf8be..40704151255 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -43,7 +43,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
 CONFIG_SPL_DMA=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index f4369865bf6..55289b967b7 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -52,7 +52,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 73ccefd269a..1a558b030fe 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -37,7 +37,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x480
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 3b1af07f057..34439cf77be 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index d6edc719004..c471e04d9bd 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -25,7 +25,7 @@ CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x84100000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_DMA=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_CMD_DM=y
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 657eb354c1b..a9c02976f8c 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -43,7 +43,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NAND_IDENT=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index cb4a141675d..01f19570d7e 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -50,7 +50,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index d25dd8134b6..10b7205e49e 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -48,7 +48,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 99e0e168ebf..1d043f2fdeb 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -50,7 +50,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index e76ab5997fe..55169bb1391 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -53,7 +53,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 876f07816a2..a7adb9282b0 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -49,7 +49,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 4990e271c3f..c0fdd86e1f0 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -55,7 +55,7 @@ CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index 3a656072534..5040af058dd 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -30,7 +30,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index 868e89114b7..1ea35c7cfab 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -31,7 +31,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/omap3_beagle_defconfig b/configs/omap3_beagle_defconfig
index 7f0b927528d..c8c9ae02f16 100644
--- a/configs/omap3_beagle_defconfig
+++ b/configs/omap3_beagle_defconfig
@@ -22,7 +22,7 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 3434783d45b..93427f3691c 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -22,7 +22,7 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 78bfbbd1a22..729586bfdc1 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -29,7 +29,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index aefd8861db3..f0f326d2f9c 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -31,7 +31,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_I2C is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_SIMPLE=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index 85d53d06357..cbfe1cf7985 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -28,7 +28,7 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index 60607548a25..b91b9665cc2 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -28,7 +28,7 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index 157391a71c0..09a7a3453e8 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -43,7 +43,7 @@ CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_SUPPORT=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_BOOTM_LEN=0x4000000
diff --git a/configs/stm32746g-eval_spl_defconfig b/configs/stm32746g-eval_spl_defconfig
index 3864e21a180..f9711bedd7d 100644
--- a/configs/stm32746g-eval_spl_defconfig
+++ b/configs/stm32746g-eval_spl_defconfig
@@ -34,7 +34,7 @@ CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_XIP_SUPPORT=y
 CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x80c0000
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/stm32f746-disco_spl_defconfig b/configs/stm32f746-disco_spl_defconfig
index b2a786121c5..a2b740c9cce 100644
--- a/configs/stm32f746-disco_spl_defconfig
+++ b/configs/stm32f746-disco_spl_defconfig
@@ -34,7 +34,7 @@ CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_XIP_SUPPORT=y
 CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x80c0000
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 34622032210..37d22f8d95f 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -33,7 +33,7 @@ CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_XIP_SUPPORT=y
 CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x81c0000
 CONFIG_SPL_DM_RESET=y
diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
index 6df09352400..be553ad3c36 100644
--- a/configs/stm32mp15_basic_defconfig
+++ b/configs/stm32mp15_basic_defconfig
@@ -40,7 +40,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_FLASH_MTD=y
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index b6cd0a47fa7..3d5df307d40 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -47,7 +47,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_RAM_SUPPORT=y
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index d1acf9c657e..50a8882a074 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -45,7 +45,7 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
-CONFIG_SPL_MTD_SUPPORT=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_RAM_SUPPORT=y
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index c638980ea2b..c2fc80b10f0 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_NVMXIP) += nvmxip/
 else
 
 ifneq ($(mtd-y),)
-obj-$(CONFIG_SPL_MTD_SUPPORT) += mtd.o
+obj-$(CONFIG_SPL_MTD) += mtd.o
 endif
 obj-$(CONFIG_$(SPL_TPL_)NAND_SUPPORT) += nand/
 obj-$(CONFIG_SPL_ONENAND_SUPPORT) += onenand/
diff --git a/include/mtd/cfi_flash.h b/include/mtd/cfi_flash.h
index 52cd1c4dbc4..f4aecaac75f 100644
--- a/include/mtd/cfi_flash.h
+++ b/include/mtd/cfi_flash.h
@@ -163,7 +163,7 @@ struct cfi_pri_hdr {
 #if defined(CONFIG_SYS_MAX_FLASH_BANKS_DETECT)
 /* map to cfi_flash_num_flash_banks only when supported */
 #if IS_ENABLED(CONFIG_FLASH_CFI_DRIVER) && \
-    (!IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD_SUPPORT))
+    (!IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD))
 #define CFI_FLASH_BANKS		(cfi_flash_num_flash_banks)
 /* board code can update this variable before CFI detection */
 extern int cfi_flash_num_flash_banks;
-- 
2.37.1

