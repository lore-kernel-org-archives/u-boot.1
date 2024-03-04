Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD2CC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F0287F7D;
	Mon,  4 Mar 2024 14:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Jjswyr8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F32CF87F6F; Mon,  4 Mar 2024 14:26:46 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C38D87F8A
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709558803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1u1XG/IZJUxQb4m+9hvPT1OzVrzm+8ab4X95GGL+ww=;
 b=Jjswyr8oQbvHxztY1dkeUPJDg2wEXArXc5yyvWMAeFkP5r3nBeFOdPk6uMPmZCs6qtYNo4
 hDXsCROrcI8aow5zGO1y37JbBcuWQC5ecIix8CrKsh0M2DCaD3WkCMABer9eCtl/UDMr8h
 PJbQ2CXwGHS9S0/aDALtaHgro03XIsiO1TWZYidLJTve7wYlM9x4+YFV+hytjt2X9oKsq+
 dlYBIrUgYCwdc5zy5Fmdp6n7/O4kNcnw1nAU15OXsspp5n+uVuIGUmGeEqV4VOe40Szuq7
 D4f7e2z+8ot2B7U9QbsxpejvVffop4zgANHlGS/bvc48PHf36TIQ0cA0peniyQ==
Date: Mon, 04 Mar 2024 14:26:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v3 02/16] regulator: rk8xx: remove unused functions
In-Reply-To: <20240304-rk3588-saradc-v3-2-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-2-7424e2ed5d3b@theobroma-systems.com>
Message-ID: <d1b4a35e224c75dea85392968f7d13e0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-03-04 12:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Those two functions had their last user removed in commit f9c68a566c4d
> ("rockchip: phycore_rk3288: remove phycore_init() function") part of
> v2023.01 release, so let's do some cleanup here.

These functions could be used on the Pinephone Pro at some point, but
it's still fine to remove them now.  They can be re-added later.

> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  drivers/power/regulator/rk8xx.c | 31 -------------------------------
>  include/power/rk8xx_pmic.h      |  2 --
>  2 files changed, 33 deletions(-)
> 
> diff --git a/drivers/power/regulator/rk8xx.c 
> b/drivers/power/regulator/rk8xx.c
> index e80bd6c3723..97d73ac95e0 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -210,14 +210,6 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
>  };
>  #endif
> 
> -static const u16 rk818_chrg_cur_input_array[] = {
> -	450, 800, 850, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000
> -};
> -
> -static const uint rk818_chrg_shutdown_vsel_array[] = {
> -	2780000, 2850000, 2920000, 2990000, 3060000, 3130000, 3190000, 
> 3260000
> -};
> -
>  static const struct rk8xx_reg_info *get_buck_reg(struct udevice *pmic,
>  						 int num, int uvolt)
>  {
> @@ -1160,26 +1152,3 @@ int rk8xx_spl_configure_buck(struct udevice
> *pmic, int buck, int uvolt)
> 
>  	return _buck_set_enable(pmic, buck, true);
>  }
> -
> -int rk818_spl_configure_usb_input_current(struct udevice *pmic, int 
> current_ma)
> -{
> -	uint i;
> -
> -	for (i = 0; i < ARRAY_SIZE(rk818_chrg_cur_input_array); i++)
> -		if (current_ma <= rk818_chrg_cur_input_array[i])
> -			break;
> -
> -	return pmic_clrsetbits(pmic, REG_USB_CTRL, RK818_USB_ILIM_SEL_MASK, 
> i);
> -}
> -
> -int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int 
> uvolt)
> -{
> -	uint i;
> -
> -	for (i = 0; i < ARRAY_SIZE(rk818_chrg_shutdown_vsel_array); i++)
> -		if (uvolt <= rk818_chrg_shutdown_vsel_array[i])
> -			break;
> -
> -	return pmic_clrsetbits(pmic, REG_USB_CTRL, 
> RK818_USB_CHG_SD_VSEL_MASK,
> -			       i);
> -}
> diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
> index 3cbfc021956..0db82419d4f 100644
> --- a/include/power/rk8xx_pmic.h
> +++ b/include/power/rk8xx_pmic.h
> @@ -233,7 +233,5 @@ struct rk8xx_priv {
>  };
> 
>  int rk8xx_spl_configure_buck(struct udevice *pmic, int buck, int 
> uvolt);
> -int rk818_spl_configure_usb_input_current(struct udevice *pmic, int
> current_ma);
> -int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int 
> uvolt);
> 
>  #endif
