Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E76CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3F0802C1;
	Tue, 19 Aug 2025 06:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lqsRba/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B44F80422; Tue, 19 Aug 2025 06:24:14 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF6280050
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXDeLwtEm2GlJuMKmoB9/4sheH/fmICwnI2dQeqaWeugRj1q9cvraC3lvnSIJqqNLHM6Wv1Ag1uHG3O3gbWQcBe/XwZPWEOdrXHGbwHbEz0qEamtxEZrLfRtx8MgGoi8d5RSqkHN+HZjikJiXpKkehbUVICdKovN4mp9wAYUSUGhJESTWJbLmzVEO87N32eP0N0sgMIqcMz4LoXPcybYJzjp7P0oSPYJ9d0jaLHEFsvWcSAm/Z879YWnT5ix4s3NggLrgfFBuU3lSLYIDlCo4rTGdO3j8SspiwMb+kOtIP3UVpz6LstsM2BD9ZxLsTD7yHWTMpHHqgYHqOiz9WOWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG3iCXjcHEyD0sbrA4pvLL1U8HnY1KfB9IRPVzWKSzA=;
 b=lx4ITwW+ynZJcZ+agqz1ilpDKXDFHe1PGtGaShNOdCTuXxXkvwiD/W4JbRH68veqvkOSowkdBhCblIz1p2LbPDwzvO2Njcz+SWVC2Zk3oU8hkFiB3jcJ3q60OSAISXvH3YppRwhQh5Q1TcUaSwuRWfC40nBLjLYCjLyFOhIeLsOJZSmV81QOowfiIhWfSJ5mcE1rdOrB2wiWpxgtLamEBk2hJ2FBbklugv+5Qc49vFqiv3y2k13xgONgnHsmQYA1hQQ/jxfGQkRuDSqdJybJGw2xOqxq1XHTZI5N20qQFbj3+DnJM9LmwKV0G4Y3SlYU5DqtC0X+1kN7U9LrQss6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG3iCXjcHEyD0sbrA4pvLL1U8HnY1KfB9IRPVzWKSzA=;
 b=lqsRba/TrsmGyPycSkar/SSgXReNcPOvyj8syj+tlCpm0T5UxzK6LVvGFkUTmwuDOKHZDCLRBTAivnXxVq64V5zxn3v+8aXbqK2vVXY+JjT/qxxI/ksYUCZ/0O0tCIO4K36VdkPwVlnBcENzAJaJTgRDxzo4Ln26ykv2t1QQ8HpKTzvgwusin7BrNIfOJYFC1171m4R8gG6IYX06p+dVXY1hk98pBu/1F5n95J9rkV3Qcqde5QQoHLhfSWMK+mODSr56O2h8RhDXSkQACPDnDikdMEOvHZirSxUOE1/puCggnGVWAnqpH8AcToMEpDmfMLcUVodSwL9vmJOLJnKLIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 19 Aug
 2025 04:24:09 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:24:09 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] configs: socfpga: Add CRC32 support
