Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC420CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD5880087;
	Wed, 10 Jun 2026 10:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OgZKcEGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F22E84664; Wed, 10 Jun 2026 10:48:24 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6680980086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkhcsmmXk/EwBoBk8xfhTR6YVJonUTUS1bfsXbBbgBoXjV2u99pLcqNvgM4rux77hys11CUuo5kXt/xA2PyH6dk8ltFXZrC/1vF90XTxhhrwR0qqeVqs5P1hix2TVFTzLZPLphJ6d48HKnSWKea14PuizG/pG3L8FnXzUCzCO0VjbQ45vJJCHtpxM7spBO790CHRPJg8oLWdH1OjWmP1nE5d1hLZOgKyxql+AXKoAxKsYNIa26eRWRqa9A39esrdSNPfEPzuttfqKg6cwlGXC8QYPCFMupWGpuzQdm1CSs0coCWsAf9ooyQ4kVkt209ZO3W+0dkLfaVgDRgUODUmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNGlzhcZH+aoTNuuTR20sGXtcxUq+XUeWVZxqWaRA/A=;
 b=qadxVeehnlX6vqZbtaCK7T5YVM3N/rBt/u5HpMyVGkhZd9MNV1i/kAC0H1teAiXbi3jzdAfgAfOMAa9s2RDV1oK5VloqNR0jMm2vuCPGzn3meJfA7Ma8IEQsmmkJzOdosk4LKxQh6Tgk/cj2P9R+dzI+RthwDNOE4grCknmQOa24zlMe7tn5d1eTLNGX6gmaOyG4BrSuGy/UvjOnRz3oBi5RjP9UG6Z2xsNvoIyVf3QBlry0sTCNV/HA0b+ncdpU0AbK0OPruc7tWIunccAWmmzg6TulnEGcoy4/Y8rrPLqJbXpIqdYzArB+QsV0Wal3cdfpZzcCILhKVdp8xlD64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNGlzhcZH+aoTNuuTR20sGXtcxUq+XUeWVZxqWaRA/A=;
 b=OgZKcEGNArhT0qcN2QKHg2oQhceaMCzgRaBE8fxtDUMQoQxIe9B4vKHkcTeUllF++wyILFABz74XHmcJ3cNPFSTWoUFhOI4ssLm6cB5bUKOPHeLYI+QwVGEGljT42GSC4A/Xy15+uY/Jufbjruhexkk16XFVYNQZ8zb5Rbed18MFE0AIyJuoY/CSUW2rYYoumofzFKV7B1Jzg44i21DYI4lf5uMBqFMrUytdZjv/GjnQGCR2ACyMC+R9fv3EuTz0XU+6ZdUpOvvz9eDasdK1sVwIqJWU0PmhUmQSG/eRLWoykirzk7QW3GTcMaLQ2/DnrhSxpIEwXhBfc7aZ/8ZqUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:48:19 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:48:19 +0000
