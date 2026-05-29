Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FEFCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 17:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B2B184693;
	Fri, 29 May 2026 19:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XgzPXobp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5014846A3; Fri, 29 May 2026 19:21:32 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B49805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 19:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2ox41MU/CiXRSU67UxGBMEwa5/UMnqf4BILeqvZxk6fOD6Fj77NUOiq6OZIIKyv6LJnNb3sUVLlu9VMfRjWhdL4fQAsHuix28kCLRov3VtBnn2LltIKgUKm0Mk9JN+nnHP8yElZdS97jXzB955gjTl5oDNYF7obIG5sB3gKc4dmPKLdIC9rsBkmpSlL3vE7j4im4E8bGG6sA5DQ8bBPeff9LdpNnyJol15yAAQNNkppn/B8r3R2CMnmJ5r3tyITXleMvmjIByf64rYqPOhYu9WQDxgh2A+kzdlJiZqEFfrwIVO00c6zrYS+vD0D6671+e/iJ1IdgnSmhnzYIBOAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9emepr61K8+3gzInh69qVPO7GM4ARGcAqXV6bRKzWzo=;
 b=dCCFt/1wPfcVgA6ZUZZArRvf7xzZXmQSloZiJAN2Mexx9mTOsUWbQE1akxDhg53OWzfWGGQ0yNLdFZpDxHbAPPzcLoqdyNqCKsTZrSxZrOZB8pyDl6GZYZMpDExnTHqLB3X9Sy3gys3CRRNZ7Rd/BnFztTtbwKsE+UPWSdlCYCR3pssMg/FEAoiIOH5PwZTNpYz7vTKdlzMCnWQSweT/Rlz6oM+F3y5GEjeBpNfzYG60O7tNJZgnL7bQ+OmWkbTmTMAPEGJIofEo/5MhU6q415KpElLQS9iliBA5p3F1g5k2rxlA7LArN1yOVb/dM/wdA3tIT8oxBGoYEWDXfSss0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9emepr61K8+3gzInh69qVPO7GM4ARGcAqXV6bRKzWzo=;
 b=XgzPXobpq+PTJQCGNRrAtIVq2dTV0oYPLZwjSThcPczasVof/UViVPicXyq2CXXoAe1I6+ksr2jIvjsV0ksVvkN7lx6UiBmwacVaPMzz46V0FjENDT8HlMKdi7mSSrZMr3dxZ2SyiiOWs02PNRYmGyAkRs1mSnxZjbEJsqXHNsdCQiFZt8wYnQMcQIZFm838CLxvy2d6W1ds0x9j38UssN3Qg6y2hRT0fFCs9YvhlN/vVOhBZroMd8Wcpqg4DUFCAp1U03GEDi+0eZ43yxOItFqaM2pBupO0VqNNIBH/Lawfz9V4TWMK51CV8z1naeVqUMejCeb/pZlKPz4g67xROQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS7PR03MB8316.namprd03.prod.outlook.com (2603:10b6:8:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 17:21:26 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:21:26 +0000
Message-ID: <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
Date: Fri, 29 May 2026 22:51:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
 <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
 <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS7PR03MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a652f7-95cd-4493-a3a8-08debda6b6a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|56012099006|18002099003|3023799007|11063799006|6133799003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: lRM4usejSJrcavYdZWWX1bW+QJiukb7EuFOUflZWXo4s71fuLXHYF0DlXdvlQguDzpzuK1sSBArGauinzi7NJESBxPSk650PMttLQ8xWrms3OATqc7w6ylORA3Y3zaxRcdP9XPk3Gx/Kml0Fvfphj+NEIYYWqnu8x5oUsBZUtorIcmlVn6NTaUMKXSLAzvd5VudeTnI7BjLRFnUIFKsCr/mxwdPHR3zU95UOC7uV5IBMrbm7JQ114KkxBE3HHqg7fbAVECHcs2Pyp5KjgajkRXChCXsY9DdM2R6ArsSYHdE9Ta0W5FsG5434gJ1pf6z213zNkGMMeoLQCSFo9PErHSGlpKVpD5Nv5Me+XhI+Jtz3YfjrT0/FFDG7zNizm6CGJ12P1vcJTAgMFGQ07Z/nlpxwiiGn73zSv2XQRVoDfb4YisduGf9p4HnwPAhOUuX4hmeXiUFpVELNjW4uKlGHkbybWrXV3LL152FYzmbhbnlA0/DOgFM/AuUQ1WoceW6ImbmyqT2cskcFnrPjwGPnWtIMUuH5drFMwd9Yt+FHuzrgWED6IKX4VwI3TpjWG55OaZGnVeAUnShdQRdy0WpzCX2vfmCizw5oltZdvnabn5Z9P8Hh8U04woWAXIso91nJ3aHATJQTEW9sKGe4g5PFvAOF0+Xh4X3MtoasggFRbuZnk4y18YBXllHDk1qUUIckUhBaKHLL8xMRipt34hsjYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099006)(18002099003)(3023799007)(11063799006)(6133799003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0t1ZGZjZ1RPK0cwcUtlQ0dLU3pPQm84MzdGSGxGSTh1Y1dtTlFJSkk4L1NL?=
 =?utf-8?B?a0lxOGhOZ0RLN2UxNWw3cEpEeEhHbS9oS3NRaVp0UGZjd3FRbHZkMkc0Z2Jz?=
 =?utf-8?B?VXV1ZTJ0UExYVzZHd2NyUUs2UmR0UzJieVZJRUVDajJxN3ByOTlWTU9OMWV1?=
 =?utf-8?B?NEYwWnZJcnVtTlpBTXRhQlFCczNlQWJKZC91WW40bFFTT1FpclordUR6SG5n?=
 =?utf-8?B?WURBRTVGY3BYekZna0tUR2JrT3I4WDJIcy9Ya0R6UC9meHNOb3htc1NacE4w?=
 =?utf-8?B?dGNFdUdqRVM1T2JaKytQR2JsSkFvVjhTZ0IzbDh3R1RVOEJIeGtwbDUwL0Va?=
 =?utf-8?B?QmtNODMxZ2dJZGtzZWU5M0VzTXBWc3V2SWdsKzVENjJkeTFmaE9kQnJac2cz?=
 =?utf-8?B?Q3hSNFVQN1FDcDFBcGwzZWk4WEFBbjIzZGZ2VTlncVh6SHcvWHNPRyt1N3JW?=
 =?utf-8?B?WDhzeXVrMHd2VFZqWThGeDEzK2VsU2NsUkxrdE1vUlpsZ2hlWFp4L3hBN0hh?=
 =?utf-8?B?Vy8yd2FuYTJvYmtuUnlYSVdNdk1MNUdocUlnZmVkRTZhMFdEN1RSZ3ZZWHJl?=
 =?utf-8?B?L09yL3h2SFY0UmJ1aktwTStpaTlJYnF2WVd0UGdIUlB5ZERNR2J2N2p2Mytl?=
 =?utf-8?B?YkMxS01INVZZY21JZk1tSGVIeUUvNXNQbEtGWkxFcng3ZDVCYmhhVmtud0pN?=
 =?utf-8?B?ak1yY1kvZUdnaVhCUVFBa2k4R0Y5SE01TDVoZUoyQnYrRm1CdzFjOEI1UkZv?=
 =?utf-8?B?aEdBWmZYVkFKRVZaTW1hYUJTaGdQUlJQckZKOEl5Sm1ZRnpHWloxMXNDdGpw?=
 =?utf-8?B?aSs2NEYwaWdqeUhqdEY0em90R3VjK0RhN2dyd2RoTmNNRldSd2ZpRlZZa2l4?=
 =?utf-8?B?YmRObGhLeUwxV0ZMRjViSG4vRldlSlI5dVVmdERoN1JtTGxQbFZ0WHlWSFN0?=
 =?utf-8?B?V1dOMjBiRXdIYlp1aktqK2pLTysvcW9qVlE0clZCWFY0dURvNDhvekdHY3NM?=
 =?utf-8?B?eEtpU3loUnB0V1AyczBWeFVoL3FTdktRZHhVK01DZ1pWSnkrVks2UGxuZkN5?=
 =?utf-8?B?eTdMVEdXeTNxRU1pQlppMmxHOE9maUR0VGVaUTZFaTB4ODV5dEtyYmRIQVZx?=
 =?utf-8?B?V081eUlpM2ZMV2tlRUVSSU5XdTJUZ2F6bFJkVlJEYklNV2tDRlppNkFwQ0Zp?=
 =?utf-8?B?Y2g2M0FFMlJnd2hzeDgybkd1NDBsc2ZyUGl0R0p6aUx6M1kwMlIwQWlyVlJr?=
 =?utf-8?B?SSt6MXdDMWk0NnVUazFmbmJudGRMSU14Z3RHUjJON2h3d0Y3KzNQbU5kOUJn?=
 =?utf-8?B?TXd3ZGE1Smh1dk5jdFM1bk0rQkRaSDRGWkNzVUdPUzduVURvNU04Q1NpTkt0?=
 =?utf-8?B?SjNpK2RoZGd1ZGc1WHdBcU02cVViamlvQjlyMkRnVHhFM21lNUdQaitrY0NH?=
 =?utf-8?B?dytmUHppLzFJV0RjdEE3bExuL2lFS1NXYnJPOFh1YXF6K1BLOWRCa2VSMjRm?=
 =?utf-8?B?L0lrZzR2bTB5T2RUZkxBT2hYb0w1NHI2UVJ6MEZEVjZEdTFnMm5TUWJGMGJQ?=
 =?utf-8?B?cDVPRWU2UnhrM3JTM2wvZDV5cnEzV3ExT1ptaFUydWYrRjBKejI5NkFvaDdB?=
 =?utf-8?B?V3V2a1pzQjMxQnB1TGI4Mm5zVGdndnZ5TTYwWExCY3h0SzF4K3FJTXdjalIx?=
 =?utf-8?B?NXlHR0twVXNLSCtNQlRCaE0zNEFoZk56bzJFbWZwY2swWS8zOTVDSjBTdGxh?=
 =?utf-8?B?ODFWcmFuRG54ekNSWTlFU1NweTI1YWkvdzdwSERkRlZEVEM1Kzl2WjJWU3k0?=
 =?utf-8?B?R0dFdWFPWThjUXdraDNFdkZYU08xWjdUbW1SUnNuNE5DcFhzdjIvemhpU3pt?=
 =?utf-8?B?NDJIVzFwODF1eTdNWkpEZ3NqdGdnTWZHQjJKY2ZaZGtHbTNNSTBsbGdQTDVj?=
 =?utf-8?B?dUhkZDZJanlDK3NGdXQzSXNIMmYzUXN4c0E3bXZ3UHlsS2xWaHkzbVdUaWNL?=
 =?utf-8?B?L0VTckZJVXJHcHRuR3FJTGJuRlc5ZDFYd1RLb3F3akZ4by9Wak5RbW5VWGNt?=
 =?utf-8?B?QTNZVG5jUTcrazlrUE91N2JPNExYQW1ZZXk4ck9hbUVFeDF6Y3htdWtGWlUr?=
 =?utf-8?B?QmFBeGZDb2VqeWpFME5pZFNJZjhZT2RaMGVFeXBoMzFZQysreGwvUDc4eFdy?=
 =?utf-8?B?dC9NdndKTS82RC9qTk5TQjhZaW94NUtTVVVoVGF2MWV3V29kc2xQQVJVejNj?=
 =?utf-8?B?YWRJZnpDNFI2NmdCVUZpMm95Unh4YTcyWEFyV0dlT2Q0d2VmUU02RjRxaWYz?=
 =?utf-8?B?MHFJM25FcGRVMGhDcS91YS80eUluMDdWbDZsRWN5Um5JdDFxVjlaZmo1S2c0?=
 =?utf-8?Q?4S++K+lRsjulbBJ0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a652f7-95cd-4493-a3a8-08debda6b6a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 17:21:26.4086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcF+JtdVV6QAW1nYxlVF/Z8y3JeCTYPiKlgxei8aCgvKfxB+d0LEpFMjfi74zgdI8U5TdPxFgBGdhpGhxj3ThurejtlFqyg7GgAKQI061AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8316
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

Hi Judith,

Thank you for the information. Let me share my analysis based on
what you have described.

On 5/28/2026 4:52 AM, Judith Mendez wrote:
> Hi Kathpalia,
>
> On 5/16/26 6:44 AM, Kathpalia, Tanmay wrote:
>> Hi Peng,
>> Thank you for reviewing and for the detailed feedback. Apologies for
>> the resend — my previous reply had an incorrect timestamp due to a
>> timezone misconfiguration, which caused it to appear out of order in
>> the thread.
>>
>> On 5/16/2026 3:14 PM, Peng Fan wrote:
>>> Revisit this patch, since it break one board [1].
>>>
>>> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12- 
>>> b796-4b8c2aa1822e@ti.com/
>>>
>>> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>>>> Some boards have SD card connectors where the power rail cannot be 
>>>> switched
>>>> off by the driver. However there are various circumstances when a card
>>>> might be re-initialized, such as after system resume, warm re-boot, or
>>>> error handling. However, a UHS card will continue to use 1.8V 
>>>> signaling
>>>> unless it is power cycled.
>>>>
>>>> If the card has not been power cycled, it may still be using 1.8V
>>>> signaling. According to the SD spec., the Bus Speed Mode (function 
>>>> group 1)
>>>> bits 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>> level. Thus
>>>> they can be used to determine if the card has already switched to 1.8V
>>>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>>>> transfer mode.
>>>>
>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>> ---
>>>> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>>>> include/mmc.h     |  3 +++
>>>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>> index ec61ed92e86..e1f62a5d0ad 100644
>>>> --- a/drivers/mmc/mmc.c
>>>> +++ b/drivers/mmc/mmc.c
>>>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, 
>>>> int signal_voltage)
>>>>
>>>>     return 0;
>>>> }
>>>> +
>>>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>>>> +{
>>>> +    /*
>>>> +     * According to the SD spec., the Bus Speed Mode (function 
>>>> group 1) bits
>>>> +     * 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>> level. Thus
>>>> +     * they can be used to determine if the card has already 
>>>> switched to
>>>> +     * 1.8V signaling.
>>>> +     */
>>>> +    bool volt = mmc->sd3_bus_mode &
>>>> +           (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | 
>>>> SD_MODE_UHS_DDR50);
>>> This is wrong.
>>> sd3_bus_mode is sd supported bits, not the current running bits.
>>>
>>> To detect the sd card running bits, need to use:
>>> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF
>>
>> You are correct that sd3_bus_mode stores the supported bits - as can be
>> seen in sd_get_capabilities() where it is filled from the CMD6 status
>> response:
>>
>>      mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>
>> However, the intent here is not to read the currently active function
>> code, but to use the supported bits as a proxy for the signaling voltage
>> level.
>>
>> According to the SD Physical Layer Simplified Specification v9.0,
>> Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed modes
>> SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only available
>> when the card is operating at 1.8V signaling. When the card is
>> initialized at 3.3V, those bits read as zero. Therefore, if any of bits
>> 2-4 are set in the supported field, we can safely infer the card is a
>> UHS-I card and, when not power cycled, retains 1.8V signaling.
>>
>> Using switch_status[4] to read the currently active function would
>> actually NOT work for this scenario. After a warm reboot, the card
>> receives CMD0 (GO_IDLE_STATE), which resets the card's selected function
>> back to 0 (SDR12/default) — even though the 1.8V signaling level is
>> retained. So switch_status[4] would always return 0 in this path,
>> making it unsuitable as a 1.8V indicator here.
>>
>>>> +    return volt;
>>>> +}
>>>> #endif
>>>>
>>>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>>>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
>>>>     ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>>>>     struct mmc_data data;
>>>>     int timeout;
>>>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>> -    u32 sd3_bus_mode;
>>>> -#endif
>>>>
>>>>     mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>>>
>>>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc 
>>>> *mmc)
>>>>     if (mmc->version < SD_VERSION_3)
>>>>         return 0;
>>>>
>>>> -    sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>> +    mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR104);
>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR50);
>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR25);
>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR12);
>>>> -    if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>>         mmc->card_caps |= MMC_CAP(UHS_DDR50);
>>>> #endif
>>>>
>>>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct 
>>>> mmc *mmc, uint card_caps)
>>>>     uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>>>>     const struct mode_width_tuning *mwt;
>>>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>> -    bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>>>> +    /*
>>>> +     * Enable UHS mode if the card advertises 1.8V support (S18R 
>>>> in OCR)
>>>> +     * or is already operating at 1.8V signaling.
>>>> +     */
>>>> +    bool uhs_en = (mmc->ocr & OCR_S18R) || 
>>>> mmc_sd_card_using_v18(mmc);
>>> In theory,
>>>
>>> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>>>
>>> OCR (including S18R/S18A) only reflects voltage switch negotiation
>>> capability and intent, not the current signaling voltage. So your sd 
>>> card
>>> should have OCR_S18R returned per my understanding.
>>
>> I think there is a gap in understanding here. The scenario this patch
>> targets is warm reboot or system resume - the card was never power 
>> cycled,
>> so it is still operating at 1.8V signaling.
>>
>> In that situation, when ACMD41 is re-issued, the card will NOT assert
>> S18A (Switching to 1.8V Accepted) in the OCR response, because the
>> voltage negotiation already happened in the previous session and the 
>> card
>> has no need to re-negotiate. Per the SD Physical Layer Simplified
>> Specification v9.0, S18A is set only during the initial 1.8V request
>> handshake. A card already running at 1.8V will not set S18A again on a
>> subsequent ACMD41 after warm reset.
>>
>> This is exactly the corner case: OCR_S18R/S18A will be zero, yet the 
>> card
>> is already at 1.8V. The existing code misses this entirely.
>>
>>>> #else
>>>>     bool uhs_en = false;
>>>> #endif
>>>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>>>>         err = sd_get_capabilities(mmc);
>>>>         if (err)
>>>>             return err;
>>>> +
>>>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>> +        /*
>>>> +         * If the card has already switched to 1.8V signaling, then
>>>> +         * set the signal voltage to 1.8V.
>>>> +         */
>>>> +        if (mmc_sd_card_using_v18(mmc)) {
>>> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
>>> Forcing switch to 1.8 here has some risk.
>>
>> Agreed - ACMD41 is required to initiate a voltage switch on a card 
>> that is
>> currently at 3.3V. However, in this path the card has already completed
>> the voltage switch in a prior session and is still running at 1.8V. 
>> There
>> is no card-side voltage transition happening; only the host controller
>> needs to be reconfigured to match the 1.8V signaling level the card
>> retained. Sending ACMD41 again in this context would be incorrect, as 
>> the
>> card is not in a state to re-negotiate voltage.
>>
>>>> +            /*
>>>> +             * During a signal voltage level switch, the clock 
>>>> must be gated
>>>> +             * for 5 ms according to the SD spec.
>>>> +             */
>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>>>> +            err = mmc_set_signal_voltage(mmc, 
>>>> MMC_SIGNAL_VOLTAGE_180);
>>>> +            if (err)
>>>> +                return err;
>>>> +            /* Keep clock gated for at least 10 ms, though spec 
>>>> only says 5 ms */
>>>> +            mdelay(10);
>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>>>> +        }
>>>> +#endif
>>> A proper redesign is required. So I am going to revert this patch.
>>>
>>
>> I would respectfully ask to reconsider before reverting. This patch is
>> specifically targeted at the warm reboot / system resume / error 
>> recovery
>> scenario where the card is not power cycled. The check in
>> mmc_sd_card_using_v18() acts as a guard - it only triggers when the
>> card is already at 1.8V and the normal OCR path did not catch it. On
>> a cold boot with a fresh 3.3V card, the UHS supported bits will be zero
>> and this path is never entered, so it cannot regress cold-boot behavior
>> for any board.
>>
>> Regarding the reported regression [1], Judith mentioned that he will
>> debug once he is back. If possible, let us wait for him to conclude
>> before deciding to revert.
>
> So I started looking at this. So far, I have found that on AM65 u-boot,
> we had been enumerating to SDR104 mode once during boot and finally
> resolve to HS mode right before loading the kernel.

