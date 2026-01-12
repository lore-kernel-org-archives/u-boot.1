Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B4D25030
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 04:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E535839AC;
	Mon, 12 Jan 2026 05:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D24D83980; Mon, 12 Jan 2026 03:40:03 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E7483980
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 03:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnDJ53nNCZKvW6Cj1TZOk43Z5z/O59jzl/zPm/kVmN+h8bmRck1H+e1FeY0bd6g2hCq04tRKpeDHbjQW7/dMIWC+oTor5w3TZijqx75FA1hYPkCA4VdNXiB4IO8QR27dY/U30sHlroI4lvkbEDTieVyGZyFWoeAUYLvvs9INA0V+XPsP4jFKnaj8mpWPIOxxnh4c+8Yu0/YvdR3RMPCdZus3Mnu6uqap+tXcC+waMxsl5zShL2F/zrMNIB+my8KCLLClvGrOEcws0ZxZTVAI31z/T3eyEoG3OYTsc6zcdBQdsXkpv/XX1ai/Wh0IYSuPuqGUYjAYuf9RhMK2bztkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tB2TDg1rtiOQsLPRqyiQLR5ayZR4Lg+NU0glmHj/pw=;
 b=V8oMn2OW5mcTgd2C7CaZpCK+Nd8mFL0vtTOLlDezQy5BtucJAXGKdZG2qDU2YfUa4O8pTjsl8Zw6npbZ+s96Cvblr3p6uR8cW4Zo+Zj3/tj7EHpaeSiggRIblMF3x4Lf1Kt5TArvSrvlJL010vXJT1bhDm5yOl1xWR5OL0My4Jph+30q9ZiYi1hxYQqIf6c+w4ZS3ZPpojMY9AZvganPKld4BNEseeZ83Emn8NcVUZLBsAlwFMICVtKAkHPUt/Y0SJOJiDTZucNgjbLKSo4ptzwr1uX54j5iTtILG6lHzjdVIKobJ0bLu/IMO7ovWZOCYtTbIu6PnxOvvZhIb6thYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.20; Mon, 12 Jan
 2026 02:39:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%5]) with mapi id 15.20.9456.017; Mon, 12 Jan 2026
 02:39:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Tom Rini <trini@konsulko.com>, Leo <ycliang@andestech.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 oliver Fendt <ofendt@googlemail.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
