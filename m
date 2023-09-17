Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B4CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A73286B29;
	Sun, 17 Sep 2023 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DKlGBa/M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NONAI1WC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E92786B52; Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005CD86AA7
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVKL5NrPz9sQ8
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH6jfD7yBYXXCqNMRVc4/ZL6H6i0mB/FI+7znput7R0=;
 b=DKlGBa/MzPS9eYLL7UQBvg7GUZ39uXL5l8Sjmfi9sfB1vBD/A+6lNMVcsaKnzT23gADBwy
 WbgSkkZuSaIq9cTJW9pmNuRtXXyF6wbJSJos2HA0TP/0WEuMPm6jZoMjmLDjZLgxFfKten
 GB6wllkaWEm3f2aehzx6Jp0UTsAhNJIqlt6M8wTFG50OyrBuUlVWG4kkbsys9JNsT5z7kA
 AuD4cS/O+mpUaLFKFEhYSWj0j60wgarEqM+Q9r/eaq8wYXdnC0yBw+oRyZv1slIy0g8zM7
 CNI0tYrfXV84I5eWZ9a30d4K3jVKBvi9eGlx9cRgR84F9Eo6vaP5X7qu+zj2zw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH6jfD7yBYXXCqNMRVc4/ZL6H6i0mB/FI+7znput7R0=;
 b=NONAI1WCTdc08gBxsYtmnLj0n5cRmYSpwzglYytO3ssjXaYZGM0CCz04gi1uT1d3buCPCv
 RWl4D6UYT5Set3L+4EF0orIWjJNbGRX56QxzZfMdS+X9LaTDJ8P5l0mAYU6Z4uVIxFiARF
 GJhioDfzOTaSyc+gctZvcA7ed+1ze3DgmlqfJzdzbtunS7QaDD7GJYHRR8Fl5jbrlF0gkG
 zAeRBkRWPn2og8Rwx6MVjXBxTYN1fw6HfWO5tzZxyfjGzNDh+gxfc5ZampYYfEB7H/tl59
 9STRylUCG63ysaZzO/EIl/2zEWDTtVs5bgqqeB5S5sUYf7G77oeFB7u8eHOvNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/19] ARM: dts: renesas: Synchronize R-Car R8A779F0 S4 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:12 +0200
Message-Id: <20230917141319.379939-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1a8cfb723b48dd2122b
X-MBO-RS-META: 6yk7qx47fjk373nkzb8cmybudd5b1zzm
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

Synchronize R-Car R8A779F0 S4 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a779f0.dtsi | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/dts/r8a779f0.dtsi b/arch/arm/dts/r8a779f0.dtsi
index f20b612b2b9..1d5426e6293 100644
--- a/arch/arm/dts/r8a779f0.dtsi
+++ b/arch/arm/dts/r8a779f0.dtsi
@@ -1059,7 +1059,7 @@
 			compatible = "renesas,ipmmu-r8a779f0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xee480000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -1068,7 +1068,7 @@
 			compatible = "renesas,ipmmu-r8a779f0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xee4c0000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 19>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -1077,7 +1077,7 @@
 			compatible = "renesas,ipmmu-r8a779f0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeed00000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -1086,7 +1086,7 @@
 			compatible = "renesas,ipmmu-r8a779f0",
 				     "renesas,rcar-gen4-ipmmu-vmsa";
 			reg = <0 0xeed40000 0 0x20000>;
-			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			renesas,ipmmu-main = <&ipmmu_mm>;
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
@@ -1108,8 +1108,7 @@
 			interrupt-controller;
 			reg = <0x0 0xf1000000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x110000>;
-			interrupts = <GIC_PPI 9
-				      (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		prr: chipid@fff00044 {
@@ -1119,7 +1118,7 @@
 	};
 
 	thermal-zones {
-		sensor_thermal1: sensor1-thermal {
+		sensor_thermal_rtcore: sensor1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 0>;
@@ -1133,7 +1132,7 @@
 			};
 		};
 
-		sensor_thermal2: sensor2-thermal {
+		sensor_thermal_apcore0: sensor2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 1>;
@@ -1147,7 +1146,7 @@
 			};
 		};
 
-		sensor_thermal3: sensor3-thermal {
+		sensor_thermal_apcore4: sensor3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 2>;
@@ -1164,10 +1163,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	ufs30_clk: ufs30-clk {
-- 
2.40.1

