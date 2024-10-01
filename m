Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68FACE7D05
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638E08918F;
	Tue,  1 Oct 2024 12:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ticSh1xK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B288918F; Tue,  1 Oct 2024 12:02:00 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0A888B1F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so681748566b.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727776916; x=1728381716; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=r7lbniU0UCRelfv2Yyl1vo/wocIlU44i2TP/zIQAI4g=;
 b=ticSh1xKtSdKDIslPyxk6RmBSOeOUGs7A8ifcQ8mM5k9lyWb6Iw1cS8C39GpGldps5
 2Q/eG2gPwRCxntgWv5tmCzDfKn08pky82oPt78Ebh4eapz9agFbdNZChe7275xvVjARi
 DncdczJowefAAWfqthyXjal2OzlvLVydaRfaCPKhTFjxM90QQhcDKmrFwH3xGVNqNuky
 o2QQy9N0mtSgH3pXClEKWcFAWgl+1KdfKWBKo9Nh/1ULvBKWYFGI4UoXowvfgdpXhkOq
 X2csv5rO8+8B9XRo4uD9Nf5AVb/kMrJA+FrV8OmKw58pXuiptnDj3A1dWAaPfLarAPlV
 7Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727776916; x=1728381716;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r7lbniU0UCRelfv2Yyl1vo/wocIlU44i2TP/zIQAI4g=;
 b=iZJsSjrcMn9bsS5EjVvjzB/HgxDw8eFMt9CuQ8d85vsU3iNbISGqnWNYOMJ6rZPzuH
 FpG2jus3hSmvLJDT93FXxc76G+boJzhZrvOh1GfNE7E1/C/or/I3qqn9x8b7Bt82AtIe
 4hm5tsUw499/QtZa950ZAARLNUYoqIvrqS+I0F8KPYD+6MWmJLmibCfG0tFQuc5HfpdX
 0H17ff5hXVGHZa4YHDeR+gCGTggDPL8t/hOxoPMAJOoV7FoHNz6GZtEI8BWY7XSyiaoZ
 osIbiGOZJl1G8ByovcvnFW0S3fgJMJ6exRv+oWzsXsKA8/E1grjFfA5fo1v01e0fJWLg
 t1lA==
X-Gm-Message-State: AOJu0Yy4Zw7s+QnhuI5lJueTO/qzKLQDy9ZdvkTMahoM1VPBJHh38Y9k
 gC/25WSzNHfOvusogluVeY3l3HHKKCZz0MWkk8WM3Is+udJSbIVyMzKlDkAJnPoguuXSXAsACzU
 F
X-Google-Smtp-Source: AGHT+IGMaGWDBn+XiRyRiBOYJBPHSa1Y29nPX3eP+grCiplLs21FKoH+AErNf6Djfdrqr2Ssy8wqAQ==
X-Received: by 2002:adf:a413:0:b0:37c:cc96:d1cd with SMTP id
 ffacd0b85a97d-37cd5aaf9f5mr9816471f8f.34.1727776903469; 
 Tue, 01 Oct 2024 03:01:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ec13:4c0:b08d:b067?
 ([2a01:e0a:982:cbb0:ec13:4c0:b08d:b067])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6587sm11386535f8f.47.2024.10.01.03.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 03:01:43 -0700 (PDT)
Message-ID: <d350e3d8-557e-4f7f-a4a5-983746d554b5@linaro.org>
Date: Tue, 1 Oct 2024 12:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dfu: sf: rely on DT for spi speed and mode
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240917-uboot-topic-dfu-sf-dt-v1-1-8cf38451eea4@linaro.org>
 <87ldz8cij3.fsf@baylibre.com>
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
In-Reply-To: <87ldz8cij3.fsf@baylibre.com>
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

On 01/10/2024 10:52, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> Thank you for the patch and sorry the review delay.
> 
> On mar., sept. 17, 2024 at 14:24, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Align with cmd_sf, and try to rely on DT for spi speed and mode,
>> and still fallback on spi_flash_probe() if it fails.
>>
>> With the current scheme, spi_flash_probe() will be called
>> with CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>> with are set to 0 by default on DT platforms using DM_SPI_FLASH.
>>
>> Like cmd_sf, keep the option to specify the speed and mode
>> from the dfu_alt_mode string, but rely on DT properties
>> if not specified.
>>
>> Using CONFIG_SF_DEFAULT_SPEED and CONFIG_SF_DEFAULT_MODE
>> makes the SPIFC controller on Amlogic Meson G12B & SM1
>> hardware fail and is unable to recover until a system reboot.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/dfu/dfu_sf.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
>> index 7c1c0f9e2dc..b5d875be5ea 100644
>> --- a/drivers/dfu/dfu_sf.c
>> +++ b/drivers/dfu/dfu_sf.c
>> @@ -123,6 +123,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>   	unsigned int mode = CONFIG_SF_DEFAULT_MODE;
>>   	char *s, *endp;
>>   	struct spi_flash *dev;
>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>> +	bool use_dt = true;
>> +#endif
> 
> Can we use if (IS_ENABLED(CONFIG...)) for this logic instead of #if ?
> 
> checkpatch.pl seems to warn about this:
> 
> $ ./scripts/checkpatch.pl --u-boot --git HEAD^..HEAD
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible
> #36: FILE: drivers/dfu/dfu_sf.c:126:
> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
> 
> I know we will have an unused local variable (use_dt) when
> DM_SPI_FLASH=n but to me that is fine.
> We already have unused local variables based on KConfig symbols in
> dfu_flush_medium_sf()

Sure, let me check !

Neil

> 
> Thanks,
> Mattijs
> 
>>   
>>   	s = strsep(&devstr, ":");
>>   	if (!s || !*s || (bus = simple_strtoul(s, &endp, 0), *endp)) {
>> @@ -143,6 +146,9 @@ static struct spi_flash *parse_dev(char *devstr)
>>   			printf("Invalid SPI speed %s\n", s);
>>   			return NULL;
>>   		}
>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>> +		use_dt = false;
>> +#endif
>>   	}
>>   
>>   	s = strsep(&devstr, ":");
>> @@ -152,9 +158,25 @@ static struct spi_flash *parse_dev(char *devstr)
>>   			printf("Invalid SPI mode %s\n", s);
>>   			return NULL;
>>   		}
>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>> +		use_dt = false;
>> +#endif
>>   	}
>>   
>> +#if CONFIG_IS_ENABLED(DM_SPI_FLASH)
>> +	if (use_dt) {
>> +		struct udevice *new;
>> +
>> +		if (!spi_flash_probe_bus_cs(bus, cs, &new))
>> +			dev = dev_get_uclass_priv(new);
>> +		else
>> +			dev = NULL;
>> +	} else {
>> +		dev = spi_flash_probe(bus, cs, speed, mode);
>> +	}
>> +#else
>>   	dev = spi_flash_probe(bus, cs, speed, mode);
>> +#endif
>>   	if (!dev) {
>>   		printf("Failed to create SPI flash at %u:%u:%u:%u\n",
>>   		       bus, cs, speed, mode);
>>
>> ---
>> base-commit: 19dbc09405d3503ce3efef3c2e4b4f0f1a03372d
>> change-id: 20240917-uboot-topic-dfu-sf-dt-8ae62e5c7d79
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>

