Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB5CC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA09880AE;
	Wed, 27 Mar 2024 13:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="DOhstqK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F5F880DB; Wed, 27 Mar 2024 13:12:06 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC33880E0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR/e3v6QALtOE0xdV88HupmYJf6oFPZUJ3wVuKSDUNoQi9uU7sEHC9olLZjjYCpKWsDlMYP5rXesw+3hfwvGJ5vSGQRI7dMlsqZ4FP2XLN7gNehEQSJJsPXysVFr6WCOW3Np4vpgtn7vpYVRvw5OTEXfuacWV7KbwJkAAonLyobQYAXB2pZ61FjG5FDJ+QiN8c+dyTUgruRDi0YQTSGnR2YFO5cjFH0xQbNbmv14bJUSqeomdgHUuWDiGy3O4AW0EdkP6S4ctziJhQakwBhPJ+FZ/rnTKXiSJfqP6In9Ziz9hynJnESbDVZRJQhk6yvV5n7Vy+Mrcg2hzVkjVHCiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNzsLDH3SmvQC+SF4VzfI/ix0w0htYgtiPGbWwfmihc=;
 b=RLj4pQFAE4o7YfApbjGLBFl2sRvt5S2Watrfrxbs79VCdAVfOZ2y7G1jCFgoEURZv2q+FkXxAkzdgkpcDDuRHC0SRELler+CVIF2otd86gdudwkFoXkm3FMFX4yEeXHCl3hpQeIpwG8uGLmPFeKwucWpxo65TJVQfGwc618wWoJ4eIsOdJA1CLJGqVRbbqs4RYDcEyfQx2w1SgjIhVB+xMk19ZZ9d4QZS8Tig4raJdcyuYH3l29ZXaP89PAPWG00vTndf8nxaGuH0EqAiGrfnbi5d/1/St2ApFdMqvp8Yo+JlvpMMn7lnw7xHgFJPbb9FSiFKQ6WvbbCHrLTpTPLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNzsLDH3SmvQC+SF4VzfI/ix0w0htYgtiPGbWwfmihc=;
 b=DOhstqK7XbQ4A+37VePBqLXjaIFxJav79AixC6YWRKrxBeUeh+C/CGw52dEZSbtzP0n/9LXD5tfod6D19YLZMGOweVeqXlJqyCF0OqM0hIVWv/W4M7wXdbW4SkHYRbNZzUgwJz8XyHOw5qb7txOASofqQE7YzZ3/tJ98qsq9VsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAXPR08MB6528.eurprd08.prod.outlook.com (2603:10a6:102:15a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 12:12:02 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 12:12:01 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v3 2/2] arm64: zynq(mp): Rename spl_board_init() to
 spl_soc_init()
