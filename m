Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5587C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5A983870;
	Tue, 22 Jul 2025 13:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V2BhuCgH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687C28388E; Tue, 22 Jul 2025 13:42:10 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8AF83837
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1YnGrJIQFkiJV2Tjo+tuXqNcTrqNPiz0SYECmv9AM+vpLdUwduwerir5ZaSemLqSkszorMaiGpyrDJMrewVAF/KDZ2Wf6MzoPIroCTlMuxur757Ey10Jfp6io6t4vLlnnoZN9SnKMUOYtD8LANaav5Zr6sHo+D4dklLtydqQbuj338o/+y2maghcYnggcPvZE7nHcCKt1CtND/zrKZ+OYjJRuEsYgaWQmUy136EPkwv1Y0J6Iork5hjZDbNiLxvXzQzQxWnqH5f9XXe9Fw/TMDDilVEPIHLvibGcs8I+oWEQVit1aft+zyImFaiTsU0emoqSPI+PWPgiZLZsGmT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=iTZ0O8s46b01ZMcMI08Fb3G8TJzc068CiQYk1qWWYL19pbJ5XNaJjAPUNP0MeP1CP1whlUacvpvLAijFWjK5FaXN3nm0HDCMD4g6dpkjx8qrVYiBFJ1YdGyCBEZUTk+WIx2QA0rI85dRJeD5UE0jo/kUC0OH7ilYHfgbXe0vgYQgnZd7vGblrvdXSYPp0vx47RJGuToz7od2BzlZkxdxwYiYxCdIrtWkO8PlLJ87MtMJN0FgMgYPaBw8yqb1Wz62JLHfGVnlGOKzu4ahZbt/lwl6Zv7FXvM2RckkCPTpv693/sqji5dtVdmnl4Jtv4D8ig/FQ1kvXT9hzt8graL74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=V2BhuCgHpXYWUDsTwkLRwiBKPhxs6N2w7J73nav6dKoKeYIjzmHXO2AxIXjWR90QDN/YisSV5hdnhKjvAQAKV0oj4bS4WySiLCk41Dy4aS2ScaoOnRS5gQu0K2THTJDsAmQplRV4Tt0rJHEhnqc2FMzmdq67ObHHwCD+zdP0L4glrjn9IeXyYlWF/SlKIWs+0s5w9sRFSm56vkMkC7nv5k7aFCeiZVNlfM1g0mG6crU7UyfSlM9fKiSPcKafqQv7g9XQWpjOnFJ+u38FnSt+rjpeFmg9aR4YENAl+gIoQBkFjciOzXy20WNYSz1vMuNgdplS/AYVEID8Of3PiGq1oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8674.eurprd08.prod.outlook.com (2603:10a6:10:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:42:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 09/19] mtd: spinand: more refactoring
Date: Tue, 22 Jul 2025 14:41:25 +0300
Message-ID: <20250722114135.768998-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e54a77a-0558-4872-781a-08ddc914c722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hSissEgYEzS1Yw2XhEuNM+UVmLSz9w0ft2xfHkLHCc2PenJoLTgcngj/OdJ?=
 =?us-ascii?Q?PJUcvTAw/miUkBpCPlrphKkmZW+Reu1V75kitqucP5FAEQRKvD1jtfHZ6hn9?=
 =?us-ascii?Q?HKtGJu0uc8lPw1IJA15N2JsVKAz/9NFrC8z7LzLc1etZU8pXr62lQtWPXaWy?=
 =?us-ascii?Q?OzeSefFbH3YEuaAb5sO9ZwkCcCap1LsMHuEWx1dZ6C6kl2vGUGPRfDLahAPD?=
 =?us-ascii?Q?QpLMn4caUwOfEB6P5mNYUKi9cSVsowWOnFWiZLRYDdZCC+TgbuPzxcbRoHcl?=
 =?us-ascii?Q?rAgbrg+FP3NabnjFgahBItknBAgnNstx8zWNUHYbJ/7545Po0OMv5ylK9vG1?=
 =?us-ascii?Q?jtOCR36FPuijLW0nvlj0XY0bnAXUz3l0d4CF4V40zu68iUeRlQs0QtXNWjU/?=
 =?us-ascii?Q?y6MEfJK7MOjXVHqCVudMuVFrlQwqsOmFPJjCmTwch5+XJEncu92vjmV+eDh9?=
 =?us-ascii?Q?88prr74VTeyP8JjdmJqsEGnFVaVrid2R5zckE/PrujL2QCOKSczjfKhhRwdx?=
 =?us-ascii?Q?tbo4e2X/e/0HNnQnz1KepIyE68/fc3ajGeOtS77iUZqPLrpan0f4v9M/Kf5Y?=
 =?us-ascii?Q?OBJRpfCmUK4s/Au+uwtaXEjNBPMX89CgKGP0VY/qAkD+VYzeJdJ6wErL5bhU?=
 =?us-ascii?Q?Oewj2RCnYt/cAGL2cq7OHp6BINajxLSmayqIruJNrvGr45ainPzfwVxZBaJI?=
 =?us-ascii?Q?RmV/9wE3UX0xEpsI1jLiATT79QMmnTuGZiDGiWsk/ZRw00DEBLtP4PET0dpy?=
 =?us-ascii?Q?+TJs7nA7fJrIWW8pvX6/Lbx/AJ7Xa70cyMMFu4ZNdtU0YWLK/LV81CCWN5Yx?=
 =?us-ascii?Q?NKCz4E1tpf2YH09ktzKHLXik6PTes5InbD1I8CRLDIy3SGRn+c9zNTJ3DwjI?=
 =?us-ascii?Q?eyr9T8xqzahEN3zSeqKOKn04zMii5HbWb73I7rNca3e1FFXIzRVRnTpV8O5n?=
 =?us-ascii?Q?3N3Kh7H9qtn1bogqqc4CRXL7/LYsksCvchmzGahZdkDHsLqAPiNWifEgxu45?=
 =?us-ascii?Q?eW2t46WXL6SZQP/7hW7goms5uCo6E+2tiPJCl4RnKtt1sesPq5y8w9v6QRmP?=
 =?us-ascii?Q?CSuSr0ZcgkdLxdPajr5/28Xe387zdgF8jWc8VhBi7dBvD6XXCyNiXOPHhmeO?=
 =?us-ascii?Q?uHZj8vxU5C7hgiBD1LjPSkDMe3eORwTTjWJ8REtFcp2rjLT1tMLppiqJgI/Q?=
 =?us-ascii?Q?1cSrVNQ93FQBeY/FfdYGnqymStF8KR/O8V+ItL4PcuT1N43Jf0VWWJeCPXI+?=
 =?us-ascii?Q?c2gt7ZhhxyxuYzDIQhwvAfk+tNe84slZFwM9320QmEATwPjSui+Vfmi7xDJx?=
 =?us-ascii?Q?CYw2LwfQaTH0jBdqY9AsVTYeGBMCEbvjlnG5Jqe4ScuoMq6FswpH29Nd6WTO?=
 =?us-ascii?Q?20yL5PCgWHVQC3Cf2cTguPJlpObmJZQqod/llvlD7cZvKJH/5zieO5nY3Bek?=
 =?us-ascii?Q?6S8NMyLBFpFZDxHUp8M8WxrcjWPoPEfXl2/kRpL5WmOmH57wyU6J8IOFjsy6?=
 =?us-ascii?Q?Q/bxogL1dJFWk2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUxvZLxedL+5lKh43sWLBuQh/i0LWkUCCMayOnzY/Xl/JH5XVjQbB3lEewNt?=
 =?us-ascii?Q?OHYQwotUj9ozVRgRTNj8myVl4+X1gD/vU6ppYPz0uA9/VRGHPmXWKk6uyb/I?=
 =?us-ascii?Q?vlPRzRFba+P5bPz/Gc2l5eWFCJBITcZOS7pnmHgy5DPTu+qfc1OWgFcAEUbk?=
 =?us-ascii?Q?3gfj9W3v4/+coYK5AZhUfvAkBfClXSYeIiOLr9mfxZan+qQaJzejkeBDDQW4?=
 =?us-ascii?Q?meZ2DO+RTDc/Iw7cxq9+0gIHhkxANjbVFV1lDZrYMabdY/yzXaAaj9GChrXp?=
 =?us-ascii?Q?7B9e0TpHX2fbu6l7Ud9xoE+vNzp9DN/0hpKzhXdoZOg14JHc4a2fvqfSVK6x?=
 =?us-ascii?Q?R6/UwltEBBP1YJ4NKhLPID9MZ4MwhlUDfJXsRrXY/noIsIh0AlLzowpCK3Wm?=
 =?us-ascii?Q?b+4e2Q7GiZg5Lo6is1H5by/la6M2Xa1QhWMpuEcP6PNou9N1k2pLVGOosTLK?=
 =?us-ascii?Q?6oLkw1h4PxckR1IB4HMGWTZ/4/B5sEVJx1Kx6etgADlsqI9gvd+TgI3fD6ue?=
 =?us-ascii?Q?6+mK41JV+dpUuBNDSJ+KiJoWVP3UBxUCW8WpC3AXvwWZMq+/6ICLSqGB6uC6?=
 =?us-ascii?Q?WR74x8EGc1i34PEnV5Zk8TRdfh/tHlhrqck79w2fnD1bZnEUOUyGiuol4X+Q?=
 =?us-ascii?Q?BNuUHFPuZuhqXEfF3c12HK+5uQofyPqR6QtQpKY2pCZyoqgD2MXF0NhzvVyf?=
 =?us-ascii?Q?Lq1F6F+E/aJIYFULTxD4PDuLLVNelKPF25XfbX5wYd2NIBNz6bJvmKWJYEns?=
 =?us-ascii?Q?C1Sci3OxkdC4n7XtkOrAZzFhdFv2nkWH9sbXPS/6eoWcuKZ+9g8db7/4noR7?=
 =?us-ascii?Q?cUbzN6jSkZmBBm5STaE5gWbBMKcOpuhHiWxHZRFnD5boh8sznP12HNDGLY1S?=
 =?us-ascii?Q?o96tvHgVOHRqhjd48SlTAFFjqLot8+toSsUYw9l+/58YeI7lvwzzRruRHF3l?=
 =?us-ascii?Q?kIEKDNq/VrOAXbQSPvPX2LZA79mnqZ8DeslBaenLoWD9k0NRszmhG2Y8HG1B?=
 =?us-ascii?Q?8Rni/CSy9L8ATAEAD+l075eB2+sJwamCmUX/tVBwWgsqByb2mcnpmBZI8R8f?=
 =?us-ascii?Q?MhP6+XPrcyom+RmYFpxOyuW8djejkdgfvxMhQ+AILTrouTDBxHAbQm8/nEvE?=
 =?us-ascii?Q?H+AQk978s9kQC3nymG3YpI+1bN24mNMHYrYZ8et+lfP+YZTJSHHwBIoxaT65?=
 =?us-ascii?Q?qcr7K8t4wdUHnzWJL6tKRmuHQ1IPUodWzLGyshy4KKDBN9/ZF2xMUmW9mK2S?=
 =?us-ascii?Q?RnY99knQYThqPgCR5JDvmY47f+ENHAqSwBkSu1Kb4ZLIRfDEG94v34XW1W+o?=
 =?us-ascii?Q?1p6TY+9r80ucMaXRz3w4g+Q4Wn6JCgVcYvgZ3AZ4pbqxJM8+V8vhTXj/l4bl?=
 =?us-ascii?Q?bgh9EocHr7lPQdABkIyPqu/vHqQYMfIVxsm+EleF4rN4bdXejxudZxhQOQEp?=
 =?us-ascii?Q?mbs58x1/i06gWJ2NKxZJ9rTsUykl5MJ859A4qX/P5U3NcW03ke6xSrpK3Aq8?=
 =?us-ascii?Q?CeIjhnbDIZy7F8TcSU41lZyb7q5yb6aE35I4gOcdf2AHkXsAw4ndtn5jx6Hb?=
 =?us-ascii?Q?YBZae4xknOq91zXvngNG5rUULAe4E0lphitn4A0A25tIzLdQIs7s9bjaOhDu?=
 =?us-ascii?Q?4jVdoADqBqXl2QtYTKuxz9g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e54a77a-0558-4872-781a-08ddc914c722
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:03.5876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK/eRT1JlE2GVP2OiXc9te6jptHcftimw91SFz4RMwAqGfJ3DjO6T6VCKFXEStBXPeG3d2ogseEj2hTXJ3WyBy5jPpa57BVKLGRNz/7GwtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8674
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

This make code more close to linux-6.10 kernel driver

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 115 +++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index df59d3d23ce..a6353b37e7f 100644
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
@@ -413,9 +466,8 @@ out:
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
@@ -445,35 +497,6 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
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
@@ -1074,30 +1097,6 @@ static int spinand_detect(struct spinand_device *spinand)
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
@@ -1187,10 +1186,6 @@ static int spinand_init(struct spinand_device *spinand)
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
2.47.2

