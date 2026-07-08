Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4DFC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11988838D7;
	Wed,  8 Jul 2026 06:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LztTLbvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B4084A29; Wed,  8 Jul 2026 06:39:11 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D831E80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8+5Nbn1sMz8cUJNsdX1DFPQSbwAUxoUjyk/yh0OmOJcLhfPRmCeuhokVrExlA9IjiPf8gFNfvwZH2mexiJGCTUyKJcmzJPF4yJIdjU0yAlE9Sol6XjqOqaNhT5ILUkWKkcJRyGpJnwlEjtvcoru9TpTQWQ/IXkw40cWQ+t5ldTyH2fYqx6expF+zQEoUsO3/mTLkFtorXFFOtzaVhQeNsMFYgEBan98nrJNVFHTrN+tm18aOlZUDf0VdGKUH8uZp4QNka6I3A3lVHH8z3FZtUCdKvA9YQHjdd3Gp6hTSLZZM+OXzg4AO3iihX+yuiCpaMHVF4KhnBRj227qGzdg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeWYZALWLlmzVpmcpnfaIkpwOTpGAvu59cDPZICH0EQ=;
 b=WzrDDR715eBEUvp3pDQZdPaC5tAq0hcFprrmMbZOWzpcMmD2QE2AP0AEkdW1wDAAl+Bug6q4tyXJkgS61DRXRovmiR4HRo0A13R1RRhAUdm3qvnOU2lcNk9rDhhoKoB7hMiQDH5u2aM0iW2+LdQmm5PkYzziL8LCoq1SyYpfr9JUBIkewuLOeEn0DNdiHGgZJOcUaGLDHv4G6JIqwTAXIqpzLAmf/SbWJaaA0mBh8ScAmijxiLe5IZTzrPfp+7zHOfPiGKUOKuKJ2OCgK/YwIJVpcM/d/RExut9DezhrX1pAfygzMOT5huMvBlu8C9yVIutNqB95JhwVb9vOFp2ouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeWYZALWLlmzVpmcpnfaIkpwOTpGAvu59cDPZICH0EQ=;
 b=LztTLbvWG/ALjw6aBI3wgk8OohQFLOYWMhi+92ECD0KvgSQWrsAXzzuEwEoE7c+mzYxQO7uoKR0fA4atkzPAT3+ka+wYzu6gpinaOxbVIhqggY/J3COcKD8lY+MaXNSLfZTLov4sVfosjVusi2Ti28wvD3lTrQsl4mhoOIeYUCqT3kPMtjlhQ06I5irrQVkZvfHl96Zl2b24KFAyTxNEMrtjWMdEuHN2dMb/7xHlul/8a/I6sYAQPoe6nS8mtmmksTt9U0BJosAIogllXlO1p4J2FV5GLby9qQbB53xX39DloGt422PvaLPble0G0hcRfrE2NhJkrEpzIklyC7JXJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:39:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:39:05 +0000
