Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA93D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 12:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BF8838CE;
	Tue,  9 Dec 2025 13:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dxn0LqeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 593F583B81; Tue,  9 Dec 2025 13:26:49 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FE582BF2
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 13:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX1tdjav4ng8AXKAzIhNdUYUih+tP/kWBkPq/Q89J4LFhlelEKCWO0IvizSprPcNLtUpwzz8DVHOZyVrLMjpl9639w5qCK+yCotFnraDI4lynkInJUbuJB2FapQ7rF6OI/LHEO83ZMe32SPSmFeCzBORyfwafokKq+8tQIN5pdv/QOZ3G1xsePRgySpIxeD7twO5M/Zjnq2B1/8mi47t3Qk+Z5PI0vyN2pKND2LbE8r30TbnP3rxRyr3XvBpZEyZTjFbcTTRhiF7AqQTfPPnASabU6dvHt5QDHa+b+1Mpj9yp7eqokOh3aLp/GY71vsmEXDHqlKoxVyuagvqqwLsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWF/Cyo+aNZ8SByI5VWyh1wa4tsvr8pv6/9d0m2LhpQ=;
 b=efEUoJOOC+PM0MTR9blWQfbKtBLrEgj0DjwLxZ66HjXMJLXlwoxqBWz3Ouv70RCQICJOVrSQ6yj3vrXYpCkzhQDR2Fec7JIYcNVyDmJyb6dayBMIjk7s5HT+VY33xFXUO4Fk/jsYcrfPlQVxoQ5b8vi5crozkTnHJEaTmsoB5225rZ48zy1oQJf4IFxylJ/o9dCJ+hRusxazubzkudT9ospHQQvjBHawlPyAoCIgxAB5JA4yvkfMRgDxoxPxNSB0UQFbFV0pNRT+SLLcHdO+clAdoYeWyEI0GcSFOKprAEp30dhjw4wC5tirPX2fFBEkfH1NAaONfhmFlzNqxGbJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWF/Cyo+aNZ8SByI5VWyh1wa4tsvr8pv6/9d0m2LhpQ=;
 b=dxn0LqeVE9RudkG2GY+aL7DfgrMma64BBx3A42d4SqADG8sSGF+uqla9xGukSg4GxVDvevHsKPCS/OTKjy+QnybI6cqbcz20fBBrpkchN3k8C+mYfnljyxwT4D69C/ZTlmBhpDyIv9XXEKeNtYEDgeb4kbvFIUpAC+BFAmMRJwI=
