Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73463CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B89838D5;
	Tue, 28 Oct 2025 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="DBI71G5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F5E83710; Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7F0800B6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCBTU91Y89u1rxHKH5Y1PG4BpmfaWi4QQbI4VFXjotIxAoywTMOA+M05I/9htZ2zAnXyvaLkhWNrnduV9ttV8Vj+bRKXJDFZJ4aFSrcxLDQiwSjzYRON8w0+3fIL5WTnDomOPUMl9bq1KEVsNl8CqDS4JNTbEqcwpSiM58SAPIQ2+tR3OMZvIqMgFvi75+DDM7TK5qEfU+TlYArt5QUeAb14UW3Q8u98zSFKfwgDcfapl796witU6g3c6O7LfVVjmrZ7wOxzdwCBDafvBiyqtnv9dgmk7dps5rlcNo06Yokr1m/Da/qhMVXNsETFhgnFtq+lVXkD3qgYLon1pxGUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipBAmxFALFWIX1FBcoS7IK+VrR6wQFGnRJ6dcd0UmCw=;
 b=RyOr7AtoB1yt/NhO6Ju+QB4PShfu3D5xT3S8/gE2tZaTuEu9Cb4imOh94YyUM8SOTwAfgSHeKtaVct7KsJZkiig3PiTwcg8zxOdSFC015jnGg6gfsNuMxpYWFuyJTkDTvUG7wchbshxLRG0wNSRf0LhAQKfHGDLTVxlrr2TaLQkhz5RD49LePdC30nRRic7XNHDZbuEL8CR8a6YJCASmZVFbYpP3E5pwSkzHfycOWHO/TPpQU87zpEOMytXzJszXDVGGpDyDFEQcVNYH2lExVERCrjvw57rvXVjtDhtU0wKof73LAA905e6C2W3OfzDt2BpMDQyRaDEznp3oMsN6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipBAmxFALFWIX1FBcoS7IK+VrR6wQFGnRJ6dcd0UmCw=;
 b=DBI71G5E7FBIqoQOl15EUXRw5Xe1KwPoqPZVwnKltDYun+3k5LVvWQZqoVYJzdYXTZy1IZsiomTHF3kpUFuina4e6ZFuNPPt87LdEHzXUWX9km72cQ09liYfEF8RYgxTn0y1c5zRuBQu8n3g7jBiw9BAROKbc9DMRal45INHTAwITjOTdkSf6vxq4hwYcf9FwK7IuyLUq0GcHikW1YVLsQI9lEie2w2SE3ua64iOi8T5nLs+50rQ1nDUDIIULRGYnQfVgYTwqjyP8mtwCXUkoNXKjWtr/JIPQJh6j9a7vvLuTlFpXroBhL0uPyMGLPiUIO/01NpJhOt/NIEddQZbWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 04/11] spi: airoha: return an error for continuous mode
 dirmap creation cases
