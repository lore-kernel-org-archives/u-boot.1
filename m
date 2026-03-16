Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C08EFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9867383E36;
	Mon, 16 Mar 2026 09:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DcT00cBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3D983DA7; Mon, 16 Mar 2026 09:05:01 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79AF83A1B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2zvC0Fj6d7OxTwd5GD0HvPYoa6Tv3q6XE2RjvQkUs3a/5TTbLHq3HOgmYljK034opTgbZMjbvEHWVd2Qy8auRmGAebtFoQGeszPUJ82YEipDSh3FqvyNb8qhoAqZxXXYTcG+0VwQtQVrkLtLHPawSqdu9nSLWY+hwrsT51qBb7Rzt/iIeLKkSouWBtIvfeysBbrUeTrbuXy2SMjH8GraDmP35TstOsWfztJ1LX7LumZ6FLPivWvK+SSADBKJ0aoSH5QMvYWQvqKDHpAzSTj42GTIZdw/GsZUMobL+yEbuNTTDyljyzlpdkZEBQ+qNOZObO7FrE3/aGwPrYeaTIgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1f9uiBxhfKC5SPrjnlYdH13qR9bEHRHy+YV7NIGoE0=;
 b=sPvDd67vtdhH9NuX2ddUV28Ljoj8VEbKt/nd7A6iq61wVgTpcnBvxy++0bnPfrHmR6GrcNbd8o6WElnDQy09jScQguvNAF0tETSVXST54vviIoy+mSCs1Y/3HrVdmmr2jLxyFXQplIRB0QdFKUD0a1ZReT5wTXvSFc1GMSsWLxYr7uLTNRQLXMhzk/hSzgwDnvznpSs3Cq6K4Zy5KC3/Hn3yjf9me0WRHpSR5YlOwQ6pFlJqq5N31XLtZbh1c2qroPAG7OXtZ0ehHu9YZwOe3tFXwpRpLgXUs3LztRKHZ/YfNmzYnFi9/KVK9bX3G60FfiAzoy91sDIerl7RMDliWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1f9uiBxhfKC5SPrjnlYdH13qR9bEHRHy+YV7NIGoE0=;
 b=DcT00cBLDsg1/5CeT15e6cSUw0c1eFDnxq8J90OVMOtwDKZbxVq1t5AthLDctP8jwfy46UsUF3ppe+rTilWAxGa2jm1o93UbXR7yY2gd+kUH1IxrEWCp0iy5xaxQ+B0llUjMrk3HNDXIyzpWUImpVchlaoei9m+a2I1pConJpQ386eUj/iBf6mm8auvqL5bcCYcAB7r6Q1DLKrAvUyMeHwrq+6oscPWJkvASjpRICBg8cKCA6J587hn2OT+uZE4lHKEmuvA7qeFiJuOXIeAoknWeN8D/Zq6Fmc7tau3fK8O9N6ejtoJGpVx0qsMJS1J54MQT+Q9uivNd2XAaCpaJBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:27 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:04:56 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 3/5] imx9: Enable QB data saving for iMX9{4,5} EVK
