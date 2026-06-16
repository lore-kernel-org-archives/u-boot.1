Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182EACD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 08:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E07846CF;
	Tue, 16 Jun 2026 10:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="PnV5KLGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EC68484F; Tue, 16 Jun 2026 10:12:20 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C69C846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS11Y7qRNAjqSoR1xWd6Z2Qn1gcjb4vbmk+cbCp6/4KzLJn8KdFPoq3y9PMX17HdVFAtnYpN3DmAR7nvK7Tw5XA2/NpUSOt0VG1t/k+TaKBWeAcu+3is8+R8Vnkq7uFFf4sNQWG4dwxV5i1bBTGse2uhWPJecmMGfqwBF+3/taNDZQlSbjzxtIQzYcKLS1il3xE9/vpBJ4e6CnJR/4syFbJU3/97rUXnwMW8FPvJXbPmU80uosx0mJwcghbkU1lq8BaOHO5OVy479KzZkTjSMpQnYLU8oi1APvHuN05HC3tfiNT/AHNNQ3wFhX4n5f/wt+WGZt9wCU3TTIBzMQBqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doxiZmOjV+vAxOXIkomjxWZeEQPo567b9CT5U52Tynk=;
 b=TYgrzrHJQHI49m8/xrewqcSsE2Hm8C72DhbdNEk+eCF0w1RbKNagZxfGevMNXjLpHmWt0tXH1JgGVOUrmJW9Osd9hEMXPvxeiaepwi7ADYZAIkcg907rwHlqNnUMPoh1D5ESd9njCOR1KJtVdxvozRLq9aJPdZPtdkifMnILK0HGlB2ks4b6FqRlPFaN488lMYYYzp7gidyB2jt7PzpLxW4MOlYvI6RuNn0HmIC19o4KJpyanfHV6dpAfVpwEnG1Fcjjm3EokrBP6GaGg0NgdJeAoQGx8Ginvu1Mav0acQ5tIpLIhpQMB3TAs3kel9b+QTcJihqjwneDit3qdD/7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doxiZmOjV+vAxOXIkomjxWZeEQPo567b9CT5U52Tynk=;
 b=PnV5KLGCdxVSes/tm43fPwdg1zIAJm6kwISlF2oJ3AyGC+wDQ3AZJ2rneD9F7Yc54VbA7pSr2wyhrbUJtd/Tvqv7Bxfc4TvGs4A/gUKqR8TqH2ydN56FVjFW1Ihil0RxLULLdLbgRLPEgPqRxxU1CHKfM51OlXCn70sV+wiYm9Ioj8mu45OOmDEqAl+Ecgn4YBe1R1XsIMJGoTmuMZy4o9BAY9vBIeDFDsvAEob2VYeJ9BS9CHURGHv+fwgWJcik/PdiCu0jqsjf5WHYDylI5UgW0jsZvzQJMamQO2pNjRGvsoAnMqlWq4ZV6urSJfVikjB7iluq1p6GOlbpgQgD4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:12:15 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:12:15 +0000
