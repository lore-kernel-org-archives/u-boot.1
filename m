Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9580BCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05622844CF;
	Tue, 26 May 2026 14:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Vetdf3QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CEF846AC; Tue, 26 May 2026 14:00:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0238404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpteBrJHYbXyt0vlgZZ5WmoTJdc+Oe+CosVdr0V6EuDsXosBOwVlMXk4ED3xgSZodPiOY8777wipjOSs5A1J5PaM1ArmSxbMH6xPNZvsCeDyOiYcmxfVQpKxhKaee+lyw0KrXYQNTGO5ipdiIgQmV5863mqmhKKh6iTIxW1ZRv741hA2mBrqc/98hGEuHrzNRV81+IrhqLb+DiVvi7QnPqEy9HjcrTdU0bRkVW6o7sa3I2+gQHVLfhXY7e62AiYALZ6v1V5jP//MvmvRYvnyLrMTZcRON9hgw1f+dknfypE+hPe5Wm8GBUejYeDFscUOf6y7ounpyKDGEcUtgP1IRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFUa07hO6gbg91vMfEr+2qlU2GkuG+exDQoOnyTFLIk=;
 b=WFmtb5+fR5qiyaxaz3IPng1KNxXgOWU3z2k2ZHHzcJtGEHnNXJDEeIiX3RYSZ4B5SeFKyhjm2xoaD91ERfASkiBt/ecOzywVLUfexbKt4axf1hQp0FFziL/1O56aRGrl+lBPOolas5fXU0UNCJa2sJOvdiLigwPSfsleQ9IH+Evnjv+GFgY8+1TUC84pBtyMep51B2uDlU2x4yEJMkDca+/y8GZQGafsZ6cSyF4NQIrbJV3hH6WhyhFeMr1nR4MfPrquWpYiURwch9USOR8oH00LWeUIz0JTpHs7bYTQowQdAy37NIoX4QC99ujs4jtHBtilhOOIuLg+qgxuX7Xk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFUa07hO6gbg91vMfEr+2qlU2GkuG+exDQoOnyTFLIk=;
 b=Vetdf3QW7QrPHtWfcBJH6KMuzWQxxKyoal4O9G1kC3s1XfOG7pKSYt5q2Sx7Qm96YLZ0FWUDQk009FmsTwyJ/tBFuAWxV2TEtKnHEvgEkmxNwokn8/VM9tdDcmKBBg7awq+FfQjm/BFMO9lzT9Q7xIZ/dateYKoG+PhgkAsYevtsfKQERBxm6WFam6suzVxIKsT3iEdUzoURuSrk+ue72pD2rffRQUT4dJSvmniOz5s3HXWyhC2sWTNnd+sB3xGP6/9Fy4650/FM1+WAir/0DdvldoLAuu5Uw/x6emtQ6JxQBpJs36u/yq+c75qpI1v7ujiSCPKbniqLYONEDRZlWg==
Received: from CWLP123CA0246.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::20)
 by DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 11:59:58 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:400:19e:cafe::99) by CWLP123CA0246.outlook.office365.com
 (2603:10a6:400:19e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 11:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 11:59:58 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 14:03:39 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 13:59:57 +0200
Message-ID: <a4185156-5b6c-4f5f-8aed-96cca3f2bb84@foss.st.com>
Date: Tue, 26 May 2026 13:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] ARM: dts: stm32: add U-Boot specific dtsi
 for stm32mp157f-dk2
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <linux-amarula@amarulasolutions.com>
References: <20260512071157.564081-1-dario.binacchi@amarulasolutions.com>
 <e901ee2b-5948-4f79-8442-fd6321e25568@foss.st.com>
