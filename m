Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94453CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA41782D21;
	Mon, 18 Aug 2025 12:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2QP8Ui9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E3B80FA8; Mon, 18 Aug 2025 12:06:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 412D880194
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x54qvDs5tBIS2afs9qu+Q3AX48Bms0ECrwqGULMMpTlfC7CPq+OH/hvBWNmnJqx0eSHPwmYiehsgYhAPhqRQN9dSIcTA9UzjVIdNFepeW/s6O03Dv+HvpndQtu3nT5netlrV7crZFSrxcVEU5zotIVWPwpkrJ8tBpBXmrMou5rbJmt9HOL526G+L5JTODNB4wuVv0a20h7/iyHbpH3y60cLjzP2k8X+1QICBfl0BqaXSdPhE++PyhOYifeK4kBL+XaxIk05BhmPl7l0MgC3KSwfrYcR+Rd9aSYpI5uAKxVWH2nHFXHZWZrFcUks/6rNhFf4ciKOFRa/oFUbYj5IvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3khqCqw8gvBZ/FfhzfsthtrauefsJRbB/UrV4Kean8=;
 b=RSrUYzUeQ4gc5J6tGxT/0NbeKs0A33RH56MIYr8p3hIZzp8IBh7jqp41HrWz/L0oKdIvSyyvTuLtCBJqUb61yX+/3HMV5qhCz3FLYZta+fUS5/fbl8noI1WPmaDIkzGQHnUKXzMBwigJxjzoz/at3Yebrdj45ufB3je6mpVuzd+OPIKBKlQfGtUYFtcWJ9pRzIFyQn72Cb9RncdpTg5+wipNeVQIIcD3cKlQYbdDyujw270Cg3aeikx6KQc/xgs0fJEMwtiMXiP2YDA1DQKAsWfk+jN9j+sI3noIs7OsYZyBeb5RTjFVIXS12o3DC6ZcX9OYIgFdVPLynDb4KkSSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3khqCqw8gvBZ/FfhzfsthtrauefsJRbB/UrV4Kean8=;
 b=2QP8Ui9NkBF5SiLgBow9sUufIl7i9UUnscfaKmKfm/WqcaTm/a1SNBMUzCXBJQ/5ha9tjYCNOEI+gQhJ4gtVaAJJfCLDpQ8jN2czRHXFK/6Woy61YKK/MCviLhgi/gttZhTsXhSl4sPz77mXC7r4g18Zp45sy5XRYXyoqOxcF4xogIdiqmB46Sg1q9/0FwClbaTWK2rVWc7CsgS/FngbVXFd7fSgg02/FE2ng2NtcjzbHnCTZjR4G1jEengt2KxhMt0rgns89wxe6Ds6cKIWc3nE+Gek5zlsFyHnvJ8EQGlNmNjD5TpFeT+YIBJyXdeQz9XzJNBMuvhintKgxCQh5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 07/21] mtd: spinand: Align logic for enabling ECC to match
 Linux kernel
