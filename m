Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5095ACE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 05:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6394B86B18;
	Mon, 25 Sep 2023 07:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SwDncUBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6A986B3F; Mon, 25 Sep 2023 07:53:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C2E88692B
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695621182; x=1727157182;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R4S3yPrKqa7kJ7FGpA4DZTJSVZSfjDbptekTd55w0VA=;
 b=SwDncUBuvfskRg3NleW/0gQLx5gKpMdU1P8BD+U+Q7yXgd9l0+pHwpAu
 StM6HykVGYF/oiM8mHSDnKLS0Z6sIQ9WBS8ZHhPtuO3x5FppzZEsjAUQo
 0p/acuevdl5wyCmAFJqRZikslXcv9aVsj3+r37cd8irJn2X59AC1NvB/N
 zQSEjQeGpmYQj4P6agxkkOjwGFv3dhOk2OxQCDizoioLfZu9SfWr2lNuM
 QYQaLMFfdhslL2hTe8CdQGZ3+PodsokjnuOPcSRx/XgC7kMYLiXWKEdqd
 RnqyBfINXX90ffIg1YXpCkMzpjYcb+xgVykZYtmgO3qesGDIDFwia7p11 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371491258"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="371491258"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 22:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748239719"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="748239719"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2023 22:52:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 22:52:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 22:52:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 22:52:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 22:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giT497I0aNo+ffd8xTp4Sy+eAPIpLpmqvSofQesJOdTGndU5pbYxBi//hp8wSRwOuNtX6m4FQ61jro1cO5qcV1eQoDYqS7+adPns08LSnTCXWAnqCD3Yz8naWEUzTVR+RC1eRU9N4zsbQ8w2bNGiahV2CCble7qfWiS1NrQheLck4WzISCrh2BfNgHAKqOria+bLS4BF66aTxTE80FvJ+KyWHditeEo8xPfOYFZSAtOoHcCSjOqYLHdiJ4rEdR5jbjF91z4qU2U8alMMuRjRKOZkOqyOdBBhSsFXf7p7bl8oJFhJ/qF60Mdtn729WJrT4423ruez1ifJHNAB6SZGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7Y4OZrnpuWla/nFusBZy/Nt3wCsYVNc1vWqdT/+7aE=;
 b=AHXTzJOI2udyGRWQvmJulfbygt/zaaP6VlQzbvszV67NK0loyuGj+6nfcjsdPrIsFSp6PyIklpkZGJL36Q8WZb7ta3z3bne3NkdaPi/+yzoO873ivu+ZqwAZeR1MbUR6fmbAZgKdy6ikx1+Zn5dccplnT7AtRbxacgNq9VYg9uQ1IUglK6tM7y7aHmBBWBEjoOhN9nx7Jd59BpNUzaVomDb26OrkAb/CdNnbbZF3ZTpYwUOHKbi2bZ6H0pPRmMB1wFeI/Sn75qcJEAwMcHl+JWasvwsXZHgby7HH4voEaHMYssTNextqdqV2p9YTYpImAKvPZg7efVZLVUIlXe+R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by DM8PR11MB5638.namprd11.prod.outlook.com (2603:10b6:8:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 05:52:55 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:52:55 +0000
Message-ID: <e9890ccd-cae8-6ac1-98b1-2917142eb886@intel.com>
Date: Mon, 25 Sep 2023 13:52:43 +0800
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
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|DM8PR11MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e4e500-231d-4d63-1444-08dbbd8ba9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56Gbu4da6iBdjVHkDeE42/fmholUf/qpmgVJYebKPy+i30EzNM56ncMsQoOhlym77xdHKMKsGF0Xc4VoyE1GcS71zHzsWrdzvc7AekEGSufH/WjnUxaBU16fixDfdBsUgtJ8UuDKzNrBDeO7kCOZFzzEL4OHuLpxXh6o/duwCm6xWjeWvJnJXx+t3J0/aaWZcSwDxjI2Yb09cFiS9H/gh8h9JjEFTtgFeSwjTyRBnNb4FLYYFs2oZt+jl/Y+SRt2d/ROyjk8YbNCnBBKedN711QhxoYyAsy/fzKr5B622JRvZvZ3OJEoX8WV9dYuVgA+Y4nArH93lzCxg25KHLvs3bJO2Hgpq6GTnbRrfobOUtsr4j1gSe88XLFU7SA74Epf2J1m2tDiMn38APCKEClUWZ6sC0ICluBjvOnC5Gu79iUs6Xj2p8m9e/9uWLJvBazF1+Ix+lLcd9huCHdESX0n3seY/nwCFbqSqN5OF88Mbf0GQR36RJa7S3r5hvKf9l0QGfwbolvTyEKMS2NpHALc5xgrRT9oefacx7K2IUMKjy65QE3KwTjk46R2ZS7DXIzMoKT4wrijLy+rygq9HXLSXDDdsJNBMJ2J2rvtrCZNDwG0Hm5HvFivQNbJsBFFrUuxGLfGMnzsbu2TbD9WRtkGMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(66946007)(53546011)(6512007)(6506007)(66556008)(26005)(86362001)(6666004)(82960400001)(478600001)(66476007)(6486002)(110136005)(966005)(38100700002)(2906002)(4326008)(5660300002)(2616005)(8936002)(36756003)(41300700001)(316002)(31696002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0hueTJJZ3dRZnJtOFRrT29UUDFiSzEyOTFMS1lCeHB3MnBsL3BBR0xjbnpT?=
 =?utf-8?B?aEFkLzRjUnB2a2lOZmpmYXplVGM0dWMvSUs5di9MdWpua2w0RTk3NGpDekVs?=
 =?utf-8?B?QnJIb3FBNDlDeC9UdTA2NTBhYVZUN1pGUEVMdWpXVVVzYTNkNHIvRkRlanVL?=
 =?utf-8?B?MmZwT1J5NHgvL3R1Wk1hN1JmeHdjY2E1cHlza1lxTkFEU0VmMVVidFZGaFla?=
 =?utf-8?B?My9ELzhrY3IzdnhSeUwyOGZmVCtYVW04aVVjTWNYSmRCQXFFR3BQWkE5cEdi?=
 =?utf-8?B?VHQwVFYwNHBCMUIzcUQzRWFXbDNQYVJ2ejUxMVNaZlZEdWNOQ25Kbko5b0lB?=
 =?utf-8?B?TGYzRy9NcUV1c01VL1JSUVA5S21UcDY0d3lYeFRNWk9UaCtMaWdXNEtxeG1K?=
 =?utf-8?B?cFFzT3RZRDBxUUxzdi95VVRhL09WWE01N0d3Mlg0SXp1OCttWVliRHV4SDhG?=
 =?utf-8?B?Ly9BbkNVMVF6NEFnd0JZREhLQkhlSTF2QXozYVE3YmQzYTFuT1RqVnhlcEVB?=
 =?utf-8?B?QmNOWjl6V2Rrb29TNG9uc0pwUXdjbWNoOGFHczhZOVpEdDNJcVdSQ1lvaWtE?=
 =?utf-8?B?azNkRm5WSldGalI5dEg5WDJ3dlZkR05uaDFEL1JQMS9NNG1DSGJRTjRDZUh6?=
 =?utf-8?B?S1hGWGpIODh0c1FhelRPeTJ0TmdXdW5KMnFxNitlVGJwY09VWmRHa1N6a1hz?=
 =?utf-8?B?WUxVM3JRSkU0TlVaemtWdUVUSmFOZEdZWU14UWp1QjY0eXR3RmVtWTVqaHcx?=
 =?utf-8?B?emFwUW5ZckVuNUtYRTlKcFFuZ0ZwbVp3bVYwa0lGNGlYWmYwNi8vVVdNbnQx?=
 =?utf-8?B?Mmt0N3BtMi9TZ0I3NzlCTVh2WDhaeFFzOEMzZTFtdk54bXpWZDJQRWM3cVJj?=
 =?utf-8?B?eDlPK2o5aHlyMjg5aGs2V2Y4eDg1RWhxRkd0QXJ6YXpxOVdPQllHQnJtN1dH?=
 =?utf-8?B?MHJFUitOWDRSdGhlL01XNGFaTE05MHNma210eVdzODVZZnlSZ1RONTM4ZEY0?=
 =?utf-8?B?dlNLWVNNTm1PNkJtL1J5Y2wyakdsbkZDekMybFBKd0drc2hqVjNIam10dUdY?=
 =?utf-8?B?Z2RaSkszVXFYd2dEaDd4ZzVKdVNWbFEycEl6a0oyaHpwNVN0V0d3cTFQVDl0?=
 =?utf-8?B?NXFvUENlTGI4OVNnSndkUkNiWUNmcU9RRmtFUXFnei93eXhVYjdHVXZtM1py?=
 =?utf-8?B?ek1lUm0xZHlKWUYwVXd0VmdzVE82MGdQelN0QStrR25jcWduWmZKM0ZqMVUy?=
 =?utf-8?B?SmJJVEdGMm5SYlo2YjduQmVBWXRxYmRZQzBhalVuV1B0cnI5ZGRUeURBd3Yw?=
 =?utf-8?B?MXFUbThuZXA2OHlNTVNaSFNHL1RCMXAza0JQcW83ZHZzQnRRUk1UUVVsQVhD?=
 =?utf-8?B?ei9MZm1LVnJ5STRXR0NmekJvQTNDUkZnWFJZbzU1MWlDR1NxU01YcFdxUGVT?=
 =?utf-8?B?aEw0WFlHR0VYNjJtbHBMbmROMWRSU1FXOEpLc3BVVlVYUkluaVBVZVg3eDFE?=
 =?utf-8?B?WXpLQ1JsWVdsQ1hzbGxIV1czVERlY0IwZVlTTFpSdnZldjkvWmdPZ0svQnU2?=
 =?utf-8?B?dGg2NVNVT1hIbjliUk9HeVVxTkxhWHVad0ttMHJGM3MvQm9OZU5MTnpwUkpx?=
 =?utf-8?B?V3NyZ0I5TUNQd1JlOEZGT29SM0kvNndITVQ3ano4VUdUZDFsdXhDVm9UbUV1?=
 =?utf-8?B?WXBBVWR1R0llVTZDUU9vRnFiUEkzTk9KRUlWdXR5RmFEazg5Wk56dThmdFZ0?=
 =?utf-8?B?REpDOHRzSnA2bSszcGRvbVdYMWhGQk5Pc09yVEFGUW1OQ05TN1hwMDI3ckps?=
 =?utf-8?B?elNjUHI2bUlXN0VGK0RJMXo0UytVS3pId3FSMjBJcDNnVVIxR0FJaTlHWjRm?=
 =?utf-8?B?U1F3L05nbW1TT3QrR3JiY05lUjVQbStRVXRDY0hpaUhBUDcxK3dqV1pERFBD?=
 =?utf-8?B?azk0d0FtSUdFanpkbUNFbHEyazJTL3Z0QjRQT2FNT0psNnpSWUZrSWlqNElx?=
 =?utf-8?B?WWxVZmJoWDJsa2I4K0tocUJ5S01sY3owRkxnQWtHbTBKb3hvV3d2a0ovcmMr?=
 =?utf-8?B?ckZUd1BzSXBQYzdoZDJmMlEvQU44bE45K0E1b0RVSllRZEZsWFdZMS8yeWNy?=
 =?utf-8?Q?U9n++WOJP1WV1oFdeesiXGuGL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e4e500-231d-4d63-1444-08dbbd8ba9f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 05:52:55.5029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ukp1qFMIec1OALu1jeLMEq8/qbesrZhAnn5HKO7w2VjaWFQ6EuEE5FqFihszrfqdrMt+wO7sF4lHeHN9nZbC9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5638
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
Hi Heinrich,

Besides ram_top, ram_base is another one we need to consider.
setup_dest_addr() has:

#ifdef CFG_SYS_SDRAM_BASE
        gd->ram_base = CFG_SYS_SDRAM_BASE;
#endif
        gd->ram_top = gd->ram_base + get_effective_memsize();
        gd->ram_top = board_get_usable_ram_top(gd->mon_len);
        gd->relocaddr = gd->ram_top;

If ram_base is modified in #ifdef, ram_top is still not ensured to be
backed by ram. I tried another workaround w/o this patch, it boots up
successfully:

* return gd->ram_top in board_get_usable_ram_top() that's >4GB
* comment out #ifdef here. This is necessary.

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

