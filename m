Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030A7E748EE
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 16:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9B485DFA;
	Sun,  1 Oct 2023 18:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="JfkiCdAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7BE86C00; Sun,  1 Oct 2023 16:19:35 +0200 (CEST)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721E6870A5
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 16:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=dpmD1ostt7WXtB9cC3osqVMA60nkGS2jS8tKd0Joxuc=; b=JfkiCdAjLzzKJb9GP++xMJXB+F
 0WRFoC/nweHuZmAXrT9kq+myJgrwTCSMVUcM+KdmJ2NoKDs+kUdcFDl/sKayoH/lQEWfvfL75kin/
 xgDXn/ivj/Zra04HIliRjKoQGAMGbw+pttOM7PfGwGpTLBhdnNGOmaRhZDRXS5F5OtEVOjIx/Ddde
 qJvj4PZZn918EkUfD3Q0SgAE1wB7LmOu0et7cMlIjdUzuJMjQQzz8xn+fTlHvi9iBOTdG7EDL7tRb
 NuK9bCaWA4SVzC7w05U9f/Ndzan4hrgQDiy3IluWfLfKvMc8dbm5bvD/LM24fRljiA2mEaCY+U4Hi
 ZZQBbEuA==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1qmxI9-00CV5z-AM; Sun, 01 Oct 2023 15:19:30 +0100
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] board: rockchip: add Pine64 QuartzPro64 RK3588 board
Date: Mon,  2 Oct 2023 01:18:50 +1100
Message-ID: <20231001141858.164019-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 49
X-Mailman-Approved-At: Sun, 01 Oct 2023 18:17:08 +0200
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

QuartzPro64 is a Rockchip RK3588 based SBC by Pine64.

UART and booting over SD card are tested to work.

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/Makefile                         |  3 +-
 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi   | 21 ++++++
 arch/arm/dts/rk3588-quartzpro64.dts           | 32 +++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |  8 +++
 board/pine64/quartzpro64-rk3588/Kconfig       | 15 ++++
 board/pine64/quartzpro64-rk3588/MAINTAINERS   |  8 +++
 board/pine64/quartzpro64-rk3588/Makefile      |  3 +
 .../quartzpro64-rk3588/quartzpro64-rk3588.c   | 39 +++++++++++
 configs/quartzpro64-rk3588_defconfig          | 70 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 include/configs/quartzpro64-rk3588.h          | 14 ++++
 11 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-quartzpro64.dts
 create mode 100644 board/pine64/quartzpro64-rk3588/Kconfig
 create mode 100644 board/pine64/quartzpro64-rk3588/MAINTAINERS
 create mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 create mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 create mode 100644 configs/quartzpro64-rk3588_defconfig
 create mode 100644 include/configs/quartzpro64-rk3588.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 85fd5b1157b..87d1b116960 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -190,7 +190,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
 	rk3588s-rock-5a.dtb \
-	rk3588-rock-5b.dtb
+	rk3588-rock-5b.dtb \
+	rk3588-quartzpro64.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
 	rv1108-elgin-r1.dtb \
