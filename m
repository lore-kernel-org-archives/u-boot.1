Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57331CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 12:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C8C83DE9;
	Mon, 24 Nov 2025 13:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gNwHkbd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEE083BF4; Mon, 24 Nov 2025 05:06:47 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E751683B72
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 05:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sREaaNQXW/fNBk6C1Jpj4WtubOsVfEZiq68w/d1GAgbiW8vlitk/3+3HaIMObaE24IKo7A/ZuA4Mpso22VpU6LoNoIsgnjowsGBzE2P+jlA2/QHr6GoDWxnXuwoXpqB9YwXWum9UiePW3nYZzSyloGqTyQWRYF4PDl6bxQ2DE/xEUxSztnesCegSA4W83TzLiQtWBQqEcM5cYasGAsXQdlBFtxlE9ejp1CkJh3S9TsnHBNYbF0sl5aC5e9ziTGGWdm1ZFrAiPIWiKHqiofnGmcnJ2J/SvWKqqPck7E1p/iipq2I8IWsXmbUj65p6HBORK/EepvVAmxvrfzz6IWzbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgToIQBjNg3ptheBJDpwB184XwHxoFXtKODIJF8s9Uo=;
 b=FMt8OR6y/LfnaSJq2HZsqptmywiFSNJUf8rRjDkOC1eg5+CiFQvxxiugi/dIHnGzSKTp7Kedn1iVS9h7n03hq6oUIMl4HVtHJbdSeu1y2EHsTkgxPGSFIEEL7ook+SvwHVb9ejjTULGCUI0D7jqm+DP3muxraTSP2hCkvasNyRBlpFc+cILM6PS+AC5CSLTM1xej0/0mYZwx2bGigQbIsmfvH/ftf+5X9bKl0NOYUS3lNF0wCz/aTJey3MAwPHAdFdcvZvW2uJsmozCOjuWJnEF42Yt5KXXQYNKfQUl8z1MVaC7OxCR1w4GNRTvubc/lx4MAfmv1Br0Q2lPDSaZlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgToIQBjNg3ptheBJDpwB184XwHxoFXtKODIJF8s9Uo=;
 b=gNwHkbd3kAfk2BJtFmZCBhBROnhsG3bLieH6Ctbb8t45WWHQ6ahv68H/iVJBqunNKU0V8erTBcIVbtUeqtGSVzk/kettpsjtAtc1RYtUuvm7y8f9cvimJXnqsxxMb8Qmjy9cSvybXrCQeYkAdbTgOYX/AgolY7KKgijWq5ulcZA=
