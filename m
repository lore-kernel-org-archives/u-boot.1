Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A86CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B3D8495E;
	Wed, 27 May 2026 03:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="smUQbz1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773AE8496E; Wed, 27 May 2026 03:19:12 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A1C9848AA
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP1JTMSzGfsWzFbG/v7aEu9K3uDB51dTBgytlqAI6GJQnXG+u5ipBbRurRmVkGy7Ms/QvedYN6z7CSKQu1vFBigVdiWUzfiNqh12iLnYoU8v3SfQJimwzLmNjfROD6SZ4rH1o9axySU9s2zGrNAkoTqeJrn4DITsfWVal3Hi6Jaov+Lyqon7IYt8uG1w/esW/IkVy56GehtMjTiwY1LDPrjCqJW6Z9Vv/FcDOBFiE6eB15ndLuw/CHJNc2Hn/41oTNuhV7hMUmqqfzfm41395LOnxc8RjNlD9mOestAtLywLLLvB0+zR7OcpuyC+r451CE+r/seNjnN8dgrBK8eN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty7mlZpBbKDL39VpOV8EZn0FEsAuobcrR3PxnV1eA54=;
 b=sBtoY3tYwG7Uk7etFwt4+GNpzxwSI2ktR3eadsYh4JLtf+DS0MfARFWa8oF3xzIyBooBAaYGYBhmwZ7lQ3PX3AZgHM71JxhRNmZ4WqORh3EayDOwGH9ve7kX3c2HYorri3ZBBQFbUZGEezAqvRFOC3+xt1AFwddjWzY5yYMuEl6rRQhB2XvTgmXWb1uEBInMJKhAueO4YrNyUvAQAZyV1c7Gtn7JLn+dHHd8TarzKt2B5Tff3W5IQttJiP0Ij3y/a0gABaY0XALVAGBjREGRCFQW0nwvcW0WBJoKPEOh+L76A7L73f5YsBnfUQCCcis+bYOJ56Rt5sOLXIxyrZ+RYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty7mlZpBbKDL39VpOV8EZn0FEsAuobcrR3PxnV1eA54=;
 b=smUQbz1QhbKlqVO+wq8EneJLtRaaX/FSsWHIG/z2S+P33JVSjbxsjRoJoC8sNwa8C/xIoGpWNcbKsFS/g1eSXlxhVOQV/Otlm8UzJ9ZAJvG7iZMjsjtITQcQL96JxUk9m3qdxUFjRPLTaanPB3mDu0zCd8FIeFTR5RKA7R88Pv9YodZcTNQvqKM9AHsz3oLj6dgXAY+B3ALXNWIWoVHRi513QY2IyKZBK0GWiZDG5xlXNiEnxOFtHr9AkorHpGVmW/MeVtjkedn74lh8s/jLPY2LoNB69pYIBrMz93UK8dO4RvTdDU1SLKVroGSdAE+kNpjGgnMtLzX6JfVmoHdoxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:19:08 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:19:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 May 2026 10:35:26 +0800
