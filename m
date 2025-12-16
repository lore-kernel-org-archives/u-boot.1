Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A442DD5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 05:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E5580077;
	Tue, 16 Dec 2025 06:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rJgMeooq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76641800AB; Tue, 16 Dec 2025 06:20:58 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044DF8003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mchCKgwDKJHmRpMAj2d3cOrtc7fOAg06ogQ+zNplNinZnBkXcWsvu4X3lIxVdg7Nb3mS/wdHpclVshXdSg6k/fl1rS/kbj3gIQsU9cZPzufRwINpuCcTnq0KzIs9ukmEMHSo3bBtRj6jeF4Wl3/9H88Cyc3vk9wTuYSe+EXczOkPeXzwGWvGjuChnjHsK53GVMB1UBXGMqW2jRF72JBe66zS0JXHuUjkMJOBG9YWgyq6drD5XnojFrMFAxs7KRmbcuTBxK5p4Az1kWil+7mQ9znKZqft83a2tHhu23IDfSU3rzgfR0edtoFbFPmnK1TAdxSjva5nC9V+9Xovc269WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QldycSYTNvgJLJHHtBSfba+lZcnERS7OzaJjkrwyozA=;
 b=TIhpuLnYdOwMvTWa0XhdiFOxeMQtg/1IluOUag0w1QoNQG1x6E7N/m54i++lwvwe3JGhI0qYObRXG2LS1BpT5Byq0moDIH6VsSSO5XAGXAv5cB3trp11MtLArs/mHetliTZkmHodpYZKMZ2F76r+ICvrTC+klsXFBO+tg7n7hOy8Dup1MRPft5YXRGckZDBcsnrOD0E1a7LBSE7Bs/wevoGKEJVp7seLsS1XB1EsAZB8QCDi10ZpdmSFAi30Wu/Ee13MKZpaqZkzs/pDXUr7NmsEZXjYkeosjrWlG+ICR2haV59rx2yxwV6A3H3X9SBJPwwVzY1WxuMWlE1nPDZp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QldycSYTNvgJLJHHtBSfba+lZcnERS7OzaJjkrwyozA=;
 b=rJgMeooqlqgTjlfVmdgB1ai2xgf6y++YuEQ0IcHwGEudKACRElZyqUWri6yekAemC/ZouZID3SNE2cktApeqNLtEM2gIjUEimlminXEidGKLkQeoAvW05RxgFv8ZEp5muwSyQfCOc1Q80iUVSP3Zb1c+5FAcWXtZDvK2CuYnthM=
