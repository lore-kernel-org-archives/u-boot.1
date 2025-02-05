Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A25C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 22:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F6180104;
	Wed,  5 Feb 2025 23:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U+wluv1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADD1807A7; Wed,  5 Feb 2025 23:18:14 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8491800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 23:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738793889;
 bh=zmvqglwcLOkezHVCTogWRoS2q+h14tfQoO1P/OnHuKQ=;
 b=U+wluv1gX1m3vG2EE4Wmp6Szo1nxMXA2mzCvHXY1BXMaFbwHeFBF0/YCRbWp6MIN6kXjv7OOi
 pXnHbhJBj74resqoB8noezO1qDU5/OgJQE2qUOBvNElP2AEyKctpd0k4cpEw69F98BdtgRfBYUR
 /bNQS/0GV+WU07tUSdzduS1NRB/xNlXvsQv08ZrwXXcWxNhI54Q1xqz3mHoUtZjgcZMo2D1+vwd
 FB8lBS78DE094KYcmGBiKfrMDEArMXpAo2WJmlo/9cH5dfIFQ9+RCp3vH6WFBARL5bchW72SZOv
 xmY0CCQLu+Pn86IkZJn501c6xoUHNgBTPmk79nfUuB0Q==
X-Forward-Email-ID: 67a3e39f4f7eea50c61f4945
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
Date: Wed, 5 Feb 2025 23:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-6-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250205015606.2686149-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2025-02-05 02:54, Simon Glass wrote:
> TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
> want to be able to update the RAM-init code in the field.

If I understand your description here, you mean that both TPL and VPL
are meant to be "burned" onto the board and not intended to be updatable?

Is this a typo or do I misunderstand something? Else I do not understand
why you would need TPL->VPL->SPL, please explain.

> 
> So when VPL is being used, init the RAM later, in SPL.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> index 6fa8f268770..9ac16dfdc71 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -194,6 +194,7 @@ struct io_setting {
>  static bool phase_sdram_init(void)
>  {
>  	return xpl_phase() == PHASE_TPL ||
> +		(IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
>  		(!IS_ENABLED(CONFIG_TPL) &&
>  		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
>  		 !not_xpl());
> @@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
>  	.of_to_plat = rk3399_dmc_of_to_plat,
>  	.probe = rk3399_dmc_probe,
>  	.priv_auto	= sizeof(struct dram_info),
> -#if defined(CONFIG_TPL_BUILD) || \
> -	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> +#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
> +	!defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
> +	!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
>  	.plat_auto	= sizeof(struct rockchip_dmc_plat),
>  #endif
>  };

These two conditions are starting to get ridiculous.

With "[PATCH 24/29] rockchip: Allow SPL to set up SDRAM" you are
depending on TPL_RAM to decide if RAM should be initialized. Maybe that
is something we can use here to simplify?

Basically we will have 3 possible DRAM init scenarios to support:
- ROCKCHIP_EXTERNA_TPL=y -> DRAM init happen in external TPL and SPL
  should only read DRAM size
- VPL=y or TPL=n -> both DRAM init and read DRAM size happen in SPL
- TPL=y -> DRAM init in TPL and SPL should only read DRAM size

Regards,
Jonas
