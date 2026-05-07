Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04196CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2806384AAE;
	Thu,  7 May 2026 14:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ChAZAkEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1F784A30; Thu,  7 May 2026 11:02:32 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BAA84903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw14wISAPkly72llr7LtgU166ZQg5yhN0hRxkz2Nk3lSSfG+L1qznl+TL/myWe+EwkDZXfVbQ/JbZdlTFt/T4AtsjGmyTTd+Ma+hP4BkFWj8vZSeztvmJxvsderQcU3Gi059t+6iVqE3tkHmWDQqfxT9PNEa2ozzbrnKAz5uCqfXuJGz/MEcsspsoqvf0Uji53gwIOgM7pePHQ3FoTrV+qq5dYsZTc5mXDdzCdPqVhBCggj6NzNvqdQPing8nbcq/1mqsTW4/FPkBTYLjubaoATLPJdJnNWh+LznzDlO7ywk3PTYjHpHGAsIKgNsELQUBOfsTL7OzAqezrSSH2tYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP9n71upYKp/o39VxRBwm8k+Bu23dLD1bTguG7RgBt0=;
 b=BV7QqWIJaC8oVLXh2TIs4CHRG6WP8SoeWh8lm+3DRzYKJb7d4nXgEGkX/IeJ7Hl3OMPDTiFIKKBUp2QX2Im+FzQH+GCjYSBHvhVxCNSlfOjRmdUbpzMr3soCBwCsYhSI4UhKj3kFbt/mow9bHOLqlLixSdxsL0M8JlvfmNQZeqTN02DhD2yYvUaC1Sr6th2x6f9HbUBBexZ8yxytvmqrnid/ijjtrRbSmgOhDtEgmde5kqrXkPvqXKKsb8oLY7R6fErAkWu0S73/SETrfOaYSnZZw5+IZldjn0gUpfiZTCwnJ90nuaEhO62AKLeQ7CLL4SXs+Sr5dYUiHlsj6T8ERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP9n71upYKp/o39VxRBwm8k+Bu23dLD1bTguG7RgBt0=;
 b=ChAZAkEIklhjeTfBKzh7iUYj29tzjdUPE7+1cPYkSS9862tIXk0TucN/2HKTBMzBwoVlRKMfSEXeFfqcenWujzFvx3bAODYgCNq8QKxNb5lfibSRQjLKHDFWWQzxQeXEcJLf7rZn1f8hwHEKOCimPuw6Ko6W7+mME8VaZmjsvNjRkV0k86pkkLQSLzlB6g0XefHdWj6nbt6X9UotvTLKL/5QBo++O3J1D1PA74TPSiXLP1H3nFaldZ2lAyTXApfYqWJAEfJIjG4tufLNvGAAvjVMG1KlcTISYDDV812Id/WJHM77oFt1zOqNIkDSccgkV/fVBeZOUOdgLg82LkAu1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by IA3PR03MB7740.namprd03.prod.outlook.com (2603:10b6:208:512::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:02:27 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 09:02:27 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH] drivers: clk: n5x: Fix incorrect EMAC clock source selection
