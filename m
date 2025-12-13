Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798DD59F6D
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 07:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117B7835FD;
	Sat, 13 Dec 2025 08:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dkf9V8Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331DE83642; Sat, 13 Dec 2025 08:07:52 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F162C8307F
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 08:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dorTHN8amRWRy8BUDgf6J3r3sxSGwJDlzK/d/dUjpHIkIaLSuzC2MX6baVUI6frRUD+31JiYTEEO98/4kR+xmb74Nhti9hdsANAEwdWROIuNncEMscRqdHD8RpPI9FzMbLt9aac+sMhTj1aQ6PqqFp6rOxZ1ZXqoiY3McthAVY1s1UBqaQKgdOO54SLAfrTSgl+03W5I79KWE47LQgI/9lb/LG6MICr9E0jcVEDdJeBGfg7i1wVaKPa5naJfieajV1o6zcp6QP0oL1QD/pDUfEwLs+Xyyr73Mol5E6ANcpxjs+jChtxp6zWpvmbwb4WqzTlNGiERgbx4eUQmvBOI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cR3pXrryJzfgEfe+t4MRp2IVnWuiNZuMHdL1fWVtCY=;
 b=s7D+8KEYDkGuGfdBFhGZM1kwO7cHHaHEZSOViNUitBVbHLtAWckue1IxlO0EjdAFeyvPlcjIs1goFr7m/D5ZyS/ewIHAgk/cjz3XEBBDOCQhxIoTUs9QPalj7rFEb7YaYZCzKATamaMmU/xNC4FfGlI1L2cWrFqyInB0aUTyrXnsrWI9nVJSF7kQ5tnmjiDkizyQ9NesshQlgfGTGi09v2wzjJBIA4vn53ZSDOwyJXRYsj9+whU+sF4fc+xkDgpek5/AOwfKPchaUIJj7PgzWEutFr4rtfBRAEpQGWnyP66JsvI84PL7dgFINA92N/47ndrXAhgDSFHwsdmiBgGPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cR3pXrryJzfgEfe+t4MRp2IVnWuiNZuMHdL1fWVtCY=;
 b=Dkf9V8Zxcihg1J8QlKP0pFRqhJc/Fopcm7jO+NFrg6tnpoLGB/H7QjJaJLh8i9SJfRV7XDFQEZbtwf470QMf9B+WEr7oNVPLC5eLctaBCiE8zhPRCuObBQNtSlZtktYYIsUbjgNS6ncPqRPYtaQ4orL0u9mIOAkp+ZD+HH23yDk=
Received: from PH8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:2cd::20)
 by CY5PR10MB5937.namprd10.prod.outlook.com (2603:10b6:930:2e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 07:07:34 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:2cd:cafe::d9) by PH8PR07CA0015.outlook.office365.com
 (2603:10b6:510:2cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Sat,
 13 Dec 2025 07:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Sat, 13 Dec 2025 07:07:33 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:07:30 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:07:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 01:07:30 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD77MMV3403394;
 Sat, 13 Dec 2025 01:07:23 -0600
Message-ID: <0617453d-7d6b-4d76-96c4-6ebebf4c9da1@ti.com>
Date: Sat, 13 Dec 2025 12:37:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] boot: fix prompt for VPL_LOAD_FIT_FULL
To: Quentin Schulz <foss+uboot@0leil.net>, <u-boot@lists.denx.de>, "Philipp
 Tomsich" <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
