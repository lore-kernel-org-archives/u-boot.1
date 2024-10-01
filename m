Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8964CE7D08
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEBB8910B;
	Tue,  1 Oct 2024 12:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yABems2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4FA88C05; Tue,  1 Oct 2024 12:13:32 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3877289174
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42f56ad2afaso57362935e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 03:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727777609; x=1728382409; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ydg9vFUJojqA8jaH6HVmodG2SWeaoUEXoFmlC/VC+jc=;
 b=yABems2i4gI3BcPEvsBBaJdiZC7zA5ssxerhXfyCid5jUAbrf877GOnN3YKELi/yYs
 ZsRVtQkLzTRTGBmPqFErHgkmJYaFiuYyt6PKnOXNqOeaR6rlcz+iWGfii4vnDkhtoy6q
 SzbBmb4XcJTGsCZxydsuszuPKE+UO0qnmOG8Y+QSxHLL4u0fbkWoInYo6NNBv92AQStm
 K6MjkUMlHCnP48ibLk/o+bka2rmLVnsfTtYMx4SsqwmHXbGMUb7ToMOTVC5XALGeoqyx
 f+r5qWnY9hMfu7zaUKG7fIhMjnMmgOXuDHSojoCnUnTN00oKmuHpyvbdP1ASAHkZ/xMN
 e/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727777609; x=1728382409;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ydg9vFUJojqA8jaH6HVmodG2SWeaoUEXoFmlC/VC+jc=;
 b=veGePrz9GQb5SvPznAgcj9Mw6zuyZVGVqXeaehZE0ffKPm/vyMnCiMWZhK84fbbBC5
 2mTSx0J9RnsLdPRwhzwbj2URd8gQvLqjqnGH38qK1thK0qLtOjbwLbjq8+jjiN1+xKhS
 nkTcMDYat5ocA4tBuSu3NDroMpHSCgPv/c1MP4GvNy83X4ez6Q2b5486bKhSP6shj1TS
 ETYffcF+2G7gOQ9NQLFCCkQo+hVq+rXgZyur7fSRHe/v/H8ve8EyalZ7W3Rt/yZW4Zr7
 Fpj2ROy1LdHI56tWihGSw9wE51KcvJgxfncXJ/IXYnijifHZpO8V2gWZbC7Gk52lEXdv
 6HPg==
X-Gm-Message-State: AOJu0YzRai0uYKtonvUmsspHsdxoO4o8LPXOgGKvn/x2PM6eeQVUV8LQ
 oFd9yw/2K6WDew8n77PVud+LJ5oU/g3KGsxlONJosMhQ22RMvJYylqwxa+BX1CKu4eJd0+9ZTKU
 A
