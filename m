Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4734BC87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9918F847AD;
	Sat,  9 Aug 2025 03:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eUlAVMkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8864E83CD3; Sat,  9 Aug 2025 03:05:17 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C2E83CD3
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/G8xtTcAXqm3dg5XmrSYR2IlciK5tCTqD0SqsYS2XYHWteXEnRYhC9bihzmCj95tuPwmT42U8oTAZp0YNW1iKjzn/O1vFfRpxlRN3Y1+d5qBYohW2q7fZtO8JuKBlP0WTT5CcKM0HMpewOmp5bpxyF3FOQwInJdqNkjznxPgW2yMx4uY3JR+juXn9jSFE/gbarNIVhzdGcCM8ixsPoCSza2AignTMf4zn5ib/qwPaX0eWustFFr+c2TBnlQyPX8dOMeGOXduUog70fQjO2Mljto5jschjtRDC6Z05Swstx+ww72KmHKi6OZn9+bCHX3D+cQL50BfF62+CJsD87ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuQeYAbGaE5bdzyMlmgPzUNWpvxArYooH+JXUcsJSlU=;
 b=qxHLnGi3OFTz6B4hBMPv1/xAevLNX5Dim4bXL36txMhc9Md4VmGhfWyLvYDRQXwnqhSoUPgTLoDkkhCSw3QaAH3titu3Trd4BGSamynwxz1Uj/OqQDj/gRgwHFVYW+1azJrXkLZwjz4ETy5Ij/yQCz7jVG5Kp4RomHVyUa75n6d3Ge026fUZm6Ka2LQhNK/a8Fn41wzw1pGrwU+4jtlPh2kbdW4boLK3y6mWHXL8m0g2PCyADudFCWuClQb2q+mP8rfFUz05bSwOuJDdjzLDItNHiZQO2CrGqRDohKilkwj1ZAMyjxKzs+pDKpWNZngvddee1O/bDUwg9U3Chx7Rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuQeYAbGaE5bdzyMlmgPzUNWpvxArYooH+JXUcsJSlU=;
 b=eUlAVMkvP1HUeWZvQj7Va2pKchNhOlW5JIaWXKYQJUL50gG4eXwT5dW1uam+iburhRubNuqb8nG/E7DqTUmHUcb+yQMw6q6SvISo193YJr8pMDIsE8Ay52qn3r4SisAI6SH9wypshmJkmO1X/gVbN+DgFvLXv4IVDqh2i5NJZlRjMAih2ksKawQMb3iZOybiIWYm3YqP68DTFKTxvdzaE0grF4NaoZgB+FOqL6GBxuV+ehce7bVxrlb7LNh5yfXYyzfd5TwzKZmDHhNNk8OvA20UtWvIEgtdlb9IrKTTgUqih6nHCiLDZm2EOIv9Mgsxi525rFO2Lp5kxVwulIgDdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:07 +0000
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
Subject: [PATCH v4 02/24] mtd: spinand: Use the spi-mem dirmap API
Date: Sat,  9 Aug 2025 04:04:34 +0300
Message-ID: <20250809010457.3125925-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b14bad-ffb3-40fa-60de-08ddd6e0c7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eJsysJudI2gpccowiSwO3GL+isQGFppp60H2pTpRqbp8NrT6X7njVpM6ZE0o?=
 =?us-ascii?Q?8msGf+LQNTtWRdz4SalyFFKK2JOhUnYEdGaH49H47oYzEcPC5Irvb27CZXS3?=
 =?us-ascii?Q?U1TpqZh7d1PEm+my+T+RNs7KXtASSN/UkHFYNMNdx6iDMiyv8TFuc0U8JAot?=
 =?us-ascii?Q?HVClxsCpZh0rbamJDvgy5eU69YdafFF6S/LCiQtq6MvKBXOMMLvTQELJ0Dmc?=
 =?us-ascii?Q?GBNG9ZclYmhsqYXcMXybKYi1XqBdtGiANRgZAcfJtxvNP637hcaCmt+SwYNJ?=
 =?us-ascii?Q?b91eFIewsto0Uv813qVLt/5I2+EGT0/umnrnCfdIZbIcSbmg5zPuxOP1VjM9?=
 =?us-ascii?Q?wNUVQTA1EwjyR31J4lIaRIPvHmEYv8T7tEFkESwLi6mfv6qu3n1MJBsVuGcv?=
 =?us-ascii?Q?rZapTPALY/ZEJ+9mSkcgc9WNgpOl6Fl6Rmxju7ebLRD3gXJA/0i3QeK9Jgjx?=
 =?us-ascii?Q?ZfTIfxqinjADPFlZvpxmIe6a8iSPsqY+KxP3j4iAc4nTF2gtE9j7oZhw8ZOk?=
 =?us-ascii?Q?TkiMNgfSlaPA9GhF3vNFkksjYPdyGPslJRJe97WnCbu+Jqqe3EpD00EVd9u8?=
 =?us-ascii?Q?GPzUrMxah939c8QLuWJaqXS2pJGC7cowmGM9AxN9fYvcug2QTLOM5xUl/KQt?=
 =?us-ascii?Q?L/BTX/8TM0H50srflyUaU7Y24fy7cq/5Mz514Uqrf0CQqW0Kw2NhSNT5qa1b?=
 =?us-ascii?Q?XCcncLDJJQQWyyH8vxGk1anEytxZTZt4KkAyP8MGS2r0BYSi04l+TZzKDJH2?=
 =?us-ascii?Q?/rGz2QiSEj8Dsfi/WT6QYstqviAra9TmUkpw0IpOSjfQC0vcgfFqOLwQKcCI?=
 =?us-ascii?Q?PoPZAkfrtFNQX6GoK1lODtZ2JzX7FS6ooLlbeFf3R2Z7Uh4Rf+7jOolnaBWv?=
 =?us-ascii?Q?u2wyn4naZGaDD/QxkNusnRY6YQeT5QxWDCPG30uKC+2OBjlfbRftfd+4KAiO?=
 =?us-ascii?Q?y77oB/3iEl+0OxRk0aa4w0+KZlxPbJDX1T37qZs4SyAJUYgp+rdN1Vc25wAa?=
 =?us-ascii?Q?kJgPlaynC4vj6zTnGnfE8UJDX+3PxhMdPG7Z/tamO6gk2znd1DxX2aaOGyDr?=
 =?us-ascii?Q?tSNbaEczXhhrfBeBSXy+1vjUbmNxpDK0vouVzNixWglk0nnl9ZXXJoPJ1KjW?=
 =?us-ascii?Q?Mrm0BeT9WOhGDO2gqQ+7uHUNeE3MxxJ5Zk8gXwdVTDnO2iSGhX/cF7UQ32jY?=
 =?us-ascii?Q?1lYw6N/r5DvKatmGwWb1h5oDS5dO5B3ARc6KhThpSNYM62HABrYu0c3wscrH?=
 =?us-ascii?Q?AKdDFNHkf/GRkHt2N8RPFHpzf3ucPIpaIBJAmIS6j/eNxeGCINiFGEEEO8h/?=
 =?us-ascii?Q?5PVbqNx7U9rTPnr4G1U0BD1uc4IGeTHMuQNnwpPdMFZ2Q5cVhhiyPynC0qCz?=
 =?us-ascii?Q?9K2XvZ0HUFcFL5FlzEIOFW3E/tCUcPztC67hB8DHHHYHYI5wD6GZ65x/g+UN?=
 =?us-ascii?Q?/D301p0gOsdbcFEM9E0+8v4aCGNW6U+hH0NbfqsD7Tvz0OumShL+N2DDVfGM?=
 =?us-ascii?Q?uQvUbhHWI22amtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvAlbjvvBO84TQr6aFJnTxlFwMaHcSosDZKLDxIWToLjJHi35+pYUO7nLJXf?=
 =?us-ascii?Q?PXkLSjKXyOnu6XopuSi2OKu0Zkv/dGblyg7KGy7nVcbe/ScOeFzy6vK7v3Gn?=
 =?us-ascii?Q?bB/9p9XNbZR9DIFxfNaMXPXMyP12HuVu8rYFOQSff/NzpWEzBwGfsOrYG//K?=
 =?us-ascii?Q?kmtJ9mv5pyDHISdXzHbSpInG7IRGpSEKgpnL66AbYX+EY49llGGmIkNUQvnM?=
 =?us-ascii?Q?5m3FiEPaEz4lLyhsIbjjElRXYruZF8E9WXdFNYVDwVpN7yXdp7CW/ngw1J2H?=
 =?us-ascii?Q?G47DuWC3ekZKQb2v5uNUHAkUjxGMpSmzkXYrgZxOuzgJzjVTpc3/gj4u/bzz?=
 =?us-ascii?Q?7L2N8sgnPCeQPT1yGYorhOWK/tcYL1wvUezJeEi24j+o4ICMB6FgyIC/KN2e?=
 =?us-ascii?Q?AvOLGV6iv7OvSYkwuRJajthjd7Z48y3VbRbaQ7SnzGP6O8tHliHEJ2f8rRdF?=
 =?us-ascii?Q?VBlRWRPQ1eGRtYIFraSiKZZhWdQkkHc1wT5U1gT4Vc7MRatSxl+sm6bvTsXI?=
 =?us-ascii?Q?biftFX9Ac0vQbSTo5wIWscMUFWFAzPDoKbYNdONVR3QgGsU8z83HvQu0Fn4e?=
 =?us-ascii?Q?5Q35CbRvRPSMgfAogiJP3gWJJqwBtnCCgDsD30wtl0mDxIiws82IoTw1HH4/?=
 =?us-ascii?Q?lhnQjQ7CJKK++PJlj/NlnyVJN2SATEk1SMSnst1va4lxhGutKAQEXZyI1BaR?=
 =?us-ascii?Q?wIfSyIbt7Ug0EFC4Fn1f63aVg1DrwI/4akFvz32PopdVs3cp5Gw/J/t9iBtg?=
 =?us-ascii?Q?PLgp/lbOFNQ7NoDp9Gsaa6L5oEU8Mi/CGy0TYBqhCJMphNn+crUfwxbYo3Dv?=
 =?us-ascii?Q?heeTNJGlRykTKs4onkGuaESD+RfWOTCiiTRO7XUpsYMB/Y181W5gL81blSYt?=
 =?us-ascii?Q?IcJwmnZsFZ+tYZu2v0RbD/rvfyuMQrEv3AvYuJNVEqLsnZgSKQlwNNTDmcSA?=
 =?us-ascii?Q?0ry2jtcrP+OqzGqTx2p4eIINt2W4LFpCpFiENog1gbCSBMuGT41VDdBWNzkT?=
 =?us-ascii?Q?cXeCaX7tzxoHgUy8wL9HChutVFjc1WRJ8qRkn3NhKMcbzY8YHwuByImtoOs3?=
 =?us-ascii?Q?Lei2cFXW86mq1spQB9/pkO54fnJN7XD3CyE5KH31IHYgRJTPcQx/DvFzy5Zs?=
 =?us-ascii?Q?6kHm8vLCQo5A49kB5kO0I+2vxn6NwCczHU7pDTWFAnoSjbE/tgZ98BdvXGq1?=
 =?us-ascii?Q?XQo//6Y9qAnLC3ZTR+5lyvyRLzNxOMaNJqdjIy9uNZltuIoVFx7n5pi98VQB?=
 =?us-ascii?Q?YLIy92rV4EHebihPRCxua1kuqAfWRC0tLsWVegrYaD42Y31sl6NrEu+hob7f?=
 =?us-ascii?Q?B91tUWRFhEfPPpRF4nocaifJRWCtk1REqn3Elu0YQQuCe9wgNDM7A2nWUAzG?=
 =?us-ascii?Q?bWa2DrNeaRNBEYpL9x2VRMkas8j2j7aluC8M5jezq/enimisdNoIdIIFNwHp?=
 =?us-ascii?Q?vnIK2IZED7P3ANn6xTRda91StnVC2rtrDju5qF3dVLgcweGLAvkiKpI4O017?=
 =?us-ascii?Q?Zk5OA+/YgePrOplnbLn1nAhudKllVHHVMsGyJtjTZErXVJIBZ57UPh7qD68s?=
 =?us-ascii?Q?8CHZr8I2LC3WzrjSC0VmasxV70kGhtqVyeXGDUzdyyhfdEvkweNxXS5MHLrc?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b14bad-ffb3-40fa-60de-08ddd6e0c7fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:07.4242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ8DLSlH0v8PyqZATl7OY4+lGLyvTenTEw3lEqDiTkH3chrpuWDapCohtjHHUlxKIrn8HdNrduukYaE3e9vZx5u4/lb8Qb8z+WGmVJTeqBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

Based on a linux commit 981d1aa0697ce1393e00933f154d181e965703d0
(mtd: spinand: Use the spi-mem dirmap API)
created by Boris Brezillon <bbrezillon@kernel.org> with additional
fixes taken from linux-6.10.

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

