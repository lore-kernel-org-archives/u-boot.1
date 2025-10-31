Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B42CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E95B83642;
	Fri, 31 Oct 2025 10:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WLRuwSgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E09A838AE; Fri, 31 Oct 2025 10:30:42 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E128331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIUVmlAG6B+CwX1zicpfVEvjwBTrO0CcoezHrD8hbxdxOsc/bUCLO9YzL561cWo7SPI6oVvhFa19WU4AOh6/babzXvfGeH18fCJ/T5Ag1FXRW2LrApeoJADQ+2Uf8f1J2L/tuy4G7ZY5HnMYQTszFxqW4e5JBT8sE1DrXu/v2Ouq6ktOfYX6iB6/2k5dwSX5GxaWkHFxipL612/76VSQEvLsKE8EUt2DmzYlJlOt0/ohG9pQw6XBsZ7CPrSJkJ2yVHrv9zgtLsk4JuWXQb9ESV8mPUu8IR0IXelZHhU8m5FRT1lHrAi4uv7LSCboRbpB0uB31FG9wCLtEw973mGMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHhgsgDKKfY3hr+195JU2Xkm9PShjVGpcBCqCn+m8O8=;
 b=iJb3Rb7evVIUfSUuOcmESQdYQfetjE0LNWDHnEwJdGydAqp7rI/h8PyNsY/gV0XfPBl//olB10PyBgc5okGQRI0T7c1QFhgnkNpeddONp/8e4RX3rhBNhcqANUGVFufI2+jk9zVuCnxv+vS0Y2nuoCGo4UnqlaQynyTNYAEgVNMjaHPmkwQd48Zupi6wGx+j8pRds+aHh/sVBkXBK77D2i+V7PVn3WVKlr6lT4ywKQVdJ9kC0QW2H8Tu5vFKd9ie2QtU/OdZVnneN/isfdiFPi0REv7xtyjOtfYvJR9aTaVaJwcDTUUDWFW2wZSb9CLzJCUV6XVKpPbAxwfJO+BSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHhgsgDKKfY3hr+195JU2Xkm9PShjVGpcBCqCn+m8O8=;
 b=WLRuwSgqGU8ISR5Zd70vUZCK1qL4kn9oXvCQLUBBrY1QfieK8r2jB4fywpstQFu3kUOY0UFTRuK4ZHqcqvpdbeBJShQ7ReauRKR9QBx2w+b3l69bKtiKXvY/bVbrQJsYRvRwrFZ3Cj2UWAmqZnLMqfWtcVKQ59Ur+2ln/3NfZ7c=
