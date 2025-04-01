Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F318C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A82F82155;
	Tue,  1 Apr 2025 15:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YtubifMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 416F28215A; Tue,  1 Apr 2025 15:34:49 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024DB8210F
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso882506466b.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514486; x=1744119286; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZTeuU5RhCWT49O3vlF6Z6vPtENRM7nUOjQbrS0DUd0=;
 b=YtubifMCznPs3xu12iY+zD3vNLYmr9r49+6Sc51Fia+s40lyolL3C0LATM0kWK/P7s
 pvErOc6BLSJBcxal7TLl/W9hGBEfgDpKgc8HIg7z7li8n5DpeWtOS5A5yG6i9uI3G8e4
 MEidL/NMr7C1OjNQjTjfTPr/8RCrRMMbNl6LrqCy4BXYcx4WaPsvsM4+2VA6zBuQ7sty
 B7NnbQLJUb5OHggoTCXQj8OfrcVS7YEvAHirMXbmMS+A/RGDMu4H6pwvA+knY8WQscQq
 J+/22n7t6pjdWjjaiAO2iEzUpFHot2HP/sjmdLkRHDIn4pPr1DDGEUmRTZc5z4JXKRGp
 B9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514486; x=1744119286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZTeuU5RhCWT49O3vlF6Z6vPtENRM7nUOjQbrS0DUd0=;
 b=jv2jI8yxbdiCuiiQDnvPrAsRSC91pQdbJKf/M313jhpf7z4FCGV8ywaCppCCDfv0II
 CXuniLU28a6HVcGBWeDJ28NjrBKO1x67ro3ieET1XiG7sHSNdHuzJCd9GlhHAZc9u50t
 1oF7qix19GcqD77aa3DJmt7g0yxzIB0EUe4imt8FvZUFvDeSYQ/tD5yNVUzn2qKef88E
 zvb/GLqtTVFitrKUreTceH2iVVSlb572am/OBd0lK/DpHLIiHzWUHD+rT4bPhMShUHrQ
 BAVJw8+Ll4qhWXDATd5b8T6PF6E/TITAxX1+5q5R3XWyrNA74iOC1P6Q879wMfJ7O1JV
 MoOg==
X-Gm-Message-State: AOJu0YxZqUnRCOn7TpF8wF/7+FimFBBrC9233i6aKYAr910WFZq4GcMF
 s89bv7FrLRiEFWP1m4LvKMwLngxlqYKNrCBjH/WoMNym7j+gxLyG
X-Gm-Gg: ASbGnct/ORpBdXPGRSQ7RpPI7NBR7Jy/6JW/0Ry4Fd/Ap/yNlzRVwEYEgs65/5S/WNU
 2+xMesseE1CeFsRe+gtAZmKcaQqa8gTVb9eMgow6CjO/8pEJF3S+3DZzHq+lwIolCyyPfs1iq0S
 XetawKbquPfaurupe5O+vt/D4GivR7FPOvC8XzdsgQita2x33bJDgfsda2VhEPo7H2SZBTqLOTy
 Woj4AhBTPHykcr2VS9dInzTqJORJffmpgBScd8++vkAOZiTInEUrgn4rKgr5taMA1S+uduWlhlh
 TiCOtlRMToT0JsVWPCtiVKUyZ2IIPbyjcrfQPNSIUgr0lCS5kZExjiAYydAbU5qw1LyUuXQw3qY
 ZN7x6+nhE4irzlTopRXgf
X-Google-Smtp-Source: AGHT+IGVB2d0sJ2BaJk226fbGiUcz6xqFF6Y3Z7Mok6mddGmC16r8RygRmQwQrZP8jCS+zADuPLvCA==
X-Received: by 2002:a17:907:7e81:b0:ac2:dfcf:3e09 with SMTP id
 a640c23a62f3a-ac738be3908mr1053170066b.43.1743514486130; 
 Tue, 01 Apr 2025 06:34:46 -0700 (PDT)
Received: from [192.168.0.15] (89-64-20-160.dynamic.chello.pl. [89.64.20.160])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b184sm789518366b.51.2025.04.01.06.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 06:34:45 -0700 (PDT)
Message-ID: <0709393f-51f7-43e9-91b0-18ef5a7c0866@gmail.com>
Date: Tue, 1 Apr 2025 15:34:46 +0200
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
Content-Language: pl
From: Artur Kowalski <arturkow2000@gmail.com>
In-Reply-To: <CAPVz0n0fRLgc7aOCpjVVRaX=dPMB9D9UDyNck8gsCJTpfh1pBg@mail.gmail.com>
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


