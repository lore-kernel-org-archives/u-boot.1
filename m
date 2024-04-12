Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0647C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0865587FE8;
	Fri, 12 Apr 2024 16:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="r40n7zEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA35087DF1; Fri, 12 Apr 2024 16:11:08 +0200 (CEST)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9124887E2E
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
 by mxout4.routing.net (Postfix) with ESMTP id 0B99B100790;
 Fri, 12 Apr 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1712931064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YGfXL5jCKBBZJ/vpH5HXTfini3OFijCvjxIzj5NxpQA=;
 b=r40n7zEv6za16LuR4XKIeNgcyS4qpuujZ4ia61zWXho2J0ch/Beo1ELtEOJnhJ4LREsain
 zqjtJF2q6OvqibXbcOdIexrmzhWpX006gTTD0YQNW3qA+/EcwQG8FI1WskGk5wQYB0qerD
 u05KZVlJbF9gOzuPLybR9OeBQInXqR8=
Received: from frank-G5.. (fttx-pool-80.245.75.63.bambit.de [80.245.75.63])
 by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 46DD1360268;
 Fri, 12 Apr 2024 14:11:03 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 John Crispin <john@phrozen.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	u-boot@lists.denx.de
Subject: [RFC] pci: mediatek: add PCIe controller support for Filogic
Date: Fri, 12 Apr 2024 16:10:51 +0200
Message-Id: <20240412141051.23943-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 3dbcd9db-0d81-46da-82ce-30a4c88adab0
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

From: John Crispin <john@phrozen.org>

This adds PCIe controller support for the MediaTek Filogic family..

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
Note for mt7988: pcie2 needs a dedicated phy which has no driver
in uboot yet, so this pcie port is not enabled in the board device-
trees.

Note for mt7981: i have no board and have no dts nodes yet for it,
so only clock change first.
---
 arch/arm/dts/mt7986.dtsi               |  46 +++
 arch/arm/dts/mt7988-rfb.dts            |  12 +
 arch/arm/dts/mt7988-sd-rfb.dts         |  12 +
 arch/arm/dts/mt7988.dtsi               | 164 +++++++++++
 drivers/clk/mediatek/clk-mt7986.c      |   5 +-
 drivers/pci/Kconfig                    |   7 +
 drivers/pci/Makefile                   |   1 +
 drivers/pci/pcie_mediatek_gen3.c       | 382 +++++++++++++++++++++++++
 include/dt-bindings/clock/mt7981-clk.h |   3 +-
 include/dt-bindings/clock/mt7986-clk.h |   3 +-
 10 files changed, 631 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie_mediatek_gen3.c

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index c9aeeaca2b11..9a9b0b64cc68 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -375,5 +375,51 @@
 			#phy-cells = <1>;
 			status = "okay";
 		};
+
+		pcie_port: pcie-phy@11c00000 {
+			reg = <0x11c00000 0x20000>;
+			clocks = <&dummy_clk>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	pcie: pcie@11280000 {
+		compatible = "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		reg = <0x11280000 0x4000>;
+		reg-names = "pcie-mac";
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		clocks = <&infracfg_ao CK_INFRA_IPCIE_PIPE_CK>,
+			 <&infracfg_ao CK_INFRA_IPCIE_CK>,
+			 <&infracfg_ao CK_INFRA_IPCIER_CK>,
+			 <&infracfg_ao CK_INFRA_IPCIEB_CK>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m", "top_133m";
+
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000 0x20000000 0 0x10000000>;
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <2>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>, /* INTA */
+				<0 0 0 2 &pcie_intc 1>, /* INTB */
+				<0 0 0 3 &pcie_intc 2>, /* INTC */
+				<0 0 0 4 &pcie_intc 3>; /* INTD */
+
+		phy-names = "pcie-phy";
+		phys = <&pcie_port PHY_TYPE_PCIE>;
+
+		status = "okay";
+
+		pcie_intc: legacy-interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
 	};
 };
