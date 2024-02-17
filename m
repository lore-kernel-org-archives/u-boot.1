Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D903C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D51B87E9D;
	Sat, 17 Feb 2024 19:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GnGpor2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FDBB87CD4; Sat, 17 Feb 2024 19:37:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A107787E6C
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708194999; bh=fKlb+RTURq96bhBnZv9p7lcLv65kktVuKXEUIRAYVQM=;
 b=GnGpor2mjcyuYjTEvg8N4krqIXYS7CSG0sKk/xw2/Gt9GvhVW7pYk+zJDguHs38RIi2mLG+Xc
 iUWwC69Z+8bjEflHHYa39gW4jDbKV0G8mPtB9GGwRhfUwp61MCfKncY7h4j8Ij3/efN8e0OHzzs
 rvVllhX+VE/dDEwHRHYRiLnFfBFSC3VVRGYA8e/Q7KpJ0pTS04nH/X2wmyg9Qef6mVw7sMfUF4V
 e183YFlgtGAun/rUpHznX6dPbCbbmzh9ge7lCEr896uJtfUZf9VBlq7Sab6KxGRA86bNuxMBCew
 DOX3mOwK+xL63T76aVf7kLG9BucYQidoNcYs/E9gZTLQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 FUKAUMI Naoki <naoki@radxa.com>, Christopher Obbard
 <chris.obbard@collabora.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
Date: Sat, 17 Feb 2024 18:35:49 +0000
Message-ID: <20240217183610.2621132-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217183610.2621132-1-jonas@kwiboo.se>
References: <20240217183610.2621132-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d0fcb5af53a5c07f266c96
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

Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
into its own board target and update related defconfigs to use the new
TARGET_ROCKPI4_RK3399 option.

Also move the call to gpt_capsule_update_setup() from the weak function
rk_board_late_init() into the main board_late_init() function.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/board.c                | 10 +++---
 arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
 board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
 board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
 .../rockpi4-rk3399}/Makefile                  |  2 +-
 .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
 board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
 configs/rock-4c-plus-rk3399_defconfig         |  2 +-
 configs/rock-4se-rk3399_defconfig             |  2 +-
 configs/rock-pi-4-rk3399_defconfig            |  2 +-
 configs/rock-pi-4c-rk3399_defconfig           |  2 +-
 include/configs/rk3399_common.h               | 16 ----------
 include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
 13 files changed, 95 insertions(+), 65 deletions(-)
 create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
 create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
 rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile (79%)
 rename board/{rockchip/evb_rk3399/evb-rk3399.c => radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
 create mode 100644 include/configs/rockpi4-rk3399.h

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 4f666aee706f..dea5805c4665 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -34,7 +34,7 @@
 #include <asm/arch-rockchip/periph.h>
 #include <power/regulator.h>
 
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 
 #define DFU_ALT_BUF_LEN			SZ_1K
 
@@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
 
 __weak int rk_board_late_init(void)
 {
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
-	gpt_capsule_update_setup();
-#endif
-
 	return 0;
 }
 
@@ -196,6 +192,10 @@ int board_late_init(void)
 {
 	setup_boot_mode();
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+	gpt_capsule_update_setup();
+#endif
+
 	return rk_board_late_init();
 }
 
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index d01063ac98b6..bf3600aee2ad 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
 	   * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode only),
 	     1x USB 3.0 type C OTG
 
+config TARGET_ROCKPI4_RK3399
+	bool "Radxa ROCK Pi 4 board"
+	help
+	  Support for ROCK Pi 4 board family by Radxa.
+
 config TARGET_ROCKPRO64_RK3399
 	bool "Pine64 Rockpro64 board"
 	help
@@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
 source "board/pine64/pinebook-pro-rk3399/Kconfig"
 source "board/pine64/pinephone-pro-rk3399/Kconfig"
 source "board/pine64/rockpro64_rk3399/Kconfig"
