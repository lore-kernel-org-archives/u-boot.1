Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E81F436AD
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8475F84314;
	Fri, 17 Apr 2026 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VluFCmLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A594842D2; Fri, 17 Apr 2026 16:14:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B2E8427F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjxgmLx6mlS4VZaUjudhJqMIUd/vM5LCcDy1jKS5pVkZQvv6xQDcAIyZVIId1fBIveBTov3PrWQn4DHh4Rscryxn4NSTgjYDvhlNPvTBHH7eTZRisPDhdsEh/O1RRQHGWGA20F7s6F64Gqp7ikPmneJkjr9ELKavpItH+E54fFLFlMVVd8HqFAK6/qpaHYRlho0FlcjYwhJC+nBmViWxHNGcMFwm4sDbw+qkk6e2J4wc1yfl+4tkw5cBrronO2OpuyQp4FMJtFIvjIuKsWBemaXOta6w+bocJN6f/3bMqfqUQqqgStcn+w2/U1DWb4OqSM1/zWJoqGlDz6lCzipuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEiVzVrwuWx/NwAqj73J7yqTQACi2G7RvHNainI951Q=;
 b=xdIc+UjhIucYt9xkHaif0zjGG3kxNHBb+4mzAa1LMMpM0IlNQb2Y3WYW6GqA4LoZIOlR1dukGnApmZuLXLJuYQrUSjR+3zZiKknU3229TinNquwXzexL8sLXzOeIK+kj4uLfWl7kRmP9HVvoHMXv5jpj0buhkgPTeEAggfcpYFyvzvqLWCEt1MbXWx6J21DEbHRJSEYFPDYgxXGQceoW3B4py2cgfInOeIudeR0tmPRkqwAt14BDhTkX50GXRpEmO6z84TdgMObF2sagEXVpRIMFkRWjHs/EtL2YsA+Ro2TDnaM43m4hpiYRC3FapuQ9BmDZy+JyUPHATOFvRPKK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEiVzVrwuWx/NwAqj73J7yqTQACi2G7RvHNainI951Q=;
 b=VluFCmLWYH3uAvYl0tZHFCdIa05+IanQsoXH6DbiQSQFOKWVrGIc7XbE7n930LiO8EnzbUBkdeEtB7Ondh/3AyHXYhwyK4OizsHOOTkWUtAbY1IdNrhoDuDLthgpx5qJIbvq+jRoqRZ1eqGnsbll370aRRuUtjMG43uf8rz9JiMefB2jZ9g69rXwLkBB6N0g1b/lYI3UnBqwFzWHe6i3bjikVEXSfd81CeRXLFXGtqnxRcoJ86BxlDAEX6ovZaUixFKzWgwa+kSpjsR3Js1EDkUU9yTvM9iFBtxsmS/JAAavCKycO3sAZWrnp4ZQrAYJlOspmaZJV/35Rbjb/wublQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10879.eurprd04.prod.outlook.com (2603:10a6:800:25c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:14:30 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:14:30 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com
Subject: [PATCH 1/2] arm: dts: layerscape: Fix DT build warning in SPI nodes
Date: Fri, 17 Apr 2026 22:16:36 +0800
Message-Id: <20260417141637.1490695-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10879:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f40e69-0575-4666-a428-08de9c8ba418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|42112799006|19092799006|1800799024|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 1OrTpszBRlXCzapMtV1bsUGlle4YQBPdPy08cEVHDqMZC0etqV+hnoLRRN0VvJqsDCzoi6HWFAns7HYp/WHqptlZ39t9/Qn4RrgPfi4xTF0ka3gig6loJXbva71o5IyDhd48fB8SmHqChzqmZFAh29YeMsSwIOfYuqo/h+ji/BenZnsrHKMLe3OdW2FkWmqHgQkSZC5qU9U8euBwgVXx06Bolt+E7q6DGKDRoduC0cLiFV1ZdTmzj6331f7o8p0PKgnxLWQK0fG79ME5fv7kzhHgTlwQGYIdPxNB2Bzy1bvWY/3in81MtRxk8+iYUMG4b/QeT1m1BZifdsp3Nr8WtDGhUjoA/tz6qpyYgQhhfdvgV6BN/PJBuFcUJiLW4cGXHGRiGBjugOmyBOt62vwoCq1soWJMXRp7vn4fP/p2QSXWqh0Vx1qqZFZUkqt6f2FSS+C+u/iDHMpvW5upZx3sHf1uH4sDBGQlGU6U0HOO1TBalrMxTotzVx74hxOCMxllI4zZUIkydg06xlBgXDOrzzvnF28VmnUYLzU2aJwETyN5+4eV4eFOAEVHPQvvdGepbCAmZsPt7MkFgiuvzk4gK79eglbAkqmF05HLhDgvbDPV0zUpp/oWNClMrCQFY3uj8xLHevDrD++efIH1RsjzU8tR3X0AlsFFzfK4n+gZZhRgWNVo8EwM2wBlWwXicmmEpHqFbpISOFkK+AdRg8qlMKcIr50GpCGvm/5EuySNe9MxLtNVyluduYfHh+K3V3CRNzby7eETOJxkQTv6gcltMsHN6lkrmPlX/f3uBk1Bvxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(42112799006)(19092799006)(1800799024)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TB0DVxAz/9PzUuAGtvrsFKGd7a8q16H4HFqpIEYjZQQ//v1AObgxxjFKB1QT?=
 =?us-ascii?Q?h4ASQS1YAbu+TZQB42b/AurCEfwwHYNqmK8W7EFW2nNFb1IPDPItWNmfdNli?=
 =?us-ascii?Q?LcBvSPDIfRp6zmXZXGoUsdkKJtkx1QszQmeRAv2vjC6JpFamUsSjkBbckbGK?=
 =?us-ascii?Q?iYGWL4D951AV7mRwbruXaA/s4r4UX1w4LO9fN/DGj424Ig+Xj+qOqwdVldhm?=
 =?us-ascii?Q?IhrVSdv/iBFe9SVVcW+ng9LBGiwwExktOqgiYsiDysvforEt0gFr1c5hM4mk?=
 =?us-ascii?Q?Vxi/PPOr14Mm7Wx40ZtC1zyunaIAkGZViNBmyKiWiwq3rDRgMnd/1pM35utV?=
 =?us-ascii?Q?Xp4gZkCbI7EjxEM/itzKDPRxVz31nHcjaQZjXejugJDUFB06IAygFmCC3bSV?=
 =?us-ascii?Q?y4/Gs7w/3Gaviqss9aTlQj6gVusAd9J/OS5QurUSq1fsQIcFjPjktXyXeuMu?=
 =?us-ascii?Q?FLnPfM2/N8PeRgD6xrPbHd65Bgq+2puCAFGB4LEhscFa+pJiu/8mN0/AoPM8?=
 =?us-ascii?Q?XxCSlEpUQwonTXtNGmHQHZ0okS9JEyLg+NsoGe0EB8AWsYz1GLyG+tvqJRDg?=
 =?us-ascii?Q?PL7xeymrPbTcpyAmV7jlPSw3PZC1iKzS4yF52vgVePbeOBkVirXFqElR6lOq?=
 =?us-ascii?Q?kPHbJ7bK+oCJ/5mw95rKCQ6/eru6ryVbeJjum1+eImTVA6nJpqRJZuOC0U9b?=
 =?us-ascii?Q?LZJp7daGullDMndaKsqYx3maFTykTES0M2Aa12rENGDbUm3yHBFsTJ/aAp5T?=
 =?us-ascii?Q?yN01GY5nahWd7I/Twg3TVrUv7HP1VDofvO0HM3TNVR8V9i49d+yuhZhxQswG?=
 =?us-ascii?Q?WXJ6NhsRrbY20HHcDy18porCcqJ+/b2SN1jKXJOxNwXkEuN8Ig2liSpz98af?=
 =?us-ascii?Q?yuqXBs7utoTX3mRbPfBTL/p2wmYFoVletc4/2KkbvbEbsJYWy743SR1YR/5I?=
 =?us-ascii?Q?6MBeBdI7o1UqQPAhMJ++ZOgecgs3Fh7+ztSw0RRXqrXs5pjc6pUEFdLurRqj?=
 =?us-ascii?Q?0bvTqimXYu+bfcRnYmw/VLpQoTZgO3ZnetgJXOid926j3Z6VLNC/berZZyGf?=
 =?us-ascii?Q?CwDOptEq09qyRMRJwQInlIEe9KVEvHb40fulyedqBwE0pcL80WZJ1fBMAG/z?=
 =?us-ascii?Q?zQbRsziROT8gSv9xgyuWqmld9YJ7tyu+IV1UV3/MutgwUBL14GINzzMfQ9Z2?=
 =?us-ascii?Q?y/wio57EXY3fZ7rcp3F4/7VZAQyDhPZj/Vlei0du88CDNBp0tIgdJk4tNbJF?=
 =?us-ascii?Q?giYyCqloyPvHilsty2wIA2DiDZx3YXJjc+183tUlQrWBfjpRg8rfKducc834?=
 =?us-ascii?Q?MR7EDQrR3NZX0ckaq+QOaoiK9gpI5/sDVy4bIK8Lfqz5EvvOsGj87f7G3GS5?=
 =?us-ascii?Q?HCucqjZ5HrmbUZ0EmJIfKEW7S1uwVjjO35ynN3C2TXFwcogrSHmcmxKduPCT?=
 =?us-ascii?Q?XUM5zP2r1bqlEeetKYaVdQJ4sea00NC1VrzZxK0fJfZ/XAWTsPq4sKfEbzl9?=
 =?us-ascii?Q?NKA70HU2KKqdh8X2sYqOMaoAeJeo9TS9UjxdYW+Ecq4iID3t7nysHPdXY6xe?=
 =?us-ascii?Q?A2VnIdE5RyrYkRxaiTiz+h0qnYyVV8oksqfRTwWkuxv3ZbxDT/BOEVNe2UM0?=
 =?us-ascii?Q?rGTkxAKvtF+6xWDIJ/8bNMP8NN+ENmao8UktLbJfeUrCkM+Tb6herruRLc+a?=
 =?us-ascii?Q?fB8sQzJMy9Z2l+PAHhGj/3+qVSAODYtjeg0Pal9DjiF/1jwz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f40e69-0575-4666-a428-08de9c8ba418
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:14:30.3704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/UPICeqsM/NJjzNT+zVsI4X3kaiW4+JtBrNsiqg0tPusmgsbf3mNkd/pnHUPS45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10879
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

There are lots of DT warning in layerscape DTS files like:
node name for SPI buses should be 'spi' and SPI bus unit address
format error.
Update the spi node name and flash node name to avoid build warning

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/fsl-ls1012a-qds.dtsi     |  6 +++---
 arch/arm/dts/fsl-ls1012a.dtsi         |  4 ++--
 arch/arm/dts/fsl-ls1028a-qds.dtsi     | 14 +++++++-------
 arch/arm/dts/fsl-ls1043a-qds.dtsi     |  6 +++---
 arch/arm/dts/fsl-ls1043a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls1043a.dtsi         |  6 +++---
 arch/arm/dts/fsl-ls1046a-qds.dtsi     |  6 +++---
 arch/arm/dts/fsl-ls1046a.dtsi         |  6 +++---
 arch/arm/dts/fsl-ls1088a-qds.dtsi     |  6 +++---
 arch/arm/dts/fsl-ls2080a-qds.dtsi     |  6 +++---
 arch/arm/dts/fsl-ls2080a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls2080a.dtsi         |  4 ++--
 arch/arm/dts/fsl-ls2081a-rdb.dts      |  2 +-
 arch/arm/dts/fsl-ls2088a-rdb-qspi.dts |  2 +-
 arch/arm/dts/fsl-lx2160a-qds.dtsi     | 18 +++++++++---------
 arch/arm/dts/fsl-lx2160a.dtsi         |  8 ++++----
 arch/arm/dts/fsl-lx2162a-qds.dts      | 18 +++++++++---------
 arch/arm/dts/ls1021a.dtsi             |  6 +++---
 18 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1012a-qds.dtsi b/arch/arm/dts/fsl-ls1012a-qds.dtsi
index 910d2a5c778..194ab344350 100644
--- a/arch/arm/dts/fsl-ls1012a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1012a-qds.dtsi
@@ -17,7 +17,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -25,7 +25,7 @@
 		spi-max-frequency = <1000000>; /* input clock */
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -33,7 +33,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1012a.dtsi b/arch/arm/dts/fsl-ls1012a.dtsi
index 796d72fc9ed..b0f3fd79094 100644
--- a/arch/arm/dts/fsl-ls1012a.dtsi
+++ b/arch/arm/dts/fsl-ls1012a.dtsi
@@ -48,7 +48,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -178,7 +178,7 @@
 			clocks = <&clockgen 4 0>;
 		};
 
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1028a-qds.dtsi b/arch/arm/dts/fsl-ls1028a-qds.dtsi
index 3b063d0257d..6d3f08bd678 100644
--- a/arch/arm/dts/fsl-ls1028a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-qds.dtsi
@@ -26,7 +26,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: sst25wf040b {
+	dflash0: sst25wf040b@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -36,7 +36,7 @@
 		reg = <0>;
 	};
 
