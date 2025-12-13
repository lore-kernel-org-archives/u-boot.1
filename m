Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE50D59F6D
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 06:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D526E83655;
	Sat, 13 Dec 2025 07:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RZLQ28KE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ED683106; Sat, 13 Dec 2025 07:37:17 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F010683045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B43qZn1ZKz80idUkB3szNfEVCH3/NESdm9bmYLKmZWg6EfPVvMyt/bC1ZV4R3sqU7bh7SV07T7Eg8UZk0Jaq0xmJpQY0z4BZSPgkvmL66qwJsTobEeLSm+d2CIYpTZ9FBo24dP7yDZT0MXLHSx5SeKs/Ogn5LfL2VDwKZRwBI28svUjA/MtoaT81ywk6TSZT1DgL9nj6pmdGSoDswcHeKi7V/5dJwq6j3B7HZIFSE466cnxk1I+jKQxQ/XkZTg+PcALCQIopmPk+b0/qJ2A0OfMg+hItItEvGG9ERGpbHxlgTBG8VlqbHdGn5a8bTTTaYCP2T/gpkDMw6FsD7EFM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU22ATL1k0m53pvRg4QIhbNOhgkNRNRAYiGoc0Is2oM=;
 b=ZwWq9juZzEreGW+TrxC/qPjzTByANKiyvPSNiHkwMK7+8sIl5Ow3FNxlF+9wdNX+xVxWlcA5PNPy8LT8CrdGWUEQeE3YRiRGp8Jkar3JeIYohLaStbDNWYZvJkkWvHov+I3oNtQWqKrcvnXHBlW916B+3JqwX38oVfzm8tae5PzGoO51N6SHVMj/e8OLXqCdSeECC9x0a2wk1DpNclPXurzOHRF1CnpjrInS9VUSaOJsKBTa0iiPHN/8nEe+L6crKU4CSJMhIhj/fiL0Pl6UZhQbCgVdjGbT91lcx5IV2hp4Z7blD9DIKdyunYrtg9Hq0t0kb0+3Cg0UYNShmd67ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU22ATL1k0m53pvRg4QIhbNOhgkNRNRAYiGoc0Is2oM=;
 b=RZLQ28KEkt2xLTRVbyCAHZsozE9xErUx6krh98Af9djhQZz5Z+77AWkM8llH6QKMqV00o9e+8EcfgAYQB0Oaer/QQWaZIlXZMg2i66e0HhkhnTzfCox9nQzOjaz2Jojui++DNMuhVZqn+Pa3189JdCd6yO35kIUeWic8Y4tHbQs=
