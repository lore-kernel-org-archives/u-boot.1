Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3A8D5E120
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 03:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B17388D5A;
	Fri,  8 Nov 2024 04:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RftEXozG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E143188B8F; Fri,  8 Nov 2024 04:29:03 +0100 (CET)
Received: from mail-m19731109.qiye.163.com (mail-m19731109.qiye.163.com
 [220.197.31.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7C788D5A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 227617f5;
 Fri, 8 Nov 2024 11:28:53 +0800 (GMT+08:00)
Message-ID: <ddd3e6ec-d3d4-4ff8-947b-82ba00a28339@rock-chips.com>
Date: Fri, 8 Nov 2024 11:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 2/4] rockchip: rk3399: merge CRU check within
 rk3399_force_power_on_reset
To: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-2-22aa82189eb6@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241106-rk3399-sysreset-gpio-tpl-v2-2-22aa82189eb6@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09OHlYdGEJJTklMS0tLSExWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9309d1539f03afkunm227617f5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6SAw5GDIvGitDS0giN0MT
 OB0KCixVSlVKTEhKS0hNTkhOS0pOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUxJNwY+
DKIM-Signature: a=rsa-sha256;
 b=RftEXozGr5oYJj35dKAdg0DceQ9YPY6L+na+5oTiN5tvYeXVo+BQXnM/f/aqZrh1U+6M3ECaZAk4s9AggfMtmzfupZTKodM7y2iXlgw771aJgjN53gNs4zm/IVOK5BtEaSHmXpOhzX/DhOX2gQRVfaGGqY6WCbASkMLBSp3LI1k=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=aEAFzBckyYDISKI5WkS/V4y8oFsWNDcCup04FOB+RRo=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/11/6 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> To prepare to support forcing power on reset from TPL which would have
> the exact same logic, just in an earlier stage, let's merge the CRU
> check that triggers the power on reset with the rest of the logic.
>
> Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/mach-rockchip/rk3399/rk3399.c | 43 +++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> index edccb2a3980d0e3921aa4073b67aea6a00f18b8d..7b6a822ed04b8151a5da147056dbf73ffdafd149 100644
> --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> @@ -172,9 +172,29 @@ void board_debug_uart_init(void)
>   #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
>   static void rk3399_force_power_on_reset(void)
>   {
> +	const struct rockchip_cru *cru = rockchip_get_cru();
>   	ofnode node;
>   	struct gpio_desc sysreset_gpio;
>   
> +	/*
> +	 * The RK3399 resets only 'almost all logic' (see also in the
> +	 * TRM "3.9.4 Global software reset"), when issuing a software
> +	 * reset. This may cause issues during boot-up for some
> +	 * configurations of the application software stack.
> +	 *
> +	 * To work around this, we test whether the last reset reason
> +	 * was a power-on reset and (if not) issue an overtemp-reset to
> +	 * reset the entire module.
> +	 *
> +	 * While this was previously fixed by modifying the various
> +	 * places that could generate a software reset (e.g. U-Boot's
> +	 * sysreset driver, the ATF or Linux), we now have it here to
> +	 * ensure that we no longer have to track this through the
> +	 * various components.
> +	 */
> +	if (cru->glb_rst_st == 0)
> +		return;
> +
>   	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
>   		debug("%s: trying to force a power-on reset but no GPIO "
>   		      "support in SPL!\n", __func__);
> @@ -206,27 +226,6 @@ void spl_board_init(void)
>   {
>   	led_setup();
>   
> -	if (IS_ENABLED(CONFIG_SPL_GPIO)) {
> -		struct rockchip_cru *cru = rockchip_get_cru();
> -
> -		/*
> -		 * The RK3399 resets only 'almost all logic' (see also in the
> -		 * TRM "3.9.4 Global software reset"), when issuing a software
> -		 * reset. This may cause issues during boot-up for some
> -		 * configurations of the application software stack.
> -		 *
> -		 * To work around this, we test whether the last reset reason
> -		 * was a power-on reset and (if not) issue an overtemp-reset to
> -		 * reset the entire module.
> -		 *
> -		 * While this was previously fixed by modifying the various
> -		 * places that could generate a software reset (e.g. U-Boot's
> -		 * sysreset driver, the ATF or Linux), we now have it here to
> -		 * ensure that we no longer have to track this through the
> -		 * various components.
> -		 */
> -		if (cru->glb_rst_st != 0)
> -			rk3399_force_power_on_reset();
> -	}
> +	rk3399_force_power_on_reset();
>   }
>   #endif
>
