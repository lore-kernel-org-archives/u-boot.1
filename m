Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F5C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 00:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D225884F6;
	Thu, 27 Jun 2024 02:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719447256;
	bh=lYjGD21QqEYcq/5hcj9DIWtd6OdinRtBW17W1s/xsmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rfsx1VkAdQBk0t8etKsD1QGBXt5ZFW5cZigoeW59qg17x6i1ouGe3Ggdd/zRkXoyO
	 NWtAdh6QJH2vSw3R2w30tONE//AlFQ27Mqt/cEt0M3OsU7EZi2Gn/td+Px6BE6OWHW
	 gdktuPChAQ94n79r/kz5NGdGROkrCujyktFF4XH/pWDDPFULxKuoBgoKHhBqoWxK9w
	 cDdncJP7jZw/qnmR8nTSI86cvCuRyC7eU9B/H2Sa5nQ+FNMgL/Y8w5mq+ZDEvQ3i7g
	 /yrNXZYlE0OvQmlZz7L2REZFLlR3UgRIDVqYykhJUseNLTdS/54arf8wYFw+fBPrOz
	 bRLSwDjYweoDw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CAD96884C7;
 Thu, 27 Jun 2024 02:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719447255;
 bh=lYjGD21QqEYcq/5hcj9DIWtd6OdinRtBW17W1s/xsmc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s+h5EKu9VAPxuSv/4Gffdd7Haak7wEMvSLhUkKYXJiQ53xsqWA921620nvuEuYKu2
 5u3N8fRqnjqVsYfiLMFS3MyWitTfRmZFEWfRbM/W9uXD8cugrvOy+qOCbNzxLzB4+E
 leEj2oloY7T4OIEPUXbY9a5BTUpU3Up8KE/NTrWAIVWWKUYL/BQfQYCIPbV5Q6NMez
 cB1OaNKG2fRHBT2MFxU+nqwTGtQ3zuPUlDlC4DR5FSXSoMampZkRTW/cvuAXOyUhLm
 c6C5RuizMH4Brdwy9oHTU5DprCORu9qcPoD2awj9ieRJ4x6/oO+OFO0zi24GVyQdYP
 wCaPVZ4D7VoVg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/2] ARM: imx: Update Fast ethernet PHY MDIO addresses to
 match DH i.MX8MP DHCOM rev.200
Date: Thu, 27 Jun 2024 02:13:16 +0200
Message-ID: <20240627001403.279340-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627001403.279340-1-marex@denx.de>
References: <20240627001403.279340-1-marex@denx.de>
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

The production DH i.MX8MP DHCOM SoM rev.200 uses updated PHY MDIO addresses
for the Fast ethernet PHYs. Update the base SoM DT and SoM rev.100 backward
compatibility DTO to cater for this change.

Since the MDIO address adjustment is now also in the rev.100 SoM DTO, not
only in the rev.100 PDK3 DTO, update Makefile accordingly as well, else the
DTC would complain about the DTO overriding the 'reg' property without also
updating the node unit-address, which is not doable without duplicating the
entire PHY node in the DTO, which leads to large amount of duplication with
no gain.

Fixes: 9de599ec3d59 ("arm64: dts: imx8mp: Update i.MX8MP DHCOM SoM DT to production rev.200")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/Makefile                            | 1 +
 arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts | 5 +++++
 arch/arm/dts/imx8mp-dhcom-som.dtsi               | 8 ++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 06c234afbeb..e49e9aa3e15 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1291,6 +1291,7 @@ targets += $(dtb-y)
 # Add any required device tree compiler flags here
 DTC_FLAGS += -a 0x8
 
+DTC_FLAGS_imx8mp-dhcom-som-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
 DTC_FLAGS_imx8mp-dhcom-pdk3-overlay-rev100 += -Wno-avoid_default_addr_size -Wno-reg_format
 
 PHONY += dtbs
diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
index 0e5d329b149..b2154d57e48 100644
--- a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
+++ b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
@@ -35,6 +35,7 @@
 &ethphy0f { /* SMSC LAN8740Ai */
 	pinctrl-0 = <&pinctrl_ethphy0 &pinctrl_ioexp>;
 	reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	reg = <0>;
 };
 
 &ethphy0g { /* Micrel KSZ9131RNXI */
@@ -42,6 +43,10 @@
 	reset-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
 };
 
+&ethphy1f { /* SMSC LAN8740Ai */
+	reg = <1>;
+};
+
 &i2c3 {
 	adc@48 {
 		compatible = "ti,tla2024";
diff --git a/arch/arm/dts/imx8mp-dhcom-som.dtsi b/arch/arm/dts/imx8mp-dhcom-som.dtsi
index b504d36818b..f2d99d05854 100644
--- a/arch/arm/dts/imx8mp-dhcom-som.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-som.dtsi
@@ -100,14 +100,14 @@
 		#size-cells = <0>;
 
 		/* Up to one of these two PHYs may be populated. */
-		ethphy0f: ethernet-phy@0 { /* SMSC LAN8740Ai */
+		ethphy0f: ethernet-phy@1 { /* SMSC LAN8740Ai */
 			compatible = "ethernet-phy-id0007.c110",
 				     "ethernet-phy-ieee802.3-c22";
 			interrupt-parent = <&gpio3>;
 			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
 			pinctrl-0 = <&pinctrl_ethphy0>;
 			pinctrl-names = "default";
-			reg = <0>;
+			reg = <1>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
 			reset-gpios = <&ioexp 4 GPIO_ACTIVE_LOW>;
@@ -146,14 +146,14 @@
 		#size-cells = <0>;
 
 		/* Up to one PHY may be populated. */
-		ethphy1f: ethernet-phy@1 { /* SMSC LAN8740Ai */
+		ethphy1f: ethernet-phy@2 { /* SMSC LAN8740Ai */
 			compatible = "ethernet-phy-id0007.c110",
 				     "ethernet-phy-ieee802.3-c22";
 			interrupt-parent = <&gpio4>;
 			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 			pinctrl-0 = <&pinctrl_ethphy1>;
 			pinctrl-names = "default";
-			reg = <1>;
+			reg = <2>;
 			reset-assert-us = <1000>;
 			reset-deassert-us = <1000>;
 			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-- 
2.43.0