CC: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>, "Jesse
 Taube" <mr.bossman075@gmail.com>, Simon Glass <sjg@chromium.org>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Martin Schwan <m.schwan@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, "Andre
 Przywara" <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Justin
 Klaassen" <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, "Rui
 Miguel Silva" <rui.silva@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
 <20251212-kconfig-reorg-v1-4-72441d8cc53c@cherry.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251212-kconfig-reorg-v1-4-72441d8cc53c@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CY5PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c35610-c40f-4c41-4e19-08de3a1649a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmpRZlI3TXN0N0JMQlN1c1RQcVN0MjY3emNjcEpEU3JkWnRuUjl5eVpxKzRx?=
 =?utf-8?B?a3BBMWhHa0VhUWRDeStyd1U4OHVpT1JCZXdmMlEzTXp6b2NmdFhXaXJGejgw?=
 =?utf-8?B?WkVVczVheHM3M1dHOGpxd3h1NmNGM2s5UUdUMUZGbTRnTHQ4ajB6NHAxYWpL?=
 =?utf-8?B?NXppN25Sc0kwb1dFdjliUkZyV2VrVzVVaUVKU3NJL0R0M3RhbWtqYk5BM3RV?=
 =?utf-8?B?ZTV4TnBaSnhRdDZLamYwU0h2N01rWTdvYTJmQjgrYTBjVkx6MGlNSnVwSnp5?=
 =?utf-8?B?Z0JHZFE1NERsWmVPVFVjcUkyTlp1eEg3RnpwUGJkSWl0bVdoZzYyKytLK01j?=
 =?utf-8?B?QmVaN1dCUjBhbWVOckZhaFV2Zm15UG5RcmEzR09lV3NmMFV1b3FUTnBMdGY1?=
 =?utf-8?B?eEN4SG5wbXE4VzluZEUwbHd0QUg1VE4wTnRCYVFySjFqSTNFSE5KMkpRWURN?=
 =?utf-8?B?Y1c1SHpXNjlXWSttbEZkcFd5OU1WVUc3aklpNEVvSGcreFFZZDQvOXVkNGJT?=
 =?utf-8?B?ZDhaUWFnY3g2aXdrblJlaW53K3BIcmxYTGRDNi9tMkt0dFhCVWhrUmpYRXJv?=
 =?utf-8?B?OUp6V2E3Vk0ycHAzWWRQOE5idnAraktodzBYaVpITnlxVHlPZUVTdUxtSDhy?=
 =?utf-8?B?UlluemRFUFpvNWdtTm5XM1N1ckdMQ0ZkZHJ0dUJhQkZCc1p5czdNWUNCNXZC?=
 =?utf-8?B?K1ZmL0lWUGx6cFJicm9GWjU1d3N1WHFtTWNXblRrZ1h5dSt1ME84Sm9tNjJh?=
 =?utf-8?B?OGlRUVZrUTNvdHQ5aGw5dUI0b0hoK3A2MjhSbWI4cUwxOVN2R013V0FUVmZz?=
 =?utf-8?B?ZytHTTlHWkxLOEswb1QwZjJXcUtrWVFzMGlxenU0U0Z6M1ZyV1NGVWNXSUp5?=
 =?utf-8?B?Ukx2ZzZwcXpDZnRaUmtLMDE5YnlPUmVXeGREc2xBMEptVEN2UDVKbnJVbkVt?=
 =?utf-8?B?WEhub2hrY20ydDQyNzYrVFY2eFRQcUtIT2FVR1pTVUs5MWlOekJCWFdlbGE2?=
 =?utf-8?B?Zjh6VVVUVUpvNnZnWUp2ZGJEeUx6OHJVMFY2L0tJUk9aVlVtRUg2dnRHU3hp?=
 =?utf-8?B?Z0pkMm5SeHFWclVGRnRkalF2UTVwMHcvS0RmWm54NWJSK042emlzVU5yZktm?=
 =?utf-8?B?UTVLNVJ0cE4yRGRBdnRVTzRHdjNTNVlNQjJ4UkZmZ0JPMW1oczNMdXpWd09w?=
 =?utf-8?B?MXdLNnpPSVZXamQza2F2SmZBYVpPbzVvd0N6UHFOWXZjQnZZM2NqK0ZaUlVG?=
 =?utf-8?B?djA3UUVESGRoWXVwbTJNMk85ZzJIMGFBdi9kOXUvRkZQWnhrY2tJNU9US29J?=
 =?utf-8?B?ekRRNzkwdDUvREViQlRubXRqMDQ4cWs0TERlRjYxZkdPL1dCV1R1Ym1UWGhp?=
 =?utf-8?B?Ny8yMDdjb1Y3Q2tnYnc2YVg2S3dPUWFHa1U2R0cxT3ZmMkd1bTZhR0FIS3Jq?=
 =?utf-8?B?NThKRE5UMDk5NWQxWEx1bWt5dnVkdFBsMUE5K1JOKzAyeEtHN2k0eXpjQUE5?=
 =?utf-8?B?ZEtXQ0M4eUNqOUo2NWQwQ3NEeFBPVDljVEtyRDhyV0t3Qy9DUDh3Vkt0bXpr?=
 =?utf-8?B?UWhveURhMVFKQWJoclFyNXJUc0JodHZxOTRCa3drOGx2WEZwcGJHdllud3Fs?=
 =?utf-8?B?VUNhY0E2OUlxMVhLdTMrNXdEdENxZG5ac2tmdnFkcUxOamkwRGMrWCtMblNB?=
 =?utf-8?B?MUV1ZEsvTlNoZzZaYlRvSFFncVAwWno3cmxWVlhRNC9CMDlWTHZOYlZJSHlp?=
 =?utf-8?B?WlJQTTJxVmdIeEFRb3g4OHNUdi9CRGl3RnlNTjNCcHN5MlZnbWc1TmJBQkpU?=
 =?utf-8?B?a2ZoSEwxSzFIMy96Qk1SYU5UenpMa3BEazVXRFR3d1NjRXdWdDdQeGZkWk1a?=
 =?utf-8?B?VFZiOC84cytwRENsdE9BNFJiTFhJek0vbTJ4TWpWTnIwUGp1d1E1MW9KMTdK?=
 =?utf-8?B?dXA1aEhTZkxSNFNBQ1J1WFVDZDl5c3AyZ3JUMjdxeHY4Z3l6T0hOMVZlZ3ZO?=
 =?utf-8?B?QzlPcGhNUEJzSTNxMXVFSUtWK0lNQitVWk5WdEtsMWFKYjBsbXR4WGZOUzh4?=
 =?utf-8?B?cy81cFpzWGN2VmFsd3VOWkQrUlViY3FKcXFHQkt5WVFiY20zZHBEdlpLUWVn?=
 =?utf-8?Q?Y3Wo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 07:07:33.2053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c35610-c40f-4c41-4e19-08de3a1649a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5937
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


On 12/12/2025 11:43 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The prompt wrongly specifies this applies to SPL while this symbol is
> for VPL, let's fix this oversight.
>
> Fixes: 8dfbd798122b ("boot: Allow use of FIT in TPL and VPL")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   boot/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 3e882d3f4f9..dc6988aca71 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -361,7 +361,7 @@ config VPL_LOAD_FIT
>   	default y
>   
>   config VPL_LOAD_FIT_FULL
> -	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
> +	bool "Enable VPL loading U-Boot as a FIT (full fitImage features)"


Thanks for catching it

Acked-by: Udit Kumar <u-kumar1@ti.com>


>   	select VPL_FIT
>   	help
>   	  Normally with the SPL framework a legacy image is generated as part
>