Date: Mon, 18 Aug 2025 13:05:59 +0300
Message-ID: <20250818100614.432931-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a76cf58-1b65-4a86-be8d-08ddde3ee981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hYHPyIWgfAo6IKD5d3JAi9gOD1ZTl2qHqcAZrrRnYnu4W4rQ9pFeSvfTUHUo?=
 =?us-ascii?Q?ZobH2PbKMJMJwtpq9mp3hkc6ZMrCrz+USecFqCxNDgUOIhrOSmoaZjO9iZdE?=
 =?us-ascii?Q?nE9dC9FK3ZuKUyz7OXphYjpI01kwSJ/pVXfazyHnELaRBnmfe51eLsh820IJ?=
 =?us-ascii?Q?q+ztmK/4mIctzFN0va8g6P3eyJkafQ6VkfzO4fGgY00tmfPJPGEe3oGoQTzS?=
 =?us-ascii?Q?BIlrPVohamGVPSybMc0kH/XXTk/1EnIn+FEnfAX/xIILmOQU72P87zB1CJzq?=
 =?us-ascii?Q?+nX1ZpKh09vLNqXcqS4lyYyFH0dTMN07wh/B/RmLVNjJPRw9z+oY1lxDkQLs?=
 =?us-ascii?Q?WxvRVjPzvfx/CE6Yrd+J1Qh0ayJxoN1Kqr0jHLc5T2Xw578AEnaKkfhi5jK+?=
 =?us-ascii?Q?uAfriEogGiZ+N8uvY3EZUkS+jCnCP5RxN2BAADMAkjBEDhueSq/F2xMOwz8s?=
 =?us-ascii?Q?tVBvsYdrzbXguvPcENqR0e/ORWS48JO2uCpN+bnhIrYuwh7Q2H3U+vW0kVJf?=
 =?us-ascii?Q?xNOnat8bEo+uRHqL5EE71v3TmsaSLpW+fOjyW6/aURoSL95Tpdl/PYuwIWKS?=
 =?us-ascii?Q?nbd10G5JCk0JbveYMo7Vfa+k//TTchofFU8/XyEiHx3AaSGXF1eH0TsNgLDk?=
 =?us-ascii?Q?ShOwG16i+YqOAz0VAo+rkJ4CLQhvw7h4KEZwTcSst+Tg3bmPr0+mM2Hc6atp?=
 =?us-ascii?Q?sqDovUbPEtWTVOgmUJBQRuvjYO2kqB6y/9qd7aC1WLYuin99Qp7dTLMjDCeH?=
 =?us-ascii?Q?ZFhs5uGoP7oG8SLhpWR0Y3qlPyHQzcvmLmKe5OMKNyy3El3eb3e+fUHZX0X6?=
 =?us-ascii?Q?mkm8tg5KF0d+5Odb9qqQdgRXJAO4G1mtd4dBuHwAVZ60izJ9qtoAzqKXW5cT?=
 =?us-ascii?Q?+9AWszkjcysZiKIuvTIEEikqJ+Lq2u4vHVyFMYv+6RKTohgGbTLvA9sP8zui?=
 =?us-ascii?Q?gk+2XiHgyzFyjBJv6ZKxG+/LMkAhYiOjB1kd+Wr39gg6oWrElqnXBRkTq41I?=
 =?us-ascii?Q?he8psJ7y+tfulnpOBye5u08F73fw5bi+5B0uZ0kltw0cQ7fIbimfnc1Kkb7l?=
 =?us-ascii?Q?1jwKvETQSlGKxbFYJm4WSv5xMejjdv+yXu9DrktQzocqmzXaQrya4ipl2B5O?=
 =?us-ascii?Q?VF0X74U9gvwKruZHvIgdJg5zX36kce7o/Clpqhq6MAIKLy+U3A99clG8oRjQ?=
 =?us-ascii?Q?QmitUMvi3zsZc3tnk9swg2CB8pDZKQXgynYDpypE3KvCprz9PhDEqhPDZ3pN?=
 =?us-ascii?Q?2RGVkIBcyPD4rV7YZF4sCHdWEXozwD3LUWQ2F/Q+Z+tPIvFaB2fTT0OkgSrE?=
 =?us-ascii?Q?LE1g9tRqtLWtSltHa9hC+tqUQN3DP9UqrZPVLDAeLMxuBFA/WcjGgyJHeEro?=
 =?us-ascii?Q?k7t4WzQV8f9esx5EyG4XAoR1TG1034MPNbrHzHPUNDnkaEJaGf+T8tFT/nxk?=
 =?us-ascii?Q?TzJjsHbryum3emriNW3R8O800vGuhqNoUwieIrxXSZH+p8Egcym1r+UowJqi?=
 =?us-ascii?Q?uOM7WrI6Jp+GfY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7oSC9i4A79BnBL4eOmps0/SrhnkY6+vGv9KdfuK0csyjrrquQdVVsORt3Nb?=
 =?us-ascii?Q?sZ8Rqqn2atfE8CmVxsNslAgUXwYVKpS0OOHYLTX7rSaunwZp+9AYUH7c1NUE?=
 =?us-ascii?Q?EcMJyy/GuIP80gWgIfzmeqGxJLuh3mLeDjiGclQnMBTuydz2iRTubErP0tOr?=
 =?us-ascii?Q?zRz9nYD/qYVRNDqtkf+0EAMpSKLFiYo3ggBEEBksgM/6bxdyISjHbGFdX7Ox?=
 =?us-ascii?Q?nucd48k2qvVmMDcJYR2bHyhbBURR9qjBMH64nkKPm3FDvK7SKRB4O9Q8Bcke?=
 =?us-ascii?Q?8T312qBGFFdg9FTy0aX30kJH6veIM2qLcKHhiy+C0GrhkqC3qi1r55fcFWOy?=
 =?us-ascii?Q?w23SPHcKeLsc7AcxoKRAl4VqrdejKFhTxv6+FKoKbg/z7/wN6sATLNdXT9X5?=
 =?us-ascii?Q?jRFxKfxWYG1r93d2Mj6NIeogFDmO+vs2XQ3XZPe8R9kVMbDH1erjzhHGeNSM?=
 =?us-ascii?Q?0Rb1SEis5gvLcPLSKoUp7VKX2FAVKEinQEh/ECFbKYKZPZYLfZu0GmNwo2/X?=
 =?us-ascii?Q?ZBbQed5EWu50axZ6chVVXgWhtfm63CQeNljz0YJKvKPW7G0zmpDX3yWuo7AK?=
 =?us-ascii?Q?1YbU/dxut0fgtrVqfVW++u7g+TyDmBvgvxl8qqagjy05CCSvCXj576QQ7PJn?=
 =?us-ascii?Q?jK2/SUHEPcCSELTgr3pxrbN+zzDixhzxEigC2Ff/0RUPQahKcZAaX1UXcAu0?=
 =?us-ascii?Q?1jpU5qbudqpt+xn570w+XNv72Ic1se0TE89tyIUmLJWZHhdvlWVeI6kxoEze?=
 =?us-ascii?Q?sknsLf9Q9B+XSj0LLedKXwjESHtiARBdtX5/8b6u+wfsaFYldpcT8kdHVveF?=
 =?us-ascii?Q?y66Vd8ZHD8QGH6mi0V3ERnk5y/BPNq+1DQNXyfetcXXIYG/KYX9eaf3cebjp?=
 =?us-ascii?Q?1eMyjCW7gc1OSAaVeIJZgzuVi9u//cBB9h1W05OiHWG7fwh2rkw4W02uLRMT?=
 =?us-ascii?Q?Po4TIxzWmnnspLxlGW8Z8mr8H2M1tC0pxrfIoK7piRFrt6/eIaiAGBf3ZBZC?=
 =?us-ascii?Q?0hHW/6kvgFECr3R7Vl8m4qRkG4h3dBMHQX7Ts53xKLtywDxcW9Q2XRtLGAS/?=
 =?us-ascii?Q?nrdAT9NiDUautGIGxCOYFrQX8UoiZwfocgSYm6K/skhkp6KGL70BRiIBWMLX?=
 =?us-ascii?Q?mdz3lLGP4Z7T8y5T2LsT8N5vpHbIV9GBX+0n7ejHKqJuwo6qs0PVzWc4sIec?=
 =?us-ascii?Q?hWF8/UyvVx52FIjGpzA+AG/pukm1djwdPYZLBhrDuSk3+tox5k732qfUZhxP?=
 =?us-ascii?Q?X3c28chpzK0nzI0SNGAE2ImWL80megNejV8IKXRLgcPXtLli5J78iHdUYjX2?=
 =?us-ascii?Q?FEt9gIbIIjCATY9xeZdx2ivgZbgmqyLpW/XzzRni7KRznFnH72Zg2qgbWecs?=
 =?us-ascii?Q?9PPv+Lof7MiaJMwQrhIY4OkIJLde5JZio0OwDSVIc7r8maJB9Z4PPTf9Um4u?=
 =?us-ascii?Q?lxxxLuygzTLi8wPAV3rUzVcMqpAeHoS+rDwd7m53LL4+oYo7g1Lq8rfpEC6I?=
 =?us-ascii?Q?K19kL9L4uPuqNJupZsTv46rxPEVwbsldjHwZSkFWuJeXDJLR1mln/eWFplzm?=
 =?us-ascii?Q?E1KmnXed5mi0iAfn+r9ChwSPDrxyumGSRx7kSq+X/QXRFjiRzp46s1b0jI5x?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a76cf58-1b65-4a86-be8d-08ddde3ee981
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:34.5438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87FSHXF2I0641d0mjgvg5jzQ1w1u/158VZo7N01cv0bsnm2i7+zgk2sm7tPNXf68ek0WK7BK06B41yBA6O1s/Om+bG1rO7EeUeLgWoGV/3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

