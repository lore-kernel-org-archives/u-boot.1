Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF20C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 23:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743A888A7B;
	Thu,  1 Aug 2024 01:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OdUcxENh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8534088A95; Thu,  1 Aug 2024 01:18:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61388897F
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 01:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722467931;
 bh=S5CSZSqyeKKj9c3As8SlKlF/xaq1KUpN+EBXny8Yiho=;
 b=OdUcxENhCiHzqpNIv44eI1t4d9xtl7y5FuAACSM2ivqW6HedbEG3TAvUnn3v0MIvnTIp1Xq7y
 nQeidhZLpTON/82h9TGgYksR+wVrFx+SDF5oB7lBGZ3bqC7F7qiDS2Y0mgle87XixvNA1oM2QYn
 iEVG34HnRuVgdBVBD9XL4oC4xNr/xcXhg9zgSfQAumYCBwxAXcKFuL3R90C1CqDqQqy57RiumDF
 fJCsL2BCkL794ypQG/A2zAjODmj1H9V3ryD54AGkBNOILcpr2aQb8D9en1IWOl/6631/rHpqtOM
 L/qrM8NpdfygqIkTe/WMepVwPXQccydSUy1YkbTilA1g==
Message-ID: <d90a0e00-4fba-4ff2-8de6-2cdcdd27ca23@kwiboo.se>
Date: Thu, 1 Aug 2024 01:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 huang lin <hl@rock-chips.com>
References: <20240731215832.2266189-9-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240731215832.2266189-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66aac65606984f15edfbe222
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

On 2024-07-31 23:58, Simon Glass wrote:
> The code here is confusing due to large blocks which are #ifdefed out.
> Add a function phase_sdram_init() which returns whether SDRAM init
> should happen in the current phase, using that as needed to control the
> code flow.
> 
> This increases code size by about 500 bytes in SPL when the cache is on,
> since it must call the rather large rockchip_sdram_size() function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v8:
> - Include ROCKCHIP_EXTERNAL_TPL in the condition
> - Put the non-dcache change back into patch 5
> 
> Changes in v5:
> - Move setting of pmugrf into the probe() function
> - Drop the non-dcache optimisation, since the cache should normally be on
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
>  drivers/ram/rockchip/sdram_rk3399.c | 35 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index bc79c034808..611e30cbe52 100644
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
> @@ -191,6 +186,19 @@ struct io_setting {
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
> +		(!IS_ENABLED(CONFIG_TPL) &&
> +		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
> +		 !spl_in_proper());
> +}
> +
>  static struct io_setting *
>  lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>  {
> @@ -3024,7 +3032,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>  	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>  	int ret;
>  
> -	if (!CONFIG_IS_ENABLED(OF_REAL))
> +	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>  		return 0;
>  
>  	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> @@ -3093,7 +3101,6 @@ static int rk3399_dmc_init(struct udevice *dev)
>  	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>  	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>  	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>  	priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
>  	priv->pmucru = rockchip_get_pmucru();
>  	priv->cru = rockchip_get_cru();
> @@ -3138,19 +3145,16 @@ static int rk3399_dmc_init(struct udevice *dev)
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

As you pointed out in the other mail thread, this adds ~500 bytes to TPL
because of the added (and unneeded) call to rockchip_sdram_size().

The rockchip_sdram_size() call only make sense to be done in SPL and
later phases, as was done before the changes in this patch.

This RAM driver need to:
- In TPL (or SPL on bob/kevin) initialize DRAM, i.e. rk3399_dmc_init().
- In SPL and later phases report DRAM size, i.e. rockchip_sdram_size().

Please restore the old behavior with something like:

	if (IS_ENABLED(CONFIG_TPL_BUILD))
		return 0;

Since we never are expected to need the struct ram_info in TPL, that
should also reduce the unneeded size growth of TPL that you observed.

Ideally we should really migrate bob and kevin to use both TPL and SPL
same as all other Rockchip aarch64 boards. That should help simplify and
reduce likelihood of future issues that are only observed on bob/kevin.
I will try to send RFC patches for such migration, but wont be able to
test them.

Regards,
Jonas

>  	priv->info.base = CFG_SYS_SDRAM_BASE;
>  	priv->info.size =
>  		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> @@ -3181,10 +3185,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

