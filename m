Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C74C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBC6838D7;
	Wed,  8 Jul 2026 06:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="bmFH4gR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748CD84A12; Wed,  8 Jul 2026 06:38:31 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D199B80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8PiY4AL7SjXSqvMe4OWeKekpbioJ9b4+1HNx6pmEI1kPl0Q+E8e4r+2zpZP4Xo455P4S4Ymcvlo47ps5d7j4iUOsDeJnYAFyc7Vvvj74Nf+MM/a2I4lCnMvNo3jjgzaYz8rn9/gKSHRGPuorFBQLF5HcLQ/uHlAgLt26/WDn7LTP/NBuQQ/ckiDZfU/2tKDDY7LEeVFC3ixJskVX3g1DhTp2J/ko8aSZa1hB/4b/QJydi1jEXcEeeYK9pYokyZodsiPCaYIk+JJEIcBRzLpZdJC4hs274w7FUOgc5bPDcPzsvLjsiH2QB2XRFdLzQI/3f4uXltgxOKaKS9j+EPB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgNmBR/7QXcdiDOcqOsnnGG/MaynJEbY8DcRWrT7UaA=;
 b=qV7OcKeYDHV3s28yz7AR5q4spcorGVS3twPfOZXXoZSlreaJQixKc4afjqKfcNDK54y04zL0HzU1/fj3rF9/A2UJKjFSaPArJmtQKU54dMWzQu5R/ROS6H8AFeeGPI6CCPqyR7Yeal7STnEawpu/9LIpI6dA34u8wtduswJiqNFKUQgKD5iVaSUgspEo7DW3ukz4rZ44u7KTH4ng4Q8Agyr34f8ikOj9cmLbkL8gLVVxdwB8U9JlMFPkSMlwJX0p3wu+x10L+pnjp4TZZ7n1lq5KN78VPBZ2hVy4TTvsFVEY5tw3LVvzD0QID9ukzko5cYGcSvID3+W5ki2WadN9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgNmBR/7QXcdiDOcqOsnnGG/MaynJEbY8DcRWrT7UaA=;
 b=bmFH4gR54OUklZhsXQY5gdQaG+hj8r6Qg4p1uxeaLuUwUMBezHD+t/W0oMZjx7vpcGJek8/TU3zPdtVjjO5xkns7535CqY8FAfwvctnshzUmqe3kQoJOKw5vivhIZq0oZu94NSrOe0ULt6YSAYdNXc0DVi9asBO9SFTvq6N5YBdfW+dx08+A+knJqYixC7dKRpXTTBTYKVS8e+R1fcRr6KCBp0VS+L4hF9PqQw8koZ4QOKhWmF6p8YMKWoUy85tIbbRmqt0BsyVPlSUCJkBmihfZgHBv6ebiiA6p+DPToTpe3WmCNsnJQz81tgWR/QqPZm88qvRcIgxSbOUpltYhOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:38:25 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:38:25 +0000
