Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC01CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377AE83D85;
	Mon, 24 Nov 2025 13:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="stBovjA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB60E83BF4; Mon, 24 Nov 2025 04:51:29 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA5683ABA
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 04:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUIietA29p2/qK3bB8nV4hYFdfv4kKX14ojB+6l/I9rChli14QGthSBttlLMqgHDv+brcdl2bGsndcBqR9hi2zdYzHfHuefya4CyTzw3C8a5YQV3VnXQZmw/isBaugRf72qk6n2AkfnA36ajY67IsxHe+N4OrEIAxyoWoyrJNiZ51QMUnwqSKApqSc3bji0la2KFcEbkVuFM+rfEQ6Pyq2YdgmlBA+n2wM4F0OChR3icgKZbv0/MxwaoTMAzLvs8q32uEearHDjKYry6HTqWG1/oQ2Jwf+rCHOdDtIuYfE76DqhmqK40MBGjKUK3gX5smEAi521MUXoixAUaArNJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjEs4jl0ptDAqaY6F+n436pngb6wzXhyIbXEcjNUblk=;
 b=QcH8O/au7tjvXqwN+6JWGB74bjCz1R4ZtU3uYijzux6w1TSQ5tafNFqUAKvYJq4KaKCkDkEAXUeBTz2QJHGENaXA4heELeirrePAz3RsVoyHOcaVit7nrs1c444lBkHexQ75JaVcueqbJVrzjSM7UXAQtDZB0EfvuRMLwnVNpu+NgR5Lp5EQK0TP/ZUFJKXjY79Plk0mxBfcYuFuvxS4JJs/419E+ac9CCkizBkrCRjpPMMkKF6CEulr94QahWmqQyyUKMyVHH1+uAx9blOF8h+F+6ANAUoB2KeOnFfah6b3lqadP5K/AfHgMcOoRG0VQJ9mO1E4gS1+hTAwjfIclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjEs4jl0ptDAqaY6F+n436pngb6wzXhyIbXEcjNUblk=;
 b=stBovjA4j1f2sFLgNWuOLGogdj568tkVlIJ6whaHlpYL1dgyD2Z3wdlglmJG6PyWk0OwzgH+laczslxNm+V4p9oJWyvScKEmQAJE9+xGBnaf3LDTPKecUGGApqUxZsA9xdwBJXrJltidYJ7yTfA4356cNA3Ub0d3HZmK1d/Szpc=
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 03:51:24 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::21) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 03:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 03:51:23 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:51:19 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 21:51:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 21:51:15 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO3p5qI1242908;
 Sun, 23 Nov 2025 21:51:06 -0600
