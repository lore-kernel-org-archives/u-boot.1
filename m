Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592DEC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73795881F8;
	Fri, 12 Apr 2024 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SJJTiOr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE05587FE8; Fri, 12 Apr 2024 15:24:58 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72A1881C2
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdOQFXlfg7ugsMzi8P155ws2cd2mOcecHiqXl95/aEvfZiDP6+83HrGWhy0Ng/HzjodlfTTEZcTgyLfRQhu8PuCDbdmr0th1F1i+cMcc0UD523bwhtgjvAXZ8VfMqUjvKs5VMFXxb8VE2ajVqb17cGyvpEI+BAZnflk9OXOoW65Bv9Qh4GQWJslfIxiAJ4t8i9cxqKa91wmbw72GSST2esr3RVQUhNPl6S5vMg1+8RFklLq8LPI7CGxfX/rvUy7o2CiHIVbd8IFM4d1YXIDNT3FCMkQZl3Bn0VPTh/vsqDQCQo01mW3+ZsLSYGHBeOWBcxB7Mu7+PVxXqB/CGktFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=JX53u4QOtIgom88aoU5N3PmPuqQBxHoCfmZuw6azBKfagF+S++FP7y9Oawvtj3dA/nuAovwx1JKaTOOMj6aaCwntfekEOwefqodKg1fSyb29pfNIBcImtPJkUw5g26xA9cjdYg/0Bqi3x7SIt2HREMjic2ZP1xsROW1qu9IeR+3vwgqTk/Zf7sfsm6jcp5a8iWcGvYVQVt3ObcsYHSgiQ7PBMNC48iZd9Ig7LVCdtMEIRDZQeHUy71BZbFpw9hSmy5HmsBSBj7ZZInCPelTc2oWFzN385n9DCtq77UZmOJ3z75CsCDi5s+CFCNrO/qLfVduxC13slFdyjkM1b5ul+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=SJJTiOr4jtER+sUpZxz/giMkLBOiuI/lKd11DNPLjUUolPueP9+gQVY0Ajd3ThM8php9JyBUx7ey77pqE+/b2nVnEa6UtzfjnKjkHrWi9UXyhsHnpU9GswFAN4y4mZt69R9u6xixb4cz6kgcrxS3BkbD6WI6ajUt1kNi4LqNhTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:24:55 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:24:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 22:24:53 +0800
Subject: [PATCH v6 3/5] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx93-of-v2-v6-3-c2ad48e46eca@nxp.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ee0895-07b5-443f-c17b-08dc5af3f166
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoI7mXTZ+vikeTVI0grpK9r9lS2MeedKEWglnrpaOmkdbZC3zvn8kxiVQCDtdK7hqFeZDhT+EwSTsxzWDOJKfyIAdsuDcChGq/05iC9NwiYVdEgUEXvQQ33ncouJ4Wb5ylBdPb0JKD/WsWsCyPyBuK8WPLmFSjJhUzFWOjkzxvICtFb5E4HqotB9nURnpKJYz1xIM13dSACISQUAu5Lx/bISNA3BqIgurfUTjjzrZIpAqI4L1bXT/gcuSHL3bAdD3zUzVahk8knzQgygMmyPGOE2BW84fkaUiDS8MumWbV12C7fV8C+M6S6c29wWdaMJiV4VGNCfYqhH4FmlAZDpJBT69tsfrRtDpL2jB81RI4jLxoCxkWac0DJntyKsdt8DRGIAAJETmLxGZHkAuYwh+E3cVBlnNg3V3mjTyk0FS17/M/WSd547Sbf62gEXZ2qoofFRMnxip0fc85jj2bSpa3DdR4g7sG2tLkUpzrKun26wpkLiYBGC8xlzlgQvH2ZQZWEl8VlYl7XJEBrmP6q8pzZQxGg5iO2R2+g2FO+clG3VYqz+x2R/C8Yz9Wh0Y/lBGgaa3rAa6oHKKXl/CJr4lEPBkxINvi+SgZ6LaBUhxYAmqubAm4sZxbE93w9Iq8tdppj+erU4v9XB4+c140rhquFByUHkpuMOGKa8l7d25GaHXO/b2yiL/C/DoQscvOZpgEeW5KOsqINUBMIQlA4nKKYxRJY74tB8r8y5lZ0+Abo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpFV0VVS1BJUEJZRUdNTUFNZmUyRHNrQTA0b1lRYjYyazJaTXZNL3RqQWhH?=
 =?utf-8?B?TU00UVEyREo5bDI1T1BERk1MdzZyTDVldkVrNEZSR1NaMlVrclQ2UkpMQ1I1?=
 =?utf-8?B?V1RQVU54Ukd1Vy9NZy9LM0pnQ2VoNkZ3emRHbGJPUXl2UXFTMVdUMy9EZEoy?=
 =?utf-8?B?cFNVL1FCRW1vSTBMY3pZWEFIQ3lCL25DWVIrd3ArWVhxZ0xuY2s1ZTN6VTJX?=
 =?utf-8?B?dXRZRERUVzBKM1dTZ1VEcW9peVFxZkY0MHdUdWxrYy9PRjhEMFBiTFU5a2Nq?=
 =?utf-8?B?R2htVU5pd0U0dm83U3hUdHExeW8xYkMyS3E1bzFLRTV5c2E2OW44QTFNYXBF?=
 =?utf-8?B?cjM3Qk1VQnp3c083SVlMbTBSWTVmVjFmc3BaQ1lSMmlrbzhnZHdaYWw5aUM2?=
 =?utf-8?B?dWxaYzNEZW9ZbWhKenZHUHR3K1FtclFabnEvbERHb3hPMThzMVZ1UmplZ1Zt?=
 =?utf-8?B?OVRobFFpZVcxdW02aGNMSDNqMFltcDJKVm1CMm5NckFIOGdSVjNmTjVqTXlo?=
 =?utf-8?B?WFdReXNFSkVuRldZaWpvblNBbWVKdlhUWVFWSmNGTC81S0FGaWNMYWNxVzUw?=
 =?utf-8?B?cnB5S3liSllhNy9xaDdYKy9zMWJEQ3JPaUE4MzlpMGlFNUFEOTRIYnBoUWMw?=
 =?utf-8?B?UkVKVUNBS05WbDJjazNKZ0RTNW0zeEl3NjFOMEpmTzQ2ZWJTSDI0TE00Y0E4?=
 =?utf-8?B?V3UrSkhSTTF5TUdjZDB6TnJtV2VmbCt0SDh4Rk9BOTMzNHBHcitXK0Y0ZUhz?=
 =?utf-8?B?ZjU1NjdLYXZxMVRRWlg0Umc4SjM3L2x3SmU0Zi8vcS8rQytFcTIveHY2QnFU?=
 =?utf-8?B?bkU4cWNpNm02c2tUZmFUemJLaldiU2VURzJQR3h1V2FpU0kwYytlM3pJdFBF?=
 =?utf-8?B?ZlRLRVVRM2ZRd0lVamNwUm9RdWZFRmp1Y0U0TjJnOFd5aFlqYytZTkswc3VP?=
 =?utf-8?B?Z21vNEdJVjQwc2JxdCthckd1YWxmQWZtWG5jeG1PRFVFQ2JaWUF0NUxWYkJy?=
 =?utf-8?B?Z0dDaXlQbmwyNzFqUU5PajhkYWFVd2JmcEJKZXNSQXVnQ0lHRFFzcW1Vc0U1?=
 =?utf-8?B?OWpFK2h5R2o4ejZRc1A2UkthZ1pVVGUxbS9yUVZocFcwdDR5QWpZOW94aGxZ?=
 =?utf-8?B?cUVpNWxRVnhMN1JLaHBxamlDSXZ5NXl1czBQN2h1ckptOFM1dU8vZU92ZXVU?=
 =?utf-8?B?ditXNUJ4NDRVeHVwZHBRYU0wdWQvdjQvWUhKeWdHRGFtZzBubnlxbzczWkE0?=
 =?utf-8?B?YzdOUFNUMEJMWEtnZndPNGp5VHZSdW9jMmlxVUFvUW1tSkdEaC9wMzRqVHM5?=
 =?utf-8?B?VFpxdEU3c0J4R3VQL3pEcmVsMjBDQ0tJN3lXWGhxUm50d1laTlliV2dJWkNi?=
 =?utf-8?B?T0VmTFlSOXVLWkdxMnhkNERVWEhCeEh3RWNGM0dFZ3QySnVuRE5aMkVyN0xo?=
 =?utf-8?B?djNkTU1SRVN4VytmWmVyNktHcUJNY3JJeWJHVEJ3NHVtZFhyTHpXTStsYkla?=
 =?utf-8?B?aUdMZ3lGYnpOVy9tUXdOZXpxUndZQnRTNmJvOWtTZ2VrRVpiekcyRU5yYk1n?=
 =?utf-8?B?MmRXejNvb0IzY0ZxbDFwLzMyamQ4UDNuZU0xUjIwQktyM0lUQ0N0V2tPRjdJ?=
 =?utf-8?B?QlpQYmExQXUzMnZzQ1NmaUExS3pjNStIRllzRmVPUU1ZZzRMWk5ybXJvN0dD?=
 =?utf-8?B?SXlGbVZqUS9Rd0NvaEJmemxKOG9wampSOHlPS3dRNTdYekVzMytjM3JtVldU?=
 =?utf-8?B?RzBFbUNZUnBGK0RDc2wyQ3pQYms1eTJObjVINGVXbDhMNmZnZVhsZFIvUzdB?=
 =?utf-8?B?RUI1N2t6eFJYR3pWRDNnTWE2QmVLR0t3RElOb05rTGdEdnhQVW9pVDJSdnVY?=
 =?utf-8?B?N2s3NUpHRzZpNHRhY3ZlREVEYlh0ZjlkMmF3VlRUOWFwdFk0Q1graHZVWVll?=
 =?utf-8?B?azRnSDRtdDhvM3RHd0p4ZjYwT3RucHRqTmMzemV2aGw0ZDhkdWN3QmJQRG93?=
 =?utf-8?B?WUZ2MU9YR2JqQ1E0M3NBS2lpT3UzR1ZWVXVxTHQ3TUpNN0dtUHRkZ1hoZVcv?=
 =?utf-8?B?bWN3K1IvVHlMNS9FMDhJdGZnbXdLMFpTOWlBYVJpVXU3U1k5YzZqVHJkMWZ5?=
 =?utf-8?Q?V5oVVfHQLfLjIYmMLXGqC/Q1T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee0895-07b5-443f-c17b-08dc5af3f166
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:24:55.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3s1QKjqNj30E6+oKgI0jLrG8cAoRAFQF5UT+3gxqwOkCxDDOWzk0dnGW2mHZCDyBXi7sJu+dE15oTPUC7bxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
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

