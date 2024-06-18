Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3977C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF8E88381;
	Tue, 18 Jun 2024 17:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724619;
	bh=AoHAeZla5RpbiUp+QprbMDfbwPICrv7f7NbSCs6Dz4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pIS1qWlbZwxcJSNRnhHt/bM7ZtCIlTUY9+Cvsv19RP7z+KQmfKm1FzAQOs4HKSkwC
	 OGfZ7FBh1TXYvYNvv6UHjGbgByAyWcKmFpQtAGQKv1mMURIXj6HU21aZlP1PGHOuxM
	 h+MLeWtVu3MCtforiGAlThEupXl/9plGn3CojgP5wqQrlX5W+nJZ3aVW3b3CGENchN
	 eiQ/xFWMpumIUnRd+OIbKr8EZ0L3uN5r4QCWS/EfcVcyN/AolNPh4LeZsrzhsGL49I
	 L/hYNpgRMHgFO2JvaWR0rp12AnzOCQcn+z+0hY5McW2eQ/JeACOwhbjL5YzVX+tRVK
	 QDJSCixmsRarA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ECBA78834B;
 Tue, 18 Jun 2024 17:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718724616;
 bh=AoHAeZla5RpbiUp+QprbMDfbwPICrv7f7NbSCs6Dz4c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yo1icMn2CSoSaCPdYmXIKfHzzq+26MfN4eblpig+b5e2GnKydmSVfu0leUvwejNpL
 bAROqEQt75dFv+q1G+XksJfHwfy21lRglBKvMWJgXUJAnSjGNwYTb+f6oOv8gZKbjh
 D4U+uifSM00ft2X9Yav+E3Cc0bh5pDeRRaVsrF9x3m5JQZXhqp6sm9OyJI1jfOCahK
 n4+cA4WJ1jdfjFgUwMvnVaKQ3EEAMOnwuaCdBNGCthARoqco1eLwL5EaE83o5J/rsj
 PTJwB65r35LYYqHrCxM1gjzRGpvap1vaJfyZ5w1bZn99AiY8JP9DwtNvbdScvjGi+d
 QYzJz2Bewd8Ow==
Message-ID: <e52e6f28-94c7-4c2c-94d9-e1185829b6e7@denx.de>
Date: Tue, 18 Jun 2024 16:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] phy: meson-gxl-usb2: add set_mode callback
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-1-6b41efa46e35@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-1-6b41efa46e35@linaro.org>
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

On 6/18/24 9:55 AM, Neil Armstrong wrote:
> Implement set_mode callback by calling the current public
> function.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/phy/meson-gxl-usb2.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
> index 92c285103c..e051e66224 100644
> --- a/drivers/phy/meson-gxl-usb2.c
> +++ b/drivers/phy/meson-gxl-usb2.c
> @@ -150,6 +150,28 @@ void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
>   	phy_meson_gxl_usb2_reset(priv);
>   }
>   
> +static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	if (submode)
> +		return -EOPNOTSUPP;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_DEVICE:
> +		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
> +		break;
> +
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_OTG:
> +		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int phy_meson_gxl_usb2_power_on(struct phy *phy)
>   {
>   	struct udevice *dev = phy->dev;
> @@ -161,7 +183,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
>   	val &= ~U2P_R0_POWER_ON_RESET;
>   	regmap_write(priv->regmap, U2P_R0, val);
>   
> -	phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);

Could you rename this ^ to some phy_meson_gxl_usb2_set_mode_inner() and ...

> +	_phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);

... remove the leading underscore here.

>   	return 0;
>   }
> @@ -183,6 +205,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>   struct phy_ops meson_gxl_usb2_phy_ops = {
>   	.power_on = phy_meson_gxl_usb2_power_on,
>   	.power_off = phy_meson_gxl_usb2_power_off,
> +	.set_mode = _phy_meson_gxl_usb2_set_mode,

... and here ?

[...]
