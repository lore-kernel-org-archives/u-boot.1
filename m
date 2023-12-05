Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CF2C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 14:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B107871AA;
	Tue,  5 Dec 2023 15:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="24rep5o6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77AA8768F; Tue,  5 Dec 2023 15:21:01 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53E886D85
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 15:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edY6CwUdj/w+UWyOIcOtppRCm7quPgmJaNDRV0BP56sXl1mluhpj134102BB5om3JqO2enzlgwT0T71Ol9U8KqFY7wjJkeV/Vrv8dE3jZhb895TNhtLKl60yQPgu9bHM4rT5Tdp+BwD3T8qfrRR97BS1LPYAhTWWEvC/FHxKi/47mWY+UFf+PPhi5tn6PcdHzz17R59TxW2Il8v9oyvzkKirTt0jIpmBn+V/OsweC1t0ZbnN+PvOBZZFyOuV/Gdo+EORDsUUCSWnYHmTkVoWRLv8VeUNjKiZDxqg8ybSi85faPrrEfqaZWU0jmFEsTTV7u1EimA0S2CKWfN3kIIbIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vhrNjrMyqwzQ+YY9WEy8cHRm3DutnCH9F0IQyWuEDU=;
 b=UHyFuGb0DrkLDy8uCG1r3ROI0Ne29qJAgTOY8pDCc5Fc1lzbIBCvj/hOaDc1N0STyq913f6s5I9Cb78aPQFra+dV5/1rwRZO/fjjpMj3NWpaxzcM0JZWssACNOCadff7ZYVEJRRFW2PxLmTVH7tA2Uxv+/6RGEhdD8kGH9gLxEfWJGOLISyBWZbJ99h/gZYeAPLiJwPbE1ggt46PHekl5mzJMzi5vL+Pqe2Qa65E52G8HfnKbP9hkT9yqgUaJY/p9YO2w3Ste9rqwvmGCTCg1ZJ++LUKIEcwRkySZUxQLFLWW7R6oJBQjY8YHVotiSmBUgu1dKa1MH4Ikc+IzHgRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vhrNjrMyqwzQ+YY9WEy8cHRm3DutnCH9F0IQyWuEDU=;
 b=24rep5o6CyO4HtZphvQOkOMPQBq7w7BnKDgY+62CAQeTntwj1LBUnDhPwP1QKDxr/xj/QklnLqN2Jtt/uul4P+oB8keatFVlknwtstEU+hfv4DaX+xaA0xqPHM6Gy3zoPQhpBfCBztni5He5Cimf1+YlIHeXL7j/kitDfT36okA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:20:54 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:20:54 +0000
Message-ID: <a9088621-1b8c-4361-8294-863ab71ce823@amd.com>
Date: Tue, 5 Dec 2023 15:20:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Add support for AMD/Xilinx MicroBlaze V
Content-Language: en-US
To: Padmarao.Begari@microchip.com, u-boot@lists.denx.de, git@xilinx.com
Cc: rick@andestech.com, randolph@andestech.com, Conor.Dooley@microchip.com,
 ycliang@andestech.com, yanhong.wang@starfivetech.com, dlan@gentoo.org
