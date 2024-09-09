Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08268ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 12:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5847288DE2;
	Mon,  9 Sep 2024 14:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ep/kpN6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52CE88DEC; Mon,  9 Sep 2024 14:52:12 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5F288DE2
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 14:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so351930966b.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725886329; x=1726491129; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TIkBAw+D5x0moptfyZPUSXH1fb37FR2+F3CuKd74Asg=;
 b=Ep/kpN6yzRIJW+TIiZb3SaH/vktiy3S09qROnwUqZNZKSPnOUDj32TxGyxwyJ1upc4
 xM4Jd5UmnCOKyQ607HZe0n3vhoP9Ru2AYJPcFC60opQc0kzQ8l5Lsk/NCGdcKewjs6dl
 eajtD1gbYNnX+mavMQ/pCrkidBIZ4EMsKBYSLOjFy6o1GUxucQAl6QTelBgu7UfYcV8N
 qwN/YnNAlAsujl/M0aACZJCMgV0Js/OIRcm3UqPaDYcZHIWavSmtkDb+xXiSfzORElvr
 ttdiol9TGeh4zXXs4WTfZiyaTHVpQBh76kgKvcJxfT93VfZST10Jp6AnKY3QOIuRa/dv
 GeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725886329; x=1726491129;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TIkBAw+D5x0moptfyZPUSXH1fb37FR2+F3CuKd74Asg=;
 b=QRPJOHko5eF6mHjHZ/iEI7czodPaC8OyxkQfLJFg94zwRMS7xG7HOnVoSmh86WCvtS
 aaDT1KD97YgYPAeIXE2xArfyc+PdCST0G1zDx/Xn01wFaTDXJgrWCWvEoxjISMvCrUvl
 BuXrIKqyvz2lCXg9G5hPZl3IxYeGnbLlRDKbBqKWF0ToZPTwxeeNe+DxmskUMWuRmlVG
 H1VRjK64QtMnHnGjczqk0WYwTQ3l0ADqfn/Ktp3JVkto7nfYpSyEf/RANwLpJ+VYRris
 B4mb0dBAWO8N4zg9M3xbzs959JJ/0YmFuR8yi9UMbJGPbhwpVD4kQ+G0qDPBuN0n2IA3
 yDCw==
X-Gm-Message-State: AOJu0YxBaIpHKP79JBJbC9JGf78hh+DVoNo7b3eMKg2QyM/WPaWlT38/
 UEjpeqbrRLm/Z7/55oh/FdAbv/Tnsed5okAhjPCtHqoWJRIYSQp6rVPgxCTglqI=
X-Google-Smtp-Source: AGHT+IEipvnh5U4KmCQaCe8gf9RGx5BdnOLnaNlWy8P7G5memsGIECp/pv/jKuQo6DHpjcdOSk2dFQ==
X-Received: by 2002:a17:906:da82:b0:a86:8d9d:898a with SMTP id
 a640c23a62f3a-a8a888ec67emr1263495066b.58.1725886328385; 
 Mon, 09 Sep 2024 05:52:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850?
 ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cf6040sm336303066b.169.2024.09.09.05.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 05:52:07 -0700 (PDT)
Message-ID: <9019434c-8227-4b83-a2b5-5574d052c784@linaro.org>
Date: Mon, 9 Sep 2024 14:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] Revert "gpio: qcom_pmic: add a quirk to skip GPIO
 configuration"
To: Caleb Connolly <caleb.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240909120641.1396544-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240909120641.1396544-1-caleb.connolly@linaro.org>
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

On 09/09/2024 14:06, Caleb Connolly wrote:
> This reverts commit 19f000b72b2fa7e4540f7cdb91287aff594239bd.
> 
> The bug in writing was caused by a long-standing error in the SPMI
> driver which has since been fixed - c2de620d64d4 ("spmi: msm: fix
> version 5 support"). We can safely enable writing GPIO configuration
> now.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Tested on SDM845/pm8998 (OnePlus 6)
> ---
>   drivers/gpio/qcom_pmic_gpio.c | 27 +++++----------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 80fee841ee3f..f2ef4e5ce144 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -68,19 +68,8 @@
>   
>   #define REG_EN_CTL             0x46
>   #define REG_EN_CTL_ENABLE      (1 << 7)
>   
> -/**
> - * pmic_gpio_match_data - platform specific configuration
> - *
> - * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them.
> - * This is a workaround for an unknown bug on some platforms where trying to write the
> - * GPIO configuration registers causes the board to hang.
> - */
> -enum pmic_gpio_quirks {
> -	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
> -};
> -
>   struct qcom_pmic_gpio_data {
>   	uint32_t pid; /* Peripheral ID on SPMI bus */
>   	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
>   	u32 pin_count;
> @@ -127,15 +116,10 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
>   				   bool input, int value)
>   {
>   	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
>   	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
> -	ulong quirks = dev_get_driver_data(dev);
>   	int ret = 0;
>   
> -	/* Some PMICs don't like their GPIOs being configured */
> -	if (quirks & QCOM_PMIC_QUIRK_READONLY)
> -		return 0;
> -
>   	/* Disable the GPIO */
>   	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>   			      REG_EN_CTL_ENABLE, 0);
>   	if (ret < 0)
> @@ -277,9 +261,8 @@ static const struct dm_gpio_ops qcom_gpio_ops = {
>   static int qcom_gpio_bind(struct udevice *dev)
>   {
>   
>   	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
> -	ulong quirks = dev_get_driver_data(dev);
>   	struct udevice *child;
>   	struct driver *drv;
>   	int ret;
>   
> @@ -291,9 +274,9 @@ static int qcom_gpio_bind(struct udevice *dev)
>   
>   	/* Bind the GPIO driver as a child of the PMIC. */
>   	ret = device_bind_with_driver_data(dev, drv,
>   					   dev->name,
> -					   quirks, dev_ofnode(dev), &child);
> +					   0, dev_ofnode(dev), &child);
>   	if (ret)
>   		return log_msg_ret("bind", ret);
>   
>   	dev_set_plat(child, plat);
> @@ -360,13 +343,13 @@ static int qcom_gpio_probe(struct udevice *dev)
>   
>   static const struct udevice_id qcom_gpio_ids[] = {
>   	{ .compatible = "qcom,pm8916-gpio" },
>   	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
> -	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
> +	{ .compatible = "qcom,pm8998-gpio" },
>   	{ .compatible = "qcom,pms405-gpio" },
> -	{ .compatible = "qcom,pm6125-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
> -	{ .compatible = "qcom,pm8150-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
> -	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
> +	{ .compatible = "qcom,pm6125-gpio" },
> +	{ .compatible = "qcom,pm8150-gpio" },
> +	{ .compatible = "qcom,pm8550-gpio" },
>   	{ }
>   };
>   
>   U_BOOT_DRIVER(qcom_pmic_gpio) = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
