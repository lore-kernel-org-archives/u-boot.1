Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E17C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5AB80ECC;
	Sat, 29 Mar 2025 00:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hJvqVFS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E744810F4; Sat, 29 Mar 2025 00:41:22 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C20805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so669676666b.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205279; x=1743810079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BibLJem6OmznRpczvAA+9WgFL/dbPGXzzqc+ZoXxcz0=;
 b=hJvqVFS0v8ucBGAIXaXKPpupGshFb9remUx+jX1hb+JmOUITQ9K0LEzlg5sCN1UvFw
 lTeU5G03sjVNId/S5rBGtpHg8ob7k8EdVGQqsGdvitGOxGCbluPSyqtWpG01rKZcpy3q
 Yul0pCyuo7yroyyq2cuB1xU1uWV3ndKHFi2Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205279; x=1743810079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BibLJem6OmznRpczvAA+9WgFL/dbPGXzzqc+ZoXxcz0=;
 b=IRIkP3+b6qUq75/uf+w4yvkINpK4Ulo8P7Y2J11T4Mcp+QGPO0dpKJ64JP1aIQl4Ux
 i+NZ8diRGKwCApChbWhrWCK/KHuycHxplUIYR6332Ac6c7eTIvlMNJ3y6fDLPW6ZtEqc
 /wpg90auofFFzsTqIXHTdXBqrI5NMggook+tdCbBv8E1L4WoYAUbffIuSqIsJwXD/2PJ
 QfcVAyYV77yn5PJAb6HQTDgvvfC4porIWc5OI0aSZdqCAL7vETNENiCL+YYUYWM6OFlS
 xam2B2rq6RgQ2DoJu4ms8oA5Be7mvAIRXh5qh4ONwoZh+ZuidaRvYVkEwQPzgFbwXNhj
 QXjA==
X-Gm-Message-State: AOJu0YycV3J/n/ygOxJbrfgk9wNtzL+DTNcCBPjD+iia/tskyw+597hR
 C4xKhPalhRZ4pYosFs7ttkunPMp5ckZEt1frgE+IuwLIG1faFMfBxOWfxUgQNU3x7OKqvC2R6fq
 kcvByx9VOsSuiNpr1byk5GpSZG4DgsYfcGo9F
X-Gm-Gg: ASbGncuomkwurWsKG+fCk12N3HaQneQ/n+mkJfcdmWAldFDZn8EmTEEu/1yllrCsznH
 CawIFV1N3nb+QaKW7cBa2LG4MuWwIhq4F55VSm2jAlGtEaOFTbeHc7RSIzUX5/D8bPDqlYy9ZrG
 lYi8+mU5qqdrcKJ6PksNFPuYozDyM=
X-Google-Smtp-Source: AGHT+IFT4A9uUsDIeLegpsAGYRb/YXAHI3F2EFZ4iZTPkXvjBaU4cuANjossyPLZXmVi9GsRTEtZ7bSazSWnyPOmmg0=
X-Received: by 2002:a17:907:1c97:b0:ac6:e42a:fb4c with SMTP id
 a640c23a62f3a-ac71ec04f5cmr479006066b.9.1743205279231; Fri, 28 Mar 2025
 16:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
 <CALeDE9N0CirXGSJe=Tunj5LdV6pJ=MRrdVdCZfb6-E=mGOvraw@mail.gmail.com>
In-Reply-To: <CALeDE9N0CirXGSJe=Tunj5LdV6pJ=MRrdVdCZfb6-E=mGOvraw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:41:06 +0000
X-Gm-Features: AQ5f1JqVNT7Rx2gj3EnSm4IrCrhZQO5IJzhqKin7clutRk54gDugn9XYstrInZw
Message-ID: <CAFLszTivYeMsPKXqZ2CWSjVTgQ8Eb4u9BUnU8Z2yte83aSNyTg@mail.gmail.com>
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Henderson <richard.henderson@linaro.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, huang lin <hl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Peter,

