Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA8DD5AE41
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0A5839C6;
	Sat, 13 Dec 2025 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HOP/0d+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5F0830E4; Sat, 13 Dec 2025 07:57:25 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AD483045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJmKW2zRrit7BRdNB3MmAsz9iHcShRq8zBNiwYvf0qkBcxLDRqtOVnp7x4Kf/XZmM1vBedGUTm5zNIxYjPuk60mq8Nc1tUURpjaWwaKlNpDFHrdsEPdkGiOZvwO8DHGP9qSQ3fmdmzS+yoIbpX8qw7Sf0jzx8RdAJ4Y5piMf/mCs7SgIrl099h5/z4dSVQ8vlLD5Ecjak1cqJ7UcB4TZpvFNzQmc5PrAfPj6pIOqw1bZRg2OYxeSFREvmg4EoLCHbAmvXoyeUh2dsQW38Q47Iaj6/prqRm2vqGIXQk9aXQAejMldrLCSC6+enQx9bKMOszQtRSNcffQxoKOfEgYhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5lGh9MSRh3ETJD0Avcax01XIQrDikzIb1/SGXrBsjs=;
 b=Affu3HyFftIjdjqgrvdGBqONe+o7SQQ5iYDS4EqfEkHjOugQS2NF4TH67RazpcTr6S94TECzrngUhkTkotj3vZY/JtgIas4Rh0DF7iOZDvrX7dBbKghvc6ICy8/3FxhJciz488ShnoZpJyBc6NUvOqto9NQAPNLFX8zyf/NDtsU2SeQenK8vJqUxNKFw5tOjzFroiNQkwfk9zR79QCqJSHkB/jZiTGMHtHyeCBrRpBHvqSDTOfIGHaqvqjhydiDSykvyUe+BPBPa8qESKrf+sqZGB68oaQ/dSnXzRRRgMCvBeNb+0E/O0vjlOAheGHkMpT1FfjSYQjdAC0d1Do9rkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5lGh9MSRh3ETJD0Avcax01XIQrDikzIb1/SGXrBsjs=;
 b=HOP/0d+l8uWqVfyY0Xjz3DHpZHpdbmXUlI/BOt6EtYm7rVCecHP5w1UcuQNbXrcyjRt6zsV6fMs9thWpB8PFwW2LoiWXiAvLegdYNivy0N0NLeJym/6BEN9Nb64MNEutBV0e1J2gCBT6hivlOMC6BOE6ldP6ssGM1o/deK3y2Tc=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Sat, 13 Dec
 2025 06:57:20 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::53) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Sat,
 13 Dec 2025 06:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:57:18 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:57:18 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:57:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:57:16 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6v5mw3391271;
 Sat, 13 Dec 2025 00:57:06 -0600
