Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7C4C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 19:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA9687FF5;
	Tue, 20 Feb 2024 20:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E6hMb8YI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CCC87FF5; Tue, 20 Feb 2024 20:18:46 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E8A87FF1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 20:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hObPMhh4t/frmNMfX+YZutRoFH1ylLK1jCY2DE5R5Q0jAAwaUpxCEl+qQMDRb+QsRGVjmTmY7m6QyZm70jrCoBTR4Yg83tp531IXMDxgsqovFA/C46jO4sejrUbgzkagpj9dD34C9etZ1Gn9+7eBgGI8BK7yIzm1X2fhpW+Id+24M8Cogjvm8WK/GuFQ9vQpEf7lQAb76eB77hF4VmBvcWoAKs9CMeMLiM9rayWjIWIzb1UFsZ5/X+zeuUS3HLAke2Uz0FA452BAU3uFv5CaA03u/KMe1NNpoKojTbadKcIHZNSg33tm6viIdMT8A3RnlJtjGXTIZpqM/xguVZrTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWrjrVFENiAPHkWd4AOtw8ejNHGtOxZmjD+U/6sPJ98=;
 b=L+Wqbx0SZ2Wa6PYLlb+IoOEZbKaOAY75gwCWEmdOZOQ6lYmQA6M8LzSOMqZJ36aAdNd7o37lqEfyqQpsCqVJVU9woTkeMU0C1fRR7oYAn9JGsGkVbn/OO0KDC9XpxFLh8ZUWQYgVGACg6Krt0Oe5haqBPphnPqFsd10UEr1EIpndQwdwW6ttoUhmLoudeBnrJkjZscwzEFAHV1p0kCwTqEmLnivGJCtnCzIzOtbsnWFD4oh9/VlB6Y0/AB9tlIqVQoF51zOhSy4Ph1236kLcLc1iXd3745CP9L2qr+VDnVEuKRUrxD7s4FxAIOnc1IpVCHHLMZYjshrVE1MhMkgwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWrjrVFENiAPHkWd4AOtw8ejNHGtOxZmjD+U/6sPJ98=;
 b=E6hMb8YIgAR/p842aZEDNW3progBiumJXTaoyaKXqZjxwhyoEaFlf4R5XGzY/vfzIvuenPAn2nVyp+KN+Ud1nkUJJcv7ec0xs53bRiBoKTy4jqlu7qQePhmemNa8lvRa7TwzhvdogGixc15kyN/1VEoE1eJRLLNZoafisd9Zubk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH8PR12MB7206.namprd12.prod.outlook.com (2603:10b6:510:226::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 19:18:33 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 19:18:33 +0000
Message-ID: <769ad987-fdef-4edf-adf8-96f8acee63e3@amd.com>
Date: Tue, 20 Feb 2024 20:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
 <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
 <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::18) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH8PR12MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: f71207e2-2e3c-4a10-93eb-08dc3248baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC0Is/YHM7E06yA4/cPIxhM8yzer4D9InA6mFrqTBms+A9oWuWX2V+nnOMuws+ArUGDNkoDpCPlopH1JdziG5ELVH1PnCpI8LKq8EqaivhDEJ8YVut9mm1d2SyMYdUS7W9xE15L7lM43yWE5kT85Ye7WUm1lkhtCDgLIkmIOBxkGLSSH3PY986ihv8iDGQkc6r5nNeCEfBgIUAttKH3lR4lus+9j2y/ldzFZ2OansHNcSPD7XK+TQuvC/+xPV0zaC1iMpHl8R56opal/AYza3pBBco8Mj1X+ZOd1KCjtobcek55MIdxDezGNHe847OuhaJ7vVef1icPeRp55FS95pvkUmMvxJwkaTCJnPAJ+3nDPXw+AGnq7bt3Qzjv4EwA8GuxN4wiKYrZJ47jJGuQVVRhOcc7bU+0j+31w0+smy8mZVozTI7dNM00NZjOVHJh7/9JDIijSPtLj+yLWUli9MuWTvo4a+xxzEXMQaoSzFmcyqFvDK+O0R+AuaVOfaUBmJNVKNYQWjT+v4uh9GS9BcNQOvCNN5/8f4alc4XpQXfr7WTMQO/lbShsJQ0Blrax0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWhVQTlaU3ZZTEJtM2QzNEFxb2tDa3ZuTHp2ZzdpM0ZUNnErYXNaUXRrKzBy?=
 =?utf-8?B?SFhsVVNpR2wrUWJvSkIzQjRuaERVQXczemJQdktQY1lFNWM1SFdCelJKMHJh?=
 =?utf-8?B?YURaUExiYmRuQ3RZbjkrdnFVQndkWnZDN1VPdU9qSTNDTlR6MDhHYktuNUZS?=
 =?utf-8?B?UXNsUWwxZURpUGlXN0Q2TFdtcjRJN2w0YWdqcHJSa0VLRVBWblFsWi9OZG91?=
 =?utf-8?B?OS8yVWk0emJqa2JlZXJoOUdtN29jdlNLL1RaZTliU25GeWUrYjIzSWZCSDNY?=
 =?utf-8?B?dHFodys1WnFVb2YxRzBtY0Jqc0dGL25tSVVOUEg3dHp3RVpxcjd3VG5teExS?=
 =?utf-8?B?aHpQZ3Ezb1BjWUYzVzNDOHk5UlJuY1NRU0pXMjQ1OUhOTzdwYTBaS3RQa1hv?=
 =?utf-8?B?NzVGcU9BK0I5eDZZVktJRVl6aW9JZXlnZ3lVMTN4RnZaSmxJYWVvc2NmcW81?=
 =?utf-8?B?eU1jRXhFbkZIWVRnRE1hLzA1aDJVemNNRkdmSEU5MGxQZzB4NlZUL1dGeVB3?=
 =?utf-8?B?L3dFWlY5VmtCeUxvSHNxTUw1TnBPQUdLWklBcGU2Ymtsd240bzBVS3dlaGdP?=
 =?utf-8?B?UmYxdktrN2lBOGpxR3JqWGdOeEZYVVdzNXFTTDRERWFqZzMyaHN5QmlJbWtl?=
 =?utf-8?B?ZnhmVXd0Sy9BbG0xNE9MRFNEeTYrQ2Y5MHEwMHY2cGgzaVRqVEFmUm9QUVpR?=
 =?utf-8?B?Wm1ETUJHQzZITSs2Ky9JVmVQRmNpOENTYXV1TTVGQUR1K3JIZkNRRW11TlNs?=
 =?utf-8?B?RzdmTzNoUXZrUnhWUzlUZGxkRlh6eit0TGNaenpFbDhyU2Q3ODBjcWFMUi9q?=
 =?utf-8?B?VzNrZ2o0a0x5YTZNQ3d6UXZnSVRzaW1UOTRuV0ZNZXhCd04zdFZPSnJpZ1Y5?=
 =?utf-8?B?S2VqTzVDdGlVNE8xellLcTIwL0YxaG1jeTY2Z0FRWWp6TE1WYVJuWFdqbUVo?=
 =?utf-8?B?QjlxSWlxQVhtdGc4UTFuOFpUdFBZWDBEK2ZmenZ2Z2U0UWNCd2tSUjd3K28r?=
 =?utf-8?B?K1hqRnhTVFpvTy9kTVgxQVBFSmpxQ3M5b0d2cnZuNHBhamhCWTZyTjVaOC9Q?=
 =?utf-8?B?NnY3YW9sdkFXR1J2UkRHbmM1U2NwWWxTa1BZMS9qL2lpc0paRnpUZkRRb3Rr?=
 =?utf-8?B?RTh4cUZBdkN5VTdrYjZQci9pU3RzWVJMSzlka0NMRWFiT1BWSGMvVENHRExE?=
 =?utf-8?B?eEdOcnhLeEFaREJyNC9oNzFUMmFHMmRQNFVKVGI2c0p2WkROVEMzMUo0OFZ5?=
 =?utf-8?B?MEpza0NETzZWNG13ekhDSEEyWVgwY3hzU001RUxHSmFhWEFoRE41ZW5TTDV1?=
 =?utf-8?B?alBNd0RqM2pGcHRuRlpRMjRmc1hHMVJWaEVCdjNYNHNBS0xnTnZkK2ZGNTFY?=
 =?utf-8?B?L0ZhT0IrMXNrRUs1djFsZFVueUt0L1pHMWs3R2FuWE9Ybkw3emliditqRFIr?=
 =?utf-8?B?cW0xdTZJZnpOQi83TU9xd2hVbXVmbnhtSVZIK2xWMi9xSTREcUJneUk3K3FO?=
 =?utf-8?B?TmFtekFlZUpXcGczaTJPL3BWNlB5WU5BQjhqUnNoSEhLeWMrRmRRdmk1aTRt?=
 =?utf-8?B?WEJhTmlkaC9SRStSSU5NK1N4T21aRkdqa1pQMzhSOXZLbTFKcnpDeU9IUVl4?=
 =?utf-8?B?cFdjTUc1a0xxVUZ1YVNaU3NFek9ibXpFZXhCYWtMbmlsZlNQK0N6VU1RSGEr?=
 =?utf-8?B?VFYxczVxQnJycUNESEhsZUcvdml6QWs0YUZSTW1GS243OHptaEUrL0NuTnhJ?=
 =?utf-8?B?ZmRsSE5GU2VyMTBDajBTeSswL3dXQzdjS3ZiVmFDZ29LNlRRMkFPeTcxRk5h?=
 =?utf-8?B?Y1RSQmhSc2N1QVdwa0NKQmpUWGFCOW04TFNqYVhDeUsvY1E5TkVVK3RYazBK?=
 =?utf-8?B?bVVLTUYySmNkSWYxM0M4cHpTOTRzUlQrUnhDTm5IaHQxUmVoaEM2VDZjRVpz?=
 =?utf-8?B?NGE2elBPZHJERCs3TUh1TlVmVHBDV3F3WnFpNk5Ia1JMQTJyU1ZMOEdId1o5?=
 =?utf-8?B?cUdqZkhUeHF4QW5jaGMxbnRVU0VPSGRTdlRpbnhvdUhlSlVPY1I2dDhJZlBr?=
 =?utf-8?B?VU5pSVQ1dmU2elYvcEZkNHk5VHlMRHU0ZzE0QzhFcW1SbzhJYzJ3VThib1gv?=
 =?utf-8?Q?fuSmJmYERwDPxxWiKbUSMDRBp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71207e2-2e3c-4a10-93eb-08dc3248baa6
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:18:33.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiTlgAOr0fiIYu6c/GpPs4iJBZf47Rr6erRG/3hsn2mXA6QZ+RkVQ62SpX5E5+ul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7206
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



