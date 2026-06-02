Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D70CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCD1848E3;
	Tue,  2 Jun 2026 12:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L8am/4oN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A70848EE; Tue,  2 Jun 2026 12:04:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 815C6848B3
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxTkXhSDl77IcW6hiuXmYsHaJAvXy00hQrjcIyiFmXKEbwIYnRshtEn4kigp0Y/B0hMb3P8/fRjMR6ODOODHXUfczYEGy8tf9bbxXTvlmva3L+wlfJ+qTbCGIsrycfwL2NR/ybXuabeKTdZ464FDIfPFTV1xizlyeVFU6OYYpmHVxFkBXuC1w57N9dfk1OpoPAhlYuajbw6fXmIetcNej/ncFrsJlxBZJ1rMDevRPLCI1qV+RMNw3/PYWfdZA46HRfrEzqhAv/N2or03GX1S5m4OnqOzBv8Egz/QpbYye1efjIdvZwBN6bc/p9T3Nr3lFrXbQdOM7qfwVu64DpECSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpIcRJVBz2p+/XEk8vs77u7QZwE7IlCTUz2FMrpitsw=;
 b=APlx7aozv9zxLt4GpYl8lp4XNYGRhnQrqmKGl3B9QFLQL7soPphVFlrFEMDyUABUpjYAvn/M8Y3wIUP+x6k4J3fgzTcd4T8zIWlodddmaxejRb7UiGJKBZeYASexrgbwCYhGo4CGFxaYLcyG2/ra5zHlCz62oeq1dIDGR9Qmd8c6vPvpx8JbkJ9TeClvcJCJrMgKPW1qIU67qq9b+fBUZi0tIm0/1+kd/aemZVHCwOpJbCgnLgnF61u3z63zsSU11eCPHG1Oem/qOfpiAMiFlPwIg5In3HRy845NOGANif1JAk2Ta38+wehR/71KlAjkpA713462jwLw2lAHu1cVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpIcRJVBz2p+/XEk8vs77u7QZwE7IlCTUz2FMrpitsw=;
 b=L8am/4oNGGiygAKY28gR3M2Lr5DOf/dUNcd1tvl0rxjUzG2FNKg4UMQFhar6LtLzkG7MX7v3SVzX1vqBLozKJp2eoFMnq/gvdAOBJ8usX4d+vwuKStJ+xchut4U9/9tbgo59GeVonZxc9TbP2KCWAkR6b0qEJ+zS/mkeQJr7oTaFMxNoqrE9s6czU0mTay/Lgyeq3uKm6bOUA/kthVod3eR7U7Nw0mqHFyt+mPe171p7SkyFB8li8e6b3CEbseBnUAdnlDx+8ri8pDtzjNJlwQQAIYy29HCcGQ4ZnY8ILmTuix4SZh/vUH8Rn6rUHcxdX9j4GxQzS2ri02RMfiygIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AMBPR04MB11742.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:03:53 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 10:03:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 02 Jun 2026 19:20:17 +0800
