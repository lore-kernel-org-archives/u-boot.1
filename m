Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1117CC87FCC
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 00:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D5D838D5;
	Fri, 25 Jul 2025 02:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="eOAkD2Ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE6A838F8; Fri, 25 Jul 2025 02:38:10 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C97836A3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 02:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMo3+DSiP8cjse/9i1xYwYMJ2ifKncwN/bsnjbgFEjvs7IECuGoEeIlMcIsHiBOz2uj1mCS1ZWvzO0Nf1U4DdukmS/bAIPCjQlrXNhWCTbHK3hcaRsh3DoxNR/vugVloO+mEbQPcYa+lJaNbW9X7mX+wghMD5H345Enj6K12g7uXfhB4xJG1XMG+5v0n6FfQLuW5SYCROcCg3zOh5S520bDThAdslFahi+huWDeKDmfJfAyLdV/72prWbHX27ztzKo0FaEksbXJPSTjVVmcnmYLXWg7HdBp45zV6c9sJQzxXzicxmrUSy9Tz739Tk17icRYbJNAT0sIbY+KmPL5YIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUqGJ3anoGz2rjTRAenRFW/RLuBCaND3Ozl6/sD11sg=;
 b=P7J07cpyvWZjwWf4GN/68kWUuQhvsLVmMxxjWsV4D/NRM1Sz/BLci9fxOKmnYXyCQSODmQ7+GxMkudOayK9ZQrGuCpj43k/Qw8porVhloIOIhj6eM4duvUT1A8ccnWIBlPBNap3TTxUWIaOf2Ocog+UevkuTJDWCPzgPySZx1OKprgTKX1o23piftW4iG8q++Ud5lj7ahg87oVwIuEvRLN/jsQuF5+1UE3ASkq+GdNGtlQh3uRdG6XABiIeHRajXFQc7wRty2J9ILSu593VRvAfQwey1xpJ9XAmHnFherVo5uTdn86fnS4atRgiY4DmWskB6IgCHm4dcnfBC2CiG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUqGJ3anoGz2rjTRAenRFW/RLuBCaND3Ozl6/sD11sg=;
 b=eOAkD2Ev+CrRHRt/PlLg/knghDgdha4Tjv4JrI2hKzOLcNjha/drRuIlU2BxT87x6lKTaHj1KSB6AFAnwQt0zHLsRpKssUYoh8rnsMqKJHrFs3ugrUTa9QtNDnhbwdH8hh75V21NVaQgl0JyEMl7XrP/cIX/3tEZQPv0Tw7pIeJmXAbIVroTH1XjzcfQLESCCDmibL+5d94ly5aIUZHCZbxYkZO/HrUlVT2ezEdotLI9+en8+h9AkvgC0IBIUDSUOI1hTzwGKA2Bmclgj3P/W08tL1L8KWRhhF0j3hBS6GpE+np8OMhzFKa87a2x2H0LxXOASzpu0ZxbzafS77qdjQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYCPR01MB7268.jpnprd01.prod.outlook.com (2603:1096:400:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:38:03 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 00:38:03 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: mtmips: do not select PINCONF Kconfig symbol for MT7620
Date: Fri, 25 Jul 2025 08:37:42 +0800
Message-ID: <OSBPR01MB167018BE339065B656265691BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250725003742.15646-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYCPR01MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7a8a0a-ac3e-47dd-0f83-08ddcb1383c8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799012|8060799015|5062599005|19110799012|5072599009|40105399003|52005399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y7ZHcOjlluTEV3IBnPX9aPNbzz4HEh1pfCPkI8s6AVREUG1dDSMHhHVuGyaU?=
 =?us-ascii?Q?pPgmNSUOZxLJQjccGCaI9x9OH7+EK8EXFnoYj9d7czlOk39H2oUJaTuSRs0a?=
 =?us-ascii?Q?S2WEbv9sNXorT5T80Drke00ExvGQ+06HYD+r5bRwsYRWtRktsifUeZiVQTRv?=
 =?us-ascii?Q?C+S3gWMvW55iof7WKtaDVQyVfLuALRMVZO0L1i+111TyJzy2oy5midn/szap?=
 =?us-ascii?Q?UaURWzncsl+TV9DbOUyGkQCKhxjpSL8ND6MY1I89fTG86irD7umqbTM/WJ0Q?=
 =?us-ascii?Q?UQ7KpYh7A1gIjhRwKj9yl6w21VUAoFt9Qroy7vycfc0dK5p9qXC0QDANAabv?=
 =?us-ascii?Q?Pmh0c/tTq4cEk67OgJc29HkEu4xidSLE9GleIlISIGRceaQ34jZQWgumvC5g?=
 =?us-ascii?Q?OJsVqg5cuJGlXVR1Y/rdZ/GHZB9tngMwHzMmcd8wLpJYNIjwroN1cfnPg7+O?=
 =?us-ascii?Q?NIZkrKzYuwM/FFgj1qVXdJEGCB8GkrqrvLtapa0gt4MmfqBY8ct5tYNSvj8x?=
 =?us-ascii?Q?PiAX/LYGXoXWkSVfBPJj9jMJXjc1xjq82v5+aZPbHIl341Y8JAcS2PTOTHpX?=
 =?us-ascii?Q?ZbU0Ncoznxz+zrnUBntprsQFI6/vo8lj7nLaxgjA5ghjHjqV/Sr0yJh//9yJ?=
 =?us-ascii?Q?U4CVS2YRWCJ/RrH0L5WQatn94d8jK1f9Jr3IcXEJ41B0Muqeo2KrTcww/bM+?=
 =?us-ascii?Q?cZU1ZlYS4IajKHtsU/I+yopC6aSyQ5xyRm1gUkfzAb4cTKsKmOxh9iR/EknG?=
 =?us-ascii?Q?AFoARsrX3XB3McfDilW0o9LzKn0XKFzuKxdRbrbBIcKZqieFUlPElAU5rpkI?=
 =?us-ascii?Q?r0h1/13h0NfwdQveOjNnsQ1mn/3W+d/1bTQrufsf6lKSpWXp6QbPDfKronVN?=
 =?us-ascii?Q?8+/9MQrlpiA8cD+gDdAwcVupOsXsMiSrbGxBOG/z2U/+SWFfvpWvPacgbk8q?=
 =?us-ascii?Q?vjX/q78LIv5T+5XeEWFOxheYzrcpvIflsOE86AV3SgQvaahfiMrU8L8Py8HS?=
 =?us-ascii?Q?S5ge5pfzmER9Mw8IuJ1loumDg8bttxMH7KNm5flaz9GQK5/wOHrOgPik8S4R?=
 =?us-ascii?Q?vqZYW4xyqBI6UMxXJzp+5IWIv4j/bk963Hb9gzLhmKlHLQ9vlWZKWPQE0cDW?=
 =?us-ascii?Q?dOs2gHUgtuEtE3IhWtuo3645eViucUWszbisvWFmhXIPah3eS29bjB9lIhVV?=
 =?us-ascii?Q?WgDN2Adezhp7uUg1CDbdqvWb/OddjD1mdrDmzw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChwSpn3zGfz0kM6yaEtJxuG9uFnJSDjJEDc58Li2SbOUIKhS7XnNSFI4Aot+?=
 =?us-ascii?Q?BBZ3/6TqM/zKRIXy0vn9Pudil62tuETSsD9WRkLOxIltG7ZfMfwreLpJ51Sv?=
 =?us-ascii?Q?fxtjlzONCxWqfSF1pQwQoNJ41yNfFKTr/eJYhhx6mTTR/oX5YBQuBs58ZyPj?=
 =?us-ascii?Q?yHXIXav/xCpICaFJnL+t4OSJsbQ73bvxGj2wdzjqbC4dOqiRkHqtpjT4LRoK?=
 =?us-ascii?Q?lNovP//CFFhYKbfpAmI2ISHL8ucRwE4QiIyYV16KP00G0IC8vs+yzq24ZCl/?=
 =?us-ascii?Q?5O2wk1unk+SPwsKrkoKEgYwRX/JMMYPMTWKOTWWnph6Vpu8nfmlunpvN6S1G?=
 =?us-ascii?Q?N+pFdPhhLvyw0Msfo/3Gjvf5/RaumPLk1u0uBejbeliYjfOPRIBf3SL4SQk4?=
 =?us-ascii?Q?YVTC96P9OMUYz1+NcEJolLWHp195FtlCeKy/XOJxIRkPP6O+XjjZPF/dhUxo?=
 =?us-ascii?Q?HWun9+tGh3Zznzxej5fvbvSg3xJE1rgswUJnIG7zbMMwHtD1WUkGBgjuEyLO?=
 =?us-ascii?Q?2sXEqZYGM++9K80+w31qti9MqyAZlU17BKwaAt+CqypEkOICs70z5+84jIGK?=
 =?us-ascii?Q?OhRafl9dvU5xo2cO7gCiGkMfZq8lBqh+OyCTXWwW7rGpx8YsDnZOjuaPEjq0?=
 =?us-ascii?Q?4PeEeA2ieF/7JKb7oF2W3kZ3AEbCees0qHZ7EjRvlZFgd87AK+Xe0PvSoqWy?=
 =?us-ascii?Q?KYHiHmQNCsOocaBZcY4h0E2eSJDe/UbSQLvqjBIz50XL27uILGL+5/OTTkLU?=
 =?us-ascii?Q?865mCsHSBKOxmd3HwuyhuLlRU0vW4SO0nzoJI1wNE2t8nNRRyZRl/N28BUTi?=
 =?us-ascii?Q?uS/GuvNMKeydigeYKVuAGFH/J2/J8lnYsJd9VZGVmAd9A7020z2XEZQAT8v/?=
 =?us-ascii?Q?gQ4LskgJyKHBvWgJ6hGmYj+Pd18HRWZuAid52vvy5CTh0ibeiH3V7r4NWELl?=
 =?us-ascii?Q?NhSUdxLII3OCu6p/f7jNJwqAyXeJH55wQQv0/pHHGgq3/dXwOYylZk3KfOxl?=
 =?us-ascii?Q?KR5v8gsLp6WGMlINOL/LrcICQ+hEN9L7wNLB+q1jbJvViXvEZFc1hUJyTeUZ?=
 =?us-ascii?Q?gvCs326+Ci+VVbNSkS1EOtj+58BrSp6BKatAKQPtWZN2VKuzfnbE1/u/0CNT?=
 =?us-ascii?Q?8tl9AgJ71DNA9k+RXbCUT9BUoZdY4RWUX/o4tQm/6zfeQPy9P825YuXb1yPZ?=
 =?us-ascii?Q?dd1oDKBFG98+1kogzheEyiIZI/ANBEMCyO8Og4sPKhNUr7BwurIB1ENSm74N?=
 =?us-ascii?Q?gORN64n9ry2Rce67jvmt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7a8a0a-ac3e-47dd-0f83-08ddcb1383c8
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:38:03.7811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7268
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

Mediatek MT7620 u-boot does not have PINCONF implementation.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/Kconfig             | 1 -
 arch/mips/mach-mtmips/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a0317011de7..36612756294 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -75,7 +75,6 @@ config ARCH_MTMIPS
 	select DM_SERIAL
 	select PINCTRL
 	select PINMUX
-	select PINCONF
 	select RESET_MTMIPS
 	imply MTD
 	imply DM_SPI
diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 3fcd0b8465b..9c190cfc6ff 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -84,6 +84,7 @@ config SOC_MT7621
 	select SYS_CACHE_SHIFT_5
 	select SYS_MIPS_CACHE_INIT_RAM_LOAD
 	select PINCTRL_MT7621
+	select PINCONF
 	select MTK_SERIAL
 	select REGMAP
 	select SYSCON
@@ -101,6 +102,7 @@ config SOC_MT7628
 	select MIPS_SRAM_INIT
 	select SYS_MIPS_CACHE_INIT_RAM_LOAD
 	select PINCTRL_MT7628
+	select PINCONF
 	select MTK_SERIAL
 	select SYSRESET
 	select SYSRESET_RESETCTL
-- 
2.50.0

