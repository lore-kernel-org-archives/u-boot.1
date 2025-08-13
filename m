Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5292CCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5124D8388E;
	Thu, 14 Aug 2025 01:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="obRokN1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A4E8383F; Thu, 14 Aug 2025 01:43:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F452838C8
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHXrvRSykCCNYZgVRVRgdSmHlbWfPfYxPi89zxbdIs4CB2GSrlWfRh4odLvFwcoCeb3eChJ+ELE7YMbi4T5/ZagcwfLdoPsZoejKhqAOaet6zZ4hp3BRoZeIx8V9Twm+B9zGKQfQPU50XjixPyAkdk1TTdoc0t7OHR5e1YSvBgnTEOuhImLa/YwYoiKxrgkGdVRkZ115yLRYW7n3uSs8nHBOVMAIO6MWhKgQu4/bUUL+OaDQix7mF9bXO1mocw0bcdaDmBY9u47DyOYPcgJps9ChCHbzHrMmwI/9jMlJlN+KpOT8OZqcsWMs5HM1Lcy2jBFcLSuBsDShX9yPvywUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3khqCqw8gvBZ/FfhzfsthtrauefsJRbB/UrV4Kean8=;
 b=ZnWeIBkjhuQf4oB1Iltxhun8dx9+Kmwo8ExAHKvC0gNFASvk+RR7yOMGbrtsxViPG5DJiSZxUgxEmMInepWrLjt0mJFzIk4lfy2cTU4B2Fohk7nT5vJb8AGwwoZscv5cRV9r2cJ7zvn2bSs2QaLEDlbSNPfaJCfWEC1f/MQvCKZtpxe5yUTdgs21oMOSi8OOUd3IRjPz3c/HqVG5joCwXuM1TBGRX6nkNzdRcqlfskJ5OZfEncFzUu9F33k+sNjfDXetZHqWoXNm1JMMsZl6qjGSffp3MTSEmkltFQXznNvmBKbPymgLkt+P98Bh5oGFp2fmmG4lbbMTWKF6zcxDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3khqCqw8gvBZ/FfhzfsthtrauefsJRbB/UrV4Kean8=;
 b=obRokN1jxshK1+3Z7ZWid2/WP+o3FTL5PCcY8L+6UxFMzc4/LxtR/mKZnWEj93irZpXSWu2KMF4hk3gZJqt7jZT3nIsLtqFpp2Gg2tbcnf0PaaIeN/5IzsXCVRRQqDOqFTASpZUZKamPwzPApFbBw68M5B+q1u41YbpB5oWiI9EXVtcw7ZwWaAo4FN8LHaWZdO+nQWOEi0iXqAjKn+wko7c8z0NXWiakzRxulzB08ULd76u5WpOxOulrOaY6CvYa1nivTEZepxqFwrfZX19W3384HkMrgJf/BWUXCHwoHaR7KGL3ZFdzJdAYKDKnSD446YwuntJkCYpZ+47H7Ky5dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:32 +0000
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
Subject: [PATCH v5 07/21] mtd: spinand: Align logic for enabling ECC to match
 Linux kernel
