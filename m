Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B80C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 08:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E2B84B20;
	Wed,  1 Jul 2026 10:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsj4aEus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DED284B22; Wed,  1 Jul 2026 10:33:14 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D332284AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 10:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k09jxdlA7cP2qCNY+jVghiL+NYuZlZ7iBclxoacfP0WSEycLrSlSM02QiRCGVuTfJzzXZPm3i87pmPUJebEX5QPN03JqXZm9v3g0aCy6tJ1FpevgZcXMxoSxLo2iTi3kEKma6O7mw5VEH4cFfBR7Phc4SPNiSsdaPfB3V/GcnsFfh/AnPlT2i3TIF0TZT7+n3pfX886/EOZfWNPIqR/L9YPpHYkAwHmBw/EdiuJNAXvVb1aZyTSX4zfQRdp9EXu6w+WTHkaY09dq/cr5DRmxFMxx9voQbo4Sb1O7OcEDyVv3rZtrWQlcDMGsE5TCJI4dSdnVaf5KZFbq7KqEz62WPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cJP7NXTFW/Q7wB933LdQAG7U3e2xIZy7MNJnDfNHPA=;
 b=w4zebPMt6Q41E7gnQP3UBzFfgSJnAF06wBURDXtRWcRfBaHPSTMAuo5w3Tk9IdxKuAxK+2cQvQraOkA4kzNoLs3Y74rEvkiVl8UUrpY81HZ8ktKGWslSqcbSPpIyQXdmjzInsvP31kyfKtApz1Q8ak/1aYL1jFwHbjvt4GtvhF1jDU0GFfqegiHcxL4m/dtsuGBywN8Ux+cQg2AQVMVCHBGI2qLfsJlL0iSeJqHGBZs3ajcXuX/zUgQEHiVYAOTTtksmPWgeWwKVWxC6TNpyEUxcqf7Mg18fL6pil14/L+sRt0KpXydS2tXQYd131qZAXGsgKrf4ZeNWe26QxBLJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cJP7NXTFW/Q7wB933LdQAG7U3e2xIZy7MNJnDfNHPA=;
 b=vsj4aEusKaHA9MzvhUo7i1yFEFWXrTDVOaLGwi4Vi+zy05W7dNbW0K6eoJta6QDTyEZKt0gy3imTCopCzhAf20EZ10Z8d1OOhgeGXBXbxBJQTSHCYgaHdSyaEzU2cgljSV7UXKUK2k0zv5jYe35KcAbtag7nvPOHI1WEzPXad4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 08:33:08 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 08:33:08 +0000
