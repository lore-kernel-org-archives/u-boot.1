Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7399FD33990
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF50890FC;
	Mon, 28 Oct 2024 16:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="15JVYXXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AF789098; Mon, 28 Oct 2024 16:23:46 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7269D890DF
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS7+3ckHDfE0QsAYc2TMc0QBCkOeWHwvN95+LTauB+e5Y8qT92KE1yYI4XS4uu21D8CsvXrncRGLsyFwbXajX4kgsQka4ZWihvTcwy81eaekWPqEOyU3KAqhwzgHJK+pxy8vW9ShRJ9ZzQVPDz9ztlLmhWilhdxqTYnw6Ti9hbOid1bPl8WpO9wjcvRUHIyhZ/PFMr4uCFP5YceQ1Kv0V3jHYPwUrn54E+tDuiHUJ8FHmX/sTRXLf5V8/bJ47U47vb+m+XoQww48QbflyZQDOQmvQ1g56EHr0VLXXooEfR1wgRtfZrR7jaBGwG99vW+QGRhNUnKl1CZB9SnFroelXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLG7DRRWLAukcHmHE4YlWkdtn4FiaI/N03Vf8tz2i0I=;
 b=fjo1jTXryH2JGerJJB4/JwV9FD0cZtnCWTMS0LGZX6fklveuaeNn47+SHLC4sqaXvk+JEcmGSYpD5yiiL4FId/3t+htHQ22LQIFxJJb+/OXyeUie14Ii/fDrkclAyLU/GBLt3NHifO7xMP0fe2UIIJ295KGiCJbgPuAUqwZbZGfwYIg/leX0KicJ5dhKIngsNJgvKj9V+QhB5Jjf6/2KOWQPyO4VdJBnS4HPo8RA0eeAvCgPfG/l9YvxnyuKCWBiYfi/R2iJWZ7qExrcyKd3U+pGhHFrVjrwfhsrjICsFnHgg9prb8RfUTzTOhABct5LtuoyI3yV7Qz4TzfpcfExrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLG7DRRWLAukcHmHE4YlWkdtn4FiaI/N03Vf8tz2i0I=;
 b=15JVYXXftB3aDexVjc+RGFoCO67mMvaPS3CuTs8wjGPyDe1eUQaHMsKUQSqoZM7V4iY57ufsVIZNVXWmqpoLGtaYLVFABNDuLd3LuHPsEzppjTx9yVZnK1u4e98jUpUGbnybkl7EyUUMAI9QFmzO/+nKaR/nzd2TuCPgxhdnXFaKoAqzd1SIDiV18b+zI36lYH0cPoNfNrkFqmaF9/vFjPJLFkICxX4B699eJH4/nkdpdrPy537KirLwfbK/Mq54RJU/sI5N30oHI1eHAfRLGySVS//t75AMSFBn3RflQcnrXQDX0Lj1jRypcPN/LfCJFCE6bH/BA3OD+Njpn0oBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:23:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:23:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 1/3] cmd: mtd: add markbad command support
