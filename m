Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C1ECD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 10:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A2284119;
	Tue, 16 Jun 2026 12:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="erKI9fNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB52784704; Tue, 16 Jun 2026 12:34:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38A484105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d74cfy/awjjM428M5FwEcbF3L1NCeAcd7Epsn5sRpZlTJ9YgDjk4RZncog5jNQ3p0QoIouLtWIB3OinXO4Hdr1DqijdKWh8UGnB6Dx6yISig4GzFNvQiOED5r83SFaNob0ExxkAHC0YIPPXn5fvHzFcmcQ3aW/w0gFwcOx9svwNbUfxCUxN7Mda4kGU/51vyZ900+cJyD2vVftTJ3nagWvY6Wej77d63SlQBzmrXxcgewOxUz1NAOOfFzzd8jc2x1ng4qBovpdepklUb6t50cyDqHA7QWS6+AgB8CnQHX9gP319k2RMaBOrIHEqKlbEXsMtU9ZOYWDGzhhIS7jT4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xzZgvVx4LExfCfnJ00T5ra4sOLEsKSeJAROG/E1hVQ=;
 b=hrp9OJ/vdVqPb/UVM0D2GqwTsXS8UPXDRwJI/PJFORek6q326F439wpMZk0vmM105PpL3xsPE18ri3yPK2+ClSQdpkeQqZCcZwv/pOteLqWhJN1B9zeJnWJ5QXso5IysJPU7y761qQU8EUegAPUIcTm8bUp9V4Pt3j8PUCPw+CzPFfGx5EWwvlkmOENVkXB6FuHLengBMqN/JtzJbKCt5+CxxwC1HRNG9/X7Ie8z/Hmidmym5vMTKi5/C6epU1OPUy5J3Q65hIxPVka3l2dXWLfp2C47Huv/XKlOBfdkZgaPRRKWG/S9vW2tX85RvhKxBMsOXOJit/kvcboefW80zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xzZgvVx4LExfCfnJ00T5ra4sOLEsKSeJAROG/E1hVQ=;
 b=erKI9fNvb+iFZ+rwOe3OMWCHBGVeDYnleE5EYHBfRx3avziryBidT8v3NcXR1pO2CIQx/OcIPGYZ8yb/R2mYimfdyK4HP4CWYXLh9hfzNT8A8Vc60kZVGy9wsY8EZUs3ncspGJQnOOhSh4xZNUlI7FBHhXGZy+FjDLyQMI4gi/5iunBfMo53RUwlUpJEmuUf32MPPRP4VLrgdweI9QvnWgIpsQRNrurXA+vAmQ7iAioAHYsk9RyCrYKI+PZnICXWrWIG0xc3GzkL7ScTCH1ZfV2kjuO7YFmmfUJXj8u+lNVJTBb6uz/EqUROEsPNlWP1yYb6WnOYm513QSlDhQzNZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU4PR10MB8998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:34:11 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:34:11 +0000
