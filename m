Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF1C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7406A8414B;
	Tue,  5 Aug 2025 10:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4shxQ1dH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A63F84198; Tue,  5 Aug 2025 10:15:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AEC9841B6
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeDU9iMwCiXLaA5cmG3ShJ4vxeK/ItCUIz3KxraYMZG7Cv3O/883DHzQvSkfc8wIBZvWUt3FIN9XAGU+MU73dG9ebUV4Rbt3RAukzG9R/ndAY45tFGQvpEi9IqJHLwhZbBmN1W5d484G2hY8jlIxR0k4sHpjXYjSsjsfieOq2HK59m5V3yv5ap0Eo8/hd8n3u3YuOjNEoZGlNMrjhXlEf49LPWHk18xgQTFDxM7lcQX5AIJMRpY76C7orxXESjEvoM1LIusT8swMCVkaW1Nv4ToPEj/jb6BK7ia5zKnWk1Q4HBrzU00FEIUVuqaYfqwP1fecV7/B/QpzKSndz3Qz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdWU62a6x+zzcG6IZXhQlU5s0fTm0z24RCBXc9Tw3wI=;
 b=LBN+DoAbcXLv8xaauLCNiatWyOJa2kKgClXN/swxUZWu2XfemRkJLR/w5jA+XSWigEvFto40mvNe8Jlye3lQeQNzvPkw8q2LqbIvBAVo3Sw1h7dC8wIWSLYfgCnycHiKJ+vrN81V1gJpa06hkPcfiIVbyVIo4mw2ugA0mdGKJmJSSvVZN/tarro5ImoxrfsTPmnMgpcSmZvUsiuqxsbx76RVrf1zZ0fCKfaY9wgN4l5TWliBECLHOrDRERp2YOIiiDfVnk8UUhxMrpCyAw1JezSASo28IQ2Aoa6wxpLXr4At5GpGbJBdSLxDc1b+aggUQ1XCJU2xuMctElVGPU5r1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdWU62a6x+zzcG6IZXhQlU5s0fTm0z24RCBXc9Tw3wI=;
 b=4shxQ1dH2Xg2eGQaHjyvXscycLNhYUgn3LLNd+BHdxppFQt3MV5nIGUNayVK2ODVKjFSRWGGM+j0gBvCGtbbZag+zCFwlEmubStEbST08Ne1trBHSk8VTCaMpqWdQjXjdNQkzfAceB2gwjhilJ1IrQkZoYZ5FeziMNPj47N9egRp1BVJOBSf5RPBMNnN+AYHNwvlQAiWfNfwbdpmosKjzc4q8dbTI8gZcEZr7VShFOa+ZZIHHV8N6ZitavdzeDUpOC3oleuriny9hx0h4loMYoDYefigLpTn+PfRqWkmhaOxndi3HtV/dopgxGuvbVPDojtjsZ7DwqSK34vnu95Ong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11069.eurprd08.prod.outlook.com (2603:10a6:d10:139::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 20/22] mtd: spinand: fix direct mapping creation sizes.
