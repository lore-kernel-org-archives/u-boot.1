Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3731FEF8FE1
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 13:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05766838BB;
	Wed,  4 Mar 2026 14:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FnT77Qyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181D283F8A; Wed,  4 Mar 2026 13:09:19 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBCE83F7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 13:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCnA2VmYnkHSWYcq+BwuL1Lv6pfWT48jzFSv+iS96J6dox3AxAyOdty4GC6lFrsFa6I9B+sDk4eKUU9riwKWpGBgIJk9MpZV9qncgJOSXq3uPV1KiHUibBbgmzDy2yLYyD1/YkTbkNHomt/iR6duo0JUPxAX+FnsG7blsUcS47QUCvU9YRQRM4rbZ/l7m5EtcmZ6o070IBiUnOqOdchVOSAtOO3E8zzkC3Tjb6tgzhYgBTSl4AXFkKXfD4jLOl+2liEA2EoqnWegrXeGytFinVykYqaQ4z5XViIt6bRVcf3bBci94stkU2odKO/+9w3Jiv3ou4Jr8x8n85CFYIA/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKnvx9Pabj4ZhDA0Tq0VAHlMi+S19eCiul8u7HE+cHY=;
 b=Qg7U9KyKjrBgEGW/g78+1ZDwlzFg1aqduxRzqgX5Ew1jbh0c0TPhwzCkWAtI1X8m8pLbe2bq0D3bJaguzpjaJ6g+YY8K7xFV43JtxEWnQtzZ90NowCRvmyDolUBHOqHw8a175Ick+542yBTNnzGbkAfhZerpd31JUdUNKnLsXpd8NQsr2app3/SZDklW6NJOjey/3HqQ0eaDkiphg9SQOtihmlphZhsv/9bLZqK4wZRfVstcvX5QWnw9p3Pi4tKuIUPInQr0axpz0Vq5fygBOC8Pm63B39tkn07/o+UnR4GVobRhPNM8rEJ5QnghWOfh4+FkvmFL1tKC0hhtYJNGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKnvx9Pabj4ZhDA0Tq0VAHlMi+S19eCiul8u7HE+cHY=;
 b=FnT77Qyu3MlVSZoSVeGASctWbRJXIe3et8p7VlolgVK9MShySLT6O9gi+Rn0m0hp5SB6W25mOC7UBjFK5//SXBae7dAsUAZjLoIeUWwjVfei2uAJxKaEnRl3MYosw6Ms74Xj5a+8qEtoY6HK+CJrkkoVNoF34a33Bj0KlEMvAIopFFanA2AHIPZYTOFesqRysdJvWle4kAU/3bQLcTQ10qp+RGlFOQMboxx3V8KgHFH2O43wrDo2Ha0G4TEwD35hGpxlGePNsh3wXoq12a+/A72m5czTappI8dVHDcnB2RbJU0ZkiUGVSNhLkLz5r5TdaOGhMGCPPvRcEKqBsDhfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6234.namprd03.prod.outlook.com (2603:10b6:510:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 12:09:12 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 12:09:12 +0000