Received: from BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21)
 by CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 04:06:42 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::8c) by BY5PR13CA0008.outlook.office365.com
 (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.9 via Frontend Transport; Mon,
 24 Nov 2025 04:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 04:06:41 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:06:40 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 23 Nov
 2025 22:06:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 23 Nov 2025 22:06:38 -0600
Received: from [172.24.235.38] (lt5cd2489kgj.dhcp.ti.com [172.24.235.38])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AO46Sph1260911;
 Sun, 23 Nov 2025 22:06:29 -0600
Message-ID: <b3e0d56c-a02f-408c-b6e8-966956b548c1@ti.com>
Date: Mon, 24 Nov 2025 09:36:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
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
 <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: a59b17e2-45e3-4d5e-5fa9-08de2b0edfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1NtRGUyTUYwbm5lZVRYcWE5Qkw2dUpLYkRGTmtzTkJjTnI1ZUI3TW5PVXFY?=
 =?utf-8?B?eXJpZUZHS0RqMms5US9rWVA3amltM1FJdWphTUtFaVFPM05oTEYyV3NGWkJj?=
 =?utf-8?B?N3JyenA5aDgyOHpMaUhNcmFSdDNqM2UzOVB2M2YwYWVibjMxdzhRdTZQVlBW?=
 =?utf-8?B?WENibTlDMFVXaDU2bEpWUWx4MGNxYzl3NkZLbjFtMzh5eDVhQy9WK0lVQnRj?=
 =?utf-8?B?S1hySjFTUDlya2NaQ0RzYlg0OWlyWWVDSS9oTk45Nmx6UVBGeW5wZ3BQcVBa?=
 =?utf-8?B?NCtmblFVa09FL3hYWlZVS3l3WnFmTENEN3NTUUZYREVJeVZ3NzhWOC9tdjJi?=
 =?utf-8?B?QjhCSDI4ZkI4UUhZNzM4WCtiZWsxNFpLRnU4MldYL3VqNng5YVVxemNxMUxq?=
 =?utf-8?B?ME1WZm5KbkNzRnA2bSsydkFUTEg2L3VqZjExa2lqeDRZcDVrU2x4WWV0emtR?=
 =?utf-8?B?aEoxRUUwR1hBNXRiV2h2M1NJaThWck52eEt2R0pydktaa0xTdnVRcUZBY2RU?=
 =?utf-8?B?b0NLVnVXQlVHeEwzY1l2em55eHdMVzV5ZzFiYWM4M2NBTDhrQ0JINU9QSzZs?=
 =?utf-8?B?WHNzUU04bzIrejM3Z2ZIdUxCanhGWXdrNGFVanZ4a3QwOWhtNTZnQ2V3aGpa?=
 =?utf-8?B?TnVmS3FXSHFTdXVkSEw3Z3RQYkswcjZMQksvR0dna2I5U1NUYmZud2JNVGpV?=
 =?utf-8?B?ZHBONW01VS8vYk1maENlaWcxUnVwVkRIblhvZkt6VThSVGNTb3lKZ2RXdWk5?=
 =?utf-8?B?OFRhUHRFSkZHeVBrUDl4MkFRRWdiMTZCREZjQ28vY2hzU3duRG9wTFJ0RWMy?=
 =?utf-8?B?QUlSNHFsZ2xLREFaY2thczRYbUNVaFlNVWlxamluT1QrVS9PdE9zWmgvMktU?=
 =?utf-8?B?ZHU4dktTUHNtaDdGRDhqazA5NkNVTXVydDR5Zjdxb29zcFJyMFM5WTNZd2Jz?=
 =?utf-8?B?WjI1V3NNT0hvWWZSNVhDR08yREtFQ3IwZFJOdlNLQm1tWHpXQmJNVnJhQzR1?=
 =?utf-8?B?K2xqMEJ5a2pFd216OHV3SXVPYlVpN0NET1Q0WU82WFNlckc4U3VxL2FFbmNL?=
 =?utf-8?B?Smd3ZnpoSnJSeWp6enhlZUhDTVR6bWdCOXdTbkJ1OE9ENy9vMkFyRUtuTDU0?=
 =?utf-8?B?KzFDZ1l3UFFyMW52Z2VBU1BBWWNzRTNjSnJOY20xNjAxV25vbHNSdkZ2aFZH?=
 =?utf-8?B?QytNaWhYa291U21iZG9XenU5Zk5xNTV6MkpEN1dBZ2FMMnFHcUtOaEp5Zmc1?=
 =?utf-8?B?L3RxT0RYQjBicFRnRnJWZFhoQ2dxTnZsZ0FOQ1RoTkZkajB0YlpUTllMRlVk?=
 =?utf-8?B?NzY5OHJCSVhDMXYrTGxoS1dSbHdoZTdiemZFL1dTMkpNUXpHbWt0SmVBZU90?=
 =?utf-8?B?MnhjRGY2ZGJHRnVlL2J6QVB3TENiRmY4ZmJ0Ym5QWm84ZlBiakJ3L1Awb0NZ?=
 =?utf-8?B?U1YwUlJCK0kwWm5oZU1vZkVES2kzSUF3RTBPYnZXUVM5MEtoeWZRRnNpajI1?=
 =?utf-8?B?Y2tyRWdtbDZ4d01MUitaNGlHWDByZCtWeUlyQ2hLVWI4a1VGYklOdU5YQzJx?=
 =?utf-8?B?UXVvUDdOd2RBSFdXaXB6OFJwdFUvamxPVTRrMzdMaG1ESHVUY0FPL2F1NHpm?=
 =?utf-8?B?NjNLNkRROWdEWFhqNi9ZVEJnRFloTjZIelVhZ0lWZ2g1V0QxTUJoekFGTmYv?=
 =?utf-8?B?MmQ3V1ZJeFM1czV3a1N4U2pwU1p3YXVCVmIrVnJiMUY3OUI4b2lhYkNVZWVp?=
 =?utf-8?B?bldrQlZjYUg4YWNqV25WVDNScE9tVjZMeXdkL0QwVEovWDJ6cnZDVkp4R2xQ?=
 =?utf-8?B?L0ZIaTR3QVhOZXhBNXhEMGtSSXJGUUtOMm1vaEJtOW9GaWYvVHFhNC84aTdi?=
 =?utf-8?B?VTRIN0RGby9PcEtsMDVyMWhrQjJHYUNlOE56TUVIVzYwajhDeUZ1NmlZS2FC?=
 =?utf-8?B?K1AyYk9pbldZQmxkdXlGY2w3dHZVcnlsWWw2L0pKMUJQM3FibkV3WDNpU1ZZ?=
 =?utf-8?B?aTg0T2NpaEJ2RGlNRGlRejBQc3k1OFZVWkplbFIxNFNtQm1SblhWek5ISERK?=
 =?utf-8?B?aGp4dGR5TG4vaEN3ajRaREVydzNaWHRoMXVMeW9vRFBvTm9kaTBpWTk2QmV2?=
 =?utf-8?Q?C48M=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 04:06:41.3331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59b17e2-45e3-4d5e-5fa9-08de2b0edfa2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
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
> Add a small helper that uses memory regions referenced by the R5
> devicetree node to calculate the LPM meta data address.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 44 insertions(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index b28c2cd5776f29d75d54da9078e5fb17768d69c9..191254b391af68cb6c277f986069ed87211f2fc1 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -16,6 +16,8 @@
>   #include <linux/printk.h>
>   #include "common.h"
>   #include <dm.h>
> +#include <dm/of_access.h>
> +#include <dm/ofnode.h>
>   #include <remoteproc.h>
>   #include <asm/cache.h>
>   #include <linux/soc/ti/ti_sci_protocol.h>
> @@ -36,6 +38,7 @@
>   #include <wait_bit.h>
>   
>   #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
> +#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
>   
>   #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
>   #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
> @@ -191,6 +194,42 @@ bool wkup_ctrl_is_lpm_exit(void)
>   }
>   
>   #if IS_ENABLED(CONFIG_K3_IODDR)
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)

device specific function in common file ?



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
>   static int lpm_restore_context(u64 ctx_addr)
>   {
>   	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> @@ -232,6 +271,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
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
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 3333b30b56e711b082d4da7f6773cf0002bbfe30..c579796a7a3baec12792ad137c5c03e7ea361d55 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>   int shutdown_mcu_r5_core1(void);
>   void wkup_ctrl_remove_can_io_isolation_if_set(void);
>   bool wkup_ctrl_is_lpm_exit(void);
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
>   void lpm_resume_from_ddr(u64 meta_data_addr);
>   
>   #if (IS_ENABLED(CONFIG_K3_QOS))
>
