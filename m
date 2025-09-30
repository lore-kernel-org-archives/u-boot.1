Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE5FCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C27837E2;
	Tue, 30 Sep 2025 02:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="idoVZwuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C3883621; Tue, 30 Sep 2025 02:21:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EAE3835CD
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFC38QyWWG7VvTIuj4NhOPcusbcFHk1ZvDnBlxkJ6pni7K6qZqQnM+syNAzPO5GinPEfVSiJCFXFzjj+DUl4lSfPc2byOtJufGiIMoheSL8amSmc7GPwTgDA9MIvy7RD+g+dsRIL5hXyssuWxCqhb2xJuFPAxopAzEOjraqupnN0gM2cijEKAl9nTXDEQGESpUtxcmHdCUNLqt9prWCDC/8BQIF87+Tabvs7GVsWIqqIYyX9YtrTwCo83rqjcGMUlNV+o4a9pTdHT8hFPfTqoo5gUvlHrCWrDFRBq2RVbfvJ4Qh0a9nY9eCmbeCQR9PqapJdaF80IqxPShijRJvsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgUUA7IkBZJVn6N6JQZ0p6bFm5ULXMacmaSt8UMc5ZM=;
 b=ZxJio/0B9YhQCS8CO55K0AAOX54Nsq7iJV56DTU9o9baGv9pXurXMBe6VHG+3BYtWEf6EQgNoNrhGtWXNuTyxkD7damJ52TWpIn6gbkHgDOMCewo40sy11OKsJoVKy3EKgwCtu5dtZneJAHCh8kmDWQ2SDI//G0eEzHpSuZx85Fo3tOIiiCFgER6oOT5UGdCIDcR63IVm5MOZUr6Pv8MH5eetf2/2pclyARXz+46TgYk2cQaO//VcWfyc65kw8L5BjVLRivmVxSA0lqU2DiLtQegRoNKR0WI5RjhbIe7PhyBVnYf9CTwunXtGO5DtXmaV42t7SKcd0wyyzmfDsWy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgUUA7IkBZJVn6N6JQZ0p6bFm5ULXMacmaSt8UMc5ZM=;
 b=idoVZwuJkXVt67yP5mrlGFqoY37d1XHQa8gehGhluQk7z5MObEne9wICWYUNDvBWC6VrBHHV+1cwm4usSlsMOi4LYUP3Cx56FuPz1o57unugNpRRMHNmBXkWJiIVMnj9lPdbF8prYzwvk1IhmG7hBO2BSi3gO9VSaUWuSfZnd9S7bcJHhkY7WTfyhFB8q9x4O5O6cQ6Mux2YlAiLHORQ1D5GQBwfV/Kg5vOXVR+SHt+KlIxUb8qxsNiqfgaH8ZE9EDBI40Co6SpCAZQxE5oe4m/jgvliZv+YQUdhQf6CYIvJ8I2Ism6b3Nvj3vk2CkBvVafsUgl6iTz+Lbyc4di+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:41 +0000
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
Subject: [PATCH v7 18/24] mtd: spinand: Enhance the logic when picking a
 variant
