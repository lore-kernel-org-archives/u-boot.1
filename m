Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3F0CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 00:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4F083981;
	Tue, 28 Oct 2025 01:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gigadevice.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=gigadevice.com header.i=@gigadevice.com header.b="Z9CoNLyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0B983993; Tue, 28 Oct 2025 01:05:11 +0100 (CET)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704BB8391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gigadevice.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vlim@gigadevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omxxJ5q7N9yMq8++vE9qOm+aZAXMbMzk7ZEFXU9SYGNayNotdOSGRo4GQfI1tMAGH0zIShOJDkzik+BgKlWarMAQbOpZAbfJQVyea3wliCqc5KewAiDqZOSQSWBKPn3MtspRehecWYJNYZzfHgCEc8giPsQ1SVU2gp45rKDs3aKK9aRp61bvc/fkcqQdCxH7/beg/7doIvG1bIO77sbUZOF6zy1wZnh28rcpB7ye8+1nOwF+wZL5GUb2vA42Gv3R8xDZWCJYFbfCGsaZTosfIwnD1KrpSzL3YJ6nEv7RAA+FyqfeLbN+tpQmBsyz24w4x2tpPybO3W1v71FAw5TuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar8VB08cFH5Qc2fEt+VY11mi5+x0xR7MxnciH4zBui0=;
 b=PQpgtQ2ybVZFk/Y+bfdKtIfOMA5nUfFNKqV8Ocur4KZjwpoYZ34AyqxSGEK2QzqS8zx5rDehbv7oNMtzpvWbsPYgc2/Id0gMZgL9DmsjeSSU9lOmur02mz6RijWw6CS2JrkPAiZmPdz9YbQdQs7x3Lf9aS9o8HRk1DGUwRrHoKRR0JB4+C+J4Vjn/ic4c+FT7jfAefwnlIl4tDOjfX3olmtXpX0ppY/p6QI9Q80DPxXpRHxnw6egS/gK8iz3P6XIRLy6UvUvYcbx9FZVBQvnuY6OcaXjgvAMlRfOyIrCtLdiYTA4d0ox6uktd4IeGz1mgaJ7VXaE0v8WTXwl4iZ/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigadevice.com; dmarc=pass action=none
 header.from=gigadevice.com; dkim=pass header.d=gigadevice.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigadevice.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar8VB08cFH5Qc2fEt+VY11mi5+x0xR7MxnciH4zBui0=;
 b=Z9CoNLyOUVAz3JRR4h9en5AWK1Juo2aJc3bOmMqfT1aXEfINQDMl/k8q/sz85sPIsY+yYQAc6G6fE+EDD5BGrzNtwlEcebDvGy6kbfAfqMC3q3G4LGs7PJBjPlQYIef9tBEbZ5DJ99YBY9qGsfGnHzRS/u4vagN1+L5dMrNaqzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigadevice.com;
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com (2603:1096:4:26f::11)
 by SEZPR06MB5668.apcprd06.prod.outlook.com (2603:1096:101:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 00:05:05 +0000
Received: from SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16]) by SI6PR06MB7813.apcprd06.prod.outlook.com
 ([fe80::554d:309a:787d:e16%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 00:05:05 +0000
From: Victor <vlim@gigadevice.com>
To: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com,
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com,
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
Cc: vlim@gigadevice.com
Subject: [PATCH V1 1/1] mtd/spi: add new part numbers
Date: Mon, 27 Oct 2025 17:04:26 -0700
Message-Id: <20251028000426.90860-2-vlim@gigadevice.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028000426.90860-1-vlim@gigadevice.com>
References: <20251028000426.90860-1-vlim@gigadevice.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To SI6PR06MB7813.apcprd06.prod.outlook.com
 (2603:1096:4:26f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR06MB7813:EE_|SEZPR06MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c844b9-913b-4b01-65cd-08de15b5a609
X-LD-Processed: f84ba339-959c-4ab1-9b67-1e43414f945e,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mdrnLfLnpFoWavVDDs4rIlUFp1i8y8csHW+bV9Fn4vIGFqWsAHQ9iOiEGDYT?=
 =?us-ascii?Q?n1w1rbii+PdG5vZ1zOPBmzQt88WlNf1hwCZvF5eHimW71TIpmu7a4dgJKAyC?=
 =?us-ascii?Q?hbbkltjeBricO7yhgJFhOQpWTw3s9Zt3/GmAPBV9tZ6xx7q1oLWFVrjAOXlY?=
 =?us-ascii?Q?K+HcIsq4KERrO+ajZ+couBbLJ6T53VNhqEH/6pWU27VN9HD2Nbq7KMphcUyT?=
 =?us-ascii?Q?cPzWHfBqj5BFBD81KeraeZxaLEy2v2cN06bJQ44FIDkarXzqfaFQ09nFKvFH?=
 =?us-ascii?Q?c+xQ525XD6j8vfPDeCU5rBOT5SISdvkcuiLTuBMrTa2YdYQ4zxdfitkGVU97?=
 =?us-ascii?Q?N5alBvhneyyuv1C5VoKU1/wb2rqa6jda6+682XRw+IAsy3eftdlDoGOB1TWT?=
 =?us-ascii?Q?PQBZz2RVizr5eAaDu9+7hFQlX/KEab04zrVvITdlSXXuGVuZOLgomPjJV2cp?=
 =?us-ascii?Q?qikH+Ozk/I2qnP+5gHAul3xwpqR+GB+gAB7Iusqdh0AR03YRfjNFQco4eILk?=
 =?us-ascii?Q?dsq2OMaP6efFoz9syzqKPKQFVgegFFFR69VPpL1roFQUnm4U7U95XNW45OdO?=
 =?us-ascii?Q?HIFB44/wDbpozsKUHWDe7ABXy87/MgudxGChMfYWX5fXMxGchAzKElsDxtQa?=
 =?us-ascii?Q?YnThVf+IhbhcgC078KGV6UdeBwZfStwcQrxAuAbSoR2n63Eh2rk0SA6ylbeO?=
 =?us-ascii?Q?PitglgR2E3aZjBNg4d4wYbwNP8apwIZfsoqju0OGY/7Pxub1q/dTmi5FDaid?=
 =?us-ascii?Q?8tDlT/Aw6PccCto5kF1TCkQEGzXJhOkVuUurfY6InW0ndAiBY9+JJBvqzQQw?=
 =?us-ascii?Q?b5W7Mslt4ivqoW2TrYrfmX3g8XVnySwv6z0TyvzdI8e0X/5EuKl6sbL+89iJ?=
 =?us-ascii?Q?pHjZYiVpRiKLtBruTLHAIFZV8NBtn2UlXPq/kyd1r2PN1Io0xoJJVuKkqbtP?=
 =?us-ascii?Q?6C65FtQ1PmMd3S8a9acjqO1kH78X7ImQsiGT4U8iSo2ia0u5oPgsgurq/YZU?=
 =?us-ascii?Q?eXJTn6MMldgHZzaNKY1UC4QZYjxBMhyrKS2LEYunX0a5K/KekEqMFOXE4K/t?=
 =?us-ascii?Q?0xLRDynLKUPrTr1aNepsZCPClL45hTRohD72wDTbKOVgVn5l2MImfVfEk4RU?=
 =?us-ascii?Q?7mRWRH6l4RW0TO31UtCjJGZgnNLNo2OeNupVLAc6l96q5qycYm0bu2PnbqTT?=
 =?us-ascii?Q?n6azhEs1RpPX8cpSY1TKcucryzfEL/TO1GfND+EbYCSWMGlcGQ/40z2vPjqe?=
 =?us-ascii?Q?Rr/tq9YKFWEOjI0yUEAabGDsOQMy6GJfDyAycdRDmdGYQvrGuyukrp1Nxa3e?=
 =?us-ascii?Q?QkCkWieAn6jGf6XTM2C60myv1S1PFiFepx8uitqI4G4vXw62YzF8I/1ayTtc?=
 =?us-ascii?Q?J8VvjyloDmRllSfJuTTOuP8A4BNZkFcpKtZ/oRfSntthwTaZTMJkqOSdfIMz?=
 =?us-ascii?Q?BzsbYOGVA0PWqy1ZqBxHlHuY9nn1QvTBJn7NDoQjwb95Oosb8bpOo9iVHxlF?=
 =?us-ascii?Q?dZitsxsRC9VAlA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7813.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HgyKuJ3wlnTL4WfRsaKaHqsxdl70DNtLpK+pTwTtO8c6d5Gkk69yLj+NIaoT?=
 =?us-ascii?Q?fhNjp/KOn86e0lTKD+3mkwL8R+OR5jYBW543b+YapG9yPBWTvGdPDJd70/Gg?=
 =?us-ascii?Q?h9uBz5F6pzK737RYnW3VgHaJm0HwG8m5wEgNm8pOrdCqDccs7YalKM4JxxGz?=
 =?us-ascii?Q?OOH0UyEE8CYv+hLWGwIILRvgyeOLz42Fe5Au2c4uzPFvzN2Emjrz8Tgdrb14?=
 =?us-ascii?Q?NXJwhYVAqyoGL/clrONGAQDg4dxdl+sv5hsy659NZ6CqFB4UaksCQL1RGcjd?=
 =?us-ascii?Q?EKL0UXNlkfbVOx4VRqvFXL2NGY1jgWp2hIuKdCTZC8Yy2gHmqwjrTFscMTzm?=
 =?us-ascii?Q?IkW4dll4KucEaJORrbQAZCuWx17Eslnu/VGLdaTgLqn5r+qu6/CUQ6ySOdnB?=
 =?us-ascii?Q?4bAQV85AW942H78mZvB63YoS1FepNHX1yfIz89rZc52RzezKY8jOIqlayD+7?=
 =?us-ascii?Q?JXIfTydnUodvO/8GEgCaTs7SJsBJoBNjkPJW+UXWhDJTVELETtFzukG/lTCp?=
 =?us-ascii?Q?JofMEnZppVu5dSvYusqZLbMBawPnUU/PHjzar5xY8ommZMk7wLzsI4KBZwqI?=
 =?us-ascii?Q?NyyJj/+iemgRsx+mUbp5DgX2CJaMkLDASO8S+IUq9L532xccAN9qNQgEC9aT?=
 =?us-ascii?Q?+n/kzNpU1wzMSojT8rhjFlSf/h8UxaGVxfghHvqsQjzYSibnjR85LSAtCsGG?=
 =?us-ascii?Q?3aNgqfVJydlwByRNuJfKFgoIxPJVgc16qcczA9H/h8zR/pOIS6iwjvkvOxgg?=
 =?us-ascii?Q?oqcrQY9mPsqEOyiEWc2eA3Wy/YiBgK5xmc8yO/AIU6+4vbd6JPPba0uHUKpp?=
 =?us-ascii?Q?Yrg6NV2edC27IssVbFj+ypCHJYbXkkui/XMcmBOvjPMSTLFk0wDkTnfO+NYh?=
 =?us-ascii?Q?0pt8pCu6H3DYnipCqSA51INQ6LvP9H2pjTqEnxy+A781UwjPmsq+dYZ/1jgN?=
 =?us-ascii?Q?Kojcx1EUj+1EHGnjfSJtFQ0mqmMz/cglPvr957bsCDg/g9JH5OttMxcWizUb?=
 =?us-ascii?Q?fl1ma68+pj3YvwotPE6zCPtPRlbw7uELTK68x4NT8fl15lJtcmFcZrdUcVGM?=
 =?us-ascii?Q?3zMmi59zEqvNbOtUhn57Wd1XnkpbmdA417mCg6MLhKyAb0pTTtQWJ7laT4Q9?=
 =?us-ascii?Q?j43iCQKmda2mtntTreBD+m8ezVPGmNA4xdGjGBY195yAyPwB4ojGhYWkeYqH?=
 =?us-ascii?Q?IaiZ87xHXV3bl4mKeTKHo9vM7zIxjfqJQ/24N2STUEdIyupBxWMrQK3NoS4L?=
 =?us-ascii?Q?xiRB9yx+uWsm76AuXVtb2kWjRz+2XJ4+T97nEKztrrEOzzBpqJs8xYXjyvXt?=
 =?us-ascii?Q?QgfKp7TPlmdK8ZnD9iby6AmwAUOfTZS7fSDEigvhflBobUn2HhQkmRcOKkEK?=
 =?us-ascii?Q?y4eug3cYMcUXOcc5hHhHimhmHXBOIUpv+3JCE4tbTFxCwEEFWvuUEuyi7WVm?=
 =?us-ascii?Q?6LAk4d7x00eFnbW15ShZ5LvLPLw9ItuAFNki1Ee0QTIppgmBCU/4yX7vqkQy?=
 =?us-ascii?Q?InE6ZqlacIdQbSZGZ3Yrt1zCDLgMkTeyzzW1GCg4RxGhN86xTcLc1cTBjLk8?=
 =?us-ascii?Q?SNnAdYjnl9Uj2uiQJFIhy6GUBGiVs9qYIAajXqHUyUfD+owhq/AWWm3xzR1Z?=
 =?us-ascii?Q?lW9FZWPy+gyERUC0EMr2tfQ6yGQ5milU4eCPjUqmgrpX?=
X-OriginatorOrg: gigadevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c844b9-913b-4b01-65cd-08de15b5a609
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7813.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 00:05:05.3624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f84ba339-959c-4ab1-9b67-1e43414f945e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pwBgArGiWT0IN47y2wyiq6FHSIpX1i9Jqu7Q3DGPufP/0Ydcn4R+rpSmYMdt4auotwGOtMKhyIoTsGWV1plsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5668
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

GD25B512: ID C8401A, 3V 512Mbit
https://download.gigadevice.com/Datasheet/DS-00649-GD25B512ME-Rev1.6.pdf

GD55B01G: ID C8401B, 3V 1Gbit
https://download.gigadevice.com/Datasheet/DS-00979-GD55B01GF-Rev1.1.pdf

GD55B02G: ID C8401C, 3V 2Gbit
https://download.gigadevice.com/Datasheet/DS-00980-GD55B02GF-Rev1.2.pdf

GD55F01G: ID C8431B, 3V 1Gbit high performance
I can send the datasheet via email

GD55F02G: ID C8431C, 3V 2Gbit high performance
I can send the datasheet via email.

These parts are tested on Digilent Atry Z7 board and Xilinx Vitis.

Signed-off-by: Victor <vlim@gigadevice.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 666203c8485..5c6fc8a5155 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -123,6 +123,10 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)	},
 	{INFO("gd25b512", 0xc8401A, 0, 64 * 1024, 1024,	SECT_4K |	SPI_NOR_HAS_TB |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55b01g", 0xc8401B, 0, 64 * 1024, 2048,	SECT_4K |	SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55b02g", 0xc8401C, 0, 64 * 1024, 4096,	SECT_4K |	SPI_NOR_HAS_TB |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25b512", 0xc8471A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55b01g", 0xc8471B, 0, 64 * 1024, 2048,	SECT_4K |
@@ -137,6 +141,10 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55f512", 0xc8431A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55f01g", 0xc8431B, 0, 64 * 1024, 2048,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55f02g", 0xc8431C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25t512", 0xc8461A, 0, 64 * 1024, 1024,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55t01g", 0xc8461B, 0, 64 * 1024, 2048,	SECT_4K |
-- 
2.34.1

