Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDEBCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01839832AD;
	Tue,  4 Nov 2025 17:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bnLjkIVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCE0835B3; Tue,  4 Nov 2025 17:41:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240A0808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRBBMnv3/4F2Pbdd/+coXOjrXd+ssAC3jlTkFQ0Z+MN64JAk+EkSf7tJPXakfiCIImC1C0w3xPF6+qo2F9lhaZDYnKtR+WTUxjARgm6iJN85XATD0CUOo6BczF7xNMOYJPjmWz4oUGX/2qmqRT1WVPnZ8xXjpwEwe6r3PxqYbpwhipyVs6mJWoa0WpzrAlJP+CQ/J1OM3H5JP9wsEBRjVzuGgY1J8Regbq0sLpTpwWRuN3VWR4BmhZ3shoFZBlMVPRWkvUe8omVAQSoaoWFQV7AjwjedUapC4huvmdTCxQB9OUqtP2064brkU4HTsiQots5SFhyiyi9uUm7L0bzhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCZs+jvg/EjIdZMO7Kq+N7uaCWJfehkTqntMllV3VGg=;
 b=s1SUsQcd0JkOeea6oznBZRhU0SMG5hXZnEYiaOJJaoT2tdx8+X0mFYN283qaGfoHff2f9AbxuCFQh4WiVsL++W+uJy6m5EFJEokenFz/LGgRSzom7bOyaSlgZp/rs2MToffcLNHBm7QsaRjwcSj/oYzF/sfWh8n6th1p6scIB+uEuyz7ljiLyZVesk9TWieNWx6ciYLkx7TMJ9biJypQeS6X/PYusvve9slJ7jH9kzk8X7XVoxbQ9r+o5INBna+qDp1cwkwGv0rJmhi3KrIxhjaJydZ/nqSj+JwosaPbZBRbiYXIwPKdRofNfKep5GoZZVm8U/neq7uUWtN/6J4Vew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCZs+jvg/EjIdZMO7Kq+N7uaCWJfehkTqntMllV3VGg=;
 b=bnLjkIViUFKpW1pMDPBFxfuUUzXMKmZ/SN+XiMb0aABVdzvJsOVFYFYqBiVZOEElOT/snKNEu8goqOdP13Y1nB2WD8y39txj8tcqvDL3iay0T06zBsg99lmUdzkIg9VlpUFULXBaNjo8ByX1lPpJtIAwZbHJv4Daj4Fv0mZ00eQ=
