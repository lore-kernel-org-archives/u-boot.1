Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6AFD3E194
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 23:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD7688E0F;
	Sat, 19 Oct 2024 01:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HOt7fZWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CBD88DA0; Sat, 19 Oct 2024 01:47:53 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39EA288E65
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 01:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/3AYx8q0my1s3sQPdegLYuNNVugNDzZlBjinRgLoHLFdQsl8MlNIAJGXSI/eT1/+95ZaTPo9dqMP+MeI9Lc3caaZjFYj57dv/GGFrt4RfTPa7OSsRygFqfpKMDt0nUOAOTHgX+5BuLiavylr9A+jGANJGYgtt4ut1DO1MVppIYKIrLBgBBsOiOaMqQdA9ioXi3Vp7dhNx+riTgoCsQBWUHbrRXgC8zCJ7vuACzhEV3eyLIuCsBaAVrv6E3rgfg3BiYu9TauVoe/CwCrPVUHfU9Ya7Qs4k4kBNq3n/ycsruCE2Iid7lQR8DiRpCbYCa6f7SCVQgs7J+zPPw0yCKJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX7JEAx4hqUG4p2tto4zz2pYz22dF6gg8ZsBFI0kc04=;
 b=x/NCjQRbfxMd1FnD5bH6FBqCsivQKfXhDiQ9moOBvIslMXjuLcw05CUJC8LKYBYqyvw0nfSGqW6+HgF7+Ax64KCl6XL3iCTpUlACVYTQsykMDvuSpPIJDJyQkIVDYIZS02KcVqnI+Bl2j2FJcJW4Ne59ocVWBkWLRCfuAbKY/jNvkunwTO8o91NNu/XvS0/9pxP79ev9mF2D2JJQVOjfg1u89cRdnyoXUo93lORdT/2rwAZSGnij8UYdnWnbxlLfAiapF2JA4DXL0A0p20lbdLGCKc2c0UtrWjvXisRrKsJappg7GQ4R20sWhDbY7iYkduqnbcz3SZikcogfS+NVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX7JEAx4hqUG4p2tto4zz2pYz22dF6gg8ZsBFI0kc04=;
 b=HOt7fZWN2q5iYH5uOvEiYwljUpCgeeBSxYcjZtfr7bQ6MK2LWWVmEQ3pq+r76rIGv+oEnwDm85xlbIehRqcCkuyO5C+9vnkOKiDRMXBkEDz24DFjh6C7MtsHex7pgWp72qgcrpCTSg6xdmMA3vBV4Or5QiVHEYar8Vx/h+TrRI3uHPGvhQzUrp/ncTpArh0SpJbx54arbIBHKOKkLyMjuUKdWzPTFH4dKvR6HsimWlphiPC3vpLpa/hcG7rSovYYClgsTlhh0TIrJfiJWNiX/vtCFrzBNeAX0CAwVsuCTnBFLZazmDOv990aHI1Dq57ceRGNe02k5AK37O5cSBvX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 23:47:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 23:47:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm: dts: imx8qxp-mek: fix boot
