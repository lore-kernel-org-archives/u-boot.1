Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5908C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5778765A;
	Mon, 11 Dec 2023 10:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/Wow4QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421DF87650; Mon, 11 Dec 2023 10:08:30 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5FE8765A
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so4910015e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702285706; x=1702890506; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EdhKwHPEnDo0vYhuASNUBSuhqMtgP9JoEZ+CUlO1s9g=;
 b=l/Wow4QZu8ALuXdilV51Ese++JVB6VvbpV+AJhg2lTeOcb7/5Ac5S4Rk1MlSFaPI+j
 XoZR2u1hS91rlCy9JZRmRWQdT3D3gwdliW2RtXQWSnDxgQFtSu6QbiSL/rwHwmMqh8dX
 keY4sGsM00U7JGhfKJwGuW4n8qgngrPxTmUTLwi5goWKuB1+TZHzu+n0PljGl/2EOdD/
 Qx7m2wfJ6Bqra8CHRpNAjVu1PE+99YVM+iyEIfAIqyWD4TLCFu3JtX5SRLWhr9R1CHO2
 IyIHXnVZRybBalSDGlKfpGRRYgqHM9S4mQMhRQO2xQnGU5LbOFmZkTUGqyheO1AxIcFf
 jKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285706; x=1702890506;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EdhKwHPEnDo0vYhuASNUBSuhqMtgP9JoEZ+CUlO1s9g=;
 b=wvxkELOxjS3zwdsRiejipxv9IKY9AEet8rmv3BBpXAFGyHWumodJEaIYKH4L8TnWe9
 n4bpUvzC0clWFvI40PSnsocLc6miSCtXlqAbDuqR0gv/zb/HBSd5+T7aG5z6sRye9LeN
 9TW2PnrvSHXXhXtTXjs0ypc55RPJvoJB/0HQ9xGdSs9e3UPlaSTRDJwUGsvFB6fPP0JV
 VJNnOJb2W/cy4ZHambPIYpUVEyv8iwQStlsdymXlIaL56xrGMA+vvWaGAC3tU+JvztBQ
 L6zRsnfLw09lKnRK1AzFr3DHmvAV0kO4Mwr962/BQ/l/F2UV3NbjKiXyj9LvW7MWlLMu
 h30g==
X-Gm-Message-State: AOJu0Yz/VWcsqeNNO64NORnd/okzmGhGOKuoWrndbmUmIXBxkt3ay92O
 lvHsI3uLe4WiQ8MeuKk9V0PFMA==
X-Google-Smtp-Source: AGHT+IEjKYtBAfSrgl0FRzeqjnjnKIRliWRZ5ti/3Q8cOlRqWcgwyc8/Hdj3K91u0I9lqhmE5cUbZg==
X-Received: by 2002:a05:600c:3c84:b0:40c:4ca8:6aca with SMTP id
 bg4-20020a05600c3c8400b0040c4ca86acamr159608wmb.109.1702285705603; 
 Mon, 11 Dec 2023 01:08:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23?
 ([2a01:e0a:982:cbb0:302e:e0c2:d42c:cb23])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0040c440f9393sm4627069wmq.42.2023.12.11.01.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 01:08:25 -0800 (PST)
Message-ID: <a963f773-f17c-46e9-b468-ca9e6217ffce@linaro.org>
Date: Mon, 11 Dec 2023 10:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 02/17] video: dw_hdmi: Add Vendor PHY handling
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@edgeble.ai>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <20231211085939.5478-3-jagan@amarulasolutions.com>
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
In-Reply-To: <20231211085939.5478-3-jagan@amarulasolutions.com>
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