+source "board/radxa/rockpi4-rk3399/Kconfig"
 source "board/rockchip/evb_rk3399/Kconfig"
 source "board/theobroma-systems/puma_rk3399/Kconfig"
 source "board/vamrs/rock960_rk3399/Kconfig"
diff --git a/board/radxa/rockpi4-rk3399/Kconfig b/board/radxa/rockpi4-rk3399/Kconfig
new file mode 100644
index 000000000000..d82663506b12
--- /dev/null
+++ b/board/radxa/rockpi4-rk3399/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_ROCKPI4_RK3399
+
+config SYS_BOARD
+	default "rockpi4-rk3399"
+
+config SYS_VENDOR
+	default "radxa"
+
+config SYS_CONFIG_NAME
+	default "rockpi4-rk3399"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+
+endif
diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS b/board/radxa/rockpi4-rk3399/MAINTAINERS
new file mode 100644
index 000000000000..12d4f35af881
--- /dev/null
+++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
@@ -0,0 +1,29 @@
+ROCK-PI-4
+M:	Jagan Teki <jagan@amarulasolutions.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	board/radxa/rockpi4-rk3399/
+F:	configs/rock-pi-4-rk3399_defconfig
+F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
+F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
+F:	arch/arm/dts/rk3399-rock-pi-4a.dts
+F:	arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
+F:	configs/rock-pi-4c-rk3399_defconfig
+F:	arch/arm/dts/rk3399-rock-pi-4c.dts
+F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
+
+ROCK-4C+
+M:	FUKAUMI Naoki <naoki@radxa.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/rock-4c-plus-rk3399_defconfig
+F:	arch/arm/dts/rk3399-rock-4c-plus.dts
+F:	arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
+
+ROCK-4SE
+M:	Christopher Obbard <chris.obbard@collabora.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/rock-4se-rk3399_defconfig
+F:	arch/arm/dts/rk3399-rock-4se.dts
+F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
diff --git a/board/rockchip/evb_rk3399/Makefile b/board/radxa/rockpi4-rk3399/Makefile
similarity index 79%
rename from board/rockchip/evb_rk3399/Makefile
rename to board/radxa/rockpi4-rk3399/Makefile
index aaa51c212e52..3d0225332275 100644
--- a/board/rockchip/evb_rk3399/Makefile
+++ b/board/radxa/rockpi4-rk3399/Makefile
@@ -4,4 +4,4 @@
 # SPDX-License-Identifier:     GPL-2.0+
 #
 
-obj-y	+= evb-rk3399.o
+obj-y	+= rockpi4-rk3399.o
diff --git a/board/rockchip/evb_rk3399/evb-rk3399.c b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
similarity index 79%
rename from board/rockchip/evb_rk3399/evb-rk3399.c
rename to board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
index ebdd74a7b97f..a533128b92fc 100644
--- a/board/rockchip/evb_rk3399/evb-rk3399.c
+++ b/board/radxa/rockpi4-rk3399/rockpi4-rk3399.c
@@ -3,13 +3,8 @@
  * (C) Copyright 2016 Rockchip Electronics Co., Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <efi_loader.h>
-#include <init.h>
-#include <log.h>
-#include <asm/arch-rockchip/periph.h>
-#include <linux/kernel.h>
 
 #define ROCKPI4_UPDATABLE_IMAGES	2
 
