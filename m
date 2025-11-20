Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D59DCF857B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 11:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B13683F1F;
	Thu, 20 Nov 2025 12:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OarWC9z9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A7A83F2E; Thu, 20 Nov 2025 12:24:05 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877EE83956
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 12:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9EIoulCtrPz9HGwLyoaOiaVpNbQAW3eD4DSBkrc9303fD4F8X0LAb0w/bfitz2tZojGMvHb3nJ9kK5uBDn1S3yFUO381ZZ3lydN+G+aRYu3gguHol5WE+c5khby3BPJ5NvjgLiick8fN2Nvi8UJfTaGtHAbwPXyUzBQUv+aMJK9Gf4cXjRY3mutLe4ZUFdcNtapAHIJxFT3++geXcAbWLdHEEbqgBPVzuucFzQxAnSGUGmEcn2iCLNOtVMStGcBItbp+dmjTaAIss7Ni9IQjo8x68nb1TGjhuD3663mzMclTJ8Uhdo0jviGiLf3XNFdW6b1H3bvE4WTaaFO6eJa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAcHOnmlm0xp/f9Jor2RJcq6zMY70xpoo/46HFmGl14=;
 b=m2NvnAbmZz25EFGPyEtEoIyeGrhFurNQFptPP8m8RbInqV5eKOQGYTyNG3hKXt2QrW26cTXrJJtn3u1NCTAE07mXHjTkOKNMSgmpArgU8/2VbHOX1PSp4iFrEUlAcj2gimphnwOhurPjnJkbaBmuKviAJ7qNc/YjEQ1SovXpQYwWFj2KfDldTLejMIo0FB0lWEu41j+e4jpuN+bu5ld0l/cqTLm5Tr59Rii927zUCUdSJjQyOLX1IK+0vw6EhIbbVUtVUN9qo8XnBOKKpAalQrNEJMPpwRIYn3FrPkVCtELMYNWf/WkTFIWWkZVIUyG6EG0GlVDCsvKF7lsqsAfPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAcHOnmlm0xp/f9Jor2RJcq6zMY70xpoo/46HFmGl14=;
 b=OarWC9z9tfY4TyQ68lPXg6u1+CIWrGechKyZZSKmiNWKo2ARCCqa4ud7eyO8yfS1c3LJQQ93RXJr+9/3ddHFgjKPAdqh9EkL3deEMMctpj9GTiy1gMi5a5ZqG3jtZasxntC3h3fp92r6dca5X8oJ+yq8G+v4gazt8C4fTa2MABwQgpWxGSsdBsl1c+zuWKnZm0IS+1i+IsEqYENGwmx9iOiUDjvSzd25dpzmlUdu4xiC3uwul4MU2+/GgaBEtWPdTlEqN0WyDUkBp3J1CFpLTHYI/UVGx7szbnnEsczW/+Qk7p5a5oZI/Din1KBC1YTqt/ciQkV5wIPeBQqn1L9qhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB11992.eurprd04.prod.outlook.com (2603:10a6:800:2f8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 11:23:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 11:23:58 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com
Cc: alice.guo@nxp.com,
	peng.fan@nxp.com,
	lukma@denx.de
Subject: [PATCH v3 1/2] arm: dts: imx8ulp: Ensure mu@27020000 and lpuart5
 availability during all boot phases
Date: Thu, 20 Nov 2025 19:22:59 +0800
Message-ID: <20251120112300.1242106-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB11992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a68c2-d14b-43a1-bc10-08de28274c06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fmBUEfa7zdoYGTBd+hv3zId5a9q3E+mqhV1PD8XySZ+UoiEJGXUkC/BOpfeD?=
 =?us-ascii?Q?IemRyujwF1HZDZteUmJ5JTYZq9ci92jKkH3+49Fg2m2k8Bbd5GJdcxYA9SBv?=
 =?us-ascii?Q?zQVFpjKnwE2j6NbiekgyGIH2BGJ+nnwvMshlUuO+hsxzqoJIK8ZBthmide+Z?=
 =?us-ascii?Q?mHNy0O1d9aRerM3UICnsPZP2VPZZIWnA1mSdw+02szGlrLjphrHi9dEfSngw?=
 =?us-ascii?Q?CDtSdh09jSaA8ntVucsdAagmb3GlyEVy+eYexinlU5C2lStFwbJrOuTVURyk?=
 =?us-ascii?Q?Qd6rpskcXsR8xRLfCb9bhK8i/5rWk5ON4FFmwJeMHf27j4xWomRqhO7a9nRA?=
 =?us-ascii?Q?GmJfXPRZeT10x88CbtoFoE7KZOL3uaRJmNwHbB5wkV5oWbHMarREVeLwTFDV?=
 =?us-ascii?Q?4Bd6BPwvEUDsCGeXFOGDacTrZvOOb3Wr3vEO46+z0atwQxE2OvCS2TtvsVRb?=
 =?us-ascii?Q?6A2fJOj75mKabbFlYn08PPG4aoUjIrZmacbV1j9AAmQTWFuiQCe4kmWZkBPT?=
 =?us-ascii?Q?kN5s3OMnIefDr/CsXcD/nzvO/4maUtjtoeoBOOiKjNRl5tVOL7zfFICxaJvg?=
 =?us-ascii?Q?I7G6xcSUF752s3yalc+FRIjElkeDJhkWDjF80LfWtWtW29A4Zo1KfGBy79OH?=
 =?us-ascii?Q?QScsrJpuOR46MdOUQuMmKEUY+qD50k1LkL9LNVf1L0CQNemjHmpcOnpryTOX?=
 =?us-ascii?Q?F1wvpcPm7hfs04n0tNC540P7NbK7W3dIgceXHC2iId+S9kYj5Oa18woo/KMv?=
 =?us-ascii?Q?lKcgCtBkNxE/13Ntfsts5I60rHA9ifwQt8r0pFVcyIio77K5z7h6D8q3bB3p?=
 =?us-ascii?Q?5fz0pnR1hz0fhPM8PGh0ZR35cMDro9UTLTkmGIrpMrg/PUZSag4fubSO72BC?=
 =?us-ascii?Q?6HvDYZXfx7/mMv//zKrdZGR5DI3h7EeJl5p/gg+Z86WEEQG9EpQn1bpx+50K?=
 =?us-ascii?Q?PnqxbqMyk7UQ1U//q5GbSFEhmE6Hxs6eLQkHegHh/fgwfkG/dNIhGxpcoDMp?=
 =?us-ascii?Q?WGJEi/+96wTvl/csXAEe1ANtgAnJ00VyC5yOPBz/EYPHCQKQsrRBBiOJRmD5?=
 =?us-ascii?Q?XIT+91ByD4bST4mIB1/E3wPOTKjDwgGW/kfn7V6n1RdbSBYMqb5yZH6VShbO?=
 =?us-ascii?Q?Dr6qe7cttn7zaeFPq8LH3DlE9kmH4jkd9F3dug7Lpf1Fz5aiMzPHJxdd556z?=
 =?us-ascii?Q?DaPUwpmWxOCbh4AwFMKnsN88cSMJQ3DIYti0x8AD9pp/874zDbVrtb1rEdNf?=
 =?us-ascii?Q?GlkzVTq6kl9gkEUdILMomBM3VuVl4vioOG/X1IFyJIjifnHwfPDrsKVcSlPC?=
 =?us-ascii?Q?dPsxtvIPNTTrYImOUJMccASYjxewx8eIYs+nZv5i+Pod0xK/8Bn0Uprp/1xZ?=
 =?us-ascii?Q?lUh5PAWVBjcHZFi+Finfm4VqNKLv0RFNHoTatNVFQ+WgsiHBhpMwhU7UjgpW?=
 =?us-ascii?Q?vMGW5YlC7L7iRYVFDrJOXyvV8hHDE6Isf2XtvUUeh5dDTaNhXd3U02YmplG4?=
 =?us-ascii?Q?hSD/+kHAooCKWy17MKU27eSEEt697rUqWoP8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gcTVOYxo5F0MhVBrk+N7cn4xkBO7EbksbZsaOVFymNJqZt5lFDmTEx3KqBr?=
 =?us-ascii?Q?zMzgojp1bJTMiTOk4wio8B1Lb7zQboSDlv3pB6aDSx3mp/L18dRwfB40qDZ2?=
 =?us-ascii?Q?Rvz21VDpxF+QEn531TVC581FpK2tirWBrREyNkYkEIrET5io6v2bKv0fTP0c?=
 =?us-ascii?Q?S2179snZsKjKp6ieoY7R8QsOG+ZN7iIqRtYhPKkskoHroBkRmKMI8ewns4As?=
 =?us-ascii?Q?f7QyFvtbaZ6RR9n7ujuwNHDcihTRJaemoHK8M3fh1unYejwHgJS/z9TN+GWJ?=
 =?us-ascii?Q?upmtuEeNhau9JA0ujGP4zlVb74ph47ij4I8uau5EONsa0icAg/uiekbGc3Cm?=
 =?us-ascii?Q?0mcZ6olHAfPKnNcsF40b8AsEG7n/k3J1dxDHJUM8wEOTgqjsvR9YXNLEFNmh?=
 =?us-ascii?Q?ZLRH3iVtea70l2dnWbl7ZI8efjjZnIpG6grl8AUC8eJtUueGKPCSlxhUAbYJ?=
 =?us-ascii?Q?vYbarBwv3sqiYfRaDsFj1hNxJI2z7YmnCfIEE0pYIrhio017Awfkt7JT2rtl?=
 =?us-ascii?Q?6uj7oloWc6U116znpHSiADG48fR2fHhqyw484zFvUxo/lxm7R4gt/OITkxlA?=
 =?us-ascii?Q?G5VRo6gaBIEkjVePINZKek9a7WkrhTVfEQM0+wFqKpfyu7+JYYv9mDbXQiS2?=
 =?us-ascii?Q?2Gr2xaTeLLmkZYR95KIifq3++Em+OSDs6bftH4HcuvMRyv6zXWwr1J3kR9Qs?=
 =?us-ascii?Q?IeM9C4/QB13rjS7U4RkEBtOmn4sQz27d/9uZvSbGwliMjk+kKyX2l9/kJMgy?=
 =?us-ascii?Q?Q6ZIuSpO/DW9tydqlP7hydU/0u8rKUWQxpiCo4L1f9Qhl7CLGhwjHLLOuZRU?=
 =?us-ascii?Q?Pc5R5h4PBwz+2lQKboWSL/diGFgB/1vRKdug1RxAJKuZLuHxlLqNWC37ayxG?=
 =?us-ascii?Q?Euoujd6CqrmBzM3c561SIlKtp6ClGRsz2D8/PIEynKeixBBu5fMopFXotpZ1?=
 =?us-ascii?Q?NyQEZRavZuXw0RT0yLs8/Z5Cy4MdU3ss9wLCMTqXndkfjwaWt7Z/eGgJjmZM?=
 =?us-ascii?Q?M1VXTq2v6tbbBMGxI2dgfwaPPDWvfoPG/F1LL+mx/c0Zef0dXbV2+W7fJajL?=
 =?us-ascii?Q?on1QefGk0sJQERqNN6EHNb0oh+sPixLwyjRIDbZk1Ru19Ct5jFHL9R5h+uET?=
 =?us-ascii?Q?Jy7n2MTXG3qnEtNCgJBZjMq5fJ0ab3dPYE68C3aJzbzVgg1XNj/vexIuj0mu?=
 =?us-ascii?Q?sYAqywmNUPmCvZngRae3QpVw49cf+SChicltaZN1clbVIKrgBwoRqqun1p1/?=
 =?us-ascii?Q?siU+zMmE0DDnPJe6egn7nlhaM2ErWC5Vod5/MXiJ8KM95ZCa9V5Pdh8Jm938?=
 =?us-ascii?Q?gZ36LgIuqqK3P7qEFY+/INKTY+2a3dZYncDOYceljdqZsVsyT/YR4GdDn+0s?=
 =?us-ascii?Q?jYFI04720CsZNNGKzc+zTIKvCmN8j5LMyvYesjDJ99iSexgTQLXrjwKH6KCW?=
 =?us-ascii?Q?m0QJhDi9owRzoZ6RrqEGs0SdkVD/tdbF0R/eBvaOZwJlIqu3xxqExwsXVR2y?=
 =?us-ascii?Q?/4P5ryYCcBhsT3Nt26ln8QDQrOATXwJNohE91gpszHzYCx+wVoPbGbjxw3zq?=
 =?us-ascii?Q?B96sPOd0CtwgHfpHNuCx0gbqQ+91VSZwY/Wce3dW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a68c2-d14b-43a1-bc10-08de28274c06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:23:58.2783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7bz5MaRHhOfbFbVz4zys1WFAbkWa0iCENqn9WA/+iomTgOInbasznIdB/mO31W8J2u5H7DxBMjz2PScXdU7VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11992
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v2:
 - improve the commit log

Changes for v3:
 - split the changes into 2 patches

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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
-- 
2.43.0

