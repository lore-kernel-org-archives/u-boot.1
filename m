Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC222C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D90982CC9;
	Mon,  7 Apr 2025 09:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a+ZFy5h6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8851D82CD5; Mon,  7 Apr 2025 09:31:18 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242C182CEA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso36889775e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744011073; x=1744615873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DgnzGwMFqik1SgYBiNQCjGEuVxTfpGngc2l6gVfiw6g=;
 b=a+ZFy5h6z+pOxRZLE6T96zDtn4XQzXOOqN4LZZcSLp3wRIs7gVbuGvUSGAbAT4RFar
 1N26bMYJnW4yt/cSHZCIedRkiE3OqjxznvADYnSbsjUOQpVcyBVwAcUOBkJ36xhdRlP0
 ZdyTar8mjtcG3sZJmyBB/qnOeL4Hhfsi+Iq7LPNyV3CqmGG0RrT5tqQdPY8f7foNLGzi
 o6L9LvW41Vf2MsWHF66l8kiIDZPzZDrnuIalrlKMGM4HWfsOtV1200QxqhGWyt3xYcfv
 ebUeTl/qio3hP1NroRYLDH/JH13EwaUU8v3NTOCw0kOEuAlp4qlgdbwn5vcmUP4lDsrS
 UPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744011073; x=1744615873;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DgnzGwMFqik1SgYBiNQCjGEuVxTfpGngc2l6gVfiw6g=;
 b=djhK+tKdwQFtm7tnesnR+7zvjqUcBfFCJyHsSD23ysTs5ri7gK4tqEE0FWLMr7bO16
 NvWlWTuTuUWTe5I4E7ZmwfFGsayNC5ghZ2+qY14Fih4q6CrCGKvI+UX5cLGDt5Uh1IX7
 brwuVm2dMFlu2SKc/INDPEpXQ/nuRKgTC6oGiinuLz2L4dl0LjddIsk3pNOnnBCPjsN0
 /N8lOoHy0JV8CdwmoPN8PIKGhBoH+Zjqt3Oni+zDraX1e6U0gUjshRUnmXwYWrp61nDY
 UHsYmvmmwtU4mBAZgXSagtt8Sbo2C0SulqDtsU8kb7g493kE4A8r8scEcMzVgaMnFYXl
 FzWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0dS8F1uiKb08PWFAboiaYHkMr5b+6YxA/qfHkLWf/7RWA80ELqcLeNsDgAXyahPfop9WtgY=@lists.denx.de
X-Gm-Message-State: AOJu0YzO45RlajnRHZRHusFUfQ+mDnfTf3HdUi2e+4caXpBVQ0jD/243
 vhup8RPRtuP7Em/QrKUYqcvtxW3DWSf9CCnlPZuB2Xp+kDfnwdEchotdU316sW0=
X-Gm-Gg: ASbGncv8CfdhyiHE2XDc/F45SQxh/a8HBTK/yXm4rhn6SMm96zzAxV86NUSk7P+3sUF
 B3tWxCFA1UJznbekaNfmRifM2+Pe5hdPqtg11NZfE/wHCXx+9GWReXfxDhi7YWUTlNr5aOU3ZLZ
 fVf6OlOjRd+pBJmSmZ/IgQENPrb4A2U0UWz2LbjKRwDUrqnuXPEIqUN6eKA4DJHz0tdWXbF8cOp
 j/X51bRma89qu2gTOPjtCldBAZWXp9mbsR9gcf8L4e9lrTEF4BSAofRqCx8I3p8L0uWcB4FvGcZ
 ElKhiwhqIpb3AJLeDlmmF+EXzNHMT4ktuTrnovSPOqSze7aGGcAs6cut3n2hB28r/7yQ7FfyO2x
 q0+rv36kwr8EIMJMPYxeyJzwQ+vEIER+X
X-Google-Smtp-Source: AGHT+IGKouIVklPCbGrSKaug/gqd+EHqloSYS9rQkTIIgWb44V8eeNca05mOMdTCp+6vP4Bk0eV0lg==
X-Received: by 2002:a05:600c:1ca4:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43ecf842872mr94418695e9.7.1744011073425; 
 Mon, 07 Apr 2025 00:31:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bbd9csm120195355e9.20.2025.04.07.00.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:31:13 -0700 (PDT)
Message-ID: <65a0b534-cd01-4fb9-a4b9-f135a6ca0fe8@linaro.org>
Date: Mon, 7 Apr 2025 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] net: designware: Mark drivers as having active DMA
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jim Liu <jim.t90615@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-3-sjg@chromium.org>
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
In-Reply-To: <20250407013513.638110-3-sjg@chromium.org>
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

On 07/04/2025 03:35, Simon Glass wrote:
> Network devices which use this driver have DMA running while receiving
> packages. Add the required flag to driver model so that they will be
> removed before starting the OS.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Add a new patch to mark drivers as having active DMA
> 
>   drivers/net/designware.c    | 2 +-
>   drivers/net/dwmac_meson8b.c | 2 +-
>   drivers/net/dwmac_s700.c    | 2 +-
>   drivers/net/dwmac_socfpga.c | 2 +-
>   drivers/net/gmac_rockchip.c | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 5385849ea6b..9b2b0a5d602 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -885,7 +885,7 @@ U_BOOT_DRIVER(eth_designware) = {
>   	.ops	= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dw_eth_pdata),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
>   
>   static struct pci_device_id supported[] = {
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index bf94e50842d..95a99a98e99 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -162,5 +162,5 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_meson8b_plat),
> -	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
> index e78193f3376..21df8e3ce81 100644
> --- a/drivers/net/dwmac_s700.c
> +++ b/drivers/net/dwmac_s700.c
> @@ -64,5 +64,5 @@ U_BOOT_DRIVER(dwmac_s700) = {
>   	.ops    = &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct eth_pdata),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
> index dda33f90d65..9f262aaee60 100644
> --- a/drivers/net/dwmac_socfpga.c
> +++ b/drivers/net/dwmac_socfpga.c
> @@ -145,5 +145,5 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>   	.ops		= &designware_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct dwmac_socfpga_plat),
> -	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags		= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };
> diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
> index 5c542d62bd8..52be3a5687f 100644
> --- a/drivers/net/gmac_rockchip.c
> +++ b/drivers/net/gmac_rockchip.c
> @@ -760,5 +760,5 @@ U_BOOT_DRIVER(eth_gmac_rockchip) = {
>   	.ops	= &gmac_rockchip_eth_ops,
>   	.priv_auto	= sizeof(struct dw_eth_dev),
>   	.plat_auto	= sizeof(struct gmac_rockchip_plat),
> -	.flags = DM_FLAG_ALLOC_PRIV_DMA,
> +	.flags = DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
