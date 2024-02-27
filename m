Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0838C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 11:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046D287FD1;
	Tue, 27 Feb 2024 12:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTHjpPT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A74387FD2; Tue, 27 Feb 2024 12:04:45 +0100 (CET)
Received: from outbound.mail.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193E987FBF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 12:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOyxKSWaPhDZiFB+cf5KU7Jc4XJGW4F1W5eAuNI9j46yiqPEdVC3/O1l4eQFRrLzwlUtmaXD0knilML/2IOdIr/CDpaqu/rLszq6V5gchbk4UxKlDacM2tMxoMqhoS4tSHBmd0aD/ocMPo9kqkEZRZZcb/PzmhrUdI2N1WiFiWh7eg7+MYBQ/Pbs0IPxUpWmZd5/4rdd0J3IIxifJZZrTt2/FN8I89pQQpkhk6AN3OypF6USoA2UNspFdFr25y5gfTWyb6/Vl+cv1hxdBmQCzbPY4YZxNJWi+Mbkk4HXwAFmYOpTtTB4V40OwJ9b171n//nQUI/q/LsyFqPlBqrDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+M/6JaT5GCoyTiqmVEBvR19V+ci+NJfIPMg/s4cqiQ=;
 b=Z4nYFiFYpaN6Yc1oHmgYzGt1dDKL9VHa+ENq8Jd6cYOz2N2l9OVf04cqT4dFQrNguRFebiHtAeoULu3U2w3kch3U7DLLRK8OjwxBkzQbAWKozuZs1WvP0SZClWk71w9Jf5cyqA95mweCmRL9POl6hf3cusElJoC9fnas2zGm5fzoqixXDk5CUxak6l/7rcNibZNiOkDlftFw/m933nw2IlOji3Zov10bdKYtow8XlOLiFpaN6tu3MCnSj1fRMxJm3M+BjSV6/RttEK4zILeu9FXWc6Y4SzCVOasuMAc/Ao+mqzm+Wy8JqKEs1kxp8J7hjVAqkkIsGCEx/xWLyinHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+M/6JaT5GCoyTiqmVEBvR19V+ci+NJfIPMg/s4cqiQ=;
 b=oTHjpPT/8UBGJrPWH4epor7OZhsO0F4l7GAYDC89doXNfZySSNRYlTKTuBvGN5oApWMVBkzPK8xCIcVS89gLqhRsnijrbb6cX4UvOEe4kiRu7QSMbVrLDsOXtj5abdblaKLtUywo2gfSzTaxFssHCRhcB5JZ/FfPTxjio0sxF0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 11:04:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 11:04:39 +0000