Message-ID: <367b9e8e-8473-4150-9b74-970e4507d45d@ti.com>
Date: Sat, 13 Dec 2025 12:27:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
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
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-9-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-9-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8027a054-6048-42eb-fb8b-08de3a14db8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUpraWlSWHNKSmRwNTU3aWFrNm05RUYzNFhCY2RUNDhmOGUrLzlxR2FpTUZK?=
 =?utf-8?B?N1dpaUtlWDZLdDY2RmRyakdNZEtCNmtjYi9TSktIM25ZM0M2WmZBalVyZGJv?=
 =?utf-8?B?M1hrME9nNDM5TlA0eFdnOXE0aHF2TkJYMlhCcE1XbjBZdEJqemx1WGMwNVVF?=
 =?utf-8?B?dWtFTlpPTDNNYStmU2RVYkEwQTFCbUQ3U0FZcEhjMDQrczROSnJSdmJMODcz?=
 =?utf-8?B?VytRbmxTTnlJdE5uM0dRUzEvV28zdWRtWTMvdkpYaUxHcjlycnljQWs3U3lR?=
 =?utf-8?B?NVNSYkp1MnlvbWJqbmVPRjlUNGNxUnlqY0JQbWZZQkg0OHpuZnhjN0NSbDlP?=
 =?utf-8?B?MDZKMTcxOHAzeWNHTWNSTWdGZ3VTNWI4aGtsUFlCaG9oc3EzRTJiSU5obWdw?=
 =?utf-8?B?OHRWaU5uVFZDTTdwQ1hFSEhjNHc4NEY1eGFqWEIvbTBjMEpXWG1BVEliZ1Rn?=
 =?utf-8?B?UW1vNHZob2NzQ0xMNDBqckVOdWdjdFlJQmhzTm9oUWVMeFdQbHBoWGRzMEND?=
 =?utf-8?B?R0hJVGVIaExtV0E1SmZsVVpKSnUyMXZKWk5aVnV3RW5QMSttWnFjRGFaakJG?=
 =?utf-8?B?djYrY214K0JlU1J0REhyWmpEbTdLSkN2bno0bmM4aUhDdHFydFpPNUNmdk9K?=
 =?utf-8?B?QUdLL1laaWNxVTdWMXFXbTV4NGVWajZvNVRCQW0wRFJKKzZ2SnNNTGJNT29G?=
 =?utf-8?B?bGRyaGlYZFA1WitjQTEvYU93UnBQOUdzYUY3WFhGbTFFNHZhMEtha2NzUGhl?=
 =?utf-8?B?OTJHVHFaSVF6L1N1MFAwTS82bjQwdzhoTWdNWUxkS0l1WHpKeXlsS09UclBQ?=
 =?utf-8?B?NlNEYlRzRmU4UDlmWDVNZlBldHo4aTJNQU5STDhWV3ZNYThWZFR3cmpDOFhT?=
 =?utf-8?B?T3dyY3RVSDNtY3ZLa3puZTVxU2hwR3lRVjNuWGRDdzAxcVdoZDJGRm5hVlRa?=
 =?utf-8?B?QmIwdzE3UXpENm1EOEJ2UERHN05lM3F4dXBpMXdPNXRZamNTem4zbmtlTG5s?=
 =?utf-8?B?V1d6OGd6TWVnV2dDTlRqdkY5dlF5ejdES0ZyZVBOUEFLT3dCT1liaTJoRC9l?=
 =?utf-8?B?emhleGJYc1NMdGlCc1lPN1MreFFxVG1aZVpCZUlPTy9ERVUwM0cwT2lYQjc3?=
 =?utf-8?B?V3dQTnVONVdycjg4Y0tTRDBJU1V4aWczOU1mNTgzdVNqTW1BNFpRS0ZYRDh4?=
 =?utf-8?B?amM4c3JrR3pJRmFiMjI4U0ZrRUx5dkJMUHVMUFkvWlhsZk52MFY5RWd1SEpN?=
 =?utf-8?B?MHJCQ3JTVzNBUGF0MnR5UHpuZHh3T251RVBlQlRwNnlER2tqUHRmdlppVDk0?=
 =?utf-8?B?SFBFaFcwRk4zRWJyS0p0MW8ySWQ0aWNHNW1MTmh4MytaUzdHRXgrcDNQa2pm?=
 =?utf-8?B?eElxOWRrU0xrbDFOWXk5YThTQ0ZiTTVXS1JiblJVaXVJWHN4VmVlYjRiemRU?=
 =?utf-8?B?SVhZa2wyY2Q2SUdoeWYvMTdMQTFsUWJxOUtVWlNsMW0xazZiUGNtZjZsclNU?=
 =?utf-8?B?ZUd1NHZodDhkT255OHd4cytXQXBCTzhYZFhlck92NGNFczM2Nm41cEdGSGU2?=
 =?utf-8?B?V29iQlRoUzl1WGY4dTBKKzFBc0tMeHhVMWFqTnlNdVZLYll4bExkb2dIdXN2?=
 =?utf-8?B?L0s2cWU0ZGMxV0s1WUZSSndvUXAvZytrejYxQVdXeWRXamdDWVlhOVk2SFdW?=
 =?utf-8?B?ZllnQU5wQ3pJaGVkdGtlVmRDTjRQUHUzR1J2OU02YXh5dnE0VE5Idk5taFlt?=
 =?utf-8?B?aG5hODBrY3lFTFlTWVpCMEI1cEdpOHJ2L0VaWGE3MThqRDA1OFF5cWZ1aTNL?=
 =?utf-8?B?ZHVJQmVrZWp2ZW52TFR5aWJFWmdHd09sSldsVkpiYXRVSjJ2WGZjb3o2c3A2?=
 =?utf-8?B?K1JocUZMQ01kb2JxWXo4SFJOU1lQZzdTc05wMWJUbEdEQnZYT0tsOVNyQm85?=
 =?utf-8?B?QUVoK0lJVzNxeW5ERXZXUkVjTVc1bHpqelRyUk1vTnFaeDJGMXZLSGl1bTcx?=
 =?utf-8?B?T3djSXExNEg4SDRqWElIb0RxRmJOS0huRTZSWUhpWVE0dUhqalVhRldWRzhL?=
 =?utf-8?B?UGo5NjRqMUZKWUNUQm0yTmxUKzJubnZCRUJ3Q0s2K1dRZjNrQ2luc3JlaGxJ?=
 =?utf-8?Q?uZDQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:57:18.9654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8027a054-6048-42eb-fb8b-08de3a14db8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
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
>   arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index 976bbbeb8747f9ddddd78b3f8d7f3787c5bfd576..4bc688ae10cd0ce36d87d2c2ad2d7609db52d5b2 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -255,6 +255,16 @@ void board_init_f(ulong dummy)
>   	spl_enable_cache();
>   
>   	setup_qos();
> +
> +	if (wkup_ctrl_is_lpm_exit()) {
> +		u64 meta_data_addr;
> +
> +		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
> +		if (ret)
> +			panic("Failed to get LPM meta data address %d\n", ret);
> +		lpm_resume_from_ddr(meta_data_addr);
> +	}
> +

Any specific reason in patch 8/13, resume is done before cache and qos.

for this platform am62p5, cache is qos is done before resuming from standby


>   	debug("am62px_init: %s done\n", __func__);
>   
>   	fixup_a53_cpu_freq_by_speed_grade();
>
