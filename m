Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60035C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21522847F4;
	Sat,  9 Aug 2025 03:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AP7AgyY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F93847F4; Sat,  9 Aug 2025 03:06:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B3D847DE
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWtfpsksVXS/2w6gsCqU7gYu3zQQz09iPj+TngawPxX1ZLBryU/PJODhwrOg41uBfPp7ifDE/xtk6NdkbTDj6WT+mQTejSNyhsU/blDj5Yue1T/x75EwOpUiltd82tDxEPZRaZgtinlwvFFV3mXYwPEFpEY4kEw6hrkFl/VAH5n9FcUq56/gHE7xFNFK8OWKptay7SqmilMXLmyZONS8B3awlHC2pfty5sLkkYjD7X15sFCtUWxQVjSwCUz82CKO3ljN0tOv1W/U3U9MmaNxpQOLDdfSaa8E0+kPB8G2xVRvURzzD/WXwher2CNlqosUcbIE7tHk4zl4kmlnhBCExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=j+ileL1dM40rBHmg72IQTxnxWg5cYLadnkdLHnomwcR1BfBw1cSSgjMhazvwUxZeWY73GVn6/WA22i+kpm3AnEX1XTbF8/FvJYkL8+wH47aYCc3z+lMqpOoIbqoutrjGJ/cqzTU8dE61Xnn+TgQbruUvNwYxvxVAJN2/xy8BSyW+Fvch7Za/ps8dsPszYrr0iWkWKZo5iAeGVazMjxJd4P2M+1nok/TSBiblvXdbOm9rtLD70iRGzrE/AHQfXgBma0S/7psJc1H5AfpzC1dX78mMXcklOUwlXPjDUx15danl7zLXfsp10lUD9TQl/oMEzvFVjvHAxD1AFe49tGAqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v/yRZS/aADAjS8OmojHzPrLMnm6VhT7XfyF/56YGWE=;
 b=AP7AgyY32B6O3XjLoZymIBqIBMmLI+HUW1AeyJKKM2bmn9kZWxHPSWIP/uVQ5QvVqstbwWOHQgWp+EPKMA1PK9VHN3J36Nd17kE+JRe923bCsgkRGcr9xyg6GL/re/QH8fwCaIlQ0iySBeGAvsNxDRkWA1bWtOPKfzKF6SoZ/iXGEG3Qq/QJy+AFgXy61mishKDZ3qJrtQucXMXlpSqEkdKevZ171SMPQ0jmPzFm2W3gy2A6/BY5CVq/oPfYGhtl5h0Qq9kpOVuda38nlv9KhACr6t+59ofuClY8rxOOX/eOGA20nhIrAzl/r0daXWv5FCH/OFT74H+VND9Ho4zR3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 09/24] mtd: spinand: more refactoring
