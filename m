Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65086C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29F286BAC;
	Mon,  6 Nov 2023 12:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeJSyI1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0779B86BD6; Mon,  6 Nov 2023 12:54:11 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD4586BA9
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQJDjO5f+kOgRvalEs4L398/MigFLDN0qE5fmy5Xt1axHid+woxAd0fi8DyNnGzUHTdHluLEAC/0rKfhqvTvtRbK/5yfucQ7Eox6Pw8A7PrqwDOF1dE9qNpNhdOGqP0TKX/Uv1RhqN7fXEER9eqhQI82nEE30CKVKAaL89VuFOWwW7i5Vx9W067cj/J9+tV4YMiWNUQlKIpGkwYZkZGVc5HvMVb3wdlDKYRGzBZ7wsI7YixNGv+KzFEvJbNbqgSx6PBfMO6pRSGkderAKoOr0qXPUijHvf30thrL+5UIOmihZxKOxdVs6Cou5qvyd1RN/5cXA5JuUEa1lD4Eub4kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL20LbOkwUoW4HsMcN6sp8K5GUiCH386YZ6k9Cz2Xts=;
 b=DI41f91pAIeSgAB578dOeKFLkvYLi72MmT3EFv5b5yS6k/mY7DYK4o2c+5xsPa3JEKQ3iAodquouC+eiuXqDaLkfxV6VmNOdvOkPieqgLM2vROZIV8mpe8QN64ZnEppSvdGYSFAoSBAFIL8roplu2RD1SQQbBU3dSjJpdesISzJgSqxD7uLU3bs8S21hq2+gibDNZaDVs052zpqpA9pHRu83FtRo7/gf9YgE0vEC+jhVwPt7Yeh74tFa/Cl/YX7JNWqPgo02+u8eeIWoT7mSsqhxK9vJPjfCFOUES29NK+as9ifQHuCEesAzeOCY75O/dzggWge8J6xvYRgU0gBf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL20LbOkwUoW4HsMcN6sp8K5GUiCH386YZ6k9Cz2Xts=;
 b=MeJSyI1FOGhPQ5+tiBCPfSRRedQHcfwp9vjURG2XW52PTmDQNfA+Sp2j8bIi2gcZMSy31TdGH8NJcUJsD361tuaWQ3OZZm8faeZwv5Xyf24whxAyNheNBtMqNPmrQ2DYFli/6yu9OWIESFC6rHWjShq4mOjjiv4PdAwarlIhUmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:54:01 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:54:00 +0000
