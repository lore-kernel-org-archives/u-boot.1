Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943E4C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA64847D2;
	Sat,  9 Aug 2025 03:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CRrlsSWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FEC846A8; Sat,  9 Aug 2025 03:07:28 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3774C8480A
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS2kbIE41QR6z+I6we45rcrYoCXgQF7Rh7Qaz74L5n+rGNAONonf2rNW1XGKCFfr+bEquEtwNZi+dlPVkT6VoPp1mahG7GjXaM6IpMe72vx5U2qc1NeSxOI3InmsuywFWvKuFavhZmTXJfF6BFhmdmh/Sv5khkK6Ejuj+Fetu6ABNHqO4sifNBrfPY92I3PRyu0nTX/u2tylhoXMSdi+NGXWo/wGLGNL6E/+S7o+VVliOYhkEdIw+GFBIzuOILOWZCF9M3FqEcsvvo4D4cDd7rlI01LMygJs2UfSbKdUqF8YIkSsE3F8XrFNa7ru5iHHgCB6g1pY3w3c1p/ziwN90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5uuWIv+PZLUn0lWIiioLU0TdGzX0PevcIo+hTnchp4=;
 b=xayUVrsixBm140hLZbL26kIuoqOeKvgY1WtKlrsxSpy7zlkHRwkoJRCaO09Nosyyeg/vX8aaa1NBiF3fVe3nqrp8pgG0s2jZx/uJUwgVs66L2dqXcS/NnohwBWfakLpZk278EvpBUc7PmtUJtKewBD/N4+aONOBOPU11Tnry+EyTYSyIX9sscmGYxABc0A9OhWBK9kif0SHdfo1o3w2zSwAgRfa9Cib81DDjfWLRz8VbQ8swIRK1cbEourBcip6WKU7e6q45+3z8JODz2kX0EVQcCgOB9tMVldpZHUc63Xl0LXo2rQcrXqgtK4a8/+ei/A8FQNvtZBZTNrkkt2I8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5uuWIv+PZLUn0lWIiioLU0TdGzX0PevcIo+hTnchp4=;
 b=CRrlsSWljVK8f6sCGQ03rn3FdvZXfVO9jue+TYwCp1lLbALH/etnWNYM/cDU5GNwd1Y6dU9oNSJ52qc4gZTOR44rDtJPho7fFAoA7MdeJJayyWI+LCmqDKmWnfz0HwQ2xQSlmRkUfudTTWnUUJrCsXkNIDNssmvkuJzP4zxBXKXIGULYi8z2Ek1HQj4AlCzc69vM1XgRSAHlUGebd592XloUicOkQ9Zv7Nl3PwQU1eKwa97qXCCI/C72Md2FPhbVstuO395eFRFiQdGk+MjbFku4EP0CiFp9jK/uDm/IuKUzs9RLPdSmGuBHsVHbNdpienq5IXeHT1zX8mBbYPeM6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:33 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 22/24] mtd: spinand: fix direct mapping creation sizes.
