Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C4CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACB980422;
	Tue, 19 Aug 2025 06:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Gkc/LLyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F5780EE5; Tue, 19 Aug 2025 06:37:56 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03570802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKxF4BG1bwRBGL549+Z9p1hSr2xfqlIFMAD4mNKKFE32fBSwZCmjJqWptyM7h4CMjVcpvGKneVITKsNw/Zt1lbNQ9ypI8+uJ4R6DIV0UfQe4rlodHD+HpaZpxDBTWr26H8f+NVq4JWGWigfcurwTNuXzK6paL/8HmwWsAzKu9CNJBDMJrBj41GwgfpesF/WR7vuDtFvS5/AihgsMv5pqgB5tvuZU71AaY4caulBuv6NNE5WuRKl6qpS7hDPwyM0nl464pULszmCqNBTsPs9cluaPmoG8wgQl4675xHZ5kw5WwnnGXf8pj9tNjgRf2XPGeN0OobxpdTQTYsgpgE7YMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPxQCRRE+/Yf3sjg5o4KS/FA+ZuBVdaySiWk1ijbRA4=;
 b=zAUSfqWzcRAOv7JHEGCNUkubxJ9JTIcA9byaf3+LOArmDZotGWdXMogBaU5v7UA8wy5lShxXcHvH5c9VYRcOjnry4cFFLG0U0uTiWcy//kva2WXJkwBivTGUbbSHfn93z/zUR/pkWu2lr2oDM+v1Q/kP8xPx3HwuDUYmx7UbKfX7Vf+/y31AWE8rR0FGcWDczpOZ7P0PS0Vib5ilOwbbYu4MuoM0VuqxiUvVWc9aumu2eegBZ5M5faFDdAqrM/V29kr6rilTzyL/7FYDH9cE/sqG1Ocio/fMGlLdVEZ/vGBXMuwvvx2ENNw3RdQ0lQmPyfs6ZaVnSTme8qqBFoHt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPxQCRRE+/Yf3sjg5o4KS/FA+ZuBVdaySiWk1ijbRA4=;
 b=Gkc/LLyL2i0LvFZ2gYP5E4RLjYuqbl+sOdAzEN17uetO5gVrkvkrxG3EEP2vzMAurtGY7Cm1eeJi2zC8JWaP0eM4mLpT1Jh/BhHpfaFos51bv1nec0RUG8b9Gzbhi1tuahhbVKi09TDn4RJYjryQHdlufFo3cYqRWlPgifAHiv4opYefr5x6mv5HzpVMi5vYKLtb8m7dYSggmR2GD8nwdiNmka09Yi5WyiH4mW3qzHoxyFPxFCsJDrEBQEC8OswAu1+t0qZNwsUywRw2mElUQJGdwz4K/Al19gVLizGbblQjEWeIccjFxLt4S8MePGeb9h6FUILBtRBccSz0pTYZcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB5688.namprd03.prod.outlook.com (2603:10b6:510:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:37:51 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:37:50 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Sean Anderson --cc=Tom Rini <"seanga2@gmail.comtrini"@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: clk: agilex: Correct EMAC clock source selection
Date: Mon, 18 Aug 2025 21:37:43 -0700
Message-Id: <20250819043743.8000-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 56881899-6984-40f2-f0c8-08dddeda27c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loT9cdFm1WwNdoVR+0/20fKgoz1U75aisM5DX7SCKuS1qnd85dc+0mrZOLxv?=
 =?us-ascii?Q?b+TsZ5C/c46Zivhy480beKspaqJTdSLbRPTyq6S7MnB5HybT6ztTJYBQw6gk?=
 =?us-ascii?Q?7quW1UiCLqhvVZB4FQseNLAob82+wNKzmd+nyi8IsHlnhMXvFfeJiF2A6Fpm?=
 =?us-ascii?Q?hlx0EN1VPPkLkbGO/2w4ivWttEm+W+XwP6WSl1iyPB2ktK/HIkDKukTZA7iF?=
 =?us-ascii?Q?tSdrnWalSg5Ocy3X67t2CoqDad7+vQilhF3oaoA0CVsw2tumlG56DWSPlBLR?=
 =?us-ascii?Q?cMw1J7FBUAZv1hNRnZMFYiQreSpekebZ6axioCgcCGj0BYcF9N1OKbBbAQtx?=
 =?us-ascii?Q?w6p4Dauv94/geiYlmg6+Nuu5gasHP9HlqSl+unb+gdXbRuCmzP/yDthpq1HP?=
 =?us-ascii?Q?Z/7ujzlwBaFKoBJkKRkCYYo6krm240pIMRYc+P3bM432W5G+9Uwt5+PkT968?=
 =?us-ascii?Q?5WckRosLLWzIKBn4XB7WJW54i0NAfY4z67QJoeSvkXAPHiLqN0f/tYvE8nc+?=
 =?us-ascii?Q?Mg4Pkn2H2VI73rOJbeCZtEU0p2EelwthJ4PkdMhHwdfW2X15b+quzUsLf8vo?=
 =?us-ascii?Q?s4rpa6wSpKfAzsbidyNs907KQY1MbNZQJks7rOg8i4HqcQEbM8SvBeKyGRgu?=
 =?us-ascii?Q?0nNIrnKYUZBKhObEZT9pNrGurRIgGJ8Fj3Hn+OyZpxQrnYWvX1qcnzbt86TJ?=
 =?us-ascii?Q?JP+hvN53fgvk4uEiPYK/euZb2LjPeJTxM889rj4iXEdebS2ZDHYIFztkFBVG?=
 =?us-ascii?Q?lorTtVrpTVSF5CAQiYZlLHKnHOSXRRqylf5y/0H4iXSDu/Y5sYb4yybcoNbt?=
 =?us-ascii?Q?EASLQyNbe+zn6YGy52r72LjHxPnsUE2JDk/lo0n1fzLm7zpGDgLn/ykJndbz?=
 =?us-ascii?Q?e1AoYbO/kcSiq0xlTVhGkKog5+Rvh4DO6YC/kVyCgaWxHWVHTumzq9bdoGQP?=
 =?us-ascii?Q?q5VGYBF4ToiIl5cbD0yA2OKei17XvXQl6ibew2JM+nH1g2Mx3DFmwCfUW0SQ?=
 =?us-ascii?Q?3onfQQNytsDvqQidxlCLkWxXaeiNLbqrThGPWwlW6wWXOFjYoY9h1RHEVkck?=
 =?us-ascii?Q?7uacQZB6KnxkD8jfpL7EBf3/IXG4imQo3Z3oPMcK1YKzYABAlwST14qVEiXS?=
 =?us-ascii?Q?mo3aYd0VnBwe+sa4Hma1P/R7YP20GL0kjKfHJ5xY5ND+MO7qYUO1hgthKifO?=
 =?us-ascii?Q?9nT+tF91Ervm/jrb54vma2fqZ5n8gX3smqDgTfKzqKjvVGNKwRiAOQOdXqPc?=
 =?us-ascii?Q?tZBINakVvYA9dycB9sG0/7wxTEKEB6rKk8iui0L/I9ok/YrV976LzK5Ceufx?=
 =?us-ascii?Q?EIcOgq5GYefLKFycm8u5ibQmrbrTfGgxvdOareARlUHcMzmdy/pFskd9uj+S?=
 =?us-ascii?Q?K6dHz8kWIPXl0DzVGaGMp56fid352C/ngF5yrCztZ49W0LzuRQdPnos7BeaZ?=
 =?us-ascii?Q?0wkDw+kI0bI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2j3XLB+MGSF19Z8CytyjsNlYN6K0t4dd0vsYFwBrzFXwbWiKDHn6bZ845Igg?=
 =?us-ascii?Q?hsvbqotVYEon5gO1geV5nLbafNmNSXKMyLEVMyhbge5owOaF28hcpUL4ceeq?=
 =?us-ascii?Q?eV8FgNreD0gbrsQ2HrSo+bmOAQEKmr8EMXVTjkPxg0YwJhOctPy/TmODaS2z?=
 =?us-ascii?Q?9foDOaMkSQQ6YZdOZJaV/AjXsxXD7wiSYk/k1EfLi37KdbIaEG95RKqKN4ic?=
 =?us-ascii?Q?3kQ7z19RezOGoSDgVQIdztAJrGxgg190Qau3UKBhXVAxuLYrCBn5D9dE0CoG?=
 =?us-ascii?Q?L8aJZYsoH4L7qelJDVqNov6C2WXmTOuU30B1ANqGLygqTygDMP+8h6gnrZ7R?=
 =?us-ascii?Q?+MdKhhZyOutOMzQZvfeuIlh5/kHBUCqrg+c5EhfBl7/FlEpY8SljVn+RhZw9?=
 =?us-ascii?Q?AndmUw7e+zmBK8JocqONrGI/21IBMzdcZAdaWu1qNb5zESu/EEL2ur/YXUGZ?=
 =?us-ascii?Q?DMHVIMfI9N9woh0P8VmrsF+pmLrqKl5/p2TZHMwt4BVcIKt/d9V+W7cKFCc+?=
 =?us-ascii?Q?6LcSScABIavVdfQ6zLacaw/SGcElMapXExXKgRT2zYlZrKttcihWr3T8SWAd?=
 =?us-ascii?Q?3kAY9h2lMBDYqIPTajVTgxaOUaocA0NTj3PLozwYyRuZ1nOhJHq00YLWwkoX?=
 =?us-ascii?Q?5jaEVGDUkjmtgHRGp4v7dEMBcFJhkrHJO8vh0Pt/UtdqJzHh5LHQvvv3kGTZ?=
 =?us-ascii?Q?2XebZNktctlFEeVwf/DUsNkCcvoP5tuwSF1PHPwd+ZzPgMYPt4n921V0G1tZ?=
 =?us-ascii?Q?pEsowjELFg1c1pXdGhOhudqVAs4Cx+WP/k893qycNh5ea8FxxWsbIELMDfSD?=
 =?us-ascii?Q?Kp7JtQp11DznzsxzN2sNRcu+p8t+iVlZgViOgbCViA51i8BkFOhuBdZbjXGu?=
 =?us-ascii?Q?L3MPFbSgRYK5lIeZ1aIN7FM7xPej1j7JL+mOcVXbNNH0Onz12EFPBO2DfXHh?=
 =?us-ascii?Q?6u0G8BrXeDln1XYFWpIo/JC3p0sDU2E74gJjDxOfbVXItMvQ892Gx502pVHG?=
 =?us-ascii?Q?Be0qe7BHh2evt+81eY8tE9VXxWhYVQRx/oumlX9K6fDAddGzWAuiSm0OV2YQ?=
 =?us-ascii?Q?p+zH+Jg2gBK1WKHi41TvIksnq3p6uo54d7eT723n0umpIOX9yj5U1oLOxQEn?=
 =?us-ascii?Q?8TfwVAEILXOCtU6dF9W3pHByskQvJXJyMOnEIsJ38kBzOgn8R42KEHICUu9H?=
 =?us-ascii?Q?d8+cM2ha6SqazYAUVSQl7rOmFgMK5fC/Svh+IDyO+s3bsWifbrVcqHXmJHv6?=
 =?us-ascii?Q?h2s1saK+EZwfijer2OtRBuwjB0knOgrOHfqETk1lgz9oPxM/Mct/8/zAI7AL?=
 =?us-ascii?Q?AOVljy0oaMU9+G5NY4Wv/ZYqZm6nyOa9ip/B0OH0ej7xFu/WVfWAOuqILMre?=
 =?us-ascii?Q?F/kQbAPp4HFsuL4F5UgYSLIjoAvFDmMO3DGbFmxOm/lw11Ca3F1zhMIwbagf?=
 =?us-ascii?Q?Yf5u+LFPOip4L8J1jmjBqh3VKW7qJZgJ7eIO1/Sfl/J2GbG4hTVjw4roW29y?=
 =?us-ascii?Q?e7GiPREbAqKWv4pAXvYRRFrgzVaoCjeaDvlS8SDHgp51iTwPyT6Y+RFXeVWi?=
 =?us-ascii?Q?bu2KmCgWdoEms78schzpPY92MEk6MdcgnIDohmA6wp20kRU6qa9DjFRnHE6v?=
 =?us-ascii?Q?AN2+LHZ1gLCqRZ1pPRO4By4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56881899-6984-40f2-f0c8-08dddeda27c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:37:50.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbhp6MQRWdY/L1kBvma/mBMHeVwCPYgJr1pYdxwsjirvFFgWvuBwP15UWVGRFKbbmCyM7rAQO4yFJS66VQDYY8S8lT6wpXnYlAva4aPl3/pj8XeRip8cJcjzg5MefEjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5688
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
 drivers/clk/altera/clk-agilex.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index e1ddd02f356..967d8a41272 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Intel Corporation <www.intel.com>
+ * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <log.h>
@@ -515,14 +516,14 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == AGILEX_EMAC0_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
 	else if (emac_id == AGILEX_EMAC1_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
 	else if (emac_id == AGILEX_EMAC2_CLK)
-		ctl = (ctl >> CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET) &
-		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK;
+		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
+		       CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
 	else
 		return 0;
 
-- 
2.35.3