Date: Tue, 28 Oct 2025 19:28:18 +0300
Message-ID: <20251028162825.3353166-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: 27946e6e-391c-4d8e-1a24-08de163f0d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x2gzwjOpbopRepOCaT3q5Ku6RWJT/0pNhRvgwTXq4laYxwXJi2fYNPbQyOmj?=
 =?us-ascii?Q?geNaJNlZ+XL4XL2OE8wGrUKpQVok7fwE7Q42m6Hshg/57+eRdkm5ERdx93fB?=
 =?us-ascii?Q?2fKYx8kuA63c40IngRquLyZy6QY9g6zuQjjUbnmgrx+qIG5If4N26Z15jRuj?=
 =?us-ascii?Q?1xcKHswaCS1ie1pZTsOvJETNWFHTrn28gRzPft1BqgpTkmJ+saJo1iOqszAU?=
 =?us-ascii?Q?8d/jq2yZwb8VPmViesPGuavOs9WVD7IyC3NAVr3uAXVGmoIc7wvkyiRFXjmT?=
 =?us-ascii?Q?zbsjXodVLDeReW/WSuP17XBPQZEj7BbXVideIdRNia6C9V3YEpqC8/kahh8w?=
 =?us-ascii?Q?YhVeZdZTR/FhicyA5Odo7O6y6Vqzk/SLzibSTnd7+4gAAh+wYK6dKaWncxAf?=
 =?us-ascii?Q?Hmb/1jTfCNQem+s1yjlBDNTR9p7LL0bGk5EgBRS/GvGlmuZ6vUbe0z74wpEN?=
 =?us-ascii?Q?7VEWY0jsU6WcXu/MpDHf5xBtUftkB3WU/+ilBaAmLxUYg2w6dkZUsEzscj/6?=
 =?us-ascii?Q?rO3lCmlL4VHBZJsO6Vgom4MfiT7zKeucKWTvIJVvS2a8sqYJde8qBnLCo9cg?=
 =?us-ascii?Q?4NMqsZWm0Gs+w8RzJqAufVsm+K5j8HVzR5fe7691KhETAD7hEQw2XmCcvJPd?=
 =?us-ascii?Q?5kE5DOmfyECMugCRuMDEi82ZYrfp+EJnEkeL7+9P3ahVyfmt7MJWYy3gLjg8?=
 =?us-ascii?Q?ZU2JMWmDscUMbQGAVUiygd1GgeH/3ny43B+YOiooFwyKC2+E6SGpk16pN7HJ?=
 =?us-ascii?Q?BnJXhV/Yyq0Ufp0hsmtFLd9K5CXy5+q0YmgumXQmAQsy1eyAy9RJwwjx0VS5?=
 =?us-ascii?Q?kxtQ+IL4xFbsLN5pXo2ynCfrLBh3T6RIdfVJFrIR0zSDS17vY+F+EqR4t0fG?=
 =?us-ascii?Q?xnrLRmEpVmOtf7EIRQ1+jUk2JxiCNt0UxPnSt/VTBlWHw6ae0vdeab4R6es4?=
 =?us-ascii?Q?SVUE8byo0+JRs3d+HBHuzuaokerL4ADywbxmZH5F17/Fweau4bC2NtG6YlXw?=
 =?us-ascii?Q?cwLKq0/5hbZrN8q0OreehRhzI1QS/UbYxenkly25XPayO3u8Fcctj1Laj/N8?=
 =?us-ascii?Q?4vgaepcVx4hlljAKlIDQScN43RETRVuqzPnBewEpam8+0o7Cg2PtqpCoOCzh?=
 =?us-ascii?Q?wZt+Rg6HJVxNrf6q99gx0aKiCr50TywSo+l10p5lx69MqO4UaYLUoGI9+yob?=
 =?us-ascii?Q?AlxRmTz32bcs0NGh1UJjI9LVpXg1HYHYrTZkhTyIxs1Idi051FthcfcyLTsc?=
 =?us-ascii?Q?ZcrZ+RNZ9+WR73HCbXPhh5SzV+/3RiftigSQ2ULC2vwDQQVIYZojePp2s2md?=
 =?us-ascii?Q?MGwzClKi+zeTpjpJsYHiB3lHEX2pgp5PqQBOi5xnVofVAZuIfpnI366YMZlt?=
 =?us-ascii?Q?WArCakn5RhW2VyoELCxs0M86isWuMMB1s3mVPXeVAAsEOI/03vebkeupuZuB?=
 =?us-ascii?Q?modyOr2uSZ0Nu461wu763+cbtmU+4TwqzbG6zo+uzKU3bra8TrbdSQAr0pLS?=
 =?us-ascii?Q?gOpy1j0OvX0E7IkFmvFHXV12J1CkVCCDRVH3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXSeMlAj6X5dyF5V1yKuKk+pc+b9jVZNVEV+GQaeJTDzCjFN3nEPI7Ya/Vi9?=
 =?us-ascii?Q?g8QZIolrkm2PL///A2+BZcz1dsc2Fse+Mpa8vnY0htQ+f3l8DNR36QekE89A?=
 =?us-ascii?Q?GbuimsBhWD9TKKVG2/QcxhZqjOckBfMGsRByXlGWuAy19eFLHgH1bWjx0r6t?=
 =?us-ascii?Q?rVmj/cJVklA4A7IwQkDZlANj72tMO+BTD/3WUyMHi9X5OhARokA7/Ovwu81N?=
 =?us-ascii?Q?0iWF+6dRGIOUlLvLNYuN+Omf88j/C285YTBJ6y9hetkTT+1FTAPNzcldMec5?=
 =?us-ascii?Q?2dxxh3nkX+cp3glbTUDY623lG3HaUJU5UI58189VL8Hq+0QHW4Gk13//2Lol?=
 =?us-ascii?Q?3XKZiRcjsm0ZuSUmo/gl7UKo0Qeb96E2nWSGhR9gQ22533WlkIIl8y8X98Ea?=
 =?us-ascii?Q?tHUsTgQXn+cwewgtuYmb5oLcrqHkCPBh9wupYcWa8Zxr1SAJ+y4XYu3DhNls?=
 =?us-ascii?Q?k8xPwVM+5PYBTtL4yu7//KdUnGASY35G3wIU1u/9NLepHHnByEj+o4AbUYs5?=
 =?us-ascii?Q?KxlPfqLK49t2ajlH4TsbKHGHr5OT9VVOGYjpOFSnlo/encul1Cr/R3EP+ZI+?=
 =?us-ascii?Q?6CpYv73h12GydO2qhJP8kSesEY3UAdo3wiXMzaBvJzKbgUu6MdEkjFjg5BDw?=
 =?us-ascii?Q?fQGjJ+qHXmTUEKSJfTMPIdJPvKZnD9qFRKEypPR2H/8zvrVO6SsDgstdlPiR?=
 =?us-ascii?Q?2fiIZpLv2ssbPa+Msa7SrR6b1a9wGUxtsZfOJ9AWQGoLoYHkSB1EUW93d/8F?=
 =?us-ascii?Q?ItntoipbVgAAmaVUX/0JfoABoFKolBoRf+T4J72OXJx8wkFvA4ZBbGyle0VN?=
 =?us-ascii?Q?Iz4cScBKizW4zW6hNuBceSiE8SXz0Z9yKboh9zKG+ApCJRVjf5p1e3SbY6o6?=
 =?us-ascii?Q?3haLRIaAnBYKRVScZOBIg9R/XcKkDeI088Ps2FsGP19U5kENQ8HCV1hLbsaS?=
 =?us-ascii?Q?FgVTTvo/Oh6ePyndw7x2h+B7q+1vRodnt6RlXAb7Jahg5H83PPlh2ig5or1Z?=
 =?us-ascii?Q?eidqhllomg4uTsAtffg36qoaEGPy6xVV8PRVP2UoZt6XyoS8AZWqOH8DB3r1?=
 =?us-ascii?Q?ZkmBVIx+0mAwRHGBTGj8oNvDFTVtlyyyW1EaFeVE+PnsbMZw5UWMF/J5YTGJ?=
 =?us-ascii?Q?ytp+AJnoN/fm6eWrr6u9qXr+KtIWJUVbtw71J0r/L8XLMCwL7sTvC65VfZ7Q?=
 =?us-ascii?Q?qBcn2SrwMi2HWszgXszA9HBRwXh85N+5N86EcZL+H/GI+lyv1phWg+mKRiiv?=
 =?us-ascii?Q?QlRUWJfMfhLwdPQiSIrZ7uKt4wiDMTtnyvny1ymM9jqMm20GP6nDnRCApdvD?=
 =?us-ascii?Q?ga4mbdWrwoyNr9NfA28wUDwMtCM0KVE9g96HHiuyCLBMMpKpgOlF87q284gC?=
 =?us-ascii?Q?H2ha2QXCVRywgi1JDFgJFonPGLQKuOqGuBSyzVp2E549c2rpLvNGfdhlFYx3?=
 =?us-ascii?Q?k7yZQDfBMrziu4uhjevpUdjcVrCaaID8k/+vTv3uihUzNeV+600tBiYow7Gi?=
 =?us-ascii?Q?npr9XoKUblU/4Az2QSUCqQkN5LUEsPO2nrK3+9DIyM2OGNlAADnqU4poB9gJ?=
 =?us-ascii?Q?OmjafQsvvV3zKeG+byC3eW50CosZk6qWn4Dlq9olcNoW3KAhO0og6RZvdc2t?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27946e6e-391c-4d8e-1a24-08de163f0d25
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:39.4472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtM0xWBa0sUFzPBqFj1wnBelrBzzQFKxKDsKnXjju/cx2VJSwypuLJCn3KfT42ncYi1p6Zy5GxO8N5uZ/9w5QUHoCt9sWRRM7He04FURseg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f72d11f5b19..bec4ec0bf00 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -630,6 +630,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0

