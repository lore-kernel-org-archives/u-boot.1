Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86527C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B158875F4;
	Tue, 21 Nov 2023 15:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pl4QE7ag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBC4875B8; Tue, 21 Nov 2023 15:29:04 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2D487572
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzEZWlM5BCqXMlkY1sCwtGjVukAW7IQZmbOBSqPiq+WRq5A2ScxgloHSEba0HN+uninTpkLoWyvIH5WEdML4mHxw3ZaYjpUzXG1UFzLdjAEK4/5lgVC+BipWlyzRfd+yojtqUSMKRPImqkIYwX9LfiZXAZZgIbQiaR6yamIhiMWH33zg/aQ4yCBrOFd4CHUo8NrwNAMJq1r4fuDyP5l0igWugFq6Cwgkm6qkNkxEL2EF70QZMdFZSGxG3TS62ocx7JUvqnEsH93s6Ep0sCaZwCIc7mGcoeuk5Z13wd/PMzWmvV5FhKAtZaxY9g4lu9HlhVJrnFMwCguEP+EBnlW5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krXUk64RnqmMxDFZykuFnh4NLIXIHSwhxbv6mWklCSw=;
 b=MYIGhd+709+QcuQW2XT96yFbUoMWY0LsWzyLiEIswruQTxVYj7DHQOpVAgZGH3nqGug77/2/rn7bHaT6kbP9DU3I8IKeRX/4r3pTlGubjra8P0+t6LE56/Qissbv1NtBgDE00MJdRC9UCCreKLZ0qmwL5KT/7vjyzxBvMBAsgS3Pto8vh7g4wbmk+DB9Bj2qKuLaUWwbZjloEpClv6G3jj9mWxOGSm+7AZRw0hJIZK45erAzfX185sSLwmLXLd4pd3ZINImGrUk9bvdRvHjAKf/hMk1OkLxiLEXUzKK+x/JXoOwZvnLEIuaAFVlQtxK0PAvGdrtN/PjL3imiugMf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krXUk64RnqmMxDFZykuFnh4NLIXIHSwhxbv6mWklCSw=;
 b=Pl4QE7aggB3IlM+1Kpeprsyiey7hUk1GG/L/Oske5fqSfxXEybbdXVXqPddFywpby70eycrhISxXj6kni+8O+J2ndqkT/wPyQzcAgA8u3+rBHNyHZbRmXFmsFW2Y3IHqkMQ8z6/fMvlySB3Gj6gpz9wJ7dFKwoDTNn8vI0UsqGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 14:28:59 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 14:28:59 +0000
