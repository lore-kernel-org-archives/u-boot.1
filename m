Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1868CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6608583F3D;
	Sun,  9 Nov 2025 08:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="P84jUcy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B4183F33; Sun,  9 Nov 2025 08:07:23 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DB883E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsXGnHTHSqtbiV/YWK1+i8wPFAngBaiCm83en4q4sVGu0TpbdLgoVNtoASNlcgXaXjpnhoNyC55aie63VxuDamnGxnWiwW3Xg5FzHkPOI4/5thEPkPMF7lfPiJq5gYqLZ0Cejme7+fOk5HMtnLkHkgeVGKyVujTnhkgVclXcN36h88sGxejUnz2PDm3fQ9kcs6MLZbdnOlUzr5t3mmOMxuflmXtl7gI031Vt89yQMZ+Bx+gr7LAsRlwqQqKFB8EIbuznzH8VG1SR1/H5IbAMoGc+u0nQRj+PwGbGtMu0fSXqDO4m4Af5sniHwmF6rgM49dDhI0PSZCCgMH6eqjR5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yBztEv7L6PTumJhaSL5gCXJ0OzWPTAgAOeAvbbi2Zc=;
 b=a+PW1caaWFBROZgRUUgLXVPGCV9q7msR7+AdiEkXvRGkijOFXKFQCN+DcM2hTvJJ4ghdCnGFcbQ3XxwVgdB3Eczcdiv7NklZ/p7Ri/Zuo6+h83Z22zEJHwbP/J5duB7vEotmSAPUE0nNvBjQgHW5X4hNBpQSWA/gy9bw1MmIMeOvzvF35gfiLv+eBNRS0zjLXj31gIFtQsFvikWq3LrrTCqjboqnEBxHhg5GaP5B9KkvoSMVH1269qQerb19hb2iQ8sgeWgigdcdWzP76Mcsz2BtOc2cQ6BNFlgtzQS8bTNEdnzPHDyVD2oZqAhxNu4SF3mrLh0SBrYgWEy5vkGbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yBztEv7L6PTumJhaSL5gCXJ0OzWPTAgAOeAvbbi2Zc=;
 b=P84jUcy4vVeShQvxTnZWyGMDyfGgm9R6/h42a90DJZfbTcw7cQ0ggJZ+aQtjfQ/ORcLsChsYDoZ+MfaGsDgJ8Ow8hB/PQRy67MNyDRbcdVcZi8dspY7Hv3zP5NxJ8g0wHlKuNMlMhc5A+bfVWGEWiwDJlcXZQ2zJ2/6U9WeNXykbZCcQtzgGYgr9aS/Mxmaj/HHT1K3UvUWRE4xp9Qt1eYERgBPU+a53H++oF4nw8ElqOVuc4ipgy0MkCX1B9LsO0ZZvxhBC74E5VmDq60vcylKyQDW01bS9wZ0CN5mv0iOv9H9MmfMzl1lOkc7aORL6BsYtWi7qOIXshJg7zqE7LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 10/12] spi: airoha: set custom sector size equal to flash
 page size
