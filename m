Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF6FC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9AC8852E;
	Thu, 27 Jun 2024 13:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mulAJfUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CE2885A2; Thu, 27 Jun 2024 13:20:26 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0B888566
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea1Hz6fR1Ba4wO37bvQWVBGDhDHQLZtaLFy7rQGah/d6IGAtf47Xgv0RR911fddJrI+3h0y/maJ1ack9teTXF3wFwqlrMAEWP3jxVPRsCmz1AakeTUp8wSMkNfMWPcXD72DnrlVAiwViIWZY+FlmbEPcaH0WA8BPv+soRNEsDm2l1GAsf37P9q7oXZ3WGcdfSuLqL9RZcfsHOgLJ3VjKhpDmCx+2TNKYb4cLW808ATChhLQJlze4fuOJTiEqZRnHHf+GEZg6bJHuy+S9vQa92leKHwDmey/Wkt82kvGTlIbXIWzrW3+YZnJV2SXK8SgOCspbJNUzuv1enCYOHqsI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S0EMdBdnG2TMoms/Rvf926OmDTjdpeAFkgct9DnsNk=;
 b=e//7Gz9QQs4CzoFrrNe4eXKkoCSQsVRZvx5h4DGHtXTEoNI99wsBa276zScg25mTwJPGmbEmCo/xE+gU54nTmwlVFG4MlTRNDIb3z4GrqaKx/D0H36lClYWryD4AHoV9oMgdWV5/WLGHVUi+8Ev2Bzcji5bL2PVG2Tmpgl5RoTbTSwsB3j+wTPd8+jOVN2A4nkgTNhiKv/yWoEY66aihxZEE1IxXRpblUdlaVvnaHDMPlQba2WBL8J/KkmobaGmvRMqN9a5NujQ7gXkBTlvthQhsNomk+mSFqPeHfplxTMOCs/gGoJZOJwFG+uE33iE9q/HOaJXkzPNIGCyBVRt8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S0EMdBdnG2TMoms/Rvf926OmDTjdpeAFkgct9DnsNk=;
 b=mulAJfUk7aMKPaqaR+7XuXyO4HbLzjNXXgEtvPuTgbHWskA5W3mnvYvJwedTeO72prHtmC+nqyVUHhSkqYW/eQr2H83JvxQH057APrCWYvB6h8apS2a9bPgRrs3YgbUckxWWLDWZCVy6XnjvT0f5FjZrWB6nfgnoihFflE/B/UOi7qhim9SJx5tuTZn4uYTG1Xp80WkmbbKIVX9H8TrRdd+YN4ka44xu/boSlmOcOBKviwKtUVcHBDz6zn//1jgN6rN6D8+Yqazj24H5NIt6bWF/lSZEv6wJMwfozQBckHLaO157La6bn2oL/gKxDfdE1g3X8sqdDPdWQaGQPJbEMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6064.eurprd08.prod.outlook.com (2603:10a6:102:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:20:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:20:19 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH 6/7] mtd: spinand: sync supported flashes with linux-6.6
