Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2043C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38688402E;
	Tue,  5 Aug 2025 00:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D1C46rev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4198403F; Tue,  5 Aug 2025 00:11:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C4E8402F
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv/mzRR1rAIvQzL1XtvWgJV2F2OFVHEh4KzDoU/hR5VihrLLXN7kYxjYa9m0oZJAViTBQSPjZoFxpsv49awPKrFgiODlIKk9Mzjdlnob1OKMYdlqU3+vLEeOX598F/jjy+jnaQrD7XADQ8OuUdxH7AW1LlxO9en5ZzTS+BobuWHRlaL73eTeVu4hWmaAzM3lScQ54xUpoWagL2gmvKAuYEX7h1GZlfYFWn5VOaSYE7CEsWprUEQHaYeU9bFIbdJo8yQtFoh/rbPoVvWddaLDVHPxjvlPv48/hqPRhFVB0i2WNm5HDSkEPJM0IVlfHlwo5/27a1HECJjjATStzQx9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=gPovqT0bY2l3g4HPK/+NwToMGoFz4vNiklmR6YyI/7yFz0GnYd+wFZoR03WbEUiAqqoHYEfc4Tx2d2uEAveKxUIqu5GidbvYvTZM+Gj2jKXjLF6dynb2Eg1lSh+FUEQX23bCzB+4bD6jIPDmUx5YJ4Q2sjHAxsmvlxM2w826dBigupYrkOQkkW1KdW3+GOwq1ksioMr7NvGvNZf/diYdLalrIqV0vJmWc/JQLrbLwTCMHgFD47hvw41hQwISIAQCz8oDx8mtspKjabuabuFG6/FApu1IOeUVRPURpJ5oirtrN349yt1hhv0D9Eg0V05By3PPBy7MaK9y/PomukkjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V59sYNd3d2AXL908cxc5+GDKD2NkSXybUwD6ek8+0A=;
 b=D1C46rev7Fl/ox5ES6/ePe3sgwgjdzVHUNketbJ8OBierYMP1eF4yxbLfloX2nBXz1z0vHhPMgdcinN9wPe7LWvtUd1cJ73V9kusJogDEi+RJhFHZFXUn7BcxneKmpmrbpJ8QLTgkK6RZdAp0iJzIOY+xu4318uEhnsjhXC8IhRXVWZ8WaThtj0YTrepH82kq6fCduGsr3pyiXAlbPD/qhmIZHuxktIxZsgqyDcNEBe8pNp1kTSR2ddiKNsfQBE2HDg9rQ2r8Vv1IZY4O9B94XAJjjaCPZkwnZp8nYx4U0ukKvmLzAUGppzxYOhs3gol4gjjLdh6sKv3hkYJLlQs0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:39 +0000
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
Subject: [PATCH v2 06/22] drivers: mtd: spi-nand: more use of
 spinand_to_{something} helpers
