Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F893C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 14:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8578792C;
	Thu,  4 Jan 2024 15:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dQHpnNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2818792C; Thu,  4 Jan 2024 15:45:28 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B2F8792C;
 Thu,  4 Jan 2024 15:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPEJE/60/VA4RU/y1I7AkwVHo2BhemvBz6SzMXyvO8iLaG3/p7/BvGJLoSZdqTXI20DSIrZ1K3KylP8Hk5YNqhJtJ7UsP44dfQGxdR6tNrkbqthVEAxftRp/2faRZd/IEN09zSGUw4nuziR2BHhDsA1n1yotk8P9HArkqEt8tZ42A9zRezbQHoRK0XpU84TeanwfAcHuvOMA6KoChQWrHztKaQNjTmCCvrArY+Vgq4fQBay1tvUDG7QhbQSLDMUNG3LjiDuJtdlskttWown/LZQNUdAtbq48/dZlmkFZgPtG8CFBKVRT9Zq6SD2zFnT1q6gzPRTM+EdnNS7cJTnzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz9D6TxDACrod30dyXddaxwmhkKL+D92lIMPRFKNlpA=;
 b=hVI0WiQ8TcYf1La10VhD+I8+is3MpSujWeQBNwfueVirw4m2JqSHrYS0t1kgmrHoAxe9I9OVueW00jLi5qVGLDUBI7dX4z1bisqUHqvGRsyrafNl+RRm2tH2Ooa2SIjjnf4O8qTw/aOKaImS3/OxhMdMAkrG/1BIxVX6XOzZfu1w22vZuy06+ZT0bhwYh82cvDPRbZ7esXCvlnZtVhxXVEe5ryq3ErhZRBFD2UfsPfW7nSnUDsiiDgOCoPzVaEq+yex8Rx2LN9hglYUgaRESD1X31Evsi1OG7t8oMJNHVRIc6uHWMOjOrcKKE7Rj9TwUfnmVHALHDMPx9aRFZJkQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz9D6TxDACrod30dyXddaxwmhkKL+D92lIMPRFKNlpA=;
 b=2dQHpnNGoSwDbEOBZTI4YUu8Ihb8S00gDi1EQBjbvJv8fg87xpIyE3U3kp/mjK+XMaCCIQmEAyPZCQxrSoA2+1jFnn+RnO+F7MOFkpriM2odhtNvrz1dxJiEHRriszeLuIsuWBLslREnp7pEsGp4vmiX/4xmPxQBYikE6K36r3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:45:20 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:45:20 +0000
