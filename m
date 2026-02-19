Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3928E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687A283A47;
	Thu, 19 Feb 2026 11:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aUdlRC1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FF283AA9; Thu, 19 Feb 2026 11:52:23 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E859D83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljYPkkd7mmHByje+fP0aaZuToJ6fj1ToSOLNp0nqW0srmkb0EelDzIelcEvGnu1ck2L+/HjBV5NDeVOIgiqA28jYL5Gy9KeR99rQIeYrjL1UAXWU8h6FDTIxEAT5gS3rnqr17S3SQCN2uFAqzXgGQvV+TTCdJk6WO5X0YDr7TjMlP7ucZqaciqwgSVqgR4QNoeVwXhw5mMbUCHa126YCtQ42onh+csplvDIBYN0Q5bi3bEddR9ZOb3gxErH7f+RMRG16/lSD9hu+hBsmRKughebnwK4ptLq4lJwu+u6mLFu0jF8QmDSGgr43StjCFiknowfoaa8ANgJZlZ+Td9tOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNIlpBMuG4jGPNoZIhD17N6Uj7erxgWk0C3byA1KNfM=;
 b=zUfdsPB4ctFRDA2ceSgKQOa57W/88UdZBw+MH0f9Tooqv5AFPQP5CiozavKxobLoaoWVGTSLJmN5NNMP8zvxaq5TdSswuKg1fTDjAM1zADkeMLDM7ZUlAyKx1ucrnQnhKkaWB9rHzVfKvFz4Oq306RxYuVNLQc03r/yZeu6F7eVL+waFwKQTSbIDEv6O++2I7Un14ShKrgn3C1dLLTXx0UkjUqDatz6ZhqCp16Sn1et1EFc48yBsbw1Cdh4jGPxQ3X29zjX+CzYOOO0ApD3DGwaOzY2SXOe9lM2DC88ZYaB2O68+TUwj+gDc1fTGAXje+7RLSEQoyyqhWP4MLelMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNIlpBMuG4jGPNoZIhD17N6Uj7erxgWk0C3byA1KNfM=;
 b=aUdlRC1Y/YTi3wQ6ab6Um7RePlxZBbvPbrR5pNlWboRrniP+PaqqCdIGQaGoZ8BrR3CCzbD80JO9HhbhQuI9x6D8CM0frXK4GJjTCFyFRM9yxwp1VHQEXwbhI+q0/PRP8orlmIQER26u2JaRkvQt9JWkYDljy0rBjwcc3nMLees=
