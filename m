Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24D2C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D27847B9;
	Sat,  9 Aug 2025 03:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Q1vS2KTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01D1847AD; Sat,  9 Aug 2025 03:06:27 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692A0847AD
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH3tH7BjT1TVt/Io0fGf7hjwze0Gatam7r3aLd4jFqpti0mSHZ2zB+pVeDKZLxvcYNTiq4Ru1fcUK0vrmTUwsxYd4rkeVzXrAXgRp7n5FlCNg1+BTCVyDek0inZTq4BDJJwqJofZEUY8Id8V1NfoZpZ2Y5HVp+UBGDrCZtIJbt4Y/GK+zostsMkR9lYFe6J9d5Cwko+rHiML4ZNL57wfWfVHmZEApo8csCOz49NfFIVGyjhJhr/Zfl633dkfIBe/QCUAoYpTKESD3nzFHh3UQlqWA6DblWxKXcbZdpJ5l6jEqkSZnkll2cgL5blar+dGedSx+eYnaajYgkmPufy4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCfvaMzx3zIOwEb7GX5TP3CtSv0tV7JaTo+byPksC6c=;
 b=O4DJCqPs68xMhAErnZf5bfqqqNhwP3bB8VrWCXiKZx2iLn82ntb5w68wNcnD8yy/sRDJiN7i0NTVjZFR4NouflTqMkcsY0xf5vAuzOpn+hH3BLFz5NLg3zoCMtGxx48h3JrZIV4VxUWLhSDDfQqrXK+KzutaZPRGxBbWJFFs11iaPLxEjtrP9LLd0l4dT4dr2tzjr1Y5zojFFN4YSnUzvYaqmQAGVse9pzMozWF6ZcLxihpRLKY2Az/Tx/WKbPOahwppDL4tnZFWVrJyYGsGevEgxfAYkNLEgyA/ovZQIFbtVtDRl3Y4STXcE8ACnJSA/+N0BL6Fjk3uu9RQlv8iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCfvaMzx3zIOwEb7GX5TP3CtSv0tV7JaTo+byPksC6c=;
 b=Q1vS2KTQa8F/78DzbYyZK60q9iplsaDqUW5YBZTSfxcm8rl1E08r2yMGLVlXEeYBBnmLW9QoVJhJozM7zkuhdLvuFLJxLV0NIcID2BIAZCnRsc6CnkNso2xYBLtTJNHX4n6f6ePflY/09/oaKQDWB0bXqiYtys6EAzX6US1b3yp2rq3c6WFVmh2GI2O3T3rXJesnOW1nsI/qnGPjcxQeta1TTp6wBuEe0tYIXYhZao7YzBBdpP3WPdBXM/k9P248lRZE9HobJyEQFMAQqssTaGS0iXghBUYxngL+yTsuiO0nVTUOveg8mqFjFT9ph6fhMBjQkxbXnBloToI1eVSmrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 17/24] mtd: spinand: add OTP support
