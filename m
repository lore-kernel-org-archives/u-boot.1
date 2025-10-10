Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6DCCD18C
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E905C83FB0;
	Fri, 10 Oct 2025 13:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="s3AzkWpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30CB84207; Fri, 10 Oct 2025 13:58:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E6F8422D
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAVMaW+2yOb5vG2v5zaTxIakfPy8HEnIBpqQ+Nb/7/fDzfqlya2q8RIaASHavd7evJgxZEk32P0HD0QdMEKdf9DNsaVkJHth+mAmBquuu/+VCL/PzT2dVVUq79NPAbu7aBuFY2E+I5A/EDs331o/S1RG1LWWagkdenGx7CeWK0jDBbamfX3DrMvrtGNhan8D8QpcJv1gdclyzFm1n6LtcZeKl56ODz5ngMSvQ4iS4IO/ouaYJvi6md29qWo4VJiT3nigYinzdWwPgMSbYRRBdhPgzEyqNryJhhEiNRZ8RlC3n+PGA0jUcjJAfJhOhSlgF2LsW30JwHZlhrgbhcOylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoEMVbydULZa5Sk3AFgf6+P20WiQm9j3KRU3HNSDjrI=;
 b=QTrUqdn43FkPlNez1Bd1+uJuP0j0k9EuERGOi/TO2F9+hP8f2MCnQeabMR5wg5DHqBUNmbFHLmGc4TLJorGdtPfHeHO0QeyvwUdKo3WcWgHnqgyZrtNqF46CpEGGygIzR6wv64xAKSyFifCGEeCznNXrP2r3mGw7hNwg+WZGSTUBRBuTiqaXILhfdaiRxux6PIzKL5FEK0vKr+hzmxwxYiAp/IMfJt6Jjp0YFAB7eKbJo+DQoF+FNZx56bYL2kBkCcPhy7tnAgjeQSp3h5B2o2JMAvgxHpv3NM4jNa/moSV6F+Fe0fPA0tvOtSazo0rLzLfM5jNbL4vpSvbqFUl/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoEMVbydULZa5Sk3AFgf6+P20WiQm9j3KRU3HNSDjrI=;
 b=s3AzkWpUHzT+Vx1O8AL7DxHjax32GwrAgHLm4w7abxss3AAk+q6e2VrFDnzpy+dLPduEyVP3p+CcaH5NsXfObGG8jYKjdN0zL5DFq/pa2Tq9L6Es9F0un0R2PJAvd1Bh4dMX/StU/KxU5fdUR5GP4IQ0TlsxeyEXsiKzs/G2JtdY7qErOPOxf2rY9BeWq37f3YmUUQJFkkHlq517CWbRWzNmAFtkX9WVHqu8zIoMdbe/pDKGRBq+Q7jLOPM5GUThnofWXIhrvIWKEOH9P4edfy0tOdPlHCxKmOjJcHAWoaBIjKe0Rgwyg23kr6b1dx2U8bklX69Cf6UUdkHDuCvhoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:50 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 12/24] mtd: spinand: Add support for setting plane
 select bits