Message-ID: <80b360fa-fc8e-43ac-801c-2b688efe26d4@ti.com>
Date: Mon, 24 Nov 2025 09:21:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] arm: mach-k3: Remove CANUART IO isolation
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
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-1-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-1-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH0PR10MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: e786936b-a4dd-406b-d926-08de2b0cbc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEVtL2FZaGFOWHZuT09aTUQzdkE2eDRjZmsyWXZXRkU3MmxLZGVvUVVDTVhu?=
 =?utf-8?B?dFEwTmllSHVlNEE5ZDQ3SW16RmhYTGRQUzFjbE9xN0dXNXJ3M1F2ZU9UaW1Z?=
 =?utf-8?B?YU5EWHkrS29YY3hJL3FQU2FoTFQ3UTN2V0ljTGx5clU2SjhwZzNnckpPQW82?=
 =?utf-8?B?bm1YTnZJOTIveStTa09sczdZcXVTeXpreTFINGRHUDZBeDUzdk1kUzhyMjZR?=
 =?utf-8?B?aTlBWERLNU5XMDJzQXpYUlkyZ3grY01vVXdmYVZ3ZDljYjhvdjcxZDEwNm9p?=
 =?utf-8?B?OTZ5OVk3TDZJY3FWaG1rdWMxWjBZYWVEeVJrQjFQWENubzluUXdsbUovWFJq?=
 =?utf-8?B?ZDN5Y0xMQ2RXTXVROXNySlVXdGhSR3ZCWTNHUjM3MFFvc0hUdHQycW11TFZY?=
 =?utf-8?B?V2dzeWN0dW9qdC9TdWhWMlltVjg5emUyd3lXUDdnN2tka09UNjBlUTU1eWIy?=
 =?utf-8?B?SGFHTmZGVWZLdzNpV1Y1NVJLQ2Z3MFRRWHh6MnhEWHlPaGh3azFYNmNLZVdu?=
 =?utf-8?B?ckx6RzFOb2NGTWNqL2l0K1NIUzYvUlhPNTJzYVRYNjB6R01MeGh5WnhVcFB1?=
 =?utf-8?B?MEtZdHpqTnBWbXNsSm5BUXFRakhBRjc3YXdCUGQxOUJEVzliMzNCaDhZWkFi?=
 =?utf-8?B?LzhJb2MvWDIxWTZWem41U3Q4TEdhOGtUMTFtVng0YzlyQ1JtMWljWDVwRVRh?=
 =?utf-8?B?aDlZY0NTRGpUcFNZREVlRHN6MEpnQTZ2cWFERXBQMUtkWHJ0NTRsMVJjZXZl?=
 =?utf-8?B?SDJrcXZUYjNNd3lXY0laVUh3SUhpVythOGZ6K3Z0bmljVXExMkJNMmV4M0NG?=
 =?utf-8?B?VjcvUjQyOTViSlBhb1RpYU0rd3hpM3FTRFprSldxWG00bDJJWU8zWHFyQStF?=
 =?utf-8?B?aUl3b0YwZjJuNFhEUHlra3JmMFdsdTF1NjhDSDhiZHFwd1QzSlJNczRLcnpw?=
 =?utf-8?B?aVFnWjhremhiMTFMamZLL01Zb0ZxSHFabURMcDltUVJ1TDVlSzR3c3pEaGI0?=
 =?utf-8?B?dWhIZ1lVSWR0L2VEQVBReGFSOU14cWlDUWFUZTJvNS9YVGlKMEZPUkpMbzZZ?=
 =?utf-8?B?SDVOLzZDbFVvd1htN0M0NVZlSkNNMDh0TmFoUy9xYlRLOEtXRHpHRTFsVlhm?=
 =?utf-8?B?dlUwTDFIT3BWd0NXa3ZzMFRZTVRvQnZGb3RlL0ZmeDV5VTdQcEt0RjM5V2Fq?=
 =?utf-8?B?bzZrNXlOVVA3T280SmNQMUNmRHQxZmxPTC9XSHg0Z3lNb1gzSXhMOFlSSXQ0?=
 =?utf-8?B?SUhub1VhcTV2cmxYMkhsQlB6RzRDTlFLN3htKzNqczE5MThXVUxzNU1Da21F?=
 =?utf-8?B?b21RRnZnbWt2d0tsd05XZHVGNDZwRjJ0RCtkVFc1ZjQ4aTM3WUNYOXcreTZL?=
 =?utf-8?B?aWZxSTFXZEdzRGdZQWVOcG5Ea0NGNEpXZFJobWxkVzJZNjNLN2lsdDU5OXJh?=
 =?utf-8?B?TGpZRjZwV2ppTGRQc09MblpMUGhjYTQrc3RzVi9ZcUNLOU9FSFpIV2lpRUZY?=
 =?utf-8?B?NE5FeWZKVTlXck5ucyt2ZFNlaWZxVlZsWk5KU25NSWpiWW45akhrejB2KzNx?=
 =?utf-8?B?RVExTkZLZjRuMVpUMFpLbEVDaVl4K2ljcExNcFFVZlRlc3JGSm9zb2VLNGdE?=
 =?utf-8?B?b1U1QUlVeXNpalYvQ0lPY2xmWGczakpiQU1rRXdJcDQxTjlyMVd0WmJiR3Bl?=
 =?utf-8?B?cHJmWFBSZXFsZHF3MVllY2FUZityejdqME1KNitwOW9hZmE4RWZ4Q0o1TVBG?=
 =?utf-8?B?a1dwWGN0b0ZLZHNmcDJpdy9aVnpxVlVMdnozS1hFcENJMnVOKzhMa1RWZlBW?=
 =?utf-8?B?VVBrOFpJdFAySTZCcHBsbmNMdkxxcERDWk1FWTJUREFBa2xxRW5yUURkRXpJ?=
 =?utf-8?B?dE91cUE4T1pNRHFtL3pIR2I4ODBOR0hWTkU3azQ1MVk3ekRaVWJwR1IzalRP?=
 =?utf-8?B?OEsrdGk2MHZxMElLK2ZYSyt3TVJtVytXMzdRVjE4TG8xMVZrYkpsVjQ0bVRE?=
 =?utf-8?B?STRRd1ZNRjd6WlpoRm9BQ3huOGRJTHlOMUlOaUhuRitWUmJwZUJRb2xYT0pT?=
 =?utf-8?B?bXR4Y2FRejJpU0Y5ZEVDRHRwbnBBV2wvMmx4VlIreEtxaWZPNTRWSitVRXRq?=
 =?utf-8?Q?Q/w0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 03:51:23.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e786936b-a4dd-406b-d926-08de2b0cbc7e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
X-Mailman-Approved-At: Mon, 24 Nov 2025 13:50:30 +0100
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


On 11/20/2025 9:33 PM, Markus Schneider-Pargmann (TI.com) wrote:
> After leaving the Partial-IO mode or other deep sleep states, the IO
> isolation needs to be removed. This routine is shared by at least am62,
> am62a and am62p.
>
> The original function for testing was developed by
> Akashdeep Kaur <a-kaur@ti.com>
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c    |  2 ++
>   arch/arm/mach-k3/am62px/am62p5_init.c    |  2 ++
>   arch/arm/mach-k3/am62x/am625_init.c      |  2 ++
>   arch/arm/mach-k3/common.c                | 57 ++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h                |  1 +
>   arch/arm/mach-k3/include/mach/hardware.h | 29 ++++++++++++++++
>   6 files changed, 93 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 48d578e7d6f180f06b42003313bf643c725eae7e..60645272c816023798cc5d6fa46a2c569143343b 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -101,6 +101,8 @@ void board_init_f(ulong dummy)
>   	/* Init DM early */
>   	spl_early_init();
>   
> +	wkup_ctrl_remove_can_io_isolation_if_set();

