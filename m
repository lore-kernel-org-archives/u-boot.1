Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD8C3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D3488808;
	Mon, 29 Jul 2024 01:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB3E87DB6; Sun, 28 Jul 2024 22:26:50 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9564E88276
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 6F4B41F0004B
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:26:29 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 001FBA11FC7; Sun, 28 Jul 2024 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 677F3A11FBE;
 Sun, 28 Jul 2024 20:25:19 +0000 (UTC)
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
Subject: [PATCH 05/12] am43xx: Define common init stack pointer address in
 Kconfig
Date: Sun, 28 Jul 2024 22:24:54 +0200
Message-ID: <20240728202501.3204905-6-paulk@sys-base.io>
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

The init stack pointer was defined to the same value in each AM43xx
board defconfig. Move the common definition to the Kconfig option
declaration instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Kconfig                                   | 3 ++-
 configs/am43xx_evm_defconfig              | 2 --
 configs/am43xx_evm_qspiboot_defconfig     | 2 --
 configs/am43xx_evm_rtconly_defconfig      | 2 --
 configs/am43xx_evm_usbhost_boot_defconfig | 2 --
 configs/am43xx_hs_evm_defconfig           | 2 --
 configs/am43xx_hs_evm_qspi_defconfig      | 2 --
 configs/cm_t43_defconfig                  | 2 --
 8 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/Kconfig b/Kconfig
index 45656e90b917..19ce371a9cc2 100644
--- a/Kconfig
+++ b/Kconfig
@@ -236,7 +236,7 @@ config SYS_BOOT_GET_KBD
 config HAS_CUSTOM_SYS_INIT_SP_ADDR
 	bool "Use a custom location for the initial stack pointer address"
 	depends on ARC || (ARM && !INIT_SP_RELATIVE) || MIPS || PPC || RISCV
-	default y if OMAP34XX || AM33XX
+	default y if OMAP34XX || AM33XX || AM43XX
 	default y if TFABOOT
 	help
 	  Typically, we use an initial stack pointer address that is calculated
@@ -252,6 +252,7 @@ config CUSTOM_SYS_INIT_SP_ADDR
 	depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
 	default 0x4020ff00 if OMAP34XX
 	default 0x4030ff00 if AM33XX
+	default 0x4033ff00 if AM43XX
 	default TEXT_BASE if TFABOOT
 
 config SYS_MALLOC_F
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index d73b1cb804b0..0fc4c0f269a8 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -3,8 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 89e212595af9..c538c1ae352f 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x30000000
 CONFIG_SYS_MALLOC_F_LEN=0x400
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index 2ff011932853..0fe5479757bf 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -3,8 +3,6 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index 845b686ac93f..c4693bc98249 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -2,8 +2,6 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index ff5073cbb2ba..980ef13f1045 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 5ef59d830e5e..75725e179d79 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 # CONFIG_SYS_THUMB_BUILD is not set
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 32f126a51744..e8603886d6a6 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -5,8 +5,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4033ff00
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0xC0000
-- 
2.45.2

