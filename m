Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B1C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ABB88874;
	Mon, 29 Jul 2024 01:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A4F888276; Sun, 28 Jul 2024 22:28:02 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDDA87F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id E67D01F0007F
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:27:17 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 64279A11FC8; Sun, 28 Jul 2024 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id C56D8A11FC4;
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
Subject: [PATCH 10/12] omap3: Define DRAM banks number in Kconfig instead of
 defconfigs
Date: Sun, 28 Jul 2024 22:24:59 +0200
Message-ID: <20240728202501.3204905-11-paulk@sys-base.io>
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

The number of DRAM banks was defined to the same value in each OMAP3
board defconfig, which is expected and hardcoded in the code. Move the
common definition to the Kconfig option declaration instead.

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
 configs/sniper_defconfig             | 1 -
 10 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/Kconfig b/Kconfig
index 69e8b17b7933..8b7b213ffec0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -209,6 +209,7 @@ config ENV_VARS_UBOOT_CONFIG
 config NR_DRAM_BANKS
 	int "Number of DRAM banks"
 	default 1 if ARCH_SUNXI || ARCH_OWL
+	default 2 if OMAP34XX
 	default 4
 	help
 	  This defines the number of DRAM banks.
diff --git a/configs/am3517_evm_defconfig b/configs/am3517_evm_defconfig
index f492053aa0f4..4eb406673ff5 100644
--- a/configs/am3517_evm_defconfig
+++ b/configs/am3517_evm_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="am3517evm"
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am3517-evm"
 CONFIG_TARGET_AM3517_EVM=y
diff --git a/configs/devkit8000_defconfig b/configs/devkit8000_defconfig
index 6c54dba5b4d3..33201cec7726 100644
--- a/configs/devkit8000_defconfig
+++ b/configs/devkit8000_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="omap3-devkit8000"
 CONFIG_TARGET_DEVKIT8000=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 04bd464780e5..f1d9bb34abae 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x8000
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-igep0020"
 CONFIG_TARGET_OMAP3_IGEP00X0=y
diff --git a/configs/omap35_logic_defconfig b/configs/omap35_logic_defconfig
index dca2bc32decc..843b61dec4a6 100644
--- a/configs/omap35_logic_defconfig
+++ b/configs/omap35_logic_defconfig
@@ -6,7 +6,6 @@ CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 # CONFIG_SPL_GPIO is not set
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-35xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
diff --git a/configs/omap35_logic_somlv_defconfig b/configs/omap35_logic_somlv_defconfig
index 3cbc1f0bff11..bbd1b746cf90 100644
--- a/configs/omap35_logic_somlv_defconfig
+++ b/configs/omap35_logic_somlv_defconfig
@@ -6,7 +6,6 @@ CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 # CONFIG_SPL_GPIO is not set
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-35xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 032a9bebfc9c..cc0b61af509e 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARM=y
 # CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="omap3-evm"
 CONFIG_TARGET_OMAP3_EVM=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
diff --git a/configs/omap3_logic_defconfig b/configs/omap3_logic_defconfig
index 4e94170afb1e..ed04386cf95f 100644
--- a/configs/omap3_logic_defconfig
+++ b/configs/omap3_logic_defconfig
@@ -6,7 +6,6 @@ CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 # CONFIG_SPL_GPIO is not set
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-torpedo-37xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
diff --git a/configs/omap3_logic_somlv_defconfig b/configs/omap3_logic_somlv_defconfig
index 97a936f31d75..c5d76d0d0860 100644
--- a/configs/omap3_logic_somlv_defconfig
+++ b/configs/omap3_logic_somlv_defconfig
@@ -6,7 +6,6 @@ CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 # CONFIG_SPL_GPIO is not set
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_DEFAULT_DEVICE_TREE="ti/omap/logicpd-som-lv-37xx-devkit"
 CONFIG_TARGET_OMAP3_LOGIC=y
 # CONFIG_SPL_OMAP3_ID_NAND is not set
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index cd0f48528f42..08ab3a66c51a 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x120000
 CONFIG_SYS_MALLOC_F_LEN=0x400
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_TARGET_SNIPER=y
 CONFIG_SPL_STACK=0x4020fffc
 CONFIG_SPL_BSS_START_ADDR=0x80000000
-- 
2.45.2

