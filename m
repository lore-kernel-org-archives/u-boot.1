Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81A1CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C550D84BF6;
	Fri,  8 May 2026 01:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M0P1oLhV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TU2mjreM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF1C84BF6; Fri,  8 May 2026 01:24:54 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1208484B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBSyW342Rz9ttD;
 Fri,  8 May 2026 01:24:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQBQ/6J0tH4irfYfEHjOmez6zxhNei+y6KCuAfkOMJs=;
 b=M0P1oLhV4z6i0Njgx+CQpmPyCeEHmCj4AhKR6NOx2kOWitD6le7+wM7EGFaBeueNTKU+9p
 1DjjleVo/XIANmmDuCYqjJAiOQHBHaRuXlqeWm19dZS9Zmn9jb6+nDKnrZogVNVRcQwq+D
 PKazdttDw8aOnGMHbKO49YRzBmAAebIimhtunpclWrFmr5I7WbYvhpbaUC28zM7SVoPuOz
 mVcws9yFz5YMpCcd+W64I5WDRAR+WUkxlBBoGBElvABHz5J7oRp04xRougSstkIoY07r65
 Ipb9VceKiM4fqvx3aSTJZLCqmGhySRaH97fzi2MD0+VzhOhDGhGirdBkTRgzxA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TU2mjreM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQBQ/6J0tH4irfYfEHjOmez6zxhNei+y6KCuAfkOMJs=;
 b=TU2mjreMQpUBd/Kc75wWILsmssILNT34CGzBgIu7A38eXizNk9P6RENGm2AGMGGqKDverg
 1VimPvbeh+4hayxdH3tFPzkoqVm55AFNVvcMXIK+u5mPjDT46pie/O05SbVHvcdKLLaYbP
 jun7mHSHNiCvbo3tCsNRund9DC81BbGqIcBYMTcqh/CC1Nf16zsYlsZRhKcQGN8Kt8Nz7x
 wgi3RcHnTxtXgAX5s3F5+46UOjNAXCBm3xFXRLTnK9fPExUKTzca5axzpl2ptmap7vBi/K
 CbT+1j7Ol9kK9Wh5FXGc7GABM2oeQE1L2GHE44GFG7DxxuDmovmzuSl9rTHynQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] arm64: dts: renesas: Switch to remap drivers on R-Car
 Gen5 R8A78000 X5H
Date: Fri,  8 May 2026 01:23:32 +0200
Message-ID: <20260507232424.304154-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
References: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tjstajnzqdx8q3kyxok5op8ts6jc7mk9
X-MBO-RS-ID: 3a12d9131b92d5fc6ca
X-Rspamd-Queue-Id: 4gBSyW342Rz9ttD
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

Point every direct user of SCMI clock protocol at CPG node instead
of SCMI clock protocol node. Point every direct user of SCMI reset
and power domain protocol at a matching newly introduced MDLC node
instead of the SCMI reset and power domain protocol nodes.

This allows the CPG and MDLC remap drivers bound to CPG node and MDLC
nodes to remap between DT clock, reset and power domain IDs and SCMI
clock, reset and power domain IDs. This makes U-Boot on R-Car X5H
compatible with multiple SCP firmware versions. Currently supported
versions of SCP firmware are 4.28, 4.31 and 4.32.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Clément Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi |  12 ++
 arch/arm/dts/r8a78000-u-boot.dtsi          | 136 ++++++++++++---------
 2 files changed, 87 insertions(+), 61 deletions(-)

diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index eebad1281fc..299716f96a4 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -34,6 +34,10 @@
 	};
 };
 
+&cpg {
+	firmware = <&scmi>;
+};
+
 &eth_pcs {
 	phys = <&mp_phy 2 1>;
 	status = "okay";
@@ -64,6 +68,14 @@
 	status = "okay";
 };
 