On 11/12/2023 09:59, Jagan Teki wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> 
> Extend the vendor phy handling by adding platform phy hooks.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>   drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++++-
>   drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
>   drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
>   drivers/video/rockchip/rk_hdmi.c     |  2 +-
>   drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
>   include/dw_hdmi.h                    | 14 +++++++++++++-
>   6 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> index c4fbb18294..ea12a09407 100644
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
> @@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
>   	return 0;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
> +	.phy_set = dw_hdmi_phy_cfg,
> +};
> +
> +static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
> +{
> +	if (!hdmi->data)
> +		return;
> +
> +	/* hook Synopsys PHYs ops */
> +	if (!hdmi->data->phy_force_vendor) {
> +		hdmi->ops = &dw_hdmi_synopsys_phy_ops;
> +		return;
> +	}
> +
> +	/* Vendor HDMI PHYs must assign phy_ops in plat_data */
> +	if (!hdmi->data->phy_ops) {
> +		printf("Unsupported Vendor HDMI phy_ops\n");
> +		return;
> +	}
> +
> +	/* hook Vendor HDMI PHYs ops */
> +	hdmi->ops = hdmi->data->phy_ops;
> +}
> +
>   void dw_hdmi_init(struct dw_hdmi *hdmi)
>   {
>   	uint ih_mute;
>   
> +	dw_hdmi_detect_phy(hdmi);
> +
>   	/*
>   	 * boot up defaults are:
>   	 * hdmi_ih_mute   = 0x03 (disabled)
> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
> index 5db01904b5..63ca3ac52e 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -375,6 +375,15 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *hdmi)
>   	return -ETIMEDOUT;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops = {
> +	.phy_set = meson_dw_hdmi_phy_cfg,

Pretty sure this should be meson_dw_hdmi_phy_init

> +};
> +
> +static const struct dw_hdmi_plat_data dw_hdmi_meson_plat_data = {
> +	.phy_force_vendor = true,
> +	.phy_ops = &dw_hdmi_meson_phy_ops,
> +};
> +
>   static int meson_dw_hdmi_probe(struct udevice *dev)
>   {
>   	struct meson_dw_hdmi *priv = dev_get_priv(dev);
> @@ -397,7 +406,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>   
>   	priv->hdmi.hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>   	priv->hdmi.hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
> -	priv->hdmi.phy_set = meson_dw_hdmi_phy_init;
> +	priv->hdmi.data = &dw_hdmi_meson_plat_data;
>   	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
>   		priv->hdmi.reg_io_width = 1;
>   	else {
> diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockchip/rk3399_hdmi.c
> index 3041360c6e..b32139a8a6 100644
> --- a/drivers/video/rockchip/rk3399_hdmi.c
> +++ b/drivers/video/rockchip/rk3399_hdmi.c
> @@ -64,8 +64,14 @@ static const struct dm_display_ops rk3399_hdmi_ops = {
>   	.enable = rk3399_hdmi_enable,
>   };
>   
> +static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
> +};
> +
>   static const struct udevice_id rk3399_hdmi_ids[] = {
> -	{ .compatible = "rockchip,rk3399-dw-hdmi" },
> +	{
> +		.compatible = "rockchip,rk3399-dw-hdmi",
> +		.data = (ulong)&rk3399_hdmi_drv_data
> +	},
>   	{ }
>   };
>   
> diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
> index b75a174489..e34f532cd6 100644
> --- a/drivers/video/rockchip/rk_hdmi.c
> +++ b/drivers/video/rockchip/rk_hdmi.c
> @@ -83,6 +83,7 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
>   	struct rk_hdmi_priv *priv = dev_get_priv(dev);
>   	struct dw_hdmi *hdmi = &priv->hdmi;
>   
> +	hdmi->data = (const struct dw_hdmi_plat_data *)dev_get_driver_data(dev);
>   	hdmi->ioaddr = (ulong)dev_read_addr(dev);
>   	hdmi->mpll_cfg = rockchip_mpll_cfg;
>   	hdmi->phy_cfg = rockchip_phy_config;
> @@ -90,7 +91,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
>   	/* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
>   
>   	hdmi->reg_io_width = 4;
> -	hdmi->phy_set = dw_hdmi_phy_cfg;
>   
>   	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>   
> diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
> index 0324a050d0..4b67a1614e 100644
> --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> @@ -369,6 +369,15 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops = {
> +	.phy_set = sunxi_dw_hdmi_phy_cfg,
> +};
> +
> +static const struct dw_hdmi_plat_data dw_hdmi_sunxi_plat_data = {
> +	.phy_force_vendor = true,
> +	.phy_ops = &dw_hdmi_sunxi_phy_ops,
> +};
> +
>   static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
>   {
>   	struct sunxi_dw_hdmi_priv *priv = dev_get_priv(dev);
> @@ -379,7 +388,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
>   	hdmi->i2c_clk_high = 0xd8;
>   	hdmi->i2c_clk_low = 0xfe;
>   	hdmi->reg_io_width = 1;
> -	hdmi->phy_set = sunxi_dw_hdmi_phy_cfg;
> +	hdmi->data = &dw_hdmi_sunxi_plat_data;
>   
>   	ret = reset_get_bulk(dev, &priv->resets);
>   	if (ret)
> diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> index 8acae3839f..4ad8b39f84 100644
> --- a/include/dw_hdmi.h
> +++ b/include/dw_hdmi.h
> @@ -534,6 +534,17 @@ struct hdmi_data_info {
>   	struct hdmi_vmode video_mode;
>   };
>   
> +struct dw_hdmi;
> +
> +struct dw_hdmi_phy_ops {
> +	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
> +};
> +
> +struct dw_hdmi_plat_data {
> +	bool phy_force_vendor;
> +	const struct dw_hdmi_phy_ops *phy_ops;
> +};

Why do you need a separate phy_ops and this phy_force_vendor ?

Simply use the provided phy_ops is pointer != NULL

I think simply use a single struct passed as pdata to have:

if (!hdmi->data)
	hdmi->ops = &dw_hdmi_synopsys_phy_ops;
else
	/* hook Vendor HDMI PHYs ops */
	hdmi->ops = hdmi->data;

Neil

> +
>   struct dw_hdmi {
>   	ulong ioaddr;
>   	const struct hdmi_mpll_config *mpll_cfg;
> @@ -543,8 +554,9 @@ struct dw_hdmi {
>   	u8 reg_io_width;
>   	struct hdmi_data_info hdmi_data;
>   	struct udevice *ddc_bus;
> +	const struct dw_hdmi_phy_ops *ops;
> +	const struct dw_hdmi_plat_data *data;
>   
> -	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
>   	void (*write_reg)(struct dw_hdmi *hdmi, u8 val, int offset);
>   	u8 (*read_reg)(struct dw_hdmi *hdmi, int offset);
>   };

