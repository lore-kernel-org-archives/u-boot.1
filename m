Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A052CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DB283DDD;
	Mon, 24 Nov 2025 13:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KgnrPltw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8B483BF4; Mon, 24 Nov 2025 05:03:32 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A37483ABA
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX+X8DA2r3Mq5RCfqNndXL3GSwNZGcYoyE3jJOi9ZSQ2aMzUzoVqK+JUW4r4PMadqlHRUafcdu4NjnhlhqwHmh4ipweGOuM6kbfeCcTcuUPC5uVqwv+DFS0+IUt8QmxgPD/tcLVK5Mjjv+2MkC8DP6ZMiikXXWcOk8gJ4Unf64w9jZ4EHDWcYpQemT4ojeKgzUruUBqaRf8kfnJRJbfGYHskPHm8G1SibQdVBKBUgApIw5135yMdbntKwzY0076X/A8UeDZ3lpfolFQKLUANCrlvBivHDflj0C/QO23AuTCXQrzxnKz2zvMzRM7W7AntExeO4yRGXDMopz4xIIGXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRxMUFzXzvFhnBh221gePDpDzE+maOB2DfbK8M0uLBs=;
 b=WtMKXKsY9fb7F5MSVqDpmuvoTL7vUw8eUaU0WsX7NsHkX201zOJlAxI5lo4V8TZ7Agr4rFbYj38rNtqMWrvmD/v7c22lSy9r0nk76xdVb2oUtsbIkElp1OYQ1QzBQF4U93SImh5Srupd1tm6nJ8wuMyOnKk+qUT5aCQFAIVps/ULgwuFZECevQDtg04uEji/9FmWnaHjpxXKXU3Cf0orLOlMur/bOySq1/Q74QyjoAMtQGabqQqkzQSagUCQHmPSQnGjgZG5OTwG/QX0le/gkSuRrTn2H7E1dfabb7i9hE5y8oF38Pwt1XwocFlmt2z7iyoPB0X7RIMmHDjBh8Bgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRxMUFzXzvFhnBh221gePDpDzE+maOB2DfbK8M0uLBs=;
 b=KgnrPltwj7LcDFx2k2Jv4jm3Fg8ek0GnuNGnW/1dhuqSYCcl1Ii9je93EtPcH+ixYn9bwTM1hnRF9qifTKQmXlgSNtoGSuSxJbL0JfbVeZAAlOEeUIG+SP4C01sjIralLZjAAgmXbwx+jLmnx/sOj3GyXDVASPmol1w9LHjyMYo=
