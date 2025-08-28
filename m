Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B711CCA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2949183214;
	Thu, 28 Aug 2025 08:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rN1YG/ps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F90083253; Thu, 28 Aug 2025 08:36:47 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAA9831D3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFz2LewgC0LXtZVk8rL2dgfABjIew1N+XLtSDyIrt+OMAMTaqM42ADNxv7DODhYjSc3lnSHhnpoxedZlqja6IhjZU4EqzJtRi/t13FDiFFMheSKR4gSGi8RzC279qf+8E72IzHIloR6xBY44i3jPSXcLriluVvS/YjKU+TlkpN3Sl6KgTjw5sbnKsld1dv7I22tFmBr8MKeQ3DtUmtKotHAr0WRuX5MGBuBPoG1DW43OAEEKgk5dT/lKp9w0AEH0ldn6I/wjtnmwZCcJJmDFlo7S/xgG8PVB6gZmj0RYPcjqrl6Slz81DgQrNY92NeQ1J8u0m+SZwzORuTYUoNBh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eixDiHVh6vZ9mGIO8Fdhfwv2KSoK0FKXPv9usk2hB5c=;
 b=wIrVouMdOzswY7kIb3hfEttjNWFT7eUdMxRLpctSLWzGDxtUu3FojNxf6pk1SE/QCD7FaDF4QJ8ux3SdTt9dIj70CXJNkhK4myl/7L6xM4fqGuTwyuzBihdQJ6oHgIh6iw+D4JrW5hKUua+7X+izeLDZ9xw2zR3aTVs0HV/lzN066Uvye0R26VewlCqBWA402CeAvnSI0sKiqzFD2gTVNYnz+/FUw68hytWwc/38FufDoOsWvHu/m5U52y1H1m6wv4CYtFoiZ9Kb4W0G05gABmLyc1UJq7JZOIwrBZCpOSo5w2Ioei+OHfhPC/vXH7iJSqmS1jzV4j0+GDddfJm16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eixDiHVh6vZ9mGIO8Fdhfwv2KSoK0FKXPv9usk2hB5c=;
 b=rN1YG/ps7iM6MSHXCIeXxv+2YwKOpPKbspN+DKjvu1kGtKuLVLTKkdtySNXwvZ4T4xkoiPrLlrF1+gINcxIT3CniZE1pyuYYR5ay67CbyhRnuxlKaf8mjet3Uqi6hzTmUUpa4TYq1qLL2vuxs/OjhwbQT86jiy61b0lEyScGIimOwdTUqKxQ31aOLMl+T4ECHKGHWMDub2NhQMpcPj9Prh8b9oTl0x4oTgAUTONlY68PjLnos0fpMkw0Nv1osZb4XOZOLs/6UUttWcyyB6Ww25Kx/R9AjZNZgx8DIWJYl6zKEXkT+6NOiYNdDDroO8W5/yKpa1tF+UUDTNXJGpFVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV3PR03MB7408.namprd03.prod.outlook.com (2603:10b6:408:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Thu, 28 Aug
 2025 06:36:42 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:36:42 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack
Date: Wed, 27 Aug 2025 23:36:38 -0700
Message-Id: <20250828063638.30278-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0072.namprd07.prod.outlook.com
 (2603:10b6:a03:60::49) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV3PR03MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bac7eb-4ace-41f2-7bc0-08dde5fd401e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YwBVhEULmIXO/k6bubqPO9O5KhqYmm1YqGA05gnPv+/9pQUrmUWO2VLbOylK?=
 =?us-ascii?Q?IC7YULiPu9W0g78uYIy3sPS/DrCW3N1jBM9gZHdxWnYYpyE7eerfnmzCqaDz?=
 =?us-ascii?Q?vMooSSttehQWb797Ro7UHL+cTrprTL6gUSd1XENH9MId8XT5q+FsLP8vN+8v?=
 =?us-ascii?Q?YsoInk+Q3T2IN6HHnfPJmfl1cQKJS7ipjHaGSfII8WTOmscyZoCZt1PLpcMF?=
 =?us-ascii?Q?+pOxRSUP//0Wk7698NNd90TCvDH7OahUKxZI4P7/dJqRJ+sQAGK90fYUUaRt?=
 =?us-ascii?Q?n84LlWPipO5KklneRcQbft3lRFYPuQB29IC5FbMsQZhC3pRjew/Z6jX2+uFW?=
 =?us-ascii?Q?+80eEgwGD26IqT/lJUrSzA9jxC/PrSGqH/J3PV4Qvm7E+Xl/kBlYqOoKseK/?=
 =?us-ascii?Q?9sQhyLlblwP5qudqBQiu36H7sMhK/JRYIyD07O/WzQls9voYL5i47Zw5QJrm?=
 =?us-ascii?Q?T3BGcwxGXNDcnXSHYYwHLeBeFTtzJ7B5PD6TpXMxGX665XDEbzXofftXOG2q?=
 =?us-ascii?Q?n2NJwx3prGhL1tY5LUzx909S5apsDaQMoKfJCtxiOtKhnaqiqDerm3q4A8TI?=
 =?us-ascii?Q?Uc8WjOaPMc2Wpzez9hGfO+Gna6wSohRVx3zZpUNQBbJX80BD5XPjw9YPlamd?=
 =?us-ascii?Q?SBzVz1c74kY7tRr3yb9LSbEAfWAdGJaDLuuO1fzQMOjg/fVnEq9b28JupIO1?=
 =?us-ascii?Q?+RzXpUxbl90xzLpqIi80VNmMnenXSj09ILryw24zP+1UpWVNFhKxF54q+/0u?=
 =?us-ascii?Q?ADvzOuHJR3gIo9aKVL04zSQMUmilaKMl/cpj5eDxTaQReEC7eHZXT5lvD8J2?=
 =?us-ascii?Q?e03arxKfP4EAB7V2AQsnUiioBLcQvUFncXWI2Qah7RFMyt1mmDuMDTo1jTRw?=
 =?us-ascii?Q?2Ttr/qFgr01APl/EF2qJd+HHpp3eKWQBDVxIKHgtrLf54flOVLosrg8zsehs?=
 =?us-ascii?Q?fkijfbt4EZY3tL51PPM8KCzFhLNJ2ARyP9qUA9DFMEBBMNPagtPdW5oXyIyH?=
 =?us-ascii?Q?NZHijge+LvXVRE4k5vAMewTb4rR5ZZLRRmVDOvrhMzq/m0Ssbl8neagq2rBu?=
 =?us-ascii?Q?3d9nhU0OH20SzzZE1ynCGKF9Nby2VAXZAE6ztVqDVjI0QjC7DWhqVfyWCm2f?=
 =?us-ascii?Q?eeh0DXqJG2gSkLPje5b2UqEOesmwxMn/TwssMWRRYOqtACbFesCd95z37KTk?=
 =?us-ascii?Q?qeOWrq1cpbVxo/XrWyvy3SRv2LS8o9ef0+s1BqJgY2vTdR8qWMWbHemzUoed?=
 =?us-ascii?Q?z22NG50UMH0UTtdLOBdPHWrQfuRFpB4VRip93DrgdLu1yR7xUe5mmHaaRVTA?=
 =?us-ascii?Q?muc3n2KMtKaZeqEiLqq1hWCQAnsLXF8tjVHkNMVjcyrsdS8AD5mGuHXqs9aS?=
 =?us-ascii?Q?vgASObnUn3EPXTFz2Wh8naMc5J2WI4SPXtsr7ThFiDSsz02NHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQCHF3wKZiDmeQv7IJM34jgb9FZxJQBJA0/95hBpUNQ/L9J5di1p3E9RrwKd?=
 =?us-ascii?Q?HymDpwlA93Kfwh2inhFzcYNi0SDP7WrAauaovp4/E2R7d1i/pKQp34EooMtQ?=
 =?us-ascii?Q?+rHLhq+a/Qms3B8WRqtypUgA7ymH6BhIQhsPKt5yo2VQTEscMpghEeDUyBAm?=
 =?us-ascii?Q?aNHnPncSYZFZOXY1tgBGa4mHpM3jbDG49619Kciq1GP2tVrd29nJ+R2NLVMB?=
 =?us-ascii?Q?1HghOmlr5e3xQQhQHwOL9Acg6WfQ1xpx+rnKtLc35X36zfJ6g3rZq6uLtFKp?=
 =?us-ascii?Q?3JxSef/+QDu5ozH5ZR5E4H0zj/lgt4R4M8RbE+tEaGK4CCdxVNL/6tzX/wYg?=
 =?us-ascii?Q?CFVynmrKxinyTrAVRbvFurcrSwZFvHQ36EhBl0xm6C7k0Ip34c7sTnsPO0ue?=
 =?us-ascii?Q?rDrV8FcuIC/klu9oXiQXeAhuIxDTUlHA0hp9EwXVUAoR6gCatO2Wfqf3aWFL?=
 =?us-ascii?Q?nvPzQvBVI7kQbRNHZme2n5fe/G86VfpyHdN3YYrQeVfUXZzpsg+S60zRQAEg?=
 =?us-ascii?Q?kFWJlE6lBmcbPjuqVfY9bPrMsKpJ/NE5qPPqk23vha6/w61dNX+AqemN47UF?=
 =?us-ascii?Q?9CLWu7IKlGEQKASQYlRgNJg/hkxsfU71K0cNSHLvDW5ehDv3qaM2vgLsSos6?=
 =?us-ascii?Q?W2ZwEopL/b13JGF7STeWcEPjLyPdfEx2TOXFLJas/4E5TuL1fCNAHJf1YBhE?=
 =?us-ascii?Q?wSa/lV9NZvSKVBBE/LA0HnzuhKZBOOPsdZljCjA33WWfR7+6Jh1M3abkyGih?=
 =?us-ascii?Q?kFm0EC+u3GIFG/Hk4CI8wY11YJF6j9Tbn12/xHP/qBTqTXWkXMwSJunJCxDl?=
 =?us-ascii?Q?9m6SSOe0hYjsDx7spOXzex8o/uGxSX95uWu6YaOzyI5LJ5e+Ug89hV++udFO?=
 =?us-ascii?Q?OqJnqLNTRN4Hrp0VMpbtdP5kqiubO9l2v93yc6XJqs1WVZ5hjby0ChyX7aOd?=
 =?us-ascii?Q?49ffkFO8SbV0NRIK8mBi1OzlBCm69VMFXrkFIm2SWiu/LvLNiW4qQXUJEi/4?=
 =?us-ascii?Q?b37BEyH1EmZ9kAlnaIOEb0jXqi0oFhXWGqHlcB5HJA+lGTIqjmZTdcNY55GJ?=
 =?us-ascii?Q?dhv269cPKdGZgEJ0S/l0jgtFBCyQaRiqatjFZ5tyslyNCPuijonvyiGeGAr4?=
 =?us-ascii?Q?iQkgioypuUk/jb2pZ6pmtg5n5LFoQ544W6dXFAwJdoB+6o2+Jm/PA/UStaWF?=
 =?us-ascii?Q?9M3fxzz0Ah9tmzDkQieKRC8XeH8RY9qP9VHkvTSN8sHwo1W+mmVtMxMsQbgN?=
 =?us-ascii?Q?coLTsNClsz2nzD9wAUscZh/2PTPPY1nGQ2w6wdo2HHBiMVbLWsqPUk/s6loZ?=
 =?us-ascii?Q?AaCam5oz5q1tRG2S4EtFqbqQAK7C6xWzsTgA4s5h89H1ytX2Ch6TwxVRscfq?=
 =?us-ascii?Q?rGNLcCLiJQZp/VYJAabmVAOsRUQBlWE6F7/we6y24P5LVvIAUn6kZGLHnSVk?=
 =?us-ascii?Q?1/eL4u2QGIpurmxvxhGTMK5ygKJaUP9F6uY4fR1TeZpcSymU9RkAyzbyRqm3?=
 =?us-ascii?Q?0iD//nt8sc7S7NXOgaA+MV+TJjo1w2L2hSlxhI7yciC7j4d0KYSXFQVQqrqf?=
 =?us-ascii?Q?Zfn8U4ZnD2eroAQbpsalR51XkzKNuzZO0qfezYf4zGpk2OKJ6EjHdgRupLWG?=
 =?us-ascii?Q?8GIi2xAHe4QUxIQyYjBz0r0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bac7eb-4ace-41f2-7bc0-08dde5fd401e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:36:42.2784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9lWVh0OP8x+YOcvHVhiFUBqkLnNTNF9/JZLPfP1VvKVvQGg1rXp2mpPaM9vn8VTPK8g6OTVrX22qWQNIwyUP4hZPOiemBah7hgGNczQTPdsxAPSWZ1Z+IlZsOk+nu0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7408
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

Add support for reading data or images from ISSI QSPI flash.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/mtd/spi/spi-nor-tiny.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 23de64a1520..213a76c27a3 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -220,6 +220,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
 		fallthrough;
+	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
 		if (need_wren)
@@ -255,7 +256,8 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 
 #if defined(CONFIG_SPI_FLASH_SPANSION) ||	\
 	defined(CONFIG_SPI_FLASH_WINBOND) ||	\
-	defined(CONFIG_SPI_FLASH_MACRONIX)
+	defined(CONFIG_SPI_FLASH_MACRONIX) ||	\
+	defined(CONFIG_SPI_FLASH_ISSI)
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -433,7 +435,7 @@ static int spi_nor_write_tiny(struct mtd_info *mtd, loff_t to, size_t len,
 	return -ENOTSUPP;
 }
 
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -662,8 +664,9 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	/* Enable Quad I/O if needed. */
 	if (spi_nor_get_protocol_width(nor->read_proto) == 4) {
 		switch (JEDEC_MFR(info)) {
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 		case SNOR_MFR_MACRONIX:
+		case SNOR_MFR_ISSI:
 			err = macronix_quad_enable(nor);
 			break;
 #endif
-- 
2.35.3

