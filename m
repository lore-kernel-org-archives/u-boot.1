Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84294CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4DC683642;
	Fri, 31 Oct 2025 10:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v1HLJq+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0151B83885; Fri, 31 Oct 2025 10:28:47 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB6F8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPDJ2YDdnLv8hT/JjwV6h0ENoaaXzQmiNC8SLBd4fBfBYH9zlicu1NzVGPL9V6Ka4sEZX59rB/I3oO92PkyOS2wWFyWwrcS6t26+2bnLKQHXxZViD4Z/GV++m5eQ0JCJHfzEUl6Br1spgAvEfwZrtGsqvVNeBO0IRVUUmlwOCrsAf0xFNmPcCe8iIAGr79NF4lqmtYT9hS14G5FOpAknloT0o7tFUO6yemyaIFIyE3dO3ZsZjnm17ohVQP9c81/lS6LxiXp1vDn2DNoWCFq0mngqPy4nUt/6sz5l3wrsCVjvcf6wTBhjWZyGLhj9WNvuf5K2i1TurI2YwRl/hC5/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwKKFXvtAC0SMohcY/PzshPaCnxSWwYjzRDEkB53wt4=;
 b=wHSwL8DhekHB71O/i5SRK3iAePUANN6qAsACK0+djKs4JXk01l9/PQstD+zLf6NQbcWLrxdZ0i4nRA0aa+jzTgr28lfgHFYafJgIGi7DbhZboDIivZFeuLJ01y+pN3VsAPcxnlH+v/SEhjelABdHwo+vaZWXB5uO+EPt+m3z4vhgWqA6r/ZNfJd29BEUst7Xz8gtAs2ESAWzRRBhcVC+29Gaen/V5vPaCkPSa/UvCVeugAmGM5ocw/ma66D+j9+Ur7Ivx30MTqq47LwQL3XgUeyWWCvlWCj2vcsy9bFqroVun/p9Q8ogF981tQXXx/NfdHo6Nc6C/TJbgNztParYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwKKFXvtAC0SMohcY/PzshPaCnxSWwYjzRDEkB53wt4=;
 b=v1HLJq+IQINDCUKL5N+3lW2YjxFCwM2n5Pi1jfVWIE4hh+E6vSf6UM/Ak9leIzxWAzutFSP1r1XHhTjxuDicGTb7InRbwvsv3tgfdSJQ7CHlgcqcCDJ13WVUNFaEcQK3ozmFAdh2qjGLcXUGyYid3TokW5uj8DhCoGVtMgbCgLI=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by PH3PPF350708D76.namprd10.prod.outlook.com (2603:10b6:518:1::794)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:28:40 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::4e) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Fri,
 31 Oct 2025 09:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:28:39 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:28:38 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 04:28:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 04:28:38 -0500
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V9SZOk3687382;
 Fri, 31 Oct 2025 04:28:35 -0500
