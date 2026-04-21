Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0981AF327BD
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4D2843C0;
	Tue, 21 Apr 2026 11:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZZtE08Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26494843E0; Tue, 21 Apr 2026 11:51:45 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEEC8439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qra+DytG3znwFFYCkgI77GfjiXXIZl98A004FhcogUA8I3MhKHJ588ozU9HwokKeRBEaB2dHt+Wenwuz6Fhz4xLzUA96E1GBUr34FcYDbUciqlEEss7IZcDpKY2iGUh+54lQBgVy6Hnjs2u+DPFMV+jZoejxNG+pSmJrTVw77X2eGUHWDxTKY79qn8o9FCKAaH0uvz3U8x6q97FSKU6HN/M4IA3ilJB1Ufieqe3hDOwo2nMBOn68eKeLPYZBjY39PB9v4mcj7NwpN4t1vn8UpcRHVkeb4pInyOewqdGHb2qZ6HVn7wT6XsRAPclr5KLOYNcwSst+H1sgxphfYokwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duPoEP/Zo2Fked+yWftE90/caZTYeTjYAYMfwByU9WU=;
 b=MWgQ44Ynjmh+WkifYSsfjiO4O4z03cyDyWSIiv5T14t3kjVSPY45C1PMnH4s8t3kGJoo/jcDPHx/0Xik9KGx7d72vYe1A/AncABFgaG9NLKa77ztoxvge9hMQ218oqRX+1TS1Ez7lL0zgGbdEEuusrYMx125mzefxfXkgHQcXtU1XvVyln9rzWbhU2/lBXcOExbw4SzfrIXFxYXjajmsOevghx5e5dJrkaajKjaWeA67COOXIUlMzpICiwtnztyi1Sd/rt5GdbdSz5WGIakpPwCmmcs2ABodomJR/Qk0lnAOeuspF9j4Ro/eQu1dLbM88UZU0MFHJmLAMNfQ1HAFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duPoEP/Zo2Fked+yWftE90/caZTYeTjYAYMfwByU9WU=;
 b=ZZtE08NvEaRXQrn5nirGJy4b3Z1aYMXp4LD6V5OZ026LdYWpGZkfG/iwbTltf2s4Gghk+ksd2s4vDeyU5HMBy1rlM02mznZLOlLGbbrCbN3oMHxY5sJl43jpu9QswveKeyAckcrAJtVCVRs9+ofrJkvPbJ8Zfb9nBa1wQ6AAbQg=
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 09:51:38 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::92) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 09:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 09:51:38 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 04:51:38 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 04:51:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 04:51:37 -0500
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63L9pZgq275791;
 Tue, 21 Apr 2026 04:51:36 -0500
