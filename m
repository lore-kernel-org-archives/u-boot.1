Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647ACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614DE84AC8;
	Thu,  7 May 2026 14:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="K2t4CAGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2E7D84A3A; Thu,  7 May 2026 11:03:21 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182F684903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYEscq7QnaczUA6Oxy5R/trBqOSt/YyfIQAQwlt0ioWVSiGqcXyLK2QZjd4avAuiz9ru7Cqxb988W8173NFXeQIda9yrTnfSRI1t5tWdABYKLLvqfsxJVvf1J9/lPDS6OpKL0e02FF16mVHuxn5MavleSz38oEkniFFP8WhAEOj8PxACM7/s0Nhc5h8TRG9z2YS7BF4CZ95D+6NrUunEKSVjSmRkHijy3TLBXwyEWjfk+XBvYxdkfxZBQWHXyOGhyD8/4eHxaw0yjh89jocHfS3AoruP74FdK1ju+tJhb8MSm6v5i3wIjLpNJfQz3sLSVmH/6IsYgB5S7V10XxQJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPSUCreCmCHzQwOqM2hKUv26wVjJWn30/B3zV/4yLEM=;
 b=EnYzW4WHMLvxafC4QhSEOwYBtCqt8W5q31RQ2xWVFh8AC216plwliKYIl8QcwgYkP3r4/BBRaFNQ2sQLmv9f++zXslMtUrRZbGaMEPi2+oeRJPLkKARHbyHQ9MRcAeCyEy7Qny53MbvVizJGYwGgE0cqAy/pGQdx84peZ1kd+Uyv86AnEP9zxEfal3NdUfJtwn1s1kYT55WSZJEJoc+nqB7v/ESd7fwcXk0o53ByG4P12yODO5g7ZghDpT3b/x8JWmenKRh2Ck02egcjNiXD73RJOOovyaRshwWpQo0Y1xFH7Hl+21/1HECHTFdnWrhp5eAF8Uu+35sxm5l/0CSvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPSUCreCmCHzQwOqM2hKUv26wVjJWn30/B3zV/4yLEM=;
 b=K2t4CAGa0E3a84foT/g3Ky0dXzXGcsKIhRbM9eFO7Oc0z73E8r1sfPzSogc1GKFy2AYiBPFje2CEuWQrFwWreSgb3aUfNQOIPdmhA311RmVas/tkvKTTF53zEDgGVPEwE2a16AQQ+XPvMj1SQGKY5D+tOozl0jj0+eYxKcAsPxC6tM/5ui/0uhM3Dr04XVmRPaNB0NPAE5N7f8sde0VOm6stLUVQyQ/ReNXV1+8vgVIq+zGuHKPfT58w1qQGN59VhBgJk3i4LI3SsEDMEcguWDXF5lMZk/Xbs9OyE3FGeRQQBDhOBQU7ENSwQfqc+3MICzi6oncuoHlXHJG7QEsa2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by IA3PR03MB7740.namprd03.prod.outlook.com (2603:10b6:208:512::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:03:16 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 09:03:16 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH] drivers: clk: n5x: Add support for enable/disable API
