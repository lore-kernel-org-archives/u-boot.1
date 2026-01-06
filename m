Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7684CEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 17:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE3783C14;
	Tue,  6 Jan 2026 18:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jVfbyCJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140C983C08; Tue,  6 Jan 2026 18:23:22 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1A6838E6
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 18:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owHHxFnr6kP/RmKjmW++56NKO9TmyZxQ9IcfOeiS/kkaGXfa/Vsl7zjBzA6PLJyvcVd1C7AkdY/VLxi7AG5rCHGg5/HfDopsjOp0PN2lVSihjD4qMWVIgG6WSV8h1w5EK+mRsQkTTtbvw6CWVn8U/fSdcK9awnUV+VH3awt92Llxo0zJuMoAZi6rdkXWr94xCMht3mzNWF9Uj5F2tZP1x9+uRyS5rQcl+9eOPPMjszof5hfrDnirdsX/JCWtnpoYNLCjDJm1jEmJLUPuGi0hgyacqUH7kOARdAiaxT27a8mXFR5QTAivkXgK4a/4k3QiGm8EXe5iXY1hKW+FK9/o7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQZu+KoIsh7MRvLXBbKi3lca7fJ2y3lI6uiiF7B/akI=;
 b=qugL03p3+FkKz3ZZ3f1xyUZX7+lO+rtiCS8ijci6anjrKjCEb+xZFH/ZA4qKq+4cJMwdpDS6FSUmpNqf3Nltgm3LEpPKaQbLVyfXwwlgAeWq20wfbhsCtXofAPDY1KR/pSdRjvkbctaJLKCL2zYzoDIBXBZgb8qAB9OdG28kClNIFMpuABbbi7HwAU5IgrgRrO9BD+xGnpBkEArDYBzQswMJDoudRDmdspQDLKyFVcj8/59Uj+3ipnbVzagCfJ0mXG1aSS/hl07nKFhJWj846A/5OVmAHcAQtRc7QnTGTw9aCpbUxjMw1l8c7uwcm/VSosbQZJ/tIlNfRICjGCwIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQZu+KoIsh7MRvLXBbKi3lca7fJ2y3lI6uiiF7B/akI=;
 b=jVfbyCJO3gfkPoXnWF/4PzUBuNfc0i7P+82g+1IhY1mY7iBQoEGOFrlQN1hLNR/3MCOlrtATKb63qYDlva3nGmvfKdT5yLQcFdXrYi6wKXFv3AiOkN4ysLM5l8Vr8zHJl4VL1+2nAJNfKlpVcPCWdELVJJ36Nr/RaSFMTMH5vhk=
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by IA3PR10MB7996.namprd10.prod.outlook.com (2603:10b6:208:506::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 17:23:14 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::99) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 17:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 17:23:12 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 11:23:04 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 11:23:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 11:23:02 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 606HN0LZ3356348;
 Tue, 6 Jan 2026 11:23:00 -0600
