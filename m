Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62A7C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD4483F2D;
	Mon,  4 Aug 2025 03:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wPDZK6sN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25B383F5C; Mon,  4 Aug 2025 03:25:40 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E8583ECF
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDtNTQkpfE6GiqK/bUcxZ0Ak8E+ZpSwcEikv5MIBZKzmV2vKgJSGPhZ1G0PHdHacQx17F3PJV9rRxHIepq5NeIMePSkyOuHEZETiwbwgihe92XPmzVZPrRFFTARgu9/OUIqXvsxjI/nB2Ikb3Ry/fhfRhT8GelYDu4lxj3UIdMCyI874VdFlNb81H4HTeLYoPcce1+KV8cXlq0cSZNZ5SFHfXw2ntSXd0x9VshaNcmbM8D8VKkG2CIIL/jwe0VTHUKzKOHijICRWaWDPWKymbat2AV8/uwLxqdrfrbUA5fh35Q8DH93nmusIS6+J/Q44NIkqtTotPBInk1ZYfPjn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyD15frlwvpqfAaSyYeMmMSJdosvGhQ9DapDjUYNTkY=;
 b=edo/Ebh0J6nev44TRbbhZwyGzkLD3Ffubwvks8zrKnNZPp78qEe9x4uqczDoIvsbpLEEvxjKtnPea38Rv6ockUciFphPsiYzflMYVjHcDDG6MACsHSwNxCVXcMoKtMLI2/Deu4OMqpdApbE+rZ7IClJcig6HBbT62HlkuWLbm8HyWYhC2B9hs1z62bElVxo5NVBTpbRbXv2M3jQMAdQSYE4EFmn3ArtGCJGQQn48x5Gwc2WdxzxNRY43NqY3VRJ8VFcJTY9vQXd6824g2VpPTM1WIN841W4a/r/1RXrfOBdArkhKzaM7+f7+jKz3A1tBCGwvmPekJJyQ1j0h5KKpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyD15frlwvpqfAaSyYeMmMSJdosvGhQ9DapDjUYNTkY=;
 b=wPDZK6sNM429zjhtRWlYun4FHy8DBEvOp6UCfjgKC24uAeK+WqY5evwf82MZV0LJZeUUiYZ9kR7WEppWut0tTaAauoJp50MCwK5FLXG0H6ZFge1IhDnAovS7wgnIt2AmGP4n5TKIcME1VnhijieQu57gfvZh9kJaNf7Umg38Va6VQ+ZmO0h5swSlwq2ALyI9MvJL4NcrenBcUu0U3tz1a7sbes8Avu/HZxekubBKAtVVKelh/qzEK87L+R9CTlWrQ9SNaFWP7xqoM3zbqAuzaSVLjI9TehtUWf9k3gnxXG+RFBfdD5LQ4EDGfuZQKIHyki9rv3Mxc5/JQX+vYejoKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5613.namprd03.prod.outlook.com (2603:10b6:a03:28b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:34 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:34 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 29/34] ddr: altera: Add DDR driver for Agilex7 M-series
