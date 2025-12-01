Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13353D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD4283B32;
	Mon,  1 Dec 2025 12:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PXL0ooAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C3683B48; Mon,  1 Dec 2025 12:01:33 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5677D83B30
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjQ80PJd08kBzcsQmxO9LlZlTv38jbMIVf4Ql8Qs1btYJLGF0vsGcyGb9bytwxm63rs829zvFa6GxSJGS1vX3Y6MQYaBFNw8sbJm0L42W+6devCjdUAEh0MgnY/DkVi8M0g8pKk191r7nkZn6fQaneXFxiJdTy7xLaPZ2P5ttykqivqbt8YH0clipFX+XgJGryoT5Ac4dyxMDjrzWsJbt1ZzdHNIMMq6BK5BfKeAT2gOJxvvUv1FHtILHPdek1FTaG3k9/N0lwi98jOy5QJa9HP6KXVi6UJ+VWI+D+1rKgTNxweYT9hwKgXbinidCqhRdzAoajNr/RTCFCIJ3fswJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0puz5/5xIO35WlEaPJxKI3xuj1F1lhWmQK6XO3TUIME=;
 b=dZHSx7pjtUzFmf64cjvA8XSV9Eb0c2aCL91gaa+xc2y7o12in7NhrHTHDTfV3esHHzF0VdQXCfy0aZ+T6akex29Vg/iDsEe++vzyvNaXPM7yea6Z+EBLzQ+Hf4guxYotE72+E761y4AXyMwG+qYCD+TZQD/Yp5j4ySS+BpNpIR2IhymsaldUFttkABv/skVzvx3DR7JAEQCIoULakk0XBaZEvaZ9ZvzAWrI0iTTrXSCTPQZ1J4Cg7vm46wQy4hLD6pFb1G75GO2fZVrTK962h+oFb61Nwf7FVk5UG33vNW4o7jXqFmCz9pJUu2Iwc2nXsq2nqNKdG+jTgWqOxG10Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0puz5/5xIO35WlEaPJxKI3xuj1F1lhWmQK6XO3TUIME=;
 b=PXL0ooAAO+qfHMgSjOMVO3LQSXLj1v2VtL3Z7B5NzA9A98lKCd8JNCE4a3zmeTqJp3uDqIP7AFDRgIY7z+o5Hn65feTGBVv52/9BMpGIiP5KY4EDwM1kluxISyCjhm/51ESIctzlb/WGjXDg2QEPQa3AyPjQc//JfG21V38EqwVlUilgctUNn9SoIj1OgDEgZDrQYHz4ZpBSNVbJH9iLLQmhPl3GcCDhdTRd58yyuzXBiYVHutPrTHKl9jmvVmAZ9aLH5/VSulDJfexM7CokLRr64ezX54MQqSL7+txHv+TSijviVgFwqUQ4Gu2oLmSfkOnuOjIcQWu+YRYKvIWuXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBAPR04MB7318.eurprd04.prod.outlook.com (2603:10a6:10:1ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:01:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:01:27 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de,
	uboot-imx@nxp.com
Cc: trini@konsulko.com, sbabic@nabladev.com, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com
Subject: [PATCH v1 2/2] imx8ulp_evk: Switch to use devicetree imported from
 Linux kernel release
