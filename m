Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC24CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CA586B0C;
	Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d7+5rwUR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lGAWnto5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21AE86B09; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205ED86308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVKG0W5dz9sm6
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B7TheTMkuWmGrBErATnRVG5JrdXG30PiCg/5PRE5rO8=;
 b=d7+5rwURw0zMUDbnrN/V/VLfPPVSHabVv8HVj1pF8xpxsdzo+Jen5OBSSk/ubY30W9ieon
 W3t6o/b1Wo3nq5tsnAs0uxLVn3pV2BEWArAFYzCRLMdjIin8kt6AAbEYTjXW8rbldFAtWo
 Se0BCmp+K1IaWE+PIQ+dAdv1kmqU63NLy+jcXVUscwGhPVXm33BXBgTTXk8SqgHTslcmts
 v1TGZ6/DLcD5lQa+PMwQ1VZ6ICRm6a/dofEinyeZ0OAE0x7AJ44u9GAMHdhMdEmgkHW0iC
 2TUaIe+z5gQYd78q3ivKiT0sWY8H+EB4L4Y94xtzUSGmj2qH0eDVcXoWEh02aA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B7TheTMkuWmGrBErATnRVG5JrdXG30PiCg/5PRE5rO8=;
 b=lGAWnto5MwTyJi1UR8MxpUuIww2ncATppo7qTb0JO949bPyrq6eqM2O+hrDxVOSXpVP2CT
 6Fl60dF0knfYiQva3mBOc6GtVRWbQSNEhmg/ux4Ej/YeoPWMZQmq/7iJlOPvPDV7fnlT2T
 1Qc73BEOLjdUuSi8VNfKUs2d7ujO7fOL/W5gzL+qq8j+XvtsCvYFS775kn3fmNs2AujqV4
 9VxgUIarCQYPLGegHhurMJrpUJGAXMAh26xLOI4jriQFkVJmV/kbD3DKy+3j1LlrwvpFwO
 ZIIyZkI1RGCdW47xusqz7S4CILIDuBJKGyMg2/I5VgtPOGyaPBLhHpZtYDtkUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/19] ARM: dts: renesas: Synchronize R-Car R8A7790 H2 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:01 +0200
Message-Id: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d1d476be2abd5fa6a97
X-MBO-RS-META: 77jfgk1ggnzfe984qs61tou5c5oem6g9
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

Synchronize R-Car R8A7790 H2 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a7790.dtsi | 85 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/r8a7790.dtsi b/arch/arm/dts/r8a7790.dtsi
index db171e3c62f..46fb81f5062 100644
--- a/arch/arm/dts/r8a7790.dtsi
+++ b/arch/arm/dts/r8a7790.dtsi
@@ -376,6 +376,17 @@
 			reg = <0 0xe6060000 0 0x250>;
 		};
 
+		tpu: pwm@e60f0000 {
+			compatible = "renesas,tpu-r8a7790", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 304>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 304>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@e6150000 {
 			compatible = "renesas,r8a7790-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -1037,6 +1048,76 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm@e6e30000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm1: pwm@e6e31000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm2: pwm@e6e32000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm@e6e33000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm4: pwm@e6e34000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm5: pwm@e6e35000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm6: pwm@e6e36000 {
+			compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		can0: can@e6e80000 {
 			compatible = "renesas,can-r8a7790",
 				     "renesas,rcar-gen2-can";
@@ -1109,7 +1190,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
@@ -1252,7 +1333,7 @@
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi1: ssi-1 {
-					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x03>, <&audma1 0x04>,
 					       <&audma0 0x49>, <&audma1 0x4a>;
 					dma-names = "rx", "tx", "rxu", "txu";
-- 
2.40.1