Message-ID: <6c5a21fd-bfd3-4b9e-b8ec-5d195f9c8c08@amd.com>
Date: Tue, 21 Nov 2023 15:28:50 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 2/2] xilinx: zynq: Enable capsule update for Antminer S9
To: u-boot@lists.denx.de, git@xilinx.com
References: <3ea0572dbda8f21270c00a77528eb6ec954c7c40.1699866313.git.michal.simek@amd.com>
 <8f8deb5f46c0f2d4b687b626f4de221873133856.1699866313.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <8f8deb5f46c0f2d4b687b626f4de221873133856.1699866313.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 3747063a-d323-4639-cbe0-08dbea9e334c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xalv1p4FzHzf/4QnPn2Ts/drTn5A6+4Hd2RqSZt4/TEHF1MyZZZievsI+BiKaEm8XcmNRFSToaHy1/YywK/Z3f1iqzgsPRcPb/ABtqSfB22GFJ6kS7yobxR5/384zAf/LI+SikkGwihBwO1IlGzZpUwqbgy9sHxy3IHWXmvJsaon+V2uLM0aJdl61ipfTVkvOkkHG9eMjHtHwff2Aql5quYfHBGuXeWvzKaftXluVGoig3XI0p3RzDdvDOKXHHHt8aAjzdo35o6Vx3Q2w96M5FnSFg3oHQEh4lIggAYAflg+INBsEFnUA2ZqB+/TYgNryyjEuKn0uRbEKQycAkNCmFXMBkgaYDZD7eYGx/fJBjO4Pl6ocsXIS263yBYrujKqvXRqBx5c/W2TAW/9pqXfobOoKzc9m5rGyGgjzRdLzxj+C9aMRKFvhWAVjFlQEKfswoEFQdhG61khAYZ8gCSedvkq3G8dtg7GRtJtinqpiLxwtzL1rdPtN5RpW/a7Rae0ZEMZfcMO7khHdQkQuvhRo/gPdPlJaMk0pCLVsX6kM/OfE6muX1uwAMOMAtTuqXniqW1qN+6AB5HwEe3f62lxPbp1K2xZ0z2uhsI+aXD3kSsmHDNZ09GcRzDTrrSVc3rK53OHP/JD7ad/Y82NhU/eeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(31696002)(31686004)(6666004)(6486002)(6506007)(66476007)(66556008)(66946007)(316002)(36756003)(6512007)(53546011)(26005)(83380400001)(2906002)(15650500001)(44832011)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZUNEFQRytLU3BiT1VNQ01uL28rUkNMQ2ZoT0RJbE9QbHpTNHh6QVQ1Vkxa?=
 =?utf-8?B?N2k2VjZxWjZBeng0d3RicUZGNkpXU1I0cWE1Ym1XbFBMQVhIWTdJTEp0TDRk?=
 =?utf-8?B?V1Rkd2VBTGh0ZzJvY2V0b25NcnllZG9kTEdjVGNqUUJlVWJFQUk2Tm9HNTB4?=
 =?utf-8?B?WkVTenNwak1vU1FiYmI0R2hRQkVoNDI0OVNBak9WdFZYL002OTVDYUpXZUti?=
 =?utf-8?B?UmJIajd3alNTZnJsSlBrSlFLRVBwd0V0UmJjajludFJPeTdlTjlPSGlCT0Vw?=
 =?utf-8?B?akhzd3VBQnpqQWt2VmMzTUxHb25wR0xjK1ZHdlp4bjhwQnIrZ1duV1VwWTZQ?=
 =?utf-8?B?UW1MUktkS3JOdTZjTFVqZWtyUUJOdGEwQ3BKMDlGdXZ3WnA4cHZkUk54cDJT?=
 =?utf-8?B?UDlRU3RLaExSMTA5bDVGMGp2cXA0QVNIaVpvOURuVXlIbzVmc0lXVzRPZXZX?=
 =?utf-8?B?MkxDRTdMMk93OU5wNXEzczV3RjJlZ21UOHVoNnhRakJOeElDQjlPWm9qQ0dm?=
 =?utf-8?B?SlVpRWNRckdRNksydzFvUjhGTEQ0RjFJemZRKzV3Q3ZQSWFtbHAzQTVCVmhl?=
 =?utf-8?B?QmoyRUpWK3ZIT1VTNTFVSDF0L2l5cWVvcHpIZW5Ma0xOcTdhSFdkZHBnQ3NC?=
 =?utf-8?B?Z1p0bVpJeWt5R3B2UWk4ZzFtbjNyUld0OHZBb2NoU29HRXZmdUpzNXMyRHpJ?=
 =?utf-8?B?VGQwV05qSitzaUdDajZuM0RIOTlKcWNIWmxQNUpCUDYyUnh4MTZDNjdiZnY3?=
 =?utf-8?B?aldscHlGcDNpQlRidmxqZElkQllNSkkxRXFoMU1XeHZGT0E2WWFHdFkvMzhu?=
 =?utf-8?B?dFNTNGxhWHhrM2wzdkFUSnZ1bzhWeldNRDdZUllCMTE5MzBaL1NHc1BGNTc5?=
 =?utf-8?B?TFVXNTFBM2ZlNXloUlIxMnZGMkFBeW5PZFR5aWdZZWpTbkZVeHcwRVVyQ3Fp?=
 =?utf-8?B?QlRQelQrbUhydFcvRTgvcUhHcWNDcis3WXl0Q1JrbHRFSEdiSTMwc0VjczB4?=
 =?utf-8?B?SEQrZm1qcDJIc1BadUMwYnVoYXZiNkRYeUcyNjg0TGhERmZvZjJzQmRUS3k4?=
 =?utf-8?B?Q2R6eEVZUGRMS1ZIVVpYbFd0OFA2bEFIMEJtK2NMNCtDckM1dHJrZUZHS08z?=
 =?utf-8?B?Mm9MUnF2dTdaU3hJSDRoWmdTcFVnUnFTNGNHMmxzenM3T1FUdTRTd21tSDJK?=
 =?utf-8?B?a2tWK3lJNXNiVm5qbDJERGpRNFJSVWEwUjM0alJrOEE4YUpURnE5Y3pUMlN0?=
 =?utf-8?B?bW1hazV1MG1mZytOU0V3VnF6d3o2OU9HSjhZemJFNU14WGp5V2hUb1JEV2dO?=
 =?utf-8?B?WUUvYzZUbWtkK1RMcTZuVk14NWh0NUVvdkYrL1E2ZUpJTkgvc28vWTZ3M2VF?=
 =?utf-8?B?NXpjVmVIQ1NvdkFPNnNkaENLOGFmSi8wOExHU1V3L0Njekp0WDE4ZDdDaGJj?=
 =?utf-8?B?SzNRSStIU2RmOFY4TWM2Z20wangrUGhCT051YjVvT2FCL3NaNEYwai9tTnZZ?=
 =?utf-8?B?QVFBUUUvVDdhdTljaXRiemN1TEZmVVpYMTQ0S2ZDSmNaQVppaTJvT2F1Umhz?=
 =?utf-8?B?aVVDblBubStTYWJoRCtoTk53NWRndEJlRlphemFLR2tWLzhkVll1TjlkRlQ2?=
 =?utf-8?B?QlhRR2VQMWdVTnJLQ1IzNmRyS2gxL1pmU2tGVXExRzFMenRXcXV0bVYwc3dO?=
 =?utf-8?B?YlIyMHdacFB5T0RCOXZ5bzlnS2FMUi92YzZWVTlBUGQ5d0liekIyTU9IRG9o?=
 =?utf-8?B?K05YQnpNcEEvT1lsdWdWTVdpMVQ3MjhkNlJYTnhsdkdTSERrczFHOEw4cjIx?=
 =?utf-8?B?S3dwOEo3UkNHWWMwOFdQZXBMUE90Nno2em5DU3JYWVZrSmNFZHhnNTc1QVpH?=
 =?utf-8?B?OTdKTGc2NzlNUzFMNm5BVC9zTk5EbGtPZXRRK0tRNzJzSXgxMUtwU08yN2xs?=
 =?utf-8?B?U3k0MXF0S3BzR3crWnpuRytSY2hPZ1gwNXlzaEZVRWFWRklvRmQ3ajNUL3Zo?=
 =?utf-8?B?Nm5VdGdWN3pNMHZxUHh2SHRPdm9iUEd6a3B1WUpyVmF0TmhBQllqd1BCd0ZG?=
 =?utf-8?B?MXJONmJjYWJVVW51emRUQ0d0U1ZUTVJtd2lxM1IxU0srQVJabTVIV1lrMWxj?=
 =?utf-8?Q?PCqXMwoap87nZjbvmG5ooVNwy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3747063a-d323-4639-cbe0-08dbea9e334c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:28:59.2225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FcFpf6DDBCP2vBBkeu4ht1nABZtCP46mJkPEFtc6CeJa4EEsskK1g9dqrJzpdmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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



