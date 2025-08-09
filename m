Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EB4C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D6D83D7A;
	Sat,  9 Aug 2025 03:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="POjqsTbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5167483D7A; Sat,  9 Aug 2025 03:11:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A881D8480F
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFODhqPmxVNIx3vr5LghCWTOunYMDQJnxQUiKKQ5HcU8+y7iZMyMKwm5J4NM2OVMwQNTjjJ0wiwCXf74qcjLin+Zu24mzhggPGQ9P9s+Q48MyWjGwApqg5VRpmdJMUrY/cwGgZb22PvSz/myv1YSgRARXhMCpERzWsrw0seuu6YsLW4sqwOWMK+QWiKoh9yO8GFd2Ao8TEikWdNvtitAvTnpwU8dGh9zrO0eHvasUdmxSxDkUrOMbnFMQp4tUpNPonyTlQOBOR1+FdEGTrTu8giwNcED/dah2TzuhNUTUyi3cJf/mj1FsfRiOLGjrAvZYiXMKU09i48ZSA1DuS4yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9noEMsxNdJdraHyfoQK7t2c+tt1ruaOImZDfHtsnqss=;
 b=jEA7QNXSNxhzlGY3VmD9376QA2S/4n1H+vs69r/30ochWZeuH31aWo0/3NvIrVrFrwRihlFi4UAiN3L9LMBsOlRJnG6qp0Xml+F1jT/jS19OhZQrOKj6wRlXxpvYogXKtoBnHh26G2s3hjde0zeDN3qRu2IaFi9cjCYTdn98NuUNz1Nv8Tj0HojMeG5soQKinyVgfxmYcTjvUgDWulDPLVyjVGg51wTHKYkqcYSaMxUH9WUpEVusLZ2/KFGWmXTL3eEM4kMKBbiQhOth2vKSz4B4nd91LwkUJqz8Q3nho6552oNZ2Fs8RB/6nGz9EOljKjBkCtPg5ciS/8dnZ1UpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9noEMsxNdJdraHyfoQK7t2c+tt1ruaOImZDfHtsnqss=;
 b=POjqsTbiX3o187NuAmUxf0bCDpEh1B4XdH1pn/MQA/V+X6oc6EuT7mCM2ELkoklww0n6MMOwqUM8xIi76Yw1NGGBwpEbx/PWZfTU2sVASGmMNnb3VhLwf9E1q1LVOryNRKdvvePOXIdN4ibWjv4kupY7qTySGH75nZ6ir9vNhX9kSuhZaLkgj2B2atWdYql8I7P5tXQ3GM1lTuggdQ80Ku6abdMQOTbaWP3figg44ob2Gk6OL+zx/k8AED+w7dSkxPpPbrtmC0GQchC1cBdrPB/wXto+nTh8QiQzaDPnUJGxZYrk1j30tPgwTySU3ozXry0JV45lYZUjAOCxZCGFzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:35 +0000
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
Subject: [PATCH v4 24/24] mtd: spinand: repeat reading in regular mode if
 continuous reading fails
