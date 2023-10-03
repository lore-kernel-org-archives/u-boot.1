Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6178E75432
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E043872AD;
	Tue,  3 Oct 2023 09:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sJAGyPTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CF487460; Tue,  3 Oct 2023 09:27:49 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1747887222
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so615367f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696318066; x=1696922866; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/JoGW1PL7iE2wfeVTeRF473P6kJ0k+9TWP+BP9Jo/Wk=;
 b=sJAGyPTu5ILVVBohOoK7CKODx80zYQKiwbDBALF3PGSNrBnFeKBskB4lZ24KrAo6df
 TUV4E1nes6LlBk+2dduUfWtWKKp/89tmoHR4CHli0dQK7ROKJrKd12MfA6TNZikoBcia
 PzzsrSxpOqJAUVK4sKm8BfkR+ujh9ujpjbvfSaCXwximDAHCGXZuYr8GLdub53/FWIyw
 V4SUFefW67U5x6uttMZkfsXuZtGy7VHfwwIe0SEm7ZZ26hL9+uBWsNrxRqo1uDpKtRMQ
 SMA5yT3F0obhmQM36iqvxjjzaJ88ddjZ4O3DBmB+4QlsjUIJP8k9mxP3Tj5oNbEisw/D
 wnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696318066; x=1696922866;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/JoGW1PL7iE2wfeVTeRF473P6kJ0k+9TWP+BP9Jo/Wk=;
 b=SrdSOjR4mE+sVMMZimTOIlmlDGUSfA7xt0zBo2DQAT7dqzNbmgxKEUFTTN3iHM1dFB
 zmKxTjJtakeE6HNN1lulaH5QW5xWfSszj+uqYfJCimAk+PZA/Pik3A1BbLitDtKw15R8
 vdxG68Ii+Ut4LAJ+2sHot/IzqC/cdOstdT5/jGqjya+rcqN8pYm3vnQZ50L/nPgqfF3D
 wxIVHyMn475tikldvHs0vuAT0Qy1qS2dvSHihX3wQ0ZGeiaLpM1ZI6yT/YqS6vt7zBOB
 n9OPFRHZxuFDsVvacXyHM8iuGA6oMLujph3zegjL9WAeKn6WP31cc8MaF2GKEShfNLwN
 cgZg==
X-Gm-Message-State: AOJu0Yy6JGRQqn+EZlVB1V/erCjd6c8WmYtn6kik+CdRow/GGO3A3FqP
 bdfiAEWAUlCradtgAnHYsOK1Sw==
X-Google-Smtp-Source: AGHT+IGSI6Y/zTS1DqF6QQX8cSjcsW5kuVWI+7rc4aR4jqqFlXI8LMsKWWqgBUXO77nBcYEzU5UOsQ==
X-Received: by 2002:a5d:4751:0:b0:321:6fb0:9a8b with SMTP id
 o17-20020a5d4751000000b003216fb09a8bmr10507360wrs.70.1696318066643; 
 Tue, 03 Oct 2023 00:27:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a5d4710000000b003179d5aee67sm857666wrq.94.2023.10.03.00.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:27:46 -0700 (PDT)
Message-ID: <0d3d89f1-ec88-432f-9b17-2fb718a6bd3c@linaro.org>
Date: Tue, 3 Oct 2023 09:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 6/8] a1: clk: Add missing CLKID_USB_PHY_IN gate
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Igor Prusov <ivprusov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-7-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-7-avromanov@salutedevices.com>
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
> From: Igor Prusov <ivprusov@salutedevices.com>
> 
> We use this clock in dwc3 driver.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/clk/meson/a1.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 3aec42f33b..1540e1875b 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -238,6 +238,9 @@ static const struct meson_clk_info *meson_clocks[] = {
>   	[CLKID_FIXPLL_IN] = CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
>   		EXTERNAL_XTAL
>   	),
> +	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
> +		EXTERNAL_XTAL
> +	),
>   	[CLKID_SARADC] = CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
>   		-ENOENT
>   	),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
