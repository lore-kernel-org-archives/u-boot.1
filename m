Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40916CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82D884664;
	Wed, 10 Jun 2026 10:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MXkFNMxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427B380086; Wed, 10 Jun 2026 10:47:49 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43265841C2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uARn4hdDX7UF/2DiJrBbeXb9iDWLVlMcjEhPCuMQhs7xQ4T7YOmAL2kRw/J/S75QgRQNPQkkRiQHwdYOWAgXrNB6hUnlURrjaBOjc3//wfLb0a76P2oRPP1eC+QKraOfK0o2nlXGJwIeQ5fuSBzsd9T4kkb7Ip9F8K6JCR/3L4f3VQlqqVe0RCnKyh2r/3JIPDonkIVPnCm5wVK9JugBon4nT6gEy8xTKn2To4T4ug0JWpa6VMDJmyoOz3iR13Es6e/39cT6cZHwdUuEnt8XVxF0VYOSxeM+7SA9yBwuJIddZU20LaT1X9YOMdrKjNJwNDN7NbSoiIx/LUUfWo1Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPd8cRgBVQ0xZiCQ2g4p3mlUUjxffC30EkCUZ+GUMk8=;
 b=NFZoq/u1Bh9qudfxNxeZwckI1VNez4LAJpSk+RJ1hgo6VaN2fMNQd5GQ5l7ViQdfAf3DjWA71H5fDO6VJYzUxBnmSXDpnvaFeaE4tElN6NJ6XYgyb0JuZIJl0T1Hg7U+KMkRKV2+kvUh5orD76YBaqCw3rNss4ulQv3eI2wwIxMS4GQV4F3/n4xv8waoCmD72naMUEHchKURvopWQpS4Cd+qpd2JwM87NFUI5dsaDCa/k1+X+KummHhQwK1V1nqZuibxSpLTtvz8GCaDGaFCeTuPcVZaF3gr17326RNH+92JEx35B17XDAyk1NOP0l/+88N1raqeDb5NbegUo1yplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPd8cRgBVQ0xZiCQ2g4p3mlUUjxffC30EkCUZ+GUMk8=;
 b=MXkFNMxWil+QlcpoFMLYuFh2zIFIYjrOLqRVNWiFv9nlopATls2IFvyxpORMfSFlhrfIFqr4Sb0cJ38cO+yThaLU69W28GT5Wfnpd6T59hd1Lr5oMcKu6hz8BSMYPE2KmjzHoM824oCkvq+tXH9aHAce+HeYkU8j74IyHcBW0tJtZAl3gTdNqW0KT8T1fJdMQqRIOoFzbUPm60LpMNNMAK+uI1U4/Xwm/Crg2mgLiMGE/R9isXzctL+80gTdDABRcVeSxd51HXJrsBqvPzrQcAXmIs0QGjiUhELi76EjpAOA8PC0zgQLpl9876O2MKdhQlNZrMkSBUPnzapIkxyv8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:47:42 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:47:41 +0000
