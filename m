Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF37CC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 01:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFFC828A2;
	Thu, 12 Jun 2025 03:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KyA5Km0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE83482977; Thu, 12 Jun 2025 03:03:59 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6883081FEE
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 03:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtQRCk2o7Q5iYM2jyCD0JvrphHR7zoiifz+y9vTBIMmVoBjl+ByZ7PkmOI3hudwBOl0eoJMpzHe1txfghiygA5ovIPNNVhTS/ZJUe+3AL3rSvHuc8hSg6aw2zjTqrS9lHBL0PRHtZyvnMhawlzHUT07C571+e0DaQzXy67kZ6V9XQttRRjzgwENurFE0qzlm90S9i546EBOvJNgMhApt86DaRNeWxfLIisDDuS9/PmOONO2mapHynYv4J7+vJPMHfs5ojFTu5xJyrRMaQMZ2ZNd2UYSfkYUn2StmPtnIruH+mkQasUe04K35vqPS33HgLC2C0mnd+cZ3wtf7wMMeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvkqRDBPEqXmZVzhPNeLpR9FYANZ/N6gp7zH+Ugr/us=;
 b=cqe4z3xCJ3qizebTWdEnFqoCb9OggZGALJXJctktc10BxZt1elB+6KQOo/GvuhapWFPpv/zrWNQVFcEuPxxqBaCSuDopai6889WwuOWAzME4B19MC9iaPmEuqRW1uOyWqH5N3ODjl0Qf0jFYTbNfLv3eH7gAiCxPoPdWCcbP3BVTwRmO0QSK2oXyK67AFABsy3e4Zoc22EKZ1LVKyebqngyoVFTXrS2ahJHoMdKjEACo8B7ZBlz+hRdPUNs5AzphbJRxbo4KvfS1wuhfZQXnHmTjvlImQDjqBjQ5rds1haNOytcN/eu5nBTwcPk9Zb7teuF8DvhX9lnLGvA/vKo0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvkqRDBPEqXmZVzhPNeLpR9FYANZ/N6gp7zH+Ugr/us=;
 b=KyA5Km0xU1I4mVhvWdR8TyC8q80R9lkpBganh7Jz/zZWE6Yj4Ejb3XpAcKzRMFhG0dnmKIaQ5Jq5nrMQX6X6TUxtarlUFiyIokSz+1U8LUcmwJbUNM0TFHJkBdI3BU17/u30to2hkgxEq4cUmhAFaFZ8DLuBSIkAo48AomUET3IdlwZbblrbYJgR7upFQ1/Lemy76wBV6gko+R7yO7bQasW0OQeplKW7/zrYiRWgZDlNqDMAO9xbYk30VcJbDRLs/kmddUHfI2/D4TeWiZeJ4VDFkNiDFckJ4/XhH5s96jh+yP7uOJXmHOih5I8z+aEC7U90kH6HG0d2YDBB3u25oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9594.eurprd04.prod.outlook.com (2603:10a6:102:23c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 01:03:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 01:03:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sbabic@nabladev.com,
	festevam@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] imx91: Drop OF_UPSTREAM
