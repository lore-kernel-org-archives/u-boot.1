Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E83C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 08:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4123B877D0;
	Mon, 12 Feb 2024 09:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gGWwFU3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A86D5877BC; Mon, 12 Feb 2024 09:55:33 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E384287775
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 09:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9wp7rFaSEbP/WtwVjACX+xwcugDE8PIlv3S25sT5zbC2v0E2WlCnJz7cNYpTGrX0hzwfheJZ1OnMrogWtIMD/1K9iMus0y++GprqfzFULMPVJRPPm/RqZC3qFXx7xuZIptl7PEm0kQu9cbNmOQPOwUi8HlCFymOTHE/i7J6FvVd8LPJOMs9ZZ+XaX+22Fjl4AOG+wVBYkrHoqtS95degEXNxN61f8gH/Qs1kAidtAM/IvJzOcxZu/zwuPdRfON2QUcKf/n3PeTfQsUUCfmYv7XLJtNn6Qoy0c4Y9mYkONCOeeWIYZmF1WfSe9tyL8+A5BPXLluHzni2SZACL9Y5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALDeYfY7zLF3DN/9jJsmxiTUqE+zraNBZM/b6NWYZTQ=;
 b=aiR4NI61Ary9bSBiVvZx9cNsC0WXT9851nlw7uJXLF8QXVAvW0pPsCaqiVdp0Bx6ruM9qzYQ9zFrHDmExoDNQLTM8RUz2qN9EvAeb6gH19wlsjajzB/Wn4biixU63ZmB0N3gWLgDNcAZ94xv1l8v/ilYa3P8Dzb5pOAzIwaItjFAWHd52tD03LDuwTq6IWpR1aiI+fCXjkLfVq+PnPkt1Aq0QlDG3WR6elVhsGWQwyepxKF9awjFlxtXOf/WP3Nhi88kDl1HB8gR6aVB6zG1ZFrKloirXeewuYGcmzd9FB4kir/fysjuADeKm2BlN6nXkcmfBPtOG9ZIzmjIcKSzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALDeYfY7zLF3DN/9jJsmxiTUqE+zraNBZM/b6NWYZTQ=;
 b=gGWwFU3d3RCWFhA5Scf+XeMz/1IogcrUtBRqJ6Is5q9s85RPVYWibToj1EeetLPZOcbTQK6zxDE63mkG22owOXXtjqUJOAxguq99Nua1HQhCBitUeORzUhpWsBtWw104kozzAAZNg7LdrFLfNvIKx3YIzu274EUtM6KmXXcfGuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.17; Mon, 12 Feb
 2024 08:55:28 +0000
