Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D1EEB596
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 06:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6131186E65;
	Wed, 13 Sep 2023 08:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y0QPb+J+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5926586E50; Wed, 13 Sep 2023 08:00:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D375E86D99
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 08:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694584804; x=1726120804;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=a8CiTK39pF2y2ot+y3dz/fVrRu2JxZ8/qFn9crvbT+4=;
 b=Y0QPb+J+wuADFFBL/dOAXaL/fh7x+bsaUh2fjv+no9f6XYzub9BdemvV
 Wv3q40OOR4acfk71cL4aKrQIcYFiUmXOt7RaMBuQ6jK1y4j1rL0qHUOZR
 BWNH/q5rBWZFjFXpwnewlysYWPxPWcS4kBf/XtwTbRNsRfvIPNKNh+0l0
 lPaXbDDHELTQnwCO50wn/+I1qOqMpkNWTTY7U01DTZbMbbWEt8IwAyCvZ
 JOKVpGqTxviAeQM5oDb6al83MUTHqPPAuAnrWHhUa5/O+dav6SH3alCbf
 NsZpimd6P8GOKggIKbcdm1PO81ENLiQPZee+9m/4qluquUyhS7uZ2moaW g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="445011457"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="445011457"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2023 23:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="779074813"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="779074813"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Sep 2023 23:00:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 23:00:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 23:00:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 23:00:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSHHzb5+bBI4D6mGpFHd/Y6wFOnLr9Kj7RFbRLRZrwI6+9igMt97g6ohm+WoQehoyMAWp/HocIJBu7fvXA21+9kLvSeEd3LEulJEabK/PxH7At/tn96BSE8wQW7XClgvgijWp9Rr47evfDx+7HmA5j4ONJi9i7cN9u5WoMOJo2yKRpg4FSj2Knjs1pG8/lB2/yreQOnXNOd7zfWH9bMwXboMbxUwcYY+EcExiFOdPrHTwyJbDF15nCHuuxbAVKmx9yQzly3S3nCcK2VpqNWZLNUVw2x+UF2dbY9+qkzPnfilfN3crCAl0H59xiPsjpa4q04iffxaD3JBEdbuW9HkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug4NNUkYZPaTKKGKkNREQt/WcU5nQ3fTrCF4wtLn0XE=;
 b=H2MrL6PGOzp9r9TodFZcSiFEaWC/hxVx9rxlcXnHSJIULU5hUWJSCt7jjeinKIWxGUUVETLOCCtPxy7NRTxfBGlTh7zl+6JXuru5wm22GMsdlIipRg67G9e5lSLB5EWaWpxaW/JdbW+tfACQQGD2I8WH7GtnmfTOA01WEyw4T6NBYVYf71foPLjTI+lfrVNzq9ldYpG9Y6lIU5Io5G14vlo0I4DTj16yu39+o9HPS5/xX0Wm6D3JC2ZMIDh63MnWVGwkG+b31/QoNgmQk25tbNIBd/P5bFH+XC4zTBMrlBw+cjcmiOvwBfnx5rcyvG2ftQF/QtUfj2ZN/EKv9kk5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by DM4PR11MB5390.namprd11.prod.outlook.com (2603:10b6:5:395::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 05:59:59 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 05:59:59 +0000
Message-ID: <d53af6d8-9cb1-4ab5-73a7-a3547dc9e224@intel.com>
Date: Wed, 13 Sep 2023 13:59:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] riscv: enable multi-range memory layout
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rick@andestech.com>,
 <ycliang@andestech.com>, <bmeng.cn@gmail.com>, <sjg@chromium.org>,
 <pali@kernel.org>, <u-boot@lists.denx.de>, <andrei.warkentin@intel.com>,
 <sunilvl@ventanamicro.com>
