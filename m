Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F83B87895;
	Thu, 21 Dec 2023 17:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lzi7kOqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE8F387895; Thu, 21 Dec 2023 17:26:19 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9716387899
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33670b90013so597987f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175976; x=1703780776; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X8nR6c2Yz96SGxLeOx8WWKpFCQeFY0nrXZhKF707IP0=;
 b=lzi7kOqmW2/UGEHSoNYQYu+MyGV1CUw7VW1eazOUUzGMAUrleQlfoRAXkG4juBTMUZ
 +az7/243AJ9LsEzdOGnck5rebhLr+nbmSCseI63qPZVzQL3tWlbfT8v/37yQM44ciit5
 dRfLncs9OoBbzdsYpdldTuGlPQrqUp6LuUXkzoA0TCfwkSD7RuzbUPM0GhFQW4/9GsW2
 jlBTDyMmekBv0XaY4ICpAaf0X1YCCSrMerluwHVXsL9ygNiU3ffS/B1XAZpXBtdpAc4X
 MUazrNdUPTur1uDrcgumEaVOTvuvvv3d/2Zk7o0ySUDyoqV1mPu8MpTBwI9vySLD7/ij
 Cvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175976; x=1703780776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X8nR6c2Yz96SGxLeOx8WWKpFCQeFY0nrXZhKF707IP0=;
 b=HgkHBwVZKjX6BtMF6TtSgnOkfd7lOW11NxO5Hbp5/n10qxBgt5NR4ijST0EE7ng11m
 1hE1Bqy4JHqRu/k/PR2QPcQd37MhuFAwQckFJY7YahqEpi/zUD6dBV/2M5+CAid3Gns0
 SVdZACVWvZAHslfz3IvMPWFD9Kfmx0ned9wfAwOTIb0aKbBib1FYOKRtqaQn+oV2u8bQ
 fF/WEN3zKgVDsB9yOZrruZ8pIQdJBGmIHJv7NtxhgvmJBf+4lNVLyBJKuKNafxuxz79S
 6hkeuYTeqAzEgwJUvkVbxjW2eaQ8Ka6XfoHqIvY8RacNrRAZzHbZMG8zsf7TcX+ofx85
 rk0g==
X-Gm-Message-State: AOJu0Yx54myJrGeLp2fWCk1CHtGQodDOL3dxAnNdXaKkBPYK+L5siYUR
 Z22MYgy3uLM/lYwOwbZsipil4DOv52IpOA==
X-Google-Smtp-Source: AGHT+IHIYcgKwobc7v1cMQU0mpLC2cW47Oawj9NixVbzuEdyPGMyBVSPgetmDTx6mYMknjir0d3QAQ==
X-Received: by 2002:adf:9bcc:0:b0:336:5499:47dd with SMTP id
 e12-20020adf9bcc000000b00336549947ddmr603611wrc.6.1703175975993; 
 Thu, 21 Dec 2023 08:26:15 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a5d5047000000b003366af9d611sm2375065wrt.22.2023.12.21.08.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:26:15 -0800 (PST)
Message-ID: <e6aa079b-9c5e-42b1-896b-938a94d1c13a@linaro.org>
Date: Thu, 21 Dec 2023 16:26:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/32] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
Content-Language: en-US
To: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-9-b6dd9704219e@linaro.org>
 <26585839-068c-4816-959d-3759a9bd85d7@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <26585839-068c-4816-959d-3759a9bd85d7@linaro.org>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 21/12/2023 16:19, Neil Armstrong wrote:
> On 19/12/2023 17:04, Caleb Connolly wrote:
>> Some platforms hard reset when attempting to configure PMIC GPIOs. Add
>> support for quirks specified in match data with a single quirk to skip
>> this configuration. We rely on the GPIO already be configured correctly,
>> which is always the case for volume up (the only current user of these
>> GPIOs).
> 
> Do you know why this happens in u-boot and not in Linux ?

I don't, I did some preliminary debugging but couldn't root-cause this.
Writing to any of the GPIO registers seem to cause a crash. It could
potentially be a bug in the SPMI arb driver - I'm not sure if there are
any SPMI writes done on this platform by U-Boot
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/qcom_pmic_gpio.c
>> b/drivers/gpio/qcom_pmic_gpio.c
>> index 2a4fef8d28cb..198cd84bc31e 100644
>> --- a/drivers/gpio/qcom_pmic_gpio.c
>> +++ b/drivers/gpio/qcom_pmic_gpio.c
>> @@ -64,6 +64,15 @@
>>   #define REG_EN_CTL             0x46
>>   #define REG_EN_CTL_ENABLE      (1 << 7)
>>   +/**
>> + * pmic_gpio_match_data - platform specific configuration
>> + *
>> + * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt
>> to configure them
>> + */
>> +enum pmic_gpio_quirks {
>> +    QCOM_PMIC_QUIRK_READONLY = (1 << 0),
>> +};
>> +
>>   struct qcom_gpio_bank {
>>       uint32_t pid; /* Peripheral ID on SPMI bus */
>>       bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or
>> GPIO_MV(0x11) */
>> @@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice
>> *dev, unsigned offset,
>>       struct qcom_gpio_bank *priv = dev_get_priv(dev);
>>       uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
>>       uint32_t reg_ctl_val;
>> -    int ret;
>> +    ulong quirks = dev_get_driver_data(dev);
>> +    int ret = 0;
>> +
>> +    /* Some PMICs don't like their GPIOs being configured */
>> +    if (quirks & QCOM_PMIC_QUIRK_READONLY)
>> +        return 0;
>>         /* Disable the GPIO */
>>       ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>> @@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
>>   static const struct udevice_id qcom_gpio_ids[] = {
>>       { .compatible = "qcom,pm8916-gpio" },
>>       { .compatible = "qcom,pm8994-gpio" },    /* 22 GPIO's */
>> -    { .compatible = "qcom,pm8998-gpio" },
>> +    { .compatible = "qcom,pm8998-gpio", .data =
>> QCOM_PMIC_QUIRK_READONLY },
>>       { .compatible = "qcom,pms405-gpio" },
>>       { }
>>   };
>>
> 

-- 
// Caleb (they/them)
