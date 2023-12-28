Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FBFC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B75DA87A51;
	Thu, 28 Dec 2023 14:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C3rp1u0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1775487A76; Thu, 28 Dec 2023 14:37:49 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6D287A79
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbbdf0b859so1737607b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770663; x=1704375463; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXIfu2zwGi5PSmS89IaRTH3LaPRA77gIis4zue7UwM4=;
 b=C3rp1u0yb5u5Ssc3o+1KZ+ktwJ1WW670PwGKm8fs8tdhZ0IlcstVwwNi7b8dyyX0vG
 IJOZANpNTyQ5uNjPh2szxoLqO99XC5z8tVr7OzwwcUFdJWzQgjrmPi9oLH1+bs70FeyX
 WBMerosgzEqBsPqA9irAp+ScFeioc+T5NooVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770663; x=1704375463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXIfu2zwGi5PSmS89IaRTH3LaPRA77gIis4zue7UwM4=;
 b=tjJU+Df9palC3ZgiQjdd9z9E7AePwgB4VmCnM+V0amTmqaOe0+ImAlLq8cHlCqO+7B
 uE4fpAQRl+mzKfTLMgGcSayc/zoIRsgh4TGFmQZuoz18XQDdl+lMggJVMj/aF23yUpwM
 jeqyqpUOjpFDO8w4EPqTKMIyuy+8lQ5WyEvOxFERYafjXvakfFgXATJQAaeW1BVSw765
 rBnBAGgBz4rEC4rQ2Q+TKXSmhgHBO6CNdHHZ5FB7/25JNyMEYQtyLKwvufBmdqzFPtu3
 aVl70nh/GW92b5RhAPj5g6sC5daWlol3RRCY1oWZJXHcwW0y31bAdX3da1GHliVk6Afy
 1Ydg==
X-Gm-Message-State: AOJu0YyHxCl4y6YI8+7MyEByfsTH9iKaymb5ObkFRiwGKt/URU402ksr
 iFiUcSXCgGDdNAdnQJ9RnX5cgSIYtiaR4MxN/gC6RyA5LYbk
X-Google-Smtp-Source: AGHT+IGs2yZ1tGr8DO69t5wRi2GMQtl0BbEkfOYnJdI4sRgNR8uqJRhZz+za737p46Z5M3Ig/kUfmiEI/wAKN3g1E4o=
X-Received: by 2002:a05:6359:4c06:b0:172:f31a:6bfb with SMTP id
 kj6-20020a0563594c0600b00172f31a6bfbmr13714110rwc.51.1703770663578; Thu, 28
 Dec 2023 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-8-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:11 +0000
Message-ID: <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sumit,

On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Although there were still some variations in board DTS files based on
> meson-gxbb SoC but I think those were minor differences from upstream
> and shouldn't impact boot on these devices.
>
> So switch to upstream DT via mirroring amlogic/ directory from
> devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> building DTB from there including *-u-boot.dtsi files from
> arch/$(ARCH)/dts/ directory.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
>
> Changes in v2:
> --------------
> - Picked up review tag
>
>  arch/arm/mach-meson/Kconfig           | 1 +
>  configs/nanopi-k2_defconfig           | 2 +-
>  configs/odroid-c2_defconfig           | 2 +-
>  configs/p200_defconfig                | 2 +-
>  configs/p201_defconfig                | 2 +-
>  configs/videostrong-kii-pro_defconfig | 2 +-
>  configs/wetek-hub_defconfig           | 2 +-
>  configs/wetek-play2_defconfig         | 2 +-
>  dts/arch/arm64/amlogic                | 1 +
>  9 files changed, 9 insertions(+), 7 deletions(-)
>  create mode 120000 dts/arch/arm64/amlogic
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index d6c89058061..8ddb59161a0 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -25,6 +25,7 @@ choice
>  config MESON_GXBB
>         bool "GXBB"
>         select MESON_GX
> +       imply OF_UPSTREAM
>         help
>           Select this if your SoC is an S905
>
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 41dbf7981f8..2e1c756bf7a 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
>  CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_DM_RESET=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0xc81004c0

So now I am wondering if we can (later) have the SoC be implied when
using OF_UPSTREAM so we can do:

CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"

and it will add the 'amlogic/' automatically?

Perhaps that might be a way to bridge the gap in terms of file layout?

[..]

Regards,
Simon
