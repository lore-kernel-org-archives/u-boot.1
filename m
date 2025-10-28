Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5B3CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B1B98392C;
	Tue, 28 Oct 2025 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="4orMv9rJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0C3838BB; Tue, 28 Oct 2025 17:28:49 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF64983710
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpyHBxb9P0R2YcEeg8GtKyq7DrPOswAesxxPktrrXWXJT1cTriu8F1zlkARtAb7dolrUJ44rL++ZbcbAAtvIcdYCwF63At9gVklKZ7JAawfvOY8MjLiy4XDhm3StyGJW9/Fui5E5oO+XbDycPdeGKWHLNB/+a0+XKAbpID/t+odPxdcJV3cTFUm2+dfyp6ZW6pgUWIRqvQ4LwNLg1bgWfluTaKzOIS5WB+D+EeqdkBOw7UqYmqqkNVowvm32cWMfa+YbD4UMV7PpolFbHEdWh6tJkxb7HMXe+aHffWcLVipI14MQH2UQJ350w4DqY+YCXo66MaUjy1DHXCh41klyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8s86B21p+enrY5Ebf4QSmpry8mGNkEfHZUhk9vT2vk=;
 b=LQB2wbp7iC4Q1J2Qzm8N3NP9HHpQjtx1zBL0L3sRTx6xZ9sE0FR6+H0mzUHk1KafDu7yr94n7qYnIC1dLJA2zUo3DqT5NqSzJowLnwQ04vkiuSO9vetS132Ny0abEH/Vy2TEgvyUMMjTjjg3HlQIobQ0bw1vj+MZOyyJCku+dId6hhEU4CM8IQylrUBTF+eL+J4ag+iZ8UgPdJ34wIrkIJoIngl2PluA09hxBsicjMinbuSneGiEkrxhCfbLM9SrJG6Ru72LHILOEL4iit8Mat9sM//RANpSf96bJEfeuybfnoR9uXHeQd9HDI+R5AwiQGEU0BRzH9ryukl1udLYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8s86B21p+enrY5Ebf4QSmpry8mGNkEfHZUhk9vT2vk=;
 b=4orMv9rJmws86KFBaKxpwkAvHaUixBEOJqHpUnaSkLMgsDBHtPDFrIx5FliQNccA+FF1aEEoo6sxuER1atOnaymJa2c/IVBD2Db26FiwDTAmbpX4IP8x8+X6sLS0S6SK2FJ25MmFmoOHHt4ZkU9BhyuTfg6cwcnDT6UGPr4ffvlNQNxSJjxJyxCdtHcqg+I6f8h1hKw4zAsYoNfBH16WPVjc7Jxd0tbMmNTB5juLV8Kw2yxJe9Upx43qaxNmLCR/tcb+HOsY0e3mGHzTTarkGuybWedvBfbRUolejRim+ewZBeA8g3kSU1Z8sDI8xaIDFKIZaF8qzXU2pvTxjx3xuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 10/11] spi: airoha: avoid usage of flash specific parameters
