Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FABCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 08:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D63983B2C;
	Fri, 28 Nov 2025 09:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hoc3qO3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D0384312; Fri, 28 Nov 2025 09:14:53 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEE1839D5
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTIe/s0QfosAJwwvaTiORZQh14fsEN0cG/3zFplSHWjZYFSyvoBwvZeuKRzDXpEiJH1YfSeAYUkpz+XZR9WZSKD82uJA7xztqrUOsVz6dnHXzj1yyYxfPItPYJpZtKN50vzBPxCIcHPr7k+77cmBXDI00rdrjGkRM88+uyYzACytx85NfQaH1dTBlLjxI8ELCpFw03P2XP1RMU33h84qHbs4ggGtyo90CqeRhOz/ABovixI3yPwAn3vDLQI+CigH1Hw98lc514E5VM78LO8MCyCiS3ZEZoUULERDBGQ0MBh2B1K3lhaLVK+7RtfDq/b39x2zVkzIwyZWjqNP+/fYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO8Y473QvtztkvMOjLU5gQxF+vrMN+MIOkBIGuSc7ME=;
 b=c/CdZmWohT9yf30p7oVOMfxvcJDwFRmapeIGX+N/JVyDO9fBn+J9NfTK0SCGhqLU2wmOdP0oBWA5VdbYgStnJMsRkKFkKDJzepvKzWV+j4XXlhn3Bf3PuLuxETxp/m+4pjGbgBfHjn64oqJOD/gOX4NVLH3YZX5eTSLfuFEA6GWU+bOGs46skwWvAJEtdnCDFOzyojVQ+pa7iNuL9+1pkLn6ngCwYDVhQc3bhAkU/IzW1xhs0LnM5oXP5yaOcf22qayTxeZj1tQTeMmHuNO/FeH6u1zi6qXIzLQiHDT7pL4tOeEvh8Yr2sF6jlAi1YV9ES7Qo83pk7T1WtyTi4MFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO8Y473QvtztkvMOjLU5gQxF+vrMN+MIOkBIGuSc7ME=;
 b=Hoc3qO3WZXMf9x0EtS09bPtx9CcKMfZCdNNRLAtSG7vEC9poSkn4XVr+3cMYxJkK70ondJYF3ww1sIuD7fMK/Nv/7gLOSdekojaEUAd2TpM/1eTD7uqytyGPAriToHR5YP2fGIFiLg7UVA5z1ZSPzWuCp77NIqx5zw9dPY78Eno=