Received: from BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18)
 by SJ0PR10MB6421.namprd10.prod.outlook.com (2603:10b6:a03:44b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:26:42 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::89) by BY5PR13CA0005.outlook.office365.com
 (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:26:42 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:26:36 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 06:26:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 06:26:36 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B9CQahO1191288;
 Tue, 9 Dec 2025 06:26:36 -0600
Date: Tue, 9 Dec 2025 06:26:36 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/4] configs: Remove default malloc length for K3 R5 SPL
Message-ID: <20251209122636.ae2w56zr3edsalye@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251208190635.2044082-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251208190635.2044082-1-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ0PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dd8f5e-8816-4b23-ca32-08de371e3605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFRlY0hheDlxL1loY250STRrN3hZSXc0eFJTdFMrQklQMVc3cThsWnlZVzZK?=
 =?utf-8?B?R0I2L3g3ZGxKRit0RUdlYVdYWWhIT1FCbklhSm45UzBtOHYzdFdKcU92c0dl?=
 =?utf-8?B?QTJ2WG5yUXVES2dHYkpHUUNic3pIVmcrOEw5NmV2cWdtaWRVajBMYlRFN3lC?=
 =?utf-8?B?VS84YUYxeXJMdUk0amNwbURoVHBIUlJwQjNvWWpTSEpyL09hUk01WTBqWEJH?=
 =?utf-8?B?U09yTXlHK3VZaTlxdE9rV2YzWDJFVXM4QWZodWtiM1YzZ25iSytpS2R6K0Z2?=
 =?utf-8?B?cXhKR3RiYyttSnJCQUplYXFLcnJRSExsTHp1N1NQWklMSXBQdFh3MDE0dWxY?=
 =?utf-8?B?VFpzRjBQSFM4T2tmWlY2MzRHa0J4aXlBOWJWQkJrL3lmM09mVTF0cWtGUHl1?=
 =?utf-8?B?Zmw2WUhXdnhzTmp5KzJnNUllYlpQazVxK3IwNHFpWnRLNmNZNFVFWmtpR0hJ?=
 =?utf-8?B?TTZzNWVvamJ0aGhJMERzdkJXcHpCWGpTeXdoWHdRN24zelErWk1CcEZielFK?=
 =?utf-8?B?czZOcTU4a2doN3RvNjBaYlE5ZEdzUk5LZ2Zoc0FjWmh2R2l4RFBMemN0Z2N4?=
 =?utf-8?B?N0UxR1VJdENQVENUMkpoVnlEWHVMc2lZMkc5blJwVEVDU1JVNjI2Zi9RemVP?=
 =?utf-8?B?Zk9iTFk3RERmVjJsc3ROZWtCY1c2ZmFhRUpWelcxRzlSZVV4YmpkYWtrdDdr?=
 =?utf-8?B?Q1oveFhqZmdvSDUySG5PQnZsdTREVERtdDRHTmJ4V0tteXhBekx2TUpaVUps?=
 =?utf-8?B?SHA4Y3Uyenl2Q3FlVDMzK1NhTHJOcjBMR0kxQitFa0p0ZWJJLzN0aWhiZ0JL?=
 =?utf-8?B?aEdWNjBJQTJTMnpxS1N5WENDMWhIQ0JCekF6SE5xbSt3RGE1bGpHeDJIRUZE?=
 =?utf-8?B?YmhRRldGQkVvUWNyakxydGk0Tld4M3ZMWnRwVitUemYrUlVMWjBhNTBEZXky?=
 =?utf-8?B?Wm1kMTlLajJyWE8zRlE4SXpzdnNSMW1UdUxlaWNtTmFmL01CVytkUHBXZTFY?=
 =?utf-8?B?eG44eEtIOGF0MmJaNmFtcHRVWWlCdTZFSzFLdzdrOVRCRW1PQUk1SWZ6Qkgv?=
 =?utf-8?B?QWdsRjdEQTVNdGc0N3BRLzdVNGd5UXVMYW56ZU5ybHJiZlF4Tmcwd1ppRE9h?=
 =?utf-8?B?NzRTbFc2THNOUDl1MzE1OUJHMnVJN2NlUlN2QWplVTlVNzQ5Tnowb2hqOVBk?=
 =?utf-8?B?bjJjSTlYS2JYM0FxSnNYT29aUkkvREpyU0l3eERNK1REKzM0cmhkWUlvZ0RU?=
 =?utf-8?B?eWhIb0VIVGY3OUVHUG14TG9vMmxSSmRCYzROVUZ3eDhGeDV3Y1M1ZHhreHVm?=
 =?utf-8?B?SEpuam9nUllzK0cwMnhPOXhLSEo2UFZsRW1CMjUzNEtMenF3Y2VsUmdmRXAx?=
 =?utf-8?B?aWgxMElUcWREc3FUY1A3WmVRWTVMcHlZUlRyazhZeEQ0bU9teUM3UytQQnBB?=
 =?utf-8?B?YnBpUHEvbHNkMC91VVNOUUJyL1k1WU9BMnJGb3MzTEREaVlONlUvZ1BOUTV2?=
 =?utf-8?B?dEttaWdPbU1YV0xkNWxmZ3FibUJUN1Mwc0M4N3NKeUVMOWlHUVZXaW5USE9G?=
 =?utf-8?B?dFNFeTJBUlIvakwxUVRNS0tSekR4YS9Ed0xJWFh0RWxjbnV1eWtCTXRTSVdi?=
 =?utf-8?B?LytFeUFHem9LWjc3bW16SDJ2RjA3RjE4V3F3b0JUelhqQU4xU1FIQnpRMUh3?=
 =?utf-8?B?SThPbExSL1p3THFLMEJFeFZZdUtSb2VOZUJkQVNUN0VsNlNCVHJCb0d6Z1Na?=
 =?utf-8?B?b0lrOFVIZDlqWmNTYTh6anlxOFMyL2FuYmlBS0hRbTBFY3ExeUJPODFabVly?=
 =?utf-8?B?c3NDUVltOTJlWGVCdVlWWm5xWFRJN3hoQms3VWdtMGJid3ZOT3cwYlBzcGhS?=
 =?utf-8?B?aW51Y04zcWJRMGFWYkdXaEtySUdLUnpiMzc2TEhvQ3oxS2QzbGg3SDZyanVZ?=
 =?utf-8?B?VnBWRkdxRHJmZzcwSXVCK1ZxRlRLbHFoblhXZm1CZ0E2QXd2NGZWNFUrWEpD?=
 =?utf-8?B?bGxob0FyRzBrRXFmWjJXWXd5cTdLd3dyY1VJRmM3TktTeU4xV05HSWV5dzVU?=
 =?utf-8?B?WFpDMS9JdENmKytsc3VhNlk5ZnphQ0ZsbHdXQ29NN29yaFA5YlNwZHlWbXFB?=
 =?utf-8?Q?DEDA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:26:42.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dd8f5e-8816-4b23-ca32-08de371e3605
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6421
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

