Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30434C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE38B80BAD;
	Tue, 18 Feb 2025 13:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y+AT3Xwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FB180BAD; Tue, 18 Feb 2025 13:07:23 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365CE80EC0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Onj+YhT+yZWH0fVV2YT6yID4HOgSToNqsKCYjHCDFco9wqUAa0wGxWL4d1Lnbws8Lcf0ooQ1FmGRTQUMv1z/u6Wcw1gsn74vPqOpJ5cura3g7DWXW8sb0PHP2sCVm5SluLdW/KDRLTpQQeDVkS8j84LMC/Ae3ONkMGE/9LPxJzmwqutKhmKiA/soeVX6ZGl+G6fIKQMhE0AbK3EJ3M6vCEiycM++6loV14H/J/giGVS6+teqUTgsWcYdh+ZQRp/fh7pCu0PNuSFLPvh5VEtdVoNMY0P37EUcn1Arcv5/VJJFTAIEmMOUGEkJCBL0p7Fqig1ayrr2c+bGnWF423FRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9Re7CEe+GjzJfEMll2pCcun7IGKBfSPUj0YAgOuA1o=;
 b=FEXPwPEcqmdSciCc/anjcXOruO80MAfafOGI1wovK7O5gUG8mvaXDkJpT4g16kTAEHgBkxnYPc4A5njOfqarmjouanqo0L+I/t2xWYDf6BHOMAFSVF3Eqvc4tF6kdRzLkJSbgCyAU/I4iigXgBuH4nzdagT2x+IVRmSpzR9EVbCdN1D4Lzx14SnY6z8BuC63x2aniYPaivo4lztZleFKUE3l4yFPNfa9R6OooiIY8ZDbXMT5LqzDtTkmwiPzvEjlh6PNawmqMf6jCA5vmEigXpbnmkTmswXQkAvocNRDGJhqglA2tole8MlVoMzmYWSfbStWegoUhCvAbyqo89apjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9Re7CEe+GjzJfEMll2pCcun7IGKBfSPUj0YAgOuA1o=;
 b=Y+AT3XwnAqUeNAHk5bhAGTASfdIsMgIzwp0vF+HGIOC1wpAZ9tNvEHNTORAUhMCyLEAxgw8eMlbn970bc+t9O4eUg09+gK/e3wTdOgtISDSJeWT5+4HAXgVFsbGDr8svawnGhBeUKowriyvGO2dKnMBSoofTGcflLbiLyRbzM1zDDAhH4NoZ7szRgdPNN7Iz0bqwx1GJ1OuoTJiGkx4LBxENVfRJwHnFgvgiXe9LJgmgut8q9bmMBd3ExkKJFD80iNR1jtr+/Bpe2f7z3V3AvMRTLc9OQizNk6sE+PX2mYo7IFix3w0PNN3XP1YdL5T9xk+KFz28zTybpduvbjby/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:07:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:07:18 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 03/20] pinctrl: nxp: add a pin controller driver based on
 SCMI pin control protocol
