Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7183DC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18A58800B;
	Wed, 20 Mar 2024 15:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Tr/ukjMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F51F87D7F; Wed, 20 Mar 2024 15:03:09 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01olkn20819.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::819])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BB68800B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQhNu9/IS41BmYRxhvEr2j1ds8sdgLo48SqUVjlc3x4ES936611vTSAFsj55pmPJAPETyPM5fxpZLj+xh57maNwr5EN/I89Kdea9KzPdrbJ/YGZL9bE3eLu++KpaKX49Whhf/jIFpipa894QCwu69yezWGbvEPy7nT6Bn5RB4pJqUN2YU4YTELozmPnI3qmsJXouTTFjOEIXJNAmFeVkvm5+K+n3CtSyB4YsK4cqXf6cbxgDO3cioLt+fXcUCB1DcCa8RkzT9xOeHZUGx6Q/x9xfg9YtYI7QO5PlDuw1vR5zROJd/JtF8qFiTJMNXkPy5sbWemrH1QfokIaT1gJtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zweEB1DlkZu9gs+ABO1aa67DgFpzlCQXo4D3V+TW/VI=;
 b=fAkxZYC2MB0yVwQX8Orb2/TGdhxCEgw70ElFO1aXIiOgVm3h7BjP3eHZwEAbblTT8EYfI0h630FQcjZ9rISAcnhqsPajE2AvAevqLRhNkf/5qIGHiTDkjECcPHaO4TIBHHbUfoxI4ecY/CFFW4ETj1+wX4FmztHqPOwqzm3TR7d7MgLEyONbzF2GMDD635kajweUaFWfQ/McdBR6QeDvEyj5LWw81xaOS4sQus4jecysjRR5vtgvkjA0lQ2DRWIgqX2JNyfAlcjtgJX60mnOq2QReNC5ke5y8y7Ql2Z6x4nRVnb4rdaM+1vODfCd2SJga6c03GCt6Zv6fpnYIBe6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zweEB1DlkZu9gs+ABO1aa67DgFpzlCQXo4D3V+TW/VI=;
 b=Tr/ukjMo1xR+ZAHJ/Ydta76Xuea2ef+h3XQXFMUKt+xa0lw1JjD74BVefYd/URsH3DeG99KlqHyZi3T60fior1e9aDRsLE+BUupLy0TCQxcR5dewhECAi9x0n0PSRD5fqXBAfDIj+Y5E8kMWK01A8PbfoKZ6w9rUVLiDNIWpOfd3z1eA15A0TEjxhgGER/hkV3vNHFOSpJYwBHlH/kLD46aKix9mDArFlrWpMLOmnLJty2Qbdoj5U/rHqOVVIwlepO1R2/rJB2U6xfbyCzz2bUaBmZZYhxHSybJc5d7FPjkkTanbQ5qXii+Bu1d+t/8PruQRWZOs8vPiNOv240FfPg==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYSPR06MB7504.apcprd06.prod.outlook.com (2603:1096:405:cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 14:03:00 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:02:59 +0000
Message-ID: <SEZPR06MB6959980F8716A68AD09D27FC96332@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 20 Mar 2024 22:02:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <CAPLW+4nqmeFNPRibP2PKSOpR67Ud=2wPL1V=XSxnMYDiSM20-A@mail.gmail.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <CAPLW+4nqmeFNPRibP2PKSOpR67Ud=2wPL1V=XSxnMYDiSM20-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [Om7/Ky46BLyk98fddrXWHcoszMl/H61CJKxH61qGDfMB4JB6dzIV4O+EOs1Cc+P1]
X-ClientProxiedBy: KL1PR01CA0084.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::24) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <4b1323c1-7014-42f6-af5e-73203913aec7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYSPR06MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 51025c74-b8f1-48ed-2c2d-08dc48e6732f
X-MS-Exchange-SLBlob-MailProps: 7J/vb0KDx3h7Pte51U2nZ3/UcDM7/R/+1yogjAmCmn8yOREwa8hDs1fWsPti80/eB/Zxlm4DF5Iz3zutfH9U0BNSweBtGQX4o4quBuGnwDFeukXvuX56OHlruHGvcktsUQv4/PWrJ+c/vanvYu1GJg9fiOkAwAeZSPB2BPE9/kMspZUNjmg5xK96B/NrDCO0yXizctfScjSFy7X+m1ZuOBXJnkA2U3keXf6hnKR26LBYv08g9/HzAppwg7jtxrWzag/EzrfHA7zYvM912gu63Lqyz+t94NAuUscykDvJGM0FkPUhvtJMW35cxeXEqy3rRg8J/Yzo9KS+cMdmMOz3mRjT3puvjuWb6kvOGdPHOIPCtxsSL6XECfQV3MkyMILBMdH3ezNtF2E/C/FvWLcY9tyZ8C8QCd7YhjVqO212MBxDuzQT7+aVkK3gSdgc2nIezTEoKDycFloUQlCtLUmx7JaDv7CVXP10wkKmuCnfatMsGsVYwrIc+3/dknsTBQoR/tnEMlXJR62m9KNBDbvck5laZOblj7aByWft1TJEArVQjwiJJBI1gFW2UuPSpKqPN7msOVom2gpJB9MnkF+ThYa1d0Hq9BNQmb3nGl719RA408lTB+BdCODaOZZAiNyUpAMbGSZFoumZCCsGmmSrrvqb8Dsvkkzff11mofalegmFrIOajhxf8Rgm53Ugr59IT1oF5+FxP41xaPmW1DDJoBT5j5mIHTaNDaMgOfT+ljFbROTAVjpXhxQxToo1yXOnaCohUSR+elVO3rO2vOoRNcf8pPfpNYkFGAMz9Sbgc0Y=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzVDmDwT4v5sh0iDViaFgjR6lYfrt1ycXVDeVpoiLiTHbM3zcjX63EB2rBsUsCYf4Y7TjM6cgevgCXYVlXV8CaqZVwp+u899vIlY232hUQu2pPVRvOXiOE1MotpPG/At/4R0ZbVvc8qEASz0ugIPiMT4Xh/G5GJgp2ZYCVTJ7x78CiGCQFY36QkttLdAVamDhNWZpZ9hM3J/6eU7ZtINaKQoOng51y+gmu2fAZC71lpRsiHWypf8yKl/2uaatR2JfadnUqW/ksgPj782hdJFeOtGdM3FMtAhLT397W+KQhDwc2cCQp6l84F4Q8S+rt4ZLrQoKOcZKydpaGCCNDaUPhx6Cxxit4efoSomlXQ5A/zD5muouhj6VaN+F32GDUOyqshQowHb7Ey65NEYakGkt5hq/zIfzzlqA4u1RrhKVE+q3sgYYKnAU+3jRd3qfHOXL4SCezoMC9ZSC2CfL03NMQxpjJi3LQ17cv09/JgSOP8ffL+KnGMw22FkisLLXoeG4UE6MJdhUT8evvs4cS80eM6L5197Yq0eN0F56lQud8f+YUWd31ghTquqNrd5YJ/u
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1k1MjVWYVZMdmM0U2dmcnQyaGNrQnFrOEZLMzdqQnVPS2d1cVNhSVNKbzlB?=
 =?utf-8?B?TENOSUl0MXpRTWNrRnFoc2NXeHpJWHdWc2VsZFcrSFdXZlFyWUxZM3J3TzlE?=
 =?utf-8?B?TDR6M0Y0aDFicFJrZTUxSVFueG9na3dIYUpDQzBhZUxWbEdwN2tadm13dFRB?=
 =?utf-8?B?K0VlVWp4TXRpZkZtUlVyakpodWRzSUZiMGxwK2EwMlFtdFlhTEduV2lSNG1o?=
 =?utf-8?B?QThGc2JyOUdYUDA1UjBqNmZIajhZRFNNODVwTENKZ1ZoaFo2WGJUb1FPZVY4?=
 =?utf-8?B?RThhc3YwZzZINyt6S3A1Sk5QVjhiUk42T3RQR0MySlVBS0FDdmxvUEJXRDYx?=
 =?utf-8?B?M043N3owZ0dwbS8zWjNaOG0vcGtxcDRXNTZScXg4dGYwQmFSMS9HVmt1djZx?=
 =?utf-8?B?eG5qNW5KTEhZbXRFK3ZxeDJFUUdpK3gwQ1ZBellyei9rblk2UmdZcy9iUFRC?=
 =?utf-8?B?K01DazRCbk1BaE83a0Ntc2QwOEJaQzlPWklTanFxazNJUWdNa3pvWk1Mb1lr?=
 =?utf-8?B?TkVEcDM5Sk5FSExURW1wNkZtQ2ljTkMyUVprcGw3akRBRE9XbXlGWmYxcW9N?=
 =?utf-8?B?elE2bllITTRrb1RvV1dRWWtrQUUyc05xTFNUaGY1NVM2OXNPcUUvS0tvc3Rm?=
 =?utf-8?B?SEJPWGpTckVsbThEb3dHekNWdklYN3pYaFpUWTR0MkdXOS92MFdEN2grZk5j?=
 =?utf-8?B?M3g1WXhPelZES3NGNzZEdm9GM1IrOUdURjIydm96VVAxcDY4MXFkcXozZEhY?=
 =?utf-8?B?TDlsQ2lPREdySk1rdWlUalVXanJCQTBETkdiYXROa0piY1VXbEdsaXJGYld4?=
 =?utf-8?B?RXJhRVcvUDBjSDg0a3lub2FDZVhyT1dERmdpaFpFQ3BjbWx2VmZKWXhQNXVE?=
 =?utf-8?B?TFdnNmFud1VzZU9UdVV1WHZHYnpvNENXMUtwTkhyKytLdmFERWJZK2xORjRk?=
 =?utf-8?B?MXY3eGJkZ1FCRmRkL0RTbHl3SXp0NzBISkxXTmlweHdNOTdaRjlVZy9CLzIr?=
 =?utf-8?B?NGZXYnJHakJPeWtzSUlTa0JOeWZWNzRVYVRlQktveE1JQzNiZmF6TU1HYy8v?=
 =?utf-8?B?Nlc3ZnVJdUF1WTU4TFJBYWlEd3lDM3dpa1cxbFhSYVdlU2xuSU03THRQVTZG?=
 =?utf-8?B?dHFWZlBaUTgyS0VUZkk3cUhKSEhUdURjS092UjFxUlBCV29jQUQzcHRnN2lI?=
 =?utf-8?B?M3RySzVXeXRWUFNlQ2FJbXdVTGN3bVlGa2Z1d05IRXhIREhhSnB6aFRyYVlj?=
 =?utf-8?B?M010TEFsOTJvdWRjWEVhRHRHMGU3dTZtRW9oWDBUTG9UcDFaYXRwZFhPQmZa?=
 =?utf-8?B?cUFTSjdQV2p2YTUvOWdGNjRUMk1IRE1kSWRTTTEwNE16YSt5WExWSzRROE9k?=
 =?utf-8?B?WFdvRXVYazlzY2VQT3I0SEZtRGJ2YjNlQUcvVlllTzArTVBscWI4Y3g1cFdZ?=
 =?utf-8?B?Y2o0aU9TZjJUa0svUG9zUGdYZ3dwbXN5Q1lhTUJWTmFQT2lXZ0xQK1lxc2Ex?=
 =?utf-8?B?YjBBZHEyU09iYWhXK1ZhWjdCTU9OMzRockVnVTNrRTRqelcrZ1JoSnpsSVNi?=
 =?utf-8?B?R1MrMXdtVXRxeWIxUXRGam9GcTZBczUwYXd5K2hZeDA2d3FIV1JnaFpEU0J5?=
 =?utf-8?B?TTU2UzdtVUk3SEdUeDg2eCtYMTh1cG9Yb2hMT2k4U003U0M5TFlwb1BqdUhn?=
 =?utf-8?B?MGdhM3l4YnY4alhDc2w1S2QvSnZWWkdqeUQ2Mzg2K2FHUUtzZXdJeGJuVEg5?=
 =?utf-8?Q?Yn3M9xCw5Vx+xGl37B99h7kwudULS40Zr+qVjqS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51025c74-b8f1-48ed-2c2d-08dc48e6732f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:02:59.5789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7504
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

