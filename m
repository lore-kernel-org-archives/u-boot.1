Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551BDF436A8
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 14:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883B28428C;
	Fri, 17 Apr 2026 16:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lrA+I+Za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735C08428C; Fri, 17 Apr 2026 16:13:28 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB3F8427F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 16:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbJBwTwfwbY/QC7Uu5ZniP1cNZJ6A4aGCAGzmEXdvyQIv0DeStKnKpIgfQV3cqdsHbkoFbcCX/UB1wkkRGTHSZ0yq3zkb0rSaoMmZJiFiFLG+zZaN/GJMZDWDv6Z+tK1rFftP/J0VtFy4KIH29X3BnQmilqjdnBPvBUeHQt7KJJizOEe+rbuNKUrGN+UuFB0Ks5hZj87LlQlXTaZ++FTp0ez2l3Rh6x3xye3OPG7ovcBdR/4/QyPsAwSAeuwHOel+1I0UyYbMu0DoKM9D3Z8HzVRhCCxyb5K5Et3LVZVPihop0mleWtUx+th6FeyMsjmIGr2RvRNIvqDCob8AgUoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB67aQIABK0tw9vyjogPj+hrapueIWnoKu1hy+7soEs=;
 b=RJUpGMkWJeF4+mVKJBnYje/a+nOX+U14JYon/885c2Nv4jrvrz+R3POLwiG1R4oXNCTWDXndM0lLjz7SypIFFjdqQfMTH+4V1JI6dbhABwW9I5pIxXpnJbpWaBKgYNMUGk2Y8t4TnByL7EiW/e5Lk1MesKtP8hLrShNHrQjcyfdlCqFPJkC50uTs2W6zV9u2aymk/pmVYBRZPiyw5QSTzpbdWElnU9MW26s7QAZ5qdmp/AvbCM5wBZj5k+kQlHkPvGzmUVggkNEppi0oV6hQvPsg/JsPxELsmy8/6lbkcekUQWTIT7hd/pAB2lF0+ZNcBoVtjFSKZkpGJBl2+g9l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB67aQIABK0tw9vyjogPj+hrapueIWnoKu1hy+7soEs=;
 b=lrA+I+Za4osrWdNPlFlJAPuq8RJC71wlnTzIXhf081M6ANtFP2yn1IZ+UBJ6r6Y+6NamHQD6Bj22sXUjqYWQeVnQl0U+w+AapRdf1pOrvwJW1pwPwJUOC8ud0+N49KB7VcpG+PEWe/z4VV9bHx1N2GVizXUIdUeMB/ZzkE7+AhvI/Ahf/Xp4V6vslpVL0D96Gs6EAgOt8BfOybB1mzydYjdgSMNg5vWz+1kHYNLmKZt1ESKAuZTuIa7i7S0EhTBdCgN11ZU24qhMaMwllaXbQArgsyC5QTR4I3QEJA7pnX1wrmFtKzzU88Jt7Mc5AU0Asm//taWruT302trHmO0tdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by GVXPR04MB12128.eurprd04.prod.outlook.com (2603:10a6:150:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:13:25 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:13:25 +0000
From: Ye Li <ye.li@nxp.com>
To: peng.fan@nxp.com,
	peng.fan@oss.nxp.com,
	u-boot@lists.denx.de
Cc: ye.li@oss.nxp.com,
	uboot-imx@nxp.com,
	matt@traverse.com.au
