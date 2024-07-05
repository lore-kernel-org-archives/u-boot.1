Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDAC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 14:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C35889C3;
	Fri,  5 Jul 2024 16:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fziT4p2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39B6889C8; Fri,  5 Jul 2024 16:25:35 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A6F88256
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 16:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkOKEp1VwUWba1Y9xiip8EKDsixU+PrqLUOiWoBQ8hy+og9821JCG2pKAdM+WQEfodb9dj6SpNf1WIFSr801Sg7w/otkcTOVQv0wq8RnsIWov5HWsR9UDKACUxSW064Lqsud0As5uTEKj9hTUN/TQNI2zVHDYA3MsFu4uqKW129Az0PaZ9aM96JTxV3PsDdaHNjOHIxVcw40C1kw2DN/AqvZJ6IGeLTQNG4WZB2+LcTrC/eOwqRbwW9iibDGkhlScuCqASiY0xaAEOBQemaFmU/xCCkP16Y708hFrajZYv95UdGyAwxIsF1aWNsRZZ9jxP2BMZflGIDCKfiK4/9ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/vwMLLIx02z4xBUgBd8OPWIu0ipgBpvS4Pn0S4Fl1g=;
 b=UtHSiEsxvX7JneZLdRreuu19Anp4AeYdMBr3mnnmXvg3XYWEaIUWP2smtG0AXdG35/5vsh8e9Q63fIO9C3GXJn0krFvhP7KgDlTPS7YIEgx/Vi8T7xmk+iwd1Doib95Rode7RQsMjWQQSZ9ahHxXSbi+lX50k8JsxJDUeYlZZucGIWUbyPHJ3v/cyJPIbysdb4KKTcD+Giv6+2kg7JEtGQZ44IOqamPxValYs/kxVfTU5+4tqZ2GhcJ4JDKJ04g9nBNj+9MZX20z+BxEBzBczSadcFrID395xFpStZcpledVDWJl0MfhblaOgVG6qVnPhPhmDAk+7ORyVR8xQWwVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/vwMLLIx02z4xBUgBd8OPWIu0ipgBpvS4Pn0S4Fl1g=;
 b=fziT4p2xffo1np590SVh8SyFnOb8nnHQkLeBc7nKrHfGY4cr46+OQb9VM20a+e6E2HjIf+q8QZgf8tgGikSansZZrloudCV7pvbjdYR573OjH5wb25l1rQYJWxYaqnKallEUZKgoD79j2QA2OHoT3XgGVwTnNL4D+a0yomkmq320k82f1+5DtetvbtZ3qyEgYg0FpRuTn3v3lCUrvLGZcKAH9Inmk3Si9u9rmSbEn4DypmlwNVumYbXvGNL86Qth3TafDwgHxh1+FKNZmc6BJ19zbtb0T9MqmtWERaQNeqisOLsVG2KZow64fou0exDmXH+hBlovMhTPOPvH1HUnyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5978.eurprd08.prod.outlook.com (2603:10a6:10:1f5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 14:25:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 14:25:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Chuanhong Guo <gch981213@gmail.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 6/7] mtd: spinand: sync supported flashes with linux-6.6
