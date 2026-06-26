Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC75C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7085584704;
	Fri, 26 Jun 2026 17:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i3JW9Iq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D438495B; Fri, 26 Jun 2026 17:46:38 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DE28404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt6CXpZkp7s6y7gzDvFCbRnmYQD7PxPnLzif69L9rXObYPCuraADHW+Zzy7GFySEDYcD8D+2Yq6oSXVld2PM7X1qKZwEyqpaB3QNWGRu0W8iQSWiXKW6HPTBeY5ob2isl9WuypjnXZGys6MuZ8kCDXai/1MrbYKWstzJu4ooQ/c0HKGBdQT6DE++DhCFt+GtuBFoJiPjjz01s/uttxXDVo1dDj/ZPe7nZkBhyVjfLasYvadsEMLSTXRzLgV4Zc6/EhQCyIMfIh6r303ZN/JmQ6JfKuOKuPwvy2t2UO0YUkEXxmSpx1vCt58U2zDZHjfwEIrTEHzOTYevr6Rpl2VjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htZ/VeOk/IOdEk6obXfmpIcTxehg920S+WjY6XK4JsA=;
 b=E1H6WjtGDI4+OxAx17bd3uYlICx/R31BNKp8dNEZdGiMrTs95OaMeLfyKtmltMuWof/1YUCDDLi0cIolYdcclG3YS1bDhejCCXK4iDfAxU305LIcVD+BAodBSqeV1GikzSNc2BF6Xz9ke8j5jdOQJ9DrggBqMXfHqgcYZ+DaR2xbwx16xx1pqjRaCxTcyEJ49djnpV3SDhwKcI9yUIJtKTdi7kP8vBx79ovvlt0BdQTZrtuN7aSdsNY0OWbimPSgL6ATljYZDD3Osk2Kcuv5ipM9l/GG1M/N3vFXx9fTZs+08EwxWzpT0IyMq7p6ulzk1VH5UN5myrHIqCeYr957/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htZ/VeOk/IOdEk6obXfmpIcTxehg920S+WjY6XK4JsA=;
 b=i3JW9Iq/iXVPCLmNzkhaVml8HPz7jpzaUA9x3b0/FcfGdTY2ygO37OPZNFLzPkcsg/YX7uAYkv7H7YFivO93Fh/MnKrimO9ZZdGpjq9gThazZLVZjeIA8RTkVdFQN7hqlhejYiIee1/wiSCXpM8xwYT7Bb4wi9ITUw1yv7FAsbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DUZPR04MB9869.eurprd04.prod.outlook.com (2603:10a6:10:4ad::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 26 Jun
 2026 15:46:30 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:46:30 +0000
Message-ID: <eacd2ffa-a1bd-484b-bf4e-af14fa6c7aba@cherry.de>
Date: Fri, 26 Jun 2026 17:46:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de> <ag-EpjuQlre9QmYN@daedalus>
 <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
 <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
 <eca33072-97bf-49fc-890a-a51b7fdc4d62@cherry.de>
 <CALE0LRvobvMnm=P4qqcNjzWPhRjtYLO4sbHP4UHOKLTdUoaryA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALE0LRvobvMnm=P4qqcNjzWPhRjtYLO4sbHP4UHOKLTdUoaryA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2PEPF000008A6.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64b) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DUZPR04MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: d3baadb3-be2c-4045-d422-08ded39a171c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|22082099003|18002099003|4143699003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: xIYsIxkZMEkqtSBFTphkqu7xVGkSWincAwar6XBSKroL2+5Z+mWtZ0oibqAzfkVhd1go9gFbZG/BbmVgOiPs6oHVVXgUAO0lCUKXNElDLn6SEChQsogPx54I2pYqIOuUewTOB9kIstr+mbkPyEbVvd6alC4FRSJI38YE5BtnUlfd1K7bD8iZmCnnDSTxoHtKt4XU23GKvWW12zUX6p+8XxsOrGe4/Z3wUkWvmBpPrOpmf5/c+Hjhcu/5sDB4VM3QJOCAehLk3Fkik2YNq7+z+H+Tiu2m26LLAEwzteSRrM9oTVEL/MDbsTRVuA0HmoyI5sQxJa3DeVpeb56JRD+6ysvXKVHK+HytcxCImPyn86M+VzRUKvkOO5DDdiah1wjCudbKTrZaRNpjZr/ifcKOzj7a9y+3YvTou57kbpAFI0qmLMdx7byWL6W2a96sdHXm6/v5Cj2iz026adZ/mtzqm5je0SKNGcuesUjhA32vGxD5sROBD2hmg7aKp+NeSdofAz0/aEn/6uHm6y0/UJK9kiSPCXK/MqiRNGO06glzQCu/XE98I04D3kZ8P1sNoFMVFN7W3p4esdrD9kDhpAOiixBwkGBKr1cOAuc6XNw/eJejK9OJVX4zCfVykht0nW0/DECTapyy2CBGllNwCWYpRQyoKwPiZJMmtEpAb+IMf6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtteE1NbEswMUVkOVRuK2FzOVpFQ0lVREVzM013eUlpTCtKOXFMVzhvRy9I?=
 =?utf-8?B?cXZacHhJbWQvcy9sUkZSMGNpRklLME4yNzhEK3Y1Y25lekYvSVR4RWJqVlF6?=
 =?utf-8?B?UFFKU1kvd1Vsb0s3MncvZWpNWS9oSEx5a0grbSt2OURkUGJJWjFYR3dzOHpF?=
 =?utf-8?B?bWhqb1l4bk5MbjR5R2RLM2hJRWgyUERZcjB0WlUwR1dEcFI3T0I1NnBMVHpU?=
 =?utf-8?B?ZnpiZGlxRmZTZjZRY1lGcUQ5ZkozWHF5dGdNWkoxTmwwVEc3QkRzS1pmc2pm?=
 =?utf-8?B?RDBKSTNXNlZOWFF4MHQxWFZnUkthZkZEbDFjbjQ1WGpoOEpTR1FhU0hDYTBu?=
 =?utf-8?B?SGpORlVPN2RKb1NIUmlFWWJPdXBBN3FjUDd1cEdiMDM3ajJlYmhNNXBQdUtD?=
 =?utf-8?B?THhVQ1MrdEZjbGFFc01sNHE5T3hCVDNEVEtDbWVXMEplQStWZTVUUnpaaUlS?=
 =?utf-8?B?M2IzN0IrUysrVXphUitMMWZZakFjYzY1TlIrZUVIb29hZ2I0NE00V3Vua3Ey?=
 =?utf-8?B?REk4L1NjbmZjbkhpZ1dDNnhkU28wNGJZQ3UzOXFNMnFLbDM3MlhGSlRJa1o3?=
 =?utf-8?B?VmNkeEgwbCtTS2w3ejFTRlVVTFAwWkc0eE8rbHI1S21IaGxaSjA4KzFnZVNv?=
 =?utf-8?B?QjJOckZ5YlM5YXR6QmxnOG1lTnM5YmkvZVI1eG5iTTJmaXhHdDFzeWNpbmdl?=
 =?utf-8?B?dmxnM3lBblhHYWFycks0bDZodmU3WlVRWWxyQzNFbnliUVRCVTJRMi9NbDB6?=
 =?utf-8?B?YnJhajEvNE5wbTZRejZjamtySjdiNWZDUzI3RXBML2FmOWFURWRsU1dvZWpp?=
 =?utf-8?B?NjEwanUyNDYvekZ1V0lLME0zK3RCbHByWThqRndENmdDMmU1UFZYZU1KVmZj?=
 =?utf-8?B?cDRLKzk1TnBEYUZzVktOTmxyZldmZ3FEQm9LSEJqUDIxOGt3VEFNZzM4ZFcv?=
 =?utf-8?B?TkF6dFY3aEhaQXU4MDZzL2Iyb1l6NjNENjJFaTVjREVGUm5kL2pNbDhsZ2p1?=
 =?utf-8?B?Tks0a3ZQcWpvamkySEY1U0JZdjVIMzA3cUwyMXIyUUFDR3g1ek5seDZmYXJM?=
 =?utf-8?B?V1F1WjdyRFlwaE9CWDVFZ2RmTGZyeE93QitUSHNxb09vbW8xUVRyR3lGeWdJ?=
 =?utf-8?B?MFk3NitHd3dmcXVzbGErV2JkV2t3aU5DZ3NhZFFFM1QzOXF2UkZtazBlTHFu?=
 =?utf-8?B?WnNMRVIzUXdTQW4ySHFnRnJvWlQrMXFkcy9JZytTbkdaRnVXSTJJOGxCdkc1?=
 =?utf-8?B?S0ZlY3ZmWk0xZmJ3NUdwNlUzWHJZYXNhbXVpaFFNVFFZQTZBWWV1WWJ5YWJS?=
 =?utf-8?B?eU5GQzh5NHZ5NlVKMGVhQ3RWOVF5SjBvMDdqU0p0Q0tBeklSL0psMElVSnBz?=
 =?utf-8?B?TlVleE9MVXNsSDdKOWdoRHpSWkNEZmJrNFhOKzdDQS9wenJCZlE1eERtdXJU?=
 =?utf-8?B?Yi9ZTEdMZytuMWxvZ2x1WDV0Z0MwS3krekN0MEl6VGtDVjQzYTQ3SW1zOVhh?=
 =?utf-8?B?MkJmYnNMKy96aEMySHNERTkvQUhOV25kb3ZUTjZVbEJTZExxTTZsSkxud0FT?=
 =?utf-8?B?MlZWTWgvRnR2YklRN3IzVERNN3Fmd0dHSXNoemYwNUpKenpMS0NtMUE1M05C?=
 =?utf-8?B?T29IUjFMUUVZM0FvZVhMY2VSZFZ0R25Dam1qY1F3RjB4dTlYVmcrQ1FQQVVw?=
 =?utf-8?B?MVJjZVBBd1QvcFVmODBzYTJOSXBlZmF1SkorVG45MnlaajU3N3haWVJla1Rl?=
 =?utf-8?B?RS9nL1pYMVBTRGtNVkRQN1FmRlJtanJUZWlmZnhVQzJSWTRYNSsvQmM0QXFo?=
 =?utf-8?B?QnVHWHAvWW53cmlrZk9xVmg4blN5Yk5weWtQVmJiUXF0N1pHbERGZUwrUWpB?=
 =?utf-8?B?cWxpVFhxT3FxbW9DRXlidmhCK0E4aCtLMEhwSlN2Y1pKMHB1YUVNSDI5NVM1?=
 =?utf-8?B?TkN2KzgydzRkbU9GQW9HbWZYemJRdVBKY2ZjT1VXTjJCWmZjejZkWWFDdk45?=
 =?utf-8?B?RUtZSG5RLytDQTFISG9Sd3RTUDJRSmMwSVBZaUpHQk05Y2xvK0liNEZVQnpB?=
 =?utf-8?B?L0hINUI0R1VMdGk0aW9yelVGQmxIK0NFWHBFTGxrN3RRekwyK0ZzOHhjZmdj?=
 =?utf-8?B?Z1RZNnJmYVRUUUJvR0hrcHgzZVNYaGxmU0ZicFptOG5rMCtyZUpJRVZQTnY3?=
 =?utf-8?B?WVoxeFIwOSs5dkR2Y2Jpb1kwTkkwMGZwK1VKdkU2R0t3OHUybmpVbkdRVTRt?=
 =?utf-8?B?NnhsOERPVTIrSENFZFpuQjl1aXBmU2hXZUpqS1EvWEpBZS9CUW9tbGFMQVVz?=
 =?utf-8?B?ZFo5RzZZUEwrVEQ4Z3NxY3UrK0ZoUFZiSERtR1RNKzRhV0VlOXR4QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d3baadb3-be2c-4045-d422-08ded39a171c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:46:30.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gyz6/xk8Wnimv410R3m63KOZbhQP4AeW9W4Golk8gsnev0RrVtvv7FZIHbyrvq6LJN3CkQjkAdv732QNqHtLd3MBpPiyizuglLszcEYYQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9869
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