Date: Mon,  1 Dec 2025 19:00:34 +0800
Message-ID: <20251201110034.1968871-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBAPR04MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d24221-03ac-4f3d-0f88-08de30c8f98a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yE20WfxPzrUVIemCKaRvSLqGmKsD4teFsvAYV4cOfNWDOfVnu3yL1DpOTv2e?=
 =?us-ascii?Q?qijWl2uRtznVqsGO8jRpnfbxq6zFmhxOtyj978rkm/nOXnnNseiwFIrpjzm3?=
 =?us-ascii?Q?lWhZgx2uK02Nko6SrDE2oZGi9VjoEmeWtS4++lCGdscyrnKuqFLkRFNWirHg?=
 =?us-ascii?Q?a694M5wgQwEDQ05Xq6NTF+cMArQ1eu3euBeI/c39IZuEBIMACSOYz7Iy/OUl?=
 =?us-ascii?Q?0KXpYLqKdOAdySScdBkLKdG0n/KHLd9vuFmsSjj8VsQ5cgWUCzoV1x9Xecxt?=
 =?us-ascii?Q?3PRDcMYezn2FDeO3wE5CRUvFjOReSGhNmAM7wHtv/wVRU+ysKUuISwINGFN+?=
 =?us-ascii?Q?fRlaR1+bfx2H/4q8+Ru4TCC9p526anLT4pO/NsL9/sB5qcaJUWyE95pQxpF/?=
 =?us-ascii?Q?ubQE5vgJnI34uMsCegelszLSzvuFHPqjhy6aZx6O2m4YzckMsXmmHRMqZiNa?=
 =?us-ascii?Q?Ttvl6toFHH2TzdfoC+dbVNxq+AQ2kuuAOUvlB+a4e1Mi8hEpufSm6kfL2ZQM?=
 =?us-ascii?Q?dzvn2zCvotl3uar8sL7HDhAvr1g6xcKo8/xe/8oaXmgoMBzs5B1hVQ/nbpXe?=
 =?us-ascii?Q?Ypdi9EGYwJN/m97IbpechbQB4wFaA5CR6pLExMzKcUL9d4ELSW9bDg4GIrL4?=
 =?us-ascii?Q?9Q1OMxnaMbNJfsEK2Zoj+4ESov7umTwI9It+vOuKT6qIWIsJxdc5sEQAHDu9?=
 =?us-ascii?Q?76Uj0JIUyMO979ar3HJcyYOEEage021IIi7Y8FqekUrqgyxXZwgxQOgvlp2J?=
 =?us-ascii?Q?saQgrAr4XB3VuNhnqLFu+0TaX3mmShK4CVbWqyn5lRShaR1mHsL3sCNLv4/e?=
 =?us-ascii?Q?xeGc2TpCvv6W0YkMc1SP0jJ14F9jkGfDGtcKO2QVyUJXrb3W1XLCMHv+ktaE?=
 =?us-ascii?Q?X0EsKWlTwpZLRWE8MUEoBWtwtCgT8xBfFV4UzZEyqKfJrTOd9rkW5yDYdTda?=
 =?us-ascii?Q?e141Fvj0v+OHzw7MSGRDrNmTiYmGSjRoXreUqsB5qdCh/DYcnb/ARSMalm5x?=
 =?us-ascii?Q?7c0bqAw37aBgOM+dQ6EP/jlCQFK//+linI0lBwcwvRy3p6WpE5qSJncgbOgb?=
 =?us-ascii?Q?UJGptonmH5agFmJyxljEaGJ61CCxuoTOAWjBh/y40U03vvkyACf5scR4LR5c?=
 =?us-ascii?Q?LpC4hVGvqiP3BG0we9b24aUvr4WEw0qtjE7W8QxuKGb6xY4D5UjjOXPvCAka?=
 =?us-ascii?Q?LjDADVLj7eW2DGrdCLJev2IwC3dwYu5VlPDLa61Ets4dQ9laiycQb18D2xxA?=
 =?us-ascii?Q?sgQhGtcCPSCGGszoYmWI/SN+7WvHM5NkRfcRWQfUbyOE6CWqwt3/YIPAelKm?=
 =?us-ascii?Q?y/OfOPujLgF8xX/nlJJAPw9GK/QHyFnvMTEeTpwFRzTBD1SGstSkSgSzKlLd?=
 =?us-ascii?Q?0vu8cWi7Et3h0bW3JyVx8YnqgTe8nXAJjl+0fnWnGoe+FMSasbzo7pxjBbTT?=
 =?us-ascii?Q?76+IhKIw9qCv1btCOU6MB/qvFE4a6rD3KEW3WcKRIGIx3zxbjHcL4vdFWrhb?=
 =?us-ascii?Q?QBGy52kbL2gWtMiOL3+BCQ5MC5IooXNQ1XD5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCIjHEH4j2P10gzaI9W7EalDgZWutR5GkBzvniz+CRYY7VxBkMmbAr1eM7JE?=
 =?us-ascii?Q?9DKB30tppwbeC3nUogQ3R0zzRRmvLAyZ1568MjgudyKXIPT7mQMHdhLK++hP?=
 =?us-ascii?Q?PHP5TJJRNB5G3pBe1be1bqt5Dzp6m0ztfqBCYE0DtgCCKGEQrKfCWRqLZfPK?=
 =?us-ascii?Q?tgQNIf0ye26wOkG8LLOWDdcIEt5o/kp0Kmwqt00/DswhJF4qei8UtISOPj1y?=
 =?us-ascii?Q?+Wdups5cc9TsdOBvqatJU7pqZpinOLKbV196H3DAwCeLEd4D4Bppq8HCx4im?=
 =?us-ascii?Q?TjeUIbBnRlxYTErbR2cgzBkkPLfz8ROkQcMOqolB3fgO/xTYwP6ib8ykXQxr?=
 =?us-ascii?Q?hgCvSMKg/k+7IfzmHAyMXgKUp5/lwsXWP6rGINW3EVFK48VtHg8jRt+kLGgb?=
 =?us-ascii?Q?0a1vVthLzXie/ZI2EWTXE4SyAlPtaEH9+hinnPEQns/2ujXKOTgmCBbXC6b7?=
 =?us-ascii?Q?rhkOfaAwLzUs85Lg3in8KhH4Lho5eFfxS536JD5f4nzYN2XTxnCoSQZDPh9h?=
 =?us-ascii?Q?3YVCFMiIGhhKSl+v3eZjBoHY5vpBubNdl2B9djaGBC7kGkZKO7SLylpIyLHU?=
 =?us-ascii?Q?SQSOtbcAQNPAIslgYyYKO1h4f/nu9Xr2N4R42o4a04/COFOTVy+Si2NPUdVk?=
 =?us-ascii?Q?8HM2gCwfZrRzsKy+dlzw5eD08nBis3GBnq4kbuzLvFvxgBsAkJ0+9LZOVyAw?=
 =?us-ascii?Q?kZaAHskNhF3Fn3dFTas0+4pWSllZekkTNU+ZXGHMa66hmBLkUrUVjOsS80Kk?=
 =?us-ascii?Q?nEai/xvnic8PgUhkfoMuxFndJa5tfxtsFzEuFlyKTciyG/CHW94icekX3HIu?=
 =?us-ascii?Q?CAeftv7avMQ0CPABrldEdRw+z50JCFb7qWzZGlykRMdDAdRkCXJExeHfyR/q?=
 =?us-ascii?Q?wcZdhhpESLTr3AD3nd1XWUv6lcO/eWHhgQaMLN7IVRw2+Z8/tXGn+OGt6XoI?=
 =?us-ascii?Q?SebhoU58REeGE7ReJUJw0XQJrh9Rb4SIitiWfdur6uEECqZvYc4xMoCJgnbS?=
 =?us-ascii?Q?Ig//VAaHtgLX8EHfw1osRB4tVFEzmDAx99P/9bfzV6gI8v1ci7I/xBKNu98V?=
 =?us-ascii?Q?CoEmQJrexFHvkbLb9119u6vxwuWmFW05lgKRYdZNbpufjO6a6w7ZfKzZdcx/?=
 =?us-ascii?Q?uh1agzvchfCn4lafDz3LRuEUoRnPVgarCPjS9HXKoBAKixkpILaio2Zpb4Do?=
 =?us-ascii?Q?9qR/f8bpgi9R7sz7B+iIFv4bBpdTE1RUTPN1iCPO7AFk6FAoiPMpXoC254Cr?=
 =?us-ascii?Q?tgJ+eTsoRwSOTywVr/8fK8L2UmddpY0gHBbzkI+sUy7bo6QBhzSGB+lyE+Hn?=
 =?us-ascii?Q?ILpE8BMPQXuOfh0yEjnZCrkrWgcCfczzOzKu7rPo9byhSQWImTrQvuaRVDsd?=
 =?us-ascii?Q?iKscKEWOUL9PuJVBUj/IkG53BYo0OTb/HZug+b/xIgsMMBr4Lnij3GieYctE?=
 =?us-ascii?Q?EHAALsSEaNY+GqEDuxK4+/HYGuhBu1v4oolpYAR6zRywUbeBZrZbx/Lkg4Ua?=
 =?us-ascii?Q?XESx6Mgp6rHe/SPO1aHOU/l1fPdK4G+09goLPR9v6Tc35dvzMlNiqkrTcah/?=
 =?us-ascii?Q?LWj2ZJBA2n4RR54kwvSpOLfmnf6Hd1ArIDCE4Zo7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d24221-03ac-4f3d-0f88-08de30c8f98a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:01:27.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtNXCPYFg8n8EGC489pcPvNGwdxwdQxOyZtsqbjvvemBjlidvPS78m11T6rnBzGIy7axWt71h91TGyDi8TTlnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7318
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