Date: Sun,  3 Aug 2025 18:24:56 -0700
Message-Id: <20250804012501.21811-30-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e6955c-5374-474a-dcbf-08ddd2f5cf62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FWeIQf1YW2b4dqn1SUctrYRf5j9xObixtCJ3BZX2+F+kr8hbnm8F926BkM4R?=
 =?us-ascii?Q?f/Bpi1ZNdNQtKddqUV3ZptRTlL5MrelmziWR4T2wKLEclcBpDch0BD69KyXy?=
 =?us-ascii?Q?pRoV7Dz7jgFtgdUxfTdRaJbm1pBX6cGEqlkSjzm0XF0wV+qEZq7LCMh9SOyh?=
 =?us-ascii?Q?F9POxDsApfCcc3EdG7BklWDG1+7IOzHQKAIcNAbUHizE7f8iALLrXMQJa0vL?=
 =?us-ascii?Q?50w9gtur2DR7wX3i9cZa+GRFJ8OXI4TzYuLR3pPNMTXLwoRI2xZukMEiSAS0?=
 =?us-ascii?Q?Th190kBut1mz4BaNn++BIfhtGB2p25zgVzj7VU1ghX1jvl/B/iNyJ9+IEzyX?=
 =?us-ascii?Q?Qg6Zitc4TiSFrv2c6wxB5kCV8MVLPQYx4Gf8puPd93wwxei/2C9UgfypCWoA?=
 =?us-ascii?Q?+KpMc/mwoiodO68c0sQ+HI4ZltCUmxoURrv7IoZjcj5fChf+5NIMVDNBM5np?=
 =?us-ascii?Q?bA4Tl8xrwmVGi0rAQY5Cn8Wb5d7ap/b1Q1OBI7z/1dcdZaDuPFLPKz52QjYo?=
 =?us-ascii?Q?Qe1gSq3YXST61bu0wupqKHKadh6rrHf2lYWtfcwKLLl8fT4jBPTHvvUuZYV0?=
 =?us-ascii?Q?77okioWVk3Rw0C/duVDcnOoQaaRCFs029Zm01uFYCR8B4Ng+OSX4B/Y+pCB+?=
 =?us-ascii?Q?/MFvGgJt4slPUsdej1m4+mqC/PJyb4+SoPq4ROAqvx2yOTc59E5auoZVC5Wj?=
 =?us-ascii?Q?WGWX690/07ifKmQ6GiWGzktoiwiT7MyPQOKXRM6cVqN4oux6ruW4pLrlq+4q?=
 =?us-ascii?Q?+ZuXBbPRRmVuKiA9hrzRYTExHxrTxrRNIyQca5MDwRx86hm5WgzjMFlFDIot?=
 =?us-ascii?Q?eFOIHKQ660v/4DeFkS/5d16fQSI3IPskOKjG9vN8BwGX89hBE2MbiMZ6h6DC?=
 =?us-ascii?Q?ccK3Z1RxAf8yEkiVQfrLvOJT6CrICHMakI3lp5fOBXRtVkOhoDpDGxms6KgG?=
 =?us-ascii?Q?aILroXkPy1yWpwqCh8/ts4GLBzbkhGrB8Mty1A7RWsfIoAqbEMA/vg9P5/ky?=
 =?us-ascii?Q?rRR15PyQ4oVUB4kap+UkMdNsYD1EtchbkZivam3m5FjRB5Alt6EyDQMrKaPI?=
 =?us-ascii?Q?orXPDsbx8KPcxDE3J7xiAOuVNzYempIl7YGO9iOBuJZAIhK2QjmY+UeMyiCi?=
 =?us-ascii?Q?uLsSoo5Dt03V9VScvgGBzthXqjRVxzHekNk02MJCZD9aHtt3HDphjjOa8kez?=
 =?us-ascii?Q?j2sBxa4kkm2UBbgQcow96KNFd0J1GhOfOiL5+RVtRDtoIpNuo2vHAB4ilmxl?=
 =?us-ascii?Q?2LCJoZu6gD2FGoqUEvVkKwABcD5Lnslq7qGU87jMe7usTYSjyHRTMTFX8GHp?=
 =?us-ascii?Q?0dlOpFgP5xUexWGRksElV9ZtVMKdcELD+ngRgHh9fsVy5f1i4Z+CZE4v2FE1?=
 =?us-ascii?Q?lV3tWXA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?THZMJyz/ojH94/srFcQdi/qYYxVvnNXuAeniElIR4bv7erRZExZYtXh4BRBh?=
 =?us-ascii?Q?eoMctMhDTtusFNF24Ef3H1ab4NVrN75u5nghiYScwmJbLH4F4aJlfBw6Sm+o?=
 =?us-ascii?Q?jXJ9X75EWBP2vEdKHgk10tKzCpMquK7VThNJGlPqcb38jEQuAY603kf/PNBH?=
 =?us-ascii?Q?N5Zz+rYsThpKJDPGDFjFhKt4FDlJrs0ag2SAY/D8rjp7uOJD1ZYo7RPVT3Q/?=
 =?us-ascii?Q?Sy0cI/YkdoQKaE+vWLFfmiZEwRNiDWaxhykWsaEbuS1g5DSld+/Hbsrv264J?=
 =?us-ascii?Q?cPYGzyCzU6FKnaiHQ7i4m+dn6SiIYCYOTYs2ZvTD/kCixInOHKNBuzAi+keW?=
 =?us-ascii?Q?2CFOrVkPbtsrSdx0zrk6HhONZdOMCPWYYBzbTXSerSRRrkN5keCfyMV3B6TM?=
 =?us-ascii?Q?tMwsnJ5huNaMFNBSPjhHjdiiX237kvf3Gsvu7L6Xi0fqC8MMYzUBlDhiqgtT?=
 =?us-ascii?Q?lZXHuPlKHnDCaaNbRtMM9zZVX+j51688MpEHYyFLHbXUJ20tZFZ3IOsldAy3?=
 =?us-ascii?Q?XNWkidPLXcU0cdepN5ilwc6B0nV4t78Ze1SnRR1CxgvmgDMYwKtJ4gxqYf5j?=
 =?us-ascii?Q?bju0qrYODyb72qPdJh66kAeXWGEEEgfWgUmplaTMPw+uAXaX3qLpzG+HNwRD?=
 =?us-ascii?Q?vwhs1OI/v4sdpYLLE+UzvGAeqMMmv6OkpFSWYR3f5S6y44yBFzTSlw1FLUVk?=
 =?us-ascii?Q?jycqek+fAdnDV0pPuUIA1lqcbVLB3s7t1HUIqFaZ/8Rf+6KKzxyFBxpsR9ar?=
 =?us-ascii?Q?R4enO9totttnmT2ZRnlTnL6nEdphX7OLLpSd078jFSIQh2yFIaoeX+G2gZUH?=
 =?us-ascii?Q?yZF39bFMjAOiseM9dfqXRJUNPuXaIPErNk8pTHNLhadWt20VWEm+lMwqzMdD?=
 =?us-ascii?Q?oAnyxSnV9ku7hNYTb/jC/aX06Fq52niDZrt0gDemhqoGZV46icw7FvbwwCXE?=
 =?us-ascii?Q?crRguk7iO6Uu+TIz/sjuNTXJILxnp5IBE06l/La8/v8lL6MT2jOjwPasV0eP?=
 =?us-ascii?Q?k+eY2x4Kqkeg5UXAsRri/+aKz6JGUp/AapiMHoHPAN8awsIy+TOP4Vps0qHA?=
 =?us-ascii?Q?gjhr5GgTBAE0OMtmLpt0EKWq2wcJ49Yy9HUEgQ7UrY8cNqRzifStiAZ7CrF+?=
 =?us-ascii?Q?3OevUfSa0nRpl+LpN06Ih6UrWCL8lJ9084X+bMJissUWaAFi450K0DZfSrun?=
 =?us-ascii?Q?Ip3lVua6VXS8Mds3Gg+ZRt4PM6pNJRjvVlppnBn11AxLuAhdDzEQXSUEvjI+?=
 =?us-ascii?Q?Wib7bAqZZKaJR3zpJuFJXYaCxcLiS18PTrEA7fkFVtF65AdRTuNfXhkp78xP?=
 =?us-ascii?Q?+9UZScS2H3/0lztELeBBAiR/tbeoSaHqX4FL3xFa7/CiYjRdLMi16QmdW8Qk?=
 =?us-ascii?Q?JlOJlN0ukPCN1oy5PRNNtiPSeWh4oUn3vwB2Z1CYOTxenYSIGTGt3t/kp+Sb?=
 =?us-ascii?Q?k2BDLGOWxjZJ9CbcYsxsXE+pNnPstrj5lcJyTIohQoWtTS8BBS0B9ZYvoJu7?=
 =?us-ascii?Q?wYn1t9YfcbWI4NtpybC6ARr2Vy16SURpooLBrbSYVaRpRMIA61hyfntH2D7b?=
 =?us-ascii?Q?Zp2KWUGf3iOz2wB0RZCSfaJkII2lsTfkcjyYrHtGkdjqJtP692L7JarB7OYZ?=
 =?us-ascii?Q?vsOL4/PP1AigdevZxe31wT8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e6955c-5374-474a-dcbf-08ddd2f5cf62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:34.8346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg1eriaxKgjun73QNkX3N4faC7qVZFP3YsGZfZMwoWbpnocBDhUw4cJRRsI81kW4hlKKADHTXcRqDFAfSL4T+gLlwnWiDONX+1v1upAdTco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5613
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