Date: Sat,  9 Aug 2025 04:04:56 +0300
Message-ID: <20250809010457.3125925-25-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2fe80c91-5913-4922-513a-08ddd6e0d8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NhXU8+l4GKLpF0UWhv5wsRqi5CYD+KsFexP/pRQONdzNoqJ3CZvziYEyei3v?=
 =?us-ascii?Q?zBgLZz9YwbIOLsvfyltK0CCr8tYpCyDTxxM/kYf59Yofgwh3ponC1Ms/CtZA?=
 =?us-ascii?Q?+Zwq2DODZM3lDSQOJEnDEP5a2Tp4gQ6wzngYSJzm+7n9B9BY7HHdg+/IOyI6?=
 =?us-ascii?Q?fr7LX/tTzs9CfizIOvv44WlE8gS+nYE9Xb4T6HWnAJ6BHhFPdvRHkublp+eN?=
 =?us-ascii?Q?tzG8SfwUdzGDQc1WY5+GPIl/3z+nzD22icTEjK5LyUr2rv/QgbuR5NG9fBYE?=
 =?us-ascii?Q?CtMvG/wPI48dCE0PQ1SdSGRAUfhXqSyi/FDCmi1ApC/QfBoSgrEhTenFxAI1?=
 =?us-ascii?Q?IO5qDjPdNLTV2yzAVyiwQVt4GRXH6sYbguwZpOTu3cybXlpkxNX//jKyL8QN?=
 =?us-ascii?Q?TH9knAgeVCGQ7x6GZOsM7hf2DbSUju+8oZUFk6l/tosWUL0F4tkcAP/TUT+p?=
 =?us-ascii?Q?MG046xxYRJB9DS7To8n/2A1PmfEa8HUkcI4Sy1Yxo872nADexM0fodqVu6gL?=
 =?us-ascii?Q?fkNhkBxMD4xrX4LWR4lJO42PBdUJkF4sAluXDVUNNEOWGh930nvyTkLH6bZV?=
 =?us-ascii?Q?f5GIpR2663hlYAdQB/6zUgd7CkAYp9ok25wZJzB3czt9X5ti2Gy4z6nQ63x3?=
 =?us-ascii?Q?BCZb5rItmBsV5H4jDekJoQ3TsBQ/gIYX46o505SnvKwQ0QNMWrHAmS0XqQ+A?=
 =?us-ascii?Q?9MgTjHYokTgRby5U/11fnweICQGssP95iz9aJsB6L3Q7QgTDNh4tiLv/6+EO?=
 =?us-ascii?Q?Px/llus3eBtO3i56BOL8Gdt9UIBNw+rWbJdvC5IxKYJoi3e1EkwaLNaUaYcE?=
 =?us-ascii?Q?AMiiMHsufGZp/RFSy/vArRbViAXai/oS+QtNFVWAt9JTSkM1dDNoWlWwvNRT?=
 =?us-ascii?Q?0/RY9Iv+cOmpjAsGmvL0VboTBOML50rQGA8DYG12P+64ldD78R/VDEQhR4Bc?=
 =?us-ascii?Q?SWYH9uOBckEJUc+MdtbOfofTyyvIXJKw8Yo5vf1XDQNIwyKIlV+xczFXMXtD?=
 =?us-ascii?Q?/T8LUu60ycqhzWvptW5aZwK4aJYdr6hlKFiS8K4SRKFELll/pOV3KqXBpAPx?=
 =?us-ascii?Q?CqIKxy3XWDVdlVSGTmtUi733SPOv5ZiO/CuTWqB8IjZBvVwCnOfj/Eg3AZsq?=
 =?us-ascii?Q?ccNSVaE2+jC2tXdpvuClVT+RDAyJiwibBbTZYuLGwHwvZa0tHCo+HNJuLjYw?=
 =?us-ascii?Q?ZD4L8ClOszWWr5Rav71QtXeXT/PEoiIVoy1E0CTAyO5k8KN/B4i37co/rSZa?=
 =?us-ascii?Q?PcTvx1rgJhu82QO725k8SUFToMr/7t8SqgCEWjzSET0jlyPNF3yXfW2s7Rs/?=
 =?us-ascii?Q?2gVX+XZAJUjgzFMnZ7xZxseqQb/aA4UhODc0dm8gZ32yRRGJvl7QvkWWSxsS?=
 =?us-ascii?Q?NBlrpjflT8yfRrQqsXk5AfeGVaiUBHzqCVlRD7rAUL7q264EM8CDwa8dKVFA?=
 =?us-ascii?Q?91+7V4gKeZ4ZFBoteUXdAY2K/4dDX3rMigW2qY5eCV/lQyfBpptLgrLQwF+a?=
 =?us-ascii?Q?NvbFZLeoI4L3sG4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZIRjxMnWAn+tTDS9S9CilxpswiQbujdnia5gMbmrtznsT2IjpeSru/yEgMn?=
 =?us-ascii?Q?IMfDVWDzvVESCEzG2HGQd/Pr4PHgSzp3AKhc9dmCEKDmJNPsVTpVFQPjEaih?=
 =?us-ascii?Q?D3FI8KxzK2n6ztG15QVRBlpD1syc+YUBia//fHPa7T89XvnTOijbsMGOvyui?=
 =?us-ascii?Q?0m2ilrMkAz+WiyH4ft5WrT/CqdJVP9n20DJr7R4SZdOsv+NlsCiwAdCLwTsr?=
 =?us-ascii?Q?w+MIA/IwciGfqyth3JifSf6SMHOn7llQ5CCleYx4ynaMYi+sj1xTNO05jlgW?=
 =?us-ascii?Q?TNPAh+IGiMdSOsThYsznFE+5i9Hxz+TQ94OK1XaF6KPEaZcrCARh+DA9Z7rW?=
 =?us-ascii?Q?lHX8baZG/ra6MjngUFSb9ImTEmTtCpt1R+Nn0mSBXRdghiI5kVbPcTtNOlPY?=
 =?us-ascii?Q?clW1vZlThYTyIXuL6NrCBweU+b+cXTCYsPUu2uymXaaSABePWINoKWJfl83g?=
 =?us-ascii?Q?+TH3mVHu44+uFsLp7ZL732FqjRdEoyaZH/aEictvaBqW0kdQAsDYNsChRYqN?=
 =?us-ascii?Q?C5/LRjHVXezlGZQpoSKTNUWxNDHW7T1EAqJSf8o6p3sPqnVh6BdW4TqIo/tD?=
 =?us-ascii?Q?b3A9+VaKIRm93ukPPhqiru8sK/PA+zuv3BRkfEaTrEQ3GXfbNH4bldZ21sLh?=
 =?us-ascii?Q?LGbA1K8IyvSRvWE0pK5kGE+T4DIIau6R+2c9rXvcMVO/1ryiRqxH2PBoIDre?=
 =?us-ascii?Q?0iZ4DowJkzbEYaMGrjm3aGm7Oe5mdZbk3lYGnYJShBaEsX4Y1XTxF70slHH0?=
 =?us-ascii?Q?c2tw9ao/XpypR99tkasqdAxeQRqlykSOsNHZnCA9skChyNwM7KmcGLMMuLq6?=
 =?us-ascii?Q?5a+f+M/WZy1iBqrzehksgso6Rih+y0IA0cgzotaCnjkWFj1zKrj7diRgWiCh?=
 =?us-ascii?Q?tjNYX0ovWJ7H+YOrWrKMijQGQPsEeEgDBZN7tihnsZUOUwKUB3ONrVYuBeUE?=
 =?us-ascii?Q?rb1cSIL1LNr8Ejid6b5PjcfGEk3hLv+hCB2Yr91C3QkoRycvEMW+glNPdpJE?=
 =?us-ascii?Q?9ZRv6Kdr0oDAPn13+EHcxOa9vJ/7ADBnw8PGddjXNsItVGZUflW/sOpebLMD?=
 =?us-ascii?Q?QuGj1OTMGrQVGsw8dOVSo3y1Y1NdcXfp8J6BsjnX7nEESiG1kuGlAG2XmgwT?=
 =?us-ascii?Q?VuJ66+vf+H0JjgEgrNbUNayeTZ3EJ3a0finR/Q/ma+ln3LASf8KZChGn3h+5?=
 =?us-ascii?Q?ajEHSbUHlBeX4mUURM9txNF2h03OFxQ4BoMCFTNbs1ww4duMB8mxZcwZsCRV?=
 =?us-ascii?Q?Pgi5bCLXYX2Aqg47I148lyQg3SP6ZRyQcmOtxVRhrqk/rUh8tdubawOYBPZE?=
 =?us-ascii?Q?6Sf6l+V5nDHA9V3B6wQnbCr7bDBoo5RuCv2LPhigsSR6t9ZULc1NZIUc5jZD?=
 =?us-ascii?Q?IckiTGZF0XXmYQ4FqEzwQEbdihbixfvjos5BttW4nNsnRZpbCT4g29vhFbrf?=
 =?us-ascii?Q?Fc8ivPESp5i8k+ZfBDwT3ITg5bk1UAlW0wtvlmVgT5ETDps2UlrZMT/lh0h0?=
 =?us-ascii?Q?Aedqd2qoNZwKfBzMPwOHOLOqzx/LJ++425QLDEk7BY7k7EnAiA4SHBEgKbp1?=
 =?us-ascii?Q?wgsq+uo+n/eFQVq+Xt6pJtJt0DqtjRJP8vvQWS+NmGYsmCtM5bWr1ycA2l71?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe80c91-5913-4922-513a-08ddd6e0d8c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:35.5517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ea+X/fIrPnkJWwlDWeic+IDvqYVIyz9KxVgjbtuLxqzSDstW/HPV+o3MMVHxM0/FKyk7LWXdoTEtv0Xow+e32oNEnAjAEJN8QLfkQXWHqzY=
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

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 40 ++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 31926e37104..72ff516661f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -375,7 +375,8 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 }
 
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
-				      const struct nand_page_io_req *req)
+				      const struct nand_page_io_req *req,
+				      bool *controller_is_buggy)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
@@ -427,8 +428,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
+		if (nbytes && req->continuous) {
+			if (controller_is_buggy)
+				*controller_is_buggy = true;
 			return -EIO;
+		}
 	}
 
 	if (req->datalen)
