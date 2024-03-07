Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFAC48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 08:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E735F87E21;
	Thu,  7 Mar 2024 09:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMuoQ6CS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ADA087E21; Thu,  7 Mar 2024 09:27:03 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF06877FB
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 09:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQH86fTKgKNYR5cLYqW/WeJfWWalFKRG9dNWwuPgH0TNJaYYubfU2zv3larEn4cibXsQ1jZosU/Vp+S3b7NNjQguF+HhnrWsXhH8k6qbvjWWImTJ6srMx4uAUNNzZ6AZr1mlMCQpsWCKthYX37gGyOswlJaxPE7HMfZvgsF8wo7AcB8a/Xd4Qmk2fJ02w/H/VD6lzI8PJ1n4MishCHcP+zCq/HVcmBpjaSIEy3C7we94xAA2o+PIuN0cdBI3O+/IqJ20qz9a4owp7vSO5hEwKh0jMvCMzSEuMcsnlvDpK5ZJWBjkchZfhaov7agvVsVUkI9qHAcJZg+RuAxrTDVbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZDbSb9Y+mbwrTwSwnIT9OK1AHvJZvMC1Jfc5r6v+5w=;
 b=faXitub4QVDxB/xVkcY42G5I9EPP9bJmvmLBnfrg5cqCkJbtm0ZQ7DubToQ48faZHaonM8yh5UmzVvLZ9c06zkfUWoP9BjtoLS7ue74tMk9d8PjhlWYwcAUyotw1awWEtt7J5mVwvmZN1JkVq/bIdIbIC1FkwyDFvAGsjIuuPgtyXJupSaYW+4sXrD0RDEf2WPL8yl5vMb8ZdDmFsY3PEntrqwqGhtvNOv8eIRa0D+1u0q3NnYIDntAcYekZQ2ou3IwBUiITQo+XvaiPJVVFvrvuH4D/q3PnfR196evT/VpemAIKsOlR4mX9WODmQuFw8meGTfm6J9QaYxXsLCRXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZDbSb9Y+mbwrTwSwnIT9OK1AHvJZvMC1Jfc5r6v+5w=;
 b=IMuoQ6CSHel47tdJkR+53pemPzbu0OWSaPIEWvYfvcX6Ajd5YICP3VevSeV5z3uAEG5C0g/b1ms7HESpRq6u3uUN3NTF32Y1B9aahZ11o7AxcCCGblvQ6COgWzwKJMgkWWTnQy3+RBcjtqXVTlAQM8U636lu6QCQTOYt7V/6XQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 08:26:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:26:53 +0000
