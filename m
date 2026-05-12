Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CD6CD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E812C8341A;
	Tue, 12 May 2026 06:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="giXUPUdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609958394E; Tue, 12 May 2026 06:35:21 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4C883015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhZFuv+VnEG3+v/LiDYjQF2LvdWp7cyOXNNd5qEm77aDFebOdGFUrXCsCOd3DvFFMnmpzVakonN1jqY614t287o2L0tvzHMlUOi0/bJz11DLqqtO/z5FeBKMR7qSHuJnDcIjJ36h0E6iibE4QNRmA7f+bkE9Zb/ok2y3k9lhzPnM+CJA7+jKUFyYop28jT2U20h+Dn+hA5xQdd4ReNaIqXMGIHokGdj1hmrxpXCJxho3+XX72iOicaWfq1Y+HiIDXvLTQIRdQlqSkNQtzx1edIrG6+xq50oe5zN2UaL09AhiL3b4Hib1gCvoUyVP4RZpBsJVMmPAePxxyxsVGUP3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COfr6+iIfhu5JPJgBnxYiDemQ4b1MEm6FQ+ZGZfiUp0=;
 b=UXWOz8ALgJrIv+hwmH4CYlN+QYV4mI7qmBvDkodK3RMybu1DIvlVbcRY1qeumINlAR0YtQC/s4HWcMbLU+Hz6F5koBDq+HhhUkxHxx9Vzpm9biDRsgpNSJhxxgiAe5YfVJj6jqCRUxdnhB1PhSOM3iBxhGenV8dSoL9T9MEC+2rJr4GpLWpggEaYn7pQQrAbosqMrdQsBfO00wzUwUAvLcF4il2//nqqYsDc+N6Og1IHsnGbV7G9FEVGfMihQFh6leyUTTwBjXUdJ67A6EuQqkSw4pHuE9v2dUukexM1Zc0qXwFSntJeqtbDYgyL1i5a8UpBREEZ8ZxjN5X8ToLqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COfr6+iIfhu5JPJgBnxYiDemQ4b1MEm6FQ+ZGZfiUp0=;
 b=giXUPUdxjAHgWM3nsOKRxxR+j9TnHb+CYDzM2Zis0e4KrF3xmRTI8neBeaq7akZ/fecRjT4yOmAVpcTeCjPPPGjxt1Kq5/I6JuNMRorB8XDw7gUMbACztVRPMJvva20YTodhEuaeb/IspY3n5E9vpUajWQGUTKKEIbCXDAJEane+HjQqdq3ysvAnbvPGjL1T6g6F9WR7jwWn6ko+oYjePvVUtU0C1+VadNUXceVjuz7D1Ks2Fr90zCsaZGp8fIHPkSbGN6tDe4PgHFyEyKF6+VhYOu3LzIH8kuRFKtt3/iQvH+b+dUsM/aqxlbr8hLHuoXmho5xLlrX0WnPyBF5Bnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM4PR03MB6192.namprd03.prod.outlook.com (2603:10b6:5:39c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 12 May
 2026 04:35:15 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 04:35:15 +0000
Message-ID: <db94bc99-34f4-44b3-9511-025a8ba5e989@altera.com>
Date: Tue, 12 May 2026 12:35:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: Sune Brian <briansune@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SD8D4yHnSLAQfrs3-kgGfmZrqh6fMXmB=QOfZYq9Uq7EA@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SD8D4yHnSLAQfrs3-kgGfmZrqh6fMXmB=QOfZYq9Uq7EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM4PR03MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b53845f-5ce6-460c-dd17-08deafdfdcb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: PIC7q9uv74oOVDuOQsDgOhT6Xnh7/+AW9AZpGKgZFv5gALNWwrU9kfDZOdKRqs+mrhiNl/0maxz76AvOawdvJBedZHslHPjHb8Au0W2xPDfwy4DevFzg8PD6mSdn91GsNodgAiikjHlOANo7uQPWzjFINyhwfPVYx8AWzQdYqOpAxrWywOpWwh5wBSFjDFvxMw8K8p5+7yScLxAWEyX4p5btd33uhKgIclVIm8rYLNSiVaAGAo6mrd1d2FPuK/Xzm3WCVo+UiXQGehEm1VM3ggVLSDVzUJOdZlbxLQ4tZigWTP1/2G8iwwsT9cz5jBVriSSBo5XItTj42cnvQM0YoAXijHjlVkzikBDg7B/ytJH/vRGGBWRv7yC8rV6CXjk+3FfKSeTBKUTUGVPwtHl8mJy/u0poQGu8y54I159rHEdWifVOiFuc/sD/wXESUKd2dS9h7ybzeFydOG5lsho7KfdCEeiAuKziRxySkgnqiPaIgxp5yRvICOQBiOTEzuJReV44Dh13VkBKbF0G62xMWoxcC4/YvfqAVYA20pDadV99yvWxC2oL1zWU8byuV3Tcij8LBni0onp7r4rdgxrlZFP0vEa5sA6dTa5a4v6mskvdEPnYh6iYNfHukYcr7mgGuxZMPQCnfOGUKAIVBiCl6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUE1ZVBJWktoaXNOZjZMQ2l1bVBHS2V3R1BhSXV4ZUtQL00ydGVlQUxYV1V3?=
 =?utf-8?B?YnBGRkVOR2pzUGtmektCclhpL1I0TE9tTnpXclBKeEUrSjB6VjVWMEtUUTVi?=
 =?utf-8?B?aE5KWUNvMS9IVkFqNG1maklqOG5ZcllzalZpd282NzYzOWhiakYrSWVzTXFm?=
 =?utf-8?B?bmI1ViszQWtHQkgzY0g1UTZiOGFScXNlNngzQ3ZUZlRWeVcrQ1IxSU9iamZC?=
 =?utf-8?B?NWYrTjBGdTd4R0lUa0hJdVJkS1lZTDVhWjE2TGJ3bEFBWWhSMXdScEhhNnht?=
 =?utf-8?B?em9rZHBvUEhQOHRHOW1EQVZRSUx6OUVON0ZBczIrN25KY1dvL3NreWlrS2J5?=
 =?utf-8?B?OURzdnpJR1JXcURvcTRBOThnK0o2UWVPK2xzQ1c3YlcyeXA4dzhmK014OXFt?=
 =?utf-8?B?N205WHB5UFUwbjhVNDhheGVMR2NRaitXYjJvM21nejg1MSthcHJDYk5WQ043?=
 =?utf-8?B?NFd6LzFJcWNibXpmbUZXQm9qazZXSWEzZytUcGlXNVBDVXhlQTlPOEZxSG1M?=
 =?utf-8?B?cG5LR2hVS0N3SmRvS0JhRGxXalBPS21YejFIL2VvRE1OOGFzbUdYTldNeC90?=
 =?utf-8?B?R1JNbDNJNE1DdEtyUnVyd1hRcWdBa3A1RWZUN1M3VnhGSzRidzNsSnFDT1Fn?=
 =?utf-8?B?SjZ2THV5bEZoQnNOU2hYb2xwUVlXSU9Xd1V4MzBIQnVtN1lFOEhpYjROU1cr?=
 =?utf-8?B?TWg4Z25Wc3RneVAvVE9EemtYMlI4M3l3aStPeVExYWtJSUtHbU9pa3krRXh2?=
 =?utf-8?B?TUxVcEIreE0rSFhscUcrRmFGNFA0L1YwY0RaWXYzMTVUY00vUURqTjkySWxG?=
 =?utf-8?B?WTJ3d0FlbWErM3ZQYzN2a0pMR0Q4RlpiQ2d6amhmNDROeENXNWxRdTRUa04w?=
 =?utf-8?B?RW52R2xuQ0ZRMTJXUkt2K2Y0bUs1QWdHcUNqNHNQRGQwVmJGaWV4Z2Z4WVo1?=
 =?utf-8?B?WXFRQnZmTVhORTNnZENSVlhJTmMxUU8xVThEaU1Kd1F5Z3luSmxuQXM1eGJW?=
 =?utf-8?B?cVQzRllSSnRpU0p3V25KKzNTelp5VThIMjFNMFRZcFpjM0M0RmZTZStTZlZY?=
 =?utf-8?B?WUEyb2dQeUVKT0NNWE1oRFBjdzBZd1g5VXNZSUFRVjFvYUtxZGJmZnJoa0FU?=
 =?utf-8?B?dGdrMXY3TTBjU21zMmxpdjZsVnFJS1VRbDVHVHQvdEVTNG1MSmMzMjM1amVx?=
 =?utf-8?B?OFZjb0txamNXNXFzL3pNWG9HSFZlTndiN1E2bE9EN1ZpRE4zaHRVY2NVYjBo?=
 =?utf-8?B?SGxXd2lkaUVTb1JERUtzeFRvZXZ2RmpNOVkzZWdzTWN6d2psaUdqMlo3bW9P?=
 =?utf-8?B?M3FjdExGNXJ0UXdKQ2VlQmFYMEkyMmFOQys4dWxUcUtHb09yU2ErZHRKeTZZ?=
 =?utf-8?B?T0JqTUtQa1dRKzVpUFZ2Ykp3b3FkMW00aXRCdTlqV0poeGxxU2hZR05hNHN6?=
 =?utf-8?B?RVdCZnBUc282MUZOUnZiTGwvVjRIcXczQllrbVpzaVhlVm5lbmI4MTVnQjJ3?=
 =?utf-8?B?TmNiQ0tyQTJ0b1NvK1NFenF3OFZ0dGFSR0VZWWxSNnltd2J5d29DcktCKzhw?=
 =?utf-8?B?eDF0cWM3cWxwSnBqOWNwNFl2TTM0clBIVEdUVzUzTkMxSytDSUd0RW45eUkz?=
 =?utf-8?B?S3BsUVRXMk8xRnAxeW4yRmF2QUVLbm1KWFJiaDJjL1U5SkVHdFc2bGg1REE0?=
 =?utf-8?B?U0tRbW1vWEdBaUJubnpUbW94RHYvbU9MUmY1b2Nrdy9uRmltbnZDRXZ6b1Q4?=
 =?utf-8?B?c0Y1M29ROWlQWXRBM2h2NTVZL0gxTWw5SzZBeDRzVGFRVkZCLzZHWjU2Z1Bw?=
 =?utf-8?B?VHBWdHBhMys0ajMrMStBOUFqWSs4V01wZ2FHc1dBSWNzQkZrWnplVUZ0SjNP?=
 =?utf-8?B?d1kyaWw0WlRpVW01S2xTSFczc3pUYTh4UUNLYkVtQUpMSnRaRlBUcG5UcHlR?=
 =?utf-8?B?WVJvSjNFOXA5RW1tbTd1UVFHQlh1Q1VrdXJ3LzBubjlGNlZobTFweFkrK0dY?=
 =?utf-8?B?bC9kZVRteGxod1hlRDV4VU4xYjR2b0FQamhMYnNCQWxzUzRteDNEeWlOOE5Q?=
 =?utf-8?B?L0pyOFJlMHg3ejVRd0xuclZiSjNsM2E1NndMTERuVWo2RjJSMVUvSkk5bGxa?=
 =?utf-8?B?MU5qUFdDcUxHVWhxNE4zN3cwUVR5YVkyZ1RZQXlycGNRY3NxdUt3ei9uRDhM?=
 =?utf-8?B?Q1BmYmNEUUJrNVlxbTM3cnVLWmJHaFVPeHkwYzFHNExFdVU2bG85a1FGTUdH?=
 =?utf-8?B?Q25iMUVDbmVxWldjcGw2dnRMQU1sdUtMKzdmOUY3OHR3SytsRCt6NVl0RXZZ?=
 =?utf-8?B?MGdXcml5clQvdTltRzhmK212em9zbWkxRlpzUVlaSnhmVUVTRmNINi83OVN4?=
 =?utf-8?Q?u5DDIi31/7Y1L4RmwBQXqu3/eOMbO+B/3zpYw?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b53845f-5ce6-460c-dd17-08deafdfdcb1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 04:35:15.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mCMYaqfVOYtnY6jPT7PXt6/tnLLGk7MMSD1aJGDXWTcB+UZnhUe0wXHgnSgGO049iPpdN97t5t5M9Hl36lVmkgiBkOrcpV7VKXrknBEO2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6192
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

Hi Brian,

On 7/5/2026 7:04 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Thu, Apr 23, 2026 at 4:06 PM <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
>>          1. Update MMU/dcache setup across Gen5/Arria10 using common driver
>>          2. Add ECC scrubbing support for Gen5/Arria10
>>          3. Add DRAM size checking for Gen5/Arria10
>>
>> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
>> Tested on Arria10 devkit with RAM boot as well
>>
>> v1->v2:
>> --------
>> - ECC scrubbing, Gen5 DRAM size checking, and shared dram_bank_mmu_setup() is set as optional via Kconfig and
>>    defaulted on only for the reference Arria10/CycloneV boards to avoid SPL overflows on size-limited Gen5
>>    defconfigs.
> 
> Well, I don't know I am only a contributor after all:
> 1) But do some one or some ones clearly mentioned [1]
> 2) Per-version change history must be placed below the '---' separator.
>      The required format is 'Changes in vN:'. Custom formats are not
>      acceptable.
> 
> So v1->v2 is considered as a valid format and not a custom format.
> Hum, interesting.
> 
> What a wonderful world =]
> 
> Appreciated all the "reviewers" HAHA :D
> 
> Brian
> 
> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions
> 

Thanks for pointing this out, I will correct the format for v3 submission.

Best regards,
Alif

>>
>> History:
>> --------
>> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com/
>>
>> Alif Zakuan Yuslaimi (3):
>>    arm: socfpga: Consolidate dram_bank_mmu_setup()
>>    ddr: altera: gen5: Add DRAM size checking
>>    ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>>
>>   arch/arm/mach-socfpga/Kconfig        | 21 +++++++
>>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
>>   arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
>>   arch/arm/mach-socfpga/spl_a10.c      |  4 ++
>>   arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
>>   drivers/ddr/altera/Makefile          |  4 +-
>>   drivers/ddr/altera/sdram_arria10.c   | 34 +++++------
>>   drivers/ddr/altera/sdram_gen5.c      | 64 ++++++++++++++++++++-
>>   drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
>>   drivers/ddr/altera/sdram_soc32.h     | 15 +++++
>>   10 files changed, 252 insertions(+), 49 deletions(-)
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>
>> --
>> 2.43.7
>>

