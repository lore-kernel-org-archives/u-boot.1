Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910DBD59F75
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 06:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F654830E4;
	Sat, 13 Dec 2025 07:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C+khKG4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1618583106; Sat, 13 Dec 2025 07:31:52 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E3283045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCDljysj4WWwMjWnl6TqbxinBa2gJsoS+xcGmLf1KolIco6S7XoeNZKtVWuEcsR4/MsSFVvxGtALrE1ziO6XkMjow/nlsWfhlxnVzCSHVt8x/RIc202uGjASJ3M4XH2941bLrc9ClbTrMCazCZ5jdG3oFoW8qSL5txmNx4b6gua3ddaHaz9xzS6e6bhEKBrfz0W9/80jlz9/pa1LIeBAUh1l09CxubcXxJyzrcU/cIcovUxIAHx0wJjoDSaACTABgcu76LyJTsxbHCkn+CbvACMFfiL+n9rult8zuvIAt/iClpNi1BQNKROOLRz8rNqekwAjvsIBRJJPYO0vDqzzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbuSK5R5d9kyGEEAyrwELDHbcI8L/7pyvIy0P79BtA4=;
 b=p6IdDHDTqfA0PJ/9E1h/aeRkmVAdBG2EeOWAPqUdJj4nWPpB7SA0+A+m6WXVK4sOVnI/4A1R4USPGWJfgjgEJejMURn0alStDgPiwcsN+rXhyjXh7yBQM1oO+tLrnNOWzCfqBm97ARs0gXbFhWwJKlbgfgfdMLOz7DQ6rCJutmitUoOwo5kAFP/lbjWrZ4ZMKt3Y/3vDXqsdDy+ZjL9uYxcXmlgIaVmawq0cSUuE55dt4TdIADBfd4eLIZ6YdG2Qpu0WiScPaLSfU6MF+EQ5YnnX+vBFC557YgAZuJBjl2HfTakccsXf6109aQd37d0yaY7tVQs/4hMLOdCUePZ3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbuSK5R5d9kyGEEAyrwELDHbcI8L/7pyvIy0P79BtA4=;
 b=C+khKG4pkCjG2uoLt4aXNMdH4254K9ntUsb+5aI29sEjZvaS+Or0BPjIeaqRxQXthjQFeMkUlEC01fYMa41ACpKlC01B11EnMRRWzIyp8DH7Y2HqB8OEdRtPUuKCMPHOAmPpCn/ZwA+DmzUm1cvCxm+fPHNyT8Mp3M7zj2rSfW4=
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by CH2PR10MB4134.namprd10.prod.outlook.com (2603:10b6:610:a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:31:45 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::ca) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.12 via Frontend Transport; Sat,
 13 Dec 2025 06:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:31:43 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:31:36 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:31:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:31:33 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6VN3F3317862;
 Sat, 13 Dec 2025 00:31:24 -0600
