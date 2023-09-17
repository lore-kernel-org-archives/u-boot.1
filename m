Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB95CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57FD86B6B;
	Sun, 17 Sep 2023 16:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DywwcQuA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dsgep5Kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E7286B28; Sun, 17 Sep 2023 16:14:05 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EEC286AFE
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVKP2WSZz9snG
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFFGzqiY9UiGaG2QyepIfwB604TWBJxCzwH/SYOTsoI=;
 b=DywwcQuAUcPWBvnBsbUbM1Z1S+57w39sGnd4H5CAn9+jndq85ZMReR9QzCRoGlLqpugZLw
 KFDi6Jr+ALpqZydcoYVEMTdZKTsvw3CbuI3kzayxCr7UYmw4U8jcTuCsz/H/wlprlqG4BG
 /Gbdm6xNgtSpurmn6vmt07jHidFPduTGQW5GAymr5JJeKRaxWtuj+W1nyPEpXTuWm/bEAm
 XwoR7lTO2jHpOuiMvwvZwcdDZ+Cg5B+DMr3YIvdM+pa/6IM9kDTmiuhBz0YXfTY2Oj9mrm
 SQtsoyXFkyYlPsCtuof0uYru9Ae+XtVpRmSq/m2Q2n9TWJAvVnRG4GJ6DpXXag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFFGzqiY9UiGaG2QyepIfwB604TWBJxCzwH/SYOTsoI=;
 b=Dsgep5Kw02wkEcsQPxWKBLFisJte/Od4gc/PkX7IElWKFJgnS3meE4RE1qa+ku0CEzvaPI
 snnv11Fx/PUpy+WajzFcMcObz5QKEexgBgn8Yh1to/EZsmdt2wT/lUUB+IppJUKlWJEDHJ
 ARvl5N3FNb4v4nyxkqptloc2Pssgj3JhzMmA2Ccwa/9UJbF8AioWlbxHbqwdCL2u45scxx
 jGEOLVIJkH3rPzSi9qQoQvPwXosilw2LW4g3WY7WR3/8oVm3pJcfn2g61mvis49cxSX9hA
 zumkZkeb6bORISdWnkRJVdmtsJ6RsuMq8g57PEv1FmsWnpep6CKpDbYckUK2JQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/19] ARM: dts: renesas: Synchronize RZ R8A774E1 RZ/G2H DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:18 +0200
Message-Id: <20230917141319.379939-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1fbc9af12f49cb27d5f
X-MBO-RS-META: zbrq3h1fzn95emmhoibypweyy1b8g9zk
X-Rspamd-Queue-Id: 4RpVKP2WSZz9snG
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

Synchronize RZ R8A774E1 RZ/G2H DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts | 29 ++++++----------------
 arch/arm/dts/r8a774e1.dtsi                 | 14 +++++++----
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts b/arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
index 3e9ced3b2d3..146f78cb6f1 100644
--- a/arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
+++ b/arch/arm/dts/r8a774e1-beacon-rzg2h-kit.dts
@@ -14,6 +14,14 @@
 	compatible = "beacon,beacon-rzg2h", "renesas,r8a774e1";
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &iic_pmic;
 		serial0 = &scif2;
 		serial1 = &hscif0;
 		serial2 = &hscif1;
@@ -51,24 +59,3 @@
 	clock-names = "du.0", "du.1", "du.3",
 		"dclkin.0", "dclkin.1", "dclkin.3";
 };
-
-/* Reference versaclock instead of audio_clk_a */
-&rcar_sound {
-	clocks = <&cpg CPG_MOD 1005>,
-		 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-		 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-		 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-		 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-		 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-		 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-		 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-		 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-		 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-		 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1020>, <&cpg CPG_MOD 1021>,
-		 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-		 <&versaclock6_bb 4>, <&audio_clk_b>,
-		 <&audio_clk_c>,
-		 <&cpg CPG_CORE R8A774E1_CLK_S0D4>;
-};
diff --git a/arch/arm/dts/r8a774e1.dtsi b/arch/arm/dts/r8a774e1.dtsi
index c5a0e7866b2..2acf4067ab2 100644
--- a/arch/arm/dts/r8a774e1.dtsi
+++ b/arch/arm/dts/r8a774e1.dtsi
@@ -1774,7 +1774,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -2471,8 +2471,8 @@
 				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
 				 <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
 				 <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
@@ -2483,6 +2483,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
@@ -2498,8 +2500,8 @@
 				 <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
 				 <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
 				 <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
@@ -2510,6 +2512,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
 			resets = <&cpg 318>;
+			iommu-map = <0 &ipmmu_hc 1 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

