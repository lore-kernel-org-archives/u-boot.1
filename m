Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25BECD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3968086B4E;
	Sun, 17 Sep 2023 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pSr+6I5C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wUzxbwMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F7386B27; Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AE886B10
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVKK37k6z9sWf
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSZy+Iu/l42YAUM6Lc7Jrk7b43jbw4pIeMQZ2k6mkwA=;
 b=pSr+6I5CFm+3MKq4o3c7xfbS+QFcQWojXW/PmdpLi8Xf6BzWaKeJ8XQzITbhZMqkKvA2ml
 v/SCuQJagfvT2vC+UUJIpaKoE0lGjOlS8dqcPlSm2NUFzqgOuRHH6A07R56+ubXcPadPz6
 Um/+tiXhB1C3GGPheh6IZIgrRysFBNXtXg+4DyaHrACvhmgYgG9jyn0s9e7DGoYjTVgszX
 gKu+RiBGPzQrHHJGw6E2hdD6g8bVlHX/HTw0rsUq2/k1tslzAwqgstcFpgzVb3M3O5dQTr
 ul4eIuANB2FurQiOXEdJTfejSKA52GWzDaZKbYPzy+mFONmiYobFFRjyDXQuEg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSZy+Iu/l42YAUM6Lc7Jrk7b43jbw4pIeMQZ2k6mkwA=;
 b=wUzxbwMlepcxbskDaKVveUXO9IVcgaYkoqLcuY5fII6UmwUEeMx+zLbuYQRBr9a38uX5SW
 2QMtU2Lmw5BLbkBRmJBje1Ew5J8DgofeVsemkXlYxFzAqeOeCsQ4ws/4vlrFT2UB/hRtqU
 GobUvKfmS52pRwsnGJ2eloPmvjFmRcSSb13K2nvk+neBhuUXyqgO4yQDlP6KFGmP34hSKZ
 SMlLuacPtcrReWpiRqGF7rlgkT+GjoOGthDCb1VsNzZ3uO+5t/Az8Z4DhtrcsmlFMCZi5k
 P4MVwwSogDZ8rZKODUHZK2CCE09/hE9MIxd1aEhPhWxFBpeCbKJwPZrCuKNZOw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/19] ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:09 +0200
Message-Id: <20230917141319.379939-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b8805e6e8f96ffc66b0
X-MBO-RS-META: akhwu1ryzheioe8dc3w95reumdoyjiz6
X-Rspamd-Queue-Id: 4RpVKK37k6z9sWf
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

Synchronize R-Car R8A77990 E3 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77990.dtsi | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/r8a77990.dtsi b/arch/arm/dts/r8a77990.dtsi
index 3053b4b2149..1be0b99c15e 100644
--- a/arch/arm/dts/r8a77990.dtsi
+++ b/arch/arm/dts/r8a77990.dtsi
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
@@ -1469,7 +1466,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -1873,8 +1870,8 @@
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
@@ -1885,6 +1882,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

