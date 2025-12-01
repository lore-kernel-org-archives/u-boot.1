Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACFCD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CB583BC4;
	Mon,  1 Dec 2025 17:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rufEiPNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A81983BF4; Mon,  1 Dec 2025 17:24:12 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FFA83BAD
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPEpVnXUmLYBiZ1Vk/3RUOfUOo0jpP8tZ5GLonx+ErQ0GxI2Yw7F2XK62Attcwq1V3WzOtbR4/FPUzqiE6SY0QTf/i9Ad81WVAPzbQIQBUunCMRiJMoDNdEzXj67PGh7VEH4vxbVc2GUqznNBcWBnndKadCmPtOj7nS0UnWUaXBrb+uoyBcjGYqJtIZUOM0HyevBaNdIiAR+9C7nuSLRkPiyKc6nFUz5mC4AP9XjeW08vePyg8/yheDkz9hXdkbW2tIDKtcQXAbjJo7f8rx2exFH/IKtA7fT/9QwD+aEU+2pE7Jgcfwtk6KUYX5Oo3K5R+taCOQYOWO2VZvLOuWEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DoLdbZFnTaN5qnzz46Tjh1dGWmX1cpgkCg0/c37e20=;
 b=MGx+9VDRWcHYBoI0NSsxevMOy4IY1tzLDieW634zTCQOpbxf9skLBi2JpxL/6+cudNeI/HkAGYhIRyfj76r+DBZgJGT1f4jl2qoytWcVi04rlAsbjJcTaI+o+Zmh4ipfJnj7k4CdqEpFQo4J0LeAt+oMDLNt8n6krwVxi6ReDh9nBPobJcucj/yU9TBqKjDdy3V2rMPXaK26BRaqyf6Vz8EYDWJf19YvPw6w+5Rq/4GWuL1OW92oPbom0cf5PftxrFqEm3HcMmvDNhNA5euZphz+nePFoskvuVk3XWe99l9GTFK1k7FagRmTJfJPRaO2tHagyxW+bIUThfiMXmvqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DoLdbZFnTaN5qnzz46Tjh1dGWmX1cpgkCg0/c37e20=;
 b=rufEiPNPzd+BKkhPYJksS+5r8TWH5RdGU4m4DyLPKAR++6oVs2tPQ4Fz01PLSNPEpZjRG7FcWJrNfMZ4dh1EH/oYpiiAyvgTHeNQ0ixoToQAUZD2Mrj+dJWxqKRTZdkGL5Z1xI0wAiUutW4ZeUfeDg64tBga2KJtP+MvNmbjtnA=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by SJ0PR10MB5568.namprd10.prod.outlook.com (2603:10b6:a03:3d3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:24:07 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::9e) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 16:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:24:07 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:24:04 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:24:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 10:24:03 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1GNvir738080;
 Mon, 1 Dec 2025 10:23:57 -0600
