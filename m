Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B74D2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3372183A2D;
	Tue, 20 Jan 2026 09:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f2R/dq+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0098483A83; Tue, 20 Jan 2026 09:34:52 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3741839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7SeEIDk8nWkPKIQj8h03Yuy5jfFpQyob1XHIWnv5vbExVQuIweL/89p6C+uJf6zdvkMZ44xID43u90XlJxCz5FRFy/VP17ybYUCijeZTPxB3noMcIGganDCxMyvF3WT2qHpJ5Lf0YnQCjEPRcJ29yJ+L7czt8hKlhV6WbPiL5NT7keSs09qtjyBalB/xze1nMxAsp2TcUX+RF/PUxF0DxnkqYYl+7blKTuDK0rZTpif5DrQbeq0C6NymL/4QdpOG7OPau9HJEVRE1Lf6Ym9IjlYSuP9pSVKxl6Gma14AwACL6eXbGWzuADsu1KPaxqH4QUBgMuQUzmSsMo5AH4c+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVmzofogIERqy7+A+Jly/61M1960Wav0fTPGiyFLf8c=;
 b=rpjvwFhF8IA0KIhybXN0RguGrOuYm4umw5+E5uv73fg7XrxOEblwaXgjZphyg5lrcsw77e0+//z6Z2QVylBiDt7th4c0RjXNyoHNP31FrNLGaZ1KjZuo+DdJ8W+t+0KJ1eiMrA4j+080DxNJZnwk4ciBO+rSg00QUQYuWUWLvQ5eD8XYmVYcIVwynag/YgtzIr1U9EpIkr1xFD2AnScWi5iAkBg426bSzv5g8MLkx28WOoIAix98mjXHCSB5+4VOVFi6saiqB8HIdEv3xxwEvu6IEnq9Zl3msh6pX6kzDaZL+3OGDra/AG3N81k3Fpme1XuPuc0Mml0MyPKN/mGvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVmzofogIERqy7+A+Jly/61M1960Wav0fTPGiyFLf8c=;
 b=f2R/dq+8DslNTNQDkWlGMdBJUtAe/IFxye6K32vL88B7cfjjxeRR1TqRX2vJcFEyihlYoS7bUJCOA2yLCtJK9+cSCQEWAki7CU/Pt8jhpCkh4asXnmScxtSLYvUWEcPU/VBx0ivP39nHn+0E8Os1dhBzVNxTgS5Bh+GFaSLQs68=
