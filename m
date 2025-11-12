Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B4CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 06:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13FA83C08;
	Wed, 12 Nov 2025 07:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U+W3ArPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8ED83C13; Wed, 12 Nov 2025 07:00:16 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C90B83AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpndbiWd8KeRicVBaOEy8yEO4fa4Bpfe8HRWqrn4MgitWe9+mgZ+L1fwDgTGChCk+4ODNkMUrpdIRF3/EQgrLAkiETXxHGU+pmiPc0f5IwNQVot3l4+T3HAvbLB+gwZYdvO9YsgKrFOQ5U3mqOSiu1P3fVvxjCheNHiw2tBNl5OYW2l8oraapytG0kQ76SPL4Zo4DGyBDr5pYvjL7x+z/o0Ix3swjKbqlR6GM7Wbe2e51gPkWTfxmxVV0wjnbQARm/RiTPz+SSCq+HZZAiD2xGFN6D1USLowvDB+uE+3qVduxkobp6V1rhf2mSR7Vo1wNeEo/f43+kjqjPn+4xo8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLkUQdAd5Xb989osXnyfmdYKIRb/w4J6gUZ46bguCdI=;
 b=kVzT6zjOYK6b/wVpdZJn+y107cINFuEYmM5WR7B6RByMZ7WpoS6xlvn9/2zzj7g91bObkfJvNu2FUDhvcI7U/IfPubLs38JnmfM8moUYXjynR8Uu9GFs25ryk806r5xBL4SRlH8bobq0C/VzQg1JxN6FXUzDY8ZTrztH/oB/HXzOOkpwVBrTbV+lng41eYri4MYpWFIVBHMD3Ewvfzux1sXKON1WKNGoistqv9qB8lDlJ58KvOkwDrQNVy26xBf1qKmFslMG0FbSHfaV+U0/7z88hrBdU5GAXHu8SVbyF1rkEhcc369DKyueLfpJJqmVi7ZM+84tD1kMtr2J05EyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLkUQdAd5Xb989osXnyfmdYKIRb/w4J6gUZ46bguCdI=;
 b=U+W3ArPOspwC+zdZ+fa114EQbcZrhIS7yQEqf2yHtY5QAgWzFgiv7vrmDZdVllM8syFgAWe5xJYJGNQQH3l/uOM8kf8NM71gme5uJtNjPO7UhjIQZdhoQ28xhMCIqbiNe1JXvCYyleS4bCD4QLkxLpKrzO7wTpyWPsoEnrfcdOQ=
