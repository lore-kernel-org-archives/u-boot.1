Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45486C44524
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356D482991;
	Mon, 20 Jul 2026 08:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="glyYQgK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA56183E76; Mon, 20 Jul 2026 08:11:22 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E26C80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Revex1uVkzpcIGE9INNO9z1MA5HPtha25t1Xu9grFYjztjNPd4kOc279MsHwQVSGr5Tqcm7kZwwg+qxeqcsoZ3ioDQaYU3+ZjN3MNdQA/pLztTzDdoLRcRMZquHmfCha/ZJFRHWFsK0aU7TLYwQ8YEDhGQ27jr3xOf1loDTGR5w4x77gIky+jUNcSSU17SXSmyGQxEm/UXjwPx35BXbBtcZfEmJDQAr8lIWcb/qr4BeQWAmhGGykD2UCqkeNePNz8nPIKfKm3caQU6CVGNscOKw0XZlTcfBAFi7wTvgkxMOaKGVnBsAc6XuVGVFSHEij6Hkdcx1aBMmTl9yIedDVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSetMVuzrqpdruQn0ifg2ZYgp0D+vACzjFEWQscIhcg=;
 b=unaOdPvvWdfnauaG7vKGva2L2gYvfPfMWgvBRMjlTVGAYgx5s6LdqlrqZdzMs4/pYa51F2LTGh76ZeCI/tnwQsO4K9EFspCpo+s51GalWQNaUlkx918jG56kvMnKKaifB2qsDXJk+p2t1zWaK4wIFO6OHxoMRknhCZ7p0nYdlEU/WJD7fvmsP9vMTOPcNOJYxo0W+HFulRPyESdl0wt/A0f46DJV81DrafzzoUYP8aGr6u2kYFmaqAGGbAGy6iRCCg5gn4xQGiRgI9KEgXnNCds+fy6z22t4O7Wk6lqLt3OdRM2H98wwsSJPRdCRpEmxMhJHFo4AVjXTpnhH+F87Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSetMVuzrqpdruQn0ifg2ZYgp0D+vACzjFEWQscIhcg=;
 b=glyYQgK1qiO5X1SyL+AztOuvhlIkyYwOFUXL+dG/Eh2ZPeNZXeJ7ZzN6GunU45s0vSvWES3Nj4AanI1wFUB3vMVVYv0exYiIzGuJs4PdsWqGAW+kWjIj2CkBwQrw270ElENF0M6KBSDBDhZKB+UZs1pISmVbdB5+6Al2YUntNyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:11:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 06:11:16 +0000
Message-ID: <179b7eb6-61ba-426f-9dd1-b0aad4a05426@amd.com>
Date: Mon, 20 Jul 2026 08:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is
 disabled
