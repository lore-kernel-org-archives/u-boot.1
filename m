Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CBECDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3FC848DC;
	Wed, 24 Jun 2026 17:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EUQgnqOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B572847C3; Wed, 24 Jun 2026 17:46:43 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C538460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+X6Y0jDCDrq3J+wl++58dqFcnD7+Bbv5yGYN4tKs5s9AwGZU8oMr91XGH2PxT888voxw3YY8iXDz/2mK85iX6062Za0u0RLHOhZrm10XqgDp3Js+KkI+fGV/6synMy6S1u9yulM3XYfQBuK/ajnl3WlBXe3oP4V1Eg7gEzsHpkmaeMxxt63BFaLhEWMjiSPk8vIZ7ogG6hQesDtFXiiLA/+6PQEUam9j1NNJJLcyvhGR8KroQ8XNiavzRuzDo6BgFOvTNSq1CQ2LLbpA8PSkEk2+IQOA6E+4UJyP06skaK3ESug/w1RBDFqJyQBsaTYgJK0JtaDXz0fQANM+DHmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qPei+T9oqefOYiuWDehPWDEZszC0wDM5pedeLF8BgA=;
 b=TR2aHd/R+dggCqqTod6ziJmeObPSyUNlASvfXAK13iJ9ZmJsd8bT5BrzjO1xQlSkWo4+OUhmADN05dwAURohqmhBP4K5s1w3B4M+9rz5paMvhZcUKPOHunu18cXxq0H9nI9TktHX7kP7NeB3uC+eszpAODui2YwHk8TsMkQQD5so0UEITtfnZ/9NUGs2PtWapVZJP0aJr26lwrApQUKgIW3wrQX7vA9QmbCi3DRxt1refBQsepE8Na9MfPjUr9pOmPeW3SWG8dsTGamZng1qC1sGkkryMC2Mg5AyhX67PPwPnrDVDpFERogx+qFuvOYOvnJ9UWbTyVo4j9hokEasag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qPei+T9oqefOYiuWDehPWDEZszC0wDM5pedeLF8BgA=;
 b=EUQgnqOgbdQ5Tc/1pDTpb10RQoshXnLfX3FDnpwZQu153y3ONjboW7LXuovP6dRCAN3NA/fBV+YVo3po7kf8PCF0OP8rNndyasgv9JjIwysgM3eg0Cy2PgqDQXKRaR/ysgu1C5agNwl+W7GcogKvnU+hfaczgyoLBp5ItfgfAas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 15:46:37 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:46:37 +0000