diff --git a/arch/arm/dts/mt7988-rfb.dts b/arch/arm/dts/mt7988-rfb.dts
index 2c1142843091..2f0d00b6950b 100644
--- a/arch/arm/dts/mt7988-rfb.dts
+++ b/arch/arm/dts/mt7988-rfb.dts
@@ -180,3 +180,15 @@
 	non-removable;
 	status = "okay";
 };
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/mt7988-sd-rfb.dts b/arch/arm/dts/mt7988-sd-rfb.dts
index a3df37d252de..0a3eb5360d21 100644
--- a/arch/arm/dts/mt7988-sd-rfb.dts
+++ b/arch/arm/dts/mt7988-sd-rfb.dts
@@ -132,3 +132,15 @@
 	vqmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/mt7988.dtsi b/arch/arm/dts/mt7988.dtsi
index ac476d5cdd7f..b2e2724732fc 100644
--- a/arch/arm/dts/mt7988.dtsi
+++ b/arch/arm/dts/mt7988.dtsi
@@ -194,6 +194,152 @@
 		status = "okay";
 	};
 
+	pcie2: pcie@11280000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11280000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <3>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20200000 0 0x20200000 0 0x07e00000>;
+		clocks = <&infracfg_ao_cgs CK_INFRA_PCIE_PIPE_P2>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_GFMUX_TL_P2>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_PERI_26M_CK_P2>,
+			 <&infracfg_ao_cgs CK_INFRA_133M_PCIE_CK_P2>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		phys = <&xphyu3port0 PHY_TYPE_PCIE>;
+		phy-names = "pcie-phy";
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc2 0>,
+				<0 0 0 2 &pcie_intc2 1>,
+				<0 0 0 3 &pcie_intc2 2>,
+				<0 0 0 4 &pcie_intc2 3>;
+
+		pcie_intc2: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie3: pcie@11290000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11290000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <2>;
+		interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x28200000 0 0x28200000 0 0x07e00000>;
+		clocks = <&infracfg_ao_cgs CK_INFRA_PCIE_PIPE_P3>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_GFMUX_TL_P3>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_PERI_26M_CK_P3>,
+			 <&infracfg_ao_cgs CK_INFRA_133M_PCIE_CK_P3>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc3 0>,
+				<0 0 0 2 &pcie_intc3 1>,
+				<0 0 0 3 &pcie_intc3 2>,
+				<0 0 0 4 &pcie_intc3 3>;
+		pcie_intc3: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie0: pcie@11300000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11300000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <0>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x30200000 0 0x30200000 0 0x07e00000>;
+		clocks = <&infracfg_ao_cgs CK_INFRA_PCIE_PIPE_P0>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_GFMUX_TL_P0>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_PERI_26M_CK_P0>,
+			 <&infracfg_ao_cgs CK_INFRA_133M_PCIE_CK_P0>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+				<0 0 0 2 &pcie_intc0 1>,
+				<0 0 0 3 &pcie_intc0 2>,
+				<0 0 0 4 &pcie_intc0 3>;
+		pcie_intc0: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
+	pcie1: pcie@11310000 {
+		compatible = "mediatek,mt7988-pcie",
+			     "mediatek,mt7986-pcie",
+			     "mediatek,mt8192-pcie";
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		reg = <0 0x11310000 0 0x2000>;
+		reg-names = "pcie-mac";
+		linux,pci-domain = <1>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x38200000 0 0x38200000 0 0x07e00000>;
+		clocks = <&infracfg_ao_cgs CK_INFRA_PCIE_PIPE_P1>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_GFMUX_TL_P1>,
+			 <&infracfg_ao_cgs CK_INFRA_PCIE_PERI_26M_CK_P1>,
+			 <&infracfg_ao_cgs CK_INFRA_133M_PCIE_CK_P1>;
+		clock-names = "pl_250m", "tl_26m", "peri_26m",
+			      "top_133m";
+		use-dedicated-phy;
+
+		status = "disabled";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+				<0 0 0 2 &pcie_intc1 1>,
+				<0 0 0 3 &pcie_intc1 2>,
+				<0 0 0 4 &pcie_intc1 3>;
+		pcie_intc1: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+
 	usbtphy: usb-phy@11c50000 {
 		compatible = "mediatek,mt7988",
 			     "mediatek,generic-tphy-v2";
@@ -219,6 +365,24 @@
 			mediatek,usb3-pll-ssc-delta1;
 			status = "okay";
 		};
+
+	};
+
+	xphy: xphy@11e10000 {
+		compatible = "mediatek,mt7988",
+		"mediatek,xsphy";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		xphyu3port0: usb-phy@11e13000 {
+			reg = <0 0x11e13400 0 0x500>;
+			clocks = <&dummy_clk>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+			status = "okay";
+		};
 	};
 
 	xfi_pextp0: syscon@11f20000 {
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index b3fa63fc0ab4..93e02cd23ac1 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -504,8 +504,9 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA2(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_INFRA_USB_SYS_CK,
 		    2),
 	GATE_INFRA2(CK_INFRA_IUSB_CK, "infra_iusb", CK_INFRA_USB_CK, 3),
-	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_INFRA_PCIE_CK, 13),
-	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 15),
+	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_INFRA_PCIE_CK, 12),
+	GATE_INFRA2(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_INFRA_PCIE_CK, 13),
+	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 14),
 	GATE_INFRA2(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_INFRA_133M_PHCK, 15),
 };
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 463ec47eb92d..f62a9844b1ef 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -350,6 +350,13 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable Gen2 PCIe controller,
 	  which could be found on MT7623 SoC family.
 
