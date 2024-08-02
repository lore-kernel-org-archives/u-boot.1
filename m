Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0C3C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 15:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF00D886B5;
	Fri,  2 Aug 2024 17:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Unm43KX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9DA388BA4; Fri,  2 Aug 2024 17:28:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A48587CF8
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 17:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 99A893FE08
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1722612512;
 bh=g9Ce5j57IKwpI3Zt8ZRFPemJeQPs+yd/Ap1IleNGiPw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Unm43KX2V4qxq1l+RK10WHWwjj7Z0qDiQOR8bedhMauhBh7pV6XGobZJsJsJxWbu3
 SjGRPYz5E40DojVGJp+rrDJPbr97zGb0vMs3wj3fEKpnT2ehQCQgBGucZFSWWhCz81
 vr4/HF36/VZgkpkzJo+smWNJb/yZVp8ov3cWBd2K0C6VgqaYD1/ZQtDqgJ8zN20FZs
 8OLpYKJ2lfl1qUHu2yvuRtPlBLkeMU4jt3I6eoYDbIKGc6rkKBRu8qIXoY+cA09vxB
 ChNPXTY3VI0ByHdXX40BrsZ4xCz0fIQUpol1dzFs/uVg6W9TR5PJ3kEj+mqp5jot/c
 NjqJY/e7DOOFA==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a0fa34d1c9so8477727a12.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 08:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722612512; x=1723217312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9Ce5j57IKwpI3Zt8ZRFPemJeQPs+yd/Ap1IleNGiPw=;
 b=Yt4seNLaUJbj0PZs9PPPQ0yYwLrZV1HCmxzYyUfcNIfDUto9O4yl7e/SDR6ZArCyTp
 6ebaH9BXyfeVYswR7DDfjBRn2gKllUomlDL3aO3Y7eZULcyPar7qo4Glk+cFoGXwe6jV
 NJ1I7iCSXPUSQQeBqeCJ3Kq5tJKs8AkFsF/hF+nlNzGNieQwD2rJwa87yKBVUWd5ut9O
 p3mDieaHiT7N5oFZ87wyWaFpZ80/LZEF0LLdz1oceQIQ/1LG0vzN8v+/1swc+le1YuN9
 kDjnteiXa5nn5JQFVC5Jtn9pLG/7u9gpnvphqeZdFJPrcDunwqIOy8cieR2gjKMgyRUy
 CUlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvj/ml9LxzAh1hQG2zjZV4jh0do3n7Gp4bjHMvJ93upkII55OKryMTjaOBFwnnu2/tZ/1EwqTFIM12DrW07VJ5LdaHbQ==
X-Gm-Message-State: AOJu0YyShAb0SfOFBB5esEaBMKzDVStouu8758ajwxXWphinE289OqRA
 jSzRz/ozPxyIgFy/kecaks/224+OhReiUZAqFx16Er2xwpSooFiD4/qhLQ1wEJ+6L8A9rcrmu7C
 Q1D+bohEYLcF6Bqdy5PBTVfFemvl9PoKcMzu0lyXG9tq5F77eKXMCVF4Xh/uYbY+G6jTrv+RXnU
 8=
X-Received: by 2002:aa7:cf09:0:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5b7f5413badmr2850058a12.25.1722612512084; 
 Fri, 02 Aug 2024 08:28:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwrwRrVHXk6ZZAp7UOdNmoIvzh5Do7A8126u1RD6I0++rtTUPcj+eigAs9JJ620ezs3JQRSQ==
X-Received: by 2002:aa7:cf09:0:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5b7f5413badmr2850029a12.25.1722612511493; 
 Fri, 02 Aug 2024 08:28:31 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83b723e78sm1245865a12.59.2024.08.02.08.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 08:28:30 -0700 (PDT)
Message-ID: <27d5a36b-1485-4837-9427-c9cf44310837@canonical.com>
Date: Fri, 2 Aug 2024 17:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] doc: document the pwm command
To: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, trini@konsulko.com
References: <20240801100754.44732-1-emil.kronborg@protonmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240801100754.44732-1-emil.kronborg@protonmail.com>
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

