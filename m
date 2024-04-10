Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39B0CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620C888120;
	Wed, 10 Apr 2024 10:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KkdRtONe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3638819D; Wed, 10 Apr 2024 10:42:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA3D88120
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-416a208d496so11754165e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712738563; x=1713343363; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DoF78Aym4hMMywSQnqEL2Cp82W0ffQXwvzxrbKzQL1Y=;
 b=KkdRtONe5zdUETeOHOb87/HJyW6J+zUZ/FbdxhN/wF19GYq8QhzhsPgY6RLVEd+uSN
 dyE+0vg9c/n2obNpWKKMpqxX5Kfq868KqQVUWUW4+VBs+rDXDSBFywWGMkgAruNOMc6j
 Ln2cuI+yV3vEuUJ/VbREdMqRsPFek+PX8OcP0m4vo3ve9kvhHQBRJC/X3HXrh4LR5FQd
 6AHKOwOgj2+jjK1k8m9jhfEG4t5uBqUwG4ltkToJZtDMxsfihfZDufZpA4zJZGhcvoS7
 duMFSGbf3cH7TGGeqMsMwSZ/poeHyusLmWBSL8wUb21JM6gk/3sRNkxQrsvyu1TWTgjc
 mXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712738563; x=1713343363;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DoF78Aym4hMMywSQnqEL2Cp82W0ffQXwvzxrbKzQL1Y=;
 b=Ys9sgV/bQiy4SiulCZhGx/Q4IKceDb6bElCpwwJGBNG6l4UBK/kjDPcobszKZcPbba
 O/k5cIQ2W90HOnLM3aqyUu37jcKN/MKuzx7UjPCe+zb/zh6p2au1hU70tNCC7fiGWPyR
 Du/DCm6J9ArYA1D2H5VDRCjSMQz7ob7r0maCoREFeHBB1NFkaaMorpU6uhpNi8nXxyfs
 TZjqVw99o/5jaAAqsCfxJuPY4axfRNa2Dd9JT+acMDuANTl8Leyxm2ZbK5UqSOfehZVZ
 F9XSWLp8w8BaWg5b6AAUCeNjBklavPXDVTgzkvOnY+bu1SUuCTa9t4ivZfW+75SbYXBB
 E0qg==
X-Gm-Message-State: AOJu0YyXKLXbkiyNyzdVZMPlcNgECsUStBPHAv35Mzt0E81Ho8As2eew
 zuOEPD3rAV7b06pCEdSckM8sd0mcR3VsVrWMZPLnTTcVWZ/cb6CBmF3cJM+5NsI=
X-Google-Smtp-Source: AGHT+IGkhC7Ebng+WzvwhRLTsfJeFEMXYou8rNu5V0jvh3Mr7rmHyjaHTiQNlmB0Tk8EUnF3QIJ2cA==
X-Received: by 2002:a7b:cc81:0:b0:416:af4d:e3dc with SMTP id
 p1-20020a7bcc81000000b00416af4de3dcmr1667390wma.12.1712738562447; 
 Wed, 10 Apr 2024 01:42:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b?
 ([2a01:e0a:982:cbb0:7b0c:6cd:4afa:674b])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a05600c46c600b00417bab31bd2sm620116wmo.26.2024.04.10.01.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:42:42 -0700 (PDT)
Message-ID: <4a72c6b4-82e1-4e4d-ae5c-ef491275d5c6@linaro.org>
Date: Wed, 10 Apr 2024 10:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6/7] pinctrl: qcom: sdm845: add special pin names
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-6-5039164ecbf7@linaro.org>
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
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-6-5039164ecbf7@linaro.org>
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

On 09/04/2024 20:03, Caleb Connolly wrote:
> Adjust sdm845_get_pin_name() to return the correct names for the special
> pins. This fixes a non-fatal -ENOSYS error when probing MMC.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-sdm845.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 459a4329ec80..c1e5cc01fded 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -65,9 +65,20 @@ static const char *sdm845_get_function_name(struct udevice *dev,
>   
>   static const char *sdm845_get_pin_name(struct udevice *dev,
>   					unsigned int selector)
>   {
> -	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +	static const char *special_pins_names[] = {
> +		"ufs_reset",
> +		"sdc2_clk",
> +		"sdc2_cmd",
> +		"sdc2_data",
> +	};
> +
> +	if (selector >= 150 && selector <= 154)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 150]);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
>   	return pin_name;
>   }
>   
>   static unsigned int sdm845_get_function_mux(__maybe_unused unsigned int pin,
> 

At some point we should add the pinconf settings for SDC and UFS, but for now it's ok!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
