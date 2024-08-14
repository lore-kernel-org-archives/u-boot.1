Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46C1C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713E4889E2;
	Wed, 14 Aug 2024 12:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nQNK/QE0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D5EC889E2; Wed, 14 Aug 2024 12:19:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B404888CC
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkc50gvKKhaO2vF27PT4q0m2skwTFZCPj59yOFGSHlQSC0wwBbr1GeJFtMfoUOSYaD+yPfxvAiJb5rFfBpnXfPSV/ar+6/hQ/Dwagy89GhhoARDLQT+spjt51I6cBjXwMecdv2bgKkbB43/Mob6UrX914/Y/Q+XDXvh8YjsupkkK6LTNk8ufnXIo6fsXKxxRXnYNdoF7Zdf6/q56H2QJlzP0EaEMAkT8D524EKMy6ji6d0TGlaJ78R4fiwa4MsuReQmcNxuviyy03An84y/MBVKQzpcjOv4IlA+B3ymwoEOeV6OTWFamWnDtS8V4VI381gtJL6gm4chVNN14jMaYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4z6gI7fOL1ejap3WA8EtHJL09hSoakVEd31DvdS/gI=;
 b=XTQyEsWEDGduEF61WYyhaZGF1XsJnr73idtIQvIqw+y11bWG4n3UpVC31L7rFRJG3uN/8mOTQb0XZvIVFH1QuGb+CUmUSZpGlpQ19ZUSpvuRsEXYhaDk7fQQEUbiz08hO94hAXnexfyWi9YuT1u+s6bQuL8b056NwXc7JVMMBqNC7+TqvJQHIX3bVrVVass18pP9tkVIN6NqQoM/qi0lD4eXC3x/RsDvdMC/1fNq8YiXhzC8uYpOqVyAN5i6VPZdEDNS1zLPCfHK5806PENBE7mh5ISIBH37uS7qPOOIqcrseQdKgiH3j5DT3p+HE15foPbtgxs+NzKXkwpyGt8vsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4z6gI7fOL1ejap3WA8EtHJL09hSoakVEd31DvdS/gI=;
 b=nQNK/QE0YytjjyvPaLbVLMnKIi+UFzywYdHQR6JYyQTsDpV7K4iPD3g17whHIKCLOaghJ+deynsqhQQnksmxMmaGx6qBeOc82hjom+zIuK+hv8/43Mzn9SQ5ZknaJa4VTQWyTtI1KQUFhKB0rhhyMmtZIw2EYUbZc2SfLAKSX/WFPADk7RV3A24XNNr6G7odnMu9MBsECuI22CX3oLVR6Z3ffAOKXoTEYxTkwGXNcNSwBu6Ee+O6E96y60P7o5eZYLd19ndhdyAJvFhKgLfEVEz3DFE1tegtMZxwkGbQ5MEcDhIQTya4WNHbU3oj1WGt9udggXKU0mCv5eIg59tyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9524.eurprd08.prod.outlook.com (2603:10a6:20b:60c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 10:19:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:19:43 +0000
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
Subject: [RESEND PATCH v4 04/10] mtd: spinand: simulate behavior of linux's
 function spinand_wait()
Date: Wed, 14 Aug 2024 14:19:12 +0400
Message-Id: <20240814101918.1347167-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c42f3810-8171-49c1-1f88-08dcbc4a9d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PTLT6wQGyRhCyBy6jRNzhScCT3bgrww23eGoQaXlu4utzhln9b5qQuTEo7bP?=
 =?us-ascii?Q?Yo8c0gnWGO6ze+dWlMXCoSBeKJW4tCIbCe06KOSS0xDarvgYJbuxDcN/MmuH?=
 =?us-ascii?Q?wvKEgBCnmXUM0qIv7yA86f4fu3vM9wsQis7Ncv7KHugE/xAW/JBt/nTsRbel?=
 =?us-ascii?Q?sKuLSP/9fw4eE88ZQsEm7M7KzTp4Gd2ZohPrqQRFGFYMXMspYW2BIDxAaAr9?=
 =?us-ascii?Q?sbvq1cwm8xSLpH4ttdX1WeNAgHc0EV894pwSw5n2BNY/xYQByesEi6jbBxLV?=
 =?us-ascii?Q?V/N1c38IMAZ3eeDYxn7vzBdVlZVhEodJj3kZ6FVYtewCVjxJHmRd6NseUkf8?=
 =?us-ascii?Q?HfPLS5jLldLyZqIZ9BKu9Afqz8K6tK3ZXgdRkl57/m/d91nWXzBOFsuI0Ptv?=
 =?us-ascii?Q?IXhzWBuuldL9COvXE7IWMfz0Q+BZTbw5vSuSi8VZA0B74HHHOua0GBk1A/fN?=
 =?us-ascii?Q?pxvjKyFSyaFB7bmQscJ6ZNj+tMWg7crlabMuFMSgHr37C1Kt+zh7u8FYYiIm?=
 =?us-ascii?Q?7ngwHoAjdDYnYEgKOZEKyVBw1bL1jIFcz86vzCiPHVb+xaS+T4BWVCPe0TP/?=
 =?us-ascii?Q?m6r/CgkA2cUvOuZjoZq/0ijnpJ44cbVUItfKS0pTZAbTENYAT0vXm2TAjOYK?=
 =?us-ascii?Q?kc2N7OJ21jx9+2HM2k6uXvs+rn/u8j8pA1gUi8ykdutzRRS8OXG2D8bjzxJ+?=
 =?us-ascii?Q?QGbXFxP9Z9vKXUOpsGlFyYAbia9jrGcCxO8DI5BjRBLez5ZYLxOalxsnsdlI?=
 =?us-ascii?Q?jP9IC2AzfGouPZ8535v1WOk9YfkZjbwylsQ7SaWN9GdnFz0S/5zVLfKnrIuF?=
 =?us-ascii?Q?ay3gc0qsc5euP+hEMNrYS0Jhs3mclJE/pl2w1h7++lBwWZoZ7Q1UHBYTvmpv?=
 =?us-ascii?Q?0njGVWNv6pkOnu1u8piLAQ7SLJ5gHKUgJh5inIidWHwnd1A53kbMEFuNhD8I?=
 =?us-ascii?Q?Y11U8ibkkkLfSXVU1phIZYYofnLrfRXCbG/XzxzvEv3DmPSG3j9opsrdd4lh?=
 =?us-ascii?Q?yczeFj6fyfedPZPpVFluMgPBHqdITIzY5Ha+Zk28QNeJizRsXIYP0b/YrjhD?=
 =?us-ascii?Q?SP2dZgb1LTLOnixjS4IqoVS5usFfgxKBqRZ2kL4ccBmNb79jukQtfwdcfygP?=
 =?us-ascii?Q?xAVcgX5XCBnJSETpSMasQF7G+zRxkawuuqx1E41IyjcDX8ifUhubO8nWVZl1?=
 =?us-ascii?Q?Ve3BN72maT+eGIfS1ymOmBgnU36s05B3q7K+HtD6NUUhIuzaCkwZxEBkgI+2?=
 =?us-ascii?Q?NeSO2glPhCqgO5DiE57iHJlwlxUVbo+w3+zzTSTY0OaXIvxMXRNTCiV/9oGE?=
 =?us-ascii?Q?GqYTWeDL0UCFqqdHfT7meU7UwOjW9jknKDMiVVWIvzQZIAW7xERQ42c3/VQD?=
 =?us-ascii?Q?jew0Qi9/aR8t4zzbqejPS6wDyuxo1pmzfw81v2rH+Vnn7aDeczBzYRz6cTuK?=
 =?us-ascii?Q?n4kq+H1Uiz4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3fa2p/8mthOr27JqWpsdIPSdl4rP+eMRhelzJw5LtPZKRo0ZSF60Ec2KdxV?=
 =?us-ascii?Q?QusZjYd9G8hHmxaXQAsUH3bWHgGGAqm6dxx9D/CUq+6oSpeYsvNqqgTXpN4w?=
 =?us-ascii?Q?N7rEyjxrCH/jEX0F/1iErrhoLQbJyna96rke9wV3+ehCHfFS5CHkRugltXch?=
 =?us-ascii?Q?958XQSe6hZ07ZOOGWhUQYSpXQr5t4/PsSDeN4U5qPTfg5eqGpO5U6pvJucAe?=
 =?us-ascii?Q?Vlt1GvdTcJ+883fRgVdeVEcZ9kh1V7tVxlI0h4K11FBM3qwzGZRdej7QExI3?=
 =?us-ascii?Q?ppuqCcdX9O4WB1qxhT1h1YYub2UuC/9pfIWspCE1+4qI4+5S1WMRzV/xmyU+?=
 =?us-ascii?Q?Tdurm9lgJwNFY9AQZsGsFjEYEcC1zwZFamlVfVTTIDnDu88eOzlxmAuFk1TH?=
 =?us-ascii?Q?jq11iBycz4AXG8fx0v9xwGG25mwrcU8f+Sk+lWupHYr/+pLUgD30BYyMGqwf?=
 =?us-ascii?Q?fNrEFZaA6W1b4CujaNNZMlTQMjHQarwVpQC+f79o5XXO/pvwvj1IyPwqn1fA?=
 =?us-ascii?Q?AEDo2bHSZS6ANn6pgSCT8hX90zKxIzCv0tbIeFm0BeO9asNuvkGQf3RCDiXI?=
 =?us-ascii?Q?Tkz1/3h0Mf63E8cM0Smm6SoDRjo0gf8ABXPg2NKQQ4cQqgd8Z20kYWdBA3oO?=
 =?us-ascii?Q?S2g/UG/3Lgdsj83IwVfd2x8qf7dXWASagpQUfM5ECXh8cXiSt5Ctb0ZvJY8s?=
 =?us-ascii?Q?x8NuwtxFSANYPUYSrmZHE1qLf1XSs3DUVsCNnOLb6U0rR1bAqQ08WOEmS6Lj?=
 =?us-ascii?Q?QUpln9RaIxQh2962NmwbVnUR3tBV2kBdQ6MeCC6zxzm2D9XXTavxIiEIQQJQ?=
 =?us-ascii?Q?j80RoCCA8TQqt3X/sIPUcOP4rMjy/cY3/VutYyBTq9vXfjLJ4ps6iCN9aXLe?=
 =?us-ascii?Q?L0CjfSPnBo36Beb1mbE9f/PxsCZ/hLoPx2Og28xe30o9PiI5wM0uAj+902Zo?=
 =?us-ascii?Q?hCciBM2CI4wQWqVldswbHfjdyvwPm2RnJGRVEOcfiW1BKG+n1WB3fJa2vMWY?=
 =?us-ascii?Q?3wOJmkWUGsqoblQoUOP7bpzq+Gus8GAsx9yWA6ck1+9bObfHT+bL7XlDurXl?=
 =?us-ascii?Q?a9oZmyrjxlaHlPZVedDAopnkY6ZqAzx8JqWHXcIhc35y6j3iOVEzkyjn7wyI?=
 =?us-ascii?Q?0ZHKF76VvzDUOHH4o3cXzzrJS3AdSILJWTR4UWQBNjXZtP0XJZuyuTTkELCs?=
 =?us-ascii?Q?SxZ+scpxZ+Exw3S0Qu99eEFQwXbe6/U+Yvb3ua4ThGg/dwjKnTtpBhI33kWz?=
 =?us-ascii?Q?X/+9UDeEykzg1m9ACOeZYwbK6UTIl/wjRUGYNdgzQZGwTCkY+ZxCRTi3ljlh?=
 =?us-ascii?Q?L+Ka56hnmU5ZLqG+VR7zfN8bTNckKxdVdanVBcXO4XgjQGLXbuFfrwOb1WaT?=
 =?us-ascii?Q?oR4l9yfwws2GjF1yj3cY4hY4cj/+4zrPLly8UZhbLqQH1YXDiQa3S4KckLvb?=
 =?us-ascii?Q?Bgcp604ZXbQfnmK3SnWuTBkVkcn1mwP0jDwrMKp4rDlBrc9B9xyhXEAfUTAD?=
 =?us-ascii?Q?ts4Wtu44b4v2La+0IsCJTsA5F/rncNooEBlGxQbVgbAnAYahFrrgVpeFdO6V?=
 =?us-ascii?Q?i/jo5YBGb5SEWtqjXUpPH/lJdUIQ/cibwjQ73nTtP/KpQJ360ORYnFNx0Bwi?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c42f3810-8171-49c1-1f88-08dcbc4a9d80
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:19:43.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+9bS4siUFvMTiXK4Kj+DhXMtfOug05tP4WLvIgG4yx5d/4pyRfaZtU30H72AIMyI6QjJ+dyI042E6BdDg40buU1nqMB0NZU8x9ukJ6NTbU=
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62779dd3e51..a10605487f3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5934b7604cc..b701d25f73d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.39.2