Received: from BYAPR06CA0063.namprd06.prod.outlook.com (2603:10b6:a03:14b::40)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 04:03:25 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::f0) by BYAPR06CA0063.outlook.office365.com
 (2603:10b6:a03:14b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 04:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 04:03:23 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:03:18 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:03:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:03:09 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO42xTR1255745;
 Sun, 23 Nov 2025 22:03:00 -0600
Message-ID: <59f3cbe0-4152-49d7-8514-3456fece2365@ti.com>
Date: Mon, 24 Nov 2025 09:32:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] arm: mach-k3: common: Add CANUART wakeup check
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
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-5-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-5-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b91c951-9768-4e6b-8851-08de2b0e69c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjVjYm4vM1RSOUtMNDRLT1hvczh1U0xEL2ZFQ3FVR0FiQlRjUWs5SzR3WWY2?=
 =?utf-8?B?dnBOZDZqaW1tODNhcHc0amVaQVFtTkd0a2tNQStTSmxqblVUTVpNbW90b01n?=
 =?utf-8?B?M2RmeXV6WHYwdFVvRUVETUh0OG5nZ01wOXhYaHB5UEZPTy9HbnVvYTRoUi9O?=
 =?utf-8?B?QkQwNXc0TWwxQ0tMQXFxSm9STkt0OFNNMWcyTTJXVEc0UERqQWg2K1ZJK3Yw?=
 =?utf-8?B?UXpuMDNGZWJOelNpanNJUURkeTBOV0RjZUYxK0xsRUE1TFdtUWZCZkovd2cx?=
 =?utf-8?B?TGZDM2xYVkc5em0vQVExUXc3Z3Zob0xmSEdpV3pQWUR1WjJFQWZjbUdHZlp2?=
 =?utf-8?B?TE1PakRIdUhxazlUSGtSbHN6U1RxK3dNT1RZckJ3aEJPZlpMT3RaSFRjTzg3?=
 =?utf-8?B?VWF0NTk5NHRQS0NhVlJURDhuRTI5MmpYZ2Q3NEJlL3JwT3prK2NyN2Fjb2tU?=
 =?utf-8?B?NHhEaEh3dGpTaGJFakl1Y2hIVmVMVWUvRnMySW9pUGpySjNTSGdDUDBnM0dZ?=
 =?utf-8?B?ZnAxaUJQY1ZxSGRzbGdncC9mSTc1MXRaRnZlaW9nbEpvWHVCVlhISzVhc0FN?=
 =?utf-8?B?cm9CNmZMdEZhdFRrRUUvZHAxMmZRZ09OS3NvejFVWS9hbWtuVFNiUk9KNHBr?=
 =?utf-8?B?ZExpalZhK00xb2dmYjZGdE9tVE80R2VLdUo1UnpHUWpZUEJOQm9EK0RqNXF6?=
 =?utf-8?B?R2J3akM3M2xRYjh1SENBdlduMzV1aW5qMTBLTmcrM21rUDRMdkxXalBhTE9W?=
 =?utf-8?B?M3lzL2xWb3dlVjNINndqVVBEeGRYRkxacjlUSXZkVjd3NUVVL01rL3F0NE9m?=
 =?utf-8?B?c2hlUUlIL2ttVnNia1hzMG5lMVJlRG5yWlJwTWxLSHY2RWZNVGkyMFZOVStP?=
 =?utf-8?B?NlhvcDVoOWprVG9lcjAyRndUc21NRXR2UC9nY1JZYmJGR1FybEJUaHlMV045?=
 =?utf-8?B?VGo0aUlRVXh0TDN3S2ZkNUw5MTFuWGR6UnEzalZiUW14QUhaSWRBNzBRRGNJ?=
 =?utf-8?B?T3Y0b2l0bHVqcUdzNXJuYkJJVVoxdmdqWC9NWkwrNjRPeldERnB3YnEvOFVs?=
 =?utf-8?B?clJiRldlS2RHZDNQN2NuYzRKLzdtUi8xWWp4aVJvTDArbGpyK29LWFFpc2Zn?=
 =?utf-8?B?bEQ4cW9QNlNOMk5tbjMrNXlHNFh5bHhDenJvciszbitvWmxPZi9qRWtSa2Fu?=
 =?utf-8?B?d1hVNVpZMnVxTDJNbFNEOTZIL2kzVlRYaGhUK3BqK1VEYmQwdmJmOGhja1dw?=
 =?utf-8?B?RHZtQnMwN3dkUERwRitvY0RHMy95cXVicWlxS3hvMDdVUkFvYUVTUENCRlhs?=
 =?utf-8?B?Q2VjQjlQWDB3QTlhWDVpWWRVYVR1aEVpVUVvN1hIOWROWnlUUDI3N1dqa0pn?=
 =?utf-8?B?cVVReStNVU44dkZBenZTV29nN3pGM1lNY2pPNVZzZ0xKZ3U2aVBjNUM3dVRo?=
 =?utf-8?B?THJtbHhSK0ppNlJoenB4TEE2M1VQOVFmb0dtendZSG9DMVZYY1dOQlpDZitZ?=
 =?utf-8?B?MDU2WGJNeW1MTkR4cWtZb1NrcWliMmd6SXc1dEkyQmx1NVh5U3NHSWRDZVVz?=
 =?utf-8?B?Y3FsV0xOelBwenVMN3BUZlFhU1ppb3NhZXZQT0hJUmRRSzlYZ2xxVUM4azg2?=
 =?utf-8?B?SU9QU0RERVB6N3pDM2V5dEFQbXNLRzRkZDB3N1ptRE1FTzl2K1R2Unptd3Bs?=
 =?utf-8?B?NGlic04vejVldGdiMTdPWjNkTHZWSTl5VDQzSHM1cWwxMjhHekF1NnpOajFv?=
 =?utf-8?B?UmtuMWVQbTV0Sll5Um9YQWNCbDBPd2h2Z3BNeEU2RnlPNzcyMWdZWERIOEhB?=
 =?utf-8?B?cEhHcnZRSkpSZUsxeWJ2YlFmOU1OU0NEMjNZY21DTXJBRk9LTlhqeENLUHVT?=
 =?utf-8?B?aWZpWndhcnFYc0JUNVUzaWZnUjJsaC9lK0s5NXNlcTgxSFZtbTBNWEJqY3dW?=
 =?utf-8?B?OW94RkJSaUlCd05oa09leWxjeGV3MkVIZllHNWNSOXYxenhUUTlWMDFlK1Rp?=
 =?utf-8?B?UUh0T0dGUlBVY1VhZGp5a0x4cUJ6UTFLbDJMcmhQTU5mVm1xTDlaVEpTSnYr?=
 =?utf-8?B?NW55WHNBanczK1FtRmZEd1JtVzkwditRZjZkT0RqUzJqWmp0RUIzT1BPcnRC?=
 =?utf-8?Q?yvbw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 04:03:23.6921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b91c951-9768-4e6b-8851-08de2b0e69c9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233
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
> Add dedicated helper functions to check CANUART wake registers and magic
> word. This helps determining if we are in a wakeup or if CAN IO
> isolation has to be removed.
>
> Also add a helper to detect a low power mode exit/resume.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c                | 22 ++++++++++++++++++++--
>   arch/arm/mach-k3/common.h                |  1 +
>   arch/arm/mach-k3/include/mach/hardware.h |  3 +++
>   3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 3cc4e7cba0d1e834280fcce3d1140ca32247d807..7780c7740d5ea2a5dcbb442210ce46e25c5bb61c 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -165,13 +165,31 @@ static void wkup_ctrl_remove_can_io_isolation(void)
>   	writel(0, WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_PMCTRL_IO_GLB);
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
>   void wkup_ctrl_remove_can_io_isolation_if_set(void)
>   {
> -	if (readl(WKUP_CTRL_MMR0_BASE + WKUP_CTRL_MMR_CANUART_WAKE_STAT1) &
> -	    WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE)
> +	if (wkup_ctrl_canuart_wakeup_active() && !wkup_ctrl_canuart_magic_word_set())
>   		wkup_ctrl_remove_can_io_isolation();

can this be merged with patch 1/13


>   }
>   
> +bool wkup_ctrl_is_lpm_exit(void)
> +{
> +	return IS_ENABLED(CONFIG_K3_IODDR) &&
> +		wkup_ctrl_canuart_wakeup_active() &&
> +		wkup_ctrl_canuart_magic_word_set();
> +}
> +
>   bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data)
>   {
>   	if (strncmp(data->header, K3_ROM_BOOT_HEADER_MAGIC, 7))
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 49417679e2ec7210d5c95540f476a5d8ee548617..b7dd52fd1792cb6e3eab5c9f3863f983a8ac08df 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -52,6 +52,7 @@ void do_board_detect(void);
>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   void wkup_ctrl_remove_can_io_isolation_if_set(void);
> +bool wkup_ctrl_is_lpm_exit(void);
>   
>   #if (IS_ENABLED(CONFIG_K3_QOS))
>   void setup_qos(void);
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index d7c759420524faf48ea26c66607c6a899d1321b3..e4e7dd61c0689db11083b81f2e74ba8bea74577e 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -128,6 +128,9 @@ K3_SOC_ID(j722s, J722S)
>   #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1			0x1830c
>   #define WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE	BIT(0)
>   
> +#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
> +#define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
> +
>   #define WKUP_CTRL_MMR_PMCTRL_IO_0				0x18084
>   #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOCLK_OVRD_0			BIT(0)
>   #define WKUP_CTRL_MMR_PMCTRL_IO_0_ISOOVR_EXTEND_0		BIT(4)
>