Subject: [PATCH 3/5] spi: mtk_snor: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-devfdt-spi-v1-3-37db1f6c168a@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6583a9b1-843e-4b52-62e0-08debb8df341
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4zMTN86Ucjbwfo2KD5xdutc3iZhVU9T8FDQUhlGBzVrKnYAd+BHKyAF7/8/P0UY9eN5lWfLnyh5jJPtTGran1ps7ZLjX0fHEyXe+3o+wWYxs7ET2DENvwRT4IJzecf9shEDpK/rf+SsdLV82w7RoOE5T3UuKkDxYKUo8EL+eLMG8dEI7fJHQdmQN8oGNb8OXGQoEPz7y/qRyKMMDdwhGFuAMRdA0uCIxQRVGb9I4uv8tXZit14wpzbyFXJWNPh0bdsS1VSRg8K8Yqt6ohMrlNpFntCgmmZFPmtuR9Ao8DdI4gsBfSYz5+2qEhnR6uvGgJUKheT9RY1HbTnW7E8WxDiwkorSxX3Gk3kUdwNMdp1xaU4HP4mVrwNXR+SGpRc0xautaKKOBW7ozB5iK4+oQH3XHstffS6HU0f16+2xm8GTZPC84pucPY5Q1KUd7dzA9zRkysaMhdYesuvM3q7cOkk59H3iQ+pnmMDcsg10PYPrD7Wu17+8WajxRUih8wGsW1hetqsJnuSljAzfc3I+8Be5RQIy6GdG8fnIx91Suy+mE1BAocfBElmgBz5fgEAeMfXZuFNWuCD4fw7HgtZ7i/MmrlNpTCQVRVPwGxw0g8F4dCPyqZQqtw2poYucz9yl70hh8Iqe2YXnpJANwIOZpikiV913Li3OdwJqE6AhBuy+UVFKjdxQ3eekCcju2ZoqtmJNJjUOTtDQmwBxVwPEiQ0ny9S96rryqsyFitgEVLwbB7eU74qzSVwzHL9ndT36d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXc5NHErRlNZUHdoQjJUNDUyRXVJUHNVS3FGVER6MCtPVmxWdFU2ZFJHNnVu?=
 =?utf-8?B?Sm1aS2tGeHZHVjRqUFZsWjB4RzhTQWZXbGJYeGpRaXEyS01scERUbDNXV3k2?=
 =?utf-8?B?cVgyZjdBdVlsQURMWWJuTkRsVjR5RUVGcHpNbkd3eWtkSEp0dTFyYjRNMVcz?=
 =?utf-8?B?aXE5azlzeFlzWStHd3BTNTVnV0prZmxSSFFNT1BvYXRmM1hUcUlHZisxUm0z?=
 =?utf-8?B?ZWE2M0JxMDRISGRodmt6MmZRdmt3VzA1OEgwanJtWVRweWdyZ2JDb003NzQw?=
 =?utf-8?B?WVFjUDNjdmk2Z1JXUjQ5SXdvWndyUkZ0Z3FpTytPTmpEZUdZQ1RpS1hzdHZu?=
 =?utf-8?B?VkUxWTczd09FZkV4MXRlbktDTTRqV0RaYVd5S3djU3FLWmxaaTBlS0dKdUpp?=
 =?utf-8?B?NDg1R3dNZ0xuR2J5TWZ6MGFSMG9idVl2K20zTDJTQThPcDNrQ1NFMi9sKzZK?=
 =?utf-8?B?ZUNUOHA4eWZMclhZZnNLMFZ1WlBYdFlXMVFyUHZWTWU2Q1ZRYVBQRkFmMzd2?=
 =?utf-8?B?YW9nM0x3WTc3aG54bE9WdkM0YVYrQXhpb1BJMzVOR2hBRXdZeGxNZFBPMVow?=
 =?utf-8?B?UEpIZ1kzdUhldWcxWmVlSTBleVZsVVJNWHRyaitjcEozRmRFQVg1Tm15VG5n?=
 =?utf-8?B?ZHNPcllyeGx3TlBqZ29RNExFZUxZZWtaRjFoWE0xNjdISzdudE84UFFpZ2F0?=
 =?utf-8?B?KzNCNkhjUUJ3QWJiMmorZGJ4Ky9ndEhTZ3NMeThFUWFWUk9IVGZKVXR1ODZi?=
 =?utf-8?B?T2NEZEcvSm1SS2dRbFg5V2tLWDFkdnZtVEtIbE0wYm9FSU84UWtENE44aGs0?=
 =?utf-8?B?bWpkV2o5OHEvMEJrRUVid2NEQnBZVmdTalJWRHhMRTArVU55eE8zbUpiaVAy?=
 =?utf-8?B?dDh4ckc3M2ZDSm1GaEprOFFLN3EveEExVTdGdDRGOVJXV2hqQ3FhTFA3OVo3?=
 =?utf-8?B?MG85Ym96STdCdmR2dHB6czdtalJCNk14QzA0ejlFa3k1YjRIK29USEdPRys2?=
 =?utf-8?B?UlZXakJQOEx5ZXE3ZE5uU0EzUE1yb0FNZW9PYjhiZ0NWalpRL09YMlJzL0k4?=
 =?utf-8?B?enVGdGMxcE1yQ3AxN0pDRy9oVm9CdDd0L01LcHhVN25adHhkaFBrQVk1OFZj?=
 =?utf-8?B?a0UwNTZHdllHdWRrc1hldGVlUnBQWEtvMUJsZkVudVRKV1JCYS9MQVBwMk92?=
 =?utf-8?B?VjhiNlRPTGVRUy8zQnpzMzdFRFVFZmtwL2F0cGo5RzBFV3Zhbnd6RUdjUUZG?=
 =?utf-8?B?T091WTFBWDVXV2lGZVk2djNBVmtISWNORFJPWXNqa3ZKT2F0UG9uQnd5QmFm?=
 =?utf-8?B?RjRFRSs0Q25OVVNhWUVXVFY5VHdkeWNaQUVWeWk3ZnJ3U0gwbmtFcm5ZWmFM?=
 =?utf-8?B?VEFOMFBSVEtHbmJ5Y1EvMWxWT2drbzRnS0NMN3lMdHV2T2RiOHR5SFZVcGph?=
 =?utf-8?B?ajV1clFBNzdFWjVpQWVzeWRUQ29Jdm5oQTFKMGJORXBENTQ1K0pybWRmNHJP?=
 =?utf-8?B?R0ZVT1dkSXFUb3NmTUlNUEp1ZDR2c3ZLWUx2eFc3dDVZVGZ6blJVdjZqMW1q?=
 =?utf-8?B?WUJMMzg1MWt5WlF1dVAwOFpFelJDbjh5SWdmR0dTdFFzaGF5S3k1OUQ3UnZR?=
 =?utf-8?B?Q08wS21FeVNTTXd6N0l5cmwvYUJlcWtFemNvRit5c0x1OVpPV0NzTXZ4OXQz?=
 =?utf-8?B?bmVCSHZkZmlHTUFwKzZEdkx0TThZUkZ3MDZ6clVzUXFQa2lqQWxQNlkxOEh4?=
 =?utf-8?B?aEkxb1Y1TjkyN1JGSVFPVW5ybCthQTJDbm1KdHBGRlJrQUE0SzUybzlodSs1?=
 =?utf-8?B?UnEwQjFYSDRjTnFxRGVrU2JPUHRmTTg5V1hRNDNEWXV2YzZ6OU5mazZUeWNt?=
 =?utf-8?B?OFpOYlJpdjB1aWsvTCtoZjdLcW9HZ0NDZ2JwcFVyRkRyQm1GWk13VW5CSHlO?=
 =?utf-8?B?UVJOVFFObDJMN2g5Vms0U0tNQU8vNVFhOUVKQU1HOTBCbXYySVdvVnRpZC8w?=
 =?utf-8?B?N1BYMjBsSk5SZWJReDRXaVBpaTZJanU1MlcxY3l3WFE1TVpBTjk2QTdQK1FR?=
 =?utf-8?B?YjQwSmVtSVpjWXZrdHU1cGdjZlRxM2hwbXoxRkJhZmFvb3IxUUY1NWxZbWpu?=
 =?utf-8?B?V3hFZHhxRlJOYTh1MVZUbW9PQ0J0cHFzcVR0emtEZ3RkRHUvdGNyQjQxYkt3?=
 =?utf-8?B?QVNyUGM0YWdXOWtpQkVGOFMyeXlMQnVHK1RUU09zbU5GeUdrUWZTTHM0d3dh?=
 =?utf-8?B?ZG8zcENCTlU4d0RoUTRuczJzVFYrQjBwdU9vQXViRGorRTJLcWVhYkVZR0xu?=
 =?utf-8?B?NXpnQWh3ZUlkcFBUSTY5SDF6U3NrQWQ1NEgycjFoOEJ2T1huK2oxdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6583a9b1-843e-4b52-62e0-08debb8df341
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:19:08.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAEU53jHAnBCS+BlGl9qREwqV2xPFsZcuvHegm4FNHQ9w3i3ZYC7jqG2PLCiNAXzYsi/hDvZj862eR9WCrwERA==
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

Use dev_read_addr_ptr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

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