Date: Tue, 30 Sep 2025 03:21:03 +0300
Message-ID: <20250930002109.3600886-19-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 26b93d43-b14c-4e68-7fc4-08ddffb753dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NhEMzXFIxPFYdBLk3rq+7k5jKtQPeIxS8/yPAw3PaNCT+9yHrBNc0H5JTmpz?=
 =?us-ascii?Q?9Nls9vJOhNfV7tKDR0/DPYgBJlSq0MHFjaUTbkU5lzMUrC+2tO9wKl/5tHmh?=
 =?us-ascii?Q?3GP0eX3jX8qEGqm5kscMvxo69Vx0wRe+Xv58LS3fovGd71ZScmi09xAxhj6Z?=
 =?us-ascii?Q?EzBzWasPJMsxNCxE8DQRl1Oa28n7g0QLWTdJF+IKWD52yWU5PaqoGjkk2CZg?=
 =?us-ascii?Q?MThDuq/zEd9jZ5/Q530rghbyjkAzWkI7MJm9MyrrxpOLA37WOMik3PTrgbxP?=
 =?us-ascii?Q?A2LqUb0VdJYczuG3SnAqRRNqEaex3eKrTOOQlAZjhuuVbHwEXHBTlzbYho8i?=
 =?us-ascii?Q?qG5Z2bSpl+MsdPsEZPyKrm+la2d6ra5EDQkV5HHtAdd9Lkx01c+dOwH0WXkh?=
 =?us-ascii?Q?lc7LXgwAit4iDY2lhl9jyWQza02ofLg+CH5es6p5fhHQyL88BDFDWkW+E1xW?=
 =?us-ascii?Q?cTV1bSs+2aoFV6FcNSnoxFoiaAn/HwjCC8p2N9yOBczeYE1LxGf4OdoX8GOQ?=
 =?us-ascii?Q?Qh5wt2WYIeySgC4z/LxCyfvZxBQHoZq2JXecJQ8tStG0E3WLgJOF3azNl51K?=
 =?us-ascii?Q?O3H+/VlrZe7h9KJ56gACnVVCacZ+NZ0oNfMk9kj4nltCR6A/SqwvoFLWcHrr?=
 =?us-ascii?Q?PfAz8f3Zpp91+tGY6vOhv0HVkNsMok6ijxqJwPDb71Rho2ssyn8uqBAeex65?=
 =?us-ascii?Q?OvidDxSGVb1cH8CpMySqQIXIQgF9KkygYfPdZTXewvCfAg3ZOqsNiRz6YUd4?=
 =?us-ascii?Q?tlfbTvyuup9sFKetIuFBNGLBZasgSo9QUMT6MtIUnOrvDhw36CoxGeCar0VX?=
 =?us-ascii?Q?W/WtpVF5cB8opIY5jiQp6DZbV62yul4VqGktrfflR4An0/7iyDCRXf5qdYsZ?=
 =?us-ascii?Q?Hk2Zvkh1xzRskcU55M0/TAb7PWH1dlBUubO/fO2csHskj7iBTpcd/fbVPVvd?=
 =?us-ascii?Q?OZre+xDCwezjPlNmGYAZraeCIY92OaFB95r/EVtoYtYYsRyMJB12QjfNuCjg?=
 =?us-ascii?Q?s2GzK/UPcQG0ykEVIwg05l3GzzSjyUHTdWv8cEmvIZ9QHH/Pr5149Z3wi5WD?=
 =?us-ascii?Q?2/C8mvgPhwaf2t4c3OHhM7AHUJ4KDMj49rD8s/rs/7VRJ4qe+YRGuw42Ks3y?=
 =?us-ascii?Q?Hb20Z3FY2E98JRXTzJa9+8NWFadbqImuonsv05J6xuvrZnSLRS042Iiu/Oh/?=
 =?us-ascii?Q?8KE1CBwTKffquWSI8f1/Pos8wPD6VK9hTQCxCN8KXjx/5lHJy/0zG+ptylRB?=
 =?us-ascii?Q?3nfk9E8rP8gmKlwmmIMD4YQ9tYAs9bLSWpVzKGg3OEtzYz/ZF6+hfJxSCQi0?=
 =?us-ascii?Q?GLq/FgqzU9pSIW3CjmFx3u+TqzvCkxRy1BdaGEFUUKiCaRSJpiukntEZD5S4?=
 =?us-ascii?Q?P5Ps0DoMaLLtfh+zhIqkRMLOAbS6lny1Jt6EhRidBcTp/c33GrE5wb3xIP7k?=
 =?us-ascii?Q?eq9qvOSoVnbhajPI/pAiDs0uvxbbocuJXQWMvaF9bjYJJESOPKPVLNFhhjZ8?=
 =?us-ascii?Q?E1CTVlKlONvkZEny4IPG2eC0shXOoO/Trq4RPRiPbcTm7qCfJDz7AbVFpw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3JR5L+sVT1xoIkp9pqRvw5vKHLOpR99P3LruYsKzIp8/+lYiB8NEtmhxvVMF?=
 =?us-ascii?Q?xXBpieAHhcN9H553O5LtAXZkJmGPXS+Np/tvJzbTwO9qz7YTa9hYGSyp1T0H?=
 =?us-ascii?Q?O/bIDk2jXCEtJdUaEDORocXOBr4Pc3j2u8uPLtGC+nHdq2D28KSyUnxNC7mD?=
 =?us-ascii?Q?TCpgL7bw/5C7EtUXu+/pFZKOGri0GSUCgbb0E9ncrsn1PiV+EsGZYGJpl2BG?=
 =?us-ascii?Q?81oXaJNBxKiow02bWI3upFMUM8zuNrfqdKZE1XGvfrP31c6WF2gNQB8NszUw?=
 =?us-ascii?Q?4QWpqfKwy5+EJiCJL9R1cYiZeHsq4SJQuPqin5kGrn6na7eWgtYHC6LMyzpJ?=
 =?us-ascii?Q?vFBU7GAg2HPddEyy5Vwj4UOfEFC2vm5UQv5MChsFJkOus4q1Tq1uGK8c7TvS?=
 =?us-ascii?Q?BhbjMBDLeQGcLnxQUw8YaLVrwe/SiTYCShxwnrqQVB8/3KLgWksWNFgBY+U7?=
 =?us-ascii?Q?OhhoV6O73MS7ase74qVrFACZWFTpOhnfZgKgXpksK6sr4dYaiTMXPpU3MnHT?=
 =?us-ascii?Q?WVZ65kw1pd2z5TPYppzqF4C6ZJzB7nR0mKtIJ5UDVavQTdFqWzNtkvbeBclx?=
 =?us-ascii?Q?Z8CnDORlCfktimOnHz6x3Xkdpx7XLgoI1lgWayrbOoGcWYdIEEhLOtiSFY5n?=
 =?us-ascii?Q?M3rraH6T4Wmc4AqwBgx4OMGvz7bx4vKBgirCfWDKTqUi4ppVY98N/uDQ96Mw?=
 =?us-ascii?Q?lOdAKERtZZDuvvjO5ehzAInXLoLJOC5G+PXDRB+E4nWkaw8GEEHR8XfPVDkp?=
 =?us-ascii?Q?H3s+Njo1Jk7STNkD6s1fpaSQwzZVW1bEWqQi6sNagQwqD3Rk9XuqdRe58aRD?=
 =?us-ascii?Q?otr3nHDFPUG7gSx8pQil5g8u5tNb8Nb5muiEjVCpFziWHT9M08SAuAhPXUrc?=
 =?us-ascii?Q?DyYunDG6BCPdT3WAFLLdyWFylGbXy8Cyb2fpEmljWXUcZozh7TdiyxmMrrfd?=
 =?us-ascii?Q?4BBLH7J13hW7Z3W5EUnAskk4iShaGd9c+QTcTwejNmond8Dktp+Jom6c1Ej3?=
 =?us-ascii?Q?VVSOUUayoh+hTAR325X3AbIKuu8VJuFxf6O28EglbE0OVSPH+9E8F23/dTEs?=
 =?us-ascii?Q?poqt9UmRQos4mWv+wRTe5ZsVuET/KEHkjCe57MapEE1OHfBMDjbywZY0rQm2?=
 =?us-ascii?Q?C+ynUyO7YJkIxgr48OzFgRJThargJB7XY+r5UMKxNxEGCAD7exiMHqgGii20?=
 =?us-ascii?Q?V4OPQhEi/AGfgw2mnOxFSgVLp0/lq6YFjeXQOt76/j7HHr0rUtVqaEEVlwP+?=
 =?us-ascii?Q?k8a/n/mNvXLrnMA+tHJKXU6nX8DWP/C01+Hcm6tD+7JZWHBq0DXhE/nFMdo5?=
 =?us-ascii?Q?J93dTCf2GNWTR3Y2ty/Sbc4fC+sxLWXKbj12QpKo9ym1nlh78q9TolfBvpOB?=
 =?us-ascii?Q?givop0gp5jSCe77xcUycWeHHG1jxnhAzRkiWLgpLDJaturn9i8XsRDztSZrc?=
 =?us-ascii?Q?yl7jujbzarn3p51oG0CcB/WKgkHrXlLN8jFmgSeVc/hW54rzq6lU2c0kg+wf?=
 =?us-ascii?Q?Nx3eVunU8NgI2F8hiCJq+Lbq4Vuy5ZPANs7Qu2wxIH7ODHCjkouanG0WNlkl?=
 =?us-ascii?Q?JmdTRVLNwWaYLPA/gr8Fd0Dbr99//DHtyLPdC5hIpFhp7M97bxSGBptENMsW?=
 =?us-ascii?Q?EmiGNuxaPntdgzaiSr3Vp7c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b93d43-b14c-4e68-7fc4-08ddffb753dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:40.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWzTp6ePfXKA/aumPY7e963m4bdbb9tPfhWGdF0OTioBkFzxxfYP7xXTpud+/c0M+gbwSRwt/j9oQ+PeDJwZlvBhvPSRiFNGCANzHG57lMk=
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