Message-ID: <a5fbd8b4-03a0-49c4-b071-742364880081@ti.com>
Date: Tue, 6 Jan 2026 11:23:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 "Udit Kumar" <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "E Shattow" <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
 <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|IA3PR10MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fb22f9-d78b-492f-8a5d-08de4d484561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjhHSi9BQ3JKV0tZR0xKaUdYN1o4K2duc0FGcFA3dWdGL05HajlmVTVoMUNG?=
 =?utf-8?B?ZGZ0TGV4OWtsU3hiTDZYVDl6Skhqa3ptWlhleTRuclRXQTA1SldvMjcwZ09i?=
 =?utf-8?B?T1pTblZrOUZIazJ0ditSVWNCQ0xvM2VDWkxxTnhid0N1b1NiOTdsa0REcTBD?=
 =?utf-8?B?SDU0UHdsOFIwdWNieUQxbU41eEFaRjkrS2FEUkdJU1U4ZkN3SXlKb2Jnck1Q?=
 =?utf-8?B?dzMydGo3WVBPck80Z1VzR1VrSGhJYWF2clczRnZaL1o3NDZBV3ArLzdDZFlB?=
 =?utf-8?B?S205dXdBSit0THdCcXNRNlJNY1V1TmRrWml4ajJhdU12alBTN2dUU2U4U28y?=
 =?utf-8?B?ZTZ2V0tPNVF2ZXJNbWEzUCttK3JhOENkeU95Z21Wa01KSnJYK1p4UnEyNWNG?=
 =?utf-8?B?UjdkR2k2Rm1NK09rS1paNVVNV2pFTXhNaCtid0k2UmVmTHRNYkFPaHVOa284?=
 =?utf-8?B?U3dwaUJFYWRHMndXUi9sSUVzaWh2V0lJVHBtcjJHaVlTQmVMbTlIZzQydXo0?=
 =?utf-8?B?dG1aUGVWSURUTzM1ZkpCMHA2cUl1SXBGbWpUY2M3VndGZ2RPaFE2Z3oxZGVu?=
 =?utf-8?B?K1JHZ1dCQUxIUEVRUUYzcVlvVkZscmRVTEpGUzZScEd1VmJIWkVRZUxNZE1I?=
 =?utf-8?B?d0lkRTdOWVQyNC9qWjl6Y0tpNDNKdEtsUEgvZFNXeHd4ZlhBbnVBRjNnZTRp?=
 =?utf-8?B?cU1WSXMya29ZTDl3eFpGZmE0VENvNmpwd2pYVXlJZFBMUnZjTndXd1hKUDlY?=
 =?utf-8?B?RVEyRlZzczR3VnhiOGg1RjhObTJhQks1Um9EOVRkYXMycnZJWFRJZHp1cEhr?=
 =?utf-8?B?QktIZzBQR1hSZGI3bnN2b1ZEVEhZQ0VEcFlPY25ROUQwcVp5MDJTdjZBWHA5?=
 =?utf-8?B?ZkZTaTFrb01ncGQ2am1mQU8rZXBMMU8rSDA0SExaV2MyZ09xbkJhYW1DcVpG?=
 =?utf-8?B?bjJSU2ZSc3lVSG9uUzlHVnpJalc1MHY1NEEyOEQyRUlZNng4TmNvTS82NXVo?=
 =?utf-8?B?T1orcWlCRUNRUjRPcW9pRGR6RGhXRE1iTmQyOW4vYlU1SGtCTi9mcUhVYmI0?=
 =?utf-8?B?V1FlZ0R1aXBMc050ejg4ZWYxV1YzWmU3K2hmNG0rSTNzeCtpQ3VrajNZbERW?=
 =?utf-8?B?ZTRGQlJKY3BrMmNFcWRYb0hDMjl2R2RhSk1WVGlpbzV1ampjd3lRa25IekdM?=
 =?utf-8?B?bkVqRlZZM2ZYdTJEUE0xMFJ1ampDN3EyWXhFbEFxZ3cvY2YrMmcyTGorK1Zv?=
 =?utf-8?B?OXQ3eEgxbU9kL21rYkQvSHVzNVR2aDh5aFZ6aFpaMlBDSkliUk1GYnJ4akN5?=
 =?utf-8?B?VkpzMmk5NnEzRkRyY3JtYUE5eFhiTXNkTDQ1SWlJaHVXaUNzRmpTZE1lTWtu?=
 =?utf-8?B?S04wUkNCZEU2ZWp0ZDZwbDlrc0hSRUhHcXBMczZES3lBOGJPcUZUR1hQRlFy?=
 =?utf-8?B?N2FDWlFnWWdxNlhHcFNLNVBzdmkyRUtsSVBKTjlCbCszdFZtRkFtaHk1Y2pO?=
 =?utf-8?B?Tjk0SEtjU1l2dEcxRkJPd2h1UmJmbUFGOTlsU2VCVUNEaytURzhjblovM0o2?=
 =?utf-8?B?RHpnT01Yc1FzSVdNNE1tODE3cGtlNE9PWFRjK0tnYVpyVFpuQTVlOCt5d0s1?=
 =?utf-8?B?S1JBaWJMVXpXSnlUQkU5WWl4NDJwMGZ4NmhXT0V5VjEveDRPWTBHbHlyWkZL?=
 =?utf-8?B?UXRQOThrV2J6bGI2clJqTFEvMlJmZ2J2cXZvQStaNlRiTE9NZXRndFVvcG0z?=
 =?utf-8?B?UU1lcVpVNW81U3JWcFdYZlVYYmhPQXFhQXgwOENGTmtrVy9mcWJwdGZGN1dL?=
 =?utf-8?B?QkowOWNSZWJkTmlFWU4vM2dSNk5DMDNVM21ScWZqemxtTFZMZDg4RGlKOWNn?=
 =?utf-8?B?cWE1cTdqa2VJeUpFT3BaL3k4enVkb05PazJMbE9OanR2SThwd25EaGM1ZnZv?=
 =?utf-8?B?QWhyc244ckZPS3RzZEdNMC80N1NvMUpxQ1Zqb3BsNGhFOFBaUTZFWGRkbDFT?=
 =?utf-8?B?akh0UUxRWjFqZ3lQeE4yQXg0ZDNPbk5tNWxqOTRYU0pvMElsR1h5UFVJWWcx?=
 =?utf-8?B?MVV4YVF2YTlpYUFsa2o2OE9HQ0hEZ0ZrMlNYVklWb3VQb3NuNVRDc3BEME9F?=
 =?utf-8?Q?GCwM=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 17:23:12.7621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fb22f9-d78b-492f-8a5d-08de4d484561
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7996
X-Mailman-Approved-At: Tue, 06 Jan 2026 18:54:15 +0100
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

