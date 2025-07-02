Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD96C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E82A81FEE;
	Wed,  2 Jul 2025 08:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fJOCxFAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58F68003E; Wed,  2 Jul 2025 08:49:33 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255978003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5626nO953853485;
 Wed, 2 Jul 2025 01:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751438964;
 bh=j12JKStlonyeMPewyqwf8RIfQjpzQU7vUUytMDs33Fc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fJOCxFAnBhld2NMiJH608kFQlYJCC6jB3aYYyvNrVOmA3zejEYtQW5AoY2qwSMB/N
 GdG3dnvKT9wy1DWMkmYc/XuX2WtWoMYgGwu3X2qYymBuZpkB+v2mQaR2w5P46X1Mqx
 WPb+Rg9IGcit/JS9+/Bh4viZaNTthNWkUG6rtg/U=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5626nOKK608355
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 2 Jul 2025 01:49:24 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 01:49:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 01:49:24 -0500
Received: from [172.24.227.249]
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5626nJhO2684005;
 Wed, 2 Jul 2025 01:49:20 -0500
Message-ID: <cd4f6a21-74c3-45e1-bece-426efb2b0705@ti.com>
Date: Wed, 2 Jul 2025 12:19:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/22] ram: k3-ddrss: Add support for DDR in
 self-refresh
To: Markus Schneider-Pargmann <msp@baylibre.com>, Sumit Garg
 <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, Bryan Brattlof
 <bb@ti.com>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 <u-boot@lists.denx.de>, Kevin Hilman <khilman@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>, Kendall Willis <k-willis@ti.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
 <20250623-topic-am62-ioddr-v2025-04-rc1-v3-3-a4da322c16af@baylibre.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-3-a4da322c16af@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Markus,

On 23/06/25 17:38, Markus Schneider-Pargmann wrote:
> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
> powered off completely. During boot the normal initialization routine of
> DDR is slightly different to exit self-refresh and keep the DDR contents.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 177 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 177 insertions(+)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 6590d57ad84f3c4dc5c72c6c5889038c463b0469..874614140c6d4a785fcca6eda4a8736e1183e193 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -57,6 +57,16 @@
>   #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
>   #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5
> +static void k3_ddrss_self_refresh_exit(struct k3_ddrss_desc *ddrss)
> +{
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_169,
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PHY_1820,
> +				 0,
> +				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_106,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
> +	writel(0, ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);

Can we change this writel also to reg update function based call?

> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_150,
> +				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
> +				 0x0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_PI_6,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_21,
> +				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
> +				 0);
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_20,
> +				 0,
> +				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
> +}
> +
> +static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +	unsigned long timeout_start;
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_160,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
> +	ret = wait_for_bit_32(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
> +			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
> +			      true, 5000, false);
> +	if (ret)
> +		panic("Failed waiting for low power command %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
> +				 K3_DDRSS_CFG_DENALI_CTL_353,
> +				 0,
> +				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
> +
> +	timeout_start = get_timer(0);
> +	while (1) {
> +		if (get_timer(timeout_start) > 5000)
> +			panic("Failed waiting for low power state\n");
> +
> +		if ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
> +		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
> +		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
> +			break;

As i see, wait for bit function can wait on mask also, can we use wait 
on the bit transition with timeout in this case?
> +	}
> +}
> +
> +static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
> +{
> +	int ret;
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
> +				 0);
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
> +
> +	ret = wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +			      true, 5000, false);
> +	if (ret)
> +		panic("Failed waiting for latching of retention %d\n", ret);
> +
> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
> +				 0x0,
> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
> +				 0);
> +}
> +
> +static bool k3_ddrss_wkup_conf_canuart_wakeup_active(struct k3_ddrss_desc *ddrss)
> +{
> +	u32 active;
> +
> +	active = readl(ddrss->ddrss_ctrl_mmr + K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);

As seen in 
https://elixir.bootlin.com/u-boot/v2025.07-rc5/source/arch/arm/dts/k3-am62a-ddr.dtsi#L10 
- the address range for CTRL MMR is starting from 0x43014000 and has a 
size of 0x100 but the address we want to access is outside that range. 
(0x43018318)
We need to increase the address range in this node in dt file as well.

> +
> +	return !!(active & K3_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
> +}
> +

Regards,
Akashdeep Kaur

