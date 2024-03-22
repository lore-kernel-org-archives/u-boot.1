Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C6C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C0088028;
	Fri, 22 Mar 2024 12:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h43QZqc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6B0881BE; Fri, 22 Mar 2024 12:53:24 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C27387B77
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9o3lKsksOw4UbIokAOM2cpnVReuFoiw0vtUS/Dli1Z2/YabnOf3ynwy6uKfp0aGsSIQc5MmC76tjeoJtV3tL1EJHVfEIdu3G8wJZAETt6ZAJCZDg3fHq7D6SEcXe2Y09CDimcw2jNo1GTfRxldigRNgDv8vqW4c2wHYotOPj4M1nEFpqGw9U/kmdS1LgN5LMQAYpsaO9SKMSAZyoAXC5MKKMLfH12xg4SJqorL5jFZKZ50GGbyiwYehxgQNMzh6adc02C6D+6JeHq6cy6SnmkEDMFNyF68buUaNfnMCWPgW0OqgilA04lSC4oQOIzB5UVKXhicgQ+MIqs3AE9H0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lKd1qxzCmCelbkz+mzMWcReUxbrVApYMuHF+ylPRm8=;
 b=H5BpoIMsdWIvj0TzJ0aycv+cZbI1f6XfgqsNC//oZtYBq5Y9irkHWWj7iCaM6alCXAd55jeR/0LAMlUzhigc8OqcTvsVxmmwF2iYdRSajad9Ju1MU9GUoRgJK5idBCpo79RntRJx2rRw1kh3x8ivgUw18FRnZ2q9Y/Or0vVeW4MiqvA8irYBDB3jJKOSMc6/QlPN6ciB4iq8H0O4utK9Y1oF8XQG/I5+V+sgtupx9TEok923ZmTJBi/l/CiazxPzeGLmT9nI/IRzRXAQnt1rbgESe2fqpqkGdIsd8DSS5ORqPCdLMDhjUxP4s0Bjv+Nopuc+Fq3GdhRD/1r15ZvQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lKd1qxzCmCelbkz+mzMWcReUxbrVApYMuHF+ylPRm8=;
 b=h43QZqc2CEnThEAgebxdjoLdXTyO50q2IPcZDIozrxLbcsN6GwtBWqr2B+SxF5oA9/CZtL7SEaIAmXDftjzB/97/MF9udsp3zIvxlzuRpKKUi/zm78J6UZ/7dNp1h2wZO6OL3LUmXvjyYYb4QxOUPBKNGjf/bQDzzd9V8Eet6m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:53:20 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f%7]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 11:53:19 +0000