Date: Thu,  7 May 2026 17:02:15 +0800
Message-ID: <20260507090215.18074-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|IA3PR03MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fce6081-df8b-4dfc-2852-08deac175c80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: vNqjLzbsNN0jStCmCZtptTNq/FsnvF3mrCtcrd3Ts0VoE+sa7lWeVaLkqbiPvFoE+7t3gHLydqYmSxpj/wrN0Xz/ThAkzoORlGJVYyD6tnFHsmkIjF0Y2Ohprb4M0FV9lOEJiINE2tPAyZ5Xx+5JC+SGXAC4ZNDyXb9xd4pDeqOW2v93WbEnlIP6jSGIr08tznNEC00ntX7gwM/zcfgrI9JdO3aDJh1lpO/3/aLutLrTmB+VNOBrYmXdqvCbSo0O4tuaEHGPSYCVmpmLZ93uqqoYg5XolJzn9zhNAR5FM2H/d22E2Pldttv/ECCk24O2mpoNsFOSNxQ9evPuMpej++g25MiV9fMx3tT2c9q1kxpChLEYAkiwtrN7lYR9uh70mpwCnLyw/gQETEdqTm2kOGVhvUpleqOj9fnz79mE+mfx0Nut6xq2cXDZ6UEyWXCcGtsKB7MB2+zxUMNu1bwGtGnZDy631ipiRAYl9Pj0M1rxIi0zHLcgBqvsZoDDsLUaYlK3Pj/J1/rQOkc9KrBHjWmU0RoS5KjYC4mnqm+FlhN1+medMTelGvGZesH8P8VvQohjxca82mEe1TTgfAz2xscBzjfhV+7xfQT7rall6u6H++VZlOmcokeveb9QtC8lyeoJhZ1ZXLMy29Mi7We+6hmvqAvhAsG2M/bacqZtAopwY3hrv6UQbSeUDMYrZcmE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mw5nFrohHJXkZenLEtDexR+Zv1/Ts+fzlCNRhPfdID7eEDRevwjFrQbQJ1A7?=
 =?us-ascii?Q?InYQb1Z8gwIJep5FNVzoje9/oUlCK5oCYWVcg6hOhTz/nL07nl2xbUs0XU0b?=
 =?us-ascii?Q?M8fMsJnMWGRM6maM5ekTnvVNPMh6mHPmo2sY8LoLj+bGzOz65wR3rt5fyapd?=
 =?us-ascii?Q?3DFZoEagCr6ek/JBC7PUcu6Yqkj8mjwsoYSsfmY7WN7vWWtugF1RfEp90SRS?=
 =?us-ascii?Q?Qgh8kBPzKEdcGizBBsesareJ5cXk9WMP487e3QbVRNA5sVyr7bxdlJB/R25V?=
 =?us-ascii?Q?+d/I2gmqncbThr2ZT8FaeqLapO3JCoaEmFlYTwlqqU11Qy9HDdnw4d53CcQr?=
 =?us-ascii?Q?TwD/uhSFXX1E5C1jC7XMsvbanz1xNamu/xkkjykKulAWAQ3yb8nADagvznL7?=
 =?us-ascii?Q?xfYzzXIkQPt/Ny4yn55tCMFrbUWPEL8qHlRrUmnkZikztA/JQ5oC/WitS6Dl?=
 =?us-ascii?Q?cW1ZkxtEPiBA569Dr4+GYZX+Yc9i9HuxuRHWNpGNJFrNsAEqeY9skg8Z2IXh?=
 =?us-ascii?Q?cmkSttBDhVQndZUB9RKB01HscQL+SWuqWktmMc1jVlHBYvnDfEcXxEqGb2nQ?=
 =?us-ascii?Q?t4eBDv43VthgDP9vK2/htrnaKNCcvkHiBMNMoTRR3S6SYDMe1pjlpniqci8+?=
 =?us-ascii?Q?66f4i4GcpbLvw4FsncoCXvxlNuaP3EumTS2aL0r2MgFLwn4PXqnnTrTFpz4A?=
 =?us-ascii?Q?KU9SlCX+ntj8IdyK/936ZBchyzZp6SsUcTm5963WTpcE/tjv4HhgzNLlX4Ra?=
 =?us-ascii?Q?8NoekxaLI7HdDf76LAY4jdEXPWi1VTjYxguMCbJ9Pao3FP9Rgv68uPC+bjmf?=
 =?us-ascii?Q?q1EqH6GcZNGG6Q44dOAqq8juSPZefS3jbAq1p2GSwZe3tjpzRD01RtG7Ffsd?=
 =?us-ascii?Q?TRNuWq20aoQ8tdTOiLYsZA2cVT3d4vx0eFWMbfahPkjJX28GYvnCcjLHp8UR?=
 =?us-ascii?Q?EBAR6dqyHRzdsBLR/8YtGJ/fABB1vuxBEcyEsp3KMgII/sUqiIMtHb3yr78w?=
 =?us-ascii?Q?f/r6PKg4En4vqomfDtbwZc476ajEFMo7bYYDMuJAvDGCTm6G8QAE3lXaBabX?=
 =?us-ascii?Q?UKbNY9eWarzxsUFMHs3yKAOxHOxvoZ9V7WMiGUdcTez2YrdL122MzzTlsIRV?=
 =?us-ascii?Q?CeamgCJXD9FkIilNReeKShT164rdsB64kx9V8e22Z+n1rqxYhlqqnMSXFCe8?=
 =?us-ascii?Q?ITEmLfbLd/z++HTnZYs7KmrylrI5+gm2PXXzCPcCT2PrE0iJNa/g3HEaazGd?=
 =?us-ascii?Q?DKQtnl8E+vD7AVtILmhUgThUGR8qMvokUqXhYhr0E199J1xSV8aZshSDN2pW?=
 =?us-ascii?Q?oB6TjUtcVH+LpscFlm5LE2RDQ1oGMm3D4Vj8GtWdeMmtjf83m8Q5lrOUjtfY?=
 =?us-ascii?Q?QQBzusxU4pFSez4Z3uDs7Vn1UTvOrguBYzGAPNDLgUjaRnTizSHO2lpgJZ3c?=
 =?us-ascii?Q?zAlrZfwcttMgN+ZUhbUbPoPDnkypaGBGvokro9f69mZ/fuoXT2qH0hxgSMeY?=
 =?us-ascii?Q?+ZwSl3ByZEsQnwnKH4lIdyeucY9zT5QN5ufMmudizcUc9oMIUcMk98+s3bTA?=
 =?us-ascii?Q?lYrhfu0tFZPzCzdE9oGtCLCkr7zYeAPCz3c6CWVB2P6atnHCqoIn4Vz9vfhl?=
 =?us-ascii?Q?vnfImZ4uPVEUZ4+Ml5nMwZMcfMr+ErQwANBbae/zviH3tqjpaJpV9vWmznf4?=
 =?us-ascii?Q?x4BBtPQ6UbyPuMyOmaHddiTl1LVKiTOE4vgCqxFb4gGVu8qoTyhHz2nVjvAz?=
 =?us-ascii?Q?CMq63Npr1YkjglJpGcIkjwrF5AGF900=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fce6081-df8b-4dfc-2852-08deac175c80
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:02:27.3543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JenY4MrNfxb52B0mFgxIidqgUimfjZ5ZrEzjXs5gUt1AFpm/ESFGK1m7R43SqKKZKK/Aj0GzyTl5xRX+yWQMBhS1hJBb4zAdAXfS2ktnB6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7740
X-Mailman-Approved-At: Thu, 07 May 2026 14:04:29 +0200
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

Fix the incorrect bit masking and bit shift that caused EMAC to always
get the clock source from emaca_free_clk. The mask must be applied
before shifting, not after.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/clk/altera/clk-n5x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 3495283407d..47a51bd5ace 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -328,14 +328,14 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == N5X_EMAC0_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
 	else if (emac_id == N5X_EMAC1_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
 	else if (emac_id == N5X_EMAC2_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
 	else
 		return 0;
 
-- 
2.43.7

