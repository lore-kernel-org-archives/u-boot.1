Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C39CCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4938390B;
	Thu, 14 Aug 2025 01:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BG96BY20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A0F838E3; Thu, 14 Aug 2025 01:43:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0228383A
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD7avCpJZBNw85Za7edN8jnk0OK3XRfyEoTR/07YqJs6nZM/RJ73QJbuB0sgwAFwwXwz37w/dQLbF89BQEzNDkjoaeKmDoFIoMpEy6rxqkUdAyHE3YnwSMrs4TBtHNqv6hDgfcYqpYul/V21cUipzXZwkfC9pSVco7lCeu8wQVfmsBeVINDGS83r/80Q+ToAz/SkQVlbSBt4IBGXS41uubxfm+GjFA+vzECuhhAhYF+LS/5LufK4H4tPjXzyBqnMuDbYY6bUyBvFEEA421F46AgiheF06yA7spzYYbveDnCQeOIvRf/jL+jRevRYupf+NwIGsaJlWFjcafBouyejaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZhwE3I1MuCvHHFwpq+lWC0Fqb7ltnaYcEMPyPSX4zY=;
 b=BQ9bThQbHWgnkTEbSaycNjEoCIBqQGTsxEdVxIYiw3ZhWHiR3UqEFxkA239L+1+dn1KX2wb+1T/G5ihU+048vUOYbqItoPi9bPl8EBewDthQCUUiC8ag+9Ma4oRgO985uvsyyweyqpQgYGXLcz1Im4hnr+wBVy1lmcyiKOPlfxRibv9Xf4+XHChNq0KWAlBsgxTZn4GdpRXiUu+agCosWoIT7miWLZgrQtngO9kL3NB/ak62lOF5tl891zE1kIhhal+XIBuKvvS+vHM6WBgTN+asFYSGQ2eIPoe1L0tkc89WSxmBMAiqa6s4lKgkTbnfJW8vu7sKZQqcl9RmwEAr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZhwE3I1MuCvHHFwpq+lWC0Fqb7ltnaYcEMPyPSX4zY=;
 b=BG96BY20iWV2AYoMAz/+Gt1L/gfSEv8hDFhu3MwFPPAjGXWZGB0UVP7SbjE3sG43DR7+zB3awYJ/qfcyCP/8jeCgPPjq8FFYThadb2Z4M2nLloFraF2SvfpSSw1NsPfDkJsCREXZj4axSTKDGcCuGVRZYclditDzCLWNLbuBVc1lFoHKT2uSGCJvHxTrdAhBwHaagKJ+yxKSloDKibGRPPO7uhpzphi8KtxKYZX6rR7OVmCVfh6GLaUKJ+iBkYFY+depYpQpJ88mqfsjatYbT2Ki4eWh5cmaHyolZDM1DxQXrkg48WAGCerDcicNYKquUec2jYq5dLb/CccxPau8gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 17/21] mtd: spinand: add OTP support
