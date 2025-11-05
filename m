Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FACCCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D5C83AA4;
	Wed,  5 Nov 2025 17:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KhoO70qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD1E83AA7; Wed,  5 Nov 2025 17:19:04 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d902::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36E383A9F
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDGXC7otr+qWL9VnnowTJBM94IyAHyH4o1tZYDo1M8ujmfpBDBp1C9WVk+MxTUs8JqMotLaoCgtpDBeQKL7rBw/rw/Czcmf6PvxBfdoXYcC81RBbUX7eUPCQfU6Ju4bXazIVXlsyrVEHlkp6dXrN2mX+D7B89ks49F/9LK+csG9Y1GyeNH5PUsUxTz6lgjba/Encz0QFihTNb+cNAIR6xKv71yIBgddgtpwjA8HpvQAliwluz+hKuuvpYIYmq5cwpF6hAue2uafFn73CkvmZU94SNOLp6aqP202J3zhjdIkKryw/IrP4Sl56nlxVD8Lq48+3Yn3t/MG2b71/c4+kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwvK+h+d6+j7AWecPtFk+ogy923/DFTTkYpxRr+CQKQ=;
 b=j1yVFv7DZMjxRNcm0SH2Y89OtLqMHuvLiF4pX19baFsBaEQsywuDteslmkbFxcZxhEf2tNv6Y4+5P588eWMtKdsq0xKLzbS6BEbUNYtpunPZEbUEBFBIamribP7ZvNE2aQOaUNxGk4RGxq0QA64Re+z28AcVSmY5UYBkNWaETYuA2C0C7S46qJuWHwHCg9u6DiB2TFftqPq2hltnTJWOFpbL9K5tPs0zh6vmreNI0Qztxe7bnkfeGKyWBdD97NfrLL9TtCp8M4JHv0XWUWzqXqVK+c8BLc2WazqHAQ+eRwGetHnzjefk9T8Nd+av53/MmXns0LIFUaFTvtKVHPmLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwvK+h+d6+j7AWecPtFk+ogy923/DFTTkYpxRr+CQKQ=;
 b=KhoO70qJBBdTQVKQA08+tGJIoVkW7/q4/L4QxvmxPomtMg1qyaURYvXzY7moBpFd5N6AwIy7DxHs1FjRSe9Ja2qt1qkK8ErZESi3TxsHwQrZRzb4wX2+oGQxAk+b0cWm8NPJi4Y18lfLj41gIfQNMqcgwSU0aFRNPoLGNZGalII=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by CH0PR10MB5130.namprd10.prod.outlook.com (2603:10b6:610:cb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 16:18:56 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::ae) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Wed,
 5 Nov 2025 16:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:18:56 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:18:50 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:18:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:18:50 -0600
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GIkGx3988801;
 Wed, 5 Nov 2025 10:18:46 -0600