References: <20230905100935.428120-1-fei2.wu@intel.com>
 <92e300b3-d4d5-4965-4ed4-ae3974fba279@intel.com>
 <149987B6-0711-43D4-9CA8-15408D770681@gmx.de>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <149987B6-0711-43D4-9CA8-15408D770681@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|DM4PR11MB5390:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d57411-93aa-4b9a-7bf1-08dbb41ea975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L89qqK1plcYayRKeynu9kcCepltOeCkq2AHmON88Fp07t+vd5Ha5qjpnaEVk9WFq46z5EH7aJFksVXSP4NrL6rVuFq2wveDO1cNXHwC7jhpGGa/mfXE/7wrh+FvMPw91IyMbdbBQp34F01k7IVfjGias9/8WSL3oB2hYns4WmTFRUzNy29yv7+E5Rc1YvjYfnP7Rw4Stm7Gg9ZxKFLmmDalkFF2wM+cqE6G0keOHmtskI4ypK96xLYgkd6BjEmZyiUC2Ev2hDaZvd7/fFZqjp2IlXS8AISY+zXZxLo6uY/BMaMjhEr/gM3CtvAQozg+ZywQ7bp+uJ8qdhIscmTIX1xxYszd6fdCLRUWmLe0EbJXtowgtlKsfdFMIB1fj7GNOUA1Hv3tU4kfMm9bwCBwx5LwmPKNWraM3jq53RaOrSv+HdnPN6tlF2uMhgKuJV7xzh9ljyT3djxnE2q+AHcRZi//HI1kTvKmCnERhhWhF3gAEZ477su5wu/u8Qo1Qs57WQWUKNIW1DQcYjdYjgzmYS5Mj957pH38iQd7MjucdUIsJvYw7PDdXDwxU+upFDTF4JMKEV8tDqU0A6ffqmQzFS7Z3dL9DwqnmlT9lX6nAd2A/RUOo7m4awcbLHlb0N8hJsSzL7H8m/rYjljNOs4ofvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(1800799009)(186009)(451199024)(31686004)(6666004)(6486002)(6506007)(53546011)(36756003)(31696002)(86362001)(38100700002)(82960400001)(26005)(2906002)(2616005)(6512007)(478600001)(83380400001)(5660300002)(8676002)(41300700001)(8936002)(66476007)(66946007)(66556008)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJVV0hBTWxEdDdKLzBOVzNjWUY0NXJaM1VNNEo0Y1pzUzB5TU9NMlVoRVE1?=
 =?utf-8?B?dnB6WWEzdnhpOE5TSUNHbmNnMXB6cGtQRlh6ZzB4aEFvZmR5TjR1WEsrTWZv?=
 =?utf-8?B?dXY5WjR4QTQzUllhck9rci9ZNGFYd01melZqRVRtYlZXU2FIREZXenpLb1dt?=
 =?utf-8?B?RTJ1WGhqY2lDL0NlSW5oV3dMN1c3M3pIM1U0WjE0RXRMRFM0Y2hjelJGT2VH?=
 =?utf-8?B?RDU1NEVPcW93SUIrVmpIZ2c1TFV4QnpoK2thYStQM2g1djhrVWE0dnFRMkZ2?=
 =?utf-8?B?S1hyWXpaMXg5R2U3N3c5dWZuQzVRQjhsdGljNVFaRU8zbFNUQ0k1RmZsYXRi?=
 =?utf-8?B?RVNiR1lYd1pZTlNpQ1RqNlpWeVlSVU1xY2c3Ky93bFQ1d0pmYWEzQVJxc3h5?=
 =?utf-8?B?WVh4c3JBTC9ISzJtcGFSNVZ6V091MXN6WFVpSVZMSk1ZcitGaTBXUkk1NEFK?=
 =?utf-8?B?R0pRSVAxZ2VnZjQ2Z2hIVFEzOW9lWVpOUUJ0QlF3Rkd0MTh5SlR1bzIwN0F4?=
 =?utf-8?B?RGkzT001VERiS0Q1MlZCUkJvYTBZQnRMeHJtWWtaUkNwYlRNUUhoRmt2TmFt?=
 =?utf-8?B?bGdIOTRTV2pYOUZ2ZWYwM1hFa3dYY01ObkdIRWxyZnoxcFp2czFqR2pRMWtj?=
 =?utf-8?B?ZHh3aTB2RGNRMUxaZHBZYnIwRkxWaFBWVVFPN01jY2UvbHhEYkNVckVyNXA2?=
 =?utf-8?B?SDhMSHkxSzRiUHVZZ2YzeEVWSUQzSXJtZU5LdVUxaWY0cjhLVFRZSGVxREhP?=
 =?utf-8?B?ejBWdDRjUVpYUk9YNkxsaFE3VTlVOVBOenJGS2dua2VNd01nTG1oVnVFbFJn?=
 =?utf-8?B?M2JtTUd1MDhIZHBnZXF2VHR3eWpHU1B5dVJyUGd5YjF2OTd0NHF2T0xWZ0t5?=
 =?utf-8?B?d3AzRW5jbWxCZGZrZUo3ZC9Fai9KUFR0SWZodklEbkJRZC9Uam4rbnBlbHdw?=
 =?utf-8?B?WExXTi9xU1NRd3JpV3EyN2pQUGNqSmNiL05Ka25zTm1OL2t0d1F5aVR3TTBY?=
 =?utf-8?B?azloaW13UGFDdENBY0xmM3JVYXBxOFNhQjN5VHdtYnFVOE9hU205VTdMM3hG?=
 =?utf-8?B?cTJ6bWEwT2w4L2pUdS8vUFE2UTlTUFMybG8vUURZUjcwbTR1TzhNZmh6Z1BV?=
 =?utf-8?B?bHJ4dXZyN0ZTUTJhYWZHSEJmQXZQZ000alJkcXBVRnNyMnhnOXFMSEtNb1JO?=
 =?utf-8?B?cjF2OWU1NlJmN3h4bE5BaUpwenBQTHh5MFA5NjdqcVlYeUxwYU5MNHFIRnZG?=
 =?utf-8?B?SWxRb2ViYmVtY2I3Y0txWGZGL2JGRDQyY0ZQYnRoc2dJRjF3Mi81ME1KTGJR?=
 =?utf-8?B?bUl3MGdmOWhpdDk3RWViY2tidHZlSlRESElCWUhYSEtpWWVtaDVrT3ZYSkha?=
 =?utf-8?B?RjVzb1JIa1ZZcWVHaHRoUXp0UzMwZllGZDNEZVdNWU0yK3BySkl1NVZSTFNk?=
 =?utf-8?B?Y3lwWnZDcnArZ2VPcGlKSU9Pb2FSVHJmNlNPVDdvbkd1WlFhWjN2OVQvU3Fh?=
 =?utf-8?B?OHUyY3RFem5hZS9EYVllYUtDV1NhV0Z2OFpGODNPYU9hRHpsVytsNmNUM3hz?=
 =?utf-8?B?Qmw3RHhqTFA3WEltZUVPd0wwZllXMzM4amxQK1lxQTNsdHVCY29SUFREUDNp?=
 =?utf-8?B?aDV1WDN2NC9mNmRaMDFpL0d4clF5S1BBUGhpeXNtcGJrUEE4azlwZ3ZNMmNi?=
 =?utf-8?B?cUVnWXBSdDdpYkRBRkY1dVNWSUpEMWtBVlVSVXpxOWgreDUrbmliS05jcExv?=
 =?utf-8?B?bkNPTzZNdk9BWi9WQmlUNCtwclVZVlJMYkJtclRZcjV2Rzh4QmdQcE1ucWQ5?=
 =?utf-8?B?U29UTm91dDl4b2hwZ3lCQjJ1eGFyVTdsckxXZzgwQVA2bE9NZE5MTW5TZ1JR?=
 =?utf-8?B?bW56Sk9mKyt6NGVrcVN1UDhQZkYzU3ZvNVNLd0UzcDNaaWJyb1gzNXQzT0NH?=
 =?utf-8?B?Y29naDJTU01xdG5vRVpRcDRnZzZYMmdrYVIwdzM4SFpNamdXdDE4V1A3dzYy?=
 =?utf-8?B?QVcydGEzOUM5MHNwUHA4ZElrc0VOVmJiWmliOWN4ZkpscUkybW9wZG5sQkwz?=
 =?utf-8?B?QkNLTkpuS1VicmV4aEQ3Si9CZ3lleWRMWEFHeWx6Y2ZwTjNRK28xSG91alBT?=
 =?utf-8?Q?Fsev+2mnngUxDfwhmzbH/XFhp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d57411-93aa-4b9a-7bf1-08dbb41ea975
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 05:59:59.1263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGVDruDGEv+HJ6uZ8fGHaAeStrxzSRHjHlhbJRTb0gN+ZXgjdd5ovpo3DxV5wRS5kjXryVdRn0nH0tuABko3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5390
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

