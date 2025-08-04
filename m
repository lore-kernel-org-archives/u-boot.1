Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEDCC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0255383E04;
	Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DMHmyjAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7E583D77; Mon,  4 Aug 2025 03:25:23 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4072583DB6
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSqyH9JfCRYb5Sy4EiaoNo16zY9ij8R35ipCVqg4Qq913WxOcfWlviDEOzYGdPvtHIn8k+ONk4TNhPP3nP0Lfb4r9hVhXkJP3p29nxuppzeJ8g0Q5hlMC8rYx5EALOKhZgAJzFEp4IXtDgzzfVbfETqUjzJdzwN2RVj/xyfUykL88zOdhtMFy52THSG1TaNvf4OZeUR5AQOdMCRk2efhH8vvx4a1X06S8Yx6XPN/q8R/N1VZLharHMpacsh6QrXJyVC4o32h8P+pTkVkaRwQnKRwZ6+Ml561fXOF23J/wsDLOJjR7ClAA1BZKfjZlNbrwrjs6Gz/IajVETLBOeSjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGLzGqnJQ6qN/RdDUCBSFhTomZzHM6VbBxPP5FaBZdk=;
 b=JRXBgLmKhG1/pv6S2cq1X3nN3IPxUreaHKhqcqqzWthvHZsjn9f+KgwSaLqwK+vHtAXVHmbYU1v34om5fNWZ+2IzwjFUI+27QZA1R4f6Qg6givROWbc47p3REjrMw+6fRMYGT6bHKz1pFsmCe7TnxQuSNRz39fE0BSbsTELBFacbZq2v3zwKYrBXd7Mk99wVv1HXRINaaSepCx3OGRp31u1jz4/Fmmmm6uAO1+A+L7YD2eDkHoX2I3M6pDowYr9WUj1WX7OKNFVjgeKHd6ErSdYkTm8PP9YN+zmpGPGe2lDIJ7IfS5siMd46zaNWmdhfiEA65oRuDY5zVDf3iOtgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGLzGqnJQ6qN/RdDUCBSFhTomZzHM6VbBxPP5FaBZdk=;
 b=DMHmyjAkih9ZiLdF97skvW5Mc4NOHxqalVtbY65udJSjPB7s1zE6Pr0bBd6fjjw1ClxUKx9GFj3ZF8Ti/HAeqbfs/BCzAe+78eq80181xbCoIzxlncsbYKjDYNz7BDdNMVqqFFlk+iQyPuAMmv/1uMxFR9S6HprePvyhhrKeZz5LFfkLObBKeVER5gDnYktl2w+rx8ugZBJJZEz82vZSJh4xBihPY2ENOVvMY+/OGBGJka+QQBZEhXkEVhS/hDe6BHvud+MvdlpHijvWrQRa/yCfHUWEBKuaKg8O8pdVvy4s8MejzTKAsM2MYlx9dMfcRXI/7d/mHIgM2sK6UUQA/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:19 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:19 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 07/34] drivers: watchdog: Enable watchdog support in SPL
 for Agilex
