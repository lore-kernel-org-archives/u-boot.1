Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D7CC0218F
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3145E810F9;
	Mon, 27 Jan 2025 08:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="USXAp+dG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C79810FC; Mon, 27 Jan 2025 08:54:53 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F1380FF7
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50R7smRF973880
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 01:54:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737964488;
 bh=OP45yB297E63o15K2ssYZdDUSU2BmIPYSZekAOABNoc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=USXAp+dG8ng3zgITIKDH85BH/omcW8KZjlis4Ntgh6INYEhQJo3PE8USQWmEm0MKu
 91DP8WLbSUlgdjRva3Hu0XgUv2p6wd3/jQN5DVHUntZ2+uTlcvt6wayEM32NVZud8/
 I1BC1cwVe2YUGmHlaE5O9FIzQHIsNH27EHG8hlfk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50R7smjC005786
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 01:54:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 01:54:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 01:54:48 -0600
Received: from [10.249.139.5] ([10.249.139.5])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50R7sjVG019954;
 Mon, 27 Jan 2025 01:54:46 -0600
Message-ID: <701482cc-d308-40b2-ba6a-82876c8d3cde@ti.com>
Date: Mon, 27 Jan 2025 13:24:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram: k3-ddrss: Set SDRAM_IDX using device private data,
 ddr_ram_size
To: Santhosh Kumar K <s-k6@ti.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250123083626.1035262-1-s-k6@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250123083626.1035262-1-s-k6@ti.com>
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

Hi Santhosh

On 23-Jan-25 2:06 PM, Santhosh Kumar K wrote:
> The SDRAM_IDX in DDRSS_V2A_CTL_REG describes the number of address bits
> minus 16 that are used to determine the mask used to detect memory
> rollover and prevent aliasing and false coherency issues.
> 
> Set SDRAM_IDX using the device private data, ddr_ram_size for K3 family
> of SoCs.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
> 
> Tested on AM64x, AM62Ax, AM62Px.
> Logs: https://gist.github.com/santhosh21/6dcdeb9a118c13732f858a1baca7dc4c
> 
> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index 05ea61bbfe9a..ff87faf6a224 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -33,6 +33,12 @@
>   #define DDRSS_V2A_CTL_REG			0x0020
>   #define DDRSS_ECC_CTRL_REG			0x0120
>   
> +#define DDRSS_V2A_CTL_REG_SDRAM_IDX_CALC(x)	((ilog2(x) - 16) << 5)
> +#define DDRSS_V2A_CTL_REG_SDRAM_IDX_MASK	(~(0x1F << 0x5))
> +#define DDRSS_V2A_CTL_REG_REGION_IDX_MASK	(~(0X1F))
> +#define DDRSS_V2A_CTL_REG_REGION_IDX_DEFAULT	0xF
> +
> +#define DDRSS_ECC_CTRL_REG_DEFAULT		0x0
>   #define DDRSS_ECC_CTRL_REG_ECC_EN		BIT(0)
>   #define DDRSS_ECC_CTRL_REG_RMW_EN		BIT(1)
>   #define DDRSS_ECC_CTRL_REG_ECC_CK		BIT(2)
> @@ -711,6 +717,22 @@ static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
>   		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
>   }
>   
> +static void k3_ddrss_ddr_reg_init(struct k3_ddrss_desc *ddrss)
> +{
> +	u32 v2a_ctl_reg, sdram_idx;
> +
> +	sdram_idx = DDRSS_V2A_CTL_REG_SDRAM_IDX_CALC(ddrss->ddr_ram_size);
> +	v2a_ctl_reg = readl(ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
> +	v2a_ctl_reg = (v2a_ctl_reg & DDRSS_V2A_CTL_REG_SDRAM_IDX_MASK) | sdram_idx;
> +
> +	if (IS_ENABLED(CONFIG_SOC_K3_AM642))
> +		v2a_ctl_reg = (v2a_ctl_reg & DDRSS_V2A_CTL_REG_REGION_IDX_MASK) |
> +			      DDRSS_V2A_CTL_REG_REGION_IDX_DEFAULT;
> +
> +	writel(v2a_ctl_reg, ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
> +	writel(DDRSS_ECC_CTRL_REG_DEFAULT, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
> +}
> +
>   static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>   {
>   	fdtdec_setup_mem_size_base_lowest();
> @@ -769,11 +791,9 @@ static int k3_ddrss_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -#ifdef CONFIG_K3_AM64_DDRSS
> -	/* AM64x supports only up to 2 GB SDRAM */
> -	writel(0x000001EF, ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
> -	writel(0x0, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
> -#endif
> +	k3_ddrss_ddr_bank_base_size_calc(ddrss);
> +
> +	k3_ddrss_ddr_reg_init(ddrss);
>   
>   	ddrss->driverdt = lpddr4_getinstance();
>   
> @@ -787,8 +807,6 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   	k3_lpddr4_start(ddrss);
>   
> -	k3_ddrss_ddr_bank_base_size_calc(ddrss);
> -
>   	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
>   		if (!ddrss->ddrss_ss_cfg) {
>   			printf("%s: ss_cfg is required if ecc is enabled but not provided.",

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Also sanity tested on J721E, J721S2 and J784S4 boards.

-- 
Thanking You
Neha Malcom Francis
