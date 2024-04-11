Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C5ECD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6D4881F8;
	Thu, 11 Apr 2024 05:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O0NLdjOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DEC87F70; Thu, 11 Apr 2024 05:23:11 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D84F881D0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVDJzMdtk5xUgfENJ18ibRD8I3uo5wJ75I9xE87zaCRwsfhyRDRTlfOURjs2fHzQU10I8tcnEtc5dV86gXI/YVe3hNTJRuNa3HqXoDz49dh7+hAuwG9yWuHcWYE8XS8wCOLpqGRMd48wkknyph5hlvmKN4NMi75kbnn8gYHY0u3aDVxNOSxrv8PikpgBYqx75s4PDahpHMwEddRWUdZytDq3r2l0EpZnZ0ABieJBAFlPQn3W37f/pgrbmDNERtma1OqRJYMO9yvFlDAYr1zLCg4wlbMthsh8AWuT/5C9uOdcX96dtYwVmG+8uajN8QGOJD3bcv+PQHnaZScPCcsqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=oaW9+6cPClgBbwLF8aZycNSlf5X8kCz1hd2VNZ+DiaEeM/q/6w2DgLyL/NecCuDE1fRGuoFbJSzohciQS8RxjMPyYm8csH3RQrxjfqMM8W9o4ezbQvONddXBz4vFRY45asSUg+0jc4dMZq4NHrXzysrVluiPpITajZKcL+YyK56YEy0js+OttqEHZXMeNDn48ShA6Tmac5qcIg0FBexDr5bTOJz201YFf9XEKkDmSM0awPJAxt39m1SBCwhRA+6ikXSVDSF9HanKVJaqtHgcCH6HG3NAuV0FmVw1yUNG4AbwKJrCaHVpsMj3KtRwoe7vzi8Jwqf54xg2//fBWcfXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=O0NLdjOS1IbFTrM1orQPsnf2ifMsM3JavLSNTW1S6/TRw/eQsZe3TE2foqcQzH0J+/2g91NiJoJUtdXVDQ6br5u1ZwkGJ9qT7GNZMfQWOO74ImUQoTRVAOLMJ32Hyy8TCDtA+wp4lju8LAT7wjlmbGpp+8AyMn1CQIO3XCLBT78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 03:23:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 11 Apr 2024
 03:23:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Apr 2024 12:23:01 +0800
