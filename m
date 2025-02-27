Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C22DC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 052A581115;
	Thu, 27 Feb 2025 17:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fp5wIa0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585958118A; Thu, 27 Feb 2025 17:16:53 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F737810ED
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso10520925e9.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740673011; x=1741277811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wiHjs5D26n3P687pTKA9k/DZJSk2LdSRd72SizWa8Hc=;
 b=fp5wIa0deSfFuSNyESYP0FqKJ7YMhcldOJ2BU6oAzpwdUClfX+IUDbLW3alsKSCIuC
 aLTwHgmz6q0U/0kZzLUq2VZLeRYG9EjUHardu7ZQCTWRHK0kYOnXYj+Yo5L2q/0MXBpA
 HFuaSLYH9sVwliHBzIDZtMbmRK8gg2gVRIKslRIY7nIgy/D2LDJuf6wM7zHFtU+fQCT8
 cCx6g91qnTOVL8TkT/6sEYTEvuc70Jjj++O/nmdSAJi7JbaPRes0MP2dYwgZr/2YNhk4
 SuGhxZA68PNiNjWyEAjaOr9Hiva51u3GcEQmXnW79SgTuyK6LEOVQaiQjdufXr33awKe
 VJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673011; x=1741277811;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wiHjs5D26n3P687pTKA9k/DZJSk2LdSRd72SizWa8Hc=;
 b=MLerMOTDnWfKPS/2R/Du7O/Kmg4BV/QwdnIwCMVqWd8x7AOM+dJGnIzy9gM3M9i2wP
 eVA5wVRYm/2+0O3ujCq8TkTRe+Vc8DMOiQabvMEfAKvimnuTSvDb570SEuz4+Vc5rmoF
 XAVdutGwyiRpmSIbe0gAEXOf7UEdu1qKd5mXDMlWwpm2fj9leVayT6fO1B3UrSWC5GhE
 vmJaKqG5ydsQATc0+x9oFAcN2ci6H7zGMGWYOaKbd0rZnjFklE5oXK2o0vsM6x6aGv9d
 61oQywYmPzJCCyOgQ2RsCsR8/hT/Y2p8RPD39oyOW4lMmOC4YYv/mumzYhaxqmT9L92Y
 e0vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsrpVjAZTg9jv1G/K9mSZtZlYpbHTFVGLMfsSUxXE1ZrfJUNSR4LyWj+5Qc03BFurtawkKhjc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzad5jOOabnUwOEh9y6fU5VZYYQbVCLaYvLwFoWYmaPWdb6FBak
 WiKOgcSr6ve8mBPqADVfibomZZi9jW8Gk0b2R5bJGW9QH2Gxk0PMu470XbKFVZ0=
X-Gm-Gg: ASbGncti9G5vypdfOQ2we7+Y6uYOf+5eVVchAD5w5SLdbFFTWLnSQhwe+cm64znlYvE
 jr+fj9z6FhczxdF9aYl/nPPrHLUznPIWMOg0nSNbAc5L15s7auTicnOX4nGRd2jOHy8KM9OREUR
 U8iHHfW7XAvDMdJtq1TSsNfvH1p98BrZ5dw++DWPkARj5J7tvzeML/gFsZ35n9IqiECfmptWkyD
 LmtaPeViwAPolZOnlT3RKbOMEWt41xiIfB5WjDEtyDReF30aeI4QRpiQBJpwEfyH8RiYi/bu97d
 UZT8R0rPbK46jk0uMnl8D+WbtMmLsQBg4rvuDIgGuUpdVumsRxetN7UQyQYemwc6GYCtSc4+paH
 1r0I=
X-Google-Smtp-Source: AGHT+IGi6CE7lbSa3EjSQZrjss6bmflFjwh1qc6nlWwgvV2di8krix6FgUr7pZbxlzCvGdt/JJ9Hzg==
X-Received: by 2002:a05:600c:19d4:b0:439:34dd:c3cc with SMTP id
 5b1f17b1804b1-43ab90169c6mr64356545e9.22.1740673010664; 
 Thu, 27 Feb 2025 08:16:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958?
 ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532bbcsm59336255e9.11.2025.02.27.08.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:16:50 -0800 (PST)
Message-ID: <e7e55f99-cf93-45ac-8f99-d66c5682b832@linaro.org>
Date: Thu, 27 Feb 2025 17:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] mach-snapdragon: of_fixup: fix property length at
 writing
To: Rui Miguel Silva <rui.silva@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
 <20250227094911.497219-2-rui.silva@linaro.org>
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
In-Reply-To: <20250227094911.497219-2-rui.silva@linaro.org>
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

On 27/02/2025 10:45, Rui Miguel Silva wrote:
> The length of a property includes '\0' in a string type one, so
> the length passed by needs to have that in account, if not,
> when getting the property value it will fail because it
> has the wrong size.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 55368dd43b66..ea956a4791d0 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -86,13 +86,13 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   	}
>   
>   	/* Overwrite "phy-names" to only contain a single entry */
> -	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
> +	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy") + 1, "usb2-phy");
>   	if (ret) {
>   		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
>   		return ret;
>   	}
>   
> -	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
> +	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed") + 1, "high-speed");
>   	if (ret) {
>   		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
>   		return ret;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
