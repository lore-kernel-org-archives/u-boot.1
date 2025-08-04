Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2099C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F097284065;
	Tue,  5 Aug 2025 00:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3dEBzQDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B2C8403E; Tue,  5 Aug 2025 00:11:46 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14D184006
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7MMrg8DcN92CI0vnAIbo4lDGpCMvQnWmeWNuosYyYID9uD4vpy6svQzLR0uMnSv8o+jLNmRZ9VQ50XnbvnDElV6FoYenYlqGwK+de8lrAb7hd9EO93hIN8k39b1Pe8mjbQC8EfSBcDB+o8y+ONuurlRKnTHUYqmKxhl09EtOcm5eUC4Mha3UJQLYC+9PVNoqF71n5PI/q+WHotGCnLpoYO+Kre2uOEt1nSaA+OaP8YLGWzLLr+V3OPIO/ReMus6X5n5QVQm6wYAZQwbW9ZxqrwVTOrNy6Kcz0sUeSkJ0NSsrWvNPGOSGu52hllkwBqZZHfmvLGZHMM7PRVO/nIdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LZZcksHMXlhrdMcR8YBr1QZ89bwh3dvDkqLFXLYBYE=;
 b=FI+ZbC2Tt5pKppJqF6ekYuq9ODQei5JJvP7N5VB1zI4hOqI9zJcCl9v/k/6qXySO8A5HuiUcQO3buNOr8zsuFKVO2mWRdw/v5WbYd0p9OLOneyNaOZWBH5jlyMt6mS90LedpFkrdMHCbJQigo6t4m6nbDS6Ej6RY8EjHuLEwzYGnXH+DGE8B0JlaFQ0Hq2rgqXG/mp46dSGDAC7J2qbZ4dJFEAf6WYTkSIdENuETgPyuOjgamkPwGlUQFApXLrTAWiZl87jZqwbGEX7s+LNgHHRuWZ0bQz6qGbMqcdEmVLUa2jcpGF9sFuOo0mfs2cnfeKnKHnpVzcTYernHLyn/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LZZcksHMXlhrdMcR8YBr1QZ89bwh3dvDkqLFXLYBYE=;
 b=3dEBzQDVzpow2tLBKZAZk583BKpkawqXKWskWPZhXWq9DBa/WbisDnyzyx5GFMMkL9HZMx+KT420Gu6ukQLfI+pNZX375u/lD3SOaAIMnTMLWoHf2FujB5ONrKIkqxu26JpuKWN3OHaK17mT53EUJUYCCCb/F6dpzRVc6eIAasIliXwVBaYlzgqbm86PpmcpxnGn6Cb8533QgMgKB1PLaWpDQP8fZC/lL9GEm14jv67uoPo13iMhHXJFX+BPcY2SVvDz4xdbwyQpRsli5C4/5fvn4CWNrkOxyIZwHJdR2tEANe5va3U4GHSkIEX0JWFyQZYF5RX2ftfKN9d3/GbGOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:35 +0000
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
Subject: [PATCH v2 03/22] drivers: mtd: spi-nand: Add a NAND page I/O request
 type