Looks like, above function may return error, what is your plan to handle 
error case


> +
>   	/*
>   	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>   	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index aebd5200b0db9959805d04408b34d283e21b6e2c..1c47debca61598ecacae03d83b4001a72dda164a 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -160,6 +160,8 @@ void board_init_f(ulong dummy)
>   	if (ret)
>   		panic("spl_early_init() failed: %d\n", ret);
>   
> +	wkup_ctrl_remove_can_io_isolation_if_set();
> +
>   	/*
>   	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>   	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 14f93ac998f7d11997b753550c0ea38926e35e64..6eae8929ef7722ff46f67c82d2e17eff618eaff2 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -201,6 +201,8 @@ void board_init_f(ulong dummy)
>   	/* Init DM early */
>   	spl_early_init();
>   
> +	wkup_ctrl_remove_can_io_isolation_if_set();
> +
>   	/*
>   	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>   	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 7c06764af8256b7fd27f8e7f208a597b1b91652b..3cc4e7cba0d1e834280fcce3d1140ca32247d807 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -33,6 +33,9 @@
>   #include <asm/armv8/mmu.h>
>   #include <mach/k3-common-fdt.h>
>   #include <mach/k3-ddr.h>
> +#include <wait_bit.h>
> +
> +#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
>   
>   #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>   #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
> @@ -115,6 +118,60 @@ void mmr_unlock(uintptr_t base, u32 partition)
>   	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
>   }
>   
> +static void wkup_ctrl_remove_can_io_isolation(void)
> +{
> +	const void *wait_reg = (const void *)(WKUP_CTRL_MMR0_BASE +
> +					      WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
> +	int ret;
> +	u32 reg = 0;
> +
> +	/* Program magic word */
> +	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
> +	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW << WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT;
> +	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
> +
> +	/* Set enable bit. */
> +	reg |= WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
> +	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
> +
> +	/* Clear enable bit. */
> +	reg &= ~WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN;
> +	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
> +
> +	/* wait for CAN_ONLY_IO signal to be 0 */
> +	ret = wait_for_bit_32(wait_reg,
> +			      WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
> +			      false,
> +			      CLKSTOP_TRANSITION_TIMEOUT_MS,
> +			      false);
> +	if (ret < 0)
> +		return;
> +
> +	/* Reset magic word */
> +	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_CTRL);
> +
> +	/* Remove WKUP IO isolation */
> +	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
> +	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0;
> +	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
> +
> +	/* clear global IO isolation */
> +	reg = readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
> +	reg = reg & WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK & ~WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0;
> +	writel(reg, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_0);
> +
> +	/* Release all IOs from deepsleep mode and clear IO daisy chain control */
> +	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_DEEPSLEEP_CTRL);
> +	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
> +}
> +
> +void wkup_ctrl_remove_can_io_isolation_if_set(void)
> +{
> +	if (readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
> +	    WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE)
> +		wkup_ctrl_remove_can_io_isolation();
> +}

All of k3 devices may not use this function ,  consider to add 
__maybe_unused


> +
>   bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
>   {
>   	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 52d3faaab5c94578cf4f7e288cbf840500d490a1..49417679e2ec7210d5c95540f476a5d8ee548617 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -51,6 +51,7 @@ struct ti_sci_handle *get_ti_sci_handle(void);
>   void do_board_detect(void);
>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
> +void wkup_ctrl_remove_can_io_isolation_if_set(void);
>   
>   #if (IS_ENABLED(CONFIG_K3_QOS))
>   void setup_qos(void);
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 81b5f1fa45ea30456a43c6640aad01388ea6a3f2..d7c759420524faf48ea26c66607c6a899d1321b3 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -117,6 +117,35 @@ K3_SOC_ID(j722s, J722S)
>   #define CTRLMMR_LOCK_KICK1			0x100c
>   #define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
>   
> +/*
> + * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
> + */
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x18300
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x2aaaaaaa
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT		1
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN		BIT(0)
> +
> +#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
> +#define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
> +
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0		BIT(6)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0			BIT(8)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0			BIT(16)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0			BIT(24)
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0_WRITE_MASK ( \
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0 |	\
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0 |	\
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_ISO_BYPASS_OVR_0 |	\
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_WUCLK_CTRL_0 |	\
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_GLOBAL_WUEN_0 |	\
> +		WKUP_CTRL_MMR_PMCTRL_IO_0_IO_ISO_CTRL_0)
> +
> +#define WKUP_CTRL_MMR_PMCTRL_IO_GLB				0x1809c
> +#define WKUP_CTRL_MMR_DEEPSLEEP_CTRL				0x18160
> +
>   #define K3_ROM_BOOT_HEADER_MAGIC	"EXTBOOT"
>   
>   struct rom_extended_boot_data {
>