Date: Tue,  5 Aug 2025 01:11:06 +0300
Message-ID: <20250804221122.1420516-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: da42bffc-a5f7-4d6d-f372-08ddd3a3e269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9VuC48leu7ynPwTcFAVg+FheNcLMwBulTDJUrA9quzGjpTpqAoCD0+W+xnOv?=
 =?us-ascii?Q?SsXOuZV/CvtMJMwv2PZIN4c90F+KOUC0RYmfXmy3uoYgQ2bAeHBOsa/ZyNEe?=
 =?us-ascii?Q?VVDPZpBgqj5k4wTVwBHaRAM1UBTxOCeuoBPiAwXqcNRbU5fkOeIFTD+1Mcs/?=
 =?us-ascii?Q?KPMseXmaZoWbOz4gyQkSyOzLFJpfzMusFcRidgd4/mo6r+4xApsARr46QBKG?=
 =?us-ascii?Q?YJgexp7ywMczJC10Wf+yWdqaNns+BZz00gtvaEVcKTOkNtLZm2AvgJa5FVIZ?=
 =?us-ascii?Q?sBiVXMeq+B3Txe7E1SP5f5mJ+A/jP4PEdMkuRReK1uR/jnT35mFy/JGJdEWP?=
 =?us-ascii?Q?dpwYMzKh0D+dZ9V8miwsfnQTB16hfyBi6Vd0HWKqFgCIfwdUp2Z90ItG7qmZ?=
 =?us-ascii?Q?kYgXv8CmgWNxR24Oxt7+gDqJ3zUXKz22Gy0tinRZv/FmRipODAYzjRWNXWDv?=
 =?us-ascii?Q?J/Sa18PNKxQh88VCdOkhSRhgXn1qj8UC9yPbwkMqsupu8KOieBFNqeE4VuaJ?=
 =?us-ascii?Q?kn/o6HMy9l8ZIJPpC6nfTBmPapJimNZxwNmeMx+a6x5ntv33i7rxZxFU3Gkj?=
 =?us-ascii?Q?KRe7wQzfSqqvt2mimMd+us03jgq8YamLPzd0fGFka8+Vz1r+znPxcdFfUGAG?=
 =?us-ascii?Q?6ckdnrRhqkE0aXEOHNm4ZnPg5IfDkzjtPVq/XK0czwnil7+2DJ2GJkZS0COI?=
 =?us-ascii?Q?y3nYliskF3DHaEa5xDsyIqyMb943aexZy5RMWBJRXx6JLytQoTjXpU9C7z6u?=
 =?us-ascii?Q?NePOuNjpUHX4ccWs42Nha7iAuyEPGNJ3nzv07tl0Btr+uVsqjLm01SuwFIdv?=
 =?us-ascii?Q?ab222uUnIg26TuyUeakmLptb0keXochqlb4698u6So+HVqqxMR6q1Mnn8CTn?=
 =?us-ascii?Q?0kDONeyT8aWajvwArIb2DfW0ZikJ4bapevkZoYGk+QXWTfqShpZR5PHwCKmB?=
 =?us-ascii?Q?OuWuAI9OzZWb9gvSKXSSRHA4Y87E+CLy2VX5iiqybEZCkZiAXRe28aJ7jEIC?=
 =?us-ascii?Q?B8Moz4RxOeONTy4h1y5vQJ7nacDlXeRA7SAXxdiLkbIPYbHwY/jpEIBgn7Qc?=
 =?us-ascii?Q?9T9Gg2svhx7reJJmH1LfCyJXQvcplwHX2rcysJ92KDanFdYTTg+XXIOk3GDo?=
 =?us-ascii?Q?qKdj/VjUMAFZd8HFfANhk+CllKO+kZX60xDRP5jisXrNZ2e/ifUq8NwOuhub?=
 =?us-ascii?Q?cKwfQa6smfO/tbE7HIfwiCst3CsX2fr1wlpeGWXUMi/YlZ3cCedL9ZzsTNWt?=
 =?us-ascii?Q?OPZHXJsVk9vAi+2LyVVsMHc1LeJBsMgAGiYOO9iTzlDUbQTM5I4qeqJrU0ke?=
 =?us-ascii?Q?3qhIYhk8FNK8o8Qgn2/XTiE5zFUKXaHPGca5uOoVTK4gMzK0Kbq96w7XzDzS?=
 =?us-ascii?Q?Y0fwMx+jpXhq0CYgAquAlVfQ13hQ/f1XvPkD2JiR33Y+NiIt6qVpqdfPLXGs?=
 =?us-ascii?Q?bZ2/l/9QTV2yJHYeP18iqN4tF2m+bqhNC1Y5n6P+jT+9CSCEmbBHq6x2tpJM?=
 =?us-ascii?Q?X8i153BSlfc71GU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2UQ4Dt2K9AYnfzb+bcnX9pvYT7QNapvDRIL3z4kXgxiGSCilXvTEdb1mW3aE?=
 =?us-ascii?Q?qejwOne0b+8b186m3nazQy5b0CKc0jYs8+qzHLUuan2tp8Ajd8wiEQ9OLkGy?=
 =?us-ascii?Q?2/1w1tM9Is5oH4ypvWyeZCt8Ld0XG73vrr15BVyoOqS8F9N/qHxdjvwNwZMK?=
 =?us-ascii?Q?46QTlsnMGcC1goEE66+cOxr9aNeUnfncui4RkMy7fQo9MlMcoKWWJPsUzJlY?=
 =?us-ascii?Q?7fC5N/Hp4FTfrCxMs86+QCMa3NqWe2e0rQ65B0I3KP53fHVDQNaJIPk3/5bk?=
 =?us-ascii?Q?QWgiUFZl8jY2EiUVPFdpRP5S8iPktkTgCKyvOfUpLDRd/yTl0X+GCu69tjiG?=
 =?us-ascii?Q?GH2/504nQbyoHbf4ONFMI/zsFNoftsZK4jNYrxiTMYG1MS2/ZrCizibhaRbc?=
 =?us-ascii?Q?bzz1alf2+Mdg54DBoPTCaNCHfvuqWao/J7awhuJGkto1XFaMtbEbiavVfuKd?=
 =?us-ascii?Q?g6fZXHxoKp0ldGaspTscvYtkZGpmJvVdl5sbeZBEFiP3m443/0ErjWs8QqPP?=
 =?us-ascii?Q?2Ayf8lSBFNI9PrQkk/hyKE2xASZiLJAuWXCITubl3TznYg9NpwNOHj2Ehdui?=
 =?us-ascii?Q?NPA9bZf68HRDScKt2Wy6h//Iy117HocBotHElHT8DzE2U0nxDCmuERUqd9eE?=
 =?us-ascii?Q?YgzOUwASFebpKTVuxFoYJpItKPZLbO/TfSufymiMCuM/h+ILy2SsGZHI2QF7?=
 =?us-ascii?Q?Pn1XZBu9XVC3dHVBfRnWkVTjtadSyYrhhEqs7o2n0eU0+hau/km372e8Beu9?=
 =?us-ascii?Q?DGjM4q2iFqaFLqnnJOILHB/Qydrv61p3odHapyFhk5LbdMMrkiiphBAKA/NC?=
 =?us-ascii?Q?F9TdqGsRZ5i+DPJ6gr9AFg9FW3Dg+km05kfGZxq5XO/1JAgcKuUCUOQgSYUs?=
 =?us-ascii?Q?6ieDUE82d+rdmwky8K915Hpvrnq2KRRefNNiNiDFZruWcubauU5XUUYL72g1?=
 =?us-ascii?Q?iVT/05RNrLXmb2kY8GRis/1717lvn83CZBEIG/VKdYnMJYYiYg6Kh8SSnE9M?=
 =?us-ascii?Q?UHp5Rdn2cZlPON8s943KPMtq6UunExEwNHcfkkGPVoDqm5wxMzY01udQx1EM?=
 =?us-ascii?Q?0lrTahE7XCVS8mnak3Qk+lj5s/Np2a4t39J/EQanfKWj4q4H92/EE1uaWi94?=
 =?us-ascii?Q?v22jRM0Vs3fdk1B5vY8Mkdg7Y0UTsC44dY4dU5AHvkhO8Wb6IxyRfNBVJTEQ?=
 =?us-ascii?Q?aiM1cf9p+KmkVs06uBC3tYtuu2D8FrbhfUFqVbLxBE7AyWsCyErBF8nq3v23?=
 =?us-ascii?Q?paE+RUhNzjJn8E7VsKXRLAQEyH1XaCRXpruPJxUJQgUkcRYDhgRJg36tXRE6?=
 =?us-ascii?Q?q6zTES8DfNbUju7aBOKdRxl2+4IkO9CI+dObiC8exgW3UD3uK04SZaDGQNH/?=
 =?us-ascii?Q?UbxXsuWJ4KymU6xGGl8Ar2NMop4TydX1yNfgRg7tPfzgRg1rFIgSNLXjDhhl?=
 =?us-ascii?Q?UMLckMwEP1cGTPPEofNg5yqpFC1LpPUDEjMEbJZfEmO0rWKmESBMW58DogdX?=
 =?us-ascii?Q?LHjkxGinVt8lLtxr+3pMi+mq7Dk6pnmZQZdYvfkBq9SmTSgwd8u2B3AcRu+x?=
 =?us-ascii?Q?Js4ol3COgJmaa6B+x/MIRHC9RdgJFCuW9j5P/a9ffr0Nxp40KAgARdFsyDBL?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: da42bffc-a5f7-4d6d-f372-08ddd3a3e269
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:38.9683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLLpaTyH5BLK6HapXiqOvAybDh9ZNxX22tGyVBxcFXkfJ+WozCGtDhmFbemNVJgsRkcV5aW4fCiZYFWCC5ushzAPovU9qOmCAhcjMaV7LGM=
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

Use spinand_to_nand() and spinand_to_mtd() helpers instead of
nanddev_to_mtd() and direct access to spinand structure fields.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f99568050fb..c16d3954245 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -236,7 +236,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 				      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *rdesc;
 	unsigned int nbytes = 0;
 	void *buf = NULL;
@@ -294,7 +294,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 				     const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct spi_mem_dirmap_desc *wdesc;
 	unsigned int nbytes, column = 0;
 	void *buf = spinand->databuf;
@@ -356,7 +356,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 static int spinand_erase_op(struct spinand_device *spinand,
 			    const struct nand_pos *pos)
 {
-	struct nand_device *nand = &spinand->base;
+	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
 	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
 
-- 
2.47.2