Message-ID: <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
Date: Wed, 24 Jun 2026 17:46:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
To: Liangbin Lian <jjm2473@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Johan Jonker <jbx6244@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
References: <20260512091532.97256-1-jjm2473@gmail.com>
 <20260512091532.97256-2-jjm2473@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260512091532.97256-2-jjm2473@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bfedc5-6242-42a7-b652-08ded207c695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|921020|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: t5XcSCJ7kj9YZBTSRDMfhEtFrPmQNTuI0OCj5xdqin0t2/aX5m8/32F4YBHiiQC6OGUtNflEBV8pFGVARZTVi7/0IajDFG7WDqukPQlbNLps1XaK74R/JLK7hB4B6rGoUo6pVwoqazWkUftYbWRauKScZN++tBC/brIPGmtOblCM9rRKcleaYEZ2WL7fPNdYt3jSVr7k15gzft//cO81Qny7fSntjt9ARpmZGmcFjP7rsPcAOybpOkhSL7brc+kwX1wMJS+/e3JY4g03sy5t8yxxF6XL7Snumgkaw5zm98fHuyh3/uJmHYHxJ+C5FdkLTmzDQzOl04i/rRnq2+BJKg337kNjY1P/h6XiqZIU/YJp4d4FILCBew2JMnN6MXHR3sksNKkYv5806fuo9sXn3pmiAaYft72SC8mLU1Zcm+fOCF023piJEx516euDCiCzIwH69hoeL6lATKRRhipw730RmGcaAkj1YGsS/NLnGVYOhkUTRPNZ0H1ZmKGcfzZvunTp50mclDXMTweW+j0YXZQ/cRhJAhFlrTIx9I8gT4IG+o2/kA1ISxWJCvl/hbbmgMix0jG83jaazLvhZ4kzaPL1yPUDcrF/Lqiq+rTwOcA5nKdyCIkAFCsAFowY7anJcrVDwiQAMgpmeW0pCTN3L6fXurS1cCeYb4b+P+e4u4E0qxCyr4X1nxSWFywNSBj2bHTeWhi1tgRzNuvFLMSAOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(921020)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJ5NDlKb0ZiSUd0a3puQjRJNG5RdFJYUEFscFhVUGhyQXh5K1M0TGk1ZVBi?=
 =?utf-8?B?Z0t6a1F4SjNvMnZURmt2SE40dCtPbi8vc3llbFYzaklqTXRwYkJnZDJXQzVF?=
 =?utf-8?B?N2kzV2NDOVJhVHlrRjJzemtzRzk2ZVF4dG1sZzRKUm9HdEM0NWhXckJMcHpj?=
 =?utf-8?B?cTdMRlRxTGIvenIyak1iV284Yk1laDBFUHh4NHdFbmM4L294aldySEJlUmxF?=
 =?utf-8?B?QkMzbTk2MW9CUmtyV0E2ZlM3TWY5WHJSZHdmSklNWkh2Mys4d0JCMm5UclBz?=
 =?utf-8?B?YlhMYlZPdHkwYndIUjJ5SU9tQjZnR2M5czVkK2Z6aDFwaWhDN05BWTZ4TDQw?=
 =?utf-8?B?MVdtekp1S3VVZHZ3bDl0c3MreUl5Z2ozK2c0Z0c0cEY1aENRWENBV1RlL2pB?=
 =?utf-8?B?STg5VHFkTU9YMkxjUUJTazJJNlBCc1FZNEtJSmZiMkdkdEVYVWVSdVhSbEVh?=
 =?utf-8?B?a2U1aHUxaFZGcVpaSUIzK3AvL2NSZGF4N0pUWlNmVloxQzNVZUFZak9sR2tM?=
 =?utf-8?B?QkZmTFEyVUR5QVZOdXZvRzE3MUlxd2pIZ0lXZGRudG8yVnZETkx1a2JFMFRk?=
 =?utf-8?B?SmdzdWt6SEZDTGM4bXFxYzIwMGFhK012MnN3ZTJUUzNvY0I1dVFRdjYyS0dO?=
 =?utf-8?B?MUZXZDRDVzhXZFYzR2xYS2tDRklxdVRGUDJpNEFQVEJYTmwyaUFnOGpFc2dr?=
 =?utf-8?B?ekVXWkpnell3N1JGaGs4SHF3S3I3dHNQbDBTTTBNODdNN1I4KzBkTDVjMzRl?=
 =?utf-8?B?WStlQmp2TjRXOFRhOXJsK0RpUFllZksrWllkL2o2NWIwYmRiYmFzdDNvOEtr?=
 =?utf-8?B?Q29VeFQvaGVKTGF4TU96M1BRZmI2YXRBU1BjUWVseFhwbjN6ZmE4bVpkUHMv?=
 =?utf-8?B?Y2NnRkpHZWlFcGc3cmprakROYjdQeVIrdjc5Y0pmZ0ZDSXUvNjFnaUNCOE9m?=
 =?utf-8?B?aHo2b3dXaWhXbnJxOUgrSjV4cjNoblZCR0ZPblRkeTUvWi82WXNmdWdlYVNu?=
 =?utf-8?B?MnFja1dHa1B4UDZFQ2JhQml3RWJkRWlZbDhsOElieDJIUHVEZ3RQaFhsS3NS?=
 =?utf-8?B?WGR2cW5rSzVlbkNKUGJsUFNaeWNxYTFGVjlIbXFYZkJDUmN0ck1LYnljZzF6?=
 =?utf-8?B?ekJTYlZCWm91RW9NUUszY2FZeEVzY3YrQ3lhT0NjWHIxblNGc1UzZSt5T2Vy?=
 =?utf-8?B?cjAybGVBNEtoQ2NrMjNNdVZWYWw5aFh4TVBoR0tBbjM2azNxeE9USWV4REND?=
 =?utf-8?B?NmhJNTdWbWdQZDNHZTl5Z0RRMGtvT3BVRmJCUkI0QUZRL2UxSmo2dFU2bGJI?=
 =?utf-8?B?SVNYYmdLVzhXSDFPVkptNDIvSWFaYzJTN3B6WXdBQm8yUzBuejBZNDB0VFFY?=
 =?utf-8?B?K0xQWElGOU94cGt6TU5JTjFOWjJQTUlKYmpWaGJWVXNYeWVHcVgwczc4Qmx1?=
 =?utf-8?B?cUc5M3k1TlZjNjBTcVRTajNiMUVVOEtYUmUyRXhFSzRZYlM1WC9ZZCtBRE9O?=
 =?utf-8?B?Q2lsU2R1UFUrYlpITS9qb1BGbFE2TVc1VU40bkloVWs1VXRuclJ1c3BSeTJX?=
 =?utf-8?B?OFE2K29oYWJBVHRZcDNxWGJvNHA5TzFpbXlEc1ZmbFJOaHgzNUpCZDByRDZY?=
 =?utf-8?B?NFgyTWNQbzhwNG1FSm5rR0JDR0lQSGJOZEpTQWViMXpJMXVuaGJIT2YxN2tn?=
 =?utf-8?B?eUJ2QytTOURVYitQZWRUbTZWV3g2Yi90bnNNRnBsZzh6VHdySzNhK1ZiRGdS?=
 =?utf-8?B?MmVGN1lITS8zMnZoZnZSSDJ1ek1Cc1laYmdoVlpGZlBBUFNXdTM5V1RJTk5o?=
 =?utf-8?B?MGNOamhLL1Q4b01VMHJSelM0UjZLcU1XK2VsSEF0VFlmVGhsLzZQWldmWGJ4?=
 =?utf-8?B?MlQxS2tuS2tJUENlUzgyR2owMURpaktvWCtqZVhvSHZYNk9tOW5qempNRmlv?=
 =?utf-8?B?akFyNkFzbGp1YjNnTDRWemFUNW54cCtkdFI3WncxRW5wc2ZNbUlJb1dveHpP?=
 =?utf-8?B?d3NwQ01KeHdQVHhSamhKbzc4L1JYV3BUaW9RK3piVFBWTmJORUZMS3dBWGNa?=
 =?utf-8?B?RWNWS0d6U25OREJzOHlvK0V0YzZsdUtmNlk0Skh5NXNWaVZxZGxpalhMa0t3?=
 =?utf-8?B?NGM3aTUzWjZlVzBIYnRrV3ZGeEtjVTdvdmdJKzVjZS9haDB2VVVrQVgwQ1F0?=
 =?utf-8?B?YnpqWXdIU3pjYUpNTEk3c1RTWUlycitzUDZLNDZmNjh4aHVKZ0VDQjVDdFN0?=
 =?utf-8?B?bThWZzdWQnU4NEZUWE12WnYxK3FpdEpERFMxc01RdUZYMVFLUFk5WlhSdEJ5?=
 =?utf-8?B?K1J1dE1DS3VvRFNncjR2V1dqb0ZLUStBMjYxeWpXeUVKS1Q3MFBxZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bfedc5-6242-42a7-b652-08ded207c695
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:46:37.2357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90BZ5ika/1EClLW8BOOL40Us5IfGvAPy5XlXDXLA38ekSpYB8+vZvHhITBjhOyS5K+yIpDCd5cp3eCwipImA8/2Q/qk+fUbAjfCQhoT5nFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
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