Message-ID: <cb0ee2fb-2753-421e-9623-3cd74e6bef03@amd.com>
Date: Thu, 4 Jan 2024 15:45:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org,
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104135008.GQ1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1c8820-d5ea-41f9-d13c-08dc0d33c65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+K1rExyZ18GJw4GtoLdv6w/qRuVJsk9KWUosP6Dd5qUTwW+G93WyWqtq6I4ZcFWUJLm4xHbujXK0cFuETgCkt1WXy0LvUGCzMHrUJ/W8eefAf0FgPsMeNw91llC9d2S2UAINmrSykuvKlYIvrBfxOvco434c5+IK7LBUHj0D6RKeKAFD/hMTh0JdQm2/U5LTS7SIOHUR6fNN/WOt3jhnE0L4cRGkWsVhiZim1Zwvka/i7ILfgZYL9jtM0ZNLlu+nuirUsIB7DKUvXfsjVyCkSp3qU0siFVIYFfV0SDCQImRG3KhaBzQkGuzU5CW9iMWhAhiPCKWetvbJyScaAPg+lSIxHqYRPX8pfDFSqUbUrt0UjZM8Fz2lFnlbi2jQKABzfPhQ5jYWfNr4QwxYhjKVojQTkhu+Ol8ecMdoI5/tTezw3YtOCXfCY5XgL8GIedNWRmLX4HlKc54jr868rfJNe3XxTKsAjDDd+CpO9pxiFIKqajuT3Mxg86zjmB/pEKb3Sm3e9koYEGul6fAvFd0HhW9I5iXXcjaHlKvem/03A7bbNgDKt+Cly5qn3Z4CJMT2RlvfhiXwvK5xpyjzt07zKKmpCc/flWpwaMYunL2nO0vAoXvFcUymuGTbR/HLycNCgITNcG2mYgcoMqu8L0Flw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(110136005)(8936002)(8676002)(6512007)(6506007)(86362001)(2616005)(53546011)(31696002)(26005)(6666004)(478600001)(966005)(6486002)(83380400001)(41300700001)(36756003)(38100700002)(66946007)(66476007)(66556008)(44832011)(7416002)(5660300002)(15650500001)(4326008)(66899024)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZ4MHo2MFpmUlBOWkdsaUthWHk5UmdsTWYzNUxlTHp2UExGSk80M0QyN1Mx?=
 =?utf-8?B?aGNYaHVYNUxvU0RaakVmbXFTaFJ0Y2pQTHNWSEJaeG9jQjd2aTFzVjhjemVo?=
 =?utf-8?B?K3RDWVQ5UnpNL1BRbWtWRjdDdkk0OVNOV0dOMEErUTNnU2UwclJwYis4U3RS?=
 =?utf-8?B?NExRT0c0VitpVjlWQzdsMHljaGV4Z1pxMHpLczhvMjdLZGxWcHNIdmhKNENp?=
 =?utf-8?B?QllqaU9FNmFya0ZhK00veStOWjZ2djNObjYranlxK2pqU1B6TXRlcUFNSHRo?=
 =?utf-8?B?Yk13eEpVUnBtYzhRWmlWY2Z6ZzlIbHFUWXJhVUxHcHNBOVpudE9KMjhxdHRh?=
 =?utf-8?B?R25pMmtXcHZOeFdMdW8vWElLZHVHemZ2aGlzRCt2aW5OZTFiaERPVmorZVJU?=
 =?utf-8?B?RWMveTdrVklZdmVPT2t1SmNKcFJYWHB4NVBHSElLTGNsUHBkSzNRUG4rSFRB?=
 =?utf-8?B?cElrK2FqKzBNUjhWWVRISmEzb0p1YXdZRC90UDYzYmtnVWhtbDA0ZTZTdEQ1?=
 =?utf-8?B?YWtlL1NaWUhtcmR5TkR5bUlzeWZFNkhXbEgvZStwblZPQW9GMGh0ZmJiMzBq?=
 =?utf-8?B?bzZoV211Qm9kb2ZlenBxTmI0MzVFclJ4ZVo2anA4WE14ZHZyWUUzV2N4MjRw?=
 =?utf-8?B?VkFRZlZTNTNLL0szZnIvTU9RNEZpYnNPNGdhbXIxYU5aRnBVODJBVi83SGRw?=
 =?utf-8?B?alBOajEwejZxQzZsM3BKV1FVdjIxcmNleTNJdEVOcy84WGhJRXJ3VFVlSDhp?=
 =?utf-8?B?SEVma25yQWJLajJHcDNyTzNvb2ZPZlFYbHEvb28vSlJtL1BpNlVMNXpEVDdt?=
 =?utf-8?B?bTFzUFRsdXhXZmk1NUpLakliSTVSZUNNYjFXVkZwMFBzdjVNTlp0Vmdya0Jh?=
 =?utf-8?B?aGRSaXQ0M0NmcFIrVmszeklRWjdPK3F6RjROMWlXUXltcjhJTGxxVy9UQ0Jp?=
 =?utf-8?B?dGNCNlJHS2xyVzFzV1pKaGVFL0xaSXM0RlVpVUdha3R2NmRIK1FUS21QQ3VZ?=
 =?utf-8?B?RW82ejl3UWNrTGRUL3pDQVdsbzgzZDgzR3g1RmlRRHBxSFRwY3hWNWNHK25o?=
 =?utf-8?B?aENPa0tPcGpnbnQ0ODYvd21Fc3VyR2Jzb2NxWnNaNFBOU2xLdEFtSW9qeWJs?=
 =?utf-8?B?MGQ1RlZUdEU4K2E5N0xldDNaSlhnVUdVQWU1dFVubEpBa0VqTS9XMkZWU3k4?=
 =?utf-8?B?MDFpRGF2TW5aRUtSTDlFUVNieTZNVXFmUmpEUmgyeWp0VXhyQU9IY0JtY2pH?=
 =?utf-8?B?YUYzNWo2NUVtaXBlZGJRMjJKZWpTMGZoQzhVQlY3MVZMYmlZT2NMMU1Mekxj?=
 =?utf-8?B?U1BNOGtWbm1SM0gwMXhRN2t3K0x2ZStLcW85aTBjdGJxRmY3Vm5UbzlaTldh?=
 =?utf-8?B?UGdKbDVQZUpZckJkZ051WlpqelJ3eGFFb2VvOHRoc3FRWWpKNnQvMnR4Y0lm?=
 =?utf-8?B?OXExcERSV25sNlA5bWc5eTJib2doTTgxYkNQVldRYlpORnNxTkYwaTVieXFW?=
 =?utf-8?B?dUxNb21NZFpwMnZLUWNVVWJ6TzR5STNneE9rYVd2aTJ4WkhGTU1uZzNseUlC?=
 =?utf-8?B?VGF2RHNBN2pRRlJKZXZjOHJ3MjRUSUZFMlRDNzVXcS9qVHMrZENqazJaTmt1?=
 =?utf-8?B?a1V0TVF4T0NaWGwzSUE2MTZKeVMwcm0vckdEclVtS2o0WjNUc05yWFhCRjBm?=
 =?utf-8?B?SG9ndHFJQldJYU9ibUcweGFOSEZWQkJIdUZlK0JaMmdocWdWbmdBUVlrWGxp?=
 =?utf-8?B?cGpzcGd3SmI1Sk1wbjZvNWRwdHpudU5rUkdEL1hDcHNuL09TOFB5ek5DMlNS?=
 =?utf-8?B?M1pwaXpTQ2JwZWt1cFJ0RGFacVBVMUMrUmcwOTA5TjRaTG1jVlFuNnF3SXY4?=
 =?utf-8?B?L09RNUJrSmt3Wi9CSlVkTmZrWXVtUmI0aWp1NHZXaVJ3NC9VanhwT3ZCQzMz?=
 =?utf-8?B?T1orMU9NVTBTWGhmQzQwRm51K2NVbmdSUzkvUGJMQzlkamhHMW5RWDBmMTEy?=
 =?utf-8?B?WFkzNUx3dENTR1VxMG5rYjlDbXg3WkpIOHo3eGNYTnlEOUlIQUxaaGJyUTds?=
 =?utf-8?B?MHh0aUx1M2VmMWxicWNRUTVBMGdSNjVwZHdtbFYxUyt5VVFjZDFKMXVna29x?=
 =?utf-8?Q?gaMwEZz5N65NRBv0nywbMKxC4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1c8820-d5ea-41f9-d13c-08dc0d33c65b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:45:20.5410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcFsjNkE8opqYtVN824Q2Ffd7+781teIK7lsG8tb/6ehU1afNZ7KrTBliR5/unXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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

