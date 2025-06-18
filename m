Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9E3C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C328B82C79;
	Wed, 18 Jun 2025 09:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PNZ/+L7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318E382C87; Wed, 18 Jun 2025 09:36:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EC282C2F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-608acb0a27fso8694666a12.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750232161; x=1750836961; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=No0ZHrY62VdlgKc7ibhYMmHWB4tHM4UQwgHsyjGhr9M=;
 b=PNZ/+L7OPdDXk6FXwQDKMn4NqraxEPGpr1COPOu5b7He3nsU8U1GBMLOSBrqAyvEGG
 +hOFoKT5WlQhwUmFPKRpD8CAnaq2gHq77iI0HP7RmKTJhcqmbQYRQvyONmRG+FW1u6iZ
 ZdHObQecDgON5UV52d48QSV0JAVVYcmmTv2+UUAD5YBDfRyLpgoBSe4AH6+j0LnSufgx
 0FHnQsJH4NK9rw4pnVWfYARKxHgN0WITSC/kaZZtC0DmVmN0SsBwl8IRi4Xk8T+F9a0l
 XgqgdSj5FDo2FiVmgsWd8CJotS+Pp2N1JCZh5vN8qFABSg7OiiZ7ZihQ23J5GXaKElZS
 Rngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750232161; x=1750836961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=No0ZHrY62VdlgKc7ibhYMmHWB4tHM4UQwgHsyjGhr9M=;
 b=svTQTh8wFCFRs/fP49vfWWyz0X0z6Dm0M8lHdyAZYnS4r1D9nlIYI4kSspaCWy91k1
 uj9e2PhYf3qgWA8RR+b3nhsGBAgeM+yXr78deSk73Kvj0FKwzLjxDYzgsEsZUF+aRgtK
 zTcSJKwWvO1pliT0McVtRQkyRII44fpPAWIgT8YaNHypRsY8uEKXKdtiIVjUPiwA9CCf
 s0QCmdjvInDdlv9Ki5hbIu/aO/STsOJwhQ7WRVbccO80lt8/P7xDL4egrrYtYns8YzJu
 Y0lBjprNXWkegEEBHOXgK82PcGztENC1tjtLJ24+y0pwFk25eTGoKhKnEOxxyMtG6wrh
 ioLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsqouZttd2GP30sJOgVvD2+xrh6kqz4sgKSJM9JCxfm8KFF/jPjx2mgNBW4ZamMk7Z8iQh70U=@lists.denx.de
X-Gm-Message-State: AOJu0YzVfBhfq4DpCibC1BtRPPaVj00m6R3NPGbD5zbSMCl9+rjz9tNy
 j3RTn8Us0JfVEyolwZE6h8HoyHKOHtD8YWGNjQXzHhFR7jZ3b6M9RRUu4JA9/ao3FAk=
X-Gm-Gg: ASbGncsVb0oJ14V74W3gl62Znn0Tn5yIbYjFrbvyOl9+C4YeMqfDv5yAqYVkEt+1Dt2
 wlYr/k1ksp+NoUE3p+qsr982pZLvURr0FSwjA4Db0KGWni0a2j95K985HpYS0jxgaF/UeA1OATk
 zH3XOzZs9Qo1LQPOXuqKy+KIo7JXLKqJxrAFAPLj0DyubSn/eXgAoSl00ac8cyY7fv7YOADabpH
 NhDjQhOBeMsZmIsNhs3uefEMmzukpdeFyeNeo5oKd8vXfJms4VQnwBE+IMMql9pOxSJcf9URads
 /W04rjRjxDNU8gi/HC+KVrhe1xU3wdB4LBWx8x3RewNOUGjrYYH90ipE6bus2HA1PfSepA==
X-Google-Smtp-Source: AGHT+IF5fYTikCcrgJEUkCEfKa5Fuexog1i7SWVgNd4NgI0PcNjPJyWzDajUYzMokkpNM75v/6GO4w==
X-Received: by 2002:a17:907:6d0d:b0:adb:2bb2:ee2 with SMTP id
 a640c23a62f3a-adfad451438mr1797962366b.41.1750232161310; 
 Wed, 18 Jun 2025 00:36:01 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adf2a174072sm915545766b.32.2025.06.18.00.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:36:00 -0700 (PDT)
Message-ID: <a0419e95-e333-4d7e-b2bc-3f0d21e46f23@linaro.org>
Date: Wed, 18 Jun 2025 10:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] Add support for sam9x7 SoC and SAM9X75 Curiosity
 board
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250603050556.80851-1-manikandan.m@microchip.com>
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



