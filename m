Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BDAC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98741838F3;
	Tue, 22 Jul 2025 13:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NzGKYFyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCABD838F0; Tue, 22 Jul 2025 13:42:24 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6FB838E0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajTgYEWL2QgSCCe00pEBmF3d3VQjwJKvsnDWTvzOc1KLrJ6a26aonfpx0rJrpXevaOTBRrU8PQNg7B9acAB4tkQKiKs2DmbafmCHWCHWtHC68cAPp6aG0kosGd31yh9A+GSbXfiQRPn5ik6a+2KDYfzN27n/r3U5s/TIc1szzPUHliA26s7WV+vpgpJvm9kYnLokS8jDp0ED7hMsHy/LEnx1p01yphn5pg4elDNH/H30pipIaRIm5ToTpPP7nGZrYMFS29q74UK6Ylnvz5g9eSbNapuakmU/4xOfuzqZQONFvlOD2EHKkF/sXdF+JSigW1BkRmiM73vCcLijfqgdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V1EDNF9K7akR9wjtHcTjErWDnj7ZkRI1aopMCxgGmA=;
 b=quJIPPo9X1Ey+NJygMP3uO6Y3CYjjDdZ9dNHdm2TzSJVvv4Gc4bD+s5cySl21V4eZViJ8iq3oG9NUCDTi4r+CxAJBenIjetHGsRkNVx/9oveILdldSNxg2k48R5wR5wRFaRYoDN91U4KvqegISYOrjcCw2k1Q85uoA0HvvyBuLFw4fPJ0oUx9qKdVgDpYq0JXMQKGHtIfN2C6lx1+qyoQEGtwJDBz/usENdCLe3nFOVzBCYmWDzhwXwLt6i1UNUVumwktTkJJqPIqIwwE5kcPHfgWATZhwGW0hqhGChmlwP+Yp5qTWWYz4JqeJbgBHOEEtbKjgH1MYiKH6YYfXUVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V1EDNF9K7akR9wjtHcTjErWDnj7ZkRI1aopMCxgGmA=;
 b=NzGKYFyfS6jl2syKbm8+qPns+vqjctHILpqH3j+32FtdxVoav4/2EF7HciQy5V8hgh56p5SqgMP7rIj2aoPS5aWtFMUNYB+V8mAeTMqm2AKoxwej5zYVgvsZN6llqemN1ydNxczqjeBi7yc4wvO6wjOQLLdGtY3uWlq+FCsqkt1Azp5Q0iMDwlA8hYrsGgWcVrUiaHQL4u3JewPY4gkByCKK6FXsfhUZV8P6bhg54H8BECOdVC/0MH6gobJS5Y2KtNIao8wteQ+bUJZawsdrbXwg4fwUZOasZVVmlxvGEejEFU5eu1EYrJrhOtz6Z6arZDuwlswQzs3p+RMNg7vCTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 19/19] mtd: spinand: sync with linux-6.16-rc6