Hi Tom,

On 1/4/24 14:50, Tom Rini wrote:
> On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
>> Hi Michal,
>>
>> On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>>
>>>
>>> On 1/3/24 17:32, Tom Rini wrote:
>>>> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
>>>>> On Thu, Dec 28, 2023 at 4:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>> [snip]
>>>>>> +In order to maintain devicetree files sync, U-Boot maintains a Git subtree for
>>>>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
>>>>>> +kept updated with every new kernel major release via subtree pull as follows::
>>>>>
>>>>> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
>>>>> had in the original repo). I don't think it's relevant.
>>>>>
>>>>> We're not likely to regenerate the tree, but any clue what 'git
>>>>> subtree pull' would do in this case? It could happen if we switched to
>>>>> git-filter-repo.
>>>>>
>>>>>> +
>>>>>> +    git subtree pull --prefix devicetree-rebasing \
>>>>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>>>> +        <release-tag> --squash
>>>>>
>>>>> I'd put this in a script to run. Documentation tends to be not quite
>>>>> correct. A script could also be smarter and figure out <release-tag>.
>>>>
>>>> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
>>>> something using subtree, I do hope to learn some lessons from what you
>>>> do there. The first thing is that given the size/nature of the commits,
>>>> I had figured I'd be the one doing this as a subtree pull+squash then
>>>> push, rather than posting to the ML since it'll be huge and
>>>> un-reviewable, but with a note sent off to the ML that people should be
>>>> aware the next sync has been done and retest as needed. But Sumit, were
>>>> you planning to do some of this instead?  The second thing is that if we
>>>> move the subtree part in to dts/ instead (where we will still have the
>>>> Makefile/Kconfig we have today and then our Makefiles within the
>>>> directories, this might get more complex and so really require a script
>>>> to keep it from getting error prone?
>>>
>>> I played with this series and didn't really have time to dig into subtree
>>> mechanics but one thing I see is that when squash and merge happens you can't do
>>> simple rebase anymore which is time to time very useful.
>>> I see some different rebase strategies and --rebase-merges option but if this is
>>> adopted it should be properly described how to rebase u-boot tree which contains
>>> some subtrees.
>>
>> Did you observe any specific difference with respect to subtree merge
>> commits (Tom will likely do those in the beginning of next release
>> cycle) when compared with normal merge commits when Tom pulls in code
>> from different custodians like one example below? The same rebasing
>> rules should apply to both types of merge commits.
>>
>> commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
>> Merge: 2b28c3b871c e266d273114
>> Author: Tom Rini <trini@konsulko.com>
>> Date:   Mon Jan 1 12:38:15 2024 -0500
>>
>>      Merge tag 'dm-next-1124' of
>> https://source.denx.de/u-boot/custodians/u-boot-dm into next
>>
>>      support propagating supernode properties with bootph schema
>>      align bloblist with v0.9 of Firmware Handoff spec
> 
> There's two cases. The first and uncommon case is that if you want to do
> something like:
> - Branch next
> - Add this subtree, do a few subtree updates on it (like my experiment
>    of starting with v6.1-dts and merging up to v6.6-dts)
> - Wait a while, have changes happen in next
> - Rebase on to current next
> 
> It gets painful and odd, but I don't know that this will ever really
> happen.
> 
> The second, common case is:
> - Assume "next" already has this subtree + some merge commits in it.
> - Make a new local branch.
> - Make change in your new local branch.
> - This hypothetical "next" branch moves forward with changes
> - Rebase your local branch on to this "next" branch
> 
> In this case things work as expected. Even if  "next" in that case gets
> a new subtree merge that you need to rebase in.
> 
> A third case that I'm not sure if really will happen or is a case where
> the custodian should rework their tree instead (to drop the subtree
> merge) is:
> - Assume "next" already has this subtree + some merge commits in it.
> - Make a new local branch.
> - Make a subtree merge+squash in your local branch.
> - This hypothetical "next" branch moves forward with changes
> - Rebase your local branch on to this "next" branch.
> 
> This will then make you try and resolve some conflicts from that subtree
> merge.  But is this a valid use case? Yes, I can see wanting to get a
> start on testing a dts merge before it happens, but is this a tree which
> needs to be rebased, or just re-created as needed, if the parent branch
> moves forward?
> 
> Can you explain a bit more your case Michal since it sounded to me like
> you had a problem that happened rather than a worry about what might
> happen?

I remember couple of bisects which I was doing and it works fine on the tree 
till the point you have 2 issues to deal with. It means pretty much you have 
config change/fix which has to be applied to see second issue.

The normal way what I have done was simply find major version apply that fix and 
then take the latest tree and rebase latest on the top of it. There were 
normally not so many conflicts to resolved (or easy to resolve/ignore). Then 
because the first fix is present all the time bisect is able to help me to find 
second issue.

If there is subtree update the whole rebase will horribly fail.

I see that Rob and you in DTC case just simply do c&p and create regular commit 
with all changes inside. From my perspective this is more straightforward to 
deal with which will handle all cases and it is also proven over that years.

Thanks,
Michal
