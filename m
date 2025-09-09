Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CF9CA1016
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 02:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B9E4830F6;
	Tue,  9 Sep 2025 04:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FdDnLaxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8A0800B6; Tue,  9 Sep 2025 04:13:06 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8AC82A9E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 04:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMjde+GjKQCrMCxaFJPpUmL+3ve/8vgnMgcI7h0y1+lvGqY7t3pu2MyiCF6kjyCHC1oKzmvfzaONUB9dIyyYqWUE1vEqiOYFJbdhDIilxHQjDi2NCP++fiRVS2a2SoaVHLoT1ou9a31/JyKF4qMKQxFauM0gws8EIIQ2gz629fvAQdwImjDz12bIXzx2aV+0nRiuib0JqxWSlRWVVLsKXXBH0auROTrxukXfqidJqPfDW9Ddq8pEKkM1s4hr9EazWuLktqbLphAuWLM3JXbUMUXtiTkPs2TrysUEpvpW2AmcAf97Ju6ux2cJZ7VpQrNgsNUU9d6Rel0Ct3AAON7MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVMICEnCCYPDULn24PUoRtr6Pg1Hnel1hjUb+vXqcpI=;
 b=KO3VgmmWQ9YHGAV/E+a4vFRlnwc4gwWbycApRB2Hqub5CWVbyfLFNfgh6RjaETjvEIRRTXtY+6V5v0nwvHQNBrknl9s2meZK1jwwOH1+uO+cmPj6YyiYz4x7lIKXlDEzW+dmxH0qnBPtBObE/rfYmmxrpVWzwR8jV30F+dTOi7Im6tKCunP+LsStLLhW8HKbMjo3FZ1GyvwwnNl71etIZtXTfcE1m0yD1+XGJZq136DZ/Fihj6KdHcv8FI79gc6hWWJ8A03+TKeiWPVGGmWNMtu+4rrygi+tnwAT3jj/z8NlvhbvcOGXabLje/9v0Al92D5eimwrCP/5eUcZI2DAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVMICEnCCYPDULn24PUoRtr6Pg1Hnel1hjUb+vXqcpI=;
 b=FdDnLaxSb62TbRDh7QEns2vNhDH3tUxmyBhPmlQ06Q0o89IBrHBK2n6Xb9QYKu2vdvxl6DwWxuW36X0i06XTBqG91/jWLSq8oWAV5dC+TrZdba1iyda9675RPjeV5f91Uw28QSeQOxFleR6FvhQGEiWZLOZK+pmVkQTtImsz7fdyfFXwHaZQVKbvwQ7ThyfHJNcqA1dVIiLdV18CvWwtUSYCZXDXzSYc3guXzrHSCjL9tLo/KPAwnHQrllQtEKVczySHQ/DbKKlfqM4aQ23mWSL3e8/G+A/B03ao7mLJ+5SpZfLiNPx9rrnIwyD4lDjUsjnvidnUYrxSD5V3UrNEBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH3PR03MB7314.namprd03.prod.outlook.com (2603:10b6:610:1a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 02:13:02 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:13:02 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 2/3] drivers: clk: agilex: Support for enable/disable API
