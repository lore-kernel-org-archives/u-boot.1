Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD40C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACCD984AA8;
	Fri, 10 Jul 2026 16:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n3ILKVuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FB884B07; Fri, 10 Jul 2026 16:52:02 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94F884A90
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R11SfObRULTNgakq9CW9F0/8hV0mazdRHzs0cLguZViZ9UbUMpzONRuO4UTguUZhiT9QOU3pqkhzkqo7YzOHI4yG0qM93k82tHUnzJu3RELoY94436Wa92RYC69FywqS2P9xjvM/ZAjZ1tVhkNfQi5yqWbiY9ymIbtVBH7/LBsIjXb9u7UpPEWgF9Tlz4PZX/ubBL52leKvsforxANtunWHWRSJNTsYtWGaeaXEk4lnL0iqMzaT8EjTv+aQcmz1rQihtnBCNP60zkiCJIA1Gi8MohYMsPDci4P/6GE1Qm0Ci/i+elXvgbGdCoWeyGVKhkOnQffmSO9CGaPwOcQ4AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCwoXQP+6lbmfqChQSeJmQKPHczRyWMRbXw6FCWozaY=;
 b=JPzOeFr0mg1ic5lCSzQQi//l78SjY1isFFBJYJM+A6W9zdj6V1Pg0FVlcz7LErYF4kEL5ktxXNddjW0HfVLEnDK0Xan1EvWSDHyXLXNSY8pF//Dc78rIxNQQ6ijSBsgteby9/zmFqoETxaHnwkEtf/p0dCzYAcVwoLn0Ebgty6UG86yhpeeh2ZFuf3MTIt3+tCDRUFmbOoUpqBG8O9ZYOvwktJiYZZd3X9MjvQxL9Xor2SbvqcantUxiloklMSA1f/YnPv9x1ZSEOxNIL8mGDunporeHJzR6meC2E0Zr62yy6Cj7NTw88dMHx5jCOeh1CHgwpPPEEpAJBa7JRpkNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCwoXQP+6lbmfqChQSeJmQKPHczRyWMRbXw6FCWozaY=;
 b=n3ILKVuFj+4DrDeSE9Oh8QFbQiWYc8K5O/0NT+eSM3DrXdz9YXnQoXnkn6CY56CIE+cGIaS8HDHzeC7zaYb8KcIy7q2EOT5IZoVppWyc12+QYuub2jBPIkizd8iNgq+4IgDrMDrzua6MRkPPB4dGZ92MoocHhR9q+v08H8JoNEV6Yrsa1/ZK2StEhwysFIrt0b/cecFHiOUt6FqdOjdE1jF/KRPgz2A9xJizdTXknN2pQLCYd4PXjqkHHmHyCwLVjzz0dntpJvXLwoSLX1Ua0u91p5xAe2jpGijHWO0ZJwUOlpy/SviELItCIJ6TS0PDzUVfIaIli8yY08d+hf1sHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7584.namprd03.prod.outlook.com (2603:10b6:8:204::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 14:51:54 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.017; Fri, 10 Jul 2026
 14:51:54 +0000
Message-ID: <904d1c75-ae6b-43e4-b066-959105916bd6@altera.com>
Date: Fri, 10 Jul 2026 22:51:45 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH] arch: arm: dts: agilex: Disable gmac2 node for Agilex7M
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: marex@denx.de, simon.k.r.goldschmidt@gmail.com, trini@konsulko.com
References: <20260429081529.5713-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
In-Reply-To: <20260429081529.5713-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 3530ae3f-28ca-4575-1112-08dede92c830
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: QB105rAlta9+hGqQToIdyXCnMb5vis/3GWsEXsH2VQ7zdOTz9+bi1uMH8lgNXemXOBicZ6iErT/xO5h5/PGd5uXFOcJ44jFnoqQzzB7klPLTkDTbKdOti2G58TnYqALXUbEEkS2fRTGVJNohPLM/UhQTnT7sdXBqmtdmvDMZh2IsbKpX/NDI9NXosPObSV0dCgunZGCD0qcpwhaodfPZ4cf6TGI9y7nTJlvkmF2ZhRUgSVS+Wo4R6IB2ME2v/NCTW6fHBwFaaQ8/kiBdvg5SluoU8eRkpScFNl9J+vxHbDAzdVvtbQQef9jYPYowHE0OIW8XDsyLM1Z8LOxAVtmXf23lT3EmbXYJ9kWOAyeh2xmdfZELcTv2wNwo6xQKnO568NE/ovouBAI3P9N12Tgwg71+G49LdtfUeSJNQNd/y1Jno9TOxuTzD1io5PV9UMu8iFZgzCDO5rEnAGUSB0KJYd4dcleLrk2wB/LtwCikaTmRngbl/EioCrFH64vh9yRCu7plHTHesc61SMU0mD6BCnZHR+3YjCKlCeyQXJ3jOSSzhuQb95HYJWra/VVzsteGNX+DGj+lDvNfpRtvkmYasRlc3+1xrGlnfzSE196z3nsEihrgxWPR3zf4Nkg5Ht/C1i7B11T6z7qQNwRHH89zyhwTPLiNVfaR+qtyzT/pBTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZIVGFTV0g3R29yRVU3cGVxc2NqbnErMnYrNHc4Q2x0dUJGRXBXNG4rOEhr?=
 =?utf-8?B?ZkFkcXNUNFRWRXNHaWd1RFF5NUY0ajJFQXl5czBmRm1waWdLUzRNb0c2TERQ?=
 =?utf-8?B?eUFSMWxqd0JMNS9kdnJZenR0bFFFZXFVWU9wSjVEOGRMMnlaR3kvWVFtMGIx?=
 =?utf-8?B?UE9hWWxyOVozYTA1K2kwa1NlTE5zdmxtc3o4bHBrZUJ5aUUrZS9RL2FFOWh2?=
 =?utf-8?B?Y3hMT2lpcWMxTXVMa1VjL1dhcjVTdlROYS8wOExucmlXYVFsdkV0YnpNeTFG?=
 =?utf-8?B?TG5lTkZ3dzZwZTA1ZG90VE4xZkhBMi9MY0dQOG1XYU1QUm16MFJWUWF0cE9O?=
 =?utf-8?B?OVZIaTFZSlp6RVFFM1ZXeDh4aWhLb2NFeUdUWjhsNmlmakxEaTR4WDMxaVp2?=
 =?utf-8?B?Qm12U0M0T2s1QlJwbE9YVmRIaFVXaTMrUkUvQ0dIb2NqMWNlSUQ2c3djaVZF?=
 =?utf-8?B?cE95K2IrYkRHZUxhUThLRVhyOW41YnQ4bi9xS1gxNGs4TVNDcE5VNkdBM0xI?=
 =?utf-8?B?SlA4MHRYbERSZ2lGZitRa0Z6OW1SaUtXaTZaYkQ4MDE3b1JvWTlTTHN5dW9J?=
 =?utf-8?B?RWt2aUtpZlBrelV1RHB5QktRa3p4YlJvMXpRN3dwOTFBb2xnMmxkZVczNHlq?=
 =?utf-8?B?eFYvRVQzWlhwUExBRENoV3E1NWRpL2xadytHbUcyU21HdDhkQjEvRlNWajBO?=
 =?utf-8?B?TmZ1aFBGWlhoQ0syQVVsQkJjZWk4OGVpZkZmTVZ3aC9aK2ZTY0k0NHdsQzlX?=
 =?utf-8?B?bWN0R0JmQXFoUlNySmVVbGJxWTVKbDhsVVp5UktGUXl0bkdXQ2ZXbEwrbFFt?=
 =?utf-8?B?Z1R0emRBdFZmMXlidjZHQnF4dElUNVQ5S3J6UUxxck1CdTNoQXVMVzVnQ2Jj?=
 =?utf-8?B?NUlrRVBXaGZEMXJ1SHY1WjFzNE1KRlpSSDlpeG5SNkphTHlIaGZpZ2M0NVZS?=
 =?utf-8?B?dHZxdFVhcmN2TWpITnc0MXhnZlVpbUdiUjVKeTJiNFNOWDRRRjZSU21ZK0xQ?=
 =?utf-8?B?QVRMRHFHdXZibUQ4MndJZ2JONGhCVmUwRmczUDRZMjZwdTRtY3J2L3Q4VW9S?=
 =?utf-8?B?cE5IRGc2TWZvR2hDajdNQjNWZmgwNjd4Zjc0WlRmendwMEIxckVML251RVlF?=
 =?utf-8?B?SFA1Mk51bEJCUXRWZ2hkVTlQN2tMN1FTZHM2NS9SZlR5U0JPRFpIQllqTmFy?=
 =?utf-8?B?Tkt1VUw3aUNZcE9rSFBrQVIwVUI4Kzh0NWhLRGpTQXozZGFsWTBtV1VWaWRJ?=
 =?utf-8?B?d0tBMGljakhWREJTWjh0aG1Ma3N1WkExV2lYTnhEakxYWkNQYmRneFNJSXM1?=
 =?utf-8?B?OXNzZ0tKMXdDOHJ0dTFnUEdVdmlsbjlRZGtsTVlpVERKVWFmZ2VPbXUwbmRt?=
 =?utf-8?B?Vm8yWmgvVmlWemFTbEZsemk4T3NPQVMvZVVqa1Bhc1IvanQ4dm9nVjI5cFNk?=
 =?utf-8?B?TmtTMHMydmxuSWtIaFNtMWlHNVFRb2RYM0RqTUJBVkpPb2xMclhvdHNyT1V3?=
 =?utf-8?B?Y2lIK0ZxNHpkNFJDVE9yMG5JVUFYZlc4QUlLejlCblBvbmtYVWFtcFNlQld5?=
 =?utf-8?B?aWZzWEhqQ1drNGlCMDgwK2R5NG8yTG9xelpYbWVHOEJJckV1T09KT1hZbkN6?=
 =?utf-8?B?MkxOdDc0RHQxbFpRUWRJSS8yK2NyelJ3aUhRWnlCNWlnREZqNXU5bVFSU3pk?=
 =?utf-8?B?cGlOZjVOL29mNmtBZEF2bUR0dGtTWmg2ZktKTm5UcTd6TmdLMWczOEkvMkNI?=
 =?utf-8?B?K1pteGlhUTNyQ3dYZHp2bzBia1hJRTBoZlRTbk9SWTFhcldmZmhkM0I1ekhp?=
 =?utf-8?B?Nks4UFJXZExBTkFUb3ZzWU9BSndhOTFLcHRicCtPZ0NDRjRFVzhBVWtFV01P?=
 =?utf-8?B?QjViY3c1ZHRhTW9WVXEraDlXSjBuSkkzY0tQd3NlUHNXZnhFaXZpdnFxbzdj?=
 =?utf-8?B?RHJMZ2dKRCsrUE1oQlpRZVdGOW01QjVPTU9ZWTdraktLYy9BN0p1MlFNUXF5?=
 =?utf-8?B?QjBoOUlBQWhZNTlWUXFYVmpvU3o0dWVFMHJCWjVNODZXWWhJanN4UUg3TTBG?=
 =?utf-8?B?Qk82RStmNERsZW44OEQ1bFIwNTRweFRuNHpyNWVLZHQ1bmY2Ukt1WjNyMDN6?=
 =?utf-8?B?bmhaT3VqRHBvRlA1NG9uZ3R1djQyMXoxYXlvcllEY1lFTFlZdk12V0pvZmJk?=
 =?utf-8?B?MVlqOEFrZDFHcDZKWE1PSmw4cW0vamk2a0JGdjRVMmtwenFRSXE3WHBzK25X?=
 =?utf-8?B?MjhMeHg1SzVtR0dnb0RHdjBJMCtkSzh5dU8rVXE4ZXJhcUpDNkVqc3VtSEVI?=
 =?utf-8?B?MHZLaElkd2x4T3ZxZ2VyMzFGRUhneDlmNTVzU1RZS3JuVHR3SU8xZ2dDS2pv?=
 =?utf-8?Q?aWD8zErzrE9I6oqI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3530ae3f-28ca-4575-1112-08dede92c830
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:51:54.2433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dtp8LdOjmA3LE/Ka0nLhL/9c3ih4Ll/I4sZs3c+mMcTe02/ehbHaZJWRDqkHh6ieWBrmE+P67WUf3mUJgwVrJ67TnEPblIwR1i1qi6V+uYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7584
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