From: Michal Simek <michal.simek@amd.com>
To: Tim Ouyang <tim609@andestech.com>, u-boot@lists.u-boot-project.org,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, leo.liang@sifive.com
References: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
 <967b6d66-15f2-4e5c-9de9-3c530700cd05@amd.com>
 <5q5jvub5st33a5i3wfepjbqjcvxmxfyrjun7wxptqfjccra54d@ceo2hhhzibnv>
 <d00b7401-d52e-4d49-bfd3-6330d8b31a94@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d00b7401-d52e-4d49-bfd3-6330d8b31a94@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 74747d26-8ace-4128-c936-08dee625b52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|3023799007|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yhIvRzMYorplVBcTfTewxo2RoCxE+8/UxyT0sG8yV2NS8VtyCjDm+nKl7x6rUIGqiXdWY0+flVJmJY0P7LFtIiKV5Yl4I6++IssWA3sTlqakxe9fpyCjrcvdiD1wDz/REZteVAdcFSAFQzBpvvlytAEML8ta+KYFIiBuH86wau9LiYwcdW/VVAF9Ump/RP6bFzmYzvLltxOMmkfxGn1BbS/9gzg3xmoAbQxfj1CfZ/HQ+TsVxagGt9vHA096nqu2yA3Mk7cMYhnMxcY6MNthgIvQ7a5S47IE6VWTmnZo8sYQl1u/zeuUlTxlyTQQLEs60JDe0GfhcnDktiCoeAdEkh7sx/hjrZFbamz3qcqkMeEl+VKOfzFkyG+mAwkYCeQRYthI8AK77vR64dTkPLu91zSJNKyhvC4bQo5+PrOtyzpQykrghP1rlL5jZgMxi8YwnqTtyhdDNR27Dwrn0XRviYnlzTEb3r0No4749hwg8AIJoQpPKcig4NTJ4u/vqDWL64qDZqZVmwsO4eZxJvepSnH1fwTWLHmmhOm5ozgNxz0uESt2Ocnq6VjtyG0jIlEQEFrLOzhWQY8yNN9jmTS5KOwvAAuZsAexik+C84ffdyZR2lrOGVU4peiEB7PFwKXbRwcvWua20RgQ9BgcHTuZMuKiH2L9QbvZ3bOP4yotzqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVVQUF6UkFPa1U4ZTdON25wTEo2K0lsbmVEOEtkbmV6TnlnMnliZUdSeUJo?=
 =?utf-8?B?NDhJejdhUVF6YU1wS3NBWXVkekpnUldmczRZT09OVFJUZGV1aGpXVzd4TERP?=
 =?utf-8?B?MmtmRHlNRGlObDBKK05iSGEwaWJsY2lxZ3I0R1A5aUtBREdMNmhuQnJaaXNq?=
 =?utf-8?B?ZmF0cFZpUVpHOWdrVy9SSUM0UHhrb2szczJKUlFRZFRiblpvTFpOSGEyeFph?=
 =?utf-8?B?ZTdPcmVKais2aWRMQkF0UWRqNkt1cEpoUjV5WUMveTJPOG1HY3dvMXd5T3J2?=
 =?utf-8?B?QUNBVmZHalM1ZVBNRFNodStURFJ3ZUFGN0g3eVJDUWF3OENsYzkvLzZYWGxZ?=
 =?utf-8?B?RHBiaW9hbVN3dVcxcWZTcno3N2FpaXBmcXB2M3lFRGtWZkc4REFoZzAxZ3o4?=
 =?utf-8?B?N3VGYU14WWJFVWJPSmpwQVA2YzdLU1pDcXpXLzY3bGFWNFZqTEhmUkdOQ043?=
 =?utf-8?B?aGdRcDc0SUhON0NzWXVwVTZ3NDRIeFRlQ3UvbFZBbUd2d2lLS2xRRUZWT0U4?=
 =?utf-8?B?VjFiRGxiL3pmcWNaN0xoTC9ZQ2pweDBRVUVuQ0ExRlJGVkRqeWh1S2h4NER6?=
 =?utf-8?B?SXorZ2dtcm5aMVNtRjBCUi9XTGxaQ1YxcEV1UW56QmI3TmQrVk5iVkIrYzhL?=
 =?utf-8?B?TG9DTmQ3OGQ1M1A4Sm1YQWFXVXlyVFhhVjNkTmNHclNrWStRd0tLeXpvcFBD?=
 =?utf-8?B?QzJMVkhtYzJHQ2NIZC95R3V6Ri8zTGg2VGl4Vmc2Nnh4Tm1ULzVOempsMWNl?=
 =?utf-8?B?ZUV5L2xrOCsyanFvcStqUkNTK05PTUFnMWVkR0dVZk83Qm16TGV3dlpwbG1M?=
 =?utf-8?B?UENoNkpBUW1NdXZRWXlwcWlSbldaVDhIYkFPeWRZVytKU3FWUTNHRUtYcmFl?=
 =?utf-8?B?ekFIVUh4OENVei9RY2FMUFc5ejdVdlhGWjRybWdCNG43VTNYMFllMHFyb1Nz?=
 =?utf-8?B?eGJlY0JlU3JrdGwxS1ZNamZLOFdNTHJLeHV3ZEJ2N1lqOGtqcGtuMWl4VndU?=
 =?utf-8?B?UzJYMEZCQUo4UFhFakxIQUcvYnZ1eUoxMzdtbkpFdEtMTy9mOWpKSDg2TzBW?=
 =?utf-8?B?TFZ0MUlBVmRzVXYxeGRHUlJrckhzQjJ2NWNlNEVTd1g1MEt4SndHSmFaazda?=
 =?utf-8?B?NTM3TmlpZjJ5VkdTYWRqTUVxbnVKL3ZCWnFPbzdaOE50cU96ck81VkRZQWo1?=
 =?utf-8?B?MnFDVDNIUzFqWm9sNlZ4dEl0bE9UdFVHY293aUU3SktZRVJYaFJRYVdIQlNr?=
 =?utf-8?B?WmNzOHJGMGQrMUJOMzhQWlF4eUVFM1JzcEExREYvTXZwLzZXWDg2YTMrUUEw?=
 =?utf-8?B?UEx4RFNxbFFLb3d3aThyRVNPTHR2Yk0vK21PdWMvcklHOUMyY1AxdldVdlZD?=
 =?utf-8?B?bTBMNnVvVDlhaG9vRDk0THg5RHNuMURGYW5EMHU3M2JEZG45Yk1nVVVMRFoy?=
 =?utf-8?B?QUNIR3d4NmtITXFBbFo0OERjbWN6NENRZitGQVQ1WVhpS2dtSWNHVHBobzFQ?=
 =?utf-8?B?RHFZYlZoZWJ3N0Y1WjZIME5zd1B5ZmhtanBLdExiVWR6YU5WY2krdHMrMTkx?=
 =?utf-8?B?K3owZzdod3o0MlptSzZ3dHBYSGtVVzNybzZhc2tNM0publVKTTRGQUh5YU5V?=
 =?utf-8?B?UklTKy9lQTdEbzRYVFgwVzZmSGdrb2xXVzRWbngvNGlJRmdKUTd0NFd1Tm56?=
 =?utf-8?B?WkNjT0tWL1I3dzY0VkRxTGw2c3FQMjdOWmhYU21qZUxxUlFvbkc1cHVwamZR?=
 =?utf-8?B?K3lHNFpCMS9ZY0p4bUo5c2Erb0xTaXQwT2NiUWhvVmF5bEZQMjV4cSthOUdR?=
 =?utf-8?B?ZzFmendwdGFJaTRUVk51aEJ5QzVFVmtvWjJHM3pLa3NGRnpJY1g2N2lycUJQ?=
 =?utf-8?B?R3dGSFRnUlJnaVQ2b1lESDRPWVFtL2Irbzk4RjBCVndTRFRRekhMVm56c3FC?=
 =?utf-8?B?c3ZnVjl3OGp6ckt0VnMyQnR3NXpLYklkalF2NHBQM0tvb1NHMTA1TnJGZ0E2?=
 =?utf-8?B?STIxL0xaZzdybFhFR0tFTTJHZGtNVHhJMmVmTWJtVEZoZWJ2bmx3L2ZEdEJ3?=
 =?utf-8?B?WGxtbHEzL0c4N3lWU09tTUhqRTBma2xWcEZLRW1jMDhiQUllMTVQVmllWE5i?=
 =?utf-8?B?UG9Tak1PYk5qK0FpSGNNb1NHSDQ1a054aFl2ZEVCeWcrZDVDeXFVT05pc1hW?=
 =?utf-8?B?eFROTGtyNDhRSHRzTldKZHliRXhGeHpqZ1lXQXNwY2s3UWJ3V2Zud3RkUmY3?=
 =?utf-8?B?RldxQVh6ZnJKSHhyVGRUQmxsaTNnN0pVbUhsL080MFdnSHFvRnM0VXZaaUhq?=
 =?utf-8?B?eU5wbnZpdzZpRytnV0s4VlhtT0NpQmtiSEEvMm8rTWJ2bk5QNytZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74747d26-8ace-4128-c936-08dee625b52b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:11:16.2395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ParkWNDXM6jl8pboItdbnzLs/zjM7NH12+VyTVDTPfh9uuNdZi61m2k7uYErL9wp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