Date: Wed, 27 Mar 2024 13:11:53 +0100
Message-Id: <20240327121153.2455126-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAXPR08MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: f9932db0-192d-4ab3-c7ef-08dc4e571bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9SbkSFdU73QbVIG2rKY2WPC5erAt16+Ao+UNxwwbbKIUEal/ugIF9kuinrlINho06E3BBJNRazZdsx84XFO9D6qT4o8RNpFE3lwB2InxRMCdW3NNp0rYF/UdXH2ETPvaczb8D7+fKTBKW4sNiVztoH2YH6ygXMH7nlqMvo6BXYWoLLe0io6DqDN4IJ4fV7vyk239Q/uLAWrNuL4oASrbLXwuuRlz4bgYoJJDkg8Cr1yrtjiukvuC/v13d5+y9Uayks1bavBkrguB/bh5MuTGTvTKSTcuFL3qg0tyWoR8L/oRDO/lv/a/MRqJUZw6vUsAreFSyDZy8BaeNPNSJzRPyhgTQCr/+R+4AhMttQTNWUpTt0UOaM6DySbCFHnCVYKfFpceiUXPGoGVbHev8AhTW7AgophjqyeL/vv3GjSATQd52FLet/YkdJD7sgzZpoyrkqOJ+YWBKIrxRphU0rDzCuzsFqFTy0/z0Ez911ymDmHtYnKWIzPYaop7nNqo2h1A6U1RZv1Ly+P3CjZG2hMsGjNe5J6yqvr6RV1C4PgtPkFsoGqA9IpCx8NQ7WRT2ofLeJntrzUSKF3HQSZzqDPQWBnUBliRkudZOcwxwDJw55DzRswwRSqcg7uWpl38qAoIwgfVw55nz76GdI9zxdQFn+mIXPE0QK24VcGltMDLJfdFTN5XCoo1juf8RCG0+95aS2p03ECr//juOj2y3A3Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(52116005)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K98na8nfLEqZGlvqaNQU4TK52NKAuIMSby+ULzGsgUK5ijW5PVYVJyGcd3/3?=
 =?us-ascii?Q?1C4cwRX7wV47OdJm3hPslEoGZzj3IBcd7OWeGJh41NhzdF2iZEP9+Uv5hQ1F?=
 =?us-ascii?Q?Dwcaw76BNZ4dOYpZA4GYKzHtGiDdGCwXQOGqqNeUhNsBzmiAhZXxkKTQ9ziW?=
 =?us-ascii?Q?sSYFbIKjcl4p09YjzpcsiKdvaZ47qLHyw8RSezihUsg7CXS55+BzzfdhkQ/M?=
 =?us-ascii?Q?8F5h9t9EOW5B/P1cASwO9ojyRZec9O1JDBBbukTQlo9uyF0KVqf2QY081GKB?=
 =?us-ascii?Q?6NZyKVrA/4YgAwlAXw9RQXdiFO0aCzsD670dlEaDdZxZOSCD72K3hCMoQxQe?=
 =?us-ascii?Q?OCnQrdme8VljMonbj1RS6k44B/wTOgE1zJdVLxyvduqfnjYBrVg5zjZCv8WG?=
 =?us-ascii?Q?3PnrjFGPfMrFjMaEytiJmMVkAo2zXBp3N4gEmJ8wVol8p8dNvvCzNzwn6ERU?=
 =?us-ascii?Q?iJ6ZbaQ3uealZt1xdROy7JDH5GTcFriZUNwIVcspkCfbrIsrwKj+o9GJ2atX?=
 =?us-ascii?Q?Co8JCXXUqrqGX624Igcqaqk8fqhoEZn9qPYEJi++5Me7BWKlyPlp6j6/DKSE?=
 =?us-ascii?Q?b2tcsR7Dd1SvRrdw+6/4fca1QLnOYY1+x7xRuDxf0HAvuYMNXE1PnA6/+Zdf?=
 =?us-ascii?Q?PCWqB7asCz/e8z0fr236A51pt3K5Bu5Ljef0hW36qvalX6MKhVsmD+HGjKkF?=
 =?us-ascii?Q?8v/dr1Qg4Ah/zDEBpbyvuE18x0U6+D1+YQmCRtrqdP8+mEh/sHSx210y7y+7?=
 =?us-ascii?Q?HJMflx+0qFoUrygKTvPfoGZmzFRs8hndi6w9Jjy2H8b2w6DyxVT3WUfDbH3T?=
 =?us-ascii?Q?n/TMBFrX7uQY5MDAFUOOkv/2j1VTyqBuro5+EI18+8QazJq54/L5yoPg0xsC?=
 =?us-ascii?Q?7Linz354it4Lt5JNoRxyx5F6M924htPF/eVNpJRwjGmgEHs6zdkk2U964R/P?=
 =?us-ascii?Q?vM5Yti4Tkwu1CncuDcNfXf8HjKZ4oBiuMyVi2T0vvVo8DpFTFTQAzsFVEUXC?=
 =?us-ascii?Q?PAnK5Ms/SstBuGlkqsLy4u1sBfWardyKbBd2g5N9+VqH36WNGkSOhZ8sAkDL?=
 =?us-ascii?Q?v02NTRoM+SfO8bT5on5vyUgu3utgKAxdTw69rNcJfigMDYj2S6WwymfENULs?=
 =?us-ascii?Q?gbmW5JPKGgJPMPUPZFJAvmXwlB0hQtAc8/jygS6D8niLqQZaTdzJfrW0Y5H5?=
 =?us-ascii?Q?o1CrH1c0YDl3AAWOqG6VlMcArBE2IrBUIcxYUoYRvTBaNHge5CJ9QNfjkBf8?=
 =?us-ascii?Q?cc8nCfNu8sGIRPSDABqWSgM95Zzo3o0bIY/T81dxdD9YBhVVgeiMI2IbPJ4R?=
 =?us-ascii?Q?uA7LhTgAEbN4nPhBgBPLiZ4AUzESl9donRLKtHB5iZU19HAtNL+CpmLtGAQM?=
 =?us-ascii?Q?M0GSkKD0y4ACeVafEhcjGXiPTm4s1EsnlTWTsFZLHZ+nyQsP97u8ZjvrE+KK?=
 =?us-ascii?Q?idDTqOXXW1NCCh8FNfBpRB3PvUXmj0taW3tuNmSmpHNMHy0At27RnbQfdVFi?=
 =?us-ascii?Q?YoCEobitn144pMRLHSqFpSX3doF/iR0YmAO8P9Fqm6/6Axuh+pB/2CPZjGJq?=
 =?us-ascii?Q?1y7yDB3M6BOxwoIMEkrngugsTksLBw7vohYk3G1/MECPkiybRf0gJSxoFjf1?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9932db0-192d-4ab3-c7ef-08dc4e571bdc
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 12:12:01.7734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIfPVKo06p8tDh4wY32U8+DRVAZc3Ta8CKXQ2CW7YHCKqKwaz0ySSk8s8u35iNev2ih3KNzZkoEnJPkrTtxn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6528
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_board_init() to spl_soc_init(). SoC specific
implementation should be separated from board specific implementation
in order to be extended by board developers.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
 - Rephrase Kconfig description and correct minor typo