Hi Enric, Eddie,

On 6/17/26 10:19 AM, Enric Balletbo i Serra wrote:
> Hi Quentin,
> 
> On Tue, Jun 16, 2026 at 6:43 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Enric,
>>
>> Thanks for chiming in.
>>
>> On 6/4/26 8:22 AM, Enric Balletbo i Serra wrote:
>>> Hi Quentin and Eddie,
>>>
>>> On Fri, May 22, 2026 at 4:38 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Eddie,
>>>>
>>>> On 5/22/26 12:29 AM, Eddie Kovsky wrote:
>>>>> On 05/12/26, Quentin Schulz wrote:
>>>>>> Hi Eddie,
>>>>>>
>>>>>> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
[...]
>>> Does it makes sense?
>>>
>>
>> Somewhat. I still don't understand the obsession with the Provider API
>> when the issue (as I understand it) is "I cannot compile OpenSSL engine
>> support and I don't need it".
>>
> 
> To clarify the "obsession" point, which I think is an unfortunate
> take, my impression was that this wasn't just about throwing a quick,
> blind hack at a Fedora compiler error. The build failure was simply
> the trigger.
> 

I think "no engine support anymore, so providers must be supported" was 
a shortcut many could have taken. I understand (and really appreciate) 
the intent of trying to improve the situation instead of "just" patching 
a build failure and be done with it (after all, I myself just installed 
openssl-devel-engine when I got the build error instead of putting in 
the work Eddie did).

> Eddie put significant effort into researching the modern OpenSSL 3.x
> API, studying how to phase out legacy, deprecated components, looking
> at the U-Boot's testing infrastructure, and trying to proactively
> modernize U-Boot's backend based on established upstream kernel
> patterns.
> 
> I agree, now, and this is the beauty of discussions, that the kernel
> approach is not enough due to its narrow scope. U-Boot’s edge cases
> make a full API migration heavier than expected. However, trying to
> actively clean up technical debt is a valuable goal, and
> characterizing it as a mere obsession with a build error can be quite
> discouraging for new contributors putting in real work to improve the
> codebase.
> 

I do realize that "obsession" was too strong of a word and I apologize 
to Eddie and you. I appreciate the feedback and will try to do better.

Cheers,
Quentin
