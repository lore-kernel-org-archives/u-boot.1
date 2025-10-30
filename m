Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730BDCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 15:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9C983642;
	Thu, 30 Oct 2025 16:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f/zVnjM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCBF83849; Thu, 30 Oct 2025 16:39:43 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425A08334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 16:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnsIw9lo1+zK+94ABdu+wESFMbmKmUGy7Fog7ZnHpxhF9ydIkIzY5vSjkjK4/v7P0XtmIugkeQL1q78G1lRED+c9OE9wDEaG9fzXjpQohIYrJPzwa5nniaMn+7tSzEJLpZQw67Nsg+fZ5cRC8pocZnjDNosdgHvfaJf/c7Z0AQKq82/bd1BsnAfdvJLppJ4xn+6YVv9cWtjPukyQKVhNIHL3XmnX68e2X3D+t5riIkDBLG7hojsGvbEWJhddhIkCaBy08XfwOS0sOjY8RQ/5A/qTmipMUJ+bOGjp+dkmW91qPvmfWbMF9Jl0s9gdMCYquM+7Ky91pInW/mMnkPrQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PztWULNM2NoCermVCpuAo2H5n41r5Lkb5oZrA18yoHg=;
 b=pqO6UstnYG13eC65Yv3dh7ZCKxjCenXndCtFNXSc7r+H0bQ7ke2e34yhWiv1fysNAMcjh2d366/skIvL8WVdSSAjUoFX6oGGzqspD8gF7KYPjv7kXgrsdGpsIbG3WOwbOCBe2/5A/X9Jc/HlDW049ZrYD7ILxL9LUEiEuivaU6Ggns5OqmF9RP2i+xDw31N/OnzBmR4OJhtFhGr/91wqpq/pxBZ2z6Voyz5PIO/7bJ+kujllmToH3RtzSn0wwvmRzbjgEBRxpWlR80Nqy4429XzWEu7wo2AhUW/vFRD/vwjyjxFqvRxnyZOkKi1/fODg0eKweVtkjQAJmdBIsMlvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PztWULNM2NoCermVCpuAo2H5n41r5Lkb5oZrA18yoHg=;
 b=f/zVnjM3dwocDrYd3btZWJGqt5ViNf2SeOI8DdOILQ0xYxQgShg3zOac00S/UhE7ZethbOlv0uWluDndiHkcYH42IK+gwyShPBp9BrFxoDLyOp19Mx2jDiwKK6vLkmy8nTH+Spl97J0EY6DXCA3UIG3w8/jp13KkaoKGjAk6p0A=
Received: from SA0PR11CA0001.namprd11.prod.outlook.com (2603:10b6:806:d3::6)
 by IA4PR10MB8541.namprd10.prod.outlook.com (2603:10b6:208:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:39:37 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::ee) by SA0PR11CA0001.outlook.office365.com
 (2603:10b6:806:d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:39:35 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:39:29 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:39:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 10:39:29 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UFdSec2421607;
 Thu, 30 Oct 2025 10:39:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Oct 2025 21:09:27 +0530
Message-ID: <DDVRPWB15CPW.P27MXQPUI2FC@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v9 4/8] mach-k3: common: support only MMC in R5 falcon mode
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-5-anshuld@ti.com>
 <6fe53b09-fe92-4d04-8e51-9084f2b01c77@ti.com>
