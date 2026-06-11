Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E25CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 18:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0878407D;
	Thu, 11 Jun 2026 20:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YVrY9fDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649E6846D3; Thu, 11 Jun 2026 20:15:07 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5AAD839A8;
 Thu, 11 Jun 2026 20:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UisLVVaV/GhY2I5Dah+z01Ri9PM7UZ/x5AsV1ZxuNQ8SbiaVl7LJ3UkgB1HwcdvroUrNWNrl9YBRWACivSPwNR59VFUp1IiKhHr7bJWL5aZNjC6FIBDDDwFbPtcqPYNFeite49P9z8LzEsx1vxzcCrKr2swwo26WRG6Lfd8Oo1mYPSP5IMHqVdErc+JDrFKHQcez8/ky3tosdf/PAHSFH0Zs3IkqsNz6YCpMhtd8Y1D7zvlNda+JqdM2S6JjvKGBzHSw92Cb8dRxA336/W9atQuQGkdFFdqZZBbjoQ5eIWf6q2FxHhOSpgnYk9FmiThoB/o4UN0i4Aq5+zQZn/uCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5icJcCVlm7hsiXZnv02+mr+7vGBYLnRduwa8IyP5jw=;
 b=XG69ueZyJYC7tZWV2g75joJ8VGT2KHRS5Kcjrep8GArUedlLJOFhmFbTalOCT/W3LB+qhKjny4u9u1sBtrv+dEjMRRV6B9ud9M0N9q2hKF1apnnC4HlwD9s63fJ4kXdguxUNJZ3s7S14AzuRaXYPGHa58ZEGxJrDwYcAQgQcr3CswQvOpT572UmKpGR2mrvpUESO9E9z2qdv2P7kuwD13KrUV6M6j9To8hs3kvA7mPsBpfBPq1WAB9dnOD4Jm+qm0fYBFw1tVgEy1DRy9ecABX+anPqAPQmR88juvN/6WzaCqi5zthh9iM+l7Z55RdDAVgbY2JfgC58IM4T/86/xJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5icJcCVlm7hsiXZnv02+mr+7vGBYLnRduwa8IyP5jw=;
 b=YVrY9fDY8n1YAWL5tKgz8lwbGxmpUMjqnsQ5tCkLaKSRLZv1uhjPkTnyCZ/A0rn46VbNQGiC7k1MdpbbdAGHZ2QkfL9QorfLMBa1bi9uo2mbAwDJrtQxi/ce2WWIP+D9Oz4vFYSoS9atQihdGlOonyL3JwuQvG9R++fovW2pMRo=
