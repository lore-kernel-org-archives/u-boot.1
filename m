Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21538F433C7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 03:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D2F8407E;
	Thu, 16 Apr 2026 05:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BoWVgUw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E77C840AB; Thu, 16 Apr 2026 05:52:56 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B5B83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNBF44lOJ1LLculsc5rWBeiPMrjxFjZLspuV/zSNbxFL2AuJ7a2b5ZZxCPdeDESTx+Bc/zBMYF+jDjv1vneK/EzaQ1twgwJMLhyy4grd+hvo8igB4AjiGez5K/BXkAzMeFLa1pTg/4xL/vHxp9lyy7f98XgKbj6uBvG8PweazQjdsjIPdbbOa5Y89AkQhp+3PtNiwpBBHq5pkVRv9c8pfVPVmA6Y5kZ8NCMRn4jw5tnlBl53qO0DsuU929xWl9kF0DJXR4A3YZqVruBp7q6eS36vzgKJGuWTVov487UyJyqsj/yXcy+gPtTM9RYOnjJk8j3iL04uF9a13Md93tbukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzl8tLpDpKdF9fh+deQ7O5kXu0XvIGffgFj9kYf3K7A=;
 b=b8n/Vk8ob9FMDr25aJigI/irKzIKvlgmZeJvi9XMNXzb8tIOgXGDJysXNbfKP8HSzyOXxwqU2qMamQbnlDUg4y/0LKnso8bORDvSb0tZStlZ7jTN1T5BOsLpZNYJVlgchvysE/JTyFA6hQphI5deDMxC5WNPUMvQvkeX2xvzMuSocZy/0SmcixCPvSzgcdjifyw2wgW//wvfzSjYM6R6rRFw7E07+9bPsH4TXr6JmZ2Wv3f6pMbb8VR3NhPbvgN1VICNGf/N7Fsd4VltJICo1RLh2tLhw35++TsGM/ebwvq29mIM27YeJt9+G9AuRVR2kb9MdYunuLkSAZ58ev9bsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzl8tLpDpKdF9fh+deQ7O5kXu0XvIGffgFj9kYf3K7A=;
 b=BoWVgUw2t2SPPI5mzy5YJr/SHeZhoivztnDHdkg+lLSUR0JAvF1ljqxnGibvoj2LuZQbyqQYD+01cYDUsUAq6P46/ETG8sOHDLBcJDiTCwhA2X1EnjB53vWmtuowgxvVtgSm1I8WR04SndFqlJis9Dl0UcjDLcUNXVrYt4UBnpyz0i0xTsKgnnA6Tlidp3GRDTRPl97TuhNvll+McXNRNZnHLlyUOgoUqYoI03usD7ChFX9+syyvIl8m4yMxJNJx0rOCSponSwHCU9Skh/YZYqFd1KCz3Eb8XtddlEmkvXZ5+6glDhqaSpHgH/8U/ACMt58rYI3r2RJhSjBumhqZ1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB7892.namprd03.prod.outlook.com (2603:10b6:303:272::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 03:52:48 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 03:52:47 +0000
Message-ID: <223e763b-772f-4b3f-8b1d-301e2d976884@altera.com>
Date: Thu, 16 Apr 2026 11:52:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: agilex5: Configure DFISEL for SDMMC/NAND
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050117.23037-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260311050117.23037-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 75df0926-5119-49e5-6956-08de9b6b9fa8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sZh5eZU3vHMJunl6gZ0qpeeucyIf3YW25SDd7kj1Ag/Pj55eUREZMnXlxba2yXuAQXgMLy6FadcI2KoWQSb9Q5eFrBPiv/bxNjASJNv8wJrmgD0nhypsRn+Ve1MpAbw0xBgFtEUE0O3ibKunlGCaGCVF2F3XbBuLuA1uM0MuGibv6SPCnBjk1VZaXGx5KSUJ2wD6BBwbatfn1D+raPQ+0ZNfoxMa4QXqK6vjb+OAQgQHSC76hAZ1fEkV9eysSS1FaFZrChLeDSkxiv8JsNs+AXNC3uIGoiYBLt3MP+s+XVj054dTGNoy4MRXDqQ7hGdPzcCbIQ3Qi+SCN02X5uaVX/x1wCnJfDctmkVHRoZ409f5yQu9UZyE1yi5M6SytZStMew9Fd6xlTD72t/gMgYqHjxnwoKijPVEsTpMPLxoqgVQYAynmBvVWN6Me5VrWi3na8fdEnn1Rn2lrWDJTDFpnefio5eaGi1+DhfsoSxz2sud+OMOAvylM6Y/IDgxBUVwS9EmtUa1ibp7hpoLHXG2QuNCr4kWZwFYgDbAuNNeqBNHAhZ0AwfsRgx85TRP5+rvTVelE6YQ6WKAxegyABaudwADVFAtjl5Hqw7I2TOUdnQwrlk2lw0LJwUzjCWKX2ZdgA7LaHW+atH4CXjUCdXiRj2awRVGi/myFQkyDicBsEvBEFuybH8f8savTlqHVL6r3hMW+UHNxmISRc5fuPXSXyX6Sm/zFPTzDkzqeEtIovo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2M4NU1BVDBaV0hzYjJsNksvWEs3ZHU3dHRIWStzclF6T2J5WW1MbHZ5N3po?=
 =?utf-8?B?RXpYSVc5SXFxYjgzYTMrZlJWOEdXYU5mZVdqNjMzVzJjdGNDRmdDRFFtdkdz?=
 =?utf-8?B?M0lSR3FKNCs5K2Q2aCtRTTZTQ29VQ0lKVVBUNXdjK3ZRbmRWWEw5ZDBXYitJ?=
 =?utf-8?B?dFhmbmJEVC9ZaGpMVVM2djFJWXVFWkg5c2svR2w3ak1qNEpyQWxoemRBNnhD?=
 =?utf-8?B?VHBpN2oyWVRxRmR3dElBWllsSDJuOXZjTGEvTTJBN0V4QVBhb0Q3dklxL1N0?=
 =?utf-8?B?TE1kRjQ3MCszV3hLd1BTQmhSeVc5S3V6OTFjTkt4ZXlvaHBHK09JM3EvS2ph?=
 =?utf-8?B?OFNHS2w3QmJzNCt0di9OL1FvR2IvUU9CTEVpa096Uk1tdFExcExSWUhvc0xY?=
 =?utf-8?B?N0xEeU84bXEvUGNOUVNYcHlCK0dsYjd3NzBkWVdXNkQ5T1lmWGVsU3BjRWtD?=
 =?utf-8?B?am5RYnZNcEtIWU43OHdkZmFXRy9lSVRPMW1Relo1QkdEUEV1UTV3RWMxaFJh?=
 =?utf-8?B?azlHUEIwcTBmK3NmRGYxRkVza1NwUmRRREVhcWdpNGpQbGY3VmtCMCtFQTFB?=
 =?utf-8?B?OUxZcllQdUlsSGFDc055NzEwY2dHS3cxMWYvaCtISjdqUFJXaXdYU282ZWcz?=
 =?utf-8?B?LzRVbVlaMWVVOVRQVTRlNnUxVEFLVGJmaWF5Y2svTjQrVGxvUXE0NDNqUFU1?=
 =?utf-8?B?K3psK0poYnBSU0FGb3hSKzFWVWU1NWFJa0s1YXF3cjdjQk56dDI1S2VUd0lV?=
 =?utf-8?B?T3NKY0UzR1JVYm0xem55M2xMZThhd05YTFlLUzg3WUNMYk5zb2tUaFhmbmpz?=
 =?utf-8?B?eGpuV2o3aEptWjk3c1k1UlJleTA4SWJYNzFLU0xPdnh2UWwvd2ZUblVWWmJO?=
 =?utf-8?B?TldjTkZwMEF0bWdzUVVkSFpZdDB0SHlFY0JKM0RFcXY4SGdaeE15aEc1RS9x?=
 =?utf-8?B?L202K2VPTHpUUU1lNkpXMHp1bHhiK2NXcHRaYzVUYVZyL3lodnRiK094RWts?=
 =?utf-8?B?cmw3L1Rza0J6b0VKVlgva0FWRDFQYWNxbG05MUJoRnFjRTBHTjdQQWwzbER5?=
 =?utf-8?B?ZTZNODdBWlEyTmN5WURlYi9mZUxrUkc2ZlJ3bjZFQXVSYkk5SVBhMW9EMVNM?=
 =?utf-8?B?ZHpGdkVsY2s1dFFjeE5xUTBQaDdwdG03WGJhWkVlb2ZEb3AwRnBtQlJpQS9r?=
 =?utf-8?B?SDV1bXZ5T1pqR1BGb3h6RDRQNzc2SU90My9uT1kydkkwdjVCN21DZi9hUG9J?=
 =?utf-8?B?eE4xL25SQldFK0VBSndmbys4TmlsMnFUTDFvZG1mcEVpU2dDeHFZVm04R1pS?=
 =?utf-8?B?SUtwMzI4VHIwcHRnT24wOUVhSVIybnN5bTZhUmVBU1BwempuOWRKWDdCbHQv?=
 =?utf-8?B?T204T2UrRTBkVkR4eEtVYWpqbDZ0TFhzK3M4R1o2cnJDcEhTNTFnRzBjS3Fa?=
 =?utf-8?B?U2t6ZnJDeHpuZVpxeHVKdUhORmJxeWdVUndYNUJ3eEh2dGplVlNJS0VzR3Fv?=
 =?utf-8?B?YXVFcGxwUHFtOGlsZGlBcWJVd3l0K0xPZ0JVa1ptSWtVNURJdFpjejM0RDVE?=
 =?utf-8?B?WnhMOGY2YTNGK1hnK2NHUE5Za0Y1aVBBSC9YRG9XdjVhdFhlOUNCWFpRTDVa?=
 =?utf-8?B?YktMMDU0T0dyTGFRVFhPQWtma0UyTjhZbExIUk9DSFdNQS9JSGhrZjlXUnph?=
 =?utf-8?B?RXFmMkxpSWFXZ0pyYXJ3M0k5ZkpPWlQvY2c1bnI2MjA0M2lMNmpUZ3lKMEND?=
 =?utf-8?B?d1pGQXZkc1AwcThLcUNCcnM3aS9LMDMvTkN3SWF0L08wbjBlSDUzY3dUd2Ew?=
 =?utf-8?B?Ui92ZTNIallra1ZkRUNzUzF6d2w4anUwNkhpY3l3T0ZKdndZVTFad01NTGI4?=
 =?utf-8?B?NnFNaFE0RHZzZHpQekFPaEcxUUtOa2lVQ1JMaU10OXdtdjRqU2swdnRTV0VT?=
 =?utf-8?B?Ukp2dHBLUGtqZkdNUlhoVzNaTS9ZV2QvU1ZER0NXeURyQzREVUhTMUNYdWJp?=
 =?utf-8?B?eUxlUWtXN3BzSVRiUytOU0hkU2NBTlBvOE5VZDVjaXZ2WmZOdURmemp2SHZy?=
 =?utf-8?B?a3dORGI4eEMzZmc3aUZ5MmdKRUhSTkpLSzhqZnpNa3pzNXMzZWQ0Z3IyQXRV?=
 =?utf-8?B?eDgvbUZmVTNvRkk5RmNrM2hiT3dJUzh4Sk1aMlRtRDlpRCtHQzBxLzRxUGto?=
 =?utf-8?B?TGRFUFF1MFlGc1M4a0hHbVlDc0N4blNxR01uU2NZZGhvaUNPbDEvQlJwTGhj?=
 =?utf-8?B?TUYzUTcyUnZpbnZuOGV2a3RzeTdrY2NTUzJIUkZJUEZBVzZ0cGNJWjNER3BL?=
 =?utf-8?B?c0lxdUV5WUNTZDg1Y1ErQXBpbk5iSDZnSHFIOVMvR0hLVlhWTmM1azFTTmp6?=
 =?utf-8?Q?WPR6PSssRF/jrvmc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75df0926-5119-49e5-6956-08de9b6b9fa8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:52:47.8415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYaZL1t7a5cO5DVZpFQktjM38FRHU0O2v8wTCgZbUyS9+3yz7Lii7UMMbKgMbKlfFAOxhLXvE7dk809lZlrQjh5M+HrWzzDVqOMu2MIAO0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7892
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

Hi Dinesh,


On 11/3/2026 1:01 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> By using the handoff COMBOPHY selection data [BIT 16], we can determine
> whether the combophy used for SDMMC or NAND. The DFISEL configured for
> SDMMC if the handoff COMBOPHY sel [BIT 16] selected for SDMMC.
> This ensures that the appropriate PHY interface is enabled during
> early boot based on handoff configuration.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   .../mach-socfpga/include/mach/handoff_soc64.h    |  1 +
>   .../include/mach/system_manager_soc64.h          |  1 +
>   drivers/clk/altera/clk-agilex5.c                 | 16 ++++++++++++++++
>   3 files changed, 18 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index b8f2f73e283..39e3340f38c 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -81,6 +81,7 @@
>   #define SOC64_HANDOFF_PERI_LEN		1
>   #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
>   #define SOC64_HANDOFF_SDRAM_LEN		5
> +#define SOC64_HANDOFF_COMBOPHY_SEL_MASK	BIT(16)
>   #endif
>   
>   #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> index f768a3a55cb..f95ee6ce226 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
> @@ -18,6 +18,7 @@ void populate_sysmgr_pinmux(void);
>   #define SYSMGR_SOC64_MPU_STATUS			0x10
>   #define SYSMGR_SOC64_COMBOPHY_DFISEL		0xfc
>   #define SYSMGR_SOC64_COMBOPHY_DFISEL_SDMMC	0x1
> +#define SYSMGR_SOC64_COMBOPHY_DFISEL_NAND	0x0
>   #define SYSMGR_SOC64_NANDGRP_L3MASTER		0x34
>   #define SYSMGR_SOC64_USB0_L3MASTER		0x38
>   #define SYSMGR_SOC64_USB1_L3MASTER		0x3c
> diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
> index fb1e72ffc5c..dd999e25aec 100644
> --- a/drivers/clk/altera/clk-agilex5.c
> +++ b/drivers/clk/altera/clk-agilex5.c
> @@ -25,6 +25,9 @@
>   #include <dt-bindings/clock/agilex5-clock.h>
>   #include <wait_bit.h>
>   #include <clk-uclass.h>
> +#include <asm/arch/system_manager.h>
> +#include <asm/arch/system_manager_soc64.h>
> +#include <asm/arch/firewall.h>


#include <asm/arch/firewall.h> does not appear to be used by this file 
after the change. Please drop it unless a follow-up hunk needs it.


>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -244,10 +247,15 @@ static void clk_basic_init(struct udevice *dev,
>   	struct socfpga_clk_plat *plat = dev_get_plat(dev);
>   	u32 vcocalib;
>   	uintptr_t base_addr = (uintptr_t)plat->regs;
> +	u32 len = SOC64_HANDOFF_PERI_LEN;
> +	u32 handoff_table[len];


u32 handoff_table[SOC64_HANDOFF_PERI_LEN]; is preferred to avoid 
variable-length array

>   
>   	if (!cfg)
>   		return;
>   
> +	/* Read handoff for PWRGATE configuration */


The new socfpga_handoff_read() is described as “Read handoff for PWRGATE 
configuration”, but handoff_table[] is only used for COMBOPHY / 
SYSMGR_SOC64_COMBOPHY_DFISEL selection. Please update or remove that 
comment so it reflects the actual purpose (PERI handoff word used for 
COMBOPHY select bit).


> +	socfpga_handoff_read((void *)SOC64_HANDOFF_PERI, handoff_table, len);


Update len with SOC64_HANDOFF_PERI_LEN

[...]


Best regards,

Tien Fong

