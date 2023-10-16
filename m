Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D532BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCB186DE3;
	Mon, 16 Oct 2023 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460667;
	bh=flwpGdmvB01L16kVMmSMTF6dSYhgLiwO1nluhK0ubS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RbcP6/RM4dpkB1KvAr7ZaX1atdb8/a3Zl0AVV1IxB5MOWTFa1BfhAw3HIFTQOOKWe
	 3UHF9ZlOBYBjas0EClEBry0c1Yg3dC2/ffg7g2B166+z4+29VjsX0ODdcwD8s6F4ZJ
	 JALqxbpHqenDLQp9wB2SyI+UkN+fx3gJlTuMgXmDYhMts17rP8QmH2ckZy6lQgBkDa
	 xRVrzrHaoeNP3cIW7PfaJDKRU4RXD0vcwzbe40uFqQUviWHEEypD7UPNgTTFlE4qdz
	 VRL0OX+AfuwK6Hkem3WrXCi9iECQatrSRNCb5q+RQG9XkO0+gt/ojOV1a6qvzwiIOt
	 PbKozlWOqEVXw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2595986BE0;
 Mon, 16 Oct 2023 14:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460662;
 bh=flwpGdmvB01L16kVMmSMTF6dSYhgLiwO1nluhK0ubS0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tq4LqFBg7vgF9dH7RNmJE967gOd03s0m6wLitamUAzVaHaDiBrrUC6XS1O1Q0J1Xs
 0TeXWalR1c74/EtCrD5hGFl35IJlJPCZwYqlKaZ4NW7Hfyam004kHSJJPhJCN9cuBR
 1qbwC3Y/F8499flaQCaBAYbw/9vlAUaEthvfGToqtWq+psEAyz7T2qLIUf+yzpmmrd
 W+ys/GCkJNs9hgE3QIq6xFHTVobHbhabC3U52n+ByCxHmOMmpSny0rQMN6wSWkda7k
 /6ySZ8sAd1suI9EIR6ph2ErAMzHJtk5BdN/Bf404w7cPOLXAFLzrxPR0WE7+E9Jf7r
 QE28vvm8meQQw==
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
Subject: [PATCH v2 5/7] arm64: dts: imx8mp: Add DT overlay describing i.MX8MP
 DHCOM SoM rev.100
Date: Mon, 16 Oct 2023 14:50:06 +0200
Message-ID: <20231016125019.21583-5-marex@denx.de>
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

The current imx8mp-dhcom-som.dtsi describes production rev.200 SoM,
add DT overlay which reinstates rev.100 SoM description to permit
prototype rev.100 SoMs to be used until they get phased out.

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
 arch/arm/dts/Makefile                         |   2 +
 .../dts/imx8mp-dhcom-pdk3-overlay-rev100.dts  |  10 ++
 .../dts/imx8mp-dhcom-som-overlay-rev100.dts   | 120 ++++++++++++++++++
 arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |   8 +-
 board/dhelectronics/dh_imx8mp/spl.c           |  16 +++
 5 files changed, 152 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
 create mode 100644 arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 16494a7f1b8..fbd7217feb4 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1063,11 +1063,13 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mq-phanbell.dtb \
 	imx8mp-beacon-kit.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
+	imx8mp-dhcom-som-overlay-rev100.dtbo \
 	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
 	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
+	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
 	imx8mp-evk.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
