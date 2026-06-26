Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC71C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931078496E;
	Fri, 26 Jun 2026 20:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MuGlvsUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9488484975; Fri, 26 Jun 2026 20:07:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553D38460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf+sfjrtisY1aXqrji9/nJLviN58HADzrN3n58kjW6SfEHxBryhPzN8MLPNWPbIhATz1SweOKtNHTmHoOA20tWmV1qxwClATWOuFXqqMcseUX1Zn4wAWZXdZ0yVsDHsJNuDitg6fN+qODdqy/f9EPOMNdKUY0uJOEpLgbUueDZa38Q3i6bQTxJL4d9Y6mWSvMcQDYINWxe2ZI3bs4wurth5/p8kkwsAGnpIiS2A/qhK5nU718bnmV9TQ8jataDhrzJcwLUCxtm6CH4q5J0yITrmmRalbEsrzYe0A9zT7x6OhMqMqhlimysTmm7fQBiq1qDtPHei8/zM6WhDuFZFlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYdWBaYVefqSJy63GTaRZirXEHJaiPTnQIjLySuv0Ug=;
 b=Hc8BqZ/8lnG9ImH0H2h9a4MDl1sSx0PyCnGqu1TMckLyl67pshGYYxNIKdHxkwcpT+ieTaf3euAfmINHS0/jfzvZvKsxCEE/ZEIpUI9dhrrtWVmtLbmwYeBDEIyBnsag0kxX5+y5U6yHxWji3PYUSSW3AOeIJCDJB3fCnX930CVuSrDPmSpAH2SPbxpe7yYjClKygi8s2e7TZN8KEJKt7tVOHdtK+xUcyUirmZJ5SQ11NlxdLyDS+w/8RGQGGxkaSwHD2rJccjrw3vJ2Bn0wPqghKDGVgoaT31oMNI/aPjU1DcnwSRPpZ6Tj003uSW8h3LT3KTLpWefZq7/IzWJsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYdWBaYVefqSJy63GTaRZirXEHJaiPTnQIjLySuv0Ug=;
 b=MuGlvsUnqthROWzxrrZg8N+nT5NDKWQL533fmz1e2P7jEv9gGcxiB0/JODtG90t/P4fgWRYkn2IAvBWn7RxUNaqiICiM4bArmSo1mM2ZxnZw6jvx/zcGJjrTelKw3isRvQ07MhbBmzW/auK1iu0kT1NfjqHWwMOOtHMkvlkOusg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 18:07:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:07:17 +0000
