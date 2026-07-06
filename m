Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7372FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 16:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 044E7846FD;
	Mon,  6 Jul 2026 18:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XDeQWqdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519B88498B; Mon,  6 Jul 2026 18:06:56 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 276D8846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 18:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2bjRJ8K5+grQHcKBjnedSP0G3Dyp2QNP7mCvkmhVfTFDOlPbJRiN0tc78sykKt1jbKkn76Iuddil6nbhJkQFuZaCBlXMQcZ3LXRArZSK8nI1wLBo0EFGjqZaVpxKCVCxJI/n00DHiAFcBrplnkknzVEVmeR+LoZZpXeKSjG77vtAL1+7Ti7RvmJhqDIJ2/uopsmtDpB7xxGJdQTxzIJaZQUPcNSjUMZr1Pws2/a8RP84Hsiz7l7Eiz9MmrnVP8TG3yU5oghp16IxpMkLEwhIEReQhFGXm83agpL1pgZp5dIuelAZYt67ZyHlcaYNyYRYnIg2SzcGpm/VwHdRBalCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbNq5WwiVn/QuKq4lw8qw4zMzZ2IwEMzJgsB97S6UQA=;
 b=pdOHtfXtrY6bXWzaZF+aypzzOFQsK+n2ABiwzlsvfeXQaHwMUuM1TzrDfCFXH9SIqPHZbzWWELPAs7z9tFjDCBeJVQmw6rUNcsTGcz7+9qTyMhQXd8jpCe+N8Zuk1Kw2U/Y5wo3K0qOg8vWSBSpEuRV9zonztOxcY+WCxjC6Y2ihJq2H8Z6uNLpXcyM5ZwsXz6GFrWH01MgNCfkMUxfpVETV/dihCJWs77/6iGqgzXBQrgNfDm4aRhRhoyDpSXVUcjznnIZCExY5zLyIJOimedbsghCqcyVP8JC9Q+I++D7Q8mA1MvlpG1RDpNB8ljWbX3GO/rWnWIsQrFj7Ncz4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=rasmusvillemoes.dk smtp.mailfrom=foss.st.com; 
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbNq5WwiVn/QuKq4lw8qw4zMzZ2IwEMzJgsB97S6UQA=;
 b=XDeQWqdNGZgOX+I21MLOvyRFImWD1vODLwI+vUmpmlkfDCQpft+SEy6mjR7a5hHgR6BMS6PLQFJ3vlaJlMA8Af5VACNWMbyRnPoI6ZfDmkTvSt0Jc872oZ2Fv7LRoDPgIoghlS5DYTb5/bW5SQ3SL8/DCHfGIweB6tprM+bP8+zlvoGNhCaNP/BQYaKio9PNueNMCCb8fX82jT+qXaop9kt8rcH2sVSDHIps3iD66+bkYBVoHtyp6xPNcAmWnYn8S41O+fcH5UnIwA8EnWR+Cgd9sH5HoHkOv/8czvl6kgoO57dM5YcBZD/vNKSbTei5At3n1r4ZbIbXFNEFAbyRcg==