Content-Language: en-US
In-Reply-To: <e901ee2b-5948-4f79-8442-fd6321e25568@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|DB9PR10MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b387af8-14e1-4434-01da-08debb1e4f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|13003099007|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: N0rFwaKjKmK1IEqK3xFsLX/qJfj0WzqCBTdpGR4d07avzEUM1okT800h0+5pgAAZZQ4HZfS8Gy3TUCaggO+KYuWo9R0jnM6dSqdAYZkNmIkzh2UqbXsglINEIBJGkCHfgHraUeGfundihgh3HF4ocGHWq2SAKUF7gUZ27BFbfo5y4s5yTqjGI7eV0wml1g50WbDH+tK40jNByc2WrVwK9vE+9CGxqeF7Ehon1AProo/A2OcxbtAXTZH98j/x5jc74ZmY1Jpq9e/pmRN10GW/JeJjeLv+QSg43fZK5nKrmhKIsSAzbB//ZzuKkEiscVKiJDVhy2emTza8HaG9AczMo6oo6RWfRtRL0S6CcRiJOEUvQYS9KNORVmU8YxId6R23qUKj8NWF76grzq3boRx/3xRNIPo/3yOx2MI+vACZM32Cat454VFmtb4thNqBn8oopkJQZWGnJQWjiM1Dw9dRWYCJJh7T2SAYCE5F5c7sCpisZKhgBloi4PE/f3It3RA0+ZhoHdz/d9RRk76DVZ8JIPGmMFKEFYUvot89snRiErIxrlivcK6kWL7cFP2sZp61gvlZSeynZ7rIDR3AAgpWB02HKuGoEfjmFbLn42IQztqP/2ubGAgyEAwymbb+bWDbSqXXjV2pmiRE0XcPvr6oTzP+QQ2lEtletsUyMmbGwSlEaeRdgBV8WjPbKB/uM0gs+a0L42fS3LrQZHs1CW+ssFt6CAaU4Ye0/ywK4f31WHo=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(13003099007)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: enci/AMTzKScl6+UmeVjtvvvjxHDEe8hL2D6m4LOiQi5Qb+tWtqWy2jQ/XuknqLJd9qMCClTTD7inHaxjfo8S5ZKWJhCr6zKE69d1xMqhEQtIx74hXSgU4rRDKfZB8suofeZqqKJEcQAIrlLyqbgY9gvtPBcuEVBrj1mm1c42qgLeG4cAN88Epy0qvp9F2PUsuAiEFLEVCfKXCAcg//Lrz0eSTM9iF1bHD1vozHPXmoGutiaoCSWNgdWhNRV47Ytb2kMSJju7bs4HAE7gfjMOu8hm26XDD/ut+JeRDNMOYQZxLbgNsuJLZzHJThd25fs30mF4s9VfMRFP57MHEMfJUKdWuvAulCRoVmdSrK+0xYCl27XQHrN4N7nlHk5MjzJKC7vlI5I/UYRuVQ6PSp07ZdpFn66OoG70qToFNwrl88oD02R6sbCVuykIlcBMOCX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:59:58.6077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b387af8-14e1-4434-01da-08debb1e4f4a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8246
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



On 5/13/26 08:44, Patrice CHOTARD wrote:
> 
> 
> On 5/12/26 09:11, Dario Binacchi wrote:
>> The STM32MP157F-DK2 board is a direct derivative of the STM32MP157C-DK2.
>> As explained by ST [1], the "STM32MP157F-DK2 is assembled with latest
>> STM32MP15 RevZ cut which is the only one available for new product now.
>> The major differences in this 'F' variant SoC are the increased max
>> frequency of the Cortex-A7 cores and the correction of some HW bugs
>> (Device Rev.Z, see errata ES0438)".
>>
>> Introducing arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi by including
>> stm32mp157c-dk2-u-boot.dtsi allows inheriting U-Boot specific properties
>> (e.g., bootph, fwumdata), avoiding code duplication and ensuring
>> feature parity.
>>
>> [1] https://community.st.com/t5/stm32-mpus-products-and-hardware/i-m-wondering-what-s-the-difference-point-between-stm32mp157c/td-p/213460
>>
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>
>> ---
>>
>>  arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>  create mode 100644 arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>>
>> diff --git a/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..456ba70ba9ca
>> --- /dev/null
>> +++ b/arch/arm/dts/stm32mp157f-dk2-u-boot.dtsi
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> + */
>> +
>> +#include "stm32mp157c-dk2-u-boot.dtsi"
> 
> 
> Hi Dario
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Hi Dario

This patch doesn't compile against U-Boot v2026.07-rc3 tag, we gat the follwing compilation error :

DTC     dts/upstream/src/arm/st/stm32mp157f-dk2.dtb
Error: ../arch/arm/dts/stm32mp15-u-boot.dtsi:83.1-9 Label or path clk_csi not found
Error: ../arch/arm/dts/stm32mp15-u-boot.dtsi:87.1-9 Label or path clk_hsi not found
Error: ../arch/arm/dts/stm32mp15-u-boot.dtsi:91.1-9 Label or path clk_hse not found
Error: ../arch/arm/dts/stm32mp15-u-boot.dtsi:95.1-9 Label or path clk_lsi not found
Error: ../arch/arm/dts/stm32mp15-u-boot.dtsi:99.1-9 Label or path clk_lse not found
Error: ../arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi:76.1-9 Label or path clk_hse not found
FATAL ERROR: Syntax error parsing input tree
Check /local/home/nxp11987/projects/community/U-Boot/stm32mp135f-dk/dts/upstream/src/arm/st/.stm32mp157f-dk2.dtb.pre.tmp for errors
make[3]: *** [../scripts/Makefile.lib:476: dts/upstream/src/arm/st/stm32mp157f-dk2.dtb] Error 1


Thanks
Patrice





> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

