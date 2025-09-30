Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B09ACAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534B483544;
	Tue, 30 Sep 2025 02:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Qukfk5CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF44836B4; Tue, 30 Sep 2025 02:21:41 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD8E88362A
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP/KgZT5xB4x2LeNXPUU0pYXvTgeYOw9uOjR6WLt/DnwOn/HOjim5rR0i/yUT0On6vXezim+CNQFSGd2pI3BofJwGMNehjSzIR0w0OfzMuOpkbWHXUQpNeKGaaRi1Ad0Mqa55wnwa7WSWi6YR2qu7Pz57DzbflfNu3kqCdYiZ9ZG47abCF4PbU6omBHwEN/ut5C7chYdlgGlD6KG0jdU6rL8TW0MD17AgOtC279+hXCdV/Q0uKEkXO8cBEuU/YzPx6y52MoiJBtbE38q60ewREKrFDp1oULhBto0g5TCZfICY3zgymyZgNgB1I/ncrWXwZGZXx/tXVHyIbJzdqTKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhd+yxmrkcq2pO3q/Zr/C0kVGuLb69R1KAUfqT25rLs=;
 b=VKe1qXAjZyDytUwVHecqkVILNf55DbxLozIqJZNZ0yL4Dh49UeNxENS1yPJANvUlEwvgpypmRhxVZ3hsXj2ofSqG1ltT4ic470bk4VgDyIUiQqtRkK6zFP0NtY048YmQyKHcVHJrm90capZu1J9Bt4hJyMxsgT8eeI1K+axTYtoPBwuM+DebHO3VIcDTXy39Forw6v+SXsTaZ4YVi9SWBC8yvP21r64luvo47xQieyQ9quJPr2R+FIc3uR9zjgXBraOgNb1d3jEjgb6Rgv8IemKVjJ0jhqr+1XRcJMXvpCBjGSInrX4aMz0Uq2FjJktUsBvruYXDrJFHjmymQ65P0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhd+yxmrkcq2pO3q/Zr/C0kVGuLb69R1KAUfqT25rLs=;
 b=Qukfk5CMTg0OGcChb+1qI69CkC18I5QmZsrhILi3NfAbNZSsLRbOP4MwoRb2XfbJRhnaATinM5C48RT8FxzXxTHjMwAw+0sf+3SG4AvbTnx1KVc0/DvIqiacn+3fS6TDKPQ1cVLy6BYGNeCMkiv0skrleewTgajXogibuWioVYp06V9cfEP07cKtXUCnRjHbp11n1HoBrmJ5aBxMVnk1IPFTqSGRCZFHfjYLa3oE9+0fff59R/72f7YaeFCbex317Ubtn7HeHwx7P4n5Nw/7rIq2Ql8pxTuC50NM6KuRVqCPJT8O6artyjSjBa7Mr4nwMzRgBrjZ1qBSHilmJF6RBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:36 +0000
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
Subject: [PATCH v7 09/24] mtd: spinand: Refactor ECC/OOB functions
Date: Tue, 30 Sep 2025 03:20:54 +0300
Message-ID: <20250930002109.3600886-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0859e0c4-3c97-4cb6-e720-08ddffb74cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sBZU5QK8sfy0kCkSuSYJ5nnb/bSuhQMbiyK9PQ/QT42FxKJrA6uwXPOOLD2b?=
 =?us-ascii?Q?SAW6550JBnpIdeToWTOK1iDjCACRm7QyqJ0B9IEJJQSkT8lTWmwh6q9uk7YT?=
 =?us-ascii?Q?q5YxJkw2xivdaQaRRTBrzbLXxUZMFXM3QN2ppBPmPQpEajWfbmJx/0T9YAbB?=
 =?us-ascii?Q?zT8eiLcVkRkinTbaaLNd6UfBCeaQEgJboOlEx3sFZy7/aa+/7oVUdId0u+Es?=
 =?us-ascii?Q?sxrSlH0KQUdhMWzqgFcdIUZWVZ1Oe45mSYauf5H/VCZuU+w0GEBFp8uirh5u?=
 =?us-ascii?Q?oz6LKLwLsOw7aBXjAvGuwcJmxcvdORLglsrrihLrjD/zCETpZ0lFyxQf0XPZ?=
 =?us-ascii?Q?ngof31eIN8IYg0x0jHO0FzI8jxQQ+9SjvdVT5wvLTt2fkKyJthp+WIO5hLAV?=
 =?us-ascii?Q?F8UEQxAFN5zNLTsG8ujE6M/uO5FFWfapiOE3CqDT9TkCQIl8Hk/3WIzieZmD?=
 =?us-ascii?Q?I4WWBElbmB+Pslrkrj/jhargXxLxOYNx3u+rWmxYBeK+nqrM+gAeCF4NX6kA?=
 =?us-ascii?Q?7IYmfMxMK1sVs06iSipmbZ8UV9fsKH+qTxlr3uBmIKXhIEJX6TszD4HCzL/Z?=
 =?us-ascii?Q?kTAO/s+8lTBpVcXxBKlbgoAvmm6t0Iq3TcPSBk+rMjxMqof48IS59O05Telp?=
 =?us-ascii?Q?LCLl9fxUK4UJ8Wla1Xd+/u+4tlekGVj5mDM40monLefmNrnNLd27FOPfntgf?=
 =?us-ascii?Q?lGAW0WK0gbkEr8zcelptBHLjgE5+zpM7HIr7ZyfRaEUqnd6q7XpoIJKQpBOO?=
 =?us-ascii?Q?OHBVxQB4/FOcDQ+yRnpjT3IlnpOWybgb7unKCnoYl0uRtzDi62V+LOtIVrln?=
 =?us-ascii?Q?BygQMFzfMCjO2U8P01fovQslpSSMH0tAyVDg6M7GWxdRt80XNRAWLfFsYa4O?=
 =?us-ascii?Q?mBUrn1yAFgAiUHkwD35/wvL9xJ/DeIPqy2wHhN1t1+KaAlhdDYJKW+iR5oOq?=
 =?us-ascii?Q?Afm96CcQIMLLZQY08gKk/yJ4aE/HlUyJj/HlHb0zXHFSNQhVv4Vx0g4v4ZiW?=
 =?us-ascii?Q?QENNl53jxPLdIuxzmMBr/Y7GNQ+dpUCQTfiGv9QERzI5azX/PsaDJrtD+4rf?=
 =?us-ascii?Q?nbmpN8SzWTlwnhEHNtICIBKUZMnPfnBtHKVcorDKGUeVdxpzuiNiszj+v2O0?=
 =?us-ascii?Q?rA/UwB1WxLEGpPUxZCzkqxDNic+t6YPykcLzlm1BC/YZvFxxntC4narAc8V0?=
 =?us-ascii?Q?BkoN4qhQJ+M8ylgzTGtQ7wIyDXo+pysguv+BJ0jDGOMoBFROvxV0xUTJTCJW?=
 =?us-ascii?Q?DWTVip/E4xYkRvErAwMX5jyujqXJyr8PxUE+x1bFKKsM8QVvdBlnaVnNMBna?=
 =?us-ascii?Q?Aj6r43iDhFFQ4EINbN4oHFWaUUXpH+2Foy086yS6cc3fmdLIUWzeXBJ+w+VZ?=
 =?us-ascii?Q?HH6JsZSS9mtBS2eum0MkpFJo5YmZ8iyBMiG6kvESiSfFYAe1oyZtx+x6HZIO?=
 =?us-ascii?Q?MUNDQvPBTUDnThROnb1ZhXVJKth63d3vKwV8eh6vIEOQstt7MZlaqiQNlp2i?=
 =?us-ascii?Q?kTv9EZe6c0ykG8/V2nkg/DazXBbQDBjjy4YcN7Ok0aHWxgOdD7fiRaDsrQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SY3z7nG0zpe/ENFdFPPPcloeG5zKi6xrBjcc+ZS5cXSHHeZ83aDb3i6ftEi?=
 =?us-ascii?Q?Oq85HqF6auGIj+krCHkbL6YK0LZfIvYGzKJo5hnwsH63ntTs7iwuPRBsfKCz?=
 =?us-ascii?Q?YYGxEtKXR1lam79D+4usZeUsva3ReWK68kHRUvtDM7Kr0AwLo7R6GbSQQC50?=
 =?us-ascii?Q?Ar6VglBUUuB6TxAtqSEzOsWEu+0PFYEh1igxI02ne3LXKM/idBoPQe2OkYqG?=
 =?us-ascii?Q?KGHnJXMx8AGzGoHOoxc/Ie1ouhxNeMGkNFFyWqCRkcXDmHOh8kaHg4FldJFH?=
 =?us-ascii?Q?GhIaio7RyQuzhhxLUkpBchPNylE/bc2wsobGXp3xIJV40DSI4IazTtKwfp0V?=
 =?us-ascii?Q?akCqzMvLGz3zQUC8/tn4CR5U6xozAAYFijOadU7dDoDzv0KdSOOBlYhgtX5w?=
 =?us-ascii?Q?oszPRUb1NKdfh5i1J/Dr1+nMmp4UwbQ63lBveuxR/vP+fz7j8IjGFkCMqGy6?=
 =?us-ascii?Q?+ecZvwuDYcxXezxSAFCAarbvCD7u+iBbLNgwTeLXoAY+TGbB1TU02VOninZH?=
 =?us-ascii?Q?3m8QAh9upWMuxHnI12JbYWFRVooixSL0jnmZ9s66DuhDvM4cSwmA6o95oibJ?=
 =?us-ascii?Q?OtAabon5L67xjDkU1bzURqChO8BZ/MDd18FKalc7famgm0jU5ghfF5/po1Dy?=
 =?us-ascii?Q?6oP7E6vrPsG775+1GRaUarQnxp5IZ6NvmP15CgPWmGu1k+bkJbJ47uCZUieV?=
 =?us-ascii?Q?8UuTCNt/+9jCiAYBdSdOpf9ypL521AmnLs1bQPjAubgrvN8anuKtuLSvvdgD?=
 =?us-ascii?Q?+nPLY4ZPEiTIoLmSVLf5EefUqrl+BABtv3gImSQbPD6GBJWlUuygJ49upkwB?=
 =?us-ascii?Q?M1TeMR4DzhXKoaU7VgHL3kzBuNnkx8Yo0iQ/kH+ynkZqZl+KgBSgtCRBEXgV?=
 =?us-ascii?Q?VLAunwB4gWopsIutmiIr50xF1b0yDD0mm026gcz9XgdzJIjCEpDX+PG4TXY8?=
 =?us-ascii?Q?PnVYpsNMPgneHm9UoKXrKSkQ61yXEjJFzgyHMajGz7y/4bZ8Is5FqLesO7sp?=
 =?us-ascii?Q?Sqxdfspl7QgiikV0K5PTruInS6XXrRTBHo3206hQA9VAB41bgMpdQc4EttAC?=
 =?us-ascii?Q?W5jpeHktVSYC/FzcK6ecQmiEdFflXMFm6QUZcLZp/kcQ7lexNfl5WHy7z5/Q?=
 =?us-ascii?Q?ot/BlL7vtUmIJwgPd/uaNs33v/6w4LoiloDRlOxeQZDW+k3SOboZJ8HL0lfm?=
 =?us-ascii?Q?a+vgVTTgLWpnThNV5g2VXVymfySQfubcm2L/1lWLAhYNtQwQbVuC/GeIz2Vm?=
 =?us-ascii?Q?ml5q9fDy3OAUV1QWQBAhcXc6q8hqes5caMDhUGtmj3n81SIryrc83yuudxKj?=
 =?us-ascii?Q?pjULyHDqLiz5oKfFxWuTRkgFhuGpw19oYC5KHddHIZsAIs4jVh0UmbLlndMg?=
 =?us-ascii?Q?MAYCs6SnDe4kMA1dVGOK8DbtCMoHC+yxO0b1fjlD/fBq8H+zTIGhyL6Gl6+G?=
 =?us-ascii?Q?irdYtgDWq01piYSUPFHfqZc1/HQW9G+vkkRqBHQRbr7IE6BEc9Pff7Mz3O9n?=
 =?us-ascii?Q?UKCuIBooCXxumavDJtjyDY8+taesjqHKW0oZ41ZF3Oobp9kVULpJnAJneMlX?=
 =?us-ascii?Q?vP+ABQl1jbub8xlHMsiEcwdYy2QWvZrsWamK9P1vx8px+dggP7srFeHp8NRV?=
 =?us-ascii?Q?awqc6L1hZxAofOXq6m7lFp8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0859e0c4-3c97-4cb6-e720-08ddffb74cf9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:29.3600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSpwWVJhd9MO37lhrEo0WAC2r9tR29fRAj914mSHZCbOLgTWAe+Qfpa56pW6365kNLXJPHzFo21hGrk4QeTd4f6o8CKc6+1o72/hvJ9T0GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

