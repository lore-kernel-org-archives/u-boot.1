Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15BECD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 05:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12043803C6;
	Thu, 28 May 2026 07:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JWcoxmFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BEE83FB0; Thu, 28 May 2026 07:26:38 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06F980398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 07:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcqNoBy3AXT8UUuF8lToiBMd7RGUcSCYEeYgpGvf0PFfh0HPqZTWIatnMwj1yoHw2/ck1cpAf1rmLffGydZr5QkwoMQU6h37N5WDlb/dPFuKNpg+gt0XrU502lWVPumnZdlzBJntaVDiIykjhJajBcSQUXtnJM87NZiVhWTu28kwyM5dh4vu45aPbuwd42FH6ITtkDN2aPjJv7SBpQ5dVXiSW6y5zKKlU6RtZJgA7+sudCuYCHBLGwyooeRu5nJdB1f8krj+qlYosly0kul7PqraH/E1IQFJS5YIsdUuoGQSOfwBGxE9J23AkG+JDxkTBYe5JgTm4cZTEHAwnl5b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO5XukwM/2Mfs1wIES4riBEFuefHqh8+jqPRq6a8XRE=;
 b=sWILMDEAqsIIK565nE/2PKrIJkKaVccGzVLdbgJBeaTe4ccbnN8Lmuw+6HHFF1RDehY3nHuarnbup7AVackP1R6glN8i0HwlVzpxDpyoCszaF7lStrkViwbP3p6pfSCU6FZ7xDUsqLB2OgqfOyO7H3LB9r1Atyy2wxcMqem+2rVluC31o6PV6ITH0RQBr+c+p1Hbw7DG79puVqpRdzP5yh4uRYvwWYWLEL/ylKVrk19lA+qRtxqOXvm8mfQE9tbJWPBjkDsCyPZF3wx9S6D12KhC+JQU5LhgzFOhk6hWmhOGcPtIvppb5nNOpjfCdhAAeEubpDjRMthXT8qo1uLpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=synopsys.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO5XukwM/2Mfs1wIES4riBEFuefHqh8+jqPRq6a8XRE=;
 b=JWcoxmFqp2keQLKz13tYkc8lwq4GU5qO+tbIRi8iT8c9OT8Gn/a6wPJMn1g+iUV6jUUXPMQ/26CN+ryBissR6HpRzmeiRuamthQYPytWPuE3HhWAZ3M/DXe+Y2gnAtr04hpwi6iFi2XRIIBlIRrzujObr5DX+gUz2J2GGy5NKvY=
