Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076CEC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388B584A51;
	Thu,  9 Jul 2026 12:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YYVBV09b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD0684AF2; Thu,  9 Jul 2026 12:24:11 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D94D984994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUTmlGxousL+ugHowANRMfjXBSupFBTQQHxP2B3vbQKq6RetOSv7lDAuHxr5UuhVj0STTbPpvrjuOpyxPmX8yUSaqTgJfgTlTJMbLKsfSwMRxrM9RXhXTmiuO7unkQyc4+Cc3Rddi9AHKKEgzKZ31qfEDWbO9MOs2yOZNR5SX/Sa2SSV/EBjLLOphQAwLluda077deXrQH2bUuxr9K+gJLNaPVXF97OGTEkeOKed22Kh08zYGsZGYhtsKzCf+UOn5fI3CsbA2lkM2ThTfqnzUN+7AGGUd1dO9dROzVdhxAaGAVyWexlfCbTJP3Rkn7xlFXS1Q+YRUaq7IWHEco1hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqgGywKpImibq7Ml9QI+Vatnuk+qUm6rHWu4/CQxJyI=;
 b=rbhYAQ+US9TYjw5bpiNc1CJMxFxYwllYK37ecFeK3+zrhPWh5AGY5qRco6T+NrPe/nhDnl5lxZhBxiwsrKjXsZJ7wXLkhpJ2crXIRpthu5MUR1O6uwVSBigQdITT51mJN1JzVBtGHb+K2qKju8cxi6dfXBgjBeQA33OnmGAFXikrBnaI6OnsFpsKMkXpvVI2zAbRwpQrZi74cUh46vbqfZMHpkUffyDeBILhTjY0dufWtYbs7v1pSN2+sP6ouaPu2P+sMSPRpO//ve37nraiyg5K6HRuLfCQLdWG+EvUfzjbOvff+Ew0Q/X3I2ImPvyhVVV2z8qQ2RdtbSnZRkLJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqgGywKpImibq7Ml9QI+Vatnuk+qUm6rHWu4/CQxJyI=;
 b=YYVBV09bkFYHGYQibrYJ7Jx+KiR3w8OFZtwtloRMYvBIUYe8TggdXAs/gz6gKrRtpsbXLukpJAEf7GrD7g5Xi/SG/5iiVxax3iBMkP8rDeDWEx7cuKJ1T0SLOZduiA/Er1sdRP8jxGkPRhTnvpCUG2HV3CY0dW9Fdg0wSbfPV/J7NTl9p2fcrvhcm1aybT06xsVBUibOPttuUHdEtLzX9Tr6XYF7sAMXYIcFynNmubimAo/YZl7tWp3qlE5wiXi6HPffU5vihE/Tw2y8sV7jy4Pt51nz19TfMBg7DdVJ9Td2cTzDZzLWyLycWhR2QdkO5/psNoDNg++dKPU3jJI8cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB5965.namprd03.prod.outlook.com (2603:10b6:5:39a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 10:24:06 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 10:24:06 +0000
Message-ID: <02515472-3898-495b-b663-dad44152d8e7@altera.com>
Date: Thu, 9 Jul 2026 18:23:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga: agilex: Add eMMC device tree source
 file
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260429022901.4326-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260429022901.4326-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:295::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM4PR03MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3265ae-d755-4cba-70a0-08dedda43463
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: z0Sdo7VjymaiJuFmEyEH8CuY+YwhQXfNcYUf/mQQjG1+ujUoy4jvH7z3yjeIfZv/zB8Z9OnF5Y06rAfnFHXn91zk27x8xVt891DFRb+RJ43QF2ZdpFypXNqQHDGeamT5UKrMM65iCsOAKdUGMYZYzDcq+aH13nUqtmlE9VZBD3CuLwzwDPRVfhFf1i6ocC/JOmDrOdDB8uehXRxKrbYglsr1l/ne6hthkdgcTEf2eEYU8fdPY6sYAeQz9IHmRTymtr3iUIe1AcUCPA0POTUWNy//xDzBgwR3R4DTOLHRE4R8ui5ITy+91WDtR9nwKWM/Geqe1gw1/k86JkJuITB6hQU2F8/9VNRRyKCJGSL+ICxDkrhQVyxmQwOA8W66nMLW3pyKpxePa0ffJ9eKusdxMVbPmOdDXHMddI9uJ9ZnGizMzb7XqP3e8oySEKzuL71qcc9SXuAox8Axt9ScVSd6C9YdyrISHAQyDG9A6CPKX7ZJdFsc52hJpuQ4hyfNH5inu8jo7srifS6AghwBDGLzbYIumrS47mfUso+NcymuoAF+XxMJ6AYwqADMjUOYAGWqjZWaHiRu6l7BUQfpOEDORT3VB7Yl+0GNjmS4cHis3+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REM1VkhEMm5xQlRON2dHUW0zR0ZESlVZVkMwVVEwaGhkZG1tVmxVSU1UbDND?=
 =?utf-8?B?TnFLL3E2bzhyYk4rWTlOWEhhVk94Ykt0elpCYlNBSFVuZDJSdHljYnZpOTZ5?=
 =?utf-8?B?Tmt0bXJwWTQ3a1VtUjB4T3FuQm9IaHI3VCtnVFNjU3J2Sk9GL0xQVDNiREYy?=
 =?utf-8?B?emVxZDlZQWU3NTk5ZVljWkxZa1ZzdjVsTmFRVFFzcVJpNVBXemlONmNJazV2?=
 =?utf-8?B?MHlYSEVEOXZMOHpaclI2MVJ6NTdKY0JzUmtCRllrWWV2NWR4eDd2OGFiTUta?=
 =?utf-8?B?akFYT2FhK1grd1djcUZ3U2F3WFZ1KzZxcGZvbTJRVVlHbno5OFA1ZFN0emJn?=
 =?utf-8?B?QWZzM3pXUFR6ckJXQThOY3g0aWhUQThiUVIzaE5kSDdwWWgzQUZaOGJLMnVG?=
 =?utf-8?B?VTlSWVY3cHJlc2NPQjVYSGdwSkpwZEFQclM4WTE4cDlpWFBMeERmU1owelNk?=
 =?utf-8?B?NlFiUFFqR2xROC9laHhMT1VPMEkwQnJGZUtKQ0FXclpqb2MrbjJLcDZncGh4?=
 =?utf-8?B?c1djSTdhc0ZScE9FRlpUdFhzNjhXTTAxeGpWeERNNWh4WE9UYmp4aWtBRi9a?=
 =?utf-8?B?Z1JMb0E2VFVlZkpTYjk2NVA2TDRadzF6WWJ3UlRnTHZBcks4T0l4aE9vU0xk?=
 =?utf-8?B?UDY1ZEpzM0hYUWJyYjhTMytqOWw3aHd6UXk2eVdzOFowbHdteEZ4alpRRDNn?=
 =?utf-8?B?K2N1YTArRS90SmtBdnpiaW1wc3M1MmUvek5Kak9ja3FyU3R0RHdMaEdjellB?=
 =?utf-8?B?ZThSNVFiS3c4c09UWnZoMVpKRFZLVWdWL3Nja0pkVml6NVhZUmlrWTF0WFFU?=
 =?utf-8?B?U25lenBVQTNmbGtFSnhqcXluT0lkZ1k4V0ZZaUxEdWx5VHJvQXZia0xqZnp4?=
 =?utf-8?B?RHppZDdCZG0xSEpmcTM2ZzhRc3YzOWpyenY5WUdYekN6M3l1ZGxqdGZFUXp5?=
 =?utf-8?B?bUlhTm1oVXpwZjhqZkxYUExmelJBWFQ3N2NBa3E2L2hYWDlQYjZVUVhEQXcy?=
 =?utf-8?B?SGpMOFZ2MTFsK3FEUW9OWEtzc2FBTTR4ZUh5UlRrd3FJOURyV0NCWGpxcnVq?=
 =?utf-8?B?a2RBRldUcm45bllYQjBOd3c3dSt6Qnl4bEE3aVU0MHJUYjkzVDFBVVphVWxx?=
 =?utf-8?B?NEttU3ZRZGFSNUR4U3M0NUNudWJZV1lLYnVhOElxRFNZYm9GMDdLZGdDYnp3?=
 =?utf-8?B?VEZ6NGkzYk9nOFNXczNBZnVoWkRMay9xZFRPZkVQSFVobnY1NC90eHhsM3Vr?=
 =?utf-8?B?aktZOUlydlFwOFFQWWtLSGM0K2pPWFpsUU1Uck8vQXUrbnM5WlJYZDlwc3F6?=
 =?utf-8?B?dGt3R3AreVY4V2xKQTUxUmZxTEZVYkZiYXF0c1RSS3ozeStnb1dhbUs5WlN3?=
 =?utf-8?B?WmNGWVBOWFZxZ2h0Ym9Velg5bWhVK01yUmh0UWp1OVVZcXJFOEpkRkhXRHpy?=
 =?utf-8?B?NVA2Z2xTby95TU1GMHFSWU0zZHROaGo4cDgrQWV1MHA5ZUd3dmxOSHJ6V2ZP?=
 =?utf-8?B?R0hMREhxb1ZadXNTVDQxL3ppOG5kOGhpZmJoSklsMzZ1ZTdyaFRjMFVjWDNk?=
 =?utf-8?B?eFNSeVFNbWZaOGpDc0RKMDFSbVAxcTZZYUV4UHI2NXNLR09TNmFxeVlrQmwx?=
 =?utf-8?B?dWJFOEtjM2dicU1LTCtUaUxFK1BuR3YwQXBqcnczTXIyTjg1Yld5SFdseVVo?=
 =?utf-8?B?MW9URndRdG9nd1NvL3hkaXA4MTZNeldmV2piK1JsUXhRb3dRZXFRSTd6dDJy?=
 =?utf-8?B?NUcvU29xazJXM0s4VmtTcjRoZWpvRTRIUmgwejhUYkp1dW50RFJCQzdVZzJx?=
 =?utf-8?B?MnNwOVdFZE96d0Y2TWZUaW5JbytBTVhBQ1g5T24vL01iaWhnaGN5RFZEU1Jq?=
 =?utf-8?B?cGw1bHM5aCtnTjJ4WG9GMzdpYmFpdlJ1TkxSQTY3RVB5eHVmVStnTExGZnpz?=
 =?utf-8?B?NU5XbVVEU2NQUUNkTUZPSUpMK1FVQjhYYkhlOVFLNjZUMXdnTHZGQXg3SFpW?=
 =?utf-8?B?VEhKdjBVdnU4WWd5a21yWnFpMzFuaHpQNldybmFXa2xhQThWdW0rb1p6TERV?=
 =?utf-8?B?Ym9sMk16UzdlYU0xeDk3RmR5NXl2a0FKM3dkN1dza3cvcWx0QkJYNC9GdFhI?=
 =?utf-8?B?NTdGZ1lUZ2M1V1VSWWkzZUhENVp3RDlwOEduY2tuampUWWZ2WkdrSnFrNGZj?=
 =?utf-8?B?bFFhamdRMEJtZUc2UVYraEpsaGd0ZVhRV3ZSMStyRW9mcHEvZTVLOUU5VVhN?=
 =?utf-8?B?TDB1MHhxQzk4QkpYakNGQ1FIclo3UEdDWU9XOXhiL0svaDdsV05jQVZuM2Nx?=
 =?utf-8?B?VTdoT1VqRGVYLzdFSWRhd0NqMnE2QWFNMVhqdEZ6VWx2MW1xL1RSSjh0dW00?=
 =?utf-8?Q?+/6z2BKGZO6qQtj8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3265ae-d755-4cba-70a0-08dedda43463
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:24:06.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3KQVl85+CeTDAbtdBFugJMJn5NinyDBZMoh8ng7wJJFG52z5wJbhR1rowy5gIV8juLXCD2aFKEBo2tj8VBTlLXXmKLK7BLeUsZSO+PDghU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5965
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

On 29/4/2026 10:29 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> The Agilex devkit supports a separate NAND/eMMC daughter card.
>
> The NAND/eMMC daughter card replaces the SDMMC slot that is on the default
> daughter card and thus requires a separate board dts file.
>
> New eMMC dts which is based on the existing NAND dts is needed to comply
> with spec in which eMMC board ID is designated as 2.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 24 +++++++++++++++++++
>   .../dts/socfpga_agilex_socdk_emmc-u-boot.dtsi | 16 +++++++++++++
>   configs/socfpga_agilex_defconfig              |  2 +-
>   3 files changed, 41 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
>
> diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> index f2150b7eb7b..d3d4e550d0a 100644
> --- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
> @@ -199,6 +199,18 @@
>   			algo = "crc32";
>   		};
>   	};
> +
> +	fdt-2 {
> +		description = "socfpga_socdk_emmc";
> +		type = "flat_dt";
> +		compression = "none";
> +		fdt_2_blob: blob-ext {
> +			filename = "dts/upstream/src/arm64/intel/socfpga_agilex_socdk_emmc.dtb";
> +		};
> +		hash {
> +			algo = "crc32";
> +		};
> +	};
>   };
>   
>   &board_config {
> @@ -213,6 +225,18 @@
>   			sign-images = "atf", "uboot", "fdt-1";
>   		};
>   	};
> +
> +	board-2 {
> +		description = "board_2";
> +		firmware = "atf";
> +		loadables = "uboot";
> +		fdt = "fdt-2";
> +		signature {
> +			algo = "crc32";
> +			key-name-hint = "dev";
> +			sign-images = "atf", "uboot", "fdt-2";
> +		};
> +	};
>   };
>   
>   &binman {
> diff --git a/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
> new file mode 100644
> index 00000000000..fd301ff28a9
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions
> + *
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#include "socfpga_agilex_socdk-u-boot.dtsi"
> +
> +&gmac0 {
> +	status = "disabled";
> +};
> +
> +&gmac2 {
> +	status = "okay";
> +};
> diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
> index b2c7b30d546..1690e1ad8ed 100644
> --- a/configs/socfpga_agilex_defconfig
> +++ b/configs/socfpga_agilex_defconfig
> @@ -58,7 +58,7 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_SMC=y
>   CONFIG_CMD_UBI=y
>   CONFIG_OF_UPSTREAM=y
> -CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand"
> +CONFIG_OF_LIST="intel/socfpga_agilex_socdk intel/socfpga_agilex_socdk_nand intel/socfpga_agilex_socdk_emmc"
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_UBI=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

