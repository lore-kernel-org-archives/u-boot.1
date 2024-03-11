Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6ACC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EDB87F09;
	Mon, 11 Mar 2024 10:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CTD5/0Fq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9C687F01; Mon, 11 Mar 2024 10:12:39 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1A587F04
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emzPgrpFHUHIgetuwuPs1wsRt6QKSOxLsx38DMJ6CZbJ8/Gir2GPVBQQn5HurpyoJ6rntiv03374TiurBlnuJ/AFOZ2RE7Eg/aa8hn7AnSLVovO5NiUa5G3XBvq21MF8bU+Tnnb72D1LVR1WsP/R6sv6t5ZwCYpbdE//kAMZK6aDY2VMZmY5JddbKe7DogaFrUOHmV+tE3eFJDdIUkQy5witiUHxMXDVCAHco/C7ZqEDL+DgQsSTb4nOqz8rMfQnNs7vEfVupKTGAMVzOwVM1GbV5m+1zsLRxrqv5XrM7kd0ycgdU4bMubc2hXbp1A2VJbO5JGGU9Psey6VhPSfA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6aTpbDW8/5JZq0pO2u6ENfemf1/0HOPl5oWF0EPUPE=;
 b=of1pUL69uKhCK2mFfzkATC9rUH6do6e5s7482YjsFzJCIdGw0J2h2MH1Jo+4S9MeCn5549msg3swrboFTPDokAeR1YV5nO0vJ3PMNkR/OpwYSnl9qMKQAAe6gOrLMSFtqNZcuqDjUGtlfAK6Q51nEpexCe1uvO07Hv+5jmlN/sDo+N0doC0fY2kT8SPIimQ2ekJjw3HDM9nwsHme83DiCdFF1Lm8Kfgt644h9br2bbH5opvP9rZGShUa41+jIJpNb81rQtkSz9qeOGQapTn/TFrofNbLBfnt0tApGTbMzZMRGQ/op5J3Xe7yRq5RBmbH+8sPcTm5gGqFAokjn3MLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6aTpbDW8/5JZq0pO2u6ENfemf1/0HOPl5oWF0EPUPE=;
 b=CTD5/0Fqmn83sMrbjL3rHLwRg+y7ftxCGhTWq6Xlv5mtggf4lgR9Exiwnpf5i6Q5LTuUQ+yrrnJrZL6GkZ2gEcJyE33KR6/vwfdUM3zcKOcAa8KT0K1+WFS+1DI1TCSFZy/z0tVNJo5w6Vw8aIbSYizzimm70irQ5NSXUdrNsys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:12:29 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::17ee:bb1c:2418:7e32]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::17ee:bb1c:2418:7e32%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 09:12:29 +0000
Message-ID: <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
Date: Mon, 11 Mar 2024 14:40:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Content-Language: en-US
To: Angelo Dureghello <angelo@kernel-space.org>, Tom Rini
 <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>
