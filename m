Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A7CF256F
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 04:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35EA38397D;
	Wed, 19 Nov 2025 05:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jCG9irZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFD38397D; Wed, 19 Nov 2025 05:00:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C16A83979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtJZI7UBXDckVcQJKTfpJ1owNPBZ5A98uxsbsGtOqVF+O0uLWGIKJoDwmrPaUhz1DMb0zzQslqSKN5YL0V52SYA/XfT9B/5qXq1D0DnbLG8eZVmVOUBL1I1pJRbPp+eNKCU1Vl/zMpTGcjHZ6gjuHHtx07soyqLlEknNvg7RKxUFPsFYbGkpkYN00oLDwyPcURPUS8yGG/+24kv7ap5BoZaOmntVu6Q7i5L+7D0tca62AP7ichyevBEoGv2YCQWczD20pQ01S3I2nYZdlrM8k0+am0xnTLldXmYNjFhuJ9rdfGJ8PBmw7PDlfhU36afhteh3qNrLU53gAeY/UsztAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xe76iTmqIRNNYezAaMj3iwQSbszt/zQ1zAtguBJSxU=;
 b=CI1eHzxvChHG2K6kycC9NrL/R1lJBj2MjYN/kwBBwddIUxheOpPeT8AIYTyrAamLnzbM6OmcfT7+zzDfnuzXNnqcCNR002TCVzH5th7Ldfdov3+PIn40q3qP7XF+Mx25YQc9j1KhPh+nO0JaCFzs9Qju33Ijaf6dxVccu7wTbPQDq080QOmsVTbt3Ly2XeSlSasvEsKoiGVmAjVHMOswX77ikE9lGKqLYowisX5D+nYrJfaa10KTuJOPgRRrt4lz8MWNGbaYICT4NUL7a2saonKgjVm7aJZC349mI11j1xS+ppBZUDsa5gf477lrZRFuiB66299vWB4LX9d94WLIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xe76iTmqIRNNYezAaMj3iwQSbszt/zQ1zAtguBJSxU=;
 b=jCG9irZh2WzvL9c/ecCxeawcM9ajVdtsq9kG1HCY5fLMKGAD1Gj/j5Kbw5V2Mp//ySVCCIe9lEcpBvmVtItdJ0OeeCmQdmM4YFpMk21QV4XvK15p/JawaTjHdM44t2iJZROlVgtrazM1ICNkvylQSMBTc7YDEytZO95fL24RnZTegGeUNcRZQy/vzhtcS6mrhhz3RpLdankXiF5i1zRNKYqMPkJOwebLTPYnE5vpVPBsKYSgzKFPC17lv2bofZ0Bio9cWYTmSEspKBbVbJGYnea1t0vsix+JAjHm83j4DgvGEbs3YvSdkBOUkyIpvXTLAFmrADO6M/fBYdJ2vQg0jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 04:00:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 04:00:10 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com
Cc: alice.guo@nxp.com,
	peng.fan@nxp.com,
	lukma@denx.de
Subject: [PATCH v2] arm: dts: imx8ulp: Update device tree to fix boot issue on
 i.MX8ULP EVK