Message-ID: <338a5ec9-5a83-4508-986f-969d1cd711a4@ti.com>
Date: Sat, 13 Dec 2025 12:01:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/13] arm: mach-k3: Remove CANUART IO isolation
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
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-3-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-3-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH2PR10MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f29699-ad45-47ce-46ac-08de3a11480f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2ppSVNPeERvdHJVZHdoUktmcVFDaHVBc000c0VoTWU2cC9UU2hQbFhFeUZO?=
 =?utf-8?B?cFZDbzhTcVdtcUgzS01IZVBYa0lMWmpRUUZLSWRhZzBUcXJRalJCQndnd2x3?=
 =?utf-8?B?MFhUV0tBa3hiQUp4QWdyS2dzOFZDUEI5QmlSZHJhd3V4UE8xd3pZNFA0a0M5?=
 =?utf-8?B?NDhQMEZoa0hFMmVRMTNGWjFwUC94dElnUytOTnp3dzNpNkJIRkl3VS9DYUdn?=
 =?utf-8?B?OXZ3NHFwZVJkbUhFdmlWdytQUWdDRHkrVmV3c2dydDZ3YUp3bWUzTjJBZm5v?=
 =?utf-8?B?Ujl6anpaWndXUTB6bFIrZDBEakRxbnJyV1BGSFBiUmFkdzdzckZvckh6SmVw?=
 =?utf-8?B?cEVSRnpBM2h5VzlXa29tYlZ2M0VKUEdjbFVPTzdqNVpiU3BOWGNJcWlkRWhx?=
 =?utf-8?B?RmU4Z3lmUnV5QlFZZlJiZVEyU3NIdFhNWUtTUW93bXBqOEpnenlkTm1Cblh5?=
 =?utf-8?B?SlVFcUhrejVsU0dOL25NUHphVG1oU0R4d3ZObVlEL2NNUHFTTlVuQVR6dHM3?=
 =?utf-8?B?aVNQeUxSUzZOZEdwZVN5L1lrL2o1aWJiUDdjK0UyOHI2Tms1RnZ4U0NiMmZi?=
 =?utf-8?B?WnFlSHJ4dTRwTjJpYVZ1Q2hwcUtQVUNaZFl6Z0UzSnBuSjNRNmREeEYrT0N0?=
 =?utf-8?B?ZlVocnpvbmdFaUdMdldUY2RCc0JpQndtU0pMQWhxbDJ0MzJSUEpHY3RlWWlk?=
 =?utf-8?B?NUNTMEpUS3JTK0JLQ1BTL2lJa0FQNXBQWVNqNWx5Mlgwc2duTi9PdGdwZzhq?=
 =?utf-8?B?SFZnc2JSYS9tKyswWTBlOUR2UnlNNmk0ZXltZGk1ajU3ak1FbjRvSUl4a2Ji?=
 =?utf-8?B?WlhXTXJxRGFRRUhLVEhyS2NkY2l4R05BQ09GOVpyb1B1dzhhTjVPQlUrUjRW?=
 =?utf-8?B?a0xKRDNwcmZPZW9zb29rcHVPemltaG1qWlRNRWtFaTBac004Zk1PN3g1OHRj?=
 =?utf-8?B?LzhTVEMyeDNhMmNnUVBLc0FFelpHRWdRZWZIcW1EakEwRXRMa0N3NFh4OUcx?=
 =?utf-8?B?ZVRUdFZkSW1rbFhJU1dGdEUwSW5oUC8rY3g3RXpuTjBxRmVQekdhUGZwWHFZ?=
 =?utf-8?B?TDl5ZC9wQ3NkK2F6YWNVZWY5T0M5WmZuUjFMeFF5YzRobHN5SW1xdWNqanNX?=
 =?utf-8?B?bGhmZWZ3YWIvdUwvclk1eXIwclRkUkVYNi9ITnk5Y08vNmRudmpRR0FHRkcw?=
 =?utf-8?B?WlZLNXFLMmlEL3lQNk1HTmNXSndyOHUxQmpPVndIdEZrMW1pNnNUQmZhM2c0?=
 =?utf-8?B?Yjc2akpvTXVpSFhqQXdyQXIvczl4L3VjUXdoZ0VhcHNuSCt6Y2VVZHhTYWxB?=
 =?utf-8?B?TEM2U3h0SzFkeEkyYzV3Q1pvYUlHMjNWVDB3RG9XeHZaWkJCTElWc0docU1E?=
 =?utf-8?B?aVBmNGRUWTUzZU5JR2hnSUo0ZFVjUktWY3FjRmpBMVljOW0vUGJNRkdtYmxi?=
 =?utf-8?B?OFE2Z1grZDR1TmNDQ2VvNU9nQkRvSGxVTTROSWxEV0lJaEdhQ08wb1o1bnAy?=
 =?utf-8?B?VkU3dlBSb1NMeUpoOWdtbENLb05HQ0hCS3RYK3ErSFduWUlpbU1wTDJySzR5?=
 =?utf-8?B?T29LWWpNcXcyN3VRUVFiT3VoRE8va1VBTG5HWFlWZ1VYV3BsY2xSRzVkS2Zk?=
 =?utf-8?B?TVFxcXp6K1VRSEdmc0VGem53K2l0bVdjMmFXOThHS0ZsaUZGTHhxVFdMU1Fn?=
 =?utf-8?B?NUxxNVpBNEFUdWhLcFozbWdWZlNIQlpoaGZYeTNHV1NLRFBobGdVdC9TYllw?=
 =?utf-8?B?a0NZNTNHcjFsb2k4eTVzVEQ4UkhyS2tkY0ZINFNiOWc4NUhzTnB6NmpHRXN1?=
 =?utf-8?B?ZWhQNnRtbGNlMHNBZzRVeU80NmRSUk8rNEVYdXQxWk9HUTRCRlBHTU1jdm9x?=
 =?utf-8?B?RHl1cDlDNEw2eU1HVkJyS1N0L2ppeHhaTTNrS2pVOHc1TDhNbWtyUFQ4STBh?=
 =?utf-8?B?T2lqSmZnOHo5WW9TQ0VneVhYcGFNV01zczR2TlFSU1dLeitRNnZhVVNjYTRn?=
 =?utf-8?B?ZUFzNzhqRTVtajd2cXUwQjY4OFZSdjhobjlOMlp5WU84UU1CWGR4VDhPOERC?=
 =?utf-8?B?RjNORU5iN3A3WGFJMDhicUxZU1RsNkFIVjBFTVdXT1pCdTFuK1BXQysvK3pn?=
 =?utf-8?Q?7cjA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:31:43.0544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f29699-ad45-47ce-46ac-08de3a11480f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4134