Received: from MN2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:208:239::34)
 by IA4PR10MB8688.namprd10.prod.outlook.com (2603:10b6:208:55c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:34:46 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::f0) by MN2PR08CA0029.outlook.office365.com
 (2603:10b6:208:239::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 08:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:34:44 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:34:43 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:34:43 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 02:34:43 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K8YeVH907391;
 Tue, 20 Jan 2026 02:34:41 -0600
Message-ID: <775f2dc9-419f-433c-a28c-74e0abfe63cb@ti.com>
Date: Tue, 20 Jan 2026 14:04:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm: dts: k3-am62p-binman: Configure firewall for
 ATF/OPTEE
To: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <s-tripathi1@ti.com>,
 <k-malarvizhi@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
 <20260112093643.885903-4-s-joshi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260112093643.885903-4-s-joshi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA4PR10MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: ef49fd3e-58ce-4305-3672-08de57fec376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2VzNUF0S20zQWpyL3FKeFEvWmJGa0pWZHZOaTl5QzBKSklhWmpVeTl3c2tL?=
 =?utf-8?B?MTVmOXFTY1FEcUplb3ovdmtmTzR0UVdCaDVNNWQ2ZE5udC9HZWJyQXFUejF2?=
 =?utf-8?B?OGh0alRvMXUrbW0zUHFPTjQ0YnJXTlhWelFCNFNEYlBMK0RsT05QM2hwMG9T?=
 =?utf-8?B?b29td25SelFmeWc4OXlYUGVKdndzTk1YOHRBcDR1RUdGZ2FFZEhyVnl0a2Iv?=
 =?utf-8?B?VzdibUg1YXFkeHl6OXZUbU5Za2ROekd1U3lpS0dvSXM3b0UxeXNUYU85TEM4?=
 =?utf-8?B?cy8zY1NVTlpRZFhvaDhiMm82OE9hNFd6VXNsSTVETGRqRmFlMkdIUmtwTmFU?=
 =?utf-8?B?TUMxMm1jSloyWGdTSzFoQmNCd3E4VzJBeGV3dFdGZnM2UVMxZ1RkUFJUK2Fr?=
 =?utf-8?B?VzBzcUVDZTVZeldVZ3lhakZRZFFWTzQ1bEpkVHFKazF2ejZVdS9ZTm1wa0R2?=
 =?utf-8?B?Umw3RUtQZERzcndXRnBpcHJ3SkZURUxXSUMrUlZrTVBROWZ4dFB1bWtQWEZP?=
 =?utf-8?B?TjNFN25QNXZxeXZuV1FLT1pDOE5pTFZuQzVsRXlLT0pLcG8rUHNVdzJKRnBG?=
 =?utf-8?B?T0pBUHBNeXR6MFJrYTAyRXlDZDMya3cwTStLTlBuUWp3VXd3T0didlpLa3Zw?=
 =?utf-8?B?S2g0SWgrczdiT2NtQXVUd2liY2w0TUhiUjByK0JQK0hFM0F2RmxqREVCdXF1?=
 =?utf-8?B?OG0vQnRKV1RRTU5NcVd6Rmp4dFN3alNEckhWejkvOTErWXdIcFoxQVZwZnlq?=
 =?utf-8?B?SnNaaXVhYmdVNDF1MEROY2tGTWlvUisyNU5GVjBpNDNodXJQclFaL1RFUUk3?=
 =?utf-8?B?NjJ2Z0NlbWNRZ3J1QXJRRUZwQVI0dXR0d3JoUUJScGphb3c1bXRmWjQvK2sx?=
 =?utf-8?B?UGZTZHVFZjZMK0lZNUVqL3QwMjlEOVRya1FYd2lEbEJvTFZQYk5jZ09XOG5q?=
 =?utf-8?B?YUtQQ3FqUWtFbG1PSHpyMUg5dzhoVnJ5UlVvbUdUcDJtMlN0T3ZSV0hESGpF?=
 =?utf-8?B?MEdFUnZpOEN1YThJZTdIa0QySWs1ZEs0aDJoUGh1SEVNRDBmUVZFL0ZCMGNX?=
 =?utf-8?B?Z29yRXV2TjRzcXp3UlV3RnArNzZHMzN5OXJPWW4wQi8vMmRIb1JaUGhXWXBv?=
 =?utf-8?B?YjJmTWFRWE4zVVdvRHVWSEZSSGZ5TldKK1BKdmpOVDkvZmFIUnV1NTg3TjBr?=
 =?utf-8?B?K200KzZBNlp2OEpaRjR5QkZjd3Q0NGtlL2RxZUwwbzIvMGIzZGpic2tTSWhw?=
 =?utf-8?B?RDBUMHlSRytIc2E5YnljelozYk5SQ3pVc0NNSElRVVB1TUQ3LzlNMGpvclRq?=
 =?utf-8?B?TjNyRC9OYUlyMy9paE9GdjRUaXc1bFpOMzRHcDErMENPSlpxNzEzYlNPaVRX?=
 =?utf-8?B?Y0lLMXdVVVkzeVFNdXQxeWtGR09ncDZ1MFBvNzNHSUI1YmFQMTdENEJrNjVr?=
 =?utf-8?B?VXNLQW1oR1dEVVN4TmtFV0RRdXJhLzZsR2czU1FRcWUxcCtrSTlGQlMyd2th?=
 =?utf-8?B?TDFtRWxyWExrcTFaeWJMR2JSbXFtcWcxR0I1QzVRM05nY09QVm1KTElqRGwy?=
 =?utf-8?B?RmlIcUxZajI1YVVFd2QwdGdjSjMyV05pLy9FYzF5WGl2d0srZktIMUh6Qlpr?=
 =?utf-8?B?dk5vNlUybXRPaGhSS2ROaFpKanRVbmdXcDZPcE4yR2VrNk1KUkJNYmRJYUdy?=
 =?utf-8?B?MnRYcFVIVStyR1hzd3ZHNm5iMTNSbGxNUVRTTkxrYUdTeGY0Zm43VHIxWmgy?=
 =?utf-8?B?K0dqRy9pRTVNdjNaSFBkY2gwVFJUQnlONDduNGdYREQ5bVpsVXM1WmVrdEtX?=
 =?utf-8?B?ditVdk9tdllTUE1KMzhIcjN0d3NxR3VpaDJ0VkRwVTNzR1FOQU5tYm9jeGtl?=
 =?utf-8?B?RzBXSllKRXpJNFFuNlpPRjVNNTZ2ZHhWaFk2V24xV3RLOWZtVXNRdXN5OGFE?=
 =?utf-8?B?RFdXOFNRellkV0RSUGZLQXo5N3JMWnNtTUh6NDFFRGVPVDR0VDByRXVQUldZ?=
 =?utf-8?B?Z1BtQWN0d1hkZlBFOVZFUnNQcXh3Z29DdEwvaFJLSkpmYmFJMmpGd1N6QStE?=
 =?utf-8?B?RGtzUnMxYVUrcmNvdWY4czhmeXp1ZHR5Z3prNWFEQzhYVDd5bjYyMUFJTk9B?=
 =?utf-8?B?QVpsUlYrNnV5aHFjWm1OeU5qbjJoYVltK0s2RFFUbHBHU1kzZ1pMZnZ2Zlpw?=
 =?utf-8?B?allwQmpIdVVGUmVpZGlFbmNBdEZJSTkzTjJyUDV0MzhwRVpLQll6NkxIbE5v?=
 =?utf-8?B?RkZ5REo1WnlRUldjaVRLRTdYRWxBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:34:44.4537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef49fd3e-58ce-4305-3672-08de57fec376
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8688
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

On 12/01/26 15:06, Suhaas Joshi wrote:
> Add firewall configurations to protect ATF and OP-TEE memory regions
> from non-secure reads and writes in AM62P.
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> ---
>  arch/arm/dts/k3-am62p-sk-binman.dtsi | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> index e1443d6226b..96c06c9ac77 100644
> --- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> @@ -217,6 +217,39 @@
>  
>  		fit {
>  			images {
> +				atf {
> +					ti-secure {
> +						auth-in-place = <0xa02>;
> +
> +						firewall-1-0 {
> +							insert-template = <&firewall_bg_3>;
> +							id = <1>;
> +							region = <0>;
> +						};
> +
> +						firewall-1-1 {
> +							insert-template = <&firewall_armv8_atf_fg>;
> +							id = <1>;
> +							region = <1>;
> +						};
> +
> +					};
> +				};
> +
> +				tee {
> +					ti-secure {
> +						auth-in-place = <0xa02>;
> +
> +						firewall-1-2 {
> +							insert-template = <&firewall_armv8_optee_fg>;
> +							id = <1>;
> +							region = <2>;
> +						};
> +
> +					};
> +				};
> +
nitpick again: one extra empty line here

> +
>  				tifsstub-hs {
>  					description = "TIFSSTUB";
>  					type = "firmware";

-- 
Thanking You
Neha Malcom Francis

