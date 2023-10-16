Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA469CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEEA86C26;
	Mon, 16 Oct 2023 14:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460663;
	bh=7PvM7tN2I5U1LwVD/k4QESU+MYX0sFgQ7X5QHHPe28o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bNejV3XkLVARwJlYRcnGGeY7RWV7na0VUPpX8NVuiFg6lFVJlnEqhDuoiwIh65yF0
	 VefcO32ZE8X3DGzFL/mZPHyKzAC+StWhcPTr0+jv8g2bup6yXY4fiWecjLUieATmkO
	 awhrn9qfjAAm8JzsMu093lMJEEVT5D9AsO2QEkXRfTw9NHmeMFgk6BhDbld8HKNKtg
	 t6hcjZOFbbqAKmECBggJcuRAwpfKzdlHUoVjlAw5W+XSZHDaKbNKdDPETgEANTYqsJ
	 bCargg4PeO6BNuBeLAwrgTE7/Sd5hSKdeeRcfrX4LQShRf+Ji5RF1czf/C1qudSeY5
	 bidE3fEdxWV8Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8B948869D1;
 Mon, 16 Oct 2023 14:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460661;
 bh=7PvM7tN2I5U1LwVD/k4QESU+MYX0sFgQ7X5QHHPe28o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gmqF7+2NDObfasY87NMp7rh9brHdXBCdJnO6822ckW4ALaWxB4rrwa1ZtDQR9vniE
 QxhNH+0a/Cq8RjXgb9qKtcJg3ceQyrbi/ZunlAu62bxT9QsaE90vSJ5ocTaz2wcGz6
 c43qNzqu/xpM6ieXhXTC1kRxnnOV4G7qNSHX+txH59nvvk7m7eMB3+8S+SB2cZxK9S
 aYUGK5n7PfBJzf5fun/aotM6iPpnQ3DkKLQadvhQdENBeg7QQCg4UVoLnbrQG1Q4cu
 mnmArYjMDTZov45XoWrfhA/keyWFBG+z6hosX9MZYWiSb1iy8mp4BO04M9FNJBmBOf
 6UnFjQ35R1mcQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Fabio Estevam <festevam@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH v2 2/7] arm64: dts: imx8mp: Switch to DT overlays for i.MX8MP
 DHCOM SoM
Date: Mon, 16 Oct 2023 14:50:03 +0200
Message-ID: <20231016125019.21583-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016125019.21583-1-marex@denx.de>
References: <20231016125019.21583-1-marex@denx.de>
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

Add DT overlays to support additional DH i.MX8MP DHCOM SoM 660-100
population options with 1x or 2x RMII PHY mounted on PDK2 or PDK3
carrier boards.

Use SPL DTO support to apply matching SoM specific DTO to cater
for the SoM differences. Remove ad-hoc patching of control DT from
fdtdec_board_setup().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
V2: Rebase and collect the patches in one series
---
 arch/arm/dts/Makefile                         |   3 +
 .../imx8mp-dhcom-pdk-overlay-eth2xfast.dts    |  10 +
 .../imx8mp-dhcom-som-overlay-eth1xfast.dts    |  43 ++++
 .../imx8mp-dhcom-som-overlay-eth2xfast.dts    |  24 ++
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |  49 ++++
 .../dh_imx8mp/imx8mp_dhcom_pdk2.c             | 228 ------------------
 board/dhelectronics/dh_imx8mp/spl.c           |  46 ++++
 configs/imx8mp_dhcom_pdk3_defconfig           |   3 +
 8 files changed, 178 insertions(+), 228 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
 create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
 create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 6e9c5f07999..16494a7f1b8 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1063,6 +1063,9 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-phanbell.dtb \
 	imx8mp-beacon-kit.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