W dniu 31.03.2025 o 07:51, Svyatoslav Ryhel pisze:
> нд, 30 бер. 2025 р. о 22:27 Artur Kowalski <arturkow2000@gmail.com> пише:
>> Tegra20 has mux allowing to repurpose microSD as UART on boards which
>> use sdmmc3 controller for microSD. Add TEGRA_UARTA_MICROSD to enable
>> this feature. It is currently supported on Transformer T20, support for
>> other boards may require Device Tree changes.
>>
>> Update Transformer T20 DTS to select correct pinmux and stdout-path
>> based on TEGRA_UARTA_MICROSD.
>>
>> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
>> ---
>>
>> Changes in v2:
>> - added TEGRA_UARTA_MICROSD Kconfig option
>> - removed .dtsi for enabling UART over microSD
>> - modified transformer DT to use UARTA and correct pinmux when
>>    TEGRA_UARTA_MICROSD is enabled; it is enough to flip a single
>>    switch to enable/disable UART over microSD
>>
>>   arch/arm/dts/tegra20-asus-transformer.dtsi | 24 ++++++++++++++++++++++
>>   arch/arm/mach-tegra/tegra20/Kconfig        | 15 ++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/arch/arm/dts/tegra20-asus-transformer.dtsi b/arch/arm/dts/tegra20-asus-transformer.dtsi
>> index 49efabbfd92..9ea323c81f3 100644
>> --- a/arch/arm/dts/tegra20-asus-transformer.dtsi
>> +++ b/arch/arm/dts/tegra20-asus-transformer.dtsi
>> @@ -5,7 +5,13 @@
>>
>>   / {
>>          chosen {
>> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
>> +               stdout-path = &uarta;
>> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>>                  stdout-path = &uartd;
>> +#else
>> +#error Unsupported UART
>> +#endif
>>          };
>>
>>          aliases {
>> @@ -195,10 +201,17 @@
>>                                  nvidia,function = "i2c1";
>>                          };
>>
>> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_SDB_SDD)
>> +                       dbguart {
>> +                               nvidia,pins = "sdb", "sdd";
>> +                               nvidia,function = "uarta";
>> +                       };
>> +#else
>>                          sdb {
>>                                  nvidia,pins = "sdb", "sdc", "sdd", "slxc", "slxk";
>>                                  nvidia,function = "sdio3";
>>                          };
>> +#endif
>>
>>                          sdio1 {
>>                                  nvidia,pins = "sdio1";
>> @@ -376,7 +389,13 @@
>>                  };
>>          };
>>
>> +#if CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTA)
>> +       uarta: serial@70006000 {
>> +#elif CONFIG_IS_ENABLED(TEGRA_ENABLE_UARTD)
>>          uartd: serial@70006300 {
>> +#else
>> +#error Unsupported UART
>> +#endif
>>                  status = "okay";
>>                  clock-frequency = <216000000>;
>>          };
>> @@ -434,7 +453,12 @@
>>          };
>>
>>          sdmmc3: sdhci@c8000400 {
>> +#if CONFIG_IS_ENABLED(TEGRA_UARTA_MICROSD)
>> +               /* Can't use both at the same time */
>> +               status = "disabled";
>> +#else
>>                  status = "okay";
>> +#endif
>>                  bus-width = <4>;
>>
>>                  cd-gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
>> diff --git a/arch/arm/mach-tegra/tegra20/Kconfig b/arch/arm/mach-tegra/tegra20/Kconfig
>> index 3349f1e2786..c2c51660216 100644
>> --- a/arch/arm/mach-tegra/tegra20/Kconfig
>> +++ b/arch/arm/mach-tegra/tegra20/Kconfig
>> @@ -77,6 +77,21 @@ endchoice
>>   config SYS_SOC
>>          default "tegra20"
>>
>> +config TEGRA_UARTA_MICROSD
>> +       bool "UARTA on MicroSD breakout board"
>> +       default n
>> +       depends on TEGRA_ENABLE_UARTA && TARGET_TRANSFORMER_T20
>> +       select TEGRA_UARTA_SDB_SDD
>> +       help
>> +         Repurpose the SD card slot for getting access to the UARTA serial
>> +         console. Primarily useful only for low level u-boot debugging on
>> +         tablets, where normal UARTD is difficult to access and requires
>> +         device disassembly and/or soldering. Enabling this option causes
>> +         UARTA TX to become exposed on SDD and RX on SDB pins which correspond
>> +         to microSD CLK and CMD pins respectively. Currently this is supported
>> +         only on Transformer T20, support for other platforms may require DT
>> +         and configs (from include/configs/*) updates.
>> +
>>   source "board/nvidia/harmony/Kconfig"
>>   source "board/avionic-design/medcom-wide/Kconfig"
>>   source "board/compal/paz00/Kconfig"
>> --
>> 2.48.1
>>
> This is not applicable since this is a hack by nature, BUT if you
> contain this in the transformer t20 board and Kconfig (no dts
> changes), this may be applied.
Ok, then I'll drop DTS changes. I will add few words about this option 
in Transformer documentation
and a note in Kconfig help to not surprise users with not booting U-Boot 
as enabling this option without
changing DTS causes U-Boot to hang.
