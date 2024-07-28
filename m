Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD29C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D3788827;
	Mon, 29 Jul 2024 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE09D88677; Sun, 28 Jul 2024 22:27:19 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC6387F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 05A9E1F00036
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:26:48 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 69AC7A11FC5; Sun, 28 Jul 2024 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 52734A11FBA;
 Sun, 28 Jul 2024 20:25:20 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>,
 =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D . Woods" <woods.technical@gmail.com>,
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 07/12] dra7xx: Define common init stack pointer address in
 Kconfig
Date: Sun, 28 Jul 2024 22:24:56 +0200
Message-ID: <20240728202501.3204905-8-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240728202501.3204905-1-paulk@sys-base.io>
References: <20240728202501.3204905-1-paulk@sys-base.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jul 2024 01:59:10 +0200
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

From: Paul Kocialkowski <contact@paulk.fr>

The init stack pointer was defined to the same value in each DRA7xx
board defconfig. Move the common definition to the Kconfig option
declaration instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Kconfig                             | 3 ++-
 configs/am57xx_evm_defconfig        | 2 --
 configs/am57xx_hs_evm_defconfig     | 2 --
 configs/am57xx_hs_evm_usb_defconfig | 2 --
 configs/dra7xx_evm_defconfig        | 2 --
 configs/dra7xx_hs_evm_defconfig     | 2 --
 configs/dra7xx_hs_evm_usb_defconfig | 2 --
 7 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/Kconfig b/Kconfig
index 19ce371a9cc2..70c26b4ce76d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -236,7 +236,7 @@ config SYS_BOOT_GET_KBD
 config HAS_CUSTOM_SYS_INIT_SP_ADDR
 	bool "Use a custom location for the initial stack pointer address"
 	depends on ARC || (ARM && !INIT_SP_RELATIVE) || MIPS || PPC || RISCV
-	default y if OMAP34XX || AM33XX || AM43XX
+	default y if OMAP34XX || AM33XX || AM43XX || DRA7XX
 	default y if TFABOOT
 	help
 	  Typically, we use an initial stack pointer address that is calculated
@@ -253,6 +253,7 @@ config CUSTOM_SYS_INIT_SP_ADDR
 	default 0x4020ff00 if OMAP34XX
 	default 0x4030ff00 if AM33XX
 	default 0x4033ff00 if AM43XX
+	default 0x4037ff00 if DRA7XX
 	default TEXT_BASE if TFABOOT
 
 config SYS_MALLOC_F
diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 7c3ceeb07db0..145c6d8e5855 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -2,8 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 1f7eca4691ee..850fce024f1d 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index 807e1d66a6d7..d1ef82b7bcb2 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index dd2378801249..244d5351bd83 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index b698a36eb838..225f279572d5 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -4,8 +4,6 @@ CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 40f47a3adb1e..3b37355654ce 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -4,8 +4,6 @@ CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-- 
2.45.2

