Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23533CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31DF84940;
	Wed, 27 May 2026 03:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fvzqYjc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A95C84940; Wed, 27 May 2026 03:19:20 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DCF848AA
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZQ2xqd5PKdRtsPPQRESS5l29O/g4uBEjwHWsPNXgC/AgHhFYU8QVIbtcqWlPDqPDh00krUgjSdY64Xpz1I6Xf4ErIiKcXFx5IaNbOjiYD7OK5u5VUIogBntlq1GVy8LylSeyeDzN3gSbQsF0abdQ7WJA/zn8kXTevGFIQhyGUrUSXlVSRQNDVRcWIsPe2q4qtarYFM3yPDZvrP2ZWLW6ViBg/LrR7uwvAYpntGyDYN1/fR+n9MtQ5UEMTzl8EBgsF6GxmeUtT7oY1B6dtS1RGH0tsSlS8gJlErIJhK9RcR2zo/DsFyDt3a5bxG7iZHygmu2XYkq/JiY06TyJIjEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYZi8jciZPZA/EtDN1bk5ibhp4V8HS+zInPizFrZWjI=;
 b=SyKWW9tbhBWXxX51AJ8MihwUQCcd3Fk74kYRs2WbJPKTD1eQGrdA+82dEOPAYRwWALk9yUscxyxeqRj0210qoOs3/uZTcSOBz0IecJwIfHKxXmovxTQXwNys1rCMn3vhsI6IUNRKK1QSd33D2pHE6yuV1jE4yJ7PFby+TEBAijTvHsyqlJk0Jz0ESb6QDze1lT9UYcAwij5wOvuk0gW9z70aFFaEm760PAXAjS+HWiETr3GTPYd5JM4qTIkjHghjKGZcuhvOPLVmN6B7Dh2uiOMbiQ8JFqGRCN7NKSu9K7TjwyyC/Y3DebtJMrLSFrSMRAiYGzL4krzYBJxPhHJtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYZi8jciZPZA/EtDN1bk5ibhp4V8HS+zInPizFrZWjI=;
 b=fvzqYjc2egRhHagQADffAIF8Zt29/hXhMyoJKKKuCxvk9oQ7Vbqbae+xtWvPB9+SnmHX4oVsXgyc4efj5Fy+5kvG+k3kRKxUwo9nuHZ/8hrLAQTY3tYFbJ7sNop9Qm0QwSv5+iuo9G1Fq5YRu8RvzMpJMovtxsRRxjbLacXn/IJUdkUbORjur3Dlg7qKQr0TXnj1Qgb//4cmPHTpJmNNJutaXSfJpvrFZjRzdSKI11hX53wCge67WgMbeoM8HO3nBZFIafTwfwk8OgoRfSGCzjTw0Wyd0eYmhKc2jgrF/mFMVWcsSgHAYORm+5L2O2OXx+8cqOkT6Uf7lSd/L3Wz+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:19:16 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:19:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 May 2026 10:35:27 +0800
