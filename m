Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A5AC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E9183F00;
	Mon,  4 Aug 2025 03:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="R+pZyOrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9EC83EAC; Mon,  4 Aug 2025 03:25:37 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5DD83E70
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntkp8GyoiuMgwE4yznExN6ppfSPNde1OFoL4TMO6nGBQ3iJPICgBSpGBOMlUk9cPxG0knKJhQAyHpYgVgmOPFAKYLK6KdYez4KeU7vqlZqU4MWerKX3AuG6AgmflDwxO3xkJ8QMthmNn40AGmvC6swNjkHRWLxD/SSPyUXdjf0t/bj+CUYhT9ARxHxBS99zEp2i+JJl5l2GwDLidTGg0zewaAR0nVK4NnR/oH+RmgwSwCOptCJosi8hEkgv09E0v4NmQE+eJ0RoOPm1UEZAOOQUR7UQkyQEDmlvdrstfikG4Grn8Sz9mNZvLYa0brGONdI0Jf2lBgwTq5YewGjspVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqv/vvs0pgt5/ZBGoodq7TFBTFViqzoDmRKziL655Ys=;
 b=cMOWwEfWT9GzUInldVAmLp8quDDuK59vPYqEh6f19TwyYZrXWr/cOKIT9HWy3KlhrvaV4DF+nRf4RVPzOfHlshmjOy8J5QMNTCj73tHMj9hSMzM8J9m1016wK9oZGsOj151xemqtxzzACvde+yKcDlORAWop4s5IJnv7MVgRexYZ+wciQVsTNnFfjFditTZSimi1J43XA0mFpi0E55ApR5Mq/uZoEyj0gM8eFg4I+gS1OJ7T3yjA5IPUC4vTNBsLW+MnfRW9nQHl3mEMyXVJ94oiSEezpj/oI59Vqgd2bd2GpIU62jFPysEyvG9oUe8I+Jmalvz7TasK0WVQoeIzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqv/vvs0pgt5/ZBGoodq7TFBTFViqzoDmRKziL655Ys=;
 b=R+pZyOrmyYyEFXRZlmUccIJ96gV1d8ePlixtYg3WPhWW25dTluUDqERQaJkznwuB2+nn4IXTe9vhsH3/wepX624UY2z+xknhKbnsuPVZizzQ9cG047nS2yTOf1MibHp9QytqYsz/WUxyZmV1l9Nx6nAenEl7dkSpK6Zh8vkKhaYzcfRpO5xS/+ol3rJR4NVhY6b884pCSENfWkdunFw/oVgDdqO7uVk2ZhLkod6pBnvh0EPrjpadg0tjq1QH7C60dRpUbNMxFS5+yHhCUhJHA5yr13pFaTYYD5VWDUhmkSN8b+fi1UjpYvCeGyi8OfHIZRBV5v0UP0GcLuCmOVdE/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:33 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:33 +0000
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
Subject: [PATCH v1 27/34] clk: altera: Add clock support for Agilex7 M-series
Date: Sun,  3 Aug 2025 18:24:54 -0700
Message-Id: <20250804012501.21811-28-alif.zakuan.yuslaimi@altera.com>
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
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 30013a5b-664f-4067-f790-08ddd2f5ce80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WXtKC2Hy3JVq5nXA205XQZytqQI33vEfzj8uow/mnJ7G9bZo/Gp/NOoWLatw?=
 =?us-ascii?Q?S4rfp8OJuP70euWaNlKFbjdoTXTOZIHrD/cjuF2O8CHdX1Tjs3JUgqYBO2SX?=
 =?us-ascii?Q?vDwIj74/KHPZJScikWhRAT8LQRGHnDFEHbJxOz6O1AU1NRuk2P/Qq1NVdeLh?=
 =?us-ascii?Q?1DVBoruY3qV5MOYgYXZUqSMsgxkZ92OY4UxqTF4+qkdBp6Imxan5wLBJpqB4?=
 =?us-ascii?Q?fA9Wuy4JsSGtQ7aeFedllFgTQH9rcW848GbRQI4lOHl6KeLm9et/1+znRRUn?=
 =?us-ascii?Q?os+x5bzXlq7g4U9gnTkGUe5EFZV5CGO01Qnsp8faeMWVgBjTZ8m8qXZFiRdq?=
 =?us-ascii?Q?Jnhgy2X+GF1VDii+V5UEIYIWOUkeG8kBviZSLe4WopUGMgYcD8v0QKt2lDsu?=
 =?us-ascii?Q?YCrR79syzPaplAXzf9q0ZX1ldoiC3FG1w2gkkayZ/mjlHJQdvJ+336nhpgYG?=
 =?us-ascii?Q?38Sx+H6XgLFDf2zSvz7pvA910DGTyKFHPsw5OwC17MalzvxbbefYg7p4HvuD?=
 =?us-ascii?Q?eLKIPJ70rov4vhJs6zBLDqRev0Ea/XnvySMBSCDuZVrqjUwNvzepaC9H4PKx?=
 =?us-ascii?Q?Q6cglNi5+lsj5HOCd/mf22OTzIX7l3SsrfLn/31fyP5biB0a4biIB1IdJsCg?=
 =?us-ascii?Q?eonl3vAucTaEevmcKbB8BZD7spEPmVHsl6grAgHJ8BA7XvqoDS2Hfk3KGnEz?=
 =?us-ascii?Q?7jEOKaVq/VGHLMk/VuDKtw1xflO8T1a0IMvEklCwWTYWrPJz4eB7DqjZMNkY?=
 =?us-ascii?Q?Z6m/wcF/FjNIZUNNa6zEeRboDvDO/STecddacBo9mQ2Jf8XvzCD3AsmrSzM9?=
 =?us-ascii?Q?Zv/NfxOiNStmGOlKuXpwxug24ForN3OaYgSd8P1aQ8V8yEiYTLz8JV9n6rHT?=
 =?us-ascii?Q?LPXp7kR7f+hDBAQCt4UVeuYI28j9cG3ejtNGDtuNTAsGcoo55dc2010wpi1/?=
 =?us-ascii?Q?hjcL9+L1WXRfeZREkEEqtdTUchTy7MlkngI+79GPT0mpO1b+JcvOCyauYt4b?=
 =?us-ascii?Q?e+/u6XTf4pVQHSfnbYhaNwNxsnX5Oh9aV2s/xLknCXqzJhw5dquG1odHXVx/?=
 =?us-ascii?Q?T02GlkQSdDsf1I0gjpEY0TdOIC+TqPC1Y+LycdYKvARcprsq3taxIYytFtrK?=
 =?us-ascii?Q?6jxDmqMmGhrrfVuU2cmmqHw0/o46CVjLynwgQISXFM5uA1VKq6dyS2nRZyoC?=
 =?us-ascii?Q?T9Nh8y4/Im37GqtggqYYQqKFSZuvvndIbtbsfavQuJoOnQ6fTmKBt7HzPFKG?=
 =?us-ascii?Q?VwjlyTHFPJs5qRqTq+dIxOau6QGUyI+t64Y3JkIUDQ92ZDgJlzYJmBxsK5e/?=
 =?us-ascii?Q?Q1qryRik0pxn4CmHWhsRMUxX9ptYZcNROYyvw4RmyWiKniRPBHl4usezk3Gl?=
 =?us-ascii?Q?eHKX1d2WL9GBpclkMeeHS5/XlaHLpd1T0tqhTTIRv1CQCu7LmPo3bM6ukZHn?=
 =?us-ascii?Q?qpVlJbbw2FM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5TdXEWfRZSeVpOpZh78ukcrYg/gBE+A2+UNrwHSfCTycGDavDoqXWcMIs2VC?=
 =?us-ascii?Q?c80Nz1pNDhED997wFp9jouyCiA/3VsBrY+0KYXlyrZ5WxMIgVHf/E0kKoEFS?=
 =?us-ascii?Q?Hm80rgVLVnqNeAYQ2PtFMpjq2Gn07636WDrEgCeYJCXDAV8mAvl4b7Eduq0e?=
 =?us-ascii?Q?Zru6K6l+gax3dX0Fl/i01EnD1MuO2Etit8LYbgdfAMPVj14PCIX+iOADL6qK?=
 =?us-ascii?Q?Wulwr0DgHblY1aCjDLwBwWyc5Txvvm/C0StilW2XihQra6KLRVF3/yVR94M/?=
 =?us-ascii?Q?N6S1Z7brgznwly9nZA/rsYypAK7b2XjAw4X5CWQ4pMBldUBWrlvkjjNEcQ/l?=
 =?us-ascii?Q?li7ixUvzz7PqRgX2VuENzsp7RmKRu+GlCV/7jwJyfMasSB9XR7j/9ka8ftkz?=
 =?us-ascii?Q?KVZ83ZJ5w3bWM9dM8zfsGUTrUcZYkFsbdqy7AlwPn8PQErsk8rEbYsx2yxpF?=
 =?us-ascii?Q?UH97nGL5nDMqMIAI8SsB79Ob3j5Xmw9+5TqB29YP57ZIcCJb3pmEW2zaGwKJ?=
 =?us-ascii?Q?YNdmfzumv2GhGCr2JBwaoqtplL6YDNI9pQC6q+BOjRskS0IM/M/+PpaNR7Ih?=
 =?us-ascii?Q?dzOmssDRGgaNnVGhz0fX0haTC3hslgjGMOJQKmVGfs3WRuI8y/X/f05+kYMn?=
 =?us-ascii?Q?LLHO8giM3fycfgNQsHurUDDC+8X7vfMau+khftFyIpC9BfnQVVqBch8sm63W?=
 =?us-ascii?Q?/dimPBcfR+Iv0a95MamUoKZanqTOSmY6fLHKcSZ7/wILNT+YCTmFKahkdQ+M?=
 =?us-ascii?Q?RzEv305kTUV9xl3ktYnqAJLYoBBvAOdZ/NG06GP1F1KaVv9bECiprv3BCYQq?=
 =?us-ascii?Q?nn6oWGnIwsJRuSCFYiAGY4Igz7bEfKbjI+WVtYSammH5PsKzshdbZyxecYYg?=
 =?us-ascii?Q?LxObzpGk2KVrLxiQuVrsqMfXUf4Fsk8cPmlY7OH40vj/RlWINS4/jruX1aVA?=
 =?us-ascii?Q?/yIv9PxGJGH3HvCkKmZf4rjTC6XIHWR9cjcydozk/a4ammg4zO1cNh/+zHTC?=
 =?us-ascii?Q?9n/0V0sggyYfmnLCTHwhYGBFzt8bH9G5ARtEVJlFQ4ObxiGMX9/h0DW7BwK0?=
 =?us-ascii?Q?VKytURB1ph9glu8quLu5R9IxXqIkvj8z7ZT/DbHoccEUt6NSGwLGhxMXr/zy?=
 =?us-ascii?Q?5trBgHZ0TObGcll42JPexPZj9xurhwkJVivT+dapLFGwPyQhYvn8Kjd1ytNw?=
 =?us-ascii?Q?r2NDX2Wu/+JhKeRguFsGN9PMv2/4NsRJKORoaDmqCVr8q9G6Jd2oicf+1w0R?=
 =?us-ascii?Q?RA2pJhlvVVyPIfAMudFERXjJ6zjnJ+oiTt1S3YvxA/2zIH0cMX48SFbRGbim?=
 =?us-ascii?Q?lzhnvP9U2QfdQANYHaYkFaAKwoCGrsae/nkXI+f7ayP6PzgviPvMIsD3le6h?=
 =?us-ascii?Q?r1uHp7bsr/0ALk3oN/6WkNt3YIzAq+BGUim6FplbS3Eybilmztp45dMaEXHZ?=
 =?us-ascii?Q?+oJWEtNEdMDgGIg5h1xENSOE82b2r8EdSG38AqyViIarj56WJoGU0xX7YUxe?=
 =?us-ascii?Q?Eu9hjpDrRd5lAPq4cOiKiwDAKmr7Hjt/vfFo9maZDwYvInjNJvufiuQeNJ1T?=
 =?us-ascii?Q?pORNlUwXDiLIOuuDIyIvKvRe/tE0N9yeSJnRIFm9/Ji4TuYMIOqg1Vvf6TUn?=
 =?us-ascii?Q?+1aBHolxooAj4ld9fNy9RHQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30013a5b-664f-4067-f790-08ddd2f5ce80
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:33.1159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drvTkqYNVdfDpx7MyQmjzkLVpOausL8xM55KjP2+LVytB8SeKHTSiCc5PNy7XK5pSTZ+fmAdO3XLlPATs+iEt2J4dPNsmRzs6ksD63on/j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