X-Mailman-Approved-At: Sat, 13 Dec 2025 07:37:52 +0100
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

Thanks Markus,

On 12/10/2025 7:38 PM, Markus Schneider-Pargmann (TI.com) wrote:
> After leaving the Partial-IO mode or other deep sleep states, the IO
> isolation needs to be removed. This routine is shared by at least am62,
> am62a and am62p.
>
> The original function for testing was developed by
> Akashdeep Kaur <a-kaur@ti.com>
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c    |  4 +++
>   arch/arm/mach-k3/am62px/am62p5_init.c    |  4 +++
>   arch/arm/mach-k3/am62x/am625_init.c      |  4 +++
>   arch/arm/mach-k3/common.c                | 59 ++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h                |  1 +
>   arch/arm/mach-k3/include/mach/hardware.h | 26 ++++++++++++++
>   6 files changed, 98 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 7de234611639d119db5c7a718738a02cedf8028c..24fdfdd7f1d9146f0cb6dde333d2bb54df96700d 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -101,6 +101,10 @@ void board_init_f(ulong dummy)
>   	/* Init DM early */
>   	spl_early_init();
>   
> +	ret = wkup_ctrl_remove_can_io_isolation_if_set();
> +	if (ret)
> +		panic("Failed to remove can IO isolation when set %d\n", ret);

> +
> [..]
>   

>   	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 55fe1f06d8b04a0bc27a88bb63a1fdc0b1eb383f..a68924a2123961642b63401f3600ac825fb62da5 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -52,6 +52,7 @@ void do_board_detect(void);
>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   bool wkup_ctrl_is_lpm_exit(void);
> +int wkup_ctrl_remove_can_io_isolation_if_set(void);
>   
>   #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>   int k3_r5_falcon_bootmode(void);
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index 6f425d03be5d9cbc03a0daac5e9b10fadd176335..8b5698ba8e99e32d9b41e8e476ed433481726b8a 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -117,6 +117,32 @@ K3_SOC_ID(j722s, J722S)
>   #define CTRLMMR_LOCK_KICK1			0x100c
>   #define CTRLMMR_LOCK_KICK1_UNLOCK_VAL		0xd172bc5a
>   
> +/*
> + * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
> + */
> +#define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084

This is specific to few SOCs, and not common for all ,

So, please make some Base-SOC file, which can share this definition

e.g J7200 SOC

at register 0x4301_8084 h has CTRLMMR_WKUP_POR_POKLVB_UV_CTRL register.

and does not share below bits.



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
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x18300
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x2aaaaaaa
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_SHIFT		1
> +#define WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LOAD_EN		BIT(0)
> +
>   #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
>   #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
>   
>
