Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1769F5A8DA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 03:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2C683FFA;
	Tue, 21 Apr 2026 05:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z87Maaum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56248840D8; Tue, 21 Apr 2026 05:50:15 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75EA83E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 05:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrFPXniWurB284ZNt0A3qnHwQJ3jMVeocPT9UqIPTgRX8lIB3dNIIXKFX31WvLxG8KkFuo9bUeSPnnNMwTRZG+9yFfty0f8dhbTw9RiZMQMJzR/xqUP0hMIFLtExKOJeXRTTG+HuM8XSwoM76kse0/PK5esrXF1s9ndOR0oW1JuV2krDVYq5v8UBVckP3txCASoT2BInduR1wuOtH6lrpyebDVhkSeZhCdC5zSkMK1Wf/klZ3GIXJCX3dlnkUe46+gF5M/0lraoa52GsMOGivwC+1ZzlZ+uVP+OFaB6yhd7F1ytqyBu6Scb7tiAMyQXWrXhFXFkrcRxmCEHtj939XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sztf1wU8hgT0Yl+cIbuZydDucrQGR1+Dl4/xW2Ff39E=;
 b=tPAwf8EDsgtDj6YffbIjAQn+e9P+QlYmHP5FTO/6ufcKxm0JLX4vsR5hRNtrafzWM6uLqC/Oa6wTVcesGk2zvyQleBf2Qw8QCWlGm+1zysvzv73toF7VHJYEGF8x683teYF5u1lgFiATf7uLKfI6cnwgwEyHQSnR0mkCgMO7+CkHNSeB9Y57T0FxOCdcs71Xfr2JbRqI7wmCR20XGYtSfGF/Akkov25Frd0TTY34jOChY44hBCeI7mulROFNU9xpIxfaD6lTOgpf48hdX0liq/gDCn1W1w0KOQ6WVP5n7KLluc95djl4fgxvIQhIfv5nXqik62H2bN9VesuCqHB9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sztf1wU8hgT0Yl+cIbuZydDucrQGR1+Dl4/xW2Ff39E=;
 b=Z87MaaumxtPc1RbhT9lm7Bq2tN6aS6FfLSTCJNKVQD0cCeFjvN2cs2gaCtNTuyTXnabGFNkiUQjEMvUN/znE1uKYcfPuNpaql/VfhSq93C3xU9nulTiDN114aSeBjXNZcyellJ64veAQuRi2niqWfM+g9PbBrOACCZSil2H1UrE=
Received: from SA1PR05CA0009.namprd05.prod.outlook.com (2603:10b6:806:2d2::11)
 by IA3PR10MB8664.namprd10.prod.outlook.com (2603:10b6:208:577::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 03:50:09 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::86) by SA1PR05CA0009.outlook.office365.com
 (2603:10b6:806:2d2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Tue,
 21 Apr 2026 03:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 03:50:08 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 22:50:08 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 22:50:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 22:50:07 -0500
Received: from [172.24.21.102] (lt5cg60819vj.dhcp.ti.com [172.24.21.102])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63L3o4iq3993150;
 Mon, 20 Apr 2026 22:50:05 -0500
Message-ID: <ff95c3c7-7438-4a30-8731-9a00c440ea8b@ti.com>
Date: Tue, 21 Apr 2026 09:20:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: dts: k3-am68: ddr: Update to v0.12.0 of DDR
 config tool
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <s-k6@ti.com>, <bb@ti.com>
CC: <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <gehariprasath@ti.com>,
 <u-kumar1@ti.com>
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251031053425.3960963-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA3PR10MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c389403-b28e-4024-f593-08de9f5914dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XKBGMucWBoXSD9LqlQLV61DBvVNeIfXrSkoZCc08qO2lLTLNlY7Im4OkIhNWKYfplrtNaZoBva2bgxDtZceS/vQnkLr/4QUojY75qIGkobQl0oWQ1u2yyl1cGIzvIC4q8vWuuVEtlI9PeDScDqlp9LbIMB9l9yWwjXmY2VNaR57u/+OUO1Myqs1T8wBn0zLI9NRLUUoDHmKBIGEKeWlArY4lpzJR50Xp55aJ2prdq+oB3l3nzcdSqG7YN80IVGf7Tmy93Xt70dJJ2HNKA3Z9qTy657f17Zooo1w5U7/lGyKOoyVzivbsQX9xczdqlr0+crtnq1RwCXvHuLbMLm/ziOLK8H2POTSSXX45RoE7XgxARuQCI4wJVQQtEckTk6cU9ijWDN4rCU6yAdmgnksrjQIiWncaq95sWDo9HPa5BlhPwbQESUcwDgqhOHBXYMESBfXqq+aInwm8QpzcwhlKWuRoZBcdcy74vtU/osqOyFlwDQ4Wir4BaBbWih+V4PaBPdikU0xLrwRMfXWHwI7a9k1sDNV6s7q3XLuRVfLxUipjvID2vvyNEJl90qrtgVRI4fDboLlXiKIqMYjkngsdnEzQhIZQGCFPy8AbNXZmvTK4wxCfzV2TQvfCb440tF98b3exUwo6mwuwzeFQ1Mlg8Rbojuj7tddi44WmAVJGj/q7LVoimllHMq7LZ24XAprHSTql1PYl4Ul9X5ieKkNjtiJj+IrJuIQRCxf9j+Me1H4=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gLBlFrxK6z12AH+8CtXOcZU/pa4745004hANd/WX5qNJhw1+DogIKg/AJc7lMUd82HV6hypWf5ps2ibrLULNv+OluNC5MNhYW6neoZNOEGSCZvC/FxV8p2UfAJKT23LEeu4u1q5DxjqvQ/suXPw1uNLQOcPyK2Wmbfa83NQe5f3ErvCx6kmdoDPTS5AjLN85Aftq79xslsBJzM6kD6cvrQidw3sV5ZeB6te263g4VcII+RsmzeLaHMHvPcRBjCSjo1RSSaocce6Fi96lm1LYtYWvLddsLvwVmfmgvd4/Wp1Gs0ONyf79TmiRRngAtBrgjgNTQcRhS8UyPCDs9EQBFROs8je53sGkEpp2tzou5QrqQoDuEKbqE7HlLeCzz4+6wqvSXVOAJEmSqnzojAnP9+yLwP0TQOOEz00VxMeqxD9tUxqLfvxxFc+2RD363FRv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:50:08.3286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c389403-b28e-4024-f593-08de9f5914dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8664
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
> Update the DDR configuration for AM68 according to the SysConfig
> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> is [0].
> 
> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi | 4410 +++++++++++++++++++++
>  arch/arm/dts/k3-am68-sk-r5-base-board.dts |    2 +-
>  2 files changed, 4411 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
> 
> diff --git a/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi b/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
> new file mode 100644
> index 00000000000..ea773a2ca4f
> --- /dev/null
> +++ b/arch/arm/dts/k3-am68-ddr-sk-lp4-4266.dtsi
> @@ -0,0 +1,4410 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + * This file was generated with the following tool revisions:
> + *     - SysConfig: Revision 1.25.0+4268
> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> + * This file was generated on Thu Oct 30 2025 14:50:37 GMT+0530 (India Standard Time)
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
> +

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> +#define DDRSS_PLL_FHS_CNT 5
> +#define DDRSS1_PLL_FHS_CNT 5
> +#define DDRSS_PLL_FREQUENCY_0 27500000
> +#define DDRSS_PLL_FREQUENCY_1 1066500000
> +#define DDRSS_PLL_FREQUENCY_2 1066500000
> +
[..]

