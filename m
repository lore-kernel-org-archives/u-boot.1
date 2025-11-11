Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A8ACCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8CB583AB4;
	Tue, 11 Nov 2025 07:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cJzN4+O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B45383AF6; Tue, 11 Nov 2025 07:22:43 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1519483A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2nl4ymBbZm28agCF406z6BoNcyhycDUv2fRGhOhaGoINqeJ1QGvScyYDMOMZMezaHgHIdZ19Wn76ov4mpQUdPuzYrKY2k+4tR0Bi4bh8N3fjQHvavD5/E+Eh93j4T5GpJ6S+ob8NgD4pBu8tBItP/S+lULfLM2cHkn86V6cKAeTJq6WXVNgGTRzXDt4nR/5ItAD+9RtCsa1P1w0OHe21OSipn9H7EwWhSr4p0rfpl+7eU1TZXbYexWA3ZIGcwYTvMsixMioMNaQlvocwu/BEsoTd05vSfPqGPcILZkSMqxf7Xpzzvf4OBDp7y6H3faHmlyEsEYeeVP5vuxLpcBr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptfdfEvvo1HfbJnsRavwfBPo6rUmNAtvDLIjTsoO5m8=;
 b=W3LQnH8cvWS5CfcDe6PDkrclBYcw2hh2Or13g0Pe4eB21O6j0ZB0Ca4S3Y4Qe+7rJiMB6bHs+vgAfs5PXoH+NBWVNiayXLCddOT1HkrlO0ZFrYTUpfNidLJzSXlPoyOrdhjBm8PC/cUFk5X21ZuHwYWFhCoExYfEK1IEv80sULTpGCC+UKyhy1ERegwLT25VERDiAVNJKjPdfn/IQdZiAhy4OhDQRu7hVTveeSq89kIiVxyvJCesVbRhqGyp+/geEWnpa7DM21qUrDduKJtSH4P5DwRNO2mIFzsoVMpEak3tBy/srlsueeiRCbgIrYXkhNdabBGopcELXYZ+unzD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptfdfEvvo1HfbJnsRavwfBPo6rUmNAtvDLIjTsoO5m8=;
 b=cJzN4+O3pfRFcJuRK5LqiVqEuAwMl+7kc9seWu50k5BAT51YR0bpdMKb9M5Cv8lnEGLClfueVIRnqH0oxFwf/CWLBySzq8wVPTfugzcNZIvohJzzKlVceQxhZPZYlvVobB1hdebouvQ6qh3dvgk4Kw7Nj5k1Zy+S24QMEIYxIcg=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 06:22:37 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::a0) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 06:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:22:35 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:22:25 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:22:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:22:23 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6MM60457229;
 Tue, 11 Nov 2025 00:22:23 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Nov 2025 11:52:22 +0530