Date: Sun,  9 Nov 2025 10:06:56 +0300
Message-ID: <20251109070659.801344-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 27471edc-0f39-45c1-ec62-08de1f5e9fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?daaWXmpyGA5jHqb/S2CVi7r6XWmmK9+fUiHKF2oYWa5x3N1UTXA+rEg9cKxK?=
 =?us-ascii?Q?WVXwQjiSSUR7snlGt84UJ2yTT8/4LE7BeYpJqan8X0Z8GVlNKzLoE/uUpJ7t?=
 =?us-ascii?Q?GEgb7VGcY9VHnzh9s2DdkqyRu0bxcZeEc94PxNDBR0j4b+AKhZm/+TF9+bhv?=
 =?us-ascii?Q?76pqUYcKtfJbYDjKtuc2gKJKK6f2w7PEMXDIYU8dk1i/a2bHlQkequ+mnYt6?=
 =?us-ascii?Q?wWhAZBWn97OzqR5AymjGluncpYRAvVCOQAyp9ky3YuTlKQPV1T0yYuIcv98t?=
 =?us-ascii?Q?jSUqSs0QuvReNitqU93v5Eea+DuOLQ1iSpHmFJ5gxhfHwJ3e02aj1aZw8cpK?=
 =?us-ascii?Q?9W14BAAMWLbGABmtvshcbBhDjo217Sqdxuae3W7dRuEFeTSB9C44F6owKUvR?=
 =?us-ascii?Q?Lw/NspUdE1/pdO60SoGRr+UONYHCLzxm9TTds/0IzqpjiXdTFNWpUYmkkndH?=
 =?us-ascii?Q?rq6s9lQPcN4u4jPXSDhgExQ9ufY1JjV/5sCPwn9NObRZeM4TcNhz1QxJCxAb?=
 =?us-ascii?Q?uWn/jM3Qlb8H1tgJbOHGG6SFLmUVnOOObQu6+i6Hf1InvzcZ7T7UquuIjkzl?=
 =?us-ascii?Q?Ka0BP0SumuCsYsSIWwhSyCCNWyu3A7De0dQpUC3x9hgDTsX85VBTeO5HgcQL?=
 =?us-ascii?Q?rpeSlkQa4uKElLCIyhKF7+aBhW81uLZaSifVq0MhQjlN5gKIytVC/yMtBpbc?=
 =?us-ascii?Q?r5u+bE5SVwPnkbTMFb2jLfM27JJSbf/R1HQm7LCZDgWEfrMz183U4b5rDUAr?=
 =?us-ascii?Q?I3bRkGGGfYbUNOhWtwOeSi4UjO/RQso2zV3gDW8Olkgx+id9Vdvq4PBI7yOW?=
 =?us-ascii?Q?YaXDOPLCYRk+lXHTVxtbNchhKW8uuje9mD0W7p2WgpYZ1HKTpjS6Bi6rp9TQ?=
 =?us-ascii?Q?mKWDpIqY1GlB/7Hv6tBHiD7gLEX7kx5UDMFyEkvo3C0Oztyrg9WJbtJ9xerd?=
 =?us-ascii?Q?Ny5MhKYN+SVbQzkuSTLm4ZOqTPfORRXklMgazFDbCs9c2X9NJ6IdDxjzLbdK?=
 =?us-ascii?Q?0BEm2cXJ6gwRkLqHiAUWeF/MC7n4onPM6n0E7fVdOVHZid1YzsyZa6jCNG9R?=
 =?us-ascii?Q?wblJ9zupRdwViuW0ouU9F85VyEwBOM0GpDeSsddmQVDTTnXxEJTaRDJJ/TSc?=
 =?us-ascii?Q?bNN233QYVjemCItXaLGCzhRXMwCTYwmcit+x4BjKXC7uuuRJsqssvL0DFQRd?=
 =?us-ascii?Q?e8i8XfqwErkpjJxlWCdakr9l4eQEzXQV9+Pe/XlHQ9Kqr5DIHQeIoQSIRmHc?=
 =?us-ascii?Q?wvU5+XacgNLGc34KwW96rvohoOoqsBjsjroIAoexq4aqyNYqgLN5zijhltPG?=
 =?us-ascii?Q?qwJNsYSCjUnIuzmkpqkyDi7eaOZzqCIU3gJlTGWEzXzsU/d5QuadTp2y8vaJ?=
 =?us-ascii?Q?vJua7IKcxUCzfjlCdBOUXfsExPZTK2EHLvbi53+vMzG6Rz9eqaniVokn9dJD?=
 =?us-ascii?Q?seIg3mHMfnG5Yai8PjHB1DxkVNIirsK97wvYX84+QQyGduDZ7u9tJJjgGnO8?=
 =?us-ascii?Q?tN/+CsC0rqnmVMHKwNiKlotlZm6dG1iW/6p1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T5V4dUmqN96Z/brBloOFTwcTkmdRcuSxUvukjA4dDZHSNpAZwRxrm7QiyS7V?=
 =?us-ascii?Q?MC8A/fv7+7qJDQ+mjDWqrUVtfUcBUQcjvaEtIVO6HtbtjIdQ62hMpY4thBwx?=
 =?us-ascii?Q?vomHjuZ4Pfn+fBKdb3qTG4uy4ghI8DTehFq3+Rf8qEflHWevz9vJvrcA9znY?=
 =?us-ascii?Q?roU9IzHsA/SjqOmsuPymmgv6ILEK2T61nN6whiIb6n87+GXflqlqL1H0VNym?=
 =?us-ascii?Q?HWtP0goImNkT0JoP1UKZx/31R9FSfE5UZ9yEdVUycA1QdCcD2kjILLBJBR7v?=
 =?us-ascii?Q?H2/JNEvpYDCgIhkfkCJqmUWLSyKB1AnO6zoI41hYjISQ/A8Ibo5Q0ALQ3+Fo?=
 =?us-ascii?Q?KnOSQugw7/bJomkfT0yOTZRI64EeFyjxc2CWZBlOsnUShsEHobtf/UqPuz2w?=
 =?us-ascii?Q?TnN0znPY2Q1VoNPZ5xF5ElNpakMxtDtssPu/ArYrKIghEMpxafLhf4D8a2bT?=
 =?us-ascii?Q?lb04gjm30mMwQiKB1BciS5ppXbj3VWuUYr4f2bBFOFsBC2Oj1Muzx/QBDiWK?=
 =?us-ascii?Q?1Gqtt7z6G1p7K10ylXALKuhfbeBTMR2gj9S8czLSZKJjGY7fHijPN3XpYHd2?=
 =?us-ascii?Q?zdD3zVKCYaBuBJbPZlCg3J0g1YMllxOLcpisnc+4haemeAts8e/6k2rkxL55?=
 =?us-ascii?Q?fLn4BjQg+FYaU+xOKdmpjaaEerzwZ6n51IWCzBwi4Dtgg5+GM5DGATflaXX9?=
 =?us-ascii?Q?OwqSmpjV3VkSMVjjU0UQP2+ljyg36XdnF0v1axrZlLq6c31oe8MVXHfoK/GD?=
 =?us-ascii?Q?B8+1fSHhVdDhRvUPqjra1PjTRlYUuiPR6DYdLHa5ZOU/ogvRKP4XmauNbGAa?=
 =?us-ascii?Q?SPUMz1b7UbrOOV/8bqhU79ntFbju6WyYHiNgTV98fv6P6hM9a+MIPOwaArAp?=
 =?us-ascii?Q?uqoMK1L1FagiNiGVy7w+JA+72LKUKYlPdyXn7s3AABFDsX2YIDs2hRMsTE3W?=
 =?us-ascii?Q?/3mVCI/dyb0kuvHgVW1xMuaCc7N7NVkB33/r3q46SxGA/FEFzL64Xl0Z3pdA?=
 =?us-ascii?Q?lWlwR/vQUnEoi9MBL4wmkEEiJJfK6KAeQw0uI7jjHszbia+8fB7ska1KLFoh?=
 =?us-ascii?Q?3jP/+fXXAjDUtAXk5J/dhvfu/Rjqt7z3lA8yciJFR8tDZsElN9VvwI9jLUip?=
 =?us-ascii?Q?ez3VSrHsGsp8jpYOlLd/NC7BN2pNx3ugV1vlhX3CJ0zmyiE5NjbsHASGtPgD?=
 =?us-ascii?Q?ykzH4w2O/xqK8todiiejiGD1otvyceseZoZPrA9LQwDIJS3khY0VoLNJmefw?=
 =?us-ascii?Q?BQ+neq/fDsCH4x6qDfQJDHOufcyEE/Yok7Bz0VstW3+Llr1PBoUk0X0ihLbP?=
 =?us-ascii?Q?yoRs5fhfeisyIIULXnMs7gOGm8+np19O2hYIqXQ7s//NCV1dvLH0BYm5XXCX?=
 =?us-ascii?Q?bqyyNndHiUvwf9ZnJF9MU+YPALZQXZyIk1gdhLdEhhJnN7W3RI+zE7Iqt28Y?=
 =?us-ascii?Q?ndIbs3BgedSSgm4JSc23TnDLOuklyEAnTUYDdWpKlyFBSVBRZxcIGuXlhlJ9?=
 =?us-ascii?Q?jz9ymqTJ9OxyXkm4FpvtqKHK3D2FenPqK7l4fUAGQTDZnv+EpzZ2ATQCHLA2?=
 =?us-ascii?Q?dDZ1bl10N10cn5Cda8f/EdSBgCSWAmqcWLKS9MHkcdHAQ/s0mmddccnnTiLp?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27471edc-0f39-45c1-ec62-08de1f5e9fb6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:20.1718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3BYWqmtX9cosnSNcKIWXBcP9tltGijdHbRPqQnge540W1OMCicWgskCZbDy0kjrIm1F1RwZbt0fNJ8z2Hmf9/l3JgVTAqsVJvxUzs2Wwtc=
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

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid usage of flash specific
parameters.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 55194648d9c..f1f1a5b9d8d 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -515,7 +515,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -528,7 +528,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, priv->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
 	return regmap_update_bits(priv->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -614,8 +615,11 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = priv->txrx_buf;
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
+	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -674,18 +678,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = priv->nfi_cfg.sec_size;
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -707,11 +710,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -800,8 +802,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = priv->txrx_buf;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
+	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -856,18 +861,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = priv->nfi_cfg.sec_size;
 	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -889,11 +893,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0

