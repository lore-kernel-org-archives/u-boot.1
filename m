Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09E6CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B44886B63;
	Sun, 17 Sep 2023 16:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="twvJk98m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uwo0u070";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7FE86308; Sun, 17 Sep 2023 16:14:03 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2598986B49
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
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVKN6Xphz9t4X
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uO1rNtIefoFKOHRob2ajcjpCWPKc+sXKbei4p1S8rbM=;
 b=twvJk98mLtVsmshtSTrssASeECztl/xveXbxCo/6qfJFVFMUpsM9JgABToqinavDeDO3gA
 9FbLx8oAYbLEY6X/vUYqTNyXIqXpP/YBG5C1DhlrwA7bgybtAflbmmwoV3SqhePhjsZ+E3
 N4tAuffTluN37BP71zxvn6a97LpQupzo/G+fFSbK1br7HlZt3Ilh0pl8waUt5kzk5ylGh9
 +vQp6PcTmn1LjCnDUO8E8L+7wQbkeCWGMps9vBs0DRqygozT/ieHZEZ83qSgrZbyDaaBrh
 f1QKHGNFIvKEJWdKMy5v+ZIzCwgxfLFC3u0X/kjcW3SWRghpGO6RnTeL0zePAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uO1rNtIefoFKOHRob2ajcjpCWPKc+sXKbei4p1S8rbM=;
 b=uwo0u070EJqWTyk9g1W5Q4HCdRZ0t1fVaEjZ2NjeSIUtt/1DS7BzbizDi2aCNoNZoksJtz
 HsWSZqzS29BuFwUvMh69g6MGEIv4xNBWjjI0/4AdDqoWPuA8KwZaSPvxIgMBh/F0VZP7dP
 ot0OUi7dNYM2tUlP/IgBF7IqI7gXWrsivDNSk+Dfa+cJRfLA0QF7Hk6wH/tcnBhKlhpOXp
 UCPLxLsZZUjHt5cZfqTiiYIBIRVVn99ZXwt1LUvjNiQBTg/boB4oI+eFatpgRrbhBHQvmc
 g2n5YN5mVgPbzxkizDqVyeJJhiQg3GnB0f6RLAjFu9x3p37A5NtCRYNG7Zltdg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/19] ARM: dts: renesas: Synchronize RZ R8A774C0 RZ/G2E DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:17 +0200
Message-Id: <20230917141319.379939-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8b25f033f480bfeef55
X-MBO-RS-META: a968fdk83p6sn6nxz9bzza49qpz6p9mc
X-Rspamd-Queue-Id: 4RpVKN6Xphz9t4X
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

Synchronize RZ R8A774C0 RZ/G2E DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a774c0.dtsi        | 11 +++++------
 arch/arm/dts/r8a774e1-u-boot.dtsi |  1 -
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/r8a774c0.dtsi b/arch/arm/dts/r8a774c0.dtsi
index 151e32ac036..ad2e87b039a 100644
--- a/arch/arm/dts/r8a774c0.dtsi
+++ b/arch/arm/dts/r8a774c0.dtsi
@@ -49,17 +49,14 @@
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
@@ -1317,7 +1314,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -1707,8 +1704,8 @@
 				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
 				 <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
 				 <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-			/* Map all possible DDR as inbound ranges */
-			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
+			/* Map all possible DDR/IOMMU as inbound ranges */
+			dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
@@ -1719,6 +1716,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/dts/r8a774e1-u-boot.dtsi b/arch/arm/dts/r8a774e1-u-boot.dtsi
index e86287098ba..45ef5b78240 100644
--- a/arch/arm/dts/r8a774e1-u-boot.dtsi
+++ b/arch/arm/dts/r8a774e1-u-boot.dtsi
@@ -30,7 +30,6 @@
 /delete-node/ &hdmi0;
 /delete-node/ &lvds0;
 /delete-node/ &rcar_sound;
-/delete-node/ &sdhi2;
 /delete-node/ &sound_card;
 /delete-node/ &vin0;
 /delete-node/ &vin1;
-- 
2.40.1