Message-ID: <21d8a0b9-2d2e-4ff5-8af8-7676e2c08413@altera.com>
Date: Wed, 8 Jul 2026 12:38:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] arm: socfpga: n5x: switch firewall setup to driver
 model
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-6-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-6-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb4ebeb-2016-4f49-1c3a-08dedcaabf4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: gdzOuLH1fHP5Z2yMJKWjCjmYlG1zHtBgUBG57f87/dWXid4omEWGZ78962Iie0KOXepYuAKxuih5MMEkJi0iqRi5KV4ABrlhCN2CclDQ3lfPxyknD7kIgeP9ggcbgsF/TdHJw6DcKKDnD28mAPfAGsg2jobJ51WylCJroicN3B3OUHln2xyLUt+M0RlRtz5NzFmQbs1kbof0EYqV6IvZmQl50v+JQQ95hOdZxA1GFGW/QEtuH5FeMRzSl1E48kGi+WMMQE3q/5eidcMmdqf4TQmksNgJDzwaFVmZ3CCSXHQfAIRl5iVDuoCMFH+/C+w6VYnFeft8awoOmn3pmuY3C3E9cWS1CbgH5m9ZYjwZn+mwY1zp++uqy2kWr1/yJ3rfMznwnjSeYr+PA7Dws1z8XR7rAoce7p4rkF92cSxhnrFn0tMYJ1zbLyaFoPxI3PKIehByCUu2HTUpuxjnEW//nmijMRDAqtnCZdcJbaeifOrL72T0Uk86KXxQA8z36VZv7rEdt4ZjLW+YjQltsJJ9JeLW+ew0yVsesph5MHcULzEKv1+5k2vF17P28etYrxNQEZAlp7Bzr+tQ+jC6Rdv6GcvEoVPrYPB0EYCerPkoHho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5iaVpFdWFtQ0RnN2JlajcrdllvMjZpMW9Jb3k1YUx2SCt5SFdSZy9PdTJG?=
 =?utf-8?B?aDZjb2orOFB4K1V6VG1OR0hRb1ZQaE1VNlhmTURRMEpFenhoRlE0OE9tWlFW?=
 =?utf-8?B?OFVEZHhIRmM0dkgrV2MxMTlEK0N0QlpzQmZsZFRrcGdCZVV2UEFma3hTeCtR?=
 =?utf-8?B?Vlp5Rk5pamMwRVJYeFJYMjFsNXJwa1BnemR1OUR4NWRBOUlhNk55MVF0bzlF?=
 =?utf-8?B?NGJJenJsdnIrdCtiRDRzbmE4NDcvbkZpTjFjYU8ycUcvNGphSGVETWRFSnNS?=
 =?utf-8?B?cWJuVHNqbUxFLzErYU9MalYwMTV2VGtBSFRKNEYyQzhIcmxRWmlVQ04wVkVZ?=
 =?utf-8?B?WGNuRTJqU3RBeHpTd2ZyQi96bnZnMkg5LzRnSEdLbEdnTXZpWDJQTTFpam5H?=
 =?utf-8?B?VGRacmVPb2grWnhaWFRQRExnMnBhVHUwYVhOeE9tS04vYnRKOU1EbDFPeHNh?=
 =?utf-8?B?QTJhUGQ0Mjc0eXZpM2o3V2V6VEtRcDkvd0g1UXhPY0swb203cDJ1VTRYcWRx?=
 =?utf-8?B?SDIzd2pweFhpdVh3ODBWS3c0OHl5blhNNHp5LzRGSkw5SlUweURieFV4UEdR?=
 =?utf-8?B?RFlEU09hV0VYNXN3UzYrWUtzY08zSjlEVWNKb3RRWWpyYmpOWkRRYmp3OWcw?=
 =?utf-8?B?NFdxQ1hsQjJJMUFZWTQyOE9QcWswd2VyMU5PRWJ3b0QrSVZ6WU9hZjhMQitW?=
 =?utf-8?B?alU4Y05ZQmlLaTJiQU42WEYzR2NuYU5DdExtN2p1NWtvOVlFalRjTXFaRHRz?=
 =?utf-8?B?OHBJSitQZ2gxbm82Z2FxL3BnV3l0UWR2bXBwbWpSNVJ6WXhCUFl5QVlLRlVY?=
 =?utf-8?B?NHBwTGZvZHg3UzgvWDViTFJNZ1BpWHBEWStMVGlvWEhVNXNNdmh2M2ZPS0N1?=
 =?utf-8?B?ZEFhZU0rNi95Q3AxeGVIZXFjeXRManM4OFAzY2J4Tjg4aXhvWGh1WXJBL1ht?=
 =?utf-8?B?Z3grNWk3eW41cm1RKzlDcmI3WEZweGwxSENSOEd3WWdackhhMEFpZm5rRFlx?=
 =?utf-8?B?Vk42WHJsVmFNMXcwdGJQbGoyVzJaUE5zWnJycWg1bHd3YUswWWE0REN6ck8y?=
 =?utf-8?B?dGxITkdkTUpOK3hndjlvdkRyZDFsc21uWnhJbmEzZVI1bFN2OXlwRTJCamMy?=
 =?utf-8?B?YXdhc3BVU2FnOUM3eXl3aERWUkxGVUNWckVrWGV2V1ErOUtWSnE5VG0wK1Bt?=
 =?utf-8?B?MG1wMjdRVHhJQ0h1ZDJwUzJubzBNSThiOGozRWVFandGS2tOd1JnQjJjMnc2?=
 =?utf-8?B?WCtoR1ppS0FaTGdFQzJnRUhOaElLRVRMeDM2azdmTEFqUHI3OFlIK2VCQkxU?=
 =?utf-8?B?TUVCNlAxZjM5TEJCRW51QWp1VER1OW54NmZhWi9PWEIzTGtJZ25uaGcxdzZl?=
 =?utf-8?B?L1lWeG9nZERmaHkyUFRFSGVkZ0ZSNnNBdTM4aXZrMzdyMmQ3Y0xvWC9ERFli?=
 =?utf-8?B?UGpOWG5JakE2MlZRbFM3VTh3MktzVDlBUjYyeFpERlBwSzltakhGSjdMN25R?=
 =?utf-8?B?WCs0ckRhVFhkNVpxVmdubWdxTXVCSDJIdVl4cGdYOUJSTnhNWnllVUhjMjAr?=
 =?utf-8?B?ZmpEc09mQkRVTW5ubmNkZXZ0T2o2NU51K2E4K2xsOUlzaURjMjY2YU52VUdN?=
 =?utf-8?B?eDNTOUNMb0I3dmNpUVBLZjZ3L3FMaE9WdWlmRFBlZUNDTEdrcXhRTDVWWlAy?=
 =?utf-8?B?Tk9CVlZsUzIxeWg2L1lhYllsTzI3cjd3TUwrL0kwZTRuU3Y3Y0pwT0hLUGtx?=
 =?utf-8?B?OVpoQWdkOTIvL2xEMk5KYlRLRlhiTW1USWdnbFpqREJVQklmSEtId3dHOTBy?=
 =?utf-8?B?ekdvL0tYamNXS09PL3U4SWVKaWFKZVhFWHJCN1ozUzRCN0hXbUxBem9JL09L?=
 =?utf-8?B?bzdzT2RDSWZFdUNRSkJiZjBNTk40a0hjRG9kOWM3TkVSb3VNNkQ3bWU3emNj?=
 =?utf-8?B?TjFvYkZ2clQ0K2I4N2Z3MU5MQjhYTkJjTHRUNitObjA4VmVhNXZySnZ1N2VE?=
 =?utf-8?B?dXdRb1pPNXB6cm1KdS81WWV2K2tlb0d1M1RQdVRwTXFDL0ZENmRTb29wTjFV?=
 =?utf-8?B?NHp4ZXZqZnkwUS9mdGFQd2t5b21NWUtkN1UwT2xIK0F4ZmdFd2hDVUpGOHJV?=
 =?utf-8?B?cDZheW5vUWtIbHd0RHMrZzkrN0UwUXpWM1VzQkdVbXBnb3ZJL2R1ZmZuTGJm?=
 =?utf-8?B?aEUvLy9tRWZNaEZvS1RTbU5Qb2h0TXdBeTgzTDlFNDZSaTBOa25ocTNGbEJF?=
 =?utf-8?B?dW1UQ0FGczBCanFKTEZBR0pMM3dyMHlmZ2JYN09vZzlONjhrTlE1L3l5UW55?=
 =?utf-8?B?NEZIZXNsRFVrL3JPWGYrR0JtN1IyL3cxSW9Pb2VXZzBuQVlTWEpwZ0tLWms1?=
 =?utf-8?Q?nhL6ETubrLNuiRXc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb4ebeb-2016-4f49-1c3a-08dedcaabf4a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:38:24.9405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSGIOK2boyrUa4+Nj8wZcQCvodV9U9fyqRvZZj/FkjY7DYNyJEMFuajAr1DVuscQhuWWdd9BHd2Zy7j0MhdlWw9L47r6y0j0vqakJFnKIHs=
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
> Move the system manager and L3 interconnect firewall configuration from
> a dedicated firewall_setup() function to the driver model, using
> uclass_get_device_by_name(). This removes hardcoded firewall setup in
> SPL and relies on the driver model, making the code more maintainable
> and aligned with upstream practices.
>
> With spl_n5x.c migrated, no in-tree SoC64 SPL file calls
> firewall_setup() directly any longer. Remove the function and its
> private helpers from firewall.c, drop firewall.c from the Makefile,
> remove the now-unused declaration from firewall.h, and drop the stale
> firewall.h include from spl_n5x.c.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>
> Changes in v3:
> - Extend to fully remove the now-dead firewall_setup() implementation:
>    delete arch/arm/mach-socfpga/firewall.c, remove firewall.o from
>    Makefile, remove the void firewall_setup(void) declaration from
>    firewall.h, drop the now-unused struct socfpga_firwall_l4_per,
>    socfpga_firwall_l4_sys, FIREWALL_L4_DISABLE_ALL, and
>    FIREWALL_BRIDGE_DISABLE_ALL from firewall.h, remove stale
>    #include <asm/arch/firewall.h> from spl_n5x.c
>
>   arch/arm/mach-socfpga/Makefile                |   1 -
>   arch/arm/mach-socfpga/firewall.c              | 107 ------------------
>   arch/arm/mach-socfpga/include/mach/firewall.h |  69 -----------
>   arch/arm/mach-socfpga/spl_n5x.c               |  13 ++-
>   4 files changed, 11 insertions(+), 179 deletions(-)
>   delete mode 100644 arch/arm/mach-socfpga/firewall.c
>
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index 962dce67c64..5e57d23657c 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -114,7 +114,6 @@ obj-y	+= wrap_pinmux_config.o
>   obj-y	+= wrap_sdram_config.o
>   endif
>   ifdef CONFIG_ARCH_SOCFPGA_SOC64
> -obj-y	+= firewall.o
>   obj-y	+= spl_soc64.o
>   endif
>   ifdef CONFIG_ARCH_SOCFPGA_ARRIA10
> diff --git a/arch/arm/mach-socfpga/firewall.c b/arch/arm/mach-socfpga/firewall.c
> deleted file mode 100644
> index 4dec47b8e96..00000000000
> --- a/arch/arm/mach-socfpga/firewall.c
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
> - *
> - */
> -
> -#include <mach/base_addr_soc64.h>
> -#include <asm/io.h>
> -#include <asm/arch/firewall.h>
> -#include <asm/arch/system_manager.h>
> -
> -static void firewall_l4_per_disable(void)
> -{
> -	const struct socfpga_firwall_l4_per *firwall_l4_per_base =
> -		(struct socfpga_firwall_l4_per *)SOCFPGA_FIREWALL_L4_PER;
> -	u32 i;
> -	const u32 *addr[] = {
> -			&firwall_l4_per_base->nand,
> -			&firwall_l4_per_base->nand_data,
> -			&firwall_l4_per_base->usb0,
> -			&firwall_l4_per_base->usb1,
> -			&firwall_l4_per_base->spim0,
> -			&firwall_l4_per_base->spim1,
> -			&firwall_l4_per_base->emac0,
> -			&firwall_l4_per_base->emac1,
> -			&firwall_l4_per_base->emac2,
> -			&firwall_l4_per_base->sdmmc,
> -			&firwall_l4_per_base->gpio0,
> -			&firwall_l4_per_base->gpio1,
> -			&firwall_l4_per_base->i2c0,
> -			&firwall_l4_per_base->i2c1,
> -			&firwall_l4_per_base->i2c2,
> -			&firwall_l4_per_base->i2c3,
> -			&firwall_l4_per_base->i2c4,
> -			&firwall_l4_per_base->timer0,
> -			&firwall_l4_per_base->timer1,
> -			&firwall_l4_per_base->uart0,
> -			&firwall_l4_per_base->uart1
> -			};
> -
> -	/*
> -	 * The following lines of code will enable non-secure access
> -	 * to nand, usb, spi, emac, sdmmc, gpio, i2c, timers and uart. This
> -	 * is needed as most OS run in non-secure mode. Thus we need to
> -	 * enable non-secure access to these peripherals in order for the
> -	 * OS to use these peripherals.
> -	 */
> -	for (i = 0; i < ARRAY_SIZE(addr); i++)
> -		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
> -}
> -
> -static void firewall_l4_sys_disable(void)
> -{
> -	const struct socfpga_firwall_l4_sys *firwall_l4_sys_base =
> -		(struct socfpga_firwall_l4_sys *)SOCFPGA_FIREWALL_L4_SYS;
> -	u32 i;
> -	const u32 *addr[] = {
> -			&firwall_l4_sys_base->dma_ecc,
> -			&firwall_l4_sys_base->emac0rx_ecc,
> -			&firwall_l4_sys_base->emac0tx_ecc,
> -			&firwall_l4_sys_base->emac1rx_ecc,
> -			&firwall_l4_sys_base->emac1tx_ecc,
> -			&firwall_l4_sys_base->emac2rx_ecc,
> -			&firwall_l4_sys_base->emac2tx_ecc,
> -			&firwall_l4_sys_base->nand_ecc,
> -			&firwall_l4_sys_base->nand_read_ecc,
> -			&firwall_l4_sys_base->nand_write_ecc,
> -			&firwall_l4_sys_base->ocram_ecc,
> -			&firwall_l4_sys_base->sdmmc_ecc,
> -			&firwall_l4_sys_base->usb0_ecc,
> -			&firwall_l4_sys_base->usb1_ecc,
> -			&firwall_l4_sys_base->clock_manager,
> -			&firwall_l4_sys_base->io_manager,
> -			&firwall_l4_sys_base->reset_manager,
> -			&firwall_l4_sys_base->system_manager,
> -			&firwall_l4_sys_base->watchdog0,
> -			&firwall_l4_sys_base->watchdog1,
> -			&firwall_l4_sys_base->watchdog2,
> -			&firwall_l4_sys_base->watchdog3
> -		};
> -
> -	for (i = 0; i < ARRAY_SIZE(addr); i++)
> -		writel(FIREWALL_L4_DISABLE_ALL, addr[i]);
> -}
> -
> -static void firewall_bridge_disable(void)
> -{
> -	/* disable lwsocf2fpga and soc2fpga bridge security */
> -	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_SOC2FPGA);
> -	writel(FIREWALL_BRIDGE_DISABLE_ALL, SOCFPGA_FIREWALL_LWSOC2FPGA);
> -}
> -
> -void firewall_setup(void)
> -{
> -	firewall_l4_per_disable();
> -	firewall_l4_sys_disable();
> -	firewall_bridge_disable();
> -
> -	/* disable SMMU security */
> -	writel(FIREWALL_L4_DISABLE_ALL, SOCFPGA_FIREWALL_TCU);
> -
> -	/* enable non-secure interface to DMA330 DMA and peripherals */
> -	writel(SYSMGR_DMA_IRQ_NS | SYSMGR_DMA_MGR_NS,
> -	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA);
> -	writel(SYSMGR_DMAPERIPH_ALL_NS,
> -	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_DMA_PERIPH);
> -}
> diff --git a/arch/arm/mach-socfpga/include/mach/firewall.h b/arch/arm/mach-socfpga/include/mach/firewall.h
> index b47b577ae75..8f3b7d90ad1 100644
> --- a/arch/arm/mach-socfpga/include/mach/firewall.h
> +++ b/arch/arm/mach-socfpga/include/mach/firewall.h
> @@ -10,73 +10,6 @@
>   
>   #include <linux/bitops.h>
>   
> -struct socfpga_firwall_l4_per {
> -	u32	nand;		/* 0x00 */
> -	u32	nand_data;
> -	u32	_pad_0x8;
> -	u32	usb0;
> -	u32	usb1;		/* 0x10 */
> -	u32	_pad_0x14;
> -	u32	_pad_0x18;
> -	u32	spim0;
> -	u32	spim1;		/* 0x20 */
> -	u32	spis0;
> -	u32	spis1;
> -	u32	emac0;
> -	u32	emac1;		/* 0x30 */
> -	u32	emac2;
> -	u32	_pad_0x38;
> -	u32	_pad_0x3c;
> -	u32	sdmmc;		/* 0x40 */
> -	u32	gpio0;
> -	u32	gpio1;
> -	u32	_pad_0x4c;
> -	u32	i2c0;		/* 0x50 */
> -	u32	i2c1;
> -	u32	i2c2;
> -	u32	i2c3;
> -	u32	i2c4;		/* 0x60 */
> -	u32	timer0;
> -	u32	timer1;
> -	u32	uart0;
> -	u32	uart1;		/* 0x70 */
> -};
> -
> -struct socfpga_firwall_l4_sys {
> -	u32	_pad_0x00;		/* 0x00 */
> -	u32	_pad_0x04;
> -	u32	dma_ecc;
> -	u32	emac0rx_ecc;
> -	u32	emac0tx_ecc;		/* 0x10 */
> -	u32	emac1rx_ecc;
> -	u32	emac1tx_ecc;
> -	u32	emac2rx_ecc;
> -	u32	emac2tx_ecc;		/* 0x20 */
> -	u32	_pad_0x24;
> -	u32	_pad_0x28;
> -	u32	nand_ecc;
> -	u32	nand_read_ecc;		/* 0x30 */
> -	u32	nand_write_ecc;
> -	u32	ocram_ecc;
> -	u32	_pad_0x3c;
> -	u32	sdmmc_ecc;		/* 0x40 */
> -	u32	usb0_ecc;
> -	u32	usb1_ecc;
> -	u32	clock_manager;
> -	u32	_pad_0x50;		/* 0x50 */
> -	u32	io_manager;
> -	u32	reset_manager;
> -	u32	system_manager;
> -	u32	osc0_timer;		/* 0x60 */
> -	u32	osc1_timer;
> -	u32	watchdog0;
> -	u32	watchdog1;
> -	u32	watchdog2;		/* 0x70 */
> -	u32	watchdog3;
> -};
> -
> -#define FIREWALL_L4_DISABLE_ALL		(BIT(0) | BIT(24) | BIT(16))
> -#define FIREWALL_BRIDGE_DISABLE_ALL	(~0)
>   
>   /* Cache coherency unit (CCU) registers */
>   #define CCU_CPU0_MPRT_ADBASE_DDRREG		0x4400
> @@ -149,6 +82,4 @@ struct socfpga_firwall_l4_sys {
>   	writel(data, SOCFPGA_FW_MPU_DDR_SCR_ADDRESS + (reg))
>   #endif
>   
> -void firewall_setup(void);
> -
>   #endif /* _FIREWALL_H_ */
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index a49be837921..0a8dd6d0fee 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <asm/arch/clock_manager.h>
> -#include <asm/arch/firewall.h>
>   #include <asm/arch/mailbox_s10.h>
>   #include <asm/arch/misc.h>
>   #include <asm/arch/reset_manager.h>
> @@ -69,7 +68,17 @@ void board_init_f(ulong dummy)
>   	print_reset_info();
>   	cm_print_clock_quick_summary();
>   
> -	firewall_setup();
> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
> +	if (ret) {
> +		printf("System manager firewall configuration failed: %d\n", ret);
> +		hang();
> +	}
> +
> +	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
> +	if (ret) {
> +		printf("L3 interconnect firewall configuration failed: %d\n", ret);
> +		hang();
> +	}
>   
>   	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
>   	if (ret) {


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

