Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A7C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 07:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CDE87B9E;
	Tue, 23 Jan 2024 08:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="og+fGCwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00E287B36; Tue, 23 Jan 2024 08:53:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897DA879B2
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 08:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmoI/5RhSf4JVc43AD3likBcO0rmRf1rO6z5sCMIKzisdDrlKhjqwzOWYLVxe6q2+DYsBTdkS7ZkP1a3J4ZHWAzQTzkkP+h7uwIIUbAx9yiCaOHmY3LZd/EfSofavIODF8ffiB5MBR7+SJKkkDjMFCar2G/5uTyETeJHry12V3+4hZMGc725SL2D6IC53Wpp8k5j/gZexTmW2H5U8w6GZZ0d5dacigbHRRHIsbzV0PQbusMDEx5/TjgnxIMD64mbdHQDd58BHBR1F5K5JjWxUTxgXDJCQzwyXijROSZDSLaUoYtfIV6obrpA7vFKkriGml+SHSNwQGrxH+ws6gNbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuXDtPAG74GIMTGH4ugUsM4t7xDx1B7AkIfqqgKkquQ=;
 b=NsUBusLBsnmBwAPovlfNJd4uI3Xi0a0LfzLxi9uD0oQmmkt/YPR2GesipTWFZ/qANqYQ6GI0C9xld8SzvJLKzkjvP7DJT85dJsMJnuFKy1uqwIdNhFm/6J+53V6PeasNq53YKOXkbHROTFpWZZ+s9BacbW44xfkak6U7glcJkffRm/rj3IBWWBkxUNiWN0bthyCev4QuUPQQt1Q1H5lkn6uzV930L2CF8tUx9CJmMhb/qyDFeeKGG7/qgkglQMPwfwN6zP7WqwtI8ZHG88QfjqRZ1bGHPELdzS8RYsLxzp5Z522TgqVwqn6YXQL82obpwqc5e2hRGSi6ND5X63Whag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuXDtPAG74GIMTGH4ugUsM4t7xDx1B7AkIfqqgKkquQ=;
 b=og+fGCwkcAp5aRaqFv1v2gAxJIWIXRXBHATpOVKgaE8/UvTgPLGf3bx/b6FlRSR3nHjoScwHtrH0X/tWZSM+nKynA4+aAzxbC1qIxasbBCeca+yEHRDKChQzeVKZcI7ont7IHKGQw1sPC1kNf6enDS/f2hHZ8fofgEu91DjBKHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 07:53:30 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 07:53:30 +0000
