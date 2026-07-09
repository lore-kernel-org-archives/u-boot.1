Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC25BC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CD184BC3;
	Thu,  9 Jul 2026 17:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0fqeHpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EBC784BEC; Thu,  9 Jul 2026 17:20:49 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F05D84B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QR1BGYnL+/yvvbtwkAerUpfWOfA24u6z7IVJt6iExu8HlwrIvt6sYCpR4VCpZk++HeHoqsum3DvcXJTyd4OEHNJ3bg7O1Z4FdKOC+8EbWBOYK+vAP6QqzvqlmUru9Qaej0We7ADZ+L8Ri/fTabqCGZ/E9B54gGvhTar/Iis6cBR7U9NtH25D/DQT5PKoewZSBkOhxXrID7uLYeA3xc36Ofocsu8ZHvvblOeg0cDop2ZK1JdyDOJmvcecIrMAlVgBVd5EDgJWXNva7D7TGuuHLsyK5SxhCcLCYqzQpO3esi98uOkvNe/V5qj+ngke9eyNT17yDQi/lRi8wsF5ozCOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emhV4dQ//uGos06B9kEa9V4KJ97wIJcKy5Ki0JRZ1qg=;
 b=RAYfAIUfWoPdimfVtlT37JlksEBlhNvhdzdvBw4bs2FeKBRAm+CaOhYK+f5U5I2L+AnKgbnvO5ttXAs7tH/HW4Mxlh0IskiAWr9k87I+NefR6fPGC70so1b8Fwqmb+RC9R4vfHPk2mrK+A0gTzIMcujx1Qc+ts4CpWxoZE2NABZVr9aCLsdPO4b5BJp4d/XB1c1vh7bx2RYxXszN2hy1aWkQFI2esQsAZRladMyLAlg3jE4eWl+CvxFOffNXSjWbs07Erq43oOZomm6gQNGZatu7uG7j95l6H5STviPjWhW4JBPyR0qox82U+HVD8rlkPUW8F3fCb3YsZzqGUm7m2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emhV4dQ//uGos06B9kEa9V4KJ97wIJcKy5Ki0JRZ1qg=;
 b=b0fqeHpeded4P5mU3zA5GFbnOXTS2JkZiuPOrsf/r62PEy1o9P4Awb7EjYV/hUuNqihRqRvd8YGMvc3es1i0Ku5tIispOVABoZGycEx73U3t2Z8RdvkOAxN6gMvT2BE+VFgbEXvr1+aJpmvplcMTPcqz1MVW72m4iazdd1Ubtmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 15:20:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 15:20:43 +0000
