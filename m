Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09471C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61ECF88031;
	Sun, 28 Jan 2024 16:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IUGP7Pdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DB087F07; Sun, 28 Jan 2024 16:56:00 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8492D87F07
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TNGHZ5GB2z9sp1;
 Sun, 28 Jan 2024 16:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mn6JTpquR4MkwcN3sKV+1uh7+naYtcw5tyQtyVNc014=;
 b=IUGP7PdbWXthWlDxmJB+ITCpORTjyqJi8rZzcvAwaHS7/eIoDpCwl1zHo07lyucwDH9Ob1
 pVR203RChpknt0F33EFuUop3ADZifkoI8LndfDaQRNQgo4syxDfmJLmeAjQ+XNP8FzbMjW
 BivRoaLRIlZdHFOJSgKIoP0kzJJ5FytTFp9adcaEGUDTLIzVfhCQV8zS9/lArk1hsyPwqU
 CO4Hf+gv6B+paJrj36wnBd+/JQiqwDwJYyVUAsQREpLUcg4gbhVRngNt+/a1RvjpvQgk4k
 F19oCajJCIo2CkUzT9V/N+dRYkGeWlVKY3ef5cK/VXIuaqOxtz+Cp5AH12hMng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 11/11] ARM: renesas: Add Renesas R8A779H0 V4M Gray Hawk
 board code
Date: Sun, 28 Jan 2024 16:52:09 +0100
Message-ID: <20240128155458.56712-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5d6fd66c360e6f727c5
X-MBO-RS-META: dducirj9u55syanskkdhni8h8x6q1fj1
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add board code for the Renesas R8A779H0 V4M Gray Hawk board.

Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
V2: Use N: for pattern match in MAINTAINERS
---
 arch/arm/dts/Makefile                      |  3 +-
 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts | 42 ++++++++++++
 arch/arm/mach-rmobile/Kconfig.rcar4        |  7 ++
 board/renesas/grayhawk/Kconfig             | 15 +++++
 board/renesas/grayhawk/MAINTAINERS         |  5 ++
 board/renesas/grayhawk/Makefile            |  9 +++
 board/renesas/grayhawk/grayhawk.c          | 66 +++++++++++++++++++
 configs/r8a779h0_grayhawk_defconfig        | 75 ++++++++++++++++++++++
 include/configs/grayhawk.h                 | 14 ++++
 9 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
 create mode 100644 board/renesas/grayhawk/Kconfig
 create mode 100644 board/renesas/grayhawk/MAINTAINERS
 create mode 100644 board/renesas/grayhawk/Makefile
 create mode 100644 board/renesas/grayhawk/grayhawk.c
 create mode 100644 configs/r8a779h0_grayhawk_defconfig
 create mode 100644 include/configs/grayhawk.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b5c588c3363..5e26f019436 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1169,7 +1169,8 @@ dtb-$(CONFIG_RCAR_GEN3) += \
 dtb-$(CONFIG_RCAR_GEN4) += \
 	r8a779a0-falcon-u-boot.dtb \
 	r8a779f0-spider-u-boot.dtb \
-	r8a779g0-white-hawk-u-boot.dtb
+	r8a779g0-white-hawk-u-boot.dtb \
+	r8a779h0-gray-hawk-u-boot.dtb
 
 dtb-$(CONFIG_TARGET_RZG2L) += \
 	r9a07g044l2-smarc.dts
