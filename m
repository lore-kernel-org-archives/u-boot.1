Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3FACDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5B784A85;
	Tue, 23 Jun 2026 08:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Imbmntv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0A1849CE; Tue, 23 Jun 2026 04:03:07 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7193E849E0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv3yigsmosSv9sj/P+F587wbBpL9l1Bq//mcYPVNknLJ5Psr73PDAgWhMHeDnxOzPaXmaMzbFHpkgDo4m2DfE7cAT9q4L/EGV78yNmgDba8VGrm3efE9cxyNlKXkVoJrrjnXRl9CXunTefrEQjxtjnJGNADq1E8wP966aXkVqdF0nIV4O43VtoZVkNGokNZxUArDqDhQ78okkUs5Op8XozdX7Yxt466OgxXHLpwxpF+Ypt8YCunZymUkqIkohru+C44kycxUyhqo1301GT4ZdDnPAi/gRkqz4GxUpR/Y/IpK9KCU67Dnyzo69K6j5qK47DgL61/iJvPcrkAJr0/kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51rltmWSoB6k0po/7VpHlUehTGKroMNm1jGlTpctvAQ=;
 b=MeUQE67hyHwexNfNOodyf0TQcCSCyX/m5Yt4V6mEKu/Gs6c9lvPAGaf3F1dxUHtxPR27J0pc5HLSUXc6Eu2wlYJlWRexvNKDU+aR29+Uo5xbRDpNnx/fEDu+gXxAS6+aU6u6gpHwrQuX5A3MpMS5DAUSHiO2sQwZg61FHDU/dBPfFWrKgn5mHA/CFiyDjrIsiFcZUCKOGoTSbO0rHU24CgyWocuYXWNNdmysB7GmlPIEN0Xsyxvl8LO1us9XRydOl4OlzDd6HsUslCTTCNa2asp7mG1EoBTN9z00ksYIG84kqV2vYbiK5TFfK5PmFrp29CZ9gZ4g0vW0pzlVlQMfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51rltmWSoB6k0po/7VpHlUehTGKroMNm1jGlTpctvAQ=;
 b=Imbmntv10MQksHyQhJR0w8NvVLxQk9V1c5/v6Z6GwyGKBzUbqSR5JN95XY++YHtGxfpZDKGXxgtmLHqqwzyG+zXRkoeH6TRLm8nPiPmN1qAeCXHoOcC3nhEcbGM9Fte89hGKHSH3Wa81K1h7u+YBufMl9Cq4VYqHBdqQNBlg6w+6XEI099rsTkB/82XEFEaTn1hlttqxo+cqAOvLR4kBM/yXRM4h6tX7UO8doRXWFpvh2B9Zhx2uCopgNK61p5lZRCe48qGuSNnoyy8MN87pTjlyDu0hfnVASRaRYbJWS9TZDtgQercO05iktJ9w2UeHHvEdpuXAijb+CYCtxtm+uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:03:03 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:03:03 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v4 5/7] arm: socfpga: n5x: switch firewall setup to driver
 model