Message-ID: <9875f311-a65e-45be-993a-c57aca808268@ti.com>
Date: Wed, 5 Nov 2025 21:48:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Refactor tidss_drv and enable early splash on AM625
To: swamiljain <swamil.jain2016@gmail.com>, <devarsht@ti.com>,
 <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20251105161437.4064391-1-swamil.jain2016@gmail.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20251105161437.4064391-1-swamil.jain2016@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CH0PR10MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d94c6d8-4d6c-441d-500f-08de1c8704e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|1800799024|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjdZVHRMWTZtM3liUTgzU3ZjcUpSWTEyd3h1T3JwNzFXOWwzY3hhejgwdmRD?=
 =?utf-8?B?SE5pZUxDdGdjQ2pUSjBKRE1ueml1ZGM5OGJiYUxHd2ZvMzU2UzFOK0lZOER6?=
 =?utf-8?B?VzhNRUhOcVRwTGoxNXB1RXVEMUJGUGI4YnQwUCtvZE1MQjEySmltQUNzMW5y?=
 =?utf-8?B?aGJENy9yWGZSVk51eUpKYkNkcHl3ZkdQaWVjRU1lTzJoN1hQbVpyN2FKNzBM?=
 =?utf-8?B?OXo5Y240SUlVTGhxb3hVWUljc3k0cUxkR0phVm1IMEttbFZCUE1VYXk1aUVH?=
 =?utf-8?B?SldJWmlPc2xicGgybkVxNmYyQ3k4bWFmUnhKQzd3ZlZsNUxVc2cvVmdQWEFl?=
 =?utf-8?B?ZEVidHFXR1dCSVNvTWErNXU0VWVMc3Yrb2xDVE8yL1VnMzlvTTdNYUJoT1ZQ?=
 =?utf-8?B?RlgyeEJocDM3S1piVDh4cG9BblJTcjRrQlFpWlovc2xHOXZqNUpiZ2RjYllh?=
 =?utf-8?B?UDdRdUhSM0dQZG5EUk9YVXZYT1JtbDgwNDJpVW5GMHd6eFVKMHZTVENYWWI3?=
 =?utf-8?B?L21kb29OYXBwVTJQR01JSkt2SjdUUWlNWkxQME16THM5UGhkN3N4RTB2dkk2?=
 =?utf-8?B?TmQ0QVRTQjNGdm1RYUltRGFpVi9KKzU4QXNydTNzMzRsLzZxdzZ4QzNrY1FX?=
 =?utf-8?B?eHhqbWFOdnhoUjgxV3YyOWxUb21tRVhFaG1jcWJRWko2VmxvRjBqMWZiMWd2?=
 =?utf-8?B?MzY4ZjlZQWtMd1JiUVhiNDVCUE5kUDRjN3NZVTgxTWxEMk1HUnJBMm8xbmRC?=
 =?utf-8?B?QUNlUTBueGZVamh4VkRUZ1hxbnFWLzd5cTNlcnBtOXdmRm9zUGU1SHBaV3kw?=
 =?utf-8?B?RHJYQUJZZHdhRmVZYXVSYVFqRDFVRllzUWFvNXdwWCsxY3JrV3BnUUkwcnJ0?=
 =?utf-8?B?dG93UjVZVTBnSGhPWlo1QmJrL2JYVmxsRnRJQzBmRCs1TDBQTy9XYWZkNnVi?=
 =?utf-8?B?WEhmVmtHeDFwMkd2SFlDa09GRHdBYU5Qa3Q4eVJEeVE2QXpCM3pSS0ZHNFBW?=
 =?utf-8?B?RmRoNU56akh2TGI4TTRaYU04T2xjVG94ZVlxdk1OS2I2Uk9kWkcyU0tteGlT?=
 =?utf-8?B?STQ0S0lNdFEwN3RvcEJjVHZMNmllWk9oZXJzcGFTL0VZaXFaSDZmZmxBK2tI?=
 =?utf-8?B?VXltLzVtZVhlTy8yWnBMUmlrREdGaEREQVcvNG5sVWcwc1BMMC85QVJLTTll?=
 =?utf-8?B?SHJ4SWlYc1FuemRtYzJtZjFLMWxSR0RQUU9UNkdiSm0zZGpLUS9pWFliU0hu?=
 =?utf-8?B?T2RwZVJ2L2M1ODVtejJYTTVvd3QvRnN5QkhoMDBjU203WFE5eDlVZ09WZGVK?=
 =?utf-8?B?K08yVVlENjE3bWhOV3prMWJqSncyQ0NJQjZzUmg0U29TOVlQK0FyRWxsZnhs?=
 =?utf-8?B?Ym1hbDV1eWRNK3JDUnd6TGVrUkxvOHN1ZmlnTHhGcGJmK1pINCtyZXprNmU0?=
 =?utf-8?B?dVZiYVBQdkZTZmovTyticWVLaHBZa0JCV2RpRGNzNHRCdFNrRlNrY1g4YWpU?=
 =?utf-8?B?UG4vSlJ6VjB2VHozcGhUVkdrdnRiUTYyNGdLbUVoWlJJMGFyWmRnRFQvQjFq?=
 =?utf-8?B?QnZrZzc4WFl4SDE5WWxkUWxYaHFxTE5PZDg2aHZBRXhHekhJNTdZbmpQeEFX?=
 =?utf-8?B?eEhnais5a2ErbGhwZ1BsR1VqWWw5NysyQlpDLzA0WGxVRU1HMGdFS3IwYVJW?=
 =?utf-8?B?NlNuMnFuQ2xQME1pZGdLUllNQmRvdkxEckFpNGRmTnBqQk1UcVJ3KzQ3U3Qy?=
 =?utf-8?B?Q1BXWHo5eG1qTmxKY1E1ek55YkRvbUJ5RXRJTzZaSm9WVHBhcUVGUjJPdm1D?=
 =?utf-8?B?S3F2M1UrcFNmSk0zLzB0ZHp4bkFUbkZTb1J4RmJtaGlyU21MdkduazRJMUFk?=
 =?utf-8?B?V0lnZVV4MEFHckhaT2lwVWpJUjNsTFN4aitrUEdOQVZHeTBUWENKN051UzlL?=
 =?utf-8?B?cmp0clFOa0QxVjdHcWFHeGZsVVh0c05NaHVxTW1rVS9lS2ppWm12NDlleFdm?=
 =?utf-8?B?cUJXeS92a1d5UkRnQ0MwbU5mMkkxdnpVZExDa2MzMlVVa3VibzEzQUYxUkM4?=
 =?utf-8?B?VlJBbDJGUStpRCt0Ym1sdG4yaDhRbjEwQVkrUlVtUHhueGJuOHJpK05XYm1K?=
 =?utf-8?Q?ZKhY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(1800799024)(36860700013)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:18:56.0706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d94c6d8-4d6c-441d-500f-08de1c8704e3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5130
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

