Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC436C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFCD838CE;
	Mon,  5 Jan 2026 17:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aXhq4pnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6721780325; Mon,  5 Jan 2026 17:15:22 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A35A839DF
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEtO09gZgSPRT5Km2iUZkh+oAmQHWzSKubWYjSWVXIIy+DbQP2f631K8o6MD/kKtsK5K8fJOaaEGPTkxXAQ1L2i2Y6cCjraFwpssReumWLir8KTtYAbBdDgOEs0BEHhkymKph0bQoH784IiIOoySqxktG5UGibFblfg9YfcrMwB0VVLWQ8ZHQxWC7BUC+xm5fUDcJo7Sk9xjmEF6NOh6ygY+hHMqQRNWhjMpys+XsN+ptWg7dsl0egcLQpXU8Q7EdjgLf1PTcWeafEr8bWiN2Mp/PH3E5fAyilxvoxxr5EsMa923KMpMoed0J5pkMOW36luSntZSNjpCookVDP2heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijJ95qwGmoX7n3wCKHnvLg/ii6oyH7lLWFgaD5mpiAU=;
 b=R6tvhPYFMAn34ugmtUT0RORTbtmRr/qZe/lQgsxfR+3HgeFtmsmLBCUIePqIELt5v6T6Q5s0M1bRZJiFiSbqkv+YxqOj09SgIyb1IxLz+mx24wcnxxmELOl9yDc5mrz2v7nENHNPba93JkiJPLUec4wuymPQRDRc4AXY4jUFlKnJkM9Z3Sec1yQMbd/qbdircLrd4kLdjZnq8eaYa7wEc9wI8xYLstdECmS0vxHMmhEprvFwIPAYV5SE8zHDahY8UQ/DoraNyLek7w0GyNebMrUnN486Y+L03EK9DbZGUdbRh+4Br/yp6Hp87VSAQPTpV1Hit3oeUqwqrlDKkc7zRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijJ95qwGmoX7n3wCKHnvLg/ii6oyH7lLWFgaD5mpiAU=;
 b=aXhq4pnVfDGHPs0vcxlmzoPWI81YL/oNPEn5ORjHpV1dNcwY2kaUj2O0mcwRXom4cIJ9eDepysU4+X76QoedDYSy5v3bGFDmkjgcJt/5K3T3eBDeh+HJmMFTwv8hq9vAxHtm0oVL/iaGSWxd5Q/zuiG/765T8HOSuvqA225w27E=