Date: Tue, 18 Feb 2025 20:05:40 +0800
Message-ID: <20250218120559.451678-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ef285e-d0e3-49e9-ae2d-08dd5014ca3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c8B8u/sx6e/U13V+5qJCD5r7u1hCgXrvvLpWAPVfAQpW5dyBlVrtavS+8VSo?=
 =?us-ascii?Q?7Mx+ulpTWjxMayMLIdZ+HsdOkL6XUludlYl+StcQPPGgq0i7bfg5ZBFM+8su?=
 =?us-ascii?Q?NA4L+Va7cLtzwQd3cMEdjRsSAE2diZNLALjNeyunN7SdHgg+aXppLFzkGe8E?=
 =?us-ascii?Q?HJcNUtCsx7RoGGgNH7Ozwpa4dsyjCa4eJVB/UEod/jfrWzWccHFLSewoOA1y?=
 =?us-ascii?Q?DqCS8UEf99M3oCWybiYug8BEB13kTZHwCA2PJZtcIWhwpoR2+ciM9cDYlRxy?=
 =?us-ascii?Q?JslwkwYcmlkEgksOlOjpdB/dILuOzJhkAhUKuWSlHubNNsmHF5fD42r+la9G?=
 =?us-ascii?Q?T12devIwZVFwvDLKhhq9gRK5ujgYT2q6JMO8PnFTGMRn24zHl0aahMmzyRaE?=
 =?us-ascii?Q?5dTVBWS1v1AYem6g6N34prGTlyvdAoV5ScCVtYcmHoxqtomyqTwsiUcDcnK1?=
 =?us-ascii?Q?g8sMXAfMFugJjW6TPD+cSgih5sNEcFKLayIqVZLuwdcOl70ArggaBhm08fHR?=
 =?us-ascii?Q?26lHbJ+nCHfy7MeqEZ0WspdaXV3eI+s0LSjA4lv1/s1Hrf4S1eBuOgSVrlW0?=
 =?us-ascii?Q?ozLbTjeYZ9GA2wK7yKiT/Mb8tTDM0tAgoF2N0WMmcFx/BbGeps4Bjkp5r/p6?=
 =?us-ascii?Q?uep724WNic9ljrlLo9O2EFp/qnErR3Br3WohXQR3Sr1/hMe2CqnUdiSktcQL?=
 =?us-ascii?Q?EbF8JkMCQqm/Xwdlplzfdi9ggOx6D8JiCBpCkIxwJrurC91i/MD5DJIWSqfJ?=
 =?us-ascii?Q?FTFMUasnNAk58AaZ33YHamqQ6lRVlR/3CC5ujZQcrgIfkUAAmPNAdIgOSszm?=
 =?us-ascii?Q?0OWEsylcaymMihyjq81XS+ssz8DxKwbrv9diK2YaYTSdMwzEmZoJC6Xv6qA4?=
 =?us-ascii?Q?qXcW3bsSVw3DHwWff2eXumrJvcof73BZ0+zpJpAb2i3eKiJ8MqHC6XfyAbuu?=
 =?us-ascii?Q?j9C8WX18+TO0+IA5oEzyD6WdXsucY1ebFQKwvDm1X98SkSGG5V97CMsz+ofC?=
 =?us-ascii?Q?d5Y/RcVJwR5PS+ljnLSqMB7lK9IsygMo0JHYQZj0P14Fkcn8Mcio0nQCQaU7?=
 =?us-ascii?Q?mm0P/HVco7zQPMh4lqYdIrS4zn8xmhzbPkAh4MZFApv7I8cUwW8pNkn5z839?=
 =?us-ascii?Q?jbc7/Tax0dSvhGmCJ2Y9c0XfSuCOrSPyLCmklgMFyskcnBFrdLs8zxfEwyek?=
 =?us-ascii?Q?xudgW7F1nB+yC+0v5zc2pRJbmZ0GWZ96P87ubIvzsVZN/gny9XWW8sGblFmr?=
 =?us-ascii?Q?iCmJ+QZeDXm8NCX7ful2BSIdDneBfCWzxtrMiLEM64upyIe0YzmMFo5jrdOA?=
 =?us-ascii?Q?bEvVer2A7wq78HMs+ucSLu7HnbYCNAtZ33pXgtDYKwu9AgPRE7H0RrJOdFUJ?=
 =?us-ascii?Q?/6mLhnF1GCcQ4ETzvkL4VRntroo+lBj325OGdz4lUC4vqk7ut0TrgLSEkNKQ?=
 =?us-ascii?Q?+ni02yA8tIaUUg3BTY0fij5JJ5edTlmM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGtwRGnUuPMNlFGnWQZTwPNfl1TejxfQIPzAwSwtHZnrzUdMA0yw19G4BIye?=
 =?us-ascii?Q?Uz5NIurK74VcwO/G15zn2a4nhyeLGOi17T6RZJbSehTPqGj3PiPc6MsbSkeJ?=
 =?us-ascii?Q?CKin6qMyOkMog9vDJWNWd0jwCqeoXAYYqE1MROS6cMkf6H4IPP0GMenWGf+x?=
 =?us-ascii?Q?nct7jTYJoGdfrwqRmUHHt9S4uK6/s2AJgX79XFhsq2mu4yA1/0n7rkEUQeS7?=
 =?us-ascii?Q?VWi+GR3AUAKbc9YyWX+vxTphBytz9b/SLmF2pNNhdeqSNbIhXxw3A9+av29N?=
 =?us-ascii?Q?yOMYApk/StYn+nC9l+7c6lebUbVWjIriMIlV4K3tmVSaKn+6gkuaRvfitE4S?=
 =?us-ascii?Q?cd0Dbes+cFS1m8bRcVOpnIYlyMOi4Fw1nfxKJny7uPI/+uM37LyV65lxnU+m?=
 =?us-ascii?Q?wheseKL8SCPxvQSPFIYwTvmnRaeD52u/8lDD8GPJvOv0CcstnqkmEYHW2lT2?=
 =?us-ascii?Q?LvrOnM0a0TIKBgQ1mG5ZgySaGa3MOXFgUDHATIeZ+hM/Vj/ogxPAoBXZv4Oy?=
 =?us-ascii?Q?lxtu1qqxYgxpFMKN7cz2H59RwtFbuOPWRHCyycy6UGz5VN1gTH6IBRSEMr4n?=
 =?us-ascii?Q?vsMhf8+R9IFxizi0rrbZcFXhua0khNwvqT+Ien58JKC+VZKnfAdg7O4Jn40s?=
 =?us-ascii?Q?hUJ1PCzyE9DnayhI04Hgvw1kGKWdtOz/x5ON+5/YZS4Gkv4wJug03c3I1vOV?=
 =?us-ascii?Q?c+sNUOd7Liwgu6oNitEopoXnomQXpx5p0+WqQS5+QMpsTtk4r/WymNnXml+S?=
 =?us-ascii?Q?wPlAUqo3rQPqRcTXuHmAuOLwoti8pmN0hZknS6+RcAXHB9odNnMvf70ZCu4Q?=
 =?us-ascii?Q?dif2ap0rIjnm326mHmBsLnrgYatydtdwFt7Are1yR6ekc2mwdTKbjlyOgzn7?=
 =?us-ascii?Q?jOepBY0p31hXWH/aMZ484fm7vcaXllPgZvKHo5JPFX4k2KEaZqCY/HxbATpv?=
 =?us-ascii?Q?KfO0xcqjMP0+SSFe1ut8o6QHGifLJrqfghFT3R6bFC+nZT4X8yavFqGo8Xlj?=
 =?us-ascii?Q?4vgw+Ceacuq87N/O0NoGMHpBEXguyk2MUXYGPLyoZqP7K6WpEhYnoC0WhpIE?=
 =?us-ascii?Q?tvq4DaV7+2COO2hu9COvboD5SjIs/4BYS1/qy3+QkoC6FvP0EMBWbvxKnDNa?=
 =?us-ascii?Q?gLZtRsqpy26YErwk42Z76N9Zdf6sOWxhdQq1EyPuua2zaOBEYrU/rGXG0jlO?=
 =?us-ascii?Q?oCqWyWaq92DFLY/RD3RhPJljZ+mTcv1MbboWD7+8AhP65uUXb1kiMsyjFdeZ?=
 =?us-ascii?Q?/pXurQir2Q5DFziK2qTg2nNfb4jQSYMvq0+BvN0WsY5ykYWQxmhfJT1eF8x1?=
 =?us-ascii?Q?RAo+6kZ9w/595W6fVTOIX85vXeCBGSJPQ7jwo+eVKuLUqvqceuIaFrEFUEAA?=
 =?us-ascii?Q?Y3F1SnAgwFqbTDMSlEt9ciJPNctH8nwH6WfPIYf2BVv8FGq2AHZ1v67Mxy9J?=
 =?us-ascii?Q?eNCi+c1Md/Kql0lf8s0qLrLgrt15Zw3H/pMvHIp/Sg6namaXXL+dvSfdX4oU?=
 =?us-ascii?Q?GalnsoY917Xlb4SqfdHP2ZP+MERoBalyCO8x8VlJ/YXk0CueqyGd/JDLMsNE?=
 =?us-ascii?Q?7OtymEphm4GvioPurbaOB8Yyweyv5Q+QqPs6k/SL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef285e-d0e3-49e9-ae2d-08dd5014ca3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:07:18.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptgm0zXLpZi8AarLm2tc3JIAxj1HigtIgshjMjqvPyF8jRBCjQMt8EE3k0Cz+ii2s9hylXpsiSip9gWi+HpP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
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

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig        |  13 +++
 drivers/pinctrl/nxp/Makefile       |   1 +
 drivers/pinctrl/nxp/pinctrl-scmi.c | 143 +++++++++++++++++++++++++++++
 include/scmi_protocols.h           |  36 ++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-scmi.c

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d5..84d9a3641ff 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e5..9ef675d18c6 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 00000000000..4a791b7e951
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX93	0x360
+#define DAISY_OFFSET_IMX95	0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status != 0) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36b..279ebbad440 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.43.0

