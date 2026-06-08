Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB62CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A1D84704;
	Mon,  8 Jun 2026 10:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xmB7/O4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A22784715; Mon,  8 Jun 2026 10:45:16 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F59F83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSVPfMbCT9tgJBddjRFfYo1M0nGci2epFaIPy2lnCGpLTamY+us8e7LOC+bLG+PQyMK/92Yq8iEhYUU7ERmUAuc1XGELyGdFI3ESqOphf4aKxkK3eq5qhDVQU3/C94e62MFyu6XPT2P9qAOLiFxrQN6JKgDZcrKecf+ex/+lrr3K+H8FqOYx/CNT3P+MnyMQ7Xi0pnucL1jS7WbPkq8L9MeP74k4OQ5dMCu7zAFbwLuEi0pkqTfNBbqKz7atXM4VANI4+z906U9M7cblwMqlhAOGJMgaE8PVVe19+/p5rpoRSQAy3DJ4tptJ+J9NopTYDpMKyoLbROnFKv2gsMhlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPL7ccgYJLQfa8H/4UxbVxRY1CzmvbG8dH2KuxKVtds=;
 b=cYkk4AJ/CiWPDqFKpoKrgmoV6WGoMgGVZFEGj7nNy+YjPvIyrpsi6gBggpUfYKRMGUTd1YImZlbGKw7FtDiroJBN9zcw+yKpiu28nAu/XxgPFNNwyH3W8+mgY1p621OuFQjntZ7hA1UM/nvwxctOS/nqwrRKZal6u48+U3QanM5Xc44NtILk/Ns/xmziB1FvIqXP36JffPXz/sdFcTzax/SrB2vVa1W5rithJgXITBjqeiVAc3hn1yE1BzmMAvA7N3NWBCihrft8X+lB0TQcpq3L+jE2kI658xIW+vfzP6GFpUnK73CyupEERGvoHDGDWBhrcGU6pvaO07BTpBH0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPL7ccgYJLQfa8H/4UxbVxRY1CzmvbG8dH2KuxKVtds=;
 b=xmB7/O4pfq/lcVJOGefr0e19CFUIbWAj71YPiudW7TlWPCAJmllIeI+BoPnampyt/zH7f0GO6IF6IhusAf/MXSFlTIFk9rvSQmdmS8JYAHqaAUDWavJaV1/xsNjcInuDdcaoXlfBlWXMnRDJIBmg1ON0z+EkSlphM0QXeI/joeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:45:07 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:45:07 +0000
