Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F486D5C0C6
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 05:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B10D80077;
	Tue, 16 Dec 2025 06:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OTd2CkW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F76800D0; Tue, 16 Dec 2025 06:18:00 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FF98003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6GANN7aqDNVgd4FxarBtFNM+7Wszkam8YYn9+at9AHAWqsQJo7rIt5PaU+kXHhWRi7rAolUtI4jgpqLCEAdAShVrnW3jekRADpRK+BoT5hr8odfqsMz3A0x+gTQPN1IMaGhniCmWAJvQePCFdfyR8XLwLLX4PJmeETByPzaVHxhh0Vlml0FGP+OYNdB007bTogBe3gXsgxeLjSBYK1eMaH7Qa+SG0lQ0O5ba7aM1DvQj91a29YNhZSdVV0vVMd9BqUA4KDx8b1J6VWZ6Xxfs4GPcgJoro6H8SKZlBE9dkLWEbbTOCJrwdWhuOpyz9eKqJifJwnq43i8eGOXI/t8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itg8/WS+0U5nnMbJC42bIoBxxwIjac4uLVdxCDxK4RI=;
 b=c0+723lQxGKK6jllZfiaXzbGXJFmee2fynnA07y1yrG6PCOx438pAd1rEQoBvHBQv5F2hk1LfjD1+22ylDiTpA4rYaAlnKWbIbSkry9MjzOYJTetRFw7SULyVs6P+ZAMCCAWDhHB4Qryz0L6qCY9W3TQvA0+e/rZjH/ZjKN06AmJbZX1cJ7glQtD6kuN87el16G5693Rn6d/gKCwrmdgMtfA5NV5/2DSyR0PAD/R6xjU4c8u0jFAKKevzcK/2z1+UZr0ugaBkbOhWNsfyqoU54yP2lJ8wGB+xC3sBFRLXntzzaR1e4PsYWJlApWP6DABQz+d4ZlWH8MTp6OjcDL32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itg8/WS+0U5nnMbJC42bIoBxxwIjac4uLVdxCDxK4RI=;
 b=OTd2CkW/TSVe6KCwAyLJ8iGchwPvaPGks6S+WuV6UIK+t5Pe/ggBO+0gA/Gt+54qgSOkO6V/t8ESklmbNilPPNadAOuIA6KauFucl1C/vODFM/508cHQ0/uylEui5zHftgAR5z+dQmIhXM7aWnDwO+7DSVh1CdmSP8A/cYG0xdY=
Received: from DS2PEPF0000455C.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::514) by PH3PPF0A29BA37B.namprd10.prod.outlook.com
 (2603:10b6:518:1::787) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:17:54 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:4) by DS2PEPF0000455C.outlook.office365.com
 (2603:10b6:f:fc00::514) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.2 via Frontend Transport; Tue,
 16 Dec 2025 05:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 05:17:52 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 23:17:47 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 23:17:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 23:17:47 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BG5Hj383526095;
 Mon, 15 Dec 2025 23:17:45 -0600
