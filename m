Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EF0D25B5C
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 13:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD0A83CEA;
	Wed, 28 Jan 2026 14:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eu6DXKK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2622583DCA; Wed, 28 Jan 2026 14:14:35 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EAB83C65
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee1Z75z5S09zx9xEzArsnTwirS0LKsvCUH7FCxk/63m4i86xkK/e1SK7HYVHEsTkp3FoGiNwGvu31PAVoQWfnn8On+Z3txCljE54G8EiriJGBmRE7JZJje2FtrFxgxtzoZDt30PG6or7zGrFHPIUNWqZbfkQN2WZZg4b8A7zqcTj7q7+hb/eQPUsvMjxq1HIBu+dlpnkXFKrzjsBt1u/U31eHbgd4FCNmdHaqJyOITWWR+389E0x63cVSh3koT05LftHgiZGHZRwqaViseLvGxq1ahSDgtXKGtKe5lQWNwvjOjckasVMnUL1Uns2UtntCWK9uqA6KYGKu8xlKYUf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWdberDLmOcGdCNRypYfA4dSqu36yDIxUYACynX/qTA=;
 b=QSmBd0uvc7y2Bk8RZrp3NYrQu/TxbdRBec7RtyABO20KfnmA1TlU5kqOSIG3b3iOnLfwbAqfA/FuJd+wYdvikj404Uw9WUJXGwBbmhCojakdCDXIFNO1oD9oSxTgtE2+jU0MsQo3Z9JadNwroSPTTd1kD1RLLQMPiyE7hhEVboZydGXQ52PydYHBUTpKC2GkdV5wNkB6vLJwlgMtMAQ6RemQpAbhv+c0r0RH8nB/OCN0HwhwMAqRL9LeietE7MbVDBFfFTvtxK98tEsfbK0Ul2/qWX23hl2ZTnNUXIALf3G4JJxuaIGlCjT/zsOQyM3cOYiVbGgOhhM5CjeDG90lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWdberDLmOcGdCNRypYfA4dSqu36yDIxUYACynX/qTA=;
 b=Eu6DXKK1t9Z1iRgLiBYFYcQYJuK6Nm0Aj2+NDgetalGRKPfnv3UL63vuDQfJKQypcswRRfEqwG5v/QPKKRgKPJVibChhffXQW+vqM39p73CsbZ7S/n/YY0zuajlSclKcSj5u3NiEFYTv6rNEsLwv+OOL80Ew4TdpVGVrlhSMI6o=