Message-ID: <81642120-43b9-483e-ac29-d8445f4042aa@amd.com>
Date: Tue, 27 Feb 2024 12:04:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add label to pmu fwnode
Content-Language: en-US
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>
References: <20240227084008.2086287-1-lukas.funke-oss@weidmueller.com>
 <95f2396d-782e-42c1-8579-ca1a55d788eb@amd.com>
 <ee6ab688-49b0-4385-8144-7c37eb5bbeeb@weidmueller.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ee6ab688-49b0-4385-8144-7c37eb5bbeeb@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d2811c-73fe-4dbd-d1f9-08dc3783e42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSZTPbVSQuRDYyukSWhmy4aSOxf5C3oxyffItUfGGok5354PaX72EbxbChc9Fo9udVKd1SI9VHW+fg/gzPUagfldlExKOQnuZ9ok+/rKpHIYMgBfxtuAkEpf9+VSmTghIwSKDMmustFvVHh6bxwaZ/yrSZK3cLyFHBVzy3cttLhw9fw4tT+dsYA4QgPcEH2eQoGxKZOsnHbYduvR8k+fgG23BJ8NgzyriJ1F1yq+TPGD5DwIy7F2qLjNYScqg/kY9UBcK1Si4lXgS+yOQB23/ss712zTDbts2TlDKxBD4SKXSL54ka9zFahcs/PRbNxhKftewL4zGSYX6aa2FR1WVrKMmKRZHb+UfUMfRjX34FwWvPxhbVQm/aOKD1wonVuZ4UHIjLPUehGphmKJYhL7poyrR4jz8NMwE2p6mbvp1GM1Snjv7Z6BX9AfZJb86QpUcDONNXKT025dvDAyk/HiwxsqtVcT1xgrj/OWKmB60teZGbIKrbq8r5+HQqAv1/2jwenIKPYE1n6fld2LKvIl7dbR98OCzHk15tDrCOIPIrrYTvbu6G9Na/53ItH/4igarIH3nPzQlQxgKRLsZ+6A78zWGeW9b7UBsf3nx2UFy3CxUlNZ+Kg1FyfKmCi7A5pcMMeMAURiukcd+x1rH3wPMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXQ0SUsvU1JkSFVkUkozeHpBdzdqa0xxcTNvWFNvc0craExiaGE2ODl2VGp1?=
 =?utf-8?B?OUt5K3dWbHI5aGp1cUJkOEgyY2lkR2pBUGw2VTJJZWhFdUtIRTZ6SjR0UmIr?=
 =?utf-8?B?SFJRemhjQ0dtZ2YxbCs4SHFhZ2pDMjNKelFucUlhOEQ0VmdNMzNEYUwzZXhw?=
 =?utf-8?B?WUNIR0dSRldxbDY0S3ZBRUtmRjBaSndtRVlPc0F5Z0tML0NaTUdzVTBrM00w?=
 =?utf-8?B?d1NYc2lGaGhhU2VzVHUxYU1LWUQzeElnVFVaUlhzVFhHenVkeFd6VUxvVjQy?=
 =?utf-8?B?d1QwYVJqOTA1N24xbFUwRG5BVFBCcStwYlpvVVhCbkJjR0FCV0tzTmY1akR5?=
 =?utf-8?B?YnhLdzI4MnplcUNhM0UzWVk4Y1ZFOHU1eFhyNTZLWU5IN2Q2ZUtXYUxPaVFu?=
 =?utf-8?B?anBZek81MmwxeEFvMzVmUXZyVlRoeGE5c0cxVzFnVVgxcGdsUXd2eEtaVmZ0?=
 =?utf-8?B?V0FoWkIva0VUSzhaRmN0dll0T3ZuSUZXOS9iMTBFa1p6RVRvV3lORXJxLzFQ?=
 =?utf-8?B?OU1UcEVybWlTVStSSUpZdDBDTDZzTnUzeDhqNkFwWC9DaTlvakhlaGVMZG9M?=
 =?utf-8?B?NXFJeUVtc1ZZMnFpeHJ0Tm8relFBOTFSQ1BkRjhmd01zb1V2NE85R2ZMaTkr?=
 =?utf-8?B?TDgvYXFNeHFSRUVzaHJyT2RhMDlab0ZRdFdZN2xrRFhiZG9NZFJVUlNYOXF5?=
 =?utf-8?B?eHo4cTRaQStEUmFzcnlQZ1U4NHNSSlZCZ0FuZk42MkNVR1pDTEE1WFZVeXhp?=
 =?utf-8?B?M1pIMHdBNWZuZU12a0hFNlJRaVUxOEdOZG9SUk04NHB2czc4bkRDY3VHTFV0?=
 =?utf-8?B?OGM1OENZNnpjR1RCWm5ZY0VQay9VTFRZVmtjalYvZ2I3L1I1TjQ1dU01RC9U?=
 =?utf-8?B?aDlLSW1mMXBkZnJBWEd6aUtkeVUrajZQTUNNQUZFZjdYTDl0dlhBOTUxR2U1?=
 =?utf-8?B?d0V4UDAwcVRaaUhLOXdlUjVFRlNQYlNsa29rSlBTb2NBbTZ4ZXFZcU4xTUpL?=
 =?utf-8?B?bVpKK05VdXJQLy83QmZmQ1VETzI0ZTVLRXVzMWJlTElqUGZhSmJ0L1VQaDlq?=
 =?utf-8?B?UnNJK3pORXJKRWw0Tkl4c2JYdjFjSTB3Z2h2c1p1SnpDZGZXSVd5bnhUNy9M?=
 =?utf-8?B?a05BNTM1ck5qWnM2cTJBekMrL1JOaFlHL1BreUJWVVpmTytWTnVGUWpYYS9R?=
 =?utf-8?B?bEhzN3FycUR4Tk5nYW9GWEg1VDVLdDRoZ3NUQnVXT0QyOFZsbXoyR3ZsNkUy?=
 =?utf-8?B?NFpteUV5d3pjaW0zYU5xTWgyVWpjOHJZUkZ3Ym8rczZva0xLZzFrRkZWc1RQ?=
 =?utf-8?B?aEI4a2cxeDVpS092eW0xZ1FKMk5ZNG1pby9lOFQyU24yWTcyUTIxV3BGZVpS?=
 =?utf-8?B?eWVSVCtUekM3NzVMNk0wbG0xUWUxSk9JcnBUTFlXK3pQcWYrMU50dFAwRW5R?=
 =?utf-8?B?cFVPdHBWWlFva0IzRGw2eXQrYnVabUJsL0JsKzQ5eTZ0SjF5NitxQ1hwNytG?=
 =?utf-8?B?YmNEd2YrdCtaOHJ5OEFqdjZ6bUxMNEw3SE1hekRiUXlrbEVqd2hYOU9KdVcy?=
 =?utf-8?B?K0FvaGJKVlV0Mm5ZL2xmN2M2MUdWYVpIc1M4Z3Z0b213UGpOckVCRTdjTnVq?=
 =?utf-8?B?R3VhQlJ1bUlhLzZmWjZYSW81TTZ6c3BsRHByZytWNzU2N1J4SnhRa3YzV2Fy?=
 =?utf-8?B?bVNzdVhmMUhrQ1pyT2R2VFBzT0Z2MTlGVTQ4c3JzQVRBRFk2TDA1ckp0OW1a?=
 =?utf-8?B?WmtzOEt5WUJOVXdHZlMvdnR2ZjBUUDB3MFdadmxIWWI5ckYySEl6TVlzT2dS?=
 =?utf-8?B?bDdzRG9FVmRzbk1QSkxSK05qZitsSjB1NG5NWFdnbThXUGE4MHlsemVKQUE2?=
 =?utf-8?B?NzlNMFNqVVFmc1RFYVRPV09wNUh2RWhWb3lMZ2xWbE9ML2t3VWl1V0F1KzJT?=
 =?utf-8?B?VWlPa3YwSE5lQmZkWWR1ZEFZZkptU2tLZXBwUFZwOXUyeVJSOTcyU0Z2Rnha?=
 =?utf-8?B?RHBkenkyNXZmRGp1QTRUUkJaSno4NStuL1JFcUQvd2h0Skg3ODhqaDNKbmE0?=
 =?utf-8?B?QWtNSmRVY1loMVlrRG16NklTb2xVOWh4am4xd01ZVXBTTmlrT3lvdTloT2N3?=
 =?utf-8?Q?Cmq3yTQZWwYGV/V7xkc3qUvma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2811c-73fe-4dbd-d1f9-08dc3783e42b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 11:04:39.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NrLPZWqEjpAMte7ArIppcds6Mq0pBmlmbMKa+rbP6r8UR6ObBpFJqXJqDsItGVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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



