Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E805C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AF9887F3;
	Mon, 29 Jul 2024 01:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D5187DB6; Sun, 28 Jul 2024 22:26:44 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3C08806A
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id C90D21F0006A
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:26:19 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id DFAFAA11FC9; Sun, 28 Jul 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id D8738A11FBC;
 Sun, 28 Jul 2024 20:25:14 +0000 (UTC)
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
Subject: [PATCH 04/12] am33xx: Define common init stack pointer address in
 Kconfig
Date: Sun, 28 Jul 2024 22:24:53 +0200
Message-ID: <20240728202501.3204905-5-paulk@sys-base.io>
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

The init stack pointer was defined to the same value in each AM33xx
board defconfig. Move the common definition to the Kconfig option
declaration instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Kconfig                                   | 3 ++-
 configs/am335x_baltos_defconfig           | 2 --
 configs/am335x_evm_defconfig              | 2 --
 configs/am335x_evm_spiboot_defconfig      | 2 --
 configs/am335x_guardian_defconfig         | 2 --
 configs/am335x_hs_evm_defconfig           | 2 --
 configs/am335x_hs_evm_uart_defconfig      | 2 --
 configs/am335x_igep003x_defconfig         | 2 --
 configs/am335x_pdu001_defconfig           | 2 --
 configs/am335x_shc_defconfig              | 2 --
 configs/am335x_shc_ict_defconfig          | 2 --
 configs/am335x_shc_netboot_defconfig      | 2 --
 configs/am335x_shc_sdboot_defconfig       | 2 --
 configs/am335x_sl50_defconfig             | 2 --
 configs/brppt1_mmc_defconfig              | 2 --
 configs/brsmarc1_defconfig                | 2 --
 configs/brxre1_defconfig                  | 2 --
 configs/chiliboard_defconfig              | 2 --
 configs/draco-etamin_defconfig            | 2 --
 configs/draco-rastaban_defconfig          | 2 --
 configs/draco-thuban_defconfig            | 2 --
 configs/pcm051_rev3_defconfig             | 2 --
 configs/phycore-am335x-r2-regor_defconfig | 2 --
 configs/phycore-am335x-r2-wega_defconfig  | 2 --
 configs/pxm2_defconfig                    | 2 --
 configs/rut_defconfig                     | 2 --
 26 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/Kconfig b/Kconfig
index 98175a8f3362..45656e90b917 100644
--- a/Kconfig
+++ b/Kconfig
@@ -236,7 +236,7 @@ config SYS_BOOT_GET_KBD
 config HAS_CUSTOM_SYS_INIT_SP_ADDR
 	bool "Use a custom location for the initial stack pointer address"
 	depends on ARC || (ARM && !INIT_SP_RELATIVE) || MIPS || PPC || RISCV
-	default y if OMAP34XX
+	default y if OMAP34XX || AM33XX
 	default y if TFABOOT
 	help
 	  Typically, we use an initial stack pointer address that is calculated
@@ -251,6 +251,7 @@ config CUSTOM_SYS_INIT_SP_ADDR
 	hex "Static location for the initial stack pointer"
 	depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
 	default 0x4020ff00 if OMAP34XX
+	default 0x4030ff00 if AM33XX
 	default TEXT_BASE if TFABOOT
 
 config SYS_MALLOC_F
diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index f8dfd1d20602..14d8d96a8656 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_DEFAULT_DEVICE_TREE="am335x-baltos"
 CONFIG_AM33XX=y
 CONFIG_TARGET_AM335X_BALTOS=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index cabc181460ab..5dd0b3288353 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -2,8 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
 CONFIG_AM33XX=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 8239f5f84dae..a55aace02460 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -2,8 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index e68bada6c13c..6b40d398392c 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x500000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-guardian"
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index 3694cc32db95..d780239715f5 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
 CONFIG_SPL_TEXT_BASE=0x40300350
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index a99b7b46cfba..bd979941b7a2 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
 CONFIG_SPL_TEXT_BASE=0x40301950
