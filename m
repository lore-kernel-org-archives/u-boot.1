Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AE3C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 08:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04608799E;
	Wed, 17 Jan 2024 09:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RBIKZgs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4747F87990; Wed, 17 Jan 2024 09:58:19 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD659879BA
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e76626170so31228745e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705481896; x=1706086696; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J/zfmteF/frkLtpsCcNRbMigxNcCxGFPRRhu/FyOtp0=;
 b=RBIKZgs6Jx6M+mXg2GUdoRFCxEUq2qmn3fJ5TYUk43MEXTdEl5l0AWprPhSR5WruFa
 pbqetg0U3Hi/voCBUMGaR4CITT/+0NOVScchjaRzconCVxtsE66U0d7VwR0G0RNhzf5U
 T4vcl0xwqOdrxt/YP/eqAY1XJkI5iJ/89STfCmBeA4efpSSEs02ZLcZ7P4EV7MIgSDCv
 Rp7acKu5P5emzOFAZB+3XSOyFnbmpqmtOnJ1sP4V3N5zIFtVAQcaOj4Nq8AyBl3LzZmW
 WHn5iIJu0x/GlBVeFjb5EG08H7+CZ2F/SBkvzQ+kUfBOm5JXHfbEUxAcW2BVY+ZbCeSt
 hJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705481896; x=1706086696;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J/zfmteF/frkLtpsCcNRbMigxNcCxGFPRRhu/FyOtp0=;
 b=wMufNb7PLfhNCCUVqKIsyWsfLcjhXaahYfnN2Dpx835jn8QU1VIErN4gdcJ8TktQwn
 tCkFkZE3yi8aIGYZGkUUgk/rCHkmkGs1vfQyYgxV2ZNq/Cw2l6pUrfDgGn9wE5BX/IBI
 LRVGlFAc8Ei+00WL4GMKwqFSlFzrt2IXcSyVpmQF3iogDcacz0wBQs7qKnGATkEpy2qL
 eV1sCWQiPOLKSZV5mAdOi40BBFGgVutXNle5UVus2qt4K5Z71k49UrJT0u5P4Vfj/Iex
 fnA84TXY/GVL6p8lVOiHYq3pmAXIxiT7MwSYLR0Kp0iXv8R12ZxnyKzj+tKUzFC6QfAY
 PSew==
X-Gm-Message-State: AOJu0YyB3KD49bun+2+mdnVzS7sSN6Wci44FEdVzac2u8/R2t6Ln8TLe
 NQMX08S89Dk3s6Mi0Em5IykTR3zbDSugrA==
X-Google-Smtp-Source: AGHT+IESTKarrdEFCkWs6dVoaWcrkEVRDraGW/yECTQ1DQw27/53iqzzO7z+jtrfAC3q22griVguFw==
X-Received: by 2002:a05:600c:a0a:b0:40e:52de:1571 with SMTP id
 z10-20020a05600c0a0a00b0040e52de1571mr4628133wmp.18.1705481896134; 
 Wed, 17 Jan 2024 00:58:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1?
 ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040e76b60235sm10528547wmq.8.2024.01.17.00.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:58:15 -0800 (PST)
