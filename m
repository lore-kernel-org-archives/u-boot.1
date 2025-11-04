Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2519CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8D1835FE;
	Tue,  4 Nov 2025 16:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KYxSFB/e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61B78003E; Tue,  4 Nov 2025 16:06:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 416758389A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu6g1AR+VEe7VlvnFeQfBNeGuNiUaHHlTAccnBqokuxzW7c7uUKT6jS8DR2uTydU1yKaluTvxV2wd8kwOOGDGL5Ut549ABbmuL7o8SBJscxMsmfw5D0axNQy8PruGqbrjxQU9NZbY5XBtr9llDnTlZFMUnwEUKQzDjblrXf/lawD7v6GIub6bI5cDhJgneCzCB2/Wcy+DXp6DKjeXyWclFEgrlgu6Y1b9fGbBkVXQ2/RCXK5ON9CgnLbea9hndQJ9dSNpiHJt/7qx16lzfPB7T111ZREmDbnqjp6UMaDct0bqRfUSn3XHR9QxZ6WuCh/DIpEfKa3RNUMFIkE8JPbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GNemp7tQ+AYtZb5kTiazVs9NuH/RhlhjRYF3xoQ0HU=;
 b=mOGPynWOtAgRqf11QyUk9rMBtk3Ao10EWwpUsJSetYOfuDiB21aPbm8V5dZRrp7xnhivC6VPxrZRlu2m4ytiYL3Qhv2ruZqNIA2poQDmJgUtejzhJ5iFGeQwPuKakqLO7lnakGrQar5kh1zOidMtX+GJTobH/7e7WAkjGhRfW6KQsM1kZp3Vczbaz7+aSMHYEMyoIdx6AOU3tMWSwHTXaeBiAEHwk9+Oa2bvFMk//U8He4nKXUvTvu6IbcTSSXAJ19+toj/KAVo6mStFKVLVV713bJDZLpNQkvEgzCyXELmYWGHDmRNm3KuGI3H4W+mLlUv2haArnPeU1AbqFb9dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GNemp7tQ+AYtZb5kTiazVs9NuH/RhlhjRYF3xoQ0HU=;
 b=KYxSFB/e6AONnas4i7cBNKc9xjCVAPXtWrF+FfGwhsrgQiMBynP+4SHgL2JFVoRLcSsWf6qoavA0vW7T02c06H2/NR02t3duIEjZPJ9qlh+3MiLGcE2ZOrufhcyb9803bmmbDMOtPJr+IS4EEC/qOdbFWA8A2criBul/oWcQLgPiuC5ybklvZzXQ3ZAFSpq7mEqYMsujWMbJWz44rffY3KZJP/L3dQD5Xz6mivjG7oD8ohv+0u+ousm626ubcdjZZMHWlKaZxotEKkdN0IgcKzx4qiNKKk74QNImqV7ePxszWmg77L5+54ataSlqr3LqFpFh7T0S44hcYUzd3TY1mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 15:06:12 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:06:12 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 3/3] imx95_evk: Add basic support for iMX95 15x15 EVK
