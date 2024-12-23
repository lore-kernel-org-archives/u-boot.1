Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500D0E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 18:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C919680730;
	Mon, 23 Dec 2024 19:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJsvZRWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6C08074B; Mon, 23 Dec 2024 19:27:11 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F6780708
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 19:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d34030ebb2so1285963a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734978428; x=1735583228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uUnPgI7z2y8L6XdSX2KDShS+a8aVLKJLhGN9ysSw3Xc=;
 b=CJsvZRWVz7JphqzXs4MWlIy3eqVnKPwgzI+fw4U3qh/UAIGKz/Yqst9Pm5+wxGMIBW
 1Fzusuh70v9uL5nsh3hgP1lRnN1RAYQ6P1jU5QXOeGMQN2brynviItdyU1xn1CdlLIPB
 wEC7VwEw7HiSLzqGx+6TjinXxlKWmYF9juyWCK8ggD4yGWqNmGDnT5BJdnW6/nJuK+hJ
 BUCToMpHKGR5UOYVpAUxc73eA6DF580Z88ivRvnlf1+i9mWqas/Quyk+KejSZCGTXHgQ
 kmOF4PWjnZahCkK59hKGFqtVUGF1j0iD482nGnaF6lwiSMnLyv/182vIY2MgYpJU4tgo
 zCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734978428; x=1735583228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uUnPgI7z2y8L6XdSX2KDShS+a8aVLKJLhGN9ysSw3Xc=;
 b=QhNOLbplb7YCeNYae6g6PQSUE4TzzPzB2otFVEo8AibNG3nwk+W21ot5XdY97L9Vqa
 NKOHdtMVXR5L+3VQlSnqeLKJNGXxLOjsRmFYwU0bB2T/EKPG09mHr9fDVPP8fukPDe8u
 vSOpqpmIGRoTMCsclRJNEp8xEHGvkk/ifQ+D9mKd9r0INlWuxcqIMUV9fOZ1IuUEzn8R
 uWLujXEHmyTaXAAcBtUnaFpqaCE0upoTkJV009ibUoHvQSM76LUmCPzJdBbZQx5GHXk2
 d7G1S65w6itVVW5WQuvbiGPJRWJzGtuy3KgpSk6hF/aEzAj6rDMvow1NrVXmIB5Wk5GJ
 eFxA==
X-Gm-Message-State: AOJu0Yw/NidnThymrLK36gKZgzFaURvPjXvFhP//BR1djOeU561j5qjl
 PIPa1TMC2J+GPRgGiZyu7iomC1PG45Bs0w+ONtRoU34c6QPHo+oPRB1gsGSMka7Anzt4odhjhr8
 liE2+W+KjTeoXSAFzLdx3CNaY5QQ=
X-Gm-Gg: ASbGncvAvFJzq2I01ltQHV8ib5wo/FFlaoFyPCWbxkJRfHHyiRyA3R1lL/dZgI92Mcj
 iBPm4qbNVp2qOMIsn2WsuxK7NwdN0leXTfPT0OAZzBtldFwoZUXA=
X-Google-Smtp-Source: AGHT+IGNMqnAOVFzFxEg6vYwU6bNhpBZKXpGJfQkjnh/jn0QOY9ziX7kBpOhaI8lM4bJDUJ1xuKa2JOYvsVKwMkT2J4=
X-Received: by 2002:a05:6402:388a:b0:5d0:8106:aaf4 with SMTP id
 4fb4d7f45d1cf-5d81ddf80fcmr10624704a12.21.1734978428130; Mon, 23 Dec 2024
 10:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
In-Reply-To: <20241220222612.1757884-7-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 18:26:57 +0000
Message-ID: <CALeDE9PdSo_6DMBUVnyGAGc0eo+RfiwV61DA_fRJdP-RB2JeCw@mail.gmail.com>
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 20 Dec 2024 at 22:27, Tom Rini <trini@konsulko.com> wrote:

> Now that block drivers are all selecting the BLK symbol, there's no need
> for other options to be select'ing BLK so that other required
> functionality can be enabled. Remove these places.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>


