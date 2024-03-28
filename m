Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ECFC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B087687F4F;
	Thu, 28 Mar 2024 05:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ltl2Or91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA5D880DE; Thu, 28 Mar 2024 05:06:22 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9D42880DB
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zvldgj8w6KTlCe0630Hh65NNQdPPzxvn4OE/g7uCjqY/VHgUr5UYWdkYc7B7zbOiDzyUIc3MaUh40W4vQr23h61UcPaxTqIcTj++o7iEJMNjO8O2F5noLlDDVkF3jnUyF76jbQjg135Z++5lqWlgYwjB251O6uuAK/Q7gTpJkvsg8vqUIQOVPfhs+/7teNLgbYvwOZM/zuMjhF6/sLkR5i9oj0fVaIypFV8VVLjGc9QEsZc3ZVvBIKWTJ/9uuW6JLLaLikYU8rVhlQHv2nw5B++OFZXaGo4jxZqacLT9Xcg32sZY3jkk0Sxqxu4Syuc77MLXFWsZXRFdJ9HMgJNoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=J1o3XRhRgZbcKxG94R46s35oSHStm/Btmpgt+hHL/DAxap+k6+EHiQedrSOQPCl831EUzblP8txzI3hEHPUMsLUK3onHsq42LBjDiyiFEiw3SYBaSjiWPnodCS9NR2CteRN6leZsT3p6Q4+4fnrOLZ8zUL1pFPkgq0xwDE3QJLA67ae5BFxT+e32J8nk5Uh8zF1hpK/gjx7FvekxvxDiQRlw47SpAfcgAaNz0YN0v2LvK3eBDieKVDlXhepHgF/aJUznE6mgMUomGfruexytFYypuofrhOm2oQtkV5ZC94PhQUT2ypO9A1DD6OSXDFSAS3rL0iLNo4IurFQFztfxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=Ltl2Or91RYIBt8jdbZNmy/8rlxIxnI5h3GneqXCOr6Vpc6CPCzW1+yFtxjGwXx73dLa3xoU8Lo/xeEmAPxdPQpG6+wiE78cEOTgKdbSlEvdmtvy/0nI3sW9/TqzsnDMhWrxTO0HPlqmDVE6CH5i3JB7zBkw35UHn/QKFHze9ugY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:06:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 04:06:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 13:05:47 +0800
Subject: [PATCH v4 3/5] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-v4-3-338d15a65c36@nxp.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
To: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: c97c7a41-8605-4c8d-4f16-08dc4edc6aa9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4XGAA7RS5/1KlSttz1IrBYplXC6k2JuQ+geejst3lAcBOueRhBt5ZbZAfjd2PepXXy6fViAl6JFHLE91HwZGgMeqG+qKgfPRQPSIe1zbwkKhi2v8Eo2slgU+Qf4o/LCuPMpNmXMcMhEc9XoG7Yb8edcMyeFb85IoSi8s9HxAgV2J8YrDVOAkVOUz9SWVLH7QhtuiHTMacsGwWZ5YOMO3qj/4f419tm2mnZUoTbe4aUzsHeHZmxzR9w+Ll+fkjJsrTp0HYdf66EmVbvCS3Jc1r1QYjjTiQj7Wp7SIe9mOR2qxFp2Us91ofKoKbVWjRzX9T7g7/+Yk2tBaFDMLM8G3peWdriBEHCZHC8UrDQvvStWvfJlC5Ku6nulJm4as0pthXZUjCX83o/bmW+dVnGwgXPIg9S+u8C38VJLmyGoiJ6CAWzB/s3n+GjbCCyg4CDqUaVAnfx+qSJihbdXGWHcTcJ4ehYUOuzRMT4jeUXWlL7s4BLOII4/TS1DCvKuFzr7IrMVP4tihe9LEx7hBsThJtvldIzjuxVQsJEKJzhUw0bT+t/BmvKVjC3CgprruIsBzToF6nCgRz+w5aZD92f8DZTKIGG04pCw2gOnEQpA2VKqaEcxLaH8w8aYXxCKQVlpYA7buovmui3w5FUkWWMmq1x3fYjr3sZrMkg9wPMUslLlGbmXRyVOeKUR0MFdD1q6JVFf/rdoH9PsndPWleD9xgvI7dbvilqH5t+gZ9d/WcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHg1bXF5S1hOWXI4dktjSThpUGZySWwwTWlOcHNlZEdPRGlMZW9lTERpRjVm?=
 =?utf-8?B?dGwxQlY4dDJ1ZnRhWENUUnhFSFYwb2tLY2lsSGcwZmFvU25XL2tURDZveVp1?=
 =?utf-8?B?Z1dBRlhwNWFVTjArTmdzM016QzJhU2ZoMzdDeXZKa3dXN3F6UTJnZTJSSjU1?=
 =?utf-8?B?TVNDbFBUYnlKSlcrM3lQc0l6RmQraWdHSW51djlUdEp3U1hBeVpabzhDNU1i?=
 =?utf-8?B?cWFOaEpLbjAwRysvbDVDQnBrd05iR0JxazAvT3hTSlkrYmxLenZubHFjZ21K?=
 =?utf-8?B?aFVldTFmWG5KeUpwWVhrMVoyQmlWV2JiQ3JZUkM5VTJna0NHa2NCSGlyZDVH?=
 =?utf-8?B?SXVPSzVTeXkwUmRKNGVsbG44MVdvby9rYjRTcDRVUjFUVkdJTFNIVHNyaG5w?=
 =?utf-8?B?WFZESngvQlB0bGEzblZENWVUNG9ML29VaDRTWUhxd1hDRWxKQ3l2cnVsNGdi?=
 =?utf-8?B?eEF1T04zRUM2dU84VTJFUEF0ckNPNDFSS3JraEF5MTlXbFZzRmtwL01xbkll?=
 =?utf-8?B?Zmk0YldwakovTXFPczhkclYrUHZydjQzRHY1SDVyU0xiK0tHU3dDZ3I3ZjdR?=
 =?utf-8?B?ekI4SG1mK3FldVkzVi96QkFJNmlyUExpak1yWTN5MDZFejIyQ05lTndleFYy?=
 =?utf-8?B?RjZvVzZQanlaOFBDc2IyOG5RNm9mTFBLekNlbjJiUzRSUlhUQTVqN0xDR1I0?=
 =?utf-8?B?SU9rcDdHWjU2L0Y2L21zanV4RG9VQmZqbWlqc0tXQzh6cTNBcC8xRnI5UDFm?=
 =?utf-8?B?Z2t6Sm1hVTNJL1Z4S0lSbTV6TFFSSSt6SFFCYkpZT0dZQUsvaXNWWDM5bDhh?=
 =?utf-8?B?aFNLUFZyTTB6c3ZSbk1vRWNIOGlHTEZKVlg1VDJYMWh4eFVDcTJ0WkNRV2di?=
 =?utf-8?B?QTJjbHI1cExoalZVVCsyVTRHUTFuSnJINGxUaTZiemk4Z0lWUzRXT0o4a2Rj?=
 =?utf-8?B?enYzV2NyMGd5QjhtMjZGQWRIblhicDBVQjNGQXM5cTBNeE9mM1JsZjBQWFp3?=
 =?utf-8?B?TmtRR21DdUFjeXI1NG1DRmN2NzZiQlRFcjFTc2FLanIzSGFjWk1QVmhJNTRW?=
 =?utf-8?B?QkRJTVpWZFV3NSttemhSWVJhY1orWXJlTGNvT2luZzJwVWtzRHhMMDB3VXhL?=
 =?utf-8?B?Rmc0RnFjekkzemNiQVBkNWtPeFU0RzF5dXR3dEZDeEo1ZkNiNEkrQmZ5dFdR?=
 =?utf-8?B?VHNUanZKUkgwZlUwbzNBTXJyMC9PWVZKa3UzZFNXbUJmcS9kaGxJd0NFMDRr?=
 =?utf-8?B?RFFkWXNIVW45S2VJdWlYUk81NnZsY2ZsbGtLYmplaVJIdTcxeXRqWnUrOHF5?=
 =?utf-8?B?ZFdrK2RldjBkNFdDQ2RPMjNUcUtIQytiUTB5TWZacERGYzMwdzkrc3JBK2dw?=
 =?utf-8?B?bmFkVjFpRkgrakdTNmNEcUJERkdFQUJzTDNuUW45ZE5ublFCK05nSkpUVzVF?=
 =?utf-8?B?N3REbDVPbFYwQVUvRFh1Y05IaU4rd0Vmb1pZZ04rRTFURDFucEFjeS8razVm?=
 =?utf-8?B?WFR1N2tUai9yRnZiVDg0RStYaWo2bEEwQ2VIWHExODB0alZCZmtESkZVejly?=
 =?utf-8?B?ZFdNeU1RVlcvM3VBaE5VTnczbk1lSjQ2V3d4Nzh4K0VtQXF3TTNMa2Jwdzlh?=
 =?utf-8?B?TWtydDdQemxCb3ZhYk11VGFUNHUzV3FvODFDUlZqa1NIcXozTVRqenlPWG9I?=
 =?utf-8?B?WEFQRCtsdzF3NVNhbGpqNGRKRXFjdDVDQmozaFV1UnVjWFJqWUJrMFBSZ1Q3?=
 =?utf-8?B?Yk9JSzVJVEFsWEphQm5PczZpWVE2cXBQakJUQXF5NkhvbEtVQUoyMm82S2RJ?=
 =?utf-8?B?OXFadDVtYWRPeUFZMlJLM3BQSlV5MU45MmdyRXdLcXMwVENZVWJTNys1YTli?=
 =?utf-8?B?S2ZTYTF1WUVUblJxQTVEVHo1K0pGeCtaazJUNk9PQWVQV2w4WHFEakFVbVYr?=
 =?utf-8?B?a1d3QlJsczliVGFnWU5VSkNVZTdxM2NUMkw0ZTE2OWg2YXZKcE43Vy9zZ1RG?=
 =?utf-8?B?RTlnVVNiRWVCQVh3a2pwV2xWNENWeUs2b0dhMTd4YnlYbmg2dHhMa3hVemFp?=
 =?utf-8?B?WHAwcXBIUXJqSnNvUm52cUgvMVJEOFptMGo5SjBhdlE1WWpPWEwzakk4dFpN?=
 =?utf-8?Q?YPm1NefN4BlByILySFDvVI4wF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97c7a41-8605-4c8d-4f16-08dc4edc6aa9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:06:16.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J6oG+2lLRn7Ow7QXzs1RcPTyoC4VpVAzlFn89YlSNK//QsVsQqe3SvSBn4ouowbyd3gylYxYVDpfVg6qA/n8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488
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