Message-ID: <bcd0274e-920c-4f97-88ca-4cf518b9c650@ti.com>
Date: Mon, 1 Dec 2025 21:53:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] configs: j742s2_evm_r5_defconfig: Disable PCIe
 boot configs
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <a-nandan@ti.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <j-keerthy@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <jm@ti.com>, <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <u-kumar1@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
 <20251201110103.845413-9-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251201110103.845413-9-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SJ0PR10MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9794fc-0af9-4347-ba05-08de30f60cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTRpNzhLQ0l1aXNUQ2tEc2hpSm1qQ1BUWHNtVlZOVkxZUFNhdGZCd2dyT2Nm?=
 =?utf-8?B?NEFpRlJNRUg5dGdTVm1CdE5tTHpRaG4rcy9NaGFaeWllMW9YeHRxZ1htcVhB?=
 =?utf-8?B?Tjdwa202K0ppT2RqWFRUYkYvTC95bTRhSjhORnIxcjNMdXV4RWx1dzlGZllQ?=
 =?utf-8?B?ekM4MHBCUDZEem0rMGNDOXQyLzNUZSs1YXM1YXNiMUQvbGJ5V1hTQXA1cG8v?=
 =?utf-8?B?M2dHdjQwQitISDg4SWlZeVNGbVovQnpyU2NTdXBLOVlSQU1sZUswWmZ0Y2N3?=
 =?utf-8?B?VlQ3SW1wOEsxWVl5Q0NjNlh4eVZtT2FNWWI4UVVCZHllUTRGRlVvcG5DK0xW?=
 =?utf-8?B?eFEvZlBZWGo0RlgyMlZWRnEyRzJ3M0FpaGNaYVFGYW9EbDhFdHRoNm1XWWtL?=
 =?utf-8?B?Z1hRdFRrL0x5Z0dGRytISEdnbENRREpoaXU4RS9HNDNJT1pkUTRqU212YVVI?=
 =?utf-8?B?WHRDd2NsaGFsaGhJbGZLbTNHYWhLd09wbjVzbWIzVUVJaW9YOGVrRkNKdjgx?=
 =?utf-8?B?Q2x0ZnBMb1p1S1c4aUwxZDNEdmNGOUlWVnpCK0l0MTVHRllidCtpSUxHMVZK?=
 =?utf-8?B?a3dyTzgxck90a1pwYkRadmVRWERWMCs1TFJHMVpTQ21vL3ZYUlYwZWNPVVVZ?=
 =?utf-8?B?anM3SDRKYkJOTUhqais2ZFcrWGhyaXJlTS9IRSsveTlRd0JmZEQyUlFYWDFs?=
 =?utf-8?B?cHhZclJqY0ZwRmN6MEtqUE5pZVNZS3J2YUFURnBydEF5VjEvVXpaTWNjVkFz?=
 =?utf-8?B?RmwyTi9aSlNvVHBLcG4zZUhlNEhFaDZjWTRDb2pPYWVhR0RtK2NKa1ZUa0hx?=
 =?utf-8?B?SmJGSVhseUFpVDU4eXE0aVNIQjAwbVNORkZOQjFQdjg1blpuM3B6ZHlVZDRa?=
 =?utf-8?B?Wm03Ty84OVhyWXI3aVpXaXB0MC9WYk5hVFNvY1J5UzUwa1FKcHQrZCtuY0Vo?=
 =?utf-8?B?K2Yra2c0Wlg5MDRONXptVmRzY1FDVEU3UHJGd0dYU2o5dExVQVcrZUJIQWxX?=
 =?utf-8?B?em9IZWdxQU4xVGtyR0Z0Uk1raVlYeEtHajNBK0REVGExT1JoKzdHOUFIclNY?=
 =?utf-8?B?dzduS3VQOXpUZEZUT29XdTl6OFpsQzEzYmhKNVRUOUMvS0V2Mjh2YmFHcnhV?=
 =?utf-8?B?ZDZXRTRkTVZQODQwVzBNZmt3WXYrdmxTZFowMjh0U1huVGJBajJSRTVZLzBI?=
 =?utf-8?B?SmRuajlUSWNQT2FtRnJ0akVSUTNkZFRiQzhlenZHOHRldVpHK1BhbUlucXZr?=
 =?utf-8?B?cGcrNzl0WE0rWk5tZWkxSnd3Rm1iSG9CYTRwTzRXVmFhYzNJVFVydG1BdU9F?=
 =?utf-8?B?b3hDQ2svV2gzdVpxcEFZYlNobGh6ditnQzQrVzMvZXpvalNMNCtPSk1pMno3?=
 =?utf-8?B?SVBYOWlDUFNKUXA1Q0t5dU9sN0ZrUzhRZXRTK0dpdzlVdUFFSnYyQjQrM3VR?=
 =?utf-8?B?RDVuQ21CZDBZakw4ZzdMMXllWmxBZlBJbzVMbHRCNk4wRUdBbzBxSzh2ZVBE?=
 =?utf-8?B?U2ZGQW1zSjBtT2ZubmlJbkRGcUJuZGpPMjlyNXUyK3IzZnVra3ExMExaNk54?=
 =?utf-8?B?TE91OExmVzg3NjUvUGc1K1Q4YzhmMlR4NXVENFRxOE1Na0llWFBoYkpXTCtC?=
 =?utf-8?B?QkVsZDQ2Q3hrZ2YyNnl1QzhyVEY1QUtBeWQ4NnNXanc4Zm5MVldwTnExMStt?=
 =?utf-8?B?Z1BGVGU4bUQyd2I2OVg0TE8zVVpOVGFiV1A4SjlpaHpnb0FtaFl2UUhnQ296?=
 =?utf-8?B?b0xKQWxZdDF6MnJWR3k5SmZsTHVGTFZ1bnVzc051ZStqN3JIOHc2WWJlMm8w?=
 =?utf-8?B?RWtvd2Roa2d2a1cvZmFNMHc2WjJLRjJDeXFwT1UyTWdFUGtGMkErY2g1S2ZI?=
 =?utf-8?B?b05sR0VXWks2MHRMZnRrbkVsbENFanRtQXM1enNNdVVmd1lGNlFCVWZsMWRy?=
 =?utf-8?B?SXpsWVlqN3lnUktWT3l6S0hIa0lkMm5PZ3Q5SHE2MUVBV3NLenFwcTVCb1lQ?=
 =?utf-8?B?WkVENnFOZTB6RktqYnNlKzg5akxmcVlRcVAxR3JHQ2NFbUxBaUtpMnUzZzBS?=
 =?utf-8?B?MmE1YkpTZ0lxelU4MThaNmFNaFhKWEJIUnEyRlZLZmI3WXg5STNXMzBNT2tP?=
 =?utf-8?Q?OgaVyc9VuJEjrnC5CRcDEgjct?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:24:07.0368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9794fc-0af9-4347-ba05-08de30f60cff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
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


On 12/1/2025 4:31 PM, Hrushikesh Salunke wrote:
> J742S2 EVM supports PCIe boot but it is not enabled yet. Disable PCI
> boot related configurations that are not applicable.


Please specify reason in commit message , why PCIe boot can not be 
enable even SOC supports this.


> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>   configs/j742s2_evm_r5_defconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
> index 2be6318df76..fa0bafca689 100644
> --- a/configs/j742s2_evm_r5_defconfig
> +++ b/configs/j742s2_evm_r5_defconfig
> @@ -5,5 +5,14 @@ CONFIG_ARCH_K3=y
>   CONFIG_SOC_K3_J784S4=y
>   CONFIG_TARGET_J742S2_R5_EVM=y
>   
> +CONFIG_SPL_PCI_ENDPOINT=n
> +CONFIG_SPL_PCI_DFU=n
> +CONFIG_MULTIPLEXER=n
> +CONFIG_SPL_MUX_MMIO=n
> +CONFIG_PCIE_CDNS_TI_EP=n
> +CONFIG_SPL_PHY=n
> +CONFIG_SPL_PHY_CADENCE_TORRENT=n
> +CONFIG_SPL_PHY_J721E_WIZ=n
> +
>   CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
>   CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"