Message-ID: <a727ac9f-3602-4b55-82f4-5e5696c92070@amd.com>
Date: Fri, 22 Mar 2024 12:53:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Also support JTAG as alternative boot mode
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de,
 git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <ed51a9d51948ab939a53e0b9dc6c2d2546f97a4f.1710933505.git.michal.simek@amd.com>
 <dcc310e3-fa22-4459-a0ab-b44176c4bd2e@linux.dev>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <dcc310e3-fa22-4459-a0ab-b44176c4bd2e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ec8334-ff92-42b4-4966-08dc4a66ab0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOrbn3+kwap6kaBUgpD0uFg746xlMaLg9OSSg0L/EpwxAKzsvKo3MPQV72DwS1JF88hZAjHmciNY7Cg+gVTCq75vfHIYooJCwP+FhN/pVHxAwwnhG7jfUAJaotqMlly/PQ4excsXzEUQu/IkEPUZ368B5d7HXRA0cDcBMXRig9R7oMG/45OLyLJ4YqDmlF/T9M1kkR70mFazeWLa4NUAcQW9Y18XmumlhncTohQS/r7DmA22E8G358/pfvIZyqz2y1qE/61i42aYqyUS6eLWTgKUw/aFWkllX/fC8D/YeWYxmA0I6EPFpDA/75r6mSYAkCg7BeuzkgMxeirItXkli35Wwzslu6A1Rg2FwJkTlvqshdLyr148gbfsvukdNWnhebAGn4HRN0khCbUtKDLXLnPJOZc9dWGTx7fgAuyflrdNbHDcrVpKfPGR75K5+qzT6/rKrz5Dx+aNOohaOXvB3uybkS6PeTkkejTLq5uAxSGrcNU9X/p+c8NwoqhFAq1M12Tu8iJ5dtPgp7Bi8bKWR1fjMEkASLTAl7kIVXQOhIEOKEqAY1RRCFGkrM0VQ9BJpS+Nv2eNPOzyokj8S8T1mixohuHMzx1ObqurtEHwZZILlBS+tjAPSScodTL/n0wxGs1z2/VXZIE93qAeSWpXapC4gFCuSM5GFSLuZpYqOo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVxalNHbzB4TFQwSkxjc0VxcnFmVzJRdFlUYTNEME1uZDlrVi9HKy9nWmxR?=
 =?utf-8?B?N3FiVStHOW1JbnBFdGcrRDhqTG5KVW9GSUpxb2ZSQmUwOWh1c2htamdtMFRP?=
 =?utf-8?B?bkhvOS9BNC9Mc2FiaFV2SjNWSm1jSVpmYlJEWTB2QzlKaGNnb2c0VUJXSnND?=
 =?utf-8?B?TnFmSjRSTzdKakJCTmU0cmdPWDNrMUZiQ3FSd2p6ODlSL0puS3ZKMWcyUTJs?=
 =?utf-8?B?WjZvQlFGUGJXZXhTTlk5YlB0c01FK0lmQ0hqbVMrOHlqUjNVNlM0Z1ExSTdF?=
 =?utf-8?B?SmZHVnRzZDJXcjFEeEFRWFNhaTQrM0JDbGx1N3hQdVd5Z2NnZ3JIQjkzRGJy?=
 =?utf-8?B?bU1VVmk5VWVacVM5NWs0a2gwakVac1hRMGZOSFRDcVZFUzVOVjVCcjhhbTM4?=
 =?utf-8?B?Y0U4c1NNUTlQbWtEdGkrbFJGVzY4dTN2eGdZdS9hdndnOXlqdnA2OXQxWExN?=
 =?utf-8?B?M1VTbUtaVE9yMyt1b1c4U3BjMkVnRjdoRERIMkY2S3l0M1hZQjJPcW1rQUp5?=
 =?utf-8?B?Y0JsQkttVTl5dXVveEV1TEl0UjRaWHZ4YmRmZmFIbFpGTS9GbUVoMnA5ZkNx?=
 =?utf-8?B?QS9SSmlrS3pldEl0dVFqTmMvand5d1hkTnhxLzN4bjlQUlBqLzZhOU9WYlcw?=
 =?utf-8?B?UzlkWEQ5ZzBabWFkMllQVExtRm5WcnlQbHB3bnZsZ0N0SnJHaU41WW5SNnpl?=
 =?utf-8?B?d3cyalZEZVZCT1g4ZU4zUFk0R0dTSE5IbURzbjRYUU9RZXJBQ0kwQXg0czdV?=
 =?utf-8?B?SVI2VDBQaExFR29ud09UVnZ1VXEvSm8rTzdOdWs1RDRWUVd3SFF6VVdEQUxV?=
 =?utf-8?B?ODNQL01RRlhGZTFRSXF6bDdOVkg5RzRGZjQ1NXppdkhkQmkzcTBFZk5GRzhL?=
 =?utf-8?B?RXNFRERTdmZSd0VGVGJZZVpoNVFiN3liKy9PZ2dsekJ0V0pXUG9BVWJlWjFM?=
 =?utf-8?B?Zkd1OTI0SjdWbmI4OUpqZ3d5RllnK2ZvendNWGF2TjJvYXhXNUJ1SFRQL1Nk?=
 =?utf-8?B?RlNlaXAvaFgwVmYvM3c4L1BOMndZUVBDZkJpaUdzYTJKdzJuOG5sRm9vbzg3?=
 =?utf-8?B?NVJ3M1Z6TWxZMmkvRElzQ2kveERzaGhxVXhiOXYzbktseDF6a1MwQ0lUQ0dH?=
 =?utf-8?B?dUR2cDFJbU1GS2xjRkk0N0pQNnF1dlRqZmNEVnFzUmxGU2lJU3JKcGllVEdJ?=
 =?utf-8?B?Q3JXVng4Rm1DVEZVV3dCZlQvSlRBRHBrd09QZGdtM3pQYlRhY2hDM2xpVzc0?=
 =?utf-8?B?VUZRbW9Ec0QyY242OWxmS0ZUMlQyREpZSGtVN1FUL2ZjMDg2K0hYdUdYRlpJ?=
 =?utf-8?B?T25Oa3Bzc3Bya1J0eHVwMmtiYWFoNk5mdis1dGUvNHRVUG45S0FrTkJyL3ZT?=
 =?utf-8?B?NjdxMXNkMDhoS2RVZWMwdU1LZDBOeFlPR1A5OTV6bXRVR0xDVzYvbFZ5OVFZ?=
 =?utf-8?B?UVJ4ME55VGQvS2xJUXRUbVNnL3M4aUZBZ3NkTkxzZTVrR2laM0FRVmdwcHN4?=
 =?utf-8?B?UlFmeEcrYVdTZlNwZHVXUjZrMW1SeFU0Q3RIamZRdXAzVU04R1hhbDJhTjhm?=
 =?utf-8?B?KzF4c3ExcHJ3TG8wUUMxb2o1TS9xZVVRREcreGpUeTZJZXBxRjBoS3NVQ3FZ?=
 =?utf-8?B?QnVGWExBUWxrK1J4c29iYy9VbXY0UjRIV2daRHhyVEpTaEZ2R29xNTA0RjB3?=
 =?utf-8?B?MDVCczc2a2lUUG5vNjNxZ2lHdENrRzZiOHBXQzdIVnZSNmJjQU9kQUkzTFpz?=
 =?utf-8?B?NEg0eW9waEl3bUJJV0d5SktGMVM3NmZ0dWpxeHU3Y05XRzF2VmJiMWNZcGVV?=
 =?utf-8?B?TmVKNjVmSHgxeUNDakI4Tk9mUzQ5WXdxVmdjVm1UV3UxNGNCVE45WStFMnlu?=
 =?utf-8?B?NzM1Nk5XSjFjdkl5ZXRsbEIvUmhOc0pHRFRUN2Y1ZkJ1c3kyd0tnMHRLT0Fj?=
 =?utf-8?B?T2d0dUpwbWdGQ3g2NkljeVlIbFdCQkk5RDJqcFRrcUpMVDE5Y0VJV0VTSHlO?=
 =?utf-8?B?MXlYczB1b1dHakg5c0pyY2hSVmdWUzJyeHFEZWV4alI1VHZ6dGxlVkU2V1Rh?=
 =?utf-8?B?SnlwdnFvZ1VvbHFpRnpuMm5VYXNuSWsyTDM5YUNUWHRBZUZ3ZnY0T3R6NkZD?=
 =?utf-8?Q?8qWaMW/NuTgkivwYZYz4BzZc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ec8334-ff92-42b4-4966-08dc4a66ab0d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:53:19.9176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1DfqPqM5ersnOjkzjy5Jz5ZPs8WUbT0YvX0SgBJpEPaYsZAN6+1GhtCO9Krmhyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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



