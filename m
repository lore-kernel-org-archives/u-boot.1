Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CC6C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BFF83BEF;
	Fri,  8 Aug 2025 11:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OSGF+24S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4813283C0B; Fri,  8 Aug 2025 11:32:29 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D18B83BE1
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytsG8k2d0EQ6r5goOvo6TJER1e/RbRdWvpiSNln+LUrgs+gNVxp3ou+4P0LTdZxmlHDxvXSShEzp86NMkpA14JdO434scZuvVkeGWRR1tkeGwzSxVT0sh+B4MK8SdwDqUXooadNzpnRAtw0b3rnTvyYV5F2YBs6vTkh5jafFiyYHfdxqYw3G/9iMosEiRRzz5L9SVL9ORTbcM91+NuMLVtsdUt2Og0+pkSvsF2AhEFTgl394ydpoczw70RmnQ8HCIDlBMbScKx4UhY0qXPGIHlijMcLGqzSOeU7Ilg6Tzsmo+Xum9LMlKetKYizDAa4HGL4792wICe9Z765c4AJjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opn/evTeXKmQMEYN2y5dRP4C0QeFk18V/RKnZS9/tU8=;
 b=vaOk/QTcU9F0Q1QRfNUJaYjDkbw/J+VA5Rr9agGW8MdwJEUxH16oKsG32cdf76eU7vANKb4ePqtlg3g9z5zqNmSPiBJwRSwjRWWMXhZtCTeO4fGskqLKYccpMTVFsvKWtBznOz8sDyPLQLr1C613d/y7E1PKbHw4wHt3hkOo1Rl8GVAPd5sLoyYTHGt7hW3/hlyFBQtOFImdrS/v0e+hNOoKPidejnxg11C8i1D6XaQgWOVf7UG7obFF/Yu5EL4x2+UeGZ4SNDm8NdbDGp4OjgyRpIt19w1+nedvonjM4vyE5+1mKUULztlIullxt8dTzET7nyK/5v3Rf3K2c4amWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opn/evTeXKmQMEYN2y5dRP4C0QeFk18V/RKnZS9/tU8=;
 b=OSGF+24SxtGQ5Z76YszZSMr2AgRttPIeSCGtL2HnA2J7Gc7G5y+8b4OPOt8HEdrR3028vfmmWPFJ8PkyPi+wziffGRL4ICLgiuo0OeKNW/2Pj+rr7rsXdQfjuGM2f6sNU5jM687fuiEuuD1EQhCdz4djr9ljJGvYh8UGJqfcNP4Hvqzo7Uw2RtFZmbHUKhklwRqs+e23lM+wh+D0RQ1mZwf9AWTJT1liKwY7lQBgf90DcyBsf2Vn3zlUusRSrE3paJSGLc1RZg2zwaJw4nZY4sKkRUCthPYXTQeVV5Jn3VKeXOJLsKrEZf9Z9AuESGPGaCvoFfjJZDmg4YTLK4Bq5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV3PR03MB7730.namprd03.prod.outlook.com (2603:10b6:408:27f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:32:24 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:32:24 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] configs: Simplify Agilex7 VAB defconfig