Date: Wed, 19 Nov 2025 11:59:14 +0800
Message-ID: <20251119035914.1165505-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a3e888-567c-4126-ad00-08de27202213
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8XY8XLkmTVdTGBd2pS5mT8db+YPXjw9oGXPbES7fbVbWtmxllc5lC/OVW0qA?=
 =?us-ascii?Q?NJRLqYztWv0kB3OQi2iAPaEb/6aGYKy5d8kbOqzbKHYC7A3SX8rLU/pITqo2?=
 =?us-ascii?Q?FR4K2sKaOxXQZxWhQQcvtLimAOhQNrIrxW6WzoeSQOYw1dAkXDzNZ5F6O2ya?=
 =?us-ascii?Q?BUtLDCUCWb5IGACazgfCp8VWRmIChlbd3/m5qK5m5cJZ5X8n3sm9Q7Epfj38?=
 =?us-ascii?Q?n/UTe22F+Z5oxRiTWZoLUWp/gCZ62jIcPx6a6AH5hBxrDhjRmLDcEbrrRO4T?=
 =?us-ascii?Q?XElVz6IKA2aHuUT2PA28bzgPnX6J58PdftTSwUvHRgR3seJ9xZ6yBDRzBR7I?=
 =?us-ascii?Q?HSJ6p5nipcLF+FTd9PqRXcVts0JNVDHn8H+K1CnTXVl+I5tkVCO9iYf8Rvb0?=
 =?us-ascii?Q?YW0Lf4aBdToEMSwFxLoDvuf9uSV/m2xL5IRBdW6msd0/Nb1+0STHGVQn0FoS?=
 =?us-ascii?Q?akxI9xwEmKRwnM8i2b4iy8Ew7kxJIChUR05wwsHEen3T8Do8AqIk4HHJ229z?=
 =?us-ascii?Q?OyobcS3lcaUP58vBJTYdKJVo4pKMzAW/T5AC7gppDlWmamaazcwyEYJEbG56?=
 =?us-ascii?Q?KgugetRBLtxtNz6BCU2ZWd5XFYxkoj5veIn6GjHgZ2DLpmYfZZLOiJigwYBL?=
 =?us-ascii?Q?bS734boAov8CZB4RUJKYMTEdY7563Yv5ipyjSN7IYhp2OWt8v04wRyy6mk/l?=
 =?us-ascii?Q?P0knd+PI937fI5njL6wV6dcyJxu1OMXuVgMLo9sMjruaLbINExZBb28+In3p?=
 =?us-ascii?Q?ZFkH4UyC3+N7CVfYnXs22FvVr1FieP4LZUtSFCx6n8DnloOkohrGOuNhniNg?=
 =?us-ascii?Q?DEZj0QwccU5/UdoztFBtSpx4RM4YDmlFk+heiy63z9wAF/uNPNzw6Eol1hFX?=
 =?us-ascii?Q?08HzGlaaufeKzw/kNIPnEKh47A6UBcuCopmOWNz+e5Xd73M2cyrKhjKWMk3c?=
 =?us-ascii?Q?OTvpaKJCXWK7/rFiXkKcDf2UX8XuemFCeIeEgL3FqqV2Ia56d5VmcpO5Wx1o?=
 =?us-ascii?Q?P1mlQAiVj5GgurEduXT5DYOBJc9PaOJoz8dmDyHcjOgc23Zpz4vjrllYL4Gn?=
 =?us-ascii?Q?ZKCDXFi9PAvP1wulf4dEIUx0qt/tyI3yCBXQbkG7fKCcfxeOccih8KMiCnO7?=
 =?us-ascii?Q?eJ0f/slwehCF/H8wuYaduw05Fmlwe4zT28cQkPy+4Be/zQSH+VlZp4b7Lmak?=
 =?us-ascii?Q?vG2nXFM2Ni6TezVoz1jOZBqGI00HuTroDArFX52fomYH+6Ilb1Fqah0AlTT9?=
 =?us-ascii?Q?1jhLt6vgZJxkfjQ1a38Q6klGoVZWB7ER9iNcon05FkcheUSHN5h9YQS1QN8g?=
 =?us-ascii?Q?SCJR/ENc926RTL83GKnjulwU3UM8Jsct+eO8ACWwel2bgXGaO3w5EPoyd6Qe?=
 =?us-ascii?Q?fNm1sfj4CcC28GQfAP7IlFXjSxrgDFrTMpqZtgUOd9fecOCFuQc7SE8R2+uu?=
 =?us-ascii?Q?9VE7sexVI+y5bbq3yXBMfNr4HmMTNqqQ6dTA7458AVOeYMM6jL+z/pYzMA/2?=
 =?us-ascii?Q?ggP35e+GSUOtUXaKKaF2DQXIq6i+tHnF13a3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbanO7vWE5mEt6uKYbPXyMFYVp0uD4yecQns4P9U1wSYoOOCJdl/qd+m4elD?=
 =?us-ascii?Q?TVAPu4A50VKSTJ0642AjSIAIBJmVRZDTVF1REfjHr6Oumw9Ou9KJYMYGwYP/?=
 =?us-ascii?Q?mjIs35vk67ZjTlQC6bInC88EIDkBM4wME1C4stp7/SqqGsPZLpX1YN0ERYKA?=
 =?us-ascii?Q?627XeLZFnsp6K9u8YmW0z3KWS7RL/USWdaFytKPm9Ubc7chYPdRGl+QXF7hx?=
 =?us-ascii?Q?q7M2GjaTxbeIpMUjtCLtaz3soqO7dj9Rpuw4eZ4CIx5RxF7TBYdVGhc4gwdO?=
 =?us-ascii?Q?UzIQ8ttow6mS2CBLY1soiKqYW8YsY9gf3A7VDOGcWEWjmSy02/Ok/Uq1inzs?=
 =?us-ascii?Q?oBrn9ZEsZexDDXBLXi+IOSprYd0N0sFMUnRa/18j3hZHT06nYF0IC5ryctE6?=
 =?us-ascii?Q?M3XXxvZtJpITmNITC0xFUcPKtsdfmB6BRw3HpFqfHXJ98NmzdlbEmwUCVIbW?=
 =?us-ascii?Q?WebFxp3BCHNcVhEzdCguj0iLHtkV24Rq+Sliv35QxLisxWb5Nc/qOp4DX+3p?=
 =?us-ascii?Q?T47S/vnmJ7x6Ic4WLcHosEN+2IOUJo2JoABqc4JlTR6+/HqJwUxOeE5dkyys?=
 =?us-ascii?Q?VybatEkcIF0vBoo/ZJxRz+4jRU66cVcgo7DxnljV9A0uOPuIhbfHHqU05bR+?=
 =?us-ascii?Q?KIxofn29K0icJUt377OXxfuPWe5oKSDSukzZc4m4Cp+HhmuPNe6ab3mtiQP8?=
 =?us-ascii?Q?KTSGCFpEezzv5uZmDcqbh3XbF/DsrL62x0PPEleIbnspecujesEoxpTHv8HZ?=
 =?us-ascii?Q?InhMaegNbvqUJo7pdQr1K30uATUSr36+EFa7dAIYBIBjSIRhDKvo7Za+l+31?=
 =?us-ascii?Q?QzVMmgO+IbLP8KLZJS4a0y2VJ7OsMvOhpan1C9h/8oOHykO/CVNpUUG+Pcze?=
 =?us-ascii?Q?9ndIZCbVfKWRkS02AAdr/aq0vsUL6+KLSoabrg/VGHa0dX1eq7Ei7y8MmJYe?=
 =?us-ascii?Q?KEwG5v6yYMpHSiajXH+Qu1s/O7NMBMwSM1gurZtTCL61iVE65R3SeICM3T1C?=
 =?us-ascii?Q?Nsgdk3W+cjT0aYatGcgq9hal6FnEuRmQKMorq91XukjBh/jE8kwqMABUe7e9?=
 =?us-ascii?Q?UwWBTCjFrESvCZgjpNel5x+gS/MeQcvFp5gO0yJXQUVtOeb/VbLOdGE8qxvh?=
 =?us-ascii?Q?mePAE2oqyEGW1S7fhuk9GXC6/FUFCw1ESeHfdEskFcrLGBF9mZ6oIFqg0zII?=
 =?us-ascii?Q?5k8sI/XtG9UtNOpyiA0HLlz5rC4Cm2PI3N1Is0Qx2Vl6a4JjYgx3VsdTMcMp?=
 =?us-ascii?Q?d9Dxjn/jQIpve6yD1Uxfn1ntX5a5Jv0AQyZVjTDsJpQLEPNhoV/h/vR0NcRK?=
 =?us-ascii?Q?nFRaYV8McYHUTUtwKeK2pRvIHBBOTayGmmsJnl+Njf6/2HMwdH2MONiwHici?=
 =?us-ascii?Q?QXYidGqw9kOP/Q/VeVgzrFmagkV44HKX3ziXQHdly19zAwt921RdmCrZ2Rjc?=
 =?us-ascii?Q?Af3GhnhoXUmPQFx9cuqwxPait387xN8b9iLHYKmsx4crBWXo0XgIgy1Kd8HU?=
 =?us-ascii?Q?5+4DeS9iu7gUznaA2xwXz6swze9N37AP80BeOFQ6TRvvrIc2+wCILt5+DiJQ?=
 =?us-ascii?Q?7jhMz/LPNFYZkAHVHHQWFzpVwTwCvotqP+XxfN2v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a3e888-567c-4126-ad00-08de27202213
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:00:10.0381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N7gB7lJX1lM+kEnyotIWJ06CqmXHSpygbCGaYfd8NlzGbJ+04r47jfPYIxghmtAzsYagNOpt3kSOIrpd/mJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
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

