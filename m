Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51418CD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8A5849EA;
	Fri,  5 Jun 2026 03:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TsDLDO+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F4C849CA; Fri,  5 Jun 2026 03:58:21 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 886918490B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORBPWRweZpG0uSd71zTFD4e8j/eJNew2rW2TVQ9UKxZSzKNrNEOQOicc/W6dKfSxV0SB2/G74/bVWomBfMIOardJ8ojDLVa1bh+H4h/mrTEIdJ3IpVg1htbq0gj33RMXabThWtjuPCd4MCr9QCvD2J5Mx+2YHurOY57JqQx2sLcnPf7Jk1z5ey6uLswPiMYvhPZuUh1pW1HK9BhVw70paPHurzwBKIb+PcUMORA1rRZdCTvhl9ZTJKNdfIqNBjsZJelsRGgQcnc4/wWPuXJAH83OVoU65HQ9m0rdb3aqJq2yvPzgXnunb2KhyKXBENKkE/LboO6xLKRZVomER36mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l54pWBCSaPjCsisZosWgr6x52MctA+Gtlj0mN1Qhh3Y=;
 b=XwnI49S7nG++gdZJjyPa3yboHZJGu2/N8/Afp9k+mzGFIV5i99RpnWmTrQdbUoMmCrGuea+tF1NRPtRTj/22QDlBJMN+y3LRZfykYmmXf6mPqnKyJ9lbScpMS8ENHaybMOtNA1d7VpFUvEpbMnTUE0TPWWjQqyvq5dMp39B0+3CteVaNlDwdNn5HffLMC/NqatElGfk2gPkQNPpnb32hEVl4ebl/VxgyPPHQCx15csKFBPz9hyJAJkrIFK2Q6PRXyt2/P+OZWJkoWuAPGZgnayXsHrgAZxCYKAi9KicumBpUHaR8zRmxJIX3qdgwIfa+tS8YPOQA3UEJV/V3cDXxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l54pWBCSaPjCsisZosWgr6x52MctA+Gtlj0mN1Qhh3Y=;
 b=TsDLDO+HZdCK4p/j1Mp1/URcLBu31i7PKvKAnznNHmOc/zONpMRzqjQp0ea7HF1EWZPKkI0PR0i+3TXdPA8d0SSZbfuer0t2NIqAAwrRK8hRS8+VNPRuh9193XsqTEV7/4EXFejfmbny/Enosquw0OmjGAbto/Wy1XqxcedI34Wo5XBMmnVFVl9/rNoAFjZhTbxGIkYpk8IudNSWXMy2R48/WeH+rOH0/BUNQsgrjI2LGai76GqQ+Wr+iTGuEqova+UK8Ktneb5BjKX9D08zrVmrZev/L8PwCmRI5ZOwQEW7y+eZCpDmUXd0K7mIWkR/dtWUh3Vm9XDtVyDKGDufUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:59 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:59 +0000
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
Subject: [PATCH v4 7/9] clk: s10: Refactor S10 clock driver
Date: Fri,  5 Jun 2026 09:55:01 +0800
Message-ID: <20260605015503.11709-8-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 106b41a4-2bf5-4f72-d9d0-08dec2a5ba42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|3023799007|6133799003|11063799006|56012099006|22082099003|13003099007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: ob+jIrIfl79gWTWUdbM2Lzysauf4iXxKQ/QviiqRQ96L38veZJaivllolvm8kygtPt7G7B9G/GgFEb7v0Oo2dVnh0INkT+Mj2L6WKiiCRsxMOegJzl8Rv3yh7tUb/5vr83D33oLCKvaN5oap4qzuMruZIv6Sb3T63MCfxLIPDyEzyLsFdNUAy1Oy72Aze9Szn2iwWo9m1yBOhhpimxifT1DG5cjr0tVlOsPFeFCkdBWrurxCRO5bEkPc0c4NJKd4S9Loyc9yvch4Ol6ivwEgEdwG+hM6SRxk0p5sspj9B3h2tXKGLStl+4u0bnm3GCtzIs+pyawgT5GOykCZ2e+oOzKmT+SCqmWMtzQiBcPv9q3mjrIVurg901PDBelFB1YRQJ9AV+oYb3U/O2LeplcjgXqFRup98Ko5BI9NRFVPSrInCSJht8xP7aiRSE3zknTBi/elL+2mM1I27fZc9Kl8Q009VEAojNe3YKfwmJTlS88lakkzEz03qdWH9oVt26UbQQ2qlSjYixOQKVADrDNKsXOOF+E0P0/3FuuOWWx006sAgxG6ulWbDl3c6laexI9kiJ9QAUKlYnSx0m7AqidQoCSMbAlGh5LtPEsxrH2DVEFjbMDF3ktAHBsOO7t9sBbYtWDzKL3rceCX2gnz/jBnuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(22082099003)(13003099007)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Wh65AtamD50eNgVs8SDnKNAUE3ap+PZohKWH8v/MT5c1ag74HDwFdWzorHs?=
 =?us-ascii?Q?fAxP3kkJ800NcZaBrzttpd1GpJlPYV6MGfBME5ivGbQghelJ/4keUV+iVttS?=
 =?us-ascii?Q?fmE0lwH27sxqo6DT2YFCG3FX35ryub+MVLB5kDYWU0SwihUikXnzxRolnENd?=
 =?us-ascii?Q?wKH9kv0kUY2kz7F+su5bR1GNhKSesPyxLmprClXDSXTmQiUS42fFFxT226TQ?=
 =?us-ascii?Q?1ieI00irrDKGt50SVmG5OMfcUlXAN42asEwBChSSR+1SedMK0nvG6Bz92MG3?=
 =?us-ascii?Q?bHH+agkNG1aRhvrKvEVzjnT5L78rBQEJxZpXshXoN9wsnOD43zz51eS2Imno?=
 =?us-ascii?Q?/fei0AC1j6P5Fp5RqNfK820m3x4Sp0Mho+duLayw4ANyEwjlB3/BjuFWkdvj?=
 =?us-ascii?Q?qLsrE1yRtcEEHjg7zbvECrC7JLqPJ0hiwwoaf+WchaGwcQvH4Wr2M0P0wKEG?=
 =?us-ascii?Q?j1hwmHL4+qMYqPXXX0YuTBQj3kUSWene25V4WRoU5BR7swySDZ7nXwGJQt+p?=
 =?us-ascii?Q?RuvWXpOzLV3rKkdug5y31GEhqTi/0TToXuPN1Q8a7Nu4dqAJW9SghHukPiQZ?=
 =?us-ascii?Q?1KZIHo8rguCpOKyeMt8LbcetL5f2dTsh3zp4vgyZy/l2JRRSSBHNdhz9ljZZ?=
 =?us-ascii?Q?dRXJ4R4Qiu1QFtOYy8Dfwh4j/BZBJ8e9UerLMe0SKy5jknpOrJiLzDCrHm3L?=
 =?us-ascii?Q?MewN14Sz2aoMzxZlszp3m7VjAUE4GMvhmR47O/tNxa01bZlRsvdL02ar14E4?=
 =?us-ascii?Q?vwDVmvF81VjSN7PFqinS8YKHOaneTf9KoqMCVZEtHAKiLu1m3te1pTmD6crw?=
 =?us-ascii?Q?KJHtiwsYPfUqKVRhzO+Io1hLon5FpvT0a3SttLZ3XCPO1vlzN7wbdjh8NLy+?=
 =?us-ascii?Q?HdelsCaa7WJrihdEZJsL3W1L88BxGn7DF74enIi+lNPlDZ4j2voB25ek6RJV?=
 =?us-ascii?Q?+SsdHyTdpmJsXcH03YHwX7kekShb6AERc4HM6s9wbahYGfodcywTj1D9fCHO?=
 =?us-ascii?Q?cJ7L6OSeGOeOqElOk3AiS+k2OQ54QEgV8S0sol/yKN55cnSI+SpxXtdpHED6?=
 =?us-ascii?Q?UFnMCRznQcNKas/eWjDhSqEtnOBhWXCg7pnFMgP1Xm6Rpj51mAFGyw0vjAYF?=
 =?us-ascii?Q?ghc+NfxYgUTkr3QO7SlJ8z0yDYhlt0JyJ/vpFjVAxD/VBtBDmsakYsNEsGwx?=
 =?us-ascii?Q?2QgMmm/pgeVX2y1TRLxzKwIkGznF66B61968Bt5CBtXkruMzU2SMREp4F3zQ?=
 =?us-ascii?Q?THeOuoTbUWty9VPjcnmBlLqv/wsPAFtJWUCKNhChlIVyad2pWspFctEKBDbk?=
 =?us-ascii?Q?Pv/YovtrDqQK/TPQlr3mY/5Oca7txFIoa52ST+g8jky1Um9A14vC/1cHpHYk?=
 =?us-ascii?Q?aE2vDGu/TGqhXITXbopsU82KCC+jSoak5lJnt/Z4l37e0HDl/M9M78bUZcVY?=
 =?us-ascii?Q?ZVoZ5FGyB1kWbbaWfK9qdQn7xrlBO/LYwWqS6DU/03jDii20Y2q59lfIjU2D?=
 =?us-ascii?Q?0J4/4fhy0XmXroTra02GmR1013hwsO9VLYu+YYIQvVQV43xfyER3mh2jmhYP?=
 =?us-ascii?Q?t7igSp9YK+/CayyjYurRdbT2JtGUBN81HsaKbcUiG/eph6cYc2A3ZUKvmf//?=
 =?us-ascii?Q?95ydZkK/kjyLlLEQiTdL1P1V6purUWH9me/4eE2CdGidppSxm6Sz67fRGL0s?=
 =?us-ascii?Q?ucBRn0m1XOmqYmY5B5rIDwI04BC/6CKkigmYqiAocmU0litFtaTNhQvsZ9+O?=
 =?us-ascii?Q?Z0cVOF2aUGg0wgWRX6MMN1K4Y5H9QFY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b41a4-2bf5-4f72-d9d0-08dec2a5ba42
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:59.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K6d+mNyw8kepdeS6KfujAbUc6FaNEaxFgAK2YQrSod1JhT9NZB7FByrjtrZ002Kj3213MsReZLXkNznPSj+0WBSWDfsPTrRHX7Kt6v+mtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