Changes in v2:
 - Change spl_arch_init() to spl_soc_init()

 arch/arm/Kconfig           | 4 ++--
 arch/arm/mach-zynq/spl.c   | 4 ++--
 arch/arm/mach-zynqmp/spl.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42..db56db9414 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1275,7 +1275,7 @@ config ARCH_ZYNQ
 	select OF_CONTROL
 	select MTD
 	select SPI
-	select SPL_BOARD_INIT if SPL
+	select SPL_SOC_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPL
@@ -1318,7 +1318,7 @@ config ARCH_ZYNQMP
 	imply FIRMWARE
 	select GICV2
 	select OF_CONTROL
-	select SPL_BOARD_INIT if SPL
+	select SPL_SOC_INIT if SPL
 	select SPL_CLK if SPL
 	select SPL_DM if SPL
 	select SPL_DM_SPI if SPI && SPL_DM
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index fea1c9b12a..112b44e2e1 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -32,8 +32,8 @@ void board_init_f(ulong dummy)
 	arch_cpu_init();
 }
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_SOC_INIT
+void spl_soc_init(void)
 {
 	preloader_console_init();
 #if defined(CONFIG_ARCH_EARLY_INIT_R) && defined(CONFIG_SPL_FPGA)
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index a0f35f36fa..71f9932525 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -56,8 +56,8 @@ static void ps_mode_reset(ulong mode)
 # define MODE_RESET	PS_MODE1
 #endif
 
-#ifdef CONFIG_SPL_BOARD_INIT
-void spl_board_init(void)
+#ifdef CONFIG_SPL_SOC_INIT
+void spl_soc_init(void)
 {
 	preloader_console_init();
 	ps_mode_reset(MODE_RESET);
-- 
2.30.2

