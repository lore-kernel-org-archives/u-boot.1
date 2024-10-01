Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D6DCE7D12
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1B4688F77;
	Tue,  1 Oct 2024 14:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="naGYHkTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD69891A1; Tue,  1 Oct 2024 14:04:31 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 071DD88F77
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMo4e9HJDiRnbKFOKzeHAT7QvxxdugGeTyPJuFg7k/curFd4bjGkg35cdmFSJWbCtfc9SBp/U5PF+kKfZV6DbYHX1NmbtsvfBR0Jq1a1n6SQF1AH4hyDhqnlRHjzTgQ57H9Wv0xTGQeEiBBqCYzgUAMKXr9f5X1bLwfvu41AcVz+C6TG699O6v/HKYNvcSGPEw0P6wOCwScY0Yk2/zeli6u7MEakEId8466/rwWb23Aa8OJ//hXJ0rIyLt5WVl+6fK8btufqG99E2YEP7E87VeIIvYe7k26c7lVLN743K0c/S02GTtJr3zTBY0LKH3pyneMGj/uGFYunzZP7CxzC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55TopdWFwRrnpABVxKWiSgPJgpnlFolv0D13ebVghtE=;
 b=hOBaCZOHFYB1KdTSXKQYYeG3R6GatGLHCWFs3mqIe2DtEOHe+WrN1lMIMzQuZQU01iX3qQcNcPWPwy4J5M5xCzg4BqeVb7zIevxT1RRZi4udcJcgMk+0IzDtsVgBdNRhX7FbgXXaZqQtjuQPzH7BlpQo7YTgjNNlShKUF5jS4bLa0bOGJuSCymnkunEwH9wAo9Xq3047jYcmhdmWb9wF9QOIQ0kdgu3YaYVQNNvQxjdNwIabuIk6e/c2NG6769GDopeXneffwA0X7PEdtifKHacFUlu6nyj7f+7b7XbF8ZaDdb+dsNseO7SgdpoXhKSf+x3+MoIJPromxDwjIYMSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55TopdWFwRrnpABVxKWiSgPJgpnlFolv0D13ebVghtE=;
 b=naGYHkTYItvSYqILHSPoAorzFb/hloHU3V3wkClmrMgmZjtw5rVXFybUPNOzQLaeia+0zsiPGx9N67zAi3UJDXdNyq/M38HnWo9fWZ0JC2vIPL9nU1vCd0oEEyCC1PMNohpNZEr1Z9XIcAC/C2SKpxGi+7IxcNEXExskHCCeKUZUklhOPcxKvUDmL4ylvZZL8qu8cyXeSnt/ZNTabW9lgqESsYXn1WHXhkoxDRt14J0PQ1GF/o3qfbe+D9CqCcIevliBob0fyJm/T1qDwelq4PDvd7gQ5vL7pehE+BlVYjYKq5rC0qlI1tVeHd89rHE2WdoBZ/v7ZoXRwIXsh+GNXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 1 Oct
 2024 12:04:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 1 Oct 2024
 12:04:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com