Date: Thu,  7 May 2026 17:03:04 +0800
Message-ID: <20260507090304.18905-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|IA3PR03MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e978a30-18e8-4148-d684-08deac177982
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hqcPK0ejUrJoOKhD45p2jWZQlDTe+aPGOf0+uz2C3hK2LdDsIIeDFEhB6Bx+nc2xWsPdaTWMAjmDtp52yxCBNelIN2Mem9dcRjtGWIg9OUbVeE+SNcfr7PQXzOSbh8bFcG6mSiMgf6C/Nqn8Nzt5dKlI3ypmGGFAISoW5LqOiiG5RCXSi3qgscFRfpbXEATab7BYc2aT2isiBFaZDDCBi95EZUji7GyqGfSAFLH54v5DfB7swuRm+74xvgwp7zuI6hXlEqMxDwI3TAtvTglwxne42azfXNaOksRZL/eKBPyShN3V72STQ6TfanjTbT/FEOFEi1erKmQftMXHnfuaG3xF57GFkKnHW4z6tpPmS1C7C+nhio0zGBuTdT2K690zp8xuPbz2f1Ea13qqio8f7edQil4i06P1XCILGddi2qUytBD6fDtsoNfF3fLSKhHNZ2OebBWB3mxnC9tyvpFm1R0356Az7Zo49N9RME0WWltoI0LtrK0LCBZNG5xXWLUwA3ry/AD0zVnDeVKgOd1shkCKXq3owsJFP+OLreUVj7+XrGZZ0gathv/eaFiE5a/igV3LABCQT/XSK8ZvMNB9mFuE22yAe9TRaHn3ZjWP0wO8DkuitWYgsF/HDDisNEHgVxvSRQ6exlS+PxjzkydhHsAeE7UrVZOzRoa0q6jgrNXiyMTiE0KOEnMF1iQeWelF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9KqJ9wgnK+E/VbwfGWkI9+GfZyX7+cNNBhYBgfPTQtLDsM7p56o5SeVh1tht?=
 =?us-ascii?Q?KBZMUAK0qkC2RWxFdd3NkP7H1S7ieRXYfO34GT2U6JQaQ5yUr0/PnFFTZLdq?=
 =?us-ascii?Q?6O8aNFghBeH/OjhcRfi0bSHdWdT0Mf+siBcrfCj83HJREMmFvGsv7l0KUQ/T?=
 =?us-ascii?Q?liTcW48bMoCP2VJOpOwMgM3LLqfuci/maRplhze+h4XGAjy6+Cle/XxFJWFb?=
 =?us-ascii?Q?4CboyZtDSEQ3ezhdXttWCXyOLq2ORQd6hvi7IfgCPF/NzJpoQ76CBnvhkums?=
 =?us-ascii?Q?V48EcvTUM631jkd3Gm2/7+AwtLDnu4VUwm8d7KXTnKq8vs2zDbd5ibe4W11e?=
 =?us-ascii?Q?uesB5kCN80c2KIGRLhP9TJxZ+fgGw+zo7xNkZoCGVGwV40vIECFmXL896cLn?=
 =?us-ascii?Q?G/Zbh8tvb66dOJEOpI0HlQhwInsw/DnAnJAaMgEgw53nlcoCXURHh0yQ3FdK?=
 =?us-ascii?Q?meNiPttjj7nInGGqzgy1yocsOQuYznxwN9xRnpGjZthbcTpj5xNoE29U1FRV?=
 =?us-ascii?Q?bML2y7hx69VrQtTiFqlPYCA3aUR67Okh2+5w1rzwPq57rq3EZtolTq8rE4OL?=
 =?us-ascii?Q?lsYHE1gBAaRq9qX/STXj12hZrFm2bbyMiyi4ueVKpyCiXeirTRCCWKfuw0mm?=
 =?us-ascii?Q?okdJIlY2oOpSEknQHfsldv1ggO8UAhRf0oQejtLNAhfyOeoz3RsW0dI4N6EL?=
 =?us-ascii?Q?9iZfjNOLiPDod/SzssVOldNR4HKszvG7EaBK+jwZJh/54Dx2bC8doTPqTFvA?=
 =?us-ascii?Q?z0e/Ig3+j55RtRAIrsaoPSVglwL9s9kRKqFZ1viYRI1nP1KGlR+nU95cPE9T?=
 =?us-ascii?Q?zgbAvK545NrSWogZnKtdZT9pEferB/s6DxdnQWBwvPz8O+55GxZWOxkLyywu?=
 =?us-ascii?Q?JLV4rgdu7Lsv9lj8/UVNYKtC1Ko2U2iKuyBXbnULYSBkUbJr0xjevtY2QcZg?=
 =?us-ascii?Q?bEtgr4rGy4q4/Fin9SfvQg6dqazkylr9brAokxKpixESk4sk3KTjNA1Su1LC?=
 =?us-ascii?Q?P89KgSuGmfS0UHSCoayOWLGW8atR31gQ4DgE0vTIChi0XICouj8aY32KKq6V?=
 =?us-ascii?Q?wvWbKaxkNvSWjAmbcuTuxH/Hl4o7YTrTbPV1h6rTpZAMdOVKJhGV14M25Dte?=
 =?us-ascii?Q?IMXJ25uCBL2MQapHSG0MXiyl00DxekRFTfE3cLyAXzFlQqIN8ut/EnBpsyOP?=
 =?us-ascii?Q?vpKEGn6w47QSL/+7wjPy3TAwlUUG1tNQnT7/bJUAIu1dvxPG6c8huvSizVLk?=
 =?us-ascii?Q?e2NOPo9g/Kyvb0qhJcFypBsncSqkxVYnKuEvo37APQBYQsJDgWAgBe+5Z1of?=
 =?us-ascii?Q?pfkWYf3cbN9mY5lQg1S0bQK5PyZDQrEoudPKDraNrB3lwc9ejeuHIx3NSm2m?=
 =?us-ascii?Q?7qi48yOYLRgoK/xzYmsIckSBxQ/I5epKKNRkju7iB3l4PrfEDLeB7UJwA07N?=
 =?us-ascii?Q?Wq8ltD1QNxLahqOu/ZxF29WhvrJTNTB3aTVPOinL9gpkdINFfPKLa3RHCmTv?=
 =?us-ascii?Q?iz0+AdjzyJMrR3tWkcfqkAIY1hP/83yC+Wd9vZrOb/nfSrdohgc0j03ax1Dr?=
 =?us-ascii?Q?jdaza5SYSbaAtygNiQGmCpi72gBqOpJFvRC5ANEr0oJSqWLnSfw0gCg1SXmF?=
 =?us-ascii?Q?s041FCwWSo+lnPkhzU2NEwdyV2Pg8E0PO3zR12y0aEAW44bQetTFdb5DELSC?=
 =?us-ascii?Q?cqzpz7nm3UKuPv4poP7pHhoDZ/aDfzemj+CTM7o86jdF0EeCDatockZXb5dl?=
 =?us-ascii?Q?KCs9CuoIYqtpjdZFhWSRfNE+nDiDBs4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e978a30-18e8-4148-d684-08deac177982
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:03:15.9051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gFwhmJpBXxlKYKiAeEHc7a1MPlh3oK0ZpRjkzwjIQzIrBgkZVsD13vNF8Svk/bYa41guU16LzUerUCjuaUxZjKwgA5glaarz6NeSmQB0II=
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Update N5X clock driver to support enabling or disabling
the peripheral clocks via clock driver model APIs.

