Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E366EE7AD42
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C488725E;
	Tue,  3 Oct 2023 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o0cDcn+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351CE87259; Tue,  3 Oct 2023 15:21:02 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC62287284
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso970911f8f.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696339258; x=1696944058; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pI59aYosQYHU2guYGI0SzdHSoKj72+JZp8wirAuCrGE=;
 b=o0cDcn+1SgvO6uGQlzgGJ/bybiegi5dVVEdJhlClLsFUgOunuPw9Rizk/RdItsaHsO
 6jsFwKorkDQpz7FhJ7Yiab3DaLKPFiyaChnd5GuZSxfI5ZTU339wcaV8niD1hLpiM+Ke
 3kGn8vf2M2snLeW+6GIXUs43ghcIopvInSbX5aV3V6Ott6MRvecuy+zVtxnrjLFnA9D9
 xg4UqaQQLo/czknyrV7kH/2GWflGa1mYWrqyToxEd6N+cZWDVQLSlk7uE1RUYaha5wby
 EPC3ZUQzYsrGoX66InMBwtewTNvxFvu/FmZuYFa1UnbTwIkWrYNo64SHrfFv4RFEmkfa
 91/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339258; x=1696944058;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pI59aYosQYHU2guYGI0SzdHSoKj72+JZp8wirAuCrGE=;
 b=fQXLzYPGgyGH1WQfmuuavSGKwNW5VRnqc8dIDAmFurV3cel7XS8L6hu2f4oKAA51Hq
 mq1H662432wKXgljvWjyuUYj4Zv7tOf6NH+pY6aBYm124B4B9y9zSqFfcqN011d41dBu
 Hd0X79Ai+cFiGKzzQSgtyXWclExsV76+CphyJledABFID6nld0P9N0T4nHCCIIR9ESQK
 blgt7QRXlP1SnHcveZTCMSzY2jAW2y8GhhkKjC0G2BNK+a2x4gca6eR3vlzlkm2TDy+o
 yFJldZpoqxvqS56UH1tZ6FCkAjt6ExM/Qw24wD//QuFpJviaf+RI9c2HrzMbAMhCSBp4
 urzQ==
X-Gm-Message-State: AOJu0Yxi2QfLXqhWf2990f6vSdn2GetfMqv+sxkJ+8N4E/SiC5PCzx4U
 jOnQlRcNTc14llpMkIRdxb6AVA==
X-Google-Smtp-Source: AGHT+IHJCuJxmeALtTlU8BrV59Ugbt8hd8eVxx1N0/LwifXq4nn3+D4zwGIyxmXXEv482voBB8Dd7Q==
X-Received: by 2002:adf:e683:0:b0:321:4c7e:45e3 with SMTP id
 r3-20020adfe683000000b003214c7e45e3mr12965303wrm.11.1696339258356; 
 Tue, 03 Oct 2023 06:20:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 f8-20020adfdb48000000b0031ff89af0e4sm1568213wrj.99.2023.10.03.06.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:20:57 -0700 (PDT)
Message-ID: <a0fef13f-0f39-4595-abb2-2859f0bb18a4@linaro.org>
Date: Tue, 3 Oct 2023 15:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Igor Prusov <ivprusov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-7-avromanov@salutedevices.com>
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
In-Reply-To: <20231003112838.41503-7-avromanov@salutedevices.com>
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

On 03/10/2023 13:28, Alexey Romanov wrote:
> From: Igor Prusov <ivprusov@salutedevices.com>
> 
> We use this clocks in dwc3 driver.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/clk/meson/a1.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 3aec42f33b..1075ba7333 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -238,6 +238,12 @@ static const struct meson_clk_info *meson_clocks[] = {
>   	[CLKID_FIXPLL_IN] = CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
>   		EXTERNAL_XTAL
>   	),
> +	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
> +		EXTERNAL_XTAL
> +	),
> +	[CLKID_USB_PHY] = CLK_GATE("usb_phy", A1_SYS_CLK_EN0, 27,
> +		CLKID_SYS
> +	),
>   	[CLKID_SARADC] = CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
>   		-ENOENT
>   	),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