From: Tingting Meng <tingting.meng@altera.com>

This is for new platform enablement for Agilex7 M-series.
Add DDR driver for Agilex7 M-series. This driver is designed to support
DDR and HBM memory. The official HBM handoff is not ready yet, therefore
hardcoded handoff is used for HBM driver validation on mUDV board.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 .../include/mach/base_addr_soc64.h            |   6 +-
 .../include/mach/system_manager_soc64.h       |   3 +
 drivers/ddr/altera/Makefile                   |   1 +
 drivers/ddr/altera/sdram_agilex7m.c           | 500 ++++++++++++++++++
 drivers/ddr/altera/sdram_soc64.c              |   5 +-
 drivers/ddr/altera/sdram_soc64.h              |  11 +
 6 files changed, 523 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_agilex7m.c

diff --git a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
index 5ac868a281b..074b9691af8 100644
--- a/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/base_addr_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016-2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef _SOCFPGA_SOC64_BASE_HARDWARE_H_
@@ -45,8 +46,10 @@
 #define SOCFPGA_SDR_SCHEDULER_ADDRESS		0xf8000400
 #define SOCFPGA_HMC_MMR_IO48_ADDRESS		0xf8010000
 #define SOCFPGA_SDR_ADDRESS			0xf8011000
+#define SOCFPGA_FW_MPFE_SCR_ADDRESS		0xf8020000
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020200
 #else
 #define SOCFPGA_FW_MPU_DDR_SCR_ADDRESS		0xf8020100