new file mode 100644
index 00000000000..f27e6429abe
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2023 Marek Vasut <marex@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+&ethphy0g {
+	reg = <7>;
+};
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
new file mode 100644
index 00000000000..5d9a00c9429
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2023 Marek Vasut <marex@denx.de>
+ */
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "imx8mp-pinfunc.h"
+
+&brcmf {
+	reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+};
+
+&eeprom0 {	/* EEPROM with EQoS MAC address */
+	compatible = "atmel,24c02";
+	pagesize = <16>;
+};
+
+&eeprom1 {	/* EEPROM with FEC MAC address */
+	compatible = "atmel,24c02";
+	pagesize = <16>;
+};
+
+&ethphy0f { /* SMSC LAN8740Ai */
+	pinctrl-0 = <&pinctrl_ethphy0 &pinctrl_ioexp>;
+	reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+};
+
+&ethphy0g { /* Micrel KSZ9131RNXI */
+	pinctrl-0 = <&pinctrl_ethphy0 &pinctrl_ioexp>;
+	reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+};
+
+&i2c3 {
+	adc@48 {
+		compatible = "ti,tla2024";
+		interrupts-extended;
+	};
+};
+
+&ioexp {
+	status = "disabled";
+};
+
+&reg_eth_vio {
+	gpio = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_enet_vio>;
+	pinctrl-names = "default";
+};
+
+&rv3032 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rtc>;
+	interrupts-extended = <&gpio5 5 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&uart2 {
+	bluetooth {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_uart2_bt>;
+		shutdown-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&usb_dwc3_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb0_vbus>;
+};
+
+&usdhc1 {
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_usdhc1_wl_reg_en>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_usdhc1_wl_reg_en>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_usdhc1_wl_reg_en>;
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog_base
+		     &pinctrl_dhcom_a &pinctrl_dhcom_b &pinctrl_dhcom_c
+		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
+		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_i
+		     &pinctrl_dhcom_j &pinctrl_dhcom_k &pinctrl_dhcom_l
+		     /* GPIO_M is connected to CLKOUT2 */
+		     &pinctrl_dhcom_int>;
+
+	pinctrl_enet_vio: dhcom-enet-vio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x22
+		>;
+	};
+
+	pinctrl_rtc: dhcom-rtc-grp {
+		fsl,pins = <
+			/* RTC_#INT Interrupt */
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x400001c6
+		>;
+	};
+
+	pinctrl_uart2_bt: dhcom-uart2-bt-grp {
+		fsl,pins = <
+			/* BT_REG_EN */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x144
+		>;
+	};
+
+	pinctrl_usb0_vbus: dhcom-usb0-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__USB1_OTG_ID		0x0
+		>;
+	};
+
+	pinctrl_usdhc1_wl_reg_en: dhcom-usdhc1-wl-reg-en-grp {
+		fsl,pins = <
+			/* WL_REG_EN */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x144
+		>;
+	};
+};
diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
index 6f21fbe1151..a29db0ddd3f 100644
--- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
@@ -178,13 +178,13 @@
 					};
 				};
 
-				fdt-dto-imx8mp-dhcom-pdk-overlay-rev100 {
-					description = "imx8mp-dhcom-pdk-overlay-rev100";
+				fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 {
+					description = "imx8mp-dhcom-pdk3-overlay-rev100";
 					type = "flat_dt";
 					compression = "none";
 
 					blob-ext {
-						filename = "imx8mp-dhcom-pdk-overlay-rev100.dtbo";
+						filename = "imx8mp-dhcom-pdk3-overlay-rev100.dtbo";
 					};
 				};
 			};
@@ -198,7 +198,7 @@
 					      "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
 					      "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast",
 					      "fdt-dto-imx8mp-dhcom-som-overlay-rev100",
-					      "fdt-dto-imx8mp-dhcom-pdk-overlay-rev100";
+					      "fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100";
 				};
 			};
 		};
diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 8dc464b1dd7..1b05da53c35 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -44,6 +44,7 @@ static const iomux_v3_cfg_t wdog_pads[] = {
 };
 
 static bool dh_gigabit_eqos, dh_gigabit_fec;
+static u8 dh_som_rev;
 
 static void dh_imx8mp_early_init_f(void)
 {
@@ -166,6 +167,15 @@ int board_spl_fit_append_fdt_skip(const char *name)
 		}
 	}
 
+	if (dh_som_rev == 0x0) { /* Prototype SoM rev.100 */
+		if (!strcmp(name, "fdt-dto-imx8mp-dhcom-som-overlay-rev100"))
+			return 0;
+
+		if (!strcmp(name, "fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100") &&
+		    of_machine_is_compatible("dh,imx8mp-dhcom-pdk3"))
+			return 0;
+	}
+
 	return 1;	/* Skip this DTO */
 }
 
@@ -175,6 +185,9 @@ static void dh_imx8mp_board_cache_config(void)
 	const u32 mux_sion[] = {
 		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_ENET_RX_CTL__GPIO1_IO24),
 		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_SAI1_TXFS__GPIO4_IO10),
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_NAND_DQS__GPIO3_IO14),
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_SAI1_TXD7__GPIO4_IO19),
+		FIELD_GET(MUX_CTRL_OFS_MASK, MX8MP_PAD_SAI5_MCLK__GPIO3_IO25),
 	};
 	int i;
 
@@ -183,6 +196,9 @@ static void dh_imx8mp_board_cache_config(void)
 
 	dh_gigabit_eqos = !(readl(GPIO1_BASE_ADDR) & BIT(24));
 	dh_gigabit_fec = !(readl(GPIO4_BASE_ADDR) & BIT(10));
+	dh_som_rev = !!(readl(GPIO3_BASE_ADDR) & BIT(14));
+	dh_som_rev |= !!(readl(GPIO4_BASE_ADDR) & BIT(19)) << 1;
+	dh_som_rev |= !!(readl(GPIO3_BASE_ADDR) & BIT(25)) << 2;
 
 	for (i = 0; i < ARRAY_SIZE(mux_sion); i++)
 		clrbits_le32(mux_base + mux_sion[i], IOMUX_CONFIG_SION);
-- 
2.42.0

