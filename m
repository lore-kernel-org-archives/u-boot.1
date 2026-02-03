Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C241DE8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D8784150;
	Tue,  3 Feb 2026 14:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lXfd+xzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047C483FC8; Tue,  3 Feb 2026 08:48:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032DA83FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxp+Sxu0ZW3l7YjIipfzKsYNQ9wxIQk62e0HPOHnmYP0yKqM00gqoHyAbYr6hjA3tPRozgnN0auypwkc+xLRgKs56dazw8TZagfftKZtvsfyLHFAulA2fHoSfj8qPWZ2L8p3wJf7feocopSWW65N/Tjk7PYmZL2UhJ2ANgt0eGNz03nVsK3aYwyW9ZhEVwYVb/tPxq1ItAi0azc2TqTe7PwNN6XuQbZUIvVDqJL8KSqVdo+Ug3E1tlZKZqCqJwLz1taD5K7AswJMMEJttk4FZiRwfTpf+9UX2dhl/QFgVzbBB0D64FLESMYuqwSKqzjxwsfEbg4G9/mOacWeSBpC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UqlBZ8tYpsPXy+QtP4LcG/OSZKv+8xBb7167lJRpmE=;
 b=mdclV29sbHnxL7fZ5PXSpuBPPuW1QrXo0uP+DfVsAZ8zYjwcteqNXtZ9ShOQPsX6gigjqWVCF8E3kG2IXjqMll8IAYENLZXHnZCYIBta9SQ+JNakXKdDzfhkxxUO+Fdq8hzPLmSngKcCgrxFHkkZMxy+vf21iPgKJgYuUuWGoxKkD1cnURQwtcigxUiRHZpPv21K9zDWVvb7m/0Df+eGBis53QL41kMBzAoBZlbilsHZx7MeOuDWCGLDXOdrzKumbToYUpD/nBS0hJEjXw9FbBSPf4VvqTxsqiwxsySh/fqwzLXgu5y2gL57Rxiy2iLYc3fMh+SEezu6pur5zrPBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UqlBZ8tYpsPXy+QtP4LcG/OSZKv+8xBb7167lJRpmE=;
 b=lXfd+xzbe6TFlq0rc0ojXKh50Kbi4IVtjLKtdq8rGhv4+3jzpWvLLmVaT73HBfnHSgqHzKGB6W3OJHSJ58StO0vz0OMkpQ6QGNKjUOHOUmewojGMTLwDWWy3QUxk+VMcFiX13paMlkRjoEreZKP0XKhfFxd3ohGIY0nLcWNsOjMyZoo7ufvGPr4JeIiEoSxwqXF/YFWRaBhRJv+l02JyLDCI0D75nGDAFUNRmcr43cZF3hg2+8mZg6HUBsGnWIc4wj5LSoS0NVKdsx7c5GaJ8BE0AN7xuppP5xHzEJP8FwqaijWU/sq/sI2VU4PO/7DE2B6qVJofWHx1FHHRh01I/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV4PR03MB8236.namprd03.prod.outlook.com (2603:10b6:408:2e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:48:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:48:52 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 3/5] mtd: nand: wire SPL NAND MTD loader into SPL build
