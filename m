Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CADC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE266876AE;
	Tue, 19 Dec 2023 12:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uSfJpVZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878F9871C3; Tue, 19 Dec 2023 11:13:09 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE8EC86F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJACulA095443;
 Tue, 19 Dec 2023 04:12:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980776;
 bh=jtGlK/Vsy/8cxC9YiYBZ6hoNOwpqAsqtsQUc/3NWdJk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uSfJpVZ5Zp6DirtuTeZ+MOiZdrGbCyAkqBZsSIm9+nb9ympA8Wh//FoXukWcvsLjd
 mo/8ANSXaysGHYfeIvf6l3MGiQ38nQBELGDMDHq89k3KzyeYPI8rzX092N3DT/k6A6
 OHGqMhd/Frv71daJRqCC/eTj3UmOfUU5qTXkiErc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJACuqC031367
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:12:56 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:12:56 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:12:56 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJACuWC089149;
 Tue, 19 Dec 2023 04:12:56 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJACtbZ010341;
 Tue, 19 Dec 2023 04:12:55 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 07/16] arm: dts: k3-am65: Add additional regs for DMA
 components
Date: Tue, 19 Dec 2023 15:42:06 +0530
Message-ID: <20231219101225.3443978-14-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

Add additional reg properties for UDMA and RingAcc nodes which are
mostly used by bootloader components before Device Manager firmware
services are available, in order to setup DMA transfers.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/k3-am65-main.dtsi | 8 ++++++--
 arch/arm/dts/k3-am65-mcu.dtsi  | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am65-main.dtsi b/arch/arm/dts/k3-am65-main.dtsi
index ba4e5d3e1e..691c9978e6 100644
--- a/arch/arm/dts/k3-am65-main.dtsi
+++ b/arch/arm/dts/k3-am65-main.dtsi
@@ -616,8 +616,12 @@
 			compatible = "ti,am654-navss-main-udmap";
 			reg =	<0x0 0x31150000 0x0 0x100>,
 				<0x0 0x34000000 0x0 0x100000>,
-				<0x0 0x35000000 0x0 0x100000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+				<0x0 0x35000000 0x0 0x100000>,
+				<0x0 0x30b00000 0x0 0x20000>,
+				<0x0 0x30c00000 0x0 0x8000>,
+				<0x0 0x30d00000 0x0 0x4000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
 
diff --git a/arch/arm/dts/k3-am65-mcu.dtsi b/arch/arm/dts/k3-am65-mcu.dtsi
index c93ff1520a..d7111aa8b2 100644
--- a/arch/arm/dts/k3-am65-mcu.dtsi
+++ b/arch/arm/dts/k3-am65-mcu.dtsi
@@ -142,8 +142,12 @@
 			compatible = "ti,am654-navss-mcu-udmap";
 			reg =	<0x0 0x285c0000 0x0 0x100>,
 				<0x0 0x2a800000 0x0 0x40000>,
-				<0x0 0x2aa00000 0x0 0x40000>;
-			reg-names = "gcfg", "rchanrt", "tchanrt";
+				<0x0 0x2aa00000 0x0 0x40000>,
+				<0x0 0x284a0000 0x0 0x4000>,
+				<0x0 0x284c0000 0x0 0x4000>,
+				<0x0 0x28400000 0x0 0x2000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt",
+				    "tchan", "rchan", "rflow";
 			msi-parent = <&inta_main_udmass>;
 			#dma-cells = <1>;
 
-- 
2.34.1