+&mdlc_hscn {
+	firmware = <&scmi>;
+};
+
+&mdlc_pere {
+	firmware = <&scmi>;
+};
+
 &mmc0 {
 	pinctrl-0 = <&mmc0_pins>;
 	pinctrl-1 = <&mmc0_pins>;
diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
index ee8aa9ee199..df21a9e03a2 100644
--- a/arch/arm/dts/r8a78000-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -11,7 +11,7 @@
 
 / {
 	firmware {
-		scmi {
+		scmi: scmi {
 			compatible = "arm,scmi";
 			arm,poll-transport;
 			mbox-names = "tx", "rx";
@@ -20,17 +20,17 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			scmi_devpd: protocol@11 {
+			protocol@11 {
 				reg = <0x11>;
 				#power-domain-cells = <1>;
 			};
 
-			scmi_clk: protocol@14 {
+			protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
 			};
 
-			scmi_reset: protocol@16 {
+			protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
 			};
@@ -64,8 +64,8 @@
 	clk_stub_mmc: clk-stub-mmc {
 		compatible = "renesas,compound-clock";
 		#clock-cells = <0>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_SDHI0>,
-			 <&scmi_clk SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_SDHI0>,
+			 <&cpg SCP_CLOCK_ID_CLK_S0D6_PERE_MAIN>;
 		clock-names = "mdlc", "per";
 	};
 };
@@ -111,14 +111,22 @@
 		status = "disabled";
 	};
 
+	mdlc_pere: system-controller@c08f0000 {
+		compatible = "renesas,r8a78000-mdlc";
+		reg = <0 0xc08f0000 0 0x1000>;
+		#power-domain-cells = <1>;
+		#reset-cells = <1>;
+		bootph-all;
+	};
+
 	ufs0: ufs@c0a80000 {
 		compatible = "renesas,r8a78000-ufs";
 		reg = <0 0xc0a80000 0 0x1100>, <0 0xc0a00000 0 0x40000>;
 		reg-names = "hcr", "phy";
 		interrupts = <GIC_SPI 4284 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS0>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS0>;
-		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS0>;
+		power-domains = <&mdlc_pere X5H_POWER_DOMAIN_ID_UFS0>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_UFS0>;
+		resets = <&mdlc_pere SCP_RESET_DOMAIN_ID_UFS0>;
 		freq-table-hz = <38400000 38400000>;
 		status = "disabled";
 	};
@@ -128,9 +136,9 @@
 		reg = <0 0xc0a90000 0 0x1100>, <0 0xc0a40000 0 0x40000>;
 		reg-names = "hcr", "phy";
 		interrupts = <GIC_SPI 4285 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS1>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS1>;
-		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS1>;
+		power-domains = <&mdlc_pere X5H_POWER_DOMAIN_ID_UFS1>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_UFS1>;
+		resets = <&mdlc_pere SCP_RESET_DOMAIN_ID_UFS1>;
 		freq-table-hz = <38400000 38400000>;
 		status = "disabled";
 	};
@@ -153,14 +161,12 @@
 		};
 	};
 
-	cpg: clock-controller@c64f0000 {
-		compatible = "renesas,r8a78000-cpg-mssr";
-		reg = <0 0xc64f0000 0 0x4000>;
+	cpg: clock-controller@c1320000 {
+		compatible = "renesas,r8a78000-cpg";
+		reg = <0 0xc1320000 0 0x10000>;
 		clocks = <&extal_clk>, <&extalr_clk>;
 		clock-names = "extal", "extalr";
-		#clock-cells = <2>;
-		#power-domain-cells = <0>;
-		#reset-cells = <1>;
+		#clock-cells = <1>;
 		bootph-all;
 	};
 
@@ -301,22 +307,22 @@
 		compatible = "renesas,r8a78000-multi-protocol-phy";
 		reg = <0 0xc9a00000 0 0x100000>;
 		#phy-cells = <2>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY01>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY11>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY21>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY31>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY02>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_MPPHY01>,
+			 <&cpg SCP_CLOCK_ID_MDLC_MPPHY11>,
+			 <&cpg SCP_CLOCK_ID_MDLC_MPPHY21>,
+			 <&cpg SCP_CLOCK_ID_MDLC_MPPHY31>,
+			 <&cpg SCP_CLOCK_ID_MDLC_MPPHY02>;
 		clock-names = "mpphy01", "mpphy11", "mpphy21",
 			      "mpphy31", "mpphy02";
-		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_MPP0>,
-				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP1>,
-				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP2>,
-				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP3>;
-		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY01>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY11>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY21>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY31>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY02>;
+		power-domains = <&mdlc_hscn X5H_POWER_DOMAIN_ID_MPP0>,
+				<&mdlc_hscn X5H_POWER_DOMAIN_ID_MPP1>,
+				<&mdlc_hscn X5H_POWER_DOMAIN_ID_MPP2>,
+				<&mdlc_hscn X5H_POWER_DOMAIN_ID_MPP3>;
+		resets = <&mdlc_hscn SCP_RESET_DOMAIN_ID_MPPHY01>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_MPPHY11>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_MPPHY21>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_MPPHY31>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_MPPHY02>;
 		status = "disabled";
 	};
 
@@ -325,19 +331,19 @@
 				"renesas,etherswitch";
 		reg = <0 0xc9bc0000 0 0x40000>, <0 0xc9b80000 0 0x240000>;
 		reg-names = "base", "secure_base";
-		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_RSW>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSN>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3AES>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES0>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES1>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES2>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES3>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES4>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES5>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES6>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES7>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3MFWD>;
+		power-domains = <&mdlc_hscn X5H_POWER_DOMAIN_ID_RSW>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_RSW3>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSN>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3AES>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES0>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES1>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES2>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES3>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES4>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES5>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES6>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3TSNTES7>,
+			 <&cpg SCP_CLOCK_ID_MDLC_RSW3MFWD>;
 		clock-names = "rsw3", "rsw3tsn", "rsw3aes",
 			      "rsw3tsntes0", "rsw3tsntes1", "rsw3tsntes2",
 			      "rsw3tsntes3", "rsw3tsntes4", "rsw3tsntes5",
@@ -349,26 +355,34 @@
 		compatible = "renesas,r8a78000-ether-pcs";
 		reg = <0 0xc9c50000 0 0x4000>;
 		#phy-cells = <1>;
-		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS0>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS1>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS2>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS3>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS4>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS5>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS6>,
-			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS7>;
+		clocks = <&cpg SCP_CLOCK_ID_MDLC_XPCS0>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS1>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS2>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS3>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS4>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS5>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS6>,
+			 <&cpg SCP_CLOCK_ID_MDLC_XPCS7>;
 		clock-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
 			      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
-		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS0>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS1>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS2>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS3>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS4>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS5>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS6>,
-			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS7>;
+		resets = <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS0>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS1>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS2>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS3>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS4>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS5>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS6>,
+			 <&mdlc_hscn SCP_RESET_DOMAIN_ID_XPCS7>;
 		reset-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
 			      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
 		status = "disabled";
 	};
+
+	mdlc_hscn: system-controller@c9c90000 {
+		compatible = "renesas,r8a78000-mdlc";
+		reg = <0 0xc9c90000 0 0x1000>;
+		#power-domain-cells = <1>;
+		#reset-cells = <1>;
+		bootph-all;
+	};
 };
-- 
2.53.0