Message-ID: <b7449d8c-f4ce-4112-9060-3f76963813d2@siemens.com>
Date: Tue, 16 Jun 2026 10:12:14 +0200
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
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DB4PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: da00bee9-5fcd-47d9-036e-08decb7efa0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|55112099003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: UEryMtBzY0ew76TYpZY7aIG7Tkd+H4T1Kv40CMQW1mZplRb6140rnvk0OwlPUoHzEiXISht8A3mo7LCrUR0JsXJ49A7zSWqMbdm9vCSjZ2nYNyA3uBIm9apgcVW7RUwdvAEMgJROY4ZIwDsfG1HhrW6hdoqun6825xohl6rsiNvj51B1C3ScoOOQRWRIezK27iOB4NPylqcOoSXVjg3dzR0QmsSZuEGOyhY8yxxBiXOhrMWgaTmy9w+tfWuns054okPG+boxcMYw5IlPlT9/Mtpw1p3QWq75/YHHSAW0av1mGQiGJzqyS4Ql7uMoTdPAgO0HIIdHsSNy3dh/YH2KQ1k08vCVl4E4WgAULi/ywlkRPJb9yMEL/sVvmvzA4/qy2WqV9AksYG8OI+OKBlhtxlQdabQBBYVM8aeciHy09VX4nSUVTMguNaTHLxu6Bk6BfOhC/LnvbE+hb36Oyvf4QVb+Vidih3yeWeGcyCaqMBqnxKM6VDvbuIXTzlgTuKeSMz9Px6o8IHzpyGT1xsKzSJdz0X2N/mFmJ1OSRdelkLZDNdWlbQB9PgDkQERhoFEEGYl6Q8wm2IsKTfrwGpgyOnt2y+glo1sSo6kAG750fkctsrGIK47lTs/NoQqZx4SpoI7gIA6tgMU3JG5/h0WdSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(55112099003)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhaQitTelM0NmJvYVB3QjZtTzRvOUMvVklhSWRvY0EvODgzS3V5c1NVSjdE?=
 =?utf-8?B?c2tXNHlzNldrVUNPUXBKR3VRVHZ0R1JUMTBNbmQzZTAwTWN4Y01mNHZBRFlN?=
 =?utf-8?B?VndSdWM4OE5jTnJNUXpqVXRscjArNCs2amZESVB5dnI2ZThnWllBWkdEd3BL?=
 =?utf-8?B?K2J5YkZVd0NYRDBDekdFT0E1bUREVmMvSWJhMWtUY2NRcThoYkpoZUNDWGpN?=
 =?utf-8?B?WTlSZngzb1Yra0dUQy9ySk9KTjlaWUJPdzByZ3ZtSzI3SGVJR08vL01GN1BT?=
 =?utf-8?B?TVArZ0dYQVVuWTgzMkxrWFVOdHhVelVyWjR2VERSV2d1RHNXRGZyNi9TUXZ2?=
 =?utf-8?B?N1BpZlBqQUFzRkVNMjRDMGRBWWlMQjIwRGpXc1BBRm51b1huMThsWkZYRkNU?=
 =?utf-8?B?aG5kNjVJaDY3cEdhNXk2dWVpcDI3VldMNnJJeWdSajRWcDRVZ3JFNFJ6VUs0?=
 =?utf-8?B?YjZLSkU0VkpSR2dEbi9tQ0JHNTNFY0FaZXNxZEVkNU5PWlVHbUVnTDdYc1JT?=
 =?utf-8?B?ejZmRmJmV0djWW1SUGNJSWQ5YlkvYzNYSFp4RTl5eWliTHlQRk96MmJGaHY2?=
 =?utf-8?B?VjBoQ29wdlpzRFltN1RUdDVZazlwdTBJTlpncldBRWlRTW8vMFNuQmZPM3p4?=
 =?utf-8?B?UGZvYUZBYWlwamd6Rmc0ZWVrdUhNOXJzbTdGaXQydmtQWXpIdVJTQXd2SElu?=
 =?utf-8?B?VHAwbFI2Y2k2d05zS2FyQ0FGcDB3YkVIbHBkam1xMldIRzExeXovK0RSK1c1?=
 =?utf-8?B?VDNwSGVCc2VvQWh5MGhUaThzNGRBSEdlK0F1Y3RHcVRtWWVEUVhKb051Yitk?=
 =?utf-8?B?Mk9jTXJFK0hHV2FBeHBOQ3l4ZFVNMm9WRTZVMFFBTVl6V1JwY1N5NzRjdEVK?=
 =?utf-8?B?R2owVUc1ZjVlQTluS2lRM0t0em9rY0Q4TGNueWw2QzcrcjdKVTVwTXJTeklk?=
 =?utf-8?B?bWVmRnUzcjRvb3ordTJscTA4M3NBcDgzalo0SEk0aWR3WXhlcmpkYnVjMTFR?=
 =?utf-8?B?ZDhodHptVEp2VzJQNTNCMkJQNENINDhydEJ0SjJpQUtXakM0V2ZFb09CbmdV?=
 =?utf-8?B?TXE5SU9WcEI3Z1RDd3J5UWVxd3BOTEZnSndZYXhPUFRhZjZITXlYOWR0VTF3?=
 =?utf-8?B?MzZZVlh1WXJIbDE3Y21ydTEzdVM4Q2pjeVd3bzVwT3ZpN2FqSUNTUnA3OUJI?=
 =?utf-8?B?TmZuRi9ZRzJqUDhGaFg2c0ZPSWhrU2pZb21sanBFN1FyNDliVFU5WWI0VWcw?=
 =?utf-8?B?Zm4wZVdLVTZJVjhrVWRJazZtNmwyR3VvdzgwWWRXajltNHlIUEhIdXFaM2hN?=
 =?utf-8?B?a0IyOGNXUG51ZytLU2dHczZRNW1aV2Q4Z3VZdW9RUjhMNW12Rm1DY0ZxYkFB?=
 =?utf-8?B?bVc2WXE2ZDJiMzJWV0NKZDZqeDFtT3A2NVdOajhMNlNFdDZiY2tHTmxiMWp4?=
 =?utf-8?B?c2NVc2xMR29qT04yWTY4M1I3NnkzK0lDbU5EOUc0ZEVCQzNDYnp4cG5xdDJY?=
 =?utf-8?B?eTBGYTFPN1NnTHBnRy91b0hSQzFZd1BNZmdaanNXemdlNmlVTVE2NnVTVndY?=
 =?utf-8?B?Y1V3MXZ5NmxTSGlxSmxGdmgyQnh0eno4eWRXV0lvenpZV3hoSE5yWWc4OWh6?=
 =?utf-8?B?MVFxY0ExTG5VTXFDdzJOMURQaDlVakEyZmZVaDFlM1kvbkY4NlJUMmtRSVQ0?=
 =?utf-8?B?a3R1dUFpRFltcmU4b1NBWmplNU14c3RkUnhUYkV6bjk5NTJ1ckw1Mk4zODRr?=
 =?utf-8?B?QXhtMUdObzlZcGJNc3RrY1VXRXhDbFRDazlYT2dOUnJRR29hckk5bjBhYWRu?=
 =?utf-8?B?MkVoYzYwKzlBMjBOTUtpdzQvaDh2UTduTy9hb2R2TkFZMWNyV2NsY1QwSUNt?=
 =?utf-8?B?T2J2UWlGTjdIbzNsNjIxNDVaR3ZzOVVES21KU0tZMTZ1b2kyMGRONVRxSVAz?=
 =?utf-8?B?b2luVTNSenlOS1FhSDVWdUVFYUE5NkQvQWRQbmpjemhUdFMrQ0FVTXRFeEN5?=
 =?utf-8?B?SGVLd2w5U2lybmd1d2RwcWFRQk9pNUxsVTZaUHJsdWd4WnU5WlNEMG9QaGpZ?=
 =?utf-8?B?WUgydlNlZVNhRUZPa1BvSy96TmpJdUtuV1o3QUFYNlZ5eDVSUzdsdlg1OWhY?=
 =?utf-8?B?R25XQ2ZydmdTa3MrcENuejlJTXpOR1dzY0pQV2lISmJEdlRBdmtmczRNdGNI?=
 =?utf-8?B?N3JLV1k2am9iZW9PMFlLWnNMMVpFa21RRTg2R2hoWU5tV3RiTVQ3Wll6OWtR?=
 =?utf-8?B?MUdVRUVtRmJHZGxXMHR4WnV1VzRNb2UzcFVieW9FaGtDMHRRWUVNRmJ6MEZV?=
 =?utf-8?B?ZVVQYmdndUVLRmFDSmN4RG5VRzBTNG9GTnl2WU9NS0hoUERlcVo0ODBVakM5?=
 =?utf-8?Q?BLhqFc3q8q2apZMI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da00bee9-5fcd-47d9-036e-08decb7efa0a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:12:15.5936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5Ub815ctHxbcQcGxpmFmWl2gZyWdhBPI8u6hyz9f3+/hqz0/+rxEyIQ+X9MS5ga8nr6AGcktho5+BvE53+ave3cyph+tHep69y9q6Y0P8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6261
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

On 6/11/26 11:57, Ilias Apalodimas wrote:
> On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>> [...]
>>   /**
>> diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
>> index eb6afe49e77..db3f6f486e9 100644
>> --- a/include/tpm_tcg2.h
>> +++ b/include/tpm_tcg2.h
>> @@ -162,12 +162,14 @@ struct tcg_efi_spec_id_event {
>>    * @log_position:      Current entry position
>>    * @log_size:          Log space available
>>    * @found:             Boolean indicating if an existing log was discovered
>> + * @allocated:         Boolean indicating that the log was allocated by u-boot
>>    */
>>   struct tcg2_event_log {
>>          u8 *log;
>>          u32 log_position;
>>          u32 log_size;
>>          bool found;
>> +       bool allocated;
>>   };
> 
> I think it makes more sense to define an eventlog state with a u32 and
> replace the found boolean with it. e.g
> 
> #define ELOG_FOUND BIT(0)
> #define ELOG_ALLOCATED BIT(1) etc

Is there a specific reason why explicit low level bit operations would 
be preferred? Since the structure is only used as internal data 
structure of u-boot, what about declaring bits like this:

+       bool found:1;
+       bool allocated:1;

Looks like that style is also used within U-Boot.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
