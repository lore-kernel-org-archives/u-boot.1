Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B702C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 10:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FD787F09;
	Mon, 11 Mar 2024 11:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ckX2s3Zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B3C87F10; Mon, 11 Mar 2024 11:08:02 +0100 (CET)
Received: from mail-m6019.netease.com (mail-m6019.netease.com [210.79.60.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD0D87EF5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 11:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ckX2s3ZrCTD9gB7lj59zNkyhUAkuqggpkoy54qG7Mx/8Pnu/JNFmv1BUGfBZeGBL7BYcuKs8try9IA7oQbx3DS6XDc9knj6gmvJpnf7OMjJhnCRXU0Ta/d4Igx2Qnuksh62yOtRPyKDZKrkMaMmQEWTMgTS3yrQUDByaV/phZW8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=5m1cxGkSq5sxBfaDM19YQfgMcaB10VlyjRJemgI/sIc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 10339900369;
 Mon, 11 Mar 2024 18:07:46 +0800 (CST)
Message-ID: <5773dfdf-02b3-4dd9-b6e6-73aaf53f00e8@rock-chips.com>
Date: Mon, 11 Mar 2024 18:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] regulator: rk8xx: remove unused functions
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
 <20240304-rk3588-saradc-v3-2-7424e2ed5d3b@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240304-rk3588-saradc-v3-2-7424e2ed5d3b@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktNS1ZLH0IYHUxJGUJKTU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cfb8f7603a9kunm10339900369
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6Mzo4OTMXFjAKMhwiTxUx
 CzoKFA1VSlVKTEpLSk5KTU1MQk5JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUtKNwY+
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


On 2024/3/4 19:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Those two functions had their last user removed in commit f9c68a566c4d
> ("rockchip: phycore_rk3288: remove phycore_init() function") part of
> v2023.01 release, so let's do some cleanup here.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   drivers/power/regulator/rk8xx.c | 31 -------------------------------
>   include/power/rk8xx_pmic.h      |  2 --
>   2 files changed, 33 deletions(-)
>
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index e80bd6c3723..97d73ac95e0 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -210,14 +210,6 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
>   };
>   #endif
>   
> -static const u16 rk818_chrg_cur_input_array[] = {
> -	450, 800, 850, 1000, 1250, 1500, 1750, 2000, 2250, 2500, 2750, 3000
> -};
> -
> -static const uint rk818_chrg_shutdown_vsel_array[] = {
> -	2780000, 2850000, 2920000, 2990000, 3060000, 3130000, 3190000, 3260000
> -};
> -
>   static const struct rk8xx_reg_info *get_buck_reg(struct udevice *pmic,
>   						 int num, int uvolt)
>   {
> @@ -1160,26 +1152,3 @@ int rk8xx_spl_configure_buck(struct udevice *pmic, int buck, int uvolt)
>   
>   	return _buck_set_enable(pmic, buck, true);
>   }
> -
> -int rk818_spl_configure_usb_input_current(struct udevice *pmic, int current_ma)
> -{
> -	uint i;
> -
> -	for (i = 0; i < ARRAY_SIZE(rk818_chrg_cur_input_array); i++)
> -		if (current_ma <= rk818_chrg_cur_input_array[i])
> -			break;
> -
> -	return pmic_clrsetbits(pmic, REG_USB_CTRL, RK818_USB_ILIM_SEL_MASK, i);
> -}
> -
> -int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int uvolt)
> -{
> -	uint i;
> -
> -	for (i = 0; i < ARRAY_SIZE(rk818_chrg_shutdown_vsel_array); i++)
> -		if (uvolt <= rk818_chrg_shutdown_vsel_array[i])
> -			break;
> -
> -	return pmic_clrsetbits(pmic, REG_USB_CTRL, RK818_USB_CHG_SD_VSEL_MASK,
> -			       i);
> -}
> diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
> index 3cbfc021956..0db82419d4f 100644
> --- a/include/power/rk8xx_pmic.h
> +++ b/include/power/rk8xx_pmic.h
> @@ -233,7 +233,5 @@ struct rk8xx_priv {
>   };
>   
>   int rk8xx_spl_configure_buck(struct udevice *pmic, int buck, int uvolt);
> -int rk818_spl_configure_usb_input_current(struct udevice *pmic, int current_ma);
> -int rk818_spl_configure_usb_chrg_shutdown(struct udevice *pmic, int uvolt);
>   
>   #endif
>
