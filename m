Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD8CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0452C846BD;
	Wed, 27 May 2026 07:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Cd7Muej6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC26846C0; Wed, 27 May 2026 07:54:05 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF4483FB0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaAVp3QjoSEqjyRBVpnH4D0hEuV7K5Y26R5FWnsN9DVsnFExo1d28KqZS6SOMDRYjsy73/GpWY8CASXPpV2QzxcLXajQQQLT3AI2XzAbi4fwZyrN043/IIdElE5y00jq/udysB7mZUxayrUgshpgcL5kycxP/WGE4a/gxTN/sCI/gOXcd8C6ocv6svk5sVl6SyOmph6VRfuSkzYzb/TtKajjOwp5qjk4jlLoFP8YS/lLf4C+t092yeI7JE3962eTRH61dSEt/4C5MxwqhYAIsRko75KowAzyBuwgIqz4dUDGVGjuNN/pCZfYheiwMwrU3iWIbzLRuRyrNLEaQp9Wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20svEs5HKbFOvJh3xc6rZKRCo4bicMvvkIMahUdYBfg=;
 b=Ah5ukrjZ9UJvBUxBhO2rWGTTNJ6cHXsGUz9kVV74TcpeKaguSYwltwo1Ord9V6DXHHn0o6D6OPfwqNfJo4yn+5IpNJkZTnW9QWXE1DfqFBloW9WNrvwNLKPHZEYkEanbSxG6IppZfO6UvIh7+ak/ChQOp35TA41LPHxH7I1ILANMHKNdZlz2u/PXzFVV4zPDEA0WGjC1QKqbYXomPd0qDV6PbhaB8SlapdcMcVsbbaOePoEHgTmu9dIZy5f/DDmOeJ3/CmnV5nD9VDpCyP/Lrb3ALDCk1Ckgog0UsDSfHzxYSI59SbN+eBsBI8FFwRf9k3zcqbdZemlozLLzDnriIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20svEs5HKbFOvJh3xc6rZKRCo4bicMvvkIMahUdYBfg=;
 b=Cd7Muej6EcuWG7SaM7r9m697qolBhb67LQcLxUBkPfJmSXNYLrBwyFi7IC8Kgn0UrYBA/Aawgy/af+mcVWi6bwdODwfox/qqjTiXVz+bdIso4sNsBjNCSdpr54FWvf7MfqPw4eVjQ+YjKCk25oIbEwqf9o+at1h+CLrplG1Hps0L0sbqn6u5z5Bm+78GlXA5svB2A5QmRecNqma4rJGzqtdFJQv+my3FMwzDdFE2uiYNyarrLmpvQBmM65XCKV2s0pdrsFH7NAGzJz7sahGP1q8bXrrEiXdwrPIzFrfpgWcaiYaC8te1bFQg1Qi/U0kZxu6GCDAnUQFrJYLSPF2aXw==
