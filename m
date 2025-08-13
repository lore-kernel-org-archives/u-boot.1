Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2435C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CD083929;
	Thu, 14 Aug 2025 01:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p7Il3iIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E48837E2; Thu, 14 Aug 2025 01:43:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B571838E5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk48OIlkeqk4lmbf1frhiGqVa5dLBfF3Pi9MH8W8W6rTa3dUMo1gI/T5MgCU75NiJnMebjbLDRb9pGgYYffvU3dxZcmAzes7c/htk71sceVXpNE1/82+x0MPVmktCLxO6i1NJ2EEro8aA1Mo+yJIqI3X8U+aysVye8kQPcr2aeQWheSolYLXZrr9eWyRHAo7hXtngls4bV7ShJMTBUDsrkZNuF1zKGmETh3qFRWw/PiN6LEzM78l+jS/bIVTj8R6rmnGlCXcpSTAr5V4X40aPSb85vKL6S9kFxY+NeXXuZBNB/GKI6NJnGIpUiaSct0jbEG7MnkAU69+YsQL515rvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz1/fxBxcm6DbGIGhIDoasDDAttTM7NNz8TdrkEoV9c=;
 b=fGp1pLgnl7WEZE3Oi0XCTJzFGqMZ/T21x3lcNGPprcoBqgVf2lg1Ek4SifRi19zIPfvcdqO/vPBRmpbAiCqW7L4JhJBdjhG/Z6gUWVLHMHXY2MmA7dubDPqsWvEYiOdBQCOKNxD6gny2vGoSpYGqbGAFogPczVn0BJH8/3SILhpLMogbmIOYmjk11WlHS2LgHAZvKSOAE9XfNDaYccncke8GGYOjeT87OdPniQufLtzDrky9dvVMrPDOQFKfrROrecXiClKfPZSpDQ1x+L6U9UM7uZeqQSuGSqnSC7uE8UxH7Q12/yrREpFVC+pvHipbd3oTzj+pd8dr2jqV0mZRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz1/fxBxcm6DbGIGhIDoasDDAttTM7NNz8TdrkEoV9c=;
 b=p7Il3iIubcLutLG7dVApiPPLdwUjT/C/IQ45yhMSnF2xyImzHENLAPclqCB6vGZd8021gghp7BQAtWdjyZaCvQ4FZRGTFfYjocZEt9qKJ/GdcHIhCTULqArH7LhjpNnftVpvZDi4Z9ffK7rAF8k4uurLt5uFrAgWENFlQuxdw+1j5PmzQ516KdeMYIpwPGmurx4vxLBJzRvMJ1ImkGg5XIUYLweKtZAXl8BgcCfz3e2Y2HSTy07DVONK++wmOeCcTa5riahyA2kYAejC270AdDQ3mK+byKkBeDaVIKVcVgLaapRDXg110GjCZNwoQM+f/dToFhbXhi8urERg6NdgaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:48 +0000
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
 Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v5 19/21] mtd: spinand: propagate spinand_wait() errors from
 spinand_write_page()
