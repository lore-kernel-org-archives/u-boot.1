Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E989CCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 05:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C4A83AB4;
	Wed, 12 Nov 2025 06:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TDmZQtr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEE983C0B; Wed, 12 Nov 2025 06:38:34 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B91E83AAD
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 06:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAf0UlNAaKzM23xOlWd7pSdDxxEUJ4LMPAbJekr5m/gg1fa90hUELJSiyQwHx8919e/DaJzTFFxwVAUVBap/qEmX1ILs46c08E09GXOxTlFyp+hHDCHPkw4bG2RLASshzu0aZX+F2e2P6okvZ7eDK5/GhTEZ6bbri3XLqYQc04AjWr6kagUzBUnzEoaMc25oFMWp1t036NM0x5D+4yOxfoDXcIhfVam5denN9AksbcbmFsE7awwDM5BgYwpFSM71U91p7rljmV+1B6+8nm0GOL1mHyG5gSmQjvgYZuYBrEWrwd8k5hHVpC94FWR4lTgH+bO74TRze7SoJh7uc75f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEZxqIrEer/cOfO9LwLVeNbPmxFMOliAd+tLwWrgI1I=;
 b=qLXjve2Q4lKJ/IL2DTX1Ey0AefWyHZKB49/bs2wubN+8pXSC2sX9+Xr0xn+qFlB0BXSSgk/yMdbVb0GjgNGqFH+8CVLhi121Iq8sCAYZYkZ2AsdSI+u2XIWazFcWO6zp5Q+nyUl+aZWXWicbdfmbLkYKFGTQYonC95KwJi9TwfNJhu7R5ZxBkYamT8LnL195POp/jzRGWaRMZ3TPpxjqNtj4FFmVr3elQMVfYobNSgTDVe95S08WzcZH0EJQY66nh3m9RxVRMsGRYJYmm31WeO2GCyl3428ZgU1R8DME0Zwy2ynni+osS1hq+d4s+ZfbPrUVE/LLHXiYAf9Pv+SBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEZxqIrEer/cOfO9LwLVeNbPmxFMOliAd+tLwWrgI1I=;
 b=TDmZQtr01NMwTygGvdTN3JkGu1uTgUDEUsoTPbjtl7b5v1c6Mt6LhIcW8L8qaNYeSiwwzKHjXO8IZ0aMeqgFeNteGzMO8Jvjthgq7U5ZhJlm4LaNYKkYzz7+4Xg++5OyUCYUJ61yUB0vOGb6BZV2ysRSrLTZbfrOEZ000AX/SQk=
