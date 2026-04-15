Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C93FA0C20
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 03:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E252D83936;
	Wed, 15 Apr 2026 05:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="alFYW4vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551F5839D5; Wed, 15 Apr 2026 05:32:21 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F08480086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoBo9b/G4hTw12RcVBNQaPSaU+EtJIGuH0eG9lFYT6fLyzHaqwmO56HDGqZMIEr5whfjdx9kyMJu5Q98JpLwO6fjDFPTV19r6Fb5Fb/bYYRSKjwZMs9+BMgRQgfuNtZ0ZIvzZK41WvcrsCjhvtt1F/GFs94h0ibWTsH6TUGIS6Cnn1GBsbad2ntg4N3LyX+yyo5f4R5xCZzh1RV7yw7po8sHeYrT7SNS8ocCpH1CaQ6TqQWQ2O+3RmzLXxyMLEYvLskw0ChEpqIgVzhEc9LUaN0SvWnuEX15WDsJPuGOkrABA1qKWHzFxOu1uAtr6WkKgw1SzCDxywIc+FHbx/GXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enfPGcgkrcb6DAjgR4Hel6xDhzYONS2D3zVovHoAOec=;
 b=QDdBSO9kRlMYkIFkcSGm2cqRk4BTsR1etHvv9hL7AqJbwle02nCEiDd5vlIgFp9q9JofdeU6f58o5TQIzQZQSTiB16dILMSJgOIvX5jwzN4YlCwwahyfTfcqyeBGiDfnQ0ommtD4uzfNKcRTSyXD9zklwh38+MHM2i44YGz70cqRfi82JPZOsTPRq6d6v+B53dVo/SLDAVyiCvzDLvxxDfHdklukipygh0tpF1brWT8gmnMi9Oaqf9uWv2s3JjYe9FjYrWmNq1X08p8I3FFKUPp8tu1gO4ji2ALBZe5UTM4HIP75Kcq+Ia+yIcT1mz3qgPwVRRb4ubCMZvolZFU6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enfPGcgkrcb6DAjgR4Hel6xDhzYONS2D3zVovHoAOec=;
 b=alFYW4vtKheUC2K3f/1uwbJKoDriYucQivDSyv/UGRAzv8cnScPNyzeUrMmlG6ecLLKZvA9T9oW+PBE2swwWf9uNSX4zNwAV68md1EIz6uDy8HtFN0/XylyCQWrFQ4xmzsO7ypDa+6exr+jdDjVwu2qbHlL125PEK4tUANbqPUMqhsbjwxhZBy0/t4F4EskwsFEVJ4bmMhJciMIHyvdIGeCoxmfqzzMKF0DN8YETgosV6vlX39Z0iRWrCl95i7d6NyhN75fGn++T3iruoNiLAzSdBvT/QazKFjT1MI2VUG3JumjipQO6v3Xbxv5bUfnaWsBSDIvs8koT7+NLJakqYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA5PR03MB989109.namprd03.prod.outlook.com (2603:10b6:806:4d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:32:15 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:32:15 +0000
Message-ID: <a8baeaf7-dc67-4ad1-905e-e8abeab6fd43@altera.com>
Date: Wed, 15 Apr 2026 11:32:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: Sune Brian <briansune@gmail.com>,
 "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <c5129f8f-5970-44eb-8bda-a6577bde41bd@altera.com>
 <CAN7C2SAP8b38_2=6oanx7s8zYPpudUBFF+J1te6bPqALcbRPVQ@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SAP8b38_2=6oanx7s8zYPpudUBFF+J1te6bPqALcbRPVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA5PR03MB989109:EE_
X-MS-Office365-Filtering-Correlation-Id: c5355547-a847-411c-383f-08de9a9f96ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3TLDSRLmqicj8q0gqr4ZlkLCY5XXc3nabOut/3cYQgeHFZgNs4wVb2JGdfrrSdjB+Ae3VV2k3GNjz5yLJCFhDScfgcwMNWLDaIJZ+L49mpHToFGh4Z9s6vFKSCFtqqtcC4aQdOUxOzHeq60cd7p1Vf1zqupfndjFC4Gj87J+oueuSMhrwSqSrjQsbhEmFqSyRkdZpmrt3dD1064kvfUbPk9A8It0sXTb3kvEk0yeHe93ZAO2OA3BJHwnSTb5TUJvEfMo+jTbeUlyL0S6ZAzw4zaZxMrqrE5NmuZ6dR9eZorBcVkQvYg3hUjbEp+nMUZpNxQcswiShSzoxYqY00U8AjaEErUvRNwcT5c6v7H/8728YCYXEFPm0YPJbscwc+ak9YS3sQdH0WsGsxPNPBIS8YQpJtUllvGyDbrgkrBbtTK848rQji/EtJ/JliiwkvAlqpBQ5GQFq/3eglyOkkABAOdy0aSGE8YxGa56zV7a3Zpf1xHhmCDFq0kYyqeEInr+oRnUbwnHhrBJHLW6+9CIoBcac9uAi4LzchUKN2XjjTMkoLYMB4qwCQi4uv35d9yiEBavd9AUccBTjeKHLBzsdVj6gbdLWC9XDMVIf+/99OJzMDbJcyi5xCrq5jnpkmmP/Ajf3GpA5q4CILMlJ6+y4luGRYCVSrXBPnR6I69QrNwJ5Ttfufh0C9N8W1diAmLL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdVVEZYNnRjTGRwSDJxV2JwWnRZaE0wSzhXZTIrUEpJYmIvRWhpak1teENx?=
 =?utf-8?B?ZEpVUGpCcWNHZ3hhSFJPZnBpUlRWeml2dE4wQkNWL0VWbldEbk1DQVdLVmxV?=
 =?utf-8?B?MkNueTRQMjYwdU1CNE51cUsyL3NuVDQ3NjhkS2Y1V1AwQlJSNmpZYUR3Q0Yr?=
 =?utf-8?B?Q2xiSVBzd1hIMEFoUWtsWEZwdlJYaDMxUGpPNUNUMlJVbGZIKzNvSHBSaEZm?=
 =?utf-8?B?NXFuK0FwcjEwL29FamlsbVZ1MUcxYWVOZFBnV0tXRUJIRHhLdk93akl0S2lU?=
 =?utf-8?B?U29XZHJsK3NESjBZbTZReWo5aHRzT1NWUXFKRi9jR2FuYm8vYmorTEUvUjRs?=
 =?utf-8?B?MzZNbnliZFhSUGpyNW5hUmFEcTVZdUJtTkRZbUNEL01KM1g1UUNrT0FJeHhK?=
 =?utf-8?B?QmU0dTBvcEhHamxKV0hIaDc2U2ZqOEtaTmMwZktiQlVGekN4NmwxSFY3b05X?=
 =?utf-8?B?U2JTUmM2ZW94YWk5RFB4TzZEdW9CcWxFNGdJcUNkeW5SYytHVk5CcXpBVzlP?=
 =?utf-8?B?ZTBuT2xMRTgwZGxIN0lWQUwwWGJFNDBxckc0U3JRbEJrVXpXNlFmN3hyZFdU?=
 =?utf-8?B?eHhuL0VGSUFkZmUxRXJGN2JMZjRVUVZ3Qk44VncwMXprWEVoWmRsY1VEaHMy?=
 =?utf-8?B?U2l3SEltSGtTcVB6TE1vekJlT3hTV3YxdG5lQnd6S2dBcHFBYTc4d2NYbUtH?=
 =?utf-8?B?bm52RXZEU211U2tFdUdvMGlVWjNnYlVjZHVyVEJlT1doQUpsYmNYaHozcFoz?=
 =?utf-8?B?d0l0eExrNTEwUW4xRExvM04rdDV5YUFPcW0vUjQ0RkRPbzBlQklZbEgrVTVY?=
 =?utf-8?B?Y2MyTFptbXoyUnlTbkxHMXl2RGhiWXQ1bWZrUDR6M2ZvQnlCeUREMU4yVm9H?=
 =?utf-8?B?bEYvdTZBS0xqb3pLY0R4dTZIWm8wSy9tdnhJdExocjZObnpjM2RiTE1lMzlW?=
 =?utf-8?B?RFI2NStXWlRXenBPU3crZW1HdHNlblFZUWNmMHN3NFZaRHg1dGYwbVRDdFZC?=
 =?utf-8?B?d0ZaT3N3cTBNNDlYeHk1bmxxWWpsRjRjSldEUWxic25lOEF5My95YkgrYlUx?=
 =?utf-8?B?S1dDY3lUODR1NlhodGRwc0xlL3FxSm8wcW15UGdEVlQ1Q21ldFE3NndBZ2pD?=
 =?utf-8?B?VnorMFpJbjhESTZ6SCtSTC90RUVOZEs2SzdheHR5MjR1TmlNYTBTdFYvbXBy?=
 =?utf-8?B?MGx5anNOSTBac2pLMmk4UnE3aDV3aDhwWE8zeUo4Sys4QjhjS0dXWFA0bkR1?=
 =?utf-8?B?NHZoNm9tTnZkSEU1ajkvMUlueWVoVHFGTk50YjhHUU5qQWd6Zit4cjZiOWV1?=
 =?utf-8?B?eG9nVmFVV2ZpVS9vQUErR2FpcjFFQWRrZ0xOTEJoc20zQWlTSEtjUVpNemJa?=
 =?utf-8?B?Z3JRQjdpUzVQTTI0VjdoWStjYWV4dGVSUlIzeldFT2xiM24vMEhVaEl3UTVD?=
 =?utf-8?B?MEdDajdwTWRHVHZ4ZWltQTVTSFVOb0NyQjNDZ0QzSkV5V3ZhUjZOczBOVUJK?=
 =?utf-8?B?STRWQURoWEtWM3BxZW1xUU9rM0hYZVVqUnE4TDNyTDl1bURDK21yMWR6a3Fo?=
 =?utf-8?B?S1F6MExtdEN5NDhZbGc4VVdYTEUzZzU0MTZ2ZWg1MFdRVm1uKytzTldUWUxY?=
 =?utf-8?B?S1RBOW1EQWFCcGhnK08rODZlbm90N25XVnFZTC9ibFFwQjNWdXEwZW1CSTA3?=
 =?utf-8?B?dTVkM2xCbmo4N05qTjloNzVkZXk1bElPQk84SDJBQmJhdEw3Y0djaWlFditQ?=
 =?utf-8?B?Y0pnTTJsZ3RTUFFaNElIYWdGZmMvWTlLL21EOWd6U2RVYVVMYk5rVmlhVGxm?=
 =?utf-8?B?WHpNRzN3WFJGTU5IUTlzQzNBWDVHVFkwK2hYbjJBQ2UyeEhKdEp1MjhyenN2?=
 =?utf-8?B?N0FYOWRxeWJDaDJwbU9LVUJqazRrTzFySlB4bXJMa0xUTERnMnZ2YUdnVjFO?=
 =?utf-8?B?SENzcnk0UTBBZnpqTkhMWHRxY1RCbXU0Y1IvdEVuSE85eTdhZnhNY0FJQ2Jl?=
 =?utf-8?B?UElRK3NvTGx4THI0NTQzUVBtcnE3dlNpak96a2hTeDd4eUdNZldvRjJlcXdF?=
 =?utf-8?B?OFhLZ3l5R0VSa3ZJemNtelpqclZ6UkhKb1BhRWxCRGF3RXdEcGFpK0xrSlYy?=
 =?utf-8?B?YmtLdFo5Tzd2RE8xUjBwSzl1c3J6dFQwc25FbmlpanFJU2Z6TW53OTNvNW1B?=
 =?utf-8?B?ZHhrRGd1QlNUT3k5NFdwN1UxQXNlQ1ZPTlkzVGVJVllmajlSMnZ5RERLclBi?=
 =?utf-8?B?SmJWQS9BUmdIQ2VPT0ZHKzZPUUI5L1k1ZFhwdHE4M1hwQkVuK2s4OS9OL3hH?=
 =?utf-8?B?dTI0a2poc0hkVGJBQ2NYNFhXeUZkZ3ZYbWpQZThpamNhUE1vU2tUNkRvK0pH?=
 =?utf-8?Q?ANqDRoK2ID+1WZKaES+uXhEshEUxiMRt+lozR?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5355547-a847-411c-383f-08de9a9f96ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:32:15.5326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUZ9rm7w56M1UBoXJ7/MPP9bICTk+A51T64miL2AwjeW06DOCjKrvI5Ns0VHuEo2cbo+sk9EMzhWT9IU9UGvlj5JJqBtWrhaQAkMZOIlZxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB989109
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

Hello Brian,

On 12/4/2026 8:11 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi T.F. and Alif,
> 
> What are the issues here? Try to help push ECC back to main
> stream u-boot.
> 
> Latest U-Boot revision even removed cache codes.
> 
> So what are the solutions here?
> 
> Thanks,
> Brian
> 
The pipeline test was failing for SoCKit SoCrates and VINING boards due 
to exceeding their SPL size limit, further improvements will have to be 
made to exclude these Gen5 variants from enabling these features to 
conserve SPL size.

I will submit v2 once I have finalized and tested the workaround 
accordingly.

Thanks,
Alif
> On Sat, Feb 14, 2026 at 12:52 PM Chee, Tien Fong
> <tienfong.chee@altera.com> wrote:
>>
>> Hi Alif,
>>
>> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
>>
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
>> 1. Update MMU/dcache setup across Gen5/Arria10 using common driver
>> 2. Add ECC scrubbing support for Gen5/Arria10
>> 3. Add DRAM size checking for Gen5/Arria10
>> 4. Assign unit address to memory node in common SoCFPGA device tree file
>>
>> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
>> Tested on Arria10 devkit with RAM boot as well
>>
>> Alif Zakuan Yuslaimi (5):
>>    arm: socfpga: Consolidate dram_bank_mmu_setup()
>>    ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>>    ddr: altera: gen5: Add DRAM size checking
>>    ddr: altera: arria10: Add DRAM size checking
>>    arch: arm: socfpga: Assign unit address to memory node
>>
>>   arch/arm/dts/socfpga-common-u-boot.dtsi       |  2 +-
>>   arch/arm/dts/socfpga_arria5_secu1.dts         |  2 +-
>>   arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts    |  2 +-
>>   arch/arm/dts/socfpga_cyclone5_de10_nano.dts   |  2 +-
>>   .../dts/socfpga_cyclone5_de10_standard.dts    |  2 +-
>>   arch/arm/dts/socfpga_cyclone5_de1_soc.dts     |  2 +-
>>   arch/arm/dts/socfpga_cyclone5_is1.dts         |  2 +-
>>   arch/arm/mach-socfpga/Kconfig                 |  1 +
>>   arch/arm/mach-socfpga/misc.c                  | 31 ++++++++
>>   arch/arm/mach-socfpga/misc_arria10.c          | 26 -------
>>   arch/arm/mach-socfpga/spl_gen5.c              |  4 +
>>   drivers/ddr/altera/Makefile                   |  4 +-
>>   drivers/ddr/altera/sdram_arria10.c            | 57 +++++++++-----
>>   drivers/ddr/altera/sdram_gen5.c               | 38 +++++++++-
>>   drivers/ddr/altera/sdram_soc32.c              | 74 +++++++++++++++++++
>>   drivers/ddr/altera/sdram_soc32.h              | 11 +++
>>   16 files changed, 205 insertions(+), 55 deletions(-)
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>
>> I will need to drop these patches (1/5, 2/5, 3/5) for now as it causes the U-Boot SPL file size to exceed the limit on several Cyclone V variant defconfigs (see CI failure: https://source.denx.de/u-boot/custodians/u-boot-socfpga/-/jobs/1379031).
>>
>> Please consider restructuring the changes so that Arria 10 and Cyclone V are handled separately. Arria 10 has a larger OCRAM footprint, while Cyclone V is much more constrained.
>>
>> The SPL size overflow on certain Cyclone V boards must be properly resolved before we can take this upstream.
>>
>> Also, please make sure to run the pipeline tests and confirm they pass before resubmitting the patches upstream.
>>
>> Thanks for your understanding, and please resend once the Cyclone V size issue has been properly addressed and the pipeline is clean.
>>
>> Best regards,
>>
>> Tien Fong

