Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642D9D59F76
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C590B839A8;
	Sat, 13 Dec 2025 15:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZMNP3Vu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C4B830E4; Sat, 13 Dec 2025 07:55:43 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E1283045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5mGAngi6bwSRXV0+tM1r9uEGzsZuHgFEt3Ad2VijuYSMenh7N+7A+xWcsIp3T4KvhJrnts7KEMYL1w24JwqXVu4eN4Pw2bxLdNVGP3X1JTqI2Eh7fT2G50rlZapNU62bq3goI6RJm17RxUUSmCF26jurNPFFICLWlfqYsHivCdOzivoNxy7aA73i8UohXjdF4INFKs3UFwyHk+ULrwdXLm6Me8QyUEQAziaONDPCV4UucEU5Kme4dzPUX6kRjVg1jivUYPWICc4E8DI2SfyVSDMsY4p0Z0MiR1wXJXq27sLmW1tbXT/47M+vgAubBQpwRIugOdhbF0zaXCaGDPfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4zxsHsSoI1dIse9p5ZlpqVXB7CTKzrFpM7eL80d9Wg=;
 b=GJjDtwOWBmCEdkNRz7a/nGXYEo7p5zXqjmVdlQYGbgIGWthyhCELGcwjHyqMrYo7m5hKH5G8NYPb7NobDIZOenTDwtcFOEc6gb+T7TxEi9IUDKnzmyaHazoOvcp2zIm0mU6vrfg+x15R2hl4Ba47EYRzy5VyZXpg/LTy2W76K3apD/fNwlhgkkC7mPalcQShTJrqiulcLb8H+Vb598dILwy+AmiU2ucBRUxhTgW4nTt2Px+8q+hZTse9fA4hA0fHLQ3zyfbrBLaBRPxHao97n+2pDODO12+SUS+Wabr6N/kJRCRPmUgnJjtU4ynDnZtNG58l5VihxYNWibcB8714GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4zxsHsSoI1dIse9p5ZlpqVXB7CTKzrFpM7eL80d9Wg=;
 b=ZMNP3Vu2nFgOFmtmjVhhzYsYpyTEN6kiXSjSIny09U033D246nC/BPM8yHp7NJ7KtW0t/qKJa6Gjtxk0d6v/UOS7qNz+sbRsCMGP9e5/VWdpq/Age0oi/qkgc7Ohlr2UabzhDSXcQFPWxEr5f008P3/PPwSTYdm/4TIS2NMZWJw=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by PH5PR10MB997732.namprd10.prod.outlook.com (2603:10b6:510:34c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:55:38 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::36) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 06:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:55:35 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:55:35 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:55:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:55:32 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6tMqG3340331;
 Sat, 13 Dec 2025 00:55:23 -0600
