Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBDCCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D2683F1F;
	Sun,  9 Nov 2025 08:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4xW9ilOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4527383EDC; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 838C583EE2
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtSchjBCHTuxncLviVGCtJ0o/+9HlzupAuYDzEM4IycpuQZ46gMJzTUUnOO6ahUeNoT6WeGq0jPD4f/0Ij8/zAK7eTm5xPRXmaRPqqC2mrTQ6XHII3uFq/9b2WfH1RNLSjWeLV2sFbzHlYd2CrAaRFxnS4bYNPnQy+ibqFeKAyb9a3V+/vzWH0WFRnDNo9kPRsqb9Td8RreHIHPQQQuOF2PsDR4lYqbMYRfwpp0nFo3UqP3uxoAGAkuecikCD+mKd61gcLaCL82UJt34HXjE1zqsfye9jptQ7PhzsYcQY4HKeiyUmBMPlFMlUBzOlVYxP1DW+NvPTN2hJ40RaY0NUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=fTttZ86qTVnO78DOg1Ax4f9IWfbno8CqtdQn7BGOpxxvmo9aAIVYxtbArClAKlCA8KCT72kFMnnNP5g0I4RjKSTr+sMjZ6q0hgUjEeFV5gyrj+X9Si2hnnEDyIY1cjzxLYICfedeelYa2/b6mVRxgDVZOw1/6E0ucoJrIqXJ330UraLXTPgc1MhblFwHCGwakDdZ/h5xS3hcX3RclioPP5X25y1r8+cDuCpNZaktg6c4Tr3DtQRb48fBZoS5+8C6Ixd+/Gwv+WTsciJZC4U22BhrdPNeiyyw3TDvIN9tEFNL29n6M4nGBwJaIQAPSNTSr2LhmktX/yTWPJZwmD3DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4TaO6Y0nOGG2gkgYTexz7YHRB0wke2zhKv75GUH8zs=;
 b=4xW9ilOi4Krp8dfzgLHyFDXG0/Nqmjx7RZfhZeikRcha6d7lx5jqql1FbG8+foE0zVNAvet4O2KxJTbQjdFPyZVvafIlaul0eB9x2BqTosZi74Mn7BhmwdFl6BJDilTJDVEMu2w4TD7nk2rA5t2LxMRFUpFBb6uTZ4ekPogf/NhH5FpwWG1/cmWm5H0OrynUcLt6mCah9CjTZxHTXiDVFZA7AJfNsuxsNbgMqgL1x66cqTEBFPBCQNyJ+FBmGwJPrzq1N46lV9tq7Gr2L1d5jKbvWtIrZJr12zG0mM/gue+SQ2ea/I3n93cWuxUyXaSGS/VyIqL2R8bOE87pNPcA+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 03/12] spi: airoha: add dma support