Date: Sat,  9 Aug 2025 04:04:41 +0300
Message-ID: <20250809010457.3125925-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd51466-06ae-48e4-5ceb-08ddd6e0cd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wjb4iZu+eRQ7L3QrgzIEbbtZqqfAKvegFsF0T1eQQixX7zs8sOtsBdemSleL?=
 =?us-ascii?Q?RT2FvUkAD0sYTjSF1urMYe1XoNZHQPEvjxD4PrmELBVnJeWRlL3EbM+/v8EM?=
 =?us-ascii?Q?M9tPDnWHBzmnVY3pWKLU8+YZeFt75zMazKYSVEGHbuojmr/5FOfPLOekOeTq?=
 =?us-ascii?Q?+aHeWDTanc9M7Lft9V1RdLowdNhCgfKFDMqKPv5M0Mj7zNJ7IjLdgOpnujPB?=
 =?us-ascii?Q?oOTZOA0Pwqr0ZUlKfNiAMepegSSGkm/7wsqsCEqj9/Pd+5Lh2R/kHw7zyduA?=
 =?us-ascii?Q?+SsXkFynOa6EcD1KW6Yr+jJYU1fR8eRgewd6A8OzOLT/jN35SiX4iBnAnTld?=
 =?us-ascii?Q?mcw925JRA5kJgUuTi/9qlJiCeYtV5YxEXBCyKHsiv2FoDeZImO6g/x4f+d+Z?=
 =?us-ascii?Q?aP0usg8jgi7KrznrbRGIYdhTJ1+ud1YKX8muYzIVdXRsWSqvcIpVpgJxQU6Y?=
 =?us-ascii?Q?ImdopfW/vRSrtKl/SZ5pwyvyFGH1KilpLAGLBuPJ+W9RIslkjKo4qdNd6d8c?=
 =?us-ascii?Q?Tnq6fKPmjLLEn43IeunDTvHlv1wp+AlcAmVSMrvG9R+H/bNkGuVU0+Lg+1ja?=
 =?us-ascii?Q?p+EcCyk+r5wS5yj8HgmLLELWTiCjHOyUUi7yavxgo7yhvUNbdL4qdDpH7Ndd?=
 =?us-ascii?Q?YkFGqYg5ZKPDM5XhQfeb30WuJnddqRm3gRjLvpcPtcTez16I1+AdzXa1pnDY?=
 =?us-ascii?Q?v1F33TP+eHlOOMEWTn2aoUHGUvdcG8Az3zqrgNo6FG8FbHOTzmP0KEnpCzMy?=
 =?us-ascii?Q?H7bBMjEhg2GbY9cZOzWBOWFUleVGwtDPWvV+S9m9wFb9S4UKpxw9LtkssxGe?=
 =?us-ascii?Q?FQ19LLSF71JrMl5lgF37pLe3ueMzXn2udndn7rVrN5cA+4WjJFb199GBnhaG?=
 =?us-ascii?Q?TKFEYJ3H87FN00xaxQIFqJbC4dvI2s7Wq7WsU78ndW4MqKPfUtzRKEpcrRlf?=
 =?us-ascii?Q?kdOFOsA7/xpfQxKSCbP34liLciwl8OfCRGaVnkSUut8gNAaagJIK3Khuwnfd?=
 =?us-ascii?Q?bDbMITuV3REt4bWlZZ6qYQ7e+TWVu+hKZxb+zcl9RX6Tk+42l6YWdNY1Wjny?=
 =?us-ascii?Q?zrs/2sHU1yogkLocB4g9nKU85Z6Nmnl5yihrGVjy8aJksHiYBdFQL8CG1bib?=
 =?us-ascii?Q?LD3/znjn2YFS28EkiqnEw3xZSPPpT7ymthzuP+3n0XOMBZPMUJTqLXKAFKIC?=
 =?us-ascii?Q?MNL5zlOEAiG4wQUmN6iuNvMEClsSLbwb6dz2eGx3kSYZ7fo6fw1DwqLWkNCu?=
 =?us-ascii?Q?S+/SeLxWYdhvxQWHbeiuHEmbfjOpRFmN4cZ4H6nt3Q5Q5aSALOpqNQAIcAW9?=
 =?us-ascii?Q?ZRkEWnh6EzehhsCdF26v1LPFrTUSEAFHj2X4LiLLrU70Nq/v+yVtce96Kyg1?=
 =?us-ascii?Q?0GtC4UPtUojRKpqKTMs8ap9mVt0BU6kdjo9Aim5Wjt+nq5tevFmIGPowvJrV?=
 =?us-ascii?Q?broufCHdZq/7UIk4a3X101YZqazzuJV/CRIvCMA1z8PfM2m+mPGL5n4dshA/?=
 =?us-ascii?Q?QmSQU1HwU9uQUlU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Of4AQNfMX/hH61OaDujdcJg8vjzGSasyHqgiulvcIr2xBp7hAcPSpsvDckq?=
 =?us-ascii?Q?ZmFBcdohYY5XbbLolT3XDavNpVlb6/cfItUs9uDepMC/T8Gw1XPVqZiVhxVt?=
 =?us-ascii?Q?dQIgNBjggngSDa/seDfwd0mVaCCSgl1bcwHQOI23EFLVgRp+DwXWTDfeL8C1?=
 =?us-ascii?Q?te7j1BtIfjWx783EoTErfKg3tv/H7kGo5yOQOLlvzWfCiogzYhPThbIkX1ph?=
 =?us-ascii?Q?5uHiVuBqM5HhRKAAEIccs7Zs/OPlXlpLY09VCXPHlYE+mOcxrhMnpz1Z9EHu?=
 =?us-ascii?Q?OEWcfY2VpEw+os/diluxNUYxKJDUt1xtzvx1/B6Z6lMv8VhfePJC7/bPXEDw?=
 =?us-ascii?Q?YpUcnCAaxG6pkIG5impMn43KMHRb5qX18n4GzP3z0X8fSTwdF/srjjobeOsu?=
 =?us-ascii?Q?WRycQc0aTkYbw31F6qyAwoIAub8/Cef+PeDDVDmEOfb44H6GQTfdh4DeGQkT?=
 =?us-ascii?Q?XyE2ERR5Be2u+SpdBFdWuiydScEemxgqk9zzOIYAbLHTvLH6a/dq7Bq3WBgC?=
 =?us-ascii?Q?Cr8s+oFa7XZlEEnpbYzsO7QG/Mh4ldHapFnLcggvnWKJSxQhP4fOgT/GypYg?=
 =?us-ascii?Q?7uuLNqZ+T+zalL4cf+wlxY4Elj+FO+JX7mBxSn1CvLmyG5LwwL2JEU4CV84h?=
 =?us-ascii?Q?Fqh2T5CmPhOKsXkA+zmGvJZVcJs+g+n4AR0l2uxV4d9mtbamo3pyX17cK2XY?=
 =?us-ascii?Q?DjnKRCpQNBt8pOTS0Wm5mlHnbE1sYTlhbOSAx4GSR2/2fX3EmLlUXm/6KE8C?=
 =?us-ascii?Q?W18/UGeiFs+s0Xavb+ipgGKuxqeDryjkeMyHnpwn3GB0+r+WEcW+lJdKwPH+?=
 =?us-ascii?Q?FiykG6oZ2B0jiQNTzCKdL/UXvAz2w9GTJlra/Z2RkpF+Eha30/udzWOMN0JR?=
 =?us-ascii?Q?fgo92iSH8WMI2L3WWkhrE4YuqRMPdAWWQ3ySHtGGCYA8qZBUctfKf0SU3cXg?=
 =?us-ascii?Q?Wwb4fQYjUzEuI3vUWT7k//sXHa7ojEtasmCTMEPiu/qgBtyScvDyQxrf2mB8?=
 =?us-ascii?Q?pDSE2/ZZYowGJBZk9yzYyCcgeQwZvUD/vsRq8llbNFLDVRD/TBf38E9Qu0wd?=
 =?us-ascii?Q?CJCq4Vt+oisvcOucDuzUFwiKBCfmazmIkIJsR8g57ShLUBV0icy2xvTwPJO8?=
 =?us-ascii?Q?1PUcsYkCM8yhEhynPZME13xb0wjxF0gQNRlgTuwQhDD+bbzXlzjOyBwi1uCQ?=
 =?us-ascii?Q?wjsD2ATK6GJNIprAEK0dPxYhrRn9hlfvHvgIbn+xp6vL5ZPWNSvwQtsbxPsL?=
 =?us-ascii?Q?mmhV2rPp+LZIQQFumzMzyVtPC80lHsHC6hmZx0SCeZf12klcS74ZDNPGE7cJ?=
 =?us-ascii?Q?1E2OrVd+0KU0g65uPNDKzh7ytF/VI8TksJFm+F/KNVv19w+OfSTS6azaq+jY?=
 =?us-ascii?Q?buSnxipum7VAgJoeoVcRQJETP1oqYkzENE9twQD1MJz9oZ/biQhkIbKVc03d?=
 =?us-ascii?Q?j9UIBFsvPi5CrQi9nEX9Ccf8Bnnl4Os0YjGuTtHlAHwCDLtIHb755Ne3ofkt?=
 =?us-ascii?Q?EatCuBR9aCLyVOqywYHRXtMmDyg2BWaz+2OVR3tTXoLDQfBq9d7ZfjHLLhZc?=
 =?us-ascii?Q?D266PsRscNPdXYAuAmruBULnW1ADR3ge1hue2Wls4e2akxfgNiNepYazSEfy?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd51466-06ae-48e4-5ceb-08ddd6e0cd4b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:16.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzCQO6/t4tbDWjcoMYCkwRuTAe7DV3K4gmcPomy4C6Z9Opsi8dLEv3wcaXQ4BiGEap6GOKtNzHsVNs6X+0ozG4uSL9jmFT/idGVJqTtaJTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

