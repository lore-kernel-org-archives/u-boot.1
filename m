Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6774CD6E56
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB9FB86CC9;
	Wed, 11 Oct 2023 12:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J5CHqcce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9475786CCF; Wed, 11 Oct 2023 12:05:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4136786C21
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697018722; x=1728554722;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=9Gl9vLGhhOWyDRFRKTEq7cn9ISAZCK5uG96aH02VlAo=;
 b=J5CHqccettXJlRzJPnIQyRq21HYIE9f7PPQuZkFzx7gswZNMC4U/SYCC
 d1eDF8Bx0hnuImRE6zx5f52wDOvny3QU5Ht8V4nTVsLqKdlwealiH6vTc
 C6OBklUw1A3+q/RrG2G/PMAvBH0QvVTPd14FRAl8zzjz5AGAv/CppyEn/
 XqgVjZBlWSlXQVUrXJxwf5CxukE/7SWHqDcfO0CS33Gxh9hE1/1F2qolI
 XxntLb35MLN6qv/Yd/t1ebHXQFwFkmJw0a5Gl4L6JS/iV6Klm5iKdXIqo
 8zRFIwhTLk5+BilEnn4xkP2cVeRr5tSnvvr/O6K1lBvxoKCO1PqVJU9bX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670114"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; d="scan'208";a="415670114"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 03:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1085174882"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; d="scan'208";a="1085174882"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Oct 2023 03:05:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:05:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:05:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 03:05:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 03:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWFu4he1yYdF7IEQ1nBamnITQECcRy/FtyES13tXRuI1P0vY8HsX6zRwosU74Lc5WmAGrBpmxxhzYguGqopLbmUfULRAzBFz7pzWb4xh7sHjjdu2SoUOe2KcCi3OO0aVmwKoyOJHCFwX7q81GI2Wz6N3TcjRtPFheb6JoKVxRCAcHwLwW5RUCBl5m+zT8/H+fYSacqasr5X5wDkO/z3j54UDU+6eDNty++HIknZVGfFTa/TqZ4nAGGoA1xdt4ZeJBLkfF3U+Gasd6PTQ9JkgiBx4adT9ImlMIG1ouO4y2hCsOF7SDVWN8sXhNEMVXIGMfNr11Fai7itukuHoXDbSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TJJmDdl5ICbVF5oDlBo+PMYHIKvt3zIgzezrre6mww=;
 b=PmH8Rb4WZtFXBUfARdzErpeYZmlGlOj5cQKp6widDs1qeF+jVcVqJ6Oc0qKwgv8AX6SppaQ6Yp8noLn+ueCbBOxR+vXXQsIBrBpLg4QWctLWjz39blhyRyz9ie3o1XRnHlvxUMzzXDN/3RYDXQFYwpE0xE1DRHIIbiZI8dy8XSlV7Bag9CZukZv6qJwfcoWsgP6GhPQlTaDs3GIYtRLJHpfEOqtgi3QVYWxPWPRRD0Gopd5UKinpS7CGg/k3zYTmlhuV7Q8Pgmts+orWKZR7mKbDj5wepywnP7S5yU9VU/iVhmKKgwkLGwtGxcx787jfo3Ep9PG1Xm3eWeLdqbCnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 10:05:14 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::2283:6ae8:35f:d709]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::2283:6ae8:35f:d709%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 10:05:14 +0000
Message-ID: <f55eb8e4-f01d-56ee-69f8-be50a979728f@intel.com>
Date: Wed, 11 Oct 2023 18:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
From: "Wu, Fei" <fei2.wu@intel.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rick@andestech.com>,
 <ycliang@andestech.com>, <bmeng.cn@gmail.com>, <sjg@chromium.org>,
 <pali@kernel.org>, <u-boot@lists.denx.de>, <andrei.warkentin@intel.com>,
 <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <0af4c686-2bc5-3fa8-ca98-0ffe4caab3a9@intel.com>
