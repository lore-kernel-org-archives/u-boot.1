Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCC9C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8983E880E4;
	Wed, 27 Mar 2024 14:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JOVnXkp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF3D880E9; Wed, 27 Mar 2024 14:11:24 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 913A9880D6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5iiJe52jMbEknmL0h3yBl0N2C9uQB0kmPp924wX829S8jia0WetzYN94vGvXW+wOMscpHL47dc6PRcDVv3JTyQ0r6QJb9uNemwnOn0vKaFM4hctMirQZQ2QoOYJ766hb1i1kyzdUFiXyJMQ3r29C+fI+L3AjvC6CLbpum/yyfiP3Eu1QAjp/8YmxDn8EfrCGwMZHTvsmKXfDHghpCyCSszpCa1D4dLuTHwmAPwtpKmBC5dLSntHytB985gjRAj7cTIXa9bsNcXYEfR/VJ1EP31nviADtndGldOFyerfqL4XzQsmFU5SQyhG1u1B57Q1bs9uzI3wxwu09qHi2jqXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=WAVhA/kdU2Ude9UZ84IfnFY6M8mOMmtPx9gJC8RAVG7fQLT3KRENz7qFR/N2cw/ELeotLTABwH/dWht7LuAMqp5UMM6PIMiHiFtXTBLyPTZnYawhDTnhlNKhfTYGjbWonf5laDQ5rMlMLPiWGAKX2YZt5eAbWpWv9TEAmCPIoFF2Oug9qgWh34u2SkaiE1lxb3/C8okqqvkAal6mTsPqJ0TGYD2wmM2uJKpYhvza8FWUg8F1XAyhgueOpguSjymfwsPgZQVXaszHxH6mk7S1oIkfNjaYsbbjIDxFdfEQvv5JiPDswdtn+yMco66BxykRhQwD2rlJiGlfBxAXchLosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=JOVnXkp6e4o1ecXcub71mrnc7FLJQwfopqLemnASbLg9XytAEOFxetv7NUDVLb0v33a8KFHIGHtTwSLxpRsRxuNkZ0tfw8I34I+FitYyfQoPKuqNb1sRUHteKavG/AyEe/jJgDQJL5gdHC2wvYfJNNXK23iHCofEQAZOoYM3q4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:47 +0800
