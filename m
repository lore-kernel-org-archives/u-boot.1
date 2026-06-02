Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B58CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6674E848B3;
	Tue,  2 Jun 2026 12:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K0xvh8md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F70B848B3; Tue,  2 Jun 2026 12:04:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D775848EB
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpku4TaTuZ3C/0T3fEhuYIp4osLf4y7UWmF77wKGjAluSotixCGeeD7r6opAh14lyeECOnF36wTtLPRUcmyEmxdpYuF3/qb8+UlioJAo3ULaGNzLyEVmzXk1UJEXYaxamz6/byLJ+kb1WSWA1Z5tx7vKms4HqypdD123J+RgJg6JAodkez7GVa5iO+0PcDpCAPkq1LgfojgWdEePPANc5Uvwn8g0wJsUoisi504orHyVBzd0KNMYUr+OjTwvVSO5vG0mVMSLUYr5Rg57anfHhm3Ub44H4L+xAJe/XxKHGyssIPByXFX7GIq1RL5XGhvBqoE0fdsM1uLK0Y+McBaBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8gUTFVsyeef1zaMUfQIL3AwAjFCvvkeUhqMWuE9Bxc=;
 b=JO6hx6pacWfWlmPRBELFnRVcuqCWUHrUQSV6tVWfbYdyVWPOG0pweu81B3yurdxn06D/LNK3PRjwU4KHosFB08x2ytR7CdotEvK4iFbYfl8QY6W7Vj4fnkFmz0GDNTuKsy6xrWOiOWRIBgfu/N66JLLMHiP2xfcxn1oVRmUKDjnCc49tri8zHYxhA1dHJF5q7T1tglZnXTz5lgxcwb1FgUYYcLO1E9gzoWt0dITMWkyVHgteH4YRV3FJg3z08W7w6gXCJMtxvBbN/NFRQAzMx5bnW4sygw0z2gCqw+m5bbZeSTqUVsXoUknMJsSuxqZaqZ9hr4GONQmz+MZ9Lp3TKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8gUTFVsyeef1zaMUfQIL3AwAjFCvvkeUhqMWuE9Bxc=;
 b=K0xvh8mdUgDz816biakvRcTKsZxSRk4/cgHFYDoTk+tXjj8q27Q/RRpH7n83+qVxkvebDq4jBURfJniTlA0RkYrHJ7/tKsQf7LVXeTtdLp8vwQSBTuFnXdJZMqEsC4hmWO22fGC4MWevSWLsat4i5gDPTOmdrh42fVHsh8sRME54lhCpm1hJujDamOLBBrY2n5YGmkT7qCbQG4PnnVGaJ406XpKrbXNaDXKpvwSBusmR7H2AYBj12h3m+8+xfEswZONTXLOYLZjCd1d6+53S8aXU5pT5MYmNr/e0L0XVXc4QmmWRoUgqb27WbkXMuDiWRcogGOy1MXO1Yt+IyhcD7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8397.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:04:00 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:04:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:20:18 +0800