Date: Fri, 10 Oct 2025 14:58:13 +0300
Message-ID: <20251010115825.1531775-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 5373f8a8-12e7-4612-d301-08de07f4602f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l06HRrsf/FMXp87C1ihhh0vHx9lQPsdmrkxXkaZ9Rzv41HXnAEqS+TKfe3Gf?=
 =?us-ascii?Q?Qvs1woo3Q/XQn/7Uwodzym4d36XPccPOkzi8QVYC5T8QTSz1so/ghc9CP5xa?=
 =?us-ascii?Q?DOXqVHvfK8wItF1MTLMWYLuMUmkJgy6Gdlc+8BVxAohYLdKRyZMrdSI7zjUg?=
 =?us-ascii?Q?8EsGyObFJgYK3Z9lnq09j1OgNNBbSl1MhwzQwBzjQyrVOpqY2PDrHljCUYSC?=
 =?us-ascii?Q?sXm92naV3Xkm5fQJ7eYO4frLxFWIAtLikI4YUAuGkng5iPVn0KHubRTgLC0X?=
 =?us-ascii?Q?KJOcfLFVBonUumqB+BCk2ZjbRfYPWZnB264vd7/EvNXH3Lhyy2pIQg0ifkU8?=
 =?us-ascii?Q?wXySimcV9AIpmR4hsj6BUD4O7UePF+qeFRZKzBf+C3tO3szt1onmo0EWsxcM?=
 =?us-ascii?Q?jVMSoS0xACZPg8N/KQDdj1fIe7Rbm48bfgXYh1gb/2diSz+NY4f4kzVVGv+E?=
 =?us-ascii?Q?22cJ5LDsO3PZBzca+EMYQ5N18jEVTyX82K93mpxOuypaUQ8/MYjAzwC6miX1?=
 =?us-ascii?Q?QAuht6HFXStWfjYt4c1Zjt7kmRhOMkdcZyHVcgHCR2OGGRx8u2GeJ+NnNew2?=
 =?us-ascii?Q?OlQZg/48mrteECU+F5i73qpNlrs6H7Zpkx/7a8cdkPq0aCdr5qokQozykrzY?=
 =?us-ascii?Q?fl9Qe9hRhnNL/D0iMsm/D9wCJgdg0qsPBEou+wWB94LkxXfp5vKXr5HCTmTe?=
 =?us-ascii?Q?ze2IDFixMA8zaeT7/2RqZTq3/jL8q5bbRAy9pRA9wIoSmCK0pCzCS8EB1Lzr?=
 =?us-ascii?Q?7W/E2SE2rMijZxwhFnMeW6/0gdxZBipNwGoQq6bcDHU5USAu2U46n1FwfZIp?=
 =?us-ascii?Q?gW8g4t18oXuQMbZo2PxGXavpJKS8fBnAXh6289PJxM0z1Ok3mVwVtMV375+p?=
 =?us-ascii?Q?BfcdpFZrJoee6Jr5XdRtOzZkk4K8+oxewnZlbXpCWONkNvXQ+dXixc0t68HK?=
 =?us-ascii?Q?m9iz+QgbpsM0MUTpQIkRGepkwITi4IIYroImgwSLcf4+v9YueiJmYYawC4gY?=
 =?us-ascii?Q?pV9czZ/6CjKvFVvWIN+DZu820eVNrYX97oEI+g60T6xYxybvGcJJptmNt5iI?=
 =?us-ascii?Q?/mhsjCdn2C9scBInuSL2kLEVmU1pq1cDF6xs0WtIzzqDZrIv0NeKD7Wq0PxL?=
 =?us-ascii?Q?KQkLZLRQqf4mFLU/0i1rPD/VyetqRU5pgUZ0X+kFsvkAugyK3Czxoq+HFfKE?=
 =?us-ascii?Q?Oq8JYSCk9cdJUMunUe1DiWhZW55ECfhzsvtQNCAPp8YGwTUlWBFR1lIf2aOO?=
 =?us-ascii?Q?8RR8F6NpKSnQ1brxVccw54Bk7gP6Q3sx49TK4v68BhsV7A5A0LTm3299prZi?=
 =?us-ascii?Q?GtRrl1nqg61vPzHtnNwOOYYX20m6tWSvrJiYwScquYvFaTWo7OuN1HUNk3mo?=
 =?us-ascii?Q?52zJvploN5z04cmDv4c0wBVlPTMKygXHAgPQarswaN0X/OnQbxmhBhFUimq+?=
 =?us-ascii?Q?3I9mAKG8TldGtz256MxJmbB4/h+b7zx10s7zI30PsnDmJRpg4tGcqv3xQExe?=
 =?us-ascii?Q?IL1nHVTmuNbZiXuLJqaOXpZnnDRcJJJlXjyEJhwzreQSI9pLNkTavheHEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IP55bAhZ+dqgjJP/SwB1jZEnA8F08xSNO9sZmkjDSVudQbbmErou2GLJQe3R?=
 =?us-ascii?Q?bDTZRf4EpheyAzOMNHxegy292uVnRGhj+CK9QQy5XFVw3O2SxqiWN108abdS?=
 =?us-ascii?Q?CXP38YQhc2JsOARIkyymODtL9dfc+NILmCe0XJ4CxlEU0/ur6h/6QmlGtnaw?=
 =?us-ascii?Q?EHvShgRlpLnD+qr3HWS2zcwMWdrqN6n0PnPgS32JeEwkbL2AnkIo1BzAOzR9?=
 =?us-ascii?Q?awn/zxaoG8kAtN6w7/yvPt90CbpLQn2LWNgMq5+4F9EGf2nzwC1GjeTb2rjM?=
 =?us-ascii?Q?IGA/3RkmTgczSa0jtXA3JNDDM2MjVXpUeXXMaXOZQQmS3AV+wmADlbmo0s0q?=
 =?us-ascii?Q?3JOuSqLGFqh6VEUGhgs2zupJYz8fdhwday4MeA1ePywsCP4dOFiQWcGDeA79?=
 =?us-ascii?Q?mdoUQHaqMo25t8XdQErwzz8JRG6mmJVkx0XIkD5v7R/k3yAg5LYoBnaxRIGD?=
 =?us-ascii?Q?yaBMGFpRsPwWZOyPwPedcA1jxcUPqkJiwoLxiZEaVPnDDKobuD89GiNLyx6y?=
 =?us-ascii?Q?mq6P7XClcmRoPGuxOYEI8tQ7TNXCC+dW1zkhW1iPYCWHRu9QhLlRrOSZqN5k?=
 =?us-ascii?Q?44krAaQyeAUq6ZVK+fXLL3MXlWaYWif5HH5OtpSzqb4O+tg28lboYKSgKSzL?=
 =?us-ascii?Q?NQz903kvuzDWpf1+LH7/0g4UYE7OZxaLOX3jLdSr0EDkDd/M+Il4IA8rmfsP?=
 =?us-ascii?Q?pwaXDQuI6B6380C8CHeAw0ttk0826o5GY3ILr5aOaWPjlj9m2J3Q286ioTT0?=
 =?us-ascii?Q?0eanzgYpm3PLP9qkWZN8rCm0o061GNIfh0OaRgJojR3dbH3T6zb3tetvjRP0?=
 =?us-ascii?Q?M1TNkO63jfd0P53Oowq0B4WGTPo855ix2Si8Hy8rMDudHJv9LJljc6WM0p3B?=
 =?us-ascii?Q?PJTAN6GBTekK/IHtuBsMLiYAgKfo5KVHUTz9AveJkNltyoOqPYOoB9PkfQA5?=
 =?us-ascii?Q?Sxm5BAnERkflOXqDbnRJRv9eDWoPKiv5yft9IBvmhKcfN7pkSP+AFA+6gh3M?=
 =?us-ascii?Q?4VSpq/8DPq6wig7GaxaQmN4q+zuE4dmpeJP2Rhl/7tQQA8P6axZkEyqHXLz6?=
 =?us-ascii?Q?1FOQ0B2JI67tLlRo5jfC0iX9ntfgTj5y0RPHBWpQmofm1Zw88c1t1pzEf2mo?=
 =?us-ascii?Q?7Imfs+7WIU8f4MNKIG7iVebcbTMQCnNQcyyGp/9u2NY4RON9Of8V2thrqBUf?=
 =?us-ascii?Q?viaDQzB0TU26nGtuQFnEFI/cuiG6UzSeEYUDKdhSjVQMDuyVn7g+se3xWvFW?=
 =?us-ascii?Q?STJCMSHLctu6zmxPOlOkGUcpGJgqK6+Eb3iIxfyMewOhUn7vfJ0sj2L4ZsGG?=
 =?us-ascii?Q?VKNpSRwkcXA5Zh4VrfeqpMbOJCnizDz4pWS+v+lblli9VsopbyGn9LGQaAEW?=
 =?us-ascii?Q?+VwsdWG4Iaz8sP4f4+SY1qsS5OQQT/WrIrLouA7qZHI6yDTCMXsrXuM980Ws?=
 =?us-ascii?Q?Y7LrADPV2PJH73u4HDO6s1KWtbYLCWYQGxsICLJ6IUlirKyFNKAk2vfA4y+w?=
 =?us-ascii?Q?Y5ZU5F5IYVOoVHWOrt2k96Kr2YHhmX6q/299WgqIpf3ADH+CEBRFsYIBtYTc?=
 =?us-ascii?Q?CkL2tOJPZqQCSg5V3vPcosZpz6GPoWNeT/BsINt9gYoes0dw7JLVeS2fabyO?=
 =?us-ascii?Q?y2Q+nndTXbWq5rkpZZzqdxo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5373f8a8-12e7-4612-d301-08de07f4602f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:50.2006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6CybeAy0zOsdjq39FqZfS4Ub1EeTX08Cok9AuiLv0pX7UW68xqmMJrSNiexjQGFF/+slXJpXGTwhhecH9VQMpZlFqJ9GNPGR/Xm9YMyi2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

This is a port of linux commit
ca229bdbef29 (mtd: spinand: Add support for setting plane select bits)

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240909092643.2434479-2-linchengming884@gmail.com
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2a2ab664c2c..2083e3673cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.51.0