Subject: [PATCH v5 3/5] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-imx93-of-v2-v5-3-9eb3c64ff160@nxp.com>
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
In-Reply-To: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e5aba9-98bc-4cef-d568-08dc59d6b521
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+pymsrOkErNIJZXDIAJ0hg1GBe7oeCw0FVH3lkrsg+oA9uwsNZTmTkYitqEia/A4SjvhHDXtonwyLtsMkaJLbTCeqalyDuqLcYUr3yjr9U4pb7EY22zjfgUyoKimf7n5Ac4Y4zFOVeuX9TmmLdFACwCbaS/jgj87GezTO73RH/oNVp81O3csGxU6yenD0kYxDubT8jMT6XT2NcsOAp0K1BeW57pUdPRfaeHTXu964mxspsN3zkaDA0yBb4YMnau7NPjjzrxNrV25bo0m65oZcIrr+aJGH1u4TpQ+wmwQuBjfZ9wkA+bvsaRfAoUglIx6eGJQpXAF9pADE6V4uPIBw6meO+WAH4hjAU6LViuik1PcbGB5+2SHuJSEguNKVIRC88qYZQhqODT4D1+AOs/pCrQJKGgq64ypUk83xD8715Q0U420s5bM+h9+F1IOm0tPl/BI0zVlTb3tzIbU8J6fk9FJ2ktqi8Hffw3ggkticdVA50nBQZfeaaR72a6hAl35PXtls79zOl5X841fJdonE6CbbpGhOe5tsSuEPJlvnHZmpfRvz+l1Q5J+VSKndbgXlFoi6msIBAzjOJ+c0fzDmaNwtPv2cH+mvDxaduT8AFsEVkKCgdnunhaMy+egJwP/5vzKVFOZE5eCMPg0uanHfZ7Kv+3zkVphZn+hpOkoC+qx1cb8Lbxewcj6lLpe6FjpoU9gdh9W/rqs45NpC677QLD0rSjuqdbCQgOZziAOWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NPRzlQSUpwUTJ6dVorbVVXZjUycXJYSk42eGVqcWU5S1MxNi9Qd1ZWWTRO?=
 =?utf-8?B?UlRhRWFGS3dGTDRKeHBRMnp1RWN0M1Q4UWxMaVJxSkRsRUNpVTMyVldnWWdv?=
 =?utf-8?B?VWNpMGdJR3oyb1RsOW0wNGYwamRMRFlhMnBFd2x4ZHZES3ZsK2FsaWZrZEhG?=
 =?utf-8?B?bnRxNTJrTXRYN1k1TTcyeS92R3FZWXBjbmhtSU1FeVNQMlV3Y3JIZU80ck0v?=
 =?utf-8?B?bys3YlZscEpwMko4SS9JMWVTM3NMcnpBU05kUUdOMlZERi93STlYSCtwM1hD?=
 =?utf-8?B?eks3Ry9MSFdXNm03TTdqVHI2YlJGalJVOG1CTTkrSkU5RjlESk00WlRML24w?=
 =?utf-8?B?Q3I1YS9oYVhOOVZtMFM1SHB2UlBkUGdnZTBQWmlwZm9UakRzY0I1Y3o0V1FG?=
 =?utf-8?B?K2QxM3o5bTF0UmUxa09NYVMrVVIxQzBSOVVaem9OWlp4M3lYZUZpRXJ3VWVR?=
 =?utf-8?B?eVY2cE1yYU0xdWZuL1FPQVdYeUlXeWxEeEdvM041N1ZDd3RqemR6QkRmSHNZ?=
 =?utf-8?B?VEtXTWtvRjg1RFRhSllISk81TUc3T2o3TUNHSHJvU0FZNlNVUGVISTdseFNW?=
 =?utf-8?B?eTcwVlVVekRvOVdvWFcyLzE1NXd0SlJ6S2ZBRklNSmw0MFN0dEpneEZ1a1Zj?=
 =?utf-8?B?c1NnOFlLU2NIclNMaDBMd3I2Z1FmZlB1MFVMZHhpbHpKK3Y3YmZhTXpjVUNv?=
 =?utf-8?B?VTdBNWRPYTBiTXZiYXMvU2gvczdpT09IREMvVmNERjVBZDdiQWhyWVptRlVo?=
 =?utf-8?B?VVFTV1Q1NWlKS3ZUSWxZN2E3L3dqT045azlzWHk3bUJ6NmErUzI0bjlHdW9R?=
 =?utf-8?B?QzQ3RUE0WjE5Zlg3QnI4WUxRaUNPQmhhY01TTXZMNkUwYnYya000bkd5c2xR?=
 =?utf-8?B?Q0pHdURCTG1POHFkSHplNHBQbU9panRXdzNoOUxOODRvc2pNc0VhZ1NkZlNi?=
 =?utf-8?B?ZGNyRkRGVFNTV2RUcDRoY0NTeGtrek16Vkw2MjYwckJLNFFTQ1VXQXAwc2NO?=
 =?utf-8?B?djAzc255OEpvUWp0M2pYWERzc21JZkg3bGxRd1pidnhGSlFZWnMzZE9UV0RL?=
 =?utf-8?B?blJHVG5TdVNtMEQ0OTJXbU5ndVU2OXZLZmdMbGV2Y2dpNXZnU0JPb2V3VHVE?=
 =?utf-8?B?Mnh6VnhnNlBPYnh5dUtPaXVSRTRXYnlZR21DbVE2N2x6NFBXVDFRa1NPQ1RY?=
 =?utf-8?B?bWF0TktoTS9lQk9tYmtiUlVqTU0zZkFGcURLTm5KeVlJWGptdTFOU3pMU3JP?=
 =?utf-8?B?ei9QOUtyRGs0VG53TjRsTGs1QlRRZDR2bDdPQ2Y5aWp6cHZmYkt3c0VqTHVh?=
 =?utf-8?B?OXU2ZWJOMi85VlVVdmJvVVZSOXE4TFlBZ2pxQnhKQkJ6RmNXSDlISitJOVA3?=
 =?utf-8?B?eUlsY1RnK3Q1UGlwV0RrS3Fnc0dIbXBMa0p1aTFWQVAvVjBDL3lEeTRBam93?=
 =?utf-8?B?Q2NFQTRaOUVSd3lCaVVrRVJjYmRMd2VBakprRTB2VHdnelN1MVBSMVRRVFRM?=
 =?utf-8?B?UTBxRGRzdllrOXNEcUw5cWVuTzZUS0hNZk1NVUVMbUJScCtuRW9RWnNESHJa?=
 =?utf-8?B?ZnpESVZoRFo0OXgycmFQdXkrUWFNMDlIT1A2WjF0NUgzYlpKNjJxZU0vOGxK?=
 =?utf-8?B?Mzg4Zm5SM1ZRbDFoSVV0K05JU1VjYjRvTUtVeDVzU05GeTNwWmUwL0p6c0Zq?=
 =?utf-8?B?ekQ3Q3NZZTdQenFNejZwWjZlaHFXVWZaYktibSszQVdmMytWSGxCTUpvV21N?=
 =?utf-8?B?YUVtVjVJQlMraFFRNEhZS1REa0JtbXAvcFo5SE1MRW5CS1JXdC9lb0g4RGZz?=
 =?utf-8?B?bWJ1Ky9haXd3NUc4UWxMM0NXQXVianNjeHRFQ2p3VWhUbkkvcy9SRSt4bzlU?=
 =?utf-8?B?NHh3cThpTGNtQlhuMmZONnpVbitTQTU3VW9vcmVubjRicS9Xc1lqTzBvVXNy?=
 =?utf-8?B?aXZtaCtkYU9uc21iODBMT3FsS2RUUUZ6RnRLMUFRM0MwSWs5N2tRenFMSVJr?=
 =?utf-8?B?dzZrV0NCazZVNFFFWjE2UVYzUU8raE5Sd1hnWVVZaGtiaitXRG1IRmtjN0tQ?=
 =?utf-8?B?dnRseHJGc1RsUXpjODZ3VXczajArWjcxZ1dZaVRDVkNwNEhLODZ6eWV4V3dW?=
 =?utf-8?Q?Ni4vqpOOnCknk8anlvCaH+urV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e5aba9-98bc-4cef-d568-08dc59d6b521
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:23:07.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNiEVUTzgeo1Hcqk/8hd5+j7rOZP1URThCbbdQsUBnAlGptKCU8IF04F28upehPxk2FIfm1UmJQuyLyzgufHfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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

