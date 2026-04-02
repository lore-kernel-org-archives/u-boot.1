Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90FD39403
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF9F840BE;
	Thu,  2 Apr 2026 11:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GwcfHtob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCEE8407E; Thu,  2 Apr 2026 11:29:52 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E346884142
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBWdWt0rbvKe8M7hbJe21YE8/tfc4YBo53ICGO/wtUfdsyNla/wxoBpznvHgJmP7G9/f5RgcQJyX5hUPoJqqk30VPnLO1H86aB5++i72QvBokjH/v6UCridJJzJJzYO8eBwFloS7Fw2cmZ02hvD//pHY3dtoD7UeoZ1C9I7syrQ1bXaB+unBNkJh/Ov3qpWAx7k4biljUOesdaw260TZSsmZ/DD38C5R/5sufPImECSFt4AmPTMAi6nrCQjFKGuTWfw/2c4nYeiw8320QQLAjQTt55T3Tbap60s7YgPUTjsd+uHKO1V+DPtJJZfzX0wHBwKiuXLjPVq6oLnCTAMQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SkAQcZmDdxvK41WY/vq4Mq/WOfIQJL/Wt4qgFQA+eU=;
 b=CrR9nY+7BeSEPbOO1fAByVgAy9OTLQYuhzOSFDiDHmBdNmO3IKnVc4j6wm95h3Nhs5uT8WyoqjjTgUY++8sL4UBlyhVAetM79MeT4Ckgkv3e2SwjY03+FQcCTnJjMZfnk/SJUHsqxQkx70sTPpzzIwuBY2UKasMs5BbpQONVBhXniKzIb8wUMpMznnSDbM9zXB2cGp3ymhiaaP6G4JUOjHIAsqsGeMfS64Agq17S38YKzfZQ00AiDQS9/KVjv9lGTM8w0+Om/47a8D4twy3W9tRFCfX59xhKWnWKrR7BnQPlBWvQrFyujDF25qTVSuVtDUc0Fo4td3aX7LoA5IeioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SkAQcZmDdxvK41WY/vq4Mq/WOfIQJL/Wt4qgFQA+eU=;
 b=GwcfHtob18IUk1WNL51UBDK5nGaUlmgfFrBj8e75wnplmms4OcJ5N7qa3FzuozKgCXN/JvyXoTcbF5WuiYocma3BZoDvuldtCIZ80gHtEcEBcMn0hGAZO6ujHPjWapMov3PSKVJpIHF3d/Ya4PqgRCaOqKk0BmRzvz9VHb5F/PLOJXkGc+qKyvCUV05hzwAMxcoXB32XChDxIC2SyALCtD4EcaFPAYLhYcxSv3IvAZKQK3TqKGjD1pVenhnEhrhhVTlKi2FRoE8/AqXmii3cqfMxIDYZM3nI9NQlYHMxMKnvx359LeiEZzNvYjmAhRgOQ1MF520TfuXBvlRCzeO9gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:40 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:40 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 6/6] drivers: ddr: imx: Fix Kconfig for
 SAVED_DRAM_TIMING_BASE