Subject: [PATCH 3/6] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-3-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4a8dcd-0a7b-42a7-1948-08dc4e5f63fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1Nh1BmdPfdCrYCMtvOSYbIUNRH9wK7/PdXzAcpj7/6LyvK05JMar5I3FVMKpFU/uNgJqqYX2jRjlyiwoPx+BxOcl7gwn1IpErr5nSB+Smva0AMOB0tB8W7ZL8HcerFE9WQN/IxU1dsxxptWF0cSh6MuQYam355FQ7QhiTCwLqrNzJbXo2T+iN2nZBPwq+xVciH7oRF1ixjSGqElQHSopmwnEWLoSsNVNz07i5glUZM+U6VyiCyJg+oKhYEZc9zpLF4TI46LQNQ0j1ItWY/dyQCS0kr0+RmM93wmmBwSwzuxymkjzu/ShfyuB+fUZkq6vymu/nFt4uTI2g4Pu5R9G2v7REx2UizI8PDdb1hbMBjw5UJ4iWvrCncEAJPBmtaOrG/z+ilCEFpb4yYHHjLkfnBYXl+6t4h9AWWm1q+/TVyjqGWhqiOFgOZgQEVtRznavX6t0pCguXQj+WxyfszCdgvuj/L0w2493mPvuSpfg5E44MndFYyHi6Pa1RyEVjiiGKdj021aOtkRKrimZ1ronyszjwyX6WLzTUDq29HxTnYP70u75rVsf61l6CoP6iDEeGOgTJJtGnL4ihe22EMVcxJNWBAwuS4xXRjFU0l7/hLBztQ+NA4R1MmWRS1u3MiChFMkXLH934aTdjviBaGLymfM9TtEOL1uxUwjchbnz5+BK/FTOAEnKMrZ1d9vGj3FUR7Q/TmqVaksZpJiz+6ho3340Ls17Eb3fxzU/o1wEgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFVSdHNVTFVUcmpFMVNYVmZkbFBNK2RvV08vNzlJdjh1MnNLMXFiQ0RhTzJu?=
 =?utf-8?B?S29meDBiQmxxdkdZS2ZLbVYyc2dVajZNb3BuR0Rqb3pPSDNRWW9LaWhWVDR4?=
 =?utf-8?B?T01yVEtZU2cwY0lqUUpLTmdMQkFYZ1R0b0daOFMxaWRNaTAwYW9FbWFmVlIv?=
 =?utf-8?B?c0dCd296UHhRWGFuN25yRy9KNW5TR3U0YWJReTM4blFoMW5xUUxvbW5EeHoz?=
 =?utf-8?B?eWJKM2owTnJIZVVNM1pUOUpjVzNJUS8zNGgzdm1Ic0JVK3VrYVhxTXBYQkE3?=
 =?utf-8?B?N0h5bXRQYjMyOFdkMXY0cE8zL3Y2U2FPNGNCdEtLbDlkQ01GODcwRWpNYmxZ?=
 =?utf-8?B?M3pFWllzWmtKQWxUQ1BaOE5WdmtzQjBwYnlKc2s0ZW1xM2hEWVU1WjdsSWk0?=
 =?utf-8?B?U0hsVWFRUnBvamNvc0lPZnRiOVJhejdOWG01c2diV1Rxb3p0c25YcUN0U1lS?=
 =?utf-8?B?NVM3ekxzREt5Y2hFa3hCMC9RTjBWeDFENUdVMGRKNXhHbXVPTTVBeFJGRzdt?=
 =?utf-8?B?WFpucFVnUFoxL3RSUXhXRTQvY3p4S1NpUThWRDZ6TE9DMU9ERzVyejVKKzNt?=
 =?utf-8?B?N0VsTXhZS1Z5eklHTGJ2NmxCd1RhV3l2NUFrYzFBZlVNRGhhMWdjZjRYNzNQ?=
 =?utf-8?B?S1V0UEVXYUNFaFVmK1RjbS96WEg4NHdWUFpMNU14NjF4UnppUzBTanZkTzd4?=
 =?utf-8?B?SkFNRC9MRHphZFpmQ3VXMEh1SE1HVjF0b1lERXNpdFVrV2JaVWJlcDNLb1p4?=
 =?utf-8?B?UnJmaDc3MDNtNmxiUGxRTDQzZTJPQkF2YmdmWWNzSjR4QnJhQjI2czhRLzRh?=
 =?utf-8?B?NlpHWGFRNXRmYTNuaHNPVU1EbmZKcUJwTEVpWElNRlVXOGtiWERlWUY2Qzkw?=
 =?utf-8?B?SWtMWlRzYm9FTEdFdVhnSC9zTHdibCtDNDBZL1l6R2lvVzRtMHNtcGcxRnRV?=
 =?utf-8?B?d1YvS09NeCt0WHJibitCbXYvdkFCZlNnVFdaZnZ2OE80RG5KbGQydlFuVFdH?=
 =?utf-8?B?cjJYOFpPeFJOeHo5czFFTnE5QjhXNlNJYy9lWkFTeUJDTlNjV3cvNVV1a3Iv?=
 =?utf-8?B?MG52ZjFVZjBhanFYVnVKOVJTcm9GOVQ3OExXT3pndXc4ZGZKUDFiTmE4dXlP?=
 =?utf-8?B?ejVVaW1Jd1NyUFo2OE41Vkx4Wm1ycHZTYmdkNWI0aHBBUjFCamw3dExMU29P?=
 =?utf-8?B?bVNrTkh4TlI1NTNuWTQvcTRKWkxTV09DWjQvdk5zN2hIS0U2UUw3ZmpjOXlG?=
 =?utf-8?B?NEJ0TENVaEpxYWxwMS9RaTlpbk10UythME1tQUROOXBWbk8xaWxCV253WjdE?=
 =?utf-8?B?cDA5VzdrZnJVSitIRnI3MWxFT21VVGZMMzdiWmxraVVPanVaQ1BhN1JiNm9N?=
 =?utf-8?B?ejMvV3ZVRVJ1UnZqRmREcTB4MVprR3lqOWxEcDVLQ3Jmd0h3b2R1LzRINzQ1?=
 =?utf-8?B?aGFjMUJKOGplb1g5M3dVV3BIM2g2d0RUZDM0VEtMc2lqSktCZSsvQzRZQ3gy?=
 =?utf-8?B?UjAyV2F1K3E3d2lZTTZKdUp6bG91Mjhpd25vWUJpZVhYSXJXZ0ZXS0FZZ3Nh?=
 =?utf-8?B?WDFwdURsK21HZjRENVVlZzR0MXZyVDR2TDBhZjlmM0c1b3NHNGxUV3ZISnE1?=
 =?utf-8?B?NmQ5SlZZTG1VbFcrZHBJc1pzbS9VVlp3VmZseXJBZ0pFcUUwV0lZK1VtT24z?=
 =?utf-8?B?bFgrekJnVXRWQ25RU1I4MFY0WDlZQXNCNzlnRjBlYjVOOVZmUUlQYm9MdTkw?=
 =?utf-8?B?RCt2cVI0UVRQczFaemxUMzBrMjgvNWYwYWh0RXVQUDllNTB2czNFTWxSaWdE?=
 =?utf-8?B?WUVBWEd6Mm00V0VuUnBnS29WNno5ZlNFQlJuQlhmYkQ3Z1JOcGEya29OL2xR?=
 =?utf-8?B?RGtIK3pOL1JFM1F5TVZDV2phRGdSNnN0b0VmL01scXFISW03eFZwQitJWDd3?=
 =?utf-8?B?WDZTMDU2Tk9LaHJJSjBFWkxacTA2b21KdnpqQmNDSnhabEJXM3ZvSW5WL3ZQ?=
 =?utf-8?B?eUY4WEhRT0NKNTdpZHk0NXNZV3BPY0tELzhXcmtxeElnd0FEZE4wOCtOYlBL?=
 =?utf-8?B?Z3ZUVDFabm12M2Z5V2l1U0lRWG5GTXFXTTZCejNOVXY4U1Y3UTVYR2lxWDc1?=
 =?utf-8?Q?dICqsZRVW+gVHhlU3CUeEgw1R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4a8dcd-0a7b-42a7-1948-08dc4e5f63fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:18.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT1iE+v/NvdCMYidW0kleY5cz7cwf93o6vp0ukIMHNGLcfOj068kvNQkLOA3NWBZnDBoza6cZmeYd6btmJGuuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

