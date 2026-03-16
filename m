Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F98EEFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 07:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EE383642;
	Mon, 16 Mar 2026 08:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jzzlKyRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D4E8836D3; Mon, 16 Mar 2026 08:45:34 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3438352B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 08:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2Nz5bzU/0Qluy0Y2N2fdCCw9HBGByVnR5Q1Zz4W06b7UBFL7LjOJDvytDikGiEEBkSHGIWEyqyNt3UsG5+rfWg6nVENI2Tjyns/wUgUS/yZfdLqXKYj/0AqD4bckCfYBFMFw4RUEmGky6gChIEclnzERS3T7xVxVkM/AtmswVHBaCTMnZZMOt6GFbzVS7JTh3zxBe0StCnV2q5HR2Zip4xE9epMniDV9bkHSqv3eDt4995Ox8Dfkwd0wYzP2Z+eYtSimu6e/Ac/0sOo3N2E5syZA8A3cRA1xsGvBSc7Qc6Vk11xswLmPaTKn+RUb8CtgpZJXfjzEeG+548yfGyYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMpWfivigv0UFe+uw2lzFo5RUb5GTijUkx4/d3lIvkE=;
 b=xnKJKTtP55U0Q+Bc9JIxHx3FqFy94puq6Jxnr6J9m6PPAsLfi3TEvblQ5CfHzS7Rw+EyV+QCI28kfmVvfmY0gD5sM69jJT6us3j/fE54tcCCFGSnjttjruPytyG+k/ly72MFIddG4zVsDJiLiCRs0jd0aHVql/dhECg+0FNW+18tvx2kBwXoWVCzbM/zpmFLMuUHTonrMQ9OxgI0DEOpUqewiFDd4amlfvIDqqihPT786mRbvve5oSJgABGBzs1vRLBDfKuY5UyHfDMSAe99Ls4kXDhrrNLIpsYyDBI/pf49Ac29DZ8ebem3+R4WocWXMlwRpBWAnDR8eBnoeIkpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMpWfivigv0UFe+uw2lzFo5RUb5GTijUkx4/d3lIvkE=;
 b=jzzlKyRIBOCSfDBZJbv0bkyy5lg8izu8z45pwr4I+XeDXU3+VOhqSOnLZmcUBtHhDANYflkcf5Cb8n89puLNpCVdl0R5MFyyf5nNR3Gtl3Idx0lsnDSMk+knzNGzebqkS7ZrZnRnyWsqUmSFkq6RQs5FxXyMhozRqMbiDkpKZ/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 07:45:21 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 07:45:21 +0000