Received: from CYZPR19CA0005.namprd19.prod.outlook.com (2603:10b6:930:8e::26)
 by IA1PR10MB7141.namprd10.prod.outlook.com (2603:10b6:208:3fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 05:38:29 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::8f) by CYZPR19CA0005.outlook.office365.com
 (2603:10b6:930:8e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 05:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 05:38:27 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:38:22 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:38:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 23:38:22 -0600
Received: from [172.24.26.46] (lt5cd2489kgj.dhcp.ti.com [172.24.26.46])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC5cIu32161332;
 Tue, 11 Nov 2025 23:38:18 -0600
Message-ID: <95c8d3a5-7332-4af0-9ba6-2e63e027da99@ti.com>
Date: Wed, 12 Nov 2025 11:08:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] arm: k3: j784s4: Add PCIe boot support
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <c-vankar@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <u-kumar1@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: f309f48f-ac8d-4778-f51f-08de21adb492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGlzTHhVaUJ0MFpnMXNtNVYwRHlwZVRlTFlYVXZDMXRaV2FxSEY3bWFlUUF5?=
 =?utf-8?B?SnZpWFBhdlVUZDhLYUpYSVdxR1Z3Q05qVUpPb3l6V2JsaCtPUFJXNm9oakxa?=
 =?utf-8?B?dkUzaXVqUEpkbzdvSi9GWjAyeGZXYjRSbVFUc2trUzYzRStMKzVIRW5oOHNz?=
 =?utf-8?B?aVBsWERjYmx1YzkrV0gwNzUyelY1c3dEb0lsSkcrZWM0anNONGJvVjlvNVUw?=
 =?utf-8?B?QVlldlBZR3RNZFlsT0lzNWJCUGxycUdPOUU0UXdML21MWlI0bmhab2w0OU0y?=
 =?utf-8?B?YmZzZ1BISE90UUVSTE55S1haV2lud3NxYjVZdG5Wcm02VjIvdnY1dEJwcndD?=
 =?utf-8?B?VUJwQW4xNC9MdzBFS0dpRGJzVnc1K1BUditaODJzaFFEYU5jcGlDVkNpMHpy?=
 =?utf-8?B?UmgxVHNUQWpGZlFTOTZBeW1sSmNlMGQvejZzd2dlOWcvWXVpeCtvbktqOTlH?=
 =?utf-8?B?dGVLRGI4WHNzUFcwOGZNYTJleHM0YTU4V1E3cW9iUDRHcFZyQ0JZZzFRZUZk?=
 =?utf-8?B?YnArekFueXFGWW9LYnA2WStJRE5icmgvWjJQdW84Q1k5Wm5YZzJFTW5TMkUw?=
 =?utf-8?B?MDV1Y0hmMGhaQUp1RHhnaVU5NUN3YXNCQ0t3dDhEaENEL2VwV3VBS2FVMk5C?=
 =?utf-8?B?b2VraXFxelNlNEQ5YWVjZm91ZmZPRE5jN3VpWUVURTgyYXFCTnBtYmk4Z0d1?=
 =?utf-8?B?ZTRENHdHaklhZ2t3VXdGL0NUM1pnYjBSWXdLN3R2U1NXTTdsL21PUXR4bEN1?=
 =?utf-8?B?N2FiRGFvclNMUEJ2SEhHMDU4L0pRZG1hYzFzUlhQbUhGeExtYzhXVFhkNXIz?=
 =?utf-8?B?SC9LZ3NOTExxcm5LZTJuaWxQa1JRL2VqWG5vSDRmaEZsTi9JRUVlM1VMT0xl?=
 =?utf-8?B?bEt3KzQ5bERrOGREZEhxT1VzTVlzZWludGVndkpFY01mcEN0MGh2Y3hMR09a?=
 =?utf-8?B?ZFdjVHZidXdwYmNCclM1VDY1ZzY0cnlCMWRhaWVVR1RiN3pFOTNEY281WjZ4?=
 =?utf-8?B?MEFNSTJVekpVcWpsaTM2Q0dNSmdZSTV5Vk1JQWV3MU8zcXZZMkVBcXV6N1Yz?=
 =?utf-8?B?QUZ3bjNwdlBFQnFtTURzMnZBemthWWFoVytXVk5Vb0Z3MFpZeExvY25kMmRF?=
 =?utf-8?B?b014ZCtXUGVlbWZYV3crcGVzUmo3MkVKSVUyNHhyeEMxTm9yeGVxN1pRVU1X?=
 =?utf-8?B?VXlOZ1BZTmxEWGtzZ2xQTjdXeE1NZFozMWFSVzQxb0tSRmxkWWZzY2VBalBE?=
 =?utf-8?B?U0QrNXQwRDZORzdXTjVHazdyQzJFQkZaczJJMFYyVXdGOFdYN0lLZ1BpQjlm?=
 =?utf-8?B?WGlYTlFJeEkxS1JWWHp0NUh3MEhCOFVOakdVQTdXdGVGQzUxRlBXdEFLQVdI?=
 =?utf-8?B?QUo4QXZPdXhFRkt2NXo2KzdKbnpDb3ZxY1hERUlVT0dHME9FeWtWTW80NVRn?=
 =?utf-8?B?Y2ExRUpnWVlnNUJDczQ5dG9sNTZYZnlyeDBEa0F5UUExVlpCcnRhOFcycDJV?=
 =?utf-8?B?cTJVcFVpWHIyc21FbDI1Z2N6TzFMbDQrcCtpN0xGaFZCdDdydXdYa3dKYVpt?=
 =?utf-8?B?UUlKQlg0ZGhSbDZZQW16UGttTEFOT1V3bGxvTlZMczk2M2VNZDZjZ01LYU1Q?=
 =?utf-8?B?UGNkK0lPVmxIY2FXWVdBdFMzZndLNDM5TkJRZWkwUUhSQnZpNVhlQjdJTU44?=
 =?utf-8?B?MG1PL2h2cWk5Nng1cEhJUkpXeG8ycVNwM2Z5VVpQb09nTzdpMmRsSVVrOTNH?=
 =?utf-8?B?YTIwQXhHL1hlNjZ4dnVxL0pOYWY5UEc0cUdBeDdtd05wMVJwMWtGY3dGb3Za?=
 =?utf-8?B?MjF4V1VqWVgzcFpqRU9ubkVuWEhyZXF4TUNEVnBGdHJvdkM3UFloTWlMQnho?=
 =?utf-8?B?cklYeDdURkkrTWR1bG9Ca085MFU4WlYwYXZaUXJUdGovUTZHdXlSQXdQdjVF?=
 =?utf-8?B?V3RYMmF3V0dYbmFvK2twZTdNRlZlVzdhaWRJU0FUNGMwQXpRKzgxemkvSm1C?=
 =?utf-8?B?NjRycW15TzdWWDZkdWtJb0Zpb1c2Uks1emExOTArSG45WGJpaElwbUJBK3NO?=
 =?utf-8?Q?XzF7hL?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 05:38:27.5346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f309f48f-ac8d-4778-f51f-08de21adb492
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7141
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


