Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F6EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28318786E;
	Thu, 21 Dec 2023 17:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uUSFzlZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9F38786E; Thu, 21 Dec 2023 17:20:45 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6162887860
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so5867405e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175643; x=1703780443; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4CvT6EDloo5ufuofza8oY4XPP3dDSdlyitvpcLQNE6Y=;
 b=uUSFzlZwlTiZtvh1V134T41JUSxwpYnbAcEkmfRg79rxMj5WkGo3k538rM8iZM/gNJ
 vgF+Na2vIVThgnLu4RqwT9bYc2yQq0ZtiKW8VJ7Ncip6MWG2/dugRzI+WRKOoZ2vYQ6P
 kD3kHn61/v/Bi3DFplFk2RJMV/CLfXVGaVj6INSIcuqMiNwTrRPswSa9lA2x9kCo5b3k
 OzM8bOJJIKXXoW9Z8hQavxj/RzHqM1dqkXeqKdKUUqhzrSKbiW5JReyGchYQ2Q/DVbrW
 Rve4dobRcxOGZfmHGpPe1wSSafVWDQG7Z3w1hd+StwcwbszDXJPaYS+cm8v1LusKGz9D
 LVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175643; x=1703780443;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4CvT6EDloo5ufuofza8oY4XPP3dDSdlyitvpcLQNE6Y=;
 b=YKPnhAX/ujQiuQKQ+sALtQf8e4FPnXtwgPsB/GNYHUrmbNfOJm2AlTQQVV8iaRFVjE
 0eQyeVj7lANjHSaAlQCFWv3TxmD+yvHQHmZOZPZ5aJ6PmfMNJVaNjSrTRYAFhnlw5gza
 77ko0A9hsYUJGtz3mkYQnpGPRjyeqCgWGgrdeqEQnNzavYGyb8YHK0MNnSCO1ShGD0vS
 HeYQGoHmEJ71MFUmVShI4EeXy0VY/KGNTYheMqJIfChr1dWngG6TO0FGvXiMvnn6Vqda
 AOgCO18H+3QN8lFm2marVeqB+rdOgIPQDprz9NNGI5a9RDsSZuiLcCZicQ9zHdbXVwAN
 h9uA==
X-Gm-Message-State: AOJu0Yw6LgFt7Ct/Qk27HgH3wL3OJgHH5+bHS+kzd0F02Q0SQHheivco
 uVrLkZ+AAUNecmqzDYKojJRqGK+c6GPaYw==
X-Google-Smtp-Source: AGHT+IGZ1eLj2GL+P9yuTJoevLZ9MFyLxd69x8eAPBUPuphUq9winTAyK4BVISsQFsCcU48jqZ/EFw==
X-Received: by 2002:a05:600c:35c1:b0:40b:3e26:8733 with SMTP id
 r1-20020a05600c35c100b0040b3e268733mr663029wmq.0.1703175642801; 
 Thu, 21 Dec 2023 08:20:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b003364bb3e989sm2316961wrc.110.2023.12.21.08.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:20:42 -0800 (PST)
Message-ID: <7cc4f21d-4e4e-48d9-aed1-ebcfd36e3788@linaro.org>
Date: Thu, 21 Dec 2023 17:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 11/32] board: dragonboard410c: add chainloaded config
 fragment
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-11-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-11-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Add a config fragment for building U-Boot such that it can be
> chainloaded by aboot/LK rather than being flashed directly to the aboot
> partition.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> new file mode 100644
> index 000000000000..3fd064924a1f
> --- /dev/null
> +++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
> @@ -0,0 +1,7 @@
> +# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
> +CONFIG_TEXT_BASE=0x0
> +# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
> +# CONFIG_REMAKE_ELF is not set
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_INIT_SP_RELATIVE=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=524288
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
