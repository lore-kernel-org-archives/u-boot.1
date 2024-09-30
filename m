Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD8CE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351AE88FF3;
	Mon, 30 Sep 2024 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8023888D08; Mon, 30 Sep 2024 18:49:28 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn
 [139.219.146.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A765088D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtbt9b+kb3E2MRMqMAv7foh3S399zpgVzgz2AvsfnE+B1txeXkkiN9tikeRxLkm2oG1TfO0keJZR+tK6V28FEakBjGeeKdGuOVZZKg3gmhzuMSWO8kaViBsb952cz7yzcC1AznOkf5gMYEPg7eqXwsY70OZuITCNmbmD/k4WcFslYQbjrjyG0Cjr9mzyaq0m0iR6k2JwSzepTFQlPa9LSvQm/Uc6hzGyt6Jvmf74ScEYkEcl6V/Ob/d2XWu9561wb+W0484QuZ6Smne9yQUx4DzoxdV+tuh0ar6TLxUmjtLkrvqCQwEuVIjzAe2Dk2ybG+68iiEZnkB/w5Vm1AUa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bunPIF4vKEROSyKMxeNIlGRVq5yIuLnfz3zO8O9/6S0=;
 b=DRm+dKNUTXADkf4i+vfK4P3L5IVZG2nYP8k5Sn6IomG8Fmn5XKwli2KcPAJv3xwYT1JqY+uRmKZ1YphinukEdzMdVFTHNqLNh7r9WFkKs/q1tPBEGTV3qub0k8pzuFaGYClZgTlPqecqY5ZZXGd1vbSG9N13WI5Ni6OXkUZCobRMl8f5CWNbxyGF4pE3IxKnIBroPikZURljuUGwMDi3cXqWQrm3y7oDA21eyDB6vs8x9ykWtNDytLSCWcpbb1J3vNJ7/Hh+e4eqcQSdF7MQfR7NI6poVkZjz8utSLK+eUoZagctSeNFeDbgAMVZIIv12fcZfVHE7MLFnLic0G7KqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:32 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:32 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 04/12] dt-bindings: Remove StarFive JH7110 clock and reset
 definitions
