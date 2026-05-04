Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D633FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17B484653;
	Mon,  4 May 2026 14:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPuvM96S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355148465E; Mon,  4 May 2026 14:39:14 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC308460C
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3k3Xm8K4evNZYwvH9eDnF1TItr29jO7nt4auAUBcsB5nsoMVBHEII4DUKVfMScaU1QmHWaKAfJMmWPWbAgWHL1JcHXqgN3jJpaG/5SPJmDKO9ilSmkBijcwco/b+oGjEtcSJkj/a5maqEpYN0A408ZHq6eO3o68DJYsXEyURN596FbeatWMH4LvSeAgChyeeefOu0IUDboTV0MtKRVBr61jvX9CpsmhmouPiOOvYh9zVggeAplUWOFkPsArt/jvSWjbkKMWc/ue5rzzx+kKdOJW9sneLtqeM95e0f58eyOIENBfhA4NDE9k4fhf7oQoqL19MfZ9cEQ/thWE+RW1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4EQpcXMBjhYeFDDL8HJgTo6pzzq4cWrU+h3PPzHv2A=;
 b=uf+bVXfMS2CrIbhavGhfQpV+wYSp91+noDLbMSZkEf//SLYDs+I06ulJ6CBRRt2kKBxAcShCCbNX7ElPyOItamLTUoSypOI7KjFoE3wr0JY5q/4XIgWaaPReMULlm2/67mFMlwgDxBt0F5b0GdQVyiaB6Zplzp33InPF8FPlDoQEwedQBUPVOEtDjKpmtHBAjOeFFJ0F9spYs84zRVujVnGVgCiz4HsIRBF9dVHg9UCA1D2W6acH1u24OKaMfhMV9voBIAVQT5ycOaDPQE8AQaOOHdFun+i3bE07MCnifaTVGAUKwV6a+mSoSB3UgXzbUGAK1mu05p2MH+S1tDZBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4EQpcXMBjhYeFDDL8HJgTo6pzzq4cWrU+h3PPzHv2A=;
 b=QPuvM96SGP/4IQ4QQJSEL1uPWbYs8A3yrG2kNSAzKZWJEyxR0cJDPJdDpNzFpDGBp/TTL7wJNSriN+hdZPEN5MVWYW2MznrkWhsA2DZo70bh1DjBpsTrNaCkCSWzLZ30yoVZzeI0ykqeaqrM7SNbNKBu5mS8NRg3woYrFEOxr9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:39:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:39:02 +0000