Received: from SA0PR11CA0123.namprd11.prod.outlook.com (2603:10b6:806:131::8)
 by BN0PR10MB4967.namprd10.prod.outlook.com (2603:10b6:408:123::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:37:12 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::9) by SA0PR11CA0123.outlook.office365.com
 (2603:10b6:806:131::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Sat,
 13 Dec 2025 06:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:37:10 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:37:09 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:37:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:37:06 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6auh93323195;
 Sat, 13 Dec 2025 00:36:57 -0600
Message-ID: <13b96a65-9b39-4c08-bb85-9dee290ffddc@ti.com>
Date: Sat, 13 Dec 2025 12:06:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] arm: mach-k3: common: Add CANUART wakeup check
 helpers
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
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-2-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-2-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BN0PR10MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d71b6f-6c89-4e48-9337-08de3a120b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDI1dUlURFlYL1dObHFsemVJL0R0ZUNxRE14YkJ6QlVOQWppVVFoRThGU1lN?=
 =?utf-8?B?RGJiNGxZUWs4MDBqaktNRENSY2R4ZEJZTC9iT1dwVU02eWYwemVWaUFBRkx1?=
 =?utf-8?B?dDYxUFoxOGtLQS9nTnZSN1VERG5RcGhVZnFtOHBQL3RaZXlCR1VRT2dPc3JQ?=
 =?utf-8?B?V3RwMEU3dW44V1RDODNDclpDZk1iejVBdTdxVVdkNksrRE1WaVNsUEd4VzRs?=
 =?utf-8?B?UHNMaHkxVlJNN3NtdmVQY3pCS00wbG1iK2RvNHBvZVRRSEN1cmQ5SG0wNHN1?=
 =?utf-8?B?R1ovSGZGa3pYUzUzV0toaXZYRnUwYStkUWx0L1M1Yy91bTMzdndKMUpnYTli?=
 =?utf-8?B?VUsveGFuNSsyQWZoRGc2UWlnSTF3cmRYdmQyZzhDZmVmRFVIUUZqbTFNMHhX?=
 =?utf-8?B?NDBQUGdmbGdZYlg1MTVNSW1ja0gyY0dhSm5VLzFLRzFPSkxid2tDd1pGVVhG?=
 =?utf-8?B?K3g3Y0xZaTVodGI0S1E3dlI5dmFGMEExVi9hUitvOWdSUnRwYXpUMmt1Wmpi?=
 =?utf-8?B?NHZUVEoxYUprTTNQWlJZTXkraUVrZXpMdjBHU0UrL3VTSUU2NGU2SjZycnl3?=
 =?utf-8?B?NE9xU0VKbWJnbUhPdUFiQ1FadnBmK2ZkTUdoQVRJdERKdHRsandWMGs0R0gr?=
 =?utf-8?B?T1Yzc0VUNVY4UEl1ektGcmtITGhBUlZ3ellQTGdWZDNCdjhOYXY4ajVieXJF?=
 =?utf-8?B?OXJJTy9TTFBXSTg0TXFNNDZnR2tPTUZtVlVMNFpXWTk2ZnhTVWNtc2d4T045?=
 =?utf-8?B?NW1QQnVJb0pNaHQ5SExwMDBnbmtQY3M0cXlUODkwYkI4OWNiRlZ3ZU0yVVln?=
 =?utf-8?B?Q3FDd0VBRXJoZGsrZ1pTTTNZMFBvRTZESHlJbXBCczRUT2RUbi9RT0Yyd2Jy?=
 =?utf-8?B?WVQvVEo4VWdNeUxTZ2ZydW5LVW5ZUTFscmkwQkRDbmpMRUNFTXBPNkF6VWx3?=
 =?utf-8?B?QUdHYWc0OXhQc0tlYmp2MDZ0blp4SWxmbVV4WFk5RGdRSjR2YytFaWoyS29F?=
 =?utf-8?B?cUR4cVlFT0VvbSthRmUxbE5RMWY4VU50LzZvRUg3RUdkd3lpYkFpckwvVkZu?=
 =?utf-8?B?QVB0OXFHRXZ0S2ZxRkw2RTZDeEZRalhidW5sL1pud0RUQ3p1ZU1ONDZvUDdM?=
 =?utf-8?B?dHZ6TnJuRDR0TGRjNU5GNmF6QmlqWExUMENlMm1Fdm9WNDQwZkJsNmdLNmwr?=
 =?utf-8?B?V2E3SnM5dUxmZVY1U1Jid0lyNDN6S1FYb1d0OWJFU2xkRzVETVlhZmw4VzFs?=
 =?utf-8?B?Qm4rbm1TVUtxdi9jRFVHeGRGckgvV252N1dyMHlXZzAvSm9OOXlkQ0xsc05W?=
 =?utf-8?B?VUZsS0xkaGFDRTNpbTJPM3JvdXY3bUVraXB4Z1MvNXQ1NnNIME93Y3U0T3Vl?=
 =?utf-8?B?Q203MWtxMWZucGo4b0lsaWpyaUJDZmhxTUs3a09sWHowNnhvUmZDZ3g4U3Fp?=
 =?utf-8?B?b1lvajhacjJFOTBNbkZvdjJEYlhFdkluM2dId0FFd2gxVzNmMnpjVDkzYjVS?=
 =?utf-8?B?N1ZkS1ZlT1BROWdGS0V6cUlLKzJpV1ArWDdsZ0JqcnpDQ3JwZXRYeEJEWnMw?=
 =?utf-8?B?b0VCMjM1NlM4QlJpQlVKcFMyZjJkM3JCZllSQlk4cC96dWtjSXI3bmlBNFBU?=
 =?utf-8?B?MlhkT01LcjNIU1JGSWJJVGNQNytKVTN3S1N3Z3NjRmpvcTlIbjhjZXk3QzNH?=
 =?utf-8?B?aFBhWkpJYm9oTGVuN3BXaThodFFBZmFGSVNLNGFCcTB6WHNuZk9kMjc5OGoz?=
 =?utf-8?B?VFc0S2l4eWsrT3VWaVYyK0NhQjEwRFFDSldkdldaRkZyMnVDS3loUUszcjU2?=
 =?utf-8?B?VDdIMEQveitYUElzZ2o3U0tIa3BPb3NldlRMdDY0WS8reUFPdS9qM2l3YkNu?=
 =?utf-8?B?MHFYVTVTNUJCRkNvdGcyS28wdDcxRStiS1BhRDhNa090ZGtST1U4RFM2RWF6?=
 =?utf-8?B?RHd3bDhWSkEzRVl2YmNHbU5XaTBYSGNvWi9mUEowUVNvVDVhclpwTjJESDZ0?=
 =?utf-8?B?ZWdjVE8zUHpGK2RJQ0cxYXg2bmwraDgvVlZXa0E2QzBvemdFakNnVDJ2MG4w?=
 =?utf-8?B?anJkMmNyTjA1bHVpU0J1ZlBUVDA0cjZITjRTSmhOeVlNTUFPWEYrZWIyQmMw?=
 =?utf-8?Q?4zTE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:37:10.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d71b6f-6c89-4e48-9337-08de3a120b08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4967
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


On 12/10/2025 7:38 PM, Markus Schneider-Pargmann (TI.com) wrote:
> Add dedicated helper functions to check CANUART wake registers and magic
> word. This helps determining if we are in a wakeup or if CAN IO
> isolation has to be removed.
>
> Also add a helper to detect a low power mode exit/resume.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c                | 19 +++++++++++++++++++
>   arch/arm/mach-k3/common.h                |  1 +
>   arch/arm/mach-k3/include/mach/hardware.h |  6 ++++++
>   3 files changed, 26 insertions(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 760aaad03411441e3cc169f2501134cf69dcbee6..a80cf87ce65a44c386539ade17c0f435e09de841 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -115,6 +115,25 @@ void mmr_unlock(uintptr_t base, u32 partition)
>   	writel(CTRLMMR_LOCK_KICK1_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK1);
>   }
>   
> +static bool wkup_ctrl_canuart_wakeup_active(void)
> +{
> +	return !!(readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
> +		WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
> +}
> +
> +static bool wkup_ctrl_canuart_magic_word_set(void)
> +{
> +	return readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT) ==
> +		WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
> +}
> +
> +bool wkup_ctrl_is_lpm_exit(void)
> +{
> +	return IS_ENABLED(CONFIG_K3_IODDR) &&
> +		wkup_ctrl_canuart_wakeup_active() &&
> +		wkup_ctrl_canuart_magic_word_set();
> +}

May not be valid for all SOC,  either move into some am62xx_base.c or 
make it  __weak, so that other SOCs can over-ride this if needed.


> +
>   bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
>   {
> [..] 	