> ---
>  arch/arm/Kconfig              | 4 ----
>  arch/arm/mach-exynos/Kconfig  | 4 ----
>  arch/arm/mach-imx/mx5/Kconfig | 2 +-
>  arch/arm/mach-s5pc1xx/Kconfig | 1 -
>  4 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ea256f687867..86b37e8d5f8d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1371,7 +1371,6 @@ config ARCH_VEXPRESS64
>         select PL01X_SERIAL
>         select OF_CONTROL
>         select CLK
> -       select BLK
>         select MTD_NOR_FLASH if MTD
>         select FLASH_CFI_DRIVER if MTD
>         select ENV_IS_IN_FLASH if MTD
> @@ -1981,7 +1980,6 @@ config ARCH_STM32
>
>  config ARCH_STI
>         bool "Support STMicroelectronics SoCs"
> -       select BLK
>         select CPU_V7A
>         select DM
>         select DM_RESET
> @@ -2028,7 +2026,6 @@ config ARCH_STM32MP
>
>  config ARCH_ROCKCHIP
>         bool "Support Rockchip SoCs"
> -       select BLK
>         select BINMAN if SPL_OPTEE || SPL
>         select DM
>         select DM_GPIO
> @@ -2116,7 +2113,6 @@ config TARGET_POMELO
>         select AHCI
>         select SCSI_AHCI
>         select AHCI_PCI
> -       select BLK
>         select PCI
>         select DM_PCI
>         select SCSI
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> index 7e6959510087..28193039cb84 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -18,7 +18,6 @@ config ARCH_EXYNOS4
>         bool "Exynos4 SoC family"
>         select BOARD_EARLY_INIT_F
>         select CPU_V7A
> -       select BLK
>         select MMC
>         help
>           Samsung Exynos4 SoC family are based on ARM Cortex-A9 CPU. There
> @@ -39,7 +38,6 @@ config ARCH_EXYNOS5
>         imply USB_ETHER_ASIX
>         imply USB_ETHER_RTL8152
>         imply USB_ETHER_SMSC95XX
> -       select BLK
>         select MMC
>
>         help
> @@ -51,7 +49,6 @@ config ARCH_EXYNOS7
>         bool "Exynos7 SoC family"
>         select ARM64
>         select BOARD_EARLY_INIT_F
> -       select BLK
>         select MMC
>         help
>           Samsung Exynos7 SoC family are based on ARM Cortex-A57 CPU or
> @@ -61,7 +58,6 @@ config ARCH_EXYNOS7
>  config ARCH_EXYNOS9
>         bool "Exynos9 SoC family"
>         select ARM64
> -       select BLK
>         select MMC
>         help
>           Samsung Exynos9 SoC family are based on ARMv8 Cortex CPU. There
> are
> diff --git a/arch/arm/mach-imx/mx5/Kconfig b/arch/arm/mach-imx/mx5/Kconfig
> index 4d1e07b14d32..0dfd68496875 100644
> --- a/arch/arm/mach-imx/mx5/Kconfig
> +++ b/arch/arm/mach-imx/mx5/Kconfig
> @@ -26,7 +26,7 @@ config TARGET_KP_IMX53
>         select DM_I2C
>         select DM_PMIC
>         select DM_SERIAL
> -       select BLK
> +       select DM_MMC
>         select DM_REGULATOR
>         select MMC
>         select MX53
> diff --git a/arch/arm/mach-s5pc1xx/Kconfig b/arch/arm/mach-s5pc1xx/Kconfig
> index b15b2e7b6a01..d8b85f80e631 100644
> --- a/arch/arm/mach-s5pc1xx/Kconfig
> +++ b/arch/arm/mach-s5pc1xx/Kconfig
> @@ -7,7 +7,6 @@ choice
>  config TARGET_S5P_GONI
>         bool "S5P Goni board"
>         select OF_CONTROL
> -       select BLK
>         select MISC_COMMON
>         select MMC
>
> --
> 2.43.0
>
>
