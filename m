Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB2AE71D38
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87F386EFA;
	Fri, 29 Sep 2023 15:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AGDEwlow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F05E86F02; Fri, 29 Sep 2023 15:47:17 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F12586EFA
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C358DB81E9D;
 Fri, 29 Sep 2023 13:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CDC433C9;
 Fri, 29 Sep 2023 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995234;
 bh=LeVOgDGH4KSM7JfgS5+fYlJSi6TsrOQVGXaspM8nd4k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AGDEwlowz5WX4Hiv0HXI6YZGN1kBTnqN4/RGUpYTFdM2m7jBf4cowYOdTYtfixqkP
 rlov8cfYbIFrlYMFa5CEHgJsXtuyCF0WSw2mrqs0mlHV7zO+xOJWjhH3XdAQxviNHC
 tM9mPFMo+CYYQZ5RZbWSsGEPLfUysSnkV4bjVUAyRTvHSpoMAbFuDQk78/rCWMQ9UV
 ml24qP058xJ9iQ7xFMUs/k2407SWK2zgsHE4JOjavMRyEDUUdVTjdYndnjTai5al0W
 Ua9NzYRogfOyNKfQO0v5kawYJJqCteS6Xrr8rmjcR7mX9RzIugKovk8o+dlIYE+psN
 k4HKdey0n3P2Q==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 6/6] arm: dts: k3-am625-sk: Mark dependent nodes for
 pre-relocation phase
Date: Fri, 29 Sep 2023 16:46:46 +0300
Message-Id: <20230929134646.214781-7-rogerq@kernel.org>
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
main_conf is required for phy_gmii_sel.
Mark them as 'bootph-all' so they are available in all
pre-relocation phases.

Fixes the below dts warnings:

<stdout>: Warning (reg_format): /bus@f0000/syscon@100000/phy@4044:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
<stdout>: Warning (reg_format): /bus@f0000/ethernet@8000000/ethernet-ports/port@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
<stdout>: Warning (unit_address_vs_reg): /bus@f0000/syscon@100000: node has a unit name, but no reg or ranges property
<stdout>: Warning (pci_device_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
<stdout>: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
<stdout>: Warning (avoid_default_addr_size): /bus@f0000/syscon@100000/phy@4044: Relying on default #address-cells value
<stdout>: Warning (avoid_default_addr_size): /bus@f0000/syscon@100000/phy@4044: Relying on default #size-cells value
<stdout>: Warning (avoid_default_addr_size): /bus@f0000/ethernet@8000000/ethernet-ports/port@1: Relying on default #address-cells value
<stdout>: Warning (avoid_default_addr_size): /bus@f0000/ethernet@8000000/ethernet-ports/port@1: Relying on default #size-cells value
<stdout>: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
<stdout>: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 39 ++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index c658506256..b78d34b459 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -21,6 +21,10 @@
 	};
 };
 
+&main_conf {
+	bootph-all;
+};
+
 &cbass_main {
 	bootph-all;
 };
@@ -118,8 +122,43 @@
 	};
 };
 
+&inta_main_dmss {
+	bootph-all;
+};
+
+&main_pktdma {
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
+&main_rgmii1_pins_default {
+	bootph-all;
+};
+
+&main_rgmii2_pins_default {
+	bootph-all;
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &cpsw3g {
 	bootph-all;
+	ethernet-ports {
+		bootph-all;
+	};
 };
 
 &cpsw_port1 {
-- 
2.34.1