Date: Tue,  5 Aug 2025 01:11:03 +0300
Message-ID: <20250804221122.1420516-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d8e8b2-123a-4889-e3d1-08ddd3a3e027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0WPuuyBe18hKDjmFcNJFCw3MYUmDdBndq7/QcxJrrQxl6o8jtMTqrOdiZDn?=
 =?us-ascii?Q?0oM+zNG1aYiTqCEuocVg56gKuHQZ3OUJF2ufRf7uGPRcM7tT/8BVfi9WHFwZ?=
 =?us-ascii?Q?nILVdvJ6IwLh6LBpYrnB7tuBX8cQWSB6+B+dfGjqyAH0xSiFVwBFBfoaxu99?=
 =?us-ascii?Q?BL7wWgoXSPVaNf20niKZToVK/Z9Qhz2qsNRhM8+f1SQR7XvHDWTHWrb/aIMz?=
 =?us-ascii?Q?mgV5xTC5WmO55zF8INA7JpvR7OhoBw2W+qsxjHiwfg0SqqkqIljBEsYUrDMg?=
 =?us-ascii?Q?2S2MBlHtwGaMHlX2RrXkTGVAdJtyTG5lVj4TflV2Nw9P3fKRajcyNn8Sh8Fo?=
 =?us-ascii?Q?D/EmfWZizDkvjvc3zxHlLar1Yyl/+oRRdu67aDJ1YuHfF7m3Ea5B2uum59Z3?=
 =?us-ascii?Q?po7RMioMnrNwQDNv3QhOA8rIKXj6SUZSUsmnfRjJgjJzc7kBz6ryGAUQIxtj?=
 =?us-ascii?Q?4U+DF9C4fkA1i8oIhGOltVPb9d24DOpazEpEN7QQmDjBDXoMbD31wHoqcr70?=
 =?us-ascii?Q?qgSEegy+RBvzVyegiVM7uGaTZ7ASjKH/pEgsYq+4SxytFnMyNV3bW0kp4F5H?=
 =?us-ascii?Q?If+QQESBhU2KX5nUuL/R0cfVVdATZN4I8rZdF3ltcj3GpVK0dzMC/2rtI16U?=
 =?us-ascii?Q?MRavjiCKQwcqsl9M/vtGoM0brZVHbgyMrHkIHohEZbWLI1CsOjfak+vZlr6i?=
 =?us-ascii?Q?fBQ6E6hHOYbBk6JQWi48kEetxniF+yC5wfH3xIEbgW5b2+v99Bu9jMqRdAkw?=
 =?us-ascii?Q?cXaZmw/SqXsqmDcYxQVqaCfpwCvmyDtaJZGrq84heIPex5FXBsz+BzuSMZCZ?=
 =?us-ascii?Q?Yus70ZAQNeXEPkI+AsTPeAfWXnW3bcBHGlI+0LHxRgIH64+oNjM7sSq/vmyx?=
 =?us-ascii?Q?96yYw2uJwPl9hacfrcjl8T1nWMYbm34ggEBfIeygXGPdUOhUKZALm71P13ET?=
 =?us-ascii?Q?D+Vr1KMoVssPKObP5zabNi9zEutu0OGe0FwPWQwh0dGOos3EKG+g5x2RhDSB?=
 =?us-ascii?Q?mAje6PEzGGjt272vcgdDmpkxl3ov7gCxf2hLTUOAuDwLaipSjGxJyXvVx4Bx?=
 =?us-ascii?Q?NYJwGPz9FT7KSDA/tdU73DAJMwCIJJQo0fQ3HhRVV8CyaKwqAodRUFQjKENV?=
 =?us-ascii?Q?jEIgLlhS9+Io9+zwIqhp6QbzdMOJBLCt7lKGnLTnAOx4mcG/jyKoEVY07pHq?=
 =?us-ascii?Q?cWZd9fmq9EkTxfRYnRfVbab6Czw4vdVRc6oZZlO9Ew1bd2hHKCpMZlxg+sLN?=
 =?us-ascii?Q?+GBodQglrHeXmUDPyxf0YkQhyYBpsKGhF0oNBwZfTyxGobdSplmgL5ozq62I?=
 =?us-ascii?Q?P9QNb0uuvezQgC4ssvCusrKVnMlYKwp+OrdG4QBJss7WOcETzVwwIORfFCAb?=
 =?us-ascii?Q?iWpIi2WDf7eOwrk/XpO/KSqpoLM13yUW5Tqxqhqq4oYS9aXTlNAjo4mhjDlX?=
 =?us-ascii?Q?1kKrvzDKo3QFOhl2J0cFz8BSy1J9/15icM9J8PI2qmgU0KeAIC3JrJFR3DS9?=
 =?us-ascii?Q?HwVUtxQCmHep7KY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXmJNeWRVVagijRTDGOEtrZrKERMGFKLHBkykBaWpXxWZOGGiGB4t7x/3fxI?=
 =?us-ascii?Q?yz+cOmDiaAcjbk3dMjN9trSZOH8mjrsrAJ2nFz4lpm65ERukhxs9nu9gHueB?=
 =?us-ascii?Q?zb2YVpcIAkt2pK4BTX8OkBdOUnGzF0VGmp4ZKziBl/XDRaB6jFpZqfeIt/qz?=
 =?us-ascii?Q?LxB44CxBoSXWqqIBEyt8aZ+sIg1U4gflYBUzLfXR7PkmtdTRYCGLtJyCygYQ?=
 =?us-ascii?Q?Qui3hCFnNSwBPAjA8FWRvA1ZHAMm91rKzXcgVJ1UEhHAsLVoVv4GFV1ATnwI?=
 =?us-ascii?Q?Aual385J2aprNkcx9iGt9Ez//TQQ0UIu7voDoTXqOyhaZYOQRsxyT/Z7k5BQ?=
 =?us-ascii?Q?XyPSvDwmUEv6INmYSiXGuaLrDyc1s07QxEkC6KUzbo+uXifHssgoay2HW6MV?=
 =?us-ascii?Q?vOCzSkvDijGlwQWM/3DWBLE6SglAz4LZi/1kfEI/DyejHYbbnp1w4OWoBe/5?=
 =?us-ascii?Q?KvQoXbti9AJ5umhWo6yZGbzi6B2gNu28iZHg81sL1ViCeHjlgNc8K4p4TlpV?=
 =?us-ascii?Q?kW7WR7KULHpSZ/b2zj1FqgLjdS5Zs/OAAggVHH1Vo+nGXuf8PktUm83FQaS2?=
 =?us-ascii?Q?5hFtsR8NNCyYHpr6g9y23TKlMYwKD4MJspQFSn/2Y+FLHzxZuaKydgss5NSj?=
 =?us-ascii?Q?YgxMY1FXjO5FUA6Mv6rAfVPzyoDxXKipBB58kI+GLQFCfSlxv44RaVuNJnej?=
 =?us-ascii?Q?wEfPS6+5+bfIHGBYlKLJ3Nb3W6gpoEUZgSNK28gfJoh9Dq8SvLMq+jg9odn8?=
 =?us-ascii?Q?JRy1G4zjvMZo0zzOxK+rlR14D3b5YPc3jk+v7OMXr6WsBwuopglTMkTITQZi?=
 =?us-ascii?Q?M6rNViR0M5QF3gmMl3V4wHTMbVT+KYuCMXbb8c6H/Usss4ghd//hHxZ+e5nQ?=
 =?us-ascii?Q?BmJwsCyFCTlgfWT/J/YVLzVB5SaIFMzNPNpgDB6GRtF4iWSHTbhFsbbpKWOq?=
 =?us-ascii?Q?0213H1PLwzWBhL8KZ/xogilae1uPlPYxgcCUWnX4/ihZqaoNfNDX8L7h+2qP?=
 =?us-ascii?Q?+i7QCENJZJtfCo9VqUEa3nofFzMci94OrDKClzusZtUQ56QzhdQivTjp22zT?=
 =?us-ascii?Q?dQSB7kx2EoONCh41aOUPPmWoWi10nD6UbUJ6CGthUTvflkN7FKSVAVrpZG/Z?=
 =?us-ascii?Q?1lvvdGUM9cIXeWiNtU0pEBjgT9k12knAyQshowzEm86x+XYYod3c4MOA6L43?=
 =?us-ascii?Q?bdWGku4NC8SSodjME0EHtmIWUl/SNvXYp7pyvBnsMjTHWMhgKEO0NHLCDUB8?=
 =?us-ascii?Q?cENSzlBVu9bhjCVmT6FvXTb+LksoIWtkHCqFSAbuDrH61+nwRutVW7o7glv7?=
 =?us-ascii?Q?43yldfzO3PqdVENgCuXXklBaBrNbqHR0gUc1VATMRJJPuyh8DrCzTRNfD0qp?=
 =?us-ascii?Q?zuNhpQXWNqLcL9cL1cJf7/P5g770rsySA1BRLlMErwCrWvWnsDYqcFAElyHm?=
 =?us-ascii?Q?sNJEj4JqtCyCsJl0iCufiOqvB+DRlQNe66yspaaC6/ySQXLcD4prPC7LoxVk?=
 =?us-ascii?Q?M9IoWGocBp1tgjv5B3U0ASaJC99NkYYp9f4qIl7O+2z6EkLSmZ4NBo74qJck?=
 =?us-ascii?Q?CMNo2R1E1zb/ZPq4BwkN3jHNzCYJPfP1w+DEgaa46/DYrL5Bu7+jUXOWn6sM?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d8e8b2-123a-4889-e3d1-08ddd3a3e027
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:35.2647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAYKlTUJcTpgWUmYFZyKxP5A3kC3ortpw2HVtGzA171BGHPhpOEl99wVXjYgh8+19iIxKX5L0E+ViR06oKrSCaMN7KZJo/et/1V4MR1slNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux patch 701981cab01696584a12e5f0e7c2ad931a326059
created by Miquel Raynal <miquel.raynal@bootlin.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c |  4 ++--
 include/linux/mtd/nand.h    | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c1b8b9627f2..d8abd03e919 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, from, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