On 11/11/2025 11:46 AM, Hrushikesh Salunke wrote:
> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
>
> PCIe boot allows the device to boot as a PCIe endpoint, where the
> bootloader images are loaded by a PCIe host through Device Firmware
> Upgrade (DFU) over PCIe.
>
> The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
> To enable this functionality, the SERDES and PCIe peripherals must be
> configured early in the R5 SPL stage before the bootloader images can
> be transferred from the host.
>
> This series:
> 1. Adds the required clock and device data for SERDES0 and PCIe1
> 2. Enables Cadence Torrent PHY driver at SPL stage
> 3. Enables J721E WIZ SERDES wrapper driver at SPL stage
> 4. Enables PCIe boot configs for R5 and A72 stage

I assume you might have changed device tree to PCIEe EP,

I suggest , adding this in J784s4 board doc. (If any changes are done to 
test this feature and not part of this series)


>
> This feature has been tested on J784S4 EVM. Following are the logs
> corresponding to this feature.
>
> https://gist.github.com/hrushikesh221/cf48b512eb4cd90c1612ad2e531b8ffe
>
> Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
>
> https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c
>
> This series is based on commit :
> 6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh
>
> Changes in v2:
> - Fixed SPDX license identifier to use "GPL-2.0-or-later" instead of "GPL-2.0+"
>    in clk-data.c and dev-data.c
> - Changed SPL_PHY_CADENCE_TORRENT config type from "tristate" to "bool"
> - Changed SPL_PHY_J721E_WIZ config type from "tristate" to "bool"
>
> Hrushikesh Salunke (5):
>    arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
>    phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
>    phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
>    configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
>    configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot
>
>   arch/arm/mach-k3/r5/j784s4/clk-data.c | 209 +++++++++++++++++++++++++-
>   arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++---
>   configs/j784s4_evm_a72_defconfig      |   7 +
>   configs/j784s4_evm_r5_defconfig       |  13 ++
>   drivers/phy/cadence/Kconfig           |   7 +
>   drivers/phy/ti/Kconfig                |  10 ++
>   6 files changed, 262 insertions(+), 27 deletions(-)
>
