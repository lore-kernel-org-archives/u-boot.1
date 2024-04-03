Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F65CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 04:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E00B881A7;
	Wed,  3 Apr 2024 06:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjpfL4JY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07785881D4; Wed,  3 Apr 2024 06:46:00 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2431487A4B
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 06:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56d5d4d2e2bso3871447a12.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712119557; x=1712724357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbLLMYGTnT82sVFGQlHP5JiIWoxFi33XbH38JWMdPQw=;
 b=HjpfL4JY3Wws69Y07eeoa1t4vVkfgPYY0SJQB+JdfZ5L5ERuI2+0GJvcCp75fwujne
 Q647FnlODQeDLKo9uBtuzu+6qM6xxDf5po4rmvgw5V5Fx7Tp4HzajhuMDyiuZKzAkf7p
 GbnVvBEGFohQCbAqkweeBuz/fXJ36kNW9aGTP6qSVIo2yYfcvxcZUL1KveQDfdlH/zdJ
 f5say8GSN3nehRsJFYTZMUCJvEhjYnyCPaRBLFyybkdi3F/pSzaNQIWZG4y5IDaWuouu
 /sXwj9TOFOH5ATSAcfY0KcFDqPFJ3n7xHZWvVSejTUOuZ+sINrBtU8BTDN32kP+f1nfA
 cSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712119557; x=1712724357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbLLMYGTnT82sVFGQlHP5JiIWoxFi33XbH38JWMdPQw=;
 b=rYYA4inEQ752qwknp8OOuWowFjXm+A1cn+mx4HWyjJ/KVVeNu5azA36aAEIUtBLHs6
 u0h/6vzStE/eRDcNCOfAwoHsKxj+GoSh83A71LnQyiSl5vz7EBiRyEoBPEH/xs2s70YD
 RS9JutOGx9XTKkRifefgWW9NMF5lotnwTIEX26SuFKlCd/Xka8551vfCGpwkRVpayxD+
 c1QMMLNKtLvC3De9cGdRkiYDiRGRuoNM0hJZDEsYGmYxfcbuYbSr5OPm1Z1B9A3OJFZk
 V5Rm2IfRDO3fR0ddc8gt0XkbKfifZO0aT1mo41y+/nvpaKNyf+v6Ko2a6hqOWJwT6Q8A
 PUEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6dbytkDWLs1cTXA7E1qatJfpFN7LRNVfUz4MVmTzOe3q7qNep5j+2uBQh7pJsaOBrpxIY6bJyTbjehN/dvzKj0JPrDw==
X-Gm-Message-State: AOJu0YyBuAXbh5/0zcAtlCqEgn8pFDwk9F7KXlUNnrgoAbyybL7daqkv
 NnwHz61tHgVSDiBYJ8FQ3mz4EMr31tiExpvTz/L0k4sfABR67Bwxhc1is7CelnWjEtsXPlHuiYo
 T8N5u+0NCDphTcBliC1+N2Md6+QU=
X-Google-Smtp-Source: AGHT+IFoYbmkpH7E49ww+u6qRDqnWSdI6Y4pQXI8gwPRpb2G7NyE5qHihZaIMtZa3VivBQW/DDuvLQ3Vw5kF2Vii6VM=
X-Received: by 2002:a50:d7d9:0:b0:568:180a:284b with SMTP id
 m25-20020a50d7d9000000b00568180a284bmr7324911edj.37.1712119557462; Tue, 02
 Apr 2024 21:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-3-jonas@kwiboo.se>
In-Reply-To: <20240331202921.262323-3-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 3 Apr 2024 04:45:46 +0000
Message-ID: <CALeDE9O=x4eO9YoiDUG9oFocDcEyyo+NysdZV2NdgDGKCL-8vw@mail.gmail.com>
Subject: Re: [PATCH 02/31] rockchip: rk3399-ficus: Enable TPL and use common
 bss and stack addr
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, u-boot@lists.denx.de
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

On Sun, 31 Mar 2024 at 21:30, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The rk3399-ficus board is only using SPL and not TPL+SPL like all other
> RK3399 boards, chromebook bob/kevin excluded. It does not seem to be any
> technical reason why this board was left using only SPL.
>
> Switch to use TPL+SPL and use common bss and stack addresses to allow
> for more options to be enabled in a future patch. Also add the missing
> DEFAULT_FDT_FILE option.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

I believe I have one of these if you need anything tested.

P

> ---
>  configs/ficus-rk3399_defconfig | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index 4859042d6b56..3bcd0fd66b91 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -2,32 +2,22 @@ CONFIG_ARM=y
>  CONFIG_SKIP_LOWLEVEL_INIT=y
>  CONFIG_COUNTER_FREQUENCY=24000000
>  CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>  CONFIG_SF_DEFAULT_SPEED=20000000
>  CONFIG_ENV_OFFSET=0x3F8000
>  CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
> -CONFIG_SPL_TEXT_BASE=0xff8c2000
>  CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
>  CONFIG_TARGET_ROCK960_RK3399=y
> -CONFIG_SPL_STACK=0xff8effff
>  CONFIG_DEBUG_UART_BASE=0xFF1A0000
>  CONFIG_DEBUG_UART_CLOCK=24000000
>  CONFIG_SYS_LOAD_ADDR=0x800800
>  CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x2e000
>  CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>  CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_TPL=y
>  CONFIG_CMD_BOOTZ=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> --
> 2.43.2
>