Message-ID: <03b3c07b-6cec-4a32-8103-11f49c9338dc@ti.com>
Date: Fri, 31 Oct 2025 14:58:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251031053425.3960963-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH3PPF350708D76:EE_
X-MS-Office365-Filtering-Correlation-Id: e04e7b72-994f-4e8a-b55c-08de185fe05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU5FTGJrd3I3dko5VlloWlZTSkRPVHVGTDZ5VmNZMlZEZnhXamplMXVwenBj?=
 =?utf-8?B?Q0I0UENJZ1JqUk9XaXpMUVB5akp5dmNNdmJaRC9sQUZGMkpWRmhRREJqL1Bx?=
 =?utf-8?B?WnM1OFI1bzNXb3ltOE1BaWlXTGxpSWVoalFYWjZrcWExN3BweXZRejczSXIw?=
 =?utf-8?B?Qm4rNEM2NnROT2I0QTZ1ajF0bHBlZnlBNkRRc0ZwcWMwN3o4TFRWbGpEalFn?=
 =?utf-8?B?cmljbkVpZTJyR084VjN2MFpZdm0wcVNnbTdUQ1d4cVl4TVJ4bEVrdmdvUDh5?=
 =?utf-8?B?T0dhVkhkTW0yR2g5ZG1BYko5dll5R3J5L3cvU2ppRUVYSHBtU3lja1pUQmZk?=
 =?utf-8?B?WlRacGRabEhBZ2ZCQTJ0NzJXWG90Z0VpVGpHTFFkTmI3VlY3eUZ4VTYyWUtD?=
 =?utf-8?B?cDJ6OW1RT1pHNzhkQ0xrd1piSEZwaEVSN0tnOGVXSk15cSszQkZjSitJSzZw?=
 =?utf-8?B?YTd1Y25MeFd3bVJTR0ZGMlgxdmRtWVdqNE4wcWhWNS9sR2pnREhWVVVrc201?=
 =?utf-8?B?S2RJVWcxbHBnY2g2WXY0ZnRZZlVjeDBQVjdVK0Q4U09nUGY4azNHL3pTMUI3?=
 =?utf-8?B?ZytWcGYrTDNvR2dTRy85THNhMWRCdVJFSGJRaEx0bXRIZ3FjNHM4WWRTdU9S?=
 =?utf-8?B?anhvTGphNnVYdHV3UXNNNm14RmlGYk5oOEFSK3JGc0R2NkthMmRQSS8wM0pl?=
 =?utf-8?B?QUhmSy8wZWNEVEJBdGphOUJkWlBqaUcvc3UxRjBHc0VNTzdTa2FZTkM5NHEy?=
 =?utf-8?B?b1BzUHl0aHErbXVjU3J5NXVHK3lOdk53R2djdkhjYU5lWTF6MDVrdWxvZlQw?=
 =?utf-8?B?Z3FybnF2NHRUS2RCM3grS1MxNzBMak9kWG1YNEJBYWJueS9lS0dNR2NQb0Fy?=
 =?utf-8?B?czdKbUZHd3E0eGh4dkRTdHp3Snc3b3Q3dWVJajBvSzdOSkMya0h5dVVtNm1p?=
 =?utf-8?B?SHdFVjh3VEhFSjUrZ245T21SdmZUVzR4MmxIcFF3WGlyN1g4OVoxTHIyc2d4?=
 =?utf-8?B?MU0zM0NiUEFXVGNzV0ZGQjVZQVhzeFR1NHc0YmZHNUF4NmRsTXNIWXA1THlB?=
 =?utf-8?B?TG5yN1BUSnkyUXUwUXpkZkFvaVY5UExLMUtjbDEvR3A2NVYvZ2M1NVlqVEwv?=
 =?utf-8?B?TjNLZUE2V21TY3lUc0x2MTBCNUk5cCtSbGxKOFhKSm5zMUlDZ0hhWGc5WGE2?=
 =?utf-8?B?YjN4eVRNNjJRZTFXcWp5dTZuc2grbEJQbmpRMXNiWGdra3BydUpGdEVCWWtI?=
 =?utf-8?B?dk4yRzRJWFdTQzhsUXkzRE43U0svSVFLMnhhR2JKUnJ6QkZmRTRENnJkUkds?=
 =?utf-8?B?V0cxM0RPa3ROVG11M2lUTG14L3d6a3hrLzFCYkJEUGkvV08xdjlpbzFLTG1j?=
 =?utf-8?B?MXJCb01SMjlSSGQ2WTRaK3dsaDh5VlVrRzlDVVYxdCtjSnU3aWxCSnczV3JT?=
 =?utf-8?B?a1VBK1FkMzJoZzFWZ29KaXNrYWx0amlndksxcGMrMWk1U0tLSTFtOWlEZGNr?=
 =?utf-8?B?YzUrZHpUNk5BNHB6L1ZKV0wvWkI0R1dJU2s2aXBsQTk4ZDRJcDEvNE8zQkhh?=
 =?utf-8?B?S1F0bmFkV2V6d1B3WC96enRUbEk5VHJRWXg5bmV5d05IU1JScW94M0dMa1Q1?=
 =?utf-8?B?UG92d0drMW5LSlByYkdPYlk4bXFYVExVZi9vVFJKYytaSlFua1kvNiszenVl?=
 =?utf-8?B?SENYNWFUclozZmpPZnA1YnBDWUhIMTR4Rmx3Mk1wUGtZQTY0aFR5UzhBb21j?=
 =?utf-8?B?cmxaclh0cm1GbDIrem40UVB2Mk9VcnNSV2tYZHU0Q1RBZGR1U1lvRWZVMG9Z?=
 =?utf-8?B?cTBOWXZ6TmtKYWw1YWh5aThmdStWTkdhaHZKNUJwdW55ZVgvWkJ4UXNUaFRr?=
 =?utf-8?B?MTZuTG83dThZNTgwbzVEWXBQaWNpdGcxajRFdXdjaTZSSENKMW1YUlZXR1lM?=
 =?utf-8?B?MXZZRHdkMWYrNVJnR284cmZwQjJGdTFTSllNVEFFMkV6NFZHZnIrRnpnN04w?=
 =?utf-8?Q?sQ1nq4JHitkPvTHOHkBakbH0LRUZWI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:28:39.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04e7b72-994f-4e8a-b55c-08de185fe05a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF350708D76
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
> Update the DDR configuration for J7200 according to the SysConfig
> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> is [0].
>
> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
>   .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
>   2 files changed, 2208 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>
> diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> new file mode 100644
> index 00000000000..810415494ce
> --- /dev/null
> +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> @@ -0,0 +1,2207 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + * This file was generated with the following tool revisions:
> + *     - SysConfig: Revision 1.25.0+4268
> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India Standard Time)
> +*/
> +
> [..]
> +
> +
> +
<blank line >
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index e35b767a7e3..3127ac83d7f 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -6,7 +6,7 @@
>   /dts-v1/;
>   
>   #include "k3-j7200-common-proc-board.dts"
> -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
> +#include "k3-j7200-ddr-evm-lp4-3200.dtsi"
>   #include "k3-j721e-ddr.dtsi"
>   #include "k3-j7200-common-proc-board-u-boot.dtsi"
>   