Received: from MN2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:208:1b4::30)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 09:30:36 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::6c) by MN2PR15CA0017.outlook.office365.com
 (2603:10b6:208:1b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 09:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:30:33 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:30:24 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:30:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 04:30:24 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V9ULuZ3690975;
 Fri, 31 Oct 2025 04:30:21 -0500
Message-ID: <ca2a5898-f1a8-4704-9c53-e2ec3bdbfcf4@ti.com>
Date: Fri, 31 Oct 2025 15:00:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: dts: k3-j721s2: ddr: Update to v0.12.0 of DDR
 config tool
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251031053425.3960963-3-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ0PR10MB4766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b04881b-66ca-432b-303a-08de18602445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzV3Q0g1MURVTjJFekorZDZVWmFQd1dYdjE1NTVEWkpmV3Btb0Y5aUJVYXJH?=
 =?utf-8?B?QmZEaUVoRTcwM2h6L1lrYWZBUUgzL0szYmhVUEF4RUZhK3lNY0d2ckVmaDk5?=
 =?utf-8?B?ak4rZ1EwbzIwRXZLOUZua1ZEd1IvNm9Ka0dhTkhqSmhyRnpaMEgwZ2s4UjVY?=
 =?utf-8?B?dUVwQVVDNC9UWERhYnlHZmR1WGYrVmpiUnhiYkZXOE9Id2lMcTU3ZFZuandw?=
 =?utf-8?B?VXpHc1B5MWhRMEFxWFBZTEJmRVhoM3RxUE9DMGZiRVJkeVlxTG9TRUsrZHJy?=
 =?utf-8?B?N0tlTWt4VGFkRkFYSXdnU1BrQ3RCMmhGUmNjc053K21pREl5bDlSSGU2RVVC?=
 =?utf-8?B?Rm83bmdxeVRmakJRUExNdUtBOXpHWmh2N0ZoM3lIR3ppb3VQYlpxc1FHbUFu?=
 =?utf-8?B?SzdoUXZuaTZncTRqeFVpZUVodUNJSzV1Y05CTUd2dk1xM0tRRCs0NlFkTVNu?=
 =?utf-8?B?QWNob3lzZWNFUk9iODNqWVBUSWoyYzB1aTE3Qm9YV1hLK21jWUtLSG9VZ1Zr?=
 =?utf-8?B?VVZpSUNnRVc2RVZTK21LLzBkM3ZoNTFMLzI2eThOK0NNM3hEQVpzL1hLc1NM?=
 =?utf-8?B?WlNnVDZyUEdqcEJIcmZ1K2thMzZGYlVDMjd3NDB4YjNodzZtSWhqUXFPMC9y?=
 =?utf-8?B?alpoUWJNQzR1cVlMbEllWnhZbU1WcU00cjBvclVwRU9QdlB3Vk5YSkRMeHZW?=
 =?utf-8?B?cENnaG5EOFJvSC9VbkF0bUhabnJqQ3Q4TVBEMlI2UjRvMmk4U2ZwV1BodkJi?=
 =?utf-8?B?NzJyYjZhRm9YYTVRS053bXdCMU9wa2l5cU1UU0JKUUxJN0RtdmRRbVVhZi9m?=
 =?utf-8?B?cXpBWXJFY0ZzNkhjMDNmekd3c3RxZ0M5SVdGdXQydWlYVnlma3JaN0JrNFVK?=
 =?utf-8?B?NkgzRlg2enM2cFRqS0dvbHRjblYzajRNSHg2SzF2OWp3QU5vaWpmQ0dPK3U4?=
 =?utf-8?B?WlpPdWFUbW42dTVOcWhkNFgxaFdNSWFCdDhOQU5PTUhlNWtVd2JzZ1M4SDlO?=
 =?utf-8?B?SmdFYTgrai9ZS0J1WnVmOHRQR0R6RE5qR0pQWjlZWDRuUDVxTzdTcWhMZGZv?=
 =?utf-8?B?Rm9FMW0vSG5nTk5Gb2ppTzIxTU1JM3RpMmliWXUwQWJyYVZoaDVSMGhtSDVX?=
 =?utf-8?B?ZlBSV3piTlhiRUxCdDNNVnFmQnZ2SFlSQ2p4d21hN2d4MzdYem8yRk1jdG9B?=
 =?utf-8?B?RmMwUW5QaGpiZzRHVW10K2ZQWElpRHkyZkpNSldEZTFRdU5MbDVWUUlyai80?=
 =?utf-8?B?T1UxTytSYWl6bGdxTkFNTHpvOG1GeXVBSlo0YUs4UE1kOHk5K0lEWHp3bkZu?=
 =?utf-8?B?Y29oM3dtTjRIUE9TOHhZMWQ2L0U5N0pEQ3NuaDBYZ01LS0Q5bFYvVWdZdzhk?=
 =?utf-8?B?cC9SWkxlM3dQeENXZUhkOFdHOHc0OE5kaEc0WjhUUmY0Wks1a1daaVpocm5l?=
 =?utf-8?B?L0JFYlB1K0FmSDF5Qy9KYkRENjlFdXdlQzVqVFMxWVNRb1BmWXNQaE9GMnJs?=
 =?utf-8?B?d2Z0VXFyOEsrOWlTVlMvUHZoQk53M3h0TkQwUTNXa0JjbmkzM3dsYXhQWTdV?=
 =?utf-8?B?SzFWTzJTK3NhZmw2NkRxakd0aTRvY0c2RGhqUjNTck9EbEljaDJxOEJ0U2dB?=
 =?utf-8?B?VnhZTFRlb25HbVpIZjdQR1V3aFN0MTN5STNXRnhsdmNhMVl5dTZDaXlMUHha?=
 =?utf-8?B?YjFxcWdHeU0xeHRtbmNWRkZUYm1FWTJpWnJpWmt6aG9vTmQxLytyejl2S1Nu?=
 =?utf-8?B?VzlqMVRsajk4VW56U3NJd3lsdGxDNjhhQ2pRaTZYQStoMDdkRjF2SnhHQVU3?=
 =?utf-8?B?cVp5TlQzTStER25vSnFtRjN4Y2R5aWNXZE56MEZHSjVpTTRhT3JuQUpxcXN2?=
 =?utf-8?B?Y201NFh0T1puTW1GTmIrOXhreGtKMmN4VTREbDRkQi9JYmV6Y3ozTUgyK0dq?=
 =?utf-8?B?ajJEck10b0thTkZIZTljeFY1UUkvdk5LeExJdzllUlJobTRiVWRnK1laZmNn?=
 =?utf-8?B?cVZsd0R3dTRWZVl3WHRITTZTdytOc1FubUY2NjRiV3FvQ0crUTFseUNlRnRR?=
 =?utf-8?Q?ssZxFK?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:30:33.6863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04881b-66ca-432b-303a-08de18602445
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
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


On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
> Update the DDR configuration for J721S2 according to the SysConfig
> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> is [0].
>
> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi | 591 ++++++++++---------
>   1 file changed, 307 insertions(+), 284 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
> index c91576bf093..ecd42b1cf4d 100644
> --- a/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
> +++ b/arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi
> @@ -1,11 +1,23 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
> - * This file was generated by the Jacinto7_DDRSS_RegConfigTool, Revision: 0.7.0
> - * This file was generated on 10/14/2021
> - */
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + * This file was generated with the following tool revisions:
> + *     - SysConfig: Revision 1.25.0+4268
> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> + * This file was generated on Thu Oct 30 2025 14:46:29 GMT+0530 (India Standard Time)
> + *
> + * Multi DDR Configuration (table based on register configuration tool inputs):
> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * | DDRSS | PHYSICAL SIZE | SOFTWARE ACCESSIBLE SIZE |
> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * |   0   |      8 GB     |           8 GB           |
> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
> + * |   1   |      8 GB     |           8 GB           |
> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
> +*/
>   
> -#define DDRSS_PLL_FHS_CNT 10
> +#define DDRSS_PLL_FHS_CNT 5
> +#define DDRSS1_PLL_FHS_CNT 5
>   #define DDRSS_PLL_FREQUENCY_0 27500000
>   #define DDRSS_PLL_FREQUENCY_1 1066500000
>   #define DDRSS_PLL_FREQUENCY_2 1066500000
> @@ -16,6 +28,15 @@
>   #define MULTI_DDR_CFG_HYBRID_SELECT 0
>   #define MULTI_DDR_CFG_EMIFS_ACTIVE 3
>   
> [..] #define DDRSS1_PHY_1420_DATA 0x3F0DFF11
>   #define DDRSS1_PHY_1421_DATA 0x01FF00F0
>   #define DDRSS1_PHY_1422_DATA 0x20040006
> +
> +

<blank line > also in patch 3/6