Hi Alif,

On Wed, 29 Apr 2026 at 01:15, Alif Zakuan Yuslaimi 
<alif.zakuan.yuslaimi@altera.com> wrote:
> Disable gmac2 node with the incorrect settings to only enable gmac0 as
> default for the standard reference Agilex7M devkit.
>
> The gmac2 node can be enabled and configured with the correct
> board-specific settings for other Agilex7M board variants in the Linux
> device tree.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 30 -------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index f2150b7eb7b..9dc2c66f6f1 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -69,36 +69,6 @@
>  	};
>  };
>  
> -&gmac2 {
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&phy0>;
> -
> -	max-frame-size = <3800>;
> -
> -	mdio2 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,dwmac-mdio";
> -		phy2: ethernet-phy@2 {
> -			reg = <4>;
> -
> -			txd0-skew-ps = <0>; /* -420ps */
> -			txd1-skew-ps = <0>; /* -420ps */
> -			txd2-skew-ps = <0>; /* -420ps */
> -			txd3-skew-ps = <0>; /* -420ps */
> -			rxd0-skew-ps = <420>; /* 0ps */
> -			rxd1-skew-ps = <420>; /* 0ps */
> -			rxd2-skew-ps = <420>; /* 0ps */
> -			rxd3-skew-ps = <420>; /* 0ps */
> -			txen-skew-ps = <0>; /* -420ps */
> -			txc-skew-ps = <1860>; /* 960ps */
> -			rxdv-skew-ps = <420>; /* 0ps */
> -			rxc-skew-ps = <1680>; /* 780ps */
> -		};
> -	};
> -};
> -
>  &qspi {
>  	status = "disabled";
>  };
> -- 
> 2.43.7

Looks good to me. Thanks.

Best regards,
Tien Fong