Date: Tue, 23 Jun 2026 10:02:19 +0800
Message-ID: <20260623020221.32362-6-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcd99ad-c17d-4a32-f2a7-08ded0cb8e9a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: w1gmUoQ+/rlXKb6wm4VgCabIzLL5eonjaGk6ENjduoAJoaClEPofbJnBJQGUF0dLIHLBz5FIkbOrWEWjJpSF4MUBsp+92gic3Az8NbzuoeX1CvFyw5hqBFoFor68MG1xl+bX0SWAWxctV50KjdVLzVVSr6XZUeAL/+CTyKflkTGM2J8H3QpTAK/kZfYn+kOpburi/AVi3rpHrmvQbJ/uvcRSdzJAYY8FUpidRdLWcnHBoQ5S/3hq8PYtLrV37INF6ZhpElEdQoktExgKxuNenHZh21ZCIvL0HYmbMnTrX0avjTpA4C2otg9aB2kxXKmKysnctx8AjOMwprU0kubk1kz1rr6fw0t/m9BchumNZxxr7qXQnCPkL7Saf0onLMRsQldI4V1JSa/sl3jITiC90eK0jfMvAbXFwRvrT/hIQsWonmpn7eKVRdzVqKVtNB3GmmTHdsnoT5LDeKlghWvrxMNc4lnR/5nwstI/E+bXw8VOs7SYpWNOQYsksD7DN0tMjU7HyRRceV57ipAFpL0rFrmBjuR59IzvNUrBO2aBAkyUwVEq+2aV3jxZatx+0t5r01qBzJfJ/MZ5y8AzoNDhitlcu5ZLnBqPh+GiLmG2FzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlrMz7jsWuH+5/L1ohzzCuph0SA6Q2m9zioHH+X93Tdlt2DfSXHpZ6sDSEPX?=
 =?us-ascii?Q?J+5rLURtgHrMu/3oYkAObqRfSKmz9IHIgdQenrwOo5eFm0fpLl62+LUIRogW?=
 =?us-ascii?Q?7ck3VrO/oPnG70L8hwNuk8SARR2RghFXKojoNvn8GuMbjcbwqyhkbOO4OiTt?=
 =?us-ascii?Q?6NVZOHc1bEtYPNdJgRfHBZNZvu5fBNhPWL1to+dSGtL6yGhrw45LvXo+TkhK?=
 =?us-ascii?Q?W5uSkRgfarsWIZBZ3J6V0S3FSYjvS7IxHwsFJ0y8noJF+8AJkX8VDfLytFiw?=
 =?us-ascii?Q?vc3/XF2Fc276NCCn0KoCXT3o2jrfm4lkILN+KW9Cum/XJV9ziJ0WpZyO79vs?=
 =?us-ascii?Q?UgdE077xnwyRDHdr5UHbKmJfXN38wIrTGA5yKr/9EkZWDQQJiWNDHUITzDxD?=
 =?us-ascii?Q?NB3jAUd/LKU0gHrm5mPrV1mkPWDBoXEmZsPUj0o+HxxmagAYXBno0ABE5L1B?=
 =?us-ascii?Q?AwejNx7HjWNwiyUjSidUxbt6n3yQgeItKmclvXOn0xxGalwMgfvR495LhWDK?=
 =?us-ascii?Q?tN3pbqPqUoWf6PRzGbZu+pT90XwK6o0qisAKHqOnsjQHHINeBO+UBer+O2me?=
 =?us-ascii?Q?M4peCmsVXL6jH4D2tptLkrjmmn9pR9Dm5hgj59AUXrssf7mfiunrwAbS/ZP/?=
 =?us-ascii?Q?d/VIi9GoHAomCyE/6yjnf1cM1Mo/WUPGgcVnPG1CN/ZTJ0uygGr1C7YyJG7Q?=
 =?us-ascii?Q?LRq26WWSmdWo2h8Mb6GJ+YolGOrYpsKqrbHc+VxY9af76Y8YccVpP2VtrpB8?=
 =?us-ascii?Q?CBon5uN8T2Fw8aVVB+LuTdU4ODDHSUBXyPkoejRIipSVi9OsCCqTWtJKX6zY?=
 =?us-ascii?Q?NJORQ2wgi90udE3F2XzG7iMW5Aje7cQUQkJupg/PY7EYRUMLDd5CDJ8d3IsQ?=
 =?us-ascii?Q?wYMt0TbNdRNzd+KLEcQ71m8iBRWrLOloCdO8REDbY9+Qn8Y2VUYY3/Nhb0Yt?=
 =?us-ascii?Q?C5toepToTksJPCKP3ejcFJuMiY5vbziFoU/lTpFz2lTX0m7Pv4onxcU8YlOK?=
 =?us-ascii?Q?J+3+xSln1rtN0p6Bc0FMo9ptA2qG7xzlVh/DDxfL+F8ppte6W6Iwm+V2C4Bk?=
 =?us-ascii?Q?/5qXiyxwctmFfkvmAGXx8NzwdDyat+TGvWWo1BfdzsMr+jGjGib/VqGuOQrN?=
 =?us-ascii?Q?MOasIXgA1RLFlUgGuyU0mruXkcctarmvv07AkekT2UzfrMrA4VgzyR0keFNR?=
 =?us-ascii?Q?bXpH0yHs8tjYrxX+UwHYZ8gucWJ+Q3oz1r4+I5r1eHdlBTskCStjU++IMXtp?=
 =?us-ascii?Q?NsPOTRaQP27nQTJi1Z0LdUVv6HCIuk3QscVYbZ4l9HYUch2CMUTb6iXT50RI?=
 =?us-ascii?Q?1vQuE7hQDcrOhcOdSY7yq2FekUc9a6T83opLkwz2jtjLDDrB59zVATlUIM2M?=
 =?us-ascii?Q?70WXrFw5DRkfxR6aw98jCxlA24Rfy/9MHuiKmJbEYQt1eZpOorxR/c6+7QKK?=
 =?us-ascii?Q?EhOB0aISYE3EhfsDlvv09Qw211IQwtX9cv1btglV6QtCspyxvESka4h4pqIl?=
 =?us-ascii?Q?Br/rCSVnIcZavzLn0M3rhVrIxyEVBA7Xu8Svmj146M+MczPNZ/BbRWs+zEvw?=
 =?us-ascii?Q?NBoh7JpMDw6wVbm82d9+HqhZpvA1VgJRqSKT7qh+o832m4fSwiNaOdCs3zjf?=
 =?us-ascii?Q?LosGSpI7JtFGIAH7WuvL8ixAtNjaZzuThRn3RtEsiKBDfC6HYU90pLRuBXol?=
 =?us-ascii?Q?4P2YOFaYbehxz/1k6ZYa17d2DrbBfCFIGuyn36TAsKSuLwBxkAwrHlsxjPUr?=
 =?us-ascii?Q?knw4+R4KZlx3D79yrOccN9SCGhbEsio=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd99ad-c17d-4a32-f2a7-08ded0cb8e9a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:03:02.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRVoyt8emX+xhguKcQ2UVEosarEIDpPeV9ZmwgwVYR7cbwxO7690xiTLHv56xm+u/CnbN/B2r8JG32agd9fg5Gs32cbeetCi3CU/Js3X/s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Move the system manager and L3 interconnect firewall configuration from
