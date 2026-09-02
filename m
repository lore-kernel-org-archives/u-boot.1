Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1DC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B2CC80F35;
	Wed,  2 Sep 2026 14:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJj3usBa9IGL; Wed,  2 Sep 2026 14:37:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359868;
	bh=ij0xYkvbozkHUlDgtsGfZtdZmvbhRCpXSEebPYG/Tl8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Gj5dGzn4fxUtwqheIp2DFo7nN0tlVr87f89Tdvdv8GCg8KXPyYQfcXB/5tJvhj6Pd
	 eus+K/OBy6NxXG2AdFknrnjE81QzQ+7ZwjuWkz8D9s4ddEP+cBevMk/Xk8X5tE8lYD
	 xzA+K99GowoXEIZAPLYHmeuoYQmuojI1L2OyuxClH7AcHEI0xD1kvjOEhaZf3iiz7b
	 GySjUw/UIQAUuky2iwcHzKE+FTOReNeffCI6zkS0wyBR3Xp4KgJK0DpyNxEBgiGm2e
	 ScfCu+/ioe2gqEPEWTQ3zpmfHys7P3FXZ5bYtKR9GloMyTmbaOZwM1tCsBDbVcpWug
	 i+3WIf42R3smg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8584D80EC5;
	Wed,  2 Sep 2026 14:37:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0180C363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6FD280EC2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NZ83NiY-mXr for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:37:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ls0497ZR
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1FCC80EC5
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:37:46 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1193188a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788359864; x=1788964664;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ij0xYkvbozkHUlDgtsGfZtdZmvbhRCpXSEebPYG/Tl8=;
 b=Ls0497ZR2sDjTzRqdhIo9SVV5JJb9HSXW2Ch46TflvOzqHY9dgPqPIN5Afzy9hr9P1
 45ZL1ECp0Cc2bCccVzrH3fDi93xQNTlVrDU8h77i5xfWwZVO4pI44EpaZi2XKEtxm+vf
 06EFAliXDrQyP37FQ1+h1Tj6WwOaPsATcoCtMIlK8ANoDNzDfIfw0UWsVwncP85rt5Ob
 z0a+0N2QnCRt0/YGQxPUnCDAGISJQW6KTj+4tL1xGeXU4UxllueJy/ucPmxpYt59p6gB
 bJMzbH+ySMobiJzDL0+TcFSNxUQRHRpk2ZEOjAZuX+lenO0C7QchNx1f6Sip9ELC+Fvd
 DhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359864; x=1788964664;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ij0xYkvbozkHUlDgtsGfZtdZmvbhRCpXSEebPYG/Tl8=;
 b=owy0FhibRWMmRvHAh9LaO98HkynMY/QGu/qBFifa9JLmO24TXgk8wJKUJ/yzQZ7TI1
 Bcm18MkKqU7AAEWVRZzCiAY8rdgCd7rSHBsDfeTYuT+F3L/J0olQTNA0IzYJp1wrB+j5
 W9pGBPPAGK+h8LREV7gdI4lD/s60xsZ8RbYgLJiHeW8pde/N7lNWR+wyUnnO/OsMwAuO
 5uaGZ9HT4zTAak2A5768ZiElGyO56aEuSxGeX+jG0rbRTI0I16/s+QJMDiRGSqX8Zl0C
 mrfbJVniadEJe+aCIboKXVfvot8PrnpXDDACL0mD0gwYYF9O3XpXfHL52SzMbkvl2Cf4
 Dyqw==
X-Gm-Message-State: AFuF++lRQiGpIQkuQsnmh9n2Gm+EZz8IVg5XOTnjzeLfZGC1Aq1uDkRh
 FU8JDHG21cNxM5dc56kq4HocQKfB6iggGYtqK6JL56eN+zWz9sn9KrJ3VskK8bewEu4=
X-Gm-Gg: AYBFou3HnTv517+56xZDjzcJ/zR9HhJeKT/KJMYkj/kGu+f7/IU4ExcFxixfxbviJSH
 IhkwMTdGATx4SeOyIZ+RGKtmmQVQhB4zW2UZJ/pfhfyZ3xAEtJ8dbOBgtPx4ws+BtCEVVQyeQGO
 uvTtv4xB279poiFwRaqQbjO9/27Zej1pSotglagqRGmw9osQavsL5hgjQkXEz9oX3NEPP+HGB0R
 tD07sww60kYHBFdedZfxUHRF2V3DLXdPH/csiKEATT4vd5RBh2WR6qCvTdI3PBeuHTyAuW/SqsZ
 DpL2gNBdsbkvqHmxHeioOUr3ih2KjY4VgFRcj5c7+FqqcWDXb19K8Sy1PwJoI0zzrraGez5Zki0
 D2NHYKTuD6dQxSJL02egI8Y9Y6pMSzGtd90ABASGJ2ms/LXn5BdHO7tnIW9Rm4fZDA1F8nVtWMd
 jLSKY4KF9Kw66B3nMy5v9AYvLqpqD8rwrWzBCXKjGh1VenlkgTS+yAPPP79TO59Ph8PZ7UfQ4Yv
 opYN0Dxyr0ELrIB9j8KbnuyHh82Grflo3RB8Sc=
X-Received: by 2002:a05:6402:a0d2:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a6825668e2mr3478298a12.1.1788359864424; 
 Wed, 02 Sep 2026 07:37:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e9e:e6f8:a41a:72c?
 ([2a01:e0a:106d:1080:e9e:e6f8:a41a:72c])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f942fe4sm1233794a12.25.2026.09.02.07.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 07:37:38 -0700 (PDT)
Message-ID: <07617824-547e-4723-a228-91b2b8b55766@linaro.org>
Date: Wed, 2 Sep 2026 16:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi_gpio: fix bias-pull-down
To: Casey Connolly <casey.connolly@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Petr Hodina <petr.hodina@protonmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20260902142736.2419504-3-casey.connolly@linaro.org>
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
In-Reply-To: <20260902142736.2419504-3-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/2/26 16:27, Casey Connolly wrote:
> A small logic error resulted in bias-pull-down being interpreted as
> bias-pull-up, fix this.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index bd1d7a16e852..b218a3d3d585 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -795,9 +795,9 @@ static const struct pinconf_param qcom_spmi_pmic_pinctrl_conf_params[] = {
>   	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
>   	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
>   	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>   	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, PMIC_GPIO_PULL_UP_30 },
> -	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 0 },
> +	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
>   	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
>   	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
>   	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
>   	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
> @@ -879,12 +879,9 @@ static int qcom_spmi_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int
>   	case PIN_CONFIG_BIAS_PULL_UP:
>   		pad->pullup = PMIC_GPIO_PULL_UP_30;
>   		break;
>   	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		if (arg)
> -			pad->pullup = PMIC_GPIO_PULL_DOWN;
> -		else
> -			pad->pullup = PMIC_GPIO_PULL_DISABLE;
> +		pad->pullup = PMIC_GPIO_PULL_DOWN;
>   		break;
>   	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>   		pad->is_enabled = false;
>   		break;

Good catch


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
