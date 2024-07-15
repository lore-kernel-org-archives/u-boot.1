Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA31CC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 06:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0262487C68;
	Mon, 15 Jul 2024 08:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PKpQfthf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A43787D14; Mon, 15 Jul 2024 08:24:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5627B87919
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 08:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a797c62565aso408424666b.2
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721024656; x=1721629456; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E1WiaTbg9Pu0NpqogQGxirqyAzc0UW2uzgorhKkLk6k=;
 b=PKpQfthf30Y+9LXs7udS8yhzulKiyY+7VHTUaB4wRl2+guvThRpqY6/qJzHi/bQMo3
 sGZAnyeZDcOpeKtZGs/1kCmNWNxrxHVJC96bjEYU92hthqtlVnD64XGwli2l4kccojUx
 oIOR7WOm6LCDNp/P/RARspv+dR08mPIZyy9BDloIJoxV/0kXnyJM42lOedZhIjgnI95X
 1ivFTFPMFWnb8YY2pjekbYhaSIebxzdUy+sy+FFuZjKuftppabxN7Pxga7cMeS1GH/fr
 QPHDXBn4VsPDksHXhuW7b9cFc8oXXvfUe1fCPgsjOzPM62GW664ZT6iMFWKcxJzQIFwM
 s1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721024656; x=1721629456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E1WiaTbg9Pu0NpqogQGxirqyAzc0UW2uzgorhKkLk6k=;
 b=Qrv4kcQcdk8tN93KVyQ6Ygxe3h3K+w+14yol29KmTgUXvzFp3+5ou/yCXChSpuy5jT
 U8IeY/g2/e79FjsMf4AK00AwV+HBEBtQgC4pg8CBtGG+8DLBco6/0Hd64YmiDVDOya5y
 R+hTz1M+ul1oYfk2UUXqZPI8acuuvHtLUSyZ//KOdJNPvPbRW+ff3AQkJGuS495i5odp
 eQ5qvTenud6NzYtwz8gEfnlkpXprbNXZ0F5e6clUB0CoriwFzbUY8QG17QCgADqv53Uz
 rX2hT+/CFXIxqXPm/ohjLfbMME7vK3QQiPAJ9YqlKKX0iM9ekE86exzpmgx2X3/+xtfk
 ptEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzhVSTZXSx32iaw1M5yaDVlhW4dh6N9D8nRovw1veEEGfIKkvn3przNOSWP1F9+3o1xr8IpkaLnEfNCPl0CihY4HMZOQ==
X-Gm-Message-State: AOJu0Yy1nbvU8ZRyVuNJ7VQ+fUhRClz8sY/rxYrSZRutQGsPYNlWNG1U
 XnqY/DzJOhAMmkaUVjzellYSo2AcW8kEqH9LKdh+7cana8/GyVnW7VZbimS/3gA=
X-Google-Smtp-Source: AGHT+IG5ab1//qXxDqAQKSVax5hzadj0IdfmqIL1j+jk5C5qsmRDI9n4UhzsdFRQ0g5Ja9SCJHAWqA==
X-Received: by 2002:a17:907:e90:b0:a6e:d339:c095 with SMTP id
 a640c23a62f3a-a780b884b3amr1371319766b.47.1721024655564; 
 Sun, 14 Jul 2024 23:24:15 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7e79sm182407066b.88.2024.07.14.23.24.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:24:15 -0700 (PDT)
Message-ID: <948a0d04-a0a2-4c36-8c8d-5f3ad70dfdeb@linaro.org>
Date: Mon, 15 Jul 2024 08:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Dragan Simic <dsimic@manjaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <c8e6a53d96a89e54585bfe28a647f44f@manjaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <c8e6a53d96a89e54585bfe28a647f44f@manjaro.org>
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

Hi Dragan,

