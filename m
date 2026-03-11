Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4781125852
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 16:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F9583FA4;
	Wed, 11 Mar 2026 17:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fUQzNTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C928413A; Wed, 11 Mar 2026 17:27:12 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE6E8352B
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV3Ih60t4yZNkMAF3XJNt3WvEZdl2znWrRGjbl4aEwp+DKesxaZZRyhPEwcSvjxd0q5/FDBFTXC9yWC/M2sQh9b7V34FJsaKwOHJ/eOLQdDZ8nE26lfjAymgC4l60Y/iBZBAY3XIzaB1mYXkOP9He60QPA5OboJswsyRjxto4ekvo281IH8g+phKREB073kt7ELVt/02lbinnvSZvV9hl/vElawAeNlboTUp9o2XY02ym3PPeU/hchanw1EMYsG7vovJXbPwc7vcBbjOWqFXxF/wZV1fQ3ASerGIoGSSgdGALxU81UVr7ft3sB2hmY91MgagZn5Y/DBNDM+HrJnfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjlIYQiC5TV0MnaB3cKBjkXNi7p3lim9s4P4ozcGBVg=;
 b=UksJ1Ko2dE8HFS9phvhkmC8fzd05TOjuG6R8cHHu2eLb7kdraz1kemI54a2PzdJxNdCwrDNwz+PLnT9lV8abJ7fz3qp6NsICbj+LD9Mh7r/jZoOzDwqPOERUpmpY3HdZJZLvWZIg1Nn51V3RiVwuXzvw8MjwapVK1TxX1zR/Dj4zPnI93qr2Spv2N7GmigGBDhXrjvFMkXvjWSSHuOrS191BI3jHYV1Gq8gLMisa2kapScADvalxxC8vxIUXmXvouPYpJLpnYe98bT20nYak723a1OARiZD6k/jGnhnjJmNVUCrz1pR5rMOegbI90KJFGyf3Ymsgd403ngGt8N3gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjlIYQiC5TV0MnaB3cKBjkXNi7p3lim9s4P4ozcGBVg=;
 b=5fUQzNTU3jF3Vg4MHdtFFGCHzGvgDYYu24CLZd+zrt5efLJ2jzkvAQjP/9aV/T+KvIppLAMWVhD5AVKJEHjARbt6m25MBeQbGTcGSvKhBknMsdTHU3XasUHidesOHoMIhhZCntcxPDuulAz0nRSrg6lux/yIhBvCEZ+L0JbfGko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 16:27:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 16:27:03 +0000
Message-ID: <856a0d4d-4c5f-4028-ac0d-de279bd07c78@amd.com>
Date: Wed, 11 Mar 2026 17:26:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] efi_vars: Implement SPI Flash store
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Shantur Rathore <i@shantur.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, git@amd.com,
 u-boot@lists.denx.de
