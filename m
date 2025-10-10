Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8ADCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2D68426E;
	Fri, 10 Oct 2025 21:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="kZGx+iAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1ED83F8E; Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951E383FA0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBfiCnACFLefu22I7YEV/2vfI0Pabr88j2ADOaHO+eUYfM3niM4C2CM+KGHOcu12QNJ/qG4umOut7X1dieUWCObe3tFtQclLm/cCUYgPI2/CabPxBbYZPE3G7oU+BBcGQVuMsuBZdgyG2bJ6iaoygLXJXcw6uFQbYaT5dYDAXBfP2xgkgmtUEdy5IsKUa+o7TDcba1jzBs3eaIckhKYsNf/x2Am5i4JtW+bwqVsbOaDo12tGzALlhUok1MPEOXjOdxYL/xGV6H1Dp8B0UvLqcq7G1fKE3+4u0wodxUm0uHMlvbhG/ZNfSxm4n9TdosDxmA9kAEURpPRWgqezRantYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=JVtWAaNlC3wIJvqSHnsCWxFGP0LVPVVqmf9/R55WWYyYrimiezyq+WILQPJbE4u03Ko7zK+AjpglqS0ey+5FlJl4xAoflWnpas/Qc+hIhyE//JSoQXSFc7FIXWTUZZ2rBU+/gaTapshhF2IALPe2L9Xlnn4lRetN6qQBXkarDdSOEbJRuRsdtx8Kok2EfiBfpC85qD/Paqusza+vVHVe46QOVHixJqIDeGdQHR+5uJgFc+51EGTO/85UWvN3wHo/Q4dg5DRC4kCZ5L9RpxqnWFYy8vIYchjnsYqrJaUNiou3NlNzYeYHI2U35wcZTQ1iVG8qxjUY5B7+AfzAKpG83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=kZGx+iASf+WWpf+Z4H4dMKnXF0j3LBV1DFrBoP2azLR9QAfo1MhIyn0Dp+RdQlckAGtfdJb8KhgPbZSASPtShp3D4D1LGkkB//FimLBpeE92988+wm0c6N+opxikenHEZJ4loQ/TLdHtNLBmpuq7Wr0BhL2sW8LaMCSQxMk4p9ZwPv1+Hml22Ef1ZwykOTQWf1kBUzv0s7LyIhopV8Qa1OXQtyEhPgHxcg2raXbaXk9R0jx83WsxiPzfP/VWZPdRoIY32It1FlhAev0GXaqE+sVXcwG7+tj7z47oslbEpzFtZMtUjqNgnPw+Olq7AI3bMjUD2JBL2Exs1bxH5okbGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 03/11] spi: airoha: add dma support