Received: from DS7PR05CA0089.namprd05.prod.outlook.com (2603:10b6:8:56::6) by
 PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 13:14:28 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::91) by DS7PR05CA0089.outlook.office365.com
 (2603:10b6:8:56::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Wed,
 28 Jan 2026 13:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 28 Jan 2026 13:14:26 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:14:16 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 07:14:15 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 07:14:15 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SDEFAU2008675;
 Wed, 28 Jan 2026 07:14:15 -0600
Message-ID: <ce64abb6-220e-4757-91b6-b6f19ea7ca34@ti.com>
Date: Wed, 28 Jan 2026 07:14:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm: dts: k3-am62d-evm-binman: Fix device tree
 reference
To: Paresh Bhagat <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <t-pratham@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
References: <20260128005453.1387483-1-p-bhagat@ti.com>
 <20260128005453.1387483-2-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260128005453.1387483-2-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: da96a29a-c109-4f50-0b37-08de5e6f29e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWJIVzhCZnIzcWFTRmZBbGlXSkNDZHdHVy9YTVNtUysySHNZenVCSElWclZt?=
 =?utf-8?B?aUE4empEeFMrYzExbkZzNFFrRVcxUjBTVEZFbVI1dHFCSm9IZUR4WFRRVTgz?=
 =?utf-8?B?eEV4NnZqSUF0ek9pMnhnZjMzeVdOKzhNeVdRaXMwbkVIZ2ZPN3Y4VW43UEdI?=
 =?utf-8?B?Zm8xaGJJTTJkK3ZMc0RzTlJCb1VjMlZQb213Y2VqSVdHRU9BNlN4bS9rTTk2?=
 =?utf-8?B?cmFjSUdoWnlGOHo4V2c0aDNDNVpjZ1pzVmp2OVl6cy9acEVGVWk1RExjUTdv?=
 =?utf-8?B?R2tJTi9KWEp0VlpDUzZaR2l4R3pCdUdzWEo4OW5HOXIyRlVDNFdhM2NZd3ZX?=
 =?utf-8?B?bzZjUm5wbzVkN0NDM3B0QUJydXRuV1Q1YXFYQTVNYTlWT0xGMGZUdWQva1U2?=
 =?utf-8?B?KzFOZ2RmU0hOd2lUQnBuQ1l0YURHUTlZTlpISXhNWk0rcHFPS2hOQStTWERt?=
 =?utf-8?B?a3hqK1FnK09jQmZEb2lFa1kxSTd5N3lZdVM0L1AyUkJUMkV4SWMxRjJkVkg5?=
 =?utf-8?B?VzVIMk0rWWhFaDlJYWR0T1FWS0xEUnNHWWg2K2g4WitRYzdZdFNJMG9rRUo3?=
 =?utf-8?B?Nm5zRFpuZUg2QWRaUkZ1ZWZnN0ppZklTQzB4Q2h1dWFsaEVSbHZOUUhiVEZC?=
 =?utf-8?B?bGRjek9FTFA2bW93VEZkNWxpVzlFb2tLQStTZE4wZWFPNElyTG5OUHhpUUI5?=
 =?utf-8?B?cDBvbXFETzdaSXgweitJZXdQcE1VSzBqYUEvYm53dUlkYWpVR0ZrcTR6WTNE?=
 =?utf-8?B?dlpuNk5IR0x6OEkxRFh0N2pxa2xhWkZMd1JsRUhVM2JranB2bEhZZ0tCckpk?=
 =?utf-8?B?cC9Pb3o2NVp6WFJFaHFCeG4rVkN0ZkRlQW1hSWYrMmNVR29aQlVCaDFzNTJq?=
 =?utf-8?B?cHRXVkUvZER0c21pUjk5OG1yRVRzQ0JkWGY5WkVZanZjR05vNVVTUG5qblox?=
 =?utf-8?B?MDdiUUM5alBBd3cvUXBxTGoxdk45T0xZTzFqOGNaWVJDanVmVUdGVDBrN3pq?=
 =?utf-8?B?dTNjOGh3a2kvbHZNb010WG5sd2FpdVRBM0FrT0QyZ0E4T0xpZVliU2dpZ0xX?=
 =?utf-8?B?S1BrY20xUmhjcG0yaG52VUtQcXRkbjdvYkNkMlBkd1ZNbWEvRUVNTkl1SWF2?=
 =?utf-8?B?RExQa3dLWisrRmYzaTVYRzdVU2tHOVpNVk5Qd0lGQ2lCZkN1VHlVZkhTRFll?=
 =?utf-8?B?TEdBbUNWTTVudDRMN0k4RE92aTNWSWRLdkFyRkJoeUZjd3BZYU9ObEtXbHd3?=
 =?utf-8?B?cUY3dHp6U21EblA5VUloY2RrTXFhcTg3TjlQaHNYV3c2a3FGQVZ0Z29YTFZO?=
 =?utf-8?B?MGVZWUlXdGZHQy94L0Rianp0RUFLdkJodTRMUWlnOUR1c3VLRjB2NkFKbFBL?=
 =?utf-8?B?VDB2UDBjdEtCQUtwWEU5b2tDR0xmNTdmTUx0OEM0a1BWR1hNeDZYeTNScm5j?=
 =?utf-8?B?ajdjenM3blRpbThlQk9IM29zYXRQV29qbW00WUhQbFlCMDd1MDFXUmdYeG12?=
 =?utf-8?B?WGQ1UHI3Ynk0NG40MVlVSVRGdjQ3clpaUm9KcmxKZ0lwWFpCUnA5QVhxTlA1?=
 =?utf-8?B?eVFwL0Rma2EzV1E5akZORVRQOTVWL0w1cmNSZFBvZlB6MkJtblJZUWxUTlpp?=
 =?utf-8?B?VXppbnAzTmJoenJ3OWlydUl4Mk1jK1I3QUZFSm1idWh0cUttZWpEYU9lL2hs?=
 =?utf-8?B?T3V2cUR0RnAzMGNGRWNIejNETUJGSjJiSDg5ck1lN01nUXZZYzNMR25ZdGNv?=
 =?utf-8?B?TWs1K3hLQWp6d0ZTaFpFakNjdkw1TU1TMlNDQjJWVHZQRy9NUEFFeS8wSEts?=
 =?utf-8?B?OVNJb0dzWVNJeFdZUC9MWWQ1VGh2YWxmTENPZndSeXdsdG5oSnlYbnlaeEx2?=
 =?utf-8?B?WEFuUm9VUXY3SG9QSTgwT0pDVWcrN3pRSUNGTGNTMXBkMS9RU1p0enBvZXZM?=
 =?utf-8?B?MkhxNVF4SDZaYjN4cjdMbHpEVDFDeGdwemZTQzBqcXlSbTN1SFVQYUFzSXU3?=
 =?utf-8?B?U2ZCTnhneTAxTDl3T0tyVlBqZnV2V1M5c0hXYmxXbFpXMDhuNzFBZTVjY1Iv?=
 =?utf-8?B?Y0ZwSEpEWjdmY3JleTY4OVZxRmVvVVFFTUtOcUlCSGZjZzBoZTQxbko0R0ZJ?=
 =?utf-8?B?aldvMGpYRURROVE3d3E0TEYyUGtGQkYyZFIrd1hVQkNVYXJYUFIzZUt6UUwy?=
 =?utf-8?B?aHc9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:14:26.9737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da96a29a-c109-4f50-0b37-08de5e6f29e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
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

On 1/27/26 6:54 PM, Paresh Bhagat wrote:
> Fix ti-secure content reference from spl_am62a7_sk_dtb to
> spl_am62d2_evm_dtb or AM62d dtb. Also remove redundant k3-binman.dtsi
> include.
> 
> Fixes: 14dfa6b86187 ("Add initial support for AM62D2-EVM")
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm/dts/k3-am62d-evm-binman.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> index 3a0ab9f8b2b..41c8746cf08 100644
> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> -#include "k3-binman.dtsi"
>   #include "k3-am62a-sk-binman.dtsi"
>   
>   #ifdef CONFIG_TARGET_AM62D2_R5_EVM
> @@ -72,7 +71,7 @@
>   	description = "k3-am62d2-evm";
>   
>   	ti-secure {
> -		content = <&spl_am62a7_sk_dtb>;
> +		content = <&spl_am62d2_evm_dtb>;
>   		keyfile = "custMpk.pem";
>   	};
>   

