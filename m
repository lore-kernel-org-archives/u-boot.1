Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE63C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540FE87976;
	Fri, 12 Jan 2024 09:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l54RCrmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD2187981; Fri, 12 Jan 2024 09:56:00 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8968792D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336c8ab0b20so5327035f8f.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705049757; x=1705654557; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4TkZ9wji1D78BlczypPPTQPPNeHKenaBsaD1kmaimlw=;
 b=l54RCrmDzx7+5Vpgvz6iobhd4HG026WW+XeKE0D9hY9yGS+JiPqnFczRqSf8w6BE//
 tgIiuuqPeK5BPsvW2yK2ZT1vXkL66I5AxS41GR0/yWFgKbPY1pEbRmOryKomS47s/hRP
 oser1WoQGKHVsKX7YEYhZiABjIZkqAcITsbB3qJgU9pDvnWlOzUlLBXdMXJTD8TxNxJ6
 M+ciui0i8k4wMfNflYMXI/tQWw+badpIQJBVisX5s9m3bSQh7MfbaQd9+VicwDcDISqC
 klP6UWd2ZQMaTzzIVj4REyojHzNK+UWEdvRMKNdfBKQlyByPDzQpWuVXC0j1PIV4x5Zq
 VBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705049757; x=1705654557;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4TkZ9wji1D78BlczypPPTQPPNeHKenaBsaD1kmaimlw=;
 b=cA1RIEdqocrsYthamKjQR6trE0BXTDeFgIgRAcUhsqC9nsyaDcQyjUEsBB//E+zonK
 bIkWRci3N7RvpEVtnIdAs31mOgtUsLhBSBUhkBI2Si2fdZbUiJJVMtWIcdscdc+lc3Wb
 c+yKi8aQOlFr5oxq8jKs9zuQFwqNiS+YvuuwkBPeEmBKTWf0sV869Cq8t8uCmYswV7G5
 2EchJw6gELhybdM6DuEimDk9MWw/QMpuKF70oMOyMAaRi1kWBDbIy9Gfp3ouNGe48jSX
 Rk3n3/s84unybhdfOnrG7s/yfhwunZvj/DPnnGeUoGvLC+ZB+nUHkaBhwGE3+X7wiLFv
 /xCg==
X-Gm-Message-State: AOJu0Yz5j4H7GpBaaPoGC+w0aSS8vHqgmSHEOLUIOept6KbcPjt9x9rW
 0NyjplWIajO36usIrikWrWnYjMaL8/JwjSsGEw7ZpooCUpg=
X-Google-Smtp-Source: AGHT+IG1Yi1wwRjJRV/nEPlAQytI1hKoomXgI83opakULLJahcsOaNHeOkQXS5Mx6Iptj22quPWVjA==
X-Received: by 2002:a05:6000:11d1:b0:333:2fd2:5d1a with SMTP id
 i17-20020a05600011d100b003332fd25d1amr628011wrx.76.1705049757576; 
 Fri, 12 Jan 2024 00:55:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f?
 ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
 by smtp.gmail.com with ESMTPSA id
 g1-20020adfa581000000b0033680f7be5fsm3278900wrc.87.2024.01.12.00.55.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 00:55:57 -0800 (PST)
Message-ID: <e51db290-901b-4ccb-8fc8-e9dd1bd045d6@linaro.org>
Date: Fri, 12 Jan 2024 09:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add Mattijs for Android AB
Content-Language: en-US, fr
To: u-boot@lists.denx.de
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
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
In-Reply-To: <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
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

On 12/01/2024 09:40, Mattijs Korpershoek wrote:
> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com
> 
> I'm interested in helping with maintaining the android_ab
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
> 
> Add myself as maintainer for Android AB.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fec063a242f..3c73d8c35c4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -59,6 +59,7 @@ F:	lib/acpi/
>   
>   ANDROID AB
>   M:	Igor Opaniuk <igor.opaniuk@gmail.com>
> +M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
>   R:	Sam Protsenko <semen.protsenko@linaro.org>
>   S:	Maintained
>   F:	boot/android_ab.c
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
