Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD3CD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80261846A4;
	Tue, 16 Jun 2026 11:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="hpynkMxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138A6846CF; Tue, 16 Jun 2026 11:39:07 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1C784119
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/m4O0g4nOmliUftlma92ZrL/0LnRRqdym1/KM8kFADUsnxUJagwwNUqHfZl3/L0W5x6oVb6RnabHGVEgbEK5BetpirVudvbJqLy3awgi7eVyF8ZV3eduArvttH72hHhoIlwMIjWtiiEiw8UQm155gT4KAmPsgfjmipZTZIVZLSSaqzXFcbcyUYjGIMexDopPA7YIEeBxOuSnMNYrx3xobw5NZrrRSm9I1YG9kpTOB7oL1jRpFV7jX0XeOEKwEy0w/kBpJdvIoF8CipM9zUqNr34EzOVICLzdTp2XiTn/2FY9gxfZSj6aXV/5KcF8qNpuMaBCttg0LcwYKQnfaosng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vntu3mHZmk50HdE1BIYCtIPVOShsgzNQUgWdg/MsUs=;
 b=R6sMKqIKnQ8PdQIgdUF8w74jCeBnygtX/una65YKnH0CgKvQ9gTk2HoqWjcvNoN9Sxc413qHH1X3sci5lfjrE3a6pe4jMfEO1ukGQbQqE3VGKpd/vShGvEbHnkCfnrqSsz0gVSpUyf/Mlo/ORQLsxq4RBD9GercXIagpdmenkkabbK7+oGd37o4zsKPWvn7uwP+kXeu2E6EFIP5INkAQ6S8paMHMv3UgE4RIh+x9JMxVEftMlX/t6anusWMBsxuX3XhGUNbAFGq/7zoujUmseBURcUzdDhKtHx6lbtbip/YOmqilZWeWe3AoGdWIaHZTKrly/oJazXeLbNsf+X8gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vntu3mHZmk50HdE1BIYCtIPVOShsgzNQUgWdg/MsUs=;
 b=hpynkMxxfQkSIFX4AgchUrKzcOvtPoUro2ujXHs2smTnEz1iTmw2G8ZfUGqLm/33xpNYMuWZMEKeGzSAgy90N4ywTrOQQ//MDcO5Fxh/Y7wtOAKdWcfN7ifoZz2PWkPBlem6lMURClph/oTThrjPsficnkH3UnQ+r1iwVvHMkos03MRPlsB95v3cODzSUtrHjdFsOOO6U1/8rUJ2aj80Cm/BWpBeoXK6jfdn/rAVJrPtH1hyzI17cXgn8AsBbfe9NPzlpfLhYxCNbbgaJPzjklFhrcTEkOVcjV6pkH3bFS9CLey0HP8caXKcRbmF3w2ZgUpN0wrxqePc1Wm+uzy8AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS2PR10MB6566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:39:00 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:39:00 +0000