This seems to be the root of the issue. Entering SDR104 mode transitions
the SD card, the IO signal lines, and the host controller all to 1.8V 
signaling.
Once that transition happens, attempting to switch back to HS mode (which
requires 3.3V) is not possible without a full power cycle of the card.

This is explicitly stated in the SD Physical Layer Simplified Specification,
Section "UHS-I Bus Speed Modes Selection Sequence":

   "Once the card enters 1.8V signaling mode, the card cannot be switched
    to SPI mode or 3.3V signaling without power cycle. If the card receives
    CMD0, card returns to Idle state but still works with SDR12 timing."

So the failure you are seeing is not introduced by my patch — the card
was already non-recoverable to 3.3V from the moment it entered SDR104
earlier in the boot.

>
> Also, sd3_bus_mode=0x1f at u-boot stage.

This confirms the card was already operating in 1.8V signaling when your
debug point was reached. For reference, on a fresh cold boot at 3.3V, the
CMD6 available functions table shows sd3_bus_mode should read 0x07
(only SDR12/SDR25/HS bits set). The value 0x1f means bits for SDR50,
SDR104, and DDR50 are also set, which per the spec only happens when the
card is initialized at 1.8V signaling. This is exactly what
mmc_sd_card_using_v18() is designed to detect.

>
> Something weird: from the schematics, its does not seem like the IOs are
> switching to 1.8V with on board hardware PMIC.

