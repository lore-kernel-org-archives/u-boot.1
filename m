Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77748CD5BD2
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF046846AA;
	Mon, 25 May 2026 15:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMADi2zv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB96846BD; Mon, 25 May 2026 15:10:26 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7E68460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFhgOf6FEoSGWxSnwvWS+YMImmyAkTbUj5yZ6MtN4Cc26MqSGh55DSyGfgdreQi6MVahdPDzG+cHHx2IQTnGJIBPVfusRwZl1Eu9bQ+SwCHYCjyITu3iDpI2q2++E/l1v0oT/EBI/dEUm0y+C/BmKBBt8fRf+QxmQwwmpm7Y2RfdUgApxBRYZLCnOD3+xs7EAZ7zhPWfO3zJLvGoNuhGe/fb5K7sGgiUYg71Jz6kamK8pkC/5tXhD8w9os0XvG4WEEulIDL5ThKnStcS51a+pPnCEnv5N+nwP5hO+TAF4UHwtWHW6kBsilEEZVsSr8vpeT2OGpPUwVp8WDNAlJ2pcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXmZbU/g0VAhpki2ElU23lsy4gAITHmhOt97a8myG8Q=;
 b=RAwyxijAiPIxfeLBpbitP3bxfdMDuuW6CFzKbR6Jo1WFpmVBUlScfo0lLI+Yun9AJNSzjItznxugtNfhMHgIQEkJ4ek8xzLrMy0JugkiFF0xXYUQ7lTO9ZxkrCm1VBG0IkW9Cfhf3t3YAAg2d4n4WXmoLFtL5fwBtHMnxjLk5EWwyLV8iQUf+F/C0btSwRJQg2Z81z3nVp/Z0uMKK+uNz/yjDd9Nk4nHHRq6J2q8aloKEbrpJ1q6M/r+zVEnpIhCgwUhWD98AF3IaXzKdaM46+B7tpxBKl13QUxY9sF7StUh/XbrZ1pOwo1Z2ZZ5r2sAy9bN9Kij6ogFyTYmCQrDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXmZbU/g0VAhpki2ElU23lsy4gAITHmhOt97a8myG8Q=;
 b=iMADi2zvTIKUk7AoJnOiKgHrRqn7Gti0qK5nufb4N1MNGg19gKdEMWlpfYZUgsoa/LPn6NGjkQ9PC7820DMkhN0ca1qk3YFsydxos0mPU+YWCJ3LWyVW//56YjXOKxG0NgAKV7cUnLZD+oUkm3ETAbGyEIP2utl0htg94z1nRQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:10:17 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:10:17 +0000