-	dflash1: en25s64 {
+	dflash1: en25s64@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -45,7 +45,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: n25q128a {
+	dflash2: n25q128a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -60,7 +60,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash3: sst25wf040b {
+	dflash3: sst25wf040b@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -70,7 +70,7 @@
 		reg = <0>;
 	};
 
-	dflash4: en25s64 {
+	dflash4: en25s64@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -79,7 +79,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash5: n25q128a {
+	dflash5: n25q128a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -94,7 +94,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash8: en25s64 {
+	dflash8: en25s64@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
diff --git a/arch/arm/dts/fsl-ls1043a-qds.dtsi b/arch/arm/dts/fsl-ls1043a-qds.dtsi
index 5e02cd91d75..fa1bda51108 100644
--- a/arch/arm/dts/fsl-ls1043a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1043a-qds.dtsi
@@ -21,7 +21,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -31,7 +31,7 @@
 		reg = <0>;
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -41,7 +41,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1043a-rdb.dts b/arch/arm/dts/fsl-ls1043a-rdb.dts
index f5b3bb68b3d..80787907df6 100644
--- a/arch/arm/dts/fsl-ls1043a-rdb.dts
+++ b/arch/arm/dts/fsl-ls1043a-rdb.dts
@@ -28,7 +28,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dspiflash: n25q12a {
+	dspiflash: n25q12a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1043a.dtsi b/arch/arm/dts/fsl-ls1043a.dtsi
index 21643a1d951..7337d3cecb6 100644
--- a/arch/arm/dts/fsl-ls1043a.dtsi
+++ b/arch/arm/dts/fsl-ls1043a.dtsi
@@ -54,7 +54,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -67,7 +67,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi@2110000 {
+		dspi1: spi@2110000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -306,7 +306,7 @@
 			clock-names = "ipg";
 			status = "disabled";
 		};
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1046a-qds.dtsi b/arch/arm/dts/fsl-ls1046a-qds.dtsi
index d66824975c5..706405ba805 100644
--- a/arch/arm/dts/fsl-ls1046a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1046a-qds.dtsi
@@ -21,7 +21,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -31,7 +31,7 @@
 		reg = <0>;
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -41,7 +41,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls1046a.dtsi b/arch/arm/dts/fsl-ls1046a.dtsi
index 44ee4c5808d..ceb5d6b3356 100644
--- a/arch/arm/dts/fsl-ls1046a.dtsi
+++ b/arch/arm/dts/fsl-ls1046a.dtsi
@@ -54,7 +54,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -67,7 +67,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi@2110000 {
+		dspi1: spi@2110000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -311,7 +311,7 @@
 			status = "disabled";
 		};
 
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls1088a-qds.dtsi b/arch/arm/dts/fsl-ls1088a-qds.dtsi
index 4d21d4fbd5e..83635a2e40d 100644
--- a/arch/arm/dts/fsl-ls1088a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-qds.dtsi
@@ -144,7 +144,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -152,7 +152,7 @@
 		spi-max-frequency = <1000000>; /* input clock */
 	};
 
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -160,7 +160,7 @@
 		reg = <1>;
 	};
 
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a-qds.dtsi b/arch/arm/dts/fsl-ls2080a-qds.dtsi
index cb7851f2cc0..f442baa8bfe 100644
--- a/arch/arm/dts/fsl-ls2080a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls2080a-qds.dtsi
@@ -31,7 +31,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -40,7 +40,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -49,7 +49,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a-rdb.dts b/arch/arm/dts/fsl-ls2080a-rdb.dts
index 0a87caeba96..5a9b5c06e23 100644
--- a/arch/arm/dts/fsl-ls2080a-rdb.dts
+++ b/arch/arm/dts/fsl-ls2080a-rdb.dts
@@ -22,7 +22,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: n25q512a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2080a.dtsi b/arch/arm/dts/fsl-ls2080a.dtsi
index d754eb4d5cc..c1173a95f24 100644
--- a/arch/arm/dts/fsl-ls2080a.dtsi
+++ b/arch/arm/dts/fsl-ls2080a.dtsi
@@ -118,7 +118,7 @@
 		interrupts = <0 35 0x4>; /* Level high type */
 	};
 
-	dspi: dspi@2100000 {
+	dspi: spi@2100000 {
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -127,7 +127,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	qspi: quadspi@1550000 {
+	qspi: spi@1550000 {
 		compatible = "fsl,ls2080a-qspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-ls2081a-rdb.dts b/arch/arm/dts/fsl-ls2081a-rdb.dts
index b0b7ef08a02..61f0ed9b821 100644
--- a/arch/arm/dts/fsl-ls2081a-rdb.dts
+++ b/arch/arm/dts/fsl-ls2081a-rdb.dts
@@ -25,7 +25,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: n25q512a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts b/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
index a609290000f..1884946cc7a 100644
--- a/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
+++ b/arch/arm/dts/fsl-ls2088a-rdb-qspi.dts
@@ -113,7 +113,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q512a {
+	dflash0: n25q512a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/dts/fsl-lx2160a-qds.dtsi b/arch/arm/dts/fsl-lx2160a-qds.dtsi
index e96605b1b4f..dfdad5fb31f 100644
--- a/arch/arm/dts/fsl-lx2160a-qds.dtsi
+++ b/arch/arm/dts/fsl-lx2160a-qds.dtsi
@@ -31,7 +31,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -40,7 +40,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -49,7 +49,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -64,7 +64,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash3: n25q128a {
+	dflash3: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -73,7 +73,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash4: sst25wf040b {
+	dflash4: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -82,7 +82,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash5: en25s64 {
+	dflash5: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -97,7 +97,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash6: n25q128a {
+	dflash6: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -106,7 +106,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash7: sst25wf040b {
+	dflash7: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -115,7 +115,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash8: en25s64 {
+	dflash8: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
diff --git a/arch/arm/dts/fsl-lx2160a.dtsi b/arch/arm/dts/fsl-lx2160a.dtsi
index 680c69c7b73..4b4b1c100b8 100644
--- a/arch/arm/dts/fsl-lx2160a.dtsi
+++ b/arch/arm/dts/fsl-lx2160a.dtsi
@@ -134,7 +134,7 @@
 			     <1 10 0x8>; /* Hypervisor PPI, active-low */
 	};
 
-	fspi: flexspi@20c0000 {
+	fspi: spi@20c0000 {
 		compatible = "nxp,lx2160a-fspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -221,7 +221,7 @@
 		status = "disabled";
 	};
 
-	dspi0: dspi@2100000 {
+	dspi0: spi@2100000 {
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -230,7 +230,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	dspi1: dspi@2110000 {
+	dspi1: spi@2110000 {
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -239,7 +239,7 @@
 		spi-num-chipselects = <6>;
 	};
 
-	dspi2: dspi@2120000 {
+	dspi2: spi@2120000 {
 		compatible = "fsl,vf610-dspi";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/fsl-lx2162a-qds.dts b/arch/arm/dts/fsl-lx2162a-qds.dts
index 0ca30df8620..b333af6d63c 100644
--- a/arch/arm/dts/fsl-lx2162a-qds.dts
+++ b/arch/arm/dts/fsl-lx2162a-qds.dts
@@ -41,7 +41,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash0: n25q128a {
+	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -50,7 +50,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash1: sst25wf040b {
+	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -59,7 +59,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash2: en25s64 {
+	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -74,7 +74,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash3: n25q128a {
+	dflash3: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -83,7 +83,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash4: sst25wf040b {
+	dflash4: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -92,7 +92,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash5: en25s64 {
+	dflash5: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -107,7 +107,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	dflash6: n25q128a {
+	dflash6: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -116,7 +116,7 @@
 		spi-cpha;
 		reg = <0>;
 	};
-	dflash7: sst25wf040b {
+	dflash7: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
@@ -125,7 +125,7 @@
 		spi-cpha;
 		reg = <1>;
 	};
-	dflash8: en25s64 {
+	dflash8: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-flash";
diff --git a/arch/arm/dts/ls1021a.dtsi b/arch/arm/dts/ls1021a.dtsi
index 4f65ee765e3..005a40eff23 100644
--- a/arch/arm/dts/ls1021a.dtsi
+++ b/arch/arm/dts/ls1021a.dtsi
@@ -205,7 +205,7 @@
 			clocks = <&sysclk>;
 		};
 
-		dspi0: dspi@2100000 {
+		dspi0: spi@2100000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -218,7 +218,7 @@
 			status = "disabled";
 		};
 
-		dspi1: dspi@2110000 {
+		dspi1: spi@2110000 {
 			compatible = "fsl,vf610-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -231,7 +231,7 @@
 			status = "disabled";
 		};
 
-		qspi: quadspi@1550000 {
+		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.37.1

