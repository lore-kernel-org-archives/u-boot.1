Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B50C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83E380F4C;
	Mon, 17 Mar 2025 11:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gEynZfpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB3880FEC; Mon, 17 Mar 2025 09:46:11 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F38E80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TilRAsSZNV93qf+S4wyMgmFghaPZeGnUo/flyB49+NONOzTuu+gSu0+eb0GyY8klEYCQQMnMTg0bj4E+mXtx8akqt3iCE9k71jwDjyZFAXaBacazibeYYRiWw/GXk3/dkiKbnF2iH6762CInbZNoEglahAOehylDf24XZDLgM7IVkJ6JWS6mNYptlqAXzpjAlEhjxJEjKl3bIH3p+wT0XxOqy9KNmVUTAo9Ms9seAwLryvFlKR3tI3nWb8e8JDK4A1veKlGbvlYhhylnowRNb3nQZxAukzkUQ0q1/azxCTDoaOSsdvMxMC6pEVv+fejKGLpUyBbGK/TMG2nceaPumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H97MIdouOFTVWYNOKIavtyreYHm0ayrQKIK3qmtYCs8=;
 b=jWZqyFOOOlGWHHZkvs6cP0EqExfG8RYpXjxyZHynVDgHBuwZYgFCaWyaOkniyx1FDZ2dIIEiYReT1N3HvGl6zzbzPkX5qBdqU1fWdinYkAYOEZ9ambQRTWY9ZuJNKSPOjxKlTOfXU/4+erR1uwIUeb3Fdlsk3fbSwnQhSL09txRWvIgusjrxVBixBH4cpAEpnsDsiFHtb7NZcs4rzeDxl+5kxDsMHoyH0pnWggk+7JPcRQJ7cW0C9Y69xm+zct6iXkBJI7BYG1+Clm6ENCGFbggNIqEXoXfS1RNMpteQIX2byt92zss5XcMbRJrjQjgNHfI0djmYHonRNzwKmBTvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H97MIdouOFTVWYNOKIavtyreYHm0ayrQKIK3qmtYCs8=;
 b=gEynZfpI18PuFVt046+dzLYMNz3wg8648MhE7p4AZFYDJ/cbseNfxwZ6Ax7tG9bh745E4NL7XfPKX/redZpQ2FIz/obgJcKRow2g8oIR9pSqYdyG7/bYbHdoRJ/u8VfEWLM1mkgpROEctIGDWeOPdIBsv0SpoqeH3xmly/VZ7M6u4AW3y4XCgqu7w8JBmg7FPSfGQSBOduFc76gerTICxEQ1uUtWd90TfEW6IZcNL3/2W3FQ9pnvo3p1EbVWps42EjNDn9KrlCnzMeE862jDPXy8oh34FJWBqDTjEqEUu3mFa0PsVv2APbq7yhboQAQaMtZPwwqb4BbuTxhTeFLdvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by FRWPR04MB11175.eurprd04.prod.outlook.com (2603:10a6:d10:171::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:46:07 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:46:07 +0000
From: ziniu.wang_1@nxp.com
To: peng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com
Cc: pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v2] mmc: mmc_boot: support sandisk and micron emmc boot/rpmb
 partition resizing