Message-ID: <b5f0efc3-094c-460d-829d-d838580928b1@amd.com>
Date: Mon, 25 May 2026 15:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add capsule and FWU support for Versal and Versal Gen
 2
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20260514102601.1759779-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260514102601.1759779-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::23) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e197968-c8cb-4a5d-9fb6-08deba5ef72b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: TLsgGWTLZ+fUZfJUEpr1IMQPJr25NCMzQp7i6nIfit5n87QJ97Uuv9DC+cjxeeh+yQUa9GWn9xM/aSx0w3E6/sfYmI8jHl16GEPF6C6SV5vIML+low89cvquGQOag/BN/gfmDuIPv8Lgz0wIrxXnp0IhS5Gqd/sMwJYNv3FlgAmpuGSR5Fnf56Xv8MRCxPcocdHQJzN+d0EjRJWRqLnq6f47QciqpbZApbc/P79WYTpb7EWiV7QoQ3JuUEF4URGayYM/E018ZlcA109OsDIgILxzkJLCYyo/+rmwNHfhr7CZO0xFUHDj+00ydQeIGh+WXaQGHow9OndrSNO4gWhRYW4OMhcM2M7GvF6xQu5dHfNSDwGoyIY7fGmidp0UWQ7D720gUKXM8drTZL7uXUMW6krDvRT/DZAoruGUSVEJKAVwbYjZXHF0hPvMNQ5Ozs/YaEvjvcRKSB99Tl+nzrZF9/8NZgKeivKbC+A9lWVB+bmZ9ycdgvopEqQDAA24FP4hfYFmMZf7aPLg5qKFBk2Lin/1PE9epBQsbSd9G3QK0oU8UI5/jJEbO0lKnkYRffis8Dhh4mecemp7GBb5lGSy49tGLYgHPaxJnLEROVi9zk0sIa+WkNqNtOzcsQPc0O7OVNEb1jNlzOOe5GrK73EaxpUWwUmSvoOTu1o7sa8vnxC/JV3mkzrlK5ReCNd4Pz90
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFd6VDN5NG9rc0FEdDdVRmNQNTZucmExSWY0ZkVDMmJsQjZFK3p1cUlTYlAr?=
 =?utf-8?B?TzVUcHdHMytGMmo2MTdxclZUYlA3R1kxMU1VTlBpQmU3c0NEb0U2RFFSS25L?=
 =?utf-8?B?SVo0aTA1blZiTU9mMk9QVWVQdnE0eUk2bmh1MnVKaFRHeXkwT21VY0ZzbnhL?=
 =?utf-8?B?N1BTMTBoNERjRTNNc0k0S3pKaDEzMWphcE9jSXZ2Z2RTYkJ6bUJCUkJ0Rmhz?=
 =?utf-8?B?R2VNcWFRbkNRdGg3WU15cUowNWZPTTFuaTVrUGJ1a0pQQ0lPQzBXM1RWRUky?=
 =?utf-8?B?alZObWIrWVp1bUpPN0ZjVGJZWEtuVUtzbnA5aUNnOGwvVElLNCtXVXlRRTkv?=
 =?utf-8?B?ZXA3K1dObTVYNm80NDRLaWpweEQzVDZyWHRNL0FpT0xrUDJST2thMnduRW4v?=
 =?utf-8?B?Q2E5Zm1mMm5TOHpuNERyUWplSC9FaWYwK0hjL1VXaEZqb0E2S1FHUlEvWEp1?=
 =?utf-8?B?aHpPSjZQUzZnZE1KbEZ3QUZXTmFQeWV5LzNzT21ud25LS1ZpQjJmSnRobGF2?=
 =?utf-8?B?L0xtMnIzMFptZUpCdUV3SVdRVm9oL2lmaWtUdGUwVUYyYVh2Q0YvdWpGY3NM?=
 =?utf-8?B?RlBXaWtielp6OStMZStIQ24xNk5mQXN3a2V1SklkZ3dCMlJhcWFxR2VvaGJn?=
 =?utf-8?B?dVBmcEhwQUp1SDZXRjZZMjZvbUc1Z3M4Q2NidktBcDBqZ3BHWDhmZDlmZytM?=
 =?utf-8?B?enNyNDJnNDRjdUI5cDJRajlpcy9waVd3VFVMVE9obGVMbHhCOTVxdGhiZGV2?=
 =?utf-8?B?Yy9CdjUrTFpaU1pZeTNUYXROSjJLbzdpY3lLVUZKMkwvTXB4WG0yaFgweVlp?=
 =?utf-8?B?N3h6c0daUk4yMnhiVGdqTWdqNzlYa3VraGlvMVF5c3RBNjRYUXJKWGRGcGtr?=
 =?utf-8?B?N25NZVYzdWJYVmdtb2F2R3RuV2hJeVVCR2lIUmVFZk52TEYrWDRrT0VEcDhz?=
 =?utf-8?B?T3pvUU40Z3h1S0pxV2xybjRwdWFqdW01L05ISlNwVHN1K1h4MGxZME1CR2U1?=
 =?utf-8?B?cGpPekNnT3M5dFhQQmgycUJaMXpRSHAwSEtsM284b2lhTDdQblA1ZVVrRlVW?=
 =?utf-8?B?dmZnOE5maVBmSDhPYzdkU0pScE1UcTRuM1p0Si9hWGtxdlh4NWE1MjI1d3Zi?=
 =?utf-8?B?TTdsekhhRkUrcHhmZEZwRG5HNVpJM01vcm5SbXRZa00vTFMzM2RuVSt5VkJs?=
 =?utf-8?B?SDd6M2JQOWZrU3NjM3R0K2wyOUhweXBuM1dGMmdvZ1ZMM3NFVWtzMkw1UmNJ?=
 =?utf-8?B?VTBCazluVld1RVQ4RlNJc1ZCbWZTWEs0WjlFWTMrNG5GZFZ6THMyOHczbDh6?=
 =?utf-8?B?T3lVT0tBanlTWUJkU0w4K2Q2ajdYQnFpMTF4NmtJV1ZYWmtacDlPV2RkeUZa?=
 =?utf-8?B?aUQrQU1yOExsU2VPaitOWFRUTkc0OXBsOUtSR1VZa21rNkFBdTlhMDU1T3lP?=
 =?utf-8?B?akp5UkZLd0h6Yll0dE1pQUFramJCLzhSU3pacEtRM1ZhOG1hZUxYUWhsNFcx?=
 =?utf-8?B?WmU0T3gzY3dYeFAxcGRmSENiNlpma0Z0ZWZlZHF3Mm91eVQ2WTBKK3M1bk8v?=
 =?utf-8?B?Um1kYWNKZ21qRmN4NHIvVURqb0c2bGRzajdiY1BnN3pBazRONzF4YnNPYVhm?=
 =?utf-8?B?eEI1V29EUnQ5Wld2MWdRQ2lZeDU2NU1KRUtiTzJVcGF3akFZRWZMNkZOTVU3?=
 =?utf-8?B?eENtOENrWlAwelp3R3VIZHdMQiszWDZsd0tUTEJMVmt6VHJ1d2lGRjg5UUtI?=
 =?utf-8?B?SE9RT0x6SWZpeGFPR0tiWDNOWFRBNklxaGlEZE5YZmpqalhBbkp0N3RhNkNX?=
 =?utf-8?B?aXdkV0RUTnRWTTF0eHF6enVHcjVuanNiM3VaTE1MTGFKbHVHcGFZVEdCYkF1?=
 =?utf-8?B?S0FIYThXL1dQV2RScSs0YU1xSW1ZZWF0enBLOTB2MW51YTlzTTZIb0FKZm1k?=
 =?utf-8?B?YThrazdyZDZLdmtsNThLa2JXVDZ6Q1RKTzJsbnA0WXE2YXQyQVUzYnhHWktB?=
 =?utf-8?B?bU9NNFhoR3BWSENMWGxOcW12ZGRna1Q3UFFlOEN3NkVEOWVoc2RrTFJZdUNx?=
 =?utf-8?B?RUo4S2VENzdsY1JlMS9PcnBvMXVMQmpORUIzN0dUZ3Zlbk9XaU9iRmZVckYw?=
 =?utf-8?B?QklQc3ZOaWFIdlAyRFFhN05FRUg0SWxpMWIxM2NNZnJiN1BxYWQ3TzdOQjJz?=
 =?utf-8?B?Vm9xUFNqV3ZaRGw5KzVuc3ZHVkhuM0x3Smp2WWEyM2dIYWRRNGJLZ1U5RGty?=
 =?utf-8?B?S3RhQ0gxMUZLbFJHMFZKVjUvZGNyeW5RUlhubmphTit1Q2J1UzJ0MktPNnBx?=
 =?utf-8?B?elUzcDF4Qmk0VGdBT1ZHempNRDI0ekhZcCt4anp1N3o0M1FuOTM4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e197968-c8cb-4a5d-9fb6-08deba5ef72b
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:10:17.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdnt976HMcfMjQpgI8vSsIONAahPECMPxlsDssqEWVuYZs6Y49f4UpBIb3N7+f+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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