On Fri, 28 Mar 2025 at 10:51, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 15:38, Simon Glass <sjg@chromium.org> wrote:
>>
>> Add support for this new phase, which runs after TPL. It determines the
>> state of the machine, then selects which SPL image to use. SDRAM init is
>> then done in SPL, so that it is updatable.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
>> - Skip spl-boot-order.c for VPL (rather than modifying it)
>>
>>  arch/arm/include/asm/spl.h               |   1 +
>>  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
>>  arch/arm/mach-rockchip/Makefile          |  11 ++-
>>  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
>>  arch/arm/mach-rockchip/spl.c             |   3 +
>>  arch/arm/mach-rockchip/tpl.c             |   2 +-
>>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
>>  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
>>  common/spl/Kconfig                       |   1 +
>>  9 files changed, 205 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>>  create mode 100644 arch/arm/mach-rockchip/vpl.c
>>
>> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
>> index ee79a19c05c..62844d64cab 100644
>> --- a/arch/arm/include/asm/spl.h
>> +++ b/arch/arm/include/asm/spl.h
>> @@ -30,6 +30,7 @@ enum {
>>         BOOT_DEVICE_XIP,
>>         BOOT_DEVICE_BOOTROM,
>>         BOOT_DEVICE_SMH,
>> +       BOOT_DEVICE_VBE,
>>         BOOT_DEVICE_NONE
>>  };
>>  #endif
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index 4c515593718..58ba0e0468f 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -252,13 +252,15 @@ config ROCKCHIP_RK3399
>>         select SPL_ATF
>>         select SPL_BOARD_INIT if SPL
>>         select SPL_LOAD_FIT
>> -       select SPL_CLK if SPL
>> +       select SPL_CLK if SPL && !VPL
>>         select SPL_PINCTRL if SPL
>>         select SPL_RAM if SPL
>>         select SPL_REGMAP if SPL
>>         select SPL_SYSCON if SPL
>>         select TPL_HAVE_INIT_STACK if TPL
>> -       select SPL_SEPARATE_BSS
>> +       select VPL_HAVE_INIT_STACK if VPL
>> +       select SPL_SEPARATE_BSS if !VPL
>> +       select SPL_RAW_IMAGE_SUPPORT if VPL
>>         select CLK
>>         select FIT
>>         select PINCTRL
>> @@ -268,6 +270,7 @@ config ROCKCHIP_RK3399
>>         select DM_PMIC
>>         select DM_REGULATOR_FIXED
>>         select BOARD_LATE_INIT
>> +       select SUPPORT_VPL
>>         imply ARMV8_CRYPTO
>>         imply ARMV8_SET_SMPEN
>>         imply BOOTSTD_FULL
>> @@ -296,13 +299,14 @@ config ROCKCHIP_RK3399
>>         imply TPL_LIBCOMMON_SUPPORT
>>         imply TPL_LIBGENERIC_SUPPORT
>>         imply TPL_OF_CONTROL
>> -       imply TPL_RAM
>> +       imply TPL_RAM if !VPL
>>         imply TPL_REGMAP
>>         imply TPL_ROCKCHIP_COMMON_BOARD
>>         imply TPL_SERIAL
>>         imply TPL_SYS_MALLOC_SIMPLE
>>         imply TPL_SYSCON
>>         imply TPL_TINY_MEMSET
>> +       imply TPL_DM_MMC if VPL
>>         help
>>           The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
>>           and quad-core Cortex-A53.
>> @@ -457,7 +461,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>>
>>  config TPL_ROCKCHIP_BACK_TO_BROM
>>         bool "TPL returns to bootrom"
>> -       default y
>> +       default y if !VPL
>>         select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>>         select TPL_BOOTROM_SUPPORT
>>         depends on TPL
>> @@ -498,6 +502,16 @@ config ROCKCHIP_EXTERNAL_TPL
>>           Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
>>           include the external TPL in the image built by binman.
>>
>> +config VPL_ROCKCHIP_COMMON_BOARD
>> +       bool "Rockchip VPL common board file"
>> +       depends on VPL
>> +       default y
>
>
> This should be optional and opt in, at least to begin with.

Yes, agreed. In this case, it depends on VPL, which is only enabled
for the new board being added here.

> I honestly don't see what value VBE provides, and I've not seen you describe your vision for it anyway.

Some docs:

https://docs.u-boot.org/en/latest/develop/vbe.html

Talk at osfc: https://elinux.org/Boot_Loaders#U-Boot

Alex Graf was kind enough to do another one at Embedded World 2022 but
I don't have a link.

If you are using UEFI, it won't provide any benefits.

Regards,
Simon