References: <d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com>
 <77eb6bfd6d2e331d554604a73ed164a54fd05fbe.camel@microchip.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <77eb6bfd6d2e331d554604a73ed164a54fd05fbe.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0187.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cfd216-3430-4176-9b96-08dbf59d6432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mEKJqrCZRqs6mHt+9xpuf/w/hs/1H53c9XMOE51HG8uhIiD2HE1IaUbOHsLMiIm/RdgQcAxgHZK26JavQUXPYRrPiodA6tRZICjKEr3damepCSvT3PwnCFzCwtXj4vFRz8hpP3WjHzd/3uqKFf5t8Fz/26eeM3p9ygDkOKAcvsDpR9TGLep92QVry+6NjEDCNYfMn9VOlbGxNOcxapzOH+i8VfzsMcY8Ga7OWL7fCX+CZcPAPbRkjbm68yCcfsmJN7P5Nip5YyxVc8zMtW9hchTZFzmCywVqekdB87eitOfh/+1Qmy3fpk0701d9gK4u03mX+rz9UMa4RmIr2mNGGYQj90bISY7VnE+2vE3W+yfMXb4Qs/NPmr6yv06Us84RY1pdJqeXgM2XeRjiV7GxUb/rO9zZJjYWA4uT4WYBey9Y4XXQBUM21d6XsvmKMYV0ouL9rtvSx7iwSNqIV0R+rn5TYwKltR6YwY3FkOpMNb8EE3peN8OWdTO0iAWObFLvv5TvuZ6WFsA59CBh75O8pI4vfkL5NzYa/ftsVvM4O2Sz4jD5TQkSN2RV9t+x+6BPdW+1Kh1didfe0pubi6cEbZVyIh/ZdvWWLFrB2Kw2LpLrcYANsZBFylfmpbxOYC/IB6IJTji0ZNVxwDVyVuCPjxQJXKLdBQFaV6WM+/gMnP74v+nUOQEN7QBx6JFNONu763Xf7Go2Rx7kYXZcAfE6usuUEwWToPsJb/Tovpu5/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(478600001)(6512007)(53546011)(6506007)(8936002)(2616005)(966005)(6486002)(6666004)(26005)(66476007)(66556008)(4326008)(8676002)(66946007)(316002)(83380400001)(38100700002)(36756003)(2906002)(5660300002)(44832011)(86362001)(31696002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFCcTV6eHhZbU1wL2h0MFRWZE0ySlZZUHlIekUrelUxK3p2RSsyUlI4ZEk5?=
 =?utf-8?B?WDN0OFdNZjNDaGdDNE1CZnZJU1ZtME4ycmNTNkFad0drTlU3SG5hSzRmTi9q?=
 =?utf-8?B?Wm9TRFVOZm4wSWRwMnFRbmZONGhkcHdCbWdDcHZSNk1IelRaaXpJeWNyRWdp?=
 =?utf-8?B?Vnd1TWpseXFBcFhRRUlJcnlIQnVCVEk4U2w0QTlVTEE4ZXMyQ3h3L2xFei82?=
 =?utf-8?B?VmF6Y2VZOGpvZzRHM2E0ck1Bb0E3OHJVZ1NtTlpmNUpYaFJBZzhQTUh2cEcv?=
 =?utf-8?B?bGxUaWZOSWRCdW9uY25neklKSjB2VVNFNTR0eHRyaWtRU0FMaUFVZVdCcnJV?=
 =?utf-8?B?b1hCaDZESWRFMHZpT0VVdzZ2TGVienpLWHErSXYzdDhxVjRHNGhxMUs3bGNY?=
 =?utf-8?B?T05qMTVaT3BiY0k1dTZWNWE2dmJ2VXVNUGkzTU5oNnBuZTNYWkJUUmE2OThr?=
 =?utf-8?B?WXczR2JxUzQxdEcvdkdZZXBJWWhYYzc0aGRhVFlpMFd1cjlvY055UVBac2VX?=
 =?utf-8?B?L25ueW5xT01GdUdCNDcvckswTG9VOFBsYnEyTGtzNXZrb1k4Qkd1SFk4Y2pP?=
 =?utf-8?B?N3NXbmVCQ1Z6emNQRUxQRVY1T0xrSFlySFpkWnFxMGFEamhvSzhSSlRNSm8v?=
 =?utf-8?B?S0lmZk1XbllyeXVOSmdNbnhBRFlIbUZYSkVoUzFnblQ1L1dDTERhRlVFNXBh?=
 =?utf-8?B?NnlDNHZyUkEyR3o0ZlRZdXByVXBHaHk2M1IweXdMQjdZL1o5SnJZR0ZrMi9Z?=
 =?utf-8?B?NGc3MlA0VVJRSHRnRnBGL251enRXSk9WbTVCdjhlSTBsUzBMZTY1N284b1lT?=
 =?utf-8?B?MzNZcjJxMUpiSVlqYmlEb2VxaFRlbmU1ZzdVSFRCYkhKSU5KdHZQOFpNeTFt?=
 =?utf-8?B?L2kvbkNyY0pSYi9HRVZucldMWTlxQVNJQVo1MFN6WjUvRU9iUUJjME02Sk1F?=
 =?utf-8?B?K0c2UFdWVEM2VWxOenFnY0JPM0tDN0NUb1A2MG91WW5DOE9wZ0d1TTFkYnRn?=
 =?utf-8?B?OU1rVTFLU3VXMld3cmhrZXRTcWRLVVRWK1Yra3BLSTQ2UHZrcUg4ZkNPZE9I?=
 =?utf-8?B?d1orbTVzOGpSNVFFVGszUnF4c0FrcWxvT1FULzJFays0Y1FvYjZyZ1g4YUlw?=
 =?utf-8?B?Vkc4dFJBeVR5MkpjUTNMZitBOFdMeDRwOWxZSXA5Snc3R0ZYQ0g3RW4wYzVx?=
 =?utf-8?B?RnJwdldNNUhkUFA3TU1yOVlIaDhsMDVaakhDVUtSMnVNVzhPYXFUU0RHUnhQ?=
 =?utf-8?B?dVBnNHZsU0E1Rjd2c0JSSzhJUk5ZOW9ZZkdqMHBWdG5WcmJwbU5kZm1BcmMz?=
 =?utf-8?B?OVMrUGh4eDVldzJUdVNxaFhBYkxEQWxSdnlTWjRuendNc1AvWHV0enhyZHlx?=
 =?utf-8?B?dmJ0cDNHb1EySDY1TlZXQ244c2poQU11S0ErMkk0UXAzZ3g0VUNCdDNrQUZ5?=
 =?utf-8?B?T1k2b3phekRTOEVqdFFjMTFJRllIMzZiU0xrSEN0cG0zOVF2U21jY1p3UDM3?=
 =?utf-8?B?aHMvUXpza0RmbEU3aU93WWtiOXBCQ3B3aC9XN1NUeFdIeEkzN2J3dndFL2RR?=
 =?utf-8?B?V1pEeWdybXpHMU1mR1Bjb3Z2SVljMld2bE12Y0RFVzJrU2I4d2lML2J1U1Jl?=
 =?utf-8?B?U3ZSR0tVd21YRlB4VUxIck9TM2FOOFpZV2kvbkEvQ29idG5CenVSUktXVWlE?=
 =?utf-8?B?SDhpYVdyTERmV2FGVi9xNUwrK0xqR1VzOXJMbDdUWmg3WUhpRC85RUpLVXVQ?=
 =?utf-8?B?ZHp5aHhpOWs5UzRndlNhNmlsTDdOeTlpbGxrSHRkR2V3YmE2cjc3aHl2YnIy?=
 =?utf-8?B?SHZQYThmNjFjNzY3aEZiaEpBb3hRMTZHQ01Ka2p5WGp1ei90dXVkakk0REZG?=
 =?utf-8?B?SWpmMTdYckdwVVY4b2hPZEVVYVJOODJCK3BGTlpuYzNTT0JHMmE5b2Vrc01W?=
 =?utf-8?B?WERSQlNDOGdKY0Fob3FOU0dFa0wzK0YzZUdDRVJWSG5Fc3RFRmY4RXh4MGRM?=
 =?utf-8?B?YSttQXlHbE83UVEwVkd1NkV0eDdvV25GeE1ZV3RDSWZyQWRzNzdXcEptU1RE?=
 =?utf-8?B?UEpmNzRjNFpXTEIydUVpaWZIV0VnSHRETTJZSjB4Z04yUGNhcVZ2QXpXaC9s?=
 =?utf-8?Q?I8P7YmWUJ0pPt+yijqEhHFagh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cfd216-3430-4176-9b96-08dbf59d6432
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:20:54.4018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDMTWMKos0Yz3VR81NaDGpH5LzOhXuDK74YY1peNO2qtN+WGa9wI71O0teGtqeo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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



On 12/5/23 06:17, Padmarao.Begari@microchip.com wrote:
> On Mon, 2023-11-06 at 12:56 +0100, Michal Simek wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>> It is hardware compatible with classic MicroBlaze processor.
>>
>> The patch contains initial wiring and configuration for initial HW
>> design
>> with memory, cpu, interrupt controller, timers and uartlite console
>> (interrupt controller is listed but U-Boot is not using it).
>>
>> Provided DT is just describing one configuration and should be taken
>> only
>> as example.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - Extend commit message
>> - DT changes, add interrupt controller, check agains dt schema
>> - The patch for amd,mbv32 compatible string is here
>> https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com
>> - The patch for board compatibility is here
>> https://lore.kernel.org/r/50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com
>>
>> xlnx,xps-intc-1.00.a driver exists in the Linux kernel but DT binding
>> is
>> missing. That's something what we need to work on.
>> arch/arm64/boot/dts/xilinx/xilinx-mbv32.dtb:
>> /axi/interrupt-controller@41200000: failed to match any schema with
>> compatible: ['xlnx,xps-intc-1.00.a']
>>
>> Public annoucement is available here if someone is interested.
>> https://www.xilinx.com/products/design-tools/microblaze-v.html?utm_source=marketo&utm_medium=email&utm_campaign=EN-EM-2023-11-02-New-MicroBlaze-V-Processor&utm_term=btn&mkt_tok=NDA5LVdZWC03MjQAAAGPMMJYuPPscCags7WdvOeUSWy-_mC9aOwrobFaZRf5ok_eHoQUvTLBzJdHrkcBId9tQ4a-odfnU91WjUkIxx-iSG4OKGofjK5iZcAiK_VN8_xK
>>
>> ---
>>   arch/riscv/Kconfig                   |   4 +
>>   arch/riscv/dts/Makefile              |   2 +
>>   arch/riscv/dts/xilinx-mbv32.dts      | 106
>> +++++++++++++++++++++++++++
>>   board/xilinx/Kconfig                 |   3 +-
>>   board/xilinx/common/board.c          |   5 ++
>>   board/xilinx/mbv/Kconfig             |  28 +++++++
>>   board/xilinx/mbv/MAINTAINERS         |   7 ++
>>   board/xilinx/mbv/Makefile            |   5 ++
>>   board/xilinx/mbv/board.c             |  11 +++
>>   configs/xilinx_mbv32_defconfig       |  30 ++++++++
>>   configs/xilinx_mbv32_smode_defconfig |  32 ++++++++
>>   include/configs/xilinx_mbv.h         |   6 ++
>>   12 files changed, 238 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/dts/xilinx-mbv32.dts
>>   create mode 100644 board/xilinx/mbv/Kconfig
>>   create mode 100644 board/xilinx/mbv/MAINTAINERS
>>   create mode 100644 board/xilinx/mbv/Makefile
>>   create mode 100644 board/xilinx/mbv/board.c
>>   create mode 100644 configs/xilinx_mbv32_defconfig
>>   create mode 100644 configs/xilinx_mbv32_smode_defconfig
>>   create mode 100644 include/configs/xilinx_mbv.h
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 6d0d812ddb55..67126d96af89 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -39,6 +39,9 @@ config TARGET_TH1520_LPI4A
>>          bool "Support Sipeed's TH1520 Lichee PI 4A Board"
>>          select SYS_CACHE_SHIFT_6
>>
>> +config TARGET_XILINX_MBV
>> +       bool "Support AMD/Xilinx MicroBlaze V"
>> +
>>   endchoice
>>
>>   config SYS_ICACHE_OFF
>> @@ -82,6 +85,7 @@ source "board/sifive/unmatched/Kconfig"
>>   source "board/sipeed/maix/Kconfig"
>>   source "board/starfive/visionfive2/Kconfig"
>>   source "board/thead/th1520_lpi4a/Kconfig"
>> +source "board/xilinx/mbv/Kconfig"
>>
>>   # platform-specific options below
>>   source "arch/riscv/cpu/andesv5/Kconfig"
>> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
>> index be6c8a422729..b05bb5607f06 100644
>> --- a/arch/riscv/dts/Makefile
>> +++ b/arch/riscv/dts/Makefile
>> @@ -9,6 +9,8 @@ dtb-$(CONFIG_TARGET_SIFIVE_UNMATCHED) += hifive-
>> unmatched-a00.dtb
>>   dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
>>   dtb-$(CONFIG_TARGET_STARFIVE_VISIONFIVE2) += jh7110-starfive-
>> visionfive-2.dtb
>>   dtb-$(CONFIG_TARGET_TH1520_LPI4A) += th1520-lichee-pi-4a.dtb
>> +dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
>> +
>>   include $(srctree)/scripts/Makefile.dts
>>
>>   targets += $(dtb-y)
>> diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-
>> mbv32.dts
>> new file mode 100644
>> index 000000000000..6a6b8b694bd1
>> --- /dev/null
>> +++ b/arch/riscv/dts/xilinx-mbv32.dts
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for AMD MicroBlaze V
>> + *
>> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
>> + *
>> + * Michal Simek <michal.simek@amd.com>
>> + */
>> +
>> +/dts-v1/;
>> +/ {
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       model = "AMD MicroBlaze V 32bit";
>> +       compatible = "amd,mbv";
>> +
>> +       cpus: cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               timebase-frequency = <102000000>;
>> +               cpu_0: cpu@0 {
>> +                       compatible = "amd,mbv32", "riscv";
>> +                       device_type = "cpu";
>> +                       reg = <0>;
>> +                       riscv,isa = "rv32imafdc";
>> +                       i-cache-size = <32768>;
>> +                       d-cache-size = <32768>;
>> +                       clock-frequency = <102000000>;
>> +                       cpu0_intc: interrupt-controller {
>> +                               compatible = "riscv,cpu-intc";
>> +                               interrupt-controller;
>> +                               #interrupt-cells = <1>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       aliases {
>> +               serial0 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "earlycon";
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +
>> +       memory@20000000 {
>> +               device_type = "memory";
>> +               reg = <0x20000000 0x20000000>;
>> +       };
>> +
>> +       clk102: clock {
>> +               compatible = "fixed-clock";
>> +               #clock-cells = <0>;
>> +               clock-frequency = <102000000>;
>> +       };
>> +
>> +       axi: axi {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               compatible = "simple-bus";
>> +               ranges;
>> +               bootph-all;
>> +
>> +               axi_intc: interrupt-controller@41200000 {
>> +                       compatible = "xlnx,xps-intc-1.00.a";
>> +                       reg = <0x41200000 0x1000>;
>> +                       interrupt-controller;
>> +                       interrupt-parent = <&cpu0_intc>;
>> +                       #interrupt-cells = <2>;
>> +                       kind-of-intr = <0>;
>> +               };
>> +
>> +               xlnx_timer0: timer@41c00000 {
>> +                       compatible = "xlnx,xps-timer-1.00.a";
>> +                       reg = <0x41c00000 0x1000>;
>> +                       interrupt-parent = <&axi_intc>;
>> +                       interrupts = <1 2>;
>> +                       bootph-all;
>> +                       xlnx,one-timer-only = <0>;
>> +                       clock-names = "s_axi_aclk";
>> +                       clocks = <&clk102>;
>> +               };
>> +
>> +               xlnx_timer1: timer@41c20000 {
>> +                       compatible = "xlnx,xps-timer-1.00.a";
>> +                       reg = <0x41c20000 0x1000>;
>> +                       interrupt-parent = <&axi_intc>;
>> +                       interrupts = <0 2>;
>> +                       xlnx,one-timer-only = <0>;
>> +                       clock-names = "s_axi_aclk";
>> +                       clocks = <&clk102>;
>> +               };
>> +
>> +               uart0: serial@40600000 {
>> +                       compatible = "xlnx,xps-uartlite-1.00.a";
>> +                       reg = <0x40600000 0x1000>;
>> +                       interrupt-parent = <&axi_intc>;
>> +                       interrupts = <2 2>;
>> +                       bootph-all;
>> +                       clocks = <&clk102>;
>> +                       current-speed = <115200>;
>> +                       xlnx,data-bits = <8>;
>> +                       xlnx,use-parity = <0>;
>> +               };
>> +       };
>> +};
>> diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
>> index 4f0776e8bd95..843198fa0da8 100644
>> --- a/board/xilinx/Kconfig
>> +++ b/board/xilinx/Kconfig
>> @@ -51,10 +51,11 @@ config XILINX_OF_BOARD_DTB_ADDR
>>
>>   config BOOT_SCRIPT_OFFSET
>>          hex "Boot script offset"
>> -       depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL ||
>> ARCH_VERSAL_NET || MICROBLAZE
>> +       depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_VERSAL ||
>> ARCH_VERSAL_NET || MICROBLAZE || TARGET_XILINX_MBV
>>          default 0xFC0000 if ARCH_ZYNQ || MICROBLAZE
>>          default 0x3E80000 if ARCH_ZYNQMP
>>          default 0x7F80000 if ARCH_VERSAL || ARCH_VERSAL_NET
>> +       default 0 if TARGET_XILINX_MBV
>>          help
>>             Specifies distro boot script offset in NAND/QSPI/NOR
>> flash.
>>
>> diff --git a/board/xilinx/common/board.c
>> b/board/xilinx/common/board.c
>> index 9309b071269f..12a877c71549 100644
>> --- a/board/xilinx/common/board.c
>> +++ b/board/xilinx/common/board.c
>> @@ -652,6 +652,11 @@ int embedded_dtb_select(void)
>>   #endif
>>
>>   #if defined(CONFIG_LMB)
>> +
>> +#ifndef MMU_SECTION_SIZE
>> +#define MMU_SECTION_SIZE        (1 * 1024 * 1024)
>> +#endif
>> +
>>   phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>   {
>>          phys_size_t size;
>> diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
>> new file mode 100644
>> index 000000000000..4bc9f72c541b
>> --- /dev/null
>> +++ b/board/xilinx/mbv/Kconfig
>> @@ -0,0 +1,28 @@
>> +if TARGET_XILINX_MBV
>> +
>> +config SYS_BOARD
>> +       default "mbv"
>> +
>> +config SYS_VENDOR
>> +       default "xilinx"
>> +
>> +config SYS_CPU
>> +       default "generic"
>> +
>> +config SYS_CONFIG_NAME
>> +       default "xilinx_mbv"
>> +
>> +config TEXT_BASE
>> +       default 0x80000000 if !RISCV_SMODE
>> +       default 0x80400000 if RISCV_SMODE && ARCH_RV32I
>> +
> The memory location of this board is at 0x20000000 but using 0x80000000
> here and "CONFIG_SYS_LOAD_ADDR=0x80200000" in deconfig.
> Is the 0x80000000 memory location used for this board?
> 
> Other than that:
> Reviewed-by: Padmarao Begari <padmarao.begari@microchip.com>

It is based on fpga design where main memory is. Maybe easier to simply not to 
define it and let every config to set it up self.

Thanks,
Michal

