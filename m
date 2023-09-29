Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A8CE71D38
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4165D86EE1;
	Fri, 29 Sep 2023 15:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Au+hnima";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA10286EAA; Fri, 29 Sep 2023 15:47:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9580186EF1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 94A05CE2398;
 Fri, 29 Sep 2023 13:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB3C433CA;
 Fri, 29 Sep 2023 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695995220;
 bh=x+UcJrS7jDvCCTz7n4bL/O3Hzn+BlWmzHSk9UF+7nQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Au+hnimaShEj9E7A6giJklJF06tgYn48/RnaAgFhOiL0FodxfdohBHofX57MLDxkD
 KRScjJn2wUBC68c2oGYHcAmu4hIosYEil3yCag/ZJCzmDQxPBIE60QKj0/5CwmQgtG
 kBjbFFsnU8vG+oQULj1AqaYiD9MtGlltqj89NbVuZyoadqfg+6Vap/EVLLfhddbNg8
 agnI6QUrkULPCHYSAV9InoPsroS6wFIAfP/oZ7MZy22bpxhcYa66oWnCFljTT8UJUw
 tUFj1BgDk9rYOaV/65/bh0khqtbbeAG17+BgFuPCWMqOzTKSNjxUENRGOUvpHsgN2I
 59e/6BXjENI6g==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/6] arm: dts: k3-am64-evm: Mark dependent nodes for
 pre-relocation phase
Date: Fri, 29 Sep 2023 16:46:42 +0300
Message-Id: <20230929134646.214781-3-rogerq@kernel.org>
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
USB and MMC nodes need pinmux.

Mark them as 'bootph-all' so they are available in all
pre-relocation phases.

Fixes below dts warning:

<stdout>: Warning (dmas_property): /bus@f4000/ethernet@8000000:dmas: Could not get phandle node for (cell 0)

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 48 +++++++++++++++++++++++++++
 arch/arm/dts/k3-am642-r5-evm.dts      |  8 +++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index d06955dfbc..953bbe9aaf 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -51,6 +51,10 @@
 	bootph-all;
 };
 
+&main_usb0_pins_default {
+	bootph-all;
+};
+
 &usb0 {
 	dr_mode="peripheral";
 	bootph-all;
@@ -100,12 +104,56 @@
 	bootph-all;
 };
 
+&main_mmc1_pins_default {
+	bootph-all;
+};
+
 &sdhci1 {
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
+
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&cpsw_port1 {
+	bootph-all;
 };
 
 &cpsw_port2 {
diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
index 696735d8e2..64b3c3af63 100644
--- a/arch/arm/dts/k3-am642-r5-evm.dts
+++ b/arch/arm/dts/k3-am642-r5-evm.dts
@@ -74,6 +74,14 @@
 	ti,secure-host;
 };
 
+&vtt_supply {
+	bootph-pre-ram;
+};
+
+&memorycontroller {
+	vtt-supply = <&vtt_supply>;
+};
+
 &sdhci0 {
 	clocks = <&clk_200mhz>;
 	clock-names = "clk_xin";
-- 
2.34.1

