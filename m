Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECA2E7D0CE
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 06:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0B0864AA;
	Fri, 22 Sep 2023 08:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GY+gFxqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29A13864AA; Fri, 22 Sep 2023 08:17:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20ACA864C4
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695363466; x=1726899466;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xje6vk/YPJeVfoMT3Hml334tSqtUzg2Qn+KaAfuPGdk=;
 b=GY+gFxqS2cyNj0FsyVR0VC/mSy2LMsoBeWahQVzkrAujdkXpFAl37dWY
 SsZOU7ApoAlkRp4Tyju5qHVCgyuGZ4wlYiM8mhQ1a/mli4rAzshpIYxRE
 D1xX2dKnxEZlVlcg1HtO/B/BNgs7aO3swHjj4Yt6AKcz1xXX4Vg6oNkKt
 51Y94PwWzTbarXEy7CB/15I7lPZGmgIzewME5RLoyWY4kTuyZFGnq26HK
 J/E8NkvQi6xh7ani8l253hRzGLnyeLQ+rMt0Vmy8UtYMLeTq6lD9YAeby
 8iMlkharEEMqAb+E25mIWu4ZXz9fdwGpu2Iz0CD4UDwaEKoXAI/jFhcZr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="360134823"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="360134823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 23:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="740983232"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="740983232"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Sep 2023 23:17:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 23:17:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 23:17:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 23:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjhXdqyePFZ/BnvozxGsUMKsvSU4UoGplbxRqKVttjW0ZaDvYjpflybv59Puaqtd9WbjDuDqmJmqiUaRtgQC5lrxBj2jcULP8eQK+VBnsxZk7HlOM+mr50APG7sY5N8V2QII5ttwxPwv63TUP0rGZJ1fvsUY/g0LqyLVNjyltYB6B6PaYwa4+31ZolpEMb1TV1iorK0/lV3f8X6px1lIj1R6OzV36J54h72zRHcRqU/6G6al428DWek5IZhnJKf8eliulWMcyUXl4iXyYG//GiPWST5JJVCeeqM3RAe4zCqAa3I63lVBDLNj9ARPI3ZeFExfTppZoKFGJjHVnaZSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wly8B8Xc3Ub3VZKvQ0gzmwDfRoZetJTMlYvWMw1qgc0=;
 b=eoMQQL4Ao7lYgliLo/XXf76JZx6G5kNpgr45t4MYfghQQtP6v/B9/JZfn2WUa1EvK345+F3dQfS7/+DeI3UDTro+xcEVxbrymFebTAlEjuE5Kc99NBjTJ8CUORYmaqlHuzTr8s+/skuy0fGbTcH0RbYwOezBjkprrbvzAKEhPcvHyVknwoEbwuMYC+LulgD8WwsixDzQ6mIDYSnjVeJj9snj6xyc/RuYumuGM+M8si2ysuwIZ367EAvpVN7qhydxVlVK9zKbqX0YOmYHLbSZkrjhZKtqyN2vFW3cjXBTo/09gqQBQyE2bf1isukr7V7pKFD+DQ9ZOXVnpAwzzC2ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 06:17:35 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:17:35 +0000