From: Alice Guo <alice.guo@nxp.com>

mu@27020000 is required for communication with ELE firmware, and
lpuart5 is the standard output device. Both peripherals must be
available before U-Boot relocation. Use bootph-all instead of
bootph-pre-ram so these nodes are retained across all boot phases.

The driver model for watchdog timer is not enabled yet, so disable wdog3
temporarily.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v2:
 - improve the commit log

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 12 ++++++------
 arch/arm/dts/imx8ulp-evk.dts         |  4 ++++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 845fe205925..2782dc7dd75 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -10,16 +10,16 @@
 		compatible = "fsl,imx8ulp-mu";
 		reg = <0 0x27020000 0 0x10000>;
 		status = "okay";
-		bootph-pre-ram;
+		bootph-all;
 	};
 };
 
 &soc {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &per_bridge3 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &per_bridge4 {
@@ -27,15 +27,15 @@
 };
 
 &iomuxc1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_lpuart5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &lpuart5 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &usdhc0 {
diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
index f1c6d933a17..7aec1706382 100644
--- a/arch/arm/dts/imx8ulp-evk.dts
+++ b/arch/arm/dts/imx8ulp-evk.dts
@@ -119,3 +119,7 @@
 		>;
 	};
 };
+
+&wdog3 {
+	status = "disabled";
+};
-- 
2.43.0

