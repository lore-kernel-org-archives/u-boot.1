Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED58C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C733188A12;
	Wed, 31 Jul 2024 12:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="B1lNc+NI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422D8889C5; Wed, 31 Jul 2024 12:20:31 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F128889E6
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSXOufDb0vo4RffP6bFMeJUTZ2OuqlA01UoBzkXTSH44l8nWgRdVbRCdvnTQru1dlgtmL9R5/UVDnjFFT2Y3c8pNJzH23yzb24xTuwv85yFAv3MkH2dfLB041Nae7eqb62/rrStSO6rA806zdv92gSkFmGZI517ukueuD2+cKrw+pgE7QbqYsKbVO3ppnu7gcxLGFhH16p4C+OBgJ0J97ksBcUazGJW6Tt8EZhqqRDekiXsUKsGiVmEjAfDchrPILEIyLsK0UyZpYD7dd8Pgle/jpAU/jIXRGjN1WOMQ/XXaaBOWE2TMn/f/+YCjB6toYJ192GS0o/RnUYDK4ZxlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8OBGBgWfiC3+akpoEZDCGeu69GRkUY8ygF+1VaEUwA=;
 b=ljYfvUqw+Xtp0inbdywgQ2dLgV5XltpLeXFAjiS9RgHSEfcd87HjuXVn9okcSH4s9Is5ihtmhEf5n5aLbDOeZEw4tgr0dLash9tw5wG3ouYoVZNiF18rVdeSeVle8InYtywBOy2UaXrTIOdUYOhz8vD15a7c385XTrcAYr7s7s1ZO+THEhJYFUOmJZRxKUrsd4W7rJTBMvJ7Pv4nh+URUSbFFW8kKb4FveixJ/r1Evkxd5Dp7Ut204Gw7hdGC+r80Cc//cDeVw49gQqZmMBZ1q4zuKKrQuY3pH34b26GL+aUkApFWYXRLQvCF62tfYjIPvIELzDcMDdV+I5VE2AUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8OBGBgWfiC3+akpoEZDCGeu69GRkUY8ygF+1VaEUwA=;
 b=B1lNc+NItRb6APkwVZBpwDDjHTgT9vtUq/+zg8x+DFL9yB4kwOoubsAn96RlDLt4f8++A8Q8YQBsWwzNeZRpdgS1eYXjEf5GzQ47ae29zGDAKwzmq+NwpfgDSho+XUzqKPVtHRtmKJZaGf/3BI3JNs+UyKwu7cG0ZNNOg3e6cmTaJgsq5ETH7mnWNroE0s29t3W61G1uHTb87poLklCWO+vBz2jw7oV/WvKKI43LamV4dXu10taYwk3wgtz0rXUz3gKDUBEDnQNBEwPwRqp0OMTY/pr/VGjZnDyYsW1pixdx6g/225+xSBdt1rl+KZ6X+dymZ2ka8Qs2swsAeJLgmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:27 +0000
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
Subject: [PATCH v4 07/10] mtd: spinand: minor refactoring
Date: Wed, 31 Jul 2024 14:19:58 +0400
Message-Id: <20240731102001.4030460-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 68354e9d-19dc-4034-3ae1-08dcb14a65bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uTxev2tm53yriEz07bQSlStpnvad2okFaJRrChuuxnS048Aod5MgrZzVTnmA?=
 =?us-ascii?Q?A/k35UWvtVGfGNlnHQfyLgpGvzGztiyelaXEoy0pNDcnz5ByHiVvhsJYtasG?=
 =?us-ascii?Q?tpVr6/0x4G+uTH9WMw8wkDAGPL68qsjHJ5F3c2DT+9OAw0uiBoq7KZ3fwm5m?=
 =?us-ascii?Q?I/9QHqAxYG2G4EFNdX6cMf3rypEjfGoETLOdTR6/xxQY+2lDgbe7qeDIhTw2?=
 =?us-ascii?Q?cCbO3ImMSKFilqP8YZc2dgidd2tMtpaYSZdNMaGdwvob6y1VqIKmd2Y5NOxA?=
 =?us-ascii?Q?tPX0wb++Dwz8JfvmcFmqbdBbPMT+lWCa4XM0xfVYVbufwDSg1YAfrY6QF9Na?=
 =?us-ascii?Q?sajupGNUixy6MRYVLw11UL4lvK5D0rVe95s+eEMOV0ww1eJLLPvQo53Z2/oN?=
 =?us-ascii?Q?Q7qvEq8H4etDWP4Cbq24BmcPMi6xyveyB6zyQDtAp055T/uOotMU2DRZWp5l?=
 =?us-ascii?Q?wb6hQn/FPN4Ccm2gQtkfT9ZLXvn3qasH/3Dey5ftmQaVgHjFdW0Wn/qy7kPA?=
 =?us-ascii?Q?q6p6aTN1h1w23z574hYS2gCObuAck/CJ5vQCWKAw4octMupGYZKWd904yG18?=
 =?us-ascii?Q?uKn6QwEkkr627AallTmlofgJCHd8wUrm7AD0LS1cPUdgMAjYtYol/dmUc4XK?=
 =?us-ascii?Q?zSjU6pCwLk/GYIK6zJAioO8sSGb8BWJfOZkxwZ/3wyfpYCs8fLO9M9947AwT?=
 =?us-ascii?Q?7vt8h1XGV75pZVEDwWyPyr4SXL8EwMj2C2cZ7oxWXOBvJxDceBoI39175jSF?=
 =?us-ascii?Q?2c/p67+LO4mnWuMSBULC9Ia5nZehvk4/EWlJfuXIRlZgwYZ9pcFPsmxwDt4i?=
 =?us-ascii?Q?NC38+oBkbCHlJtVFp7ARuoApAO5xGKp3/4TY03vJIEanU9M+GhmGX4ACu7cH?=
 =?us-ascii?Q?saOy3LHOwZL5TjR3PfF/Hhty2rwtCswzVDXoL0jKsF1E8GhRF2xF0n65kUSY?=
 =?us-ascii?Q?K8oPlLBLLWdf5GXdgiGqRdnDQ/rvJquyZaJ2DitUoSwzObeJso+8YqAjoJZ1?=
 =?us-ascii?Q?fuS79mThsqrlnD0qT7ML+uZw/SbVKGC+h16OxQxt1bapgtSnAhqsvgfhy0bt?=
 =?us-ascii?Q?t9pqOXh59WwkglCYH01P8Lz7Pbk2HKmH4ZVumK8XFWI2mHqhamKDP7LHWJqf?=
 =?us-ascii?Q?c6zcv2t75pzR3NVdAODSlKBgEHU6r+FtHA8aw9em6bor4fuwpvIHh/twKv3K?=
 =?us-ascii?Q?yyiP4i8hKcgT5znl1nbqx+D1lOccX+G+xPwD3hl63BUUCmZa568ET13xH4wv?=
 =?us-ascii?Q?ga10WAwg/9uW0EkHmlyqTT1yOgD/kVEUklKugiAb8y7iVwy9LzaPfhjyKJDp?=
 =?us-ascii?Q?3hwKYlqyMkCLh+Q31oRvv6rAd1nxu/aDCinkv1GsAoZj6db6kcj1K8D2TMCT?=
 =?us-ascii?Q?+D5q4nUPvovJt0Dv2F51bbvtWPmutnX8jpdl1ryDh5dXrqH+MYuDpUBDRL+W?=
 =?us-ascii?Q?/zmZ9KyPYT8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IW1H6Lb1ChLVUbz8BVgHYGQznV3EBCY4oDawatEvBWSuLdQm+PmxVX2DTaFZ?=
 =?us-ascii?Q?PfVFlz1SQ4PEjvc3Q1OuVt+j1RHOz9PgFHnRdIIEwsaKIcQGH71//p9AgcF6?=
 =?us-ascii?Q?sXVm3wfnaEcrH4k/Cp4VWd4/v5UxcmIhTO9ioKUXGGI+sOds8tBFks6KxTyb?=
 =?us-ascii?Q?LFypnAXQRZ8xoWolvFdKoJkdmKA+RCDSHJA8b+RVa/1AJEj3GA4JM3YKgPNb?=
 =?us-ascii?Q?bW+yQ3K6zKU+HKzBYabqgXjQdESJUN+R6n4il0ew+n7g6vNzNLM7FxUi6kmx?=
 =?us-ascii?Q?8EZriG2iVIjjKQZ4Qe0Cb1vWAfI96Lnno33B/XnAG5gtEfoxx1nDrWTrvBsU?=
 =?us-ascii?Q?hZbWoHAAjF1p3y7KVMqIIk3JhTeV7BJpnC9/NhgEPB8wlrODeTgixLNR7ZGg?=
 =?us-ascii?Q?O6OiyLvSAcv/MYkDxNacmUaP9f3NRVR0BWR3FMSwNMJ19t5z8N17NdwzjIe6?=
 =?us-ascii?Q?wLJJeqCpBtkS6pzaiDicQIALAj0kzWCNYv1mhaJ0ocx+WOs6j+YGSSQsL5kR?=
 =?us-ascii?Q?RhTlfKNDyAhfBU40S/KrAfkXggZzLBAXINK+ejnntvM5Tsd5c/s7TiVkMf5q?=
 =?us-ascii?Q?f4il9PTEUtLqaso7ts72d9zl3IWonat3wvQNT7h0r7g96k5EDrXk1DmVGEOf?=
 =?us-ascii?Q?URwsilUDodwSp3ozZXsGhOCjFl2sZgl438aRnKF8nZmwmU4AoBANKTBXYf6V?=
 =?us-ascii?Q?ZJZmJGtxcVLxqDdKgpLuZtJY8Ibim4DxIZNXXKtG4SsUDe+nJ7Jt1OVeU7m3?=
 =?us-ascii?Q?VSim923E7cKDWcbdWHOs1U5n3omohai8ziy7eP1qEU1tdtc34/yyZyqwWz5F?=
 =?us-ascii?Q?1dQg+fj39pmrrsv6jhfqSP0jB8/RvS9R7bXu1kYqQeuvEKR3KaHZiZpztBuN?=
 =?us-ascii?Q?MAepQwEw6TiBiE8NoDwJfmVwVAnNo5FKg/DKb8TqQgjpaYKWRjkzjL1DugK9?=
 =?us-ascii?Q?1w2Y12sv8Hw67P8rKhPb54X5z+aH61Kw2N5K5cY2vO6712BYYwpz4Pbm4ah4?=
 =?us-ascii?Q?oLlk8tMPV3slwsJ7C2jPwEJ+MXWnsERDtTCrLrVJnKKexxxPS6jty/WbUepr?=
 =?us-ascii?Q?cAC6YEl97vCHXuireNjncf6ibypr6XNA6NCfg0mnxlt0oLK9h3hBHwlp7M/n?=
 =?us-ascii?Q?AI7BETybdVniOb2Jb/vnS2Jch1NJxpEnK3gAcatMgu5qnvbHeMBNwSmq+6bQ?=
 =?us-ascii?Q?I2jpG2OJRDoFIBvF7EhGGgvGzCQu/bOFksz7neVBipTDrWF5AYou1KkmYnPz?=
 =?us-ascii?Q?5qk0ogw0m1LmzEYyGlHOYczrDifeFYwkW32Az4bAuGQvCaxk+8gABDAnWuy7?=
 =?us-ascii?Q?7SZs7NpiezZo8VbpvhZ+0RjzQHg9KoYYd9ribehObMgHsU2GNSqL1De3ideH?=
 =?us-ascii?Q?2if21N9lKzfVEStOxVbrZY3D0E3iY1ltFnXmhSFBeAeI+ZJbJ7ZfSA+uzEoh?=
 =?us-ascii?Q?L8OqwH+ZOCcnhOvEd5JcmPq54H4HIky4jmos2t4WLsBg+YI148wIkLn9uLZ2?=
 =?us-ascii?Q?svdH9/vGPiHOQpGqfnbFyuTVcy1YHhV9yyD8vtay4gsEMSC9a3Hx8C6ctBvb?=
 =?us-ascii?Q?VtJ8LY6GIpQIKzVBbmsJI+Ob/gdO7vyK2KWYoZk1uHvxjNVIDaqmXfRalbzR?=
 =?us-ascii?Q?zVHqv+BAe7DZUCWk9tFHugA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68354e9d-19dc-4034-3ae1-08dcb14a65bf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:27.4224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvdbFPoB0W/VJOkIiHekQwa0HWj+R+1AAaZkjvG94Wa1Nd3IbfCkX3iIUrZ9H85f250YmmSDSajhY9LdqoHyuQSfLrydqAyaaOUQeB/gvZ8=
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

No functional changes, just some refactoring to match better linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8d5c07e6966..cb787908332 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -155,20 +155,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -187,6 +179,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1068,11 +1075,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1105,41 +1156,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1166,6 +1186,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.39.2

