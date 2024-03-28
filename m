Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DC3C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82056880F3;
	Thu, 28 Mar 2024 00:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GWMGSdO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B6B88105; Thu, 28 Mar 2024 00:47:27 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFBE880F4
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1zsa7Tfvem2HmxnbK8kfl5d7u+7x9Koz4lh9sXuFitCvQr5inOSlm57ugDNHqStSdrbEpT0OeThBpp3HM+zm/60vpqupmmX8vuBgk+hCfa/UFgU0Vyq525KZLJuM4/7EIY58q1wUd3B8suyToTxpUeAS/JsaprnMtOqWQzCX0X+33yPtuKqZ90MsAym2uTeZpLRCS+WA2sJx/GoZc5JoIkRGn85nTei+p3c4OblzJB8LC3w+nbqp3ksrtBMudwZYA+r/Z38Ptn3sLAAgLXSx+guPmQJFdY6+J5AKW6J9dNJ+ZkjgVHo6poYoiQsMXmEbjhzxuhGnW3yKOLrXJ2MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=mLtmq741wk5TlNpVBUk5D30kf/4XKRxbhZmQYoaPj99cRRVoFI9a9X83HH/bU5BhNS2Azwq0Mq7157EOGyS+sBo/mS7YNJmzFAUoOXWpsIHGVLoug9miJKjjFxsd8n2WnMYpFQkOqLzHrsbKt83ujzEolWRfVuLp5uTd1Dhdxuh7Bh1fGJUk8sVOn1B9IuhAMMb5fX/jDrxxuJECMlWCn/NEK9bpHzIZz0WZEZb0trie0tXuUkGZgLXXm/qI8VSibG+cbDXb37Jdi9bSH4+zZ8xrHKkGAXLiVcME0tvLE0syrchYIh/KGCctqzS8tohv7tPzuvVJPvqAbmX/+d7orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw5jzwTIPCMk/iOdv7f42gq+s3I8TPPWND2qNjv1UIo=;
 b=GWMGSdO95Rijs9kmIlIMYaS6htYRA4NiNudsmT3i5aLnJuxcC1O2UnRSfiyBiXnPRtz0WhQVDQaWPLGMXK9hd4xh3jN4onbKbRYZ4EP4cGqwIvFfzM5zaYy40LOYaNPLMaLWIch9CClC2qy0RsP4z026w92r8o7gXXcv2sK5S20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:49 +0800