Message-ID: <d6f63f01-5b53-48da-ab50-75bf8f0d83c3@amd.com>
Date: Tue, 23 Jan 2024 08:53:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] xilinx_mbv: Remove empty config header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240122223920.3630168-1-trini@konsulko.com>
 <20240122223920.3630168-2-trini@konsulko.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240122223920.3630168-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:802:1::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b4cfc6-95f6-41b7-caba-08dc1be863b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+vnCQxR/pf2K8Ny5JHSrCThcX9J6cNIKsAuVfaNidDItYiO9UMYBfsMsPl9Eu+aYIRbdREGlvOCID/m8XrkhKRNqS9pMZPtiw0S5tziraWbckQY0ERWWN4bYIeu43tg1tByodl/jW67zYlff1mrguoDE5cfE5UMf280DuBp0w71HUsacCUYN2im9vl4lLHPmNBQ5jKlPm9r2ptp4y6xIh2BhomduE3RZYHoVxIw9xhlUmz3VuVaMeZJFTJEULQnF/IA8LFqsM6938DPa2W+LIn9NDAYthj9szzg1G27Qwu2ww4PlbSplvJkokw3dyNuyZZQuDrYbLyxUcrym6B8zI0PvRzBItFMoqpbudwtK8AaniXPEC/wv/lJYO9nB/kSUQ0Vwn8TO09+kMrajWwPBcV7raTC0q2aNRe84cISo/sAXvdTq9LOWiYiO4Dhd7VVZ8ZCO9JxuKP0f24nTqvtknrh9051zRui5X09wETuyxYBwPF/DCXM6osDcvSQelT4Mt57mWyvVtsQQp3oLuhN2w2974G9e9JmV3nqGktagO8EK7yY966wvdajeGHHAbedhCrn1iUMibL5A1XMpgxNpBizviglHrQs9mr0ViNAZVqejc8i5yLDJgO4c0OR1bwBGeTlRzjJSonwSuLfYXtopw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(26005)(2616005)(478600001)(53546011)(6512007)(6506007)(6666004)(6486002)(41300700001)(316002)(66476007)(66556008)(66946007)(31696002)(31686004)(86362001)(38100700002)(36756003)(44832011)(8936002)(8676002)(5660300002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhpS3dGU0hxMzVlb0dwTUJBakR2b1BzWUpMNGh4WnB1N3gvY2ZmOVNHbWJ1?=
 =?utf-8?B?Qk1DdURMdS9pS29rUkw4OFc2Smk4ams2WWw2VnJqL05SUGJjNjVhT0NQVTg0?=
 =?utf-8?B?dnVZa21SOVFUc25rVmV1VFBtQ1I4RVJMdmx5WHRtT296T2VTRzAxUVBVbHQ4?=
 =?utf-8?B?cEsrQlFSbnMwTUlaWERVNkp5TW41Q3FNc0pCQVZDd21tSUQxMFNrNnc0a3lV?=
 =?utf-8?B?ejVTMUFQOVZaa25FY29HUDFPVGdFUVlUcXdoNjh4NDZSb2dsNDRzN1dkWWpt?=
 =?utf-8?B?ekxCNU9uZllrNmlyTFlBaURzRVp4NFI4VlhQRTZQQnRQcHdyejJxMGJBU1B1?=
 =?utf-8?B?WUp4bUp2RWZ0NHM0S05jMnpNWFZWN3hYa3NkVzhkVHZ3dEZXSEw0aVZkWFpN?=
 =?utf-8?B?LzM0VWN5THFUL1VKVGVZdW0xcUs1NlpYY0owa2NaVVR1d3ZKSnhZejBjaG54?=
 =?utf-8?B?eDl4bndES2pzZUtUaDRhaE51TWRZUUZOSHR6engrT3g5UFkzd1VlRXdlMjJs?=
 =?utf-8?B?c2QwMHRLQnpkazlIdkxEY1RLdjM2ajVRdkhlZEdMOFFSejE0SFJqb1IvTmh0?=
 =?utf-8?B?R1ZGd3l5Sit5UThKMVZXcjVOMVRpTDkydWRxUTVkUkl0VkRHcnM5VUxISTI5?=
 =?utf-8?B?V0RCb3hZbDFiK3pWUjdXOW9aeE9QcHFJR2Y2RUN1MDE1MjI3ZEFsRzFnMy9t?=
 =?utf-8?B?Z1BHTXhpakZFcGdKMG8wODVhSWdvOUxVUTh2RG0welNQK1BpN2dob3VYRlJw?=
 =?utf-8?B?dFVBWHdVdXI4ODVCN2FJVFo3ZHlVdEJybjhOR2MzZ2pkRG5KZitSU0thb3Nm?=
 =?utf-8?B?WW1NQjVCcmFTamtiQ1U5SE82M0RyMXVpVG9CNGF3WHZ4SlpjMVVRYlhKSVR3?=
 =?utf-8?B?aHJBcGRZMjJkcWhyMHJxQjQxZ2NkWVZOcEtrV210azJOVE13Y1hKTjU4S0d1?=
 =?utf-8?B?cUhrTmYvRmIrckJ2bWFqdjdNbWhwcE8yRmhpbkF4cm1peDd6NktSOGVEMzdX?=
 =?utf-8?B?WmhGcnZWVjZqRnc1QVZQdXQvWHBOZDVPVzVHRzNESENIWHlXVmtTMnYxa2Jk?=
 =?utf-8?B?cE9TOWlZRGJpbnhGczMzbnhzMFIxaUhjeEludEtUSUs0VC9HSGYxU3NSQzlS?=
 =?utf-8?B?a2FrSktzRVpvUjNZVkdnQm9WTUpNUElaNENQU3FIRFp1NzAzbTNsaU1xSkpR?=
 =?utf-8?B?NzZjK255d1pMNU5xVmZ2MVR6Nm5nK0hJZ29kOFovUzB5bUdvN0tBOVF0YktC?=
 =?utf-8?B?anNIME0zRW1aM3ZUczZySHA3SktXWWxhV2thWDFRbWowbHNxVXRMUngwQXhq?=
 =?utf-8?B?RE9SZXl4UXJvL01YN3BFaUZKQ0JGSVNLZzZTL1VOZGROeldVd0YzZnR4ZGZY?=
 =?utf-8?B?TTBIS1RJMXowR1lGMS9IYnZIRDh2cGtobjJNZ3FLd2pFeG5QR2R6Zi9yWXB6?=
 =?utf-8?B?NVVUN3hTRWIwNzZwTXBHRndPQUVVV2g1dW0vN1h4bHlXQTR6OGZXQjZJNjVT?=
 =?utf-8?B?M3AvMW9PcXF6RTRFZ1JPck8xSHFQSVUxeTVoQm05czMwcDBnYkhnZVZNM3NS?=
 =?utf-8?B?QTM5ZldsbW1WVTZLMEpwT1RGUGFXOWxYTER3dFpnQlBEOTRsb1lqN0g1YmJ3?=
 =?utf-8?B?dHJtYmtWcHlZTUtQVHd3WXltVTdTWVFhbHREOE52NHQ2N3JMQU10aE9tUFJZ?=
 =?utf-8?B?cjJ6VHlmd05IVnR2NWpoTS9VT2RhRGZrSDcxSW9SSG9jOUJPT3VRQkFoMHh5?=
 =?utf-8?B?eWFCcnVaUWJIV1RjNUordEthK2VDdG4venNpcytVeGk3K0E1SGtOTDZRWUNa?=
 =?utf-8?B?Z3FYMk91WFRRY1NPK2d3dG5XelpIOVU0Q01BQ2tKSmhidFhIS2xVM0EwcFg3?=
 =?utf-8?B?L251U1E1dmY2Y3lZcHAvZVJ2RHFYN0MxdzlnallLbWxSTlNtSENtbmp6UHFL?=
 =?utf-8?B?SkprMjE4OXQ0ZDlVaTJKV0xzYlJjaTVYVXJ2Z0ZjVm9Ibkc0M1diM0svVlBW?=
 =?utf-8?B?VTFqemdyVVZSL2hIYllLK0FlTko5MlQxRVlieEhFVSszZnBRRm1IeGZQOE5k?=
 =?utf-8?B?LytWWjlzTjRvZDhJTC8zWVFpSldoMzZUVWpjOU1kUEFOV0tvYzJHUEhoUTNk?=
 =?utf-8?Q?X8SzGMDP/UZ71Wk7AUGJmXmDv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b4cfc6-95f6-41b7-caba-08dc1be863b7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 07:53:30.1060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw6DyJG/XqfKiufjfauMXFWavWWurTLmo2jyaq7R2LcGN3SV1OKMvGJNiEmSuuYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
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



On 1/22/24 23:39, Tom Rini wrote:
> Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
> lack of board.h file, unset this on the xilinx_mbv platforms and remove
> the otherwise empty file.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   board/xilinx/mbv/Kconfig     | 3 ---
>   board/xilinx/mbv/MAINTAINERS | 1 -
>   include/configs/xilinx_mbv.h | 6 ------
>   3 files changed, 10 deletions(-)
>   delete mode 100644 include/configs/xilinx_mbv.h
> 
> diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
> index 4bc9f72c541b..d2dec397ed6f 100644
> --- a/board/xilinx/mbv/Kconfig
> +++ b/board/xilinx/mbv/Kconfig
> @@ -9,9 +9,6 @@ config SYS_VENDOR
>   config SYS_CPU
>   	default "generic"
>   
> -config SYS_CONFIG_NAME
> -	default "xilinx_mbv"
> -
>   config TEXT_BASE
>   	default 0x80000000 if !RISCV_SMODE
>   	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
> diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTAINERS
> index 445654fe740e..db9f03388df9 100644
> --- a/board/xilinx/mbv/MAINTAINERS
> +++ b/board/xilinx/mbv/MAINTAINERS
> @@ -4,4 +4,3 @@ S:	Maintained
>   F:	arch/riscv/dts/xilinx-mbv*
>   F:	board/xilinx/mbv/
>   F:	configs/xilinx_mbv*
> -F:	include/configs/xilinx_mbv.h
> diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_mbv.h
> deleted file mode 100644
> index dba398aeec49..000000000000
> --- a/include/configs/xilinx_mbv.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> - *
> - * Michal Simek <michal.simek@amd.com>
> - */

Acked-by: Michal Simek <michal.simek@amd.com>

But maybe in future we need to revert this patch to add more options there.
Or do you plan to remove all of these configs?
I can imagine distro boot wiring but that can be done via vars file only but it 
is not practical.

Thanks,
Michal

