Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D05C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3083D87980;
	Thu,  4 Jan 2024 16:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZHj8UB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44CA87933; Thu,  4 Jan 2024 16:50:47 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4928799D;
 Thu,  4 Jan 2024 16:50:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNK8MzyywE5Yz/0Ex/ej2hXSWvd05ZZpE1u1Nn7YKVXSEhQjC9IyjgpoJjheecVMFdCtlObsWVPfOp9sjUr0NwYSPLfhJu9N5yxNQMyR3t7uzzSJmnZx6bmpq00baYeoDrABkUkgkx66WSo6qEoDpAuYZkHvIFwuW7qIOje5d9hfDcswfgLxDdbwvWBTbMDMq3lDDR1WajNOZORDRXlKkOP9N3Vcr7hu816AQr/vA/+NxlIL1eCtsZmqnhH43g4y12U4vJrJeotil6RtqlCOJPLIJ5xm+8BRdo7MgQbFOxNXaObBm+2pBHMKWsVmNvmrVBhv7XI4yiyIhspaDcVbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YuvaD8xZM7blChqU5SUcCmRlqaNRGYuSiUOrvuEi0U=;
 b=FY527AiREQxj8qY5RGQi2bpAtbwDyMB+ARYOmdVcW7ZI3+SIVK5hXGc5Ecj1slM+UR8xcHOFUYGqJYRqSilIrvtUoTWaBb37+JO7HziYrICu5f4gAytQqlL3Ku0uiSYomM4K24SWssZfqfKGsX4h6KMSgwqo/KdhD2EVsWAc7RH360znBHNVbcWK9luU4QKUK2bjH7AJMsf6xznXMdNRGavVMLakIy5QGNlkOCKFJ93Yuy9mHURmYpU1YzzxDVrX0vNo4pCg0lznE2GlsQOuoo0fSkfGxZ/pCnoecpVM2F4lW5Pkxqvv7/n5qnZpgHb1ecAsq/SCKJ1BY3gGuE1ZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YuvaD8xZM7blChqU5SUcCmRlqaNRGYuSiUOrvuEi0U=;
 b=tZHj8UB81u73y8+cyoqg+YFHK4DNzIXv6JZXdUeavIzhf3atcQLiLT3JaQeyDbFx9UC4T6zBebDEEmjx+kjtnBlDbst4saPh27mSLSaDX63DyxXAvYWTKFAZbIGyCZlRXKrwlcnv7ekMeGpqgEOreZrI2H03QUFoLy9cO1COlf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.27; Thu, 4 Jan
 2024 15:50:38 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 15:50:38 +0000
