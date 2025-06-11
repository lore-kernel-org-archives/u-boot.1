Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB23C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 08:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874BD82A4B;
	Wed, 11 Jun 2025 10:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qopn944Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE03182B20; Wed, 11 Jun 2025 10:48:33 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7AE828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2455585f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749631711; x=1750236511; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cGdqT2MCjGshRWU+z5Z6/drCawsXoN1jc02smPX8x0g=;
 b=qopn944ZhGOMaP4GepR34biJjHh6/fKAa+fnT/jIrBnY34g32SJDdstSrpmOeqY+G7
 GgbA/RZasS/Yne0wEAeUXRV0mVvm24bHBaa5oXLYlAHyOCsy9VFojPU33AhT5wFFLHPo
 rt5KMixDOU+C3X8UEpjhPGm9itZsGOl3JUlTHXMJaTPp6z23/JLNZtkcLEat0T5Kwt7T
 XsQwLccCIO5ZrmVUM2MkXHgrYfdtAMX2w+jgBtb5IZYr8Sxpka81yuWIWYU8MG1orrDL
 1DXpKnzRCZP+aOa5/6CeaUM5OJfIg12GMUaOyDyVBLAaiXiq/jwizlcnLS2AbP0cwB0h
 yEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749631711; x=1750236511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGdqT2MCjGshRWU+z5Z6/drCawsXoN1jc02smPX8x0g=;
 b=D2GlM+3L8iMQV5HsL5QYBmZhlmODBnr7aO2OcZEE8ietPuyKfqBQ1wV+s5IOP9b6Oz
 jq9qlWo1uL71/LqNO9nzUUufvc8qDwVscwNKR/l/QNH9jMZGnieQbD19v5PM2zKTcRZh
 pleYOKfhvWlsiCAXKGoRpLnQNvcZqhpg/lBlQgfv5vtvLEbGypoqS/5ipXYw5cNznKqn
 ZPmpR3zwTwwQAlEQL1rDA+aFGJbAOHw8dns/TC7nsMoZ6+RxMbYnyOxlOkxQLWaF4BjL
 UEKd5vc1do11IpeW7UwcUM+7LaoLcNFI95Zd6mSD7OCV6YclkHJZ5LGBL13trkp/pevU
 GYBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVubn6CzuO8T0IcyJTy1kAJY3MnqnnZzdjEZjOV8j45Zy1vTWXccKNUQv8cQ4JLl0onX3A9oEI=@lists.denx.de
X-Gm-Message-State: AOJu0YxShAcBd43eggqE7O0fW+qRdMnAWmru+EYWkAyQLJtbkChjp8o3
 cxGslLSIzn/Xir6g++peoz/t+682RCjuBnUts1pgsKh73u3LUzY478C+JLpcQc0c97o=
X-Gm-Gg: ASbGncuWxR4ZI6nPuIRPTCGW+66HO5jL/7LAnL66juDrMppliXZMdYjj8CkAQ+aECe0
 PEIHYxj+PELldlfgH7vX2i0jT2mT7bCWOQOwJVdEm3uGP82aD/HhJKf+8VHhz/O6PMzXsEIwhsv
 ASqyB8LgnlV6ea1HYMc819WsSTGAn2ujLwm8T4W52RU5TUjeO7W4EmEQYVkkQvqdpFuGVWCIhKT
 sjJwH8RJsS9Bk56l9lFjR45vk4WqMDEdoFEaJAMb4/xYNXxW+vPanp9ZaYCztK9ixVwgtxARrUX
 2t4Xgs5adXeiwvH56r/Fklmj4C4RuP3n8yvbOMG3RSyO6h4YknWM7naIjpl8tHEuV/1+JYuiY+B
 WXZTQVr+RSZLoBMr7i0v8UlgzVv/Kivg/6EmOkQ==
