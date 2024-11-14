Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F46D65C70
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B01989611;
	Thu, 14 Nov 2024 12:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZG7RTntj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC9789574; Thu, 14 Nov 2024 12:05:11 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297228961F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so4712615e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731582306; x=1732187106; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gRJG38YxVjlsZzrX5tGAyFh0NPkok0s3zl/9t64g2Vo=;
 b=ZG7RTntjjomY9UNYo+hepiKdUmExb6fx9m2d6pS80kd7Yas+l62a4Sb4iJvVNJ4A1N
 rO90m+0+1t4JmHupLnLeawJrGuxd6c0vALOsAyGbnXPzrPBHUIk8WhcKNY4opI+6xRvm
 bS7LsLV3tz+OMbyVOKL2QZo9kWO7fZu6uW0Aac3zJaoj3tzXpn2Sw2d61/gynUHn5eQ4
 ihhrWAGnwa1UZwP0dkF821YZlQkbID8DDnQIaWSjYjP1BluLWEz9doTSkH8s9g/PCRNR
 I83sIyJcyOzci8737+y/Aoy6mZU48kNFPfX4jWrNp+KBhc3aXb9nH48+kbFxXiICpWmK
 IN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731582306; x=1732187106;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gRJG38YxVjlsZzrX5tGAyFh0NPkok0s3zl/9t64g2Vo=;
 b=rCPOBMwttStMMzaW/zQK4AxEClzRiZP68PNuZ0NJh6e3zXQQ+wCGz+W95+WoIDQMOZ
 8H5oyDSXbuU+Ax4gXZ4QEGJNqLw5FQDdT/bf2jTSyMLqspLlEmfLR0WWD7uas9Trxakc
 IqbHSdlPgvKV3enbNewpgGxUcAWMHET2yHK1y1UpXZ88N4g9LlzJoQdxvuZxFh8fOzbC
 T2x9Zlon9Lh0Wjnmxog+jaoP2Gy5n7A064iZjccBuCEgGMsIphcjqDGl+NN7LvvjEj8o
 NM7WH0g87lgDgDcVm1F9gdzNMVf+SdJpoDU5GfGjGp8HrwO4sD8VF36rmiXj0eJnoG8b
 4YLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTitAhPfAPF8ZDSayYmfExkTVKvYvDByNHjklt7evc9YcaS1gWpJA/9g2hLWkb5LvfYnnTO/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yymn1TRIaguXH1kacAarvDQfJBJKWxpHAvofH6HoJ5EeAoSWDmn
 StWlGQoX9c0D+w73DqCgRvxOTzhUXYXSvuomf+xZlcD+Dz99/PGWPyfdGd6jaf4=
X-Google-Smtp-Source: AGHT+IGZBbO0SjlMUxjuAoOgV74fZNuA3crTfEFbA7MBQOOu7KvaBSnHez0jxfpvPRJIVBdPR+MWUA==
X-Received: by 2002:a05:600c:a39d:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-432d82a9e5dmr40391645e9.4.1731582306628; 
 Thu, 14 Nov 2024 03:05:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a62a:6bba:b737:406e?
 ([2a01:e0a:982:cbb0:a62a:6bba:b737:406e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da29ffe9sm19996915e9.44.2024.11.14.03.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 03:05:06 -0800 (PST)
Message-ID: <82958f36-2183-4347-8ef8-64b4ff077357@linaro.org>
Date: Thu, 14 Nov 2024 12:05:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: configure logging
To: Caleb Connolly <caleb.connolly@linaro.org>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: u-boot-qcom@groups.io, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20241113050431.1848951-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20241113050431.1848951-1-caleb.connolly@linaro.org>
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

On 13/11/2024 06:04, Caleb Connolly wrote:
> Set LOG_CATEGORY and pr_fmt. Also fix the time.h include.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ab2ceb51389..bbe9d3de7636 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -5,9 +5,11 @@
>    * Copyright (c) 2024 Linaro Ltd.
>    * Author: Caleb Connolly <caleb.connolly@linaro.org>
>    */
>   
> -#include "time.h"
> +#define LOG_CATEGORY LOGC_BOARD
> +#define pr_fmt(fmt) "QCOM: " fmt
> +
>   #include <asm/armv8/mmu.h>
>   #include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <asm/psci.h>
> @@ -28,8 +30,9 @@
>   #include <malloc.h>
>   #include <fdt_support.h>
>   #include <usb.h>
>   #include <sort.h>
> +#include <time.h>
>   
>   #include "qcom-priv.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
