Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446FDCCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B37883EEF;
	Sun,  9 Nov 2025 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="C+AxgGsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1831E83F01; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715DF83EF1
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPb6FvGmAb+ZqXIpan86everLgrR19ZtomblnxQ3AZEsgJPHV7dOc9qg76vJlc9tA33BT0kAJ4wdH5VDexZFW6tgKLJ/DzOCgs7p0Oa9Z6/soiAkhBze//mhkvrLnDdfThNsLW6fhU0aSv4Ak/mMcYWrcEUhJupThg251K0jDzqGsQYCwU0SYpbxBagteY8sme+t+B4cppt4SyvtsvSG6W5+IT6P2imLc0MBapIepsPGlXWOEOgw6i71CFh6kp2qqMc3xlz1RUXRWGxaik73mBjKTQHTuoFbIqktQFqedsZiUjkOMkjB8v7wsNTWugGDo1gHiB+/vx7o90PWvo7D3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXpBKClHu6MWG3nKBtnuSuJLaI4okXDTfFsCbsTIUCk=;
 b=jkuwwtaZO0Dkb5kX8dOz76133MLue1Ov/5RIn7ROjZprYi0cgxpO2aHzCFCVj+fD640Xd3kXUePdwBBaz0UFtAQ+EdJqGSjGJ2sUMJNbesaeDgTY14VsLzIvokQRQgKNzeMr0B1AjGJ32ZAUEtrLcXuU1aFXFMs0D9jUORb45xpz4JB+eXhSGF+oaIgvIMjza7FUwQuEOgpfKpDn8bKve42/tUMLO0z+ObsGQr1tmDGFIVswTfr2AIj1WR/Fm+dm8whDr+u4/cPFVgNLLSvaMreImtG4OiI/fSiMn3UWYnTwg38AOgq/bFvpX0JiZw7v5YQYDDV3PTAwDHd5EFMSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXpBKClHu6MWG3nKBtnuSuJLaI4okXDTfFsCbsTIUCk=;
 b=C+AxgGsZMjWcmnZdyZ7ohPM2nIRbZkPJGBptyFoRiH6raz09tZms/I8SKum3wRgJApVvBbj3g0hfAYVFuarsEra94L2TXx1cZ5tUG2p+uxFUs65MTDdIf8pX3VbY1QKF45uMg9a+Ua1AbBPWQnAdJ4r7EXl2xAsGUXn9ZGtUmMkIjLYKZKR15vPaXrcJ3HjykqNLYVeBOdn5OeuhnCsdX5Mv4g2cG7Qt+5X74oRvR3BYWsWOdGlNgDo+juro77UcaID0A31FmdY98YPZ6LVG2fC0KGtyFGIAo3+ILGWaO+Lkn0h0qLpYoQySMZ8J1/6ZE+hNH5TtNu8GAMaLS96YlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 05/12] spi: airoha: support of dualio/quadio flash reading
 commands