Hi All,

On 11/5/25 21:44, swamiljain wrote:
> - Refactor tidss_drv
> - Add am62x_a53_splashscreen.config to enable splashscreen at u-boot
>    SPL
> 
> Note:
> - As OLDI specific changes are in progress to be synced to upstream DT,
> use this[1] branch to enable SD-MMC splash on AM62X. Upstream DT changes
> can be found here[2][3].
> - Use TI logo file(ti_logo_414x97_32bpp.bmp.gz) from this link[4].
> 
> [1]: https://github.com/swamiljain/u-boot/tree/v3_splash_final
> [2]: https://lore.kernel.org/all/20250913064205.4152249-1-s-jain1@ti.com/
> [3]: https://lore.kernel.org/all/20251017115325.1942591-2-s-jain1@ti.com/
> [4]: https://github.com/swamiljain/ti-splash-logo/blob/main/ti_logo_414x97_32bpp.bmp.gz
> ---

Please ignore this series, will be resending v3.

Regards,
Swamil

> Changelog v2->v3:
> - Add splashscreen.config fragment to enable splashscreen
> - Align OLDI mode detection logic with kernel side upstreamed OLDI
>    series[1]
> - Address styling issue mentioned by Devarsh
> - Pick up R-by tag for PATCH 1/2
>                                                                          
> Link to v2:
> https://lore.kernel.org/all/20250725043012.1186886-1-s-jain1@ti.com/
>                                                                          
> Changelog v1->v2
> - Iterate through all available OLDIs
> - Move dss_oldi_tx_power from tidss_drv.c to tidss_oldi.c
> - Rename tidss_attach_active_panel to a more generic name
> - To handle all active hw video ports, add an array for active hw vps
> - Iterate through all active hw vps to enable respective clks
>                                                                          
> Link to v1: https://lore.kernel.org/u-boot/20250603105735.4038240-1-s-jain1@ti.com/
> ---
> 
> Devarsh Thakkar (1):
>    configs: am62x_evm_a53_defconfig: Enable A53 splashscreen at u-boot
>      SPL
> 
> Swamil Jain (1):
>    drivers: video: tidss: Refactor tidss_drv
> 
>   configs/am62x_a53_splashscreen.config |  16 ++
>   configs/am62x_evm_a53_defconfig       |   4 +-
>   drivers/video/tidss/Makefile          |   2 +-
>   drivers/video/tidss/tidss_drv.c       | 235 +++++++++++------
>   drivers/video/tidss/tidss_drv.h       |  40 ++-
>   drivers/video/tidss/tidss_oldi.c      | 364 ++++++++++++++++++++++++++
>   drivers/video/tidss/tidss_oldi.h      |  72 +++++
>   drivers/video/tidss/tidss_regs.h      |  21 --
>   8 files changed, 631 insertions(+), 123 deletions(-)
>   create mode 100644 configs/am62x_a53_splashscreen.config
>   create mode 100644 drivers/video/tidss/tidss_oldi.c
>   create mode 100644 drivers/video/tidss/tidss_oldi.h
> 

