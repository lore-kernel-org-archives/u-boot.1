Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F1CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A3B83F2F;
	Sun,  9 Nov 2025 08:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="idBlj6mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEEC83F2E; Sun,  9 Nov 2025 08:07:21 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3549B83EDF
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8FcB8IPrXVUVD7WODK9VNQV6pNEtq4FhzGUN5Bo7HLuCE1qls0DlM0eHmhXE2Xa+3nlAFV1XBerPH0So+05LyNZF5xl+Qx7AB3CINPfBgBo7owsis00+NQ6wcZWNIV4Rs0hn5K8Ux+eY4xGz/eQ4Q81fW2i6TaFWzoWgTqCM5+5LSPl8mMn/3yvuBHsZzFNFrbcDP1E6bXQ8W1/iRaLiche/ilZhNU8ND709DLDMkFKV22T9iHqcHgGqBnk3o4gckOadrKxtdCNd13WBztpUweYGdUQYC399LCgTd/Xq7W/TcnEm7af9BhsRoVyL+eKe+k+DXhkLHjo60CiFPlfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i7B4yAAV5aKm6kSISMQL/zVaGInDnBuBSpX4of1efU=;
 b=TpShNYj9Q+wZt4NrbbUa2wGVd25iad9FvC9uFbakmLqmyrCkuAHbSI+eG5x+LeTGh40kU4b7QDF57pUjYb149AYI5+lafxyqqyGx+zcTxytzMhy62EnJyVLAatwSPPN3yfuwoLbZM7LO7PPkn6A2WamlSM7ga189ELdpaXFSfutYB/n/3v9avp6pccVzutI1px0HSK0sC7EUullqNU4/CoKwZdBqkowgSsofE3hB+4SmamaDU3/bvB16aEEGhy0X8Br0karOpILBfilbhtnTqKlE7M2VDaMorqt4PnyNmVz+HfLcVoTRGFVpjPqJZyYSl8kXIg8pI6MvZzuNvAE8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i7B4yAAV5aKm6kSISMQL/zVaGInDnBuBSpX4of1efU=;
 b=idBlj6mrAe3k8vBK69DwSxV3FuUYdMH0gV3g304eY2cis1vtt+6FVSCgl27qkbo9AA25IqenRh+krWVXNYovJJtrMXN9l24YGWvQBbob2AKhjmoyOwffoTYIHnz7/+N9M32OsFCLDvCUYerGkWGiGchHvJuhkACWABIIxspQQ//beIrlonjjY6ALS75htuHi+bbhstV0aFu+pn0iE+sNIa4lHmVJGt1FKGMp260GKV4gb3rnWmtrxG1p6MhpLJYiqzRlt7g/QX7LjUwsdw6XW9B864GowEfefi/DaxK9n6lD4a0fpHm6Ql7pqI9/sT+Qmq9EdXyLWtCSxQB1CXjw7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 08/12] spi: airoha: avoid setting of page/oob sizes in
 REG_SPI_NFI_PAGEFMT