a dedicated firewall_setup() function to the driver model, using
uclass_get_device_by_name(). This removes hardcoded firewall setup in
SPL and relies on the driver model, making the code more maintainable
and aligned with upstream practices.

With spl_n5x.c migrated, no in-tree SoC64 SPL file calls
firewall_setup() directly any longer. Remove the function and its
private helpers from firewall.c, drop firewall.c from the Makefile,
remove the now-unused declaration from firewall.h, and drop the stale
firewall.h include from spl_n5x.c.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Extend to fully remove the now-dead firewall_setup() implementation:
  delete arch/arm/mach-socfpga/firewall.c, remove firewall.o from
  Makefile, remove the void firewall_setup(void) declaration from
  firewall.h, drop the now-unused struct socfpga_firwall_l4_per,
  socfpga_firwall_l4_sys, FIREWALL_L4_DISABLE_ALL, and
  FIREWALL_BRIDGE_DISABLE_ALL from firewall.h, remove stale
  #include <asm/arch/firewall.h> from spl_n5x.c

 arch/arm/mach-socfpga/Makefile                |   1 -
 arch/arm/mach-socfpga/firewall.c              | 107 ------------------
 arch/arm/mach-socfpga/include/mach/firewall.h |  69 -----------
 arch/arm/mach-socfpga/spl_n5x.c               |  13 ++-
 4 files changed, 11 insertions(+), 179 deletions(-)
 delete mode 100644 arch/arm/mach-socfpga/firewall.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 962dce67c64..5e57d23657c 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -114,7 +114,6 @@ obj-y	+= wrap_pinmux_config.o
 obj-y	+= wrap_sdram_config.o
 endif
 ifdef CONFIG_ARCH_SOCFPGA_SOC64
-obj-y	+= firewall.o
 obj-y	+= spl_soc64.o
 endif
 ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
