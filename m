Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918ADC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E71D8006D;
	Wed,  4 Jun 2025 14:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hJLZ1lxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94537800D7; Wed,  4 Jun 2025 14:41:01 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5817680050
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 14:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso54794995e9.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749040859; x=1749645659; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flkaLQlXGI5ujTU/m16pag0dydAVw3FKHZiSEuYGTuE=;
 b=hJLZ1lxPkTaw8PZxEfcyqv7rPhiXh6eAjfgICdfnOjyjVLBNMTjTZmBRICm3obXFyJ
 sYoBdrC3zUBR9H2GAngUrgxd+iJtGqVPpmWRF4Sth2rcwssF4wwb3LksO55F5e9/Xufx
 rzeUxYYSmGCqPQ+nLs4xMeHLcbgZJWygYVN2Fxf5uGFN7s7hBEw7Z170jGy+TeOL/XhR
 4SgqqI04sXJxs0m+aAOvEpIVzTK0gBz7CeMc80ynaGzXZ83wazmP9cjv8cEmx4Dlu6do
 CVjyjPwAWScAeoHR9HV0ptG4+tlxUm0YypjuPlgfPcKdGuAvdZjYnrMG7/u958Js/i7A
 gMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040859; x=1749645659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flkaLQlXGI5ujTU/m16pag0dydAVw3FKHZiSEuYGTuE=;
 b=dDC9eO2Lzd/UhUCO4FghtlWIJy8wh8IGS4dGaMX8o0DitKg+vBLKjc2cVMN0Wl5wXm
 vwVEq0XMsvyY0GQygRfp0iEWygZzVOf/3MUysGnX3I5eP+H5AXBv95IrCjpX9u9hn7I2
 xRZ29Avm/TUB0zJA4weVcGigVh/NM5uv/N062DQBTOvf3z87C9oaQcFkwEEuiewQxEfE
 6MLjmHLURe60iRCf0jLvrHMYK7A8oowbkfMk5mRTo+rC6xYNIPN37x+2gUzME8i4CD9u
 0ix8QkOiFlCeTl6S02BVcu5BLByHR+hayj/NEQ0cq9ovU4O3kKJDtGwl28QW47ucktql
 Yiag==
X-Gm-Message-State: AOJu0Ywg6LqfuoJa0NJrSXvon2BcZKG/XbFZfVh8D5N8lVr+uhuuO/ia
 aQEmdlHGETgE5PjMNghB87MB4zVwwQ73i+62PaAhskT60jUIuJ6UF9Rj7HNeIys/4Z4=
X-Gm-Gg: ASbGncu8oU12tTEc40aX7zb1bOwuqGGmatCA5ZCRHmQ88X8xBTUVFBwcmWTJRooakrF
 WXyGj2hjQPke0P6WCc24wa/DOBkrJ+REMZepmP74gyUpbkkFreGO7TtlwaXPoGGEICSGtUbx5E3
 03seHhMOdbvC3KvDSEhyFHjcxTOqLz/gMwKShXfPCRItWLqtWz9IXR2/CCeX73D9zPOzNtOVXGi
 BYSdIH/zwU/TOZsoGOAtR3pRTRfNCD4wTiHyBGCsiVpMeBTpurqGXaZk1pnHFljgH4ntd4m89Av
 RL/ZAJYb008/Pux8q67joNT+a+hfM4Ifvs6Ng7Bc2b2cTd9MgXajbMaANZSA20KmiKGdumoC1Bm
 KS9PkR9ihi38B2XE8JTms+yCj+DvGvv1VYhxS
X-Google-Smtp-Source: AGHT+IHtMyk5m78yrthin3heTKSO85rhI9TlrGrurCZ0/dPbzKgY1EJD58USObKL1CQr4MyfImUXsg==
X-Received: by 2002:a05:600c:314d:b0:442:f4d4:546 with SMTP id
 5b1f17b1804b1-451f0a650fbmr23116535e9.1.1749040858755; 
 Wed, 04 Jun 2025 05:40:58 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:968c:2df3:c75e:5a31?
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb80f6sm195892175e9.28.2025.06.04.05.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 05:40:57 -0700 (PDT)
Message-ID: <724196e1-a409-4b03-8145-3dbb473e3949@linaro.org>
Date: Wed, 4 Jun 2025 14:40:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 0/2] gpio: qcom: rewritte SPMI gpio driver from
 Linux driver
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
 <cebc988b-de5b-45af-92ba-08ee7998aaef@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <cebc988b-de5b-45af-92ba-08ee7998aaef@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 6/3/25 18:43, Neil Armstrong wrote:
> On 01/04/2025 11:47, Neil Armstrong wrote:
>> The current SPMI gpio driver is very old and doesn't support
>> pin state tracking to fully support the whole pinconf calls.
>>
>> The simplest is to rewritte the driver using the v6.14 Linux
>> driver and fully implement pinctrl, pinmux, pinconf and gpio
>> support using all the newer interfaces.
>>
>> The goal is to deprecate the old one it has been validated
>> on currently supported hardware.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Neil Armstrong (2):
>>        gpio: qcom: add new driver for SPMI gpios
>>        gpio: qcom: move pm8550 gpio to new driver
>>
>>   drivers/gpio/Makefile         |    2 +-
>>   drivers/gpio/qcom_pmic_gpio.c |   20 +-
>>   drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   3 files changed, 1037 insertions(+), 20 deletions(-)
>> ---
>> base-commit: 5ca70325b64f760bf4190f206a0e88dda495e3d2
>> change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
>>
>> Best regards,
> 
> How should we go forward ?

Unless you have any concerns let's pull this into -next and see what 
happens. I'm preparing a PR atm>
> Neil

-- 
Casey (she/they)

