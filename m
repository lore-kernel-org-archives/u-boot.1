Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BEDD6B6A8
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF058920C;
	Wed, 30 Oct 2024 17:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y48r0LCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CEAC89211; Wed, 30 Oct 2024 17:21:52 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89700891F5
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so38650f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730305310; x=1730910110; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iDEfYdk7u246tBJDkC+kMgOCFpv2AesgVlMdKN4PJ5g=;
 b=Y48r0LCJDiaXplp/yZwN0doz7BkXmz/L8LFTzonH1D9J5vN4qlvwWRZ3pubdhqtCyr
 7C0X9FPOF5E+alr48z/AZ6wQYPOO8FvfVs/4LUfh9pxOkThkYresr+I6SIBk6WTc4Oi7
 0jYiBezmia6jQsjHBlu6e5KQb8KZw8+FLQybhNBCOY/KALwSFPEC2Znsd2m3LfMDnOVL
 9+4oZSfQcYiJ8AsSS15IWZoOPLvH0EqeWrNlXlPqZpLyO5hClN9ruHHW5W6FbCH20WDK
 v701TtcLFqhXlFFQG6vuD5tbGUvkYEyGrCWWb2WEAok7q4gjbUUCsZwBqTplSs2Z2XAc
 VqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730305310; x=1730910110;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iDEfYdk7u246tBJDkC+kMgOCFpv2AesgVlMdKN4PJ5g=;
 b=QMNUkWJfvrzYj75Uw5vNRnqW5hW/CnHPimZveb5ukL0UiMudqBHwyGPTCBcRq4tu8y
 h8t5zfypgDIWBVUuE+564B5MofN7nQUjiCEWNF/ZNqz1bHy95y2Yu6/DWgkWjclzAYvW
 Uca1vGirbZk5+ZI9I3CMdfRhTtHmEJw5F1DoPAuTOKXHTCXwTsyaf3JwGHlPyN6IWNfL
 T38nFfDBP6VTUntm9oQZHk+SHPtfPK2DVAqBW3iyn4LldrfzWdEnsPOiqr9OJRZDGIQ7
 0cuGrqpoGXFPwN0nNqRxKABKOnRf3AmiY6URylVNzRk2vPDHKxpLsfHjDAWyfBzO9b2N
 1eBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxG5CVjXyPrAVxyPadSNqxpI7IlfzO2YOBXRiU50lbEI2yyZ1IoOV4G9g3/3EAbYv4e/CdwCA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp59gxLT6bUPRaM3Eh1VqznhxgSODdob2Q70+PM2owgtRjd5Uo
 JJD8C/seVSB1sbe+lp0BZvq7gXAssofD9k18/bYnHOgfZ+fD19064LzJUlKLIkE=
X-Google-Smtp-Source: AGHT+IGN6qkLc0QY8I8CKrxRpqAl7Rv4BXiWFsvDjD33zPFaNRungbp7FJqI7I4XFtuzQymmw4kabg==
X-Received: by 2002:adf:8b5c:0:b0:37d:5130:b380 with SMTP id
 ffacd0b85a97d-380611a1430mr14679218f8f.23.1730305309884; 
 Wed, 30 Oct 2024 09:21:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:201:dd6:9287:c715?
 ([2a01:e0a:982:cbb0:201:dd6:9287:c715])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b6f838sm15750327f8f.83.2024.10.30.09.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 09:21:49 -0700 (PDT)
Message-ID: <22981cb9-dcfd-4501-baac-7e7f1c212c4d@linaro.org>
Date: Wed, 30 Oct 2024 17:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] gpio: qcom_pmic: add again the quirk to skip GPIO
 configuration on PM8550
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
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
In-Reply-To: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
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

Hi Caleb,

On 16/10/2024 11:16, Neil Armstrong wrote:
> The qcom_pmic code is broken for new PMICs and should be fixed,
> without the QUIRK the code is broken and the GPIOs don't work
> anymore on SM8550 and SM8650 platforms.
> 
> Partially revert the revert and only add the quirk on the PM8550
> PMIC, making the buttons and MMC detect gpio work again.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index f2ef4e5ce14..cd9f3926ac4 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -69,6 +69,17 @@
>   #define REG_EN_CTL             0x46
>   #define REG_EN_CTL_ENABLE      (1 << 7)
>   
> +/**
> + * pmic_gpio_match_data - platform specific configuration
> + *
> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them.
> + * This is a workaround for an unknown bug on some platforms where trying to write the
> + * GPIO configuration registers causes the board to hang.
> + */
> +enum pmic_gpio_quirks {
> +	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> +};
> +
>   struct qcom_pmic_gpio_data {
>   	uint32_t pid; /* Peripheral ID on SPMI bus */
>   	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> @@ -117,8 +128,13 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
>   {
>   	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
>   	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
> +	ulong quirks = dev_get_driver_data(dev);
>   	int ret = 0;
>   
> +	/* Some PMICs don't like their GPIOs being configured */
> +	if (quirks & QCOM_PMIC_QUIRK_READONLY)
> +		return 0;
> +
>   	/* Disable the GPIO */
>   	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>   			      REG_EN_CTL_ENABLE, 0);
> @@ -262,6 +278,7 @@ static int qcom_gpio_bind(struct udevice *dev)
>   {

Gentle ping, without this PMICs gpio are unusable...

Neil
>   
>   	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> +	ulong quirks = dev_get_driver_data(dev);
>   	struct udevice *child;
>   	struct driver *drv;
>   	int ret;
> @@ -275,7 +292,7 @@ static int qcom_gpio_bind(struct udevice *dev)
>   	/* Bind the GPIO driver as a child of the PMIC. */
>   	ret = device_bind_with_driver_data(dev, drv,
>   					   dev->name,
> -					   0, dev_ofnode(dev), &child);
> +					   quirks, dev_ofnode(dev), &child);
>   	if (ret)
>   		return log_msg_ret("bind", ret);
>   
> @@ -348,7 +365,7 @@ static const struct udevice_id qcom_gpio_ids[] = {
>   	{ .compatible = "qcom,pms405-gpio" },
>   	{ .compatible = "qcom,pm6125-gpio" },
>   	{ .compatible = "qcom,pm8150-gpio" },
> -	{ .compatible = "qcom,pm8550-gpio" },
> +	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
>   	{ }
>   };
>   
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-qcom-pmic-re-add-quirk-75b24dd86849
> 
> Best regards,