Date: Thu, 27 Jun 2024 14:20:04 +0300
Message-ID: <20240627112005.99375-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112005.99375-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA79.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f39e093-1741-4b75-17d1-08dc969b20c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ORbFpf1Yl1o9a9pj1AoLcobgMz5kUk9n/pejsAX5QVof5zlF4P5+hcA72TDI?=
 =?us-ascii?Q?da83qJbMI8cV9f4lvMunfByaZxH3MNDdOF+x9d5nogDbIei6pW/lOg0oR991?=
 =?us-ascii?Q?OHQCGQ91rxOwXW6mNsq4ysGjrzn0SC3a5Bzayj2vRFTRpKV7qjWXixrOQWeh?=
 =?us-ascii?Q?z7nvEjGZ97SH0Tj4zuyONH4QfZq1SGrGbySPpYXBVx+Exz1mkoGDjBfJnpIN?=
 =?us-ascii?Q?Ce3AkkjxzLS+KwH5bWPQZqXNSyrKqrAH5Y0ff1jsli4s7eBdQAx9+GZdgpyO?=
 =?us-ascii?Q?Fv0b/nzZcrVS9m6Pd3WjuHXaovmm0ObvYd8E6whYqI+F0hGsjOg1MuD4clNr?=
 =?us-ascii?Q?gCn3oum3CjCvoszHZpnoS2uw0FpHd2lQ2jmWuNeMnu47c8iQsZPhUNbDoyG0?=
 =?us-ascii?Q?LLFLyd7qUw3aNPBTkDPmAntKMNzlG16n8b1zSYHJHjO0CRctk1DpeMuRV/tE?=
 =?us-ascii?Q?pOD62aGV5tFZkR12hm+IlsR4RCORZZQR9nNosvbDX32XIwc7SilcdwN4xXak?=
 =?us-ascii?Q?r73kXl/0xELrR410z7rxIB2S7YXFMIYSC9J10cQYglVUArvmm5BSwX4fpaor?=
 =?us-ascii?Q?V6312YKTAH0k02xZVCdehgYHGpEblAUDNXkylJbxQSXKoTbqBtkmeuqVvfZh?=
 =?us-ascii?Q?Fph5ZoUxMf9/EWkt5WfhhkE96YHh/plw15tZcw1Da+T588ixnDim4++um7HD?=
 =?us-ascii?Q?q3zl4EAasolGDz9KIhEend2UCIAIO9VfCHwYzMLPUTC3ws8JKSwJhjIG8eAa?=
 =?us-ascii?Q?AnNC7U5PQzDY04oYz/Y1bcMECew4P3JBGVbAiWIY1jJshxcq0cSlG4aKs8o5?=
 =?us-ascii?Q?+MkXt/LQSLAri/S6lPtddNg1tNRU6QxNTakjBYXe4R4Be/U0k/g/ptkYsO3t?=
 =?us-ascii?Q?WNM46riR4zAxjuETGfNXnVAwv+droAWjhuKrVC4UcHrDYM263oeJcVsFm/m0?=
 =?us-ascii?Q?qWjOAFyrQq1n7JQBJDYPwxDiMrP8DFxuiosy/OXunnksTOr68A7Ifvtxt0OG?=
 =?us-ascii?Q?BqyJgW0FwI5VFBYv6Lu/6CRv9DxLs1hY77LaDOfEWMfctyW3JZIh3Ljv6adE?=
 =?us-ascii?Q?xfQcHOP2bvto+nQ5Adf/iJsrFwaJWz+r0VYOI20+wBfPr/+v9J5a1g4KempF?=
 =?us-ascii?Q?oBL3karPvsYNi0JrpxRA1gspD0wLWhYxh3w6YBpofxnmlp6z3yXOh1456YuY?=
 =?us-ascii?Q?nkKrTBdnVv8COBcHpI4UJEKw7PxvRxwkjzm5wgNk2hJF9r8ypgChfZCzyc4o?=
 =?us-ascii?Q?EqOCLYY26+Q6HPy+E8cYHdr/ZMz2iWSk9eX+QH1xlk+odVttXMRxqS2kq0Jk?=
 =?us-ascii?Q?B+r3jBHgqF0pNhkELj+4kxmN3x/8HIHZSYQCy8CXt2/UJHCgMrpbiKULVK+H?=
 =?us-ascii?Q?oTk/JBnNqRYRMm4JidBk1wxW8jvKFTvD3K45MbxyeA+lt8K1EOZ3AVQZP3D1?=
 =?us-ascii?Q?8+3J9sO7voQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmVqJhjSLZT6+9h9LQ6JiOpXkDdOJQQtrKRtFzb+aSskkTRJnRx1wCAdXTvo?=
 =?us-ascii?Q?jGHhbrQVCdEIx2zlsf1SemrDy1f5D8taB3SG79XBwiEfoZuEUO2fHqHxNNM7?=
 =?us-ascii?Q?FeAswQUdevJF8vRvXr3+0/g79zVGXovYpNoJ7dtWvlXD8GWrANdCPUk3Bm9m?=
 =?us-ascii?Q?ffAUI2K/apTRGmX2Q/at4oAvNbh3faxMLqr0M2zKdcf8SXQQgRTPoPYcfF1a?=
 =?us-ascii?Q?2/t/c7FSlBKL6OcYW87GuUEEMXBpCkPIzg7+HCplttvkXv0yRqN55yLMv3V3?=
 =?us-ascii?Q?KlpJq+CQgJVrfKcIr9K4JE/RoY7CblFFRrlkwIotzYxAPiNZUqHd5WwzBQVt?=
 =?us-ascii?Q?3MSaMesUSm4Z7eNOPBRa0vi+zjysLgWxAiCLEd5Y8Q9o1VkwSAKY7ydUtcxS?=
 =?us-ascii?Q?qFRLWX8KbLEmUgnkDEXhgrHt+hLsukKvCy7Bc9sxd8obfkl8IKuEszC5fURc?=
 =?us-ascii?Q?rA2Khx9ZSlcHdemPmKJCyYXAPRf/IPgv+F57kEqYuneUm85J3a/aBhTqpnzk?=
 =?us-ascii?Q?ZcwjWL63g09yIxMtAzoGV/0BfTpo0/MIEGPCrwdszNHDaj00Kwj9MUAjOk6T?=
 =?us-ascii?Q?nqW1pvoBkhYmTit7kWPVtrU36/lf/dgXmNIOupcafyPz8Tr7j3/OszpSj5JG?=
 =?us-ascii?Q?Vdh9lQhGsFf4Sbp3BYZ6aL97IxrLvm/WteWjA1NZHomTf2fb4TzATlJbtAvV?=
 =?us-ascii?Q?/xNH8vQeTvd84peOAawVpb9bZNcxhFpCf3bWuJXoHloqpmxpJwZxXBWojV9E?=
 =?us-ascii?Q?Ny+Wc3KGqebN6TsDgin8dsYcs5McxPtBkgvfL7hXjZOh3KO3bamMXZ8dyP2W?=
 =?us-ascii?Q?+xmuDA33wA7nsf8eWGPhvoS6aqwWG0sSjhzy8PZENoZNFjF64A0LQBbr3OyY?=
 =?us-ascii?Q?1aSs0wDCq66lwDJNtA7AHE8AMG+atSIYZ8UiSw3+qQsaPV539ssYTNZv6PLf?=
 =?us-ascii?Q?27VJtfaM32/XNXCHrUAXvZC1T00ksGSGlyaQ+mlZCX+PF9vRVxha3p/X4OIC?=
 =?us-ascii?Q?8pK4Dl2BPg/fejp/0PiNOOscfzZfOedbyqFH6uuG96+skm8J17+bI0EMQ5DL?=
 =?us-ascii?Q?9UcZlC6cIFNOE2owK3IoW9NMcLEoU5D0vV2BeyzM1iJKvQ6DbY8fGjnKLvVR?=
 =?us-ascii?Q?ftDIhyjolY8Ubodo38Fdp5pWadOQ6JaFQBpvhKBhWLd7Dw7x2sqlYsDIr/Ec?=
 =?us-ascii?Q?vpmRxFsS/cbdQGq3jow+oq6mO4PnYdrUbAcI4psT+zDacQYpD2MwLioCiHqP?=
 =?us-ascii?Q?DCucCCx06QN4KJ7bBXLnILsdSBf1t4uZY806zRMi5wKTYbaYMo6hU7eYqsZp?=
 =?us-ascii?Q?LXjPOR3LWj92ak4P5dnjHwO35ngGB6/LJhA1Ri5UEcL9DO8z59BnHiwRQBIE?=
 =?us-ascii?Q?oRLmi/gbYyTa7FsEmdio41XXKe77vGLsTOuwkyxwWGUlM3o+3VTU4E5qMxAt?=
 =?us-ascii?Q?2iVP05FQfxOKk5Pdm2AxjWp+Hvh+BCBsW5xKHoPD87Cq8vIwClmuB+v8B2eV?=
 =?us-ascii?Q?buSU6sdVFH1X0TthzFCjD0NgIzgR9XunzskQ2JHG2kZkyHmpPtxRe9GvrWh2?=
 =?us-ascii?Q?VbIpO0wZQKIAarqWMOc0Be6LcI9HO+Go8b/UGnzL7AsWicj5HNZaShSciLxm?=
 =?us-ascii?Q?djX8NiWAKJfa1+iAUOgTZio=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f39e093-1741-4b75-17d1-08dc969b20c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:20:19.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdtY2sIOqAI3zaq/wIQnpTlPZh5LKx8uiJtPwJ0HGR9SkTBJ/FOodkLfi2n20MA0qPCY+B+d1MucotE8jEkWEj+FYf+oQ8ApTS1K8TE8QiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile         |   4 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 +++++++++++++++++++++
 drivers/mtd/nand/spi/ato.c            |  84 ++++++++++++
 drivers/mtd/nand/spi/core.c           |   4 +-
 drivers/mtd/nand/spi/esmt.c           |   9 ++
 drivers/mtd/nand/spi/gigadevice.c     | 188 +++++++++++++++++++++++++-
 drivers/mtd/nand/spi/macronix.c       |  20 +++
 drivers/mtd/nand/spi/toshiba.c        |  33 +++++
 include/linux/mtd/spinand.h           |   4 +-
 9 files changed, 496 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 65b836b34ca..6c733c0cc65 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