Date: Tue, 22 Jul 2025 14:41:35 +0300
Message-ID: <20250722114135.768998-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: 983f6dba-a06c-4ce9-8ee9-08ddc914ceef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6Dp6ElP+fubakpn91sdzgrvp+DzXIGV0LcAsF93BGyOEm3v9NN4AprAsFp4?=
 =?us-ascii?Q?XUaaJ2DRFVjvOofabKS1pHnbbQslyniVB0OqbzsnYZFMZb9KywUU755Bm7iZ?=
 =?us-ascii?Q?aLnEs+rEjRWolpvDxipo1CESIG/rToItwnojjRG832PCYyQ7yslHQJIiJYf5?=
 =?us-ascii?Q?6mZ7zUwsad45jshRt4aedAPXoC+N5yFGZ6OQzXkxChu4NrpomsWW5P2zpqcG?=
 =?us-ascii?Q?pVdBgQdgnHoUxDPYohY3D7CSrRPjBqHpRPq+VVAmcJ7HWdHm008nbeKiy1mA?=
 =?us-ascii?Q?F+RAYDfWEF+66n4xu5xHXmzdh8u2vvq0U3U6l8V4hhAg62P3RwmCk3jGRmFw?=
 =?us-ascii?Q?Ox6UcVSC1T00eTelnQHs5EKwfw1YQoX2voOTvEdOTjjJ4fV2b00WQ7TrAF/P?=
 =?us-ascii?Q?lfiAzA0Ham1H9LTapjujYxPOAb4lfOHzsl8Atl8KRNQxjGEFneepSY/2zNfs?=
 =?us-ascii?Q?qXcP0o+Y+FLcEYh/0YNod7HgwnOIqdmvMlPoXjRgFUzXXlAyTYj4kB3RodXv?=
 =?us-ascii?Q?WySsmFrUYCLeroYcDSEERpOIHqC4lt0wBle4+EtG5ZzZg4uNXM1GPj8GehF+?=
 =?us-ascii?Q?aLWOvfoAZepWVPtB7ACeGDjgbOYSEQoX7G46o/Gj+3hgFVCPDN+9hzikrHpB?=
 =?us-ascii?Q?hXWiYP8h+XS3hB8h5/fZmKDQk8bf4kFCGzF/qOfZof1NNbE4HjzmJmq+D0Ws?=
 =?us-ascii?Q?ZBbGIRerfoLV2ngwEEoLdTQaMZLeTp1U9ZKxofRiVwkxG7jnYBiCK7oKU/t3?=
 =?us-ascii?Q?PB95zi2ynJeSs/eF9Z3ZH1A6kVXq/MqQ4XkZEYbquMmhSL9aa9WI+v3+OGqI?=
 =?us-ascii?Q?kKWoKqmEmnahR2jap1hGDo/yy17DAaWtOEEaiJPZjtxXeWBIg9ZpuEEHnaGh?=
 =?us-ascii?Q?Hj7YjBVnN6vivFEGMfLTDudaYnXob3a/P5XoiSeAy0SH/zqtF7IvdvNT8cWW?=
 =?us-ascii?Q?LDtqsYj0Fq1EOBnY7PHCcTeAvmC6cQPSCWC4hde3adiI0KBwgnHLWM6ycD/6?=
 =?us-ascii?Q?sAyAsJDuBF0sh7L5HIhbI1fdHRJeIku+pZRnlqFvxUp26ZNohnGSCKC8EmR0?=
 =?us-ascii?Q?8wd2UZuCAwJrhRsLMkdCSbVtut8nE+qxQieNPp0us0DNzmGzDWbqTv8UY28/?=
 =?us-ascii?Q?osKaa24Wf9yilNxnFLBBRSyntEntCyHiQ6Yu/NWdc26NjAcqqZwg/SBAtjxj?=
 =?us-ascii?Q?VGouzzhqWFWtVsgq8zhMU55aW9eyd9PB7+4PMbttYI13UMjRMO8ZnZ+1BwRN?=
 =?us-ascii?Q?NJJafMC0jZfHurVQ9dPMv6CsgdKlRKrOsfFht6OhVyvpoeEfP2WtFYSWflN/?=
 =?us-ascii?Q?25/UyjoIKDSFdwMXrWmBiRKkzzaFc985XLoViMnCTyIQ5R9vxtpyOQkpT6Up?=
 =?us-ascii?Q?DbY9lij+gAhERQbc+eOC408G28rzp46t5834Fp6fq70V+pV4x93WpOJU7Y5U?=
 =?us-ascii?Q?a5cY1NKyTaHiuVpw86nKHBIMEIunPIiSTGLy4I4oHn1rW2oKI2EzWnQF3FzI?=
 =?us-ascii?Q?+7xHsMESSzlA0Qs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J3CLN+5yrcPS65VBHtR0lqIM05g+9SRs5x3aQHEgEclbO9s3d05z92DRpS8t?=
 =?us-ascii?Q?c7CV8YbQnrS6Mqz/q0RY8YcXtbLQVkfL84aFrDxEbM/PgIlw4vUoXaH6GMqU?=
 =?us-ascii?Q?MTUEnLdLO6/ccOQ1vyIJ3Eux4SiBgBhdDVAdkTpmbIR0tKuaUuij1VdIfbKb?=
 =?us-ascii?Q?3L+RWnKebyfS9GTIZtwTGhXc1FJRtYRcVnr6t1p5+9ydqxccrqe/KVDNcjrh?=
 =?us-ascii?Q?wwq6XpJz1sfO/xey7TgYX2fZye+izPxoyrUerGrPDnIUWU9uom8UflUyC8sE?=
 =?us-ascii?Q?4q6HJDN7+Uj9yLbaosg5uABAgIH4SDeG4p5tj6HqrWuE+uWK9m6ePAEmhS3u?=
 =?us-ascii?Q?nrD6jtE4Iltp9sXunKEwMY0+RKugbCTpKAzJ4ODyZxCHxxF91BL/T3aSRaZm?=
 =?us-ascii?Q?k7mFjEaXuzynMpJs70kHQQUMn8o2exPpro60QTHFEIB+nN5ahnMG4CDrj9oI?=
 =?us-ascii?Q?AR2EXMBcTayovCC5xXRPDYJQvvCZ/9s+Zl8sx27WNEyDZF9YeTFGfsejh0AT?=
 =?us-ascii?Q?pGPE/TufC3EoP3gkM1QA84ZkWzwR0QRBWVxnqNUpwXjm2l5dANnqw28tCvD8?=
 =?us-ascii?Q?JupLbYRuyXKxzJCh/hbuWGBWL6lkMv1AxsBGwvfMzGKxVUkrslhLxXfT19Xa?=
 =?us-ascii?Q?XZm9trkB8OOYvVrE3TCn0gcx8/G6NDpuEL/EbLPTpckTPx1OPf1Pcp8vaYwH?=
 =?us-ascii?Q?Y1TYRdXmKMhV10P3netTk3K3NvjhVSM4XPYyvNmP0NbRWIahe2/nCR5IrFdp?=
 =?us-ascii?Q?tWJTG4QaqUER58XPaQ7OZ24DlMio0TjxaEhRm52MBpx6E3ZnA278/kbksuwD?=
 =?us-ascii?Q?4ONpCVTbJFDwBL8ngVqHyUvXy0jqOh/nWlWYWyQ06XxXIOad/473IewaaKkf?=
 =?us-ascii?Q?0pN7iEGwZLBCBTGL97GOq4G3VYTtOkdxvV53CgElt49RGzjnIboMQcSwnIn4?=
 =?us-ascii?Q?jxiLZDt1T0hYbhQHnq967Dd8/Fdfg2CzD6H4BQmAxwe0BsglyJyivAg5Ri0m?=
 =?us-ascii?Q?m0zXJE4C9Oqs5ZzBKy9GOWAyTSaxrcf9KnVmHY83YvPpq4GdsNft7Ubsdypu?=
 =?us-ascii?Q?66kaqHbzCYM5LRFVhQoafyaxjP6u044xofgZAztJO9+httdrUwwgBsPojbjB?=
 =?us-ascii?Q?x7XwyM2PGkIW5E7npziMIxWbnSoROvmln29WZk9TZ8q84Hz6WMsJciLy55Tu?=
 =?us-ascii?Q?PT6k2u8XsIRHY2lEv0eliwsDWDEfSywDL4wUKmY9rlGCXnGREd641fuKgZIs?=
 =?us-ascii?Q?9GrelF1zKninqlTA7bMP7WeZJ0q9msHMAIeCKuH4iE2JnUFZCoa5yaUwXBHb?=
 =?us-ascii?Q?+7vZehi+/USITXTMX/FCqSbaSmfjMtGcYMS5mNbRpxBC2UXGj/WpTVJNdMY/?=
 =?us-ascii?Q?+2KyisVyLm9zDe8MQq4XN/A1ZBsYudcq1t6cHqxka1DzZov9cOSnvSZ/A0r1?=
 =?us-ascii?Q?gGghu9GVJfeh6OGjaNzVmc8LkjQ4WPoHgDBdN3KQYnnd234/LpTWwDC//DR2?=
 =?us-ascii?Q?9BKD5i9Yfcd7I14rQtGQ0sREKWbfd07K2fu9UPJ+HHeNxbMmEu4wDyVBQYk5?=
 =?us-ascii?Q?C/lO7NQdvfHHYbUUnp6g2OfXDHLY54FF2tmQAj6zyqc5zMdaDbjmfwNYbBzM?=
 =?us-ascii?Q?0RNi4Uj3uOcTdfOZckUyDaY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 983f6dba-a06c-4ce9-8ee9-08ddc914ceef
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:16.8334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTU1GiXYWlV8BdxHCWkMs4fIYGkPzM64PRRNU9kfevUXSV2jHzO8iMwMGAdNw/iE8oRpXzolEdkaWrGRkPrnTHl3W5WSpWH7xtTd/3W+CYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

