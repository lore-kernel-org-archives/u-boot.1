Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16FECD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE42084A7D;
	Thu,  7 May 2026 14:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="WFoCEsuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC3284A30; Thu,  7 May 2026 11:01:32 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89F584903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3fkIY/FSa14r5ygQf+mq+2kK+TwBUwDsWYNy5BZV+RXdc8wAj6Oj21pjVzh+9Wj70eEqJfzYBj44zdtfRKOEtu7oFazsUe67BC62FTv8NoSVfefrcaK55ClIKXVBvt/XiQlbOX1DLBhkfr9jf/E5HUFhTtlOxJkAvoV9xBqs59fYz89zGM4lUfNgF5d87Ko0ZCnmIc0T709AB+qQSsWodZSnOoNwncFL/TdqPxXRCprs+Gl7Lck7CoqmM4ExZgxyksmm2n6ZBn72/Fhoa1uRvi8OLzILa5I58L9JtbZAMA95m71x/h95JhrCup1qC4rRKhQ8IuvXvC1lEYHoN0gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxOSEc2PTpuCknqSH4D/61i7A7kfhp9wYOJMZy1DpDM=;
 b=TQeDofJJ6tllLdLZu+urwGzwf2uzZMU+uEevi3ehUTYx91oV5nmOiLb0NaVC0Y9DsVCBN1QFHDwCNMoeFy9jvqh0dOas9PTQs8+SWQ4iTA0UzkaIRhlIW9vPaAfkPly5kohUK3VjVjZnwLNGM9ET7HQ7p7kX57a3XkpqkDJmoWQtrYvCfQv0VpZo0EDO5B79J29tIHib+h7pDLG/RuFyswmtKs6ClXMZWz9JElrX5qdyzsaSIqwEoURqAa+uhU7lFCrf2Kff5dFNYbVKiY/ClW2S7/vGlwg/xpm+UasQRHmAk3HRDFpQp8S214qpgBK2eSKWYGJt5mQkZn+DxTzE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxOSEc2PTpuCknqSH4D/61i7A7kfhp9wYOJMZy1DpDM=;
 b=WFoCEsuAr4GhiTOK/2YGuFUte0h5snShSFgCpg6k6DZ02BnwTAhTVqq2yYXnLAJO6BdU89eL4z+UtflLcvIu6XJxldNvBFb14R1Z0T6wFk3yB+EGNsKC89QCppWlpAt3Hp9sGBHBBj+CK1OJsTmlRmUunjuzTlMmBsfTbWnwNMDMoZMjiWNilk/P0jEej8x/97D1HKVXziWn8zrXnc+NjZ2wtIvPeBcRzks+l4PLyu6HGItdmsf05ofwuhUoKIJzUgfs4177AYflYTLhJAZtOchsfvBTCdAdl+N64kvaV8yZv7Z2NFpHEEbiLnSB1GKZMIe47WpeelBAl/upShiYgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by IA3PR03MB7740.namprd03.prod.outlook.com (2603:10b6:208:512::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:01:25 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 09:01:25 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH] drivers: clk: n5x: update comment to describe PLL bypass