Message-ID: <785175cd-a2b8-4d5c-8f2c-326125465ed6@amd.com>
Date: Thu, 4 Jan 2024 16:50:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
 <20240103163201.GL1610741@bill-the-cat>
 <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
 <CAFA6WYP6p=eVtmnS=Qd8xv+nCSFvzREMnRHFkLzEzENnvTxv+A@mail.gmail.com>
 <20240104135008.GQ1610741@bill-the-cat>
 <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
 <20240104153029.GT1610741@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104153029.GT1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::36) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: e2919b6f-5e98-4698-8c03-08dc0d3ce5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9ZElzcTpHuz1Npb1KFcRyVw1P5Pcr+JVdASZ7IL4Rx7EBAcfjAjoGeO74GOxErBmThr9/vWIlsmCM/NBSGt9GQsTxZeXFUhX/hfmybeuiujsYzuVc86GFz2QB9sJbC+gHPzkies1zkgI2P0irl6EczU0rqxhr3q2/kELzLlBNN8SNV/4i3SYFDmgPheMJ7nUqMSRbsDPXDlLKhMSfJgCnuS9vPCmDGbVllNV7Ur7lGHWkU/2n/cKRnJAfqsnm1zE8EzCLBQKadPxt1oMaXGqRmnco2BBeMQw9KQb2EuLUe5+6xi8ERh6zrRZSdAwS9fyk9P1tC6026HUWUdvJDu2iJdNVU11dcjgfUYKT8XnLW68JqJMHDt672W8/KsDOCi9ESNga6xIaDRBMtGmhzdqK38mrvq5i5DkRaAw3AVMlE8u7XgVWzOUc6TQ+N/VE+YJfkg8zqazcGqcnrW4lJxNVHOAhlKPqD3ib7eCn4BfK0qBLeMmeunAyPMynItdZO6ooFsSAfI4JwsNJ0jX0EAQzygf4+/F4Vua0F+nvdAfQilBhOPtqiroFWAnl8hcQD7/Ja9SKMDxi99jnNwXbq8wd2qcf4WTGdtK7zVGBUW2xbdHwFmGtBIURdkJ6jyT/C9WI1qOXtHS2HyRed4X92VgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66476007)(6916009)(66556008)(66946007)(8676002)(8936002)(54906003)(66899024)(316002)(6506007)(6512007)(53546011)(6486002)(478600001)(5660300002)(966005)(2906002)(15650500001)(7416002)(6666004)(36756003)(41300700001)(4326008)(44832011)(83380400001)(38100700002)(31696002)(2616005)(86362001)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ltVjNtcmZPYTd0UkppRk42UnRuajhMZXd6NmN0M2hpdFdqR2xkbjZUTXBP?=
 =?utf-8?B?Zkw5K0UvTVRQTkhmaE5FcGlFc3ZoMkJvZk9KYU5WWFBGZ2ZDMjN6a29HdnZr?=
 =?utf-8?B?VDYrZUt1c3ZWYnFLU29KeHIvUjBHVmMvT0VzMTYxMy81cDMrKzFmYkVRRlZN?=
 =?utf-8?B?UTZRekJmeFVpOC8yVkhwdjFxQW5uellCb3RwV0hraU0wL1NYMWlBc1FVQWxk?=
 =?utf-8?B?a2hmYUJ5bE1ZSEQ5S2xQTVptWkYwTENlRlFvRDZCdUwrL0pJbUNDRXoyc3Jn?=
 =?utf-8?B?N0FNTTNuV3ZRMDZsbE1HbEp2SU9oZ1JBaE1UcjdHOXk2cHVma1crOXViZlo4?=
 =?utf-8?B?eER0UzFyN0czV3ZDamtTR0FCRkRpaldkbWwzYzZ2WElPbjZwL1JxMHI0ZVZQ?=
 =?utf-8?B?eE9CQVcrY1VzaVhrU1FhcTk1Yyt6bU54SGRlM2xGS2htd1lqU2JsenlONEpT?=
 =?utf-8?B?aGtlVTNpV2Q3N0lIbXJPSUxqS2tOMWRtaitmWW9ScXBPWkEwaVhvcHZGeDRJ?=
 =?utf-8?B?WDJmMWhQTzJhVXVpZGFrNHZydU5tWkwxZ0c5TDg1TWZlYXBLUzgrbW5OVGVN?=
 =?utf-8?B?MDIxZVRBVE8vNTdkODVjK1FINE5ucW4xV3dLL2tZRGNkOHo0M2xkTHJUUlFh?=
 =?utf-8?B?ZjVjaVNPWXBTeUJONjRoMWFPUDVXNmVEbC9ONVk3Ujl1RWFkeWlrOHRlWkF2?=
 =?utf-8?B?M1ZEeVhxMU9nZlNYa0dJNktWYUNDZC9RSmJPVk5WSHhtQ3NSekVFcm9QQnk1?=
 =?utf-8?B?NnVnNmJZNXZzaHpRM0RoN0Vrd2Z3YmlxM3FVS0cxYm1WZmtkZER4UUt2bHlM?=
 =?utf-8?B?TW1CZGphRk40MEY4b2EyTkhMNVhDTlJ1NkF6N3IwMFNKVUIyMFI1M1BNelhX?=
 =?utf-8?B?eHo1WnNLRkdqbDdFWksrNEFJZnhNcDdZUUxFS0JYMFlVb3BxMXlta0NIT1BO?=
 =?utf-8?B?Qk5KNnFGbXJIbC9JZlh5SlMyamdacnNoSk1wbDRkTXpDWGtMVGUxckxRcEZL?=
 =?utf-8?B?ejNaV0xoRUVzUnlMSkpudktSbHFTZTFocGQ5MDFKaTgxWEZyaE02dUJqZzdi?=
 =?utf-8?B?dXhNVlk4WVhVRWxDWUxrWUpGcFloR2FkN2Y0Y1kyNFhNdThzd0tjK01nYjlw?=
 =?utf-8?B?cmlIbUpGRDJJbWgvL1liUXRQM3lyYjg2V3dYMFJtMjg5MDdaMHh5WW1QdUNl?=
 =?utf-8?B?dHJCd2Jxdi9WcU9HUWFKSjJnaE1rMFRZVFBLd04wWWwwWEZEd0JaMERKeEVr?=
 =?utf-8?B?akdiMGNOa1luckVkY2N0NVJIQzdxdXAxQjZsQkdyZzlUNkViV1pvWVUrK21i?=
 =?utf-8?B?NzI3eTA4eENkWDNaWkRjNlRHRVlEUzkwQUJoZWVXaGN2U0JidzhnK2JLUklU?=
 =?utf-8?B?Z1BtUStDN3g5d2gxcE1ldVFDMVIwLzliYzNCRkF6NHpIdlc2ZkRjRkZxZUxQ?=
 =?utf-8?B?TnI0RXdUS1NjTmJ3cWdUdDV5VFc2di9Qd2lBZlpET2hNZW15VHI0aWFEeHFZ?=
 =?utf-8?B?aDkwVERkeHlPcFdZblFjN09rLzhPcFB6T3BJTGZNaDN1TVRPd042NjRaVkU2?=
 =?utf-8?B?UHpyUFFGVUpWbHpsYkRtcWFWcldpMk84WkptcXEyRkFaYWYzcGh5VE52eUtV?=
 =?utf-8?B?d241MnVXSStRMXUzL2pBYU50NGx6L3YxcWkwbWN3VlUwU2dmVHF6Z3ZDWWJ1?=
 =?utf-8?B?bE4wb2JwSi9YUktoVXo2RDdkNCtMRHlZOW96UVZjK29CM2xwelZKZkxTK3ov?=
 =?utf-8?B?Q1A4Z1U2bUQrZHI3QnJJb0NVcW5xUHZSbjU2UWxZUzg1L2IxcUtQc1Q2eFBG?=
 =?utf-8?B?ZjR1NE13MlQxZTZsV3lPSWhvSWl0Ykt2WmpRTmoxMVZFNjFIZjFIcnVqYTRr?=
 =?utf-8?B?M0JBZzR0TGx2K0taQVc3eVJvT2VNVzNJcmlseFZGWkxGMzBYU2Y2VnkxRkJN?=
 =?utf-8?B?ckVEQ1ZKelNYTnRzbTM1RFpXYSs4dXN6SGd0WU53NG9oU04zdm8zeWNKN0lF?=
 =?utf-8?B?a0N5ZDZ4UWVUVWhTY3FPVmMrYUNXd1ZCbWp6cVBBdEtkc09wZnh3U0plQktw?=
 =?utf-8?B?R1p0SUNvdUFudlFWbEJlN2QvQyt0SHpTbEpJelc2aEZPa1Y5TEVHbUdBUFRQ?=
 =?utf-8?Q?CaR10Kxth5V498pdNLuJ0ueTU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2919b6f-5e98-4698-8c03-08dc0d3ce5a4
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:50:38.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9cxuYTBDtgAzU3yF4UjlfIPFOU/O3HWKcicqym+FO2OKwFLlteki+aHr+2q+mXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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