Date: Sun,  3 Aug 2025 18:24:34 -0700
Message-Id: <20250804012501.21811-8-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: eb096473-1762-4a33-c8db-08ddd2f5c60a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0JNAAD+EQ9RGzhvWmA5GyvQzG5I+Uknj6itQc1+XWEbShzxSWXFpr1wbqXia?=
 =?us-ascii?Q?TBBxVO4JZJv9NbWQavQTOy0BL7eB2YyMuqW3EovmPsikSSedJTtd8MhDX5ag?=
 =?us-ascii?Q?Giq3w3EJBgv3za5KcN9IFP6itSA+Spg3ZtNKIG4soc8XLOhl5p/gHgADgDQU?=
 =?us-ascii?Q?LANDX2usFQTKOndZz6XROYh9nHgp4ieG8mq0CZhb4zqRPXCAPgTtZab5mKL3?=
 =?us-ascii?Q?yyfGQgs/jTwBFV+nxHns4IkHK6AcRieWIbjUNnn2yiOHhJ00xr/lMHTyzK0I?=
 =?us-ascii?Q?WbQX23RsGhBPk6WQhG7tcA+olMnh1pcn0JJEhnVw6i90ewl8eLssydTNgIYM?=
 =?us-ascii?Q?cQNmLSX9dELjMZ35rRogvr291EpR4DJdHbJEpoSpzVR0fQcA7dUbKfkA0rtF?=
 =?us-ascii?Q?kZK14L5ymkPlLChIxhZnAGTY8E+c0JlKmwhO8yf1T68W7gEIAT34DgFThM1Z?=
 =?us-ascii?Q?PrbZ++tiYH8UvER9fIYHFGD4xF7VDEXDf7fJlo0KC3bs9gDE8eWHkmarLFQi?=
 =?us-ascii?Q?Ve09KQUaHlEeS0WkvemFrUMnp1IGTn9I5LNOCSuGm2hKXJSGOWnSHM0RsanG?=
 =?us-ascii?Q?UtdGwBDIAk2FHLWsWmUXwYsgyov5XaAdgc6zhF7dex52mWMYysx/dLYjyjYh?=
 =?us-ascii?Q?EK8dKs531rNwVgf/rMT56DLLlufwrGvqR8agiq4YLpQ9KInTBZqD1aFSUOzd?=
 =?us-ascii?Q?jBzLJ2Ve7V97iNb1FkG7idR0MIqbLB9fuaBv4zcaIt+OM2S9s4FsDyRA3BRV?=
 =?us-ascii?Q?ycC0Hm3MEAWbq+gG92nTnGStyGa1gzhU5rbBxTxiPVH3tz7J7hEwLvD1GXcc?=
 =?us-ascii?Q?9D2gqUL9fhJM++1h74Lqc+EBi0x5hBhNnE9T1xGxrfuq02N/WVzVFdV/vCq7?=
 =?us-ascii?Q?CeA2IRHS140W99jypfcQHlPJfqRJhExXLEmBXi4gpnKgq4Ze6B1nGhr1kFJB?=
 =?us-ascii?Q?L04+8SsOt4Kv/oproIPV6F8JQGiDBDSUKftnoiILhypWuKVkXQzcEjUIM8Xk?=
 =?us-ascii?Q?OeP1MWn6YyZAG/vXfqXAKQ8KeVjMV7qnLuWKwo/QoJzlLhNFw0mKRmoOJpt1?=
 =?us-ascii?Q?LCixRse83Q15YLqIlS1zQ6h3zmpW8dp6E27/b6q/s0nSkJu7ksQRWv+sDKyA?=
 =?us-ascii?Q?x/7zgobAswtZ2Ss7ScsXbPRAP9yu15aoWPrYuZb9T2BicZzYB54y83MzRv5i?=
 =?us-ascii?Q?G/0FD5UUn5T+1Jslfp3DLz/0246I5mMop8oOWyExLX6llfMlfPVxFkHjKReO?=
 =?us-ascii?Q?M41o9USOJQwyVhoD3JvBhz88TLwY9XeQ6EdUQDa9BMunF1cswiKc0QE6lbqc?=
 =?us-ascii?Q?CK/Tb2aQBUMLImr4EaW11JJozemuc/jRfZmvhAoapEXK7zKoy2Hhuq/iD0jS?=
 =?us-ascii?Q?sj1UYHEoCwntynTrLnWlOH/BXC1Kph0JsG/gj8stDwRo3mLcKvv4OsKVtIq7?=
 =?us-ascii?Q?AFjIfSxa95E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eRWCMRWfclzIHQlFcFle3Y8puD6KIDoloki9QszJoxZevFLc0qZP6Clsnqt1?=
 =?us-ascii?Q?eKz7jz3WtjCWNKNpv9NpTs5JWCeClcdVEh1b1rWGPUmpCzDPm4x0MqfOmV8V?=
 =?us-ascii?Q?tsXtzTV+lau3DXSyZVI2YdvAfoxOs6jmBfh5Slcr9pumZFD76z1/yRfM5W8c?=
 =?us-ascii?Q?1Vj96SPWdRfrN/w4srvKBXFLMfzGq+bDYLjzVrC/Y7BvOXP50d4KmP0g0SsA?=
 =?us-ascii?Q?x9gAtI0JC28f0PlZoYKO8V/dwn+NPRA2+2wGoCvJl5SYvNNZK77ARwjtJW45?=
 =?us-ascii?Q?hvgSR9YGMV4YAeXtka8H7DwxqD9EpqjvhxdYoMyjs0Tld4Sp/lXwM05GQ94j?=
 =?us-ascii?Q?bbIgOWzjhEcEDtbB+rNJs/LH9PPvB9WVVtMfpSzVZf02QO8Cuds8VDUnYBtP?=
 =?us-ascii?Q?gDrikXdkNja/LTbyRxD8zkIjPtBKK7rmpih1unNHLAkROlHo46pvvs7Lg6Wq?=
 =?us-ascii?Q?z5jct2diGpRyKB20liUrRkfX/ZC9KDZI8YXSRJHD1bymC9aDKK/+GpWtgK8g?=
 =?us-ascii?Q?q/1AFE5J5hDVyoF3FJvbLU7Uzwkrkip+x4wvdXm118xUXQ5TVFKTPlOfiCFC?=
 =?us-ascii?Q?XYlEbT5a+W3Ndcq3ZppwtJZyMkdfHE3lYfKiWv4noNcCIsL7u+8FqrVb7IwM?=
 =?us-ascii?Q?VsuGygCHIsSWZ2j3lEsgIzz60hIqARsh143jjti0LkyPyjiprEc3tupsAGbp?=
 =?us-ascii?Q?l4eimuQgsojdvT20CVxRc16Y1fp76jJVEXCpF97lXR+PQs+Cfn2dwZEi/9vI?=
 =?us-ascii?Q?kSJCYkwC6uKcLxUy44zlKtO1ISgYrJ6Yfldj4j9y6iEldyBgQYHJiKiTcPqa?=
 =?us-ascii?Q?f7MKcP/uw+jPV37SyhejCeKa/lJOMFWwuQXkzYQmNRsgwB125/Txt6sum/9t?=
 =?us-ascii?Q?XaaploUUVtxckvGfsVzlkx9SH/Szd6/oYlV6m5+fPiKhVv1/MbaGrINO4dCS?=
 =?us-ascii?Q?2D2ZJD0DcDEKt+g4oZlUtkKGdr28gBPGyTetamtyAj6uKduiyoEcGvZsIqAl?=
 =?us-ascii?Q?1Yc3liPvEBbESUCt72l4bSspSuyPeKs9c1U68YJXZMXOelCGGKHJihefqfqR?=
 =?us-ascii?Q?470exCvRNGQ9fkVI3rxdj8/8sGQTlx83FSscDpiITLIuTtrCKCHkw+pk37U1?=
 =?us-ascii?Q?EYl82uw/BKLcomoVhcNz/8qTK42Hzcf/WBtpCxognXW1Rs4opglKd/A+ARbj?=
 =?us-ascii?Q?4/DkAdp47s5jAAZJU9bbNGK44qFEKU1rfFMXTKkf//P3HBS5LRgthdQEOtVp?=
 =?us-ascii?Q?18N7+zrQj7n7g08ahhZQJl55DMuilC8DQEcHl0F8HRW6EJ64U1o/BZEl9HEv?=
 =?us-ascii?Q?xK58y1P094/I1ztyUvrW3IqdMMnPRn5OquIloGGj0ckTL4Z3l/b3zNzAh6UH?=
 =?us-ascii?Q?Tbnw8a83fi7ALg79ycd/8AkWiqh/6BXWr2ZUEpFNXghsJ1cj5a1IMZXZ4+qs?=
 =?us-ascii?Q?dd917QMOtz+JcGLFXJHypBt2Aujds7EWM4vI8rjp9J56I5nU7uvVxN6xOlNN?=
 =?us-ascii?Q?fS7EyfSv6cETc6GH8W8xZXEPhFDwZsbSzwHDcrJQmCC+3VPBD8IYDemy4z/X?=
 =?us-ascii?Q?1hYM4RXWSE2aJDYz+r3TgoBEZaswbSToyjQ/jxs4CNP7Q5NTKuFZeCFyihL4?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb096473-1762-4a33-c8db-08ddd2f5c60a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:19.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCfT2wAmLk17lxIHxobpn3SpIBjBmr51KmQUa9AHBOTGh3uzAhsOeZdvm/SigCspoQ+0KI3ZBz8HtxngRsah1vFphu6i/ObDASGD+0965rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

Enable watchdog as early as possible after clock initialization
which is set at 10 seconds.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex.c | 10 +++++++++-
 drivers/watchdog/Kconfig           |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index c2956264bc0..208085d4049 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -19,7 +19,7 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <watchdog.h>
+#include <wdt.h>
 #include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -83,6 +83,14 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * component. Watchdog need to be enabled after clock driver because
+	 * it will retrieve the clock frequency from clock driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	preloader_console_init();
 	print_reset_info();
 	cm_print_clock_quick_summary();
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e9ea874d0e3..985de714184 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -30,7 +30,7 @@ config WATCHDOG_TIMEOUT_MSECS
 	default 128000 if ARCH_MX5 || ARCH_MX6
 	default 128000 if ARCH_MX7 || ARCH_VF610
 	default 30000 if ARCH_SNAPDRAGON
-	default 30000 if ARCH_SOCFPGA
+	default 10000 if ARCH_SOCFPGA
 	default 16000 if ARCH_SUNXI
 	default 5376 if ULP_WATCHDOG
 	default 15000 if ARCH_BCM283X
-- 
2.35.3

