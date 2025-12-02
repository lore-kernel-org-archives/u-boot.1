Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8A8CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 05:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D294983DE9;
	Tue,  2 Dec 2025 06:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A+3YvO1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB88883DEA; Tue,  2 Dec 2025 06:56:39 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CD483DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfY0VkCdy1GfCb2UGgSY3TqppddoGkqHXLCr3BrErnsbVV9Ox/+tOQhkJ8xX3KKSFmMHP762NGKNRbFnnGfidpo9cHt1tuzU8w6uwDdGpAzAPyJDreCfk9b9+72aepf2QFOjx2wuHUI6+LJnwVlcPBE6+czXIIo8S3pIvSg77VXpgF7AcP/8O+6VyUM+m7ZqufCC5m1rJk9kc8hTIylpBoq0DFl6WEnPNkHSXMSov85/toDJb6l42+YlKxtsS2AUBU/aDJ9pjTJVYgV15ZQB48gi1dteeUbrfYGFJLPHW2jtc/7XL1ggRkYnbIm51huU8prnjZb8Az1wIwVbfRfAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+muceaDEqqk2i0Ie2wChm98sklHaLsXI9dZVTKw5csM=;
 b=U/mAMchgm5MorSdBjpckK7C6KsWb+FFcYOoxeicX6MrXEvKEtp8idDV+sHXAn70gklvFekpcTG8qn88EFUxkNeT8PqyMNhZeLXoiUwHXAND+PXqmCD6bgEApeZ+2vp+RD5WguDRe3yCi0clXsURZiMslx79lHfkPiVF/JPqqBrzoaN+lmd9BzPym+EpsC5Q9wivGc7P0kLsMWCVj+aASPqiywfD86/JDP4RL0CzG/y0arjxjuXP7H3jWDAIsiXMdRVSQOXMJMd2zQ/d3RSF7r6fhMLWpZJKE01pAobkyTqdD8jNj2wB3t/SqI7bh6YZYiGw0SbdOLcBkvKkqMPPFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+muceaDEqqk2i0Ie2wChm98sklHaLsXI9dZVTKw5csM=;
 b=A+3YvO1GAQKDH/aimB6eHcQvN7gi01jeD6+cM58TmB4aoZJouNi7VNyskb4XrSonfX5O5sz4hgCLk1iuKywGVsAjGoOithtcAN/laSaNLXE966Nr3MhlDNdZnSRCZQIegI+C8zfFwhlbDliSQYSJMWbwIGCTLwEZaS2ygWjnzfM=
