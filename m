Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B0E93709
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAABD86C2A;
	Thu,  5 Oct 2023 14:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pjKPsh5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8544D86C33; Thu,  5 Oct 2023 14:27:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A3F86BDF
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 14:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405524e6768so8364235e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696508873; x=1697113673; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XIDgibJIkeo2ZcyBvv+ediHwi4mDal+OhzVvyCat8ZM=;
 b=pjKPsh5UbhkQwxezumN6s2RvqEq1DmSqZJM/806Gd3bE3gL7BsAEEgwbH7y3RWGGYX
 ZD56RLv37Vk3PUy8y/i0eo1wweObZ1YfYkoRKghIZYa6oXjADmhtlw87nhqXoBu2a5lz
 JVUuPmfsgPTXfw6jvMjJYClAeVf8N9OimbMkEp9fJ48ujzTFKnfpHE/gTBxrVAFxxU2C
 TaMJFJqHu8nZbszI/XJf4IONsSQKrM5nTEPVIX4/OEvxgAdEC0PuMcaHntdzV4RYq1XP
 6Gh7Kmj+ChUKGKzq8IGXEfUpbIMZWoMvepYC3y2rTGRjyKMYn53XfTmuRuwGzdWbkuOu
 euCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696508873; x=1697113673;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XIDgibJIkeo2ZcyBvv+ediHwi4mDal+OhzVvyCat8ZM=;
 b=mOciUCFHmpPNa11XjgcLTOQOfw54juLrHS8uqL/wS80U4dXoYE28MD6P+QAZ+R0Dse
 i7QIzx/lDoFpF3bMrDNxZghcvdm3o9cZLrh9dZcRsckHxqjQpfJQHQh4Kwb5TJvIW0mY
 9qZt8aZVkstouqXCUuZyFpQIospZMn4Ie30ovcgz6/MMOQ7s4C55yxlEhFuyquqc1Yk/
 o67jbx6m9yYDftpDzhvH16Pf6SrsBCrDHsP9UOxGstmqLhXYDW2YIXtS180ECUJPiNKJ
 uJGqXiQBG3WvGXvPA1bXfVwBqKJSDXssI3ZfAebChfKFbA7liUsk0SL6Am5l6gdzLxpq
 EtAQ==
X-Gm-Message-State: AOJu0YyaB2rY4FI3KUOe8HQ8MkejxZ8a0fVh6I0lhqPkmcF/CmIGGpg3
 0HzNqV2wL1PsEXSsrO+Rps+mTg==
X-Google-Smtp-Source: AGHT+IFPmxkl1LsiqmBIFNPQoBfix2KeLOT89GYdM2a0MrwPGoCjccn6FUI22NyvnjnqNnOsgnGbjg==
X-Received: by 2002:a05:600c:24c:b0:406:44d2:8431 with SMTP id
 12-20020a05600c024c00b0040644d28431mr4797230wmj.6.1696508872704; 
 Thu, 05 Oct 2023 05:27:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:53f9:e5cc:ac8f:e0db?
 ([2a01:e0a:982:cbb0:53f9:e5cc:ac8f:e0db])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm3647583wme.47.2023.10.05.05.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 05:27:51 -0700 (PDT)
Message-ID: <3782b09f-8279-4c66-b7f6-7115ee8ce79b@linaro.org>
Date: Thu, 5 Oct 2023 14:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: sm: fix build warning
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru,
 Igor Prusov <ivprusov@salutedevices.com>
References: <20231005081936.72178-1-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231005081936.72178-1-avromanov@salutedevices.com>
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

On 05/10/2023 10:19, Alexey Romanov wrote:
> This fixes following warning during u-boot build:
> WARNING: unmet direct dependencies detected for MESON_SM
>    Depends on [n]: SM [=n]
>    Selected by [y]:
>    - MESON64_COMMON [=y] && ARM [=y] && ARCH_MESON [=y]
> 
> Fixes: 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/sm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index b4cc3f768e..f0987275d2 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -3,7 +3,7 @@ config SM
>   
>   config MESON_SM
>   	bool "Amlogic Secure Monitor driver"
> -	depends on SM
> +	select SM
>   	default n
>   	help
>   	  Say y here to enable the Amlogic secure monitor driver.

Thanks,

Squashed into 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")

Neil