Date: Thu, 14 Aug 2025 02:43:10 +0300
Message-ID: <20250813234314.3945708-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: cb89562e-de78-4899-a4fa-08dddac33e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?68lX6apHb6rC97nMjxjP0yfEy3ml7+vCEIR5QkdHJNQU1ixHksBINsfKJgmT?=
 =?us-ascii?Q?k+1ONeJZaXMFGFDClmVWf2Odb4sXlp+v9OErb/agUpEXbSFxy6ORTjJWXFsZ?=
 =?us-ascii?Q?bld/ykMDFOEc+7MMWeO4rOaNiPMAAoSM43rgHf6+tcFQaJaRZFhR4sgipI/D?=
 =?us-ascii?Q?z0WtrY/QzGLvzUbZYv7EA2VSOJefJENNy0UHfH+NGY0B6Ps7HBnhuzPHCflo?=
 =?us-ascii?Q?ZRJ7HxnsfA1iaKGdOb7VDQZipgdDSar8YM+EteOeQdtal0vUWmP5MJKf/AkS?=
 =?us-ascii?Q?EtAGjmx/Wve0ceCLUgl4v4EhdhaFJ+NekVbGZCs9GME43y2EqfdnSe/oQT5V?=
 =?us-ascii?Q?RXKsMvmvrcEyXULBnWWMiNfQMCXdb7uR+kzxU9vFeZS5SvctE8cWSCxrPEpp?=
 =?us-ascii?Q?HHoPV8RJC29wTzgUVLQFtUIsbSfbosQV6eFMo0eCKskZ5UYKBsY5odxzuUIK?=
 =?us-ascii?Q?cNS0LZs0Wi2DdbS4mpDcDye3A1tG4SSg9rTm/sf/MjdS+Jtp7SwC2uYb+yN/?=
 =?us-ascii?Q?Xa63mGJr5eEo3xNvB41sqSjlY2S3dTiKyvwMTAMBurA5z5y3vWJakOXMZjzn?=
 =?us-ascii?Q?0iK4ynOhm2b/3Qp6l43fMgQzAfeMG2fA6YV8cj1jqMsjbnT/s6bgHEqx/K80?=
 =?us-ascii?Q?dmBrJ13WNcCB98GKGlqTfWuYuFXSFZx/kiiElrYUXKKyVQ1geNnpzVxBdVke?=
 =?us-ascii?Q?C+rBwx30Qn2fARXBQqUUysWXfhMBDzr2LGtOKKhHHZDVNiCL0hBUJQqQstSU?=
 =?us-ascii?Q?VIH53BpLETc1TwzUJ0b1RcAk2TIUnOyErrI+LQQgREJIo0G0Zs+u6gVppbzM?=
 =?us-ascii?Q?4QSJ/oCDE/FinF9fb51EXpOV41OdZ/+8z7geN4xi/CdFMZ8H+kaYlyl/bUdX?=
 =?us-ascii?Q?tT24wl8NrGQTrfq4tQiCK7hUkcw5gSpK8qVEyhqKCoPKfBEb2q6ZgGOd0FYL?=
 =?us-ascii?Q?bdDf05/KzPa4F+t3Z0WgW+bJ8eG6V2P0ai/g81p8EtvAGtKtKKgz+Xdp/LOs?=
 =?us-ascii?Q?7RElR3Qc1sd1Vpa+chMYu+NgYouGRaKy42eXMka+92qwwKp07R52wabKRpjM?=
 =?us-ascii?Q?oQtiX9Ka1pX260FyPzxHHjUdBSsE6+32aHzVr5ZMRN+qAf0QpdVNL+28jokS?=
 =?us-ascii?Q?ErS+dQRl9zff7uLCz8h2bS3TXuXFK4F3rZCGTU648oITIcB0xNoQn++Eznu6?=
 =?us-ascii?Q?jmTM4e0oVt/jAcMw8uClOHr+LCSB5Hm7dZyyD1XTuIhoffLuFNv6MRmBmavI?=
 =?us-ascii?Q?x+2Ke9Etyj1OMBHvEiEJ8SIwj6Jj8nof55gKMQrb/O3r/dMGQE09whquINlL?=
 =?us-ascii?Q?z3Wl6DQlJUH+sDdLeH3sTd0J284TfEhp5xiYm+IWdcjeXKqtwS16Bgg72qB1?=
 =?us-ascii?Q?6horSArfxZkYHhp5DFQHMcF0Ewm3ORyjWgwGlszfu4LXOwitT2QU9dzePkuo?=
 =?us-ascii?Q?ce1ObGc/6eyNvTzG+pqZTEJbEuhcMEoJle6mWz8auzbegFw/P9S2NqtLK4mZ?=
 =?us-ascii?Q?P6pM7jGsEv4fSXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRTrAP/n6lN3xXs8DYmT9fOYm7Y4nALBZmCJTptH7MiqYslTXFEh3woXVTun?=
 =?us-ascii?Q?AV5ki/vifzS/m7s9tEmiHW1tceJXy15UPYxmvK9egmyTznilWMpOKLO80FPz?=
 =?us-ascii?Q?2L5MTrSIAaCxN9QWtlpQ4Rlrox2h2RndgVQlXhqlPrTG6/SPVQZqqG/jyxEJ?=
 =?us-ascii?Q?ZgyqY3KGh85FUGOe2FPRM3m2GJ3MS/g/D5X2glWHry1mJ+4L8VFecQCDwGXM?=
 =?us-ascii?Q?hREwJ4dhQE/MFWps2AwPs4XmGgOZwKPY/oFKb/JidbQpB58WzWsAv9BmKXpH?=
 =?us-ascii?Q?fOIjY6auPueSdWk883tXtU/gSXf3ixN2rShFUAtU1vPxwOfiHMu3H4JcSdb0?=
 =?us-ascii?Q?/9PBOg/R7MkEOpb3bXomsFil5vEGgtN1lSvcxmg01ZKun2dhOPTkJ/P+FsBo?=
 =?us-ascii?Q?hcd6xvmy64SzmLzajf2JuGlNagkQRBqnRVk5EuTRBddEHmUSpa4amnTq76jX?=
 =?us-ascii?Q?1pfaZKRa1sW02Za3bek5OAC6c9j/qeK84SmDjOjnuEV0pY/Aqlr8hpZWrS6a?=
 =?us-ascii?Q?f+MuVmzCGgRq0kBXNXPW3Wnx46g8c3NFQgJG30gBqLPb/CUBSNOPeTVX0aEH?=
 =?us-ascii?Q?5enmKDUueu43KihjzteGLukXtynl+zcZb3QDzfv8uBx+Vwo+cPtznHupaGRM?=
 =?us-ascii?Q?DcUrHA5kr7cihscAyWFtW9tu7OkUDpa09yN4nhJOax1sQI9sQiReDoZLmpmq?=
 =?us-ascii?Q?+yE82apDrcGmvOZ7irNYPkgHDVP0+6Pba3Z+eWscqSNvVy7dOFN0EciZQXnx?=
 =?us-ascii?Q?jwyZW/wucofqMioh4NCl6Z/9YFeDUA0LR0Ip8fR6mxwPFMu4rhXryDFRhr84?=
 =?us-ascii?Q?wHE9IcPcgbNI2JufaENMVjp76PQXfu4EwkdYCXN2QjUT8Ya8gK2dJ5VHTYGB?=
 =?us-ascii?Q?zTsomBngM2CSHk9+TzXoTflgHxLU34ZRbMsPF9oCM6qWeNf3zoo0eXIeRLe0?=
 =?us-ascii?Q?JMd0Ei1ILQPhGJ7JXEirtP9d6Wa949MglUNYWOle4s+Pclgb/jXdMaxnHM7N?=
 =?us-ascii?Q?jDb8Tz4IQ+hkeSNQW8rQSaYN/6VC7Vsm/kkHQC3y5rE9bXx0q6/0tZZxQZG3?=
 =?us-ascii?Q?eB9rq86j0a7fWNsJ+BmMGFdYO/bRYSYLjnhbL9cc0gH3AkS7wFO4EnNWpUNg?=
 =?us-ascii?Q?z0/ZQORexJoNn76yRiG5dXTCAaFpjbPm+62vV4rlCm5/b+kG4uN/EQHEbAKd?=
 =?us-ascii?Q?SqTfLiDMkNwsrRHt/lp+ypyjB4joK0TO+DPJQARylz7Mv5L5vUSIsYmqEi/5?=
 =?us-ascii?Q?sEO17nZKjLSmWBLh1pdPEEP/k/FVogto0mXwpZt+b+06YRVh30nUppgRSW0B?=
 =?us-ascii?Q?OcBJyabE/qcJvWw7kGzaAUJ+RDibgec22AmLHXd0Db+gawqn/edfdQQsDnsI?=
 =?us-ascii?Q?fSh2SPdo6Xu3NYB5jBa1hKrywc5JSG1R+IaiMg6fPG4hmvqe85QF7qKZeKm6?=
 =?us-ascii?Q?UkQ5IVm7N63WVWRQUXBmCUUFCEZXePJdI0Qz3iZVyV2jOCvZSP7gGcoBgDZZ?=
 =?us-ascii?Q?jiRKRPcE3MnpESBrrh1aQXhSjK80G1luLye3l5QeOyhmvmgLQ5wE3sG+ezMh?=
 =?us-ascii?Q?vAZjQqC+rvARdcctjrFBD+X3+pZ+CRgNpCKKpqKVdqYtfoGB9ksezn2yNFqK?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb89562e-de78-4899-a4fa-08dddac33e85
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:46.0746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlEyJZwxAmVkIYa2/A+zio0PCMfRCvNIhxCYpoJROfPZlCVwuWxoIr+vVmRlPF82IDDFaMkVzIWgpdsJvCDg+yPXkGAXGxMlsv4H/5WVsYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

based on a linux patch c06b1f753bea (mtd: spinand: add OTP support)
created by Martin Kurbanov <mmkurbanov@salutedevices.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |  42 +++-
 drivers/mtd/nand/spi/otp.c    | 369 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   | 112 +++++++++++
 4 files changed, 516 insertions(+), 10 deletions(-)
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
index 33d0c27f788..f16d3b0335f 100644
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
@@ -543,10 +543,10 @@ static int spinand_erase_op(struct spinand_device *spinand,
  *
  * Return: 0 on success, a negative error code otherwise.
  */
-static int spinand_wait(struct spinand_device *spinand,
-			unsigned long initial_delay_us,
-			unsigned long poll_delay_us,
-			u8 *s)
+int spinand_wait(struct spinand_device *spinand,
+		 unsigned long initial_delay_us,
+		 unsigned long poll_delay_us,
+		 u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
@@ -617,8 +617,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
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
@@ -648,8 +656,16 @@ static int spinand_read_page(struct spinand_device *spinand,
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
@@ -1338,6 +1354,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->fact_otp = &table[i].fact_otp;
+		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
 
@@ -1504,6 +1522,12 @@ static int spinand_init(struct spinand_device *spinand)
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
2.50.1