Received: from SN6PR08CA0017.namprd08.prod.outlook.com (2603:10b6:805:66::30)
 by PH0PR10MB4552.namprd10.prod.outlook.com (2603:10b6:510:42::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:00:10 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::9f) by SN6PR08CA0017.outlook.office365.com
 (2603:10b6:805:66::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 06:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 06:00:10 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:00:04 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 00:00:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 00:00:03 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC5xxtt2152614;
 Wed, 12 Nov 2025 00:00:00 -0600
Message-ID: <d0d1b04c-db93-4b2f-9f9e-96dba4622363@ti.com>
Date: Wed, 12 Nov 2025 11:29:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] arm: k3: j784s4: Add PCIe boot support
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <c-vankar@ti.com>, 
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>, 
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
 <95c8d3a5-7332-4af0-9ba6-2e63e027da99@ti.com>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <95c8d3a5-7332-4af0-9ba6-2e63e027da99@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH0PR10MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 880889f8-2536-4420-1fcc-08de21b0bd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTN0czBoNXlwQWt6OTh3YmVGZnd0TkdrYkQxc0VsQktoVDJDUDVTWkJDd09D?=
 =?utf-8?B?K0thbFRRamcydEVXNUUwQlJ1UitmRUVRS2xvTkJFOXJINkNPb2xMemQzaXNC?=
 =?utf-8?B?WXlad0RiZ1F6ZGFmSWpEM25jWWxyQThWNjdzdkx4Uy9UYzNDR1NTd05uYVNJ?=
 =?utf-8?B?dUNhRjdBWGlTb1pZWFVSbVVLYnBBblpsNmFycDIvaUVNNVk0RGZ4eUYvN1pq?=
 =?utf-8?B?MXNyZTdlSzIyL1dBUEZOZmE3dm9ZYkdPdXgxWEJJOHgxQm1LanZRYVZZaUVD?=
 =?utf-8?B?ZlRLTzJjcDBndCtrdWl3WTNWZmh4NU4xRUt2TUR5WmJQcEFJUkl3YWE0SWZh?=
 =?utf-8?B?UEJWdzhJZGhvY2RsMitkTHlDRVMwTytmVzkrbGZSS0lxcjA1enFWVmxnM3RY?=
 =?utf-8?B?Wk9pMjZTbUlnK01sQVcwNTRoa3BNNWFEd3BYeHUray9BaGVVYzhyMTQyU21n?=
 =?utf-8?B?NUU3elJCdWw1cWdpeVkwZzdZQUloSU5rMjJML1RLUGZxSG80N21VUnBhTHg4?=
 =?utf-8?B?K05OVjk5UjZ0WFlEVnlZNDRDMGx4cGlwSnQ5TGlTZmhvd2h5K2xTZG9CWFpq?=
 =?utf-8?B?NVJJWWVFMytrNTZHbEZRY0Y2VmtlMFo0azhzTHB6RGVTOE16MEFrUitNZnhs?=
 =?utf-8?B?eWpXTVBoTTU3RVVzTlVYSkowOXd4aU5uM1RKTjNlanpTb3FLQ0tMU0hHUGls?=
 =?utf-8?B?Qnl3SDNBelVySmZpWGtiOS90NC9lKzQzbHZ2V084eW9VTlJsMjMyYldNNERM?=
 =?utf-8?B?UEVoQ1VJRFlJZ09XZTkya09iSnk1SlBnSFlLcXZmSGVGKzdrWkQyeGRTbDhR?=
 =?utf-8?B?QjlZQnJ5aTNaSUQvckFKTVQ3a0RnaDNObm1RUXJBdy9kTFFaZ0hEUDR0Tzdp?=
 =?utf-8?B?V25SSE56TXNWeitENWJRRkxTSmJmNEpTK0Q4ZVJvTFRHWUhXcUVhNU1lc2s3?=
 =?utf-8?B?NHhBbXBoRC9rZlF6VTVLNUhzVk9DWkR6cm4yWGc2dXBOMGhuMEFzeXRxVThz?=
 =?utf-8?B?YzRrK3QrU01kRWxiZiswWmlKc1E3Zis0U2RWTmQzT0o3QitJcFRQZG12Nk9a?=
 =?utf-8?B?dFRmcTJSdHAvekMyV0ZtaU54aThWQmUwbXV0NGVvdkVkS1BsU3duVC90R29T?=
 =?utf-8?B?bEF6WlNyNHBTbkEyMVdDb0NvYjBQdk5uZ250cHI2MmNCbmVBekdCUHg5S1lR?=
 =?utf-8?B?L2Z5NHp3VWh4eWh0TGRBSUYxL0I5cXE3L0V1ZzYvNkQ3b1VHK3k1cXI1Zldu?=
 =?utf-8?B?WmZGVVZLcXBYVzNPTnpwalNwRytueTBFaW1yRHQ1UDRlaSt1L2ZpTTV6OHZZ?=
 =?utf-8?B?dG5qVk1SVUdJNC9kN1owK0tqcnZiTzU2V1NWbkRSLzNETklGNHYyeHh2Vytu?=
 =?utf-8?B?QTlGSDVNSzVjZ01wT3VFdzI1THFKNXZwZjQrSG1JNVlSYVVrakViNWQ3RVJR?=
 =?utf-8?B?WTRxeWYzbVYxQ1JhZ2lLUGd2NVI0ZkV6QnpiVkxpczlQMnIwTmQvVWNPM3Ra?=
 =?utf-8?B?eG8vd0ZkSU5JV3B0ODl3M0RiekRHN0NRQU9pYndaRnVCaHoySVlzcENyMWxQ?=
 =?utf-8?B?L3RCT3AvVXZ2MmZ5Nk5YdTMzY0VBdE1xcWFqamQvcHorVDNNQjI4WlRDeHc1?=
 =?utf-8?B?Z0FaVHNZeGYrY2Y4NktPalc4UDRDUk5EUDJORnFHRThHZytQZ0dmZmhVOUoy?=
 =?utf-8?B?ekhaenFZOVNjVlVBODFpOXIzKzRiclQ2bXBuMitPSGpNR3pJaWd3aGt0MmJE?=
 =?utf-8?B?VVdBS3lQRlRYc2RuZ09FSlZDeHNFc0tmZTFGWnhaS09hRG9TSU5xNE1vcVkv?=
 =?utf-8?B?WHJJQWZPelFZVlk0cU95dnRuSTVtaE9hS3o4L3V6MlJTS2lXUnhmajN4ZWJa?=
 =?utf-8?B?YWJ2Q3NpbUU3dDNnUHUxY0pEK0JPUHRXbEJkQmdBTTdrZVVPYnNvWlpaeDg0?=
 =?utf-8?B?b1p3QWpVWGVWODVZMXd1N2JqNlpHV1QyUDZKMDkxMnk2dnE1MGJqR21RZmx5?=
 =?utf-8?B?OWFxdG1WcFNXSzFhVWd3OUZGTTVrRnZhcDZtbkwrbDNGaVJYdHZ0bVJrZmx6?=
 =?utf-8?Q?gCa7wY?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:00:10.5522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880889f8-2536-4420-1fcc-08de21b0bd3d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4552
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



