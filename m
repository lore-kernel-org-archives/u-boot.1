Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CD9C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC3B888A4;
	Mon, 29 Jul 2024 22:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E041888A3; Mon, 29 Jul 2024 22:45:14 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF0A888B7
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id E757F1F0004B
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:44:57 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 28EEEA12587; Mon, 29 Jul 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 3CA45A1258B;
 Mon, 29 Jul 2024 20:44:41 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 3/3] omap3: sniper: Convert to device-tree control and DM I2C
Date: Mon, 29 Jul 2024 22:44:39 +0200
Message-ID: <20240729204439.429900-3-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729204439.429900-1-paulk@sys-base.io>
References: <20240729204439.429900-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

This converts the sniper board (LG P970) to device-tree control
and DM I2C, both for SPL and U-Boot.

Note that we lose the call to board_mmc_power_init to enable power
for MMC2. This is now expected to take place through proper
regulators, which are not yet available with the twl4030 driver.
The call to twl4030_power_mmc_init is moved to spl_board_init for now.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/dts/omap3-sniper-u-boot.dtsi | 16 +++++++++++++++
 board/lg/sniper/sniper.c              | 29 +++++----------------------
 configs/sniper_defconfig              | 13 +++++++-----
 3 files changed, 29 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/dts/omap3-sniper-u-boot.dtsi

diff --git a/arch/arm/dts/omap3-sniper-u-boot.dtsi b/arch/arm/dts/omap3-sniper-u-boot.dtsi
new file mode 100644
index 000000000000..d467f533a123
--- /dev/null
+++ b/arch/arm/dts/omap3-sniper-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Paul Kocialkowski <contact@paulk.fr>
+ */
+
+#include "omap3-u-boot.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+};
diff --git a/board/lg/sniper/sniper.c b/board/lg/sniper/sniper.c
index 88d5d0881433..9d0959f294e8 100644
--- a/board/lg/sniper/sniper.c
+++ b/board/lg/sniper/sniper.c
@@ -14,11 +14,9 @@
 #include <linux/ctype.h>
 #include <linux/usb/musb.h>
 #include <asm/omap_musb.h>
-#include <asm/arch/mmc_host_def.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mem.h>
 #include <asm/io.h>
-#include <ns16550.h>
 #include <twl4030.h>
 #include "sniper.h"
 
@@ -30,18 +28,6 @@ const omap3_sysinfo sysinfo = {
 	.nand_string = "MMC"
 };
 
-static const struct ns16550_plat serial_omap_plat = {
-	.base = OMAP34XX_UART3,
-	.reg_shift = 2,
-	.clock = V_NS16550_CLK,
-	.fcr = UART_FCR_DEFVAL,
-};
-
-U_BOOT_DRVINFO(sniper_serial) = {
-	.name = "ns16550_serial",
-	.plat = &serial_omap_plat
-};
-
 #if defined(CONFIG_USB_MUSB_HOST) || defined(CONFIG_USB_MUSB_GADGET)
 static struct musb_hdrc_config musb_config = {
 	.multipoint = 1,
@@ -77,6 +63,11 @@ void get_board_mem_timings(struct board_sdrc_timings *timings)
 	timings->rfr_ctrl = SDP_3430_SDRC_RFR_CTRL_200MHz;
 	timings->mr = MICRON_V_MR_165;
 }
+
+void spl_board_init(void)
+{
+	twl4030_power_mmc_init(1);
+}
 #endif
 
 int board_init(void)
@@ -188,13 +179,3 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 
 	return omap_reboot_mode_store("b");
 }
-
-int board_mmc_init(struct bd_info *bis)
-{
-	return omap_mmc_init(1, 0, 0, -1, -1);
-}
-
-void board_mmc_power_init(void)
-{
-	twl4030_power_mmc_init(1);
-}
diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 5c6f9328bf8b..06e9b2ae2faf 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -1,12 +1,14 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/omap3-sniper"
 CONFIG_TARGET_SNIPER=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="setenv boot_mmc_part ${kernel_mmc_part}; if test reboot-${reboot-mode} = reboot-r; then echo recovery; setenv boot_mmc_part ${recovery_mmc_part}; fi; if test reboot-${reboot-mode} = reboot-b; then echo fastboot; fastboot 0; fi; part start mmc ${boot_mmc_dev} ${boot_mmc_part} boot_mmc_start; part size mmc ${boot_mmc_dev} ${boot_mmc_part} boot_mmc_size; mmc dev ${boot_mmc_dev}; mmc read ${kernel_addr_r} ${boot_mmc_start} ${boot_mmc_size} && bootm ${kernel_addr_r};"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
@@ -19,12 +21,13 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SPL_DM=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_TWL4030_INPUT=y
 CONFIG_MMC_OMAP_HS=y
-CONFIG_CONS_INDEX=3
-CONFIG_OF_LIBFDT=y
-- 
2.45.2

