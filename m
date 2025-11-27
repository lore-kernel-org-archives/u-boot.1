Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E252ED11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D66F843E4;
	Thu, 27 Nov 2025 15:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Hmo2fvpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EF08437E; Thu, 27 Nov 2025 15:04:51 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41B9843D6
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMk7AaPc4WV2KyKcPBkkgSjuoH3E7uJw3SqJPgO9KoTLv+olCQCvvFbBvf89JGr2nMbcbUPF30TnCoQT4DviiWvFRqWU0xtHqaAq9npQX3jJ4On9Eh7+le/SQJNf6o8rTI4zLO/hsYrbKWIS/pYGgN1eoUiWRCupzoCDX3V8rH++9BFgRHWOUmiYCaQ1aMb4WNHYwH4wigPVATA50nfMlo7tTalDNnbzt3NkoXPct6x073PA/etLcZ63v61yAvePX3NplywakSfsN//22AAyWxNhDX0QG+A71pT1LDq+YzOpF4AY/fnMiifg9vW7/RUsm8699QN7VGbQWMCM/BsdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OFfSzKp7BG9KJp090r0ago2MUqUfxw//coq21yl8zw=;
 b=TUiKaqCZoovJWKJAdSWUjvD3ursxjkeyb6+4dFf+VfvLs8xoQO0W3yileqnlmsu8WoPyMD/W3XKT4ziJkR4Aq2xgjJEVNLz484QKVstRwwb3cGfaWuII4IQFAfHXLsnOB6WjQyjZTlu3SkGTYY5WKV1vZvuSv9jm+6iw4uRSUBhoNEuz0Yu+Kx2k18Dq94ZdfBFg/EhxPimb49ZPCcnuc12VdfPo3H/KO5mr9mg1LjViuINqgvWSSp3P8Aef3IjIDrW+3FjSaBFPM28JINjtQcYhasBkqeq0zdj+J+n7TsiuOQrrIOMGXDrJyv/jRuaP4sMKCMOqZfPlONJAr7uvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OFfSzKp7BG9KJp090r0ago2MUqUfxw//coq21yl8zw=;
 b=Hmo2fvpPm8qUr1EdHL9os2yztnfRNXp47eO7yN2sr8m+4JbWf85vwVrJ4it3GZDW1i6lulSQjr40K216O0gQeMI2N+SyMy7RmvbJPwfj019UoCVgN4glhESC1TyTvT2d92luBFHlf1Zzqzvmbh7ljwad1GxBdgSwmmOwMPUnS5IJIDzh0BDCMsgUwGQ3N/zHABDeM7tm8we74Rrm+sqLbwRFtDhfW3PRzm9OpuQ4iM61/0baqf1ZpIQK043ZPqYlO5Q6PCtfmoesdOHwLiA64VFo0HMzKiReIB9vKNRdwldYhB1bBl1rcKZ9K3arAi2QWV1kgaQpv/WxS0j8Sggn0Q==
Received: from AM0PR02CA0159.eurprd02.prod.outlook.com (2603:10a6:20b:28d::26)
 by AS2P195MB2272.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:593::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:04:46 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::e4) by AM0PR02CA0159.outlook.office365.com
 (2603:10a6:20b:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 14:04:46 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 27 Nov
 2025 15:04:46 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] arch: arm: dts: k3-am642-phyboard-electra: Drop bootph
 properties
