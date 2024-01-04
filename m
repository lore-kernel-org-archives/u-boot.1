Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E509C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 10:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B57877C8;
	Thu,  4 Jan 2024 11:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ofLIUHpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0585187933; Thu,  4 Jan 2024 11:09:19 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E065877C8;
 Thu,  4 Jan 2024 11:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G71xzHQk0XPM/PpuEssvE63hRsiv9rsx0QOwYegyx/PhN7CWsCsQSLGDkT+LiC3ENQF+a2fRQ7I4rIA8p1H8hfIeLu+kN3Ksu+zlnWQJSnowIG6PyIYMg/gLlbS3mbz1J9PRdC0DU+uosct3FM1uqwOaROXI2c/vSOKZvxYii7zkEWgv5phtsnluK1tlXKSKCdIkV59YW8Ta++Yj3V57MtsZ2RTqngLtJYuDhaZt34/VqvkKy/lUO9vlrxh5npDrwdhinoAf4GuqJOoXgwQ6uoWjgfjWYCzhJKU/e8oHwNyCDX+tU4CEIyod2BxF+oAnmopgyVvCVSnUeFU/Qm2Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPWyvuCA8nFIBL8p3HVkp10ph4V5W912JGL0VoGkpQw=;
 b=OHwOFOh583BUFHRqfludTEKiDUeqEk+rQKgyoEgrAq2CU8jAdbYsxMSa91KQej6n7yIQMvCagra2yeyKX0S2axR8beoUpIQxRb55bLPI5aO4tTUy9gJai5406U2MjxMYkw0FMiP/WTzmMba5Ymn7S4Q4OKQ15NiA9lkczRSZmfz2locs+h8oTD5+YcoN/jJiLeY1dctc34/827VqOsOFKyp78rH2JZEXjw8wbgUca7xsXm/Xd8mWGRhz6N2406CB9dObUXFTZc5/qsfHWrd4g6lLqU9N0g03+Cwsr8F5HcUcyUiAEqBlQoj/OAP/I6N45lASMV/jsE3I4AORVPWdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPWyvuCA8nFIBL8p3HVkp10ph4V5W912JGL0VoGkpQw=;
 b=ofLIUHpCVqkuSap0+lfc5zuyNM26e71w1iG+g360X+NkQocQ9887F2DRNonEvzQZPkHsw4MfL3g6+iPTrJGJp9bK5gv+RW8RusT2Lj1cxW8dLFnpg67+3s+Lb8D000SuLEeQ4wSlqTU9KFT6o6SJpElXJbfgxt48CvKledWBkwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 10:09:13 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:09:13 +0000
