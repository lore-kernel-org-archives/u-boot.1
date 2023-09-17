Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2288CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6210086A9E;
	Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Jkxnf8EU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xh2KylIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D8E86B05; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA8F86B05
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVKH5ywZz9snG
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Fr8obSAnHE6U62Ff2+B8Xp7AmmHbPGVRVr8c6shRmw=;
 b=Jkxnf8EUi+8MSq2anzaDxWjfRDjMToQnOGwTel9V/JIbL9QRX60Go6KBL7IyJV9MDDtbro
 plhjXQ+gmtYXd2v2OZukFW0Fz/8EXlwLJdRXc3oU2I5bOxtCqzz2AHmqlRIAb6ApPxaLQN
 B+goxe6WTrhO7mzcUnUILxmBK/xfRuaoD8IPquneKh7jUbsC39hXH+RUy6bi+Jo34iAC2U
 3hJ1oNaHt6Lscw2vNcbjM+YXfRnLolN2h/lzae+tLLNfsv5cy+YJ2gW3Hd1QUZj8BuyMC6
 NgJYD3/UmCNt1OMVBhOX6VkA9TJtJ++nsm6aKYOrl7DqYBpE5Zm6VPCgzTf8jA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Fr8obSAnHE6U62Ff2+B8Xp7AmmHbPGVRVr8c6shRmw=;
 b=xh2KylIAP2t4q9tuJmaGkt2dcGi2HNbSnfdMMlMZITlSkylaIJONPH/Lk/6t/sFcwZU83W
 KcZ51ZsECZikIIh4pm1M/qvUK2uis/2AKalGqPFxl1nlyVvwriRCMj5SFIjL3dw2obEmt6
 ZGnuokzB6IP1uz/9pPfAHQKzmluAWB51OGb2cv82vn4Fcy2vhMmIQ6cqGVjbWZ1bH4Ff20
 uwOVTa8XYDkXj12OX2msi6mV6gJPZs8HCGwaBHdzG43W1A/wnLyNPecmS6Wajh609KHmwl
 v4PUAudsJGo/NyOFnBXaurxk/sG/YT72U/IHtDliJkSxM0XHmvKtFg8v6rz5iw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/19] ARM: dts: renesas: Synchronize R-Car R8A77960 M3-W and
 R8A77961 M3-W+ DTs with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:05 +0200
Message-Id: <20230917141319.379939-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 834b12561ac91effd62
X-MBO-RS-META: pqfuskkiex1hmcpztndzpbeahugjmhic
X-Rspamd-Queue-Id: 4RpVKH5ywZz9snG
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

Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77960.dtsi | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/r8a77960.dtsi b/arch/arm/dts/r8a77960.dtsi
index 1424d4ad941..17062ec506b 100644
--- a/arch/arm/dts/r8a77960.dtsi
+++ b/arch/arm/dts/r8a77960.dtsi
@@ -70,13 +70,11 @@
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <300000>;
-			turbo-mode;
 		};
 		opp-1700000000 {
 			opp-hz = /bits/ 64 <1700000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <300000>;
-			turbo-mode;
 		};
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
@@ -1870,7 +1868,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -2567,8 +2565,8 @@
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
@@ -2579,6 +2577,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
@@ -2594,8 +2594,8 @@
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
@@ -2606,6 +2606,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
 			resets = <&cpg 318>;
+			iommu-map = <0 &ipmmu_hc 1 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

