Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4951DC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699F38405B;
	Tue,  5 Aug 2025 00:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GzHKM7St";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A5083FFF; Tue,  5 Aug 2025 00:11:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A349783FFF
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBWZ1KX+b1VPboU9K8eIMJ6UBISk8Ppwni1u06mMwQ6o4CSsb/J388uIzlO7i1+FPYAJjBmegFpmqM7enKRmyFG8MOVxDxVGMH424eXZ1PXCJ1CzgHkMd5V5hrR0O1VZDsHud/Kr+Eo3QHZwDw5dCqnJBcUQ2ErQeUpej1/vmQg7k2oKYne+e9etL47LopzH6WAbGyXshOg0UA5sOnXiANPGVziiA6g9JCgTMPqi+7KsrgOsuu3XOtBIufeoR2UdvXE1UDorOS8193j2iLmTGcIudzxJ1PnQZYsVbU9HNnGauCXQfbe7qy0yDeQzeHi4T36Fvgvqfews5qZ42CfNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq5JdYrm2XjyfcEBI0ZFspAzwfYbofy8P46bClyQSJI=;
 b=kONwTH5WvG2yoKGADEHKeYZFCYHjueMt2I+iycmX9e3bFwQsTKG2l9ghdEMlivLJs0ulWGz1fDWYcKiuDPjIxibT0fqRlhwGyAPQn5Kys7uPYea1NI2C/GaPg/4GstLECkXEKpS5k32PnOuR65guKkCqpe9DfAQhFvH1wFcS0Yk9KdgQKHPlC5r1p5Q72dppxVvi2tMT7CdGsULYyjrALkb5Y1PLLeobrT4JrOZudvcDudKW5igaPsnVk6QcO52CakTKT38rZPFD+CrqLqJlif9HQqSLndiaJdTFj1C8JIChcl/xNps9Qt1VgWB6Biy7XxZHW5wuEN2yJSdWPbVDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq5JdYrm2XjyfcEBI0ZFspAzwfYbofy8P46bClyQSJI=;
 b=GzHKM7Stk/1+OpNM8IrnhvhFPDBJQReSDhYy9UldVPOec2VEZOEjnVAiOwN9mmGib8CFU63+zbj2KGIr54chJcet/wQD6UmMd8kJRdO7//YHe8fUQY0t7zdEqW1hqz4NwZ6pdt/s6QCKXkOCqoIGRd7yF5uLUJFc3rnPlK40fqKvGtWkG+pInxtTzOorFHd6VUG/qteISe8TyT6SV2ZBe7zaI4sTmLPvHMm0DJiJSmErCCqe3VzbUnjCK4VeO19cBnRvDmwVQt59B5Xkk7uL0MCzhLQY8e6yLChLTZyRpkyRGwNXKJ+arDJEgLNkZZj2foK8UuSxqikiradSkXzE1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:34 +0000
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
Subject: [PATCH v2 02/22] drivers: mtd: spi-nand: Use the spi-mem dirmap API
Date: Tue,  5 Aug 2025 01:11:02 +0300
Message-ID: <20250804221122.1420516-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d27447f4-7760-404b-ff1c-08ddd3a3df64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bFzev+QJ5LgCl5zDc2o/pDGo4/VZFE8kVZccb3Y2MA4dbnubtWp8sU91Iy5c?=
 =?us-ascii?Q?mJZSFiU5bFOAwiMbWk61wexjrqR7slmOKON+x/F1a9tiyfg+MbXEWzr2MdTH?=
 =?us-ascii?Q?kY+yUDHvY9kR22mgE2D8IW3eNtaRogifNhrCyg951JChSoORKCvTgC7eYG3P?=
 =?us-ascii?Q?BseiIDUFF6j1zg8Hm17/sFSmDHh7s41Xr2Y/IGiEiZdwsYYZNileK4xkCr4G?=
 =?us-ascii?Q?kIbha9+mW6RwK50oLLNQObcgfKgR4E4Hv4DgW2QyAheCXKCgAx7EYYEZiozU?=
 =?us-ascii?Q?HtVpBzO6Bhj82EY7EefaviBe3j2DrBaCsI7fwLxeQQgxJ2CflVqwfPYqyssf?=
 =?us-ascii?Q?l8QKWKmrUDWEb49a+REq1gk0VTW/bticqtMlEnOWyUkkZryDn6Pc5l2dWhmg?=
 =?us-ascii?Q?PW6n1AtSw9MReEiVPqzqJveRslx2YtSQPMYnGFJu/bXA9+oFnwhop6799aZr?=
 =?us-ascii?Q?+viqZA+cbUVoOJU22yZwTJdkFzMoBnWw2szZriZJOpTwYfnS9yFDd2R+2Fr1?=
 =?us-ascii?Q?Zo2JtP8InnkJPTET0lovnuwKTkzOvr+TRYegmJAsZ8g7pefrDtENvgTwRSrF?=
 =?us-ascii?Q?r+uVejvUe7DgHLfW4in6mDnGFHDS1bfUOe4UWQfhP0lbd1nnoaiuSgXSJkQq?=
 =?us-ascii?Q?BY+SYN6tPNrH7tvW3vHPFCC4DOhxZ5eaMiebFQSGk8WgTIdxXQVIeHU1/Kj0?=
 =?us-ascii?Q?bys8XPJ0JWPasv6NdZYTadvo+uQHb1AM9pizx7MfhOcunVEF+aH0QzbJSbeF?=
 =?us-ascii?Q?SIzVjQdoCblUmbm9QyaLRmrmkF1OkjWHTWnhHqokZ9//IsOU4RPgczYDhrbm?=
 =?us-ascii?Q?9rOaQZe0T8wzq+t5ueXTbJ6a0q22S/NxVXx31Jo7c1aMMIszbDBbYIIQjBRz?=
 =?us-ascii?Q?sR5OCjz/mU8oYYwea3w1MgElGkOj6q8HgI2xQlrxNCBgmvUJ+AQHKPnw/Ka6?=
 =?us-ascii?Q?CfriFETu5bxSM+DTPLDrzsJhAeoF33u1vsnKSssbtuWi83bO5ZtO9VismjED?=
 =?us-ascii?Q?ZuAOsKfn6x2wRizZYFmhlJUmMIkV7la7M1FHHDNhUXeL0ud4M18IKNzWUB6E?=
 =?us-ascii?Q?wQ+8O6fWujdCr3etaIg5iUOMHTTGEbumGAaQgzpsx67MrDq2Ok9zPql3ROGF?=
 =?us-ascii?Q?d8VABlycU3sEqiI4Q7v65toDH10aC7N7qHMT/ba2ALVdP+uqfdAHYFpcRjda?=
 =?us-ascii?Q?hJHqM5/9hODzuOATgzqKiBpQRDf/SQG+MqVUU9TEFjETBQ4+X1Vxq6sJyY7z?=
 =?us-ascii?Q?uSWSxIC3429llVJn6RCTmuHnGsM+/MryOMq0zRdniSwcfmen/jyylfFMgaUf?=
 =?us-ascii?Q?MNuq66Rivc4YIogKjni+2YqZcl2IAQB7xA+CChEBaGwSxrT351WD6SVMjplE?=
 =?us-ascii?Q?UYV1s6licfxI9QYgT5Fhl+KvEogOZXfQYEuHGhSdIZK9q1lY46TAjfzlfhMK?=
 =?us-ascii?Q?8F3hTI+vi4YTXehnOcfxuBZc7ThIdXcmSjpmp7sfVH3PeyMaGR6qLUM6OjlF?=
 =?us-ascii?Q?h1S9VFpRZBFSIqg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4kvuqMtymfpHyVvQrag2bexPuzfQw5EiRGc4NM+b/2BrJofuctwchZBS6Fa?=
 =?us-ascii?Q?pj0iZtqVOMWgFscElWxCMcYJvLi+VWnOZ95Gb6vdkPSXejIL4kImyQczbVNU?=
 =?us-ascii?Q?IiyWo1d5tHuaKjDRSGxT4lakFzzG64YstHy8uAzowksvYch4UU7sifwYEfuc?=
 =?us-ascii?Q?rwIj2awqqG3EkAVFhKkoMAwmo11xWZTA5vJbShyb12hAgGN8y5iEEYeRHvL4?=
 =?us-ascii?Q?X2eTl/6/vEBbg5yBOEYBiDhWwp9sg0tL2OvdDcer1XCmtsT9xlbj4QdTq5Wr?=
 =?us-ascii?Q?n38JT6uS7gI7TDjv+UsWD1nwN14fIdOzw8FKCvzxmwZKb2mbYPgnSALZe9vO?=
 =?us-ascii?Q?BAH2Dj1zKioXw33EP+S7+YCI8TimV3Sv8pu5/EGPtueMXDp49Xgd++O8wNGf?=
 =?us-ascii?Q?vWFvtk3q2Kp1ZW4234MOaxS6wQP2WF0ZbzFnFD5G06eZw0Wxi2CXAQSVwdDq?=
 =?us-ascii?Q?BZC1klzJ+WDBurBPblLV81zVDc/HnR7v99q0nIV6VGZYf1HEdFEQXG5SnEH8?=
 =?us-ascii?Q?D4PLX7DwQUfu0VYznRapDzyzk6MGLrfFFjCBFv931bDoqkeb3v1ZCTDz5iOK?=
 =?us-ascii?Q?WPUhhMskG6DYWL5bhiTLYGS3fvw4hosA4gUlc69RqO795kXAkqwTlYoc485p?=
 =?us-ascii?Q?jg4dh9X1V19tZslgPJPCJdXu86Smk2oE6o3Xua5EYAd20QF4PWTPc3lFeG99?=
 =?us-ascii?Q?eqjMhIq6tPN64/uK1IBbFJW4rVY5a8hGZ/rFmjGsEYeoBP/u31aqo3VG4IxK?=
 =?us-ascii?Q?FNpfim/EWAU+lQoQSTpIvH9t99R0N72A6z0Ok5NFt0s1HCQZUesAyS6ymgv6?=
 =?us-ascii?Q?2goUJp3UM777MQjWOdi/J9UwCY8FuBbv9nKX5yIva3PfVIbYPwKWXE1koGRf?=
 =?us-ascii?Q?JBdi/brn2UE8VwdLY3WTnDVHW/BN/PXrykBD18PKP1Ky4dFL4cbA+ONXRLnI?=
 =?us-ascii?Q?kNfKw/54Xu8JSOQTsCz0Sr5LUE9VuJhVI19cZ3j0LPr4P/EVChG1AUylGJH6?=
 =?us-ascii?Q?gS7ckqjO0tfSEIxhycR+tpnbc/+Km3R82yoxAWF8quC0KilJPBSp8a5d7Tmi?=
 =?us-ascii?Q?5Aq1PErK7hHm2g2DSw2oWCLeN/+/sErkzSkPTmmDzG45wXF+Jj9UjbAbSIIH?=
 =?us-ascii?Q?rDvbVil9cHVHa0vkXXw4y/OXlKrxdTZgX39LC0sioBE5QpOTt94+AX58hX+h?=
 =?us-ascii?Q?MSdoxgaLDkMRed/tG9g3RCtcn9Y8FuhQB69xSjk3u+CCXTkK75sitm3hP64p?=
 =?us-ascii?Q?VOpPK/zSyIORKyXRpIKdytbD5JDpvBodzDteXosATEtocDAI0Y63xWrsMsoU?=
 =?us-ascii?Q?DkM+CiC9hWROa1O3RqDgKnW8s7FBWqq3Ux1BdwVFjtD0D/e1eGEg6c0nAiPA?=
 =?us-ascii?Q?41m5xDfq+wIauUR90O92OpvFgxEfpCj7wvpRNe8UABc454Bj85OGJOIUBzby?=
 =?us-ascii?Q?SYi4dpJ+o9M7Bgrus+fAuGUrpfJf+HvPSmVXG9aoirCIi1B2QnfwGTqrtTQz?=
 =?us-ascii?Q?IXO8zFmQBlSctQdetBgSthp50YDaFphI99Gx0+NOMmgmHRJpwXQImdT6DnTS?=
 =?us-ascii?Q?zPrZzJWN9kXSSr7VsLQ/vVpcBCxhcdiwdLRuqDRHh0/l3HR6ME6pznu/Xce7?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d27447f4-7760-404b-ff1c-08ddd3a3df64
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:33.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWiVYbaUAwrkmvCNHqWRlWH/DU31+c1lsz3fVvVeD2OFYulOkOLr2+brFXNtmakCV1G8ZJof8V4a5uMP9WiuNQenJguQpqTl6ff8QhGwloQ=
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