Message-ID: <65bb681d-b66e-42e0-b848-fa132e6255d3@amd.com>
Date: Mon, 16 Mar 2026 08:45:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
 <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
 <d0f0d10b-6d44-427d-9e55-103d5fd0e107@amd.com>
 <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgdogHiTDpuwCiu3k1yA=x2-z3GxeMgj69qbpJK-s18Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::19) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 359f1ca0-24a6-4276-a36e-08de832ff9ee
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: NYBKwunkHirgN5JsmghgIQjgVyEzIcSsfU4qBrYF4A3o3OPoVKPBKQ7L5BLwCTkVk9f+g+u1UoID1XoP9qzj+6CUMYEf3z0cpl9OUV3GdW+cnqRtQFeYOt5nNC5bVPq4mpf1zxLPTG8FvcmdyUMtWci+RC5li+hn1VAQi0sV6QizKsPNJn8bsXpGD9du2Xq9fqhZtvgpSvPV88TnbcfEHQoxwFKo/ff1zW4g6EYzAphaT5krJDzHMPcHIYnkwgJ/UTQpYmqAvqGXYtMsLFjAJAylg/4N7FUwMKgW64WUentZ94Q/9GvtjX0eskvHrWm0NYiCcd38XB60YJ2Git4wvUoiZLcsTgupBnPjAF3rbWPodfOx+/g1BOTXf64eLXzZ/ol+iWPPNvrgfuOTraGZeSTWTl+hFNeIevK200W8/KZThrjqpvQl/tpF/oz8OUr+0RpeMGrNlqSGx00nEHbS4o9CZME0f8rBdY9TGS36MwSwgrehYSvBY3Rei9BYW3hSeELF5JsCPWXhd7GOG603z523YxX5tiE8yqd+S0g6Bx0BSsmg3k8Mvc5wmlpWZLxD+0s7cbnrauPxLJr477ZILld2WIE7uTuoj4wWDh+2MsBj79LWVpe6B/W5xTqd0o7ervYsDELKZBGzpYs2YQJ/n+D4Kqq9jgf3s8CSXa8U243GBVVHLa+XKjq9QM+OsP7kAvqUk48J3zux1X1GSF2tkE7XPvu4tRW6H4Yppc+EvWdqHYilodaYwrhYwsJv2ZJM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNTUkpUU1JRT3hlL2ZhMy93UTZaaVFyczZvamxId3g0SnJMVkNNTUNaMjBG?=
 =?utf-8?B?RFIzNHVpYWdnbi9YVkR0WGg3UURzbDQ2eUE5MS9OdE1WK1RpTzk3U3hWZENH?=
 =?utf-8?B?ZjlSLzVIMnZZenZpVDVZRXVhOG9JK2hsYkJNNVIxam1GclpzMS9rNTdmendR?=
 =?utf-8?B?RndlRnp6ekE2YlRoaEkwWU5rRUtXRTliWU5wUzVucE1Gd2x4RnJSOGlWclZG?=
 =?utf-8?B?MWVQY1dWdzZrZy85MTJyYk4vbEF0cytCRDZiQnpNYnJlS1crQ3VxbnJsL00x?=
 =?utf-8?B?OUxWMk0wVWc2VFNDUmpVcG1HRlFnSi9DR2g5QzdKRGdSWmphQ1JMeGJiWlkr?=
 =?utf-8?B?Y3RuVWVQcW1IU2lteWR3Mjh0OFVJTE1MZ0U1MFVaOVRqc3lQNGNQNVcrOGhP?=
 =?utf-8?B?SzFpNUpTR1VEWmV1MENBWkJ3QVMzNnN6bTNDYy9nVVFqd1FBZGNjOGNaREdW?=
 =?utf-8?B?L0tSS3g1S3hmN3RVWjBCSWRaQnJoeXVSZk5KWmxnVi9YSmFNZjNEeHJnNVpP?=
 =?utf-8?B?V2F2b0E5WXFpZ0crZU9scXAzKytuTzg5STB3UXNKbytFb3krOFAraEtweEt3?=
 =?utf-8?B?dUVibm5TQ3FpSDZ1eFZ6VEpPOWJkUXpWRy9uMHkzelU0d216a0t4TWF5QVFi?=
 =?utf-8?B?bzZwUVhJbTRKaGxIamxQdys2a3cvc2hKL3FxOXM1NkNidDJ2RCtlbTI1czV2?=
 =?utf-8?B?Um5FQTR4OGluNXoyUy9Jb1pJR01jN3BpSGp5TmxPV2VJVjkybWNGa2xvM2E5?=
 =?utf-8?B?b25NTExzT2V6MmxZTjkvUjBQVWFxbDNvbU1RS1pFdXB0MnpoL0xFRmpKRlls?=
 =?utf-8?B?blRkNTV0UmRrV2ZTaGM3dy9iaWk1QVVzOHQ4TGJoYnRMT0dmTTlIY2YrSEdW?=
 =?utf-8?B?d1NNWCtkY3VFVVFoUHRUcXdMNU9oYmZDRmFxUmd6Skx2VWw0Nzh4bTg0TU5z?=
 =?utf-8?B?Ti9XbVc2Y0xXbytFS0grTHpGTUVGcm5nSHNDdmpQVkFYMmE4bWtVU2c2RDFh?=
 =?utf-8?B?VDA2aXpwY1FmUW1BL2NBWlVPWklCQ3NHeEF5OFF3czN6d0FxM0pJempsMity?=
 =?utf-8?B?ODI1ZytWUXFkT1NtNVlxeVVyRTI2Ull3bzZtV1RqYjJOR05ubUp3VHNBK3pl?=
 =?utf-8?B?bS9jMUN4Q2REVGoxNDZYSFBGNDVkaFBFRDViMW1sU1ZOelRSWXVyZVhqODJH?=
 =?utf-8?B?TEFZRjJ0M2QrMzl3MDV6R0tCQ1orUWl5QzZjdStpV0gveHpWUlc0WFlVenRL?=
 =?utf-8?B?Q2hBZEIwazhYQ0pUZE5pbElFQ1hvNU9KWVFRUldvVmhFS3g3aUJxK2dOVTh6?=
 =?utf-8?B?QVNYT0RvRDJGSXBmYTFCVmZrY1A2SFdtYW0xbUJwVjZnUExNbGQxN2dKNFkx?=
 =?utf-8?B?MkdsN1NlRHg0S1hiV2J6cktjSUcrNWJCeEJoNGlua2V1LzZkeWMxb25qMlUy?=
 =?utf-8?B?OGtOMGtBVEZuNVhUUVJveHFHZUYzemxxeDdLdW9nVzZxSjNWcDN2UWUwNjFv?=
 =?utf-8?B?b0kyd2tlalFOWVplZEc1RWNGTy81M2FSamN0Y1h5UUYxNG1aaFhZMlRoeVBO?=
 =?utf-8?B?WVBMM3g5dHkzVFJiWVdXbUdVNGQ5WE5DQTJ1b1BlQW9jRlB5Rnh4QUM2Q3ph?=
 =?utf-8?B?aVBrQ0pSbGJrd1pNaFlkNldRcnFxMTN6bFdLemZLWGh5b1MxZnMxVFlnZUpZ?=
 =?utf-8?B?UGcrZElmdm45YWpaSmh2NnROQVFsU0dqUFNmdEtIVEpXY2t6VzAwMWRHNDdM?=
 =?utf-8?B?OFVMT2ZObXFoR2V6cjlBdGJTUXhtM1AyMGNIem9NUytlS0tBaW4yZEhtRWZR?=
 =?utf-8?B?eFU0K3NFZ1FyVjNaS29uYm5xYTlsVDFhY05uNFVFeEhoSHFYK3ZCME9rZTRF?=
 =?utf-8?B?dGVWTnB1NTgrdzMxcGxSdFNQZWFUS25RZWV5b29vYUFEZS9reTdiekhvL1JY?=
 =?utf-8?B?bjgyanVqcW9uQk1BcjVxaHAwWVhxMGpnYU4yekhrNXVmNno5Q0twalZEVUV1?=
 =?utf-8?B?MG44ZEpUdnVYd2srNTIwZlZ6YUlrQjVMeGlRS25ETnhNbk5xcU90Yks1Z1JU?=
 =?utf-8?B?eE5CRXBkNDdFeEVWN2FwNzNtemQwWVAyNnAvZkVwRENaT0pVd0dZZWQ5K1Nl?=
 =?utf-8?B?TG5yZllFMFlwekV3SGlVNS9WbWthdW5IRUtCVVZnM0I4WDl3UFhWS3hZTzE1?=
 =?utf-8?B?c0VHamlCNlNha3dWQkwyVzZqdS9jNWNtaTlUZkcrKzk0WTB6MHppYjhUeFZN?=
 =?utf-8?B?eEE4VTBmOWIram5NbmdnTHYxdUU5c1p3bHFscXdldmZvSXAwdFlRM2h5SWFW?=
 =?utf-8?B?RU1NU1F0QVVvYVE1UDBWNDZXVndock5DQ3lCMGZmbC9QTVppejNOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359f1ca0-24a6-4276-a36e-08de832ff9ee
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:45:21.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aex/QDg/0DbeHCcKl0Vb4XaJvoSTf8PlvBfYYc+NIZAxLlX98lCANUZnMVnlfArU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
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