Subject: [PATCH 4/5] spi: nxp: Use dev_read_addr_size_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-devfdt-spi-v1-4-37db1f6c168a@nxp.com>
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dfca4d-4acd-4889-2753-08debb8df7f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ff+VlsQxPFQKJlgSCzQFkVoGNzFobtsymJTDIoUDFuYO8OOtluBMHRTqFzLLjXFXPFGlBpskaF4W5cdF4oO8DqgUx+tUWoqK/84I7ZakXrCTjj4O9gCfNg+HFSiE3xKRxpmHY+NpzlfhPCvq+bbyg6BN49MJE4vkVlhsyD9xyA5p9vkzwuiLpEghciTVBqgk2VoAftN26AYoXcdIhYF39L29/xQQ8Y8WyYbOAUIOA4Zmc6X99Hhh9ipQUdMNlAktKTN40YRKQdQPAupdkqFPVJQirOOP0/r/XW38U4JRCW92eR6Xvb5zpPdAJc1TVIR0/U4Ywz4xisnfruwMHKD5FFm2W+Zictz3MlLkhnKAxnSbnaTI7ODaia2gBYnBObEU9QVqyrEgmzKZUXPxi0RwzDpPfWWq+Yja+fW0ICfqDLknTMW98nU6dL1TLGMHXLxjI1oxaZNyNbhYGIUcjYSjzIpZ6liEh47az9wIZQr55ByMJJjzCbthGBFqCC/4KZtG/i4lI6D4k3Xf0U6mM0oAUHg3olAodZdgjsbKQv5SMphDozdlysiGbOfyVlWEEGfR8Nu3Jos1q9ZmCQ/H+eZcJKDYnVLwDUbNAnRhqMO+3wjlRUMllw25PEvZef77xeYOBu9blGScCHfFfC3n+wxKOrx/tTncPEMuH4ZHJhI+nnC7eUL0LT98hVqKmCuc3Sh+ISjefbxLdE8dxTFgj0UU1iRVW8saH+zFLw63OiMzcGE9VP5CQ/MTLcfWhfZTWNci
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9iTlR2a2RCNWZqK3FlYlphRTQvS3UrZkNSeVBXNUdtem5KTGN4cGhVVlJL?=
 =?utf-8?B?VSt6SGJHZkRaYkFwOGlhbFgxWXM3VWdudnpYZ2lvQjlQUzBuU1NpeXBuZXkx?=
 =?utf-8?B?VDFLRGpQYzM1UkFFN0dxbW5qN0dSRDd2SjhOUnZRSVpHMnNHQUpWRnRTS0ww?=
 =?utf-8?B?NXliaFM1M0NlMU9keUU5NjdBZlNIbmNvQjhWaHVDRStaY0g3ZzdHMVRhalp6?=
 =?utf-8?B?R01IK2hGU2RjMHlBRWF5blEwb3dvaW93dEJNVlVkNG1VcmxpYmMrYU1VUEF0?=
 =?utf-8?B?bjR4R3cvUkRqMEppWUtlZWJtOGNMQ3NyUlVKMHVLTUNjTXlTK1BZSWxMK2cv?=
 =?utf-8?B?eFB1N3R5QjdNSjBoczBBSnl2eGVuZ1BvR3ljTzdDMy9ISmg0emRqTXp5MUpI?=
 =?utf-8?B?MUh5UlRFRzRkamgzUWpYZmpCa3h0ZUpwOXZuVXRlbUtwancrK3B5VmZvdFJw?=
 =?utf-8?B?ZW5lSnlORThqNzVFRGFGYVBZQmEvc0tlRCtBM2tKWWRVMENGZTJkVlI1dzVp?=
 =?utf-8?B?cEozMGZZUTBuMWFIYmxsZ1IyaEtocXFNSDZ1bGxqZUhpdlFTTlU5UWRpNnNJ?=
 =?utf-8?B?d25zdXFHaEE0OEk5ZmxaOGNrOERyWDBqcldHYk94TkFBUFRKbHBwVWVxaGow?=
 =?utf-8?B?MnpveTBPa1FTaXNzUnp0UFhIcnFKdGpvalp5NVVqcmdXY3BDbDhQSVJXdUx1?=
 =?utf-8?B?dzZ6M1h1dVBKUnpDczVUV3hXVUcrMWxsbFptRVZ6VTZIa3dKRFJheXV2VDJ0?=
 =?utf-8?B?OEJ2VmhNd2tHR1NsYW5pS3pqTTVzTFRXZUVlZVEyamhPY2pZRHZjZ3B3NjRa?=
 =?utf-8?B?NGsxY1pUQndyTm5hMWdZSDdZd1ptOVIrNXBpVlc3b1A5TW1YWncvTHFKWGF0?=
 =?utf-8?B?R0llZk9uU1ltR2VyajdkYWNpWnNOQVRMVzlVdCtHYnhFUzRjVzdtbkJ3eVh6?=
 =?utf-8?B?RUcxSU8vVUs3aDVHVCtSM0YxdXkxY0lGK3VWbVhrSFIvV1FNRUFZRUdzaFNt?=
 =?utf-8?B?N0p0bGhpZWx6czFmUkVTNE0zRllKSmQzRFluc242UnVwaUgxdkJmR2dGcnpk?=
 =?utf-8?B?ekdHcnlRNzI2ODljYXZwOGg4aW9XNUhoUi9xYy96QmM0L2FKQTkvbHdjQ2xI?=
 =?utf-8?B?d28vWlA1VFZZYStZTG5GUklhRGgrcDBvd1pyQ1c5NXVvTEw3OUFFbDJrcGVt?=
 =?utf-8?B?SzlNTS9EZjhlbnhVbVRRalNvL0NKK1NKbEZLbE1iOGgrK1hTZzFUMmNzT2ZT?=
 =?utf-8?B?MWdlUDF0ZGdpK3pTK2dSTENRNUdWTGlNZlRvVjZOOTNBZjZTeVkyY0EweUVs?=
 =?utf-8?B?V2FLRnVGQnh5b1Rya2VXN2wzTkhkT0kvWnVvL3VvNzBSTHUrMktpcGk2NjV0?=
 =?utf-8?B?VDRIN0Z4RE9vRWY2NW1jYUxRWTBDMXo0WVJMMmNIYXlvWUt6QmJabS9QR0Jj?=
 =?utf-8?B?SDlSazZVZGg0NmFVM1orTWE5blMxc09uNmcxaE5oNVZzMnluZWw2aWdIOUx4?=
 =?utf-8?B?MitwOXdQaGRORGNWMzVSaEZ5Qk9HK0xpU0t1L1JVNDFIa085UFhleFlBQjBx?=
 =?utf-8?B?RlBCRW5ZWVFwVldiUnBodThma0plcnRvLzMxVHZyV1ZpaUdSN1IyUHZlKzVt?=
 =?utf-8?B?K0FOQ042Q0Y5T2h0OFl3cDBWRGgrL2pIRklEaG1kZEpyR2ZzTy9Ddm5aMyt4?=
 =?utf-8?B?NDBpNzg2RTNMcG5oUFdDWklOcElRQVVUaFFrSE04MnZ1bkU3clY1UGZKV0lr?=
 =?utf-8?B?YlZFcHlaQzk5YktNSDUwZERQZTNUUUVqdzE4VWNQVUF5NG5scHZjL0F6ekIw?=
 =?utf-8?B?NFBmVXY1Ti9VamI3dFdINTljakZmYlQ3eHk1ZWRrbE42K204UDhTM25EYzB5?=
 =?utf-8?B?a2ttZkxkWEQ4cUE5UUkzVVJFZi9PTWdwOGNMUjhTZmtZMEhtZlJGTFh6UGVx?=
 =?utf-8?B?WlEzT0Y2dlVYamQzZFMwa1lMUmtCeHI5YlZvMjl4TWlWN0JQRmJxc2ZLbkVt?=
 =?utf-8?B?LzdDeis3L2hxaVFkdnZkTGRCQW9XUk14dnhibnlkVEkzRWRWL2tsc0p1eFZo?=
 =?utf-8?B?YTNvY3VmVzNEY0pkbFMzMndURUNSWExEK1czMFlGbGN0N2l3Y1h3WDRsWlN3?=
 =?utf-8?B?OHNSUmU2cVArUkYrMUloM3AxNDZPM2o1bmwwS1daSUVhcVkzL0hlcEJ6cGlP?=
 =?utf-8?B?VzFJL1pUQ2k4SDFlaHpLekUrbTB0STVHdW9XQWMrdHVqY3lVU3JuV0xURHJH?=
 =?utf-8?B?a1lyM2xqNHFiMlRGZE5mVjdQZTBQSDRCQVpMTmlPOWluLy9lRW5HZHphSXcx?=
 =?utf-8?B?Sk5EckJsVFZVY2dtV0hiTGU0VmU1bmNMNmJHL08xUHU0NTBwT05adz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dfca4d-4acd-4889-2753-08debb8df7f3
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:19:15.8962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeBNO1pLBZSqQbO25PS3nm3he/XNSumUJGeALh2gPCKX4hqCxq0uK/8+vKP7hC2oFyRmKcOe2LyCjLaiZ9kH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_size_name() which supports both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