Subject: [PATCH v2 4/5] spi: nxp: Use dev_read_addr_size_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-spi-v2-4-08374650778a@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49061a03-62cb-4c5f-5064-08dec08e44ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|22082099003|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: B96FneDy5jNvSPTz8gHRKNzq4AXMWF0P2BZb3Ize3E9yepuvw6FDBDLyyy4A5zFwSQEV55LlsuacMPRfK1KMwynYrHLCoLYcBPDURH/Td0DpMzByihwf8V+WMN3aGt86jQtcp26/D1mi6Je+bUF3d0GlXH4l6xXDcu8Zk7+1mH/zJViyetLM7E0aLpRnXK9bGwyO+gvlibsCyJB2xHMgkZmNPgNfZLL//8HURNshulTSmIMttt1Z2JJxj+NzIZsGUNu3T3g8Fh0uheSvOovxI3tlGEAt43AebB2T/0XmtlLbrvflkgnZptaQNzNpK182cQXJdxskhCq+0I4QKA95hULZqcS76BOelxtbxuYAP0Gh8H6k8xTUgIKoS2mIqsbh2NeDyTLwymepl8qEaMhkQ9PIAd2BUxgxSqqOfW2L7VhviZHRIEKh4XqXc017XtlBfnG1vV5SuPnoF+sNWy1Hr3rJxRxjzxy13dALrrjCWFgXW1o2m7wrn+LNtKq9fV0r14BME5zWNGyy4u9UpkorPOoXsHKZRdEBemJBTpGuyqaxTWLb1hBR7Or5r52L/yBt3xUHt8MaYdIG4w+Ojb5e+3ucpVM9XoTo44MtOG/T6pXD9BT0TCaKWwuUZKPWPm/G7CWret9gMeT3vJVRimqQ59rNvDuNpN8sQ04HTpdCMcdu3MF+pMcwPiBlksABlQOUYwtrtl9IIHOvIHLLRuqvZKUOEg+IVSTgSycBqKxcSyyMkdh0d+n5uU+0FOQV85TH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(22082099003)(18002099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1mVy9yckRwY3IxbVBNb0J5UUdIN1lCQ2JQb0ZrS0VGZXRUVjk2NzZONU9x?=
 =?utf-8?B?YTZEd0pzelFQdmVqSnkwVmFjbXBocksvNEcrZDFwOEk2SXBBUTllUGRmcXJI?=
 =?utf-8?B?MS9yNXVVeGhJbzBBU3dUMzBrVi9zT2J4aE5kZmk3dFBSK1Y2R2ZZSHR2Um5h?=
 =?utf-8?B?bGpsaTl4UVBLWGVlZ2ExTEl6eEtsRlJ4a1BzQ1dlK29zV210R0RNWFRJd0lz?=
 =?utf-8?B?ZUNlWVlzdW9WdHlUQWpxd2dCbU43c3hBY3F1bnR0azM0OWFSVWJxY1NIdmM1?=
 =?utf-8?B?QytSNm8wNXR5WEIrQVJ5MzRkS2d3cEVoR3NudFh5Y2VaYlZmMHlFZG94KzBH?=
 =?utf-8?B?cFZGRUYwUExJajZ0NkxvVm9wanBFVEh1UnNIdzh1VThGak9kaklJRTJTWlVR?=
 =?utf-8?B?Y3BnQWw5ZC9FMjY5Y1pVckJGTEhSS1hzQ3B0dTJESzZmZGNkSE1kK05VN0k5?=
 =?utf-8?B?dVlNV0lid3I0b0RHVExTSlplQ3JXcnF5QUpHa3RYYkNFTDRCcFJDZHVJVWtj?=
 =?utf-8?B?L3J2bHl2TWJ3SzkrdkdWTVdEUjY1Um0wdzNjQzYxUVcxZ29TRVRoeVhZdXZo?=
 =?utf-8?B?L09uZDVFeVA3cnpWemNSZ3FUUFFUMVBrQmZ1TXMvMmVseXh3cTUzcUlXN2JX?=
 =?utf-8?B?U0E1ZnpNbE9laDkwQjRUYXdZNFdpeDYrcnNqeFVpRXdxdE40TTZuV3ppaUxG?=
 =?utf-8?B?Wm9qWkdaQ2QxS2tUOVpIOUFudUZHNjYvSFNTSU56SXowRlV3a1ZMbjNFQlZ1?=
 =?utf-8?B?c0h1ZmVUZHhhNklCaHYxMmtXRHNpbmR4YmV6YUViVGxYeEtlWndrTnJUcSsw?=
 =?utf-8?B?VWc0Y2J2cEtxZ1BOSDhMK0VOQ0kzbVFFaWp5R3JXVVhVSmdmU3hZRjJHeVUr?=
 =?utf-8?B?am9rRXh5cmJjMUxFTG5KRWZPSlJ0VGVyMHRiYjBHUDN2alNoajdIcGx1TnVH?=
 =?utf-8?B?YWpQeUpmVXpLTFhTRVJremwyMThwdnBTaTZ4Q3duUmNuY1p6TEZUcHNLNEVu?=
 =?utf-8?B?MDVuc01nOUttYlk5bjZkOHRMc2Rmdi9aYXB4T0NmOTdIdzhmbGVaL0dYaFZS?=
 =?utf-8?B?c1dpYThJaTFqN3hPS0RQTGpHOURTRktrMVozQ3c5QkNxc0tUU05VUDUvM1Z6?=
 =?utf-8?B?NlAycmVzczVWQkVtbVViZjhIa3N6Z2Nsb3FraW93MjlJNmVrK296a0tkT3hS?=
 =?utf-8?B?M2s5YTRNelM5aWk1VG5jU2Z5NUlnSkVXZ0lFTHljYytmdWxsRFRrcFB0d2pV?=
 =?utf-8?B?aHRUSUxKdFIxaEo5K21kM3hNQmhINFpzT05YaVNFWHBSNkd3SWlzSTIvNkM1?=
 =?utf-8?B?cUd6Q0FyRXpPb0pjZFgvZ1QwbjhMM2dTejlxWDFkd2V6WGpXdC9SbUZiWlMw?=
 =?utf-8?B?WjM3a0RIZTZMYk93Ynd0RG5UMld5SS96cFdzYjk5NytrdjRJaWdTVk1jbEda?=
 =?utf-8?B?dVlUNUM3MDdOdm9kdzFJZVBmaXcwNTJDOWh1NjF3ZnI3R3NPU3E1VlJoSkV5?=
 =?utf-8?B?YmRsYkVtNU1OUHNKdW1JTUZlTjR1WFZWSVB0QUdFQmpKMk9NT1ZMeS9XM3Fs?=
 =?utf-8?B?bmYvVXBvc0FoaTRMdGRibmY5WldvM3ZrZEw3WGpCOVpNcXhpODlQSXVXQ1hC?=
 =?utf-8?B?ZGswdkY0UkIyVFloL0dMN0RXWkxVVjlaQkNIVVRCeEhhbGZhdVFPYzY3bTRB?=
 =?utf-8?B?LzlnL3RoZ1g1ZEhPb3NTbXpIaExSQ1Bib3k3NGpyMVc1ZFZoYjNNRlcxb0V0?=
 =?utf-8?B?ZTRiSXZBdWdXSXlEWVFpK2ZFTDhxY3JnQzQ2RlgxcEk1d2l1VFc5VjIzL2xn?=
 =?utf-8?B?dTd5bmxCb21Da284Um9hMXY2aFY5djc0VDlpT0ZOWjFGTXFLZDQ3U1lKK1Ir?=
 =?utf-8?B?NnpXZUIvaXBFL1FDZU9HdVY5VVQvaEllMVNNT0QyVlc5NHZJUExBSGJFY3VJ?=
 =?utf-8?B?L09YMmRxMHFuUlgwcUhhcGVzSHl2VE5PVHlCYlZ0ZlNzR1gvRkZ1bzg0bXRK?=
 =?utf-8?B?WXlSYWtYMnQvUHRzTStPMk16dmQrbWNqc3JNamJlL1lUeXY5MURFRkZRQjNU?=
 =?utf-8?B?bEZaZTdmTWRKQzI4aGwySkpKMnNiYXFEUDkvMTdQcWs5c1JGWWxYMWJ3ekp5?=
 =?utf-8?B?TFh1WlVObTV6UGdVOXJ2UUp1Q3lMMzFHc2pOZ2FCR09NZEptM0Z1b2xYd3JN?=
 =?utf-8?B?RE9jNWNmOXJaUnhEZmtGbUpVM2N4UFdMczJGaG0xSUgvUnFkUk85cUxsVW1L?=
 =?utf-8?B?L3Y1TVBnZjdsakRUZXNqbXczc244N3JDSHFjSGFNMzN5ZjN1Tk9STzhSTFU1?=
 =?utf-8?B?NVJOQ0pGMkFFdE9QbE1zekNhaTFrekFDUGhlZVZqQkFINTBpTFgwQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49061a03-62cb-4c5f-5064-08dec08e44ab
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:04:00.4161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpD+lT63OZFAKESaI9CM8dGJN+TtrHhtGqrTr0H8jsIkBwfcvB/lolt5Hy+UJOBY9sU3V2BvldWj0SyeKn10Dg==
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

Use dev_read_addr_size_name() which supports both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

Also correct type of size to 'fdt_size_t'.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
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