Date: Mon,  8 Sep 2025 19:11:15 -0700
Message-Id: <20250909021116.12599-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH3PR03MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fd4dac-8c3e-4edd-c0bd-08ddef4667b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WCGO5Z5jiU37EI1o+j9FOAtEQG4PyLR8q33D4ja1wy9IKhtuXzdVtVsAI1HC?=
 =?us-ascii?Q?s/c7O3CanI6nUDKBzOilPN8ewjikZUk79yH+mbPcb0iqHoPwLAKjQOKrH0L3?=
 =?us-ascii?Q?hPsvuJ7NdIUooeakQufyZk2cHN3goXK6oINX+ksX+aj95m8bTyxqMLGBROX5?=
 =?us-ascii?Q?ATMkFDOXRj+miiiN7epYVZSPBbzTLqDlZiy7DoFfpXJAKCPpQib70k4qQlfg?=
 =?us-ascii?Q?UOHcwKYN+gb49uauSajy5z1tzpSSLog0l2AwBfZJClHI/Se/POhpfNlrPo38?=
 =?us-ascii?Q?PYH4ZuT5GsO2fI7bG5ahyVBZ+gZGbXSfC02UdA632281e+ZC2kc514oD5nZO?=
 =?us-ascii?Q?bnOctKzz8NNxZ8dbzd5RmO3/jFWOzlUqeb1MNIY0EjNsFDu0fDJO+xbBLYT2?=
 =?us-ascii?Q?O+jGMrBlUVRnfMAHX8S4Tg/tpXtnd73wYGUmdmhE9+k9WIi5jghFWFCc/8W5?=
 =?us-ascii?Q?6PuAYkOvkr6NN9SvwycM4YOsdiH1DBdvyQORNIz0RkdutucKhBIXnBAgg/sh?=
 =?us-ascii?Q?baMLEIL1p5PnqSmvOWkSKK6M5XH3Gv1aZQpz3DSZ3prYBQ0XmI6MYLSmt2R4?=
 =?us-ascii?Q?UDyAQbKEoKbX3o/f3mUesVrAkqrSCXXEEUYxsOCx2D9Tv9LYU6sV3M3hHj1I?=
 =?us-ascii?Q?wxefgPT6C+elghTu2ad1tkBK51TXJ4BK1W7ef4kvekOzGkY7PT2CxSn2vJS4?=
 =?us-ascii?Q?n+sEnrQdFttcDnJmT/CkexgCx6+vDumGPrG1eT1/CJDFnYVfhiyAE2CbgrOg?=
 =?us-ascii?Q?W3mbzb1pqJP+VHvTKUESwwjoPrcwmXQ3xepjXiUmvNzVlX83lqlx7mwXrc+7?=
 =?us-ascii?Q?DVxxP9VC1PwjD8ltKUtf4jqE2JHkUe58ql+jWfPBWEGQJwQuF//6AXp3mED+?=
 =?us-ascii?Q?MdatCUcSPL9B+juM50MRlhA6NbnJSYuhq3L9Dj7i/sA/CobpHMKVVSqGWaSO?=
 =?us-ascii?Q?0KV8WgSi59py8Yrcrlyy+jnGEdvp8PCtw7vPDrIFTj8OwF5EF+E47eX2EkNE?=
 =?us-ascii?Q?9hozClSPdGoiNT8KWSRW7wEXFaQUUY521rq5qAq/nbbimlrKTJO49KwY1/Ry?=
 =?us-ascii?Q?uT5y5erSboMBUz5Fr6ORb5elmOJhW9h44MWt7qHlMbQivVCfB9/nfPsryNdb?=
 =?us-ascii?Q?h3OOF3/5zTqOnwSE3PrnXKVg5ly3KUfiJuH0A9T116NcF2Ofi+Z4eUb1FKEY?=
 =?us-ascii?Q?DkeIvbW/89KPrhG5GHhCNEDjVxNlJTlfKsHy2kjQ+fOgDstSu64n6S47Xp7w?=
 =?us-ascii?Q?B/4MsaXi94ugunB1Z5kvAryfo520W69i2NqrmUUHw6JYTpZfUM6Hxt3wc/Os?=
 =?us-ascii?Q?iCb38eOYDD+GgmVo6WtSgtePau+V44IC4cuuKHxBVSeMFr6LiVJyMegBNMWV?=
 =?us-ascii?Q?Y0Eld/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7c/BRor7pH/yM5H/KQG9LLCSUKfSwMPAVXvmE0T6l6qQSI9bLCFl16GVjRP?=
 =?us-ascii?Q?aLhfHpWLrKCts5EwT3CZPyEQvqjp1wyVSUtyi1eIAHVTdT+gIgJJ1wux35R+?=
 =?us-ascii?Q?S4vS/DvKGmlPRFrcc/JZUrHCJB3nU3ZDcR0kJtqLUrHy3HO91hV8u/LSJhyU?=
 =?us-ascii?Q?G9pVxo1NH0JMYWStdvtYJAbPZ8k+j/QLHoNlFvctD7ZNjl4vVWLrLOrzPRls?=
 =?us-ascii?Q?ze1ISr4zgz/vH7KilHTU8sk1jm2NxsL3nQg9h5tGHpmOYMt7+hyqL+cpfYoD?=
 =?us-ascii?Q?ymHERw44lKiSR89Nf/c7mBo7pozNHNeyVNt3s+zB1auHZc/RHFyQQqe0DchC?=
 =?us-ascii?Q?4vqU/x+Sw89NkXtTGm0nmViSvtzayF1hJ3X+geLQbi1R60T9eSEQDfjEs4zc?=
 =?us-ascii?Q?0NrYNSpvSKbvMKSAJV0KtR2vC2yRCQ6haLsMN3/s9m2CpMLnIG5jNWVzOXwy?=
 =?us-ascii?Q?fnnLiiKFDf6dCtGNdhqufXxsC9ATjLiHkdWDJd90ei+gl4xjLb2MgeyWcLcB?=
 =?us-ascii?Q?BOU7SLLyQhI/5ydpHf5xXe3NR4imm7P4JmnD57uWr1DJQUT3rJbCg+Xssq7c?=
 =?us-ascii?Q?/2HWxNUwKUujEsmFJhJxoxrIN3yY43eVsXzxni8lEeYWkB0kapWXmSR8eBfA?=
 =?us-ascii?Q?R5/DdmCgfV61n1SAlQUxB4mSW1BVDuggKbClyM+VdL+OsIFDchqZlxFmHcRk?=
 =?us-ascii?Q?pnaoKJOqL2S/Kd+oWzK3MXklPfxjhnLoqIvouQI8va9U33lRmyX3vy7f8H9w?=
 =?us-ascii?Q?0KbgCJ6T39BQ8coQUtncJvUjI94MnBxoUDWxsUXc/oxaXPoVOr+ZgqcHvSoF?=
 =?us-ascii?Q?kW9Hqyl+ao8FqqNc/jd3rZJ7FFaxrxQJyDoo6pYNSNnGJISy6dDzUFkBZfGq?=
 =?us-ascii?Q?IJbhYtsoF+zRAOMFMQENx8ZHz9qENoFMW9rMfjdJE0v+lckhxUt77FzzcTl8?=
 =?us-ascii?Q?ZcXPV0dOcffLif0q2ka2xJIEsjDtp2jSlKg5hysEDZFBwDUrFBFY9Sx27m3G?=
 =?us-ascii?Q?Cg+vQT+9g7PqAuOFr4NUSiaIgcPw5Sby5dQM4NQYIoOMcfiMaphukrSuByvc?=
 =?us-ascii?Q?aH5ISpZ8FZHl6d/KGqIkjeOiev06Acus20FlCqdYWJWqMmN2ESfYc+nMJakG?=
 =?us-ascii?Q?aNxCM1ujNbmgwtzlA7TFMOhtBGXoNuK6t5mlN9Z/NvsGQAHcoUiiIhcj0I10?=
 =?us-ascii?Q?Xhbha9VbKpUtb/j1i0/vT1gtGuK1xIOfBjh3T4A/AiEtgM2FFgOIPOf6LOf4?=
 =?us-ascii?Q?7R7UpIb1xdibNWqmfmcdi1UqOjEiKcktQrL55xNCXeCFtp5E3a4YzHovIUlC?=
 =?us-ascii?Q?KnT2BCK+rez7RdlBx13roTSL++GyKjEoj3nn+Rmou/ErkWfB7KGjBxnsA8A4?=
 =?us-ascii?Q?LiCvhKYtnyXowM7ji/qbueF3U44dVcF/9vbEJfh0OrqOOwR2/YR2M9VKGmgY?=
 =?us-ascii?Q?+0FIWZbCbBGO5FuWVoYbiQ8riLkWte8LL9P51PYVPDio7/RXdw+5Yhxp0Sdh?=
 =?us-ascii?Q?M2HspBcURmrUZIXGdAzTSSEBfDuwWdB8QCAX/E3vmnKGPJ5R6bdBLtr6ph2E?=
 =?us-ascii?Q?A3ACvd8RN2Jnva4HmAM1K/2XhHV4ZZE7k+tocu+Xm6CSHvjI0Fld1IahGdgJ?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fd4dac-8c3e-4edd-c0bd-08ddef4667b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:13:02.4833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryE8fnGLt+L7tDw6kY9OQDPeVWzCUeLjGcfZz1k1bxnd3QvcQBJ3SdY85oKQ0i1zNO1HIFse0Ty+7wSkifUBA4cxxxErlUUflQh9JHlWQJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7314
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

