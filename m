Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D92C36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3766382F65;
	Mon,  7 Apr 2025 20:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rba5BITy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4903E82F85; Mon,  7 Apr 2025 20:10:28 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA1482F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so37231485e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049426; x=1744654226; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=pNeU0EBJdIw9Im57BQLZXCEW108pepNze5fU9vVP+yo=;
 b=Rba5BITyCvcabLfib7UCo7HoIwiwpxp7bQdzGeI/JAQOrrvgENxjzryoKg98PatdcQ
 1HrIanjx8LjIkBvgCEUl+b57onSD9KMdiJywCGpJUBC7puco1S5TsXKTxubYxyFBeBhv
 FzL9kX/KEsRHh8xqD5D5zS2rVhearxQJK7TqFFkcsCYvZRFq+cGz4RztOJpBjWpTHVtd
 wTrFbJEJfh42VBXaJ68pACaWAeOy+mWzgKNgtl2Er4dn7zfZBotkCNXpoUnDQgtVdh9N
 s7RPUsd73CVYg5GATr3/AA+T90JDM7PrlNiZ66tMjSd9lW5QM9zRPrHjw1WkXBEDa/xJ
 aQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049426; x=1744654226;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pNeU0EBJdIw9Im57BQLZXCEW108pepNze5fU9vVP+yo=;
 b=ITgXk0d5oD0NK6ZIjwtNAnxTI6zmcJWA6KY4eCg6SaNLUSqqZUe2VY+VF6Pvr6mrLe
 bL/jnOa6eHg56J0Pn436LxL7PkEnR4h60PHCZiHojdXT6aVzpcs39QHzjYDO7rSVek9I
 XliqMQE2CLnC5f7lOFMf3ouyTSVz/WYUewGb1T0fDt7I2XKNn+5XhGUvr50byshP/o/Z
 oQ9EUaRoViO8ippJ4g0lRasyhZ6CEnI9kPYmjXqY20RtzuzmML7nt64kwW+BukAycT0w
 +g7caVi+6nQVBBtBiK9x89ZG3ZxU/P/BRubo59cdS/x6iqlzT7aFjFQCPbVgTJHfMZcI
 FCBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd7zSLbXipIWlCrebACmbCMMLNig3i6lYVHdEidwlc8PJ2XCkxiJsVdnzLm7wBTQp81yQuzIM=@lists.denx.de
X-Gm-Message-State: AOJu0YzVBBnUyw+c4m6cOaAGm/Zv5OSr1oRy/Dj+GUIusIHJ3y51XQew
 uMszJ5e+U28+KJ22UT81NbKwa+fq3GDPAghMKhBV36jbq9AleOotx0S9dLB9XUs=
X-Gm-Gg: ASbGncugGwrf8AtEGXZ92+5jOcRothWImNL/TD2keNyUt9aY39erWA6CCu6vdfeyA5M
 QbyhqN7skjfcrC83GM+tTSkFVkBsXkHnDkfkPMqTAuYOQwAXafSFkqZq9U7+eQ6myMGyHQ1UAwP
 /9mt3Wzhe7K6ARgYBNEEMpAgv9ySC7iraPOIFwXhTZKJnksZlmf9nJFqQZoD49O9HOO46wCAZly
 pBDhttsOMKX+Wy7skFo+b1ppaPqIvHnmzrObjB3BWgYTM8rWNoN8egIsBu7B+dJpflUWHp0qlGT
 wySnkOI8oq1ZPxAzfWLPatUQXeWnn4+j7Q5J9BeqitJNfVDV9TfrjAc8ApWXCsrQa6IsN9RoRSm
 nYvP8qaQy4zxuM+GeBoyeYA==
X-Google-Smtp-Source: AGHT+IG4OljzB4bGcdzqDyfyvW9KHzvpviTr7ALaSNBg/CvYgNqlTLQoua/+CnM3UtapqsHkzgEFmQ==
X-Received: by 2002:a05:600c:384e:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43ed0b483damr133676005e9.2.1744049425732; 
 Mon, 07 Apr 2025 11:10:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663053sm139800745e9.15.2025.04.07.11.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:10:25 -0700 (PDT)
Message-ID: <fb4750e2-2f1b-4b17-8bd5-c050dcca01ee@linaro.org>
Date: Mon, 7 Apr 2025 20:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 11/13] board: dragonboard410c: Enable support for Android
 boot images
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-11-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-11-524aefbc8bb4@linaro.org>
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
> The U-Boot port for DB410c still has plenty of extra space available at
> this point, so avoid disabling features that would be normally enabled by
> default. In particular, this incldues support for Android boot images,
> which is quite likely to be used together with the USB Fastboot interface.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   configs/dragonboard410c_defconfig | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 62fc42c9460d075fd27c3e2823eb8eea2a559772..414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -14,7 +14,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_SYS_LOAD_ADDR=0x80080000
>   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
>   CONFIG_REMAKE_ELF=y
> -# CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
>   CONFIG_BOOTSTD_FULL=y
>   CONFIG_OF_BOARD_SETUP=y
> @@ -25,7 +24,6 @@ CONFIG_SYS_PBSIZE=548
>   # CONFIG_DISPLAY_BOARDINFO is not set
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SYS_PROMPT="dragonboard410c => "
> -# CONFIG_CMD_IMI is not set


What is IMI ?

>   CONFIG_CMD_MD5SUM=y
>   CONFIG_CMD_MEMINFO=y
>   CONFIG_CMD_GPIO=y
> 

