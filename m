Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A0F9B5F5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5573C840CB;
	Wed, 22 Apr 2026 11:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FQ0SaoYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66ED8412A; Wed, 22 Apr 2026 11:45:00 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121EC83936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8JlDpnX01eaRgIq8gvjPW5oVvYhr/+czETBxYmBi1pDWpnebbqhMjeZoEpk1LYxHWgZrQP4+mzWE5s4iw+/eCSLMUR66ZbDGIuZZQRowbOLI1oXKOgeO7ms62tGgtHoW4NbiAHA+Glo3u52LUCD4zpkM9TOdVILgdclsErfCk+WIGa3fVsugPH569KfOLk6r9uqSSpVMUuiHFmIGXFPYJqlH+sJf3RqrAOVWwVAXYPKJME1F4Uj2x2JKDGiKbCXxnojRlghK4Rwa5KbrzZk1xsjcduoF80JZndI8s+fGQUkmG7tOQHntDvGQR0TwNE45AtuexR3YgrZ09fxIt39XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIri2beWygyrXwTXLrd7ugxVlvb0VMobywFUzqcAgYs=;
 b=OO8ApweRlF/+7kNb/cPKaQ0bq0Mxkw4ykw05QqpgtzJ6ntEK9o4oNG4O1bdAOMQkw4gTsz2jdOHeaqnld7uVRI8EIK1U49JcQmE4Q9m+4y66Ec+v1ri/a0lBZgQdbfB0ptNHEHyBSQYmeCLF9uXwfGvDg0dbpCXU5ged9rayMBmAWu79nIOT+wHOU1SpR/Spz/N3fua1+4PfTD2YFP0JR+ccL+BEHJUnZUVCHnC7+tFQFG/9A+Yc55SZoMGYUe6da83oSbhqO1irOOvr1q6qqZlQ4WCTIUI0Nxpe8nDG8nRylpQNaYsIsLSQmETRzF0bG3ocq1TlPOxmBESAkEir0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIri2beWygyrXwTXLrd7ugxVlvb0VMobywFUzqcAgYs=;
 b=FQ0SaoYQIeVaGskVD5QurDxX58AKoGXnNboMnIKjsU0DQ/VSXr8TZqbSHoa36xP7ULw7Yb+NBxlIcRtr/oLlDybRYxeWKR/G4sWeE4s0slI6sjy5htSAvkbXs792FCICrSdN5NiStxa2ejDUuK7ALIM80Ny2W79ELjEkZAd+fE+6tCWQkSzVlfc78O0TjzmTbgf4GgGG7TW9Z7K9gOJTGvi+RXSH+nQd3Oth7mp/KZROxZM2Ms1w86B7Rnb7mjUrngIL8KZxbjFtLFiSEkpLMW/65llrFx2OXsUL4trpyemNX7FuvMh3oQCi2bCUZ8XGGgB33C0GD/w2JP1kalJgDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7249.namprd03.prod.outlook.com (2603:10b6:8:114::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 09:44:54 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:44:53 +0000
Message-ID: <1ba3eaf1-d4c2-4138-b15c-aa627379fdff@altera.com>
Date: Wed, 22 Apr 2026 17:44:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] arm: dts: socfpga: n5x: enable DT register
 settings and update GMAC nodes
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
 <20260318030034.25889-3-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260318030034.25889-3-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: e76a7edc-c74d-4f65-d7af-08dea053cde6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: bTWWXM4C2JQ+cvKenEkc/o/DOL2fd1S6XojXdtSDu3AfN1IYCiMRuMsyVTZPhhC6ItOF3ZCS93WcKhQ1vDxcNeUwxjSOkMjmQMEmMM/ObQ60vwYz0eetW4gi1R83ttEuMCcZIJkOb57Y25NhhpPJbAC3t42Mizlg9vSHFMynMBXSi3dNs2G+mtFsWCxSvKbsBBCn5gDLLEyDkJq+QGaWB6DDCstifiYMNZe+r9Mo5LpVaDmmaJ1CF0nS6NLc+qUohCjODVnaRWH/L35ZUq1/qgpxHWoA5vIUZBOQG75KAvWo34rHxVVWcjbKdP9PZD5LbjED5M5d1T1VkXDMYDX1ifL81qXF6mrZ/y6dJcWZSdVIrU7SnjmgivUDBDRPZo0fYTfFmJ2m0b4EPV4T1bVC5K1R36GgOj4g0qRW0tkoCjHHoQ/Q2AprGOFdTCQT363RA5Uqo49P1pRncrcoO33yL/q4JoGQSJVzsNt3DNFZtDkSY/qX0SPwB2al4wbeg/twHCg70H3xyqZZalFgkRRtfpeHxsxjP/yPguhIX9w6oNNFFGeOagMlbkhcMXFvV6jvZt0X14byRQPTQIfa9TuJgZEoji0proFmIJsz2zlS+oG+kjoTKGsEVEbCX1rSVPOIlaLrEo3uwZzy1t+2vtBZGvIxvW3EDQ+SNT1gRqH3kVUoYBgX5LWej7FuEVabcque
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhiTTIwK2owOThHOUVmaFBCeThjWXdEUEtmVFpTYmJlMkN1a3RxTW40NkV5?=
 =?utf-8?B?RmM5OVlpZmhxS2FkSUM2SlVWZWc4M3hiSUFtUkpMQzd4UFBRS3M0YXE3ZFph?=
 =?utf-8?B?ODBjNHZneEcxc2tKLzcwL1B4ck41cmxIS0hYWStRTXVyK29scGhzZkM5UnEw?=
 =?utf-8?B?Z0R2L2I5YkpvWWFRQ1l2NG1BZ3pxMUNjUDdha3JoN0tjWlBvR3FxeXBmU0t6?=
 =?utf-8?B?cGVBQW82MlNtWG4xODQ4TXBkTWlEb3NaZHlrM3RMdWF1SWUrTFEvSHBVQXV0?=
 =?utf-8?B?OEpSMWd5bzNEVkNSVTcwT09RK2dqYXZFcHhFcHdBUDZWa1pHbUczQlFOdXBZ?=
 =?utf-8?B?UUpXR3BxZ3hUTElCN3lDS3F2YndUTExaSlkxdERtMFg3TnZRYjlTdWVoTEh1?=
 =?utf-8?B?WWJiRi9CMmFxbTk2eWl2dTJWbXNUM2NxQTJITk5YQ29RazE5WUZBcURWWGtD?=
 =?utf-8?B?MThJTmNuTjk0T3dNd25FNkJjc2liM2hQRE9NeGxmcDNjS3VqbXJEQUdsUExC?=
 =?utf-8?B?R0xRR1NyOEpVVHQ4cmk4R2pLVjVubWFBVmF5R291cTlVZy9INjJnenVoSXFt?=
 =?utf-8?B?aVVBcVVIZ0RZUk92bUpRWHI0VjBjQkh6ZzFwOWgyQndhWHFhcUxWdVo0Tmxn?=
 =?utf-8?B?YUthdGNiYmU4QmxtOWVoMmlmRmROSkZ0ZkU3d2xqREUzdUZmYzVwYk9QdGVy?=
 =?utf-8?B?amhqMS9KSnZ2UEY4bWd1SUdVYkY3WVhRVjZ4a21LZHlBYldVQjVtYjNMTGhS?=
 =?utf-8?B?cGFtRGdhYXgyZFNiZHF5NUxydWNlWUo1b1Z1TFdaRUZZSFU3d3UwTFV1V1RK?=
 =?utf-8?B?TUdWNkNUL2RKMDlOVk5lSjREUTBGcWNJbnZHMzY0V2x4b1ZIV1dCVzJPRG9B?=
 =?utf-8?B?cThQcEczMkwwMnU4UTkzcTZGTSt6dFNoNC9jamgrMnYxYTlucTQ0cmI2SHhG?=
 =?utf-8?B?aE14MFVOUjFEeVQwNnBZSnhuTTBIZFEveExKZnpNNUFVUHBkSENQNlg2OC9j?=
 =?utf-8?B?NktWVFhWeXRlRUhTM3ZQb2wyalFGdnhxN0trTEdPNDNoZWtMYWxLZVNZMUJQ?=
 =?utf-8?B?NU15bktOdm8zb00zSEQyaHA3U09ndmFGeXMzcTJCbjVXMzRCQ2xtdUpJdWF1?=
 =?utf-8?B?dkNIZGk2Wi9aK0xhV0V4VmJrUWtSNmdmd3IrZXk2YkFtY1U5bEtQU002R1V0?=
 =?utf-8?B?RDJxUmpvdmRGa2JCb0cvTFRUZ2NNQlJnbEFXL1JiMko3TzlUOWliVHE2b0Jw?=
 =?utf-8?B?MVdMUkhSRXFhNmlnNVhUc2M4QVpRYUVxVlVtQUlFbVRNdlFmSlQzWlF3dFRz?=
 =?utf-8?B?Ky9yUkpPTlVXS1ZpUXpNUllDQjhMemVKdXBURmlqaC9NVGJqSEp2MmpqUEpI?=
 =?utf-8?B?VmVXNGtTcE9BeDNBR05jNmMzbVZVTFMvdHg2TExUZThJdjZtSkp3TTEwelJ1?=
 =?utf-8?B?STVmNlRwdlFrczFIaGxjeHU1VDlsblp0V2dXakJvblRhMFc2UmpBZzVYbE5Q?=
 =?utf-8?B?OXRxVjZhR0NUVmYwZTRjU2Jkc0pUMEwxWTRxaVhGN0pNbmtBMTluV2RDaTdP?=
 =?utf-8?B?Z0pvT3RVUUlKemUvTkVDOVk0WXFINllmc1dQaXhIcnYrTEQxTFFtaGN6elNn?=
 =?utf-8?B?T05NRjZlQTFvMGpFMktRTFd1bEFGMDA5U0g3Uk94b0NEdHBmK3FGbnFCRTho?=
 =?utf-8?B?T2R1Ulg2WkxKcGh6T0M5UnNyTGwzYW1yWG16Z0JvN1MyT2syUUVqcjl1eDdk?=
 =?utf-8?B?UndzZ3pHWFZ1N0FLWEd0SlhSMS9wSXhDdXk4WGhrYUVGeWFDUC9kSXdsWmNz?=
 =?utf-8?B?VHo1WnRJRHNsVEN1OW9UTElwa3U2MWlYdEtYb1FKcFkvTUhhbFFHU1RsUHov?=
 =?utf-8?B?SGR1dXBVZ05RdHZ5S21mTkNUSG9wV3lvdkkwWnpkMlV6ZTJ6cnZ1Z3ZPMmtQ?=
 =?utf-8?B?VU5IN25YNDBmVTZyTDZ1VC9UYVRwUnorSWNuaFlIL2pmeWQwaEJhMG41SlpB?=
 =?utf-8?B?SSttVGtkZGxLQkl4MWhldkZldVA1aHQ5QTdCNGIvVVVwdTZ5TkpNbTJya1VB?=
 =?utf-8?B?Y3ZFMTV2aVJmUGNjU2NmcTJ2NWNqMUZvQUVUWC9LdE00bEFtOEc4NW5mdFBt?=
 =?utf-8?B?RjhWOXREN2hPMmxrdERVazBhM1R2WGp4SncrKzNhZzBXSnN0d2hWU0RpZzlF?=
 =?utf-8?B?VldFajh2ejBpcXFsdTJ4N1FIbS9uU2tDaHlqYXVuYW9VVXBPNHhnUlJVUjZB?=
 =?utf-8?B?dUxob3VEVVBLSkJBZEc1QWVqcisyN1RGRWFSTWlja2toWWxZeTArTkZ6cUd2?=
 =?utf-8?B?b29ucmhlVWhTd01TVmpYckg0SkNjU0JINENnTzdVQjZxZlRQaiszeGg2Ukhl?=
 =?utf-8?Q?zFvXZLNUO4tJdjLY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a7edc-c74d-4f65-d7af-08dea053cde6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:44:53.3153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJ/DI3oCZoOX9uSLsJGO/CLE0VpjyasYK2d24NW4VQ++EMPpSLrhsgNE5XBcUyy5C52k31sHNvbRmhJ3YqU7+XE23PQ/Jz1Eu4EH6ZQEc6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7249
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