diff --git a/arch/arm/mach-socfpga/firewall.c b/arch/arm/mach-socfpga/firewall.c
deleted file mode 100644
index 4dec47b8e96..00000000000
--- a/arch/arm/mach-socfpga/firewall.c
+++ /dev/null
@@ -1,107 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
- *
- */
-
-#include <mach/base_addr_soc64.h>
-#include <asm/io.h>
-#include <asm/arch/firewall.h>
-#include <asm/arch/system_manager.h>
-
-static void firewall_l4_per_disable(void)
-{
-	const struct socfpga_firwall_l4_per *firwall_l4_per_base =
-		(struct socfpga_firwall_l4_per *)SOCFPGA_FIREWALL_L4_PER;
-	u32 i;
-	const u32 *addr[] = {
-			&firwall_l4_per_base->nand,
-			&firwall_l4_per_base->nand_data,
-			&firwall_l4_per_base->usb0,
-			&firwall_l4_per_base->usb1,
-			&firwall_l4_per_base->spim0,
-			&firwall_l4_per_base->spim1,
-			&firwall_l4_per_base->emac0,
-			&firwall_l4_per_base->emac1,
-			&firwall_l4_per_base->emac2,
-			&firwall_l4_per_base->sdmmc,
-			&firwall_l4_per_base->gpio0,
-			&firwall_l4_per_base->gpio1,
-			&firwall_l4_per_base->i2c0,
-			&firwall_l4_per_base->i2c1,
-			&firwall_l4_per_base->i2c2,
-			&firwall_l4_per_base->i2c3,
-			&firwall_l4_per_base->i2c4,
-			&firwall_l4_per_base->timer0,
-			&firwall_l4_per_base->timer1,
-			&firwall_l4_per_base->uart0,
-			&firwall_l4_per_base->uart1
-			};
-
-	/*
-	 * The following lines of code will enable non-secure access
-	 * to nand, usb, spi, emac, sdmmc, gpio, i2c, timers and uart. This
-	 * is needed as most OS run in non-secure mode. Thus we need to
-	 * enable non-secure access to these peripherals in order for the
-	 * OS to use these peripherals.
-	 */
-	for (i = 0; i < ARRAY_SIZE(addr); i++)
-		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
-}
-
-static void firewall_l4_sys_disable(void)
-{
-	const struct socfpga_firwall_l4_sys *firwall_l4_sys_base =
-		(struct socfpga_firwall_l4_sys *)SOCFPGA_FIREWALL_L4_SYS;
-	u32 i;
-	const u32 *addr[] = {
-			&firwall_l4_sys_base->dma_ecc,
-			&firwall_l4_sys_base->emac0rx_ecc,
-			&firwall_l4_sys_base->emac0tx_ecc,
-			&firwall_l4_sys_base->emac1rx_ecc,
-			&firwall_l4_sys_base->emac1tx_ecc,
-			&firwall_l4_sys_base->emac2rx_ecc,
-			&firwall_l4_sys_base->emac2tx_ecc,
-			&firwall_l4_sys_base->nand_ecc,
-			&firwall_l4_sys_base->nand_read_ecc,
-			&firwall_l4_sys_base->nand_write_ecc,
-			&firwall_l4_sys_base->ocram_ecc,
-			&firwall_l4_sys_base->sdmmc_ecc,
-			&firwall_l4_sys_base->usb0_ecc,
-			&firwall_l4_sys_base->usb1_ecc,
-			&firwall_l4_sys_base->clock_manager,
-			&firwall_l4_sys_base->io_manager,
-			&firwall_l4_sys_base->reset_manager,
-			&firwall_l4_sys_base->system_manager,
-			&firwall_l4_sys_base->watchdog0,
-			&firwall_l4_sys_base->watchdog1,
-			&firwall_l4_sys_base->watchdog2,
-			&firwall_l4_sys_base->watchdog3
-		};
-
-	for (i = 0; i < ARRAY_SIZE(addr); i++)
-		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
-}
-
-static void firewall_bridge_disable(void)
-{
-	/* disable lwsocf2fpga and soc2fpga bridge security */
-	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_SOC2FPGA);
-	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_LWSOC2FPGA);
-}
-
-void firewall_setup(void)
-{
-	firewall_l4_per_disable();
-	firewall_l4_sys_disable();
-	firewall_bridge_disable();
-
-	/* disable SMMU security */
-	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU);
-
-	/* enable non-secure interface to DMA330 DMA and peripherals */
-	writel(SYSMGR_DMA_IRQ_NS | SYSMGR_DMA_MGR_NS,
-	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA);
-	writel(SYSMGR_DMAPERIPH_ALL_NS,
-	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA_PERIPH);
-}
diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
index b47b577ae75..8f3b7d90ad1 100644
--- a/arch/arm/mach-socfpga/include/mach/firewall.h
+++ b/arch/arm/mach-socfpga/include/mach/firewall.h
@@ -10,73 +10,6 @@
 
 #include <linux/bitops.h>
 
