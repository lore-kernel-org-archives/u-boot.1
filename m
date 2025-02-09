Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCDBC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B12480821;
	Sun,  9 Feb 2025 17:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VRAUyo6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B01EE80A2A; Sun,  9 Feb 2025 17:10:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC1A807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A75443F220
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739117432;
 bh=nPwCPSfJLh4Xcoh7UVkXG0josyP5ZhZFhj4uA0ztuxg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VRAUyo6T7ZKTWZN9d5wE5ZRAFmMdKuP9WC1IEKGUlgaKmd3v41vgwphw9UnPRw5fV
 tSR80TLALEZN3qt6FxW0wYqKem0BIHuDAvOF91mVOgRZi8/Zx02AREvphlRutHbq78
 ylx4E//a2LY+PvnXwiDT1T7IX6g2EIG9FePHbshw2PUDJg/x5sYXr+US6unQpRPEwh
 3K+obWfF7182ZV9rrLF6kp5ICkuRYOKsONx0aJFmusnC75Wmm5b4dSH27vDhdhi8rp
 EhmjLhU8jt8frqLsz0RGxNULXybnV0HoXhPBDSmh2r5LBDcblxjHXP98HKTWC+kRqv
 obUi8EXcwxWRA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e180821aso21292275e9.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117432; x=1739722232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPwCPSfJLh4Xcoh7UVkXG0josyP5ZhZFhj4uA0ztuxg=;
 b=DSPx3Vku7b1eZorTU7u2r6FcFUHXrbN0RgHB8Ezket2Ce1kLZZ27Rl24vSt8jlV6e9
 QleJ9peeefg/HA5Ns1eMAtcztRuGUuNBw/joI8Ray6NL7ij1w0llNbohodkPHoywqD20
 Xl72rWo74rqnDG6z7zQStDYUrJCdk1Wpqk54v1br+AvT5gEHvFCbUXq4l9GR720miKPz
 ET/CFuCp8B1jqIbiSSaho81CT8E86ailo0jxiw1DIpXVVvk20tr73oBK1M6PBZj7delp
 8VkctXhmt0Z1UubNXZbMnvkDqwD1aayf4BQ8koNXBUZzT47gD3eefidsZHPW/yJeZ4Ab
 yMwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt3z1igh2Av26Okxom4Lf0jhp1uI1OvsADntJ7NxwdgineuuCMiNElwEzlOsU1gprHMJe2AtI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3+2oweKk0/ftDNagT3be1BoGYn9D2KZ6tLdlYR5HfAeEONGsF
 Eg5ybAgw/8Nua2W4XojLlvZRET1Js2h7GW9dG90VarZpqHVxVvZH9qiN4ODVI7ZDEPp/sLbyHnl
 vH66nQsi1OkjI/VkEPMVhz4Li+fNP9BTXCRcs99aJ2epY3+IZY0c0hXRB3ucxxwscC6M=
X-Gm-Gg: ASbGnctoSbqGIlevWp6zkFAyT93yNDf73Pih7LUGY2T36IME6Ms28lhtYh05YHMsgqy
 Bm7Sg51dY5JkY756vYE7JfMfG99+d150mgXs9GGHlJu9mPS6O/pW6eeyAd8T75i8bMObXXR5Hd0
 N4ms874K8fk9QydUmKjnQqJYceVyFFIpTZUspaJF9TMjihU7TC501K2rvyY2fPyrM6VxBSFPgsU
 i7hyrocYLyTboLGMaAKBR9vxoq9RHbIgpZM4SoB6v+e0THE9eT5OXjb4y5gqb6/ih+JI4pmr90j
 Z4t1CFJK5WanKu7GiIGE7HQYcCgiKKtOuLnABZ9EtVnE0YdFBLr9k7oRCmb748+0Zs2kXRrW8+P
 Nbg==
X-Received: by 2002:a05:600c:4f47:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-43924990cb5mr83120175e9.13.1739117432243; 
 Sun, 09 Feb 2025 08:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE2zenNydSEif24iQX69rfe3TA2mbPrrVOxvg24XShRgfLPMryM29kTUrTlu+kiJ5uEIT79w==
X-Received: by 2002:a05:600c:4f47:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-43924990cb5mr83120085e9.13.1739117431932; 
 Sun, 09 Feb 2025 08:10:31 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ff10sm117594395e9.12.2025.02.09.08.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 08:10:31 -0800 (PST)
Message-ID: <55245b3e-22b0-464e-8ec5-4e3a95b88de1@canonical.com>
Date: Sun, 9 Feb 2025 17:10:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
 <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
 <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
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

On 09.02.25 17:02, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 9 Feb 2025 at 08:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 09.02.25 15:29, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> If a single configuration node lacks a description, this does not rule out
>>>> that another node with a description matches. Anyway we have the default
>>>> configuration as a fallback.
>>>>
>>>> So continue if a description is missing.
>>>>
>>>
>>> That field is mandatory, so we should really fail if it is missing.
>>>
>>> What problem are you trying to solve here?
>>
>> Sure the field is needed to make a configuration selectable.
> 
> It's actually normally informational. Have you looked a

If the field is informational, we should not worry if it is missing.

> CONFIG_FIT_BEST_MATCH? That is how this is supposed to be done. But
> with starfive_visionfive2 I see:
> 
> # CONFIG_FIT_BEST_MATCH is not set

How would CONFIG_FIT_BEST_MATCH match strings in the EEPROM to a FIT 
configuration?

> 
>>
>> But as long as we can find a good configuration we should boot instead
>> of leaving the user with a bricked device.
> 
> The more likely impact is that people won't bother adding the field on RISC-V.

The current runtime check is inconsistent: You will get an error if the 
first config lacks a description but may not get an error if the last 
one lacks it. And you are potentially bricking bootable devices.

The right place to check is mkimage. Here you can bail out if a string 
is missing without bricking devices.

Best regards

Heinrich
