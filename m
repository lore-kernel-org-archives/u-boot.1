Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF0DC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8CE846A4;
	Fri,  3 Jul 2026 11:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jkCPWiQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC7584832; Fri,  3 Jul 2026 11:55:24 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD223841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1A4m46KzCixCAcDYWcxP1N/noe5Uqsm3GmibXCwAOoItd33G3HuMmD2o8j/zL0Wmxb1IZnK+jRQNQlnrJhASTcj80bRxM0TDUbXeHEZcoNT60IW4kR/KN7tujdvIBfB65irMOuPFaIoCsarTtOB/a6tBN5rOYRAnbcGNvKOWQIdmlFkpFE365XslHmwlgy5VCQagTPTMOL+D+CE2NQGJ4svWJoTxapnVnfDBnZ3T7zsXK7M270qFMwvXqycLSwqOsIDNJethSZa0qgPGgJLIuf5mws5ISRqsVZwjRloRe8gJB/ImTkOy7xpqUdgKDv2OHbm9MtRAhwFAl9SHk54hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PNhUxlLo4N9vB6c5Je1Q2fzDqd1nOnm+KUHg1soMmA=;
 b=Z3zn2qgVrU2n4rbz95ZiMyRNvba64fqwQS7735V7f0RMCBqyFYT0a4qT7ynDYMg7ySIaveTSoUHW/7W43OmSYFD7XkiD3tJiy6Ze4/EdlpAC6478sYsRI3iOXGrEEMlZgW01pBjyhRHDFD+jbXUVJxHxn+1z9DNrNuNEUjeI5Fdj91dBzL6lupHG4SG2jkepV+Lw3UssQPLWHHGmW/FR5QfsLdYkawTwyQL6uxghyCR6cyi6DfAeu/hYrWIdgLm7mJ66YHFzAT7XRqSqFnom330w4m+mklCisBbyt8znYO6l+V8YaMzIPKTwuMswv2kIipYVd5Ayq0hnO4gsSqFjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PNhUxlLo4N9vB6c5Je1Q2fzDqd1nOnm+KUHg1soMmA=;
 b=jkCPWiQSZ90V2VDRB64BKcZHxcuFjAXD62X0/MlvDOIDpe2xpOqmz74z/s3QeNrSrwfG5JFQtUa4EuBTBie7xvgON40WIqLhlPRyL0MTIY87Uki2ZnSF2VLjEaiCGztaAsqoi3CsA5zOafJItGCdvWttmn6w3Wc5+D7iGfDoAvWKnJJp9WEh0pY9gmhwoZ2aJzkAKmq1KKl5XpvjfpfWrVEuhalG23sGuenqcoOJOBipISsXF/2MWdozkmoigV+Bg3Tf9f05CCrjOkohyqCICwl6vtY58LLjX8lgqHbYcddePrD7RlyG8C7wTZLXilR5NuRdILHPQw2o7FC6hK8CJA==