Received: from AS4P189CA0041.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::15)
 by AM8PR10MB4019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 05:54:00 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::5e) by AS4P189CA0041.outlook.office365.com
 (2603:10a6:20b:5dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 05:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 05:53:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 07:58:02 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 27 May
 2026 07:53:51 +0200
Message-ID: <ec36ce66-37e7-487d-a987-0f9f7035c2bc@foss.st.com>
Date: Wed, 27 May 2026 07:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp2: update part number for STM32MP251/3
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260224-update_mp251-3_part_number-v1-1-d8bf2033b3ed@foss.st.com>
 <2590b373-0184-4d53-920c-74442680789a@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2590b373-0184-4d53-920c-74442680789a@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|AM8PR10MB4019:EE_
X-MS-Office365-Filtering-Correlation-Id: fa420f20-f8e9-46ca-9536-08debbb45932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: idrS7WdI+yJEZF1slEzicupRCK5igXGXCzUrLrCuH6XCib5iq4Js1yLfdAe/nB9jIKKOClEUFvIxgGih8uSkBFp+ALlg7ESfEYIPI3yyvtzbYBrLcUsb1wCJqjskCwVEnFlnE0UjOASSUWQ/aK2MB4AMHm6O5cDorykY4T3TJKGUC9Mu3hk7clYAO8j0AR+aanyXsRBdE8wTVha/BosfrTnjX/162Pu3Teh0jGWFvCGS+3NiohVWZIbWndRqPABQrKvpylsQ6pqCp/I89faEU871wkQ3Un3BCvexRYCF0MDr+/PbQ0k6fm2xIhr9GDwSUMv6bPyzr+ZuTc9SIN7GJ+dUA1z0KMKbUkMgsPFmVMbRjITfNhhfb95sKBWPFoU/qRQt0o8FYRlHnGQx5EzFr0ubWy34Lt4cfS5R3tCTeoJhLYvfdOM8opDptpXdLlSlcrNfXQ60T8PLLZezg1pFplXyy4JyCJV78DCEz6guhz2rZbe+TWhWI+GmdT6dZ2SrA3H8ZPFN5nXD/OgSD/DFvNjeks1QqvXbZtWaji2HnQoalevXCTyP19SWc86X3ZocAAyucZCt/rYpZ2YjO2lc+CCy+7PWe55s3vvyHgP761h0b2chnJsbVBNJuJ4lBt5fU9D/6Wysq3NSkJ+VelLrzHxE8yBUy03YecsWJKOWQ1tcQTm4Qa6YE+FaT66VplwLJt2KkyZD/M5+FqSd+YKEZ68IzSBRz1IkGthVE9DuuNQ=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bHEppbkahOT8m+I0LXiGiczF/t9bfu0fzxtXh0g7k9vDaDTPSnx0hY3JQ7KzS9wRPkeUr9+MZzc5JkeSEF2qF3xXNGiywhD8GLHrTs4Rp6dNNWBVsT/zNJzwbR6JUWhNR/Ek+h0JAQRXyG0QEwXH2+/Ji/iKfYmcWktYE2zzErgvI07nuIcy99OZROiKRRNF+res/SarKlFt9+dpuJ9TVQ7LKq58BF2itP/+yElW0n2Y1EZpVlPiMDO098VFeFwzUg0aSYTD1HTikrhDWyY/L0ZXEDBRxx87tGts9xiiWPdcls/t66SWnp4qeMlEnGRMlAGONJoPKDqKpP6lsOIgfqJ0eaNkr6KCq25zYj6wblDRQbM5KyroxplebmekL6s9CqLt93JGMdnKAmRQVnVOY6eYcHV5xcfyCHBGNgu69l12WKag3qTor1qzT/swAB/m
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:53:59.7366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa420f20-f8e9-46ca-9536-08debbb45932
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4019
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



On 5/22/26 10:07, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/24/26 18:31, Patrice Chotard wrote:
>> update part number for STM32MP251/3 for last cut revision.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/include/mach/sys_proto.h | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> index a875907ac3e..05ce869c428 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> @@ -61,20 +61,20 @@
>>   /* ID for STM32MP25x = Device Part Number (RPN) (bit31:0) */
>>   #define CPU_STM32MP257Cxx    0x00002000
>>   #define CPU_STM32MP255Cxx    0x00082000
>> -#define CPU_STM32MP253Cxx    0x000B2004
>> -#define CPU_STM32MP251Cxx    0x000B3065
>> +#define CPU_STM32MP253Cxx    0x000B300C
>> +#define CPU_STM32MP251Cxx    0x000B306D
>>   #define CPU_STM32MP257Axx    0x40002E00
>>   #define CPU_STM32MP255Axx    0x40082E00
>> -#define CPU_STM32MP253Axx    0x400B2E04
>> -#define CPU_STM32MP251Axx    0x400B3E65
>> +#define CPU_STM32MP253Axx    0x400B3E0C
>> +#define CPU_STM32MP251Axx    0x400B3E6D
>>   #define CPU_STM32MP257Fxx    0x80002000
>>   #define CPU_STM32MP255Fxx    0x80082000
>> -#define CPU_STM32MP253Fxx    0x800B2004
>> -#define CPU_STM32MP251Fxx    0x800B3065
>> +#define CPU_STM32MP253Fxx    0x800B300C
>> +#define CPU_STM32MP251Fxx    0x800B306D
>>   #define CPU_STM32MP257Dxx    0xC0002E00
>>   #define CPU_STM32MP255Dxx    0xC0082E00
>> -#define CPU_STM32MP253Dxx    0xC00B2E04
>> -#define CPU_STM32MP251Dxx    0xC00B3E65
>> +#define CPU_STM32MP253Dxx    0xC00B3E0C
>> +#define CPU_STM32MP251Dxx    0xC00B3E6D
>>     /* return CPU_STMP32MP...Xxx constants */
>>   u32 get_cpu_type(void);
>>
>> ---
>> base-commit: c61d6f67f46f05149182b33c3c0ba5d9b6b46889
>> change-id: 20260224-update_mp251-3_part_number-42196c4f7d49
>>
>> Best regards,
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied to u-boot-stm32/master

Thanks
Patrice