Message-ID: <9a88e2cb-37a2-46a5-b56e-e01d336daa31@amd.com>
Date: Mon, 4 May 2026 14:38:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777551598.git.michal.simek@amd.com>
 <74c8b0830dadc5b7f36c4e2c49a1087a503f7ca1.1777551598.git.michal.simek@amd.com>
 <CAFLszTgWRJgZoLQqqLvLuUR0B_uKje5ffvQt3uZG9sdhPiKNNg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgWRJgZoLQqqLvLuUR0B_uKje5ffvQt3uZG9sdhPiKNNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: c74ef739-ac49-44c0-51a1-08dea9da1f22
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: muGV5ryi1gCB5h/1V1N9Go9xRqcBJRBbBPoSbJbljYEZcKKzE+txmlcraoEiaSjyKKrq7fYEbT0azr1E7EPE9KwTeozKtGxSJ+KRJkAU2AkEVPG2hr0vnDlCI6NldhD7R4F9SVF9LsKEwRdpK9GdQJF2b6d3Ddg9neov8JiIkptyxPF+Z/lG/K74+bi1sjouKniicjAx8s0RkKIuPJoMh8JBKn6UsdvoasTaX/FirDadMJbE6s2pzOkcn62Q8LhPvOoGmHJPGuaQnVQ3rUKTgh33aAhh+6pWjup0NI2E6j0eaLhE1RBbIfmwJzGhPqrzfv6i2s9EEoOQDksy3NTbZFbUEpTYr+GP+maUtePivtyjhqKurN/UZnSn063+fyYoHQmiGcnyLqqTwoaMueI2+P/Yiu0H0q+TuBw2bJrxrN/ClJ2ju2tgaMx9vHZpibQcI9Qs4juuMFvubIXleQqJMQVStUoVQvqWsbRtyzFpDjmJxOYL7D8NUA72kNNrxSHj+7fV7azf44eelvxBvDNpFTAAWK9HgXbjHDqR5gkt2Ee2ycLHNWUckV4DtaxydCXOsC6dUREbjwC3fQl5U/Xir8CeKJfd3Zf04HlMwkp6XnKrM6xPmvld9gmUkgBcjTguTucPb2Aa4AUTNx17Iphrxcz1OquaJBsO1FQCY258Zo2Iej2KwbEUgkNRqWPJ7xJS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFJ2bGhUUmVwRUJZbjFES3JiNFZ4bkV1Q29zY21wLyszZXVENVkvSjB4N3U3?=
 =?utf-8?B?VXFhaHE4LzlucmJodjU2Y2lDTkVJU0tSdEtxSnBZWHNDek9zUHlaWnkvUTJ3?=
 =?utf-8?B?UVFUWVFCeXpRckFRT1cxVXBaU203UGNTODhCNEdzSzcrUEc5T0tzYnM2TXRJ?=
 =?utf-8?B?QklGb1dpYlJLTXZLSmVQUmhnMjlTUXkwOFdUOHNaOVNwOFZqeWFpWjAySWFH?=
 =?utf-8?B?UmZnd0wxNENYZUh4dVNmeStrVURST1p6NC95ejVRcHYvMURQeTJqbGc4Q01h?=
 =?utf-8?B?V1Vlb2xSVFdGZGd1RmY2TXZ0REduZnVnQnVKZmRsbk82QUZLSHF3TUhPMmdm?=
 =?utf-8?B?cXFQME5sanFRN3pCNkZjYTdBUEt1V0ptR2NyaEZheUJsSWo5Z2JvSHF2NnhN?=
 =?utf-8?B?bWdDWVVvQm8zZUFPblNsTHVBUFZERE9ZWFUySnQ5cWE0TG1NK3BOUSt6Tmpw?=
 =?utf-8?B?OWJYVTdJVlM0SjZONjFVckxaR1VWTWRMcDMzNjl3ZnI0TEFvbTdKc1U3dlYz?=
 =?utf-8?B?VG1nalMyMXlXa05wM0FkN21JTkd1V29FQlRrbWZLTFFJSWREQVNuODFoeUEv?=
 =?utf-8?B?b2RleGw0MWxxUXkwcEVvUDN3UC9GMFNEdlZQM0drRkhXbjBhNy8vbi9KYU9G?=
 =?utf-8?B?SEQ1ZzNPR3pvSithRzNDdGpCcm1ubWtOY0I2YWwwKytRaS9wdjllSnFhMjZ0?=
 =?utf-8?B?Y0pXZTJ1WEl2YWZQenNETldJNC9Zc1ZFK0g2VEo0bHdXZTdaTWlDSzZ1Rm15?=
 =?utf-8?B?YmtPSlJTaUdwU1RVWS9JeTlzSTFzWXpvUVZ5eWwzejlMSGc5TVRYUUh3aEYv?=
 =?utf-8?B?OEREdkZQRnMyRkRURjJvYnlFZlpSRWdtUWljUU5iZHNaaTdKYjloM2xUdkpH?=
 =?utf-8?B?eUx6VXBqZ2MwWG1WYWZQL25PbkR2QzZsME9IUkd3RGI0N3V4aytaYnNRWHNn?=
 =?utf-8?B?RGE5SW1pT1dlRVdpZVFoWmRNM1ZTWVArUVd4dGZQRnRJcXIrZFh2cFJHZXd3?=
 =?utf-8?B?TW4xNkZhOFF3Wmt3VStMYXB5dXEwc084bHJnQU9zYWJrMHVMRHBHYThhcnds?=
 =?utf-8?B?VEFSbG1wZWl2ZFdscDd0V0dvMjNTTVJIaVZYdUtXdWdoMzJCVjVDcDFRQ3ZI?=
 =?utf-8?B?Yk9wTi9hVVNLeUxqdk9tdGw1TTN4Y1VrUkkyaDdFUkgwaEVpb3ZzZ0cyckpT?=
 =?utf-8?B?cElteXV1V2NMbDJFS2V4WXpERnI4cHR6eFhKSXpiZXpSTm0xMXJQUHpPazl4?=
 =?utf-8?B?K1FmcnAyNDd2WXl2Nkd0dmN1QjRhQ1FEcjBZV3Y3Z2FBSkR6dEZQOVJoOWVV?=
 =?utf-8?B?NDlUS0pNZ2oxWk5tUHRleVp2eFdzK3dRSXJHaGN5bEpnN3JpQ1duM2puZjdw?=
 =?utf-8?B?RW1rUSt5VDE5UkkzcGJaNnhJenlsSEZrbkZ6Q09DSzFiS1ZZR0FxamhVc0JK?=
 =?utf-8?B?Vm4ydXNyb2l0eUh4ckVwQjc4ZDVRVWY5bGRncklFcERJa3JCZnJ5b0ZjTWRT?=
 =?utf-8?B?R1JweFZJZmpPeklCTStWR2ZUZURjQnBBOHB2cmpEc2pEektzNGFwY3FDdlVp?=
 =?utf-8?B?elNTQWdwV2l4U0pqeEF5bGkxbHhLQlZjd1pnMlh3eFBSRU5FZEF6T2JGdHFP?=
 =?utf-8?B?cU1HQ2d4SWluZGxWSlpqSmwyU0hzU2I1N2l5aUZmNWc5MHVGaEZoalBSbzIw?=
 =?utf-8?B?VzdLUC9YaFgrSjRmNEJ5TDVUK3NYRHR0anJjeldtUldwaCtHWGNGYnhKS3gy?=
 =?utf-8?B?cUVyUzlkaXptdWNhQTZLRS85SmpWc3paNXhjSHpYVGlJa0YrWm9FZmJFVXlk?=
 =?utf-8?B?UDJEOWh0QnY0M2M0OUFyejBnWUczYWR0cWpmdzRZY3RhMjhtclRMUDAxd2NF?=
 =?utf-8?B?YVFZc0FuMXM4UTZvTE5Kd21TMDFGVnNVOGNHYVJSRkszaG9MSVFxNm1jU24y?=
 =?utf-8?B?R3VGQlVibkxhdjFZVHBLMXhGbTZUMHoxdUxZNEE0dnBxcTFTT0hRMUsrRkhT?=
 =?utf-8?B?am5JN0JDWlFnYmpuN0o0dmRwT1VaSkhnQWNDOGIrVGJicG4wdFdDQkc5SXND?=
 =?utf-8?B?ckdEcmZwbUpNSG9lRmJaWGNVeDQ1TUVRdFJzZ0dVR3p6M3hvRFdQL2tlMWZH?=
 =?utf-8?B?OTFjVkQrdXdBbW05OEc2TndnZy9WQVBpdXY4K2dTZUF0YnM3b1JWVXhFOXRq?=
 =?utf-8?B?STdYVnllZ09yOUpWTG9DV2F0WmRqdmIxRTh0Z2pkZ2ZFWklBS3BCNHpxNFBP?=
 =?utf-8?B?NTZpbFJHRVdSZWZ0R2VZSUdSU1g1V09PM0lxSVU4cmlEY01pWXBUck9JekNW?=
 =?utf-8?B?cFBQWkttS1VDbk82V1lkTEZwelVvbGg1eitQNDFsSjVGdjJLTW83UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74ef739-ac49-44c0-51a1-08dea9da1f22
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 12:39:02.4920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1TVoQv2MGxrecobfUuVsZ8T4Lm5zm7ERA1kMGY3GsYjC8I+xfnfX/psIT7rAL+P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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



