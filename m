Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B9D41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E73683CF2;
	Thu, 11 Dec 2025 11:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M7V/bGRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7608383B48; Thu, 11 Dec 2025 08:36:31 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726638036B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso4433305e9.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 23:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765438589; x=1766043389; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=npo1mQJbUsFXQeB0CZQfUL/L/ZZjEmZDotNBzwX3IM0=;
 b=M7V/bGRAp5FcGC8D6NhzP9l0VLInSeP09dM1An6MUP2pxV2POGkP7bMy4rWSVaDS2u
 ZqcguTx1bIzmSjr7/0t3pnq++bbQc+Z9uxdUBtmluZ0q44TcDkAhdMFFWtOKGW1GcJJz
 7ZD9TQpImWFnrAsNb5xQLn0Kk282GLuoyySQL3OWgvFBMG4PAb6WGT1QkTPw1CTIk8sG
 QA6Ax7r3ZbvmpE5/AjyPoAP0+siGQIm7N7+JVi7X6ccYCKXWK+DqYQAvLxqdhf+8e2ay
 tmTF0N+S6QdVraE6PPO6bYJNzHr23VU5KQVtDFQXjEuVn6b0wUyKUbEQOT6kJWZLHySA
 qHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765438589; x=1766043389;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npo1mQJbUsFXQeB0CZQfUL/L/ZZjEmZDotNBzwX3IM0=;
 b=j5NjkYRHDgjTCgZQ+xd7p219vlJqLwU6cEVVVWyM7xxP+IvBPu5cks9+q8O7N9uIx+
 Ltu5m80XzGVo/JeOVG88izdrxRG2vNVraw6N1/iSafwrMrARnGb5iPL4RXZZTuoPVSDC
 O0AVAJanFllVN1okWJ297KRCI6QLoiP4YCCMz0pMd7doWG9IA9bNxmYxwjOSZd2z7mYt
 jQ2PLKdAaqaI4BKh6mXJUh3CtRi5a/obpDiXe3joDCzwfWss9FJ7g39RKY6JQ9B5gCNC
 jLss5npDfn5Qzri+km1TeQYcJNBidxcoay2A7KWnkWg+UEbVJSQSBmPLs4RHCggfpSyc
 aNKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpX7WW14SFCBrobdVErKZEglMqmUHDs/wr+3kFP5Gb7iRONJXvLnGRtqGmqEnI9I4J7jpGCug=@lists.denx.de
X-Gm-Message-State: AOJu0YxozHaqeUINwEpv1VAhw+fE5zWFmtvNZMCnMsTZx69tyAfFvncZ
 vSET8i7m0GZKYAOThT+bd8FpdS9vBBdVZhGzaPrMuLpBm9m8Ho9FKoYUT8T5XgT1rtY=
X-Gm-Gg: AY/fxX7oB2tsQusJa14MudeFOeWUH9ZZkbneNQEI9bpd1jyseArq59xYb1MgvD+YPfs
 YTaPoARgzBmeGEEBWYjji0PHMLJopTAnCeIX2PcyC0VePVDM4pE+lTxty8hrNc6vHB1fdvVSE9c
 QfJNXJmKobHPuQfdpWrgIYHt+2piRTdd3+nRXfRxsVjTVQbsAYLH0Y83fhBt/V+4xUaK8tf8EeA
 iqeD3WcEONwAtyBaqymB7E2OCuBogGiUKDEPh7QMtRYz1M3auv2z4HL6JkS6jRHdNPzc6vUkp07
 ihsDmHORhKx6g1G5ViuEVkbB2gSg0xs3f7sY0ejbQPqL1KKqwWKSjVeqQFZm5TU8cEY1jI/Y/LV
 RIvLCoDsRKwDrqiIlTMaQ82uMJYwbYxV3juJZxtVwOPlnGq0mE2Me2flrAQnaAewZ0SIJBWGS5o
 RX3xqtRK/OmeM9wXX9iBBLLTF8TJCvqu2xvmwIQ8wP6Axa+PUg+ncCXfsMqW1U
