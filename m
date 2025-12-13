Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B5AD59F6D
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 07:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B3A8307F;
	Sat, 13 Dec 2025 08:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HxzG/Dd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE12830E4; Sat, 13 Dec 2025 08:05:57 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D7983045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 08:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA6KOU76pOC8TiKQvrxFoYcwQn98wzPNE9nmjvVkomb9ZooXgs82t5y+PBxlB2Cfs8b30NG0PR+NzdRAmEktx6HYMFS3ibCYpL/vgSAW5rEDDGdRl+K1TymIrsJjP757FreCjHNcULfzAhlQENfavAn/H1/pwC3ERcJuVHLzNqTsoPK7jS3xdVPihTThGMYEN7wpzjXOJZzgLCgbqbUkuWpSh8ym9SBW/2S0xQS2y91n57nD1OmjVVtZcsgZPOwLDCyO4JjURFNYoCvTcBDo4eGoB1vCggrr2o4Vra1kRJ9h2qGuGaTNlEU/m4/Dzw+r/WhL8CvZswLkSXbDlwMSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEBEoZd5z05MdqHg0uTGVrVIqBhdVOPE3URy5f1DAQ8=;
 b=X4ZbJl3gLpP76wZKAe7FyoNVejP4Sjnr4bJYkKFg5xbzRLf0AEPLCnxVFiyk0cj7VhYykFiw7SOwxmrC1LCyv3jant1FJjIC4I2MLWpDpTNx8AnQZi/fICCWNLAPPs+bASXRjP3+/FMlKnkKtu5WShgQlQ0AZDzYC+hBgXR+G4y98JqY9ySvZHfkNlXxjN2N7yenx+96FTU0HaahKz0hKy61FWaqaaxrFp8oUGiIYoXVU7SPlgMLWNePC44ABW08rB/RpdH+R98D2fFytz12IPBNTIDbB7uGNcRrTUNtNpnZgMxV9FVtI3YH6hH4fxy635k+AxBlxyv1c7Lxb2o1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEBEoZd5z05MdqHg0uTGVrVIqBhdVOPE3URy5f1DAQ8=;
 b=HxzG/Dd8pZzESRN6Mw1A+orYf+RfMFQjMYswRkf7QBpKg1EtVNnGv6yl2jPZOwVXiP+LLFvq9dSRQHPyXsDhTJ+Jbuqm2IQeg8+zWUco0iCalHiEC8Jh5zoHGA3bhRbo4O4qDIXPMJtAgh9JmLRqNb0tb4E3qHJc1VDYYcyX/Ws=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 07:05:51 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::e2) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 07:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 07:05:50 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:05:47 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 01:05:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 01:05:47 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD75bDH3352143;
 Sat, 13 Dec 2025 01:05:38 -0600
