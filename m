Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432BCEFC5D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266CE8918F;
	Wed,  9 Oct 2024 11:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A0WdZ7MQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B2A88FD2; Wed,  9 Oct 2024 11:50:57 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322F38918F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so15316205e9.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728467455; x=1729072255; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+jVoZQht6oJnt1WnvlV3K0kO2H5cD3190dSP0gdJxes=;
 b=A0WdZ7MQOVWob1eCbSN7t2jsyQ4+LG3Jfiw+cwjLPpo9gm2skc60Z28S5srnjKLv1G
 yCSxqx7gguxtM6A3SQWEimKZe1xVtlNndw8xHpAmXKXaFzGxFAUuvCZsMzHpj95aOzAz
 gZg/ZQ5SDPQ8QhLiN/QIcKNe9Xo/6ZsdYNXFvBqZOCrRZBvEmOGe2oCxQpKBnvNvTDo5
 GvhQiLVBuaCD6y9TzSRIkxSjwcldxhHEMOJtjBbmB66sxcXaY2M8wVF3COwlhn6EJ4GT
 ggu9uqszEZh2OEROcz13ZWPITcYyi2GWrwxs1doykg5hdlAwJp1K0OrdPLINHhah2Thj
 +/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728467455; x=1729072255;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+jVoZQht6oJnt1WnvlV3K0kO2H5cD3190dSP0gdJxes=;
 b=Lr6zKAP+Q9oti9vrLesuE7qZpPAV9h8hFMOURvbaKoBhj6ueQiPqW94j6qZxRYyhyt
 Le0HV1r+jVWzsv9S1iESi04dh8b0PH3GlGIGU1vnWnQl/xT5JFYKwM1ij/tOTeGPMk7T
 mEZDP5HnKTJIfVB4RmdrvezUR2gorknBGK2No227+gVedzXnkgjhhucepqfk85jMa6qY
 BoJcOAw9vcXPho5KqbdcoAtMiBgjcFGpPf3MUB2QMtDgDs0mdp65oHWT+X5OiMxjh1p9
 pNuHJuiXs0U/BpZMVcKC3f1kU0cYS9wG96+xrcZ3isWipizu89g80hp6ThypxEAPB2xK
 qasg==
X-Gm-Message-State: AOJu0Yxhdp4SpNKLTwzgoI4xELRDWUP0Y0tHwu3+HfPmE0C9hI36o6sa
 TIFMsQekatgl7htWpLWwEsMaK4DTreXES1yUgzvKTuB6SMSQVDpZUu6/aUkT8/M=
X-Google-Smtp-Source: AGHT+IFqPtWLFcwaE5c85dAnsKjtjpUm1HvpS2ju7A1qlhMpkLGPypeR/ePyoi7M1GY+ubuKvtSmqQ==
X-Received: by 2002:a5d:5d82:0:b0:37d:3f5c:5a83 with SMTP id
 ffacd0b85a97d-37d3f5c5b7cmr812983f8f.19.1728467454534; 
 Wed, 09 Oct 2024 02:50:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:767b:a30:4bcb:fcaf?
 ([2a01:e0a:982:cbb0:767b:a30:4bcb:fcaf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f34asm10007725f8f.3.2024.10.09.02.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 02:50:53 -0700 (PDT)
Message-ID: <19b70f67-7760-454f-a3f0-870950e3b845@linaro.org>
Date: Wed, 9 Oct 2024 11:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: stub: add sm8150 compatible id
To: Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de>
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
In-Reply-To: <20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de>
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

On 09/10/2024 11:49, Julius Lehmann wrote:
> Add support for sm8150 clock controller to clk stub driver.
> 
> ---
> Simple patch to extend the clk stub driver to support binding to sm8150 clock controllers.
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index ea817031fa6c0cc1ea21000273b5651be5d05e65..76df9e3aba0e664fdaab8431f7909dda52ceb795 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sm8150-rpmh-clk" }
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
>   	{ .compatible = "qcom,sm8650-rpmh-clk" },
> 
> ---
> base-commit: d0f74bd417daf6492975ce346843ba0767caf51c
> change-id: 20241009-clk-stub-sm8150-b7a29e0f43ba
> prerequisite-message-id: 20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org
> prerequisite-patch-id: 01b791d83c26250b3ff485045b88d5889f911bb8
> prerequisite-patch-id: 66febbc73195c71535e2423d14f1ff6994ac36cd
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