On December  8, 2025 thus sayeth Andrew Davis:
> These values are already the default, remove them from these defconfigs.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  configs/am62x_evm_r5_ethboot_defconfig      | 1 -
>  configs/j722s_evm_r5_ethboot_defconfig      | 1 -
>  configs/phycore_am62ax_r5_ethboot_defconfig | 1 -
>  configs/phycore_am62x_r5_ethboot_defconfig  | 1 -
>  4 files changed, 4 deletions(-)
> 

Nice!

Yeah the preprocessor step these need confuses savedefconfig which is 
probably why these never get the syncs like the base defconfigs. I'll 
make a note about this issue.

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

> diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_evm_r5_ethboot_defconfig
> index 5ad4d3f0e5c..c97c4e28fbe 100644
> --- a/configs/am62x_evm_r5_ethboot_defconfig
> +++ b/configs/am62x_evm_r5_ethboot_defconfig
> @@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICEC_TREE="k3-am625-r5-sk"
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_MMC=n
>  CONFIG_SPL_BOARD_INIT=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>  CONFIG_SPL_BSS_MAX_SIZE=0x3100
>  CONFIG_SPL_DMA=y
>  CONFIG_SPL_ENV_SUPPORT=y
> diff --git a/configs/j722s_evm_r5_ethboot_defconfig b/configs/j722s_evm_r5_ethboot_defconfig
> index fd58485bff2..68237f7d8c3 100644
> --- a/configs/j722s_evm_r5_ethboot_defconfig
> +++ b/configs/j722s_evm_r5_ethboot_defconfig
> @@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-j722s-r5-evm"
>  CONFIG_NET=y
>  CONFIG_SPL_DRIVERS_MISC=y
>  CONFIG_SPL_BOARD_INIT=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>  CONFIG_SPL_DMA=y
>  CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_ETH=y
> diff --git a/configs/phycore_am62ax_r5_ethboot_defconfig b/configs/phycore_am62ax_r5_ethboot_defconfig
> index 81a7f5b0784..526d15a0dc5 100644
> --- a/configs/phycore_am62ax_r5_ethboot_defconfig
> +++ b/configs/phycore_am62ax_r5_ethboot_defconfig
> @@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-phycore-som-2gb"
>  
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_BOARD_INIT=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>  CONFIG_SPL_BSS_MAX_SIZE=0x3100
>  CONFIG_SPL_DMA=y
>  CONFIG_SPL_ENV_SUPPORT=y
> diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
> index 3bc426821e9..92dd0be647e 100644
> --- a/configs/phycore_am62x_r5_ethboot_defconfig
> +++ b/configs/phycore_am62x_r5_ethboot_defconfig
> @@ -8,7 +8,6 @@ CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-phycore-som-2gb"
>  
>  CONFIG_SPL_GPIO=y
>  CONFIG_SPL_BOARD_INIT=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>  CONFIG_SPL_DMA=y
>  CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_ETH=y
> -- 
> 2.39.2
> 
