Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E40F327CB
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F353843C0;
	Tue, 21 Apr 2026 11:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LRzvEpWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7C884461; Tue, 21 Apr 2026 11:30:55 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C2D8439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHiS9ZbZWHqL2O6ikQQVWAgOfwFyxSz92V03M63pPfFf1qHKBoYO/AfcvHPfqD4jMl6DvMI3EWJiw6X6mdcwPM65y9oeOcRD/RHa57HJLr93FEzQPRRX7hw4pv2B+Si6xWpaUPDtjYLoQcU+wiBxPe4azLmTC+UA797KR7gj3htPO1zWEtViZOTLOvMb98v5QU91R2s1Fjd80MvobH1P4QlGzmBih3U2ZFqAZTXkZPOz5fkvzANCgYVSjf9aMEgjWQNf45vzmJuW8qWStr0mcdBry+t5exyR/M9F1TFHcN9kuKL8ZpWpj4puB0pZ4z8u6XO0bM/i+RN2l9YSFgn0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ltuavUT1s8NGcyI6QjbPUmSRMZdJbEhTCn16eWKik=;
 b=G5IPJR3Gy5TPWdhxFtJAjitX1t5t8w0Cl5C0s4zuSaFRTFz0Vgv97d+1LJIH8Gc6xDdB0ldy1fH9ubduyW4VJjvSDXGSxizO7apnSQxIHO4Paj7eDXcv3gUr8nETZADyaLR+CSl6hQwvOnCOPkS6BxEMWZpzVlpL5DAR7AUx+N0juJOpPdGQdKZxQIFsiXS3bDVQQtFvubue7D1A+P6CfrpuqUG3rMBvrBNGWGxHArGbdjOkSxGjP4K2Q0x2GdXogeSZAGoSbkINAajcqJcK8fV5iTUQ0rmg8ywste4F62hnvzHa4s271xSSDD+Or6WfThL7oEE7RdPzps0jdLuTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5ltuavUT1s8NGcyI6QjbPUmSRMZdJbEhTCn16eWKik=;
 b=LRzvEpWRK3DbdqNkhpsYK8bT3jQ67pyTuh2MKSjWnI45C8wSBAQw1H+S0KMIjc3eTgtyOFK8GrcgLVqB73U6ImzHnRmspnAarT0rQPfS1rodzo+8kpR+6WoevoFTd5FI+QbqEowoVA/QjOkA2g5QZAFekLEmsJaFUZs85g+Tt1zFOQ8FHsbCEddltzfQOVE88LcM4LJcetf8hfLjYe0TSpKcYZ+QFFUs0Ka7d6NK5J9liPH17clY+TK+zEkyHjecn4Pi7O/1Plh1G5Zg4h0LCNehTsAnxqingHsyB43C+FiZXUkj96pITkpxADxEsu5JSChGPpBDvb7ta94O3k94rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA0PR03MB5641.namprd03.prod.outlook.com (2603:10b6:806:b0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:30:50 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:30:50 +0000
Message-ID: <c566d6bd-ae38-431d-a43f-326abdce3e69@altera.com>
Date: Tue, 21 Apr 2026 17:30:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] clk: s10: Refactor S10 clock driver
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-8-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260403022513.9446-8-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA0PR03MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 717849fd-a794-4d10-056b-08de9f88acc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 8IwE7KOIw3Uhe0xMYHmeBZCy2orUN98z0fMsYV/1Q3BESjhZ7ChqYMTeJby+O/RtNZpjlhNQWOC4Fz8XhzDVZaQFEXs5yN9W1IkfjOlYs00aASqNA9bGbPjMbJm+PX4cZRXCAbpgnf3x758xYkzns5YYfDHSE35UYT3gVGDB4EbB1UKEljXrbSHtYZ6q8xMe/Y9lT98EeYYn35lzICReimex8uNHNAa+AdMjezmfVU/s+ZLp9l/BeUt3yTTeUXmbDPdsoK5RCEJCbtKf91UNkAfb7JqrQ1vTRw7/03Q2dl+sqmzqYhhpWcpG6B9mKlu5QdKFPOzZwPHXAUXV6yJU3HHxOlBXF+/Yxr/T+Y6ZiszOh4iLEQrbosraQ4aFoHLt1j9xqfCoelnjO0wucJLIk38+qcZ5HHX6/GHyWXSq7kLgVqOykO8Ac7ZNyJkU49/XwETuKPWC1zvpsbdRCnc8iQJA5S4McsVzAUCbls0HNk9sBLr2OzKnbWKRZLmbCnXX7uhQNoTcNT3iWgGuMQKSw+wKewuumGZZIW6F9+RymKfvGYIE8/j4l2tl02imhhSikwXlxkzWPxYjdaZ3wSkni5upXiunBNNpg3l6vGcxYEUujplOX/4eNOwjF0lx9S9iulEJ8BJUOD5wbzw57PUeZ/eSk7oDf57flxOibbFITBkfopwd8U5pOcdaATICyW6A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUwxZGNxVWxzdHBlaGFhMnRWcXNhUXNsaVpYUTI5K1gyallkcUs5V2lyYkJl?=
 =?utf-8?B?SDNVc3pWblBVMy8wajVOT1B2NFhvYzBMenNyQWJjVTRxZWJVZllJaWlROGJr?=
 =?utf-8?B?OXJOZnoyNzBKY2UwSDdJK2hpZ01jTWJQYVk5MGNXRUZwaG5GZXBiaWJhdkJY?=
 =?utf-8?B?MzQvb0x0MTNaNUQyRFJHOWhORExHYkhTMm9ONjA4TTdoQjJSczl2NlpURmVZ?=
 =?utf-8?B?ZXBRSG4rMnZ4UU9YYkh4WXBFQm5LRkNEbHRiOGxQUDJVcXdqWVcrTjgvcWpO?=
 =?utf-8?B?WnkyOW5yc20xdURteWlXeFBvUXlaMy9GamlmZGhtd2FqNDZYWkFsSlo3VVY2?=
 =?utf-8?B?dzhvQjJkbFh1V0xEVWp2c0lQYVFwQUlNU1ZCVTJwTTE3bS9FU1ZObWpZTjVI?=
 =?utf-8?B?NklRVmIvVEY4ZTRmbHR0ZkNFSCtnTTZhaFltTG04Z2hyMTQ5Sm92M2V5S3M0?=
 =?utf-8?B?KzBCd0l5RkxlVnIweUJxNlhsVTNYRUUxaVptdFplVlM4U2lSbkl6ajVsRlJ5?=
 =?utf-8?B?VEkwRlJ0OVlkWkJaNEFWZnRBR241QzV0M1NJUEQzQzJjMXIxMkY2S0JDVEJJ?=
 =?utf-8?B?b3pUM3Y0QWEzMzdZOWN1K2lxaEptNFArbjV1ZGNlbTk2QmJUbHAxeGNZVkN2?=
 =?utf-8?B?NEpoZldQbXA4Z091bUM4MkRpL1FIQ0FKVDVlZGFYVmdNTHFTTTErSURpRVlV?=
 =?utf-8?B?RUtGMldzR3l0bXAvSFFsRVBXcTVjTWhZZEtHZkhMSThIbzNlRnV5cTRSYU1O?=
 =?utf-8?B?dXpGRkVqR3FqK1FEeSt3dFFCRzRGYTkzckRiVC8wT2c0YzZoT1hmS2hFMHd1?=
 =?utf-8?B?ZXFoSUZjU2FNSTNERmQ4WWhjc0JyN2V5N2t6Mmg4Yi9FcE1BZlVDQ3IyQkgx?=
 =?utf-8?B?a1FUT2NjY3JQbVFoYUc2SXJ3TnhSbVBnTTdoWlh6NmhRZFZudURJNXpOdGNU?=
 =?utf-8?B?bjRxZVhWWUZPSVRkNkIrZzh0N2tQb1V6MWQ4Z2g3dXFmaVdwRDRPQlo2Qkdo?=
 =?utf-8?B?cUtlQXdKaTVNSzBuZUVJUm56S0JsbmNtUlp0Q1hoZEVBZzNtZzRuY0luZlQw?=
 =?utf-8?B?UHlOanNwVHc4UWF6cWU5TDhkMFQ3cEQ2aFRUK2RuUUg3YTl3QmNWRFovSFdo?=
 =?utf-8?B?QVNJdy9TbU1KdTRRc3ppTEtwOTIzMFpnMGpmaStqcmJGNjVBSzJadko3Z25I?=
 =?utf-8?B?NWxuWGNyNHVmWkx1RjNWQjVhSzRKZEJEcm53aW83NkFBNktDMFlRUXlqeEh1?=
 =?utf-8?B?UUNuc1dEQmZsWnpma0hMbmRMeXdGRTdYNmpoeTl4cTFzWURIZ3J5SUtLcG00?=
 =?utf-8?B?NktXRjBMRlhQVHdZVlZ2YXVIOVg2S09XdjRnQ1ZjbkZKOWI5SnFmcUJEK2hj?=
 =?utf-8?B?UG9lY2F0Q0NvUHZmV0d1QWRVK3p0R3VDY1FVeExOVE15QldyYzc1R1FTNmFL?=
 =?utf-8?B?VEJILyt6TUlwbk42OE9PNzJELzJhSWtTMEZQOGd2aFBZYmozTWo2VlJmbFBI?=
 =?utf-8?B?UUFZYWU1MEFSeUp1N1p5YWJEc055L3A5TlhyUVZXeXB5ZzJOdG1hbGxWaWxE?=
 =?utf-8?B?REtOTzlFRHVqWFlheG90YjVjZ212S3dycWF5ZEEzNXBQWGRHWnJCSDFZTVRr?=
 =?utf-8?B?eDMxTytwb1VVN0pHRTlyMFN2NFBJaHNOUFpTZ09XekdKQk5kcDdwNjY0dXJu?=
 =?utf-8?B?RWdjU3kxeFNhK2lUY3cvVzBWemZYWXZqSEVvL0greWFHbXBKNmZxNlliVzUw?=
 =?utf-8?B?M09KeFV0UTJxZDBzOERqSWdDYlpGemUzcVQzbjVVbUJnWkY3NnNqc2EzVHhS?=
 =?utf-8?B?blZaakcrRTFhbmc0dVZuY3lqblpDeW5mS01HQWY2RjhBYXJhMWhBQTV4TnAv?=
 =?utf-8?B?eC9sZnFvUzdBSFQ4bzNWajd3MzE4UmU2MDZ2YlBVeEljQ1FCbmVyRWREYkVz?=
 =?utf-8?B?dUlBR3ZoSis5SkhaUU5SUk5wRGttVVl4amkzcTIxREh1YTlWUWFqL0swdHVF?=
 =?utf-8?B?cGdIRjlFODhnVUlGZUxiWlJzd1kvQVN4OWZTemNGL3p1NzNTL0owNG9aVXBF?=
 =?utf-8?B?cVROM09JWjhUUGR6SzgwaCtQanM0OWJ4bHAzUEV4bG1VWUdVODFSY1lXSXhr?=
 =?utf-8?B?aGEvVDZ1OGcydlZmV29GMi9XenB1MFhMU0FydU1xdjJjUTNLa2U5NzJiUFUx?=
 =?utf-8?B?bU0xR2Z2QW11Q2UyMGViaDF4YXBsaVNmRDk0cDZuV2o4R3Q0QUY2TzMvcFhP?=
 =?utf-8?B?aHFBRk16bGVGbEh2Zk9haXl5aVFSdE1mSVQvNTR5L2p0TmdJZnpZR0szVTEw?=
 =?utf-8?B?eGZJRGZEcGM3cnljZ1RVTisxY3NSZEFhOENvdE5sQURRa1ZUMlNtVlZlbjlU?=
 =?utf-8?Q?egU/ZLTjppfvs824=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717849fd-a794-4d10-056b-08de9f88acc5
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:30:49.9850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VoFy6FX9D7JZi3bltn3R5bURr759Jf2D+uWWxYgXrzcp5IwzmfQN6aIwCsLVmiTFRdad9JNwFdVPqOiMDqp2daw3N0/pSLKR9yvAU2BA24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5641
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


