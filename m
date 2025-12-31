Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC80EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 12:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 945898402F;
	Wed, 31 Dec 2025 13:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="QUgluOBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E7683F6D; Wed, 31 Dec 2025 13:33:41 +0100 (CET)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4038402F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHeDc1tNJtlBRXhOw4hIoO4O14qGisVwVMaBA87g4Jjd1mnPG5y8ZqG+Nqj3YWKIx+jaZ7FOoyBoPJt73UVNNU4ay/zzwqUawKl2iTp+z+51fcdtORhI4eFfuOErF1z9vx0u6TSxyinyC/n9xG/eK8DxVGFqqY0W9jaIvuOafA3xh9LTENLgTmRX6xpCcWnWrFpf1AGwz/32vPhULExf8yx/5pOydozfB9ojz0aDWJ9E6hFn5tuYAqGtLxMjcxmSuj6AwZBlml8YR9c9q/k7DwJzfTSVI4AOsyVhDMSu4T19SwO46ARzTlCbncef0GbIlJt3NQ4YhwcbUH9nqZuyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpJPSuR+MkcaGQO6JbaWvEbTMHmzL+HDlRjczn0v3XE=;
 b=YC0KLOMalzyMiHNI5f9tO7/Lx+Szf+5FUOBflcLH8HhSNO+GIcVTabWrXYXBX533gSOxwNMAbYC5WHPFhIzui0LMJ2ksEw1GaiSU0FDeGJ0Ddhk9jcyXH2p00oDZTqILhGYLrGw960PT9S202Pl74oTdgyJRllF/9qCGBiLCDiHNj7VfnmM7If5MpE3d/MLmRyrZ7MryTmHr6Qv3e0jJpHgyZDpcKWqO3X2GeChUyQQklt4hYRst2SYn0dzBGyIUcJMD3m+3gGlOHjdNyElFMcdRdtk6yfh2fW9Q5HxL+anUApfKdh/5GE4cJbcJ+TxIKIJ9wZOvg3w0PAPc2iIGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpJPSuR+MkcaGQO6JbaWvEbTMHmzL+HDlRjczn0v3XE=;
 b=QUgluOBBiFjvwwYQGTfAmDd1hCGeHefmSAPSz4RKlwh0cfBq+5wDRhQ3Ypk0OW1XG1Zv2a07HKAOE7FasQQEB9fPiIKmryj8XJs3MnMug3fdXZfvfoiJBJd5u1N4klqP/xJ4HY9Qe710ZcSYFmx+63zziNSirq0a7JXgW3WHnPb4LuTcdd26nbtLTLdxkOMGBmIpeJDx1oud+q47ez53tUb3uisQXHbjFWHA32k3ej0obYYGv7QdYnLecEN9+k/ghEqz38rYl7P482EVavPSQQgc8nyPzXIu9ROYOzfu74YcRrsnbKZp7vIBZLuaInngpky2SPOVb8j7oNQsj/avXQ==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by OSAPR01MB7303.jpnprd01.prod.outlook.com
 (2603:1096:604:140::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 12:33:33 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 12:33:33 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/2] mtd: spi: add support for BoyaMicro BY25Q256FS
