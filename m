Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A268DCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7496883FF0;
	Fri, 10 Oct 2025 13:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V1KTbji+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E6C840E4; Fri, 10 Oct 2025 13:58:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C1D83837
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3VT3jrb0drnSOveS8Y6C7pulrdJMyLCL3B0sEjYXcOoHBGq7OdBRStCMkICiNYeeH6LrN//mrNy0X44mbziGMKAK7LwoQm+0YKSlaNQ4MwD+hg6Mv9/fmJab9DIgKRVEiGPCXDffOXo6ussAe0z047imvyfgM6ZXiPGSVgPBp4/MBl0/iIG9pRaHthczVl8cTuPVO57ids2x3Nkr9bLr5Ef71BPHD9+CNA7tF1zrhk2c2D32iM5rMuh9YftwywUfBN0h/gGSDWgZFT1nPRHCA5MPnLdnoJOUoP236cE1zog4Hqa5P3qYCg8kYzfQ3Ftuz3bR9kTiNaaqo5nO5LNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKlhRJrnn+zKClAl9tyOh8itPQoe5iT7tyc3CTQ3aWI=;
 b=pK3Usn6p86p3rZbFrY/qjjthCCXFdLNTDAbxIYqF1OFrXhKuUGWBW8QLoWm60cXWvPDrpxn0gwSWhX9dbPMkC4dpbs2UV0HBO6ZFy5RyLuZ3DDwgw80qCyq2T4bCOTg1SG5rmUEKbdipd6SppnU9LI7jgtivxncy8bzmU8llXMlAI25vMWS+fRcKOQ4Codr7EjqiLEbEIb0FlzvNoEiX07X5v1pKRXwzpTCaUcqHeLwRuApoRQ5pTS2T1mPsoek8RPMvzyt7CG3MSVAXDN77OyfXiZmclVy+dVg50EI6biFY4xVGFQ0QsY6NKeZDs4WWriYbSTrhRjKPjzQhjvOKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKlhRJrnn+zKClAl9tyOh8itPQoe5iT7tyc3CTQ3aWI=;
 b=V1KTbji+pPuhXiA+QGYPFLIzrYur7jsn7OwJcWHEt9xRRj5G05v/cAfUKL2h0GE3O7eFEyFXEumR8DoiBtC3uV/B19jdcLYrn0BxPPwFQtCh3VoovSg4BG8UEN/yMlpuU8j1yssfhYjqInfMbTnwKoQ3sJwNNVKTvep3Ahgwx50vYaPRSada+ZVnYYfRaG0sSBKKe7IhVfSb077NN8l3ps8/x2yqvgiSu0jIThPOgFbHNSx6665O8XQ2xIbxt8y1fZEqSCau98gybHMEtQJK+0KjRNZtySLbKSESfckljvMCIOTqSF4p+Z+o5+Hg0yJu6/t7MirIIDSxXR1DqtJLAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>, Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH RESEND v7 04/24] mtd: spinand: core: add missing
 MODULE_DEVICE_TABLE()