Message-ID: <12db3d24-12aa-4655-9889-7b6917b14b12@amd.com>
Date: Wed, 1 Jul 2026 10:33:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot Concept Tree Proposal
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <20260629222142.GA749385@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260629222142.GA749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:610:58::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: f05bb39e-5267-4230-e171-08ded74b60de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|3613699012|11063799006|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: p03nS3wsL1y89wVE0w9Pz5TnV0oFFc4+BsYhUJSCtNbOhLImt881/iex/DwPUafQVarTISaF98cT0/zbLU/jpwq0o+d8W+zFeqiwVlMsudrbNZwBBP+GwrEKfc5bAMHrZJV3HUGRej7WCv6NeP/fbL9h/9+vRaoZBDBBzBFJf3w7+peeAs1yEp4VUNaMHAuCtHGqoJ7x8VvdoK+m+xGIYSk1komINSc6xQv/87sglOeIRMq2oed7Mofe/Sh+QsFIAvMg+iOaArmQkRuEbTQ9BA7faimfAc5lyKjgIp1EnfaZSf0MYtbdBnb5ULeLDlLkzGHU2yC4edgFjtxDOTGCOi5WKs7yYp0d+AW6Y1wwSrBusyxlgn9u+P9jnUaTbrDIn0lNdPXmVjKUllb7FvXmNUficwHAPzaLcq8nWvxsoVuhZy4o39/dZzZ1cvoxGnoP5QcyfPfZNvj0XgXGRI1go8cW+JZiTzJQe3/h7FSkvaTa43sME/L65ILll3fm8EqN9an3BYj98MVdimIPTMVivQVdaZFYtFlEo0Em0pBsxwgKnQejxLD1eLpdl+g6ADTSntMLoA3mp7yYJZwrE6lmDQHiW9+iMvSm83IVYEcKwY7l5VbPlY+wjRKbjPDQVhM2LGVe9lEbf7GJxZeTdtBjRozHHTP8vCyRZ73MNGIPW6pdX4EQnoAuWPtXV5ZUgXeCW/kYK4VRGs9VGZzOHOsqOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3613699012)(11063799006)(56012099006)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pkZmhGV0NLS2ltS250T3MyckJ1dWlNM05BZTM5R2R4TXJWZVJnTWxxQnBY?=
 =?utf-8?B?emRhRndoZ1dYQTVBYWQ0QytybVFMcDZsRllWWWNRQkkzcmN2YUtJeDJVME4r?=
 =?utf-8?B?Ry95bDY1SENCN3Vsa2pLVWQxVmlML1JZUnJwenhDQlp6Q1l0NG8xVGFTeWhs?=
 =?utf-8?B?bjljY0VNazhuNldWdVJNeHFaYi9WdUV6SFdIQUtqS2doSG05TVh3UzdXZk1U?=
 =?utf-8?B?NWJTb1pZWjVNYzRvUUtrT0dzdlJqSlVWTzQ1Nm8rZUNuZU16SXhzeGtDZ003?=
 =?utf-8?B?d3hKeU1EbUFsWkdHMXlubEI5UVhTUFlRNWRvdE85cWZ6SnNrWlRTaHl0bmo0?=
 =?utf-8?B?RHdzYjlRemtTYTVVRzJaQnhvOEc2NXJBcW1ubHZGQlVETHl6UnVQQ0NlMG0x?=
 =?utf-8?B?dCt0dFZYSjB2eDRUazl2RnJyRnQ0a0U5SVBHYkZvOG9SbHd0Y3JaeSt2YkNP?=
 =?utf-8?B?SUp2Q0hZYk5Xc1FpNlBXK2V5UHZRSWs4MVRuclQyNWZrZXB0cXAvVVQ4V2Yz?=
 =?utf-8?B?M1U4cUNNU2FBWG1EWVI1TGJUOCtRUHJERzliSU8wajd2L2x5SWYyUWFRM2cr?=
 =?utf-8?B?Z3pja2xOdkpXQ1FMNmpzelRvUXU0MkIxd2RHNFRGVXJzRmdJaVlhRTRoN0Iv?=
 =?utf-8?B?amE3aWhHOHl5WE81S2NlRUNIZXUwbUJ2a3U0RGk3M0FrYzh0aG5nRk45QTZj?=
 =?utf-8?B?YlR0NE1jWCtCNE55Zzh6S09mTWt1ODk3SEJHVS9XdE1qMzdJZHJpN05qbkUx?=
 =?utf-8?B?eFR0RFA3Yll5MVBuYmt5UXNXOU03L1BjOElIUnV2ZC9DVUNuWkVMYitZSnNJ?=
 =?utf-8?B?YzI5akNJN2FxZTRqUlJkR2h0MUNWVDhvOThrcGNlbk5UYnREREl2MFNkcFZj?=
 =?utf-8?B?QkJIT2p2LytkamZlR1NPeDhiYWJJZExBUnlnd2c0OWpweHhXa1lEaUFCUzBN?=
 =?utf-8?B?Nm5mNm1MdVNuQ1JxSWJIcUV6UldKbVFBTTd4WXYvdjlvbUhjRkpWTUdTSHV3?=
 =?utf-8?B?ZEV6dUkwNkxTYzB1cnBGZGdocEtLVVdSd0Z4OVBqK2hBenBIbGhPdW1OWjhv?=
 =?utf-8?B?U1ZYWTNvWUxJSUw5bFoySWRwUjlBWWI4MVArcGw4cjE3bWlteGFUYTUwYWps?=
 =?utf-8?B?aEdPOE94Y1pUZjM1NVNhbFB4Qlk1M2ErdjdHUXBlZHFNQWJMTEdIK3VqTUJl?=
 =?utf-8?B?TjhWSzNwS0FzQzZxbEZ4S3BYb0w1UGlZT2pHOGhsL0xXT3NyODNQU1B5V1pY?=
 =?utf-8?B?dFRLYlU2ZktBZ3lHUi9wMUQyZmhxU1BtUWRIV2tabVBOK1BxckZsRC9hUHJk?=
 =?utf-8?B?YVhLNCtmMGZ6VWtORkRjNm5VWUQ0OGozQmdqK2xyVmpTc1lHWGVGN290SldX?=
 =?utf-8?B?QlVSWXpxODNycUFMeGxRS3ZLakprQnZtVDZFa1doazFHUEtDV25Bemx3S1Vl?=
 =?utf-8?B?anV3WDFoc3JaUitmRnJpYTNJVndQQ3FiM2MvNjdkRjFyenpER1BqOHgrSDRq?=
 =?utf-8?B?QWVjMDQrYXJiZnc3d1pZcGRhMW1CWTRETHBiRmd3YkRiRlFrWm1HL3VVSE5q?=
 =?utf-8?B?bnZnMmdNQWd6bkdaWUJlK2lJWVlDRzM2eHhKck9ieU8ycmk5MXY5bE5YTisr?=
 =?utf-8?B?T3NmOGt5cS9IMHhuVGx2MklJZE1MbTAzSGN3bDJHa3ZieEFCdk1RdGdtcHRo?=
 =?utf-8?B?Wkc2UVZZdUg0aFdVMHV0YVhSMFhnOVVJR3ZCYVJ0cXNqaVVaNlBIRTA5QWsr?=
 =?utf-8?B?NGVYK2dqSm9UNlc4cXZWRGJTVGIyMG0xK2UxMTBRZk92ZTBuWXoxSGZCSW40?=
 =?utf-8?B?S3VqcmZyUkFzOVAxajc5TlBOMTgwSXlOOXR2UVNETi9nZWl3SzFEamx1cUI3?=
 =?utf-8?B?QXVQdjhJSTcrajB0YjdkQ2xuMlFoZjFlbjdqMm9vUUNYS0hxRTI3SXZTK216?=
 =?utf-8?B?Q244QTQ3K1g3NjZRR0xna00wckpwSEpDcnpoTFB5UElScCtJcmFXYXFXay9U?=
 =?utf-8?B?SzJzekNRTGFtbzc2MER6NmJTcktQL3NWWjhSVlBPaGpCd0FhaVNtREdHQTUw?=
 =?utf-8?B?UnlLMHFXNi9iR0xjaUR1S2FDZDhoWkRTNE9sby9mZ1R4bGxBTWlGQkVSeHBi?=
 =?utf-8?B?UEkrU3VLVGQ2dkdEYWZCb0MxL0ZBKzlCRHEyM2xSYXVMRlBYVkExd3JTQjRi?=
 =?utf-8?B?ZXhsMDJpeGw0ZkVmcG1wVlcwd2FRSEhLaFZEODVlRnpKWi9wTXp1Qm96dWxp?=
 =?utf-8?B?RnA0OCtma3prN3NUQVVvSW1qRUxRek9ISlF2OHUzdkpBQ3lmWDhxdUorUXlx?=
 =?utf-8?B?cXdQL3hBT3Q0WUJSbTRBQ3hIcFNyUDZhcXpMeGcxOEZHK2FreFpCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05bb39e-5267-4230-e171-08ded74b60de
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:33:08.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xB2oCL9V8tZxQfkrflHNOfM9CcJP3IPE1H7erAs9P9kuenVTSiy94lPOT1VeDBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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