Message-ID: <ddc049cb-fce4-4941-83fe-f7ac38633fb6@siemens.com>
Date: Tue, 16 Jun 2026 12:34:10 +0200
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
 <b7449d8c-f4ce-4112-9060-3f76963813d2@siemens.com>
 <CAC_iWj+twmGF84XQTHRuRXUU872Zr6W2_C53KzKS5oZbOC43Cg@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWj+twmGF84XQTHRuRXUU872Zr6W2_C53KzKS5oZbOC43Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0534.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::16) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU4PR10MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6069630d-9e77-4e2f-9440-08decb92ce0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: PeCsEmdfcW5lIIaSEd4kYPKwjPE/BahT8M1zwt3KwtTIsvyshA4KtaYg2Ha6oDm3TTgIcPptLpW5HgzHoQ4ScvDsy8s78Vk//AUKWV7gzIg6SC/wLhsxtsg60Sdq0YEmOE4EAlrai4PkQMwAL2F0xyxRIlpJuP4QuYEaoMefkSFu0jbqyI+VrWAZClT9nB9/GnR1IzW1tT/DCU5gEnmb5Aos97J0oyU1YpVYVKXqJUpfb0lBdODh/6uw+ZJSnriiUTzUF1vyur+Fv3wTU5ZzNXjHzrdpiE6JT+dI67jjUFHUGV6BUZJvMbmeoV/V8UW/CyC0JQmbOoetmq7Xf0PuFbdynbAXAsqPLPQ7xNQpvJYvFlBJe312ejD4jqKJ2KRai0kvMQV75VU+vFhjmalyyySMIu5UV8XNCFIJc2avOl+RbShgNvSGT9DubYDwLsFQwUYjXNmfdL5M1TDahM7wmNv53GqgeFbQUC9kG3kjVEjd7Tf8JHyxz4uCRF+xbdFY5KMjthqfHkNJjVVV+BB0Hxtu8kCVQa0KkuQLxoVXMfdGJF9j0/WtgXQmKwNUm0MmjpPT7kJ9iuGeVKph9ErAbOzdldfzjvwbTusmpJxqCYWF3V6P2BGEGVsMEQ7t8Jj7Lu0pka0tgbEwpzZzsnfZ6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1E0Sjl6QzB0dVJTTmtoYklBcUFTMnVMNkZ5Y1ltT0NxNDQyenBZUnVMVkRE?=
 =?utf-8?B?YUJQbWFqYVkvSmQzVnptQ2sxYXhQSmZ2V0JEZHVqZ1VHUndVT1c5bk5VNGJC?=
 =?utf-8?B?UTA3SEJUNjd1ZjRmcUJzeGlTSEV1dm1kOW5jdjhFT0pyOWYzVjBxTFczdllP?=
 =?utf-8?B?S05hQzhBaEh4akJ1akwwYytWdlI2b2JHZ1pDMzN0K3NST3NLRzRLQ0VCc3or?=
 =?utf-8?B?R0ZWcU5oRzBHNVkzWjBtU0FFVlQ5cTVYMnV5YVN5T3ZsM1BwV2plNm05cEZG?=
 =?utf-8?B?OXBhTTBDNUNrbFkrdnk2eDVZOHRDdEpUTTZqYTRDRkdnVXExUXYwQUhYeTZY?=
 =?utf-8?B?blRYNGlVZHBhWU0rV1MxVWJZQlo1eStYaUZnR3c3eEtvRGQ1WHd3T0lUQkpq?=
 =?utf-8?B?MTQ4OHQzLzVYbW5DYXZKTHB1bUhRaEUvaCsrMkdGT2p5QVpHRFA1ODZTclEy?=
 =?utf-8?B?WkF1QTdJejVFa1daUVZ2Z2J0UjFBUmpmYWtiZ093d2c3RXdYNjJCRXd0VWxx?=
 =?utf-8?B?UXNKUHYwRm9ORXRmY2YrWXlCeld0KyswOGJCU2JvS09VTGp5eE5VUU1qRzEw?=
 =?utf-8?B?Qnk1RE03YmxDZitSbDU3WVR6eS9jTERSSXZ6WkR0RWZ5Und0TlJuS3R4M1pV?=
 =?utf-8?B?YlpPQjVpbm1HM1RUSlZ4VmxEWFB4VUwvUktLWC8wdWVjTksxdjBYUG0zN1Jh?=
 =?utf-8?B?UEFXUG94cjRVeUYxYUVROHcyQWlHbVFVMmZVZjZEV3oxTEFtZUNzM2xxVEd4?=
 =?utf-8?B?UCsvbmh4ak45eEpTYTArbVBnc0NzUHdFaWozQjBRZFVYNVRtZWV3REhwNDV2?=
 =?utf-8?B?Nzd1b3JpMHRnUWZCMkhpcXhrMmJtb3JaYTlySWpFRU9ZRHBmVE4rWGRiMVZw?=
 =?utf-8?B?MWFrYitaeFVqdUljdG5sMjUyUEdtcTk4YzZ0VmJ3Uy9RQXIrZ0ZaWWppMWlh?=
 =?utf-8?B?TURTempBVGtBWTFwQXFzTXFKa1VjY2JJZEw5RlhvLzdyRS96KytYeGcycDEy?=
 =?utf-8?B?MWlYRk9oQjVtMWdTL3EyblIyNVRzSTh1YWcyQ0ExMU1reGk2Mm1icFRhR0pB?=
 =?utf-8?B?YmR1aTVZUkg0NlArVHN6VUxseU5XR3JnVHNGaWRBZzQ1RWwrWHhtZWErWmlQ?=
 =?utf-8?B?QkR2NDZsdmRqZVRWQTB2V1hZbGM4RktPamhuckRsRThadGR0c0xzSjQwakJ2?=
 =?utf-8?B?b3FoN2dvd1BiRnJrWHFXaERiWWxtNDQ0NzRqb05VdHhRckJPM0NJZXVjTlRY?=
 =?utf-8?B?RUgzLzR0QWRIQVEyNkg0UWR0Z1I3TWFXL2RkSHRoWWsySTF1MWRYYjVrV25Y?=
 =?utf-8?B?dXEyV2ZGTUtWejNJTVpFc3hhMkVCVUNwdHkra2VzL09rWmVmYUYrclVxS29U?=
 =?utf-8?B?SUpxTTJXOXc2OHgrOG1tazY1RUdveGxjYlNnVXlHVjNrT3FXRUdha0RNeDVM?=
 =?utf-8?B?Z0x5N1dPMmh6WVp2TnZ1NVU3Nmc3cVpBaDBpMHNzNGhReUdNWFgrUDNqaTZx?=
 =?utf-8?B?UVp4VzArTUdlZVoxQlhIWHRIeERVM3RYemZpdnJ0R0x6MEhjdmdJRlY1SzBQ?=
 =?utf-8?B?MGt5c0xwWU55VGVsUloxSVFwNmg5aFBEK1pVMFNMWTVEKzNTV2xYQS8zUmh5?=
 =?utf-8?B?LzdaN3NhS1RuMnVGODI5TnhLalRLWkpzUVpXRDBWTVRERXJMelZWZzVqMkNZ?=
 =?utf-8?B?VWxMei9wUlViNHd6Nll6cWpYa0VwYnMyWWU3S0M2Q3BqOVhtc3JJK3gzMmg3?=
 =?utf-8?B?ZndEZ0FrbTh6aGlYczNPZjFVOHRicXZIQnNMRXF0aEVqbWRSQnQzSnc3dTRH?=
 =?utf-8?B?SHFGT2gvWW12eUR4eDhQd0E0VkUvL0UzN3lKOXBwYkR4ZWpOSWlWdEF4Nncw?=
 =?utf-8?B?NEExTk9sWUxYQ1B3WGlTR1BSRnpRV2g0OTZXR1lJTytMMFZlZ1FNT0IzYWJv?=
 =?utf-8?B?c0t6QTlmSU16bU9jSlZvTE5CTUtheDFnRWhNSUNXaXZuTkpvUGdUWjZnODF3?=
 =?utf-8?B?M0dPM25RL24zOU9reFg5UGlVN0RRTmRqcVNkOStRR0tYNXB2M2x5ejdBNGVD?=
 =?utf-8?B?S0czUE1DME5reUVWaDdJdEQyRmd6THFncGswR0pYYy9tcmw1eTJhOVNHek5s?=
 =?utf-8?B?N1VQMHVLQjQ3TUdrV1VSOXRXeHRFR0o5UU5LTGFNUk0vV1FTYWJsTjVsNnNH?=
 =?utf-8?B?bnVJMHUxZmhQUXY2VzBndzltTG1hQ3pwQk1aWDBBSkx0VUpLNG9BOHJZZjE1?=
 =?utf-8?B?cVJUeUV0eGE3K3BHYml6bWUzMGR5TElwSTNXSkJGNDAxbjcxUjFZRnd3THE5?=
 =?utf-8?B?Y2NuSkVRU1ZhVlZmODViR0NiOHJudWNiM0dQSkIyNGJxNUxKNXdiMnpYemdx?=
 =?utf-8?Q?Ztb/a9cQ4Ab5UGbo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6069630d-9e77-4e2f-9440-08decb92ce0e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:34:11.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNJHTJTix7sA7rmEBpMUOr+C7GuJCJQxhI2Bo+1hhZwxaEEJI3AG99OorsL/rgQcxMicQcNVK4ktyLDV+q4kDciz9pzWis6EHjBEGZdOrtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8998
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