Date: Fri, 10 Oct 2025 14:58:05 +0300
Message-ID: <20251010115825.1531775-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1c66c0-d883-4c12-faca-08de07f45976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHuFm/o924x3ixSZh1jz9ttT6wnzCxLjK8dDRH3q0w+Q0Qlyuzv08tmPJUj0?=
 =?us-ascii?Q?JDoXj3vaA9CUKD7EA4gpMOR2+YTfva3cQE0TfcZ7lA70Upli1ZTtBemjSxnR?=
 =?us-ascii?Q?n+n5Rcs9Zm7tvZsoMMGgJaZsmfHA74su+T4aIJYm2wMv9xPuyAIua0NrNhTy?=
 =?us-ascii?Q?LuD8/32w0cUC3a8IvnEKGqV4dE8yNt+LaT422cbbtS6gjbtxYOH72lQstaJm?=
 =?us-ascii?Q?qEoHk7SG4rtJ5IAOoxSGxAefPlGeKv8KjWScQ+B3BlMrpuOHCBcXYXldI9Hd?=
 =?us-ascii?Q?J+tHEQfUt3JM5Mj8tBghqL86KahkGfoIk9pCjrCx90z4XRW0qxAlxtJJ2dmL?=
 =?us-ascii?Q?8XKywMJPkk6t9X3CsMs7DvPi3TmX2DnS6q9VpCyAR/Q0IrXrC1nlsA/h/H2t?=
 =?us-ascii?Q?RVDpjOAvdprBgYPdGUtOhr3KLgelyFErDfULfM2G7FcVB5luZ5kTXQzW97DK?=
 =?us-ascii?Q?nBjyHAN/6eSRYRb7CvNjwsUROGu98lfRoL6327+MDu9z/u1npA7AT2bWfby3?=
 =?us-ascii?Q?E5hYLOJxt9Tz5z+aeUULuN/NiGJXpKQ46tQ6TCeW3+ljh/zQ9xEwbUsCf6WJ?=
 =?us-ascii?Q?OpxMmpiv8feWkce+TzL2BH1ngLbXki1fi0sBnZjZmSjHtdPteIcZfu20gNoP?=
 =?us-ascii?Q?4ys0V/ZFp51lYyqQl7k+0fQhdDkik4o/9ZXeJ7AK1D+KaDAhdlaVNrk775zQ?=
 =?us-ascii?Q?HeNjdGkgds/xUIwMTWHA1B6IERo+pq8jVh3mJlkoVNg1JKKxhCjyO4vkD3KJ?=
 =?us-ascii?Q?HlbQfQQbFWmFdjn032Miw3ZXcjzUArbm1XUumMppnyJMf5V4V990MEN3ot5e?=
 =?us-ascii?Q?n0EkEiyyMwOSzcYow+1chYp/Cpzb0enkIwtz3aOD2wux0KaR1KoZvnl461eO?=
 =?us-ascii?Q?PL3zgSJH2TqGwvtdRYJ5lOTnJLL8kXjBW/RpHIbiQiNZr0NvBFgyNSzSifjy?=
 =?us-ascii?Q?QSpzyPY5msDw7EfQ9JPoOVVSK9d7P0GnrxfnyZAGwvqjNmyZOD+ehW83Nmtq?=
 =?us-ascii?Q?NzyLvyeQlFkSS0BRcjaz1nBK90IgSwLZZ9YS81vgI615oTTFdp7qcy2g1PBA?=
 =?us-ascii?Q?1AAXEHFiB2qDWANbikZfGlKGNTLvM2FLM5d6axeBF+8UZQVefeuifzoIjdbi?=
 =?us-ascii?Q?J2P6yAJzI9AkRaoZ0dntkBRis7DzT2Oyr/OYS5CRWoDflLa51vvGkjCtt5Gr?=
 =?us-ascii?Q?jwY2GoBRsD76GdPEN8Ed9wLe1IC9aAIAT1It9GsBIVWkXLkbyyrn11/hKmf1?=
 =?us-ascii?Q?YpZTRILBSvNS2INoQUBcX4HhXwODbbXsdYwTmKsUZWdUvo7BO3w/7Sa1Lhq4?=
 =?us-ascii?Q?GhC3TsBSLAoPrOGfpLWE7V/kJ92+Wa0IlfTvnnumdaSkxwSzqMzQO2Dxdw5p?=
 =?us-ascii?Q?yOuzLHRiMNeyu6O8WcXw0p7SZCiw+dy7d9KfDYPShL0Jx/igtlAuAmdGdYFl?=
 =?us-ascii?Q?542wkaoCBERby1m/otWwmEw9xRWvlO1mZbm9xmuPpyHJPu1QIpiJ8zDufXfJ?=
 =?us-ascii?Q?dOuO12mvGALTB5o7yX7lLcltGF4yfQ4tLW0v4neV6iu38qYWu917o8qXqA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYjyaaVwQnLETuVdOS7k69ZsLbqQ1sqRpCkrGs24PEvTXFqsG7cTrH2Qt1Ik?=
 =?us-ascii?Q?C0qFNrZErINZkMWulciYDAeFnrVjwOTjYM+rZh3owalq7ot/NvBqqlPOqX1L?=
 =?us-ascii?Q?WHEnijNRCAlSv7KmOynCn8WL1hFSR29TvKDFPpmn3rEJac0BKoA3ziJo3VLu?=
 =?us-ascii?Q?YUW+1Y6YfJxgX4XQZY7kgmDODlatTofBRN4GEx3XsVzNpftORcj4ARYwy17I?=
 =?us-ascii?Q?F1fLL2gquZdrnVzo+nG34QjEaQJEwy+2lxqEYBylcr9TPltkE70qRRBK0TOU?=
 =?us-ascii?Q?hEbcfUVF2pLLVG7SbpbjYjITZGXeTitcWShbrDECm9zgpZBuh2L8XSSQHl4X?=
 =?us-ascii?Q?lVYNsOYxsYjnYR5I+UnpoEWbmZxvAcIX60ovdMizs2ru8NbmTL9mJa2xmIAY?=
 =?us-ascii?Q?dFEGKn+GJyREDSnRHFMxQf/T/zZwg+3JTS/Y4H8GdUjwwEsviW4fMBe0Q0kg?=
 =?us-ascii?Q?hZcSOYt+FPLwHPu3NeP2t1dJM1QaZF39e2Y6VqM3lx/nASuzPuDXSO524UTE?=
 =?us-ascii?Q?WzgzAh+d8Q0UBXp0UPs9ktVfx9atZoJkygpF0rbTnKegSMk/OxcBhMeHd0VH?=
 =?us-ascii?Q?q/kxLPbRV+391CLKLaXiKKohf/2sf+0000wXs8L+X+Z9mLK9nYb1Or30W7Nc?=
 =?us-ascii?Q?BsBEAr1dwFm4BUpAjx+aRWdzg3cqEqytzbrSCyJy0poBB5ttMB3mS831THuf?=
 =?us-ascii?Q?uzDCdrRbmyVtcJYltpnNTbFla9RQdWj3Z5mMzYI1LuRKR4Isy6brO+/zYQCQ?=
 =?us-ascii?Q?gDp/EwKA7cSuh1yK5CP/NXmVX4rshNpMywY0db8j8zuPCs6QPxw68bvOmjR7?=
 =?us-ascii?Q?rEveMLxFWK1h0nAk/9xv23HaRMivyq64WER2b+bxKnMUiYreVRqvMGgJCLrU?=
 =?us-ascii?Q?NweNliPWu4gHoPMQx3+C0FF5067eyKXZT5cxFiw5hB7ii2yCkB71MXxUE1tc?=
 =?us-ascii?Q?kKI5TgLsP+6/n+jDagDFzao5HCI9jsAUEajhlBuKbMvw2q7lywzNLiAYVyz8?=
 =?us-ascii?Q?a1oc6P/LfggcXk0f3W1WpFA8pe+C3Lexd1R46SDnisnsSD0lY41MDl6vinRq?=
 =?us-ascii?Q?7xHDT5i8UtOED9EqhSvD9uNuYLrxelU5cK4/qgbDdS1oXPWRTQfzYAMK4SFg?=
 =?us-ascii?Q?HkrCyUPvyBlTklFySXSOifXS+rY6pBStx6mtVs+hnFOwT/L6jtuBbHQHFNkp?=
 =?us-ascii?Q?Gx+XWA6bBXkzdQRjW+sJ7Uy5fqkLEaIvLHxx1ZqlRPPRwp+E2SyBpQljXN1H?=
 =?us-ascii?Q?3krbQR8op1pVGUVQBMMe2j4BbcRyQgEVmCNH7a8h8FweCXig1BH5dVhm3IX/?=
 =?us-ascii?Q?eCBrFQg+zh53WuhPYcDHF78u/0PgjhKATs5ggdbQk/JBXGmfVYxtIeAf1D0r?=
 =?us-ascii?Q?D7xmeAvm3IwjPZTcYbN3ZYV/QiXlvjXDLPQYa1E0DM5KdjonMTzvQ5dyluL8?=
 =?us-ascii?Q?SERiu0omrxBOKCHhP+X+2I0+t7UdqI7GHp2LHUFDlsIE/0Iel/Fb7TXo6hR7?=
 =?us-ascii?Q?uzAckZ04a/Yx61isj/FJtn26cA2ex0InIWSHdEC3PLkCw4jxZ1MsincOh7KN?=
 =?us-ascii?Q?/9Z9zX8g/N5S9OnXtzG9IepixwjrJCht261KNGptjweGeNGeza4gRbzwLx0X?=
 =?us-ascii?Q?y2Z/Vtckj1LBBP9VjfA29qQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1c66c0-d883-4c12-faca-08de07f45976
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:38.9967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN0ZU6Gn5bH5Ab23lxlnQ6CCTIhbhheX2b0c1C0/Z/gv0OCW4uOjgD6BXJhd4q/UnYRtlUZCSxOpOelwHPPAImk6bQiBecN06PYT4P9wQTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

From: Alexander Lobakin <alobakin@pm.me>

The module misses MODULE_DEVICE_TABLE() for both SPI and OF ID tables
and thus never autoloads on ID matches.
Add the missing declarations.
Present since day-0 of spinand framework introduction.

This is a port of linux commit
25fefc88c71f ("mtd: spinand: core: add missing MODULE_DEVICE_TABLE()")

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20210323173714.317884-1-alobakin@pm.me
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.51.0

