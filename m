Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE223ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365B589070;
	Tue, 10 Sep 2024 14:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VAGjqZ1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB85D89079; Tue, 10 Sep 2024 14:27:31 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D7889069
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso23164145e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971249; x=1726576049; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=++ADQfGas4z1QrTswxPFLCQDyXVkuUo18IcX1MNvvfE=;
 b=VAGjqZ1eBaTNY69Ba1S+stXxW/tAEUNCm4d413XItybDY2eBZX+iDKJ5pVIej5FG7P
 cAAFDNo+YbE+BhFPDPa6/speed4MqcEbvaBa04N6sTw4ZLjIEyhMQZglOUhXESEW46nD
 b6KvRX93tqdyJugttJZ7xlI8wqCQtkUsL+81wNjmvQ+exovDTEYFpcQmu68XkXSkh2zh
 A02+xesEGadcNW4vPSfo657qrrVSgbMxtEcLRChdcBdpc+iGTbkQlPKkQZiNuZHqzAeX
 VxlHZkB8MwOOUkT4F8VblijmxbGPFWoP6fwq0rAjf7D+6WYqyezIJU7OV7OKhtjWAhmp
 yq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971249; x=1726576049;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=++ADQfGas4z1QrTswxPFLCQDyXVkuUo18IcX1MNvvfE=;
 b=ittRYbAJdBzR0KPGqZ2sHSL016HCXfsEeNr+zqIa/54NpM8pnEWOl4smEBoaaEJ5JG
 wI0sFQxfv1HtCNLqbBWIl1Sf+lKkG0TXFtncOWsos/KMczhRyGH2bj0gJL4Gx8rxiSag
 9Jrs2WbZGSEr3HHF+Yt2ozd4+oO+zW65Cm0u1ejyF9+FDWgCwgewI8AonXf/00e2Lp+K
 4rZu+6cM2OVuBd2/3jJpmQuVUWPSm86ZKNkkm90ml5TNMMI98DpCxdPTHszh7nJj0cqz
 yC/3NAt4uk9ToN0OYeyIxxZWBPG+rYcbAXe9LqaaFzZSCk8ttinbnf93KnWFuWlhKUZy
 MF/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfkxAls0PXvcByB0LWhaPeqca41FMHiObXC2IvfVkqd9dmDcCtCnYC62URmk0LhiT2gBqZ+L0=@lists.denx.de
X-Gm-Message-State: AOJu0YwpmPYR8T3LANe3dGz4vr82qxbL992zEWIdEAfPDKhbtAfEU9BG
 1KzFm6D66oTUi0CKWC8IEmUUdqX4Qt1lvHAa257IYD4nt8IRt9CL3pymsxlx0B0=
X-Google-Smtp-Source: AGHT+IEM158Dg6tKGn5vnpIw2nsiVzNdXh/z32AMKhJ/xCWd2QfGTyrE1xD8rznmfoU1zDnZ7PmadA==
X-Received: by 2002:a05:600c:1d18:b0:42c:b98d:b993 with SMTP id
 5b1f17b1804b1-42cbddbd807mr18201895e9.2.1725971248624; 
 Tue, 10 Sep 2024 05:27:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:44b1:5873:83f4:c201?
 ([2a01:e0a:982:cbb0:44b1:5873:83f4:c201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dbf58sm8762812f8f.94.2024.09.10.05.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:27:28 -0700 (PDT)
Message-ID: <932aa894-d367-4aa5-a5ac-67a977d84f6c@linaro.org>
Date: Tue, 10 Sep 2024 14:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] pinctr: qcom: sm8250: add special pins pins
 configuration data
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
 <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-2-50623a7e4931@linaro.org>
 <09a00f61-ee64-42ac-ae76-9a9194edd649@linaro.org>
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
In-Reply-To: <09a00f61-ee64-42ac-ae76-9a9194edd649@linaro.org>
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

On 10/09/2024 14:14, Caleb Connolly wrote:
> 
> 
> On 10/09/2024 10:58, Neil Armstrong wrote:
>> Add the special pins configuration data to allow setup the bias
>> of the UFS and SDCard pins on the SM8250 SoC.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-sm8250.c | 41 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
>> index dac24f11bc2..69c907e3868 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
>> @@ -18,8 +18,37 @@
>>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>>   
>>   static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup12", 1 },
>> -								 { "gpio", 0 },
>> -								 { "sdc2_clk", 0 } };
>> +								 { "gpio", 0 }, };
>> +#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
>> +	{						\
>> +		.name = pg_name,			\
>> +		.ctl_reg = ctl,				\
>> +		.io_reg = 0,				\
>> +		.pull_bit = pull,			\
>> +		.drv_bit = drv,				\
>> +		.oe_bit = -1,				\
>> +		.in_bit = -1,				\
>> +		.out_bit = -1,				\
>> +	}
>> +
>> +#define UFS_RESET(pg_name, offset)			\
>> +	{						\
>> +		.name = pg_name,			\
>> +		.ctl_reg = offset,			\
>> +		.io_reg = offset + 0x4,			\
>> +		.pull_bit = 3,				\
>> +		.drv_bit = 0,				\
>> +		.oe_bit = -1,				\
>> +		.in_bit = -1,				\
>> +		.out_bit = 0,				\
>> +	}
>> +
>> +static const struct msm_special_pin_data sm8250_special_pins_data[] = {
>> +	[0] = UFS_RESET("ufs_reset", SOUTH + 0xb8000),
>> +	[1] = SDC_PINGROUP("sdc2_clk", NORTH + 0xb7000, 14, 6),
>> +	[2] = SDC_PINGROUP("sdc2_cmd", NORTH + 0xb7000, 11, 3),
>> +	[3] = SDC_PINGROUP("sdc2_data", NORTH + 0xb7000, 9, 0),
>> +};
>>   
>>   static const unsigned int sm8250_pin_offsets[] = {
> 
> Could you also remove the special pin entries at the end of this array?

Sure !

Neil

> 
> Kind regards,
>>   	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,   [5] = NORTH,
>> @@ -62,7 +91,12 @@ static const char *sm8250_get_function_name(struct udevice *dev, unsigned int se
>>   
>>   static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selector)
>>   {
>> -	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>> +	if (selector >= 180 && selector <= 183)
>> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
>> +			 sm8250_special_pins_data[selector - 180].name);
>> +	else
>> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>> +
>>   	return pin_name;
>>   }
>>   
>> @@ -76,6 +110,7 @@ static struct msm_pinctrl_data sm8250_data = {
>>   		.pin_offsets = sm8250_pin_offsets,
>>   		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
>>   		.special_pins_start = 180,
>> +		.special_pins_data = sm8250_special_pins_data,
>>   	},
>>   	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>>   	.get_function_name = sm8250_get_function_name,
>>
> 