Date: Thu,  7 May 2026 17:01:09 +0800
Message-ID: <20260507090109.17130-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:a03:333::30) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|IA3PR03MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: b186265b-eb18-4d49-63b9-08deac1736d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: TQTtGA4b7ZczO/15mdUnz8RjsZ67Jp11xmK8FWlz6cbcqwzzOTHZutLgP5FpOOZBdWCF6AT2kVolWr0XRKHOR5YuM8LGJG3+pgFhPYobwB5dJ4QmaNn4W7n3pmoPGpKhVOVSq+CegxLdOYjFZIy1WQ/EpSiom0oJyZuufAmF9i9lENhu1RP6TlNWWgOnddg1Xiu37fvGPcCWN4QUv9uTDz4ksKIFKo9pipWcEnchsmz1VuxbLuXdgeezzQiVPgpDwmBD4uBfTQdFtfIqQ8tgo8jAIsFklteGX0hB6OWY/z2QUhTyYX4yyepSCrsbkb48Cr/5Ssv+3N1oZhlURuogn4M0hrpj3oDlCjJkWiEs0SidIowStYeRmp8kd0QkowlEVDd3DMDaJVXzFTNEiro37aKFcd2t/vuWNBxNwIUha4QzwxDkbmfTplACsNN+JPG9Ge09JkPfzbTmY6lEdgDnhZKvqqKdhtcfX8UKa4IWVoVpcjlmXXQxDdh8oygZt5ysuV514XfPSgOj4xmqo6TNepxaCRSDd3u87/MqcfN9wGJ65rvKvx4DF9LrTMblyXzHxZy06o2Mkij0+ugyI7ixSFLYujsvHXl84lABs8/OoYEA6TnXWWjJttbHkIfuZTWY4NqWITDETX4OmXG2FaZdPgnHzqQ/eZ5ZK7LjpbxYVIHuoRNrHO0IynDNnWedT3jd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SZgJA7BSG7JyXzcnHsvQhLHZIwNzl3SC2ptOeLKM2b4lTXgbzJvTDDuw9FS?=
 =?us-ascii?Q?t9VFKdDUM7GKawVVdsh+gQgBlocvhMtSJL/pAr3IbVD4fjPFwX6hLmIZ3afd?=
 =?us-ascii?Q?uf2r9gYNguRNh5kiAjDSSDzkZ5U02hfq7F1XKZBFG8f1MYALn9eK0jDQ1GFw?=
 =?us-ascii?Q?BsQ9hmpu5cL9TUGcU7ypH5o+bGL5ZvJPz/hgykLC3Y6CxA5BiV3WILkZy/fr?=
 =?us-ascii?Q?1JZ/vu2WFVu/afJ6AyYncHH7+NPRl8r/SNbd+Ys8YkEqgwXGu33DKxnX0YaU?=
 =?us-ascii?Q?5ONBrT+ptRhqjbIxouzjmXmPvsGbLUa+x6ussWdO/Cw0AdzRgWlAPEq+2eY1?=
 =?us-ascii?Q?bP7PAY2QeA1pbDnqyEeAGvHqhn/STf6GMV04rUCwFxtiPDoh6tQMk5sn57Bo?=
 =?us-ascii?Q?xIRY3nA90BRXnga4jGIEJs0SRHBq4e2itFk2STXauQafX8ePtvAak1uH/UBE?=
 =?us-ascii?Q?WM31Rjk7ONcdtfGlIfxMCzco8IToFF+W0qS7SROOc658NeAyiJQ2yKpEVSwD?=
 =?us-ascii?Q?1hE8/qAtyh0cppgwNJzWEt4pulMXST/DH1BKgYkz0zm7V8W2Hbh5Wfek6a97?=
 =?us-ascii?Q?C8CSkRur/X3uqzdsprUYY4coPVkdZXtblAYgxogsbMZ0QqTSsENDC31IJLMx?=
 =?us-ascii?Q?pVDYcLZCCpzHKvNh6eyaLfFayH7KkB92/ORPsGtorvJnbHlppNMdSUFKkQ2/?=
 =?us-ascii?Q?NxMDGcpk4H6X3mEtZn2FFDuWSq/qTgg6Yg39gZU2B7N+KGhmfy1y2+eiQP0g?=
 =?us-ascii?Q?rLlFlyzRD0RBL27BVp1bVBcsRUph9ANS+hlt3vgZgjHjlltPtPzWcmOUydY8?=
 =?us-ascii?Q?ImYZXrUkpoEavULaAIMxPn8XH61zd7qFANsXc6cbog9eqAAhQ76SfmRjn9Vr?=
 =?us-ascii?Q?zlqBsoF8l6NebCjXjv3PIUN/RaYYgr+rdOzg7wykvZA9/arGckarKgxGZ2HG?=
 =?us-ascii?Q?K4nGOtdSP/AK30anzvVzK3HJube5TWDgl1UHA+uMbNXeq8bQ/BjKkYZP0Ud+?=
 =?us-ascii?Q?r9+dYqrNGpNUh/tx88+scF8CTiXKZDtokxIXOkbHjfCV0kIQvP8b4BpTPG/R?=
 =?us-ascii?Q?y0t/f7Q1cQ2bSS+dmfensrnWEbTJ3jJdp/trA1jA6t3MnpwzC6oaXTMoFw/3?=
 =?us-ascii?Q?2+N+3DSTTwy1tKv6oOhX4niJuVBqGk/s0pte85kpMYJPy4aJlMzGpUl3izuf?=
 =?us-ascii?Q?iKExw7sglCB8j29mhz4FLjcD7x91Gde7O5Tstdft0B9KNEo1vyrt0PS/Qx+C?=
 =?us-ascii?Q?LkQPVcdkUbyN2kvbuxYYhDGWdXD817CqS7yLCXLsvgHfQERNTWYJdi08R964?=
 =?us-ascii?Q?lDV+ERNzs/cquGRkpg82gxL/HQl4j/zPK9FNbtpTzSuwEbfGuGz7hT50ufj5?=
 =?us-ascii?Q?hUnXkJsrA/oCXzualXvsNAHNRLjDtL4lV14zU37NikSdlLPVepkEqRvy3wqy?=
 =?us-ascii?Q?rBMhPAXs81HsPNdTRkPjSJkyyaaKuZUbG7Bl5QUOr2iDByS3Mk2fkaEN1suq?=
 =?us-ascii?Q?bt1pPglpY4Q4Md7m894yreuLjTQnTWoLl1BbvVkS8HIV4qLL1mSNTkuqf/mk?=
 =?us-ascii?Q?q9b3pmLRE+RgiyakOC6U+9RIs9lsr+EL6slAOz1w7KGA0Xhn6aHHLmlrDqth?=
 =?us-ascii?Q?om6+Z2I8xiUS9DjH6L2OLTtGfJ/Zetn/LDjWsujk9dFvVsm0h9FGeMyOoLj4?=
 =?us-ascii?Q?gdFmTae4SmH8eO8L0ZnR8TlObtUxOUEcUSyXfoVINcaGJk3p1sZQh3W9d7MY?=
 =?us-ascii?Q?OCrgSB149IIHFCVh1JT2Z+tdoHCucVo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b186265b-eb18-4d49-63b9-08deac1736d8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:01:24.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiHI6O67ahQC6j+ZS+nXJHVykwgPq1yjCY5QGwOZSCCBW0lPLdRW+NQ5M14E9WtYNz+kp58zfA4lSLEdn/GD8szS4Z4VBZ6778wX+m1vvxU=
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