@@ -649,7 +653,7 @@ int spinand_read_page(struct spinand_device *spinand,
 
 	spinand_ondie_ecc_save_status(nand, status);
 
-	ret = spinand_read_from_cache_op(spinand, req);
+	ret = spinand_read_from_cache_op(spinand, req, NULL);
 	if (ret)
 		return ret;
 
@@ -774,7 +778,8 @@ read_retry:
 
 static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 					    struct mtd_oob_ops *ops,
-					    unsigned int *max_bitflips)
+					    unsigned int *max_bitflips,
+					    bool *controller_is_buggy)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
@@ -813,7 +818,7 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret < 0)
 			goto end_cont_read;
 
-		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		ret = spinand_read_from_cache_op(spinand, &iter.req, controller_is_buggy);
 		if (ret)
 			goto end_cont_read;
 
@@ -890,6 +895,8 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	bool controller_is_buggy = false;
 	unsigned int max_bitflips = 0;
 	int ret;
 
@@ -897,10 +904,25 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	mutex_lock(&spinand->lock);
 #endif
 
-	if (spinand_use_cont_read(mtd, from, ops))
-		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
-		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	if (spinand_use_cont_read(mtd, from, ops)) {
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops,
+						       &max_bitflips,
+						       &controller_is_buggy);
+		if (controller_is_buggy) {
+			/*
+			 * Some spi controllers may not support reading up to
+			 * erase block size. They will read less data than
+			 * expected. If this happen disable continuous mode
+			 * and repeat reading in normal mode.
+			 */
+			spinand->cont_read_possible = false;
+			ret = spinand_mtd_regular_page_read(mtd, from, ops,
+							    &max_bitflips);
+		}
+	} else {
+		ret = spinand_mtd_regular_page_read(mtd, from, ops,
+						    &max_bitflips);
+	}
 
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
-- 
2.47.2

