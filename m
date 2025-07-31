Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87A3C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 05:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B95C8319A;
	Thu, 31 Jul 2025 07:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jN3qW3ku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0E4832AD; Thu, 31 Jul 2025 07:47:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860D78318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 07:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56V5lrQp3371588;
 Thu, 31 Jul 2025 00:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753940873;
 bh=En48YWY4Ut2GqHMX9PicJaw4OQsKnPKllkEYTJeogk0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jN3qW3kuEOPo8QteGvLPf4Zfd/ip+6qVF0X2ZbIoiDei2qlr4uxVpl5/gfi55bb/m
 fpIkG7nyCOZ4xxyuNH/024/Wb58Y687v8lgmlJ8QnB6G7nXdYD+gor/TuXhREEA/Rn
 of+aqhgJx/83Sxde957Y2amYCa7lwM9d6NHmc8Mw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56V5lr5S3729399
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 31 Jul 2025 00:47:53 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 00:47:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Thu, 31 Jul
 2025 00:47:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 00:47:53 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56V5loMZ2105785;
 Thu, 31 Jul 2025 00:47:51 -0500
Message-ID: <285b02a8-4521-4040-ba6d-470f36e3df7b@ti.com>
Date: Thu, 31 Jul 2025 11:17:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ddr: imx9: Add Synopsys LPDDR training data collect
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-7-73da75bb33d3@nxp.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250728-ddr-imx-v1-7-73da75bb33d3@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 28/07/25 08:54, Peng Fan (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Add the functionality required for collecting Synopsys LPDDR training
> data in SPL context.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

[...]

>  endif
> diff --git a/drivers/ddr/imx/phy/ddrphy_qb_gen.c b/drivers/ddr/imx/phy/ddrphy_qb_gen.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..d77bb8480d85770d29e4408c2a723b20377833f0
> --- /dev/null
> +++ b/drivers/ddr/imx/phy/ddrphy_qb_gen.c
> @@ -0,0 +1,1842 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <asm/arch/ddr.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <u-boot/crc.h>
> +
> +static const u32 ddrphy_csr_cfg[DDRPHY_QB_CSR_SIZE] = {
> +	0x00090201,
> +	0x00090202,
> +	0x00090203,
> +	0x00090204,
> +	0x00090205,
> +	0x00090206,

[...]

Are these CSR values likely to change from time to time?

> +	0x000110a1,
> +	0x000110a2,
> +	0x000110a3,
> +	0x000110a4,
> +	0x000110a5,
> +	0x000110a6,
> +	0x000110a7,
> +	0x00011000,
> +	0x0001104a,
> +};
> +
> +static const u32 ddrphy_fsp_cfg[DDRPHY_QB_FSP_SIZE] = {
> +	0x00054026, /* TrainedVREFDQ_A0,   Byte offset 0x4d,      CSR Addr 0x54026 */
> +	0x00054027, /* TrainedVREFDQ_A1,   Byte offset 0x4e,      CSR Addr 0x54027 */
> +	0x00054040, /* TrainedVREFDQ_B0&1, Byte offset 0x80&0x81, CSR Addr 0x54040 */
> +};
> +
> +struct ddrphy_qb_state qb_state;
> +
> +int ddrphy_qb_save(void)
> +{
> +	int i;
> +
> +	/* enable the ddrphy apb */
> +	dwc_ddrphy_apb_wr(0xd0000, 0x0);
> +
> +	for (i = 0; i < DDRPHY_QB_CSR_SIZE; i++)
> +		qb_state.csr[i] = dwc_ddrphy_apb_rd(ddrphy_csr_cfg[i]);
> +
> +	/* disable the ddrphy apb */
> +	dwc_ddrphy_apb_wr(0xd0000, 0x1);
> +
> +	qb_state.crc = crc32(0, (void *)&qb_state.flags, DDRPHY_QB_STATE_SIZE);
> +	return 0;
> +}
> +
> +void ddrphy_init_read_msg_block(enum fw_type type)
> +{
> +	int i;
> +
> +	if (type != FW_2D_IMAGE)
> +		return;
> +
> +	qb_state.flags |= DDRPHY_QB_FLAG_2D;
> +	for (i = 0; i < DDRPHY_QB_FSP_SIZE; i++)
> +		qb_state.fsp[i] = dwc_ddrphy_apb_rd(ddrphy_fsp_cfg[i]);
> +}
> diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
> index 8e350de8315e40372f583c7a84c3ee5ed8b827d9..33275656469ecc24853f228b760229572e73aa48 100644
> --- a/drivers/ddr/imx/phy/ddrphy_utils.c
> +++ b/drivers/ddr/imx/phy/ddrphy_utils.c
> @@ -184,6 +184,6 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
>  	}
>  }
>  
> -void ddrphy_init_read_msg_block(enum fw_type type)
> +__weak void ddrphy_init_read_msg_block(enum fw_type type)
>  {
>  }
> 

-- 
Thanking You
Neha Malcom Francis