Date: Mon, 28 Oct 2024 18:23:32 +0300
Message-ID: <20241028152334.1814929-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43c) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 19212039-0945-41ee-986d-08dcf764820f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KnA7iR/+0kwxrFtKe/crDx9TjUNtBOpFXNJLLzUaIOWDd+zfCuRY6YUceQRd?=
 =?us-ascii?Q?W4WSlw6Y3f1E4eFMWsc6PLqPL6nK0Sdmd0Z6/FEwW0fMFVBvwmTF1+RVJ+xx?=
 =?us-ascii?Q?cm9aqi+xxUBtj+D7XzhkRHnP8a6L0yuOl9keIvj3zohWiPo5N0I3N2IDHwIk?=
 =?us-ascii?Q?ScjOyGyuwiF3b3MiA0sNun8btKTNxIse78n8586qoCHdwPlKT9dLs8C2F4eW?=
 =?us-ascii?Q?encbkQs7Nu/OoPbvfs0povpPPnrBsjEpgVEbXCE14RlyQ54wIrxLo78eOXyc?=
 =?us-ascii?Q?o1ik+BzPUhCRpZc4ZPQSAL2eiGKpyqJN3fZSilQYiEcq4XZeRqBEeiW7qDmh?=
 =?us-ascii?Q?hrbmXsFeMj3M7V88b8iYCI7w9aZL8DciNHr1oNLpA6Izm/nTle5/cUoz/38G?=
 =?us-ascii?Q?n87R1GZ0BZyLzhDic2ZpjaFXgdmPn2HsgC5HgAhpAXaK6RagpaftqRLuhyG6?=
 =?us-ascii?Q?8OCxvQaou9eryA6Q/ilpjBrKCJoLvaKPi4CRDyLaU5/rhHIiKqZ3wEgv3e8t?=
 =?us-ascii?Q?Dse5WH66gSk42WJ+myd8icxtA8eFJZ/Qsu5Ox42nuscwveEe2GBwzwLdR8zM?=
 =?us-ascii?Q?TTNj8r0LLJB8C7rDKDL7PGhwWyz2u9kSWmNGBXYoJKbzpPLQxrhRAvTgP4VA?=
 =?us-ascii?Q?CidHqG0T8djljQU0a4POJQmKZ1HgvSokfmjW1876LpRKeVwwGotJQzVQol9A?=
 =?us-ascii?Q?iPuGvB/aSCxwtNGdMyWGogGDRHrBKL2Dl17C57gp9YP9DXTwF7dWsfU8BuE0?=
 =?us-ascii?Q?bMoM/bUO6g7lcuUTxe07sFXmm2nCddwe0Ly2Jsz9vBtQn7zi0NW7v+Bpy7Fb?=
 =?us-ascii?Q?vicZ2B0jpvpPLM3mVOZWuIBEMJ/1Wh88tTwQ5usSaqYRs3FzIV6wCG2QZY4W?=
 =?us-ascii?Q?vvPxKb742g684Eq+7UlxpFA3HBayW3xoPXfAjdEWGaUmtWoh+jJphqN/umpA?=
 =?us-ascii?Q?/sCd4xrscSqcjNdGldFZciqMQX0tUOScrFDYpgkNWVaQiWVEqiDwdmyIDrKS?=
 =?us-ascii?Q?RAzRwHQDthpdv0hNu/mS8ppG2oKRr26mC0N5OTzfyKIoPGIU3ifUDYCZ4M7B?=
 =?us-ascii?Q?waqE3xHIhr3woQSOQT6zXDs0UZ0Ni8K9r5Z6BDZMh4XgzLAYROr3swpWgXqI?=
 =?us-ascii?Q?u1Px97m/cqYAc1reE6w0MONBX9erX+cTcMCRAXDN0AB4uo9qA6npH+ALMD/g?=
 =?us-ascii?Q?45AB1AuT6NQ3M3akzTWDONpYcYGhRW/5dvz3ZBS7jSOQI5tpADh/YV8lGVIc?=
 =?us-ascii?Q?15gtVEEl0zwN4zfQ3dHle8P9P+wFZtemydGSKoNYDS1nMQcqu+UMPx2CiVh2?=
 =?us-ascii?Q?OXIB2g8VBZwEvTLGHHd6eVcUhdNK09o/N+zZP7IWVZmKyG5R17b1sbrQgRus?=
 =?us-ascii?Q?pqyVfPywaVRbU1IjjZQ2PsjHXJ+a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BOAGPI1MQvIfrsoQ1AdxSVd56vOz57KbrGKIj2rIIrcTa7ImjDeL/+yDETP2?=
 =?us-ascii?Q?g0znRbd1GpuDmZbWuuN8HNNdKdB+OV7fNLcbOUQrAJqlTi9ERJbDMeyuqy4O?=
 =?us-ascii?Q?RKa1Ftr942DOTBfvkVFMl0OpNiGy1ebf9I58xYCtLQ0H25i3zP88T9uIo6kT?=
 =?us-ascii?Q?7RE/01uWNKLc/agnpQeFy9oSz7MxvjZwaopi6xJHBX5TwY0jUsP7s0Bsz18H?=
 =?us-ascii?Q?u4Jzq2oYf0ruvnf0SiigfxbPY3TOWp0gWhUV6JEoJ3/2LwHp65Y/8D9br/se?=
 =?us-ascii?Q?M0QhQBROfJQvGPDXCewN0P7VSgFGQ4sPJp43vYTGvDPmpHfcVpLLcX6yI64j?=
 =?us-ascii?Q?8edxGkBc3EFYu1m1qhQmZeLE2GhzAVUfyLD/VWoSMNRkl7brNAXUIexXd1Ce?=
 =?us-ascii?Q?s1JN5/+IZmeOmZQqaa5mxm71vsqAe/9PWwfpaHKrUh1kpX/jaacvdHv1Levu?=
 =?us-ascii?Q?9UljlTFuwcuZ0vMUXq4OT2NtlqTwfyuCYLOiaYJmzu0F1VkTsrglwvXjwN5y?=
 =?us-ascii?Q?kSfcEC+qMIS8i5HOGCiEtPdRQaZlGgfrjQnyXmnkQiQ7yyI8kKCGygAnSte7?=
 =?us-ascii?Q?BzFkZwNENlW6xi9xv9E9CKa/RRSfTZBcW/41e4P8I+YKlCSghFt9tAsJxRJc?=
 =?us-ascii?Q?1DEQPIEbS36yvJrxWHtvRPGE5mBRuWIMM2WOKW5ITc3Z4ofupWved4HPFUPJ?=
 =?us-ascii?Q?V0Ag2fLB8Whwzg23FOi1si0F5D7avCDYoD+z+0s5fEe+f3Zggq7kIyPmU5Io?=
 =?us-ascii?Q?ZeomkCQnRKHvrDTm0gmy1VCmng7PBiPl7MZg5c4B+ioEmibZ1te7P8zS+vNA?=
 =?us-ascii?Q?4uXh9ywFtBzDVFjyovzwywtHuohRechG6Tqr9lPVfgSvu1JM8TYRrWXVgLHp?=
 =?us-ascii?Q?1OkArGGAIvBKfI8godOF1REQC+o41pu4r7PED9iGoRF2YsyNQPwuZvzQzhaj?=
 =?us-ascii?Q?ue+f2xk/4uFwfaIQ3Rw+IUoww/nPT0OKAbgNTU87Mi0yjtfBU5Vv943WKD3S?=
 =?us-ascii?Q?lCjW8wxqNVYbEpSdKn4XRcvrAbbkfefTw000A+a3RQOViT+AyJtzM/aqWpST?=
 =?us-ascii?Q?nf8vyMrWV0FfjtOFlPJ8QjPuuWAJYIh6evPZTMSOMRDiqrY2giQT9oRhbCTj?=
 =?us-ascii?Q?HSooQfSypl8YkzFUh3rZAxDazjI+ogWpSx5DNTmoC/zjt31+iW0etWLKd0J/?=
 =?us-ascii?Q?EW8Hmb/NM6jGLYx7lvsmucd0AYh7YLlpX/3sD+o0k+E0ocCzlvVHF45TgHnt?=
 =?us-ascii?Q?YMUTHu4h3EzvjRNjwuU3w8TqskB+nbStEnkF3GYFRHmeiIIu/be13LEbSxE3?=
 =?us-ascii?Q?L8ViTRZaNQXAfFsjUdCRcORt6EKB4RRRiDd4mGf+85dVaNBjsA7htFDaJA0w?=
 =?us-ascii?Q?FTEu4Y7zTKtHWyFIn530OYgF8LC8MPzbJ1wQ0VsVp8VDKWhXwnOEB1vy9FGM?=
 =?us-ascii?Q?8qmagf6jVHyCsKtZrbpiLIO7s6Ml7pSMtiFzpRsNp86larYPMhymaLnsFcYZ?=
 =?us-ascii?Q?S1T825QE2Fg/emefx2iDXjrXqQydYDWroHeJZe2sP7t7/1OF2SNIPuctRS+i?=
 =?us-ascii?Q?j3mernpp334JciIlZ6M3rfp/DZQQdcm1XgaLOX1GiJgOllzxsmsLnjxF7G2g?=
 =?us-ascii?Q?ADjaFs5cCroVhgxN/nRoUyM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 19212039-0945-41ee-986d-08dcf764820f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:23:43.2695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vygHhE3DO+5Vmy7M/GejQ3zQcTfuDhALwltxH0T4HdGQcdGsIA0OdubZXCzrsOE8xbTf2JeJEjOJD6kkIJpDQJjY/CQUAZ9KqFopDPgsmls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5697
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4fba9fe6703..c2ece0a7c1f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1460,6 +1460,14 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
+	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index f178d7bea61..bf08f483c14 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -700,6 +700,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -782,6 +833,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -816,5 +870,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