In-Reply-To: <6fe53b09-fe92-4d04-8e51-9084f2b01c77@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: a64e3df1-0fb5-4f9f-24ba-08de17ca87a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVJOTi9NNjdEZVhQU0lraGVYc1lKYlEvYzFXcExPWkYxRjdQTEwxc0E0MG5I?=
 =?utf-8?B?Nmp0TXl2eTBxcG1SLzNCNmFHWGhvUGhKR3BzN2trRS84czZXNXV6dVFhZDg0?=
 =?utf-8?B?dU9mUjN4SHBSR1M1bWVJN1JETWFsMDdPcU1LeDYwTmVhNXdLQlVPSXB3aStP?=
 =?utf-8?B?aksrOTg4MCt4b1lobXk3aUw3Tm00RGhlOUpMRFlaVDVLRXNGVmlQYjdvKzU4?=
 =?utf-8?B?MnJMcmxNWXZZU2w2T2tDOWhlellFVWplV3ZwTGtxLzdjUkM4bHVYeUNyb1Fj?=
 =?utf-8?B?QWszSVNlZW0wSGJPdmFNa01hTW1GWkdNL0dQVnhMT1NPSzh5eTBVNUxHK0V5?=
 =?utf-8?B?ei9MM1c1a0J0Y1FCNU4zbWpVZ1BldFpoa1FMbmpsRWpnclArU0lCSFpab3g1?=
 =?utf-8?B?ajN2eVcwZzF5TnZzNkV0VzZOK1JnWW0zaXQzQjA2QlUzSVhMMU95S2dmMDlu?=
 =?utf-8?B?R3pQREJraGY2elhHYkxtcnB2cTVhbVpWNk9rWHk2WjE1ekhyRTUvSXhnRzN2?=
 =?utf-8?B?dXBJMlFkQmVESWN3UC93Nm1yMExYS2xvdFljMVhPbTlBM3A2dlFwMTVTVHpj?=
 =?utf-8?B?MlZoYkNPZ1BSMHRhSHVNMDFwd0NOVm91YmIxVUkxTU9NODRJMVp1eGNraCts?=
 =?utf-8?B?QkdNbnU4NFdUUjA3Z0s3RzRJUTBGK05CSkhSM0hUWnJKWm9NTmZQelJiQWI4?=
 =?utf-8?B?aDdrVVRtY3VaVExFdlk2azBoS3hqMHQ1dVphY04yQ1lqNGEzaDhEVnIxSXBt?=
 =?utf-8?B?QzBYNUQ2eGh1MElkYkZubDVubVhVQ1g1S1B1bUQwQjdXNzRtSXJmUmEySEF1?=
 =?utf-8?B?M1gwQW5JQVZ0a0pyQnArNEZVWlZtSlA4NEtJQVdOYlgwN3p3cnVERHB1Z0ty?=
 =?utf-8?B?M2dzNUQ4RVhRT0UxSHFzRVpETTR0K1BVcDU5c2VpTlo0OWRwK1U0YVBBZXdY?=
 =?utf-8?B?ZnBsV0RNdGx5c0p3Y0NZZ24vSWx4d2p6Qk1RdTZJU04vNVBSNWxoNU1DMjB0?=
 =?utf-8?B?SEhuejBFVWtudmJFbldyRzNrRXpFN29nUTVieEdHdHVoQzZuMXlBMW9ubS9l?=
 =?utf-8?B?S1ZCVm5udGxKZkZwS202aG5GckFobk5YR2srdmErV3p6L3JJT3kzSzAxV2tB?=
 =?utf-8?B?dXFkcmhQYTVGZjhWeGRYV1VuYXlXVFVMVzROUGw5QnBqQkZwZUtibXNvejdJ?=
 =?utf-8?B?YVdyN1NaTWNZNFc1VXVKWkVyNXF3dGo3Vi9Nd0svU29rV0JkdTEvK0tNKzBq?=
 =?utf-8?B?aFZJb2x4RURjR1VCR2dxWjZya1N4NzVDemhZVzF0MWJhNzJlNE1oaGNvWU1Q?=
 =?utf-8?B?UnFQTjJ0ZEQrdFRpSm1sbkxlY3ZESVFEd3Myd1hWbC9nU0dsVm9iSzlKcCtL?=
 =?utf-8?B?eUI2cDVtSXMxK05OY1dBSHpsd21QeGpvdW93VjJtQW9laXVYd0RuajUrV0tR?=
 =?utf-8?B?UStZbURmKzFXWEVGTGRjZzlSN3JWM0NNcXNzU3J4WHN1V24zNkNPTWI4bVp4?=
 =?utf-8?B?VUxUWFZXbjRJcmdDdjlHcDh0RUl2bmZOQlhtWHp4TWlMN3I4Ly9kQ3gvUnNM?=
 =?utf-8?B?V1Axamx0RTE2YnpjMEJxNUwxWXBjbEpuc1JGQWhCeVRHeVRCTnNyMUFyRS9S?=
 =?utf-8?B?RGlQUkF0azRjSkVFZ05pZVByWE9XSUh2RXg4N1BKNllMb0pJc3BvTXVyb3VJ?=
 =?utf-8?B?c1FEODRpb1BmM2pqa2dBWnBSaDlRMTRNallLeG52WGMrdFUwMUxtWHJ4Qk5H?=
 =?utf-8?B?cDFOdWFuWHhxcEtkckZvU25LNExKSUNRbHhCRU9LM21GOWtPSnZaWnpWWlV6?=
 =?utf-8?B?emVhalVrbTdWby9sbUlYdHhXQ3VXbXNXbG8yeHA1TnRVSXVlUjIzTWtuUVE4?=
 =?utf-8?B?eDl2eHRwdE9QaFhVWFdJbUdqbW5nbGNVM25QcnNjOEE4ZTFTM215ZmRGSmVY?=
 =?utf-8?B?c1AwbWwrcDBGYnFPMnNmMmdiMExaUUxya1pEVDMwbUhPYkZzUmY4NDFjeTMy?=
 =?utf-8?B?bE9WUldNamxyazZzTHJudUZJUkdjVlZ6ZkY1VGRicDRXZ3RZQyttWVI1U2xr?=
 =?utf-8?B?RE9Rb2FQQnJHMGdqNlh3WTh0dnRKM2p3RmdEU0NodHhrVURjT3pPN1dRY3lK?=
 =?utf-8?Q?IZFY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:39:35.9421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64e3df1-0fb5-4f9f-24ba-08de17ca87a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8541
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

