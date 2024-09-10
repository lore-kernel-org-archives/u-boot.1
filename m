Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE46EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AA789049;
	Tue, 10 Sep 2024 14:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UMkhXyqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE258905A; Tue, 10 Sep 2024 14:07:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9002589037
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3770320574aso3386566f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725970033; x=1726574833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QBUgYmIM/lVms26c10bxT9Tr7oTgGyL/i4aK8TBi0K4=;
 b=UMkhXyqQukLVcQ6TdAxW0VcPPhq5wa1oxMM4BAGJlKRyVdfnvcRJ5gnRGb5XLAZzJ1
 M4/nNeBzyPPb0ie86oH8SJt3qnBvqYBzqVLWfBXIchQrxw7Alm99C6ZZQCAZhXp6XGek
 f+/xLmQVtn3TP6ECX0lFYsRRIb7qfqTZsKmdCA8/r/abFMUJOFkKmHra2fwx83dBuRS4
 y7czouj6SlFoLllcb/FiLgOYCIl3CoUHZZgklPUE0BgZB8i2lfZekQQn3MXGgDKIdsaK
 P85W3tD4QUPTCqTQ6KHSfAOlkOHvFIJTvpgg186k//KCSeONpvA1A6QS6Gcw4gyOf5EU
 wb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970033; x=1726574833;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QBUgYmIM/lVms26c10bxT9Tr7oTgGyL/i4aK8TBi0K4=;
 b=VwEn+H4O3yXmFJupCMxEkSR1PsNXN5t75Un0V2fMKxTBCDOHstH69tSlJb34ZuOfyq
 wEySM33R/Up/xNNjD4wZIAAUaCBEMdBOM2SEy29N2m3SlNjs+xpee87KVUPfmJy4tyRB
 PYfzpR6ZeX00Yf+EUZfEp6VPfkqmWVAPCY50B7PObGBPJcVDYDTt4Mvteh8R5LComkAh
 bVEi1kKd6zdsYrRBmgAYM1cGqfgQPmlu0QGM5CNXcCxE8VnVAtVvzo8vSRyROM0vYIoh
 31YxtgdSj+6ofzbridY7Eh08PvRvvmHnQUiiEMaghxPbLuLct284F7Ub9WrgwB+oVpAx
 eFyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV74D5XgcSgGlkWWvdO21o0LenVKmROMJ+KwJVL8xe8GP1GXmr8xribqBUvDJrl+dRu2HvtVHI=@lists.denx.de
X-Gm-Message-State: AOJu0YwNAKGh0xHEEEvBDos/jk8fLukuQrbKU2/0fY8i9f4iyTXZgbQK
 iQofBkP0Yhhx/otp3BhL80F1efrqm1urv3F0QHtqDHwQy8EBJNknJKfOEKJ85Pg=
