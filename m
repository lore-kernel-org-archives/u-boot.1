Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD21C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9067780B6B;
	Mon, 24 Aug 2026 14:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bluSBzL06TTT; Mon, 24 Aug 2026 14:59:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787583567;
	bh=sbI4wzBj/85vfxjb5EESelZfShn5mujC0Uk8UGi/rLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uorOfueqmfjp9QfIrkOcq8MhNo3EgL87ejrNVVEKG2yCUyv7KYML29+KBPaf/oNXF
	 +OnqGRcONLcQNUSzUgmXVDgf5eSOZc7fEA6opZ1eC5bhhHvSz/tCB2fnCCqz2KUVW6
	 QLJy7oi8EMfUn39lHbv49wE1ql61tpAhWf3DKtHTfPmjps5hhe/VZHpIRvRsPS9Nku
	 SYBDtpHF8STNpjagOo2EQEiitlbBGHNyNTaI6ocA9Q+206Z+DiGPpLbC/Xaa9mbpsz
	 lb9ENN9AUgAwMxYixxN8N4Vr5Cjr+S+vAqDKqvuCNdiIdnQErgso5JwyAp8S6/+cNq
	 tmgbNOCCOzRlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BA8180B7D;
	Mon, 24 Aug 2026 14:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FEA9396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8627960618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xwhmqq4hPQZ for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:59:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IwRNn9MY
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2812605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvH5m5Vs+z5xnf8d54gAFI+GKnx9E4Shy6xgURHFZdDU5G56bwFWJteWu+c70ni/h30KshJeXrbH7lVkhGx/H+sOZ/zZGuPa1DYOpe9EAIQQQGQ4TdZcjp053e9IY4JiCzPHaFeTKfqX1vuMjeqDcwCkqNqZNHKulu9hQ7Sa3NnMEZWJP1e6nWog4VDLTmwW8JN8wHV0o9y3fQENN6x6ng8Ze18V8/FeweLqMqJePoIhFe9JtN2ueFzkgEBhDfXDNQ4emY3FApcOMaLX4DeY18paLwKffEUS/CyXOi5tlUKmSILDkHabRhDQbr0njhSouj5r3/gsXBmr1WUEaRzgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbI4wzBj/85vfxjb5EESelZfShn5mujC0Uk8UGi/rLA=;
 b=tQGt6mOQWE2i7/nND4znnuuKOhnrGd759wzQgjtqiLPWJalFfLCeKIM2EHqznfOi4c2zygu1ib/mabeVHNUaez013iUYpbZdgzz5s1oxnHUCiQ6cbWueD1x4GkloDHSsfs1wES8mBupmSJ/SOSd2jyE7cDchkvzLAR7WPJ5AzN4qfJKHwcMtDO0gVXRJdg3Drz11aFhvyNdAWtDTFWRus9/xzwrGKbXa5SDQ39nn6Zz/4esY71mU1Ix4mZmlWRrTsoA9HqEZZGXk/gidAQXWE6DMHF+B/93QLvPzhWN2fy+kHw66dwIrbQJXLQ+EyOjV7iXD3iZXf5yVE7ZH/F5+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbI4wzBj/85vfxjb5EESelZfShn5mujC0Uk8UGi/rLA=;
 b=IwRNn9MYpBhp8vZ1lZkYTzJWuhbxoaTODfEB9bonxqARwVO1PyFfRIzXiWqjNiN4p6wP4d1LuXc+SXAl6rYUIX+FqiYu26qVqIAZSOY8Z2NnKoSP1R7+7qllowiCiVDMUTiWYkkrIl8HtZP+5X1rM1SCJd7MmlubFOfENrSwbPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 24 Aug
 2026 14:59:19 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:59:19 +0000