Message-ID: <edc5aa0c-b42c-4090-8eae-96b1001f06f1@amd.com>
Date: Mon, 8 Jun 2026 10:45:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] riscv: Make RISCV_ACLINT visible
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0146.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::32) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 01467651-cc06-4fd0-b688-08dec53a3e56
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QaElCCIKvkoO45OozdPczDHe5wBDXBNYu/dVRDyfOz//m2Woy8+V9dCXOBcF6U9iNRpYTeGMcvlSqUjHhfpO4KcVcjQEgkxKammlm15Pd/hcW4Yxop+5eoCghbHdRMx4lsC4Tp7J0ol4ynrcY3rplYumIbwLU4QaPRkkxiCeDlWEoeZlaTr3RJFVpJGkkor5fuwLlavt8dpOm66ZcHpubaNdEnHZuPhMkJ8xMJDz///Pf4iCWv5IfENxOMYXjnKfOvdZYqYgVh8Yh7OCWwP9cR9EH8xd4vz4RtLGwAlbQPD0i6ic0vsQSthfwdbwwEBPLQUfbBWFzwLVZm5qxzFVUiATHfet5ZZPKRZ0AP8mZVRz1Q2LaWIzHFIMnOxYQJv/utYAmVVw2+6g2rHxOw/TmIG4WiC0LWgyYmX5LBbzPusEKmsOgeerW5TjsxCo927q6lvR2vGEcALEhaX/BJv0bwEKdlgv17k6CgLbuXAIsvGFIFbJQAvnKSf8w78p4p4OnEcxG2n5NiWmMOMB9OO1ZR63C6sugC5tbjgWk70+dmdviot7TeY5C+3R9q17vuoSzyT69jBLn1nTxnLBclPuiQIcRW4vxTVgTahOb3MddWloX79aGjve60vmjm94g9olcTG4k20LF+3vELB9BPWezaQ1MIyvpPBfUARJGexO57tozaFxqsBeLeqCTYcs3lef
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5IMmkxeGpWTlBWaWg0WWl2N3VaZlMvdzhVMCt5cFBUQTNIbUFobWM4VmZa?=
 =?utf-8?B?UEVDR2oxWk9BTW9WSlRqaENJR3dyeXJ3ankwNUVkb2trTnV1a1JoQ3BITmlP?=
 =?utf-8?B?UUdpOVlxWFBwYUZmak03SWpacWtJUWRHWExqSndMbmVhQWMrOWxoQ01PbWNK?=
 =?utf-8?B?azVkcGYwbTZkRExyWXcvQlNSdFNXamd1MmgreHppNVphYVJlQkV2OWlXNk9k?=
 =?utf-8?B?Z0NhMzI4UjdmT0ZaNHRFN3cwdlMraGNWSmVsZ1FhT3djbW9OY3lyTHBNbXpv?=
 =?utf-8?B?Um9VQmRsWGVqWnlWci9oWDFuV3ZlUlJZeDN6cGtRNEk0R2RVTVZRRlU2cEkr?=
 =?utf-8?B?OXJvaGNGejhQUS9vV3MyNVFiQlJCRGlUWVhrQm9UQi9iVDR5TGVoVkM0c05r?=
 =?utf-8?B?NWNXa09YUzkydkVUNDZRRCtUSEJodWNRLzNnV0dyazdwanhDTkplbjd4SW05?=
 =?utf-8?B?OXdjUTVXVG5KeWU3dTRDV0MyU3JydFdjRWtHamFKQmpZUmY5c3F2THRoTlhz?=
 =?utf-8?B?NlZvRFB2L3Z6SzRDUlA3SkNydFBLc0puUUNEREoyTmFkdkttMzZyQTYwY2or?=
 =?utf-8?B?K2p3ZE81NVNLdzBOT2NkYmFVcjI0MEZBZGloV1FJMkRNTFRJeElFQUptK1Nx?=
 =?utf-8?B?TDV3alpiOVVITnYzVUFiNjFXQlJoYkNlUklkTzRFNlZNUmw5dWlRaWJaMTJm?=
 =?utf-8?B?cHE1aU5kbjVLSU9TUnRjdEpxZFk5QlV3UFBaUjJUK2Q1OFlMWVVNMWdhcVZD?=
 =?utf-8?B?cWY5T3NEWERYMmJMdmdlU1o3L241QkhMSVc1QThacGo0ZkU5QnI4Ri9zdWhK?=
 =?utf-8?B?SW5JczNEcE5nTFZrRkRTYzJVdEhKdHF4Vk0wa1plNDVmRGNYSXdMU1FsMWFV?=
 =?utf-8?B?NEtrK3JWaFVUNUNBUm80bWpZYW9uazRFeXFUVW43S3Zyd0ZDL2d2T010ak1S?=
 =?utf-8?B?Qmk0TnplOVpuekxjRU1lTnBHUmZ5RVBWWFRYUDA5dGZ1Vm5RWFpPdzhURXV3?=
 =?utf-8?B?clpuR1JFT2N0NWZORC9UYllreG5Cb21CM05taHJXVG5nSlJZcGdaWEdKUVJk?=
 =?utf-8?B?cU5xei8wSEZmT2dUWmZ2NUZIWGxSRDZYUCs1ZmNxenNmRlNlTXYzYjlwa2ZG?=
 =?utf-8?B?clB0UE82ZnBaZGlFQU8vUm9OZzBWS2VES2lnMm5sZVcwWVlERjFiUC9hT1VK?=
 =?utf-8?B?dzRqK0RJMDEwZFREY1YyT0x1QlJVa2F6NWQ1V2M5WUhxZnUwcFVlRTRKSm0y?=
 =?utf-8?B?TzU5dkE2dFVCRVdvbkhOZENFZk1Nckxtc0d1a2ViVHpSZnh5d0lJcmZyNTN0?=
 =?utf-8?B?RkhMZTdML0JrTnlXZzdnQ1JyMWtTaThkZFpNTEl4dlV2bWxlbThPREY1aFRW?=
 =?utf-8?B?NS9oK3prQ0Z1V3JvZW56QTV1VHBrWlhyM1FFZFZwYkQ1bno1UldiTFBiSWlu?=
 =?utf-8?B?K1hNZWJBWGMwWkJuQS90K3JYK3F3TnB4ZWwwK3gxajU2SHFPaHRIZ2xYNzlO?=
 =?utf-8?B?dGszcHlCZnB6MzRYT0RlbDFXTGFNaE1BcFlIZEtpK0dxcFZRdzkrbnpwNjRn?=
 =?utf-8?B?bk1wZUlEMXRzaWpRQ3g0OVJjd3JlRTVlcjl4SkcrOXBlTU9rQ3RlSGpVeXJj?=
 =?utf-8?B?RjVQWG1mZ0hDVWlrTUVHa1IvWXdkQzF5OHlTTWV3ckRUa0s1UnJCdE9wNlY0?=
 =?utf-8?B?TmdQOWF5c1FrSmVSZDZFQ1hZdFVvQzdSbjIzakZwMktQKzVwTmxxSTZPSXdG?=
 =?utf-8?B?bVgxcFo1bUVlWWRyNVNLMC9WenVyQVhRTkxIS295KzBjT2ZQcjBtQnUway9N?=
 =?utf-8?B?SGJWSkRlTGlHbFh2Q2VDTmQvdkQ3YStxVytVYjJLeitLQ1RQT2ZGUVF4dHp1?=
 =?utf-8?B?Y1FTK0UwL2xZTzYxQ2hqZytnNE14NHJHRjErN3JlNVBrTjB6dUw5U1Jlajh5?=
 =?utf-8?B?eFQ3V0pWTCtBaWJNSFA1MWFnRzdBTUR2dm1vaTlvd3FKWklyRlFEdVZLSS8z?=
 =?utf-8?B?YURtTTluY3dmZ3ovaHk2MHQxenFURmVBTjlKZFRRdGZxcHpaTlFKVklodlFH?=
 =?utf-8?B?NHo0U3JsWElHTjNiMHFzYzF3TTVXVDl4RGptUEQrWWJmNnFDZmNNZDZhVFlt?=
 =?utf-8?B?YWJhdlVoU1JTdUt0eWplYndjVDNoQjJuc1VVdi95YlBNNGNHbUxremZjWmVI?=
 =?utf-8?B?NGl2R3dFbXB1VzcwWnRXOVF5Ny9MaUVCcVkrOFREMjlIUXo1REV1NGNTdUJ2?=
 =?utf-8?B?K1V5QnNOODFLYWVTMWplekRLeW9ZMlZoVmtwU2Ewa05FcEM5czhMaDhmNWFz?=
 =?utf-8?B?UW9VT3AwY2tEeCsybWtqUDBpcDdIQmVwSHh2TTlSNHVHbE5ITjZyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01467651-cc06-4fd0-b688-08dec53a3e56
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:45:07.8889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xe1AsNbyYE1YHNtPuQMRovCgQOve5EgDEUwW4F15GaEgCpABI4BYJatiAhlKV1GO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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



On 5/15/26 14:47, Michal Simek wrote:
> A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block.
> 
> Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
> prompts.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - don't enable it default because it is breaking some boards
> 
> Changes in v2:
> - Make symbols visible and disable them per platform basis
> 
>   arch/riscv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ad7589123c6c..e3adc48f6f52 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -378,7 +378,7 @@ config DMA_ADDR_T_64BIT
>   	default y if 64BIT
>   
>   config RISCV_ACLINT
> -	bool
> +	bool "RISC-V ACLINT support"
>   	depends on RISCV_MMODE
>   	select REGMAP
>   	select SYSCON
> @@ -387,7 +387,7 @@ config RISCV_ACLINT
>   	  associated with software and timer interrupts.
>   
>   config SPL_RISCV_ACLINT
> -	bool
> +	bool "RISC-V ACLINT support in SPL"
>   	depends on SPL_RISCV_MMODE
>   	select SPL_REGMAP
>   	select SPL_SYSCON


Yao/Rick: Can you please review these 2 patches?

Thanks,
Michal
