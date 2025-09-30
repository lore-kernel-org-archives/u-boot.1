Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4373FCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC93683335;
	Tue, 30 Sep 2025 20:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yconTOQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864C58349B; Tue, 30 Sep 2025 20:38:20 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087BE800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso86448f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257497; x=1759862297; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nz8HbquO4ZnArCrrElZMt22EfS0owAj310Txo0lpV00=;
 b=yconTOQrPkh1rZ8+hKfvjHrq3mMqzI7jMTS94Ab8t14OagU+of3eAqUigOsV0ljJHq
 tg6ddxSapKCKIt6/sosuAgWQNyf5+4eKHUhaGaVY8yAd2suXi/8vivyfYP3XdhyVot0i
 4nj7SH1/DuguQoBf220dhThM3a8N9noR2FUUFtg1G/RcE2SX6/GAYiRTDfOZdCINjLrG
 xAbnxwSdU9ThRyj67Q0JHC6SHArQKl9BAA+DxELU1mogvq1C3JFWwkn6NjgKCUgi9emJ
 8rDk+/Ufnm6a9m5fUAs6X6lvekD9BbO0dJBgFQ84hfpldJFc2BdrIkLoDzY7ChR7XYmF
 WJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257497; x=1759862297;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nz8HbquO4ZnArCrrElZMt22EfS0owAj310Txo0lpV00=;
 b=UR7zWrCmTywuOILjongofG27827jZ8anvcX7ggSA2dA7cP2nXnIDfuOYPLb3tW+ROx
 TIY+Wv0XPFTq/7xI8lzEHqnQLsDoEsTH404PX80aVY5izZsoOzQEfcWZTlOAzkNhbkBm
 7fcq2aiWSQk/QB7A2zhsOI5mdjOS75mJgwYsk+MtO3upBsqpQjV3voF6qIZcsMi0KqRz
 MQkxNyUM8xorJ+Faygl1W1qC5MeudnPWTECzRe4CkzMZ8Yldcl3jfxueeZwe4mlm8tBG
 qrLnUaaV4+hakyZEthN06dRLHtvrcMNuFqSBqLRZJkF3+gGFenUC7EMlN5X5HqkgQFTT
 YlRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyAjUo9628N2oVR0Dtx3dyUAWsY1Npx0MeU+QKMVmYXXuE2mFgQ0Vbt9UUSKbhfR6FvyvIKHA=@lists.denx.de
X-Gm-Message-State: AOJu0YwBPaKyPivj0t6BAG6qQ9RN9rplq61YSLqP4OP+DCTcMw5TQotH
 1ELDQE4RzEVc2HIogpk6My/GxMAYzKhYGSE2RbQFVtDIc6UC2PwWAMZNFBjsyP2hL30=
X-Gm-Gg: ASbGnctlq686GN6/u0frHUn/FfmgWx52b3GaRWkO7FVZF9GqBd7W8cQsNv1vy9kNEmT
 WWJ57cLBDuTpMaGZOdb8n6PpTAgF/spdDavhPmpPRr9FqVUG03JpVO0FSCJWR36k2Al0dEVtHtC
 YOiav0AIABJAEgpwp+IwmA5exz1ZnI7tvP2IPBcW2mCjyMz8uyEMJ+NhjzCYqHUqgaTLaBdXgg0
 E8X5sAbI/ckiVfgUvH9i5I5oVxUFWCUx6EPoySKPwjfr+6DLPeMVirkj5w/AZUpRSjcgINXCWgp
 0F1TFnQxqMMwm7FlI7PSvJci/h7DU1STu6uY1hcENXckOBxOUBGLIfnQ5X0JGiYq4+MBS57ox/m
 9mN9oa3/ChB6hnyZyK7ZidiZkZ2vGcUXUj1iGUI8A4UGTN8mv63+OgSkUOWtvTyuCREGgFzMsAm
 Ls1DoARFb9p0mi+gRVOnQfC1AxKbxo4MMvgQ==
X-Google-Smtp-Source: AGHT+IH96c6sD1/Ftf4CBhdjq7DRm7v6HSN4JozUacA/vWiYRf2+Kb1FRQ78h4F9BVtFodUTTPwhRg==
X-Received: by 2002:a05:6000:26cc:b0:3ec:c50c:7164 with SMTP id
 ffacd0b85a97d-425577f4ddemr636832f8f.15.1759257496897; 
 Tue, 30 Sep 2025 11:38:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm23643968f8f.24.2025.09.30.11.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:16 -0700 (PDT)
Message-ID: <feb06340-eed2-4757-aa90-2c0bfbd04259@linaro.org>
Date: Tue, 30 Sep 2025 20:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] pinctrl: qcom: sc7280: Fix offset of UFS_RESET
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
 <20250924-2025-10-misc-v1-1-7e75842ca714@fairphone.com>
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
In-Reply-To: <20250924-2025-10-misc-v1-1-7e75842ca714@fairphone.com>
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

On 9/24/25 13:30, Luca Weiss wrote:
> There's no WEST, SOUTH or NORTH in sc7280 pinctrl. Fix the offset of the
> ufs_reset pin.
> 
> Fixes: 51ec7fdb64b ("pinctrl: qcom: add sc7280 pinctrl driver")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/pinctrl/qcom/pinctrl-sc7280.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> index fe87947fbbf9c27509498c1da982997e4d542478..d62b2cc6fb6b3e50773df7cd8bdedd43841c540a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7280.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
> @@ -10,10 +10,6 @@
>   
>   #include "pinctrl-qcom.h"
>   
> -#define WEST 0x00000000
> -#define SOUTH 0x00400000
> -#define NORTH 0x00800000
> -
>   #define MAX_PIN_NAME_LEN 32
>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>   
> @@ -47,7 +43,7 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>   	}
>   
>   static const struct msm_special_pin_data sc7280_special_pins_data[] = {
> -	[0] = UFS_RESET("ufs_reset", SOUTH + 0xbe000),
> +	[0] = UFS_RESET("ufs_reset", 0xbe000),
>   	[1] = SDC_PINGROUP("sdc1_rclk", 0xb3004, 0, 6),
>   	[2] = SDC_PINGROUP("sdc1_clk", 0xb3000, 13, 6),
>   	[3] = SDC_PINGROUP("sdc1_cmd", 0xb3000, 11, 3),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