Message-ID: <0e0a8bc8-06a5-45ed-8559-39e870e5d4ca@altera.com>
Date: Wed, 10 Jun 2026 16:47:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0216.apcprd04.prod.outlook.com
 (2603:1096:4:187::18) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4dbd20-8edc-4ded-c9cd-08dec6ccee77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|13003099007|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Wk4SbzGubVKguUdnMJsrjsLIcu9hwNf4ibmuu86XC1J4svLLzDxAmLHzT/YAR6nSmOitT4Mb0pBVGHybzJUHXffjefiNiCdij1WWJeIiOjeV3yPY1pcBm9xV3kz7uSfe7WJrAxpZ/myUAQ7hewmMVNR6PLvJSCBXNWy1iGVYBC0ZEcUG33zwEtH+1rKT91ExNmzSEkYSu5tbbVoh4uSQI3nkYZG7/0nB4zyrUyO81vI1r52P89WCxgy8DMLUgqUc55qIwQ/wJ300gzronqDT8My6aXooOGWUVD5mJ69bVGaZjBwHMbTzjh+uwfNQUSESl8db6tyHCUFl340NSg1hs6lGF4v00OKx6PAgI9MU4SVpTPOUPrxpW29apOfNrWDCYFwD6gSedB6TdNDmCXFvHr0jScrbG5RM0poGu6cX3kQYM1N32aMoIJbQ3ujB8Q+BXsVTNpndh7n93HRjDP4yQ0z3ZMVtzNCBFE+DD4HpsCJ6R+GFykwgXaFk4g/CzdS9nd0TQW3OcM/66SzEgiGG6ifxll9eQ2GFhJ7QJQpH0bwwg3MVY7GQ0D5VV2w9eHsfif85iUdfhLbupgVsYFkg/FcwmEdmK238tnHkscEa5hd9ZvmP45A4VNrr0zL3K/FH3oiQfSHiqhRV5XEb2zLDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(13003099007)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJpMmJvZ0h0cU16ajBBczN0UTZtRy93QTRpd1llc2x5a1N2aGl4OGtVV3V0?=
 =?utf-8?B?L1ZuVC95blZqKzFMcmxHUDgxK2hOZ0xtVDBsbzJDdWJMZTlPRGttcWNEa1NK?=
 =?utf-8?B?NFpNVW14QjlMUFp2bmQyNmhnTTk4N0dEVFc5ZFMyMHNoSlBPTWJ6WEFwUkZ0?=
 =?utf-8?B?Qi9WT1lTcWFWVEIvQkFtSFRWYklWbDRrbWFwYXFnaWEyQTVpU2RFNkVxRmFZ?=
 =?utf-8?B?YUVxL1czTzQ5TG9nenpMREdzdFZzQmI1VWtLZjk1MlV4ZW51K1pRRW9ldy9s?=
 =?utf-8?B?VXJmRWIxWEJ1S2dSL1BZYzRxdnpCcE1EWk5pZ2FjbnRuRDFKcWVsVjNQMDZl?=
 =?utf-8?B?U0JJUWkxZFNzN0RJVUUya016dW5PclM2dVhrbVYyb0htWi9sTDZZTG5VKzZB?=
 =?utf-8?B?Z2dHMnYxaVJ5a1pUYmk3M1NXbm9WR1JrMkxjaDFRTFdlRTd2QTdPdVlsazBI?=
 =?utf-8?B?bU4vWGxxaEJYTHplRnV4VkZsZk1IcGF2L3hqeWJsdVZUeEc0T242K3MxZ3Rs?=
 =?utf-8?B?SWtOdU93Mmx1eENVUzk1cUtDVldYL0tQTG1Fcml1bEVGRGlGbi9pVzNYL1ly?=
 =?utf-8?B?OVRSYTV5RU80YzcwRkRkQW1DVUdraHZXTDZaZ1NzOXJLMVpQY1dDU0UrSzFw?=
 =?utf-8?B?S1RzWmxORnVXcUs3OHN4WkdCemxBQWJFZjVxbFZkT1RRZkl3dFMrL0VHUUx0?=
 =?utf-8?B?SitZdXhzc05kajk4aDhYZVhXMVo2d01aQjFiYXNPLzh3b0cwSXhkSkxjd3Q5?=
 =?utf-8?B?MkdSRXpOVGRrSUdHQ1Q3SFVpYlJLOTlJWWx0Z1BVZHZaeU9GTDFoUkViSWdT?=
 =?utf-8?B?YUs4S1RSMmdRUlhReGc3UE14WnczNGprc1lYaWZRcEhGWkRsbEVXbDh2VFVr?=
 =?utf-8?B?dTdqSjBTZStpbExHMGtKNXdCSFljMFZvbXJMMWhPaUxQbmVrdHZzbmpndisw?=
 =?utf-8?B?S2dxeUhOMUg0a1pwZDg5VjNWWjU4WGJydDVmaGx4TlAzaC92T21Ob1lmb255?=
 =?utf-8?B?Ty9LWXdGV1hLeTg2T1c2cWlHa3MvZnpnaVprUGhML3dqTkN6NFNQWlVzazQy?=
 =?utf-8?B?T2ZuNjRNM1lOYlVmTGtDQXJ4UW1wWlVCSjBtcjV5Qlp1bStFeTlhN1N3aVVM?=
 =?utf-8?B?aWE3Q0xPdnlCK2tpdUcwSnlGVHVueU1xT2gvdVBPR25KcjEwUmhJWGE2cVpw?=
 =?utf-8?B?T0hXZGxCU1E3aVhHT29vTjZWWUdwS1dMQm1ESXdoZk5YMFdxNjc1M2pVenYr?=
 =?utf-8?B?dCtINVhPek5RcWtqREJocll3aGExd1M3NERGbmdHVzl1NmRiTGE2dy9Bdjln?=
 =?utf-8?B?SXdpajgzeGZuUXJ4RmExR25IZzJLM3NXNDNSSkVncUdyaEo4SDB4M3Bkd2lk?=
 =?utf-8?B?N3lldmtQNy8rWWZQTE5OTnZZSnBoYm0yVlJrbWVFNnZjeks3N2h6WnVPa1V5?=
 =?utf-8?B?VitmQ2llWXh1UVk3S3d5RWlWYjNsakNxT1RGbVVSR09tVVd6bzJ5ZFNQRGJp?=
 =?utf-8?B?ZjlWeEk4NTR2R243ZUZjZ1ZsL0RaVGt6bnBrRjhPMEt3YVkvOXp5TmNBV1Rj?=
 =?utf-8?B?WTdmQytUZWVCYmJQeXRmOWZ5TGJjWGpzTWJsNmM5TlRwTllFWFhsYklhYk80?=
 =?utf-8?B?WmRTQW1TYzdMRTlLWkE1ZUpFbENPQ3MwbzczaTdOcTNkSlZKWGFqaDAwM0Qv?=
 =?utf-8?B?dkozZTAraXlBQzh1OUFuNVZLSFlPblhvTkk2cWNOblVGUEh3eGtWenJyeE44?=
 =?utf-8?B?Q2RoR0xtWEdwQzArZ2RxSTFRL1BkcHRrNWZHcGhWcjdwcTNubUJnUjhxRkg1?=
 =?utf-8?B?QkxpUmNJaE10ZGt0bFRlOHg1c1JWTW5zNC9GUHNQVVlZOC9uSUd4M2JWRDdE?=
 =?utf-8?B?ejc5Y3NxL3ZhcG5yS3NGWmtTd3pvNytGeEl0bVY4dE9lSU05VGNqenVGOHFy?=
 =?utf-8?B?OXExUXArbXkrUlBLdnVGTDBIdlp3NTcvdkhtd3V3bGFyamZVMmNYS0tGcVZa?=
 =?utf-8?B?ZjNTNlJFTk91TU1BVjJ6bGtSUEg5aFpkbmtpSlVkMDQwWUVLSFljclBRNU9h?=
 =?utf-8?B?OXd1NDNFKzRvdVlqYnNIbUpzeEdwQzkyWHczYUkwUndLdXpMZW8yN2JwT2RG?=
 =?utf-8?B?c05mdTU1YjdjSG1QK3NZRXA0YU5KWllPL1dJek5WZGZXRU9UZ1dESi8xTUxX?=
 =?utf-8?B?WXBwUDB6dk5ZUnk5RVlVYXZVN2RXMWNRcFBDN2xQQ0M5U3NPSXVCQlMrNWxP?=
 =?utf-8?B?ZVY0WlRCaFp1aUVVM2JEczhBRzhFMGNsTExObmVuaDhjaHhXYzlFeXJGanFa?=
 =?utf-8?B?VnVkTy8rdjFPejdPS1NjUU90c1o3Nk9kTXBpRUh3WWcyUkhoTHhEQ00zakJI?=
 =?utf-8?Q?mGTT4H/PZiBY9SUM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4dbd20-8edc-4ded-c9cd-08dec6ccee77
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:47:41.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iVoQWlhqQjhoU7TjrkzZ8xUiEYijUaBRkWhlF0PSdFKoQuPKwU0fuiv/2TVB55SF16WhvjB+bSLU+8X2IUT+i8Bcf+IZlw8K+sBBawSni4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:54 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Migrate the legacy Stratix10 platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Removed fdt-2 under &images node and board-2 under &board_config node as
>    socfpga_stratix10_socdk_emmc.dts is not yet available
>
> Changes in v2:
> - Cleaned up git merge artifact
> - Cleaned up cdns,read-delay parameter for spi node
> - Cleaned up duplicated /delete-node/ kernel in binman node
>
>   arch/arm/dts/Makefile                         |   3 +-
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 158 +++++++
>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------------
>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 119 ++++-
>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ------
>   configs/socfpga_stratix10_defconfig           |   3 +-
>   6 files changed, 262 insertions(+), 594 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index cf9046f6056..cbb58180814 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -453,8 +453,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_vining_fpga.dtb		\
>   	socfpga_cyclone5_ac501soc.dtb			\
>   	socfpga_cyclone5_ac550soc.dtb			\
> -	socfpga_n5x_socdk.dtb				\
> -	socfpga_stratix10_socdk.dtb
> +	socfpga_n5x_socdk.dtb
>   
>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
>   	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> index 3e3a3780469..a3b4c0564f9 100644
> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
> @@ -3,6 +3,164 @@
>    * U-Boot additions
>    *
>    * Copyright (C) 2020 Intel Corporation <www.intel.com>
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>    */
>   
>   #include "socfpga_soc64_fit-u-boot.dtsi"
> +
> +/{
> +	aliases {
> +		spi0 = &qspi;
> +		i2c0 = &i2c1;
> +		freeze_br0 = &freeze_controller;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		bootph-all;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +	};
> +
> +	soc@0 {
> +		bootph-all;
> +
> +		freeze_controller: freeze_controller@f9000450 {
> +			compatible = "altr,freeze-bridge-controller";
> +			reg = <0xf9000450 0x00000010>;
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&clkmgr {
> +	bootph-all;
> +};
> +
> +&gmac0 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
> +	clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
> +	clock-names = "stmmaceth";
> +	/* PHY delays is configured via skew properties */
> +	phy-mode = "rgmii";
> +	max-frame-size = <3800>;
> +	status = "okay";
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +	};
> +};
> +
> +&gmac1 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
> +	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
> +	clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
> +};
> +
> +&gmac2 {
> +	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> +	reset-names = "stmmaceth", "stmmaceth-ocp";
> +	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
> +	clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
> +	clock-names = "stmmaceth";
> +	status = "disabled";
> +};
> +
> +&i2c0 {
> +	reset-names = "i2c";
> +};
> +
> +&i2c1 {
> +	reset-names = "i2c";
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	reset-names = "i2c";
> +};
> +
> +&i2c3 {
> +	reset-names = "i2c";
> +};
> +
> +&mmc {
> +	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
> +	fifo-mode;
> +};
> +
> +&porta {
> +	bank-name = "porta";
> +};
> +
> +&portb {
> +	bank-name = "portb";
> +};
> +
> +&qspi {
> +	bootph-all;
> +	compatible = "cdns,qspi-nor";
> +	flash0: flash@0 {
> +	};
> +};
> +
> +&flash0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "jedec,spi-nor";
> +};
> +
> +&rst {
> +	compatible = "altr,rst-mgr";
> +	altr,modrst-offset = <0x20>;
> +	bootph-all;
> +};
> +
> +&sdr {
> +	compatible = "altr,sdr-ctl-s10";
> +	reg = <0xf8000400 0x80>,
> +	      <0xf8010000 0x190>,
> +	      <0xf8011000 0x500>;
> +	resets = <&rst DDRSCH_RESET>;
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +	clock-frequency = <100000000>;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	compatible = "snps,dwc2";
> +};
> +
> +&usb1 {
> +	compatible = "snps,dwc2";
> +};
> +
> +&spi0 {
> +	compatible = "intel,stratix10-spi",
> +		     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> +};
> +
> +&spi1 {
> +	compatible = "intel,stratix10-spi",
> +		     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> +};
> +
> +&binman {
> +	/delete-node/ kernel;
> +};
> diff --git a/arch/arm/dts/socfpga_stratix10.dtsi b/arch/arm/dts/socfpga_stratix10.dtsi
> deleted file mode 100644
> index ea80d1bed15..00000000000
> --- a/arch/arm/dts/socfpga_stratix10.dtsi
> +++ /dev/null
> @@ -1,430 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2018 Intel Corporation
> - */
> -
> -/dts-v1/;
> -#include <dt-bindings/reset/altr,rst-mgr-s10.h>
> -#include <dt-bindings/gpio/gpio.h>
> -
> -/ {
> -	compatible = "altr,socfpga-stratix10";
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -
> -	cpus {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		cpu0: cpu@0 {
> -			compatible = "arm,cortex-a53", "arm,armv8";
> -			device_type = "cpu";
> -			enable-method = "psci";
> -			reg = <0x0>;
> -		};
> -
> -		cpu1: cpu@1 {
> -			compatible = "arm,cortex-a53", "arm,armv8";
> -			device_type = "cpu";
> -			enable-method = "psci";
> -			reg = <0x1>;
> -		};
> -
> -		cpu2: cpu@2 {
> -			compatible = "arm,cortex-a53", "arm,armv8";
> -			device_type = "cpu";
> -			enable-method = "psci";
> -			reg = <0x2>;
> -		};
> -
> -		cpu3: cpu@3 {
> -			compatible = "arm,cortex-a53", "arm,armv8";
> -			device_type = "cpu";
> -			enable-method = "psci";
> -			reg = <0x3>;
> -		};
> -	};
> -
> -	pmu {
> -		compatible = "arm,armv8-pmuv3";
> -		interrupts = <0 120 8>,
> -			     <0 121 8>,
> -			     <0 122 8>,
> -			     <0 123 8>;
> -		interrupt-affinity = <&cpu0>,
> -				     <&cpu1>,
> -				     <&cpu2>,
> -				     <&cpu3>;
> -		interrupt-parent = <&intc>;
> -	};
> -
> -	psci {
> -		compatible = "arm,psci-0.2";
> -		method = "smc";
> -	};
> -
> -	intc: intc@fffc1000 {
> -		compatible = "arm,gic-400", "arm,cortex-a15-gic";
> -		#interrupt-cells = <3>;
> -		interrupt-controller;
> -		reg = <0x0 0xfffc1000 0x0 0x1000>,
> -		      <0x0 0xfffc2000 0x0 0x2000>,
> -		      <0x0 0xfffc4000 0x0 0x2000>,
> -		      <0x0 0xfffc6000 0x0 0x2000>;
> -	};
> -
> -	soc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "simple-bus";
> -		device_type = "soc";
> -		interrupt-parent = <&intc>;
> -		ranges = <0 0 0 0xffffffff>;
> -		bootph-all;
> -
> -		clkmgr: clkmgr@ffd10000 {
> -			compatible = "altr,clk-mgr";
> -			reg = <0xffd10000 0x1000>;
> -		};
> -
> -		gmac0: ethernet@ff800000 {
> -			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> -			reg = <0xff800000 0x2000>;
> -			interrupts = <0 90 4>;
> -			interrupt-names = "macirq";
> -			mac-address = [00 00 00 00 00 00];
> -			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
> -			reset-names = "stmmaceth";
> -			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
> -			status = "disabled";
> -		};
> -
> -		gmac1: ethernet@ff802000 {
> -			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> -			reg = <0xff802000 0x2000>;
> -			interrupts = <0 91 4>;
> -			interrupt-names = "macirq";
> -			mac-address = [00 00 00 00 00 00];
> -			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
> -			reset-names = "stmmaceth";
> -			altr,sysmgr-syscon = <&sysmgr 0x48 0>;
> -			status = "disabled";
> -		};
> -
> -		gmac2: ethernet@ff804000 {
> -			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
> -			reg = <0xff804000 0x2000>;
> -			interrupts = <0 92 4>;
> -			interrupt-names = "macirq";
> -			mac-address = [00 00 00 00 00 00];
> -			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
> -			reset-names = "stmmaceth";
> -			altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
> -			status = "disabled";
> -		};
> -
> -		gpio0: gpio@ffc03200 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,dw-apb-gpio";
> -			reg = <0xffc03200 0x100>;
> -			resets = <&rst GPIO0_RESET>;
> -			status = "disabled";
> -
> -			porta: gpio-controller@0 {
> -				compatible = "snps,dw-apb-gpio-port";
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				snps,nr-gpios = <24>;
> -				reg = <0>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -				interrupts = <0 110 4>;
> -				bank-name = "porta";
> -			};
> -		};
> -
> -		gpio1: gpio@ffc03300 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,dw-apb-gpio";
> -			reg = <0xffc03300 0x100>;
> -			resets = <&rst GPIO1_RESET>;
> -			status = "disabled";
> -
> -			portb: gpio-controller@0 {
> -				compatible = "snps,dw-apb-gpio-port";
> -				gpio-controller;
> -				#gpio-cells = <2>;
> -				snps,nr-gpios = <24>;
> -				reg = <0>;
> -				interrupt-controller;
> -				#interrupt-cells = <2>;
> -				interrupts = <0 111 4>;
> -				bank-name = "portb";
> -			};
> -		};
> -
> -		i2c0: i2c@ffc02800 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,designware-i2c";
> -			reg = <0xffc02800 0x100>;
> -			interrupts = <0 103 4>;
> -			resets = <&rst I2C0_RESET>;
> -			reset-names = "i2c";
> -			status = "disabled";
> -		};
> -
> -		i2c1: i2c@ffc02900 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,designware-i2c";
> -			reg = <0xffc02900 0x100>;
> -			interrupts = <0 104 4>;
> -			resets = <&rst I2C1_RESET>;
> -			reset-names = "i2c";
> -			status = "disabled";
> -		};
> -
> -		i2c2: i2c@ffc02a00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,designware-i2c";
> -			reg = <0xffc02a00 0x100>;
> -			interrupts = <0 105 4>;
> -			resets = <&rst I2C2_RESET>;
> -			reset-names = "i2c";
> -			status = "disabled";
> -		};
> -
> -		i2c3: i2c@ffc02b00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,designware-i2c";
> -			reg = <0xffc02b00 0x100>;
> -			interrupts = <0 106 4>;
> -			resets = <&rst I2C3_RESET>;
> -			reset-names = "i2c";
> -			status = "disabled";
> -		};
> -
> -		i2c4: i2c@ffc02c00 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "snps,designware-i2c";
> -			reg = <0xffc02c00 0x100>;
> -			interrupts = <0 107 4>;
> -			resets = <&rst I2C4_RESET>;
> -			reset-names = "i2c";
> -			status = "disabled";
> -		};
> -
> -		mmc: dwmmc0@ff808000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "altr,socfpga-dw-mshc";
> -			reg = <0xff808000 0x1000>;
> -			interrupts = <0 96 4>;
> -			fifo-depth = <0x400>;
> -			resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
> -			bootph-all;
> -			status = "disabled";
> -		};
> -
> -		nand: nand@ffb90000 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			compatible = "altr,socfpga-denali-nand";
> -			reg = <0xffb90000 0x10000>,
> -			      <0xffb80000 0x1000>;
> -			reg-names = "nand_data", "denali_reg";
> -			interrupts = <0 97 4>;
> -			resets = <&rst NAND_RESET>, <&rst NAND_OCP_RESET>;
> -			status = "disabled";
> -		};
> -
> -		ocram: sram@ffe00000 {
> -			compatible = "mmio-sram";
> -			reg = <0xffe00000 0x100000>;
> -		};
> -
> -		qspi: spi@ff8d2000 {
> -			compatible = "cdns,qspi-nor";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0xff8d2000 0x100>,
> -			      <0xff900000 0x100000>;
> -			interrupts = <0 3 4>;
> -			cdns,fifo-depth = <128>;
> -			cdns,fifo-width = <4>;
> -			cdns,trigger-address = <0x00000000>;
> -			status = "disabled";
> -		};
> -
> -		rst: rstmgr@ffd11000 {
> -			#reset-cells = <1>;
> -			compatible = "altr,rst-mgr";
> -			reg = <0xffd11000 0x1000>;
> -			altr,modrst-offset = <0x20>;
> -			bootph-all;
> -		};
> -
> -		sdr: sdr@f8000400 {
> -			 compatible = "altr,sdr-ctl-s10";
> -			 reg = <0xf8000400 0x80>,
> -			       <0xf8010000 0x190>,
> -			       <0xf8011000 0x500>;
> -			 resets = <&rst DDRSCH_RESET>;
> -			 bootph-all;
> -		 };
> -
> -		spi0: spi@ffda4000 {
> -			compatible = "intel,stratix10-spi",
> -				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0xffda4000 0x1000>;
> -			interrupts = <0 99 4>;
> -			resets = <&rst SPIM0_RESET>;
> -			reg-io-width = <4>;
> -			num-chipselect = <4>;
> -			bus-num = <0>;
> -			status = "disabled";
> -		};
> -
> -		spi1: spi@ffda5000 {
> -			compatible = "intel,stratix10-spi",
> -				     "snps,dw-apb-ssi-4.00a", "snps,dw-apb-ssi";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0xffda5000 0x1000>;
> -			interrupts = <0 100 4>;
> -			resets = <&rst SPIM1_RESET>;
> -			reg-io-width = <4>;
> -			num-chipselect = <4>;
> -			bus-num = <0>;
> -			status = "disabled";
> -		};
> -
> -		sysmgr: sysmgr@ffd12000 {
> -			compatible = "altr,sys-mgr", "syscon";
> -			reg = <0xffd12000 0x1000>;
> -		};
> -
> -		/* Local timer */
> -		timer {
> -			compatible = "arm,armv8-timer";
> -			interrupts = <1 13 0xf08>,
> -				     <1 14 0xf08>,
> -				     <1 11 0xf08>,
> -				     <1 10 0xf08>;
> -		};
> -
> -		timer0: timer0@ffc03000 {
> -			compatible = "snps,dw-apb-timer";
> -			interrupts = <0 113 4>;
> -			reg = <0xffc03000 0x100>;
> -		};
> -
> -		timer1: timer1@ffc03100 {
> -			compatible = "snps,dw-apb-timer";
> -			interrupts = <0 114 4>;
> -			reg = <0xffc03100 0x100>;
> -		};
> -
> -		timer2: timer2@ffd00000 {
> -			compatible = "snps,dw-apb-timer";
> -			interrupts = <0 115 4>;
> -			reg = <0xffd00000 0x100>;
> -		};
> -
> -		timer3: timer3@ffd00100 {
> -			compatible = "snps,dw-apb-timer";
> -			interrupts = <0 116 4>;
> -			reg = <0xffd00100 0x100>;
> -		};
> -
> -		uart0: serial0@ffc02000 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0xffc02000 0x100>;
> -			interrupts = <0 108 4>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			resets = <&rst UART0_RESET>;
> -			clock-frequency = <100000000>;
> -			bootph-all;
> -			status = "disabled";
> -		};
> -
> -		uart1: serial1@ffc02100 {
> -			compatible = "snps,dw-apb-uart";
> -			reg = <0xffc02100 0x100>;
> -			interrupts = <0 109 4>;
> -			reg-shift = <2>;
> -			reg-io-width = <4>;
> -			resets = <&rst UART1_RESET>;
> -			status = "disabled";
> -		};
> -
> -		usbphy0: usbphy@0 {
> -			#phy-cells = <0>;
> -			compatible = "usb-nop-xceiv";
> -			status = "okay";
> -		};
> -
> -		usb0: usb@ffb00000 {
> -			compatible = "snps,dwc2";
> -			reg = <0xffb00000 0x40000>;
> -			interrupts = <0 93 4>;
> -			phys = <&usbphy0>;
> -			phy-names = "usb2-phy";
> -			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
> -			reset-names = "dwc2", "dwc2-ecc";
> -			status = "disabled";
> -		};
> -
> -		usb1: usb@ffb40000 {
> -			compatible = "snps,dwc2";
> -			reg = <0xffb40000 0x40000>;
> -			interrupts = <0 94 4>;
> -			phys = <&usbphy0>;
> -			phy-names = "usb2-phy";
> -			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
> -			reset-names = "dwc2", "dwc2-ecc";
> -			status = "disabled";
> -		};
> -
> -		watchdog0: watchdog@ffd00200 {
> -			compatible = "snps,dw-wdt";
> -			reg = <0xffd00200 0x100>;
> -			interrupts = <0 117 4>;
> -			resets = <&rst WATCHDOG0_RESET>;
> -			status = "disabled";
> -		};
> -
> -		watchdog1: watchdog@ffd00300 {
> -			compatible = "snps,dw-wdt";
> -			reg = <0xffd00300 0x100>;
> -			interrupts = <0 118 4>;
> -			resets = <&rst WATCHDOG1_RESET>;
> -			status = "disabled";
> -		};
> -
> -		watchdog2: watchdog@ffd00400 {
> -			compatible = "snps,dw-wdt";
> -			reg = <0xffd00400 0x100>;
> -			interrupts = <0 125 4>;
> -			resets = <&rst WATCHDOG2_RESET>;
> -			status = "disabled";
> -		};
> -
> -		watchdog3: watchdog@ffd00500 {
> -			compatible = "snps,dw-wdt";
> -			reg = <0xffd00500 0x100>;
> -			interrupts = <0 126 4>;
> -			resets = <&rst WATCHDOG3_RESET>;
> -			status = "disabled";
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> index ef0df769762..bd585d96bd2 100644
> --- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> @@ -3,47 +3,130 @@
>    * U-Boot additions
>    *
>    * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
>    */
>   
>   #include "socfpga_stratix10-u-boot.dtsi"
>   
>   /{
> -	aliases {
> -		spi0 = &qspi;
> -		freeze_br0 = &freeze_controller;
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		u-boot,spl-boot-order = &mmc,&flash0,&nand;
>   	};
>   
> -	soc {
> -		freeze_controller: freeze_controller@f9000450 {
> -			compatible = "altr,freeze-bridge-controller";
> -			reg = <0xf9000450 0x00000010>;
> -			status = "disabled";
> +	memory@0 {
> +		/* 4GB */
> +		reg = <0 0x00000000 0 0x80000000>,
> +		      <1 0x80000000 0 0x80000000>;
> +	};
> +};
> +
> +&qspi {
> +	status = "okay";
> +};
> +
> +&gmac0 {
> +	mdio0 {
> +		ethernet_phy0: ethernet-phy@0 {
> +			reg = <4>;
> +			txd0-skew-ps = <0>; /* -420ps */
> +			txd1-skew-ps = <0>; /* -420ps */
> +			txd2-skew-ps = <0>; /* -420ps */
> +			txd3-skew-ps = <0>; /* -420ps */
> +			rxd0-skew-ps = <420>; /* 0ps */
> +			rxd1-skew-ps = <420>; /* 0ps */
> +			rxd2-skew-ps = <420>; /* 0ps */
> +			rxd3-skew-ps = <420>; /* 0ps */
> +			txen-skew-ps = <0>; /* -420ps */
> +			txc-skew-ps = <900>; /* 0ps */
> +			rxdv-skew-ps = <420>; /* 0ps */
> +			rxc-skew-ps = <1680>; /* 780ps */
>   		};
>   	};
>   };
>   
> -&clkmgr {
> +&mmc {
> +	drvsel = <3>;
> +	smplsel = <2>;
>   	bootph-all;
>   };
>   
>   &qspi {
> -	status = "okay";
> -	bootph-all;
> +	/delete-property/ clocks;
>   };
>   
>   &flash0 {
> -	compatible = "jedec,spi-nor";
> -	spi-max-frequency = <100000000>;
> +	reg = <0>;
>   	spi-tx-bus-width = <4>;
>   	spi-rx-bus-width = <4>;
>   	bootph-all;
> +
> +	m25p,fast-read;
> +	cdns,page-size = <256>;
> +	cdns,block-size = <16>;
> +	cdns,tshsl-ns = <50>;
> +	cdns,tsd2d-ns = <50>;
> +	cdns,tchsh-ns = <4>;
> +	cdns,tslch-ns = <4>;
> +	/delete-property/ cdns,read-delay;
> +
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		qspi_boot: partition@0 {
> +			label = "u-boot";
> +			reg = <0x0 0x04200000>;
> +		};
> +
> +		root: partition@4200000 {
> +			label = "root";
> +			reg = <0x04200000 0x0BE00000>;
> +		};
> +	};
>   };
>   
> -&sysmgr {
> -	bootph-all;
> +&fdt_0_blob {
> +	filename = "dts/upstream/src/arm64/altera/socfpga_stratix10_socdk.dtb";
>   };
>   
> -&watchdog0 {
> -	status = "okay";
> -	bootph-all;
> +&images {
> +	fdt-1 {
> +		description = "socfpga_socdk_nand";
> +		type = "flat_dt";
> +		compression = "none";
> +		fdt_1_blob: blob-ext {
> +			filename = "dts/upstream/src/arm64/altera/socfpga_stratix10_socdk_nand.dtb";
> +		};
> +		hash {
> +			algo = "crc32";
> +		};
> +	};
> +};
> +
> +&board_config {
> +	board-1 {
> +		description = "board_1";
> +		firmware = "atf";
> +		loadables = "uboot";
> +		fdt = "fdt-1";
> +		signature {
> +			algo = "crc32";
> +			key-name-hint = "dev";
> +			sign-images = "atf", "uboot", "fdt-1";
> +		};
> +	};
> +
> +	board-4 {
> +		description = "board_4";
> +		firmware = "atf";
> +		loadables = "uboot";
> +		fdt = "fdt-0";
> +		signature {
> +			algo = "crc32";
> +			key-name-hint = "dev";
> +			sign-images = "atf", "uboot", "fdt-0";
> +		};
> +	};
>   };
> diff --git a/arch/arm/dts/socfpga_stratix10_socdk.dts b/arch/arm/dts/socfpga_stratix10_socdk.dts
> deleted file mode 100644
> index 864f4093ef8..00000000000
> --- a/arch/arm/dts/socfpga_stratix10_socdk.dts
> +++ /dev/null
> @@ -1,143 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2018 Intel Corporation
> - */
> -
> -#include "socfpga_stratix10.dtsi"
> -
> -/ {
> -	model = "SoCFPGA Stratix 10 SoCDK";
> -
> -	aliases {
> -		ethernet0 = &gmac0;
> -		i2c0 = &i2c1;
> -		serial0 = &uart0;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		hps0 {
> -			label = "hps_led0";
> -			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		hps1 {
> -			label = "hps_led1";
> -			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
> -		};
> -
> -		hps2 {
> -			label = "hps_led2";
> -			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
> -		};
> -	};
> -
> -	memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		device_type = "memory";
> -		/* 4GB */
> -		reg = <0 0x00000000 0 0x80000000>,
> -		      <1 0x80000000 0 0x80000000>;
> -		bootph-all;
> -	};
> -};
> -
> -&gpio1 {
> -	status = "okay";
> -};
> -
> -&gmac0 {
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&phy0>;
> -
> -	max-frame-size = <3800>;
> -
> -	mdio0 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		compatible = "snps,dwmac-mdio";
> -		phy0: ethernet-phy@0 {
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
> -			txc-skew-ps = <900>; /* 0ps */
> -			rxdv-skew-ps = <420>; /* 0ps */
> -			rxc-skew-ps = <1680>; /* 780ps */
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	status = "okay";
> -};
> -
> -&mmc {
> -	status = "okay";
> -	cap-sd-highspeed;
> -	cap-mmc-highspeed;
> -	broken-cd;
> -	bus-width = <4>;
> -	drvsel = <3>;
> -	smplsel = <2>;
> -};
> -
> -&qspi {
> -	flash0: flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "n25q00a";
> -		reg = <0>;
> -		spi-max-frequency = <50000000>;
> -
> -		m25p,fast-read;
> -		cdns,page-size = <256>;
> -		cdns,block-size = <16>;
> -		cdns,read-delay = <1>;
> -		cdns,tshsl-ns = <50>;
> -		cdns,tsd2d-ns = <50>;
> -		cdns,tchsh-ns = <4>;
> -		cdns,tslch-ns = <4>;
> -
> -		partitions {
> -			compatible = "fixed-partitions";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			qspi_boot: partition@0 {
> -				label = "Boot and fpga data";
> -				reg = <0x0 0x4000000>;
> -			};
> -
> -			qspi_rootfs: partition@4000000 {
> -				label = "Root Filesystem - JFFS2";
> -				reg = <0x4000000 0x4000000>;
> -			};
> -		};
> -	};
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&usb0 {
> -	status = "okay";
> -};
> -
> -&watchdog0 {
> -	status = "okay";
> -};
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
> index 7b04859dec7..8e80127b2d8 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -10,7 +10,8 @@ CONFIG_SF_DEFAULT_MODE=0x2003
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x200
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
> +CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
> +CONFIG_OF_UPSTREAM=y
>   CONFIG_DM_RESET=y
>   CONFIG_SPL_STACK=0xffe3f000
>   CONFIG_SPL_TEXT_BASE=0xFFE00000


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