@@ -75,6 +78,7 @@
 #define SOCFPGA_FIREWALL_SOC2FPGA		0xffd21200
 #define SOCFPGA_FIREWALL_LWSOC2FPGA		0xffd21300
 #define SOCFPGA_FIREWALL_TCU			0xffd21400
+#define SOCFPGA_FIREWALL_PRIV_MEMORYMAP_PRIV	0xffd24800
 #define SOCFPGA_DMANONSECURE_ADDRESS		0xffda0000
 #define SOCFPGA_DMASECURE_ADDRESS		0xffda1000
 #define SOCFPGA_OCRAM_ADDRESS			0xffe00000
diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 713fa2c517b..054a28d845d 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -146,6 +146,7 @@ void populate_sysmgr_pinmux(void);
  * Bit[31] reserved for FSBL to check DBE is triggered (set by SDM to "1") ?
  *
  * Bit[30] reserved for FSBL to update the DDR init progress
+
  * 1 - means in progress, 0 - haven't started / DDR is up running.
  *
  * Bit[19] store ATF CPU0 ON OFF value.
@@ -156,6 +157,8 @@ void populate_sysmgr_pinmux(void);
  */
 #define ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK	BIT(31)
 #define ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK	BIT(30)
+#define ALT_SYSMGR_SCRATCH_REG_8_OCRAM_DBE_MASK		BIT(29)
+#define ALT_SYSMGR_SCRATCH_REG_8_IO96B_HPS_MASK		GENMASK(28, 27)
 #define SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_MASK	BIT(18)
 #define SYSMGR_SCRATCH_REG_8_ACF_DDR_RATE_SHIFT 18
 
diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
index c627f16711e..7ed43965be5 100644
--- a/drivers/ddr/altera/Makefile
+++ b/drivers/ddr/altera/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX5) += sdram_soc64.o sdram_agilex5.o iossm_mailbox.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += sdram_soc64.o sdram_agilex7m.o iossm_mailbox.o uibssm_mailbox.o
 endif
