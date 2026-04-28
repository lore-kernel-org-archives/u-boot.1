Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0344FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78849843C6;
	Tue, 28 Apr 2026 05:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XDmJJ2s0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B921842EF; Tue, 28 Apr 2026 05:48:45 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0779084329
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENZ+b5aF5uG7AQNdDRgB4g/e7NElkeoHIalgQ8B+jRAus1hLhV8V5urj0GNQ7/yV4jpUeQsYne2mSxzJvUQZAxLdjOV/aj98m7EY8OktWvzp1UBMp4Wf3B+FAb4PnV2o1EBgKs9G6ruF4cXdDR06levARZVxjuH20fCMsihX+cDu22nPqgZy276WnRjBvpT9EK4xI0dDttk5M8A7/WsRvpjtuYcJPWjkcY14ZTIvDomMRUOmKzlQ9JVe8cmwMZt8etR/zEasFwDafpBq/KcTnxM/23W+U2/FQPGM1mx2i/Cbs0r0orO0fLH8DfHq+rnQG+QfrVhymgtL40c+XzThqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss0SQzQHUlnTPBM7n1Uuq+q6I80zslruQVE+LelqRoU=;
 b=puO9kqehYdiP2bVhdVWP2tVVr7qKBm+H6J+YrlL58VEuMnEIpwWhaaEgyau9ySc+HgzeplKvDZyl5WiOG15IaIp22N34vBOKOtqxSm/K7utF1njKCddU2fdW0av3V0B+5iZrOKmuPJBvhyX5LZbq5HVBu06MrRZSCDOMl+kPdaXhJjpBWWt4ixTBH6Fel/oUCe5IEA57tyFuAomy/PsTnfaV4byC98P9Yyu655ZvwTLqGg0YQxCzDq/xjBDn9M/ej9pKOsUZSuuh8QgQ2A3475NoKszgizbFY2CyAZYPtbqnnLnl7Z/44Ik7efFpQFR3eTgh/yr+CUMVVnPbxz0Fig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss0SQzQHUlnTPBM7n1Uuq+q6I80zslruQVE+LelqRoU=;
 b=XDmJJ2s0UCVJWIma0DbgOU0+cXE5ZcYwoPiQYwm7mjsMOFUsZhqYDmBu/IobYD1N3I5fi/bdWKpYKsbRGM5oQHK2P9K530TkVQV+34jFbHkZ8zXLyuSBwV9MufrAXHGAP95BfU3yYMgOugYS0SubUOdtcz95w9hwkWeA+DNgIb8uMydJ7KQZvK//G+2C7YHx6CHXv/c2KBgqzF1ZHxjPTYBWEj94iB8IHCb7c9oJk//8QeIQhg6voYPSMoYQ8MaAB+SgZTL5OsVnSnGWilHCBoJhCnrWSGXNHdBoO2rB1qMOStUa/oMDSy5NtHg+MbP7gAxQCT/pc+obGtWODLPqww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7403.namprd03.prod.outlook.com (2603:10b6:a03:55a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:48:38 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:48:37 +0000
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
Subject: [PATCH v2 7/9] clk: s10: Refactor S10 clock driver
Date: Mon, 27 Apr 2026 20:48:20 -0700
Message-ID: <20260428034822.23756-8-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 131cd752-475f-4275-e551-08dea4d9074a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: YwmrwXkg23fOSTK9Wln9O8X9U7i5PiD4U5ZS9iWBEmdj4gyV3PsziQg/XntterGykcoHsrsT6z5DkkBtFVyyyGoRB+OlocAM8jxUXYtGItt5QGuczllRVus/0e5b7yYNrN9PUE6EjPEVH5rJBUNk10xKvWF7Ch37Pi7AfHGiUFZ1VI3XxclqXKO2pTW2oIQ16qdha6qVvnSVpv5yBAVKbfDoebZ9lSv3lweNvdhj0271xnkuSJHYTCLzd0BkFnk1j/7zVUjxZF3RMeqhWaHYitZqL0Wg7JO9PE/K42MY9YQJATKkcM2/RCm9+rk0nT+ZD6TnH3bjhYrrj9nwfb7gTuTOz380f3MNK4YfWp++Z0vxB3lPpJhVJGFlHYF+PnADEOrSdwLNluaqOrzf2NHnTZnAvp3E5BQsIx2CTv8LZ87edhogmSpIdXJ6ZU8EFTu8BAJhVdGVUpYKxy5Rv1wcdeq3/NUaeY0zT+vm9oZQNJK17JUikzPac4xE/RJWFlGL/y7WfCARqqUbPzqejv/OJ4gkffI0U/DWEfzWUG7lW901aYeZ1jcX7XlTIxRgFJ3CMYntFwKzyb+9yMmPX3e7JdW4+DgKEi+t2tHHrHOvyHciYJmnHgV1LJHAyTg8Orz81PUOsu7yk+Cm/+JO0ndibGPRXGoE69e8biv4Yk4EFdPwYr3v7XuAZhX80kP0UhWs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MdRKOJUMhuOiy+4izlWbFTVj39q32+vtsbWyzDTX9Aca1bjXJpHeEfpyG/i?=
 =?us-ascii?Q?Yv8bOyUb69Ow7QZS9mHjFz5HXPY1X6KncjAb5YEEIrugo3KQa0d4SksDTmzA?=
 =?us-ascii?Q?5Vv4oLIfIambCpcxDJYN8kAclKQxX4mbjWNphbQFeJZO+tf2pYdpPG3lXoHy?=
 =?us-ascii?Q?PI/rfJrI+Acenkx0V6O/B2YaRF7KHJJ0QRjQSKUyTgh6fv1s8bb+T+6P/3Gy?=
 =?us-ascii?Q?PGdGqOR4HvT4MV+snCTHLIMzmQV9BueP8x3JQRPs18no9Up8b1w0BX6Ga8ay?=
 =?us-ascii?Q?PwlN2IKTc3yNkk+Qt320V9zDbst//aJhDe9GTtoAk0jtI2X3gnggLCqqXfXd?=
 =?us-ascii?Q?+pkUcODKie1+OaxDf1czT/mdfpSjC+KF+Zp1U3snUxRxDy3hWLkbmD71KAzv?=
 =?us-ascii?Q?oMfQJ2VLH4o2TudEWcfN+zCJLrlV6rVouCYKosz8hyP/q7+6vjsW4cMuUxrU?=
 =?us-ascii?Q?3YSb3XLGIUFgalYUf0s+T0RGEMrKEVF2+BMOOlj488Sm2oSuYUyx53YAm/UL?=
 =?us-ascii?Q?oidtymYW+uWc68obxenNfQIlPwfJEcyj8ZgF+GbQ8kDrBAM68qnXy+yBzTR3?=
 =?us-ascii?Q?Y/EIqiTo+BrMh7U7iRPtwzAxhiSElngMMkQeML67Ji9s8RLjKIAN7VME/RrM?=
 =?us-ascii?Q?3Wtq1+si7Ha8Gu+oreuUGYnCx8tZHmk8WSu5wZapBJkcuy7sYsVMN8adfkMi?=
 =?us-ascii?Q?BWbGhg8its5f6KzmbARCtqgG4EaOi00sn7Httleo6pUYz+oXBWcwU8wdx7cH?=
 =?us-ascii?Q?pwxBJBnW9aKXwUiHF1LRLiFcuOs5SuVy6agG8BNYLoN15IocMONl+JsBtgBr?=
 =?us-ascii?Q?p6qGDUjr5KS6Lg+RwX7x7Wx95fwxqDgldgbqvISw4qN4+XDIvxadmIzS0+ee?=
 =?us-ascii?Q?oeIC8sKdMs/JFxI9tbLw0R3G+j+2ktUMThcVQ4z6dzAddxkftFmteMDS+/a8?=
 =?us-ascii?Q?QVY/Z74b2RceFpeN2CEMYvhL+n2hobBTWA82s4qneTpVLcmttCsqCfSpHO7q?=
 =?us-ascii?Q?pWSnRbQnKoJNBsD2my/72C0yp6jBYPLJ3Oalg1anLmYIebqx1zUJFOhgiX1X?=
 =?us-ascii?Q?xKhoMSSAMHpPKC92FHNRwYi8rwFFnAdCHYq/5BZco5xrtDfaSpyPVP3uzu9c?=
 =?us-ascii?Q?ZBaXmSUKe/IN6effx2NJfQnSbyPegjL2W4LxOPXtmVGs72I46ZxXrB+/2aYK?=
 =?us-ascii?Q?Pa8UGNjIu2Wz5N/Ez/5T+9K3RO9zC3TdYfQrPewBtFC9qYI3/4ZSTkPvig9c?=
 =?us-ascii?Q?YBOUBCmc1KtoTougDoMGkxOetrZnyjzDqqO9MNGJ7+H5URh9reBWnEt501kw?=
 =?us-ascii?Q?WJjpJt8kZvTGFf1MICO9Ti/SHRNv5KSbLe4VEMJ0ChYYETEfeDUTlhUuuhkK?=
 =?us-ascii?Q?Lhz40E1ue5yUyAwe4skYwl7Vl+/q+OtPRWgfW4ZZxhnJiIdK+/t1BvaQZu53?=
 =?us-ascii?Q?ssub84gQbf0BMu/d2i77W6Uoa099h4QYklURgOMcClpSsIdgLFgOCM9OFqRC?=
 =?us-ascii?Q?j51z974Gi36OWQwYJID80Ifn6FVCaOMTZw9LCxp2+TB/ezcXMuLVeYjiN5Mg?=
 =?us-ascii?Q?OzqVUmN1RYWmTpz1OmD6Mo6EUhqZHWPMScU3lVTHQuVwmi/z6qLRg/9hnVP+?=
 =?us-ascii?Q?1/R7nAdnai2USvNf0KerF23ffwT8UCspP8G54KGgIMHk8a9R9K/k3t9sbzqR?=
 =?us-ascii?Q?UFHxmeNV7QX3fAsDclHK8NjBftAWiOTdSLT29r0+UJA7duidL/JFo1c1iqGZ?=
 =?us-ascii?Q?SFGvOrrQVjcwiKyVHlmp7r5wZU2EoptOeMxqQFFV30R5jdQmksvu?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131cd752-475f-4275-e551-08dea4d9074a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:48:37.4868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWts6l0acXVwJXll5XGNc+KPZCZvGCYAumDDAtKXgRYX/N+WaQU7Vcv8mvqmV6AC/d7HBavbGG+/gRVUOCKsxR5odUGKNbh48Nqsa5bk34A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7403
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

