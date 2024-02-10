Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F015C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 06:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913D687E9C;
	Sat, 10 Feb 2024 07:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vrfi/ExT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34BC287E9F; Sat, 10 Feb 2024 07:33:10 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A040C87EA9
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 07:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7426FCE21B7;
 Sat, 10 Feb 2024 06:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943FEC433F1;
 Sat, 10 Feb 2024 06:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707546784;
 bh=wxYd/A0HMl3KlwQsUGf88Y3mufCObtTDoWV26yQG3bU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vrfi/ExTXC65TjGCBpZYVooNFFCWr03+QfbqvMzg+oBS/U7CfqjtCYI2xQMWJH9AV
 KpPWxcou+ivdfejJTudJPZ4vqKCRjpytn+WUo1ft971nTjiN0Ur3JE9ErQOJnkBvIx
 JVPRF0b6KZPf477YfPNgemmvjqnVOZT7XYVLBoUXBqRJv9Ys/Q5mepfQKefSlIRqbG
 VzM4tJ46/AFFsUf0nVd5rK615FPgRey36gn6ux4exNibcQV19IkdeID3zzKJHIegVs
 bJIexG7Eo1oh0XSIc6+80UuPMGazzMprtyBCteDCO/1Wx5DS+enz8ZDj1nV/3fEaIf
 G+JgxXoqzDiDw==
Received: by wens.tw (Postfix, from userid 1000)
 id 85D9A5FB5F; Sat, 10 Feb 2024 14:33:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] rockchip: rk3399: regenerate defconfigs
Date: Sat, 10 Feb 2024 14:32:50 +0800
Message-Id: <20240210063252.1065611-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240210063252.1065611-1-wens@kernel.org>
References: <20240210063252.1065611-1-wens@kernel.org>
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

From: Chen-Yu Tsai <wens@csie.org>

Regenerate RK3399 defconfigs after adding imply statements.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 configs/chromebook_bob_defconfig          | 2 --
 configs/chromebook_kevin_defconfig        | 2 --
 configs/firefly-rk3399_defconfig          | 2 --
 configs/nanopi-r4s-rk3399_defconfig       | 2 --
 configs/pinebook-pro-rk3399_defconfig     | 2 --
 configs/pinephone-pro-rk3399_defconfig    | 2 --
 configs/puma-rk3399_defconfig             | 2 --
 configs/roc-pc-mezzanine-rk3399_defconfig | 2 --
 configs/roc-pc-rk3399_defconfig           | 2 --
 configs/rock-4c-plus-rk3399_defconfig     | 3 ---
 configs/rock-4se-rk3399_defconfig         | 3 ---
 configs/rock-pi-4-rk3399_defconfig        | 3 ---
 configs/rock-pi-4c-rk3399_defconfig       | 3 ---
 configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
 configs/rock960-rk3399_defconfig          | 1 -
 configs/rockpro64-rk3399_defconfig        | 2 --
 16 files changed, 34 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index b5a5ae737e52..bffa0d33b75c 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -27,7 +27,6 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-bob.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
@@ -68,7 +67,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 20913d2cf0fe..e14fc358c504 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -28,7 +28,6 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-gru-kevin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
@@ -69,7 +68,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index b7c8e95b7b89..b01b1a327896 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -20,7 +20,6 @@ CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-firefly.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -46,7 +45,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index cacaab14d21f..18a1e68aa049 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -17,7 +17,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-r4s.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -42,7 +41,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index de357415fbe4..6b83daf07945 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -26,7 +26,6 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-pinebook-pro.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -61,7 +60,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index d08224fe536b..96316c4b303f 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -25,7 +25,6 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-pinephone-pro.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -60,7 +59,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index c2aa02ec74bd..f39d352c7890 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -25,7 +25,6 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -68,7 +67,6 @@ CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index de6539bedf48..64103eada8cf 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -26,7 +26,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-mezzanine.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -56,7 +55,6 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 7123a7a07299..61991e8868b3 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -27,7 +27,6 @@ CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -56,7 +55,6 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 18525c8bf504..12587b1eba10 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
@@ -21,7 +20,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4c-plus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -53,7 +51,6 @@ CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 171de23ec8f6..16a58a10d7e3 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
@@ -23,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -54,7 +52,6 @@ CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 83fc4ad7dabc..fe3705e3672c 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
@@ -23,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -55,7 +53,6 @@ CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 089344097e0c..f37a09710b9e 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -8,7 +8,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
@@ -21,7 +20,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -53,7 +51,6 @@ CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index dc4b3b40380a..9a8beaa81ddf 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -22,7 +22,6 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399pro-rock-pi-n10.dtb"
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index b93dda56593b..80b41b061bdb 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -20,7 +20,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock960.dtb"
 CONFIG_SYS_PBSIZE=1052
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 711541f84627..c37d858c2c66 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -28,7 +28,6 @@ CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -64,7 +63,6 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.39.2