This makes u-boot spinand driver almost the same as spinand driver
from linux-6.16-rc6. The only major difference is support of ECC
engines. The linux driver supports different ECC engines while
u-boot driver uses on-die ecc only.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/Makefile         |   2 +-
 drivers/mtd/nand/spi/alliancememory.c |  20 +-
 drivers/mtd/nand/spi/ato.c            |  14 +-
 drivers/mtd/nand/spi/core.c           |  17 +-
 drivers/mtd/nand/spi/esmt.c           | 111 +++++++++--
 drivers/mtd/nand/spi/foresee.c        |  26 ++-
 drivers/mtd/nand/spi/gigadevice.c     |  60 +++---
 drivers/mtd/nand/spi/macronix.c       | 269 ++++++++++++++++++++------
 drivers/mtd/nand/spi/micron.c         | 178 +++++++++++++++--
 drivers/mtd/nand/spi/paragon.c        |  20 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++++++++++++
 drivers/mtd/nand/spi/toshiba.c        |  22 +--
 drivers/mtd/nand/spi/winbond.c        | 221 +++++++++++++++++----
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 include/linux/mtd/nand.h              |  30 ++-
 include/linux/mtd/spinand.h           | 152 +++++++++++----
 16 files changed, 1054 insertions(+), 257 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 831760da1c9..152aa1a3783 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -2,5 +2,5 @@
 
 spinand-objs := core.o otp.o
 spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
-spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
index e29e4cc77ec..a5d8eb44c5a 100644
--- a/drivers/mtd/nand/spi/alliancememory.c
+++ b/drivers/mtd/nand/spi/alliancememory.c
@@ -19,20 +19,20 @@
 #define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int am_get_eccsize(struct mtd_info *mtd)
 {
diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
index f0d4436cf45..4aea8df0759 100644
--- a/drivers/mtd/nand/spi/ato.c
+++ b/drivers/mtd/nand/spi/ato.c
@@ -14,17 +14,17 @@
 #define SPINAND_MFR_ATO		0x9b
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
 				   struct mtd_oob_region *region)
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..a76878abab1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -44,7 +44,7 @@ static int spi_nand_idx;
 
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
+	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(reg,
 						      spinand->scratchbuf);
 	int ret;
 
@@ -58,7 +58,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 
 int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
+	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(reg,
 						      spinand->scratchbuf);
 
 	*spinand->scratchbuf = val;
