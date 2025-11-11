Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CFBCCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 04:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11CF83AB4;
	Tue, 11 Nov 2025 05:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PXm/6fzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0231083AC5; Tue, 11 Nov 2025 05:22:09 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30D983A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR3ATWHZpb1HW6YBZxNYaSgmpRl/I+VZDrnubyLarjmMR7f+UweqouBQES9nAZzw2N9wSTtbGOqiEY8V9RC2tADVY8sACiB72g3CXT/FKLvFVph7pWIBRk4Lto3eaDQAEzRjplYklFW6ZsLvnOQAyzpiaXRwwsRaeLMxdm2PdGTUrjd2ouPBtFJMBRD8XOZk6P4dmqRs9/HXl3bFxPYwfs6Pm04u8EHmwb3gsdxpc9LR6u+FPDkqmu1rXWSqTiwPU1OMOwFJeVxk6VYPA4spThgS4EFBW3eS9h8SXgGjhE1yJJ1Dham6bC72NwYCf/og1m4mK6DClpr8FG1vzP5eLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6KkCJqds3b1TIDoB7MBQJPsoKNGsvPFD51vPbY/0nI=;
 b=SFnpLDCERlq/4mre/YezdMYeNeo3ph9EjXz4niFUYkxdP5FY0VhsL3eZLR50ZUOm6XW44oqknYnlDBiKqOaGzTHHEjMCzAqINSKRH4lF0Kj/+BhRzJmJ/jY1tIREaAUHaZw0dh+WJHXH7iPeymRmCiKsjCMGD19hJzOFx3HRCaUuCNRVTc1eNzT3KtqsrXBbQ5Uu743r2qQ5XGVXvwpyx8JkM4AFpZMvCr9zqaOZuGaLeWgIVJnFubfQk6YKYhLxsfLMK+Y4SAv58jOiZBHYlS+uJiRnuCmSRNHOkvl8SXv8GKO4h5f9qTA2B7RoCNUo1EGuJRgs65HRlxuNAslzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6KkCJqds3b1TIDoB7MBQJPsoKNGsvPFD51vPbY/0nI=;
 b=PXm/6fzBlePinH3m/l3sWWdfKPEUZifsd106uRrNDmJ94dVY1bP/+zqzAdxIZSblulQNQSchegZnlrAGf4yDlTaH2/yNBcOoY0uGEaq50F2oCFYvRCa7b0/BKAzsmziV8q0ZlYEGkYo8+kposyxbWGfPTZj8Za6ZkUsE3bwI2uA=