On 6/16/26 10:40, Ilias Apalodimas wrote:
> On Tue, 16 Jun 2026 at 11:12, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 6/11/26 11:57, Ilias Apalodimas wrote:
>>> On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>>> [...]
>>>>    /**
>>>> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
>>>> index eb6afe49e77..db3f6f486e9 100644
>>>> --- a/include/tpm_tcg2.h
>>>> +++ b/include/tpm_tcg2.h
>>>> @@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
>>>>     * @log_position:      Current entry position
>>>>     * @log_size:          Log space available
>>>>     * @found:             Boolean indicating if an existing log was discovered
>>>> + * @allocated:         Boolean indicating that the log was allocated by u-boot
>>>>     */
>>>>    struct tcg2_event_log {
>>>>           u8 *log;
>>>>           u32 log_position;
>>>>           u32 log_size;
>>>>           bool found;
>>>> +       bool allocated;
>>>>    };
>>>
>>> I think it makes more sense to define an eventlog state with a u32 and
>>> replace the found boolean with it. e.g
>>>
>>> #define ELOG_FOUND BIT(0)
>>> #define ELOG_ALLOCATED BIT(1) etc
>>
>> Is there a specific reason why explicit low level bit operations would
>> be preferred? Since the structure is only used as internal data
>> structure of u-boot, what about declaring bits like this:
>>
>> +       bool found:1;
>> +       bool allocated:1;
>>
>> Looks like that style is also used within U-Boot.
> 
> With the patches I pointed you at there are a bunch of booleans before
> this as well, so I doubt declaring bitflelds will make the struct
> smaller in the end. Padding/alignment will probably give you the same
> size.
> 
> OTOH the patches introduce more states that are conceptually relevant
> to the eventlog.
> The updated struct looks like
> struct tcg2_event_log {
> void *log;
> u32 log_size;
> u32 log_position;
> void *final_buffer;
> u32 final_position;
> u32 last_event_size;
> bool get_event_called;
> bool ebs_called;
> bool truncated;
> bool found;
> bool allocated;
> };
> 
> The TCG2 code behaves different if GetEvent or ExitBootServices has
> been called as far as the EventLog is concerned. So I think it would
> make more sense to encode the last four booleans to a 'log_state' (or
> something along those lines) variable.

To clarify, you are asking me to change the code like this, right?

- !elog.found
+ !(elog.log_state & ELOG_FOUND)

- elog.found = true
+ elog.log_state |= ELOG_FOUND

- elog->found = false
+ elog->log_state &= ~ELOG_FOUND

If that's what's preventing the patches from getting in I will do it of 
course.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