Received: from AM8P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::7)
 by PA1PR10MB8871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 16:06:51 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::71) by AM8P191CA0002.outlook.office365.com
 (2603:10a6:20b:21a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 16:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 16:06:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:11:10 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 18:06:50 +0200
Message-ID: <ffb0c593-c829-4da5-bdbb-f9d1096358be@foss.st.com>
Date: Mon, 6 Jul 2026 18:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
CC: <u-boot@lists.denx.de>, Stefan Roese <stefan.roese@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
References: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
 <si6XBH4Bxhdlhio2J4oJEDmHBeZYLa-W8YwddESQB-JgOw43EpfwAPNbrY_dFeXyeUQtW-xV6Bi8nSRc9IDAzA==@protonmail.internalid>
 <20260703-optimize_cyclic_run-v2-2-81762cff0b17@foss.st.com>
 <87qzlgwktz.fsf@rasmusvillemoes.dk>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87qzlgwktz.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|PA1PR10MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 111c3b95-f181-4453-e420-08dedb789741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|18002099003|22082099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: rHFaOiCXqyNA2P6/RG3cdCFqkQBTBYaYBq8tqJQ/S7ILHTRkcABLtlTakph1EKve4ZcynjVNd10NG6ALwn+PpY4zUzevRPQ3u8oVkD0no/XSFimSrI4qN4XA4za16ciQI+QsPabNbgieDkBTi78nBrtcPcV7NL6O1oX7Q6pycHfQbQ4KnqHhX24W6iorR+latXmvoWGC4ZPnK90cpaSvr00dLTzEopwIXisoYRRBzH/Vcr4hPz91ARIpyl7ZQ7OPJRkKsPjT1y+skRZI3SULNFciXpJmABSp0ad7G8/GwI7xl4WYSk2q41DO4C5qb5uspC9nRvS2In0Q+ItkMJH44n6Vn8uwmtep/ckEBanko48bd7MtunnWgqNhtLnvbvmOEoX4AHs+fs/+XjJoLjKHzQu8ij+kWd7AHAvLG0jAg5DwzhKxVlLO5WDu1wJm2hUvTu/HjimUTIkRTrFwpfRYLrIp1nk7Usbm5779un4IAES/An7UIu0AMjTep+0pPhDeDegfMttWT0NB1lVPf0fEvMDTKaH8wZwO0nLgDxDrDBXykPGYsX8ny1wTb0gf6rwYnKn2S4shqcDGSe7bmbP5k3Zrq1Ny70sV6YG5PfiNZalwKBzgYQw+lnXzc8ptvZAGGgUHI1htfYih7goj2tbA3fByJHL6MPrTZpg2JgF6Zte1QhJUYHDzexdupJs+Rc3w6xMM7p+SFrSOBPtCChN2lA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d4QGrUJKiW88+7B/uq3NJH+cAt5UtjuqUR1kksh/Npqw/xzhNRTOFnN7fjEh1CxoAQi5kgYXS+6kk1dXFKAQ2wQg0BisGafezudwz6FldTJi3g/8gAAfR2xSYkaUlafjdbw3W4uSI6ws0qPK/fZWWq4jUuISoOr5d7w9i9pCt409viA/wIbYGbeAZiZ4KB5x+QTd3q6IBH8WWhhGUELCg0Cb/jCRaOJ5n5SOUn5MNB5J11KVFzXXPbshbP8mVbGQuqLF/xOR2YxehXrUL6MOetReksKe/Z7jbmIjgj5A4AtEFLd1xE3IsvHMJbikeT+OnMsR7rfWYxsYXsn+6m1eSon6zWh+JtvtQVzVUJzHyMXr0+d0SIrbNgR8jo1uI6zzXdmx0tuhZJlcklwc9rN5UQIsFqRuDq0R7R0C7ekr2lHJSMvF6foXhDUPfBAB7d2N
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:06:51.2537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111c3b95-f181-4453-e420-08dedb789741
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8871
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



On 7/6/26 11:04, Rasmus Villemoes wrote:
> On Fri, Jul 03 2026, "Patrice Chotard" <patrice.chotard@foss.st.com> wrote:
> 
>> On STM32MP157C-DK2, when using the "ums" command, in sleep_thread(),
>> ctrlc() is called every ~640ms which doesn't allows high reactivity when
>> user press CTRL+C in U-Boot console.
>>
>> In sleep_thread() loop, ctrlc() is called every 200000 iterations.
>> But schedule is called on each loop iteration.
>>
>> Optimize cyclic_run() in order to parse the cyclic list only is the
>> next cyclic to run is due.
>> During cyclic list parsing, save the nearest cyclic timestamp, which
>> allows to exit from next cyclic_run() call if no cyclic will be executed.
>>
>> This allow to save computation time :
>>   _ before : ctrlc() is called every ~640ms
>>   _ after  : ctrlc() is called every ~230ms
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>>  common/cyclic.c                   | 16 ++++++++++++++++
>>  include/asm-generic/global_data.h |  4 ++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/common/cyclic.c b/common/cyclic.c
>> index b37cd6d8ff0..10ea0711ba1 100644
>> --- a/common/cyclic.c
>> +++ b/common/cyclic.c
>> @@ -68,11 +68,17 @@ static void cyclic_run(void)
>>  	struct cyclic_info *cyclic;
>>  	struct hlist_node *tmp;
>>  	u64 now, cpu_time;
>> +	u64 next_call = UINT64_MAX;
>>
>>  	/* Prevent recursion */
>>  	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>>  		return;
>>
>> +	/* check if the next cyclic function's timestamp is reached */
>> +	now = get_timer_us(0);
>> +	if (time_after_eq64(gd->next_cyclic_call, now))
>> +		return;
>> +
>>  	gd->flags |= GD_FLG_CYCLIC_RUNNING;
>>  	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>>  		/*
>> @@ -102,7 +108,17 @@ static void cyclic_run(void)
>>  				cyclic->already_warned = true;
>>  			}
>>  		}
>> +		if (next_call > cyclic->next_call) {
>> +			next_call = cyclic->next_call;
>> +			/* move this cyclic to list's head */
>> +			hlist_del(&cyclic->list);
>> +			hlist_add_head(&cyclic->list, cyclic_get_list());
>> +		}
>>  	}
>> +
>> +	if (next_call != UINT64_MAX)
>> +		gd->next_cyclic_call = next_call;
> 
> Are you sure this is correct? There are at least two things I can think
> of that might be wrong:
> 
> (1) Doing > or < comparison (as done in the next_call > cyclic_next_call
> line), that should never be done, because the logic around timestamps is
> that we do allow wrapping, assuming the two timestamps being compared
> never represent absolute times that differ by more than what can be
> represented in the signed version of the timestamp type - that's why the
> time_after*/time_before* family do a subtraction and a signed compare
> to 0.