Hi Liangbin Lian,

On 5/12/26 11:15 AM, Liangbin Lian wrote:
> LinkEase EasePi R1 [1] is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
> 
> [1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html
> 

Note that this link times out on my side.

> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> ---
>   arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi |  7 ++
>   board/rockchip/evb_rk3568/MAINTAINERS     |  6 ++
>   configs/easepi-r1-rk3568_defconfig        | 82 +++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst           |  1 +
>   4 files changed, 96 insertions(+)
>   create mode 100644 arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
>   create mode 100644 configs/easepi-r1-rk3568_defconfig
> 
> diff --git a/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi b/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
> new file mode 100644
> index 000000000..dc0e0eb7e
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> + * (C) Copyright 2026 Liangbin Lian <jjm2473@gmail.com>
> + */
> +
> +#include "rk356x-u-boot.dtsi"

This file is not necessary. When rk3568-easepi-r1-u-boot.dtsi is 
missing, rk3568-u-boot.dtsi will be automatically included, which in 
turn automatically includes rk356x-u-boot.dtsi.

> diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
> index 030cdbe6f..4dfc3d870 100644
> --- a/board/rockchip/evb_rk3568/MAINTAINERS
> +++ b/board/rockchip/evb_rk3568/MAINTAINERS
> @@ -5,6 +5,12 @@ F:	configs/bpi-r2-pro-rk3568_defconfig
>   F:	arch/arm/dts/rk3568-bpi-r2-pro.dts
>   F:	arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
>   
> +EASEPI-R1
> +M:	Liangbin Lian <jjm2473@gmail.com>
> +S:	Maintained
> +F:	configs/easepi-r1-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-easepi-r1-u-boot.dtsi

Then you don't need this line either.

> +
>   EVB-RK3568
>   M:	Joseph Chen <chenjh@rock-chips.com>
>   S:	Maintained
> diff --git a/configs/easepi-r1-rk3568_defconfig b/configs/easepi-r1-rk3568_defconfig
> new file mode 100644
> index 000000000..c76960379
> --- /dev/null
> +++ b/configs/easepi-r1-rk3568_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-easepi-r1"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y

Do you really need this?

> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-easepi-r1.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

Do you really need to remove clock-names from the xPL DTB? I know most 
Rockchip configs do it but I think it's mostly because everybody's 
copying everybody :)

Looking good otherwise, thanks for the patch!

Cheers,
Quentin