Date: Fri,  8 Aug 2025 02:30:41 -0700
Message-Id: <20250808093041.15011-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV3PR03MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ec5f34-a412-4813-ad97-08ddd65e7b2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DlNq6IPDLiMcPOcH+xDqDif/5X2ouJ7Nj+rWWQyF7KyXNXfd6rUQ/DO5pZaR?=
 =?us-ascii?Q?cRThVft7J6PH/ljEXo22aflyk/DVCr4C8pO+43PdafZDnPB9uw58cf4+IAA4?=
 =?us-ascii?Q?tqrVN+nLmANtOwmyVeMtR2eJXSJdKIAb3SoA+5a4W1sot1M77i1E9/URiLIM?=
 =?us-ascii?Q?NjYiDdBwGHr5cTzvrAhn/8AK6UtJDRf0hfnzEXAQeLGmhKrXKWu/w5c52UQu?=
 =?us-ascii?Q?6MRJ/p8SzIj15L6048TTSOfULockgfWy38lzvYS4VnCdSfSHoBBnKcAfbITl?=
 =?us-ascii?Q?Al+L5saXQJ2Wgb52dRg7VOi3+vIcfbh/74IOSReDd74ml2QIUdAedTLcvPAr?=
 =?us-ascii?Q?zinYq4aW7yVEKRtf9ciQ7YC9LGv3BALJ6GW4HZBWEZnWJLN5cAq9ah6PmFpC?=
 =?us-ascii?Q?dvOjz5E6DyY/VaWlwkxnodKm4e0UuObA0ZXW7KvacfPULBkRxQZajj0n20/g?=
 =?us-ascii?Q?7maiXdT6McCdcqQcNN2rLge+hZeIeZfRI9ZrEkbIrTrKXl6i5V/PsDnqYtXL?=
 =?us-ascii?Q?BnejpxZ8Jql6rHqIkd7DdHsn/fzje6W1JzmxH7bQubwCUiZ0GNf2NgQGPk3U?=
 =?us-ascii?Q?j+ZlsC7kQ0FqKTEX8mRf6LJSgjv/fI0gx+Bck0cl1x1i5T9kVCqyk/Jd6G0r?=
 =?us-ascii?Q?J3y0f8/ObcJFdG7WxpzkBUstY8y0y3+EuasAZP04KL5jfV7Gi4y9XoscKNsw?=
 =?us-ascii?Q?iXH6prgPZ6pLpLxGUjICMrSRzRrr4oHO2UtenknxJkSyc74fNxTvomVR4AAj?=
 =?us-ascii?Q?j/dnEh1A9Zem/Udipj5TfUzA47D8nlbk/UgQfOgB96V7O3a7Qq3VjfXUC3xC?=
 =?us-ascii?Q?aK7Zh52V2ylxxiZcvWln7eNmM9XKK4KNTtQSAPYPw/IuTRW+23qaNsn+BH5n?=
 =?us-ascii?Q?CH7u+3NxWbuylS7XJilcb2+E+3dzALQU1jZpE8N+2CzBskLGJToXMLrcYsB0?=
 =?us-ascii?Q?UQPBxyBNGCgjBXEITQkwmVFCtkDZngjfHDf8NO8BDcxbe+QjB1CBk5z4A2l9?=
 =?us-ascii?Q?PeljfUj+935rN6HOgdVOmpjhWOd0g9Uzm8IhV1VGNfe2PkI+AB2n9mpshN5N?=
 =?us-ascii?Q?uxZs5M05ZP0QKeOU2nzwuwKvpeN5QkfGmMElwrF7xQO7GYfqjbucUaaIpwUJ?=
 =?us-ascii?Q?ftPrsgbsTWXEK7bqYrrdQhwstCzWdew2dEa8Z0mEyambVAWwn6mwxnWs+Vwn?=
 =?us-ascii?Q?75DbrcDqbaKwFeIuHhCkBi2MiryxgiiAIM9Sfncb6RFr6ClMGImtwzMxUWZ2?=
 =?us-ascii?Q?K9lPf0hjaJo74DT+ijVpHH7rXNkEn2tf2TPDdPaV3XYLvy01v+Ex/unzETWc?=
 =?us-ascii?Q?EfIODlSau/3TlVhFpqBN1V8KHFBKKxISVlPRyxqtAkYHC7FU9Agc3lrAn9bR?=
 =?us-ascii?Q?u+WjRYfRvC7Owv1Vxh+G7wT2rD3tv3uiuFlI45o+ANBr2jNpSZc+2t+etsCk?=
 =?us-ascii?Q?ehphaieDmVE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nr7Glynf6D/BaS7gKbOtb2T4s/RJYULVJQgBjBhyua5lRSG5YWdYX1K+q9St?=
 =?us-ascii?Q?0Q2yZP+KtpNiUkgn6C1A/xPxxHOb8tIVYa5+GCD28LLGEUbHdAhz/0jkpboF?=
 =?us-ascii?Q?1B8JWagT8MBdexpvZtJDSwxE/lmd/XZ74aV+Q0ApIo86ssSm7CVYS7fdeoEc?=
 =?us-ascii?Q?PAxa6DkU6N1iC0+GMWeewPWJxUmwi0q61dyLdjdY11DKSwUUyEz429CrIyRx?=
 =?us-ascii?Q?EjtlWz0SBsIWIpkP036YReQEepGny+zI3YJ5+w8tn1O5daAObV8vnqo8Ixde?=
 =?us-ascii?Q?8w48mgE4cGFO0r4khXjRDax2pXUylrgOxshrZs7EhbLx447ne8Eu6ASwdL5N?=
 =?us-ascii?Q?KSpXqXBMUDwKoG89rdhGQcrVZTki+WDkkHx85Kj8QpuEnT7lGThk9F+3a0qn?=
 =?us-ascii?Q?S98kcnRV92wT6SNPMqjDNRveYxyEDyrscZ+wfw9RGXx0ATVyB8eAWCBbO4Wf?=
 =?us-ascii?Q?5aMkFP7nykPV5pOkDk/UNixcZQ/ZTDqPc4LUJCEWPws0gxIGIVii1kFZUWXr?=
 =?us-ascii?Q?vxwUotxDCB5wBJA2klmWDK7rUJ8chAYThFuZNz9yCVpSql5dcTrtQE4TIXH/?=
 =?us-ascii?Q?PP3REC2YzzYqCS1cWaXPn5PJVqT2rtlLr0e0WWJ+VtHRhubLIReYOZ3xJZxq?=
 =?us-ascii?Q?5rVdrWxxZtNOiph1MvN+YMwMSYytso7TQDN5i+C+StfTuumptT4prCSQLQn9?=
 =?us-ascii?Q?vXECJl/08xxXktJLPdDNE694mteQXGQqhK8uiweALsNXLjdxgRSqq/dg0mrr?=
 =?us-ascii?Q?l+gCtB3SfFLQC/Essx7fJPtlewIIOgMmH1FAEoQzbbOSRmdcNmnbZ5tyWqSg?=
 =?us-ascii?Q?cSZk4RfkrZa/yhdyj5H14KaFrkvpxwQQCMQ57FPfpYKX/fDy43NAeGzEpwnO?=
 =?us-ascii?Q?Y1MXZY2JEdE+kc8tAhYpFO1v1R+jNvY/Y1pcACnNq+7k+2iOtRmOQUMcEsm4?=
 =?us-ascii?Q?XErZF679aIvDeMu07Ov4VeOkda/aQ8B/5i6J5L1IeXwVm53HR3GEEwW1S3Fi?=
 =?us-ascii?Q?4oEynku4AwS+HOKYwRn/xKIduiYPxk1QttTGNokBfweZyhezqVh8VFKqJ+Iy?=
 =?us-ascii?Q?m+hpBidte1UB9RNdohVXyqhJr95C8ruOC7MuZFjwR5OnE3jOY5BP4qV8X6rR?=
 =?us-ascii?Q?Wfviqxa0fOtSzkwH280fC6v4++FNUZ9VqGUFUqYsn8dGdwi/hoffe/ixt96H?=
 =?us-ascii?Q?T0udLvee6aPPgnmwaxiQURk5KApuFK/bq27Gf7hEUkyJyVR4Mv62Cqz9Bi6E?=
 =?us-ascii?Q?l7xXodWybBC0K5GGvU4RwCwS84+MTpo9u6VTSDakUdAjSJQTLNWPff87JqbL?=
 =?us-ascii?Q?RyNklwkklPpAmr14OCtiIdA4K7lYwqhx1dg6mlv4mRrOyKmZ+f2tvtMzz50F?=
 =?us-ascii?Q?mKKVTlbKwd9AoIwXmU4ahWCKLqSRuUT/EZifpUqMeIsm7quMEr8ictFHZxgY?=
 =?us-ascii?Q?bTqFTXxe5twUxkb9vscfM79RnW63Kdzh3EjyI+PPW8baZr1za9IXAM/RdnFS?=
 =?us-ascii?Q?J5c7MfHWD1UuV+2d+XVu9n3j0ZUULNQzk/TvKYtUXaOUuBArbv9GLPRVx8WQ?=
 =?us-ascii?Q?FA2x5GwDGQfIxTazuXcJrbAeWeHgEGlNvtCLVA/xaoZLgvs0ugN9Yn03++wV?=
 =?us-ascii?Q?Slkuu6K9JPwRNzXajdhY6b0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ec5f34-a412-4813-ad97-08ddd65e7b2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:32:24.0140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQWg1OfWgeWMj56ZY8S3tsbGAamsdiQ+qF6lVkZaaMnLlJ1RR3zOzGSIn3sQINvoHBMvCCRtL7gr954Olf9z09daKb4lg4QEd3Rpr46W1sVT6LN8BX5Xs62O8gXzBpXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7730
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