Message-ID: <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
Date: Fri, 26 Jun 2026 20:07:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: U-Boot Concept Tree Proposal
To: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2bdb8e-0f1d-4b50-0a85-08ded3adc276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|3023799007|3613699012|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Kqq/KJjmN9eGpm26dHJEGkTqHctXEU0ZVFVJCbwWgDlL1rq94hq1Roy9jIcmA8rtLb09x1cACrHdOHDuSwvgPkT60G2qzhdfRlusXkd82kwWlAWJUvOkShJYeRqkMfzLDV2kv6RR5GJlMLby+ueY7yHBD2jWWurpTXKKGTAVTZr31UpzMZL3OL8nbvNzfqqnaSG3s2f1NR8uvwHIv4fqoP40HwpJvTnai1AtEqOy8RTI7lxEVzJK3bDoLmSbGk+mBtSY/jeaXV3aX61VsEujOYNcYZsDCVg92kwuhGesTlFrIVLv3UouHQMKmnnhPfyER/C9SqxZj3NX8d2V3iiBaPY/l2DvxazDsdxtmmqCI9oeEsKqomwj2icGvkvsh6he92pEkO83JwUKSvRQmCJ4QDnZ03+HkHiq9vEQ8qwQFRVT89FTz5bs2r38TREXze4ixMzy1OXjE8/iW8/Hf3YRsiMbhHW+7aJHWLYDzbBhnePT1sF/Wkb0Zrmkyeyr5wLzDmdWq+bzF/jH8zeWQOXvzrYn7tBB1QcU9jnSRukebqSarxMMPfeO8j8uj6Ste7P7FtH5OogibnReqtuKnOdilFjxqKmAKtiPRazsi8MSMH5dSEK96VgZ1f5fnu8cgDtJYstyVee7F/2INackOV6yFfFINIdTFpTl0cvJ1vyjL5A2cBCgkg5gGVEhrpcVgu4Az+UjCq7PJSQDRsSWcBs1pVvFMez5W+9a9EbgZRM6sbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(3613699012)(11063799006)(5023799004)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lGOURiQ3JHbk82OHE0Wi9IMkIwT21SSnViYVp6dXRpSzNSc3VMS2RicUhG?=
 =?utf-8?B?Rlh4UjVJY1A0eFF0NGwxTlkxUklMUm8yNm0ycEo3eUIweFlHUnFNWGRKZDFr?=
 =?utf-8?B?dDRBTGNtTEJ2R2pFc2dkbllDcHlkVjZaZjVZemFNamN0U3JWK0V0MzRQdHc1?=
 =?utf-8?B?TXl6dVlhL3dSYlUrSW9pSjZaeDdNWnNNaUZaaERBZmRLalJmcHk3NG9FTmZl?=
 =?utf-8?B?Ym40QjFoSkltMEhnTHVRWWxTOGNhdmV1UU5VR3N2RFNaSE5aeHh3ekc3dk44?=
 =?utf-8?B?dG9oL0l2Y2RsclNVMGVXVWRKTlZWbTRCU1FRWGxqTUJoWnN4eFo3eUFBVVZz?=
 =?utf-8?B?VEpUYXhTVzRjeTNVZ0NCU2RlRWZCT1d2RS9XNDhEZVhVa2lHUnVsT3JKZ3dL?=
 =?utf-8?B?bTJCbEtGMEdRSWlkTDhCMlhvTWlMVDduVWhhY2RKWnR5Qyt5NlhjZ0I0Y2la?=
 =?utf-8?B?bzVxK0g2Tll3YmRUbkxIT2FnaHNQRDlUa1MwaHlLZVJ4RjQ0VTZvVVBGOEZv?=
 =?utf-8?B?QXJ3Mkk0SnFSL1A0dTVjdU9PRmlBcFZ1SEdNWGlWSWkwV29EMUM4MjUxeGtl?=
 =?utf-8?B?UWl4Mkp4ajB2WjFjL0ljZmkxakwzbnUybGZtTksxRTVQS3BHZVVja2pNdXdt?=
 =?utf-8?B?eFRZR2Fxc3QwOWRNRTNlSU4wMXlpS096bjVWSTByeWpTWUZzK2h4YUxUcWVG?=
 =?utf-8?B?aDBQaTRvdWN5eVR0anJ4bTI1UDVtSVdIVWdwdHdEMnhkOUFvRDJWNnJpaGp2?=
 =?utf-8?B?Z3k1US9qcUVZUjlxUFhNN1NNYXJLUmlDNmxQRU5IWmQwTUI3enBCdEFQUjdM?=
 =?utf-8?B?dzVOVU5GZTBvWHFvQW1SK2tYOFkvaGFZVDVVOGdyTWRZblVZNTg0OVdaYldT?=
 =?utf-8?B?NlJrZkRFbXQrVWlkYm1UQkdBY3RaakU0SFhyZDkvdTgwZUpiNUxyRlJkdlBZ?=
 =?utf-8?B?SUxMM3JvcTJXRzRNZDVPSTJqRU9qUjI4RUw4Q1VoY3F3TXcxZzV6NGVWcUFk?=
 =?utf-8?B?RGRkY2VEcVcrdEJ2QlgwTm5QUCtEUUxKNWxreFZBa1RxME9ZQkgxVWoySW8y?=
 =?utf-8?B?ME50aWxBUkJMRnpMMFlhc1FGLzl0eW41RmNxMGo1d1lZTzRzTEh3Tmk2aks5?=
 =?utf-8?B?OUhDUXpoUlBEZDVoQWZIWmNwNTBSeUdlYmoyMjNmaVB5VkJHRUtzWW1PZitR?=
 =?utf-8?B?M3VkN3JmWUJmb1RnZlpVb01rQWROazE0bkpsY2VTMytRb0dSMnNZT2l6TjNv?=
 =?utf-8?B?c3NhV2VTU0svVDFtQzdSY1V3bGtyc1k2c1JzMkxabVVwRFM2eXM2ZmFoRXJD?=
 =?utf-8?B?NWRUQjVBTDZXa1NiMlJ3RE5ZUXNXSUx4NGNpOEllTTBJL3loeXBGVFIyZ1hs?=
 =?utf-8?B?UnBMTk5UYk1oUjBiN29mV1NYenFvWG42eTBBdEdicnBCcjRIMzdCTVptVHBr?=
 =?utf-8?B?a2RaUnA1bURTVFFTSzJHQ1JuSFpsTzJ6MTdMYjRNQVQ3WUNTUWhWMVJTaUpW?=
 =?utf-8?B?Yk9qYzNtWFZGanQ1UnlmWmVPbTJtV2VFemt5WStjdytGbnZDMHNpbDUzcWJk?=
 =?utf-8?B?SVRGdWMwK1lVdXB2UGJ0NXcxY25ldHpEdDRBdkcvenUzdU52NDhGUXo2VWx6?=
 =?utf-8?B?RDRDTnVQVkoybUlCbmtuR2QrSEoxVytMY1pFbmh5MDBIemhsSTQrNm5jUmFa?=
 =?utf-8?B?YjFoaUt3VVpZYWJ2VlAyV0p0Qkd5S1J0ZW5oeTVIcDNFVnh1QVN3dEo2cnNl?=
 =?utf-8?B?NUVqTStBU2dXU2ttb2tzYVBZbk9VL1JMd3hmNUN4UFgzU3hadkV6dkNLZHMr?=
 =?utf-8?B?dFY2dmMydHBNTnZ2VXh5cTI4NEJyWlhDZS9LcExiZVdPcmN5NWZyMTdlNjgw?=
 =?utf-8?B?Vi8zUEJFb3JUbzVSelJhQ09zY1BVeS9PUkUwS0hXcjRPb3M0SUMvdVFTWjBZ?=
 =?utf-8?B?ZEtXTUJkaGhtUVdZSndsZE94d05PZzR4czBtb2kxeWpIeVB1RFZCQ2lhU2Fn?=
 =?utf-8?B?L0g2MUc4bzh6THRucFhIQU5RcHhURFVvNU9DS3lKZU5aK0lEMkd0SFlOT0l6?=
 =?utf-8?B?bVExZGduck9pREZkMFBoYld4T0tyYTY3SWZqUDhKMzRBN1QreWdxa2VKRzV3?=
 =?utf-8?B?QThoRy9WNW05NURaZlY3NXQra2tHTlpVQ3VYT1cxSHU2bUhaazg1cFBJL1dv?=
 =?utf-8?B?b2RGd2F2TzdtZ3gxVEkvQmdUWEtERHAzVndiSHFmQ05XY3EzV1h3QXZyUE1D?=
 =?utf-8?B?Wnk1aTkva2pBOVhIY215UTVmRVg0ZStrMXFvY2p1VEdTdzhubTIrK2JZWm1F?=
 =?utf-8?B?bFdOdW5VZG1CdUh0V05ONHVIcXhTdVBUSDRNNUkxZDNBWWowRnBWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2bdb8e-0f1d-4b50-0a85-08ded3adc276
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:07:17.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WWwZ9fKMskKvfOLZ86woeDjnuMgu8MIk1MzbMAKqGdG+mvwWivwAEOOLrZZvGYjIdECvKjFWnERb7ki7RlrGQ5wWPicSh6oZ/zF7n41dVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004
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