Enable OF_UPSTREAM for i.MX8ULP EVK so that devicetree imported from
Linux kernel release can be used.

If mailbox@29220000 is enabled, gd->arch.ele_dev will be set to this
device for communication with ELE firmware. This is incorrect because
mu@27020000 is the MU used for communication with the ELE firmware. To
prevent misconfiguration, disable mailbox@29220000.

The driver model for watchdog timer is not enabled yet, so disable wdog3
temporarily.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/Makefile                | 3 ---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 8 ++++++++
 arch/arm/mach-imx/imx8ulp/Kconfig    | 1 +
 configs/imx8ulp_evk_defconfig        | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 865ceb65f9a..b7ece30d1a3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -880,9 +880,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	fsl-imx8qxp-mek.dtb \
 	imx8-capricorn-cxg3.dtb \
 
-dtb-$(CONFIG_ARCH_IMX8ULP) += \
-	imx8ulp-evk.dtb
-
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 2782dc7dd75..860994129ae 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -22,6 +22,14 @@
 	bootph-all;
 };
 
+&mu {
+	status = "disabled";
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
 &per_bridge4 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index e96e34651ce..d64cfca0408 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -28,6 +28,7 @@ config TARGET_IMX8ULP_EVK
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
 	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index f8a87dde5cf..469ee928129 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx8ulp/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8ulp-evk"
 CONFIG_TARGET_IMX8ULP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
-- 
2.43.0