-spinand-objs += toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o gigadevice.o macronix.o
+spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
new file mode 100644
index 00000000000..e29e4cc77ec
--- /dev/null
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Mario Kicherer <dev@kicherer.org>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ALLIANCEMEMORY	0x52
+
+#define AM_STATUS_ECC_BITMASK		(3 << 4)
+
+#define AM_STATUS_ECC_NONE_DETECTED	(0 << 4)
+#define AM_STATUS_ECC_CORRECTED		(1 << 4)
+#define AM_STATUS_ECC_ERRORED		(2 << 4)
+#define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int am_get_eccsize(struct mtd_info *mtd)
+{
+	if (mtd->oobsize == 64)
+		return 0x20;
+	else if (mtd->oobsize == 128)
+		return 0x38;
+	else if (mtd->oobsize == 256)
+		return 0x70;
+	else
+		return -EINVAL;
+}
+
+static int am_ooblayout_ecc(struct mtd_info *mtd, int section,
+			    struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	region->offset = mtd->oobsize - ecc_bytes;
+	region->length = ecc_bytes;
+
+	return 0;
+}
+
+static int am_ooblayout_free(struct mtd_info *mtd, int section,
+			     struct mtd_oob_region *region)
+{
+	int ecc_bytes;
+
+	if (section)
+		return -ERANGE;
+
+	ecc_bytes = am_get_eccsize(mtd);
+	if (ecc_bytes < 0)
+		return ecc_bytes;
+
+	/*
+	 * It is unclear how many bytes are used for the bad block marker. We
+	 * reserve the common two bytes here.
+	 *
+	 * The free area in this kind of flash is divided into chunks where the
+	 * first 4 bytes of each chunk are unprotected. The number of chunks
+	 * depends on the specific model. The models with 4096+256 bytes pages
+	 * have 8 chunks, the others 4 chunks.
+	 */
+
+	region->offset = 2;
+	region->length = mtd->oobsize - 2 - ecc_bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops am_ooblayout = {
+	.ecc = am_ooblayout_ecc,
+	.rfree = am_ooblayout_free,
+};
+
+static int am_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & AM_STATUS_ECC_BITMASK) {
+	case AM_STATUS_ECC_NONE_DETECTED:
+		return 0;
+
+	case AM_STATUS_ECC_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors and return maximum - 1 by convention
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 3;
+		else
+			return 7;
+
+	case AM_STATUS_ECC_ERRORED:
+		return -EBADMSG;
+
+	case AM_STATUS_ECC_MAX_CORRECTED:
+		/*
+		 * use oobsize to determine the flash model and the maximum of
+		 * correctable errors
+		 */
+		if (spinand->base.mtd->oobsize == 64)
+			return 4;
+		else
+			return 8;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info alliancememory_spinand_table[] = {
+	SPINAND_INFO("AS5F34G04SND",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2f),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&am_ooblayout,
+				     am_ecc_get_status)),
+};
+
+static const struct spinand_manufacturer_ops alliancememory_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer alliancememory_spinand_manufacturer = {
+	.id = SPINAND_MFR_ALLIANCEMEMORY,
+	.name = "AllianceMemory",
+	.chips = alliancememory_spinand_table,
+	.nchips = ARRAY_SIZE(alliancememory_spinand_table),
+	.ops = &alliancememory_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
new file mode 100644
index 00000000000..f0d4436cf45
--- /dev/null
+++ b/drivers/mtd/nand/spi/ato.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Aidan MacDonald
+ *
+ * Author: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_ATO		0x9b
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 8;
+	region->length = 8;
+	return 0;
+}
+
+static int ato25d1ga_ooblayout_free(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	if (section) {
+		region->offset = (16 * section);
+		region->length = 8;
+	} else {
+		/* first byte of section 0 is reserved for the BBM */
+		region->offset = 1;
+		region->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
+	.ecc = ato25d1ga_ooblayout_ecc,
+	.rfree = ato25d1ga_ooblayout_free,
+};
+
+static const struct spinand_info ato_spinand_table[] = {
+	SPINAND_INFO("ATO25D1GA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&ato25d1ga_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops ato_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer ato_spinand_manufacturer = {
+	.id = SPINAND_MFR_ATO,
+	.name = "ATO",
+	.chips = ato_spinand_table,
+	.nchips = ARRAY_SIZE(ato_spinand_table),
+	.ops = &ato_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c60c3dfad68..9d0d49e32f6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -987,13 +987,15 @@ static const struct nand_ops spinand_ops = {
 };
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
+	&alliancememory_spinand_manufacturer,
+	&ato_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
-	&esmt_c8_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
 };
 
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 7e07b26827a..8aec927c7ea 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -123,6 +123,15 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D2G41KA",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
 };
 
 static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index f2ecf47f8d4..fe8c76acac6 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -43,6 +43,22 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
@@ -329,6 +345,36 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xd2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 	SPINAND_INFO("GD5F1GQ4UFxxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE, 0xb1, 0x48),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -343,12 +389,152 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x51),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x41),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x42),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x55),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x45),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x91),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x82),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x95),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x85),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5xExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxH",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xc9),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 064a9d6b2fe..3475208c923 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -301,6 +301,26 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
 
+	SPINAND_INFO("MX31LF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX3UF2GE4BC",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index d264cdf32ce..bf7da57de13 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -269,6 +269,39 @@ static const struct spinand_info toshiba_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
 				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 1Gb (1st generation) */
+	SPINAND_INFO("TC58NYG0S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 4Gb (1st generation) */
+	SPINAND_INFO("TH58NYG2S3HBAI4",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 2, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
+	/* 1.8V 8Gb (1st generation) */
+	SPINAND_INFO("TH58NYG3S0HBAI6",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
+		     NAND_MEMORG(1, 4096, 256, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_x4_variants,
+					      &update_cache_x4_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
+				     tx58cxgxsxraix_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index cb32bd44a9a..ef15e184f2e 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -266,13 +266,15 @@ struct spinand_manufacturer {
 };
 
 /* SPI NAND manufacturers */
+extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
+extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
-extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
 
 /**
-- 
2.43.0

