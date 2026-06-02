Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0644CCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3F6848EB;
	Tue,  2 Jun 2026 12:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mc9w+MFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC75083FEC; Tue,  2 Jun 2026 12:04:14 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F014848EE
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg5wnLg98cWvAkDoAKVp2pdyvFp0BlDLH0R/uN1pj9dkPJc/Bl1lrCwCX0A4/iDRO9e2JoRyAFw8CoIlqZCxByJLKA9vjSAJgrBAgowNg0b2teJZGMAM2tp09tHK/+8sM0rOShj5lL8bFX8cq1odGgHYQcadTwaEyepVPFXWUhORkMJtxgB29a027ZlEXxVFkmC9y8ZfAvVXx8ICjcDK/0pw0tv20vZSEvJrl2N0j2ombXRYb+g5s0h47TgYiWqM8ApMcffB3RZXDTbjPHM48cir+n2eEtgsCs9zlwmyMbcmqwVN6CWwi9BDOzwuCq5UfQtMNuOqcN5rxU2ZsB87hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO8gwb9G3m8VHUkD8WnbicpToVVJ8NvFIyBzoW7WbdY=;
 b=sfDvB9Si9A2ZSaUzm3K73QzZ0f4vPFgmmWlfETFDMO4Ir7x4JFDweURIPuI0x6HdjxtuOQJe4SlibLrJarUQMR3tPvSSUYz7sFAyr8uHkO+YbOLY1sqcKdvk/FVdSjUEyUJwlI2OA2nJHPkMweaRxQHlBgep1NW6d4F17S7YcrQK2Qw+KrVb5g0zvUl1dGbOeA+l6G8zr4HyhZWTfP6orWIX7yt9WgiLSmcRQ2t6CNbk/8uH0R9Wf1gqAUktKE7zkaViactJBSVnIwVtfs+WCX91ylE9D1Fgh5q5UDO1nMjrWrN0X+5tAwFuVlCnPAuvvaLLMLf1KQSE8IZG8DpnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO8gwb9G3m8VHUkD8WnbicpToVVJ8NvFIyBzoW7WbdY=;
 b=mc9w+MFwpLjWps6gNPWgIJUqRi/2HNDm4Jl2PDolYd57MvMTXL/VizfeMcUOAke3oHR2lGI2lssDT+WZ175ba3cJc1veBjVOmifYJ/1lu6wbRSJF+qOIdQrMraQEAJOmaOp8ylyfN6HEY9Wi49VRH09IuupiqBF2H85F8p1r83riRk2vuEzfjHevbqPC2FpE14Gd9PYfz2uFgiC4K8RzX00sVZBJPBpg4nK5w8rTXfgfND1GvZYDGLB5iFS5ZZyt7oLMQ4C/GUiLikRsp83tCm/GKkLnn2hZ9fakJt0SQBU49rboV8imAa5ZBZcPhYSP4LSjD1UGgGEyHWIyptAgkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:04:08 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:04:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:20:19 +0800
