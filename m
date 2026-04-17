Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD5F436AD
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B3C8428C;
	Fri, 17 Apr 2026 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hpU55/ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F8A84307; Fri, 17 Apr 2026 16:14:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9CDB842D2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmY0kEP+RgN9Z8YDB6LHa5lo72AUKFkrN4ZPXtoMEIDPdjZ25VFMseABO1uWODdlWvbBYlkHx1N12ZlIvLRiRkWF8z3qpHKRSbf4rz+oD+x+KSl/SaA1A+kZiqHKtxQbzsfgkzw34ssweGqQ+ATe7heA3cdZVABhPETtry/VUu2ivawUwLkmhQa8L4FqQtvOypiQyKdFcVWbrZlJYNSGfYG9jx1PH+UOQZs7acy9HTA7YaOL7696n5ap2QGM9ObSZPFwNh7V7q7MwXCPnbT2W46yN6osNkDlwKQfawZjFzinJw2lZRap+Xx+LbGoHLaUn5HjmV01M252IqbyIHHhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtvGSJXOyJHHtyaFWBR0WwfNaTfbTABxbGcxBPwFKi8=;
 b=TIeNxalAXGcDWPyqfSFsrSfK/6GBFgbxVkal5N7Su7xScWAmYm7KSvPJznAMipBvW/lhVsilb3/4qNBxCgN9T1Yggck/dWqwS+lJNVPR7YZLtyfHnCDKAwsFX9Af+xw89qlaWZDsaf48nStOTRK+wnbozOIOeBR7ERkv6HSW3jRJ3jmj69Mr3k0qGZ0KumIEzQsCLTOa4MWta5V2+ioCz4erncBzKkN+rAKq0W5bgPIdUehbA4UssTVFZu/Pxru/0yGC+HG1OzYWNwYy2LSuS54xdWLx8Z6pwB4nrx1IiKGRDLdvmahrOxlAL/SkoMmw1knz70tAy2BK58qpa4uD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtvGSJXOyJHHtyaFWBR0WwfNaTfbTABxbGcxBPwFKi8=;
 b=hpU55/iiqcxE3KGksbprOzZlMUA38eTFwbfgLMev06ZTpEexTTKNzJEdEu7y00lJSKKpz7Z6zIVojY+Ai0fiFcLNVDLOJCcHA2zrEXslqG6P1zYQSs1l3Aq2NqU6YEjanBj17ls+CdRvldTg+WXNtfWo0fvVNxAiHDQ4/EILzOw059INlKhhZbEFUhy0R9ktSczJnMkUXTs99hTF6RJFZC0hyjRW1xHHUikAdChy2DPgOZGJ/2yPKVhHbzQQTxe11rVXpioGS022z6Lib3+tcMAP/SNpPoRrTsB668zTqms2LtA4DHSw4gKf5n7B+a5U3uabtGcI7dynY8LQBz9kCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10879.eurprd04.prod.outlook.com (2603:10a6:800:25c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:14:32 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:14:32 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com
Subject: [PATCH 2/2] arm: dts: layerscape: Fix SPI flash compatible string
 issue
Date: Fri, 17 Apr 2026 22:16:37 +0800
Message-Id: <20260417141637.1490695-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260417141637.1490695-1-ye.li@nxp.com>
References: <20260417141637.1490695-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84b00d-c423-44b8-0259-08de9c8ba56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|42112799006|19092799006|1800799024|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: pydISvGCz/Gyqt18SFGOY4+hgEAwqp4mA1Gs0d2PPt4ynjFONRYOYFrgoJKOthjToIbTz1julAZEz08pwtq+AbRf4VclahqFKTWokJRGl/WOoXb6AZ2yliGWFOjgGL43dmW6bviXwg5cVas9Paeq9YinKwfAfJRULZzy5nTMLNP+/VC0UDxjnsZeh1cC9/7CaUnVpAxP1lF/IGsACRKvpHSIysau7iP1+DM64OliJD/suiz1bGLCWD509Kb/P1tfTN5hacwrUk+vRoRdsx2XU8FnBCP6PCFneJMhFUOJoTfAt9wJIX481VXCVJcE8T6XGdxQj3MbwuKmNT2yosT2Vh5zz2S++2cz3ThhN56AnUrpRaifv+u2kHglDBmVf6BfluLDcODGd1e1dupYl0wmxW3gjNx3AqhwkT4dKaNMtimokjzH1u99JNl77VvBq1JgGivxBoZzk1Te5oodeKsArFlvjWPD9NFI+ymL8rxEHLA+dFXfgBMSgvmYncRpcZtMj4bopmWBBqhvxm2dAkiSEB/v6LvFGzWPfUw4KLA+SV4XvsbT5i/8vnyLud2F1DRPClINsD8VQOQD8VoZYyj+aDMIgpIceqMOMWyk7QW6HgpwpePheHBvcKmXTi68tEy/2x9pWn34xhqCHzozmLMauIlx5+jgLvrQjFKKs1VzmbJ3GtQ2vDTbBWUdvOjQQmvHOmR66vbH8TlWHE/0mlh4dlooHvUC28U0ctSjq+YLbMxlE/Y07hwEl6HwZzQXkRP8mbtmiMxQ8+e92+z3QKh2zTdnb701T0W0z04aW64C0mA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(42112799006)(19092799006)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?36Yg8ZTASNjaE8JdSRnbsH5AiCo5CFq/Zl4qv8sxh3f67Yzz2sbWVgdF/iSX?=
 =?us-ascii?Q?RA0muZmrTchttEf8pyEMcu4n1v4NaZWFYYNSv3s6Mzp/1PJ9uibKiLK39vZm?=
 =?us-ascii?Q?JhzDuB1UkqAQ8xszKXzOhDdzYgEfAnYMWcZQYYtPnGnWfjafliLY3okfdNFI?=
 =?us-ascii?Q?HOPB8erZaGwEHqXoWe9iTE+FOyboxmrj7Zr1SfbvADnpKaYPOEz5JtCI95Io?=
 =?us-ascii?Q?+SaBmBqZppQbmjr1A4NckqOlJpgAK4YAT6yeMgYVSUF4roLZzl27Vd1wj+bv?=
 =?us-ascii?Q?fhBIkciynql9lspdK6SjOzV6uWzp6cs2KYaSeR9YBIBEhA6iI/aJpvcoxyvI?=
 =?us-ascii?Q?hzPlMkMyE2lcBYCfPXfwsRs1lq6uPqkNgcRt6pOSkWt7GB3pBd1m//lsvuPT?=
 =?us-ascii?Q?9+FDI9vlQRBx/fW7x01NU6fs/rvY0suraRIyiMKY6HivYaLRh0UFs35o9JxG?=
 =?us-ascii?Q?5YCf0Qxw8rG0keCjiTxyqCU77UbEh+k5Agl0eITX9aTg/WmBhoRj1pfpGir4?=
 =?us-ascii?Q?6AtYAJCWK6B1mH2zlW8rQFvDoJ8i1dzFTJ3Ik1UL7v226Qpc1VQ0/gYySjq2?=
 =?us-ascii?Q?fL3t8pq8DOToyG8iZgsi8rkVJL5Sh1rHXNH8ayB7bpkzZVo68WaqDx33EhpL?=
 =?us-ascii?Q?zEsj3ERF6X1u6FnNhhyOk8v/6H2T6T45SDIlhrpFWzDPU0cmudrLTgA+L0FD?=
 =?us-ascii?Q?zmCJRZls+tgH3667ELlEA8mfXZ0r4S7Z5n8Fu6uN6Vgtkx5x30Ik/a5u6Rms?=
 =?us-ascii?Q?qh0FvoxgG208DMC696CwDdjNH4KJ9VJngRRK71y+s/0WNF1kpJPdbsDY6D1d?=
 =?us-ascii?Q?xpbXfeHo66eyXJtsyQayT6kIQ+ierOfNTtTg+g/FefhE9SElve/ziMjzcuJC?=
 =?us-ascii?Q?uvCtppOrLJHZW6PSQ4SFPTcfpFKnBdTotjYlst9gJ7aLeqOkfygHHezCX+ne?=
 =?us-ascii?Q?2YoXgtqAeecIJtv284auFZdKDoC5kb5nTASF64EPyL3QI54c2KNSqziSDToW?=
 =?us-ascii?Q?HhJM2swv2Wo9T+na5z6gQ6aDA6UHegqvLoGRKweOOig5HTl0otfL9FHHaFFg?=
 =?us-ascii?Q?6gFBLTWrjRMlz2r4OJBUKU2dw2oLxXkWVS5ccsUSPsD8pCmhsqQncFtDcQ4X?=
 =?us-ascii?Q?erk5yy4mvVtmkBiurGxGyrylibaVcvxsdHcq64vMTXKHrJRN9uX0MBmPF4J0?=
 =?us-ascii?Q?whjf1fdWRHUAm8rKS23L2liBEvQ88UZBEWdInyaTvBS5r/315GOAvOo8p9f/?=
 =?us-ascii?Q?ac3SWlrkLOBanlKG7JUBxkdAO6g//EF6YCP7/0kgkL5NmthmAhPBQlK5mf1q?=
 =?us-ascii?Q?HGmxWttdKeSRp0kjIfhs6enjKQJaubjzHCtbt7gO6rRRoVDl72E1usLlKLTY?=
 =?us-ascii?Q?y0tGtFgrCXuV4zS/cf6FVdpheccFeJX54t1aQ84C0h84GFwqWE924do85566?=
 =?us-ascii?Q?JKnLfkKPcV1OV1Qi13ZT0rNbWXh3xXCMcawQgQwrpm+i5Q9tJjUFtlXPUCLa?=
 =?us-ascii?Q?azB07+Q6l9cE0y5jFnNLLad5tCvM1xraahN8oPrfeuj40AaABtbJ0Vl2UIHX?=
 =?us-ascii?Q?7L7iL49/cMYfc/X/nwuuytbaB6xYVkwiiIS0lh4m/+GCYjO4o0iP929VCzDf?=
 =?us-ascii?Q?7+09msgVTtVSHMsBamH94uRWgqLgSap4D6jD4iBsKpq8t16EAnwPbqXeSZA+?=
 =?us-ascii?Q?kGliZFO+uqtaZjA7ckLuAw6OS9Truytx/F8UmQxJJ9FBjpi5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84b00d-c423-44b8-0259-08de9c8ba56d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:14:32.4603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYphi+QTFnHcnJMURLmY7f/lws+F9WAMGg7PDS/kzsAI1Cqvzoe1LtBgo8d6cJlP
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

When CONFIG_DM_SPI_FLASH is enabled, sf command will default find
device from DT which requires to use "jedec,spi-nor" compatible
string not obsoleted "spi-flash". So update NXP LS DTS to use
new compatible string

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/dts/fsl-ls1028a-qds.dtsi | 14 +++++++-------
 arch/arm/dts/fsl-lx2160a-qds.dtsi | 18 +++++++++---------
 arch/arm/dts/fsl-lx2162a-qds.dts  | 18 +++++++++---------
 arch/arm/dts/ls1021a-tsn.dts      |  2 +-
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/dts/fsl-ls1028a-qds.dtsi b/arch/arm/dts/fsl-ls1028a-qds.dtsi
index 6d3f08bd678..ac5b2d9dde9 100644
--- a/arch/arm/dts/fsl-ls1028a-qds.dtsi
+++ b/arch/arm/dts/fsl-ls1028a-qds.dtsi
@@ -29,7 +29,7 @@
 	dflash0: sst25wf040b@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -39,7 +39,7 @@
 	dflash1: en25s64@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -48,7 +48,7 @@
 	dflash2: n25q128a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -63,7 +63,7 @@
 	dflash3: sst25wf040b@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -73,7 +73,7 @@
 	dflash4: en25s64@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -82,7 +82,7 @@
 	dflash5: n25q128a@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -97,7 +97,7 @@
 	dflash8: en25s64@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
diff --git a/arch/arm/dts/fsl-lx2160a-qds.dtsi b/arch/arm/dts/fsl-lx2160a-qds.dtsi
index dfdad5fb31f..6fa36de0622 100644
--- a/arch/arm/dts/fsl-lx2160a-qds.dtsi
+++ b/arch/arm/dts/fsl-lx2160a-qds.dtsi
@@ -34,7 +34,7 @@
 	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -43,7 +43,7 @@
 	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -52,7 +52,7 @@
 	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -67,7 +67,7 @@
 	dflash3: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -76,7 +76,7 @@
 	dflash4: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -85,7 +85,7 @@
 	dflash5: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -100,7 +100,7 @@
 	dflash6: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -109,7 +109,7 @@
 	dflash7: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -118,7 +118,7 @@
 	dflash8: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
diff --git a/arch/arm/dts/fsl-lx2162a-qds.dts b/arch/arm/dts/fsl-lx2162a-qds.dts
index b333af6d63c..4eaf982529d 100644
--- a/arch/arm/dts/fsl-lx2162a-qds.dts
+++ b/arch/arm/dts/fsl-lx2162a-qds.dts
@@ -44,7 +44,7 @@
 	dflash0: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -53,7 +53,7 @@
 	dflash1: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -62,7 +62,7 @@
 	dflash2: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -77,7 +77,7 @@
 	dflash3: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -86,7 +86,7 @@
 	dflash4: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -95,7 +95,7 @@
 	dflash5: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -110,7 +110,7 @@
 	dflash6: n25q128a@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -119,7 +119,7 @@
 	dflash7: sst25wf040b@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
@@ -128,7 +128,7 @@
 	dflash8: en25s64@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <3000000>;
 		spi-cpol;
 		spi-cpha;
diff --git a/arch/arm/dts/ls1021a-tsn.dts b/arch/arm/dts/ls1021a-tsn.dts
index e74d0956194..b5d9caa73e6 100644
--- a/arch/arm/dts/ls1021a-tsn.dts
+++ b/arch/arm/dts/ls1021a-tsn.dts
@@ -173,7 +173,7 @@
 	status = "okay";
 
 	flash@0 {
-		compatible = "spi-flash";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
 	};
-- 
2.37.1

