Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8C5D12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AF883FAA;
	Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CT0w2Zr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FC2A83F93; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23CC383F98
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXmPxy4xT4EjfSSnVsj0+9sMizU9U0UlMErxPu3tP+u7LGXDcaStLM2YzRAWaxNbo8CdXZE3EBOwHfvEdQOUk0afWQGiNzayZzGv7IVJyqxn89TYsubp5+msJCAPsBtbXlP0N1Pyp9S7ujDA/l97eiane8XJNsa8Hd4OF+TSwuaJDWbBxZBPbWb/S/rhEchlpZt0SEIJFJjJmNLmixndr1yBD4Ol5Ieqvh2Q5XqNR1gddQiXda1b1axL5h3oVmm848beTo9/CE1PZdshWeT6af4oSoG5suZc4bZWWAokYML1UQTIzbvQs8h9VDdKITxD5JRXtFgvdjArmOpYuHMzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTqYG2ohTI3DlvAXQppub5dFnzG5e31IytZBIM0LwUw=;
 b=G6UvlYdZ0GT0qKoUR9eKSA/i1kTnFGJ34CLxmeOnaZWBKwICdiz51brMC472BZcXd4QZwm+bC7vacqPC6mqe9bbq49sENET1PSO1osPhSnGbIquBvf9WeibLL7EyodyIDwt7jgUzqSxoGrurZUhr71SSPGe6qXPB7Gv5ROqqJVakRHGOpyNz+kklj6BmM1Vx7NEoD2AhcfGHGjantO0CSWBVhys8FmIzJcYKD/KNoIGnltaHHZTXvqlqb0xbzO+pd0YaH6S1Re0LjaCZTdK3/AUqr7L2e0DDlEKQWvpbEzYy00ohs54BSDpj25c3pdCjmP/mmi2VSx/rKVBQH7eE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTqYG2ohTI3DlvAXQppub5dFnzG5e31IytZBIM0LwUw=;
 b=CT0w2Zr9JjHODBSsCIspqvxNV4edlU4Tv/KLNj5X1FyizzgLfat4U1uSEUC52uw8DjerpXKY5HltRs0X/fDExAr6yfhTxz2s94gVw4ogD9nUgCY5dGv1Jp5FZhHiZN47Hkylv55z9/2QukARUPxmKsyFKFcmpiDZCq2PQcqdYumV55mSgJr3QVaFJoDV6WZ1BUtUqYf0a13aDwNOdNuHgkXsB+/9zNV8+LrxELX5bKwdxEa89mjgNrfCRU4my5GljDPCvpznibDP5mvGJmsLB02wymJXyDGZYkEPpLa0h/meOYuMEtKZDqZ00uLT3bhQU3Wvsqo9/NFrG4uh4ZQBXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:29 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:29 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 3/9] mmc: sdhci-cadence: Use max-frequency property from
 device tree