@@ -359,7 +359,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
-	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
+	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -369,7 +369,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
-	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
+	struct spi_mem_op op = SPINAND_PAGE_READ_1S_1S_0_OP(row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -516,7 +516,7 @@ static int spinand_program_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
-	struct spi_mem_op op = SPINAND_PROG_EXEC_OP(row);
+	struct spi_mem_op op = SPINAND_PROG_EXEC_1S_1S_0_OP(row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -526,7 +526,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	unsigned int row = nanddev_pos_to_row(nand, pos);
-	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
+	struct spi_mem_op op = SPINAND_BLK_ERASE_1S_1S_0_OP(row);
 
 	return spi_mem_exec_op(spinand->slave, &op);
 }
@@ -586,7 +586,7 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(
+	struct spi_mem_op op = SPINAND_READID_1S_1S_1S_OP(
 		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
@@ -599,7 +599,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 
 static int spinand_reset_op(struct spinand_device *spinand)
 {
-	struct spi_mem_op op = SPINAND_RESET_OP;
+	struct spi_mem_op op = SPINAND_RESET_1S_0_0_OP;
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -1185,6 +1185,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
+	&skyhigh_spinand_manufacturer,
 	&toshiba_spinand_manufacturer,
 	&winbond_spinand_manufacturer,
 	&xtx_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
index 23be098b885..08613eed250 100644
--- a/drivers/mtd/nand/spi/esmt.c
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -8,25 +8,33 @@
 #ifndef __UBOOT__
 #include <linux/device.h>
 #include <linux/kernel.h>
+#else
+#include <dm/device_compat.h>
+#include <spi-mem.h>
+#include <spi.h>
 #endif
 #include <linux/mtd/spinand.h>
 
 /* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
 #define SPINAND_MFR_ESMT_C8			0xc8
 
+#define ESMT_F50L1G41LB_CFG_OTP_PROTECT		BIT(7)
+#define ESMT_F50L1G41LB_CFG_OTP_LOCK		\
+	(CFG_OTP_ENABLE | ESMT_F50L1G41LB_CFG_OTP_PROTECT)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /*
  * OOB spare area map (64 bytes)
@@ -104,6 +112,83 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
 	.rfree = f50l1g41lb_ooblayout_free,
 };
 
+static int f50l1g41lb_otp_info(struct spinand_device *spinand, size_t len,
+			       struct otp_info *buf, size_t *retlen, bool user)
+{
+	if (len < sizeof(*buf))
+		return -EINVAL;
+
+	buf->locked = 0;
+	buf->start = 0;
+	buf->length = user ? spinand_user_otp_size(spinand) :
+			     spinand_fact_otp_size(spinand);
+
+	*retlen = sizeof(*buf);
+	return 0;
+}
+
+static int f50l1g41lb_fact_otp_info(struct spinand_device *spinand, size_t len,
+				    struct otp_info *buf, size_t *retlen)
+{
+	return f50l1g41lb_otp_info(spinand, len, buf, retlen, false);
+}
+
+static int f50l1g41lb_user_otp_info(struct spinand_device *spinand, size_t len,
+				    struct otp_info *buf, size_t *retlen)
+{
+	return f50l1g41lb_otp_info(spinand, len, buf, retlen, true);
+}
+
+static int f50l1g41lb_otp_lock(struct spinand_device *spinand, loff_t from,
+			       size_t len)
+{
+	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	u8 status;
+	int ret;
+
+	ret = spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK,
+			      ESMT_F50L1G41LB_CFG_OTP_LOCK);
+	if (!ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->slave, &write_op);
+	if (!ret)
+		goto out;
+
+	ret = spi_mem_exec_op(spinand->slave, &exec_op);
+	if (!ret)
+		goto out;
+
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
+	if (!ret && (status & STATUS_PROG_FAILED))
+		ret = -EIO;
+
+out:
+	if (spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static const struct spinand_user_otp_ops f50l1g41lb_user_otp_ops = {
+	.info = f50l1g41lb_user_otp_info,
+	.lock = f50l1g41lb_otp_lock,
+	.read = spinand_user_otp_read,
+	.write = spinand_user_otp_write,
+};
+
+static const struct spinand_fact_otp_ops f50l1g41lb_fact_otp_ops = {
+	.info = f50l1g41lb_fact_otp_info,
+	.read = spinand_fact_otp_read,
+};
+
 static const struct spinand_info esmt_c8_spinand_table[] = {
 	SPINAND_INFO("F50L1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
@@ -114,17 +199,21 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
+		     SPINAND_USER_OTP_INFO(28, 2, &f50l1g41lb_user_otp_ops),
+		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
 	SPINAND_INFO("F50D1G41LB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
-				0x7f, 0x7f),
+				0x7f),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
+		     SPINAND_USER_OTP_INFO(28, 2, &f50l1g41lb_user_otp_ops),
+		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
 	SPINAND_INFO("F50D2G41KA",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
 				0x7f, 0x7f),
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 6229c959b2c..7adb87b55db 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -14,18 +14,18 @@
 #define SPINAND_MFR_FORESEE		0xCD
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
 				    struct mtd_oob_region *region)
@@ -83,6 +83,16 @@ static const struct spinand_info foresee_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
 				     f35sqa002g_ecc_get_status)),
+	SPINAND_INFO("F35SQA001G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x71, 0x71),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
+				     f35sqa002g_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index f3608a13d8e..202718ae81f 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -28,44 +28,44 @@
 #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_f,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int gd5fxgq4xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
@@ -189,7 +189,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
 					u8 status)
 {
 	u8 status2;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
+	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
 						      spinand->scratchbuf);
 	int ret;
 
@@ -232,7 +232,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
 					u8 status)
 {
 	u8 status2;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
+	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
 						      spinand->scratchbuf);
 	int ret;
 
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index c2a7aa2da96..23737e2cc21 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -5,6 +5,7 @@
  * Author: Boris Brezillon <boris.brezillon@bootlin.com>
  */
 
+#include <linux/bitfield.h>
 #ifndef __UBOOT__
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -13,21 +14,35 @@
 #include <linux/mtd/spinand.h>
 
 #define SPINAND_MFR_MACRONIX		0xC2
-#define MACRONIX_ECCSR_MASK		0x0F
+#define MACRONIX_ECCSR_BF_LAST_PAGE(eccsr) FIELD_GET(GENMASK(3, 0), eccsr)
+#define MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(eccsr) FIELD_GET(GENMASK(7, 4), eccsr)
+#define MACRONIX_CFG_CONT_READ         BIT(2)
+#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
+#define MACRONIX_NUM_READ_RETRY_MODES 5
+
+#define STATUS_ECC_HAS_BITFLIPS_THRESHOLD (3 << 4)
+
+/* Bitflip theshold configuration register */
+#define REG_CFG_BFT 0x10
+#define CFG_BFT(x) FIELD_PREP(GENMASK(7, 4), (x))
+
+struct macronix_priv {
+	bool cont_read;
+};
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
 				      struct mtd_oob_region *region)
@@ -52,8 +67,9 @@ static const struct mtd_ooblayout_ops mx35lfxge4ab_ooblayout = {
 	.rfree = mx35lfxge4ab_ooblayout_free,
 };
 
-static int mx35lf1ge4ab_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
+static int macronix_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
 {
+	struct macronix_priv *priv = spinand->priv;
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
 					  SPI_MEM_OP_NO_ADDR,
 					  SPI_MEM_OP_DUMMY(1, 1),
@@ -63,12 +79,21 @@ static int mx35lf1ge4ab_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
 	if (ret)
 		return ret;
 
-	*eccsr &= MACRONIX_ECCSR_MASK;
+	/*
+	 * ECCSR exposes the number of bitflips for the last read page in bits [3:0].
+	 * Continuous read compatible chips also expose the maximum number of
+	 * bitflips for the whole (continuous) read operation in bits [7:4].
+	 */
+	if (!priv->cont_read)
+		*eccsr = MACRONIX_ECCSR_BF_LAST_PAGE(*eccsr);
+	else
+		*eccsr = MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(*eccsr);
+
 	return 0;
 }
 
-static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
-				       u8 status)
+static int macronix_ecc_get_status(struct spinand_device *spinand,
+				   u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 eccsr;
@@ -86,16 +111,14 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * in order to avoid forcing the wear-leveling layer to move
 		 * data around if it's not necessary.
 		 */
-		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
+		if (macronix_get_eccsr(spinand, spinand->scratchbuf))
 			return nanddev_get_ecc_conf(nand)->strength;
 
 		eccsr = *spinand->scratchbuf;
-		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
-			    !eccsr))
+		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength || !eccsr))
 			return nanddev_get_ecc_conf(nand)->strength;
 
 		return eccsr;
