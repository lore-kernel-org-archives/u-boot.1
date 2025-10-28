Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FBFCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F3C383710;
	Tue, 28 Oct 2025 17:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6gcVC7SL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5840838D7; Tue, 28 Oct 2025 17:28:46 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5B1836D3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsc3kzVeBXxfhBz1Zr1a7cvHaxYsbEnMqeYqsu0rbTeP6gp6nczZF3nyxGwdAqNFcgiC/j6t+QPtaOejD9K/i7VkA+uhboqAdZo7NeiKRDNMxOvguDd7MfXHnjQfVfdO5JTM3PHIhjU8/8RfMgxJ0xEq2q54BPu8B9IsmjGcLWUwEU++ZQP3B+fbAmURkNO4v4dYYJd7qzuQDZncJoMIlLbTBNecmv7w/gUq5O7upj2Rsx0Rvtt+ENlFCNBlfsfQIMvJ2eLIxrfhBNZybS6TTSzvTdyTfb3tCjmgrkbPpz1HhnTch7kzpUKCJ4ynKalL+ygcRGEVyx2Nlg4UAco5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i7B4yAAV5aKm6kSISMQL/zVaGInDnBuBSpX4of1efU=;
 b=Lo1luiQ3ufR1z36uEmhJMea3PLr/fcyVRttDcpRC0UjteZ1lEv/Qe5DCVvBjC3QtC/iBPmVYSAojDE/2rYZfcxNXvkz/hO7WpBsSYu39OJHVfk04x/jgAg30FGVMSK1/QjRswvjgUYdG/J8Dpp+jqEyTuGZn8d2MW2Z98siczNjF4O+MYvoc5A03s2q9BWRM5LFnAHw/kREUeLKKy2o4UtN2lBt2vPg1N3gGw1OvQQD93JMrx9HLEmzkI71lpcswXXNHIl5vXpqPEMkipWOo0e7q7EpetwxqlfQoGyu+J9NQqYwtPCMdg22HAnol/WiY1c7+k/TGW2sYZHCmRpVqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i7B4yAAV5aKm6kSISMQL/zVaGInDnBuBSpX4of1efU=;
 b=6gcVC7SLxIbzTf8mtulhOQWNUlZoV0qm1G+fxNW8y5ryYDWuKjvLQATaG/8APKFiPgjlvnV5fw7ZR78ZwIc2hoX4CkfFAtl6tq1z9fJQoxGLg8JBeybMUGcEX8m5fLp1ncTFC22EXWtVegohX8d0fxcrSI5vst4nN4urBQ2rx4dTjGU0JAM44k12z2Eq30gqWWxMxyFPG3Dcqd55x26Q39wDiUnxLp/HVatQqjQloGc+P9kcBkA9fTxm9j6ntMcj848zpid6pdKdjpPq4gDDULt5DCIjvsuFTR+3CsqcUKDORpobSsNgHqSBTajVq1SPxhq/x7EG0V4QHa6/VpRRZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 07/11] spi: airoha: avoid setting of page/oob sizes in
 REG_SPI_NFI_PAGEFMT
