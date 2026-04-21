Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59C1F5A8DA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 03:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D3783FFA;
	Tue, 21 Apr 2026 05:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lwVYscLW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283DF8407D; Tue, 21 Apr 2026 05:48:48 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A9383E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 05:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mxjh4UEDDRtCictbkU1QkUn8RRU+4DdcjEovZlDOFoy+GF3FjEK/MgDwSo1RnLqnEAcX9XAh9FjsH2watFnZO4Bb5qrihwyR3nsMjtfX2/5mod+CsA58LUDpzW4+zIxOEaCLaf7Us4qKi7JyRbiJ1s9RH7NU37Ek1qs2/qiEv+c2Z3qyl73VS6LT7fibRXanz84pmXiPy3fkuoKmM+NAk9gs10QwfVML/nlYI4ZBYYbjOI92rvyukjddy7MbKxK9Z9BnmsE4WAk1t9ZL3SuV/JWghEAuL2Oj6e0AAIHmUYRAiwguG8faDjcQOG/XqM+V0rX5Mf15XfzC7sayekSIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDmX16c4j7liWll/Q93bgL0/gWHQGPtHSCqhxJxt0zw=;
 b=gaopspmlyyY0GKu8d1Rk2032hAmovSinMWMgCNy+vrr5wA0KgJSp2vzhJC0vBpzMiwLVyjQHfuSY4qOlPTeikFKBhZ4t1+RP2xneV7L8A1L5etcNRlm/LdAGvJCFddkTQ/q+WY/s+xzVSfpnNpmatooCaRMot315qgFOGKaiQ05EJVCMlD+BIk1WFUwhv6q0P1owBOIoUNt9vhAI/jg+bKRcrWKuVrPRNav3+hDlUFsPJ/yFOJOJgiVtrseoeNRUv0hv/MsM9QTz1YeSKLdfWZx39zW39JvJ/MTnJ5HdtHZ+PrvgDKSh9mqP6Fw8g/fbFRRmpZyfrosmk4asuVoYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDmX16c4j7liWll/Q93bgL0/gWHQGPtHSCqhxJxt0zw=;
 b=lwVYscLW9fq2H6ELEUCMIHbSahdq5/rnjUn0/QYvXRxirGj4xaphC25mDr8gwOSM2Bo1EA0x95t8K+vy19Ed0qNojQdFFr4lNklI0sd3RfIN5pwwgh9AY2Vaoh6Vb+KZ7YUT1I0SNfrhu+uiMn/x1TJkHW740zUv1xRqcqV6kF4=
Received: from DSSP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::17) by
 DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.33; Tue, 21 Apr 2026 03:48:42 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::4b) by DSSP220CA0009.outlook.office365.com
 (2603:10b6:8:3d3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 03:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 03:48:41 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 22:48:41 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 22:48:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 22:48:41 -0500
Received: from [172.24.21.102] (lt5cg60819vj.dhcp.ti.com [172.24.21.102])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63L3mcMh3991508;
 Mon, 20 Apr 2026 22:48:39 -0500
Message-ID: <538fe76e-7374-4b45-9f40-7d6926d2a599@ti.com>
Date: Tue, 21 Apr 2026 09:18:37 +0530
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
 <03b3c07b-6cec-4a32-8103-11f49c9338dc@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <03b3c07b-6cec-4a32-8103-11f49c9338dc@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR10MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a91afad-5300-40eb-7027-08de9f58e155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +3W3wsX48QzJJsJZhYc43E4+CORvp/3/SooeFTBvfMG1cbf8jEnM/UcKl6eqSdo0eKDydv5XozvwHuKbmeQmxRvtj6yomz0zrKKeWGVhGQv0OFWwThtvOQljscKx/4sxlbdnVbAQYSqj4wpHQSV8GPF478oyaQjLv81D3Q0LY/zZdqf0v2CL/BrT7ayoeNGuwFPb/17mPU06FG5hOLHEa5/aK/uA14hUN4vJ/gwa+Wmu55ZSPa2ALf7+NhHIY2rgVYmyodA3pUtIxXCG2/cqdwInE7k8BvA9XoncWDxm5SHqB/CLkUoFI6JWaqWqckY88ht/QEm1AqRP8dzuJR95yk02OXjzuggAhpe8nmIEAV00X2uN1BT6W1RQOw3OmBeUw2htaQ1G6J6rqfH0tMmGMxPBgeBMrEksreSSv4+zqMObgRWHEe+qYxFywB0fgDM55EPUw8fuXQKJDYItb4KzGfLi777EgN4jvZ8/JB8OWpJw9vUwbFVYxlrhamYjSflBj1gTXp19r06hocrlGjGRtD1zQMVas55oMklkjKSWQwTeeBBD8/v0elufG/fvp4hIQPSd7obw8VGisG/qiI6aoa8KsopPcXIOoCggpxqtUKp9XCPTH4Jh79iMhWe7esulz9uBXZ1z3tiymfGgHuC+/TvcN3PDXi/Xcgi0i5kVyJLGnNbIoQBPQ+6b6U/v6Ahb01jOKD3gq/b/SMK09P7vUyF+lvsg37H6RMm+sDlig+s=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7y1TIadd3W1t7BLmjabSXiaNbC186AFKjmWK1BEl5RelgrNZSjBXJiZr3tuhEhCXiC3Zc7Ivnv5Wcu312MadJtGdYsAQB/pZAKxu6/PAA7HEy2aEpKzvGa/M541O0tVk9gEsTJOpTZcV9YDoWn4NaDhNyfCEsFYMHZSXTCA3Ab6lzJh6D1zoG6GMu73AxaTJMbGbZv1p0D8GAYukKCdZIEHC2ww+1n+A8+B8e9KXLsqcps58QXnnoQwmuhTt5mVP13xaLNX9aCC2GD+vsCGbarQPkBF6TonIJ9ec3RCFoW9GmQir9XfNsNGrd/mMYODjB8RQCzWd/rKXjiu/xHjP40wRsx2c54dm58HXYEdDAUNT9h/Cb45v8/q4UFFt/5szALckZ6A/TIlPWWZfTz1KPd04cLINz84x825KFpM6rICn0cgkucX4Mw1BYyolmACa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:48:41.8603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a91afad-5300-40eb-7027-08de9f58e155
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
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



On 10/31/2025 2:58 PM, Kumar, Udit wrote:
> 
> On 10/31/2025 11:04 AM, Neha Malcom Francis wrote:
>> Update the DDR configuration for J7200 according to the SysConfig
>> DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
>> is [0].
>>
>> [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-
>> AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
>>   .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
>>   2 files changed, 2208 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>>
>> diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/
>> dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>> new file mode 100644
>> index 00000000000..810415494ce
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
>> @@ -0,0 +1,2207 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://
>> www.ti.com/
>> + * This file was generated with the following tool revisions:
>> + *     - SysConfig: Revision 1.25.0+4268
>> + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
>> + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530
>> (India Standard Time)
>> +*/
>> +
>> [..]
>> +
>> +
>> +
> <blank line >
>> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/
>> arm/dts/k3-j7200-r5-common-proc-board.dts
>> index e35b767a7e3..3127ac83d7f 100644
>> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
>> @@ -6,7 +6,7 @@
>>   /dts-v1/;
>>     #include "k3-j7200-common-proc-board.dts"
>> -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
>> +#include "k3-j7200-ddr-evm-lp4-3200.dtsi"

Could you add in commit message, why moving to 3200 freq and dropping 2666

>>   #include "k3-j721e-ddr.dtsi"
>>   #include "k3-j7200-common-proc-board-u-boot.dtsi"
>>   