Message-ID: <2435f340-8395-4810-893c-9a84d3246e0c@amd.com>
Date: Mon, 6 Nov 2023 12:53:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Add support for AMD/Xilinx MicroBlaze V
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Conor Dooley <conor.dooley@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Yixun Lan <dlan@gentoo.org>
References: <41c2fda5d6f96e44188d912811a63b8a40625e6e.1699027398.git.michal.simek@amd.com>
 <20231103-shell-those-d0776d5c2e41@spud>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231103-shell-those-d0776d5c2e41@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::21) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ad4c36-1697-4d34-34b2-08dbdebf109f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR6QTH6RNdq+sso2pvYRMe9iH7krEESzgdF9Bjf4CDwDmSAqvQzTEMgmiX1cnjmzyvGlIZ2zCnSwBcDLi+1988dpKqeUJNpVR+NBaHgMLWt7UQg/mX6gEhrBAY58TOLdDSmc4JHy407Ecn6aygxxZVZKo1i2MY1zQT89gUb8NAs4F8mrcEY3LPOlq0umOKUlRzuW1+t6HEVsyeQnOeUyBfj11ZEu3X8QzwJZgEqg6HhIeT62RLw3u2AAc6FxHMXa91ZF7Zt31aFkyF1iZVb/rRFWMUh+rCq6PHYntDYAp9ik8wKT1dJrU7E3Y1+7v1piA6GNhBmo4mlUNzz7940Kvn/WG0RjHQJZ67vzqCWpY2Gk1s2n1GNxYJBS/hFG84c1cSHoD5ESQNqiWCp9ZqwEdzhNO3vKYvw8uraMPAr2SyhDkZgUpLncC7z+jj/hV0DXQSEvpJIEMWYgmFDYYbpJcGpd2VCmyR0PBARDs8e/NnyX/bNvzrKuBA8bjIdm9NkcMtkl8sIN6sTH5wWD/ZcUgEAnm4vNH4ioln4sSq3fTX/nCkbU2TPU8EYaTVVmqbWKrB2aw6Nw9DcYs2aWQimhMk9k9u1TXKkdvERACdOyJc9TxJCwDjZzXOZrVp8vFzfA4b73LGHZXhGpNnfdGQGfbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(41300700001)(44832011)(6506007)(53546011)(2616005)(7416002)(6486002)(6512007)(6666004)(316002)(83380400001)(8676002)(4326008)(8936002)(5660300002)(26005)(66476007)(54906003)(66946007)(66556008)(6916009)(38100700002)(2906002)(31686004)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djYvS29pR3FUekI2VHpWTGZxTUpPL2VabVdzaVczYnp4bTJhWW56Z3ZtMEVI?=
 =?utf-8?B?SUtqa3JCTDFPcFBKY0o4SUkvRmt2dDM4SVZqa2MrZ1UxaXBsNXNwTGdrVStN?=
 =?utf-8?B?V3IyNzdVSXZWeGlzODZUWk8yQmJpUlRZck1rSGg5Q3lKTGlxdGVsaGQzdkEv?=
 =?utf-8?B?dmw1YXZHSlViOCs4WS9Fb3lrRVRHUG4yMG1vVDROZmNkYnUzTnFFS1ZWeVZF?=
 =?utf-8?B?emtkQSszS3BlU1cwcEp5QnhEZVJjSnFUYnlncWVrV1dhQWRabGdCN3BCZk5z?=
 =?utf-8?B?czZYU1crMENtWU1pL2JhVWl3Z2dYK2l4RlRJTXJxeTZCYStnNGUwUEJnK2JC?=
 =?utf-8?B?eE5heVprbFY4YVFQQkZXTjdyVXYrcW9DMk9MSndBb3FSNDN1Wk8raXUraW8x?=
 =?utf-8?B?L0twbmJLalQwUDVjeW8rbHFnd1lySDYvNUpKSEljWEVxOHVERU15RU83Yjh3?=
 =?utf-8?B?NWE1UFpIRVducmtLU1pyVlp0L3dlWkhFaHRUU25Bb216VWlSYWg3ZVZuZm5N?=
 =?utf-8?B?RTVDZHhYSm1LN1ZGRkxVbmpHcndER3oxaFZlYnRWK1B2bGI5QTZzL1ZYdmp1?=
 =?utf-8?B?Um5GVm5LRXA3d0dXMktva1Rad3BKVHlrdlNPVEx6djVUOWY5YmRIbnA4RGZu?=
 =?utf-8?B?ZXUwQmd6bmUvaHNGVFZTUVAwNjBsZTFPYUVCRG1WNEt2cEdUeUQ4M0pTMGh5?=
 =?utf-8?B?MXRZdzlXK3EzK1hGYUp2UVdRRjdzYUNvNWsxNTJ1blVMNm5lNGZ2UUpPZGdx?=
 =?utf-8?B?Z256NjhsSTFuczJ2em42ellyby9JMk9qQncwOFY5eVNNSXc0WWFXOTQzRFhw?=
 =?utf-8?B?dlcvcWszYmc1QlJMeU52K0lmY0ltM3M1ZnRuNzlNalVpTDV0a1JaeXZhMUhx?=
 =?utf-8?B?UTF1ekZMckYxQ2NjMlpZWVo1V1JwejZHa015R0cwS0lOckpZUlI4YUdacXRr?=
 =?utf-8?B?MDV2eXpsMmI4MjVpbFRsKzA5YkJic0JqL1hUOXZDZnR6QmZqTHBCaEZLN1hi?=
 =?utf-8?B?UlErRnB1U0Vud0xzcllhelViaEF1bFpVWmRlVk9ITW10NSs4ekorOTVVWUxF?=
 =?utf-8?B?SGtMUXlqeTJVeG53NWpnaWRpUC9xLzk3Rlk4ZDJIMitNenRVdEJncnNoRERW?=
 =?utf-8?B?cUdTTWJobkt2K3ZJRUlZQWRxTWtqdmUrUmpIZGx4SitOR1hrMkVkWEpNRjI3?=
 =?utf-8?B?VDJ4NElpSE1KMjlPY1lRbjJzZG95Y3RFR2VaaGowaWozbURoeE43YmZCNUJL?=
 =?utf-8?B?dmVzQ3l5L1dkWTlMNnBESGdtdUdNY1I3YkdUTHoxY09SVTNrTUZsWU80Q3JS?=
 =?utf-8?B?TjRpQkw3d0lvcjcwaTY5TU84U0M0QjFYcExJb2o4ZzIwL2R5bTJ2cnB1UUNh?=
 =?utf-8?B?WlNwaEJ0TkYrV1JYTVpUYktGTHVqOFRYVEpvTExJR0ovSFJRaVVOcFNkNk9N?=
 =?utf-8?B?TWJ0RkZtSFE3YVdGeW5UeHJZV1hVaHNMM2RMZ1NjaDQyOFQzQVdBR1BKMG05?=
 =?utf-8?B?L2NxaHBFc29NU1g5K0lYM1lzRjY0TlhtWlEwdWJLQWlFb1dSYmZDcHdMRllE?=
 =?utf-8?B?SDdEUytDZzUybTUzbVlwVjJReE16THBpUjVFOUZ6VTl1VkQram8wT1JFc1VE?=
 =?utf-8?B?dUx4c1FjQVlWeUdmRDdzYUZMM2FGWW5SSkJuTmhOTGtpRGF3MXIxY1RBRWVk?=
 =?utf-8?B?VlVKWjhFdjVkdWpLcEpkMG93M1A0RHc4UUxvYkZpeFJQOXdsYjJKOWtNdXA2?=
 =?utf-8?B?MDU3WFozWWFCYzJLWHRmalVISE4yQ2Z2TUtBTXlaZUlHYmtPak4vRU5xd25Y?=
 =?utf-8?B?WmhCUkR4VVZkVWRDMW93b0ZqV3NDMkUyQXlvM09pcGN6RHNzSUxMOEFpQ0F4?=
 =?utf-8?B?RitNUHE5cFg5bWRVVHp6ejRjM2JZWjZLU3dMNWhBQUlqdFVTOEJKZTBQeTYz?=
 =?utf-8?B?aVlOMDBGTGY3WWl2eDN6TDhwd2F3UkFGRWwwM2N2dUpPTVRLM3RPd29rckdv?=
 =?utf-8?B?cVY4WklYeEJldytSdml4dmZuUEFMb1IzK2hlc1IrckN5dWtPR2pTYm9NOWdJ?=
 =?utf-8?B?MUNoNms5NjlsSlY5YXNBcWdYODNETHFvMGgzVEN2c3haNHdNOE1SRXNWSks3?=
 =?utf-8?Q?YYXZiaDdienm+IPcxJDGYJKma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ad4c36-1697-4d34-34b2-08dbdebf109f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:54:00.7700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDDtnglIHRKWClvhvrh8PjLldn+BnomGy79//85y/3YVjtOOJ8wuHf1JGCtFIVz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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