-
 	default:
 		break;
 	}
@@ -103,6 +126,38 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int macronix_set_cont_read(struct spinand_device *spinand, bool enable)
+{
+	struct macronix_priv *priv = spinand->priv;
+	int ret;
+
+	ret = spinand_upd_cfg(spinand, MACRONIX_CFG_CONT_READ,
+			      enable ? MACRONIX_CFG_CONT_READ : 0);
+	if (ret)
+		return ret;
+
+	priv->cont_read = enable;
+
+	return 0;
+}
+
+/**
+ * macronix_set_read_retry - Set the retry mode
+ * @spinand: SPI NAND device
+ * @retry_mode: Specify which retry mode to set
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int macronix_set_read_retry(struct spinand_device *spinand,
+					     unsigned int retry_mode)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MACRONIX_FEATURE_ADDR_READ_RETRY,
+							       spinand->scratchbuf);
+
+	*spinand->scratchbuf = retry_mode;
+	return spi_mem_exec_op(spinand->slave, &op);
+}
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -113,7 +168,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35LF2GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
@@ -121,10 +176,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF2GE4AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26, 0x03),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -132,9 +189,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF4GE4AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37, 0x03),
 		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -142,34 +202,67 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF1G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF2G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
+	SPINAND_INFO("MX35LF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF4G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
+	SPINAND_INFO("MX35LF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -179,7 +272,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX31UF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -189,7 +282,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 
 	SPINAND_INFO("MX35LF2G14AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x20),
@@ -198,21 +291,38 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF4G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
+	SPINAND_INFO("MX35UF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF4GE4AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -220,7 +330,10 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2G14AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
@@ -228,21 +341,38 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
+		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF2G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
 		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT |
+		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
+	SPINAND_INFO("MX35UF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2GE4AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -250,9 +380,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2GE4AC",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -260,7 +393,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read)),
 	SPINAND_INFO("MX35UF1G14AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x90),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -270,9 +404,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX35UF1G24AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -280,9 +414,11 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF1GE4AD",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -290,9 +426,12 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF1GE4AC",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
@@ -300,8 +439,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
-
+				     macronix_ecc_get_status),
+		     SPINAND_CONT_READ(macronix_set_cont_read)),
 	SPINAND_INFO("MX31LF2GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
@@ -311,7 +450,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 	SPINAND_INFO("MX3UF2GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
@@ -321,10 +460,30 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     macronix_ecc_get_status)),
 };
 
+static int macronix_spinand_init(struct spinand_device *spinand)
+{
+	struct macronix_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spinand->priv = priv;
+
+	return 0;
+}
+
+static void macronix_spinand_cleanup(struct spinand_device *spinand)
+{
+	kfree(spinand->priv);
+}
+
 static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
+	.init = macronix_spinand_init,
+	.cleanup = macronix_spinand_cleanup,
 };
 
 const struct spinand_manufacturer macronix_spinand_manufacturer = {
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index 01c177facfb..cd705f08b7c 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -9,8 +9,14 @@
 #ifndef __UBOOT__
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/spi/spi-mem.h>
+#else
+#include <dm/device_compat.h>
+#include <spi-mem.h>
+#include <spi.h>
 #endif
 #include <linux/mtd/spinand.h>
+#include <linux/string.h>
 
 #define SPINAND_MFR_MICRON		0x2c
 
@@ -30,34 +36,38 @@
 
 #define MICRON_SELECT_DIE(x)	((x) << 6)
 
+#define MICRON_MT29F2G01ABAGD_CFG_OTP_STATE		BIT(7)
+#define MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK		\
+	(CFG_OTP_ENABLE | MICRON_MT29F2G01ABAGD_CFG_OTP_STATE)
+
 static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x4_update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /* Micron  MT29F2G01AAAED Device */
 static SPINAND_OP_VARIANTS(x4_read_cache_variants,
-			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x1_write_cache_variants,
-			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(x1_update_cache_variants,
-			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
@@ -133,7 +143,7 @@ static const struct mtd_ooblayout_ops micron_4_ooblayout = {
 static int micron_select_target(struct spinand_device *spinand,
 				unsigned int target)
 {
-	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MICRON_DIE_SELECT_REG,
+	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MICRON_DIE_SELECT_REG,
 						      spinand->scratchbuf);
 
 	if (target > 1)
@@ -170,6 +180,136 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static inline bool mem_is_zero(const void *s, size_t n)
+{
+	return !memchr_inv(s, 0, n);
+}
+
+static int mt29f2g01abagd_otp_is_locked(struct spinand_device *spinand)
+{
+	size_t bufsize = spinand_otp_page_size(spinand);
+	size_t retlen;
+	u8 *buf;
+	int ret;
+
+	buf = kmalloc(bufsize, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = spinand_upd_cfg(spinand,
+			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
+			      MICRON_MT29F2G01ABAGD_CFG_OTP_STATE);
+	if (ret)
+		goto free_buf;
+
+	ret = spinand_user_otp_read(spinand, 0, bufsize, &retlen, buf);
+
+	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
+			    0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	if (ret)
+		goto free_buf;
+
+	/* If all zeros, then the OTP area is locked. */
+	if (mem_is_zero(buf, bufsize))
+		ret = 1;
+
+free_buf:
+	kfree(buf);
+	return ret;
+}
+
+static int mt29f2g01abagd_otp_info(struct spinand_device *spinand, size_t len,
+				   struct otp_info *buf, size_t *retlen,
+				   bool user)
+{
+	int locked;
+
+	if (len < sizeof(*buf))
+		return -EINVAL;
+
+	locked = mt29f2g01abagd_otp_is_locked(spinand);
+	if (locked < 0)
+		return locked;
+
+	buf->locked = locked;
+	buf->start = 0;
+	buf->length = user ? spinand_user_otp_size(spinand) :
+			     spinand_fact_otp_size(spinand);
+
+	*retlen = sizeof(*buf);
+	return 0;
+}
+
+static int mt29f2g01abagd_fact_otp_info(struct spinand_device *spinand,
+					size_t len, struct otp_info *buf,
+					size_t *retlen)
+{
+	return mt29f2g01abagd_otp_info(spinand, len, buf, retlen, false);
+}
+
+static int mt29f2g01abagd_user_otp_info(struct spinand_device *spinand,
+					size_t len, struct otp_info *buf,
+					size_t *retlen)
+{
+	return mt29f2g01abagd_otp_info(spinand, len, buf, retlen, true);
+}
+
+static int mt29f2g01abagd_otp_lock(struct spinand_device *spinand, loff_t from,
+				   size_t len)
+{
+	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
+	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
+	u8 status;
+	int ret;
+
+	ret = spinand_upd_cfg(spinand,
+			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
+			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK);
+	if (!ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->slave, &write_op);
+	if (!ret)
+		goto out;
+
+	ret = spi_mem_exec_op(spinand->slave, &exec_op);
+	if (!ret)
+		goto out;
+
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
+	if (!ret && (status & STATUS_PROG_FAILED))
+		ret = -EIO;
+
+out:
+	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK, 0)) {
+		dev_warn(spinand->slave->dev,
+			 "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static const struct spinand_user_otp_ops mt29f2g01abagd_user_otp_ops = {
+	.info = mt29f2g01abagd_user_otp_info,
+	.lock = mt29f2g01abagd_otp_lock,
+	.read = spinand_user_otp_read,
+	.write = spinand_user_otp_write,
+};
+
+static const struct spinand_fact_otp_ops mt29f2g01abagd_fact_otp_ops = {
+	.info = mt29f2g01abagd_fact_otp_info,
+	.read = spinand_fact_otp_read,
+};
+
 static const struct spinand_info micron_spinand_table[] = {
 	/* M79A 2Gb 3.3V */
 	SPINAND_INFO("MT29F2G01ABAGD",
@@ -181,7 +321,9 @@ static const struct spinand_info micron_spinand_table[] = {
 					      &x4_update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&micron_8_ooblayout,
-				     micron_8_ecc_get_status)),
+				     micron_8_ecc_get_status),
+		     SPINAND_USER_OTP_INFO(12, 2, &mt29f2g01abagd_user_otp_ops),
+		     SPINAND_FACT_OTP_INFO(2, 0, &mt29f2g01abagd_fact_otp_ops)),
 	/* M79A 2Gb 1.8V */
 	SPINAND_INFO("MT29F2G01ABBGD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
index 079431cea8f..5f915318563 100644
--- a/drivers/mtd/nand/spi/paragon.c
+++ b/drivers/mtd/nand/spi/paragon.c
@@ -21,20 +21,20 @@
 #define PN26G0XA_STATUS_ECC_8_CORRECTED		(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int pn26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				   struct mtd_oob_region *region)
diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
new file mode 100644
index 00000000000..d17f0e5cfed
--- /dev/null
+++ b/drivers/mtd/nand/spi/skyhigh.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SkyHigh Memory Limited
+ *
+ * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
+ * Co-Author: KR Kim <kr.kim@skyhighmemory.com>
+ */
+
+#ifndef __UBOOT__
+#include <linux/device.h>
+#include <linux/kernel.h>
+#endif
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_SKYHIGH			0x01
+#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
+#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
+#define SKYHIGH_STATUS_ECC_UNCOR_ERROR		(3 << 4)
+#define SKYHIGH_CONFIG_PROTECT_EN		BIT(1)
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
+					 struct mtd_oob_region *region)
+{
+	/* ECC bytes are stored in hidden area. */
+	return -ERANGE;
+}
+
+static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int section,
+					  struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* ECC bytes are stored in hidden area. Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = mtd->oobsize - 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout = {
+	.ecc = skyhigh_spinand_ooblayout_ecc,
+	.rfree = skyhigh_spinand_ooblayout_free,
+};
+
+static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
+					  u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
+		return 2;
+
+	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
+		return 6;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct spinand_info skyhigh_spinand_table[] = {
+	SPINAND_INFO("S35ML01G301",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_NO_RAW_ACCESS,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+				     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML01G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_NO_RAW_ACCESS,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+				     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML02G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_NO_RAW_ACCESS,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+				     skyhigh_spinand_ecc_get_status)),
+	SPINAND_INFO("S35ML04G300",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
+		     NAND_ECCREQ(6, 32),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_NO_RAW_ACCESS,
+		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
+				     skyhigh_spinand_ecc_get_status)),
+};
+
+static int skyhigh_spinand_init(struct spinand_device *spinand)
+{
+	/*
+	 * Config_Protect_En (bit 1 in Block Lock register) must be set to 1
+	 * before writing other bits. Do it here before core unlocks all blocks
+	 * by writing block protection bits.
+	 */
+	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
+				    SKYHIGH_CONFIG_PROTECT_EN);
+}
+
+static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops = {
+	.init = skyhigh_spinand_init,
+};
+
+const struct spinand_manufacturer skyhigh_spinand_manufacturer = {
+	.id = SPINAND_MFR_SKYHIGH,
+	.name = "SkyHigh",
+	.chips = skyhigh_spinand_table,
+	.nchips = ARRAY_SIZE(skyhigh_spinand_table),
+	.ops = &skyhigh_spinand_manuf_ops,
+};
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index bf7da57de13..1623fc87841 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -18,28 +18,28 @@
 #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_x4_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_x4_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 /*
  * Backward compatibility for 1st generation Serial NAND devices
  * which don't support Quad Program Load operation.
  */
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int tx58cxgxsxraix_ooblayout_ecc(struct mtd_info *mtd, int section,
 					struct mtd_oob_region *region)
