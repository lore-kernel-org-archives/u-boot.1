Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88242C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 12:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E1B820F6;
	Tue,  6 May 2025 14:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NmIMWQo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03026820F6; Tue,  6 May 2025 14:03:42 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF5E80C83
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 14:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so8467700a12.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746533017; x=1747137817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D+rHNxK2dSz1oBKZa5NV4U32krQld7iLHKHXKe3LEjI=;
 b=NmIMWQo3ysUiaQqdPsdxwV+eMC8WF040umgbABR8PsHKv7o2+JUpvK0kpD9x41iC3W
 vyt9HYPD7M1ks20fITkqzEt4G53YQfXavq90LXwJt0TTvvWDSzsaBKeZ8trKB6XQY5PK
 fXfmh4bUsbgfMfuM8AFWzHiy3QGyhX3z5B15YPIa4Ea7+U15pW4cNzqS9uHGhdtsKKsC
 U3r3TfcTp5xw8ndnC9F1IkMGjcvYqyV6rnzFC1XDj7EgasACWD5EwQLHmz63aSh9N8Ew
 8cFt9X4xvc5d8w2Ri49c5xSYNCJKcbVg50Pdz/y9mQQntTKrpxFl8+AfjY1obHRGjhRW
 h77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746533017; x=1747137817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+rHNxK2dSz1oBKZa5NV4U32krQld7iLHKHXKe3LEjI=;
 b=NiGmhh7jzpk9Wr4nk3v5Kqu7HS2GQO2tw6P8UAQMyp+7/g11CmxMB+bPWsDQ8Bd5hb
 FHi33vChowJY7woTqk/9YXpFW0UG2bK9S0ZT3nZqIEbPxhHtKbOe34G63FHVOce/EGs1
 ULMIBait1f7CR8GQkmwXbZtYjr/Oig/Td7eySwdb28mD64jVTeLhECNz+VATf6Xxjghz
 hpkUnbOr35MNSsLO0usluKRFiaLb2RUoZUbhJS9GgPqXPINNWIvnoLqntUD7kQcwpwvl
 fSxdqeKP7C5jwKmCY5mPVIwnQClbNoXpAXFvJIuMvyxOLgASYBxsFGyoq0KT8BnEK/oy
 64ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgsW1kHh3q/5VDcZ2j8rsBrnBVlVINGqPVaKKWKPdcbcv+NQNJRRTTO3uqtK8JfSu65/2jlks=@lists.denx.de
X-Gm-Message-State: AOJu0YyW9fSZAKwJUfndIHjSCgTlFfYdMDE7b0fxpokt80XrOQzwKINr
 r6ZtAYquJR1HHMVrx5uHb7Drkq8ybGwamE+do6ueGaXAw/mP24/A0ocLpY1YvDaYqOLeJHsLk6B
 R+CY3c31bJGrDvoB1a1Or4cK9wjA=
X-Gm-Gg: ASbGncsnSylrDlEnEufjoG1A3eJDSOVEF/6DKKfYHcriQObkIUdXsi2hRSa9TWpGVfK
 xte6VHDTLkpPzcTTF799YFjFcMaNubeE7tEgK05Wmmck6Xrdbs+Yzkav3vewoAOowVe2thCbnVY
 vVpdPFIhc/SH8OBmJqqGS27ckbeB+lfvkockINCfr1lPgS5oIXXUKThx/p4VjJ/BRH7A==
X-Google-Smtp-Source: AGHT+IHNJaH0zW97hRGQF+pcmiNRmu8p6XY20aS0e+aoem7OmylCH/YhbO8IBAf7UgSSLThp4s52HXqG08OwxT0x2DQ=
X-Received: by 2002:a05:6402:d08:b0:5ee:497:89fc with SMTP id
 4fb4d7f45d1cf-5fa7891aae1mr14695805a12.33.1746533017400; Tue, 06 May 2025
 05:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de>
 <20250505-has_rom-u-boot-rockchip-spi-bin-v3-2-75f23b3bd8d3@cherry.de>