@@ -24,17 +19,15 @@ struct efi_capsule_update_info update_info = {
 #endif
 
 #ifndef CONFIG_SPL_BUILD
-#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && defined(CONFIG_EFI_PARTITION)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
 static bool board_is_rockpi_4b(void)
 {
-	return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
-		of_machine_is_compatible("radxa,rockpi4b");
+	return of_machine_is_compatible("radxa,rockpi4b");
 }
 
 static bool board_is_rockpi_4c(void)
 {
-	return CONFIG_IS_ENABLED(TARGET_EVB_RK3399) &&
-		of_machine_is_compatible("radxa,rockpi4c");
+	return of_machine_is_compatible("radxa,rockpi4c");
 }
 
 void rockchip_capsule_update_board_setup(void)
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index fa1f320f5a00..c1196e800e5e 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -95,35 +95,6 @@ F:	configs/orangepi-rk3399_defconfig
 F:	arch/arm/dts/rk3399-orangepi.dts
 F:	arch/arm/dts/rk3399-orangepi-u-boot.dtsi
 
-ROCK-4C+
-M:	FUKAUMI Naoki <naoki@radxa.com>
-R:	Jonas Karlman <jonas@kwiboo.se>
-S:	Maintained
-F:	configs/rock-4c-plus-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-4c-plus.dts
-F:	arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
-
-ROCK-4SE
-M:	Christopher Obbard <chris.obbard@collabora.com>
-R:	Jonas Karlman <jonas@kwiboo.se>
-S:	Maintained
-F:	configs/rock-4se-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-4se.dts
-F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
-
-ROCK-PI-4
-M:	Jagan Teki <jagan@amarulasolutions.com>
-R:	Jonas Karlman <jonas@kwiboo.se>
-S:	Maintained
-F:	configs/rock-pi-4-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-pi-4.dtsi
-F:	arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
-F:	arch/arm/dts/rk3399-rock-pi-4a.dts
-F:	arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
-F:	configs/rock-pi-4c-rk3399_defconfig
-F:	arch/arm/dts/rk3399-rock-pi-4c.dts
-F:	arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
-
 ROCK-PI-N10
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 94a9803ac6b5..8d4bfe902e8f 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-CONFIG_TARGET_EVB_RK3399=y
+CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index e27e4a221267..9acdf52a82f2 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-CONFIG_TARGET_EVB_RK3399=y
+CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index eb6727f22ae2..dcc9fd3084e3 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-CONFIG_TARGET_EVB_RK3399=y
+CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 247518c42b13..da2e7349f677 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-CONFIG_TARGET_EVB_RK3399=y
+CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index 96ba19c659bd..4e75771055b8 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -13,22 +13,6 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
-#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
-	EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
-		 0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
-
-#define ROCKPI_4B_UBOOT_IMAGE_GUID \
-	EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
-		 0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
-
-#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
-	EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
-		 0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
-
-#define ROCKPI_4C_UBOOT_IMAGE_GUID \
-	EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
-		 0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
-
 #ifndef CONFIG_SPL_BUILD
 
 #define ENV_MEM_LAYOUT_SETTINGS \
diff --git a/include/configs/rockpi4-rk3399.h b/include/configs/rockpi4-rk3399.h
new file mode 100644
index 000000000000..1936e06ab3c2
--- /dev/null
+++ b/include/configs/rockpi4-rk3399.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __ROCKPI4_RK3399_H
+#define __ROCKPI4_RK3399_H
+
+#define ROCKPI_4B_IDBLOADER_IMAGE_GUID \
+	EFI_GUID(0x02f4d760, 0xcfd5, 0x43bd, 0x8e, 0x2d, \
+		 0xa4, 0x2a, 0xcb, 0x33, 0xc6, 0x60)
+
+#define ROCKPI_4B_UBOOT_IMAGE_GUID \
+	EFI_GUID(0x4ce292da, 0x1dd8, 0x428d, 0xa1, 0xc2, \
+		 0x77, 0x74, 0x3e, 0xf8, 0xb9, 0x6e)
+
+#define ROCKPI_4C_IDBLOADER_IMAGE_GUID \
+	EFI_GUID(0xfd68510c, 0x12d3, 0x4f0a, 0xb8, 0xd3, \
+		 0xd8, 0x79, 0xe1, 0xd3, 0xa5, 0x40)
+
+#define ROCKPI_4C_UBOOT_IMAGE_GUID \
+	EFI_GUID(0xb81fb4ae, 0xe4f3, 0x471b, 0x99, 0xb4, \
+		 0x0b, 0x3d, 0xa5, 0x49, 0xce, 0x13)
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdin=serial,usbkbd\0" \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3399_common.h>
+
+#endif
-- 
2.43.0

