Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7DBCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 05:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7E08480B;
	Wed,  6 May 2026 07:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="akSS7RNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E281A84812; Wed,  6 May 2026 07:48:07 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5D984807
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 07:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciTGP6pBjBx0Mdy/XUIdDxEHxD0+AzCKICR9WOaHk6A8Dj5JVdRzs5c1MmfRHOSroWEREJI8nIxsDHVR6exQokL0tVTL2Gj2OZTRZDVMlOAsmIlX76insWZ73+uYCsiq+F2/YtcDbkBdiTXRoSiM7zOMbjFy44n8jCBQmP8YnXMORWFgFS2j+7OqgTjeOGjjYCuobIf2elcGIabDnDr4Iok8ipNX4rOAUtzZ/E62YY+gmORQ04YzbhSwSc4UovglZLQE4v2yHFAi1I4rzfx/yArWSdHcgklI5qq6kumAM7NGQPmAEYzwoh+DrIri8dhlGSJypL2w2H/I89++Q6gdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRSXYXBgOvX+h/YWBi8OjPml3N0GslMSaQaBsVVNttg=;
 b=MnmiIggtrj0/NIZ9VHuyotdaX+0fEd+uOJDGhJoEywU9xbvgM/4PIzr39xxnLG1aUqbxJASKzsMbUhL+qq9+S9me/XNflVZud0qbHnWeTYjLZpYsjwMvPR5rZnX/Kznk+eNVpBgsi703wsVgI/OetbzaYUNzaCYx4HrW8iRkM6dq0tUXPIKj6XCq0fPJZs9ZB5NqpWg6Ufi2r15kWuGL/Yfi4eqFcgNQ+/AJAmunGN338UwGMO0BPWYCx/XNsIEQLGgmpjf0T62dQVXXopwCjvZQeAoJV/SAJL+ZW2pp4wesaFFz3gU2EwmkC0E9r6146fEdJxvBzGDRcm0xNjyfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRSXYXBgOvX+h/YWBi8OjPml3N0GslMSaQaBsVVNttg=;
 b=akSS7RNIeG6zPVl0T51H2APJSuJCD3kOhrswjda69iseoQAyrNBYXHndaWW2TM4Zzt5GLfTGxIx8clQMFHTq6jjf777FYQlVbAaLLH1I2kXAYKYZqOJ+zFlo0FQsdke5aKNRgOXuVlQIOgercfdtLV+DaCFZUhQnHTHY2aJ44fuMc2VsL9AGy8aT0r0rb8ERIT10HbiCkuk9HLBoBWmbst+DqmwsVjX3SQDtbrCK0L2c4hi4jEavjdtjxg6W2f9iC/faAWVElSVn9CSvWkr4etIl+oCEGcUNG4DmAs3pj1NsmqlGJdlHaWL5bzfhNHxmVzBjrKxATBAiWizfKtsoQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA0PR03MB5644.namprd03.prod.outlook.com (2603:10b6:806:b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 05:48:02 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:48:02 +0000
Message-ID: <02b858ec-05f6-4815-b9b0-e32d07b62e55@altera.com>
Date: Wed, 6 May 2026 13:47:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: Sune Brian <briansune@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
 <CAN7C2SArQZxDbm3EZ+mnup-EniyQ79-1Cv7n_19AxPpFr=SnGA@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SArQZxDbm3EZ+mnup-EniyQ79-1Cv7n_19AxPpFr=SnGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA0PR03MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: dae145e7-c0b0-423b-1c56-08deab330952
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XaVZjYzgIXlgCgUIXz/mijd5+Ob5tnHuWEdKFTxt/GMIWkr3s2YI1v99ifkMjo6jmnoB5+Ee85I1CUo39aHrJw1Rf+rVf7VxP/hZpanWGpatbmBaEXcdchECU1lMaRmhd4/jRk49nvxAKdI1yhc4o1GwXvQAv+oVtZ0QvX7C6N09ynrRsWArlqvGwzuPRP2MVDAX72ILjtu6xuATlVfbnVqpNZxeCqh3ki5rjygbduiI4QRUeP45W+f2daOccf6m4fUwDzu/KeVjaQeafqJBqJGFoA4m2DNSqeWGXswvgSM5dKRjrGrwQH/4XYLYBISemWG5dH3iZrLUX4uzJKFnGMncrj5lNBa9z3Rt67s+rWrsBht7Zk1+9T7lsq/WeM47kToX8HFXm0OuvH+tDN5lUYvN092Vsvf/6GGevA4yArcNJelrrr3FfxhaqeQe2V2vsHwKfbItpZIHmBSkWzeUGggc2gYMuQMV+PmT0SQ0tUqMFYj6WQsm+wJSx9E003dbXuW6iQhCY2O1qd0e5cnLg9DTpn8bfo94SvfhO+H+BSOaC8/2iEoVIUo3w76Ua4x1ZWFAP8QdoA9hMu+2mUsJqPger4o3k8+E9OyrceZ1cz+XhwOMTmDOyrWWoedrJmulKX1nskHvCGvxloPTPibJozhsYLmn8Nw4ZLYezII7zsF48Cc0qQneb4u32gjMYVTJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUdzRlVnRnJ6UDZxSXR4MkRvVlRSS3l2Vi9lbGtuRm1vYWozNmZwWUpSNXR5?=
 =?utf-8?B?YTh4WnEyb3k2M2xhMlpMOXc2MVUzY0lacERaVzVZdTVxU1lMWWZ0MURpTURH?=
 =?utf-8?B?WmNoWDJOYXNnZG9rWmhKNVo2d3dRc3paTldiN2RPTHFNZlFLZFhnREVWMWNl?=
 =?utf-8?B?MnFoMndhQ0JILzJkTEVUVjFpVVR3L1NORXpVUW13VW1pL2JManl4MFJGS1VE?=
 =?utf-8?B?MGVkL2ZBYitndi9QYXlnakFIOTlmdDgvT1kwdEtDaDhpenhUSkNqZVV5VHFt?=
 =?utf-8?B?cW03aHRxN05tZkp2bU5EbWh1cnZvMHF0SG9SaStHUjVpam5FK2UwY3FUUk1Y?=
 =?utf-8?B?bmZEWHE3VlA0WXBkcmlRNnk0NnVOYXdVL2lEV3VGbnJoaHFqN1N1WGFwbXFu?=
 =?utf-8?B?c3Y5VWtlQ09kNHNVMmtDMVFOTm5uVDlhTmZWbjFhRFBQMDlRU3U0c1BSOHly?=
 =?utf-8?B?N2twOVUwd0d6WGdNeTBmeUNDQ3ZHTTREZFplQm85MEZ1VkdLTnBlM1ZTVXNh?=
 =?utf-8?B?ZEw2dVhOUmxTczdOT0NkRmI1enhZbWZtOXYwS0lVdE9zNk1mOG55UnNVeE8x?=
 =?utf-8?B?UkN1bjNONkpzc1RJcXh6SGp5azR4K1BPTzNjcWJ2WXdjeUFWRDQ1TUdIVWVM?=
 =?utf-8?B?K2lHbm9wc1V6ekFubGdsOHQ4RW5sbUFwMUhqZG5IeTlGa01IRFg5bld5dko3?=
 =?utf-8?B?NzNwd3JEU1Q5K25nZGNzQlJkM25DOEd2M2M2aWtqTFN4dERpc3ZNNGRxcnlR?=
 =?utf-8?B?anR1S3hUU0hvLy9rcUFFSEdCNDArTEx2SW10M2U0SzdtSnRPMWJGM1dyRnZB?=
 =?utf-8?B?TDhQVSs4cGJDa3NzbFY5YU85Vm5vcHNBa2lPM1pIVFlwK1hMMGtBOUNaalZn?=
 =?utf-8?B?ZVdZelBnalY2bDlkZmplQUptSDRQam54MDNkNUQvZFEwTGFhNzYzaWxZa1Yz?=
 =?utf-8?B?d0xEbDBOT3FIOEhoNEdWa0dlQkdQTlZZL0MxZkRjMEhzMGlDSHhUbWYrM3lL?=
 =?utf-8?B?V0ZaVzJ3eVdRWFRMWkVGbVBrQ243dG5vemt6Z0JzUTdHMzBPVTN2SzVycU8x?=
 =?utf-8?B?d01FWTZtNHdnTXNHTXdoL3I0Tm1PNWtuNmVZcmNMRFA3TmFNbFd3c2IyUDJh?=
 =?utf-8?B?STBuelY1eURXbHJrTm4yQ0pBL1hBUUZoTHVxcXpGYXB1MUJFNllQRTBnTVBU?=
 =?utf-8?B?WkRFTEI1U2xYajBZdXUzaXRQSFg3TC9oRWVFU1h4REVCMHd6Yzl1Z2xyellj?=
 =?utf-8?B?L0haR0hra3hSOUFGOG5wdHNZdnZYdzBXLzBsUzJWQk9sVSt2dUNuK1BFVzlL?=
 =?utf-8?B?R1I5VjNUdjRTc3ljUVFQcGsxdkgycmU0NWlpSXVOQU9IN2pmSEZsK2VMTWVu?=
 =?utf-8?B?SXZKS2Q5d1BJaXNPRmp3VERlZnhaY3lGeGs5dEJHandNQzkvRWl3SmdzNnpV?=
 =?utf-8?B?bEY1b3pvZDhBTDNaVk5nSUFOTDJuZzFReUV3amhseHg5QlJ1ZHNCZGtmVDIx?=
 =?utf-8?B?VUlxYjJpVFBQbXJaVWlGc1pxalZlVG9McnA1UGJDM0x2aFg4NmN4OEYvVkxG?=
 =?utf-8?B?M1BTMkI0OVNlVlBHamtobnBSN1RuUVFlWXdieTdJVWh6Q2dFWG92QWVFZXU2?=
 =?utf-8?B?UnJhWnArMjNPS0syN2JBeWxNVWozZjZNU1AwOTBMOWVxY2VOR0p2aDc5QnQ2?=
 =?utf-8?B?ZWh5Sll6cS82VTVnVkRORGE3QXZuNWJSZVFsZmtuMTVWWStYMTV2Yy82Mm9I?=
 =?utf-8?B?UDJ0blNCOWxiREt6dVBPUVFZbGd0aWV0Z01uR3M0c2RPZHEzaERDeC9WTEpE?=
 =?utf-8?B?aFpEaXo5b1NPb2o4ZTY1M2VLT043R3NJSUpOMEwyNUdtaEY2dThJTkV4b1RL?=
 =?utf-8?B?bjU2MlhpV1ZLdG9wZzVzeXNkZWxzV0VFY1diZW1nKzB6czhGL2tsTE5GQmow?=
 =?utf-8?B?SmhtUkNWYS9TZ2VHbStxVkVid2pJSnFmOTB1NDYzUnpZRWViRmp3aGxKdkEr?=
 =?utf-8?B?eDBrc1BSS3Z6SUZLYUtsRjNyc1UwVWR6Vm5YclMxWEVKMkFkNnQySFBScjNO?=
 =?utf-8?B?QnlqSW8xa2pYUDdJTjJCY3pHMk90Yis4UXZOUUJrekxod3RoNExtNDJuRnNC?=
 =?utf-8?B?S3pwVlljWmJjSDBXWXhUOXluNzRGa1UvaVNRaUpIVUtDMDVUSlNpRHB2OTh1?=
 =?utf-8?B?UlRCcWhiVk54WUowMnRLZTVZTDJIaUZFVDN0WkJOaUlSNzdLQ0NCZTRHYmFt?=
 =?utf-8?B?TFZtcXhYTDdkVmYyb3dlWXdxbzFGTUNWYXYzaWcwNWliZWowQlF0MzNJSzdZ?=
 =?utf-8?B?N3JVNkdyOHNJOFJJOHFXbEJJOFRLemJodGdTcG5iVkR5MDZwTzlBM2tIMnB3?=
 =?utf-8?Q?OLehqO/vbkQlWWvzPUs9ZQR9hEv+KTvKGPWg/?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae145e7-c0b0-423b-1c56-08deab330952
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:48:02.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWgWFhcWdjddcIz4pyVuWoAerI1Tjn3ClFyAf450AjOVwzBykpLF597Mm/t5z6kjOs3LoLxwK1uWhIm3EDyip5FJDZG1LVrIWlLnyz7UM4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5644
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

Hi Brian,

On 5/5/2026 7:08 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Tue, May 5, 2026 at 2:54 PM Chee, Tien Fong
> <tien.fong.chee@altera.com> wrote:
>>
>> Hi Alif,
>>
>>
>> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>
>>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>>> case.
>>>
> 
> ...
> 
>> Why not remove this?
>>
> 
> Hi Alif,
> 
> Just few comments:
> 
> - If possible make it inline, extra file means extra time to compile etc.
> - To reduce the code size which I tested a bit, the text message is the easiest.
>    So possible reuse or cleanup text print if needed.
> - use "./scripts/checkpatch.pl" under the u-boot folder to clean things up.
> 
> Thanks,
> Brian

Thanks for the suggestions, I can try to play around with these options 
and see if I come across any meaningful breakthroughs for these Gen5 
variants in the future.

I'll double check the checkpatch results for the next v3 submission.

Regards,
Alif