Message-ID: <51aacb5a-0c43-4bca-8036-028ae9fe6267@amd.com>
Date: Thu, 4 Jan 2024 11:08:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240103163201.GL1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:802:1::48) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1931ad-e663-4334-c6ae-08dc0d0d338a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hoLCv9kNwTig+3f7AjoJuwEKbeLoyzT4kHRqlL1UtZdvKRu5gTgzVgMaJnK1MbE2P9ur4ARt1LGsRxNgxWYswLw/MrE2ZTMlYc7VEf1tEB0Fvg65yrzDIXRgmq9Jr0JL5Qgfmwe4kDXYbgCV07nmY5Jq4QJ6hugj2ycf4ajFQv/N9zlkL+n/S9dzyRjzvg9Y8lH7R0z0qtXcBuLV1LpLb+NfMFwVQHh+4B+zN3qQN3vTi73WOtKdClEJdqUCem/y0GFFuTeCiHx5WaM/mZaGY/apPiVU4aGN3O2ScHAQGnm40oOD0ndEnO8lnrMPCYn1BiI7vX1JKUI8persPlnnVqEu5kuuLcI82BqnRQM9XC5C8NZ3vfs7nWFEs7UXRxLk8TKjsmdWSQWB4r1gnjOZ7/hcaGlT+GoHJqUUqNDZZ67yUPlAlzgeWY2Z5srRTMFvjABXzB3m4ntGKza+tXJXwRkT0TBn7C4t92zXWLITtvzeeOwtjnI10EeOochcBNn7LRYTjEgExCrXErfwlbOdgWzcam2Rnoc6wDxEegdfHavsb768/oXNEQQ1Fll2hMDS38V9Og7v2B8cMFdItYgKtZG3qwD98notolHA65JOP3l3XBqsr07FbTAF4sxMjae4EjpNIeiRrjRtBrWRuaiww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(66556008)(66946007)(8936002)(66476007)(478600001)(8676002)(110136005)(83380400001)(6486002)(6666004)(53546011)(6506007)(6512007)(2616005)(316002)(26005)(15650500001)(44832011)(2906002)(7416002)(5660300002)(41300700001)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElieDlIWXBSdU5kRFRVMWJTUGcyM3hxTjBBb2FldWFzVmx0bFk1anJOSysx?=
 =?utf-8?B?UXluL05wK1NjR1VMYmE5NllKZWdkL3dDakp5MWRaTDFvQ3BwaUhJbzgvVCtS?=
 =?utf-8?B?S3BkZTdwWmZwektEMkQwUC85R0l4bU5qMm9wMTdqUGtyTnM3VElVbStkUXJ6?=
 =?utf-8?B?MDNsU2hEMFFlMURjbTlOTVdsRUJUK3Z0L1ZXOGI0VDFBb3FBdVlZMWpQQ3lU?=
 =?utf-8?B?VW4zUHlCdWZxZ1ZCVnljSFA0Z05vZStGSk5XUFZ6Y2k5ZnpvaTByZFpMUEVZ?=
 =?utf-8?B?UklkNUFjUFpnWDhzaktLMFVWSHhjVmhpM2JSQ2FJSE1PNU9OekFENWozVExM?=
 =?utf-8?B?bFBvRkljTGRVWU9Rd2dGM0h4MmQvL1pNdzRhRDFvUzZQV1U0N2V0cWc2U0l1?=
 =?utf-8?B?YStJKzFycXZneFk1UDRadGkzcHFkbGJCcENlTW9haEVJN1hTcHBTWFRVUzBW?=
 =?utf-8?B?ZEpVQWF5bzFKYWh0TWNQYTJ5cXl0dkpZWHpmQ1lSRklLUTh4RkRDWnVGVzBJ?=
 =?utf-8?B?amR4Y3F6N2EyTm1IY2FBKytEQVBodmpZT3pOSFk3SDloYkU4QnlLSVBvZVdC?=
 =?utf-8?B?RlVlelBXR2d1UmNnQVAxdTRTQ2JjdW5zNjdEVnR3SmhEckYrSVdDaWFsRW9Q?=
 =?utf-8?B?VVdvSE9Ld3ZDQVlpQXJicFpVcUdIVmhBM2RlS3RvbE01aVRVYnF1cG1HMUtY?=
 =?utf-8?B?bmlhVFo5cU1NR1dqOGFnZlMvNEhNQUpnd3ZlMlUxeGdHS2pRaVBpSmIzeDNx?=
 =?utf-8?B?czl4bUc3TDUyaTAxeXZzZWhpeTlGeDg4NkhjVncrL2h0MWl2bU4xMTNOazFH?=
 =?utf-8?B?MkEwalg3WVhWY3dhMVNZSkpZR09DdEVwWWxhb1B6YUEybHJSVGM3VjVwZmxu?=
 =?utf-8?B?TmRYbTJxTXlWRlhNdDIwRllFZER0ZkdYK1JPekVTdzgwS0JMaXpvU2s4ZU9U?=
 =?utf-8?B?a3Q5TktzMWZxbXBLWVVubjZZbW9taUVIYU1acExGN0dybWZlWCtPRHRKQzd3?=
 =?utf-8?B?dDJVaFhCMXVrZ1NBZDA3WlBlVEZJWlBicmlXcFJ0aXU5bHlIQzdHU2ZFZmZt?=
 =?utf-8?B?M2I0K2NIWXR5ZGVodU9wdm1PN01DSEQwQ2dSSW1aVDFYM3E0MU5URU4waGs3?=
 =?utf-8?B?cVlqbnpIUS8xRTZmN0tydUhWOTJkenV5SGRya0ZFVDNrOVdlMk9DWGVxVGdI?=
 =?utf-8?B?amdFUGdDUGJFSExIQU56NFltMGRUdWVjeVFrMmxIKzRxOFY3MVBlL0kzQ2FS?=
 =?utf-8?B?cERPdnVGRUdEbm9ZZzFMd3FWQ3N2M2Z1aUJVQ0JzMkdFdzBDM1RYQ2FtS1Vq?=
 =?utf-8?B?b3hOTE0vMlNGcjZnSHdGY3dOY0lJMWl6U3JIb09sYU1jdlNxbSswYlFJajA2?=
 =?utf-8?B?QTdlUGVud2p4QzBOMG5PM0ljc2JUbTJYcDkrUWZOVFVRKzA5ajZiOS9TNVk1?=
 =?utf-8?B?bVlXNndPbUROU0ZNMmV6THQwNkNacWdXOUpvQkpLR29FN0hxSTJkdWljTGpT?=
 =?utf-8?B?bXRrNjF3NGpYOVhtQ1A1cm1sU2ozdE1abVNScTdpcEF5SkNtMFp1WHIvM082?=
 =?utf-8?B?dmdXZnMycVIrbFFlU1hRLzlZU25XeVBNa0xIeDNBV3pGVnpaM2ZHcnVoVWJs?=
 =?utf-8?B?ZGhDQTQxNnlsZ3ZhYk5URDNCQlAxMU1BNU1oVUJSREZsTWs4Zm44dkNsdVZz?=
 =?utf-8?B?YnZnWjZreVNndVhLeVNXNzFreWtHcENNTnFFSXM4Sm5HZ0VaWHBKNUhDdEdW?=
 =?utf-8?B?Mnh5VFZaR0krcDUyNlVxOFZlUE1FQ1plYW0rSHBLS0EzVlJqREhFNU5wa2gx?=
 =?utf-8?B?a2tPR3dIWko3N2VCQzFLMG9ZTTF3T0tWMXV2dkZPQTBDYnVUM3YvTFNrZDVm?=
 =?utf-8?B?bTBQL00vUFF1b2NVSjYxTldPdWFSamg3bFRTU1VBclFUeFhjeU1BYk1BVkEy?=
 =?utf-8?B?RnExUUZzbE85ZlBTTTdrQjJyK2VuL2IwYXRPSUxrSWRDcEl5SWxkYzR2RzlE?=
 =?utf-8?B?M0d4VStoOHoyT2I4eWhFSGp6Y1pUMnROc0tlTTB2Mks3b0xvcWl3bW1lUFNU?=
 =?utf-8?B?b0g2cS94K3grc203eCthM0g0UjRTZVZvbFQ5M3ZMWW1xaDllYXVHK3ZrbnVV?=
 =?utf-8?Q?WZmRNX2W9dnTsXCSQgqrme5HV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1931ad-e663-4334-c6ae-08dc0d0d338a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:09:13.2506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOAswLLGru072B80ZKXqHSPPeWGW1NvfiLy9EDA0wuvtUvrvWmW47KSXbyRR4eGd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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