Date: Fri, 10 Oct 2025 22:08:33 +0300
Message-ID: <20251010190841.1590130-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3e2496-64a9-4295-f05a-08de083072c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g4y71oquUKEcOmejC2SM/DXn9t+39yQFizsnwWKv68x5+Qlx9RPiMU8muOa/?=
 =?us-ascii?Q?BS82NI3rzc4oTFq6GEYbi5Q4gxyVD1ZElx7ng4wEV8a0knLd2DY0i9NoGtWg?=
 =?us-ascii?Q?JFg21Gqh7node5csk0lyKnB2DenOvZxbwfKqTwfDkXYy1wqcfWc6f+dIvo+2?=
 =?us-ascii?Q?aLUhNLjhK7HVktCUAZjgEZtoKYO7V17mpnW1uDFiMnCJ2CEk0cyhGKrxuERm?=
 =?us-ascii?Q?vICCVkC0uX+oGO5vNlsY6OYje/et0W/G432cC68JTg7Z80P5Nfo2a7sNuAIS?=
 =?us-ascii?Q?wP+UZ500fXKfaAEwCrO6gh6wRbhh0uEIRnT36m7A7l82arOFKsaS4vMYEJ4a?=
 =?us-ascii?Q?/fMx9TWak8yHXl1gtkseNrxzukIyOs9jHxXFI96gGw5z54V8saiCFjB/X/9O?=
 =?us-ascii?Q?diCcvEb5Y79ebuggMmxsgaWBl9RCSEGJIL0SWbnFILKMDvreCJCa/xAg57W8?=
 =?us-ascii?Q?c8JlwzMLnu7Hlz4wiwQR+OnIj8BuUzSiS8L6XsfOxO7qLMw5pbneS0GOLry8?=
 =?us-ascii?Q?CcsHiZAdQrnsDheFAkD44E7zXyqPNh1bvuAUxZQuUhuqEycIMKy6u0fz9sjK?=
 =?us-ascii?Q?yJsBPiEWbyAKI8oyGY3TsiJYjjn2Arfee5498iSE7kdY13Dy44nvY8PwQPpl?=
 =?us-ascii?Q?gKAO2xdjBpyMXLQsaczDtYi7xy14fKTyztGnpe1HE9R7k3s2L1U5BGkyp5gD?=
 =?us-ascii?Q?tuOi9TuiaSf2t653/9bZpKl11tkJcQKoc0tl7HXF1ZVhOB/JbolCjzicfMzq?=
 =?us-ascii?Q?iYynDJD0fJ/edkajeXWcD41oRIk8NkzccerzT9bY6j1RI4NCctgLiA9Qyl27?=
 =?us-ascii?Q?zjUmUBeQ9GHVr8RFjfqS6K0FyraplMQ42GmrnSPy0ZkClrc/uIYKbGbsziWN?=
 =?us-ascii?Q?c/o573Q1QggsJ48EKEV3MllqJh3Bvd8SEmoIRyhdr6vO3veaZ8QPQzUd2XBv?=
 =?us-ascii?Q?zxt504QiwUCENyKg6nvS0LW9NTFOLzrNBI1QRgUT7GZkhXLmbViEvZu4BpFB?=
 =?us-ascii?Q?xgSzAkMmnfqnZK1xMjTowUxTRm9MvwnI82SNHg7AdvDjq+kT+m3yQJ3fsHUu?=
 =?us-ascii?Q?8m+5Mq7HCJih1D0RH2o2LtXVOZHrhbqysoF4baYaFq0OaZac16M5MD1G/m4a?=
 =?us-ascii?Q?fwSbf7salaLQboGhRNvJRTe91LF9xWElIEUdcf3H6kBNWTepn3iMiEbP5/vz?=
 =?us-ascii?Q?ZgZe45DA3oydDJkVgHFLQ1DPRbCPed8D7QmgyGqIgLrlIivKOerJr68LVUn9?=
 =?us-ascii?Q?TJyM7DnjkH7+fW7hwlmnL3LoRm6KsDtb7heJXuG19UKCaqjJTwfBzZXpjAmL?=
 =?us-ascii?Q?AmX3kQ8y+X4ZgtQ73jGwqk35xCV+rTWxlibbfdx48S5k9cU0nVwyqLAbXIhR?=
 =?us-ascii?Q?zyUcYstww187O0LL6GV5jUcm4DsCw6pT6lwwiaTcBr22gz/0LpG04TzDkvWJ?=
 =?us-ascii?Q?K2SYNOvrDnmUUo6I96oi69d2vzKEgpePnrmN16HTAqUKTPEc3htnaCyfQxWj?=
 =?us-ascii?Q?V2N3bAKXKjWciLd4yXd58TegDmF3wSRBfgnn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CIYO4uwyoBTMdY2xGg35W0/Judn7oAIjXPziPUGmlfsUlXGd0ya6t0VejJQ?=
 =?us-ascii?Q?YgD5blazqyyB5RjoVW66vuAUEhri3JRRgzpaSzAu3+S6agQ7PwDD5zXMVV5+?=
 =?us-ascii?Q?rZppIH0XjpGYd08NSXzK5+rCpMGNDNRWOi5h7vQGJ54cC4iPoTbWf/N5PDsE?=
 =?us-ascii?Q?Y/gMh5L4NOi6ceCTX1XXUzuvssFsm4tg/pI36zmYZ8bjKEWMHbD0e/6ATlCp?=
 =?us-ascii?Q?Zp1Ibfo3XGHCElh9FWT+b4FRK+kML8p5sDuXzYh+MMBLxCsHj5VyYUHyAqjZ?=
 =?us-ascii?Q?e32eSAtD1Tl0YKvwxaidwuCSbYDcuyQ6UERCBjhNNPalZfqN7SL4JUTF+lAG?=
 =?us-ascii?Q?Cbbf0TAYi5xLgRCFSs1/XHeoHDc576sUcL4XOPpikTelR8i7FF8uzkDlF3SQ?=
 =?us-ascii?Q?AfUXzW/G6yDR37XwbayCNbmBVk7lemca0y6e+Uzm2SXeRADvGW5lXB55WW/L?=
 =?us-ascii?Q?E4VgJrIObsMMQvU5ugoZHUk1LCRSKcTRvGEed3zqE8qQ52vOQ9xXMUMowov3?=
 =?us-ascii?Q?Q82/zpGdcvanbqRwoRCLPHHcE53cf40V9rYiMEBfMXmW/0HEIKTgcwrFz2uM?=
 =?us-ascii?Q?fP31fiYV9csTrxerUGe0a8qS/ntx53ccca2KAY2ztm5ExbE0pW9wYgPLKs1v?=
 =?us-ascii?Q?qjm2S2NrFEVPqMn+5l+V9qwoJ9iSS5Qwmt91qJ4rgcfjjcrsZ6XQvP48axC8?=
 =?us-ascii?Q?v/64WQXiV2xeC9L8pX2PB0oPJbH5UH5VtRMtyr1TQ4pHLtbBzetPFSOs+Pdy?=
 =?us-ascii?Q?o4QmWJc1EorAbdiM8bEt1Z5+DYXtNSmxLKkwSp5nXsRLfR3Dkro/5VAgfnDy?=
 =?us-ascii?Q?Husegt4x78Glkik7s8ac4rnXvIcThVggyDJEP55Mr7z4p47NTuji9tO6rzid?=
 =?us-ascii?Q?tt3k4igqBbjHX5nOeJYGR+FqvXx2WkvxtYqdjtiHd+R5q3ouTHUyQNG1asql?=
 =?us-ascii?Q?jylGUl0ycrNO5TPMCuq9oR77ke+wTb7Quutkhf1sTxbrd4w4X5EQ36Eoi4U5?=
 =?us-ascii?Q?JTBCnD6sK6Uac8KXrUuYG9LgHyHDN4KwRj8xEY98KksgQmAsLEu9UjzlqLWf?=
 =?us-ascii?Q?X4wlbh4QCpQD3xduV09bxulyupamq/4REIc6QyShZBTuHH/6g97FkIVxDihh?=
 =?us-ascii?Q?cyjZZXvNS5zX1nHFJUe8Ntl7H/Vjelzx90D5XoNxY2W7Axz3DTpiYGaIJtOR?=
 =?us-ascii?Q?Hb/jbLYcNeCzKNCoYBO39kcZjdmEG14tSTZt0pXisgFA2ZWxCoQVN3644L9e?=
 =?us-ascii?Q?6Jlulcy8whSySnBtxq6EVYifYO8ZH0IvFMsm/0aKnS30yJoi+h+3TufVGulm?=
 =?us-ascii?Q?WyeR1bqrH/Huc4nl6vmYd8buf/FUmsGcCajbn3/hoK6lK2Kt6c9OfTlQhLNc?=
 =?us-ascii?Q?gyJmnLFUxhpVbBguY5o3aoY7S7Ca2QpeckmlyV1n9SbZfrcmIHpFKWYtab5N?=
 =?us-ascii?Q?GutTbmtHInETxsd+nqU4RQ5weN2PYAxFOjONGbEB1+/unSfGFcDps0AWAOHV?=
 =?us-ascii?Q?SzNaR6YgMGZzzBXHwaIFsSxD/EJeRTz+XGyGyAodDFRStqpWWI8T/W9rQA2p?=
 =?us-ascii?Q?uKE+SzKKNfU9DEHIOYGAGr64N1tG5fF8WidCN3cJ0yxvSNRrsSqIDMBZ67eY?=
 =?us-ascii?Q?XAiKbLnXZfPx+tvXLQOVFms=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3e2496-64a9-4295-f05a-08de083072c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:51.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtRDcu1CenqNJFgKrdrU5MRjfNVf8NuBGO3USTbsc2Y6UaXllD787YkhC0uygtp5Toz1rRBZJ4WYsk5cehJGsTmG8gx1uFGMDUMHbwJT5pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

