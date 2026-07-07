Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14601C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96887849A4;
	Tue,  7 Jul 2026 12:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WA0N4em0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E13849F6; Tue,  7 Jul 2026 12:59:12 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F50D849BA
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lva1HQdCWifVY4iH1z6hVFcTCvDVe6SGt292MYrQHJWoM+8w9QaZoRx2ftPsz9phS9A4FDpLDtrDd5yH0Ismy6F74p2iusiUcSJbgfCAPgI3voIkTD2lpiJUzPglhPy23NNFNIwYVBzF5/HBx3w2kWI/3C0vgxUEGPlFLE//xV5MNpjPL0xG9DsLNt9ConPU3PGwwkw4aQ2yYG5l/1Vr/PwgJhUcb3S0LjRbUjKGo4BqhlSWb2uLqXeWS/KqoST+bWbiS2NqpJluy8R0vYYRyogYGndpCJ64QaDrjna6J/AFu/uK6yEGXdu4lkj1ryLEZwgzHqnEN9UrjxBwAzT/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE5BqTol+FyPjHu+p8IdmxmarZsRkF+b6uwiLwGmQSo=;
 b=aoXtAe6yX+jjERep2XpS92Z4bkpz+KrLc0vh5d/JZLlVH/X/1XXatgqzkqTnhu/xMsl2dRINLlEuH41OH56dUPZNMknREdWooSKBt2PP99nct/sTGwQ6xJdYNAQbPOOrksPuF9uQmbW3yJaH+51/NzaCjjbvF9r3JC+QIpbtrWJVzEfAVZrxyirmp+nbsl3ZMz/wQ8qXBfVypQjgUh0qUyH0txHCsXYwKl6xQHO2iN2P3ws7KhXJTglst/KNlfRd0SiyGRJTxfUAiAvV7eN56sOeOBIwsTlAKPjmwJnpEVHn97tN3tIXZnuZy+8ctR9gJPZ6c0IgfxPa3fcYnCW/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE5BqTol+FyPjHu+p8IdmxmarZsRkF+b6uwiLwGmQSo=;
 b=WA0N4em0761O1txd71AP+uO2M62DgCbKy8NqXszvIHPfAOEJz6OGsowvOKJv3yD40zVMlaBPAGwogLqTp9weyq01oKH9rcLBMGgPMcm1BCx5Sdq28K3yFj9WeArSO/CPmXNPF3ie6aYsE/2a6a9k3mkQB7rgdVhqjy3rdUx6G/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:59:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:59:05 +0000