Date: Mon, 30 Sep 2024 23:59:11 +0800
Message-ID: <20240930155919.111738-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: 69015aa5-3b6f-45ab-477c-08dce168df74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: Pk7OXG++7RPvL4arL7C0Ak93b1edyVXpnesyluh05f2r5l0UtlEUuLIurmyi+WxGRssrCHh0zUoHchQkp5ihQ2mHaqroOt0mnNHcOLTI8y0TLKxJkArACSFrGnYqfe44csoKpY7C7FhT3MncJhi6eiufeRN88sFKFrSJFiSN2pqg7MI8zQK21RT1Toijzbc0oqFWo04QzU9B1rD9gkuuLToKCMu9Y+xhnjNabIR1E6rJ+08TWCqaw6ajUMPngSp8adF7gDdAKjvxm2o7rrghpUWBFsfDYphrFC/MXv1tLrODKcy8HZrA9tKp0IrMGCCjfTi+aDOqqSxmy/HT7P6bCEy59M3P+JeXEIsZxVjKxi1Umyhx/7wDDbebxguT8doQgGfFraLzQva/7QKorKsg5lRL2RvXcqbc3BF3RtmzqcralP8Ym/mk1CuPLY4SHmwtICgJc7XDVyiZuHjBLQuTsMQZp5Pft2HIn+JxVTul3uOjLXIIeUHJ1dG5D0UgGavv03vj1kBdcdl2qjMP6gODhU2oIND04r0xVXM0OeTQskqXQvTMS/BIWFHGljaJ4RH93oQA6QxIghWnuGFN+RrG4y8BexUVPUQoZXGtaZrT6hO/a0gFPIX9HOEF0r6llt2R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ntU05xUpNYLcqFIHigISUFQd3i0I15QimVcokIWJ+jfQAjJFhfWpj9UtRKAU?=
 =?us-ascii?Q?DKKExgSIbpby9bhVl+GgUSlZXZKSQMAmgvbdYKsmgFftpBiMrW02SqvGnrbG?=
 =?us-ascii?Q?ts+CfVOCCVE1mA2EYy4MFW5HBbSNZaPMS3i7bD5l1Sm+aFkbQ9cY4bMXTtxa?=
 =?us-ascii?Q?/RqSxKfRrbA1Cs6OQMP/SyGwfqRE1v3JSMOTotuJ1FOAvSnFAXNvoNZOnsrj?=
 =?us-ascii?Q?/ZLdCj1kK1Ca9B+KXknjEIwO32G4VL9dDHPV4nnNvZSejvYGnl6LMDB/htwS?=
 =?us-ascii?Q?FCnvU63DVha57C7sHAawPe8nTBc6fQc1h/HOJvP7iKecHhn83+VsPu9rJOY9?=
 =?us-ascii?Q?IuOAIeGJ1VguBEzd08clUDUo4RibtHHvxwPtPLoRMJ6qn9biiHSNVZOvO8kz?=
 =?us-ascii?Q?nJSgauDq7ASOX8SRDCoqGS2Ttsf8XHLzBILDw8KPeDlk4+t2ycHjC9ZOEbhC?=
 =?us-ascii?Q?hzZ7PRg/sUYhQjrpLfhzhvZa8sK13dWq6nd7OYMYF7Az+uYUDzlaQLoz8g7K?=
 =?us-ascii?Q?jDKsGsOPEtplADgcderSG3zchDJ2VAfnI3yJi0GOKUZNb7wcRVhPimeUW41x?=
 =?us-ascii?Q?Kr4T1l4X41lhPJkCgN1wCaCXfTFgawyIUz7ChdK7D9vwc5M8EuOAqz+AuBT4?=
 =?us-ascii?Q?MqMoPfR4LdbDqTJeRWEbipETEdLTYByzidxnXg4FkMRG/UkgPGIiE2iDv8Qq?=
 =?us-ascii?Q?idi80ZeQjfGOQ859/M8T27UUqKfppqmwOZ208GlhJZhT3fOkxiuifRtJc5mJ?=
 =?us-ascii?Q?zkyjpXApUMtUwIhVDgOJGuc/4vs/r5MVwZQIaXaGzRM7aGOcNvgXjrMy09h4?=
 =?us-ascii?Q?EbzPSsXhOMWb5Jp/WCHr1Inu9TTIUlVPfG9PcWDh1O9zw3V9m4h1ra6XqawO?=
 =?us-ascii?Q?NfHsF0US7U+rV5euldNEyapHvTaB7v3ZOyDS6Sq6DgeuQrzUSstZtbJVJcmb?=
 =?us-ascii?Q?r2CrKPfjVc8Lf2XzlTg0sQFpnRfkyC/+5wNhh7KPcKbIQDHyCc9pyVOnzBNo?=
 =?us-ascii?Q?2g6Htk3OfjV6CQNaFFsSvEZfWafvOq0oPjaizbbFztFqB632+aLs38x1UWDh?=
 =?us-ascii?Q?9i0MByrTplTyPzGUgZSm0mYKEiUWJoHOcPF9Qi5NNYNj6SFxCXd1NPv08vV2?=
 =?us-ascii?Q?wGLiVkXMcT+gIO/SYk4qLyFHjaJ3He79dikyvI+lpXBDV1yT3zOju7eov/MB?=
 =?us-ascii?Q?y3rsv6IsBUyH3EQtmx1hg2L18KO+tgowSnanI+cwbhNcAfhW1t1HCOarOCUo?=
 =?us-ascii?Q?1zMTXd+Ts5dDI+Gr7ez6t+e4WsxQ8lgN2FF8jbki4kqlkR5fu91ZerxcRqHJ?=
 =?us-ascii?Q?HeBo/GgQJcRd1gbLlp9H8WGm/c9CzQyt6tChFv66R6qXS74g/sy/zQAQ/3jM?=
 =?us-ascii?Q?BqHjZLgKsq1k0sjOPyYhZPKH+WROdvcSr/bANkovSQoa06lw/VruW9ojcsRE?=
 =?us-ascii?Q?BXykgZfouqlBlkD/S8/nJQPF1844MH2FFpbffvzdn5Nk80xtii87mg+mJ0+n?=
 =?us-ascii?Q?4zVJ301yge4ohOQ8+QywRxbF80q9H/tEIBLgxhHcpduDgKeTzyeVZjuOpb3Z?=
 =?us-ascii?Q?rsJP79bKxNuP8x6LLk614++ZXxLxokmwOgJk+DnOWAxkKgEkvCxJ0sK4BBHC?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69015aa5-3b6f-45ab-477c-08dce168df74
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:32.2874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMN5DStW31s0xbz1/yZ1lPado6895HLBsPwXUUDva3KAhXgRUwQH0VQx8OWL7TNKpdatWcM91zNkXoUASya0sdmBGkqBn/8JzRTMYxat+S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

