Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F622C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D24847B4;
	Sat,  9 Aug 2025 03:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wi9u84fW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1708480B; Sat,  9 Aug 2025 03:07:10 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBBA847B4
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQR7F5AzV/UbDzvv57z3qq4nR0ijzrFbn6Q4vhW/Guivf4d4SpYJROSQJpzD7Thel2wimQugiTrkKRIRmG6QHclAdC7PM3JOEMU6mYmzFY0TTKZvQn+RrDSQWCzsOQ6xub1869LePtdLfVL8Xs+VbqG84zYTn1Mogsibdv9mpY8qvbWfZOUD9yWm/Pi/LW7BFSpk5a0gZ/8IexcKXi5Rpu7DEH35QmNmr5ouLbJaZar6NHfcYLlYsZbc/VG00wNYZHH6S6+C7BtPamKy9u6m7mUHs+awGZScr6a5q4tUrdIJuwga3KtOODh+lk+da2vogPJCRJiOhxMcjcdgln9cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po69HnmKEjS5NZswVw7gQo7e//y7LAixQPo+uv9yqc8=;
 b=eS0/cHXMP4gametMo9p31yLevLJpqtnerBsjoPdrGjdHI8E8m1w0K+pf1Ki5Po/pE8zQGGVKXXk+qu7sJ1WoHT+srT5GWFcHdBd8y+G0Oq5XteZlkQqJ2N8VL3Xz9N/PJrkM/YIhuGdcsjDJLlFhYhMZTP9szJcLDSCYKBk4WsufUsTgSSoAx7VpI9erfFdsqiFwpxPdH1Xl5Jt/LrASs7Z52OGO4J+QDoPW4KCjfarNgJa3cLvMpC6HoGigVoP0/fAIsZHLCPE+HSRlrkiKigezYwIF89ZVRBinKNu9d4AHya+XvIYOU1J2mdSNfBvKVRWdg8dghHbtmTinbAtNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po69HnmKEjS5NZswVw7gQo7e//y7LAixQPo+uv9yqc8=;
 b=wi9u84fW7sXB1x1tAoR1BYCMSObOWH0ZueDn/DgBMn+mjqB5Q0Cfcbwyc8WlSU1LuV7sQ4/ZTWzhy/16PgijpAtF8foASFVjSaHlLtm5mLHdWz3XeMqzCsZltD8HgJZB8xXHUiB0eBLgZ1u7MqKMt1o6a1kM3dpS5VnviI25efLWgXQl6u8TiXMf/iwTpK69cCbFhMCoIw5YPDP7KLroialuP57aXE6AbV+LvJlznifLwIBArkAIc4Ar+WosnYf8yjKC+dBSek9VajfWZyAwHPl5pqfYqXFljLnOL3mIhS0bCb6/lL+ckimrPJzGdshKs7Z7pK8MndX+9TEyyQj0dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v4 11/24] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Sat,  9 Aug 2025 04:04:43 +0300