On 2/20/24 19:43, Sean Anderson wrote:
> On 2/20/24 13:24, Michal Simek wrote:
>>
>>
>> On 2/16/24 17:09, Sean Anderson wrote:
>>> On 2/16/24 11:03, Sean Anderson wrote:
>>>> On 2/16/24 10:06, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>>>>>> However, this is a bit tricky to time, since the debugger has to wait
>>>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can result in
>>>>>>>>> long waits, since occasionally initializing RAM (and other things in
>>>>>>>>> psu_init) takes a long time to complete and the debugger must wait for
>>>>>>>>> this worst case.
>>>>>>>>>
>>>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>>>>> debugger when we are ready for the image. This means we don't have to
>>>>>>>>> wait any more than necessary. We don't change the default config to
>>>>>>>>> ensure we don't break compatibility with existing debuggers that don't
>>>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>>      arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>>>      1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>>      #include <image.h>
>>>>>>>>>      #include <init.h>
>>>>>>>>>      #include <log.h>
>>>>>>>>> +#include <semihosting.h>
>>>>>>>>>      #include <spl.h>
>>>>>>>>>      #include <linux/delay.h>
>>>>>>>>>
>>>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>>>      }
>>>>>>>>>      #endif
>>>>>>>>>
>>>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>>>> +{
>>>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVICE_RAM;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>      void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>      {
>>>>>>>>>             spl_boot_list[0] = spl_boot_device();
>>>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>>>             if (spl_boot_list[0] == BOOT_DEVICE_MMC2)
>>>>>>>>>                     spl_boot_list[1] = BOOT_DEVICE_MMC1;
>>>>>>>>>
>>>>>>>>> -       spl_boot_list[2] = BOOT_DEVICE_RAM;
>>>>>>>>> +       spl_boot_list[2] = jtag_boot_device();
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>>      u32 spl_boot_device(void)
>>>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>>>
>>>>>>>>>             switch (bootmode) {
>>>>>>>>>             case JTAG_MODE:
>>>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>>>> +               return jtag_boot_device();
>>>>>>>>>      #ifdef CONFIG_SPL_MMC
>>>>>>>>>             case SD_MODE1:
>>>>>>>>>             case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>>>>
>>>>>>>> Good timing. Can you please tell me how to test this? What's the setup?
>>>>>>>> Which debugger are you using?
>>>>>>>
>>>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2freview.openocd.org%2fc%2fopenocd%2f%2b%2f8133&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f832185958363d84f990a08
>>>>>>>
>>>>>>
>>>>>> I am trying it on the top of the latest git but getting issue with event block and no idea how to fix it.
>>>>>>
>>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:22)
>>>>>> Licensed under GNU GPL v2
>>>>>> For bug reports, read
>>>>>>        https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>>>
>>>>>>
>>>>>> Do you know how to fix it?
>>>>>
>>>>>
>>>>> I actually bisect it and found that it is caused by
>>>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>>>
>>>> Interesting. I have been testing with 0.12.
>>>>
>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digilent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp.cfg
>>>>
>>>> FWIW after installing the udev rules I do not need sudo
>>>>
>>>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38)
>>>>> Licensed under GNU GPL v2
>>>>> For bug reports, read
>>>>>       https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=http%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=6e1be473-0b3f-4bc4-a4f0-403592e74baf&auth=d807158c60b7d2502abde8a2fc01f40662980862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>> none separate
>>>>> Info : auto-selecting first available session transport "jtag". To override use 'transport select <transport>'.
>>>>> Info : Hardware thread awareness created
>>>>> boot_apu
>>>>> Info : Listening on port 6666 for tcl connections
>>>>> Info : Listening on port 4444 for telnet connections
>>>>> Warn : An adapter speed is not selected in the init scripts. OpenOCD will try to run the adapter at very low speed (100 kHz).
>>>>> Warn : To remove this warnings and achieve reasonable communication speed with the target, set "adapter speed" or "jtag_rclk" in the init scripts.
>>>>> Info : clock speed 100 kHz
>>>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=0x48e70126)
>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM Ltd), part: 0xba00, ver: 0x5)
>>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (Xilinx), part: 0x4738, ver: 0x2)
>>>>> Error: JTAG-DP STICKY ERROR
>>>>> Error: [uscale.a53.0] Examination failed
>>>>> Warn : target uscale.a53.0 examination failed
>>>>> Info : [uscale.axi] Examination succeed
>>>>> Info : starting gdb server for uscale.a53.0 on 3333
>>>>> Info : Listening on port 3333 for gdb connections
>>>>> Info : gdb port disabled
>>>>>
>>>>> but with zcu102 I am still not able to connect because error above.
>>>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable).
>>>>> It looks like that not everything is working for zynqmp.
>>>>
>>>> Is this with the boot mode set to JTAG? If so, you will not be able to
>>>> examine any of the CPUs until you have released them from reset. So you
>>>> should be able to run
>>>>
>>>>           targets uscale.axi
>>>>           boot_pmu /path/to/pmu-firmware.bin
>>>>           boot_apu /path/to/u-boot-spl.bin
>>>>
>>>> to boot a CPU. If you want to silence the above error, you can add
>>>>
>>>>           uscale.a53.0 configure -defer-examine
>>>>
>>>> to your config. So the full command would be
>>>>
>>>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>>>           -f target/xilinx_zynqmp.cfg \
>>>>           -c 'uscale.a53.o configure -defer-examine' \
>>>>           -c init -c 'targets uscale.axi' \
>>>>           -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>>>           -c 'boot_apu /path/to/boot.bin'
>>>>
>>>> Let me know if that works for you.
>>>
>>> Oh, and I forgot to mention, but if you are testing semihosting then you will need to add
>>>
>>> -c 'uscale.a53.0 arm semihosting enable'
>>>
>>> to the end of that. I also find setting the semihosting base directory with
>>>
>>> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
>>>
>>> to be helpful.
>>>
>>> As you can imagine this is a long command line, so I have a config which looks like
>>>
>>> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
>>> adapter speed 25000
>>> source [find target/xilinx_zynqmp.cfg]
>>> uscale.a53.0 configure -defer-examine
>>>
>>> proc boot {imagedir machine} {
>>>           targets uscale.axi
>>>           boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>>>           boot_apu "${imagedir}/u-boot-spl.bin"
>>>           uscale.a53.0 arm semihosting enable
>>>           uscale.a53.0 arm semihosting_basedir $imagedir
>>> }
>>>
>>> which I invoke like
>>>
>>> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine'
>>
>>
>> ok. 0.12.0 version is working better. I am able to load firmware to APU but I was not able to load pmufw. It was saying timeout like this.
>>
>>> boot_pmu /mnt/disk/som/pmu_obj.bin
>> /usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173: Error: Timed out waiting for PMU firmware
>> in procedure 'boot_pmu'
>> in procedure 'resume_pmu' called at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 232
>> at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg", line 173
>>>
>>
>> Then I looked at pmu and use below snipset which I use on xsdb to make it visible for debugger and also small waiting time.
>>
>>
>> @@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparation for loading new firmware.\
>>          This should be matched with a call to resume_pmu."
>>   proc halt_pmu {} {
>>          set axi $::_CHIPNAME.axi
>> +
>> +       puts "Enable PMU target"
>> +       set val [$axi read_memory 0xFFCA0038 32 1]
>> +       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]
> 
> These should already be set. See table 39-3 in UG1085. Although I seem
> to have a combination of 39-2 and 39-3:
> 
>      > targets uscale.axi
>      > # BOOT_MODE_USER BOOT_MODE_POR
>      > mdw 0xff5e0200 2
>      0xff5e0200: 00000000 00000000
>      > # jtag_chain_cfg jtag_chain_status jtag_sec jtag_dap_cfg
>      > mdw 0xffca0030 4
>      0xffca0030: 00000000 00000003 0000003f 000000ff
> 
> Do you see these values in the JTAG boot mode?

That 0x1c bit are
"Setting these bits disables the security gate for the PMU MDM and allows the PS 
TAP to connect to the PMU. All bits must be set to 1 for the security gate to be 
released. (POR reset only)"

This is enabled to see PMU microblaze MDM. But I expect microblaze is not 
supported by OpenOCD but this makes it work for me.

> 
>> +       sleep 5
> 
> Part of my goal here is to remove "magic" sleeps like this so the boot
> process goes faster.

I get it. 5s is likely too much and didn't try to minimalize.

> 
>> +       puts "PMU target should be enabled">         set val [$axi read_memory $::IPI_PMU_0_IER 32 1]
>>          $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_PMU_0}]
>>
>> With that I am able to test your patch but it is kind of slow.
>> Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz used by xsdb.
> 
> I have been using the maximum 25 MHz speed without issue.

Can you provide more details about board you use?
I can switch to different cable or different board but based on
your config you are also using digilent smt2 NC module (without USB on it)
that's why it is quite scary that I am not able to run it at higher freq.

I will try different board or different cables.
Do you know if standard xilinx cables are supported?
This one
https://www.xilinx.com/products/boards-and-kits/hw-usb-ii-g.html
or black version?

Thanks,
Michal
