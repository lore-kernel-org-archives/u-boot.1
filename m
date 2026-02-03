Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4AAE87834
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C098B84262;
	Tue,  3 Feb 2026 15:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="tInAsPnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F90842E1; Tue,  3 Feb 2026 15:43:34 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A6D8423E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdUykrlQtLnHBXbZpuafZbfQED5CVUp7+3VqG31rf/bHLNMkE/wLtxfmj60WorZwQEEJE79xVIB+Ot3vKSJRbtwV01VRD2aS2/CA++scsIokFGtf1wqXKJ1Gh5UrliJ9xuFgWNTNof8LCg6OgyL/JX9269UwS8ZlxpACXiPVUEYdZFjJSrtM/qS94p8BgHSrrNnpsxrt0zVcFrHhSrMt7eIyLlwGGBQrls0Mhun49l7sxslfLoZ40y+6vkmYjSdjZUotkOlonlP6ooq9LMZmzVXIHXpQgti3SvmwxZErf7v+alVKrvvNB1sPpIZ/6RtoAh0zyrqPMebUz3GKdB1VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRnEskrm7s6/jftso8ilZ40mXEzTh/zkWiQFbMKPmPQ=;
 b=cRmrVCCQO0YKwHYbbzIcoqJHtIe1ncLx2X85YtSqwN9TbCqCia4ptN2hoGr/JpTNRddvvMmVIaLdRX5egH2ykKqmS/uW/8cUa3LGZ3T2yguH+GwhS4x3nHPJn7An1JsUqrOBGudzmjN0qMQ1B6lG6sGSN3QoPmDS4jzZKdUzzcE6diusOUvEfkNSugonlZxdQBKWVzJpZMTcfFSqhly4o2Glwx0n3UeCC5WaRIk8HzIFM00UWogc9cVYtp0LS4aKOlPEprMc0C1MAZFFs0xIYz43vPdzYi7ERFqAkpAlrO9cmJaBmBOq2RxobPwkf7Lv0fB56eIVIGziMZa8lalSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRnEskrm7s6/jftso8ilZ40mXEzTh/zkWiQFbMKPmPQ=;
 b=tInAsPnF+zjYQxXSKvyYn1R4UwWnbZS+nAlTUeqxBpi9/OPAmYuS4WGHvvkH8amD84mZbqTizQfQhWDXSpA9yoXevQOGS39mKnK0SrI+gJuwCOlkCxqHWJoo2wjnQ+VK3VMN2o5+JUKKgqRrKL9yKbGW6o/E8wT5tV4xZYKnVJEObE/WZ8WZojsGpJy9JMimHReaFMa+K3HbNRDlIcO6FHNHQ1OBNaClffKIegiVBwaC0PW8CGz7yKhOrBV0PNNajHlzVmLIewzv7VXvDJu6yj29tjMwFz5fYEjBMrAc6QNav+tWRiMJ23thjh8i9BlH7pUBXHl+qHRBiIlb2aP7xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com (2603:10a6:10:371::13)
 by AM9PR06MB7267.eurprd06.prod.outlook.com (2603:10a6:20b:2cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:43:26 +0000
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c]) by DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:43:26 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 1/3] bootcount: Use predefined count/magic bit masks
Date: Tue,  3 Feb 2026 16:44:02 +0200
Message-ID: <20260203144404.12093-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000662D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d1) To DB9PR06MB8439.eurprd06.prod.outlook.com
 (2603:10a6:10:371::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB8439:EE_|AM9PR06MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7e009d-2726-466d-2c0a-08de6332968d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tO2SeJle8L8dq2qU1b2HQ6QhWLjy2ionQl+t07FUI6bZBtyo8nPlJQ/CaLVE?=
 =?us-ascii?Q?i9T5djco06cEjJgDgJzCItw9PkBxV3y+hsTZ5u/GBM931exVhp5PauWGagnM?=
 =?us-ascii?Q?vQlgaZiHYYoKggmi0tL/7+oWHMutdEEF8poCzuIxfR/xufuIej1uKHv/myHY?=
 =?us-ascii?Q?1leL1nCjh8rSZmnQuoV3SCxgs9k1jwVJPvb40H2BKac9BNbZAybA6ow3eC1P?=
 =?us-ascii?Q?TSfz8fZ2NiveIGjh33JC/A++IiRan0IQj3DIIvNsYrqyu/UH9T1CVMYEazTS?=
 =?us-ascii?Q?Ayhha2t/oDfxIzg0j+cGTsWrtTMLLp3jMImSEdakfK2oLBva+c7OnphQtOal?=
 =?us-ascii?Q?KwgECWuUuoFrPF8+QN850yTP3ztv8acFnZC5HB7G8JQ7tJEIOnY2pCGqGxps?=
 =?us-ascii?Q?KXEd4AKcsC1Vr4qOq+0nEcVjclM5+DgNNlNL8kz0LP2EYLti547owtZQ4Du3?=
 =?us-ascii?Q?bNC/SCYStEbqaBUTB5rTvBYlDQhNiX4OQGPQACpxzZ7fizzq21YCqSeTq3ty?=
 =?us-ascii?Q?a059x9Le1gk+b/Zj864dbtgEMtjT98/byilFIpk8If3g/wdNUBFRU2EA28Aw?=
 =?us-ascii?Q?2SPFbfy2GCovMCeAn64sHh8oF9TXvNjHAgh5Zr7lOGBLEfNUqJDY6xxTjVL6?=
 =?us-ascii?Q?3mGOZAdrAO1mJIMyPO8qVsiFBF2LKBbItXvv2IJ4kKePQKdYbociwggvgNdW?=
 =?us-ascii?Q?rAPc2Tv5kWgfUhkOhPVZVtN6Kktxd3JEA2c9djTaq5U+Qo6nGGYyW2qpJNcR?=
 =?us-ascii?Q?DZ0DpbMi5sWkr+BaIwAAtwxDI2HJt6XoAZtGAO9stpKoo7sPb828zsIOk4pa?=
 =?us-ascii?Q?kbYaMtjC0+30tafSpz5fDQsqIlRU/hQHxxm/w+6II4BcKFqAzdqJJSjvN0QT?=
 =?us-ascii?Q?ZLv4QUv27/xJt7MmaqZANGcDjyX2zB+vfzfQh5/uC+d3MutfX3QPr0W3LgPO?=
 =?us-ascii?Q?Ep25pmLAM9sdCj8MXOBWrTdzAupZ/x56lTEWJdE4H3f0G73+GvsVkMqckfCV?=
 =?us-ascii?Q?rVgGrLUFCergzilxjBzO2cKhy70nwLixfbHnsvHhYNHqcYmUtbuyyCuB2tD9?=
 =?us-ascii?Q?ZQFanqI66emEj4Wm5Uq6i/jaP4xRMoiES+Fa6+dFjXBnlXaKN1i9iWQzEYV+?=
 =?us-ascii?Q?shTrErQI+X8yST2Ofc5D3bNkyCa3V02uiyfCohGNIZemW8WdkNKpV2PuoJQC?=
 =?us-ascii?Q?MXgfG3Na7uh6E8oAmRQoClLnYjGATt5+2Dn7TGhyaAoD7cu6MA9VUzPz9FNc?=
 =?us-ascii?Q?zsWAEVam+FJ2afr/nUyyIGE/+x7x/s7dM9A5AKqEDvEXYMNnSsU+6aUotG3N?=
 =?us-ascii?Q?ZwsmS/DgeKVPlwCg3Q34EMU73+sz40vYhtyd69KiVujVcyWlVjhTlO+Z/k/t?=
 =?us-ascii?Q?L4+I9ipFvs06UHGIAhU7lmYMsMceWR5uj3tE2M4yvELk+PtJRr8EKHFOXm+N?=
 =?us-ascii?Q?iFud0ypDSoT+xWJ9iLqMFOTQAW3YV1N5F+tp590iTUGr+yBEC84nO45Hypnx?=
 =?us-ascii?Q?q9fNbEX45vAG8rU5Mkct3is9Oao71EA3QspRj4636+FN7JMaaYOxO4m0LLvt?=
 =?us-ascii?Q?18LJAuzQX4+34TqikDsy2IL2rMXOxXHDcaGtXQz/ZGl4YWaS3Q0iX6Z4PAtb?=
 =?us-ascii?Q?sE9Cxj9fTfGSNKRLhnog+M0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8439.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTywF1MJwXjnvKAnnxBDQt5sMU4Z8qSZKPTFGCmNiwGNm/ttFklnXpCGLitz?=
 =?us-ascii?Q?vJDYGvCI3gw1TIHSs+83R80A+jWp3dQ08WC+HOSm4uxJ9NGb7ZXAK59Gxlnm?=
 =?us-ascii?Q?AZpHFSlGvJMtVVdSUHX40xnHHyVckRyAlKgbwe4ODQOqI1yN5UhHcS27lXsP?=
 =?us-ascii?Q?jFfHrOjjf++SEzYH/jkJO5eYlL031ufq/69PuoMGMfycCx3FveArs08zBE0X?=
 =?us-ascii?Q?3NBqXQuEUZpE7Y8U4Rav6lTVdB4Xmvd5h1LO5sr6Eqq6uJe8pPfVe+M2BL3d?=
 =?us-ascii?Q?383UmXczKA5vCgiTOWPE/6qeN8+Jz/Bm4Ez0eD20gE184vsvzlfqkZM/H+QJ?=
 =?us-ascii?Q?Gjo1BlUiFkxluK6N1bxb5x6d/qwSEIq4nEFjUeODmyDgqABiZYuUGUmH/sgu?=
 =?us-ascii?Q?MUhWprEXd2JCPwnyrzmWR9NdYMHnRFeR4W18uu+BNsNLBrgRX9gUkCuXTofN?=
 =?us-ascii?Q?15QCW3xLjwYr6A3j7wiOi497nbt8SzMzMnmbSh/c0gUjZzlbPOtZvLYLvarh?=
 =?us-ascii?Q?iIdrJX1CCw1L/9FCluZ/jYQW9Xjm29ht5NtQaznNTxbG+CraiZ+5Y1YLfe1g?=
 =?us-ascii?Q?bz1mkIqsPouVKYbgYTBpiCUGmi1+dQca/OxPY/mUCzmIwdKX+OHl7y+sUN6A?=
 =?us-ascii?Q?Ww5ZVLhPzlHTnr47ByKvfrulJtetIVZNqQXS+oEop7WrPvyk7z7zjQcXhgGp?=
 =?us-ascii?Q?i9rjzE2PP6+u4971JZUhQss9/8vYAsj7EJWrW7fmmroIOABeQqIuAhL6GXGC?=
 =?us-ascii?Q?tYiHgye67fBnjUphfxwKU2OYEOKo9HAwClqLlBmX0h6Btf/tOndELjF+nguQ?=
 =?us-ascii?Q?qev8lp9kWyRL/lA0VWktS4cX+M43ux4kutNyIkfabSACqkT1MfselJK+19Uf?=
 =?us-ascii?Q?Tvn+OGpH2Q+a3J6t9heObcyJ5HdIM3hlooitWkh9Dp5jLd/TfeJ4a8tmMsUG?=
 =?us-ascii?Q?hrANcR0H4hOuESh2mVB8JBTn2SiJbOzY6Jm9t/SY7+LS4laB1Xh3ew1CNWpb?=
 =?us-ascii?Q?Z8lUWAY+loB1tB5o7aVdsy+dyQ9kSF7OTsCNt1okxFYgrVlbsCuiubT4ejNK?=
 =?us-ascii?Q?XCVMDI1WNrRDesQsqOALd2pdZs7BuoMKG04QLZVJfRB3t+2HPY9Yy4NExYa9?=
 =?us-ascii?Q?xXKGaaGX5RdTRFFWbVyiQgaYyL40jLQqzQi73kRSe02BXYGKR0jb96kxqPnW?=
 =?us-ascii?Q?5CC0jNee5LVV0+4PVWqPdYOZaUlNfvyV0OOn0XgruBAS6zD6vnBbyGAySOw0?=
 =?us-ascii?Q?wzt14KiEeVcuith1fpz6lTcCsIy2sueUg1MGrkV5yHV5VBXyYBjPviyK4XZO?=
 =?us-ascii?Q?Js8cNzmGDxDFp+aWhEWTMv0yPYe4xPcn+6VA8JgpK2ebv8k9D/prOICiogFv?=
 =?us-ascii?Q?v6PlScV+xz8xGVVTa2brht2y0ZzROjYDYUsyA7l6dWQFaCCpc9RFenHU39lG?=
 =?us-ascii?Q?owT1zUWPbYnT0rq6/TOnux7jXoypvB4l7EI1B9lsSIVVOT3BUluAxzub//al?=
 =?us-ascii?Q?7VJ/Kxv33bUu0oOOOz9gsGLcicMjOcyZNg3cKoKoWT2/tYLQzZXWnjl86mzS?=
 =?us-ascii?Q?e3i3undyLhJFg5xesOWD2Zw48j72fLRb+INca3yn5UgsRqBrH7T4XD0q85r2?=
 =?us-ascii?Q?tg1POsUilXLnJsXc8yu1ENAQyg6MDs85HRq3Y4WzKK4tEW9qd0JoBNHRpwFB?=
 =?us-ascii?Q?u5NKp7UmXxq9214K74DZJJQcvmkVJJa85Se9nf+UeNPCLxA+Pv64CWDBM3WX?=
 =?us-ascii?Q?6m5GiF271SwqohqSwoBgV/ORmdO1Ix4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7e009d-2726-466d-2c0a-08de6332968d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8439.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:43:26.2757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZjuJw5MPfiT7EcGNgT4vLK2u0vyJ+c+yeYysfKKrIK5opcSsrrelHa2arfgsUWjF8UwSHFqetngNoxLQbd0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7267
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

From: Niko Mauno <niko.mauno@vaisala.com>

Use predefined bit masks in operations where only the magic half or
only the count half of the 32-bit value are processed.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount.c         | 12 ++++++------
 drivers/bootcount/bootcount_at91.c    |  7 ++++---
 drivers/bootcount/bootcount_davinci.c |  6 +++---
 include/bootcount.h                   |  5 +++++
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/bootcount/bootcount.c b/drivers/bootcount/bootcount.c
index 343b8a34414..454e50591df 100644
--- a/drivers/bootcount/bootcount.c
+++ b/drivers/bootcount/bootcount.c
@@ -19,7 +19,7 @@ __weak void bootcount_store(ulong a)
 	uintptr_t flush_end;
 
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
-	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | a);
+	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | a);
 
 	flush_end = roundup(CONFIG_SYS_BOOTCOUNT_ADDR + 4,
 			    CONFIG_SYS_CACHELINE_SIZE);