Agilex7 M-series reuse the clock driver from Agilex.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/clock_manager.h | 4 ++--
 arch/arm/mach-socfpga/misc.c                       | 1 +
 drivers/clk/altera/Makefile                        | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
index 49f3fb2e705..f0431c081d8 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  Copyright (C) 2013-2024 Altera Corporation <www.altera.com>
+ *  Copyright (C) 2013-2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef _CLOCK_MANAGER_H_
@@ -28,7 +28,7 @@ int cm_set_qspi_controller_clk_hz(u32 clk_hz);
 #include <asm/arch/clock_manager_arria10.h>
 #elif defined(CONFIG_TARGET_SOCFPGA_STRATIX10)
 #include <asm/arch/clock_manager_s10.h>
-#elif defined(CONFIG_TARGET_SOCFPGA_AGILEX)
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #include <asm/arch/clock_manager_agilex.h>
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #include <asm/arch/clock_manager_agilex5.h>
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index a68ddd9e76b..76747c2196a 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -265,6 +265,7 @@ void socfpga_get_managers_addr(void)
 		ret = socfpga_get_base_addr("intel,n5x-clkmgr",
 					    &socfpga_clkmgr_base);
 	else if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
+		 !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
 		 !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
 		ret = socfpga_get_base_addr("altr,clk-mgr",
 					    &socfpga_clkmgr_base);
diff --git a/drivers/clk/altera/Makefile b/drivers/clk/altera/Makefile
index 61ffa4179a0..858f828e537 100644
--- a/drivers/clk/altera/Makefile
+++ b/drivers/clk/altera/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += clk-agilex.o
+obj-$(CONFIG_TARGET_SOCFPGA_AGILEX7M) += clk-agilex.o
 obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += clk-arria10.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-n5x.o
 obj-$(CONFIG_TARGET_SOCFPGA_N5X) += clk-mem-n5x.o
-- 
2.35.3