Date: Thu, 14 Aug 2025 02:43:12 +0300
Message-ID: <20250813234314.3945708-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: d89fa146-3ceb-4263-f2ad-08dddac34012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vP7lWejrbyAj8km8duCpw9slB1gVxdgWc/4PGLIqVGHdnCe64UinusK7TUOd?=
 =?us-ascii?Q?Wvi7mYD9/jM/1sCqstQ8ozet2ykIPpgs7IRUxPth9UmrM8BN+NE0PcwZqAIS?=
 =?us-ascii?Q?IEG8niNz5dF6CL7b1tgfFi03VaOLZGUfuNQY2maLdB/nyDfI/i/2lNvGLQaM?=
 =?us-ascii?Q?99wsN3NFvaJIlarL7q2he9uM+ET9Q0WJsDcwzrsIRzLLpvoBlt1eFF8UyOwE?=
 =?us-ascii?Q?zxJIoDHWEkmPDp9TnfS4slhts2/MJQaEpQJ/R2W+eJULPCOPyxXvcBHid2cI?=
 =?us-ascii?Q?jRdJjya3hULCsYwO48YUxajzYKYnhdgv1WSUMN/Pd3FOBKJrbIiR/KA4p8f9?=
 =?us-ascii?Q?YYOZg8NBPETuPxu61ULkND0SHxsdra3AwxSorTiT0mlEqlzCo0Z/AC4OrOGh?=
 =?us-ascii?Q?2OjEnYiJiNvIRnOAYrWgewWwbRm9uWhZ66QhWLoTzkZ9mHKfoDWFMEo1PHf+?=
 =?us-ascii?Q?XkCYPBBSkugLGcgS7j5cbtrppuUbd2vndmPo9z+ZOrUPjvxbG+Xm5i1Axrep?=
 =?us-ascii?Q?ZHY8LWaYJei9/xL9hrTMaD1yBZXnSNeumcfzUGGR9fP+Z7dD8bA2A1WziiQQ?=
 =?us-ascii?Q?FUc6YAyW03h6z6TnAbz1Xsl0gTCwUipqkrK8tpHYcZLBLt9HbgmJM6/al/iY?=
 =?us-ascii?Q?gZfEj3yH6MHfzdJdkbNNyiHqSdoOopFvcLQQMBKh89Hp6YZ1vpvMOafC8nJq?=
 =?us-ascii?Q?pGx1xNQAR6JtGz2sgxlZQXyovoY1Poi40buDHX3qmzUK0ObWdldAA4YX4gOf?=
 =?us-ascii?Q?T1+5bzuOZRt9RkG7/d9u7UG9m4Tm/x6OWefSUpMH7KHAjFS3voGn3JWDBc21?=
 =?us-ascii?Q?ku9J0VPWd/HuajVEdADo0hr8IaP8+goU1GAdn9g/HGW0Ra295XHoTbycjdqn?=
 =?us-ascii?Q?DjSXrej/ZO1luuzUeCjMBNU7iCi6+8ByzpESo0GY6HdkjWNy22S+HJ5D2Lpk?=
 =?us-ascii?Q?r8zB4ilOOoXeMxu1i+4bEa5Z+kCFf1Cf1e0pC9U4/FMx1bcAJ0M4FwZ8z3be?=
 =?us-ascii?Q?eyY2mmvc1Q1CJFghBC0vz2X2x7vEIpwpvT383+GryoECv0oCMCQgRmqCt6YB?=
 =?us-ascii?Q?SVOqvQB5MW4ufAtsfSnlMyCC8YQ1jZ3ZcWP7cSEWY6wLw2jQfy8TNdDaFn9F?=
 =?us-ascii?Q?B9mbp9z1zuuP08gSrg0fJnYosCIY1kB6pEEi/cV5BBkQUapUyTQgCwAy/2VJ?=
 =?us-ascii?Q?k35tPgNvSra06lLiRlKvarT+za97LB5TqWzFoRefl+Z1f95ICbLxYWtHteMr?=
 =?us-ascii?Q?4ucPPEtm87OskjM90mWDJFiCp3TFDXyFIAaz5GfamB/vVxY2iCWk3a5rSkGn?=
 =?us-ascii?Q?lDCf/ckboTo7YzaDkdjoETffnD8JGmzyGKtWByFPgmIN5277GlKFrnD5zxxx?=
 =?us-ascii?Q?bAVnwx6FZLq0uVo2zpNELj6NSfSNaV9+d/1KEwGBj1EKohf4s+AW9G3hQMHa?=
 =?us-ascii?Q?JojQvVL/0WWr2qcP73OHMF7iDUDmZ61E+SxlVXLvwWh8FlY/oeDTWyY/aVph?=
 =?us-ascii?Q?yoj/tZyLcgnX+t4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsnC12RbuJpablG4P1EOuUQenqpJqnZ7v0l2WbMxNx+uQE+Vh/XOiBa3sBhF?=
 =?us-ascii?Q?x3VcbhWU8OV1tT6qhR16aPvy/XEshnL8nbC/SxHkAV/lXBrZGzXQ9tY9/xaZ?=
 =?us-ascii?Q?ihKDoZOWWMJfn/E4YN46AWQPAlNqiDQ/ZI7s0BF6ktDnNUPoYJmVuK9qzxTq?=
 =?us-ascii?Q?1LruKjokZdAKu8KBViGTDUCYwIUsT4afL6VM0S3rq+WoIP989gNawKNjnoev?=
 =?us-ascii?Q?LG7lOkQJ5ICKNP9E3jpixwJ18UHGZkse23mJ2CHkNPxahcsRi67xAtFfUBUT?=
 =?us-ascii?Q?vAqIVEQumPxMuMypFFTMDNQ3AWKQyWDcPfTvyGlbJ56hf1169IAZMPCvfxOp?=
 =?us-ascii?Q?YaomOq0gPengYWkbfEIHm+lpldNC56wZvh6SPgDJClyx28WGgIDbLClfXwsS?=
 =?us-ascii?Q?9NI9hQ1w8Ham3cuefXHhaiJXvQNlFNzbMy7oslHB+Wjj4jljwRZuf3UQpFeN?=
 =?us-ascii?Q?pTMxIgMnYShDCOqr0X/s2wFzwUIlHOf4QDixGvHnU6T/a5vG3M/s24j3dUW/?=
 =?us-ascii?Q?lVgMtHwcZ8oLcuCAnzGwRqr4eFAjMcI3Kakzj37YGmaLJEtWxk8GvJb3mSFR?=
 =?us-ascii?Q?pf88QrXoML9T1hUOsCw9neeWqQohCujl+UL8F+UbPqBhemotmUwpCCaHGCvS?=
 =?us-ascii?Q?1+ogf2TEHwnXMUiV9G1iEMtLHjvp56EKlvQWWVdbRVY8n/5HaELx3OhQfUsI?=
 =?us-ascii?Q?Vw4EY/lqnbP63vOUQs6sHQN6Ytupbj4vUkKEztkrbQbRwodunA3znDggSeRD?=
 =?us-ascii?Q?gulUA/7a2T72kGcba93q2ynSpmiQBjoC7zDwY8Qk2m/whccmOlGGIedJBIrt?=
 =?us-ascii?Q?zqAF83ZexPBPDcn2UvWSAs3tzAC8VTJGdOrBr4eCqYmtTiZie5vzf8BSh019?=
 =?us-ascii?Q?kz5XJGD6HZSNObOlgvTAWQJDTc14NlwGhJng7DTMbpA+ShgbzjHsDNvyl3ET?=
 =?us-ascii?Q?07OdF76EvwZ9hBRS6EmLDsSLzgs5DO2TFzYfAtbFbTqpOiz2kYHzQRdPVE4l?=
 =?us-ascii?Q?6kftlnyBeDwDrFF3p1kARxdsKbk7AKnlpawnoSFIGE6IPP/VG/mVWOjDs7MQ?=
 =?us-ascii?Q?mQ/EpU8nn0Nm1iVQ+YgeQ+gUSwz1QC8QMd4ggwTYJ2dMDcN2P6G0jX3GBbVL?=
 =?us-ascii?Q?8U0Mleayk8Ye4YgagPxpvwyHFZN8+vZ/PSnKFQZWVDb0tmArkBkhFxwxGSt5?=
 =?us-ascii?Q?ql7DcC/7Kzbbz+VwQh6nuMWYF+FE3PqJfwbSs/pysKHskWUTnfbRxYUy9ymQ?=
 =?us-ascii?Q?J6/yy8zJmq9oDh1IKlMTlR2iCLhZJfkaI0g17EIERhO44iAOwdJ8ZBG9j/0O?=
 =?us-ascii?Q?KH0eX7GH5fs8pdZtZPXRJUUl0qcuUIJcRcchxxPocwpEZjdHaLzTrWuishLm?=
 =?us-ascii?Q?AfAgTO9Tho8qeU4PTp1QAUQ5IZaHj3+onB3F1MONBArtwpZF9HeoJwTfI3fQ?=
 =?us-ascii?Q?gqc8dr2QrIVUB+C3qv2P8DDtm1k9e8mDvyz7gFbYiGOVvL3JKyavz5lUf1Nc?=
 =?us-ascii?Q?/IBSRlsjJHb//PhVFHGtmxFxjjRd5/ALWrkMUq2eeKKd/ZIofwXQLFLvBfYe?=
 =?us-ascii?Q?fBgLP/FSGqwrAt8cxtwFiohCI4oOfJlhFCmc6Yf4UZF5B1IlOdjL/JcgL6tE?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d89fa146-3ceb-4263-f2ad-08dddac34012
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:48.6899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxqyzm6qV1v+6vNMI9jl6s+g8372Xh5IpLAPMSZMDjpBkZojUVN2/U2bj1sgQPCl5jbDgLUKZ4UvHYtwpIxgYErxVeyMpjr3aLN21yjbTIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Gabor Juhos <j4g8y7@gmail.com>

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is a port of linux commit
091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..3e21a06dd0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
-- 
2.50.1

