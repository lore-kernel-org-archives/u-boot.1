Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72654EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 22:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6B788CEA;
	Thu, 12 Sep 2024 00:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YizMRxDn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24648925F; Wed, 11 Sep 2024 12:46:07 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229968925F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:46:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY5yjs5aQKlnAYfu66/Ol2LMDp+27/1rRsLUQpX6xK2AYQBIe302siUJG0SyaR4C0fFmnlVF5bPT1KZEMoFt118VQLOPg20SKFo2PHEupT/MxXLlykKvpfxfRZt9ZJAauP3igy3JxIbuBO2r2+TXhwBguIWd/9dEXsu6RptriL+3nA/1jeo6pEnW7RHAe/9ErrTcK6LItRzGszs0Wfoh1G4ptjGnO2g0HSNf85OKxMcKoP+e7Am3e/FSumQ5Xe9BdYGW0r1osm5gNTRBXe+Q2bISLQV1zT6gVcguIfzc7wS+CK3RSnG2fKl+MNXc8lLwCcBy4+7ZBbG71HQk04qojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOcuvKcBCx4uEMQ25JVUxaOcubl3Bg1AK1rbRVjn5mA=;
 b=LslvvycA+g7M8z7q9UlEIFJ3F6ZOUde9KffWq46tvtEzYeVFueg6Z+aQ9NNjYVBQv1AjOHlPcQ51q4h4t3Ap6GX0acKkgirL6hH3qgeyd1KazLDq7iDDwkBPveoHelOqfb6fH/m5NqUjnjyZisu5FlaiI3i353aSvtSdL6ahep0w7Ekb9IdmlJSGjO2GFphKUL1ry41QWKq/sgcsMji3YM4e4+o1Fm4Qt7LDsmJSybRBJXkHqH49bZABV4DFUOvMeG9JvGEds5aTgp8w1Xj58D19/UvwkCvM+9C2SgyapjcT3PXXJLTG+vdUcgaRPlbM9jZNiwv3SrSr44lRfIF+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOcuvKcBCx4uEMQ25JVUxaOcubl3Bg1AK1rbRVjn5mA=;
 b=YizMRxDnXbECa13j+EgPlE6RSPXAdza2LeC/R9ryQySvCeeqUN3itKHeVg/qg9fC5+NEFhdoY8Kbq8lMwVcyaWSI8Y/VrW35/2MGCF71SSj+aUYB8fVUg7UcrW3E2InWN3w3xHlFwLfEA45jLHotpJEcpPYEfNwKnzX53wLeq0DuSyh4aqdwvpCuTYiZ+oE4MMraCqGBMuPBynxy0x8tWjQwQP/I1VgDuayK1n48Fc1QKM32qm2Wzj/R1YyQH9o3OOQdJxX7FrPdPGaojbkxwe3v3/1CDOIVZhatIyFFEQY1/3shHgywi1aQJVc1ZPgvXhTZhhWcl/2L081J9FhaHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 10:46:02 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 10:45:55 +0000