Received: from BYAPR02CA0030.namprd02.prod.outlook.com (2603:10b6:a02:ee::43)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:20:53 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::cb) by BYAPR02CA0030.outlook.office365.com
 (2603:10b6:a02:ee::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 05:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 05:20:53 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 23:20:52 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 23:20:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 23:20:51 -0600
Received: from [172.24.20.7] (ltd1nqfk3.dhcp.ti.com [172.24.20.7])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BG5Kn1l3529684;
 Mon, 15 Dec 2025 23:20:50 -0600
Message-ID: <13702aaa-1468-441d-9647-6640ffa10147@ti.com>
Date: Tue, 16 Dec 2025 10:50:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j7200: Extend firewall for ATF region to TIFS
To: Prasanth Babu Mantena <p-mantena@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>
References: <20251215104623.1665884-1-p-mantena@ti.com>
Content-Language: en-US
From: "Chawdhry, Manorit" <m-chawdhry@ti.com>
In-Reply-To: <20251215104623.1665884-1-p-mantena@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: e57b1d2d-8a21-4118-7b3f-08de3c62e262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnpORElpb1lsVnVrN2h3TjJONWRDajczbElQUkJzMDR6RWZobGpSWVVYRkZt?=
 =?utf-8?B?UzlTeldkemhFMlBST3JZL3Nocld2NWlIS0dlSjE3VE5HWlRpdUlibElYOGlh?=
 =?utf-8?B?UE1XSlpZUEthS1B4ZHdOS0VDUDBoV2ttMlp0cGE5bFdSU3RQMURibWlLbXdB?=
 =?utf-8?B?Qmx4Y1lMM3dKb1U0emRrNVhBMXNvWDFsZjZHdHlPVFpqWDUxQXluVG90N3Nm?=
 =?utf-8?B?NHlOSUxVejJrcm5NZDBNTW1kUi9GYVNRdHgvZW9zSFVWaWZTbUlvYjJwS2xu?=
 =?utf-8?B?YjJOWHpVRVY1bkVxNjVmWnR2Z2E0ZEZxTlo1SXM1RE14akhMS2JvK3pSRVVC?=
 =?utf-8?B?LzN2KzZUbUxMQlIzODg1b1ptRm9RR3BLeE9WOVZWOUwrTHRWNnJnRGdoS3hl?=
 =?utf-8?B?RU8vMENpWlZNZ1dTelpvUmtna2xabHl1emxlYjQ4TGEralJ0cWI4Q1Qvb0pw?=
 =?utf-8?B?OXV6TTErd1U0dlZMN1BIYjRieUFBMnp5c1l6dmdrNmV1Mnpqeng2Smg1Z1Jt?=
 =?utf-8?B?M1g1KzdTRk1RcGdBWkdMck9HUk9WMEkzUjFVRHhoY2ZIYkh0c2hwZ3IxdHVu?=
 =?utf-8?B?MXZja0s3ekMxQ1VHeFFhc0xoS2tGbjkwRVFQaW8vRzJtbzhnTCt0dWR2NTZJ?=
 =?utf-8?B?M2dPRFprdUVCSGhQUjRGTzZ0THVZb244YUdXUG9yZ0dnWW5IVldVRG0wN2ly?=
 =?utf-8?B?UXhmUm5kN052bVoreDQ2aW1oQ1V5cldBSzFjQkdrVDZjU3VhUUgwWXJhS3Bj?=
 =?utf-8?B?ajhxSk9lZm5iNW1JT2JMNmxaR0VJN3h6ODRsdGtKUUdkeGFCVTl1b1Qwa0tV?=
 =?utf-8?B?SWZEVWt3Q2ZEUUt3bEV4dlVuRTJJcHdwME4ycUp0Q1lmb1d3MmpScHdzK3ZZ?=
 =?utf-8?B?Qk8zNG5hcGZUOXA5M3dLcDA4RnhWLzY2b01JT0paNTNqZXB4c1VnRFFYT2Ns?=
 =?utf-8?B?SHUzL3pzdFRoalNPK1RXeEU0NDhLcG1BY2J5UE9vc0NQOXJNS0NjNWtRS0lD?=
 =?utf-8?B?TmpYZnlwYjB1QTFPUkFpZ0lqNUlHdjJ2VkhLcThLMktpYmRWSWw4OEwyRUtu?=
 =?utf-8?B?N1I3OEp6RGNVMzVtUWo1MzU2emtSZ0ZpWDlTclhaS2lUd1N1YXQzdXpBVWlp?=
 =?utf-8?B?NUJrdXo2blVFaHYyc1drZHdtcFo1Wk9hT0lXU3pweTNXcWxGRVJiTUxKekZ2?=
 =?utf-8?B?b0swMXFNOGk2WWxDMEFIWkR3amhrd0YvbDNPUGNDY043MjlQYThJSjcza1hT?=
 =?utf-8?B?UUcvZDB0aXJRTzNuS2dqZ1lsZHJGVVVHMHJ4Umx5RnFmTjBRSHBiK1ZZMXdm?=
 =?utf-8?B?RWsyK0pIb3ZTSi9wY2xvN1FSaGJCcDluOEdkc3dzRHh6czd6UUMvVGNUclBB?=
 =?utf-8?B?ekNobXUxdlVScEM0SHJRa3cxejRXejNpdGgyeEdFaDhrTHpRRVd6M0Q4OXNZ?=
 =?utf-8?B?TXF2ZHErY2hBMWFLeks0KzdyQ1NWNzNEa05PeHBUOEwrKzdqeHlxUUFGa3pZ?=
 =?utf-8?B?NDRsR25FYnhVemJvUFJFSTAySWhjd2tYSGgxTHljWGhDbzJqVERUalFuQkp0?=
 =?utf-8?B?M3dtWjFVcUZkK29uM2V6Zk9jK0g4Y3Z1bkFpblZQWHdHZmRHZHNrYXJJZmxX?=
 =?utf-8?B?VTZ5WGVBWFEza0JVanI2MlNxdFR5SE0yM0xrbmlXUXJOMWhrOU5mZC9wK0dw?=
 =?utf-8?B?OWVDVTdxMmN6VTd2K2phcHU4Q1lrVHFmMlVkc3lrdXExY3Z5V251YTVya2cy?=
 =?utf-8?B?ZlBZNXBxank4dUNKblNBRlRZeE93UWZTWGFjYm9vOHlKMGphV2xWelMwNkZ3?=
 =?utf-8?B?aVkxbG1WYlJqQ0k0NWFNZmRDR1NyWjliMFNzTEo2NWIrTTVrRnFmZ0JPeklK?=
 =?utf-8?B?Y0Npb0NNQ2hLVFRFWi91MXhDVVQvWGhFL3hEZXlvaW1iYUt4anpPSTFLQnJZ?=
 =?utf-8?B?M2VySFdtT25MYS9IRXRKSWVTa3V3V1F5OXkrUDBaRTdCTlRRc2ZzWmdZbkFS?=
 =?utf-8?B?OFArUWNoai9mWkk0NXArWnlXblkreUVJajJzK1V0V2YvTXBtQy9jYndIZ3pO?=
 =?utf-8?B?UG8reWF5Szk5VU9CUzJsMyt2SWc2RUlGa0dqbjZlbW1JZjMwbm9IMjFPd0ow?=
 =?utf-8?Q?1dYo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:20:53.5001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57b1d2d-8a21-4118-7b3f-08de3c62e262
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
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

Hi Prasanth,

On 12/15/2025 4:16 PM, Prasanth Babu Mantena wrote:
> Extend the access to SRAM region of ATF to TIFS as well. This is
> needed for TIFS for encryption and decryption of ATF as a part of
> low power sequence.
> So, give permissions for TIFS to access this region.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
>   arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
>   arch/arm/dts/k3-security.h        |  1 +
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 761b1730464..6c5ebaa1f35 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -479,7 +479,21 @@
>   		start_address = <0x0 0x70000000>;
>   		end_address = <0x0 0x7001ffff>;
>   	};
> -	firewall_armv8_optee_fg: template-8 {
> +	firewall_armv8_atf_tifs_fg: template-8 {
> +		control = <(FWCTRL_EN | FWCTRL_LOCK |
> +					FWCTRL_CACHE)>;
> +		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD)>,
> +					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD |
> +						FWPERM_NON_SECURE_PRIV_RWCD |
> +						FWPERM_NON_SECURE_USER_RWCD)>;