Message-ID: <5058275b-a198-43b1-a040-df330775f695@ti.com>
Date: Sat, 13 Dec 2025 12:25:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-8-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-8-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|PH5PR10MB997732:EE_
X-MS-Office365-Filtering-Correlation-Id: 070ec534-2833-40fe-ef82-08de3a149e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEJVMGpjQ3cwcmdRdFJrTzBNdy9mbmhJQjY2aWpHUkk5Z0h6SWRMN0c1cWxV?=
 =?utf-8?B?aUUrS3RSa0lqWEhYRUhVZFN1SXlQMFZUaHU3QVVSajFnMVFFcGV3RUtmbGl0?=
 =?utf-8?B?VE42M0NYcUxNc3ZmQXUxNFF4VDhiZnR4aUN5VWFJamZWUXNNYkdtdVRDdnMv?=
 =?utf-8?B?VmxXVzdlV3Z6UWFHSnRVY3kwS1l3WDhwYlUxTFlnbldSSjhGRTdIa044Skhq?=
 =?utf-8?B?d0RNbmhKSDlFOEN2bHJlUkRoZXM1dTZlUnZsYzA0b0hqVmh6NXpWbkQ4VnAr?=
 =?utf-8?B?SmkyaG5pWnlYMDg0Ni9XekZIVHZvN1RURDdCNi91S1dXNzNDUFBoZmVnRTY5?=
 =?utf-8?B?ZzY0ZnVmNkRYbHQxQmY3NWg3VnJEYlVjWk5vS1JVMkQ2SEFyclFyQkFsYU9L?=
 =?utf-8?B?SnZaUVE1S3dxSk0zTkVEM3hhVXgyYTA1bW5jQldMM1IxdGNYbWZVRDFtc2Qx?=
 =?utf-8?B?SEJTV1libVk1Tmc5SHFQM0NkREphaTJwRS9mRXN1engzVUhVWGVadHpjTEFO?=
 =?utf-8?B?ZHZIU3FNb2FOMzFjT1A2cGdqREY0bEYwR1BScktxNDdGOE9ibUdodE5wOFYy?=
 =?utf-8?B?SXo5SzRHZy82c2RTV2ZOdFVSdmpva21tVU4wLzAweW5NZFVtaWZQUEhGc1Fv?=
 =?utf-8?B?MUJNRklBY01HS2d4MllhekUzYUF4dytreWxsTUVuVGJIRmZxQ0ZxUlAzeWha?=
 =?utf-8?B?bnptVE5ycFBKQmV5Y0M5Q3Vvd3U3L1d1by80UnFINWFyYU5IZktaL2hZNHJ4?=
 =?utf-8?B?M2diWEVRTW94OE5RMnpXZDEyaExGaElPM1QvWmR1Kzd5a3NtL3lWMUhsTmlT?=
 =?utf-8?B?UkpEWXBpamZwWDhZeDd4dE9IL2ExT1RlNXZoMzk5TklpdmUvYVlVRXJnSFht?=
 =?utf-8?B?QWRTSmM5Y0FLSHFjZ0tRWlBzdTFPU3ZVR0Z6eGpPUlNRRnRYaFduL0p2cmU2?=
 =?utf-8?B?VGlnSE1Ud2dnTGg1WWpOZldCanNXcndiV1l0Mis2STJWa20zSVVxT1RJTDJ1?=
 =?utf-8?B?bmdmVDg2eko2UjdQYzQxT1liTjNPaTJ3MDkxOXg1U0liUDM3OUVmZzkrOGZM?=
 =?utf-8?B?QllIUXdRM1Z3dnNhZXRLYkRFbzZDNkZvdzVBSnBLM2RoNmlPczBkV0I4dW53?=
 =?utf-8?B?K1RNY3NvcG13RytqcDV1U1U4OGpYa2d6VFJKZFF0Vy81R1FPYU1BRjczQmE2?=
 =?utf-8?B?RDFVQjFpRGxzRi9hRE9nNnQ0NDRlcXN5Q3l2NEZxbURMVXZlbGYrUWpTNk5p?=
 =?utf-8?B?RFZkY0l3U1hRK2RRbm5DejZrY244cnBtdnpmS3psWG92TWprTlRpMy9LYndo?=
 =?utf-8?B?djVnSUJkTlc3VEIvR0g3c3VzdU14aGxTT1ZMZXVQcDZKcGhBdUZBU1dtMWoy?=
 =?utf-8?B?SEtVWjhCRXRYNnUremIvemc2anpiMXMvL3QxYzQ1Y1JHQ012Qy9WR3VHR0NY?=
 =?utf-8?B?WnEyMm5WbnJLUWJLLy9ISm55cWJMTUp6YnBIVnpSY05uNHhuS1FkSjIwVzZh?=
 =?utf-8?B?RGtxUFAraDdqeE5zN2ZoeWFsT3RweWs3ZlRTM3NiY1k4ejd3N0FnQlFRaFh3?=
 =?utf-8?B?RkdTK2FPNTZsc0dkK3dKZ2JVZC9HUWFidERueDNSbmpwVnBza1gvNXhXT2Vz?=
 =?utf-8?B?eXYzc01BbWxaOFhTM3pBR1JwSk9qdXZlWHkvN3FSUDBEK2lzdEFTZWwvUU1u?=
 =?utf-8?B?bUdmUEY3czZldWRQMEorVkdnMWdpQkx0MFdON2ZHblVNbHRNV1p0S2ozcDZn?=
 =?utf-8?B?WFg5empYaE5BK0dmbTg0bWFOYXc1b3M0SloxZGw3U2MrQ3UvQTFuQ01VVEhw?=
 =?utf-8?B?UHF1dlVPZWtPWUVrSVQ1cE1EeWJZZDREOTF4T2hCQ2xubUxDMDFMN2MzWVly?=
 =?utf-8?B?M3lkTHVEU1ZFZ1lpNHBwY2Y1SnBJK1VzdHAwNTVnd1QzV0o1bDhleHBuZEZR?=
 =?utf-8?B?aHNGWXBzSGhKSVRTQTBIM1IzNkc3a3ptRHpFWWtadG5LUnNUbUw4cWlnRHVl?=
 =?utf-8?B?S3RBV1RmY3lycWNUZkFpbWpEYnRNeEZkMDJlVlltRGh2Tm9IWUpxT25MUXRq?=
 =?utf-8?B?OXpQRyttemZlRGlnYStDUEpSOWtrQWRyejBvU29vV0ExRTNnWFVnT2E2ZjVQ?=
 =?utf-8?Q?JSp8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:55:35.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070ec534-2833-40fe-ef82-08de3a149e20
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997732
X-Mailman-Approved-At: Sat, 13 Dec 2025 15:04:07 +0100
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


On 12/10/2025 7:39 PM, Markus Schneider-Pargmann (TI.com) wrote:
> When exiting a low power mode with DDR self-refresh, we can directly
> resume after DDR setup is done. Call the common function to resume.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 24fdfdd7f1d9146f0cb6dde333d2bb54df96700d..9fe671c3ff458189ba04ddedd0f2fa8894629cec 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -197,6 +197,15 @@ void board_init_f(ulong dummy)
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret)
>   		panic("DRAM init failed: %d\n", ret);
> +
> +	if (wkup_ctrl_is_lpm_exit()) {
> +		u64 meta_data_addr;
> +
> +		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
> +		if (ret)
> +			panic("Failed to get LPM meta data address %d\n", ret);
> +		lpm_resume_from_ddr(meta_data_addr);
> +	}
>   #endif

I think, code will not return here after resume then how setup_qos will 
be done ?

>   	spl_enable_cache();
>   
>