+config PCIE_MEDIATEK_GEN3
+	bool "MediaTek PCIe Gen3 controller"
+	depends on ARCH_MEDIATEK
+	help
+	  Say Y here if you want to enable Gen3 PCIe controller,
+	  which could be found on the Mediatek Filogic SoC family.
+
 config PCIE_DW_MESON
 	bool "Amlogic Meson DesignWare based PCIe controller"
 	depends on ARCH_MESON
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 72ef8b4bc772..aa254a2f4338 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PCIE_INTEL_FPGA) += pcie_intel_fpga.o
 obj-$(CONFIG_PCIE_DW_COMMON) += pcie_dw_common.o
 obj-$(CONFIG_PCI_KEYSTONE) += pcie_dw_ti.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie_mediatek.o
+obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie_mediatek_gen3.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie_rockchip.o
 obj-$(CONFIG_PCIE_DW_ROCKCHIP) += pcie_dw_rockchip.o
 obj-$(CONFIG_PCIE_DW_MESON) += pcie_dw_meson.o
diff --git a/drivers/pci/pcie_mediatek_gen3.c b/drivers/pci/pcie_mediatek_gen3.c
new file mode 100644
index 000000000000..a273ea123aaa
--- /dev/null
+++ b/drivers/pci/pcie_mediatek_gen3.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek PCIe host controller driver.
+ *
+ * Copyright (c) 2023 John Crispin <john@phrozen.org>
+ * Driver is based on u-boot gen1/2 and upstream linux gen3 code
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <generic-phy.h>
+#include <log.h>
+#include <malloc.h>
+#include <pci.h>
+#include <reset.h>
+#include <asm/io.h>
+#include <dm/devres.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include "pci_internal.h"
+
+/* PCIe shared registers */
+#define PCIE_CFG_ADDR			0x20
+#define PCIE_CFG_DATA			0x24
+
+#define PCIE_SETTING_REG		0x80
+
+#define PCIE_PCI_IDS_1			0x9c
+#define PCIE_RC_MODE			BIT(0)
+#define PCI_CLASS(class)		(class << 8)
+
+#define PCIE_CFGNUM_REG			0x140
+#define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
+#define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
+#define PCIE_CFG_BYTE_EN(bytes)		(((bytes) << 16) & GENMASK(19, 16))
+#define PCIE_CFG_FORCE_BYTE_EN		BIT(20)
+#define PCIE_CFG_OFFSET_ADDR		0x1000
+#define PCIE_CFG_HEADER(bus, devfn)	(PCIE_CFG_BUS(bus) | PCIE_CFG_DEVFN(devfn))
+
+#define PCIE_RST_CTRL_REG		0x148
+#define PCIE_MAC_RSTB			BIT(0)
+#define PCIE_PHY_RSTB			BIT(1)
+#define PCIE_BRG_RSTB			BIT(2)
+#define PCIE_PE_RSTB			BIT(3)
+
+#define PCIE_LINK_STATUS_REG		0x154
+#define PCIE_PORT_LINKUP		BIT(8)
+
+#define PCIE_INT_ENABLE_REG		0x180
+
+#define PCIE_MISC_CTRL_REG		0x348
+#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
+
+#define PCIE_TRANS_TABLE_BASE_REG       0x800
+#define PCIE_ATR_SRC_ADDR_MSB_OFFSET    0x4
+#define PCIE_ATR_TRSL_ADDR_LSB_OFFSET   0x8
+#define PCIE_ATR_TRSL_ADDR_MSB_OFFSET   0xc
+#define PCIE_ATR_TRSL_PARAM_OFFSET      0x10
+#define PCIE_ATR_TLB_SET_OFFSET         0x20
+
+#define PCIE_MAX_TRANS_TABLES           8
+#define PCIE_ATR_EN                     BIT(0)
+#define PCIE_ATR_SIZE(size) \
+	(((((size) - 1) << 1) & GENMASK(6, 1)) | PCIE_ATR_EN)
+#define PCIE_ATR_ID(id)                 ((id) & GENMASK(3, 0))
+#define PCIE_ATR_TYPE_MEM               PCIE_ATR_ID(0)
+#define PCIE_ATR_TYPE_IO                PCIE_ATR_ID(1)
+#define PCIE_ATR_TLP_TYPE(type)         (((type) << 16) & GENMASK(18, 16))
+#define PCIE_ATR_TLP_TYPE_MEM           PCIE_ATR_TLP_TYPE(0)
+#define PCIE_ATR_TLP_TYPE_IO            PCIE_ATR_TLP_TYPE(2)
+
+struct mtk_pcie {
+	void __iomem *base;
+	void *priv;
+	struct clk pl_250m_ck;
+	struct clk tl_26m_ck;
+	struct clk peri_26m_ck;
+	struct clk top_133m_ck;
+	struct reset_ctl reset_phy;
+	struct reset_ctl reset_mac;
+	bool use_dedicated_phy;
+	struct phy phy;
+};
+
+static void mtk_pcie_config_tlp_header(const struct udevice *bus,
+				       pci_dev_t devfn,
+				       int where, int size)
+{
+	struct mtk_pcie *pcie = dev_get_priv(bus);
+	int bytes;
+	u32 val;
+
+	size = 1 << size;
+	bytes = (GENMASK(size - 1, 0) & 0xf) << (where & 0x3);
+
+	val = PCIE_CFG_FORCE_BYTE_EN | PCIE_CFG_BYTE_EN(bytes) |
+	      PCIE_CFG_HEADER(PCI_BUS(devfn), (devfn >> 8));
+
+	writel(val, pcie->base + PCIE_CFGNUM_REG);
+}
+
+static int mtk_pcie_config_address(const struct udevice *udev, pci_dev_t bdf,
+				   uint offset, void **paddress)
+{
+	struct mtk_pcie *pcie = dev_get_priv(udev);
+
+	*paddress = pcie->base + PCIE_CFG_OFFSET_ADDR + offset;
+
+	return 0;
+}
+
+static int mtk_pcie_read_config(const struct udevice *bus, pci_dev_t bdf,
+				uint offset, ulong *valuep,
+				enum pci_size_t size)
+{
+	int ret;
+
+	mtk_pcie_config_tlp_header(bus, bdf, offset, size);
+	ret = pci_generic_mmap_read_config(bus, mtk_pcie_config_address,
+					   bdf, offset, valuep, size);
+	return ret;
+}
+
+static int mtk_pcie_write_config(struct udevice *bus, pci_dev_t bdf,
+				 uint offset, ulong value,
+				 enum pci_size_t size)
+{
+	mtk_pcie_config_tlp_header(bus, bdf, offset, size);
+
+	switch (size) {
+	case PCI_SIZE_8:
+	case PCI_SIZE_16:
+		value <<= (offset & 0x3) * 8;
+	case PCI_SIZE_32:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pci_generic_mmap_write_config(bus, mtk_pcie_config_address,
+					     bdf, (offset & ~0x3), value, PCI_SIZE_32);
+}
+
+static const struct dm_pci_ops mtk_pcie_ops = {
+	.read_config	= mtk_pcie_read_config,
+	.write_config	= mtk_pcie_write_config,
+};
+
+static int mtk_pcie_set_trans_table(struct mtk_pcie *pcie, u64 cpu_addr,
+				    u64 pci_addr, u64 size,
+				    unsigned long type, int num)
+{
+	void __iomem *table;
+	u32 val;
+
+	if (num >= PCIE_MAX_TRANS_TABLES) {
+		printf("not enough translate table for addr: %#llx, limited to [%d]\n",
+		       (unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
+		return -ENODEV;
+	}
+
+	table = pcie->base + PCIE_TRANS_TABLE_BASE_REG +
+		num * PCIE_ATR_TLB_SET_OFFSET;
+
+	writel(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1), table);
+	writel(upper_32_bits(cpu_addr), table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
+	writel(lower_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
+	writel(upper_32_bits(pci_addr), table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
+
+	if (type == PCI_REGION_IO)
+		val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
+	else
+		val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
+	writel(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
+
+	return 0;
+}
+
+static int mtk_pcie_startup_port(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	struct udevice *ctlr = pci_get_controller(dev);
+	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
+	u32 val;
+	int i, err;
+
+	/* Set as RC mode */
+	val = readl(pcie->base + PCIE_SETTING_REG);
+	val |= PCIE_RC_MODE;
+	writel(val, pcie->base + PCIE_SETTING_REG);
+
+	/* setup RC BARs */
+	writel(PCI_BASE_ADDRESS_MEM_TYPE_64,
+	       pcie->base + PCI_BASE_ADDRESS_0);
+	writel(0x0, pcie->base + PCI_BASE_ADDRESS_1);
+
+	/* setup interrupt pins */
+	clrsetbits_le32(pcie->base + PCI_INTERRUPT_LINE,
+			0xff00, 0x100);
+
+	/* setup bus numbers */
+	clrsetbits_le32(pcie->base + PCI_PRIMARY_BUS,
+			0xffffff, 0x00ff0100);
+
+	/* setup command register */
+	clrsetbits_le32(pcie->base + PCI_PRIMARY_BUS,
+			0xffff,
+			PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+			PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
+
+	/* Set class code */
+	val = readl(pcie->base + PCIE_PCI_IDS_1);
+	val &= ~GENMASK(31, 8);
+	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
+	writel(val, pcie->base + PCIE_PCI_IDS_1);
+
+	/* Mask all INTx interrupts */
+	val = readl(pcie->base + PCIE_INT_ENABLE_REG);
+	val &= ~0xFF000000;
+	writel(val, pcie->base + PCIE_INT_ENABLE_REG);
+
+	/* Disable DVFSRC voltage request */
+	val = readl(pcie->base + PCIE_MISC_CTRL_REG);
+	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
+	writel(val, pcie->base + PCIE_MISC_CTRL_REG);
+
+	/* Assert all reset signals */
+	val = readl(pcie->base + PCIE_RST_CTRL_REG);
+	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	/*
+	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
+	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	mdelay(100);
+
+	/* De-assert reset signals */
+	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	mdelay(100);
+
+	/* De-assert PERST# signals */
+	val &= ~(PCIE_PE_RSTB);
+	writel(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
+				 !!(val & PCIE_PORT_LINKUP),
+				 100 * 1000);
+	if (err) {
+		printf("no card detected at 0x%08lx\n", (unsigned long)pcie->base);
+		return -ETIMEDOUT;
+	}
+	printf("detected a card at 0x%08lx\n", (unsigned long)pcie->base);
+
+	for (i = 0; i < hose->region_count; i++) {
+		struct pci_region *reg = &hose->regions[i];
+
+		if (reg->flags != PCI_REGION_MEM)
+			continue;
+
+		mtk_pcie_set_trans_table(pcie, reg->bus_start, reg->phys_start,
+					 reg->size, reg->flags, 0);
+	}
+
+	return 0;
+}
+
+static int mtk_pcie_power_on(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	int err;
+
+	pcie->base = dev_remap_addr_name(dev, "pcie-mac");
+	if (!pcie->base)
+		return -ENOENT;
+
+	pcie->priv = dev;
+
+	pcie->use_dedicated_phy  = dev_read_bool(dev, "use-dedicated-phy");
+
+	if (!pcie->use_dedicated_phy) {
+		err = generic_phy_get_by_name(dev, "pcie-phy", &pcie->phy);
+		if (err)
+			return err;
+	}
+
+	err = clk_get_by_name(dev, "pl_250m", &pcie->pl_250m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_name(dev, "tl_26m", &pcie->tl_26m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_name(dev, "peri_26m", &pcie->peri_26m_ck);
+	if (err)
+		return err;
+
+	err = clk_get_by_name(dev, "top_133m", &pcie->top_133m_ck);
+	if (err)
+		return err;
+
+	err = generic_phy_init(&pcie->phy);
+	if (err)
+		return err;
+
+	if (!pcie->use_dedicated_phy) {
+		err = generic_phy_power_on(&pcie->phy);
+		if (err)
+			goto err_phy_on;
+	}
+
+	err = clk_enable(&pcie->pl_250m_ck);
+	if (err)
+		goto err_clk_pl_250m;
+
+	err = clk_enable(&pcie->tl_26m_ck);
+	if (err)
+		goto err_clk_tl_26m;
+
+	err = clk_enable(&pcie->peri_26m_ck);
+	if (err)
+		goto err_clk_peri_26m;
+
+	err = clk_enable(&pcie->top_133m_ck);
+	if (err)
+		goto err_clk_top_133m;
+
+	err = mtk_pcie_startup_port(dev);
+	if (err)
+		goto err_startup;
+
+	return 0;
+
+err_startup:
+err_clk_top_133m:
+	clk_disable(&pcie->top_133m_ck);
+err_clk_peri_26m:
+	clk_disable(&pcie->peri_26m_ck);
+err_clk_tl_26m:
+	clk_disable(&pcie->tl_26m_ck);
+err_clk_pl_250m:
+	clk_disable(&pcie->pl_250m_ck);
+err_phy_on:
+	generic_phy_exit(&pcie->phy);
+
+	return err;
+}
+
+static int mtk_pcie_probe(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	int err;
+
+	pcie->priv = dev;
+
+	err = mtk_pcie_power_on(dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct udevice_id mtk_pcie_ids[] = {
+	{ .compatible = "mediatek,mt8192-pcie" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_mediatek_gen3) = {
+	.name		= "pcie_mediatek_gen3",
+	.id		= UCLASS_PCI,
+	.of_match	= mtk_pcie_ids,
+	.ops		= &mtk_pcie_ops,
+	.probe		= mtk_pcie_probe,
+	.priv_auto	= sizeof(struct mtk_pcie),
+};
diff --git a/include/dt-bindings/clock/mt7981-clk.h b/include/dt-bindings/clock/mt7981-clk.h
index e24c759e4992..1c2781cd765c 100644
--- a/include/dt-bindings/clock/mt7981-clk.h
+++ b/include/dt-bindings/clock/mt7981-clk.h
@@ -226,7 +226,8 @@
 #define CK_INFRA_IPCIE_CK		(54 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_IPCIER_CK		(55 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_IPCIEB_CK		(56 - INFRACFG_AO_OFFSET)
-#define CLK_INFRA_AO_NR_CLK		(57 - INFRACFG_AO_OFFSET)
+#define CK_INFRA_IPCIE_PIPE_CK		(57 - INFRACFG_AO_OFFSET)
+#define CLK_INFRA_AO_NR_CLK		(58 - INFRACFG_AO_OFFSET)
 
 /* APMIXEDSYS */
 
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 820f86318316..fdf705921700 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -205,7 +205,8 @@
 #define CK_INFRA_IPCIE_CK		42
 #define CK_INFRA_IPCIER_CK		43
 #define CK_INFRA_IPCIEB_CK		44
-#define CLK_INFRA_AO_NR_CLK		45
+#define CK_INFRA_IPCIE_PIPE_CK		45
+#define CLK_INFRA_AO_NR_CLK		46
 
 /* APMIXEDSYS */
 
-- 
2.34.1