Date: Sun,  9 Nov 2025 10:06:54 +0300
Message-ID: <20251109070659.801344-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ffd29d-aca2-4c11-cb94-08de1f5e9e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THTBdkFbjW1AglTI4AvMEMsfecSHZhwW6qwoqCcbbxopZrcYnHKhI2y6Yrni?=
 =?us-ascii?Q?SR3vIKiog26DkefUM3LPb4gDjIdSbpr7MzItWZM9eV4Pk1105Mo6MN9edDny?=
 =?us-ascii?Q?JG8BbIE2pRGOfcHRqkngeY591LvdPaPIvnqXtPp4rjqC3Ijfe7Jh5bu98Aib?=
 =?us-ascii?Q?kIJh93edB/JpMr2Hh4CvS7izhpJ8qxma7WXUW7upCjaCxCUAzQ+KfxP3uSgf?=
 =?us-ascii?Q?jLOfbkMK8wZR47tp/LqiD2fBHzjl9qdsHkTX9/NICK+4ZSfp5Z3pA4MuX3I5?=
 =?us-ascii?Q?Q++Yzmp80OKBKcK0w7VXGOWC3iXQObjR/4X5YN62K8Wg86gqyu2Y9XsjoIEZ?=
 =?us-ascii?Q?/E5NUZY52QDK+F7Ri5MliwMzF7HovY7v8P0zkm/s/7aGzq4ZwlN/YKp0l5gU?=
 =?us-ascii?Q?aa530ljjU2hziHQWGlAVNT7GoFVIErQzNE5APsIIDYda5DDlFXdx/PTN63Le?=
 =?us-ascii?Q?ci0/Co9H+O+tSTh/+IOr5IQocWVQ9V75qCVZdV0Et6eCqv7HscxftiLMRgGr?=
 =?us-ascii?Q?SMluO442BrNMP0Rx9YcS00Ew7/b65/SMHb2omixnHCr1A5kYA//tuBDa3SXO?=
 =?us-ascii?Q?iKXiZ8gj3TMdWmXzMJmJeQJaaHmy5/1PFwKBQiRuFrsgRiTTxdFpRGETldlA?=
 =?us-ascii?Q?FZWgkxMhlCCjKK0ugNe6ftXypUS2lmRZ+oMAnEkiFpiblJFNKruafLN11u0b?=
 =?us-ascii?Q?KWuXm3ejYR5PUPDqpqbqRzw9irM9QTh+fdkdCqfpbSnf7iZqcn0slVFiwnTo?=
 =?us-ascii?Q?zjqP0pSukQEBzI9gJ2cAXV/JQlNnTJTJ8uzryBJ7dCbFJ9P5zEhiBBwPw3A1?=
 =?us-ascii?Q?zSFG7oIhk3uHaZcxF1CnIil0hqEZO6vFifIoXHiSlB2KcMiJKlX9ksfkLR7W?=
 =?us-ascii?Q?JpkriJkF9Uja1z1ubIGR5np7dSLxnTQNI3AhJP99DBMJXXwxkCI7WXdehOdj?=
 =?us-ascii?Q?nHp5elXJDaBSMecPDRpmA6ki2kL6s5HMwrEC8lNcr6VOvZ8hQmVDPlsCWXs1?=
 =?us-ascii?Q?mc5YrbpwvB+MCBr2Ve/FnyqaWmjdzUmNuWXyEYnos7AkZ9ABVrD/wXwFr0cz?=
 =?us-ascii?Q?H4/0csL4CA9MCteXaTmME7MvZ0UM2OJmQjZG/g4RtYI4OpU4p04CJtSaUu8X?=
 =?us-ascii?Q?+edwtJIGX7inq3/OAcGN5QuxLDJ8KNYLViaP0i9gahlu1hZvLteOa7lMOqcQ?=
 =?us-ascii?Q?Cfb8WSMg9nyGTHcwg5rnxFS/MCszQrwlV+2jlNP3pIoc5JWYOW8QDequQsQX?=
 =?us-ascii?Q?uS8VXNvt3x5xSkgTgzCoWE0LULKLvTLpWmPZxhdgU9sq3r1OgFwSDf9c8svm?=
 =?us-ascii?Q?jsfxdTx1TH5CMG3PdpFJBDlBUwsBS33Fm/R+wRPs64PytYFbMJ3tnQjStGWa?=
 =?us-ascii?Q?Nb9MbNreEYMkLTkf66hMOuURr0GXppKnyLyPK3C2uvk4KKhQcdXCf29HV9Rm?=
 =?us-ascii?Q?lRGNyme6wEGDHn36zg9c9N2SHgI4e5wERFLizE5JKY97TXdJZu1pL8yVc8q2?=
 =?us-ascii?Q?Wg8Nrk7rUhrPBHEG+fqpZye2HiAjKsEfKhKs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcuZTp43LPXXjbTfgjEZG2YedcUuwwgrIxTn+HkKZ/Zhvwz1P1Lu+X6JVwJq?=
 =?us-ascii?Q?CuXang98INUKAd8H6vf6ToZRJKz9uXVgUsVkNedktP/RjTztmoujyZx93g7j?=
 =?us-ascii?Q?LhGkTFzxsVcFpKQW6XCXlnyTSSz7y1PQbnJuoEuA9RQ7sHc7LvyAiO0TF7jC?=
 =?us-ascii?Q?3CEEANfT6VkacUHZQ3kyiJOBwHaMGs1IdXioBDHmsq/nZo9CbFud3uLxwcWK?=
 =?us-ascii?Q?/ZGMaMYBh2CQqNU4nZKzYPd5+Xbv317a/rk43KAuGmG47R4nahZ8/ue1kdsI?=
 =?us-ascii?Q?vQG3ov26cRzgXeaNburYt9xaW/GeaoHsNUOOGF41K6O0TCUM7S2RRbSY9req?=
 =?us-ascii?Q?XbJQuXvWM+2of8NJWZYMIb6H+YLxRE5BhxCaM+FCxc/XltwwA7bKNbYGoL3I?=
 =?us-ascii?Q?cO8bLB2ttRL4yAS/sPcqdPGYRd3JKCL2aGEtd5DF+Sr3SJB4xHgTNConrWd0?=
 =?us-ascii?Q?hTyT1GBGVZzI+otXGnxOkxShSC6sJs+NghQpwzAnkbJ1t+QMTEQXMTbNbUb7?=
 =?us-ascii?Q?i+V13EMKiOVQTE8O3Hc1brhqFSGbSpbdVosa0WzoKGrGDbnMpxokidTs8rSP?=
 =?us-ascii?Q?5gqNEJV3iOsx3xn9Zr9T+ImqBOOjJZ2CbGsr4zOKZaAb8t5BoBoQB8x8th1L?=
 =?us-ascii?Q?QET9eyqD0n0buAHZ0BXhFnd/YFMz4q2XbWqSGmbpRtSxesOaHYDZTNCv9R6Q?=
 =?us-ascii?Q?rUZ91kLQRpPwslLaAztek6/uaHktNT1qRUdBUoi5633vIOcvJRI2dG3GyL2W?=
 =?us-ascii?Q?G/5r8Ez4TAuLtJbYeTBLokeCc/v8Tvg45q/tpP6jBpVT56VaKsi57GMib+Hq?=
 =?us-ascii?Q?e1FCdW89wBeRtxNWDOIywMV+JMiDNfyC6/ms5VDI1zAAK0l6Ydq97z6Q1y4h?=
 =?us-ascii?Q?XuGFtmBd83AQbjUnnA6uYu9b2j2VSpx/sbt88Gkf6kkh1yMZQOBiNrBde7km?=
 =?us-ascii?Q?NRct9C7Jtbw4dP1Fip1O9Fnn/T6IcYcWacAUMPifKJENRWc7C2GOZfI+aM7d?=
 =?us-ascii?Q?V/JIgp3YLA00lkcJh/FPSu/gHSEEMhLGRgfAUsOOpqhw3OuRhvPJxB/UDsIo?=
 =?us-ascii?Q?8TzdARF0M1oqNk8jJqO4SxQ6s1K16yJqLUQXiBUjIVpoj0zZy8ISdWPZ7Tll?=
 =?us-ascii?Q?IWPPWsSSbORVBLCS4bHaQMkdQamJK96ssIoGd4hnHmbSxxv7JV+YjdNvDmRo?=
 =?us-ascii?Q?p3ZVvN5TP81es2vvMhfwJKOc5hNk7TAwFYbWAqBszj3shoNn+FyOCYUixqZT?=
 =?us-ascii?Q?htD9URus5sNNvdVsmkvXt+uRmz1GPKXK/USDYxAdCtrY+jGSVdwcVPtqTulg?=
 =?us-ascii?Q?iqgPQpUhB4wR8UUTc5ANx/BImo9LIwkzsjPDMRDvpdRBUzAfX/Cp33jdLVNW?=
 =?us-ascii?Q?FDkqIKHjg4SeSwxjQoPFWFqdgfmST6pGwc77KK2nBrangiJmb6Q7GfnhZInX?=
 =?us-ascii?Q?GUHfqmWPFKnN8uhG5dfot/sIhECe07TlU+HTA1wlQ4OQJtlFjxoSKNU3KYwS?=
 =?us-ascii?Q?DJ9ChazuQ1hm7XXNADyVZPDmExnxQ89FGWIoAdZh97Cr8rb9Qaky4j2I8RuQ?=
 =?us-ascii?Q?r9rCt6zSBupjH7pbE3NqCGHqIRO8c5vLZw2Iui8kWB2Ejq9uYVtshVz9xHVL?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ffd29d-aca2-4c11-cb94-08de1f5e9e61
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:17.9263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBRBtuKj3BYTbf1xBqw9pZmz9w41HA4UpEv95i9Lh8Q8N9zDzEEG3R/jVOYIeUYtj/Rc6NIYS5nBKvlyqGXytntdGsmGwINeXiZhHA0pEvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 23c4507b10d..b136f8b26d2 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -514,44 +514,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (priv->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (priv->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0