On 12/11/25 11:08, Kumar, Udit wrote:
> 
> On 11/11/2025 11:46 AM, Hrushikesh Salunke wrote:
>> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
>>
>> PCIe boot allows the device to boot as a PCIe endpoint, where the
>> bootloader images are loaded by a PCIe host through Device Firmware
>> Upgrade (DFU) over PCIe.
>>
>> The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
>> To enable this functionality, the SERDES and PCIe peripherals must be
>> configured early in the R5 SPL stage before the bootloader images can
>> be transferred from the host.
>>
>> This series:
>> 1. Adds the required clock and device data for SERDES0 and PCIe1
>> 2. Enables Cadence Torrent PHY driver at SPL stage
>> 3. Enables J721E WIZ SERDES wrapper driver at SPL stage
>> 4. Enables PCIe boot configs for R5 and A72 stage
> 
> I assume you might have changed device tree to PCIEe EP,
> 
> I suggest , adding this in J784s4 board doc. (If any changes are done to 
> test this feature and not part of this series)
> 
> 

Yes it needs to be changed to PCIe EP. I am planning on
adding all the PCIe boot details to board doc.

Regards,
Hrushikesh.


>>
>> This feature has been tested on J784S4 EVM. Following are the logs
>> corresponding to this feature.
>>
>> https://gist.github.com/hrushikesh221/cf48b512eb4cd90c1612ad2e531b8ffe
>>
>> Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
>>
>> https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c
>>
>> This series is based on commit :
>> 6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/ 
>> custodians/u-boot-sh
>>
>> Changes in v2:
>> - Fixed SPDX license identifier to use "GPL-2.0-or-later" instead of 
>> "GPL-2.0+"
>>    in clk-data.c and dev-data.c
>> - Changed SPL_PHY_CADENCE_TORRENT config type from "tristate" to "bool"
>> - Changed SPL_PHY_J721E_WIZ config type from "tristate" to "bool"
>>
>> Hrushikesh Salunke (5):
>>    arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
>>    phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
>>    phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
>>    configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
>>    configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot
>>
>>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 209 +++++++++++++++++++++++++-
>>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++---
>>   configs/j784s4_evm_a72_defconfig      |   7 +
>>   configs/j784s4_evm_r5_defconfig       |  13 ++
>>   drivers/phy/cadence/Kconfig           |   7 +
>>   drivers/phy/ti/Kconfig                |  10 ++
>>   6 files changed, 262 insertions(+), 27 deletions(-)
>>