Message-ID: <a4466fdf-623b-4eca-9df0-ba6658d2978c@linaro.org>
Date: Wed, 17 Jan 2024 09:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 02/17] video: dw_hdmi: Add Vendor PHY handling
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-3-jagan@amarulasolutions.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240117075154.58747-3-jagan@amarulasolutions.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 17/01/2024 08:51, Jagan Teki wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> 
> Extend the vendor phy handling by adding platform phy hooks.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
> Changes for v3:
> - drop data
> - assign ops directly
> Changes for v2:
> - fix meson cfg
> 
>   drivers/video/dw_hdmi.c             | 10 +++++++++-
>   drivers/video/meson/meson_dw_hdmi.c |  6 +++++-
>   drivers/video/rockchip/rk_hdmi.c    |  1 -
>   drivers/video/sunxi/sunxi_dw_hdmi.c |  6 +++++-
>   include/dw_hdmi.h                   |  8 +++++++-
>   5 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> index c4fbb18294..4914ba6146 100644
> --- a/drivers/video/dw_hdmi.c
> +++ b/drivers/video/dw_hdmi.c
> @@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
>   
>   	hdmi_av_composer(hdmi, edid);
>   
> -	ret = hdmi->phy_set(hdmi, edid->pixelclock.typ);
> +	ret = hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
>   	if (ret)
>   		return ret;
>   
> @@ -1009,10 +1009,18 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
>   	return 0;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
> +	.phy_set = dw_hdmi_phy_cfg,
> +};
> +
>   void dw_hdmi_init(struct dw_hdmi *hdmi)
>   {
>   	uint ih_mute;
>   
> +	/* hook Synopsys PHYs ops */
> +	if (!hdmi->ops)
> +		hdmi->ops = &dw_hdmi_synopsys_phy_ops;
> +
>   	/*
>   	 * boot up defaults are:
>   	 * hdmi_ih_mute   = 0x03 (disabled)
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 5db01904b5..259af1b457 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -375,6 +375,10 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *hdmi)
>   	return -ETIMEDOUT;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops = {
> +	.phy_set = meson_dw_hdmi_phy_init,
> +};
> +
>   static int meson_dw_hdmi_probe(struct udevice *dev)
>   {
>   	struct meson_dw_hdmi *priv = dev_get_priv(dev);
> @@ -397,7 +401,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>   
>   	priv->hdmi.hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>   	priv->hdmi.hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
> -	priv->hdmi.phy_set = meson_dw_hdmi_phy_init;
> +	priv->hdmi.ops = &dw_hdmi_meson_phy_ops;
>   	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
>   		priv->hdmi.reg_io_width = 1;
>   	else {
> diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
> index b75a174489..d5b5a529d2 100644
> --- a/drivers/video/rockchip/rk_hdmi.c
> +++ b/drivers/video/rockchip/rk_hdmi.c
> @@ -90,7 +90,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
>   	/* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
>   
>   	hdmi->reg_io_width = 4;
> -	hdmi->phy_set = dw_hdmi_phy_cfg;
>   
>   	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>   
> diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
> index 0324a050d0..986e69d66b 100644
> --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> @@ -369,6 +369,10 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops = {
> +	.phy_set = sunxi_dw_hdmi_phy_cfg,
> +};
> +
>   static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
>   {
>   	struct sunxi_dw_hdmi_priv *priv = dev_get_priv(dev);
> @@ -379,7 +383,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
>   	hdmi->i2c_clk_high = 0xd8;
>   	hdmi->i2c_clk_low = 0xfe;
>   	hdmi->reg_io_width = 1;
> -	hdmi->phy_set = sunxi_dw_hdmi_phy_cfg;
> +	hdmi->ops = &dw_hdmi_sunxi_phy_ops;
>   
>   	ret = reset_get_bulk(dev, &priv->resets);
>   	if (ret)
> diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> index 8acae3839f..17bdd2dbf9 100644
> --- a/include/dw_hdmi.h
> +++ b/include/dw_hdmi.h
> @@ -534,6 +534,12 @@ struct hdmi_data_info {
>   	struct hdmi_vmode video_mode;
>   };
>   
> +struct dw_hdmi;
> +
> +struct dw_hdmi_phy_ops {
> +	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
> +};
> +
>   struct dw_hdmi {
>   	ulong ioaddr;
>   	const struct hdmi_mpll_config *mpll_cfg;
> @@ -543,8 +549,8 @@ struct dw_hdmi {
>   	u8 reg_io_width;
>   	struct hdmi_data_info hdmi_data;
>   	struct udevice *ddc_bus;
> +	const struct dw_hdmi_phy_ops *ops;
>   
> -	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
>   	void (*write_reg)(struct dw_hdmi *hdmi, u8 val, int offset);
>   	u8 (*read_reg)(struct dw_hdmi *hdmi, int offset);
>   };

That's much better!
Thanks!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