On 5/14/26 12:22, Padmarao Begari wrote:
> This patch series adds EFI capsule update and FWU (Firmware Update)
> multi-bank update support for AMD Xilinx Versal and Versal Gen 2
> platforms.
> 
> Padmarao Begari (7):
>    arm64: xilinx: Add PMC PGGS3 and PGGS4 registers
>    firmware: zynqmp: Add PMC PGGS register read API
>    board: xilinx: Add capsule and FWU support
>    board: amd: Add capsule and FWU support
>    board: xilinx: Add FWU boot index support
>    configs: xilinx: Enable DFU MTD support
>    configs: amd: Enable capsule update and DFU support
> 
>   arch/arm/mach-versal/include/mach/hardware.h  |   3 +
>   arch/arm/mach-versal2/include/mach/hardware.h |   3 +
>   board/amd/versal2/board.c                     | 131 +++++++++++++++++-
>   board/xilinx/common/board.c                   |  73 ++++++++++
>   board/xilinx/versal/board.c                   |  42 +++++-
>   configs/amd_versal2_virt_defconfig            |  15 +-
>   configs/xilinx_versal_virt_defconfig          |   2 +
>   drivers/firmware/firmware-zynqmp.c            |  54 +++++++-
>   include/configs/amd_versal2.h                 |   5 +
>   include/zynqmp_firmware.h                     |   4 +
>   10 files changed, 327 insertions(+), 5 deletions(-)
> 

Applied.
M