Received: from LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::b8ec:c90c:f40:a4e0]) by LV8PR12MB9360.namprd12.prod.outlook.com
 ([fe80::b8ec:c90c:f40:a4e0%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 08:55:28 +0000
Message-ID: <11ed2701-7d32-4d40-a651-55a2eddca9e9@amd.com>
Date: Mon, 12 Feb 2024 09:55:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] armv8: crypto: SHA-512 using ARMv8 Crypto Extensions
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ard Biesheuvel <ardb@kernel.org>,
 Loic Poulain <loic.poulain@linaro.org>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Simon Glass <sjg@chromium.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
References: <20240210120709.938286-1-igor.opaniuk@foundries.io>
 <20240211003712.GB3040305@bill-the-cat>
 <CAL6CDMFVEUFqehatU=WJWRtyaDR+Wz0PGY6pRx=nMC9duoj+AQ@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAL6CDMFVEUFqehatU=WJWRtyaDR+Wz0PGY6pRx=nMC9duoj+AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::19) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9360:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 995d5064-eb5e-4e4d-2eb1-08dc2ba853f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPPeq98SUcgjoQvPUj/B/f//2xy82lSEGq52SD+fukpk5HRGDrrLav84UsaIH2mixxtOr6GoHL70h/PkbJL7u0pyJGnkATIR77LIsaTQHdhGG+w4/kMii19Zp4taBKBDXNE3/xKtchzbCDNlsKiQ8KL8lzM5ut3HYaMyjP68r5U4iEJy1jL+fN96kKOqMwSn5QAnkiq3KIhbw62wCgI9GpxTGiBaGBA/GC06MAEwUpJJroTyA8sOUXtBgpwgxDFFOM6I6Lf2tVQLnEGoAe0rnJ4cXb0s3R70uiPpcL3ar3RwU6a4+bPtrbZ2QhbXGED6Frs3hTpda4iH3oWH06YemdpK4jD1oQvRthSdZKXCT7lAq983JBjVximAOFYAiZxoUBZTXmAOVy7KRmVBAcdD/fHvAlpnJkJ9iGAJU7UD0Hya3diFf5Qs7JN35L68hMu86bauH6xK0d4Kg5nGyFLTVxrrJ3zeLMQFMIQyID3HsBpGtbaxIJEtiOWqX4ViqY5ShFWnDJZOOY31lniptyV69zsO0B7ujuQo22iWM8knWj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9360.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31696002)(86362001)(38100700002)(316002)(110136005)(54906003)(8676002)(66946007)(6486002)(66476007)(4326008)(8936002)(966005)(66556008)(478600001)(2906002)(7416002)(5660300002)(83380400001)(44832011)(6506007)(53546011)(6512007)(6666004)(2616005)(26005)(36756003)(41300700001)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRpdFVzaWFrZzJUR3VzYXdpd1VWT0JnTlk0MGh0QUNBQkRnQisvY0dIOG5m?=
 =?utf-8?B?MTlFQ0dZakhIUnUxQ0ZUMFpPZ0s0bTNMRWdyL1hPc3h3Z1lKZG1uSSt1c2Vw?=
 =?utf-8?B?c3hXVGZ2RjdOOEJ0ZGVzbit0UXlJMTY0VXRMYTY0eUFWUnBJUEVJYUJrNFp0?=
 =?utf-8?B?YUpBc0s3WGhsQWw5ZXE5bFM4R0N3YmJOM0RQbmNJRjlDazlNUlJBY2FLN1li?=
 =?utf-8?B?em9LTTA1VWduamJleml2Z0w1RkJINWovays3emNnaGIxS3lqWnc5ekVkT2xZ?=
 =?utf-8?B?cFVCRCtuenFZSWF2WEc4R0VOS0R0WVNsSkNJeFlER1AxZy9jUWZqWlA3Rk1H?=
 =?utf-8?B?SVhJVDFuWUNsVmt6eW15UUlLYzBUYjlkNlV4ZWtGNjhtL1M5RDhLa2N5YmlY?=
 =?utf-8?B?bkZRaFl4RThSaFpqaEtKRWg5ak9FUHVVRkt6L21MYXRmTm1yLzhGbytZZFNH?=
 =?utf-8?B?OFdyRStSOHdGUkdLMGhhdTZsYzRjYktoTVUva3FoN0FhQnpzVTZ4N1VTY0E1?=
 =?utf-8?B?RDZNRE5aYUROUGNoVmo5QUphYkt0OS9DQ0VFak1lTTdlanJnV2t6VXJCSjB5?=
 =?utf-8?B?V2hVdjhzWmhNSFdwZDJYWkpHRnFhN2V1L1h1bG43RmZ6em5lcmkxSnJUU3Ur?=
 =?utf-8?B?WDhyUHEzTEYzUWNHVDhqcnNudWRrWE5DNUhpSlduTmg0blkxNHVEaUJ3WllF?=
 =?utf-8?B?YUpPVm1vV3dvT0VKdURDZURVY1ZLM2JlQXlNY0Y2ZmR3OGIzMjhqditmZjlR?=
 =?utf-8?B?ZnY0RGdzMDVTdVFKbEVFZHFqVDk3WFpqL3hmNjFaNmVzNHF0aENRU1pWSXly?=
 =?utf-8?B?dU9ZUnVJYmtGUXl6S0pKS1NMMnNYYVU5M1NBaEFIemdsdXE5TENhZ0plNEpu?=
 =?utf-8?B?SVFjeHRCdWVzV29rcjhtbGRBZy82RHRvNzlUOFlycXpKOEFNcGgzUHZSRXc3?=
 =?utf-8?B?NVNGcnlBek43aEthbWRkcE9oMVNpZjlBcUloYi9XS1FVZXA5aVFWaytOVE1L?=
 =?utf-8?B?K1dPZS9qZ0RxVWpJUnloQitEcWlnemI5WlJpeHNncXZTKzc0OTYzcldaa0NY?=
 =?utf-8?B?OXA5dERlZjlZMkNBUmc1SFR1anFkdnh3YlRFV0VLQ2V0Z3lBbnR6ZzE0N0R3?=
 =?utf-8?B?OVBHelBsVTY1ZlI1Z3NxcitVWmhaUmtDVGZVbTM3ZmViTWYxL0l5cW9EM0hy?=
 =?utf-8?B?MkJtVjNSRkxvZTVNM2N2UEFNcW5PaUJHOU1yYkttRDNXeXBZSGlmcW1vd05L?=
 =?utf-8?B?QmdJZU1HMGVxY1p5Z3pOY0hUNXBwaHBlUTYzQmxweFZROUs3ZDRzaE5vNE9p?=
 =?utf-8?B?RUdlSFJ1bFZRZ2tMdW9lVTZ0U0VjMkM2ZDN0MXI3VW02WGo2eGtubzFjWjBW?=
 =?utf-8?B?ejZmS052K3EreGU0QWJoejUyWExoeHFTTGk5Mk9RdExPcFQ5RHhOd2ljWC9N?=
 =?utf-8?B?Rmd3MFdZbnNHZWRVNTZWbzJXYS9vamlyNW45aGR5Yk9vblJ1dWJ6bDQrbW5n?=
 =?utf-8?B?cFFsRHBXcXQxNnA4UklKZkt0ZFhGbXhKZkp0OUQwZVkzWEdWWlhia0dMWlZW?=
 =?utf-8?B?bGdMZndhZFhQdU5BSWVaeThpT1U2aW1WV0JrUVpPenpJMjUvbGVWZi9EQ0ZP?=
 =?utf-8?B?dGttRE5UZmE4ZG9CTUxnUGhNd1ZUbnZwQU1aRjRYQ3FUTy9kaG5ocXFiQWM5?=
 =?utf-8?B?bm83RG90aTFtcFpzSzIwOWR4N3ppWjcyb3drZlFjU3BxenVLcUZLenIzZThh?=
 =?utf-8?B?VUFiaHU5dzV4Z2x3bG9QdXlPNzBZaWtpWlROZ1REOGxRN29rTWJ4V3FTd3lw?=
 =?utf-8?B?bW42WXE2OUJlbFlIdldSZFB0eFV1R3kzOHNtMExtTG0rN256VStoQTZ1UktI?=
 =?utf-8?B?ZmxEOWdvZHlCeHUzYUZYYjZsL1NvVndtUG9qVGRNMUdCUFYvbzExWkJWWjNj?=
 =?utf-8?B?YWFkWnZINTNlT1B0RHEvM0lDWmJONWNmZFdxOEtxMDAwb3hPOTRsT0ZSVDZN?=
 =?utf-8?B?UWl1UnVFU1pOTmxpV2JmTy9zamd2MlZjaWEzaU9GUjZsaTQ0elN2WE1vZkZq?=
 =?utf-8?B?am9udXIwZWNGQUJySmJDSGEwOWtlNm16ejhwMDRzUHA3c1UyYWViYWVjUFJo?=
 =?utf-8?Q?rEfgLJaSZMXhdJ5bcMRJ2FIpf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995d5064-eb5e-4e4d-2eb1-08dc2ba853f5
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 08:55:28.1932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjL5APEbG6uzJgaxV1y6KSIbmTDueULPR+GaHtqTbOgE0daOuA8/w0sexyAVAhS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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



