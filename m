Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B7E98E0E
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 15:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A0C83C39;
	Mon, 23 Feb 2026 16:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SwO2a97G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F6C83BC9; Mon, 23 Feb 2026 16:58:20 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A6F80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 16:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMHKdXQ70F98NvIC1ecH9UPZBm4NrWyUWecoa9AaJs/U4HeSVzoGWRjChxpNZf2+B6dXade1F7JnlIy6NPndzNE+K0bi6t+EdoLF7ZJ2U058lFW787P0p2+Kvt26wbRBvR9ItNDixhFLGzI0n55KlrDri9IGbK3S6wPwkumjwa+vwW5Ugz8mu6ZOpjhvqaseVKm0+02zVURHtesz9Xx2DTptIdROwCoi4hNdl8lCLapfPFAYLKW4bBzFrWnCJtS/sDantg0+KdFrdzHaYO+9+UGIzyK3V2Qum2jzYeKIlr6PwriG2t351TcSBkeNUqj7r+Omrt1m76yo/ovFNUqZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L81Unwa0+HHVEmfE30gkaZEjgIOi5BV6jAx4NupHeU=;
 b=VwJMJ4JqE2npVvC24omQ1UulzeL1JIIhJKKpjQ+h8hS4DJ0vKYBKFBOQvTkB55a3LjOmNizwlYxCTypuZ8nqd0VbxSkh1lF7MSVkKPi9AhupQ9j26SuI/kS6amajIjGYpSOWNLzg5sobvwZBXobTLWmr50C0p6iJKlkzLgAQnnu4Vww2bluucPJBItZzIlNfCDENZkaduNf2BspCaFpOz0/M1d+fMBZYYxkEg53kPEvWS3I1v0yzpkfFpH91/y413NjhU4gpqdn5fk/nYMzzsB0Yp3UikR2GOFWDwR0rsvkkD90oRgJfnpUbrQ6ufvl51b0nfsUk11keHbLBNJNFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L81Unwa0+HHVEmfE30gkaZEjgIOi5BV6jAx4NupHeU=;
 b=SwO2a97GdpuXAzIhqT73iOrPEkEir+QpadWTT8A1Y6ezGKtvYjEG5hEqohUgnRSUO2TPou0be/ibsKh4XduPayFHqGPDvB+1IPlKYyZiIn7dS4eN8csAsxqapIwyJ+Vvi2pH4IWRrZmdXsx2Ig0gCdsNXh9rdp+7SFRJCDNOhSk=