Date: Wed, 31 Dec 2025 20:32:33 +0800
Message-ID: <OS7PR01MB13834946A7860DA02B8E59769BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
References: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251231123234.1323171-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|OSAPR01MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d80018-7a16-4b35-3612-08de4868cfa7
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|15080799012|51005399006|461199028|23021999003|19110799012|5072599009|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?235tTBK2eP0RW0Sh+dxlZl1ipURWG99d7q6X5NkQH0LpvZq/MPNQwulKjdHG?=
 =?us-ascii?Q?mevUBHCP1MbJs4r7oW5sgAQGAs2JZ1cIrtRfqygeCuoiPCTow+MkoSjo0WYN?=
 =?us-ascii?Q?Uz9HSQ+DH5ZinWMoOJ2KGh5f5sL09/QnT5yyeeXnue1JmKqg1+bu2E1tepiQ?=
 =?us-ascii?Q?877Dzugxjf6WhPH9M6M40RemlXh3XKIdJqIfxnL+AgSe0jkJAMKuSG7ieNnW?=
 =?us-ascii?Q?DE6FoUlsGmi7lppdlG4wD+v3r3omaBQZF+UKEh6AmSRDT+y4eysUBQ29l1Fw?=
 =?us-ascii?Q?+lZQdhCB8wMFNCJ97jU9r010aezhLzuvo/p7keuCIYJ1GkRXywfFY+j1GWzt?=
 =?us-ascii?Q?RCBlqMgQSxtfU6m8kCMS+4GmYMxsWn63CouPYqiPu1CbZa7JQxX7Uk9y+tb9?=
 =?us-ascii?Q?C2LB5wU6oJIiK3HPBAKn0PFxovFmZW65k9ZrB6oRtrnplaRtX+14QfvkYXAP?=
 =?us-ascii?Q?N9XLEgxxwPMe6n+nrtZdrONY4WBwQBy7VAgt50avDZCjdaqMsbwY6nZf7ZHU?=
 =?us-ascii?Q?AV6m7Ya4vUXwQ14npiD8n5UNBVyo6IzjRlMTMJPWbZ67Jsj0gbPLEnEzzAs7?=
 =?us-ascii?Q?13UME/wgKxZhogM+BPlceUX7jncuuFWRv851PJYgXQF8quKVT0XDzuXpj4Of?=
 =?us-ascii?Q?YxGUXqXxQCJ9XG7WHOpfDhaSI2ibOzMh8ZgE2T1Vs9UxyF+/N91y0t7HxsPP?=
 =?us-ascii?Q?FRkjD+xdeDorL0EkcFU8vJm4exRhNoRukFWYx+t7bxNI8mrlMU5Y8uFEkqpD?=
 =?us-ascii?Q?EwB2QAseoJT0D2+aRlioqGsgxYEHeWQdVh8hTY+9vf4VWsmbqNCaaipYh0sG?=
 =?us-ascii?Q?gy/D6zq/4ccE7hMNQeIDoT0NraUktdAloveFycT119uXMgcpWMiRcioPgb59?=
 =?us-ascii?Q?Y7HU6nFSKNConHW6N4jeJs+AFoYU3NZN2lKlGYwzLYJeBjB9XT/BvnzF9LyW?=
 =?us-ascii?Q?U7bxQcukVzvSfBy53a21uPezQwKBspy3Gp4pqLzZt1ln5KqBO5FzWja7PPmc?=
 =?us-ascii?Q?7SG0gd8ajbtWL5qa9ru5QO7PBfQsfyfCqHfEYCJG2KGrY/PocIUaHCJh+MFS?=
 =?us-ascii?Q?N6axtG1wqgYn6uaubY9eYxCRvHNFI97e5+qu9uijDBXo79WfCI2Z+2agZOQc?=
 =?us-ascii?Q?woLjiUlV/7BtlcXhlj6ZLmcxrr0Asj20CVZEVnIZXo/6q4Np9Z+CYXC8N/t3?=
 =?us-ascii?Q?qR6rVtgi2esPDuQOeKrMqYab0nIIvLdC1U40Og=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BTTghiukAgv407B/NYLovp1gK5pdo8khQo72JxBcoWWtqptpM1FDgk25WSNk?=
 =?us-ascii?Q?h/DM+Fo5eeArn91MC1k3Cd+g9k5OKF3OWdIWCJK8rQFxjNfnWWEVwBN+hxSq?=
 =?us-ascii?Q?cLN1tO3KdpZgiXsHaUsT/RGwczjVRxDl4adOQi1XLfsltOtuHefxMG7DSDCp?=
 =?us-ascii?Q?Sp0drandnBInBj6SnmERtr8ToAseyb19H3t0nhCQO5R2b7JIKgkY4tLstFHR?=
 =?us-ascii?Q?tDkp5bWt40w6wSGCB/HO1C1gdWWyrHsnn3lGHPHWOf0DklBaMiiM7pXguOX5?=
 =?us-ascii?Q?TKtFw9+ZwcO2R/fq0ytRgXmLH/2SI7Rl/kY5P/rthyh51BrltYkpCg/Sowff?=
 =?us-ascii?Q?UyRSf4ATWy6idsIUQ7HH8DyAaa9xD8kIiSQiQVdPNCh37B+k5g+xY4q3cSih?=
 =?us-ascii?Q?mYZbvEgCSMcO7tGpt1rGYcTl8o9dmCs3Xoml4I01/mYoVjA+iwMGquoQFtt0?=
 =?us-ascii?Q?yj+RfwhyNiAZ3r6S8xKAIZS4o7PaJKRwkWM1xKJWCyfKlx95oY9+SVwZ8W6L?=
 =?us-ascii?Q?+sTX5iBZQ2lodTAplA7Y4CJxTLordvGQ5EDoTxYUqFzDbdVRdC35xi1XjmhX?=
 =?us-ascii?Q?WmuzcR+Gc7XReje04REviN5Ar8/xRz9B1BarI2dEcRupriIQD4hurpVEff6i?=
 =?us-ascii?Q?lNyoBp3b3VwOI5UZA+lqlPZzK4fsyNcWXmq93LFM9YfuvjDSzrqZAtG7ohX0?=
 =?us-ascii?Q?UqJAINgsB1Xt9a72G4qEY/dkQkqx3XSFXUy+Ym/J8HcvnkCSjRUrwQj/Poaf?=
 =?us-ascii?Q?nCCQlamdULzlwaJiX4ZhE9m3UBHOkc3rbZrxVZGAS5LtP/Aiga77DqjKPqHG?=
 =?us-ascii?Q?B+3XPMY/CxaBU7jypE5BlwiVafebTOvjwgSv0dAcLXt3f7wDYqypMqjDfxKv?=
 =?us-ascii?Q?KIaJBkKtHwlefR05IJG5yzxfszNq05/0PW4csXKNXSCMbD13Mp+FTMmTQCZe?=
 =?us-ascii?Q?NliDa6oLMEmn/PCfiWu8dQ30FtoZUyGaVuP0aidF//1uJaR8w384OWM+LRi5?=
 =?us-ascii?Q?hWlrt2qXdpWcT4tZKcaN2dH8sQO5gB1EB6a2SVsEXRF6FPKILS5gxoIQVSl/?=
 =?us-ascii?Q?W+HRoDZrk0zLDBab9YFC7QFnn6etJP57iO6QnSA2G/74X+KAazmabBi8Dh5C?=
 =?us-ascii?Q?ittF17jEpy+TO9ujrOS83Obu5V/H0FqUamCoJj53+xpZyxIe3i8+ABqkdKDG?=
 =?us-ascii?Q?unB3aeWQGFK1TPrq0QRqI2eNVE1w1oU4vyB34iO2BasxG6pZ3PvBvoZEkVL0?=
 =?us-ascii?Q?aP+S6rlW0uDjIrvG7HEYvFwXJ6hyS4P2n7vGqHJNh93qNfEduarJuT9PneLJ?=
 =?us-ascii?Q?YmXg3bxh4hQK5TXGIb/rfI6WSL3Q4BSqi3yv/9iert/7Fc/k8Kkf7WBnqMaa?=
 =?us-ascii?Q?mkHlCxlIsGNtOksRabinIUeQjJA2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d80018-7a16-4b35-3612-08de4868cfa7
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 12:33:33.3815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7303
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