Received: from SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) by CH2PR10MB4245.namprd10.prod.outlook.com
 (2603:10b6:610:7b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 05:56:33 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::43) by SN6PR2101CA0002.outlook.office365.com
 (2603:10b6:805:106::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 05:56:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 05:56:32 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 23:56:31 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 23:56:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 23:56:31 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B25uT5i1709120;
 Mon, 1 Dec 2025 23:56:30 -0600
Message-ID: <52e73f71-6c4d-4630-88f4-81de3fedaf83@ti.com>
Date: Tue, 2 Dec 2025 11:26:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: am571x_hs_evm_defconfig: Reserve EMIF memory
 used by PPA
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20251128150455.3279166-1-b-padhi@ti.com>
 <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <c5f858f8-0eb3-4ff0-bc7b-6286a43c93da@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH2PR10MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: de655bb9-760b-4ce3-bb5b-08de31678bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVhJM3lPY3hTSFZsckJtbDYyN0tidzFaaHBpalYyZmREUlJuK0RGR3UxTTJt?=
 =?utf-8?B?R3Yxa0hhbnVSSktseG0rQXlXTE5tS1Y4UDlzbkh5cEkvRUxFWEYxOEVVQnFs?=
 =?utf-8?B?aEZ4K2JpaGZmUG5CZFE5eWdvclpVdHNEQzJOL3N6aDdvU00wOWNucTFCeTA3?=
 =?utf-8?B?UEl4TCtnMXB1K3lIZldna0ZaU0JQZTVGODFXcGM0c21UT051aGJvNW9nUHpS?=
 =?utf-8?B?MFROWFl0TEpFbTlKMDhQdEQwUGZJMTkxM0lDUXFHMmJVc0pnOGlvTUt0WklU?=
 =?utf-8?B?Q1IwN0pvNTNXUlcvbHVjenV5TlNRbjJjMWxpRWlYOWZKYXNxK1crV3o4TmRv?=
 =?utf-8?B?TkpoZ0JFTVdqNzRiN1RvZjlIamNNVkdCZTVTTWtCREJsY1NTUTkwVHpNSU9u?=
 =?utf-8?B?aFBvK1gyWk9mVDVvaEkveUI0RkJFWlZXeXVQazJnM3NiK2pOdFdNNzBKdEN0?=
 =?utf-8?B?bVlPaEtTWHRwd3NBdDNZZk5TK242L1lFYlpGNDdDc0p4Wmk3NWwvbzFzNFpZ?=
 =?utf-8?B?UDJJMEoyMytwcGRyNVA5RWNBeG9leVJzWjlhZmcyc3l0SmhoUG5vSHBGSnl5?=
 =?utf-8?B?cXZtL25Jc0xORG0vRW1SVTdJWUdMZE9IUW9RNFM5SlJtVkg2L0hnMnBZL2RI?=
 =?utf-8?B?dCtXa0RUOUZsYktMTjdyV3BuQWxId3RIQ1JmTFErd3ZOUGJFS2tSVVJXd0Zw?=
 =?utf-8?B?Njl6NGpwdnlFZTNJVGphdkwxL2NVRkdsREZjUWpSdlVIWGJySk1kU0Z5Y0Z1?=
 =?utf-8?B?eWRmODF5NjFEd2phQ0VDTE0zbjE3Sm9nT2t0d2E3Z2RxazJieE14Si9pcXZv?=
 =?utf-8?B?NE5YQW93aFhWamVlZWRCQzNQeG02dS9uTHZKQXM0Z0d5dnFLdmtpUXFBdDgx?=
 =?utf-8?B?bGVzYjYzRnA1OERZWUxUNFJqYU1YeEloRWFBblhnaUNhbUVSdGo3cjlpci9s?=
 =?utf-8?B?Rm10Z1d5citSbmRhZUxaN2czL2ZJNUErTDNtalRjdkxrcWVPVVRqRVl1V1Zs?=
 =?utf-8?B?bDA1RkpmWk1uMm85SEwvRytjSzB0UkF0bGtvZXJmRTB3ZkR4RnRaaVJaQi8y?=
 =?utf-8?B?OFpUMEVoenhrVkxoS21ySHFZbHorRmNuK2RPazhUdTVlWU9EazlvVEtrK2JZ?=
 =?utf-8?B?c3FydUVGdHllL2Uzd29kL3BNM1hnM29rcG9yVGRrTFNCY1ZEUnkvRXN3bnRx?=
 =?utf-8?B?VS9Ka201WGtDYTVwR3FtTUQzU1R1UTdmTTBwQTFBeVhMTUZkWWNrdmZBYWY0?=
 =?utf-8?B?d2J4TXRmdjI1TjlVdGdwWUZqQUthRE0zNHFPTGdwcmNhY2R1RHJZbkkyUW1I?=
 =?utf-8?B?aDROazd1L2dMd2pGWU5qdFNuTTIvVmhpSkRLMklaTXZPY0thYXpZMk5kUUFM?=
 =?utf-8?B?eld2MHdnUFVSSmpSRldUajFMZFc3V1VBTXY0ZHoxZU10ZU5vdXplU1ZwUEpv?=
 =?utf-8?B?U3VSTWk3SENwK3NxQXp4aTdHaTVrOHB1YlMrSW8xa1lYaXNwUlJzTFFrZVN2?=
 =?utf-8?B?Q2cyanExYTZFT296TmRBTldaRXQ1MFhHVW5uTXZ4aXBOc3AwY3FXSVZrM1NW?=
 =?utf-8?B?YjAxVjlzSW14aXNIYzJ3a2pFQTQ0NlJGbmVPWXVuMWpxek5xR3Q3VklwWHBP?=
 =?utf-8?B?dWZrcDZIa3RkcDdocmJDVXFRV2xHaVh5Y0ZqeDA3aHVQOGtlajdTL1puTEFl?=
 =?utf-8?B?MkJGR3NBTDMycXUrWkl0ejZnNVEzUlJrYS8wcXVPTW9BMk1acFpKNDBXdlIv?=
 =?utf-8?B?UTZ5TzA5anBCMWd0S0tTdDFlOUF2cFgzaldlTUxDazFFUHFmVTlWS1B2bHJF?=
 =?utf-8?B?Z2NoMnAvTE9iU1R5dlg2WDd4QUZpWS9lYWx3R1RWcExOc1JqYkNwTlFrNXpu?=
 =?utf-8?B?YThyTnJTYVRmL0NjclN3c2hjcWdETFA2dnVlMy9qNWZyMUxXOUIyenYrSURt?=
 =?utf-8?B?VnJLS0hXZlUwUzZvdGxtMXhoN2c5OFBnd2dSdjVWMC84dnFwWG1SS1pxV1F4?=
 =?utf-8?Q?8ACg0NihH8Gi+bSP6AOB8VJRQp3pxo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:56:32.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de655bb9-760b-4ce3-bb5b-08de31678bc3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
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


On 02/12/25 00:58, Andrew Davis wrote:
> On 11/28/25 9:04 AM, Beleswar Padhi wrote:
>> The AM571x SoC has 1 GB DDR space. As part of normal re-location process
>> U-Boot copies itself to the top of DDR bank. However, on HS devices, the
>> top 37 MB is used by PPA and is firewalled. This results in an exception
>> and the boot fails.
>>
>> Introduce a new defconfig for AM571x HS platforms and set
>> CONFIG_SYS_MEM_TOP_HIDE to reserve the top 38 MB memory (aligned to 2MB
>> as per page size for ARM32) for the same.
>>
>
> This "SYS_MEM_TOP_HIDE" looks new, for other OMAP-class HS devices we
> use "CFG_PRAM"[0], seems these two configs do the same thing, could probably
> combine them in some way..
>
> As CFG_PRAM is set based on TI_SECURE_EMIF_TOTAL_REGION_SIZE which is 32MB


CFG_PRAM is only set if TI_SECURE_EMIF_REGION_START is not set, but we
have it set it to 0xbdb00000 in the am57xx_hs_evm_defconfig.

https://github.com/u-boot/u-boot/blob/master/include/configs/ti_omap5_common.h#L75-L81

> for all other AM57x, why is this needed only for AM571?


Other AM57x boards have >1 GiB DDR. So, the top of DDR space does not
intersect with the firewalled EMIF region (0xbdb00000). Only in case of
AM571x, the top of DDR collides with firewalled region, so boot fails while
doing reloc.

> We build for all
> the AM57x with one defconfig, so this new defconfig will go unused. Just set
> the default CFG_PRAM size to 64MB (same as AM43x), 


I am guessing all AM43x devices have the same amount of memory unlike
AM57x devices? If we set CFG_PRAM to 38MB by default, won't we lose out
that memory on other devices which do not face this limitation?

Thanks,
Beleswar

> should be enough for all
> and doesn't hurt to have more than needed reserved to be safe.
>
> Andrew
>
> [0] https://github.com/u-boot/u-boot/blob/master/include/configs/am43xx_evm.h#L153
>
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
>>   MAINTAINERS                     | 1 +
>>   configs/am571x_hs_evm_defconfig | 3 +++
>>   2 files changed, 4 insertions(+)
>>   create mode 100644 configs/am571x_hs_evm_defconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b43dae882b3..e5d564cd760 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1780,6 +1780,7 @@ F:    configs/am335x_hs_evm_spi_defconfig
>>   F:    configs/am335x_hs_evm_uart_defconfig
>>   F:    configs/am43xx_hs_evm_defconfig
>>   F:    configs/am43xx_hs_evm_qspi_defconfig
>> +F:    configs/am571x_hs_evm_defconfig
>>   F:    configs/am57xx_hs_evm_defconfig
>>   F:    configs/am57xx_hs_evm_usb_defconfig
>>   F:    configs/dra7xx_hs_evm_defconfig
>> diff --git a/configs/am571x_hs_evm_defconfig b/configs/am571x_hs_evm_defconfig
>> new file mode 100644
>> index 00000000000..7e44ee5221a
>> --- /dev/null
>> +++ b/configs/am571x_hs_evm_defconfig
>> @@ -0,0 +1,3 @@
>> +#include <configs/am57xx_hs_evm_defconfig>
>> +
>> +CONFIG_SYS_MEM_TOP_HIDE=0x2600000
>
