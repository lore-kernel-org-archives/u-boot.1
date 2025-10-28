Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A025CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC7983914;
	Tue, 28 Oct 2025 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oaixZxuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E652783700; Tue, 28 Oct 2025 17:28:48 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5986838D7
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jELQr5X62XBOHP6MfUAhVWgUuz/RMpx4I6OMMIu16ohyRi170IP+W6tm79qYSMb3OwijOtGw8p03L0cTrVuwv2UUoyuSmghF7LfqznxsECh3VjLlQkeCwfCb46oWVL+CD0X+H0phjf0qfphcaiKgDAavdsLssqD31+1JvWONcxHcnyK1fhXUJSsqn5viRCJ8FUDIDNq99VRtsMC/8AuUcm75OCE7rNRaOa9YFxAInSBYDhbbQAv5jLlEdYqsqQHB9sFf3E5XyIMluEMK7dCAsCcKRkphSCTbslvrtYiwJXIZt6NZ+iF1/adHqhHG7R9bFnserptluxJa5Vsodo4bSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yBztEv7L6PTumJhaSL5gCXJ0OzWPTAgAOeAvbbi2Zc=;
 b=ahDAPNgHxzsOoAqo+atMIFlx27Bm/aNdd86xIQ4HcZKAFHIw0pK32W80KY5ON8GyYYTRMyjnT+WjQuBICnfv2XSHJssDbrOsh/zozRxAnxO5JxHGbfRzRfspz1y4D59/VPbwhYq+ECyOzkvJTDDBdKjtqTAqnwcRSBkWJN8AlkdM2aeOC9Yg+ozRwi9gjss5Zr3WgZOED0Z5frqbq/7t1QskayXkvx8RVJ0Buz0QAwI1Gv1LJu1qmgeFfwWT/bUfpeEjlamFppQ5lmz35IGdwLbjNOTnZWmmoiio1TSf66KjK6m3zb4rhVlPHvFvAS5XwVoPPcQ1Eb3iwxHqT/aXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yBztEv7L6PTumJhaSL5gCXJ0OzWPTAgAOeAvbbi2Zc=;
 b=oaixZxuqO86LUTYVMSdEmEyJNINr3U3US0uM/utRP2W7R18Wn6l8L1eI9oaBWetQQRuwnyImOJZ4EjiC9vBvn2IvbW68I0vy2GF1c955/rXOSyFSrB1ZkAHbbXRMh8FB6Ub4SshZ//EetiCBj8En5sYy9iwfJ2k6/d4FKNb70IwUlk6rOhJ/F5hxhzB92Ja0BSq//W2QV+DP+aFhsMJQYRofHGORNT4/YNXZFmfilBI1uqSDu8PvDIKOVlyWg8+s9/FYJ7ixaAbfYsqn+JNbXRrOcEHdDwd+e24VM7HbXIL1WsqJeyOeTEFcoH1MrauFskY7yu0XugvCA6RNn/HTRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 09/11] spi: airoha: set custom sector size equal to flash
 page size