BY25Q256FS is a 256 Mb SPI NOR Flash chip. This Flash supports the
SFDP standard. Since SFDP is optional in u-boot, we still describe
all features it supports in the flash info table. This change has
been tested on Mediatek MT7981 platform. SFDP dump:

00000000  53 46 44 50 08 01 02 ff  00 07 01 10 30 00 00 ff  |SFDP........0...|
00000010  68 00 01 03 90 00 00 ff  84 01 01 02 c0 00 00 ff  |h...............|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000030  e5 20 fb ff ff ff ff 0f  44 eb 08 6b 08 3b 42 bb  |. ......D..k.;B.|
00000040  fe ff ff ff ff ff 00 ff  ff ff 44 eb 0c 20 0f 52  |..........D.. .R|
00000050  10 d8 00 ff 22 4a 05 ff  82 e9 14 ce ed 61 06 33  |...."J.......a.3|
00000060  7a 75 7a 75 07 b3 d5 5c  11 42 44 ff 88 50 00 01  |zuzu...\.BD..P..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000080  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
00000090  00 36 00 27 9e f9 77 64  fc cb ff ff ff ff ff ff  |.6.'..wd........|
000000a0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000b0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
000000c0  ff 8e 00 fe 21 5c dc ff                           |....!\..|

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mtd/spi/Kconfig        | 5 +++++
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 drivers/mtd/spi/spi-nor-ids.c  | 7 +++++++
 drivers/mtd/spi/spi-nor-tiny.c | 4 +++-
 include/linux/mtd/spi-nor.h    | 1 +
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index ca60a425ba3..68f81079715 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -156,6 +156,11 @@ config SPI_FLASH_ATMEL
 	help
 	  Add support for various Atmel SPI flash chips (AT45xxx and AT25xxx)
 