Received: from MN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:208:530::9)
 by CH3PR10MB7140.namprd10.prod.outlook.com (2603:10b6:610:123::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:41:24 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::71) by MN0PR02CA0012.outlook.office365.com
 (2603:10b6:208:530::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 16:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 16:41:22 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:41:17 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 10:41:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 10:41:17 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4GfGgX2228065;
 Tue, 4 Nov 2025 10:41:16 -0600
Message-ID: <bf5c3446-7ce2-4835-b005-52e1b1b677ba@ti.com>
Date: Tue, 4 Nov 2025 10:41:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: mach-k3: Rework spl/get_boot_device()
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <anshuld@ti.com>, <bb@ti.com>,
 <ggiordano@phytec.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20251104152459.3648004-1-w.egorov@phytec.de>
 <20251104152459.3648004-2-w.egorov@phytec.de>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251104152459.3648004-2-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH3PR10MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e239fb-6d50-4d2a-cba7-08de1bc0fd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjJmOVZlK3VTUE9ZUzFzN2FpeDJEb2lHZjg0Rm50NGZWc05VSkpFNlo3bjZs?=
 =?utf-8?B?NGk4SjA1VkY5bUxNNDhqdFNOQ2FkbXNQa0RUblNDRDQyblpuVG5BK3JlK1lo?=
 =?utf-8?B?NXZWaXJyc2tYeXBjelRTL05McjhuRXZ2c0ozUmJLbG1LdDFydzYvdnRQRFFE?=
 =?utf-8?B?Uk9Sb09Wb1VOa1FpM0hOTHVyMHBuTlBYQ0NLeGhuNWVKK21laEFxemhIYTVH?=
 =?utf-8?B?VzBoVTdpY3haTTJET2lrN20zZXZXK1gzN205ZmFkbDZnSlJvTEhIcEo3YkxK?=
 =?utf-8?B?WlNGeURxYTRSRCtLU1NHcjUxVEJVYkt0aUxMczArMzJ2SHgwSFp6M3NjQkF0?=
 =?utf-8?B?TTd1bnE3Q0RZR1lHcVBrWmx6MFBXVlkzMVQ0Zkt6cVgxMSswWEdEcVVxOE5C?=
 =?utf-8?B?UmFGK0d0ZzlhS0xiTXgwdDhKby8zOVUwNzZUdllPcEd3U1FiN0xJYjRlc1lE?=
 =?utf-8?B?ZXYzRXJHMm1yM2lkTVJBU1dzSHV6SDlKOCtHMzBqVXdSSjd3YmJiMXlkVU0y?=
 =?utf-8?B?YmY2QTlQbHNTeHlvYm1iVHdhTHYrWkFqaTQzRktVc2JuZ2hkc0JVdGczempW?=
 =?utf-8?B?TEV0V3dvRDgxNWoyTTZ5dVBrSUZseDBkelZZM25jbkRYNjVvd1kyUUtsSyti?=
 =?utf-8?B?UG85bmovY0l1VXFOSU14by9yMVp5WVk2SExlYzdtcHBLay9qVzNHZm1udXJx?=
 =?utf-8?B?NmF0c0ZjTWNKK0xPWW92a3dEeUNNa0ZqRlByUTJKNmF4b1AvNnhrV2Q3ZWpr?=
 =?utf-8?B?S2Nvck9QemUySmtMMXo1bU0wK1JNTDVBU2c5Tk1UQ29qcGpMR3RVUlNUUHZQ?=
 =?utf-8?B?dEZMVnozUDJGK3R5ZHJ6b3FzWFJ2dkZVV3dEa01XaWl6QW4rOFhOVW9aeHVu?=
 =?utf-8?B?azRlcGtoYzZ3VC9zVlk5Ym9GQ1ZKc3pGMVFmL1FqUmMweFAzajh2QzBlZFVC?=
 =?utf-8?B?Ni9hRk0xZEFZR0VFL0orTGNoVWNncXJ5OVVwNU9na0daUE5BeG5jbkhFeFJU?=
 =?utf-8?B?Y0IwVnorejVYYkJGS0dUa0NxaXNQMFNFKzNwQmp6TVJ6Z2RrV0tOdTRyYWd0?=
 =?utf-8?B?eWI3TXlWQng1MEQxUW5VYTJMb1BrUmZEelR6bnh2UlBqVVRkNjdHM2lsUGJT?=
 =?utf-8?B?SWk3SDVuY3lrZmk5RDRaemx0RmhXOFoxM2FERlVuQ1BlaHNsQkhCczNrRUts?=
 =?utf-8?B?U3lRbXZ3N1haN1ljVHRCSmJ6K0VwUmtNWFYwNVZXd2pJaGFNR05GWGNXS09o?=
 =?utf-8?B?WnhDQVd4eXZ3MFR4OEtzSElMbzUwNExxK0ZOZjg5WkJDUjZBemk2U3RXbjB3?=
 =?utf-8?B?NnBqOUNlNFNWS2daNkhGUExpU0g0UUdWbUh6cU0vaWU0S21jSmk1ajVMNnNG?=
 =?utf-8?B?aGVVdERWdXJucTU5THYzY3NXQktPRGgzTWVOUWpoM2pRaHVqT0hHMGJrdW5p?=
 =?utf-8?B?NEt0eDlENTBqZW5yYVVYK0ZVd00rWk9zRGFTRnBTb1BlSHJGTFBtMThSSmY1?=
 =?utf-8?B?em1JVjJic3FkZEN2S2Q0WmxWZHp6ZURMUnphRERJWDFzNStod3NrMWxVRTlM?=
 =?utf-8?B?MmEwTEVUbWlXU1V1cWNHYzBxQktGQUhoSGRRdjRqaXJhODlBM3RTWEorR2Fl?=
 =?utf-8?B?OVZRRDBvREJJSlZFbzIwUFdZU3pCRkN3bzBOZlZrTXYzZzU3V2MyZTRBbHJk?=
 =?utf-8?B?Zmw4aHdPREhIc0lqbXd0MzBma0h1eFE0dFgxbVVEY1JDY1pCMlI3SjdKT2hw?=
 =?utf-8?B?cHVlMENzTUNuUVV3QklENDhvWXNuUUh3Tk1BOS84STAxd1ViQjc1cklzVGZB?=
 =?utf-8?B?bExxRndJMjVRUS9VejlNNzdreU56aU8vTjBaNm9tRlladVN6Qlo3T2JsQWdR?=
 =?utf-8?B?clUwaTFmdUQ2bnRHSmcyL2hkbFhLSitSOFdPQi9VWEhtNGtxK01qNllGaTNT?=
 =?utf-8?B?citkMlhVTWlNaVlQWDJCRUs2czFROThNR1lrSGJtSXFrMGhPc3QyeVpScnRR?=
 =?utf-8?B?YVpFK3NrblRXY3Q2SlVUQmRXZzh1WWRDa0JEWDI4dHpKeGRlWDdwTW9UQ3V4?=
 =?utf-8?B?VWtZQXVFYkNHakVaSmxtUTA2MzhzcDZ1emRldW9PMzQyU1VITXloNm1SbHl1?=
 =?utf-8?Q?o5Vs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:41:22.6214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e239fb-6d50-4d2a-cba7-08de1bc0fd16
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7140
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

On 11/4/25 9:24 AM, Wadim Egorov wrote:
> Introduce a shared boot-device helper that translates DEVSTAT boot
> modes via SoC-specific lookup tables. This replaces the per SoC
> get_boot_device()/get_*_bootmedia() implementations and centralizes
> the logic in boot-device.c while keeping the mapping data SoC-owned.
> 
> Start with am62x as a reference implementation.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Anshul Dalal <anshuld@ti.com>
> ---
>   arch/arm/mach-k3/Makefile      |   2 +-
>   arch/arm/mach-k3/am62x/boot.c  | 141 ++++++++++-----------------------
>   arch/arm/mach-k3/boot-device.c |  90 +++++++++++++++++++++
>   arch/arm/mach-k3/boot-device.h |  41 ++++++++++
>   4 files changed, 175 insertions(+), 99 deletions(-)
>   create mode 100644 arch/arm/mach-k3/boot-device.c
>   create mode 100644 arch/arm/mach-k3/boot-device.h
> 
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index b2fd5810b67..7dc77328e5c 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -6,7 +6,7 @@
>   obj-$(CONFIG_ARM64) += arm64/
>   obj-$(CONFIG_CPU_V7R) += r5/
>   obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
> -obj-y += common.o security.o k3-ddr.o
> +obj-y += common.o security.o k3-ddr.o boot-device.o
>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
> diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
> index a3a6cda6bdb..06bd04da99f 100644
> --- a/arch/arm/mach-k3/am62x/boot.c
> +++ b/arch/arm/mach-k3/am62x/boot.c
> @@ -3,104 +3,7 @@
>   #include <asm/arch/hardware.h>
>   #include <asm/arch/am62_spl.h>
>   
> -static u32 __get_backup_bootmedia(u32 devstat)
> -{
> -	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> -	u32 bkup_bootmode_cfg =
> -			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
> -				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bkup_bootmode) {
> -	case BACKUP_BOOT_DEVICE_UART:
> -		return BOOT_DEVICE_UART;
> -
> -	case BACKUP_BOOT_DEVICE_USB:
> -		return BOOT_DEVICE_USB;
> -
> -	case BACKUP_BOOT_DEVICE_ETHERNET:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BACKUP_BOOT_DEVICE_MMC:
> -		if (bkup_bootmode_cfg)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BACKUP_BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BACKUP_BOOT_DEVICE_I2C:
> -		return BOOT_DEVICE_I2C;
> -
> -	case BACKUP_BOOT_DEVICE_DFU:
> -		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -	};
> -
> -	return BOOT_DEVICE_RAM;
> -}
> -
> -static u32 __get_primary_bootmedia(u32 devstat)
> -{
> -	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
> -	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> -
> -	switch (bootmode) {
> -	case BOOT_DEVICE_OSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_QSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_XSPI:
> -		fallthrough;
> -	case BOOT_DEVICE_SPI:
> -		return BOOT_DEVICE_SPI;
> -
> -	case BOOT_DEVICE_ETHERNET_RGMII:
> -		fallthrough;
> -	case BOOT_DEVICE_ETHERNET_RMII:
> -		return BOOT_DEVICE_ETHERNET;
> -
> -	case BOOT_DEVICE_EMMC:
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_MMC:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
> -				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
> -			return BOOT_DEVICE_MMC2;
> -		return BOOT_DEVICE_MMC1;
> -
> -	case BOOT_DEVICE_DFU:
> -		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
> -		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
> -			return BOOT_DEVICE_USB;
> -		return BOOT_DEVICE_DFU;
> -
> -	case BOOT_DEVICE_NOBOOT:
> -		return BOOT_DEVICE_RAM;
> -	}
> -
> -	return bootmode;
> -}
> -
> -u32 get_boot_device(void)
> -{
> -	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
> -	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> -	u32 bootmedia;
> -
> -	if (bootmode == K3_PRIMARY_BOOTMODE)
> -		bootmedia = __get_primary_bootmedia(devstat);
> -	else
> -		bootmedia = __get_backup_bootmedia(devstat);
> -
> -	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
> -	      __func__, devstat, bootmedia, bootmode);
> -
> -	return bootmedia;
> -}
> +#include "../boot-device.h"
>   
>   const char *get_reset_reason(void)
>   {
> @@ -141,3 +44,45 @@ const char *get_reset_reason(void)
>   
>   	return "UNKNOWN";
>   }
> +
> +static const struct k3_boot_map am62_boot_device_primary_table[] = {
> +	{ BOOT_DEVICE_OSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_QSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_XSPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BOOT_DEVICE_ETHERNET_RGMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BOOT_DEVICE_ETHERNET_RMII, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BOOT_DEVICE_EMMC, 0, 0, 0, BOOT_DEVICE_MMC1 },
> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 1, BOOT_DEVICE_MMC2 },
> +	{ BOOT_DEVICE_MMC, MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK, MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT, 0, BOOT_DEVICE_MMC1 },
> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 1, BOOT_DEVICE_USB },
> +	{ BOOT_DEVICE_DFU, MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK, MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT, 0, BOOT_DEVICE_DFU },
> +	{ BOOT_DEVICE_NOBOOT, 0, 0, 0, BOOT_DEVICE_RAM },
> +};
> +
> +static const struct k3_boot_map am62_boot_device_backup_table[] = {
> +	{ BACKUP_BOOT_DEVICE_UART, 0, 0, 0, BOOT_DEVICE_UART },
> +	{ BACKUP_BOOT_DEVICE_USB, 0, 0, 0, BOOT_DEVICE_USB },
> +	{ BACKUP_BOOT_DEVICE_ETHERNET, 0, 0, 0, BOOT_DEVICE_ETHERNET },
> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 1, BOOT_DEVICE_MMC2 },
> +	{ BACKUP_BOOT_DEVICE_MMC, 1, 0, 0, BOOT_DEVICE_MMC1 },
> +	{ BACKUP_BOOT_DEVICE_SPI, 0, 0, 0, BOOT_DEVICE_SPI },
> +	{ BACKUP_BOOT_DEVICE_I2C, 0, 0, 0, BOOT_DEVICE_I2C },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 0, BOOT_DEVICE_DFU },
> +	{ BACKUP_BOOT_DEVICE_DFU, MAIN_DEVSTAT_BACKUP_USB_MODE_MASK, 0, 1, BOOT_DEVICE_USB },
> +};
> +
> +static const struct k3_boot_device_info am62_boot_device_info = {
> +	.boot_device_primary_table = am62_boot_device_primary_table,
> +	.boot_device_primary_count = ARRAY_SIZE(am62_boot_device_primary_table),
> +	.boot_device_backup_table = am62_boot_device_backup_table,
> +	.boot_device_backup_count = ARRAY_SIZE(am62_boot_device_backup_table),
> +	.main_devstat_reg = (void __iomem *)CTRLMMR_MAIN_DEVSTAT,
> +	.wkup_devstat_reg = NULL,
> +	.bootmode_addr = (void __iomem *)K3_BOOT_PARAM_TABLE_INDEX_OCRAM,
> +};
> +
> +const struct k3_boot_device_info *k3_get_boot_device_info(void)
> +{
> +	return &am62_boot_device_info;
> +}
> diff --git a/arch/arm/mach-k3/boot-device.c b/arch/arm/mach-k3/boot-device.c
> new file mode 100644
> index 00000000000..4c3f2da3269
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + *  Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#include "boot-device.h"
> +
> +#include <asm/io.h>
> +#include <asm/arch/hardware.h>
> +#include <spl.h>
> +
> +__weak const struct k3_boot_device_info *k3_get_boot_device_info(void)
> +{
> +	return NULL;
> +}
> +
> +static u32 __get_backup_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
> +{
> +	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
> +			     MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
> +	u32 bkup_bootmode_cfg = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
> +				 MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
> +	unsigned int i;
> +
> +	for (i = 0; i < info->boot_device_backup_count; i++) {
> +		const struct k3_boot_map *m = &info->boot_device_backup_table[i];
> +
> +		if (bkup_bootmode != m->mode)
> +			continue;
> +
> +		if (m->cfg_mask == 0)
> +			return m->result;
> +
> +		if (((bkup_bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
> +			return m->result;
> +	}
> +
> +	return BOOT_DEVICE_RAM;
> +}
> +
> +static u32 __get_primary_bootmedia(const struct k3_boot_device_info *info, u32 devstat)
> +{
> +	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;

So this won't work for J7x devices as they have the primary bootmode in the
wakeup devstat (WKUP_DEVSTAT_*).

Since you already have a k3_boot_device_info table, instead of storing
"main_devstat_reg" and "wkup_devstat_reg" store whichever reg contains the
primary and backup boot modes. No need to label them "main" or "wkup" as
you don't actually care what domain they are in, you care about what
each contains (bootmode). That plus the shift needed to extract that
value would make a table that would work across all mach-k3 platforms.

Andrew

> +	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
> +			MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
> +	unsigned int i;
> +
> +	for (i = 0; i < info->boot_device_primary_count; i++) {
> +		const struct k3_boot_map *m = &info->boot_device_primary_table[i];
> +
> +		if (bootmode != m->mode)
> +			continue;
> +
> +		if (m->cfg_mask == 0)
> +			return m->result;
> +
> +		if (((bootmode_cfg & m->cfg_mask) >> m->cfg_shift) == m->cfg_value)
> +			return m->result;
> +	}
> +
> +	return bootmode;
> +}
> +
> +u32 __weak get_boot_device(void)
> +{
> +	const struct k3_boot_device_info *info = k3_get_boot_device_info();
> +	u32 bootmode;
> +	u32 main_devstat;
> +	u32 bootmedia;
> +
> +	if (!info) {
> +		pr_err("%s: no boot-device info for this SoC\n", __func__);
> +		return BOOT_DEVICE_NOBOOT;
> +	}
> +
> +	bootmode = readl(info->bootmode_addr);
> +	main_devstat = readl(info->main_devstat_reg);
> +
> +	if (bootmode == K3_PRIMARY_BOOTMODE)
> +		bootmedia = __get_primary_bootmedia(info, main_devstat);
> +	else
> +		bootmedia = __get_backup_bootmedia(info, main_devstat);
> +
> +	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
> +	      __func__, main_devstat, bootmedia, bootmode);
> +
> +	return bootmedia;
> +}
> diff --git a/arch/arm/mach-k3/boot-device.h b/arch/arm/mach-k3/boot-device.h
> new file mode 100644
> index 00000000000..04951deafb3
> --- /dev/null
> +++ b/arch/arm/mach-k3/boot-device.h
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *  Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + *  Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#ifndef _K3_BOOT_DEVICE_H
> +#define _K3_BOOT_DEVICE_H
> +
> +#include <linux/types.h>
> +#include <asm/io.h>
> +
> +/**
> + * struct k3_boot_map - Descriptor to map a raw boot mode to normalized device
> + * @mode:       Raw PRIMARY_BOOTMODE value
> + * @cfg_mask:   Bits in devstat-cfg to test (0 if none)
> + * @cfg_shift:  Shift right before comparing
> + * @cfg_value:  Desired value after mask+shift
> + * @result:     Normalized device to return
> + */
> +struct k3_boot_map {
> +	u32 mode;
> +	u32 cfg_mask;
> +	u32 cfg_shift;
> +	u32 cfg_value;
> +	u32 result;
> +};
> +
> +struct k3_boot_device_info {
> +	const struct k3_boot_map *boot_device_primary_table;
> +	unsigned int boot_device_primary_count;
> +	const struct k3_boot_map *boot_device_backup_table;
> +	unsigned int boot_device_backup_count;
> +	void __iomem *main_devstat_reg;
> +	void __iomem *wkup_devstat_reg;
> +	void __iomem *bootmode_addr;
> +};
> +
> +const struct k3_boot_device_info *k3_get_boot_device_info(void);
> +
> +#endif /* _K3_BOOT_DEVICE_H */