Date: Mon, 17 Mar 2025 16:46:49 +0800
Message-Id: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::18) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|FRWPR04MB11175:EE_
X-MS-Office365-Filtering-Correlation-Id: 2098cfb1-a735-4756-f99b-08dd65302889
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1agjIqtp3MvN3v1iI/T2YNh51GQeiFNEejGv8gmJeIoU81RNEuaqH3/dm7JL?=
 =?us-ascii?Q?X5hjBv1V6kfKH5BX7YGsACOft3/Ze49tTzo6vYF/Nya2S4b1y117J8Ar4oAQ?=
 =?us-ascii?Q?F9HT1BbywtqT78U7BahnitmuLDOfDDgjFUehtLDNFGGMnWcxmXR3ACKLXq29?=
 =?us-ascii?Q?ZG0C/liheYSn6RbNRUT0rX4etGFjs0Xin1+ZmSeK917iP6epG+/wmC84wvhR?=
 =?us-ascii?Q?559mfjw1UAT/sg3DMhIff11ULiBx8VZGRq2N78XTN3vl0ygrRE/wVSz/2DeW?=
 =?us-ascii?Q?3/VJmznH1bhbM4RjeHMjo88vlFqkmMeOBqsHxKoRGmewwX/vutR4q+GjCVWo?=
 =?us-ascii?Q?l0f5R/cGPekic4H//eAcWy+FjnY1lxZqfa7md6NZNIIwnPy74RG0KQfwdns2?=
 =?us-ascii?Q?UpCN0idgZbqZb7DVtbuUZIMZN+izuc3NDMNG8/+yfJMF9Y0q0UM/3zHFQPZC?=
 =?us-ascii?Q?JY6ei1HEjVugiNSQCL7G5FRPvy8zysjSUkE1+gtwV00i9C0Pn5SK/yT3SEJy?=
 =?us-ascii?Q?AlD8UVLqDoYl1NcvXidhB4/9bb+Gk7xzS/xCpCAqsaxigjRkQyqb0/jy4TNH?=
 =?us-ascii?Q?F7u7KWgxo8whTRm3DMTCL6LDsFLdBLA+bMORBkV+Y/MnS0IWshPb3Q5i5sWD?=
 =?us-ascii?Q?rGV6Ji1RWHArD5MzJCNGwH+Fi4LpxbhlUgIIJO4xFuc37esqsb2G0Rcv04dT?=
 =?us-ascii?Q?uV1P/r991aRsBhEseuNIG/g+nAgy6wOS31IwZlbOKLojCh59v0nznsjg5CBc?=
 =?us-ascii?Q?Yv07516t0ndHtaPcnI8rcApSntAqV/4Tocov9VwjlUVHdxi7gYvPWKPMKw9e?=
 =?us-ascii?Q?jp738zsXR1hlhWsSKzzKwnegNRyhiwr31+O9mCmRR0cCdBMTbXp6/d+4LYij?=
 =?us-ascii?Q?c1rglSkzDF+aTQDWTePvEuiPI4CbMGS1ptmlE2r7eZlcuSbpVZ8iuBegjKoV?=
 =?us-ascii?Q?zF6FhuFjESr0LjqQ7Yu7HnRTw41GxdipxEgPQaUpCLZbeBb8210GBgaw/V8/?=
 =?us-ascii?Q?DP2IJAo7KxaD2JKCjDIpJP6Tsx72Xp6MGwTuyp6xwszeA+phiXaQSMU/95Hi?=
 =?us-ascii?Q?d5EXUCIuqJi7H3oJvWJ0pJK2yMnCKy9UScUuY3NUJTWQnsY+JqWbyzJwaclw?=
 =?us-ascii?Q?OqNO+4pLx9Bv9KQmIjdZn934/UB2jTTQ3pBO/vvOMj69pXr/9yKBGiHjebGq?=
 =?us-ascii?Q?8Z7USdvXGo7BOG8KYFKZV+WJYjfL5ZJ83Llt4NAKfczJ50Jd9uAt+FAOfHrH?=
 =?us-ascii?Q?OOarpU3gG5rfYkr0NPyHQAU6GtlBjuE1vdqWN47pJnwjNJQZ94XL8azNE8th?=
 =?us-ascii?Q?2zt8ZfYH6XoWjHfNESzgIi/fwyMtWm74ke4l2SCv9CHIZPPgTIHjSxm+Kvvi?=
 =?us-ascii?Q?3YkkUwa2BGRFno7pBZ0ed6FyMapFWGZeplcT4pfyU6E9Kb8piROEbU2tTfmb?=
 =?us-ascii?Q?zxEhXVeauQXixNeBbMF0Yg+6sN1OXlRB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyutIYSsYHfG3v1tP4TLaAjc5H33u2sWrNgIvBqGLnkELO2MtpVPdjb/g9lb?=
 =?us-ascii?Q?IFaoaqgPIODXs6v3k6BpLVcYADyM0g8NmYq14MPgcTcHPshzQyYAPq/kepv2?=
 =?us-ascii?Q?Fw9yHOMJuvB/dJ/1XiJh+g1Ia/llbH4WK7j8uiGK9XteZlD1O9zClsOpqbzD?=
 =?us-ascii?Q?EpdB/R13GsZF/QlAu/ei01wQnUqGwGEgpEFkvW/J04GLPQW2MmcG+5w08tzB?=
 =?us-ascii?Q?OIMTsMz349UR6XbYqltvtvAdysmomnQad7G3arGpQ2Ls+KBjvk/FQr5MT48T?=
 =?us-ascii?Q?21PqZBsox0QzI+KHKepC+fN4uueIeX6+I0i/aBNV/jVxgfv0KsDCzwjshhZn?=
 =?us-ascii?Q?wcpd9DcBhvgwh1Q7gICPqgrzuPCr0/KcUE1RJLX0crZdlu5ynQBI5PNrrt9a?=
 =?us-ascii?Q?0S3A8deugbHH0k+879RDcde053V5JgL9JMZR5Ns327IVxWSF+cAkBth4rJp/?=
 =?us-ascii?Q?iM8+o8LBuv9kizPqIF3eiEAyEUAUp12T4nHqaaKXApb2u6KPlm3i9Sam9umo?=
 =?us-ascii?Q?oYrmhS0x5PAMRRD9CSgO2p8f9SiwmNYbk2VqmNnYtGw1H6BmHgsa3OL7IELP?=
 =?us-ascii?Q?F2Q6h8b1k0o1FBDZVfOKsVj/dl2PxQPtTL1a1sFIjZF4JnQt/uhPNkcoPeZp?=
 =?us-ascii?Q?HNqgztDkbmSf9nlBsFNtcDx/FBygaXhAAN5BbguwFqV1NabsSevMcDUqozj4?=
 =?us-ascii?Q?ZMvSSYXO2R0segESqsKR65hCA+FnkEiHgttOaYbSLV/f++WuBaoub7zm6HaJ?=
 =?us-ascii?Q?4Wqv3b5WhNORqYLEVCLXyS4RWThq9O29qJD/C9g433HQPV7bp2GJaeLqlDyV?=
 =?us-ascii?Q?nEGYcyHFtRZ2++tSQWUP6o1Q/OmIQHzYOYdvSYN2M+Oge+gZM6GYB/qeco3V?=
 =?us-ascii?Q?r1/wXwho3fR0Ix8ctDXUteTVmXyMJpzGa8HzyVDwxT+WzEG5EiPaoNOO5/NX?=
 =?us-ascii?Q?SjxPxGwakp26adUL4hZ38+cpPO7sTrs+N4L0MRlNVTeRLqPEgmM1WMqBR1U+?=
 =?us-ascii?Q?vF9F8ghUnbO7uOYXATIoBusarHAJdTcN9NDWNnBMquHNXpRzFS3T/8YWZbav?=
 =?us-ascii?Q?8xlCYHKXOH0eE2CYCtehGn0gdY4DEE2PnKwdfkiHRZS5BAdajsQ0dDvO+WcG?=
 =?us-ascii?Q?6K9B/NYevPjZ7NAxRXQV798SJZccq0DpBIEiu+C1DB1dQZhJqsGlu0+xfI/k?=
 =?us-ascii?Q?csTlA0+lhAP8QgDZ3IVKHb91tNCE+xrtyVRgA6fw4hMZ5VAYSiQ6SUilk1vk?=
 =?us-ascii?Q?UZPbcObBkXirMxTW2bzq84rGBbGWqe44cp0nxQb7tVacxGNxDybeyrvtouuJ?=
 =?us-ascii?Q?o4H2Z4k3+x+qTc1sb/yREXwSJJP5o7QWo7gLDdU6q1/mV9uAnCXbGVXSlVe4?=
 =?us-ascii?Q?uDARq8XFYxFaneQWyORCYAqqlGcwFztwD4HfM6aWkEZEn7pf0iCR7/VRKSob?=
 =?us-ascii?Q?+wndmIpx80mCQvjmJEwOpUdLUjumuc5SWm6Dl+enOJDZd7eI6gs7WM3L9uEP?=
 =?us-ascii?Q?IARTDa8IGf38nV9XZUh6LXeRQfpTT0A3jcuChlf4KwN4kI369pqaMDHLOBLb?=
 =?us-ascii?Q?QyucQ2gNPUZUA3HbLdVlVhAgeBwnqTTS1j9Tb8qm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2098cfb1-a735-4756-f99b-08dd65302889
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:46:07.4199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7MTQK/2vSDRMG1m09f7cmY4UjqJ/9zuePrUUjGojPcIu+CitZaiIql2EUlPQ5RbfpgOPyZBDxEeOAh24vL9rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11175
X-Mailman-Approved-At: Mon, 17 Mar 2025 11:49:52 +0100
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

