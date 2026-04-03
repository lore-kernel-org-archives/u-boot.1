Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E9D73087
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 02:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C7884150;
	Fri,  3 Apr 2026 04:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="W7Piimug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DF583D8A; Fri,  3 Apr 2026 04:25:58 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD6184132
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 04:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFA7YIKGjzUmtSWBvBHYxyDDxS/83q5yMx3V2u+5oOAliS9P5j04groC7dWXaEsNm1aFB8J3SDler5BIozrCPoPVhG41k3EFSNhNlWL1ceP99LUmvhlFvSF2SQLl8t2GuO9B0rl5FoOyevbIbF+rPNtBjRLvvYLOrFPQxrKx3bH2dHrLzPZY1IiB1XFuOrdvuD4uzd6S11/LcnqQvSx72BW8ISriZEqsHCytHeaDVn1cxwk+58bZuwRtroY834MMPWVy3Nsc+DJDKpVC4GAEIzhI9xzQA4cmWKmQqYWDjr7ktv82hocZO6MlodUlMLlY2s+bqQrPvs/LP7Oi0wfsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JrSaib7s/Z2vcUrs5a5+eihNBeIjO8pqf7VRG4Xx/4=;
 b=RkSvHuv5OsCSlSmXcqKL6CQxlV0FZkYCmVe9YwzydRho/H1vYbQ2gUIi1pD8Fp/fQ2CkpvecC+w/SD6gPzKDvoeWbvJdeKNHgtSnRFcO8k3s4EpyIyxQaIuJPWij6zW1EahfBAcTfn9Tq8bu8EHNIbsYd9ktu8GbVFjD9ti6v5hye0IAEIqfizpJph4DZALa9MkkzxmWq/fruMDMIsI1gk/wubeRJW0rKYVNW1rLH2xF7yWSr1BVzIyhgNseguJMFlMGMIylMz2fXm9UlZXU7/FoJZXuXKU1A7G0vDyzmuJ9Wut6cpMIPJ0RseKHBfmOCpNrtsfNIx4wfsLMkXhFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JrSaib7s/Z2vcUrs5a5+eihNBeIjO8pqf7VRG4Xx/4=;
 b=W7PiimugkO17x1mJ+95KPLD5w7q+B4qogvwxt59493ReSB/p3eq+4QloCuVP/spFrwMT4LXiggFA18zHqbg1fH/9lAdWiRZGtkT9/IR9BAoMoKdPRHjAvkZRJJes3mMCClwY8fvUF5OBIh907vI+qNxHFCYP6+9+HdrfByEmCg6BdMrIRJMB6K6vcxEQz/irOt5BhQpvnZkohdEpUGIfHmZX/TvjskykZe2RA3J+b2gXR+tXpQFTyDVHOjDc+2dU9c46IUxPOJpMmPLq2Qs/9MVgQWFnVWqkrLxrmh/QQ/2yFEcYpiOIHRcDCWI8QIEwcIByAqr7D6wdJqbgt9Hsnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989164.namprd03.prod.outlook.com (2603:10b6:8:362::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 3 Apr
 2026 02:25:53 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9745.025; Fri, 3 Apr 2026
 02:25:53 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 9/9] spl: s10: Enhance watchdog support in SPL for Stratix
 10
