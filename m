Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06BECCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C49C83968;
	Mon, 10 Nov 2025 10:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j9UYuJRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C773483990; Mon, 10 Nov 2025 10:22:06 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8800083959
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNUpHkUVndjq4exEF7bL6oDlHqq932ygiy34CC5cHog8t4DeYDXec6UMhi1A2kmx9kjT3dtjdDZOhpHa6xG4qsXU/LA6uJGF2J80F5xZYR3Mv1SYnW2XdiSDAvWDbFOKr7pPpzy0eIQORoOp7zYlS8rD8jexDL1pSTG+O4To+sYsFx5wZmcuPQKbz62kjQuLhwfYMpoOwdqJYH7za6rEPAYB92cyYptFHVRTgS5ogynxcJ0a9CcQ90OKxQnDmV3LA0pgbRarqE9Za/TzReZCfjJ83ZYTt6d5unufVyVYtiBtCLAiZJMA2dzxvTt3+5J4BQDlzQ3uVUr+3Qk/tN4CWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S4nMBKXy2KfHrJYBWO8AaFJIEXa/NaXM0oA9a1o6II=;
 b=GLgmY0fSq0kl0cE39LExmu/152gzMYbyrAa4NIFlUG2N/ZrHfhaSGEatCV5BWM+atXO34qoV12JGdXq9TELitP5uom8R8IiZ1CCmU9Eh3eBkNFEBzQyB9SbWHd1dTUh4chA3IP+iLL3WhPSxgfpz85IWoyEoIfAK17NLvhs6aisT3weaHFQc20P88epZOlmPRKSzQzLETlh17RIH5dtQ13lbiTIYNodTQvYgjfG1S4gCYbcexLutUSr3SvcO1B0CE3bALVwSwZAuaD9SjsdhSbA0zWeyJ1JjmKQlABZ9drRTjRgoJ7Wf355jc46ye4q3T1tpSw59YEgXmoqcLFrEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S4nMBKXy2KfHrJYBWO8AaFJIEXa/NaXM0oA9a1o6II=;
 b=j9UYuJRAykDNcX/jC+TgMBBWryc4v9Yd5pGe61g+4chHI1PDNZFgxbjls/Klxbv6CwhwPq8T2K1FIT1rG7RNxxIJw+l2w6XLsnmyM73jhKW43JxdkVWiZNHdWYM5KK772eD/30fTJDO2C9LkxbU20KepT3LF7mOQvtyY1fbLCm8=
Received: from DS7PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:3b8::31)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 09:21:59 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::df) by DS7PR03CA0026.outlook.office365.com
 (2603:10b6:5:3b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.14 via Frontend Transport; Mon,
 10 Nov 2025 09:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:21:56 +0000
Received: from DFLE105.ent.ti.com (10.64.6.26) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 10 Nov
 2025 03:21:52 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 10
 Nov 2025 03:21:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:21:52 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9Lppu3130059;
 Mon, 10 Nov 2025 03:21:51 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Nov 2025 14:51:50 +0530
Message-ID: <DE4WKRML5VTN.1HQSCYE9S8XCY@ti.com>
CC: <stefan@embear.ch>, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/6] arm: dts: k3-am642-evm: Remove duplicate node
From: Anshul Dalal <anshuld@ti.com>
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251107130216.3084134-1-dev@pschenker.ch>
 <20251107130216.3084134-2-dev@pschenker.ch>
