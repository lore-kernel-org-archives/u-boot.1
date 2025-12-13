Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786C7D59F61
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 07:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDC781D6A;
	Sat, 13 Dec 2025 08:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="L4z21cfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042438307F; Sat, 13 Dec 2025 08:10:06 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75ACC809A5
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 08:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7TGRB2yk5WZQDD29xv/aCBgl7WUiPXCo7DBEfFLwwLArUkQQkkbFvg26tLwerDFSCtViTd/9R76PzIt0HnCYRUdSjogUc39r5r2WVoLvHuVm0ZgnwUYeNNET2dxBt7kNUlsQuYLETipb7eIw2/HvEkbwIrVIDwtQEmbkox+FfS+IZEES5fwFqHcBfyaTnBHJ5HWTwyEMuXuMGy+XD7yceYmx+Pa6ksAf7iyXWzHFHg6oOA6hx7HmWv20nUBJ1/P38waI7bOZdK90T2dWOji0DFA2kqbPy8GxvhQoYBQMynpbZqNcMapQkBMFIO039Qphg9/P4ChWan9sDE3INVJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHt+g1ztOYhWS1j+2GPytwQCScfdAUILyVSDb5Ny26I=;
 b=Jt5cLApI+gkNEtJTq/uBOoBCl/62FRNZ6CQxY0fATBkzyi+t5NJtGOjx5uLa1dGUrBCoChZu06qIvu+/mUFbyG64ecGTu7F4429i1xW807CH0zZf1Fazuy8QGnN2szUqizJGfpqqGwm1m//NUQPlW1pf6BQy1YlbJ7dtwgmNzSkkAhemeiIEwu2ucNMJaYOGP8bJxD3mGGQYMlSnlxyyqGuZbf8Ttr8zc9bQdQVQJzLrXUnHROK9hzyVTUF6vKPiO7c+ZFk2e1PCi6YdGoqdleaweX4+0Td1RSGS8dLW9navkmtNyx1xCAPaTpSgGWRNokyTlZi6TEYTzl7n+U9i1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHt+g1ztOYhWS1j+2GPytwQCScfdAUILyVSDb5Ny26I=;
 b=L4z21cfugBh3DpZGZ/troxSTmNJ4YenjuQ0+48GXznpCKxY5/TAmbRmnVf9hq/YZNuZ71uZCXZ/YZtvEpwMgibwFp6yUXv5X3LTItCUS8owlJVXmioLhu97NiFiy36xHoY48cUjLhoWuRiSDL+pXC91nJqNq2xV5ZXx8OLC8kjM=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Sat, 13 Dec
 2025 07:09:59 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::8b) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 07:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Sat, 13 Dec 2025 07:09:58 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:09:56 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:09:55 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 01:09:55 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD79iks3405029;
 Sat, 13 Dec 2025 01:09:45 -0600