On 6/3/25 08:05, Manikandan Muralidharan wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - sam9x7 SoC is added
>  - Clock driver for sam9x7 is added
>  - Target board SAM9X75 Curiosity is added with its differences in DT
>  and MMC config support 
> 
> ----
> changes in v6:
> - 1/4 - New addition to this series
> - 5/8 - Parse NULL in at91_clk_main_rc() call for parent_name
> - 7/8 - Remove main_rc node from DT
> 
> changes in v5:
> - 4/8 - Define ID_MAIN_RC name in sam9x7 clock driver thus dropping
> 	the main_rc clock from DT and Alinging it with Linux
> - 6/8 - Drop main_rc clock for pmc node in DT
> 
> changes in v4:
> - 1/8 - Drop the local include file clock/at91.h and the update
> 	the MAINTAINERS respectively.
> 
> changes in v3:
> - 1/8 - rename at91.h to at91-pmc-status.h, update the SoC DTs
> 	and MAINTAINERS file respectively
> - 4/8 - update header from clk/at91.h to clock/at91.h 
> 
> changes in v2:
> - 1/8 - add additional PMC clock definition to support the sam9x7 upstream
> 	DT
> - 6/8 - Remove support for SoC DT and board DTS as they are already available
>         in dts/upstream
>       - add the differences in DT files between upstream Linux DT and U-Boot
>       	DT to at91-sam9x75_curiosity-u-boot.dtsi
> - 7/8 - Add OF_UPSTREAM support for sam9x75 curiosity board
> - 8/8 - update the DEFAULT_DEVICE_TREE config to <vendor/name>
> 
> ----
> 
> 
> Manikandan Muralidharan (5):
>   dt-bindings: drop at91.h from clock includes
>   clk: at91: clk-main: drop parent_name check when registering main_rc
>     oscillator
>   ARM: dts: at91: sam9x75_curiosity: add tweaks for sam9x75 curiosity
>     board
>   board: sam9x75_curiosity: Add support for sam9x75 curiosity
>   configs: sam9x75_curiosity: Add initial mmc default config
> 
> Varshini Rajendran (4):
>   clk: at91: sam9x60-pll: add support for core clock frequency inputs
>   clk: at91: sam9x60-pll: add support for HW PLL freq dividers
>   clk: at91: sam9x7: add pmc driver for sam9x7 SoC family
>   ARM: at91: Add sam9x7 soc
> 
>  MAINTAINERS                                   |    1 -
>  .../dts/at91-sam9x75_curiosity-u-boot.dtsi    |   95 ++
>  arch/arm/mach-at91/Kconfig                    |   12 +
>  arch/arm/mach-at91/arm926ejs/Makefile         |    1 +
>  arch/arm/mach-at91/arm926ejs/sam9x7_devices.c |   49 +
>  arch/arm/mach-at91/include/mach/hardware.h    |    2 +
>  arch/arm/mach-at91/include/mach/sam9x7.h      |  172 +++
>  board/atmel/sam9x75_curiosity/Kconfig         |   15 +
>  board/atmel/sam9x75_curiosity/MAINTAINERS     |    7 +
>  board/atmel/sam9x75_curiosity/Makefile        |    7 +
>  .../sam9x75_curiosity/sam9x75_curiosity.c     |   66 +
>  configs/sam9x75_curiosity_mmc_defconfig       |   73 ++
>  drivers/clk/at91/Makefile                     |    1 +
>  drivers/clk/at91/clk-main.c                   |    2 +-
>  drivers/clk/at91/clk-sam9x60-pll.c            |   55 +-
>  drivers/clk/at91/pmc.h                        |    2 +
>  drivers/clk/at91/sam9x60.c                    |    7 +
>  drivers/clk/at91/sam9x7.c                     | 1085 +++++++++++++++++
>  drivers/clk/at91/sama7g5.c                    |    6 +
>  include/configs/sam9x75_curiosity.h           |   23 +
>  include/dt-bindings/clock/at91.h              |   23 -
>  21 files changed, 1669 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
>  create mode 100644 arch/arm/mach-at91/arm926ejs/sam9x7_devices.c
>  create mode 100644 arch/arm/mach-at91/include/mach/sam9x7.h
>  create mode 100644 board/atmel/sam9x75_curiosity/Kconfig
>  create mode 100644 board/atmel/sam9x75_curiosity/MAINTAINERS
>  create mode 100644 board/atmel/sam9x75_curiosity/Makefile
>  create mode 100644 board/atmel/sam9x75_curiosity/sam9x75_curiosity.c
>  create mode 100644 configs/sam9x75_curiosity_mmc_defconfig
>  create mode 100644 drivers/clk/at91/sam9x7.c
>  create mode 100644 include/configs/sam9x75_curiosity.h
>  delete mode 100644 include/dt-bindings/clock/at91.h
> 


Even though I am not really happy with patch 4/9 , but because I haven't
figured a better way to deal with it without some core rework, let's not
delay this further, applied to u-boot-at91/next !

Eugen
