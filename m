Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57AC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEAF846FD;
	Mon,  6 Jul 2026 18:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DYAwdlZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBF784852; Mon,  6 Jul 2026 18:29:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E96D846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4mpib5WltxYN88c1VpdF/wGnjKVQoz5Cb+chg1KLJwZbFtJVMfnoiXrIRObIaDsxYXuNbouVbUo7Y0ILqveiiaNmB3aepcAVMMhW/xxkggdd4DJtxw0llTsDbqSNwjv7fedBaNPJzJV10Px1ID3grgPYczXA6mDQLOeGS0p8Oe7FwWjUl4/nhHHCqxFM8J0hHhLEEDbO6EXA7aa2nzYAuvDaPKsLksrsZNlf3NQuu111QrM6QEpgADZElDz9S/LckOtbk608l92k6lvtQQtQ+L+y2oP1y2s7TT+/E5aQyfNZQvHwwY/x/C1JYotjvpRPwhIKYv1q6mJM83pNWHlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnL7fwIWDTuf0h/MNunudA7AO89Yh0O6yVIp2RazSTY=;
 b=v5DBEoWyic8WKZkpA2ScrayvTx2wwHa2Wk1u1HGCshSPXvArKbUrkFGt9PsIPqeAkoabSOPavqxAZemDo4vwR1dbGe97GXjvNyQWPY2CP5zDblVQSwpDW+aOa1D4eg3BWhAZHbyDDElh05CwGlPnOtaM2YpZCgyTKYwXc9xVa4CtMYXT7jOftQ3GnxKEwXTK6sT2oGegh25zjz/We114hrcyqc2Fnb2sOALx4xxLtMipOmBRkT+6hOYgum8jqQRilhGCMq+YEAHhwo8xWX7ewpGOFVtmFaYlpgcVow/5flcdLy3WkWxBLGxv9uz/PxV9aSdk7JgG/cX7ZTfkkxHnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnL7fwIWDTuf0h/MNunudA7AO89Yh0O6yVIp2RazSTY=;
 b=DYAwdlZOws2Zlc843kZgsQXWWeKQSVBQ3+9Pmwk/2F6pBOwCfoHu2iJD7Q+Tb2vdqyFkxYnc+0HwYYlhnCUbWXvVCdkjD5whgSUkL2k16+7iGwelUuvHnPsddfwMszS0g7ebwSc3Ha0bomVk/PkzcH0H08C00sjCOrtNJKZxx9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 16:29:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 16:29:21 +0000