Date: Sun,  9 Nov 2025 10:06:51 +0300
Message-ID: <20251109070659.801344-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d7b3ad2c-a8fa-41bc-1a23-08de1f5e9c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVdxeDhlLCTJf61YHG+abAPE5wqkDMmAccFGlL34jzS2O+hZ7YHcF8EoPh1o?=
 =?us-ascii?Q?GOf9sga5o/w01Efjgbs8alL+Y7UTCH3gY4OY0IUF/u1ha12HlXGHCVAPAa8h?=
 =?us-ascii?Q?7kkQpOKeD5BUD4k2S8Q2BYLKZ3qBJlauIX6MEkHW/M2iHdtn9/l8jA2urWHW?=
 =?us-ascii?Q?auCd1lLs4uCtfH6m6mle64tKLYxSuG+ocvZYqgAK4XNmQy6oajgUvuGUASkG?=
 =?us-ascii?Q?IcvN9l0IeHi8sFRmenzSA1x88dH8jY8dInjJGOEhQgKReCAcVE90SjlzjFnT?=
 =?us-ascii?Q?y1JEInpegX8YjWVp+BHxH2tyYsOgovdWcllHHVQ0O7ypupR8iDppX1InsmX5?=
 =?us-ascii?Q?enZ+8COVmqzfoVEtaXSH1fwhuJNdxvDgh5MnL+Vke+1h2PNtR/lzTAFwAd/w?=
 =?us-ascii?Q?qnOpg4BUbsJ4ht8EH390jB30PishodysahVbaM7eAOcYxiN2vfrnUeUkyiTT?=
 =?us-ascii?Q?Chm4GXmZPS3aIbZAVlVR6DIroFAB41uoDymFLOEXhez5jKfUzLv9BrOVKABj?=
 =?us-ascii?Q?Lh26rByChkdkDVgSCeqlQvj8S73VT2dKHi/LW65IqmcHkeol7E6E8OQIkTsU?=
 =?us-ascii?Q?Vrg4Wead3WGUqH2CgEC4H212mL4/mUb5kJYsg0ShK/AWXDAw0gr3ZoGVDw81?=
 =?us-ascii?Q?/lIzV+C6VT2QFpnUmmrU3wMemu0RYH1b51D6nH0OSYEItN8EewUc+4K50I1M?=
 =?us-ascii?Q?+EH6GYNuJTvf3868ofQJZy4kuPUFvheVXQczjUbYMP/iMCUPymncs2IaR9JS?=
 =?us-ascii?Q?08LlghVa3jA/9DoU/JWkGLt9Dro/d+olK/E0GiVhA4xxw85yIDrL3JwfAg0m?=
 =?us-ascii?Q?gGxllffu3JdRLf8gnAc5VBGxOEOPbW5yzMhL/GkbfSwBf4IeHsSWgU/RJ7Z4?=
 =?us-ascii?Q?Sl57auEjsyEtJYRG5Ws4wffcknSZ7UgBqTw0OgX7Pvr9sW/gMFGFLpsrIsd6?=
 =?us-ascii?Q?m8fAscxrEWWGdzuKqbt+SSryIefiTIhL5lcAHw9qTZvxwPVuwJeZZKRVgQzo?=
 =?us-ascii?Q?hR2qfQc6xec6cVMo4+ir+Kp64A6zqxsBwq0wn4HVUcmsAxlmJVUGlUepkKCA?=
 =?us-ascii?Q?KedIRtKjnGQLsMw88RHsjNSAAg/q6PJ79dYKkap4cn1VGXJfQrp0SC+Gx8Dy?=
 =?us-ascii?Q?wHSZxJelM70U1Kq59cK5RTTfrMqbBUna4RBAuf3RhoE3p1BsNmSJWNdBpOT4?=
 =?us-ascii?Q?csfvDPeDK4T9YUSGV3Asq4ssRD/QNlyQ7QmxRLZi5dd/75TCP3RPzlJYPDcL?=
 =?us-ascii?Q?Bqxyu/v0AKnX9TXJyQwwSsBya1A5LijwpVgr9XhUjNmaSgNDrvEH9auy53TG?=
 =?us-ascii?Q?uGNGVH2/sMwFbWIJDvzs11/BiOIVeoCukSzJ1cQuBibtNNosmwVj0NdEVJG/?=
 =?us-ascii?Q?YT5qeIO+en0goz3/Wf7af2a4HF8JaAWcIHwFvNnGcPL2FNSMWkRZBvJdJ4xv?=
 =?us-ascii?Q?wS9+NjDMbC2z3sMsHa3qdA0XzjK1Bi+KjVFrSp+w3D3XtBGRhkQl2lgaJjq1?=
 =?us-ascii?Q?P6equb4FJJoUbwmarZG2tYWe9nOjcrAUnZ+/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stU0yITJjPWvDZMb2BtzK/2Cldtx7EAE4hb6Wt0DAx9ab4foqU2R5yDg4XOH?=
 =?us-ascii?Q?rWZmmhLafq7ZESrMOgMPJy+paqa2C1UWqkw+87rNRkXK70bgeB544OYTbHab?=
 =?us-ascii?Q?yl/5CZtbfbDl87voRGqIC9HljpSe2PeOTzEhbUC0SMAD3fye8BQXGK+N9vie?=
 =?us-ascii?Q?kBC8bp+PJKvgHVgRTrcrQDCqK1XeEXmIWyCkQnaDmJcLEa54LkqTcvEWcdNC?=
 =?us-ascii?Q?QwBeVxUm+9e9EDROdiDlOf3v2ELKVaoCVsUADGb3rtnQDl0PWMXKJzrDIuct?=
 =?us-ascii?Q?h4VeLVd+Bc6Q8bg1a2JBdLl3MzSpTsfDmAo+IhGq6qw2kCvNa6GxH3I2i5T2?=
 =?us-ascii?Q?13hBpPRFO7xo7haRul98hyiP8DdZjGi7u+fRfwp79UlnN3i5xDEhuVRrOjf+?=
 =?us-ascii?Q?n396oWT2k8WVKQ3+llIxXyNzFCXxQJA+4GkXGl9rqxv6fcwUWe6OX4A6QWJ9?=
 =?us-ascii?Q?kqWkIWde4UYaijtt6pXC9AA9Ofvfz2m9jiMxHAmOV0tBjbGZS2fGkl0sG6TQ?=
 =?us-ascii?Q?TyK/qS+HhBk3l7dTkUU9N6y0LsVmuy32Ije83TxdohFx14uG7Ve4WV8IOKUE?=
 =?us-ascii?Q?LjoO2gA4oSvDtvlQPUdLX3WdcU5L3YGWZfRy1z+lrfqMCWp0CCcuhlPTBao9?=
 =?us-ascii?Q?sam+BkHubY7n0OjDH5KdcIXa5EcePMj8ixweBCaDPBcNjM/zHgLS/1QVlKT4?=
 =?us-ascii?Q?XpWJj0DLIVXGwBQzk5sySafkZikY9lbVCu9cnBg85K8Hkz+l6OU77Oqf+YEg?=
 =?us-ascii?Q?OGsdVUMoCRaCNEbPTHBI5odMqZP4rS25iIJH7RmE5R0SdNOdtMxvAFDa8sqE?=
 =?us-ascii?Q?oZ7xClZWmunZ09JYSuTzIY0nPBBOeVFr3fR4EUlwbZOYCS3iIK8F7gDsTMYo?=
 =?us-ascii?Q?RUWqkGXdhneB7KsyhI0Y0JJ2RN1lM8O7yGjFE1vUOk3jiDo8uJPK1EYBKZem?=
 =?us-ascii?Q?AlVuKesJwEFXMzoAdMW8O0L7s3Y1Mljuq1SAMsBIJZUZd+5TOX4jkUSNkLNo?=
 =?us-ascii?Q?wnh89/gjeb8f4APuI7idIuHgRL1PKB9rCrBacSdjjU1i+ABtJuRoZn2F1N0f?=
 =?us-ascii?Q?MOX7emyFpcAYNxrJZha5NDPDvEJ/DXtQ1wkJ2zs+6+1Gy157qP8/ZxdjCdmi?=
 =?us-ascii?Q?1owpXrHBs73/wFegsLT067uJ1PQwY6YIhxOjhwdIh6T+aDMOBvICvL93JClH?=
 =?us-ascii?Q?u9ygjTWIXEaMqkz6rWbqoVD72TIa1XaBhW/cHDOd8NIkZ2gzDoqzwvA3d4Ql?=
 =?us-ascii?Q?qszLdxUMNnT8nvFKVdfPqlHRf0uNb/LHMs9iuR0LyNncxu9Jbd/qucLlndQf?=
 =?us-ascii?Q?yvhj2dutshMNJDiaSD0CM8QFgwFxPjOe4cJAFxySo7Jz8CsdHwMGNwVB22we?=
 =?us-ascii?Q?cvYpoFdHSYN58EPERn/NG3X1vO0h/Has6hNATBr95nffPQ6nJwOaurPrpJCD?=
 =?us-ascii?Q?0jEVIxDB4q6LW7nviB8hQnsnIanKB4CN/EZZ7TPZ8qRlYrwxZ6maksaO71xC?=
 =?us-ascii?Q?nm77zeMlkr1ZSDWWOVG74lifLpWU97Gi6tnoxBk2JmaZHBC+5EqaTdOCa3Fu?=
 =?us-ascii?Q?IsfoBjFhBiyXMvWcTw56oxCliuMTXXp0Kg+uEqlW3w37lj3F2sL7wWHlqOug?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b3ad2c-a8fa-41bc-1a23-08de1f5e9c2d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:14.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oajOcxr6scs+R7itK0h+tRAs5OFLswj/OleusOKV75jK6cD4pQlawmgWC3Hp9CScb5Obqzb6P8MVIsaKqZlRJRyNOaJDLWq7nfITZpT0jI=
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

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index bec4ec0bf00..65381060407 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -141,6 +141,7 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
 
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
@@ -175,7 +176,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -643,25 +646,37 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_slave *slave = desc->slave;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv = dev_get_priv(bus);
 	u8 *txrx_buf = priv->txrx_buf;
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
@@ -692,7 +707,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0

