Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31FAC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7981887EC9;
	Mon, 12 Feb 2024 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DqYS07xU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3805B87EC9; Mon, 12 Feb 2024 14:51:34 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D8087CB5
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B573ACE12C7;
 Mon, 12 Feb 2024 13:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6935C43390;
 Mon, 12 Feb 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707745888;
 bh=yCML5mnOUfMgg5IoFTupsihuPV9sVpJZwfQyV0nfvJI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DqYS07xUBG+LsdE7IRbYaO65M+inFXRqsRjmOo73GTDzoUx/WHvo84TOVx3VXmDek
 x3ykgOTLenp82k55YoHNYlpwJzJ3q69FxwuldDaUhTFB9921LEPiDaHldLqcgWFbs5
 jEheFkh46jTokPoUG5SeTXjTMfI4TJPtvWKQxIpqSYWc6uf9KUkdSIT4l7QNuPA8A7
 8En4JyYqAGyNFqgL32p1CQDraU61H7dqlnAovRu1bUFKl0eXfrB/un1fblDTn7E3zN
 nwdm8b5eaiuR4ov5pSaDKB6GPz6qwCZ0ZyDD/NIA2GU9/Je9frtOksOJpxug7TAA8S
 pxHS5/W7S3xPQ==
Received: by wens.tw (Postfix, from userid 1000)
 id E7C8B5FBEA; Mon, 12 Feb 2024 21:51:24 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/5] rockchip: rk3399: regenerate defconfigs
Date: Mon, 12 Feb 2024 21:51:07 +0800
Message-Id: <20240212135111.1767734-5-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212135111.1767734-1-wens@kernel.org>
References: <20240212135111.1767734-1-wens@kernel.org>
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
Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 configs/chromebook_bob_defconfig             | 3 ---
 configs/chromebook_kevin_defconfig           | 3 ---
 configs/eaidk-610-rk3399_defconfig           | 1 -
 configs/evb-rk3399_defconfig                 | 1 -
 configs/firefly-rk3399_defconfig             | 3 ---
 configs/khadas-edge-captain-rk3399_defconfig | 1 -
 configs/khadas-edge-rk3399_defconfig         | 1 -
 configs/khadas-edge-v-rk3399_defconfig       | 1 -
 configs/leez-rk3399_defconfig                | 1 -
 configs/nanopc-t4-rk3399_defconfig           | 1 -
 configs/nanopi-m4-2gb-rk3399_defconfig       | 1 -
 configs/nanopi-m4-rk3399_defconfig           | 1 -
 configs/nanopi-m4b-rk3399_defconfig          | 1 -
 configs/nanopi-neo4-rk3399_defconfig         | 1 -
 configs/nanopi-r4s-rk3399_defconfig          | 3 ---
 configs/orangepi-rk3399_defconfig            | 1 -
 configs/pinebook-pro-rk3399_defconfig        | 3 ---
 configs/pinephone-pro-rk3399_defconfig       | 3 ---
 configs/puma-rk3399_defconfig                | 3 ---
 configs/roc-pc-mezzanine-rk3399_defconfig    | 3 ---
 configs/roc-pc-rk3399_defconfig              | 3 ---
 configs/rock-4c-plus-rk3399_defconfig        | 3 ---
 configs/rock-4se-rk3399_defconfig            | 3 ---
 configs/rock-pi-4-rk3399_defconfig           | 3 ---
 configs/rock-pi-4c-rk3399_defconfig          | 3 ---
 configs/rock-pi-n10-rk3399pro_defconfig      | 2 --
 configs/rock960-rk3399_defconfig             | 2 --
 configs/rockpro64-rk3399_defconfig           | 3 ---
 28 files changed, 58 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index b5a5ae737e52..989a8211f64d 100644
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
@@ -67,8 +66,6 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 20913d2cf0fe..07a96aa18989 100644
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
@@ -68,8 +67,6 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 22ad98b95ad3..0ca4cebc4d90 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index d6140527b752..1d1e55162290 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -43,7 +43,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index b7c8e95b7b89..2fe38f81c50d 100644
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
@@ -45,8 +44,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 7f4e48a4e750..28a59899e1cb 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -43,7 +43,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 9de8a53c1aea..075e28a509f4 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -42,7 +42,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index f31b8ecf6ee4..c65690ce3da7 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -43,7 +43,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 76dd91911c7c..2122018e7a3e 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -39,7 +39,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index c18e7b1bd169..c1617d740112 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -43,7 +43,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index e3bdbccccbec..4d70fde6b14d 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index e51e51c8cf5c..a96fe0306dad 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index ca57c7f81a51..c8faccb233a5 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 02e7f4e2ecb7..1c4ffbb44041 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index cacaab14d21f..f97c06412f07 100644
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
@@ -41,8 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index 27add8a29b92..bc2c4782efbc 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -40,7 +40,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index de357415fbe4..3083d0a8bb77 100644
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
@@ -60,8 +59,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index d08224fe536b..454cb7eec76b 100644
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
@@ -59,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index c2aa02ec74bd..7e76ec5076f9 100644
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
@@ -67,8 +66,6 @@ CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index de6539bedf48..8d4153ea5f0e 100644
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
@@ -55,8 +54,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 7123a7a07299..3824eb22d3da 100644
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
@@ -55,8 +54,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 18525c8bf504..67ad54610a72 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -21,7 +21,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4c-plus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -52,8 +51,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 171de23ec8f6..b0993bb81020 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -53,8 +52,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 83fc4ad7dabc..2df3cd41e16c 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -54,8 +53,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 089344097e0c..bac745202bc7 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -21,7 +21,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x2e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -52,8 +51,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index dc4b3b40380a..e86df4b7456a 100644
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
@@ -47,7 +46,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index b93dda56593b..a9cae27ccd2f 100644
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
@@ -50,7 +49,6 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 711541f84627..b9c885cfee55 100644
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
@@ -63,8 +62,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.39.2