Date: Mon, 12 Jan 2026 10:39:47 +0800
Message-ID: <20260112023948.46008-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
X-MS-Office365-Filtering-Correlation-Id: cf682ede-a4aa-4993-003c-08de5183de98
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: hb8LiS/FocYEETQkDR3INR1snzIfHQV8rm57t178zu5p0wjIJr+C2xpKHPwMHlAURuYJU1vLZ7qfl5r1GtDJe2aVF87uKcE9+LJPTIK2yDDr82OAp4CaFDqotw57/+Ohj1RVFoK3w0rID9m+ocesjthfVn4/ScwqkSa4O4TYtoPCeULlcTX0LAr3cMIUoOiA8WNRkUMNGAqrF/9CV7IS/q6ArpaAJuHUiMBN+ydn3LrT7UspFv4Gkldu+Ha9YSG2lFfeDpwbiFIunGqmbegS+8RAKuf+/DbNkarYoZtPzc3YDe2RFTaemIuVS2SsoWK2m8NPOVQ/UBDGSnYgqVQc1ru1fe0eYj5bxLfbD6CZtABmxAhS3z/xksmLsldwdXuZ/Y5rKVJ12dysIuh+9uyutH7elPOARpIJGN5KkJttPMLx+9OsJthSH1hkvMQvTzIHJE+SSSbbRJiZVf5G+IYvZcs8D/rz1PpdJ1QqrLBy4hay08zqRrt0EPptB14QLcfB/0NSwOIdEdzBXbgjK0BPIFAAMcuJkJY+Cf9tBSsFdM79no85fboGzgLrcR/SLKfOE39kXZ9oWAzyZSxKsFShphNotqfUZysEtRBK1RSEeHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(52116014)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QMYSdQBgH4GtKduXUNrNe5UNMSJHKu8E7tzL91Dr/nmyj8TjLdx9xhIaW7q3?=
 =?us-ascii?Q?lpij1ZF890Ha2NK8tqMDk5bMaECsLv0DEwLFMeGUJ0TWXTTHnY8aeWoQonOB?=
 =?us-ascii?Q?bt7iLmjL8EA1P+k/cWKIvzNE84YiJzpcsdfqp3ZZBcsZ+JxPWtxki8upLAld?=
 =?us-ascii?Q?c7SrSFPxAud/z2AZDAJ9xxyiGp0ynSquK615X6SG0S43TXD/4ZtvaKlz1p8f?=
 =?us-ascii?Q?p4W1GWPPFhD/LUDvaZm8YtCBcMUA3N9NTcoW9hpdlrsWTkczpZ0Blesjyodw?=
 =?us-ascii?Q?uMz7lXgsiHHY64aD3o70iycrhn4MQOwA8IGJvcdYM6QoxgK3+4u38+8FIZkm?=
 =?us-ascii?Q?pWSXVJeujM9T7VqC/YMI/f95l45sfFMn6qwy2OgMrZE3G8+RCoI+zR9hxIkj?=
 =?us-ascii?Q?GzSztSaQ1fJWdq+ox13uTYy2qkvxeluvyFiVwMvaQhFXZAsHwvVYy+xtMKEc?=
 =?us-ascii?Q?80xZLQrus2KSSCigSPOkvy1/X2LJ/YS/pGNA38YVKe1i4RMWuuUXJ/rQFJbf?=
 =?us-ascii?Q?dr/elKdwhsAOp0+e3Tmcr2qSR/Nai1mJkzcOHocHgA7tIJo6weIwnRX9+VhT?=
 =?us-ascii?Q?+lstxAhlVfeolJX4pBfMNZDxkJMJEJUe+exCMfIr4pXXl4xMwFqxvZv2X++l?=
 =?us-ascii?Q?MsN794qjPYL/SvW14S79yscW/i9EKjktM3g8sziJH3aZIVDviUNNjmEtO1pi?=
 =?us-ascii?Q?k1i14KwkL2GvWpqghMZadhN0DGuzJF7ojn0Hn1qMsUJ47NcxGcaWvWYWiXh9?=
 =?us-ascii?Q?A92a6rOdpbAv6vzmD9wvZZWPYhfZyzFrrKPnrqZqHMaYGGIZdONmEdGIJS+E?=
 =?us-ascii?Q?tREL9zYOcI1B6CQSCZZUHGzDXa7zkfwywgqR1Xkxp3zc+YkW7wILlb/wfUH/?=
 =?us-ascii?Q?TlVQ7UEHgyLnm4xlQA8gkgx/B6QPWbgpVAqe4wKhBAGxm0GS3XvVOZjdOlmG?=
 =?us-ascii?Q?JM7/uy3hGfGaXBmNLKRqgYHK3u4ZzxPicxynmJ0JNNiuhTL7vJstqjBx8BBM?=
 =?us-ascii?Q?giV81duI0GPacRT4Y0Xfrfj9jlEueJfyELtgfc+LBfA+AMOftyxNeT2sjtMo?=
 =?us-ascii?Q?HYzjvUBUSMFywSD5xtH6xs84OkA0PKXkkbCi3XlzUcepvV4MfQ4oPfvMhrLV?=
 =?us-ascii?Q?iTT6EjlZnNpaBHPN593IqtdVYM2d8RAy+rS2sjqC1mt/sKwQbxxJ+CjQPsaP?=
 =?us-ascii?Q?ZRgx+IHqd3tFYlSzonzUcACC3j0ajSdolOhTOIt9OdImuldtfVQHnGajrG2I?=
 =?us-ascii?Q?7sbckbP/6x1dp7v0WnZ/Sna8t3/peu+gaOOuIIBi54z63MLrSVAP/2GN/uqO?=
 =?us-ascii?Q?ibzPmM6VSG/5alyLrvET5y0TljBwL6/sEmpq/aQHZcr0D4TJTqe/P3OpOgtI?=
 =?us-ascii?Q?KbVq88Vh6djvGnw3EUi1hVwMPzmHR8X/ITY9QU08iv4GgVnlNlYahLBUkBn9?=
 =?us-ascii?Q?OKaZMXZZwQxW2b1I6U7O7Im+PPFFQfHioB9xDftFRfQDm6EihXsCMdRZQ2/c?=
 =?us-ascii?Q?+0TUjqqdjWS+P3T9r6GIb+voqc8931oM5JZLI2sof/SyehJQqp6gUv9wV64c?=
 =?us-ascii?Q?RaNuKonhDTCL8V8MUgZEgy6ljCk+NLse8YE+pU3agJsoSzBw9JyRc157BvVr?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf682ede-a4aa-4993-003c-08de5183de98
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 02:39:55.1955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIy67F/tXQ4Aae4FwBfCVjJTphSnoY71aonuRy9khG+TVqB/At2mROyv/VxcYhThuz6HHEbre6Pa8E+amG6Q3n9oITy3QpFfSJeyDnGkabU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323
X-Mailman-Approved-At: Mon, 12 Jan 2026 05:15:18 +0100
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

The license of the file is not valid. Fix it to GPL-2.0+.

Fixes: fe11aa0b8ca3 ("mmc: sdhci-cadence: Add support for Cadence sdmmc v6")
Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
Reported-by: oliver Fendt <ofendt@googlemail.com>
Closes: https://lore.kernel.org/all/CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com/
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/mmc/sdhci-cadence6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 91a245aa490..ca1086e2359 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-platform_driver
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2023 Starfive.
  *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>

base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
-- 
2.43.2