On 11/13/23 10:05, Michal Simek wrote:
> Capsule update helps with easier firmware development that's why enable it
> by default to be able to update system without replugging SD card again and
> again.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/bitmain_antminer_s9_defconfig | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/bitmain_antminer_s9_defconfig b/configs/bitmain_antminer_s9_defconfig
> index b8c9afd9cfcd..5c9b97819b14 100644
> --- a/configs/bitmain_antminer_s9_defconfig
> +++ b/configs/bitmain_antminer_s9_defconfig
> @@ -42,7 +42,6 @@ CONFIG_SYS_PBSIZE=2075
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_SYS_BOOTM_LEN=0x3c00000
>   # CONFIG_CMD_ELF is not set
> -# CONFIG_CMD_DM is not set
>   # CONFIG_CMD_FLASH is not set
>   CONFIG_CMD_FPGA_LOADBP=y
>   CONFIG_CMD_FPGA_LOADFS=y
> @@ -50,6 +49,7 @@ CONFIG_CMD_FPGA_LOADMK=y
>   CONFIG_CMD_FPGA_LOADP=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
>   CONFIG_CMD_NAND_LOCK_UNLOCK=y
>   CONFIG_CMD_PART=y
>   # CONFIG_CMD_SETEXPR is not set
> @@ -60,11 +60,15 @@ CONFIG_CMD_MII=y
>   CONFIG_CMD_PING=y
>   CONFIG_CMD_PXE=y
>   CONFIG_CMD_CACHE=y
> +CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_CMD_FAT=y
>   CONFIG_CMD_FS_GENERIC=y
> +CONFIG_CMD_MTDPARTS=y
> +CONFIG_CMD_MTDPARTS_SPREAD=y
> +CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_NAND=y
> @@ -74,6 +78,8 @@ CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
>   CONFIG_BOOTP_SERVERIP=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_BOOTCOUNT_LIMIT=y
> +CONFIG_DFU_TIMEOUT=y
> +CONFIG_DFU_MMC=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_ZYNQPL=y
>   CONFIG_MMC_SDHCI=y
> @@ -93,4 +99,6 @@ CONFIG_ZYNQ_SERIAL=y
>   CONFIG_WDT=y
>   CONFIG_WDT_CDNS=y
>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
> -# CONFIG_EFI_LOADER is not set
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_TOOLS_MKEFICAPSULE=y

Applied.
M

