Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83378C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 08:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42EA886CC;
	Mon, 15 Jul 2024 10:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qIENx1oA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB23A88747; Mon, 15 Jul 2024 10:38:45 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE4F88655
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso4957702a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721032722; x=1721637522; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mImJoNeVTYMKMzECKyEjUXORyLfpP5koclG+CAVwVng=;
 b=qIENx1oAOy+RwQQAqHA7fgZU4ynRYZanOR62DJsRS62CCWxyBkpbtmJYSYyDbWwpFT
 I8l5oZD+EsziVv5A+cBW8DRCBfDkYysIxL78RPUboKAoMnWwNzlaw77/nz2sdeRTQN/p
 jJxLp5j1z4u2rnwMBAp0BpmRWlAjxAbNqfOqJTcvKIvvT2zvy5EnkDtFjrXX+yFA/Fex
 ZJpkXdkswACQZGydQm81aE9M5FOLqrDmnIZvJDlZh2OtRFPZlEa2AnRSbzD3ccwjMAqu
 q+4S21bfaOeitVgF+luWz1U0DsiwEyVRzXsvSvlgUIWoRrMJ8nvCqfr/3MfDj2R1ATiU
 oylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721032722; x=1721637522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mImJoNeVTYMKMzECKyEjUXORyLfpP5koclG+CAVwVng=;
 b=dDcSPVfxXKVsIuX47QfXEJpzHevud1/VhKTKB+ioVXQIt9JhNTrRuGk13gkIncwFHb
 OEeT+EgCvIuFztSUS+LF5+vusrcA0vhUhapGuqXgzQM+JbnNWN7HdcpMAv5NPy+DxjIG
 SQwFZq3zZ5EZcG9K7gA/URJOuUH+Dm/ILp1ZRURyXDqcVsa099l9X+dnbKYEtFnQJF/M
 OkMxmx3HeLKDtwh+0bNhj0bDuSuFHdVUjz0Bk83M0sq8GKIJu2CpXW/4NNPCdYRMQk66
 yMiZuhTMa5V5EhOEy12izJ/jUF+zwhbU38gkWOZvyQ2SoboazwyNTMMAlkJjZDN3050Z
 fF4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3TtTtqPG1hrQNQrAeaCZmZ/UbufhaHNOaxbpfGCEhSNZVb3jLSgowfoy6XJL+HhIJY8BvLk72d3IXzvTZcP1jG04NMg==
X-Gm-Message-State: AOJu0YyYsBPRLAFfCiFjvwfG9xC65iFf9o1Gi9u6kbbfIcrBUmQgjovV
 0prg95uhT7dJPyMQbxVBTrFWD8X/jgp87LvoO6/7oav+FcWB7yOMbSA4URW0hs7WCMSxtYK6PKM
 9Wfk=
X-Google-Smtp-Source: AGHT+IH2UWJbHGqt0KE5nu9Ocuuwu3JookblWvRsNlEvu1oMZNTON7UWc8ctsqrG+YxXdRjPTW++Wg==
X-Received: by 2002:a17:906:7086:b0:a77:eb34:3b46 with SMTP id
 a640c23a62f3a-a780b6b1a18mr1329424466b.19.1721032722230; 
 Mon, 15 Jul 2024 01:38:42 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc7f1e2bsm191505966b.110.2024.07.15.01.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 01:38:41 -0700 (PDT)
Message-ID: <4d222507-3e68-411e-ad8a-c355ed1b8b9c@linaro.org>
Date: Mon, 15 Jul 2024 10:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
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

Hi Quentin,

On 15/07/2024 10:16, Quentin Schulz wrote:
> Hi Caleb,
> 
> On 7/14/24 9:49 PM, Caleb Connolly wrote:
>> We don't have audio support in U-Boot, but we do have boot menus. Add an
>> option to re-map the volume and power buttons to up/down/enter so that
>> in situations where these are the only available buttons (such as on
>> mobile phones) it's still possible to navigate menus built in U-Boot or
>> an external EFI app like GRUB or systemd-boot.
>>
> 
> Are those event codes properly defined in the DT already?
> 
> e.g. 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts#L31
> 
> If so, what prevents us from simply patching the U-Boot DT to change 
> that code? No additional code required anywhere, no need to maintain a 
> list of mapping, etc...

Many platforms in U-Boot are now switching to upstream DT, and 
SystemReady compliance requires that the bootloader provide a DT to the 
kernel.

U-Boot doesn't really have a generic way to apply specific adjustments 
to FDT for U-Boot without them being carried over to the kernel.

Patching FDT is in and of itself somewhat treacherous without using 
OF_LIVE, which isn't set up until after bind(), making it unsuitable. 
It's also vastly slower to patch FDT than to patch a livetree.

I couldn't conceive of a way to do via patching DT that wouldn't require 
solving the above problems, I also couldn't think of another example 
that would justify making this patch more generic or configurable.

Kind regards,
> 
> If that isn't possible, .........
> 
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> Cc: u-boot-qcom@groups.io
>> ---
>>   drivers/button/Kconfig         | 11 +++++++++++
>>   drivers/button/button-uclass.c | 22 +++++++++++++++++++++-
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/button/Kconfig b/drivers/button/Kconfig
>> index 3918b05ae03e..6cae16fcc8bf 100644
>> --- a/drivers/button/Kconfig
>> +++ b/drivers/button/Kconfig
>> @@ -8,8 +8,19 @@ config BUTTON
>>         U-Boot provides a uclass API to implement this feature. Button 
>> drivers
>>         can provide access to board-specific buttons. Use of the 
>> device tree
>>         for configuration is encouraged.
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
>>   config BUTTON_ADC
>>       bool "Button adc"
>>       depends on BUTTON
>>       depends on ADC
>> diff --git a/drivers/button/button-uclass.c 
>> b/drivers/button/button-uclass.c
>> index cda243389df3..729983d58701 100644
>> --- a/drivers/button/button-uclass.c
>> +++ b/drivers/button/button-uclass.c
>> @@ -9,8 +9,9 @@
>>   #include <button.h>
>>   #include <dm.h>
>>   #include <dm/uclass-internal.h>
>> +#include <dt-bindings/input/linux-event-codes.h>
>>   int button_get_by_label(const char *label, struct udevice **devp)
>>   {
>>       struct udevice *dev;
>> @@ -36,16 +37,35 @@ enum button_state_t button_get_state(struct 
>> udevice *dev)
>>       return ops->get_state(dev);
>>   }
>> +static int button_remap_phone_keys(int code)
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
> 
> ....... I suggest to make this a weak function that can be overridden by 
> boards (should it maybe be only defined in boards C file?) so that it's 
> easy for people to come up with their own mapping without having to deal 
> with two people/the maintainer disagreeing with what should be the one 
> and true mapping for that key.
> 
> Cheers,
> Quentin

-- 
// Caleb (they/them)