As JH7110 switch to use OF_UPSTREAM dt-bindings,
remove the redundant clock and reset definitions.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------------------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -------------
 2 files changed, 441 deletions(-)
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h

diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
deleted file mode 100644
index b51e3829ff..0000000000
--- a/include/dt-bindings/clock/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,258 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
-
-#define JH7110_SYSCLK_PLL0_OUT			0
-#define JH7110_SYSCLK_PLL1_OUT			1
-#define JH7110_SYSCLK_PLL2_OUT			2
-#define JH7110_PLLCLK_END			3
-
-#define JH7110_SYSCLK_CPU_ROOT			0
-#define JH7110_SYSCLK_CPU_CORE			1
-#define JH7110_SYSCLK_CPU_BUS			2
-#define JH7110_SYSCLK_GPU_ROOT			3
-#define JH7110_SYSCLK_PERH_ROOT		4
-#define JH7110_SYSCLK_BUS_ROOT			5
-#define JH7110_SYSCLK_NOCSTG_BUS		6
-#define JH7110_SYSCLK_AXI_CFG0			7
-#define JH7110_SYSCLK_STG_AXIAHB		8
-#define JH7110_SYSCLK_AHB0			9
-#define JH7110_SYSCLK_AHB1			10
-#define JH7110_SYSCLK_APB_BUS			11
-#define JH7110_SYSCLK_APB0			12
-#define JH7110_SYSCLK_PLL0_DIV2		13
-#define JH7110_SYSCLK_PLL1_DIV2		14
-#define JH7110_SYSCLK_PLL2_DIV2		15
-#define JH7110_SYSCLK_AUDIO_ROOT		16
-#define JH7110_SYSCLK_MCLK_INNER		17
-#define JH7110_SYSCLK_MCLK			18
-#define JH7110_SYSCLK_MCLK_OUT			19
-#define JH7110_SYSCLK_ISP_2X			20
-#define JH7110_SYSCLK_ISP_AXI			21
-#define JH7110_SYSCLK_GCLK0			22
-#define JH7110_SYSCLK_GCLK1			23
-#define JH7110_SYSCLK_GCLK2			24
-#define JH7110_SYSCLK_CORE			25
-#define JH7110_SYSCLK_CORE1			26
-#define JH7110_SYSCLK_CORE2			27
-#define JH7110_SYSCLK_CORE3			28
-#define JH7110_SYSCLK_CORE4			29
-#define JH7110_SYSCLK_DEBUG			30
-#define JH7110_SYSCLK_RTC_TOGGLE		31
-#define JH7110_SYSCLK_TRACE0			32
-#define JH7110_SYSCLK_TRACE1			33
-#define JH7110_SYSCLK_TRACE2			34
-#define JH7110_SYSCLK_TRACE3			35
-#define JH7110_SYSCLK_TRACE4			36
-#define JH7110_SYSCLK_TRACE_COM		37
-#define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
-#define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
-#define JH7110_SYSCLK_OSC_DIV2			40
-#define JH7110_SYSCLK_PLL1_DIV4		41
-#define JH7110_SYSCLK_PLL1_DIV8		42
-#define JH7110_SYSCLK_DDR_BUS			43
-#define JH7110_SYSCLK_DDR_AXI			44
-#define JH7110_SYSCLK_GPU_CORE			45
-#define JH7110_SYSCLK_GPU_CORE_CLK		46
-#define JH7110_SYSCLK_GPU_SYS_CLK		47
-#define JH7110_SYSCLK_GPU_APB			48
-#define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
-#define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISPCORE_2X	51
-#define JH7110_SYSCLK_ISP_TOP_CLK_ISP_AXI	52
-#define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
-#define JH7110_SYSCLK_HIFI4_CORE		54
-#define JH7110_SYSCLK_HIFI4_AXI		55
-#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN	56
-#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
-#define JH7110_SYSCLK_VOUT_SRC			58
-#define JH7110_SYSCLK_VOUT_AXI			59
-#define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AHB		61
-#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AXI		62
-#define JH7110_SYSCLK_VOUT_TOP_CLK_HDMITX0_MCLK	63
-#define JH7110_SYSCLK_VOUT_TOP_CLK_MIPIPHY_REF		64
-#define JH7110_SYSCLK_JPEGC_AXI		65
-#define JH7110_SYSCLK_CODAJ12_AXI		66
-#define JH7110_SYSCLK_CODAJ12_CORE		67
-#define JH7110_SYSCLK_CODAJ12_APB		68
-#define JH7110_SYSCLK_VDEC_AXI			69
-#define JH7110_SYSCLK_WAVE511_AXI		70
-#define JH7110_SYSCLK_WAVE511_BPU		71
-#define JH7110_SYSCLK_WAVE511_VCE		72
-#define JH7110_SYSCLK_WAVE511_APB		73
-#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
-#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN	75
-#define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
-#define JH7110_SYSCLK_VENC_AXI			77
-#define JH7110_SYSCLK_WAVE420L_AXI		78
-#define JH7110_SYSCLK_WAVE420L_BPU		79
-#define JH7110_SYSCLK_WAVE420L_VCE		80
-#define JH7110_SYSCLK_WAVE420L_APB		81
-#define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
-#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN	84
-#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
-#define JH7110_SYSCLK_AXIMEM2_AXI		86
-#define JH7110_SYSCLK_QSPI_AHB			87
-#define JH7110_SYSCLK_QSPI_APB			88
-#define JH7110_SYSCLK_QSPI_REF_SRC		89
-#define JH7110_SYSCLK_QSPI_REF			90
-#define JH7110_SYSCLK_SDIO0_AHB		91
-#define JH7110_SYSCLK_SDIO1_AHB		92
-#define JH7110_SYSCLK_SDIO0_SDCARD		93
-#define JH7110_SYSCLK_SDIO1_SDCARD		94
-#define JH7110_SYSCLK_USB_125M			95
-#define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
-#define JH7110_SYSCLK_GMAC1_AHB		97
-#define JH7110_SYSCLK_GMAC1_AXI		98
-#define JH7110_SYSCLK_GMAC_SRC			99
-#define JH7110_SYSCLK_GMAC1_GTXCLK		100
-#define JH7110_SYSCLK_GMAC1_RMII_RTX		101
-#define JH7110_SYSCLK_GMAC1_PTP		102
-#define JH7110_SYSCLK_GMAC1_RX			103
-#define JH7110_SYSCLK_GMAC1_RX_INV		104
-#define JH7110_SYSCLK_GMAC1_TX			105
-#define JH7110_SYSCLK_GMAC1_TX_INV		106
-#define JH7110_SYSCLK_GMAC1_GTXC		107
-#define JH7110_SYSCLK_GMAC0_GTXCLK		108
-#define JH7110_SYSCLK_GMAC0_PTP		109
-#define JH7110_SYSCLK_GMAC_PHY			110
-#define JH7110_SYSCLK_GMAC0_GTXC		111
-#define JH7110_SYSCLK_IOMUX_APB		112
-#define JH7110_SYSCLK_MAILBOX			113
-#define JH7110_SYSCLK_INT_CTRL_APB		114
-#define JH7110_SYSCLK_CAN0_APB			115
-#define JH7110_SYSCLK_CAN0_TIMER		116
-#define JH7110_SYSCLK_CAN0_CAN			117
-#define JH7110_SYSCLK_CAN1_APB			118
-#define JH7110_SYSCLK_CAN1_TIMER		119
-#define JH7110_SYSCLK_CAN1_CAN			120
-#define JH7110_SYSCLK_PWM_APB			121
-#define JH7110_SYSCLK_WDT_APB			122
-#define JH7110_SYSCLK_WDT_CORE			123
-#define JH7110_SYSCLK_TIMER_APB		124
-#define JH7110_SYSCLK_TIMER0			125
-#define JH7110_SYSCLK_TIMER1			126
-#define JH7110_SYSCLK_TIMER2			127
-#define JH7110_SYSCLK_TIMER3			128
-#define JH7110_SYSCLK_TEMP_APB			129
-#define JH7110_SYSCLK_TEMP_CORE		130
-#define JH7110_SYSCLK_SPI0_APB			131
-#define JH7110_SYSCLK_SPI1_APB			132
-#define JH7110_SYSCLK_SPI2_APB			133
-#define JH7110_SYSCLK_SPI3_APB			134
-#define JH7110_SYSCLK_SPI4_APB			135
-#define JH7110_SYSCLK_SPI5_APB			136
-#define JH7110_SYSCLK_SPI6_APB			137
-#define JH7110_SYSCLK_I2C0_APB			138
-#define JH7110_SYSCLK_I2C1_APB			139
-#define JH7110_SYSCLK_I2C2_APB			140
-#define JH7110_SYSCLK_I2C3_APB			141
-#define JH7110_SYSCLK_I2C4_APB			142
-#define JH7110_SYSCLK_I2C5_APB			143
-#define JH7110_SYSCLK_I2C6_APB			144
-#define JH7110_SYSCLK_UART0_APB		145
-#define JH7110_SYSCLK_UART0_CORE		146
-#define JH7110_SYSCLK_UART1_APB		147
-#define JH7110_SYSCLK_UART1_CORE		148
-#define JH7110_SYSCLK_UART2_APB		149
-#define JH7110_SYSCLK_UART2_CORE		150
-#define JH7110_SYSCLK_UART3_APB		151
-#define JH7110_SYSCLK_UART3_CORE		152
-#define JH7110_SYSCLK_UART4_APB		153
-#define JH7110_SYSCLK_UART4_CORE		154
-#define JH7110_SYSCLK_UART5_APB		155
-#define JH7110_SYSCLK_UART5_CORE		156
-#define JH7110_SYSCLK_PWMDAC_APB		157
-#define JH7110_SYSCLK_PWMDAC_CORE		158
-#define JH7110_SYSCLK_SPDIF_APB		159
-#define JH7110_SYSCLK_SPDIF_CORE		160
-#define JH7110_SYSCLK_I2STX0_APB		161
-#define JH7110_SYSCLK_I2STX0_BCLK_MST		162
-#define JH7110_SYSCLK_I2STX0_BCLK_MST_INV	163
-#define JH7110_SYSCLK_I2STX0_LRCK_MST		164
-#define JH7110_SYSCLK_I2STX0_BCLK		165
-#define JH7110_SYSCLK_I2STX0_BCLK_INV		166
-#define JH7110_SYSCLK_I2STX0_LRCK		167
-#define JH7110_SYSCLK_I2STX1_APB		168
-#define JH7110_SYSCLK_I2STX1_BCLK_MST		169
-#define JH7110_SYSCLK_I2STX1_BCLK_MST_INV	170
-#define JH7110_SYSCLK_I2STX1_LRCK_MST		171
-#define JH7110_SYSCLK_I2STX1_BCLK		172
-#define JH7110_SYSCLK_I2STX1_BCLK_INV		173
-#define JH7110_SYSCLK_I2STX1_LRCK		174
-#define JH7110_SYSCLK_I2SRX_APB		175
-#define JH7110_SYSCLK_I2SRX_BCLK_MST		176
-#define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
-#define JH7110_SYSCLK_I2SRX_LRCK_MST		178
-#define JH7110_SYSCLK_I2SRX_BCLK		179
-#define JH7110_SYSCLK_I2SRX_BCLK_INV		180
-#define JH7110_SYSCLK_I2SRX_LRCK		181
-#define JH7110_SYSCLK_PDM_DMIC			182
-#define JH7110_SYSCLK_PDM_APB			183
-#define JH7110_SYSCLK_TDM_AHB			184
-#define JH7110_SYSCLK_TDM_APB			185
-#define JH7110_SYSCLK_TDM_INTERNAL		186
-#define JH7110_SYSCLK_TDM_CLK_TDM		187
-#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
-#define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
-
-#define JH7110_SYSCLK_END			190
-
-#define JH7110_AONCLK_OSC_DIV4			0
-#define JH7110_AONCLK_APB_FUNC			1
-#define JH7110_AONCLK_GMAC0_AHB			2
-#define JH7110_AONCLK_GMAC0_AXI			3
-#define JH7110_AONCLK_GMAC0_RMII_RTX		4
-#define JH7110_AONCLK_GMAC0_TX			5
-#define JH7110_AONCLK_GMAC0_TX_INV		6
-#define JH7110_AONCLK_GMAC0_RX			7
-#define JH7110_AONCLK_GMAC0_RX_INV		8
-#define JH7110_AONCLK_OTPC_APB			9
-#define JH7110_AONCLK_RTC_APB			10
-#define JH7110_AONCLK_RTC_INTERNAL		11
-#define JH7110_AONCLK_RTC_32K			12
-#define JH7110_AONCLK_RTC_CAL			13
-
-#define JH7110_AONCLK_END			14
-
-#define JH7110_STGCLK_HIFI4_CORE		0
-#define JH7110_STGCLK_USB_APB			1
-#define JH7110_STGCLK_USB_UTMI_APB		2
-#define JH7110_STGCLK_USB_AXI			3
-#define JH7110_STGCLK_USB_LPM			4
-#define JH7110_STGCLK_USB_STB			5
-#define JH7110_STGCLK_USB_APP_125		6
-#define JH7110_STGCLK_USB_REFCLK		7
-#define JH7110_STGCLK_PCIE0_AXI			8
-#define JH7110_STGCLK_PCIE0_APB			9
-#define JH7110_STGCLK_PCIE0_TL			10
-#define JH7110_STGCLK_PCIE1_AXI			11
-#define JH7110_STGCLK_PCIE1_APB			12
-#define JH7110_STGCLK_PCIE1_TL			13
-#define JH7110_STGCLK_PCIE01_MAIN		14
-#define JH7110_STGCLK_SEC_HCLK			15
-#define JH7110_STGCLK_SEC_MISCAHB		16
-#define JH7110_STGCLK_MTRX_GRP0_MAIN		17
-#define JH7110_STGCLK_MTRX_GRP0_BUS		18
-#define JH7110_STGCLK_MTRX_GRP0_STG		19
-#define JH7110_STGCLK_MTRX_GRP1_MAIN		20
-#define JH7110_STGCLK_MTRX_GRP1_BUS		21
-#define JH7110_STGCLK_MTRX_GRP1_STG		22
-#define JH7110_STGCLK_MTRX_GRP1_HIFI		23
-#define JH7110_STGCLK_E2_RTC			24
-#define JH7110_STGCLK_E2_CORE			25
-#define JH7110_STGCLK_E2_DBG			26
-#define JH7110_STGCLK_DMA1P_AXI			27
-#define JH7110_STGCLK_DMA1P_AHB			28
-
-#define JH7110_STGCLK_END			29
-
-#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
deleted file mode 100644
index 1d596581da..0000000000
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,183 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-
-/* SYSCRG resets */
-#define JH7110_SYSRST_JTAG2APB			0
-#define JH7110_SYSRST_SYSCON			1
-#define JH7110_SYSRST_IOMUX_APB		2
-#define JH7110_SYSRST_BUS			3
-#define JH7110_SYSRST_DEBUG			4
-#define JH7110_SYSRST_CORE0			5
-#define JH7110_SYSRST_CORE1			6
-#define JH7110_SYSRST_CORE2			7
-#define JH7110_SYSRST_CORE3			8
-#define JH7110_SYSRST_CORE4			9
-#define JH7110_SYSRST_CORE0_ST			10
-#define JH7110_SYSRST_CORE1_ST			11
-#define JH7110_SYSRST_CORE2_ST			12
-#define JH7110_SYSRST_CORE3_ST			13
-#define JH7110_SYSRST_CORE4_ST			14
-#define JH7110_SYSRST_TRACE0			15
-#define JH7110_SYSRST_TRACE1			16
-#define JH7110_SYSRST_TRACE2			17
-#define JH7110_SYSRST_TRACE3			18
-#define JH7110_SYSRST_TRACE4			19
-#define JH7110_SYSRST_TRACE_COM		20
-#define JH7110_SYSRST_GPU_APB			21
-#define JH7110_SYSRST_GPU_DOMA			22
-#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
-#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
-#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
-#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
-#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
-#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
-#define JH7110_SYSRST_NOC_BUS_DDRC		29
-#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
-#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
-
-#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
-#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
-#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
-#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
-#define JH7110_SYSRST_DDR_AXI			38
-#define JH7110_SYSRST_DDR_OSC			39
-#define JH7110_SYSRST_DDR_APB			40
-#define JH7110_SYSRST_DOM_ISP_TOP_N		41
-#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
-#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
-#define JH7110_SYSRST_CODAJ12_AXI		44
-#define JH7110_SYSRST_CODAJ12_CORE		45
-#define JH7110_SYSRST_CODAJ12_APB		46
-#define JH7110_SYSRST_WAVE511_AXI		47
-#define JH7110_SYSRST_WAVE511_BPU		48
-#define JH7110_SYSRST_WAVE511_VCE		49
-#define JH7110_SYSRST_WAVE511_APB		50
-#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
-#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
-#define JH7110_SYSRST_AXIMEM0_AXI		53
-#define JH7110_SYSRST_WAVE420L_AXI		54
-#define JH7110_SYSRST_WAVE420L_BPU		55
-#define JH7110_SYSRST_WAVE420L_VCE		56
-#define JH7110_SYSRST_WAVE420L_APB		57
-#define JH7110_SYSRST_AXIMEM1_AXI		58
-#define JH7110_SYSRST_AXIMEM2_AXI		59
-#define JH7110_SYSRST_INTMEM			60
-#define JH7110_SYSRST_QSPI_AHB			61
-#define JH7110_SYSRST_QSPI_APB			62
-#define JH7110_SYSRST_QSPI_REF			63
-
-#define JH7110_SYSRST_SDIO0_AHB		64
-#define JH7110_SYSRST_SDIO1_AHB		65
-#define JH7110_SYSRST_GMAC1_AXI		66
-#define JH7110_SYSRST_GMAC1_AHB		67
-#define JH7110_SYSRST_MAILBOX			68
-#define JH7110_SYSRST_SPI0_APB			69
-#define JH7110_SYSRST_SPI1_APB			70
-#define JH7110_SYSRST_SPI2_APB			71
-#define JH7110_SYSRST_SPI3_APB			72
-#define JH7110_SYSRST_SPI4_APB			73
-#define JH7110_SYSRST_SPI5_APB			74
-#define JH7110_SYSRST_SPI6_APB			75
-#define JH7110_SYSRST_I2C0_APB			76
-#define JH7110_SYSRST_I2C1_APB			77
-#define JH7110_SYSRST_I2C2_APB			78
-#define JH7110_SYSRST_I2C3_APB			79
-#define JH7110_SYSRST_I2C4_APB			80
-#define JH7110_SYSRST_I2C5_APB			81
-#define JH7110_SYSRST_I2C6_APB			82
-#define JH7110_SYSRST_UART0_APB		83
-#define JH7110_SYSRST_UART0_CORE		84
-#define JH7110_SYSRST_UART1_APB		85
-#define JH7110_SYSRST_UART1_CORE		86
-#define JH7110_SYSRST_UART2_APB		87
-#define JH7110_SYSRST_UART2_CORE		88
-#define JH7110_SYSRST_UART3_APB		89
-#define JH7110_SYSRST_UART3_CORE		90
-#define JH7110_SYSRST_UART4_APB		91
-#define JH7110_SYSRST_UART4_CORE		92
-#define JH7110_SYSRST_UART5_APB		93
-#define JH7110_SYSRST_UART5_CORE		94
-#define JH7110_SYSRST_SPDIF_APB		95
-
-#define JH7110_SYSRST_PWMDAC_APB		96
-#define JH7110_SYSRST_PDM_DMIC			97
-#define JH7110_SYSRST_PDM_APB			98
-#define JH7110_SYSRST_I2SRX_APB		99
-#define JH7110_SYSRST_I2SRX_BCLK		100
-#define JH7110_SYSRST_I2STX0_APB		101
-#define JH7110_SYSRST_I2STX0_BCLK		102
-#define JH7110_SYSRST_I2STX1_APB		103
-#define JH7110_SYSRST_I2STX1_BCLK		104
-#define JH7110_SYSRST_TDM_AHB			105
-#define JH7110_SYSRST_TDM_CORE			106
-#define JH7110_SYSRST_TDM_APB			107
-#define JH7110_SYSRST_PWM_APB			108
-#define JH7110_SYSRST_WDT_APB			109
-#define JH7110_SYSRST_WDT_CORE			110
-#define JH7110_SYSRST_CAN0_APB			111
-#define JH7110_SYSRST_CAN0_CORE		112
-#define JH7110_SYSRST_CAN0_TIMER		113
-#define JH7110_SYSRST_CAN1_APB			114
-#define JH7110_SYSRST_CAN1_CORE		115
-#define JH7110_SYSRST_CAN1_TIMER		116
-#define JH7110_SYSRST_TIMER_APB		117
-#define JH7110_SYSRST_TIMER0			118
-#define JH7110_SYSRST_TIMER1			119
-#define JH7110_SYSRST_TIMER2			120
-#define JH7110_SYSRST_TIMER3			121
-#define JH7110_SYSRST_INT_CTRL_APB		122
-#define JH7110_SYSRST_TEMP_APB			123
-#define JH7110_SYSRST_TEMP_CORE		124
-#define JH7110_SYSRST_JTAG_CERTIFICATION	125
-
-#define JH7110_SYSRST_END			126
-
-/* AONCRG resets */
-#define JH7110_AONRST_GMAC0_AXI		0
-#define JH7110_AONRST_GMAC0_AHB		1
-#define JH7110_AONRST_IOMUX			2
-#define JH7110_AONRST_PMU_APB			3
-#define JH7110_AONRST_PMU_WKUP			4
-#define JH7110_AONRST_RTC_APB			5
-#define JH7110_AONRST_RTC_CAL			6
-#define JH7110_AONRST_RTC_32K			7
-
-#define JH7110_AONRST_END			8
-
-/* STGCRG resets */
-#define JH7110_STGRST_SYSCON_PRESETN		0
-#define JH7110_STGRST_HIFI4_CORE		1
-#define JH7110_STGRST_HIFI4_AXI		2
-#define JH7110_STGRST_SEC_TOP_HRESETN		3
-#define JH7110_STGRST_E24_CORE			4
-#define JH7110_STGRST_DMA1P_AXI		5
-#define JH7110_STGRST_DMA1P_AHB		6
-#define JH7110_STGRST_USB_AXI			7
-#define JH7110_STGRST_USB_APB			8
-#define JH7110_STGRST_USB_UTMI_APB		9
-#define JH7110_STGRST_USB_PWRUP		10
-#define JH7110_STGRST_PCIE0_MST0		11
-#define JH7110_STGRST_PCIE0_SLV0		12
-#define JH7110_STGRST_PCIE0_SLV		13
-#define JH7110_STGRST_PCIE0_BRG		14
-#define JH7110_STGRST_PCIE0_CORE		15
-#define JH7110_STGRST_PCIE0_APB		16
-#define JH7110_STGRST_PCIE1_MST0		17
-#define JH7110_STGRST_PCIE1_SLV0		18
-#define JH7110_STGRST_PCIE1_SLV		19
-#define JH7110_STGRST_PCIE1_BRG		20
-#define JH7110_STGRST_PCIE1_CORE		21
-#define JH7110_STGRST_PCIE1_APB		22
-
-#define JH7110_STGRST_END			23
-
-#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
-- 
2.43.2