Message-ID: <DE5NDW3OC26M.16ZWOENW17GM@ti.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>
Subject: Re: [PATCH v2 0/5] arm: k3: j784s4: Add PCIe boot support
From: Anshul Dalal <anshuld@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <a-nandan@ti.com>, <c-vankar@ti.com>, <u-kumar1@ti.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>, <peng.fan@nxp.com>,
 <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <ahalaney@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251111061645.1004382-1-h-salunke@ti.com>
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: e387336e-2c63-4f6a-c9a1-08de20eab48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm5qVlIzYTlZaWM1OWFUSjVjSmxZT080SHBnbUtjY0RmZFhKQzdVd3FLOWFY?=
 =?utf-8?B?MzZkTG1NZGdmUmdkV0h5SW1UQnY2ZitJa0RIMWt5bllGTEdaMzFYTTRCaGIy?=
 =?utf-8?B?VU1MRVYybWhCZmoxZ2xkampIUjd2M2pkVDhSWGtYT0NPQkpBRzNjYVpvRGZQ?=
 =?utf-8?B?dit6MFU2aENkRDh3MWsxVElNUWdGS2Zzd1RRbGcvTGp5M0k1STBjem95Zi9G?=
 =?utf-8?B?T1JEeThodVluZmgvMGpZdkN0SHVJTTh2Q2JIRkVxSWRHdEFyc2Q4Vi9NS3lZ?=
 =?utf-8?B?WURRQTh0dm8xRTVCM3l0L2VuRzZ1bnA5eG9qVllEVnFLRGdyR3JJcmV4K09Q?=
 =?utf-8?B?ZTlabDVmK0JoZm95YzA1VFplZG9maWRyV2xvckxJNFFCc2xncjJ2eHBwc2Z0?=
 =?utf-8?B?dE9FNjdvclg2YkNZZEJXSjdVQmlMMUVSUGg5VkJHY09vTXRRZ2d5OVlqTHJR?=
 =?utf-8?B?SjMyd0ZsQzd6bUFzVmRpaUdsUkRqWmh0Q2dMUE4wRHFUTlRiYlc1SkpGUVBF?=
 =?utf-8?B?VUFsSjFud2xFaEV2R0daN0h1L0dHL1k1RFQ1UXV0SjduUVp2WkllZkYxRVNJ?=
 =?utf-8?B?WnpYckxnaFpaMks0ajU5Q2ZMMzJWWXc5WlBOQXkxSTAvQk5SM2ZIblI2cXQr?=
 =?utf-8?B?VWNBUmFmSjhFTmM2MGRsQXRnQVhWTEdLdW5sL2tzVGcxQzZNYm9GSXlycSsz?=
 =?utf-8?B?N1BuZndoWlNnTS93ZVhmclNGay94US9HMWhTbldXKytTWlo0WXIyMVZ2dktZ?=
 =?utf-8?B?MEU4NTYrSW9td3NySTNmVjI3YXVuYjMrc3JWNkpGMmxVWHU1cHdyUXN5cjdU?=
 =?utf-8?B?clVDZ0psL2ZKMmM0MVNybnJ4dCtZUDA4T2ZEMDBpZmx0ZyswdHRxQ09UZk9J?=
 =?utf-8?B?WVJ2ajRqSjBLT0h3RUgwdlY1dU1mTVc4MW5HY3JZeHNxWGl3bFBBamtqSHVa?=
 =?utf-8?B?SGNzcUpUdTVVbHdqeUcwdnpzTHhWbTNmL0Y0R1Zwd1V1WWQ3SHlpeVZMb1lx?=
 =?utf-8?B?WllzSW1ISmJjWC9FZzlpRVI1dll3QndXbUxwTW9Zby95c2NOclV3ZTJkaEtk?=
 =?utf-8?B?VEdFcko2UUVMclhxTmNiSXkrVXJGZEtic1ZHTExMNWw1OXg2TDBBbVRZdTUy?=
 =?utf-8?B?MmRKUFhYVnpCRGpLMUVIcDFnYnRVVEZ1NjJ5QTdCaWVzUXdIMS8zNjU1cUhG?=
 =?utf-8?B?MlUyK3BXZzFpeEZ6bmJsazZxVW8zaERCcDExV1dZZm9wZS9TaktVNHRFNWUr?=
 =?utf-8?B?L0hQOERENDVmR3RJblBZRXIvTXlpc2RxR1lyOTZzN1J2TkNLZ2N2d2U3cjI2?=
 =?utf-8?B?T3pEUUZLcWU3YUpIMnBSaEd3dEVyS29IR1Bwc0hqWmdpU3pBdUROQkV2K2pL?=
 =?utf-8?B?Y1FhOWlEbE4vT1hnaWFqOFNpR29ZTDdIUVBzQlhnUTF6Q2habDZaVGYyMmxP?=
 =?utf-8?B?c0R1NlF0SE1XcWx5SUhwdGN0eTN0a1lOMWNVaGRkdVhrUGczMzdScUFiWGVy?=
 =?utf-8?B?MXNDNnhUMFErSFBnbmk0SnVrT3dWNmJFWHljcVFNNUU0RmlocG5tV0JjVzI5?=
 =?utf-8?B?VklSTFV5dnJGSThla05LY09uNnpqWEo0R3d2Q3htMmxRUms5eHJFZko1ajRV?=
 =?utf-8?B?SmZacTlJMTgwamFDRnFQQlUycTBsYjJuaHppcTd2V2tFYmZIT0pEdzRaS1Zm?=
 =?utf-8?B?VFZDNmhsVDNPdEZzZy9lMXBhd1BaT3U4QWt6WnBUYTVlT2JUcUdPWFV4MjRo?=
 =?utf-8?B?RzQyM3JaNXk2aDhTRS9YbkFVa0ZpclhGL1NrWkdxYVZkZG1pUlhBdEFPYXBU?=
 =?utf-8?B?TUdxcXlzMlBOZk9CSEI4d2c5TWovL0tkbFpGRmhZSHRyZHZZVU8zYkhMNmNm?=
 =?utf-8?B?TDdGSVFXK21oNjZGQUlvSVRUOHBaRGpDU041Y0o2T0dIOTkwVFFRSEhqL0RU?=
 =?utf-8?B?aWVRbGUremlubFpjbmpNTWFBVXZkRy9lSXhFTTAyWGJ4YXdiYi9Ta2paT25I?=
 =?utf-8?B?WG1ieTdqU3R1UWlHN1AvVTFqM2JPS0Q2bWdXM25zV1RpN1JGS21MT3VsOUts?=
 =?utf-8?Q?IEfGkV?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:22:35.5592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e387336e-2c63-4f6a-c9a1-08de20eab48e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
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

On Tue Nov 11, 2025 at 11:46 AM IST, Hrushikesh Salunke wrote:
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
> 6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/custod=
ians/u-boot-sh
>
> Changes in v2:
> - Fixed SPDX license identifier to use "GPL-2.0-or-later" instead of "GPL=
-2.0+"
>   in clk-data.c and dev-data.c
> - Changed SPL_PHY_CADENCE_TORRENT config type from "tristate" to "bool"
> - Changed SPL_PHY_J721E_WIZ config type from "tristate" to "bool"
>
> Hrushikesh Salunke (5):
>   arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
>   phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
>   phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
>   configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
>   configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot
>
>  arch/arm/mach-k3/r5/j784s4/clk-data.c | 209 +++++++++++++++++++++++++-
>  arch/arm/mach-k3/r5/j784s4/dev-data.c |  43 +++---
>  configs/j784s4_evm_a72_defconfig      |   7 +
>  configs/j784s4_evm_r5_defconfig       |  13 ++
>  drivers/phy/cadence/Kconfig           |   7 +
>  drivers/phy/ti/Kconfig                |  10 ++
>  6 files changed, 262 insertions(+), 27 deletions(-)

Acked-by: Anshul Dalal <anshuld@ti.com>

Regards,
Anshul
