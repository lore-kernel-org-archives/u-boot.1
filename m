Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D2ACCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E9983F8E;
	Tue, 11 Nov 2025 14:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Csvd0ExO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FD6839D6; Tue, 11 Nov 2025 10:28:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A902783B47
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 10:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuxoLX08aMpLKjhNihY4LLvNDZIpieNu51ttcpHgZG20KGbaYQttNp13MhBfqOpoLwyuUDFXGd4vs6B2nEKfquIL02PkVs314ZyW0oFfH4BsMcLy4oCefVCLMRVL1GkNl1IulbZLh5DlqAJ8+iLhRAWQyS+mxxTBHu/bLwC13Ava+1fK/hDvNatLhmOYx67qOXeTAaDLyCaTFD4sQsCYexG+DE0hp0GSQGN7kLlhzX31XdVvT0cTvHoOymznnAGv6eWZkCpq6mdVFokJnSw+yOM8T99dYFaoqokrVm1cWvy92pv8S/qWtkOfWLln5JlTh4uPoEbkLEfR5PG8B45BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsflQ+SMSzL1pqCyWuCuXw7Ss9szpczWWfMBOK4MRi0=;
 b=l80PkJTh3MhLlB96AiRJifQ2uWJXXgBvLSIpO39jMTfnPrPoIcSje6GJg5F6kiUjij0gSBvclkeZrFnrGBiX6p/no0jIpqdo/pS5PuYzI7QbThJCv/UNjaZa4EgCKb4m4aCx0Nvw/zH6qvmxGZYFPXiZ6wIptm0VdCxtTl5jdOMYlP1tptf6u/BYDez07cnK1OMsNBeWnm8BAy4c14P4/Yl9PakYWkMKH4zOGw1JNfU5UsevSsMh3z/cyK7Cykpc9ygk5gvjFCaoyHWiaG4TgOgFCrTbXATFjFuAm9gk9uFvKP1zbGeD5+8KYENGdYUJyE2baTnUWBQkh+vl/4ASlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsflQ+SMSzL1pqCyWuCuXw7Ss9szpczWWfMBOK4MRi0=;
 b=Csvd0ExOdLh8o/solO8Y2EeII9V2xJgcIpJURaVRUa94Xj7s4x68UBZz8SbFRJ5Aby7jqsl3qmTl+515C2JaKcqonOSPgzwca0c4/3luAvypbGlPgz4SpQyTipSarEMRtg2aFjvSQRwP5w77dSSCBHN2jPuI3dQ2/BulPN+9ngU=
Received: from CH2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:610:20::27)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 09:28:39 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::5c) by CH2PR07CA0014.outlook.office365.com
 (2603:10b6:610:20::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 09:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 09:28:38 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:28:33 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 03:28:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 03:28:30 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB9STuR692188;
 Tue, 11 Nov 2025 03:28:29 -0600
Date: Tue, 11 Nov 2025 14:58:28 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vishal Mahaveer
 <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Sebin Francis
 <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>, <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, Devarsh Thakkar
 <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andre Przywara
 <andre.przywara@arm.com>, =?utf-8?B?VGjDqW8=?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 01/13] arm: mach-k3: Remove CANUART IO isolation