Message-ID: <f51afc6d-7051-4d41-9b5c-1be2cd7b816b@altera.com>
Date: Wed, 4 Mar 2026 20:09:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga: arria10: Disable CONFIG_USE_TINY_PRINTF
To: Dinh Nguyen <dinguyen@kernel.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260304035307.16125-1-dinesh.maniyam@altera.com>
 <d1f767bb-85ad-4b63-b695-161b12cfcc0b@kernel.org>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <d1f767bb-85ad-4b63-b695-161b12cfcc0b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d81692d-2aee-47cb-dea2-08de79e6d86b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: S4yDp3kkJyGtPhJNSORZqYBHJPMLAyeA3tXpyJdqK/GW+0Tpp3GNIoEG5cqmgcIRU1TAkoiBUyqOLBHxf4bR/yJvf3EwZ6ai1jUwusJV5AcLBnW8EWr+TGYnVitt2C0M8hg9ZAKK81TXxDWjWBBbEQMyCsa149DyMijqJtwwFj50y3Z9Zf/oDeMLkKyQVC2/ttd7gNhZSPCv+i56zetpctkXvYcZ/8LzsadH40gSD0Bgq7KqJg3BFczCI6JMZwS9fxsSCLb1GJUiQ6l71Kvj+Ljnvl6BIAKaEazEhBnmKgHdMqogVR2+4lUXeQxVjm05LCzvOwDVREGk5xhJ2hsPZkjn198u3TolY1sAC4b7t0MUILjefdgjCOf7ruMjnxK1joJxpuQBHJCFq5D3BJT5qOPHtghotHOwxgCAo2A/Ajegjf+Q9UQ5+s0qlI4UXrhX/Wamf1zMT2HZj9sDXKpAttNHXp7HdIhIC94kg6eLbpG8OKvip6jfrpBiHSSuMmWFAX2P0EaFEDppnC8ScianwW6LI/YkCbUwqrldyQEYp5umZPJ/7jIsrpF0pkBsByOWPAwebFPnI9A+7NiHXeLih5eY3bj9w81BhTGYqLSxg04rKsK3dGW6tyuKIpWD5WJH/JERlHC6lnIgPRoSDI3RyLQfOI/oFRKnGWe0PCb8bE+lkkBRFH4cH/gZH8S6AWFlUopZkHz93NQN5GSO+zvfwDrq1wTgUO9WnTtjpxp1qHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZaWXpCQ1d5T1VHUFR1MWREclJxcHRSaHZBeSs3dWtlWkE2SkNBQjBIbEoz?=
 =?utf-8?B?Z2JzbjhqUG52SitVeXF3cC92WjFxMXRhc2g5QWlQd3d5ZjY3Ryt1dVdjU3hw?=
 =?utf-8?B?ZXVEelp3RWZ3SjJZV05SeTBDenZKZTV0UFh1SU41U09Sb0JYaUtYK3pSWHhG?=
 =?utf-8?B?TVV0UHZURE1vSExQcGtqNjFGWjgwYzgvdE9BQVoxQWIvQktxclJqZzlrN2xJ?=
 =?utf-8?B?R0ROVWNBNU90dDFJVWNwN28yUnZjRFFBbjRoWnlab2VTcGNiUG1nVy9QZUNk?=
 =?utf-8?B?V3l1b1RCWkp1L09seUg4TUd0a3hISXZ2N0diOThDT1I5YVBZVXg0RGpvd1N6?=
 =?utf-8?B?SkFMbnFWaXU1eStMa0dEa1YwaS92QmdncWhpWVJXY09md3h3M3FxUENZRlpv?=
 =?utf-8?B?YjBmanFwRmE4UXZ3Mkt0b0h0RDV2TkN5SVBCRlZYcjROdHBkWDN1Q1JjUFRC?=
 =?utf-8?B?aElkNHhnVXhUK042SnBMRzlScHNvWWRLeWNEZUJ5TzZialRSWXUxRHNtWGsr?=
 =?utf-8?B?eDdNNnZaWTJ1aElKOUo1cHNRcFgyYW04c2ZWd2Y0aUlOUCt3YWNDWFRva2Mw?=
 =?utf-8?B?SnN2bldScGtuaGpyZHcxbHRxQzE4aHRSVDVXMWlDUGhLOWpsVkR2azYwcEVC?=
 =?utf-8?B?TzZpTmtya0VsRkxFZ0JjNzBiUHcydElDTFVUQ1R5UWpSUmU1QUc5WXJ2QkVQ?=
 =?utf-8?B?VktQbktPbjRuYXJ6V1RVeTVJTGdDQk9wdC85Y1V0VnlpYUthWmtMVWdEZkhG?=
 =?utf-8?B?QmVNSmpjOG1iaVVIOExxTlJSc3RnbDk4UlNTU3pZSzhXbmFYMFdRZXlVMjla?=
 =?utf-8?B?RkpsYkNSWFJTcG5TUjZOR0YzR0hOMVljaTJiOU4zOTRqT3p2ZmpaQnFNS3R5?=
 =?utf-8?B?bHd3U2lCNVhMakcxakNobENxWUxyNUNtcXVLUDNhbm42SVhzS3k2VjZkdWxV?=
 =?utf-8?B?VC9SZm1sMi9wK1VNUmI1OEhXdzRScnB5K0IxZHRHTDNnbm8rQnh6UzkzSi9Y?=
 =?utf-8?B?UFF3UENLS1pWNFovMFJZa3RyVWRmKzVhbDlxbGltcXFXUHJuT0FKZDAyMWJt?=
 =?utf-8?B?Vk1udGJ4STNZU2xTbU05ampMekkrM3pXYWZaUit2RE9Sbk9HUG14M2hndVdJ?=
 =?utf-8?B?anhlanMzMnBid1dUQjJBWk9qTVYyMDJvdFZVamI0Y0tLK2hBNjN2WGVaQW5x?=
 =?utf-8?B?b3o5N2w2Q3ZoV3FLZm5CZWluUHVJclFocnltaHo2TS94Z0k1cTNUWFJ5ZWJq?=
 =?utf-8?B?MHRVQXNJNUQyZ2JhdDcxanc0bm02cTFsYnpCSU5iekJCVWZ0QlJ2YWI4ZjBi?=
 =?utf-8?B?Wmlmdyt1cXIvWmJpdVdiY1ZISUNiSDRQelZxVnB6K20wUlVmUUNkWng4NDBT?=
 =?utf-8?B?VVcwYXFWSjNhbWZzVDVtQ0h4TGdFRUg3eEUzS2lZblVFZngwL21Nb1YwY3Vw?=
 =?utf-8?B?Tk1iVnIzTnVsUk95UHBJUEltYVd0eW5Vdit3UmF3L2xmcTREZWttQkl6Tm5E?=
 =?utf-8?B?dHVRek9WeWRVRHEza3MwemloMjlqQUYxajBHcjBSUDl5bkRyV0MveHRHQU9j?=
 =?utf-8?B?SExVSjUxQ21mUmxrWWRvODlGMk56ZkR0cEpPTnFTbThlV3UzamJOT1RWdTBV?=
 =?utf-8?B?cUx2TklSejlobjkwQ2syVjJ2bHd2eitzQ2FvM0NHU0NuNi8rNFNtQlQ3Rzd4?=
 =?utf-8?B?UEF6enlPbmhsTlI1bDQ5azFDaGlWaXpKN2NPNXZsT1NjMUFSaXk4TU9XdDY1?=
 =?utf-8?B?dk03aFRjWTVmdlRMRjVyazJIV0FqTTRZaGJGVnVrbVNUVktwSUNoMnltcVRQ?=
 =?utf-8?B?RlZDMzVkM3o5RUZaUVlsVkRrbFNTY2FCeU1uNENmTTRHMXVBaFVPMW5lZjFm?=
 =?utf-8?B?U0k0YU5oRGJtcG9hL1ZvcXloWEU4TXpSL3Nad3RScTVrM1VWbnI3TGR6ajdD?=
 =?utf-8?B?RlRrSDNnaUZlWm9xT2l6QWs0U0NjeEdheng2MElnMnR0MlA5NU0zK1BjbjZR?=
 =?utf-8?B?Wjk2Uk5NM0RySjZCOENLcG9UeW4wUmUzclpMRVZ4cDhoU2pPTyt1ZGpLM1dI?=
 =?utf-8?B?V1hreXBjOUR3ZUZBb1RSRVIxaENLbkpuWlByYUFTK2xTNm9pU0xsNWVEV3hN?=
 =?utf-8?B?dEhOWDdBS29XSGhqL0l3M2lTS1hkOS9xZmh4d0tZbVo0NVlFZGE5Tld1MWF0?=
 =?utf-8?B?S1gvV1hEd2kwRFRyZExJK3h3THIrMGt3T0JrRTNUVllIUmpoNSttZWpIM2RG?=
 =?utf-8?B?cEkzUGFjdkVLaVovZFhMalpyMHdRSEFBR09Vc2U1NWVqeDZDWVh1NC8wZnFZ?=
 =?utf-8?B?QVM0TjkzNlBOcVFWZTBLU0pSWnNGR2o3eDJOM1JybGJBMndRYmR2cXRHYWNS?=
 =?utf-8?Q?zcHwR/zexgAX359o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d81692d-2aee-47cb-dea2-08de79e6d86b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 12:09:11.9157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCnIrUgce2oPS2FW4Lc4PU6UkI+ESMgpMH45SDvG/G3qKRz10d4HzoF5y2z2EMQQMfGD9bXD2Nvjws5ISU4TPlQKhV1QQm/COwFUUt/UBqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6234
