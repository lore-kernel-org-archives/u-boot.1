Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A239BC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306E4846FD;
	Mon,  6 Jul 2026 17:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cg+SCS9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574F7848D2; Mon,  6 Jul 2026 17:16:34 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60DB846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn/JsgZANhVt+aVR1Gd2gJp8lTu/xXSnHh87D1Vj+opPsxkeu8HnNzjwCm4suKVle902mr2rQJMSX5+3wSD7kwaRdVlo0l+69cyMzNFke8w75Bcb0TLtX0yl+UCzZ+0js0qekV11PEIqNq+l4hG5EhmTZ+UrcOHTtVBhhUeOspe1TJpvcPmOH5ijQrgm8HpH1Lqg4WGaZNOtTt1nY6EkkKUcSuQIvuBcf1GmwaCZg8gEri/4tB3op8yIQynYG6TNVprcosIr0Os/YZ4tO2O8oVvf+BXyo8gHoFlS7jQGgsVK8w5tjOofrf/BlthtezD7qMW372CVllVH7WlsepVRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Q9TzOD8/u5Cfkuqc0LmabhVRBGoc8V5U5vszmRV/s=;
 b=XcX89C15MrmSFUep1Goq8aDkfL0fjFGdY1RsQA/Ua/fi9zCXx95FN4+XPlCRiVvPsAkTNc7sRxyE2m1Z/noskMdawtj2FnRs0bQ2QvTQJ5ihqj5Gce7Ug8g3AK2WO7PyO/koojbecOex4BfMQw9PrdO6h35KxNcyv+zJYKf8zKG5fdZG1vCzRTmT6oV7uGsMcHdGu6CItzOlJIh/XX2WrdvhaBx3ZaMu7ddwFzxTEGsAHOX18gAJTxcLJK/Mfic34unjUNhHB4dAa1WZWZB/i+Fo0/q9wlWGMkrTiGyF6NU5JRNaibu63+WymEY52KnRSBCH+Coynr2rPtWPXpxRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0Q9TzOD8/u5Cfkuqc0LmabhVRBGoc8V5U5vszmRV/s=;
 b=cg+SCS9Op3nLrE+M+KADz4iC/kKh2tA5coz3fomglWzfGDwv6nm/mf/s0MGa624bs9XiH+fIu0dp5hxA+53WVn2DvlbnM/lNWturdaSPRQpLskUUKXdLI8+mwyAMADfArgf5ueG6neu42tq57y5marO/GwX+BuRI66RLZdKd2kbTQdpghStxpiD0jpAEkLvaHrLrJEeoP6zc3VxxwHufjaDeUTKSfzreghWG6vVLcjvo4zXuHLxI4kw2SN1rMZgV/ec7JDL7NMkdmxpsur527RJFA3iTRG7xWt2LoCDLATW/dnGwWhqlnQ4OFVCkvy1UPthw+x+8QB0kG4IjNO575g==
