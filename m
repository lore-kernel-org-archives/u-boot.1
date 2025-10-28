Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A66CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D039B838DD;
	Tue, 28 Oct 2025 17:28:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D4809HS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73D08390D; Tue, 28 Oct 2025 17:28:47 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BEF83710
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiTLkOjAwHbMR8+YgwSTAaNO+etLrG/XbpWq1scW4HrP0s2d/FFUrmZf2KQcSi9BF8pMtIteBKVgikzJapOI3TaFQBq59dT4Vj9ykE6fA1Ecl8+zXNnpTbjVz/CA4k4mPA6m7/w+Gaww9Mgi8wZ1d0xnJabHs190YKttbHWFg/UhIWUuyH5qoltyBw67botP22cpRLrzVfHXQEwYqtySTe65neJjkIPEWp9cyJvfTP0yhtulwcUF6b7peimvgyhLouiiERve+zXVIgDgizB2gWasb3+ylJpZmWhTeHosxzocU9zPhi7jMdCLo1DsvxGxH9HljO14fA5tllxbf6rfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olU1rtd16U0dNWQoI2LKc258+vLQNaFTwF754UlVRt4=;
 b=RjJVXibd2vd7gS2OZd173YqF00wtwBt2LJpyksor6XYgMblsekvKjjZR8m7G7bPijs3bD98iX9xJYpGdwbcGMc45sPSgy1WuCJEvpP5xEsMoNgPLamYFL6ooH7XT3kocjoBaU9P3hwCsm2DOSL8VD63ktyNtjy1jLJFgLVvEXpkdASZQZF+mlF3+dqAoAn+OoXl2mnRxax9VqhoQmFHuEW9RMBFml5M0/owoxJfen0lzGp4fY1eU0vCapMetfk3KiRMGLzkGOx1acxZhqDEU+O9/w0zVvVsAKKHhN8821G2uKX3iQ2oVyCNbkVdn33H0iT6F9jVNVZZUHtldZ/H6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olU1rtd16U0dNWQoI2LKc258+vLQNaFTwF754UlVRt4=;
 b=D4809HS2zzUfeOS11qZP59CtWzIaAVA/GXt+/kI5xDwAOa7pBIAGLuSZ3eOhFAsr4eqzxSlYFPaJP3nFSdQcW9SupI+JXFe0gW9Dg+XNJzJ+dX2DUFsk15g+AbU+xDLxvb/4lW8ZhMzME+zCxde0uFbjFOp+u0q0QrrVoVlp1WWIkrLhyWYMG3VEeAIh+B/rwpb6x5mZoR7AN1t0z4l0vm2FbqrP421z7CQjb6lxEZar/+ZJSEtOHTqlFPxRxyM8X2+UaBZgsMRw+R4ITOHOGdBbYmOd2dlEirCafvK7ySvV0n2PxnEtKzQNR4QRsYEryXlV3kKrOfpcS0t5xo6dsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 08/11] spi: airoha: reduce the number of modification of
 REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Tue, 28 Oct 2025 19:28:22 +0300