From: Ye Li <ye.li@nxp.com>
To: jagan@amarulasolutions.com,
	u-boot@lists.denx.de,
	marex@denx.de
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] mtd: spi-nor: Fix chip erase timeout issue
Date: Wed, 11 Sep 2024 18:45:30 +0800
Message-Id: <1726051530-56280-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf804df-101f-422c-9a92-08dcd24ee96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CeIjVngog5/KQnaE4CbI4wEbTBMz2LR8AH2hR8QRdX3QB9zz9LDGzbPGTOo2?=
 =?us-ascii?Q?9Wc1u9QpZPMuU8ik2waqG/lxRYXmECFyge65dt9ex/oH0GsvKQXuE5y0J5KO?=
 =?us-ascii?Q?Q5aB2isHp78ox2ZXci2YEUXL5LDbsPg4gthFJyBK6GBE23ibuHR1zvy8XDfd?=
 =?us-ascii?Q?k6ax14AijoYXtLpQB2eG660qvjBZqDXCK1U/N2llv/FnE8QZj6ddStftawRM?=
 =?us-ascii?Q?G7NxVcAj8Kvs1YCIgvrmPg9prV2ssuxr5BTbLMUfSYLecR5De+nj8fI69F9F?=
 =?us-ascii?Q?ENXm+aD33z2CUa/wo6HhBG4C6vbdozHj1m/yCI0nbLn7/UyfdkDBv5WU9HE4?=
 =?us-ascii?Q?aAIV88Q27Wr1jDSskNBDhFlGqAHbTFIRgTXsWPzVRiuxBCx8mtAfqYK3lriz?=
 =?us-ascii?Q?LArx+qjl6w1REK+77e94t7A+Re2blI8ez1d25LpoDV80dKqZUHAKyg0spl6Y?=
 =?us-ascii?Q?dmEAgPtKpBoPtIkFf1p6Rv7EV/laoqS5HnbdaiMQ/Uxk36ytqGccgThTBby7?=
 =?us-ascii?Q?hX4BPF9rFl0615WvQAzbY1MfsofPvxvufpkpufB/Z+QCBe8GG0wFWSZTLWCu?=
 =?us-ascii?Q?eEE2MW0qlru10Eq2NfZrw5LmuNMBXLoIkWgyWDeCWyS3dQ+/bKEfj4TgvRZJ?=
 =?us-ascii?Q?vedYAryphIA/3z9w99osJnCy7q4PM9yT56ShPGGX2EgH6cCWp0qv+5m/OQtu?=
 =?us-ascii?Q?GDuVUUCOa72MfiYXBy2tw07FbgsLYa9AbAvK8Y3Wad6Vi7YYdBUWpjyUPwFv?=
 =?us-ascii?Q?UcL3HCeglp5fzv/AsaxFsiLcPD9zCxwAHV1yjrrGKDj1ciBWKRuN7W/vB3Ds?=
 =?us-ascii?Q?zgjDfWQL/T1RINPbdlcz8GVozQawMKHkBitUirm1PpuZjoP3Eha2G2cnNdmI?=
 =?us-ascii?Q?wbTDv2Pzr5itiLgzmNtACtAthYMVkpz4yk8Vr7t88sjO6ihjFuxsKz+bly3M?=
 =?us-ascii?Q?yL5vsHfFJk+Mnaht5Y9X4LReaUVfBe/JoXOssp9QgwZffDcBrkPhBNrYkbtT?=
 =?us-ascii?Q?Cn7dmqDRwY7JIgeaqgxslV2+RTzp2wm9tt0rnZC0/cYsNdi7LhVhzOgUSi/l?=
 =?us-ascii?Q?X687C+fMLZt9Et94XtF6nSPL/kqIBi1PXD1qqGuciTgMqz/Yl+zB14Ngz8F3?=
 =?us-ascii?Q?tdM4De6VjWG5sB+WlDUB+kj4d4VRaj/0VYQFD8vGtoMyBakysxOlugRCRPB6?=
 =?us-ascii?Q?+Jfu5dPT820MLnXiT9Qx2bB7BMRmmQgpgp2g641O0GM4NLexQVKaaVnP0iQl?=
 =?us-ascii?Q?haq+f2V9gtBenEJftztGGhUXpEbqkiNJ5cQQJb3nhZFaxRjc+t8x+327UN75?=
 =?us-ascii?Q?aTQ3CzTUkkOdLcU3eS2Rln9jsjM8qYHRlJdjsz8W7oi2yobx9HRVLAMn/xjZ?=
 =?us-ascii?Q?u1P5mAWn3KJASJ4ETGAdlXFtezplAmO0P9A3h3hk7MUSwpPoWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bi7XDl1zo9CF6gl9C4ofdllc+c5ASIbo5OyuGGb3qD5F/ZjVmXxKp/HCgyhj?=
 =?us-ascii?Q?351+1FoHb/Ld92kD0Jn/FcNR8HT/UOv5tGVzx5qeqK1wA5TPEI66a6I2M+7h?=
 =?us-ascii?Q?2qLVfcE9Yxx47kFMl02nUV8lOvhmpdb90I6F8kbXsCL/WWvkbERuvdU+uTR/?=
 =?us-ascii?Q?Slf00XZO6QCXAxKxnYkoScw5dEIrki03rEkI/uhB6JEfHyrGQbhDJBvX8GkQ?=
 =?us-ascii?Q?A7B68fqTlfOM3GB88AvRlPL5nlRjMLEW0Mx6PI9b8oOMzVWBNEbUQJk0um9f?=
 =?us-ascii?Q?nMysPWfUELwnyl1gzQXNhDwbqaCoHioUGICehumMitzvTDlP8AJGc3nar59a?=
 =?us-ascii?Q?uohAogsD/kfVy+s5lOm+3OQBUMwZ4b0z7EOpTY8rSeOx7s7FAUbAcEmwJXVL?=
 =?us-ascii?Q?vhm1/E1U3EAaUN/r/N491V4O/s6iVz1Y12IDj0XyIQ78QE9NspMBZLVEzgf4?=
 =?us-ascii?Q?kT8BPSDibopM/Zf7kIOXVYC2vK2dfq/FFxszQqiatNXclMR1+kSeMnjTsSfP?=
 =?us-ascii?Q?UTnG63oFSjdiIeImkUHX9vuMZ3GM2xp6Qt0XFwd6JtLukSmvDT6HYUziNEUU?=
 =?us-ascii?Q?YhuP84mh/5iu4PtmvrIWV1CZNScTMwJO7ttJnR//FfYreWGgl8MzozR0yXtj?=
 =?us-ascii?Q?mb337nUSLXDQ6HREr6sk9nLlyL19RkzVpQcKllTyNivxL2m0ZyNtIPWTRwFJ?=
 =?us-ascii?Q?PxRk6UFnBnrarGP9Q8EBJQmirpWyeIz9Ms503ArloxrS4l8fMLpVE5zfHsL4?=
 =?us-ascii?Q?tDm30cmJOmFHn3sIobEIFm9S7Gz1dOqxHtSectntMsDsICSgkfb5s0zevr0K?=
 =?us-ascii?Q?t3SZmiaUuGxPHb8RbwCWy4Vr2igp2MmzBdmzwKt2WaghnJgOonsSCw+b1fC3?=
 =?us-ascii?Q?I8WagRZyfb4XlNr6jHIGqjQmmTQtZO8EQHi/7Qxd/RYkMuSNp49ewJyXQ07w?=
 =?us-ascii?Q?NX+CYcU7WfbBErDewYg2JkMP5BOfimlaubGpAOy9rw+zE4a8H1h4zU/lheN9?=
 =?us-ascii?Q?+fgPT1QNQhsD4K/1vzgc8zWhODz2jRauiCopxtsnOLpybkqVUARlA/QTOupi?=
 =?us-ascii?Q?Y5KD+WcxMwJoWOX2URkhzPlL6TPt4wIwJQR42P473eP+MudF+skXl3E9UR7I?=
 =?us-ascii?Q?sbTZKfZ5rBjgpDnkw8SJHPdI13yoRzagj/rNiZ2Wt+qd9VRBrOHJk1XDBl5U?=
 =?us-ascii?Q?JL3D7Ea3w7Q3pHTaYljnlbMPvDCBWVE2CaoJxsgmBNzMWw8sSxzsOSUrzo8h?=
 =?us-ascii?Q?QG0o8fi8d3fRkI3luRzIOAh8U3iyLS4mMI9qhzAeewunSH8cX2QYv6JI11NL?=
 =?us-ascii?Q?aqS3ZS4XrOyeAjo/Z0p/8D9ksNQzAmNAA1Qn1cFRs0f2Qc9zryNJIkUv0ZKD?=
 =?us-ascii?Q?1VaRo8ko9Pi+tad2RYC/uZoseBvGFv4pcTeVpnuGW/O3EHY8KzQyeqB59uk/?=
 =?us-ascii?Q?uJ6S9WSBM/3drN0JEmr6ScDtQnsE3IBpPEOIn7saSddVC667scA/2dDSY6Y6?=
 =?us-ascii?Q?OiajpyW0UJUs4evCeNT4NUusARrXzjnYMYL9HqyEAejdIM/EhWwvh10t9mE7?=
 =?us-ascii?Q?855nrWfYgxVGnWcbcLg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf804df-101f-422c-9a92-08dcd24ee96f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:45:55.1193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TScp1N4V8Me9Uwzho45Kj5c7f755KStsXaCKl2GEOQKjMRjDSA4fQaDsMxRmuRt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