Date: Mon, 16 Mar 2026 10:15:54 +0200
Message-ID: <cdd6f3bcc24891f1c18ef3116191a258d46538a0.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773648510.git.simona.toaca@nxp.com>
References: <cover.1773648510.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9616437d-6e32-428a-be65-08de8332b649
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JlMwTaTZJeDkVwyFL5D8WNRAVkdosREUJgKs6vlHEEiFxKRiqBx3Nypbe3Yy/rmynrZAp1pV0iqTJRCl6OeAoXMf0QYhNoO7TeLSN04vT55lioYjRkBdOFYIPxQd4MniRtENjIRFjUy/ruGbmVr5WdYwXZZEl77hBXlESYTDQvmqIgLCRUsMfsLtOuQHUd2NtytJtxXSpz7/qDklwj1A8h02zEPNUIrekvNsAa2OjbIuavfS3gZp9nOH2kthWQ3wTKViqwX0zcVQ/rmydbcmJUutZOCn/7aYXX4WbRo1B6BO2Jv32Kr0l2CgosoTwEmGcY4UZZ/0s6h8Q9jOih/Vln/ccI8UDL9fimuP92AttDjFzidoiy8C5yULJUoFkO/uGZT3+Bm88m8nRKRY8mRN0mEQyDKp4MRf737dzufviAmYLvkO1Ewl7DhNjFY82WsBPOfi+iWQA0vdREfwZT9KK4VK5nUHoWSe4P+r765ezRPv+//B/9B90GWXr/I3QIL1qAeiTc0yKsCKTrkuc5ikZiLiCR29bLVXeRB1q03v7N4tP27v07MmUJpq/jvcL99F8bzRCArp3RwczBii7qrN1im/1klKEQJh3zabW26NR4ElzeNw1w9hPi1ckPJ3L80t16nC58qOsItXtzjq+aGcQSqaEh71mCN3WYGluR2kSXvBtKYzXv+Un0u6Uor+BDXo2Fuazwg7PZggrCNnNgBfEJEsavzuuuDFgo2u3+exDP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGmWbjL2bQ+IZPBWNCv+L6YimOLyCfDxQbRVQBDhWjrGDKlD7D8Spbh1F1my?=
 =?us-ascii?Q?t41uYMK1HmNNM+qfRnWfw5eg5jRNowOpTSgpgrjEgLIjrTbgFbuPHDQnG75K?=
 =?us-ascii?Q?0RRTo5gUC/Fy49yXAxX2t63KZOJ4wsiCqbxM75/Db76RgfmYtTd89+W1tWIa?=
 =?us-ascii?Q?Oeg2ATYJailH4j9O3cYky3QazDtbPQzBDYLva9UA/XbBW4n690nXX+gTZzqJ?=
 =?us-ascii?Q?EkYpdKZMbhSBWB1pWHz0UWZ2/j3f7rIqtGUHH0TwpFRNndCQ/RI7yFbqARnT?=
 =?us-ascii?Q?aNddRwAUCXUUePDeY1A3oHREwtugDK5ndJLZ1VcAfoz0ekbQq5Xuw9PkcsmI?=
 =?us-ascii?Q?U7DatdYHRMsevzKmt1j1B8dOA8m/4L3qyLXzu/mO9/8hrO//yKyPVuiTcHHj?=
 =?us-ascii?Q?odwLNaU2BrGylA3CL1E8nvc5LxJZVHnv25W7GjVRxIjkT1CJkiWCBklHT8T0?=
 =?us-ascii?Q?Q7A/uU4xhSdY4+P+evsjkV057Z9q/yCEQQirosux3OwKYRc3V649mn0OrIUc?=
 =?us-ascii?Q?LMXbDHtg2mGMmAtptaEmG4IrZnG3UK+sM7q54nJngs0xzEGBvFjmlB5qm2o5?=
 =?us-ascii?Q?xOlwqYZVyVKFwtbQJVPPhjxR+9Zh46OzRTtmO3IGDgrzeeryLpuOyZqt6mLg?=
 =?us-ascii?Q?3UA2UUM/2W0WN7z+CSSbJJgZZVhd7FuSfzZMqP7e2EU3PjPs33QL7mRayITL?=
 =?us-ascii?Q?SCOt4v/Cy6g/aGrlCV39E9bgzkx2Fp/GhrSBMjjV8wluwC//87twbIh5Sp3w?=
 =?us-ascii?Q?AHBirVohREyiEs4aApUuFaSLETVPiaiUC/ohwjONoaZCin6zhs6M/qJTSavi?=
 =?us-ascii?Q?4qN+0YVz3a9yIBlei0t3gdz/KQoKrULSbQOucuM2vTmIvphdASXMrktqxmic?=
 =?us-ascii?Q?dakEmD5hmYy54vQGDs5Qqm8Y6i8g6qUu+S7Mx4uiDmSmX+BSS1hLg0ggBZRG?=
 =?us-ascii?Q?7qL5V7GNkCFd7rAMZRGZb3mAuVN7sxleGn0itp6bfHoSP4k3RTdPWiEZ4v54?=
 =?us-ascii?Q?FwoDnRaNNbYEcBCqN9Jtnf6t8bdw7bfaYo8du+cKDEN0NcTbAnl5AhXLJPEl?=
 =?us-ascii?Q?3+3ofC/qROe0yQPzOP2BK79zTR0clc8GUY+IpBagzhH/3uly0TsdOrhF04Ar?=
 =?us-ascii?Q?3/xl/hG952KbrLG/frZ3Sduhi/4PhTd4TyFvvlYTrVPrMCWcVteimGZyM570?=
 =?us-ascii?Q?d/O38xSk1wUbvEY+mbDdsywg3vK7X/XF+G8RHyDCW6EOPPK3vJrEMkI0q0wy?=
 =?us-ascii?Q?m+qCrQzWh1LUmCyp2+MMqjagkonGF3d6/tYi/5yAl/Jg5zOdQN4u3s0CYHV6?=
 =?us-ascii?Q?KcNU5peRAZ00awLysvW8cMuHeRJrsvft96v9v9hBpOy8koBCiM5/pfSoCyUz?=
 =?us-ascii?Q?Ukl3GpAkBz8CoqffevWRZZPMSM+g7GKduXlxaPQfTh16r452jWe/DHO+Qq/Y?=
 =?us-ascii?Q?FmuvoLOEmoHtHmTUpCDahwTkneAPrdtg4Hpzfvll4eOxNG5R9dt8eoomtb0/?=
 =?us-ascii?Q?BpSGBOj3ofDp8K2i9tu1iHYkehEEV3rzs2OqSo72DszyjZFFuXaxy8LnYejv?=
 =?us-ascii?Q?z2ZnDIJVpqItFQqnoTyvCAFCN+NX1hqWAro9snqCrh9iKM044Tc5TwP87n6b?=
 =?us-ascii?Q?12YkYBo4xJbsFILc36Jnmj8f1qHpZcIm4oP/iqKUz5R4sSxXb5tJQP6xvsOf?=
 =?us-ascii?Q?yPlQy9Ie0k+Ddp+Q9aEzTDy+7yd2+R0Y30ulXDUVaDApbWDKXnldEh7izvSj?=
 =?us-ascii?Q?fPmWIgtSfw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9616437d-6e32-428a-be65-08de8332b649
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:04:56.5049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVUJsyUSyle25rl1fdvqTcrjLM9+v+s9/bdWhx4lZmfbrTZTj76QxP04DTy+4ROp1j5ZLbHX6a5s+nmE7EuMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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

From: Simona Toaca <simona.toaca@nxp.com>

Add the necessary options for enabling DDR training
data saving to NVM and running QuickBoot flow. This
makes Quickboot commands available in the U-Boot console,
as CMD_IMX_QB is enabled by default.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 configs/imx943_evk_defconfig      | 1 +
 configs/imx95_15x15_evk_defconfig | 1 +
 configs/imx95_evk.config          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index ef4f9a8fcbc..57d4240ba26 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -96,6 +96,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index 38a855417d0..03c9b71f8bd 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -100,6 +100,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
 CONFIG_CLK_IMX95_BLKCTRL=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 3db583cce59..b34d3f9c935 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -101,6 +101,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_SPL_CLK_SCMI=y
+CONFIG_IMX_SNPS_DDR_PHY_QB_GEN=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
-- 
2.43.0