Date: Fri,  5 Jul 2024 18:24:59 +0400
Message-Id: <20240705142500.2272803-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705142500.2272803-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8195d0-9daa-4fec-339b-08dc9cfe5363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6q7M20Hg/CzW2aNVt4pBGT31JrQbmejEFj67ewYEb/pb92q7H4sNsCD0Uu5E?=
 =?us-ascii?Q?J4aMyyslIMNql8ck+McapyrcDASpaxNEmNftGd0iTAI2cgrI+f2nKGKAxRPv?=
 =?us-ascii?Q?ehjRepOedScs7WLZYJg48Iv4CGuuZ8Iz9A4IeGCye015p72aJOiJ5L5/gS5V?=
 =?us-ascii?Q?TRdz+De7vzRjjBilENDWAJsCdqqehz83JfDM+7mc9GpfoZNLRxtcHCUjyoi3?=
 =?us-ascii?Q?e89ImG8Q26NyRKkBRNmdZmmj9LB5t644MmIIzKjhd/NZ6+NIWMLEYPnwFHgj?=
 =?us-ascii?Q?LVz2qY9nHMltIX5g8uE+71q5Pkeou6bVTgMsZppkRdFjqO5lms/13fGUDcFy?=
 =?us-ascii?Q?Bl1deze2tOboOkSfugAW6P+1GOZ9hlyW81wFVJ3MggwLuwpLQCgk2qI+dwMw?=
 =?us-ascii?Q?kOwL1axT5oABcFNUXBQYPOq5FVvHL5jlRYI3UspqLakaV4zpPYlclrmGdZDG?=
 =?us-ascii?Q?n4dbaAfwS/G815FrLZ/I77gDVef93/hCTSbozoDyxNrq2abrpSK+avRqOCls?=
 =?us-ascii?Q?vAbu/1jXH58hmWmuIO9b3FHD0aBBjeV14bQiSnjPO4UB5gyZSmeea2P7DHsV?=
 =?us-ascii?Q?p62KbY7MSzQNn1zuK0+CnXmR7BY8CqBo1c/um6dEbiXuATa4H3bcGPBaGfUw?=
 =?us-ascii?Q?cvSqumQKiAZwlxdaktAYIER3XPLMWzdqBxmYZNuuyhdWmb25QAQt61lZlHYo?=
 =?us-ascii?Q?frYothq3H8/FCplXYzeWuxAfnlKmvoRIg4E+LlnQ45ISHLJf24cE3V5IDRWY?=
 =?us-ascii?Q?pqQyRnTVe3EJG37YLAzJKGrwm+aeVX9soFqDwGHSgS3UDUmRMoEj8QKmRamH?=
 =?us-ascii?Q?UiB9riBWliljCevygb4R9Wdv4bRKfW4ZB0Ys3zA6D061uv0tIuY3qdLEmfB7?=
 =?us-ascii?Q?V7xix1L8CjE8RcO3u+JuI/o2QHfoeXrLbKforEImuYBaJu/i5xvHDgDKU21r?=
 =?us-ascii?Q?xjITdIhF+ORXnreH/J3AyAKQ2zpFXcMVhAY4v6VPRy4kX5FVhDu0TNgm6qm1?=
 =?us-ascii?Q?qnyW3WyYf06q5aJ4vpSKWyfCfekT9CgjdEAgl7/1UV2EdVaB15vqgrNaXdlY?=
 =?us-ascii?Q?zRRcn2PvdfYSvZmf9yC5ROeuR+rCbESVqJCdiAGVqKIVRq/T/bAdidQal6CJ?=
 =?us-ascii?Q?wqgEnL1m3rPlPPcZmSVwvLReW5bWLb5WzUs970xdsttzpGhjSX26ZMpWbcNd?=
 =?us-ascii?Q?Oy9EXyLi5Noh2IOqGEdFYHKPdtFtqap/s6L8B39mUPvjCgo7Akx26QDHry1W?=
 =?us-ascii?Q?527E7N0QTW34f2NSvPph58Z+QC4A/nbaIMnJdawCdn4NNz4n25oPrrknKMtf?=
 =?us-ascii?Q?N+qgoFMtsV+7CyonlphHr2cgbTXXYFZ+tOBR6jBRrsia832aQT+HniGn+buo?=
 =?us-ascii?Q?lHAs/F2Outk3sKthsCotr7jxI4LDArso5RFQDUIuS9gt5fHYjeFta/hKH8/7?=
 =?us-ascii?Q?mLUbSEciUAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9iaBnofcHQiHkwjwNpJxaQF0aGymnONaiz2YDeu21l+z8zNhARh98ozYHcJ?=
 =?us-ascii?Q?CzMUOMCBkNVZ0D8GTP8CG7CzghSm9K7DLG6xyfFk3dP5bclLjQQYEyjO7Zb2?=
 =?us-ascii?Q?redcHfocdNpV3xfWq6gUhwWSAMTS+2F5DqC+TLVTuqxpnCT80Dp/8HseBgI4?=
 =?us-ascii?Q?QN3sfss8jc0r+PpxI7XKYJTtj1J1O3dRIJPfkEMn2qezdp3aBcKa/6x8c7cr?=
 =?us-ascii?Q?1W6O5EPTZ2MYisc+ZuW/Iy9a8hfNd4mFMX6t/3rb1ti04bAThSyBrZjRD2z2?=
 =?us-ascii?Q?Rmufy1inkWp0IFpGblBFoCtBNSUwDML4IUPYgw/eBscXunrGCEREBmZ3+7Md?=
 =?us-ascii?Q?tthL14jK6dnBPqsLQ/1wx3KII2MIOKxH0zS6ppv+nYodqq64JoLQAH7ogdRx?=
 =?us-ascii?Q?a84A+o83r7YxNGfZLiVRerlTWH4KyC4mEEtTZ4mxBzfKOZBoqPzWukbxFTGI?=
 =?us-ascii?Q?uTkrTgvHeZW3t6iyhCY59zrgmyrrEDtBSG7HyI8N0sqHNvszURev+IU/3d2Z?=
 =?us-ascii?Q?kKZMHU3b0T0vX5Ey0gyKWGAlUnklADS+B8sp8RnH1Y43DbopzfRmNDG6fDpf?=
 =?us-ascii?Q?v0CvHouip+1ssnlRKiubxr3itXwMqmdAuKj39tQx6cl4mI5pcGMzyF1pgbaz?=
 =?us-ascii?Q?3uguYa3HO6afKL4oUjqabuND6e5WWL2N3sFu+ktQkeKN6jSO1VS0kan2dEWT?=
 =?us-ascii?Q?gnN8oqUep5yLP7/OWXvdHJqB47PY5juVmUxn6LCQ/CXYbcBnhNWn68a3J/H4?=
 =?us-ascii?Q?GGqSaFrqiuenKwCq8JRwyq3ffN+PqPyy9O6HL9nm9FePd+EyfWTYS/miB/Wv?=
 =?us-ascii?Q?qx22ZEkASvheVW24BXOmSjvIr5kcSpvvYCppDoEEHFz+5kpo660SrDPFdTLt?=
 =?us-ascii?Q?fqYAfSRKf8X5oB8dVq3uwOg8fh3oG9Lo+1no2ui9hU0uRn0Ygai6W0uZF7kD?=
 =?us-ascii?Q?rZ+685i3LWatW1hyUT34d7THQytbi4ZphxwYu3vY5OMaCyBiLIR+cG1QlYj3?=
 =?us-ascii?Q?aWhkM7j5KCGKq3i/N3mChoNjybiiy4tlvs4T+LdHwyIaRo9J1/a2Xzrdzn73?=
 =?us-ascii?Q?WMHnI8DfNCnlEAeoLdXK/dY0Wm0Os5o3M4sMZiy639Pjjq3Z/odluAITbdUW?=
 =?us-ascii?Q?FNmqrxg/1BajNS4oySbDG1cKOKYg5P2HxWwZ9JoENGTSX8QE0nmvZpDQzFj4?=
 =?us-ascii?Q?s26eQjUkbAAupZFUtAd0GpwPypDj28keX1tx+mHnAtRFnBpI9X/ZczTW5jH8?=
 =?us-ascii?Q?8PSKPmm4ZU/8ui2gX39yU2PxkMBancNNqgVu6gYs6MaRIIDAyFf9jhRT3V/o?=
 =?us-ascii?Q?+67BelDq4VNepPJbHWn/1gR0PoUYLHg3LUwgWS8ubfrsYKILze3p2g8x6gPZ?=
 =?us-ascii?Q?RkvsyZ7rE/BaXpdm7BGmqi4nmKVzn5BgbmvJ1j4RVS8zXua/n4HU5iC65OCe?=
 =?us-ascii?Q?1gGT+oqZtG1/EaLytL9pnVq3f4ZwCoTN/9TMlcFfJBHd+B75DlOQsgSicVFT?=
 =?us-ascii?Q?WUtXhNZZNnL9LSvNMq7BzpawxQ7xZycR5WGNJTF9hvilcA6J/M2Y2s36MLU1?=
 =?us-ascii?Q?g45PqhX2Hqvmp4duVqNIxV+xe6su1EF/tq6Nf4hX3QIgXyPgM6H+0AqYRgmD?=
 =?us-ascii?Q?oDG5GdnaNLaroBQAYw5GYvw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8195d0-9daa-4fec-339b-08dc9cfe5363
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 14:25:31.6106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0MwFnZXomyJbwvO3Qwux7A2tEdh0e9GndkFgHcmBQcZvS+5Q1GUj110esS0iQqU1aLU+BuKVGyZ3PpaG4S01VXOw9cRVa0udfLQsa2b948=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5978
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
2.39.2

