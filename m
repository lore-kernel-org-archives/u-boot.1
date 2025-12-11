Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6155D41C39
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4827E83CEA;
	Thu, 11 Dec 2025 14:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HWn3YwZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E3983E43; Thu, 11 Dec 2025 11:09:38 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A79083D8A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebin.francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHlkXbMCZS1n3drxGgTW4s50KV9LEMtQLPUBpW+IroDaQ+COUoK2/47m1FqRPuiqXQ6F7GcevT4NQhP9VCxQP8SJAh7X3wBNbW0pJ8dnvyv4N5JdSxpbyX1DbPGraOcnNQ2hzzacCz0QwAoe82Rk5RT1WmfWKDtyGjtDC4RXLn3ghG2R/QOizG38DkE/sl1J/cL9x7QkGz0mdeYsXZct++/IwthjaRf4jfGFXAXWA9gf+dA703I8T1Ke8e7ToHa8ncg+LGds7DvG9jv4Eqnvz12MFUu2p6Yir6OahAO04fBHasV/cY+hn82XU0YVu/ayaMQAoswx7YcaCzYRY+XRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnBINXhBlp2/CZs5td4XpvrJ/7iyyx1arOZp4A8Y4gM=;
 b=T8INTteHtPeSZhfeZZnt91yXhN/geaye99xMh6VkhjMBGY11CUzfH/RJs0TGUoGeLTl2nCb4v0w2zm9La9NXsaJrqpf7a4MayMiEZ82y4NBGzG8kazN5gG/AzZESl4/iunXww9hfZDoMm/yoOVkLf/A7yTcT3UgiucG4Mr4BHSrmno4kUC72OOAKfT9LGW167HdrjRLittMLRogyIHggm5gVNlXNuJ/0DGKMwMnTnNVt9GowrxxtajZVYU7Y1rfu8aDw/oirUJzNYtymUrLf7uEgjlPxR7lTJ4XHcknsuoM66gh6UThEK5FjV5MPFIifWSxvFFTDtZOWkP5+WH5RcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnBINXhBlp2/CZs5td4XpvrJ/7iyyx1arOZp4A8Y4gM=;
 b=HWn3YwZKbKn3a4QJ9vkmCquMCtqtW9fgJiQZqt8oXaUaEw8/746up8SR/uQ3mzeTiB0Lb1TBpawuwfwj4BWTj8KmTfNK8SZKyrQfHtL+urpevJz280/zJPIi1LFm4kvHtobGAOu8jVM/ishTFelyvuWl+n1E2GeLgkbFZr0jpoA=
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 10:09:23 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::f8) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Thu,
 11 Dec 2025 10:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Thu, 11 Dec 2025 10:09:21 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 04:09:17 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 04:09:17 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 04:09:17 -0600
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BBA9E8U288766;
 Thu, 11 Dec 2025 04:09:15 -0600
Message-ID: <1815d22d-e5a9-4388-af66-ec7847041930@ti.com>
Date: Thu, 11 Dec 2025 15:39:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: ti: k3-ddrss: Add workaround sequence for errata
 i2487
To: Akashdeep Kaur <a-kaur@ti.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <d-gole@ti.com>,
 <k-willis@ti.com>