On Thu Oct 30, 2025 at 7:25 PM IST, Andrew Davis wrote:
> On 10/30/25 12:19 AM, Anshul Dalal wrote:
>> To simplify the boot process and prevent the R5 SPL size from growing,
>> this patch restricts the boot media to load the next stage payload
>> (tifalcon.bin and kernel FIT) from MMC only.
>>=20
>
> Is R5 SPL size the only reason? This seems rather restrictive to only
> support one boot mode with all this..

For most non MMC FS boot modes, the raw offsets that U-Boot uses are
common in the non-falcon and falcon mode. And since we need both the
boot flows to first load tifalcon.bin and then fitImage, we can't make
use of the common spl boot flow with those boot media. For MMC FS
however we have two separate configs namely SPL_FS_LOAD_PAYLOAD_NAME and
SPL_FS_LOAD_KERNEL_NAME for each.

This also simplifies the usage where the tiboot3.bin as the intial stage
bootloader can be loaded from any boot media with the catch being that
tifalcon.bin and fitImage both are loaded from MMC FS. Specifically the
boot directory in rootfs, which simplifies the yocto recipes as well.

>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com> ---
>> arch/arm/mach-k3/am62ax/am62a7_init.c |  3 +++
>> arch/arm/mach-k3/am62px/am62p5_init.c |  4 ++++
>> arch/arm/mach-k3/am62x/am625_init.c   |  3 +++
>> arch/arm/mach-k3/common.h             |  1 +
>> arch/arm/mach-k3/r5/common.c          | 17 ++++++++++++++++- 5 files
>> changed, 27 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c
>> b/arch/arm/mach-k3/am62ax/am62a7_init.c index
>> 48d578e7d6f..1c8a5fd2a35 100644 ---
>> a/arch/arm/mach-k3/am62ax/am62a7_init.c +++
>> b/arch/arm/mach-k3/am62ax/am62a7_init.c @@ -240,5 +240,8 @@ u32
>> spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>  =20
>>   u32 spl_boot_device(void) { +#if
>>   IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>
> The check for CONFIG_ARM64 might not be needed, what if we want to
> falcon boot from A53 SPL right into Linux?

I have a separate series[1] adding support for A53 falcon mode and we
can use all falcon supported boot media from the A53 SPL there so an
k3_r5_falcon_bootmode equivalent is not necessary.

[1]: https://lore.kernel.org/u-boot/20251024081408.1610102-1-anshuld@ti.com=
/

>
>> +	return k3_r5_falcon_bootmode(); +#endif
>
> This should be an #else capturing the below return call, otherwise
> think about what the function looks like after the preprocessor step
> if the above is true:
>
> u32 spl_boot_device(void) { return k3_r5_falcon_bootmode(); return
> get_boot_device(); }
>
> just seems odd.
>

Will fix in the next revision, Thanks!

Regards,
Anshul

> Andrew
>
>>   	return get_boot_device(); } diff --git
>>   	a/arch/arm/mach-k3/am62px/am62p5_init.c
>>   	b/arch/arm/mach-k3/am62px/am62p5_init.c index
>>   	aebd5200b0d..4c215d5cebe 100644 ---
>>   	a/arch/arm/mach-k3/am62px/am62p5_init.c +++
>>   	b/arch/arm/mach-k3/am62px/am62p5_init.c @@ -375,6 +375,10 @@ u32
>>   	spl_boot_device(void) u32 devstat =3D readl(CTRLMMR_MAIN_DEVSTAT);
>>   	u32 bootmedia;
>>  =20
>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) &&
>> !IS_ENABLED(CONFIG_ARM64) +	return k3_r5_falcon_bootmode(); +#endif
>> + if (bootindex =3D=3D K3_PRIMARY_BOOTMODE) bootmedia =3D
>> __get_primary_bootmedia(devstat); else diff --git
>> a/arch/arm/mach-k3/am62x/am625_init.c
>> b/arch/arm/mach-k3/am62x/am625_init.c index 14f93ac998f..44b8d2654b2
>> 100644 --- a/arch/arm/mach-k3/am62x/am625_init.c +++
>> b/arch/arm/mach-k3/am62x/am625_init.c @@ -327,5 +327,8 @@ u32
>> spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>>  =20
>>   u32 spl_boot_device(void) { +#if
>>   IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>>   +	return k3_r5_falcon_bootmode(); +#endif return
>>   get_boot_device(); } diff --git a/arch/arm/mach-k3/common.h
>>   b/arch/arm/mach-k3/common.h index 5807d358464..cd3e19374dc 100644
>>   --- a/arch/arm/mach-k3/common.h +++ b/arch/arm/mach-k3/common.h @@
>>   -54,6 +54,7 @@ int shutdown_mcu_r5_core1(void);
>>  =20
>>   #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) &&
>>   !IS_ENABLED(CONFIG_ARM64) int k3_r5_falcon_bootmode(void); +int
>>   k3_r5_falcon_prep(void); #endif
>>  =20
>>   #if (IS_ENABLED(CONFIG_K3_QOS)) diff --git
>>   a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c index
>>   439dd92ef54..aa94c0c1956 100644 --- a/arch/arm/mach-k3/r5/common.c
>>   +++ b/arch/arm/mach-k3/r5/common.c @@ -391,6 +391,21 @@ int
>>   spl_start_uboot(void) return 0; }
>>  =20
>> +int k3_r5_falcon_bootmode(void) +{ +	char *mmcdev =3D
>> env_get("mmcdev"); + +	if (!mmcdev) +		return
>> BOOT_DEVICE_NOBOOT; + +	if (strncmp(mmcdev, "0", sizeof("0")) =3D=3D
>> 0) +		return BOOT_DEVICE_MMC1; +	else if (strncmp(mmcdev,
>> "1", sizeof("1")) =3D=3D 0) +		return BOOT_DEVICE_MMC2; + else
>> +		return BOOT_DEVICE_NOBOOT; +} + int
>> k3_r5_falcon_prep(void) { struct spl_image_loader *loader, *drv; @@
>> -402,7 +417,7 @@ int k3_r5_falcon_prep(void) memset(&kernel_image,
>> '\0', sizeof(kernel_image)); drv =3D ll_entry_start(struct
>> spl_image_loader, spl_image_loader); n_ents =3D ll_entry_count(struct
>> spl_image_loader, spl_image_loader); -	bootdev.boot_device =3D
>> spl_boot_device(); +	bootdev.boot_device =3D k3_r5_falcon_bootmode();
>>  =20
>>   	for (loader =3D drv; loader !=3D drv + n_ents; loader++) { if
>>   	(bootdev.boot_device !=3D loader->boot_device)