Refactor Stratix10 clock manager driver to support driver model, following
Agilex clock driver.

Create a new clock driver, clk-s10.c, for Stratix10 which supports the
driver model. This allows several APIs such as enable/disable clock, and
get clock rate to be supported.

This driver will be initialized during SPL to bring up the clock as early
as possible. The clock initialization process are refactored into this new
driver from clock_manager_s10.c during clock driver probe.

Excluding Stratix10 from legacy method of obtaining clkmgr base address in
mach-socfpga/misc.c as the base address is already obtained during clock
driver probe during SPL initialization.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 MAINTAINERS                                   |   1 +
 arch/arm/mach-socfpga/Kconfig                 |   2 +
 arch/arm/mach-socfpga/clock_manager_s10.c     | 449 ++-----------
 .../include/mach/clock_manager_s10.h          | 176 +----
 arch/arm/mach-socfpga/misc.c                  |   3 +-
 arch/arm/mach-socfpga/spl_s10.c               |   7 +-
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-s10.c                  | 603 ++++++++++++++++++
 drivers/clk/altera/clk-s10.h                  | 202 ++++++
 9 files changed, 873 insertions(+), 571 deletions(-)
 create mode 100644 drivers/clk/altera/clk-s10.c
 create mode 100644 drivers/clk/altera/clk-s10.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d1173126fc6..032f0ee97fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -159,6 +159,7 @@ F:	arch/arm/mach-socfpga/
 F:	board/altera/stratix10-socdk/
 F:	board/intel/agilex-socdk/
 F:	configs/socfpga_*
+F:	drivers/clk/altera/
 F:	drivers/ddr/altera/
 F:	drivers/power/domain/altr-pmgr-agilex5.c
 F:	drivers/sysreset/sysreset_socfpga*
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index fb98b647442..aa1f3e761cd 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -146,8 +146,10 @@ config ARCH_SOCFPGA_STRATIX10
 	select ARMV8_MULTIENTRY
 	select ARMV8_SET_SMPEN
 	select BINMAN if SPL_ATF
+	select CLK
 	select FPGA_INTEL_SDM_MAILBOX
 	select GICV2
+	select SPL_CLK if SPL
 	select ARCH_SOCFPGA_SOC64
 
 choice
diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index fd27470f967..df636f14f93 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -1,425 +1,78 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
  *
  */
 
-#include <compiler.h>
-#include <dm/device.h>
-#include <linux/errno.h>
-#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
 #include <asm/arch/clock_manager.h>
-#include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
+#include <asm/io.h>
+#include <dt-bindings/clock/stratix10-clock.h>
 
-/*
- * function to write the bypass register which requires a poll of the
- * busy bit
- */
-static void cm_write_bypass_mainpll(u32 val)
-{
-	writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_BYPASS);
-	cm_wait_for_fsm();
-}
-
-static void cm_write_bypass_perpll(u32 val)
-{
-	writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_BYPASS);
-	cm_wait_for_fsm();
-}
-
-/* function to write the ctrl register which requires a poll of the busy bit */
-static void cm_write_ctrl(u32 val)
-{
-	writel(val, socfpga_get_clkmgr_addr() + CLKMGR_S10_CTRL);
-	cm_wait_for_fsm();
-}
-
-/*
- * Setup clocks while making no assumptions about previous state of the clocks.
- */
-void cm_basic_init(const struct cm_config * const cfg)
-{
-	u32 mdiv, refclkdiv, mscnt, hscnt, vcocalib;
-
-	if (cfg == 0)
-		return;
-
-	/* Put all plls in bypass */
-	cm_write_bypass_mainpll(CLKMGR_BYPASS_MAINPLL_ALL);
-	cm_write_bypass_perpll(CLKMGR_BYPASS_PERPLL_ALL);
-
-	/* setup main PLL dividers where calculate the vcocalib value */
-	mdiv = (cfg->main_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
-		CLKMGR_FDBCK_MDIV_MASK;
-	refclkdiv = (cfg->main_pll_pllglob >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
-		     CLKMGR_PLLGLOB_REFCLKDIV_MASK;
-	mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
-	hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
-		CLKMGR_HSCNT_CONST;
-	vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
-		   ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
-		   CLKMGR_VCOCALIB_MSCNT_OFFSET);
-
-	writel((cfg->main_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
-		~CLKMGR_PLLGLOB_RST_MASK),
-		socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB);
-	writel(cfg->main_pll_fdbck,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_FDBCK);
-	writel(vcocalib,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_VCOCALIB);
-	writel(cfg->main_pll_pllc0,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLC0);
-	writel(cfg->main_pll_pllc1,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLC1);
-	writel(cfg->main_pll_nocdiv,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCDIV);
-
-	/* setup peripheral PLL dividers */
-	/* calculate the vcocalib value */
-	mdiv = (cfg->per_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
-		CLKMGR_FDBCK_MDIV_MASK;
-	refclkdiv = (cfg->per_pll_pllglob >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
-		     CLKMGR_PLLGLOB_REFCLKDIV_MASK;
-	mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
-	hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
-		CLKMGR_HSCNT_CONST;
-	vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
-		   ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
-		   CLKMGR_VCOCALIB_MSCNT_OFFSET);
-
-	writel((cfg->per_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
-		~CLKMGR_PLLGLOB_RST_MASK),
-		socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB);
-	writel(cfg->per_pll_fdbck,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_FDBCK);
-	writel(vcocalib,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_VCOCALIB);
-	writel(cfg->per_pll_pllc0,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLC0);
-	writel(cfg->per_pll_pllc1,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLC1);
-	writel(cfg->per_pll_emacctl,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_EMACCTL);
-	writel(cfg->per_pll_gpiodiv,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_GPIODIV);
-
-	/* Take both PLL out of reset and power up */
-	setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB,
-		     CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
-	setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB,
-		     CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
-
-#define LOCKED_MASK \
-	(CLKMGR_STAT_MAINPLL_LOCKED | \
-	CLKMGR_STAT_PERPLL_LOCKED)
-
-	cm_wait_for_lock(LOCKED_MASK);
-
-	/*
-	 * Dividers for C2 to C9 only init after PLLs are lock. As dividers
-	 * only take effect upon value change, we shall set a maximum value as
-	 * default value.
-	 */
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_MPUCLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCCLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR2CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR3CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR4CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR5CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR6CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR7CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR8CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR9CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR2CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR3CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR4CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR5CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR6CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR7CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR8CLK);
-	writel(0xff, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR9CLK);
-
-	writel(cfg->main_pll_mpuclk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_MPUCLK);
-	writel(cfg->main_pll_nocclk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_NOCCLK);
-	writel(cfg->main_pll_cntr2clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR2CLK);
-	writel(cfg->main_pll_cntr3clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR3CLK);
-	writel(cfg->main_pll_cntr4clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR4CLK);
-	writel(cfg->main_pll_cntr5clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR5CLK);
-	writel(cfg->main_pll_cntr6clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR6CLK);
-	writel(cfg->main_pll_cntr7clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR7CLK);
-	writel(cfg->main_pll_cntr8clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR8CLK);
-	writel(cfg->main_pll_cntr9clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_CNTR9CLK);
-	writel(cfg->per_pll_cntr2clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR2CLK);
-	writel(cfg->per_pll_cntr3clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR3CLK);
-	writel(cfg->per_pll_cntr4clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR4CLK);
-	writel(cfg->per_pll_cntr5clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR5CLK);
-	writel(cfg->per_pll_cntr6clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR6CLK);
-	writel(cfg->per_pll_cntr7clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR7CLK);
-	writel(cfg->per_pll_cntr8clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR8CLK);
-	writel(cfg->per_pll_cntr9clk,
-	       socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_CNTR9CLK);
-
-	/* Take all PLLs out of bypass */
-	cm_write_bypass_mainpll(0);
-	cm_write_bypass_perpll(0);
-
-	/* clear safe mode / out of boot mode */
-	cm_write_ctrl(readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_CTRL) &
-		      ~(CLKMGR_CTRL_SAFEMODE));
-
-	/* Now ungate non-hw-managed clocks */
-	writel(~0, socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_EN);
-	writel(~0, socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_EN);
-
-	/* Clear the loss of lock bits (write 1 to clear) */
-	writel(CLKMGR_INTER_PERPLLLOST_MASK |
-		      CLKMGR_INTER_MAINPLLLOST_MASK,
-		      socfpga_get_clkmgr_addr() + CLKMGR_S10_INTRCLR);
-}
-
-static unsigned long cm_get_main_vco_clk_hz(void)
+static ulong cm_get_rate_dm(u32 id)
 {
-	 unsigned long fref, refdiv, mdiv, reg, vco;
-
-	reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_PLLGLOB);
-
-	fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
-		CLKMGR_PLLGLOB_VCO_PSRC_MASK;
-	switch (fref) {
-	case CLKMGR_VCO_PSRC_EOSC1:
-		fref = cm_get_osc_clk_hz();
-		break;
-	case CLKMGR_VCO_PSRC_INTOSC:
-		fref = cm_get_intosc_clk_hz();
-		break;
-	case CLKMGR_VCO_PSRC_F2S:
-		fref = cm_get_fpga_clk_hz();
-		break;
+	struct udevice *dev;
+	struct clk clk;
+	ulong rate;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_CLK,
+					  DM_DRIVER_GET(socfpga_s10_clk),
+					  &dev);
+	if (ret)
+		return 0;
+
+	clk.id = id;
+	ret = clk_request(dev, &clk);
+	if (ret < 0)
+		return 0;
+
+	rate = clk_get_rate(&clk);
+
+	if ((rate == (unsigned long)-ENOSYS) ||
+	    (rate == (unsigned long)-ENXIO) ||
+	    (rate == (unsigned long)-EIO)) {
+		debug("%s id %u: clk_get_rate err: %ld\n",
+		      __func__, id, rate);
+		return 0;
 	}
 
