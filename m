Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF88C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EBF88A28;
	Wed, 31 Jul 2024 17:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KxoGhTH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E026288A28; Wed, 31 Jul 2024 17:03:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7742988A15
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 17:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722438195;
 bh=6gWiXWmUrL1u5WqbNG0k6iZU25fmmmYswyw+4++R1tU=;
 b=KxoGhTH+lzfpmfL7tKNiXDwgEG7Hs/SmcsSF9BSJ5B/MAXXjHy6BX+i810tVPFli7RlRa1mjk
 nvWZRDDtD0/M8aw6+4ohCPe8oF9kENgAbpJe5jjc7tJu/Alp0hgLvujZ4qcL5B5XMb6fyg33X4k
 AMnUJ5wHeFs7Q5LhJLEKbmXgz6HxZJgFXOh3VluEvFF2+7JKXyjqGJI6YCH4IqD+XU7CZzIdNHg
 3c2uNC5Geh+94fyOqaqSumgZjmDe+6iojUmV7v8LmYxAaXlL6eLwWJG55PrV1N1grR5SCAwBZTy
 yaEczaN1x4VopdkR+WdU44pw3AIKmprdOCXyx3vOtZ3Q==
Message-ID: <d77dd5c5-37fc-4743-9f3d-3ef88eabb07f@kwiboo.se>
Date: Wed, 31 Jul 2024 17:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>, "U-Boot Mailing
 List" <u-boot@lists.denx.de>
References: <20240731144908.795290-1-sjg@chromium.org>
 <20240731144908.795290-9-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240731144908.795290-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66aa522e06984f15edfb5c4d
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

Hi Simon,

On 2024-07-31 16:49, Simon Glass wrote:
> The code here is confusing due to large blocks which are #ifdefed out.
> Add a function phase_sdram_init() which returns whether SDRAM init
> should happen in the current phase, using that as needed to control the
> code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.

I am guessing this size increase only is related to kevin/bob since all
other RK3399 boards already use rockchip_sdram_size() in SPL.

> 
> - Drop the non-dcache optimisation, since the cache should normally be on

Is this referencing to something that is still done in this patch?

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Move setting of pmugrf into the probe() function
> - Drop patches previously applied
> 
> Changes in v4:
> - Fix 'stating' typo
> - Move Binman size feature to a separate series
> 
> Changes in v3:
> - Split out the refactoring into a separate patch
> 
> Changes in v2:
> - Drop patch "regulator: rk8xx: Fix incorrect parameter"
> - Rewrite boneblack patch to onstead drop the target and update docs
> 
>  drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index bc79c034808..8a7cbb1849f 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -13,6 +13,7 @@
>  #include <log.h>
>  #include <ram.h>
>  #include <regmap.h>
> +#include <spl.h>
>  #include <syscon.h>
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/cru.h>
> @@ -63,8 +64,6 @@ struct chan_info {
>  };
>  
>  struct dram_info {
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>  	u32 pwrup_srefresh_exit[2];
>  	struct chan_info chan[2];
>  	struct clk ddr_clk;
> @@ -75,7 +74,6 @@ struct dram_info {
>  	struct rk3399_pmusgrf_regs *pmusgrf;
>  	struct rk3399_ddr_cic_regs *cic;
>  	const struct sdram_rk3399_ops *ops;
> -#endif
>  	struct ram_info info;
>  	struct rk3399_pmugrf_regs *pmugrf;
>  };
> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>  					struct rk3399_sdram_params *params);
>  };
>  
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -
>  struct rockchip_dmc_plat {
>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>  	struct dtd_rockchip_rk3399_dmc dtplat;
> @@ -191,6 +186,17 @@ struct io_setting {
>  	},
>  };
>  
> +/**
> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> + *
> + * Returns: true to do SDRAM init in this phase, false to not
> + */
> +static bool phase_sdram_init(void)
> +{
> +	return spl_phase() == PHASE_TPL ||
> +	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());

This is still wrong, please consider ROCKCHIP_EXTERNAL_TPL or this
function fail to do what you document it to do.

See our prior thread about this:
https://lore.kernel.org/u-boot/CAFLszThg5xohR-9AgSMHVrW5Dp_tN39nC7rq1Z4ZMnqOQqJa1w@mail.gmail.com/

Regards,
Jonas

> +}
> +
>  static struct io_setting *
>  lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>  {
> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>  	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>  	int ret;
>  
> -	if (!CONFIG_IS_ENABLED(OF_REAL))
> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>  		return 0;
>  
>  	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> @@ -3093,7 +3099,6 @@ static int rk3399_dmc_init(struct udevice *dev)
>  	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>  	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>  	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>  	priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
>  	priv->pmucru = rockchip_get_pmucru();
>  	priv->cru = rockchip_get_cru();
> @@ -3138,19 +3143,16 @@ static int rk3399_dmc_init(struct udevice *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static int rk3399_dmc_probe(struct udevice *dev)
>  {
>  	struct dram_info *priv = dev_get_priv(dev);
>  
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> -	if (rk3399_dmc_init(dev))
> -		return 0;
> -#endif
>  	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>  	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> +	if (phase_sdram_init() && rk3399_dmc_init(dev))
> +		return 0;
> +
>  	priv->info.base = CFG_SYS_SDRAM_BASE;
>  	priv->info.size =
>  		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> @@ -3181,10 +3183,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
>  	.id = UCLASS_RAM,
>  	.of_match = rk3399_dmc_ids,
>  	.ops = &rk3399_dmc_ops,
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>  	.of_to_plat = rk3399_dmc_of_to_plat,
> -#endif
>  	.probe = rk3399_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
>  #if defined(CONFIG_TPL_BUILD) || \