On 9/13/2023 1:05 PM, Heinrich Schuchardt wrote:
> 
> 
> Am 13. September 2023 04:23:14 MESZ schrieb "Wu, Fei" <fei2.wu@intel.com>:
>> On 9/5/2023 6:09 PM, Fei Wu wrote:
>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>> board_get_usable_ram_top(), but that address is not backed by ram. This
>>> patch selects the lowest range instead.
>>>
>> I think multi-range memory layout is a common requirement, PCIe
>> passthrough happens to be the first one to require it. Could anyone
>> please take a look at this patch and give your comments?
>>
>> Thanks,
>> Fei.
>>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>>  arch/riscv/cpu/generic/dram.c        | 2 +-
>>>  configs/qemu-riscv64_smode_defconfig | 2 +-
> 
> We should consider all riscv64 defconfigs.
> 
OK. I will update qemu-riscv64_defconfig, qemu-riscv64_smode_defconfig
and qemu-riscv64_spl_defconfig.

Thanks,
Fei.

> Best regards
> 
> Heinrich
> 
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>>> index 44e11bd56c..fb53a57b4e 100644
>>> --- a/arch/riscv/cpu/generic/dram.c
>>> +++ b/arch/riscv/cpu/generic/dram.c
>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>  
>>>  int dram_init(void)
>>>  {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	return fdtdec_setup_mem_size_base_lowest();
>>>  }
>>>  
>>>  int dram_init_banksize(void)
>>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
>>> index 1d0f021ade..de08a49dab 100644
>>> --- a/configs/qemu-riscv64_smode_defconfig
>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>> @@ -1,6 +1,6 @@
>>>  CONFIG_RISCV=y
>>>  CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>  CONFIG_ENV_SIZE=0x20000
>>