On 3/21/24 17:20, Sean Anderson wrote:
> On 3/20/24 07:18, Michal Simek wrote:
>> if (reg >> BOOT_MODE_ALT_SHIFT) condition rules out alternative jtag boot
>> mode which is 0. When 0 was used origin(HW) boot mode was used instead.
>> That's why directly fill reg variable with requested boot mode and don't
>> let code to read value back. "else" part of code remain unchanged.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm/mach-zynqmp/spl.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
>> index 5af735aa5cef..979ff3aef6c2 100644
>> --- a/arch/arm/mach-zynqmp/spl.c
>> +++ b/arch/arm/mach-zynqmp/spl.c
>> @@ -91,13 +91,14 @@ u32 spl_boot_device(void)
>>   
>>   #if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
>>   	/* Change default boot mode at run-time */
>> +	reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
>>   	writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
>>   	       &crlapb_base->boot_mode);
>> -#endif
>> -
>> +#else
>>   	reg = readl(&crlapb_base->boot_mode);
>>   	if (reg >> BOOT_MODE_ALT_SHIFT)
>>   		reg >>= BOOT_MODE_ALT_SHIFT;
>> +#endif
>>   
>>   	bootmode = reg & BOOT_MODES_MASK;
>>   
> 
> Looks fine; can we change this to
> 
> if (IS_ENABLED(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)) {
> 	...
> } else {
> 	...
> }

Issue is that CONFIG_SPL_ZYNQMP_ALT_BOOTMODE symbol is not defined and depends 
on CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED. It means you get compilation error.
That symbol can be setup and then what you have above can work.
Is it worth? TBH I don't have preference. Please take a look at patch below.
(And if v1 is fine then at least there should be added depends on 
SPL_ZYNQMP_ALT_BOOTMODE_ENABLED to SPL_ZYNQMP_ALT_BOOTMODE which is missing 
there now).

Thanks,
Michal

diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
index eee34380f0a0..75d3ec916a66 100644
--- a/arch/arm/mach-zynqmp/Kconfig
+++ b/arch/arm/mach-zynqmp/Kconfig
@@ -145,7 +145,7 @@ config ZYNQ_SDHCI_MAX_FREQ

  config SPL_ZYNQMP_ALT_BOOTMODE
         hex
-       default 0x0 if JTAG_MODE
+       default 0x0
         default 0x1 if QSPI_MODE_24BIT
         default 0x2 if QSPI_MODE_32BIT
         default 0x3 if SD_MODE
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index 979ff3aef6c2..bbbf684ae496 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -89,16 +89,16 @@ u32 spl_boot_device(void)
         u32 reg = 0;
         u8 bootmode;

-#if defined(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)
-       /* Change default boot mode at run-time */
-       reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
-       writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
-              &crlapb_base->boot_mode);
-#else
-       reg = readl(&crlapb_base->boot_mode);
-       if (reg >> BOOT_MODE_ALT_SHIFT)
-               reg >>= BOOT_MODE_ALT_SHIFT;
-#endif
+       if (IS_ENABLED(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE_ENABLED)) {
+               /* Change default boot mode at run-time */
+               reg = CONFIG_SPL_ZYNQMP_ALT_BOOTMODE;
+               writel(CONFIG_SPL_ZYNQMP_ALT_BOOTMODE << BOOT_MODE_ALT_SHIFT,
+                      &crlapb_base->boot_mode);
+       } else {
+               reg = readl(&crlapb_base->boot_mode);
+               if (reg >> BOOT_MODE_ALT_SHIFT)
+                       reg >>= BOOT_MODE_ALT_SHIFT;
+       }

         bootmode = reg & BOOT_MODES_MASK;



