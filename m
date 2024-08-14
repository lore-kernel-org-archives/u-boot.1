Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D89C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD5F88A1A;
	Wed, 14 Aug 2024 12:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UJXfnlPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9678A889BD; Wed, 14 Aug 2024 12:19:59 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93473889EB
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXSqwl+NAQls1BYchRVCyZSogzVT08cobpYwL6exvfi4shQX3QKZiBe06d77XnkzRySD/00oLFNBU7Q89sgmvBkT289WryyfwWQC1T+yaS/1XIGQnYzIVjrKY1ssWNINZwzvbBKrPl/UJgIvRy8LXDH9wNntlnT/hULzTRugNgFsneH1LrZtT/g7dl3INXj66nfw9lvlIegTZp9m3L1EytsaynhgqOOyzg/LsPTgPNYsgS3hQYgB/lqRS8cfAYbmNkDH9obpDQfei1ioV6QgLdwm/srgH62MB9YMCJ6mKlUuFQjuYg2UAixkxHC7GBkmmHKx7JnkDuK8YLxx+qzQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYiDU/3SdcvWYECEC4KrcFOXJn4IW8FiQjWODiWCkNs=;
 b=OiAwdq5jeUlM4Drbz8E57c+RWFlwF+jKmefxfV2kTOPgX+4bvwuxY3b7tMMUFG+fMKaMoU01WuPONfzTNuPm861fYVsc7/og4JyjUeVz5IuwYe46Rc3cwOe27gOdwtyHoD7QKGP86skusjc3WiifxbRv39eTF3Uw9+qDY2Gu/jSDjbPaUDR8oP9yBODoGMwhPKDXJipkgkHWLpVfEi6Gdrn7cPjebP5+h0DqWbl7YW2XuC7O9ikyj6KaBin9glCABPQmYG/pvkNgCOW1CLZIkvE0U28SE6XxlxOcHs7mgm0Mqy6R7xl3C645419LG/sIeFqt5L9ZQQXF3hqLdY35OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYiDU/3SdcvWYECEC4KrcFOXJn4IW8FiQjWODiWCkNs=;
 b=UJXfnlPH+Hd5JzVJJyzly1DIzSSME7zXnSv2KwmJ6y8Ob8XKefh3FEwJJOXxCUrZXA/XTzhXyXtM1TmqzohOo/KhxJokiT8WM0wvy+Ma22WfDCnXMkJQSKKcBPLCyz/ZnpTQdQ9LXDoZOkCQHP9SEA90LakIDP/HGWFUDdEPbgb3yLsQ3WLZEoD7LijgYdWxrz2dGBGDw7+aGCqtlXmieaA0UMKb10Xue/vVaUGNUQq/KTJnMKOSzlAQCMv9BI7OdqDfEbsDmCDHXU6e/yeFumc9mVrmB++v2ARHDRdCQ15Zayn93o7n1/1ysI58lDlpdBWTWtC1Z+DmGuRG79jNjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v4 08/10] mtd: spinand: more refactoring