Received: from DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) by PAXSPRMB0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:232::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 6 Jul
 2026 15:16:27 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::1a) by DUZPR01CA0223.outlook.office365.com
 (2603:10a6:10:4b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 15:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 15:16:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 17:21:15 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 6 Jul
 2026 17:16:25 +0200
Message-ID: <13f510d9-6b08-499f-a6c0-f76484488899@foss.st.com>
Date: Mon, 6 Jul 2026 17:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
 <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|PAXSPRMB0004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c598f44-b968-4b98-7805-08dedb718ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 91qDY1XgCKAe0+k5KJ1J31ly3aKf5BiGpOf2/Xgcp5MXtGM5HslGb6RU5WBvAmCSKQ0x/sM1c/sJuudyie0Ra16rdi1EQzYW/WojDeBBuZwEzunlwRLMKFTj+JoxfothL3lxX5+TQIjFM2G27H3F0vMJ8yz/+lo7cLkxsRbqQLEefE7cpqSCMJICXGAwzr915xnUpm5J86Sutm6SDXG4j5cVWFAVZ5KCwdmHdbdTUErjabJGKfWCgZxT3oIwLnhbBaSsXSHZdoUkRvP1/SLx8Umdszvhj51CNv63yC/hUQMwHTdKdAxE0oFxccKtf2mvZV+5HFovdjiHzueL8dfKlBfGMgjQR26G/70OVMksyTun1/hxEl0rbjN+a2bjLByLN1m79n1BdRGotAAQS2zASbyjK6k0J98I4RK41VtBv+ZipEMf/7UpPs69TljoDa9AeXjIa9FmUUYRFp7BhT8QQDh2gIpO7SCcvVd8f1QVPJTxer+vcBSbA0t2T/9fHlDYPGONvghNT6hLgmgWQsmrSjVlDvFJMjhNESlOo3FPQ7EXAcf9Sx1DH0j/MWzmlIOQP6T4SKbiJv8G/zYMwplOmJYEunRQ6euXZw8xbgcqDGBX0Kq3+yupWimBy1RkUxER9mwFKlFO386hKTnKI0SQGOpateOBxrnfozDU6X398GbPYJsNmQ8CnWxUbjPt7OLwA5KEiuHiDe16JXqeCjh1Iw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U5uGujyyGKJtDDE/Ykru73VrULp0tG4AuWPnEPsUfuuUS998U0hRmF9racfKSMydMwKU8ieEK6+BJPglIIlEkwYVrVU/J8saOCxId6oOz6p6C4LG7YVRG6bo8HC7Cd9FwD3Pv4eTVQKVXeE4pZmBMm47ZRZwxK/H6SWB0cyH6FYbK/nanta6qanqZt8noF20ghzHjDG9KMbl+IsuXcuGTFAaY4Mkeq7wmI6wmWn9QDAN6FC03yavzkuJVGyDylWaoN7oa+mocnkldzan4KdCX4MNJj56A9v3f8yOev0ZTBRl1RS835z6P/fII3n2FCCZBCOuvNNMR/eW5zrbyMCJwvSDg40ypBoGetivd26+Vg96/EPWZOMfNgPPgaybGWD3Gjc13wK3MF3SPu21drROgekd7LVYVGKj85+1fbnomwub51yVNxz3V19pYx0bAgKq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:16:26.9659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c598f44-b968-4b98-7805-08dedb718ca8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0004
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



On 7/3/26 16:38, Marek Vasut wrote:
> On 7/3/26 11:55 AM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
>>>>    +    /* check if the next cyclic function's timestamp is reached */
>>>> +    now = get_timer_us(0);
>>>> +    if (time_after_eq64(gd->next_cyclic_call, now))
>>>> +        return;
>>>> +
>>>>        gd->flags |= GD_FLG_CYCLIC_RUNNING;
>>>>        hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>>>>            /*
>>>> @@ -102,7 +108,13 @@ static void cyclic_run(void)
>>>>                    cyclic->already_warned = true;
>>>>                }
>>>>            }
>>>> +        if (next_call > cyclic->next_call)
>>>> +            next_call = cyclic->next_call;
>>>
>>> Can you move this entry to the beginning of the cyclic list, so that the entry with the earliest deadline would be right at the beginning of the list ? That should squeeze some more improvement out of this I think.
>>
>> Hi Marek
>>
>> I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.
> 
> Does the list iteration exit when it finds the first entry that is not going to be executed at this time ? If it does not, then there will be no improvement. But for this to work, the list would have to be surely fully ordered in incrementing timestamp order, is it ?

No, the list iteration parse all entries.

I see your point, on original implementation, entries are not sort by incrementing timestamp order.
I did some implementation test, by sorting cyclic entries in cyclic_list when :
  _ registering a new cyclic callback, put it directly in the right position in cyclic_list.
  _ in cyclic_run(), after running a cyclic, compute its next call and insrt it in the right position in cyclic_list.

There is no noticeable gain.

Thanks
Patrice

> 
>>>
>>>>        }
>>>> +
>>>> +    if (next_call != UINT64_MAX)
>>>
>>> Can the next_call literally hit UINT64_MAX in that one unlikely case ?
>>> You likely do need a separate flag, bool next_call_valid, to avoid that edge case.
>>
>> In case, no cyclic has been registered, we don't parse the cyclic list and next_call stays set to UINT64_MAX
>> We don't want that next_cyclic_call be set to UINT64_MAX, otherwise in that case, we will always exit cyclic_run() before parsing cyclic list.
> Consider this:
> 
> +    u64 next_call = UINT64_MAX;
> ...
>      hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
> ...
>                 cyclic->next_call = now + cyclic->delay_us; // = ~0ULL
> ...
> +        if (next_call > cyclic->next_call)      // False
> +            next_call = cyclic->next_call;  // Not set
> ...
> +    if (next_call != UINT64_MAX) // False, branch not executed, but it should be executed ?
> +        gd->next_cyclic_call = next_call;
> ...