Received: from AS4P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::9)
 by DB9PR10MB5617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 09:55:15 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::2f) by AS4P191CA0019.outlook.office365.com
 (2603:10a6:20b:5d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 09:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 09:55:15 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:00:01 +0200
Received: from [10.252.26.28] (10.252.26.28) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 11:55:14 +0200
Message-ID: <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
Date: Fri, 3 Jul 2026 11:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|DB9PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: c56d3682-b417-44ba-56eb-08ded8e92e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6JtHJSv/lsarOmn1lvMvAGqaQ6dfFeCFHj3f9xKuK26mfBATMsY9cd2E7kVWzFF76dA2dp8q9pY44skHuVDuAIyvDEnTyCn3mT8b8ETdZTWl2+ooqUpm/ZOTZLjFESHn7YC98kFNF3D0/xWmD3f4w80Jx7sF4zfQrjdxS1jt2HN5r5DlxmBUrBblms1fJFXvAmYaebx8bJJkFQBYgeeJrFAdhw91bqT+wKHOzjfQ62O3LkmuPsdvjZveMtsopy/MBcVeOBR6PHzWL/SGbrzNV8nMMoJ5OzhTvH8O+lZo2SXh7axrcqiJYw0/tAw474VjBkujlUZj3NXhirbvVm4WhIHPNeL3caW+zIyX4mmXlMq9xF5nHAy02cy/ANUjPdvXqIQM6snDvR1NRiDj1Hy7P3Bu2A8lFwBMI8lpatbuzUDVb6LES4GIqzB1M3ppXmDaQS4caq7EsTm4vmMizG6gED0kawq3zz442hfu6vKJ6o1Lme/Vy32fKOoLyPXETw2n+mDKv3x/vubvjBJGjcje0CvuGbqqUtcKNMyxW+og7SOu8jlJGz9m+4fcquxBXT0WHex3zqwgivHBZkiCCNPpcQFZEvZ4FrHaHutKVgmmDVglr/vRW26ENjc+acpGmTauJ/pT6djFAYxOMxnuOrejw3V4t9i3ehSfufP+JHZ8i72ykAyhPKR02HTR9yb2cdS14ixBWiiD926lJEQoqOFL2w==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g1RV6qwZsvPSwGMgT73eZKoK+uIS6TZE4sNyX/kkpxHPrvbxZaV7rtCu4kqXh+xMEyVYHzRG++YJVb36D2/pWaYJ8LHJ+DCQmYQQDN8dDYmA0aa6wgiLfiZ+8hqGt1jYqm+9D5TS3kwCTelngq3c9bXi1an20TIvuxwVT5hHmprG40Lr3T7vBCFnsBorACELiiBd9gp4z27mwTqiUfYuxaWbayFl2d2sBs3r8IDbmESTvSlZHnunglHthtrQJTRauTotepqzx1mmc8BXEZlfYGPSpOOWYMQyhrPrFjJvHNUp+J7GsmssqDByLPwBmkIJu43GPSBOzWJsbFVH21jRezc24VKVlwe8jiu37ud8vbWdztBiMTo/IA0fOfyz3eba5hfWo3y2p3fgOQvmoMfXMKRWPiJcW+EruqyUDoxASSMveuP5LPM8lBMqq/kU+FxG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:55:15.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56d3682-b417-44ba-56eb-08ded8e92e83
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5617
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



On 7/3/26 00:10, Marek Vasut wrote:
> On 7/2/26 5:24 PM, Patrice Chotard wrote:
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
>>    _ before : ctrlc() is called every ~640ms
>>    _ after  : ctrlc() is called every ~230ms
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>>   common/cyclic.c                   | 12 ++++++++++++
>>   include/asm-generic/global_data.h |  4 ++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/common/cyclic.c b/common/cyclic.c
>> index b37cd6d8ff0..714d6863d5b 100644
>> --- a/common/cyclic.c
>> +++ b/common/cyclic.c
>> @@ -68,11 +68,17 @@ static void cyclic_run(void)
>>       struct cyclic_info *cyclic;
>>       struct hlist_node *tmp;
>>       u64 now, cpu_time;
>> +    u64 next_call = UINT64_MAX;
>>         /* Prevent recursion */
>>       if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>>           return;
>>   +    /* check if the next cyclic function's timestamp is reached */
>> +    now = get_timer_us(0);
>> +    if (time_after_eq64(gd->next_cyclic_call, now))
>> +        return;
>> +
>>       gd->flags |= GD_FLG_CYCLIC_RUNNING;
>>       hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>>           /*
>> @@ -102,7 +108,13 @@ static void cyclic_run(void)
>>                   cyclic->already_warned = true;
>>               }
>>           }
>> +        if (next_call > cyclic->next_call)
>> +            next_call = cyclic->next_call;
> 
> Can you move this entry to the beginning of the cyclic list, so that the entry with the earliest deadline would be right at the beginning of the list ? That should squeeze some more improvement out of this I think.

Hi Marek

I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.

> 
>>       }
>> +
>> +    if (next_call != UINT64_MAX)
> 
> Can the next_call literally hit UINT64_MAX in that one unlikely case ?
> You likely do need a separate flag, bool next_call_valid, to avoid that edge case.

In case, no cyclic has been registered, we don't parse the cyclic list and next_call stays set to UINT64_MAX
We don't want that next_cyclic_call be set to UINT64_MAX, otherwise in that case, we will always exit cyclic_run() before parsing cyclic list.

Patrice

> 
>> +        gd->next_cyclic_call = next_call;
>> +
>>       gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
>>   }
> Thank you !

