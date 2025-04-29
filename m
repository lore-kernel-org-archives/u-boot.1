Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE8CC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 16:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3205182A39;
	Tue, 29 Apr 2025 18:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="euJVyKDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 848D382A4D; Tue, 29 Apr 2025 18:22:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B4A82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so41529965e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745943745; x=1746548545; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ptfsu6n9Lw0JxF0qSEA6dTyjREPmVakpCHOUxzcCsCI=;
 b=euJVyKDgNVQi3V4Yfin5xLYMcXs9WUz8zBcSX867ZSpwU5a2fCYX1dtFc9Y8rrA9Sm
 7wsX5rV8iuVtfJigHGzTqNENV7iZPoLd37fxbP3iFjuESyxyZeO1jkInxKeYkRr65KfP
 C+Z5Tfw9oWEzNEab0o8vnGJRrSzTUXSJH0gtf5UzgCJfigja0XwyPwExcp5y8S31RU1c
 pad7HqT5BhCQXd6MDCjG7RlQjP1iPsogLX1bK65QY1YyDu61TSqlA5BrYsMF0dvRRkkA
 M3ilZAU40uMXVdUTqmT5ngEZo8wSpa6viEIoq+GcX3CyIjniW1eHyR+88rYuOofibxgC
 8P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745943745; x=1746548545;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ptfsu6n9Lw0JxF0qSEA6dTyjREPmVakpCHOUxzcCsCI=;
 b=VR1TagdodyNX8hAIkLB/FV4Y8rNrZyCKbPIwAbOf3VWY+xYDipS3zue9G+gBZvt5Jb
 CmQceeXO6ptT7V68uXR5tCPe264iaq0WI0PsRH71nUhV3zsKbpuIJus8RrisMvgZ5Ocj
 nAUmcIz8aiotgcBro7Fr5hASArhE2+mR0qKxPKnXScYh75RNwkK/Et2ET8hAF0OT/wNk
 tQE9+fxTVp1MW3yzdfoF30X6aYX2/vFuHdwF3WVa7Y7EC5iu6ccrdZC8IWGBT3MTJpUj
 FRgmrbRqRd2diE6ZevRY6MF1YN4nkIaSk2bUBIKN8uqw/4XC7krP5Jd3tb77d6X+DFo+
 axDw==
X-Gm-Message-State: AOJu0YyXRyD97xuStqpzMuGKpEDqFtrOfH38M/pq4Nl/B1+cNa3BPWpJ
 PliRMgpqaigngws+A3OtdwtC6Mnbhr9wY3SvggQAwZFMPXp0M2CqNfm07dYurcQ=
X-Gm-Gg: ASbGncvUHfn+vJgE+LiKrJ+B0g0BhZSVjbD5p6yhtRFlioQ7nBx5M03JBwI+1WgsQdQ
 hwKgY+5OExd4ssqOdyK9nyI6HhCAbVSUIn/lbgF+OSiDEkZe3IH1rOFiDhlWeRarrdS/zIq4gl8
 hDIb/CqA3nVigU+8uac7G0epketfiU5rj3hoFA9H0T6fvSI1FQ/a47rQiwU2wf+FTjMxa6ITiaG
 TPYvrdY09DwFLyoHFzaQyWPyw476e+4XoMy4gCXnm7NhrjPf6uV+JPsUG3qatuKcLjVV5H4yhBG
 7bb3UgnYl1ln9o4qFepgnsr3fDXRCYikGN0H3CJaQcBGEgdq+44CP3ROz1kyaHV3nT3fx55VjvT
 6lnxGqf/MvP6jRBhIBA==
X-Google-Smtp-Source: AGHT+IHAZuiBSZTyOeYX/1xhFpIbomO+Dbrs9ryvWZv43oK+uaGHiUHzCvtx7vupkFXEMh7smmnt5g==
X-Received: by 2002:a05:6000:178f:b0:3a0:8033:1e3a with SMTP id
 ffacd0b85a97d-3a08f754a7bmr9668f8f.2.1745943745184; 
 Tue, 29 Apr 2025 09:22:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7eea:fda1:4564:f556?
 ([2a01:e0a:3d9:2080:7eea:fda1:4564:f556])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46a25sm14535873f8f.69.2025.04.29.09.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 09:22:24 -0700 (PDT)
Message-ID: <c95593d8-9590-46b8-8c29-231f506d77f2@linaro.org>
Date: Tue, 29 Apr 2025 18:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org> <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
 <87zffzwfz9.fsf@kernel.org>
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
In-Reply-To: <87zffzwfz9.fsf@kernel.org>
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

Hi,


<snip>
> But using raw partition descriptors[1] does not work with the above
> 
> [1] https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors

Right, not all features will work with generic block backend, but it's a start!

> 
>>
>>>
>>>> +
>>>> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>>> +	int "Define FASTBOOT block device id"
>>>> +	depends on FASTBOOT_FLASH_BLOCK
>>>> +	help
>>>> +	  "Fastboot block device id"
>>>
>>> This is similar as CONFIG_FASTBOOT_FLASH_MMC_DEV, no?
>>
>> No, the MMC one makes the mmc type implicit, while the block one
>> can target any block device (and mmc)
> 
> I understand, but when CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc",
> CONFIG_FASTBOOT_FLASH_MMC_DEV and FASTBOOT_FLASH_BLOCK_DEVICE_ID are the
> same thing.
> 
>>
>>>
>>> To me, it's confusing to have similar KConfig entries based on interface
>>> type.
>>>
>>> If we really want to do it this way, then we should add a safeguard in
>>> the code: test if FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "mmc" and if so, add a
>>> warning to recommend using FASTBOOT_FLASH_MMC instead.
>>>
>>> What's your opinion on this?
>>
>> Perhaps, not sure it's really problematic
> 
> Maybe not for you, because you have the history on this project. But to
> a newcomer, having both options seems a bit strange.
> 
> If we look at how the blk-uclass is implemented, it inconsisent with how
> it's done with fastboot.
> 
> longer term, I'd rather deprecate the CONFIG_FASTBOOT_FLASH_MMC_DEV
> entry so that we use FASTBOOT_FLASH_BLOCK_INTERFACE_NAME for everything
> (including mmc)
> 
> I understand that you might not have the time for doing so, so as a
> first step can we add a (printf) warning in the fastboot block layer
> when the interface name is mmc ?
> 

Yeah my goal is to first have a support for generic block, merging
both makes sense.

Ok I'll add a warning

Thanks,
Neil