@@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index fc3e3855d41..0d4aaaadc21 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -15,27 +15,63 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 
+#define HZ_PER_MHZ			1000000UL
+
 #define SPINAND_MFR_WINBOND		0xEF
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
-#define W25N04KV_STATUS_ECC_5_8_BITFLIPS FIELD_PREP_CONST(STATUS_ECC_MASK, 0x3)
+#define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+
+/*
+ * "X2" in the core is equivalent to "dual output" in the datasheets,
+ * "X4" in the core is equivalent to "quad output" in the datasheets.
+ */
+
+static SPINAND_OP_VARIANTS(read_cache_octal_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 16, NULL, 0, 162 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 1, NULL, 0, 133 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_octal_variants,
+		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_8S_OP(0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_octal_variants,
+		SPINAND_PROG_LOAD_1S_8S_8S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 104 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 104 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
@@ -80,6 +116,18 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
+static int w25n01kv_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	region->offset = 64 + (8 * section);
+	region->length = 7;
+
+	return 0;
+}
+
 static int w25n02kv_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
 {
@@ -104,17 +152,57 @@ static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
 	return 0;
 }
 
+static const struct mtd_ooblayout_ops w25n01kv_ooblayout = {
+	.ecc = w25n01kv_ooblayout_ecc,
+	.rfree = w25n02kv_ooblayout_free,
+};
+
 static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
 	.ecc = w25n02kv_ooblayout_ecc,
 	.rfree = w25n02kv_ooblayout_free,
 };
 
