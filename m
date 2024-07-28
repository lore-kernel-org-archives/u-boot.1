Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A4CC3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D008886A;
	Mon, 29 Jul 2024 01:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD5988276; Sun, 28 Jul 2024 22:27:46 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7E887F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 284DD1F0008B
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:27:07 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 9F869A11FC0; Sun, 28 Jul 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 549A0A11FC2;
 Sun, 28 Jul 2024 20:25:26 +0000 (UTC)
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
Subject: [PATCH 09/12] omap3: Define maximum SPL size in Kconfig instead of
 defconfigs
Date: Sun, 28 Jul 2024 22:24:58 +0200
Message-ID: <20240728202501.3204905-10-paulk@sys-base.io>
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

The maximum SPL size was defined to the same value in each OMAP3
board defconfig. Move the common definition to the Kconfig option
declaration instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 common/spl/Kconfig                   | 1 +
 configs/am3517_evm_defconfig         | 1 -
 configs/devkit8000_defconfig         | 1 -
 configs/igep00x0_defconfig           | 1 -
 configs/omap35_logic_defconfig       | 1 -
 configs/omap35_logic_somlv_defconfig | 1 -
 configs/omap3_evm_defconfig          | 1 -
 configs/omap3_logic_defconfig        | 1 -
 configs/omap3_logic_somlv_defconfig  | 1 -
 configs/sniper_defconfig             | 1 -
 10 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6fc97f4ccbd8..3fd113d776b7 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -78,6 +78,7 @@ config SPL_MAX_SIZE
 	hex "Maximum size of the SPL image, excluding BSS"
 	default 0x30000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x1b000 if AM33XX && !TI_SECURE_DEVICE
+	default 0xec00 if OMAP34XX
 	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x7fa0 if SUNXI_SRAM_ADDRESS = 0x10000
 	default 0x7fa0 if SUNXI_SRAM_ADDRESS = 0x20000 && !MACH_SUN50I_H616
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index a6e3a03ec143..f492053aa0f4 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -17,7 +17,6 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=10
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then echo SD/MMC found on device $mmcdev; if run loadbootenv; then run importbootenv; fi; echo Checking if uenvcmd is set ...; if test -n $uenvcmd; then echo Running uenvcmd ...; run uenvcmd; fi; echo Running default loadimage ...; setenv bootfile zImage; if run loadimage; then run loadfdt; run mmcboot; fi; else run nandboot; fi"
 CONFIG_SYS_PBSIZE=1054
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index b78a567aef75..6c54dba5b4d3 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -13,7 +13,6 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run autoboot"
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 761f5c31e832..04bd464780e5 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -18,7 +18,6 @@ CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index 539cb15157e3..dca2bc32decc 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -20,7 +20,6 @@ CONFIG_PREBOOT="setenv preboot;saveenv;"
 CONFIG_DEFAULT_FDT_FILE="logicpd-torpedo-35xx-devkit.dtb"
 CONFIG_SYS_PBSIZE=1054
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index 3039e2960488..3cbc1f0bff11 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -21,7 +21,6 @@ CONFIG_PREBOOT="setenv preboot;saveenv;"
 CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-35xx-devkit.dtb"
 CONFIG_SYS_PBSIZE=1054
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index c502542a79d0..032a9bebfc9c 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -14,7 +14,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="omap3-evm.dtb"
 CONFIG_SYS_PBSIZE=1053
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 522052d7eb40..4e94170afb1e 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -19,7 +19,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="setenv preboot;saveenv;"
 CONFIG_SYS_PBSIZE=1054
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 5c15e87a4584..97a936f31d75 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -21,7 +21,6 @@ CONFIG_PREBOOT="setenv preboot;saveenv;"
 CONFIG_DEFAULT_FDT_FILE="logicpd-som-lv-37xx-devkit.dtb"
 CONFIG_SYS_PBSIZE=1054
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_MAX_SIZE=0xec00
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 35cfc28006c1..cd0f48528f42 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -14,7 +14,6 @@ CONFIG_BOOTCOMMAND="setenv boot_mmc_part ${kernel_mmc_part}; if test reboot-${re
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=538
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-CONFIG_SPL_MAX_SIZE=0xec00
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-- 
2.45.2