Received: from MN2PR22CA0026.namprd22.prod.outlook.com (2603:10b6:208:238::31)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Thu, 28 May
 2026 05:25:32 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::4) by MN2PR22CA0026.outlook.office365.com
 (2603:10b6:208:238::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:25:31 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 00:25:29 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 00:25:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 00:25:29 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64S5POjg1385793;
 Thu, 28 May 2026 00:25:24 -0500
Message-ID: <b3d0d4aa-9058-4d2f-bc1c-bfb51fa4ad04@ti.com>
Date: Thu, 28 May 2026 10:55:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, <uboot-imx@nxp.com>,
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, <festevam@gmail.com>,
 <peng.fan@nxp.com>, <alice.guo@nxp.com>, <ye.li@nxp.com>,
 <simona.toaca@nxp.com>, <viorel.suman@nxp.com>, <fedor.ross@ifm.com>,
 <marex@nabladev.com>, <joao.goncalves@toradex.com>, <ravi@prevas.dk>,
 <ping.bai@nxp.com>, <ji.luo@nxp.com>, <qijian.guo@nxp.com>, "Francis, Neha"
 <n-francis@ti.com>, <Siddhant.Kumar@synopsys.com>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 8208f0ae-72f1-4ba9-6c64-08debc79893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: l5jE+ulq3pKd2w1BYkCGbUmVP6XabLJBJo/tXDbiYby/MyR8dWVMaPD1CUTURz0qsqHX2/ykJzmhisWySXh98yGftuSwfi01g275s8q40Ifk0HGLmVR2cDQsKTo8Me+SeW9t8eZnMFM10Y1Xqui5iRuDJvAFwTypXIMoVjvV9497LzU57F6w8ExG7gaKIRraXosTsSAyctNUSGl30qRR6sVWDm0LyQRCP7Nn+Ae/N1/TeGngMvvva0/DDn0X80mESl0NspzpLQphfr4DGAoeepP8MMsD8Ns+BcTZRsYfa3Kc1Ul8RzBXy7PQlPFy3JNfS/78SHExWaOzkZ+QCcw0R8UTSyP5dT57jqznkUu4pcYinZ/ZWjij1fkNbHim9Cda9GVZsUu3OuTVFJpyeXnkZ20KHJYmKH615bJPxToW388esnrWbQjCR8X7VSZ2+vijPdE0cK+uxdwG5x8ByL5FA+Necm+LvpfiW+hE7vCDyxVwtaRu+Y4eqYGH98EJza3yQkglqXlTNPg6jTaEfzGvE9JadtlMtN9AM+gFOsSkK4PV4U+fIdfANwjqrP4u7mXeXB14iYca9lF8Z8IAVhZheuWGvE2ECT/PNaYE+63wHqy9YlStRNvjScksUdqkSImQVj9q5GhpLkQlsjT2VO5uwZjp3pml5ggzIMeTdudyNZKUzNU6Ugj1q6pxxyPlg+szAYYUe24AA+QRAPyC4GKmDCx0Eebtuzn7ALdcfTFYcXo=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B+rf7abw40SKX88WmrAP8q3fCmSVDdDJJW+rEX+1idUw0GWT59WtTxGBaqm6alzosP7tWWoYi911pW+lIElpioO2pICSaFCVutIRUiBavuDW36dZxYjQCIJ4CeC/f3HlEpOxcYhBl9aUeJgTPRmhJ/pNYLvf6PFo14SqlSW0H4d/DyVQtVjEO9XQWFzduWE3Id9RdXuyJ6EgE+dc+v6d2KEtIoooemWVXhU+xsD2YBiO5cyoU/YtG2tnAX5cka0v/L+h85gfPvbSBhke37e5JvenZqgA/+oq/KFuQW/HZKddFTslSKTsFMDTUSPMKpgii+L51YsI3paAm0nbhyq9tGyTdzbMN8jCKMN1nWWr+f0AASJiQOBvrOIBuRT5FWztTOuVksUAcoEJ9W4yL3CTAlkIkUrbXVMrJWOR2RII+EyoYK+9VL06Gw3FiYSUcIyN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:25:31.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8208f0ae-72f1-4ba9-6c64-08debc79893e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
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



On 4/30/2026 2:03 PM, Simona Toaca (OSS) wrote:
> From: Simona Toaca <simona.toaca@nxp.com>
> 
> DDR training data can be saved to NVM and be available
> to OEI at boot time, which will trigger QuickBoot flow.
> 
> U-Boot only checks for data integrity (CRC32), while
> OEI is in charge of authentication when it tries to
> load the data from NVM.
> 
> On iMX95 A0/A1, 'authentication' is done via another
> CRC32. On the other SoCs, authentication is done by
> using ELE to check the MAC stored in the ddrphy_qb_state
> structure.
> 
> Supported platforms: iMX94, iMX95, iMX952 (using OEI)
> Supported storage types: eMMC, SD, SPI flash.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx9/ddr.h |  48 +++-
>  arch/arm/include/asm/mach-imx/qb.h   |  15 +
>  arch/arm/mach-imx/Kconfig            |   9 +
>  arch/arm/mach-imx/imx9/Makefile      |   6 +-
>  arch/arm/mach-imx/imx9/qb.c          | 403 +++++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/scmi/soc.c    |   7 +
>  drivers/ddr/imx/imx9/Kconfig         |   7 +
>  7 files changed, 492 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/asm/mach-imx/qb.h
>  create mode 100644 arch/arm/mach-imx/imx9/qb.c
> 
> diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
> index a8e3f7354c7..bba12369f06 100644
> --- a/arch/arm/include/asm/arch-imx9/ddr.h
> +++ b/arch/arm/include/asm/arch-imx9/ddr.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Copyright 2022 NXP
> + * Copyright 2022-2026 NXP
>   */
>  
>  #ifndef __ASM_ARCH_IMX8M_DDR_H
> @@ -100,6 +100,52 @@ struct dram_timing_info {
>  
>  extern struct dram_timing_info dram_timing;
>  
> +/* Quick Boot related */
> +#define DDRPHY_QB_CSR_SIZE	5168
> +#define DDRPHY_QB_ACSM_SIZE	(4 * 1024)
> +#define DDRPHY_QB_MSB_SIZE	0x200
> +#define DDRPHY_QB_PSTATES	0
> +#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)

[..]
Sorry for basic question, in case OEI layer changes format due to one of
other reason then how you are making sure, struct ddrphy_qb_state is
aligned

+ * This structure needs to be aligned with the one in OEI.


[..]
> +
> +bool imx_qb_check(void)
> +{
> +	struct ddrphy_qb_state *qb_state;
> +	u32 size, crc;
> +
> +	/**
> +	 * Ensure CRC is not empty, the reason is that
> +	 * the data is invalidated after first save run
> +	 * or after it is overwritten.
> +	 */

In case OEI layer using saved DDR training data, then will
passed CRC will be zero ?

> +	qb_state = (struct ddrphy_qb_state *)CONFIG_QB_SAVED_STATE_BASE;

If yes then you can return from here, if no CRC found instead of doing
crc calculation.

> +	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
> +	crc = crc32(0, (u8 *)qb_state->mac, size);
> +
> +	if (!qb_state->crc || crc != qb_state->crc)
> +		return false;
> +
> +	return true;
> +}
> +
[..]
> +
> +void spl_imx_qb_save(void)
> +{
> +	/* Save QB data on current boot device */
> +	if (imx_qb("auto", "", true))
> +		printf("QB save failed\n");

In case, of 3rd boot or so, there is no need to save training data,
whereas you will return error, in case this feature is auto enabled.

> +}
[..]
