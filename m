Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BBAC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 07:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEAC782C87;
	Mon,  7 Apr 2025 09:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WloqoaXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC7C82C87; Mon,  7 Apr 2025 09:34:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B0582C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 09:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so3692107f8f.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744011251; x=1744616051; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=87lS53SLmBjO7cHn5uk87Je/8uScceyp5320tpIVZtQ=;
 b=WloqoaXFJBOVgNMaJZPN0lwOE0jL+aM2vMUGfHGuw8ZSvGYpIrBjnZHFWz46YnQjuR
 fp1mCQCk7P0hV2kfXghZT0XEWw9zH2c9w2KUYq6ZJgxhO/cBV9oXvcHcWIA5j6ptKOEL
 4pNdovht3vTP6s5XN4JW17sa7/ws/2O870gn6fhlOJH5UeMHSUXvfT3sHNWBnB8hhSfD
 Cp87C9zVgUMra9/v5akxFIH/4eA5VozFwv4MZQZ+nN4i+u5+oTndGLxuQkcrvJfne43u
 hB/mvh25HsnZGjDNE+Z+/Ypq3/Kd2OxlPZXkQufZHMB3STUZNGv1jWSWIR6LyfWsNOwS
 2wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744011251; x=1744616051;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=87lS53SLmBjO7cHn5uk87Je/8uScceyp5320tpIVZtQ=;
 b=JBOVcHPyqOtm+t4E71ThTnnyPnY0aIOHsQ75Snm5PjOTBK74NUluinAWGraDlZ0wwg
 12znU4/fIG1KnGO9NE5I7Xn3QEU4zhaKQ7Jgb0K1l6WJzRIyE3mMC0R4tqtBQmxmysW8
 nGIG6RxfrQ3L1QYTQO1Df6RmdBfL58GrZbbMCsa13WtGuj2jICEOhsGnwCcbEFnxPJSl
 WQEY6DKWBMJ4ifOJANkCTlWlvlGbEzcjvJX8GXgXc9hZD3Ub3b8DElti2H77Pk9dW9SD
 aeB6/MtrogMo+MJIOWxspZUf+ad0JabHuoCMw+r9bSZ6f6txq7Gug3OsOqOcCcphJWNR
 Tw5A==
X-Gm-Message-State: AOJu0YwLGc9JhsU2gnqxL4VtfK4bHFlLWWkZUO+DYytE9dX3cFBmw3NJ
 n1telBDNLpos0AmQaYBZdapw8riH8n+hlc0ZZczIk6zvk4ek3sEBKa3bi9wpUp6Jy+1qF1lZdHP
 V
X-Gm-Gg: ASbGnctM6XgGQmdDOGFb7fZKSixOZ4qfrn1P0C4X1F2ZOm6MA9/EpbcjFdb0MLcSjwP
 mA6EWeHYZvhNEF5au1d/odqBvyNREZPPc0cl+ODuEwhnPqHeE9tReaFK7nAki9adzaW38ShPhHv
 s+X8fY9juNMxKlf3iAYhqK7GTY1hsEvcoMOUaszDVt1J1iqCHs6szImv8RcuKNr2TTLrmyRrV0S
 yvjiIMlap7YGOu3DfWboilH80FL6+a/rwz6Kcjm+KXrVERVTqkGo9Z98mhCURHOWkNVAqDsw7aZ
 vsUf1ybsVXb8vD4y6x+taKJlj9c3qtAZoTmbt3sNMzojia+eiKXGB4FnvZo7rt6FgN+DoeEEyIm
 T4Ikq/uoJ0W80sKanG2DcuQ==
X-Google-Smtp-Source: AGHT+IHeUkb4Q6OlG2JLOASdo5h0nE5PtG6+apUE+z5zhsnFdETMdhErgRiU9aahiVegJXJaBaC6bA==
X-Received: by 2002:a5d:584b:0:b0:391:4231:414 with SMTP id
 ffacd0b85a97d-39d6fd18f22mr5875872f8f.40.1744011251102; 
 Mon, 07 Apr 2025 00:34:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b0d06sm125745665e9.35.2025.04.07.00.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:34:10 -0700 (PDT)
Message-ID: <87a3dbba-e43b-40b9-af58-cd77747ac412@linaro.org>
Date: Mon, 7 Apr 2025 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC/RFT 1/2] gpio: qcom: add new driver for SPMI gpios
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
 <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-1-74077ef0b464@linaro.org>
 <4429b568-1200-4a6f-a41f-ad6c7905eec5@postmarketos.org>
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
In-Reply-To: <4429b568-1200-4a6f-a41f-ad6c7905eec5@postmarketos.org>
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

On 05/04/2025 17:56, Alexey Minnekhanov wrote:
> On 4/1/25 12:47, Neil Armstrong via groups.io wrote:
>> The current qcom_pmic_gpio driver is too limited and doesn't
>> support state tracking for all pins like the Linux driver.
>>
>> Adding full pinconf support would require adding the state
>> and it's much simpler to restart from scratch with a new
>> driver based on the Linux one adapted to the U-Boot GPIO
>> and Pinctrl APIs.
>>
>> For now only the PMICs I've been able to validate are
>> added in the compatible list but we should be able to
>> add the entire list from the Linux driver.
>>
>> There's a few difference from the Linux driver:
>> - no IRQ support
>> - uses the U-Boot GPIO flags that maps very well
>> - uses the gpio-ranges to get the pins count
>> - no debugfs but prints the pin state via pinmux callback
>>
>> It uses the same CONFIG entry as the old one, since
>> the ultimate goal is to migrate entirely on this new
>> driver once we verify it doesn't break the older
>> platforms.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpio/Makefile         |    2 +-
>>   drivers/gpio/qcom_spmi_gpio.c | 1034 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 1035 insertions(+), 1 deletion(-)
>>
> 
> ...
> 
>> +
>> +static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>> +    { .compatible = "qcom,pm8550b-gpio" },
>> +    { .compatible = "qcom,pm8550ve-gpio" },
>> +    { .compatible = "qcom,pm8550vs-gpio" },
>> +    { .compatible = "qcom,pmk8550-gpio" },
>> +    { .compatible = "qcom,pmr735d-gpio" },
>> +    { }
>> +};
>> +
> 
> I've added 2 compatibles here to the top of that list
> 
> +       { .compatible = "qcom,pm660-gpio" },
> +       { .compatible = "qcom,pm660l-gpio" },
> 
> and was able to confirm with "dm tree" that new driver is in use and it works fine (Volume Up key works and I'm able to navigate U-Boot menu).
> 
> Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

Thanks for testing !

Neil

> 
> ---
> Regards,
> Alexey Minnekhanov