On 01.08.24 12:07, Emil Kronborg wrote:
> Signed-off-by: Emil Kronborg <emil.kronborg@protonmail.com>
> ---
> Changes in v3:
> - The help text for 'pwm config' in the examples section is more
>    explicit about 20 us and 14 us for the period and duty cycle,
>    respectively.
> - Fixed 'pwm enable' and 'pwm disable' in the examples section to only
>    expect 2 arguments.
> - Rebased on top of master.
> 
>   doc/usage/cmd/pwm.rst | 80 +++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst   |  1 +
>   2 files changed, 81 insertions(+)
>   create mode 100644 doc/usage/cmd/pwm.rst
> 
> diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
> new file mode 100644
> index 000000000000..bd1255d82186
> --- /dev/null
> +++ b/doc/usage/cmd/pwm.rst
> @@ -0,0 +1,80 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +.. index::
> +   single: pwm (command)
> +
> +pwm command
> +===========
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    pwm invert <pwm_dev_num> <channel> <polarity> - invert polarity
> +    pwm config <pwm_dev_num> <channel> <period_ns> <duty_ns> - config PWM
> +    pwm enable <pwm_dev_num> <channel> - enable PWM output
> +    pwm disable <pwm_dev_num> <channel> - disable PWM output

Thank you for documenting the command.

To stay consistent with other pages, please, remove the descriptions 
here. They are available below.

> +
> +
> +Description
> +-----------
> +
> +The ``pwm`` command is used to access and configure PWM (Pulse Width Modulation)
> +signals. For all subcommands, the following arguments are common:
> +
> +pwm_dev_num
> +    device number
> +
> +channel
> +    channel on chosen device
> +
> +pwm invert
> +----------
> +
> +The signal's active and inactive states are swapped.

This would imply that all invocations irrespective of the polarity value 
swap the active and inactive state.

I guess we could say here:

The polarity of the signal is set.

If the value of `polarity` is 0, the default polarity is used.
If the value of `polarity` is 1, the polarity is inverted.

> +
> +pwm config
> +----------
> +
> +Configure the period and duty cycle in nanoseconds.

According to https://en.wikipedia.org/wiki/Duty_cycle "duty cycle" is 
the ratio of "pulse active time" and "total period". This implies that 
it is dimensionless.

%s/duty cycle/pulse width/ or "duty period" as in pwm.h.

> +
> +pwm enable
> +----------
> +
> +Enable output on the configured device and channel.

What happens if the device-channel combination is not configured yet?

> +
> +pwm disable
> +-----------
> +
> +Disable output on the configured device and channel.



Please, describe the parameters here:

pwm_dev_num
    Device number of the pulse width modulation device

channel
    Output channel of the PWM device

polarity
    * 0 - use normal polarity
    * 1 - use inverted polarity

duty_ns
    pulse width in ns

period_ns
    cycle time in ns


> +
> +Examples
> +--------
> +
> +Configure device 0 channel 0 to 20 us period and 14 us (that is, 70%) duty cycle::

Please, add comma, use 'µs', and don't misuse 'duty cycle':

"Configure device 0, channel 0 to 20 µs period time and 14 µs (that is, 
70%) pulse width::"

Best regards

Heinrich

> +
> +    => pwm config 0 0 20000 14000
> +
> +Enable output on the configured device and channel::
> +
> +    => pwm enable 0 0
> +
> +Disable output on the configured device and channel::
> +
> +    => pwm disable 0 0
> +
> +Invert the signal on the configured device and channel::
> +
> +    => pwm invert 0 0 1
> +
> +Configuration
> +-------------
> +
> +The ``pwm`` command is only available if CONFIG_CMD_PWM=y.
> +
> +Return value
> +------------
> +
> +If the command succeeds, the return value ``$?`` is set to 0. If an error occurs, the
> +return value ``$?`` is set to 1.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 49b354e6ffd2..1adab5283950 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -92,6 +92,7 @@ Shell commands
>      cmd/pinmux
>      cmd/printenv
>      cmd/pstore
> +   cmd/pwm
>      cmd/qfw
>      cmd/read
>      cmd/reset
> 
> base-commit: 7010f22eba35b2a6b66ba37ce565e566ca08c68f