Received: from PH8P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::21)
 by SN7PR10MB6451.namprd10.prod.outlook.com (2603:10b6:806:2a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:58:11 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::d7) by PH8P223CA0028.outlook.office365.com
 (2603:10b6:510:2db::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 15:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 23 Feb 2026 15:58:10 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 09:58:08 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 09:58:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 09:58:07 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61NFw775607101;
 Mon, 23 Feb 2026 09:58:07 -0600
Message-ID: <7e0440de-1047-4146-a0ad-378503047269@ti.com>
Date: Mon, 23 Feb 2026 09:58:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62*_evm_a53_defconfig: Enable OP-TEE fTPM
 support
To: Shiva Tripathi <s-tripathi1@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260223091314.586968-1-s-tripathi1@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260223091314.586968-1-s-tripathi1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|SN7PR10MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b1035e-7264-492f-1af0-08de72f457d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0VoUmlWQUVyWGd6YUd5NXBsMTVHMkZ6QjRYajRzb3MybnRhbHYxdUJCdUtF?=
 =?utf-8?B?VDQwalhyMGtwNUZYVGhYQmFCems2bWpiL3BmRC91cy9NWnJqU0MySVZRWVhG?=
 =?utf-8?B?bXBCNnFRYm45Nm1XeGNNcFZRNTdzMDdUcDk5YjVaWlBIdTdMN0xYclUyU3g3?=
 =?utf-8?B?dGR2aFNQSzVHUXNxTDN6b1VVZEd1cVVXbjZRR3IyYlQ3YW1kQjdKWjY5STNr?=
 =?utf-8?B?ZksrT3RKQlVJVU92eGJ0Q0x1eW5GUTBhWGZJcmhSSXdwb010RFFBckxVeE1i?=
 =?utf-8?B?WnozOU01VkQzUVBuam8zN3lOcEVnZzV6N2hQV2tBOUl1eHhrSGw5T0taSk55?=
 =?utf-8?B?QXBqMGtVZE1ZOHIwcWVOR3ZLVnFBU0hINlB6R01EeUdZY3hiZUpxVjRDOUc5?=
 =?utf-8?B?OW9BTHdNU1h4RENEL1ZiY2hrTk9ia25FNmg2RUpoWHljdnU1T3lIeUF0VC9y?=
 =?utf-8?B?MnVYZzRBQktSY2ZzNnJRVWZGN09lbEJmVEl5eUxLczNTMHJxeEZXTlNrZEpG?=
 =?utf-8?B?TGhFcnBkRGZ2Q1VWSHF3ZVdWK3dzUEFTQzJJRHBCWU5JQklTODEzVEdRd3M5?=
 =?utf-8?B?cWl5YlJDOVlkWUFEZGRFMXJYZkNpYmtMU1lobE41WStXRW5NM2x6aWN2NnBo?=
 =?utf-8?B?L1c4M3Z0c1NTWHBjNGdDZTBEbm11OEJFSDBlRnh5QWF2NExXSDFlcHM2OW9n?=
 =?utf-8?B?QWkzSStLRGdSTmJhb21oQXhRRW10eFVCVm5uck9xTUpuTCsvVm9WRnJqTDJE?=
 =?utf-8?B?YWtreU9sL2RZTHVGU2EyVTBCM2xON2hrSUl6cG5UeHdqOThKVzNTSVJPU3NL?=
 =?utf-8?B?YU85SlRRcHRzdUdub0MzQkhHUE5YanhzbVZ2VnFUYlNyUk1uVDlNNTBXQlZ0?=
 =?utf-8?B?V2s4RTJzelBWaitTU3FkeGNxYy9OeVE5eXN1b3duRnR6RjJvWFlVc1V0c0NV?=
 =?utf-8?B?dGZJUFZ2UytIei8xNnA4a3JkaUtJeW5zTllWZ0VRWEE3b0hQT3lUY0hoZ08y?=
 =?utf-8?B?SEllSjBzaWZDZnlxZ05GUTMyZ0tFQStHOFRYZ0tYZU96VnozSnVFQXhua1NE?=
 =?utf-8?B?WGJFZlY2YkVjOGY0WVdQbERKaU5XMndZeUZ6VjYwbS9tZzN1ZFMxMmoxK0sw?=
 =?utf-8?B?ekdQeWdmVms3SzlRRm1KRmJ5MVljdHYrNnZLcnVjaE42YXA4Mi9tZHN0cFJV?=
 =?utf-8?B?TFB5RUk0dkplem15d3BvL1RSdEM0c2FpdkhsRmtHRE5mWjhRcGxlaWJzNk1s?=
 =?utf-8?B?VTlsUlJGdVZTUkdxQ2JXMENkbXpVVDZJR3FmWmlYNGZRWHBwOFZXWVcwZDZt?=
 =?utf-8?B?Q1B6djdaR1ZRanV2NHZHNFo4bFA1Y1kvWGQ2Uk54Vi82Y0RTaHh4dHBuYVJo?=
 =?utf-8?B?aUZCSm9kWlRYZHBwL1pEKytmTzc4Q3ppYWlJUisrdklzTnBpTXVsUU0vYXIr?=
 =?utf-8?B?cUxZOEkyUDVRNGh3WDdrRmNDSTluV2ptMzU4UjNwY2E2cW1MSHRpQlRNQ2wv?=
 =?utf-8?B?RlFwalpzMytqUU9wNDJmd2lhYUg4V0srY0MrekpicHAxd0o2UVNyekVsdWJD?=
 =?utf-8?B?c1U5L2llb0w5eFdpRjZPT3hhZEhFR0RaS1pGSVN4VzhsZFRRMWNrQVh1OGha?=
 =?utf-8?B?bUFCYkFsQUYxSzQzcVBxaTJQZW1iMjB6ZCtVRWZ0N013OWkyZ3czdDNZN0dl?=
 =?utf-8?B?NFFMMGxSdXBRdFdQcDJpQkZuYm5mYTlHaDErTlc1K056UENLUWtBeTZBRWxo?=
 =?utf-8?B?a2dnVUU0elRsN3ovZ0lXYWsreGN3eUF2V1ZNWU9kWnRHYXh5cjRUSTlnOUNO?=
 =?utf-8?B?aTAvYW53eEpBZnlWa2ZsNmdaL014NlFDY0FvZVJYeWwyU1ZtRkU2eG92YmRZ?=
 =?utf-8?B?OE1GMjVBVlo2Q3U0bTJ3KzBpcXJ1Z3hRRmdBR1c5TS9TUVVKUzBJeWpFV1JY?=
 =?utf-8?B?SXpDcGNqMlVJTnZJTmgvQStGUjRHdDRqem1qdDFUSFlBazhmZnJDTTZLTnUy?=
 =?utf-8?B?MVNET0FLQnpKTU4xQ0NPSXJmZmc1aFNNNGlRN2gySzFOUEV0RjRZUWdHVXNS?=
 =?utf-8?B?VTNNYWZlbWg3OWhWRHdsS0hMT25tZzc4SS81S292MnY0RlRjUU4rR1g2SWF1?=
 =?utf-8?B?OUZNekFUTmo5Y09VRXRUbGhlS1JKSzFJb2Q1QlpyMmJlUUw2N2VOcjNHY3NF?=
 =?utf-8?B?NG5kd2JpZmx6MzgvenRaZFYxMVpoSUp0enNBcVJ1Skw0c2FPdndXc0lEUm5I?=
 =?utf-8?B?Qi9BOS8zY1NPUjc5RVRQN3o0NlZ3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Q+gEJRLkRH2OSWEnYzO6LfnBmd6rZStRAq6y1hI2VrS5RtSfWRyaSqgNrvCdrZUfd5jAX88adGOC8wn3jWGgoQLp2Y6cd6ejYSyK8XLZ3nZNvCZZywPUb7avB/mLfRD8gBFq0G6x9NehUtoqAFuB9NIJP8eNpue8ufG3csG/8kIPqUGp6g09jEvxTWWAbeoK4U6RmLg7A2PyHiNd3DVanNu08u1Y5qzzXT8c4MUV3fHKzuVPPZCYAI+D+Qz9BpC6MwK3DZpnbya2XlPHY8IXe4UFI4UY7PndeDRYnKkiv8AQf6/FcPg6oMmcxf4YDbUf6/l8tbQg4Es9ADYoznyBdXAfrFcnwRiCkRkD5daKVyUBsb3QKH/D4sATjSeOGrOrFOYWucR1AWPfd5OyE0192exyHf7/4z1c45TDqEtLp7icMw83MqfnagbAMldSfA5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:58:10.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b1035e-7264-492f-1af0-08de72f457d8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6451
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

On 2/23/26 3:13 AM, Shiva Tripathi wrote:
> Enable firmware TPM (fTPM) support for AM62x, AM62Ax, and AM62Px SoCs
> by adding OP-TEE and TPM configuration options to the A53 defconfigs.
> 
> The AM62 family SoCs do not include an integrated hardware TPM. This

No K3 SoC integrates a full TPM, so why do this only for AM62? And
why only the TI EVMs? *All* K3 SoCs and *all* boards based on them
can make use of OP-TEE's fTPM, so why not move this to a common location
in the Kconfig files. That way you don't need to add all this in every
single defconfig.

For instance the CONFIG_CMD_* ones can be added to TI_COMMON_CMD_OPTIONS,

config TI_COMMON_CMD_OPTIONS
	imply CMD_MMC_RPMB if SUPPORT_EMMC_RPMB
etc..

Andrew

> patch enables the Microsoft fTPM Trusted Application running in OP-TEE's
> secure world to provide TPM 2.0 functionality, with persistent storage
> backed by the eMMC RPMB partition.
> 
> This enables TPM 2.0 functionality in U-Boot and provides the foundation
> for measured boot and disk encryption use cases.
> 
> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
> ---
>   configs/am62ax_evm_a53_defconfig | 9 +++++++++
>   configs/am62px_evm_a53_defconfig | 9 +++++++++
>   configs/am62x_evm_a53_defconfig  | 9 +++++++++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
> index 167ba7ff8df..b14f19968a3 100644
> --- a/configs/am62ax_evm_a53_defconfig
> +++ b/configs/am62ax_evm_a53_defconfig
> @@ -99,5 +99,14 @@ CONFIG_SYSRESET=y
>   CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_TI_SCI=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_TPM=y
> +CONFIG_TPM_V2=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM2_FTPM_TEE=y
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_CMD_MMC_RPMB=y
>   
>   #include <configs/am62x_a53_usbdfu.config>
> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> index aa241a73c3f..2cd572cd5c7 100644
> --- a/configs/am62px_evm_a53_defconfig
> +++ b/configs/am62px_evm_a53_defconfig
> @@ -148,6 +148,15 @@ CONFIG_SPL_USB_HOST=y
>   CONFIG_SPL_USB_STORAGE=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>   CONFIG_EFI_SET_TIME=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_TPM=y
> +CONFIG_TPM_V2=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM2_FTPM_TEE=y
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_CMD_MMC_RPMB=y
>   
>   #include <configs/k3_efi_capsule.config>
>   #include <configs/am62x_a53_usbdfu.config>
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index 281fa3fea15..3221a9b8f2b 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -138,6 +138,15 @@ CONFIG_SPL_SYSRESET=y
>   CONFIG_SYSRESET_TI_SCI=y
>   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
>   CONFIG_EFI_SET_TIME=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_TPM=y
> +CONFIG_TPM_V2=y
> +CONFIG_CMD_TPM=y
> +CONFIG_TPM2_FTPM_TEE=y
> +CONFIG_CMD_OPTEE_RPMB=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_CMD_MMC_RPMB=y
>   
>   #include <configs/k3_efi_capsule.config>
>   #include <configs/am62x_a53_usbdfu.config>