Message-ID: <9f5abc54-965a-467f-88fe-f3a722f470a4@altera.com>
Date: Wed, 10 Jun 2026 16:48:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] configs: stratix10: Combine defconfig for all boot
 flashes
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6889314e-94d8-4ed4-b54d-08dec6cd056a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: kSU0B81bbo6sSnJOzUPQ+rvNjTrfHvPSfV2FVHFPl3rWAutWUWSfkmOdBDQ65ZixggyUuJikmajbZ6QzQYpzZUGuUjWDzt2OfehJa3C5xO7MkZpdjri85b95o6MX4s7wgMUgTsiTYPjRmw8wF3Ut45twGSjaOXx0GHXA8tk903Z2iaEe+E/OUCLL0WeeqcH7P7UnSYDA/tNQpnQD6i891biQNS1spDXg0wVswonJ6cE+Xrdbz7yPF8GYL/SsQ7Y/+TDAg8F2k1o+UqhZmtbkM1xeDWnXUGtCnkDZs5bIGbByy08DxVQZqHJJk0x0C0Dq9/JGN+hJM3L1c7AvSD0D897/4J4BNbGL2jJw9FrS8FDuJyFxbnQag78AdZBx+tunLutWHDlPBlTb4GrBOUWGH3FLK3fcsIgry9sW0uezWLZ8ju+qwQWxILtxeJhpDb8lI1Ie2CdOZFgvP3HNI4ydAF4LLlKjLqV7DkoCoFuB7/IsPTIw+NNr4MK1kEIKr2auamfgUYv8MPmbVtCwOO6eQZ+jD/dJbWjCye1ZRYq0qjCLqB/6Qu+O9HA808Lk7+pKJCaUVVWQ7w3mFldGd8+z+F1HjyrRmf2oCyuD4idOD7gFFIgApjoYi24kXK+jE33PKOsnDt3ak95W7zcRUN4y3dWLjv4O16lUAWgzjpdwaeT3qFYd3rVknh7LYfLNKBSt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFhmaTlPeWRpdzluVS9RRXRGWkJ0S2dkRllaMHY2L1V3QytPY01nZVpFOTlQ?=
 =?utf-8?B?bnVBNldMVnNHVXZMOHpsQVFEeVVmL25sdmVGV2VLeXJCQlJjTW5FRFY2UEF0?=
 =?utf-8?B?R25RNDR6emdnajFDSmFqa2E2QUE5Z05YcW1HQXpKZlYrYjg3YW02VEhsQnlj?=
 =?utf-8?B?ZDNOTjRlU1BEUU5VcTkvSmJSL0RQTlZFY0pMWURtVlh4cTNjRDNQUUIyVjhP?=
 =?utf-8?B?SjF1U0dac00yZHIzeXEzVk0xTFJZN24vMmNCSGd3WmZUTWhkSm5XRWFpK3py?=
 =?utf-8?B?ZGtacEt6bWJzQ2ZnOTFWcHMzWjVheGxyTnNkdC9YTnhUNlB0MVYzR0hWR0hU?=
 =?utf-8?B?ZXBwc2ltK0VyOEZZNU9BdnN1YTFrV0Y1aWlyYWlUdE9KanBFN3I2eUxJNmoz?=
 =?utf-8?B?WFJwanY4TnhaTG1NNWlnaXBUODJsVmlPR29BMXM1TjhHcWR6blRqa01TaXV3?=
 =?utf-8?B?UnFpcWk1dnJ0YmNkcVY1MWEyL2xuZmNabDdzeFk2ZEJvWnEvaHhvOWZXRlhw?=
 =?utf-8?B?MjI2bm1PZlZKTWFLRDVjYzd0dlFyU0pQL292RUJZekQ2ckd5TEdwamRCeVY2?=
 =?utf-8?B?cUsraXovQmwrMCtOdnIraFc4azJTVUFqN1hUeGtPckxUbXhsQVNCeWVlUXhP?=
 =?utf-8?B?ZThVNkMxNU1RMGE3ZmJsdG0xZlBERXdzeDRPS1htZGNCdGF0NDYvdXYwZzVj?=
 =?utf-8?B?WG9xN2FjL0I3UUtXOExGNlNWakVOVk00MU9FejRiRFRzU2NhN0phWUFBUUNG?=
 =?utf-8?B?SkY1SHduSWJVV3hsb045cFFuSVg1WUlLKzZKdzNETWE0VE1sQ05uUVBFS2t4?=
 =?utf-8?B?TmlVWGh2SkxFODFGcDNBeGxlOWhsenllUkhscHdMZHlJc1VudFJYcXAwUVJ0?=
 =?utf-8?B?UHJZUE5qODZlRnVyTDN2ZkhKa1hyQXlqamRHeHp5VmhNQjdvK1g5WkpSSWtE?=
 =?utf-8?B?dHpnMGRkc0tZeGxpdjcrOUc1clFjYVhCV3UrcXkwZnA3Y0JaOU8vbGk1QTFx?=
 =?utf-8?B?WGUvL1hYTjJ1T3dkOFRPbHc4NytBMTdVaHI0TjNmdjRNYUJyekU0V1psWllu?=
 =?utf-8?B?bmZEaGVQMG1lblc1RUFTY3BidFVqSUt5MEZTSERQZkNrT3FBMFIyNE1oL3dv?=
 =?utf-8?B?S0gvRnpCMDFBRVRvSmRaNm94N3ROa1dVanF3bldwa1lMS3dZUDM2UmFIRFcw?=
 =?utf-8?B?Z0Z1RndMSlJCbVZJakNacnNlS0s0WTFSVi92Q3lPL0Q1cG1yUTcydllwMjRJ?=
 =?utf-8?B?TDk1N0RGVjl5aHVhU3JGcHRHeDFVVVhkTHJNZWN4MGZvbUxpcE9wZ0owZ1dl?=
 =?utf-8?B?Mk1RZ2RLWDRrTUJiZTlWemkrWVJRbExsRXZZaVpkMXF5dVJIamtLSVBIdmhC?=
 =?utf-8?B?REQzYnNiUGoxNlQzZVo3RUFyZjdPTWJsbVlmci85VURnWHFCTi9nU1lHemox?=
 =?utf-8?B?NjJmZlkrNzdCS3MrdW9PUCtrM0MvUm00Y0hrbHJLbitoR0dsVVBFOFVwRFV4?=
 =?utf-8?B?RlNUUFlNeWxjYjFoWVRtR0MwRU5KemN1OGMrRGx3ZW01U0Rpb1F5M1lZZi9u?=
 =?utf-8?B?TjJQR1B5Q1d3V1RRL3lMcFlQS0ZmWUMvdG8wMGxzalZGRzRyc0pBOS9raFg4?=
 =?utf-8?B?WFUveStVMUtNMkxMT0Y3Rk1lZjB6RjFIdVdUR1JuYlRGck00OUZoMXpZdUVV?=
 =?utf-8?B?UUswKy9lZmNvQ3JyOFM1cnlwRWJpR1Zyd3hJZVJrV204clFpc0FWYnFQVTcy?=
 =?utf-8?B?bkVVd2laMUJpbG5NTnlFL2hreG1ET0xoOGtLcVBPZjB0SmhMVm5uYUtuMEJL?=
 =?utf-8?B?Z20wdEsrSnpmdlJ4RGRQODVTSXJXeVY0M1BMd0JiZkhKdkRqUDB0aFF6RjQ0?=
 =?utf-8?B?QVFUNWhOQVA4Wkw4RXEwS0psQVdTTUtGRlM0Q3phTmg2WDJhYTMzR3dxendM?=
 =?utf-8?B?QysvSWozSTVpc3EzdldiR0p6cC9nenV1cFk3NG12SDRuelZDTWFUQW83WnpS?=
 =?utf-8?B?WFVXOXRFeDI1bndGdUQ4Z2lUeXFZUWRnbHV5U0pNSWpybVhmRktzd0o1NnFY?=
 =?utf-8?B?MFlKNitub0FEVFdUZC9ZcGtQM0piSUpHMDlnK3NWUEZsVkV3Nnk0NGNZNHFH?=
 =?utf-8?B?ZXBEQ1BKUExUUmR4dXFBb1I2cTNZU1ArL0hqUzU5aXdaTHphR01mS2pmS3g1?=
 =?utf-8?B?SzdwNVNmRmh3TXpVOWhCMURITE1VWm1LUFVZRm5lSXRESGVvSDVKbytOTWR3?=
 =?utf-8?B?bjRpeVJKVnZNWDMrdlF6NkNwTzVabHpHYjdBWERmQkRPdlZ6Q1hGTE1qR3Yx?=
 =?utf-8?B?UXBnVVM5bVJYMW1ZU1d3Z290MHhOSkVJWGtQWDBHVi9sUTNybWxKWGNHa0hp?=
 =?utf-8?Q?nN1zgMFWPR8E2A2Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6889314e-94d8-4ed4-b54d-08dec6cd056a
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:48:19.8166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXLKMl27CQCqkwSwvaiEIRjA4EXwPApu8z8OJTIMvVnh9Ntlp4QhxVUvocWyTp2Xa9YywDxHmu5AQQy0ue/1A1G0Xrq+OLrcuD0d+CCbWWo=
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
> Combine all MMC and QSPI configs into single defconfig which is named
> as "socfpga_stratix10_defconfig". This will be the default defconfig to
> use.
>
> This will support booting from all three flashes using ARM Trusted Firmware
> (ATF) as the secure runtime monitor.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Regenerate defconfig with make savedefconfig
>
>   configs/socfpga_stratix10_atf_defconfig | 90 -------------------------
>   configs/socfpga_stratix10_defconfig     | 67 +++++++++---------
>   2 files changed, 34 insertions(+), 123 deletions(-)
>   delete mode 100644 configs/socfpga_stratix10_atf_defconfig
>
> diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
> deleted file mode 100644
> index 2eea9a2a731..00000000000
> --- a/configs/socfpga_stratix10_atf_defconfig
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=400000000
> -CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x200000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> -CONFIG_NR_DRAM_BANKS=2
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
> -CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> -CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="socfpga_stratix10_socdk"
> -CONFIG_DM_RESET=y
> -CONFIG_SPL_STACK=0xffe3f000
> -CONFIG_SPL_TEXT_BASE=0xFFE00000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0x3ff00000
> -CONFIG_SPL_BSS_MAX_SIZE=0x100000
> -CONFIG_SYS_BOOTM_LEN=0x2000000
> -CONFIG_SYS_LOAD_ADDR=0x02000000
> -CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
> -CONFIG_IDENT_STRING="socfpga_stratix10"
> -CONFIG_SPL_FS_FAT=y
> -CONFIG_REMAKE_ELF=y
> -CONFIG_FIT=y
> -CONFIG_SPL_FIT_SIGNATURE=y
> -CONFIG_SPL_LOAD_FIT=y
> -CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcfitload; run mmcfitboot"
> -CONFIG_SYS_PBSIZE=2085
> -CONFIG_SPL_MAX_SIZE=0x40000
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_HAVE_INIT_STACK=y
> -CONFIG_SPL_SYS_MALLOC=y
> -CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
> -CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> -CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x02000000
> -CONFIG_SPL_ATF=y
> -CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
> -CONFIG_CMD_MEMTEST=y
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_I2C=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_SPI=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_SPL_DM_SEQ_ALIAS=y
> -CONFIG_SPL_ALTERA_SDRAM=y
> -CONFIG_DWAPB_GPIO=y
> -CONFIG_DM_I2C=y
> -CONFIG_SYS_I2C_DW=y
> -CONFIG_SYS_MMC_MAX_BLK_COUNT=256
> -CONFIG_MMC_DW=y
> -CONFIG_SPI_FLASH_SPANSION=y
> -CONFIG_SPI_FLASH_STMICRO=y
> -CONFIG_ETH_DESIGNWARE=y
> -CONFIG_MII=y
> -CONFIG_PHY_MICREL=y
> -CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_SYS_NS16550_MEM32=y
> -CONFIG_SPI=y
> -CONFIG_CADENCE_QSPI=y
> -CONFIG_DESIGNWARE_SPI=y
> -CONFIG_USB=y
> -CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_DESIGNWARE_WATCHDOG=y
> -CONFIG_WDT=y
> -# CONFIG_SPL_USE_TINY_PRINTF is not set
> -CONFIG_PANIC_HANG=y
> -CONFIG_SPL_CRC32=y
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
> index 8e80127b2d8..82f0cceafb4 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -1,80 +1,81 @@
>   CONFIG_ARM=y
>   CONFIG_COUNTER_FREQUENCY=400000000
>   CONFIG_ARCH_SOCFPGA=y
> -CONFIG_TEXT_BASE=0x1000
> -CONFIG_SYS_MALLOC_LEN=0x500000
> +CONFIG_TEXT_BASE=0x200000
>   CONFIG_NR_DRAM_BANKS=2
> +CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x101000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
> -CONFIG_ENV_SIZE=0x1000
> -CONFIG_ENV_OFFSET=0x200
> +CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="altera/socfpga_stratix10_socdk"
> -CONFIG_OF_UPSTREAM=y
>   CONFIG_DM_RESET=y
>   CONFIG_SPL_STACK=0xffe3f000
>   CONFIG_SPL_TEXT_BASE=0xFFE00000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x3ff00000
>   CONFIG_SPL_BSS_MAX_SIZE=0x100000
> -CONFIG_SYS_BOOTM_LEN=0x2000000
> -CONFIG_SYS_LOAD_ADDR=0x02000000
>   CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
>   CONFIG_IDENT_STRING="socfpga_stratix10"
>   CONFIG_SPL_FS_FAT=y
> -# CONFIG_PSCI_RESET is not set
> -CONFIG_SYS_MEMTEST_START=0x00000000
> -CONFIG_SYS_MEMTEST_END=0x3fe00000
> -CONFIG_OPTIMIZE_INLINING=y
> -CONFIG_SPL_OPTIMIZE_INLINING=y
> -CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x02000000
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_QSPI_BOOT=y
>   CONFIG_BOOTDELAY=5
>   CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="run fatscript; run mmcload; run linux_qspi_enable; run mmcboot"
> -CONFIG_SYS_PBSIZE=2085
> +CONFIG_BOOTARGS="earlycon panic=-1"
>   CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
>   CONFIG_SPL_SYS_MALLOC=y
>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x3fa00000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x500000
> +CONFIG_SPL_MTD=y
> +CONFIG_SPL_SPI_FLASH_MTD=y
>   CONFIG_SPL_SPI_LOAD=y
> -CONFIG_SYS_SPI_U_BOOT_OFFS=0x3C00000
> -CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
> -CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x04000000
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
>   CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
> +CONFIG_CMD_NVEDIT_SELECT=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_WDT=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
>   CONFIG_CMD_CACHE=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_ENV_IS_IN_MMC=y
> -CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> -CONFIG_USE_BOOTFILE=y
> -CONFIG_BOOTFILE="Image"
> +CONFIG_CMD_UBI=y
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_OF_LIST=""
> +CONFIG_ENV_IS_IN_FAT=y
> +CONFIG_ENV_IS_IN_UBI=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> +CONFIG_ENV_UBI_PART="root"
> +CONFIG_ENV_UBI_VOLUME="env"
>   CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_SPL_ALTERA_SDRAM=y
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_DW=y
> +CONFIG_MISC=y
>   CONFIG_SYS_MMC_MAX_BLK_COUNT=256
>   CONFIG_MMC_DW=y
> +CONFIG_DM_MTD=y
>   CONFIG_SPI_FLASH_SPANSION=y
>   CONFIG_SPI_FLASH_STMICRO=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_SPI_FLASH_MTD=y
>   CONFIG_ETH_DESIGNWARE=y
>   CONFIG_MII=y
>   CONFIG_PHY_MICREL=y
> @@ -85,9 +86,9 @@ CONFIG_CADENCE_QSPI=y
>   CONFIG_DESIGNWARE_SPI=y
>   CONFIG_USB=y
>   CONFIG_USB_DWC2=y
> -CONFIG_USB_STORAGE=y
>   CONFIG_DESIGNWARE_WATCHDOG=y
>   CONFIG_WDT=y
>   # CONFIG_SPL_USE_TINY_PRINTF is not set
>   CONFIG_PANIC_HANG=y
>   CONFIG_SPL_CRC32=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

