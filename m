Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E1E7542D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AB2686DDB;
	Tue,  3 Oct 2023 09:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hL3lR7d+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D88D86A28; Tue,  3 Oct 2023 09:28:06 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E7887236
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso629808f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696318083; x=1696922883; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=dI1Orn3EJa3HQcc/ggnsfl+sLGf56m79pjP3Xr2ASt4=;
 b=hL3lR7d+bCelcOV5SPcsMlQ0k+RsEOhbOPO5Sj6VTnAW3RQCKOX38XoRe7HaftPeFW
 knVDSgsWvW75kj7zqwdgC8EDbCfF44MXQZ1QeP60Qq0ONjp/qoSjp8OS3IkZuLgP1BKn
 qeT5iTALcKHFNJLi3TbifE9iC4+Y3jreLbSQJn7TP3Ue5NRlZEl/YLAVDVgrXnj1H29B
 U5YKdacgky/PeX6q3EKn0jEIdlRB2wAPU3PvkeneKMBebt6pqGiW0fthH0excFzNb2dN
 APFQHc+QSLdFVIhA7OATZpAO4SP6Hoj0ZaIWM+mfBCXVDjLzXPH2WTj+xz5K8WuZeczp
 bGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696318083; x=1696922883;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dI1Orn3EJa3HQcc/ggnsfl+sLGf56m79pjP3Xr2ASt4=;
 b=hfcF/BhXb6QqUo+Am8M5v9de/+sXaU9UncMadaNadXnfT0RktetXzeNYDXauOXVMQd
 EnY/2KQ+r+qxCnCtieBWaWw0KA26qO3KHPVaIv0rhp9oOXlAglwVDQcQR9dntoHlm8kh
 dzTqto9icnoT5uRfjLZH2D1ewTJvPcTG/IXNXT/LmvQrFgunOuHRLIdkLvB2chYrxnMP
 1pxgKmo2kOJfVz4i8iSmE59VQAkrJp4aEeMTgR7lyVtWXubtBvWHJXQouektz7rS/q5f
 r+XwOK9j9domZZoSN+YL4CEI6pHY859Woc9ovAm+9KQmBrV9j13EwOBQkq0SJC1/K5VN
 sZjA==
X-Gm-Message-State: AOJu0YzHIK5cWbFfjgmgH/HfwFE7qveKMOOOexzcjk3o340SNpdeWlLV
 H7rF6NugJLGxG6qO5GD/d0e9Gw==
X-Google-Smtp-Source: AGHT+IHzoDsxsUdAE1X1rQHkxdWxC+qAx7bNs4ioDUUQkI4RxKCFGPNUqG/G+uyBTytcVIJJrND9lQ==
X-Received: by 2002:a05:6000:11c7:b0:321:6005:8979 with SMTP id
 i7-20020a05600011c700b0032160058979mr12672148wrx.17.1696318082951; 
 Tue, 03 Oct 2023 00:28:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5d4710000000b003179d5aee67sm857666wrq.94.2023.10.03.00.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:28:02 -0700 (PDT)
Message-ID: <60b40445-d790-4f1d-89a8-14b8beb20d9e@linaro.org>
Date: Tue, 3 Oct 2023 09:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 7/8] dwc3: add support for Amlogic A1 family
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-8-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-8-avromanov@salutedevices.com>
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