Date: Tue, 28 Oct 2025 19:28:23 +0300
Message-ID: <20251028162825.3353166-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 958f054e-9d60-46a3-15e7-08de163f10ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zNuMZSIfaciz1ijYJWEINs3DpgSQpefLW6N4LbUxv90m7rj9SJDsSTmHVVoO?=
 =?us-ascii?Q?cyDGhwwdL+pFyUiC6zlUPl5QAkZUumKEYbFPIP0iXHHv/luw8kxlpudMjrrj?=
 =?us-ascii?Q?/2BDcjohv5qH37o4erS0gn0j2C4WSbPP6trNo/BCdYezaCXKxIZ0ZnUvxatb?=
 =?us-ascii?Q?+Vcu1MjCRw/eupGO8cURWrrU7rDT2NxW/RSWCH8qsUgoQArCbOaC3hVCuNKY?=
 =?us-ascii?Q?FLae40LyayPNxWMh812O4Upi/q6OxkVS4nLlFV2M244p3ol8WNBiby0LQE6J?=
 =?us-ascii?Q?QkZr7FscMH+l/CS/G/zCFGpS5+clvjppBW9w/jx9BLMlzWfPCgcO8ysRhWKK?=
 =?us-ascii?Q?9Ih1nR28jOne6eq86KnaibsximOKF8eE22L5CvqV4J9LntqOyGyqPErF2FCl?=
 =?us-ascii?Q?vpS8CmHFq//JwvN+mK3vBri3dE6aPpwZcm3YKVVUm+jnSk9pryPyI1l8Ih9g?=
 =?us-ascii?Q?7Wr+7MYgecrfakQGq1+SOd+7/qONvmt20dqWvIMUJokQgJSHYHpLxORzG9cD?=
 =?us-ascii?Q?so4GWxf0bpKwhrCHUXXax2+J3NMUSUEDpJbrIRLTZVchi5I1Oa7dQN/RD4OB?=
 =?us-ascii?Q?36DPtkcW2jqGZt9c2/3sW2scbp57cmt4SfEeovxaRdZW7e+Ab7jO2JEHMgmn?=
 =?us-ascii?Q?gG1zJvKBlr+STvr+/R8wcANuKSF23qhQlW2ymPaGl8vGxT1yOviJVAC0GViX?=
 =?us-ascii?Q?zeiYGj65NICieDN2NAOU2G2adAyuxEr3FQ0bDBABDXqW4S/3aUy4BKBpegVX?=
 =?us-ascii?Q?NeeXZUPQz2ZP50kGohTeO9E3uD9r1Cw9W/VWxC2HvX4075kyyJWrPf/kCYw4?=
 =?us-ascii?Q?gR8bFcVDThD4IUOzxoNBOpcrUw7n0QoSgzQal4XpBcJedAWxaTsvfdeIvvht?=
 =?us-ascii?Q?viMll3BQOg5reWTo/wP2qu1iOgMRKqFWnFHR+n0yKgpd4LlOjGfV68ZaSGDl?=
 =?us-ascii?Q?iZ5OKZ01oU+KtSx7kbrR64zBFcDHpM/bMFrBDOjCCDwchltWlJabAzw9Abez?=
 =?us-ascii?Q?8fB5cdBR9JxaJ35ghG0MG4PulKhBcI5xAEcE53d2a85IfgZhHs+lSkjg/4oG?=
 =?us-ascii?Q?QP2W1Y4csZ06LmAUGOMXHMjGbJzHXx2MDpoQsbZaL6BM3q+sFwD3ZAalVb/x?=
 =?us-ascii?Q?tIMnwhBz+8YdR7+U0MWOYRvPIDrHvN1XNZZDiCBzDMyA/C9/3HVHNjw/a71d?=
 =?us-ascii?Q?itU5aqVa5cp/syW818uCpp+rEK3GAEr303KMr+yvFxPJsJpjEPIWFQea0fop?=
 =?us-ascii?Q?QIfKh1+fgeDyHjECA7AC2pHCRCcrBtPOhy7jje+5mWPbaV29em/IceLFV3YR?=
 =?us-ascii?Q?2sqQWW51abf/AO3huesN0yNttQel4uPdUD6Bup4GtZU38ezvTWd5Y/3i+fiC?=
 =?us-ascii?Q?shCdJ7GY75r5QY+LJPIRpuSEoQv+vD/lfF8yRFx8w/h4AMpkygSsnF6HaRv7?=
 =?us-ascii?Q?EvyExPujMFXSexVxJV7Xjc9Rji0vJgokNDHsMoBHLICl2BYbheKEnV+HFo8L?=
 =?us-ascii?Q?KbIRtN0g9VERlix7PdrYW6KiYhGFaBdwbXgN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CUGUR8z47EhK/W+Q6QUJiiXOmwafMcpqeOAZXfjECU5RUnK+qR/h3of7MmP?=
 =?us-ascii?Q?Jy7V+bP75tPyNavPygez7h7Uv1d7GtN0UUjQiQs48WAhZsXLh8mh4xrzy1pb?=
 =?us-ascii?Q?ay8XGTq+a9+irRpcR7L2tHfeOf//Iegtf9W7gX2j4lxDfuv4C+KK313VUzxq?=
 =?us-ascii?Q?B4LzW7bNMzxQ71pZLhBPGAVecFsRgluq7PQQhJpnExM7/nRUQn4zsIOLh3ww?=
 =?us-ascii?Q?U6D3rGbzO7tuKoTkbXPGIq3/gNULInbIenODrvq4ws5hh65l3iWdZLj9tmQ/?=
 =?us-ascii?Q?ZY/NQjw+f+ElFwr2tjShgQtWHX3xTmqWpMhgT3ovGuDCz4G6mIYzUTcJCesl?=
 =?us-ascii?Q?7Ff73VngCRmxCfnapDDmWxUfGRauG43Dj7TacNFUvW3hXx5Xmj1IqeW4ORDj?=
 =?us-ascii?Q?wXwQplmyko4/w/TAagBZkHFNJnFcysSq8m7CeO02jDWFzwCstHCAvvjyfiYP?=
 =?us-ascii?Q?jWrAVrALNT6YT9EErVRv49iisFCNHL8NcP9PikRn1VOHfTcSQZKdOCx39uDn?=
 =?us-ascii?Q?g98ZG1Gp5XNVyl8xgN7SXoZCFqGATPIsgDGEl8DquD8mvU1Pspj3EIxzlTfQ?=
 =?us-ascii?Q?cVEucaP/6wc9Zbm8TQ+E8BvLsii0kX3dRbEI+K9GWJkrY1tnzfwPKjmhFN5N?=
 =?us-ascii?Q?79NQLx84RuL5jey1QNzM1BznuYegqSVsdOXZpcHw6BwuvBCn7WaJLTHYLaL4?=
 =?us-ascii?Q?2XLkGuqPKzNu98ex/hhFeDVNotIJL4kGZlRd6iqzmxCE0uhfXHJYZLOpvVCb?=
 =?us-ascii?Q?RPFxBy8NX15iPew9mZt9LRT0TmNY/0lrHMS0UPWVsSd6NrFSzayeJj/DHwvC?=
 =?us-ascii?Q?qRC5TibtkOO/2kZ9a+fn1NnoGQ81TLeNA0cqlEL8lXoCJCkl/xX8PP6vZAxZ?=
 =?us-ascii?Q?ZE+q51rMvLmS5m65fKa3dvBQVPvKEKS/OFq1yMxAeYc8tzZbtmXKr6Mo0O/o?=
 =?us-ascii?Q?4blndFEniqPSQoG6iXT4ei91PCc9jHTuc/4JVI/1iNRUBZXyl2W2A9w+fepW?=
 =?us-ascii?Q?DJ0KZnd6ZTzJ5yLXQne8uYzuh2ewu9waiCKzoGZGE6EKty4oYouUjjO9CLPj?=
 =?us-ascii?Q?oixznD5T9meedBGSbXKpqaKGs5SZQ/hYNyCDOjRbYldqjMQnVZdzuYKdYZcl?=
 =?us-ascii?Q?rVASNeDYwaMKdhd6CMLVOrkOORZU2Nad4s6d3xXBK1kEGm11wkKr4T8aKlqP?=
 =?us-ascii?Q?AumQSaNU2EHK95syyblQ3F/bvo0ndApUISlhA4fkzbi1dQc9/phgS9q2omf+?=
 =?us-ascii?Q?fpUtm/J3hv4OTYSXYTSYHksd6a+es5NVGn2NFlKmpKFNtD6s3bW0J/cNIXc/?=
 =?us-ascii?Q?OxIRIhxKIPMF+76srtEGD8iQmEmc28oWXEpMVEMlsB306MAhSCRYhf4piLlB?=
 =?us-ascii?Q?x2eHkXlsd/sUwdXkOiQylSFgIOvdDFVJPrzVtHQlYkcV20bsH9wyC/0Av9QL?=
 =?us-ascii?Q?9py3nWiG1i4yrj0ICHGYVwhsVLebd+o/QH0of1EVQa8Bpym/dP83sO3hezL9?=
 =?us-ascii?Q?YwYpPWV0TEfAa/w2Zh/zpYHVwes60ds3sZiPXTCqkaOE4n2V8G0MyMIO1+A7?=
 =?us-ascii?Q?VoBgeu/p9SBuIwSZnn5vR22CtDmjxbvxHRF6ID9hRcIHK0XMC67DUmKYiqem?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f054e-9d60-46a3-15e7-08de163f10ab
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:45.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I0S6TKMPZj5pe08JTozSOlqB513MS+m+AzkP/n4OtoOLjYwgi2lAUlNzqC/LBnvCvrTEhs5A+1a5z+g1XciT0ptsGgaLzQReGX29qEnQVI=
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