Hi Tim,

actually not sure why this was off the list. Let me add it.


On 7/2/26 13:26, Michal Simek wrote:
> 
> 
> On 7/2/26 10:57, Tim Ouyang wrote:
>> On Mon, Jun 29, 2026 at 11:00:40AM +0200, Michal Simek wrote:
>>> On 5/11/26 10:31, Michal Simek wrote:
>>>> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
>>>> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
>>>> CONFIG_CPU is not enabled. This allows platforms to save code space in
>>>> SPL by disabling CONFIG_SPL_CPU.
>>>>
>>>> Without this patch, building U-Boot with CONFIG_CPU=n and CONFIG_EVENT=y
>>>> is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F event
>>>> spy, and when the CPU uclass is unavailable uclass_find_first_device()
>>>> returns no device, so the function returns -ENODEV. That in turn makes
>>>> event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
>>>> ("initcall initf_dm() failed"). Returning 0 early avoids that failure.
>>>>
>>>> The compiler's dead-code elimination combined with --gc-sections
>>>> removes the unreachable code and all associated static data,
>>>> achieving significant size reduction without preprocessor guards:
>>>>
>>>>     spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>>>>     spl/u-boot-spl:text -1460
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> Reviewed-by: Yao Zi <me@ziyao.cc>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - extend commit message
>>>>
>>>>    arch/riscv/cpu/cpu.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
>>>> index bbadd0c9a469..3bec7c7cb6d0 100644
>>>> --- a/arch/riscv/cpu/cpu.c
>>>> +++ b/arch/riscv/cpu/cpu.c
>>>> @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
>>>>        const char *isa, **exts;
>>>>        struct udevice *dev;
>>>>
>>>> +     if (!CONFIG_IS_ENABLED(CPU))
>>>> +             return 0;
>>>> +
>>>>        uclass_find_first_device(UCLASS_CPU, &dev);
>>>>        if (!dev) {
>>>>                debug("unable to find the RISC-V cpu device\n");
>>>
>>> Can you please take it directly to next branch?
>>>
>>> Thanks,
>>> Michal
>>
>> Hi Michal,
>>
>> The new RISC-V maintainer here. It seems your patch does not fix the
>> issue. I tested it with the following steps:
>> - mkdir -p $OUTPUT/test
>> - make qemu-riscv64_spl_defconfig O=$OUTPUT/test CROSS_COMPILE=riscv64-linux-
>> - make menuconfig O=$OUTPUT/test CROSS_COMPILE=riscv64-linux-
>>    Disable CONFIG_CPU manually
>> - make O=$OUTPUT/test CROSS_COMPILE=riscv64-linux-
>>
>> The build fails with:
>> riscv64-linux-ld: common/board_f.o: in function `initcall_run_f':
>> /work/u-boot-riscv/common/board_f.c:921:(.text.board_init_f+0x166): undefined 
>> reference to `print_cpuinfo'
>> riscv64-linux-ld: drivers/timer/riscv_aclint_timer.o: in function 
>> `riscv_aclint_timer_probe':
>> /work/u-boot-riscv/drivers/timer/riscv_aclint_timer.c:77: 
>> (.text.riscv_aclint_timer_probe+0x24): undefined reference to 
>> `timer_timebase_fallback'
>> make[1]: *** [/work/u-boot-riscv/Makefile:2112: u-boot] Error 1
>>
>> Please correct me if I missed something.
> 
> It is not valid configuration because dependencies are not properly described in 
> Kconfig.
> drivers/timer/riscv_aclint_timer.c
> calls timer_timebase_fallback() which is defined in drivers/timer/timer-uclass.c
> as
>   90 #if CONFIG_IS_ENABLED(CPU)
>   91 int timer_timebase_fallback(struct udevice *dev)
>   92 {
> 
> It means for this risc-v configuration in Kconfig when aclint_timer is selected 
> it has to depends on CONFIG_CPU/CONFIG_SPL_CPU or should select it by default.
> 
> Microblaze-V is not using this timer that's why no problem to disable it.
> 
> 
> And the second issue around print_cpuinfo. When you disable CPU likely you need 
> to also disable CONFIG_DISPLAY_CPUINFO. CONFIG_CPU is uclass but if you grep it 
> I wouldn't be surprised that there are still platform which are able to print 
> information about cpu without enabling cpu uclass. That's why there is not 
> dependency between CONFIG_DISPLAY_CPUINFO and CONFIG_CPU.

Any reaction?

Thanks,
Michal