Message-ID: <20251111092828.bchwvvzv3ymhqq44@lcpd911>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
 <20251110-topic-am62-ioddr-v2025-04-rc1-v5-1-980ee0036c26@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-1-980ee0036c26@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|CH0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ff3a99-ef4a-4495-879f-08de2104b215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UUxxb8ux/gBpdXbw/+9OGN152NIcvVWc262gbPAGzvRjIwpeTHmItHy6Xx95?=
 =?us-ascii?Q?47/ukZJyVlUTXg3DzIZHUB2SMtCUfDgMUTVnQPQduFMy+fzNQVP3+Q4Bbm3y?=
 =?us-ascii?Q?lgroEWa0F26/t+FkkZF9U4OjjGLnwQqoRU+1EqBinwWLUAQiSBPNCk7ruDmS?=
 =?us-ascii?Q?6VquBXXpdPzLSJYQL52lRkieFOopYFO0b6pl0/RiCv/aDqA4iBvDkrjnZjTf?=
 =?us-ascii?Q?CLufukwPq47zwd0GWQXrLBPAygRh4w5CpKfvAEVdbazEYBC7WzS17YgyPo4A?=
 =?us-ascii?Q?Il13hHcYbcHXjUSyxLvwrTAKBcT99I3CaHlq4V08g4l78JJSNBmtp3rv1oXj?=
 =?us-ascii?Q?OkQ/fHNQrAeS2SzQLp+5YsBo0D50sGZs+uSGaK8dJ/IXypM3PMpFY76eP0Qx?=
 =?us-ascii?Q?CI5RMS79tG4+3q8wfAQM+5W2xlyirEglW6onaLWjoLTXDuKdb/PxKmV1eNHx?=
 =?us-ascii?Q?S06emZomPVwyt/lAf4XW5HuY0Vca5rbTNogTagIioCSCgFDkS4fMS1NIXbrn?=
 =?us-ascii?Q?abmw+0Zn+Yby8RX+dTRdbIY4gCnWxWi2OHMTITCE0jEr5iVGeTkGcSmqBhxs?=
 =?us-ascii?Q?1PjCYndaviWKjIMk9CtkAkMmfqdbS3TD5x3iiBHYTpnR5XBZ/s2T5MdW1lmG?=
 =?us-ascii?Q?leYErdsFuB0odqyGa8KwyCmjd0BPqy8NF1eJHl3XX+efVNjdVW1JN+8xqAF3?=
 =?us-ascii?Q?EzVN6Xm5U/WuvhFnP52cp+4o8j+B3HAJSMMSw9yv+UNO8SL7JqHcVJ5mnG13?=
 =?us-ascii?Q?Xbzsq/DJ0KstROYT2pQ1BEtbbjNy81nyBS9woVGvyLPP7K7HqxkDIWqMcSo5?=
 =?us-ascii?Q?QIO0YoQ61Ng2SZ+6JzXhfLD9idGljvgQ01RHeVqfrJuCuOyI3zeszjUwxYDQ?=
 =?us-ascii?Q?VP4OyXe/Zd/fi4UslLNLqZOFtcHnXRQT5vfM43364xfiAdWJRoQVrG3Glbte?=
 =?us-ascii?Q?vGSmI7bKhTaKDgf4lnmgUDqA269UwHwWICOgzCryKMtxZlmCrmzXKpI2zjvR?=
 =?us-ascii?Q?6aTA2qc+RlViDGMzeBvBjVZUs4ZQg6WvE2f8sb9zWOGT7azDCIzC0TbPkTuL?=
 =?us-ascii?Q?3S5pgBG47URzbaz8MMirHG0w32fXRmJTWmhwixCbjhixPwtcZ5UrZSxmHGCV?=
 =?us-ascii?Q?SbvcKa8YAfjC1A+AjUwa9Q2TVk3ffATFzjODJC9dtgglckBCVNW0U7zg43II?=
 =?us-ascii?Q?MUufm/Tg2B5/79Nvu5jDDvmGeb/M2WBjx9AtBB6IuA2WXTH9FKfXUYnbIe8g?=
 =?us-ascii?Q?NsCpiCHbc0Yszf0n4msOWr8FgjAtbmr7VJ9l9W8bAyahantnycHAi6gkAr6P?=
 =?us-ascii?Q?VxHNgkakD6v6rRIUQjRVM3uZDP5gPrVW+cI3LHcw8lHMn5wUnBuqVSOjT8Mt?=
 =?us-ascii?Q?FAkVJZg1q0gP+Uh+NQrWg56jMgIw2+K80H+iSHGmFo5mXseYVu6wsbRVKV8y?=
 =?us-ascii?Q?JN9sQP2fPUcsMHgNSSES1HkFO2M9nPrK2gr+1ZJ+6huPj4+07TwnVBdrA4Wr?=
 =?us-ascii?Q?Xw0LN2xh5iuounhR0uaHL5s0h/cf5CVNast27DPA9h7XJRkwwIrq3n6pK97J?=
 =?us-ascii?Q?+Ng6H9c6/s/5oVeXKbo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:28:38.3506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff3a99-ef4a-4495-879f-08de2104b215
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

On Nov 10, 2025 at 21:10:25 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> After leaving the Partial-IO mode or other deep sleep states, the IO
> isolation needs to be removed. This routine is shared by at least am62,
> am62a and am62p.
> 
> The original function for testing was developed by
> Akashdeep Kaur <a-kaur@ti.com>
> 
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c    |  2 ++
>  arch/arm/mach-k3/am62px/am62p5_init.c    |  2 ++
>  arch/arm/mach-k3/am62x/am625_init.c      |  2 ++
>  arch/arm/mach-k3/common.c                | 56 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-k3/common.h                |  1 +
>  arch/arm/mach-k3/include/mach/hardware.h | 29 +++++++++++++++++
>  6 files changed, 92 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 48d578e7d6f180f06b42003313bf643c725eae7e..60645272c816023798cc5d6fa46a2c569143343b 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -101,6 +101,8 @@ void board_init_f(ulong dummy)
>  	/* Init DM early */
>  	spl_early_init();
>  
> +	wkup_ctrl_remove_can_io_isolation_if_set();
> +
>  	/*
>  	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>  	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index aebd5200b0db9959805d04408b34d283e21b6e2c..1c47debca61598ecacae03d83b4001a72dda164a 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -160,6 +160,8 @@ void board_init_f(ulong dummy)
>  	if (ret)
>  		panic("spl_early_init() failed: %d\n", ret);
>  
> +	wkup_ctrl_remove_can_io_isolation_if_set();
> +
>  	/*
>  	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>  	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 14f93ac998f7d11997b753550c0ea38926e35e64..6eae8929ef7722ff46f67c82d2e17eff618eaff2 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -201,6 +201,8 @@ void board_init_f(ulong dummy)
>  	/* Init DM early */
>  	spl_early_init();
>  
> +	wkup_ctrl_remove_can_io_isolation_if_set();
> +
>  	/*
>  	 * Process pinctrl for the serial0 and serial3, aka WKUP_UART0 and
>  	 * MAIN_UART1 modules and continue regardless of the result of pinctrl.
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 7c06764af8256b7fd27f8e7f208a597b1b91652b..b4a605503d27b29d0fb962fbe4c94650a1f6c54f 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -33,6 +33,9 @@
>  #include <asm/armv8/mmu.h>
>  #include <mach/k3-common-fdt.h>
>  #include <mach/k3-ddr.h>
> +#include <wait_bit.h>
> +
> +#define CLKSTOP_TRANSITION_TIMEOUT_MS	10
>  
>  #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>  #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
> @@ -115,6 +118,59 @@ void mmr_unlock(uintptr_t base, u32 partition)
>  	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
>  }
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

Nit: Missing what the below writel 0's are doing, I guess it's just
resetting them to reset value? Add a comment to explain so that those
without hardware sequence knowledge may understand.

> +	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_DEEPSLEEP_CTRL);
> +	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
> +}
[...]

Either way,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