This is worth investigating further. If the IO lines are confirmed to be
stuck at 3.3V while the card is operating at 1.8V signaling, that would
itself be a pre-existing hardware or driver issue — the IO voltage and the
card signaling voltage must always be in sync. I would suggest:

1. Verify the voltage regulator driving the IO lines (Vccq) and confirm
whether am654_sdhci_set_ios_post correctly switches it to 1.8V when
UHS modes are selected. If Vccq is not switching, that is a separate
bug in the am654 driver or the regulator configuration.

2. Try using UHS_SDR12 or UHS_SDR25 as the operating mode instead
of HS. Since the card has already transitioned to 1.8V, the UHS-I modes
are the correct and spec-compliant modes to use. Running HS mode at
1.8V is not a valid combination.

>
> It seems like the call stack has changed where previously
> uhs_en=0 in u-boot and now with your commit uhs_en=1, right before
> loading the kernel. 

Correct. Previously, even though the card was operating at 1.8V (as
evidenced by sd3_bus_mode=0x1f), the code was not checking the card's
function group 1 to detect this. So the host stayed at 3.3V while the
card was at 1.8V — an incorrect but silently failing combination on
platforms where the mismatch happens to be tolerated.

With the patch, we correctly detect the 1.8V state and instruct the host
to match. The subsequent failure you observe is because the host-side
IO voltage switch (Vccq) appears to not be working.

> After this, we call am654_sdhci_set_ios_post
> multiple times at mode=0 & signal_voltage=0x2 until mmc_init failure.

mode=0 corresponds to MMC_LEGACY, which is a 3.3V mode. Having
signal_voltage=0x2 (1.8V) alongside MMC_LEGACY is not a valid
combination. This suggests the mode selection logic is landing on
MMC_LEGACY while the voltage has already been switched to 1.8V, which
will always fail. The fix should be to ensure the card operates in a
UHS-I mode when at 1.8V, not fall back to MMC_LEGACY.

>
> I realize this is not the most stable platform and there could
> be hardware issues for SD. Perhaps it is a good idea to create
> a quirk to skip over this section for these kinds of platforms?

I would prefer to avoid a quirk at this stage, as the underlying behavior
— the card being at 1.8V after a prior boot — is spec-compliant and
real. A quirk would just mask the issue on AM65 rather than fix the actual
IO voltage switching problem.

>
> What are your thoughts? I will continue on this debug
> and come back if I find more useful information.
>
> ~ Judith
>

Hope this helps, looking forward to your further findings.

Thanks,
Tanmay