+static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = (16 * section) + 12;
+	region->length = 4;
+
+	return 0;
+}
+
+static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *region)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	region->offset = 16 * section;
+	region->length = 12;
+
+	/* Extract BBM */
+	if (!section) {
+		region->offset += 2;
+		region->length -= 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
+	.ecc = w35n01jw_ooblayout_ecc,
+	.rfree = w35n01jw_ooblayout_free,
+};
+
 static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 				   u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -148,17 +236,18 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 }
 
 static const struct spinand_info winbond_spinand_table[] = {
-	SPINAND_INFO("W25M02GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
-		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
+	/* 512M-bit densities */
+	SPINAND_INFO("W25N512GW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
+		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
-		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
-	SPINAND_INFO("W25N01GV",
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	/* 1G-bit densities */
+	SPINAND_INFO("W25N01GV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
@@ -167,43 +256,90 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
-	SPINAND_INFO("W25N02KV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
-		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-		     NAND_ECCREQ(8, 512),
+	SPINAND_INFO("W25N01GW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N01JW",
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N01JW", /* high-speed 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N01KV", /* 3.3V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
+		     NAND_MEMORG(1, 2048, 96, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N02JWZEIF",
+		     SPINAND_ECCINFO(&w25n01kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N01JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+	SPINAND_INFO("W35N02JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+	SPINAND_INFO("W35N04JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL)),
+	/* 2G-bit densities */
+	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
+		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
+	SPINAND_INFO("W25N02JW", /* high-speed 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
-		     NAND_ECCREQ(4, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N512GW",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
-		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
-		     NAND_ECCREQ(4, 512),
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N02KV", /* 3.3V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N02KWZEIR",
+	SPINAND_INFO("W25N02KW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
@@ -212,18 +348,19 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N01GWZEIG",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
-		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-		     NAND_ECCREQ(4, 512),
+	/* 4G-bit densities */
+	SPINAND_INFO("W25N04KV", /* 3.3V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
-	SPINAND_INFO("W25N04KV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
-		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
index aee1849a71f..5de4728251e 100644
--- a/drivers/mtd/nand/spi/xtx.c
+++ b/drivers/mtd/nand/spi/xtx.c
@@ -25,20 +25,20 @@
 #define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
 
 static SPINAND_OP_VARIANTS(read_cache_variants,
-		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
-		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0));
 
 static SPINAND_OP_VARIANTS(write_cache_variants,
-		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
-		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
 
 static SPINAND_OP_VARIANTS(update_cache_variants,
-		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
-		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
+		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
 
 static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
 				  struct mtd_oob_region *region)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 9285edd5c4b..243955ac1a1 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -19,7 +19,7 @@
  * @oobsize: OOB area size
  * @pages_per_eraseblock: number of pages per eraseblock
  * @eraseblocks_per_lun: number of eraseblocks per LUN (Logical Unit Number)
- * @max_bad_eraseblocks_per_lun: maximum number of eraseblocks per LUN
+ * @max_bad_eraseblocks_per_lun: maximum number of bad eraseblocks per LUN
  * @planes_per_lun: number of planes per LUN
  * @luns_per_target: number of LUN per target (target is a synonym for die)
  * @ntargets: total number of targets exposed by the NAND device
@@ -286,6 +286,20 @@ nanddev_pages_per_eraseblock(const struct nand_device *nand)
 	return nand->memorg.pages_per_eraseblock;
 }
 
+/**
+ * nanddev_pages_per_target() - Get the number of pages per target
+ * @nand: NAND device
+ *
+ * Return: the number of pages per target.
+ */
+static inline unsigned int
+nanddev_pages_per_target(const struct nand_device *nand)
+{
+	return nand->memorg.pages_per_eraseblock *
+	       nand->memorg.eraseblocks_per_lun *
+	       nand->memorg.luns_per_target;
+}
+
 /**
  * nanddev_per_page_oobsize() - Get NAND erase block size
  * @nand: NAND device
@@ -309,6 +323,18 @@ nanddev_eraseblocks_per_lun(const struct nand_device *nand)
 	return nand->memorg.eraseblocks_per_lun;
 }
 
+/**
+ * nanddev_eraseblocks_per_target() - Get the number of eraseblocks per target
+ * @nand: NAND device
+ *
+ * Return: the number of eraseblocks per target.
+ */
+static inline unsigned int
+nanddev_eraseblocks_per_target(const struct nand_device *nand)
+{
+	return nand->memorg.eraseblocks_per_lun * nand->memorg.luns_per_target;
+}
+
 /**
  * nanddev_target_size() - Get the total size provided by a single target/die
  * @nand: NAND device
@@ -335,7 +361,7 @@ static inline unsigned int nanddev_ntargets(const struct nand_device *nand)
 }
 
 /**
- * nanddev_neraseblocks() - Get the total number of erasablocks
+ * nanddev_neraseblocks() - Get the total number of eraseblocks
  * @nand: NAND device
  *
  * Return: the total number of eraseblocks exposed by @nand.
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..ed95ce07ce8 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -26,126 +26,209 @@
  * Standard SPI NAND flash operations
  */
 
-#define SPINAND_RESET_OP						\
+#define SPINAND_RESET_1S_0_0_OP						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xff, 1),				\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_WR_EN_DIS_OP(enable)					\
+#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
 		   SPI_MEM_OP_NO_ADDR,					\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
+#define SPINAND_READID_1S_1S_1S_OP(naddr, ndummy, buf, len)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
 		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_SET_FEATURE_OP(reg, valptr)				\
+#define SPINAND_SET_FEATURE_1S_1S_1S_OP(reg, valptr)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x1f, 1),				\
 		   SPI_MEM_OP_ADDR(1, reg, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(1, valptr, 1))
 
-#define SPINAND_GET_FEATURE_OP(reg, valptr)				\
+#define SPINAND_GET_FEATURE_1S_1S_1S_OP(reg, valptr)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0f, 1),				\
 		   SPI_MEM_OP_ADDR(1, reg, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_IN(1, valptr, 1))
 
-#define SPINAND_BLK_ERASE_OP(addr)					\
+#define SPINAND_BLK_ERASE_1S_1S_0_OP(addr)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xd8, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_OP(addr)					\
+#define SPINAND_PAGE_READ_1S_1S_0_OP(addr)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x13, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(addr, ndummy, buf, len, ...) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
+		   SPI_MEM_OP_ADDR(3, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(fast, addr, ndummy, buf, len) \
-	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
+#define SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X2_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 2))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 2))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(addr, ndummy, buf, len, ...) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 2),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_2S_2S_OP(addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
+		   SPI_MEM_OP_ADDR(3, addr, 2),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbd, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 2),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 2),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(addr, ndummy, buf, len)	\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
-		   SPI_MEM_OP_ADDR(2, addr, 2),				\
-		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 2))
-
-#define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP_3A(addr, ndummy, buf, len) \
-	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
-		   SPI_MEM_OP_ADDR(3, addr, 2),				\
-		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(addr, ndummy, buf, len)	\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(addr, ndummy, buf, len, ...) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(2, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
-		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
 
-#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP_3A(addr, ndummy, buf, len) \
+#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_4S_4S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 4),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 4))
 
-#define SPINAND_PROG_EXEC_OP(addr)					\
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xed, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 4),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 4),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 8),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 8),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(addr, ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define SPINAND_PROG_EXEC_1S_1S_0_OP(addr)				\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
 		   SPI_MEM_OP_ADDR(3, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
-#define SPINAND_PROG_LOAD(reset, addr, buf, len)			\
+#define SPINAND_PROG_LOAD_1S_1S_1S_OP(reset, addr, buf, len)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x02 : 0x84, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 1))
 
-#define SPINAND_PROG_LOAD_X4(reset, addr, buf, len)			\
+#define SPINAND_PROG_LOAD_1S_1S_4S_OP(reset, addr, buf, len)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x32 : 0x34, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
 
+#define SPINAND_PROG_LOAD_1S_1S_8S_OP(addr, buf, len)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x82, 1),				\
+		   SPI_MEM_OP_ADDR(2, addr, 1),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
+
+#define SPINAND_PROG_LOAD_1S_8S_8S_OP(reset, addr, buf, len)		\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0xc2 : 0xc4, 1),		\
+		   SPI_MEM_OP_ADDR(2, addr, 8),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
+
 /**
  * Standard SPI NAND flash commands
  */
@@ -274,6 +357,7 @@ extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
+extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 extern const struct spinand_manufacturer xtx_spinand_manufacturer;
@@ -451,10 +535,10 @@ struct spinand_info {
 	}
 
 #define SPINAND_SELECT_TARGET(__func)					\
-	.select_target = __func,
+	.select_target = __func
 
 #define SPINAND_CONT_READ(__set_cont_read)				\
-	.set_cont_read = __set_cont_read,
+	.set_cont_read = __set_cont_read
 
 #define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
 	.fact_otp = {							\
-- 
2.47.2