On 1/3/24 17:32, Tom Rini wrote:
> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
>> On Thu, Dec 28, 2023 at 4:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> [snip]
>>> +In order to maintain devicetree files sync, U-Boot maintains a Git subtree for
>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
>>> +kept updated with every new kernel major release via subtree pull as follows::
>>
>> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
>> had in the original repo). I don't think it's relevant.
>>
>> We're not likely to regenerate the tree, but any clue what 'git
>> subtree pull' would do in this case? It could happen if we switched to
>> git-filter-repo.
>>
>>> +
>>> +    git subtree pull --prefix devicetree-rebasing \
>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>> +        <release-tag> --squash
>>
>> I'd put this in a script to run. Documentation tends to be not quite
>> correct. A script could also be smarter and figure out <release-tag>.
> 
> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
> something using subtree, I do hope to learn some lessons from what you
> do there. The first thing is that given the size/nature of the commits,
> I had figured I'd be the one doing this as a subtree pull+squash then
> push, rather than posting to the ML since it'll be huge and
> un-reviewable, but with a note sent off to the ML that people should be
> aware the next sync has been done and retest as needed. But Sumit, were
> you planning to do some of this instead?  The second thing is that if we
> move the subtree part in to dts/ instead (where we will still have the
> Makefile/Kconfig we have today and then our Makefiles within the
> directories, this might get more complex and so really require a script
> to keep it from getting error prone?

I played with this series and didn't really have time to dig into subtree 
mechanics but one thing I see is that when squash and merge happens you can't do 
simple rebase anymore which is time to time very useful.
I see some different rebase strategies and --rebase-merges option but if this is 
adopted it should be properly described how to rebase u-boot tree which contains 
some subtrees.

Thanks,
Michal