Received: from CH5PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:1ed::18)
 by SJ0PR10MB4448.namprd10.prod.outlook.com (2603:10b6:a03:2ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 08:14:46 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c5) by CH5PR02CA0014.outlook.office365.com
 (2603:10b6:610:1ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 28 Nov 2025 08:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 08:14:45 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 02:14:43 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 28 Nov
 2025 02:14:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 28 Nov 2025 02:14:43 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38] (may
 be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AS8EeVG018347;
 Fri, 28 Nov 2025 02:14:41 -0600
Message-ID: <821d9b15-cc5c-450e-8ee9-2531d2ec5e85@ti.com>
Date: Fri, 28 Nov 2025 13:44:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: am571x-idk: Reserve EMIF memory used by PPA
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20251128064353.1295063-1-b-padhi@ti.com>
 <20251128064353.1295063-3-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251128064353.1295063-3-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SJ0PR10MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaa9515-c4fd-4238-70b5-08de2e563119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3FobFBRc0NDaEsvR2hXZWpZWjY3UFZEYWkvZEVlanJrZk9XRHRZY1VqcVds?=
 =?utf-8?B?d2J1eDAzdlZEVnR2ZHFNZXZqL2hOL2hocWhlMjV0NjV0WWxjbitRa3Uycmw0?=
 =?utf-8?B?MWxPNXJONG9DbGg1NCswRG51eXV2T1VvcDZjRVJhMHNKU0VYREU4RmU2cXZ6?=
 =?utf-8?B?NEJZWU5xUmx3cTlCamFLa3ZUVDdlalkxczRCYzRwRU1pcW5nNWlsY2hxMGNi?=
 =?utf-8?B?SDVZa2N0ZktJeW9jNGU0RHBZQ2Y4LzUyODBJSGE2Sy9HbTBEejFva1k4ejA4?=
 =?utf-8?B?Y2JRSkI0TmxhSE9kUWJLNzRNVC9JamRwVlR0Z3QvQ25TUWxvV0tYWmN5WDZI?=
 =?utf-8?B?S01jTXl3SlNoUTBtS3kyREd2b0ZWYzhyaVRicW5LL3ZKZ20zaGZhYnMxL0Z4?=
 =?utf-8?B?K3E2UVVNcHpEOW4zY3d3Mlo4Q0JTaUlmRm1Kb01nZjJvb1JWa2loZlcra1hh?=
 =?utf-8?B?ZHRpcnRrMnBaditmdkx1REpZbmVEN3ZFeE5FZ0EyaWJQVFIzTTJ4eVdDWWk3?=
 =?utf-8?B?NXZZdkVOZDAwc2ZEY01tR0Z4S2grOEFJN3JmeU15ZlhGdzlMT1RTbGJvKzFI?=
 =?utf-8?B?WHUvR0w3bFhkRFkzUVFTQTdXMnVmL2dEU29Jb3czYmVpL3E1REJBS1E1eGY2?=
 =?utf-8?B?cDkvWStCWHdjeE52R2hQR1VkR09qU0RkYk1xdElTOHZQclpHcDJYTWxiMUtT?=
 =?utf-8?B?cExsVTBxNTdoYjY2VlJPOEx1U1NmZnpTYlVpajRYUFpYUXRlbUpmcEhzcVFO?=
 =?utf-8?B?Q1JqdHU2ODJtNjcvYTRUNUtLVWdZS3J1bjBsSjFMc3hobVQ0YTcwL2FaMnlY?=
 =?utf-8?B?OWt5bWV1Ym9RMW5qcFZyOEZKdjZnOFo0ZnBIUDFWQ1hXY0hleUVGNzFDcEF6?=
 =?utf-8?B?RVp1ZDJ4STU4bUFPOUFwRmp6ZExtV2p2WklmUVJ5NDgza0hEQ1RaUUQ4blY1?=
 =?utf-8?B?cncwdlhubndJTzFuY2hscGF2RzVabCtPU3FGbTRXcFBJUHlzNCt3eHQ1cWRn?=
 =?utf-8?B?eXZjMGRxZVBYTi8yTlVMZGpqQWVsK1E1N21FT2k1WUEwOWpKeGVxV0ZwSzRk?=
 =?utf-8?B?TGtsc3FDSkh1N0EwZlJCUlZha0pwRnZvSTFhczg4RHdDMFI0WWt0R1JBaHRH?=
 =?utf-8?B?cjdWeUM0cklYNDdsQWpBckJuZEJwREhjeGJpMU95Znl2UG9UWml6ZjMrU3JX?=
 =?utf-8?B?M0ZOYm5PcU5tcFV4OUNVK2pQaVYxVWZ1WWhkd0RodUV1SnJqRUt1dGdIZU5J?=
 =?utf-8?B?bzN3SHBJSWtkNzlwTytWOHpuQ0NzdGZPOXUyTWVORGZwMm1zK1pQNklSYkFL?=
 =?utf-8?B?bDJjVUVobkFKVHhYcExSYmVKRnhiZGJEakRWUXRKK1dSTXNPeEZXVEZpNWpH?=
 =?utf-8?B?M3R4K0FKakVIRFFPSEJncWZaVUNSMnFrc0w3NUwzTXVVV1hxVVdRanlCY1VK?=
 =?utf-8?B?eVZVUGJwWlJER1NaVkZaejd4ZC94Y0xNeVRSNDlRMnZCdVozcHJTYVpieStK?=
 =?utf-8?B?K1pHaUs2eWJzdE0rUHNMbGlFc2FCUitFMFJ4MWRyRTcwYTBVcFZkRG9ETkxn?=
 =?utf-8?B?SC9yTjVkeXFiV0diN2lpTHMrNURNdEVHZEJhaXJ3dW1RcWZwRmRhR3ZKcHJl?=
 =?utf-8?B?U2hxd25VVHdDaTI5azdubGdMcjhIYXVJYmgxRE1tK1Y4RmlEOUpvb2ZvQVo1?=
 =?utf-8?B?WXZqQUo0VWc1aUU2QjZINXAyd3cwd29xcWIvK2RLRjlkaVNFWmF5ODU5THhV?=
 =?utf-8?B?WUZaUVhBNHFTb0thdTQ1U3NsWHN2ZmQycm9LTFpRajZaa2JOeEgyVTcwV2NH?=
 =?utf-8?B?WjBmNHQ2WU1mcUJzQ25CTzM4eHhVd2VPM201bE14MVU4U2ZpL3cyTGZKWkFC?=
 =?utf-8?B?WGc0VlI0L0IybEdzdWlsSTYwNzRrV3pCUVhkTVE4RVFoNmFUVUdJTlREOUta?=
 =?utf-8?B?a2xkWUQ2b0JkWTJ2UFZnTytwRXVwT2ZXWjI4T2JyQlFWZDZuZWNUN2theGl4?=
 =?utf-8?B?RG5uNXBMRFpJN2VuTFZ1eTNpSXd1aGZzcHcrVjF5ODFBUytVMloycWkxaFNE?=
 =?utf-8?B?cktJN0pNNHdQRkQxRDEyMkNrK1RMdGJDYWwya20rdm52Mmo3UUljWE5uZ1RN?=
 =?utf-8?Q?Ly2c=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:14:45.8524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaa9515-c4fd-4238-70b5-08de2e563119
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4448
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
> The AM571x SoC has 1 GB DDR space. However on HS devices, the top
> 0x2500000 is used by PPA and is firewalled. We should reserve this
> memory in device-tree so that U-Boot doesn't use that memory for
> anything. Reserve the top 0x2600000 memory (aligned to 2MB as per page
> size for ARM32) for the same.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm/dts/am571x-idk.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/am571x-idk.dts b/arch/arm/dts/am571x-idk.dts
> index b3592b22a0c..0cbd8c8a685 100644
> --- a/arch/arm/dts/am571x-idk.dts
> +++ b/arch/arm/dts/am571x-idk.dts
> @@ -20,6 +20,18 @@
>   		reg = <0x0 0x80000000 0x0 0x40000000>;
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ppa_firewall_memory_region: ppa-firewall-memory@bda00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xbda00000 0x00 0x2600000>;
> +			no-map;
> +		};
> +	};

You will lose this memory on GP device as well .

I suggest to have DT specific to HS device, or reserve this at run-time 
after detecting HS device.


> +
>   	leds {
>   		compatible = "gpio-leds";
>   		cpu0-led {