On 3/20/2024 2:42 AM, Sam Protsenko wrote:
> On Thu, Mar 7, 2024 at 6:04 PM Sam Protsenko <semen.protsenko@linaro.org> wrote:
>> Sometimes clocks provided to a consumer might not have .set_rate
>> operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
>> set. In that case it's usually possible to find a parent up the tree
>> which is capable of setting the rate (div, pll, etc). Implement a simple
>> lookup procedure for such cases, to traverse the clock tree until
>> .set_rate capable parent is found, and use that parent to actually
>> change the rate. The search will stop once the first .set_rate capable
>> clock is found, which is usually enough to handle most cases.
>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
> Hi Lukasz, Sean, Tom,
>
> If this patch looks good to you and there are no outstanding comments,
> can you please apply it? It's needed as a part of eMMC enablement for
> E850-96 board, as eMMC gate (leaf) clock is specified as ciu clock in
> dts, which requires further clock rate change propagation up to
> divider clock.
>
> Thanks!


Please be patient. The release cycle is quite long. My patch set for 
HiSilicon clk framework has been ignored for ~2months already.


>
>>   drivers/clk/clk-uclass.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>> index ed6e60bc4841..755f05f34669 100644
>> --- a/drivers/clk/clk-uclass.c
>> +++ b/drivers/clk/clk-uclass.c
>> @@ -571,8 +571,20 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
>>                  return 0;
>>          ops = clk_dev_ops(clk->dev);
>>
>> -       if (!ops->set_rate)
>> -               return -ENOSYS;
>> +       /* Try to find parents which can set rate */
>> +       while (!ops->set_rate) {
>> +               struct clk *parent;
>> +
>> +               if (!(clk->flags & CLK_SET_RATE_PARENT))
>> +                       return -ENOSYS;
>> +
>> +               parent = clk_get_parent(clk);
>> +               if (IS_ERR_OR_NULL(parent) || !clk_valid(parent))
>> +                       return -ENODEV;
>> +
>> +               clk = parent;
>> +               ops = clk_dev_ops(clk->dev);
>> +       }
>>
>>          /* get private clock struct used for cache */
>>          clk_get_priv(clk, &clkp);
>> --
>> 2.39.2
>>

-- 
Regards,
Yang Xiwen