Received: from MN2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:208:1a0::30)
 by DM3PPF59D9BB966.namprd10.prod.outlook.com (2603:10b6:f:fc00::c29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 18:14:55 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::96) by MN2PR07CA0020.outlook.office365.com
 (2603:10b6:208:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 18:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 18:14:54 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:14:52 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:14:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 13:14:52 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BIEmAq2405413;
 Thu, 11 Jun 2026 13:14:49 -0500
Message-ID: <c329501b-ae4a-4fd1-8fb3-0489a7f269a4@ti.com>
Date: Thu, 11 Jun 2026 23:44:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
To: Markus Schneider-Pargmann <msp@baylibre.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM3PPF59D9BB966:EE_
X-MS-Office365-Filtering-Correlation-Id: 237be8a2-283b-4c37-f39a-08dec7e556b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|3023799007|22082099003|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: guryc9fUlb2Wd5eIjYuu0e5ip/Dilp1NNN8Vh11jNhgadsc1nCnB+iurm7bmG7fsVNDlLOMBsBzOyan3hKqh6UQfKE1PcIL0HYBoEpmaVqCta7yoWzDEMq+TkhpVEbm36VmcfS/k3qxehGfGeQUpHi5sUv2vpV3/3ImyhpXK8a5qBSfJgagYry755vFUODe1y2fHwrlDuVQ0I+7hMYS+Vwt/4xtuMjWlDIY/sToypk4EuojWXeMCvED3sBF1736AGrWIuXt3iguqMYFULgNj0xErmR9HkYeM+EvXqH5S5y0SrzqW3aYU+kgHv/FYIZuqowoct53NlCWOSUAwgebn3XDEc1g2dH4PMM8DShX2SIwm+o+E5W5dU5LvPhrA3TuTNpI1XWESwAaOhkL/r7/BOAlXnaeb6X8rVhA66EcrAJ5KjBP21w+Cu51ILLkeQTL52ucpPJp73GYU9dZ6OQDJI+5+WcG2m2sOiRso3d0gdOoR0OwkYd49j5uyYGIFPhnv233X1KZPpy7oHVocFIRwyfpRknQcI8NVsOX1vcNW2gm6JzxguadcSZp/znZSZGEGmTSwSJ5TbadhznF+LCtRqBNGs+0UEWQ1Y3YzniNmVELq77zsNCI+CGytywoPRvkEmIj2dkrxw1+wiUmerFIwrwvyUKJpl2QApz9UynDAFN/0Q4Rqypdzj5QE2OVuImKjs1cZlRq7HASC8frM3o8e7dXD9jqA5hCWXMGGPU0pIu8=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(3023799007)(22082099003)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I466SrZ2D0yQAayc6wOMJZ83n6CBuY8pEEWUNtsjdEsfuTVOEm2lKKR0JuDQVdlwEzus+nusJ7DVKC3Eo5wx6ctME4jmAV/VVqDayw2ufKsEt+bpGK7rTiMIN1YktFZnzVWVZJBwuXagkstJ8ZXum+6LAA30tmAiFiieozCBF7gY9V21yp7jyu29uy3JGBkls0qHQfsVXndcbEwPiGbkdyvu0OU0ItM7b/aEgsoMTm7TxqAzPexMOOSXPHQ81LtgsvE1bseIUCoWw+kc4UUYY7qy1iniJH9L62eyl00nqV8I3YJloY8mO6MdmTZQXrt3R9+TnP0sRG2zl8ob/VUD3OGp8Hz1PVenzipKkamLQs/bjqgbYflIxjWltChaFRdZFtQ0TxPQNavWiJujgUL70rN9IcM63uYTn5ne+tnBTkD/zgsn8DtVBfkDH4WllGH1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:14:54.8386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237be8a2-283b-4c37-f39a-08dec7e556b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF59D9BB966
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

Hi Markus,

Btw Had a quick look at series

https://lore.kernel.org/all/20260609-topic-am62a-ioddr-dt-v6-19-v6-0-16afba97fbe0@baylibre.com/

I did not know this problem was for other devices too.


On 10/06/26 13:42, Markus Schneider-Pargmann wrote:
> Hi Paresh,
>
> On Tue Jun 9, 2026 at 8:10 PM CEST, Paresh Bhagat wrote:
>> This patch series addresses DM firmware reserved memory fixup for AM62a
>> and AM62d:
>>
>> 1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups to
>>     be applied before passing dtb to kernel.
>>
>> 2. DM firmware reserved memory region is insufficient to accommodate the
>>     binary. Analysis of the DM firmware binary using objdump reveals that
>>     the resource_table section and .stack section occupies memory from
>>     0x9c900000 to 0x9e608000. So increase the reserved region size from
>>     0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.
> I am wondering why you chose 0x1f00000 and not 0x1d08000?
>
> Also for am62a the firmware linker file says it is shorter:
>      /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
>      DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B5B000
>
>      https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm-clang/linker.cmd#L175
>
> I am wondering what is correct, the linker file or the objdump you did?


Yes apart from the objdump output I noticed a gap between end of 
wkup_r5fss0_core0_memory_region and start of secure_ddr. So intention to 
fix the bug and use all of the available space.


>
>> 3. The existing fdt_fixup_reserved_memory() used a delete/recreate
>>     approach which corrupted phandle references to DM node, causing DM
>>     initialization failures. Fixed it by updating nodes in-place using
>>     fdt_setprop() to preserve original phandles.
> I haven't looked at the code yet, why do you use a fixup instead of
> fixing the devicetree?
>
> Best
> Markus


I had a discussion with bryan regarding the device tree fix approach. He 
pointed out that firmware and kernel versions can be updated 
independently which can lead to unused reserved memory. So bootloaders 
should dynamically update the reserved memory based on firmware 
requirements before handing off to kernel.
I will let Bryan and Andrew share more on device tree vs using fdt fixup 
approach.


Thanks,
Paresh
>
>> This patch will need the dts to be updated for both AM62a and AM62d i.e.
>> rename wkup_r5fss0_core0_memory_region node from "memory@9c900000" to
>> "dm@9c900000".
>>
>> Boot logs
>> https://gist.github.com/paresh-bhagat/e64523fe5134a02754fdbdaff864fcd1
>> https://gist.github.com/paresh-bhagat/b578d602010db09d62d2be3b2709fc5a
>>
>> Paresh Bhagat (4):
>>    arm: mach-k3: Fix phandle corruption in fdt fixup
>>    arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
>>    arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
>>    arm: mach-k3: Add DM reserved memory fixup
>>
>>   arch/arm/mach-k3/Kconfig        | 16 ++++++++++++++++
>>   arch/arm/mach-k3/am62ax/Kconfig |  1 +
>>   arch/arm/mach-k3/common_fdt.c   | 34 +++++++++++++++++++++++----------
>>   3 files changed, 41 insertions(+), 10 deletions(-)
