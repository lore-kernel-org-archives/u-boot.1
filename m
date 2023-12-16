Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261B8C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0BD87CC1;
	Sat, 16 Dec 2023 19:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qqk+FSUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B5987C73; Sat, 16 Dec 2023 19:48:43 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72D987C7B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db8892a5f96so1379306276.2
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZ5ftUQbfItH9oFe58sT4ep79n89r6/CUPMWm6XepxU=;
 b=Qqk+FSUoDjnbzBgX76CPsYqhrRUW6BhyrdxCM1ArihPxFTfnqgAhbvwtA6HGAiELuD
 46dFHUC5UgpPJwWTXxSR9iGGL2cNIphiFxYfEjaoNIsUo+6kwmKfbPEcOjt3gd06zyPO
 /u90QtNFy9J6PCHKYIeQ6363wHqnBlD8JsXIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZ5ftUQbfItH9oFe58sT4ep79n89r6/CUPMWm6XepxU=;
 b=dotldwj6rkksQfMmjmQFeEGztT5ior2RqdOjkZAP3xBu2g41AqJJt3agnVMASUtj0O
 nt9XFpGaKXy1KwCxXhmG8aFnOBBxFxMEM/9+owPEGBEPehJGojSl7mzmyHzePa3rupjZ
 K4B7C6O8ByHwUdc7omipOajbzitGA+QhbA04PsBBCY/wdDKgBOJ7o3/BA10YscRCFqCO
 Xb0uQvAOSQp+qLzw03hNRo9djU2sLWrPMv3FcjIW/3pUzmgG2mqx7k5/ZW8+Hmqi7mxc
 F/+l6qp3GSvd74iX7KgAK/ORxaSiaNWEp84Jvcj2AZYvi/cliIm1F2V8U8BDv6CnVlXC
 OWnA==
X-Gm-Message-State: AOJu0YwLa/sJ8T/N+8wGil6/s88K+Juo+8pNPnf8mHFcMY91hI3ICwPr
 M31GHsjwXuFXSaoK3D2Z6jIIn1Sw8GZGFTDFn8jtKPDGVVkMmj4iLFA=
X-Google-Smtp-Source: AGHT+IHY7BQZex1fDK1TTo6I8L7fXWEiPvAihboVrbhmwiWSH1N+SgnZuh9yMmo9MJw01kYeIpmq1x+/GqvCAtzlMvQ=
X-Received: by 2002:a0d:f302:0:b0:5d7:1940:dd91 with SMTP id
 c2-20020a0df302000000b005d71940dd91mr10272835ywf.103.1702752514137; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231214121136.3286703-1-ada@thorsis.com>
 <20231214121136.3286703-2-ada@thorsis.com>
In-Reply-To: <20231214121136.3286703-2-ada@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:57 -0700
Message-ID: <CAPnjgZ0pUNa02FJQb2aZWbwWymLcciJv2EZUkerXGjstwD-Q8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools: kwbimage: Allow disabling build on
 non-mvebu platforms
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Terry Lv <terry.lv@nxp.com>
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

On Thu, 14 Dec 2023 at 05:11, Alexander Dahl <ada@thorsis.com> wrote:
>
> Some users want to build with CONFIG_TOOLS_LIBCRYPTO disabled, which in
> general is possible for at least some boards.  32-bit mvebu however
> requires kwbimage for building SPL, and kwbimage has a hard dependency
> to host OpenSSL.
>
> The new symbol CONFIG_TOOLS_KWBIMAGE allows disabling kwbimage build on
> non-mvebu platforms, and thus building without host libcrypto from
> OpenSSL.
>
> Based on previous work and discussions, see links below.
>
> Link: https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.org/
> Link: https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.de/
> Link: https://lore.kernel.org/u-boot/20230121154743.667253-2-paulerwan.rio@gmail.com/
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>
> Notes:
>     This is more or less a mashup of the patches of Pali and Marek, but
>     considering the feedback given by Samuel on Pali's patch and considering
>     what I thought was the preferred style in other parts of the Makefile.
>
>     Link: https://lore.kernel.org/u-boot/f4660467-9d25-dc46-9e60-b2f7f09236c2@sholland.org/
>
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  tools/Kconfig               | 5 +++++
>  tools/Makefile              | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

But  please drop the whitespace changes


>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index c80d8587b14..2058c95ca2d 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -15,6 +15,7 @@ config ARMADA_32BIT
>         select SUPPORT_SPL
>         select SYS_L2_PL310 if !SYS_L2CACHE_OFF
>         select TRANSLATION_OFFSET
> +       select TOOLS_KWBIMAGE if SPL
>         select SPL_SYS_NO_VECTOR_TABLE if SPL
>         select ARCH_VERY_EARLY_INIT
>
> diff --git a/tools/Kconfig b/tools/Kconfig
> index 6e23f44d550..f8632cd59d0 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -25,6 +25,11 @@ config TOOLS_LIBCRYPTO
>           This selection does not affect target features, such as runtime FIT
>           signature verification.
>
> +config TOOLS_KWBIMAGE
> +       bool "Enable kwbimage support in host tools"
> +       default y
> +       select TOOLS_LIBCRYPTO
> +
>  config TOOLS_FIT
>         def_bool y
>         help
> diff --git a/tools/Makefile b/tools/Makefile
> index 1aa1e36137b..fd3b207eb96 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -94,8 +94,11 @@ LIBCRYPTO_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := \
>                         generated/lib/fdt-libcrypto.o \
>                         sunxi_toc0.o
>
> +KWB_IMAGE_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := kwbimage.o
> +
>  ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
>
> +
>  # common objs for dumpimage and mkimage
>  dumpimage-mkimage-objs := aisimage.o \
>                         atmelimage.o \
> @@ -114,7 +117,7 @@ dumpimage-mkimage-objs := aisimage.o \
>                         imximage.o \
>                         imx8image.o \
>                         imx8mimage.o \
> -                       kwbimage.o \
> +                       $(KWB_IMAGE_OBJS-y) \
>                         generated/lib/md5.o \
>                         lpc32xximage.o \
>                         mxsimage.o \
> --
> 2.39.2
>