Subject: [PATCH v2 5/5] spi: ti_qspi: Use device APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-spi-v2-5-08374650778a@nxp.com>
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>
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
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fe672d-f709-4484-d792-08dec08e497e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|22082099003|18002099003|38350700014|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: J1bJyl1M9DkmsaTKZeVkH64vswEx9YPeJqhUhbKkKfm1iIx1H9oaLXbphK8X3cBmMqleoxfalhPG3Ma6B0ofhdEgLVbfP+kw/379TIZ5yc920OCgmgXTxv1QHezCEBelfkhAQ7Inu92B6q2CVWZsKbCwXMz8Ol8/dat8/r1VskMA8fp0A/EFvDXrJZINX+AGVyFfT1qUL5RghXIriGgmp5qg0Jy1y2sQ4BZQF63P+2SCzl+yOu6DezPYdnKm6LcxJ9zrK2Vts/iZ6v2nt70Y5sVzjMu3rcRTQUfF7gl2BDvT46ypbb1RDT0FWsoMnygA8cR3CaMQBwRIVM3Ktk7E/rg91fkgokF+CDRfM3elyU3qaT1sxHlfs94YLOSFAY7Jt6QR2svi9AaEUx+luSPEN6xI+GDTK1VyITrIQ7LLQzaqzXgys7CaXT85VMVcKm4OgC+zLHIn5XkaxEbOJy1eLcSZDgntCUFnCEWeCg8lndIJDdb/NA6E2aeiAb51dlXZMOHm4NvfJfswjJ0Dl9KavdNspuVk8O84X+N3KWxRsS5QIVlzcmsI5Ql8vAOtoP1BT66AZbhZK7S33QCw05bmVOvdsxmvyQ6eRC9qq2SAFhr4leHMHHjj/FwnS8uWe4iDs3E5Fd9Bj9hUnKTPf/H8ovNJeTUyNoNUBudN42+9xJEC0+a1o8zw3c0pdageAUQC6nF5Wd5BL31qMvPGlYcq7JS2PaxBTI2d4g4eAYoLBPtICZ9BveSKjWoGO8/OEQYp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVIOCtXbE5iT0IxR0owdEU1cGR3b3pSMndiaXNEY1haSmdFQjVPdkJRVS8x?=
 =?utf-8?B?dlFON0pHMkpYaXZzYnlzT2tubStnVnloZlNFUWNyMXFjK2tmWXlvMWVDbm5x?=
 =?utf-8?B?cEtZSXNraE90Uks2bldBcUNGVVg3bEtvR2YvOG05MWRwenVjU3RXZU13akVI?=
 =?utf-8?B?LzFDU0EvSUpuWDF5eXdPdFdIeWk1UG5HTGVrQTE1RzVtMTgzU2JWNGFiTlRz?=
 =?utf-8?B?c2tqWHNhcHJaR291OHBUVWdTVWVzajQ0RW1EYkhYNGU1RGFQTU9iMmlaQm4y?=
 =?utf-8?B?TTRxWnJNVGQySDNhdGZlOG1rSjhXYk1VWGo5MjlEaGxrTm5zSmowcE9CRnd6?=
 =?utf-8?B?cUlZS0NrVkVoaHN0ZTVyR1JBTEhROFhvRjVNa0NCZzRHU1JpWHZJekpzVGhM?=
 =?utf-8?B?Vk5QcllYS1NMOThMb2NpaENPbDV1QWdEZ0hjVnA1SUk0eEJ1anM2TzlHa2Fj?=
 =?utf-8?B?bmY3Rjgvd29ORmtpYlpmRmJxNXNVWHhkOCthV29HaXQybkNyRU5RTnZPc1Vh?=
 =?utf-8?B?M2NoL1MzckM0cXFwZ0ZjdlluQ3g1UjhIV1Rwdmo4aGFFMGFxMlU5ZkR4NWww?=
 =?utf-8?B?aGJNckNIOEFoNTFXNkYvdzVSeW51TVNpRUVJTjJHUHh0OWpDb1U2b1BFcXJ0?=
 =?utf-8?B?cFQrNkxKZjQ5UzdCZE5IeEZnMkNuQkVzU0VoaGtyaUNSZ28zcVRmTE51NkFy?=
 =?utf-8?B?ZGttL1BiVDl2TUlRS1pubEtqSXFlSkREZDlGc0JMMEFqN0hpM1NQYmFDOHdQ?=
 =?utf-8?B?QVNGWnJuMHN4TnJKSWprdytSMWdqSThYSmpjWXpDa0lQaGZtZWF0VEJlUkpS?=
 =?utf-8?B?RjgrcmtYUXhwZWtCYS9zd1JIR21PbnZrYkxlZWtxU2dRaHRJR0tsMTlpQW12?=
 =?utf-8?B?QTRGVlhIbnBUTjFkTVJXLzV3SlJiTFZqaHRNQmFLakdIeXVpeW9Cb25MUVM3?=
 =?utf-8?B?cUxPYzRLT1BaRzRFby9oSERkM3FxQWwzSU52ZzJsMVVObVVXTzMwcmJZWUc4?=
 =?utf-8?B?cU8vK1cwV29sN0VNd01ZYitQR2oyYm9mWStNVHc2cUlva1kwcTA4dlJHZ2Nu?=
 =?utf-8?B?a2RTeWQ5T21KTDlEaVhSb2VqUmpqT0RsbTRPUUNWNGFyS01taTdJbU5FL1hE?=
 =?utf-8?B?K0Nsa1dJQjROVjJ1bHAwS3VnNjErVW8wWkd3VkVpOUVhMTlaaXdhU0xaSm51?=
 =?utf-8?B?N3lscHI1TjJ2eGxPMnhTZm44SUhqVWVWTE5Uc3U5Mi96M1Flc1pJNkx4N1Ax?=
 =?utf-8?B?ZDZVSmRvMXhMZTNsNzFFWGZBOWN2dWcrOWxzb1JXNU9WSk1JNkJWODQ5QWxK?=
 =?utf-8?B?WCtic3BiN21BVnNUMmd5bVZ0TGFPaERQQkFKd0hOU3RLb2F1RHBVSHJ5OWx2?=
 =?utf-8?B?NVB0ekdIL3Z4WktLZlhHY1hoc1J2U2Z6aDYxVTMzMVIzMTlHVXpZbmowTHM0?=
 =?utf-8?B?aGhQQ24xQXlUL3R3OFF6SHRDa3Yzald4UC9DZ3VjL1M1M2NjUzBFRlVhODVU?=
 =?utf-8?B?T3lJYUJOMHc0R2Z1T2hqbE1KaCtHOWtMVDZOSVBZVVREUG9yTDFGRTA1L1lw?=
 =?utf-8?B?N0dGNUtDQVc5cm1wV0dyazdMN0txZXo2RHlyZGxtK2hGZDhNcVJHR3VkZ0hp?=
 =?utf-8?B?V3FiWlM5WkRwTktyMkhUQm9ja29kMzlSVTlOOENQNUE2VGlkeEVHU1RrWlBX?=
 =?utf-8?B?QzlNREluOTJPeFowbUlTSi81c0R4Ykp6WmpKY0ZJWFZEYzVpQmE4TFhQR3k0?=
 =?utf-8?B?V2VVNjFuVXZNSDNQZHFEQU9EbWNaME9GWkMxODIwb3R4MnBHWE95Wkl2eXRC?=
 =?utf-8?B?YjhpSkNERllvNkdLYXgzZDExRWRudFVINVVxZ1pUUUVnM1BjRXRLTTJQOWJM?=
 =?utf-8?B?eldPendOd3dhNDZ3LzlMLzM1ZjNERTJkeWhNdUFWclJKaTUrdlloeE02YmlV?=
 =?utf-8?B?akhWUi9tQlR6MXBIYTlGZkoyVXE5UG55dmFGa0R4NzB0ZUhVY0pqbXc4dld6?=
 =?utf-8?B?SGQrbUIxbU9FYzdtaGliQndvZGd5ZFRNUzVmUUJZMEFzWWtpWXhqcVFYRlpU?=
 =?utf-8?B?ZXdvMXJMb3ZQa3VXVFh3Lyt5eE9qc2pHVjJPWEFYRlVySzkvUE9wM1RQMmZR?=
 =?utf-8?B?TUg4MnRPOVFNbzJtZXhxU0VvNXM3S3p1V1NZVEx0ckdkNXlyTEpwbWJjQ08v?=
 =?utf-8?B?MmFxYjlVVWJYeTBlQzRmbGdsOEExMk1TUjhjUVdOQjgvQnJRcmpGbTMvWHBh?=
 =?utf-8?B?WWhab3ZOWnlBcGlyUDNqamNBOFgvb3d3MEhnRDBrbFcyR21KOThscXlqdWcv?=
 =?utf-8?B?OGdhQndUMW9sdkRraWJFbnRZRFBSSDJHOTQrb3hYYkl2UE5peE5QUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fe672d-f709-4484-d792-08dec08e497e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:04:08.5006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQbZkurK26pmnup5MjovIkSeLBVjgocNT97CMgDujIDt5MmC824hEhro5K9pXq0Z0po34DkJjDFX7P92arx6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8397
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

