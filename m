Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76946CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF5784946;
	Wed, 27 May 2026 03:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vnueq2En";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8919C848AA; Wed, 27 May 2026 03:19:28 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9294884975
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaS6fyBDuoVyjGKwLk1cneCcEfK3GAxCj3xSLpUQYybAwigCdxYxYIU45R15E4mjbNo6NW33qhimR3QmoCEJly4bETUWFP2HaKjVZRnzjxtP5wshNFuCEEO42EO5hf5HHOx2VcW7Qhgy0F/QyRVAjGOJHmOFWdtGfChB6hDSZquOK9HN0qMjBP7hJcPbaqlk16nq1FOvrZg9huv4Ba3H0hXemsLAOYoU2CeBSeMe6Tg2/uYT33wWkHAspbLhqM7PHwaIPN84FfEip/ftaupu5Yf3iOvnhV/Pwcd5CQzCNE3O5kpQtxQunZZWts1giZkNtcITBaNnN8ot1fM5RtPTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q/cFaXkT6DexO5gYhqVe9xhhraqYJF0grdklSe8QQc=;
 b=NTAWtQRI19qEPPQX5GSK30mQ3iMNCmRNZDfUhT1CPvSB445yW1kgkgyWo8JLPiSx8MjGtFb/cHg9UiL0MwFpq55KfBEFQUMXuPCmmmmIWNb6vTAHfdhHZKvPmHw0XYdH+2EqGhW0GRZKZXTs4IkoD6aSlYHW+TR8KiHM9LaJDRpP4/edLTQtZGCiNf7+b6sdPE2Ty9MnSMsWOG6icTqiEOTKs4/DbYuKx+L2jvk+RVzLXU++Nt9WQs/gYDMtOuamk553FkbmdMMYES4Z9O7gKLe8ndHUMy3UOMO6V2XwSdLr9HUnzI8elTDlFaLgoLPLUtVUVePkFdOCOjRsJjHZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q/cFaXkT6DexO5gYhqVe9xhhraqYJF0grdklSe8QQc=;
 b=vnueq2Enc8nhiSQvsQJV2sETNQ6xF9Wkz9OgWbjlust1xtPOq69U2ZCaRI1KPSol7wDuGwaHZDisV+3zO4O15DmVkCPKTO6Cm93YKhI8x6RO1y2zxV0fnLpnj/eeODEyfZHK5h4zOXbiU8VUgw5yw4c+GWArDUgBDwCmAOS0g54f89QhpUl54aaD3hsjRJB6UBIUgG/fOj53rh/60k4ID26naLtVYWg4zMNqBDROdogc0YgMcuB+dq9GKbtOjUfqvNRXOX3FWpwlvFtv2Hr/4BpuR3ir4Sm8GLdHJGftWCTHHptjeVrBrnzLfeMOtG20KqicmEDJU2b1VQqnEIOa8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:19:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:19:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 May 2026 10:35:28 +0800
