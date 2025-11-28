Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2DFCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 08:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930D383B9B;
	Fri, 28 Nov 2025 09:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P2epe8DK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4782983F87; Fri, 28 Nov 2025 09:10:23 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3EC283B8C
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwSokXOEFZPl0zL2wZ11Aj2Yn1sMaJvNRHaSa7YvG3oQuxHFhbiJdhvCUWdPNQuLfLXTyV758MbdHuoBTOHRDbUeCqAo6VpQLoIrulvLUE1/Eo3yUjx4xsJSw/6skn/lFG2xT3bEma5/v1Jx77LfWx1RUkRIE7gInaQSxko6jH59deVF2S/0Yntky2B070De4ovBH5bextrUiHU4aCC2WQ9OBTacMJrVK39VgUeVZTr72GLD4FdxGKybCON0W5sPuv+o1giF2QN8fvaV0+NQaaTNslnTE2Owq+r+D9O5albhDFTyC7qK5ebjlNWuk63HMsP4r94Ts3U9LPjlOhF7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwUpr6WCL24ZphM8/o7aZzy+caL7cXe0qk+I2kuQdaI=;
 b=GeuhVXA57JY2PyW1lXh/k0cAYo9y+B0XRKXiLAvVbrXMCmw3fqc0H3JdoKyMKdgBrO7BGWOqwG+3CphEcGmnS/TLZvfvB3hHnDCsrtPjY9jV3tteiG9fP2qpXlh7DLllmwPcgVsaWZ+L5OPDOdUy1vk7aewJaHOdYQYVSrDPigZa6krubQ9XegwqOhKwg2ZO3BRA2A/yNWI6ZNwaEy8SmXKnFpbxjKm0Shx2Qc5ljNzH8KCktgHweuSjBjoP8u1Zuiu9KeXXraOse17I/A5D27azLCuG5eyUUcen2mbRkWl+4HYLBwxOJ/KyeZQJZdgFGIrYkAF6q4aiuA5yp0FDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwUpr6WCL24ZphM8/o7aZzy+caL7cXe0qk+I2kuQdaI=;
 b=P2epe8DKbpCc8Qjghl5ENOIawyj62td7bHdYjDbRG/6Fjv63J0BjXMDHLHa68BxLqOfwsyuteAvg3rolkdJ7/2CKyCgSTsUgJsW+c4HQJ+uh8CeahxQv/vHsOsJQs7lnnjfo4H4GjGy0QBfHo3pllSCbBASEAtIUGoHLLbbC0cA=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by MW4PR10MB6512.namprd10.prod.outlook.com (2603:10b6:303:22d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 08:10:17 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::b) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 08:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 08:10:15 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 02:10:11 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 02:10:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 02:10:11 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38] (may
 be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AS8A9MF028687;
 Fri, 28 Nov 2025 02:10:09 -0600
Message-ID: <5b3385ee-e96c-4879-b01b-74ca132d853b@ti.com>
Date: Fri, 28 Nov 2025 13:40:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20251128064353.1295063-1-b-padhi@ti.com>
 <20251128064353.1295063-2-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251128064353.1295063-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW4PR10MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faf2a80-01fa-4172-a1d0-08de2e558ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVI0Ynh2aXlTY1pHY0xxVE9Jb1Y4NGluaytyTlpkc0ZIY1JLMmZtQVNLeTdV?=
 =?utf-8?B?eUt2elJWWXZkQ3FjUVVmM0paTTR5bnVPQ2NKL3VackE2RE5WYWJxNXhIUlVL?=
 =?utf-8?B?bStBMnAydnBzVk96U3BYQkhPckRwNVZ2T0Z6aGdoN3ZjYzdrU1ArVWZxS0E2?=
 =?utf-8?B?a083MHFUcmQ3Mi9xRit0K2FqNkI0OUVNVzZsdXBiZC9mU05zK2hrUjNXR3po?=
 =?utf-8?B?b255SmVCcjNkVS9PZ3dUUy9hQURjTzJPbWljV3EvcEZ4VWEvdTk1bHdKRUVY?=
 =?utf-8?B?c0gvQUliVndxVExqT2RvWUxYR0h3eVJCVVZSMUVJMXJnaUtwV3QvRmgrZ1Ny?=
 =?utf-8?B?elN4bXdhQ3hNYzVRTXR2N0NyZjRPc3NnN05tQXVtY0ZOUnRhSnRUZ2cyUk4r?=
 =?utf-8?B?TWUydVdCSndaSTZJLzFaOWNFUlJDbEZYcU11cUs0V2NMTzJPYTNXeTB0V3Jr?=
 =?utf-8?B?ZTA2Q3owaHZFY2tUNVprRGZUVCtHM2hCUVFjUjJYWHd0cFIrUnJJTWcrZnBt?=
 =?utf-8?B?dktGUHQvN1pRRzAxRVU5d3Z4Q2NoSWVJUG1JeVhVTkZURXRuckdvNUl6bUdK?=
 =?utf-8?B?L1BRMTFJY0QxNk9kRnQ0UWhwc3RQWUVncUVGZkRqeGxTaDhmNy9wQ2cxMUJl?=
 =?utf-8?B?SUNtdnIzeUREeWFnbTlDQjNCM3U1Ym1kMnpXSzNSVEZ2S2FhUVNvTTFoMHZU?=
 =?utf-8?B?cDdHLy9ZOXBCMTZNZHBvWENyVHBXb2VvSCsrN3l5MGs0bmdWSitHUlNOYjlh?=
 =?utf-8?B?MW1LNWZINVZwekF3cWlleEcxbS8zSVoyRFlUdjQyZmY0cWM4V0UzWXUvS2ZW?=
 =?utf-8?B?TDhWVVFONFdUZnYxNlB2dHZPUnpZRTJJWWFpbkJTNEZWOGFSYmMwdE9ScXBt?=
 =?utf-8?B?eVdhemx0M0x1NVNjdDA0NTlHUXhDbVdaWXlVWEwxcElSa3k1Uy9NUFM1b0pF?=
 =?utf-8?B?S1VjKzJDcU44enUyc2NXd0lzVndkeWpGTGhRdFhpam41M1VGSSsxQk9TeFRG?=
 =?utf-8?B?VVRaUks1NlNsbjFsR1hVdlAvTXZzZmdzQUZmYi9vTmQrS1RuNWRwMUJOUnFl?=
 =?utf-8?B?RmNWMnFORkp2bWg3SE1FVFExN3VEWGJ0eUwxYlFRQ0s4VDJzNU8xYUdoWDY5?=
 =?utf-8?B?KzJTZTRHalBIdU4xUHRINTJGbjNsT0FtVkZtMlJJMStiN2Nza0Qxcmw3cXRF?=
 =?utf-8?B?SUxlYkpvU0Y1Y3dpcG55OENLb2M0cnBveFBoUUZhVGVUa2JoVUVNUW9NOE53?=
 =?utf-8?B?c3d6TnN5V0hlUnQvYjcySE92aVliektCdDhMN2hqQm9iYXljWEUzRHZVZlhX?=
 =?utf-8?B?OG96TUdJdFNJbG1rRzdSN0VJQnZBQ3YzMVlQSG9NOHdKSzBjaHM3WjNSckJn?=
 =?utf-8?B?OWRHKytSb05nSEVLdW9qNFlEckQycHBFR2ZMSEZ0N0k2R1lhWGJmU1VEZ3BT?=
 =?utf-8?B?NHZvNkcwcHZ4eGx1RFRWR01KbDhJeWFNYzBqTVNYVFR4MEVHMUJtNUVjZ1Yx?=
 =?utf-8?B?bW9Tc1o1emlLZHRSQnNLdCtrWjExNVJnS1dMQW1aaVZxcjltZ3lBa0crTFE5?=
 =?utf-8?B?NmJ1YkhmTnM1eWdkVGtubDd0MHRMYzdXbnB6R1JYSitSeGtOWklFT21iZktu?=
 =?utf-8?B?Q1ZHZ2E0L21YTVV2OGNGQjNCK1daN0Y2RisraSs1eVV6UVYxd005TDBTTm05?=
 =?utf-8?B?R0FPZW5xNnIzUm1lYUNsWExEMXRWcktCbVRWWGpaM2lOZlNRRVR2TzdJblJU?=
 =?utf-8?B?VXUyYy9ETEV0R0NTUnE3RnBJV1J2bjBLVkE2L0tFU2pNQjhMZU5LV0Nzd1dW?=
 =?utf-8?B?b2VKZkNmcVlUN01BWFBsblZOdEFadVQ3dnJRNmtVUUdVbWg0Yk5vOXEraCtQ?=
 =?utf-8?B?RW1RQlVwU1ZrKzUyNnB3RmtZSTdIci83NGdBRkpiMGhnQ05oRjlMNkYrdktB?=
 =?utf-8?B?MXh1N2VXWEhSSGlZeitNVnZWWWdLM25XMzNwamN6OUJMbG9QOUpKNU9oa0VW?=
 =?utf-8?B?emdRTzZPa2VDRTAySE1nMVJLK2NEVU9uU0c1Ylo1Tzg3Yi9uSkw0THRaVFBp?=
 =?utf-8?B?WVlaK0RZVlZacEVwWGpTM1JUSUR6dFQyMXIybjV3RURGN2NnV1RZRUJvRGtN?=
 =?utf-8?Q?G9U0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:10:15.4655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faf2a80-01fa-4172-a1d0-08de2e558ff8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6512
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


On 11/28/2025 12:13 PM, Beleswar Padhi wrote:
> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 0x2500000 is used by PPA and is firewalled. This results in an

0x2500000 to 37MB

> exception and the boot fails.
>
> Introduce a new defconfig for AM571x HS platforms and set
> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 0x2600000 memory (aligned to
> 2MB as per page size for ARM32) for the same.

0x2600000 to 38MB

>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   configs/am571x_hs_evm_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 configs/am571x_hs_evm_defconfig
>
> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
> new file mode 100644
> index 00000000000..7e44ee5221a
> --- /dev/null
> +++ b/configs/am571x_hs_evm_defconfig
> @@ -0,0 +1,3 @@
> +#include <configs/am57xx_hs_evm_defconfig>
> +
> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