Date: Thu, 12 Jun 2025 10:13:56 +0800
Message-Id: <20250612021356.4228-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3c2e6e-86c4-45b7-1fcb-08dda94cfeb3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BBsJIc4gIoiIlSZO+kPzbCDGFWQROuxlZVk41SM50xSKv2yuOqZF3q/niSuY?=
 =?us-ascii?Q?trnSof5xlRenXB0cYOfr7TQMKpmZRtEqqKld0uBmpNfmewqV8uc7zUMVCZHZ?=
 =?us-ascii?Q?4IS/oj+yffqI5Um8w46ALicJvBqfXeP3panT/Xt+5OJs1KqdcaBUAQvLASQg?=
 =?us-ascii?Q?ifPsvDqWFL72nNn8fkebbDSFng3aaeosriz3/fasOhoR/cHZMVKSPLydMvUs?=
 =?us-ascii?Q?LxTJ+5Wj5pOxK0vUp+xUdL4tbxS50/lwcni2/2mv1xtkMdGPhsV3OKmeMzHi?=
 =?us-ascii?Q?72BkmGmgjCQ0c7ZdqgNyG5YDqtiti1jpcA9twCf7X1zNNnutcjyaJscDqd8x?=
 =?us-ascii?Q?k+Qu3ygNhMqASwTYM2kbAjPg/9dhijMIJJJKP3bnsxRIMJ5CRSYMsdFIaQee?=
 =?us-ascii?Q?U7E8BF2guVIb++a3oTwufqLUknmCum5r/SNwt2gJxjZZY27uoIQO/0Tt1a8o?=
 =?us-ascii?Q?nrL5Z0yCFSmAopXGZdWravCgUQ20SiFvaF3gYE8HUbYAZq2sucl3BIFRvnGg?=
 =?us-ascii?Q?aKxz+uB4vLxr5GNbqDyf4zqFsDZYV+T236qprJywVmDI4b81hPxlXITj/Jzt?=
 =?us-ascii?Q?11BQMZU2rBaOFz05kYNlMNZoi4A3hnDVpdNbZDLqlnmfQ6FoedHegvp/Iy83?=
 =?us-ascii?Q?7TDJdBbYdV/Y/JPLXy+EBDw9oAQ9rOGOgdxeEeCC9/u1TQ8Vw63J3rrzodIo?=
 =?us-ascii?Q?k6I5fo9YoOwaAL6JzmfrLg5GL2z3gfOse9GdHl7MCyVAZC7qa/w4CcHnfIti?=
 =?us-ascii?Q?zOrlf1SeDWP3QMSrUkAlQh9UqSJthRANRg6usOpPjaAaa9kZuchfG5bolu0p?=
 =?us-ascii?Q?Pd7blL0tZPOBySHF7Outrv61y32Gp0A/CNGqMAfxP/7GTtKpUo/2LSzIh+Y+?=
 =?us-ascii?Q?W97RRpl5Bln9fJl7qNecYNMJcs+JLXqaYLqAnx/Xr/RjB/L49rCtW/2n8+s0?=
 =?us-ascii?Q?d9kuT7LPuAoawCffEDy5pEX2oSh9qL74b+yjYGfMC7H/IYtnwWMroWayDMEr?=
 =?us-ascii?Q?bPkzNpZGf3bj+fiqNI4v6NAAXkPy/9w7Q4a6M2SQKvOxiSfG1BVIImD02niK?=
 =?us-ascii?Q?frPSW2WhLpH8df01eXN+UbAHksd7bylHZMLeiYimdRmlvoeHeL4SG6F9w5Dr?=
 =?us-ascii?Q?qa2K8HX4wq6j0p0jyqV2zKjzE3FXYCY8+gj1ZOrl3zveMFVxkfE3/211M1OA?=
 =?us-ascii?Q?XyZhMFwIA6Pd9ou8wi699uPIuZFrNPJjH97CFrU5Ys9g/uuCHCTspNkpSDBH?=
 =?us-ascii?Q?fCzmRF1QsHlaxNBjTsaOQidxGDaKLZBn5q2373dBLo3N4BjlzoBAvWD314Nw?=
 =?us-ascii?Q?xtg67skFo1b3/MpY0tQUbup/mibzfG/H1QqWXx7AZ6uMuo070/w8aBm1XXQn?=
 =?us-ascii?Q?JPc7gNinIGfkHKgSrvAwjUrn3+LjY4sCR8alUpnPKNBOwUHMx7zrfAl7IZED?=
 =?us-ascii?Q?uE854hlZu5oDaCxPgR2y6qsem6lU1fwL6BU5G3khQt6m+cC2T07Lwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od4zmRnnrAqwukz+w/6GBsf1gcayTn2Gp9Rz6gfc6tW17ysk9f1i2lsyRHq6?=
 =?us-ascii?Q?rRvbNtOOdTi5PLcwtFJ057yfdrUAxs4X1bqlTf3+RulS4POtPO2odMi25/Nu?=
 =?us-ascii?Q?7JN5f63FR/ynRojKwuvKy7LKLHpppBWH8AXk5AfTlOJMoqzDq2Kt0+WxOvZj?=
 =?us-ascii?Q?RhUljOW+N+DowbVoyryh1WCjsGX36HZoL8ApFMzmm/xnkKi5syp6YuArPoCY?=
 =?us-ascii?Q?cIkfI40AHm7BjNav+fl0/08ox9RuuTnHvbVwL/m4ClWf8oZKdfPUJQ4WFON8?=
 =?us-ascii?Q?LHxI17y56INnVpUjhFvDnPV+rNC1KVYwNd4Gr6EQr8zK9s4c99Gfm23JuVIV?=
 =?us-ascii?Q?GWqNuebO3H70/h5o0IOBVigkHF9z2lYTfjeGJOdxZbDyXZjEyP6PwXc++49S?=
 =?us-ascii?Q?xLNw5ExrgNDVToKntmz63olC1T+QH8YM0aYRg4sXL8TO7T0c7mdwln/47wYG?=
 =?us-ascii?Q?Y3l2+t4rfi4ie4U9SZLcbyUE97tRZkmvvPc2cybixZSJf1wOSNmK/HKgX+QA?=
 =?us-ascii?Q?kXa+EpspWKhut/vggVZpk0Odvu+qpt1XqKohLDYuT2WKOru7q6Ed2RYvvQGw?=
 =?us-ascii?Q?NyHIRMlit/ARWA16Od6Sd+7TA9MtUvkT1piX31bbXW7RElz0v9LWoCTmx0jF?=
 =?us-ascii?Q?a7SQN1BbGslGNGxj+FrRGBNhq/vHzlzwqRa60I9589/0nx7vq7Xg5Rd2Qu4b?=
 =?us-ascii?Q?i3vE4sWon1awR4WlC6L3uUc7yaodP4kkzO70y9itl7WqBCu2lq4FVzNdanK9?=
 =?us-ascii?Q?1Y2cadmXBnyoxr+j+cPpWftgC/EbJwvEbRjndgicMsLNS0LRAY+QhRilVnUc?=
 =?us-ascii?Q?jKUU1KC5kNf6Jvoj9mbEChcomLrMr9+X/hm1vpieJbcRWx7RBXuim7C++zsh?=
 =?us-ascii?Q?f5wGc/1VxUjgO5OuaGF7qc++19P0FYkOqV/1Oovt8jYqNo1POr5t99j9xdWl?=
 =?us-ascii?Q?t1eeg+Mc4G0JeHvMMRwdjOauzPSwPfdGOWc4RVO+/EdJv/UDKHMdNWhyzwkz?=
 =?us-ascii?Q?O6YdmzlVsuSRlZEwTb8B51pJgTO0DidX0hcu3ZCckJkYhcEtiQXhsQkIgp7K?=
 =?us-ascii?Q?7i1NSA1Ps5G29ZR02vaU+5ZcnIAKA0ZVRB1+QhJltigG6OH4yJNy52g9kVaq?=
 =?us-ascii?Q?AH4AJxRMWyc2jOCYSkKGhme/BRHp9VuNhteu242CzTwVo1hvdzSOYMSBNpRK?=
 =?us-ascii?Q?NuhXZ02kta3SVpTpLe4KvCj1Y64LZyZ/YimLUhvg/iyFreQAoo0DXAZzDCCD?=
 =?us-ascii?Q?EPeDGQpe15RPfDsLtpTyiujgQFDcI0xwg+o7IoqJgpWuTvjeHMiMk6QeZHE/?=
 =?us-ascii?Q?cXM+zk+UUXMGWUO403RaYB+roLYedeucAziBzFKdX/TAGVrhWKCS5Nnc3S+x?=
 =?us-ascii?Q?WLq+WnDND0/FNEB/noF+ctU05Vhq8P07ZZtZ3hLSeJaL+qs4WELHT6mA2O8P?=
 =?us-ascii?Q?8f9Lkgrly6dHyn1I/5LY+66hQF26Wu5PnCWnOGib52vnxY8kYelxcOIE1YNg?=
 =?us-ascii?Q?EsrXKJJIrxlz3t700Qk1izglfbuE2ogpYsrBdI6eIKLWfbA+9fJZNL2OyQtc?=
 =?us-ascii?Q?iKHpcirjHk4PFKqK+5E3+7gVRMF0uoKYSyv247Fn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3c2e6e-86c4-45b7-1fcb-08dda94cfeb3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 01:03:51.7159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfp3XJDDeTaV0++8ZUxD+GZwdf9RW5KT5CJxXnjwXd1n3E/pZcdE1vAAcN6DcCdNCzF7pNNl7at3KzGZahtJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9594
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