Date: Sat, 19 Oct 2024 08:51:24 +0800
Message-Id: <20241019005125.4165-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10073:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2c696e-0b9a-48ee-c220-08dcefcf4428
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6NvRN8w7tluAGnGWHUX6a7w6N3SFQGjqVTX5OLUv/wLPFjgRSv3LsshII12F?=
 =?us-ascii?Q?n7NRGTxX57U9zUAoPvqCuODJx+dzhb1TelXFuNJjf2Kzpeqg//DD2146gUFK?=
 =?us-ascii?Q?gbESUQXdxBXdx6TIAHOtT/Nkur8nZ4wOTQEDpsWY7baTvH8hhNIjldufp7A1?=
 =?us-ascii?Q?2Vp3OwJwf25UBOYZ2A8MQT/P8ys+Zzm4/DLlCH/dqA7o652jrkDU0IZT/eKg?=
 =?us-ascii?Q?b1fWLXzPGe8UDYj9fvv4X+znlbKvy7bx9kwvVeEUSvt2F2xZzmqAWAP6COh/?=
 =?us-ascii?Q?pYS8zF0kX8Mv4ubU0eCoqrGcVgIT0Z1BpgrjEeUxv2P0iOieVprkvOfWFtor?=
 =?us-ascii?Q?KLtm3DC4zKNdKQ52PFaMPPmmDuv4shFJCuU4y1cb1pIMF9Mfl0vuimIbrBxp?=
 =?us-ascii?Q?aWm+Dwze7rWdn5eWOD/FAeLIcxU8+dUvldxoc212G+rplq3lk4D54UZjvigE?=
 =?us-ascii?Q?G5ZVoLxkpEqDb1p8ro2fpP55YaSgoFphBpkJAf9uwVT+/yHnC0UVa+wiU9tg?=
 =?us-ascii?Q?zQ6z9Ggc9/I5FWDzxiUzp8tHwLBlwR8tfqYhf08iny048bG7GN7OUl87w+Ds?=
 =?us-ascii?Q?0FGCk2XtdPkrBqdVjwR2wo/Z6ApTOclhS3vs1ibYwciMoASDSvdmsFzGAvi4?=
 =?us-ascii?Q?iT4JiBvoZXu1fPVAC15oPbDcgkGVGKgMf1o9pCyWsE72ccDtvQ5tumFxeXA0?=
 =?us-ascii?Q?4PbmrX3rvmN3/kLfpUoBkfCewbT5VUIDFNFA0wXgjEOZ0v3+qmy2Hp+Wo0Xb?=
 =?us-ascii?Q?BhpgDfqQz9/vSTafU1EbKQqosFg6bpHlwREWQxd3zbnYyEO2ZgT04bK7DhL6?=
 =?us-ascii?Q?VArds1EdPVc0K5ABZNwSkxYFLtetlRHNasu6rFvDB9QufjhzI9Rl/Ti/vYDO?=
 =?us-ascii?Q?nonp5FLWORS8mhJjvT3mUyb736m69wotP5jcDOCoOGukkjDN98s7GxdmifdA?=
 =?us-ascii?Q?wVUv+10nIGqgE9J0X3e0Ve2AxQNT+75XNwhInijDLL4wjjBWjceH24j2x/+j?=
 =?us-ascii?Q?uMKFJvyfZEHbjEAcCcjjzMJXzW06+dMLgWqY1Jaxtsb1SS6okIlfZlzYO6An?=
 =?us-ascii?Q?4Fd2zTaVvbFjvlS+K4pnTgbNmbnmv7qC/cOn711rjeqZVI4R3tSR+chW4uGr?=
 =?us-ascii?Q?6JyRA0dGZ8PvlFjlpuYzGG3m2x+yQIZhsXyDoBBkpfTPAc+uy9OVwR+XOiMp?=
 =?us-ascii?Q?jARCq2UWPG7Mc+WLEuWs2CCfrZEaWuCc0FGMG4/xfr/uQGxOHc5wdeVH7/o7?=
 =?us-ascii?Q?AVmXCRM5gkGb+VL5YqI43Z4wfDvvjzZLHopvpzICelwQL3gOUNI1ospu1d2V?=
 =?us-ascii?Q?/Xmk/MCHSJzChxAVM7hJZGNlEkdGkI+wINgDQuyULyhmdQvCxNsks2k1Fc9o?=
 =?us-ascii?Q?DTXieoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5CLuErmGign+axdn9dhh+gyhFsYBshJ1En00rxHczBu2i19q3uWy6XBoVBme?=
 =?us-ascii?Q?1Ka7ERWoR5kr8q8Del2zHwqfrgkV52t0PH6/08EVwPyVyXf9phbB3AaPBzMS?=
 =?us-ascii?Q?NZ5Kpvy8gUab3wH9UT59L2NFWIQtYuO0AlvNTKQWc39nSXR7QEYi06BL4aPf?=
 =?us-ascii?Q?E9AF/H9nl18VwJcfLc0EYpRsl2pQ9qed8VlPhQdqjtvf/ErLMyvactWbXnq1?=
 =?us-ascii?Q?PijZNvYHTSN5APEwr16LbKTqXvXfQiWADq2ut9wiHGLXaFe0/38OfOIXKcb1?=
 =?us-ascii?Q?ySFr78abmVqAkDFOZ0LCR9Lh9+6z0ZTddFT/LG+g0gsqWnLeUYBjI6NUwFN/?=
 =?us-ascii?Q?pZ0gsD/G53I3HyCTcbT23XJEPX98Hb2buxMVO/UI0BrCPMS8B8uGsO3p2NNw?=
 =?us-ascii?Q?/nsl92yspQ8bais6k3EEf3pvb1smicsJcub2AcK/dBjut9wmASo8vKTlOmtz?=
 =?us-ascii?Q?BqZXsHTZCUgxVKrku/lmFBZl+U7+nfOMcnZ/mlG9UFq3PD8IYT1F519u/yMF?=
 =?us-ascii?Q?trCrldfTzyk8X1+OIZ/69uLKIuoagvvdijOOCfO7UchH2aejMTxO/Bsa9gFc?=
 =?us-ascii?Q?6D1+OinJ6N2O0oZweAQS7K7Tm/vi3B9K/NLr3oiHla7Ip4WeiS+6SSSI/VxF?=
 =?us-ascii?Q?/OJwzrbenF7XES52ToAzT/mlGCbhJsux7ZzM00hOD/lpf3JMEQGGINvBiuRo?=
 =?us-ascii?Q?sbQ4nJT03Ty4CU/QEW+7Nm8eXEEOnCfJn5MOfgIhZo5wIT8p5/+xIL8763Pb?=
 =?us-ascii?Q?E4NAtlkuIQdxAzlMTQb/vH42aNL7O9z//f/ULBixmUWNPpXVKQUJf4k67yFE?=
 =?us-ascii?Q?ACHrw+dqeX0tShjkcDsVW0j6ujhNKwzfhdxDum76f7ThYq4H2g5c3AjFqMkc?=
 =?us-ascii?Q?Jw/28anxp7eVY8Yfnlib9p/o+MnGK6ux74Rltiv28upMae7RZZ19WAeG6H70?=
 =?us-ascii?Q?so/cKbrjxcEuvJYouraxVl477VjYOiosK+wHXg/a11dNxQCDNfkpzRIJ4CnG?=
 =?us-ascii?Q?uQe8F7zKzNmKOZR2cVWG77ypCcOQBW9SrguMGqPsw2mcn4SBsuriT0P4lk/X?=
 =?us-ascii?Q?xiIggc8l21gxluwfI6FpebG5mwqx30o2bI8uBDwCEFJ8t3u3I69j2eGD/sG3?=
 =?us-ascii?Q?BA3F5y45hhlORt21vv3WUadEFodvN7wfYsjDcEMiCPJjd5w6T/s20CAWecaV?=
 =?us-ascii?Q?U+m++fa1sXj8xB30WfZPH32lr89pCfhgz/piDGS+WEZ+HVdoPUBXHvO5BARL?=
 =?us-ascii?Q?kb0NiNTJiAuEBtpDYpoh7v05cJm4oUGivs75gxn2KDcZly2k2ug4sdZwQIxV?=
 =?us-ascii?Q?Dh2esI3COnTdJ7sJrJa6eheiyT01MZZqvAThWs5W61DjpExSFnXB/YBtZXDI?=
 =?us-ascii?Q?2FBsTo3lxe3MF2iPq3l79Q2DQc1SAMS4lFuYDeQhQO8NBqOj39LnSE1oZoDp?=
 =?us-ascii?Q?NBOQAD7CliH53EwE8saZhEu5Mv3lDrM7vr/G6PY1C62JEHF0J+mMkRqzgH5D?=
 =?us-ascii?Q?LY/RwNrdWszbpp9yEHvdKAxx+REg+yURdLFXMpPIN5qOz4Mp1bGvnDRcNlzi?=
 =?us-ascii?Q?UAlCI6BYNmoeENA2mHNRTx+B4Z7UQgI4b2mGWJnu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2c696e-0b9a-48ee-c220-08dcefcf4428
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:47:46.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uy0lbDrAaIFvQ6ijxZQaEzPkENmDZ7ohiSA+lJZvrDHuKptTZ2AXVZo/FfR4hMizxKheRemX07/gzF+RYvsFtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10073
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

