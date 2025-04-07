Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0289C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA6082F65;
	Mon,  7 Apr 2025 20:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gGVrHrqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3308301A; Mon,  7 Apr 2025 20:09:08 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EEE982F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so3352250f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049346; x=1744654146; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DaLbHQwZoBlmqYEJLDUBcvu0SoJGrIE71dHA/VEMr0Y=;
 b=gGVrHrqJkEicoIU7QrDds5yEro6z9wmbR8SD1cysQZPXdQ85tHVS9aaad3Jybrs0Xu
 ckiZtc+6cT+BS9E9fJvvhUu01DIeneoCCYZIbe1GLHKHaJsJCejG+rmnfvAlrCb9yr9d
 oY+jRT78cBsUuK1S/G7hx/CdKCdYqGkPqWX/Os6f5RPxVw6y3uaK8uMWJbMcS34ZrRnn
 Gf1B5m/8NsrK13bY+DPo15HtEd44dnqEij/y9loJRhyQm7Zck5fz65Pa0qsaHSI3tjEE
 +rbBqSjGSgO8w7SuwKW7/UgNh8qzj0TDhr4On/BBGkwJXLgZsicJf5YFALmQwPHkbFDE
 kLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049346; x=1744654146;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DaLbHQwZoBlmqYEJLDUBcvu0SoJGrIE71dHA/VEMr0Y=;
 b=rwgaSdiHuaa9atstE6wp6T73KffcVK4PUw2w3Cr2Awve5Ly5f1A3Pd7tENhkPiW5bK
 +ar5zb2lAubbgAvqfOoSGCHvpi497TPpl0iY2Wun1BeBMgyRdWOliAU5yjQr8+zuG52Z
 8tRfgdFvF3mOLmEZYzIR9WOJrfzqnZvD56q/QqW6RstI3wqz4g+oF27M/QP3PUUQJRZd
 XCQovbfJhLojHl1nsm1KsuQiXbxu1KmZew3OnciXHyw/ATT+nSTPHRmzI62PAUsrnKhZ
 iU/5EVXFITv9mX8+UzEbM3UclI8Iu9rvrD5Bcl114mWuKt1bOeUosARpz1zld0fT3YU9
 UzAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkJcKIcRgK5gFkoLmy0rz7iXfbcSOiLNrRdDzv4pli+DPqOXg0NAXRWHvGxyYaVDGy2Mj6g+s=@lists.denx.de
X-Gm-Message-State: AOJu0YwSLubrjJTjEyiPBAphtI4vLZOb83s03TCMiNNPzH9lyPi2OZvl
 NeTrjZIP9sWJe1M8AWryuaF4FCdV0owJofvmriByhPaME8RIKHKaSdIes867oEadZcUYTqO4V+2
 w
X-Gm-Gg: ASbGncv2jaQRDw3iOPWg9hGTenpIieSXHTkVjt0R0fka7EPfNkFQ3QJ5IusrUR8KXO/
 ujoZnhj7qhvbStC7pq/6uX/Wpdsbd2jwIflwuCr/KC0IsYZx2yj/AflSvKt8AFFXcwG5dmEcklI
 bMc4qGVoPVMM963biblZPxWmW28SIF2HCkAfx4G3gjikV9QQUbksw3Snu0OZSwd5Rd3IiZeN8oU
 fcBW38khng1y0Ss0Hge8DfrSShdjVllt+DERIG8lmdadM1U87i+e7VqIkeXFt4JzEXxEPB+oCvL
 Lsg9A84XKuvNRI9r/8fxtRTjFpy+Cp69wfKLfA5cAYWaQk/rh2C+hOXgpY8DJvSmv1Bo9i9wMZy
 cLAVeRZMZSJGq0rp1UI/JLw==
X-Google-Smtp-Source: AGHT+IHmsAn+DLjzHqj5SW/eu09xcDq76gni5V/7orZQ7EeQkqfYq4mRju+yDW+tuk9jEBSl1kk+5w==
X-Received: by 2002:a05:6000:2281:b0:390:e8d4:6517 with SMTP id
 ffacd0b85a97d-39d0de28784mr11302766f8f.21.1744049345894; 
 Mon, 07 Apr 2025 11:09:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec163156bsm4805545e9.7.2025.04.07.11.09.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:09:05 -0700 (PDT)
Message-ID: <12b74096-1b81-4ad6-88b6-8cd8a9d42093@linaro.org>
Date: Mon, 7 Apr 2025 20:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 09/13] board: dragonboard410c: Enable RTL8152 ethernet
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-9-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-9-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> The Geniatech DB4 V3 [1] has a RTL8152 onboard for Ethernet. I don't have
> one to test if that works, but the other USB Ethernet drivers work pretty
> much as-is, so just enable it with the assumption it will work out fine.
> 
> [1]: https://www.96boards.org/product/db4/
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   configs/dragonboard410c_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index b7f284b4fa2812c60804126362b61164135adeeb..da1ec4bfc60cdf4a2a9077efb081383b5b39301a 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -69,6 +69,7 @@ CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
