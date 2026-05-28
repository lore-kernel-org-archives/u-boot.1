Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF851CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 05:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5731803C6;
	Thu, 28 May 2026 07:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W52o0ujn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27CF8056B; Thu, 28 May 2026 07:23:58 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08B480398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 07:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnrCgWI/Y7+whOi6gLk45fhCiulOM8BaCnkeINHE5+H6GKTKQL+A5i4FBks6s0+mwaVoUPW1tW3qu8k1XjYlWYZ3RPlq97omTYfQhchIbLF2IkY5hFVeKxTGpU6EcXTSqut/0mhYzrQnmfbT3LLdDoDQCz/QWq2pLDvEjrFJBWrqWKIaTsoqVgULmINo6PR0tKT3BIsW4Zjgucx6Q1eqSHn4qrCb7/wPG5EMBf9g4qlIpTpC30GSfzmFlyXx0eR/JiCCjNpxPugXtAHORYjODm7PlzzNlVJ+qWLByrnD2Y/93h9x4QbUjLR369uka0fmEDOqVZ0H6fI1a+6RMsTV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aHzeXNY/UAFLPOym732qCWlqMFMoYIu9231kIDL+Bw=;
 b=ANnj+kmFCot8J3VP/4E6+Rt6+HTZkKWlUmzHt0GNvd6GSf/YPBP/qEplLOAZF3Tre8lSVp9w/w8f3FCd/SZHHhCB8W2eYZi1jRo8xjwa8lm+WsFFLU5DR1m2dta5Vwq8tRDfnWwOUOMEH4rVb4lWiUMwtnWPo+yhZMhcXFXyyvdpVvzgRlj5sFJNklh4/AQn85At3IBmoJjW5UfpcHenBSXnnyVhgsjZf+D3We4rTKjw1eFt+DAnpVJG8Q1FRkUlc70P/vudwQB5jE+BeB3qWZXkfcoh1aGYMS9b+pwldjwugqUZe0KsHeZszlQWt6NCgRffhqXP2qdKHTt5ACVq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=synopsys.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aHzeXNY/UAFLPOym732qCWlqMFMoYIu9231kIDL+Bw=;
 b=W52o0ujnhbocqFpo6KinnsVaprfuWMbiHx2rTPphXCEvvvl9+lTEdL8ucjwgkhaMJZXnMpL+MkFvqAPLYccF5KMhyVMHWmG6BpFNuXRpZJ/l5yLAKEx6nSRYDkKQbhC1grD5AIMVL1tVJNJqS/uzqXX1sekW2YsQ23SQGQRGcC8=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by SJ0PR10MB6421.namprd10.prod.outlook.com (2603:10b6:a03:44b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:23:52 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::1e) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 05:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:23:51 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 00:23:42 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 00:23:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 00:23:42 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64S5NbtF1383181;
 Thu, 28 May 2026 00:23:37 -0500
Message-ID: <82277026-3f19-4a9b-8216-e2be456adcd1@ti.com>
Date: Thu, 28 May 2026 10:53:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] imx9{4,5,52}: Add Quickboot support
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, <uboot-imx@nxp.com>,
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, <festevam@gmail.com>,
 <peng.fan@nxp.com>, <alice.guo@nxp.com>, <ye.li@nxp.com>,
 <simona.toaca@nxp.com>, <viorel.suman@nxp.com>, <fedor.ross@ifm.com>,
 <marex@nabladev.com>, <joao.goncalves@toradex.com>, <ravi@prevas.dk>,
 <ping.bai@nxp.com>, <ji.luo@nxp.com>, <qijian.guo@nxp.com>,
 <Siddhant.Kumar@synopsys.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <cover.1777536451.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ0PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: e6db274b-6626-4789-a5cd-08debc794e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: sDlhqmz3OuOGBMXGWYjOZuSxRq1F1tZ3dMjm25dSS3MXTCwEUoBOrQ44m26dPpwPYsfb4HgFL5IgS5Neanxxw6RR91qrl5S+AZH6xyyeA2sQnQpkm+dcYc4podksSYy3udTspTggEW7HUDi3x1bcSmW7GRPilGoDG9kh3tLyCi5G1E7XqKIlwYPkmq9enjWKzDBs/3qHVmQz3hQdmjY2jAocinUOFCSdjSKT/CDIpf3pkQ6/E3H2Vwj+LcKtxa2rctzVj2vDqhPlxqcH9r2CBpQcW7psCWHXtEcWB/LjwutDGKpkBPUvw3FT515eBWC7apl2ukDE2ZW86v+HbeAohzoUD8jVm8+9MCUPcfFKn3DbRf5DpgmurxV/Ned5cXQR80zlrswnEZ/WrfVQsyoVrFOCUH9Pr6ltJPAxyGzktO3JXH/wRsXfbypcZ9WPvMDwnQrl82RIGFCeCp0QoPg7hnUXEnvWlPAeZmR8HQ2pHvdyCj3MBjgrj4155q29ZKhMI9j7eOYSrQh4OBIoAQ2j5dS3kbpbp484gqYMlYv1ms63d5vbPYXq6xi5mJVjwex6adRWYwig9gyzrjpiO/8ElvWnrz8/kosYEFQ2+NZu7VHPelfmmfNCWNASE3fE/rUGPPgf9pp4KhMqZ3iOw8AnK4L01K+EK44XUeXrpn4TresvmqqVrAyE8Ct+Hm85KHEd97Nt6lBWy+7xI/8AdU5KSr5WJhxW1rGjdAB0IE9dPh0=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WIO2AIuU3qCLQrcy3Iw6/Sf8HjuNSyHw4GUeeXIJGlHklRRC6RSke9OlppTcNNVsNia6nYHlRtP8m7xQO8Z5zQWgjckTJfRZzHPd79I3c37VDfPNGk8lAnyT+7L6bLe5v8YLZt7OvUzvbHhcX/j5DkOTj7aTyFujPFkOZZ2sIPUbjodYmFX9j2HIIJUGexxOZ5SE0SAGd6wq/gbQlSJ11rJuPQuGEtuEWQT0kOXH2he+TKskLazihkY2QvtNJz2+dXGJBmytfDlUizaK0o+cSD63zEoIHEehLaKx8b5gVFu+kF+EmTEHiP/cBB3RztFLgEwbKgypuRxO2dKoI8UuMS8GOJNOFD0j219eNvn0UWePeDlTLZRlSxsQHIlZOAMQP62ev1gwO5JldlURwn/0Dma2wG5uCUnmOkeuzLbun7WZ0tASc455bXszMtBw1KIY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:23:51.9996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6db274b-6626-4789-a5cd-08debc794e25
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6421
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

