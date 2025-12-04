Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984D1D2069D
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C2683CD2;
	Thu,  4 Dec 2025 15:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BU43wE/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1943484015; Thu,  4 Dec 2025 15:03:37 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0871A83BB1
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfbRliXPnvr+lZaceabRHuM2IeQUOHWW3i7wzs4KvGR3ijRkilvCeE9JNZ3N1RsMZtSRE/UJyHRRdtXHmNyfJ3Gf+VbyjANRU3d6PGrQcRg3NYLGdu6TP2tCWSsjUXQ5gPnqz8G9yXUCpclWBjIvTHGLkhXlOwJNb3iyoeCoT/hnpi3/y8LFzSyrPETfWJWYzBtRJ7d9+5ATZ+W5WYA/J5b+KJfMYcENlL0cVD76/Cve2CKVKMbO3iU6DxIXQPV1rhCFgL2a/m9MDRL+CYYnG/hbo0YkznJ9q+Snm4wz5egRSYpQvFHToh2O2cDZccnzNJ9rBOIZNOICMNmjFbVaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eItvY2uUbSA7ugPDH0NZZvIgkXVHi9RzWmX+2Noa7hw=;
 b=brmuvkdZ2FQ8JTtjgLS/5VYzwyibJLt7Ml+YotxD6XDOh37zQ8Z/Tst01kynjBf1SYmTVt6EZTT89hPeGnrxv7x1C03X9snI7s7i/BEEUXWkpUm5OD1MoIt4eU9BTjxH6RfUzNbwEYFymqkV53ED1SB45nVtKl5YetE8iZVH9G4xF09lpivd3whKtB/tU8w9MJDsB1fyRYcxf0m3VBVwt1IbikXUdIdwHJ2pZWWGln3x2/sZCSKgHQywFcYgFThBb4wlpj4xsxk0bXMmAgnqnaURYQHOMokDUHMxamRurS/tvz90YHjoeqyRjdwW2WFo7Qlt5U83PklXkMxY20v04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eItvY2uUbSA7ugPDH0NZZvIgkXVHi9RzWmX+2Noa7hw=;
 b=BU43wE/KoWMDrjlnAdPEWVZ7Ju0/bmhVsXzkolVN1Ru1H6Eb4mEvfLMGNwUi5QxuX1ulO2CTKfa354ZmEdonfQmtoZCwpkL0PIJUaaqV8aRlhr5ZNlmIOmrwYXo52Ter80O3Be3IUMs0P98PEjRb00Bpl2DYkEGylUpWCJhM2ZU=