serial_init runs into panic because no serial device found.
Update the device tree to include bootph-some-ram for some critial
devices needed in pre-reloc tage

Fixes: 8c103c33fb1 ("dm: dts: Convert driver model tags to use new schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

CI: passed

 arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi | 18 +++++++++++++++++-
 arch/arm/dts/fsl-imx8qxp-mek.dts         |  1 -
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi b/arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi
index 591eb66604b..e670214b5fc 100644
--- a/arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qxp-mek-u-boot.dtsi
@@ -6,19 +6,32 @@
 #include "imx8qxp-u-boot.dtsi"
 
 &{/imx8qx-pm} {
-
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &mu {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &clk {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &iomuxc {
+	bootph-some-ram;
+	bootph-pre-ram;
+};
+
+&{/mu@5d1c0000/iomuxc/imx8qxp-mek} {
+	bootph-some-ram;
+	bootph-pre-ram;
+};
+
+&pinctrl_lpuart0 {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
@@ -75,10 +88,12 @@
 };
 
 &pd_dma {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &pd_dma_lpuart0 {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
@@ -131,6 +146,7 @@
 };
 
 &lpuart0 {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/fsl-imx8qxp-mek.dts b/arch/arm/dts/fsl-imx8qxp-mek.dts
index 6a987f0dbb3..983b918dc7d 100644
--- a/arch/arm/dts/fsl-imx8qxp-mek.dts
+++ b/arch/arm/dts/fsl-imx8qxp-mek.dts
@@ -6,7 +6,6 @@
 /dts-v1/;
 
 #include "fsl-imx8qxp.dtsi"
-#include "fsl-imx8qxp-mek-u-boot.dtsi"
 
 / {
 	model = "Freescale i.MX8QXP MEK";
-- 
2.35.3