Currently the best variant picked in the first one in the list provided
in the manufacturer driver. This worked well while all operations where
performed at the same speed, but with the introduction of DTR transfers
this no longer works correctly.

Let's continue iterating over all the alternatives, even if we find a
match, keeping a reference over the theoretically fastest
operation. Only at the end we can tell which variant is the best.

This logic happening only once at boot.

The patch is based on linux commit
666c299be696 (mtd: spinand: Enhance the logic when picking a variant)
created by Miquel Raynal <miquel.raynal@bootlin.com>

The code was a bit restricted in the functionality since not all
required functionality is supported in the u-boot.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 13 ++++++++++---
 drivers/spi/spi-mem.c       | 32 ++++++++++++++++++++++++++++++++
 include/spi-mem.h           |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f16d3b0335f..daf6efb87d8 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1266,10 +1266,13 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
+	const struct spi_mem_op *best_variant = NULL;
+	u64 best_op_duration_ns = ULLONG_MAX;
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
 		struct spi_mem_op op = variants->ops[i];
+		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
@@ -1286,13 +1289,17 @@ spinand_select_op_variant(struct spinand_device *spinand,
 				break;
 
 			nbytes -= op.data.nbytes;
+
+			op_duration_ns += spi_mem_calc_op_duration(&op);
 		}
 