Date: Tue,  4 Nov 2025 23:05:37 +0800
Message-Id: <20251104150537.1167930-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251104150537.1167930-1-ye.li@nxp.com>
References: <20251104150537.1167930-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA3PR04MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4debdb06-6cf9-4add-486b-08de1bb3b103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|42112799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4HRyJfrp9La7s3aZg04XDLqViGB08KMCG9XwH3PFBZAGFO9Xt5p/K1ESOOrV?=
 =?us-ascii?Q?YDEQHR4YntUzQLySqrqbK2mjQNz3TJdYL8nebwC80vfv4n0RBfP5HSEGO+lE?=
 =?us-ascii?Q?YO3bO7wHT1Lbw35wfhcTs014uij58L/kPggU9vhgRf6BegcgMcqLSGE2XHIS?=
 =?us-ascii?Q?RIxyFBDMQ+/kDHerV3o9IGA6+wEugrIIsy63dI/ykZ+wnv0nVoLDfDJ385tk?=
 =?us-ascii?Q?3/rE+GZ/f1WOyAFCOspx+c0jEp+069TZ7XSJvyTtLr1R/OTO+oYOHyfPV/Yx?=
 =?us-ascii?Q?KddoEvYvftqaTAl5KlPAEVWCcI7GA7fbBPio3VHZOt5C90z6MrGafSsXWyvF?=
 =?us-ascii?Q?wLM7eP74gSZUwcm3KRDtQGMxAb2GAq19JYsplpygLcPPz9zIcCB5Kdlr4f7U?=
 =?us-ascii?Q?gkJEEIjvzxUsFhZ/x4pA3ZhoMdblEfVTIG+Ho2oUsoykv3jgJBuQOD26uDvh?=
 =?us-ascii?Q?QLR4F/a5R7rOzpywh1BK75LfmEJnEaAtvfbPv/RzzugWz4ixhZC1mbSDCNK8?=
 =?us-ascii?Q?cF3ORWCe0wfaURWCrvLB/ZEinYBa8xc+XWKxMLxaOEggDcDo5qdUScgK8Dcn?=
 =?us-ascii?Q?rB+InUmTzVpdEqqO6UxtISgzXiTcUN5FbamUz3yOU3BSDpXicrAYkv0w8o9y?=
 =?us-ascii?Q?flGIpUOs42f0ouPQ14DyfkNQfWIOFKBibZ3Pw31o7rQe7AjOXLwsPwm7uHza?=
 =?us-ascii?Q?NOTzID2yQyyuHkamjBCQV2Hj6pu5K9sjU4c9qfcD11UTy304lu+b504XjNsI?=
 =?us-ascii?Q?r61LuPsgElYXvo58yo26xW2C2jRrceMXk9kcQpaiqX98vsyLLX846RF86qpP?=
 =?us-ascii?Q?S6BsxBiNFdNqbycU5rkt3jaVDYJ3jItn2na2Qp8FXe3WIrvrDwN5m3vcpdFX?=
 =?us-ascii?Q?LvFIcAxafcukT1x6KG0jjPu03QvykOYW2imXnkzCR4opb80i59xh24Fxgwak?=
 =?us-ascii?Q?CcSLjkP94f23B4PBtBpA7a8XOkwnwyGG/o2h60prgIBXtvynlVoU7I50IbqM?=
 =?us-ascii?Q?EaZHAxLsDOS5qGXcVZPirGivSfZ/fzQqY4N8vJZOQ2QfeS44J1EGBmau1rnu?=
 =?us-ascii?Q?hFAhMGzp1aNOZCCoeX6JOFLvNMhLpL/j9rAW1OYTve6GqsxeN4XLe02w7DMJ?=
 =?us-ascii?Q?58PZlHdDVLvqjr2fxr3kuzwAVueL8DpJx7SziVugx1Sw8AzPSg4kNadrHap+?=
 =?us-ascii?Q?+COFngJnfw3Vb4BPh9lUkumKzMuEO/vXz7JYRIv/4FP6NLA4Q2+LVGcc41+0?=
 =?us-ascii?Q?xPhcqDjWBrmbgVr1hjE2E+1N3mGDvhiMGg62NxIIARXUWW526xB0hVM0ktUA?=
 =?us-ascii?Q?6t/kOqtv6NEUtJEyyA9H8QRBJh5OvWbGYoyXbtgnTCyGiHGRIiOZxdcqDpcG?=
 =?us-ascii?Q?K3mk65/xdMxvSgMdJrhF6ym687LZTuGclYTJSeNLPTgnUawEMFWKRqInzS/Y?=
 =?us-ascii?Q?MWLpudA6URMMZAvRZAV/zXHsGjEZLlVekhiuPC0kpCWYNCbGoDMuROAby3rF?=
 =?us-ascii?Q?XJg4cvEiyaJr5pNvtmV/aFZJjNQLCj6+/Iby?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(42112799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fW2a1Hp4xtQuPpQMo8nZktPYW2K17TctkFIIreC9jVS4Td9L88XUpIJNy11g?=
 =?us-ascii?Q?lg44pyEwsh748i2XiqfIQTpDFHvzx5bwbjI/yjKAx2t7KOSU768kI1/fj2V5?=
 =?us-ascii?Q?po8mXDucZZyPtLXStnKq4w3U2ewTV5XxdDDBunEfP4YUfDRYznMhSguBDL84?=
 =?us-ascii?Q?0xpCmODy1qGcBWEHSzBHfoSvkjx8vVCD+L3fEzCGlGTPUVM1rFIzmjxMp8os?=
 =?us-ascii?Q?ECd2nLGc3nSMOFVx5/9SZjsru/jdfrwfv6HHBnAg7mkk2hHoHuRKBbFdtRWK?=
 =?us-ascii?Q?B8PjQA2X3/WmYUxf2I0HU4vorVNKg11ECQ59IjhRrmbltYXTXkBJ+m2FRaL/?=
 =?us-ascii?Q?a0wojh47JcuO0uvQ7P5CL+3AEmk3QNGPH+DpSugpeMOig50UjCwLcms4yu+P?=
 =?us-ascii?Q?0ZhpmQtwTF5ib+0zbKa8qZLNM/a1eevgBS0Mh9tTqK31nuRQwT1NeKUg62Ma?=
 =?us-ascii?Q?n+wnW7OpZeBStxk/Q1IG3cXewQSmQkpL63t66WIYt+Ob/Pgjyl/dZ1NNMhif?=
 =?us-ascii?Q?nomZ0c6y+CVMwU79ARTKreUHseFNvZbAV7RTI9CAni81GL7wWPwQdlnEdAQM?=
 =?us-ascii?Q?YBtGstOORYKzDoPdGa/Azvli39kLgXvUqQvMk4/F1MADeD82NM8nzbLSrUq1?=
 =?us-ascii?Q?MjUSs+elEuAY3Jdrl/veni2KxL55bcXaUDmiBrGXLj5vq9R6YrlBshZLMmrK?=
 =?us-ascii?Q?hGu6Xz7Js4bLWGZHQg1/TH4Kv7hYJWrODzM2pdUtiQKfMm6kn2du8XVisnkp?=
 =?us-ascii?Q?jnDVshODfOQJuTH37QMdgEPn2s53Q67QxN2wsv2AyOdx/stzNYRCMKntwLXd?=
 =?us-ascii?Q?uzbDPstQiZE64bFKcfrfgrqBvtk7jRoHi08nPlxb6j9x2oHrhAzaA0Xwbbw2?=
 =?us-ascii?Q?GWpfiNEF8xtbhJdOeMaTHBw40yK44yTXjajz5BzxTkytpqRhmvIOjfjfHPqo?=
 =?us-ascii?Q?v72QKC5DiDkzySjys51MvfVlg3RBSKnEVEaia4jVdHuDiVlVmEK9/bbjESOC?=
 =?us-ascii?Q?ddw6ct3/01jbtdXMr4KDpibHgSU3m19HQnbYRHZmv+aSQWuCt5wiSXVGo+YP?=
 =?us-ascii?Q?x7R5bFcLA4exfNqKY/rBQ1ZRvAgehKVVCLAsr9G155xPofTy/iOOAKiGtg4m?=
 =?us-ascii?Q?IVdO9gZVewboX0oJ0OeSTwKrxp09Kd2Zq/UMvxmYE1InK7NvmSZxvhKp9XaV?=
 =?us-ascii?Q?iBC1sMeqi5gF57Fasy1RyDt3L8vttm1RfPR+BnaO7nXNCsT9MOkOvxw9W/hK?=
 =?us-ascii?Q?Seh6n0C4M4yEk/A8kG83N68gEYK2TU1TnlOfCuIbPKWstYP2Fquutp+aJ9r+?=
 =?us-ascii?Q?DUdFE5I0Gy5InN1eF4ZFQQHeogn6H2uj+s5C3LdpjDMtncwneYM/F8/K5r5H?=
 =?us-ascii?Q?zCytufsQTh6OdwkU2jH6FXR4ozkh1lfmmZM1omgW3rxTnGrGgO1Y2/BGXlJ7?=
 =?us-ascii?Q?JkNV/L5nrDeVrYZ/8YKzJUPMRCZJ3V0C1bvy279WXpMLjhjLRQsrFekgLg45?=
 =?us-ascii?Q?Qpl4qKSH6W9tK4bRxhmmzbUAySBY6ddopd/DR9KwBXuB6wGmWTHjjLTby96G?=
 =?us-ascii?Q?oG+w1fiGE8dtsijTiGg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4debdb06-6cf9-4add-486b-08de1bb3b103
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:06:11.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex+k+YdktWA1OWIcymyuf7uMlFtGSMlKa0pR1YES4Cei0mMWGeCLNP9Pm1jPrbyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204
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

Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
and PCIE0/1 for iMX95 15x15 LPDDR4X EVK.
Updated doc for build instructions.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 - add imx95_15x15_evk_defconfig to MAINTAINERS file

 arch/arm/mach-imx/imx9/Kconfig        |   7 ++
 board/freescale/imx95_evk/Kconfig     |   2 +-
 board/freescale/imx95_evk/MAINTAINERS |   1 +
 configs/imx95_15x15_evk_defconfig     | 148 ++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst           |  24 ++++-
 include/configs/imx95_evk.h           |   8 +-
 6 files changed, 183 insertions(+), 7 deletions(-)
 create mode 100644 configs/imx95_15x15_evk_defconfig

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 6ad02b9d581..e43a49a1377 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -106,6 +106,13 @@ config TARGET_IMX95_19X19_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_IMX95_15X15_EVK
+	bool "imx95_15x15_evk"
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
 	select IMX94
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
index f9a67353e5d..bf746e091de 100644
--- a/board/freescale/imx95_evk/Kconfig
+++ b/board/freescale/imx95_evk/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX95_19X19_EVK
+if TARGET_IMX95_19X19_EVK || TARGET_IMX95_15X15_EVK
 
 config SYS_BOARD
 	default "imx95_evk"
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
index 9d5c4e41b65..bc27786f70d 100644
--- a/board/freescale/imx95_evk/MAINTAINERS
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -5,3 +5,4 @@ F:	board/freescale/imx95_evk/
 F:	include/configs/imx95_evk.h
 F:	configs/imx95_a0_19x19_evk_defconfig
 F:	configs/imx95_19x19_evk_defconfig
+F:	configs/imx95_15x15_evk_defconfig
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
new file mode 100644
index 00000000000..96b1d2a64af
--- /dev/null
+++ b/configs/imx95_15x15_evk_defconfig
@@ -0,0 +1,148 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-evk"
+CONFIG_TARGET_IMX95_15X15_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-15x15-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_CLK_IMX95_BLKCTRL=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 709992e016d..b8c3f4bed50 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -48,6 +48,7 @@ Note: srctree is U-Boot source directory
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
    $ sh firmware-imx-8.28-994fa14.bin --auto-accept
    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
 
 Get and Build OEI Images
 --------------------------------------
@@ -65,7 +66,7 @@ branch: master
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
 
-i.MX95 A0 silicon version
+i.MX95 A0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -75,13 +76,20 @@ i.MX95 A0 silicon version
    $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
-i.MX95 B0 silicon version
+i.MX95 B0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
    $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
+i.MX95 B0 silicon version on 15x15 LPDDR4X EVK
+
+.. code-block:: bash
+
+   $ make board=mx95lp4x-15 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -120,7 +128,7 @@ branch: lf_v2.12
 Build the Bootloader Image
 --------------------------
 
-i.MX95 A0 silicon version
+i.MX95 A0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -128,7 +136,7 @@ i.MX95 A0 silicon version
    $ make imx95_a0_19x19_evk_defconfig
    $ make
 
-i.MX95 B0 silicon version
+i.MX95 B0 silicon version on 19x19 LPDDR5 EVK
 
 .. code-block:: bash
 
@@ -136,6 +144,14 @@ i.MX95 B0 silicon version
    $ make imx95_19x19_evk_defconfig
    $ make
 
+i.MX95 B0 silicon version on 15x15 LPDDR4X EVK
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_15x15_evk_defconfig
+   $ make
+
 Copy imx-boot-imx95.bin to the MicroSD card:
 
 .. code-block:: bash
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 2eebdadc51d..3d22740b3f4 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -15,9 +15,13 @@
 
 #define CFG_SYS_SDRAM_BASE		0x90000000
 #define PHYS_SDRAM				0x90000000
-/* Totally 16GB */
+
 #define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
-#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+#ifdef CONFIG_TARGET_IMX95_15X15_EVK
+#define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
+#else
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
+#endif
 
 #define WDOG_BASE_ADDR			WDG3_BASE_ADDR
 
-- 
2.37.1

