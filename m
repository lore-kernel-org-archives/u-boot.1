Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1AEC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 09:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44ACC86C47;
	Tue, 19 Dec 2023 10:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gK+x9yVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6440C869B6; Tue, 19 Dec 2023 10:04:23 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423DA86FD5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 10:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33662243274so1232963f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702976658; x=1703581458; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wCwBI96hCPyq1eGdCGTu94lMgyYYUgenuwQJNXR3950=;
 b=gK+x9yVJ+IaK4pkHmE7ntBhQbGOWt0Zq4IhPPTLDxeqJKEDGyvtExSJh+lpg9BaJzz
 5oexj1QcN9AtRMVMaSr+NWmDYW778p2ez4bIuTGWaAGZARZ6W5PKE1SmrY8SkW4pe1DQ
 0IcKV1RXDqLuJlk2L6D3PzNm12hcyuc8it+/ESZtZ00nrsNQ+vunfLxiBuIO5Qwh9tlH
 MVeCmlwWvjlJmzF/m0+gRVG2EepFopAjfPgZ+Bmdy+4Irm7sC8DwCSeMbQY+p0wW66Bk
 9P1z6Bsae6eGUH+BwnzNAwVNIvp+kUKODx6XnZtZEwqpca9/RZBr4pf+SIWs6s+RYTiU
 8iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702976658; x=1703581458;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wCwBI96hCPyq1eGdCGTu94lMgyYYUgenuwQJNXR3950=;
 b=gcYmnwFmOdHFh4INSc7o114BFHJmG4irYysWfiqtH+9r2frFhmIvm9izD+h6O4VQUG
 N9f6Mf9AhmSPUezAfxDMQV6fZIPJCWzeU0Chv1YlF4/07gPtO3jUOQuH0wKIcwxkAlGh
 3nn667yHiaPyph/jXdBarzyj0AdylRps4OZsinOup908Ipo61gofCRLv9heEHdwDLWy9
 Wr+aoY0Tsj2oa4IRlCae56mdwcqdAvQHvJ6z8vBLHLA1+f9OO4/MLKvoOroqyllXsnDS
 HhagKcFJkNO41PZLyYL1E/ORlqRkZf+hZeRkeE5gBhPooAQ7ny1xnBY15dPvoHiTPB5M
 2XJA==
X-Gm-Message-State: AOJu0Ywgt2P7FrIf+ss14Q7mex6A+hOig3tnr+89Lw5V6DjvZtMPaA7W
 VGYfetzodICrc9WYl6eFjM2h4w==
X-Google-Smtp-Source: AGHT+IHgCd1oORXFxjnhujE16CuQUxxN7qcpsch9jnFIMYa4IOc0OJ/dxJbpaFQoYXLNmA1UbhALqA==
X-Received: by 2002:adf:f58d:0:b0:336:68c1:36fa with SMTP id
 f13-20020adff58d000000b0033668c136famr377800wro.5.1702976658455; 
 Tue, 19 Dec 2023 01:04:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e99:1baf:483a:7533?
 ([2a01:e0a:982:cbb0:e99:1baf:483a:7533])
 by smtp.gmail.com with ESMTPSA id
 f10-20020adff8ca000000b003365951cef9sm10469574wrq.55.2023.12.19.01.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 01:04:17 -0800 (PST)
Message-ID: <fbdad616-21a0-4fe1-84b8-a5110ca2cd7d@linaro.org>
Date: Tue, 19 Dec 2023 10:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 02/17] video: dw_hdmi: Add Vendor PHY handling
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
 <20231218191114.129329-3-jagan@amarulasolutions.com>
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
In-Reply-To: <20231218191114.129329-3-jagan@amarulasolutions.com>
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

On 18/12/2023 20:10, Jagan Teki wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.
> 
> Extend the vendor phy handling by adding platform phy hooks.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
> Changes for v2:
> - fix meson cfg
> 
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

Sorry but I still don't understand why you need phy_force_vendor & phy_ops,
this code clearly fails if you have phy_force_vendor=true && phy_ops=NULL,
so drop phy_force_vendor and simply use phy_ops if != NULL, and since it's
the only element of dw_hdmi_plat_data, drop dw_hdmi_plat_data and pass
dw_hdmi_phy_ops directly in the dw_hdmi struct.

So in dw_hdmi_detect_phy(), if hdmi->ops is NULL, set it to dw_hdmi_synopsys_phy_ops.

Neil

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
> index 5db01904b5..d0d878b6af 100644
> --- a/drivers/video/meson/meson_dw_hdmi.c
> +++ b/drivers/video/meson/meson_dw_hdmi.c
> @@ -375,6 +375,15 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *hdmi)
>   	return -ETIMEDOUT;
>   }
>   
> +static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops = {
> +	.phy_set = meson_dw_hdmi_phy_init,
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