On 2/27/24 09:57, Lukas Funke wrote:
> On 27.02.2024 09:45, Michal Simek wrote:
>>
>>
>> On 2/27/24 09:40, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>> Some zynqmp SoCs (the cg series) only have two cpus. Thus, for some
>>> cases the cpu-affinity has to adapted, because cpu3 and cpu4 are
>>
>> interrupt-affinity right?
> 
> Duh. Can you update the message accordingly or should I send a new version?

new version please.

> 
>>
>>
>>> missing. By adding a label to the pmu fwnode the cpu affinity can
>>> be adapted in a device specific dt.
>>
>> Why do you need to do it? What problem do you have if you don't change it?
>> It shouldn't be different compare to max_cpus=2 right?
> 
> We remove the cpu nodes for our cg devices in order to have a dt that really 
> reflects the hardware. This way one does not have to pass additional parameters 
> to the kernel. Unfortunately if the cpu nodes are missing dtc complaits about 
> them due to the interrupt-affinity property.
> 
> Since you seem surprised by this: is this the correct way?

At the end of a day it is up to you which way you choose.
Removing unused cpus and aligning pmu is likely the best static way to go.
max_cpus=2 is another way.

And definitely I would also check that even on CG device you can have unchanged 
DT and firmware will just reject psci up request for cpu2/cpu3. It means OS send 
request for cpu2/3 up and firmware will reject that request.

Back to your system. I expect you are making product out of it that's why likely 
make no sense to keep pmu even in DT. And for removing that node you don't need 
to have pmu there at all.

/ {
	/delete-node/ pmu;
};


What about this description?

ZynqMP CG series only have two cpus. When cpu3/4 are removed from DT there are 
missing references to these nodes in pmu interrupt-affinity DT property. To make 
alignment easier provide the label to pmu node for adaption in a device specific DT.
On production systems the whole pmu node should be likely removed or at least 
disabled via status property that's why label can be also useful in this case.

Thanks,
Michal
