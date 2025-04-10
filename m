Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7003CC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4E283A02;
	Thu, 10 Apr 2025 09:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QSN7VNFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367AC83A02; Thu, 10 Apr 2025 09:46:23 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1057083995
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so999282f8f.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744271180; x=1744875980; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xRdV/3ejCaaWremGTBvSe/VbE4XGbDqCAqUMi28ovCI=;
 b=QSN7VNFcXx3MAQiGWz0O/cSCP1vv+KLHDSK8H9Dq9M3v3gFLiMGmtVk+9jNcsiflW4
 iT66658KrKttQDG87dmQVYjCCacppkynhYflnJof72Os0iZpjv31GFCD+0ezaDsKbCEk
 QwziUw6IIX4NKDZT13WmIUqdgaqUNXOjb3TOsFP06LRuwYkNlkMUa66kUmy9X9l3qI3c
 ZAmpfU/SUnHEJ/IcNDR+RJg60DYzfaCal3qfJv8IVji8HsO54WKqBxJWTMgcmSa6/kBo
 4ImpY/RlRFkEBO9Fe39IDCem9zJBiYSm+N8Wwz2MftJxAN5jVj2HbaIn9CYcj5Vfp8hA
 zpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271180; x=1744875980;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xRdV/3ejCaaWremGTBvSe/VbE4XGbDqCAqUMi28ovCI=;
 b=VaztciSYvNydCaQDf+O8e+5RZ+86zOUgwqq4fYWiuGwNTd1MQ5lOvPZwe4l5mO8e+t
 RrI8KZ3G3bQJoJXdQOg7YwS7ZuNkRImxpG6mSP8sxAYWysYkpdV0VwULzwQQiivCc7FB
 3Tr8dgoj6YCWUlcvSMTZ4f7uTf0jufYnf+b0vI72uA3BHWI8Klbj7jJ0pj1H+KGEuNfn
 RJCLUavcqoEVGcwxlQZeUt4BLKpiWK+lR9X6jyieX5vM9Yr3y8t0DaB4MN6vXbacYrF7
 nwinl9Zq2XRAMO+IsoWylB27+d0B2OC5ckoz9tNksXB1AIDF6DGYbn5UD4iqsrsJovk4
 wHhw==
X-Gm-Message-State: AOJu0YxAmnKjSw7PmYzbqYzWGq8fsQ9ZBBpocXiHwxnNeLtxNtNJEIoL
 Tg+Oo6F6eNvJzkFc3wUjlT8MlYpD8uRDYWTsWxdMgi3c3ei99mBylXlszQNekus=
X-Gm-Gg: ASbGncvkaAm1y9G9Ua6w1S7B2xKPKnqbdNKB4ZalfED8Y4QjSLYmiO7l929GnL9Auij
 M5x3yM/5TzBsplOn3tPJcm867wHdYlVVHhTbxKXHfaTI46JkSFxoedZgBtFKwvw8bffoM+e3ITB
 Cz/owgEygeoZUP14F7kh1OdkSB92qIs6sb7h9XbikRoB7cXuLSdUTTaTc59w5t5jMjWrNNjmgz2
 1U5VlaAkkJ/E39wL5BYYWOo7hs0dtoi+tpvXHef/xInUlnAiCA7GVDbSd2oSU6BH4fV8ZZ1KCuR
 AB4dbSvqmXCxdPUbw0ujSujnVfU74207c/HbVDlrwJA3glHcXeHrQ9+EYusUpRcG3ghdf9YuZyz
 iC9DFXHlj0G/qyVUM1g==
X-Google-Smtp-Source: AGHT+IGbjwK1Rzdhjsz4ciSmeLZPhi1fyx33/gjqqpjWaopbH12cexIdre6A965n1q6Z2pOeigoRHQ==
X-Received: by 2002:a5d:5986:0:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-39d8f46ad64mr1346085f8f.15.1744271180495; 
 Thu, 10 Apr 2025 00:46:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89389f72sm3860959f8f.42.2025.04.10.00.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:46:19 -0700 (PDT)
Message-ID: <10395b6f-533f-411e-9f13-09421dd3ee0a@linaro.org>
Date: Thu, 10 Apr 2025 09:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/6] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-6-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-6-76dfea80b07f@linaro.org>
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

On 09/04/2025 19:17, Caleb Connolly wrote:
> There are 134 pins not 133, oops! This fixes the sdcard on the RB1 as
> the pins now all get configured correctly.
> 
> Fixes: 0ecb8cfcb930 ("pinctrl: qcom: add qcm2290 pinctrl driver")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-qcm2290.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> index 0c2222ce663e6d584d229e7521f88fedf8aa19da..84f76b63b93ad78182524661dba561672feb4c85 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
> @@ -44,9 +44,9 @@ static int qcm2290_get_function_mux(__maybe_unused unsigned int pin, unsigned in
>   }
>   
>   struct msm_pinctrl_data qcm2290_data = {
>   	.pin_data = {
> -		.pin_count = 133,
> +		.pin_count = 134,
>   		.special_pins_start = 127,
>   	},
>   	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>   	.get_function_name = qcm2290_get_function_name,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