-struct socfpga_firwall_l4_per {
-	u32	nand;		/* 0x00 */
-	u32	nand_data;
-	u32	_pad_0x8;
-	u32	usb0;
-	u32	usb1;		/* 0x10 */
-	u32	_pad_0x14;
-	u32	_pad_0x18;
-	u32	spim0;
-	u32	spim1;		/* 0x20 */
-	u32	spis0;
-	u32	spis1;
-	u32	emac0;
-	u32	emac1;		/* 0x30 */
-	u32	emac2;
-	u32	_pad_0x38;
-	u32	_pad_0x3c;
-	u32	sdmmc;		/* 0x40 */
-	u32	gpio0;
-	u32	gpio1;
-	u32	_pad_0x4c;
-	u32	i2c0;		/* 0x50 */
-	u32	i2c1;
-	u32	i2c2;
-	u32	i2c3;
-	u32	i2c4;		/* 0x60 */
-	u32	timer0;
-	u32	timer1;
-	u32	uart0;
-	u32	uart1;		/* 0x70 */
-};
-
-struct socfpga_firwall_l4_sys {
-	u32	_pad_0x00;		/* 0x00 */
-	u32	_pad_0x04;
-	u32	dma_ecc;
-	u32	emac0rx_ecc;
-	u32	emac0tx_ecc;		/* 0x10 */
-	u32	emac1rx_ecc;
-	u32	emac1tx_ecc;
-	u32	emac2rx_ecc;
-	u32	emac2tx_ecc;		/* 0x20 */
-	u32	_pad_0x24;
-	u32	_pad_0x28;
-	u32	nand_ecc;
-	u32	nand_read_ecc;		/* 0x30 */
-	u32	nand_write_ecc;
-	u32	ocram_ecc;
-	u32	_pad_0x3c;
-	u32	sdmmc_ecc;		/* 0x40 */
-	u32	usb0_ecc;
-	u32	usb1_ecc;
-	u32	clock_manager;
-	u32	_pad_0x50;		/* 0x50 */
-	u32	io_manager;
-	u32	reset_manager;
-	u32	system_manager;
-	u32	osc0_timer;		/* 0x60 */
-	u32	osc1_timer;
-	u32	watchdog0;
-	u32	watchdog1;
-	u32	watchdog2;		/* 0x70 */
-	u32	watchdog3;
-};
-
-#define FIREWALL_L4_DISABLE_ALL		(BIT(0) | BIT(24) | BIT(16))
-#define FIREWALL_BRIDGE_DISABLE_ALL	(~0)
 
 /* Cache coherency unit (CCU) registers */
 #define CCU_CPU0_MPRT_ADBASE_DDRREG		0x4400
@@ -149,6 +82,4 @@ struct socfpga_firwall_l4_sys {
 	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
 #endif
 
-void firewall_setup(void);
-
 #endif /* _FIREWALL_H_ */
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a49be837921..0a8dd6d0fee 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -5,7 +5,6 @@
  */
 
 #include <asm/arch/clock_manager.h>
-#include <asm/arch/firewall.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
@@ -69,7 +68,17 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
-- 
2.43.7

