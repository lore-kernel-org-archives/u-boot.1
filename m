Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC754CA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638AC83734;
	Thu,  4 Sep 2025 10:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p44umzYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6191283775; Thu,  4 Sep 2025 10:24:34 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A449283622
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 10:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b8e28b3c5so10243455e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756974271; x=1757579071; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=855dvf+m6LlLZUCzphgMGLGpOjBOmYtl1dWdsnVL824=;
 b=p44umzYbF/7Mdf7sHmgqP3pOPsDLVHyHTBv+MjQh+AL4HF0jrSTmJnVv9z2r01bean
 dkp0bLbTPZvzXFRNlwdIBw2Y+nK8VZrYCJh3pVRhJrkfZpArnbj/MWkmtQenJqsBnTz+
 KIDlHDT8T6952vSqrsrImohL2Bw1PhojWIlZHlHt2uAYcKcQgvboOTg4q+KjjmcGUGMn
 bqC9AloVv9tSbPpRqflF1MuiZribcQOMUq36pAAsNVcozuHTMRBgDa6pcsnPKirutUdg
 wceG+ejJ5yjZrqpGOxV9j2zo8/4nrahFVLUHZNhSjIbXeQGQEo45VTU26LWxZWTYQdc0
 fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756974271; x=1757579071;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=855dvf+m6LlLZUCzphgMGLGpOjBOmYtl1dWdsnVL824=;
 b=OrvKCBORD7RnxYT4Xnd90v1bN5cCer4dYfwoTGemMeDFbSqglS3FaeDqHR5OAEsKqf
 6S7rULYgXctHUywRkx/XupaouTwO9+BDzXCYW6RR5gUc12AfqXgk3TQqSLeQHZOxbwwr
 2V5fwBDppOR2GUhv4T/w1lDN+KtcyE5NuGFvE4P155yNV4AcdvSneW1WsLHC4+uAyI4h
 lllvmXSvXI9bMcezotQqwUTzr4ZXJWQjp35OxGH2LmUCeBd3MUf8B9AlWWUV6t5AgTjt
 F5Gd9S2nUDuXSsOcvfCaEEyaFFL7wKNe/GScIZaLsAGCnnSkVrADsD0hgB20lMSjE+qr
 +eJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmzHDsXRRhzSFHgl80DedMkYqj/851WohKR8L4zkH36du4fwC8S4sKCNEgFTqyzqzxEwA1BkU=@lists.denx.de
X-Gm-Message-State: AOJu0YwEuR3IvhV3C+LdoOdQ5OL4lkSRXQuh+f7UCxzdWNjV9oUiTqhQ
 jo/zIR1CTP6QXeWkv9K692Yq+U/IMkjS4OZUnLipHxGz8yHPgcvGty7Oe5JA9j6WrMN4VMubN+7
 l3Bh/Rm1PYQ==
X-Gm-Gg: ASbGncuxFpSzIyt8YbA8ECf4Y3CNhhACr6Gvb0FgfvxSKRyjuMIysq+jCuJBolNg3J4
 Nwxj+qZGu9+QhQWYNY9GRnVgxGshJwvnIj73YhGVFN54xaianfvn0/YLtJ8HyPKKHvXC9asA4ga
 R4G6f7Ikfp7nVex00CwHXdz8om1+IS3sY3+8SBlyfc89wRa39bM5TvUWfIczv2roeF/ST16vlc0
 z41j32AHI2GqE/Fnp715xMYYV1dRZGfG1eFYQ0G4QrY/EfiTkhTf512zFFLeH/HUsSBfyGrTAhf
 VEUiOfxCEGmqURYC6qO0/Zwith5TjMzc1pBgGCFk9mbaAXYBOr5tMnnps1nLN1pLi3yMegcAerU
 HFnZg+DpHbOaHnmCCSD0aZoBVoWtPJkhl/6JkS+zpsRvGYfdXRXhXb2ZZleSMhg/NC77XisIyis
 MKYjYoZifi7Q==
X-Google-Smtp-Source: AGHT+IFgEwQyCgQzqt+K4cIRfzBuCKv21soEJS4bZD6Ek1wFz7ba/6VUdsDE1XWZ3Jk1x31thTaw9A==
X-Received: by 2002:a05:600c:8b64:b0:45d:d295:fddc with SMTP id
 5b1f17b1804b1-45dd2960194mr7095185e9.4.1756974270824; 
 Thu, 04 Sep 2025 01:24:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8c14:335d:24b1:fa98?
 ([2a01:e0a:3d9:2080:8c14:335d:24b1:fa98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e177488999sm1189281f8f.36.2025.09.04.01.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 01:24:30 -0700 (PDT)
Message-ID: <16deff09-13d8-4ad1-8a1c-c1d9988a9c51@linaro.org>
Date: Thu, 4 Sep 2025 10:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pwm: meson: Stop premature exit from for loop
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
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
In-Reply-To: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 08/08/2025 11:34, Andrew Goodbody wrote:
> In meson_pwm_probe the for loop attempts to get the name of a clock but
> the following if..else statements only perform useful work if -ENODATA
> is returned from clk_get_by_name. If clk_get_by_name simply succeeds
> then this results in a premature exit from the for loop and the
> following code can never be reached. Make the else clause only apply for
> an error return from clk_get_by_name.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/pwm/pwm-meson.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index c2597d8b669..caa7af085fa 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -359,8 +359,9 @@ static int meson_pwm_probe(struct udevice *dev)
>   
>   			/* We have our source clock, do not alter HW clock mux */
>   			continue;
> -		} else
> +		} else if (err) {
>   			return err;
> +		}
>   
>   		/* Get id in list */
>   		for (p = 0 ; p < data->num_parents ; ++p) {
> 
> ---
> base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
> change-id: 20250808-pwm_meson-65549e7d24ab
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