Message-ID: <55e94a52-c953-45b5-b28c-6d258f357947@cherry.de>
Date: Mon, 6 Jul 2026 18:29:20 +0200
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
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
 <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
 <CALeDE9OWeMs3peX8+4+i6iTmZn-EO2e+7s7q6S1yFaRUa0dksQ@mail.gmail.com>
 <CAFLszTg24RTHi0A0vWfv62FfZhm1Uz4iw=4m7NZ6_4W3R3kwyQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTg24RTHi0A0vWfv62FfZhm1Uz4iw=4m7NZ6_4W3R3kwyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF000008A5.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64a) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: f321ed18-952d-4638-4bb4-08dedb7bbbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|3613699012|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Gv2pHgD10+Y/7euQhdYcggYuiJsPFO8Tx7/KmvGMYfsXgqRd2SLdw5odT9jZojD3xirxm18ijz4IoGhGSVsDOpEIgKJzZuYfYNpLaTxIpVKN7/A2GfsiB9tRcLQPL9nF1+ZxxHZlFXXnsfiB8DIEqzUfvAi6U/5vUYYtW5G23tsEIDBiu1sp/XwJLyIg9Qc0SfLexhUnfzP0rO5TpmXMfnWpHXY7dHkJIwlUkk68D0NUlt47ZtPNEWcasxbTBpq93PiBbAWdGGFpkH0swnjk7nulGcN7c7qkuKzZD+XTg29yEDzEtK2+dx5Of+36NqSkZ+rJ04Lx5l1aYIUShsV2Xc0+in5TcZlJSQXO3MGuys0i+dKWOCXk8G/cwPkfEGn6QiUjhqwG8zrw7mqZ4W7bP5Ai8g73AXPOjDXRrPKJKNpzTj+hPwRRajCihbPceMwiuUKhPfOuQAzYdmcMmDR22DybsWgwiv8Vz3pVkmO61VyzfcK/wWEXRvp7gqUn8exVgyQj51VZe0j/YHMzoHmfBBGEdjxWTITCwGSNbH+9QoIotKfTjsCkuOBRsb2kr8zbLQ9ld5HeJ+8nvgRjQiU6z8QrW4UYS+BnS9cWam8ooL3ok2e9cfrYKYrJaaVY0EWu4yBYMvG6ZeBufUfouQMNoTsnbCTfBUQFKIDUim6I0wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3613699012)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUVzNXNvQ0pFTm92Nmh4ZTVMcGF4RnA4aUJndHpPelRPcDh2K3FheVNJamJk?=
 =?utf-8?B?VWk0ZzdBRTV3WTNJbjIxaG9RZTdvYXVxSmVIRnhmdTE2clJjRFdFeWl3V1Jj?=
 =?utf-8?B?VFgrV0YxZ3M2SUlBd3hHUXhwSGxKQ1Q4WWRWL21OOTc3SGUybnQxRW9jNzRL?=
 =?utf-8?B?bXpsNjc2NmdnNGplMW1EUUVPREdGVkttNm1wR2NXeEVnNU9kRDExZlZUTUpz?=
 =?utf-8?B?SGQrZHIwR0h6dzgzOW9ORk5LSWIwdU41c05vanZ4djlqRm16MDUzYi9BVWFQ?=
 =?utf-8?B?QS81ZVBhSlMwc3IxOFRicURtMjRjeGxuSnVDRFkzNlpuQWU5UVRPTnh3allW?=
 =?utf-8?B?ZEtkbjV0aEF6VjdFUXhOR2VNbUx6MXpyT3lkSVNHRXhiQXdYc09RS0QyUGJ6?=
 =?utf-8?B?UCs1KzJnd3R0OWw5R210R0VFVkY3eU1oQnVubzR3bUhDRHdmZmJxd2h6bTE4?=
 =?utf-8?B?MG9rUzhRQmc4TTZsbXpILy9rU0FxbnlybU9RUEFuK09EdTFyU1lWQ3ZFLzFU?=
 =?utf-8?B?UUVkaWJWVmNRRHk1YzFRdXVkNGM3NGMvTUNBeXlmQmE1YjFvdXJ5MWxHQUVP?=
 =?utf-8?B?M2dPR21KUFZKNGphMVppeE9uak1vMTkzMWJiYjVpTkdDZGlzNFdVamxZNld5?=
 =?utf-8?B?OG9MTFE3ZGpKTitqMHBoT0RTdWEyUndYUTNaTmhVRlU2TmtPMzB4Vi9Ob1hI?=
 =?utf-8?B?R0txeFBYNThvYUVUWTUxc1hJaml5eWFtZ2Q3a2xzU3crNFdjaThUcUZSa2Iz?=
 =?utf-8?B?S0RQaGJybTY1SzJyTjZERi9NMzRTMHNVa3RacTZDUkpCZ0RoYmJFc2d5M3Nk?=
 =?utf-8?B?aDRwVytpbWp6dXZXblhDbDdLSFFCbjk1ZnhYQlppYVoyUWJoZFlLQXJ1ajlm?=
 =?utf-8?B?L2d2djJHU3JITkdNbVVqS2JQWDZMZC9SSWFGNktod1g2Z1RmRUs0Tjg4bFpt?=
 =?utf-8?B?SWhpOXdVbkxBdFBPdkVWemp3WUpmUE1CNTRIWmNBbVFjUTVVU0ZibmVNQTJp?=
 =?utf-8?B?b0FDcUtJUmk5RWZUaHl0TmN4c0liY0cwYzQxM2VpSTVzTi9aaW51MXhyVmRm?=
 =?utf-8?B?ZjB6SG9mN1BnTzlZODV5d0c0cEFHUzVMQkk5VEFBcmIvYk5QM2o4K1JqM1RK?=
 =?utf-8?B?NWxwbmQza0Nham56WVcrNENWTkdHM0ZOSXo2VUc1OUJOUHBuL0duZjgyTjlv?=
 =?utf-8?B?NWRtTzh1S0s4WEdIT08rWU1sTnlGc1JDNHVCbW5rNEROM0ZtNGVvaW9HMmFJ?=
 =?utf-8?B?ODJySTJQMUhsWHV1SlFHWDQ1T1RvMWU0aTZMOHJOL3paV2VKVDN0ZTV2WGdN?=
 =?utf-8?B?b0dMeVBtbVcvNTIrZXg0WVczSE44UjdlSjdCK04vZW1yci8vNUxEdHRRYmxZ?=
 =?utf-8?B?N1BWUENzMU9QTEs2dmRFVS9UTjZBZDJZc011eDVHN0FzdUpKSlpHaW1IR1lx?=
 =?utf-8?B?cGtOdjduR012RmVZODdxMUV5dHBjK0kycndMS1VKRGoyWGFHRUVaMUdmWnlO?=
 =?utf-8?B?L25TTjlXWCtZU3ZlMlhwUTBpQnR1d3BVbncvRnorVnp6T3NrY1JIakRPcVlM?=
 =?utf-8?B?NWtzaWhtSkZhQlNZSmx6a1krM0Y3WVhIZndhNWlZV05VemgzUXM1YlcvV3RI?=
 =?utf-8?B?bW4zbG9JMm9DQWltV3RqUzYxVzVURzJoay9CRDlJaUJRTlhiWFY3VGI5cHhi?=
 =?utf-8?B?VHJZZ2w0WVNuUyt0YWIzeVZVSXBQT2IxQzN4U2lBRWxCYkg3SkhBZ3p4dml5?=
 =?utf-8?B?czh3WjgwbGMyaE1KSDAxUDFrVU1HL2wwbmc3ZUxlOFVFL2VYV0M5RlRaUkpO?=
 =?utf-8?B?bVozMkh2QXNGeVFFNFNOTnkvelozeTJBK01YaWhjRDJBUGhpSEsyU0VPZlFu?=
 =?utf-8?B?ci9ockc1ODJ6M2EvMzZvYnFLOTd5bXNtWlEzU2tXVlkvdlp6Rm82QnJUMzR0?=
 =?utf-8?B?NkhQSXV3SVkzUHh1RTFVR0dVc285NVpHNXUzRHF0a09xL2daa01BMmF6azlJ?=
 =?utf-8?B?VkRKT095UFQxd3dENE82bzF6a0U4eXUyZ0hidU00OXp3WGVjbFlYeHpSZkJp?=
 =?utf-8?B?Z243UEZZNHJwVkdONkxEd2tlTStSL3JxZlVnVnN4aXh2cTI3aDFLWFkvWXo5?=
 =?utf-8?B?M2o5NVI0VzNDSS85YVZhV1REZnVKOHZ0TkwwT1dWbVFsNFBBSER5aSttcTB4?=
 =?utf-8?B?M2VqcGJsZXJiTzhKZ3VZNlQ0Y3pTSnF0RHNoVlFBOEFhTVJFcUNIV0F0LzdV?=
 =?utf-8?B?c0dUQmh0UHh5ZTViOTZiYlI1UTZDUWhIT0FxNnRuajZ6ZXlqeTEzZCtZbW9Q?=
 =?utf-8?B?RGhTT0pESDIzeStTaWpQT3FWUGZnTjdTbEVpZjRjbDJDRVUrZzJqUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f321ed18-952d-4638-4bb4-08dedb7bbbf0
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:29:21.5749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1V3x30KIHHyUG1aaUshZ0HlREJFkmRIk6AWpYffUheBXY+x9T6xyUTPewOW2XItFzik/qI6VOTfyrVwZvejFxbK6+UQd1jQgpK2ovFPhR6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999
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

