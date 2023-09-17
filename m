Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87EBCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB2686B1D;
	Sun, 17 Sep 2023 16:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V7czG/A1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nr/TG3Wg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4323286AFE; Sun, 17 Sep 2023 16:13:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7374F86AA7
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RpVKJ1JpSz9sWf
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cDQOLuFkCRLt5x2DYhVf0pOqCYOxLTyHy0uCxh3BKw=;
 b=V7czG/A1LUTaXS74X/Qm6/T6oCpy3XxShuHiTPnatWefGhl9xzSedTG3L8qMRCSypYq3+2
 8iz78cwcatjYqz64cM8QNdGlu8ibMd5NIV1JpS9EYv3nxhdsUNCTpTDDuP+2bTz07JFkEv
 HtsBBH3FoJi6wAHHWxdXf/5GTwXNQYJQK0Ggkfklj5uG14r7jTWx0T+VUZ9cS/bWKZ+8qO
 2whgFtE3mQtReZ0oOUDrWMhtAfpW80CPABkV2N7KuVkM02rM2tCJ1ZiWyklRvpUG7cmwK8
 gTKhHZUk6ahVASc5HyqdSEPqGFOkSDPBAI1LiX0aEDpAZMn0A6yA4yhlnQIGYw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cDQOLuFkCRLt5x2DYhVf0pOqCYOxLTyHy0uCxh3BKw=;
 b=nr/TG3Wgdu9tq1TYRu6zECdB/bOf47mkGe1XhgPo17eomtGXzfH6xCrttw6iUVBxB0sTgc
 9e20xcVmatlQHyjXs1jt56bIJqWBNwC5jZ2p+aSOVwbmaGY4DRRrM6DBRby5j2hQYNp9hx
 cHcWdkjJUBPnelIw/rsajxF3f71M9SpZfKYsrIQMq0iOXkFr0mGDA46OpDJ2YW+DoGSRGV
 zZggwyL68TfQCl6b83i/jC04+RJh1mtrVNfZ2JpQBXAKCAeqKNjMG5OHJKVEZb+04mXuXM
 Ko5LzlwV5d2hbc2nt+ahQIcFcQzTcY0ZlTpusNKBayQjoNdbESng0YMbsXBzFw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/19] ARM: dts: renesas: Synchronize R-Car R8A77965 M3-N DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:06 +0200
Message-Id: <20230917141319.379939-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: amh5ko4kh97khroxhsq6epaeudb5tyub
X-MBO-RS-ID: 713c39487c3c7dc0458
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

Synchronize R-Car R8A77965 M3-N DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77965.dtsi | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/r8a77965.dtsi b/arch/arm/dts/r8a77965.dtsi
index 997f29521f6..c7582003849 100644
--- a/arch/arm/dts/r8a77965.dtsi
+++ b/arch/arm/dts/r8a77965.dtsi
@@ -75,13 +75,11 @@
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
@@ -1733,7 +1731,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;	<&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;	<&rcar_sound N>;
@@ -2425,8 +2423,8 @@
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
@@ -2437,6 +2435,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 319>;
+			iommu-map = <0 &ipmmu_hc 0 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
@@ -2452,8 +2452,8 @@
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
@@ -2464,6 +2464,8 @@
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 318>;
+			iommu-map = <0 &ipmmu_hc 1 1>;
+			iommu-map-mask = <0>;
 			status = "disabled";
 		};
 
-- 
2.40.1