This was wrongly committed, no user, remove it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/cpu/imx9_cpu.c | 224 -------------------------------------------------
 1 file changed, 224 deletions(-)

diff --git a/drivers/cpu/imx9_cpu.c b/drivers/cpu/imx9_cpu.c
deleted file mode 100644
index 66534fe6d17..00000000000
--- a/drivers/cpu/imx9_cpu.c
+++ /dev/null
@@ -1,224 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2019 NXP
- */
-
-#include <common.h>
-#include <cpu.h>
-#include <dm.h>
-#include <thermal.h>
-#include <asm/global_data.h>
-#include <asm/system.h>
-#include <firmware/linux/imx/sci/sci.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/arch-imx/cpu.h>
-#include <asm/armv8/cpu.h>
-#include <linux/bitops.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-struct cpu_imx_plat {
-	const char *name;
-	const char *rev;
-	const char *type;
-	u32 cpu_rsrc;
-	u32 cpurev;
-	u32 freq_mhz;
-	u32 mpidr;
-};
-
-const char *get_imx9_type(u32 imxtype)
-{
-	switch (imxtype) {
-	case MXC_CPU_IMX93:
-		return "93";
-	default:
-		return "??";
-	}
-}
-
-const char *get_imx9_rev(u32 rev)
-{
-	switch (rev) {
-	case CHIP_REV_1_0:
-		return "1.";
-	case CHIP_REV_B:
-		return "B";
-	case CHIP_REV_C:
-		return "C";
-	default:
-		return "?";
-	}
-}
-
-static void set_core_data(struct udevice *dev)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-
-	if (device_is_compatible(dev, "arm,cortex-a35"))
-		plat->name = "A35";
-	else
-		plat->name = "?";
-}
-
-#if IS_ENABLED(CONFIG_IMX_SCU_THERMAL)
-static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
-{
-	struct udevice *thermal_dev;
-	int cpu_tmp, ret;
-	int idx = 1; /* use "cpu-thermal0" device */
-
-	if (plat->cpu_rsrc == SC_R_A72)
-		idx = 2; /* use "cpu-thermal1" device */
-
-	ret = uclass_get_device(UCLASS_THERMAL, idx, &thermal_dev);
-	if (!ret) {
-		ret = thermal_get_temp(thermal_dev, &cpu_tmp);
-		if (ret)
-			return 0xdeadbeef;
-	} else {
-		return 0xdeadbeef;
-	}
-
-	return cpu_tmp;
-}
-#else
-static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
-{
-	return 0;
-}
-#endif
-
-int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-	int ret, temp;
-
-	if (size < 100)
-		return -ENOSPC;
-
-	ret = snprintf(buf, size, "NXP i.MX8%s Rev%s %s at %u MHz",
-		       plat->type, plat->rev, plat->name, plat->freq_mhz);
-
-	if (IS_ENABLED(CONFIG_IMX_SCU_THERMAL)) {
-		temp = cpu_imx_get_temp(plat);
-		buf = buf + ret;
-		size = size - ret;
-		if (temp != 0xdeadbeef)
-			ret = snprintf(buf, size, " at %dC", temp);
-		else
-			ret = snprintf(buf, size, " - invalid sensor data");
-	}
-
-	snprintf(buf + ret, size - ret, "\n");
-
-	return 0;
-}
-
-static int cpu_imx_get_info(const struct udevice *dev, struct cpu_info *info)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-
-	info->cpu_freq = plat->freq_mhz * 1000;
-	info->features = BIT(CPU_FEAT_L1_CACHE) | BIT(CPU_FEAT_MMU);
-	return 0;
-}
-
-static int cpu_imx_get_count(const struct udevice *dev)
-{
-	ofnode node;
-	int num = 0;
-
-	ofnode_for_each_subnode(node, dev_ofnode(dev->parent)) {
-		const char *device_type;
-
-		if (!ofnode_is_enabled(node))
-			continue;
-
-		device_type = ofnode_read_string(node, "device_type");
-		if (!device_type)
-			continue;
-
-		if (!strcmp(device_type, "cpu"))
-			num++;
-	}
-
-	return num;
-}
-
-static int cpu_imx_get_vendor(const struct udevice *dev,  char *buf, int size)
-{
-	snprintf(buf, size, "NXP");
-	return 0;
-}
-
-static int cpu_imx_is_current(struct udevice *dev)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-
-	if (plat->mpidr == (read_mpidr() & 0xffff))
-		return 1;
-
-	return 0;
-}
-
-static const struct cpu_ops cpu_imx9_ops = {
-	.get_desc	= cpu_imx_get_desc,
-	.get_info	= cpu_imx_get_info,
-	.get_count	= cpu_imx_get_count,
-	.get_vendor	= cpu_imx_get_vendor,
-	.is_current	= cpu_imx_is_current,
-};
-
-static const struct udevice_id cpu_imx9_ids[] = {
-	{ .compatible = "arm,cortex-a35" },
-	{ .compatible = "arm,cortex-a53" },
-	{ .compatible = "arm,cortex-a72" },
-	{ }
-};
-
-static ulong imx9_get_cpu_rate(struct udevice *dev)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-	ulong rate;
-	int ret;
-
-	ret = sc_pm_get_clock_rate(-1, plat->cpu_rsrc, SC_PM_CLK_CPU,
-				   (sc_pm_clock_rate_t *)&rate);
-	if (ret) {
-		printf("Could not read CPU frequency: %d\n", ret);
-		return 0;
-	}
-
-	return rate;
-}
-
-static int imx9_cpu_probe(struct udevice *dev)
-{
-	struct cpu_imx_plat *plat = dev_get_plat(dev);
-	u32 cpurev;
-
-	set_core_data(dev);
-	cpurev = get_cpu_rev();
-	plat->cpurev = cpurev;
-	plat->rev = get_imx9_rev(cpurev & 0xFFF);
-	plat->type = get_imx9_type((cpurev & 0xFF000) >> 12);
-	plat->freq_mhz = imx9_get_cpu_rate(dev) / 1000000;
-	plat->mpidr = dev_read_addr(dev);
-	if (plat->mpidr == FDT_ADDR_T_NONE) {
-		printf("%s: Failed to get CPU reg property\n", __func__);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-U_BOOT_DRIVER(cpu_imx9_drv) = {
-	.name		= "imx9x_cpu",
-	.id		= UCLASS_CPU,
-	.of_match	= cpu_imx9_ids,
-	.ops		= &cpu_imx9_ops,
-	.probe		= imx9_cpu_probe,
-	.plat_auto	= sizeof(struct cpu_imx_plat),
-	.flags		= DM_FLAG_PRE_RELOC,
-};

-- 
2.35.3