Received: from BN9PR03CA0538.namprd03.prod.outlook.com (2603:10b6:408:131::33)
 by DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:15:14 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::8c) by BN9PR03CA0538.outlook.office365.com
 (2603:10b6:408:131::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 16:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Mon, 5 Jan 2026 16:15:12 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 10:15:10 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 10:15:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 10:15:10 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605GFAOK1550091;
 Mon, 5 Jan 2026 10:15:10 -0600
Message-ID: <90c90e57-5ec9-43e0-bcec-80db29516b70@ti.com>
Date: Mon, 5 Jan 2026 10:15:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] configs: am57xx_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251229051113.2136908-1-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251229051113.2136908-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: a504fe6e-715f-4df2-1998-08de4c759ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0tmRFpQcFVKME5tbSs3Y3lxUWUwdy9DbzhqY2pubURFZDI5S1pFUHlqem5Y?=
 =?utf-8?B?RkhVNmxwNm90TnlMcDJKY1RMenhGQ2xGaVhBRG8wcUErRGY5clZWMjM5UUlC?=
 =?utf-8?B?NWxvcFkyWXptZnE0U2hFa3A3SEp3UmxuKzdSZHJGUzZtaW4zMDh4ckxUQ0p6?=
 =?utf-8?B?Rll3Z2pyOFpiSzFpbDVCTEtpYndzeU5tN2dwTmpGQ2hhRlpWMkdzelNORENY?=
 =?utf-8?B?c2cyWTBtbzZNK2tYSkFWSDZiWXpFOGFabmxTR05xV0sybWZRTjdKUnFzN2t1?=
 =?utf-8?B?Y2h4amNCaGFzT0NScEE0MEQyMEw4VUNLQ3BHMW4wNTUweU11cXU1UmVycFJv?=
 =?utf-8?B?TGlZNFo5eWYrRzRPczBVakd3UjlRQ1BlWDQxU0FNaHc3ZTV4R3VPNktyVG5E?=
 =?utf-8?B?NlBWYXJ2bmdMM3oyVnV5dzhlRUF4ODJGVSszbUE3NTgzanZncUlsWW4wclFI?=
 =?utf-8?B?aUUvd3ZwWEF2MjNYdUVsaWV5RmtQSGsvZmg5WEUvcEZISkJGYjJreTRhc0t5?=
 =?utf-8?B?blBWM2Y2Sm90TlhTZGNzNFhBeitzRkJMQ0xDQldCbCs5UXJrTUJUWUdPdVor?=
 =?utf-8?B?VXdYVXloclRmTGlJamQrSUtkSDNWa1dwN3d4TFNBWnZrZmNVVWdvUmhWa1Vz?=
 =?utf-8?B?b1N0MlozajlHYm5nOHhBdFJDS3RrNVlOTDNoL3EwU1p0MGlGaGdGU3ZJbTJx?=
 =?utf-8?B?dkNsTXh6T3FuUmZHbS9QUTA3Y3pNd2ZqOTJsVCtuQlVCNGNFc1k1WUF5MUZj?=
 =?utf-8?B?MVpmN0EzbkxLTGdqRURnZXU4bmxDWncrSFhaWGxHc1ZUVTJnNHlrdk1KZ21l?=
 =?utf-8?B?ekJOOUxyVlp4WnNEMVdnZExBdjlkTHB4a1RjbloyamZpOFVxSStGdmsrLzdV?=
 =?utf-8?B?K2dmMzhTY3RWYlJWYXVzMVJyZmtvdEwvWTlxVU0wdzNFVFZUdjFJeHdhUE5C?=
 =?utf-8?B?WTlJaFA0V3pPaHIzVzhOMDlRU3h3TzJNL20yd05NWkdZdU5PWlJkOGVZcEJu?=
 =?utf-8?B?SVRiQ3VlOStwc0tUS2Ntemxack4xL0h0QlR4VjhkV2R3c0FqMDBWVG9FYTU3?=
 =?utf-8?B?N2c0VlY4cjE0Mm5pckxKbW1oeE5kRW9IRDVnTitNemcxSjRnT3NMT1REMmxO?=
 =?utf-8?B?Tnc0aEtjNkpwd21NbGtHNjJRSENXenAvV1MxRVBXbXlIWnl2U1FmQVpFcXFR?=
 =?utf-8?B?UkFEc0RhU2htTjZJMk9yUjNHS1RJL1dlajNlSS9JV3lhTTJ5aElVaWZPL2Iy?=
 =?utf-8?B?Wm42MnZYQ0JUTkluODhCMnpicCt4MHovNUhYeXVnZ1B5a0VTWmxwMGxlWFBw?=
 =?utf-8?B?akUxR0QzcHBOc3lXZFVrVkRGVWloY0NONHZodHZ2alRHS3MxQUs2SEpXbmly?=
 =?utf-8?B?RXNvanRaSEt1WlM3SWRIeVBsbW1JelV2c1JBNGJkVGxTaGlBdisyeFZYZ1Nm?=
 =?utf-8?B?RWxBYjFqZEFTeTd0clNWUjJWWVNsYzJGeEk4cVFqS0FxaDJVam1RZ3FaT3Ny?=
 =?utf-8?B?K0kyQmRkd1VDOUg4eDA3Mk90VjhIK0I3ZG5UODRiMkdOdTg4N2N2ZTNhZFN2?=
 =?utf-8?B?aGg1bGFPUVUySm5JQW1RampzU0NXUWY2MnVFVnRISVNoWWt6dnFQcUc3NWZ6?=
 =?utf-8?B?WVpJQzBrT1BadnRMMDUvc0FJRlBiN3VnOTBzRE8zTVFkQ0xyTWZPQVBnMDgw?=
 =?utf-8?B?WU5GajF1TGdDaVdkUzB5MXg0RjZOZlcza3l4N1hFWkdwc3krNzRxNVlUUWpp?=
 =?utf-8?B?ZzI4YUwycDMrNThRUk45eDVZcThlYmNLWlFSZDQ5QmZxT0RPcjQ3cUMxakw4?=
 =?utf-8?B?bnpQSC82cmNZbXNzYXRXTTJSVThraHZab1lXYU8zby82cHhQUkNvQ2YyaWJB?=
 =?utf-8?B?YzJOY3lKamN5REVWNkNzRHFYUVA5WmRNc054enBPTVozOWxKVTZKdDh1TSta?=
 =?utf-8?B?ank2WGFYa0FNdHcveXNZcWJGZ1hrY01nMlZESFMwWFFFMU9NNWsvMzlRMXNt?=
 =?utf-8?B?dmt6WjFmek5CUnNid3FmVzZVVUFueGdtS2NKMTZqZGVkVWR1VWlGeFBaaWpG?=
 =?utf-8?B?QWxXQXhlOHdlRGJSQldoK1ludU1sMEY4cXd0SnFRa29rbSt4TGVGVlNWTWQv?=
 =?utf-8?Q?zQl3wJdE41Pwrzhvxqbzocnyc?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:15:12.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a504fe6e-715f-4df2-1998-08de4c759ad2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
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

On 12/28/25 11:11 PM, Beleswar Padhi wrote:
> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
> top 37 MB is used by PPA and is firewalled. This results in an exception
> and the boot fails. Set CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB
> memory (aligned to 2MB as per page size for ARM32) to fix the boot.
> 
> Note: This limitation does not exist for other AM57x devices, but this
> config is applied in the common defconfig since adding a separate
> defconfig only for AM571x is not justified. Losing 38MB of memory at the
> bootloader stage on other devices is acceptable.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> Fix boot for TI AM571x HS EVM board
> 
> v3: Changelog:
> 1. Carry the changes in the common am57xx_hs_evm_defconfig file
> 
> Link to v2:
> https://lore.kernel.org/all/20251128150455.3279166-1-b-padhi@ti.com/
> 
> v2: Changelog:
> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
> memory node in DT as it is done by U-Boot as part of FDT fixups
> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
> 2. Add entry in MAINTAINERS for new config.
> 3. Update commit message to use memory size in MB than raw hex bytes
> 
> Link to v1:
> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
> 
> Test logs:
> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
> 
>   configs/am57xx_hs_evm_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
> index 6e4704470e8..3db30d2397e 100644
> --- a/configs/am57xx_hs_evm_defconfig
> +++ b/configs/am57xx_hs_evm_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SPL=y
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_ARMV7_LPAE=y
> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>   CONFIG_AHCI=y
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_DISTRO_DEFAULTS=y