Message-ID: <d46a7a85-7077-4b3e-84a2-2ce607412402@ti.com>
Date: Sat, 13 Dec 2025 12:35:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] boot: fix prompt for SPL_LOAD_FIT_ADDRESS
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
 <20251212-kconfig-reorg-v1-2-72441d8cc53c@cherry.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251212-kconfig-reorg-v1-2-72441d8cc53c@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 9335d35d-6b93-45ab-82a9-08de3a160c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1OaDJzZ2ZxQmlsenJYNnVON3prNDdRSlNyYUNMSHVmQVBPVzdKRTNYTEhl?=
 =?utf-8?B?b0pkYkdoUm1yVy9TMXUwSmUwSThWYVc3alRlOGJuaVprTlNpakR6Wkh3YXY4?=
 =?utf-8?B?aFg3cis3STM5V1c5dnBGby9Tb2lhZGVtWjlCR3g3VWVqOWh6VGQzZVBSbTFp?=
 =?utf-8?B?ZmduS3gxY3FDZElSLzlCVnd4dVk4akRqM2toaXdkclo0c1k4Q2I1RFRxT3k0?=
 =?utf-8?B?UkQxTmdZT3JHcitQWTFkRGVSZ3N2bHVOOGZWSW5ya1VoWFBGVFI0QmVSanVi?=
 =?utf-8?B?ZzI1NFFWa2plN1lTQTBBVitDeTJjWE1LRUFXay9jNEFQekhYVndaZ1ArV0J3?=
 =?utf-8?B?Y0l3ZlJXOWdZV1o5dTBwQnc4djFraEN5dEtCNXF4d1RyRGVYTlo1TlpURTMx?=
 =?utf-8?B?NXo1RlBDMUxjQUlWNHUrUDlBejhNNmJaNlZCZ3RRMTBKaTRLNC90d3pDell3?=
 =?utf-8?B?RXpUR0M3YXZobjJsT0R1c1lpaUE2ZlQyNU1jYlJuU0t2TTc2WkxNTHhlekhh?=
 =?utf-8?B?U0pESyszSTlwZ3lqNFJsczhJSVNhSnFYT0RaYkp6bkk5eFBQeVFMTEw3ODlu?=
 =?utf-8?B?QVVBVUJ3ZnBhTWlLV2ltQk5pcUYybU9QQUtqSGI3emRoRUJYQTB2Uyt2WlVU?=
 =?utf-8?B?Z1lwNHlYaEhkTHVFWDBnK20wUDdiNXpMeHl6ZWpQZmxXQk9YNDVubFZwL1Bw?=
 =?utf-8?B?M01HdWJIVE14QzF1bFo2YklQWC9PN3Flbkw0UTd5dmViam0rVGpBQlhZWTBu?=
 =?utf-8?B?RkRra3hsaWYvTDZEUmNsV2wycmI0cGsySnRkRVlvbklndW5RV3Zqd2kwbVR6?=
 =?utf-8?B?WjZuUXpjRG51bkJnbncwSG5YWUhabkVZTWoybkovandYMDU2Rm5OY0NPdi9Q?=
 =?utf-8?B?aGovYnhCbHQ2bW9PZmRkUStyclRMMEV5Rm5IOFM0ZnFMZ3ZzcEg1eXhBeEZD?=
 =?utf-8?B?anZHcFUvaEUyYk4xSXp1SUE3VjBCWDVoZFN2RHVMZmpBY1N0Z0lyUTZKOEVG?=
 =?utf-8?B?bVhqVXA2c2RMZVFYeXg2b3lFMTlTM2RKNnNJQVdBSERzU3Q4UVdpN3owT2pO?=
 =?utf-8?B?TVRZekxuN0k4ZUhJaU8rNjFjdDhaeHlxcU1uQjA0allsMEdpNllTMFFSSllH?=
 =?utf-8?B?bnQvRkwzdi94V21MMm56a1Y5ODhXRnNCMFVPZk9FdmovU2VWVVhSaHA1RDNF?=
 =?utf-8?B?bFN4VlVaUndjd0F5ZUZ6ZzhjTWxMeGw3TE92VDlhRjlNL3dGbUlaaGcxczdw?=
 =?utf-8?B?aWNZUHRhVld6Zko5dW9XWm9Mc0c5eTFZNDZ5TlB3aEdUeXFkbnE2a1dHMU9C?=
 =?utf-8?B?bG1VQ2R6UXlGTDNxMGtOekFaak9Xa2YwRHZpbTR2TzRiY0xjWDNVVlB5Tk05?=
 =?utf-8?B?T3Z4OW5NdkpmclZsMWR4THBIN0hySkFEY3lYUDZDUk8xbVQyRzlUcHNPdllk?=
 =?utf-8?B?eVNydjdPZVlCUGFrWDM3ZEJDTHhPcXFlSGxnUWNDbHJqV1FSRFNyUnFVdkk2?=
 =?utf-8?B?SU5jTkFPelg5U2JtTVRpNlBmV2N4VmJXTEJ3NEhsQTlBbzFiZ0dWOEZmTTVO?=
 =?utf-8?B?czBaR3hpY1AyTkdvMCtIVWk2Um81QkRiVStZYXZyM2UvN1pQamZCanBoNkt2?=
 =?utf-8?B?ejR6Q1hROU8yVHNYTnJYYzBDaDVrakp3VWVDTm5QTlNINlF4VGFmdld6Z0Mw?=
 =?utf-8?B?MmhkSFpOV3pLL0hnZGRhZDB2b05uSEsrWWh6ZnRLdGNQTWo3UWtVR2lMSnFm?=
 =?utf-8?B?OWcwMk1xU0VPZU1wMUc3ajB1RnZCOWQxTEJLeTFXc2pjVC8yelhaMlNtMDdW?=
 =?utf-8?B?b25mQmtLQUl2VFRhekI0amZVRkxuQy9odS9WUEl0V2xTT1IvSG9iNDJUYmw5?=
 =?utf-8?B?b3dVQ3U5MlRXb0p4bXJLVWlQdUUyTUdDYW1PNWRSR3lpeDVMa1ZZalh0TU1U?=
 =?utf-8?B?MzEzU3lLL2ExR09vYUtiOHgrMVNKQWJiQXlQa3NwcVJ2R3VsdUloTDZtMHR6?=
 =?utf-8?B?ZWtyU21iV1p1NFVSUCs3U2NnWmZodDBTOFlUbUp0WTJvWjJ1OGtIU0pQTklk?=
 =?utf-8?B?NE81NXovUGNZbGpFdXBURHBycm9ZQ21xakFmdGZKdGtMOTNsV0RQSDZjdmpy?=
 =?utf-8?Q?KZ8A=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 07:05:50.0228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9335d35d-6b93-45ab-82a9-08de3a160c24
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
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
> The prompt is missing the indication this applies for the SPL loading
> a FIT image, and not any other stage.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   boot/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 85f4d468069..07ae6cc585a 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -272,7 +272,7 @@ config SPL_LOAD_FIT
>   	     "linux" images are also supported with Falcon boot mode.
>   
>   config SPL_LOAD_FIT_ADDRESS
> -	hex "load address of fit image"
> +	hex "load address of fit image in SPL"

SPL_LOAD_FIT_ADDRESS, itself indicate that this is for SPL, no ?

>   	depends on SPL_LOAD_FIT
>   	default 0x44000000 if ARCH_IMX8M
>   	default 0x0
>