Hi Conor,

On 11/3/23 17:25, Conor Dooley wrote:
> Yo,
> 
> Since you sent it to me, I may as well comment...
> 
> On Fri, Nov 03, 2023 at 05:03:25PM +0100, Michal Simek wrote:
>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>> It is hardware compatible with classic MicroBlaze processor.
>>
>> The patch contains initial wiring and configuration for initial HW design
>> with memory, cpu, interrupt controller, timers and uartlite console.
>>
>> Provided DT is just describing one configuration and should be taken only
>> as example.
> 
> 
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for Xilinx MicroBlaze V
>> + *
>> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
>> + *
>> + * Michal Simek <michal.simek@amd.com>
>> + */
>> +
>> +/dts-v1/;
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	model = "Xilinx MicroBlaze V 32bit";
>> +	compatible = "xlnx,mbv32";
>> +
>> +	cpus: cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		timebase-frequency = <102000000>;
>> +		cpu_0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "riscv";
> 
> You're missing a cpu specific compatible here.
> "riscv" in isolation is only for {emu,simu}lators.

Will add.

> 
>> +			reg = <0>;
>> +			status = "okay";
>> +			riscv,isa = "rv32imafdc";
>> +			clock-frequency = <100000000>;
>> +			i-cache-size = <32768>;
>> +			d-cache-size = <32768>;
> 
> Missing an interrupt-controller child node for the cpu-intc, no?

For u-boot interrupt controller is not needed but it is listed below that's why 
will try to wire it.

> 
>> +		};
>> +	};
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "earlycon";
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory@20000000 {
>> +		device_type = "memory";
>> +		reg = <0x20000000 0x20000000>;
>> +	};
>> +
>> +	axi: axi {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "simple-bus";
>> +		ranges;
>> +		bootph-all;
>> +
>> +		axi_intc: interrupt-controller@41200000 {
>> +			compatible = "xlnx.xps-intc";
> 
> This is some non-standard interrupt controller, rather than a plic,
> right?

non-standard riscv interrupt controller. But standard microblaze interrrupt 
controller. And of course it is not plic compatible. Based on my discussion with 
HW designers it shouldn't be a problem to use this one.

> Also, should you not also have a riscv,timer node?

It is design from Amd perspective as option to exchange microblaze with riscv 
that's why all IPs around it are the same. It means xps timer is used instead.

Thanks,
Michal


