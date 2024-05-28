Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42289C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C861488422;
	Tue, 28 May 2024 10:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KEXIXusU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857BB87F31; Tue, 28 May 2024 10:04:51 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A19B88422
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-420180b5838so2429665e9.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716883489; x=1717488289; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7rusyuOfqBleAOYo997npLkc6mFrsRzNXOR+NxmHMS0=;
 b=KEXIXusU3EwI62PorEDnMxfvRTpeELRlxO8I/WQArricDjHVGxzctb07aoxaNC2J+w
 Av0Yl2P0xFWrg3UO3qZRejrjynW2rd2FTmVWfU5xgMxt7QmtCMnWO6bb/7AY23/ESlgX
 ucneDQxA8IHfWj8WLc8EilG0zIOWgXbtHgKdNsbiw0n4mnaBzZN2qwttlyhMwP4uJrB7
 wI6sIqYqRaYeQ+u6iRafMPvSelGqH/XotCXrVILahwpVcHB7OnGVBcOWn9w4i3F7TXDa
 KsYWys39tBcwt3Efmniumqwu1LXttiP0+/jjtqGaJ9HL4rjkowSmQMGIxMjbGDhO3rwU
 6b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716883489; x=1717488289;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7rusyuOfqBleAOYo997npLkc6mFrsRzNXOR+NxmHMS0=;
 b=pYf+D7VxvmDZWtzoH13Dnpsmj9hcwmHrZ1TodoKfXBlM/D4mkD0lBRhZChQ5eK1iMM
 jDqd4UMSUu/SECs6fTN2Irl8fT3AzkzZmp/18pG2qVvLckQAINKEJDD00eRkZQnc94Cz
 jd6iEmpzpDsshy2FucxryDg/6ZPb5wRdg3tgMCzQHZFVWknWxUDoTnAqiIEKGdj7vyiX
 0mk1H4KkoWt6C203tOvMh8N4KtC5ULEJ2+GLWh5fkU5a0A1cMoDoPABhVkd4Zkk7kmlt
 1BSZc+2Gi71FOr3ITWs73adOf+WTj2MVzVpH2zadw4ECwDwMUlBMCvtWu2Ivz6cM9EEx
 x6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOy9Xh79aCgg8iAiQEhvvDILudOHXWTb5WGBrgAjAb4hctV7pmmZLyqZIoKqsGU21t8aZx/q3JiYKJl8UuP+XTm5aLkg==
X-Gm-Message-State: AOJu0YxYPn/x6Dp1hPUPhiD8PQ2Fs1J/ZHrQBsm626dY4alo1P/nCqLV
 jgaZ/qds2lYIoZcAoOhZuVuVJtsK+OxJbYkB+LO4qs6gij7wSaCZnCQ/y9ZeAVA=
X-Google-Smtp-Source: AGHT+IF21YHHYO/mTepU9k9/P/0voCesJpN98gZsUSloYkioVOQFPH6bUN27UT3pgtpHc3YXBzl+Yg==
X-Received: by 2002:a1c:4b15:0:b0:41a:aa6:b59e with SMTP id
 5b1f17b1804b1-421089d50abmr116017875e9.5.1716883488760; 
 Tue, 28 May 2024 01:04:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385?
 ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42108966b58sm133277755e9.3.2024.05.28.01.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 01:04:48 -0700 (PDT)
Message-ID: <d1ac1d84-dff1-40d8-bc9f-e2cd8b8c279f@linaro.org>
Date: Tue, 28 May 2024 10:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 7/8] mach-snapdragon: bump up heap size
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-7-47583d7ad428@linaro.org>
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
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-7-47583d7ad428@linaro.org>
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

On 27/05/2024 19:17, Caleb Connolly wrote:
> For capsule updates we need more heap space for the DFU buffer. Give
> ourselves a whole 8MiB!
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 536960b83c3b..5023c906bed8 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -10,8 +10,11 @@ config SYS_VENDOR
>   	  Allows to specify vendor for the Snapdragon SoCs based boards.
>   	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>   	  will be used as the custom board directory.
>   
> +config SYS_MALLOC_LEN
> +	default 0x800000
> +
>   config SYS_MALLOC_F_LEN
>   	default 0x2000
>   
>   config SPL_SYS_MALLOC_F
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