Also correct type of size to 'fdt_size_t'.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/nxp_fspi.c | 8 ++++----
 drivers/spi/nxp_xspi.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 46de915c238..d3575cbb9b8 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -1050,20 +1050,20 @@ static int nxp_fspi_of_to_plat(struct udevice *bus)
 #endif
 
 	fdt_addr_t iobase;
-	fdt_addr_t iobase_size;
+	fdt_size_t iobase_size;
 	fdt_addr_t ahb_addr;
-	fdt_addr_t ahb_size;
+	fdt_size_t ahb_size;
 
 	f->dev = bus;
 
-	iobase = devfdt_get_addr_size_name(bus, "fspi_base", &iobase_size);
+	iobase = dev_read_addr_size_name(bus, "fspi_base", &iobase_size);
 	if (iobase == FDT_ADDR_T_NONE) {
 		dev_err(bus, "fspi_base regs missing\n");
 		return -ENODEV;
 	}
 	f->iobase = map_physmem(iobase, iobase_size, MAP_NOCACHE);
 
-	ahb_addr = devfdt_get_addr_size_name(bus, "fspi_mmap", &ahb_size);
+	ahb_addr = dev_read_addr_size_name(bus, "fspi_mmap", &ahb_size);
 	if (ahb_addr == FDT_ADDR_T_NONE) {
 		dev_err(bus, "fspi_mmap regs missing\n");
 		return -ENODEV;
diff --git a/drivers/spi/nxp_xspi.c b/drivers/spi/nxp_xspi.c
index 200138f5adf..7ba3f00e506 100644
--- a/drivers/spi/nxp_xspi.c
+++ b/drivers/spi/nxp_xspi.c
@@ -711,9 +711,9 @@ static int nxp_xspi_of_to_plat(struct udevice *bus)
 {
 	struct nxp_xspi *x = dev_get_priv(bus);
 	fdt_addr_t iobase;
-	fdt_addr_t iobase_size;
+	fdt_size_t iobase_size;
 	fdt_addr_t ahb_addr;
-	fdt_addr_t ahb_size;
+	fdt_size_t ahb_size;
 
 #if CONFIG_IS_ENABLED(CLK)
 	int ret;
@@ -721,14 +721,14 @@ static int nxp_xspi_of_to_plat(struct udevice *bus)
 
 	x->dev = bus;
 
-	iobase = devfdt_get_addr_size_name(bus, "xspi_base", &iobase_size);
+	iobase = dev_read_addr_size_name(bus, "xspi_base", &iobase_size);
 	if (iobase == FDT_ADDR_T_NONE) {
 		dev_err(bus, "xspi_base regs missing\n");
 		return -ENODEV;
 	}
 	x->iobase = iobase;
 
-	ahb_addr = devfdt_get_addr_size_name(bus, "xspi_mmap", &ahb_size);
+	ahb_addr = dev_read_addr_size_name(bus, "xspi_mmap", &ahb_size);
 	if (ahb_addr == FDT_ADDR_T_NONE) {
 		dev_err(bus, "xspi_mmap regs missing\n");
 		return -ENODEV;

-- 
2.51.0