Date: Tue, 28 Oct 2025 19:28:24 +0300
Message-ID: <20251028162825.3353166-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 12929887-4cec-4ebd-d0ba-08de163f1156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nTkuwnyPKVS1SiiaUiAhiG5cXxdOeNxjWM72og1Coxl3s4B8byBZ5xL5ZvH1?=
 =?us-ascii?Q?+azn8qMs58Smt0x0D0IwONDfmi+gkpr1STX+pfPQi+1CfsDWHS8DriM06OsI?=
 =?us-ascii?Q?eBkXev57hfCPCXrdT6K3uXRRHTT0XGEbQFcUCxuTiw9WLjsE3+bIxFs5/s49?=
 =?us-ascii?Q?JQ4tu045nBy25JMqpbAlNTHuJlQWzUZ2GApqZ+TWW5vBclwXmQOJ32EFCJak?=
 =?us-ascii?Q?1EsGt6jXM8K+Uau0rJ3R+gT5TXJS0vdYtwsdwItmFXbQZIfNLjfnqDE/W932?=
 =?us-ascii?Q?gqWuNPAYTPpdfYLqyf4PhwlNtxhbdRrTwQglEdiBybm7KzrdUyjyMTO59O0U?=
 =?us-ascii?Q?pA7EzJ3XZebHv+CdKg8bTw4HskqSsptrjtE8iaD9wD9xhS2tPcgJszSNH+2P?=
 =?us-ascii?Q?Qqgz2vv1eBI4Qa8NI4kNcmSPD5dsxwhZoGKmP/ik5HIYVUKoMf9LFukRBFT6?=
 =?us-ascii?Q?7S8tUA55IOn9KZIp742XvDpovjqPLomOAOgEjlLlO+mc2TBDQyDtkRxkZtYW?=
 =?us-ascii?Q?gZiK29NzPTiTgqmdhOEkIwWgVHKOIJOIme4XSV05byLJPHGLQwzulxwsP/0a?=
 =?us-ascii?Q?kYzidmNbY0C/9Yndam6IgxUE1MavzfMaWQ6Zt2KEA/DEednNtqwoAwLKPeyc?=
 =?us-ascii?Q?e7Bqeqmlm+bmt1aDpzuW8HryJ861l7KDhh5ZLqraAo06SHyIWRj0qoyL+ow+?=
 =?us-ascii?Q?aV33JOG8lx41sgP6al5gXs+C4NJUSB1zMCDxspQrHPTk2FFq76GD/gl6QJhG?=
 =?us-ascii?Q?Oj+JyLfrzvBY65Nl62nwysYZ8iyDUwIs4r2Ydw4hG+CLCnuMQ0wB7Lq+smeq?=
 =?us-ascii?Q?g4cLl85kufV1EB5Pi85fwuqjhIG5Cwb9Hsky4sbLCpvBhcWsmDjEmuuMqFZS?=
 =?us-ascii?Q?SfxF4rk7H0PKa/ogikkxTvJ9G/rKgzEjXtANJmlaiOvRc34ecZ7CyzgVRPlS?=
 =?us-ascii?Q?gXPtNmrIK+0W05vqL9V7KlkQvlJ4JP8+AXH5YKu4d14O22/8ll8HAUK73D9g?=
 =?us-ascii?Q?UOcw+65A91PybWZ3ZS+/fxvBi8nmxVLkF1xS4WY1Tp2isfHAK2vqW1NGv4n8?=
 =?us-ascii?Q?Cbe1P5m2s2fBiZoUfBW1Ivzq89z6GQVQJGZT4pclniOVrSicJka4FF7Bf02V?=
 =?us-ascii?Q?XywhtcD0cOgS9smKNsGHszOFijFVSZmVJMPohE0pDZ46kn6jFSq7tCFvTl71?=
 =?us-ascii?Q?GZyJ1HftRis21PU/h9+laMARiz35kqsShCD8fy4Irx2djKcmPgY3/E9WYH1p?=
 =?us-ascii?Q?F4QBerqc7S8HQAqUmEtFWsUA7yk70r84X5+bv38jE7nm/l5GzUNYNvzGhGq/?=
 =?us-ascii?Q?hIvY/q/ivqIcr9IJe0YhSj1WsuptnBaNb9ugrq8xSaqd3/lU6pW3/HB5HSau?=
 =?us-ascii?Q?N/+u8nzMvW75nX7xNxRzWAak6o3sLDE80RjcS4k6ofkq/t6bTaXkAmZQvvei?=
 =?us-ascii?Q?0VqL7702ADeXHGiwaengOyFJi3wV0U1gfkvpDu1LlO/uEXOUiz5vjnixY7TF?=
 =?us-ascii?Q?+oAS9HRdnFkvS45oyo+HCjMDRddToKSTLvl1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fshC7/r9ws3igvLUXRUKEE+iIsRLXifKmb2Jti6ac7uXgda6Mw6ZH7ck8qB6?=
 =?us-ascii?Q?rz8j8/vUf2r1v2ckmlQJZlYs59Sm55ZiPfaBHF7u3Gu7VK2yScQptw6pdICR?=
 =?us-ascii?Q?Q7+VBY9PoTs2afieGMT+96qEF8NfN1FEG1FcgnA4uO5YSBw7s/pyUmlFGQqi?=
 =?us-ascii?Q?DN8OvsHfbhY6zXd2Mh9fWZa/Ifz3T1cxwI/9XLQ7m2q4AjEyKkPy/qjMOlfI?=
 =?us-ascii?Q?xQyH6F+kPKApXRMslnDIgwpQE3P3pPh1kGiI3xLhEvHVZNyC6L4N64B6lQnB?=
 =?us-ascii?Q?d3DApUXlifcfXJLxjR0/fL1c45GOlLlboY5/aNbQqfARyh3R71S0kNDZ1pbO?=
 =?us-ascii?Q?RjQppcQeqphCQKDGdfMlDGTtV+Nty0VbUfePDqKFS8YOEJL9SQraqHIwEdnz?=
 =?us-ascii?Q?vQryucDBprjoo0dfp+2Ox2PqkQZJvkVl3VdRQJYzKFCZKQyuZNzuSkyHIQNq?=
 =?us-ascii?Q?3cwLxZaAaMlDZ/Tv7V1qjU9LgYXlmfvHC6/GzLCvdohQnhAK8Hpy0SO7Znm2?=
 =?us-ascii?Q?Ht611g1mVXz9/PAnulCI5ZtxSHvKAxIRwjrh9CLhvnRvIHAIpQWgjirNpLPR?=
 =?us-ascii?Q?k/MYfC386TBMAsvo1m/oRX2xrOFE5SkS77/tGhmhCysIvkywsm2F1nFjmzFf?=
 =?us-ascii?Q?U3Fvuu8NiwFgB2unGK1XMFfcqUJw8Ak4FWlDpnKaR6CAaTaXIYH1jdebtW9w?=
 =?us-ascii?Q?OJ3rj4mwA0wIM0SXg+HAlLDwlgP9IYGTx4aZSU4FUZKsf9ZHZRU8MVGhMdHH?=
 =?us-ascii?Q?700Ygr+hkVfD2OOlWC5O1TTH+C8qi9SWGi+dbC+wYurfCWHctIQhYurdMx28?=
 =?us-ascii?Q?0/Xa0/xFp+LNM0ev4j2BJSGe9QS8WtQr33LJz6JSuB9pobC3+CczdKAMXbwI?=
 =?us-ascii?Q?OCAN3d3POCmI59PcUMXNtqgtsKMJsbxKEQXQUR46bh1bCTDF7QlS4oqCZFvo?=
 =?us-ascii?Q?kMaiu6fAhULUSj8PqWnAmWy7FbGzwi95NUTcPmEcAGWDvMMch1g89hIJtBfM?=
 =?us-ascii?Q?FnjwXR+msBVZvpukGUtFcU3DlD3tq+qKBuTBiX2BRtMEnF8Rj044tec8mNEa?=
 =?us-ascii?Q?cSKxkLmmNnKyLmr9WLWquwrSnwfbgdmCjUdgBkb3pj9hDHI/qRtdQvpTSdL2?=
 =?us-ascii?Q?yGdWVC+iJsjpADwDZLjqtOuGKqyRaViUgxOVhhkxmUg0+QMj1QjLI1pvYo7C?=
 =?us-ascii?Q?UOMvnJN1yCeNXBi7ne0thqMFdbNdPgb1R5uIxoicMdIRZxbZVBW35tB6xYqy?=
 =?us-ascii?Q?MjxMxswkZDp5QBZ6mr+bMCqEQSZ0beUhOypfsaKZw0q9QD2vN6pIyE6QvqPw?=
 =?us-ascii?Q?KJUQF2/Evh0dBXaMUWqDe9VaEEmKUh20ykl0YokpQkUFBbHws/LGA3Cud+SS?=
 =?us-ascii?Q?fGeRIm9n0VSyp5QPk9fC4aALRMDC/wxjlS9jJiABI7/J8Djj4gvmnWAyY0tR?=
 =?us-ascii?Q?zCVnB3B0w1QXxTZShRCOcRA6PJMPKSHPJhjdRzWKD7jmrAPdVB+xxvSByPzy?=
 =?us-ascii?Q?zNaJrIT16+qPhSpt5RCnYFFWK8ug41wxDTudANQuvRNp5r+S7xsFeI9mnRSt?=
 =?us-ascii?Q?7ui5Y9fo+6r6jSMAuj75wcneMHzj0FliSlYNsTPQRLqKool07MyY4p2XjiUe?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 12929887-4cec-4ebd-d0ba-08de163f1156
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:46.4622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6L4gcnGtZwes46Tea84k1WbdREoKjtorQYgx61/7rHfbmk+Ufq7W451h6fkFnw0R3ahhuKPGGv89HAc//SbZ9NzumpJx00uYXcnj15E0PQ=
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

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   round up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can find all data directly from dirmap request, so flash specific
parameters is not needed anymore. Also
 * airoha_snand_nfi_config(),
 * airoha_snand_nfi_setup()
