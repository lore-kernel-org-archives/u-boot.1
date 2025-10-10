Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4162CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D345842CD;
	Fri, 10 Oct 2025 21:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="H8ZrVyV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0ADA84374; Fri, 10 Oct 2025 21:08:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F268083914
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8h4vYNzuko3QkcShg7R7hNUpago7tg0KojbFlAfqniBQxSun5SPJlM43znjjLFOoDIYIROgtCUgovbs1E4MDddjGd64LiMLbPY1R1gZ+hpNAVdIwuvb1+6IsVvq0YoGfMYeMMrSRF1nZwkJWHCVwRs5IdEQjHC/ggXfv/r2CKC14hLoGdlatiRjrjSmTv7ercsrb+R6N0CM55zssInNYKgP3Suoj1WK7M11/jXxQhde50VIMlg9No+RZpsjBQLUATuyBr8saeUZ16zCMAgPvd1ji3wPwxD+h16VcjcI8Ses6Tmi4/hT3h7gfQtrqvolAOTz5JT0lXeRqb2SzDIjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+2utjrtVEAmyAMOxh+J1hWqn8/aeFTOIGWM6rMA8/E=;
 b=XCB8amEU68pv4VZaZvztzCyYFV7ok+DIFXSLWMQoXI7vadkHAKSjC0sE2wwff6lUHXYUrRl7lOyTKu38y6Hwsqy7cyPvJvJKrI5tdDk526NLiWBZyhbrGA0EkpMVuKiUf3QUmG1aKJF2+cRu1yp5EdnGbfQNPEM8be5X8zUK3cVvdi3l8zCnO3k4hT499rZxSnpPh0uz91t1xXkF2v7ZT5TaqyEyndpeB5e1Fj8EhGpYgbyL+fGsNkHK10Yom7skwCu0b3g88mVxkqBv2cBHBqLoXlTWob2qaFWPxLTDrKFw9uV3zdRDIDh7SenoDRtqaLWZMV77m8Jd3C1ej15PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+2utjrtVEAmyAMOxh+J1hWqn8/aeFTOIGWM6rMA8/E=;
 b=H8ZrVyV1Ny8XY7Wml5xkptfY3NWieiAFTDwKFwh2p3Hl4i9/qlYZFkVBEvpY1k1X3TReWV5yPoyxF8si+WfdnFuoWHOSlZHHteeBDQxbMaJW5WRdWAhxvBegD8/fuVHACMmsgNRBE02+ZGQ59eiJDX0ecTOVXuHPzN3NjcySi5RhL4/KOVDAdbylxnT2J4HGVUQOuFDeNXk0BK/uJ7mMmKmPVei6u88MpzSVsljLH0HKjXn1xTc3Wj44QGsAh1DjVRxjhIR5QUuRktMgmmnRo8cv3kInDn2XYMv8geVfpYjED8ThU49XD28cbN7n4y0P4a9uY4RqgbAhaG7aKaP3QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:55 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 07/11] spi: airoha: set custom sector size equal to flash page
 size
