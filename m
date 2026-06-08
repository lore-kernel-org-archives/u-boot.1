Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B0CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 02:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA27B838BB;
	Mon,  8 Jun 2026 04:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ULq+hqqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42226838BB; Mon,  8 Jun 2026 04:30:53 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D981983314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 04:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elexvlzXkEfLIQo9wB4OpVFlqWGxI+2gOoATPZ78BI77j4VYJSz4LjClEJaY30h0iLyP87/p1f8gDU5RrukWLsmw61MNIe9l2VghRcgC2zypXuQm+SEtIgl8Rn89YkUFsDk9DAWFWvMCgvevsy/FGy2e6yuqK1eoTicbixvxwVg3AwiznSv/kLvoJxd7L3ceuCFnCxwD/TVPftMe0wYe6nOa4sQzkYJaS8pIRaX/vZOih1ZHfRVIkS1VyHEEea2KxX4YMookVxkp8tVbsq8dQYbj+l8ot9p4AP4cZdR34PgDzvwQ/62frxciOAaVTBPwDJJ0m3Yhzizdj9ylakrr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+M65nJa1e9Mr4htPfY6ZlJcI+Vv1HYWKUMHsZMBUec=;
 b=oDP0e0JuORd5ZSGJZU/QjcqdFA9R8HYjEBsrtCGCehNQW9sXpkDyOwxGP7U2KmDiZUMpkBw467SWB6e7BK2oFHO1KUlqos3Pa4WO4UCiMxjgqpxOUMx3/c9WxvC+rTs+cBVVL5cQ+gJlVnBi53bRKdR/kr6LnVeuyBG/d5zZA4CGFUCm3e+QximGl5eeT8/jkMCJWvkgUk7w1v7YW3uUeCHpYHg1AKE5U1MLAzTFcxTF2z4Rs/0NKwk74sTe8zbk5JMOI63+ZK3C+cvt5/0PHa/1SCbHicdxmud/QbmZUZQaJKQsS2F7r/958aH5rCaAhCndDVmpL1deu3HIDa8nIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+M65nJa1e9Mr4htPfY6ZlJcI+Vv1HYWKUMHsZMBUec=;
 b=ULq+hqqHNB8k3eCXA3VQzYXR2L7vVi65i3zGDTgwLM1AonAMixlmtT0GJ1p892ckgs9E0yGXnYMY25jNF8VAPS7Dpv5wdXihmJ+YnB4flxAAOBiQmYp9vSgORHrgPB8DEr34d7BYJ3TfaL2KCPVv1+E2TFKLIT+pqsWPfX8vZNvOSo6Uj/ryn3J2ZDx17avZZBbL3uvDBixn9ZyWA6J9P4NmveRmG//Iqo8So55EFKw/TOjfd587pjuMtbA9/aowynC5bfdNP4czfraga5bQWIRAUZ7YTLQAp6Vm2V2zYM8NHC+Du4B3s1zipiOfCQ78LNkQknyb1y0Ooj7AQoqs9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8130.namprd03.prod.outlook.com (2603:10b6:8:27f::18)
 by SA3PR03MB7236.namprd03.prod.outlook.com (2603:10b6:806:2f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:30:46 +0000
Received: from DS4PR03MB8130.namprd03.prod.outlook.com
 ([fe80::d1eb:2f35:222c:f883]) by DS4PR03MB8130.namprd03.prod.outlook.com
 ([fe80::d1eb:2f35:222c:f883%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:30:46 +0000
Message-ID: <15cda591-50f4-4a11-9210-3d64314b7959@altera.com>
Date: Mon, 8 Jun 2026 10:30:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: clk: n5x: Add support for enable/disable API
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260507090304.18905-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260507090304.18905-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DS4PR03MB8130.namprd03.prod.outlook.com
 (2603:10b6:8:27f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8130:EE_|SA3PR03MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d91fb1-9017-4daa-40d6-08dec505f249
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fp9HimhN8KSUrWo9tlBb56vsD+1wilms99grGBmdbaf/Ihhwcz4oq+UyZHHbIKb3uypO9QGJp6NINW8vJFaXQp1NfJ8ai8qQbL0xMJOt9RGoRvUsavfLpnMz9hYgAmNOR/qKdO0j0FAI8LTH3TyQXYDwRKy2TfL9sscLK+UisP8UsHV9XLftbE5ayAC+zw1k60OK2vzIiT3LBbHow+gbgaXzhmlRicHqloAMFzno2qISlaFLVcbfLeI2LKD6Qbw/HMfhgBc0Y7YmniEM3E3WOLvUOBjWbWBJmiLfslaReLsWIoW98+WnyUu9QI3LCMy1sOy6PnGbLfV0hqc39OMy1SNgFiJxN1Tzj3wgUzBDfoJhvAE3bawNfvZZoX1nosMetqlsevugP7B8dnpmrL/1xIrST09b4uVMoc+pwJQaDwl/8nBPTaOZZ9N/+s1J2fmbptUtIJLSFUMPt4DLN8hLPrPHvhLVgd35dOL7Q4Fnp6Vq+lOFAJ8FcXzSl+O8FVWoyjrNIR6nFzG9Gdgylnr5u5LdakpG/u0kUlyDlnsietCO6lualFdf8xtPWsxJI8XM6piD1WTSM5WqCP0iGUFlaov1qQWHHuS/PCn2V8xTeBRQBxyVCPYrI7WVwdGoswGhNoFhA00XeK5j5pvk5iM1PWlHL36cuk1UNBaClJQD62V9US35xCgIg+ce6pOesoiP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR03MB8130.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNHbFRhMnd0UlBOVGxiTDlZSWs5dVlRVEFKbmhFaEtndGxpYmpuUG1Nb2VU?=
 =?utf-8?B?OTZBN01Ta0VMbi9ZM2pFWkJycnFuUUY4SWJGVTlqVnVmVkpzNFFpbUZzNXlr?=
 =?utf-8?B?NGJDdERVTWU0UTJ1TzFWcTRqTU1mMEV5bStZTE16Nm1HWG9LUnVJRjREMVla?=
 =?utf-8?B?dW9QVlhtd3MvNEM5N3c1dVFUYzRlMFBtRmh5bERGWE5ydzRnWU9HaWcydm9Q?=
 =?utf-8?B?L0JBWEtSMUZwRk53a2M0UkFjelNKYUJyNkdSN1lOcW12UDgxSi9YUUI4ZGtH?=
 =?utf-8?B?NUh5NkUzZVpZdkkvU1MvTmRCNFU3ak95aVhHRktYemF5TlladHl2SFQ2MzFB?=
 =?utf-8?B?cDZGMmRodGxpT2N4S1BJNHZLK1hDNkdyaG92NWloYTFmOUs2VXpyWW1qYml2?=
 =?utf-8?B?aW1XRWRIYnY0b3BDZm10Z1dDMVFCZDQwNUxkUTFJMWpJZ2ZFNVI4TTdZbEF1?=
 =?utf-8?B?RS9JSXhIeS9lTjJFQWRwajF6dng3RklJbmtIVHNPZDRneW1pZzlTMmJtQmlC?=
 =?utf-8?B?MTZ2eVBtWWNRV2FRdnErS0JhYW91MkZTZlJFS0xQemxXUmh6SHRFVGVGeURV?=
 =?utf-8?B?ajlsUk9NWU1vcE9wTWZnN3Bpc3RuYkpUYlM2TkJzL2IvbmRJemtBbVoxSGh0?=
 =?utf-8?B?YVNEa0tiK0dHTlk5MzZmOUFRekl0YjJQVDJ4cTlVckd3NGhNMzRFeDdZWlkx?=
 =?utf-8?B?U09TRWhiWFRxOG1FblprYXhEc3YvT2ZRcXRNL3JoWnNZa041ckpzbkFZUnl0?=
 =?utf-8?B?Vmc0Q2d0RXdvbzBtVlV0QlluemNaQlUxK3U0aEdZYStNRWE2SnlzZTNSd1U1?=
 =?utf-8?B?Y0cxOXc2QVR5M2dKcXU4bVZQN3BDWXcxTURCRGhCTjFJLzFhZzNvbWo4eTQy?=
 =?utf-8?B?UkVoNHRZRlhzejVpcE5jNklhd0VsUkhVQkZJcjF3SW81NEdUNUtkMjMyQWI2?=
 =?utf-8?B?VWlKV3ZNbXpMNmJ6ZjZ1d1JtVldIZHErcko0SVljZVZCRmNqNTR0WmN6Wlc3?=
 =?utf-8?B?eGR3ekVHRW1iMkpUeGY4TXYreUJkb2VDdHFZVGN6MDFSNWYzWkZ2MW5wYk00?=
 =?utf-8?B?ZW9welFmUHJZSm9KR0dzREJEaEZETTh3Ukt5a3lyNnIxYnQ3dlBvcUMzTmMv?=
 =?utf-8?B?UE9HSGVJQzNDUjAybVh6QjBYL1ZSdFd5azg5VEJWZWl2YlhXSENTcklyU0Z0?=
 =?utf-8?B?UndqZEI1dnpLZFk0ZkgvelVjTDdTVUl3dC9FZHdCR2tKN1RVZ3FUVnE4YjF3?=
 =?utf-8?B?enBQSnExWkRVazl6WUtJRzl4UmNZa0pBUUVxU0sway9NaGxxZFIvVDQ5OC90?=
 =?utf-8?B?b0c0VzM5amtrelR5d2lzcGYrbjNBUjVkMXF4MmJab2c1Z0MvZWJUaHlldGNF?=
 =?utf-8?B?SHErREpNWFBoVmRiNGVoWnZXS0QwZDd2ZlJkck1EZVBQOWc5MGdSWmNydGhC?=
 =?utf-8?B?KzQ4bm9RUSsvNmk3dTIwMXVEZEZTSGlOalI4eFN6d3krcHFVc1RqM3pqdDk1?=
 =?utf-8?B?WFQ5UDBENkgvSWQ0cTdqQ3ByM25NOFBpS3hWVzJMNWJjK1RmaEdvSGk4elJ4?=
 =?utf-8?B?WjU5RnJoRWdPSTZRSDNuRnVIN2p2L1VjZTZ3U3M2NXU4RDdJQVhSSlhlTE1J?=
 =?utf-8?B?aXNLc0VFQVhIVjRrbnJqeVc4STlRWldjblk2UkZSb0lCMmJoMDBvemN4YURC?=
 =?utf-8?B?QXg0TVlFOVhSemRPY25lZkhQRkZXRmZCY3Z4d1JicWRvSXVlQVBFVjRrb2tt?=
 =?utf-8?B?YlJ3cUtNSkh4L2ZuQXpZQ1R2T1k0Wi9rWGtnRDZDbVdqaWhWbk1hUG81Q1kx?=
 =?utf-8?B?dXg4S1lzeW4wVTJpSFFLdFVXTG44VXlJRUwzYjk0cnduc01WcTgxendjM2g3?=
 =?utf-8?B?dzRTd0RBbXY5Qms4bVZvYzlGS3FSd0JUTlZnTVNiVWVBTGtZbTlYYmx5QkFG?=
 =?utf-8?B?SFc2Q080bldXNUQvakxySEdhVGJwejAzd1RFdk0wTHJyME8wSlNSSlg1N3pj?=
 =?utf-8?B?ZFExZmZkeVoyLzRGYVB5U3drcjU0TVUzVGJZT3pkRzJSejlKWGFxSjhzUE9M?=
 =?utf-8?B?d2lwUlh5dS8zNGZWRzRCYnRoNTUyWSt2M20ycUdnTmQxUXlBZDdaUVZQcHhK?=
 =?utf-8?B?THVSK1U2MDBEVmYvaGZRWjNieVF4aUU4UkQrdXJGVDBhc0pPSUJYUDFrM2ZX?=
 =?utf-8?B?SS9yZ3Y0dk5ZWFpDUGI2N3Jod1V4NUM4dVR0K25WWStPZ21jU25iVGt2ZUs1?=
 =?utf-8?B?MmhqYUxLUEtuN2tPSmxRTXJZK0dOejBORUl1bWZrNEd2V3piTlJpRjVqaDFR?=
 =?utf-8?B?c2N4RGFORDQybFdRQVkzYzM0TTJheW0rMmRlVktYK1JzZ2pZSjg3OUNMdVFv?=
 =?utf-8?Q?/FnLe/qlSxJVqU3s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d91fb1-9017-4daa-40d6-08dec505f249
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8130.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 02:30:46.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqH+slh2tA+h4IpUaAHd6ZQe+MHkZEEexmh6n5GCKeZ+v84m5EyA7mJVk7emZ74XmFrtDCosBeOsyREkMgaum4xgvAdP/rMDlPHFybMuKfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7236
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

On 7/5/2026 5:03 pm, Chen Huei Lok wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Update N5X clock driver to support enabling or disabling
> the peripheral clocks via clock driver model APIs.
>
> The caller will pass the clock ID to this driver and the driver
> will then proceed to manipulate the desired bit in the N5X clock
> manager peripheral PLL register based on the given clock ID.
>
> N5X_L4_SYS_FREE_CLK is a free-running clock with no gate control in
> hardware, therefore attempting to enable or disable it is not applicable.
> Return -EOPNOTSUPP for this clock ID and treat it as a no-op in
> socfpga_clk_enable() and socfpga_clk_disable().
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   drivers/clk/altera/clk-n5x.c | 129 +++++++++++++++++++++++++++++++++++
>   drivers/clk/altera/clk-n5x.h |  19 ++++++
>   2 files changed, 148 insertions(+)
>
> diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
> index 185c9028a78..5d7b5f1e885 100644
> --- a/drivers/clk/altera/clk-n5x.c
> +++ b/drivers/clk/altera/clk-n5x.c
> @@ -13,6 +13,8 @@
>   
>   struct socfpga_clk_plat {
>   	void __iomem *regs;
> +	int pllgrp;
> +	int bitmask;
>   };
>   
>   /*
> @@ -437,8 +439,134 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
>   	}
>   }
>   
> +static int bitmask_from_clk_id(struct clk *clk)
> +{
> +	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
> +
> +	switch (clk->id) {
> +	case N5X_MPU_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
> +		break;
> +	case N5X_L4_MAIN_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
> +		break;
> +	case N5X_L4_MP_CLK:
> +	case N5X_NAND_X_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
> +		break;
> +	case N5X_L4_SP_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
> +		break;
> +	case N5X_CS_AT_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case N5X_CS_TRACE_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case N5X_CS_PDBG_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case N5X_CS_TIMER_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
> +		break;
> +	case N5X_S2F_USER0_CLK:
> +		plat->pllgrp = CLKMGR_MAINPLL_EN;
> +		plat->bitmask = CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
> +		break;
> +	case N5X_EMAC0_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
> +		break;
> +	case N5X_EMAC1_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
> +		break;
> +	case N5X_EMAC2_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
> +		break;
> +	case N5X_EMAC_PTP_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
> +		break;
> +	case N5X_GPIO_DB_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
> +		break;
> +	case N5X_SDMMC_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
> +		break;
> +	case N5X_S2F_USER1_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
> +		break;
> +	case N5X_PSI_REF_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
> +		break;
> +	case N5X_USB_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
> +		break;
> +	case N5X_SPI_M_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
> +		break;
> +	case N5X_NAND_CLK:
> +		plat->pllgrp = CLKMGR_PERPLL_EN;
> +		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
> +		break;
> +	case N5X_L4_SYS_FREE_CLK:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static int socfpga_clk_enable(struct clk *clk)
>   {
> +	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
> +	uintptr_t base_addr = (uintptr_t)plat->regs;
> +	int ret;
> +
> +	ret = bitmask_from_clk_id(clk);
> +	if (ret == -EOPNOTSUPP)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	setbits_le32(base_addr + plat->pllgrp, plat->bitmask);
> +
> +	return 0;
> +}
> +
> +static int socfpga_clk_disable(struct clk *clk)
> +{
> +	struct socfpga_clk_plat *plat = dev_get_plat(clk->dev);
> +	uintptr_t base_addr = (uintptr_t)plat->regs;
> +	int ret;
> +
> +	ret = bitmask_from_clk_id(clk);
> +	if (ret == -EOPNOTSUPP)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	clrbits_le32(base_addr + plat->pllgrp, plat->bitmask);
> +
>   	return 0;
>   }
>   
> @@ -466,6 +594,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
>   
>   static struct clk_ops socfpga_clk_ops = {
>   	.enable		= socfpga_clk_enable,
> +	.disable	= socfpga_clk_disable,
>   	.get_rate	= socfpga_clk_get_rate,
>   };
>   
> diff --git a/drivers/clk/altera/clk-n5x.h b/drivers/clk/altera/clk-n5x.h
> index f6a9f0a7947..87849d35e50 100644
> --- a/drivers/clk/altera/clk-n5x.h
> +++ b/drivers/clk/altera/clk-n5x.h
> @@ -199,7 +199,26 @@ struct cm_config {
>   
>   #define CLKMGR_LOSTLOCK_SET_MASK			BIT(0)
>   
> +#define CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK		BIT(0)
> +#define CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK		BIT(1)
> +#define CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK		BIT(2)
> +#define CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK		BIT(3)
> +#define CLKMGR_MAINPLLGRP_EN_CSCLK_MASK		BIT(4)
> +#define CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK		BIT(5)
> +#define CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK		BIT(6)
> +
> +#define CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK		BIT(0)
> +#define CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK		BIT(1)
> +#define CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK		BIT(2)
> +#define CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK		BIT(3)
> +#define CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK		BIT(4)
>   #define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
> +#define CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK		BIT(6)
> +#define CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK		BIT(7)
> +#define CLKMGR_PERPLLGRP_EN_USBCLK_MASK		BIT(8)
> +#define CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK		BIT(9)
> +#define CLKMGR_PERPLLGRP_EN_NANDCLK_MASK		BIT(10)
> +
>   #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET	26
>   #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK		BIT(26)
>   #define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET	27


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

