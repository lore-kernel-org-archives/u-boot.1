Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25748C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F788383A;
	Tue, 22 Jul 2025 13:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PuJJrpIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715BA8376C; Tue, 22 Jul 2025 13:42:06 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B657883868
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHKjA6pFaXZUnlOll0BxVlADAnG2jCFOCyWFy3dN4u7RDjqDZQ74X/KYcHrRuq8JYnUSM7anPb30LWFt7i6jc9Q8iFFqU1aVYeyob/q3BRmNRALqmFJcOPXSEqTf1gge/XfOzudMDFJGgKdttfL4w6vfsN/fX388xUYx6ofWBEXjemyaP+dWem4aZ6rEFvcSkuSsbHVGCSV67A6fIigVIS/WZjoeseIdUcCntBSo9KBZJw5oxSvOVschd1IVf1tMKSI3gWFrswBk1TMhBkTyu1SyOI9YOzdQBTjjlHaVc6lRgSE1RIujpZpkfbVXdV/gD2HAFeM4MkUfmnJrM+t0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=WxHo0gamgWbQ5UTpcAmp40nhpYyyHFqc8Jcj6WzcJFUZiidq2RfqEZjRib3NFbRO7VBZI/cQ3Fl2zixSVWc9T47pXAsifR2VuAfFXNvKWAH+DnCXNgTwXFyAlsYZ7k1f6y4/9yuFKhAE+YY1tQjK8x0PHro1+d82SYz7JFWtQ1nuzx4mLDWLDlQCjuB3sNUXg3yBDPNIKH71UASrmkUmnTNDKoN0uo5dTRFzGO08kAmroziKKdmrmoCu4kpSr0w4erACZx7v6cTfp5qC9n9iPtFfInUYihnLkQe41cYMgLjoE4lu4wwAeiJV9bTAPWtkWxs09an3mkuWGzDk8/x2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=PuJJrpIsoDtl0gSv4oFv8hYXI0LMA2OFctOvlC8ToeVYJ/ryk+pmOzOLsGw+t+mhAcQYeZSZYwKTPE3ncmLRKp6tGVPtuU3F5t2wP5I28S2KP71gDsrpZ6GFQqhdRtfLgf4O/bhU2VNnYWA+igSF+jOw0qfXKyil9cH6dN4hBw1jm7mFOjQK8Cto3v552uR5TLRMO4GBxdZigiWu3GaFDGvCMnOGdy8exHU3BFRqbE00Gqdv5EyTEakz5aU3kXuernbg7irUZg2hwAI460+JzX3ehvX3XN3UO4k0ltDRSGR6oUKDbyUpArb15etWQc88NdpGXXCi9bGBniOrI8UHQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:01 +0000
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
Subject: [PATCH 07/19] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
Date: Tue, 22 Jul 2025 14:41:23 +0300
Message-ID: <20250722114135.768998-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: eb47aec9-6494-4bd4-f0a9-08ddc914c5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEV+sKH4rEjHsEe3G7YGLfDFXfXw9qGdNRTuqaG5k6AuIsfU1eQ8gsb17zx1?=
 =?us-ascii?Q?rC8s889jKWRbidheF+INxNJhE4OrAzZUhw17gYp880ruKcbWksufnMR7w22z?=
 =?us-ascii?Q?d7ChjTbuhjMyLSFP5Idz13dGg1YEhsp5fDSvCUgJLt861M4zXNiip3MCbsA/?=
 =?us-ascii?Q?KTc2XD3iUAUv2XCgrCAlu2GrGA6x5yNqEw/n12bZxK5F+rLLNuV+OPAKUrdU?=
 =?us-ascii?Q?fLywqXUgc8k+FeYFB4YCWc3gJGy3u7ketLeyHpHWR7c58APSlA2uDFqBxYVO?=
 =?us-ascii?Q?nHD6dpBX2gQc0KB2MYuLjUDDDyI0YB1F+8i1+hKFEZj/M5ENoMf5CVB50j9O?=
 =?us-ascii?Q?TwsEb4f6IutYihU9nxtu2eqqokbE7f9huHqFOeafwEiTQHGjzeKqaQALeMOv?=
 =?us-ascii?Q?ckl/76/vWnuf7YU1JvtMU1xUE6v00fd/gGzuxS2rzn11eGbO2Usf7s/GVBGI?=
 =?us-ascii?Q?fKSMPIKjz2JjM8gXlLW4Z1XHRgpjdO3HgOYhS0XbI1VHurz3tK0kFi51CHYW?=
 =?us-ascii?Q?TBi8RbjShtj2MNuROH4eC3La7Z4bnP+qEcL89mmeKWNrnFRJwvKaFjdkgsNy?=
 =?us-ascii?Q?fcz5trAnmqqbKMuJTVFidiTBQf7zwaukiuqEtLRxuldzkx2nZK7Dmk7dJva5?=
 =?us-ascii?Q?VpUNQZOfWkgNS/9sF9XrDio6xfvhzzJrxCPSD9Ib5mifVPmIJ7CnsVY5aQ3m?=
 =?us-ascii?Q?w1SKy5BglqffRt0LGLHXBoeHqSBoj6fvsO/1CvAHUMDXLMkj+1iLWQXZ9SeQ?=
 =?us-ascii?Q?DZeLlpRGCjyZWMvvFes9Ql0WF9TomUu76PLVlLVQ7XzhVVVlC/hygZ5DrEGo?=
 =?us-ascii?Q?4p17xA8ktJ+mv4RKvLQBVJmNDP1HbRH23YGWVx+GZakIYrH4MWtaQIt2yMX5?=
 =?us-ascii?Q?cmrf6r82ksKR7Xp+xNXOnyBOKQGB+PAcFmCfhjiO4AQ/XE0JK+4CNyTi3/qp?=
 =?us-ascii?Q?rsdchh+HBW6JQpL6FrsFkQh8oQaDCskupotRLojsyYBrme1CgZAuvTk14DNn?=
 =?us-ascii?Q?VYIEuWYzRY0rc+t7gVu3vbDh7zdNDp30jU0GErVUD3oGNyP3dAIiHemB6zHP?=
 =?us-ascii?Q?ZftCEbgs12NbdHoVnTV1YYQnGxymFW1S31BomhxQGhx9NGuuS3jWMYgce8uZ?=
 =?us-ascii?Q?OglO85VxijGdzN2BPTipuXYpiYR173C68jU3NVleBwy+XWpjuG1ZxH0/0eRh?=
 =?us-ascii?Q?Tc6wRu+hoHqWelGc/yap7QTuIBkRNsNRVurWqRbQGpt5uqdyViyBwRG9LI5V?=
 =?us-ascii?Q?ABMiRS6ZRquDLoNX/cMYJU/7umqEgDhcy9B8rdBixqzPHkTflgNMW+LBH4Mk?=
 =?us-ascii?Q?5jC1PSnhbZXUuzDxexQL4MqCS6+8A8GlwLbNNykwF7UEqFkyeDOJVXsuCTxR?=
 =?us-ascii?Q?WRJCPFuzuGfAbMtD72kA44wNvYOXZI4NYAwG7mTDAiVhy6DndLUTWWBlFx8L?=
 =?us-ascii?Q?Blm+dayN4Rsm1tsISX8mLtNJeKXiKYi5gJJKlGxGuQEWLcOrFHFBlpGvi0Ya?=
 =?us-ascii?Q?vtxvhPhAavIY0co=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBrxbXoYFjmKuV0kL8CsA20+MRPbpHx4xVddThfcfebVnU5BTXCK+gSJITEh?=
 =?us-ascii?Q?2+RGHi3AX64frK1QPlUf0d0hp5rTRrZ84bCoW0+4D30nVCqdshHHRGnldY6p?=
 =?us-ascii?Q?/8p/7uDgYolHyj+RqkHEQ2xM5nOawPVmdr/MOH5ou+wODOoBJyheVhbd3zhm?=
 =?us-ascii?Q?SwuXveuifKzjt4NuITXxt9UqCi5gjt+n8slGnH+MmPosBFSAULe8dUK471Ei?=
 =?us-ascii?Q?7F9mKrEvYto1DZAttB6FqwN3B63gHlSI0MldoXJJ3Kg5H5tttNFC0eErQ1Zr?=
 =?us-ascii?Q?iPhxZs+l1EGSSONuDsBVoybh703zoHM9qqlkFmYRqJ50IMdpm9Afh8xybsdI?=
 =?us-ascii?Q?aangaom8CQoacORxkoZwA0gxW/8lq7dI+T1Em1sno0SYNUduaK/nF7GF8/iZ?=
 =?us-ascii?Q?44aUgfs/W2FQqB+q2uEqRTltfUM16ytP8ZqVfobNHhIu1sluUxV5+/Z3utZE?=
 =?us-ascii?Q?X39XDG3AUWqK53HJ7HrjbDjCmeyC1zSRYWO2I1WDfmIMRhT20RufK3kzlTtP?=
 =?us-ascii?Q?dHRqaxZHz6AUyYtW3ELBohIzjMQOpgbIUNkGnQC0RB/7+VzZuRA3IqzMfwzs?=
 =?us-ascii?Q?MPrQsmUJ5GBBUjLE9uwoa0o3tx0PwD8I2IW1lKkgR2cHHxcAdRfQZ6aPT0GM?=
 =?us-ascii?Q?6l14Y4KIGxCCYvcu/dMkpY1GAudarsxsB8WqlmNfyjNiMrXa/CwZcHOyftd5?=
 =?us-ascii?Q?jCFfpC7v7leQmjN6CXdPN4U8AoFTIIal+1SXK8NLWrDSFA26pY9QktNmoA/e?=
 =?us-ascii?Q?JUf9S21W1rJuCAB0qQ2m2pUifeDDVVENoJx+glX+0uDrJtTwGTZzTW3WEpJF?=
 =?us-ascii?Q?oJw1Rn2sPtZtaGXq1B4p0PGU7Omy7KoTh/7XlkKmmQeSbG2z1TjUMrXwSPPU?=
 =?us-ascii?Q?xP+v0badeNnPlgD32eKARyPfkmvzGwGI+hBqdPxrcGIhUZ1nZ0pEO8+ELRF/?=
 =?us-ascii?Q?zHkYcDq0djLNbyDaOzK0+8GrUxLouPsllKTpjYBV2iNZkp7K6AUmO6E9oFcs?=
 =?us-ascii?Q?1JyYlkn0qpKfvXXXwmVLd9E9eGIsjOrR4gcSl05vsfMvMpXrpZpDDQ54ZdOv?=
 =?us-ascii?Q?7kJT6ROAdXhCVR7EHT7p/dsB6T16E6H/QUgw+aLvvc4kKnKV8vB8P3M/BaH0?=
 =?us-ascii?Q?v0+j6EywNvujLGuoela4998xUJyWTvPbGYUugTvCyQY7KMVYxEhRapfrEcmS?=
 =?us-ascii?Q?Lv3Q4qUyk9Bu+TkEpzW7Ipm/X45xuxJ6BXhjc5XBCt42oxPqPJyjuFAe1BRy?=
 =?us-ascii?Q?Ao7ZzBYVZKxg0zsUp+kDVR181SFTedFJqGV0ezCf8nQjv+J1Mz7blieeyvca?=
 =?us-ascii?Q?eHAB7/JUVeBNa/g3l74K3ciQUq7DQXhA7zbnnKZ8SUkblNDO3MKN5YQf7LwH?=
 =?us-ascii?Q?BwRwvmWdFquS2CMjKX4FROWNjQppAF/cR8EmNsLUNi0nqc2e5CJ+kDChtoga?=
 =?us-ascii?Q?OUUQdFMBEWs/8z2Q48PMuAIawuGcGaRJwdqBzFxtE99Zr9Vb5i5w5dctlrAI?=
 =?us-ascii?Q?KHFxI6wdUTrxo3+7cRmeqV3bCYzHBUs3toI8BKkklzyLmq5GWchvpoO6ZglP?=
 =?us-ascii?Q?618aFSOGxVbjCOVx6kdqBbsd9310iM4GUKDo0XAP7sQjKwXps+1FhRR+Ys6j?=
 =?us-ascii?Q?vBcMrPfIokkGsVdZVvI3Tpw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47aec9-6494-4bd4-f0a9-08ddc914c5aa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:01.0820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/seon70BkN69wfMdmy8AAJSIPIvnixE74uemqf5ehr6WMlOTmOvxW9325X5OExwAJ/MuCtAxV5oCEO8XugL6IlHzPgZP1qgHIg0mLBqZmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

This makes code closer to linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c16d3954245..098ed0c4cd2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
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
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
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
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
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
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
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
2.47.2