Message-ID: <20251028162825.3353166-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 81748518-7578-48dd-17d7-08de163f0fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mhsfU4ZlM84RUipPE0j5YW0/QmJTQ8UZqujVFIkH5rFFCh/YoCx2RIUGNfZM?=
 =?us-ascii?Q?0OfwXImbPpSIRZ7JnMwstQIQ0eph6P8OwshAf8zOWRj2yYssyxJhXjWbqoPU?=
 =?us-ascii?Q?jjNdIPxAzIUlZGb/Iha3zNQK7GaV46JSB+NcwdMT6ApGuQO1/qQ2BmY+0uMt?=
 =?us-ascii?Q?1+0ueZjBIYuHH/ID+SWHxVTqEPdxBuRufcAPE4ybVi4zP91MSh+5iBKMEejs?=
 =?us-ascii?Q?5xMTN+n1GlC+kIEZjAx2tf1WfoRRu0fFZVrf5iNC0p3NSWN7kLqo6ODzySbS?=
 =?us-ascii?Q?TUvBzrtRpOrC6nQgnHoDk6y4/ObhVzk94N42aMgn3PRzMcEDIZaS1dMY7E9k?=
 =?us-ascii?Q?VcOy+kLSoXjNi14hFWFunDjIL6w/C+w3mevtJVgXr9jsmFCR+LR9ZKgNDB11?=
 =?us-ascii?Q?JcybsGJzOyHGLI7DIvHaztwzNanrMs0DiyIaOwyb1a6Xpyq62m7Hu9yO0FAf?=
 =?us-ascii?Q?VXHimNeul2LaIwSCWeDWpVcOajTjVkxoQUKDKh0P4TewW5nd8AbBjvLlmp/v?=
 =?us-ascii?Q?K7SFPEns3ODxwMwhp7T+wWEVKas/3h8M5tBdl8q1d2JP03UU85hwFAQbs7lG?=
 =?us-ascii?Q?fTw5Dnm0L/Uvm8qK/ef88u41PSlETMb0Lf7AAXdTx0R1LJy/ZKsssisylX2c?=
 =?us-ascii?Q?SGVm/g+BiecVVYq7yj9XXRIj46FPR/5qhsSCHnBWa1Mi0SzbzqQrIWL2n/Jl?=
 =?us-ascii?Q?4phCRXLkDCKBCuSEUnfO8mttpr9+1sOgr7IxbzZ81J9xMaXca5uSAZG0GF8f?=
 =?us-ascii?Q?hDwkVWe/05SNikdXTcNML1XpYZR+jWwrZjdtjON3nrQ9Gdff2+u40qmSRFAc?=
 =?us-ascii?Q?ZlLIJfmU0K0A++rD2srnL22No6pcn1AKwRd89eojwTjND6rnugApnQ4NjnEX?=
 =?us-ascii?Q?bSVxaiUpo7LeesdUh7Zl3XoffbzyPQ0HLe4QiHg0K/d2ZVS6tWe8nPL/C5gt?=
 =?us-ascii?Q?EXRWD2CestljAYSIF1OU+glvAWAvyi6Trzr1DBdIl26ZOyIbFhr2wTdEufME?=
 =?us-ascii?Q?o4ujHyb+RGOs9SM/WYeZaRFilEh2GnKO1IeYRyuYZKYMSLmQJhEvL/v1rbIy?=
 =?us-ascii?Q?rzrEna8CEuvq5tAIyM8LAK854BdigF1dnIdtJcTBgqgNUujJBehRP6h5JMwd?=
 =?us-ascii?Q?oqxJ6I5QU5aYIMEkZwlK6e7twZF4znWVmjtzN2xs6ffHCKnLJ2+A21u9x3Fk?=
 =?us-ascii?Q?RcyiROlaCBEj1VdqfvUxIjHtWZc0AIfrmkhBdtmK7yh5wGEdu1HIHShOpoLT?=
 =?us-ascii?Q?jjuxzemdTKgcZSXj0K3/c12rSoV6xz7qzN5/IhOvj+bwSej0Xcirr/An9m5n?=
 =?us-ascii?Q?4dV4z8DOuGWQyTQweHEXrxlrvtw+7r+vJ0hg6Hj5X4G+UhbJCNY5WrqRzyoB?=
 =?us-ascii?Q?FEQ6TDloDC2g6dLYD0NcbdciC/hnC3atpI7M2aXbo5iR8BYIsTZq3WMyWEx+?=
 =?us-ascii?Q?VbPmvlvB/vvsdvnYviTuCZqZ9lFUxFqCjCmRVct1HDy5As9IxkpdFnpKzes7?=
 =?us-ascii?Q?W2M3bNCNwYu9v6l0Szd2ZP0oufTC//sUNSxD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HgPzBTsSVbPK3wJQ1AsvdivBkTJVLKaVFDruc+VzArltlUTpay4tfIlWEAEH?=
 =?us-ascii?Q?OOiHMJEofVCMPF0QkExAdnXVOSfNnEKiI38Xt0kqauyo3y2YT8KysDxx7vjA?=
 =?us-ascii?Q?pqrg1Z6/sxyBDnWvWt94IBTJs9ltxovw4aO4Ttc486IhCgcM5R5T8tQE4lFi?=
 =?us-ascii?Q?S7ysPw+YEKcDvb/R6Rm9BHYev8gFJPL0jOGesLidPZnLR3ZFuwnkVoO9Bb27?=
 =?us-ascii?Q?snM73giebdTe3OYnvNxNPq9E6EKw1Z5RibOk7vp+wocDT9UqNrAdgSTErvmh?=
 =?us-ascii?Q?oBp8hAUc+g4OXi1bc4TaIRMnmmJ5B9QjHybceOiNgVxOZwx/f3fb6iJseMk9?=
 =?us-ascii?Q?JlHAKH2/vUGg1SUVeAio+R26qjnyzyIPuKf+30EzpxEaTII9F4NRmnsxz+7Z?=
 =?us-ascii?Q?3TS3Iv6TNO79uN8OjxmbNXX/aYD9/Ee5afvUfS5+W2xrxZjKUW6/vwFlBqEz?=
 =?us-ascii?Q?3QugVZDyp9JAc2h8Ns4W2rXPZHnspwkjDbCMtu8p3PULki9aa2gTZaaS7/rw?=
 =?us-ascii?Q?8hIP8+9HN50BUucOi/XmWnXzClDdl6alPiSuzK8xE3iJqDTo9+aKmNU9FsJr?=
 =?us-ascii?Q?8EK0CJr0+GKd80HanG2PraCTA3lHoO0GVt1y6J+CIFm1Aku8RGuG1KGqWz+h?=
 =?us-ascii?Q?fQD4ARjz57OWQzCKoibLeXqrogvb18kH9DK4nhzqsWoCMB68XJeInIZEi3Of?=
 =?us-ascii?Q?AqW5h29TPIaZBWnF2nHYOt3Vs4E7CaqPxwSBNrGPJBYpx3/93n+5mz6lgL9z?=
 =?us-ascii?Q?dLnAr9RMawkw+g4/O7WEy5AmaXlhAqy7MPstXyvfzj2rPoKVge/hPXC0H2B8?=
 =?us-ascii?Q?/YPzjg3ZhWGYQlptEf1FW+klf8qJ5MKzvQiKQsMtFMOedpjlf1enwvcVfq+Y?=
 =?us-ascii?Q?IP+3IcDWpknvrNwmoR07sL1QNaHQxb10thXcaUxy//Y9NMyWd1ciqLXAGXXl?=
 =?us-ascii?Q?vGUZ4rnlB1yvRVDd3NJ+Vr0q2ymC1ajgNdDOKRsMZ3gf0AtNKdf/SgbHES++?=
 =?us-ascii?Q?LirOESq5qNtbluckiAsAH7O2Jg/t4oJ9hecsH3lDR1IJxN0zaynDzVZHoqWS?=
 =?us-ascii?Q?51bcztH82c8zCalDsMKzXau1cFbXr36dTa2wc538nikpZuQ0w+vBPXp3Apc8?=
 =?us-ascii?Q?lBhZ8TsKty+MqBZddVfGTWbBjL1NIHNoRBRvcTCvBtnCXZXkPZePVWzvMYRP?=
 =?us-ascii?Q?O6NM1d37swW+FBfLA6vgRC5Y92ARQytYcZDzsF1NE/XNF/tq3pww7lwh92LM?=
 =?us-ascii?Q?8Eavg1OpCpS6vQlGtBh/PWMg/+exwqG+AkAbWwqHGhRL25kuitq4DINmQtp2?=
 =?us-ascii?Q?II7p2texPMq2rRFfBwfvl0nk82g1fjOAOGjVln05rfZwkV9UQ4Cg9eDNltOr?=
 =?us-ascii?Q?Eob3BryiKNXbNx8b7aatVi0ZLp240tOxSFQgb3glMP6LL1miOHW7EroOY2tx?=
 =?us-ascii?Q?pvT8xbeFAmxl/2Nl/R40n6w5oDuC7QgXIDrU/qvi538FA2oeAn8weAf/DYmQ?=
 =?us-ascii?Q?FoUTlELfG5iI3IsdZIwSSA88xkwkEhSGPTsgKHLyzC36QtAOZrjPYNg70mGl?=
 =?us-ascii?Q?PaosMDniO7hGFHx+uWagiF9pM9cyUXWBHiyKMT7oPoBAw8maMpKzaSylBVGV?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 81748518-7578-48dd-17d7-08de163f0fff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:44.2567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mijTpG5Dgj065p6MVeZI3jo5XZ68kLwRRXjgIj/lg7Mmb0jlcyUDK5S0jxUclRp2Pev7UY4ToORTgr/BY6JOWFhIJcruckDYLjb3NVzsICg=
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

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid usage of flash specific
parameters.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index b136f8b26d2..55194648d9c 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -645,7 +645,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(priv);
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = priv->nfi_cfg.sec_size;
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -658,7 +699,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
@@ -685,18 +733,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -791,7 +827,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(priv);
+	/* NFI reset */
+	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, priv->nfi_cfg.sec_num);
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = priv->nfi_cfg.sec_size;
+	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -804,8 +881,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(priv->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -830,22 +915,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.51.0