+	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
+	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
+	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
 	imx8mp-evk.dtb \
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
new file mode 100644
index 00000000000..3b397776920
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2023 Marek Vasut <marex@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+&ethphypdk {	/* Micrel KSZ9131RNXI */
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
new file mode 100644
index 00000000000..bb5a2b68175
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2023 Marek Vasut <marex@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+&eqos {	/* First ethernet */
+	pinctrl-0 = <&pinctrl_eqos_rmii>;
+	phy-handle = <&ethphy0f>;
+	phy-mode = "rmii";
+
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
+				 <&clk IMX8MP_SYS_PLL2_100M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>;
+};
+
+&ethphy0g {	/* Micrel KSZ9131RNXI */
+	status = "disabled";
+};
+
+&ethphy0f {	/* SMSC LAN8740Ai */
+	status = "okay";
+};
+
+&fec {	/* Second ethernet -- HS connector not populated on 1x RMII PHY SoM */
+	status = "disabled";
+};
+
+/* No WiFi/BT chipset on this SoM variant. */
+
+&uart2 {
+	bluetooth {
+		status = "disabled";
+	};
+};
+
+&usdhc1 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts
new file mode 100644
index 00000000000..82dadcea96c
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2023 Marek Vasut <marex@denx.de>
+ */
+#include "imx8mp-dhcom-som-overlay-eth1xfast.dts"
+
+/* Dual RMII 100/Full Fast ethernet on this SoM variant. */
+
+&fec {	/* Second ethernet */
+	pinctrl-0 = <&pinctrl_fec_rmii>;
+	phy-handle = <&ethphy1f>;
+	phy-mode = "rmii";
+	status = "okay";
+
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
+				 <&clk IMX8MP_SYS_PLL2_100M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>, <0>;
+};
+
+&ethphy1f {	/* SMSC LAN8740Ai */
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index 59d31eebc3e..00e1db66568 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -133,3 +133,52 @@
 &wdog1 {
 	bootph-pre-ram;
 };
+
+&binman {
+	itb {
+		fit {
+			images {
+				fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast {
+					description = "imx8mp-dhcom-som-overlay-eth1xfast";
+					type = "flat_dt";
+					compression = "none";
+
+					blob-ext {
+						filename = "imx8mp-dhcom-som-overlay-eth1xfast.dtbo";
+					};
+				};
+
+				fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast {
+					description = "imx8mp-dhcom-som-overlay-eth2xfast";
+					type = "flat_dt";
+					compression = "none";
+
+					blob-ext {
+						filename = "imx8mp-dhcom-som-overlay-eth2xfast.dtbo";
+					};
+				};
+
+				fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast {
+					description = "imx8mp-dhcom-pdk-overlay-eth2xfast";
+					type = "flat_dt";
+					compression = "none";
+
+					blob-ext {
+						filename = "imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+
+				@config-SEQ {
+					fdt = "fdt-1",
+					      "fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast",
+					      "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
+					      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast";
+				};
+			};
+		};
+	};
+};
diff --git a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
index 760ea4be35c..5edb85e1de5 100644
--- a/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
+++ b/board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c
@@ -5,16 +5,12 @@
 
 #include <common.h>
 #include <asm/arch/clock.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <dm.h>
-#include <dt-bindings/clock/imx8mp-clock.h>
 #include <env.h>
 #include <env_internal.h>
 #include <i2c_eeprom.h>
-#include <linux/bitfield.h>
 #include <malloc.h>
 #include <net.h>
 #include <miiphy.h>
@@ -120,227 +116,3 @@ enum env_location env_get_location(enum env_operation op, int prio)
 {
 	return prio ? ENVL_UNKNOWN : ENVL_SPI_FLASH;
 }
-
-static const char *iomuxc_compat = "fsl,imx8mp-iomuxc";
-static const char *lan_compat = "ethernet-phy-id0007.c110";
-static const char *ksz_compat = "ethernet-phy-id0022.1642";
-
-static int dh_dt_patch_som_eqos(const void *fdt_blob)
-{
-	const void __iomem *mux = (void __iomem *)IOMUXC_BASE_ADDR +
-		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_ENET_RX_CTL__GPIO1_IO24);
-	int mac_node, mdio_node, iomuxc_node, ksz_node, lan_node, subnode;
-	const char *mac_compat = "nxp,imx8mp-dwmac-eqos";
-	void *blob = (void *)fdt_blob;
-	const fdt32_t *clk_prop;
-	bool is_gigabit;
-	u32 handle;
-	u32 clk[6];
-
-	setbits_le32(mux, IOMUX_CONFIG_SION);
-	is_gigabit = !(readl(GPIO1_BASE_ADDR) & BIT(24));
-	clrbits_le32(mux, IOMUX_CONFIG_SION);
-
-	/* Adjust EQoS node for Gigabit KSZ9131RNXI or Fast LAN8740Ai PHY */
-	mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	if (mac_node < 0)
-		return 0;
-
-	mdio_node = fdt_first_subnode(blob, mac_node);
-	if (mdio_node < 0)
-		return 0;
-
-	/* KSZ9131RNXI */
-	ksz_node = fdt_node_offset_by_compatible(blob, mdio_node, ksz_compat);
-	if (ksz_node < 0)
-		return 0;
-
-	/* LAN8740Ai */
-	lan_node = fdt_node_offset_by_compatible(blob, mdio_node, lan_compat);
-	if (lan_node < 0)
-		return 0;
-
-	iomuxc_node = fdt_node_offset_by_compatible(blob, -1, iomuxc_compat);
-	if (iomuxc_node < 0)
-		return 0;
-
-	/*
-	 * The code below adjusts the following DT properties:
-	 * - assigned-clock-parents .. 125 MHz RGMII / 50 MHz RMII ref clock
-	 * - assigned-clock-rates .... 125 MHz RGMII / 50 MHz RMII ref clock
-	 * - phy-handle .............. KSZ9131RNXI RGMII / LAN8740Ai RMII
-	 * - phy-mode ................ RGMII / RMII
-	 * - pinctrl-0 ............... RGMII / RMII
-	 * - PHY subnode status ...... "disabled"/"okay" per RGMII / RMII
-	 */
-
-	/* Perform all inplace changes first, string changes last. */
-	clk_prop = fdt_getprop(blob, mac_node, "assigned-clock-parents", NULL);
-	if (!clk_prop)
-		return 0;
-	clk[0] = clk_prop[0];
-	clk[1] = cpu_to_fdt32(IMX8MP_SYS_PLL1_266M);
-	clk[2] = clk_prop[2];
-	clk[3] = cpu_to_fdt32(IMX8MP_SYS_PLL2_100M);
-	clk[4] = clk_prop[4];
-	clk[5] = is_gigabit ? cpu_to_fdt32(IMX8MP_SYS_PLL2_125M) :
-			      cpu_to_fdt32(IMX8MP_SYS_PLL2_50M);
-	fdt_setprop_inplace(blob, mac_node, "assigned-clock-parents",
-			    clk, 6 * sizeof(u32));
-
-	clk[0] = cpu_to_fdt32(0);
-	clk[1] = cpu_to_fdt32(100000000);
-	clk[2] = is_gigabit ? cpu_to_fdt32(125000000) :
-			      cpu_to_fdt32(50000000);
-	fdt_setprop_inplace(blob, mac_node, "assigned-clock-rates",
-			    clk, 3 * sizeof(u32));
-
-	handle = fdt_get_phandle(blob, is_gigabit ? ksz_node : lan_node);
-	fdt_setprop_inplace_u32(blob, mac_node, "phy-handle", handle);
-
-	fdt_for_each_subnode(subnode, blob, iomuxc_node) {
-		if (!strstr(fdt_get_name(blob, subnode, NULL),
-			    is_gigabit ? "eqos-rgmii" : "eqos-rmii"))
-			continue;
-
-		handle = fdt_get_phandle(blob, subnode);
-		fdt_setprop_inplace_u32(blob, mac_node, "pinctrl-0", handle);
-		break;
-	}
-
-	fdt_setprop_string(blob, mac_node, "phy-mode",
-			   is_gigabit ? "rgmii-id" : "rmii");
-
-	mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	mdio_node = fdt_first_subnode(blob, mac_node);
-	ksz_node = fdt_node_offset_by_compatible(blob, mdio_node, ksz_compat);
-	fdt_setprop_string(blob, ksz_node, "status",
-			   is_gigabit ? "okay" : "disabled");
-
-	mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	mdio_node = fdt_first_subnode(blob, mac_node);
-	lan_node = fdt_node_offset_by_compatible(blob, mdio_node, lan_compat);
-	fdt_setprop_string(blob, lan_node, "status",
-			   is_gigabit ? "disabled" : "okay");
-
-	return 0;
-}
-
-static int dh_dt_patch_som_fec(const void *fdt_blob)
-{
-	const void __iomem *mux = (void __iomem *)IOMUXC_BASE_ADDR +
-		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_SAI1_TXFS__GPIO4_IO10);
-	int mac_node, mdio_node, iomuxc_node, lan_node, phy_node, subnode;
-	const char *mac_compat = "fsl,imx8mp-fec";
-	void *blob = (void *)fdt_blob;
-	const fdt32_t *clk_prop;
-	bool is_gigabit;
-	u32 handle;
-	u32 clk[8];
-
-	setbits_le32(mux, IOMUX_CONFIG_SION);
-	is_gigabit = !(readl(GPIO4_BASE_ADDR) & BIT(10));
-	clrbits_le32(mux, IOMUX_CONFIG_SION);
-
-	/* Test for non-default SoM with 100/Full PHY attached to FEC */
-	if (is_gigabit)
-		return 0;
-
-	/* Adjust FEC node for Fast LAN8740Ai PHY */
-	mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	if (mac_node < 0)
-		return 0;
-
-	/* Optional PHY pointed to by phy-handle, possibly on carrier board */
-	phy_node = fdtdec_lookup_phandle(blob, mac_node, "phy-handle");
-	if (phy_node > 0) {
-		fdt_setprop_string(blob, phy_node, "status", "disabled");
-		mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	}
-
-	mdio_node = fdt_first_subnode(blob, mac_node);
-	if (mdio_node < 0)
-		return 0;
-
-	/* LAN8740Ai */
-	lan_node = fdt_node_offset_by_compatible(blob, mdio_node, lan_compat);
-	if (lan_node < 0)
-		return 0;
-
-	iomuxc_node = fdt_node_offset_by_compatible(blob, -1, iomuxc_compat);
-	if (iomuxc_node < 0)
-		return 0;
-
-	/*
-	 * The code below adjusts the following DT properties:
-	 * - assigned-clock-parents .. 50 MHz RMII ref clock
-	 * - assigned-clock-rates .... 50 MHz RMII ref clock
-	 * - phy-handle .............. LAN8740Ai RMII
-	 * - phy-mode ................ RMII
-	 * - pinctrl-0 ............... RMII
-	 * - PHY subnode status ...... "okay" for RMII PHY
-	 */
-
-	/* Perform all inplace changes first, string changes last. */
-	clk_prop = fdt_getprop(blob, mac_node, "assigned-clock-parents", NULL);
-	if (!clk_prop)
-		return 0;
-	clk[0] = clk_prop[0];
-	clk[1] = cpu_to_fdt32(IMX8MP_SYS_PLL1_266M);
-	clk[2] = clk_prop[2];
-	clk[3] = cpu_to_fdt32(IMX8MP_SYS_PLL2_100M);
-	clk[4] = clk_prop[4];
-	clk[5] = cpu_to_fdt32(IMX8MP_SYS_PLL2_50M);
-	clk[6] = clk_prop[6];
-	clk[7] = cpu_to_fdt32(IMX8MP_SYS_PLL2_50M);
-	fdt_setprop_inplace(blob, mac_node, "assigned-clock-parents",
-			    clk, 8 * sizeof(u32));
-
-	clk[0] = cpu_to_fdt32(0);
-	clk[1] = cpu_to_fdt32(100000000);
-	clk[2] = cpu_to_fdt32(50000000);
-	clk[3] = cpu_to_fdt32(0);
-	fdt_setprop_inplace(blob, mac_node, "assigned-clock-rates",
-			    clk, 4 * sizeof(u32));
-
-	handle = fdt_get_phandle(blob, lan_node);
-	fdt_setprop_inplace_u32(blob, mac_node, "phy-handle", handle);
-
-	fdt_for_each_subnode(subnode, blob, iomuxc_node) {
-		if (!strstr(fdt_get_name(blob, subnode, NULL), "fec-rmii"))
-			continue;
-
-		handle = fdt_get_phandle(blob, subnode);
-		fdt_setprop_inplace_u32(blob, mac_node, "pinctrl-0", handle);
-		break;
-	}
-
-	fdt_setprop_string(blob, mac_node, "phy-mode", "rmii");
-	mac_node = fdt_node_offset_by_compatible(blob, -1, mac_compat);
-	mdio_node = fdt_first_subnode(blob, mac_node);
-	lan_node = fdt_node_offset_by_compatible(blob, mdio_node, lan_compat);
-	fdt_setprop_string(blob, lan_node, "status", "okay");
-
-	return 0;
-}
-
-static int dh_dt_patch_som(const void *fdt_blob)
-{
-	int ret;
-
-	/* Do nothing if not i.MX8MP DHCOM SoM */
-	ret = fdt_node_check_compatible(fdt_blob, 0, "dh,imx8mp-dhcom-som");
-	if (ret)
-		return 0;
-
-	ret = dh_dt_patch_som_eqos(fdt_blob);
-	if (ret)
-		return ret;
-
-	return dh_dt_patch_som_fec(fdt_blob);
-}
-
-int fdtdec_board_setup(const void *fdt_blob)
-{
-	return dh_dt_patch_som(fdt_blob);
-}
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index a8fda139aa4..8dc464b1dd7 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -22,6 +22,8 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 
+#include <linux/bitfield.h>
+
 #include <power/pmic.h>
 #include <power/pca9450.h>
 
@@ -41,6 +43,8 @@ static const iomux_v3_cfg_t wdog_pads[] = {
 	MX8MP_PAD_GPIO1_IO02__WDOG1_WDOG_B  | MUX_PAD_CTRL(WDOG_PAD_CTRL),
 };
 
+static bool dh_gigabit_eqos, dh_gigabit_fec;
+
 static void dh_imx8mp_early_init_f(void)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
@@ -144,6 +148,46 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 	return BOOT_DEVICE_BOOTROM;
 }
 
+int board_spl_fit_append_fdt_skip(const char *name)
+{
+	if (!dh_gigabit_eqos) {		/* 1x or 2x RMII PHY SoM */
+		if (dh_gigabit_fec) {	/* 1x RMII PHY SoM */
+			if (!strcmp(name, "fdt-dto-imx8mp-dhcom-som-overlay-eth1xfast"))
+				return 0;
+		} else {		/* 2x RMII PHY SoM */
+			if (!strcmp(name, "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast"))
+				return 0;
+			if (!strcmp(name, "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast")) {
+				/* 2x RMII PHY SoM on PDK2 or PDK3 */
+				if (of_machine_is_compatible("dh,imx8mp-dhcom-pdk2") ||
+				    of_machine_is_compatible("dh,imx8mp-dhcom-pdk3"))
+					return 0;
+			}
+		}
+	}
+
+	return 1;	/* Skip this DTO */
+}
+
+static void dh_imx8mp_board_cache_config(void)
+{
+	const void __iomem *mux_base = (void __iomem *)IOMUXC_BASE_ADDR;
+	const u32 mux_sion[] = {
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_ENET_RX_CTL__GPIO1_IO24),
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_SAI1_TXFS__GPIO4_IO10),
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mux_sion); i++)
+		setbits_le32(mux_base + mux_sion[i], IOMUX_CONFIG_SION);
+
+	dh_gigabit_eqos = !(readl(GPIO1_BASE_ADDR) & BIT(24));
+	dh_gigabit_fec = !(readl(GPIO4_BASE_ADDR) & BIT(10));
+
+	for (i = 0; i < ARRAY_SIZE(mux_sion); i++)
+		clrbits_le32(mux_base + mux_sion[i], IOMUX_CONFIG_SION);
+}
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -181,5 +225,7 @@ void board_init_f(ulong dummy)
 	/* DDR initialization */
 	spl_dram_init();
 
+	dh_imx8mp_board_cache_config();
+
 	board_init_r(NULL, 0);
 }
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index b617f74321c..5c0c469434a 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-pdk3"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_DH_DHCOM_PDK2=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
@@ -39,6 +40,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
+CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTARGS=y
@@ -64,6 +66,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+# CONFIG_SPL_FIT_IMAGE_TINY is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.42.0