On 14/07/2024 22:47, Dragan Simic wrote:
> Hello Caleb,
> 
> On 2024-07-14 21:49, Caleb Connolly wrote:
>> We don't have audio support in U-Boot, but we do have boot menus. Add an
>> option to re-map the volume and power buttons to up/down/enter so that
>> in situations where these are the only available buttons (such as on
>> mobile phones) it's still possible to navigate menus built in U-Boot or
>> an external EFI app like GRUB or systemd-boot.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Cc: u-boot-qcom@groups.io
> 
> Very nice, thanks for this patch!  Looking good to me, with a few
> suggestions available below.  Anyway, please feel free to add:
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> 
>> ---
>>  drivers/button/Kconfig         | 11 +++++++++++
>>  drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>>  2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>> index 3918b05ae03e..6cae16fcc8bf 100644
>> --- a/drivers/button/Kconfig
>> +++ b/drivers/button/Kconfig
>> @@ -8,8 +8,19 @@ config BUTTON
>>        U-Boot provides a uclass API to implement this feature. Button 
>> drivers
>>        can provide access to board-specific buttons. Use of the device 
>> tree
>>        for configuration is encouraged.
>>
>> +config BUTTON_REMAP_PHONE_KEYS
>> +    bool "Remap phone keys for navigation"
>> +    depends on BUTTON
>> +    help
>> +      Enable remapping of phone keys to navigation keys. This is 
>> useful for
>> +      devices with phone keys that are not used in U-Boot. The phone 
>> keys
>> +      are remapped to the following navigation keys:
>> +      - Volume up: Up
>> +      - Volume down: Down
>> +      - Power: Enter
>> +
> 
> Frankly, "phone keys" sounds a bit strange to me, maybe because there
> are also tablets that have the same style of reduced-set keys.  Thus,
> I'd suggest that the following language is used:
> 
> - "BUTTON_REMAP_PHONE_KEYS" instead of "BUTTON_REMAP_REDUCED_KEYS"
> - "reduced smartphone-style keys" instead of "phone keys"

I would have assumed that anyone working on a tablet would immediately 
guess what this option does and that it might be useful given the name. 
I would argue that seeing "BUTTON_REMAP_REDUCED_KEYS" instead makes it 
harder to guess what this option does.

I think of it not as "this option remaps the keys on your phone" but as 
"this option remaps the keys that phones have", as in, the volume and 
power buttons.

If you'd prefer, maybe we can meet somewhere in the middle with "mobile"?

how's BUTTON_REMAP_MOBILE_KEYS?
> 
> Using "reduced" would also allow us to have this remapping logic more
> easily extended to also cover some other buttons found on some other
> devices with reduced-set keys.

If such a device exists and gains support in U-Boot, the switch/case 
could be extended, or a new option added if it doesn't make sense to 
lump everything together. Without knowing about such a device I think 
it's impossible to make a judgement here.

> 
>>  config BUTTON_ADC
>>      bool "Button adc"
>>      depends on BUTTON
>>      depends on ADC
>> diff --git a/drivers/button/button-uclass.c 
>> b/drivers/button/button-uclass.c
>> index cda243389df3..729983d58701 100644
>> --- a/drivers/button/button-uclass.c
>> +++ b/drivers/button/button-uclass.c
>> @@ -9,8 +9,9 @@
>>
>>  #include <button.h>
>>  #include <dm.h>
>>  #include <dm/uclass-internal.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>>
>>  int button_get_by_label(const char *label, struct udevice **devp)
>>  {
>>      struct udevice *dev;
>> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct 
>> udevice *dev)
>>
>>      return ops->get_state(dev);
>>  }
>>
>> +static int button_remap_phone_keys(int code)
> 
> Pretty much the same suggestion as above applies here.
> 
>> +{
>> +    switch (code) {
>> +    case KEY_VOLUMEUP:
>> +        return KEY_UP;
>> +    case KEY_VOLUMEDOWN:
>> +        return KEY_DOWN;
>> +    case KEY_POWER:
>> +        return KEY_ENTER;
>> +    default:
>> +        return code;
>> +    }
>> +}
>> +
>>  int button_get_code(struct udevice *dev)
>>  {
>>      struct button_ops *ops = button_get_ops(dev);
>> +    int code;
>>
>>      if (!ops->get_code)
>>          return -ENOSYS;
>>
>> -    return ops->get_code(dev);
>> +    code = ops->get_code(dev);
>> +    if (CONFIG_IS_ENABLED(BUTTON_REMAP_PHONE_KEYS))
>> +        return button_remap_phone_keys(code);
>> +    else
>> +        return code;
>>  }
>>
>>  UCLASS_DRIVER(button) = {
>>      .id        = UCLASS_BUTTON,

-- 
// Caleb (they/them)