Message-ID: <36b9a83b-d96e-43c4-a463-efb27dce0d08@altera.com>
Date: Wed, 8 Jul 2026 12:38:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] arch: arm: dts: n5x: switch to using upstream
 Linux DT config
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-7-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-7-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6c4cab-1ecb-4a89-aed0-08dedcaad73f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: i/rlZXPyN1YEjnY7CP18NeOjvbV/cEsp0rM+44gjhvJBrN+BUdXWMXOTkG+UasPkWMjDpwyuRA9gjxzAjxONhLwbAm6EhPTOa31N2KsVYi4j6rvzR02Y4DBE7LZlNoV7F7q3lEre9Z13JqBgnwi6U6It5Q+O/Wl5hVgI0Mk9iM8ejiuC/MXlIE/XGyNp/LuZsDkODuGOPvmoc1evBHlz+hnWd/F036RWssfHrL3Oro3SL6+uuRKDctr7FPEgK7igejH+qFHPIAlzz+4srJ3tU3b0x3RHr3Ga1bnlKo+7ggfdJLlUwdoYRuLmAeIY39gCqgy/rIA8EkUXadS91ooHvgK+JEFcmDq9tJiOcB+yL1wHjxCF3cftUNnpAHzdGs5tjba61tvQid7qDTKCmyQ1QhfP8b5YR4Db1yTTIeJ0xzzMVf38EIrId/dHv4bcAu0CEiPUPuSG6zfn4aU30SKcRzypd9JvLdJzxu+tOFjMqpW/syW9w8wVme7AdJF6SYK5SrSxaXcmtTDn9ZJGcpobiXrRdzxhyifIdcriuzzwPrPP2WTPwAYCkerxlCjJm8fNyrOc4gMj84eH1/XXPGGhXNkbqxBL6enteiLDgPrewdQBudxTnYlA8WBAPJ8oR/6JT3evHzdw9gH0sZa0c5w9tmDRczOR0SoRLnhX5c7tBWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWp2S3loV2NHSUZSd0hocFVOV01TRERZb2hWK0Fjem5qVmpzcnNReG9RaWN5?=
 =?utf-8?B?Q0ZMN0pSb1gweFRZN09VeHVEV0hiMk90dS9LMUhDRFRZcTVwMjVnZXo4QTJu?=
 =?utf-8?B?T011L3lUSHRKNVE5UE80NEk0RnFObW1aK2ZKMW5QT2NMOGpzT3JhR25YRE56?=
 =?utf-8?B?RWJyUEZJSStLazZmUVRoa1Rac0c1MW5HTWxlS3dRVGlXdWp3RHV6RjRweFhl?=
 =?utf-8?B?YVJRVEJmNTZVYVgwYUlMZjFKT0g0dTRkZ2xibXR6aklQVGw5d2t1eEhIbS84?=
 =?utf-8?B?MitRTWhZanh4YW5udXNwelUzcy95QklMdnBvUnBBYzFnQ2VRNTFFRVpYZEhw?=
 =?utf-8?B?U3pQVnNzYTVPT3VqeXk5WEttY1UwSXNML0ZJVDdVU0RpRmZMWFVQRmdveTJP?=
 =?utf-8?B?YmVDRWhWWmVFYkFmd0JYOVNlTUF2WFZFS0tJNUIvKy9NdjlWaXpTY3R4TFZt?=
 =?utf-8?B?WFBBOUNaSENqMW1TUDRSQXd5SFgzM20wc0Q1eWQ5UnM4UmN5M0R2VmF2NWxv?=
 =?utf-8?B?cld4TFU3amFJbEJFWnhaQk4zeVV1UzBEdzZnek11Q1JudWZDQTMyck05OEF1?=
 =?utf-8?B?N2t5bVJiNnNqUkpHeDdYemNqeXRJODU1OUk3d2hKWHlOZXJ0NFJjL1lOZHRX?=
 =?utf-8?B?NUlmWEkrVWZQSG5ueWpKUmR6eGFYTUxkSUNXNzFIVVVOdEJsQmRnQ1pONjBv?=
 =?utf-8?B?a1QrbTM2NVluUDZsL09KcDMybFFBUDV6dS8wRGdSTUZTUjB6bHlvc3BsQkxk?=
 =?utf-8?B?RWZOWjB5YVAwSWR0U3Q4SzBHM1FZNk93VUdRUUpWSmVKNURFZDVUWWgzNGhn?=
 =?utf-8?B?WHlEa0F5NDEzTEhOWGxiYVRvMUx1TWM3NDlWMzl2RDJMWXg2ZXJVUzhuc1E0?=
 =?utf-8?B?bGVCNlQrSGhtb2ZpZmt6cnJTSlhDTGlERHlDTWs2Zk1ON0NGL29henoxUWhS?=
 =?utf-8?B?TUdwTzY5elphakJ6VUJjcWNlK0RCa0tyMHMxR0xBU3JVL3JKdHFIS21lb2FZ?=
 =?utf-8?B?aE5PTTFkcS82dWl6emppc0hVOEtaOHRJTnQrMTkrT3ZQM0I2Q1ZDekJKZGJ6?=
 =?utf-8?B?QktXUG0zUHZORmgxWVNyc3VzT25XYVdyV1lWN21UUG4xeG9VSndCRGxGMkNH?=
 =?utf-8?B?dE5seUdBNFg4WHRBcUkwbEhWdzFrckl6cHlIRXVncGt6Qk93SXFGU3RxV25k?=
 =?utf-8?B?Z3BFNkdYZG5FcHEyTEJvZXZERHBwU0RKSlFMMmdkZHlXejIwNGg2VW9KdG9q?=
 =?utf-8?B?VVZOYzFkb0Y4ak9wU01oWFpIMkNNVFplSjdyN1J5bjQ5dHVRcUhqME9RNVNS?=
 =?utf-8?B?cTNrZFJlUnA2SVR0STRNOFJIT1REbkgyN1luRGlqZFJxZHpScjFpdGtKbzhl?=
 =?utf-8?B?QUJySGtJOHg0UCtsczVmNnVnN3JqYzd5OTZsK3pNQUdLc0FNN2d5YXJrVGtQ?=
 =?utf-8?B?Mzllb3NZYm84QWw4R1l2SUpTR0t6MGRERW9vdGxtZzVFck1lNmdOM0JPbWhm?=
 =?utf-8?B?TVFxNEFYZk11V0YyYnl1Vm9KV1NNYktSYUwyeGZKeEZ5U1VtN0R0QlE5dGVl?=
 =?utf-8?B?QVZoMkx6OXdaV2M1Mi8xVGJ6QXBCOE5JK3B0MkpZUVpxMmt2L0VZVk9kWXdQ?=
 =?utf-8?B?Z2NSRkgwQVJQVzNmTDRFWWVkSkthclZ2RlltMSswM3RYM1lGU2M4TUZaRnRS?=
 =?utf-8?B?blRrWk9mL3l4Nkt5Y1JMUG5wbjZQcGZvY25GZ1ZTMXZpYldHbnNTUHMxZUor?=
 =?utf-8?B?MUxVQ3Q0WGdqTFdBb3lhYW1Idk45L2FZbGZsenFuSzlNaDNIOGhROEtNSDZu?=
 =?utf-8?B?ZWNuYjVMVFpzbXptUXBOTVpSSStaVGFVWDg2VEFiQVFqQ0ZWS1BXTXVmMnRY?=
 =?utf-8?B?WnBxTUZ5bEtyeDJlN3VwWG4zL1J6VHVYaXJvRzJBM0lQQmtxa2ZzVjFwY212?=
 =?utf-8?B?SzZOaFoyVmtLNmtYVzFXU2xIcmFFQ2RxYXY3WXNIdHNucFVFTFpGZ2c2aDFm?=
 =?utf-8?B?Mk04N0tTNGFpTzZ5eWo2MzlFa1Q2VWpvL3JuS05ISkNRbHhUaEpCSFBrbTBj?=
 =?utf-8?B?NFdFNHRUaVFlbVg1UXFZNnRmL3BXUFJzZHNZMkdpbGRnNG1teXcvU3dTUDQ1?=
 =?utf-8?B?dTFjcTJERjVJb1ZtVEd6eDNXU01sQXBtT0UzU0ZOTVNoVytlUERybk9HV21r?=
 =?utf-8?B?ZFRjUDBlNHFnaE83RHZIV3JmdjdlaDN5MlVIMCtVbm9pWXgvWjQwdXM3bVZp?=
 =?utf-8?B?TDJMMlU1blduMVZQcTkySVZtelBJSTZQdEV0R2w4QWhCSkQ1NGRlbDN3MjQ5?=
 =?utf-8?B?VDU3am5rK3hneGRYK0JSbmZEbVlBM1pxaHJiZjh0cEdyejVSVFd4ajJUUk9M?=
 =?utf-8?Q?9M/pWYv4yBev0PuQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c4cab-1ecb-4a89-aed0-08dedcaad73f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:39:05.0949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9JEeO7suzTlqFZ3l5xNHgEVJEnGlRiZoRNl9vN2r97UA2vpgPc6rPC6XvqgnsBJwvhVxmM/wBCuVD+LeTzgYgE/SjtUYg0EUFzQAg25C7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Migrate the legacy n5x platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>
