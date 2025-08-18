Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40841CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A3280B9B;
	Mon, 18 Aug 2025 12:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GFZE7ir6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17C38206E; Mon, 18 Aug 2025 12:06:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E2880194
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZXzYM2UaNO8uuHnVT2NzImzcaiPMUPzPdEyxIYyEJktG0VJ/uyFbYZL/wTbUWOpVBxfdkQKHtX+C6EYI3N871u8iUd8jJcM5gHEgFb1V3h5uUgJO+q4hsiuxpnktxhAbbKvOyzePMQnWY3Ms/cmSB+lYwBpEsnaLbhH7iZ8vi/AcgCkdNchU0nKkBdxybRzYe8ifDOBM78kOe8GLW1jlrvqqyXoi0HYn2+ySaqWVWaOdQPQ6yft7bV2SeNecN6BHkCY1WPmV3hVminWjtJBTIHnT3rwff3b4j2cvOT0/3bQ/N2b90BYy+hHHyEVVz8O2AOnd2tQoQLbSwG+qZ9i5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so3JaRXoE97P2KXubTs5w9RqyCvt15d9FIsZZTYI0YY=;
 b=Wruw5uLfPah5WOrOZTUDHFxHETamqzr+mTu2h2vRL77H4JfZgSED6bVQsiBGeXyrAp4HfIA7qQejPnqhdOHQmTJycLtgBzqmpGVcCYt/rcI/z6EBBHBOGYGzH5TZYZrl5Oy2PEUv96oaShTvZTqJSFh3e6D4LavnO9nAdWcauyDrXQijzTz2uP2hSEOfQuyeoaJmjmVKtPcfyzXrPfByd7yrC/yA+DZN5QItnXUBuAjZKquICf8mM3QiHkY+6bgvJFBRNfKdv3ubWqS1YrFq0jjCn1KI7pBO1gky42qMhmUS/za+vl2vhmgTNxkT+dgaZNTvQhXQ9ZvV00XqwVhY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so3JaRXoE97P2KXubTs5w9RqyCvt15d9FIsZZTYI0YY=;
 b=GFZE7ir6egf7sFJV2kMMRVEqQU3KBNlXTTMbwNfuO6/tLWno3otUnlZUmKl2YBtqXdXOKsdKP/t2sstNZNjFKghYEzdIpTCCYB1fcCyQq8Nz8Cwz5oswD69j64B+9QrO4SKn2X7813msszClbR8wZ49NMQvtICc/ULOc1n+5NrUf8Rv9QDUArohK2HfPYrlRpnIySD/V38hF8RtWtKTk2lQ/XcuOSKN+5NNBecx+NFauHdGIXQ/aMRi38CIgiC5+CmDvRxzp2SO3SE2+SW5IYLenu1LDs0qI2/3efySh1x74XVKhDfv7rRogMBQV8eermNOaCaNkwZD7p3GJ32NcoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 02/21] mtd: spinand: Use the spi-mem dirmap API