@@ -40,10 +40,10 @@ __weak ulong bootcount_load(void)
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
 	u32 tmp = raw_bootcount_load(reg);
 
-	if ((tmp & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((tmp & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return (tmp & 0x0000ffff);
+		return (tmp & BOOTCOUNT_COUNT_MASK);
 #else
 	if (raw_bootcount_load(reg + 4) != CONFIG_SYS_BOOTCOUNT_MAGIC)
 		return 0;
@@ -74,10 +74,10 @@ static int bootcount_mem_get(struct udevice *dev, u32 *a)
 	if (priv->singleword) {
 		u32 tmp = raw_bootcount_load(reg);
 
-		if ((tmp & 0xffff0000) != (magic & 0xffff0000))
+		if ((tmp & BOOTCOUNT_MAGIC_MASK) != (magic & BOOTCOUNT_MAGIC_MASK))
 			return -ENODEV;
 
-		*a = (tmp & 0x0000ffff);
+		*a = (tmp & BOOTCOUNT_COUNT_MASK);
 	} else {
 		if (raw_bootcount_load(reg + 4) != magic)
 			return -ENODEV;
@@ -98,7 +98,7 @@ static int bootcount_mem_set(struct udevice *dev, const u32 a)
 	uintptr_t flush_end;
 
 	if (priv->singleword) {
-		raw_bootcount_store(reg, (magic & 0xffff0000) | a);
+		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK) | a);
 		flush_end = roundup(priv->base + 4,
 				    CONFIG_SYS_CACHELINE_SIZE);
 	} else {
diff --git a/drivers/bootcount/bootcount_at91.c b/drivers/bootcount/bootcount_at91.c
index 1a06db1fb74..1322abe921e 100644
--- a/drivers/bootcount/bootcount_at91.c
+++ b/drivers/bootcount/bootcount_at91.c
@@ -3,6 +3,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_gpbr.h>
+#include <bootcount.h>
 
 /*
  * We combine the CONFIG_SYS_BOOTCOUNT_MAGIC and bootcount in one 32-bit
@@ -13,7 +14,7 @@ void bootcount_store(ulong a)
 {
 	at91_gpbr_t *gpbr = (at91_gpbr_t *) ATMEL_BASE_GPBR;
 
-	writel((CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | (a & 0x0000ffff),
+	writel((CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | (a & BOOTCOUNT_COUNT_MASK),
 	       &gpbr->reg[AT91_GPBR_INDEX_BOOTCOUNT]);
 }
 
@@ -22,8 +23,8 @@ ulong bootcount_load(void)
 	at91_gpbr_t *gpbr = (at91_gpbr_t *) ATMEL_BASE_GPBR;
 
 	ulong val = readl(&gpbr->reg[AT91_GPBR_INDEX_BOOTCOUNT]);
-	if ((val & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((val & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return val & 0x0000ffff;
+		return val & BOOTCOUNT_COUNT_MASK;
 }
diff --git a/drivers/bootcount/bootcount_davinci.c b/drivers/bootcount/bootcount_davinci.c
index 6326957d7b0..a03d160a4cd 100644
--- a/drivers/bootcount/bootcount_davinci.c
+++ b/drivers/bootcount/bootcount_davinci.c
@@ -24,7 +24,7 @@ void bootcount_store(ulong a)
 	writel(RTC_KICK0R_WE, &reg->kick0r);
 	writel(RTC_KICK1R_WE, &reg->kick1r);
 	raw_bootcount_store(&reg->scratch2,
-		(CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000) | (a & 0x0000ffff));
+		(CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | (a & BOOTCOUNT_COUNT_MASK));
 }
 
 ulong bootcount_load(void)
@@ -34,8 +34,8 @@ ulong bootcount_load(void)
 		(struct davinci_rtc *)CONFIG_SYS_BOOTCOUNT_ADDR;
 
 	val = raw_bootcount_load(&reg->scratch2);
-	if ((val & 0xffff0000) != (CONFIG_SYS_BOOTCOUNT_MAGIC & 0xffff0000))
+	if ((val & BOOTCOUNT_MAGIC_MASK) != (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK))
 		return 0;
 	else
-		return val & 0x0000ffff;
+		return val & BOOTCOUNT_COUNT_MASK;
 }
diff --git a/include/bootcount.h b/include/bootcount.h
index 847c0f02d98..86474569d36 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/byteorder.h>
 #include <env.h>
+#include <linux/bitops.h>
 
 #ifdef CONFIG_DM_BOOTCOUNT
 
@@ -59,6 +60,10 @@ int dm_bootcount_set(struct udevice *dev, u32 bootcount);
 
 #endif
 
+/* Bit masks for magic and count parts in single word scheme */
+#define BOOTCOUNT_MAGIC_MASK	GENMASK(31, 16)
+#define BOOTCOUNT_COUNT_MASK	GENMASK(15, 0)
+
 /** bootcount_store() - store the current bootcount */
 void bootcount_store(ulong);
 
-- 
2.47.3