Date: Mon, 18 Aug 2025 21:24:04 -0700
Message-Id: <20250819042404.26990-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH2PR03MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5b14be-8731-419c-6872-08ddded83de8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uATludGLOzae9koa3+uICxyJDj7Q1q/my7Cw8sm5c9Utf+7Fjk7c01wO/dE+?=
 =?us-ascii?Q?p1qfem+Qrif+n31R1p6MVNGqh1Vcg+a9rBMMz6kxYd4fTQZYwvwEtlQtHWO3?=
 =?us-ascii?Q?rSKvkCzc+i3ewqjsqO273o2LW8fzGdBbgl3L0nJqtYvOhuEl0KRIsjzPhY7N?=
 =?us-ascii?Q?M/tBLAoZvX3vH4vRKfCzwJj4HbybiAFAwFOz1P4S8bHKfoqTJpWEWIJw1B0s?=
 =?us-ascii?Q?S2bBUzGgiPFgUm3HrCXn4Q5nQOMEozzVOEfUqixK1o4u1JFXDKPNPLLso+/C?=
 =?us-ascii?Q?xd3Miza+uMkf3s0zIZiTtB44eq27df1UTUWahXtZbCpgO/6jCUwA3DnX9Pya?=
 =?us-ascii?Q?eSsfuzCOdSjRMWgIbwan04yIS1I04ToIUwrbLsu1GaPK81+6M6q78O4+6gca?=
 =?us-ascii?Q?KyHZadWGUmAoRIFJjUvvaa3hFCm8KH4moI26unbqMGzIjIS7MnpY/TD9EaFt?=
 =?us-ascii?Q?27tu7TTxhI9hIEAutA1+59a4VRZBU9DelCAYQaRFnNDDji14axkNmsWJOFaa?=
 =?us-ascii?Q?AM2G6UPbkbuDKiSPpjjlegfRnUvaVtbWqGPRyKPexiTm0Ubt7LnC25AooV08?=
 =?us-ascii?Q?gIhedDAvqFZYpWYHoKCaxFAYh82E6YmhZTR+diDC9B/0Ycrb+bUtNeyGSshg?=
 =?us-ascii?Q?1mJY4ikQq3m/+kK5xeFjWdVlrrmQd/r9qrOAH2HWkCLTD0Slfk9s8FWY8nmW?=
 =?us-ascii?Q?mfsJO39tBkm+WKZz72tGbFuNXm4F0iFREWre+2Cf1PCQsSfv7BIhS8XxHQDa?=
 =?us-ascii?Q?pRBAgeT+n3fBv2sHHoCLcl5GXCMH32hyp+8j581Q2Lc7eJL3Du/Xl4SV33DJ?=
 =?us-ascii?Q?N3qSFuWiPSDP4rjuyWvjbn3JGOvhBcAazpE93HjxZ96SX8zBGGvfzdHn7IH7?=
 =?us-ascii?Q?qE4YNAAJv08SJawTlV5QOtWyp4lfBRqn/jEL2Ahv+eGxzswRmcN7RsdO7Lgv?=
 =?us-ascii?Q?XhSNgNZnBwM/+rGaraCwRZXfsB5DkSCmT8BW0PtC7EFkgxzsJmgNdqx5SJKu?=
 =?us-ascii?Q?s4HsxV0lvLEyCOfh1xruFZR+kqPBq+jPo4KEQgDC6ZqKo9Ogn5dSDaOq2rkp?=
 =?us-ascii?Q?f+5w8ONmoHsxZ1FXjD/c2i+vD8EVd9Aa7Pkqb/hkqFsYzXKT8HiTTAFrA4uF?=
 =?us-ascii?Q?76JtE1YzoI7rOZJ+p+r36QdiMLhcqf7w3nQtm58xlY8fSNPwWX/k43/yvJmZ?=
 =?us-ascii?Q?w1e46logPTYHAz+AG5irgou4SSSVY87pHCAk8N8MV1sslPhey02EbRFvPqBC?=
 =?us-ascii?Q?FRqgnNb3HLFD2/KEu9NZa0O5TbFM03p9Jy+ffYIWiEHIKtZo2ypGZg6hambw?=
 =?us-ascii?Q?k1v1EdaF1NdaOS9Fl0jMR+pAl+BuWCNR/xYPvqQgPLtshXYxano/Tm0I5b/n?=
 =?us-ascii?Q?aHCI5NnWsxZ5Gu3NvNWULuOvsCzZQ2FUjCKQjDg8q7561xdXiaMvelXbcc1y?=
 =?us-ascii?Q?c09AplmG+jQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L4PHPetEIzM2ex9yySz0EcIaFO3+BOeq/LkKBoPbDRP7uC7xCx8VnIXek0gB?=
 =?us-ascii?Q?nBXrDrYhma64GMLJzsuk4GfP0+bphvp4XqYpHC84uuoEfepmSzqRfXbDsTAx?=
 =?us-ascii?Q?1Ox2r++xwMrxYGj01ZQup/k8m40FsMuUAzbXv+EK8DjCNlkdyhjkDsT9EwAM?=
 =?us-ascii?Q?23xYps8S0UQDO7nGKWhL8Qpm4lOC5vqbb+W+GK2JgfjruIXspS0dIOUiO7/E?=
 =?us-ascii?Q?C7rWKzyno2VBLyAo2m9cQP4SDdhsKefOjP0vMU6bzlUg22vKXOLhYRHpSvqA?=
 =?us-ascii?Q?rOgN6sjXFI3fZfkD3wHMYJIIhRpZUGz8kFrhwqlS2d2AzfsbJFAQZCieLfZb?=
 =?us-ascii?Q?lDyhLNTE7pmo8DTnZp6dgaG/Dal8joVNddkhY9PMAU0NGdC3lIwE8KXQccuA?=
 =?us-ascii?Q?4cmi1NvtR6MV+wMzGvMBLko2w9wyAslCe/WTYQQEo23i/b+t6Jr0uOD7I//k?=
 =?us-ascii?Q?cgA/lQUlsAhnFOk2XBQwmo7y1MH9fCqDfNFfQLUPNELUpdI6pIinyl9orGuD?=
 =?us-ascii?Q?NwtjpGQlPBsrmMfTcTg/zi44nY0OC2ziYs8x+pVC4k1DGflyjgtjynUqZ7Zv?=
 =?us-ascii?Q?Yu20vz6f1ThSu6sJq5+XE/3H4yH+amhxCc6hS2DlbkzOPbReUKQ8UPJormy9?=
 =?us-ascii?Q?uHuWcU1JenQXtOoi9OFRlZRq3ISLQaSBmJ4xCmKpvzg/TKsEzVnXRardyP8b?=
 =?us-ascii?Q?UDkMz3eW1AeN5ys0X2IzoHyJ61NwlTXtk9D6TGGFW9DhoGGu8eJESTj1jP/o?=
 =?us-ascii?Q?nY/MUL7fkmR8EcFvrWnclQ0UICUcidkEPoB65ThRkC0bRIrWonOs6oDtwwXQ?=
 =?us-ascii?Q?8tHnXjB8tnzuaC67l4P5BMeu/0Gboc0bSmAm98gHRRI+huUgRJJJ1HM8gHf2?=
 =?us-ascii?Q?rSduklImdh1Y3sOU5G+FoKzqtThrYHbnWU9UTYmibXy11k2W+xFY+QDDQxI5?=
 =?us-ascii?Q?oWI4AvSyzOUS3KhZt912iZADXTFVVOfGtKcFB2KWTnmg8XrI0iBOjUqJmQcN?=
 =?us-ascii?Q?uYitf1KRi2ZvyDsLT4sXEf7slGMie2SSzmtrEQmiToQ1Ipa1o/BXCo0H9ED8?=
 =?us-ascii?Q?GzOz1RS0FH4faoCZwmeBHq6hlUH+O61zUow5mgcBW0lR1/oj0clQujwa7ly2?=
 =?us-ascii?Q?F55onxnC2QG2QZnRhnaK+W6eEZ3jMXO08O30YGJOUfIg4XXt0fA2d9QEyx5y?=
 =?us-ascii?Q?/KJkT1K9axOmVrse2WjDVfvnYwnUnwGmLTEuNEGk4s//OOkA4T0Aw/o/0P2O?=
 =?us-ascii?Q?2eMVV2AjPRboP7I5WF5k4AT78EOsStSArGlX3VS1UvaPw2HfWtsnHd/l4VH3?=
 =?us-ascii?Q?E/Lx5TLgp+s+vLJK36Cpc5/oHPjbpSLm6meZAPzVpur/MZ8QmUMG0wJFO/rv?=
 =?us-ascii?Q?hJH208nfMZ1mD5sskB9BniZicmgwLASQfoJmqlWDbRQdVQ9Jgh38+uJLPnZV?=
 =?us-ascii?Q?p4O+60lrO8ObeLnuMRQ9nruy6iX8QugxnS7KPk5zNF0tcimLH2DMZqRekNCB?=
 =?us-ascii?Q?FgiLTUW1nZHSRv6+jNCRPWVdK3bYgFrFaVRiCwwJBsPNc2v+7Q2HusPpu0Q7?=
 =?us-ascii?Q?YrfrYWtQr+ZLB0oiiwRpLXbcUA+rWUPEDfgmG10ppNKOreEUsb/PW5BKxE0e?=
 =?us-ascii?Q?A6jfccd6b1XBLH5AnsIwUDU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5b14be-8731-419c-6872-08ddded83de8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:24:09.3932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JWJeerTfsHFXK1b44Cuhdh3zL4Eg6hKr0NoeNkSWCKxGkV8tnxqFk7qZw2HgGDbM60g37u4zz5FyqyR/W3vIg1xvM5cbdAkiaLz19pr7XfBbneyN5Rl+J/EBFf7Onzw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
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

CRC32 support for SoC64 devices is added.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex_defconfig    | 1 +
 configs/socfpga_n5x_defconfig       | 1 +
 configs/socfpga_stratix10_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index 0b6194c1f27..638f8773397 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -39,6 +39,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+CONFIG_SPL_CRC32=y
 CONFIG_SPL_CACHE=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 879556614f6..d501fcddf3d 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
 CONFIG_SPL_CACHE=y
+CONFIG_SPL_CRC32=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3c00000
 CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 90134d8f3f3..fe191d09714 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
+CONFIG_SPL_CRC32=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
 CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-- 
2.35.3

