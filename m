Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D4FCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B9B83A3D;
	Mon, 17 Nov 2025 10:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="htywqEli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC9B83B4A; Mon, 17 Nov 2025 10:45:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364D2839AC
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R24Jb1xjY+zuxUgvmpfZ1gzMIxsFCvthOfRpFcrqh8i6iBXgC4DPL33F4KgYJXrbkxWj7DsEW0uPVCVZZIpE17fDbN6Qf8xQigwrt/JwkQ6jP25MrWRB1xX+xIW5nHLHes5Y9R1pCmhIsfGXo1qxhm3vf76PoNMxc4JBL2DFE6/p/WBsYlFrdthxor0/pV0FJ+n8YtTZnSmDGmfeTsc9AYI6WX8E/KNMYHriFPjenQyXrjE2YyowHZXQQbLtZ1bbjaal2P0eQJMzCA/oa5CVdFPop8wdV3WtKiNF+hpx7EAfHrvSD9lIW/Tu4CEmfGHTzHf1/Umkq7BW83fWtd+z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obOF6vaqfZyKG3Z5JGNhqAd2lpBdYESN9qXAYAbkEOU=;
 b=W+3PAlNJQ+mkn29yW1vsTlol49skME+XJe8IT2pFbGnAOYvNDi3cArYiCJUL9Ds8MhP9/vDXjNKEZE4fmxjPil+T90Pj/eOLobKK1kKIdQpolNLFm8xp7yjeACUlqb3wqllu2U5HhPAM9wm79AjrVF6zS0um2QAMbAMQvBumINrsaf2eJQDQfF6whkBFFCcb/Df2iPvYRRxMy738bqA/5oX3V0Q5bRZSrsp9R65w3puukf8CaosN31wlDFTEI1Z147zvw6+8BVDffQxDqsv+enjKk/YyzYJhfWXjOfY01FMDOZ/D4xm+hfhfCAttLZLIPBxlmONgblRIPCZL0r8law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obOF6vaqfZyKG3Z5JGNhqAd2lpBdYESN9qXAYAbkEOU=;
 b=htywqEli68vgoonNc5k5bc9L5AUMtmEn1iDywKvo67QIUg0+UN6hzC5LzKFQ0blEzBjZWifSgxoetP8MqiS3hQwjdQ6C9N6B4lxs5gHRqTK2I+xljoZW5AsM7QGTEj/Ct0AmYi0coT6AwHRcqUSOXh7eRm0uEKkM5crhwerHWr0Nyj/zgbwwVcAxGA4tsCxDb8yB8IMSHAWVac/0HiOZVNSbcD5ZsYyQ70CBpKAj4Wv9ZlrnRFdry6OMcP0yFEsKr2SByrN9AVJsW5I/kpqVPaVrOldYlvHrUiyHxSkLWrW6WZd7fy2eJtsLgBix6i+s6mJO7NJft6GLoPm89+Cy7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7622.eurprd04.prod.outlook.com (2603:10a6:20b:23f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:45:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:45:48 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com
Cc: alice.guo@nxp.com,
	peng.fan@nxp.com,
	lukma@denx.de
Subject: [PATCH v1] arm: dts: imx8ulp: Update device tree to fix boot issue on
 i.MX8ULP EVK
Date: Mon, 17 Nov 2025 17:44:49 +0800
Message-ID: <20251117094449.1109636-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d770fd-500f-45bf-a73c-08de25be1606
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E7c/Tznt8dqOlaLftQEX1fsUg8BUZE9ZeVlCEnY4Rtf6Ivw/evyj0JpIVX/D?=
 =?us-ascii?Q?YAM0av/DBscjcRtVbpJhz1IbG9mdfONYMmDTTED95eFxWF+9CinjdP2TwGdO?=
 =?us-ascii?Q?2KArPUt27sJAgmcnrNqGs2ZP770R6ep9IKV0WzB1zFEu9MKlWJMnSE/Wrlo2?=
 =?us-ascii?Q?/R6IWd+gP9oNOQ1qq/I1MRG5Atx30Wo0O/ksISFTiLRSYBR9WOYFeOJIr3ck?=
 =?us-ascii?Q?SuYO1Yv5rppplSBj2wnAYrIUujqMKs/mi02f6Or8VX9Hmlu6wrGKRgctV/lx?=
 =?us-ascii?Q?ZG81jQH77vFHUJdJ3rgXUSktn/im2ixQnwk9vtPh3BOw5TIPPLoB72paqkHm?=
 =?us-ascii?Q?lpnhWsaEfdT0x63d/+DtJQ28eB5yilI7PYHhrm1iWbgsoFJ643dRls1icYrN?=
 =?us-ascii?Q?VUghxHDKKQuQnbkW+fx08+WhrX/etcIM+Tnc+Rb0AY1INc4ssRROInlCjMdp?=
 =?us-ascii?Q?JrUR0f1eDBDc6iFTtDZRGMYxSIAsOiUoOwEwQ/7nHzI0YhXa0t+rmS1kKP/C?=
 =?us-ascii?Q?3XlWuShLy6z1FNvBM6aKnd6ZbzbExfGBro9nqUqXBXRT4fgCfA8RiBRToAAp?=
 =?us-ascii?Q?R25ddbKnin72vLFMb7EzU6iYBr4wVLFYlN0eezBRbIbSOmZgFqSQwMqkKjaN?=
 =?us-ascii?Q?D90znvSjDgWjnh3eAW2Fq7Cip3fePKM/P6LAFozc68NJqrGaTBZVTX062u+s?=
 =?us-ascii?Q?OMxN2ZaZTAsws9631rCBLHgcnKI3zMELZHgVEw6ALXSuuRhFJgsAiv3Gk99+?=
 =?us-ascii?Q?xgnV6lAnXjHrKvtxyK59gpCj7ZKXWl2FrxNPW0HEifxdhXUCX8wNApIomy5z?=
 =?us-ascii?Q?qdVnxnuPOmknam5UyegH8xkO6mcAiS21URLc3iANbPxBSeUX3s0tkmWcvIZU?=
 =?us-ascii?Q?bD6Qy1IXS9PINRmblzMIHlvCRzEdi5Pawv0gE15q6FvLneXvwidc9MnNjGS6?=
 =?us-ascii?Q?QNgPsxmyfoliV7Y/LFg7k7Cg+W3wcVGMx1zGVSwnxbfsNR+O0gVY/xXrHEMC?=
 =?us-ascii?Q?M60QfvC24qeUZzcK10Jh7k2F6NFizLhiXDU75m/OdIyDI1VtdpoQqIgKoJuW?=
 =?us-ascii?Q?bab8FZrlthISUcGUbAb110KsO8awsdzJNJP9B0gYcGoZP0i2C1XcZDLU/pPf?=
 =?us-ascii?Q?nts32UQBAT0S3x9k4iyIhQkJeMoQrd5AKWZ8ouKn85HvmL0LO+2NfrbaSPEm?=
 =?us-ascii?Q?cnmHHwDvvVqHWCU928MlajVHem5rTifgOJ7DLQApxkr1VmdLrlnpKsKw1QKM?=
 =?us-ascii?Q?MMax1NDeYI/X4+o7fus+PjGtJXGvn+4Unn0iB98RE3qwmbup3yuzwFm+Z9u6?=
 =?us-ascii?Q?SIYj0R5zBqRzCQEAFQNRA7+R5ZuDqkzER3S+7G+aSuZoRhGN+45Sr25WSgUS?=
 =?us-ascii?Q?px+m0jlJHdaXke4ooy7nP3Y26Vgh0ZJsh7BPk2leXHgmIYLRigsSpp+LQ8eJ?=
 =?us-ascii?Q?Wl4fB6RaXdCWyjesSAO7xwfAPa2WAfIFFv6MlThptk/1Ofn4ohXyDRplssPo?=
 =?us-ascii?Q?5g9LZ/gfrZBWeDGJHFXBJCvL9GvBk4ErSXTI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdD5Ge5xmCWixPVwh579EIbavMl/sWkiOxCvBbOhJsRn3xlsN2EDqc0Jf5rC?=
 =?us-ascii?Q?Fe3eS3Lc5IuhNIi+zOEAvqzwHyfDOQjGMR1Miojsf/+cOfsNtrqug5Iehgu2?=
 =?us-ascii?Q?X42/KeqnJ1kQL7CNQmkhfcR3wS7I1l58XBbjZ1aZG90cu6rQG85Ts/BircQG?=
 =?us-ascii?Q?Sx86sA8DMZcICFl6Q1ucHSNxWakRaMhXlJyrJzmNe7oiZoKKDg/b107DAUsG?=
 =?us-ascii?Q?Pf8CMJwsFlVBDtOz6GlkbJv46jh/1oM1+YDT4pdKID3MvK+Bw0LuNtInDYPu?=
 =?us-ascii?Q?Nt3RQOqLxzzOpc0VzrMUG+eLUJ22O8Q6XW7McnVD+ogBeid5YIaiVo4xm853?=
 =?us-ascii?Q?PG7oobaNnz1Uer6rNbVDNmmmFvQ1+WHurirA2zuoMTLET/BgeZsfd7P/yhHv?=
 =?us-ascii?Q?Xcubu/BinDzmUEIMmAftY7GggUEoOtaLe/U4jAPjiLjW1RudsGS2oOmk2Ewe?=
 =?us-ascii?Q?7JSqvNc1Ir+wowZNtKBzFJIB3VKhwKdK+bT/dMT6jdKZ436No31DXxq3hEKI?=
 =?us-ascii?Q?uRPhrL+NHUlCCh0M9r4+1a/H/f9hDiZw4xvqfusmQ4zM6Ow1gqI06q0fBJm+?=
 =?us-ascii?Q?Lv6sLX8N1cVaMOaIBLDpdrIExw1XgMkYFoep1/EFD4FBcvSlKuXgYACMgrjI?=
 =?us-ascii?Q?iGXMKacOjWpVj5QXioP/ITzOcMwsj/NV0Ur6mS0V72Cnf++/VYReOFd+UG97?=
 =?us-ascii?Q?n6JFmAO1RxJO5zW9gppBqzH15+LstKGYFqjF2iO2zM0QUfSl7r+f7FEC43ZS?=
 =?us-ascii?Q?OjnX4xYCQ1tU0Q6MvgXuFoRpk8Ndrw5Fm50nrqKrIMOD/dG43ER5ZpwwrhQi?=
 =?us-ascii?Q?0UYNmNFRnYtKoKAJz6CzZh1OxjItD81uDj0/ELJwuf6GdfjHwe7s8nnrgVT+?=
 =?us-ascii?Q?C9AZWItV7PZl7QttXjzfpcp5AFBD0XSO/Recgfr5t6Q9tISKbPTtA0XxQIpm?=
 =?us-ascii?Q?dzju/c7fCjG9rjF7mAj+jxdu9j+/ZQBS7S/H8GVNPAv/oENYFV7lxu5xXqr9?=
 =?us-ascii?Q?xfDbrHW4i1oeQRQEQhXCl0g0HEfjheSK+lZmNjg3cQcq7Dn2qsI6YN+7vjBl?=
 =?us-ascii?Q?/f9++LWYGow3DE7dI+XScn0GWNs9ktwh9TPK4B7U+M7miO7BtbkFSrAlYxyX?=
 =?us-ascii?Q?cgzDcPf9s8IQ91qEhfOPU64EKeErAvQ4NqG22CZRRqhj70hby4LmWk2IW56F?=
 =?us-ascii?Q?XZByfgKaRwwOUSFvm2VqgCy1+2TuPdL+MUNkoB3+a5KWuFWLMstspyrPp9lw?=
 =?us-ascii?Q?DjHxNv5LXG/Y6uTPCKVX+/iR9/Sr27zP76yqcoJotYG1Ws5XisZslPtUqvqI?=
 =?us-ascii?Q?9T44J+3H68a8OkmdcetEoTB7id8guasT6eiIMOdrqv+DsDOPhZ9hFt3lvxoL?=
 =?us-ascii?Q?HIubvQ4maAaDI6BXd+jgFEG5F5wyHetS/hGV/ALz+tqzuFVHZjwQNQ1r3ym5?=
 =?us-ascii?Q?Rtlyu5ttLEOQF8vVWWL5gIsWuIYnvHcZVM81ccWffc6s+Z3wKF+uk3tNkxjS?=
 =?us-ascii?Q?QRDb3fzHT/L3hI71yPfb/zUQazrFeoPb7+Eo06wbpJvcy1ZHno6vx6gPEYrG?=
 =?us-ascii?Q?EK+tgnA+R9G65how2TVfMKaJ0zMDi8XGNUngAms3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d770fd-500f-45bf-a73c-08de25be1606
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:45:48.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZK4t7ulAfFFrf6d5AK34u61G/Rkk6OtghRgz8O8DkqPO9xXFcebJ+ektkzJaqwZpQiX0RscFscSGqNM/FtPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7622
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

Update imx8ulp-evk-u-boot.dtsi and imx8ulp-evk.dts to resolve boot
issues observed on i.MX8ULP EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 18 +++++++++---------
 arch/arm/dts/imx8ulp-evk.dts         |  4 ++++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 845fe205925..3485e6e3f2d 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -10,38 +10,38 @@
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
-	bootph-pre-ram;
+	bootph-all;
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
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_usdhc0 {
-	bootph-pre-ram;
+	bootph-all;
 };
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

