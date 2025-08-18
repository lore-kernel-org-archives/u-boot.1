Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7BCCA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 02:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC74E833D1;
	Mon, 18 Aug 2025 04:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pIuWv/YD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA98833D7; Mon, 18 Aug 2025 04:55:22 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2825833C6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 04:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMD55ddLbUDfbqonxV6vt2EW7SaxyHDmvPM0+n8LoRH2dcwA/9G90HUwuq71HylscG2EaTPoYuFDLlwoVKHaPXSJwBZwsnndTvaKdfVlLt3rLFK6b7ZUwe3Q/eEl/PsdaF1H9WaBgS2/iNXhD6HBQu+YLLBWkysaTyGAFfcKHgQzZ8k8YUWkLv4BGFdov1/+1xx0lVnomLX13UU8Z5InINVluR103uv/WQ6UEmX0KjbcYheyF4Xq4XF6jR+BG8qXydGVXOt6pDVurccxlwzdUsCipj76U6Hmy4T3IBdda7/IffVEJB2a1NNURn6umPeEEK+u6ySnoQXKq/Ku8MjhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdWsicsIL2i1xd+hgU64Xywv/+aPNRHIU55siVy4WuM=;
 b=WQQwg/uRyeWsrCddMlrJuySypLVp0psQQz+Yt/Dh3OkcSfATg8T7QHC/SblemE3f7n21amu43EloPOje0P8L6cLYXXL2d3xyBUdV+Jmx5E8COh8lCmehN50LvEgagQfGgjKz00CHn9JSB+tpKOK0cINj8s4O1SQxlit0kKlRLWontb8bW3VNrRv13aKres2bIf3o4/ZpB0o8zYZhS0fP5lEe+n40gzN6SwvVfF+P+1ukFy1sDXZic2lSgvHFn3Lf9p/UXyT95A37Wikz+KT5YXnbBIEl31NAWHSCSz787wYcM1LCoWzoy50fgg3otVIy3nMEXADptutRwHIKYQyV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdWsicsIL2i1xd+hgU64Xywv/+aPNRHIU55siVy4WuM=;
 b=pIuWv/YDau3tI9Xg71J95qqhn8FXR5j1BLZO++xuwYpUIO5mUqgRMeowYE49dDcBZEyLnvYkHNo4TPhA/CCJSGoctglXZmo2avkPq23J4+kTrds8ldFe5vx39DdRSYx/ccQJFqtFlgx7gNx+4cSTQYt0c8uj0/uWY/MZhsVSxmh6GHj5EzIqcTzxUBfYDwbybn+3DyumQxtCQiCgGaA6scSDGwYUkLlGuUVLXxVV2b309DcZ2aEvyh3mChMewYF5CqP4mqjOrnfM4m/UcOB1fr4xY/inURL/hlgiwBX6xgJV8N+rRBVddqu2bkpZQkKvW1cJ3d2viCKkgBQGhJHNlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7553.namprd03.prod.outlook.com (2603:10b6:610:23e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.10; Mon, 18 Aug
 2025 02:55:14 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%5]) with mapi id 15.20.9052.009; Mon, 18 Aug 2025
 02:55:14 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] misc: fs_loader: Initialize actread variable
