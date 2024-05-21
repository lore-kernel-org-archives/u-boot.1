Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC06C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC23887CB;
	Tue, 21 May 2024 19:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510A5887E8; Tue, 21 May 2024 19:40:15 +0200 (CEST)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5412688758
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VkMCK02jkzCbZ;
 Tue, 21 May 2024 19:40:13 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VkMCJ34ckz8ql; Tue, 21 May 2024 19:40:12 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 21 May 2024 19:40:00 +0200
Subject: [PATCH 07/10] rockchip: px30-core-*: Use common bss and stack
 addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-px30-2024-07-rc-v1-7-62109c84d44f@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
In-Reply-To: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

U-Boot proper pre-reloc is currently running out of memory on PX30
Ringneck and it is thus impossible to boot into U-Boot CLI. It is
assumed the same problem can be seen on other PX30 boards though I
cannot guarantee it since I don't have access to them.

Fix this by migrating to the common bss and stack addresses for PX30,
which drastically increases the size of the pre-reloc allocation pool (8
times bigger now). The memory layout in SPL and U-Boot proper now
match the other SoCs' using ROCKCHIP_COMMON_STACK_ADDR.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/px30-core-ctouch2-of10-px30_defconfig | 18 +++---------------
 configs/px30-core-ctouch2-px30_defconfig      | 18 +++---------------
 configs/px30-core-edimm2.2-px30_defconfig     | 18 +++---------------
 3 files changed, 9 insertions(+), 45 deletions(-)

diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 87a39e115df..dd005f20ff8 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -2,27 +2,15 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
 CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-ctouch2-of10"
-CONFIG_SPL_TEXT_BASE=0x00000000
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
+# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-CONFIG_TPL_LIBGENERIC_SUPPORT=y
+# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
-CONFIG_SPL_STACK=0x400000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BSS_MAX_SIZE=0x4000
-CONFIG_SPL_STACK_R=y
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -40,9 +28,9 @@ CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
+# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_TPL_BANNER_PRINT is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index 7162c117beb..f6559fbae3a 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -2,27 +2,15 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
 CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-ctouch2"
-CONFIG_SPL_TEXT_BASE=0x00000000
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
+# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-CONFIG_TPL_LIBGENERIC_SUPPORT=y
+# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
-CONFIG_SPL_STACK=0x400000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BSS_MAX_SIZE=0x4000
-CONFIG_SPL_STACK_R=y
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -40,9 +28,9 @@ CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
+# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_TPL_BANNER_PRINT is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 1182f60358f..a099e9378c9 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -2,27 +2,15 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00200000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x400000
 CONFIG_DEFAULT_DEVICE_TREE="px30-engicam-px30-core-edimm2.2"
-CONFIG_SPL_TEXT_BASE=0x00000000
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
+# CONFIG_TPL_ROCKCHIP_COMMON_BOARD is not set
 CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
-CONFIG_TPL_LIBGENERIC_SUPPORT=y
+# CONFIG_TPL_LIBCOMMON_SUPPORT is not set
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x600000
-CONFIG_SPL_STACK=0x400000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x4000000
-CONFIG_SPL_BSS_MAX_SIZE=0x4000
-CONFIG_SPL_STACK_R=y
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -40,9 +28,9 @@ CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
+# CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
 # CONFIG_TPL_BANNER_PRINT is not set
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_ELF is not set

-- 
2.45.1

