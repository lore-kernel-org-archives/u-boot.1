Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C171C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 05:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80A182DB7;
	Tue, 27 May 2025 07:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="faxnwwnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7029B82E25; Tue, 27 May 2025 07:39:08 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4816782B7C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 07:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad88d77314bso66059166b.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 22:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748324345; x=1748929145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XQk3bYLb0nWYvC09PJyAQQ6dafY1mPw8GyzbnUvvOJE=;
 b=faxnwwnu3fhPnNlPRZqJ8ZErhgV/SCRgaBxPZS8dD7yJzZ7wxpMQe6BT21l3YvlyAv
 hQruUFITFzNwHBQSU5CODc+mVjky0C0JtsZraFxPtIiMFfWnKaY/KEQE2qJZbCqSoNmB
 Di88+mqof0k/ueGTIXHMWlJboaRgBfGBIayTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748324345; x=1748929145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQk3bYLb0nWYvC09PJyAQQ6dafY1mPw8GyzbnUvvOJE=;
 b=u/HfQtvuIqAmB1RsOSKfgQ8+vi2w5Yu/VG/U/54rhzS+JTowBy+R6xXHL+czJkCpni
 KywGgojazZilwKqhtSgpF0bOaxn6M5zBcZ6nBGYh4sbORl+FDkaH4/xSL8Cjwm6/WE5k
 XtchVA3mTA4NIp8AFh05J2xbkHYx1Z6jvANinrEYNZlND5u6GB8LLPlMOFDauohTaYbk
 0oLRHYO4gFljeqxRexDdChAr//LZfwz45BP+Ko+07Fn2sx3d5R1L1olVFIc2gGMRvIZl
 PiRH2zfggM2eS/Lz8pyDgywnw0u6A8/PdjrqcMOzOwrPdYGB4Qxtd+9qlBKrp5lzjWpT
 qFZQ==
X-Gm-Message-State: AOJu0YwP7VXcS/LbtIgNsRXH9bOejBTT6KctWDHXqYroRqoYdF6qkAXn
 OmFRR4IgdXLxvQhy6kTEMF8GezT/2w/7RmqxdB6Dzkm6619TaaL/oYVvn670QQLNARo8lJLVKPt
 LFr7+jKktdSdetYuYlNfX/Lb8rG9q76wxgJwrAU3iCFU+s/zY7gdbXZgU
X-Gm-Gg: ASbGncsXAIORXYcYBNu3J0LdoQNbRIchjF7ydHz2OxOXL1jGx4sIrD7w3px8hd0diuw
 E7fEBQCkjnHNpjCcrKaVQz6/oRq8snDc3Nbtxr2DJSw+m1gJ8p6sUB10Cu52Un0Qk+lGoj6pM68
 sjrAaySz87KQpTQahdtdHcTkxf6qnQdHE=
X-Google-Smtp-Source: AGHT+IHB7185LOohApxGFkwNOSYkyN+tqegINTPVkvNMLsvx6FgpqK+59r0iEQcOwFKxWDiWOiJnflYhvt/Gq+GCK9g=
X-Received: by 2002:a17:907:2d0e:b0:ad8:89c7:2735 with SMTP id
 a640c23a62f3a-ad889c72964mr193173366b.58.1748324344603; Mon, 26 May 2025
 22:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250526101541.3254628-1-sjg@chromium.org>
 <20250526101541.3254628-21-sjg@chromium.org>
In-Reply-To: <20250526101541.3254628-21-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 06:38:52 +0100
X-Gm-Features: AX0GCFu_O8GxSBgOQ3i8_nukzsLF5hpiOfVat3EFAlUgeF23UKiv2vIEIJBc7ts
Message-ID: <CAFLszTg1jw0+rODAXL6K=Czpd7FV6y+McdyND4gsS-nEbZU0Lg@mail.gmail.com>
Subject: Re: [PATCH v5 20/25] rockchip: Set the skip-at-start property
 correctly
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Anshul Dalal <anshuld@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Mon, 26 May 2025 at 11:16, Simon Glass <sjg@chromium.org> wrote:
>
> The rockchip image is written to the media at block 64, which is a 32K
> offset, so set the skip-at-start property to 0x8000
>
> Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
> Binman is dealing with the 'missing' 32K now.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v5:
> - Add to VPL file also
>
> Changes in v2:
> - Move this patch to the end of the series
> - Drop 0x8000 offset for SPI
>
>  arch/arm/dts/rockchip-u-boot.dtsi     | 1 +
>  arch/arm/dts/rockchip-vpl-u-boot.dtsi | 1 +
>  common/spl/Kconfig                    | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index 7a60f6b4526..3ff75c07121 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -171,6 +171,7 @@
>         simple-bin {
>                 filename = "u-boot-rockchip.bin";
>                 pad-byte = <0xff>;
> +               skip-at-start = <0x8000>;
>
>                 mkimage {
>                         filename = "idbloader.img";
> diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> index ac67b29c57a..66dcf36010e 100644
> --- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
> @@ -113,6 +113,7 @@
>         simple-bin {
>                 filename = "u-boot-rockchip.bin";
>                 pad-byte = <0xff>;
> +               skip-at-start = <0x8000>;
>
>                 alternates-fdt {
>                         fdt-list-dir = "dts/upstream/src/arm64/rockchip";
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index fb6c90733ee..fa28c18fa48 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -96,7 +96,7 @@ config SPL_MAX_SIZE
>
>  config SPL_PAD_TO
>         hex "Offset to which the SPL should be padded before appending the SPL payload"
> -       default 0x7f8000 if ARCH_ROCKCHIP
> +       default 0x800000 if ARCH_ROCKCHIP
>         default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>         default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
>         default 0x10000 if ARCH_KEYSTONE
> --
> 2.43.0
>

Unfortunately this patch needs an defconfig update for
CONFIG_SPL_PAD_TO for puma-rk3399 and ringneck-px30

CONFIG_SPL_PAD_TO=0x40000

I'll hold off sending a new version until this is reviewed.

Regards,
Simon