Message-ID: <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
Date: Thu, 9 Jul 2026 17:20:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
 <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0232.eurprd08.prod.outlook.com
 (2603:10a6:802:15::41) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ffe7fd-268c-4448-988f-08deddcda4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TViGRvtYoUbYT/XFNG5l/v1EQC5EdM9/NRFBJCUiQ6VQekV7uSipdqGeL5AiXP+q8OLKCsYK4tFEURZBGd04CJAkTNG/s8y+QlaK5aAMSflizOiBKYgEyyPR4awhXRX9cidGyNANDdt5hwJFXTq6sO1IO16gLFXk6qmB5zUg/UyG25SfEi3u0IVomV5zhEBgmg0/XvQ4hly+2qYduYU3NTejsxPHC6lIEOZqkGaH0TSJo0YptM/K8Kr2lnaNF2XQQOfWNsJ28MyU9w+1t/jTccjXbNE9GD+hgTOE71ilMsHtxCkCWWuOTzh/fXJ3NjJU+awiYrIG+I6qMd2k2x1VBqR6zjGIExFkpQb9NOMXJkwqfhmbG3rIzsmvibZCABOVipub6wucW2SkpKguPDSLR7REq+gHSTu+4WsiM/gz9pv/+wkOwceKi0POSAm3zPKAMWjLwRbiJJKfLXy0QDO7x82mcYJZA525pygk8UZNF/R46R45hZF4SpqT99BLXpSOQhZSoui8z6XUYAqlmaEq7DwZhzeTGZTVW6Lhl4oUGmzKVRKnXhDoEM+xg3J1sLn6Y3GKll4Kw9IrHkJ2IZd7E65/g4/ShRXM8J4QvTcP8Z7i9y2by5XzcQ6FCGi4h3+M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmR0K1UzSVUzTmtDWUhwM2Z3ZFd5YUNvWFpadGw0TkRPMm1aV0FocS9iOHdI?=
 =?utf-8?B?WXg0aXVjYm9zaDA0YmNSS1VxS1JDMndheHZmejkwZ3MrM0tLd3BXam4vUjF0?=
 =?utf-8?B?K2FjYlRaRitOLzJQMzJ2eHNLVDFYZTZ4elFQNmZjM2NJQmYzRUs5eXNEZCtR?=
 =?utf-8?B?WW8wVFZROGRJQlZwYnN1Z0diVGIwdHFYNkhrdEswNTJRbGdOZjZtYVJWWDZw?=
 =?utf-8?B?dGFrUXlYdG4wWXpzdUNONVBhMVBEUnlDNGlTWG9sTDNSWUVSWXpERHJCb0Nm?=
 =?utf-8?B?RUErNlhNV0tlcHNpeGVKMlZYOXdFWk9OUmY2cllMR0hjWU4yZE1aenFUUUdY?=
 =?utf-8?B?cmN1ZDVTVmVhZks0cHcyVXR2RDA5SkozaGJab2N5TDNDS2RBRGNkTXVjdmVI?=
 =?utf-8?B?bWJaVExiak95bC8zVU5icmZQdTZtNU5Dc1lVWTdxMHdIMDJSaWZLOHE3QWlv?=
 =?utf-8?B?c2pIcmxnTEhCUmpjdUxxYVhCcUZWOWpidWR2RDNTcFRwWTNPUjA2UzVSWDFv?=
 =?utf-8?B?THA3VlIrczFnNzNuSGxhclZOaDVYclBkT2NuREFmZjJuSHpmVzlCNGIydVQz?=
 =?utf-8?B?VFpmRlJSb0xUUjBKK0NwWmw4VldwQ2pPbE5Vc3pQK1hFdlJNTkNMTHd5eHhq?=
 =?utf-8?B?M3ljVnhqRzVsTk1sVUNyaWM1WElTNWh3K21NdUhWakhHaXhnemlzUy9YY0Vo?=
 =?utf-8?B?RGhWZTF3TldEQ0NQeldaci96YUltQ1prOGdMaHRIaytmSEYrMkVVcU1MRjFh?=
 =?utf-8?B?ZU10NTZUZ0o3WFhISHVBN2FRdW9ObmRUUExSa3pvZTRpRlFMSytmdzhiZS9G?=
 =?utf-8?B?cjJvSGo3cTZSYlFPSE03QncvbWdGNTVKUFlMVzMxRFZNTTJ1WWdCL2ZRUmxo?=
 =?utf-8?B?NVY1TUNrbVNEYlJnZkYxcHhtVGVUOE9BdExUbUZXczdxeUl3U2lwTUs4RlQw?=
 =?utf-8?B?eGtlN3RUeHRuQitUcC9CQjY5WlAvTVlmYXFmYTFLdFBNSjBsQlFuWHlJRlo5?=
 =?utf-8?B?Rjg2SDlzODNyQ1NSKzdWbmEyZ0kydFVYMVdkYTEyQjRQUVlzczY0UW1FbGpt?=
 =?utf-8?B?WWVMeVVEb1hVOEJDUmMrSWt0RDI2bzdPeWxBUTFsZFQ1d0FuYm1ZRHJtUGw5?=
 =?utf-8?B?K1NDOEhTMURQdlZQWGVvQzAybGpYaFdvakxQSTZEUkFLcVV1L2g4TzNQMVNS?=
 =?utf-8?B?aURxU1VRa1BQTDBWblBOWTRCdVc0QnFSMHRYTFRkTTY3bnV2ZkYyYnpDNi9s?=
 =?utf-8?B?Vk1RUXI1TU9iLytmNk9rSmNqOXdOL245c3FqRkNLTGhrZTJ0cFRQcU1nMGdD?=
 =?utf-8?B?Uy8zK2R3ejdaUVRLNHIvajFVMXIxRlZDM2JFMDVMQ1lJdVlUMllhK3FSN2px?=
 =?utf-8?B?OEpXNHFwTlJLd2pWZi9PSHA2bW53aXYwZzBQSEZaZjR5ZTgwL2NsTWYzdGt4?=
 =?utf-8?B?LzRkZVZmNk8rQjhLUS95ejVaa3BxT3NTM2d1NUNSTzJDZzY2dXBLdVdCSmpu?=
 =?utf-8?B?Q3Z1cm9Pbit2eGNvWnZjQWdOcW8vQ0lMeWppVFJxZUpMdm1SaFlkYTFlRXZC?=
 =?utf-8?B?R29aMFpSNGlFeEpJdDRnOG1ucldhK2xNeFBNeUdLWVBoeUtjeENza0haRVF4?=
 =?utf-8?B?QVN1RHcxVmpEdGs1bitBRkZlbm81Z1lTUWNkdXVoRWZnWFV6b2xGUjkyb0xB?=
 =?utf-8?B?YTcvbmxYMlJpYi9PQnlMZDV2WHFPSTZzYmU3cmtRUEVyM2FHa09wSWtneU44?=
 =?utf-8?B?amNQbit3SjJMdkx5bXRPbkR4UHUzaEFWNlRtTGZuTktOM2lmWHcwT3ljTEZN?=
 =?utf-8?B?SDhPamtvNmxoSDF1elFsL1MzeVVFVmpwL2V3R2xYbmpsQjNWY3hVVEY5VkJH?=
 =?utf-8?B?UEhHQVdHYks1THppRFFJdGNHME02bjE5b0p2SmtsVFl4djZNYldOUUNlVVFv?=
 =?utf-8?B?bklRTExUYjZDaUl4V25ndW1zdnRKZmlYcUY0R2ROaE9ucXh5Y0Z5emtZWVU3?=
 =?utf-8?B?SGZKNmZjbXZCU2RURzQ5YVZsOUVXTmNRNWpLUXFaWTQ2U25ienR6c3lDT0Nn?=
 =?utf-8?B?bjl2S25Ud3hOZjR6SHBza0RkeXNSdHNvbEYxT09YbTRCZkEwcjFySnJwYm83?=
 =?utf-8?B?RkdZalZ5eks1bTJReUtnV2xMRUdJTHZjSDhIeXQwRm9VdHk5UVJaakRzS2t2?=
 =?utf-8?B?U1F0VUxPc3BEeVZjTVFFNHh2TXo3TjZIWFh0WDg4TFhKdjVURXcrMWpkSTFM?=
 =?utf-8?B?OTF4N3BHRlljSUtiZkFKKzdiRUFWVDRyeDJDTjU2ZDJmS3d0b09UMWtCekZh?=
 =?utf-8?B?MDBmQzBGOUNJSXJiemFUa2VLL0pqc0d4K0N3ZVJoMGNRWU1YRktHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ffe7fd-268c-4448-988f-08deddcda4ab
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:20:43.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6Omiv/dbgwaPQGqAnAgBejf5jUSp2ortPJtCKRV94RA7TBtslXgnF3YbUpUAujI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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



