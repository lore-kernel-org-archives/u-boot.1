Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD045C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13972889D3;
	Wed, 14 Aug 2024 12:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="U3kA3vHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C62888CC; Wed, 14 Aug 2024 12:19:44 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AC3889BE
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfb4DEeh4gY1sG00OSgb7whDRfL5E+eVEosgp8d0/J/d4YM4dUncQcbzH2hlfAtwQxNmeOd0aPW8KMblyfwiADiWMF+DJVS0dKgW/vo+AuA4/vGU6Vpq7bTCrV0cHlJ4eBXPloqUkIfzy6fIS5S3gUY+L3NiJjn8yV9Zx92jC+UlFrdfJS/DB+ra4e7Da8ZM+VVfRUx9mM9FMpWPVg0w6wnp09vh0hTK/Fuz+JsrWBmyoMtOcVxrZVGeAnla9ZdQc+YEFGMbbQsOEHdt2Yvfst3LCJ7ZuuOEZoHcqCcKk8sWq3mIap8cPIHTgWfs+RRjuinHMyRe7Wy8o5lO1ALS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/3PaClzXbfdcOYlb/Qp4Seo9yt00/GuDEkMiZwmR20=;
 b=FpHKeLxTK1xJ6JoBG+9z9DPqSOurXeT/5DzVNYdZv+GcKdqwx+Ufhe/t/8dztaII6XMp8EPxKiAyYJMy67n4lxKOdtjEGk2y7qCraqtFqXvwFPhZVaCy4o5YfwMjTUN0SkbE75up4HFDqwrCcAEYMP0OmjiS1eDaImXmSLA1pyd+uI/eGUtzyOYwNYlmU4ZI8D4NIBw2Jqej2cq/SMil//En70kiSqpIZP0M+X3hst13foOEKwQMNQVK7ckoALfUwO/innv1+rzwK3gF7Lj2L9biOK7EhOQLVV/yPN78j7ALavxeE9SjfLCzF7vMOglFdKZyvZUxqlS2ZvCpo5Dxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/3PaClzXbfdcOYlb/Qp4Seo9yt00/GuDEkMiZwmR20=;
 b=U3kA3vHUyYncCFshmTxEMTg8mHz3KvCSLtX8msyl0h4KXcfyZVAXiSgXmoiznyZNKtQm6qX4wCBZ9LMzdpt2z/Z5NJPkK1MzyTXUHw0rtZ8krNPBIA3yP3nKawdz39iHdag8nXvjpwS9joftbFbHNF4TeSHZrnTO/VWJwG0NeCBG52E23LQ6PglLgMrc7UjwEzltt4MLR84KnrvZMWRgjnXLiJ3OZzcwPreNY0JWvUy1gChK+EK6kFjXeb08qaUxUs6wZsPBX4LL7qAfd5+97Ehd5KYmFLA8wtZzjBjU/IX4p5Jn36HHxa5FHo226JJeRXwYH3bI1mU3rHuphSCclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 03/10] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Wed, 14 Aug 2024 14:19:11 +0400