Message-ID: <46cb58c6-c767-4313-b3ab-b9c36b7985e0@amd.com>
Date: Mon, 24 Aug 2026 16:59:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Initialize num_banks variable in
 dram_init()
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>
References: <20260820033422.2967698-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260820033422.2967698-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c13e732-0d5e-404c-8a02-08df01f04686
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mkznbSkxuN6WvAVIR82+MpiZQUQgBb/bW09QQODqE3daTR+Pt9evx3/KJgxPJFfNujaRkWfCyiwyxXon1SbgBU5hEx7xtMHl98hgK9I3iE4YYcYkDFarQP2PJKrwbWtnOxsBgLrqFBcSoATRNfb5I3tEgqf4OAkM2gZvD0w9pcLETtRYz6949F+pLS+OlKYXdbJcKv1QrqpTM+stJwtbYJKx0xZ4NEgAtmniwqdCHOnuskKMi2oN5++lhLMf0pKuR16VESbnIcb84XfY8zmN0Ql9BWll0RX+tRB301RwhoStrm8U6KzYqYUCXpP7ZPM5i1VizRYLyKGx9LrosSQ2/0vygvYBBDtRVUMrbTjdv+wrV8dlgTUAn81LjGTYoBr4nuXAdr5smyzVXQz6jY1AuzjGU9pfUptBT0hNKiPny0/mYT2Jtf/UyyHCS3exTcZL/6cJ8379eqnFCHpXM+lEyXIb9L5YC0XjDZ5ylAQF5hAUAOzadZo/59tx5HGA4P369DNHkE635j0brUE+eK1Vq5pdq0oUfoHBSzW90P8tjp11wjFkL5rIy0GvY6ZQkXq/6uj7pc9hJv+FhZjsHDdWSy8nYuco0AIQXb96qRK2qNVy7cXzvWMvdaH739LkrOB0J41eO0xypgXuYAhXQuFHsaR4DgGCrx8Vwh2u35IMTIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWt5Qnd5SEdieVpRRnltbUhIMnNHTlA4MGZ3TDJQVFJhZ2ZESU9nb1d6UDlX?=
 =?utf-8?B?OTV6NXhqWVZ6MHRUVEMwbkxrQXUvaW1xNVd3eGQrMnNsQWdFdkh4ZFRYSGFz?=
 =?utf-8?B?WjV4V21oVXgrWFpKeGZWQkVFTCt0bHdUQlh5cVNSSzNNNmlhZzV5eDdKMzRB?=
 =?utf-8?B?T2lPaEY4TTh6bEZPeVdJMlVBQkExL0pNdjNqZ3lDaHdML0Q0K0pZb05OK1Zr?=
 =?utf-8?B?TWNhKzkwenVLRm1ncUgzUnI5N3NLbXFHaEgzNThyV1dWVzFWSERtbTN1WEI0?=
 =?utf-8?B?OTdjSjRrRTBuVlJCdHhGVWlwcXVreGgvMURRNkZKMGN3SlZMU2lwcVE3Snc4?=
 =?utf-8?B?bFE1UEhPRUVKaXpnK2djbGdWazZwSU5qS2krd1p6MDRSdFdEbDdoL0ZRRG1S?=
 =?utf-8?B?d0pmdml4b3ZHSTY2bUU4N2dTa3hyb2dSTXhSNEdzRDQ2cmFNWFEvN0hvc2hw?=
 =?utf-8?B?UHJBN2FYaFc0Y1RaRDg3ZjhaZUNsOHlZcTdIejJsM2xGMDEvUGNhMGlURC9j?=
 =?utf-8?B?SEQ5blE3MERISHArM1Q1RWFVT3hJTWJsaVh3SENzYlR4VWRjNm5aOGdiWmd5?=
 =?utf-8?B?ckZVY1R1dmFnWW9xNjdzRzlydUNZcjd5ZS9aNGE0MmR3T2FranJJc3VzbnM5?=
 =?utf-8?B?WmhIWFRsZFRmMHBFMG5wdm1ZbzVFVzdjYitpZDBRYUU3ZXpJRURqbWhnSENH?=
 =?utf-8?B?S1FKU2pkRlJqSWVqcFM2SlZaUVpBaWhrYnZDbHcwejcyeTdBRFVNMkE0ejVt?=
 =?utf-8?B?Tjl2cjg5WWJIQi8yYWh0SnJwaHBKT2RKY0VsVGRkeVdjTmdCYXhFMW1BMTBa?=
 =?utf-8?B?SDVsV1l0ZDJSUTM4MjlVWVdNbTB5RE8vbjJHdm9NVVNKalAzT2N2eHg3M2Zo?=
 =?utf-8?B?Yk9NUHZqdWxVVVo4VlVVU2EyMUVwRkh4TUxRaTkwRFo5WmZvcmJndFhWOEV0?=
 =?utf-8?B?bHFPTkcwRmxxZXhqRy9ENUlDbDVuc083ejVibXJZR3p2TWZkSnVrMVZzT0l4?=
 =?utf-8?B?ZnVpcUo3ZDYrT0MwRzJVMjN5R09uU0FsdDEzZ0FoWUI2RENzVW1vMmQ2L1Jj?=
 =?utf-8?B?UTBFVGhWUmtaRVpnaG5vazhwT1VsODJ4aTJFUDRvcURxelU3dXpMN1FPR2o1?=
 =?utf-8?B?eU9udHZOU3J4UzZNUTA5TDR5TXk4RGhxYlpkS2FEd0hUaFJmK1RPaXFmUG5r?=
 =?utf-8?B?Ym5Cby85WlVsZDA2NjFRbTlZbUhFZTRSRkZ4dktXZXZIeUdXQndFeGl4RVdX?=
 =?utf-8?B?UXZSald6SFg2ZFpNUllDRmNHYTBrbVFabzUwZHY5TWJKT05pa2h3bHRINjVw?=
 =?utf-8?B?aktRYXVNQ0hLdmNma2Y1aG1iRWVTT3ZZSWF2SjBqTFVVUjRJcnZvY2pFOWwv?=
 =?utf-8?B?cjNrY3grZWFUazBmSWRFQjZySUNHMTFjS2hwWjgvOG5QRGZORm1XMWhaczRP?=
 =?utf-8?B?NG8vZmFsZVFHN0F3cElLZ3Z6R1FGQlZ5QmMwYkVSVWxwV05pUE1aNEsxYmNa?=
 =?utf-8?B?MWZBWGlnVStDS0xEaWIzOU9oWkIvRnNST2hzNGJpZjZEVDVnZG9aSmloZ0Vs?=
 =?utf-8?B?SWdHa1AzeTVJa2NmeWpIUnNCbW1OeXlpOFlNbDB0SzRjTVdwbVRiQ0hMTnlO?=
 =?utf-8?B?Z3BROWVNR1lFWjJUNythSktUcFMrWDZ1Z1hXWDNXb29ESTQ5Qi9hNTJodXRq?=
 =?utf-8?B?a1pCWUZjb0pjZWlieVZHZDVpWXZwWGZKSENyVE9qSUNmdEJjYm0ydUE2dnpV?=
 =?utf-8?B?UG5jNEpvT3VUa2oxWmlId2ZHUnlrMmtSTFJRWW55TW9pVFpmR1daRHNJdWh1?=
 =?utf-8?B?RnJkZWtoNXlBdFltS0tuZmdiVmR6aEE3T1BrKytpdlM1NmpFRlhGYzFPZTlO?=
 =?utf-8?B?YXNJMFNXUkpLdEpubWJRQnM1Nzc1U2lUdDFnUm1KOG5nSU5YelhwNFF6Q2dq?=
 =?utf-8?B?RFBMSTVsdE5ReDVYNDFNRERtb2lYd2l5M2JUQStIN1RJL3crRHZqSkJmRXBK?=
 =?utf-8?B?S0RLUVcrY3BoUEJsTmNZUGVTNWxWUFpIVjdQSThzUjd3TFZ6V0w4SFNGR1A0?=
 =?utf-8?B?NXVjdTBiNHJrdHJ4RUZRU3JmTk9TREZSWktUY3ZUdlNSb01kMVZtL2tIU0ht?=
 =?utf-8?B?ZCtCOUhxUlFPbURQMEQxSkVIOGZPNWUvSmRzRHNZYTFzemV3cGFQeEtTKzB0?=
 =?utf-8?B?QzRCYTlCU1NhUEhtdDV0OWtQYmVoaW12VWVCRmtnOFN1czhDcitxQUUweDkz?=
 =?utf-8?B?SVI0R1EvUUJhZEtMR3N6MXJ5SWlYc2VCeElsVjV0WlVRV294NFl0TUlQajd2?=
 =?utf-8?B?d3ltQ05zTS8zajUreWVyb3BUYkJUemd4S29LOGtYditUZG84bHZTQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c13e732-0d5e-404c-8a02-08df01f04686
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:59:19.8398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD6Otze/guGxBrUHaKrG3nCkNoZbRr5j6AZtu6eyBdhhS+/iZQkfnThQIRTI3O4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/20/26 05:34, Pranav Tilak wrote:
> In dram_init() num_banks is incremented for every detected DRAM bank
> and passed to mem_map_fill() without being initialized, which can add
> invalid entries to versal2_mem_map[], so initialize it to zero.
> 
> Fixes: 3aebac5a759b ("arm64: versal2: Populate DRAM banks before page table size calculation")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   board/amd/versal2/board.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 15b79bbea69..ef6eb1af482 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -262,7 +262,8 @@ int dram_init(void)
>   	ofnode mem = ofnode_null();
>   	struct resource res;
>   	int ret, i, reg = 0;
> -	u32 num_banks, reloc_use = 0;
> +	u32 num_banks = 0;
> +	u32 reloc_use = 0;
>   	u64 text = (u64)_start;
>   
>   	gd->ram_base = (unsigned long)~0;


Applied.
M
