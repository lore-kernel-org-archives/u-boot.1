Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A987CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA5E84659;
	Mon, 18 May 2026 03:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RRb7Tzl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC2C83AA9; Mon, 18 May 2026 03:13:36 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75AE84659
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9Qgfr1TR2BdSSJ7K5bcdJh6xi+LIof/8lpxdogANhvC5q9St2wl0OGR56JWAXNJjM8W92MAXtdFYVXp1g2EjsEZ/AH+b85oZJbbjmyhtTxpE8uaYb9pi5daDUlH6tYV2aCJN2ABTQpyvDSIoGh1QTD4JUr8apre8llH6yCkRmFT59srVvlUvJDtBooHXNOZbN6HgS4wZW10JpPpYTmM7qPcRH3hmu7hhH8l5dnAoBCpLoosyQUu0agsZIa8sNwHN9NDoACNnytPH82SBxB/1jAV+8cJPHmFikutCGfpbKNrhrTTa044vSI/RCc9j+NaleuVrmkSwR9OzEDdHtpNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2GpDimq/fTM1jW0d1gtq0MxB0VUva2aps3eA10n5e4=;
 b=a2dB2cp2nCiPbPK5gi0bhTODG0ZWHyR0ooUxodXNXv+ia74/bvcNIjERkcoDu0miWGqMb/8slq7exJnKzDAE7+KWQ8GL304KAkG4OeCFebhMFV4/g4fUDvSfO5fDq4mRcnbDqF3/jsb7JpUFpzDBIEKnUqiFvk5LNaCtR5KZbCcjDNVSv4aMdxHlCoMNigF6kkfng58XaBG/UX7IVHFy9j3MZOY0AK6BJ/JiY7Mqeu573q+poWgLKHR76WJknF0ZYGJt5S9gYL+hoQnS0+woAwE3Z1EjCfBf4WHO7dvY0PO2pfgT+Fb+2dkfVffXG7kAGZTNQC4SPtr7isr4vVdfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2GpDimq/fTM1jW0d1gtq0MxB0VUva2aps3eA10n5e4=;
 b=RRb7Tzl8BVY/EBo3bIv/UZsSaUrWycsLxm1rfENJUxJzWVjuxmNMs7yVV7b8lvMmDzbWnBsyQep7y66LyD1MbNnF+z9oh1oH0tnuij7u/GM2+vTOSb0Jnht7KRDBU0J0Ji+WPvko8KYO6fGmxS/hvqJGJlTwpQjJh4SJhpXvhNaFLjES8/91fwCv3vlW+oIS5sOYHu/89pFE7dSZszKGVRy6gqtYBqgbHCOYpg8zWgH/bZSprxwXxYQGWJB703z5AiL034ueVMItE5UifbagpfD6PEpKD+7APB6DVFk3r0K6Zfu//ABCaXu1xcFMuBmMP4o5dzoH68RLYTWDtFCjkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6928.namprd03.prod.outlook.com (2603:10b6:a03:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:13:32 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 01:13:32 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 9/9] spl: s10: Enhance watchdog support in SPL for Stratix
 10
