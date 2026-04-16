Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5EF433C7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 03:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5CA8407E;
	Thu, 16 Apr 2026 05:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LcnTnXIL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2DEA84105; Thu, 16 Apr 2026 05:57:46 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A78EF83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8PAndpKx2bfEf53B+kaVIZCjEnL8R1hE6LvmU0Y1echmKAJ9uvj4qqKKi7HIvpsbir3PvLFke9fDuPvdQd0vqz8Zo5SZaoj+w4dMej/Ll2EfMG6hHw8MNnfgCbhBtH/YUhn31d4pTbA6GryXk+bCPenhfEJh9Xigo+x4PUYbQhJyL5TLi9b8FK9OUNIs9+5SrABHhz7Oa+KIpkgpvWqFZaguZ3woB491yzYKgAJG1Cd435pSVob6vijK12pUZ6SP5owYMDPRtzjB8WzFE5lJGTpe6u9au1Z9osQ0BSzao9mIFkQW1t+2yn5Wm5OeCcJGiXsamDfNVcKi4Yii5utpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stnj+6cOivsNALTm05e8W51hte6M+CsjanC1NEURErA=;
 b=WA3fbfQQwtt5kJ9jDg+NbvV4oVgjEBbrmmBWQtEOlEpaBtxC5/bvAT2GW3GRABSh7y+Oa4D0PemeQa7d71QXxt4jinz4gpfWxyhhD/ieOgEoScKqXpjaTC0NMdJQAiu4P89dafIeHp7IRrjX1J5tDCX8TTE6ls4bLFw2Po0DDUkZxFYtj/UmAtyH+W3vADm7ywuLd/FIaEDbclLqSc+67ZQS4828gOaRb6hiHhLny/3SwmZ0JJ6fl8W9CrS68U0XHfv+EKr45tfiSB6muDwIwFcehdlyitaCjOfyrBa6KFHAaNxV1bqBpVU0DrHk4aQ8mLhM/SY/0S4uFgKhrnJzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnj+6cOivsNALTm05e8W51hte6M+CsjanC1NEURErA=;
 b=LcnTnXILzQLX4+GklVBU22dL5PKjGDWfAcwE3MbAuxsnWGO5tyr4d9IIogn5oTMY9mlklbfUj8PIOLBgSt7DDhtwxPFpr1bHggzhVpXa6Cs7omVLrn1ZeJPOcmuO/tkduMzqkZ2HPLaK7bT0RmY209aDJsVlSKV8lB5frnMJWA/vepoOlFj7+38yrv7Sll/puQfFlf7VLRuqTL6tZwkW9AQsXbzKeosR0CJOUyPlJNzixqfhcYFIWQR95LBnWOEEbRCS06MQ271AD/Dqm6+HCH2G4JbfyKRFjMaHjH0K3xowLw6KSV1kzL35MDj9y9Vd2zugwlhaQtzCfxTgYSg7Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MW5PR03MB7007.namprd03.prod.outlook.com (2603:10b6:303:1aa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.49; Thu, 16 Apr
 2026 03:57:39 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 03:57:39 +0000
Message-ID: <ed9641fb-f9fd-4e05-802d-544aa38e8341@altera.com>
Date: Thu, 16 Apr 2026 11:57:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: socfpga: Use custom header target buffer in SPL
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
 <20260304033029.10825-2-dinesh.maniyam@altera.com>
 <a7327c7c-e4a1-4bdc-a817-6fabc92f1191@altera.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <a7327c7c-e4a1-4bdc-a817-6fabc92f1191@altera.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MW5PR03MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dfcfe4-5bfc-4f70-bcc7-08de9b6c4cc4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|8096899003|55112099003;
X-Microsoft-Antispam-Message-Info: lEXsOOYenFKTGdfIB5BaLn1hpcnEPwx6jCguIff7lRwC9ZJkLk1coQ0t8KBmK1wdOPQVAQmBdJEgfVyUxUvkUZM8qJzDlMU4i/Ym+g5UO9TVIhFMIEovx5UH0eLnbdZwjHp+CQDUatRXOaMtM2Jmbp7wI6XuJQZ/Q1szhQnsWNpZtSI0KCb/YaYRTbyhc4zTuJOvPObqPDMK2eb/4prf7KUhBwLDiP0ysVVMrE0ODiyReKVBzRMkArF4dsuEDYAY7rj6DJ5zQ6oeQpI1Crxrx0uNlMFcL2BORKH0CdWj7u/4CZGl3qvJQZyGeQ1XB69qFg22AXcZ04lqf5D6QybUr/xC6JbrOk3TqU+uDo7DXMgbkNchHq/9z/wqgdxMGcflbngmavZTRwWbdbA/Giu4Z8osCxJz/KK1z1F9XEyV+KH6fThjW9xAqGvGUCwmhTLrhkkIHlqP6u9wTb9sRl9kDlQFql1cCLqaEhIakts+mmeYxZ9rxNEbrL9risS43bY5dGJy8WJkObbvTyJjOU9PClGoXI+O2MuWGYGQq8r6qxsPSXRTXNpCw36uzAgCuvG2Kk21Cfcac3F56eoQVCbXPEuV7Bm5iJOpEKNUrNk1amokfrDFqVgQaw7fy8LTOZry0BmOIpyE3C5zryKQ0ZQrN4bosKXGQrfaeUG5cmzDiLWeJIRD2RptFq6/YASxRirxL7mjLwYP5Wu6EDT1Yc6TGZxv+hqWeVOctPqX+RuUBWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(8096899003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dlSnJXaUllQWZ2QnV2RHlOTUlTTlNLTzRIUHM1OEdTYXJ3L0JGcnhUWFIz?=
 =?utf-8?B?VEtXeGs1VWRob3dJOHpWaHRoNFdKR3BUeGd3Y29YQzBiRFNVVWV0N0JPWFdC?=
 =?utf-8?B?WEpZTTl1emhKeUU1bmQ5aEdUSDZJZmZYckVOL2t5d21rNVlQeWw3RWVJanY5?=
 =?utf-8?B?WGVvSkdoYTUxbmxwZFFISmhGYm42QlRKV2tSdVF0KzhrRE9EUWR0TVREZmpq?=
 =?utf-8?B?YU5FWnhaRUNCdi9XSHNRbDBTamNqazMwRHhybzJLT2VVczc4VXZaSDV4RmFT?=
 =?utf-8?B?NjI1K2ltV2JtYzFDcTZoN1ozV1JDUVU4RzRseUJXcmhFeUpZRU5IMHRHRmEr?=
 =?utf-8?B?Q2FZdkRkOEN6TzlxcG45VGpVb2FKYXlkeFlXWUFJbldVdGRtbyt2QUlvenh3?=
 =?utf-8?B?WjZFaFY2WnBIdUl1a3ZUVjZ4Qm9McDMzYzdoSGZnWFU3d3NNbVROZFpKWCtH?=
 =?utf-8?B?WTNRSlZoMUlYYTZNOTRZOVgzYkVaUGhrWHkzSzYxK1lwVjVaMlRacUZZVHBR?=
 =?utf-8?B?VXM2dEdjNW5iVXgyekRWdmZ3Z0k1c0pZOTgvcjlUQndoQjFkM01xdkdsT2Y4?=
 =?utf-8?B?UU9tT0puSUxkUHAvcjVnUTF2QXBIL1hYZ2puZjdRbWNsKy9US0tTTzByMFh4?=
 =?utf-8?B?aXpLclp3WG1TK3hzWEVWaEZKUWU0MDZFZ1ZzTzc5akxSK2tqS00zTXRoOTlI?=
 =?utf-8?B?YmI2WHpmN3k2MnpjWFN6R2FnODA5WGdxVVdta0JRbzZ4dkk1cG01QTNVNGxi?=
 =?utf-8?B?cDlwVnA0RUszbGxNMFVoUnNmWkkxTU1uUHZROS9LeUxGUjdTMTdEdkEyTWdC?=
 =?utf-8?B?K256RzNLcnR6RlB4dW5sNmdFOStjalBLWHdvdDV6dWtrVnlCeVJVeWhWODQ0?=
 =?utf-8?B?SjdlaXlIVnNNWUNaMlJjcm9rYzYyQ1ljUVdMZnpiS3RJeStWc1pNVDNzUFhk?=
 =?utf-8?B?c3dBZjlUT2ZIVjg3NElQVUJnQjBwblltcEdNYkFPSjlab3lkSEQ0QTYxbm5K?=
 =?utf-8?B?dUdwM0hoWEZUbGEwRExodWtKcmJQektNQmM5eG4rZWRmMWJoN1JaL3NBbUk4?=
 =?utf-8?B?c3VyVUhlQ1pRVTZrYmxpOUVBYyt1MlB3MEJJd0VGWmdwQzZXdGV6UEs2aUs4?=
 =?utf-8?B?TkJrUy9DN2V4U0ZJejhJSmtKRDg4VFZaYVR1bEV0QnYwNEdDaS80TUFucEww?=
 =?utf-8?B?N0xUalZUMkpOcUFoOHI1bkJXK0QzOEIyOU5DRitjNFJUaGswQ01kbncweE5R?=
 =?utf-8?B?MWRGZnVWTFc0K2ExdmFRMEphaDNDdGVxbE1Fc3k2UXVuVEIrZ0Nhbi9GcHdP?=
 =?utf-8?B?QVdwb3VuMHFVbDI3NXNDL1V6WGhqVTVhTVFXRDMvYTR2ZmpzbHgrWFBSZzU4?=
 =?utf-8?B?ZWhhWG1OU3dKMWZTYjduVWQvcDYySE42YWxhd2ludXNEV3Bod1loTFRKK1Ru?=
 =?utf-8?B?ZmpmUHlJVjhIN2M5UGl0dG9IdjFaZjQvY1lGa2xJQkdkZUN0OTlqaUhJcDBI?=
 =?utf-8?B?WlB6djVSaE9paVZUY3l4aHFxTTNsc3pWNkZLWTZlQmw4OGN2UVYwaWwrT1ky?=
 =?utf-8?B?eVlvOVlhM1VBTllzMDRaTElqaE8zT3hudDJxMVJSeHZkY0tOTHp0YjZjMzFU?=
 =?utf-8?B?QjdkWCtLd1JwYmV0N0ZhZXBLOU1EcWpOc29Hc05kQ3B1VnUxcVNVOFM0Z1cr?=
 =?utf-8?B?SnVOdWJMQ0wxZWVmdXd5SzN3a0ZCV0NSRDR3ZEZoSEtHMGxsc3pIMWN6RDdi?=
 =?utf-8?B?czFKOExiUnFsbWFqNVg3TExIdndVNHBJNURBQ0p3MXRFS1pSVUdSMUY4R2Ez?=
 =?utf-8?B?dGtNOVFFQjRkRWhoMzdhNlJLOXFpQ1BJU1g5K1Q2UnBqZFhGNDhVU09RVVRO?=
 =?utf-8?B?WXhaYnAyY2NuNHFoSDhsNHZXUHpVSzFiU09JaHJWTnRRT1M5dzZ4bHY2T0R6?=
 =?utf-8?B?SVRLczloYTM3TzkyV0hld0NvZ3Ryem9lMjg5eU5wdjh4WW5HTTA5THdrWnJj?=
 =?utf-8?B?TWQ0VGFuaEZPOFowR2U4dm1vT0FDT0dyNmZWdFllcitmbnpMZ3R1cCswS1Ex?=
 =?utf-8?B?dGpEVGtNVHBTbEFyVTFBMTVSZW9NSklLZTNuelN5WmNRYmJsbzNxcmFSWVE3?=
 =?utf-8?B?amRjSjVIbGN2U1laZUVhQzF6SUZ6enprb2lKQzYrUGFkWVNZYjNjd3JDMDBH?=
 =?utf-8?B?MzB4SWJyRGI4cis1QzkzRDBCVUkraWkwMC81TXJodHBCdVBJc012TERjSytV?=
 =?utf-8?B?bVAzU2RhNGRBdEhqQVg1OG1BZmRFdHg0L2pZSnQ0NFgzWkRMZ0M2VnAxb21O?=
 =?utf-8?B?eTB2L2MvOElja2RMZ29zVXJxaC9IN1luMHpOUU5oQVNXMmppd2VsWGI5Qitu?=
 =?utf-8?Q?SUzcIALXqC0nwTdo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dfcfe4-5bfc-4f70-bcc7-08de9b6c4cc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:57:38.6862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi5iLAXfS1BFcFwaia2ycRwTEFmuiEiaz8PH/rdqZC/I9rpLXiNwBRClci34WlNatf0E1iHRu1eiOjYtEEvZeoYsk+/isZ33Zm5Hnff3X14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB7007
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi TF,

On 15/4/2026 11:55 am, Chee, Tien Fong wrote:
> Hi Dinesh,
>
> On 4/3/2026 11:30 am, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> Allocate buffer from bottom half of DDR for the image headers in SPL on
>> Arria10. This allows SPL to load the fitImage header, parse it,
>> extract the FPGA core bitstream section from it, and program the FPGA.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/spl_a10.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_a10.c 
>> b/arch/arm/mach-socfpga/spl_a10.c
>> index c20376f7f8e..c3fd90de8c5 100644
>> --- a/arch/arm/mach-socfpga/spl_a10.c
>> +++ b/arch/arm/mach-socfpga/spl_a10.c
>> @@ -27,6 +27,8 @@
>>   #include <watchdog.h>
>>   #include <asm/arch/pinmux.h>
>>   #include <asm/arch/fpga_manager.h>
>> +#include <exports.h>
>> +#include <log.h>
>>   #include <mmc.h>
>>   #include <memalign.h>
>>   #include <linux/delay.h>
>> @@ -284,3 +286,13 @@ void spl_board_prepare_for_boot(void)
>>       writel(FSBL_IMAGE_IS_VALID, socfpga_get_sysmgr_addr() +
>>              SYSMGR_A10_ROMCODE_INITSWSTATE);
>>   }
>> +
>> +#if CONFIG_IS_ENABLED(SPL_LOAD_FIT) && CONFIG_IS_ENABLED(SPL_SPI_LOAD)
>> +struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
>> +{
>> +    if (gd->ram_size)
>> +        return (struct legacy_img_hdr *)(gd->ram_size / 2);
>
>
> The function currently returns gd->ram_size is a size, not a DRAM base 
> address,
>
> so ram_size/2 is not a valid pointer unless DRAM happens to start at 
> 0.  Even if A10 SDRAM is currently at 0x0,
>
> please use gd->ram_base (or CONFIG_SYS_SDRAM_BASE) instead of assuming 
> base=0.
>
> That makes the code robust if the memory map changes or if this logic 
> is reused elsewhere
>
> This can lead to SPL writing headers to an invalid/unmapped address or 
> corrupting memory.
>
> Please compute the buffer address using RAM base(if valid) + offset, 
> and also honor the offset argument and bound-check against the 
> reserved region.
>
> Since you want a scalable solution across DDR sizes, you can 
> dynamically reserve the upper half of DRAM for header parsing:
>
>     /* Be defensive */
>     if (offset < 0)
>         return NULL;
>
>     /* Need DRAM initialized and sized */
>     if (!gd->ram_size)
>         return NULL;
>
> hdr_base = gd->ram_base + gd->ram_size / 2
> hdr_size = gd->ram_size / 2
> require (size_t)offset + size <= hdr_size
> and return hdr_base + offset (aligned - ALIGN(addr, 64);).
>
> Also please drop unused includes (exports.h, log.h) if they’re not 
> needed after the respin.
>
> Best regards,
>
> Tien Fong
>
Agreed — thanks for catching this. I’ll fix the |gd->ram_size| misuse, 
derive the buffer from
|gd->ram_base|, honor |offset|, add bounds/DRAM checks, reserve the 
upper half of DRAM,
and drop unused includes.

Will send v2.

Regards,
Dinesh