From: Peng Fan <peng.fan@nxp.com>

i.MX91 device tree still not landed in linux kernel, so drop OF_UPSTREAM
and move the device tree files to arch/arm/dts

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../arm/dts}/imx91-11x11-evk.dts                |  0
 .../freescale => arch/arm/dts}/imx91-pinfunc.h  |  0
 .../arm64/freescale => arch/arm/dts}/imx91.dtsi | 17 -----------------
 arch/arm/mach-imx/imx9/Kconfig                  |  1 -
 configs/imx91_11x11_evk_defconfig               |  2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig    |  2 +-
 6 files changed, 2 insertions(+), 20 deletions(-)
 rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91-11x11-evk.dts (100%)
 rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91-pinfunc.h (100%)
 rename {dts/upstream/src/arm64/freescale => arch/arm/dts}/imx91.dtsi (79%)

diff --git a/dts/upstream/src/arm64/freescale/imx91-11x11-evk.dts b/arch/arm/dts/imx91-11x11-evk.dts
similarity index 100%
rename from dts/upstream/src/arm64/freescale/imx91-11x11-evk.dts
rename to arch/arm/dts/imx91-11x11-evk.dts
diff --git a/dts/upstream/src/arm64/freescale/imx91-pinfunc.h b/arch/arm/dts/imx91-pinfunc.h
similarity index 100%
rename from dts/upstream/src/arm64/freescale/imx91-pinfunc.h
rename to arch/arm/dts/imx91-pinfunc.h
diff --git a/dts/upstream/src/arm64/freescale/imx91.dtsi b/arch/arm/dts/imx91.dtsi
similarity index 79%
rename from dts/upstream/src/arm64/freescale/imx91.dtsi
rename to arch/arm/dts/imx91.dtsi
index be923e5076a..9963f0bb5ce 100644
--- a/dts/upstream/src/arm64/freescale/imx91.dtsi
+++ b/arch/arm/dts/imx91.dtsi
@@ -7,7 +7,6 @@
 #include "imx93.dtsi"
 
 /delete-node/ &A55_1;
