Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603C9CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2FCC8328F;
	Thu, 28 Aug 2025 15:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cyapfdMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5049283322; Thu, 28 Aug 2025 15:52:23 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1417A831C2
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8uG32dCia/Ipd/QGu5u4Om3/UVRbp6pPbaOsNhI2Qc24zrCku+vklur4jAnHr1KkBWmv1DTM8wD6isH3tx3GqsYwIy2H/kKJNA8zUpuBd7y1J3h3zjJsTMniNkTa5Ybd+ggRd0WamEo223T0LKG0Rdi8e3upOqEifBg78DvUxHIZfgJ4uOhnrXETXAp5rYtWz3h8l+x6Gpqj6ruZdtqLDnZ2GcDbBGUPWbhQ1P/niwgWLZfl1RetSCV0CXTcKcaNCxwYNgj3WM+3iFeHWDbL8xrIwnMEarOV/2xCcYg5R8jrdKSMo5gO9IjRYmNK4+xLdRiidLl7urMOK7Qe6taxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5NTUkGL825KGFZqqr7VkFWLIQ7vMmEFRyBcGHPqhM4=;
 b=ULil3Fs29x5hgwkDRe4nKpjjxGfk/ZyU9XZlh014ARriTNyqy9IAuvnEHmzoc6N3HcItAFOBpI2QQS5HrKV1JuEiSLwm1MaqLcGiWkwF2AaSxCqn+xQam0fvdXVJ7dCNIpF1Y8qWJUJ1QbwBwlgaHMG338hOlnlK8ywqaZ72e0AeKS+8R8eAYghjnblCkkshhwk1doVFZgj49OLPzOv9fupInTR50RHmm0Zf4UBDfdOzNTA94JeHwj38sJVkIOvhDDfo6fuVvmNKpGo9d/0++3pN+qkSU0gnOwnR8VjRwmh+xvs3jYQxzp5H9XGWfOsuwpieANPcqYFxRn+8foyarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5NTUkGL825KGFZqqr7VkFWLIQ7vMmEFRyBcGHPqhM4=;
 b=cyapfdMbPjgnH8cvBSmt+oanNPxfR1GlHISwI5LFHbjn+DVDTML0LzM0g42d1MfYkvrbUTYJJFp8+OGStesGiK/cxOki+vjqkaOHlPAahgnYz5Q2zhr0degAbs1TMsVBL+/18p0fqLc5d3MI6bYYFRS2MSXJqiDAMDzdwktHteOhQSUoyIwreXhb9D4VWgoPZbzpwit17XWGoY851JIOc2ot+p2d4uri0TB8krRaRi4tBLD9U3Hxw0APoIRKZRHIRhYhxtsA9PnUH31VsMK3mfW9Kl04Q4Fg/BXVkvtSIM8bXJnuyfhmjyEqRO29TaF/2U0jz3GR/dm6nllnjXXW5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA3PR03MB8325.namprd03.prod.outlook.com (2603:10b6:806:45f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 13:52:14 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 13:52:14 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source selection
Date: Thu, 28 Aug 2025 06:51:52 -0700
Message-Id: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA3PR03MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: c3305e6e-f6fd-4993-6b49-08dde63a17d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?46Q9RcgirbTErwdV4yCR2OWqOohjrKJnLdHJHblkngRwbXY1lgkidsZisSpJ?=
 =?us-ascii?Q?P8ZreBQwJkYOrIwZCJBVBcu86DdPYL5Xr7kJn2T4tHs7nNw1CGOp+xlMfwOT?=
 =?us-ascii?Q?YXlq5+wUG4WSC4xQ/KYO2wswc3K+jpfagdJfvR75H2qqur/37xr8C/TueBci?=
 =?us-ascii?Q?atL2H1Z2FsB5F3uZVEL8eQL0Gzvv5lSwdckmo/nzABRuK7dItvKSzUMArE7R?=
 =?us-ascii?Q?If/Dnh5ibEvqoyBnqTItwxjb37nHIqhnT1ImtdDaIf2T5u6KdAHb9Y99n1lv?=
 =?us-ascii?Q?jwYprSC07z0T60d5uHrtpdgu2xZ+5lLUOeE2HikZ1Qg1SUs14bIZCX7gj8LS?=
 =?us-ascii?Q?DQ2kW3wGzH+qd7oz0Torof4cKrKSgaz+9igEOozi47Ev62uYllRVlPgu9Dqs?=
 =?us-ascii?Q?VhwYcFqkKTDcyDzhW6ITrebNrBtAJ4UAzgL0fV2Hb5iDUl8znB0YWsx8k82x?=
 =?us-ascii?Q?R0aYPydt/d2p+sjrIKIrw/zWiIhm+1uMKPbkIPw3zgnBPUq1tpx0qsVuua4s?=
 =?us-ascii?Q?iyiUaGOiXuFNpM2O4B6+659gyuwluTLO/JrIU0PdVu0vZKOdz8BGCP5wMBJc?=
 =?us-ascii?Q?8NjqdPKhd+HvqC97QXEmF2MFPsb9MtBB7p5ZeLdnY5nkOubdfJ1cDwFo6edB?=
 =?us-ascii?Q?TACiQZRtlKuJhbwIZmW27+oT8ShYdRHaYj1BWzd0zVJ+5+myC7CuQN0ovDaL?=
 =?us-ascii?Q?60vnVgyakYjxksQ9tFLgKZaTn36gCtRTnYBzeI/xfhZ54ZadwrsGDgRZujUp?=
 =?us-ascii?Q?JcveGDnGnOiLvXhmr9MrMdcEiilKM6DqfDdRD7A2z0C31VaXFaFPdWdNSqEB?=
 =?us-ascii?Q?EFVvcIIw943c0VYMkvQ6oNUArEJxmmrXsjTzsgGwFFmsOHBJejK2O9b+tco5?=
 =?us-ascii?Q?mo+fo70niBlheKfv36GhEwwOCENaBlX6sB0nZdzVuItrwkbQ38wwAt2it1QD?=
 =?us-ascii?Q?k7Jd5l6scKtU+FMn0yHOIgAms5gStqdIWYFR08NbxMlN1tYDDIKiaShAHxE+?=
 =?us-ascii?Q?SLmclzXtudMIBtF8xdZm+vHqEX+mc1P1Iz+YZVdDQr8xw1rvpsbgKIYaYKWR?=
 =?us-ascii?Q?/vjz9siD0mbSRwPopQ6hLajc6nboAt9iiZBBK9KPPlBHR2zgCE/4onJmFSjA?=
 =?us-ascii?Q?6tbcB9v9uDNUPTaXxQ6YE75aAJXtx+wuGVRkMqx/vuM1+j3BPXP2oSWVu/dY?=
 =?us-ascii?Q?HgTLcRY4iul2kpJYPxSVqWhr7VptsIwmikrN7ZfcYzAiqxFK4igCBFRrCfi7?=
 =?us-ascii?Q?hnfXGzittIolaugKiZ5KS+dmpWi8GDM4uZaLHix2fucMz5uSiR7krZSNGmLy?=
 =?us-ascii?Q?UGawPBPVCOTzOM2uNJZPWCw+fCY+3hZkjHQdRPlazPOPA3+Y4fF7KqJUdAXP?=
 =?us-ascii?Q?IXFPC9U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rg5y6IzsDUxMBJPPnjpIiXQQpOqRPBsOLCPfPZrp1XPvmGO9BYjbdlDJK8cA?=
 =?us-ascii?Q?ELEJi6Jhi8UOOD9eLlRtKsIVx3nO+s46rKf3qGsY9UyeB6W1Cu/4kNpzVZKV?=
 =?us-ascii?Q?AwP2lTdg0R1PAubsfjAGPgnGIlVdcHFODnik8fH0K/jMhXSe/sCceRVW6Sge?=
 =?us-ascii?Q?QMa5Rr8gjDxZaJSqlg33ki6pSng/qEKQHbUcSfZQ8SsJSWkJX2DCsbQqS2RC?=
 =?us-ascii?Q?xGPptYsrt8WuvXZwct+M1c0yPzJszWF4rf/2Us1xunou1XMGgq5FO/Hmy12s?=
 =?us-ascii?Q?I0LZF3sO4VUcxPFbM5fKcg3PG8UbPALcAZMsl+PQaO5f/ZQqFBgBqDq4GG5Q?=
 =?us-ascii?Q?qrxS1IUv/pFIJCKnP6kxnEbE4oQJR+9tXdWLYPKIf9lPFde/Ib3VBCk2jiZC?=
 =?us-ascii?Q?/xtjpJuxAHYYY58MOh6G2tcgy0k5ICXbw172H2gdw1YjMzSHOCcPlfP/fg8v?=
 =?us-ascii?Q?VqoPP7xQivyOHy4/MjA1PMj8Kn0KBmKKENjJR7i7ljtZZpeNrEDNYa/nsjj5?=
 =?us-ascii?Q?CNFxfkuRwucS/UFlV7FWOJK7oXeZU7Ylj7unBdxWP9OUUMzedwLW7dQd9ZD5?=
 =?us-ascii?Q?riciEdhQSM7pVSLeEkdiHm45V6oDOLd8veUXZf0anUnVlapWPX74CIyvdfbF?=
 =?us-ascii?Q?GyADDKtLnj2e3U8saKyhDBnllr645oiurJI7PEEKNLp+xDwolpQc69gaIhd8?=
 =?us-ascii?Q?S9n0Y2rAdBKzLgDNItE6g4A9f9ZBUjq1mSLGt/mBr/OTso7mAL4Owfdl4cVr?=
 =?us-ascii?Q?Wh2LT1FRDd+BtaX/K6bYs8/efvxKL5DWecMESKxy0+qc9kuZwKXaueiGsRlv?=
 =?us-ascii?Q?xX23X/nBnFRrGS6ZjqkKly5uMmmbJbILM5tokgmK0T4gMIH1iqnZhnrVqx9g?=
 =?us-ascii?Q?xgLHxvyr/BmsT1M36XwhhdrKlGsbmqm7eEP4gVgEjEhOzV5td5gUlIer/WO6?=
 =?us-ascii?Q?EHRsQDNyBsngftlfNkpUqT3Qyt+GtF2ihGP9t7gtWzsNVszIWTGVyS5aq4Eg?=
 =?us-ascii?Q?dRpksB++o17V8tVIXK18hB69LF0LT31hpLbPumyUgF4c2U2/wMSU7BY6PpKm?=
 =?us-ascii?Q?Azz1CEaP8tsxMNz3c6l0D4bWpWyg/gm9dvA1gyD1bo/Aru09ALnOGjG0Ds8V?=
 =?us-ascii?Q?Lk5vCOGQxafLARDqwl3RWSD+Na6OAj1jozZOqy1X/UiaSM4mDnWNauve5yDG?=
 =?us-ascii?Q?aoRqk2Iv1EwvphUcwhhXo50256WTRnMRCjzxp3FWlrr7CKByCyjtkosWz7zu?=
 =?us-ascii?Q?SCUBbkM2zrbgMymBzii3x/9Ksto2IHCdgq1QAv7VSRg2NLbEUMtTtD3Bht72?=
 =?us-ascii?Q?UTjlbidf1A2BMmWLVqHL4gPYCo7gm+B24vJz2ZGVzdFvnKyJ391PtAnJHQvJ?=
 =?us-ascii?Q?GTIIupUPspVixaY39aOSFfMXBau0hrBRJumtv2iD83H4ZTB5HhVxlikLBcba?=
 =?us-ascii?Q?HlVwoD5zVmxV8ncZncHPlNSPlpiXTp7X985AHVtoNMfk8FNGiGB/brYkZR8N?=
 =?us-ascii?Q?d6RspZxO+Cukd7pOe8ju6hjTn/3P/tEvGPoRd7O9MesOjGUHUbbzUR505sdF?=
 =?us-ascii?Q?L1Q/Kt8YFQwMH0x6/uJ7ExGC4j1nSnkAMnDv+zAF732rj3MqX7mCxTf9XDSQ?=
 =?us-ascii?Q?Mwle6Mk3fnCDGls+khzvwSQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3305e6e-f6fd-4993-6b49-08dde63a17d1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:52:14.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WEAit+Y54lxbMDXccdqmdchdptaGU92gsYr1+1VlSO9KGa+vrhLcDeSkcZ0oQET1KCr42MIMDgX39nVnqGmqnK0FGKimof+MVRAABOAYEaA2M4kaJoUWX6boI/uxO+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8325
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

Fix the incorrect bit masking and bit shift used to compute EMAC
control which in turn is used to select EMAC clock from EMAC
source A or B.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index e1ddd02f356..2ad8cfd8856 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <log.h>
@@ -11,6 +12,7 @@
 #include <dm/lists.h>
 #include <dm/util.h>
 #include <dt-bindings/clock/agilex-clock.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 
 #include <asm/arch/clock_manager.h>
@@ -515,14 +517,11 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == AGILEX_EMAC0_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
 	else if (emac_id == AGILEX_EMAC1_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
 	else if (emac_id == AGILEX_EMAC2_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, ctl);
 	else
 		return 0;
 
-- 
2.35.3

