Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131AC27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 05:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC6F87DB0;
	Wed, 12 Jun 2024 07:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yc/wg01H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399CC882BE; Wed, 12 Jun 2024 07:51:36 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC32387702
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 07:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c2fe7f07c4so2898473a91.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718171492; x=1718776292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E064ZrXBJOZmccm2FMGhkq+XIUtogoWndzTnuFys4LM=;
 b=Yc/wg01HZIxCLyWfo4dFhQb4P6qGGGVxhvNc8mI/FmNxDKeCCi7tdxuF1yigvPmZWD
 M2IEKDPdlonoXlqbJUp1tESfqhDewJbIPc54ZClepUKkpzaVxU5ItWtKNMG6NyzlMLmy
 z4XS2Mhbs5pr/LDGx2T/40hR63BmQ/nZ1TK4f2EQ/rVUhMM86LyJqEeu0vwiOcTA2d9x
 mmqWVSDfLzxEOpWjVfKKxgDrCb75oTcN2Cf/nquA7uo6Cg9mwEhcCJruw/vsPmGDV8nI
 rUxMaxBVLuHXdRCBdlcPZomqP5jF0eBRAv2vU7jDO+z+4EPyZsD6OP0CXgksGUVDzEuC
 Ih0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718171492; x=1718776292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E064ZrXBJOZmccm2FMGhkq+XIUtogoWndzTnuFys4LM=;
 b=uIHQqv3Tej8+eUWdWvOl68ZHnNxxaRgtvT7ReM2cTpfiPtLCv4l2X61/0lwDxM9sKn
 ZNYtz3KkktdmLkd14/SiF0ng0ztW4uDPUcHneauxq8c1XzquRjGsFCv+FtnBDUlw7pQO
 tjNap8iXClr02HLJUDjqP8CQ2dhlwFPUf9esKZfdCCgmuxGTQirGKN94VIEm5gU+5hmy
 077I2k/u1Sav3K54Holdo6a6w22JP4BMGraqqhLOe6Xl8wQ42sl4H4eG/yzVbyppVAz4
 IPhSk1LIfokVv1WXGyrNlywNQbhIRrzA8TPP1oYcYFQYYzpmCAeoIdfRLBMfZy5na20w
 5MLg==
X-Gm-Message-State: AOJu0YxL1MJWY5rf5EwQ4igxCQKV3EEp1W7aNTsCstCV0H5qz7gkUA/w
 nDtXFwtW49fdVIp+1Wsu1Md51aZJah/fDd/Xo9WqAzC+zTja0Q9s/QJck/xPmw3bIpXMA/8SBau
 VwApnfn4KNWJnSo9zwCoYbpi3NQnGqk1qrJsb8g==
X-Google-Smtp-Source: AGHT+IHB4KXZBFDCEcMwvFcJJKdqv0gWZc2v6yiCnu149J7mutiAsHt0FgACi9PHv7KeP9o2v+AjrmLKbce/HXUj6mw=
X-Received: by 2002:a17:90a:3fcf:b0:2c2:c79f:976a with SMTP id
 98e67ed59e1d1-2c4a76e103emr866876a91.32.1718171492387; Tue, 11 Jun 2024
 22:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-18-sjg@chromium.org>
