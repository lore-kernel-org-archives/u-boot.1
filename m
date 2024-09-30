Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F7ACE8377
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BED389055;
	Mon, 30 Sep 2024 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A25088FAB; Mon, 30 Sep 2024 18:59:23 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244B288D08
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7QS7wRaRleGgYCwdfrP51Rg3DKxgmFX2YImd4C5yPNVpvSrisZ+H8IgfTk7mnBPjTvYiOMSyU4uVYF4ulS+qEF2Pfx7mRmnARfeS+RT0rT/5OYtDzk/YCxkQsZq1lSX3vg+n4C2f5n5ZCfJNX22lwPpf06HW3KsLOqB6HqKe3uQbCAMRloFRlKCjirVvY9PEelmPzydnMAuuW9149bqbQ3kjy272zP8lqcO8Fl5R8eoRDTcQ093UuRcmrNczi19ciRkL1KkznKdT94P+j9pwReu3TuFgH+zBMRbpS8eoORhSgpRjkvZ5YIgDMfkFusT8rsja5JyY2gvfqQOOkr+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FedG6tevqtiIJxfjPO8dMUbuA8NNCFPKsXxWagxZqVo=;
 b=fUsmS+wEiZIQcvYI88d4qtBdR8C5sazWPn+tU2gvF/4ua7rQAr29FxU701Q31Y02y9KPlDq6KqEUMobGS1cD8VDs220Pbtc07rNG4oNAYEzCtOBWFaSWGaOEbJ1hs2YCl5XWVysTMoCCdlEET4+g+5O8SazUifN40MVP2i1DH9fAK/fp58NodJ3MfB3kU+LeqytJ9bS9THP50pxaSnmmaziMI/EFgU37NzFvpFW4vuMkCqi8/VOQl7weq1dLB18JzLTqsHNfPCh2gWaVrL4Zsl+aOXmNt/H0b8xOyzAFJ3IEGhsLAyWepls/OHRhSyr/LOQfl+cUy4kqeuWc3jXcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 02/12] dts: starfive: Switch to using upstream DT