References: <f49e4ac8da5bae9252c79031f1661f386d17895f.1771247847.git.michal.simek@amd.com>
 <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <82aa8024-e80f-4db8-b0be-c8558c953c1b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0180.eurprd09.prod.outlook.com
 (2603:10a6:800:120::34) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 005009ea-8afe-4fef-32a6-08de7f8b073a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: XP2QGi54E7zF+zwm1jgKaymY9oBPNMupMytwq0BBCntm0H9koGvF/LXjaf5eeFILc8ahj8QfaYzHGPVhFYlY4/IoyKZxw2NK6aNvRFdwO0HLJwXQxnHs2FISgqDEniHBS2V51QpYdTAbBZiuVDZlDM7hIdLIs6Y1IznIohpA8MT6L0SYjrKga9osth4W000FV3o+Jngk0JRnRA+966IIiz4CPEmPcncLHi2tjS6Y7wfq/gNoJ6VOWZhEGyJ7vOJFoLEM6oWFHYZJ2SlKNvV7OrsDH1iEVqJVXvg3rh4LMPNg/uIRTJM0mtDmr5w4RN381SD5G03uC12f50U1681uP08c/oH28QSAh5RLzPAu5vjTYJXVSnt//OE1iFvdpj540zC4AJwWujkyru0DpKBbbV7THcnfQSetCTrerT+iBXgbz2pUqAujjcBmSVpuW28y/GdyR5OWtEa8oEyRJAD6xOn9RqodoQOFDdURottf2Vd+uyKE33kyWYPb3/hnpGHnOmt42jYHFYH2elxlzOuEoX2mpXstB3pgsnqKzE1NBF5XQ32nl392Eke3OgAvUc9ozMpRgrxWYXdp04HamcMfTvHiY2ueamha/Adoqb6N6WM+w1RwId7RRJEy65npJQyiMU725T5w6mu894tIGfkneCQJ5Bbh7Xli/YyFa3K4QSuK0s+nG5F6erW5L8Jc2Z/irAUtrEKC6hJGu71TXm/7+gj7BPqXxOTG4QNLtqNSsO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRPbmFBQ3hrby9Zc25OajE0OG0zQ0pOenpDVGhYaStidzdyeWZBdzVTNkhM?=
 =?utf-8?B?dFJqY21PbEdTTUl2cElISGRVNU05ekkzRllvS2lZVmYwL1Z1TzBURXN4Zlp5?=
 =?utf-8?B?dVAyVW5aOGJ0MzNTTXpXdElNTlY3VUtjZ2tmcm5hK0pvajN2UTR6MGtJSHBY?=
 =?utf-8?B?eGZwMWdaQ1JFeVkxSXpOcUJHVStVRVFOWlltTDhkRTkwajRJOE5WaCtOS1dZ?=
 =?utf-8?B?R3M2WVozMUtrM3VmQ0RQZU9UMFUxYkx4NWRSMCt0Z255dndNU3RobTVBVVdM?=
 =?utf-8?B?WTlJczR0a3pKRmlMRzdXUE0rZmZ5TUo0cGtLbjhhdmZkQUtaajNiREpaSkxS?=
 =?utf-8?B?N2tkc2ppOElvclI5bzlBeW1HZ2hmbCtBcTZuQ2toeS9Gak1pWDlQWGFJRWpG?=
 =?utf-8?B?ZDJWRGN1Q1dWaVlRNHhNRFVCckdWbXUySFBKbmZsaXF2RytpdlU5VGprWGZJ?=
 =?utf-8?B?cXhyUzN4V1RFT0k4MGFpekt0UnY4RTVYUVBoSlB3VHZyYXcwZjNVRkVRMU1a?=
 =?utf-8?B?bHA0aHhrTzlROXVzUmd2MnRJbUJqQzFCbTNKd3Q5aXJLbHJKT0N3emgzTTRF?=
 =?utf-8?B?WGJwRFd1MTdteFVoN1MzMzRUWkdDcUtrL2lXNnZWY01JQ25nbUs0ZnNhVmhB?=
 =?utf-8?B?TDQvaVp0WmU2ME90dTYxWGV5bzBteUZtRmVyMzFhME5xM0JHbXZXb3lveU9z?=
 =?utf-8?B?Z09vd2NpUitmR3V4ZFp6dFczOFU5cEI5cGo4Y2hiMEh5NVpKVFJoazZPbFhN?=
 =?utf-8?B?T1prV29sckltVEV0ek0wVFVKQ1lHaHIyTm4xWHhuVGtidUMrSjVVMHltZlJJ?=
 =?utf-8?B?OHg5YTQ0MXk3OXFBYmJrUDZqbytFeE1pbnpnK0pXYU9QZ2t1ZjhxQTZzbDh5?=
 =?utf-8?B?c25XZ3VnQkVPWkV3bFIrTmRuMm5ab0l4aFQyTDFxUUtURCtmZnFVb2pBYnRF?=
 =?utf-8?B?WXJ3blNvZEtiS3lBdnRGVnZlZ05wR09ETzVUdzRoV0ZWSUNob29YTk9CSUhY?=
 =?utf-8?B?V1lsK3hRaWM4UHVFTWtLZ1FCLzJDU2poSzEzanJvVTl4cG11T3BvbERXbUxC?=
 =?utf-8?B?WUVQc0JkYWtFMFM1ZkM1bk5mVlpzRkhMamNYOWRUTmVZQXgrU1BpWkxRcENa?=
 =?utf-8?B?cTBOQWhKVm1saVQrSlcyUk1KaFI0TEdSVmNBQ2crdlYrd29FZ0pCMjdibFFu?=
 =?utf-8?B?N0N2NThtMTh1TFJTWExKYU1uZDdoN25LYTlHVGE1dlV5Mk05RGVBc1R1dVYx?=
 =?utf-8?B?c1ZpMEdtdm5vYWs2c1JZZWEwZGljZHlOdXU3OERFVTFkYVpTdk9jcFJuOGU5?=
 =?utf-8?B?bkc2SDkvTm5qM3ZUR25OYSszY0xXcjBBUTU4cnRCYWhLM3hWYWdYMXcybnpI?=
 =?utf-8?B?TklzbzFock93RCtkSUxtM0RVRTY1RElIb0FYNDFLUFlvOGJXSlUrdkhTbTBa?=
 =?utf-8?B?VVk2UVlpUnErcmxiem4zV0d2S2syaXZpdXd1ZHd4YXAzWFpZUlRmdFpHanpn?=
 =?utf-8?B?cG43ZlRhR0Z2Vkovc0FndmJXakxSR3J6bnlhMGx6YmNqS0gzckI4ZnZFRlVU?=
 =?utf-8?B?YmhtaWhXWTlpaWVSR0RFKzNOR1E3azE3QVFzTS85ZkdjNkovTnhlaDBvK3JV?=
 =?utf-8?B?UEFXRXZibUxMc1NaZER5YzVWbENsOHhpMFhWVXVVWkl0SjNMemt4TzZtcnEy?=
 =?utf-8?B?dVpUTlp1eElydXpneWtic21wMkh6TWZIUkZBOWxUalJyWDVNWThVdHNtSncr?=
 =?utf-8?B?ZDVIVFRwSHpBR3A0bWlUM0QyUG5wNFJRMEoyREIzSHJ6QVZjODdHWGR4cXFk?=
 =?utf-8?B?NXUzbm1WYnJUU3lyaTlqWnhPSnlySWZIOGI5bkJTY01CS0ZJeUdySjZIZTFo?=
 =?utf-8?B?d29QRGU1bFhVT3NVWDlKUEJXT2RPU0k5cS9LQ2N6dCtMaGdGTWg1aVJGUHdp?=
 =?utf-8?B?SkZTLytleEZDQVFjb2RlTTkzTmVLM1ZLZ3F5K1hLNWFGZENsazVCZzdEUTRK?=
 =?utf-8?B?cDdqUjRWOVBHblZRSkF6cXN5UERRZVkvS1MrSnJGNzNHVHhUQnlUOGVacXB4?=
 =?utf-8?B?c0srcWlodEEyanRXRW5rd3VXM0MzYjROczVHd1pnRjgzYXg5dk9CUnM5UHVR?=
 =?utf-8?B?WmFVZWJsZjE3ZUhmNmdWWGF6aE11MDRNVTAvbXVuTUVkNHZaaTB1SHZQWXc2?=
 =?utf-8?B?NCtqVGc2Ym85ZHh2U1E1bDR6TjArYlVMK2FpYURZNFp1MmhQeFZtOXBZNEFy?=
 =?utf-8?B?c3ZPSEZnaTZveFJFamt6T1RsRFFOMmJXd2VxS3lqT2lqY0pxenJScmNrWUFy?=
 =?utf-8?B?Zng5cGxrMW5HMllSUXdFRk1CYkw4eWtzLzBjTVd0WGdzM2U5eW1Ddz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005009ea-8afe-4fef-32a6-08de7f8b073a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:27:03.2880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/2wKF56mVQtcU4Dee9j0yB4VSjsSDVIVNLH3jqRbrPQmMdl1YzoDf2zcCUyjTuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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