Message-ID: <00e1632c-93a7-be59-2119-ea8b3fcabc99@intel.com>
Date: Fri, 22 Sep 2023 14:17:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Anup Patel
 <apatel@ventanamicro.com>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <bmeng.cn@gmail.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <pali@kernel.org>,
 <andrei.warkentin@intel.com>, <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
 <60f816cc-8372-0628-fb1a-0073dfd87361@intel.com>
 <fbac1b44-f2fe-42c1-af62-7a882e4737be@gmx.de>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <fbac1b44-f2fe-42c1-af62-7a882e4737be@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4afe4a-271f-4937-5503-08dbbb339c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ru1QkGUKX4VSvtxKp1PiIjQn0gV27J3uSYtsryb2BEbDCWwvoJhk59isg0XyejsEgqVQndHT2uEgUOqBfT9EMNGSpkpeHJFjFURLNBaXIoeVfdGus2/1AR5cvgPGtGDTLDmdsxtmmQcULZuKPrytapi7dT7apuXifNlYjWgCwnyaZDwOUbjpymCbaMgojPzkyIP3w84Pfru8QCs7AnlUZ9R2hICHkGoMQcKGZ2Me9v0tT5UenQEHMyMMjjdmHRe3l/9mgoH6Dh9pzX9tUiV4Oj5jqtQgJiq3ce+XjwGYCXrtT+4QlavgXVEPM60feegZvzPN4GhW4klVBfOHkZFOnjPdQGGnFqnhaKxW4ElZrjNUqL4Tj/mdPZANMFoFPwmj7FAFA/05jc04OA6Zw0GFv+iyjLpjd+7VI5tvSeyQ4s73FSeCfVH6tl4t8VL4Bp52EtL0MPBdPJVoFXtJZPp/hpWRJqGFgfScTP0Qn1rYqGzd5e2jX01C4tS1j8zcKZLTohDu365t7H+djIsodUiatPdn20z5+0Duy6UAn9rJN9/5MD328qOvxjfGeTex6Jw1LTi64sycsSMfeaZMo0Y7/rFfHZdapSQA43CWxn1GsA1Hn/fqt3OVtT6bhn+CASGrogn74QITCSl5xiFtxslm/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(186009)(451199024)(1800799009)(6666004)(6486002)(6506007)(53546011)(6512007)(66556008)(478600001)(83380400001)(8676002)(2616005)(8936002)(2906002)(66476007)(66946007)(316002)(110136005)(5660300002)(41300700001)(4326008)(966005)(26005)(36756003)(82960400001)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGgwTitOajc0SnBHOVJ3T2wrQjM5Z3VMODZFdFdRZzlzRERTSkFudWcwdml6?=
 =?utf-8?B?L084Q05qbmxVZkVrd0hVMG9henhYakFpWmh1U2czd0RmRzNVaVlMaGtsem9x?=
 =?utf-8?B?Um1DVUFpZytuQkFBdDQ4dWgxM1dvOXlTdFVyQTY3SkpKMXlKZUx1SFphSjV6?=
 =?utf-8?B?RHFuOXA0blQxYktaeXRkUEpvQ3BSajZmckxJSWRHS3I4K0NMZmdwd0RnbUZw?=
 =?utf-8?B?U2dSbURWbXhhb2hqSTBOa2lLYVJJbkVSRW9NaC9DYVJURDJ6YkxHK1d0RGRz?=
 =?utf-8?B?bmlMTEFvVEwzam5qWnYyYi8wTnBKRkRTbzhaQVJMKzB4dWtWRG96dzJXbDUx?=
 =?utf-8?B?WVl2cU1UT3ByQWR3N1pyVjJCU3FzaU1aVVpWNnBzSWM2cEgzai9xTnBLZ2tq?=
 =?utf-8?B?M3FQTDdKdVdYVGV6TFpnV3lUaVBjYXAyNmNqM2ZjRUY3OTlHTzRmRXpNd2R3?=
 =?utf-8?B?V3ZzM05iOVMxaXJxaEJ6RXdaTElJZnIraUo4MENtaG0yOVRkYUd5dlU4MU96?=
 =?utf-8?B?Nzh0eisvOUx0bzhKYnpycVQwVzhiWG5jMkpIU2k3aTc5Q3MwZHlBa05SUjZI?=
 =?utf-8?B?Y3BYQ0c1T3Q2bVlWcFJseVd6bTBoV0VhN1BNc3B6emgrMkQ1a2c4RGYxaHRo?=
 =?utf-8?B?a3Z1YzRBM044RUJSSUJuMlZsYzNrWDdOUjdWdVBwOGFjT2JuSTdtOHhFOWlj?=
 =?utf-8?B?Zk02VFFXUG5teWpNR25yaThWZmdXdVo2YXF4cEcxM0ZmaVRiZDZnYVMwQkNC?=
 =?utf-8?B?bTNMdk16RmRUKzl4ZmpXcXJNcG5XNFNzeGdILzBnRDU1K3MzVWt0TnB0NGgr?=
 =?utf-8?B?Qi9TRnBQZTB1MW9sRFd6VHdRd3VINzRKMVJxUnZsY2lFcFc4M1h1c29TS0xk?=
 =?utf-8?B?c1NOQUh1bWl3S041ZlUrU2tnRERONC9aemJINlBxay9HMWxJTDVvU2h3R3ln?=
 =?utf-8?B?RytrdmNxNDJ0VlErR0ZtNDBlTTIrTURJNmJINnlJMGMyMXE3TWt1L3NGSnFF?=
 =?utf-8?B?a1hGM2JKZzB4aW44VzFPUklEY25JTzdjai9rNkcxdHNRbDArQTlqZU10c0Ex?=
 =?utf-8?B?S0xISWxjNVdPNDNNRGlPRFR5NE5xZFhJU3RvTUF6c3VyUjZoVThVM1ROTHBh?=
 =?utf-8?B?dDRsQ291czBpRGhianFMUE5aVEo1RGpJZEtQMDJzcHBlKzBRUmpNVkkwTkNp?=
 =?utf-8?B?QzYvUGpzMDM1VFZ6Q3VwZktpd2ZnV3J5Mk94RXc1YmFqUVE4dmo3STcrSjZt?=
 =?utf-8?B?VlRGNFljcmdZOTE0eVA5TEhsUFR1dGUyZE1TZGMzUXlXWGJxcm41UURLOE1k?=
 =?utf-8?B?VmY0bEJ3NlBXM1d6ZVkzenh6OXNOaHlueHhhUUJiSTh2aUMwSW9UZG1TNDVH?=
 =?utf-8?B?eGQ3ZVE0anhjd0thdjVvajJQOExFbUttN1RIMDcxRkNIRjA3TmpiOFZzS3J0?=
 =?utf-8?B?Y0xGOUR4QzBlWGU2NlEwdVc5d08zaDBXTzlJOGZZVGR5d3FISG5URmlJdHkz?=
 =?utf-8?B?M2pxeEhuQ1EweXlNRWZyUDY1U09LOUJ5RXhkeFF0SUJKcWFxaGRQallmUWRv?=
 =?utf-8?B?aXI2bndtVFVzeGd0Z3lobEdoUGp6Wm5MU1RzTG1sNlFsbEl1NWUwTVZuSVUz?=
 =?utf-8?B?UFlPWHl6RlNaQUtIekpOTkt5UFQ3Y0M5TnkwcnVWUEg5MmRrMWxOZU5xS3k5?=
 =?utf-8?B?SWw1RUJiREJOajRxaDRMTW45b3pTT2txV1ZGdnV0SUpCQXNSb3UxdWpWR1ln?=
 =?utf-8?B?OVowV1o1dC95cG1YcUcvVEkvcDRxMGdQWGZlaWlMRXM1VlByNjJ0VlBJczBL?=
 =?utf-8?B?OVZId1FHTEUrcGNMaEhLNnI5MUt0anMvak1pU2NqdHFJSWJERGJTVWxFbVFw?=
 =?utf-8?B?SmFjOW9YL2hRZjFkYUFiVk5ucS8wN0phNHhzZGlZMmFIUTlKbENjaGFVU0Z1?=
 =?utf-8?B?NU50SnFKcDZKSCtZSEVtRlJ2U0JIc1dXdmRZbXk4RWtZNTRIMmhJRkpDT3R2?=
 =?utf-8?B?dy84TGF3eHZKY2wyTHVMQXRCYW0zVjFkNFJ6SEh6a3RjOEVIVnFnaHVNbGRJ?=
 =?utf-8?B?MEFuaUNQNmZzNkd2WWxJSDdRQ0FTajRzb0c0cWxUQXdHQ0Z3VHhSaVorZHZt?=
 =?utf-8?Q?zkmxuc3RMEMBbgp7/fHxou3qy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4afe4a-271f-4937-5503-08dbbb339c6c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:17:34.9480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gUIq3bqI5sbOdNpOQimDWeAXzbwMuYAzXU90FSSQVog0XUTW9WPhuS+Ta/yDmdWnCtQ99lEYGwK7GK49vZ7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
