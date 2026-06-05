Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD55BCD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0188784949;
	Fri,  5 Jun 2026 15:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dLd35JWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B791384948; Fri,  5 Jun 2026 15:09:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1257E84957
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so1063733f8f.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780664947; x=1781269747; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RvZYXD9rPkBpjc/aJT5ht0N9UM5B0t9y9qPRvHjiQ80=;
 b=dLd35JWxOtAeAINODzcxUEcSm/8/1f3ajLJJ4NOS6A2dUg0vqXe24ssNjfv84xFLS9
 xB7YL916/RWJy/pMyvbVFENcUjeQ+M8QcfzXdFA8e3aNimhU0OiXJORWjidsIiJNqlOM
 5CpLATNHdCdLYg0JdX0FymyPU6b54eCZFyyYkNpgVqW9Onn2C3TknykJSMD38Bn8KRhH
 KhPhCx60i7BSAKyrAWF7J1+cgW+v90v+phmk9CNZ2fKM1sERySryuNuvXqarQRyjpS5V
 auAFO9SdnLRBV0oKiB1MX9iNG6tGCVITiOEuLTYHSE25qqHg4RoFkvu111D0YT16m7q2
 Ging==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780664947; x=1781269747;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvZYXD9rPkBpjc/aJT5ht0N9UM5B0t9y9qPRvHjiQ80=;
 b=VGomyvHOrmtp1KaJ51egO6tsbkul2oiF3nxgyDJT/Aqe4P0gvpHLma03UiJtPQE8O1
 WgG8nWU83ReK4b5VpiFQY/QbdiRqYEOCusV3mTNp6MV2JQ8y5va8T2C9goBwBXE3iVCm
 pTdoLpMqgNfKP22/CVA8Lbh2SLlYv4rv3jCrHpExRa8cdp4/SbkMRbzriPWN47Ij2Dwv
 bDQMSYFHwwXvqtwk2QaPCJLKFIlnYeAh7/eWTnLQyST4BqPLUn3+3rnxilEotbiw8yft
 DVKmzjaH0gNHkE7JKp1fIfCQ3F3YWfFeG02T1DHHLRs1FPWy1vJJHjGT1PUdrRADUGqv
 h2xA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91TNbmQkJsHYre94YubQZDN9I/Ne378Sz4HWrR52OXbraMQqWclFLlXxdczH8K2miGS1RItAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzzGcrKxj4SovLckuBbJro/jfM4zrslF433JQw1Ti0UN06YrYQb
 8Co6CqHFmNrdtu1uOqD8w7PiCiEG7gWBDjjbmNkEPlst11azAIx37YI+XgQPtBEYlTM=
X-Gm-Gg: Acq92OF2rTt8Im+N5wPsMpezwWMClGVs8vHl2qQLj6Oqzznvxk4y6UoC2xJbH31q6H6
 lGijd/U+HjE4tuk7sGkmKCUu6SGI3VzyovCAC5fiO0QT6m/KtsvIWR2SJBBakCQHL0D8+tT9biB
 p4092DxWLsYV08Q4Xq0IhNDZdLpZY7lgmt7FQLHb8a5tWZKvrAExUDrfNiGBgcRZpR2gGcLMbqi
 I9pkfDu++1R0sI26l+8ArvCjE1X7x37QBqD5M6FqqVwMnYcZrDc3eUuhSQZXe8QLeMyXY8NJ4XJ
 yLWzfzi9dvNjXHUKBQ8Gnv1n1Ic9ry332MysKNENAkQvxO1mS0NriLmTyM8FMSn8t9NnESXGTNe
 RQf4UDTXSPd9eCQXM1j/TPicMy22SnoR34DVf9FJQtoGOnrFSValaLpSi5ygogxSg1sHni0RDzL
 lnLKRRFcBarSghCTKyInWWo/JqW5nuD0FPpy428Uok01bY2Wqmu/2gQORSzxHab/a9mV226RfYm
 ISul2gaHHEYt/0G8A==
X-Received: by 2002:a05:6000:46c7:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-460302e3193mr3876807f8f.9.1780664947398; 
 Fri, 05 Jun 2026 06:09:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm24799532f8f.8.2026.06.05.06.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 06:09:07 -0700 (PDT)
Message-ID: <3ffc6bff-1732-466f-9e8a-0a57606c39dc@linaro.org>
Date: Fri, 5 Jun 2026 15:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 07/14] power: domain: meson-ee-pwrc: Staticize and
 constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
Content-Language: en-US, fr
In-Reply-To: <20260508122247.512862-7-marek.vasut+renesas@mailbox.org>
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

On 5/8/26 14:22, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot@lists.denx.de
> ---
>   drivers/power/domain/meson-ee-pwrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
> index 4d9f3bba644..6361f3a6c59 100644
> --- a/drivers/power/domain/meson-ee-pwrc.c
> +++ b/drivers/power/domain/meson-ee-pwrc.c
> @@ -386,7 +386,7 @@ static int meson_ee_pwrc_of_xlate(struct power_domain *power_domain,
>   	return 0;
>   }
>   
> -struct power_domain_ops meson_ee_pwrc_ops = {
> +static const struct power_domain_ops meson_ee_pwrc_ops = {
>   	.off = meson_ee_pwrc_off,
>   	.on = meson_ee_pwrc_on,
>   	.of_xlate = meson_ee_pwrc_of_xlate,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