On 7/9/26 16:54, Charles Perry wrote:
> On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
>>
>>
>> On 7/8/26 23:51, Charles Perry wrote:
>>> Hello,
>>>
>>> This series adds support for RISC-V Platform Management Interface (RPMI) to
>>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
>>> goals and purpose of RPMI are similar to ARM's SCMI.
>>
>>  From the first look it looks like SCMI. Why do you introducing something
>> what can be replaced by SCMI?
>> And SCMI has only specific ARM transport layer but the rest is arch independent.
> 
> Yes, there are alot of similarities between RPMI and SCMI. I found some
> justification for this in some Linux Plumbers slide deck on RISC-V power
> management by Paul Walmsley [1]:
> 
>   * The hardware is more sophisticated
>   * The software is more sophisticated
>   * Some stakeholders haven’t had input in the past
>   * RISC-V “big tent” philosophy
> 
> I think this is referring to the SBI spec of RISC-V vs arm's PSCI but the
> same arguments may as well apply to RPMI vs SCMI.
> 
> Some other arguments:
> 
>   * The microcontroller side is made easier with RPMI because of librpmi [2].
>     SCMI has SCP-firmware [3] which is a quite complex project compared to
>     librpmi. Also SCP-firmware doesn't accept contribution anymore.
>   * RPMI is already in Linux.
> 
> For what I'm doing, RPMI is what gave me the first results (controlling
> clocks) the quickest because all the pieces were present in Linux, OpenSBI
> and librpmi. There are however lots of missing service drivers in Linux and
> some other important OS like u-boot don't have support for RPMI at all. So
> even though I gave you a bunch of reason for saying yes to RPMI, I do have
> some doubt about how long it will take to bring RPMI on par with SCMI,
> making the SCMI-for-RISCV transport that you suggest more appealing.
> 
> [1]: https://lpc.events/event/2/contributions/197/attachments/133/165/RISC-V_Platform_Power_Management.pdf (slide 22)
> [2]: https://github.com/riscv-software-src/librpmi
> [3]: https://gitlab.arm.com/firmware/SCP-firmware
> 
>>
>> In our case where we have Microblaze V in programmable logic I can't see any
>> reason to use RPMI for talking to the same server if I need to do it from
>> ARM side too via SCMI.
>>
>> I pretty much think that there should be communication with ARM and instead
>> of creating another firmware interface talk to each other and have only one
>> which can be used across multiple architectures.

I have sent RFC patch to eliminate ARM from SCMI here

https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com/

and feedback is quite positive. I think it is more or less question to Microchip 
if you want to take responsibility on another firmware interface (I understand 
that it is approved, etc) or just use what it is around for longer time.

Thanks,
Michal
