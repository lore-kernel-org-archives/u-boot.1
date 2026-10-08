Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56924CA600A
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 07:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E2C4810DD;
	Thu,  8 Oct 2026 07:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QgQw3DGDTuZ; Thu,  8 Oct 2026 07:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 27E7F81191
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791444629;
	b=E08+QCwBbR1UfWljeVzen8GzOl17SKgVaUmSQcMvVYehwUgL45+46wwB8gZtowEnmlur
	 LNc4ZfhukBVAG+5a2hfLlTqpakjRlaIhonaDqY3tv7bHau9P4tNpLSPEvB/6JFMTodcX7
	 Q5rz8P4UiPyFEKqiOf4//Z+PiCFY0HiD4ODACWm6xPN6WJ0GOQIGE2GmrE8xpAli5jxJ3
	 hsD8hL9jVLx/GXyH13X1SgH2pHwDuaFd7gScRWY7PoAe7Vv7JdNGGxWpPciZOktAFevsW
	 K4YFgxjBW1IpvJu+Bem4JAt2V1oSSAqGPA58uJc2dQJBe8xXCHigjy0qCTnzodlGOtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791444629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=quEy9pF8A85AoXXsClBjOaNKu/KRsZc+Rjczb0Hy2es=;
	b=sIfZ5dBwDYY9OyidqZsQfVntYcMYhD33Vi/UpHD4hYGLRmJqlv18kDif4eku3SbIsWHc
	 QI0buRxYk8vwDyvLdhAF1t9hmXdx3Jn9iaPWFD7EeqcNVLFBaomtxdfRnH3YuSXsI1vYH
	 Q0GR8JOjKec78RMg7YCg8oQWj9Gnz+Ph+Z53QgFA/U+6Xb9w8Zfj7pc+Azi1j+98LBHbN
	 +PifN+AkyevapCXnykNvvHIZr8OFuC4vcep7xeiV8gXUadpWHZuAIQlqjR59R+DPCfUxO
	 JM24f/cfDhFqNbC3y/oLy0ElTQ3GOM4HCbTCPXv8/svbYtkK40+qNf1Cr25lgZghIVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791444629;
	bh=quEy9pF8A85AoXXsClBjOaNKu/KRsZc+Rjczb0Hy2es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/bPyKbwdXv5dfj8fA22FLg4PIW+cdrqa8tf9dhy8ClCptQN4nm8o3apa0++4sZ61
	 rhHNGpwCOZEpAIYv+uCpaCn417fBOjvEwemtCBynGY8L3wShL6QWrabeBcpjovbxI1
	 kRTsAk057C2yTfMhzmqRM3YSDBzBcHg5ROUkIznNe3HxSryuHNz6A+nGCGl/9jcY3+
	 6CBawnbTFMERtKcz5edIKdmkHbXiIn9LtZFH2otXw3CQDeh0mGPO8+DFq9VU94pXQq
	 JlOudolRbsTDMLaeFYZ1ot0qcFl928/eGxuhQUTxQOQAas+vIhN2OFeWHT4hHnFWby
	 it4ral5YoGrpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27E7F81191;
	Thu,  8 Oct 2026 07:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CCC5150D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02CFF60672
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fDe6iDNl2OO for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AA50D606FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791444625;
 b=Vbk/C7iSERGruggAtnERVm0PzjCO8YvGP8eq3Azfdr69vz0AA4KSfoWszTPTvKLxFamZ
 LszC1a8FIXojCtLV+caTe/Gca+BoW8IIVhkhsDrlEkv5RoziSB/zqmlFHW6ZdoUBieHXL
 lFQDCkYx8w+n/jWZYMASwTu+9nGWJazcUaGrs2ot4lqXSWBPYr8SAqfUFkGmf7Q5ZniTE
 3fuKuX34F4G4c3QHI7hmtzrAuKy52djpCmbjQUBm0b5k/DcfN0xK1pOFSMsZ3v4ypoojM
 HSpP4Q9YgNaBbhzntand7sE7zZtYo9RrI/YM9Bf8aVNL3KDxuryfZJQj/y96DHN1OYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791444625;
 h=Received-SPF:Received:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=quEy9pF8A85AoXXsClBjOaNKu/KRsZc+Rjczb0Hy2es=;
 b=srhZOVMGUB06T4ohP0iquc0IctCH72aHoeUiNRbsdCTreVJlMtK4zsBCw+O4HnPXWeQA
 4iCsOq2PxtWveLbUZzcYVJAdEp9QSdevzL23dbKIUMtf+PHvclGWsSA838B1/PncR+28p
 1QgYYgawNdcoYfp1x25RnvmtklF6mBs2XJP7E4qWpS08TayWf4ii29DRJOsu9bAd0daRD
 1ebgDAq8CoVQEXbI93NoB3/B8//BblwFxOF1d1EEvFsQoXx6jw9BgpWxtMdp72MUBVbVa
 BQ+ymB2w6fwzi40LVgzKNuq3ig8SsoGZtiVKLWe9tzAbgZHPbW5gZadkCUl7w24QaNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 arc=none smtp.remote-ip=92.121.34.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=elena.popa@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA50D606FF
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:30:23 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EBF7A200249;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE431200237;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
Received: from lsv052348.swis.nl-cdc01.nxp.com
 (lsv052348.swis.nl-cdc01.nxp.com [10.168.26.87])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 43734203CF;
 Thu,  8 Oct 2026 09:30:21 +0200 (CEST)
