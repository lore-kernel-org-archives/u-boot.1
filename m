Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE117C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 06:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E828E87FED;
	Fri, 21 Jun 2024 08:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="y21jEsUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C96880F1; Fri, 21 Jun 2024 08:55:33 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB9687EF6
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 08:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b72a=NX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718952914;
 bh=T/dVght4+W0R6bicP54QbmR5FLDzDgl/UhfN2HAwgYk=;
 b=y21jEsUTk+VKTz0ZTvmcEEjv8dXHN1OwsAzWjzdNkASZc8rQBlTs029amf3nmbOhQ/aEpoVPO
 nCvONyPKX+NqlQgZPgKb0yeguHHsAZnxC5E0fiLRw1zrv3h2wir3tz9/tosMPegofr3rjQUzPjw
 7JjW8YP/pF5XcjF7CFRC9vlKU9pS9JezzFq51T9Enf//vonYwco6VprMPIVyYXT7tM2qgIIPIFb
 37JMgdwcsl13kR6TzzCGga87RxrKq6u9rr1rqkc0FvncUz1wn+f+uKvDNkMoEUmXL8LDbpfgnxI
 fcYs6pbCev5B+ASfK2rLxN18z2ITEiSkS9bjB87SrZWw==
Message-ID: <3dbe42b8-7f9d-4b67-b903-692860518461@kwiboo.se>
Date: Fri, 21 Jun 2024 08:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/18] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-17-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240620230625.1797397-17-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66752172d60083b892db978b
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

On 2024-06-21 01:06, Simon Glass wrote:
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
> Changes in v3:
> - Split out the refactoring into a separate patch
> - Drop the non-dcache optimisation, since the cache should normally be on
> 
>  drivers/ram/rockchip/sdram_rk3399.c | 47 ++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 3c4e20f4e80..2f37dd712e7 100644
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
> @@ -3138,22 +3144,24 @@ static int rk3399_dmc_init(struct udevice *dev)
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
> -	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> -	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> -	priv->info.base = CFG_SYS_SDRAM_BASE;
> -	priv->info.size =
> -		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> +	if (phase_sdram_init()) {
> +		if (rk3399_dmc_init(dev))
> +			return 0;
> +	} else {
> +		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> +		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> +	}
> +
> +	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {

This check should be dropped, this driver intent is to initialize dram
in first phase (normally TPL), and report the size to any other phase.

The main need for phase_sdram_init() and disable of DCACHE can probably
be avoided if bob/kevin can move to use separate TPL and SPL instead of
doing both dram init and everything else in SPL.

My best guess is that enabling of caches in SPL cause issue for bob and
kevin because they only use SPL not TPL+SPL like (if I am not mistaken)
all other Rockchip arm64 targets.

Using SPL-only was not something I tested when caches was enabled in SPL.

Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
RK3399 boards?

How U-Boot works on these chromebooks is still a mystery to me.

When coreboot is involved it would only load U-Boot proper and SPL or
TPL+SPL would never be involved at all?

If I understand correctly SPL is only involved for bare metal boot, if
this is the case then using TPL + back-to-brom to load SPL should
probably work fine?, and would align all RK3399 boards to work in a
similar way and reduce the need for special care/handling in the code.

Regards,
Jonas

> +		priv->info.base = CFG_SYS_SDRAM_BASE;
> +		priv->info.size =
> +			rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
> +	}
>  
>  	return 0;
>  }
> @@ -3181,10 +3189,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