This patch speed up cache reading/writing/updating opearions.
It was tested on en7523/an7581 and some other Airoha chips.

It will speed up
 * page reading/writing without oob
 * page reading/writing with oob
 * oob reading/writing (significant for UBI scanning)

The only know issue appears in a very specific conditions for en7523 family
chips only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 309 ++++++++++++++++++++++++++++++++++
 1 file changed, 309 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 7cd409ba44a..f72d11f5b19 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -141,12 +141,14 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
 #define SPI_NFI_PG_LOAD_CMD			GENMASK(15, 8)
 
 #define REG_SPI_NFI_PG_CTL2			0x0528
+
 #define REG_SPI_NFI_NOR_PROG_ADDR		0x052c
 #define REG_SPI_NFI_NOR_RD_ADDR			0x0534
 
@@ -219,6 +221,8 @@ struct airoha_snand_priv {
 		u8 sec_num;
 		u8 spare_size;
 	} nfi_cfg;
+
+	u8 *txrx_buf;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_priv *priv,
@@ -614,6 +618,302 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	       (!op->data.nbytes || op->data.buswidth == 1);
 }
 
+static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+
+	if (!priv->txrx_buf)
+		return -EINVAL;
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -EINVAL;
+
+	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
+					u64 offs, size_t len, void *buf)
+{
+	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+	u8 *txrx_buf = priv->txrx_buf;
+	dma_addr_t dma_addr;
+	u32 val, rd_mode;
+	int err;
+
+	switch (op->cmd.opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+		rd_mode = 1;
+		break;
+	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+		rd_mode = 2;
+		break;
+	default:
+		rd_mode = 0;
+		break;
+	}
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err < 0)
+		return err;
+
+	err = airoha_snand_nfi_config(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_FROM_DEVICE);
+
+	/* set dma addr */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR,
+			   dma_addr);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set cust sec size */
+	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
+	err = regmap_update_bits(priv->regmap_nfi,
+				 REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read command */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
+			   op->cmd.opcode);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read mode */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, rd_mode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set nfi read */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_OPMODE,
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
+	if (err)
+		goto error_dma_unmap;
+
+	/* trigger dma reading */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_RD_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_RD_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi,
+				       REG_SPI_NFI_SNF_STA_CTL1, val,
+				       (val & SPI_NFI_READ_FROM_CACHE_DONE),
+				       0, 1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/*
+	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
+	 * of dirmap_read operation even if it is already set.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				 SPI_NFI_READ_FROM_CACHE_DONE,
+				 SPI_NFI_READ_FROM_CACHE_DONE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi, REG_SPI_NFI_INTR,
+				       val, (val & SPI_NFI_AHB_DONE), 0,
+				       1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/* DMA read need delay for data ready from controller to DRAM */
+	udelay(1);
+
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err < 0)
+		return err;
+
+	memcpy(buf, txrx_buf + offs, len);
+
+	return len;
+
+error_dma_unmap:
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	return err;
+}
+
+static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len, const void *buf)
+{
+	struct spi_slave *slave = desc->slave;
+	struct udevice *bus = slave->dev->parent;
+	struct airoha_snand_priv *priv = dev_get_priv(bus);
+	u8 *txrx_buf = priv->txrx_buf;
+	dma_addr_t dma_addr;
+	u32 wr_mode, val, opcode;
+	int err;
+
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
+	memcpy(txrx_buf + offs, buf, len);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
+	if (err < 0)
+		return err;
+
+	err = airoha_snand_nfi_config(priv);
+	if (err)
+		goto error_dma_mode_off;
+
+	dma_addr = dma_map_single(txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+
+	/* set dma addr */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_STRADDR,
+			   dma_addr);
+	if (err)
+		goto error_dma_unmap;
+
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
+			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi,
+				 REG_SPI_NFI_SNF_MISC_CTL2,
+				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write command */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL1,
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write mode */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
+			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
+	if (err)
+		goto error_dma_unmap;
+
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				SPI_NFI_READ_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_OPMODE,
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+			      SPI_NFI_DMA_MODE);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
+	if (err)
+		goto error_dma_unmap;
+
+	/* trigger dma writing */
+	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				SPI_NFI_WR_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+			      SPI_NFI_WR_TRIG);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi, REG_SPI_NFI_INTR,
+				       val, (val & SPI_NFI_AHB_DONE), 0,
+				       1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	err = regmap_read_poll_timeout(priv->regmap_nfi,
+				       REG_SPI_NFI_SNF_STA_CTL1, val,
+				       (val & SPI_NFI_LOAD_TO_CACHE_DONE),
+				       0, 1 * MSEC_PER_SEC);
+	if (err)
+		goto error_dma_unmap;
+
+	/*
+	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
+	 * of dirmap_write operation even if it is already set.
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SNF_STA_CTL1,
+				 SPI_NFI_LOAD_TO_CACHE_DONE,
+				 SPI_NFI_LOAD_TO_CACHE_DONE);
+	if (err)
+		goto error_dma_unmap;
+
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+
+	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	if (err < 0)
+		return err;
+
+	return len;
+
+error_dma_unmap:
+	dma_unmap_single(dma_addr, SPI_NAND_CACHE_SIZE, DMA_TO_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
+	return err;
+}
+
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
@@ -696,6 +996,12 @@ static int airoha_snand_probe(struct udevice *dev)
 	struct airoha_snand_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	priv->txrx_buf = memalign(ARCH_DMA_MINALIGN, SPI_NAND_CACHE_SIZE);
+	if (!priv->txrx_buf) {
+		dev_err(dev, "failed to alloacate memory for dirmap\n");
+		return -ENOMEM;
+	}
+
 	ret = regmap_init_mem_index(dev_ofnode(dev), &priv->regmap_ctrl, 0);
 	if (ret) {
 		dev_err(dev, "failed to init spi ctrl regmap\n");
@@ -769,6 +1075,9 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
+	.dirmap_create = airoha_snand_dirmap_create,
+	.dirmap_read = airoha_snand_dirmap_read,
+	.dirmap_write = airoha_snand_dirmap_write,
 };
 
 static const struct dm_spi_ops airoha_snfi_spi_ops = {
-- 
2.51.0