Message-ID: <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
Date: Thu, 7 Mar 2024 09:26:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Content-Language: en-US
To: Angelo Dureghello <angelo@kernel-space.org>, Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de, git@xilinx.com,
 Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0235.eurprd07.prod.outlook.com
 (2603:10a6:802:58::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: deada2dd-01d3-4992-9897-08dc3e805830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCyO86PBJ46Bpwo6ZitPeXHo4sD11Az026/rpzluolpHbyl0hA7QzpJSaAQZDDRPf5Tbz9ltE5Ak8cAxtBJ1/xFE1vABTn62LRCdo33DYp5I5QoIMMhankBBc2aXOdrbB6a/EwhmoNuYBtMTNX1QN1nkz8SzHvt8BrzLzWkmVmGQBPCGPeYGHuLcfvuXeIKWiuhMnHdn/KApFFI8NJRCKegvGfVPa9/saPzaC2dO6Br6KQYz/JkUKtDphi54rmeJdAKJuMwpdLwG4U17RnOgfYybxgiOSgMQcSSqDjnv2kNsEWZF1sEqDxtJUqoOq+MHIfM9EhCYRO4V9p/vxy+mndwf9+Prya3+lZxjWXHPCLvs+FrVO+LJUXOpOXufc+fQe8IMnzsjSdJGGDA00yoDpVFElxseHD0ddVUbSAlYs+JpmrTtIkjlj5it16/7qjjzQGwbkWgPfQpeTpj77uOC9UUnX+Dqis334KRgg44gHekOM06D8QTx0W1kARvDR4PRJQB7ppZVZYMM/ET1aeww87Qy/Uh4Aen5H3v1hG03GBqcvLiYuR2xQqhfmA2BBpbsN33Ok/7xBu52JN9MnKWXgnix+T5ddu48NX7pz8mAenc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNFcFQvZXRKdGpLeGkxSlEwNjlrU1hzN3NqNi9nWTE5RUtXdTVLOWJJZzVO?=
 =?utf-8?B?WlgvSnBMbXVmYWg0SGNBMTBtazU1SEFGSzdjUG9ORTgxMnRDcHBzbjlKSXlL?=
 =?utf-8?B?K1NrTVZvaXlZSmlJSmJQS0FUVzk0OUduWGZHS0xQYjhyOUtVbnJCU0crWkxP?=
 =?utf-8?B?aXJsM2R2UklTNFE2Vk12eVFMbHU4SWhxcnJQQXI0NzF6RHhNTkluMFFseU8z?=
 =?utf-8?B?TVVIc1R4M2N1WFNaVlhzbHJTcVM1YnlwQ0dvUHZrTm1DRjJjNzBBaTZOR2xI?=
 =?utf-8?B?ZUl0M1ZhbHNENjM4QnpkOHNIck00M3EybzAxck5nQ0dseFNZS2QzVUxtc1lp?=
 =?utf-8?B?ZnZZQXh1eWxscWIrdTJrSFV1ZStuTk5nOTNvM3Y1OUg0eThZYS9KNlg5em14?=
 =?utf-8?B?UGl4dS9FUzJLUVk5K0VmRHovYUJoa1F3Ri9nME5WaUdyUTdTU3FweGU2SjVJ?=
 =?utf-8?B?akZSYVRwSlZoQzl6SHNWQVp3c0h1ajNLOXI5L09vMSs0YnJkSGJmWFQvRk5U?=
 =?utf-8?B?VnYxS0EyYzUwVGdqRCtFSHRBMkpJeUdMYlgxa0ErWm5sdnRvUUJpczJQZWNu?=
 =?utf-8?B?UVdFYmdmWE9yckh1b2dqeHBGRFdUaFVLeE1LQkhFVU95OXNUUUk0T1FKTkRQ?=
 =?utf-8?B?clZjZHJwUThFNThKZXVoLzU0WThCbTdDL2w5Y3Jlejd2aC9CcndUaHA2TGd3?=
 =?utf-8?B?ZjJDNDVUL0tpTzJrNGl5UVFjVkphNmc2Ui9YSWJJUzZBcU1Udm9jU3QwOUpi?=
 =?utf-8?B?ZXoxRU5ETXoxdXBzcnkrdDh2TVpvYnJZUFpqSndFQU1kRlNkeXZoeVhoaWo1?=
 =?utf-8?B?QmgyK1FTcVUzVmxpcytzeXIwVStMa01uNnlETG1uc01oV21DSjExWWNQWWlG?=
 =?utf-8?B?UzNmdlBIMmg3dHZuSkU4dG84SUQvc2l1SmhQWVN4bGR5ck5xYXdGQTBoNzNx?=
 =?utf-8?B?b3JsQkRvNjBjdlc0aWhSMHgrT0dibGtROXEyQVdBWmVXLzRlNEpPVzZBcWJB?=
 =?utf-8?B?eUVhbkY5WkcvbktQcldSRkZzbGlkdUY3bW83WG4zaVN3c3hIWS9HRHNBemp2?=
 =?utf-8?B?OHJkTHNMaitRdjNycDR6SU90ZnRyZ3NFRXg5UTNlemFLK2tUUUFBTmswNGpS?=
 =?utf-8?B?azhUV2pQUjdIbU1WRk9oczY4cC9qTFZ6blVqMjFWNnRtTkhncVRpd1dEcUoz?=
 =?utf-8?B?Y0xVT1hkTlZXL1l5RldOVU9wUGVFMC83WDY5VFBTaVN5elhSQkYxdlIrbUFF?=
 =?utf-8?B?OENZeC9PYldtNllvRHlVN0RtVnNkamRmK0I1RDY3cmdFT3RMY2FQSUd2OHMv?=
 =?utf-8?B?RVRxSTZpU0FobzRoNjhqMzdMY3l2TklTS1BBclJHVjI1dE8wVDdEZG8zTGFp?=
 =?utf-8?B?UHBySGxNWEhrTUtiY1VaSkh1ZEt5bFBZZGdpRGFJNVpjdmJodHZpTEZiaXZu?=
 =?utf-8?B?U2VjS1c4WkNRR1ZpQ0lBZ0ordzNTaHd1UlRWMXNteDFSS3F6dkNhb2gydVdM?=
 =?utf-8?B?UWVmVU12SDJSL2ZNbGdXSXlReDNxQ05iZEErSUdRWjEzRVF0NVlOWE5GaC90?=
 =?utf-8?B?SU1paWVtRmI5U25uZ1AzSTIwVTZRMHFndUExWHJHdXhpSXFuVm9sbFVjRDd3?=
 =?utf-8?B?aFV2NmxBUUFPY3FKSWUzZXRlVTBQeXhyRTBIbHB5dFo1bnUyOVo0aHptNUN5?=
 =?utf-8?B?V1h1S3RuRDVVU3lLN1lreERCWFVVVkVIaEhlbkEvL1NwWXIwV3gvbzVOQks0?=
 =?utf-8?B?L3plSjJZQUhCbHJsSnE2emo3S3ZZeXF4R3ZubHhicUU1SitDWVJYQWFxMXRu?=
 =?utf-8?B?WEhCSEJ0YlIxUGp5WkZoY3Zwb01JRFBPS0Z0b2hta0JrSFVxbDZGeWxrY1VX?=
 =?utf-8?B?bWtXZmlvQnllNWJMMTNYaGI1TnU5M3VDVklGZm1nUk50N0xGRmRyYi9oQjI0?=
 =?utf-8?B?dVFhK3ZGODRNeDJnbFEzNkdsQ2tJMUIva3owcFdRZjdxTlI0aTBwMmRwTSth?=
 =?utf-8?B?eXM3ZVRrZ2lSbnc2NjlidmVkaEdpMHl0clY2WGhNQ25RY25tNjNlQ0VJUTZy?=
 =?utf-8?B?QnAyYitPN3pnRklBQzlhcmQ0dnlTY1JwdFpMejlrZWNQT2N3QkJVYy9hSTU5?=
 =?utf-8?Q?s+UrOPrC2Dcv0Jmcz5e/nl39L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deada2dd-01d3-4992-9897-08dc3e805830
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 08:26:53.8600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXMJ1LL9m12LyBqnIyTalBIY8EialQAi/A+R62biAZzphByJTVWsnZL0Em9DOCzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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



On 3/7/24 08:56, Angelo Dureghello wrote:
> Hi Tom,
> 
> On 07/03/24 1:10 AM, Tom Rini wrote:
>> On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
>>> Hi,
>>>
>>> On 05/03/24 1:34 PM, Michal Simek wrote:
>>>>
>>>>
>>>> On 3/3/24 22:58, Angelo Dureghello wrote:
>>>>> Hi Tom,
>>>>>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>>>>>> Add a test for reset commands which performs resetting of
>>>>>>> CPU, It does COLD reset by default and WARM reset with -w
>>>>>>> option. Signed-off-by: Love Kumar <love.kumar@amd.com>
>>>>>>> Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
>>>>>>> v2: - Set bootmode through boardenv if modeboot is not
>>>>>>> defined Changes in v3: - Fix the issue with bad pattern
>>>>>>> found on console --- test/py/tests/test_reset.py | 61
>>>>>>> +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
>>>>>>> insertions(+) create mode 100644 test/py/tests/test_reset.py
>>>>>> I had hoped this was all sorted out now, but both this and the
>>>>>> saveenv test cause qemu_m68k to fail now. See:
>>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/791635
>>>>> looking into this.
>>>>
>>>> Is reset implemented in qemu? It should be skipped if it is not.
>>>>
>>> yes, seems not implemented
>>>
>>> => reset
>>> => reset -w
>>> =>
>>> =>
>>>
>>> Not finding any trace in the qemu code related to
>>>
>>> out_8(&rcm->rcr, RCM_RCR_SOFTRST);
>>
>> Does reset work on the real HW, or can you not test? What I'm wondering
>> is if we have a missing feature on the board/arch code (and should
>> disable the reset command) or a problem with QEMU.
>>
> I don't have the exact hardware (m5208evb) but:
> 
> 1) i checked by tracing that on qemu the reset function is properly called
> 
> => reset
> resetting, RCR fc0a0000
> 
> 2) reset register address is correct. I checked also that writing directly to it 
> by mw.b does now produce the reset,
> 
> => reset
> resetting, RCR fc0a0000
> 
> => mw.b 0xfc0a0000 80
> =>
> 
> So looks not implemented in qemu.

ok. That means that we shouldn't run reset test inside CI loop for this platform.

Thanks,
Michal