Date: Sat,  9 Aug 2025 04:04:54 +0300
Message-ID: <20250809010457.3125925-23-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 46bd5585-84ed-4c0a-147b-08ddd6e0d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJ4Et0ItmZwW9PRbrpv3+4SdW//mCx/qbj884XnPXo2KBMNyH9sjL9rIpIV7?=
 =?us-ascii?Q?4YrENcqnRTn1s+qGGqG3iVDvYh4cwKBSL/KgvVMi8wwH78c956G67K6Fszm3?=
 =?us-ascii?Q?b6keeiqvQeoEvnom3phx+3/OES01sTNX10zl3nh2NoS+opA0MP8wzhLxqnWe?=
 =?us-ascii?Q?ZtVmPHWegkANJCzc0X3eIBirW2CwzVsVR91eXpV1oBvLlEYvdKolGakiCYc6?=
 =?us-ascii?Q?dKpSqRifnvLwMxVSvYSiCYGGm7tsh0RsTYRZoEdCjvp+9/eOcoG0BBNR46AY?=
 =?us-ascii?Q?B0F23n560a9nFZ70OfUSJYqEKUhvIn/DWLe8OgTG0lFHs+0PPhchYi2WZ1pg?=
 =?us-ascii?Q?CO9lYd70zN6syYhDYnZr7M34x7vs5xNY+NZFcaJrM2IsinGt8lqxAFcpdmj3?=
 =?us-ascii?Q?fICAVYaePyXb+tOqu3L8JAHOdDbDlh2Dgp7S24rvIZsWbycKADMX6nms6jD/?=
 =?us-ascii?Q?NMO1jkYGP6J260QmcmdoXCq9RsAsRQWBNSAm/V/TGnQxWFV442SCXAVmcLcp?=
 =?us-ascii?Q?uSjsw23/tcvulU3eoKXbZ7Eu8odUhoRtjMN+sNLiRuIDBWI/ztCXhbuLmkPy?=
 =?us-ascii?Q?dFIi5/4WS0hDBbE8pN7FVMFKWcjwHgCPmp/EflNqldqSw1VieR7mRkAWb4dt?=
 =?us-ascii?Q?/PvYpOk5MyRR8YW65ZMWh+I8rEu8J3vyeXmD9wF/zOSEAl25raCf9iTZdo7o?=
 =?us-ascii?Q?33fFWxO0FGXKT/ZxkNeTh+P+J7xyMwDMFXCd1pbG4lKzm2HwcXBPKg48wfXo?=
 =?us-ascii?Q?MazT/JTrt1n63ZaxseyVNtfmzisPa/B/8Mu0X5ZZ8cAGV8PFlMKdUdfBYT8B?=
 =?us-ascii?Q?aqmfdmZgmehuF47P9HDn8GQEbkBiywhi+N1BMbr9VNr5+BhA/ezb4Bif+nVf?=
 =?us-ascii?Q?Tpg86muFrKIGbP3u+9Dk4TNmR0taJKPfAz3oyCUd//84TlfaUnAGGPp/j6Jw?=
 =?us-ascii?Q?M01PWKYSQdF7gf2g4FDysEjfL0l/BP1XVsJczNe9EXB7YSqZtDoEAwIW1rAH?=
 =?us-ascii?Q?EOFu9yDiRQUkgjLise+TSe0ka6/2wgZv0XrvuYuewMMCXKYODO/mM3EmUMDo?=
 =?us-ascii?Q?V/yk7Y4yk8Cp+StVaO0vBy9eQX4pf87Iv04dcGtpSQw0Q08gfe8zDwE36mua?=
 =?us-ascii?Q?ixTapfZft8kbWiIym4CqMpWwVi1raMzbnh/5efeyyBuUCuW6+K51elLPvGSD?=
 =?us-ascii?Q?7k2v6STD4e80aNwPvRyoV3Vko63MPmTAntkP92qMoj01tyJsDf4m8a79lrcC?=
 =?us-ascii?Q?RK6FXLIdqMmfKynGsX2rtOICiitnI6MeShNKapumeUFwhzO4elaSLJDCJYFu?=
 =?us-ascii?Q?kBqipFdjLsZUi6kx68ZYffzdMW7WzEwBz9SzcoYHZUNcy739odwEfAXEx5SW?=
 =?us-ascii?Q?5sqCGu55eXvVCEKEcMuyXd3me1E4XQd7FooluFITNIkoI1EYSYg2HbbNJ1J+?=
 =?us-ascii?Q?qgYvl5/k//Qw+j40+ElHx4v6c/N9BSJF5jP1hmOiR3WFzgViYYxXAXzjtXyt?=
 =?us-ascii?Q?wJkSapZRmI8tFEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHJ7xSoJfVOpEuGJVwo+EZrGIwalAnub+fHRu3bNnIVrR1pO7XTVXmO9dVZ4?=
 =?us-ascii?Q?nlCxQil7nMOwYC+nrxZWjxfU9x+UxVN6/WYScvHBwkjMFgywJvTQAo1ZYxkW?=
 =?us-ascii?Q?CJR2sdESaX2zmApLX4puYKAh8dRJUyY4gi+lVIbzDqhnXmfBoF+YHNv2CMAf?=
 =?us-ascii?Q?0asJM347wpWOzN8wtCcTYpN5RKuVeN807WnNyMTpfZEc5rCA/63bbs2EDgsy?=
 =?us-ascii?Q?AlIgBmIrUIaN56InOqc7k4Cw8dJtcYfI9T6aughkkN2YMCURn1KIxTVAjKpl?=
 =?us-ascii?Q?VRfOqH1FQ99nRQGfLlapC2JTtry/6rQIEkfTxocpk5pZABFptcul1jThvxrF?=
 =?us-ascii?Q?NOCMaUntAxnYyIhnHYKdUVKCTzmkmJAmzY9z8qUlzlXNVuDdfTFUdzPgWlRk?=
 =?us-ascii?Q?mXoLDFNLwuRpkNMm1OSH6nnEHqxKNW/ad5KL8n4J3vWn1haE1fQio+0lx5A7?=
 =?us-ascii?Q?e9lAZiDKW+xmB0oc7I/G0KEaiORerNR9WpCZBUwXCm+uKIwBDzNsaPKE8BIs?=
 =?us-ascii?Q?e4lkH3JJEftmu2aXvyIswjA5uLrZxhJTv8T8z2JBNtzmRIUgfH7fR7vmy/Da?=
 =?us-ascii?Q?JHXbxSpGQs5qrTGxSuRRlHPbbgtX7p15MnFVrH4pz1GmddGIXn/aXiYg7wDY?=
 =?us-ascii?Q?IQVxYLLw77eWMjv1gaKo7lActyaUaaFROXIUpesSH5HHtnjg+bhKGOvIJ06Z?=
 =?us-ascii?Q?Ju2APOU2QnS9soLY7fHCV16K7ts/w6cGJ0GU+u+LLUJZLiViKTL5yPZLXYCp?=
 =?us-ascii?Q?D03c2LTtdDL38l1IIWx9vcQJuUK/QoFp6BSQApnBOebIg529VmO7Tytm/STX?=
 =?us-ascii?Q?VR4fz95faymiRdVnxukoojquhuF45Gw8TYZzIwmRy6xHBcxPg/poY4N6rbdr?=
 =?us-ascii?Q?ShGoeOIoe8uKbux3zw0YLAXtBZ5pECzS+g+s9UCYrG7fqq4sXhE/2Gy9whHe?=
 =?us-ascii?Q?z9V4HD/gHhrQr8HBwTtQ+17PcosTB7o8ZHVxlN/7Gfa6iJDgEbd0aYsm9eNp?=
 =?us-ascii?Q?mZw8Q0kR0QELEL0yXEkLzElnvMpaFSXcdBYUUmVFb25n3uo6cRtF+txAw9Rt?=
 =?us-ascii?Q?lFB8i/dyDcZXR90WHRMieiKO1ACP5YlAjYWSA29rdSytn03Hi1GkCIjfLeGE?=
 =?us-ascii?Q?QHisOgeon/vF96Pg7nYJJpQCG75QRQCDTBOYuY4Z4XvdExr9L2LXRlr0UYPu?=
 =?us-ascii?Q?zR+7bDdfgqt426GsW/3VHDVwK36SBbAdda9YPAAXYZ9WT5vcEHmAKsje6X9n?=
 =?us-ascii?Q?fO4mvGvyWU5A3m2ueJCHx/FM+uwjR0gqGushL54mWTiaiOAe/CdhLb0ZpnEm?=
 =?us-ascii?Q?ZjgWcJ8hdil5bs2OY9T1iVRS9bgpqR68wwEWuzlaJ4YuDOZ8V3KkCPMs8LCl?=
 =?us-ascii?Q?Eqxxw1pWJFWIXP+BOHo2Ud4NCedSOtB0um6DuHUwfIZZoaoxNeu2aLPdSNms?=
 =?us-ascii?Q?BTkTpaPrmSkKXzyiMHncWlLNZbz8c0K2O/eW5gvkv6Z3Rvc12cWncuN20oun?=
 =?us-ascii?Q?4FejZXSlPH6rRg4b7SnH5hjuOCgsyeqc17X1tkQwV9miwP51pHbXJw5BuVsE?=
 =?us-ascii?Q?Y030DZ5FVIk1SKRLIZoMKX11fzVQEaZMIhqxPf8rkE16FedKfZCny8soiV9l?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bd5585-84ed-4c0a-147b-08ddd6e0d743
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:33.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LospQJ6KGgD7u4dwNzFp/HSUHhpSwzHqJPvqVYIn6PceST8SWQF5J1S9G16kptwtlGS6sRi/YDpapNEoqYhVHxM3Nt/7kgfvmZ90dVi1DsQ=
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

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3d53e234b7..69dbdd60a6a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1118,18 +1118,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
@@ -1137,6 +1132,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc)) {
-- 
2.47.2