To ensure unintentional bugs occurring because of config changes
in master defconfig and its VAB variants, VAB defconfig files now
include the master defconfig and enable config values specific to
VAB functionality only.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex_vab_defconfig | 95 +---------------------------
 1 file changed, 2 insertions(+), 93 deletions(-)

diff --git a/configs/socfpga_agilex_vab_defconfig b/configs/socfpga_agilex_vab_defconfig
index 8eec3d8d67a..4607dc73343 100644
--- a/configs/socfpga_agilex_vab_defconfig
+++ b/configs/socfpga_agilex_vab_defconfig
@@ -1,94 +1,3 @@
-CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=400000000
-CONFIG_ARCH_SOCFPGA=y
-CONFIG_TEXT_BASE=0x200000
-CONFIG_SYS_MALLOC_LEN=0x500000
-CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
-CONFIG_SF_DEFAULT_MODE=0x2003
-CONFIG_ENV_SIZE=0x1000
-CONFIG_ENV_OFFSET=0x200
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex_socdk"
-CONFIG_DM_RESET=y
-CONFIG_SPL_STACK=0xffe3f000
-CONFIG_SPL_TEXT_BASE=0xFFE00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x3ff00000
-CONFIG_SPL_BSS_MAX_SIZE=0x100000
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x02000000
+#include <configs/socfpga_agilex_defconfig>
+
 CONFIG_SOCFPGA_SECURE_VAB_AUTH=y
-CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK=y
-CONFIG_IDENT_STRING="socfpga_agilex"
-CONFIG_SPL_FS_FAT=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
-CONFIG_BOOTDELAY=5
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="earlycon"
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
-CONFIG_SYS_PBSIZE=2082
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
-CONFIG_SPL_CACHE=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
-CONFIG_SPL_ATF=y
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="SOCFPGA_AGILEX # "
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="kernel.itb"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_SPL_ALTERA_SDRAM=y
-CONFIG_DWAPB_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_DW=y
-CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-CONFIG_MMC_DW=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_MII=y
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SPI=y
-CONFIG_CADENCE_QSPI=y
-CONFIG_DESIGNWARE_SPI=y
-CONFIG_USB=y
-CONFIG_USB_DWC2=y
-CONFIG_USB_STORAGE=y
-CONFIG_DESIGNWARE_WATCHDOG=y
-CONFIG_WDT=y
-# CONFIG_SPL_USE_TINY_PRINTF is not set
-CONFIG_PANIC_HANG=y
-CONFIG_SPL_CRC32=y
-- 
2.35.3