-/delete-node/ &cm33;
 /delete-node/ &mlmix;
 /delete-node/ &mu1;
 /delete-node/ &mu2;
@@ -41,18 +40,6 @@
 	assigned-clock-rates = <100000000>, <250000000>;
 };
 
-&i3c1 {
-	clocks = <&clk IMX93_CLK_BUS_AON>,
-			<&clk IMX93_CLK_I3C1_GATE>,
-			<&clk IMX93_CLK_DUMMY>;
-};
-
-&i3c2 {
-	clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-			<&clk IMX93_CLK_I3C2_GATE>,
-			<&clk IMX93_CLK_DUMMY>;
-};
-
 &iomuxc {
 	compatible = "fsl,imx91-iomuxc";
 };
@@ -61,10 +48,6 @@
 	status = "disabled";
 };
 
-&{/soc@0/ddr-pmu@4e300dc0} {
-	compatible = "fsl,imx91-ddr-pmu", "fsl,imx93-ddr-pmu";
-};
-
 &{/thermal-zones/cpu-thermal/cooling-maps/map0} {
 	cooling-device = <&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 };
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index e6cafdcd813..280d255c086 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -43,7 +43,6 @@ config TARGET_IMX91_11X11_EVK
 	bool "imx91_11x11_evk"
 	select OF_BOARD_FIXUP
 	select IMX91
-	imply OF_UPSTREAM
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 810a8a8c012..a57c1fd01f5 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
 CONFIG_TARGET_IMX91_11X11_EVK=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index f330ea694f7..0533acaaa6b 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx91-11x11-evk"
+CONFIG_DEFAULT_DEVICE_TREE="imx91-11x11-evk"
 CONFIG_TARGET_IMX91_11X11_EVK=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
-- 
2.35.3