Message-ID: <78e86de8-f953-4cf5-913e-3a09b3fb5dd2@amd.com>
Date: Tue, 7 Jul 2026 12:58:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] arm64: xilinx: Decouple firmware interface
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Francois Berder <fberder@outlook.fr>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Neal Frager <neal.frager@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 238d86bb-7bbf-4dfa-320b-08dedc16c341
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|18002099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6Y7YXHS8DC+c/Ts+wFNscrYxpf00DGmA8bZqFfmIu5RTPEkHZK/9lFc30daMhZf0b3z+4RxtDfTaP5HUG3wOR2IPapSx8gdQB+65UOwPm8dNgxAVZlKPWjG+pff3Q8BpiFuFe+6D3/VNWEmkOC+QKW03aE35vMHn/vLqTYI22Qca61WDnLTAn95CGS+uAePu+eZLgRjwNKoE8ZpCVAStgPB7FVshmsm55yhvVHvXPjrlx1paKdMwXvGewrqrh0J9pzjpapGrVZzoqTxog8RdSco+aScWvD4wt0lgU9oBYiXRaJkWPh819V6SkWNjJ5oNQiBzODem9KvdSNPbJQx7gXoHENEbpqgmcLqMifJoQqfK4Y9g3ISpVwMBhY9KzSd3uwzfsOGvf/D2EplgARJd+8ZWJzsRXnA/VPpo4Eh1Nb8+7yrdquBWtomXfrRd5r00hVBfwEw3oWLUKFK0lxU1I2Hw6sZUKVP7JRkheMJZwtT//RXDNqgrZgVqx7hDfppGFtyUQdZjUZVqjoJ/lj5NGnrbZNQfjFwFrI/M0+i8enwfKzAL930JV1IWnsbeZEoELky4AGR05thK4Cn4ACGXBwTl29v2kE6m0/L4RAu0GXG3V+soWqDAHOLWtxX+/9NL+a5rgpd4yKrCAd/k4FBjZG/iwD1CWA2rZgACjb5rF5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBjR1FlVVdmR1lhclovUkZDa1o2RE4wU3NpRzNLb3RxZmlweWl5aU52d2Ew?=
 =?utf-8?B?cUJ6UEFPWUF3cmlFMVBoNlNRMlVJWWcyYzY5SFFBVXJBVHZtUi9vOHBOdnB5?=
 =?utf-8?B?T1o3cVRJS0tDQjNRSFZramE4WUNSeWpVbU51dHRIVUxOZk9qc2Y5UlVXUXJp?=
 =?utf-8?B?YnJENzlqSTBkUzJzZnBoOEU0QXdIN2VYR1gxVmNyVUlwc2VhbjhQUWVhbG54?=
 =?utf-8?B?MzVBVGdGVTlEN2hwUVhmSFNrWEtnUUJNSC9XM1k5RXhtVWxwZGg5ckExRXRr?=
 =?utf-8?B?U25BbldwQmpnZm82M2greUNJSnRzaFRwMTNpK25pQWczSGZ0SXprNW5uUnFk?=
 =?utf-8?B?MHZIWWpCN2t0ejZpaWVKT0JGL1RSWTFwTy9RSGt5cndIejRacUZlSFovV2xK?=
 =?utf-8?B?bEswQTkvVTV3bEpHSWlaS0Z3OVVQOWl2VzVWSUMwbEQ1U2VSWWJ5eGxpWDFn?=
 =?utf-8?B?YUdGelVNWDZXdDRtUnl0QzJvdW96eDBuMXdCaEhOTzU5OExKVmV6cFlWaEhU?=
 =?utf-8?B?R1VBZXluNG9YdEwxQ2RtbzZjK24yQzFDM3FBNE03TjZ0Y3E4ZG9mblhwWkta?=
 =?utf-8?B?eGpOa0JVUWdGWDFsUmdaWGx2R2xwd01YRHcxVlRyQzltQjc2SmY1bjNEb2Rt?=
 =?utf-8?B?Nm9aenFiSnpEVU1tVmcwTDRKSGdPMndDai93OUZNYzRRV1hiS2laTkRNSi9o?=
 =?utf-8?B?LzFsV09WZDFkMG9IaTFhWVVpcytnYmxyV3pyaEVlWXg4VDJhVCtyQXF4Ukxw?=
 =?utf-8?B?T3l6N21WK3JHT1llWmdQZXF2aEVqN25QRjk1OHA5VWgwNkJNZCtuYThXbWxS?=
 =?utf-8?B?VmprVDR5WGdYeVp5eHlYelBrMzQvbUorOFl1K2tCYVE1elkzL2pZT0dwOGg5?=
 =?utf-8?B?eEJsbWNyR2xQWWtqT2RFODNVWG01S1JreFdYbzVDdjN6SldYeUNUcHdKYVUv?=
 =?utf-8?B?S3kzSitqVU5NcVl6RUdDTGo1VFQrVU1GQ3FYSVV5RkJKbTF4ZUdWUERUcmxi?=
 =?utf-8?B?L2ZRV09DNDlVa1Z0MW50OVZLNWQ2NGhOUHo1WlFKbzY5YytXT21WbUxGQzJm?=
 =?utf-8?B?TlhtLzNaRkJqZ2FyVE9XWldTcngvaWp4bVVTa3VYemtpeURLQ1k1NldkRTFa?=
 =?utf-8?B?UTlUclAxVGVaMjZGYmllSnc1bUkwampoZlMwb2tEeWh0dUMrOUkwUlY0bGhU?=
 =?utf-8?B?U2NJY2huZ3dFOCtSeUZNeWVsa0wxSUV2S3lsUTlSRVRIYktXN24zdkcvbzhR?=
 =?utf-8?B?aW9KbGd6WHowMUR3UEJ5VWNZU1NiUlBqVkNIZWc2UUN4YmloRDVTczNRVE5B?=
 =?utf-8?B?d0xDcWpobzFkSDZzUTNnL2ZxcGZzdUN4bk5ZM3p3Witwa1FVdEkyc0kxZUlQ?=
 =?utf-8?B?VTVDTncyL1NXVXk3OGkwODZBKzgyS2pXYXF2S1F5Z1JERzRLRkZsbGxxeWVD?=
 =?utf-8?B?S0txZnp4ZENzUk9uNW8yQUQyUkE3SWlITS8zUnZJdWU4YkJqdEQ3Q2sxZHZh?=
 =?utf-8?B?Q202cHQyakF3VWV5VHVrVmRyN3ZuODM5VlNDQjFacFVFc01NaDdTeGlaY2g5?=
 =?utf-8?B?WXI0NlNKQUk1OGplUW81SVkzKzlwdVlISldYUlhmd1Qxc2J5R0p5Q2tOejNz?=
 =?utf-8?B?SDVyUmk3QXUrbjJYdk1tbS8vS04vcEVSM3hRNXZ5TXJnN3N0WDFia3dCQkR6?=
 =?utf-8?B?TVdiNFFKRC9mYU1qSExGMTZLeGdNRFF3dDlGYXFjYU80aGx1bnZKcDhHcWJj?=
 =?utf-8?B?WUFIb3crdGwxdm9id25WQWVRcDNVcHRhT1orVnE4TGZKeVBvNWJXYWEvZG5C?=
 =?utf-8?B?QjUzNUtqMEVzRG5KOGdNSWNlVEJFU3ZQTmI1K1lxcWJnYmsvNHJNbUhQRzNy?=
 =?utf-8?B?Y3FlZEkrRU9RWndBM0UyZ2gxbmZpQjZOZFY1V1BFSDJpelQ2eW95U0NOU0lk?=
 =?utf-8?B?bXg5bEpmZ0x2c2JHVWNRZWpqV1RFc0ZpUnhzUEtSS2tLSm9kb1JCUFVYOE9a?=
 =?utf-8?B?ck1DQytMTFlLMjk4YjdzMThoTUN2U0pLc25WWmh3N0JFbURXL1cwcUl0S21M?=
 =?utf-8?B?VlRBSTVScklONXo3RWlSa25GSVZlbnhlcGFJdXJOa3BQWFhWakNxc2NpbDRY?=
 =?utf-8?B?bkpkRFdFQzhUWTYvanJYSWxUYjVURlFrbUhmK2M5SGZyNENCb3dPKy9VMTl6?=
 =?utf-8?B?WmVMWmZTZ2x1SnY0OFhpUUQvQTUxY2pyTHhmayt1aktwbExMTTdUK0xnUStw?=
 =?utf-8?B?T0cvS1cxOE5KREFJeG55cDR2Z25WRE5jMk02eHRwdVI0bG1hcGpsdXVWZkI0?=
 =?utf-8?B?TXJPOG1SMWQvR1ZLRnBNelJSQkxpc3VWUkVpMldjbnkvTGg1aU5LQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d86bb-7bbf-4dfa-320b-08dedc16c341
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:59:05.7723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XE/Y201hJCEV6zR/Eb16REtY8Mav960/qVBY5xuo1cFpW3vRTGgSfjIG6j3Nhqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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