Hi Simona

On 4/30/2026 2:03 PM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> This patch series adds support for saving DDR training
> data to non-volatile memory on iMX94, iMX95 and iMX952 platforms.
> The purpose is running DDR Quickboot flow on next reboot.

First thanks for this series,
Since this is DDR IP feature, could you think to make this generic
instead of board/arch specific.
> The process is as follows:
> - OEI runs Training flow for the DDRPHY
> - OEI saves the data from training to volatile memory
> - U-Boot can then save it to non-volatile memory (e.g. SD)
> - OEI loads the data from NVM at cold reboot and runs Quickboot flow
> 
> By skipping training, a much lower boot time is achieved.
> 
> Changes for v4:
> - add IMX_QB macro to include qb.c based on the boot phase
> - change qb_ prefix to imx_qb_ for qb.c methods, to
> be more specific
> - add boot device macro to string conversion for the case
> where the device is not explicitly specified
> - pass quickboot args as strings and parse them in qb.c using
> blk_device_get_by_str/blk_device_part_str (if they are blk devices).
> This enables specifying mmc 0:2 for the boot1 partition of the eMMC
> device.
> - use blk device API instead of mmc-specific
> - use SPI DM methods for spi flash read/write
> - use malloc for storing container header instead of kmalloc
> - add eMMC hwpart usage to the documentation
> - sent the qb-unrelated patches separately
> 
> Changes for v3:
> - Rebased and added support for iMX952
> - Removed IMX_SNPS_DDR_PHY_QB_GEN macro, as it was not useful ->
> now CMD_QB is enabled by default on the supported boards
> - Removed unnecessary #ifdefs -> replaced with if (CONFIG..)
> - Replaced spi_flash_probe with udevice_first_device_err to
> avoid using SPI macros that needed ifdefs, since there is only
> one SPI flash device available.
> - Adnotated qb methods with qb_ to be easier to see in asm dump
> - Removed explicit pointer casts from (void *)
> - Replaced custom qb_crc32 with the U-Boot one
> - Made eveything snake_case
> - Enabled SFDP support for iMX943/95, as it is necessary for
> proper erase size parsing (and is already present in iMX952 config)
> - Improved documentation - explanation about the space in bootloader
> - Added commit fixing a style issue in Kconfig
> 
> Changes for v2:
> - Improved documentation to clarify the questions asked
> - Detailed log messages for all commits
> - Detailed Kconfig options for SPL_IMX_QB and CMD_IMX_QB
> - Fixed the mentioned coding style issues
> 
> Simona Toaca (4):
>   imx9: Add support for saving DDR training data to NVM
>   arm: mach-imx: Add command to expose QB functionality
>   board: nxp: imx9{4,5,52}_evk: Add qb save option in SPL
>   doc: board: nxp: Add Quickboot documentation
> 
>  arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
>  arch/arm/include/asm/mach-imx/qb.h   |  15 +
>  arch/arm/mach-imx/Kconfig            |  28 ++
>  arch/arm/mach-imx/Makefile           |   1 +
>  arch/arm/mach-imx/cmd_qb.c           | 102 +++++++
>  arch/arm/mach-imx/imx9/Makefile      |   6 +-
>  arch/arm/mach-imx/imx9/qb.c          | 403 +++++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
>  board/nxp/imx94_evk/spl.c            |   6 +-
>  board/nxp/imx952_evk/spl.c           |   4 +
>  board/nxp/imx95_evk/spl.c            |   6 +-
>  doc/board/nxp/index.rst              |   1 +
>  doc/board/nxp/quickboot.rst          |  59 ++++
>  drivers/ddr/imx/imx9/Kconfig         |   7 +
>  14 files changed, 688 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/include/asm/mach-imx/qb.h
>  create mode 100644 arch/arm/mach-imx/cmd_qb.c
>  create mode 100644 arch/arm/mach-imx/imx9/qb.c
>  create mode 100644 doc/board/nxp/quickboot.rst
> 

