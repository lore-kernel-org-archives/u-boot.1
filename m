Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAC6CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 08:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333348056B;
	Fri, 12 Jun 2026 10:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MSX1Bf8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA2B84664; Fri, 12 Jun 2026 10:09:27 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551A18005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQXv4i8tPXEbLLq5zkVwyMFVzJ8RMg920JUJFnV7jJ9En+tVt/njko9NaA/m3sxw6VtIccUfOPfIDA+cmd05U+1+EWhqxX6O4j1jJb494HtBpSz9aPZ9f2wEnPh4o8BOAOX0vb5+lRvD7REwT9rXB9Sgp5npMFVmRLEwPXAU/ZQVZ6n6xn43k3dZyDvmnVfKxq65jC4Jb5jylXYSgeYYmbQqXZFiBmjHTVChy9B0bXrwxfHN6G0/IcDUWC5tVkH7DZWqiodHmqEgeCvOypXiYTHdctR/p9PrlL6Eg8N0DRyj5Y21+b6HAqwhTs1DAeR7CloOPKe6sBrjFDW4vMzmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXev+uQZlAgWNWMTGNlX70VEBoezHRYKTBKvr6BLIvc=;
 b=KxqsUctnjaDEGX3wqqQIZDssqzAgOpWZfeBeRMA4hJZU0IRaOvSbVie/5hKYTjj16iudBrpArulkdMKUfTu0CVvadvdeDUj778Lhu0ailcihfLmUgq3JBm+VnZQrcRR/1SRxlzYfujiGQys+ApDNXkgh+FWsOkktjhZk5oizJyORXJVGwQHnSh3g5/2m4vQtNN8/igDYMVINF46IWYi4944VRutoztmc+CcgAPe9sb2hbzBtek3RwZEYclLY54jbGwEM7SM7Y9MDn/uIlPobYeakjnW7txJAFAqCULQmpJaCtKGpBJddtYiO6IumHkP2muKSX5tIhDh9wiK5qVcsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXev+uQZlAgWNWMTGNlX70VEBoezHRYKTBKvr6BLIvc=;
 b=MSX1Bf8sgxMsaFMZZHaFv4QsfrAQh4fOtFWDihrGEHOWFexwdOoM+E+fbk7uhDtlAfslocIsHu+kKNoaTnsUBDOWPs6pG3oF/vIuV+YZx0PWDgg6Eve1nhq0Rnqso9SP3gPAMoIn06gWb6J8Feyw1MfsDKMHOMabYgvgUFfieiznoTr0PMVDIvTfi7Y3/xo3r3zpypV4BSoZ0EOvK8d3CpREtj/jSCROJpc8GnSIOdzB1+T/eYKVgI7TDH1irUh69smMlxR4y+EmF1D9zNOXOp1gnOpdQiMqCLrbKqMCX0EZ1lJmjhwvYCkbE0sm+JMYaUWjfAvDheiqZEDvDTUhAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BL1PR03MB5975.namprd03.prod.outlook.com (2603:10b6:208:31a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 08:09:21 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:09:21 +0000
Message-ID: <848b7ff7-26df-4ad5-b778-3f275ded5977@altera.com>
Date: Fri, 12 Jun 2026 16:09:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support
 for both Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 patrice.chotard@foss.st.com, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
 <20260609020358.25985-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260609020358.25985-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BL1PR03MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 61734227-f51b-4970-84d4-08dec859e8b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|13003099007|22082099003|18002099003|55112099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: QpVsP8PIUrEpK8hp/cq0/U0UgmHpCoySmRoHwSDn9Qo5HlCXSSbkPU6c3gXwDAetG8HckXBxkM6EYwAbvRvnv1LgWvT0zl0Iw//hZHDIxKPfY3hw/Mt9UZRFKckwJjR5sTsBCOLrqQ/vxOMFwN8ykRLNNZaUHBYvLrUuFeHvJs5UqhRs3eDW9fwAVfQBlvf175jvJD6O/V3ycvBz0V7+8L4WO65vvy+ZyQ8lRpSMElLVIQXuMm44d+ObvHZ6O/Py3K/o4Z0yEjNto1eyvLASRDjJMbiY+5mtFeRBDbFUuTlp4UFgdsY+vjVBSHAGUmmK9lSaICKzhBWbXVlAxIaw0yuS8yrZJslMHWs3SXraxCR2J5MW04k0HYLCVBvGNsTg1Gge1iGqG4mNwSZma85RsqqKnUNf1ERFni1LFMCVPayzKBtoxynM14NIBxZ0Df7ZX/3TdI5kO2hO09E4Wfdapq+o1/6OXWTHr4EJci2Gt0nwn5RVtHScFkgNURdOWOejBFFBcAOrc7o+dpzfOB7QC63iOO9dVezOWyat37SXb68LPKE7Lp8bxRSJR+MNNC3rgQm9SrtGysX7Me2Y7u/trV2sve/e4NPUoJxvo1RJMobjyoeS8rb7ybdpxYwKs57rUnR1rnSpgw+fKBxKpAMKUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(13003099007)(22082099003)(18002099003)(55112099003)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajZzUWhLZ0xmQ1YvWjNSSElQUlBMQmU2VURxd2RkdkNHbEhKUEdmeTZQajEx?=
 =?utf-8?B?S0xKbUpWOTEraGY4a0pQUEhhREYwcmhvK1A2aklEWDFXNW5LQ2hjc2tuMEVh?=
 =?utf-8?B?S1pvRysrUDIvaVVWMXd5MEE1S0pmMmpFa0t3dFB1ckpSa3FQVDY4K0cyUE1v?=
 =?utf-8?B?S0ZIWTJOR0N1Qll2d3ZwdVZ6RDRiWXd2MmxBRnd2eGd3YlcwYWI4bEh4MWl5?=
 =?utf-8?B?cEQ4VEdyVVVkSGJwL3BJVlNqN1FsR2Roak9iTHZ5c2NJSkd6b2V1WFhjazd6?=
 =?utf-8?B?cHZEV3MxL0xEQlc3VXdDNHZxdHhFOU8yOXlieDhKZ2ZwVEdxazdPRDVVeTda?=
 =?utf-8?B?R0dKQmcrWkQ0NXEyR2VxclpXd25VUFhPYytHVzU5OU9MTnZBQlg1ekZoRGR3?=
 =?utf-8?B?QlNPTUNWZGhXb2hqYkltemI1S3JXWEtLbjROdXdWLy9KOG1VTU5UUE41Rk56?=
 =?utf-8?B?enRpWlFIWllTRVVSK1YvVkkvSnY5UUJ1WDBmMFRpZDZVWGhoeHZDSjk4dEJx?=
 =?utf-8?B?c3N6cUgvZ1didFAwM3doTjhiYVNhdHVYWTVxV1R4NEUzSWZNSkVvU0UyQVFI?=
 =?utf-8?B?WE1mM0hOTkI2MC9ENVcxMURpa1BmWWtzamVTQ2liOC83bmgrRURUS3VLV00x?=
 =?utf-8?B?K0FRT0tjeGEyRGdXV0kxV3FpY2s5ZXVjTXlmWjg3UWkrTFo2ZEF5YUxPenls?=
 =?utf-8?B?QnRmSWVQUVZGc2FWVWdFSGI1cXBiNER6UjhZUU03cE9RWVNEeXN6SHNlWldv?=
 =?utf-8?B?SmphSDFBVXFIQk42MjB6c2ZiRXNTU1lrQUxhbXBrazZnZ2srbmp0VVBubzJV?=
 =?utf-8?B?WHVvVS8wSzRCeWZVZ0dPVXVDdGV4bVJIVDFlTlJubnlZcG9uL0FjSEY5TDlP?=
 =?utf-8?B?ZzlDQzZJNm0xOUJmYWw4VVE0aGFtbzFBVi8rc1kwcExBM3lLd3V2U3BxekRp?=
 =?utf-8?B?bnVvWHg3cFhxeVNlenRwd0x3UHRhd1d1YmZsNW51MnQ4OTF4cXZKQ0s1VTZZ?=
 =?utf-8?B?aHcyaHd0WVdHeXM0MU5RSC9IaUM0OHZxWnovdkpmbXh3Q0trSmZQcGlBdGts?=
 =?utf-8?B?bzFWUGpXVUMxUWV3czdHejVsU3FLd3R3MUlneHpmZlFRUWM3NzBNUGVtWGcx?=
 =?utf-8?B?U3JOcGVLVXdRM2F6bDc5RTV3dTFVN2c5T082UzNUeWtTSEFwRW1KMWJSSWFO?=
 =?utf-8?B?ZjRMQkVONHpmWk0vaGNUaXhPd2tCZmVsS095cUVqcTU0aW5UbzRYRFkreTd0?=
 =?utf-8?B?aE5KRlZabFZDd1FZallRQ1IvUWN5Z0Y2VDdJM3JMZU5pcURsMlUwejFpQ3ps?=
 =?utf-8?B?VGFIZndTUW95MzFPNllHa2hjTGEvS1V1N3FsQUJhb1RjRjRZS0d4QTBZeXBn?=
 =?utf-8?B?YXhPWjlYMWlKWVl1Tm96VE5EcE1kL1g2WEROcHg4VzFJQUZDQTVRM2lPTnNn?=
 =?utf-8?B?V29pOHRmS0RIMmxOcEtMaHFXUUIyNE5vekpwbldoQW9oU2ZOUGUvZlprM29R?=
 =?utf-8?B?bFFVV0xZektLZFIxVFRuWjFoNVVEM2VzZU5ieWhqcVcyZFF3TnAweVA2Y3dH?=
 =?utf-8?B?MDJ4WDFmNGtHcEsvWldZNVZzTkkrU3VNc3ZSMzFnaUt5b3lOTnJoNGVXZkpr?=
 =?utf-8?B?aVFtRzFnMzZ1VWN2L1ZwdlRXdzVBSFJMcDBQUklXWDlKamo4cWZXN3BmeVZv?=
 =?utf-8?B?VlFqcWZPU0ZEaVdpdWlaV0NBdXp3Qk05Z0ViU2RqQ2x6MnA2R0RVUmNHK05I?=
 =?utf-8?B?L2lGNUFxZUVpaHlXTVJQTXFTcnVESE1pR2FVOG1aS25TR2hXZEtnUFBuRENE?=
 =?utf-8?B?Wjd1Z2dXekNYUitwd1lvakJ0RXZNMERoZXpxbXEyM01YUUptMHlreWFxUUZm?=
 =?utf-8?B?QWJ4TFRvV1FEQUROc3h1dTRjZmpRM3ZuRVBvakJOOFQ0VzlCZmJrd3dOZ3lE?=
 =?utf-8?B?dG1RSThGa0dTQ0cvQmRKa0tKQ3N0WWFsa0pPcFZvaWV0SERNK0ZDeUV0eUlX?=
 =?utf-8?B?QlpoRWtnUzNONXczb1ZLOHd4UTVsTmk2NlFPY2t4Y3g5Y0JwTzBNZ2NPSjRT?=
 =?utf-8?B?K1NMNVZkUFUzTjVBSStjaTZNek9IVnltcTRscEQveGlMS3NKTTNTcDJROVk3?=
 =?utf-8?B?NzBLMDRkZmpqYjJSUzFtUmp4VlJhcGI2aDlRbXc1eDlhdDgwOVVhZEd6UHNE?=
 =?utf-8?B?K29pOStEVDVRSXh6UW5TT0p2L0c2Rm5wNlB3eXdPa2RoT3YzUm55dTM3Rk56?=
 =?utf-8?B?dEJFM3dvYXR6aHVtRis4dlZMQ3pvdXVBbWhBYnMrMGhWOEZMOTUzdlRVZFpN?=
 =?utf-8?B?S2hGUTFOZ1JXTFNwNXgzVXpqM3VYNjZUWER1UWRHUlRYNDhNZS9vdElXdUZX?=
 =?utf-8?Q?eFzKIEzQ+L/D80a0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61734227-f51b-4970-84d4-08dec859e8b6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:09:21.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDZuOghRJrnqp8Q2zXI5lPCUV7O/KzxHXOX7ysPmgoyFWEspJx48sYrlpt5ye5WqcKA/ZL/RAn4qXD5JXv3nr3JhT3gjplh+If1HBUbZku8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5975
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

On 9/6/2026 10:03 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable ECC scrubbing support for Gen5 by moving sdram_init_ecc_bits() from
> sdram_arria10.c to a new common file, sdram_soc32.c which is shared by both
> Arria10 and Gen5 devices. This makes ECC scrubbing support no longer
> exclusive only to Arria10.
>
> Remove legacy HW watchdog check in favor of current WDT DM for
> Gen5/Arria10.
>
> New Kconfig is introduced to enable this implementation only on the default
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v4:
> - Block comment style fix
> - Rephrase SDRAM ECC init success message
> - Updated commit message
> - Updated copyright year to 2026 for sdram_soc32.*
>
> Changes in v3:
> - Updated commit message
> - Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Arria10
> - Dead code cleanups, indentation fixes
>
> Changes in v2:
> - ECC scrubbing is set as optional via Kconfig and defaulted on only for
>    the reference Arria10/CycloneV boards to avoid SPL overflows on
>    size-limited Gen5 defconfigs.
>
>   arch/arm/mach-socfpga/Kconfig      | 12 +++++
>   arch/arm/mach-socfpga/spl_a10.c    | 11 ++--
>   arch/arm/mach-socfpga/spl_gen5.c   | 10 +++-
>   drivers/ddr/altera/Makefile        |  4 +-
>   drivers/ddr/altera/sdram_arria10.c | 31 ++++-------
>   drivers/ddr/altera/sdram_gen5.c    | 39 ++++++++++++--
>   drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>   8 files changed, 172 insertions(+), 35 deletions(-)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index b814e034ecd..dd71691b724 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -6,6 +6,13 @@ config ERR_PTR_OFFSET
>   config NR_DRAM_BANKS
>   	default 1
>   
> +config SOCFPGA_ECC_SUPPORT
> +	bool "Enable ECC support for DRAM"
> +	help
> +	 Adds CPU-based ECC support for DRAM at boot. This will initialize
> +	 all DRAM ECC metadata to zero, preventing false ECC errors and
> +	 improving reliability.
> +
>   config SOCFPGA_DRAM_SIZE_CHECK
>   	bool "Enable DRAM size checking for safety"
>   	help
> @@ -105,6 +112,7 @@ config ARCH_SOCFPGA_ARRIA10
>   	select ETH_DESIGNWARE_SOCFPGA
>   	imply FPGA_SOCFPGA
>   	imply SPL_USE_TINY_PRINTF
> +	select SOCFPGA_ECC_SUPPORT
>   
>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   	bool "Always reprogram Arria 10 FPGA"
> @@ -117,6 +125,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   config ARCH_SOCFPGA_CYCLONE5
>   	bool
>   	select ARCH_SOCFPGA_GEN5
> +	select SOCFPGA_ECC_SUPPORT if \
> +	  !TARGET_SOCFPGA_TERASIC_SOCKIT && !TARGET_SOCFPGA_EBV_SOCRATES \
> +	  && !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>   	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
>   	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
>   	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
> @@ -124,6 +135,7 @@ config ARCH_SOCFPGA_CYCLONE5
>   config ARCH_SOCFPGA_GEN5
>   	bool
>   	select SPL_ALTERA_SDRAM
> +	select SPL_CACHE if SPL && SOCFPGA_ECC_SUPPORT
>   	imply FPGA_SOCFPGA
>   	imply SPL_SIZE_LIMIT_SUBTRACT_GD
>   	imply SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
> index c20376f7f8e..0d0412d3507 100644
> --- a/arch/arm/mach-socfpga/spl_a10.c
> +++ b/arch/arm/mach-socfpga/spl_a10.c
> @@ -25,6 +25,7 @@
>   #include <asm/sections.h>
>   #include <fdtdec.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   #include <asm/arch/pinmux.h>
>   #include <asm/arch/fpga_manager.h>
>   #include <mmc.h>
> @@ -265,14 +266,8 @@ void board_init_f(ulong dummy)
>   	/* Configure the clock based on handoff */
>   	cm_basic_init(gd->fdt_blob);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* release osc1 watchdog timer 0 from reset */
> -	socfpga_reset_deassert_osc1wd0();
> -
> -	/* reconfigure and enable the watchdog */
> -	hw_watchdog_init();
> -	schedule();
> -#endif /* CONFIG_HW_WATCHDOG */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
>   
>   	config_dedicated_pins(gd->fdt_blob);
>   	schedule();
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index a9825173189..530863b1564 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -22,12 +22,14 @@
>   #include <debug_uart.h>
>   #include <fdtdec.h>
>   #include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   #include <linux/bitops.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   static struct bd_info bdata __attribute__ ((section(".data")));
>   #endif
>   
> @@ -113,6 +115,9 @@ void board_init_f(ulong dummy)
>   	if (cm_basic_init(cm_default_cfg))
>   		hang();
>   
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   	/* Enable bootrom to configure IOs. */
>   	sysmgr_config_warmrstcfgio(1);
>   
> @@ -150,7 +155,8 @@ void board_init_f(ulong dummy)
>   	/* enable console uart printing */
>   	preloader_console_init();
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   	gd->bd = &bdata;
>   #endif
>   
> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
> index 8259ab04a7e..ece6a131897 100644
> --- a/drivers/ddr/altera/Makefile
> +++ b/drivers/ddr/altera/Makefile
> @@ -7,8 +7,8 @@
>   # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>   
>   ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
> -obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
> -obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_arria10.o
> +obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
> +obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>   obj-$(CONFIG_ARCH_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>   obj-$(CONFIG_ARCH_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>   obj-$(CONFIG_ARCH_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
> index c281f711fdf..ac5d3f03f05 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -22,6 +22,8 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include "sdram_soc32.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -193,24 +195,6 @@ static int sdram_is_ecc_enabled(void)
>   		  ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>   }
>   
> -/* Initialize SDRAM ECC bits to avoid false DBE */
> -static void sdram_init_ecc_bits(u32 size)
> -{
> -	icache_enable();
> -
> -	memset(0, 0, 0x8000);
> -	gd->arch.tlb_addr = 0x4000;
> -	gd->arch.tlb_size = PGTABLE_SIZE;
> -
> -	dcache_enable();
> -
> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
> -	memset((void *)0x8000, 0, size - 0x8000);
> -	flush_dcache_all();
> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
> -	dcache_disable();
> -}
> -
>   /* Function to startup the SDRAM*/
>   static int sdram_startup(void)
>   {
> @@ -735,8 +719,15 @@ int ddr_calibration_sequence(void)
>   	if (of_sdram_firewall_setup(gd->fdt_blob))
>   		puts("FW: Error Configuring Firewall\n");
>   
> -	if (sdram_is_ecc_enabled())
> -		sdram_init_ecc_bits(gd->ram_size);
> +	if (sdram_is_ecc_enabled()) {
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +		sdram_init_ecc_bits();
> +#else
> +		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
> +		puts("ECC is enabled.\n");
> +		hang();
> +#endif
> +	}
>   
>   	sdram_size_check();
>   
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 1c3c70ea8ae..9c58e4355ae 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright Altera Corporation (C) 2014-2015
>    */
> +#include <cpu_func.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> @@ -19,8 +20,9 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
> -
> +#include <linux/sizes.h>
>   #include "sequencer.h"
> +#include "sdram_soc32.h"
>   
>   #ifdef CONFIG_XPL_BUILD
>   
> @@ -566,6 +568,19 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>   	return temp;
>   }
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +	return !!(readl(&sdr_ctrl->ctrl_cfg) &
> +		  SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
> +}
> +#else
> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>   {
>   	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
> @@ -608,10 +623,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	/* setup the dram info within bd */
>   	dram_init_banksize();
> +#endif
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
>   	if (sdram_size != gd->bd->bi_dram[0].size) {
>   		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
>   		       (ulong)(gd->bd->bi_dram[0].size >> 20));
> @@ -626,8 +644,23 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	}
>   #endif
>   
> +	if (sdram_is_ecc_enabled(sdr_ctrl)) {
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +		/* Must set USEECCASDATA to 0 if ECC is enabled */
> +		clrbits_le32(&sdr_ctrl->static_cfg,
> +			     SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
> +		sdram_init_ecc_bits();
> +#else
> +		puts("DDR: Enable CONFIG_SOCFPGA_ECC_SUPPORT when SDRAM ");
> +		puts("ECC is enabled.\n");
> +		puts("DDR: Without scrub, false ECC errors may occur.\n");
> +		hang();
> +#endif
> +	}
> +
>   	/* Sanity check ensure correct SDRAM size specified */
> -#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK) || \
> +	IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
>   	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
>   	    gd->bd->bi_dram[0].size) {
>   #else
> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
> new file mode 100644
> index 00000000000..982d321af74
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#include "sdram_soc32.h"
> +#include <string.h>
> +#include <hang.h>
> +#include <linux/sizes.h>
> +#include <cpu_func.h>
> +#include <watchdog.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
> +#include <asm/arch/reset_manager.h>
> +#endif
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define PGTABLE_OFF	0x4000
> +#define PGTABLE_RESERVE (PGTABLE_OFF + PGTABLE_SIZE)
> +
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +static void socfpga_prepare_watchdog_for_long_op(void)
> +{
> +#if !IS_ENABLED(CONFIG_WATCHDOG) && !CONFIG_IS_ENABLED(WDT)
> +	/*
> +	 * No watchdog driver is active in U-Boot. The bootrom or a
> +	 * previous boot stage may have left L4WD0 running. Assert and
> +	 * deassert its reset to stop it before the long ECC scrub,
> +	 * preventing a spurious watchdog reset during DDR init.
> +	 */
> +	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +#endif
> +}
> +
> +/* Initialize SDRAM ECC bits to avoid false DBE */
> +void sdram_init_ecc_bits(void)
> +{
> +	u32 start;
> +	phys_addr_t start_addr;
> +	phys_size_t size, size_init;
> +
> +	start = get_timer(0);
> +
> +	start_addr = gd->bd->bi_dram[0].start;
> +	size = gd->bd->bi_dram[0].size;
> +
> +	printf("DDRCAL: Scrubbing ECC RAM (%lu MiB).\n",
> +	       (ulong)(size >> 20));
> +
> +	if (size <= PGTABLE_RESERVE) {
> +		printf("DDRCAL: Error: DRAM size %#llx smaller than scrub reserve %#x\n",
> +		       (unsigned long long)size, PGTABLE_RESERVE);
> +		hang();
> +	}
> +
> +	memset((void *)start_addr, 0, PGTABLE_RESERVE);
> +	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
> +	gd->arch.tlb_size = PGTABLE_SIZE;
> +	start_addr += PGTABLE_RESERVE;
> +	size -= PGTABLE_RESERVE;
> +
> +	dcache_enable();
> +
> +	socfpga_prepare_watchdog_for_long_op();
> +
> +	while (size > 0) {
> +		size_init = min_t(phys_size_t, (phys_size_t)SZ_1G, size);
> +		memset((void *)start_addr, 0, size_init);
> +		size -= size_init;
> +		start_addr += size_init;
> +
> +		/* Service DM watchdog cyclic callbacks */
> +		schedule();
> +	}
> +
> +	dcache_disable();
> +
> +	printf("DDRCAL: SDRAM-ECC initialized successfully with %u ms\n",
> +	       (u32)get_timer(start));
> +}
> +#endif
> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
> new file mode 100644
> index 00000000000..2cfc583b5f5
> --- /dev/null
> +++ b/drivers/ddr/altera/sdram_soc32.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#ifndef	_SDRAM_SOC32_H_
> +#define	_SDRAM_SOC32_H_
> +
> +#if IS_ENABLED(CONFIG_SOCFPGA_ECC_SUPPORT)
> +void sdram_init_ecc_bits(void);
> +#else
> +static inline void sdram_init_ecc_bits(void) { }
> +#endif
> +
> +#endif /* _SDRAM_SOC32_H_ */


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

