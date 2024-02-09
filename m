Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF8C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 16:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F1A287E71;
	Fri,  9 Feb 2024 17:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qcLYHLlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE41287E70; Fri,  9 Feb 2024 17:06:18 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AED87E7C
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 17:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41047386d18so9670865e9.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707494774; x=1708099574; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=etStm2571dMq4xrpjyH5JaZC0Z0nez3KgLwIFv/GlXk=;
 b=qcLYHLlZeV2AZKAk7jCkfAUNU+eavdQMGqffBCD03b7BexuNvDeOEvpvy44Bxj3oHS
 cK1d2qYQ0gmyZFZIW4P8ccGCM5zK3pVMvCaiOfZZvvhw8eYNsOtJkjse/d+ZAwoRE7sw
 Fx+o0HJeXW7ZA+Qiqrl6C/EUpi3ZDu52rHF1JvyFaB1BHJMp7lkjRlSKMkD8IkdCbXVV
 zGHZnxxBjLcJzBF2+usrgkyAf/XwDrNCUqUxB+v1W14daGi4CVjMeyHtaKHbU2aQKLn5
 sFl9c4FYsEJyTJcdwsOyyTYuSYvew3n6ZbgTLI1eujLIGtyqaMNHFXlHWl9T8KVcglg+
 MF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707494774; x=1708099574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etStm2571dMq4xrpjyH5JaZC0Z0nez3KgLwIFv/GlXk=;
 b=VZGAqHoMCqdv0UQIz254xCrNAFLWS2mM9vhr7tVKLspMIfazYrG1T7sJBvByOwTiCi
 5RsNoLvwn01mvY9LktSPTUJYcUv0083tzyovvJ8hqxwLR+lwDbsdOLKgadWeu+c8f3J2
 468uqqpZkoJV5S6GlK5hKgaEw8JXjiCqn1crlGHfx27TrcbDAs+fgj7Rck5eRTLYD0kj
 1rCdD5yDm0sU5ZQYcpjgKDz/5lY6qbLs+OrBgnl0ykx0RCxIzBvurUpg0V61JO7aQQuU
 yomtOYRF7XE/XDqY8FtZ9wgWGujkGnXfP3X3O10QV1UgbEOyG2gMqvBxNDkhFbp3Dic9
 Jl6g==
X-Gm-Message-State: AOJu0YwGgJSipsrSBwnew8sRrRqSgxNZqYkrzXmjFbd7J/kLWZlehm3v
 Sg4LRrPKt9VCrO0XwV1atZgqbuRnAt+r0DGwgeDvyepsE+soR43AfNPHY5ipoCM=
X-Google-Smtp-Source: AGHT+IGeCindjhe7h9h4rwYNJVgMpzLHz/aWAX43T3g5vcwKxPdPIczUDjXC6D5uYDTJju84fQZImw==
X-Received: by 2002:a05:600c:3544:b0:40f:d2ff:85b1 with SMTP id
 i4-20020a05600c354400b0040fd2ff85b1mr1493709wmq.25.1707494773041; 
 Fri, 09 Feb 2024 08:06:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV0/shsWO7oD7gl2tHORXeFVrrULdRNW732260oCptU9R+japbnt3SaL0sUWsfw6BhR5otnOVpVBM1qPXmzvCyOucjdjelumYsQQykTPtxhsl9MoHasw5bLkbsHVr6togHi1NcYBIeg/20BD92irhFRSgRJD5kFK9AyHXoXnFHJ9dXSQ00D6VDJvgiBP8xXL6p/U2Bez9OWg1gv6/dLAJREGn0VZep1MKEjjwOLAzHwhsl9aC53mwiaABorJuBJ6aRs8qWbSZCdw6Huj61m0pQhedamj2r+S1v0Qge848+6d8FNzIAhSWsFk67FIrx4CqCzUh1MVRO8aiSE6tccpO8Y/9VTFL0FZJU5FilbZIEzUomRzqMywnr6h5+yM/1/YrEA
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bk27-20020a0560001d9b00b0033b55661f32sm2225858wrb.9.2024.02.09.08.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 08:06:12 -0800 (PST)
Message-ID: <2239b1c6-9abe-4479-b79e-88dd191c60e6@linaro.org>
Date: Fri, 9 Feb 2024 16:06:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/36] dts: msm8916: replace with upstream DTS
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-27-e523cbf9e556@linaro.org>
 <CAFA6WYMOndY_UeLAqTAq2oZnBotESfVbRwG7MrweNwu40HtR7g@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYMOndY_UeLAqTAq2oZnBotESfVbRwG7MrweNwu40HtR7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 02/02/2024 08:38, Sumit Garg wrote:
> On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Drop the U-Boot specific dragonboard410c.dts in favour of the upstream
>> msm8916-sbc.dts. No additional changes are needed to this DTS for U-Boot
>> support.
>>
>> Taken from kernel tag v6.7
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/dts/Makefile                   |    2 +-
>>  arch/arm/dts/apq8016-sbc-u-boot.dtsi    |   11 +
>>  arch/arm/dts/apq8016-sbc.dts            |  729 +++++++++
>>  arch/arm/dts/dragonboard410c-uboot.dtsi |   44 -
>>  arch/arm/dts/dragonboard410c.dts        |  221 ---
>>  arch/arm/dts/msm8916.dtsi               | 2702 +++++++++++++++++++++++++++++++
>>  configs/dragonboard410c_defconfig       |    2 +-
>>  7 files changed, 3444 insertions(+), 267 deletions(-)
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 92a4465f5f41..4c8b29b983a4 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -628,7 +628,7 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
>>
>>  dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
>>
>> -dtb-$(CONFIG_ARCH_SNAPDRAGON) += dragonboard410c.dtb \
>> +dtb-$(CONFIG_ARCH_SNAPDRAGON) += apq8016-sbc.dtb \
>>         dragonboard820c.dtb \
>>         sdm845-db845c.dtb \
>>         sdm845-samsung-starqltechn.dtb \
>> diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..838e629a8ade
>> --- /dev/null
>> +++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2024, Linaro Ltd.
>> + */
>> +
>> +/ {
>> +       /* When running as a first-stage bootloader this isn't filled in automatically */
>> +       memory@80000000 {
>> +               reg = <0 0x80000000 0 0x3da00000>;
>> +       };
>> +};
> 
> With U-Boot booting as the first stage bootloader, we have to enable
> the serial driver prior to relocation. Although we have
> DM_FLAG_PRE_RELOC for clock and the serial driver, what about the
> pinctrl driver required to configure UART specific pins prior to
> relocation? Without following change we get broken U-Boot log without
> header prints:

Ohhh nice! This makes a whole lot of sense. Thanks for figuring this out.

I finally got my hands on some db410c's (thanks Neil!) and can confirm
this fixes the issue. I tried using DM_FLAG_PRE_RELOC on the pinctrl
driver but it doesn't seem like that's enough to get pinctrl going. I'll
pick your patch below.
> 
> diff --git a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> index 838e629a8ade..0a21732be6cb 100644
> --- a/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> +++ b/arch/arm/dts/apq8016-sbc-u-boot.dtsi
> @@ -9,3 +9,11 @@
>                 reg = <0 0x80000000 0 0x3da00000>;
>         };
>  };
> +
> +&tlmm {
> +       bootph-all;
> +
> +       blsp-uart2-default-state {
> +               bootph-all;
> +       };
> +};
> 
> Fixes broken U-Boot log:
> 
> S - Flash Throughput, 82000 KB/s  (1503304 Bytes,  18330 us)
> S - DDR Frequency, 400 MHz
> Core:  135 devices, 20 uclasses, devicetree: board
> MMC:   mmc@7824900: 0, mmc@7864900: 1
> Loading Environment from MMC... OK
> In:    serial@78b0000
> Out:   serial@78b0000
> Err:   serial@78b0000
> ## Error: Can't overwrite "serial#"
> ## Error inserting "serial#" variable, errno=1
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0
> dragonboard410c =>
> 
> -Sumit

-- 
// Caleb (they/them)