Date: Wed, 14 Aug 2024 14:19:16 +0400
Message-Id: <20240814101918.1347167-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0401.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b4fc70-5404-478b-cbb3-08dcbc4aa4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NUK+HEmGA0JU5kQEuptis7/poE4IkpTRxh7XyLdzc1FNojcw7pLL3WBeZZAs?=
 =?us-ascii?Q?k3fcA0ugakZ5g/63InNxunNy4ewiPGkJOfn2BCBqVOIfUelWhCoG/XBNzjbC?=
 =?us-ascii?Q?lTGPSiQb/VCpVW0Vck+/xXLHzjyU7tDjSGGvlLtXbOxtLlNkbvZWno7eKV6I?=
 =?us-ascii?Q?RuUHmuQm/I4PNmOaPa0PX0ytDsOU5I+0KofOmZG5y4U2CY/lOCCl95DOpkC4?=
 =?us-ascii?Q?IjqGw9xk9t20juZ0sCDxFujipGlI6G2lpnzExqKBK/RNMbxIfa+Ws2A8dKR4?=
 =?us-ascii?Q?AO20+odm3X1Ai13byGR55G4rT1YD7wvBbV43ulP9ZuvpZ56sGglbfQHcrMgs?=
 =?us-ascii?Q?RBMPi9h59tRH4EJ/ojJTG6MfoueK725HscFU042b8sqxqN/dPA6fPUbLf9+P?=
 =?us-ascii?Q?me44a6+XxjkI2tjtPnrCK5iYZdXXZkADFexuRQ8L/+sw41cbrNHdQHM97LxW?=
 =?us-ascii?Q?RXX3GhECXZXEB6HZoHpckVSgUhm+RLnmVK/aC2hhyszWuw49tB2gEnR2Zha2?=
 =?us-ascii?Q?IX+86+aM+YDN//ojIf1wjKGxS6r/f/NsB9x8nHcYCHVlEb3xRIgqKWBfM45c?=
 =?us-ascii?Q?JP//BCEZR7yE6Ih7Hkrocj3C9OkV7fBvcMHykGuJ5xOwyTnzVULN4fT0731h?=
 =?us-ascii?Q?NYKEmwdBecX6e3MWKiB8b75Js/i6eARcVz+n0nc7Jta33rP4mvKL3/aHPzPb?=
 =?us-ascii?Q?EU8jpSveHVH3RvSSIlX3aaQ8FZZae8a5R439ZryAVO5MPfCUetWXFJQmc6O/?=
 =?us-ascii?Q?cvkS8jbNBHnD9GWcQwrn873DzH7NK3iVwLdhnM4TZ9tI7rLg3xRAKKMogyC0?=
 =?us-ascii?Q?8fE6mKrOsbXf1qq1pVP6Zk1+138ue6N+aAilevVWAJ/XJOB6FrWtywptocJW?=
 =?us-ascii?Q?0O0ucOYw6i7Q8JG9vpD9TmAhwCcJx1oFQ1ChuVNXq2ixvQ4fP837xfUaVEpI?=
 =?us-ascii?Q?wTQZMdK33g5jieTbCtZSFXhAStXOUf2HU2y7ZfLaqIGYeTRgeI6Txn1iqmtF?=
 =?us-ascii?Q?fFGdK+77IRNH8Ss0oJ5DChNuAOypGRnTIapw2Sejv+ROBu+MGKGp33dIxMA5?=
 =?us-ascii?Q?RMcQo4rnSyQe0y4deKYhlRbzN4maIU9TqVIw40PGnTIzN+hfCNAdVFs/ug2W?=
 =?us-ascii?Q?glpstnXrE4WSzeIfBuo7MX6iswVm0ME93cLKQuxg72e3AITb1bp7gq42YBsh?=
 =?us-ascii?Q?jCuX4qb0wSjAj3PfJFb9UEeE0hkL4aQOU7uPD9//oL2U5Mk6n4uRVaDqPJC4?=
 =?us-ascii?Q?pf1Dn44uB7ZWOVlWKFJaTAn5lHrNJ1MVhgjmUjOTDMpLHjLfZAo52z1IpOw6?=
 =?us-ascii?Q?0jA7yNSUlmnXrlVNTj+HzL1m2fzviMjkfA64YLiXJgh8RcJDIApw5Nk7P/Rw?=
 =?us-ascii?Q?RL2U9W6T8PigjaNDZIKlK+6sSJG8LH9KUFT++xXvZHfqtVcOTjHUlcKa0HS2?=
 =?us-ascii?Q?C3DBA/3iuGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JHhOBuOwcVI8q+aTgF9UoGhuAWeP6p4R29Rx4LQM79C2GQUSUa2H9Qu9H+Rq?=
 =?us-ascii?Q?pR6Lt97JPFBMNrPfWxQjroMoKQQzQEnK/tjUxk2CAuuNAg6V4+pOtic0F7pH?=
 =?us-ascii?Q?WOK5Opz0CYjalSmr/hWlnEpEYeRwxyLEkh8GWgrEVh6c2MOzaqvCa3sQncUG?=
 =?us-ascii?Q?N5fxB64sd4zsjxkHUzHuzwiiW7k6xHbfR15K+3BvQnVjb5nFoi1GhqWkZhth?=
 =?us-ascii?Q?urqp0421qmegDZcDkmlh4ryuf72h+bua05dggbWsa0jgIDKf7wB3jI9XIozn?=
 =?us-ascii?Q?SZj1lKDUBC/wD22c/7nvEIRHFdjUQ6ga5TV1ERZnOIHmDF2+bBjLubItTuze?=
 =?us-ascii?Q?BKpl7AIKnKuGSdBLwwocK35v6+aQRSwhuU3cus/sEyRG3GSyb+Lu2RUMiU9X?=
 =?us-ascii?Q?o7HlRQuBbqx1waPcwZx7O12opLHr0C3P29iNtSmFrKvY4hxDA9LWdWkPL4ZV?=
 =?us-ascii?Q?5QBV3E8iXlw3xspkmyU3H65Gz16SBKitq9yIq7Xa/M9joObGPkjVtzOzIUcV?=
 =?us-ascii?Q?jkT2AASMsdhVyW8P2dKdKRjywhrAheSxRgmDtO7WkpVY+G9HbHMdh4TN/LSk?=
 =?us-ascii?Q?IHKSzMED2yryvB6oWqhkEMts+6g268W5/E6IPzHEU5K+1WXF3A8f6MiurfN0?=
 =?us-ascii?Q?WMR5Vcy890yw/U4t05S0eQIuThJr6Rk5U9xs4+j9mLg5vFhkjUfUlUhkIgg+?=
 =?us-ascii?Q?ak2P5uXB91gitUpd9jDCDo7BX6RjOZ5p1HzdIvz3PTMX1BDBHFlvRAp16RgG?=
 =?us-ascii?Q?5oGhr7tlcqK63qsP7kilZICDiYuZMB4sU1qBTKzrb83kGXxrpmgVguUOoRPF?=
 =?us-ascii?Q?PHI7OprenmvNxscRMdhXiboxRyDFk7P8WRUe5zQKyKE+MT43Ce8rAklcqjaE?=
 =?us-ascii?Q?vddDyGKC+er23giAwG4r2XCWksi1rrGpIAJG4DoFYky6URLHcXDWV4pFz0JE?=
 =?us-ascii?Q?vL3sq0alLz6pk4BCM2M0GeB9pie5yBBm+ACYsAnG1rsMSzUjiCALb5kxz2lI?=
 =?us-ascii?Q?XOA54uAft0DiOuMx6YerRRyD5ENy6twKB70Y9pCt63o3AMFS9wLtlNjtsv2W?=
 =?us-ascii?Q?nJTebzKD3cFMBnDZPmFNnGIDXJeyIEDhannw1BloIHTFcYEo10sNfHDDK9BE?=
 =?us-ascii?Q?IHWW4FcKkK1/3N6rsTMonr760H6clEXMLuuBuB09GiJUb+f0NJ2SkKM0hJbj?=
 =?us-ascii?Q?3KiOv8H0BtxpH5jZ4CZj7Zhg5r/XeaDW8r/uJB99mHKP9FlFYqj/CQztKuB0?=
 =?us-ascii?Q?TU/HljUS9CpL6jNgEOjeoilW26gx9ZS6lEDXFYmEnDHuNeYogDP76CElkuum?=
 =?us-ascii?Q?9+2T/AwvXejtnLjO9owAtzwjvB3rbrlzdJUu3ogd2rXhDxp3JlsIks69aUfG?=
 =?us-ascii?Q?zl5OzfhYo+6KxhDXZgfh4oUqAHcsc9NyQbBfYIE0q3e2LhP1Z9gGOOKuvxvu?=
 =?us-ascii?Q?Lho4FqeQ7y+pY0foJHMgaRo9a6NVNT66WLgfMf6z3yV72tvVw+aZtouhxKYo?=
 =?us-ascii?Q?fL2YRdDlo2I9vZMQvpe1LSMxpX9iFMn01+BIxmZ6yc2e8vNbLWlVZ/GNQKyc?=
 =?us-ascii?Q?6W+7CeNVateog9nOz+iEKBF8GA2ON9oh0ZTrgubcQkcqXdu2mYOJ0Fls40NF?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b4fc70-5404-478b-cbb3-08dcbc4aa4b4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:55.8857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msJRsaqbrp/LRwfMPmo/T7gKMIQQrDyfXF1Ga7ytbO0jwJIOqrfwGXqjzBtqF63cIWwjFheUvwVg9Cfgd6CcLO0OmjHIRBU1Z1YsvLOFwaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9524
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
index 6ca8b7c80cc..548a7144ee3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
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
@@ -413,9 +466,8 @@ out:
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
@@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
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
@@ -1056,30 +1079,6 @@ static int spinand_detect(struct spinand_device *spinand)
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
@@ -1169,10 +1168,6 @@ static int spinand_init(struct spinand_device *spinand)
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