Date: Thu, 27 Nov 2025 15:04:28 +0100
Message-ID: <20251127140428.701755-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127140428.701755-1-w.egorov@phytec.de>
References: <20251127140428.701755-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|AS2P195MB2272:EE_
X-MS-Office365-Filtering-Correlation-Id: 693341d4-8262-491a-aeb1-08de2dbdec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tGRXrnFAAQ4iNOk1bDp4FHrrekJLc6S4/p4G9IQyJEN/g7kncwuICoxDAh8K?=
 =?us-ascii?Q?0r3QqgoxNoskPcnOp3iXOm/U2SyZ6xzewEOJqXDpPfFFGH2aDrboxDou8dLv?=
 =?us-ascii?Q?YBfBfVyItHY20iS7ZOy0WRCiags/kwOcL16QyH59sXAUFTiwTMsCRKwJgHOi?=
 =?us-ascii?Q?Ucgys2UAr61jvfjMcPKt44zGaabLXHuv+g8PBMjT8qdTYQUXo96Ce54jMGw1?=
 =?us-ascii?Q?GHFITnMzA6dnKUjER8lobSo16mExtrnidrxa11/a/3HtKoY3v9sMw45g7+Ff?=
 =?us-ascii?Q?g0yc6ZTllT73eqISfsy46IOR97ORIG73XWaRh5rqFkWlTr7tfmoaqLocGk8R?=
 =?us-ascii?Q?19Wyi+jC5Ni/k61Y5s/ju+PtGjbiMGn4n15LIABb/hVQBvYwAFNUx/aH1Apd?=
 =?us-ascii?Q?3PKrrR+tR7nBGp2qRJLivCb3duJQEZVjed/rVfKyAkjy5veYQc6DePer8jZu?=
 =?us-ascii?Q?iRRoSDuix5V8pCdvsvXLVh2RaumPqm/JDF5aqwXdiRC78zGQAEjN5+i5Qtcb?=
 =?us-ascii?Q?vNc4SMn0SuJN2bqHOIEIIs3bozDZbEB1XYUCcmzfV/UH/zCo5wvbBqtx9IDc?=
 =?us-ascii?Q?SXHoA0rq53QWmFJQHbyALZaWwYB95aie4ldDKJkt5tNh4dTm0iNoXtcm9KU2?=
 =?us-ascii?Q?MwCM3bOy2UtMCyRsnibYb4QrqYUSVXtwv0pL943xc1DkkHxR9L7KYJVGkkFL?=
 =?us-ascii?Q?ohU8Rm7aal9E98wlKNCQVSTnfk2NPM5LOxOVTvrG7vIEB0l5Zrm96RHpiGP7?=
 =?us-ascii?Q?Ot7x/fsxBB4EvUMTuTmVvignuqtlXnBowAtZTfnUxbw43Zv1iaW5Z5pWPoch?=
 =?us-ascii?Q?siOsnLThQkBjW9f3sGwb84CwHtEpz85Tnl3+xFVuQsOgP+MN6Ktl9WaylubE?=
 =?us-ascii?Q?GbN34nEM8ZUw5WYyK2Mpaw4IJN1XxMY0ye544B0SoGcrw1nLwRP0A0y0VIVR?=
 =?us-ascii?Q?oJ9Zq26gMJuk+Xp7/iQ3xgNSKAUiaOZyo53TKPp/3VXB4oPy5XZZGwngFJlO?=
 =?us-ascii?Q?2juHNA8TiltrMmJFIAvif22UTCqLg3jJ+U/2RJDZ8vQ+IEH1u6NQSMplDJ/O?=
 =?us-ascii?Q?i3h18aTLHBplIJgvfkyZqVNh099TjdTl/7scshJZ1MahvpdT8Qniul9juWz0?=
 =?us-ascii?Q?+GK/zwrdZHnQAZvgHRobepcvUOgsXD+19jOyy4sEFGlVMBqz2IXxUcqMnOfZ?=
 =?us-ascii?Q?KffNcp35Y1CNtOufGUSSAcbJTst+KnvFnPz8IbKiXHSKdjAm613dCZSnaGzk?=
 =?us-ascii?Q?xYfQG589RSvavN1qjoD/hVUuavGOeIaMPlU8NEbqbQSejHzDQ0KeBBGV78HF?=
 =?us-ascii?Q?HEk6SrXYVqe5yFNXv3BKAkDYwjp4Qblu0t3PKzppmpgXU4JOOKfYSsxRXMT2?=
 =?us-ascii?Q?PRlOq6xf+38MttaAdmanPK4JGbcmnKzD93YgXOvCWr78bjGoVQPD1SDQ/k42?=
 =?us-ascii?Q?5PT/thwsGRNjIIRrT4n/BtCUUfAzXHeHFasOZJlGlJU1twMNHBAO/lgXJ7qD?=
 =?us-ascii?Q?9xpSCuSqChV31nXDOqB5NdQ81pqo8Wpy4R08OuG8GOwCzMTR1NJ9ioMzZrWT?=
 =?us-ascii?Q?HMWECSZXT/5PD+XgiiE=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:04:46.7120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693341d4-8262-491a-aeb1-08de2dbdec2b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2272
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

Remove bootph properties no longer needed. These are now handled
in upstream Linux device trees.

While at it, drop the vtt-supply which is a leftover from the
very initial prototype of this board.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi | 104 ------------------
 arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts  |  44 --------
 2 files changed, 148 deletions(-)

diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index 56547cbd28a..0c2bce28245 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -17,34 +17,6 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
-
-	memory@80000000 {
-		bootph-all;
-	};
-};
-
-&cbass_main {
-	bootph-all;
-};
-
-&dmsc {
-	bootph-all;
-};
-
-&dmss {
-	bootph-all;
-};
-
-&k3_clks {
-	bootph-all;
-};
-
-&k3_pds {
-	bootph-all;
-};
-
-&k3_reset {
-	bootph-all;
 };
 
 &main_bcdma {
@@ -61,68 +33,16 @@
 		    "cfg", "tchan", "rchan";
 };
 
-&main_conf {
-	bootph-all;
-	chipid@14 {
-		bootph-all;
-	};
-};
-
-&main_gpio0 {
-	bootph-all;
-};
-
-&main_i2c0 {
-	bootph-all;
-};
-
-&main_i2c0_pins_default {
-	bootph-all;
-};
-
-&main_mmc1_pins_default {
-	bootph-all;
-};
-
 &main_pktdma {
 	bootph-all;
-	reg = <0x00 0x485c0000 0x00 0x100>,
-	      <0x00 0x4a800000 0x00 0x20000>,
-	      <0x00 0x4aa00000 0x00 0x40000>,
-	      <0x00 0x4b800000 0x00 0x400000>,
-	      <0x00 0x485e0000 0x00 0x20000>,
-	      <0x00 0x484a0000 0x00 0x4000>,
-	      <0x00 0x484c0000 0x00 0x2000>,
-	      <0x00 0x48430000 0x00 0x4000>;
-	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt", "cfg",
-		    "tchan", "rchan", "rflow";
-};
-
-&main_pmx0 {
-	bootph-all;
 };
 
 &main_timer0 {
-	bootph-all;
 	clock-frequency = <200000000>;
 };
 
-&main_uart0 {
-	bootph-all;
-};
-
-&main_uart0_pins_default {
-	bootph-all;
-};
-
-&main_usb0_pins_default {
-	bootph-all;
-};
-
 &ospi0 {
-	bootph-all;
 	flash@0 {
-		bootph-all;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -152,30 +72,6 @@
 	};
 };
 
-&ospi0_pins_default {
-	bootph-all;
-};
-
 &main_rti1 {
 	status = "disabled";
 };
-
-&sdhci0 {
-	bootph-all;
-};
-
-&sdhci1 {
-	bootph-all;
-};
-
-&secure_proxy_main {
-	bootph-all;
-};
-
-&usbss0 {
-	bootph-all;
-};
-
-&usb0 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
index 32a10b24327..d27fc7fa882 100644
--- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
@@ -45,20 +45,6 @@
 		clock-frequency = <200000000>;
 		bootph-pre-ram;
 	};
-
-	vtt_supply: vtt-supply {
-		compatible = "regulator-fixed";
-		regulator-name = "vtt";
-		pinctrl-names = "default";
-		pinctrl-0 = <&ddr_vtt_pins_default>;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&main_gpio0 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		bootph-pre-ram;
-	};
 };
 
 &cbass_main {
@@ -70,10 +56,6 @@
 	};
 };
 
-&cbass_mcu {
-	bootph-pre-ram;
-};
-
 &dmsc {
 	mboxes= <&secure_proxy_main 0>,
 		<&secure_proxy_main 1>,
@@ -83,24 +65,6 @@
 	ti,secure-host;
 };
 
-&main_esm {
-	bootph-pre-ram;
-};
-
-&main_gpio0 {
-	bootph-pre-ram;
-};
-
-&main_pmx0 {
-	bootph-pre-ram;
-	ddr_vtt_pins_default: ddr-vtt-default-pins {
-		bootph-pre-ram;
-		pinctrl-single,pins = <
-			AM64X_IOPAD(0x0038, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN3.GPIO0_14 */
-		>;
-	};
-};
-
 /* timer init is called as part of rproc_start() while
  * starting System Firmware, so any clock/power-domain
  * operations will fail as SYSFW is not yet up and running.
@@ -126,14 +90,6 @@
 	/delete-property/ clock-names;
 };
 
-&mcu_esm {
-	bootph-pre-ram;
-};
-
-&memorycontroller {
-	vtt-supply = <&vtt_supply>;
-};
-
 &ospi0 {
 	reg = <0x00 0x0fc40000 0x00 0x100>,
 	      <0x00 0x60000000 0x00 0x08000000>;
-- 
2.48.1