Message-Id: <20240814101918.1347167-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3408f5-e747-4d01-8cc8-08dcbc4a9b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lfsWOQEXOp2A4OSFeXSWEPADUy5Nof18jFGzUCcEKUeD1NYlo4+zsMKmv0Qt?=
 =?us-ascii?Q?IDeua3xKGDxx5yTXihcc2Bg2fCH7CqYDwkfzyiDQYSzkI5Q3PAMj6qoUhd7K?=
 =?us-ascii?Q?KC7RxKZyUzzyri4URFSCofXd1Vu6aLQXLzSHVo9AhmqMadF2T9ES45xbQwX/?=
 =?us-ascii?Q?uBPni96hIkWCBw4uaVvApXrYj6bntpqMG1Rc0RlQQslmY2bGsvQwBSm754/X?=
 =?us-ascii?Q?oqD4odyC3I5CSUUhQfr6CZiYZ4HrvNlQQAv7Aykk7eo4SsfNBisJib81io52?=
 =?us-ascii?Q?u/Ec7rSC+MumDQuvmO9aeoWHQ10D7clVmrKOFf1mC7EYyR5/GyqcoawcRyQz?=
 =?us-ascii?Q?xWs1T9Cdrzj0ETd17YLaSWgCX0b5+Sn+mtckjAg21csfQuenh7VKLNq87ndn?=
 =?us-ascii?Q?PrXoy6626K3WMlDDq1kvhWYoPvxSqfd9Don3tl8X9IjeErynLsledat3fIwJ?=
 =?us-ascii?Q?XNAORPOHKKbpqW5ZeKQhMUMqHJODK9KbtKyraTNM9WXSqLrqJMNvB9oUPUvV?=
 =?us-ascii?Q?jISudfw2Ah/ms/FZV/APuyAgQEOBS8jDSTepOeu8Q2B6cglRzGZZTlY9dp4u?=
 =?us-ascii?Q?G4GmxzLgQ5H1xKT/xcrTz1wxZ2FruSda7POwZHdKc3FwUWiV04YDQE1wuNnE?=
 =?us-ascii?Q?ffV3tvRewPQO3bt1LZmCm3hCGG1ci7B70prLuMZb/q9j0FZ38JM7ZjhemxzR?=
 =?us-ascii?Q?tEv6FfZeIB6unE1L+YdXp0WUak6rV3X18SG0qb7OClBK6H0X/vts+T1n68w0?=
 =?us-ascii?Q?81ML76o3bZoPrijjjP73dxgYfYs8PjHyw9/OaKn/O+53/wGBYEAwijCOV0y2?=
 =?us-ascii?Q?pUwhnJQSMCw4KAnDEsLXnJUpbUy0xzHK631+jt+rJG4LF1ce/AmQh9PNQ4R2?=
 =?us-ascii?Q?iI/2pANHvSPu6GqHwu4vZfsp0HpFWCyanFnrUtDome/DlNuhPRLHLrF4py5n?=
 =?us-ascii?Q?B2/sQTJXSpG9VJMPckd23BvGjb0M7drM1K0CIMhQaBDRr35oZLxLJqYQ5Ou8?=
 =?us-ascii?Q?U3FF1WyMapOpm0XenQP+xivWex/s856ir+mxwOprQUjJ0H9syB+3hWQy/mdh?=
 =?us-ascii?Q?0AGx/b3yxSmF9h6DbeRIf0AmEmSS/AJFQw9VByrL4wT1B7bQmUdFw6/hLLOK?=
 =?us-ascii?Q?AsSf4mwpaZ4J+fdtFPVLkH5qVafH1Go2oGL69idsT0Qz7MxVXk4FT+0uyzbE?=
 =?us-ascii?Q?uS4hqcdOLASqJyTN1KnY1Dj/aUYU9oWfcIBrIzAmFYmAM2LAkNowCBxXxQcr?=
 =?us-ascii?Q?WUwfd/NcO7J5ylwNLuiALLQG+qv4too+STHkB/UBYKCXW1BcCMg+Qg0vcAPL?=
 =?us-ascii?Q?EphfSesD+lHIdSW2dpxrjZ9QHf14f04XHJTe7cqQioOd4SRJk+WgsIiNU9pO?=
 =?us-ascii?Q?tZz98LCzfEx8iAOLoZV7Yeqf27kISMkevcRikXEg36dOpLbTeOED4agrLC5V?=
 =?us-ascii?Q?/gxRPnmhstE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3qQv30ZuPnyDf13Nd4C0j32nKe2baA6x9uQMhLx9Xi460vasxu1hRZHRUMX?=
 =?us-ascii?Q?1oKWlt33IFKMzhRhdftiW2TQzXAUFj7oUFCZWG/eHbSOgujQoD1+J1frNKig?=
 =?us-ascii?Q?MxbTGGwH3XR5U3bI2E1JQDn/4WCycxgEylg/s/vQdYUDevE7jqRtn2O6RJrs?=
 =?us-ascii?Q?TU879VxzByHB80ma+ebmB0tB5JmmtIJN/0RE5k6JeHtOQudKr6Qpji+gsxD2?=
 =?us-ascii?Q?5ADvOm/5AsJHvMDlwSVH7xNEjhUS020DDUf807Ku0dvm88OYmdCKjXavY4Ri?=
 =?us-ascii?Q?UuhTdDt0E7H0m76C1eyd0IL0U93pocKCdw6xo2zv9bsgMQqV5tR0u27K4pG9?=
 =?us-ascii?Q?MffKKLJw2n8uxs2G/f6Y3R5ls1Xp918H87UROkGwbkWzsY0xNm1koC0ERTfI?=
 =?us-ascii?Q?Q/pV9nkOby6RNj5VGDMhy9e43jwblkZQLWLQ8Oqqt8mBziaJSEhQnGWSZS2P?=
 =?us-ascii?Q?j6rO3LtkS9LeL6BYWe7hOR49zohC/m4Aut6kMRJ/nbh881IXtgwODqzikufi?=
 =?us-ascii?Q?N8rNoPQlXMQqX6+V4+jEqFLvwSrMXPCmOBHzh4JurLzjjxXzzgHOEMZq7Z4d?=
 =?us-ascii?Q?Pk7RJ0CbJEYhUgLYwmEKJE/gfRlvB8dod5favaWoKLyu6QnX/bvVKuQulvlP?=
 =?us-ascii?Q?WOks1aC4Dwg/7I0JhZq/SbafZMCP5zvuuDPYRBZLQ5qfVG5XydnrebLXm+LH?=
 =?us-ascii?Q?DgQosROhjp8cVyqGdxxfRb+Dn36ON6NRG6XmGfWw9HRBxWjoHHLLJv+ECFB7?=
 =?us-ascii?Q?w2SRCdsyDPRMEv6Ac62hNhWYDEh6v020FOXlFj3Z51Mrw2usiZcLmpjRQb5Q?=
 =?us-ascii?Q?OSziBdCqB2p/hvP8nwoBZMQUPM8gqIz2bLMsipwtD7mcCHkD9QKiTSTvU1LM?=
 =?us-ascii?Q?hmmD8aLOno3eOM7m/ikJPidqYMbHJtsjWKdLEfz6wJjLfQnxxYbtgyEK0SVo?=
 =?us-ascii?Q?bcMCfxO3l9uBBx5CeagocCEVWrNAa0XAwj00mWSgNqobfNYfh+NND1t8f9L+?=
 =?us-ascii?Q?UjQw2vaUmo1K7aFSNjsvyW70ZEfgVsvlGq2gkh+PvYIiVf0SVIrEKjQRlwFc?=
 =?us-ascii?Q?n1wd3KFeQP4KGuP2dmLBa9prkWqpb9hjKTykAgWxK9J+IMsK7uzut5yGQnb1?=
 =?us-ascii?Q?0btZL7Ph6Y7k1f1ADNCqun6tJP6BYeBs14ue2DOicsyFgq8WI5B1tRAtBRHZ?=
 =?us-ascii?Q?fVHS7TBywDV2iQKessYj1wIQGKjkdWhfOz4YVtLPy6kK272y7hHjpsxotJd2?=
 =?us-ascii?Q?jryA7c90V0ghNsKt1QlnO1vLBr8vhoe3oL7ZW2boP4GdcGlPI+2bUei6oWZy?=
 =?us-ascii?Q?HucOTzjMQN5eWl0MW273W540XNUQRWvfVNFczMBAbpvjd6Bhwzyxul0FISvH?=
 =?us-ascii?Q?UBvBLi1jyzCaGDXsNGZCYrU5gwYRs4Pol4Nje6dpPqOeCfHtyazj+st4ItxU?=
 =?us-ascii?Q?qmfTGdjBpIFbJeBN3E3txSBtjmsqLPK4d0ENcUfm4TdzIGrJAulpDK6hlbtj?=
 =?us-ascii?Q?eF11N9O5NvRr0cNBykeC4weZPM+cmUu7OoFrBKErjHTkpXxLq46I7l2x6N66?=
 =?us-ascii?Q?+pC+x8sIQ9C4SMFvgpkHDVbBarxcYgIkElMjLpZSej9FceHZZ9jqvX0D/FXa?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3408f5-e747-4d01-8cc8-08dcbc4a9b75
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:40.4269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IIgwLngYQu+CR5SFXo6ldnQDwANd+zXHD5rkjALM6DVSIQGKBmMdVUGGuMZ+PIpmN0y+ivdjlnFR966hDHFbLLgXHUEM/MyGL+boYT0qjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8f227ce81fa..62779dd3e51 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1267,12 +1267,14 @@ static const struct spi_device_id spinand_ids[] = {
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
2.39.2