Received: from PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::9)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 10:52:15 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::da) by PH8P221CA0060.outlook.office365.com
 (2603:10b6:510:349::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 10:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 10:52:14 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 04:52:14 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 04:52:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 04:52:14 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JAqDZ81983880;
 Thu, 19 Feb 2026 04:52:13 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Feb 2026 16:22:12 +0530
Message-ID: <DGIVQZB5G0NQ.36KCKDY96KAL4@ti.com>
Subject: Re: [PATCH] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in
 board files
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <anshuld@ti.com>,
 <m-chawdhry@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260219102721.102254-1-w.egorov@phytec.de>
In-Reply-To: <20260219102721.102254-1-w.egorov@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a859b7f-761d-4961-b1a0-08de6fa4f181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW1tWDBtaWdVQ2FFMGwySU92MVE4TnNZOWt5Y0xvYy9zUnZTOWtNU041ekN1?=
 =?utf-8?B?SlVVM1l4alJBSmx6akpnQ2svSXVlaWF6d0VPN040L0NocDZIWVlDMDNYVEJn?=
 =?utf-8?B?QldMVVJ0MW5XWklGbkRYd1JQUmo4Q3pCc1ZPNEZLWURxTmNVYlJwaHpQR3Zw?=
 =?utf-8?B?cU5Cc0NQbkp0STlNOGlMOGFvcGliMmdnaGdSdEJYRzNCaFI2NDNlZXhPV0NJ?=
 =?utf-8?B?clZpdFpMdlBja1lDSlJYc0VDMHYyZGtHL3ZwckliaEFLNW1mZXlGM2xVdExl?=
 =?utf-8?B?cDlxbFBLRHU5Tmt5NU10dTg1ZE1LR201QjcyOFVEQzFHeTBWUk9VcDdXNUFT?=
 =?utf-8?B?RnMwOC9aL0ZOMVI5STFTNzFWcGhxS2NVVHlTVDR0UFpTOWpuaG1uMG1MV1VR?=
 =?utf-8?B?S2ZLMjB6czJwcnF6SVh0bms2TjNoT3dwK24zbWF3QTAyR01wRjBuU2hPUzh2?=
 =?utf-8?B?VEE4dHYxck1ESWd5dWV1NkFEZk1KblFPRDVmVWtnWk1zWXRKWXd2NWFYZitI?=
 =?utf-8?B?VGNrN3RZY1AvTElUMnVRUWhuOUVKT2tzYkxScmw2SUVMc0hBZytZNTRyaTh4?=
 =?utf-8?B?dlhMcE5yZFN1bEtpUEJ3MktPWXZxa2pSNTVMMC9JMk1OeHVpMW5zQlYwQWl2?=
 =?utf-8?B?YS94ZUVDOHJmWng5QSs4clYrbFFRQS8vM2Z2Y0hNWkI0NlNQVWNqb3B3QS9E?=
 =?utf-8?B?d3JLVnN0NnVlamlNZDBXRUdxQTUyRFFrMkdUbzIvUTNLQ0FoYmhKbE40WUNZ?=
 =?utf-8?B?eXp2Z1BUUENzL0tVN0NpdGFQa1l4UGhicDUvUXNMdEM3MHJBcHBzUUhZNWFI?=
 =?utf-8?B?TW9GSy9Idm1tVVpOdUxOQldNajk5WGJIdTh6RDFTU2VKOWxiYVdVdXNybHhV?=
 =?utf-8?B?MzVqZ1I0YkVIcTlyR3dDTjBrMCtjVUZwMjFZRGZZMnpuY0tiTXFIWkFieTNH?=
 =?utf-8?B?U1BVa0FMWHVYamZyNER0NkRaaTV5TUZUazJ4TWhXaEE5VGpLN3Q5OGtNV21p?=
 =?utf-8?B?U3VxYmhBd09uakROL2RFTVB6c25ubnQ1Q0JzT2tFbUFJbWNrNTJTMG9EM0Rm?=
 =?utf-8?B?N3NHdW5SZkZDVTNtc1ZGS2l6bnRaQmlkWlN0dllnYmlkRndobUZSUXU1Rlhz?=
 =?utf-8?B?WjBiWEJMWTVFdXgwQ013K3A2a21aTWR6cWlBVnNGT2U1UmJaNk5IUDNKVUpX?=
 =?utf-8?B?Q0kxSkdOc0I4QkVyR0ZUb2ZtRzBwYVNzWm5WN2pLSVNlOEVDc1E5RjI5TUNO?=
 =?utf-8?B?YzlhTmN2VUxja0tHZlB0S0NTNDg4VXNHRzdHSDRmejVNTm5wTW9OUGVjWXZu?=
 =?utf-8?B?L2h2OGxEaTdNcThHRDIvZm9YU2VpNzlFZDBLclVpWCtwT1JTYzluTjdlODMw?=
 =?utf-8?B?b3JmYml3YVNBeGdGTENvaWlXVkk2UzJtY1BleW50cW5uU3hlbDBwMlFQWFZ5?=
 =?utf-8?B?YzZ5TFZnYWhnQ2o0M20vRDFxanVzZW9SOXZNYURMckFuY2xRNVNtaWtPY1R3?=
 =?utf-8?B?MUdHWGdHQUJFUWVLb0JPbC8raVREMHM0Mm93NmFmMUhyd1YyQ21nSjVDZ0Zy?=
 =?utf-8?B?ZjNaWWpYNlBxNGI2b1QvTk41MGdJcnFPVnErb0hDS2htTlZ5aFBGWUJpMXow?=
 =?utf-8?B?SGZ2cXduT0djYUJpNUUwRDlpOWV6aHpLN0xySGo4N0VpQzQ0Y3l6aHBFRTFn?=
 =?utf-8?B?dUxIT1JnckVweEJ1YXNxQmE2bklHMTdQRGtkTjh3SDhDc1ZuYW1nQW9BcVRO?=
 =?utf-8?B?OUZEQ01ENnJKeFFxcHJVbkZUUDdlSUpZdWhURnczMVplUjRQK0xRMS9vT0pi?=
 =?utf-8?B?MWFwZEFPTTVKWWxIaTREdnFsTjNsd2E2aytHQzhkUlk4MHRzTXUwNnZGQ1JL?=
 =?utf-8?B?ekYyRUVYeWZIakNYcTlnN21iYXlIbEhTNW1hYzhXNEZqbDlCblBTMXg4dW5t?=
 =?utf-8?B?cG0zbjlOSEZxbHdRcGZHUWhjbzZQeklTeTQ3NC8wTzVPOUdxR0RsdzZneFBv?=
 =?utf-8?B?QkRMN3dUWGhQZlVxNnFoN3p6K3BBTXNUY204R2ludE9taVBwUXlPaXcxMUp6?=
 =?utf-8?B?S2I2YnpsZEJ3ZjBIb3dCRXc5YnJmZnRNWlRoSi9zeWlmNHExdWp3RW9QM3pu?=
 =?utf-8?B?NjJrT2plS3krNytxd0ZKMldDbUQ4Y3Q2Nm95Si9DV09ySWM3eUkzYWpVQUk0?=
 =?utf-8?B?OHVLcDcrZEowQkdKdEdKeFlORC9qcWh0R2tlY3d4b0J2UUNIeXVqWFVwL0Ux?=
 =?utf-8?B?dHpUQk9hZWVhYXZoaUE4ZGRFVXlRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNh3L/VMGUlm6SVsF7tNP7Dw8B1KE/SEJTbiFMvEJZBDulehFuCenf+sDMT5L0gqimxECtVgsprhGla6nxWmba+mLql+ObZgaER3ybGr9ooP96bjOgDq0eLZXoAZ9ZBPhZpDnxhgaGUtq4UZ3u+rhJaRErtOSK5l7Bi7QruZxRYiuJ8DpZp3uW+NSoEA7t/zh5IbzGf0aKGRm9F1VE06F/ZrmcO1bYQsfG4aJ7utpGK65UyLjfMSYKOM5AXbC52BmjD0PTbMubOBS5sMHf1h6JXnF6yKCrujQlIiVywK2h9bNuw3c3Zgahnw96eEp5RJhRzL/E+TBIzQXLtabRuQUv5PwkkP972APQlwXuttHz12mS5q8nscNfqSRBFLnlQqFQrgZv+eEukJtSOYWgb61ceUHoThl9kCiKEoZwutXbpstF7uFRgAiBblbk4/oyz0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:52:14.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a859b7f-761d-4961-b1a0-08de6fa4f181
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
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

On Thu Feb 19, 2026 at 3:57 PM IST, Wadim Egorov wrote:
> The a53_0 clock properties are already set correctly in their
> common k3-<soc>-r5.dtsi includes. Stop overriding them in
> the r5 board device trees.
>
> Fixes the following error message:
>   Failed to set clock rates for '/a53@0': -61
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  | 5 -----
>  arch/arm/dts/k3-am625-verdin-r5.dts           | 1 -
>  arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts | 5 -----
>  arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts  | 5 -----
>  4 files changed, 16 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/=
k3-am625-r5-phycore-som-2gb.dts
> index 46b621242b5..ac6f1022a55 100644
> --- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> @@ -21,11 +21,6 @@
>  	};
>  };
> =20
> -&a53_0 {
> -	clock-names =3D "gtc";
> -	clocks =3D <&k3_clks 61 0>;
> -};
> -
>  &main_pktdma {
>  	ti,sci =3D <&dm_tifs>;
>  };
> diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-=
verdin-r5.dts
> index dfd960aaf3c..971bb752052 100644
> --- a/arch/arm/dts/k3-am625-verdin-r5.dts
> +++ b/arch/arm/dts/k3-am625-verdin-r5.dts
> @@ -24,7 +24,6 @@
>  };
> =20
>  &a53_0 {
> -	clocks =3D <&k3_clks 61 0>;
>  	/*
>  	 * FIXME: Currently only the SPL running on the R5 has a clock
>  	 * driver. As a workaround therefore move the assigned-clock

I wonder if there could be a better way to handle the hacky solution we
have here and in k3-am62p5-verdin-r5 to configure the clocks for
ETH_25MHz_CLK. Though that's a discussion for a separate patch, what we
have here looks good to me.

Thanks for the cleanup,
Reviewed-by: Anshul Dalal <anshuld@ti.com>

> diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts=
/k3-am62a7-r5-phycore-som-2gb.dts
> index b54cd9d48a4..c949485017e 100644
> --- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> @@ -22,11 +22,6 @@
>  	};
>  };
> =20
> -&a53_0 {
> -	clocks =3D <&k3_clks 61 0>;
> -	clock-names =3D "gtc";
> -};
> -
>  &cbass_main {
>  	bootph-pre-ram;
>  	sa3_secproxy: secproxy@44880000 {
> diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/=
k3-am642-r5-phycore-som-2gb.dts
> index 4b7a63db4ce..6f3a2628353 100644
> --- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> @@ -21,8 +21,3 @@
>  		ethernet0 =3D &cpsw3g;
>  	};
>  };
> -
> -&a53_0 {
> -	clock-names =3D "gtc";
> -	clocks =3D <&k3_clks 61 0>;
> -};