I think you can use insert-template and insert the existing atf template 
in this one and just override the permissions, would make it much more 
readable, in that case I think you can add this template at the end too 
as it'll be evident that you are using the other atf reference and you 
can avoid all these override of template numbers too ig.

Regards,
Manorit

> +		start_address = <0x0 0x70000000>;
> +		end_address = <0x0 0x7001ffff>;
> +	};
> +	firewall_armv8_optee_fg: template-9 {
>   		control = <(FWCTRL_EN | FWCTRL_LOCK |
>   					FWCTRL_CACHE)>;
>   		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> @@ -489,7 +503,7 @@
>   		end_address = <0x0 0x9fffffff>;
>   	};
>   
> -	ti_falcon_template: template-9 {
> +	ti_falcon_template: template-10 {
>   		filename = "tifalcon.bin";
>   		pad-byte = <0xff>;
>   
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index b4e0ce8bfcf..72490fc7617 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -259,7 +259,7 @@
>   
>   						firewall-4760-1 {
>   							/* nb_slv0__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4760>;
>   							region = <1>;
>   						};
> @@ -272,7 +272,7 @@
>   
>   						firewall-4761-1 {
>   							/* nb_slv1__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4761>;
>   							region = <1>;
>   						};
> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> index 33609caa8fb..0b3f2cf3df1 100644
> --- a/arch/arm/dts/k3-security.h
> +++ b/arch/arm/dts/k3-security.h
> @@ -7,6 +7,7 @@
>   #define DTS_ARM64_TI_K3_FIREWALL_H
>   
>   #define FWPRIVID_ALL    0xc3
> +#define FWPRIVID_TIFS	0xca
>   #define FWPRIVID_ARMV8  1
>   #define FWPRIVID_SHIFT  16
>   