Date: Mon, 18 Aug 2025 13:05:54 +0300
Message-ID: <20250818100614.432931-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c1cbf8-2f82-442f-6b6d-08ddde3ee524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86+KvM9m0pVqnGFAgPyNeliIsm4pEHkFEUjyNguq6a4hdRGJ2eJ2/mj95+gB?=
 =?us-ascii?Q?+eVQJdnZNpFurI3IRwTugXxInpi23od8EiGSvuQNXMZ9unNjxcRPkA4e5n+H?=
 =?us-ascii?Q?UhTF9V4VPNa0IeIOdo3Yghwwa0T8KJ+9r09jQlLBTLx1eUGkOXvQq6JudYwN?=
 =?us-ascii?Q?f7hjUZjnn8IV01Ax7lo9M7w4+osA4uf9+F2rowseKr9fFVOXJMizsI/W+N7d?=
 =?us-ascii?Q?nC8BFkjuxBKcbIG5P55f1iccW3RdUZhRPmfhuFjpWxBCXrFRKJcJs9jcvmpD?=
 =?us-ascii?Q?H3WVUoWlKpzhEZXW14bwPKsaila1VrhqGngXhweS+0oIxSD7yCRhsRtkAKth?=
 =?us-ascii?Q?TLWVgg9D77ll+JRz/I4ZRHOiKk7YQrEkQHuSXP1CN2Nj3DlkSdmpKUgStb61?=
 =?us-ascii?Q?9B8uXx33XP8r6DARD2nfQ0kUg99VOuVy/YFckICXTtpNlIfJKE50QnR7AhGg?=
 =?us-ascii?Q?j2Q8ZhRtiJm6W0Rrkdmopvb3D8SDJ89Zmy8Ih47nAWn1umY4LI9Oh1UO2yH9?=
 =?us-ascii?Q?AnxxAGOTpYBFA1HxI8QrDMRQo74yzaOyrK8xzmvhsXkGf+8n91exHIjW+ot2?=
 =?us-ascii?Q?5jbKD4/ZgArDjlFvU7mn6ByvGq2th3eyOm9yMrQIOJdQcTvm5xyiu5lHcJ2H?=
 =?us-ascii?Q?8JpLvH0SnXKz7Gvq63emdWk4ZBq2/AER+bqzmmnUL65wepE21MUi+sxUX0tn?=
 =?us-ascii?Q?q+A1tDlgU0/Gs3Q3DI2KSs+hs1AxcY3SMDe1M/ZsnEmcOERPXZ/IlP6Dcul+?=
 =?us-ascii?Q?sK/Na9cHhYLOJW4qMh4HAMcq9uS/kLugmf42rjmKw3cXdhwnlTxVSNMjwQN/?=
 =?us-ascii?Q?hA+S5Zs7e2vZGuFPoQyKWZ5YWo7vWJ4ibu0Qmx6CLYm2pGTwBcOp4pAeDOmk?=
 =?us-ascii?Q?qOrNCX8Erkqv80uggQftZeRuD2czlRFjraWQmrKM9CHxMyW/eNJFMSMpDMG5?=
 =?us-ascii?Q?FT8GnsU3B/GBbFe26kcSYmdav3VlIUni3hAQqdAfZFLcK4MdPtY7mTrm5GPY?=
 =?us-ascii?Q?6nE3bI6cK742prY6GEV5LY/IEYiJvZwmM0iGNqBnFnz9unfQusVPLKaP8tFX?=
 =?us-ascii?Q?MN1l0CYWVbhuSRXU8zkOe7RyDn2P5VOImQkWk6oX2/Tos6x+OQh0dyxnU74S?=
 =?us-ascii?Q?d7RY8mmQ8lyMF90dbjDfIoDEpJC/AeERMduc/OIDxCwmz7funCYZMEL3a6iU?=
 =?us-ascii?Q?2xJVHyhueh6TqAIn4wFfchefR+g2CZrASv2SrX6epu66m1WE2Ow/y0RLfZEx?=
 =?us-ascii?Q?sWe7q5J7NfFFphJ0GDLaa8IRLLpeiUembkbTBzktFWmv2d6z5cwRYhSF/c+s?=
 =?us-ascii?Q?j+YT7VhAx4/4AqFYgk/qP4VPiB6OT4ZdmL8Urahwi7eCXEaNrN/Xw/booPRu?=
 =?us-ascii?Q?XPnDFEONSHwuHi4WCgiUiJtwmL7q52dVP5n0dJAHYdjCYbH/eTTTC4eAqkyp?=
 =?us-ascii?Q?YrZQ4EGD6cW5VBWvqhTK52q/AOzCcBUG74yNCBEhDs4oSXeTuL/HcMW/PfRW?=
 =?us-ascii?Q?ZYWbQRy4HMMqn7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDzq7h80MpT5ejO1ApcXhkBbzhK/BRbOXQ1W8lQcEDpp4ryQDWv5V68kGnTn?=
 =?us-ascii?Q?MJBwUiolFYD+wD4pYaDWSGzLJ/GfO9ncoLgDY2ICJsdTSugEFZ6M2+7U6i2J?=
 =?us-ascii?Q?hOtLKbFnbUQG0K3oE1F0a3EyGh5xYRBJMRJv8klz6hl8WnKb2EmLsu8NR0cI?=
 =?us-ascii?Q?BaCAoWjwZEKk74Sn3Jtji36X8iUEPfEsBjW5u3PCacpQMknr0s4NoVSVVvV+?=
 =?us-ascii?Q?Kk2b+slRJdQE3YFeOn7q4ViMMv/2+1ytiuyk/U5TUESiKaEmOg7xJewer3QT?=
 =?us-ascii?Q?/a9H0L76IS6BmRj/67qRuHgOxT06iS416dKknwjEG45p8y7IwtUcAi2SyjEs?=
 =?us-ascii?Q?bPNeuIDvBC206LCG/N4gxDN2fY5P9mLg2inTOB3FSIuPEZ/DUBB1WMw/R8ak?=
 =?us-ascii?Q?ywpHUWyaE2KVV7amOFtEI8UFZRcF7F6L0gyyt38q05O+fL0mCoJ7hhNKJx2L?=
 =?us-ascii?Q?pmPERzO8vgo9MrPuae9+WyVM92vkujLEQ65GFuJVU8FqmfBivZUqRSRyN6A1?=
 =?us-ascii?Q?FCEpEHlw/NQz+jIPMVYPJduuILNiOx8nxjIpX0N6sGIPYtwsHSOPmicnPh/8?=
 =?us-ascii?Q?0og8YU1xG/I0tkigWtBdEldwlBFFIhgh6Zw8ZHTAsSMvaXvy+3/vIfIgUCBE?=
 =?us-ascii?Q?sMdYfureS46wFxqnbM9SZOwCq3xZth9dUL9Mguuso3EZ/X4U5p/760aUCzGA?=
 =?us-ascii?Q?QVTqG04DeWQG0MS7GPksQBGiE7sLH3GjSLVDnoL0c5px51Tx7T9j8CNH3Wp/?=
 =?us-ascii?Q?ThW15CDubzyNl1tv16mKq0yMBPRSWUVzKGuwUPwI8YCnwRUYaHdf822IIkgZ?=
 =?us-ascii?Q?SqqNaHndqaCi/CL4PH38AvFEHua2V0u9I7l1GmrJtTbERGoRyx8M+fOH1Rvb?=
 =?us-ascii?Q?x03bOLda3vyLNShi3Xnx1HxlFhsJjq39ifUZ6ceM1qQrNo1ie4lEf14UsHW/?=
 =?us-ascii?Q?hkwpjX0RaqcD7ZP9EjOPBBjie4wTOH+XpApSZC16H+hz1PBUgd4tUXhCIMio?=
 =?us-ascii?Q?xehqkJb+pIMF698ZvxlZTVzkl0zql7WmP+Oo8Tx+ODDbHiwNWEu+o8kOH+/G?=
 =?us-ascii?Q?xjQl1uanhfvapYyh8Mw1tpxjApbCLIgkTkG3TNkvpU/4uL+WbfVBWxGA4ul7?=
 =?us-ascii?Q?u3Pb9SMDfr5qvZs59Ljls0XGgfYOJD7IB+Tq2ZE61kEndRyQoKEo3cJWye+Z?=
 =?us-ascii?Q?6ohWBeqEDa+6jYn7evpZNK3HKCX90HPIZSBNGJL/hzCOG/FiTyf6T4rKAzZj?=
 =?us-ascii?Q?pZ+5dfzuEJOL37YDbOlV0vuTnEoNBBPnUy+hDilflejAQpq/j2gITrNdLg2y?=
 =?us-ascii?Q?//x0fN5Pcu1Kis+wKUiTGyvnP2mSY8afrCIY3r/TYmqF+m4XP5oFDkI94vnt?=
 =?us-ascii?Q?i/2gqFxBlKZn6zhaHobIp4mwUhxO5pZen8WT8zrAKJx3ROTS+yEfwB7+cJnR?=
 =?us-ascii?Q?iuI2yoLrX+Bd7yYlhKWuDLgIunH2Zuvq4BhqHW3mVrkGVL3hgypQ5M2DLsEE?=
 =?us-ascii?Q?ZQ7g+T2PThpzQybMjiP/UcJYr8zyvb5X2uKtmKynIHZIrs2BLoQn+Jo19+Qu?=
 =?us-ascii?Q?68EQO1F8uO89sww6qV5Dm20Rn9jEEwSXlupcnmNELCNQAnJZUb8t6GSPFuCU?=
 =?us-ascii?Q?/KSLYOMp5P9oUh/cJAir/CQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c1cbf8-2f82-442f-6b6d-08ddde3ee524
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:27.2079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGF+7JqRL3lOJ6WfCR1BIwiXkIaTDja+dfJqvxZ/cz+QvXV17AqjM1DSqwpNanIN4gCHGFN+RVACyTY8OUySZ4U/lCG9SNnSZHX2ztaMUhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

Based on a linux commit 981d1aa0697c ("mtd: spinand: Use the spi-mem dirmap API")
created by Boris Brezillon <bbrezillon@kernel.org> with additional
fixes taken from Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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
2.50.1

