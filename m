Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6548CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4946A835C6;
	Tue, 30 Sep 2025 02:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="A2dwQXCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480E0834E1; Tue, 30 Sep 2025 02:21:32 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AD88350A
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRFreKJYMxFsjSFkBtrUwVdpymy3yLSWwA3pThKD/2zMNH64vmdeIouTWC0e6EVs3EKXcX5RiK1peN1RjDO7sHAvTpoTouccyusML61tSzsgtEMoxL9EsW+PDlWDDUeMuHjPZobLtnmS83Kw8em4usBNdFNymIP2oXaHOVwweemtXZZTr0W7HDJkfJ+9N/Xg0SYUUf7gz2veYnk6r26qRCvVTv5T1k4xxiyIf+d6zvJBiMVN0BqNJgylzBlU2n9JobP41fObySKfcWCAFZan9Ew+LnDnxF0zZ1OUOaRdIkmVz67oTSLgWsH1KKjh3IOxEKXP71QHOlJCquHntT0M2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTO59+Z5UMO5/En91MaGz9PznMuT16/Hsyhpko/Sl3s=;
 b=xjeBVVqiZRF1ywAhHKp6Hw8/oJzVpSkgJpAWXPl1SiPQfH4YkjqspNivtR0hwmTFWl0XU/gx3Vwco0XDnV5WNPrgcd2PGu2CRFgxB9Qn7FlA28H63bjnICJ08VRYqO2tXIeSw/pbfdCEl2LxFrIcveVtPlH8CT9zrbplLIrDEMNinq1IvuOdOMUz0R7laLaqRneDAdbHgZp8wW52mTUf9Mwo3uPLYCINur4QugtO76XM5mU+tlAnT3rdP+u1a6xKrV/k+UHniJGnsT6es3JU+mS8bU6z+YpOs965eoE8TQHBqtnnB+B54JXIdSRmnKud6Eq18324D8SUhijJXpGvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTO59+Z5UMO5/En91MaGz9PznMuT16/Hsyhpko/Sl3s=;
 b=A2dwQXCi3qa6H67O5shYzxfD0f5h1SYlNvH1M89BjtgDiHkpMPu2uY0gHfmcVeo7Oxo/DpHcdOX51jtl3lUQMJwCpaM3b+9d/9mCR/C9khOEMwYJpAfKAKSDkP2OLKS932GnpJCVYxQC/OFVt9zhor+RkXUarmow26OB5YUn2XYQNi8skzQBNtOoKB0jCSSj7ODPL21JeXdPlIEAWlbU+B1GhHgu3xJPb8AbT2pirSNUhs/5Kox/6343XQtns+zjhvvnELPfsgNZMYjF/w/GUyNKTZnQLTk/cea4aek9YD8lpzibwT0/ixLS7DbISelEskEJxOGbPo7EXnhQ3B5c5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:28 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 03/24] mtd: nand: Add a NAND page I/O request type