Subject: [PATCH 4/4] arm: dts: fsl-ls1088a: Enable USB nodes
Date: Fri, 17 Apr 2026 22:15:29 +0800
Message-Id: <20260417141529.1490622-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260417141529.1490622-1-ye.li@nxp.com>
References: <20260417141529.1490622-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0084.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::8) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|GVXPR04MB12128:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ee5905-ae0a-40b3-83e4-08de9c8b7d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|42112799006|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: PGFsk0A/5RmI9MkJFF9Boa9rNVDhSdHVK9AzrZKeDuKgtlAXeCDOsAacKV8ESBrWRF2wVMNgInsxu6C/xffqsJhjdRos3TR+wx0t0zlj2JYHkUgFktteN3yV7G9slAYJXlCIOp9YHDAD5g0FzOROl/Q7RC+MEAzFFGkkZQr2Q7XVia3bSHzWam0MWCuFH7FoADJ+YIPBl/4Ws2f3KVYuyRURl2A48EMSp7yZ9y777ldIM5ycYfv8j6Zb3sfcLYvE88wL0YA0S/N9l6isV0qaexVm1C+PdGvb5Ilap4h6TzQpV71Fi0JbsGDXSce+OZAof8KindvQH+6pkvOyeGhiWbQdkyA1UxXhyuYcM3UslNPeEb0+nemauERz/SWV5RsVjgY7eM2PJ9pHxqq/0WY3fhyMtZSt0HOFass/3WpKCLeWWSwOkMcxRUWv3XJXgzo30NrX04QOZngW32H1kvg3tnLlQz2pmAqPuARLPiBuvbsdZeQnj27fRNrjH6/R8W07TTEbOCbmkApbGdL4Zbwa1Sxv9OPwLhEqYaWk53DQ5RH18PTfsvkw5vMSfTJwt2wg7/QNcZMO2krPbmDydM2XMGP+hbcbRAKPxAjGOnY0oKXP4kziEKM1xAugRi6899mQNkdH3n1Y3IoP9i+4VRenOMi6xGwfb+koSgrbUbsmJdisaWgkIbqzo7icCncPOP0GbLVrtWE8WTQXhlgvKF1krTvbmenVzrdL6xw4RATGNGeJB6Ms6ofZ1bft9+QaLARKNCL3lwG69kp+aOQMHowctDGaBWxO6BxD/crxjAOO97o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(42112799006)(22082099003)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?68P2ZnqKoJSWMLJ0LIBiVmMvfKJb0C8kjIcW7K5NJCQU4Jhexg8OawM/cvM2?=
 =?us-ascii?Q?kIgV9bWllIx/dSakhR2RmR0PAWsfiVmh4zfl95S+iHEtNBqJ8WZGyJ9ULmrI?=
 =?us-ascii?Q?uNOlAelwdL4FGJLIWwm58jRlEFHP/SPmrpJQJA5Cf6XgeI3yujkw1RxbOC7a?=
 =?us-ascii?Q?9puSR+NfG2l+0mTFYB71qCGeQjghU9UhgZFwQWNuL15/hKXZlImjOrco2vSV?=
 =?us-ascii?Q?EGi36mwwkHMWMVEbRhTqbOzQMtmyUTcecbtRGrZUktat6gl/PjCmmeDC0Oky?=
 =?us-ascii?Q?7y3tMFsZd3pL7+kVgm+mkTJCvVXIjniJbpeVXICi7XdLEaTCNap40QN9C/XN?=
 =?us-ascii?Q?PN/p1O7mnWphiiHupUkEdAoO3pfrfIU7pntmaZf0CAMlFzTTXAZ1X5T9/bXg?=
 =?us-ascii?Q?8Yj2UTzY+6cI+8y1er3SO77es4m1tZ2qiwBawHSNjRwpmnIHgG2cV4bs9xmz?=
 =?us-ascii?Q?T38NP1p+a0l2gCUYVpWu7dlh8BWHFxLu/r3RmT/XEHJ1Vcsim1oJltIcaurn?=
 =?us-ascii?Q?m6IDOH3EOiU/2iidUXkr1/v2OUcpj3BEWhcvu4mAUQBvhaInDhQt/T+YPv/J?=
 =?us-ascii?Q?0seBa2Z/azmg7jWmmW3S0ffEqio/gezHqgZt99WVYOic67OHPSpTECKUn+8o?=
 =?us-ascii?Q?up78jknj+alTfxo3Vn7hLWUxcS0DJTVsYsMOwB9AqZ21/wn7fq3XoeWIBxtE?=
 =?us-ascii?Q?8imydmwqosPMZvZe0LWtoKSdaMeRDl4Tdnq/mVJ88zBYnCiNZS7jDaQQw2Jc?=
 =?us-ascii?Q?imfbnwZ+/SKKqHO7zCVYw6FpkGAr0dUuGltNYIKi2grBP/zEF78tJluqgL3i?=
 =?us-ascii?Q?UvO+dh1lUYa5DtPOMszqh4fY9R/lxtkf2Nz3VNSZSLJJPdvbinUkKBKTQGTD?=
 =?us-ascii?Q?AnH0o1gatJiZpSrmab4sSCLl2ck/bzeMOi+NfllZjC4gJWCUBJvba6gqUwfM?=
 =?us-ascii?Q?FzN2btt+YVgc2DnK1YRGYULRP5LM5cLoodE8XPPJu/NF18UzphBbMuvmur05?=
 =?us-ascii?Q?v+KbDHjxYKpsfX66V8lmQiuMGLINRsGfE74fCPOnXoVjasCnIiJroYPZzqH6?=
 =?us-ascii?Q?PPHYlkMqDgl++vQF8w4+NiHW81xE0UyNoEyrzICCCA8vzArINoslYVZCZWgh?=
 =?us-ascii?Q?yf3wxhAuG5ZS9xWuiKGEjLS+dAP8czNP2Pk99OzC24u6MWLndqlA11z+uF7J?=
 =?us-ascii?Q?T8D7ek9DEbV2GFZrfcvD0QshQsU01/UQ/Mv+rjyk9AqvZAVoMUBWQmXeNfTu?=
 =?us-ascii?Q?TZ1pZ1T8SPb6ZNEUHi59HXIsulQ9o/fg4VRqVdF7FtUQzh0oo5xyesYtoZcI?=
 =?us-ascii?Q?Sh3lqQMPn9zWe5TML5ZM3eryLY/MuIwkgDdJ6Xn74ob5iUvVj9m4Y8cWa2I6?=
 =?us-ascii?Q?2iym9y1jW9GaWWM5w0bvYonARMwVS6WgGsGlOWG8JBS/ClwDPeDOX4jJvwAq?=
 =?us-ascii?Q?lfsbib67SEvaBuza7qdqCHdkEHMtLAvukqjVKdNpQQk/8rGXJ3uSFSlYxYPM?=
 =?us-ascii?Q?DjBitdc+49SPdHONN+f1KolBcEGZZU+rBNd4qZsmr+x8iKHnlPfcOII+tdu7?=
 =?us-ascii?Q?2z1Zbth/ZZKi2nna2s/ai9UjYJg3v4WXRFvmOvS9jEOhjNUdrsBkIko/9ZDj?=
 =?us-ascii?Q?EfV6PGcmkotLzbPoYD/gJiwxFTmenj4D+wYVcz6BYIO9oqVM3YtpuRXFCLH7?=
 =?us-ascii?Q?8shzup4kdRM9wxnAgD5t47wlxD/wWdlvP9YBwpLSc0yM2MY6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ee5905-ae0a-40b3-83e4-08de9c8b7d25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 14:13:25.0489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0xViD8V1yhjKI9H2bAEQCTEiWyJ5T15i+wHUhgvMo8yyxbkkdsWzPNHwcoIeUp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12128
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

Enable USB nodes in -u-boot.dtsi. After sync dts with kernel, USB
nodes status are set to disabled. So "usb start" does not work on
ls1088ardb and ls1088aqds.

Fixes: 10ff7e6b043b ("arm: dts: fsl-ls1088a: sync usb controller nodes with Linux")
Signed-off-by: Ye Li <ye.li@nxp.com>
Tested-by: Wei Lu <w.lu@nxp.com>
---
 arch/arm/dts/fsl-ls1088a-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/fsl-ls1088a-u-boot.dtsi b/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
index e2755740e5d..8ae45f6a638 100644
--- a/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
+++ b/arch/arm/dts/fsl-ls1088a-u-boot.dtsi
@@ -55,10 +55,12 @@
 
 &usb0 {
 	compatible = "fsl,layerscape-dwc3", "snps,dwc3";
+	status = "okay";
 };
 
 &usb1 {
 	compatible = "fsl,layerscape-dwc3", "snps,dwc3";
+	status = "okay";
 };
 
 &esdhc {
-- 
2.37.1