diff --git a/drivers/ddr/altera/sdram_agilex7m.c b/drivers/ddr/altera/sdram_agilex7m.c
new file mode 100644
index 00000000000..9b3cc5c7b86
--- /dev/null
+++ b/drivers/ddr/altera/sdram_agilex7m.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <hang.h>
+#include <log.h>
+#include <ram.h>
+#include <reset.h>
+#include <wait_bit.h>
+#include <wdt.h>
+#include <asm/arch/system_manager.h>
+#include <linux/bitfield.h>
+#include "iossm_mailbox.h"
+#include "sdram_soc64.h"
+#include "uibssm_mailbox.h"
+
+/* NOCPLL register */
+#define SYSMGR_HMC_CLK		0xB4
+#define SYSMGR_HMC_CLK_NOCPLL	BIT(8)
+
+/* MPFE NOC registers */
+#define F2SDRAM_SIDEBAND_FLAGOUTSET0	0x50
+#define F2SDRAM_SIDEBAND_FLAGOUTSTATUS0	0x58
+#define SIDEBANDMGR_FLAGOUTSET0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSET0
+#define SIDEBANDMGR_FLAGOUTSTATUS0_REG	SOCFPGA_F2SDRAM_MGR_ADDRESS +\
+					F2SDRAM_SIDEBAND_FLAGOUTSTATUS0
+
+#define SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL	BIT(4)
+#define SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING	BIT(5)
+
+/* Reset type */
+enum reset_type {
+	POR_RESET,
+	WARM_RESET,
+	COLD_RESET,
+	NCONFIG,
+	JTAG_CONFIG,
+	RSU_RECONFIG
+};
+
+phys_addr_t io96b_csr_reg_addr[] = {
+	0xf8400000, /* IO96B_0 CSR registers address */
+	0xf8800000  /* IO96B_1 CSR registers address */
+};
+
+phys_addr_t uib_csr_reg_addr[] = {
+	0xf8400000, /* UIB_0 CSR registers address */
+	0xf8410000, /* UIB_1 CSR registers address */
+	0xf8420000, /* UIB_2 CSR registers address */
+	0xf8430000, /* UIB_3 CSR registers address */
+	0xf8440000, /* UIB_4 CSR registers address */
+	0xf8450000, /* UIB_5 CSR registers address */
+	0xf8460000, /* UIB_6 CSR registers address */
+	0xf8470000  /* UIB_7 CSR registers address */
+};
+
+static enum reset_type get_reset_type(u32 reg)
+{
+	return FIELD_GET(ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK, reg);
+}
+
+bool is_ddr_init_hang(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	debug("%s: 0x%x\n", __func__, reg);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK)
+		return true;
+
+	return false;
+}
+
+void ddr_init_inprogress(bool start)
+{
+	if (start)
+		setbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+	else
+		clrbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+}
+
+static const char *memory_type_in_use(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	return (plat->mem_type == DDR_MEMORY ? "DDR" : "HBM");
+}
+
+static bool is_ddr_in_use(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+
+	return (plat->mem_type == DDR_MEMORY ? true : false);
+}
+
+int populate_ddr_handoff(struct udevice *dev, struct io96b_info *io96b_ctrl,
+			 struct uib_info *uib_ctrl)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	int i;
+	u8 count = 0;
+	u32 len = SOC64_HANDOFF_DDR_LEN;
+	u32 handoff_table[len];
+
+	/* Read handoff for DDR configuration */
+	socfpga_handoff_read((void *)SOC64_HANDOFF_DDR_BASE, handoff_table, len);
+
+	/* Interleaving Mode */
+	if (handoff_table[0] & SOC64_HANDOFF_DDR_INTERLEAVING_MODE_MASK)
+		plat->multichannel_interleaving = true;
+	else
+		plat->multichannel_interleaving = false;
+
+	debug("%s: MPFE-EMIF is in %s mode\n", __func__,
+	      plat->multichannel_interleaving ? "interleaving" : "multichannel");
+
+	/* Memory type */
+	if (handoff_table[2] & SOC64_HANDOFF_DDR_MEMORY_TYPE_MASK)
+		plat->mem_type = HBM_MEMORY;
+	else
+		plat->mem_type = DDR_MEMORY;
+
+	debug("%s: Memory type is %s\n", __func__
+			, plat->mem_type ? "HBM" : "DDR");
+
+	if (plat->mem_type == HBM_MEMORY) {
+		/* Assign UIB CSR base address if it is valid */
+		for (i = 0; i < MAX_UIB_SUPPORTED; i++) {
+			if (handoff_table[3] & BIT(i)) {
+				uib_ctrl->uib[count].uib_csr_addr = uib_csr_reg_addr[i];
+				debug("%s: UIB 0x%llx CSR enabled\n", __func__
+					, uib_ctrl->uib[count].uib_csr_addr);
+				count++;
+			}
+		}
+
+		uib_ctrl->num_instance = count;
+		debug("%s: returned num_instance 0x%x\n", __func__, uib_ctrl->num_instance);
+
+		/*
+		 * HBM memory size
+		 * 1 UIB channel has 2 pseudo channels
+		 * 1 pseudo channel is 1GB, hence 1 UIB channel is 2GB
+		 */
+		uib_ctrl->overall_size = (phys_size_t)uib_ctrl->num_instance * SZ_2G;
+
+		/* UIB ECC status */
+		uib_ctrl->ecc_status = handoff_table[4];
+
+		debug("%s: ECC status 0x%x\n", __func__, uib_ctrl->ecc_status);
+	} else {
+		/* Assign IO96B CSR base address if it is valid */
+		for (i = 0; i < MAX_IO96B_SUPPORTED; i++) {
+			if (handoff_table[1] & BIT(i)) {
+				io96b_ctrl->io96b[i].io96b_csr_addr = io96b_csr_reg_addr[i];
+
+				debug("%s: IO96B 0x%llx CSR enabled\n", __func__,
+				      io96b_ctrl->io96b[i].io96b_csr_addr);
+
+				count++;
+			}
+		}
+
+		io96b_ctrl->num_instance = count;
+		debug("%s: returned num_instance 0x%x\n", __func__, io96b_ctrl->num_instance);
+	}
+
+	return 0;
+}
+
+int config_mpfe_sideband_mgr(struct udevice *dev)
+{
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	u32 reg, mask;
+	int ret = 0;
+
+	if (plat->multichannel_interleaving) {
+		mask = SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING;
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, mask);
+	} else {
+		mask = SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL;
+		setbits_le32(SIDEBANDMGR_FLAGOUTSET0_REG, mask);
+	}
+
+	reg = readl(SIDEBANDMGR_FLAGOUTSTATUS0_REG);
+
+	debug("%s: F2SDRAM_SIDEBAND_FLAGOUTSTATUS0: 0x%x\n", __func__, reg);
+
+	if ((reg & mask) == SIDEBANDMGR_FLAGOUTSET0_REG_INTERLEAVING)
+		debug("%s: Interleaving bit is set\n", __func__);
+	else if ((reg & mask) == SIDEBANDMGR_FLAGOUTSET0_REG_MULTICHANNEL)
+		debug("%s: Multichannel bit is set\n", __func__);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+bool hps_ocram_dbe_status(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_OCRAM_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+bool ddr_ecc_dbe_status(void)
+{
+	u32 reg = readl(socfpga_get_sysmgr_addr() +
+			SYSMGR_SOC64_BOOT_SCRATCH_COLD8);
+
+	if (reg & ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK)
+		return true;
+
+	return false;
+}
+
+int sdram_mmr_init_full(struct udevice *dev)
+{
+	int i, ret = 0;
+	struct altera_sdram_plat *plat = dev_get_plat(dev);
+	struct altera_sdram_priv *priv = dev_get_priv(dev);
+	struct io96b_info *io96b_ctrl = malloc(sizeof(*io96b_ctrl));
+	struct uib_info *uib_ctrl = malloc(sizeof(*uib_ctrl));
+	struct bd_info bd = {0};
+	bool full_mem_init = false, is_ddr_hang_be4_rst = false;
+	phys_size_t hw_size;
+	u32 reg = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_BOOT_SCRATCH_COLD0);
+	enum reset_type reset_t = get_reset_type(reg);
+
+	/* Populating DDR handoff data */
+	debug("DDR: Populating DDR handoff\n");
+
+	ret = populate_ddr_handoff(dev, io96b_ctrl, uib_ctrl);
+	if (ret) {
+		printf("DDR: Failed to populate DDR handoff\n");
+
+		goto err;
+	}
+
+	debug("%s: Address MPFE 0x%llx\n", memory_type_in_use(dev), plat->mpfe_base_addr);
+
+	/* DDR initialization progress status tracking */
+	is_ddr_hang_be4_rst = is_ddr_init_hang();
+
+	printf("%s: SDRAM init in progress ...\n", memory_type_in_use(dev));
+
+	ddr_init_inprogress(true);
+
+	/* Configuring MPFE sideband manager registers - multichannel or interleaving*/
+	debug("%s: MPFE configuration in progress ...\n", memory_type_in_use(dev));
+
+	ret = config_mpfe_sideband_mgr(dev);
+	if (ret) {
+		printf("%s: Failed to configure multichannel/interleaving mode\n",
+		       memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	debug("%s: MPFE configuration completed\n", memory_type_in_use(dev));
+
+	debug("%s: Waiting for NOCPLL locked ...\n", memory_type_in_use(dev));
+
+	/* Ensure NOCPLL locked */
+	ret = wait_for_bit_le32((const void *)socfpga_get_sysmgr_addr() + SYSMGR_HMC_CLK
+				, SYSMGR_HMC_CLK_NOCPLL, true, TIMEOUT, false);
+	if (ret) {
+		printf("%s: NOCPLL is not locked\n", memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	debug("%s: NOCPLL locked\n", memory_type_in_use(dev));
+
+	debug("%s: Checking calibration...\n", memory_type_in_use(dev));
+
+	if (is_ddr_in_use(dev)) {
+		/* Configure if polling is needed for IO96B GEN PLL locked */
+		io96b_ctrl->ckgen_lock = false;
+
+		/* Ensure calibration status passing */
+		init_mem_cal(io96b_ctrl);
+
+		printf("DDR: Calibration success\n");
+
+		/* Initiate IOSSM mailbox */
+		io96b_mb_init(io96b_ctrl);
+
+		/* DDR type */
+		ret = get_mem_technology(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR type\n");
+
+			goto err;
+		}
+
+		/* DDR size */
+		ret = get_mem_width_info(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR size\n");
+
+			goto err;
+		}
+	} else {
+		/* Ensure calibration status passing */
+		uib_init_mem_cal(uib_ctrl);
+
+		/* Need to trigger re-calibration for HBM DBE */
+		if (ddr_ecc_dbe_status()) {
+			for (i = 0; i < uib_ctrl->num_instance; i++)
+				uib_ctrl->uib[i].cal_status = false;
+
+			uib_ctrl->overall_cal_status = false;
+		}
+
+		/* Trigger re-calibration if calibration failed */
+		if (!(uib_ctrl->overall_cal_status)) {
+			printf("HBM: Re-calibration in progress...\n");
+
+			uib_trig_mem_cal(uib_ctrl);
+		}
+
+		if (!(uib_ctrl->overall_cal_status)) {
+			printf("HBM: Retry calibration failed & not able to re-calibrate\n");
+
+			ret = -EINVAL;
+			goto err;
+		}
+
+		debug("HBM: Setting Error Mask Register\n");
+
+		/* Responder Error Mask Register */
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+					UIB_R_ERRMSK_PSEUDO_CH0_OFFSET,
+					UIB_DRAM_SBE_MSK | UIB_INTERNAL_CORR_ERR_MSK,
+					UIB_DRAM_SBE(0x1) | UIB_INTERNAL_CORR_ERR(0x1));
+
+			debug("HBM: Error Mask Pseudo CH0 addr: 0x%llx\n",
+			      uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH0_OFFSET);
+
+			debug("HBM: Error Mask Pseudo CH0 value: 0x%x\n",
+			      readl(uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH0_OFFSET));
+
+			clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+					UIB_R_ERRMSK_PSEUDO_CH1_OFFSET,
+					UIB_DRAM_SBE_MSK | UIB_INTERNAL_CORR_ERR_MSK,
+					UIB_DRAM_SBE(0x1) | UIB_INTERNAL_CORR_ERR(0x1));
+
+			debug("HBM: Error Mask Pseudo CH1 addr: 0x%llx\n",
+			      uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH1_OFFSET);
+
+			debug("HBM: Error Mask Pseudo CH1 value: 0x%x\n\n",
+			      readl(uib_ctrl->uib[i].uib_csr_addr +
+			      UIB_R_ERRMSK_PSEUDO_CH1_OFFSET));
+		}
+
+		printf("HBM: Calibration success\n");
+	}
+
+	/* Get bank configuration from devicetree */
+	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
+				     (phys_size_t *)&gd->ram_size, &bd);
+	if (ret) {
+		printf("%s: Failed to decode memory node\n", memory_type_in_use(dev));
+
+		goto err;
+	}
+
+	if (!is_ddr_in_use(dev)) {
+		hw_size = uib_ctrl->overall_size;
+	} else {
+		/* ECC status */
+		ret = ecc_enable_status(io96b_ctrl);
+		if (ret) {
+			printf("DDR: Failed to get DDR ECC status\n");
+
+			goto err;
+		}
+
+		hw_size = io96b_ctrl->overall_size;
+
+		if (io96b_ctrl->inline_ecc)
+			hw_size = CALC_INLINE_ECC_HW_SIZE(hw_size);
+	}
+
+	if (gd->ram_size != hw_size) {
+		printf("%s: Warning: DRAM size from device tree (%lld MiB)\n",
+		       memory_type_in_use(dev), gd->ram_size >> 20);
+		printf(" mismatch with hardware (%lld MiB).\n",
+		       hw_size >> 20);
+	}
+
+	if (gd->ram_size > hw_size) {
+		printf("%s: Error: DRAM size from device tree is greater\n",
+		       memory_type_in_use(dev));
+		printf(" than hardware size.\n");
+
+		hang();
+	}
+
+	printf("%s: %lld MiB\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"),
+	       gd->ram_size >> 20);
+
+	if (is_ddr_in_use(dev)) {
+		/*
+		 * Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
+		 * enabled to preserve memory content
+		 */
+		if (io96b_ctrl->ecc_status) {
+			if (ecc_interrupt_status(io96b_ctrl)) {
+				if (CONFIG_IS_ENABLED(WDT)) {
+					struct udevice *wdt;
+
+					printf("DDR: ECC error recover start now\n");
+					ret = uclass_first_device_err(UCLASS_WDT, &wdt);
+					if (ret) {
+						printf("DDR: Failed to trigger watchdog reset\n");
+						hang();
+					}
+
+					wdt_expire_now(wdt, 0);
+				}
+				hang();
+			}
+
+			full_mem_init = hps_ocram_dbe_status() | is_ddr_hang_be4_rst;
+			if (full_mem_init || !(reset_t == WARM_RESET || reset_t == COLD_RESET)) {
+				debug("%s: Needed to fully initialize DDR memory\n",
+				      io96b_ctrl->ddr_type);
+
+				ret = bist_mem_init_start(io96b_ctrl);
+				if (ret) {
+					printf("%s: Failed to fully initialize DDR memory\n",
+					       io96b_ctrl->ddr_type);
+
+					goto err;
+				}
+			}
+		}
+	} else {
+		debug("HBM: ECC enable status: %d\n", uib_ctrl->ecc_status);
+
+		/*
+		 * Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
+		 * enabled to preserve memory content
+		 */
+		if (uib_ctrl->ecc_status) {
+			full_mem_init = hps_ocram_dbe_status() | ddr_ecc_dbe_status() |
+					is_ddr_hang_be4_rst;
+			if (full_mem_init || !(reset_t == WARM_RESET || reset_t == COLD_RESET)) {
+				debug("HBM: Needed to fully initialize HBM memory\n");
+
+				ret = uib_bist_mem_init_start(uib_ctrl);
+				if (ret) {
+					printf("HBM: Failed to fully initialize HBM memory\n");
+
+					goto err;
+				}
+			}
+		}
+	}
+
+	/* Ensure sanity memory test passing */
+	sdram_size_check(&bd);
+	printf("%s: size check success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+	sdram_set_firewall(&bd);
+
+	printf("%s: firewall init success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+	priv->info.base = bd.bi_dram[0].start;
+	priv->info.size = gd->ram_size;
+
+	/* Ending DDR driver initialization success tracking */
+	ddr_init_inprogress(false);
+
+	printf("%s init success\n", (is_ddr_in_use(dev) ? io96b_ctrl->ddr_type : "HBM"));
+
+err:
+	free(io96b_ctrl);
+	free(uib_ctrl);
+
+	return ret;
+}
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 27fbe80ed41..81cb79f35a9 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -29,7 +29,7 @@
 
 #define PGTABLE_OFF	0x4000
 
-#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#if !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) && !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 u32 hmc_readl(struct altera_sdram_plat *plat, u32 reg)
 {
 	return readl(plat->iomhc + reg);
@@ -398,7 +398,7 @@ static int altera_sdram_of_to_plat(struct udevice *dev)
 	/* These regs info are part of DDR handoff in bitstream */
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
 	return 0;
-#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 	addr = dev_read_addr_index(dev, 0);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
@@ -467,6 +467,7 @@ static const struct udevice_id altera_sdram_ids[] = {
 	{ .compatible = "intel,sdr-ctl-agilex" },
 	{ .compatible = "intel,sdr-ctl-n5x" },
 	{ .compatible = "intel,sdr-ctl-agilex5" },
+	{ .compatible = "intel,sdr-ctl-agilex7m" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 4c1205b63b6..6783deadc26 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -21,6 +21,17 @@ struct altera_sdram_plat {
 	bool dualport;
 	bool dualemif;
 };
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+enum memory_type {
+	DDR_MEMORY = 0,
+	HBM_MEMORY
+};
+
+struct altera_sdram_plat {
+	fdt_addr_t mpfe_base_addr;
+	bool multichannel_interleaving;
+	enum memory_type mem_type;
+};
 #else
 struct altera_sdram_plat {
 	void __iomem *hmc;
-- 
2.35.3