Hi Lok,


On 18/3/2026 11:00 am, Chen Huei Lok wrote:
> Enable register settings in the N5X U-Boot device tree by adding
> firewall configuration nodes under the L3 interconnect firewall.
> These settings disable OCRAM security at the CCU and relax MPFE
> firewall restrictions required during early boot.
>
> Update the GMAC nodes to include proper compatible,
> reset-names, and clock-names properties, explicitly setting
> their status.
>
> Remove the clocks property from the QSPI node in. The QSPI

The sentence ends mid-phrase. It should say "...from the QSPI node in 
socfpga_n5x_socdk-u-boot.dtsi."


> controller clock is obtained via cm_get_qspi_controller_clk_hz(),
> so the device tree clock reference is unnecessary.
>
> Additionally, include socfpga_soc64_u-boot.dtsi and rename the
> soc node to soc@0 to align with the common SoCFPGA DT layout.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  1 +
>   arch/arm/dts/socfpga_n5x_socdk.dts         |  2 +-
>   3 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> index e27a64651e1..326ba722a25 100644
> --- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
>    */
>
> +#include "socfpga_soc64_u-boot.dtsi"
>   #include "socfpga_soc64_fit-u-boot.dtsi"
>   #include <dt-bindings/clock/n5x-clock.h>
>
> @@ -15,7 +16,7 @@
>   		bootph-all;
>   	};
>
> -	soc {
> +	soc@0 {
>   		bootph-all;
>
>   		ccu: cache-controller@f7000000 {
> @@ -46,17 +47,29 @@
>   };
>
>   &gmac0 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	clocks = <&clkmgr N5X_EMAC0_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "okay";


Enabling a peripheral in a platform-level dtsi rather than a board-level 
dtsi is wrong.

Not all N5X board variants will necessarily have GMAC0 active.

The status = "okay" belongs in socfpga_n5x_socdk-u-boot.dtsi


>   };
>
>   &gmac1 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
>   	clocks = <&clkmgr N5X_EMAC1_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
>   };
>
>   &gmac2 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
>   	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
>   	clocks = <&clkmgr N5X_EMAC2_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
>   };
>
>   &i2c0 {
> @@ -132,6 +145,29 @@
>   	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
>   };
>
> +&socfpga_l3interconnect_firewall {
> +	coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {


DT node names should follow the generic naming conventions described in 
the Devicetree Specification: short, descriptive, hyphen-separated names.

These look like register block names copied verbatim from hardware 
documentation.

They should use names more like firewall@f7100200 or 
ocram-firewall@f7100200.

Also, the mixed case in OC_Firewall_main_Firewall violates DT naming 
conventions.


> +		reg = <0xf7100200 0x00000014>;
> +		intel,offset-settings =
> +			/* Disable ocram security at CCU for non secure access */
> +			<0x0000004 0x8000ffff 0xe007ffff>,
> +			<0x0000008 0x8000ffff 0xe007ffff>,
> +			<0x000000c 0x8000ffff 0xe007ffff>,
> +			<0x0000010 0x8000ffff 0xe007ffff>;
> +		bootph-all;
> +	};
> +
> +	soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
> +		reg = <0xf8020000 0x0000001c>;
> +		intel,offset-settings =
> +			/* Disable MPFE firewall for SMMU */
> +			<0x00000000 0x00010101 0x00010101>,
> +			/* Disable MPFE firewall for HMC adapter */
> +			<0x00000004 0x00000001 0x00010101>;
> +		bootph-all;
> +	};
> +};
> +
>   &sysmgr {
>   	compatible = "altr,sys-mgr", "syscon";
>   	bootph-all;
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index 840537c9d0b..bc2fb91dfb5 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -55,6 +55,7 @@
>   };
>
>   &qspi {
> +	/delete-property/ clocks;
>   	status = "okay";
>   };
>
> diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
> index 915b8f6380e..fe5462aff43 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk.dts
> +++ b/arch/arm/dts/socfpga_n5x_socdk.dts
> @@ -24,7 +24,7 @@
>   		reg = <0 0 0 0>;
>   	};
>
> -	soc {
> +	soc@0 {
>   		clocks {
>   			osc1 {
>   				clock-frequency = <25000000>;
> --
> 2.19.0


Best regards,

Tien Fong