On 5/4/26 14:17, Simon Glass wrote:
> Hi Michal,
> 
> On 2026-04-30T12:20:00, Michal Simek <michal.simek@amd.com> wrote:
>> reset: Add reset_reset() and reset_reset_bulk() API
>>
>> Add reset_reset() and reset_reset_bulk() functions to the reset
>> controller API. These functions assert and then deassert reset signals
>> in a single call, providing a convenient way to pulse/toggle a reset
>> line.
>>
>> This mirrors the Linux kernel's reset_control_reset() and
>> reset_control_bulk_reset() APIs. The new functions are useful for
>> drivers that need to cycle a reset line during initialization or
>> error recovery.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> drivers/reset/reset-uclass.c | 30 ++++++++++++++++++++++++++++++
>>   include/reset-uclass.h       | 11 +++++++++++
>>   include/reset.h              | 35 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 76 insertions(+)
> 
>> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
>> @@ -225,6 +225,36 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
>> +int reset_reset(struct reset_ctl *reset_ctl)
>> +{
>> +     struct reset_ops *ops = reset_dev_ops(reset_ctl->dev);
>> +     int ret;
>> +
>> +     debug('%s(reset_ctl=%p)\n', __func__, reset_ctl);
>> +
>> +     if (ops->rst_reset)
>> +             return ops->rst_reset(reset_ctl);
>> +
>> +     ret = reset_assert(reset_ctl);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return reset_deassert(reset_ctl);
>> +}
> 
> Will this provide a long-enough pulse on real hardware?

In our case delays are handled by firmware itself because we are asking firmware 
to do it. It means no issue on our platform.

GPIO based reset can be also handled via gpio delay driver.
But I can add there one more parameter to also pass waiting delay. What do you 
think?


> 
>> diff --git a/include/reset.h b/include/reset.h
>> @@ -443,6 +468,16 @@ static inline int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
>> +static inline int reset_reset(struct reset_ctl *reset_ctl)
>> +{
>> +     return 0;
>> +}
> 
> Just to check - this matches the existing assert/deassert stubs,
> silently succeeding with !CONFIG_DM_RESET: is that intended? Should we
> return -NOSYS here?

Will look at this one.

M