X-Google-Smtp-Source: AGHT+IF1N8aFrjdaUcHgs6auscYGnkihK3dk0rPCfJfqQdKy7DnRRGqfbWKjKLmsDAN1MT9fuWK/+A==
X-Received: by 2002:a05:600c:6814:b0:477:75eb:a643 with SMTP id
 5b1f17b1804b1-47a8374d614mr48292845e9.4.1765438588690; 
 Wed, 10 Dec 2025 23:36:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6?
 ([2a01:e0a:3d9:2080:1fdc:8c26:84af:4a6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f1e838sm22859005e9.2.2025.12.10.23.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 23:36:28 -0800 (PST)
Message-ID: <ff375374-ce27-46a2-a431-8c3283d3fba3@linaro.org>
Date: Thu, 11 Dec 2025 08:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/4] ufs: rockchip: Add device reset support
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anurag Dutta
 <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Randolph <randolph@andestech.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou
 <me@per1cycle.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen
 <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
 <20251210-rk3576-ufs-v1-3-a3f9e76eb66e@gmail.com>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20251210-rk3576-ufs-v1-3-a3f9e76eb66e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/10/25 21:10, Alexey Charkov wrote:
> Wire up the GPIO line which Rockchip RK3576 UFS controller uses to reset
> the connected UFS device.
> 
> This seems necessary at least for some UFS modules and fixes the following
> error while enumerating UFS storage:
> 
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_link_startup: Device not present
> ufshcd-rockchip ufshc@2a2d0000: link startup failed -6
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_pltfrm_init() failed -6
> 
> Fixes: 76465ce21ee4 ("ufs: rockchip: Add initial support")
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   drivers/ufs/Kconfig        |  1 +
>   drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
>   drivers/ufs/ufs-rockchip.h |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 6c75bb2a0790..30b0c87798e1 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
>   config UFS_ROCKCHIP
>   	bool "Rockchip specific hooks to UFS controller platform driver"
>   	depends on UFS
> +	select DM_GPIO
>   	help
>   	  This selects the Rockchip specific additions to UFSHCD platform driver.
>   
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387da..48444705fb29 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
>    */
>   
> +#include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <clk.h>
>   #include <dm.h>
> @@ -153,11 +154,34 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
>   		return err;
>   	}
>   
> +	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
> +				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +	if (err) {
> +		dev_err(dev, "Warning: cannot get reset GPIO\n");
> +		return err;
> +	}
> +
>   	host->hba = hba;
>   
>   	return 0;
>   }
>   
> +static int ufs_rockchip_device_reset(struct ufs_hba *hba)
> +{
> +	struct ufs_rockchip_host *host = dev_get_priv(hba->dev);
> +
> +	if (!dm_gpio_is_valid(&host->device_reset))
> +		return 0;
> +
> +	dm_gpio_set_value(&host->device_reset, true);
> +	udelay(20);
> +
> +	dm_gpio_set_value(&host->device_reset, false);
> +	udelay(20);
> +
> +	return 0;
> +}
> +
>   static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
>   {
>   	int ret = 0;
> @@ -175,6 +199,7 @@ static struct ufs_hba_ops ufs_hba_rk3576_vops = {
>   	.init = ufs_rockchip_rk3576_init,
>   	.phy_initialization = ufs_rockchip_rk3576_phy_init,
>   	.hce_enable_notify = ufs_rockchip_hce_enable_notify,
> +	.device_reset = ufs_rockchip_device_reset,
>   };
>   
>   static const struct udevice_id ufs_rockchip_of_match[] = {
> diff --git a/drivers/ufs/ufs-rockchip.h b/drivers/ufs/ufs-rockchip.h
> index 3dcb80f57020..50c2539da78a 100644
> --- a/drivers/ufs/ufs-rockchip.h
> +++ b/drivers/ufs/ufs-rockchip.h
> @@ -72,6 +72,7 @@ struct ufs_rockchip_host {
>   	void __iomem *ufs_sys_ctrl;
>   	void __iomem *mphy_base;
>   	struct reset_ctl_bulk rsts;
> +	struct gpio_desc device_reset;
>   	struct clk ref_out_clk;
>   	uint64_t caps;
>   	uint32_t phy_config_mode;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