Date: Wed,  3 Dec 2025 04:21:33 -0800
Message-Id: <fe65b64f4f53d119302e2a6d884ab02f45e54c1c.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: b4493c7c-a4ba-4ea9-b8b3-08de3266a02c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sc7pnBjNo4ub+WYTRvH3rXd5YO+fGQB+4PnjkOLK1itZaR0v/XCkSnHr5Wbb?=
 =?us-ascii?Q?caI+XKJ+PxGALtWy8kE/ebcMfkSJXWvXouhKWqBwaKDkyYamqbznwMFLHYfS?=
 =?us-ascii?Q?mk5Ro54V9CYoRtjEUPBpvLgto62K8EE/bnK7cMn85BtCcngfv5yn7gpa8Owj?=
 =?us-ascii?Q?eHHbns4MA6YQVGAbljpyAL1wFCnYE4npbe8lhBHbD16hW7uBOxmEejxl1Okz?=
 =?us-ascii?Q?zms3NEj0e41Xbi7ZL1c6F4QOyMNd2119gt+Modz98h9LfvBDw+oKpcqQhhyG?=
 =?us-ascii?Q?vNgFpfFhfsTxTdmR93T0TO6KN1djIT9qtt7zOkPxilJwP+PgU/ELWTr676ji?=
 =?us-ascii?Q?sTz1g5ydvHvKjpF0TELRatjtkAsRQvxoc/N22798DfMfhrBKqHWuDBrRaKVA?=
 =?us-ascii?Q?i68Dgxdn6JYtMflacHhyBefSvDFmVXAKOcuEiivuGkXmoZZCW2DW9kHv8+DR?=
 =?us-ascii?Q?ZbPeAeDyswpkxtbugf40J+a3CmHYn7Nd7QOsWeN1wDOsVBJ5cUAiPEF/wRI5?=
 =?us-ascii?Q?I7pzDBhv9Nfb3Zb5aT9/akNRyd6Tak89GSNZCwwL1gxGFsykJ5y0c1kYdL1g?=
 =?us-ascii?Q?CHvsBT2gpzMnrggzrfDr5u1q2SoGb7LNy0G9SeueMzK8cK/NHVzPGIfAhbKl?=
 =?us-ascii?Q?x01lY2IzMxDaqAJEmBZsR+vVptNMevi/kPCMSE9ZzM9f6iJqyYljwJ8glKnn?=
 =?us-ascii?Q?+sGWqp2wybGd+qTGSnQcn50KxvaQV76KDlON7JVKtGy35pcHhfDMM0bhgrG8?=
 =?us-ascii?Q?ys5H1IDwq4tJzFchB/ss8iEUTtsxDIlVMl9bPCltiAOyLIoDpQ/3GZfNp6Ee?=
 =?us-ascii?Q?H0OzFJ4Ef6ZqRXBGhNV/dk7WxOvMgVNM2i5VxAkXalleDc5jaJCi8+lVqQtm?=
 =?us-ascii?Q?G0daIVj7E4WbVZXiVkh/FvEiPchRZIOI/f1QOdHuHHK5z/fAYcPot0MvOSjr?=
 =?us-ascii?Q?VTrsqecDV+W/cAQxg2V7FEwdBn9O23kqj+koWcgEqH3n7kW1FgvpB6D0/1fw?=
 =?us-ascii?Q?4emL8e4ellVL6lS15JoYpNEEq0xOnQdbP30tLJgpcbnyqj3J4dO/AaJNMV7D?=
 =?us-ascii?Q?Aso9HMQ0e1W8OYBidBqpSSCVyfPb69azXuiQWNvkne8OuRSptP60Y9rygZN8?=
 =?us-ascii?Q?+8QLpztLeZQ47MdZcfOTWfv/z39JUf6blpek0zueop9e8DYe6jUoVotjZiZm?=
 =?us-ascii?Q?VMfWeJ5xMAmC1Rs09UMKCeM+WYBfMvyUX0zNpjFTfk/T1LnhFLWeZXBXHtuG?=
 =?us-ascii?Q?atV6XhCo4LNJPImDG3hi/eGesFHTToRIVDcmLhMc/cPz3SpkHCMuOfEf0wz7?=
 =?us-ascii?Q?/hjIvVlLWtePwKhpBsSRBEiqbOXiZlzndedRk9S6XS2brUN860SjmE13xYNG?=
 =?us-ascii?Q?53CAFK+uX3XGBCjYvqH2n+YPp3w+OzjY+p5BLR6oKCHnI3bt0uh1h75o93Hv?=
 =?us-ascii?Q?TekENflfyFz56I9pj+O1oRlaYmQit8/U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnUTvbfketPIwPtgTdENJ1XxnjrpStjXhTZVPafhCAQeYStCV66P4SD4ynQi?=
 =?us-ascii?Q?hq3gfxyEW1YIy0ebp3ZmBG7pxOdrJmVLso2Rw663hMHHQrUT/anSFsqeuWPU?=
 =?us-ascii?Q?ZOKaDYpjHEW7CHM6Nr7UTVTFlJ9sWu/ZmMT8JWzLwzIDV6clOwSrWfE6wP5q?=
 =?us-ascii?Q?qQ54hPqa0M2BmJBta8wCBW6l8+bYcPnJW1fJNP2idAI9yRpGeNvRMkOgTIwH?=
 =?us-ascii?Q?tMQhwmmSPFvR2ygqjEMaDyLEC2d1/huGjwTB6J/eSIeGtIZlVUdLQnEOVpAU?=
 =?us-ascii?Q?vCptbgKbV6TyD+ZI5Q6Wg3f4DbOBkpI9f8n+vRgUZT9WOuUD0L9LbouCwnp6?=
 =?us-ascii?Q?jKk+U0oAPCtlpLIN0HHs+prapuzb+TIjrb1H19v0XtEwbNVfLZ3jEQT3MVgO?=
 =?us-ascii?Q?4YdHmbezmbMpB+R1G5HNOhb30ZUGJKrG7rWUfeb4qu8rQPzKKxi1MTbMHtMX?=
 =?us-ascii?Q?xOCxcGXZTBdaI29Yko4gWTyy/Q04EcRk3NntE3RaQU7d+VSKFBMBjgzAJ84n?=
 =?us-ascii?Q?RTYc1dYwLgZPW61hVD5mddNQGHn6HYGwwIKSZjzpxKpM/PfK8ilLuInv7kit?=
 =?us-ascii?Q?N8hP79WDOQan++79IM3QzpDcHptoBWGTqAuBO1icUgEDH0OohPexcbY9nESb?=
 =?us-ascii?Q?bP/qExJMjLqEbYAu8bMTaAxk0igcJUK3iH99QbIO9vrVG+8BOpzJufZvz0E8?=
 =?us-ascii?Q?gxMsSxLfNDAeGvRHEQJ/7Mv2I2PtdyNrgb7BPFQqsRCGEP4XI+82GpuXK4N3?=
 =?us-ascii?Q?Z8Ku4L4kRjZwmAs7NZiUE1PlsmW+smfAI2+5sAGKazqEdJJN1ZRtTR3IHcpV?=
 =?us-ascii?Q?iII/1tN2yZ76WgdRXy9dPGg+Qad0LrjZBwFKl3fFoKd+6btTiOsuXyJ0tEiA?=
 =?us-ascii?Q?iwFa0Uc/YZAxND7XtpW0+k02qugzsIiAmv8RAe1J9Vbt9+F4yzpK0+KkfpcS?=
 =?us-ascii?Q?JcyEvysxI4knwc8gpWl4/dKzELSs9/aM6iePRuEE43rrPVaMj6M6B35pBh1r?=
 =?us-ascii?Q?WEC8GYDngzgeybXlEKdq02XNKFBNG16YyVC3Z5kT3zHPsFmBfxgHZSGX6swo?=
 =?us-ascii?Q?G6AJoGcwna11S14aahdZwgX9+kNjlQ/rDH1QLXfY2Ntn43zozOdbPxPTCcz7?=
 =?us-ascii?Q?Ty9NNjc/Ss93thoCb+PxIjE8IzCVhn9/R5ZAqjmY1kfCQylOcaP/kw5Trbrl?=
 =?us-ascii?Q?tmI6x7K9AjHHM3bQbke1uTCYrYOK2iDK16C/S5HDZxOWKA5YJLnYegvXvpRa?=
 =?us-ascii?Q?nIQ7E1zvPODr/8Lu/07Eqwnf+OTCnpTglbDvgU/lG1dtMgBcaiQDE003EIE3?=
 =?us-ascii?Q?6qchZZaBB/lYZ7+n6ALLdDnoOAf6xQT1E4bSJIKMnv1DAGqI0wpXl0J6G/y3?=
 =?us-ascii?Q?vbtiqpZNoVHMiKzyM3vANJAlpeG2Lx7sWHyiExgIngqpSt3lWQx3HRskGCer?=
 =?us-ascii?Q?utrrm+YcDNXp5uygQoWwTfHu2T2AieE2HynInqVNDsSBVdfDZJyVtQgmqebY?=
 =?us-ascii?Q?S+7ecst4HeWK3u3I05ahdcUfsD1h4OUK9ow5AlbPVlbgfG6eWES27CWEncIr?=
 =?us-ascii?Q?p7SiZfCf7dnHqwXGl0aby8fFGQ7CKxI7MujN+Vv6rw23/Bva1URvFNytaI9X?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4493c7c-a4ba-4ea9-b8b3-08de3266a02c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:29.0342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWMvhb845FEgDtWz8VpqZkSBbXzVPmVFke6F3rO7TWNm+XwivuQfep8R/hut3+WK3Q6dM9qo4jjvXwXZEapIWCssjvD6wNeLQI/kn/CPVaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

When f_max parameter is 0 in sdhci_setup_cfg(), the function defaults
to using the maximum frequency from host controller capabilities register
instead of the max-frequency property parsed from device tree.

The max-frequency property from device tree is parsed by mmc_of_parse()
and stored in plat->cfg.f_max, but sdhci_setup_cfg() was being called
with f_max=0, causing it to ignore the device tree value and use the
host capabilities register value instead.

Fix this by passing plat->cfg.f_max to sdhci_setup_cfg() to ensure
the device tree specified maximum frequency is respected over the
hardware default.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 6c9d24fe5f7..b92b3df3ed9 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -253,7 +253,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 
 	host->mmc = &plat->mmc;
 	host->mmc->dev = dev;
-	ret = sdhci_setup_cfg(&plat->cfg, host, 0, 0);
+	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max, 0);
 	if (ret)
 		return ret;
 
-- 
2.43.7