From: Jit Loon Lim <jit.loon.lim@altera.com>

The existing comments incorrectly say "Put PLLs in Reset" and
"Take PLL out of reset and power up", but the code actually toggles
the PLL bypass bit. Update the comments to accurately describe the
PLL bypass behavior.

Signed-off-by: Jit Loon Lim <jit.loon.lim@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/clk/altera/clk-mem-n5x.c | 7 +++++--
 drivers/clk/altera/clk-n5x.c     | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
index ac59571a853..0b136b30ce6 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -58,7 +58,10 @@ static void clk_mem_basic_init(struct udevice *dev,
 	/* Put PLLs in bypass */
 	clk_mem_write_bypass_mempll(plat, MEMCLKMGR_BYPASS_MEMPLL_ALL);
 
-	/* Put PLLs in Reset */
+	/*
+	 * Put PLL in bypass which powers down the PLL
+	 * and bypasses it such that PLLOUT tracks REF.
+	 */
 	CM_REG_SETBITS(plat, MEMCLKMGR_MEMPLL_PLLCTRL,
 		       MEMCLKMGR_PLLCTRL_BYPASS_MASK);
 
@@ -68,7 +71,7 @@ static void clk_mem_basic_init(struct udevice *dev,
 	CM_REG_WRITEL(plat, cfg->mem_plldiv, MEMCLKMGR_MEMPLL_PLLDIV);
 	CM_REG_WRITEL(plat, cfg->mem_plloutdiv, MEMCLKMGR_MEMPLL_PLLOUTDIV);
 
-	/* Take PLL out of reset and power up */
+	/* Take PLL out of bypass */
 	CM_REG_CLRBITS(plat, MEMCLKMGR_MEMPLL_PLLCTRL,
 		       MEMCLKMGR_PLLCTRL_BYPASS_MASK);
 }
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 185c9028a78..3495283407d 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -63,7 +63,10 @@ static void clk_basic_init(struct udevice *dev,
 	clk_write_bypass_mainpll(plat, CLKMGR_BYPASS_MAINPLL_ALL);
 	clk_write_bypass_perpll(plat, CLKMGR_BYPASS_PERPLL_ALL);
 
-	/* Put both PLLs in Reset */
+	/*
+	 * Put both PLLs in bypass which power down the PLLs
+	 * and bypasses it such that PLLOUT tracks REF.
+	 */
 	CM_REG_SETBITS(plat, CLKMGR_MAINPLL_PLLCTRL,
 		       CLKMGR_PLLCTRL_BYPASS_MASK);
 	CM_REG_SETBITS(plat, CLKMGR_PERPLL_PLLCTRL,
@@ -84,7 +87,7 @@ static void clk_basic_init(struct udevice *dev,
 	CM_REG_WRITEL(plat, cfg->per_pll_emacctl, CLKMGR_PERPLL_EMACCTL);
 	CM_REG_WRITEL(plat, cfg->per_pll_gpiodiv, CLKMGR_PERPLL_GPIODIV);
 
-	/* Take both PLL out of reset and power up */
+	/* Take both PLLs out of bypass */
 	CM_REG_CLRBITS(plat, CLKMGR_MAINPLL_PLLCTRL,
 		       CLKMGR_PLLCTRL_BYPASS_MASK);
 	CM_REG_CLRBITS(plat, CLKMGR_PERPLL_PLLCTRL,
-- 
2.43.7

