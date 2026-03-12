Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE5106ACD3
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 17:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18802842CC;
	Thu, 12 Mar 2026 18:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oG1Q76Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CD1842E0; Thu, 12 Mar 2026 18:15:05 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6EA784238
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 18:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWhn+q90iLpCTrrK3U00uiZxqy8sTIJvI+lv+AXIMQ03gR2WHIY1Mr1J67RBRqD2yhXzdbN/WebiruU+eq8TiuQb0jtiSLcOC79p0nv7VFaDv65Ttdu3wrm2sK/4WvDvrSvF1pNgAKY0kY3eFAgMLQr4cnFyrcQWUP85JsJFTWY1gI/j2HKRLQamZ1Nu6VrcKacbKcdA0duWxiJYis83tdIT4deynKgG445Q5KDqEnMjA6GsZFlwUM0yRD2PXDTHU2aafjM5niySpbrUuuaqXdxox0I8zxu8bljFrGvH7VPcFze5OA3gI9Fprbc7omwwJWmuEMzUjMuvPZ5kSCgUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOdubfPkOii2Uh0CMmvt3NzaZBuS8Au/Ldpf0sQJF5g=;
 b=eRUq/zIYHxqG58tg2PGE32RktAomzXEFe0FzodBXtz2CeyUCIs7+oftLsEVvAuL7yLHJlFrudi+bFJ2gMSXv3tCGPJscwQ2eeA1RiXXdgbRoFhdgOSP7+4BkV2r5tI8wEqMiQibSe9N18ikX48kCa52zHhIvd1qzO1m3cIQD0QkdPfb+OGs/beVBtiSWYm39gQOclNoZaefWSLd2A1xs9ka+aMJl0/VcnT/ftHbOt99QojPIY0/6beYCxd7BBxMOMagd/htOhAw69dvjjvqiqzLBOvwUdHvDlGD0zG3Ng2bwGPFb9oXTREfEZkKGJSleyDV4h9v3OzcVBRW3cXBGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOdubfPkOii2Uh0CMmvt3NzaZBuS8Au/Ldpf0sQJF5g=;
 b=oG1Q76RxNiK/qIxxgMdYHXhqO4rJTOHFzLAhQ6L5AbQwbQqv5NmwpNUS8LT89LcsfhiHCksOUCk0May64ttjXSvzhIxfJ3LMOm1l9mY5un2pQA2yHjvUEn+/ZrhdNrhXfJKSBubhsgJPkP+bhqC4c6VHKUIjfEHSTsgBqtBOtFPHQZCFWSHoxHhOqzskJ9Jk9pnWP+HYyRtHO1FiOwp8aoe2HvFy2D1o4NPWenKsAbyFE8hV0lzjpCzyF6iMHoi5PbBAU5JLtygpN4tQEVHhLYIm4ehgB5iSdb28ZX9vSfQAxP1sSSZKcZoxsGbT21wPOVx++ib6hR7dUhESiOTnDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AM0PR08MB5395.eurprd08.prod.outlook.com (2603:10a6:208:188::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 17:14:59 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 17:14:58 +0000
Message-ID: <ede89994-cd05-437d-8808-2fef4f5889ed@iopsys.eu>
Date: Thu, 12 Mar 2026 20:14:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] net: pcs-airoha: unify code using SCU regmap
 helper
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: nd@arm.com
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
 <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
 <49412867-f5cc-4f80-bd41-3cf0f027479a@arm.com>
 <f2780969-05e4-41b6-abd1-1e09aea706dc@iopsys.eu>
 <08774e1a-b7fe-4f2f-8922-e6e766dc8c5d@arm.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <08774e1a-b7fe-4f2f-8922-e6e766dc8c5d@arm.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: GV3P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::11) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AM0PR08MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 96031771-3314-4110-728d-08de805ae376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7aDJiRkUe+FWc1CutphwAZrjiBS1p5gk23ViKP9LnCsH55Fc+z7+njx7a6KyZ8+U9yaSj4c7Q3G7ztwvyKvUWg2ojMRm7s6HCgB3C8cVUizFJkNNWvTUPU8k6Z9dH2NrB5S1QyETMcoyEVfGXxdscHiDi23gaTBx1Oh1mU8Z3LMFSljwBarrH/TJGqImok/EiMwJNACRyMmSYUWk/yQxrz2YDxiT7cLkhVw8EX6PQEORbJHxtLkFLHs5pSzjKylmAjg3BhQUVPHPt57w+6yQk6uk8UvtYY0uENgExRPH+BwKSeJcvSRup1JzGpATL5Rb4S698p4X3Yf7UOMHn257e1A+2T18CEgEPIpyh4aCZtJscqAcc0wJDWhgg47cGNVBhXTRz0m1Uqnz7p07+UmZl/eqZNUP67ubAI6wdF5EB7B0CGrDIajuOFQnUixZICcCi/aahXccYtbLmrc5sOHt5lZPx3eq059SBDRxsmBwr7hEWmuxTRbZwpUJfCdNZ3yToiTQnp0LhtjZCM1+tWiTVKMp0NzVJJ9gOw6ohhKFRRYftq2ljZs/8nCHhtiPDGs7QTPf0O9EKz/PJo6+SxXTKpGw3c9ASSZZeqO+gBDrh558qcGMrdcLWD9wos1P5wPqjyJXHWhJtleH3aNFU2BcQLzekfLpXFAbQWf983D1bbyEnaDulP/dGO83TZe5+wA4Kt28a89Nb0S4Wv9NSdQp5HULaEHYdMPjbh7qRCVnhtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S29JVFVhMEJGUUhPeXVBdDZZeEh2YlJTUS94QURodEtLdGlNVXoycHlHbld5?=
 =?utf-8?B?NDc0RFZnOGFTVkhWRTNrNWx4NG41c2dJeWZWcFdMZGlrTGE0dWwyaU43YTVu?=
 =?utf-8?B?MitOdmdiZEZRaFg0MXI5bC8za1phTlFlc2U1bi8zR3ROQVZJcm1NK3h3YkZ6?=
 =?utf-8?B?K2VLeVQ5bENja0pEem5EdkZURzVtb0R0UDc5dFpIVnpoYlYxS0R1ZCtxQVI1?=
 =?utf-8?B?Y1o4bmVoWk83N21IWkxTRW1QcHJiSUsrWDlIemN6UTk0dE5GZ29wU1lRM2tI?=
 =?utf-8?B?TDZQWW5FZHhkRjVieWxpOEFtUHcraDh5WWVaYlJDMW1FcXc5c1lMelZoUWxW?=
 =?utf-8?B?b2tFN3pSREw1YkpmbExqaC95OUhNUXdxUnhrWlg5NFo2OUgxdEUvSDVxSXpH?=
 =?utf-8?B?NVZQUkxSN3pIajQxQXRlSFIvUW1kK2pReEY1eDFsdC9nbW4yQXI3UWxoOWhi?=
 =?utf-8?B?YUNLczVHNWFjSGcvV3QwTVZVVlh4c3Nhc1RsUEdLNGtpRTRFbWJkTkhxQzdM?=
 =?utf-8?B?VWxiSkZzUmM2ZGVqWGF0aklZMG9ZcFp0dnNpUVZQT2Z1em1qbEpYallyRjJ0?=
 =?utf-8?B?a2FzUVpVdVJneUZna29ldDVvdzJuT0ZTaWozVkxVSjhrNFFTMnJaMVZzOWR1?=
 =?utf-8?B?N3Q3UWMzUitDbkpvdC8rZVc4a0F6NXlmUVAwa1NTZHV1ZmFucXhrMnNhQnhj?=
 =?utf-8?B?VnFMbFl6ZnplN2Vyd1p4RHllQUs1MFdEUUNZV0QvYkk4TGVPUW5XKzNxV0tL?=
 =?utf-8?B?SE5IaTJ1amJhLzRndjJ1QnUzeFJXSXgrUFNBdW5mb3NBaVRjTEMvVC9QK0Jz?=
 =?utf-8?B?ZnZCT0RWbWprcVQ5TFRPNmU0ejlqcHUwZkFmUks2NVowWEsxblBRQXpHTHIw?=
 =?utf-8?B?dlBSSDFTOVVSWkRacFJFcXNUT2JIVmRZMWpQL3VWb2k1b1RaM2RkcEFwQUVl?=
 =?utf-8?B?M3NKMld4a1lGWVp3dThSdy8zTlFsbzhOWVMzWTFPcXBiUFY0Y2tUbkU1UFM3?=
 =?utf-8?B?OWtoVUgzaTVrNXRBbWFmU01yZ2lpbUoxZ3BFSjVXc1pnclI1VXhnUVpWdEVZ?=
 =?utf-8?B?SkUyZkdwN08xbEFvbnFpdnJHSVQ3bHNLb2h5RTA2OHNWUFJ1ZmU4SWlKeDNy?=
 =?utf-8?B?ZHh4bTNtV2wvcFN4RHpONG0wdDVXVXRsa3lHYWVyS2QvQUFkZkJFeFVYeFpt?=
 =?utf-8?B?SjdLaUN5Zkp3Nmt6dWVjQnFsY0xVR2E3ajg4WVRyak1qOEhWMFZ4M0hwL2M0?=
 =?utf-8?B?cWozNTMvc2RIM2U1WnY3dUU2ZG9ybWVEUkJId2IzV3FBQW9nMG1JYWx6YjdY?=
 =?utf-8?B?YytGOWRrRlUybkRRTVdBRkpKLzNrT1VZREZ5bXkxZmY1U3B1SXhCYXZaSlZm?=
 =?utf-8?B?dnZwZEQwK3JHUVpRQm5jUGRpazdpUjNpd0N4YnBsWkhmWDNDT05Ka0xRNzZl?=
 =?utf-8?B?UXNVYlFPU21yRW55RFpnSDBzMDBhaE8wbU93Nm5lUDJxSGNBKzBIVmVPaDB2?=
 =?utf-8?B?cjYwNDQzN3ZxNGh6aE9JZm1iZnp3UENUUHRiV0tMeUVEemtNZE9iMkxWeVdI?=
 =?utf-8?B?OVY4b01zQU1OWmxOZ1FMQkZ3VnNGK3VudFhBeloxZiswaWZrRjZjdkpLNmll?=
 =?utf-8?B?WmFoSlZEajRZNTI2enlpSGFqdnRYcERLR3NodUphQ3JLak05NkgyVzF4ajM1?=
 =?utf-8?B?ejZtK2t3QmJOTXphYlQ5VzZFMmM3VkZodmJWb3A0N04vL3JLeFZMM1dDemNZ?=
 =?utf-8?B?ajNvcW5WZjYvcmxhT1VpT0I5dVZvVHlSa1FxR05mSFZpam5DZ2tXSjF2WFRK?=
 =?utf-8?B?VDhwQmpuN1JlamJZT0lBN0J5NUdyZkZRTStLNmF5cDRRUEZOdUJxNzNib01O?=
 =?utf-8?B?ZExxWmlUaW1WRWcxdHFleFFXenp1aDg2MXNUUkduZldCUm9IRDE5ZGlBNVdS?=
 =?utf-8?B?VVIxQnR1SG5UZk1EME9QNDY0VmZBNVNHZFRrWDVpQlByMXdnVmloaDZyZk10?=
 =?utf-8?B?Ym51QzRzUjFyb1RVRmovTmlMNHV0MktlcHVRTW9EWGZwMFRIclMramx6cFUr?=
 =?utf-8?B?SlBnZWtaeTQ2QUNHeTBOeDBNaUdwMGZZUjU1TXJldkY0K2VBMjd2WjFINmhz?=
 =?utf-8?B?c0JYaDMrZmMxUHZqMUhPRnpYbEp6V2E1Ri91Z2puazdKaDdVclovUUZGb3dY?=
 =?utf-8?B?Ky9RWHNZaWJEUFk1UDdieTgwTkJrYUlLL1pCejVNajM4Um5OYVBGYkg1WUdt?=
 =?utf-8?B?WDUrS0JiekptdmxvOXF3R2ZDRkxtRVVUUG50STRORDl0UjF2bXNUa2dNOCtG?=
 =?utf-8?B?R0hrZ3R3MmVGTmdRcDJnRExWREZ0QUltUkJYbUlWcDl5a3BTblU2SUJQUjlI?=
 =?utf-8?Q?1nc1b5t9plGpluTg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 96031771-3314-4110-728d-08de805ae376
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:14:58.6903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sR+JSt3xNFXFGYwJp/8eqbSEnbk7aCkbsYJQeVve1wqYgtVyY5BGJFxvamL3JGbCD/GZtup5Rho5vLDMxLAfyzwgu9B3Vp1qfIYr7Uw4lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5395
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