On 2/11/24 18:26, Igor Opaniuk wrote:
> Hi Tom,
> 
> On Sun, Feb 11, 2024 at 1:37 AM Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Feb 10, 2024 at 01:07:09PM +0100, Igor Opaniuk wrote:
>>
>>> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>>>
>>> Add support for the SHA-512 Secure Hash Algorithm which uses ARMv8 Crypto
>>> Extensions. The CPU should support ARMv8.2 instruction set and implement
>>> SHA512H, SHA512H2, SHA512SU0, and SHA512SU1 instructions.
>>>
>>> This information can be obtained from ID_AA64ISAR0_EL1 (AArch64 Instruction
>>> Set Attribute Register 0), bits [15:12] should be 0b0010 [1], that
>>> indicates support for SHA512* instructions in AArch64 state. As not all
>>> ARMv8-base SoCs support that, ARMV8_CE_SHA512 is left disabled by
>>> default for now.
>>>
>>> Tested in QEMU for ARMv8 with compiled-in SHA-2 support.
>>> Even on emulated cpu the hashing speed increase was visible:
>>>
>>> With CE usage:
>>> => time hash sha512 0x40200000 0x2000000
>>> Calculate hash
>>> Calculate hash
>>> sha512 for 40200000 ... 421fffff ==> 1aeae269f4eb7c37...
>>>
>>> time: 0.215 seconds
>>>
>>> Without CE usage:
>>> => time hash sha512 0x40200000 0x2000000
>>> sha512 for 40200000 ... 421fffff ==> 1aeae269f4eb7c37...
>>>
>>> time: 0.356 seconds
>>>
>>> Real HW tests should provide much more improvement and objective results
>>> with 10x speed increase at least.
>>>
>>> The implementation is based on original implementation from Ard Biesheuvel in
>>> Linux kernel [2]
>>>
>>> [1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Registers/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/crypto/sha2-ce-core.S
>>>
>>> CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> CC: Loic Poulain <loic.poulain@linaro.org>
>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>> [snip]
>>> diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
>>> index 9f0fb369f7..fd5c26421b 100644
>>> --- a/arch/arm/cpu/armv8/Kconfig
>>> +++ b/arch/arm/cpu/armv8/Kconfig
>>> @@ -204,6 +204,11 @@ config ARMV8_CE_SHA256
>>>        bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
>>>        default y if SHA256
>>>
>>> +config ARMV8_CE_SHA512
>>> +     bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
>>> +     depends on SHA512
>>> +     default n
>>
>> Like the sha256 one, this should be default y I think, the performance
>> improvement is likely worth the size increase.
> That was done on purpose, as SHA512* instructions (comparing to SHA256*)
> were introduced only in ARMv8.2-A, and most of the currently supported ARMv8
> SoCs in U-Boot don't support it.
> We probably would end up with most of them reporting Synchronous
> Abort crashes.
> 
> As Marc suggested in the previous email, we should have
> both versions compiled-in (sw and hw-accelerated) and dynamic selection of
> proper version in runtime based on CPU capabilities, and I plan to
> address that in future in a separate patch series.

sounds good but then remove default n from Kconfig because that's default anyway.

M

