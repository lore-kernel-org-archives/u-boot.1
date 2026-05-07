Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C999CCD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 08:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4608468B;
	Thu,  7 May 2026 10:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="N7oA2Wau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E02D84A29; Thu,  7 May 2026 10:37:30 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FD584687
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 10:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvH3iyhGTazUTo/2AWDchZjUuW5R6aOWGEcQMzUErvCyfs7Ezq8yOJk6Udixk/4brFLaipkDVNIRlJOTidlP0wKgfBHxeAJTKsKKJyupnhUHI0u4GwKhyBR/m2xPezIZFY+HopTREh7APFjuLd4y0nalUzJ1a5f5+ASkYwIOP1HsuqlLaHwR6ZKYA4XBgisdNKoMrh8RUxUZL/emZ1fD/EMBLc87PQSVTgW3e/w6Zq6Qj3hefAOHFTlL1AfjL80rOiscQppNbXEzaWCHC8ps04Ae5FEzrFC74Z1b+G9J5sFsAErTWGP5gv58jckBJq3GgbnLRcVOjMsFAK589UCXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1Xh+Ij7W4FXVcMh0uFzCJcIEmkgR7Zgpy88ZG0UMP4=;
 b=vWt2NV3ROS0IIiYqrGC7QvOiBCw9WtX/8iciHX3JSnQCN7OxsPO3MAyeOwUFRGAd75lnwl9V/UWwPZAqyjWzJfLeFQ7nyvMohRzRuaFu7l2VlJTPdDLt1zKEEK3D3MrHERaRlCHVd4A8j534Ycf409/fJDw5EKFTJlqyX3SWHRlMguN8BqWJCX6enezz5AY8Xhcd4HwaFjYMUhL4Q7bzikc3OdGKPOhj/EnfO7eWLqYAhZIvhdyTvn7Brb8cHJcG72sqD4Wyu2G8GXc/zHgqUabdVnvT5ZggFcKHYUMhzNvuP53mTgu6qL0AiX/Fak70d0nu7eMRQ1oFqeioi2bLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1Xh+Ij7W4FXVcMh0uFzCJcIEmkgR7Zgpy88ZG0UMP4=;
 b=N7oA2Wauyj6NQlATNouxMTIddoG/eH2OigXevwTTgtWacEBI+ndwL/sQA1BWfZcQooRbU6LmmgTstOB/1zanf2aJEIoPs4vXdjuQLcR1NRQQ3DFxLkhgGaVAabFnnYi0JuVRwhd3OqPBJvVfmgnNJrpgIin8YxWav/G1ugWBALIx7B5l4mnXlJy0n9WXZ3IVp0JzObBaWP4h3ekwN1OH17AtN6vmX0BKjXl4ULrVu9jDR5rng3tdBtlyOXxqOUwwFXaj7PTCU1xTiHS+vF3bN85OsfEPP3qgPq7Ltx3vs7ZW2AdV8p/tLNjgxyaqwo1zVbhjFoklhnFnMvE+UotSiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6911.namprd03.prod.outlook.com (2603:10b6:8:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:37:23 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:37:23 +0000
Message-ID: <cde9444b-1f01-4932-be46-d751e347379c@altera.com>
Date: Thu, 7 May 2026 16:37:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260428034822.23756-1-alif.zakuan.yuslaimi@altera.com>
 <20260428034822.23756-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428034822.23756-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DM4PR03MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: f83565b5-cc2a-43bf-1042-08deac13dc3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|13003099007|56012099003|3023799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 6P5HF58DoKVUcxbw9huk7kQhpxOJEdjqrm1tlGZ/t4rDdQy37Lg9MhacsJHpypCQ6TPPefMKeCDBkN3Up1vGjmt2SKuSPoer88lxlGn+30m4K9QDC5En3J0IKA1+QOppabIKxuO5PeZeqV+zsFAycdL2FuyGIoXy1ET44EX2zzAtpUzxR7NZJOhYrK81JmDXAbOMq2a8EA0RcvpBU26M5wgkG4NxH5CBT8DMJsHSwgU3m+DSC1Xe8ehpJm3rmyIEdMbaNruOzigj7PK+hpDZBQoIIoQizJ8rgR+bUgrc+EH3BZSbe9yG65MQ7KAFk+y2DzSZFFoC8j2f1MnDqekOauvoKcKnOTWSzQ1rRfHw6CVcVY9uMmVFDSs1iTLLiGGPD2V8dtyQGkCxTRFT6DyI3oOCkg1/cqEkKuy+WMH7ui+mOWBxj/WeyQTWVmV17cWrU7+9uQpHq5meLTiK5S7pMbxbKfvEJjgS4cz3TfkK2HWKxJmtNH3wALDviKhEbigImAMpHla8loohwlhucYWQfV/rbZUl3eZG78MLHPog+eDswZUB+Iirt5HGXdFDWKhHqfCcpvMCThZi/nwqJbIb9RpDaXLU/TsmKxbQrDh4ZBTFMK0ybXRDKf5IeUkwZJdrVOczhQ8LQ1wmQmruvkyT+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007)(56012099003)(3023799003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3F4dnFCc0Y1ZzE1QnppcE44MmJtNkhnYVM2Rlozemp4Y2crUWxBd3ovN2tk?=
 =?utf-8?B?clM5NmlvZ3B1cmJPVkthMi9nampUU29MNHcvSEdUZm1xbGZjN0NIbzBXK3JM?=
 =?utf-8?B?My95SVVKZmtMaU4xRmd3cFM2Z3JXNTRDUlVpWXVhTEgvRkx3YXFScTI1K1lC?=
 =?utf-8?B?K2FSaktxODVNNDNVYlVCT1E5NnkxNXZHNHFCNjh1eGtsclpNNW1MN2JTWWEv?=
 =?utf-8?B?SXpxUDRLQVNVZzdQdkU5d0JDTHBaQndGaWIzTUZCclIzN1Vnb2tpQU9oeG1J?=
 =?utf-8?B?dHdzcllQZU5YcmV3c2xTbndWa3lsYVNQOUxJcnZNbmpzZWtPSC9KYTRVZnFI?=
 =?utf-8?B?VzJxWkxOR0pzenh0QXZleHZSWUphRWFiQ0Q2dW5ybDFBRXI1MjlWaEJ5Sis1?=
 =?utf-8?B?eVUxVXhoanN4NmoraUxScS8rNmdpdkpsdWljeGNPd1M4Ykl1UUhjcDFtQTNM?=
 =?utf-8?B?cHUveVpZN0pmOTIwWms1VnByYm50Sm5tUmRoM1Q2SnBNUWU3L0wxK29Ob1pE?=
 =?utf-8?B?YUxYR1ZmQWJLYnNoV2NDVGlJS1J6MXVoR216N01rdzZhTEE0QUNjWGNBZmxi?=
 =?utf-8?B?Z09RQU53TWxaQUpUd2JNTlZTYWhBVVRUbFlyV3dKVmhZc3hqaDJ5TlhhQTY0?=
 =?utf-8?B?TkZxQk5leVhxaDMrT1FpT042OTdTRWt6QnpydVE5TGxVMG5iM045eDlWWktB?=
 =?utf-8?B?aTN3VUo4U216b0UrSkE1L05wNTgyQXBxYWd0NHdPMHBHeFJ1bmFiN3NZSDZU?=
 =?utf-8?B?c0Zib1hBaCs0elIvbHRIZnlMaHNkR29PTElYKzFGREtmdUE4dkxvN3FDaWR0?=
 =?utf-8?B?ZXI4SVBkSlZMR25NMTY2aUZSNE5WVGszZzFVeG5QS0txd3h4dTU2N0RPSTg0?=
 =?utf-8?B?dVpwdDNOWlhJZ1RNTmlIVUtaSVhRci9zK2k3ck5sZDQ0NlJIODcyMEU1YXBK?=
 =?utf-8?B?cHZ0YURiVTU1NmxaV1d3UjRUa0ZrU1N5Z1FUS3lGaDZVNHlXNENlcHN2Sito?=
 =?utf-8?B?d2lsdGNUK05jT0NsVzh5REd2b0o2cjhaV2JNZzRTdzZyZzl6aHRIQU5sVFZy?=
 =?utf-8?B?VmdZQXBGWUJNVElYQ21NWnZmcHRnT1VUT3lGL1VKa3pxMTN2TFJkajRrU1BH?=
 =?utf-8?B?TElHcjVOZW5JOWd4d1F2SVNoTnF0T00zdUdpKzNVTEVoMFBOSkZWc3JTT2xD?=
 =?utf-8?B?Qm95NzlHOHB6QUYxZVA0ZHBsU3ZQK3k5NHRBMTNtc3FFRHZXZTN0WWRQUURP?=
 =?utf-8?B?RUYzVE53WVBpbUpScE42TXFxa0JCS0FERFV1c0dtUkRDUlpVTnhYMnJleHRi?=
 =?utf-8?B?TjBRWi96Y1dKcWZxMjFMdEs4bjNtS0U2bG5CWTRGWU5sMlJLWmVWTzNPMEpj?=
 =?utf-8?B?SC9lVU8rNWd5RjVncFY0ZHZIc01YYU11ZTR3RDl1TTdYeDZrcGk0Qit4ai90?=
 =?utf-8?B?WDkxNEt4V3pZaCtzdEZpNzFwWXpiV3BBNEdoYVVPZjJyT0tzWENMRWlNRXl6?=
 =?utf-8?B?MjhjcEFSRys2c09qZnd3K1phbzN6L1M0QTZ6R0tDNWFSOFR0RE95Zmk3dENP?=
 =?utf-8?B?dHVSck9BVkFYbEZmaEJvT1E5dEd6OTMvR3EzQzMwcjBzTjFkbndMbHB6ZW03?=
 =?utf-8?B?S3lKaGU1aElWYU84Y2N2bHJHTzFLNzFPSlZsYnV2NkkxYmRSUS9kYUU4Mnp1?=
 =?utf-8?B?STdvbzltcnNwbEgyRnFQYmtjTHBPWkJHU3JCdVV3NDZtY2dkWXFNTzlINWQy?=
 =?utf-8?B?QmpkQ3NwQ3JTM0xJTjRHT1BFbHJiZXZ5L1h0Vk9CWjd2YXVuYzdXVHhJaWFk?=
 =?utf-8?B?WnJ4M1RIYjdHSU8rM1pKTTRrdEZqMURKeUkwZ1AyMTA2dzc1TVBVRC9yMVNE?=
 =?utf-8?B?a0Q0ei8vbzN1Y2dIQzgvMWswanhCQUNVTno0bDlhcTJnS1F3eG1IbVlZTjdx?=
 =?utf-8?B?OXY5MHk4MzdWN3NTaWRtb21qUDgyUmloWnhVNEQ0a05xOHkrSTlFRnN0RXlC?=
 =?utf-8?B?NWJzd21FanJBSVY1a05ocXYrN05Ja3lIVDBsZmhvM0FiOTRYUHczOFJIQ3V0?=
 =?utf-8?B?QjFwSU1ra1BzdGpXcDR6Z1cxYWVWZldEUEVQK01ydWdWQzdrL0R2a1EzclhY?=
 =?utf-8?B?S3pKOUs1cWVoZXFqaDl5dnVpV3VWdGg3ZWxCZGcwV0lSRjQzbDZqS0RETW9X?=
 =?utf-8?B?emZWVkFuTnhXN1RhWkFoWStvcVZTTWgvRlVRUmNIS2JKVmJFY0RVTTRKeGhG?=
 =?utf-8?B?ZVNZZzBMZGNtZ2EzQk5WT09uY3F2T2lFRUcxbG54U3hBYWtobGVSK0NjWGk0?=
 =?utf-8?B?Mk5INE44UVIwK2pXTGRtWlRJcGlvK3kvNGpwalcrRlVnRUJGakN4SFMxTUM0?=
 =?utf-8?Q?cvIOqBxSpsvdakyI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83565b5-cc2a-43bf-1042-08deac13dc3a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:37:23.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaDzTjkLhAv3irVnCcjGRGEP5FtyvH9UIhyidwsC5MIcdy7WPmAsOb8bnZqJjIg+B0Vk+S7lHfEeMBSJaU/Tt82/DNXWayUTOJFHRxr3XEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6911
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


On 28/4/2026 11:48 am, alif.zakuan.yuslaimi@altera.com wrote:
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


Please add the change log for each version.


>   arch/arm/dts/Makefile                         |   3 +-
>   arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 158 +++++++
>   arch/arm/dts/socfpga_stratix10.dtsi           | 430 ------------------
>   .../dts/socfpga_stratix10_socdk-u-boot.dtsi   | 143 +++++-
>   arch/arm/dts/socfpga_stratix10_socdk.dts      | 143 ------
>   configs/socfpga_stratix10_defconfig           |   3 +-
>   6 files changed, 286 insertions(+), 594 deletions(-)
>   delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
>   delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index bff341d6118..2832123218f 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -460,8 +460,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
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


make dtbs_check (Linux dt-validate) will flag it as a schema violation 
since memory nodes must not define #address-cells / #size-cells because 
no child node according to the dt spec.

Remove both properties from the memory@0

[...]


> diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> index ef0df769762..da19943ec3b 100644
> --- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
> @@ -3,47 +3,154 @@
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
> +
> +	fdt-2 {
> +		description = "socfpga_socdk_emmc";
> +		type = "flat_dt";
> +		compression = "none";
> +		fdt_2_blob: blob-ext {
> +			filename = "dts/upstream/src/arm64/altera/socfpga_stratix10_socdk_emmc.dtb";


This file is absent. Binman references 
dts/upstream/src/arm64/altera/socfpga_stratix10_socdk_emmc.dtb.

If those source DTS files do not exist in the upstream tree, binman 
fails with a file-not-found error at image build time


Best regards,

Tien Fong