(no changes since v3)

Changes in v3:
- Retain Intel Corporation copyright notices
- Add clk_get_l4_main_clk_hz() for STRATIX10_L4_MAIN_CLK clock rate

Changes in v2:
- Implement using real hardware clock source frequency following Agilex
  clock driver

 MAINTAINERS                                   |   1 +
 arch/arm/mach-socfpga/Kconfig                 |   2 +
 arch/arm/mach-socfpga/clock_manager_s10.c     | 448 ++-----------
 .../include/mach/clock_manager_s10.h          | 175 +----
 arch/arm/mach-socfpga/misc.c                  |   3 +-
 arch/arm/mach-socfpga/spl_s10.c               |   7 +-
 drivers/clk/altera/Makefile                   |   1 +
 drivers/clk/altera/clk-s10.c                  | 616 ++++++++++++++++++
 drivers/clk/altera/clk-s10.h                  | 203 ++++++
 9 files changed, 887 insertions(+), 569 deletions(-)
 create mode 100644 drivers/clk/altera/clk-s10.c
 create mode 100644 drivers/clk/altera/clk-s10.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bc4abd21dbc..41dbd5527a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,6 +171,7 @@ F:	arch/arm/mach-socfpga/
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
index fd27470f967..5b7058a0744 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -1,425 +1,79 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2023 Intel Corporation <www.intel.com>
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
index 5dcbda9473e..dc4c0964ab1 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager_s10.h
@@ -1,177 +1,14 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
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
index 893579f17c1..d803c13cdd9 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -37,7 +37,6 @@ u32 reset_flag(u32 flag)
 
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
index 00000000000..20de98cdbe9
--- /dev/null
+++ b/drivers/clk/altera/clk-s10.c
@@ -0,0 +1,616 @@
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
+static u32 clk_get_l4_main_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_L4MAIN_OFFSET) &
+		      CLKMGR_NOCDIV_DIVIDER_MASK);
+
+	return clock;
+}
+
+static u32 clk_get_l4_sp_clk_hz(struct socfpga_clk_plat *plat)
+{
+	u64 clock = clk_get_l3_main_clk_hz(plat);
+
+	clock /= BIT((CM_REG_READL(plat, CLKMGR_MAINPLL_NOCDIV) >>
+		      CLKMGR_NOCDIV_L4SPCLK_OFFSET) &
+		      CLKMGR_NOCDIV_DIVIDER_MASK);
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
+	case STRATIX10_L4_MAIN_CLK:
+		return clk_get_l4_main_clk_hz(plat);
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
index 00000000000..c32c3421f31
--- /dev/null
+++ b/drivers/clk/altera/clk-s10.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
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
+#define CLKMGR_NOCDIV_DIVIDER_MASK			0x3
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