changes:
 * Move spinand_check_ecc_status(), spinand_noecc_ooblayout_ecc(),
   spinand_noecc_ooblayout_free() and spinand_noecc_ooblayout close
   to each other.
 * some code formatting
 * remove comments not present in linux driver

This aligns the code with Linux 6.10.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9b48bcba496..ad699a0c6b1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,59 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	if (spinand->eccinfo.get_status)
+		return spinand->eccinfo.get_status(spinand, status);
+
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		/*
+		 * We have no way to know exactly how many bitflips have been
+		 * fixed, so let's return the maximum possible value so that
+		 * wear-leveling layers move the data immediately.
+		 */
+		return nand->eccreq.strength;
+
+	case STATUS_ECC_UNCOR_ERROR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	return -ERANGE;
+}
+
+static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	if (section)
+		return -ERANGE;
+
+	/* Reserve 2 bytes for the BBM. */
+	region->offset = 2;
+	region->length = 62;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
+	.ecc = spinand_noecc_ooblayout_ecc,
+	.rfree = spinand_noecc_ooblayout_free,
+};
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -425,9 +478,8 @@ out:
 static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
 			      u8 ndummy, u8 *buf)
 {
-	struct spi_mem_op op = SPINAND_READID_OP(naddr, ndummy,
-						 spinand->scratchbuf,
-						 SPINAND_MAX_ID_LEN);
+	struct spi_mem_op op = SPINAND_READID_OP(
+		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
 	int ret;
 
 	ret = spi_mem_exec_op(spinand->slave, &op);
@@ -457,35 +509,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
 
-static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
-{
-	struct nand_device *nand = spinand_to_nand(spinand);
-
-	if (spinand->eccinfo.get_status)
-		return spinand->eccinfo.get_status(spinand, status);
-
-	switch (status & STATUS_ECC_MASK) {
-	case STATUS_ECC_NO_BITFLIPS:
-		return 0;
-
-	case STATUS_ECC_HAS_BITFLIPS:
-		/*
-		 * We have no way to know exactly how many bitflips have been
-		 * fixed, so let's return the maximum possible value so that
-		 * wear-leveling layers move the data immediately.
-		 */
-		return nand->eccreq.strength;
-
-	case STATUS_ECC_UNCOR_ERROR:
-		return -EBADMSG;
-
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req,
 			     bool ecc_enabled)
@@ -1086,30 +1109,6 @@ static int spinand_detect(struct spinand_device *spinand)
 	return 0;
 }
 
-static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
-				       struct mtd_oob_region *region)
-{
-	return -ERANGE;
-}
-
-static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
-					struct mtd_oob_region *region)
-{
-	if (section)
-		return -ERANGE;
-
-	/* Reserve 2 bytes for the BBM. */
-	region->offset = 2;
-	region->length = 62;
-
-	return 0;
-}
-
-static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
-	.ecc = spinand_noecc_ooblayout_ecc,
-	.rfree = spinand_noecc_ooblayout_free,
-};
-
 static int spinand_init_flash(struct spinand_device *spinand)
 {
 	struct udevice *dev = spinand->slave->dev;
@@ -1199,10 +1198,6 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
-	/*
-	 * Right now, we don't support ECC, so let the whole oob
-	 * area is available for user.
-	 */
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
-- 
2.51.0

