Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07495D31A26
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 08:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB0183885;
	Wed, 14 Jan 2026 09:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="q7Z9t66N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15469835B3; Wed, 14 Jan 2026 09:51:55 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E1A83623
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=Xy8xkOdJ4rNh1OifHxQ54uIk07r2RBhyIIjo5T3JfC8=; b=q7Z9t66Np3yYKN9iX+yy/FES9k
 3k8BjCujClMNh0MOHzOLNC/NWZwF1kJL8imbGaVpMtwXVwlSs6t8ZuBqzKud6zIqyN/CHCQ71ugyC
 bSDuYO4xAzSKPpTd7Pv89f3eCvh/QLQwu5WgM4Od/vAwgEbKPvC+EtxLY7IKhOhPsHSosqUDRmuiE
 VTitMiaRoERuLwF35+oncD8hpfQa4osCKgj8d5TfjPWe2ZBHqqk9NA6Vj0FZg1ovic3Dwzt/QniXU
 vyXWRESXLewvWDGFhS6q+ceHCJxerlmnI3NtG5h0lmHnMjFqPeP+tTRta6Ls3Grej7VceLRmCr1z9
 /LpBg67g==;
Received: from i53875b96.versanet.de ([83.135.91.150] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vfwEy-002G0M-Ag; Wed, 14 Jan 2026 09:28:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 12/12] rockchip: board: qnap-tsx33: add support for Qnap
 TS233 devices
Date: Wed, 14 Jan 2026 09:28:22 +0100
Message-ID: <20260114082822.4007128-13-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260114082822.4007128-1-heiko@sntech.de>
References: <20260114082822.4007128-1-heiko@sntech.de>
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

The TS233 shares the same basic peripheral setup for
SoC, DDR, EMMC, 3 USB-ports, 1G network interface, SoC-SATA ports,
serial and maskrom access.

It could just share the same U-Boot binary with the TS433, and the type-
selection would take care of loading the right DTB for the operating
system. But right now we can't select the correct DTB for inside U-Boot
itself.

So for the time being, add separate defconfig and documentation for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi |  6 ++
 board/qnap/tsx33_rk356x/MAINTAINERS        |  2 +
 board/qnap/tsx33_rk356x/board.c            |  4 +-
 configs/qnap-ts233-rk3568_defconfig        | 85 ++++++++++++++++++++++
 doc/board/qnap/ts233.rst                   | 37 ++++++++++
 5 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
 create mode 100644 configs/qnap-ts233-rk3568_defconfig
 create mode 100644 doc/board/qnap/ts233.rst

diff --git a/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi b/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
new file mode 100644
index 00000000000..19acbceb468
--- /dev/null
+++ b/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2024 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#include "rk356x-u-boot.dtsi"
diff --git a/board/qnap/tsx33_rk356x/MAINTAINERS b/board/qnap/tsx33_rk356x/MAINTAINERS
index b91274c7b43..af9bf9fe0c5 100644
--- a/board/qnap/tsx33_rk356x/MAINTAINERS
+++ b/board/qnap/tsx33_rk356x/MAINTAINERS
@@ -4,5 +4,7 @@ S:	Maintained
 F:	board/qnap/tsx33_rk356x/
 F:	doc/board/qnap/
 F:	include/configs/qnap_tsx33.h
+F:	configs/qnap-ts233-rk3568_defconfig
 F:	configs/qnap-ts433-rk3568_defconfig
+F:	arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
 F:	arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
diff --git a/board/qnap/tsx33_rk356x/board.c b/board/qnap/tsx33_rk356x/board.c
index 006add6fb30..7cfff372d8e 100644
--- a/board/qnap/tsx33_rk356x/board.c
+++ b/board/qnap/tsx33_rk356x/board.c
@@ -85,7 +85,7 @@ static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
 		"Q0AM0",
 		11,
 		"TS233",
-		NULL, /* not yet supported */
+		DTB_DIR "rk3568-qnap-ts233.dtb",
 	},
 	[Q0AJ0_Q0AM0_11_10] = {
 		"Q0AJ0",
@@ -93,7 +93,7 @@ static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
 		"Q0AM0",
 		10,
 		"TS233",
-		NULL, /* not yet supported */
+		DTB_DIR "rk3568-qnap-ts233.dtb",
 	},
 	[Q0B20_Q0AW0_12_10] = {
 		"Q0B20",
diff --git a/configs/qnap-ts233-rk3568_defconfig b/configs/qnap-ts233-rk3568_defconfig
new file mode 100644
index 00000000000..53ac5b25bd0
--- /dev/null
+++ b/configs/qnap-ts233-rk3568_defconfig
@@ -0,0 +1,85 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-qnap-ts233"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_QNAP_TSX33_RK356X=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-qnap-ts233.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_BOARD_TYPES=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SATA=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_FAN53555=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
+# CONFIG_SPL_ATF_NO_PLATFORM_PARAM is not set
+CONFIG_OPTEE_LIB=y
diff --git a/doc/board/qnap/ts233.rst b/doc/board/qnap/ts233.rst
new file mode 100644
index 00000000000..b706d97afa0
--- /dev/null
+++ b/doc/board/qnap/ts233.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Qnap TS233 Devices
+=============================
+
+This allows U-Boot to boot the Qnap TS233 NAS
+
+The device is similar to the TS433 in terms of its basic peripheral setup
+of SoC, DDR, EMMC, 3 USB-ports, 1G network interface, SoC-SATA ports,
+serial and maskrom access.
+
+Please follow the TS433 steps but with the following changes.
+
+Building U-Boot
+---------------
+
+The TS233 can just run the TS433 U-Boot binary, but if a separate binary
+should be build, the following command will do so:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
+    $ make qnap-ts233-rk3568_defconfig
+    $ make
+
+This will build ``u-boot-rockchip.bin`` which can be written to the
+on-board eMMC.
+
+Image installation
+------------------
+
+The serial port is located next to the CPU and labeled "SOC_UART", while
+the maskrom jumper header is located in the smaller cutout and
+labeled "MASKROM RECOVERY".
+
+The USB port to use is the one located in the front of the device.
-- 
2.47.2

