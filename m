Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C6DC0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 08:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1763806C9;
	Thu, 23 Jan 2025 09:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ShLfiRco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF27080423; Thu, 23 Jan 2025 09:55:20 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1293A806DC
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c0f77162d96711ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=UP3jvZ+0dbZVm5dHrXawpdI/ia+ZPMYbrZCzTzUcuRI=; 
 b=ShLfiRconNgGNtMVHqAxabik+NiGxu3nustkojUHuHQDAap6gvManGrxwZ8UgfdQzfypSdMHAVGZqw/tK6wt03jWmcf9gD9R2r4QJRbb60jxOfY9HAQ9Y8bq35noiL2AwZh6/enZ+nd9bCmSJR2/PjYli0vWPVuHebRa+nb2kqA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:2a81dc27-e6b4-478e-afce-9494ab657069, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:25b49a7e-427a-4311-9df4-bfaeeacd8532,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c0f77162d96711ef99858b75a2457dd9-20250123
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 361362229; Thu, 23 Jan 2025 16:55:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 16:55:07 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 16:55:06 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH 5/5] board: mediatek: add MT7987 reference boards
Date: Thu, 23 Jan 2025 16:55:05 +0800
Message-ID: <0a229a71447caaad697f94e957eb8233e07c4e8a.1737621362.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1737621362.git.weijie.gao@mediatek.com>
References: <cover.1737621362.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch adds general board files based on MT7987 SoC.

MT7987 uses one mmc controller for booting from both SD and eMMC, and the
pins of mmc controller are also shared with one spi controller.
So three configs are need for these boot types:

1. mt7987_rfb_defconfig - SPI-NOR (spi2) and SPI-NAND (spi0)
2. mt7987_emmc_rfb_defconfig - eMMC + SPI-NOR (spi2)
3. mt7987_sd_rfb_defconfig - SD + SPI-NOR (spi2)

Note: spi2 also supports booting from SPI-NAND, but not the default option.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi | 61 +++++++++++++++
 arch/arm/dts/mt7987a-emmc-rfb.dts         | 37 +++++++++
 arch/arm/dts/mt7987a-rfb-u-boot.dtsi      | 71 ++++++++++++++++++
 arch/arm/dts/mt7987a-rfb.dts              | 34 +++++++++
 arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi   | 59 +++++++++++++++
 arch/arm/dts/mt7987a-sd-rfb.dts           | 37 +++++++++
 board/mediatek/mt7987/MAINTAINERS         |  8 ++
 board/mediatek/mt7987/Makefile            |  3 +
 board/mediatek/mt7987/mt7987_rfb.c        | 10 +++
 configs/mt7987_emmc_rfb_defconfig         | 91 +++++++++++++++++++++++
 configs/mt7987_rfb_defconfig              | 87 ++++++++++++++++++++++
 configs/mt7987_sd_rfb_defconfig           | 91 +++++++++++++++++++++++
 include/configs/mt7987.h                  | 14 ++++
 13 files changed, 603 insertions(+)
 create mode 100644 arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-emmc-rfb.dts
 create mode 100644 arch/arm/dts/mt7987a-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-rfb.dts
 create mode 100644 arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-sd-rfb.dts
 create mode 100644 board/mediatek/mt7987/MAINTAINERS
 create mode 100644 board/mediatek/mt7987/Makefile
 create mode 100644 board/mediatek/mt7987/mt7987_rfb.c
 create mode 100644 configs/mt7987_emmc_rfb_defconfig
 create mode 100644 configs/mt7987_rfb_defconfig
 create mode 100644 configs/mt7987_sd_rfb_defconfig
 create mode 100644 include/configs/mt7987.h