Date: Sat,  9 Aug 2025 04:04:49 +0300
Message-ID: <20250809010457.3125925-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 5830190c-07fe-4415-2399-08ddd6e0d361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dhwfKYtl8SubOVx0FatRZDtNN7vOE+VCWM2SzU86jSFhSzuHkZVkw/f+CT6m?=
 =?us-ascii?Q?6PzLnEeJOMO/GcQm89uZXLMdiU6KRMtNNU+7S6GMhTPrqNeRDxZ/YEmnRE1C?=
 =?us-ascii?Q?aKbNYDjO0JcX4sYUQsmI6DGrnXJ/4a74TFIp0JC/LKPeEfpAxzFv5/EygMG3?=
 =?us-ascii?Q?gUFe7jYPJdun3Wy0dKU+0qeG3wNdSGOqGAKTpeoK+PO4W2x7+B4VVUhK3wsr?=
 =?us-ascii?Q?b9P1jPjLtdPuMc3NzUFTp2iw1WuXvSPxuxCb/A9nm6JFxF1sGZPRQUEbn0y8?=
 =?us-ascii?Q?6lobPeuVYLXnjY2EkQVq13iZ29Fj5PkkBViy+mV0OvIp4ZE8ja0deQNchWeH?=
 =?us-ascii?Q?V443pcX8H/UVb6j4GZ9OUdorpWIv4t8Wlb/wtBZH7AXWKKGRhuwce82yZ/zr?=
 =?us-ascii?Q?8rD+8NdgBBcum6vN6ndEXQFaSvbZd4jxMBOZoIbs1HMTQ0+2FnFwemq8oO9f?=
 =?us-ascii?Q?AkCJZZpO8xFi7Rva9FOQ1b4kXN7mfYHeNTI1kSJRs7wrs68p9p93SsK9LnUh?=
 =?us-ascii?Q?L6A2C2VkrByG/PMVwa7XKUJoKzf6Xj8q8epGxviWJw+FK2erqUUzim3jQrCx?=
 =?us-ascii?Q?hzBYsQMCjHPR4QzlnBtfLrpRlOhRFHMxXpL3cnOcx2hf+9d7yYyHtHsr5Yab?=
 =?us-ascii?Q?Nv8xKx8Oy16EklJDw4msjFXRe1gCglq1Bg3S+OIUsyEwafUCxqpshmeQL2re?=
 =?us-ascii?Q?olai8YHZZ6FTQ+wK1/YCqQdT5Aq20JNwX4k8Q5upKkr/UL6Pc/CqSZxS71mI?=
 =?us-ascii?Q?80Ll3et228MrWc2FXl3tuuQegVfNezSjwaIybU0kbQPsr23t8YTE5mXrdiDL?=
 =?us-ascii?Q?CRoX62AeSBOzzkDn9uhFo4tYGjKebGD7gARs+wRJHascountro/bfB7RYOu7?=
 =?us-ascii?Q?izIrmnfIEK0qFJLnRRF2wYBwCVXuth+j2VBJUrMHkT1UsKLYnAQg0FB/QkM+?=
 =?us-ascii?Q?RGwIwG5kehUFtpjBiI7s5P3EPR6uplm48xmQ8eRoIJCMperA3aU4RHXYUBs8?=
 =?us-ascii?Q?hm9hTFeUJNnaJeP4A5dbWo0amicb8PmJN4OFMD1cV4Q9zL0H1fXSt1ctrKqs?=
 =?us-ascii?Q?biFX8235l7iLMQ7A/Xvl441A1daatOHBwQVX6eSwBQshctgtQdbphPjJPauh?=
 =?us-ascii?Q?Xp33PwMU2GSL7jO/ir8aPN/mR9bPXGZ61l4pJKUNQwqb1viSWe71QpvXkF/c?=
 =?us-ascii?Q?c/W0DIN0fh44mptVrRVblheJdhmVL2Rk60qOYGu4135Rc8fKfYDV4h5yusht?=
 =?us-ascii?Q?uHbTaB5VBtrwLDlkwKLuugf2r9wmxU384aSDyphGqPXokkAOihbw4hN3+iXo?=
 =?us-ascii?Q?BpOUZFT0tTgHQRKNttAnSCz8btP7LoIaqdhfWs7wju4doZ+vRHnXEtZUC5l1?=
 =?us-ascii?Q?tPATcYDmwoUVGMjd2uSBcHIE4kUWBvwe4PBEElnZAo/m36LgJiEIQLkdVhGG?=
 =?us-ascii?Q?ncH0A+bsUzICXE47yN7ukybZERqhI/NGNpRtymWpIk1Kuufa1f0JlmN283gZ?=
 =?us-ascii?Q?pmJwFqM4IMTW9fI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UKTe1myWzQIGJ40jhcIsvUrs6BOfLRYMNUEHQeR2Nc9kozO0Vtyfakl5NEjS?=
 =?us-ascii?Q?mAimnBhF8GRw4voCWR6YvrYMEuipL134fPLpT548UFIzjLMWB82LiOZNbM4j?=
 =?us-ascii?Q?Mu95+Qn/mXlDCxy1KY9S3J10j5EgLsEOkiz6GBh8pss05aKJub5RrRqtkEtc?=
 =?us-ascii?Q?9wHXuoRaLA3M4zMjqG7GaWn1Eqy7uoAm5Mo/nnDYV9TlAdjZozBpUhpGbyts?=
 =?us-ascii?Q?97HKHTpUVI5QqlZMC3CVQxoOxFMZXth99DTM2vDzz9nT6oTieP1e3FRbLz7/?=
 =?us-ascii?Q?RzJkjtiNLjxpuHbD3byBjzT8rOsnvNjXTgPM1JalTLxGPB1IMdCLRSWQdAmn?=
 =?us-ascii?Q?qP9bKBSaIk69B4PzHGE3k677M7j4FY6LY5fZ1IJw7sxDRKuX/D/nz68eeMI4?=
 =?us-ascii?Q?oUTZuorYFsW+HoYB+tCa6LyBqnEc9OUlJSpd+OKBy5H8ulTuLqAT+acyurAq?=
 =?us-ascii?Q?b0+GQBCZEICTFCra7OW6dls6K8ySdgvRTnSbUwrrO4khx8xwdzxwSAzCblNs?=
 =?us-ascii?Q?ED2FFxaPeyAmmAe1KHz1TyADLFSK3ZkPYXggxA7N7RI1CtkXG0uy8tEunV/n?=
 =?us-ascii?Q?wIzDHN/4NtdszR2isax8umk3194t++W5Z/PSuarIlUioda0JmIlHqr77a3VC?=
 =?us-ascii?Q?dJtdBDXsFVE9Ks2CgtA38PZziQOkYdX3Xw6tl+3fOHDw8V/dZX9Txoqt9iHe?=
 =?us-ascii?Q?nfE8jrFq8CzTHJPtOT9Sh3UuWyey+gnFvGnKpL0eJGOHQDcda0hKlTZdG4Ge?=
 =?us-ascii?Q?ls/k7gicJ76HnMfYWV7MEgKVST7QlflfLcDCnG3cuqSoye8MUiLkoW9LiiRv?=
 =?us-ascii?Q?Z0dJJznbAsGlS5p/0/7lo59OR2TL4vD06zip4uNPx7tTrJj26PRjSJhJaWNr?=
 =?us-ascii?Q?s6A1IvmtT2vywxATz26sxVC1sN0qtmTLWFRH6zTL57uXkf0mR3CYoxWW6/10?=
 =?us-ascii?Q?7Qr0O62OHeaJZohXluflJxHb3h0qk9a3p7057lcrxW+wYY8UH+yHI3kl01qF?=
 =?us-ascii?Q?IRKgQFlau0GyX2XOPeIUPL0RYmkXLIFO3xVlnNbJ/fVZKlVzDZNZm3KIY635?=
 =?us-ascii?Q?i7jc99wW1enJ72U91z8W0L+IOuOQcmsbyKCKFo8UAZN11w7Gd1Qf+qDnjNM+?=
 =?us-ascii?Q?Yq9sr2QDaGYn0ZKV/t7a0n8nXKhLswHRheNmuKssO+AZnaPNsn9YdfeIIiEh?=
 =?us-ascii?Q?znUR7UkXhEtHlPongXU738WGaVP/aGu0b7/sYhR52A9WeSJhSIiyagxfetGJ?=
 =?us-ascii?Q?EmRidwPEmLm5ee7eA1lHvnLiNMOVSofagBZZlFHUMZS0z7B1iAJZWc7tMYH4?=
 =?us-ascii?Q?drKc00RO8EdpVir2CAwWC/v6LhiffNCSTDlbS9/krSJJBdVcL5gAVGm83gc+?=
 =?us-ascii?Q?7mQpxNTm+ZSPv3+HCEYqTMGNFKwTX2T2TaQQg6uYJsX3cfaZT3zLZfHNtwtM?=
 =?us-ascii?Q?oJdHlngD47Q3bXyjtfmcXJjTgki+74+BC5rPu3/IjtVa1L0zQkFFd2tZHPCq?=
 =?us-ascii?Q?VMQ9kCuocBPS6O5IjKp5KtWrqv75r5VlDaxFW92ZqLz73Ue8XQuz1AvNS8Jg?=
 =?us-ascii?Q?l66n2ZArXRoQCF8PBWXGlos7gBl0nLRUH40S/1wxdNbizQ5TPzJMZRpHxzhW?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5830190c-07fe-4415-2399-08ddd6e0d361
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:26.5371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yU7XZeHbFYrco7Wxfg0pin5sy2GdN1f8hpbiHdhcZ436ktjE81Do6zM0fWvx99NPmWp5j51JwTlXyt2poSKb3jBzFFGSWjP7BmwfMPyZZ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