Content-Language: en-US
In-Reply-To: <0af4c686-2bc5-3fa8-ca98-0ffe4caab3a9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: d62c9e24-cfbc-4fa6-b64b-08dbca418fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWgpauqwTt6oz2A3xStdYmIK8ZFFRloik1MnDRwrRhSAXdmM0loSaZe+ZtAR2komS/qgxQxQ83tfC1UXTOE/YnvqDX94JNPpj59URxeZrrZFT6an0RacO/2XqPn6SzlJHVzItTcqd4wR+lRPjnehTcpnIIMta3sHKb5/eQvFXrZ7K7CVbix9tlyvJJ0DOwkdHPQmEtddlXxxi48ENf0VHCdL2AB/75PL26KPHn0oCY9qv6LLcvW/bAOyQwgijk5P0KHkC0LcVwBi1XNkDU4wqhBXzwzWEydXVf/8q6JRq/EshXiyno4H3mtgH4usgdUtfEkVLksI6BUW4PQ5b5GLLeF7E+cmlUaXskZqlg9Vy5VajvaTcVwCdLYcFsRdHTtdQuRK9+9mIGDg6ChuSt8+omQmwQ/NiJBnDQzjEgscWFFUNql5YsRSdrJCymiDh7GDmUE/QCAfnFrnn21tlcgaqhEXZ8y9B9dOf1ofugoyJ3OcKe+Wb6bnOwxR5mCAE30ldg5Sjx4tyZkTHJt5auzwugExXGaQgnWe1ogfnYGsAoa+QqjKWgTeW1mzz+Tiz0c6FBxGKahZOq3Cii4rwi9yON5KP2VQxJle0+WEqCeVJGIvD55FO5mLuefjpVS/HvNruTB8mRomYjzm7RYESAaC3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6512007)(316002)(66556008)(2616005)(5660300002)(66946007)(26005)(83380400001)(66476007)(53546011)(6666004)(6506007)(8936002)(41300700001)(478600001)(8676002)(6486002)(2906002)(36756003)(86362001)(38100700002)(31696002)(82960400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlMSk9iSm9EU2pIL3J1MG1Sd1F2SVI0U3cwWWhqM0lueVNrMkdTOGZmeHYy?=
 =?utf-8?B?SDJBMmQ1RnluNWQxaVdqZ3o2WVMrdmUzZFhDL2NPM0R5eWVoYUFqUGdGR29l?=
 =?utf-8?B?cEdNSitDWFdyVVR3RFY3eFBBZG9JWmdpVGNuVmZOdHJUR0hqM3BuVXllZUg5?=
 =?utf-8?B?LzFuMWhwK0xIQTZ2U0lqTmxLa01kTGpWdXlNTmdCZUpNOUd0dWZPd2ZTQmNl?=
 =?utf-8?B?QWx2blUwWFA2RW5vTXBIaWFXWnNBL3ZxMlR2T0dWTUZTKzBPSG82NW1Remp5?=
 =?utf-8?B?NlNYWWs2WjdNeHRsQktrZm5OUXBPejZVa1B4VmZ6ZXh4aFpoZDdtb0czTGtL?=
 =?utf-8?B?RUVaSmtkNFdmdkdjTzVka2FVWWE1allQWXVZU2ZJczlPbStjMmVhdThKUFF0?=
 =?utf-8?B?aXI4UmEyRDZYNTRqZnZDTk5vd2RPMlc0a1ozUzZjVlZYVmlNUjA2N1I1MG02?=
 =?utf-8?B?cFF6WFR1UDJ6aXA1My8wem95Qkhtck9hR2xuZHh6VCtjUWlGbDV3ZllDd2t2?=
 =?utf-8?B?WmFLZnh6VVdCNTNqR3dVdU8rSUdIMDIvQTRLSytqdzUyVi9iN1Fid3Fla3RO?=
 =?utf-8?B?YUFRSDBFZk1CUUF2RzUxYWVKa2RvZEMzOUd1NHFPejZpREQydjB3cVMwN21C?=
 =?utf-8?B?V0I1eWJnZE9GZHBITGdEdWF6Vnp6SlZycGVmcTFMWXhaOEdGMmRuQk9WNnJH?=
 =?utf-8?B?M3J1aXBGQUhXZmluRGx3bzU4U2xUaVpteW9pMW1VSkROaFFHWlZYRTcrOGdk?=
 =?utf-8?B?SFc3WVVqZU0xNWVQN0wvUUFwSG5JUW9nQ1g0OGdUSWlGS2ZDdEh2bjNXcFVN?=
 =?utf-8?B?dkxodmkxRjBSYkhuWURaK2tyOGJienVQdEdtOFZoVDJRM3VncmJYQ3U0QVh2?=
 =?utf-8?B?TVpUSXN0c3QzWG1QcVFUOFY3TG9FVnJwZG5pcGJvVzVHbUJ0MERWRkhUTS9P?=
 =?utf-8?B?bnJ4T3JISERxRVQ5ekpjdEhHQ3VYMGFEdlBiNnlxN0wyWFk0MUFFR01CK2F6?=
 =?utf-8?B?b3NpVGJxR1E1ZGVLMS9XVXZEV0oyaGVaYnhCeENESC96cS9YSytjY0NxTCs4?=
 =?utf-8?B?Nk94cWZmZ3hkZ2tnNCtLeHFlRG1tWEYyRkVKejR2UERLbk82YmNVOEVnUjdt?=
 =?utf-8?B?blh6TGJaT3ljQnc0dndHZ01lU3F5REdvQ01qdUx2Wkd5QUlaM3dYZ29FcklC?=
 =?utf-8?B?TjU1UFRtOXdrOC9aam44TElCREN1eEZIVnVSem8vVHhqTDhZRitYTFlGVFZJ?=
 =?utf-8?B?OVZORUFVdjl0U0NxSnF4S0JLeklBMVppWEpnZEtxWXk4T3Z2NTZLY1BobXNX?=
 =?utf-8?B?WithWml1YjRwblhFVmUrajBFd1Q2Q1QvOCs1QkFTYU5QQWZOWElXL1V1RXhG?=
 =?utf-8?B?Zlh3QWJTYTN6RHVxZjNzK2U1ZDVrVWlMa0F6eFRxK0VpSlVXL3BSYTBsajlI?=
 =?utf-8?B?c1lKSUJ4dzM4RkFlQnpURDJoWlFUTlhzSWZQYWs2d2ZnbjdXb2JQLzlGaTI0?=
 =?utf-8?B?WU1tRnVxRTgydzRwaE1BdXNTQVZmTENZVW9ZY0hNamlpeDdnWHJma3dwTXVD?=
 =?utf-8?B?MnhxeXRwNWpDU0t1N0dGOU9ScjBOSmtINnJpOTE5WGdhTTVCbkpSenFhS01r?=
 =?utf-8?B?b2xOVGFJSXVQTXFoWW5uWkFsWThYTFp1TCtnZEttMXA5V2o5YmpnNm11Nm9U?=
 =?utf-8?B?TE1yb1NYR0N4SzZLeVh4ekdLSzgwWEtzUk1ib2JTZlNZWERxSHhqcHJaMkhI?=
 =?utf-8?B?SU5iclBmMkRuWEpNODBja1lvLzM3TXVldW9MaEhjV3BpcFcweXlHQlh5U1RB?=
 =?utf-8?B?aUwrK1lIeFNZQkZSbVNJY1FPRkd1aWVLY09RYk44L3NCNHBFYnVtRng3VmpL?=
 =?utf-8?B?ZlJZL1lLcExKb2VTRldEbnhZbTgvVHBQdFNQRjI4VDNkM1BsWmhjSyt4Ym1R?=
 =?utf-8?B?ZEVMTzdORWwxTEdVeitFM2lkZTViSE5KM3o3YkhrZnlLUG5KUkUzTXF1Sm9V?=
 =?utf-8?B?SitORmcvaUtRYTNTS0hWVzVXUmt3ZHFwcHc0UGIya0NCODVUQmJ2VGdBQ0cr?=
 =?utf-8?B?cWNXL1l2YVhHM0xUTndsQld4b1RzOFRJWnVJdiszMmlDSTFMSm1QV1FzZEI0?=
 =?utf-8?Q?wNsHCNvToT6fzbT6TQUcm+R2D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d62c9e24-cfbc-4fa6-b64b-08dbca418fe9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:05:14.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gm9F3Sx1gCthEGeCrU8m58qmSzwMIWjSwFzssgF4vYz+w1TUkWA+qNNIE3B1qQ/GZGVoUqE8+IPIHOrWrsF4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
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

On 10/9/2023 6:04 PM, Wu, Fei wrote:
> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>
>>
>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>
>> This should move to 7GiB - 1 in your example on riscv64.
>>
>>> board_get_usable_ram_top(), but that address is not backed by ram. This
>>> patch selects the lowest range instead.
>>>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>> arch/riscv/cpu/generic/dram.c        | 2 +-
>>> configs/qemu-riscv64_defconfig       | 2 +-
>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>>> index 44e11bd56c..fb53a57b4e 100644
>>> --- a/arch/riscv/cpu/generic/dram.c
>>> +++ b/arch/riscv/cpu/generic/dram.c
>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>
>>> int dram_init(void)
>>> {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	return fdtdec_setup_mem_size_base_lowest();
>>
>> Linaro is working on allowing to download a distro image via https and installing from a RAM disk.
>>
> It's okay if we don't do this installation and pcie passthrough together
> on risc-v, nothing is changed if there is single-range memory, 1GB is
> large enough for other cases.
> 
So far there are the following methods:

1. use fdtdec_setup_mem_size_base_lowest as this one. This is a change
to generic riscv iff the multi-range memory is applied, which is not the
case for all the current riscv boards. If there are such memory layout
riscv boards in the future, it can have its specialized version.

2. specialize dram_init() for qemu-riscv, it limits the impact only to
qemu-riscv, even if there is a need to download image, it doesn't need
to enable pcie-passthru at the same time, so no impact from this
perspective, the drawback is that qemu cannot reuse the generic logic.

3. a complete solution for multi-range memory layout to select the
largest range for all architectures.

Are #1 or #2 acceptable at this stage? If we go #3, can someone help me
drive this together to reduce the email ping-pongs?

Thanks,
Fei.


>> We should not artificially reduce the RAM size available for U-Boot by restricting ourselfs to 1 GiB.
>>
>> We must ensure that ram top is in the upper range.
>>
> You mentioned a generic solution for all architectures in another
> thread, it looks not trivial for me with little background on u-boot,
> e.g. something is confusing to me, when a board should define
> CFG_SYS_SDRAM_BASE, what happens if gd->ram_base != CFG_SYS_SDRAM_BASE,
> I'm not sure if you or anyone can help drive this together. btw, the
> good part of this patch is that it doesn't change the semantics of
> ram_base, and the best choice is the largest range, the upper range
> might not.
> 
> Thanks,
> Fei.
> 
>> Best regards
>>
>> Heinrich
>>
>>> }
>>>
>>> int dram_init_banksize(void)
>>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
>>> index 9a8bbef192..aa55317d26 100644
>>> --- a/configs/qemu-riscv64_defconfig
>>> +++ b/configs/qemu-riscv64_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
>>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
>>> index 1d0f021ade..de08a49dab 100644
>>> --- a/configs/qemu-riscv64_smode_defconfig
>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
>>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
>>> index bb10145e6e..66dc2a1dd9 100644
>>> --- a/configs/qemu-riscv64_spl_defconfig
>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
> 

