Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B856DC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6E5E83B0E;
	Thu, 10 Apr 2025 10:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mNXtmFT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA9883B15; Thu, 10 Apr 2025 10:57:01 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B4283B21
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so5134455e9.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744275416; x=1744880216; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CVP1DrRRJB1WXUjfuj7+sQ7KBSYueXRgTrnqteIoB5w=;
 b=mNXtmFT/+9A2bJFxZCjwSbLz1raZZua4Msg3pAJ70gs8XjNXPBNJYuv9VJg9dPXkOH
 /2lgZPLKwdRLeV7o6FbiTBkrKDdrO8LUo+7miT2rc4cYjirjJhVAp/DCC+NS4kedPCyR
 otzufdhH112HaJW3w9C9wf7Nm9gjo94pWjhdkpCnUw5YcGuwJNiBeZNuGcjayy2ErNYt
 GTEq6gkg0KPCxq1jrAxz4qzDD/lFpLh0MLH9i9rAbBXlOwi4BCJGdyQxzGguN1KWzT1v
 Zq7SL88/asks66QAnq8j9uafX9fihqg+idoR6fLgsIYZsazkgRZfDOmOw6/WxJJHhx90
 1nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744275416; x=1744880216;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CVP1DrRRJB1WXUjfuj7+sQ7KBSYueXRgTrnqteIoB5w=;
 b=DA8gVz8hcOUXD9EzX6e8w95K8Qp27jsWx2hdYwio5zk2496tV5aJN6mJFZ39ouaRuE
 uqBHeBWxqUEWaY86E58vsyw2I7W53TkJLR97IBIS3nsVdIJHW1Y1ORGIaWl798JSmGi2
 Ih9TDMPjC9fdOHXjy1ma5WcY1uqbarheBrEl7rN8Cx823DwBcgW4ah1i/Aov7wmHCGv1
 sIrKB1SEDp3O3CULL4q9lt4Kuj7CpQJF6+T1RA681K2KL8BtPM/QAJ79a3FJ0PhtQqmp
 Kju6ZZMj2YI2P2kObAsG5O5fW2QnEH76dGwq7B+TkGMayqPkif1eW5W6jQynWcuf/Wsi
 sHEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhT8P7sWVS9czHhOrewMrg3uoRddENPPJ6zmaGtAzH7QqXQDYdc2WF1weGLVCKAWe8jp9AYUs=@lists.denx.de
X-Gm-Message-State: AOJu0YzZBrJ4NT7FCdhXIGD/vvKM7hoO5NO/3+IwptLfpOa67ALYLh9u
 8rFzO1GW42J1q7WumR9qKISiSSDEmaviO+H2RJlMcU3hRgftWHSMsP3UMPNNyGc=
X-Gm-Gg: ASbGncsHR+9Sd+Fmw50KUznf5LGKjwBqR59gvxMWqBqOitaYNX6XD0qPktXqzEjqq4x
 WiYS+rcLJq/jNlKAtvShfMaAfneJUn5XVcM5yQDtw+RWqoDvGoyz2NMmZt+dryQ3URD6Os7/yHi
 e+sP3zR58cVxkyIGSveKbDvD+PgmXCGGa+P17eQkl6RriCoPao5lM38fPz8QCYMUkOOFMpLcvMQ
 sDOHxZtuVvolOuTVgAycks8o6Vk0ebfaMhAozSESDA3tzFFIWseO7fv/PIyTpDDZHH0LkeJP+vB
 qQHeRgRPtbzs75mFf7meVcKKIjiyZmLk5MUuUKhGQ4ZeK/iJbCl+knuM2jgh0rUcZVpjHc6sKXn
 zTLkQvzAUHbm3H+hx3Q==
X-Google-Smtp-Source: AGHT+IF94C4JD6nZzyU9W6XN3dvb2aABl3QnBUrkyhyHSRsLi2wLmXHdAkaD3NUFpcQwJnsxa/KDhw==
X-Received: by 2002:a05:600c:4ecd:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-43f34cdbf91mr3111825e9.17.1744275416351; 
 Thu, 10 Apr 2025 01:56:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893774aasm4185714f8f.30.2025.04.10.01.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 01:56:56 -0700 (PDT)
Message-ID: <6cd94cc0-916d-4063-b588-18bde7f5bae0@linaro.org>
Date: Thu, 10 Apr 2025 10:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] qcom_defconfig: Disable MMC HS200 mode support
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: caleb.connolly@linaro.org, trini@konsulko.com,
 alexeymin@postmarketos.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250410080027.208674-1-sumit.garg@kernel.org>
 <20250410080027.208674-2-sumit.garg@kernel.org>
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
In-Reply-To: <20250410080027.208674-2-sumit.garg@kernel.org>
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

On 10/04/2025 10:00, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Currently the msm_sdhci doesn't yet support DLL configurations which are
> required to enable bus speeds greater that 100MHz. So disable HS200 mode
> support as of now as it requires bus speeds of 200MHz.
> 
> This should fix eMMC issues reported on RB1/RB2 although it should fix
> issues for all Qcom platforms but it's not seen there as mostly SD cards
> available don't support HS200 mode. The SD cards usually works in high
> speed mode whose performance remains unaffected by this change. It only
> affects RB1/RB2 as eMMC flash on these support HS200 mode but the U-Boot
> driver currently is incapable of supporting that.
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index a2b54b95f19..537806450dc 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -81,7 +81,6 @@ CONFIG_QCOM_HYP_SMMU=y
>   CONFIG_MISC=y
>   CONFIG_NVMEM=y
>   CONFIG_I2C_EEPROM=y
> -CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_MMC_SDHCI_MSM=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