Date: Fri, 10 Oct 2025 22:08:37 +0300
Message-ID: <20251010190841.1590130-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: bda3aa4f-cf68-410c-0409-08de0830755d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fKROtIQtlqs9X/0GT3qqwrOl+FBPQpNGwKI3kGm0qB2G01VhjaL2ZTxjx5/J?=
 =?us-ascii?Q?VT7Tflwjs6SaTmfIsEK+cGSpG+1/vIqPz+wRq+8FJNT9gCsabaPOnR9Vy2XF?=
 =?us-ascii?Q?nwV7/ILZ1k6LVDLNCeCtSeO0s6X7MNtpu18AT7SgYih+/TYOq+B5EUjcPgSm?=
 =?us-ascii?Q?NW//VMBUMtQkPMXELUjiBeeCTHQe3j56jXP1PohtdagM+rbPcrenBsiTb4HC?=
 =?us-ascii?Q?98X1XTJUnUoZjzq47+gRtwLQ33hgz32ySQiQXY4lHfjFZDzuWoKg1kUrg0b4?=
 =?us-ascii?Q?ITUaTGuQpZEScSFoljA5f8GbfDTr3wiRA9Kav4KDS4W9o+CVoVOX9b0e/xgf?=
 =?us-ascii?Q?H0qf05TBmr7075PVY7KSx/WQTKJvAmvRsrs+ZkttS6K9isXyorgBar9VZMdy?=
 =?us-ascii?Q?Rk4cQ49rQu7Vqagid3ubSncTJHBzu5g2D6TgDmHO5mEe+j5FBkCVGTOLfOjL?=
 =?us-ascii?Q?HaLbJGml60Kq61YzkjTqhusIth/ytR0o/5Y+NiozI6Y7srsV0rkWKEjV6DBz?=
 =?us-ascii?Q?qLENps7uzcEbkQysI5B08QD2giEok4bAIHEA+B2/x08jheC91Ry2yCShFJ3g?=
 =?us-ascii?Q?7KVoBFjbwcVz3sm5t3WLJzzkAZTKgnET6B0pjKO5eSntAJrYhstdKxzb9rT/?=
 =?us-ascii?Q?pXTTISLQDbdzsTmCl/Pjrs3noGGgwgZN7qxSmefL+n0jMbqo9l7VGKlseUTj?=
 =?us-ascii?Q?TnpBDg3WbTPqVdoO4YeyeOkmZwB1GlKTlCdM6B4eWK6tehmdx82f7jKk/i7E?=
 =?us-ascii?Q?jQ9HxYlkECajdA4AZ08ZYcBmwT/Km5joFF/B43FqJRGd0yqDBZ0vyc446NiR?=
 =?us-ascii?Q?ZMh6kB6qOciatwkxZbzBpgD1oZ1g4k6aj2cRhuWxOJTG9k4rPxIEp8/rc9cz?=
 =?us-ascii?Q?DUD0JMa3kZZVNdsbrIN60D4cQ1So8in1dvJEEvkGkv38wnp+R2YgcVgCnnC5?=
 =?us-ascii?Q?wlt+bwbOboB1G9z4cAOeIfEZqi6BSu1CvLFX9C5urAkFVwjbWIVFtZ8ghQ1q?=
 =?us-ascii?Q?SN9Z+1Pz1MN5xuRn0BTVQShTp0MRSn4DgNP1RgJtF69WVZXSmyQDNUlR4On2?=
 =?us-ascii?Q?ChO3npVpQ4k6Yqo8EJ1IbbGCNqkgn29RGziOhBPNI09yONTe6q/SAFU9WjR0?=
 =?us-ascii?Q?V9Zau1NmfpwzOyLmz0kdtimKTMQun3qUr8TAHE6owWZopepV2HVItIWNxAMU?=
 =?us-ascii?Q?RfenUP7PhW/l3X+quN388p0iE/vFJBvqrefSgmRKthN2y0SofLarFRz3IFGD?=
 =?us-ascii?Q?BoWTpvwfe5NM00v10K8oyQ3JTTw+ucLLBvzEtl599+jC+4kMVoTEXOBJgM9e?=
 =?us-ascii?Q?TWoH4rJ9Su9NVtVLw23LmqbVh/yqaf3J7auDuwV4vdmebQThV5ftQiwPDy4j?=
 =?us-ascii?Q?2+u8HWtP1US6QFDQVyBBFDJnpVHSD559UWzKJfLNo6gW4paQxbGH9CI7DkIs?=
 =?us-ascii?Q?wVJTxXYAX+YeEiwzo+5ITAidXMTZjI61jxtPaGaYe28LgcytIb9U2maMEIfN?=
 =?us-ascii?Q?zkNi5BaXIXPlkpurKrfvUp2s/6v8jg0vghR1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKS/WX9P0y4ItByZD5obaP2FoR8POQHetgyniMdf+B0rlAZ+DNaDr4Em9Lgm?=
 =?us-ascii?Q?vFSsOf4eOPe6lREbyZoaiGsVTSZ7RdVW6UUDDRHmWF/vD35QtHBvtmPwhTfS?=
 =?us-ascii?Q?19e7j3Nd4qelzEjdGag5IEG+XbYjn8qyKkBeLKKmE/eQAKzFI+PMAGiOIRmp?=
 =?us-ascii?Q?Qii3U7JRqjbd2srMJcSaVxIt0CIuPPPyNJqU1kgsKmCfnB8mR+5PxOdHz/cE?=
 =?us-ascii?Q?k6jVwctIr184RJR58SnzV/lBOXQw2+9FQKjSriZ50vC4LGWOa8567P2D6uyj?=
 =?us-ascii?Q?1+o7yPljKqWnHP3IKlVncM57YL09lbncFJYBMf/cQC75pqvHa6+nLkvtkY+n?=
 =?us-ascii?Q?7hX/EuFAAyhI9LPWuZRGGrei0ULpwfPs1UkrvdgE3azXsHQyu6xO8QZkqpCC?=
 =?us-ascii?Q?IC9JumaC7ooPFEPPYFyq6ZHaEIY8PvIrwRI/5VX3rltu/24jElZGuyhbWglz?=
 =?us-ascii?Q?l+zVei2qg0DspBtRMdts1Q+6cdJRKNMgGSjebyw6fyddNzLiE8jEd83iy9mB?=
 =?us-ascii?Q?Geetp0r+yI/fqEBvPi25Kt1YAlV3prQ1dWcpTCoc1TXrBoIlXHj5lIxKK0GZ?=
 =?us-ascii?Q?tL/xt3lo7iCAAL6CrpmLs1MROReCfrFP87oHXOAimU664bfLIl39999bXMBu?=
 =?us-ascii?Q?F0Zszj65sAbZQHbtjr+aX33cIUQKP0urBHYsJvHdM35cYLXb61YUIkVOi2/V?=
 =?us-ascii?Q?qu9Ap8TLYBBRCnXovaQNSxWp8Q0F8W82CkL/7W2aqwyELlcUsgzsXpkzNxDT?=
 =?us-ascii?Q?bz3QQBf+NTPfMe1JrtQqOQfMbWMd6cM8aOI+rJjDcSkCOvRkDNxu/ZMeII+i?=
 =?us-ascii?Q?bLU/tq5K5KmDsZWOZcERpiMIRFWLDOUf8zFFQO3s6PKnv9Rdh8qZJ8JmzZ49?=
 =?us-ascii?Q?FfDVJSiyX2t+fblcRhbBip1NLSFOC6M9bVHtUbR58eyB0LDf3m96Xry/fHAc?=
 =?us-ascii?Q?2iLisrdwzymx0ir9Rr1xPQu2MJAVZD0wox5MsVRflXgcCqU384R5wDBIoDSz?=
 =?us-ascii?Q?bGj9PBWabDon82BId74p1P3LaxyRuIWwf2s25Y7BYjiCPEZ1AGMXCOv54byu?=
 =?us-ascii?Q?CUjYTnjqJ+Ca9m+mmclGbXiXgksKTSwzP9BG2Z9ySVTuXvEndtJe+fe8Cj/u?=
 =?us-ascii?Q?ocfENl7hV+M4LDfiOJ5Dlaya8+rBAYf6CGq5DkX8GKG8aNPrHPlW/n5e8oZ+?=
 =?us-ascii?Q?soJDklKHWyUwzSz+p5m1Uc+CWuNBttNQ7xJ/uS35tAPi/3OmsE9hytD2+G0T?=
 =?us-ascii?Q?fPArRFhn1AtomT/3BZtNKBWLNPxD0lgO+ocPpwqVIYo8N7x77tamNhZRpYpg?=
 =?us-ascii?Q?LTLc9Uxk3gyY5y4DA0ETe+jDyKsQ0u3rRkCGQZIHz/oo+ngmnXCAUeCxi4Fx?=
 =?us-ascii?Q?2ISq8+R9wN/86vSFG1FsRrXANc/NFd0wf93Lg7D4tpwVnQBE86TkGb6R+cc4?=
 =?us-ascii?Q?muyLCkNqiURB2lS393v1o2vTNSeyiCXSokEobRcXJyKfz0R0niAA8jnU+vrA?=
 =?us-ascii?Q?fd2wnQM+rkjWYinq3cNipvcXQR79KDwJP4IvdUph+ksqyeyrhRRY26qh9XFT?=
 =?us-ascii?Q?HhFozGeEei+vwzLv4k2C1NSeXowiUgfUYP5P6SLjmA9ZFWnUcdX1lr1Z+3b3?=
 =?us-ascii?Q?0IqTefs5jmEI1WjVtSgJl38=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bda3aa4f-cf68-410c-0409-08de0830755d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:55.5577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIkp3T29/+RUuMgWx0FkjS3I96Ib2Q3/cSBa+/fAxXMeNmESWEX7JreRPDExshaiZw7qwsMXbL4qFUoHMA2uJawPjuRrjRMJA2e2DdrEtys=
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
index 55eb6d85884..03108dcf82a 100644
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
@@ -610,8 +611,11 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -670,18 +674,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -703,11 +706,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
 
@@ -796,8 +798,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -848,18 +853,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -881,11 +885,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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