In-Reply-To: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-2-75f23b3bd8d3@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 6 May 2025 13:03:24 +0100
X-Gm-Features: ATxdqUE6itQ7L6JpBCktZ2F73NJWP-1soMivzJP_g9Gf8LSwevKdCi07qxMPHYE
Message-ID: <CALeDE9NEbG55xWJOUWg6=kDSXk_9LHcvuDaUiFvfB5fDbxtD4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3288: do not generate u-boot.rom
 anymore
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 5 May 2025 at 15:47, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This was only used on RK3288 Chromebooks and the EVB.
>
> If it follows the same pattern as for RK3399 Chromebooks where their
> maintainer (Simon) agreed[1] to removal of u-boot.rom on the basis that
> the generic u-boot-rockchip-spi.bin is now enough, let's do the same for
> RK3288 and remove the last Rockchip users of u-boot.rom (and HAS_ROM
> symbol).
>
> At the same time, remove HAS_ROM symbol from the RK3288 Chromebooks and
> EVB configs since they were used only for that.
>
> SYS_SPI_U_BOOT_OFFS offset in rockchip-u-boot.dtsi for the u-boot-img
> node of simple-bin-spi binman image matches the one used in u-boot.rom
> except for the EVB.
> The EVB doesn't have ROCKCHIP_SPI_IMAGE symbol enabled, so HAS_ROM had
> no effect anyway. Even if it had, this would not have been enough
> considering that SPL_SPI_LOAD symbol is not set, so U-Boot proper could
> not be loaded from SPI even if SPL/TPL does.
>
> Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
> Chromebooks as that seems to be important.
>
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  arch/arm/dts/rk3288-u-boot.dtsi        | 24 ------------------------
>  arch/arm/dts/rk3288-veyron-u-boot.dtsi |  8 ++++++++
>  arch/arm/mach-rockchip/rk3288/Kconfig  |  5 -----
>  3 files changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
> index 2205caabc51ec4535bef3ab950d7ff5b421d8016..bb0078588fe819118eb0592e002e1708da7ce806 100644
> --- a/arch/arm/dts/rk3288-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-u-boot.dtsi
> @@ -46,30 +46,6 @@
>         };
>  };
>
> -#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
> -&binman {
> -       rom {
> -               filename = "u-boot.rom";
> -               size = <0x400000>;
> -               pad-byte = <0xff>;
> -
> -               mkimage {
> -                       args = "-n rk3288 -T rkspi";
> -                       u-boot-spl {
> -                       };
> -               };
> -               u-boot-img {
> -                       offset = <0x20000>;
> -               };
> -               u-boot {
> -                       offset = <0x300000>;
> -               };
> -               fdtmap {
> -               };
> -       };
> -};
> -#endif
> -
>  &bus_intmem {
>         ddr_sram: ddr-sram@1000 {
>                 compatible = "rockchip,rk3288-ddr-sram";
> diff --git a/arch/arm/dts/rk3288-veyron-u-boot.dtsi b/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> index 4f9c59c67573118dba716e46f21f9b5e303b0c28..89093e2311c758b78454710043aea7006533e5bd 100644
> --- a/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> +++ b/arch/arm/dts/rk3288-veyron-u-boot.dtsi
> @@ -11,6 +11,14 @@
>         };
>  };
>
> +#if defined(CONFIG_ROCKCHIP_SPI_IMAGE)
> +&binman {
> +       simple-bin-spi {
> +               size = <0x400000>;
> +       };
> +};
> +#endif
> +
>  &dmc {
>         logic-supply = <&vdd_logic>;
>         rockchip,odt-disable-freq = <333000000>;
> diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
> index e563bf455e6803809c7d7612bb3aa85372034292..128ee362f8a8af69861030df7b63cf0e5a368956 100644
> --- a/arch/arm/mach-rockchip/rk3288/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3288/Kconfig
> @@ -5,7 +5,6 @@ choice
>
>  config TARGET_CHROMEBOOK_JERRY
>         bool "Google/Rockchip Veyron-Jerry Chromebook"
> -       select HAS_ROM
>         select BOARD_LATE_INIT
>         select ROCKCHIP_SPI_IMAGE
>         help
> @@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_JERRY
>
>  config TARGET_CHROMEBIT_MICKEY
>         bool "Google/Rockchip Veyron-Mickey Chromebit"
> -       select HAS_ROM
>         select BOARD_LATE_INIT
>         select ROCKCHIP_SPI_IMAGE
>         help
> @@ -28,7 +26,6 @@ config TARGET_CHROMEBIT_MICKEY
>
>  config TARGET_CHROMEBOOK_MINNIE
>         bool "Google/Rockchip Veyron-Minnie Chromebook"
> -       select HAS_ROM
>         select BOARD_LATE_INIT
>         select ROCKCHIP_SPI_IMAGE
>         help
> @@ -41,7 +38,6 @@ config TARGET_CHROMEBOOK_MINNIE
>
>  config TARGET_CHROMEBOOK_SPEEDY
>         bool "Google/Rockchip Veyron-Speedy Chromebook"
> -       select HAS_ROM
>         select BOARD_LATE_INIT
>         select ROCKCHIP_SPI_IMAGE
>         help
> @@ -54,7 +50,6 @@ config TARGET_CHROMEBOOK_SPEEDY
>
>  config TARGET_EVB_RK3288
>         bool "Evb-RK3288"
> -       select HAS_ROM
>         select BOARD_LATE_INIT
>         select TPL
>         help
>
> --
> 2.49.0
>