Date: Sun,  9 Nov 2025 10:06:49 +0300
Message-ID: <20251109070659.801344-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2ac6566d-b2b3-4da7-d3d8-08de1f5e9ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xeHoGFCm5iA+2RO9dDrKxwoBd2HSVrV7bRfacdGziKz5kWx02XX02zL3pkTU?=
 =?us-ascii?Q?2UuAwx15dq+V0gVBiVjryQo5oGB7chspCJyyyGxjnRYz902F0WsISHJUtnju?=
 =?us-ascii?Q?JaU80CJpYG+YVtYF0U9kFDKWXv9nV+q/6rLyh78TGWAvPGwNvz1oW3Sj48Qp?=
 =?us-ascii?Q?E6opXMewTRe8qhUSfJqUNZZq53XV9J2edP1VH+1FnW8kveBqEcjtU6nBtU/w?=
 =?us-ascii?Q?PW0XJ4lyQuONovytUyzlnLgWNguAdWOdkTJuF3D9J3gldKFh9dQTS4ABF1c0?=
 =?us-ascii?Q?VMl9ikBgA3fgdvxx7NaMkE5UdmtnMzSByNDJbtdOWDfyrdUrcn6iEtulR1MV?=
 =?us-ascii?Q?cYRmLRa7ha5N7O1u9VKd1H7ZEduIUv3NeNwkuHKUPZi/uD8GmEY8eAeAlLep?=
 =?us-ascii?Q?mnZvO0nmQaONVKlk9RQklpyTRRX+gtpuZd9pvDFNmBZf2xFj3ITUGiuXGx60?=
 =?us-ascii?Q?Ogavqpa9SAASC3EMeZN34eHjJuNpZkZ6NfzY2ACB8107IEqIRQUODW5hmeVx?=
 =?us-ascii?Q?u9LxWoQZDg0wqS0ukwZSf9RY4e0LbHoWPedeGHu/HuctZOv+NumU51bc+jIV?=
 =?us-ascii?Q?PN1FbaZUl6wRSxzW2inJH+VumfOXF1e7RzLCH95TsxtbS2nRX+jgbKQgrAFS?=
 =?us-ascii?Q?gr0d2NO9C+jEH93zArJNAjVabNFt+wFLprj6uPvgOO1Pzzm7oHv04Injds1e?=
 =?us-ascii?Q?i9bkvxMVJWgkFfFKEdP0D4WsCzXE5bnm8louW8y7wWjROALL0PWuDwCmrNOi?=
 =?us-ascii?Q?vC5UX7jwcUKaZekesrhgewL0naNW1zsncfCap0aY2tIEoQE70zVudu5R0lpS?=
 =?us-ascii?Q?Z57mxee/c/7ESERkW4LCg0CSvoUHMnK9MtN3ZGJBKqufM0xnAAHUJEFShReq?=
 =?us-ascii?Q?1xCa4M3hpiqAxAoK9MbNPI/jdVDTsd387v22Id3+2JeYqwBNBmJbYWv0/2Nj?=
 =?us-ascii?Q?Xw1xe3Qc8OsfK13QR4zKjhPt36z9y56qR6ihgBUFrnufxu6vi5Me4UUlXFcQ?=
 =?us-ascii?Q?6U/hruM48fM6j1aC7zwnQvjgJIvxFwodKXimz/iY7AIlAVjkuO2FIRdh57Qa?=
 =?us-ascii?Q?u2MbQLB/2mdW1+oZc2w4PATbiQJaNAJ1RKZcYpPdJ8lMQHrjKYDfuaL8CTOS?=
 =?us-ascii?Q?mLO6M0jCkfKJx9J4TgZ72eUQEGFUIUFt9xOrKjClQSjH37pFf0PyhSRLH8Mt?=
 =?us-ascii?Q?Cg7PMpFkA/ApJfKlCoxRdLRmpApogvNA243p26xDZA7GEWAqnVDSU+eZbe9I?=
 =?us-ascii?Q?4H3LunS+6Lr7Wn/8o8gRmARtX14tOwI50cXD1Elx+mDFcF5aty4j8jlaohm+?=
 =?us-ascii?Q?RnpQHowuqxHzFLSEsJbxviTyPncKGUPOEH96WU2G4TaxkQn+AJtZGtkNMwr8?=
 =?us-ascii?Q?c7bZNLrND63Z9EsoEZhX3LQi+vpyi8Soe7QXh2PI0PYLeuJOHz9P0AVU9Q0+?=
 =?us-ascii?Q?q6m5FxYJfEJPI3dAnYTLOrl1BBWx6HGr9KKrzwmfQ+y13QE5EOaxeE5TiMsV?=
 =?us-ascii?Q?ns1vImlWOlRNQH+TeZHAJwoqYmVKqKzQbn5I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmByWFf1rgGbvqoEzx93+280lQvOcWvB4l6rZVBOdiNT6PuomSpeY+kMyBD/?=
 =?us-ascii?Q?RJxiIO2SEo3Omxp6MWwQXnaxDdT6idPi11ne0KDOHJ6HiozwptGDYY+pU1EB?=
 =?us-ascii?Q?ivyYmI3Gc8/2jtPsJ47M80ahoxEu0JJeeE8p77Fq7/qWxQAHR8cBvTsRQBCs?=
 =?us-ascii?Q?6NJ11WkZ4BMlWzgWRvky9BBbNk9cxt4hAozF9f5cEf4/fNMQLjmAdNC0/Bkr?=
 =?us-ascii?Q?7wKGMrTLf2N+C+KAZ5TZbk0g/SQHHo9SX1uMwm2ZFJAkKxWbuGgNe/eQgMJM?=
 =?us-ascii?Q?2J+dWxvonSvIpol2ZUNnI6dgNz8k3SOZcdNylm7v9ezfrTJkZIWuJf3b3t5g?=
 =?us-ascii?Q?KsdCdkTJS3wFeGimPTmGWmMdcjytP7YmS9sdbycI+xSfeMqrI8JP+cWKImwD?=
 =?us-ascii?Q?QmRWE4+bbAWyOuD3uabBpu3XOyXJ6rnZ56eDbOUSkFU7t9H18xIynXi4Aib1?=
 =?us-ascii?Q?WHmn1b/sHebwYgWRZK3kmUBniqWs1E80nLswYOK8eTsiyyGMZGza3uCMSYTD?=
 =?us-ascii?Q?ge/22K5vC1yahSNe3Xp9lj4Kwb/Qt1RlvQOoalK3ayAmgnuPdR1YlITUBHzu?=
 =?us-ascii?Q?7xlLlhBjpO45XPOoR9BDtbVcHvMw8LTk9OVJVo9WMMKJHwClzZQqCnVv2vT5?=
 =?us-ascii?Q?CcCFDQhhNipir+zJF6T1wMIaUxyHbB9d1Xk+N6dLbHkf+LQPPr/sElkiYmKh?=
 =?us-ascii?Q?lK19q0JKqHd4OiDgfwBFgOHB8KpKDLJDLqkX4oQcHnz7k/mddH4dgwat9FaN?=
 =?us-ascii?Q?dmBtCj2X1rNqDtgfFbjTwVMt+U8J1Z9YbpOVcDZ8BMvA3mk4QoHk8xIuNZAn?=
 =?us-ascii?Q?lpG8hx1l2zplgx3wwjk61026isDNCL2L9z98E398Q9lEsjX6mn1HB3QptSGW?=
 =?us-ascii?Q?WlhYdqWJvYKKTg0yL0Pn7N3fd7YKU+ujJOcvcXU9lggV4ENWtylMwPF+T7FN?=
 =?us-ascii?Q?xYjgGpSI42KyJFTg6+p24zUByw9DsmGksjOPJ7K9NEoQy6E7qzGG9jyxQAjw?=
 =?us-ascii?Q?Fu/rlsNBGWJAy+kpq3hsEQfKxUehYQZcH+4WHmtIuf4aSuMOQo+/4dZ3ehiM?=
 =?us-ascii?Q?BmXTrLZrfiDr1036MvyvK/ghrDJTcb//i/qfHP3qYaBMdeukRSAJctSghDIH?=
 =?us-ascii?Q?WPm5HiUtq7ZmBCgIZYtOGsvUpvgsQHsOwHJBl1grNq4ehMH0b1iWbu0iee4K?=
 =?us-ascii?Q?yphCq2OkqEQfimUnse4jd1xCffIJE28TZNIsFAm6N/XEQcLL7h0XD/GxumJZ?=
 =?us-ascii?Q?xM5oQaSXUfOeC76TTjOocdOG+MylGjcVIita0uWnWNC4d0PKy+ISUfg9Y7Ps?=
 =?us-ascii?Q?kd003qW3vFnrMASc/cN3VT+TunO7Yy/Z2aRnlNGsdIIuNfVE4RYR746sWtPE?=
 =?us-ascii?Q?AwSxivSg2sQKY9GhqePfFkcoMRyQXjTVn833E1Ci9+l33mPOzAx1ans1f82/?=
 =?us-ascii?Q?saReaTJk5lwcDNzsaU7aBbAd7x7Jr4zfJKk1qTUs7zplocJyvbrnXG0lu2fH?=
 =?us-ascii?Q?htebp1HXJVzA+l+zDf18D2uBTSAID+Tt6+tnq5GyeUzCGqC9GSAR3Fp6+gAf?=
 =?us-ascii?Q?Qome+rhMxRpx4nGiL6P5RcJtDZiGChvuVr870TUv+TH4u3QiHWs40HPiTNLd?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac6566d-b2b3-4da7-d3d8-08de1f5e9ab6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:11.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XijlVUzlnjxVolExM8LIIJjJ+DH1kzZL8igdBevqmdX5iUkzaoLojFGopPww5G9vbnmQQdbDi7tt54LrF5aEbReGs+TicHK3fOrjhxp5Zzg=
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