Message-ID: <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
Date: Tue, 16 Jun 2026 11:38:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::8) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AS2PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: b0616709-8ee6-49f8-1114-08decb8b189e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|55112099003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 6nYsLR1rBHhDQh5NnjIDddtznPpbn0LAYdeN8pvBun0YUKs/bTTkqo3+e4TTGv/Ox/iecgkCSaqjlETfFAwXZ3NIyGcO8dKm/9FrlGygGY/JU5TM8aBFKA9w4aM0gHI983sNoeOSlWPuFXUBtRfETfZHLizTZlA6xVREScOuWhMkzMpj9OVB/UrXWY6Xb5tzTdvJoa8RMiOz0l43avwIJlAn3YIuz3Ml5NxfHcfWvpXMd4v7+bSvtxf4Puw50JmJPGyyAT/hMJgQZWApeFUx03wH6h/QAuh65ClMVieBBOlCom90jduEvkxYIX22xezNL3Kg53UfJtQ51wr9E8BdUBa9IaBeh5DzKr4OybjnNVUyerh2wr6d7giq6QMslgxM3AY/EvT2J3go6aOiGzU2ubC6bd887lspKaE+Cg66QkcXAklPj5l1AILsATmYTyfKH6BC5b3zMsymHCSQVb71ZUbJVFtJja2LwaWPK1njR9/IK5cvDceg8jlTLj5dGLL9nso5PjX/A0P6ssRN3XxnKoc+pHxPpTVMtPwtMO9D1859eZBipKhxz3rGGilCOpwtu35pUBq1o6NnS13tV9bi0zRDB/Yer0vtvqft6UaA7AWeVxv9gOb0cGDSXzdQsIt/o75DCuqO8f748Wz71kcL5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(55112099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0h2UEFVNXZodHRpQWd1bk8wTVNFWTNwdU10V2ppVXhFaWU0aEovSGU0RE9i?=
 =?utf-8?B?VzdjRXhNZEZ5U2M4NjN3QytNSjFUY09ENHFBbDd5eWdJd1U5S3loRVRicnh4?=
 =?utf-8?B?VDhLTThBd2Qrd1hOQTNiSFdQOFcxRGlyd1J5dlZNRHBKSEpKY2dyL3hDMFlR?=
 =?utf-8?B?MGpGUG11bmFidHNZc0V6dVQ1S3lPZFF0enRyVHR2K3c4ck9DcVMxaVRjNWho?=
 =?utf-8?B?Q2hPdnNEbjhZN3ZlQnZ0anZoVlQxZXIwcnlBUzMvQmxmU2xqc202dTAvenZL?=
 =?utf-8?B?bTVReUpHRmZqTWpWKzFNd2d6OWpkeDF5anFYck9UdDZCTTR3QVlmd2FaSXVZ?=
 =?utf-8?B?bGRHNkh5Z3JvQnhMTVYvQ2M4TTRjdWg5TGkzdVZ5T2kvNCtjUExGcGIwUnRU?=
 =?utf-8?B?NjBpYnNoU0VvQXk5S1lVMVlyWm9mUHVGN0JNZytnQ0RENDFLdU4vaUJ2VHRB?=
 =?utf-8?B?SnNUNm5EQVYwcDFqOTVKL2NJL1RkajF4WmVpVGh6THk3WXRRcWxvdFA0ZHhQ?=
 =?utf-8?B?SFZxSVMxc2tYL3VMUGEwYkNRYmZXbHJwdk9NTENIc1BpV1dsbVA4UXFjdnJ6?=
 =?utf-8?B?R25rUWg5dk5NU1RtTnNKck1WTWRyMzJHd3VtUHY5c05WRTJIK083dmFTZDBw?=
 =?utf-8?B?MnhkOHROUjJPV25qam1lVTRSVWJwdzlteUVqM1dReUJUM3JPTm91OEp4Qmt4?=
 =?utf-8?B?eHRhUmlQQXkwV3ltVjhDc09UdisrZ2hBZGpzaFBWVGd1NUVpMWQyeUFDc1lK?=
 =?utf-8?B?dnVQZzlpYy9oR216a0Y4SnNlSTdHK1cvQW53RnpyM084SlJwYjUvVWRZU2tm?=
 =?utf-8?B?REtheWZxb21SYk5BQ0w1UFRoditvYnpyWGNaMitxb2k2Wm1UL283T2pCRlJU?=
 =?utf-8?B?aDY4cUJmclI0SUV2ZzFRUE9rbWFKUWtSMHF1elVUalVRSE5iREZLcUI4eEJq?=
 =?utf-8?B?RUVSQVR6UEFOSStRdDd2dXZpdXoycmhXYTFvaGNjRkYxR3lCUVpjazFpMG1L?=
 =?utf-8?B?bHdBQ0NlaHZybTNMd2pHQUZ4cmxYMDhiVjlHYjk1djNkdm9oOHJ4UVNaQmhX?=
 =?utf-8?B?M2VjSFRqOWtDOVJLT3dDNlBQdDFxNVUyRFEwLy9IS1BkQWppMEZFbkxNNGNV?=
 =?utf-8?B?TVRPeXAvY2dBNkExUXIvZkNJRFErOFZVRnFqelRMUWhLVWNZckk5OWZyekZx?=
 =?utf-8?B?VmFIUzBiMEo2eUYxOEdubkZJUFM3M09IbmZ1cStINHFKcmRrdHh1UFdaQzV3?=
 =?utf-8?B?L0pRUHZSS0xjWTUrYk13NEVXaE5KVGRaNGNHSlg3dnBkdEhoVUV4ZHdVSTBa?=
 =?utf-8?B?S3pqMXMvbzA5NkNiRlNRbDBYNnF1endXditUaFFSU0tOeFFJMDJQSm9jZElz?=
 =?utf-8?B?QWFwU0JtNDg2WUZtT3JmcU9RaVVnMXBMQjR2UCtYcmVCbkNIZDRaUXkwczB1?=
 =?utf-8?B?U1pYNTRJT3E3a295U2RCT3N2b25lbTVNVkptdzNLWEJsUEgyOTVVWVB4MGtY?=
 =?utf-8?B?cDZrc1FvVzN4L0tmS0hMeFdNWFdsUHlxcWFiZ2ZJRW5FT3Bwd21LcnpHclZo?=
 =?utf-8?B?RmtSTUtZSDhvTHBsemVHclZQN2FEaUpGMjJHUEtEZm92Zk91MGMzclI1cWhj?=
 =?utf-8?B?aHVYS1FCMEU4QjA0TzVIMFllSzg1OVVZcTVPWStMNllXWWZsd0h6TjdDREZh?=
 =?utf-8?B?aVMvUEtkeERqWVdwUzFtQ3RxeHdaRUxDaytsWWJFanR1cXFjNGZSVmNUQVEz?=
 =?utf-8?B?WHJBTVNJQ3BzMUkxUXcvMHJGR3hycmtMbE1ZbnZFV0JnQnFrR0tnYTBMaHZy?=
 =?utf-8?B?QmRmOWpuNDRJTWFqMC96Z2JCdjlsWU9jZ1NpdGgyVUp3Z2JmbWxaQzF1enFt?=
 =?utf-8?B?Tms2bmtTUnZScERLa3FxK2dhVndlWWhzaU9ja2ptaGs1M0ZSaGJyd3FQSjlH?=
 =?utf-8?B?bVB6bFYvamFMZEdjRTF5VWN3YXBseWdBZDBQTlAwL2E4SjRNVUs0TndnbE43?=
 =?utf-8?B?Sy9GUk4wWmdCWXZobU01N3RmaFB1OEI0dVhHaTlqYWk2OXRjM2xIVDhmWU4x?=
 =?utf-8?B?SUROdCt0d05nTXpXZXk0Z0h0czNtckgwb1NzUEpCenQwR2tEWnUvak1ibmRB?=
 =?utf-8?B?TW5OQWc1YWtUZ1ZQcUdvYkVmMTQ0emRCWk1kRWlldGZCbHkrOGZxOXdjTWZp?=
 =?utf-8?B?MHVLeXJvUUlBdE5jK0dhZi9obGlBeW9YNjVwSWpKYmxTMUcydmhxQzMrSlAy?=
 =?utf-8?B?OFgyVGFhQ0d2NmJoSEp0MlBjVUxuQTFEVno3aGMxRzdObXZCQlZXdTlkSm5N?=
 =?utf-8?B?aGRaRUxwUWxsdHR2NHNXQkU4NHZMbnIyK2N0SUNnV3FIczdRSENXcVZkMHVL?=
 =?utf-8?Q?BsVONKZHd2AgkCOU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0616709-8ee6-49f8-1114-08decb8b189e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:39:00.8599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaLMWoWVXj8RHP48F71sWXJz1bpvEQp+hoXgROVqYyacTsnZ29ytKkd6MAzzgza73QAVNICCB9lFp2u83cI19t8f4VhGSf/kr8a2ruAOnok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6566
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

On 6/15/26 15:25, Ilias Apalodimas wrote:
> On Mon, 15 Jun 2026 at 16:09, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Ludwig,
>>
>> [...]
>>
>>>>>>
>>>>>> I'd like the eventlog to be initialized before calling this (look below).
>>>>>
>>>>> What if I removed the log parameter from those tcg2_* functions instead?
>>>>> The event log belongs to the tpm device IMO, so should be initialized
>>>>> with the device.
>>>>
>>>> Measured boot EventLogs etc are primarily described by the TCG specs &
>>>> EFI and we only have a specification for it there. The DT describes on
>>>> how to pass it over to linux with sml-base etc.
>>>> However, in the EFI case the Eventlog is allocated as ACPI memory. So
>>>> you cannot allocate the EventLog a priori, until you figure out what
>>>> method you are using to boot. We also have use cases people using it
>>>> only for RNG, due to limited memory, so we can't just allocate it on
>>>> the device bringup. And lastly... Some first stage bootloaders do not
>>>> initialize the TPM & drivers. What they do is prepare an EventLog and
>>>> expect U-Boot to replay it once the TPM is up and running. In that
>>>> case we obviously need to preserve what we have instead of starting
>>>> from scratch.
>>>
>>> Ack, we are on the same page here.
>>>
>>>> My main concern is that I *don't* want the EFI and non-EFI code to
>>>> deviate. I have some patches that I am playing around for quite some
>>>> time and rebased them last week for this reason [1]. If you think
>>>> those help your use case or make your life easier feel free to include
>>>> them.
>>>
>>> Good idea and orthogonal to what I am doing I think. This duplication in
>>> EFI stressed my brain too but I can't care about EFI right now :-)
>>
>> It is, but the deviation in EFI is pretty minimal atm.
>> - EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
>> -- That's what my patches fix
>> - EFI has it's own version of tcg2_measure_event() -- That's easy to
>> fix as well,.
>>
>>>
>>> IIUC you are centering the change around calling
>>> tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
>>> about aiming for tcg2_measurement_init() as central starting point
>>> instead?
>>> That would allow to remove even more duplicated code.
>>> It should be sufficient to have tcg2_measurement_init() accept an
>>> optional pointer to pre-allocated log buffer memory. Attached patch
>>> maybe explains the idea better (just as idea, won't compile).
>>
>> I agree. In fact I mistyped the functions names on my previous
>> email.... I really meant tcg2_measurement_init(). The patchset I
>> pointed you to already converts tcg2_log_prepare_buffer() to static.
> 
> Replying to myself here, but.. In order to do that you do need the
> unification patches. tcg2_measurement_init() will need to allocate the
> appropriate buffer depending on EFI or not.

So this is how it would look like with your patches on top:
https://github.com/u-boot/u-boot/compare/master...lnussel:u-boot:tpm-with-ilias-patches

IMO the untangle patch is not needed. Does that look sensible?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