On 7/4/26 6:30 PM, Simon Glass wrote:
> Hi Peter,
> 
> On Fri, 3 Jul 2026 at 11:11, Peter Robinson <pbrobinson@gmail.com> wrote:
[...]
>>
>> I don't think we have buy in from the community into the whole concept
>> fork as it is to be actually discussing links as yet.
>>
>> I think you need to answer the questions to the community about concept:
>> 1) Why are you holding the u-boot.org domain hostage over this
>> 2) Maybe you need to read back through the input from the community
>> and revist what you think concept should be
>>
>> I feel I was very clear, both on the community call when it was bought
>> up, which lead to you starting this thread so I had assumed you
>> understood that you had to get the community buy in.
>>
>> In the follow up private discussions about it after it was clear as a
>> whole that the PLC was uncomfortable with a specific websiite (we
>> don't plan on supporting forks, would we provide that feature for all
>> forks?) for concept. I offered the idea of a custodians tree to allow
>> you to develop and maintain the features that you were preparing for
>> upstream in your concept tree to enable easier collaboration for those
>> that wished to work with you on those specific features. Maybe I
>> wasn't clear enough in my communications but it was never intended to
>> be the location to host a fork.
> 
> A fork would be something which forks off mainline and goes its
> separate way. Concept is not a fork. Perhaps a constantly merged,