On 6/30/26 00:21, Tom Rini wrote:
> On Fri, Jun 26, 2026 at 08:07:16PM +0200, Quentin Schulz wrote:
> 
> [snip]
>> I'll finish that my gut feeling (shared with some of my current and former
>> colleagues) is that U-Boot is disappointingly unstable. Unlike the Linux
>> kernel, U-Boot suffers from fewer eyes looking at code, fewer people
>> developing it, fewer people testing master or even any recent release (the
>> number of reports we have for bugs on releases from years ago...), and lack
>> of proper and extensive CI test infrastructure (and if we have some, it's
>> heavily centralized into a handful of people's offices). I loathe every time
>> I need to update U-Boot because I don't know what I'll have to debug for
>> days or if I really do test everything there's to test (is it my fault for
>> not keeping up with master, yes, but I shouldn't feel this way).
>> So I really think we could have much more confidence in code being merged if
>> we had more testing, possibly on real hardware, possibly by companies
>> offering to do some proper CI (e.g. like Intel is doing with Yocto, spending
>> days testing release candidates before the project tags a release). Maybe
>> with distros slowly adopting Aarch64 and U-Boot with it we'll have more
>> coverage. I know you've worked on labgrid support for U-Boot and you have
>> some merge request(s) still open there but it seems you're hitting the same
>> wall there you're hitting here.
> 
> Thanks for the feedback here. I've been staying out of this general
> thread as I believe my thoughts are well known already.
> 
> For the specific topic here, part of it comes down I believe to a very
> uneven level of testing. Both AMD/Xilinx and TI (and in turn, a number
> of their vendors) have labs and run tests with a good deal of frequency.
> I suspect NXP has some testing going on too, and this isn't an intended
> as an exhaustive list. But others really are very much volunteer lead
> and getting a reliable and remote lab setup really is a lot of work, so
> no one has done it. Rockchip is an unfortunate example here that I know
> you run in to. I have an rk3399 I've been trying to find time and space
> to get up in the sage lab, for example, but it's still just not there.

This is a topic which we should talk about more.
It is clear that we can't expect that internal labs will join our project
because it is very difficult to provide an access through infrastructure.
Also you can't wait for companies to finish their testing before release.

But on the other hand developers have enough HW on their desks which shouldn't 
be that difficult to share. That's why I think we should provide much easier
way how to share these HW and wire it up with u-boot CI. That could also allow 
to connect custom qemu models instead of just upstream version.

Thanks,
Michal