References: <4b7c5e82165b009cf8b28701ca3f1e182fbc3c09.1708414720.git.love.kumar@amd.com>
 <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To SA0PR12MB4461.namprd12.prod.outlook.com
 (2603:10b6:806:9c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 90696b5b-5fbc-428b-ad3d-08dc41ab6023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Jlb2crUIncF1LarUGbbA+MhNqK2miaRfPJTvMjUgPZDCVh00fNUINMcaLtfic1ySjbwyNff8Oz4PhY+JXhajbcTAHEPXNOTrt7+18+FxdjqUxeXSZ/vksX5YfuiZSfV177eTONc1ZNPVFsS4/u4SDyAoeEtjqUy4jPxg7xar6RTfD8H8mfBYMn1Jo0Go0PGcDgM+kX9Bp2ELBVkQ0DCF3qWDoNw93UDgAmLPSItGBoi5vKfvcE672elLKFGDi/JOhlYNyG/6I9kKkpj0o0KF1ng/HnF6svzBXOp7BS1301Uvft9TkXMIGPWi/1RimvGWpw1VoVEx1eaBL7f+/1s66yFCrslUvvZmp/BpI3kGzLrhnTn4gI1oI9Wkq/y9aB2nvg81g7v7yW9rl2wsVGkDdbb/ycYHmRuBTINfn805qI03hFRuTP4etwC31N7WUXDIEvkKSgTAfw+N9PApQxLwn0m0EB8ayJ7Zk6+qpRQMndY0clq+IKAlvL3tKR27f1n7I9Zm0fKxP4Zoi9/JE4BFbWdEGrUIuQD/+4nsazRXiWrYF/0rmdm9At0GTWRuT+KujYbnSj/AMpxAr/rKbHVYNh1H88zWNmdBoApkhhpSUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNXbEdxTkNyVDZqWWhSRzNPQ2RqYWhZVzZOb2VzNjQ4aGtBdjlkU1c4cGdE?=
 =?utf-8?B?YytSS0Z5a3NIaENhdnovVWdDV05vSUVZdk9ONFFYaWdoalIvS0M2SnR3MTJJ?=
 =?utf-8?B?MlhwWWFaK2tabWZCeU5TUGxxaUNFcnJ4SjB0OWo3YUZoZFIyYjFRQjQ5ZlZT?=
 =?utf-8?B?RXU2dGxZS3Q1c3ZORVdsN2F0UXc5bDRFSEoxQWRCZTE3dG9lVENWdCtjVGFk?=
 =?utf-8?B?TFFkN2pEZFZrR1lZTGtla3B6QldPaUNlejY4U1g5cWJiQlpzdU1RSWxmRTMw?=
 =?utf-8?B?cjhUS1JwelpUWGdnY2pWMnZySEplUVlHbXVHd2V1T0FYMlNsK3MyZTRXVFh0?=
 =?utf-8?B?MCtWNC9GYjlCNGFYcWNyU21NbjRLaWM0d0JrWjE5eXYwTkt3anlkN0NFeEYx?=
 =?utf-8?B?cVhrb2J1a0Y4NVk4M3JjZnBSNmlmTkZUZlBpMWJxNlhKZGlLNG00Q2dpS05M?=
 =?utf-8?B?NHFtU1dwcGMwWTNHZytSVEVMUjBqdzlmOExoMzVVSVY0c2twb01WZURYYnZM?=
 =?utf-8?B?RDlmb0VqZ3B6TDQyeG9Pbkxpc2Z1UFRBZlNxSkQzOElxbFBpNGdEUWFnS2Zm?=
 =?utf-8?B?N0pCQUJZMyszS3p4UmtkV2s2M2xOREZTTjF1MVNVQ3BYTlM2SW43S091SWFQ?=
 =?utf-8?B?WnBKS1NNbitOVFFWcnQrS0dsYTRMOXVQeVNtU2R0ZFNpQlBzSEtaL1lhY0FJ?=
 =?utf-8?B?ZW5Zakpva1dSQWpRUWlpaWl3cDQzRjFxUHBXbTVuT0FFZXE0L3ExeEp3bTY5?=
 =?utf-8?B?M2xHajl0bisrT09rRWlFVVdtZEQwMTMyWkMwOCtyTmVJWGU1d3pXZGg3dXZ3?=
 =?utf-8?B?NUNvQU9WRUhIV1pDcUFvK2hBQ0pYR3hmSk84ZXo5eTluSSsxRTAweE96N3hB?=
 =?utf-8?B?N01uSGUzVm1MdUgzZmFnQ3lJUFBMU1k4TmxxclhJcVVGdjFrOC9UNzlNdUww?=
 =?utf-8?B?TUt0cWl4Um5FdCtKZVFPYURZaUE3UnNKYkZvbzhBVTRTSXhyVTd3SWZhd0Vn?=
 =?utf-8?B?WEFxMG1YSWxuMlpoRkZlam8reGQ5d0xEaGF4a3dFZ2pvcEJ4TlpBM3N4cWFS?=
 =?utf-8?B?Z1hyRFR1cjVqTWlqak9FdXNRajNML2xmWWRvREJSZk9kWWlYbnpHa2NWNEho?=
 =?utf-8?B?UWRDUlBCNUFObnJQR21TWksyc2FGWDVCbXlEVVZOUXVzeXZBenEyNGdNZnFx?=
 =?utf-8?B?TjZhYUxUblo3cEZvQU8yZGxMSEJsTTFWaVpEUWRzU0V0d2kveEdxWGhOVTJP?=
 =?utf-8?B?VGFaZFBwVkVYbVc3eGpraHVhWnptYW5kV3RWc090Q2NBZGNpc1ZWRzFDWE1h?=
 =?utf-8?B?N1JQSFlSY1h3VGRsRkFWZHk3MjVXVmx6UzZvU1J0M1ZNZEtzVll3NTJ6aXNF?=
 =?utf-8?B?VWZ6WVM2Y2YxR1lBc0xLbER5V0NNNGhGMFNQVXpLYU5scXA2d1lQejJZOUVB?=
 =?utf-8?B?Tmg4Q2ppalhDOXhOcW9zNkdQL0hpWU1BbVlNTXRjY2k1YU9RTno2SnVXemQ1?=
 =?utf-8?B?ZTlkZXR6MTF6YndBMnZhRHdiUUF0eUUwZWpZTUxqZm9rc3VzaFFVMnlTNElz?=
 =?utf-8?B?QXBLL0k2MGJpcXdBNmhNUWlGSDZwRmFZU0MreWdRNjArUHoxRXhKVTFWQ3px?=
 =?utf-8?B?V1VOVlFBUDQveEI0bDY4dU1FRlJmaUs1Z0JyT3VYejhSOVprS09DckVLYWQz?=
 =?utf-8?B?d0lPVTZTUm5vaEwrZ1BkUVU5MFNvN1VMZXZUL1NSN2JzUk9wUWFqajllNTRI?=
 =?utf-8?B?dWI3azZPMER5VUcwUUpPN0oxdC92cmtEckx3NDZUSk01bVZ0RUd0THhhNW1v?=
 =?utf-8?B?d2gxLzlpR0tKSkxPTUdQMmlVZGp6RkxXUjYwRC90U2hTblBHdjQ4azZSTEFs?=
 =?utf-8?B?Z3BqWFh5R1hhcExMM3hwYnc3N3RqU011ancwUXNyZzEzNTgzaVhZSXRraE10?=
 =?utf-8?B?Z0NGQlFFVlkwUEorV3hQcmtpRjU2N0ttZG9KRE53b0F5b0ViYmRSaHdZMHVl?=
 =?utf-8?B?UkhkVWdlUTJWTDBWc290S2tCZjNsV2ZYVXQwVU9ncGdSUnJtTU9obGVZYWtP?=
 =?utf-8?B?M3krRk52MCtaNURocWtTaTNvOWt5YUtNQzNZekt1UVJURmpGRjNYTXE4SDJk?=
 =?utf-8?Q?gTnU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90696b5b-5fbc-428b-ad3d-08dc41ab6023
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:12:29.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47JroQI7TIO14RhDvj0VIHvFsAPvq8O4BniW2qzYLHMaIv9W11yLUwurAKzvbmXr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

Hi,

On 11/03/24 2:11 pm, Angelo Dureghello wrote:
> Hi,
> 
> jfyi,
> 
> reset support added in qemu
> merged as commit d3c79c3974.
> 
> Regards,
> angelo
> 
The other issue was with echo commands:
=> echo $modeboot
$modeboot

=> echo $?
$?

Does HUSH shell is enabled by default for this?

Regards,
Love Kumar

> On 07/03/24 1:55 PM, Tom Rini wrote:
>> On Thu, Mar 07, 2024 at 09:26:42AM +0100, Michal Simek wrote:
>>>
>>>
>>> On 3/7/24 08:56, Angelo Dureghello wrote:
>>>> Hi Tom,
>>>>
>>>> On 07/03/24 1:10 AM, Tom Rini wrote:
>>>>> On Thu, Mar 07, 2024 at 12:36:42AM +0100, Angelo Dureghello wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 05/03/24 1:34 PM, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 3/3/24 22:58, Angelo Dureghello wrote:
>>>>>>>> Hi Tom,
>>>>>>>>> On Tue, Feb 20, 2024 at 01:11:38PM +0530, Love Kumar wrote:
>>>>>>>>>> Add a test for reset commands which performs resetting of
>>>>>>>>>> CPU, It does COLD reset by default and WARM reset with -w
>>>>>>>>>> option. Signed-off-by: Love Kumar <love.kumar@amd.com>
>>>>>>>>>> Reviewed-by: Tom Rini <trini@konsulko.com> --- Changes in
>>>>>>>>>> v2: - Set bootmode through boardenv if modeboot is not
>>>>>>>>>> defined Changes in v3: - Fix the issue with bad pattern
>>>>>>>>>> found on console --- test/py/tests/test_reset.py | 61
>>>>>>>>>> +++++++++++++++++++++++++++++++++++++ 1 file changed, 61
>>>>>>>>>> insertions(+) create mode 100644 test/py/tests/test_reset.py
>>>>>>>>> I had hoped this was all sorted out now, but both this and the
>>>>>>>>> saveenv test cause qemu_m68k to fail now. See:
>>>>>>>>> https://source.denx.de/u-boot/u-boot/-/jobs/791635
>>>>>>>> looking into this.
>>>>>>>
>>>>>>> Is reset implemented in qemu? It should be skipped if it is not.
>>>>>>>
>>>>>> yes, seems not implemented
>>>>>>
>>>>>> => reset
>>>>>> => reset -w
>>>>>> =>
>>>>>> =>
>>>>>>
>>>>>> Not finding any trace in the qemu code related to
>>>>>>
>>>>>> out_8(&rcm->rcr, RCM_RCR_SOFTRST);
>>>>>
>>>>> Does reset work on the real HW, or can you not test? What I'm 
>>>>> wondering
>>>>> is if we have a missing feature on the board/arch code (and should
>>>>> disable the reset command) or a problem with QEMU.
>>>>>
>>>> I don't have the exact hardware (m5208evb) but:
>>>>
>>>> 1) i checked by tracing that on qemu the reset function is properly 
>>>> called
>>>>
>>>> => reset
>>>> resetting, RCR fc0a0000
>>>>
>>>> 2) reset register address is correct. I checked also that writing
>>>> directly to it by mw.b does now produce the reset,
>>>>
>>>> => reset
>>>> resetting, RCR fc0a0000
>>>>
>>>> => mw.b 0xfc0a0000 80
>>>> =>
>>>>
>>>> So looks not implemented in qemu.
>>>
>>> ok. That means that we shouldn't run reset test inside CI loop for 
>>> this platform.
>>
>> Agreed.  The TEST_PY_TEST_SPEC variable in both of the pipelines can be
>> used to say "not reset" for this platform in the next rev. It would also
>> be nice to file a bug report with QEMU too I think. Thanks for digging
>> in to this everyone.
>>