But... patches in Concept have already gone their separate way? We don't 
have them on the ML (nor do we want them at the moment as they are 
mostly AI-written and the Tom's position on the topic is currently "don't").

> multi-feature branch would be a better term. Please read my original
> email again on this point and I'm happy to explain it further. Quite a
> few series have already found their way to mainline.
> 

If it's not mainline or a maintainer tree with commits on their way to 
master or next, it's a fork to me. FWIW, I think we could even consider 
the maintainer tree as a fork as well, but since it's explicitly listed 
as our workflow (c.f. 
https://docs.u-boot-project.org/en/latest/develop/process.html#work-flow-of-a-custodian) 
then I guess it's not one (not in the strict term).

My company has a U-Boot tree + a few patches that are mainline, I don't 
claim it's NOT a fork even though all commits are either already merged 
or already sent to the mailing list (a requirement we have for anything 
upstream: send first to the ML, then we import if from the ML). In that 
regard, Concept would be worse as there's no guarantee patches in 
Concept would even make it to the mailing list.

Your insistence that Concept is not a fork is puzzling to be honest.

>> So I think you need to revist what the idea of concept actually is and
>> come back to the community with an adjusted proposal.
> 
> It seems that you are rejecting the whole idea of a Concept tree (my
> original post on this thread). Can you please confirm that? But if you
> have ideas on how it could work with modifications, please share them.
> There must be some common ground somewhere.
> 

I'll let Peter speak his mind.

As for myself, I don't care about anything not going to the ML. I 
wouldn't want an ostensible fork be hosted on official infra.

You've made multiple reviews in the past on the ML mentioning Concept to 
users (I know, I received one and had to look up what this thing was). 
You continued to merge other people's patches in your maintainer tree 
while Tom had refused to take some of your pull requests and continued 
to reply to patches on the ML that they were merged, even though they 
were blocked by other patches in the same pull request Tom had refused 
to take. You repeatedly failed (back then) to take into account Tom's 
request to stop bombarding the ML with long and difficult to review 
patch series. The situation ended up with you being on hiatus for 6 
months. You can imagine I'm being a bit skeptical what your actual 
intent is with hosting Concept on official infra and claiming it is not 
a fork.

There may not necessarily be a common ground or compromise, rejection 
may be what the project decides.

>>
>> First though, I repeat again, would you please explain to the
>> community why you are holding the u-boot.oirg domain hostage to try
>> and force the PLC to accept an idea that we have been explicit about
>> the need to get the community to buy into this "concept". I think the
>> community deserves an answer.
> 
> This is a bit of a one-sided view. The real situation is that for many
> years to implement major features and improvements in U-Boot, but that
> became progressively more difficult as Tom started refusing to accept
> series and I have no ability to get PRs applied. Perhaps I was naive
> to expect our good working relationship would continue forever, but I
> have contributed a huge amount to U-Boot and having the rug pulled out
> felt very unfair, not to say bad for the project. Regarding the
> domain, I have offered to point subdomains to anywhere you wish, which
> would resolve this. In the meantime I have mirrored the website and
> moved various things away from the domain. But I cannot support the
> sort of split that happened with Barebox, if that is your goal.
> 

You didn't answer Peter's question. Also note that you're not doing the 
redirect properly, c.f. https://docs.u-boot.org/en/latest/ (and I'm 
assuming all URLs except the base one). If we don't own the domain, we 
cannot make use of it as a third party (you) will be free to serve 
whatever they want would they change their mind in the future (and we 
wouldn't necessarily know). I do not want to be included in this 
discussion but "hand over the domain" != "i can redirect for you".

Pasting the rest of the discussion in the other thread here as Peter has 
started referencing it so maybe we can merge the discussion into one 
(copy-pasting manually so maybe I'll mangle the "depth" of answers). 
EDIT: well, took too long and Peter answered already, but eh, here it is 
anyway.

 >>
 >> Tom has clearly communicated multiple times that AI is generally not
 >> welcome in U-Boot. So how is accepting AI contributions into Concept
 >> compatible with "Once features are landed and functional in Concept I
 >> hope that many will find their way to mainline"? Who's going to do the
 >> work? Who's going to take the legal liability of reworking AI-written
 >> code for submission to mainline? How is this going to address the main
 >> issue you're having of "code is not landing"? It's still not in 
mainline.

 > U-Boot tends to follow Linux, so we'll see what U-Boot's policy turns
 > out to be in .rst format. I am hopeful that eventually more people
 > will see the cost/benefit ratio of AI in a different light. My
 > understanding is the policy will be addressed once the infra move is
 > finished. Linux requires disclosure, something I have worked hard to
 > do in Concept. The legal question is covered by Linux's policy too
 > [1]. I do understand that any new technology creates fans and
 > opponents, problems and opportunities. Some thoughts at [3]
 >

Note that SFC (under whose umbrella U-Boot now is) != LF and the 
official stance of SFC is now available at: 
https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html

I will quote some part in the preamble that I think is worth highlighting:

"""
Some FOSS project leaders have taken a zero-tolerance approach to any 
LLM-gen-AI contributions to their projects. We support leaders who make 
such decisions.
"""

So it's possible the project decides we don't want to go ahead with 
encouraging the use of LLM/AI. At the same time, we import a 
non-negligible amount of code from the Linux kernel which for some 
subsystems allow LLM/AI tools, so the project is already tainted by 
AI/LLM (or soon, e.g. via dts/upstream in v7.1).

 > My approach has generally been to embrace change (and deal with the
 > fallout) rather than to resist it.

Note that *you* may decide *you* want to embrace change, but it doesn't 
necessarily mean the project wants to accept it/them.

 >> What I think will happen is "I cannot get this merged into mainline so
 >> I'm going to get it merged into Concept and then direct my users at
 >> that". And eventually, over time, everything from this Concept
 >> contributor and their users will only land in Concept and we won't even
 >> have it on mainline ML.

 > I don't want to speak for Tom, but yes I can trace the genesis of
 > Concept to the increasing difficultly of getting things accepted,
 > particularly large things like bootstd and VBE. What do you suggest
 > instead of Concept?

I understand. But I fail to see how you're addressing the issue with 
Concept? Like, how is this going to help you get things merged into 
mainline? Being cynical here but the only positive outcome I see for you 
with Concept is strong-arming the project into accepting your changes 
that we're currently rejecting/not reviewing.

The difficulty of contributing to open-source projects is not new: you 
must have buy-in from other people to get interest from reviewers and 
maintainers to get your code merged. Convince people your thing is the 
right thing, justify your patches, provide ample context in cover 
letters and patches so drive-by reviewers or people with little time 
have it easier to review your code, contact distros to figure out if 
they are behind your project (e.g. VBE) and get their support and public 
push otherwise this is someone having a grand plan for how things should 
be but they forget other people are involved for this grand plan to work 
or even be used.

Quentin
