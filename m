Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE3ED5AE41
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 14:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511A58397D;
	Sat, 13 Dec 2025 15:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KVIiqQNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA45E830E4; Sat, 13 Dec 2025 07:49:54 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E9483045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 07:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayAlrUIH145FLMFVzjFosu2gMeRu7aL7qHyaH7wVBzqrvhyP//3JYFlk/R0fGtqq91zmQELAdGExWXax5nStb4P2Zps+q9qfJqv90EoGBxFqRyt9EHYnuEHVZ/Hxn05YlyCtEjURZop8LETi0tBtZXsG6+aimMtJLz0ybTyh2Bj95WY3IQPEE0bttcRTUEQxY4H3BBak2PmmO0QofrHqJjto47PikZH6bmA2a62QWulHnOFf4r/1XBXYyK2sHgJBXIXIPbPnCFpY0nEkYaAF+rG4Hx1NugKLt1SEAYJBKJp3AypnA6zqsR3OxSOWzz2lDs0D3pjggMZ55/rMmerBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiM/2XN7up7DNfBX11sgtSBR4Ryjsg7BEG8W6mqPUpA=;
 b=Yr6INKp1PM9Tlna1tBE1Q3VJoKLgA4GtfRcF3R536CfbaVsoRrDEHGIJ1TzhtvOlsMdDj3RfKGANdkAjIcY/XTJmrrN/fxoh79jM/GfjLKkPp5nquq5GwjNm5VLKXRYCJl9/9Fz8K47xzdoK/j8L+I9AmCpTXjIpp/a/Xn4w+iFHCl/uj5okrccwObtx+y95+7x3eMGt7GSjyTxKJaOjUahDfYeQph0YaPpk5Tun7Ir6Vh13JkHXjzkGxbqYsmuNCU65gBi/07ZzPOllu2YP1FRaNHEBaDnob64N2+Pl1dZI51K4QzBms2LuXBISGah3jGDdnALmYk+ng5hWYxvSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiM/2XN7up7DNfBX11sgtSBR4Ryjsg7BEG8W6mqPUpA=;
 b=KVIiqQNRyqVjEzghCWWpSsAe6KVArU0l/tl4GRXayLL+EzdznYXIm9BN7oWr0zZRj6PnpjXYVfqlLnS9KtoFQNz0RTHBVzH3MaEtt7ryQM6T2ZbWrZSohPI4ZLAqgePVkACl0tZKpeAql2DVwGOC7rQ37Q/sZGjUgKB42ymgexk=
