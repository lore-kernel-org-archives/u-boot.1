Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12852D42BA4
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 16:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4693489294;
	Tue, 12 Nov 2024 17:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jHFFbF4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10F38907D; Tue, 12 Nov 2024 17:22:24 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B79D89270
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 17:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so47704225e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731428542; x=1732033342; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wXKJtUe5OS7iT/Htv6a6uOej17/w2Rz+ypgsKkNbLw=;
 b=jHFFbF4b66fseGpyKbXcMv5BBxZ4rjoFqGQiml5lTe0qpCFYUsDeB8Ks3o4jxoTEDh
 x5xSkD2dzinRr8WdicKx+ioAkSVREj8T6b5WiJGccNxlL2Yv+M3q2sjdiIc3od252a1G
 ucYJHfZRcCvhjJrYx1odrZDI3AKL8ua6ghPLsc5cUMIY6hCI+VGChTKWWDVRrQWJeK5V
 b6aeHzareN5lAvEiGoLW6UVkDtWyjglApQjPq4jkrmwE2XnvaCdtJiUXIKsstc4+zNhj
 67elJYiYH9XN+IK3ThYdy7QrO2Y7dWIvVO5kZQiv2YtH84ErF5AwkoqBsCQfFJ9lDIZ2
 8R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731428542; x=1732033342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wXKJtUe5OS7iT/Htv6a6uOej17/w2Rz+ypgsKkNbLw=;
 b=V02+OtCfs6uWwNY+8u2ZqSXnxmogQwIYZCTqWlZsk8VH7qhDpiPAE3siPGg9bGwmVX
 jYm5DQ6dmqO2nlJ6O+LZX+CwwkndyJCzN+WJTO8Qk0GDwZXIqLQHfXhpeV0nLOfguZ/g
 jP8kmkIUKLCzgV52G757JHMew4pWq5d+9tCHqs2kjRXD1NytSEgd7DHS/fsVSmTQIZzw
 Ma3FvjgED8aLo58s5+Q3LpSzcHlKMOPTwDtfib6EayQx1ILnNWVhhzdMwFyGsaGZkG/p
 BLLvVo+AX/0pevGvJANRaW0oKMENV6bX054Nva7P6Njpy0ZxfuZhRcpPgSqYVRLAOoua
 4H9A==
X-Gm-Message-State: AOJu0Yx9xIH60TbrNSD79WGfgf8bnk1dcR9wPFZE8iJSgfemPNq87gOf
 Od5CRPpRMcMnp+buG6ASeA5NLPnUYYWtInYWM7Fm2b2IriuejVy7lqpiTr0G4L0=
X-Google-Smtp-Source: AGHT+IFaDrDkR/Q6I/A4NETWHonuNupB6+CyMN/0LMqXQd09813E3VEH9AM+jtHBjXI3UPTjyHuIIw==
X-Received: by 2002:a05:600c:3b19:b0:431:5a93:4e3c with SMTP id
 5b1f17b1804b1-432cce77fe7mr28729555e9.16.1731428512185; 
 Tue, 12 Nov 2024 08:21:52 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05c0d33sm218595655e9.27.2024.11.12.08.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 08:21:51 -0800 (PST)
Message-ID: <36aca447-85dc-4af3-a3dd-d4ec55c79908@linaro.org>
Date: Tue, 12 Nov 2024 18:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: at91: Implement GPIOF_FUNC in get_function()
To: Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241018202715.283011-1-admin@hifiphile.com>
 <2637a7bd-fdc6-4102-80c1-43d0d058cd97@linaro.org>
 <CA+Gyqebjmuiwn0UyUEJK0vh7wimTkGXPeVCrf7feYxzFLF_Oxw@mail.gmail.com>
 <fc0f7532-c260-4b6d-b8aa-5ce2ff2deb6f@linaro.org>
 <CA+Gyqebs11SSv2OGtAAg2tO9K_g9kz1uCJK+JG05+0gObgQQCw@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CA+Gyqebs11SSv2OGtAAg2tO9K_g9kz1uCJK+JG05+0gObgQQCw@mail.gmail.com>
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



On 11/12/24 18:17, Zixun LI wrote:
> On Tue, Nov 12, 2024 at 4:59 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>
>>
>>
>> On 11/12/24 17:57, Zixun LI wrote:
>>> Hello,
>>>
>>>
>>> On Tue, Nov 12, 2024 at 2:13 PM Eugen Hristev <eugen.hristev@linaro.org> wrote:
>>>>
>>>>
>>>>> +static bool at91_get_port_pio(struct at91_port *at91_port, int offset)
>>>>
>>>> The name get_port_pio is a bit confusing, can you rename it to something
>>>> more meaningful, like maybe is_periph_func or something ?
>>>
>>> How about at91_is_port_pio_active, more inline to the datasheet.
>>
>>
>> I am not sure. It appears confusing to me.
>> The pin is either in GPIO or peripheral function mode.
>> Being 'PIO active' appears to be something different, or common to both
>> options.
>> What does the datasheet say exactly ?
> 
> From SAM9G25 datasheet, 22.6.3 PIO Status Register
> 
> 0: PIO is inactive on the corresponding I/O line (peripheral is active).
> 1: PIO is active on the corresponding I/O line (peripheral is inactive).
> 
> "PIO" is the port controller itself but also means GPIO which is not very clear.
> 
> Or at91_is_port_gpio ?

That sounds better (and have the binary logic reversed)

IIRC on SAM datasheets and naming, 'pio' is a general term for a pin,
and this pin can either work as a GPIO or it can be tied to a specific
hardware block (hence the function)