Hi Simon,

On 6/18/26 5:06 PM, Simon Glass wrote:
[...]
>>>>> Another difference is AI. I believe that AI is the next step on from
>>>>> compilers, which also took a long time to produce good code and find
>>>>> acceptance. The Concept tree welcomes (and encourages) high-quality AI
>>>>> contributions and reviews. It accepts PRs and allows reviews on PRs or the
>>>>> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
>>>>> sets a high bar for testing. It uses a separate Gitlab instance for now and
>>>>> of course uses a separate mailing list and Patchwork project to avoid
>>>>> cluttering the main list. Concept runs an AI-powered cherry-picker so that
>>>>> it keeps up with mainline. In no sense is it operated as a fork.
>>>>
>>>> I'm clearly against using AI for any of development or review work as it
>>>> can't be fully trusted and will monopolize precious reviewers time reviewing
>>>> AI code instead of reviewing legitimate contributions from individual and companies.
>>>>
>>>> Using AI for CI testing and regression testing could help if it doesn't add
>>>> a burden for maintainers by reporting false positives.
>>>
>>> RIght, Tom has been very clear about this too, even suggesting that AI
>>> is actually unethical. This is indeed one of my motivations for the
>>> Concept tree.
>>
>> To avoid the scrutiny of using AI? If that's the case and you're
>> intention I have further concerns.
> 
> Not really the scrutiny...the more scrutiny the better, I think. But
> if mainline is anti-AI then Concept can provide a place where people
> can make use of it.
> 