Message-ID: <28abddcb-5218-4705-869f-866aee674f70@ti.com>
Date: Tue, 16 Dec 2025 10:47:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
CC: <afd@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <20251215163901.GS303283@bill-the-cat>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20251215163901.GS303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH3PPF0A29BA37B:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed5e1a-0537-4e56-42c6-08de3c627672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXJtMUZ5QU1DSUpRTVBVbHJPYS9hSittcHU4Zm5pblBVQ0ZBYklQblBoOVlK?=
 =?utf-8?B?TVVDVEN2dTBqYW5DQ1NQOU9rNUt0V2hDSFpIWUlpV29SeUlHcUpnZGJ1Y25v?=
 =?utf-8?B?cTZhekVNVGlObnA4MnhDM214UDNnYWd3bndqdnU3aG43WjNpZjR1bFJzRnl6?=
 =?utf-8?B?b2tqcVcvYldxTTVVN2VYSlVNb3lkcWlBZGhoVVlNOVNiSEFTWDdUbjVRSDBR?=
 =?utf-8?B?Q0Zzd0x4bngxdUtReXRCNXJJY0FuOXd5bTlUTmNCa0cwL3U5RFhvMDdVR2U4?=
 =?utf-8?B?bzYwZGlvc3c0NUJ0MlQ1Q3ZzQzh4L0JWVXhKZkZqaStjczRoZ2pDVVBxUWJE?=
 =?utf-8?B?UkpXczBTbm9GZURLQTBYdUcwNE5KekRlaSs0ZEtvbjFUelhLdmJ4aXU2akFz?=
 =?utf-8?B?NmJvT1Z6dlpYVEFYY1lvUWU4Q1k1RThyaE5GMXFUUEpKaERZWnVrQjRPUGVY?=
 =?utf-8?B?K3M1eHp0TFhYaXVSY3NRa2h0Z0V0K09Jays3aVJVQW1zZUNsV0lVSDZIK0E4?=
 =?utf-8?B?NXB3N3k0T1NpNUI5OGRJaE9wekhzZFl1eWdTS1pleERid1ptM2ZKM0p2MVhj?=
 =?utf-8?B?Wld5Q1pBM0FuTGtwQk9YdmQzeSt2Z0JHaFgwaHZvbll3SnRuRXphZk4xdTJh?=
 =?utf-8?B?KzFIYnV5ZGZrRDZ1eTQzbDdQZ3BPOE1KTEEvWDNDVTFzS3I2cmMzTTZSS1RE?=
 =?utf-8?B?SUtJSGZYSXRqbEV2aXpQZm5wa20wTG5zTVB2V1FJOTFZMWs2aFRlVUlCeHpT?=
 =?utf-8?B?NERIVTBYTDRIb1hGdW1TSE9IN0xvYXNEWnRGTTlQWW1MeUtlTWhpZElSd3Iw?=
 =?utf-8?B?TFFZdXA2RkFpZ20yS1VGcVFydm15bDZDSkR6dkI4RnhLRm9vQThNQ2hVeTVo?=
 =?utf-8?B?L05obzV3UDJ2aGNNbkQzRzY1cWM4Y2szSzZlMEJTSEZjN0tSSFJFdFd4NGdM?=
 =?utf-8?B?OURBSXRObDhvdnRyOTFZQUtadjNIZ0xtdURodzdpUElCR3JOZ2x4eDFCWTQ0?=
 =?utf-8?B?Z1VOMmgyYnBudlI2WmdUdTR1UlNWOUxINWFBdFJzK1NTd3dFN3ZHSGl0OFJY?=
 =?utf-8?B?bVIxbnRLek5yS21DNzNTeTNSY0ZHd3B0dUhTckUrOWxEVHJxUi9OQWtHdTdR?=
 =?utf-8?B?emRSZVk3c1JidVFvSUppN0xCT1lsSm1kcnlyTTJMRjd5UjhORlZ0bUM2S0Fv?=
 =?utf-8?B?c01sY0MzVkpFVGE3QnhPVE1HWXZnZXMxcGVBamdCejRoV0pIdjJxaFhFZGYz?=
 =?utf-8?B?NVNJcHByNXNFNDZlZkZ5YkVWVGVwMkMwWlNoSHBJbFpyQlhKdW83SCsxRW9p?=
 =?utf-8?B?OHVuVm5QNGdrVHBPOXlHdU9YcWlDUXBTM2tkSE13UytkY1hRQ1ZDdjZ2WXpK?=
 =?utf-8?B?SnU4V0FkK1hQNGdHU1RzdkU2dmtFd2F5dk5mQVFIZzd6blJJSk5FVTR6b25s?=
 =?utf-8?B?a25TN3Q2dlE4ZEZ2M3k3MTFlVkFuUU1rUUVEdFpQZ2dvV0MxaExTWDByZ1dn?=
 =?utf-8?B?M3RtS0tsUUt1RzFzejQ1elFqVmR3a2Qxa08vS0VSVTdrU0IxalJjeWdNRzJX?=
 =?utf-8?B?Ukw3SEJJVTlwdGR6djYzcmFwRkJneGZrUS81eHVieFpjNnBma29pWU1tUVcx?=
 =?utf-8?B?ZC9hbzZJV2czZ1h3NVFTWTBWVFJROG1CWVcyRFloR1BCcFBBd1g0Q2hSWEpK?=
 =?utf-8?B?Nkgvb2ZTWGFOZHkwU3htZ3p0K21aS3U3MWNqZmFsSTI4dVp3WTVVS0dqdkxa?=
 =?utf-8?B?UXl0RTR4T2ZOVGJZMlBDamlZVzRPbGRjZHN4eUZXV2Y1V01QTnIrcnBJOFZF?=
 =?utf-8?B?L1EyUFM1UmNwM3RDcTArZEZWZWtUbWZXOU9OamJyQmx2WUV4ZHovSE9wMUhG?=
 =?utf-8?B?bmhleFg4cnFjSFlBUXY2ZnA2QWEwRVZON0VGY1N4U3dSNEhSWTdmYXJYZ2Rw?=
 =?utf-8?B?NUV2WGxXUFlWVmdYQzdyOHNsR2NYejNwNVVJTExERTlqeS9td0xYZ1ZFcEVz?=
 =?utf-8?B?dk1OL2dnUTJIa2xWMFEwTlhwczVSa0l5aW91L0p6ZEUrU09tMVJwM250Ujkv?=
 =?utf-8?B?YlI0enlUYmpCT2U4S1dOTGlXL0xhcEFOS0lQN2JkS0hsMGk1S1FtOVZ5aWhG?=
 =?utf-8?Q?gGZ8=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:17:52.4011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed5e1a-0537-4e56-42c6-08de3c627672
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0A29BA37B
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