Hi Heinrich and Ilias,

On 3/16/26 03:43, Simon Glass wrote:
> Hi,
> 
> On Fri, 13 Mar 2026 at 09:50, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/13/26 16:47, Peter Robinson wrote:
>>> On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Michal
>>>>
>>>> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
>>>>> introduced efi_console_set_ansi() to suppress ANSI escape sequences
>>>>> during unit tests. Extend this mechanism to be runtime-configurable via
>>>>> the 'no_ansi' U-Boot environment variable.
>>>>>
>>>>> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
>>>>> at the start of efi_setup_console_size(). This prevents
>>>>> query_console_serial() from sending ANSI escape sequences to the
>>>>> terminal, using default 25x80 dimensions instead. This is useful for
>>>>> platforms where the serial console cannot handle ANSI queries.
>>>>
>>>> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
>>>> It really means don't use ANSI queries to detect the console.  So
>>>> before creating an ABI to the cmd line should we really call it
>>>> "no_ansi" or perhaps "no_detect" and in the future clean up the
>>>> variable names as well?
>>>
>>> I wonder whether this should be a Kconfig option too, a maker of a
>>> device likely knows when this is an issue on their device and
>>> explicitly enabling it via a config as opposed to an environment
>>> variable would likely be useful when there's a menu enabled and the
>>> shell possibly disabled?
>>
>> There are a lot of Kconfig options and variable which can aligned it.
>> It means we can create Kconfig option for it but likely we should also have
>> variable way as common way in uboot.
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> It might also be worth reconsidering this old patch:
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20231121113557.800353-5-sjg@chromium.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-11-sjg@chromium.org/
> https://patchwork.ozlabs.org/project/uboot/patch/20240902011825.746421-11-sjg@chromium.org/

We have met with this problem on real HW last year and based on it we created 
this internal patch.
https://github.com/Xilinx/u-boot-xlnx/commit/29b1330570543056188e5c065f1ea1be064b3a4b

And we also send it out
https://lore.kernel.org/all/SJ0PR12MB66857BFB90475FE74294CF0482C22@SJ0PR12MB6685.namprd12.prod.outlook.com/

That's why I would like to get clear guidance which way you want to go and how 
things should be changed. If you are fine with having variable/Kconfig symbol to 
disable it, then I am happy to create a patch for it.

 From my perspective this is unwanted feature and I would like to fix it clearly 
to make sure that I don't need to handle that origin one line incorrect fix in 
our u-boot tree.

Thanks,
Michal