On 6/23/26 14:53, Michal Simek wrote:
> Hi,
> 
> firmware calls are spread across board functions and even drivers.
> It shouldn't be like that and it is time to clean it up. Pretty much board
> or drivers shouldn't really have zynqmp_firmware.h included. Generic
> functions should be called which have MMIO version or firmware version when
> firmware is enabled. This is the first set of patches to achieve this goal.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (18):
>    arm: xilinx: Guard mach sys_proto.h against multiple inclusion
>    arm64: versal2: Decouple multiboot register access from firmware
>    arm64: versal2: Move bootmode decoding out of board code
>    arm64: versal: Decouple multiboot register access from firmware
>    arm64: versal: Move bootmode decoding out of board code
>    arm64: versal: Move board_early_init_r clock setup to mach code
>    arm64: versal2: Move board_early_init_r clock setup to mach code
>    arm64: versal-net: Move board_early_init_r clock setup to mach code
>    arm64: zynqmp: Move board_early_init_r clock setup to mach code
>    arm64: versal2: Move SoC detection out of board code
>    arm64: versal-net: Move SoC detection out of board code
>    arm64: versal-net: Move bootmode decoding out of board code
>    arm64: zynqmp: Decouple MMIO accessors from firmware
>    arm64: versal-net: Deduplicate SPI bootmode handling
>    arm64: versal-net: Simplify spi_get_bootseq() bootmode switch
>    arm64: versal-net: Do not print bootmode from spi_get_env_dev()
>    arm64: versal-net: Look up eMMC device in boot_targets_setup()
>    arm64: versal-net: Add mmc_get_env_dev() and deduplicate MMC handling
> 
>   arch/arm/mach-versal-net/cpu.c                | 149 +++++++++
>   .../mach-versal-net/include/mach/sys_proto.h  |   6 +
>   arch/arm/mach-versal/cpu.c                    |  68 ++++
>   arch/arm/mach-versal/include/mach/sys_proto.h |  16 +
>   arch/arm/mach-versal2/cpu.c                   | 143 +++++++++
>   .../arm/mach-versal2/include/mach/sys_proto.h |  14 +
>   arch/arm/mach-zynqmp/cpu.c                    |  69 ++--
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h |   5 +
>   board/amd/versal2/board.c                     | 133 +-------
>   board/xilinx/versal-net/board.c               | 295 +++++-------------
>   board/xilinx/versal/board.c                   |  66 +---
>   board/xilinx/zynqmp/zynqmp.c                  |  18 +-
>   drivers/firmware/firmware-zynqmp.c            |  89 ++++++
>   13 files changed, 606 insertions(+), 465 deletions(-)
> 
> ---
> base-commit: e01bb5b8ad09464b8cbf9c4186683e998c2d40fe
> 

Applied.
M