On 3/11/26 16:08, Heinrich Schuchardt wrote:
> On 2/16/26 14:17, Michal Simek wrote:
>> From: Shantur Rathore <i@shantur.com>
>>
>> Currently U-Boot uses ESP as storage for EFI variables.
>> Devices with SPI Flash are used for storing environment with this
>> commit we allow EFI variables to be stored on SPI Flash.
>>
>> Signed-off-by: Shantur Rathore <i@shantur.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> ---
>>
>> Changes in v9:
>> - Remove EFI_RT_VOLATILE_STORE enabling
>> - Cleanup commit message
>>
>> Changes in v8:
>> - Add missing EFI_VARIABLE_SF_STORE dependency to EFI_VARIABLE_SF_DEVICE_INDEX
>>
>> Changes in v7:
>> - sed -i 's/efi_var_from/efi_var_from_storage/g'
>>
>> Changes in v6:
>> - sed -i 's/efi_var_read/efi_var_from/g'
>> - sed -i 's/efi_var_write/efi_var_to_storage/g'
>>
>> Changes in v4:
>> - Extend Kconfig description
>> - Extend commit message and describe efivar missing part
>> - use unify methods for reading/writing variable
>>
>> Changes in v3:
>> - Fixed compiler warnings.
>>
>> Changes in v2:
>> - Refactored efi_var_file to move common parts out as requested
>> - Changed ifdefs to use CONFIG_IS_DEFINED
>> - Fixed typos
>>
>>   lib/efi_loader/Kconfig      | 33 +++++++++++++
>>   lib/efi_loader/Makefile     |  1 +
>>   lib/efi_loader/efi_var_sf.c | 92 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>   create mode 100644 lib/efi_loader/efi_var_sf.c
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 579eed658801..315dd4f3e794 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -124,6 +124,24 @@ config EFI_VARIABLE_FILE_STORE
>>         Select this option if you want non-volatile UEFI variables to be
>>         stored as file /ubootefi.var on the EFI system partition.
>> +config EFI_VARIABLE_SF_STORE
>> +    bool "Store non-volatile UEFI variables in SPI Flash"
>> +    depends on SPI_FLASH
>> +    help
>> +      Select this option if you want non-volatile UEFI variables to be
>> +      stored in SPI Flash.
>> +
>> +      Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
>> +      the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
>> +      needed.
>> +
>> +      Note that SPI Flash devices have a limited number of program/erase
>> +      cycles. Frequent updates to UEFI variables may cause excessive wear
>> +      and can permanently damage the flash device, particularly on SPI NAND
>> +      or low-end SPI NOR parts without wear leveling. This option should be
>> +      used with care on such systems, and is not recommended for platforms
>> +      where UEFI variables are updated frequently.
>> +
>>   config EFI_MM_COMM_TEE
>>       bool "UEFI variables storage service via the trusted world"
>>       depends on OPTEE
>> @@ -194,6 +212,21 @@ config FFA_SHARED_MM_BUF_ADDR
>>         the MM SP in secure world.
>>         It is assumed that the MM SP knows the address of the shared MM 
>> communication buffer.
>> +config EFI_VARIABLE_SF_OFFSET
>> +    hex "EFI variables in SPI flash offset"
>> +    depends on EFI_VARIABLE_SF_STORE
>> +    help
>> +      Offset from the start of the SPI Flash where EFI variables will be stored.
>> +      This should be aligned to the sector size of SPI Flash.
>> +
>> +config EFI_VARIABLE_SF_DEVICE_INDEX
>> +    int "Device Index for target SPI Flash"
>> +    depends on EFI_VARIABLE_SF_STORE
>> +    default 0
>> +    help
>> +      The index of SPI Flash device used for storing EFI variables. This 
>> would be
>> +      needed if there are more than 1 SPI Flash devices available to use.
>> +
>>   config EFI_VARIABLES_PRESEED
>>       bool "Initial values for UEFI variables"
>>       depends on !COMPILE_TEST
>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>> index ca1775eb03be..d73ad43951b1 100644
>> --- a/lib/efi_loader/Makefile
>> +++ b/lib/efi_loader/Makefile
>> @@ -54,6 +54,7 @@ obj-y += efi_variable_tee.o
>>   else
>>   obj-y += efi_variable.o
>>   obj-$(CONFIG_EFI_VARIABLE_FILE_STORE) += efi_var_file.o
>> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
>>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>>   endif
>>   obj-y += efi_watchdog.o
>> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
>> new file mode 100644
>> index 000000000000..61d68f7c5c94
>> --- /dev/null
>> +++ b/lib/efi_loader/efi_var_sf.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * SPI Flash interface for UEFI variables
>> + *
>> + * Copyright (c) 2023, Shantur Rathore
>> + * Copyright (C) 2026, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#define LOG_CATEGORY LOGC_EFI
>> +
>> +#include <efi_loader.h>
>> +#include <efi_variable.h>
>> +#include <spi_flash.h>
>> +#include <dm.h>
>> +
>> +efi_status_t efi_var_to_storage(void)
>> +{
>> +    efi_status_t ret;
>> +    struct efi_var_file *buf;
>> +    loff_t len;
>> +    struct udevice *sfdev;
>> +
>> +    ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
>> +    if (len > EFI_VAR_BUF_SIZE) {
>> +        log_err("EFI var buffer length more than target SPI Flash size");
>> +        ret = EFI_OUT_OF_RESOURCES;
>> +        goto error;
>> +    }
>> +
>> +    log_debug("%s - Got buffer to write buf->len : %d\n", __func__, buf- 
>> >length);
> 
> Hello Michal,
> 
> Thank you for driving this.
> 
> The log system is configurable to print file, line, function name if wanted. We 
> should not duplicate this here. Please, remove __func__ throughout the patch.
> 
>> +
>> +    if (ret != EFI_SUCCESS)
>> +        goto error;
>> +
>> +    ret = uclass_get_device(UCLASS_SPI_FLASH, 
>> CONFIG_EFI_VARIABLE_SF_DEVICE_INDEX, &sfdev);
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, 
>> EFI_VAR_BUF_SIZE);
>> +    log_debug("%s - Erased SPI Flash offset %x\n", __func__, 
>> CONFIG_EFI_VARIABLE_SF_OFFSET);
> 
> A debug output if erasing failed would be more interesting.
> 
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
>> +    log_debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> 
> The uclass_get_device() return code should be saved in an int variable to avoid 
> confusion.
> 
>> +
>> +    if (ret)
> 
> This is not an EFI return code. EFI_DEVICE_ERROR should be used.
> 
>> +        goto error;
>> +
>> +    ret = EFI_SUCCESS;
>> +error:
>> +    if (ret)
>> +        log_err("Failed to persist EFI variables in SF\n");
>> +    free(buf);
>> +    return ret;
>> +}
>> +
>> +efi_status_t efi_var_from_storage(void)
>> +{
>> +    struct efi_var_file *buf;
>> +    efi_status_t ret;
>> +    struct udevice *sfdev;
>> +
>> +    buf = calloc(1, EFI_VAR_BUF_SIZE);
>> +    if (!buf) {
>> +        log_err("%s - Unable to allocate buffer\n", __func__);
> 
> This function may be called from an EFI GUI application. We should not output 
> any strings to the console from API functions. It is task of the caller to take 
> appropriate actions. E.g. show a pop-up if a failure occurs. log_debug() is ok.
> 
>> +        return EFI_OUT_OF_RESOURCES;
>> +    }
>> +
>> +    ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> 
> efi_var_restore() returns a signed int and not an unsigned efi_status_t. Please, 
> define a separate variable.
> 
>> +    if (ret)
> 
> Please, return EFI_DEVICE_ERROR.
> 
>> +        goto error;
>> +
>> +    ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
>> +                EFI_VAR_BUF_SIZE, buf);
>> +
>> +    log_debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
> 
> If spi_flash_read_dm() failed, you will just print some random value for buf- 
>  >length. Please, print the return value instead.
> 
>> +
>> +    if (ret || buf->length < sizeof(struct efi_var_file)) {
>> +        log_err("%s - buffer read from SPI Flash isn't valid\n", __func__);
> 
> If spi_flash_read_dm() fails we should return EFI_DEVICE_ERROR.
> 
>> +        goto error;
> 
> After erasing the SPI flash buf->length will be zero here. This should not stop 
> us from setting EFI variables.
> 
> It is the task of efi_var_restore to check the validity of the buffer. So the 
> length check here should be removed.
> 
> The missing check in efi_var_restore() is
> 
> buf->length <= EFI_VAR_BUF_SIZE
> 
> to avoid a buffer overrun when calculating the CRC32.

I am not sure I understand this part.
Where exactly should be this check?

Thanks,
Michal