Convert the driver to use driver model APIs for phandle parsing and address
handling instead of legacy FDT interfaces.

Replace fdt_getprop() parsing of "syscon-chipselects" with
dev_read_phandle_with_args(), and switch address-related helpers
from devfdt_*() to dev_read_*() variants.

Also update "num-cs" handling to use dev_read_u32_default().

Remove direct dependencies on gd->fdt_blob and simplify the code while
keeping the existing behavior.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/ti_qspi.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
index 1f2494e592c..d0ec84a0128 100644
--- a/drivers/spi/ti_qspi.c
+++ b/drivers/spi/ti_qspi.c
@@ -417,10 +417,10 @@ static int ti_qspi_probe(struct udevice *bus)
 static void *map_syscon_chipselects(struct udevice *bus)
 {
 #if CONFIG_IS_ENABLED(SYSCON)
+	struct ofnode_phandle_args args;
 	struct udevice *syscon;
 	struct regmap *regmap;
-	const fdt32_t *cell;
-	int len, err;
+	int err;
 
 	err = uclass_get_device_by_phandle(UCLASS_SYSCON, bus,
 					   "syscon-chipselects", &syscon);
@@ -437,17 +437,17 @@ static void *map_syscon_chipselects(struct udevice *bus)
 		return NULL;
 	}
 