On 1/5/26 10:38 AM, Markus Schneider-Pargmann (TI.com) wrote:
> Add a small helper that uses memory regions referenced by the R5
> devicetree node to calculate the LPM meta data address.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/am62xx-lpm-common.c | 45 ++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
>   2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
> index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e 100644
> --- a/arch/arm/mach-k3/am62xx-lpm-common.c
> +++ b/arch/arm/mach-k3/am62xx-lpm-common.c
> @@ -9,6 +9,8 @@
>   #include <config.h>
>   #include <asm/arch/hardware.h>
>   #include <asm/io.h>
> +#include <dm/of_access.h>
> +#include <dm/ofnode.h>
>   #include <linux/soc/ti/ti_sci_protocol.h>
>   #include <vsprintf.h>
>   #include <wait_bit.h>
> @@ -48,6 +50,8 @@
>   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
>   #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
>   
> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
> +

Could this offset into the R5's second reserved memory area change based
on the firmware used? Actually this whole thing feels hacky. Why not
just add the location to DT explicitly instead of trying to derive it.

Actually, don't we pick this address as part of the TISCI_MSG_PREPARE_SLEEP?
Or does DM do it now, either way there must be some better way to coordinate
between DM and R5 SPL than hardcoded offsets..

Andrew

>   #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
>   
>   static int wkup_ctrl_remove_can_io_isolation(void)
> @@ -126,6 +130,43 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
>   }
>   
>   #if IS_ENABLED(CONFIG_K3_IODDR)
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
> +{
> +	struct ofnode_phandle_args memregion_phandle;
> +	ofnode memregion;
> +	ofnode wkup_bus;
> +	int ret;
> +
> +	wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
> +	if (!ofnode_valid(wkup_bus)) {
> +		printf("Failed to find wkup bus\n");
> +		return -EINVAL;
> +	}
> +
> +	memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
> +	if (!ofnode_valid(memregion)) {
> +		printf("Failed to find r5f devicetree node ti,am62-r5f\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
> +					     0, 1, &memregion_phandle);
> +	if (ret) {
> +		printf("Failed to parse phandle for second memory region\n");
> +		return ret;
> +	}
> +
> +	ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, meta_data_addr);
> +	if (ret) {
> +		printf("Failed to read memory region offset\n");
> +		return ret;
> +	}
> +
> +	*meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
> +
> +	return 0;
> +}
> +
>   static int lpm_restore_context(u64 ctx_addr)
>   {
>   	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> @@ -167,6 +208,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
>   	image_entry();
>   }
>   #else
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
> +{
> +	return -EINVAL;
> +}
>   
>   void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
>   {
> diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
> index d5793759da4a05d355f5d88fbd8e103ebc46f9cc..741e3ccbcbd082da9d11c61624df8a4f456fd724 100644
> --- a/arch/arm/mach-k3/am62xx-lpm-common.h
> +++ b/arch/arm/mach-k3/am62xx-lpm-common.h
> @@ -13,6 +13,7 @@
>   
>   bool wkup_ctrl_is_lpm_exit(void);
>   int wkup_ctrl_remove_can_io_isolation_if_set(void);
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
>   void lpm_resume_from_ddr(u64 meta_data_addr);
>   
>   #endif  /* _AM62XX_LPM_COMMON_H_ */
> 