X-OriginatorOrg: intel.com
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

On 9/14/2023 6:21 PM, Heinrich Schuchardt wrote:
> On 9/14/23 09:42, Wu, Fei wrote:
>> On 9/14/2023 3:20 PM, Heinrich Schuchardt wrote:
>>> On 9/14/23 08:48, Wu, Fei wrote:
>>>> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>>>>
>>>>>
>>>>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu
>>>>> <fei2.wu@intel.com>:
>>>>>> In order to enable PCIe passthrough on qemu riscv, the physical
>>>>>> memory
>>>>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB
>>>>>> ram,
>>>>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot
>>>>>> sets
>>>>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>>>>
>>>>> This should move to 7GiB - 1 in your example on riscv64.
>>>>>
>>>> I'm describing the current implementation of board_get_usable_ram_top()
>>>> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
>>>> changed? Is the comment about 32bit DMA device still valid?
>>>>
>>>> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
>>>> {
>>>>           /*
>>>>            * Ensure that we run from first 4GB so that all
>>>>            * addresses used by U-Boot are 32bit addresses.
>>>>            *
>>>>            * This in-turn ensures that 32bit DMA capablehe
>>>>            * devices work fine because DMA mapping APIs will
>>>>            * provide 32bit DMA addresses only.
>>>>            */
>>>>           if (gd->ram_top >= SZ_4G)
>>>>                   return SZ_4G - 1;
>>>>
>>>>           return gd->ram_top;
>>>> }
>>>
>>> The comment above says 32bit DMA is board specific and not architecture
>>> specific. So it is wrong to have this board_get_usable_ram_top()
>>> function on architecture level. It makes usage of devices with all
>>> memory above 4 GiB impossible.
> 
> @Anup:
> 
> The generic code was introduced by your patch 26f4fd1cb4f6 ("riscv:
> generic: Ensure that U-Boot runs within 4GB for 64bit systems").
> 
> Which devices have that 32bit DMA issue?
> 
> fu540, fu740, jh7110 already have a cpu specific implementation and
> don't need the generic one.
> 
@Anup, any comments? In case you missed this email.

Thanks,
Fei.

>>>
>>> It tried to pass through a SATA controller but received an error:
>>>
>>> # modprobe vfio-pci
>>> # echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
>>> # echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
>>> # qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
>>> -device vfio-pci,host=0000:06:00.0
>>> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: VFIO_MAP_DMA
>>> failed: Invalid argument
>>> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: vfio
>>> 0000:06:00.0: failed to setup container for group 5: memory listener
>>> initialization failed: Region riscv_virt_board.ram:
>>> vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =
>>> -22 (Invalid argument)
>>>
>>> With which version of QEMU were you able to use PCI pass through?
>>>
>> Please try this:
>>
>> base: ccb86f079a9e
>> patch:
>> https://lore.kernel.org/all/CAKmqyKMtAzt5saCUMd4vXYfgAQibpzQJAhtTSuSb+yeKhcYpfw@mail.gmail.com/T/
> 
> @Fei
> 
> With that patch I see the two memory banks in QEMU but when I attach a
> vfio-pci device my whole system crashes and becomes unresponsive but
> that is not a U-Boot issue.
> 
> Best regards
> 
> Heinrich
> 
>>
>> Thanks,
>> Fei.
>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>
>>>>>> board_get_usable_ram_top(), but that address is not backed by ram.
>>>>>> This
>>>>>> patch selects the lowest range instead.
>>>>>>
>>>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>>>> ---
>>>>>> arch/riscv/cpu/generic/dram.c        | 2 +-
>>>>>> configs/qemu-riscv64_defconfig       | 2 +-
>>>>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>>>>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>>>>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/riscv/cpu/generic/dram.c
>>>>>> b/arch/riscv/cpu/generic/dram.c
>>>>>> index 44e11bd56c..fb53a57b4e 100644
>>>>>> --- a/arch/riscv/cpu/generic/dram.c
>>>>>> +++ b/arch/riscv/cpu/generic/dram.c
>>>>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>>>>
>>>>>> int dram_init(void)
>>>>>> {
>>>>>> -    return fdtdec_setup_mem_size_base();
>>>>>> +    return fdtdec_setup_mem_size_base_lowest();
>>>>>
>>>>> Linaro is working on allowing to download a distro image via https
>>>>> and installing from a RAM disk.
>>>>>
>>>>> We should not artificially reduce the RAM size available for U-Boot
>>>>> by restricting ourselfs to 1 GiB.
>>>>>
>>>>> We must ensure that ram top is in the upper range.
>>>>>
>>>> How do they handle the case of >4GB? board_get_usable_ram_top()
>>>> attached
>>>> above always returns <4GB. And it seems like
>>>> fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
>>>> just picks up one, but which one is selected depending on fdt.
>>>>
>>>> Thanks,
>>>> Fei.
>>>>
>>>>> Best regards
>>>>>
>>>>> Heinrich
>>>>>
>>>>>> }
>>>>>>
>>>>>> int dram_init_banksize(void)
>>>>>> diff --git a/configs/qemu-riscv64_defconfig
>>>>>> b/configs/qemu-riscv64_defconfig
>>>>>> index 9a8bbef192..aa55317d26 100644
>>>>>> --- a/configs/qemu-riscv64_defconfig
>>>>>> +++ b/configs/qemu-riscv64_defconfig
>>>>>> @@ -1,6 +1,6 @@
>>>>>> CONFIG_RISCV=y
>>>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>>>> -CONFIG_NR_DRAM_BANKS=1
>>>>>> +CONFIG_NR_DRAM_BANKS=2
>>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>>>> CONFIG_ENV_SIZE=0x20000
>>>>>> diff --git a/configs/qemu-riscv64_smode_defconfig
>>>>>> b/configs/qemu-riscv64_smode_defconfig
>>>>>> index 1d0f021ade..de08a49dab 100644
>>>>>> --- a/configs/qemu-riscv64_smode_defconfig
>>>>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>>>>> @@ -1,6 +1,6 @@
>>>>>> CONFIG_RISCV=y
>>>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>>>> -CONFIG_NR_DRAM_BANKS=1
>>>>>> +CONFIG_NR_DRAM_BANKS=2
>>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>>>> CONFIG_ENV_SIZE=0x20000
>>>>>> diff --git a/configs/qemu-riscv64_spl_defconfig
>>>>>> b/configs/qemu-riscv64_spl_defconfig
>>>>>> index bb10145e6e..66dc2a1dd9 100644
>>>>>> --- a/configs/qemu-riscv64_spl_defconfig
>>>>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>>>>> @@ -1,6 +1,6 @@
>>>>>> CONFIG_RISCV=y
>>>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>>>> -CONFIG_NR_DRAM_BANKS=1
>>>>>> +CONFIG_NR_DRAM_BANKS=2
>>>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>>>> CONFIG_ENV_SIZE=0x20000
>>>>
>>>
>>
> 

