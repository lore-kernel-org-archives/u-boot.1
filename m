Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F20C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21048876D5;
	Wed, 20 Dec 2023 13:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="URa5oF8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642E387720; Wed, 20 Dec 2023 13:40:53 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4DBF876D5
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ba3cf9aa13so3812549b6e.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703076046; x=1703680846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UBrrCWePQAAD7Q3oqlwg8m/71Pl/MlCGxudnEaZw85E=;
 b=URa5oF8qz6BaWiX/jyJ8PeiT3Z6SPj284AZgYx0JLQMfjqbKXx3UC0SelL4S2WQWCO
 TZHhuFeTyT7vrPS4XyyQI37pXRFUdwlm+NbDL76T55naMi/H7M8+yWErMu0q+8zhSYol
 VtuFaeRuZWUMkDhtGByMyuYFHL1XspNG6bMfLSZf5kuFyNwYKBRJXhBaz3kCdFHgN+CI
 tfvhuE06lMFSaNeVxN7OKztB29Cyfy+8N2M9kInVyYYCJ5mbCh9+jKNv8pSqheS/R9lq
 95MP0cGsXO2q1ZwCflSwpz+Hi+qzmZ+hyyjOT0xPUMZUrLanHwhV9l904ovzOlWEDcOc
 lgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703076046; x=1703680846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UBrrCWePQAAD7Q3oqlwg8m/71Pl/MlCGxudnEaZw85E=;
 b=FEOxp2ayGKZUhYW/1htbk8yfYN9jR9iscMuGRThM5NhvEygpfYNDoAcibxyZWjWFpg
 Be5t+159pm0M7ERsaoLyG3wH3JPSQ/zJkpQ2DrA0Q/JzI9TWIKhuIwKXsrqui6BUzXJj
 IWFesCrJOq1r1DOJrjqjBDefjymGPIqNZ9MsNEEibhf5jfrnaD0sRBQNoNqLdIcTsoKX
 mfCpuhdO0DJTn+JXdS9nv2+7laiLArKR7H3MTM0jI2HfHV7ElNhZGBDr5cBtjWT0xxjd
 53/5u7DaepsyPQGpTCNUmcxVyvi3V7f6G172jw6jsoMzdtR/5aPHJ1VDv7Mvd+e7Tw/D
 bUKQ==
X-Gm-Message-State: AOJu0YxXVeFUvAj+8tnK+nnbE/e5LGW2OExPGV8HKtUK85+IyI3f7TB4
 bLMOCKv9UG7IVXr9U6PVGAwLvkJAzp4nd0Df+h5tUg==
X-Google-Smtp-Source: AGHT+IELQcbcpPduvUikYLZhzVlcKq9WqdHdIdKdI531hzEqJe3xEH/YJEoBREwRg5EwEHFU1hKEXwzPJG6FfVBeQkg=
X-Received: by 2002:a05:6808:399b:b0:3b9:ede4:524d with SMTP id
 gq27-20020a056808399b00b003b9ede4524dmr23233672oib.116.1703076046355; Wed, 20
 Dec 2023 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-8-sumit.garg@linaro.org>
 <a269fb79-8374-443a-a077-6477a97d6aba@linaro.org>
In-Reply-To: <a269fb79-8374-443a-a077-6477a97d6aba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 18:10:35 +0530
Message-ID: <CAFA6WYNykzMeYzZqa+UJ_ouewRB_juQ71BDPd=THcBdaHJJtZA@mail.gmail.com>
Subject: Re: [PATCH 7/8] dts: meson-gxbb: Switch to using upstream DT
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
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

On Wed, 20 Dec 2023 at 16:23, <neil.armstrong@linaro.org> wrote:
>
> On 14/12/2023 14:51, Sumit Garg wrote:
> > Although there were still some variations in board DTS files based on
> > meson-gxbb SoC but I think those were minor differences from upstream
> > and shouldn't impact boot on these devices.
> >
> > So switch to upstream DT via mirroring amlogic/ directory from
> > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > building DTB from there including *-u-boot.dtsi files from
> > arch/$(ARCH)/dts/ directory.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   configs/nanopi-k2_defconfig           | 3 ++-
> >   configs/odroid-c2_defconfig           | 3 ++-
> >   configs/p200_defconfig                | 3 ++-
> >   configs/p201_defconfig                | 3 ++-
> >   configs/videostrong-kii-pro_defconfig | 3 ++-
> >   configs/wetek-hub_defconfig           | 3 ++-
> >   configs/wetek-play2_defconfig         | 3 ++-
> >   dts/arch/arm64/Makefile               | 9 +++++++++
> >   dts/arch/arm64/amlogic                | 1 +
> >   9 files changed, 24 insertions(+), 7 deletions(-)
> >   create mode 120000 dts/arch/arm64/amlogic
> >
> > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> > index 41dbf7981f8..3db296916e9 100644
> > --- a/configs/nanopi-k2_defconfig
> > +++ b/configs/nanopi-k2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> > index 5f9f323e06e..65857ff478c 100644
> > --- a/configs/odroid-c2_defconfig
> > +++ b/configs/odroid-c2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> > index cd579ef5f14..c1792db51fd 100644
> > --- a/configs/p200_defconfig
> > +++ b/configs/p200_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/p201_defconfig b/configs/p201_defconfig
> > index b2f0a0ccdb4..202e1da5bcc 100644
> > --- a/configs/p201_defconfig
> > +++ b/configs/p201_defconfig
> > @@ -7,7 +7,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
> > index 3eda8f14a21..d09333d3b96 100644
> > --- a/configs/videostrong-kii-pro_defconfig
> > +++ b/configs/videostrong-kii-pro_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> > index fd92b041e73..73f3d4aad5d 100644
> > --- a/configs/wetek-hub_defconfig
> > +++ b/configs/wetek-hub_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> > index b887419a6ba..26f57b4214a 100644
> > --- a/configs/wetek-play2_defconfig
> > +++ b/configs/wetek-play2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> > index 16e9fea622d..d548584cf5c 100644
> > --- a/dts/arch/arm64/Makefile
> > +++ b/dts/arch/arm64/Makefile
> > @@ -1,5 +1,14 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >
> > +dtb-$(CONFIG_ARCH_MESON) += \
> > +     amlogic/meson-gxbb-kii-pro.dtb \
> > +     amlogic/meson-gxbb-nanopi-k2.dtb \
> > +     amlogic/meson-gxbb-odroidc2.dtb \
> > +     amlogic/meson-gxbb-p200.dtb \
> > +     amlogic/meson-gxbb-p201.dtb \
> > +     amlogic/meson-gxbb-wetek-hub.dtb \
> > +     amlogic/meson-gxbb-wetek-play2.dtb
> > +
> >   include $(srctree)/scripts/Makefile.dts
> >
> >   targets += $(dtb-y)
> > diff --git a/dts/arch/arm64/amlogic b/dts/arch/arm64/amlogic
> > new file mode 120000
> > index 00000000000..73f7c3e7bd0
> > --- /dev/null
> > +++ b/dts/arch/arm64/amlogic
> > @@ -0,0 +1 @@
> > +../../../devicetree-rebasing/src/arm64/amlogic/
> > \ No newline at end of file
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>

Thanks.

> Note: with https://lore.kernel.org/all/8c32e92f-810f-434b-ba77-3074490458bd@linaro.org/ merged it could be be extended to GXL/GXM aswell

Sure, I will convert GXL/GXM too once your PR is merged and this series lands.

-Sumit

>
> Thanks,
> Neil
