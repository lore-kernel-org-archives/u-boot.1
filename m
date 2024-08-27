Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E6C5321D
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 01:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B646488210;
	Tue, 27 Aug 2024 03:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1428839A; Tue, 27 Aug 2024 03:31:37 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2925286462
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 03:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 47R1VKFW027155; Tue, 27 Aug 2024 10:31:20 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 banglang.huang@foxmail.com, jonas@kwiboo.se,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] rockchip: modify devicetree at runtime for Radxa ROCK Pi E
 v3.0
Date: Tue, 27 Aug 2024 10:31:10 +0900
Message-ID: <20240827013111.633-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

since Radxa ROCK Pi E v3.0 is different to ROCK Pi E, "model" and
"compatible" in DT need to be different.
(specifically, sysupgrade[1] in OpenWrt)

also, "mmc0" and "mmc1" aliases need to be swapped to align with other
Radxa's boards.

modify them after loading DT for kernel.

[1] https://openwrt.org/docs/techref/sysupgrade#how_it_works

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/mach-rockchip/rk3328/Kconfig       |  6 ++++++
 board/radxa/rockpie-rk3328/Kconfig          | 12 +++++++++++
 board/radxa/rockpie-rk3328/MAINTAINERS      |  6 ++++++
 board/radxa/rockpie-rk3328/Makefile         |  3 +++
 board/radxa/rockpie-rk3328/rockpie-rk3328.c | 22 +++++++++++++++++++++
 configs/rock-pi-e-v3-rk3328_defconfig       |  2 ++
 6 files changed, 51 insertions(+)
 create mode 100644 board/radxa/rockpie-rk3328/Kconfig
 create mode 100644 board/radxa/rockpie-rk3328/MAINTAINERS
 create mode 100644 board/radxa/rockpie-rk3328/Makefile
 create mode 100644 board/radxa/rockpie-rk3328/rockpie-rk3328.c

diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
index 70770da5fdf..654377672fe 100644
--- a/arch/arm/mach-rockchip/rk3328/Kconfig
+++ b/arch/arm/mach-rockchip/rk3328/Kconfig
@@ -10,6 +10,11 @@ config TARGET_EVB_RK3328
 	  with full function and phisical connectors support like
 	  usb2.0 host ports, LVDS, JTAG, MAC, SDcard, HDMI, USB-2-serial...
 
+config TARGET_ROCK_PI_E_V3_RK3328
+	bool "Radxa ROCK Pi E v3.0"
+	help
+	  Radxa ROCK Pi E v3.0 single board computers with a RK3328 SoC.
+
 endchoice
 
 config ROCKCHIP_BOOT_MODE_REG
@@ -37,5 +42,6 @@ config TPL_SYS_MALLOC_F_LEN
 	default 0x800
 
 source "board/rockchip/evb_rk3328/Kconfig"
+source "board/radxa/rockpie-rk3328/Kconfig"
 
 endif
diff --git a/board/radxa/rockpie-rk3328/Kconfig b/board/radxa/rockpie-rk3328/Kconfig
new file mode 100644
index 00000000000..73485d93513
--- /dev/null
+++ b/board/radxa/rockpie-rk3328/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROCK_PI_E_V3_RK3328
+
+config SYS_BOARD
+	default "rockpie-rk3328"
+
+config SYS_VENDOR
+	default "radxa"
+
+config SYS_CONFIG_NAME
+	default "evb_rk3328"
+
+endif
diff --git a/board/radxa/rockpie-rk3328/MAINTAINERS b/board/radxa/rockpie-rk3328/MAINTAINERS
new file mode 100644
index 00000000000..f98ddce4e58
--- /dev/null
+++ b/board/radxa/rockpie-rk3328/MAINTAINERS
@@ -0,0 +1,6 @@
+ROCK-PI-E-V3-RK3328
+M:	FUKAUMI Naoki <naoki@radxa.com>
+S:	Maintained
+F:	board/radxa/rockpie-rk3328
+F:	configs/rock-pi-e-v3-rk3328_defconfig
+F:	arch/arm/dts/rk3328-rock-pi-e*
diff --git a/board/radxa/rockpie-rk3328/Makefile b/board/radxa/rockpie-rk3328/Makefile
new file mode 100644
index 00000000000..cede3b2605d
--- /dev/null
+++ b/board/radxa/rockpie-rk3328/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += rockpie-rk3328.o
diff --git a/board/radxa/rockpie-rk3328/rockpie-rk3328.c b/board/radxa/rockpie-rk3328/rockpie-rk3328.c
new file mode 100644
index 00000000000..3178af3e472
--- /dev/null
+++ b/board/radxa/rockpie-rk3328/rockpie-rk3328.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <fdt_support.h>
+
+#define MODEL		"Radxa ROCK Pi E v3.0"
+#define COMPATIBLE1	"radxa,rockpi-e-v3"
+#define COMPATIBLE2	"rockchip,rk3328"
+
+#define MMC0		"mmc@ff520000"
+#define MMC1		"mmc@ff500000"
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	fdt_setprop_string(blob, 0, "model", MODEL);
+	fdt_setprop_string(blob, 0, "compatible", COMPATIBLE1);
+	fdt_appendprop_string(blob, 0, "compatible", COMPATIBLE2);
+
+	fdt_find_and_setprop(blob, "/aliases", "mmc0", MMC0, 13, 1);
+	fdt_find_and_setprop(blob, "/aliases", "mmc1", MMC1, 13, 1);
+
+	return 0;
+}
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 4c6cc634bd6..15036d01a40 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3328-rock-pi-e-v3"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3328=y
+CONFIG_TARGET_ROCK_PI_E_V3_RK3328=y
 CONFIG_DEBUG_UART_BASE=0xFF130000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -18,6 +19,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-- 
2.43.0