Date: Mon, 18 May 2026 09:12:45 +0800
Message-ID: <20260518011245.19083-10-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d936c4-e422-4b93-fc3a-08deb47aad54
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2+Oy8o/1T6lQSHCKo9O2c3tCpJAr8mGo4d377izZiJQDx+8QpxUQYyznbu4EBOzl+jACXjbkSZZzv8v3zJZ/BRCim6Pr5rqXN10z296ggNq927EXal6+aXVtK7MPmOvH6I5xWEVH38v/tb5p2d/fmFy2soTBHbM1+ggp6CZL/cDTdHoDoQn//akJY+aXZGC1jkQql1N5h3wrCzteUcZvZizfkr+xsFTtR3ng35cABkK+JulSjRzn4kkLZNu7onPLa8ezN1UqFmO5WwRJFPpj0E6LtysvTGD7434AYt6AnwlTHFKtUOQP5wQTBwhbLLQvigUH3vaXmg7P4LIK+/lJvLbdmpmoFsMBTG5qNLZoxvmwVc0wjw93iA5PLWTrmFkTNa4QY870gmGV+x6kl8pLB26+rSg8YhIER4VdN1aylpbGeNKAxt4QU3qb4We5vRv6UYwCFekbnuMab1FFaFV19NIAfyRW4Oc/FAs4fOxflssY/IgLFyTf9mzkRcM3Z5L8yfGiQyNw9M/gy0QuhGzScTaItEbj+3C8ZIctCwckRAkkgsMC/cYtX4X6drKVPRloFyCLUNQx2VrtQ1Rm6q+zjurqos2lQUJJa7Ir7wklY0XLokjMcOQ0KJhl1zj8Oc5Glfk0/7Bgx3W2y5gxA5SzE41s/gsSSEYG+tnTS8hFEo6/52+mKyQ8T0nYDEiUtbQ9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKB8XlbruAelt0x5MoWriiepSWyA6uuLBGzumi3PJCGsShbLT65wvJr/ca52?=
 =?us-ascii?Q?g2v/ZnXxWyUfK3ihDDJE7Yk4f8vaek9xidL3ALoTfH1pzseTwp6kFbz07ZPp?=
 =?us-ascii?Q?KMZx1hVABw9EW3Gcj07xB61cJdE+huakCW14ilDZvrBRowugOE3OXtll4nyZ?=
 =?us-ascii?Q?8exc49SBad2yvwactvUPclzLRpe1vmnZB+mWCNsofkBWFU83pegJ9E0k8KNt?=
 =?us-ascii?Q?nWZ9e8zQL5c/eh9axjaRPcw5iy2TpPM99eizCtk83/PL6VT8IQYlRn9XTO0w?=
 =?us-ascii?Q?UENM7oEWBxYClSf7yTHTTSA7ByxTrH8wPp1fOfK4eoow8pp3zjCVVGP0+En8?=
 =?us-ascii?Q?9TZC9qkp01N4WaROc+0ngGa58LCKf37nf83zbKS8nJOd017NLPm8OTUYIBBp?=
 =?us-ascii?Q?2aCIyD2rysm8UmYW+n0yD7hUuczB1NhOkKT0J7xH56Ly/KmbUz7+aDNTJToV?=
 =?us-ascii?Q?QKOC3VzR00m2BRMGK+aM2JNRd5AU11Kv8VvSovqqkfKTR165zARbhWQVs3nZ?=
 =?us-ascii?Q?lZQDW91rkL92PXBRMe5v/0vOUa87PYJytZ57jKW/f7fCuqMGi99EJn0Am5Ea?=
 =?us-ascii?Q?DG9ohycO3jo5MgwQKJ7JRP8B0wqH1MC6VjUesGYy9/71UhiGDpCLygd4opT4?=
 =?us-ascii?Q?TZUjd9atk/MSOFOU2Nc7CIhR53ceuyqt0fb91OCwLpI0m6M1h8+hbxCrikC1?=
 =?us-ascii?Q?qQ8Rbri5AuMqoLrieSEwFlhsJpBt0zfvpKHPkcdTGtRSMHUhsqLK9ocLIDOM?=
 =?us-ascii?Q?NJ86yazUvtpZ8tWBICIbyUJgmq9692S8OgQjFmeHHkgaqo0q4GMBXNDLt8VM?=
 =?us-ascii?Q?dLngKgd4XmnFeARg6jS2e14pfvWCFSJwz0YXWwrslCEGBAdlf6ZXsnxTIOED?=
 =?us-ascii?Q?EK9sVorxgVwq9H7Bn7QdF1Jn9tkpPgNK2GQ1P8IigQSE6j5Xwe8yBUJj5y8d?=
 =?us-ascii?Q?pcImAw765ZG7PzSuoWl7wBoqml14w3c0sMOPnTsg8DQKCOg4mJjWzfOP82q8?=
 =?us-ascii?Q?rZvM1Qrx2FZphbzk/P0PJC1xpsOBy8FhRVSqgBzkXF3EcYtc/ko5bjrK3ErL?=
 =?us-ascii?Q?hw5SH2/Kzs+ZirzGL1Eky9HyY0cxjNd6Z3YrcO7YBcGFts2JvAZStzG5zax+?=
 =?us-ascii?Q?o4fek2ddYH8mtdKTJIOgz2vE7ZMGngHOz2muwYcSR+dsrABAyy8MGhCOpKzq?=
 =?us-ascii?Q?EDxug8wl4Ri8OSvDh+dUiVmXHpUFfjTQS2Rp87w14DMH4HzC6ArYprnMVbWa?=
 =?us-ascii?Q?FC55BZk6kJ+BEeyfqiBf1yaz1oxARp6EsPh9Slq04mCbpevOa/TPfZ3YCQWz?=
 =?us-ascii?Q?d+5TOs5Acezvdn74cFzSkpzzQY4S/Jqzw07qPmNqJSnf55IE6X20pwWW9e8g?=
 =?us-ascii?Q?CAR1Q1SFKFoV7NFoMqqoCohbdtyKlncWoBSdkHUstWo2WFFRdFYxyI+W9ZZ1?=
 =?us-ascii?Q?MLD6uI5fplRhvHxngxfkF6mfbZRbYq8O1SrUwNYyhYRP3QhUD6025WPKmPF+?=
 =?us-ascii?Q?7x0jsfoR9jftPyyGqOuShLPiNuPZD66VOrwJ9d8q21Gw1AIlq/nyOYPyAKV5?=
 =?us-ascii?Q?aEBDrgkTgojP31I0VkDXM+ZKVgW83BXWaO653xeIblnhHPJNqN+4dGxXak/9?=
 =?us-ascii?Q?pCI5D0HxaqqrlEn1z/FZEPN1ZttFmNCBjMcWGnpzYOX6rZo0va1HWlQBUKWB?=
 =?us-ascii?Q?Yyl5YG9WiT6/3W/aNag4YMH7IXgkL4quP1+G8TM+EaBGpt253UYFJRaWeXna?=
 =?us-ascii?Q?KDsRSaTH2iDzjNFBzLzJi6leejlzvlI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d936c4-e422-4b93-fc3a-08deb47aad54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:13:32.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0ZbtTAiAqgXZsfyjb3dXvAnMim4Q7MyMVCQg5m2Owsqh6qLQf1memQPl5vD0BZKxHAuhHC8TjK7c5/i8z8pkgrFnz3VPuKHPZxUql6FzGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6928
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

Watchdog should be primed before longer, failure-prone steps such as
firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
those steps, it is able to trigger a reset.

Switch from the legacy hw_watchdog_init() path to the driver-model WDT
(initr_watchdog()). This requires clocks and reset to be valid for
the L4 watchdog block, and so it must run after the clock manager
(uclass_get_device(UCLASS_CLK)) succeeds.

Enabling watchdog immediately after clock init keeps watchdog coverage as
early as possible.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v2)

Changes in v2:
- Commit message improvement

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

