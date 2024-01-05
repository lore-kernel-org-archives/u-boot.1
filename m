Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B9FC47079
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 08:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EED387575;
	Fri,  5 Jan 2024 09:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wR8Co8BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623E5874D5; Fri,  5 Jan 2024 09:17:02 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81C187575;
 Fri,  5 Jan 2024 09:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQQIbbDZ43p2xQ/boUpXejb9FJNTaU6bLECnEu2EzqN4TpLonNlLZTCvqO+qztNMXZFOv/BNkhvL3av3Z9CwjCU2NudJztpyL1snQrlK6mXzqDgO3Rqugi+Z7YVEutAR/GATL2+71dnTe9O0qMm1gXbxSZ2jICYZDtfBxuhf2KgzWm6dbGsYVH+v9ElYPPvropq1HD2YRjTYiU8EqCwt/tlCpJRoPXdq3U/VOXxw8xeU03UKbR3D6GoKr+R23o+oYYN+diB8DaVL4w/A7XSyZwKq1gOws7CpdkELgcqb7uhOWq+cBg3o3x6H7hO+W1n4Es/Iny+b9Ep+Ox7cJAzLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhlktZTZelD2YfophrrI4D++dCU8AeMfauJFSaWTozA=;
 b=jGw6hX7SFoYJP32GkzXRV3hfruNaye1bmcEJUD1ld7Oy7U/KlSRYU5u1+Ot0DRnD2vysqXrJESyqqr72rJ1S5nTsJVKQUthOqnefGpuuWt7nY5o52gWYofVu29vpYZ5VH77NwOZVNWkHM5O5JfbgwuqEsFk6tmCZTOElb2UL4Qo1r1RB9qee/dvuoyQX06SuugyxmU8mAon/gj4Jv1fIkjA3DHEv2KZZLhGlBl+mWmJaVeSOoNr5PvZly36m28G20/+FLXanc/7JOBNPW4eXa4LF5oLy/y+HXrUwqcSRx4q4OyJ6ofoBWHV98rWQQNfY2jsFGqEZI8nvOrPBR+TWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhlktZTZelD2YfophrrI4D++dCU8AeMfauJFSaWTozA=;
 b=wR8Co8BREOS3XjMnEDwbGQvzLbKiywRVJfzZWc7eIReH22y02wkQpnFvxzRw7tattbxUttOttFL9IbV3faYLdQRhvCMDqkpXVxPcOcEHn5fBBRyCob9nwYYPx9che0BjKGyQShGfGSyGi54Fo4gW2O378qo9e+NPZwKTsdsDBlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 08:16:55 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 08:16:55 +0000