Date: Tue, 28 Oct 2025 19:28:21 +0300
Message-ID: <20251028162825.3353166-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 9be63d20-44a2-4d0f-dc1c-08de163f0f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdvFLQMKtPzmWpBArmfqH98WBLEQby1n6B0fgXypAk7VVcgd6YHSJXXkoINo?=
 =?us-ascii?Q?/6hO7DYhXCbP4Tcu9V1E9B1crkLPEkOJ8TsS3LTuabx4vGjlj5FBLSMI16aw?=
 =?us-ascii?Q?QjCuqBRiHGiAWjz5cnK4ulCu8MXcMzeE2DK/iGKEMVCI8JolSQJL2U+c54o9?=
 =?us-ascii?Q?hudgM/1WXD5U7w4ekjJIXNop3a5rQzo3QAvj2rhNy0kH04yWBR6dp6RXQyiO?=
 =?us-ascii?Q?zRfNIOEcKr6UHnYRwCM3DoNzdc5zhJFD0+MMqFh6UtJ+xvRseYTxJX4+CLbC?=
 =?us-ascii?Q?m91XfwQoWYAOs+QkKrW12CQO0EOk55WnL6GR15Df/Un6IFND/+a1/BwuiVRK?=
 =?us-ascii?Q?BcdMmmkLbevzhtWDg1LaYbrNtFA3au1vz5zp5o9JpjXxT3qAe8e7ITlGUak5?=
 =?us-ascii?Q?mJ1CbPkma2Ef3+ymLFFuz6g5tSx/+kBaGDeH7DgL4Ks5OC1B7BlI/3jKJLek?=
 =?us-ascii?Q?pHoj6OHlF5l6AKs1tMmFIFR+TFy98+6Y0hfTxHxdYFAy89bTSMLYwIpa/sLG?=
 =?us-ascii?Q?4d5x/Hv3jZhRd+e4WfdIJ0Kn4rL1r5we8KpgkuG6hrprpLsftO+hlUubdbFv?=
 =?us-ascii?Q?C/+WFe0Lkzh+QgZH1UgkjhoV2O9BVa82khgKqIfx01JraD/H5JhXRH3SSD6X?=
 =?us-ascii?Q?n3XJDNxRWn/57AcreI9WWfoIB4AGcy+FVANEVP+6rKwBjlqcJifpvIjNe4UH?=
 =?us-ascii?Q?98tUNtP6HoJCETUwyyTs2Zzc1O6A8jqyaPf/xAadKfxD1Qe1c5iQqGfMFwpO?=
 =?us-ascii?Q?nEbocgYVYMKIhy6hmc45XuTuOIbuhjq3b9ho1j2/MGPuN5PdqYRnMTkZY2Ji?=
 =?us-ascii?Q?YQeosR0iJwOfd6SBMuEDF7MH5UBDebgt+8coTp7/FRkPUKtCq7VbOP0ghku2?=
 =?us-ascii?Q?d0HndKtfaCExbJsB95D8Y10wjJ5iIUmnrBLqlLaFccB/s9iYwgh5xtP0Ktl2?=
 =?us-ascii?Q?84gHHBkrpFfCafOKjZUErEeDaA5RgOvKtheGkiYsibR+j5w4OYB2OemHVEyI?=
 =?us-ascii?Q?yUmJqO/RO8EYKzYyfE1YF9ZligAthQJrf3VYsv5mG4CIjWQwNyc4Ihb+3YuM?=
 =?us-ascii?Q?vEpEq348l9/0O0sNr4Wl/b5jFEopaf4whgqrsEsn0yPqzD0OkfdkOdAzsSYs?=
 =?us-ascii?Q?uEt2+7kZ8jMB0D7HtFXmNcUb3lRhFmxk1rR7zSFU/INAQXZFfJHx98ORJUfO?=
 =?us-ascii?Q?iNbtrzeFShPaKUWu7PFEgZpiopnT/HXO1gsmXAezAbW3eZaZ7ZRV3xqSk4mP?=
 =?us-ascii?Q?yQuT7BH61XTerI8o0580hsOeaNo+saApd/fIkhy86Xjh4SYVXh3JsYC52fSa?=
 =?us-ascii?Q?Q+R2a/mXyBVjVeFpmuBzjtfT0byVoGshN9gKsWeRmSOkSKU2zbKKwBjvn4x/?=
 =?us-ascii?Q?rWV+g1pWDS0m/sjRKt9cJt6VU0w4UwyOYcNo+XsLl5wAD4Jn/noHsCOPJ1i0?=
 =?us-ascii?Q?7dTiERvq5l5rLNAEAt3clo0j2N6dDz/sJCl6crckD+R/QR7FLCZcBWiaXuOJ?=
 =?us-ascii?Q?3woTcFyWH/fOTFJSdPNisRKVNSJno5zf2Zly?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qs7Noxj9xJjmSVnPd6DKV2i0ju1M2b26XpK4++QfdQtdE69bgbPzHt4jvKeg?=
 =?us-ascii?Q?Jp6SuQ5uoINN1pNUo3d8xe8vKlhULnyAFXLYpfQDnut7ROMOcg+90jTua0XR?=
 =?us-ascii?Q?wlwDXA+KaH0lP71g1o0lZj91Bi8vmHcMiUjMS32QNrJswJiwwaYJD2HOxNZW?=
 =?us-ascii?Q?ar0ZwKF5Pm9SH4MT2sBpwoVsoGjcT25XxZlFdW3KoM5S1ZRQPQZNI+XVkkTV?=
 =?us-ascii?Q?4OLjbLWt6izCicf1e/a+FLuVgBc0xdi2KLUoaR8bP6Y932lk/UKpACcF99Nc?=
 =?us-ascii?Q?th5dvT1iRZ9C0/jldXr4fh/DHDnUSAADYPkpwGCAWlssY1AediAtlhPyW9Xz?=
 =?us-ascii?Q?MB2iP8ihXglLSQINrW6iWhV9wMGlZuqh7EsOdc1zIGiKXvm6SvxSlRqfIZJf?=
 =?us-ascii?Q?+hvLoIcqZzyPciS9F+LRA738EUygXXEkJCk9Hn+UHFVKrKbe7WeOAkjIt/dK?=
 =?us-ascii?Q?9UAuzuHvkL2y67Fi5ao5KQH5W90+fUJwZ0JdAcpG8m4OnLeYaUhZq+ZmrhuM?=
 =?us-ascii?Q?Vov5U4S76k6hZxlKElJ0HQarkByxVhzO7cqU26GNj6WJdFrxh7/o4q8hh7CU?=
 =?us-ascii?Q?Dvu//X7vkqM21/1wYUaIi3VtzY6FcsAGd2AdAEs4DeAkTirsum3B0nc0A5CZ?=
 =?us-ascii?Q?fArocg8WXafnMoY7xyfQXDcdXVzw7KWJ7wVsCbC09uPVZIXDT8NizdRzDV4w?=
 =?us-ascii?Q?V3Fdw4TC8ytEUkO36dkwrTYN4gki939eT/Yxb2nML8agFsvJilriOIauY4ZF?=
 =?us-ascii?Q?Bm3qcnokBCvh3kvJ8xz556d2eNxqNEvkRWo+nxmrYRgGuU6oXg2VyLLX0nXj?=
 =?us-ascii?Q?idQsk8pAnDFvRCHeYCyVWSNCRG+mUeJwfD8VkWMODRZOb3AUwhRWcFdXy6Uu?=
 =?us-ascii?Q?4S2YKtLSj1RYExgcaGSFBLB60YIKkGXOWWvhBYy5JozpWlbM/0ySv7EHsXny?=
 =?us-ascii?Q?caQa7GBt13PUsZRJnTQWkhEA5UeaVrWETHH/bmfXKqCk1W6LgrhuSLkYHkN1?=
 =?us-ascii?Q?Bko86uCf1LP7XipMHKjqBltsh86uOW8MgpPPLxc29sfZF0jPOo7/H4by33CA?=
 =?us-ascii?Q?v7FExpx3uYmqcEFJRiVlOssauVjO9Ozl3hJVt4ujFlPUfh4lnaFRq7v5m7hU?=
 =?us-ascii?Q?z5LQzNBbPSgaC3RLQPwQUsAilqJldXYBaOJikL99ybUgYea//So5/HlyRJJW?=
 =?us-ascii?Q?iFwbs1Ok/NlQLRXFp87tkH0JfUpmboBqh03DZtywUQyozYtToMdwjUeCNeKN?=
 =?us-ascii?Q?ZaizEC5Hakcunk/f4EvkSIP81Il0o1GWLFXNKM99KQ+eYexVCahlAzdDfdQq?=
 =?us-ascii?Q?FzWecDvQzWc78RECGlgyl/WPbJR267vXyngi/gQxedjnZMIIZ6g0Pu56pYRM?=
 =?us-ascii?Q?pxMQcFhWCvvt6FIHvLXOR7zJ5SQldD4R2cfYFAfS0O0buLQNX7LY7oo03c7C?=
 =?us-ascii?Q?OG/knj7K4lcOd6clLBR7Y+0Azm2EDb/6p9ytX0LbDb74G6TqzHDLNAg0X/l/?=
 =?us-ascii?Q?baQOrMzRtayOmvlY4FqwxpzD7Qa/wFNAFc/MkjyKi0BQKy1HRrA6LgJhj4jr?=
 =?us-ascii?Q?0EZXE+n/OYfVkGG1j/AODJtRtdTzDUx256Jj9c0o4Q3rUjFTfNdqm5xaVrzG?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be63d20-44a2-4d0f-dc1c-08de163f0f53
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:43.1389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3JZq4TWkvLQGbUFGbNR5gfrza0LcdPC6tbM5F5XB8FBCczkppyJzptmD4x2c1lGOKQqu1sr9+NDdk52+DmxenNmJspdDy6ZN+oMGcyVQr4=
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