On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Refactor Stratix10 clock manager driver to support driver model, following
> Agilex clock driver.
>
> Create a new clock driver, clk-s10.c, for Stratix10 which supports the
> driver model. This allows several APIs such as enable/disable clock, and
> get clock rate to be supported.
>
> This driver will be initialized during SPL to bring up the clock as early
> as possible. The clock initialization process are refactored into this new
> driver from clock_manager_s10.c during clock driver probe.
>
> Excluding Stratix10 from legacy method of obtaining clkmgr base address in
> mach-socfpga/misc.c as the base address is already obtained during clock
> driver probe during SPL initialization.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   MAINTAINERS                                   |   1 +
>   arch/arm/mach-socfpga/Kconfig                 |   2 +
>   arch/arm/mach-socfpga/clock_manager_s10.c     | 449 ++-----------
>   .../include/mach/clock_manager_s10.h          | 176 +-----
>   arch/arm/mach-socfpga/misc.c                  |   3 +-
>   arch/arm/mach-socfpga/spl_s10.c               |   7 +-
>   drivers/clk/altera/Makefile                   |   1 +
>   drivers/clk/altera/clk-s10.c                  | 591 ++++++++++++++++++
>   drivers/clk/altera/clk-s10.h                  | 202 ++++++
>   9 files changed, 861 insertions(+), 571 deletions(-)
>   create mode 100644 drivers/clk/altera/clk-s10.c
>   create mode 100644 drivers/clk/altera/clk-s10.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c58d8f85e33..863e0b763d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -159,6 +159,7 @@ F:	arch/arm/mach-socfpga/
>   F:	board/altera/stratix10-socdk/
>   F:	board/intel/agilex-socdk/
>   F:	configs/socfpga_*
> +F:	drivers/clk/altera/
>   F:	drivers/ddr/altera/
>   F:	drivers/power/domain/altr-pmgr-agilex5.c
>   F:	drivers/sysreset/sysreset_socfpga*
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index aec0fb7b1c8..c7ecdc4055f 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -149,8 +149,10 @@ config ARCH_SOCFPGA_STRATIX10
>   	select ARMV8_MULTIENTRY
>   	select ARMV8_SET_SMPEN
>   	select BINMAN if SPL_ATF
> +	select CLK
>   	select FPGA_INTEL_SDM_MAILBOX
>   	select GICV2
> +	select SPL_CLK if SPL
>   	select ARCH_SOCFPGA_SOC64
>   
> [...]

> diff --git a/drivers/clk/altera/clk-s10.h b/drivers/clk/altera/clk-s10.h
> new file mode 100644
> index 00000000000..f5be1e68500
> --- /dev/null
> +++ b/drivers/clk/altera/clk-s10.h
> @@ -0,0 +1,202 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + *
> + */
> +
> +#ifndef	_CLK_S10_
> +#define	_CLK_S10_
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/bitops.h>
> +#endif
> +
> +#define COUNTER_FREQUENCY_REAL	400000000


COUNTER_FREQUENCY_REAL 400000000 defined in clk-s10.h but never 
referenced in clk-s10.c.

Example: 
https://github.com/u-boot/u-boot/blob/e3405917a1806971d9e72a94186b299f05581e1a/drivers/clk/altera/clk-agilex.c#L357


Best regards,

Tien Fong

