Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06E4C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58ECD88130;
	Thu, 28 Mar 2024 00:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PwNciTYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E075188131; Thu, 28 Mar 2024 00:53:34 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E473F88133
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyeVGXvFVPV08AmS9Kxb6t8Xvz9+ico0snJv9d2dkkcbVj5fGyhAhtZ0jMBmmewrB1kLtap2JrKAwmdUyGpJlgJ1o6OqEN88YPKBur52JOTu+SwheQ17Md/Cxi/WW5/oN3GUwTeH60s0VUu5TxqZvdI10jfXCjr6d0E2tLhYIWdRCyeDMqbvX5DWEDxFUAmryxJ2gASnyZOvCJJoBFj1cb1Bt43uD63jdeXb+Mx6XvshBg+PU9Nrk5mpgB8i8hyHYAdmyHGmJ6EKWgo/4tbTfDk3s1iyi/yRFR29fK3a/KETcjW7nb0WTdFmaWY5BkglO20wJ7J/yIiZggmKAvWfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=S8WuvUgm5ZeecrxD/81w2e97QYG8RWEKY3A7YZcCLxUx9OMqBkr5LeZVLuHeFhSjUnOsutacAdMxSY56+05hZQYxYlVgcB6L9dkypgLDk7U4B+ZhgSjG68MAJlKYjXJaWSCdViw7FSw6MFCjOlmsCjDJ1VGhrhBxAiFz0d4Af6gn5dbNzm65vYyq3i0Oz2lA6pWea9+yjevCFTOubC1ROzxTscEfZ2H4RCkTYpcWqbXb4QOz7UrsH1an8b5hmxAmM0KXsUMGF8WZh5Y1pan8yUthwnfo7m8723DADW+Og6DdvmkKUSUL6GZge5GRcnLBI1aHumq3bCa7+8yYMKKB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=PwNciTYie4i7PtA/ivjWVTz3sPn3FanPISHE9H0bmjh5shUZyjW5P6yOgHTHgKm4qeUOYJtdHyneQKg48T6CQnpDoC9J9V73ZgaLoJIU7bblr+A4GHTRRYSiu9EqkEzJaR8N0OzBbYXleIomWxRLzdjbbnHOGtX3toQObj7DctQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:53:00 +0800
Subject: [PATCH v3 3/6] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-3-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 991aa1be-6fe0-462a-a574-08dc4eb91ab7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKNTBY5daocyCXE9gRhpQAhrbtLAaMUZF5P8sh1spzKRRRSoaIjmF+Mv5dp08IwXFSIOopUQTSQ+AL0eupE4PLVl9xervPnz1EQAjG4xaT4BskepZ8m6bRuE0Ew/aMYL5PB5f885+vdO9o2KWL+MpmqMBH0AYpBr8cMXbXKuhrQfiLQzHT9sWiRtRdRHp4ox/FZr8etjsCc0WyOceugSD1HytjgG+vmTvsDi/K6lbKnl6fcuJoEwLyrDY65efESah1A+6fNGisTg2EENeh+ekP0+x5f+hF9nxL3cNlidneMq9so/XpKAMlY6my4/ta0apIX7+0xfHaDQtfLfN9eY5jra11GYYpIrJgYClRVM8GqnKtRoS+5U7ThOa/tRhxgPYWi1XEaG6Y5UdPGcxrChOQUnHSxHDbGK9BSB2Cai53dRFLXBjfwSGqDRZGBRVJ6EQkCI4Ays3hV1ooC0ahdysK9WXGF1EKDi9wK/CnFSPwNuBl2I36ChLBuMZhdUM2vfCYLgpZEaf56sL3dDEt+v2fHuvx6hxBlA92Rz8nD8kap5WypVXNlTkYUSzMMn0O9L3yRWr2kN0xpFE8qjQ1DATmw+LThUjxZD4H/k9OeZyPoapNEDHJWMUjyfDNBVtNn7HxHcwR8PFb917WTFlXLW6+u8kNz+e24agHb1Mds5ye2/N2GJadsfInRYarnQYYwc9J0G/X469pccfLfAqPZmAaWiiv2Uc6dHEkZAF777Eyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlpJQy9jTFBhYVNvaGY1N1lXV2JjTm5HVHl3RC8xRHdIYkgzZG04SUhaNnJY?=
 =?utf-8?B?ckNKM1p5b0x1d3dOWlRMQWVWd2h4Tk5kbDg5ZDVOYk5VSSs4UTdja0pNcmlD?=
 =?utf-8?B?a1N4dkZSYUY3ekkvRG42Vy9JSDZrK3N2Y3E4cWRqbHMzSVVOTVE1RWNFL1I0?=
 =?utf-8?B?b2ZDc2hqSDhnTnhPUVBtVHIzdUt0bUJHclRLbEFDcjZSMzh4WjR3L213U1Ri?=
 =?utf-8?B?Ym1MejZlWXZCSEVEZlI2UXZ0VGxxSWdQbXB0UDJDVmJRU1RDWmN6YzZQOWV5?=
 =?utf-8?B?Yy9OTDVCYjlieDdLdDFad1FZTko2Z29SMFY4YjZERG5BRlNkOG5DSXdxMWFL?=
 =?utf-8?B?OE1XaS9kUVdqcUYwUTM5QXlaY2NQME1TaDIyUFVvK1B6OVZFSVZCM2ZyNVBF?=
 =?utf-8?B?KzhqNXhPQkM3SG5WcERLUXdVMVNWOHpHcFZxRUVPcmZ1Y0dKem44dEtZdnFC?=
 =?utf-8?B?b3hpcUJPZ2IycWdyWGs1UWlFR28zSHZwOWVhMEp5ZDIxTllkZExiTDdrYWxi?=
 =?utf-8?B?eU9kempYUjZjcVRHMVUxZFNleVZ3ck1OTFpoclZzaXlKMFB5bnU1T293U2tB?=
 =?utf-8?B?ZFFXZUVLU0I4ZWFjYUwyM3NEYW85bHJsaEJ4eDJNZnFOOVQ3V2h4bGNUUWIy?=
 =?utf-8?B?ZXh0MkwybjlMRzc4T3dYcVlvSWUyb0NqY2hSaDU2bGI4VlZlalBxV2szTmls?=
 =?utf-8?B?U2tZRk5mNTdGZmFxdDJ5N1g2Q1VpeitMbXAwN04ybkdONWtFaEhpNnFXMkRy?=
 =?utf-8?B?NXhya0RsTE5kL2ZoNUJSUnZRYmJ2ZmhEbjlXeUJ2OCsxZFcrNUdYTU9vc3d5?=
 =?utf-8?B?MXJIeWtGekFmYk9WS09sY1h6Q1BVRytHdFp2UEdzZHNMLzI3emdkQlpBTkJ5?=
 =?utf-8?B?WXVWYjkvRGE0S0g4ci96Yy9UeUFDR2ZqWDlhUnlkaExTRXNoVW13UzBHOWJk?=
 =?utf-8?B?VlprcEZEU0pvSms3V285RDl0d0ljWjlQdUpZYzNraW0vZkZqekFhRXVreUZU?=
 =?utf-8?B?NERwTlJUWmFZbnZvbWg1QXVGWmN4TW1nRHFMREtMclBlNU9QTnpHdmVTZ3Bl?=
 =?utf-8?B?eGlLc0tXNkFaT2o2N2FMSkZoOGsxS1N1UTYyTWVyaXRodWVvUm1PemRlQklq?=
 =?utf-8?B?RGQ3dVNXRjBBWTVseC9kbmxIK3pZd3MwOTkvbTBjZkQyV25FQktrcWNzbjFP?=
 =?utf-8?B?NTlpdXB2VDhPNXBQRWdnNmJ6OWpvUUhabTJKVk5jK0ZHZFBHVFhGZEF5V0J0?=
 =?utf-8?B?MCtRZmhUOTViUmFOZzk1eEhwQnAvN0pBZno2RmozdVE3dXRCeVkxT25nWk5s?=
 =?utf-8?B?dTc3N3MzRmJkWk5GZHk2K1BwZzBmdmFYMkRNWkp3akZNVXppMEMwSUFCQlNZ?=
 =?utf-8?B?Yk8xbjVFRnZuUFdBak5najk5SXAzaUNLVlRQMzBNdEVuYjJVbXFWV3dCcWk3?=
 =?utf-8?B?YTBvY2E4cXBBRjk3T1RjenFZZUxScExRdU1URFNmTTl1b0RFcWJBd0VzOWhu?=
 =?utf-8?B?SHdJZDF0azU4c0cvdDFOb0F5N2laWmtmSVVQMTROZE16aTZDVFBWK0R6dFl5?=
 =?utf-8?B?c3I1QmRRTitOMWVxUzdlR25JUDU3ZiswWlRrN1F6NXA1Y3liVHBCNUxleDhk?=
 =?utf-8?B?cUx4TEZld0lJSnp6WHRoT3hyT1M4QTlyWW05STVraHZRd1lnTFk4WTdvTHVF?=
 =?utf-8?B?Njg4WkZHNm9VbWNENlFFWFVqVS9FOE9PcXdpWWZwY1N5d2pvd2VLQkZpQ0hu?=
 =?utf-8?B?NDY3YmI3OFpWMXFCNUVPTGt5bXVoRkRXU3Y2L2dZV0VDeWMzTGJYUWJ4VmZp?=
 =?utf-8?B?NzJNc296cHVIQzFMOHlsOUdYeFVPVmhacUJOSmJCUEJLS2k3czJGeUNTaC9n?=
 =?utf-8?B?RXdaU1A4ekpTalVWb1hOWndCdmYvTzU3eHFrVGd1ME4yS1dndSthd096bkZw?=
 =?utf-8?B?QnpHcll3dGZUSlNReThoY01oWFdZQ0dKRTVDODM3ODJ4OWx6VXlUSE5sNVpN?=
 =?utf-8?B?NVhoazFhMjhPa3hXaEdKN1h2RDlkcmJaRzE0M0kzQzBLUnd2dndNREdIUWNZ?=
 =?utf-8?B?SjIybVgvby9nWElDdGRtTjBqQ2lGcnRrWmxDSEhHcUZKcGtsZVRXNUZDMjhn?=
 =?utf-8?Q?xwb7IYebIOVBpIH2qAXJk52ka?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991aa1be-6fe0-462a-a574-08dc4eb91ab7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:30.4876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoXfvRpWwHyG7L9bG/aq45s0co/LQrI6nNwgCy/B3UXBduVr8kag7ng4J1x995pquHFrUxil//lR9+k7dJgd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