Date: Tue, 30 Sep 2025 03:20:48 +0300
Message-ID: <20250930002109.3600886-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e09ff63-cbe0-4e6f-3dda-08ddffb74882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FN0oiFL0US2K7sxBewP6Qvx7FfMwaIHFDPOeZW8uB3it7+YJEneyvNSA3xh?=
 =?us-ascii?Q?qPPnitjq8fr8HvKqxIjBVdKtcFRixlLs9QuHX1bLN87oUbAQVBdEAZwjeOG4?=
 =?us-ascii?Q?wjKmWqNKdJMGRRY83AAIXiuwaF40zPGKRAcz+z/LUpGHLgf/noFfmH9R829s?=
 =?us-ascii?Q?5MM5e7O5FWmI1bBiFhcNk4Io1oqmfPFQt/4zFPXu9CixMny6jzMaxrcLMDrX?=
 =?us-ascii?Q?7MGUYiaWYdvo7iTppPsufZxSp9fWpHu45BP50h52Ni6mwOvQGQReVfPQpVAy?=
 =?us-ascii?Q?DkyiinIuhZLSr80CHft9wLgbZR69URMRMU8LhnETG7cCsUWQVp3mjxNy7ARp?=
 =?us-ascii?Q?Se4PveZ9qS0VXO8s3k1gn6+GMA6gRy1koyAjDETxWGVRUBZJhzfVhSwJL65n?=
 =?us-ascii?Q?33Bd8Hm30bAJ7+ziCOQUP5tNcgNUJnXVgbX/Dapje6xDrhSzIZu94BOSLdIO?=
 =?us-ascii?Q?NSHYNgHJOE4Sr++7rQ6N60XL8SURd76WydW/BUa9BG64B6Bk0N8dhU5s31Y7?=
 =?us-ascii?Q?SEszhf6F25f4lkEevi1OyecnalmYpS5w4k+2xoj/I9pvjlxOmyREwj9tyxhr?=
 =?us-ascii?Q?uVitz0/qSWnXUbD2ZQFngz92gLfc5bRt8QLewcTOMO7XbCuPteM6FnYb55l7?=
 =?us-ascii?Q?GPYWuQi6zY8OZkS9F7QNGWic2wV/pqCD29ezu5gLh4of/nkLi0/GR+yFdn9G?=
 =?us-ascii?Q?ffdamskMTLYNegqmVDKKe/O2p5DihKZ/I9fGXzvGq712u6vVP3c0K0bvsuAh?=
 =?us-ascii?Q?TL4Wz4bh5NopD1NgsIkc2gQNxxa0j1gB181tLj07Q2I3qxyRakBPp5yRr5V3?=
 =?us-ascii?Q?w4uCpnKnSs+UuMJ5bI/mCHWtUZqq9hNaZ//Y25J54NSTaRHY42JuQG6zU9+T?=
 =?us-ascii?Q?MZvw0gf/KGbp7JqO9AgDDvPP3KWjz/2gcLK5qX8GGQYaS3yjtypcdGmDnbpU?=
 =?us-ascii?Q?A4MCMcBju0a2kkVZt9mb6D4Wrz7g9z6NZ9K5t2sGb5J1Gf5iHEDftgMWdWS6?=
 =?us-ascii?Q?VXMilrgTI1vPGW8Ge83GGefxPIthITdmt/jfO9IpD4HcnsrwPb4t8EoKDQza?=
 =?us-ascii?Q?2M/BZNoSCxgNYYIcbagzwFTeKlWcRmEBoiDrQNGV5GrvCDYQiY9VzT/75TFA?=
 =?us-ascii?Q?8yiMXW+dncFDF2p+thPaPH1aG8JBzEof5gOFYcReDLQfXSBcypgRkoKvnXdw?=
 =?us-ascii?Q?smVdlW3X/d9SHd0WuDliFo6il7NmCuQNMLzMscQDV1q052q5CcjRsGusP8QQ?=
 =?us-ascii?Q?5aVkWOT4+44m/AoWJhShLUEcoevkU2faxzJgzkJ/dZtevjLt5v2c1NfbJe8X?=
 =?us-ascii?Q?ZvKvAtxP8V7Dp7MA/MiTTaueI3vR4s6vLJXcLTAUImyq2bG31gMk3A17Nfvk?=
 =?us-ascii?Q?pVP5nlELWX8Gdz9VOhcvp3EeHlK9F9lVL2j9egp0JnGZ9djKTW/VLSBMTs6H?=
 =?us-ascii?Q?5Fa5Z1RBrhYddh5htLebbSUCl9Ir6gdB2wpVE/wn6B77CHbUo9yAd8Ftim53?=
 =?us-ascii?Q?CIhrj0oJMVVoq67wMogG2tHoaRueirKgZ6xSrHKRjnVdllXA4/dx/zCC2Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OxTmnfiAzuBVkJnPeWg8ogkH4kOrX9tRZstLS4vGYkh+qcIhaEpNb5t5FXf?=
 =?us-ascii?Q?yd2Sqmo9TV5owq05XyA7RuH/zN96EF7RVhUGya0vPMxvRl/uduulJyWJqsvd?=
 =?us-ascii?Q?PhKFLF6ykROoDxFy0sKKOSDb//42Gp9wai3E7EMoUJItxkBJPGPKI9R4lOjD?=
 =?us-ascii?Q?PBjtIu/hXaTYpAbeCWYygzZGSg9XWrfFAzI0CwhrCwkS/InmwyoruH94rYxL?=
 =?us-ascii?Q?+E7Mf1qbFFGy7TfrNlJG9uYQqQpRr+hve3dup9EIse+g68oEXzQNR+bXhtGB?=
 =?us-ascii?Q?PEIZSv0znVCglYny0lJl47EUh5LR4kgU6YEGDQiTbo3WAsdP2lF18BJmaFWl?=
 =?us-ascii?Q?c3suowmSg97vDUaTQfkJpxxfu1KCwFe5FKBFHgK5XBxD+lop4S75U0kAtzFF?=
 =?us-ascii?Q?0VY9vXaIBL841S98ZQxzHWNKTK3wkO/Buh7GDdN8jD4lhjsXEvYcOh8131wX?=
 =?us-ascii?Q?DnDmOoVqsgVDakKBMYlQ1amGM6zWg6cMA2yB/M9WhblYSV4RAuQwFpJloAf2?=
 =?us-ascii?Q?dho0hnJEPbd2zZpVLphanxW6Zy3CrIHFtRA5ucW/ktR337NV/Clv3UbkKw2d?=
 =?us-ascii?Q?rRv2YOh9Ki46dZqGXetZefQlEt3bfF08x++8IHCEWu3/f0ILqgWFQ4pk8WyY?=
 =?us-ascii?Q?RyJ4bukyAOLijSF/6zL14WenagmHErAJBPxFlGnWKq5y+IDDNv9tYbOoFIBD?=
 =?us-ascii?Q?4NcnFlzjEBdLtSDV9yppoeifaK0CrvBca3OfTcgcMiQhpmqPYzgRoAl+zZBv?=
 =?us-ascii?Q?TnxfXB5wtOZ8rewsqNa4pVCwfjc4LN9M9Wlxpc2xn+SxLo0Gi8i/uD/I64Ow?=
 =?us-ascii?Q?04mWJcFYQzgCtUSzTnnJCLYJV+bSabWD7qaNCqAbQ+Rs0tvkVjHDbFXdRdT6?=
 =?us-ascii?Q?6ciYY5JjpEKGBfh5HsaKE8JH0czistvYyvVekt+hIpfBMnHTsjDqm9d8piAi?=
 =?us-ascii?Q?HuGxIxzYu1pi/egekpemDHdRRQzUpD19mSEZYgVy8rxAaKOFG8J1nOT1psha?=
 =?us-ascii?Q?ejK31LDXTjtz9hMHnjI8rKEL/xCikJbOAGr0eHDuPDmXX6W0OG83X+g/91G4?=
 =?us-ascii?Q?iZS2xxjOgq6zI7/ASavKu46+MkFrgoXayf3F1WCIkIKjuUxAlAb5xu1IGZd1?=
 =?us-ascii?Q?77bfYVmWdVH633BkKj6AZ48RKXGTL7JcLilQqlUK5QXc/j4OB5BDKtNsXyQH?=
 =?us-ascii?Q?ttax2i3KJ9sgBP7I3eG6EVWIYlarXLDZ9cAsOjtsE0rccJGJdfUvUyV9uboW?=
 =?us-ascii?Q?YWOCPnWF8cA+Wl5LUOfkki7XuA8im2Qy/iEUDlaP09vE5mkEmJcP31ggLzc5?=
 =?us-ascii?Q?rgIsLT/wEyNhx5Q1dzGgVTJXT+WiCfffXj8MyV2Nf1GiflIDbKAg5M4LoVWp?=
 =?us-ascii?Q?GK5lbXaRah60WX3IjQhZpDAOtWmXcpwTpHCTqAnNUkcVZecrsowX2VJwU1j6?=
 =?us-ascii?Q?u76cE8PhSCbD4auhwiOkN6FPNSQ9PaZhtMTSFHgEaPdr4a+v5hha2z6wDARf?=
 =?us-ascii?Q?60QTuDI5yZDDwbO1uUIHdL+IkflEFShTPJI/3LLcsIaj8OmyPwfnw0PNkHAH?=
 =?us-ascii?Q?7oTjmMr8zFamkBEGR3x51IyhwAFolcugw7vB/f3ceMRpXqjl3nHeLR+UKaNd?=
 =?us-ascii?Q?pV7cv6Yc5A//nntObff9Uaw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09ff63-cbe0-4e6f-3dda-08ddffb74882
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:21.9049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LwmZsT30zk+V6Sbz+1uCIQHTtpVDrXJpgeSPPu51nKxFSnccqJpcp1/vmRnq6enO4LbLu6q08dmDlZVr0z8XGS0O3XBQUoXbeil16lvHyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use an enum to differentiate the type of I/O (reading or writing a
page). Also update the request iterator.

This is a port of linux commit
701981cab016 ("mtd: nand: Add a NAND page I/O request type")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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
2.51.0