Received: from SA0PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:d3::22)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 04:22:02 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::66) by SA0PR11CA0017.outlook.office365.com
 (2603:10b6:806:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 04:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 04:22:00 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 22:21:52 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 22:21:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 22:21:52 -0600
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB4LohL304287;
 Mon, 10 Nov 2025 22:21:51 -0600
Message-ID: <bfd32255-3de7-4475-ad5b-48dc1e1aeb99@ti.com>
Date: Tue, 11 Nov 2025 09:51:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arch: mach-k3: j721s2_init: Add workaround for errata
 i2437
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <gehariprasath@ti.com>
References: <20251106063929.2232788-1-n-francis@ti.com>
 <20251106063929.2232788-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251106063929.2232788-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 093a110f-e841-4c6a-6f3b-08de20d9dc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UC9xSWtudklaYzNQOHVTRzRLeUUrOVRXVkRnVXlWaE9uQzlSV1Ewb0R5OC9P?=
 =?utf-8?B?aUFQNitXeVJHK1R6VktnY29ZV0IyY0NHc2hpTjRSVVk0MzF0clRJMkRuS3Qr?=
 =?utf-8?B?S09zMjhQeHBabTJBSkozNW5VU0N1Y2NlOFdTOEkyQjh1T2xjeHNjbHlaenNu?=
 =?utf-8?B?VFZZcnJ2anAyYW5hTlZYZkFmVTNvMWY4Zk0xSmR6NlFSdEpSMUF5c0QrMnkw?=
 =?utf-8?B?bUlVMzRSYTl6S010aGxTYURPYkdhVjFpbHRPYjZTRkhCeXMxRHdRVUNZR3Ay?=
 =?utf-8?B?ays3N3REdE5IaDRwOXZ0cThiZk4rMkNIWkZ4K09seW9RelNiclBKbDZWSE5l?=
 =?utf-8?B?OGFUSEV5SkJkUmZsNkkvdi9EVHFzWnBxUW80YTNkZ3doaXJKdkNiWWtDcXJE?=
 =?utf-8?B?THBwNnV2NnhUTWxIYUF5encza0xhbWQ5ZHNONitZVjJlaCtMa1krVmFVTlln?=
 =?utf-8?B?ZzBuWDJTak5DT00wd2hmaXRUSEdlNFdjdUlnY0VCOTNabmx6MmpCRzk0cU5v?=
 =?utf-8?B?UTR1a0kvSXNYQjdybEJwZVhBb2RudXdWR3lva2tRQS83MkEvNHJMakJTM0hp?=
 =?utf-8?B?K3pVQzFOZ0VYeUdKZlpOMVhDUzd5WW8wYllMQUxIV2RVY0pHM0thbDY2eSs2?=
 =?utf-8?B?WU5yd1Q1K2dDeVk5bVJ1SmkrV2Y5ZkRORFo5KzVXdVRJS0VQelBBYjBYR3VQ?=
 =?utf-8?B?RXJVNGxYakVXQnlCRU1nbEVBR3AwVG11aUJ3UzJPMWg0S0ZJODZmVkwyTG1l?=
 =?utf-8?B?akNCd3FhVG1Rb29tTjA4eVRJeVRnMzBXaExjV1MrODZXb0VsdTJObGJLREdn?=
 =?utf-8?B?WFNQRFBZVVNmTmowQTlIY3pvdXREdFI3WVRsWEI4S0JmZWhJZFRhRkRXaE9x?=
 =?utf-8?B?YUI4TEVCejdIMWlSZWo0SGJBRzl0alY0eWhpNmxWL2VMWmt3eWhOd0o0LzV5?=
 =?utf-8?B?S3B6b2pMVjVCdU5XSVVYbUhBb25BUW9FMVFnSnBhbFA3YU5CQXRjOVNhUGlP?=
 =?utf-8?B?YWlBT1M4TnpEQ2ZFYTQzb3NOY0Z3d0dwbGhPb1VKNWNQeENHVWlubzhRNnpI?=
 =?utf-8?B?RGQ2Rm44OE9nVEVQK0c0dUhOemNGeFRvVWY0MnpBMTNzTTdBMzNFK2tkTEZt?=
 =?utf-8?B?TkVnR2pEZWI0eUpWUXNNaUtFc2tPL05VUHpBUzRDUVhoejF6MlkxL0RYTnVL?=
 =?utf-8?B?OU9YK0dreTB5bEFiVlZiOXB0Zk1Kdk9OT0toMHVVT25ibC9tekRlUUVlUkdP?=
 =?utf-8?B?NTlnRGZSSUlPUkNydkI0TGo3dklHMTJyb1R1dnF6Q3JRNWRCYVh6b0gyNjM5?=
 =?utf-8?B?alp0VEU1TlJjbGh0L2p4cFFPay9ZQzlWcTMwY2NOVTlrbngwQU5aaFd2RkJR?=
 =?utf-8?B?UDVGYzJIZDRUeWMwMzJBME5hVmp3UVRqYW1OMzJVeFF5MVdocmJiK0x2SURx?=
 =?utf-8?B?V3BvRURZR2Mrb3JOdzh5OUg3VmRaL1hNTVV1ZWtTZ3dLdEFqTGJkM0x5Q0FC?=
 =?utf-8?B?ZGpBODlFRFo5c2tPbjNEdms3M20ydkkzZSs4dzBXdGJUaUx1NkJhWVRWMFF0?=
 =?utf-8?B?SzhnRHZORmlUbko0M2hIakVIYlpRZTJHOUEwRGtsQTNFTkUySUZ1b09GY1o1?=
 =?utf-8?B?b0ZBeEVRWDVTbjdMa2gwejRENFJYdXVFblpNZTFWK1Vhb0dPUm5vSU83UlJ1?=
 =?utf-8?B?M0EzZzNSMldsN3c1S3JrbGxyYmhpUjJlY09aYWR2MUY1eE53NXk1ejBxemk3?=
 =?utf-8?B?VUxHR1JadDhmWXhWZnM3bEFXNmJBd0xMNyt4TGcra0dOcWJWMWQ5Z0Z4bkRp?=
 =?utf-8?B?WjJMb1RIVkRqTXQ5SzFLTTdrY1dZbEh2SXNyRDVJMjFrZHo0Vks3bUNPWEVM?=
 =?utf-8?B?bTU2SHpHZU5FeFBQelRRczdJb2JuRGJzc3dxNTlXQmhNcmpqK1hSek5zWm1W?=
 =?utf-8?B?bVN5a1V6LzRPTy85WExVNnpEWWdWdUt1aDNBWXN6R1htbW81RWI2eEFDeEtW?=
 =?utf-8?B?ZUViWllJaEJyV0pRVVM3M1dXcDl4SFFqR1l6Sms3K1hISkluTkt1UURvK0Zz?=
 =?utf-8?B?Z0VGMWVkb1A1NzMwV1d0ajhQbEtpUGZVU3RGcUgwUXlxNWtuWElOWWtoVERW?=
 =?utf-8?Q?19QY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 04:22:00.8566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093a110f-e841-4c6a-6f3b-08de20d9dc53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
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


On 11/6/2025 12:09 PM, Neha Malcom Francis wrote:
> Add the workaround proposed for J721S2 errata i2437 (link) for SE
> clock-gating turning off too early. Without this, a hardware bug present
> in C7120 leads to C7120 CPU hanging.
>
> Link: https://www.ti.com/lit/pdf/sprz530
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/mach-k3/j721s2/j721s2_init.c | 39 +++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
> index eee3d0440ac..ecc4cbf1df8 100644
> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> @@ -40,6 +40,15 @@
>   #define NB_THREADMAP_BIT1				BIT(1)
>   #define NB_THREADMAP_BIT2				BIT(2)
>   
> +/*
> + * RAT mapping for errata ID: i2437
> + */
> +#define RAT_ERRATA2437_BASE_REGION0		0x40f90000

Please consider RAT_ERRATA2437_BASE_REGION0 to RAT_ERRATA_2437_BASE_REGION0 for better readability
and below as well,

With this change

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> +#define RAT_ERRATA2437_IN_ADDR			0xc0000000
> +#define RAT_ERRATA2437_OUT_ADDR_U		0x0000004d
> +#define RAT_ERRATA2437_OUT_ADDR_L		0x21000000
> +#define RAT_ERRATA2437_CTRL			0x80000010
> +
>   struct fwl_data cbass_hc_cfg0_fwls[] = {
>   	{ "PCIE0_CFG", 2577, 7 },
>   	{ "EMMC8SS0_CFG", 2579, 4 },
> @@ -346,6 +355,36 @@ void board_init_f(ulong dummy)
>   		if (ret)
>   			printf("AVS init failed: %d\n", ret);
>   	}
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		/*
> +		 * Errata ID i2437: SE Clock-Gating Turning Off Too Early
> +		 *
> +		 * A hardware bug is present in the C7120 Streaming Engine top level
> +		 * clock gating logic that can lead to the C7120 CPU hanging.
> +
> +		 * Workaround: The DSP_<COREID>_DEBUG_CLKEN_OVERRIDE fields of the
> +		 * COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register (where COREID is the
> +		 * name of the specific C7120 core) must be enabled before power-up
> +		 * of the C7120 core to override all clock-gating.
> +		 */
> +
> +		/* Setup RAT mapping */
> +		debug("Errata i2437: Use RAT for COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register\n");
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x24) = RAT_ERRATA2437_IN_ADDR;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x28) = RAT_ERRATA2437_OUT_ADDR_L;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x2c) = RAT_ERRATA2437_OUT_ADDR_U;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x20) = RAT_ERRATA2437_CTRL;
> +
> +		/* Enable DSP_X_DEBUG_CLKEN_OVERRIDE for C71x cores */
> +		*(unsigned int *)(RAT_ERRATA2437_IN_ADDR + 0x200) = 0x00000300;
> +
> +		/* Clear RAT mapping */
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x20) = 0x0;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x24) = 0x0;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x28) = 0x0;
> +		*(unsigned int *)(RAT_ERRATA2437_BASE_REGION0 + 0x2c) = 0x0;
> +	}
>   }
>   #endif
>   