+config SPI_FLASH_BOYAMICRO
+	bool "BoyaMicro SPI flash support"
+	help
+	  Add support for various BoyaMicro SPI flash chips (BY25xxx)
+
 config SPI_FLASH_EON
 	bool "EON SPI flash support"
 	help
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 5fa7ba27ae5..1a844057d9f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -193,7 +193,8 @@ struct sfdp_header {
 #define SNOR_SR1_BIT6_QUAD_ENABLE
 #endif
 
-#if IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
+#if IS_ENABLED(CONFIG_SPI_FLASH_BOYAMICRO) || \
+    IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
     IS_ENABLED(CONFIG_SPI_FLASH_WINBOND)
 #define SNOR_SR2_BIT1_QUAD_ENABLE
 #endif
@@ -765,6 +766,7 @@ static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
 		fallthrough;
+	case SNOR_MFR_BOYAMICRO:
 	case SNOR_MFR_ISSI:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b6a07fa9063..1bda2854ade 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -77,6 +77,13 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("at25sl321",	0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
 	{ INFO("at26df081a",	0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
 #endif
+#ifdef CONFIG_SPI_FLASH_BOYAMICRO	/* BoyaMicro */
+	{
+		INFO("BY25Q256FS", 0x684919, 0, 64 * 1024, 512,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+	},
+#endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */
 	{ INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K) },
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index dde290ca6a4..5d8cee3f1c6 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -40,7 +40,8 @@
 #define SNOR_SR1_BIT6_QUAD_ENABLE
 #endif
 
-#if IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
+#if IS_ENABLED(CONFIG_SPI_FLASH_BOYAMICRO) || \
+    IS_ENABLED(CONFIG_SPI_FLASH_SPANSION) || \
     IS_ENABLED(CONFIG_SPI_FLASH_WINBOND)
 #define SNOR_SR2_BIT1_QUAD_ENABLE
 #endif
@@ -229,6 +230,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 		/* Some Micron need WREN command; all will accept it */
 		need_wren = true;
 		fallthrough;
+	case SNOR_MFR_BOYAMICRO:
 	case SNOR_MFR_MACRONIX:
 	case SNOR_MFR_WINBOND:
 		if (need_wren)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4eef4ab0488..8768d794592 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -23,6 +23,7 @@
  * Sometimes these are the same as CFI IDs, but sometimes they aren't.
  */
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
+#define SNOR_MFR_BOYAMICRO	0x68
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
 #define SNOR_MFR_ST		CFI_MFR_ST /* ST Micro <--> Micron */
-- 
2.51.0