Date: Sun, 17 Aug 2025 19:55:02 -0700
Message-Id: <20250818025502.6830-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH4PR03MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f598cc5-5587-4ff0-8bc7-08ddde02a7ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovUb7Wti/ybqOINQDAoz1iRdsxPj6GTmZzZaFsBf8yNjkp7Q4A2G79iGI+c+?=
 =?us-ascii?Q?/7bVaNDJzkLSnFSFxr804tLnuA/z+pceCgpncnFAuCM3z7znueX+7gdg3+ji?=
 =?us-ascii?Q?F+QCSNwkUBaHyMQrQH5OzqRoZwDDFHstuu9iFrxOLuB7zpQ7GkK46cr3VhyM?=
 =?us-ascii?Q?5wXMeWtCJ1ys3lYIlPtR+Lc2n820E3dNzGL8Q/x4mrxmo0b5c3YgdxePW1xL?=
 =?us-ascii?Q?aSvP0RTP82lkulzR6ONakj+MFnAiNDjIqKv3gWXWSSCaHgVVWv/9nzrs20vS?=
 =?us-ascii?Q?30+pHfDAqbucGOdmWSyFNrds71szW4uOlWGO10BXXFeMDtRgbume2b0GhN0W?=
 =?us-ascii?Q?NDQbjV40JL6k4dvfJJMOyDACCIriPu3bwL12DnjMf6Pp3trj5DeBPlD1SaJZ?=
 =?us-ascii?Q?cjUR0GZT5KftpYPdQtrUsdvNrTdETRlRl+BXV0bhYoLSJZcOAyPVeR4cdLt8?=
 =?us-ascii?Q?NN9P+Mj+axcOpOba3zPoPfAcJOz7I5AYhYnR59vuflHukRKKN8NHk9PkxkBE?=
 =?us-ascii?Q?ZBdMPMeaPTcLOfliluvO8ct1/ZOHDOZtQZe+8EWqr2Fupl3g5Qnj3ZLeZGZo?=
 =?us-ascii?Q?eTDgPxO66d5DDFrwYNB2qH7LRI/Cw+lLlbz8+/oM4HOnwjELyvd9+L9XVZUO?=
 =?us-ascii?Q?efit7JQl2fhNU4QySmZpo29BJBLXkXAh7NKqDg7+5+YSmgTvyjlDgQmKiGjE?=
 =?us-ascii?Q?n1rqadGsm5pQs/UOIMpWE8KMCakWnEWbtWKeQBt/0w7yQXk+vAPOgTbDqCqo?=
 =?us-ascii?Q?6q5RDUepILTKvXmscZfZtRQ4u08ykatG4uCNGm6Orm4BwqDcfJXapW618XZV?=
 =?us-ascii?Q?/JVZoiA9xShHAy0kyK4EkN1SvMDWNV6UzIM45ckSfav/vo8dzJ41CGb30b+G?=
 =?us-ascii?Q?8mFrV/3QJmAX33TQDQ/tsXO6guRjHZ2aAnDHBkgSaeLJrLxVqWeA/mdt60Kn?=
 =?us-ascii?Q?Zv/JTviwFp77FunOvhK9TnnUjUCTZmNVMT1jntexWQsCELNrbF7TJloGvhWJ?=
 =?us-ascii?Q?tGOOw1ZwgZk5yBAZ39RxO4+Fy1PPPsdU5FxovK2Qevch1GJ+kne1hE3DUw7S?=
 =?us-ascii?Q?J6hgNIn4nGPkpA6/bEGtGZwfgSRtuCIRo/Sa5A6NHMzPOBBt5XusQ85E6jPE?=
 =?us-ascii?Q?KZNiV7s/zDV5cHDTErlorilSmUVIPK/fJ5uJ8rtMzZuuAIiD13r8Pqzyt2Sr?=
 =?us-ascii?Q?y8j13NzKmIBgfrs4ZdnZFuUu6qv/j1Hf5mog0ulaI2zml1Tq/bSyleTEbBRS?=
 =?us-ascii?Q?IkkCrUSVuMsK/E2/tvEZfcSRHvhnaLqymo94h8YE9BWNAIQC10K06aIMf67s?=
 =?us-ascii?Q?IPUdtnpKfNO8rzCPM1Dt/fneQLfXOI+jDNRvs2uli0PKbGGL+0IYh1UvfxOR?=
 =?us-ascii?Q?Mt85113MzuehXAJG11TbzKfRAvYOn9kpNZi564XsWCjG6UFLsAUnGcG5DF++?=
 =?us-ascii?Q?9FlaHiDGt3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gocb9IgMI8WUAKKTFNoAntUpkGMDh5fuvJIbpl0FqsWMl7q0W3B0++BayWKZ?=
 =?us-ascii?Q?JDU1BuwWFgc2c3Eq9fb659Rz2gaTCyHGXd95YEECz/zO9SBY5kFd4Mzatbdr?=
 =?us-ascii?Q?6IWyyImPLsJD5MDSqlxeBsyfk0OO0pzKBiybil8CYjB8BkPFZR08TOWiLzhZ?=
 =?us-ascii?Q?S7jYybVmwfD4cqadSGSOCWjTRmBwgJfT8Be1LObzhrExSJ9K61OZlWaJwnG6?=
 =?us-ascii?Q?Kj+iebNJ7ldPIHs7daRsGp5IQZTZgIu14ndpxM38olvyHNfOu8fxYs9cBm+G?=
 =?us-ascii?Q?sicbRZ8NLWzyspFSLpYAxQgk7tT6526vhS5Cp0bl5YVOyc6IP1QloBVPvlnD?=
 =?us-ascii?Q?W8fEZ3lcSnbMr+X4WXk450ogy/HWISrrrqdHQv/pvZGLxL4OEY7QIWlLR0hC?=
 =?us-ascii?Q?EJ9oB0lqbbtvrCogmmux8450NzO2rPPzOyb0uIkWKCkjFrb7rIjS6KawcXA1?=
 =?us-ascii?Q?rZMI4pxcBE66aKAP3sYsxSnq7C5G45dpBxiJYcWT5MZXbL+P2FF95eSmEyAQ?=
 =?us-ascii?Q?Dn3UAGTxyC17PNYvJoWnFgi4A6Pg9LoyYs0TQzHk48ORRDHutMCKE8PpbkBE?=
 =?us-ascii?Q?bTq4NyZiUWR+Lc4wVlRQuUvjxY/o9LZY1PFUctfkuDDf2et1Im8ck/ixeiyy?=
 =?us-ascii?Q?mQzVkHVmFoGAfzjI8/L0KE2FS8FkLw3q9+xsaO1UV0rZHGxcvWgVLSODtCQ9?=
 =?us-ascii?Q?5wGpidM7CvmuqVvGKTtucBXo22NaYWN8FwCOsJO7aIE/hJpT5CM5E9KwY9tR?=
 =?us-ascii?Q?20VvwALqJ0MPgrFoCq4J43ksOguArxq1XQ51dND7cY7WxnxcatkubF1l0iZ8?=
 =?us-ascii?Q?y0H9Sw89qjVBFHNlxse3Sc8zOrYBsOIfgCkKHVmPd2vw1Jjb1/Ck5sqJJANG?=
 =?us-ascii?Q?4dK1MPx5YBPTA+DzyFn/oDV+Y/0w6BonxwTMXmah6ogLngDErdf8pdSq5VR+?=
 =?us-ascii?Q?ts6v/Oki3Ma+x27evrPLUw2j0fI5uNJCej8sFp9g67dIv7Pbe4KflwJ++fpT?=
 =?us-ascii?Q?Rs5dL56x4DZhaYdTlp0834ewcqMivHQ1MKpAhr1PP6rofOih//aJdrx1nPrX?=
 =?us-ascii?Q?YILlulONb8tJslKN/OWTANEGVsLR4UdoUm/p2b0cBOEPYW4JlgHbfhA3Sn09?=
 =?us-ascii?Q?PRSPFCLZY8yAecU9wbBYHlmpfawgAOgBBv2PWC5tqi/yrCrlObtFgmPXXjl3?=
 =?us-ascii?Q?QcORemgeDN07glPkjjNb4TpsTL6Rt5YJIvqeBzyGQWTFBtZR5IN74lzr8TFP?=
 =?us-ascii?Q?QRzXlL5MPFGncI5LZoS0u66FY1pJjiwAI5/kRAGk7nDM5qCPj5Uvp7SKER9x?=
 =?us-ascii?Q?VJ4zRPKmezQXBNGYuIm0VH0ba4FQuErUwcKQi1P7FPmzUPFw8tofWru1AuAR?=
 =?us-ascii?Q?Fsfio+wz/RxARcvlOyOYnIqdrIneLcgFGCkzJkFHZZoTjdV4ght10xdZR8wo?=
 =?us-ascii?Q?4SyH7ojkkK3Fe3bojtqTqmeTp79thkxu5iQ+hKk5w2zPBiute6YmmlmNFN0B?=
 =?us-ascii?Q?FUlDDQK+VXdlBjfjx5edcjjnTWBvrKcV3CVk8hW9jjTrIeEdufSS+HpHRXYt?=
 =?us-ascii?Q?eNNnJZlfkI8SGzdY5DvjoM+XFqvwdw21hXsMGMXkq64yz4WYwMJ0QaxhVxJM?=
 =?us-ascii?Q?39dad3H0+qKPf/WP/l25weA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f598cc5-5587-4ff0-8bc7-08ddde02a7ea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:55:14.6575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJcxlyIC2u2s3CHlH+RXJzE+gEwngEwIyAHeo27inH5PAfGKXeLA3heyNBq3cYRvWT9JETcfqu5zrkqmELCK3UnrljPzXDYnYmIZqsvTjn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7553
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Initialize the actread variable to prevent undefined behavior
that can occur if the variable is used before being assigned a
value.

This will help to prevent potential issues, especially if
actread is used (e.g., read, incremented, or returned) before
being explicitly set elsewhere in the code.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/misc/fs_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 66803f4b997..2928cf75f89 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -148,7 +148,7 @@ static int _request_firmware_prepare(struct udevice *dev,
  */
 static int fw_get_filesystem_firmware(struct udevice *dev)
 {
-	loff_t actread;
+	loff_t actread = 0;
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
 	int ret;
 
-- 
2.35.3