Received: from BYAPR02CA0067.namprd02.prod.outlook.com (2603:10b6:a03:54::44)
 by PH0PR10MB997664.namprd10.prod.outlook.com (2603:10b6:510:384::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 06:49:50 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::79) by BYAPR02CA0067.outlook.office365.com
 (2603:10b6:a03:54::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.11 via Frontend Transport; Sat,
 13 Dec 2025 06:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 13 Dec 2025 06:49:47 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:49:45 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 13 Dec
 2025 00:49:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 13 Dec 2025 00:49:42 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BD6nW4O3383815;
 Sat, 13 Dec 2025 00:49:33 -0600
Message-ID: <ec6b0e22-fb22-4b55-abbf-b9abb4478c4e@ti.com>
Date: Sat, 13 Dec 2025 12:19:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/13] arm: mach-k3: common: Helper for LPM meta data
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
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
 <20251210-topic-am62-ioddr-v2025-04-rc1-v7-7-f113b156f83f@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-7-f113b156f83f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH0PR10MB997664:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d25a6a2-b8ff-4333-27d5-08de3a13ceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2ljSFdvNEg4dHlTV1JlTGxZVzRaOHNZbEhkVDI5TFR2aFVGaVFiMzh0N05V?=
 =?utf-8?B?c1c0ZEl6K0ZPcGtOQ1U2TmxIVFpwY05mQmxsZ0l0QVkyUVkyeHNPamVvT3hQ?=
 =?utf-8?B?YkZ3ZHRza09qbmp6VUhKMGhFTTVWMkd1aTVXcTJUdjZ3elo2ekRtSXZzeTZm?=
 =?utf-8?B?bGN5R2hsTHcvTjc4azJISEtJbVU3V3ZkbGJqM211SFlVbnJmYWJxMldKZGxB?=
 =?utf-8?B?OHdOWUhRbFRtSjllMVllY2IrRGNiNVFLTnljcDhvNVFUMjFOeTlOT3RIbkYr?=
 =?utf-8?B?VHpuT0NsUXNlR3c3TFNsbEYrbzJuaVNhR25rWEtoNys1UFZkSWtiQnJRb2VU?=
 =?utf-8?B?Z1ZlVnFKWHhZQ3JpOFl0YnRNU3c3Q09GUlB2VlNzK255RGRoS3g3dk9sZmNs?=
 =?utf-8?B?dFFodDc0Yllod2ZkRUNqM0lpUVFNdHVyNGtGRmZicGNyZ2hDMUFBV1ZrRFp0?=
 =?utf-8?B?OU5EYTVsWXlkOWxHakRacDZvRE1yVEVkMGN4dWNyaVVIZERzVmFwU3JubURt?=
 =?utf-8?B?emZrMzVYeTBMR21YV2szRlVFNHNFekRUaEFabDIxN25ybDJ1N3BhYmdrNWlu?=
 =?utf-8?B?MSt0dkNYam5XV01CbUVmTXhVMm82cithYUk0ZnVVTXlmbjZ3c1Vma09Leitj?=
 =?utf-8?B?TThseGlFUHBpclFucnVMSElmWUpzNmdjdzEybEV3VGZ1NENwdjVJNlBNbVd5?=
 =?utf-8?B?cGVZUlZmTnd4MXRwY2RYY0EwTkI3ZEt2K2ZqbWt6bVMrYkZmUWNpRkZtL1A1?=
 =?utf-8?B?eFE2TjIzdFhYNjN4MDhwUlRMS2xqb1A4SUQrK00wRGZRdjI0M2dDVHJsY2ZU?=
 =?utf-8?B?Y0Q4UmFtdnJGbllieHBJNTVRcWdHUUxQUkNJR2tBMkRsTEQza000dFZsSTMw?=
 =?utf-8?B?K2pLNk1hbUsrT2QybC84Z1FBMWVydkRVd0x4UUUyY0ZSTnJFZjN3dS9KdWda?=
 =?utf-8?B?Ny9rd2RndXl2OU9QWkdpTFhPeHNYSnQzSG1aYUJiTzFPbnptWWlwcHpESmtW?=
 =?utf-8?B?OHZHM3dPRXdQVkUvUm1mNGZETnpiQUJuVVZjNGdvdUQzNGhyK3ZBaDlOaUtP?=
 =?utf-8?B?N2VrWlc0UDMzR0VJZVdZSnBYbmRrUExUelFQMWI5bFZyZXQxN3RNRFMzVmhG?=
 =?utf-8?B?V0ppNGJVRm9hcDQ0Y0dXYlozSHhXczRTVlg0QUdrR1FFUjhlYzBrVUk4Rmh3?=
 =?utf-8?B?aDFzS21GUlh6NTdSc3lFSkhzN2txYWlKcVZ1djZSQmJ4VDRJQnZhUW0wOSs3?=
 =?utf-8?B?Q1Y3NWZ4UzkxZ3dKMjBwd2hSUkp2NjdqSkhLTENaODh3cjl0TFloZ013K0Yx?=
 =?utf-8?B?TVBKR1VJeTZCczB0NlpZdWdFZ21WZUJBRzZoSCtoRkkyUjJmdWh3ZGxPb2Q4?=
 =?utf-8?B?WjN0SmczZVE2cDE3UVhXMCsvNXE3QmpKN1hwY2ZSYWFvTnVlbkZyaUhza2Jo?=
 =?utf-8?B?dTl5WEk3WTFNVEJPQzJnU051bHR6MkxJbk5FNXZTVDNrdTdaYk1kSW14U3E3?=
 =?utf-8?B?enM1Nlg1SDNjU0RZSGJFZ2FWekdvbGx2dUdWQmNoRUt1c242RUJkemRUNlgz?=
 =?utf-8?B?MVRrVHE1L3B0Z2MzSlZiZmM0cEpGbzFqZDJObGxOOWM5a0ZMTk1EQ2JNZWdX?=
 =?utf-8?B?c2JBNDU1N3JUWTN4RHdKNmx0T2grYzVnSjR4ZWovS2xmL0xHbW5Udkg3VURI?=
 =?utf-8?B?SVVIZVRTaVhLYmxES3JXMksxRmtvTk1BK04zeThvQWVkclFpZ0VIbVIwYk84?=
 =?utf-8?B?cVM0SXZBQXR4dXkvOW1iak5mc0srMDZkSmR3cHJVb1U3UmZ1bVpiV1pnT29W?=
 =?utf-8?B?TXJFcmNVZU1rZkxLRlJiQWZTeHR0UWZ1cFp1TmdrcnU2UXhlWUhpSkcxM3lI?=
 =?utf-8?B?KytBSlVNeTB4Zzl0cTFMSFNrSkFlcDZ4Y0dQOW13K3Y4TkJNQ3ZSNXVRNElh?=
 =?utf-8?B?elkyYkFoTHRsd2xMQjhuZE9zYmpmNFZxRjFZbHFrOER1U1o0MU9OaDViTVVv?=
 =?utf-8?B?WUswZko4em5Mc0tvNUx5VkpLM2U2K24xemZyTXlMQzIwelY0c080aHNKdTVE?=
 =?utf-8?B?L3JYQTRlM3hkWGZSb1JjWFpGQ1BrRVo5ZU1uNllCOG5PSDRiSnliZUlVbS85?=
 =?utf-8?Q?WIhc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 06:49:47.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d25a6a2-b8ff-4333-27d5-08de3a13ceaa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997664
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
> Add a small helper that uses memory regions referenced by the R5
> devicetree node to calculate the LPM meta data address.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Kendall Willis <k-willis@ti.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm/mach-k3/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-k3/common.h |  1 +
>   2 files changed, 45 insertions(+)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index ee56f0b86ce303e319cfcd2b0db3bade1540635b..f058e973d08e233a458892df86e6da22ba3852fe 100644
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
> @@ -194,6 +197,43 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
>   }
>   
>   #if IS_ENABLED(CONFIG_K3_IODDR)
> +int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)

looking at function name, looks to be am62 specific, then common.c is 
not right place for this function .


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
> [..]