Tom has clearly communicated multiple times that AI is generally not 
welcome in U-Boot. So how is accepting AI contributions into Concept 
compatible with "Once features are landed and functional in Concept I 
hope that many will find their way to mainline"? Who's going to do the 
work? Who's going to take the legal liability of reworking AI-written 
code for submission to mainline? How is this going to address the main 
issue you're having of "code is not landing"? It's still not in mainline.

What I think will happen is "I cannot get this merged into mainline so 
I'm going to get it merged into Concept and then direct my users at 
that". And eventually, over time, everything from this Concept 
contributor and their users will only land in Concept and we won't even 
have it on mainline ML.

You keep repeating Concept is not a fork, but I don't understand how it 
can NOT be one.

Considering Concept is apparently going to be hosted on the same GitLab 
instance as mainline, I see this as potentially confusing people as to 
what it actually is. I still am pretty upset at the various articles you 
or AI in your behalf posted on the u-boot.org website claiming support 
for various features in U-Boot either "submitted" (nowhere to be seen on 
the ML) or not explicitly stating they are merged in a fork of U-Boot 
(Concept, that is). That with the fact our official documentation used 
to be on docs.u-boot.org really made it look like (to me) we were behind 
this effort. We made the mistake of hosting the docs on a domain name we 
didn't (still don't?) control, I would like to avoid repeating the same 
mistake a different way by hosting a fork on the same instance as mainline.

U-Boot has friction also because we don't have enough reviewers or 
maintainers compared to the number of contributors. I don't see how you 
plan on addressing that by maintaining Concept by yourself (with an AI 
I'm assuming).
I appreciate you're possibly one of the most if not the most active 
reviewer on the ML and that there's not much more you can do to improve 
the situation aside from recruiting more people to review.

I also see "It relies 99% on automated tests (sandbox, QEMU and labs) so 
sets a high bar for testing." as wishful thinking. I'm sure you've read 
like most of us that it's not unusual for LLMs to write useless tests or 
tests that don't do anything, or even remove existing tests that don't 
pass because the instructions was all tests need to pass. We also 
already have tests and yet we still have plenty of bugs that weren't caught.

I'll finish that my gut feeling (shared with some of my current and 
former colleagues) is that U-Boot is disappointingly unstable. Unlike 
the Linux kernel, U-Boot suffers from fewer eyes looking at code, fewer 
people developing it, fewer people testing master or even any recent 
release (the number of reports we have for bugs on releases from years 
ago...), and lack of proper and extensive CI test infrastructure (and if 
we have some, it's heavily centralized into a handful of people's 
offices). I loathe every time I need to update U-Boot because I don't 
know what I'll have to debug for days or if I really do test everything 
there's to test (is it my fault for not keeping up with master, yes, but 
I shouldn't feel this way).
So I really think we could have much more confidence in code being 
merged if we had more testing, possibly on real hardware, possibly by 
companies offering to do some proper CI (e.g. like Intel is doing with 
Yocto, spending days testing release candidates before the project tags 
a release). Maybe with distros slowly adopting Aarch64 and U-Boot with 
it we'll have more coverage. I know you've worked on labgrid support for 
U-Boot and you have some merge request(s) still open there but it seems 
you're hitting the same wall there you're hitting here.

I think one of the issues could also be because you landed so many big 
features and reworks in the past, you're likely the only one who knows 
how things work in many parts of the project. binman comes to mind, 
bootflow/bootmeth, (signed) FIT, etc... Getting people to review your 
code is then difficult because it requires an enormous amount of effort 
to get into it and most people don't have that amount of time available 
to them (or willingness to spend it in that).

I believe we should be focusing on getting more reviewers, on many 
different parts of the code, and more automated testing, on real 
hardware. I believe that once we have this, then we will naturally have 
less time between submission and merge, and eventually can land bigger 
reworks or new features.

Cheers,
Quentin