X-Mailman-Approved-At: Wed, 04 Mar 2026 14:18:02 +0100
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

Hi,

On 4/3/2026 2:58 pm, Dinh Nguyen wrote:
> [CAUTION: This email is from outside your organization. Unless you 
> trust the sender, do not click on links or open attachments as it may 
> be a fraudulent email attempting to steal your information and/or 
> compromise your computer.]
>
> On 3/3/26 21:53, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> CONFIG_USE_TINY_PRINTF is enabled by default, disable it.
>> Arria 10 has 256KB of onchip ram and it is enough to support full 
>> printf.
>> Full printf allows us to have more complex format printing, example %ll.
>
> Do you have a size diff for the SPL with this change?
>
> No, disabling CONFIG_SPL_USE_TINY_PRINTF does not introduce a size 
> increase in SPL
> The implementation should be safe and allows richer formatting support 
> when needed.
>>
>> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
>
> Is the above contact valid? Also, try to just include contacts returned
> from get_maintainer.
>
> I will remove the invalid contact.
>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/Kconfig     | 1 -
>>   configs/socfpga_arria10_defconfig | 1 +
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-socfpga/Kconfig 
>> b/arch/arm/mach-socfpga/Kconfig
>> index f2e959b5662..ba01ec08be2 100644
>> --- a/arch/arm/mach-socfpga/Kconfig
>> +++ b/arch/arm/mach-socfpga/Kconfig
>> @@ -101,7 +101,6 @@ config TARGET_SOCFPGA_ARRIA10
>>       select SPL_SYSCON if SPL
>>       select ETH_DESIGNWARE_SOCFPGA
>>       imply FPGA_SOCFPGA
>> -     imply SPL_USE_TINY_PRINTF
>>
>>   config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>>       bool "Always reprogram Arria 10 FPGA"
>> diff --git a/configs/socfpga_arria10_defconfig 
>> b/configs/socfpga_arria10_defconfig
>> index b32f40ae408..d5feabe5ce0 100644
>> --- a/configs/socfpga_arria10_defconfig
>> +++ b/configs/socfpga_arria10_defconfig
>> @@ -69,3 +69,4 @@ CONFIG_USB=y
>>   CONFIG_USB_DWC2=y
>>   # CONFIG_SPL_WDT is not set
>>   # CONFIG_TOOLS_MKEFICAPSULE is not set
>> +# CONFIG_USE_TINY_PRINTF is not set
>
> This does not disable CONFIG_SPL_USE_TINY_PRINTF, you need to add this:
>
> # CONFIG_SPL_USE_TINY_PRINTF is not set
>
> Dinh
>
> Yes, you are right!
> I will resubmit v2.
>
> Dinesh
>