In-Reply-To: <20240611200156.2245525-18-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Jun 2024 08:50:56 +0300
Message-ID: <CAC_iWjJKYLRx18ZdfCUnnaC-iu5SotiywrfFnCm7msbff0YqVg@mail.gmail.com>
Subject: Re: [PATCH 17/42] google: Disable TPMv2 on most Chromebooks
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Allen Martin <amartin@nvidia.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
>
> This feature is not present on older Chromebooks, so disable the
> setting.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  configs/chromebook_link64_defconfig    | 1 +
>  configs/chromebook_link_defconfig      | 1 +
>  configs/chromebook_samus_defconfig     | 1 +
>  configs/chromebook_samus_tpl_defconfig | 1 +
>  configs/nyan-big_defconfig             | 4 +---
>  configs/snow_defconfig                 | 1 +
>  6 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/configs/chromebook_link64_defconfig b/configs/chromebook_link64_defconfig
> index 7cf23b29e46..9583f87bf0f 100644
> --- a/configs/chromebook_link64_defconfig
> +++ b/configs/chromebook_link64_defconfig
> @@ -80,6 +80,7 @@ CONFIG_SYS_NS16550=y
>  CONFIG_SYS_NS16550_PORT_MAPPED=y
>  CONFIG_SPI=y
>  CONFIG_TPM_TIS_LPC=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_KEYBOARD=y
>  CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
> diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
> index a9f91dd9b26..75a7a488a92 100644
> --- a/configs/chromebook_link_defconfig
> +++ b/configs/chromebook_link_defconfig
> @@ -70,6 +70,7 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
>  CONFIG_SOUND=y
>  CONFIG_SPI=y
>  CONFIG_TPM_TIS_LPC=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_KEYBOARD=y
>  CONFIG_VIDEO_COPY=y
> diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
> index 40cc449b9b3..8cdad8d2344 100644
> --- a/configs/chromebook_samus_defconfig
> +++ b/configs/chromebook_samus_defconfig
> @@ -74,6 +74,7 @@ CONFIG_SOUND_I8254=y
>  CONFIG_SOUND_RT5677=y
>  CONFIG_SPI=y
>  CONFIG_TPM_TIS_LPC=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_KEYBOARD=y
>  CONFIG_VIDEO_COPY=y
> diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
> index 3e7298f16af..1be57560f89 100644
> --- a/configs/chromebook_samus_tpl_defconfig
> +++ b/configs/chromebook_samus_tpl_defconfig
> @@ -96,6 +96,7 @@ CONFIG_SOUND_RT5677=y
>  CONFIG_SPI=y
>  CONFIG_TPL_SYSRESET=y
>  CONFIG_TPM_TIS_LPC=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_KEYBOARD=y
>  CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
> diff --git a/configs/nyan-big_defconfig b/configs/nyan-big_defconfig
> index 4dec710cf8d..78fb7580da7 100644
> --- a/configs/nyan-big_defconfig
> +++ b/configs/nyan-big_defconfig
> @@ -11,8 +11,6 @@ CONFIG_DEFAULT_DEVICE_TREE="tegra124-nyan-big"
>  CONFIG_SPL_TEXT_BASE=0x80108000
>  CONFIG_SPL_STACK=0x800ffffc
>  CONFIG_BOOTSTAGE_STASH_ADDR=0x83000000
> -CONFIG_DEBUG_UART_BASE=0x70006000
> -CONFIG_DEBUG_UART_CLOCK=408000000
>  CONFIG_TEGRA124=y
>  CONFIG_TARGET_NYAN_BIG=y
>  CONFIG_TEGRA_GPU=y
> @@ -75,7 +73,6 @@ CONFIG_DM_REGULATOR=y
>  CONFIG_REGULATOR_AS3722=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_PWM_TEGRA=y
> -CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550=y
>  CONFIG_SOUND=y
>  CONFIG_I2S=y
> @@ -83,6 +80,7 @@ CONFIG_I2S_TEGRA=y
>  CONFIG_SOUND_MAX98090=y
>  CONFIG_TEGRA114_SPI=y
>  CONFIG_TPM_TIS_INFINEON=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_TEGRA=y
> diff --git a/configs/snow_defconfig b/configs/snow_defconfig
> index 3a617c6cf40..2c0757194bd 100644
> --- a/configs/snow_defconfig
> +++ b/configs/snow_defconfig
> @@ -88,6 +88,7 @@ CONFIG_SOUND_MAX98095=y
>  CONFIG_SOUND_WM8994=y
>  CONFIG_EXYNOS_SPI=y
>  CONFIG_TPM_TIS_INFINEON=y
> +# CONFIG_TPM_V2 is not set
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