diff --git a/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
new file mode 100644
index 00000000000..54cf72b3bf8
--- /dev/null
+++ b/arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "mt7987a-u-boot.dtsi"
+#include "mt7987-netsys-u-boot.dtsi"
+
+/ {
+	model = "mt7987";
+	compatible = "mediatek,mt7987", "mediatek,mt7987-emmc-rfb";
+};
+
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins>;
+	phy-mode = "2500base-x";
+	mediatek,switch = "auto";
+	reset-gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+		pause;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc_pins_default>;
+	max-frequency = <48000000>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	non-removable;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	must_tx;
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	support_quad;
+	tick_dly = <2>;
+	sample_sel = <0>;
+
+	/delete-node/ spi_nor@0;
+	spi_nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
diff --git a/arch/arm/dts/mt7987a-emmc-rfb.dts b/arch/arm/dts/mt7987a-emmc-rfb.dts
new file mode 100644
index 00000000000..f59e5bd97bf
--- /dev/null
+++ b/arch/arm/dts/mt7987a-emmc-rfb.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+#include "mt7987a.dtsi"
+#include "mt7987-emmc.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "MediaTek MT7987 EMMC RFB";
+	compatible = "mediatek,mt7987a-emmc",
+		     "mediatek,mt7987a", "mediatek,mt7987";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n1 loglevel=8  \
+			    earlycon=uart8250,mmio32,0x11000000 \
+			    pci=pcie_bus_perf ubi.block=0,firmware \
+			    root=/dev/fit0 rootwait";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt7987a-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-rfb-u-boot.dtsi
new file mode 100644
index 00000000000..f1ed51e21c4
--- /dev/null
+++ b/arch/arm/dts/mt7987a-rfb-u-boot.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#include "mt7987a-u-boot.dtsi"
+#include "mt7987-netsys-u-boot.dtsi"
+
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins>;
+	phy-mode = "2500base-x";
+	mediatek,switch = "auto";
+	reset-gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+		pause;
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_flash_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	must_tx;
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	support_quad;
+	tick_dly = <2>;
+	sample_sel = <0>;
+
+	/delete-node/ spi_nand@0;
+	spi_nand@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	must_tx;
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	support_quad;
+	tick_dly = <2>;
+	sample_sel = <0>;
+
+	/delete-node/ spi_nor@0;
+	spi_nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
diff --git a/arch/arm/dts/mt7987a-rfb.dts b/arch/arm/dts/mt7987a-rfb.dts
new file mode 100644
index 00000000000..0ba6b8d9ad7
--- /dev/null
+++ b/arch/arm/dts/mt7987a-rfb.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+#include "mt7987a.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "MediaTek MT7987A RFB";
+	compatible = "mediatek,mt7987a", "mediatek,mt7987";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n1 loglevel=8  \
+			    earlycon=uart8250,mmio32,0x11000000 \
+			    pci=pcie_bus_perf";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi b/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
new file mode 100644
index 00000000000..b07e6da41e2
--- /dev/null
+++ b/arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "mt7987a-u-boot.dtsi"
+#include "mt7987-netsys-u-boot.dtsi"
+
+/ {
+	model = "mt7987";
+	compatible = "mediatek,mt7987", "mediatek,mt7987-sd-rfb";
+};
+
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio0_pins>;
+	phy-mode = "2500base-x";
+	mediatek,switch = "auto";
+	reset-gpios = <&pio 42 GPIO_ACTIVE_HIGH>;
+
+	fixed-link {
+		speed = <2500>;
+		full-duplex;
+		pause;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd_pins_default>;
+	max-frequency = <48000000>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_flash_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	must_tx;
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	support_quad;
+	tick_dly = <2>;
+	sample_sel = <0>;
+
+	/delete-node/ spi_nor@0;
+	spi_nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
diff --git a/arch/arm/dts/mt7987a-sd-rfb.dts b/arch/arm/dts/mt7987a-sd-rfb.dts
new file mode 100644
index 00000000000..85de4990682
--- /dev/null
+++ b/arch/arm/dts/mt7987a-sd-rfb.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+#include "mt7987a.dtsi"
+#include "mt7987-sd.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "MediaTek MT7987 SD RFB";
+	compatible = "mediatek,mt7987a-sd",
+		     "mediatek,mt7987a", "mediatek,mt7987";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n1 loglevel=8  \
+			    earlycon=uart8250,mmio32,0x11000000 \
+			    pci=pcie_bus_perf ubi.block=0,firmware \
+			    root=/dev/fit0 rootwait";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			debounce-interval = <10>;
+		};
+	};
+};
diff --git a/board/mediatek/mt7987/MAINTAINERS b/board/mediatek/mt7987/MAINTAINERS
new file mode 100644
index 00000000000..c257d0b09df
--- /dev/null
+++ b/board/mediatek/mt7987/MAINTAINERS
@@ -0,0 +1,8 @@
+MT7987
+M:	Sam Shih <sam.shih@mediatek.com>
+S:	Maintained
+F:	board/mediatek/mt7987
+F:	include/configs/mt7987.h
+F:	configs/mt7987_rfb_defconfig
+F:	configs/mt7987_emmc_rfb_defconfig
+F:	configs/mt7987_sd_rfb_defconfig
diff --git a/board/mediatek/mt7987/Makefile b/board/mediatek/mt7987/Makefile
new file mode 100644
index 00000000000..9f3f493f3c9
--- /dev/null
+++ b/board/mediatek/mt7987/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= mt7987_rfb.o
diff --git a/board/mediatek/mt7987/mt7987_rfb.c b/board/mediatek/mt7987/mt7987_rfb.c
new file mode 100644
index 00000000000..fcb844deed8
--- /dev/null
+++ b/board/mediatek/mt7987/mt7987_rfb.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/mt7987_emmc_rfb_defconfig b/configs/mt7987_emmc_rfb_defconfig
new file mode 100644
index 00000000000..022ca32169b
--- /dev/null
+++ b/configs/mt7987_emmc_rfb_defconfig
@@ -0,0 +1,91 @@
+CONFIG_ARM=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x41e00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mt7987a-emmc-rfb"
+CONFIG_TARGET_MT7987=y
+CONFIG_SYS_BOOTM_LEN=0x6000000
+CONFIG_SYS_LOAD_ADDR=0x48000000
+CONFIG_DEBUG_UART_BASE=0x11000000
+CONFIG_DEBUG_UART_CLOCK=40000000
+CONFIG_DEBUG_UART=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+# CONFIG_AUTOBOOT is not set
+CONFIG_DEFAULT_FDT_FILE="mt7987a-emmc-rfb"
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=1049
+CONFIG_LOGLEVEL=7
+CONFIG_LOG=y
+CONFIG_SYS_PROMPT="MT7987> "
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SMC=y
+CONFIG_EFI_PARTITION=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.1.1"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.1.2"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MTK=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_PUYA=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_ZBIT=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_MEDIATEK_ETH=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT7987=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK=y
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SPIM=y
+CONFIG_HEXDUMP=y
diff --git a/configs/mt7987_rfb_defconfig b/configs/mt7987_rfb_defconfig
new file mode 100644
index 00000000000..00e3cea5264
--- /dev/null
+++ b/configs/mt7987_rfb_defconfig
@@ -0,0 +1,87 @@
+CONFIG_ARM=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x41e00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mt7987a-rfb"
+CONFIG_TARGET_MT7987=y
+CONFIG_SYS_BOOTM_LEN=0x6000000
+CONFIG_SYS_LOAD_ADDR=0x48000000
+CONFIG_DEBUG_UART_BASE=0x11000000
+CONFIG_DEBUG_UART_CLOCK=40000000
+CONFIG_DEBUG_UART=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+# CONFIG_AUTOBOOT is not set
+CONFIG_DEFAULT_FDT_FILE="mt7987a-rfb"
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=1049
+CONFIG_LOGLEVEL=7
+CONFIG_LOG=y
+CONFIG_SYS_PROMPT="MT7987> "
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SMC=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.1.1"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.1.2"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MTK=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_PUYA=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_ZBIT=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_MEDIATEK_ETH=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT7987=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK=y
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SPIM=y
+CONFIG_HEXDUMP=y
diff --git a/configs/mt7987_sd_rfb_defconfig b/configs/mt7987_sd_rfb_defconfig
new file mode 100644
index 00000000000..ca7714b1242
--- /dev/null
+++ b/configs/mt7987_sd_rfb_defconfig
@@ -0,0 +1,91 @@
+CONFIG_ARM=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x41e00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mt7987a-sd-rfb"
+CONFIG_TARGET_MT7987=y
+CONFIG_SYS_BOOTM_LEN=0x6000000
+CONFIG_SYS_LOAD_ADDR=0x48000000
+CONFIG_DEBUG_UART_BASE=0x11000000
+CONFIG_DEBUG_UART_CLOCK=40000000
+CONFIG_DEBUG_UART=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+# CONFIG_AUTOBOOT is not set
+CONFIG_DEFAULT_FDT_FILE="mt7987a-sd-rfb"
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=1049
+CONFIG_LOGLEVEL=7
+CONFIG_LOG=y
+CONFIG_SYS_PROMPT="MT7987> "
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+# CONFIG_CMD_UNLZ4 is not set
+# CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SMC=y
+CONFIG_EFI_PARTITION=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_IPADDR=y
+CONFIG_IPADDR="192.168.1.1"
+CONFIG_USE_NETMASK=y
+CONFIG_NETMASK="255.255.255.0"
+CONFIG_USE_SERVERIP=y
+CONFIG_SERVERIP="192.168.1.2"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MTK=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_ATMEL=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_PUYA=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_SPI_FLASH_ZBIT=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_MEDIATEK_ETH=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT7987=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_MTK=y
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SPIM=y
+CONFIG_HEXDUMP=y
diff --git a/include/configs/mt7987.h b/include/configs/mt7987.h
new file mode 100644
index 00000000000..18ed3c7a55b
--- /dev/null
+++ b/include/configs/mt7987.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for MediaTek MT7987 SoC
+ *
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ */
+
+#ifndef __MT7987_H
+#define __MT7987_H
+
+#define CFG_MAX_MEM_MAPPED		0xC0000000
+
+#endif
-- 
2.34.1