functions becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 94 ++---------------------------------
 1 file changed, 4 insertions(+), 90 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f1f1a5b9d8d..7d6af690bfe 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -218,13 +218,6 @@ struct airoha_snand_priv {
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
-
 	u8 *txrx_buf;
 };
 
@@ -486,55 +479,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_priv *priv)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
-	return regmap_update_bits(priv->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -618,7 +562,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -805,7 +750,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1098,37 +1044,6 @@ static int airoha_snand_nfi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct spi_slave *slave,
-				  const struct spinand_info *spinand_info)
-{
-	struct udevice *bus = slave->dev->parent;
-	struct airoha_snand_priv *priv;
-	u32 sec_size, sec_num;
-	int pagesize, oobsize;
-
-	priv = dev_get_priv(bus);
-
-	pagesize = spinand_info->memorg.pagesize;
-	oobsize = spinand_info->memorg.oobsize;
-
-	if (pagesize == 2 * 1024)
-		sec_num = 4;
-	else if (pagesize == 4 * 1024)
-		sec_num = 8;
-	else
-		sec_num = 1;
-
-	sec_size = (pagesize + oobsize) / sec_num;
-
-	/* init default value */
-	priv->nfi_cfg.sec_size = sec_size;
-	priv->nfi_cfg.sec_num = sec_num;
-	priv->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	priv->nfi_cfg.spare_size = 16;
-
-	return airoha_snand_nfi_config(priv);
-}
-
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
@@ -1141,7 +1056,6 @@ static const struct dm_spi_ops airoha_snfi_spi_ops = {
 	.mem_ops = &airoha_snand_mem_ops,
 	.set_speed = airoha_snand_nfi_set_speed,
 	.set_mode = airoha_snand_nfi_set_mode,
-	.setup_for_spinand = airoha_snand_nfi_setup,
 };
 
 static const struct udevice_id airoha_snand_ids[] = {
-- 
2.51.0