-		if (!nbytes)
-			return &variants->ops[i];
+		if (!nbytes && op_duration_ns < best_op_duration_ns) {
+			best_op_duration_ns = op_duration_ns;
+			best_variant = &variants->ops[i];
+		}
 	}
 
-	return NULL;
+	return best_variant;
 }
 
 static int spinand_setup_slave(struct spinand_device *spinand,
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 6f06650384c..db44a7b26eb 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -499,6 +499,38 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_calc_op_duration() - Derives the theoretical length (in cpu cycles)
+ *				of an operation. This helps finding the best
+ *				variant among a list of possible choices.
+ * @op: the operation to benchmark
+ *
+ * Some chips have per-op frequency limitations, PCBs usually have their own
+ * limitations as well, and controllers can support dual, quad or even octal
+ * modes, sometimes in DTR. All these combinations make it impossible to
+ * statically list the best combination for all situations. If we want something
+ * accurate, all these combinations should be rated (eg. with a time estimate)
+ * and the best pick should be taken based on these calculations.
+ *
+ * Returns a estimate for the time this op would take.
+ */
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
+{
+	u64 ncycles = 0;
+
+	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
+	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
+
+	return ncycles;
+}
+EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/spi-mem.h b/include/spi-mem.h
index e68e2b50e85..36281a62f77 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -392,6 +392,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* __UBOOT__ */
 
 int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
+u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
 bool spi_mem_dtr_supports_op(struct spi_slave *slave,
-- 
2.51.0