Date: Tue,  3 Feb 2026 15:47:19 +0800
Message-ID: <20260203074721.25520-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260203074721.25520-1-dinesh.maniyam@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV4PR03MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5063db69-e864-4c17-a1c2-08de62f8ac86
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shargIJ7K7uCchfqYtJKJI6H/Qmd6xpTL4gRWBVBMANVdHrGjkgb/FACAdqI?=
 =?us-ascii?Q?SbZUByxcINCNVvq2wNy4Mhcgt9ReyONHrH6z9z2TxCiN79XM4ZAPCoPGPq1R?=
 =?us-ascii?Q?ldt7SfHG8sbl7RQJRQdWG2LWXbIYJaNpUcfZZlV9ktU3X2MiKEdK0CthI/G3?=
 =?us-ascii?Q?h1O+PG3w5rtj4TjpRuv/lrjnzdf8XIy75BSAksfFaltnqyIlg1DSshXKTQug?=
 =?us-ascii?Q?gAr9DeM0I3UsEovBJPEUjuyO9Wnn2GQ44GnvRepAHaJLCgpnmHFYY7PcLXke?=
 =?us-ascii?Q?QT6fZTbbezFmJe0B9mULC9RmJj+XzcIFeECiqdUzCjqCec+I4Pz5c00xRo4g?=
 =?us-ascii?Q?Tw4fpREiFujPH9TwNTh9Is5m9HGZbNvvhjvfSAY2tkS6g8u+RGU80RYKytBz?=
 =?us-ascii?Q?2X5MrU95E8jYAtDuHpCPEczp/wZWGoEp2KmUIrTmoZvBCseI11KLMtSqr9bm?=
 =?us-ascii?Q?5NaXH0yqyrX1gnfu4UNlsWmi/J2PjYSxywuThqQCnR3r4fd7hhn6lapiwlPM?=
 =?us-ascii?Q?sO0AkPyvsApAYT4g1QoREmorHPIOA47M3JceisDGkJzUxPD0d7//atxuqjzq?=
 =?us-ascii?Q?lrVPOd9bGZLffgO00swAdgCbhrOXxDR8va+yMiBZQSISA6xkwu8YF1W9VYQ0?=
 =?us-ascii?Q?Dk4xwtD8WI8IPTw2mg/G8mTvFAjJCFz8Q4fz1WlbQ/alEQfY+K/E7+u26RFz?=
 =?us-ascii?Q?EoFsig9rWRUb6TEGpIfgjve1GllHf41a+xUZRiEUMO7s3hgHaBTgRRtEGS3U?=
 =?us-ascii?Q?DqtqY9dRNuvZqDGPKB//ZbIFD+Q6cU2e0hBz7OqaNEhDigpzYXyYpnJg5iB3?=
 =?us-ascii?Q?c5iAyxT7EjmlsRB7S3ZW6zVSz2CRVXcmDXEYVBn77R/Q6lTS9MnzHNGux11y?=
 =?us-ascii?Q?rvcmWx/myhS4H93VzL8Un7JR8MQWYQotMXYe5NqZxV7AtDBPCNeL0Fup6Uiv?=
 =?us-ascii?Q?RJX1pwqbEGcgscQh5SeEMvM8wia4m7Z/fsZdgyrHKW0t/+uRRpPtX51kPBr3?=
 =?us-ascii?Q?zlJhQGVBXX+lKeEkmf0gBSoAt2H/tred6a2GIjMNd6LQOAIFC3nnY3BQLhXY?=
 =?us-ascii?Q?XoeOpvcl1vu9+K11ClL7LKFou6CmXQpEmVs1ouUmyUAuA6XR6sP0C7gmHeBR?=
 =?us-ascii?Q?eUd4XNba317FGeoqANI5Bp5bdAyHa0XVtpMT90bUtHsSFVw/N3SBTfFt+I+m?=
 =?us-ascii?Q?scvAN19p5gJWc497fD1KBQ/kMbzF1IcDNqDWuMUguhJ3Trtcu2zKqION3AWW?=
 =?us-ascii?Q?v8G4KCwgdwu5QQXB8o9oIZgpDVP7PG+1aOlw3qWjT8rfnUCKpztCeFq2RCme?=
 =?us-ascii?Q?EwGmX7BeF3ZBXeYhJC5ae3uvLDRN5OOFm4hCDwJ3pDMCO7mVoaFMiBsvLdrV?=
 =?us-ascii?Q?XwSigOm6117qlSIkzwMuEbFDkYYLIUJ5hi1vCwCaj2lmZ7leAX2myzg8x96v?=
 =?us-ascii?Q?4b2Fz0hYXXK/vN6AsoSv/3T8tfe5vJ3eSqAf/A8GcB7D+0CHR7A03eqWc8YI?=
 =?us-ascii?Q?KrO0/rzZRUlA8djT6dho5yctXqNgTbtQCPKYjLFJEoRocsMqKQRCgdvJgpGJ?=
 =?us-ascii?Q?Dp/cKMdxBJL5Gvwhvro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYI1TGbWMQbfmYi10KG2V/hXH0ZzxVJAQVIPd6Xi5Nds8D1jg6A3+i/T8L7B?=
 =?us-ascii?Q?Jfuu3RewhWdPaTrs9UhXNkJPjEH9gCSrkVPKLBZDIt2jFCnarXIZEedXqwb6?=
 =?us-ascii?Q?G+FlqQkzbnBeELQ92YFhHF0Z9yc+GhrDhbUsbYec7ocB7JSHQgwXaknu8Cgg?=
 =?us-ascii?Q?FJLtsmIIO8Gkt+oBnEtwBe3CccJbpgZ87vk+MHQinyx94W4sMFXv7g/WwXa1?=
 =?us-ascii?Q?4RXji8mpCmQAeH2jHCZTxVlA9GKuvETqrGZrM5aDziy2OPxbmi1zmfJ9S8U9?=
 =?us-ascii?Q?8W6DIAZaqx6fT/c60kESYzzQwejqY9/ePkU8Y/mvV8OaMR9sFPpgKQLbyx1g?=
 =?us-ascii?Q?bL/Efo/1MONd0m6pdVCn9JjLEE7ANRovsgy4nV5ZMD634Dz2mFSVaDmtG7xJ?=
 =?us-ascii?Q?yStwBmcgdSbqVQlrbhM5xbNQOim4SHt9vkBY4hNGV0DL6vlwAkUiA4KoFjTQ?=
 =?us-ascii?Q?a8fxtKXFhmBgTKZFbMu06rW8H1xJ4p6/F93Anm2m5ZzcQ3oBidotA7hnblRu?=
 =?us-ascii?Q?j5+pMLdHji0F/dQDSdZ6GY8SxGywSXOcRMm5s/eswbilwOWSx/mVFpLfqhiG?=
 =?us-ascii?Q?kG0MwhScw2uLvkQ/HpHtnfHkx+irCRGd5rQrrZtD5j3YWOEm/FucW5d8kfTB?=
 =?us-ascii?Q?/+yxmDyCzV3cSExrIeMQJP3EikQ1o5mpAQlSiFW0NbBSx3Jj9KQKCM8+377L?=
 =?us-ascii?Q?vEBzUe3lHapN/LszTdr1riQk9TU732qy8RGnIOVmuDe4UWOA4Mzjx3csL/Lr?=
 =?us-ascii?Q?0oV9vNqENwT7AD0SZDDDMx4Viahg6UqEs+6sKO0Bb4WGOSJHFxd7RfZmF1Vj?=
 =?us-ascii?Q?GMmaV7SGVLERPlqKBZ6fyiAxxGrYC1Kw6pl11L6YMgTDkVMhAf34D1yfnvlj?=
 =?us-ascii?Q?C2dzrgrldu0aFNCI4AZ+sRKmGEDpjaV0YaV3e3dW1SIO8IZq+S9DiBlOvMXj?=
 =?us-ascii?Q?mRRLoGVVvX1EbbT4JrFKU5u2ISBOYgAFYX6gi2dWhZi81tntRJOMgiTn9BXg?=
 =?us-ascii?Q?BdtnWn2cuWC74akOxJqs2vxHczBozbYFlb7NvkDIJvhYShf2TDiyIPM6O3FL?=
 =?us-ascii?Q?BiE3MgPqz6tpLxI1GdiqtL0O6iTGTz/tk/gW77UkTpH3cbLIcCCZK1kskFL9?=
 =?us-ascii?Q?6jiOUyta+LLmp7r8aR6bj+g3H5BVxHiUjzH/V/evP0Dq7MMxnJ0mPXu/ctFD?=
 =?us-ascii?Q?fVH0ZA3cBIhEh9Ft1+NfFabtfIgQCVxPv1lIVKXP9OqnLMnYVVIna1DLSaOv?=
 =?us-ascii?Q?hXejytYqe+gssuMn1rn91chvvFcErA7QzTcN16SKi6GfAhAJ4ktxOkXGRFqu?=
 =?us-ascii?Q?bC6GlxcoMk6j7A7cTl9AxL/aOtcokIFja20KUbCK2ky2jcoXPzPRDi/0Hrfa?=
 =?us-ascii?Q?V4ZDhbsR0zYCEvDHBviQDqsbLVXCYoPzbjZTQwpUyOjH3eMmzrow/VbH+T9h?=
 =?us-ascii?Q?e2SrImaqDr4UBQo7Nk2JskrPKwalZcvV6aT2QFfhgn7QcyTL3+NejzftTUtr?=
 =?us-ascii?Q?1oCbAU/p0OR0Xr0uAnS8MTkIo19aLbNk9W9C/vyDUvQoG/tsKu55mY1puPkZ?=
 =?us-ascii?Q?/CladlXI/pSnQVOm+5sQ0cx/BfX7H0u7nd9dUdYyFhIhTHIVKRy45w75VHCQ?=
 =?us-ascii?Q?p60q7ZN5XIln6Gkf9G+9dwkYFU9Gbxd8MgyMt1YhZsLAeAO5hr3OeGU0h9++?=
 =?us-ascii?Q?k3K/akrhDthV0aKuVh6SeNpzmKy7w4dxCyuM8H910b8UaBIGwMXTpa2dhhqf?=
 =?us-ascii?Q?kQPRlVr0x951UTrjFe/U5tlYkdvpIfc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5063db69-e864-4c17-a1c2-08de62f8ac86
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:48:52.7124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfSvyK8yJozzfNrGpZo9T1+pUNj278yWONnrC/b6b39IX3OCXOlPzgxwzgrXWPwpKaHYILlW9Eb5v75nQUur5Kt1TlKBXyDnPtxx09eh3zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8236
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Wire the generic SPL NAND MTD loader into the NAND SPL build when
SPL_NAND_USE_NAND_FRAMEWORK is enabled.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 76546a6287b..51a3b9a2aee 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -12,6 +12,7 @@ endif
 obj-$(CONFIG_SPL_NAND_AM33XX_BCH) += am335x_spl_bch.o
 obj-$(CONFIG_SPL_NAND_CADENCE) += cadence_spl.o
 obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
+obj-$(CONFIG_SPL_NAND_USE_NAND_FRAMEWORK) += spl_nand_mtd.o
 obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
 obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
 obj-$(CONFIG_SPL_NAND_ECC) += nand_ecc.o
-- 
2.43.7