diff --git a/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
new file mode 100644
index 00000000000..0c4cb893c35
--- /dev/null
+++ b/arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google, Inc
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	aliases {
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3588-quartzpro64.dts b/arch/arm/dts/rk3588-quartzpro64.dts
new file mode 100644
index 00000000000..d5d6849e8f8
--- /dev/null
+++ b/arch/arm/dts/rk3588-quartzpro64.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google, Inc
+ */
+
+/dts-v1/;
+
+#include "rk3588.dtsi"
+
+/ {
+	model = "Pine64 QuartzPro64";
+	compatible = "pine64,quartzpro64", "rockchip,rk3588";
+
+	aliases {
+		mmc1 = &sdmmc;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 79fcc99b898..a0ebcdb2e84 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -80,6 +80,13 @@ config TARGET_ROCK5B_RK3588
 	  USB PD over USB Type-C
 	  Size: 100mm x 72mm (Pico-ITX form factor)
 
+config TARGET_QUARTZPRO64_RK3588
+	bool "Pine64 QuartzPro64 RK3588 board"
+	select BOARD_LATE_INIT
+	help
+	  Pine64 QuartzPro64 is a Rockchip RK3588 based SBC (Single Board
+	  Computer) by Pine64.
+
 config ROCKCHIP_BOOT_MODE_REG
 	default 0xfd588080
 
@@ -93,6 +100,7 @@ config SYS_MALLOC_F_LEN
 	default 0x80000
 
 source board/edgeble/neural-compute-module-6/Kconfig
+source board/pine64/quartzpro64-rk3588/Kconfig
 source board/rockchip/evb_rk3588/Kconfig
 source board/radxa/rock5a-rk3588s/Kconfig
 source board/radxa/rock5b-rk3588/Kconfig
diff --git a/board/pine64/quartzpro64-rk3588/Kconfig b/board/pine64/quartzpro64-rk3588/Kconfig
new file mode 100644
index 00000000000..96aa7921d32
--- /dev/null
+++ b/board/pine64/quartzpro64-rk3588/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_QUARTZPRO64_RK3588
+
+config SYS_BOARD
+	default "quartzpro64-rk3588"
+
+config SYS_VENDOR
+	default "pine64"
+
+config SYS_CONFIG_NAME
+	default "quartzpro64-rk3588"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+
+endif
diff --git a/board/pine64/quartzpro64-rk3588/MAINTAINERS b/board/pine64/quartzpro64-rk3588/MAINTAINERS
new file mode 100644
index 00000000000..a7e944b7478
--- /dev/null
+++ b/board/pine64/quartzpro64-rk3588/MAINTAINERS
@@ -0,0 +1,8 @@
+QUARTZPRO64-RK3588
+M:	Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
+S:	Maintained
+F:	board/pine64/quartzpro64-rk3588
+F:	include/configs/quartzpro64-rk3588.h
+F:	configs/quartzpro64-rk3588_defconfig
+F:	arch/arm/dts/rk3588-quartzpro64.dts
+F:	arch/arm/dts/rk3588-quartzpro64-u-boot.dtsi
diff --git a/board/pine64/quartzpro64-rk3588/Makefile b/board/pine64/quartzpro64-rk3588/Makefile
new file mode 100644
index 00000000000..47819d9be93
--- /dev/null
+++ b/board/pine64/quartzpro64-rk3588/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:     GPL-2.0+
+
+obj-y += quartzpro64-rk3588.o
diff --git a/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
new file mode 100644
index 00000000000..bda804a89e2
--- /dev/null
+++ b/board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 Google, Inc
+ */
+
+#include <fdtdec.h>
+#include <fdt_support.h>
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int quartzpro64_add_reserved_memory_fdt_nodes(void *new_blob)
+{
+	struct fdt_memory gap1 = {
+		.start = 0x3fc000000,
+		.end = 0x3fc4fffff,
+	};
+	struct fdt_memory gap2 = {
+		.start = 0x3fff00000,
+		.end = 0x3ffffffff,
+	};
+	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
+	unsigned int ret;
+
+	/*
+	 * Inject the reserved-memory nodes into the DTS
+	 */
+	ret = fdtdec_add_reserved_memory(new_blob, "gap1", &gap1,  NULL, 0,
+					 NULL, flags);
+	if (ret)
+		return ret;
+
+	return fdtdec_add_reserved_memory(new_blob, "gap2", &gap2,  NULL, 0,
+					  NULL, flags);
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return quartzpro64_add_reserved_memory_fdt_nodes(blob);
+}
+#endif
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
new file mode 100644
index 00000000000..3bcc54118b3
--- /dev/null
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -0,0 +1,70 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_DEFAULT_DEVICE_TREE="rk3588-quartzpro64"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_TARGET_QUARTZPRO64_RK3588=y
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de9fe8e642b..c3fb8a69822 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -112,6 +112,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B (rock5b-rk3588)
 
diff --git a/include/configs/quartzpro64-rk3588.h b/include/configs/quartzpro64-rk3588.h
new file mode 100644
index 00000000000..a1faa2aad85
--- /dev/null
+++ b/include/configs/quartzpro64-rk3588.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ * Copyright 2023 Google, Inc
+ */
+
+#ifndef __QUARTZPRO64_RK3588_H
+#define __QUARTZPRO64_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __QUARTZPRO64_RK3588_H */

base-commit: 2173c4a990664d8228d4dadd814bd64fdc12948f
-- 
2.42.0