Subject: [PATCH v2 3/6] cpu: drop imx9_cpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-3-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 230d2a8b-cfe4-46a5-9880-08dc4eb83f32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0N1pZiamqchhYVpW9octj/kHOW0mlI0tkQhXmWE1XjzT75fz0ZoP9myHkeNLL0VcK2KCKNhhA6yz8+sXPX/ze7fwUYvmR9eQASxi6IXIj/RF7Ski8pFOxsTQhNC/dlz38aCqVOt+gCyU7By8EcnvSH00Lt96bV9BzpI8U+Twsw7O8fg9ScfKFHeo1QFvjX7uhvletR7DOGHIJACj4Z+15MvvHXcdXt+71wZJlQQ28078PDli6oaxXd5JJnGrf/aUGwjPzWtBO+Kx+ZJaEec3mNF8sMvZeCyM7QorEA72In22nEIKFMng5WnAhADFpOstX4/9gbmAgg51kK43hRjXLOMmaB2Ein0+xjHWBY+vR0VbgDwebwPL2Zh22k3FJFUgprU/KPHKAeVEpMROvQebT//4h0EOt7SI0JZ8jCrsarswPb8pCtKpXTE0tqiQwvGB3ZDW8vQ7u5XJ3x+ydiZFD2pSgjrIUxFla4i6apVyDazLhgZqpz+LQpYxYqfvaEoFWOQtOzdPvXx1VGHJ2Q7mSCP/5jkIoLlIxo/d83eq7fmFgSSSc6HsG/ZWHlhYiBNGMQuRopwLu1umPdTQZm50lTD9VLmNNk/e+NGWSaNx7pwrRNuj7JpA2F1WG+bvfErhHJU5lFcJkd/TRX+dCGM481bNV6EzUKjlcCts2vs3D2U5Fs3pbMgUumS15bEkf8jW2joHUOqsMHB38sU0/gurPZp5cxaeUFKMWrK+7+Udtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FLeVIydDBYWG5kcit6U00rN1pmNFpxQUtDYWUyRWtITlhaUWYxQXhpSHlB?=
 =?utf-8?B?ZlgyQmkrbkQrYTA5Y2UwSWRIWGZsUXhTN0x2OWVzTlBWTWNXQTFzcTV0QTg1?=
 =?utf-8?B?RFQ1UEJZY2VDbloxNjdTMGttK0JpWGtleFdzZFJpRG1sNTdZSkdEWHBzUzJv?=
 =?utf-8?B?UEdoenFjYkJuLzc1RXNlcnFrS2xRUEpPUHRNNXpqdFFoT1p0eEc3WUtBTUVt?=
 =?utf-8?B?U1M0NUllSkpodDdkd25YTklYQXNrN3VLZmlRSHJGeU5zZWJXK2h1L01UTUhU?=
 =?utf-8?B?QmJxUjJMUFE3VkdLTlFpMW44OXNTaVpUMHRkZWd0S1RxSldpVUg5ZW9EazJ3?=
 =?utf-8?B?UGlkbWhualNCZ0lsRFZQYWUzaEQwSGZVMTgyajE3U052aUdjU2JQUkhhd0xQ?=
 =?utf-8?B?SkdRM25zbytxbkFTV3hsODRBdVhBOXhvYVM5OEJ6N1dham9SYkNSWXRNQ1hj?=
 =?utf-8?B?OHZYdHBXMFE2T2xnQ3RYcFg2TzU2VnhLaTAvbzRGUEsycUVkVm5XZG1qR3Jj?=
 =?utf-8?B?V2FrcjBudzNzZmtqSkFuWTZ3QU1vTWFLQ25qWlhpazQrZ1RtTU9oRkYxK1hR?=
 =?utf-8?B?M2dQUWtYTTRWampmaW1JS1VVd2ZQNHhkYjEzMXRVNU5Hbys2bkZFZUVZek9Y?=
 =?utf-8?B?THI4dzAwUXVmT2lya05YYmxGSFNhaWtZTDVmWnZ2ckJoc2NmT0Q3ZTlmR2Ez?=
 =?utf-8?B?QUg0TXh1aEdCeHRDRGMvellQSXY3eXpQRDlJYlZVTGJ6U28vclhOTmJqNXJF?=
 =?utf-8?B?RGJHK0NuRWRzdUNFWFcvUUZDaEREODlaQm9Jc2paVUpudytjUDR1THJDVkYy?=
 =?utf-8?B?L3BWR0drdXN4TFR3SHVFKzFlT2E3ZGVUbGlpRUdvbk04SkhPVksxNDY2WGNp?=
 =?utf-8?B?QnQxYlJUKzRrcHpVZkx1aVVRUHNOT0JldFdiT3gyNmp3RmZ5NzhGTjdCVDdN?=
 =?utf-8?B?Rks0Z0REd3NxS2svS0FEU0k4UDhZYTc2VHFHa0ZsOHl0cGkvNWduTjh4WU1D?=
 =?utf-8?B?VFAzQnRGUTI0aXEwOUkxOW5ia0ZhaGxnQWx5ZEVLN1AydzNhd09JLzl0cVVB?=
 =?utf-8?B?dm9zaVFwbHRlR3FUMkFDcTBScHNDK0NEUDk1cTVZR3BVYlpEaC85RU5Sa1JF?=
 =?utf-8?B?VHo2UkEybmh2cUhhUlZnKzljYmdhck5rT3BBWHFzNEVFTE9ZOWJXL2hOdUJ2?=
 =?utf-8?B?czZSRUFsYVVmWVVrNTdYTVhQNTFNUGl2VjdPbHZjOWZCcm1VbzlPdjg4M3pJ?=
 =?utf-8?B?Mk0wL2FWRjdpSmRqNnM3YUpVL2NZL01FUTczQzlGVVU0KzhhdWJqVnloYklJ?=
 =?utf-8?B?N2tLWTk3NGtYR0hJOHFYV3YzdFcrRHo4cUxTd2x1MmJldmpnZmRzMlNkbVBj?=
 =?utf-8?B?VGdhUDMyQ1ZuR21ONXkyemYwK0NaTTVUOFJuRWROTDFLYUhrZXlISVVHVEhV?=
 =?utf-8?B?MXpYVFAxS011eWFmVGFMclR2QlAzRlJVT0RGYXd2Mm15R2JieXloSzRac3hL?=
 =?utf-8?B?U2UyVG1ERm5lVXkxNjJHSlRmUCtNM2tTVEZzV2ZtQ0dmRytBZStrY0c0MHIv?=
 =?utf-8?B?M3A0R1FHVGlWQlYyVXlLZlE2K3B5OVB3ZUpSTnpvM0x5Y2o3Q3QyYmpuNG5F?=
 =?utf-8?B?WVFEa2kyY29kUmU2ZkNGc0VJN3lWK1RlSW9BZXdZZFZvT0EwYm9sOUxqRFNU?=
 =?utf-8?B?ZkgvOXd2QnUzWjVkKzlod0J1RXUrb0xZYmlqVXJnUVpiMzcreTlXS3ZiZEtP?=
 =?utf-8?B?cStXRVo1WWxEeERtMXRnTnkvWHd3V0FRWkZ2SVpvZ0hGNWozRTgvK3E1d2V6?=
 =?utf-8?B?dHZSaUY3eGpYekJ3REwxMVZZNUZYSnpUVi8xRm83VjhMc25YaDNvSW5aZlJU?=
 =?utf-8?B?V1FxbkJ6UHNRZXh4ZWc2engyaUdYQjlDUXd1TlFHVzN6cXltUCtRMVZQUlBR?=
 =?utf-8?B?NUsxYmxieExJRHNmZWMwQVFJdVRNMFUrTkM3eEJBcWZkSzlkWWk1aC9wOUJ0?=
 =?utf-8?B?TXo3M3JJRmxJV2VVVGRoa1VtSHliREtkTUx5STNVankrSk1MOGtHSlhZMlpx?=
 =?utf-8?B?MmJtM1M0blJyaDk4OVBJejRhdlpKV0t5bS9FaFMyK0NPN1FUMDkwTVMrMS8w?=
 =?utf-8?Q?wGBkotH82OIkrVD6HO4sJsj2P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230d2a8b-cfe4-46a5-9880-08dc4eb83f32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:22.1673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acFTfS4MRvuYl23n13/4dzDv2wQky9DPQB0F7NYjUOVv/iB3PeMJazxGmb+yf+aG2rn1NKq6CiBJpeUtoXtvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

