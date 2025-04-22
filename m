Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1F8C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CC780F6B;
	Tue, 22 Apr 2025 17:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FkxrQV5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E096680F9C; Tue, 22 Apr 2025 17:37:54 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78403803CC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac25520a289so702189966b.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745336272; x=1745941072; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3TbV7fALkiDaFrGtFdOas+mvNc6yq1omUGId+NNbuM=;
 b=FkxrQV5zKFdFuJZuYAzM5kzirVgPsGS8oY25hP7jRH214jzsOdOPSxZiKtSltnwnbf
 U8P8s2l4mOstIbvb/qzpjtPM8XJiI1wcLp2CDzaoBDf2qVQUgnGJcPAQSsvXVFJM7JqC
 x6SlUSKdSz4B25KTbKC1zMBot+N4+6ufM6LiugRlxb9SCovxuDGlae90N8ghZJntI3dU
 MjU78577NnDaMbEeXBdl3gWE7l9CoWzcdzXBatDSuShzLA25DXiWxI1R+POqMGJFWMYz
 YyJuX7R9JFkycyFfdFPYwGIJWyEyAsLxAizWnSmc0lz2A8U4R4JwdDUudBzYjPTLmlT8
 YYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745336272; x=1745941072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3TbV7fALkiDaFrGtFdOas+mvNc6yq1omUGId+NNbuM=;
 b=LmyyZ6kRDxdefuWmO8f9+/e6uRO4OlHke/fxQCQnwhOq7JbaMz84V56brv9Qcq4box
 q2lx3VxiU27YtaMecsLSiDfF25i5f4G6dDdTA2tFZqAp8MYgu92jMFAPhssxo/jtu40D
 ht3lC3g/5/gU0PLJaVDV6/AUwT/QAYjFQXyOdMnWmjuhZ6ZfwmW7F2IuPfINkS3Qukvr
 C66pYr5zsVEtwQlQXXpwrE36PhMt76FJFuOee/0CFTT+M+VBWNOpj4FGE6G+AMmYzfVm
 PFTWqu4Ekc+7AGpg3BBk68DPRqrZUmr6dk6+grenc0QYaKpPIvQLMzUfOyD7f/1erzlO
 8ORg==
X-Gm-Message-State: AOJu0Yyyk+BazYlEop7wB71tv+J0U0xFWZP6qrwm0XLZjFYTkH/sYqSm
 At2zpLWWQwgDG+GCp0F/8G8i2H53miF/AChf2i0ywhZAJiLJ25e1y49jwA==
X-Gm-Gg: ASbGnctWMogzQo6qv2fBZAOmqmrc+C6XswwMhlTN5ZC9MaTERoFeVVkFyAiqt7n741h
 KGpVswEwUrfbyZ9SCTwBDgYvI6qlXGhzcF30ADh66+zWvT8RsfoUIre+ZStnLR0bar6szVuf7B5
 mVeqEnQ/OG3inWzr1pSee9J0nlYym1Ro6ZIh5RgbMuzkuTtK3wK0oOT9coirzAzvP+qLXNR1S/p
 5n9UZYxPXsE2HtL12/UFhF6DcfCxbcKFRsBLC0c1nzOrtcvaLeBA6bC729LRFPi9YEiMGWc0Zyy
 RQxzMaaxo252wm3saoIssIw8afAh6UAqW65Qy7QUmW6UoUS77xSHRSKRxAkToE3wROxBaZEZDJg
 swGP/y4VchR8Ypg==
X-Google-Smtp-Source: AGHT+IEooIsQBZIOvhnUOABInNZb95aBJOz2s9PsUd/4mihtivDdd16+8ArRg0IkacKqvn+KTB45Xg==
X-Received: by 2002:a17:907:86a8:b0:ace:3a1b:d3d with SMTP id
 a640c23a62f3a-ace3a1b1372mr62238266b.2.1745336271631; 
 Tue, 22 Apr 2025 08:37:51 -0700 (PDT)
Received: from [192.168.0.15] (89-64-21-19.dynamic.chello.pl. [89.64.21.19])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec04668sm671048266b.24.2025.04.22.08.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:37:51 -0700 (PDT)
Message-ID: <e57d99da-5524-48a5-b672-39b05dc730a2@gmail.com>
Date: Tue, 22 Apr 2025 17:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tegra: allow to expose UART on microSD slot
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Tom Warren <twarren@nvidia.com>
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
 <20250330212638.v2.3.I45a1ec3470905b1a7313ef907a83999f1163bb3b@changeid>
 <CAPVz0n0fRLgc7aOCpjVVRaX=dPMB9D9UDyNck8gsCJTpfh1pBg@mail.gmail.com>
 <0709393f-51f7-43e9-91b0-18ef5a7c0866@gmail.com>
 <CAPVz0n0umNySqe2QoRKknpktV-iRLF=xg4+vASaQApzMKqhY3w@mail.gmail.com>
Content-Language: pl
From: Artur Kowalski <arturkow2000@gmail.com>
In-Reply-To: <CAPVz0n0umNySqe2QoRKknpktV-iRLF=xg4+vASaQApzMKqhY3w@mail.gmail.com>
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

W dniu 01.04.2025 o 15:48, Svyatoslav Ryhel pisze:

> вт, 1 квіт. 2025 р. о 16:34 Artur Kowalski <arturkow2000@gmail.com> пише:
>>
>> W dniu 31.03.2025 o 07:51, Svyatoslav Ryhel pisze:
>>> нд, 30 бер. 2025 р. о 22:27 Artur Kowalski <arturkow2000@gmail.com> пише:
>>>> Tegra20 has mux allowing to repurpose microSD as UART on boards which
>>>> use sdmmc3 controller for microSD. Add TEGRA_UARTA_MICROSD to enable
>>>> this feature. It is currently supported on Transformer T20, support for
>>>> other boards may require Device Tree changes.
>>>>
>>>> Update Transformer T20 DTS to select correct pinmux and stdout-path
>>>> based on TEGRA_UARTA_MICROSD.
>>>>
>>>> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - added TEGRA_UARTA_MICROSD Kconfig option
>>>> - removed .dtsi for enabling UART over microSD
>>>> - modified transformer DT to use UARTA and correct pinmux when
>>>>     TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
>>>>     switch to enable/disable UART over microSD
>>>>
>>>>    arch/arm/dts/tegra20-asus-transformer.dtsi | 24 ++++++++++++++++++++++
>>>>    arch/arm/mach-tegra/tegra20/Kconfig        | 15 ++++++++++++++
>>>>    2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
>>>> index 49efabbfd92..9ea323c81f3 100644
>>>> --- a/arch/arm/dts/tegra20-asus-transformer.dtsi
>>>> +++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
>>>> @@ -5,7 +5,13 @@
>>>>
>>>>    / {
>>>>           chosen {
>>>> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
>>>> +               stdout-path = &uarta;
>>>> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>>>>                   stdout-path = &uartd;
>>>> +#else
>>>> +#error Unsupported UART
>>>> +#endif
>>>>           };
>>>>
>>>>           aliases {
>>>> @@ -195,10 +201,17 @@
>>>>                                   nvidia,function = "i2c1";
>>>>                           };
>>>>
>>>> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_SDB_SDD)
>>>> +                       dbguart {
>>>> +                               nvidia,pins = "sdb", "sdd";
>>>> +                               nvidia,function = "uarta";
>>>> +                       };
>>>> +#else
>>>>                           sdb {
>>>>                                   nvidia,pins = "sdb", "sdc", "sdd", "slxc", "slxk";
>>>>                                   nvidia,function = "sdio3";
>>>>                           };
>>>> +#endif
>>>>
>>>>                           sdio1 {
>>>>                                   nvidia,pins = "sdio1";
>>>> @@ -376,7 +389,13 @@
>>>>                   };
>>>>           };
>>>>
>>>> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
>>>> +       uarta: serial@70006000 {
>>>> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>>>>           uartd: serial@70006300 {
>>>> +#else
>>>> +#error Unsupported UART
>>>> +#endif
>>>>                   status = "okay";
>>>>                   clock-frequency = <216000000>;
>>>>           };
>>>> @@ -434,7 +453,12 @@
>>>>           };
>>>>
>>>>           sdmmc3: sdhci@c8000400 {
>>>> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_MICROSD)
>>>> +               /* Can't use both at the same time */
>>>> +               status = "disabled";
>>>> +#else
>>>>                   status = "okay";
>>>> +#endif
>>>>                   bus-width = <4>;
>>>>
>>>>                   cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
>>>> diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
>>>> index 3349f1e2786..c2c51660216 100644
>>>> --- a/arch/arm/mach-tegra/tegra20/Kconfig
>>>> +++ b/arch/arm/mach-tegra/tegra20/Kconfig
>>>> @@ -77,6 +77,21 @@ endchoice
>>>>    config SYS_SOC
>>>>           default "tegra20"
>>>>
>>>> +config TEGRA_UARTA_MICROSD
>>>> +       bool "UARTA on MicroSD breakout board"
>>>> +       default n
>>>> +       depends on TEGRA_ENABLE_UARTA && TARGET_TRANSFORMER_T20
>>>> +       select TEGRA_UARTA_SDB_SDD
>>>> +       help
>>>> +         Repurpose the SD card slot for getting access to the UARTA serial
>>>> +         console. Primarily useful only for low level u-boot debugging on
>>>> +         tablets, where normal UARTD is difficult to access and requires
>>>> +         device disassembly and/or soldering. Enabling this option causes
>>>> +         UARTA TX to become exposed on SDD and RX on SDB pins which correspond
>>>> +         to microSD CLK and CMD pins respectively. Currently this is supported
>>>> +         only on Transformer T20, support for other platforms may require DT
>>>> +         and configs (from include/configs/*) updates.
>>>> +
>>>>    source "board/nvidia/harmony/Kconfig"
>>>>    source "board/avionic-design/medcom-wide/Kconfig"
>>>>    source "board/compal/paz00/Kconfig"
>>>> --
>>>> 2.48.1
>>>>
>>> This is not applicable since this is a hack by nature, BUT if you
>>> contain this in the transformer t20 board and Kconfig (no dts
>>> changes), this may be applied.
>> Ok, then I'll drop DTS changes. I will add few words about this option
>> in Transformer documentation
>> and a note in Kconfig help to not surprise users with not booting U-Boot
>> as enabling this option without
>> changing DTS causes U-Boot to hang.
> You should remove then Kconfig option as well. Add a new chapter to
> Transformer T20 documentation which describes this method, here[1] you
> may find a similar approach but info is in the commit message of
> tegra30 uart-e funcmux. Additionally, as I have said previously, these
> changes can be contained in the transformer t20 board file by using
> some device tree manipulations from there.

Currently I'm working on few other things both in U-Boot in OS, some of 
patches probably I will send to upstream
in the coming weeks, but eventually, I will come back to this.

> ---
> 1 https://source.denx.de/u-boot/u-boot/-/commit/b515d7ae0de51a26f73b2ddb5ea4db0d95b67d7a
