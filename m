Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4CDC3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132398885E;
	Mon, 29 Jul 2024 01:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7773B88276; Sun, 28 Jul 2024 22:27:33 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB0387F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id C89C21F00059
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:26:57 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 46263A11FCA; Sun, 28 Jul 2024 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id CD778A11FC0;
 Sun, 28 Jul 2024 20:25:25 +0000 (UTC)
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
Subject: [PATCH 08/12] omap3: Define maximum U-Boot size in Kconfig instead of
 defconfigs
Date: Sun, 28 Jul 2024 22:24:57 +0200
Message-ID: <20240728202501.3204905-9-paulk@sys-base.io>
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

The maximum U-Boot size was defined to the same value in each OMAP3
board defconfig. Move the common definition to the Kconfig option
declaration instead.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Kconfig                              | 1 +
 configs/am3517_evm_defconfig         | 1 -
 configs/devkit8000_defconfig         | 1 -
 configs/igep00x0_defconfig           | 1 -
 configs/omap35_logic_defconfig       | 1 -
 configs/omap35_logic_somlv_defconfig | 1 -
 configs/omap3_evm_defconfig          | 1 -
 configs/omap3_logic_defconfig        | 1 -
 configs/omap3_logic_somlv_defconfig  | 1 -
 9 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Kconfig b/Kconfig
index 70c26b4ce76d..69e8b17b7933 100644
--- a/Kconfig
+++ b/Kconfig
@@ -620,6 +620,7 @@ config SYS_SRAM_SIZE
 config SYS_MONITOR_LEN
 	int "Maximum size in bytes reserved for U-Boot in memory"
 	default 1048576 if X86
+	default 262144 if OMAP34XX
 	default 786432 if ARCH_SUNXI
 	default 0
 	help
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index 114d1a22f4a3..a6e3a03ec143 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -10,7 +10,6 @@ CONFIG_ENV_SOURCE_FILE="am3517evm"
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am3517-evm"
 CONFIG_TARGET_AM3517_EVM=y
 CONFIG_EMIF4=y
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2500
 CONFIG_SPL=y
 CONFIG_LTO=y
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index d68bb8bfd37b..b78a567aef75 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="omap3-devkit8000"
 CONFIG_TARGET_DEVKIT8000=y
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL_BSS_START_ADDR=0x80000500
 CONFIG_SPL=y
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 493395847255..761f5c31e832 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -8,7 +8,6 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x8000
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-igep0020"
 CONFIG_TARGET_OMAP3_IGEP00X0=y
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index ca1b97a26d9e..539cb15157e3 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-35xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
 CONFIG_ANDROID_BOOT_IMAGE=y
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index 3b0bc6d1eaf9..3039e2960488 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-35xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
 CONFIG_SYS_MONITOR_BASE=0x10000000
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index d7a3fc4b25b9..c502542a79d0 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -6,7 +6,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="omap3-evm"
 CONFIG_TARGET_OMAP3_EVM=y
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 52e2e459dbb0..522052d7eb40 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-37xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
 CONFIG_ANDROID_BOOT_IMAGE=y
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 64bb401f7ac9..5c15e87a4584 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -10,7 +10,6 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-37xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
-CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SPL=y
 CONFIG_LTO=y
 CONFIG_SYS_MONITOR_BASE=0x10000000
-- 
2.45.2