Date: Thu,  2 Apr 2026 19:25:13 -0700
Message-ID: <20260403022513.9446-10-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989164:EE_
X-MS-Office365-Filtering-Correlation-Id: 6957ffab-7af9-477f-7a1a-08de91285424
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9yCJUEQk9ZNhVmATE7eQGqtt3UI0gMGTvrdWbomFHW540TjR4z48aXxfpryPAb5SPt8UiSkfZ+oJdt/QfRw0fpNq3oZTA8eNX+2WReXSGYc7wiKf9xnBvH8Bnw3PoS+we2+LURqIfIs6ri65LhTa4pyckolvOXcPVvJEow6Pt4DL78GJ59vOR+U39Qrno5KLeM1G2Xgzt/Xoz6agnDASHKL7OwwRffWLx2Hvqj3li6cMXnUpyRhUhqxQTgHmJ9jeYbaKwIX+uB/ru4HkGctqjqxcH1gfkW4JkH8lE8O5jfYttUdRi/OSIH+DOpdQfEleqihcx4scFJsSVyYCv+Z0NAA6GfS1kD4fm3kMUTOguU1HTQIFt6BNcTYsnsqY6tJ4XzwI2jlWIHCYSlQ8lZNOCTq6S1v1o5vKaOsLotvaLuunUqf0DyuPAnXm1AYRet5eYGAJuL8EqQYlhWs0BtWAKiplvtjfOsdsQi3Q9dLjNCpqg4mtEYUgYQL4cPrKIHeFbb9pPkNWSdv7TPH4SwT+Ok5MWkr0noPUhuReNED0xuTSrI5fYs/BdwrcspxwlXUkKuqMU4XunplEQmTGnYJqE7JDvQLBvLbzCQsLHlj5EPq1M/AhUn67+/f2PTsHhTjTc3VurNXSKR5xokhW3HyWpNS6d6zNGY9p8ISEdJ1KD3EdSjhrLIgyIYOUBDtpj56E3ryYZ089EdjaTvJ5l43vo26iqAahUEUiIS+T/3y74ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPlzv6jIBZw4Qs4auKobCMjEy/srtraMAeaEWfoyGGPktGtCO5BPNnpKny2n?=
 =?us-ascii?Q?J+s0V/9CXhtSt3nxeFIGGUuMQi4ljB5cEDD2Fpc5TGWNkH7UHAN66EDVRw8i?=
 =?us-ascii?Q?xGi/wpjrVgn+6CkFAiVwWr2E4ejj7JCpfZ0LG8seCBXgg1Txa+bGfkFT+usF?=
 =?us-ascii?Q?QwDJ2SJLJvwFyi9218CityLy7qQumX5eN9baqY9FJPHSNPYm0gBQt/inwhrv?=
 =?us-ascii?Q?zUQE6hVuzGGupPuJMP+mZjxZ1wGqrhzGG1b1ftlV1PptvM0AXmNDIahKnnA6?=
 =?us-ascii?Q?Qo7+2PqD7lsYtumutsipjoFv4mlABeKX59gbIDuzsHuymO6hX1cCitXAOjkC?=
 =?us-ascii?Q?/hjZXurWKisokYdF/9SMFzKAeYrj0lPZ1mpBm+91c+/ejmIBBIYIbhw46TUO?=
 =?us-ascii?Q?SWv29d6jjJ5bnixBWtIHafkfRhEixpbiD5DUe+VbBKGKg1wFs+0koqayyURi?=
 =?us-ascii?Q?c9FpT7o48wf/XEgdBg65XyM5R//978RtA7qeTAXsbH8YsP0lx70NpempzV+D?=
 =?us-ascii?Q?zl7//VhMMuoqtqMm4ZmwdhV4uvZlxPNfXoFx7qMGykpgEG48mY2Xu8dQJZJ9?=
 =?us-ascii?Q?zJfSbnVqJzYxztZfBXLiSfxdsWD1EaoRjFfSrx12GK/B5dF2y4fIKxm5n08y?=
 =?us-ascii?Q?l9arxrAoXrPJLYJS3xqCsLUoJWedQcdb0ZZXRNuOwELqjBD2sTOAo5FdiZT0?=
 =?us-ascii?Q?siPYBSjS6Gr9abGU4EL3fRVhQ0nR+/HuDmZcgurjGkeZystg+2lUQ33etHkM?=
 =?us-ascii?Q?9CGryl7fwl1//gX7h7MBw6bYnYvnbF4Sy518EDS6EzDOuvCIbyClo6bPhliN?=
 =?us-ascii?Q?8tpHG3W8Q6aCVIi9HdZQWIazWItgFnnKaS73MH2YXkWO/MMAhFDfrwQofcD1?=
 =?us-ascii?Q?CIYJZnECmStGNMe94L7cPUTIyZc2v2nT8tr2BYtg3z8dRl9NOGJXkxkV411E?=
 =?us-ascii?Q?nibC11RoCHln66ClNK77oHI/yY4yoLzFxnFV7j24MFf4hxlog6adxvzof3u2?=
 =?us-ascii?Q?nRFIORxWdQacbGb1yj54qLZ8vI1FmcxZajpeLuDJpZC25tVx2gdbzab8/VnB?=
 =?us-ascii?Q?xZYB1rSTwwL2uGWZxh4e+cgu+PfMvgxSy+cLthRZ9hXuJ1gQMzuG5unu2QFl?=
 =?us-ascii?Q?WwE7z2uFJhrt6GT15YDCeUYp7YzLZ6hnPsz1oflCOl7Mxdf3Imvg41xZ1Dcg?=
 =?us-ascii?Q?+vN07wJeCZW/jcYWodB48DjfzRQKxfZ1ugRE2lfa0HmSdqZH1XAZ6nXa5UUo?=
 =?us-ascii?Q?keHm6EZFgWycGv9sTnaRAOhu3yY9i+WZ8NWgqh6fwBh7Hcw6jluwr02LWZur?=
 =?us-ascii?Q?HwbDCJgcAVslXr/ULrTwaemogAjrV4Zku4eMsKjPlchu/972LfCT6f6LwygY?=
 =?us-ascii?Q?UuC7uCAe029KyylUQTz0kTc9TH+2wkVbirWaGjhgt3L5OeW616KbPxCWvib1?=
 =?us-ascii?Q?a7B5IN0BvRwmHQrBb8cPaGOmtpDW1Eu09GXn2k15KbA4cFF9f/T4f7CIHiec?=
 =?us-ascii?Q?JHyslpMlKxR27Np6BYZxh4VPLbVYGSqw8vIns6POqH3/NSjsK+TnEA7jjmht?=
 =?us-ascii?Q?ZrbzlJ2Wu77VTZQ+YYQJEsAyLMgFMOSWkwOVZCKaQUJANP6giZ3oRCtExbfG?=
 =?us-ascii?Q?VU9+v8GVYObxdKkrbfsztbNP+L5jR0mVdVuP8vaIi3hGBLzmuTOSBqh7IOnf?=
 =?us-ascii?Q?E7f7Q18TJs7a1Mhf6T6TfAa/iL/gSPBUolbc4hln9FBXVJwguaJTFuKu9nRQ?=
 =?us-ascii?Q?uYx+4TQ2AjnZw4OKrwuRzxSyNwm++yM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6957ffab-7af9-477f-7a1a-08de91285424
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 02:25:53.2099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQQOyUy4SpWpnb4IQ3v/0FEDhaaNGuWoIgWGGh/jDnVPgzaTfs41zHkchhDkeP8WU0Gwhi6AIfWDLprWBodesZBVVC1cl+RMg0oBQPEZZ2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989164
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Watchdog needs to be fully executed in the onchip ram. Enabling watchdog
before initializing other components such as DDR in Stratix10 SPL

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index ace029557f3..588dca4fcd3 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -18,7 +18,7 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 
 u32 reset_flag(void)
@@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 #ifdef CONFIG_DEBUG_UART
 	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
 	debug_uart_init();
-- 
2.43.7