On 02/10/2023 18:58, Alexey Romanov wrote:
> Now the driver supports also A1 phy layer.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 73 ++++++++++++++++++++++++++----
>   1 file changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 90418ddc1d..550e6682a2 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -28,6 +28,7 @@
>   #include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
> +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>   
>   /* USB2 Ports Control Registers */
>   
> @@ -102,10 +103,22 @@ enum {
>   	PHY_COUNT,
>   };
>   
> -static const char *phy_names[PHY_COUNT] = {
> +static const char *const dwc3_meson_g12a_phy_names[] = {
>   	"usb2-phy0", "usb2-phy1", "usb3-phy0",
>   };
>   
> +static const char *const dwc3_meson_a1_phy_names[] = {
> +	"usb2-phy0", "usb2-phy1"
> +};
> +
> +struct dwc3_meson_g12a;
> +
> +struct dwc3_meson_g12a_drvdata {
> +	const char *const *phy_names;
> +	unsigned int phy_cnt;
> +	int (*clk_init)(struct dwc3_meson_g12a *priv);
> +};
> +
>   struct dwc3_meson_g12a {
>   	struct udevice		*dev;
>   	struct regmap           *regmap;
> @@ -119,6 +132,7 @@ struct dwc3_meson_g12a {
>   #if CONFIG_IS_ENABLED(DM_REGULATOR)
>   	struct udevice		*vbus_supply;
>   #endif
> +	struct dwc3_meson_g12a_drvdata *drvdata;
>   };
>   
>   #define U2P_REG_SIZE						0x20
> @@ -293,10 +307,11 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
>   
>   static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
>   {
> +	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
>   	int i, ret;
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> -		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
> +		ret = generic_phy_get_by_name(priv->dev, data->phy_names[i],
>   					      &priv->phys[i]);
>   		if (ret == -ENOENT || ret == -ENODATA)
>   			continue;
> @@ -354,18 +369,36 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson_g12a *priv)
>   	return 0;
>   }
>   
> +static int dwc3_meson_a1_clk_init(struct dwc3_meson_g12a *priv)
> +{
> +	int ret;
> +
> +	ret = clk_get_by_name(priv->dev, "usb_bus", &priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(&priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static int dwc3_meson_g12a_probe(struct udevice *dev)
>   {
>   	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
> +	struct dwc3_meson_g12a_drvdata *data =
> +		(struct dwc3_meson_g12a_drvdata *)dev_get_driver_data(dev);
>   	int ret, i;
>   
> +	priv->drvdata = data;
>   	priv->dev = dev;
>   
>   	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   	if (ret)
>   		return ret;
>   
> -	ret = dwc3_meson_g12a_clk_init(priv);
> +	ret = data->clk_init(priv);
>   	if (ret)
>   		return ret;
>   
> @@ -398,7 +431,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -407,7 +440,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   			goto err_phy_init;
>   	}
>   
> -	for (i = 0; i < PHY_COUNT; ++i) {
> +	for (i = 0; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -419,7 +452,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
>   	return 0;
>   
>   err_phy_init:
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt ; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -432,20 +465,21 @@ err_phy_init:
>   static int dwc3_meson_g12a_remove(struct udevice *dev)
>   {
>   	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
> +	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
>   	int i;
>   
>   	reset_release_all(&priv->reset, 1);
>   
>   	clk_release_all(&priv->clk, 1);
>   
> -	for (i = 0; i < PHY_COUNT; ++i) {
> +	for (i = 0; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
>   		 generic_phy_power_off(&priv->phys[i]);
>   	}
>   
> -	for (i = 0 ; i < PHY_COUNT ; ++i) {
> +	for (i = 0 ; i < data->phy_cnt; ++i) {
>   		if (!priv->phys[i].dev)
>   			continue;
>   
> @@ -455,8 +489,27 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
>   	return dm_scan_fdt_dev(dev);
>   }
>   
> +static const struct dwc3_meson_g12a_drvdata meson_g12a_drvdata = {
> +	.phy_names = dwc3_meson_g12a_phy_names,
> +	.phy_cnt = ARRAY_SIZE(dwc3_meson_g12a_phy_names),
> +	.clk_init = dwc3_meson_g12a_clk_init,
> +};
> +
> +static const struct dwc3_meson_g12a_drvdata meson_a1_drvdata = {
> +	.phy_names = dwc3_meson_a1_phy_names,
> +	.phy_cnt = ARRAY_SIZE(dwc3_meson_a1_phy_names),
> +	.clk_init = dwc3_meson_a1_clk_init,
> +};
> +
>   static const struct udevice_id dwc3_meson_g12a_ids[] = {
> -	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
> +	{
> +		.compatible = "amlogic,meson-g12a-usb-ctrl",
> +		.data = (ulong)&meson_g12a_drvdata,
> +	},
> +	{
> +		.compatible = "amlogic,meson-a1-usb-ctrl",
> +		.data = (ulong)&meson_a1_drvdata,
> +	},
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