References: <20251211093232.3706673-1-a-kaur@ti.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20251211093232.3706673-1-a-kaur@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 42500f72-62b6-4fe7-af0f-08de389d5ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmZGZXhOUkZhOVlISzZaRWhiWjdPZVZzaTZLSkhmZ05tY0JOZ3d4TU5meDdW?=
 =?utf-8?B?UGFNdWpGa3JtL1RJTHFYTWFsWklGT1F0TEJiU2JMd04zV2VHbVpNOWtEZDRm?=
 =?utf-8?B?MzhLQUkzU2RYM3d1eHF2K1VHd2JzWE5ZanZHQjFBMEpzR0xRaTREcTFyb2Rk?=
 =?utf-8?B?L0lYQ1MxVFRIQTB2MVFTY2FiT2ZucDA5bXlRT054MDZFZ1p3KzY0VU1iZGZp?=
 =?utf-8?B?U2FtbE5mYWlyeVNYQldqNnhLU2d0dmI1RlpRV2dRclB1S1p2UEp2MFVheWJL?=
 =?utf-8?B?OUovUVFPSXRzV3RPcjJiL0FGcjRxSUxNWGxjQWEyUlJiOFJhZy9wdkgrTi9w?=
 =?utf-8?B?WHM5Q1ZTT200RjZIZnZ5M1VqQTNEbW0wZXo3M01oMGZqVmlOcUY3K2ZQQWxI?=
 =?utf-8?B?a2FTK0RWZUFmaVRmRnZvaGowdjNWRG9teE12S2xxVXNOTEhkSVdrdHFDWEhi?=
 =?utf-8?B?SDQzODFQUmFsdXU0UDd6UzBsQjgxV0RMYlRoKzRVVnpWMnNKUGNYTlZoc2ZY?=
 =?utf-8?B?MStRUVdYU0hiVndFWk9VSEZ5Z3ZIMWM3MGk1UXErRklxdXhqcHpBeTJmVjY0?=
 =?utf-8?B?WWdscGNscmEweGpPdHFDQlRpclFWMHRXS0JiWDNIUURCeWMxUmcyNURYLzQw?=
 =?utf-8?B?THdhQWVOVU5HSmFyVW5HamVMNnNCQ2hVM0NPMk45T3pXYTRQemx2K3NwZUhi?=
 =?utf-8?B?VUJNMmtaTHYzMU9lc0RsemMyS3lWN1VpTjhEaUlWOE5RTHlQZnJ5VFpVTkZi?=
 =?utf-8?B?dEJlU2JPSUl5SmZDMW5CVEg0NnlKZnVZN1hNdElTTWk0YVF5blZwTHFvSkhP?=
 =?utf-8?B?WVFHc1E1NmY5c2RSMDNmSXRNR2IxRXNDK1NjVVovOGZKeXBFYm94K0tQVHR0?=
 =?utf-8?B?WEhrMnFsVkRJMG11T2xTMzRLSFB3N1lGQTdPbXVBUXRhVDdCU0JaUG10akEx?=
 =?utf-8?B?UFNVYVEyQ1Y1QUJBMEJSL3N2NDkvNTZBNk5yZXZrM05MZ2ZUbEFlZWlVT3JV?=
 =?utf-8?B?MXBRQ3pVa1BDV1ZYb3liTnBBYWZ2QTZaZSsvWjRxMmJIMzFJeExjZzREbEFw?=
 =?utf-8?B?dnFBUm42aytHWHVRSFdTQ01yTFB1T05HUnFQOUpwU24wWlhVRERzeERIL21K?=
 =?utf-8?B?TmRDVVcxWGt0TlB4K0FUQkZISmhJcEtwMXd2eGJKUGp2Vks4TWh5K0NUOE5s?=
 =?utf-8?B?UExVN0Z6VVJLWTN6alpzZkhKTWRCNVNwMUFmbTJrUEJlU2EyT3A0S2ZDbWlC?=
 =?utf-8?B?L3Nnd2J5S1Jwa08yRXprUWk2TmE3b2lxaFhORDhUK2hOaE9Ib2ZJY250cUk3?=
 =?utf-8?B?U1gyNEN6K3orbitvOFFFT1dMTm8vblRKZnFjbW00SE9TZmlMc3M5c3U4L3V0?=
 =?utf-8?B?MVdCT0psNzF5RU1rQ2VQajAvRGdzVXg3YWV2RWFnS3EzbmpzVmdJcE1BVHk3?=
 =?utf-8?B?dWVDRDVFdzY1aFdHSDB2Qnpzb3FpQnoxZmFUQjJxRlVqR0ZvSVB3cFRieE9n?=
 =?utf-8?B?TDFmck94TWI0cFRHVWQ0ZnE2OXYrb2JwUDhabTNhdlhqYzdkL3RLdlhjTVhs?=
 =?utf-8?B?bzNaWEw3c1BoeFpiM0M2Rjc3ekhsYlF4aHFkeUVkbDE3U3VZRzZmL0dqQnp4?=
 =?utf-8?B?NzZnMFBSL1hmVXZ6Q2g5K09EVnBiZUhPR3I2d3FhOGc4NXdpTGYyQnBmUDlv?=
 =?utf-8?B?WmlNRUxReG94TlBCR05SNzVDcCt6N3RkOVVuQ3BVRjdHLzJHL3M1dUJDSWZO?=
 =?utf-8?B?T1loZHJzeTJ3S0VBOWZKOGhqd1ZzSkMyT3VuK2hoVDhhQzVwazBFYUs1TDkz?=
 =?utf-8?B?U0hpU3VQbjlTWWIyb1V2cWF1S2crUWhFZnRmV1hPVDNhWjFhczRFTkwvZmV3?=
 =?utf-8?B?Y1pjUC9RdUY4S1d6OXYvZnNBTkVxb0c1Sy9HaEZMWUtIY1hYa1BYNFFvS2t0?=
 =?utf-8?B?cHBHUXhTbXhQUjBjRHNmam5ibk9qK0NQYlpGbkRJcUZnTGhXYjBKOWZQUURM?=
 =?utf-8?B?RGlWU1BreG96SGhjVTFzY0h4d0lWRUpIbk95L0UxdTlZclFmQnd0NFVrOWE1?=
 =?utf-8?B?VlE5bmRRTFJaU1JIY0tpNE81NWhXZ3pVa1FYd0o5azd0UnNPRHlvTGd5b0J0?=
 =?utf-8?Q?i+G4e+fHeNgQVQS2cEwcCJg4x?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:09:21.8184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42500f72-62b6-4fe7-af0f-08de389d5ae8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Mailman-Approved-At: Thu, 11 Dec 2025 14:55:42 +0100
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

