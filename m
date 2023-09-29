Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F4EE71D37
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0801186EFC;
	Fri, 29 Sep 2023 15:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m63EsLIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1AE86EE4; Fri, 29 Sep 2023 15:47:10 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B95086EAA
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 290EFB81F4D;
 Fri, 29 Sep 2023 13:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5ACC433C9;
 Fri, 29 Sep 2023 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995227;
 bh=IANGHrRCDp4bAoRs2uNm+XvOeahqiM2ZvI/ZgLrmipU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m63EsLIav73SMertLEqWPl8MjnzS+utrukWZEVVbhOLw03q6oLERsqhSJGS6IOmnc
 QVFjt3cF9kcRdVc04uEmn2LCEl8DJg6glqhzXI9PXWuckrBx4BbxxhpPBX0fAs6Qhg
 1hdgx8uao38JQjvv6x7RVefTXyheiXuCVkVUFpqfZ87Umcb+hII7EvIQoawF4r11YA
 7xluoEb0HMMjnEhnOjY4IL6eqMMzC9IRythR5meov3I7mQpDlawYIoW7uDi9wgSH7k
 2OZg24/v3ZvVQX4X4tN785qNE6VOz2U6HUyjU3vgCq9hMZTIADPkTqvIkVENHyeNmP
 dBsAGfrHLx1iQ==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 4/6] arm: dts: k3-am642-sk: Mark dependent nodes for
 pre-relocation phase
Date: Fri, 29 Sep 2023 16:46:44 +0300
Message-Id: <20230929134646.214781-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929134646.214781-1-rogerq@kernel.org>
References: <20230929134646.214781-1-rogerq@kernel.org>
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

CPSW node needs PHY, MDIO, pinmux, DMA and INTC nodes.
Mark them as 'bootph-all' so they are available in all
pre-relocation phases.

Fixes below dts warnings:

<stdout>: Warning (reg_format): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
<stdout>: Warning (unit_address_vs_reg): /bus@f4000/ethernet@8000000/mdio@f00: node has a unit name, but no reg or ranges property
<stdout>: Warning (pci_device_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
<stdout>: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (avoid_default_addr_size): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1: Relying on default #address-cells value
<stdout>: Warning (avoid_default_addr_size): /bus@f4000/ethernet@8000000/mdio@f00/ethernet-phy@1: Relying on default #size-cells value
<stdout>: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
<stdout>: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
<stdout>: Warning (msi_parent_property): /bus@f4000/bus@48000000/dma-controller@485c0100:msi-parent: Could not get phandle node for (cell 0)
<stdout>: Warning (msi_parent_property): /bus@f4000/bus@48000000/dma-controller@485c0000:msi-parent: Could not get phandle node for (cell 0)
<stdout>: Warning (phys_property): /bus@f4000/ethernet@8000000/ethernet-ports/port@2:phys: Could not get phandle node for (cell 0)

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-sk-u-boot.dtsi | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/dts/k3-am642-sk-u-boot.dtsi b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
index 5599977f6c..40a53df0b0 100644
--- a/arch/arm/dts/k3-am642-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-sk-u-boot.dtsi
@@ -92,6 +92,38 @@
 	bootph-all;
 };
 
+&inta_main_dmss {
+	bootph-all;
+};
+
+&main_pktdma {
+	bootph-all;
+};
+
+&mdio1_pins_default {
+	bootph-all;
+};
+
+&cpsw3g_mdio {
+	bootph-all;
+};
+
+&cpsw3g_phy0 {
+	bootph-all;
+};
+
+&cpsw3g_phy1 {
+	bootph-all;
+};
+
+&rgmii1_pins_default {
+	bootph-all;
+};
+
+&rgmii2_pins_default {
+	bootph-all;
+};
+
 &cpsw3g {
 	bootph-all;
 
@@ -100,6 +132,10 @@
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &cpsw_port2 {
 	bootph-all;
 };
-- 
2.34.1