Date: Tue,  5 Aug 2025 11:15:09 +0300
Message-ID: <20250805081511.1482964-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3b79ef-f9f6-4a84-3476-08ddd3f846ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCUQ2xcd1y842lG5PEwIrRJqHRBGEE6kiA3xspgylxPBV1mDd1dKXjFX8l1t?=
 =?us-ascii?Q?2bTusbSUZEDygg/vcXlQ7Shc0n7SsAFX6P+GtAV6zkLl1aQ0A9ee8e8lSi3B?=
 =?us-ascii?Q?FUpLHmUuO/DDsyn6oxetc2EDEUAqHfMaVvwA7dgrfMLZpoc95P9S81+GXeuD?=
 =?us-ascii?Q?x85jCX0F6CYOEEBrDdn78OyZEWlwIA4+WZN1U79BmkldawuWtQYO/Q9Or4XI?=
 =?us-ascii?Q?SplO7+YSx1B0WxLv5vdHMEDEhH1KUmf2i+69J0aLKae3/mGUD2//Kq+EwHml?=
 =?us-ascii?Q?t6P9fEdTRx8I99ZLhAvjcV7L7Qq4o+rBUWp3IDTVrDoBYaacmqjSZ0KBOkUT?=
 =?us-ascii?Q?G+ZxUHPXU/6vFkUbZf9FfMZZvTDZAvG7k/qPeK2IQdEq4ukdc9fAvdovZji9?=
 =?us-ascii?Q?weNgSUFsCM9WknH9eyPun22AfgVgVz4JlEtuv8Kp+2qNHD6ru6YxGOymDx0Y?=
 =?us-ascii?Q?v0tAEgXv7YZVfYG0XJoT4mDWmOUYWKjjKVbtGzQok2EybeDH8bms0xe+7FQd?=
 =?us-ascii?Q?yilFMZ84BKUPzI3Zf5qz0PFtLYXy3WZAlQgspKWARTuggzbD8v7oWjaRKdVz?=
 =?us-ascii?Q?D4ixbyRX2CIZG0NjSKmzq1UMaTNGhyFsAs2iFGBZ+V3r12hxZH3uthrIEadY?=
 =?us-ascii?Q?j90V1+fcR8sfNksno/xZFtMwXSbXsZBgZuqdXlNq9mAXvgKjkRN5vzj5KnYs?=
 =?us-ascii?Q?a6h1QEOzv+4R9tUhJlHQ5w+gBLEPxPjzVYga58OQ0yYt/gYpB4pvf7dDosWj?=
 =?us-ascii?Q?3MPUb8DO+X05q0sKeMfm9neY+ZdC6p+6nBds7sSSnDl6CF1wnCDy6Pmv5Vyl?=
 =?us-ascii?Q?QNWWX3cXXS7rK+JJpyCb50xcuG/ghUEDxHcamMxwh010HNMwYF0bXGGpo0qX?=
 =?us-ascii?Q?fEwxG+M979V+PJ1GBqfPXGidGnD+YeAJOoEYkYoDioXAfB5Idp9Flnj94ftM?=
 =?us-ascii?Q?eLmCiy8NnBLyHWlR6tyGaekm+pudNhoyaxB2BOAhcR48YZ33qXJl4U+XNPfz?=
 =?us-ascii?Q?lVU89+ouNUrQwDWuFLNDepg2Y3ste7WR6U43yd5sh/UsT8Uon43Ia6nB2jaj?=
 =?us-ascii?Q?dzm9A2WgZfrnkJvzXh23226EyG9ynmP1hRi7KJbT1YGUeeZOuTmbyBin6noO?=
 =?us-ascii?Q?lwBZtbm67Mdogq6z4tPUWk3MSLeqzK0KgOk1YHsBuPBJbSFy/WR/gES4LN6k?=
 =?us-ascii?Q?96MQLSTb92EGT6X8xY0jrodMdwr7Uw3U+7fS+Ybiy2K/XX68F+1TZ3oTGFYZ?=
 =?us-ascii?Q?NnxWIbtHqEvlN5IEuZ2Fk1NQq0XkyqBgIy+ezqJkNgjodgXsP/J6hlTYYAUr?=
 =?us-ascii?Q?oq/7W5ivsqYpd7noQiFnUbWybVf/UtI73rOer4OwRUnmh/rQjbJMqsfQhIzG?=
 =?us-ascii?Q?MycwL73+1b2guhlQH7SSvY93m9KXF+0+8qFv/b08wdunWAgpbAFxoO0Oofnp?=
 =?us-ascii?Q?Yt6P+AhuPnJX8dF1IImC4lbBybtbRXupvG6ej2PFb8QqL3j52NUiQ1OlH3tA?=
 =?us-ascii?Q?hGVlOgpt9PirV7U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVLt+r5/B66yjUTnp+iH9rGM9FySL/JuMY9xIonIQIP1nxj7H1cqcLeN96pX?=
 =?us-ascii?Q?IzhNHIRCFiifOg8y81yg2Anba6MkozhGAxgAUi+yNTFVSW2gZe9SsywxGkHO?=
 =?us-ascii?Q?N3GqCKtncBjpfWGzaLXPlsXOZIq+btyTC0TzcEldXnAIe9EjEXFAKprOSEDj?=
 =?us-ascii?Q?QASk9C6omE5L+KhN28Sgvex3GR7zUPew6Sdlir8bf6P/NE829tNXntMB9wjW?=
 =?us-ascii?Q?HbEfnpXxUVEts4lUdGdAjKAvsBoUWbg1ogu+yBtPENMDMQMt+Slxk3zurk4s?=
 =?us-ascii?Q?Jy43s3YKAbvPwhsdV0vKQlvCOlzzEWUB3eCueSR7ZNj5HJ9+/FBOPvHQyWcy?=
 =?us-ascii?Q?MGEAU7IZzwJCF5DonvZT07SzLHq48fkP6nCsQS51h7f/0pSMczbUjhNQCgwY?=
 =?us-ascii?Q?7GPEQZvPVe26rI0eNOLUZUa2mkn2XNWCwF/58zAlBC9/cx2Z62W3612OQ3b4?=
 =?us-ascii?Q?OmJLW0TLnFTVmwtp96LjuTzQ05dMo8t3CWV6BlUiTXOe3W0XMQbX0ZwEc5q3?=
 =?us-ascii?Q?FatVSjE1Qa1CkKPDWhD6dDQ4llgA20Jci9VrpLVZ+NJ7X2lN8V5DF/ok8U0f?=
 =?us-ascii?Q?BsBkR6mK3sANJ8pBvLO4AsGHfiIbaGWZeVT++URcK4jUIPUFuvogw+noaxoV?=
 =?us-ascii?Q?Qvkpw7PWwsl5RNPHti2Qg5LoAH9VeuWEV9ltvRFYYobrV/3ynmDzZhIWZSjV?=
 =?us-ascii?Q?ckkr6VH4KVjL/dfrgiHbKIuUYBL6BVpoTg/yCEKSKQJTuvGo9v6Sdhp8fKLS?=
 =?us-ascii?Q?EiGgP89fjME0mMKMVyd/YXYBOpNFKRTLPKA2fZ2bjPjf5gXbTv+DvZO2qop+?=
 =?us-ascii?Q?IaJwFlMmK4Owjetbod/seddsO8az/uqkn01jDo7E4Wg9kap2hcD04H4GDxdD?=
 =?us-ascii?Q?bK6j8Nc9tzC6XJ1RrFvepDx9FKYy9UQyq+0lfh8Zc+jre8Vt4RLW5q7zqLJK?=
 =?us-ascii?Q?NiHuOT1HldvcPYgXtbqZnYfyJ+UWwKkJN7iXz/EIidBWmxsgIwEUkpRgI4sX?=
 =?us-ascii?Q?DgnFLTq2JAE3JJ0dcZP/nBw+shOJxbKv9GsYC5rfYQcNHSZLPWYGVk4Yp/xD?=
 =?us-ascii?Q?TXhVp/hEFRG6d3zpsI6J1qN6asi+W8pLtNOHx18hhJ16I4Z+lIDDkqhdpLtP?=
 =?us-ascii?Q?1dOqrdK4sm7j95YLUtYHotQDzXu3RDbnsu+rv0NhxkSJWSRo8qm26UiYbdXy?=
 =?us-ascii?Q?NQqDF+lIR1xndYfJJVHIvQtSIrmKuz9UeqWoWZ3chsYQ+FA/ynckb7lFoNLz?=
 =?us-ascii?Q?L5moCJBwRZRkzOcKJCMg7pGixjwItkVRTGog2sEERcdFq5fUFRtdzBgtw4Xp?=
 =?us-ascii?Q?EiNlOLa1s2JQUcTc48WWxquwYiHd3jmMU7bJI7XJgHZcE34BC9CM7Rwr1+Rt?=
 =?us-ascii?Q?5QI/XqhRFdL34ol9TwnCVLge30gg6buktuPlkMwpgMFH9j2Agr/YQkke4kUI?=
 =?us-ascii?Q?iA2OadA+i9gM9SsXbpJ4pZJjBqoU9YGn/6PCDuqUylAKWhNjBmKex/HABUuT?=
 =?us-ascii?Q?wXwOH8NNFFaSrD8t9zxnbpTIpfgQ/adXLxFtSAPYWar9DWq6ZCVosZkv4Qat?=
 =?us-ascii?Q?CtXknaaYehri+ms4+vFHWYpNOcWkra+XwevCT02ns9IxpinumC2GOXvIGZlb?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b79ef-f9f6-4a84-3476-08ddd3f846ee
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:45.3708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ6y8ZpgJUN+4hxFOhj8bHhiRYgK/7DRg63Nia3vgeEcltFyxGeH3u4t6NhF5ZADAla3GpRRjfygNxqJUdiInOhkCEcuXQWYYZq9XhkpxaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11069
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

Continuous mode is only supported for non-raw data reads, thus raw I/O
or non-raw writing requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a76878abab1..07ea66825d5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1121,9 +1121,6 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1134,6 +1131,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc)) {
-- 
2.47.2

