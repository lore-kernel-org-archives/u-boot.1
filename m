Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4445ED29DF5
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DC983678;
	Tue, 13 Jan 2026 10:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mOyq/3Sf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A43836D3; Tue, 13 Jan 2026 10:36:04 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50E483678
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so6195762f8f.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768296961; x=1768901761; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1muLswv1Q6DOrUucLtQIlIAFQgYA5x5EXBkg9GN2Fg0=;
 b=mOyq/3Sf32yH4g/0qoOey85qws5gBnbqDuyv5yzfKvZuIpLJ9HnrrCePhXHozXpfyA
 exc5RcV4ks6zT5PlWlTxCUSsR9Zf1kWo2zA40u3KeBVISrYI5GvkhaJckHDFdSSZIyTk
 fkKWUeweQNa5h+MiDUZ3ievrvTf2MZEO/MdQGChDSUYbH6td4UaoOaVWkuMdsogAmhwg
 Sx73K68oQEPgOHNys5BfzARIkDbIn2uOkOcngU0ezj5HeREDSZhAyeELUM2Z0+X9ikAp
 e1gBAbfV/swFapfvTh3ho+SdlLHZuV6Osy3Y4jGcNkW/Vc/zpb+w/G1WvhO0/JZwub0g
 Qcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296961; x=1768901761;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1muLswv1Q6DOrUucLtQIlIAFQgYA5x5EXBkg9GN2Fg0=;
 b=cOBiWKS6I/EIzO6wyhymN9wej74pASTtj6aCkLKtLMy7M8ZLPI/3NMvZnvZYYEC8TY
 n4/Dt4HG7L17WQAz1OJZIdO6UqRqvaIS+bZhov31GsYRPFiAj3CmRfa6Gq9xccGI33PA
 4Brvv755Lgd5edo0LoQHBa3JK7e7v56TsZ3IwUIewXFeO5yK+1G82P5R2M5VPlZCnQTm
 wvmTvvDpM0LlL+jSs8e36pO7vSgK2S3ZdYuxXNEaZHKYuibGY2jGtNGePvFS7Xy+7ntP
 hlWf9bVQTuJDCcyIVQehOAVD3uU79c+Kji2JMB0eqjT63i9d8CktY8eCYsFPv5ZfDijW
 12Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEfbguy6BpLaLPhVSwUB9BCMhrWEPGwetJgD3LWWD0iA5NXtWW+arzLtpT4eaKgQpG1+Wzpxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxhBZoKjVsAypPNNw8o9U0bkC0Ysr2kDeZk+Js9mTNCYmnfxhm9
 RoNrvIZGFe2jKR5RhkQQb1+TwCjns6NdPXb8Oq5JHpfIp4Vcxt9RmZBbvuQkkxXo9no=
X-Gm-Gg: AY/fxX6gDoIpuidkQoZ8auQmCU0V4I8My49kaOx3hFbzk+odrZ3jAcSsY1P/xgHlPyi
 v0Ih4CO00fwzYtkWT27APuTUIpXV1ydkt0PiH+UIVuputfg5rE5KedO55xJl6YcOzOxUT7UsmFb
 FxMcukWr+APBVD2ihcA69nj6DTT/FmGadx1XoPWlYmwUTGT8j6lp3iCFWfhZtE3foNNWaWjwg6Z
 sR6g2NTyZndRqREGyVUZdFdppnJ6Ql8DFNLIOUn1BQRz4csfmrIqvvvxWqppGXvjgfVpyPBHqX0
 R1LegEmknky7GmTe5XXw/dZ9NIRfvF6LF3WpxuJ8B3E8QV438rG5sdi6OXlU+uGq3pnLUUmYQ75
 qf0myuMvGrHf8u07H0vLf6xSfW+SDwAwr3fZAQFdK2uHpkHE0IqHPzrmxryUowEFAlZVIzXe+H7
 wrKDRUmaRFjEfe8tODp+s3RWlPxnB41jZjUUM6hKg=
X-Google-Smtp-Source: AGHT+IElyD0JB12gRjrEhem25YSPIbLxwA/iR8LkMmoffP2+Lm7dufJTqe1VqCSc/iB2RJnob0yWLg==
X-Received: by 2002:a05:6000:24c2:b0:431:c73:48a8 with SMTP id
 ffacd0b85a97d-432c37c8796mr25475153f8f.29.1768296960851; 
 Tue, 13 Jan 2026 01:36:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768?
 ([2a01:e0a:3d9:2080::fa42:7768]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e17aasm43719599f8f.15.2026.01.13.01.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:36:00 -0800 (PST)
Message-ID: <7b910d61-cbcf-421b-ade8-904a7f3a06e7@linaro.org>
Date: Tue, 13 Jan 2026 10:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: regulator: common: use dm_gpio_is_valid
 helper
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
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

On 1/8/26 15:42, Julien Stephan wrote:
> Use dm_gpio_is_valid() helper function instead of manually checking the
> gpio.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/power/regulator/regulator_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index ce3d80670de045dde7e263c5301bccd744abd2f5..cf98998579aa8a3cb7f09dccd2124207a58d8b00 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -51,7 +51,7 @@ int regulator_common_get_enable(const struct udevice *dev,
>   	struct regulator_common_plat *plat)
>   {
>   	/* Enable GPIO is optional */
> -	if (!plat->gpio.dev)
> +	if (!dm_gpio_is_valid(&plat->gpio))
>   		return true;
>   
>   	return dm_gpio_get_value(&plat->gpio);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