On 3/12/26 20:05, Jerome Forissier wrote:
>
> On 12/03/2026 17:11, Mikhail Kshevetskiy wrote:
>> Hi Jerome,
>>
>> This is quite significant patch. If it possible, could you delay pushing
>> of all the series a bit.
> Oh I'm sorry if I misunderstood that change. As I said I have already sent
> out the pull request. Well I suppose worst case the feature is not yet
> working but the series without this patch is not breaking anything, right?
> If so then I suggest we merge the series as it is (without this patch of
> course) then apply one or more followup patches. Tom?
>
> Thanks, 
should not be an issue for an7581. In worst case it will just not work.
I'll create a proper fix tomorrow or on weekend.

>
>> I'll look on this patch (and maybe update a little other) tomorrow and
>> sent an update.
>>
>> On 3/12/26 19:05, Jerome Forissier wrote:
>>> Hi Mikhail,
>>>
>>> On 11/02/2026 19:22, Mikhail Kshevetskiy wrote:
>>>> Use common code to get CHIP_SCU registers instead of driver one.
>>>>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>  drivers/net/airoha/pcs-airoha-common.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>> FYI, I had to left this patch out of my pull request to Tom [1] due to
>>> a CI error [2]. The root cause is not obvious to me, and since it is
>>> just some code cleanup I decided to take all the other patches and defer
>>> that one.
>>>
>>> [1] https://lore.kernel.org/u-boot/91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com/T/#u
>>> [2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1396757#L1193
>>>
>>>
>>> Thanks,