Hi Tom,

On 15/12/25 22:09, Tom Rini wrote:
> On Fri, Nov 28, 2025 at 08:34:55PM +0530, Beleswar Padhi wrote:
>
>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>> top 37 MB is used by PPA and is firewalled. This results in an exception
>> and the boot fails.
>>
>> Introduce a new defconfig for AM571x HS platforms and set
>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>> as per page size for ARM32) for the same.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> Fix boot for TI AM571x HS EVM board
>> v2: Changelog:
>> 1. Drop [PATCH v1 2/2] in v2 series. There is no need to add reserved
>> memory node in DT as it is done by U-Boot as part of FDT fixups
>> https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-omap2/fdt-common.c#L72-L107
>> 2. Add entry in MAINTAINERS for new config.
>> 3. Update commit message to use memory size in MB than raw hex bytes
>>
>> Link to v1:
>> https://lore.kernel.org/all/20251128064353.1295063-1-b-padhi@ti.com/
>>
>> Test logs:
>> https://gist.github.com/3V3RYONE/e86b3f4551986b0400d0e0f66d6ecc66
>>
>>  MAINTAINERS                     | 1 +
>>  configs/am571x_hs_evm_defconfig | 3 +++
>>  2 files changed, 4 insertions(+)
>>  create mode 100644 configs/am571x_hs_evm_defconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b43dae882b3..e5d564cd760 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1780,6 +1780,7 @@ F:	configs/am335x_hs_evm_spi_defconfig
>>  F:	configs/am335x_hs_evm_uart_defconfig
>>  F:	configs/am43xx_hs_evm_defconfig
>>  F:	configs/am43xx_hs_evm_qspi_defconfig
>> +F:	configs/am571x_hs_evm_defconfig
>>  F:	configs/am57xx_hs_evm_defconfig
>>  F:	configs/am57xx_hs_evm_usb_defconfig
>>  F:	configs/dra7xx_hs_evm_defconfig
>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>> new file mode 100644
>> index 00000000000..7e44ee5221a
>> --- /dev/null
>> +++ b/configs/am571x_hs_evm_defconfig
>> @@ -0,0 +1,3 @@
>> +#include <configs/am57xx_hs_evm_defconfig>
>> +
>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
> Sorry I missed this specific part before. Why isn't this just being
> changed in am57xx_hs_evm_defconfig ? 


The firewalled DDR region and the top of DDR (for U-Boot reloc)
intersects only for AM571x HS device as it has 1 GiB DDR. This
does not happen for other AM57xx HS devices.

> Do we *need* a new config here? 


We can have it reserved in am57xx_hs_evm_defconfig, but that would
hide that RAM from other AM57xx devices which do not face this
limitation. Anyways its just 38MB, so let me know if you prefer to have
it in am57xx_hs_evm_defconfig and I will send out a revision for the
same.

Thanks,
Beleswar

> Or,
> and this gets on to a different topic I've been having with Bryan, is
> there upstream value in this specific config being added? Thanks!
>
