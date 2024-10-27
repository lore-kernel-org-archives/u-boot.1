Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B070D13576
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F11C88969;
	Sun, 27 Oct 2024 18:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DkYz3MqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F64588969; Sun, 27 Oct 2024 18:16:05 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06068839A
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a16b310f5so545970866b.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049360; x=1730654160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRtMjJf11nmsxkEjQYajeibH/Cqq+uFn55GPM3wxe9M=;
 b=DkYz3MqO4S23JYjNQU4fVYdck4nZS1tkMrr5Uhxe6DKApfvmqRQ8thITrXCaOnpVye
 Jrnrh/2kJ0/J6uzFQsVDFHRsME8toTW+KIg5gbyKU3ncYZzGeOy1XsejfoDrGMbsARCJ
 V2WIeZuq0PbtpJUPL+ClfA2xm0kKjVfB/l+P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049360; x=1730654160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRtMjJf11nmsxkEjQYajeibH/Cqq+uFn55GPM3wxe9M=;
 b=IBHvsuO89PDWFlluS4cyoOypsuwFeb0KGgrd8Saw+4TiORrG1/WzsgyGyGS4zPAJcQ
 aB08z+HNUpaLV2bMYf+5j+sHmILN8ubZe4kz1601fVZBIAjP6DDESG82nvKsytTeMj10
 L20ynYCyBihx6XXl9bH7s0HPgVFWmq6QK+VhQ55Z2gKDpmLAuMZxOcZNK/V1IQP6JyjO
 gNv7wJtOu9H148ADmPqghF2oK8TwBqbFcW9XpfE9PTH1UsY4ZmR6UsTVWN1Q9KKOP9Mp
 EwV0umzgISrjo/WP3dp8J5Km5A2SemR3ZBjCGLOzNaxbmCCy7D71TMF45VJtsZKK16HF
 bNxQ==
X-Gm-Message-State: AOJu0YzwRc7wFQxaYdAFT0OfM4TluEWVfMm4S6swGVwU+z/dtXyBz8lc
 LQMDnBNy2XTjznj4GlpqdjE5BO9L3nGyZytGgmBi8KccvAe/bZqNw8fVxsmacVtyynkLv1QKFtK
 L6sEpa/uXEILp+Ii5NyXVkUeFBGvymsWTPxDG
X-Google-Smtp-Source: AGHT+IH2UtkVxeCnNXnP/zEkhEtEVFpwHJy6YTw/aJesf5JnMmOPXZc8/sQXXObGH2bl3EUknyGifavhM1h2toou0UA=
X-Received: by 2002:a17:906:f598:b0:a9a:4cf:5cea with SMTP id
 a640c23a62f3a-a9de61e0011mr430469066b.54.1730049359993; Sun, 27 Oct 2024
 10:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:15:47 +0100
Message-ID: <CAFLszThR8r807vBh+L7XiPYWr_S7MeWEZLcQbvFbMQ1oN_bjPg@mail.gmail.com>
Subject: Re: [PATCH 1/4] imx: imxrt*: Fix binman breaking boot
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>
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

On Fri, 25 Oct 2024 at 04:02, Jesse Taube <mr.bossman075@gmail.com> wrote:
>
> The init_r parsing of U-Boot device tree to search the binman
> information errors. set CONFIG_BINMAN_FDT to no to fix this.
>
> Fixes: 7079eeb72fc ("imx: imxrt1050-evk: Add support for SPI flash booting
> s")
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  configs/imxrt1020-evk_defconfig      | 1 +
>  configs/imxrt1050-evk_defconfig      | 1 +
>  configs/imxrt1050-evk_fspi_defconfig | 1 +
>  configs/imxrt1170-evk_defconfig      | 1 +
>  4 files changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Hmm, so why is the binman node missing?



>
> diff --git a/configs/imxrt1020-evk_defconfig b/configs/imxrt1020-evk_defconfig
> index 5865d41a741..58a3e92ce08 100644
> --- a/configs/imxrt1020-evk_defconfig
> +++ b/configs/imxrt1020-evk_defconfig
> @@ -67,6 +67,7 @@ CONFIG_FSL_LPUART=y
>  CONFIG_TIMER=y
>  CONFIG_SPL_TIMER=y
>  CONFIG_IMX_GPT_TIMER=y
> +# CONFIG_BINMAN_FDT is not set
>  CONFIG_SHA1=y
>  CONFIG_SHA256=y
>  CONFIG_HEXDUMP=y
> diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
> index f8b85398b79..2653efac148 100644
> --- a/configs/imxrt1050-evk_defconfig
> +++ b/configs/imxrt1050-evk_defconfig
> @@ -84,5 +84,6 @@ CONFIG_VIDEO_MXS=y
>  CONFIG_SPLASH_SCREEN=y
>  CONFIG_SPLASH_SCREEN_ALIGN=y
>  CONFIG_BMP_16BPP=y
> +# CONFIG_BINMAN_FDT is not set
>  CONFIG_SHA256=y
>  CONFIG_HEXDUMP=y
> diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
> index 73001ffe161..95b5b56ece7 100644
> --- a/configs/imxrt1050-evk_fspi_defconfig
> +++ b/configs/imxrt1050-evk_fspi_defconfig
> @@ -85,6 +85,7 @@ CONFIG_VIDEO_MXS=y
>  CONFIG_SPLASH_SCREEN=y
>  CONFIG_SPLASH_SCREEN_ALIGN=y
>  CONFIG_BMP_16BPP=y
> +# CONFIG_BINMAN_FDT is not set
>  CONFIG_SHA256=y
>  CONFIG_HEXDUMP=y
>  CONFIG_FSPI_CONF_HEADER=y
> diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
> index 5f28c22e66c..487da275c62 100644
> --- a/configs/imxrt1170-evk_defconfig
> +++ b/configs/imxrt1170-evk_defconfig
> @@ -68,3 +68,4 @@ CONFIG_FSL_LPUART=y
>  CONFIG_TIMER=y
>  CONFIG_SPL_TIMER=y
>  CONFIG_IMX_GPT_TIMER=y
> +# CONFIG_BINMAN_FDT is not set
> --
> 2.45.2
>