Received: from PH7P220CA0138.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::31)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 14:03:22 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::9a) by PH7P220CA0138.outlook.office365.com
 (2603:10b6:510:327::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 14:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 14:03:20 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:03:19 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:03:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 08:03:19 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4E3HdK1651998;
 Thu, 4 Dec 2025 08:03:18 -0600
Message-ID: <4ed7ac60-97bd-450f-8313-6f9bf0d56d51@ti.com>
Date: Thu, 4 Dec 2025 19:33:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: mach-k3: j722s: Fix eMMC boot functionality
 broken by Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <mwalle@kernel.org>, <u-boot@lists.denx.de>
References: <20251204122127.717108-1-c-vankar@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251204122127.717108-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f3d19f-b757-4955-9527-08de333de16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVY3OWpBMU5CVTU2MkdJTHNWYVhYc1cwdXVaRGNUME1zMnF4Smt0L0pyOFlr?=
 =?utf-8?B?TGthOGVvMUJJZmdEVHNYdU1xWlpzSU9nUkdCVDBIbjRER1BPV3YvdGdwUHA2?=
 =?utf-8?B?MUg3VHFFYUFRUW5qZDJlYWpBamMwNzNHWUVIYVRka3lKdmRBVXdUbkpNdmhv?=
 =?utf-8?B?OG5CdGRIa3czSUJwQWlQZnJiUGd3Uk55Wm52K1FIVytYTllpbkJWRk93UUlN?=
 =?utf-8?B?K1p5R0cxdldnQzFUNFQydEpLcU9kT3VhRUFPbUJFZnJlLzh1N3ZtUEVoYlpQ?=
 =?utf-8?B?cnlzY1hvZHEzb3dHNFZQalpVK05MUUhtYUhTc3pNUXdVdkYrTGpqWHJQSGVs?=
 =?utf-8?B?WWZ1WFRnZlR3TlN4M2R6QWxMdTlqVzZWQkZhWEhXQnhVTXhWSis2RGhHUWhT?=
 =?utf-8?B?S2RmRjlYUHp3SjIwSS9uR2toRGRhWERpUjkrTUU2ZTIvV05KQjkzWDl3UlJp?=
 =?utf-8?B?VStnYVFoNkNTVVJadS9iQTBsTDBaUHhhd0IrNTZLbzNPcUZ2eHVacG5wblZS?=
 =?utf-8?B?K1MyMFVJUEI1NzRpcWZNNVhoQUszNlVUTUlrejNMVVF0TTlHQ0hOcDJkUiti?=
 =?utf-8?B?aWtnSEdlMks0a1BRSVpEdEVKOEVzOXhVRlRMRzdDN0hHVVNmeTh6TzhoNm1D?=
 =?utf-8?B?UUlzU2RZdm5HaXJDM0YreEg3QnN6TzUyRU1mb0VOZ21Yb0lSSUNZbGdHVTkv?=
 =?utf-8?B?a282ZE8rSTg3b1BaZG8yR3prVHE0ZjlIUk4wdFJRTTUzaWFYNnVWeXZKdVRl?=
 =?utf-8?B?eHlTZ3IweFZsUjZKS0tldXRVR3JKYzI1Rnk5L3dmMXMySzEzTFVCczUyZ3dj?=
 =?utf-8?B?S28rckJ0ak85YWJlSGtyRGVWWlVCS1h1cVFVemIzQUI0clc4TncrYm81RkR4?=
 =?utf-8?B?MHMyUnUySXhaTTJnWjBuQWJKU2kyMGQrcXpFVFVzMHlmckxmT2liWnJWRmI5?=
 =?utf-8?B?bjNlL1E0U1BpWkhXSWZ3akc1MDBRd0NMWW12ZnBLU2g2WldHMHVtZ3M0aFZT?=
 =?utf-8?B?RVhtRXRxU0tiYi95K2xBaUJJY2NpM3h4enN5dTJ4MEkzbCttd0QxZGlUWmJV?=
 =?utf-8?B?TlFWcVJ5NE5jTHpKUUtCVzlxYkt3VThpY1dRa2IwcjFMZzlQbERYTzB4N3Va?=
 =?utf-8?B?QTdaSUxHVTAwcmhUbEtFdFNkVGVEMFp0cDZMVDhkSm9CKzJCS1hVQkNoVkZj?=
 =?utf-8?B?OGt1V0Zaaks0UG84Rmt0Mm9IcVdUZW4yR1ZmNURrTkZNbkJML3lqTnRVd0V0?=
 =?utf-8?B?elNtUFZlYk1vSEdzRmRzcnZVZi94ckJ0SkY1c1VmNHNtVnFTSUh0R2JnTlVS?=
 =?utf-8?B?Wk9INDdJU0dJdnR4RW1jZUxidjZFaEo4Z2NEczFMUFptTWNHQUkwNDhRNFVV?=
 =?utf-8?B?MzZ4TjQ3YXhHckRMV2JEWWFZcWF4Ri92SDE4cmNZVURneTZTOEpXKzBIK0Zt?=
 =?utf-8?B?UXVkcVdjcTB1RjF4N1NxRThDeitENUp3aEpLVzUvNUJieWRNT3lnWmpxL3R5?=
 =?utf-8?B?Q3JpVkRtTUozdkdPcEROUmFKVlZkK2hUcWxYNWgvQUxaRzRxbG42MlZuYVRC?=
 =?utf-8?B?TWRFK2hlL0xyUEp6NnJLc29CdjhKNWxYSUhZYzUwUzRta01kSExnY2NyZUh3?=
 =?utf-8?B?Ym8wVmpSemp4VnpnL0tJdHd1diswY0lvalo0WEtPbVRLZ2NueGpTKzlvRU5N?=
 =?utf-8?B?Szg2aWN3Z0RUbVE4Y3k0WHdRVk5kdCtlSVRwY1l0aWFWRFd0WExpRkVrYVVE?=
 =?utf-8?B?SVRXTDhLM0RkSk5nK2dkbDZsNG8zRXdBLzFKNEhIT2tzeVhqOExIdHFCU1hs?=
 =?utf-8?B?anZBTVFpWXppSHVCSE04c2FBYmVtdTJpa2VVeXJFeGNwaDBadktMOWRiVW83?=
 =?utf-8?B?VVlrb0dOUDFmNGRXSkVSWXBqd0ZpbnpHbkRWdEdNcWdXRVZtTjBwcXdpY00w?=
 =?utf-8?B?aTZrMENkNGlsQytkYVVLV29BbGd1ZGlWUnpYbXdFQmxkQ0hPYzhpSzR2SHE4?=
 =?utf-8?B?UXNDSUIxVTAvNktIRUhHV0VYeTJ5d2pnYWlXRjRJVE9hTUV5Q1FwVEdlSzAv?=
 =?utf-8?B?Y1BpT1pvU1hGWnFoQXBIQUZxMi9ybmdGUHc3Q0xYbERIa2JaRERsRmNKallJ?=
 =?utf-8?Q?vguo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:03:20.0444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f3d19f-b757-4955-9527-08de333de16d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
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


On 12/4/2025 5:51 PM, Chintan Vankar wrote:
> While adding CPSW device support to enable Ethernet boot for J722S,
> dev-data and clk-data for eMMC was removed by mistake, which leads to eMMC
> boot failure. Update the dev-data and clk-data to fix that.
>
> Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
> Reported-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> Tested-by: Michael Walle <mwalle@kernel.org>
> ---
>
> This patch is based on commit '69c8ea98a713' of origin/master branch of
> u-boot.
>
> Link to v2:
> https://lore.kernel.org/r/20251201060839.777816-1-c-vankar@ti.com/
>
> Changes from v2 to v3:
> - Updated commit message as suggested by Udit Kumar.

Thanks

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   arch/arm/mach-k3/r5/j722s/clk-data.c | 12 +++++++
>   arch/arm/mach-k3/r5/j722s/dev-data.c | 50 +++++++++++++++-------------
>   2 files changed, 38 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-k3/r5/j722s/clk-data.c b/arch/arm/mach-k3/r5/j722s/clk-data.c
> index 238d57d0aa0..cb3d864c5a3 100644
> --- a/arch/arm/mach-k3/r5/j722s/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j722s/clk-data.c
> @@ -68,6 +68,11 @@ static const char * const main_cp_gemac_cpts_clk_sel_out0_parents[] = {
> [..]
