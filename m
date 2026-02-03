Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE58E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0D38410C;
	Tue,  3 Feb 2026 14:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rKox0Qxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E2B83FF9; Tue,  3 Feb 2026 08:48:47 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB4883FF5
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3obN1t2zWD1m+Y9vyncDPz839trrg1/MT2OIC0BBpIv/P6P7dCOGdueoICsv6UCu8ZRk7mX+bkhU2VxG02/49+J+gTFnLZsTiQHyOHLMBCMs7esxKN9nX0riGhYZJCYgZ7XIj0GCg6M9z/xCJucQRKFg8Wk1dakf6sTduUBK8+WntCWuHxuldauGnVrTUXLAgpt2PGqcurFmvMV9uX2Yv/SsPFGFHtkwD+HSFGWd/y8122R5Ha1hLVhYZdLX6UDxWjiVDwk5sBP1+bkCqht14RpvPfzTasr22ifOx8/ryJEbZeVZPwFEjAr09Nh9V6/ffFYc7sl5RgQa3WePhCX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbqjddlUq7nVDpj8D2MYNjq72Ub3Bfdp2sCZUqhNYuo=;
 b=d8KyewqioYuu9AsqmWCd61KH41prm2etvtvoeNo7bIAWPsf930k56+D//mcFkDzel+qmHAOEhMqklq5VHzVC8wYjBIvEwUqNZVkxVG/2dIepib851do+87hkHA8nM5fv0NoaG1oBu1xIRDnVOR4Er5qlL0WwZGn3/bcsmxtEHu7WV3BdbSEvFtlDYP3UppRRC08ASeO2vffz89hdOCbU/E62qxbWkbzgIuf5fF8S7Q+CQ6YZkqudzB3WsgKoI06mR8qy7haYdSaiFHczrGOAkmH5ebluxKM2yqVKBva9WII3voWUvSMa71vbcjT1POeZZk9zjaFw/SBQ/zwZP7S7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbqjddlUq7nVDpj8D2MYNjq72Ub3Bfdp2sCZUqhNYuo=;
 b=rKox0QxqUJH7Xil9576ajVzLokbNCXUfon9HAUvpSGNJOz5umFhN0qqJhep71xWXDvjcUNNTbzVCMpAdPvKlNRvE0G7oGm+rlrWJ8D9upLpra8Wh7xjc8uYbEsBCgFW9dsOJuQFrUvDNcU5zbLi+s9GMz5RK9bANSOykARwrIwPqo9qixhzXE4tm2PqhMYd5VtkcB4wUct2IjZkrVqXsAxdAXbBQ8zQxeso3WkxvnU2wcTfr9BXqgEstTJKQHYHoEgkgRIvAvj7YWNVXVVM8OBnLtPb3+vNPFrZQ9QhqCTFtLmdvq21RX5lj1oI35rDqBUWAkYAwy0Z9CVNfsQe3IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DSWPR03MB989105.namprd03.prod.outlook.com (2603:10b6:8:35e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:48:42 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:48:42 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
Date: Tue,  3 Feb 2026 15:47:17 +0800
Message-ID: <20260203074721.25520-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260203074721.25520-1-dinesh.maniyam@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DSWPR03MB989105:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d145278-302d-427e-0436-08de62f8a65e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AzA2adqDtAqwft4QxMJgkpu9MTihCWCimvFPt1XMp3gUa+voG+XD6tS9QhtO?=
 =?us-ascii?Q?6n6UB+uTtagvuDEEjpFtEwPQlGK4d4rJHAjI9jlbF3oaY5ujbYixZQ5x1qzc?=
 =?us-ascii?Q?fpit+l55WcuQOvCSHQT5DlE/alQv8C0fqT084N63zZvw21NGwSrkpDGwITOd?=
 =?us-ascii?Q?agTxILNixOAmKwGI7qRxvj6xENicge0j2olIdW/p5G6m6xOAbXMxrtwxgeX0?=
 =?us-ascii?Q?80JphafGw+2B4+rDOLaYeBZtW1FcNRWOdlkV4b5zVSz8G13HlTKO+cqANDg/?=
 =?us-ascii?Q?Tzt8o91X+q0LFqMkaP8h3VoSOySxevYHVibEkuC5LlRbWzSG07xSlxniduyM?=
 =?us-ascii?Q?JShuDEc1/+psT85tnKuBuM8VZxGdPz6RsgRwnHsMmcpptRDHtxzLKLpRYTEx?=
 =?us-ascii?Q?+gTqKSwGDWi6SpfImVWdq9JYghKChmk9JA9Gy/lGAk/APbvJJNwkxcWooFjb?=
 =?us-ascii?Q?CcGEc72pp6b0MveV2M3AyEqQlSTlFEoRQTgwtu1d4zDLjDWNALW3+0ZFudUS?=
 =?us-ascii?Q?YiDOriysoNjIoBcaIbiCyPh9rZjEoHXgIrgcZ4wzilERkSQySvB94fwsalne?=
 =?us-ascii?Q?BVJeFtYSXVu536ASEbRtKyJGb2LjcV7ighErGQ/SMRKaiRRZtl7cdCZh0BuD?=
 =?us-ascii?Q?oakQX6UVjeWZAysgEg8uf3RoQ2305dgofAGc+CxII6nvqD4LIAvBH+kXWAbU?=
 =?us-ascii?Q?9qGMp7EocVCK/VoD73/+bOBkh3jV1jKFycBx5pjQxdSujtfa/qysErrfe7NG?=
 =?us-ascii?Q?VgAEFFAbisaOvS1/khEGt878ByvDHuPfq3lKcPizrvbVb4qK1pBo8KGzL56F?=
 =?us-ascii?Q?Vh8I+oGMIhVIKyw5bakbntWAF/Dd9F3NeAVyHYIyA78Ppwp6l+N7wSirKv8G?=
 =?us-ascii?Q?S4GdKbKKNG+5sYW7v2K7Zv6TizZSzgu3XCUIBQE3YR/PdJj/8U6TYqZWJyyC?=
 =?us-ascii?Q?xDBwMhWbHd2TM0jTyVMKCUW9JjMw7UYsvrTQxBVGPezDJjJPG7sBe5MVMEnX?=
 =?us-ascii?Q?xE46z4+PBUs1ZS7vc2LH7noP6Ng1LOJnwp6hc4NAbvW5ITWZCLtHzXbvFeEk?=
 =?us-ascii?Q?Pdq3W4UG9/rrKfJ4XHYl/M+h8A5eU0Unpyt+NsOvOTwv4oKAITvGezWqHu1w?=
 =?us-ascii?Q?t+FylA5D3nTaoMpT3CUSXh4rsPhPGPWgYeyXidHMUZ62MlZ4ZbYOUdGxA6/8?=
 =?us-ascii?Q?PKLI/eJ92WeYEhJpfcCJaFSsncmXqGkdOaXhBKFFe8fVHeTgNfL6rqRYgALg?=
 =?us-ascii?Q?lklCDMVPvUmSisvsfWbO9vZTv5qx3UM7izaeQCyoo+SO4jx1C+yoTpMPDvWV?=
 =?us-ascii?Q?ptpFCDlQKNbgc0JzqJd2OL+LPjCKtY9ZSpnfiuqDAVHVE0AXEceA3GonKpiu?=
 =?us-ascii?Q?VuDs5b6kGhU1javqDQS6VbznslEX/WmYkmPw6xmyixiWu/Vrgsd7TBlB6Mem?=
 =?us-ascii?Q?Qp5S78pndUCfX5vOW5pHujyfMp6K7wh65dBceTg+Fnszj9tT3pR/HamhrnxL?=
 =?us-ascii?Q?6YU3Fy2U+AtuyRybDTGjSAhBIMd7wRgqSZwqZe3vhZd8nsMcShO3c0n6Vpao?=
 =?us-ascii?Q?euY17v6EJScMJHZcfIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zRNSUtRlhjlvdbA4WHiS5A5yOP0/uLPzP+4rSmPYXjbroB/ieJ/jq9iOVAN?=
 =?us-ascii?Q?/NDglobpK/MWiTPBaJjRGsjXs8oeNYLH5VlUXzK86eb3HYvo+PSKuezbDfq9?=
 =?us-ascii?Q?cV/QjHHhcCs+Ma0SWtK/c/wYCBU1lNNxkmTMna1OY5o0+FOuyNugxwjD3rV3?=
 =?us-ascii?Q?gHbMcbyvHf55pifRLZ7R1aMtm+A3PXiRXyZmXw4GgTRFBY6RsPMNdJoCJjNg?=
 =?us-ascii?Q?HNORp2tzF726szllIzdJjEr+vDEiBrvKZb8wxXRurXe+avePdvXDHqrQC8tu?=
 =?us-ascii?Q?LJxIqqM7PSw0A0sEUefnCZ6TwJqaN/moi9+ZU0nw4qyxgOl0uUW1Xl/bhXdw?=
 =?us-ascii?Q?zFrlzyWWnHsITk8BUUX6OXtDpc8/M50kL0qOOV3/h2AAlbbBXJvMS6MW6Cfx?=
 =?us-ascii?Q?AA3mMpz21p2c0n+LmkjfTRNYXZHtOIP4183NbpSrSS4irNi0O73/2ssPxkRU?=
 =?us-ascii?Q?vXFXkwoxsvxdQw/vOwMFstQ8IVn+rvfBIX348Xg+XHfY+FFFHc0Pw7qpiaVa?=
 =?us-ascii?Q?I0iBt6/GwYlBbtSwsDaHh6urwO4lfcnz7ITHcapxJsR6Dl/62AvaQUKagzoK?=
 =?us-ascii?Q?ynNdhqDOuWvpY9aIn4XS/MevokUk7a79dROjZCiyM0X1DOeqDYA70j1pT3bz?=
 =?us-ascii?Q?ng+NHAD4MsF4aBWPetvKGwqkD+7jnNYiLPk/iKbFfGPE7SyhpP7baOqNrdZV?=
 =?us-ascii?Q?z2SccMcJguPZNWNrDFxGPYBAfhD1dpi8tLqVMWZLk+0LFbAzOh0yZ7zOICOq?=
 =?us-ascii?Q?IoM8dlnhpE+qdG9/7wOvQYmgb+qJNBSsCIFrrINAy+jf5s7dFPiTodIVtbpD?=
 =?us-ascii?Q?xYrKJqc/4bUq6kmtPt7Tt8Um6EyZ29oB5dIgwKWM9cHzgHoulGo851TTvAJW?=
 =?us-ascii?Q?+qAQjGOQlIiiAbJs8zYPIYZYUNHDBMYwFWrtVCXzFtKtsMrbIKC/rPQWuRJj?=
 =?us-ascii?Q?Ers3zF65PUhgGkIr+iHE8ArlgSBZeL4Gq518yluiB4jmwSTw8RuupxWy0YD9?=
 =?us-ascii?Q?tNjpoZQy1uSCKYtMMnbo05A/SrFJkgWQpOeyOzLhxJJHwmxYZG3smwjnqY4G?=
 =?us-ascii?Q?KtoL+AycUP5LKL4ADxqHKwSjx9CsxOlWPSviItv4Wz9Oc+9WpxppkbjXn9Qe?=
 =?us-ascii?Q?QebgD5EUvkCr9sO9mTJsyQaB2/6rGhImBDFXu/P5bXqneBcCJOln/+G5ntt0?=
 =?us-ascii?Q?PtElBsz2DxbdwAtUeXh/TtzoARSOUd4uC6QjVPfwPZZFQsVZ4738aKH1KitG?=
 =?us-ascii?Q?CdepJ2vmRZ50rQpq0otNbsBR5a30ioEAK+6kMaNfne1FSnH1mA175/fbkkcC?=
 =?us-ascii?Q?YnxJFS2mLSpKGIoTZHWVlx4V1sxrjrK0X7lD/tmiL2WljNaWqPdZf5Eps8dG?=
 =?us-ascii?Q?JF6mqhIygo/5cJrBwVVRNd+vDGk/1TEImpY8R3hP4fQ4On7UfQXktDJWwJh6?=
 =?us-ascii?Q?56cmeaQRpBzYLir9Unr6xbGOfYcwlQJc6j6RDeKFpkWQukLgjLwwAJ0HKIqq?=
 =?us-ascii?Q?tAcPy7INYSMBKFg/WnDOQGG4SBxWK7vBs+m8wq6XbEVAI1E0/eSdBtodLacB?=
 =?us-ascii?Q?VYamCrOCqDzJoTgZmapQOstcgSS7htrMMTZWvGdn8jFM+a9gjoEkhMNsN8Fp?=
 =?us-ascii?Q?LcXmUaHj4IHCAc5xvBGneZonhE0MHeMbW3wx/q6jprfUOed8Q03sa1Wi3y0P?=
 =?us-ascii?Q?8eW1Eu/EuJ03HyrTVGLmbr4AdNtipHwqZa/4a1Dtg/7kSYAuC5cWO0HuszdZ?=
 =?us-ascii?Q?LGqZX7BtA55/3Jm34sPVAGdhXCWybnk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d145278-302d-427e-0436-08de62f8a65e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:48:42.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6yFeT7EI71e+2nqomVc2Ju0dsOqtFjL+vrjRdkFSQmI54ZknOwgUWUp37JF0LutWuONUOiE+E1VBsdr/RUfqF53g0B3/dKqudIQP6HIePE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989105
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The SPL NAND MTD framework requires working driver model support
and sufficient memory resources, which are not available on all
platforms.

Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
platforms to explicitly advertise support for compiling the full
NAND/MTD framework into SPL.

This avoids accidental enablement of the SPL NAND framework on
platforms that cannot support it and provides a clear capability
boundary for platform maintainers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Kconfig | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index e0ff28cb21b..d73d8ed4404 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -809,6 +809,36 @@ config SYS_NAND_HW_ECC_OOBFIRST
 	bool "In SPL, read the OOB first and then the data from NAND"
 	depends on SPL_NAND_SIMPLE
 
+config SPL_NAND_FRAMEWORK_CAPABLE
+	bool
+	depends on SPL_DM
+	depends on SPL_HAS_BSS_LINKER_SECTION
+	depends on SPL_MAX_SIZE >= 0x40000
+	help
+	  Indicates that the platform has sufficient SPL capabilities
+	  (driver model, BSS support, and SRAM size) to support the
+	  full NAND/MTD framework in SPL.
+
+config SPL_NAND_USE_NAND_FRAMEWORK
+	bool "Use NAND/MTD framework in SPL"
+	depends on SPL_NAND_SUPPORT && MTD
+	depends on SPL_NAND_FRAMEWORK_CAPABLE
+	depends on SPL_ENV_SUPPORT
+	depends on ENV_IS_IN_NAND
+	select SPL_SYS_NAND_SELF_INIT
+	select SPL_NAND_BASE
+	select SPL_NAND_DRIVERS
+	select SPL_NAND_IDENT
+	select SPL_NAND_INIT
+	select SPL_NAND_ECC
+	help
+		Enable loading U-Boot from NAND in SPL using the full
+		NAND/MTD framework instead of the minimal SPL NAND loaders.
+		This provides bad-block aware reads and flexible offset
+		handling via the common NAND/MTD infrastructure.
+		Platforms enabling this option must also provide working
+		driver model support and sufficient SPL memory resources.
+
 endif	# if SPL
 
 endif	# if MTD_RAW_NAND
-- 
2.43.7