X-Google-Smtp-Source: AGHT+IHluCsstKcwsAh7fxjPObCMrDwN0Worcjx46NQzxcX/g76xNr1tUnxz15bKUH0Z5aV+l+8MLQ==
X-Received: by 2002:a05:6000:1a8b:b0:3a4:f8e9:cee0 with SMTP id
 ffacd0b85a97d-3a5586dfe01mr1753742f8f.40.1749631710951; 
 Wed, 11 Jun 2025 01:48:30 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1a1e:c277:1c68:9459?
 ([2a01:170:117e:fc:1a1e:c277:1c68:9459])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532513e8bcsm14892365e9.3.2025.06.11.01.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 01:48:30 -0700 (PDT)
Message-ID: <72586883-c158-4726-a80e-6770b3fdf705@linaro.org>
Date: Wed, 11 Jun 2025 10:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] misc: introduce Qcom GENI wrapper
To: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
 <20250610-geni-load-fw-v2-2-7cad6bc18db0@linaro.org>
 <20250610225944.GG1382132@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250610225944.GG1382132@bill-the-cat>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 6/11/25 00:59, Tom Rini wrote:
> On Tue, Jun 10, 2025 at 06:50:51PM +0200, Casey Connolly wrote:
> 
>> Qualcomm peripherals like UART, SPI, I2C, etc are all exposed under a
>> common GENI Serial Engine wrapper device. Replace the stub driver we use
>> for this currently with a full-on misc device and implement support for
>> loading peripheral firmware.
>>
>> Each of the peripherals has it's own protocol-specific firmware, this is
>> stored on the internal storage of the device with a well-known partition
>> type GUID.
>>
>> To support this, GENI will bind peripherals in two stages. First the
>> ones that already have firmware loaded (such as the serial port) are
>> bound in the typical way. But devices that require firmware loading are
>> deferred until EVT_LAST_STAGE_INIT. At this point we can be sure that
>> the storage device is available, so we load the firmware and then bind
>> and probe the remaining children.
>>
>> Child devices are expected to determine if firmware loading is necessary
>> and call qcom_geni_load_firmware().
>>
>> Since Linux currently doesn't support loading firmware (and firmware may
>> not be available), we probe all GENI peripherals to ensure that they
>> always load firmware if necessary.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> [snip]
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 579c8acfcb466122c4fe66950ec7ca24c355b43a..5b83e3386be6ab7fa8d7f5306851d90a87fb75c3 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1124,8 +1124,9 @@ config ARCH_SNAPDRAGON
>>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select SYSRESET
>>   	select SYSRESET_PSCI
>>   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>> +	select QCOM_GENI
>>   	imply OF_UPSTREAM
>>   	imply CMD_DM
>>   	imply DM_USB_GADGET
>>   
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index ffc5868c0dd3e884fddb98b10f4b878d3f08b43a..78aaf003852aab96450963d93678787d30892f1b 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -82,8 +82,17 @@ config GATEWORKS_SC
>>   	  Enable access for the Gateworks System Controller used on Gateworks
>>   	  boards to provide a boot watchdog, power control, temperature monitor,
>>   	  voltage ADCs, and EEPROM.
>>   
>> +config QCOM_GENI
>> +	bool "Qualcomm Generic Interface (GENI) driver"
>> +	depends on MISC
> 
> So, this can get tricky. In ARCH_SNAPDRAGON you do not select MISC.
> QCOM_GENI correctly depends on MISC. Therefore there's a possible
> dependency problem that Kconfig might start complaining about. In fact,

Oh good point... on reflection i don't think it's correct to select 
QCOM_GENI for ARCH_SNAPDRAGON anyways since some of the older platforms 
don't use GENI anyway.

I'll rework this so that the GENI peripherals themselves (i2c, spi, 
uart) depend on QCOM_GENI instead, then all these will be added to the 
defconfigs.

Thanks,

> using qconfig to poke at what has which things set:
> dragonboard410c dragonboard820c hmibsc qcom_ipq9574_mmc
> should all have some warning? But IIRC, annoyingly, we couldn't
> figure out how to make those kind of Kconfig warnings fatal in CI.

That's annoying... What about having a script that verifies that all the 
=y options in the defconfig are also present in the .config? I guess 
that solves a slightly different problem but may be useful regardless...

Thanks,

> 
-- 
Casey (she/they)