Message-ID: <e8b96a8b-1fc8-4f4b-8b4a-aeaec27f3320@ti.com>
Date: Tue, 21 Apr 2026 15:21:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: dts: k3-am68: ddr: Update to v0.12.0 of DDR
 config tool
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <s-k6@ti.com>,
 <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-4-n-francis@ti.com>
 <ff95c3c7-7438-4a30-8731-9a00c440ea8b@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <ff95c3c7-7438-4a30-8731-9a00c440ea8b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 13529562-e3b2-4519-6fce-08de9f8b9542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mBFe9t1D9w+UK8Huck6n3PF/Rmiot9/X4Xbm/0BIJjWPmWwexvAXi+vPPzwPqOIKGcst7+Ey9SRZEjbFv2oBiau1Yzj1LvypyeorhmwF3tOhUZ7sF49BHMEFOePUQoRjYY1qpTIvqUPr/+DQ3vy84mfKqfoJvQFtjbOMokNJeSIG/IcxNO4K8nnX39DMxs8R5VB0gJYiMuVIat0Wh3r1W1fgwKEnDMKxUEirlBJJ4nXw7CaWTHWHjB7XgbpXjIxqux5lPDXO8Kp1I1VpNdynzHsZ0nUKh37mVeIwWuZe/XSAQqd8IAzjvG/OX/5quGOyI3Z6T2AaEhzR+Ma1CBgRrPFNmOPSvzSrVZjPUwtbYbnhakiFAPowa8/DMAGaxwhVYYy/Oi2SqMaK9wNjPdhwg45sY4nmbDHsCfph+3qvhNyxzT7yRWubxWZ7GwU8R8a0EFxx6lsslIOlgF9W6cVyJTO8tj0WSkfk1JRAjdvnCqyu+4cZZWwfQ8Q8MyfPUB0n39D6wN5fHMn680C2NUw/HO/7lIOJ9srSrcHLOQ1Z/+V+wGKe+9qpiwlvO1PGtp+zx00yB5KxTOwj/oBvN4isT5joiqoovNi77s82Xznk0fm0+BP1hQAFjzYcfywsC1PT54LBnHzrXFyTIdMf6rC2/Hp0pPkrW43RZfiNZK2hW18AXYjBocXxAMHE6ccZm3b7Yk/5B8Yqk3uucI6qOeb8HKgf34GoqeyetO7XVvurbZg=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VgkmNa57Dj037XNP1mC2qnzFVmmslZ1/REp34aD16vnnMABIODAt7lyyxpk9B2FBpi1RVHRbK+lFxYp2ndrdyR1VlDDYQbBtVeuMJL8Kr6NsCh7F5/T6IdYQwk5NBRYyJO1vcDrZ+cWfbKego7M5uKEeR/Sq8adgrQyzXvKBFnwPG+3dE/6hqP5iir0+wYgLAHokzyzwL0I12i9vgIvCoR87Mm4ff5Sp6DH5mIhvrzzec6ffpc2g6udG+dsVh3PJhQ+xD1yqBP73HgUi5UKrN4TjNPakqvDu2t4Am/fZo5hGzKk1qp9EiwlT4hCcPnoT6zN8qucn0QaWlV575C12hg9cjLrnT0/wcqwnljGgMhPPKKFx4K6Lb41XN45NItgAdRVUf3xF1vNsDbBvpsrSv1NucISYbsKo8DHt/wY59Dn7/oEBufkzpyO5JDyjQsc1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:51:38.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13529562-e3b2-4519-6fce-08de9f8b9542
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
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

Hi Udit

On 21/04/26 09:20, Kumar, Udit wrote:
> 
> 
> On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
>> Update the DDR configuration for AM68 according to the SysConfig
>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>> is [0].
>>
>> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>  arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi | 4410 +++++++++++++++++++++
>>  arch/arm/dts/k3-am68-sk-r5-base-board.dts |    2 +-
>>  2 files changed, 4411 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
>>
>> diff --git a/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi b/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
>> new file mode 100644
>> index 00000000000..ea773a2ca4f
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
>> @@ -0,0 +1,4410 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + * This file was generated with the following tool revisions:
>> + *     - SysConfig: Revision 1.25.0+4268
>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>> + * This file was generated on Thu Oct 30 2025 14:50:37 GMT+0530 (India Standard Time)
>> + *
>> + * Multi DDR Configuration (table based on register configuration tool inputs):
>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * | DDRSS | PHYSICAL SIZE | SOFTWARE ACCESSIBLE SIZE |
>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * |   0   |      8 GB     |           8 GB           |
>> + * |~~~~~~~|~~~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> + * |   1   |      8 GB     |           8 GB           |
>> + * |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
>> +*/
>> +
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>

Thank you for the R-by, but there was a later version:
https://lore.kernel.org/u-boot/20251103071035.674604-1-n-francis@ti.com/

But no worries, I will add the R-by when sending v3 as there are no
logical changes in this patch.

> 
>> +#define DDRSS_PLL_FHS_CNT 5
>> +#define DDRSS1_PLL_FHS_CNT 5
>> +#define DDRSS_PLL_FREQUENCY_0 27500000
>> +#define DDRSS_PLL_FREQUENCY_1 1066500000
>> +#define DDRSS_PLL_FREQUENCY_2 1066500000
>> +
> [..]
> 

-- 
Thanking You
Neha Malcom Francis