Hi

On 11/12/25 15:02, Akashdeep Kaur wrote:
> As per errata
> i2487: "the low power modes may inadvertently corrupt DDR contents"
> for AM62AX[0] and AM62PX[1].
> 
> Based on the recommendation, add SW workaround sequence to
> clear data retention latch on every boot and/or abort scenarios to
> make sure that latch is initialized to zero rather than unknown value.
> 
> Executing this sequence during boot helps to successfully resume the SoCs
> from IO+DDR low power mode.
> This sequence is executed in partial I/O resume as well as all the
> other conditions when reset is issued during low power mode entry/exit
> or when the SoC is in idle mode.
> 
> The sequence should be executed for SoCs that support IO+DDR mode, that
> is AM62AX and AM62PX.
> 
> [0]: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
> [1]: https://www.ti.com/lit/er/sprz574b/sprz574b.pdf
> 
> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

Tested all low power modes in AM62A including IO only plus DDR with the 
patch. Everything look good.

Tested-by Sebin Francis <sebin.francis@ti.com>

> ---
> 
> Depends-On: https://lore.kernel.org/all/20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com/
> 
> ---
>   drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 78 +++++++++++++++++++++++++++++
>   drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  1 +
>   drivers/ram/k3-ddrss/k3-ddrss.c     |  3 ++
>   3 files changed, 82 insertions(+)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
> index 2556632df88..523f0cb6219 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
> @@ -19,8 +19,18 @@
>   #define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x43018318
>   #define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
>   
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL			0x43018300
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD	BIT(0)
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW		0x55555554
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK	GENMASK(31, 1)
> +
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE			0x43018310
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW		0xDD555555
> +#define K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK	GENMASK(31, 0)
> +
>   #define K3_DDRSS_LPM_TIMEOUT_MS 5000
>   #define K3_DDRSS_RETENTION_TIMEOUT_MS 5000
> +#define K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS 500
>   
>   #define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
>   #define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
> @@ -149,6 +159,61 @@ void k3_ddrss_deassert_retention(void)
>   				 0);
>   }
>   
> +static void k3_ddrss_clear_retention_latch_and_magic_words(void)
> +{
> +	int ret;
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
> +				 0,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
> +				 0,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK |
> +				   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW |
> +				   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD);
> +
> +	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
> +			      K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
> +			      true, K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS, false);
> +	if (ret)
> +		panic("Timeout during latch clearing sequence %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0,
> +			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
> +			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
> +			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0,
> +			   K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +			   0);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
> +				 0,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
> +			   0);
> +
> +	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
> +			      K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
> +			      false, K3_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS, false);
> +	if (ret)
> +		panic("Timeout during latch clearing sequence %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
> +				 0,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
> +			   0);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
> +				 0,
> +			   K3_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK,
> +			   0);
> +}
> +
>   static bool k3_ddrss_wkup_conf_canuart_wakeup_active(void)
>   {
>   	u32 active;
> @@ -173,3 +238,16 @@ bool k3_ddrss_wkup_conf_boot_is_resume(void)
>   		k3_ddrss_wkup_conf_canuart_wakeup_active() &&
>   		k3_ddrss_wkup_conf_canuart_magic_word_set();
>   }
> +
> +void k3_ddrss_run_retention_latch_clear_sequence(void)
> +{
> +	/*
> +	 * Workaround of errata i12487
> +	 * Errata states that During entry to the Deep Sleep or RTC+IO+DDR
> +	 * low-power modes, SoC may not properly transition the attached
> +	 * DDR into retention mode, which will lead to corruption of the DDR
> +	 * data.
> +	 */
> +	if (IS_ENABLED(CONFIG_K3_IODDR))
> +		k3_ddrss_clear_retention_latch_and_magic_words();
> +}
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
> index cb2c270b7b2..1c2343924fb 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
> +++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
> @@ -7,3 +7,4 @@ void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
>   void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
>   void k3_ddrss_deassert_retention(void);
>   bool k3_ddrss_wkup_conf_boot_is_resume(void);
> +void k3_ddrss_run_retention_latch_clear_sequence(void);
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index cedec616e23..ebe56da72cf 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -886,6 +886,9 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   	if (is_lpm_resume)
>   		dev_info(dev, "Detected IO+DDR resume\n");
> +	else
> +		/* Clear the latch after any reset or partial I/O exit */
> +		k3_ddrss_run_retention_latch_clear_sequence();
>   
>   	ddrss->dev = dev;
>   	ret = k3_ddrss_power_on(ddrss);