Subject: [PATCH 5/5] spi: ti_qspi: Use device APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-devfdt-spi-v1-5-37db1f6c168a@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c86023e8-1624-412d-ca32-08debb8dfc9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ac4h9+ApJywK//GdI50Z35/PCsj60MqzBjBsfPaGg2qt8sS9qGCo7IXnlrSAxLZp7OkDZhwYMRuyvrLk3Viw2teHSWlvieGR5B0nChgqasSgMZ23IrHTf0++xSpBLCLJrz8EH/8cFVYY43mWehp0Boq1CZAnc4r+rhmA6vk0Sp2xQFbrllTiDturYibIuxavsxtHhPAreN0vsAu3m2Po9TFimPT38Ur0g4PFiwbsU8+kOTGdvkXsKNyKGCDRQqUCBSdVz61V67pMrlwctpcKEUDJKsDDFItlQtwNFNUAHVyIyy+4fi3ZmmR8O2eFV2iGZAZIIrXrym7C0Ag29sWoUpm3l+xlHubHRjahK87hCsf29fh/EjNHjgJJ7t7QLRBOvjOm9msMF2yb7l1v7o7yEnn4zGeiX5SYYFMAqFYjIF1BRIdyNB6nDkixgzLnivAcNWGwuTCQWV8muwbhEMGuptno/vu9htLx6nbUwd+cH/A2b9gI2KUA+4jcrFryPD/2SFY+2Ug95Lf7zvcjlPHf1fI3fRLlicjgqxYDTz2612ndkt0SZEHRPSVefAYE2blOn4SFVBljfS7eOisALXNHKdHS8YpnETik6WrAwqwqvCgM7Jk/KleaNbXNcrXSTW2U2nZcgq+Mf+iE4BVwG9g5g8ZcxRkVkMDusC+nqivtuAH0R5Dx9tJ7+1gZGXEFNLX+EHwnOxBV+6teAs6SIT4SQv1s+ETYqWyQCdUMUp2Y1SpyModF1TLNDA/AD6GvJaTv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFiM2hwWk1zQkZXK2Q2M09SbVowYmduQk1tc3M4RmRUWWxTYWJvRHpXd2o2?=
 =?utf-8?B?b3R4THJZL0xzTGh3ZXcycEx2MUNaNURsKzFzK0RJcVphVjJOUHoxL1d1cDJ3?=
 =?utf-8?B?ZUVFdWFHdEFGVjgxUEdxZVJDNDNXSE14SFJ1bWgwOFhUNkJVeVRnN2UvVXRa?=
 =?utf-8?B?TzVHeVg4S1lnY3hYbjVlSzU0bXBmL3l1WmFtMWV2Y2lvdDFmRjdTbDB6WlNo?=
 =?utf-8?B?TE9ac20vdW1KUU1scDVxN1M3cjJQdmhzc25SUXU4QTZuNi9IOEhGNzdYODFX?=
 =?utf-8?B?cnFsZWMvRVo1VEU5WGxXRWNYSHNqU1NDOHozcytweFgwVCtta1ZuSnRFVnpF?=
 =?utf-8?B?QkkraVFpdzJYOUJ5bXRscW4xYjR2OTQzSnFwMkZIb1RtUDMzb1pCdjJEeHJr?=
 =?utf-8?B?R2NLS05LelZSaitYWVFZN2JZODRlZWVZRWtDM25aRUc1eEJyQzluOHZpL3Rs?=
 =?utf-8?B?dDdhOWZldFJsSXdmNjZRMTR1cElwL25oNXVTMjlvbkpENUpVcGZ1REJQd0pJ?=
 =?utf-8?B?Zlo3anNZbFNsQkhkcWJxNUtPUEEydldSR2lPM3hrQ0xEdkZMYURlc25YVS83?=
 =?utf-8?B?elEyM1F4bXFrSEF6Wm1zYVQxekJpNHMvbklBRjlSUFU0UGt1QUpaZmhTekk5?=
 =?utf-8?B?ZGNxQmx4RWthYlA3M09yMGdGcHNzdUY2V1dud0kxWnF5d0ZoYmdmK0VveTZq?=
 =?utf-8?B?TnhqZFBETWlpb3NtWEZXaFZtYzNETUxLcUQzbzBYc0gwU2JwaEd3SVhCUEJX?=
 =?utf-8?B?SExLK3huWDFLc3h0eThiZUoyTURoNXNlSDVYMmhnL1pqaFNpdi9Dd3Fna2dj?=
 =?utf-8?B?ZzFhT3FKUkJwZ1RoNm5EUTFwUFhjUUU1UzIwUnN0dlhTVVo3WWxvai9oUjI2?=
 =?utf-8?B?VkpUZkJBTW9kWHBYc2pTSnVqVjI3c0hJcE9qT3NmT0JqUGtKUHVkNmxha1Vh?=
 =?utf-8?B?Y0RQY1cxRDA1OHJwcXpaK0lvM2pGMDhxOEVpYjRvMm9WSURlQlhacG1KVlQ3?=
 =?utf-8?B?MkRjWStzVzA1bjlkSHBrMS8vb2F6cElLRlIxR0E0b3RJME9Nd3dDTVF3enFS?=
 =?utf-8?B?VEFzWjRaOE9zWStnNDRmMUV6ZlJENnpjMHBzazJIaWYyenBMWGdFWUJ4Nld4?=
 =?utf-8?B?OXdSMnkvYXRCMHRLaXAyQlhDcStnTVZuOVowb3A4OTlxMkdmNit5SzlJMlly?=
 =?utf-8?B?QWJHZ1pqemF0MnpPcXM5ckxheCs0NGNGcmNNMExiZWRSZTFNelFlNVpPeDgz?=
 =?utf-8?B?ZGFQZEJuMGR2b2dITUNuZ294NkpJR2ZhNFhSODRHVEoxRGxCV3lKOWVmQmto?=
 =?utf-8?B?SDhQSWhWUC9LeDZYM3luQ01zTk11a1hnU3g2b1hJYVNNYW0wbXZNQkU5Q2ls?=
 =?utf-8?B?S3RzeXVJNmVXdUM0d1hRVEdheTRsY3gvQzhsUWZ4WXp1MXRGaS9BemNSM0V6?=
 =?utf-8?B?TnJBS2NMYk9kT01ycU1PQ3IzK3lRME9JOEJob2xYZDE1N0lNM1JxSkx5OW5Q?=
 =?utf-8?B?Yk5yNWplQjdsMmc2Z1l6WnJJek5JQmJvWEhMQU9MQllYZDgrcDlmZnVHcHhn?=
 =?utf-8?B?WC9Fb2tlZEI1R0hzVzBhUzJ6ME9xQUFpNDMxUnhiMEExclprc1AyRWs5OCs0?=
 =?utf-8?B?YVFoZDN5L2VRNXRDaUhQMVZ6N2phZWhFWlBNQzdmS3dQQWxSZVFpUUsweEVa?=
 =?utf-8?B?b2gvK3VrMXcwUU53bXVFOVoreC9sdGZ6bTNWUzdpUlZxN3RkZm9aZE5OU25U?=
 =?utf-8?B?Smdzd0ZUN2E4UEFQK05WNWw4dWI5KzRNMkQ5K2xkWVdFZS9RSTVPNE1rTk4v?=
 =?utf-8?B?UnFDcmljSENnZUYrR2VCaDY4WmlQTk5oV1lrOFZ6MVBIVzJvWDBsTnN3OEJ3?=
 =?utf-8?B?WVRnc0hhbS9mbjZDYzZ6WFRnZCtFakJuNjJaMVYvMzB4dkRnd3JVRlp4ZmxB?=
 =?utf-8?B?SFJCbTRMR211TVRDcGhXWUJadVpjN2h5TXlnc1lNQUNRbGdyNWo5UEVVdWFU?=
 =?utf-8?B?WDlTUVViQjR5TzRac3lMWDhpckVHektiNXRBb0xOS3ZMNEFzTTkySXRVcG9j?=
 =?utf-8?B?enNIUUlvS2dXRGI1dGwvczlDMS9qM2xIeEFNMVp6QXJiZ0lTSkpFYmZ5RldU?=
 =?utf-8?B?Tzl4WTVJeHZ5cy9VejVJSFA4Uy9sZGlveVVaYjFYVkRJZmNueWVGK0JUR3N4?=
 =?utf-8?B?eW5SRm5Gc1RsKyszYlZjYkdVdEFmSkNFc1BINnppS29MdyswYS9GRUQrZGY3?=
 =?utf-8?B?eFhZaTBlc2Nzc0NvR2VFSWJtbGRWclNTZE9LTW03NTVrYzBmZlhlZ3BRRkQv?=
 =?utf-8?B?dUFsWTFWOFhiVnVkSXRVK1UrZnptQmRkN2V0WEZaeVRhYUNhcGVoUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86023e8-1624-412d-ca32-08debb8dfc9b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:19:23.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLfDcZt+KgSAJ78Z5Hqau1tkwM4ps9tJVTGuLmXxYAPAAWUso/Na+Mnmqe9C6BQmaFaJnwfBPQ3N0zxODonc2Q==
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
 drivers/spi/ti_qspi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
index 1f2494e592c..4768bc22990 100644
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
@@ -437,17 +437,16 @@ static void *map_syscon_chipselects(struct udevice *bus)
 		return NULL;
 	}
 
-	cell = fdt_getprop(gd->fdt_blob, dev_of_offset(bus),
-			   "syscon-chipselects", &len);
-	if (len < 2*sizeof(fdt32_t)) {
+	err = dev_read_phandle_with_args(bus, "syscon-chipselects", NULL, 0, 0, &args);
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
@@ -456,15 +455,13 @@ static void *map_syscon_chipselects(struct udevice *bus)
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
 
@@ -473,7 +470,7 @@ static int ti_qspi_of_to_plat(struct udevice *bus)
 		debug("Error: Max frequency missing\n");
 		return -ENODEV;
 	}
-	priv->num_cs = fdtdec_get_int(blob, node, "num-cs", 4);
+	priv->num_cs = dev_read_u32_default(bus, "num-cs", 4);
 
 	debug("%s: regs=<0x%x>, max-frequency=%d\n", __func__,
 	      (int)priv->base, priv->max_hz);

-- 
2.51.0