-	refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
-		  CLKMGR_PLLGLOB_REFCLKDIV_MASK;
-
-	reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_MAINPLL_FDBCK);
-	mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
-
-	vco = fref / refdiv;
-	vco = vco * (CLKMGR_MDIV_CONST + mdiv);
-	return vco;
+	return rate;
 }
 
-static unsigned long cm_get_per_vco_clk_hz(void)
+static u32 cm_get_rate_dm_khz(u32 id)
 {
-	unsigned long fref, refdiv, mdiv, reg, vco;
-
-	reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_PLLGLOB);
-
-	fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
-		CLKMGR_PLLGLOB_VCO_PSRC_MASK;
-	switch (fref) {
-	case CLKMGR_VCO_PSRC_EOSC1:
-		fref = cm_get_osc_clk_hz();
-		break;
-	case CLKMGR_VCO_PSRC_INTOSC:
-		fref = cm_get_intosc_clk_hz();
-		break;
-	case CLKMGR_VCO_PSRC_F2S:
-		fref = cm_get_fpga_clk_hz();
-		break;
-	}
-
-	refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
-		  CLKMGR_PLLGLOB_REFCLKDIV_MASK;
-
-	reg = readl(socfpga_get_clkmgr_addr() + CLKMGR_S10_PERPLL_FDBCK);
-	mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
-
-	vco = fref / refdiv;
-	vco = vco * (CLKMGR_MDIV_CONST + mdiv);
-	return vco;
+	return cm_get_rate_dm(id) / 1000;
 }
 
 unsigned long cm_get_mpu_clk_hz(void)
 {
-	unsigned long clock = readl(socfpga_get_clkmgr_addr() +
-				    CLKMGR_S10_MAINPLL_MPUCLK);
-
-	clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
-
-	switch (clock) {
-	case CLKMGR_CLKSRC_MAIN:
-		clock = cm_get_main_vco_clk_hz();
-		clock /= (readl(socfpga_get_clkmgr_addr() +
-				CLKMGR_S10_MAINPLL_PLLC0) &
-			  CLKMGR_PLLC0_DIV_MASK);
-		break;
-
-	case CLKMGR_CLKSRC_PER:
-		clock = cm_get_per_vco_clk_hz();
-		clock /= (readl(socfpga_get_clkmgr_addr() +
-				CLKMGR_S10_PERPLL_PLLC0) &
-			  CLKMGR_CLKCNT_MSK);
-		break;
-
-	case CLKMGR_CLKSRC_OSC1:
-		clock = cm_get_osc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_INTOSC:
-		clock = cm_get_intosc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_FPGA:
-		clock = cm_get_fpga_clk_hz();
-		break;
-	}
-
-	clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
-			    CLKMGR_S10_MAINPLL_MPUCLK) & CLKMGR_CLKCNT_MSK);
-	return clock;
-}
-
-unsigned int cm_get_l3_main_clk_hz(void)
-{
-	u32 clock = readl(socfpga_get_clkmgr_addr() +
-			  CLKMGR_S10_MAINPLL_NOCCLK);
-
-	clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
-
-	switch (clock) {
-	case CLKMGR_CLKSRC_MAIN:
-		clock = cm_get_main_vco_clk_hz();
-		clock /= (readl(socfpga_get_clkmgr_addr() +
-				CLKMGR_S10_MAINPLL_PLLC1) &
-			  CLKMGR_PLLC0_DIV_MASK);
-		break;
-
-	case CLKMGR_CLKSRC_PER:
-		clock = cm_get_per_vco_clk_hz();
-		clock /= (readl(socfpga_get_clkmgr_addr() +
-			  CLKMGR_S10_PERPLL_PLLC1) & CLKMGR_CLKCNT_MSK);
-		break;
-
-	case CLKMGR_CLKSRC_OSC1:
-		clock = cm_get_osc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_INTOSC:
-		clock = cm_get_intosc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_FPGA:
-		clock = cm_get_fpga_clk_hz();
-		break;
-	}
-
-	clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
-		      CLKMGR_S10_MAINPLL_NOCCLK) & CLKMGR_CLKCNT_MSK);
-	return clock;
-}
-
-unsigned int cm_get_mmc_controller_clk_hz(void)
-{
-	u32 clock = readl(socfpga_get_clkmgr_addr() +
-			  CLKMGR_S10_PERPLL_CNTR6CLK);
-
-	clock = (clock >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
-
-	switch (clock) {
-	case CLKMGR_CLKSRC_MAIN:
-		clock = cm_get_l3_main_clk_hz();
-		clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
-				    CLKMGR_S10_MAINPLL_CNTR6CLK) &
-			      CLKMGR_CLKCNT_MSK);
-		break;
-
-	case CLKMGR_CLKSRC_PER:
-		clock = cm_get_l3_main_clk_hz();
-		clock /= 1 + (readl(socfpga_get_clkmgr_addr() +
-				    CLKMGR_S10_PERPLL_CNTR6CLK) &
-			      CLKMGR_CLKCNT_MSK);
-		break;
-
-	case CLKMGR_CLKSRC_OSC1:
-		clock = cm_get_osc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_INTOSC:
-		clock = cm_get_intosc_clk_hz();
-		break;
-
-	case CLKMGR_CLKSRC_FPGA:
-		clock = cm_get_fpga_clk_hz();
-		break;
-	}
-	return clock / 4;
-}
-
-unsigned int cm_get_l4_sp_clk_hz(void)
-{
-	u32 clock = cm_get_l3_main_clk_hz();
-
-	clock /= (1 << ((readl(socfpga_get_clkmgr_addr() +
-			       CLKMGR_S10_MAINPLL_NOCDIV) >>
-			 CLKMGR_NOCDIV_L4SPCLK_OFFSET) & CLKMGR_CLKCNT_MSK));
-	return clock;
-}
-
-unsigned int cm_get_spi_controller_clk_hz(void)
-{
-	u32 clock = cm_get_l3_main_clk_hz();
-
-	clock /= (1 << ((readl(socfpga_get_clkmgr_addr() +
-			       CLKMGR_S10_MAINPLL_NOCDIV) >>
-			 CLKMGR_NOCDIV_L4MAIN_OFFSET) & CLKMGR_CLKCNT_MSK));
-	return clock;
+	return cm_get_rate_dm(STRATIX10_MPU_CLK);
 }
 
 unsigned int cm_get_l4_sys_free_clk_hz(void)
 {
-	return cm_get_l3_main_clk_hz() / 4;
-}
-
-/*
- * Override weak dw_spi_get_clk implementation in designware_spi.c driver
- */
-
-int dw_spi_get_clk(struct udevice *bus, ulong *rate)
-{
-	*rate = cm_get_spi_controller_clk_hz();
-	if (!*rate) {
-		printf("SPI: clock rate is zero");
-		return -EINVAL;
-	}
-
-	return 0;
+	return cm_get_rate_dm(STRATIX10_L4_SYS_FREE_CLK);
 }
 
 void cm_print_clock_quick_summary(void)
 {
-	printf("MPU         %d kHz\n", (u32)(cm_get_mpu_clk_hz() / 1000));
-	printf("L3 main     %d kHz\n", cm_get_l3_main_clk_hz() / 1000);
-	printf("Main VCO    %d kHz\n", (u32)(cm_get_main_vco_clk_hz() / 1000));
-	printf("Per VCO     %d kHz\n", (u32)(cm_get_per_vco_clk_hz() / 1000));
-	printf("EOSC1       %d kHz\n", cm_get_osc_clk_hz() / 1000);
-	printf("HPS MMC     %d kHz\n", cm_get_mmc_controller_clk_hz() / 1000);
-	printf("UART        %d kHz\n", cm_get_l4_sp_clk_hz() / 1000);
+	printf("MPU         %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_MPU_CLK));
+	printf("L3 main     %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_NOC_CLK));
+	printf("Main VCO    %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_MAIN_PLL_CLK));
+	printf("Per VCO     %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_PERIPH_PLL_CLK));
+	printf("EOSC1       %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_OSC1));
+	printf("HPS MMC     %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_SDMMC_CLK));
+	printf("UART        %d kHz\n",
+	       cm_get_rate_dm_khz(STRATIX10_L4_SP_CLK));
 }
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
index 5dcbda9473e..e5ff0648b86 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
@@ -1,177 +1,13 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
  *
  */
 
-#ifndef	_CLOCK_MANAGER_S10_
-#define	_CLOCK_MANAGER_S10_
+#ifndef _CLOCK_MANAGER_S10_
+#define _CLOCK_MANAGER_S10_
 
 #include <asm/arch/clock_manager_soc64.h>
-#include <linux/bitops.h>
-
-/* Clock speed accessors */
-unsigned long cm_get_sdram_clk_hz(void);
-unsigned int cm_get_l4_sp_clk_hz(void);
-unsigned int cm_get_mmc_controller_clk_hz(void);
-unsigned int cm_get_spi_controller_clk_hz(void);
-
-struct cm_config {
-	/* main group */
-	u32 main_pll_mpuclk;
-	u32 main_pll_nocclk;
-	u32 main_pll_cntr2clk;
-	u32 main_pll_cntr3clk;
-	u32 main_pll_cntr4clk;
-	u32 main_pll_cntr5clk;
-	u32 main_pll_cntr6clk;
-	u32 main_pll_cntr7clk;
-	u32 main_pll_cntr8clk;
-	u32 main_pll_cntr9clk;
-	u32 main_pll_nocdiv;
-	u32 main_pll_pllglob;
-	u32 main_pll_fdbck;
-	u32 main_pll_pllc0;
-	u32 main_pll_pllc1;
-	u32 spare;
-
-	/* peripheral group */
-	u32 per_pll_cntr2clk;
-	u32 per_pll_cntr3clk;
-	u32 per_pll_cntr4clk;
-	u32 per_pll_cntr5clk;
-	u32 per_pll_cntr6clk;
-	u32 per_pll_cntr7clk;
-	u32 per_pll_cntr8clk;
-	u32 per_pll_cntr9clk;
-	u32 per_pll_emacctl;
-	u32 per_pll_gpiodiv;
-	u32 per_pll_pllglob;
-	u32 per_pll_fdbck;
-	u32 per_pll_pllc0;
-	u32 per_pll_pllc1;
-
-	/* incoming clock */
-	u32 hps_osc_clk_hz;
-	u32 fpga_clk_hz;
-};
-
-void cm_basic_init(const struct cm_config * const cfg);
-
-/* Control status */
-#define CLKMGR_S10_CTRL					0x00
-#define CLKMGR_S10_STAT					0x04
-#define CLKMGR_S10_INTRCLR				0x14
-/* Mainpll group */
-#define CLKMGR_S10_MAINPLL_EN				0x30
-#define CLKMGR_S10_MAINPLL_BYPASS			0x3c
-#define CLKMGR_S10_MAINPLL_MPUCLK			0x48
-#define CLKMGR_S10_MAINPLL_NOCCLK			0x4c
-#define CLKMGR_S10_MAINPLL_CNTR2CLK			0x50
-#define CLKMGR_S10_MAINPLL_CNTR3CLK			0x54
-#define CLKMGR_S10_MAINPLL_CNTR4CLK			0x58
-#define CLKMGR_S10_MAINPLL_CNTR5CLK			0x5c
-#define CLKMGR_S10_MAINPLL_CNTR6CLK			0x60
-#define CLKMGR_S10_MAINPLL_CNTR7CLK			0x64
-#define CLKMGR_S10_MAINPLL_CNTR8CLK			0x68
-#define CLKMGR_S10_MAINPLL_CNTR9CLK			0x6c
-#define CLKMGR_S10_MAINPLL_NOCDIV			0x70
-#define CLKMGR_S10_MAINPLL_PLLGLOB			0x74
-#define CLKMGR_S10_MAINPLL_FDBCK			0x78
-#define CLKMGR_S10_MAINPLL_MEMSTAT			0x80
-#define CLKMGR_S10_MAINPLL_PLLC0			0x84
-#define CLKMGR_S10_MAINPLL_PLLC1			0x88
-#define CLKMGR_S10_MAINPLL_VCOCALIB			0x8c
-/* Periphpll group */
-#define CLKMGR_S10_PERPLL_EN				0xa4
-#define CLKMGR_S10_PERPLL_BYPASS			0xb0
-#define CLKMGR_S10_PERPLL_CNTR2CLK			0xbc
-#define CLKMGR_S10_PERPLL_CNTR3CLK			0xc0
-#define CLKMGR_S10_PERPLL_CNTR4CLK			0xc4
-#define CLKMGR_S10_PERPLL_CNTR5CLK			0xc8
-#define CLKMGR_S10_PERPLL_CNTR6CLK			0xcc
-#define CLKMGR_S10_PERPLL_CNTR7CLK			0xd0
-#define CLKMGR_S10_PERPLL_CNTR8CLK			0xd4
-#define CLKMGR_S10_PERPLL_CNTR9CLK			0xd8
-#define CLKMGR_S10_PERPLL_EMACCTL			0xdc
-#define CLKMGR_S10_PERPLL_GPIODIV			0xe0
-#define CLKMGR_S10_PERPLL_PLLGLOB			0xe4
-#define CLKMGR_S10_PERPLL_FDBCK				0xe8
-#define CLKMGR_S10_PERPLL_MEMSTAT			0xf0
-#define CLKMGR_S10_PERPLL_PLLC0				0xf4
-#define CLKMGR_S10_PERPLL_PLLC1				0xf8
-#define CLKMGR_S10_PERPLL_VCOCALIB			0xfc
-
-#define CLKMGR_STAT					CLKMGR_S10_STAT
-#define CLKMGR_INTER					CLKMGR_S10_INTER
-#define CLKMGR_PERPLL_EN				CLKMGR_S10_PERPLL_EN
-
-#define CLKMGR_CTRL_SAFEMODE				BIT(0)
-#define CLKMGR_BYPASS_MAINPLL_ALL			0x00000007
-#define CLKMGR_BYPASS_PERPLL_ALL			0x0000007f
-
-#define CLKMGR_INTER_MAINPLLLOCKED_MASK			0x00000001
-#define CLKMGR_INTER_PERPLLLOCKED_MASK			0x00000002
-#define CLKMGR_INTER_MAINPLLLOST_MASK			0x00000004
-#define CLKMGR_INTER_PERPLLLOST_MASK			0x00000008
-#define CLKMGR_STAT_BUSY				BIT(0)
-#define CLKMGR_STAT_MAINPLL_LOCKED			BIT(8)
-#define CLKMGR_STAT_PERPLL_LOCKED			BIT(9)
-
-#define CLKMGR_PLLGLOB_PD_MASK				0x00000001
-#define CLKMGR_PLLGLOB_RST_MASK				0x00000002
-#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			0x3
-#define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET			16
-#define CLKMGR_VCO_PSRC_EOSC1				0
-#define CLKMGR_VCO_PSRC_INTOSC				1
-#define CLKMGR_VCO_PSRC_F2S				2
-#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			0x3f
-#define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET			8
-
-#define CLKMGR_CLKSRC_MASK				0x7
-#define CLKMGR_CLKSRC_OFFSET				16
-#define CLKMGR_CLKSRC_MAIN				0
-#define CLKMGR_CLKSRC_PER				1
-#define CLKMGR_CLKSRC_OSC1				2
-#define CLKMGR_CLKSRC_INTOSC				3
-#define CLKMGR_CLKSRC_FPGA				4
-#define CLKMGR_CLKCNT_MSK				0x7ff
-
-#define CLKMGR_FDBCK_MDIV_MASK				0xff
-#define CLKMGR_FDBCK_MDIV_OFFSET			24
-
-#define CLKMGR_PLLC0_DIV_MASK				0xff
-#define CLKMGR_PLLC1_DIV_MASK				0xff
-#define CLKMGR_PLLC0_EN_OFFSET				27
-#define CLKMGR_PLLC1_EN_OFFSET				24
-
-#define CLKMGR_NOCDIV_L4MAIN_OFFSET			0
-#define CLKMGR_NOCDIV_L4MPCLK_OFFSET			8
-#define CLKMGR_NOCDIV_L4SPCLK_OFFSET			16
-#define CLKMGR_NOCDIV_CSATCLK_OFFSET			24
-#define CLKMGR_NOCDIV_CSTRACECLK_OFFSET			26
-#define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET			28
-
-#define CLKMGR_NOCDIV_L4SPCLK_MASK			0x3
-#define CLKMGR_NOCDIV_DIV1				0
-#define CLKMGR_NOCDIV_DIV2				1
-#define CLKMGR_NOCDIV_DIV4				2
-#define CLKMGR_NOCDIV_DIV8				3
-#define CLKMGR_CSPDBGCLK_DIV1				0
-#define CLKMGR_CSPDBGCLK_DIV4				1
-
-#define CLKMGR_MSCNT_CONST				200
-#define CLKMGR_MDIV_CONST				6
-#define CLKMGR_HSCNT_CONST				9
-
-#define CLKMGR_VCOCALIB_MSCNT_MASK			0xff
-#define CLKMGR_VCOCALIB_MSCNT_OFFSET			9
-#define CLKMGR_VCOCALIB_HSCNT_MASK			0xff
-
-#define CLKMGR_EMACCTL_EMAC0SEL_OFFSET			26
-#define CLKMGR_EMACCTL_EMAC1SEL_OFFSET			27
-#define CLKMGR_EMACCTL_EMAC2SEL_OFFSET			28
-
-#define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		0x00000020
+#include "../../../../../drivers/clk/altera/clk-s10.h"
 
 #endif /* _CLOCK_MANAGER_S10_ */
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 418d7dfb572..6d7128c77be 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -276,7 +276,8 @@ void socfpga_get_managers_addr(void)
 					    &socfpga_clkmgr_base);
 	else if (!IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) &&
 		 !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX7M) &&
-		 !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5))
+		 !IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5) &&
+		 !IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10))
 		ret = socfpga_get_base_addr("altr,clk-mgr",
 					    &socfpga_clkmgr_base);
 
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index b05bec2cbc1..ace029557f3 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -37,7 +37,6 @@ u32 reset_flag(void)
 
 void board_init_f(ulong dummy)
 {
-	const struct cm_config *cm_default_cfg = cm_get_default_config();
 	int ret;
 	struct udevice *dev;
 
@@ -75,7 +74,11 @@ void board_init_f(ulong dummy)
 	sysmgr_pinmux_init();
 
 	/* configuring the HPS clocks */
-	cm_basic_init(cm_default_cfg);
+	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
+	if (ret) {
+		debug("Clock init failed: %d\n", ret);
+		hang();
+	}
 
 #ifdef CONFIG_DEBUG_UART
 	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
index 693446b3d89..e961d059820 100644
--- a/drivers/clk/altera/Makefile
+++ b/drivers/clk/altera/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += clk-arria10.o
 obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-n5x.o
 obj-$(CONFIG_ARCH_SOCFPGA_N5X) += clk-mem-n5x.o
 obj-$(CONFIG_ARCH_SOCFPGA_AGILEX5) += clk-agilex5.o
+obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += clk-s10.o
diff --git a/drivers/clk/altera/clk-s10.c b/drivers/clk/altera/clk-s10.c
new file mode 100644
index 00000000000..c6492e0cb43
--- /dev/null
+++ b/drivers/clk/altera/clk-s10.c
@@ -0,0 +1,603 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ */
+
+#include <log.h>
+#include <wait_bit.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <dm/util.h>
+#include <dt-bindings/clock/stratix10-clock.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <asm/arch/clock_manager.h>
+
+struct socfpga_clk_plat {
+	void __iomem *regs;
+	int pllgrp;
+	int bitmask;
+};
+
+/*
+ * function to write the bypass register which requires a poll of the
+ * busy bit
+ */
+static void clk_write_bypass_mainpll(struct socfpga_clk_plat *plat, u32 val)
+{
+	void __iomem *base = plat->regs;
+
+	CM_REG_WRITEL(plat, val, CLKMGR_MAINPLL_BYPASS);
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
+}
+
+static void clk_write_bypass_perpll(struct socfpga_clk_plat *plat, u32 val)
+{
+	void __iomem *base = plat->regs;
+
+	CM_REG_WRITEL(plat, val, CLKMGR_PERPLL_BYPASS);
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
+}
+
+/* function to write the ctrl register which requires a poll of the busy bit */
+static void clk_write_ctrl(struct socfpga_clk_plat *plat, u32 val)
+{
+	void __iomem *base = plat->regs;
+
+	CM_REG_WRITEL(plat, val, CLKMGR_CTRL);
+
+	wait_for_bit_le32(base + CLKMGR_STAT,
+			  CLKMGR_STAT_BUSY, false, 20000, false);
+}
+
+/*
+ * Setup clocks while making no assumptions about previous state of the clocks.
+ */
+static void clk_basic_init(struct udevice *dev,
+			   const struct cm_config * const cfg)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(dev);
+	u32 mdiv, refclkdiv, mscnt, hscnt, vcocalib;
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+
+	if (!cfg)
+		return;
+
+	/* Put all plls in bypass */
+	clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
+	clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
+
+	/* setup main PLL dividers where calculate the vcocalib value */
+	mdiv = (cfg->main_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
+		CLKMGR_FDBCK_MDIV_MASK;
+	refclkdiv = (cfg->main_pll_pllglob >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
+		     CLKMGR_PLLGLOB_REFCLKDIV_MASK;
+	mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
+	hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
+		CLKMGR_HSCNT_CONST;
+	vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
+		   ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
+		   CLKMGR_VCOCALIB_MSCNT_OFFSET);
+
+	writel((cfg->main_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
+		~CLKMGR_PLLGLOB_RST_MASK),
+		base_addr + CLKMGR_MAINPLL_PLLGLOB);
+	writel(cfg->main_pll_fdbck,
+	       base_addr + CLKMGR_MAINPLL_FDBCK);
+	writel(vcocalib,
+	       base_addr + CLKMGR_MAINPLL_VCOCALIB);
+	writel(cfg->main_pll_pllc0,
+	       base_addr + CLKMGR_MAINPLL_PLLC0);
+	writel(cfg->main_pll_pllc1,
+	       base_addr + CLKMGR_MAINPLL_PLLC1);
+	writel(cfg->main_pll_nocdiv,
+	       base_addr + CLKMGR_MAINPLL_NOCDIV);
+
+	/* setup peripheral PLL dividers */
+	/* calculate the vcocalib value */
+	mdiv = (cfg->per_pll_fdbck >> CLKMGR_FDBCK_MDIV_OFFSET) &
+		CLKMGR_FDBCK_MDIV_MASK;
+	refclkdiv = (cfg->per_pll_pllglob >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
+		     CLKMGR_PLLGLOB_REFCLKDIV_MASK;
+	mscnt = CLKMGR_MSCNT_CONST / (CLKMGR_MDIV_CONST + mdiv) / refclkdiv;
+	hscnt = (mdiv + CLKMGR_MDIV_CONST) * mscnt / refclkdiv -
+		CLKMGR_HSCNT_CONST;
+	vcocalib = (hscnt & CLKMGR_VCOCALIB_HSCNT_MASK) |
+		   ((mscnt & CLKMGR_VCOCALIB_MSCNT_MASK) <<
+		   CLKMGR_VCOCALIB_MSCNT_OFFSET);
+
+	writel((cfg->per_pll_pllglob & ~CLKMGR_PLLGLOB_PD_MASK &
+		~CLKMGR_PLLGLOB_RST_MASK),
+		base_addr + CLKMGR_PERPLL_PLLGLOB);
+	writel(cfg->per_pll_fdbck,
+	       base_addr + CLKMGR_PERPLL_FDBCK);
+	writel(vcocalib,
+	       base_addr + CLKMGR_PERPLL_VCOCALIB);
+	writel(cfg->per_pll_pllc0,
+	       base_addr + CLKMGR_PERPLL_PLLC0);
+	writel(cfg->per_pll_pllc1,
+	       base_addr + CLKMGR_PERPLL_PLLC1);
+	writel(cfg->per_pll_emacctl,
+	       base_addr + CLKMGR_PERPLL_EMACCTL);
+	writel(cfg->per_pll_gpiodiv,
+	       base_addr + CLKMGR_PERPLL_GPIODIV);
+
+	/* Take both PLL out of reset and power up */
+	setbits_le32(base_addr + CLKMGR_MAINPLL_PLLGLOB,
+		     CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+	setbits_le32(base_addr + CLKMGR_PERPLL_PLLGLOB,
+		     CLKMGR_PLLGLOB_PD_MASK | CLKMGR_PLLGLOB_RST_MASK);
+
+	wait_for_bit_le32((const void *)(base_addr + CLKMGR_STAT),
+			  CLKMGR_STAT_ALLPLL_LOCKED_MASK, true, 20000, false);
+
+	/*
+	 * Dividers for C2 to C9 only init after PLLs are lock. As dividers
+	 * only take effect upon value change, we shall set a maximum value as
+	 * default value.
+	 */
+	writel(0xff, base_addr + CLKMGR_MAINPLL_MPUCLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_NOCCLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR2CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR3CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR4CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR5CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR6CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR7CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR8CLK);
+	writel(0xff, base_addr + CLKMGR_MAINPLL_CNTR9CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR2CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR3CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR4CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR5CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR6CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR7CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR8CLK);
+	writel(0xff, base_addr + CLKMGR_PERPLL_CNTR9CLK);
+
+	writel(cfg->main_pll_mpuclk,
+	       base_addr + CLKMGR_MAINPLL_MPUCLK);
+	writel(cfg->main_pll_nocclk,
+	       base_addr + CLKMGR_MAINPLL_NOCCLK);
+	writel(cfg->main_pll_cntr2clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR2CLK);
+	writel(cfg->main_pll_cntr3clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR3CLK);
+	writel(cfg->main_pll_cntr4clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR4CLK);
+	writel(cfg->main_pll_cntr5clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR5CLK);
+	writel(cfg->main_pll_cntr6clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR6CLK);
+	writel(cfg->main_pll_cntr7clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR7CLK);
+	writel(cfg->main_pll_cntr8clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR8CLK);
+	writel(cfg->main_pll_cntr9clk,
+	       base_addr + CLKMGR_MAINPLL_CNTR9CLK);
+	writel(cfg->per_pll_cntr2clk,
+	       base_addr + CLKMGR_PERPLL_CNTR2CLK);
+	writel(cfg->per_pll_cntr3clk,
+	       base_addr + CLKMGR_PERPLL_CNTR3CLK);
+	writel(cfg->per_pll_cntr4clk,
+	       base_addr + CLKMGR_PERPLL_CNTR4CLK);
+	writel(cfg->per_pll_cntr5clk,
+	       base_addr + CLKMGR_PERPLL_CNTR5CLK);
+	writel(cfg->per_pll_cntr6clk,
+	       base_addr + CLKMGR_PERPLL_CNTR6CLK);
+	writel(cfg->per_pll_cntr7clk,
+	       base_addr + CLKMGR_PERPLL_CNTR7CLK);
+	writel(cfg->per_pll_cntr8clk,
+	       base_addr + CLKMGR_PERPLL_CNTR8CLK);
+	writel(cfg->per_pll_cntr9clk,
+	       base_addr + CLKMGR_PERPLL_CNTR9CLK);
+
+	/* Take all PLLs out of bypass */
+	clk_write_bypass_mainpll(plat, 0);
+	clk_write_bypass_perpll(plat, 0);
+
+#ifdef COUNTER_FREQUENCY_REAL
+	u32 cntfrq = COUNTER_FREQUENCY_REAL;
+	u32 counter_freq = 0;
+
+	/* Update with accurate clock frequency */
+	if (current_el() == 3) {
+		asm volatile("msr cntfrq_el0, %0" : : "r" (cntfrq) : "memory");
+		asm volatile("mrs %0, cntfrq_el0" : "=r" (counter_freq));
+		debug("Counter freq = 0x%x\n", counter_freq);
+	}
+#endif
+
+	/* clear safe mode / out of boot mode */
+	clk_write_ctrl(plat, readl(base_addr + CLKMGR_CTRL) &
+		      ~(CLKMGR_CTRL_SAFEMODE));
+
+	/* Now ungate non-hw-managed clocks */
+	writel(~0, base_addr + CLKMGR_MAINPLL_EN);
+	writel(~0, base_addr + CLKMGR_PERPLL_EN);
+
+	/* Clear the loss of lock bits (write 1 to clear) */
+	writel(CLKMGR_INTER_PERPLLLOST_MASK |
+		      CLKMGR_INTER_MAINPLLLOST_MASK,
+		      base_addr + CLKMGR_INTRCLR);
+}
+
+static u64 clk_get_vco_clk_hz(struct socfpga_clk_plat *plat,
+			      u32 pllglob_reg, u32 fdbck_reg)
+{
+	 u64 fref, refdiv, mdiv, reg, vco;
+
+	reg = CM_REG_READL(plat, pllglob_reg);
+
+	fref = (reg >> CLKMGR_PLLGLOB_VCO_PSRC_OFFSET) &
+		CLKMGR_PLLGLOB_VCO_PSRC_MASK;
+
+	switch (fref) {
+	case CLKMGR_VCO_PSRC_EOSC1:
+		fref = cm_get_osc_clk_hz();
+		break;
+	case CLKMGR_VCO_PSRC_INTOSC:
+		fref = cm_get_intosc_clk_hz();
+		break;
+	case CLKMGR_VCO_PSRC_F2S:
+		fref = cm_get_fpga_clk_hz();
+		break;
+	}
+
+	refdiv = (reg >> CLKMGR_PLLGLOB_REFCLKDIV_OFFSET) &
+		  CLKMGR_PLLGLOB_REFCLKDIV_MASK;
+
+	reg = CM_REG_READL(plat, fdbck_reg);
+	mdiv = (reg >> CLKMGR_FDBCK_MDIV_OFFSET) & CLKMGR_FDBCK_MDIV_MASK;
+
+	vco = fref / refdiv;
+	vco = vco * (CLKMGR_MDIV_CONST + mdiv);
+
+	return vco;
+}
+
+static u64 clk_get_main_vco_clk_hz(struct socfpga_clk_plat *plat)
+{
+	return clk_get_vco_clk_hz(plat, CLKMGR_MAINPLL_PLLGLOB,
+				 CLKMGR_MAINPLL_FDBCK);
+}
+
+static u64 clk_get_per_vco_clk_hz(struct socfpga_clk_plat *plat)
+{
+	return clk_get_vco_clk_hz(plat, CLKMGR_PERPLL_PLLGLOB,
+				 CLKMGR_PERPLL_FDBCK);
+}
+
+static u32 clk_get_5_1_clk_src(struct socfpga_clk_plat *plat, u64 reg)
+{
+	u32 clksrc = CM_REG_READL(plat, reg);
+
+	return (clksrc >> CLKMGR_CLKSRC_OFFSET) & CLKMGR_CLKSRC_MASK;
+}
+
+static u64 clk_get_mpu_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock;
+	u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_MAINPLL_MPUCLK);
+
+	switch (clklsrc) {
+	case CLKMGR_CLKSRC_MAIN:
+		clock = clk_get_main_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC0) &
+			  CLKMGR_PLLC0_DIV_MASK);
+		break;
+	case CLKMGR_CLKSRC_PER:
+		clock = clk_get_per_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC0) &
+			  CLKMGR_CLKCNT_MSK);
+		break;
+	case CLKMGR_CLKSRC_OSC1:
+		clock = cm_get_osc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_INTOSC:
+		clock = cm_get_intosc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_FPGA:
+		clock = cm_get_fpga_clk_hz();
+		break;
+	default:
+		return 0;
+	}
+
+	clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_MPUCLK) &
+		 CLKMGR_CLKCNT_MSK);
+
+	return clock;
+}
+
+static u32 clk_get_l3_main_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock;
+	u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_MAINPLL_NOCCLK);
+
+	switch (clklsrc) {
+	case CLKMGR_CLKSRC_MAIN:
+		clock = clk_get_main_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, CLKMGR_MAINPLL_PLLC1) &
+			  CLKMGR_PLLC0_DIV_MASK);
+		break;
+	case CLKMGR_CLKSRC_PER:
+		clock = clk_get_per_vco_clk_hz(plat);
+		clock /= (CM_REG_READL(plat, CLKMGR_PERPLL_PLLC1) &
+			  CLKMGR_CLKCNT_MSK);
+		break;
+	case CLKMGR_CLKSRC_OSC1:
+		clock = cm_get_osc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_INTOSC:
+		clock = cm_get_intosc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_FPGA:
+		clock = cm_get_fpga_clk_hz();
+		break;
+	default:
+		return 0;
+	}
+
+	clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_NOCCLK) &
+		 CLKMGR_CLKCNT_MSK);
+
+	return clock;
+}
+
+static u32 clk_get_sdmmc_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u32 clock;
+	u32 clklsrc = clk_get_5_1_clk_src(plat, CLKMGR_PERPLL_CNTR6CLK);
+
+	switch (clklsrc) {
+	case CLKMGR_CLKSRC_MAIN:
+		clock = clk_get_l3_main_clk_hz(plat);
+		clock /= 1 + (CM_REG_READL(plat, CLKMGR_MAINPLL_CNTR6CLK) & CLKMGR_CLKCNT_MSK);
+		break;
+	case CLKMGR_CLKSRC_PER:
+		clock = clk_get_l3_main_clk_hz(plat);
+		clock /= 1 + (CM_REG_READL(plat, CLKMGR_PERPLL_CNTR6CLK) & CLKMGR_CLKCNT_MSK);
+		break;
+	case CLKMGR_CLKSRC_OSC1:
+		clock = cm_get_osc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_INTOSC:
+		clock = cm_get_intosc_clk_hz();
+		break;
+	case CLKMGR_CLKSRC_FPGA:
+		clock = cm_get_fpga_clk_hz();
+		break;
+	default:
+		return 0;
+	}
+
+	return clock / 4;
+}
+
+static u32 clk_get_l4_sp_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_L4SPCLK_OFFSET) &
+		      CLKMGR_CLKCNT_MSK);
+
+	return clock;
+}
+
+static u32 clk_get_l4_sys_free_clk_hz(struct socfpga_clk_plat *plat)
+{
+	if (CM_REG_READL(plat, CLKMGR_STAT) & CLKMGR_STAT_BOOTMODE)
+		return clk_get_l3_main_clk_hz(plat) / 2;
+
+	return clk_get_l3_main_clk_hz(plat) / 4;
+}
+
+static ulong socfpga_clk_get_rate(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+
+	switch (clk->id) {
+	case STRATIX10_MPU_CLK:
+		return clk_get_mpu_clk_hz(plat);
+	case STRATIX10_NOC_CLK:
+		return clk_get_l3_main_clk_hz(plat);
+	case STRATIX10_MAIN_PLL_CLK:
+		return clk_get_main_vco_clk_hz(plat);
+	case STRATIX10_PERIPH_PLL_CLK:
+		return clk_get_per_vco_clk_hz(plat);
+	case STRATIX10_OSC1:
+		return cm_get_osc_clk_hz();
+	case STRATIX10_SDMMC_CLK:
+		return clk_get_sdmmc_clk_hz(plat);
+	case STRATIX10_L4_SP_CLK:
+		return clk_get_l4_sp_clk_hz(plat);
+	case STRATIX10_L4_SYS_FREE_CLK:
+		return clk_get_l4_sys_free_clk_hz(plat);
+	default:
+		return -ENXIO;
+	}
+}
+
+static int bitmask_from_clk_id(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+
+	switch (clk->id) {
+	case STRATIX10_MPU_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
+		break;
+	case STRATIX10_L4_MAIN_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
+		break;
+	case STRATIX10_L4_MP_CLK:
+	case STRATIX10_NAND_X_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
+		break;
+	case STRATIX10_L4_SP_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
+		break;
+	case STRATIX10_CS_AT_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case STRATIX10_CS_TRACE_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case STRATIX10_CS_PDBG_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case STRATIX10_CS_TIMER_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
+		break;
+	case STRATIX10_S2F_USER0_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
+		break;
+	case STRATIX10_EMAC0_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
+		break;
+	case STRATIX10_EMAC1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
+		break;
+	case STRATIX10_EMAC2_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
+		break;
+	case STRATIX10_EMAC_PTP_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
+		break;
+	case STRATIX10_GPIO_DB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
+		break;
+	case STRATIX10_SDMMC_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
+		break;
+	case STRATIX10_S2F_USER1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
+		break;
+	case STRATIX10_PSI_REF_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
+		break;
+	case STRATIX10_USB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
+		break;
+	case STRATIX10_SPI_M_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
+		break;
+	case STRATIX10_NAND_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
+		break;
+	case STRATIX10_L4_SYS_FREE_CLK:
+		return -EOPNOTSUPP;
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int socfpga_clk_enable(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+	int ret;
+
+	ret = bitmask_from_clk_id(clk);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	setbits_le32(base_addr + plat->pllgrp, plat->bitmask);
+
+	return 0;
+}
+
+static int socfpga_clk_disable(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+	uintptr_t base_addr = (uintptr_t)plat->regs;
+	int ret;
+
+	ret = bitmask_from_clk_id(clk);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	clrbits_le32(base_addr + plat->pllgrp, plat->bitmask);
+
+	return 0;
+}
+
+static int socfpga_clk_probe(struct udevice *dev)
+{
+	const struct cm_config *cm_default_cfg = cm_get_default_config();
+
+	clk_basic_init(dev, cm_default_cfg);
+
+	return 0;
+}
+
+static int socfpga_clk_of_to_plat(struct udevice *dev)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	plat->regs = (void __iomem *)addr;
+
+	return 0;
+}
+
+static struct clk_ops socfpga_clk_ops = {
+	.enable		= socfpga_clk_enable,
+	.disable	= socfpga_clk_disable,
+	.get_rate	= socfpga_clk_get_rate,
+};
+
+static const struct udevice_id socfpga_clk_match[] = {
+	{ .compatible = "intel,stratix10-clkmgr" },
+	{}
+};
+
+U_BOOT_DRIVER(socfpga_s10_clk) = {
+	.name		= "clk-s10",
+	.id		= UCLASS_CLK,
+	.of_match	= socfpga_clk_match,
+	.ops		= &socfpga_clk_ops,
+	.probe		= socfpga_clk_probe,
+	.of_to_plat = socfpga_clk_of_to_plat,
+	.plat_auto	= sizeof(struct socfpga_clk_plat),
+};
diff --git a/drivers/clk/altera/clk-s10.h b/drivers/clk/altera/clk-s10.h
new file mode 100644
index 00000000000..f5be1e68500
--- /dev/null
+++ b/drivers/clk/altera/clk-s10.h
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ */
+
+#ifndef	_CLK_S10_
+#define	_CLK_S10_
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+#endif
+
+#define COUNTER_FREQUENCY_REAL	400000000
+
+#define CM_REG_READL(plat, reg)				\
+	readl((plat)->regs + (reg))
+
+#define CM_REG_WRITEL(plat, data, reg)			\
+	writel(data, (plat)->regs + (reg))
+
+#define CM_REG_CLRBITS(plat, reg, clear)		\
+	clrbits_le32((plat)->regs + (reg), (clear))
+
+#define CM_REG_SETBITS(plat, reg, set)			\
+	setbits_le32((plat)->regs + (reg), (set))
+
+struct cm_config {
+	/* main group */
+	u32 main_pll_mpuclk;
+	u32 main_pll_nocclk;
+	u32 main_pll_cntr2clk;
+	u32 main_pll_cntr3clk;
+	u32 main_pll_cntr4clk;
+	u32 main_pll_cntr5clk;
+	u32 main_pll_cntr6clk;
+	u32 main_pll_cntr7clk;
+	u32 main_pll_cntr8clk;
+	u32 main_pll_cntr9clk;
+	u32 main_pll_nocdiv;
+	u32 main_pll_pllglob;
+	u32 main_pll_fdbck;
+	u32 main_pll_pllc0;
+	u32 main_pll_pllc1;
+	u32 spare;
+
+	/* peripheral group */
+	u32 per_pll_cntr2clk;
+	u32 per_pll_cntr3clk;
+	u32 per_pll_cntr4clk;
+	u32 per_pll_cntr5clk;
+	u32 per_pll_cntr6clk;
+	u32 per_pll_cntr7clk;
+	u32 per_pll_cntr8clk;
+	u32 per_pll_cntr9clk;
+	u32 per_pll_emacctl;
+	u32 per_pll_gpiodiv;
+	u32 per_pll_pllglob;
+	u32 per_pll_fdbck;
+	u32 per_pll_pllc0;
+	u32 per_pll_pllc1;
+
+	/* incoming clock */
+	u32 hps_osc_clk_hz;
+	u32 fpga_clk_hz;
+};
+
+/* Control status */
+#define CLKMGR_CTRL					0x00
+#define CLKMGR_STAT					0x04
+#define CLKMGR_INTRCLR				0x14
+/* Mainpll group */
+#define CLKMGR_MAINPLL_EN				0x30
+#define CLKMGR_MAINPLL_BYPASS			0x3c
+#define CLKMGR_MAINPLL_MPUCLK			0x48
+#define CLKMGR_MAINPLL_NOCCLK			0x4c
+#define CLKMGR_MAINPLL_CNTR2CLK			0x50
+#define CLKMGR_MAINPLL_CNTR3CLK			0x54
+#define CLKMGR_MAINPLL_CNTR4CLK			0x58
+#define CLKMGR_MAINPLL_CNTR5CLK			0x5c
+#define CLKMGR_MAINPLL_CNTR6CLK			0x60
+#define CLKMGR_MAINPLL_CNTR7CLK			0x64
+#define CLKMGR_MAINPLL_CNTR8CLK			0x68
+#define CLKMGR_MAINPLL_CNTR9CLK			0x6c
+#define CLKMGR_MAINPLL_NOCDIV			0x70
+#define CLKMGR_MAINPLL_PLLGLOB			0x74
+#define CLKMGR_MAINPLL_FDBCK			0x78
+#define CLKMGR_MAINPLL_MEMSTAT			0x80
+#define CLKMGR_MAINPLL_PLLC0			0x84
+#define CLKMGR_MAINPLL_PLLC1			0x88
+#define CLKMGR_MAINPLL_VCOCALIB			0x8c
+/* Periphpll group */
+#define CLKMGR_PERPLL_EN				0xa4
+#define CLKMGR_PERPLL_BYPASS			0xb0
+#define CLKMGR_PERPLL_CNTR2CLK			0xbc
+#define CLKMGR_PERPLL_CNTR3CLK			0xc0
+#define CLKMGR_PERPLL_CNTR4CLK			0xc4
+#define CLKMGR_PERPLL_CNTR5CLK			0xc8
+#define CLKMGR_PERPLL_CNTR6CLK			0xcc
+#define CLKMGR_PERPLL_CNTR7CLK			0xd0
+#define CLKMGR_PERPLL_CNTR8CLK			0xd4
+#define CLKMGR_PERPLL_CNTR9CLK			0xd8
+#define CLKMGR_PERPLL_EMACCTL			0xdc
+#define CLKMGR_PERPLL_GPIODIV			0xe0
+#define CLKMGR_PERPLL_PLLGLOB			0xe4
+#define CLKMGR_PERPLL_FDBCK				0xe8
+#define CLKMGR_PERPLL_MEMSTAT			0xf0
+#define CLKMGR_PERPLL_PLLC0				0xf4
+#define CLKMGR_PERPLL_PLLC1				0xf8
+#define CLKMGR_PERPLL_VCOCALIB			0xfc
+
+#define CLKMGR_CTRL_SAFEMODE				BIT(0)
+#define CLKMGR_BYPASS_MAINPLL_ALL			0x00000007
+#define CLKMGR_BYPASS_PERPLL_ALL			0x0000007f
+
+#define CLKMGR_INTER_MAINPLLLOCKED_MASK			0x00000001
+#define CLKMGR_INTER_PERPLLLOCKED_MASK			0x00000002
+#define CLKMGR_INTER_MAINPLLLOST_MASK			0x00000004
+#define CLKMGR_INTER_PERPLLLOST_MASK			0x00000008
+#define CLKMGR_STAT_BUSY				BIT(0)
+#define CLKMGR_STAT_MAINPLL_LOCKED			BIT(8)
+#define CLKMGR_STAT_PERPLL_LOCKED			BIT(9)
+#define CLKMGR_STAT_BOOTMODE			BIT(16)
+
+#define CLKMGR_STAT_ALLPLL_LOCKED_MASK		\
+	(CLKMGR_STAT_MAINPLL_LOCKED | CLKMGR_STAT_PERPLL_LOCKED)
+
+#define CLKMGR_PLLGLOB_PD_MASK				0x00000001
+#define CLKMGR_PLLGLOB_RST_MASK				0x00000002
+#define CLKMGR_PLLGLOB_VCO_PSRC_MASK			0x3
+#define CLKMGR_PLLGLOB_VCO_PSRC_OFFSET			16
+#define CLKMGR_VCO_PSRC_EOSC1				0
+#define CLKMGR_VCO_PSRC_INTOSC				1
+#define CLKMGR_VCO_PSRC_F2S				2
+#define CLKMGR_PLLGLOB_REFCLKDIV_MASK			0x3f
+#define CLKMGR_PLLGLOB_REFCLKDIV_OFFSET			8
+
+#define CLKMGR_CLKSRC_MASK				0x7
+#define CLKMGR_CLKSRC_OFFSET				16
+#define CLKMGR_CLKSRC_MAIN				0
+#define CLKMGR_CLKSRC_PER				1
+#define CLKMGR_CLKSRC_OSC1				2
+#define CLKMGR_CLKSRC_INTOSC				3
+#define CLKMGR_CLKSRC_FPGA				4
+#define CLKMGR_CLKCNT_MSK				0x7ff
+
+#define CLKMGR_FDBCK_MDIV_MASK				0xff
+#define CLKMGR_FDBCK_MDIV_OFFSET			24
+
+#define CLKMGR_PLLC0_DIV_MASK				0xff
+#define CLKMGR_PLLC1_DIV_MASK				0xff
+#define CLKMGR_PLLC0_EN_OFFSET				27
+#define CLKMGR_PLLC1_EN_OFFSET				24
+
+#define CLKMGR_NOCDIV_L4MAIN_OFFSET			0
+#define CLKMGR_NOCDIV_L4MPCLK_OFFSET			8
+#define CLKMGR_NOCDIV_L4SPCLK_OFFSET			16
+#define CLKMGR_NOCDIV_CSATCLK_OFFSET			24
+#define CLKMGR_NOCDIV_CSTRACECLK_OFFSET			26
+#define CLKMGR_NOCDIV_CSPDBGCLK_OFFSET			28
+
+#define CLKMGR_NOCDIV_L4SPCLK_MASK			0x3
+#define CLKMGR_NOCDIV_DIV1				0
+#define CLKMGR_NOCDIV_DIV2				1
+#define CLKMGR_NOCDIV_DIV4				2
+#define CLKMGR_NOCDIV_DIV8				3
+#define CLKMGR_CSPDBGCLK_DIV1				0
+#define CLKMGR_CSPDBGCLK_DIV4				1
+
+#define CLKMGR_MSCNT_CONST				200
+#define CLKMGR_MDIV_CONST				6
+#define CLKMGR_HSCNT_CONST				9
+
+#define CLKMGR_VCOCALIB_MSCNT_MASK			0xff
+#define CLKMGR_VCOCALIB_MSCNT_OFFSET			9
+#define CLKMGR_VCOCALIB_HSCNT_MASK			0xff
+
+#define CLKMGR_EMACCTL_EMAC0SEL_OFFSET			26
+#define CLKMGR_EMACCTL_EMAC1SEL_OFFSET			27
+#define CLKMGR_EMACCTL_EMAC2SEL_OFFSET			28
+
+#define CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK		BIT(0)
+#define CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK		BIT(1)
+#define CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK		BIT(2)
+#define CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK		BIT(3)
+#define CLKMGR_MAINPLLGRP_EN_CSCLK_MASK		BIT(4)
+#define CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK		BIT(5)
+#define CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK		BIT(6)
+
+#define CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK		BIT(0)
+#define CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK		BIT(1)
+#define CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK		BIT(2)
+#define CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK		BIT(3)
+#define CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK		BIT(4)
+#define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
+#define CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK		BIT(6)
+#define CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK		BIT(7)
+#define CLKMGR_PERPLLGRP_EN_USBCLK_MASK		BIT(8)
+#define CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK		BIT(9)
+#define CLKMGR_PERPLLGRP_EN_NANDCLK_MASK		BIT(10)
+
+#endif /* _CLK_S10_ */
-- 
2.43.7