Date: Mon, 30 Sep 2024 23:59:09 +0800
Message-ID: <20240930155919.111738-3-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20c646d5-9732-4aec-1c9c-08dce168de38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: lwkN3e+LAfopKWl3zZ14ei4QozMzFd2jNbBEcBNLzSyQpFJhDtBbfjRnHeZfWcxepT+AhniWR0/Wo/+3znXNQqFSq/OfPQQK5Vlo+F8GKyDcxqEBvRGOEpmbG3O1LV2y7ESM6hs/ddnH0EnEd0pGHB/ZMrCD7kNemeCOqtaFW6/wNIINItYNpJNlXaHwrPB3BS9YQPohhgwcP2wrAHnzwvV4CBnTzwntqrM4uc3HAWid2yanvZJ2gioSswJLHPKEOmzvpo9WLf4hhZGbi3NqEnzqNCKMAwr8ywjFhrr147Dzra7tM6aIAObIjj3poZXoaGwCi3C6/s8GH+Qv8KVxgiYAQ3xViIEL+tGzdQ9it6mUFo+bPg2KslvTGbcgPohHs5FjeAdOw89NITrNn33LQQAlkEhyowDVzkFj8GwUu5JhUJe+DBtQ8F7cj9lred2jFHsGxU1hiO+8NLR7csIBe8ZjD1Zu8xQneEzXutUQfRFOjtVhH8nsjtNYyck7RPfKblPsuLkT2y8R9+P/QSr16u5jjqXgbuFFCk1ge/HKAcFHgHbM73JtA/XPCONjkO4OUhsD6fzpBe3qnLC0XLYpuySqu2I5Ta+dbbnk/qw2UpQInvbOPkwfT2+3ym9yLjxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Z6zMWfia05RrpOR4F8l96AsKP4yNTSaZo7sdWbJvU4uG099Gcps9HseTMHs?=
 =?us-ascii?Q?Vvyvg9yoIa3jNNPuovnXU03XcnBXXNYRmPJH58f0r2OKTWC1uBOpVvravrvA?=
 =?us-ascii?Q?R55beeQLBmgPzV6kaoizuFWJq8tJYORt73jD3Hsz8J+m9rw6Wunw00Q3b3go?=
 =?us-ascii?Q?1jzuhJgWFmrX726benM1vpdOyjC4IYi9CxVe09H9VxSh+/rxqn1+CNgTDBKJ?=
 =?us-ascii?Q?JaqgORqwgVo131wnvjwIfGOsGY1TtsejGffps6qlnYJ0t0o1Vdqn0+j+S//F?=
 =?us-ascii?Q?oTlEtEE02KrZF2AfWGEHp7D6QA64EKl+N0qzzpkcqY979kdX0MTfSL65pJJ4?=
 =?us-ascii?Q?JwLcDpGcyZLGOYs4vBkvZET0aUUBqVD0GjcaRydjHIjNTI2o5S3ESqJlWEZ+?=
 =?us-ascii?Q?372WWx72WDl6jT6O7MNwF3baUyMiCqOeRmwH3AX+KntQKpVjmDoF2p/edT3Z?=
 =?us-ascii?Q?mujpRA1yY+x0YqDPATUf4miFixeNP6cGgwDuKsQKV+3DAs55zrx/2c4K1FwR?=
 =?us-ascii?Q?Ejne3XAJEuM1+hUVTt6l5MIsGnMuCM//gRISXDS3LDz3GbefVe8+Ob4OoOxd?=
 =?us-ascii?Q?m6BmcyndKCrxiaGebVOuVgZOCFnidVU7KJxC8cYRxUByvviU+eA0EF7gpaNA?=
 =?us-ascii?Q?TIShDu0D6KO50OvSdlCLbwGlANQ8tqrVD+HizyL1JcxIqa82m8HXv2vmbSCR?=
 =?us-ascii?Q?VEfV549ScqZNYI1Y8Z7HmzKSmFlR6u5eYB3XNl++82lysSKI0KMgR6LkS+K7?=
 =?us-ascii?Q?JjDzXEJDclk2UYRmXhh2ywYa8FcO1WeHM9nFZJ2XIN3+eeT7JAJkjLyPIg1A?=
 =?us-ascii?Q?cNiDdelf9DmGOqrbkZ1ByssZIFOKSCcBO3aruAVckpStjrQ94uSU3/f1P3z9?=
 =?us-ascii?Q?/bMEEqKcLRmdIOa5pnk4ODX7PgeRJ5CS7o1Zsqe8ZWnVMKmAckMPwB8zhSsO?=
 =?us-ascii?Q?cQyykCTJ2oRjQNjfYDYKiEKyUUDnPb3L+3SeOChr56L3gGUj9AMEJRf4Q/jQ?=
 =?us-ascii?Q?H4FBDqvnyxjYz2HkM8hvSLkG2xXajYZlNsrFaOH7Jwe8E03gZzEp3hAPyKxL?=
 =?us-ascii?Q?rL0SWuaGZtp7WSKhyZ9RcCrROcwKqk3wEH/2o4DO/JBucTZPFiQGQWViX7p/?=
 =?us-ascii?Q?xvsr7zve061dXqjZZDTzxyz57Xy6G002ru50Us/p6hdshVAFbCYqkrk+Mt0c?=
 =?us-ascii?Q?/0xhMLljyMpWdUt1dESLuoP0/zw2BH1CGAp6qkl6O/QB/jHmgo0akDI1AvAd?=
 =?us-ascii?Q?Tu6zNtznjqfcosbUxr1bwdnsHxAFpsRU7/uQrhWZwToTndNJSbD0Ip+2iF/a?=
 =?us-ascii?Q?naykMZvLLZhvAUnbbWWKevPyQ3BuYXJTJ0rLY1eHNgHlLfBmzyGnc32y7HFv?=
 =?us-ascii?Q?EKD0VUtx6W6jayh3nWyTvCEGBmxS1l6W8M2bEqsxDbIylN7y5F3ZL3+n0nEY?=
 =?us-ascii?Q?Gw8Bd8LWZjeFEOqlobUhnJ4PGGgFzh6OookeX2n2WtS2ngqE1BA3+/LZFrRq?=
 =?us-ascii?Q?LRDLohcJMcMAkKzMO9rE4aKJy3gB8aL4FnFuioM9JqFEkVZX5wTTImvJwJwp?=
 =?us-ascii?Q?8afsvJM0PHqGWFoNZzAFuMWg47Dpv0Q6vSPDGyt7gc5jP4lmYienA0QbVqfL?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c646d5-9732-4aec-1c9c-08dce168de38
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:30.1764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2OKwu2tN40JpsQU9WL24T7iD6k5SkFPpElyAucMfFNKabItf/aw1AtFsSh88e9QK7q12AKIDwpMNr4M9p8aqtR2R4hKrCR/hLdH20S/lhw=
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

Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
the v1.3b device tree as the default device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
 ...boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
 configs/starfive_visionfive2_defconfig                          | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index e5549a01b8..9904a60ddd 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -19,6 +19,7 @@ config STARFIVE_JH7110
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
+	imply OF_UPSTREAM
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SIFIVE_CACHE
 	imply SIFIVE_CCACHE
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 174ac24dc7..0068ea4d93 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
+CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.43.2

