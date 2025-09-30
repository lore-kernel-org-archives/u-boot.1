Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29617CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FF483621;
	Tue, 30 Sep 2025 20:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gOWDA/d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620A5835FE; Tue, 30 Sep 2025 20:44:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B7A800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e52279279so20225915e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257857; x=1759862657; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WKFsKUja8FRN7OXONwj09grGt+NBPMsVv5G7NYTokZc=;
 b=gOWDA/d5h7dS6ACbMlMpFNUMRky9s5nJP6zmGcROCHbObowtam4tw00DMwWtj+SS7z
 0IAgxmlkOsKlUgUjaJUxMttDjoWLsZwl2dSbuEmGONxQpFn3o3eN59/KyMcFGVsP68cc
 Sb+qBfIUQQyPMMN52YTVyCKLL5E1pLcfU5B0ykXsXfoJlG4ho6Sa5SEr4sduLicbbIs6
 U3On/YMuPUTCjZ0ao3g88IZW08ju7zPcoCBBZIDeTJ+WAXBfIQVQRJQKn3LL/B11nKOE
 S4zdaKQHy52bO762oj81JEKAxwUQ07Dc1Q69kLjt1o0OYgXJbSh+KhqovgW07tkQrs0R
 c8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257857; x=1759862657;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WKFsKUja8FRN7OXONwj09grGt+NBPMsVv5G7NYTokZc=;
 b=gVuOzWI7Ksf6kusK+DBZn9bsvqEaADgTerR5mnd96Qn2AYjeznYngxvo6/FJFim41N
 9osjSV5tPMKxbs2kj89tPSdAIOpfW+UKb0y/fyazQCCNCnpPwBqNTUBhrWYi8JCyMuew
 1GfEu00Uo9zGW8Kk6s1nqDLIL4Ouqj5OWuKBk8oZExEDP/m0X+UHG87qOeMDr4/f3n6i
 OIZKJD7UPE6Y8+tDcVJUza4Tlh1W4hoK4d7EmxFYqKb4nd39NAU4lswe/yVt6oEc2MQQ
 d68ncjkHBYyqQQxGWNZJAUZIwMCiwA6pX4rSpbI0r1NZe6QDGpcCGQjD3SJt+hK40DYs
 Rh5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo1mxuE7E4ilKZqGl39Qfe4UKlxPkwg3bpmi6ERlq0pLNlassDLgTI/vuiA7J+TOAs3dH+/LE=@lists.denx.de
X-Gm-Message-State: AOJu0YyvN6GWiyi8GQTWis6+vs6PueFBikoyzWtOs1xL5pZXmzCZ0Ueh
 nO0DY69YwSEvR9edWMjxObDIzN/yalHPQOSAsWx/9XY7S+5T+GlAR3fMySHzV8yg+PY=
X-Gm-Gg: ASbGncvwbdpRBtH0u1sPJBLn8+7DRmxszfGuTJMQFRMKIFB2AC3nnAkjNqdJsunGfGW
 0JEXcaYKPIM8n8GeZgtDR/8iSgpndKfOB5brld0johvZJPyb0o9Vmh65A/eeeoci60EutLHStEV
 dkiOpu6hVErcZbHTzInnbYdhWJIeI2QfWHQYyrhBkmCpZBndF55qjCJ2+QtFGjcfP5ywyEnXdXg
 4TwaOuvGh2ti4OC8tdc+2wn5MLjLcYROsAcaKzy2/ZNTx56x284rOt1JWxOtZ5vd3N3gVXa06BK
 M7dLxA+Wv6N8C+aAcJNrleT9HzB+1p5wVuaZmK/7h463pC/H3eatI7HABjtROtrbhUhWL1Lp/1K
 tMZoKh0ea09XiK0Xzzv/aGGmlKsyHemnNmO5vX9QTQFRqv4UJHEvHaS+x8Xi+h9yiVMLFVLyekp
 jsS2Km8KrJhiCkUb2Tyd39QmY=
X-Google-Smtp-Source: AGHT+IE17ZNPUk3RwrXvQTOSJYXJg6UX7bFy7WxSFcA8+YiU69vBa9hjoTE7vui06jANc1gPYPLMdg==
X-Received: by 2002:a05:6000:200d:b0:3fa:2316:c20 with SMTP id
 ffacd0b85a97d-425577ee91fmr603479f8f.5.1759257856770; 
 Tue, 30 Sep 2025 11:44:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619ae806sm4885325e9.17.2025.09.30.11.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:44:16 -0700 (PDT)
Message-ID: <55d969f8-bdd4-48a6-92fb-15e08b34354e@linaro.org>
Date: Tue, 30 Sep 2025 20:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/5] qcom_defconfig: enable pinctrl for sdm670
To: David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
 <20250914-sdm670-v1-4-a344024062ab@mainlining.org>
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
In-Reply-To: <20250914-sdm670-v1-4-a344024062ab@mainlining.org>
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

On 9/14/25 11:42, David Wronek wrote:
> Enable the SDM670 pinctrl driver.
> 
> Signed-off-by: David Wronek <david.wronek@mainlining.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 86d7de89e7746e33f4385ca78c839b43319cd861..06e48e525e670f9304177879744f0a466ed79c9c 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -110,6 +110,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SA8775P=y
>   CONFIG_PINCTRL_QCOM_SC7280=y
> +CONFIG_PINCTRL_QCOM_SDM670=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_PINCTRL_QCOM_SM6115=y
>   CONFIG_PINCTRL_QCOM_SM8150=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