-	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(bus),
-			   "syscon-chipselects", &len);
-	if (len < 2*sizeof(fdt32_t)) {
+	err = dev_read_phandle_with_args(bus, "syscon-chipselects", NULL,
+					 1, 0, &args);
+	if (err || args.args_count < 1) {
 		debug("%s: offset not available\n", __func__);
 		return NULL;
 	}
 
-	return fdtdec_get_number(cell + 1, 1) + regmap_get_range(regmap, 0);
+	return args.args[0] + regmap_get_range(regmap, 0);
 #else
 	fdt_addr_t addr;
-	addr = devfdt_get_addr_index(bus, 2);
+	addr = dev_read_addr_index(bus, 2);
 	return (addr == FDT_ADDR_T_NONE) ? NULL :
 		map_physmem(addr, 0, MAP_NOCACHE);
 #endif
@@ -456,15 +456,13 @@ static void *map_syscon_chipselects(struct udevice *bus)
 static int ti_qspi_of_to_plat(struct udevice *bus)
 {
 	struct ti_qspi_priv *priv = dev_get_priv(bus);
-	const void *blob = gd->fdt_blob;
-	int node = dev_of_offset(bus);
 	fdt_addr_t mmap_addr;
-	fdt_addr_t mmap_size;
+	fdt_size_t mmap_size;
 
 	priv->ctrl_mod_mmap = map_syscon_chipselects(bus);
 	priv->base = map_physmem(dev_read_addr(bus),
 				 sizeof(struct ti_qspi_regs), MAP_NOCACHE);
-	mmap_addr = devfdt_get_addr_size_index(bus, 1, &mmap_size);
+	mmap_addr = dev_read_addr_size_index(bus, 1, &mmap_size);
 	priv->memory_map = map_physmem(mmap_addr, mmap_size, MAP_NOCACHE);
 	priv->mmap_size = mmap_size;
 
@@ -473,7 +471,7 @@ static int ti_qspi_of_to_plat(struct udevice *bus)
 		debug("Error: Max frequency missing\n");
 		return -ENODEV;
 	}
-	priv->num_cs = fdtdec_get_int(blob, node, "num-cs", 4);
+	priv->num_cs = dev_read_u32_default(bus, "num-cs", 4);
 
 	debug("%s: regs=<0x%x>, max-frequency=%d\n", __func__,
 	      (int)priv->base, priv->max_hz);

-- 
2.51.0