In-Reply-To: <20251107130216.3084134-2-dev@pschenker.ch>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6069dc-ec91-469e-eff9-08de203a982d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmorYzdBMzMrQ0hiazR4aFVHZVhaOThOVXVBczd4NmJXOVliU2tKN3kyWnZW?=
 =?utf-8?B?Y2JMODY3Y2FtQmQ3a3k2TU5pSTJySm0xNXRBSXZOLzhJUHJxV0Z1citZVmJC?=
 =?utf-8?B?NjdiWEUvYWhwSmF1RkQxM3luQ3hzamozUnhlTHMwRFk3VU1XaFFESGMrcWxR?=
 =?utf-8?B?OWdMdFplRWIzNk9CV0FYTVJ5Vkdad1BvVFhjcUdBMDZKbE51VmloMVoxZm4r?=
 =?utf-8?B?K09OS29JQlo1WnFVdmZwMlVTc1FTdVVCN2JuT3ViUnE4ZkNNR0h3QzdZaWJB?=
 =?utf-8?B?aWRwNzlPQUVrdEllY2FMK3dtVExoaThXclloR2dOQ2hhVEtmcllNZkU0eit5?=
 =?utf-8?B?VXdKZnF0ZzJjVmRGK0pROEx3OVVIUkZIQmxMK0xzY2JTaHd4aVlpM3F5cS9t?=
 =?utf-8?B?MG9TQ1lLczZkL0dOOElVY3hESFNlQmFDVFkxN1YrWjhwanNBMVlCeWlPRkZ6?=
 =?utf-8?B?bVlrRzljcENVcG9lS0xQTW45M1h0WGtvVnRLbmJTbXIwY1lqZGdSVzBYNlYz?=
 =?utf-8?B?Y1lFRWEvZ0ZHcG5WQkkvR0o5cmdtZm9xa3dsakt4NUhyN2l4SlA0TDlSb2RJ?=
 =?utf-8?B?ZHNwTlVNMWo4ZUM2Zkc2ZTF4TExxTDBRemI3T0V5cWJvYjdxdkVTZGtOYmNw?=
 =?utf-8?B?Qzh4TmtLcUhkS0EyYy83TmxGOG1iTTBVUk1hMzlRNndSYjlIL3VtYjE4Q3l2?=
 =?utf-8?B?Zm0xb2NiSVU5YjN3d3BkL21TM0lZcFhZRUNOMjlXZzJVb1Vra0duU3BLWWl1?=
 =?utf-8?B?UnJId0pMNVNwT0Y0Sm8yaDExbzlGMzlsR29DR0JUZDMwMHZsYys0SXNPcW1l?=
 =?utf-8?B?amdvQ3NCUytacElBcXpSdkRNNkF2RG91a0tPUlFNTVZ6MGszOWdPMzdadU5r?=
 =?utf-8?B?aDRNazRabVFoYmtONjlxek5UcTBsaHNFeERCcWVQMW5zQzZSYy9LUjdBYkl0?=
 =?utf-8?B?N0pIdkJVYXdUUE9BeW9lN3hlMGN3dW0zTUUrRXdocnZmVk05eEZOV3FPZ0VE?=
 =?utf-8?B?eUtRSkl1UGRmcTR3ckt2SWUzUjdkVXc3M1I4MDJaRXJtd1UzcXMreFo4d0hm?=
 =?utf-8?B?b3Z6RllJNThVZFVzcXdYMGtxaENwNHZUNmFtVE9QY0ZzdG9TZ1RldC94RThk?=
 =?utf-8?B?OVhEV0dsSlNlckVnbzNaSTVtVm9lZWcvOGRDc2o0dHVPS0ZtQ213Qk1OWktC?=
 =?utf-8?B?TDRYelpPWWxZV1lGMEdoVFRvSExQZzZQd2JWcUpkNk1tZHNwK1BuVmR3YTFP?=
 =?utf-8?B?RDZLcFBHWHNEeHg5N2NkOEE1dFo0WDQrRWthMmhzYVBZL0JzdEpPSEVlclk0?=
 =?utf-8?B?T3lxSGNtb3pZWFIrT1p0enJtMEgxVmU5WEpCb0dzUlNORWlaK240M25uTjFy?=
 =?utf-8?B?Wm1UZU1uNm1tUE52N1dmV29nNmRoc0dmUnRrVWw3eDVvdk5LamZPT240bDdT?=
 =?utf-8?B?dGVrNCs2VFE0Z0ZScyt5YmxiWnNSMDR6Q1VReVkzNytkam1hdGZ0OURVU1hu?=
 =?utf-8?B?dEgveFlzS3o5V2FGalNlYjFqODl0MXpFZWJ1NHcvQVVGSmdmakdIcUNVV29z?=
 =?utf-8?B?djdZbVFqbDlyVXp0amtDUGJpMHlvb2o4R29ySzIraGU5N1VpdEhZRVViM3Ur?=
 =?utf-8?B?Y1FNZ0szOXluN3M4MHdXaEtCRkdrc0NkeTZaeHF6S3kxRkdleGZ1Qm4yWTNp?=
 =?utf-8?B?UTQvdEFqMXY5VjM5ZjJkcTF4ditjMHpoc2xpSXQ3RlRpc2ZUclN0aDVPZG5Q?=
 =?utf-8?B?Qit6MlBQOGk3SFdDQWgvaE9zanNkKzVQV05qZnFPaU84S3FPNStQd1NpWXBV?=
 =?utf-8?B?WWFuWndhekc0aHI3cmV1M1pVMEU2TzRWMnJmNGkyRENmREhadURnQ0xMUGg0?=
 =?utf-8?B?bXl6aDhGSmJZMjc5NVcxeGdPVzgySmVaMXlnMTV6dERMbXNXTXhhdUl3RWxn?=
 =?utf-8?B?RFkwYVJZcEUrUmZ0RnZzcTZwNzFMMjArZTh6Ymc5NFhSbjUrZDAvRnc4TklT?=
 =?utf-8?B?RkJhYkNQMFBtZnZzdHdwY3dBaGVFdXkvYkVPYVJpWlJDSUphTjRXb3ZTR0tE?=
 =?utf-8?B?eFdwMFRpRGFQL3hESDVmcG5lOSt4Tk9LaDM0aUZpOFJ1NVRpenFHT0lwRFh0?=
 =?utf-8?Q?J8XA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:21:56.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6069dc-ec91-469e-eff9-08de203a982d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
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

On Fri Nov 7, 2025 at 6:31 PM IST, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
>
> The device tree contained a duplicate DT node 'main_mmc1_pins_default',
> which was already defined a few lines below. This patch removes the
> redundant entry.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

> ---
>
> (no changes since v1)
>
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am64=
2-evm-u-boot.dtsi
> index 705b3baa81cf..6469f43fca81 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -19,10 +19,6 @@
>  	dr_mode=3D"peripheral";
>  };
> =20
> -&main_mmc1_pins_default {
> -	bootph-all;
> -};
> -
>  &sdhci0 {
>  	bootph-all;
>  };