X-Google-Smtp-Source: AGHT+IEbZk5sstjUYPE4WQC701UnbwkOExLNnqNFaQSxhPRBBhWvYz3Hf4OqhaNyrU/M6Jkw3f4lOQ==
X-Received: by 2002:a5d:670a:0:b0:374:c61a:69b8 with SMTP id
 ffacd0b85a97d-378895c9439mr9072452f8f.15.1725970032302; 
 Tue, 10 Sep 2024 05:07:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:44b1:5873:83f4:c201?
 ([2a01:e0a:982:cbb0:44b1:5873:83f4:c201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d363asm8786921f8f.72.2024.09.10.05.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:07:11 -0700 (PDT)
Message-ID: <b22f8910-1278-4bd2-9d4c-1a494936f459@linaro.org>
Date: Tue, 10 Sep 2024 14:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] pinctrl: qcom: add driver for SM8150 SoC
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot@lists.denx.de
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io
References: <20240909155315.307026-1-lehmanju@devpi.de>
 <20240909155315.307026-3-lehmanju@devpi.de>
 <cd9da433-312c-4267-a26a-0d55f2093373@linaro.org>
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
In-Reply-To: <cd9da433-312c-4267-a26a-0d55f2093373@linaro.org>
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

On 10/09/2024 14:05, Caleb Connolly wrote:
> Hi Julius,
> 
> Thanks for the patch!
> 
> On 09/09/2024 17:53, Julius Lehmann wrote:
>> Add pinctrl and GPIO driver for SM8150. Driver code is based on the
>> similar U-Boot drivers. All constants are taken from the corresponding
>> Linux driver. This drivers differs from the similar U-Boot drivers,
>> because SM8150 SoC have different function IDs for the same functions
>> on different pins.
>>
>> Co-authored-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
>> ---
>>
>>   drivers/pinctrl/qcom/Kconfig          |   8 ++
>>   drivers/pinctrl/qcom/Makefile         |   1 +
>>   drivers/pinctrl/qcom/pinctrl-sm8150.c | 119 ++++++++++++++++++++++++++
>>   3 files changed, 128 insertions(+)
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index b326fa8514..501939f783 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -74,6 +74,14 @@ config PINCTRL_QCOM_SM8650
>>   	select PINCTRL_QCOM
>>   	help
>>   	  Say Y here to enable support for pinctrl on the Snapdragon SM8650 SoC,
>> +	  as well as the associated GPIO driver.
>> +
>> +config PINCTRL_QCOM_SM8150
>> +	bool "Qualcomm SM8150 GCC"
>> +	select PINCTRL_QCOM
>> +	help
>> +	  Say Y here to enable support for pinctrl on the Snapdragon SM8150 SoC,
>> +	  as well as the associated GPIO driver.
>>   
>>   endmenu
>>   
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index 4f1d96787b..cc3660a576 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_PINCTRL_QCOM_SM6115) += pinctrl-sm6115.o
>>   obj-$(CONFIG_PINCTRL_QCOM_SM8250) += pinctrl-sm8250.o
>>   obj-$(CONFIG_PINCTRL_QCOM_SM8550) += pinctrl-sm8550.o
>>   obj-$(CONFIG_PINCTRL_QCOM_SM8650) += pinctrl-sm8650.o
>> +obj-$(CONFIG_PINCTRL_QCOM_SM8150) += pinctrl-sm8150.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
>> new file mode 100644
>> index 0000000000..c3af3448f6
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Qualcomm SM8150 pinctrl and GPIO driver
>> + *
>> + * Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> + * Copyright (c) 2024 EPAM Systems.
>> + *
>> + * (C) Copyright 2024 Julius Lehmann <lehmanju@devpi.de>
>> + *
>> + * Based on similar U-Boot drivers. Constants were taken from the Linux driver
>> + */
>> +
>> +#include <dm.h>
>> +
>> +#include "pinctrl-qcom.h"
>> +
>> +#define WEST	0x00100000
>> +#define EAST	0x00500000
>> +#define NORTH	0x00900000
>> +#define SOUTH	0x00D00000
>> +
>> +#define MAX_PIN_NAME_LEN 32
>> +static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>> +
>> +static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup2", 1 },
>> +								 { "gpio", 0 },
>> +								{ "sdc4", 0 } };
>> +
>> +static const unsigned int sm8150_pin_offsets[] = {
>> +	[0]   = SOUTH, [1]   = SOUTH, [2]   = SOUTH, [3]   = SOUTH,
>> +	[4]   = SOUTH, [5]   = SOUTH, [6]   = SOUTH, [7]   = SOUTH,
>> +	[8]   = NORTH, [9]   = NORTH, [10]  = NORTH, [11]  = NORTH,
>> +	[12]  = NORTH, [13]  = NORTH, [14]  = NORTH, [15]  = NORTH,
>> +	[16]  = NORTH, [17]  = NORTH, [18]  = NORTH, [19]  = NORTH,
>> +	[20]  = NORTH, [21]  = EAST,  [22]  = EAST,  [23]  = EAST,
>> +	[24]  = EAST,  [25]  = EAST,  [26]  = EAST,  [27]  = EAST,
>> +	[28]  = EAST,  [29]  = EAST,  [30]  = EAST,  [31]  = NORTH,
>> +	[32]  = NORTH, [33]  = NORTH, [34]  = NORTH, [35]  = NORTH,
>> +	[36]  = NORTH, [37]  = NORTH, [38]  = SOUTH, [39]  = NORTH,
>> +	[40]  = NORTH, [41]  = NORTH, [42]  = NORTH, [43]  = EAST,
>> +	[44]  = EAST,  [45]  = EAST,  [46]  = EAST,  [47]  = EAST,
>> +	[48]  = EAST,  [49]  = EAST,  [50]  = EAST,  [51]  = SOUTH,
>> +	[52]  = SOUTH, [53]  = SOUTH, [54]  = SOUTH, [55]  = SOUTH,
>> +	[56]  = SOUTH, [57]  = SOUTH, [58]  = SOUTH, [59]  = SOUTH,
>> +	[60]  = SOUTH, [61]  = SOUTH, [62]  = SOUTH, [63]  = SOUTH,
>> +	[64]  = SOUTH, [65]  = SOUTH, [66]  = SOUTH, [67]  = SOUTH,
>> +	[68]  = SOUTH, [69]  = SOUTH, [70]  = SOUTH, [71]  = SOUTH,
>> +	[72]  = SOUTH, [73]  = SOUTH, [74]  = SOUTH, [75]  = SOUTH,
>> +	[76]  = SOUTH, [77]  = SOUTH, [78]  = SOUTH, [79]  = SOUTH,
>> +	[80]  = SOUTH, [81]  = SOUTH, [82]  = SOUTH, [83]  = NORTH,
>> +	[84]  = NORTH, [85]  = NORTH, [86]  = NORTH, [87]  = EAST,
>> +	[88]  = NORTH, [89]  = NORTH, [90]  = NORTH, [91]  = NORTH,
>> +	[92]  = NORTH, [93]  = NORTH, [94]  = NORTH, [95]  = NORTH,
>> +	[96]  = NORTH, [97]  = NORTH, [98]  = SOUTH, [99]  = SOUTH,
>> +	[100] = SOUTH, [101] = SOUTH, [102] = NORTH, [103] = NORTH,
>> +	[104] = NORTH, [105] = WEST,  [106] = WEST,  [107] = WEST,
>> +	[108] = WEST,  [109] = WEST,  [110] = WEST,  [111] = WEST,
>> +	[112] = WEST,  [113] = WEST,  [114] = SOUTH, [115] = SOUTH,
>> +	[116] = SOUTH, [117] = SOUTH, [118] = SOUTH, [119] = SOUTH,
>> +	[120] = SOUTH, [121] = SOUTH, [122] = SOUTH, [123] = SOUTH,
>> +	[124] = SOUTH, [125] = WEST,  [126] = SOUTH, [127] = SOUTH,
>> +	[128] = SOUTH, [129] = SOUTH, [130] = SOUTH, [131] = SOUTH,
>> +	[132] = SOUTH, [133] = SOUTH, [134] = SOUTH, [135] = SOUTH,
>> +	[136] = SOUTH, [137] = SOUTH, [138] = SOUTH, [139] = SOUTH,
>> +	[140] = SOUTH, [141] = SOUTH, [142] = SOUTH, [143] = SOUTH,
>> +	[144] = SOUTH, [145] = SOUTH, [146] = SOUTH, [147] = SOUTH,
>> +	[148] = SOUTH, [149] = SOUTH, [150] = SOUTH, [151] = SOUTH,
>> +	[152] = SOUTH, [153] = SOUTH, [154] = SOUTH, [155] = WEST,
>> +	[156] = WEST,  [157] = WEST,  [158] = WEST,  [159] = WEST,
>> +	[160] = WEST,  [161] = WEST,  [162] = WEST,  [163] = WEST,
>> +	[164] = WEST,  [165] = WEST,  [166] = WEST,  [167] = WEST,
>> +	[168] = WEST,  [169] = NORTH, [170] = NORTH, [171] = NORTH,
>> +	[172] = NORTH, [173] = NORTH, [174] = NORTH,
>> +	// special pins
>> +	[175] = 0, [176] = 0, [177] = 0, [178] = 0,
> 
> We have better support for special pins now, you can remove these 0
> entries and set .special_pins_start = 175 in pin_data below.

You can look at the sm8250 patch at https://lore.kernel.org/all/20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-2-50623a7e4931@linaro.org/

> 
> Kind regards,
>> +};
>> +
>> +static const char *sm8150_get_function_name(struct udevice *dev,
>> +					    unsigned int selector)
>> +{
>> +	return msm_pinctrl_functions[selector].name;
>> +}
>> +
>> +static const char *sm8150_get_pin_name(struct udevice *dev,
>> +				       unsigned int selector)
>> +{
>> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>> +	return pin_name;
>> +}
>> +
>> +static unsigned int sm8150_get_function_mux(__maybe_unused unsigned int pin,
>> +					    unsigned int selector)
>> +{
>> +	return msm_pinctrl_functions[selector].val;
>> +}
>> +
>> +static struct msm_pinctrl_data sm8150_data = {
>> +	.pin_data = {
>> +		.pin_offsets = sm8150_pin_offsets,
>> +		.pin_count = ARRAY_SIZE(sm8150_pin_offsets),
>> +	},
>> +	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>> +	.get_function_name = sm8150_get_function_name,
>> +	.get_function_mux = sm8150_get_function_mux,
>> +	.get_pin_name = sm8150_get_pin_name,
>> +};
>> +
>> +static const struct udevice_id msm_pinctrl_ids[] = {
>> +	{ .compatible = "qcom,sm8150-pinctrl", .data = (ulong)&sm8150_data },
>> +	{ /* Sentinel */ }
>> +};
>> +
>> +U_BOOT_DRIVER(pinctrl_sm8150) = {
>> +	.name		= "pinctrl_sm8150",
>> +	.id		= UCLASS_NOP,
>> +	.of_match	= msm_pinctrl_ids,
>> +	.ops		= &msm_pinctrl_ops,
>> +	.bind		= msm_pinctrl_bind,
>> +};
> 