Make use of the spi-mem direct mapping API to let advanced controllers
optimize read/write operations when they support direct mapping.

This is a port of linux patch 981d1aa0697ce1393e00933f154d181e965703d0
created by Boris Brezillon <bbrezillon@kernel.org>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
 include/linux/mtd/spinand.h |   7 ++
 2 files changed, 95 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3a1e7e18736..c1b8b9627f2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -41,21 +41,6 @@ struct spinand_plat {
 /* SPI NAND index visible in MTD names */
 static int spi_nand_idx;
 
-static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
-					  const struct nand_page_io_req *req,
-					  u16 *column)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-	unsigned int shift;
-
-	if (nand->memorg.planes_per_lun < 2)
-		return;
-
-	/* The plane number is passed in MSB just above the column address */
-	shift = fls(nand->memorg.pagesize);
-	*column |= req->pos.plane << shift;
-}
-
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -249,27 +234,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.read_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
+	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
 	u16 column = 0;
-	int ret;
+	ssize_t ret;
 
 	if (req->datalen) {
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.dataoffs = 0;
-		adjreq.databuf.in = spinand->databuf;
 		buf = spinand->databuf;
-		nbytes = adjreq.datalen;
+		nbytes = nanddev_page_size(nand);
+		column = 0;
 	}
 
 	if (req->ooblen) {
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		adjreq.oobbuf.in = spinand->oobbuf;
 		nbytes += nanddev_per_page_oobsize(nand);
 		if (!buf) {
 			buf = spinand->oobbuf;
@@ -277,28 +256,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-	op.addr.val = column;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
-	/*
-	 * Some controllers are limited in term of max RX data size. In this
-	 * case, just repeat the READ_CACHE operation after updating the
-	 * column.
-	 */
 	while (nbytes) {
-		op.data.buf.in = buf;
-		op.data.nbytes = nbytes;
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
-			return ret;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	if (req->datalen)
@@ -322,14 +292,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
-	struct spi_mem_op op = *spinand->op_templates.write_cache;
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
-	struct nand_page_io_req adjreq = *req;
-	unsigned int nbytes = 0;
-	void *buf = NULL;
-	u16 column = 0;
-	int ret;
+	struct spi_mem_dirmap_desc *wdesc;
+	unsigned int nbytes, column = 0;
+	void *buf = spinand->databuf;
+	ssize_t ret;
 
 	/*
 	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
@@ -338,19 +306,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
 	 */
-	memset(spinand->databuf, 0xff,
-	       nanddev_page_size(nand) +
-	       nanddev_per_page_oobsize(nand));
+	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+	memset(spinand->databuf, 0xff, nbytes);
 
-	if (req->datalen) {
+	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
 		       req->datalen);
-		adjreq.dataoffs = 0;
-		adjreq.datalen = nanddev_page_size(nand);
-		adjreq.databuf.out = spinand->databuf;
-		nbytes = adjreq.datalen;
-		buf = spinand->databuf;
-	}
 
 	if (req->ooblen) {
 		if (req->mode == MTD_OPS_AUTO_OOB)
@@ -361,52 +322,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		else
 			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
 			       req->ooblen);
-
-		adjreq.ooblen = nanddev_per_page_oobsize(nand);
-		adjreq.ooboffs = 0;
-		nbytes += nanddev_per_page_oobsize(nand);
-		if (!buf) {
-			buf = spinand->oobbuf;
-			column = nanddev_page_size(nand);
-		}
 	}
 
-	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
-
-	op = *spinand->op_templates.write_cache;
-	op.addr.val = column;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	/*
-	 * Some controllers are limited in term of max TX data size. In this
-	 * case, split the operation into one LOAD CACHE and one or more
-	 * LOAD RANDOM CACHE.
-	 */
 	while (nbytes) {
-		op.data.buf.out = buf;
-		op.data.nbytes = nbytes;
-
-		ret = spi_mem_adjust_op_size(spinand->slave, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(spinand->slave, &op);
-		if (ret)
+		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
+		if (ret < 0)
 			return ret;
 
-		buf += op.data.nbytes;
-		nbytes -= op.data.nbytes;
-		op.addr.val += op.data.nbytes;
+		if (!ret || ret > nbytes)
+			return -EIO;
 
-		/*
-		 * We need to use the RANDOM LOAD CACHE operation if there's
-		 * more than one iteration, because the LOAD operation resets
-		 * the cache to 0xff.
-		 */
-		if (nbytes) {
-			column = op.addr.val;
-			op = *spinand->op_templates.update_cache;
-			op.addr.val = column;
-		}
+		nbytes -= ret;
+		column += ret;
+		buf += ret;
 	}
 
 	return 0;
@@ -819,6 +749,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static int spinand_create_dirmap(struct spinand_device *spinand,
+				 unsigned int plane)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_info info = {
+		.length = nanddev_page_size(nand) +
+			  nanddev_per_page_oobsize(nand),
+	};
+	struct spi_mem_dirmap_desc *desc;
+
+	/* The plane number is passed in MSB just above the column address */
+	info.offset = plane << fls(nand->memorg.pagesize);
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spinand->dirmaps[plane].wdesc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc = desc;
+
+	return 0;
+}
+
+static int spinand_create_dirmaps(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int i, ret;
+
+	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
+					sizeof(*spinand->dirmaps) *
+					nand->memorg.planes_per_lun,
+					GFP_KERNEL);
+	if (!spinand->dirmaps)
+		return -ENOMEM;
+
+	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
+		ret = spinand_create_dirmap(spinand, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_ops spinand_ops = {
 	.erase = spinand_erase,
 	.markbad = spinand_markbad,
@@ -1134,6 +1117,14 @@ static int spinand_init(struct spinand_device *spinand)
 		goto err_free_bufs;
 	}
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(spinand->slave->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_manuf_cleanup;
+	}
+
 	/* After power up, all blocks are locked, so unlock them here. */
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6fe6fd520a4..163269313f6 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -363,6 +363,11 @@ struct spinand_info {
 		__VA_ARGS__						\
 	}
 
+struct spinand_dirmap {
+	struct spi_mem_dirmap_desc *wdesc;
+	struct spi_mem_dirmap_desc *rdesc;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -406,6 +411,8 @@ struct spinand_device {
 		const struct spi_mem_op *update_cache;
 	} op_templates;
 
+	struct spinand_dirmap *dirmaps;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.47.2