Date: Thu,  2 Apr 2026 12:40:48 +0300
Message-ID: <ee1ce213e039f7036ee7dd183445934901a01efd.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca0e6a-c499-4489-4f55-08de909a5d0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ey8xwb8aUJvGwNUC1GJT69XQzOjz3MZX/w+xA7XK6ivn48LlfGLZGNJk2M+uyhNQZ+r3E8ZNBjTE/otNT7TsH3syQ8KHGKnKQBgICf+L4p/z+PJPDLCJWmXOHY2/HdOea24CfbFlAPB7xvHaQmeEXWZaaZXuzBoirjqH56oCUqymIJ4iZt14Hh6UcEu4Kh7XBVU5+5JYfXAnKwpAIuFCiOCwQ5FsUZxl7WlsFwqW21Mi12v7Mswqt8D77ewIyKkgBMjs/BZpkZ1/miWKAj5jl7+gFAboeOP0Pp14ri5hyZcEvES2F/2GxjhE2sDXSR/2hEaZGl5gZs8utJuIA8qV+rZDXmqWjdl5hp0qKKzp0vKXkO6Wqe3teZKhM0ZKYvAiCtJxzO23kkikXsClaskG9fF704Smjp86MDTn28QatrV0jvdONxL4hTqNLe6zMl1pNrpicJruG06YRD0tEdlFY4wkVyXXWzmHGJnx+sIHZQ21k81I2mVNyIjQO2EKZrBoTGUIP/3PJMzuJpIhKbQv8ChSaPdpyp6geLj31mRYTMBNoNNdi7YxbPctLTpHc3jcykRsIvVZTsfxjmpRBVg/ocTB5HZ/4Hp8J3aQ92GNfnmUkdpC6w033urYESvpy8i6X++A64zYDnPt7lEug2MoKgI9LaFfepVYUNumLQwl5xLwGDIPI/G8HScaWv/K/+fwJasABpuBeZwU/ct8YmIm3tYSor4vE1Akivi9n85CQAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HC3G+LDwS6UyYYyYzm3IyUkkP/oHIXeiquuHU+Ak2Y8CwrxoXX111RDabj9C?=
 =?us-ascii?Q?6n4WY9dI+3IiaYJqS6yP635k+vq+ibY/gaQkWSiYUcGqf8Ej1zgXROXaPRO5?=
 =?us-ascii?Q?ajDjm4xjxaPRyiePNyc66x01kOnUyRZfMoFHbvSnHtRA9y15piyn0IEUJh7+?=
 =?us-ascii?Q?IuXRhT4dzuF4hUOQmQBbMOF++5dsISirL476R7xdnJYlhZaX8og/VsDWH/po?=
 =?us-ascii?Q?9EtW8TJIz0KOJu/C4Kz4/eMGoaLRu52Azy35exCKOaC6j7qi8oYKIq4A1oZL?=
 =?us-ascii?Q?yO7+6wDQBvUtFh4xoPKz9Z82m4VWZQtQI6QAoR6JGy2UMFFoA+cqoanspEuF?=
 =?us-ascii?Q?807a4DFw4jh+wjTE6IFxwqQYnbKG4rSLSUTauwkh/x9lm4Hl2hAspWodUgQg?=
 =?us-ascii?Q?uA/4YGHSrFgZc3C2D39WGPV60/nNfsdaJV4FkwfMa0J2rwQynd0y+W+CYkmf?=
 =?us-ascii?Q?Cv3AGMywzRe4cMbAZJKDwwLiQnOVPvNXmmR8gM2EquK2mVT9VLe35V79l03C?=
 =?us-ascii?Q?05w/tWHTiczjzo0ZsBy12f2KKsALOe4YKGUR1bMK8tqRaGtyuDNa8yWyw5rj?=
 =?us-ascii?Q?gxGfTU/a2PHPVqvcCqJdIGEL7n5Xa7m1zURE0XZDHaGJ5cDiIAXRNutPQhcG?=
 =?us-ascii?Q?3OUsRsc7GtiKb3kCdmvpcUilkuv8rdPoSxK4Qyl4uGVQUuaoj9XioF2aiz+t?=
 =?us-ascii?Q?5FCiu2v6MgSSdaVp3WrAVdb80T7g63j1G+c9UXmC5x4t1zKgxjUuuIbcdwdA?=
 =?us-ascii?Q?pykmuYQc6mHa46tJkuMVi9LdTsqU4zhy5LpSZWvyDXaagzEPgu/6LkngfTg2?=
 =?us-ascii?Q?JDbE+euj2AM2C7YX+5KdZwrXAVgnLIW1s3UeCf2ydcYRNNy4d0OKnVVV6Kdn?=
 =?us-ascii?Q?MxcXk79/XOZw/NpYtyWOkkrnUjWzvC3VfS7vypgvKopVicU2Sxn1w1KjDbQz?=
 =?us-ascii?Q?fH7jg+eiI5b4ZXpA7gOLibwWd+pnQeRxXF/rAY+fwR+X041T3Igbe2j+zLFA?=
 =?us-ascii?Q?+EGft6u5KQa8JWQuBfkIlBLGJT3kk/PJIQuhU7ft2tK3tCuIo9xNhstvLzQ5?=
 =?us-ascii?Q?6oUX/2PZTTqjD0bqpTxSO76kP78maVLQQqdzjnMHgKbwcg/KwlIQYWo1TCU/?=
 =?us-ascii?Q?T4aJmUn3ncf4B+nh6hCCLYjy3GIDXC4IXgENvFrHqIbm+ggghXIYAe1nTp0S?=
 =?us-ascii?Q?27wOAVBDUXzmhh9MQv+cw7mDcpN3QVqUJJWliQZxvGFFZsE+DpZGde4+qZv+?=
 =?us-ascii?Q?cd34KBY2aUkyz2g85MjbYV2mC8PiuVjh6STxkIxKUqu9tchmc0pUC31Ftx16?=
 =?us-ascii?Q?1EM2GH4OzSGtB5JjZSHP0jI1E6iz4egd/oAqNFw2iWEUVRaY4L/Qtjk+GqAd?=
 =?us-ascii?Q?MRaVPOFBTKaVihNsFS73OF8RorSqiUPOAOKQ+DtzrqNdRVusc0zFtCwFUyUI?=
 =?us-ascii?Q?HInAeDRQaDmUF6UB8mKDbCeaoPZu/+Nk1TaBUKT3LuH0Zzuhkoi5Arb6QSzZ?=
 =?us-ascii?Q?ubkBdzvDWsDtdxSeVXhjO7Xl+SrtAeEqOi6YNC2jy0B2WME8gkDSP1sVW21P?=
 =?us-ascii?Q?2FBKGKouGuzwg58UjtwT2kS0gEhB15J388T47hbooKW0ASDe/pA+SE3IMp7J?=
 =?us-ascii?Q?BkWHxEQHcRQcegRxeG3lKMvl3Z3iSKiWJBKPa+4tnn2INRJOmNZoouVregse?=
 =?us-ascii?Q?eohTfFU/BC67qxy4GJg2cNeyR8fGNACxsPezYjyNgeKQcTzRhOrfbyrnWTIr?=
 =?us-ascii?Q?vei9t36k2A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca0e6a-c499-4489-4f55-08de909a5d0c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:39.8244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5uyWCV995weIIwvekZASkRd6rdApO6+k/MZBQ8mUDt9g01fIKGtrHcNUdeVd84GzXFdg3kC4P8zXjN1mre40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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

The 'default' directive should be before 'help'.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 drivers/ddr/imx/imx9/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/imx/imx9/Kconfig b/drivers/ddr/imx/imx9/Kconfig
index de1f59bfaf5..7b3dbf53dff 100644
--- a/drivers/ddr/imx/imx9/Kconfig
+++ b/drivers/ddr/imx/imx9/Kconfig
@@ -24,10 +24,10 @@ config IMX9_DRAM_INLINE_ECC
 
 config SAVED_DRAM_TIMING_BASE
 	hex "Define the base address for saved dram timing"
+	default 0x2051C000
 	help
 	  after DRAM is trained, need to save the dram related timming
 	  info into memory for low power use.
-	default 0x2051C000
 
 config QB_SAVED_STATE_BASE
 	hex "Define the base address for saved QuickBoot state"
-- 
2.43.0

