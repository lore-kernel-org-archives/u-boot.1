Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F08EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 089B087060;
	Mon, 21 Aug 2023 15:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692625314;
	bh=Z2nmvFAOsBV7lLpK6ThxafDx/nFV9YHuVvx05jY7hBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M7AYmjVFbb6SbPuXL/AysJ8Etz6+QFdSsVI2G7YGp6AmAEk3f4C05/jGYV1gQybed
	 ID9xBR7gZMDyAHp3uZIqSKPjZcQv5kiZUragXBK3MJvc8mH/ZUXm6+RhNz0cEj4cMW
	 gf+tw+fb9qPx+E/JRXCUL8Lg8A0FNbIjKCWOx3/Mf+BOdaHaAuSc8u32C3c1SvweUt
	 cqMkSvUbJ3plTNJO/yAbQr4S4uk/ricumVxVDsbgmx5KyWp/ycSOe3wAyh9s+WBHEC
	 s49IelaJg0qxqCkCn+KvI6XaRY/9RatB1cxp1xjx/q82dUDgMc4iMQQKxTJx/aKlTP
	 v6f91gsTSn+eQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3EFE18705B;
 Mon, 21 Aug 2023 15:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692625312;
 bh=Z2nmvFAOsBV7lLpK6ThxafDx/nFV9YHuVvx05jY7hBo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rAgcskdUgTVP7hYIxDXxOe7QX9glkkUNnAaSr3Pws5SN12MVrq2yEp1tJDUhmmkTt
 Ix5jSgCaeiYkKYgWXno0tJaim+mIsR+15AmykDDskBa+Ecvy2Jw/wKjSfdlkHomuzi
 RjkU26P7365HddSoNPxos3HgKUy0UQ7VqyuSvBN5i6r0gKUdqW9mUGOl+MXlVrdzmD
 7wpipXCuoN+lnl3sgQsFPBCivszePabgjgxCsFFxPotNDWjVW6u9xR9YAeRTpq2uRY
 f6M1veGmCjaMB0bFxhufzagSYc6Y1K74OOL1KV7jMz667WEaTjNCTjrBNSx1sYVsOP
 n4tIM608e+Opg==
Message-ID: <8864abd1-58c9-d529-9084-4707077f4f21@denx.de>
Date: Mon, 21 Aug 2023 15:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/1] usb: host: tegra: implement dts based xcvr setup
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20230821111953.5919-1-clamor95@gmail.com>
 <20230821111953.5919-2-clamor95@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230821111953.5919-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/21/23 13:19, Svyatoslav Ryhel wrote:
> Some devices (like ASUS TF201) may not use fuse based xcvr setup
> which will result in not working USB line. To fix this situation
> allow xcvr setup to be performed from device tree values if
> nvidia,xcvr-setup-use-fuses is not defined.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/usb/host/ehci-tegra.c | 48 +++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index 2cf1625670..a9aee908f3 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -81,6 +81,8 @@ struct fdt_usb {
>   	enum periph_id periph_id;/* peripheral id */
>   	struct gpio_desc vbus_gpio;	/* GPIO for vbus enable */
>   	struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
> +	bool xcvr_setup_use_fuses; /* Indicates that the value is read from the on-chip fuses */
> +	u32 xcvr_setup;	/* Input of XCVR cell, HS driver output control */
>   };
>   
>   /*
> @@ -464,10 +466,16 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>   
>   		/* Recommended PHY settings for EYE diagram */
>   		val = readl(&usbctlr->utmip_xcvr_cfg0);
> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
> -				0x4 << UTMIP_XCVR_SETUP_SHIFT);
> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
> -				0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
> +
> +		if (!config->xcvr_setup_use_fuses) {
> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
> +					config->xcvr_setup <<
> +					UTMIP_XCVR_SETUP_SHIFT);
> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
> +					config->xcvr_setup <<
> +					UTMIP_XCVR_SETUP_MSB_SHIFT);
> +		}
> +
>   		clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>   				0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>   		writel(val, &usbctlr->utmip_xcvr_cfg0);
> @@ -522,7 +530,9 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
>   	setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>   
>   	clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
> -	setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
> +
> +	if (config->xcvr_setup_use_fuses)
> +		setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>   
>   	/*
>   	 * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
> @@ -843,6 +853,8 @@ static const struct ehci_ops tegra_ehci_ops = {
>   static int ehci_usb_of_to_plat(struct udevice *dev)
>   {
>   	struct fdt_usb *priv = dev_get_priv(dev);
> +	u32 usb_phy_phandle;
> +	ofnode usb_phy_node;
>   	int ret;
>   
>   	ret = fdt_decode_usb(dev, priv);
> @@ -851,6 +863,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
>   
>   	priv->type = dev_get_driver_data(dev);
>   
> +	ret = ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_phandle);
> +	if (ret) {
> +		log_debug("%s: required usb phy node isn't provided\n", __func__);
> +		priv->xcvr_setup_use_fuses = true;
> +		return 0;
> +	}
> +
> +	usb_phy_node = ofnode_get_by_phandle(usb_phy_phandle);
> +	if (!ofnode_valid(usb_phy_node)) {
> +		log_err("%s: failed to find usb phy node\n", __func__);
> +		return -EINVAL;
> +	}

Can we get a simple PHY driver instead of this hackage please ?

See the generic PHY stuff in other ehci drivers for example of how to 
interact with PHY drivers, and drivers/phy/ for PHY driver examples.