On 1/4/24 16:30, Tom Rini wrote:
> On Thu, Jan 04, 2024 at 03:45:10PM +0100, Michal Simek wrote:
>> Hi Tom,
>>
>> On 1/4/24 14:50, Tom Rini wrote:
>>> On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
>>>> Hi Michal,
>>>>
>>>> On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 1/3/24 17:32, Tom Rini wrote:
>>>>>> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
>>>>>>> On Thu, Dec 28, 2023 at 4:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>>> [snip]
>>>>>>>> +In order to maintain devicetree files sync, U-Boot maintains a Git subtree for
>>>>>>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
>>>>>>>> +kept updated with every new kernel major release via subtree pull as follows::
>>>>>>>
>>>>>>> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
>>>>>>> had in the original repo). I don't think it's relevant.
>>>>>>>
>>>>>>> We're not likely to regenerate the tree, but any clue what 'git
>>>>>>> subtree pull' would do in this case? It could happen if we switched to
>>>>>>> git-filter-repo.
>>>>>>>
>>>>>>>> +
>>>>>>>> +    git subtree pull --prefix devicetree-rebasing \
>>>>>>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>>>>>> +        <release-tag> --squash
>>>>>>>
>>>>>>> I'd put this in a script to run. Documentation tends to be not quite
>>>>>>> correct. A script could also be smarter and figure out <release-tag>.
>>>>>>
>>>>>> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
>>>>>> something using subtree, I do hope to learn some lessons from what you
>>>>>> do there. The first thing is that given the size/nature of the commits,
>>>>>> I had figured I'd be the one doing this as a subtree pull+squash then
>>>>>> push, rather than posting to the ML since it'll be huge and
>>>>>> un-reviewable, but with a note sent off to the ML that people should be
>>>>>> aware the next sync has been done and retest as needed. But Sumit, were
>>>>>> you planning to do some of this instead?  The second thing is that if we
>>>>>> move the subtree part in to dts/ instead (where we will still have the
>>>>>> Makefile/Kconfig we have today and then our Makefiles within the
>>>>>> directories, this might get more complex and so really require a script
>>>>>> to keep it from getting error prone?
>>>>>
>>>>> I played with this series and didn't really have time to dig into subtree
>>>>> mechanics but one thing I see is that when squash and merge happens you can't do
>>>>> simple rebase anymore which is time to time very useful.
>>>>> I see some different rebase strategies and --rebase-merges option but if this is
>>>>> adopted it should be properly described how to rebase u-boot tree which contains
>>>>> some subtrees.
>>>>
>>>> Did you observe any specific difference with respect to subtree merge
>>>> commits (Tom will likely do those in the beginning of next release
>>>> cycle) when compared with normal merge commits when Tom pulls in code
>>>> from different custodians like one example below? The same rebasing
>>>> rules should apply to both types of merge commits.
>>>>
>>>> commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
>>>> Merge: 2b28c3b871c e266d273114
>>>> Author: Tom Rini <trini@konsulko.com>
>>>> Date:   Mon Jan 1 12:38:15 2024 -0500
>>>>
>>>>       Merge tag 'dm-next-1124' of
>>>> https://source.denx.de/u-boot/custodians/u-boot-dm into next
>>>>
>>>>       support propagating supernode properties with bootph schema
>>>>       align bloblist with v0.9 of Firmware Handoff spec
>>>
>>> There's two cases. The first and uncommon case is that if you want to do
>>> something like:
>>> - Branch next
>>> - Add this subtree, do a few subtree updates on it (like my experiment
>>>     of starting with v6.1-dts and merging up to v6.6-dts)
>>> - Wait a while, have changes happen in next
>>> - Rebase on to current next
>>>
>>> It gets painful and odd, but I don't know that this will ever really
>>> happen.
>>>
>>> The second, common case is:
>>> - Assume "next" already has this subtree + some merge commits in it.
>>> - Make a new local branch.
>>> - Make change in your new local branch.
>>> - This hypothetical "next" branch moves forward with changes
>>> - Rebase your local branch on to this "next" branch
>>>
>>> In this case things work as expected. Even if  "next" in that case gets
>>> a new subtree merge that you need to rebase in.
>>>
>>> A third case that I'm not sure if really will happen or is a case where
>>> the custodian should rework their tree instead (to drop the subtree
>>> merge) is:
>>> - Assume "next" already has this subtree + some merge commits in it.
>>> - Make a new local branch.
>>> - Make a subtree merge+squash in your local branch.
>>> - This hypothetical "next" branch moves forward with changes
>>> - Rebase your local branch on to this "next" branch.
>>>
>>> This will then make you try and resolve some conflicts from that subtree
>>> merge.  But is this a valid use case? Yes, I can see wanting to get a
>>> start on testing a dts merge before it happens, but is this a tree which
>>> needs to be rebased, or just re-created as needed, if the parent branch
>>> moves forward?
>>>
>>> Can you explain a bit more your case Michal since it sounded to me like
>>> you had a problem that happened rather than a worry about what might
>>> happen?
>>
>> I remember couple of bisects which I was doing and it works fine on the tree
>> till the point you have 2 issues to deal with. It means pretty much you have
>> config change/fix which has to be applied to see second issue.
>>
>> The normal way what I have done was simply find major version apply that fix
>> and then take the latest tree and rebase latest on the top of it. There were
>> normally not so many conflicts to resolved (or easy to resolve/ignore). Then
>> because the first fix is present all the time bisect is able to help me to
>> find second issue.
>>
>> If there is subtree update the whole rebase will horribly fail.
>>
>> I see that Rob and you in DTC case just simply do c&p and create regular
>> commit with all changes inside. From my perspective this is more
>> straightforward to deal with which will handle all cases and it is also
>> proven over that years.
> 
> Ah, bisecting.  Maybe the (annoying) answer is to turn that merge commit
> in to a regular commit in the bisect branch?  This is a good point, and
> I need to go and construct a bigger example tree and check around at
> what happens.

Sure you can do whatever you like. But I expect that at the end if this started 
to be used you will have subtree for devicetree, dtc, lwip and maybe something 
else. It means you have to start to keep track where that subtree are and what 
version is used at what time.
Because dt binding is extending often likely you will need to merge it every 
Linux release. It means you would have to do it multiple times depends on how 
many releases you are going over.

I know that Qemu is using gitmodules that's definitely another option but not 
sure if better or worse.

I can also imagine that companies with SR IR certified firmware would keep 
downstream version where they want to just take code fixes, DT fixes and 
devicetree-rebasing tree to make sure that they are still aligned with DT 
schema. Can you simply just cherry pick that merged commit without any side effect?

Back to my point. At the end what we need to is to document it properly how to 
deal with it.

Thanks,
Michal