Subject: [PATCH v2 3/5] spi: mtk_snor: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-devfdt-spi-v2-3-08374650778a@nxp.com>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AMBPR04MB11742:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ac9d4d-542c-4710-c0fd-08dec08e4047
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|19092799006|22082099003|18002099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +Dm6XoecRfNLpiZUO1GPdO+YRI3cXDkJE5VgdWjiBB+9gNszKnkOUSMDnanchj5PqpTlk+fzAjNvO1HshKTqVrzRrOwdN8ir7xgVZvioUqsKRMX2mh9H5p6jSeQ0QgRHgcLuwgj23negHU4K3qDjWQPdvALSbvF35YID/dTDNyBwu1kolotOvA8CvPUY0PumJrfBWYWTGkOVNFtfOpGYQeibMrlF1X313sU5T6RqPT9+FSG30q3rfEnBBSM9J7jdzdXycRkQ/LeZE5sjPP6mnc+pNZPp2BvvYH3nJBsaLpGzbK1tgyXwE19D8bCw8ZvOTjOTITS3SKnd0xfujvoe3M6RA7ei7CvGd7mtFhELusYfSh3oh8p1t5UddyuMIqWXhsRZcxT1Io5DUoiDuKJw0POSVlUbcbWZCaVDVWZbO1NDvwHrg59M23D4XyG5W9gDWRxWohwM4fPT4RAT6bMWG69PzHRZUvT8OWPngRkJO5Yw8P7t/5Yylj09qKHn6vU02tXMNL569CiSX0uX3LnW68wnLgJ6oZbmroJKnJg8dayOXgZp+YS61AAL8kY4pj7/BjOB5oUxgV8WX8IdlnrQoaaP3xpFE2UKd7icDwZixsp7WwZwq+pg8Fuk5qiowuLTAI0Of+DOgF/v7jMhgQXQOgEDkR85KxENoxw5hPfgW3TPJOOqtdUBjjdggIlQH8KvQphlgWfVwFb43UHVm9kfbTx2EmxTDFgh4X5hKStQHHNzLkTAEDKRlDmk1/0IEfEk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(19092799006)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZMMmhtQmZMaWd1UThkWk40Zm5vMFpGVUFQZVJHcUlsWTEwKytEMVQ1L0hv?=
 =?utf-8?B?M0ZoNHJxYjNYOUtYd3VTNnArWDlxSkJxV0dyY0dPMCtJcE5wcC9RYXIyQnkw?=
 =?utf-8?B?NVVTTFJDV29NWnpSbDcyQTBzVmtWMmdacEZCcEpxVHZFMVVjVkpONFBkZVZu?=
 =?utf-8?B?ZDM5SVZoMzJMYU9vZGdQcGtxVXVmWmUwaXlyS3FtWHk4L25Ya0JhN2hhUUQz?=
 =?utf-8?B?M3lOS3g1WWwxNHpjdHlYZVFZS08xMHlqekFSenRUWjN0RUV1dnRiZ0t6K1Z0?=
 =?utf-8?B?eWsrZDBvQ1Q4QzA0NUFkdXpkWHljaHUyQUs2bzQxanEzTDVpZUJ2VGJGMlJx?=
 =?utf-8?B?U2gxcklDS0ZaZ0o4NUdpdnNHL3Vac2ZKaFZCb2Jpb09LSkk0YjdDNDRDY0xH?=
 =?utf-8?B?Z0l0cEtwWlRtNEdveXkydndVVncvUlRXRCtlSnp2UlpTYWhpNGxVYzFlVm9B?=
 =?utf-8?B?TWFCbnJPQVJCNC9XMFhscFY0Z3EycVc1NHZUNGV2aVhmMUhucGZoTXlaVW1z?=
 =?utf-8?B?WFVualRLU0xYWkd3c2ZPYnZ6emY0S0FjVFNJTU5UaWFHYUc1Ym8xWTdJQUFy?=
 =?utf-8?B?dlNVWkpvUVZyWmI1Q1VHbGlab01haGhjNGVOQ1d6Wko0YW9oYUR5V29mM0Zz?=
 =?utf-8?B?bUtQdkF5WjJIZXBERzhEYjdDMndNOGpTaUtBRG1zTVB2VnJEUEx0UFh0NFBB?=
 =?utf-8?B?cFFRbHl0VkNPVHo5VzM2YUlPZ2JLK0xicE1KR0ZOQ0dkb1k3c0hCT1RLOWxo?=
 =?utf-8?B?d3NmbnVqd1JTNDlhbkpTTkRlTTUvdEJ6cWlBaHBuNnRNc3lhZHQ4dmc3ajRj?=
 =?utf-8?B?S3k1Y21GdUtrcTBORXcrNTlPN1VNeDZhanMvWmhQaFZMYXZOZ3FNQjhIK0hw?=
 =?utf-8?B?b2NWMm1TZ0NXcWpYVG9TNGVMVzJnekpuclpGdG9Ea25lbWQvbjFJNzhBUFZv?=
 =?utf-8?B?Z2dhWHMvZndkTURIeDhndkp4VTFHM1dzanNqbm1jakNQaTNMYU9OT25nWFhQ?=
 =?utf-8?B?elU0b1BLc3JmKzJBVkZ6YnZzR3lmeU5DU3UrRUQ5bEdtSm5ueFE4bVlxaFFs?=
 =?utf-8?B?SFZOQ0xieG9rNU9pTFlzRzc5bTFXTks5M0hPQ3ZmL0NQMGtUdlFneTlqRjlm?=
 =?utf-8?B?VGt2MHUxNTdhVkFNeUt1eTNFZjZIa1pkUDBhWktHZG05eTQxY3o4R2RwcUds?=
 =?utf-8?B?Z0w5WUpVUWl2N05HR1BFNlFVYVcyLzJPSmp6OXFMTXA3TlBadGp3cTdmdVNU?=
 =?utf-8?B?bFd2T2NtQk04b0hYZVI1YmpQQkdobVRMMnNWNnpTNjVmTUpnTCs5ZFVlY1lQ?=
 =?utf-8?B?bkpGN3B4aUprcG1hd2d3WjhMZTdaTGNBNEIrN01ueUtjUURrZ2tUY0pkVUgy?=
 =?utf-8?B?R1haaVFoV3hXRUVDWFBSRjM0RGlUaEdGcGQ1NDFRNU54Y0hhN0xRVWsrWFNR?=
 =?utf-8?B?ZFJINXB6S0JGWldDR2RIUkhGaEl5eXlJbG44a0UzRHROb1NsUkhXbFB2WnVI?=
 =?utf-8?B?ZmZrbEtZcTFPMDA0N244MUtFZlFJaElMSlVhSm1KSHNYcFZXQ3JWQnovRHVj?=
 =?utf-8?B?V1hjbUZjMW1Nb1lLYTVBVWdNTUNKVjB5T0ZVRy9LWk5OT0pLYnpQRkdYNko4?=
 =?utf-8?B?UjlyN1pHeUhsODhGNmY3K2s3cDdDYS9qcjA4S0J6a2MvSDcrcVhqdTE2UUs1?=
 =?utf-8?B?ZlJmK1BGSXJmY0xjWSt4ekdvZEtReUttbHlPazg1Y0ZJaUgyaDJFUGx1eXhI?=
 =?utf-8?B?cVdHY1d5d081cE1CVE5XNnJXaWdRZEk3RWZQMzI0UStCdWZSRmlyS0g4dTV0?=
 =?utf-8?B?S0lBdUdaZDQrR0prUWc1ZWxGeWU1UGNQekVGcXZSVkErVVNKc1hjN01WS0sv?=
 =?utf-8?B?QzR1djBlQlZxT2tVVzlCRld2SG9xUG94YkFWTkNNWEV2RVZZVysyZjBlcUI4?=
 =?utf-8?B?RC9vZURRK0tjYmNLa2FHR1ZhbFR0TnpmL3ZaY3V2ZGJPaWJMeS95dk1CamxE?=
 =?utf-8?B?MEVzS3R3aDkvODNDY3lWOHR5M1ArYlB1SGdOQ3VMYkRncDRZb1lSUGRZUVVE?=
 =?utf-8?B?ekVXZ3oxZXB4aWp5UFd4dWlkcWlZdi83MUVZS0Q2RzFzTTBHRUxqdHRtdlJK?=
 =?utf-8?B?ckR2Rm1RaFlFR2VQZ013c2FkVHo0bmdyR2w5ZFcwZFFhRTBiQmtIdGRDb1pv?=
 =?utf-8?B?UHVsVnJrcmJWNEFMUlJVQXRZQlpSSUZDL0s1Q3lQVmdRSFFrNlIvSDN5SFI2?=
 =?utf-8?B?WVpRbk4zR25FVkFMOHJGVkVZdmNSY0ZSb25IV3dIdnhYVUM5OFBUR251a1FW?=
 =?utf-8?B?NWkwNk1IWm4xbXY0WFByekdiWVk5d29HUU1qcC9ZdWhGcS8yUEx2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac9d4d-542c-4710-c0fd-08dec08e4047
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:03:53.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4xrS6qEMZ2xNZvAsbNZjFgGqDvooVfp0nx+dT4ybj7fvI2OCeCCtHq7ZI/b9DfToRfAGNUpwAZjzqOTIJXMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11742
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

Use dev_read_addr_ptr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/mtk_snor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
index 40fc1826db6..a54eca8acda 100644
--- a/drivers/spi/mtk_snor.c
+++ b/drivers/spi/mtk_snor.c
@@ -528,7 +528,7 @@ static int mtk_snor_probe(struct udevice *bus)
 	u8 *buffer;
 	int ret;
 
-	priv->base = devfdt_get_addr_ptr(bus);
+	priv->base = dev_read_addr_ptr(bus);
 	if (!priv->base)
 		return -EINVAL;
 

-- 
2.51.0