@@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	mutex_lock(&spinand->lock);
 #endif
 
-	nanddev_io_for_each_page(nand, to, ops, &iter) {
+	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 651f8706df5..0afdaed5715 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -80,8 +80,19 @@ struct nand_pos {
 	unsigned int page;
 };
 
+/**
+ * enum nand_page_io_req_type - Direction of an I/O request
+ * @NAND_PAGE_READ: from the chip, to the controller
+ * @NAND_PAGE_WRITE: from the controller, to the chip
+ */
+enum nand_page_io_req_type {
+	NAND_PAGE_READ = 0,
+	NAND_PAGE_WRITE,
+};
+
 /**
  * struct nand_page_io_req - NAND I/O request object
+ * @type: the type of page I/O: read or write
  * @pos: the position this I/O request is targeting
  * @dataoffs: the offset within the page
  * @datalen: number of data bytes to read from/write to this page
@@ -97,6 +108,7 @@ struct nand_pos {
  * specific commands/operations.
  */
 struct nand_page_io_req {
+	enum nand_page_io_req_type type;
 	struct nand_pos pos;
 	unsigned int dataoffs;
 	unsigned int datalen;
@@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
  * layer.
  */
 static inline void nanddev_io_iter_init(struct nand_device *nand,
+					enum nand_page_io_req_type reqtype,
 					loff_t offs, struct mtd_oob_ops *req,
 					struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
+	iter->req.type = reqtype;
 	iter->req.mode = req->mode;
 	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
 	iter->req.ooboffs = req->ooboffs;
@@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  *
  * Should be used for iterate over pages that are contained in an MTD request.
  */
-#define nanddev_io_for_each_page(nand, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, start, req, iter);		\
+#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
+	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
-- 
2.47.2