Subject: [PATCH V2 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk
 API
Date: Tue,  1 Oct 2024 21:07:53 +0800
Message-Id: <20241001130758.9810-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4390aed1-763d-4a02-cda9-08dce2113087
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0oTZqJ1YU7HpCmoK4WAkWE2VT2WoaimI0jkC15UUigy69ODXSF/euUj+cm6M?=
 =?us-ascii?Q?tZJ6JC+OY/L66AzHWvasBcgjMptw/U8gwAOj+N2iin3JGMghSIUnJlCPX/ew?=
 =?us-ascii?Q?9hF8SNLDyH16YYqCX9y/x20K63yQiHxKxuBd/MOH6+tWs/mgm5nMTqPJMoIt?=
 =?us-ascii?Q?KyPFlAxiyKTFOUR3cRQ1kxPt2YrW89+t089nGYBDWxdQPHvS5nnia8MHQ8Fm?=
 =?us-ascii?Q?WNVwibmDw007TgLTUPOFYdevDgVchfWwyzp0Dre7kMT3IEoitx1ZJjJMycRW?=
 =?us-ascii?Q?cCwPiB0aWg3KSyWl/aXfpb1RWkQk5zi5j7AB5HnBHImeY0ONqElRgiwk/qJl?=
 =?us-ascii?Q?xUC4jMCQdei6pDVuMv5zC3kKTG9Qd5gbIytocfPibCvf3EFyyGhDOTYIjZTK?=
 =?us-ascii?Q?doJhuwPTLabHc5ar9nI1P0uuLFm6AwxYdi3FC4R/rsk+51H3n4kdWCin98aM?=
 =?us-ascii?Q?atKXW/RrpKeDcwUvwY5xL2x4W+Tu1uWMy+xvltORwZ1O6m4jI9qHhhJz3G+w?=
 =?us-ascii?Q?C0mue6/ZvTj1uQ+vL3Dlo69h6EAYlyfE9aEvejxtrAknfRV1mvVzmyzmI315?=
 =?us-ascii?Q?lBIRlMlI70qfyR1zOxI3ht9nxzdgmRi1ksh9ukaJ+fHxuVoH4fhpJKHW8CFl?=
 =?us-ascii?Q?dHnxLscwW/L6fkbtbjIW7UNqJKPUm0etgKFt912CwtPMdVoGBIFgpZtBNeyG?=
 =?us-ascii?Q?7u/UZWtBb/dFwz2CtnQder9K2zAvyKdmHKLo+4gjKZWn8ynrVtiDmGVrZSGr?=
 =?us-ascii?Q?TRz2REhXVczP5cljV/6SsrbazRnlmyQeCpAyJRp47BUy7jcmYU5jJ0sVa49L?=
 =?us-ascii?Q?M4iHrTJ5P5oUivqegFqmGCcCOgXgID/xbYm1P6ECndeqLP52WwYkGTbUDNNx?=
 =?us-ascii?Q?8HFofBghL/o3g95zXSmbGbLMiL1r7rm8cGfUcu0x/h6lLN7MmJ7D8lwSLbfG?=
 =?us-ascii?Q?po471e7Cir6VqspL7DynEHDWxDBboPfhyIgT+5PPy0JGKfFDge8/DnDNP3iS?=
 =?us-ascii?Q?ItPr4/PifcIQhpcXAUnoHRp74cfDtHWuPtO6rG7NMah0ikpSQP5TE9Y+8usp?=
 =?us-ascii?Q?P1MnEC19bIXSfaNTLQyMmzBS5d9NKN2R5Yc6r9OOGVZm1WXYdRpIhz0w9h32?=
 =?us-ascii?Q?dtFbkeDt4+d0VgtyXhW8cz/afq1yAQdycQpZJAe/XGfLRE5QQTCJ4X7mNM6X?=
 =?us-ascii?Q?+4Gv2liqt6smeQQTbDwKqRPxikx2MAzp/DXkBl993Ryh4bajTKGLmoElAtCI?=
 =?us-ascii?Q?eZYt6uPAIIdmli65pKXJCrdP1nQwXWKKJvaf6W6RaPNDUgZPi1wcqNB4ET0h?=
 =?us-ascii?Q?XOLljGOZBMgGILM5qlhq6pDAjw/HACYM34r9IpqVgRw50w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQQzPnZ6sLABoeG0Lgga4kGf4t9FCOAUIGr0V8K09G1fEpmKlxpnkALQgi60?=
 =?us-ascii?Q?t3GRp7BN4n5xcCOFTUb6InAPbpFB1fXXUYFbTUYGnOs4M82a/w/6ya8hTQx3?=
 =?us-ascii?Q?b2E/vJqpvt4Qq8/A+jtB6AuNozlDHslxZLk0TqwP68qHsE+LOAR8f9AkfEsF?=
 =?us-ascii?Q?xHDJ9QoAA1KLKdkr5VQZIGutD52+OkxwMSiJMCZO44XLhx7VpCSsuUI034Rd?=
 =?us-ascii?Q?bRYnkw4h+hkh93Y6UUrsm22Kp9OvA0QfKFlBfjkuJX+wZ9aeEpjCny6p1iQq?=
 =?us-ascii?Q?tCzyoYL3GrVPpc32qmiI5pVI7PYhp+j6QS6OnYllD0kJEKy9mjuYw0TL34kz?=
 =?us-ascii?Q?NEjFM89iPOBcbDyHMYgRFQNGKbgcNDu4w9NTFdhFG5tsCyCRMDvcIK92EM4U?=
 =?us-ascii?Q?7hhySkcfbVQAhrZntWZ0keK8VzZArzoFWTkBsamh73tOLR+NW2VQpnjNU+0M?=
 =?us-ascii?Q?mjq6wUXN8bdvYLaXp84qVKj5aZJZQfNNAblmhnA1O8u41YEpzo2b5iaZx4Io?=
 =?us-ascii?Q?sfaB1N7BonJFp+MzjBhDytTj3ZBHZzG2M0Bte3C2tnf6DyPg9gAdhcUdZJ0Z?=
 =?us-ascii?Q?6aPVxUeDwok+XKYZuH0iuHbuOGSgwwUslqJy8Zv2SpgxVLJ4xM6KjEx/Qmfw?=
 =?us-ascii?Q?Z51HUBkpKomc2zXLq61R7J6GfX3aiCaceHajEl06RTZjIrJfR+URyzNm+eie?=
 =?us-ascii?Q?Ds8dPQ6pHtVQr8NCOLUCjaQJmmYanIwxfsfnbNCU9R2OcxLAZNAkNbWOjlT6?=
 =?us-ascii?Q?JWu7tyotGRCA8BLRQ5e7AO7UYsi2VocvRUSulwA4D41MyRBxOi+OlHgfB0Gl?=
 =?us-ascii?Q?5862ZbjQ17Jzi+LJTz8+XecCZw2KFGQmN2/N4xlkbjzHuHedfPCYjuD3goL8?=
 =?us-ascii?Q?lDsHX02ESWvZO1PmwqD62mAnb3GMAhM9utMgY0KhZQDjYSwUI5ghuq5RrHOH?=
 =?us-ascii?Q?z3GFko2Tq3vWmF8fh8MOlruIaIqt1b+x+iUzHsI2BIYYCBy7OS739u75D3Lk?=
 =?us-ascii?Q?AzNJUPEF/hS5DIMFpdfMC/3PmrwrXXGmL9UG2QsF8vhuQM/1CmaQLs3zvt+O?=
 =?us-ascii?Q?SHiQzBRHxz6NR4mvRDHHyS1d7AYkrFrU0jwoCZCjVUq+5MSXLXuFT1V3ylXz?=
 =?us-ascii?Q?Joan53VJ02sFGbN9eAHClt7+zxicIYOUyWi/Rju8iKYOUMK8gj0mPQVrSjYD?=
 =?us-ascii?Q?ODqZx3Gtjw9f0G5uN3bi5346zodBCyt3Vn1nGqzGe3ENOlOXPvb6bNukGoM3?=
 =?us-ascii?Q?kXUHM4E+FPfhdcN2f8WwMB+AiUUExyn9BUKz3msZuvrvFItdZ73K7aeV7BFE?=
 =?us-ascii?Q?XzRDhdHnDIoumSAFbJC3bDF2qLgOMRqiDPOT5GDZqyZ3Nia+Mf3nAsKq1HJP?=
 =?us-ascii?Q?QMCUbhQr0zIF8PujSk4rvFyLZf91iSRp6mxRyAh4OxnC21q7eM2jaw0txSBY?=
 =?us-ascii?Q?owxcZiUWgB2gaG+62bxp3c16LFTW3L2V40qHz8rlH6nDA9f0jojs/oepcM8w?=
 =?us-ascii?Q?AeBt7VMsiO3F6Tftg2DOaYMDm8TiwT/pTvUJKkJr+lE2C5x0IjPDLngfl9dN?=
 =?us-ascii?Q?DUgWKiJ5m4MCNBmeDYqC4uLqd2k45XE63TpGbvnh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4390aed1-763d-4a02-cda9-08dce2113087
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:04:23.9723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVAA3f0XJf/SnZKN93MmtyyUZyfEhrnqytT/lJMTufD5ccaCp15N6u33vmUh7i+zeWEEOi4pBwv+QJiOqaxU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
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

From: Peng Fan <peng.fan@nxp.com>

With partition reset supported for i.MX8QM/QXP/95 and etc, when linux
mmc runtime suspended, the mmc clks are gated off. While at same time
system controller reset Cortex-A cores because of various reasons(
WDOG timeout and etc), with SPL run again, only enable PER clk is not
enough, also need to enable AHB/IPG clk, here use clk bulk API to enable
all the clocks.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log and use clk bulk API per Fabio.

 drivers/mmc/fsl_esdhc_imx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index 03de7dcd505..0ced796ff49 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -148,6 +148,7 @@ struct fsl_esdhc_priv {
 	struct fsl_esdhc *esdhc_regs;
 	unsigned int sdhc_clk;
 	struct clk per_clk;
+	struct clk_bulk clk_bulk;
 	unsigned int clock;
 	unsigned int mode;
 #if !CONFIG_IS_ENABLED(DM_MMC)
@@ -1521,14 +1522,21 @@ static int fsl_esdhc_probe(struct udevice *dev)
 
 #if CONFIG_IS_ENABLED(CLK)
 	/* Assigned clock already set clock */
-	ret = clk_get_by_name(dev, "per", &priv->per_clk);
+	ret = clk_get_bulk(dev, &priv->clk_bulk);
 	if (ret) {
-		printf("Failed to get per_clk\n");
+		dev_err(dev, "Failed to get clks: %d\n", ret);
 		return ret;
 	}
-	ret = clk_enable(&priv->per_clk);
+
+	ret = clk_enable_bulk(&priv->clk_bulk);
 	if (ret) {
-		printf("Failed to enable per_clk\n");
+		dev_err(dev, "Failed to enable clks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "per", &priv->per_clk);
+	if (ret) {
+		printf("Failed to get per_clk\n");
 		return ret;
 	}
 
-- 
2.35.3