diff --git a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
new file mode 100644
index 00000000000..935ba9465dc
--- /dev/null
+++ b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source extras for U-Boot for the Gray Hawk board
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include "r8a779h0-gray-hawk.dts"
+#include "r8a779h0-u-boot.dtsi"
+
+/ {
+	aliases {
+		spi0 = &rpc;
+	};
+};
+
+&pfc {
+	qspi0_pins: qspi0 {
+		groups = "qspi0_ctrl", "qspi0_data4";
+		function = "qspi0";
+	};
+};
+
+&rpc {
+	pinctrl-0 = <&qspi0_pins>;
+	pinctrl-names = "default";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	spi-max-frequency = <40000000>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "s25fs512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <40000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
diff --git a/arch/arm/mach-rmobile/Kconfig.rcar4 b/arch/arm/mach-rmobile/Kconfig.rcar4
index 3c8d683974c..e80dce11f54 100644
--- a/arch/arm/mach-rmobile/Kconfig.rcar4
+++ b/arch/arm/mach-rmobile/Kconfig.rcar4
@@ -50,10 +50,17 @@ config TARGET_WHITEHAWK
 	help
 	  Support for Renesas R-Car Gen4 White Hawk platform
 
+config TARGET_GRAYHAWK
+	bool "Gray Hawk board"
+	imply R8A779H0
+	help
+	  Support for Renesas R-Car Gen4 Gray Hawk platform
+
 endchoice
 
 source "board/renesas/falcon/Kconfig"
 source "board/renesas/spider/Kconfig"
 source "board/renesas/whitehawk/Kconfig"
+source "board/renesas/grayhawk/Kconfig"
 
 endif
diff --git a/board/renesas/grayhawk/Kconfig b/board/renesas/grayhawk/Kconfig
new file mode 100644
index 00000000000..97621a30ad0
--- /dev/null
+++ b/board/renesas/grayhawk/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_GRAYHAWK
+
+config SYS_SOC
+	default "rmobile"
+
+config SYS_BOARD
+	default "grayhawk"
+
+config SYS_VENDOR
+	default "renesas"
+
+config SYS_CONFIG_NAME
+	default "grayhawk"
+
+endif
diff --git a/board/renesas/grayhawk/MAINTAINERS b/board/renesas/grayhawk/MAINTAINERS
new file mode 100644
index 00000000000..1d5de580a7c
--- /dev/null
+++ b/board/renesas/grayhawk/MAINTAINERS
@@ -0,0 +1,5 @@
+GRAYHAWK BOARD
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
+S:	Maintained
+N:	grayhawk
+N:	r8a779h0
diff --git a/board/renesas/grayhawk/Makefile b/board/renesas/grayhawk/Makefile
new file mode 100644
index 00000000000..9c5b8c9a12f
--- /dev/null
+++ b/board/renesas/grayhawk/Makefile
@@ -0,0 +1,9 @@
+#
+# board/renesas/grayhawk/Makefile
+#
+# Copyright (C) 2023 Renesas Electronics Corp.
+#
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-y	:= grayhawk.o ../rcar-common/common.o
diff --git a/board/renesas/grayhawk/grayhawk.c b/board/renesas/grayhawk/grayhawk.c
new file mode 100644
index 00000000000..6f2e73f7d38
--- /dev/null
+++ b/board/renesas/grayhawk/grayhawk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * board/renesas/grayhawk/grayhawk.c
+ *     This file is Gray Hawk board support.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#include <asm/arch/rmobile.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+#include <asm/processor.h>
+#include <linux/errno.h>
+#include <asm/system.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void init_generic_timer(void)
+{
+	const u32 freq = CONFIG_SYS_CLK_FREQ;
+
+	/* Update memory mapped and register based freqency */
+	asm volatile ("msr cntfrq_el0, %0" :: "r" (freq));
+	writel(freq, CNTFID0);
+
+	/* Enable counter */
+	setbits_le32(CNTCR_BASE, CNTCR_EN);
+}
+
+static void init_gic_v3(void)
+{
+	/* GIC v3 power on */
+	writel(BIT(1), GICR_LPI_PWRR);
+
+	/* Wait till the WAKER_CA_BIT changes to 0 */
+	clrbits_le32(GICR_LPI_WAKER, BIT(1));
+	while (readl(GICR_LPI_WAKER) & BIT(2))
+		;
+
+	writel(0xffffffff, GICR_SGI_BASE + GICR_IGROUPR0);
+}
+
+void s_init(void)
+{
+	if (current_el() == 3)
+		init_generic_timer();
+}
+
+int board_early_init_f(void)
+{
+	/* Unlock CPG access */
+	writel(0x5A5AFFFF, CPGWPR);
+	writel(0xA5A50000, CPGWPCR);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	if (current_el() == 3)
+		init_gic_v3();
+
+	return 0;
+}
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
new file mode 100644
index 00000000000..41aa0207086
--- /dev/null
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -0,0 +1,75 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_RMOBILE=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0xFFFE0000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="r8a779h0-gray-hawk-u-boot"
+CONFIG_RCAR_GEN4=y
+CONFIG_TARGET_GRAYHAWK=y
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SYS_CLK_FREQ=16666666
+# CONFIG_PSCI_RESET is not set
+CONFIG_SYS_LOAD_ADDR=0x58000000
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+CONFIG_SYS_BARGSIZE=2048
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779h0-gray-hawk.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_DEFAULT_FDT_FILE="r8a779h0-gray-hawk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_VERSION_VARIABLE=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+CONFIG_RCAR_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_RCAR_I2C=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_RENESAS_SDHI=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SPANSION=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_BITBANGMII=y
+CONFIG_BITBANGMII_MULTI=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_RENESAS_RAVB=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_BAUDRATE=921600
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_RENESAS_RPC_SPI=y
diff --git a/include/configs/grayhawk.h b/include/configs/grayhawk.h
new file mode 100644
index 00000000000..f1bb84f0a13
--- /dev/null
+++ b/include/configs/grayhawk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * include/configs/grayhawk.h
+ *     This file is Gray Hawk board configuration.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+#ifndef __GRAYHAWK_H
+#define __GRAYHAWK_H
+
+#include "rcar-gen4-common.h"
+
+#endif /* __GRAYHAWK_H */
-- 
2.43.0

