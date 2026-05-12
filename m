Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1707ACD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B52B80398;
	Tue, 12 May 2026 11:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Min9fS6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C2F8394E; Tue, 12 May 2026 11:45:49 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56425801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVcl+XYliK0tsvj78n+K1GDdb4YW5UHQvYjwyiRRctrt9n1rCGgYlgbu99IIrPAbIRXjyu7xRtGGBcTDcNtL4S54Rx1BGth4IaCCVBCKWCFofFMq64icxzAEwqcSFC8kM7Fi/nOhKmXDqKmqVr4xY+gwLhfoJgDF6v6+tT00piztcobWkGROHp2fWBfnIaWZXUWn7uOStXXTvmKOQcJy4wyfNZvJy5H2VQLmHdmdbeRbjx6lsvVhbOv9SDAtYShin1S6OY7ut8l+9Xh2mnM33sp58hc1Nx+/r5Jc7SVB6HotdVyxVzw5kTKIpNTEOZXDrkJh4S56RA/zKj6WnEmvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpLJJSM7B0HU9Hxo9nlrhZhyniL/SrYZoSUiMHj1Z9Y=;
 b=W01OPwAEpZfdYgIT2f9BxtyX1U+92/P8kP1FrNHH6KVTqZeTBdi9KAGAgFGcUs+UlBjHDx2VkZSncWLQgqpber8/+2Y71KWwaW9y/1AmXdWPTI/3q5ewQWOj8WnIKDa0IlGn7AlialV0ukFx3LTA9Ygi1KohFjYooK43WGocgenLe7s1qoawA4LOoQE2+fnHoc9DSZHG2k7oA1kNX+CzJrNuws0kLAezxfSGb7KexT2s1Q6hgE/TJlFVyG90Uc4bTodjlaGszgZIIozBwy2j8+KwOxbxfZOxmQcqQTqYazRtOKQohTbIya0eQXyqb16XgoBs1u3V6KDGVDR1+qMh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpLJJSM7B0HU9Hxo9nlrhZhyniL/SrYZoSUiMHj1Z9Y=;
 b=Min9fS6h/56XbePPj45Ga38ai8WVbsCRJGzV4+1Qb1dmwSYKG/FPYf1mNKm49MLEyovzqCeGyhNPywBDzKoNt4Ist1p/GBFofdpOoAQGDIyZQdoy9yhy4lQY9BgdRdj1dzCPYYB2gXR6ItP5sQiX57lfuWcnenueG49UkJf5EdE02b2K1vmOB/lMB2OIYc3lHja/TaDsx+XvHEj5e0qOQh414xKaHH8aJYZL0zlkDGO037wZK1Un+THoccsd0RjZyAlvGIfbEj/WnATRwEE/LGfYBJlMxHoJxvv/eqbyc4ngHQR3e4Ejq3byhzV3v37ilaZUvpXHsGwy8tu/Tl4XXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH2PR03MB8115.namprd03.prod.outlook.com (2603:10b6:610:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 09:45:44 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 09:45:43 +0000
Message-ID: <eef968b9-c861-4c56-82c0-fb750d5e128a@altera.com>
Date: Tue, 12 May 2026 15:15:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: trigger tuning for SD HS mode on
 SD6HC (v6) PHY
To: Peng Fan <peng.fan@oss.nxp.com>, tze.yee.ng@altera.com
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <f385cf516e8a75fff5c90aa9e54f8e54044f0dd9.1777947009.git.tze.yee.ng@altera.com>
 <afqkA0gI773LcIqx@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <afqkA0gI773LcIqx@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To BN9PR03MB6204.namprd03.prod.outlook.com
 (2603:10b6:408:101::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH2PR03MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: bd77387e-eaaf-416b-807f-08deb00b3b6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|11063799003|55112099003|10063799003|3023799003;
X-Microsoft-Antispam-Message-Info: XeewfLy8KD8lgWklUL/LZtm2cmZGVjoVGU3l606bDH75iS1Y24Q6NFQmopXCyeChzC8FwNn5dL9uob9e90rZyAPt6gTstSbmM6Jf0e5wVjGgZ+42fQeEswRPhaGAfspAj5xatOM6ZTyyxwKO0cJmFSZnWm3inyP730zgOUjf37ywvfZLbbS7GUtBf53IhrcaxRZ3rrqhy2tPhDjdrFtQTQRNeRclKLlTWEUa8gYnF+POAgBx9elkcVwxE1jvliOtVBrpfTNa0MFa9H9GspEtAiNi0jC/ZuhmJsLHjEBzUFAH6U3MSx9UW9JMSdWITW02vJXjgMTKx3o17hNpI9ah16T9GIFIH0RoJqEwTjp8Hx+TT5LKIzWllurYsFeBjF/0/0hsRyWusQ0MOt4FcoNdHsbQuhNZ97dM350onqGxi8kqR/Cvn6XOH0/d+jElSey1zBLF/bx4u47TEV04gMdGhQssDfaLIuHl0h3YTCzdCwPb2cumpPP1uP1tFfx0O5qbUX/jh4nMFFRpeGGZqCzh47vbPoezoBI7Aw0R1YejRWGXBMUfx2f0l9ozsWdKfg73ZCLkAe0+KcHnSnqRKdnq9Uo1M6KosJmcjoPPMgjx2M0XAHyuPDAB544bnf72IeT7UDTSTfjVaKVvilSM8Xam6z9BTCfHXo2XyOrOQ49h69TW8OpWxw2g7o47yFe7qdyV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(11063799003)(55112099003)(10063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1aTmJHUEVaRUsrdjhPUzdJaXN3d083cnpwaTc5K05SN1Q1Y2kyaHc0N2Fl?=
 =?utf-8?B?WVovMGdrQ1pMWUJuSDJaZWprb0NwL2J1TnNLMlVHRDFaYUpscmxPenc1aFYy?=
 =?utf-8?B?UEM5TTY5ZUNZaUk5a3dFS1ptWnYrSytkeG50YjZpMS9kRUtSd3M4WDc0TFFN?=
 =?utf-8?B?ZDAvWmVESkdpUSswWXdrS3JaSVJUcE5tdkdhWlpmbFdaS0FETC8vaWt4YXVX?=
 =?utf-8?B?eVE0WUkwaXBLVk9Tb3AxREx3L1QzanVOaWV2L1FqOW4zVm1HVHVuUzRXRFFM?=
 =?utf-8?B?RjRKUVc1YjBKeHoyK1VUWEdhSDJRV1ZJZjNBRGpKUG05TEdBWGVtSUMyOEkr?=
 =?utf-8?B?TjRBck9ZZTRHMHdDR2FqRmFwSXBhZUFiaHFMeXBZNGlMSGhDMVc1TUFzRWow?=
 =?utf-8?B?dE9RWGhXdTg3VTgzdXQwdlNZYStpeVJPOWdaN0V3WTkzR3NMSFBTZUJZT1dC?=
 =?utf-8?B?UHIxSWoxTE9CWFRUSVZGUEl1NFB2SEhNTk9tZjBkWVFHa1oyT3RMQmo5NjBy?=
 =?utf-8?B?K1YvWjRESEdBdU42Sk0xYjhvbUZ3RXFOQTRndHdYMlA1VDczMVBlK0U1Z2tD?=
 =?utf-8?B?MWNBY1o2Q0YxWjRLOTQvcUdPMG9PUUpsSytLNzhSU2xOK2wwV0N4OVBNWVlM?=
 =?utf-8?B?VmsxQ3ByRjJKKzg4QVBsRkNkUlhnUjdHUWQvQm1USGlCS2V5SituSERmcGpC?=
 =?utf-8?B?ZTJ5WHNFR3ROU0U4OXJvczJQb0tXZmY4RUtmaFE2RUhteWhvQUN3ZGdabVRq?=
 =?utf-8?B?UDFnUndkeDhYSzA0VFVCbEtiZXNObmwvcUF2V0hsOHJoR0NiY3R2ZmZaQU9E?=
 =?utf-8?B?V0liOVRrcnNKUk1FMmtkSFRxa1NQSkdHL2J1bjBoMVFJbGl6c3phRG9NVE54?=
 =?utf-8?B?MEp5amNxUGRoR2dCQyt1cjZMbzRuU2NpK3NXZU1qN3pFTU5HQ2JDS2h6Z2Fx?=
 =?utf-8?B?U0owVndTOTRDOGg2Z1NyVHI0Y09Pb0hwVXpPM2JpRU8rN3NTQ0s1aFI1ZVdW?=
 =?utf-8?B?eFkvd0FsdElDc0tvYnRVQnp6TUJsTzBHZE00WGx6Qnh4NTZOTGlyclVyVm8x?=
 =?utf-8?B?dWFYVUZMd1pmazF5QnNGRzhPUHROQTh3a1RDK09zZGdYSnNUUjFjV3NnVy84?=
 =?utf-8?B?VUY3cFM2cDl2U3BkNEc1eUIwRE9IMndVUTIyNkdCazlFQUVWcGZGOG5abEdY?=
 =?utf-8?B?NUNNbmlKTWg5TW04WmVUcmRJYlk0UU1JTGIvcXdWdGlrUEtzVS9CNVB3ajZx?=
 =?utf-8?B?Y05KYWZZK0JmU0pQWk1aVVF3eGFaTG44SmpqVXRiS0twcXRSREVsekp0Y1Ay?=
 =?utf-8?B?aXVZeEt1QklyQkJZSXlKdTIrVnNEZ0Z3TStsZmtoZFFjWmxlQXlEOEJYSm5K?=
 =?utf-8?B?TnJYYmpSdGxOaDI4YUgyY0JxRGpuZjNNTCt0NEJXeFRaVW1YZ090aDB5MHAz?=
 =?utf-8?B?akxZNUlmdW5wODA5R0J1Unk5VU9NUzl1ZzBJQmU2QklmSnh1VUVhVTlsbHU1?=
 =?utf-8?B?bWFrVklXUmpRQ0hWMWJ6NlNwWkswOEI4T0Z2aW1YMUZTeDRZRVlpTFY5Z3JB?=
 =?utf-8?B?dGlhcWFzeHF6dm5nNWdCam42QmFEY3lRTklhSHF4dEZxTGk0MFRSdGxkamFK?=
 =?utf-8?B?STdxRHRuMVNIVWxzbFhkcElMbTUrL0JYMzkrcVhUS1VJWElxL0JMQ1lXcjlP?=
 =?utf-8?B?ZWRKb3A3bVFpSHVTY0pSQTg0bE9QWTRMVlF2djRmSG0yMW5Mb1kwTWh6RldU?=
 =?utf-8?B?c01ETExicWpQV0pHczhFZ2JONXg1R3pBcVVxTkhpLzJjMEM2alovYnR1NXlC?=
 =?utf-8?B?QzBTazk3QUtOYmpNa094YVJTYUhOWjV3cFo5R2RvUGlNakN1bzFQYVo3bDJa?=
 =?utf-8?B?dklvTVgyK1B1b1NSTTQ2UlpNYVlxamNsMlcvNnNnMXovcFExTW5XcjYzN2Z0?=
 =?utf-8?B?K1RxRTEzd0dBV1R6c0p4UXQ1OFMxWFM4eC9FZzJveTdLV0JsM21lZTh5b0Jj?=
 =?utf-8?B?bjZLWVYxZlBHbG9LOFBhbTVUNThCL0R1Rmp2ekpJdExLY1JXenlqRktrbWJP?=
 =?utf-8?B?VFBXVmZpOG5uejFmTXZPemovQTlreVZ6a2RkM3JQVXBRQWVmY1hQaG9KeUd4?=
 =?utf-8?B?dmZnako2aXlLWmp5ZjlVUUx2dkJ5enNXRXhuNng3aEN1Ym5RSWNrR204bHJ3?=
 =?utf-8?B?cUN6NlVzR1YxeTBtVW1Qb0h3WXNZd0xJek9tUjE3ZlgyV0Z4eFJmd0VlK2Yy?=
 =?utf-8?B?Q3p4VmtzTVBIbUJhWW03L3p6NkJRbzRCN29RcHJFdXphNGh4L2JKUFRkWHcw?=
 =?utf-8?B?c0owOUhPalpzcTAzRFlWRkhpbUYvSkZjWUd0MmtLMDdocVpNcUZrR3IxajFr?=
 =?utf-8?Q?q7YQhEfTjlcE0+7I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd77387e-eaaf-416b-807f-08deb00b3b6c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6204.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:45:43.6938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /evLvxvGbG0z4pVuIkeDKnWZ5ncBtwlVxTShvwHcaN1U9OKuOFTiIt7KR72DWBPAMXm3Qmqfwuvc+DK7u0Zp/Uniqlyn6ZNjfljucCuu2gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8115
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

Hi Tze,

On 5/6/2026 7:44 AM, Peng Fan wrote:
> On Mon, May 04, 2026 at 07:36:03PM -0700, tze.yee.ng@altera.com wrote:
>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>
>> The Cadence SD6HC (SDHCI spec v4.20+) controller uses a soft PHY whose
>> DLL delay characteristics vary with PVT (Process, Voltage, Temperature)
>> and board-level trace routing.
>>
>> A static delay value programmed via device tree for SD High Speed mode is
>> insufficient because the optimal sampling point varies per board, SD card,
>> and operating conditions. Runtime calibration is required.
>>
>> While the SD Physical Layer Specification does not mandate tuning for
>> SD HS mode (only for UHS-I SDR50/SDR104), the Cadence SD6HC PHY
>> requires runtime calibration of its receive data delay line to find a
>> valid sampling window under constrained clock conditions.
This characterization is incorrect. The SD Physical Layer Simplified
Specification v9.00 Section 4.2.4.5 explicitly states:

"CMD19 can be executed in transfer state of 1.8V signaling mode
while the card is unlocked. The other case, CMD19 is treated as
illegal command."

SD High Speed operates at 3.3V signaling. Issuing CMD19 in SD HS mode
would cause a spec-compliant SD card to return an ILLEGAL_COMMAND error.
The spec does not merely "not mandate" tuning for SD HS — it actively
forbids CMD19 outside of 1.8V signaling mode.
>>
>> The tuning is triggered from the set_ios_post callback because at that
>> moment hardware has committed the new bus width, clock frequency, and speed
>> mode to the controller registers. This ensuring the tuning sequence runs
>> at the correct SD HS operating conditions.
>>
>> The tuning is gated by a device tree property "cdns,sd-hs-tuning" so
>> that only boards requiring runtime calibration opt in. When enabled,
>> the driver performs a 40-tap DLL sweep using CMD19 to find the largest
>> consecutive passing window, then programs the midpoint into
>> PHY_DLL_SLAVE_CTRL_REG.
>>
>> To enable on a board, add to the MMC node in device tree:
>>
>>     &mmc {
>>         cdns,sd-hs-tuning;
> Has this property been accepted by Linux Upstream?
>
> Regards
> Peng
>
>>     };
Please rework this to perform PHY calibration internally without issuing
CMD19 to the card in SD HS mode.

Regards,
Tanmay
>>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> drivers/mmc/sdhci-cadence.c  | 108 ++++++++++++++++++++++++++++++++++-
>> drivers/mmc/sdhci-cadence.h  |   5 ++
>> drivers/mmc/sdhci-cadence6.c |  45 ++++++++++++++-
>> 3 files changed, 156 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
>> index 5bbc18dfa51..a76f9e8d6bd 100644
>> --- a/drivers/mmc/sdhci-cadence.c
>> +++ b/drivers/mmc/sdhci-cadence.c
>> @@ -39,6 +39,9 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>> 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
>> };
>>
>> +static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
>> +						    unsigned int opcode);
>> +
>> static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
>> 				    u8 addr, u8 data)
>> {
>> @@ -155,8 +158,93 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
>> 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
>> }
>>
>> +static __maybe_unused bool sdhci_cdns_sd_needs_tuning(struct mmc *mmc)
>> +{
>> +	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
>> +
>> +	if (!IS_SD(mmc))
>> +		return false;
>> +
>> +	if (!dev_read_bool(mmc->dev, "cdns,sd-hs-tuning"))
>> +		return false;
>> +
>> +	/* Already tuned for this mode */
>> +	if (plat->tuned_mode == mmc->selected_mode)
>> +		return false;
>> +
>> +	switch (mmc->selected_mode) {
>> +	case SD_HS:
>> +		return mmc->bus_width == 4;
>> +	/* Add future modes here, e.g.:
>> +	 * case UHS_SDR50:
>> +	 *	return true;
>> +	 */
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static int sdhci_cdns_set_ios_post(struct sdhci_host *host)
>> +{
>> +	struct mmc *mmc = host->mmc;
>> +	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
>> +	int ret __maybe_unused;
>> +	/*
>> +	 * The SD6HC soft PHY requires runtime DLL delay calibration
>> +	 * for SD High Speed mode. The default PHY_DLL_SLAVE_CTRL_REG
>> +	 * values (READ_DQS_CMD_DELAY and READ_DQS_DELAY = 0) do not
>> +	 * provide sufficient timing margin due to PVT and board trace
>> +	 * variations.
>> +	 *
>> +	 * Tuning is performed once per entry into SD_HS mode
>> +	 * (tracked by plat->tuned_mode state). The calibrated PHY delay
>> +	 * values remain valid while the card stays in SD_HS mode, and
>> +	 * leaving that tuned mode clears the state so re-entering SD_HS
>> +	 * triggers tuning again.
>> +	 *
>> +	 * This must be done in set_ios_post (not set_control_reg)
>> +	 * because the SDHCI controller must already be operating at
>> +	 * the target bus width, clock, and speed mode before CMD19
>> +	 * tuning commands can succeed.
>> +	 */
>> +
>> +	if (IS_ENABLED(CONFIG_MMC_SUPPORTS_TUNING)) {
>> +		if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420 &&
>> +		    sdhci_cdns_sd_needs_tuning(mmc)) {
>> +			ret = sdhci_cdns_execute_tuning(mmc->dev,
>> +							MMC_CMD_SEND_TUNING_BLOCK);
>> +			if (ret) {
>> +				dev_err(mmc->dev,
>> +					"SD_HS tuning failed (ret=%d), using default PHY\n",
>> +					ret);
>> +				/* Restore default PHY settings and avoid retrying in this mode */
>> +				sdhci_cdns6_phy_adj(mmc->dev, plat,
>> +						    mmc->selected_mode);
>> +				plat->tuned_mode = mmc->selected_mode;
>> +				plat->tuned_dll_slave_ctrl = sdhci_cdns6_phy_get_dll_slave(plat);
>> +				return 0;
>> +			}
>> +			/*
>> +			 * Tuning succeeded. The tuned_mode is already set by
>> +			 * execute_tuning(), so the tuned value will be preserved
>> +			 * across subsequent PHY reconfigurations.
>> +			 */
>> +			dev_dbg(mmc->dev, "SD_HS tuning successful\n");
>> +		}
>> +
>> +		/* Reset when mode changes away from a tuned mode */
>> +		if (mmc->selected_mode != plat->tuned_mode) {
>> +			plat->tuned_mode = MMC_MODES_END;
>> +			plat->tuned_dll_slave_ctrl = 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> static const struct sdhci_ops sdhci_cdns_ops = {
>> 	.set_control_reg = sdhci_cdns_set_control_reg,
>> +	.set_ios_post = sdhci_cdns_set_ios_post,
>> };
>>
>> static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
>> @@ -204,6 +292,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
>> 	int cur_streak = 0;
>> 	int max_streak = 0;
>> 	int end_of_streak = 0;
>> +	int ret;
>> 	int i;
>>
>> 	/*
>> @@ -229,7 +318,24 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
>> 		return -EIO;
>> 	}
>>
>> -	return sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
>> +	ret = sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Mark this mode as tuned. This is critical for both driver tuning
>> +	 * (SD_HS via set_ios_post) and framework tuning (UHS_SDR104, MMC_HS_200,
>> +	 * MMC_HS_400) so that subsequent PHY reconfigurations restore the
>> +	 * calibrated DLL value instead of overwriting with DT defaults.
>> +	 *
>> +	 * For HS400, tuning is performed while the controller is in HS200 mode
>> +	 * (mmc->selected_mode == MMC_HS_200 and mmc->hs400_tuning == true).
>> +	 * Record the tuned mode as MMC_HS_400 so the calibrated DLL value is
>> +	 * preserved across the HS200???HS400 transition.
>> +	 */
>> +	plat->tuned_mode = mmc->hs400_tuning ? MMC_HS_400 : mmc->selected_mode;
>> +
>> +	return 0;
>> }
>>
>> static struct dm_mmc_ops sdhci_cdns_mmc_ops;
>> diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
>> index 7101f00b75b..ea517491860 100644
>> --- a/drivers/mmc/sdhci-cadence.h
>> +++ b/drivers/mmc/sdhci-cadence.h
>> @@ -7,6 +7,8 @@
>> #ifndef SDHCI_CADENCE_H_
>> #define SDHCI_CADENCE_H_
>>
>> +#include <mmc.h>
>> +
>> /* HRS - Host Register Set (specific to Cadence) */
>> /* PHY access port */
>> #define SDHCI_CDNS_HRS04		0x10
>> @@ -60,10 +62,13 @@ struct sdhci_cdns_plat {
>> 	struct mmc_config cfg;
>> 	struct mmc mmc;
>> 	void __iomem *hrs_addr;
>> +	enum bus_mode tuned_mode;
>> +	u32 tuned_dll_slave_ctrl;
>> };
>>
>> int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode);
>> int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat);
>> int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
>> +u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat);
>>
>> #endif
>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>> index ca1086e2359..c8b42532e17 100644
>> --- a/drivers/mmc/sdhci-cadence6.c
>> +++ b/drivers/mmc/sdhci-cadence6.c
>> @@ -173,6 +173,30 @@ static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 addr, u3
>> 	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
>> }
>>
>> +static bool sdhci_cdns6_mode_is_tuned(struct sdhci_cdns_plat *plat, u32 mode)
>> +{
>> +	/*
>> +	 * Check if the given mode has a valid tuned DLL value.
>> +	 * Only modes that support tuning (driver or framework) can have
>> +	 * valid tuned values. This prevents the initial state (tuned_mode=0)
>> +	 * from falsely matching MMC_LEGACY.
>> +	 */
>> +	if (plat->tuned_mode != mode)
>> +		return false;
>> +
>> +	switch (mode) {
>> +	case SD_HS:		/* Driver tuning via set_ios_post */
>> +	case UHS_SDR50:		/* Future driver tuning support */
>> +	case UHS_SDR104:	/* Framework tuning */
>> +	case MMC_HS_200:	/* Framework tuning */
>> +	case MMC_HS_400:	/* Framework tuning */
>> +	case MMC_HS_400_ES:	/* Framework tuning */
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
>> {
>> 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
>> @@ -259,7 +283,18 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
>> -	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
>> +	if (sdhci_cdns6_mode_is_tuned(plat, mode)) {
>> +		/*
>> +		 * Use previously saved tuned DLL slave control value.
>> +		 * Note: 0 is a valid tuned value (e.g., optimal tap at position 0),
>> +		 * so we check both mode match AND that it's a tunable mode.
>> +		 */
>> +		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>> +					  plat->tuned_dll_slave_ctrl);
>> +	} else {
>> +		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>> +					  sdhci_cdns6_phy_cfgs[2].val);
>> +	}
>>
>> 	/* Switch Off the DLL Reset */
>> 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
>> @@ -318,6 +353,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
>>
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
>>
>> +	/* Store tuned DLL slave control value which will be reapplied via set_ios(). */
>> +	plat->tuned_dll_slave_ctrl = tmp;
>> +
>> 	/* Switch Off the DLL Reset */
>> 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
>> 	if (ret) {
>> @@ -327,3 +365,8 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
>>
>> 	return 0;
>> }
>> +
>> +u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat)
>> +{
>> +	return sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
>> +}
>> -- 
>> 2.43.7
>>
>>