From: Luke Wang <ziniu.wang_1@nxp.com>

Current mmc bootpart-resize cmd only support samsung emmc boot/rpmb
partition resizing. Add sandisk and micron emmc boot/rpmb partition
resizing support. The commands and parameters for resizing partitions
are different for each manufacturer. Select the corresponding function
according to cid.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
Changed in v2:
- define some macros according to Tom's comment
- correct emmc manufacturer id
---
 drivers/mmc/mmc_boot.c | 173 ++++++++++++++++++++++++++++++++++-------
 include/mmc.h          |   6 ++
 2 files changed, 150 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/mmc_boot.c b/drivers/mmc/mmc_boot.c
index 367c957b518..ba6261a8ffe 100644
--- a/drivers/mmc/mmc_boot.c
+++ b/drivers/mmc/mmc_boot.c
@@ -8,20 +8,107 @@
 #include <mmc.h>
 #include "mmc_private.h"
 
-/*
- * This function changes the size of boot partition and the size of rpmb
- * partition present on EMMC devices.
- *
- * Input Parameters:
- * struct *mmc: pointer for the mmc device strcuture
- * bootsize: size of boot partition
- * rpmbsize: size of rpmb partition
- *
- * Returns 0 on success.
- */
+static int mmc_resize_boot_micron(struct mmc *mmc, unsigned long bootsize,
+				  unsigned long rpmbsize)
+{
+	int err;
 
-int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
-				unsigned long rpmbsize)
+	/* micron emmc doesn't support resizing rpmb partition */
+	(void)rpmbsize;
+
+	/* boot partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	/* Set EXT_CSD[175] ERASE_GROUP_DEF to 0x01 */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_ERASE_GROUP_DEF, 0x01);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[127:125] for boot partition size, [125] is low byte */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON, bootsize);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON + 1, 0x00);
+	if (err)
+		goto error;
+
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_BOOT_SIZE_MULT_MICRON + 2, 0x00);
+	if (err)
+		goto error;
+
+	/* Set EXT_CSD[155] PARTITION_SETTING_COMPLETE to 0x01 */
+	err = mmc_switch(mmc, EXT_CSD_CMD_SET_NORMAL,
+			 EXT_CSD_PARTITION_SETTING, 0x01);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_sandisk(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	int err;
+	struct mmc_cmd cmd;
+
+	/* boot/rpmb partition size is multiple of 128KB */
+	bootsize = (bootsize * 1024) / 128;
+	rpmbsize = (rpmbsize * 1024) / 128;
+
+	if (bootsize > 0xff)
+		bootsize = 0xff;
+
+	if (rpmbsize > 0xff)
+		rpmbsize = 0xff;
+
+	/* Send boot/rpmb resize op code */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = MMC_CMD62_ARG_SANDISK;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: boot partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = bootsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	/* Arg: RPMB partition size */
+	cmd.cmdidx = MMC_CMD_RES_MAN;
+	cmd.resp_type = MMC_RSP_R1b;
+	cmd.cmdarg = rpmbsize;
+
+	err = mmc_send_cmd(mmc, &cmd, NULL);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+static int mmc_resize_boot_samsung(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
 {
 	int err;
 	struct mmc_cmd cmd;
@@ -32,10 +119,8 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG1;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error1 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
 
 	/* Boot partition changing mode */
 	cmd.cmdidx = MMC_CMD_RES_MAN;
@@ -43,10 +128,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = MMC_CMD62_ARG2;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error2 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* boot partition size is multiple of 128KB */
 	bootsize = (bootsize * 1024) / 128;
 
@@ -56,10 +140,9 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = bootsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error3 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	/* RPMB partition size is multiple of 128KB */
 	rpmbsize = (rpmbsize * 1024) / 128;
 	/* Arg: RPMB partition size */
@@ -68,11 +151,43 @@ int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
 	cmd.cmdarg = rpmbsize;
 
 	err = mmc_send_cmd(mmc, &cmd, NULL);
-	if (err) {
-		debug("mmc_boot_partition_size_change: Error4 = %d\n", err);
-		return err;
-	}
+	if (err)
+		goto error;
+
 	return 0;
+
+error:
+	debug("%s: Error = %d\n", __func__, err);
+	return err;
+}
+
+/*
+ * This function changes the size of boot partition and the size of rpmb
+ * partition present on EMMC devices.
+ *
+ * Input Parameters:
+ * struct *mmc: pointer for the mmc device strcuture
+ * bootsize: size of boot partition
+ * rpmbsize: size of rpmb partition
+ *
+ * Returns 0 on success.
+ */
+
+int mmc_boot_partition_size_change(struct mmc *mmc, unsigned long bootsize,
+				   unsigned long rpmbsize)
+{
+	switch (mmc->cid[0] >> 24) {
+	case CID_MANFID_MICRON:
+		return mmc_resize_boot_micron(mmc, bootsize, rpmbsize);
+	case CID_MANFID_SAMSUNG:
+		return mmc_resize_boot_samsung(mmc, bootsize, rpmbsize);
+	case CID_MANFID_SANDISK:
+		return mmc_resize_boot_sandisk(mmc, bootsize, rpmbsize);
+	default:
+		printf("Unsupported manufacturer id 0x%02x\n",
+		       mmc->cid[0] >> 24);
+		return -EPERM;
+	}
 }
 
 /*
diff --git a/include/mmc.h b/include/mmc.h
index 81bccb4cf12..11e95e7a716 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -79,6 +79,10 @@ struct bd_info;
 #define IS_SD(x)	((x)->version & SD_VERSION_SD)
 #define IS_MMC(x)	((x)->version & MMC_VERSION_MMC)
 
+#define CID_MANFID_MICRON       0x13
+#define CID_MANFID_SAMSUNG      0x15
+#define CID_MANFID_SANDISK      0x45
+
 #define MMC_DATA_READ		1
 #define MMC_DATA_WRITE		2
 
@@ -112,6 +116,7 @@ struct bd_info;
 
 #define MMC_CMD62_ARG1			0xefac62ec
 #define MMC_CMD62_ARG2			0xcbaea7
+#define MMC_CMD62_ARG_SANDISK		0x254ddec4
 
 #define SD_CMD_SEND_RELATIVE_ADDR	3
 #define SD_CMD_SWITCH_FUNC		6
@@ -205,6 +210,7 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 /*
  * EXT_CSD fields
  */
+#define EXT_CSD_BOOT_SIZE_MULT_MICRON	125	/* R/W, vendor specific field */
 #define EXT_CSD_ENH_START_ADDR		136	/* R/W */
 #define EXT_CSD_ENH_SIZE_MULT		140	/* R/W */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
-- 
2.34.1

