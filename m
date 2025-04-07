Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356AC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCB682CF5;
	Mon,  7 Apr 2025 11:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BQOcKsPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEB282CF5; Mon,  7 Apr 2025 11:03:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A579F82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so19955095e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016604; x=1744621404; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0NpA2S5QIZ8yKjKNJxnzp4LJO48VK4O/nTPQmapaMvY=;
 b=BQOcKsPexzadZ9i14d33BHA1vYE/bjqyjIHKEbTG0iM0ea9DeTWsMbSamS5r1frVNS
 IPbJFZLDowIvIsVDO8/z5m7bE9kYqm4flcu9I7fpDJ38Zlgk29PhWvas1xAYZCMU1urN
 7a4KrsbVYfZJE9qY3tT3f4kzQxuavBDNG5fso7tqs2BEdp2z7fFnO5mORWvjmHeMQJTL
 CNHBvdDhWnpmnGZhC52V/Shp8cdKrtaApGEQ0PmNkGJ32kd2UVkFefxTj5Sy8D7Q856x
 PYMI7C576SI+l7iQ8vZdqvC7421XwFcDaxd2Ew5aHJRFqJsBojJth7W8W7PBUtpKSsri
 TjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016604; x=1744621404;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0NpA2S5QIZ8yKjKNJxnzp4LJO48VK4O/nTPQmapaMvY=;
 b=DvptWB2c9coYBFzsrCdUZiLFK6y+CmSa1v89Qvs6gUzZ7n/qsW/mTYrKtCI5nGUko4
 oElVJdkyUdNvJXDxQxzZv620u3oj5iIJXanp4RlBJJsiB9rugCit0ckIKNBW9On9zyVE
 zKg1182zVNCbwUPa0+3crpDKm8E8kBgdixozndvdRnCK+xz8XcswQny5+TGE39zwPNjF
 u3/0y25UI4m2wlrm/uU9qq1maTMS+DaQ3cEor7Xsg7VaUZoxbdzwPOIHbGiPa6aOq3eF
 3+WVjt2/f9FoKIZaD+8hCTyP3+mjIP4e0IOiijTOOUsF+wRLNcFOzeevDsM4dsZ9cW91
 EPlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFARC2XW8C4+0gLJxOT2lidClOaNhgqEPYUQEKV8HON+q+SSazhE0W9I9jiVvDvwKS3icAlxA=@lists.denx.de
X-Gm-Message-State: AOJu0YycxTZBsqCygntF/Z++B1RHyre4UM2kpcAHdsVMEQB1nQYXowF5
 y5VDvm9BgoFupg3s61zgEKKFUWlG6H4rv9mocv4eoSZWPvk3tmgguM9VrQcznFQ=
X-Gm-Gg: ASbGnctOLpRT6OXumFEI877NcZVPGC7dhO5zcVA+urJI00kfiHxPFlr2D05pFKplq3S
 MnhHAM4soeAWMoHdpXZ3xMP43xvLpkevZO5hL1q90WkXvW61Qq22bgHzO2W6OANQV7UR5Y58GO3
 LL03yJVaz62qzZlciB7nozDgJfMvKwmxn9/OEITrpe70gRJtZPEzTlK+17EGmlGTYjVH980ri60
 JVRX0FzJBGN0Ghh/ZsqmRS7drQ37jTvNlxgNehXxUyCOx3hdE+ERd45a+kqXZFD7lM1iDLLR5ot
 Ah4ttDKm/g+B+z94hh8D6OG8rn75nmGhCpE+ccxxgQUMxBWHVZbdGEr+F9akCWP66maiC7XKN0X
 Q1BznppZrQKdXjA8JuEELmg==
X-Google-Smtp-Source: AGHT+IGlVYxz7khM84RI+A3xPHmx/kpY982qk6fkT9iZJPDuRz4KpYXjhMR+aEjITc57/rarw5TFAA==
X-Received: by 2002:a5d:64c9:0:b0:397:5de8:6937 with SMTP id
 ffacd0b85a97d-39cba975ceemr10105759f8f.41.1744016604066; 
 Mon, 07 Apr 2025 02:03:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30239813sm11291024f8f.101.2025.04.07.02.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:03:23 -0700 (PDT)
Message-ID: <ab16fa0f-4be1-422b-9713-6af98b2a9a9e@linaro.org>
Date: Mon, 7 Apr 2025 11:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/7] configs: dragonboard820: enable GPIO
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-6-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-6-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> Configure GPIO.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   configs/dragonboard820c_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
> index e29bea7deb2..b5b6bc026e8 100644
> --- a/configs/dragonboard820c_defconfig
> +++ b/configs/dragonboard820c_defconfig
> @@ -45,4 +45,5 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_QCOM=y
>   CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GPIO=y
>   CONFIG_SPMI_MSM=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
