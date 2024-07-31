Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FBEC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3F388A07;
	Wed, 31 Jul 2024 12:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="y+9qHETx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E2A88A16; Wed, 31 Jul 2024 12:20:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC9388A03
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJav091Y32ooDYWuovhrSGXt8v07G4RB4J3ocEjJ+ACmiFzciGnf41DYz7sN6DEd/QZ7s968+18InIcrvKbTU8VDK1nPIt6u8nkRSSN392JIq1jGYrwXIgXDpI0rULVjFGxmcbUckY6YWdQ8cFVL/TwxeCKXWCFXo1aOERnZKGKEplLXieCtC+8pTLl70AuO1e3ETuSPCz1JiZ9+gMMm59FJjXbCOEx0L98gmHq+yKc2BMwmF8tkf60DF2jxv+04vJDT6Z0CfSIeduRTYubADfjMa02V0EkUH12tGqxUC0o49weKjYT6A5Znuidfjic6Mzkncg+QMFRzdqeWNsqu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbW/9ySkqX50qQWdEnm63HUmqjYcl+OYon1RIR7ScEE=;
 b=qzo7E7q84XVZRtToGcn4ZJ1iwsO14Sr4+WugX5IK7rcLFqr7KRX694V5GOaPPII4c5PJs4I2055aXebk374A8fLwRsCITqkevdlL8we5wNwI0n/EDpPn+RSed4iAI63JprELx3ewMOVxg4iuOb81CIoU7s/ss+ec/ZwiY+EBiDrkaiEh7x/Uyu5yVg+Z0OlySbdHrZAKfUTIwhh+ZKnKpBZ7eImp+FVPi5NeTbcLCaMw1r2Ykj6wgfigPaoK7wCmvxxZ66p86IwbkUJeH/TLz/6UPYW7IB4xLD9zUgJ1XgoUwcqS7yX7JnOGOp6SpP2Gk4JnPTza38WFd5jWoWB3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbW/9ySkqX50qQWdEnm63HUmqjYcl+OYon1RIR7ScEE=;
 b=y+9qHETxsHIINq5T+++DAv8NxCqoU3UfqU8DD0UqGkqxkYpyfjq5EDlQVKt76/rpZ3kHgmKVHBEd5Db2rdPoQ36+h6MU8x4nWhEoCsBrl1x/ckl+MGhN3VaiDy/6EmGbnj5rRxeDCVAxrrzDXxwOBrhZBAKxudCorMsLdLPq0bXthfH7vd9vRNPUx4/fzGTGbuHCC2/PQz4yt0ZOT74SrkS68Qh0vgeSf5diIYrjpntUcaRiPZoeHVzU7Vy8JDkzkyyvogtQGNiflOlIZTf7E3xLRW3DZU7Le73q99H/1jXwDqKc6RTN7pE9XP5aoq0PEvi63SZ3bD5hn15ww9tcqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 08/10] mtd: spinand: more refactoring