Update Agilex clock driver to support enabling or disabling
the peripheral clocks via clock driver model APIs.

The caller will pass the clock ID to this driver and the driver
will then proceed to manipulate the desired bit in the Agilex clock
manager peripheral PLL register based on the given clock ID.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 120 ++++++++++++++++++++++++++++++++
 drivers/clk/altera/clk-agilex.h |  20 ++++++
 2 files changed, 140 insertions(+)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index 242740a4b00..46b04895cc5 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -22,6 +22,8 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct socfpga_clk_plat {
 	void __iomem *regs;
+	int pllgrp;
+	int bitmask;
 };
 
 /*
@@ -643,8 +645,125 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
 	}
 }
 
+static int bitmask_from_clk_id(struct clk *clk)
+{
+	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
+
+	switch (clk->id) {
+	case AGILEX_MPU_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
+		break;
+	case AGILEX_L4_MAIN_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
+		break;
+	case AGILEX_L4_MP_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
+		break;
+	case AGILEX_L4_SP_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
+		break;
+	case AGILEX_CS_AT_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case AGILEX_CS_TRACE_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case AGILEX_CS_PDBG_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
+		break;
+	case AGILEX_CS_TIMER_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
+		break;
+	case AGILEX_S2F_USER0_CLK:
+		plat->pllgrp = CLKMGR_MAINPLL_EN;
+		plat->bitmask = CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
+		break;
+	case AGILEX_EMAC0_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
+		break;
+	case AGILEX_EMAC1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
+		break;
+	case AGILEX_EMAC2_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
+		break;
+	case AGILEX_EMAC_PTP_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
+		break;
+	case AGILEX_GPIO_DB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
+		break;
+	case AGILEX_SDMMC_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
+		break;
+	case AGILEX_S2F_USER1_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
+		break;
+	case AGILEX_PSI_REF_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
+		break;
+	case AGILEX_USB_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
+		break;
+	case AGILEX_SPI_M_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
+		break;
+	case AGILEX_NAND_CLK:
+		plat->pllgrp = CLKMGR_PERPLL_EN;
+		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
+		break;
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
+	if (ret)
+		return ret;
+
+	clrbits_le32(base_addr + plat->pllgrp, plat->bitmask);
+
 	return 0;
 }
 
@@ -672,6 +791,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 
 static struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
+	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
 };
 
diff --git a/drivers/clk/altera/clk-agilex.h b/drivers/clk/altera/clk-agilex.h
index b3e8841a512..be639957940 100644
--- a/drivers/clk/altera/clk-agilex.h
+++ b/drivers/clk/altera/clk-agilex.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef	_CLK_AGILEX_
@@ -210,7 +211,26 @@ struct cm_config {
 
 #define CLKMGR_LOSTLOCK_SET_MASK		BIT(0)
 
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
2.35.3