diff --git a/configs/am335x_igep003x_defconfig b/configs/am335x_igep003x_defconfig
index ddffd4f46f0f..ef4d8661a131 100644
--- a/configs/am335x_igep003x_defconfig
+++ b/configs/am335x_igep003x_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x18000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-base0033"
 CONFIG_AM33XX=y
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index febe5ebaabb2..f6b7d9c88ebd 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x1200
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-pdu001"
diff --git a/configs/am335x_shc_defconfig b/configs/am335x_shc_defconfig
index 47c08e5054b3..f2cf35c4c331 100644
--- a/configs/am335x_shc_defconfig
+++ b/configs/am335x_shc_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x7000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-shc"
diff --git a/configs/am335x_shc_ict_defconfig b/configs/am335x_shc_ict_defconfig
index c7618c5c799c..f30c2661100d 100644
--- a/configs/am335x_shc_ict_defconfig
+++ b/configs/am335x_shc_ict_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x7000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-shc"
diff --git a/configs/am335x_shc_netboot_defconfig b/configs/am335x_shc_netboot_defconfig
index 934265815beb..e9262fdf3713 100644
--- a/configs/am335x_shc_netboot_defconfig
+++ b/configs/am335x_shc_netboot_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x7000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-shc"
diff --git a/configs/am335x_shc_sdboot_defconfig b/configs/am335x_shc_sdboot_defconfig
index 439f9b8188ad..887b6aa6feb9 100644
--- a/configs/am335x_shc_sdboot_defconfig
+++ b/configs/am335x_shc_sdboot_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x7000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-shc"
diff --git a/configs/am335x_sl50_defconfig b/configs/am335x_sl50_defconfig
index 88122bd052c8..3e539c8d54e4 100644
--- a/configs/am335x_sl50_defconfig
+++ b/configs/am335x_sl50_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="am335x-sl50"
 CONFIG_AM33XX=y
diff --git a/configs/brppt1_mmc_defconfig b/configs/brppt1_mmc_defconfig
index 0b2ee74b003f..09e061350bc8 100644
--- a/configs/brppt1_mmc_defconfig
+++ b/configs/brppt1_mmc_defconfig
@@ -6,8 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x40000
 CONFIG_DM_GPIO=y
diff --git a/configs/brsmarc1_defconfig b/configs/brsmarc1_defconfig
index f584b8d30b1f..5ec55f34f697 100644
--- a/configs/brsmarc1_defconfig
+++ b/configs/brsmarc1_defconfig
@@ -4,8 +4,6 @@ CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x20000
diff --git a/configs/brxre1_defconfig b/configs/brxre1_defconfig
index 6c27f07fc794..0663a597847a 100644
--- a/configs/brxre1_defconfig
+++ b/configs/brxre1_defconfig
@@ -4,8 +4,6 @@ CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x40000
 CONFIG_DM_GPIO=y
diff --git a/configs/chiliboard_defconfig b/configs/chiliboard_defconfig
index da61c86e3961..25e162e938e3 100644
--- a/configs/chiliboard_defconfig
+++ b/configs/chiliboard_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x20000
 CONFIG_DM_GPIO=y
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index ba3f381f69f3..78ee5c1eb66f 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -5,8 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x980000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 43d29f5b11ab..81a349b730c6 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -5,8 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index b457b22fc64d..265c1138dfe7 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -5,8 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
diff --git a/configs/pcm051_rev3_defconfig b/configs/pcm051_rev3_defconfig
index 78469814af39..a4e467fa05ed 100644
--- a/configs/pcm051_rev3_defconfig
+++ b/configs/pcm051_rev3_defconfig
@@ -3,8 +3,6 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_SF_DEFAULT_SPEED=24000000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-wega-rdk"
 CONFIG_AM33XX=y
diff --git a/configs/phycore-am335x-r2-regor_defconfig b/configs/phycore-am335x-r2-regor_defconfig
index ac638c4e321f..d5056ccd98ea 100644
--- a/configs/phycore-am335x-r2-regor_defconfig
+++ b/configs/phycore-am335x-r2-regor_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_OFFSET=0xA0000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-regor-rdk"
 CONFIG_AM33XX=y
diff --git a/configs/phycore-am335x-r2-wega_defconfig b/configs/phycore-am335x-r2-wega_defconfig
index 98c621718654..5813d102475b 100644
--- a/configs/phycore-am335x-r2-wega_defconfig
+++ b/configs/phycore-am335x-r2-wega_defconfig
@@ -4,8 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_OFFSET=0xA0000
 CONFIG_DEFAULT_DEVICE_TREE="am335x-wega-rdk"
 CONFIG_AM33XX=y
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index c2f869391d73..30946b8f6b42 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -6,8 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-pxm50"
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index 7e78f1d64917..93d182a710c5 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -6,8 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-rut"
-- 
2.45.2