> Changes in v4:
> - Remove the now-unused in-tree vendor arch/arm/dts/socfpga_n5x_socdk.dts,
>    superseded by dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts once
>    OF_UPSTREAM is enabled (matches the Stratix10 DT-switch patch)
>
> Changes in v3:
> - Fix CONFIG_OF_UPSTREAM position in defconfig: correctly placed after
>    CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering (was
>    placed at end of file in v2)
>
>   arch/arm/dts/Makefile                      |   3 +-
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  17 ++-
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  13 +--
>   arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
>   configs/socfpga_n5x_defconfig              |   3 +-
>   5 files changed, 24 insertions(+), 134 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index cbb58180814..c753564f134 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -452,8 +452,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_sr1500.dtb			\
>   	socfpga_cyclone5_vining_fpga.dtb		\
>   	socfpga_cyclone5_ac501soc.dtb			\
> -	socfpga_cyclone5_ac550soc.dtb			\
> -	socfpga_n5x_socdk.dtb
> +	socfpga_cyclone5_ac550soc.dtb
>   
>   dtb-$(CONFIG_TARGET_DRA7XX_EVM) += dra72-evm.dtb dra7-evm.dtb	\
>   	dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb
> diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> index dbfd2abfd59..16b92ef48f4 100644
> --- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
> @@ -10,7 +10,13 @@
>   #include <dt-bindings/clock/n5x-clock.h>
>   
>   /{
> -	memory {
> +	aliases {
> +		spi0 = &qspi;
> +		i2c0 = &i2c1;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		bootph-all;
> @@ -121,6 +127,14 @@
>   
>   &qspi {
>   	bootph-all;
> +	compatible = "cdns,qspi-nor";
> +	flash0: flash@0 {
> +	};
> +};
> +
> +&flash0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
>   };
>   
>   &rst {
> @@ -200,7 +214,6 @@
>   
>   &usb0 {
>   	clocks = <&clkmgr N5X_USB_CLK>;
> -	disable-over-current;
>   	bootph-all;
>   };
>   
> diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> index 1f7e31bcae3..1bed87c1231 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
> @@ -8,12 +8,11 @@
>   #include "socfpga_n5x-u-boot.dtsi"
>   
>   /{
> -	aliases {
> -		spi0 = &qspi;
> -		i2c0 = &i2c1;
> +	chosen {
> +		u-boot,spl-boot-order = &mmc;
>   	};
>   
> -	memory {
> +	memory@0 {
>   		/*
>   		 * Memory type: DDR4 (non-interleaving mode)
>   		 * 16GB
> @@ -38,10 +37,10 @@
>   };
>   
>   &flash0 {
> -	compatible = "jedec,spi-nor";
> -	spi-tx-bus-width = <4>;
> -	spi-rx-bus-width = <4>;
>   	bootph-all;
> +	cdns,page-size = <256>;
> +	cdns,block-size = <16>;
> +	/delete-property/ cdns,read-delay;
>   };
>   
>   &gmac0 {
> diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
> deleted file mode 100644
> index 915b8f6380e..00000000000
> --- a/arch/arm/dts/socfpga_n5x_socdk.dts
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -// SPDX-License-Identifier:     GPL-2.0
> -/*
> - * Copyright (C) 2020-2021, Intel Corporation
> - */
> -#include "socfpga_agilex.dtsi"
> -
> -/ {
> -	model = "eASIC N5X SoCDK";
> -
> -	aliases {
> -		serial0 = &uart0;
> -		ethernet0 = &gmac0;
> -		ethernet1 = &gmac1;
> -		ethernet2 = &gmac2;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	memory {
> -		device_type = "memory";
> -		/* We expect the bootloader to fill in the reg */
> -		reg = <0 0 0 0>;
> -	};
> -
> -	soc {
> -		clocks {
> -			osc1 {
> -				clock-frequency = <25000000>;
> -			};
> -		};
> -	};
> -};
> -
> -&gmac0 {
> -	status = "okay";
> -	phy-mode = "rgmii";
> -	phy-handle = <&phy0>;
> -	max-frame-size = <9000>;
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
> -&gpio1 {
> -	status = "okay";
> -};
> -
> -&mmc {
> -	status = "okay";
> -	cap-sd-highspeed;
> -	broken-cd;
> -	bus-width = <4>;
> -};
> -
> -&qspi {
> -	status = "okay";
> -	flash0: flash@0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "mt25qu02g";
> -		reg = <0>;
> -		spi-max-frequency = <100000000>;
> -
> -		m25p,fast-read;
> -		cdns,page-size = <256>;
> -		cdns,block-size = <16>;
> -		cdns,read-delay = <3>;
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
> -				reg = <0x0 0x034B0000>;
> -			};
> -
> -			qspi_rootfs: partition@34B0000 {
> -				label = "Root Filesystem - JFFS2";
> -				reg = <0x034B0000 0x0EB50000>;
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
> -&usb1 {
> -	status = "okay";
> -};
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index fc988ed3da2..d706366337f 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -10,7 +10,7 @@ CONFIG_SF_DEFAULT_MODE=0x2003
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x200
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_n5x_socdk"
> +CONFIG_DEFAULT_DEVICE_TREE="intel/socfpga_n5x_socdk"
>   CONFIG_DM_RESET=y
>   CONFIG_SPL_STACK=0xffe3f000
>   CONFIG_SPL_TEXT_BASE=0xFFE00000
> @@ -63,6 +63,7 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_FAT=y
>   CONFIG_CMD_FS_GENERIC=y
> +CONFIG_OF_UPSTREAM=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