Date: Wed, 31 Jul 2024 14:19:59 +0400
Message-Id: <20240731102001.4030460-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c94e3dd-fcc0-438d-f3da-08dcb14a6718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/bFJwrPYJbiuepzHZ9etOaUhfEVSp/Bywwjm9DBKn8PmNuI7g2YLEqbzIpt2?=
 =?us-ascii?Q?Zls3hIGf70VBuawFhgiUH6YSxwobDKvjCTROjGFWvgQSp0t4p1ixFamq1WpC?=
 =?us-ascii?Q?3GoBJrU3g8g0hrmxMvqaj6vEzzdQCYevlsGGXgBdmP+yunFGt4l1u1fbxn87?=
 =?us-ascii?Q?qu3Owry4TaxaH8khjFRueUYwpp2ei3G9Rv2rnW8abQu+ZUYJOzdEXA3CkP41?=
 =?us-ascii?Q?4vfabPQ5PFhpPzv8PE3l7oe859wl4rYkXkM9iueyLuuSOOJFoLX/K0v20Lp2?=
 =?us-ascii?Q?PL90mqDnnqf2EnZN161gbDDQICUt0dLAHxX6JDTyZOVxm3Elz3O1HIvwEt9n?=
 =?us-ascii?Q?C1ASn/B00+nU0hbygtBH82qc7odvqnZW5seRpClZR6JPB5vjdi/zOTCjLqLx?=
 =?us-ascii?Q?SNViBCUIqtIhTKbKfw79K5HbaMaWrH9nIAFc2gpAMEoFr6k6x1Lv/vwWmhVo?=
 =?us-ascii?Q?Al42plOb75+NYVPP8Swh4h+QaNR0IGNvJnXOORvzu2Ki5J2qr+yohRSTTfwY?=
 =?us-ascii?Q?GZPUq4qwuMd9gYs86XfyUZj7TxHHs4LgOD69NIMYswacQoIrcz7+ZG50Sj/O?=
 =?us-ascii?Q?VWY7vhc/wGXlaaFi27ZQBsbWLFdyQp5k4DwPmPN/KNcCFcZMPre4JMdxehlb?=
 =?us-ascii?Q?AkU9/Sr6Kcqub3h8tFanrGlfF0ZT72TfXaB3t2B3/aq6W7AaIR3G7cRlvkl4?=
 =?us-ascii?Q?6GqrTipYos4sxk6dZDpNt+qaABnmhJlTg//WYf6EDepcUOlYGMP5SwMBxGCw?=
 =?us-ascii?Q?ixRPhbxJOXIBlK6GG1eQv1oOebD/h2At3u8V4v3A4BvtRM8TxmxXdHNCEv7y?=
 =?us-ascii?Q?0U3CxSOAA/ahbAl8ppCx5wev2MMJpQ/+yQHZtbZBKOCVNvSk3P0m3Md1cNoK?=
 =?us-ascii?Q?qJWAx1Fvsf4hpPu2e0AlL6e7/qCezL0b4LO+LjSbKlV1ucyAhnFAktlvRySx?=
 =?us-ascii?Q?+luLiFPsTDEUMm5EkOJBhjdAFOv/6hcIu6pGZ9Q8R9babq/1Xb5NOupFjMOL?=
 =?us-ascii?Q?yGB/kWpcGQYNk6yS92wDwdSGQ+31Z3uANANW9Qphwo92MXz7KVrFfs0PRL9G?=
 =?us-ascii?Q?Cy44VGQ0TWzWgUeS9esU2pUDDsBUDbbOLos/3bfc4ba1FKrnIvqJbIzDfQ/4?=
 =?us-ascii?Q?4rxpI9qmrU2tw4Jn39PUvOMn6kKXfjGWSVECN/RZJQ+G58AT7JpnqX3+trs1?=
 =?us-ascii?Q?coWKgCyQNAQIGDjZScCgIBaBjwphlQYcnSXn9LHJTaIYPNIzOqNjCcqv439i?=
 =?us-ascii?Q?caLPtIGHB20zf30BJJs/HzboLmcIO6rPYrvqGs4SGyZ0hGs5/qi4zuLa1MDP?=
 =?us-ascii?Q?cv+HawxtC8KiIQE48g604lpXOIB4rbN0h+1tnqBT2TJaNXqjY0bZRwcB2rkS?=
 =?us-ascii?Q?r1zz4ks5MdnoHjdvQIl40Bkvq6vDryUxwHrKMNRfuVY89Vs4S8Ejg0l+gg5J?=
 =?us-ascii?Q?Pt9btaeMnRw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+E7UsFDr3PzOFX5/hEmuqSRHOfT2FRgKKiOLg5ONv8EkNLvMVNMFt+v/qa6?=
 =?us-ascii?Q?GcTgXLGUh2OUIRZU7g4057TkD4xL4S8utx2AI0OeC6M6+i327qrUTGzhWguh?=
 =?us-ascii?Q?5xIigxcDFdCIcJqcbG64t3e/qg9eUhXKP3i9GYNAlTHcel/ZoJdWeN4E+xFg?=
 =?us-ascii?Q?GDtE91ARBT8kbM6OhkaRHZNjmcHkMxOA8iF1b6Ub3+0tyA8v12eucbHTTn67?=
 =?us-ascii?Q?nXpO1ONOLjULsslD+aqkzdMfMTYr9FLUDHtg6T0PaqkIi0Zlku2q/HMLM97C?=
 =?us-ascii?Q?zTlwYRAK7oW47r+OOs9Nf4ob1lYgsXfYNBDL7NdtP8MTXUJefOvu/1HPUpDA?=
 =?us-ascii?Q?D5Tox602DAtlQKX8WQ12Be6Kt34FqAUy3LZEK4HtMtgHiZmvPARBJkmqoxf1?=
 =?us-ascii?Q?XVgi6CSB4FdoZiNz9u4AID4ydy1XSx0V6ic3vZR/Ky287xKDvxvAtyGsaQCh?=
 =?us-ascii?Q?FMahbPkDynA2BJNm6S5vNL7dEr3N3v9yBU7CDOhtPsUOqx497X4yOptOfCI0?=
 =?us-ascii?Q?smV7j4IWCHE4WnaHCG2C+FB4bOJ7lxkJ14CSkbI1H00Dyio4BV1r8WHIEHMm?=
 =?us-ascii?Q?iJVX9TMAvvrH/1A1qXJ4n2ML6nMEDa1CBW5x5g+pfkpIf5SHCkWEzO+1MAa1?=
 =?us-ascii?Q?4OGZgvBcPuOBavj5dL3RU4WPLdsoiZ8noL9Uosq6htXstBpJuYeNOH/6eMQl?=
 =?us-ascii?Q?7okNiG40oiWQm5j/sAkdEpgdR94SFTWw0CxWjG7zEKBiknhzdTaY5Bnbfv1Z?=
 =?us-ascii?Q?M/cL46nqptc9TRNXHvfLzowJPnuc8JOtmT9cQmDyfsBpdSHQfwZh6BKF9NwB?=
 =?us-ascii?Q?455KiwwqXitHOYdx0Tz3nz0qaQsTiTzwCN7oCHJjXzquCTOAAfw9XzVXEV0h?=
 =?us-ascii?Q?Q5AO7ROBTkBF5ZlccAw8t72ldrSFux1eM+hOmjZwPIIEEtdsnIEQTV/4T41Q?=
 =?us-ascii?Q?UFCwxXH9QKgiHvpwfIsXvceNmehqjZuKDTYVIg2TMa30rgaq/jFO8le9yd/P?=
 =?us-ascii?Q?Ql2frPAlUqROw/zYKJT9xmHub1zg/BagQV53Q9k29hJ27efJdPbncL7/HJ5s?=
 =?us-ascii?Q?E+O2lGkroAtaL5SqdLm16Q5VCUGsk5kRLUo4iQHrHacwiOeIGr1R3POQ+L2n?=
 =?us-ascii?Q?1DU1lCCzdIUEh2L+zrCYUtwlO48ZRGOJy2mlpNLvO5XVnCMvLfFq2qlQYJk9?=
 =?us-ascii?Q?w/SOSWwhKMd/jjh/satR1bg5FtFRzO/Don0X9BiL8XO4qgEnz47F2iYK26R3?=
 =?us-ascii?Q?NYqkVAwBBH0mfIKOg1rjp/68dLc2aM7w/EQ61eX/OX5yepszmCjYcKr3sYtz?=
 =?us-ascii?Q?gWmwY5TQcZMI094RFerhGBOAdeFYHcpsdkuXLkJ+20oZVaRqWyEYd77tjxwh?=
 =?us-ascii?Q?jy6w87cwOe+RONhVDuLJ398kPJhsKjwN7BNecGotAZNRlokolTfaNQWw8CKg?=
 =?us-ascii?Q?/uPfuGAd9tIYgeXlAUPe4yNqqInU0/B1Ahm0FhIp3jFazyxu4j6HqH8Ty4JL?=
 =?us-ascii?Q?MDyF4jMjN2WhTxKiaYHMy5J6sto6dQoeCu+WRmHQ9V4HJm5ningtN0xGNdJd?=
 =?us-ascii?Q?hehrq7tKC+IQjWx5jG2GWST4ViTlzF0JSGMlwFHJ7EqaVyZXtXSaXSHrO+LK?=
 =?us-ascii?Q?xWse8Rh0x1vwfjuZtrrongo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c94e3dd-fcc0-438d-f3da-08dcb14a6718
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:29.7279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wK+MzbDpPC0WEPtFhNI2tSiwN7GacH0qtKvftdN1l/9Dt+jg2z5SfC8mGMy6NwED/SIFYBixcQOYqEXvM/uSzs1xRTQMN0gjUbKRkyOuXSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10002
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index cb787908332..00adc08976e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -217,6 +217,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -408,9 +461,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -440,35 +492,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1051,30 +1074,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1164,10 +1163,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.39.2