Message-ID: <20250809010457.3125925-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9408bdad-97b7-4ffe-af4c-08ddd6e0cee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1DTILDU1MFfN2LJFcUKhmlZUjblPTa7Y2hlayrn+mYsgCf0OLuQgSExQNQ6m?=
 =?us-ascii?Q?vjUUOpsi0Dx6YqkO5xt7eptZC2eLe7jCS57ZRobr5z0uLn5u/HCYbHMn7T85?=
 =?us-ascii?Q?DEltnj41wKKnavCnKsTXHmQqqhQevoBA0Q5OgAauADfH7wWd8Q6cFwMiMqpr?=
 =?us-ascii?Q?7j4stHiqXVLd0uJ7tO9XowWvjUyj6o74XbUdTR384Hy03Fsd3pdZKxW5Rhb+?=
 =?us-ascii?Q?Tu9fIEM2zwucimY3p8m9Xpb6kN9s5RsWcch7O3Lp0DNlW2gu9S5L8uaT9qSA?=
 =?us-ascii?Q?62HrcITc4aNqSipwsHTdMlIIn+bOvrEPPrgFBqnbghr4uxO3Ipvw2S7oSpY6?=
 =?us-ascii?Q?rClZYigdr5YoZMjHQZnTA115ZRJ5+XJ9nxeFTDM+WzkqdEN9n2VHIpQ9KK4G?=
 =?us-ascii?Q?vVAvgNt8DOoctFVODQwuw7gljiQpx1qqfJ06GI8hMzatr1IfEb4pbowhJp8Y?=
 =?us-ascii?Q?/RFQI+niKoxQZyaSpm/iEGAXG86tCz/2PSq5yXFzZri8tJzP8aD9Id3UhH5Q?=
 =?us-ascii?Q?7f4B7TJZDYLrUo9FI1g7CUl5k/FIFd1iBGOWYYVtkADN35GjHsGrhjg+/Z60?=
 =?us-ascii?Q?I7NN01w1yW8fKGz2qa+Xpw5YZdYfKCTABUeiIy3tcaadl1JJStH8vohnUWxc?=
 =?us-ascii?Q?OYH6Dc25YeyGrOooNRIC//wQbIhKSHu0iCrr+JkrVefvv6MNBnU6unaNMSit?=
 =?us-ascii?Q?irC2TyYpnY5pFtcje+I7R0lUHnPa3bVCVb61JhiZ1z1MhVDihG1vKcpw4pFu?=
 =?us-ascii?Q?yjzvRKLSUvUTz+hPl7IVBPk/ztr4pfclKr3Bts7W3yZSDbFT8ETK6W/A04oR?=
 =?us-ascii?Q?Bt3LlGQzLnh7VMW0h26ZL4yalPPdBp6dhYM4yVPQCJvq1eQtY7XlZ2OPcocF?=
 =?us-ascii?Q?JUdwegy2MJZmtyIqOPsdizO/r28Xr/BECz66L8LnJuV5HaSMrQy+em/kZrQB?=
 =?us-ascii?Q?IzrP4y6rj5mmGwxzjir507qMVe0rJMyLbcd9JKwdk+pllYPatohqfAzQD7bW?=
 =?us-ascii?Q?0m0/zCcHIIOcjiZUHf7cwdnv4n8PgtRttJPqGMsbN2kWLyci//WnHRdPGM39?=
 =?us-ascii?Q?q5pMB8rgWH/UfwwVfZiHv6LB7IQ2AmW7mPYFjWVJT/oEB8DMmkRhqeUKNk7U?=
 =?us-ascii?Q?DVWWjhLXN8hIHyyQy9BpfBU0bPcj9CUtRlod5Ssgk/iHbzq8rS4A9ImHTC/x?=
 =?us-ascii?Q?rU7Q7vaPi91eEFMCnai5tE3TepVxdkckq7MQr9X65IO9ONf3cNvBkbVGGXkG?=
 =?us-ascii?Q?p7OXL5BUIwdJH8cQATFZG+KWOVk3mC7sX1hYNcN2CEdvwTa5hPDVulGIRg0k?=
 =?us-ascii?Q?rJvGyx2pAhq+Zq8SalZwQMvqTEjipFtBEYy8kQtpWgYYIWcIuYQndKeRLp2W?=
 =?us-ascii?Q?8bn7jylucWAUd/n9XWaq+hBCRhkF+bVPUDalx2hVJpNImK+a3YUy1z0EDN7n?=
 =?us-ascii?Q?05olpCNlO/yaL5E7HVhBY0mDoWO1CDTEdu/kAgYq1AdY3wP9zR6u48Xri/RV?=
 =?us-ascii?Q?ejCpemOeUIg2LQg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oj09ki3+DmjE4tABe6IrWdOqDS/GK5sGG0OdX8hgSAbqx8JnlptHJxLYYtYW?=
 =?us-ascii?Q?gbRwp2Z8yvoioBemVRtrFrsO9mNe6PHJBdpm5BqnU/NDGPkWxDX3NVjkr26T?=
 =?us-ascii?Q?0yMqefKOZ4M/KVAvNHuPrMHIEpkAI0eMOrRY35yVdErWYbEeTkXA8YiJ0W/j?=
 =?us-ascii?Q?1vkYjhuTrHtxbLjLCFSLX+zliBPoqKTAfKVMCdn2judivW5FVPaEAQytwfeO?=
 =?us-ascii?Q?NupCxzjDh+N4RK1GFqZk5w4Z6xXHH72cHHzjQEcRNuB565qvOQmH9Ecm7CNx?=
 =?us-ascii?Q?gVXHN56OM26EFfRGoCCFneTCsny85O1IwabzRvVrPqBwqRxAlQSLpWh7TLZ4?=
 =?us-ascii?Q?Gncz6TjrbnHiGCkwnGq3gaKzeAvdaBEU0pgSDIzAxm7Nd1zTkJP7Y5oCXwQo?=
 =?us-ascii?Q?3OurHrIdCacVJ6B+xNd+GaBC7ZzbS137Atm1nX5jLCTukIWp+k/CC2Ef4uZI?=
 =?us-ascii?Q?bx4OthXYLpSmZ9QpeNljo3LnicdLYqh3UH3OXnz3rx5Ne0z63Q/OJ6qHfJhB?=
 =?us-ascii?Q?4NA/vUAqBhifFnv78ZLCVcItdaOIlTjwIOAf05Y8b7IjQGR6rdIl1NoIRaiB?=
 =?us-ascii?Q?BxwEWJ2eH4m3RDWnV74S6u2opDSNQCUHW4hP2oFyQCQfKBacKmBdBqq9Ktbb?=
 =?us-ascii?Q?WFTWd/BSh1grTKuE6+VB1zvM9zLLNm7uJK5nLqOUvnZEK32gbPqfxDjWX44g?=
 =?us-ascii?Q?SZ01LhH4djZCumcdbV8EIjr0bx1Ev/rCtF5JJyfPLa5/kPTrZq1SIqwiAS/n?=
 =?us-ascii?Q?X7d70zcsPFoJ0kBrf6Pthn0oEZJJx1z084aJR66qljKHiev2/LQeuTcOj7LP?=
 =?us-ascii?Q?nbnPbGbBBgfvXHNq2X3YgABFaYwenifA6JgPIAgu2nyzj+IVISghEkekHesg?=
 =?us-ascii?Q?BYL6kCJUQR30j4Ck80BW8zYuWsTJh31ShX/kQk7HTfetEScJ5OxiTCy5PFDq?=
 =?us-ascii?Q?Z2jibZj75xwplx8xZM2mYAPJUPECgrx8jNXUsgdmhEjF7vt/izJYZH4vy1B+?=
 =?us-ascii?Q?c87cPSSd3BhNCrZmpe6yG7GJ7iulU6gMCl0pVqcxZkeOoqZrnWGSIsJxNXW2?=
 =?us-ascii?Q?Ct90lzliXj331zDU0U6OF7WKD74kGi+rPKoy58x/3cIRCMlhGI6q8LEahZnK?=
 =?us-ascii?Q?5yugZU17BzFA+od77F7Gb9v7DTqMTTUpp+8zgo8Vk09eg7HDF723C7QxMUmw?=
 =?us-ascii?Q?M0zqHPjCaEpu1vuwer0EHB5Nw1RVEDZwGQxUAo67Y//omZzntzpnI+Rc6rRF?=
 =?us-ascii?Q?n3Ws8yKKu2PDg6Lov9DDESEdwULwgUk5xzHJyf+fiT2u/9uoqyprgHCiPUVj?=
 =?us-ascii?Q?nsZnUPiqkAHZD/XK5dhVycbu/rg9a89CuLtPZ9FQCTUDb44FvvYJtEQIVtOg?=
 =?us-ascii?Q?gf2/JWP75GIXa49G3ZdR4LFJRtp7loxJP+vw446Xo2D8xl+CmhZbTNjyEtR6?=
 =?us-ascii?Q?IVJjiNZ+kKzyWuvqIovyWSb0LUsTzAdP910a1C56KddR3Y7whLMGnAEse3d+?=
 =?us-ascii?Q?Y86BREQ5DhyGHmpSdnpC3EUzWK+ubueFof4Ygc88xrbRz5/TOyJRmcbf4dCt?=
 =?us-ascii?Q?an450fEgj2R7Fu3JR5vUkgVBlbOrdCWcpYcLbU0X2YriLo421x8aLu80vfzH?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9408bdad-97b7-4ffe-af4c-08ddd6e0cee1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:19.0077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jljoe8Sx4ECHA7YgQwqrun/31Klz30GfqA0S92Ojqs1vfizmKqYGK4f8nh9DFQ5EYKIm/10tqaD0TWx4bhOtuCRP/JBXvaWNZWjJutr9QcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

From: Daniel Golle <daniel@makrotopia.org>

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit 1824520e7477bedf76bd08c32261c755e6405cd9
(mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b4795927277..7ace61fd19f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1279,6 +1279,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.47.2