Date: Thu, 14 Aug 2025 02:43:00 +0300
Message-ID: <20250813234314.3945708-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 91873570-b043-4ec8-fddf-08dddac33636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a0jNGkxwuZBhsW2UA7xSojqtw3iCuoZ2sCk1L6FG96NNPJppTmFK6jDD6a/H?=
 =?us-ascii?Q?5H6IAUuQiVNCflmAboMVrX6IWi6c7P8B2LBvif91L7zzRR8+wNUGw8lho3MU?=
 =?us-ascii?Q?S1xvDVvpaYFBJQ6hYE+b1z8sKh4Xv4mm2hQlCTzDcphIt523GfzjL6J5mKZt?=
 =?us-ascii?Q?auAeJatd5EFTJkmChYHeXcon1hhNv4D4M3uEz1h5pci3XQgw+0JtzNRBOCFJ?=
 =?us-ascii?Q?QSg2cpvz5WaNQ2fod79YDCgFw+EEY2U2RFllJog9gW2zRJlSIvwG31NAfcwp?=
 =?us-ascii?Q?QshbPdpkW64+3GfHn0Bv43RGCofDiM7Fw3wZdZyRNTtb/xPL5vN+8tQVWDiW?=
 =?us-ascii?Q?toSnZ5UvEKAEyxsHS30VkS7sNHJQm5uosp8xywPKi/ZQVmA/Y2FLhgj/snQU?=
 =?us-ascii?Q?GoZNq/Lo0MsSAFRy6TNodJqLz8QgpGp4n+GgDdXD9xa0WkIcZEAQdZf+G/ur?=
 =?us-ascii?Q?jvReZ+lyzsEJQeiE+89auCJLDbolUm6i4V1jdU6zk0Di57e8WKyX2dxN7gxL?=
 =?us-ascii?Q?STPcEC+IUTRF/plMhwEXBiuMuT8V4KXd00tq1bliuDr5C1nzH29NM0xCWJs3?=
 =?us-ascii?Q?3GaOXjAvmcgsG2QRoJOMhCuYRQWLIJV6iFDqurcGAgdFjgn3YkWk+azLNHyk?=
 =?us-ascii?Q?NpbR2762BerZ/t/Ki1ZcWr7JscsegC81oPVoGmqTghI6ovlz/VTp0eNUcQ5P?=
 =?us-ascii?Q?XWj+IRxKqWhCWZMu9zDpPifzeCzYlnPsP/OsRHgMpIH2wMhsobfurmOd8b20?=
 =?us-ascii?Q?d1beFB2zvryIGq8QmS6YkkxqG5cZk35smfBg7twXxM7IQO28m5lsaB5JKl7J?=
 =?us-ascii?Q?ZJE66iPhJy01LEZ9dgCCbrrl2Rx9adgMKZIm9Vu/dl079pfkApzUpi1ahyq6?=
 =?us-ascii?Q?fEeoq947CvvSuEaKd/9px+uGtztnmUfSNAj6cvPJF1XcmctlkuSG2DlnJ4ze?=
 =?us-ascii?Q?qUAAd6dChuqGfR6FI0xq6P8pipBRKohRiPUzjgceNWqXSGIPEOVjPfzjCEHg?=
 =?us-ascii?Q?RlcTlGhJ8084JacMfI7og8aNpOuYsQBPwb0fZHcsMuBSYo5VNgViA2IBTDsd?=
 =?us-ascii?Q?4YUWbb2EYeJY3544f9KiIEPoc11UFuHIJiLtzd/lLF1BnVlCzJjwBYP3v++9?=
 =?us-ascii?Q?c90DExms1IiGZOhHENo4lpsI8uQy4QNkUj9A84ksT5dWwRRcVuvvfkqltcEt?=
 =?us-ascii?Q?gjzEWrIEnj6EqDbLkOXROA3v9qLml+tUfUjmpesoLlvMWJ/Jybd3ztr28sRs?=
 =?us-ascii?Q?GJdO6stDVMpwdAQuIqPY3OW0dhkyzqnnm8yLrSQ9D3IZG9eE88ZQO4/TGVH3?=
 =?us-ascii?Q?Z0CzyQyAdRZ8OMS7Umb3LXUrIF8Q3qF6KQFdq60cW6/8cwZ6AXh75j7eeKel?=
 =?us-ascii?Q?6+3/Pvn+0j8Mv7Pd6v5fjS1KG7TUhZt6xZUTBw7K+XAYz2Ggl9QKIM5p5GTx?=
 =?us-ascii?Q?H4EL0TffqNrWJ0BR5SE5i37wR15OP9plMfiG3IKSDJsXm7BZXRdL1yUsHgqP?=
 =?us-ascii?Q?sy8/tHxFXrNp09Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDQ4Hdq3PCONVcSOwSpg5m4s6GbDubz31u2S4O5OnIXPDAos2nzkukXwil9L?=
 =?us-ascii?Q?38phDBZ9135Yq9BLFz1Vl+3PyZvsD0B4MblaFcYGAuo0+25qq2XwRWXlUIqx?=
 =?us-ascii?Q?JE8eRTalf3A7PnT1muhaumExUMwO6eALwlx2nxv+uv8d2U8/F+8bb2a3Gy2J?=
 =?us-ascii?Q?dr5YiylA29Gh5eu9mDyAj6fr0EhacaGrCr9qmOl4ioSfDF/G+ORY6Oku4fqf?=
 =?us-ascii?Q?Ucj0I8x+ti08XwtY3aSbzYoQ01Hb5r6CEAWFUDUG0wejsghClcEdwsLRtQsL?=
 =?us-ascii?Q?bRMEzDxtNwNMAPsy5mPuDaNOQ0XCmIGDb46y/BVVaaCoCKnw4ItFj9jCQusC?=
 =?us-ascii?Q?St8xMZ9YrmW45pxZjL8JInbTAZOqyMQ8cAvULcKXmt29H+RaFDKNWTCuogtR?=
 =?us-ascii?Q?zcKgce0DetWbcdYbkTcoaM+Pi2WB/q1zdbBgFpkKDi0LeG1n2aGv00kkwvOO?=
 =?us-ascii?Q?LFsIb7b2g4yLmNrmpinb8KbsLuUx15odmqSOCs1QHodt+azzF3cfVwEARsgd?=
 =?us-ascii?Q?Bu/ysBLOpiNvFPi1Dv4mI1Epe2Yc8PuGmXPZ5K7+kFlT0gfK7H091h1EcAWa?=
 =?us-ascii?Q?NVkaL6GRSsyFfIkbVDlb5fJyAahD+gCkkBTAoU56jz7BgPp6DMoFiQubGKdj?=
 =?us-ascii?Q?Vxo6yoUdDJqwmPXKcCKUnWpLRhiOC8djR7hyvSqA6ED0XnrICsoBD1F5GFNa?=
 =?us-ascii?Q?az4hRNA5vTEZVQeKDfS4sHc5xBAEGePPfCog0jLOaByyM8D0nlDqlmtjbl9+?=
 =?us-ascii?Q?2E6YmFdocgyrpYp5jH7GpPo7NEH41HWcOKSFg9cKYimHHiOEnwVwEQxLO9Bc?=
 =?us-ascii?Q?Q772Vvt+7JSNoOu410Ez/IqpTcAF5RZLtrVxh9/83wR04/3IjWVrYJxCvgNk?=
 =?us-ascii?Q?YOlSCH12oYfpybNG2yXB2XdMx0yiGNhGk02zt5cbAfK//f2/3fImQ3ugk++R?=
 =?us-ascii?Q?kLquiIHoTIFWWaJJit+Ak/5YgZtri6V7vzVbZoRAJyKGg5/XTG9LerOBDYsp?=
 =?us-ascii?Q?ogOQ1lvaKZ/1zGSTYR9K0jMhcpIhNRKAZ0gJKFGmZJcZcuZ/nu+TJUGWPaP+?=
 =?us-ascii?Q?dHouno83eTefWmGu6ax+afEMfesa+efK5PIYBL6U7mUQkPn9DHCwQeduvdFI?=
 =?us-ascii?Q?qgkGY0pOjfNYgKhsUyPp4uI/GhopP0WdVk4jn7UZJxOyn9ZOPlAzPw+zrwfA?=
 =?us-ascii?Q?wXCGZlrMzhg5n1Th1+HMM7PDr8JQuXPIh9/+2+u12rqIUxLljkoCKbGqUiVh?=
 =?us-ascii?Q?mrQb8cHZRsayvjmBd5WCLC0M666J7hSun1jUV+21nw9rwLEdtkmarw7302P+?=
 =?us-ascii?Q?iJoM55R0GzMKbAUkQSTulKc9piRjjVTcsgK9wWDQ4sAiFPmq6m/nCHjb3Byw?=
 =?us-ascii?Q?UgBQufHWaXNlGerVMaVxPDcpwlhSjIg3oQSkJftObF3SqzUcY4Ikv/SGCMEg?=
 =?us-ascii?Q?38DN1jSoHKjCUp+N6EwuhRaJuwXaWw9VnlHU1To0L1/gZu3M7cKfwlIlyCKk?=
 =?us-ascii?Q?RKtuxmg8F76fLDQyQsWVagDHQ+mzAKG5qNT1GR98v0qHley7H0rMVvmxEIef?=
 =?us-ascii?Q?UbYPa0bW3X3mhBzYU13400MCpjDjTVlJhcCbD49PLSdgTUrQJ5g+U73CKuPe?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 91873570-b043-4ec8-fddf-08dddac33636
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:32.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozj1ATuGa6QsfN9bII65bZr6hKbcwbz3GQUyc6pFOzVoquSV1M/wnH4upU9iEhXKS54ZUr4O9lcpB5Wrx9AqCg6CjbFsUtr2pyWgn7JRkZc=
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

This aligns the logic to match the Linux kernel implementation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4e8d7444bd6..6d80b7c6d30 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -542,12 +542,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -555,15 +555,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -595,11 +598,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -607,11 +610,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.50.1