From: Elena Popa <elena.popa@nxp.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 peng.fan@nxp.com, ilias.apalodimas@linaro.org
Cc: laurentiu.mihalcea@nxp.com, cosmin.stoica@nxp.com,
 Elena Popa <elena.popa@nxp.com>
Subject: [PATCH v3 1/2] arm64: dts: freescale: add the MR-NAVQ95 DTS
Date: Thu,  8 Oct 2026 09:29:55 +0200
Message-ID: <20261008073014.1184539-2-elena.popa@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008073014.1184539-1-elena.popa@nxp.com>
References: <20261008073014.1184539-1-elena.popa@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Import the MR-NAVQ95 device tree file from upstream Linux. The DTS
content is identical to the version accepted upstream and merged into
linux-next. A subsequent change will switch the board to OF_UPSTREAM
once the DTS appears in devicetree-rebasing.

Sync with Linux commit 3893cb7b467476878dc2de1b8b313f60ffa6c369 ("arm64:
dts: freescale: add MR-NAVQ95 basic board support") merged into
linux-next.

Signed-off-by: Elena Popa <elena.popa@nxp.com>
---
 arch/arm/dts/imx95-navq.dts | 228 ++++++++++++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100644 arch/arm/dts/imx95-navq.dts

diff --git a/arch/arm/dts/imx95-navq.dts b/arch/arm/dts/imx95-navq.dts
new file mode 100644
index 00000000000..7860c113e9e
--- /dev/null
+++ b/arch/arm/dts/imx95-navq.dts
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2026 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP MR-NAVQ95";
+	compatible = "fsl,imx95-navq", "fsl,imx95";
+
+	aliases {
+		ethernet0 = &enetc_port0;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* actual size filled in by the bootloader */
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		bootph-pre-ram;
+		enable-active-high;
+		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD_SD2_3V3";
+	};
+};
+
+&edma1 {
+	/* owned by M7 */
+	status = "reserved";
+};
+
+&edma2 {
+	/* channels 30-63 owned by M7 */
+	dma-channels = <30>;
+};
+
+&enetc_port0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	i2c3_gpio_expander_21: gpio-expander@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_i2c3_gpio_expander_21>;
+		pinctrl-names = "default";
+	};
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-0 = <&pinctrl_emdio>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	ethphy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <1>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&i2c3_gpio_expander_21 1 GPIO_ACTIVE_LOW>;
+		realtek,clkout-disable;
+	};
+};
+
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC			0x57e>,
+			   <IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO			0x97e>;
+	};
+
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x57e>,
+			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x57e>,
+			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x57e>,
+			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x57e>,
+			   <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>,
+			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>,
+			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>,
+			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>,
+			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>,
+			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>,
+			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>,
+			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>;
+	};
+
+	pinctrl_i2c3_gpio_expander_21: i2c3gpioexpander21grp {
+		fsl,pins = <IMX95_PAD_ENET2_RD3__GPIO4_IO_BIT27				0x31e>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA				0x40000b9e>,
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL				0x40000b9e>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7			0x31e>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX			0x31e>,
+			   <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX			0x31e>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK				0x15fe>,
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD				0x13fe>,
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0				0x13fe>,
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1				0x13fe>,
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2				0x13fe>,
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3				0x13fe>,
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4				0x13fe>,
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5				0x13fe>,
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6				0x13fe>,
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7				0x13fe>,
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE				0x15fe>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK				0x158e>,
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD				0x138e>,
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0				0x138e>,
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1				0x138e>,
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2				0x138e>,
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3				0x138e>,
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4				0x138e>,
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5				0x138e>,
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6				0x138e>,
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7				0x138e>,
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE				0x158e>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0				0x31e>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		bootph-pre-ram;
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK				0x158e>,
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD				0x138e>,
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0				0x138e>,
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1				0x138e>,
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2				0x138e>,
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3				0x138e>,
+			   <IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT			0x51e>;
+	};
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+	bus-width = <8>;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+
+	status = "okay";
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+	bus-width = <4>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+
+	status = "okay";
+};
-- 
2.43.0