X-Mailman-Approved-At: Thu, 12 Sep 2024 00:03:55 +0200
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

Chip erase support was added to spi_nor_erase, but the timeout
for polling SR ready is not updated and still for sector erase.
So the timeout value is not enough for chip erase on some NOR flash.
Follow kernel implementation to set new timeout for chip erase.

Fixes: b91a0822d752 ("mtd: spi-nor: Add CHIP_ERASE optimization")

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/mtd/spi/spi-nor-core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index aea611fef523..338e5856337e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -44,6 +44,12 @@
 
 #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
 
+/*
+ * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
+ * for larger flash
+ */
+#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES	(40UL * HZ)
+
 #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
 
 struct sfdp_parameter_header {
@@ -991,6 +997,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	bool addr_known = false;
 	u32 addr, len, rem;
 	int ret, err;
+	unsigned long timeout = 0;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
 		(long long)instr->len);
@@ -1026,6 +1033,15 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		if (len == mtd->size &&
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 			ret = spi_nor_erase_chip(nor);
+			/*
+			 * Scale the timeout linearly with the size of the flash, with
+			 * a minimum calibrated to an old 2MB flash. We could try to
+			 * pull these from CFI/SFDP, but these values should be good
+			 * enough for now.
+			 */
+			timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+				      CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+				      (unsigned long)(mtd->size / SZ_2M));
 		} else {
 			ret = spi_nor_erase_sector(nor, addr);
 		}
@@ -1035,7 +1051,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		addr += ret;
 		len -= ret;
 
-		ret = spi_nor_wait_till_ready(nor);
+		if (timeout)
+			ret = spi_nor_wait_till_ready_with_timeout(nor, timeout);
+		else
+			ret = spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto erase_err;
 	}
-- 
2.7.4