The caller will pass the clock ID to this driver and the driver
will then proceed to manipulate the desired bit in the N5X clock
manager peripheral PLL register based on the given clock ID.

N5X_L4_SYS_FREE_CLK is a free-running clock with no gate control in
hardware, therefore attempting to enable or disable it is not applicable.
Return -EOPNOTSUPP for this clock ID and treat it as a no-op in
socfpga_clk_enable() and socfpga_clk_disable().

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/clk/altera/clk-n5x.c | 129 +++++++++++++++++++++++++++++++++++
 drivers/clk/altera/clk-n5x.h |  19 ++++++
 2 files changed, 148 insertions(+)

diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 185c9028a78..5d7b5f1e885 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -13,6 +13,8 @@
 
 struct socfpga_clk_plat {
 	void __iomem *regs;
+	int pllgrp;
+	int bitmask;
 };
 
 /*
@@ -437,8 +439,134 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
 	}
 }
 
+static int bitmask_from_clk_id(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+
+	switch (clk->id) {
+	case N5X_MPU_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
+		break;
+	case N5X_L4_MAIN_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
+		break;
+	case N5X_L4_MP_CLK:
+	case N5X_NAND_X_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
+		break;
+	case N5X_L4_SP_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
+		break;
+	case N5X_CS_AT_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case N5X_CS_TRACE_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case N5X_CS_PDBG_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case N5X_CS_TIMER_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
+		break;
+	case N5X_S2F_USER0_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
+		break;
+	case N5X_EMAC0_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
+		break;
+	case N5X_EMAC1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
+		break;
+	case N5X_EMAC2_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
+		break;
+	case N5X_EMAC_PTP_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
+		break;
+	case N5X_GPIO_DB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
+		break;
+	case N5X_SDMMC_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
+		break;
+	case N5X_S2F_USER1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
+		break;
+	case N5X_PSI_REF_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
+		break;
+	case N5X_USB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
+		break;
+	case N5X_SPI_M_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
+		break;
+	case N5X_NAND_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
+		break;
+	case N5X_L4_SYS_FREE_CLK:
+		return -EOPNOTSUPP;
+	default:
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int socfpga_clk_enable(struct clk *clk)
 {
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
 	return 0;
 }
 
@@ -466,6 +594,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 
 static struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
+	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
 };
 
diff --git a/drivers/clk/altera/clk-n5x.h b/drivers/clk/altera/clk-n5x.h
index f6a9f0a7947..87849d35e50 100644
--- a/drivers/clk/altera/clk-n5x.h
+++ b/drivers/clk/altera/clk-n5x.h
@@ -199,7 +199,26 @@ struct cm_config {
 
 #define CLKMGR_LOSTLOCK_SET_MASK			BIT(0)
 
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
 #define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
+#define CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK		BIT(6)
+#define CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK		BIT(7)
+#define CLKMGR_PERPLLGRP_EN_USBCLK_MASK		BIT(8)
+#define CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK		BIT(9)
+#define CLKMGR_PERPLLGRP_EN_NANDCLK_MASK		BIT(10)
+
 #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET	26
 #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK		BIT(26)
 #define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET	27
-- 
2.43.7