X-Google-Smtp-Source: AGHT+IH/mupelz4ohWUYr7ULEIrl6541jjssG5YBOO/mYrzyVY46uWHYtk30mxEoFxvTYk6kF3IxHw==
X-Received: by 2002:a05:600c:5812:b0:42f:75e0:780e with SMTP id
 5b1f17b1804b1-42f75e07ab3mr4149725e9.10.1727777608585; 
 Tue, 01 Oct 2024 03:13:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ec13:4c0:b08d:b067?
 ([2a01:e0a:982:cbb0:ec13:4c0:b08d:b067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57e2fb5bsm127376335e9.39.2024.10.01.03.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 03:13:28 -0700 (PDT)
Message-ID: <9726572a-61e8-457d-aa02-720aa1d5b54b@linaro.org>
Date: Tue, 1 Oct 2024 12:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dfu: sf: rely on DT for spi speed and mode
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
 <87ldz8cij3.fsf@baylibre.com>
 <d350e3d8-557e-4f7f-a4a5-983746d554b5@linaro.org>
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
In-Reply-To: <d350e3d8-557e-4f7f-a4a5-983746d554b5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 01/10/2024 12:01, Neil Armstrong wrote:
> On 01/10/2024 10:52, Mattijs Korpershoek wrote:
>> Hi Neil,
>>
>> Thank you for the patch and sorry the review delay.
>>
>> On mar., sept. 17, 2024 at 14:24, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>>> Align with cmd_sf, and try to rely on DT for spi speed and mode,
>>> and still fallback on spi_flash_probe() if it fails.
>>>
>>> With the current scheme, spi_flash_probe() will be called
>>> with CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>>> with are set to 0 by default on DT platforms using DM_SPI_FLASH.
>>>
>>> Like cmd_sf, keep the option to specify the speed and mode
>>> from the dfu_alt_mode string, but rely on DT properties
>>> if not specified.
>>>
>>> Using CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>>> makes the SPIFC controller on Amlogic Meson G12B & SM1
>>> hardware fail and is unable to recover until a system reboot.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/dfu/dfu_sf.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
>>> index 7c1c0f9e2dc..b5d875be5ea 100644
>>> --- a/drivers/dfu/dfu_sf.c
>>> +++ b/drivers/dfu/dfu_sf.c
>>> @@ -123,6 +123,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>>       unsigned int mode = CONFIG_SF_DEFAULT_MODE;
>>>       char *s, *endp;
>>>       struct spi_flash *dev;
>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>> +    bool use_dt = true;
>>> +#endif
>>
>> Can we use if (IS_ENABLED(CONFIG...)) for this logic instead of #if ?
>>
>> checkpatch.pl seems to warn about this:
>>
>> $ ./scripts/checkpatch.pl --u-boot --git HEAD^..HEAD
>> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
>> #36: FILE: drivers/dfu/dfu_sf.c:126:
>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>
>> I know we will have an unused local variable (use_dt) when
>> DM_SPI_FLASH=n but to me that is fine.
>> We already have unused local variables based on KConfig symbols in
>> dfu_flush_medium_sf()
> 
> Sure, let me check !

OK so there's:
u-boot/drivers/dfu/dfu_sf.c: In function ‘parse_dev’:
u-boot-upstream/u-boot/drivers/dfu/dfu_sf.c:163:8: warning: implicit declaration of function ‘spi_flash_probe_bus_cs’; did you mean ‘spi_flash_protect’? [-Wimplicit-function-declaration]
   163 |   if (!spi_flash_probe_bus_cs(bus, cs, &new))
       |        ^~~~~~~~~~~~~~~~~~~~~~
       |        spi_flash_protect

because there's no dummy spi_flash_probe_bus_cs fallback when !DM_SPI_FLASH

Neil
> 
> Neil
> 
>>
>> Thanks,
>> Mattijs
>>
>>>       s = strsep(&devstr, ":");
>>>       if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
>>> @@ -143,6 +146,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>>               printf("Invalid SPI speed %s\n", s);
>>>               return NULL;
>>>           }
>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>> +        use_dt = false;
>>> +#endif
>>>       }
>>>       s = strsep(&devstr, ":");
>>> @@ -152,9 +158,25 @@ static struct spi_flash *parse_dev(char *devstr)
>>>               printf("Invalid SPI mode %s\n", s);
>>>               return NULL;
>>>           }
>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>> +        use_dt = false;
>>> +#endif
>>>       }
>>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>>> +    if (use_dt) {
>>> +        struct udevice *new;
>>> +
>>> +        if (!spi_flash_probe_bus_cs(bus, cs, &new))
>>> +            dev = dev_get_uclass_priv(new);
>>> +        else
>>> +            dev = NULL;
>>> +    } else {
>>> +        dev = spi_flash_probe(bus, cs, speed, mode);
>>> +    }
>>> +#else
>>>       dev = spi_flash_probe(bus, cs, speed, mode);
>>> +#endif
>>>       if (!dev) {
>>>           printf("Failed to create SPI flash at %u:%u:%u:%u\n",
>>>                  bus, cs, speed, mode);
>>>
>>> ---
>>> base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
>>> change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79
>>>
>>> Best regards,
>>> -- 
>>> Neil Armstrong <neil.armstrong@linaro.org>
> 