Ah yes, agree

> 
> (2) What happens if we have a single cyclic consumer registered, with a
> rather long period (say 1s), hence a long time till its next_call, then another
> cyclic consumer is registered which should be called every 50ms. Since I
> don't see anything added to cyclic_register(), it seems that the new
> consumer would be ignored for almost a second?

You are right, i forgot this case

> 
> I'm also not really sure what the "move the first expiring timer to the
> head" logic is supposed to achieve. Either way, if any timer has
> expired, we'll run through the whole list, so while the first expiring
> timer would then be handled first on the next cyclic_run(), that doesn't
> mean we'll save any runtime. And this exercise seems to be about doing as
> little as possible in cyclic_run(), so can you explain what the pointer
> juggling does?

As suggested by Marek in v1, by putting the cyclic's callback with the nearest timestamp
in head of list, we don't need to parse all the cyclic_list entries to find the next cyclic to run.

> 
> I assume that what makes cyclic_run() somewhat expensive isn't actually
> running through the cyclic_list(), but the get_timer_us() calls done for
> each entry. Could you try to see what something like this (entirely
> untested, but you get the idea) would do:
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index ec952a01ee1..2616c4d5bc6 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -67,26 +67,28 @@ static void cyclic_run(void)
>  {
>         struct cyclic_info *cyclic;
>         struct hlist_node *tmp;
> -       uint64_t now, cpu_time;
> +       uint64_t now, after, cpu_time;
>  
>         /* Prevent recursion */
>         if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>                 return;
>  
>         gd->flags |= GD_FLG_CYCLIC_RUNNING;
> +       now = get_timer_us(0);
>         hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>                 /*
>                  * Check if this cyclic function needs to get called, e.g.
>                  * do not call the cyclic func too often
>                  */
> -               now = get_timer_us(0);
>                 if (time_after_eq64(now, cyclic->next_call)) {
>                         /* Call cyclic function and account it's cpu-time */
>                         cyclic->next_call = now + cyclic->delay_us;
>                         cyclic->func(cyclic);
> +                       after = get_timer_us(0);
>                         cyclic->run_cnt++;
> -                       cpu_time = get_timer_us(0) - now;
> +                       cpu_time = after - now;
>                         cyclic->cpu_time_us += cpu_time;
> +                       now = after;
>  
>                         /* Check if cpu-time exceeds max allowed time */
>                         if ((cpu_time > CONFIG_CYCLIC_MAX_CPU_TIME_US) &&
> 
> Because the time_after_eq64() test really doesn't take anywhere near a
> micro-second, nor does fetching the next element from the linked list,
> so using the same value for "now" until we actually do hit an expired
> timer should be ok.

I tested your patch proposal, and yes, what cost the most is get_timer_us() calls.
I obtain the same gain using your patch proposal than with my buggy implementation ;-)
which doesn't, moreover, cover all cases.

I will submit a v3 with you proposal.

Thanks
Patrice> 
> [I also want to move the computation of the new cyclic->next_call to
> after the callback, so that the callback can update its ->delay_us value
> if it needs to be called at another frequency, but that's a separate
> topic.]
> 
> Rasmus