The code was ported from linux-6.15

based on a linux patch c06b1f753bea40a282f29a9383fcf36b12323108
(mtd: spinand: add OTP support)
created by Martin Kurbanov <mmkurbanov@salutedevices.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  54 ++++-
 drivers/mtd/nand/spi/otp.c    | 369 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   | 112 +++++++++++
 4 files changed, 528 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index d438747cf37..831760da1c9 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs := core.o otp.o
+spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b3418624e3e..f16d3b0335f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -56,7 +56,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 	return 0;
 }
 
-static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
 	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
 						      spinand->scratchbuf);
@@ -531,10 +531,22 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_wait(struct spinand_device *spinand,
+		 unsigned long initial_delay_us,
+		 unsigned long poll_delay_us,
+		 u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
@@ -605,8 +617,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req)
+/**
+ * spinand_read_page() - Read a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -636,8 +656,16 @@ static int spinand_read_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_write_page(struct spinand_device *spinand,
-			      const struct nand_page_io_req *req)
+/**
+ * spinand_write_page() - Write a page
+ * @spinand: the spinand device
+ * @req: the I/O request
+ *
+ * Return: 0 or a positive number of bitflips corrected on success.
+ * A negative error code otherwise.
+ */
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
@@ -1326,6 +1354,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->fact_otp = &table[i].fact_otp;
+		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
@@ -1492,6 +1522,12 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
+	if (spinand_user_otp_size(spinand) || spinand_fact_otp_size(spinand)) {
+		ret = spinand_set_mtd_otp_ops(spinand);
+		if (ret)
+			goto err_cleanup_ecc_engine;
+	}
+
 	ret = mtd_ooblayout_count_freebytes(mtd);
 	if (ret < 0)
 		goto err_cleanup_ecc_engine;
diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
new file mode 100644
index 00000000000..e6ef78d9464
--- /dev/null
+++ b/drivers/mtd/nand/spi/otp.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spinand.h>
+#ifdef __UBOOT__
+#include <spi.h>
+#include <dm/device_compat.h>
+#endif
+
+/**
+ * spinand_otp_page_size() - Get SPI-NAND OTP page size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP page size.
+ */
+size_t spinand_otp_page_size(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+}
+
+static size_t spinand_otp_size(struct spinand_device *spinand,
+			       const struct spinand_otp_layout *layout)
+{
+	return layout->npages * spinand_otp_page_size(spinand);
+}
+
+/**
+ * spinand_fact_otp_size() - Get SPI-NAND factory OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_fact_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_size() - Get SPI-NAND user OTP area size
+ * @spinand: the spinand device
+ *
+ * Return: the OTP size.
+ */
+size_t spinand_user_otp_size(struct spinand_device *spinand)
+{
+	return spinand_otp_size(spinand, &spinand->user_otp->layout);
+}
+
+static int spinand_otp_check_bounds(struct spinand_device *spinand, loff_t ofs,
+				    size_t len,
+				    const struct spinand_otp_layout *layout)
+{
+	if (ofs < 0 || ofs + len > spinand_otp_size(spinand, layout))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spinand_user_otp_check_bounds(struct spinand_device *spinand,
+					 loff_t ofs, size_t len)
+{
+	return spinand_otp_check_bounds(spinand, ofs, len,
+					&spinand->user_otp->layout);
+}
+
+static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf, bool is_write,
+			  const struct spinand_otp_layout *layout)
+{
+	struct nand_page_io_req req = {};
+	unsigned long long page;
+	size_t copied = 0;
+	size_t otp_pagesize = spinand_otp_page_size(spinand);
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len, layout);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
+	if (ret)
+		return ret;
+
+	page = ofs;
+	req.dataoffs = do_div(page, otp_pagesize);
+	req.pos.page = page + layout->start_page;
+	req.type = is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
+	req.mode = MTD_OPS_RAW;
+	req.databuf.in = buf;
+
+	while (copied < len) {
+		req.datalen = min_t(unsigned int,
+				    otp_pagesize - req.dataoffs,
+				    len - copied);
+
+		if (is_write)
+			ret = spinand_write_page(spinand, &req);
+		else
+			ret = spinand_read_page(spinand, &req);
+
+		if (ret < 0)
+			break;
+
+		req.databuf.in += req.datalen;
+		req.pos.page++;
+		req.dataoffs = 0;
+		copied += req.datalen;
+	}
+
+	*retlen = copied;
+
+	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/**
+ * spinand_fact_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->fact_otp->layout);
+}
+
+/**
+ * spinand_user_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @retlen: the pointer to variable to store the number of read bytes
+ * @buf: the buffer to store the read data
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, buf, false,
+			      &spinand->user_otp->layout);
+}
+
+/**
+ * spinand_user_otp_write() - Write to OTP area
+ * @spinand:  the spinand device
+ * @ofs: the offset to write to
+ * @len: the number of bytes to write
+ * @retlen: the pointer to variable to store the number of written bytes
+ * @buf: the buffer with data to write
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf)
+{
+	return spinand_otp_rw(spinand, ofs, len, retlen, (u8 *)buf, true,
+			      &spinand->user_otp->layout);
+}
+
+static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf,
+				bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->info(spinand, len, buf, retlen);
+	else
+		ret = spinand->user_otp->ops->info(spinand, len, buf, retlen);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_info(struct mtd_info *mtd, size_t len,
+				     size_t *retlen, struct otp_info *buf)
+{
+	return spinand_mtd_otp_info(mtd, len, retlen, buf, false);
+}
+
+static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t len,
+				size_t *retlen, u8 *buf, bool is_fact)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len,
+				       is_fact ? &spinand->fact_otp->layout :
+						 &spinand->user_otp->layout);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+
+	if (is_fact)
+		ret = spinand->fact_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+	else
+		ret = spinand->user_otp->ops->read(spinand, ofs, len, retlen,
+						   buf);
+
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_fact_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, true);
+}
+
+static int spinand_mtd_user_otp_read(struct mtd_info *mtd, loff_t ofs,
+				     size_t len, size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_read(mtd, ofs, len, retlen, buf, false);
+}
+
+static int spinand_mtd_user_otp_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	*retlen = 0;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->write(spinand, ofs, len, retlen, buf);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+#ifndef __UBOOT__
+static int spinand_mtd_user_otp_erase(struct mtd_info *mtd, loff_t ofs,
+				      size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->erase(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+#endif
+
+static int spinand_mtd_user_otp_lock(struct mtd_info *mtd, loff_t ofs,
+				     size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_user_otp_ops *ops = spinand->user_otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_user_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->lock(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+/**
+ * spinand_set_mtd_otp_ops() - Setup OTP methods
+ * @spinand: the spinand device
+ *
+ * Setup OTP methods.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	const struct spinand_fact_otp_ops *fact_ops = spinand->fact_otp->ops;
+	const struct spinand_user_otp_ops *user_ops = spinand->user_otp->ops;
+
+	if (!user_ops && !fact_ops)
+		return -EINVAL;
+
+	if (user_ops) {
+		if (user_ops->info)
+			mtd->_get_user_prot_info = spinand_mtd_user_otp_info;
+
+		if (user_ops->read)
+			mtd->_read_user_prot_reg = spinand_mtd_user_otp_read;
+
+		if (user_ops->write)
+			mtd->_write_user_prot_reg = spinand_mtd_user_otp_write;
+
+		if (user_ops->lock)
+			mtd->_lock_user_prot_reg = spinand_mtd_user_otp_lock;
+#ifndef __UBOOT__
+		if (user_ops->erase)
+			mtd->_erase_user_prot_reg = spinand_mtd_user_otp_erase;
+#endif
+	}
+
+	if (fact_ops) {
+		if (fact_ops->info)
+			mtd->_get_fact_prot_info = spinand_mtd_fact_otp_info;
+
+		if (fact_ops->read)
+			mtd->_read_fact_prot_reg = spinand_mtd_fact_otp_read;
+	}
+
+	return 0;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 44c616a4acf..adfb5f3ffbc 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -322,6 +322,68 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 #define SPINAND_NO_RAW_ACCESS			BIT(4)
 
+/**
+ * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
+ * @npages: number of pages in the OTP
+ * @start_page: start page of the user/factory OTP area.
+ */
+struct spinand_otp_layout {
+	unsigned int npages;
+	unsigned int start_page;
+};
+
+/**
+ * struct spinand_fact_otp_ops - SPI NAND OTP methods for factory area
+ * @info: get the OTP area information
+ * @read: read from the SPI NAND OTP area
+ */
+struct spinand_fact_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+};
+
+/**
+ * struct spinand_user_otp_ops - SPI NAND OTP methods for user area
+ * @info: get the OTP area information
+ * @lock: lock an OTP region
+ * @erase: erase an OTP region
+ * @read: read from the SPI NAND OTP area
+ * @write: write to the SPI NAND OTP area
+ */
+struct spinand_user_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    size_t *retlen, u8 *buf);
+	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
+		     size_t *retlen, const u8 *buf);
+};
+
+/**
+ * struct spinand_fact_otp - SPI NAND OTP grouping structure for factory area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_fact_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_fact_otp_ops *ops;
+};
+
+/**
+ * struct spinand_user_otp - SPI NAND OTP grouping structure for user area
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_user_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_user_otp_ops *ops;
+};
+
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -337,6 +399,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: enable/disable read retry for data recovery
  *
@@ -359,6 +423,8 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	struct spinand_fact_otp fact_otp;
+	struct spinand_user_otp user_otp;
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int read_retry);
@@ -390,6 +456,24 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
+	.fact_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
+#define SPINAND_USER_OTP_INFO(__npages, __start_page, __ops)		\
+	.user_otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+			.start_page = __start_page,			\
+		},							\
+		.ops = __ops,						\
+	}
+
 #define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
 	.read_retries = __read_retries,					\
 	.set_read_retry = __set_read_retry
@@ -444,6 +528,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @fact_otp: SPI NAND factory OTP info.
+ * @user_otp: SPI NAND user OTP info.
  * @read_retries: the number of read retry modes supported
  * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
@@ -487,6 +573,9 @@ struct spinand_device {
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 
+	const struct spinand_fact_otp *fact_otp;
+	const struct spinand_user_otp *user_otp;
+
 	unsigned int read_retries;
 	int (*set_read_retry)(struct spinand_device *spinand,
 			     unsigned int retry_mode);
@@ -571,6 +660,29 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			   enum spinand_readid_method rdid_method);
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
+int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
+int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
+		 unsigned long poll_delay_us, u8 *s);
+
+int spinand_read_page(struct spinand_device *spinand,
+		      const struct nand_page_io_req *req);
+
+int spinand_write_page(struct spinand_device *spinand,
+		       const struct nand_page_io_req *req);
+
+size_t spinand_otp_page_size(struct spinand_device *spinand);
+size_t spinand_fact_otp_size(struct spinand_device *spinand);
+size_t spinand_user_otp_size(struct spinand_device *spinand);
+
+int spinand_fact_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_read(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, size_t *retlen, u8 *buf);
+int spinand_user_otp_write(struct spinand_device *spinand, loff_t ofs,
+			   size_t len, size_t *retlen, const u8 *buf);
+
+int spinand_set_mtd_otp_ops(struct spinand_device *spinand);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.47.2