Message-ID: <93ad60d2-a2fa-43e6-9ab1-928b12de96e4@amd.com>
Date: Fri, 5 Jan 2024 09:16:34 +0100
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
 <785175cd-a2b8-4d5c-8f2c-326125465ed6@amd.com>
 <20240104180336.GU1610741@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240104180336.GU1610741@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0253.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::20) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b70a17-0d0a-4dbc-0d64-08dc0dc6ae05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zjBkmWgc+WurckH6fqsjdVYPBQ+FAObWaHS25evtHPfYwwldvINLZ7u9phi5ObEkXDJ5My0H5MzkQyeo2QZLbgbmkXlne9NPlayCA94G22uAibKboTMoEIiyXyH8azv55w1UJerdTJswQqHhc3rvlupNYaD3ApMHNseokqjBosY/im5gFne+9SBMfZF2wNAXX5ltEH+YMUBfbqdFxfCwbccmAsBfvayw+ukfvkF6TBvxGnHMl8OMM1OtGP1ZJA5DKJ3cwXTYZL8AfGQ58w1MOMctLMvOsGrbsvTGquoH+qWhDjhtPo2LgOBvhhJPLGqx1TErUngbBzI0BF9Vc6pvnnrcOl5u/chBqKrMsmx7Ep9YwqFWmuUQVRos5I4cFAlp6zFA3tOGbTXAmK1VUQ8X/IOh8A+Dbj4ci03TtF+qPHwlVS39dTrhmWGrwFvGffTyiSpxL/lwap5UVJwhnq7/VaRXfTybwvja2bB608O3FH/3L5MMl3pJFceTI8GuKmpoinE8o6EQu1zAGNUAeH7Q9jp0DV667N+P+74DQ1ZDm5Tyo4aMvwqyy+xCk2y1kjF+nWJPS9VLvYK6zKUuy8ngh7vlRWSYGwaGizNwqdqkKrEf+ghseVZAEicjBwpwQoYrybPm1j2l384Md3gaRZIig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66899024)(38100700002)(36756003)(31686004)(86362001)(31696002)(53546011)(966005)(6666004)(83380400001)(66476007)(66556008)(66946007)(6486002)(44832011)(26005)(2616005)(8676002)(6506007)(54906003)(8936002)(316002)(4326008)(6916009)(478600001)(6512007)(41300700001)(7416002)(2906002)(15650500001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVFZWHRrUzRyb2ZidDFhYXB6bG1waStJK3JvVlJSV3F5aTNUckorT2lhWWRk?=
 =?utf-8?B?QVV2eWxOMDBuUHFNVHYyeVV6QzBDWlJNL29weGFLWjdCUUo2VzE5Vm5pbFdS?=
 =?utf-8?B?MXRVdVR4TnVlU3djcjNVcmluUW5PdVIxbnNyWUp0VXVxWFgvK0d3UGNjcmNS?=
 =?utf-8?B?RVY4Q01BeEhkbEFPUko4ZjBhb2Y4MHNMQnpJaFo0enF5ejJKNVR5b0JlTlJ1?=
 =?utf-8?B?WFZjaWppMUdmcUJUeUxKY1g5UUtEdllwOVNaRUdSWC9yUDZxbDRHVWxReXFQ?=
 =?utf-8?B?YkhySGJGWkhNaFdQQWxaRzhGd3lkYWZ1L29YdjZPOXVob0dMaEtRNnphMnlp?=
 =?utf-8?B?djVINWUya0dQNXE5SGZmOVlacm1UeUNkMjdVeGlMazM4ZHBWQTBsZFc5WkY1?=
 =?utf-8?B?OE9tNXVTMGVHR3JUTm4waUZLckVmVEwrZkRuZTR2WXp1OXBZKzZXRjZKYzZw?=
 =?utf-8?B?cmtZSHFCb1VTT3FoanY3ek1OU2l4bkg0Qm80RDljYkUvQWNMZkFIL21FRUF5?=
 =?utf-8?B?dzFGRTVLczJpUkcxdUs0dHo0d2E1ZU5pajlqMHJUUXFKTnE5YlJBTzdxMk1o?=
 =?utf-8?B?ejFRY0FSWEltRU0zR0VmMXRYQUN3bnE1dGNYT0ZCbThKNFRNcUFxTXk4eHFh?=
 =?utf-8?B?d0VxYnQyYUhjZVpGc1BUNVB2Z211bjNsUndNVU5UYmtFUHpJY2dCSUNEazdR?=
 =?utf-8?B?cGE5RW01Vk9mQ25ReSsrUWZzN3JzOGpUQ2x3NVFETVJ5SFAxUExqdWNITEhs?=
 =?utf-8?B?U25xVk9ZUm5OYm9lNWYxU1ZnNXdScGE3aGxqY3A0T3FlV2lkaGNRSGNibWZG?=
 =?utf-8?B?QzU0UWo2dW5idEx4SnlGL09ERm0zanFuYkN4RVFEL1RoWVE5S0dDNDVhNTk3?=
 =?utf-8?B?cnk2dDZyY2xibUYxdUhHUkh5eXRNVGkxM1l5OEZkM1h0MktWRUlTMU52YmIw?=
 =?utf-8?B?Q3RJU3lBV3pPVDF5bFl5M1BTZEZZVFRmN2VaWWYycG9pT2Y1bDRUeEFVYVpi?=
 =?utf-8?B?UjkzTVVZK0dYeWdMT2tQRVhzQnZWUkk3Y0xqV2pKYWhvWGhKVmc0c0tQb0li?=
 =?utf-8?B?dG81VWVvbmFTQlRLcUd0TmtLV1RNaEVhOGF0VHkxRC9yNjNkUFZ3NGRKK1o2?=
 =?utf-8?B?YWZmTjN6Zi9TNEdhdk9YVngrbVFNZlZXWjgwZFBBVGNPRHRPYzAvNTNCSzRk?=
 =?utf-8?B?Q2ExWnhNKzcwcS9uTzZycjA3L0RKdXRpeHFVNU1FN3RDaGM1VHFwR0tqQUxU?=
 =?utf-8?B?OEdZZnczd1VNYUlOOXBMV2wxSlpiT3JmbVhtUDZ4dFJNOWtZSi9vRXdDSU41?=
 =?utf-8?B?Y29KdE9VT2pWb2E1WTZZbUpEUS90RUJtN2FlNVRQMDBWNTVwanlHQ0ZjcU1l?=
 =?utf-8?B?VVpXYlBhL2tQRmRUK1pScUwrOVB1NS9TWENtbkVhTVFUbnBsbVVJWWovVnkw?=
 =?utf-8?B?cmwyVGxmWDVVTXNVZVNGZHRTRkgrSlhBNTNRV1VKQnVvdjR4TFhCZ1QzVVNK?=
 =?utf-8?B?ZEQraHM5a3ZJUkhhaXpzUm1ZWnRZU0Zzc2FPY2o2T1A4UVZvSENWSEtZVENq?=
 =?utf-8?B?am9iaUFkN004YU5sNm11MlJaZ0FkMDRvYVhXVXJobFVzcS8yTWh0WjY3RjRX?=
 =?utf-8?B?RXlQOUlPVlovNEk1bTZvSzR1Y2VlUmc3SnRGbDFPYlRyZUdYbWdWNlAwQWdr?=
 =?utf-8?B?VE5CZEc2dlZEbWplMFY3a0szTE9LbklKdEZ1UWo0VlRxbnpQanEyQVUzYUd5?=
 =?utf-8?B?ZjBzV0tGL0JHU1piNmdOb0RLSEllUFNjS1AyU2loZmJDcERlS3M0Z1hRc2xR?=
 =?utf-8?B?MUdqd2xRUHdpUHNjVE9pUFYyT010NndrSVRHbDgwVTh4K2RJTkFzMlFUZG5K?=
 =?utf-8?B?VnM0K3A4NXcwUHlQbEx4UjQ3UjYrVmluRzQwbjJ1N3YvR09zSHFTdGRZRkxV?=
 =?utf-8?B?SFJCR3lYaEltcGg5cUszT0k0cjhlWTY5d2F3NTloZFZRYVRHYklVQ3ZKbUZC?=
 =?utf-8?B?U1hNTkwxNnJsZDRLMmNFNlBOVThBRFBhQS9ZbmtRbVUrYlZTdmRVQnBTRGlU?=
 =?utf-8?B?cmRtVGRqRXJCMldzekxiR0ZYSXd4WHJ4bG9pOUxsSXBTMVVEdU5qckl2K3pj?=
 =?utf-8?Q?C5nF7U6UwdM5LvLOf3Bp/zibf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b70a17-0d0a-4dbc-0d64-08dc0dc6ae05
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 08:16:55.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCs9I2CdP+6ceSZqSG3XCAAZOBQ2foBFXFeG2cSX+zgykzk1LIODezTuDpY8+9g2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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



On 1/4/24 19:03, Tom Rini wrote:
> On Thu, Jan 04, 2024 at 04:50:14PM +0100, Michal Simek wrote:
>>
>>
>> On 1/4/24 16:30, Tom Rini wrote:
>>> On Thu, Jan 04, 2024 at 03:45:10PM +0100, Michal Simek wrote:
>>>> Hi Tom,
>>>>
>>>> On 1/4/24 14:50, Tom Rini wrote:
>>>>> On Thu, Jan 04, 2024 at 06:52:32PM +0530, Sumit Garg wrote:
>>>>>> Hi Michal,
>>>>>>
>>>>>> On Thu, 4 Jan 2024 at 15:39, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 1/3/24 17:32, Tom Rini wrote:
>>>>>>>> On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
>>>>>>>>> On Thu, Dec 28, 2023 at 4:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>>>>> [snip]
>>>>>>>>>> +In order to maintain devicetree files sync, U-Boot maintains a Git subtree for
>>>>>>>>>> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
>>>>>>>>>> +kept updated with every new kernel major release via subtree pull as follows::
>>>>>>>>>
>>>>>>>>> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
>>>>>>>>> had in the original repo). I don't think it's relevant.
>>>>>>>>>
>>>>>>>>> We're not likely to regenerate the tree, but any clue what 'git
>>>>>>>>> subtree pull' would do in this case? It could happen if we switched to
>>>>>>>>> git-filter-repo.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    git subtree pull --prefix devicetree-rebasing \
>>>>>>>>>> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>>>>>>>> +        <release-tag> --squash
>>>>>>>>>
>>>>>>>>> I'd put this in a script to run. Documentation tends to be not quite
>>>>>>>>> correct. A script could also be smarter and figure out <release-tag>.
>>>>>>>>
>>>>>>>> Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
>>>>>>>> something using subtree, I do hope to learn some lessons from what you
>>>>>>>> do there. The first thing is that given the size/nature of the commits,
>>>>>>>> I had figured I'd be the one doing this as a subtree pull+squash then
>>>>>>>> push, rather than posting to the ML since it'll be huge and
>>>>>>>> un-reviewable, but with a note sent off to the ML that people should be
>>>>>>>> aware the next sync has been done and retest as needed. But Sumit, were
>>>>>>>> you planning to do some of this instead?  The second thing is that if we
>>>>>>>> move the subtree part in to dts/ instead (where we will still have the
>>>>>>>> Makefile/Kconfig we have today and then our Makefiles within the
>>>>>>>> directories, this might get more complex and so really require a script
>>>>>>>> to keep it from getting error prone?
>>>>>>>
>>>>>>> I played with this series and didn't really have time to dig into subtree
>>>>>>> mechanics but one thing I see is that when squash and merge happens you can't do
>>>>>>> simple rebase anymore which is time to time very useful.
>>>>>>> I see some different rebase strategies and --rebase-merges option but if this is
>>>>>>> adopted it should be properly described how to rebase u-boot tree which contains
>>>>>>> some subtrees.
>>>>>>
>>>>>> Did you observe any specific difference with respect to subtree merge
>>>>>> commits (Tom will likely do those in the beginning of next release
>>>>>> cycle) when compared with normal merge commits when Tom pulls in code
>>>>>> from different custodians like one example below? The same rebasing
>>>>>> rules should apply to both types of merge commits.
>>>>>>
>>>>>> commit dffa6d0210f57793f1e4e1e209d91ca5642e4d05 (origin/next)
>>>>>> Merge: 2b28c3b871c e266d273114
>>>>>> Author: Tom Rini <trini@konsulko.com>
>>>>>> Date:   Mon Jan 1 12:38:15 2024 -0500
>>>>>>
>>>>>>        Merge tag 'dm-next-1124' of
>>>>>> https://source.denx.de/u-boot/custodians/u-boot-dm into next
>>>>>>
>>>>>>        support propagating supernode properties with bootph schema
>>>>>>        align bloblist with v0.9 of Firmware Handoff spec
>>>>>
>>>>> There's two cases. The first and uncommon case is that if you want to do
>>>>> something like:
>>>>> - Branch next
>>>>> - Add this subtree, do a few subtree updates on it (like my experiment
>>>>>      of starting with v6.1-dts and merging up to v6.6-dts)
>>>>> - Wait a while, have changes happen in next
>>>>> - Rebase on to current next
>>>>>
>>>>> It gets painful and odd, but I don't know that this will ever really
>>>>> happen.
>>>>>
>>>>> The second, common case is:
>>>>> - Assume "next" already has this subtree + some merge commits in it.
>>>>> - Make a new local branch.
>>>>> - Make change in your new local branch.
>>>>> - This hypothetical "next" branch moves forward with changes
>>>>> - Rebase your local branch on to this "next" branch
>>>>>
>>>>> In this case things work as expected. Even if  "next" in that case gets
>>>>> a new subtree merge that you need to rebase in.
>>>>>
>>>>> A third case that I'm not sure if really will happen or is a case where
>>>>> the custodian should rework their tree instead (to drop the subtree
>>>>> merge) is:
>>>>> - Assume "next" already has this subtree + some merge commits in it.
>>>>> - Make a new local branch.
>>>>> - Make a subtree merge+squash in your local branch.
>>>>> - This hypothetical "next" branch moves forward with changes
>>>>> - Rebase your local branch on to this "next" branch.
>>>>>
>>>>> This will then make you try and resolve some conflicts from that subtree
>>>>> merge.  But is this a valid use case? Yes, I can see wanting to get a
>>>>> start on testing a dts merge before it happens, but is this a tree which
>>>>> needs to be rebased, or just re-created as needed, if the parent branch
>>>>> moves forward?
>>>>>
>>>>> Can you explain a bit more your case Michal since it sounded to me like
>>>>> you had a problem that happened rather than a worry about what might
>>>>> happen?
>>>>
>>>> I remember couple of bisects which I was doing and it works fine on the tree
>>>> till the point you have 2 issues to deal with. It means pretty much you have
>>>> config change/fix which has to be applied to see second issue.
>>>>
>>>> The normal way what I have done was simply find major version apply that fix
>>>> and then take the latest tree and rebase latest on the top of it. There were
>>>> normally not so many conflicts to resolved (or easy to resolve/ignore). Then
>>>> because the first fix is present all the time bisect is able to help me to
>>>> find second issue.
>>>>
>>>> If there is subtree update the whole rebase will horribly fail.
>>>>
>>>> I see that Rob and you in DTC case just simply do c&p and create regular
>>>> commit with all changes inside. From my perspective this is more
>>>> straightforward to deal with which will handle all cases and it is also
>>>> proven over that years.
>>>
>>> Ah, bisecting.  Maybe the (annoying) answer is to turn that merge commit
>>> in to a regular commit in the bisect branch?  This is a good point, and
>>> I need to go and construct a bigger example tree and check around at
>>> what happens.
>>
>> Sure you can do whatever you like. But I expect that at the end if this
>> started to be used you will have subtree for devicetree, dtc, lwip and maybe
>> something else. It means you have to start to keep track where that subtree
>> are and what version is used at what time.
> 
> Yes, lwip would be a subtree too, dtc is trickier but I see and agree
> with your point.
> 
>> Because dt binding is extending often likely you will need to merge it every
>> Linux release. It means you would have to do it multiple times depends on
>> how many releases you are going over.
> 
> Yes, the plan is to re-sync every time our next opens with the kernel
> release at the time (which maybe needs to be clearer in the docs).
> 
>> I know that Qemu is using gitmodules that's definitely another option but
>> not sure if better or worse.
> 
> Yeah, submodules is harder and we're not going that path.
> 
>> I can also imagine that companies with SR IR certified firmware would keep
>> downstream version where they want to just take code fixes, DT fixes and
>> devicetree-rebasing tree to make sure that they are still aligned with DT
>> schema. Can you simply just cherry pick that merged commit without any side
>> effect?
> 
> Life downstream is always fun. Personally, I would re-run the "git
> subtree" command rather than cherry-pick from U-Boot itself in that
> case, but it should be no different than any other commit.
> 
>>
>> Back to my point. At the end what we need to is to document it properly how
>> to deal with it.
> 
> So, here's the test I did. I went back to v2023.10, then added v6.1-dts
> as a subtree.  I rebased v2024.01-rc1 on top of that, added a fake bad
> commit, synced up subtrees to v6.6, and then rebased the tags along the
> way to v2024.01-rc6.  I then went for a bisect back to the fake bad
> commit.  Everything went fine, git didn't have troubles rebasing things
> as it went.
> 
> But to re-iterate, yes, the policy around when dts and bindings will be
> resynced needs to be clear and documented. Does that cover it?

I am fine with it when we have documentation around.

Thanks,
Michal