Message-ID: <b0f0aa9f-f0e4-41ed-80f2-d1cde05ac771@ti.com>
Date: Sat, 13 Dec 2025 12:39:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] power: regulator: fix dependency for REGULATOR_PWM
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
 <20251212-kconfig-reorg-v1-7-72441d8cc53c@cherry.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251212-kconfig-reorg-v1-7-72441d8cc53c@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ1PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca2890e-75eb-4e2a-b537-08de3a16a037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdPRUVWNjNCV05Dc2xCUG5pMHBBU1FTb3dJT0xZU2JTRGxIUjBxM2JYdXI2?=
 =?utf-8?B?aXlZT2tQOEtiV0RxOXdYRW00aXpVRUtnTTkxeFVoWkUzWmV1dklOcE53WkI5?=
 =?utf-8?B?azR4THVsZkU2Slpuay9UdE5vUHRLWDdYdGNOVWc5MExJSjNRbnd1dFlXSTAx?=
 =?utf-8?B?OW0wZUJldk5RV0t4M1VFanhXMEVvTFM1VWJkTTd2VzllSnFwQ0IxbVE2U0xs?=
 =?utf-8?B?UmVhY1dYWUZ6S2VYeDRZdFV0QVZ4clQ3eW1udnZlVWMyM1d2OUM2Y2dyTmxH?=
 =?utf-8?B?ZVFUanBXZlU0a2draCt2U1Q3Q2RRQmRnZnV4bFB2Tis1NzV1TVhWd1pGUG83?=
 =?utf-8?B?bEJxWHRLZHphU3hKaTJPeVNVdkRqNXprTldyNEEzQ0Nkc2QzYVh4T2htV3du?=
 =?utf-8?B?RFBoaVdzYVFPUmFPRUxLSmVhRlJkNFJmZ1AvcEoxZ3ZxUWxob3p6SDF2NnF3?=
 =?utf-8?B?eCtaelB0TDFPblBNYUNwSXIrT01lT2lMcXRsc2ZMZmJNd0hEQWhsTFdDR25z?=
 =?utf-8?B?Uk5objFjSDQvYTlmZENkY1NVRXhkWS9sMXpDYW1DUmVQWDFnWHo3cm1TOUtJ?=
 =?utf-8?B?QTRiclY3WWlLUGhxcFJWSkQ1RGlNUnVWTnBsZzBMVGpxZEsyNERTU1hyalFE?=
 =?utf-8?B?VWxmSC9vSk5hVFZhUy9URmk1S3U0WGZIRUZJaFd1aWlEaXBLMzFHdSt2SE95?=
 =?utf-8?B?UW1hckRrVmRJd1Jnb244aTRXOE9YMFV6bzZmMGpjQVJQMzFsY2M1ZjZ6dGt0?=
 =?utf-8?B?K0Zrakh1Qlo4eTIwejdzS29UZHhWQ1V2Umc0TCtlZmQ4SlJCazNsVjFEYWtw?=
 =?utf-8?B?MTIyQUsyaW0xSnRXRURzVVhoU2lNcFhoRFB4bm1ZZlV0QXlSMHFFcTFyREll?=
 =?utf-8?B?ZHQrSzcrQk9qQlB2UXNWVTA1cGNscEtSeXA0NG1oV1hJMFBUM25xaHBmUlNt?=
 =?utf-8?B?U2tKSUhrc282Q1RKTFo3Q1FZaWRjWnZQeWY0LzNTTEkzR2gvOFBmY2ZmSEtT?=
 =?utf-8?B?QmNJR2o2R1dIQzFhNHBYM21GWGFLL29EalN5cGZ5WHM0NUFneDBEMEVWMita?=
 =?utf-8?B?WEZBdS80WFJwNXNncGpUZFR3cUhlVGFqOExrYkxSUlNDMmMxY1A4c2p5MlNM?=
 =?utf-8?B?VSt1cTRTT2JFQ3U2Ukt6UVVtMDA2VlpFQkYrbFNhTUlTbEo0NmJaY0M4eS9w?=
 =?utf-8?B?Zi9PSUlLaW8zOEpOYk54TkZMV0d1Ylp1UUtySENOQnltWW9lRElFT1lnREVq?=
 =?utf-8?B?WmlScWtFZ3BjbDd6RFJLUE9TSmJCU3M3N09xQUxubjlqd3BXYm1paVViMVFW?=
 =?utf-8?B?SUV5NVJQZDNjaEdHR3NENjRGZ0V1RXh6Z3ZzUHg5eEFjaFlTTmQ5ZEh4SGEx?=
 =?utf-8?B?ajF6aDN4T2RFd3pGWVRFaGM0WXBYR3F2T29QSSsxQlhIQ0ZKZC91eVJNVXFa?=
 =?utf-8?B?ekJrRi9EVGZYWERSYjRrc1lGZEhpdTJkUjQ0TVc0RUhKRFEwdTQrNDU2M0o0?=
 =?utf-8?B?R1ltd24zT2NLalRMYWl0dnM0em16QVp3WnlFZ0h5SEliV3E3dElPTFh0NEJR?=
 =?utf-8?B?Yms3VC9heEJKay9ZMmpJVDVxZzQ2ZGZjSWlzY1pTNjZ0L1lzYldsY0R2ZFlp?=
 =?utf-8?B?eFd5WDIzOEJKR1R4MGpkUmdnNFZTUGI2MTVBV2dSWTFnTDFDZjRFUU1FbGFB?=
 =?utf-8?B?bVlaN3pCcVFHdXlpMUFVbEQrTXNEelhicm0vbzR4S3Y0TENvVTF6LzlRQVUw?=
 =?utf-8?B?WWdTcjlSbVI0OEx0bnlTVC9PdjZCWisvSlJib3pBL3M3UzlIdEVodW9nTHNw?=
 =?utf-8?B?TEpDUDdLejEwMFJmalJlbU9GRmNBUmJqQ21ZUGlZY1k0WTVmUDViM1pEcWdq?=
 =?utf-8?B?eU9ORGFKTStEbnQ5dXN0cnAyQ01zTXJFMmREbG5UWVNjZ0RVbFVRL0k1TmF4?=
 =?utf-8?B?S3RhMXlPODFVeWttc3VZeHpISzdmejUyUUV6VjdLZm1KVFFIcXNYcjJVaE5w?=
 =?utf-8?B?Smp3SWVjNFY0MGJnb3l2NXdNWjhDalFjU1cyTC94WDh2M1ZMYTNNYVFRU0R1?=
 =?utf-8?B?YWxtV3hxdmJ1NDZwNkxTOVhGYUtBc0lMbDdjeVdPUFE1SnlFcTU1SjNMOGU0?=
 =?utf-8?Q?4xyw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 07:09:58.3906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca2890e-75eb-4e2a-b537-08de3a16a037
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
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
> The PWM regulator driver is a uclass driver, thus requiring DM_PWM to be
> enabled to be actually usable (and with the appropriate PWM controller
> driver enabled as well, but that we cannot enforce easily), so let's add
> this missing dependency.
>
> Fixes: 1a01695615f9 ("power: regulator: add pwm regulator")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/power/regulator/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 1875e61967c..d6b451ca407 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -133,7 +133,7 @@ config DM_REGULATOR_PFUZE100
>   
>   config REGULATOR_PWM
>   	bool "Enable driver for PWM regulators"
> -	depends on DM_REGULATOR
> +	depends on DM_REGULATOR && DM_PWM


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	---help---
>   	Enable support for the PWM regulator functions which voltage are
>   	controlled by PWM duty ratio. Some of Rockchip board using this kind
>
