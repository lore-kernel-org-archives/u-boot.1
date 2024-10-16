Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D637DD1AD59
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64E2F88BC2;
	Wed, 16 Oct 2024 15:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tKuui/5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A4788B99; Wed, 16 Oct 2024 15:40:39 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A6088C4A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so4283769a91.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729086036; x=1729690836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pNrz2P8cHKuRmV5zNmo9QvZGA+ewi4v87elDAm3kX1Y=;
 b=tKuui/5bH1UHrrxDrd6KTkS/PaTfq2YMkWa+aovj/gPdUwGNFSmxRyd11c0rGoUeLL
 EWROZ/GZDZEG8wyT+Hf2DZn8WcLXzhDLYoo+nxzDMR9EcmiriJTfflNF/VOLcMSXYDUA
 e7oPlywPTZAQ/cukcdLYlqsCzPOtPO2t0CiLVrLLriw6OFpPxuBfRKmQ4hd87I5HNG8U
 8OCpqdGqvRrVT7F5wITNlEcEyFhWsgP2VXC3BzzoLfYRs0RQ/4idpJkx08ksFkMCh7A5
 XvmaZroWdZqOVrwcU4ge6oPR4HL6bijmD7pAE1VtIMyVJwslyEg1e0V88sgmd5vLvY0d
 vAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729086036; x=1729690836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNrz2P8cHKuRmV5zNmo9QvZGA+ewi4v87elDAm3kX1Y=;
 b=LurK00t9Qv+3XY72BPmDn0qPcJO+syRHJNkUgul5e5cxK/Iqcw0NQxfrfz+5YcqXxb
 jMkCf9/M26rmceUCNzi2i6qBVNdvuTO3Cs8fddkpB8jd8x2jpnONFMWLyeAADBlN+vOe
 SvX7XP/HAUrrflmdIEVxLLwHCVmI1Ax7+eV5COE9ccpJ8v8o36qgaXCLNxyr4ZW1ole7
 B5n5KGod4A8KpmEeD3+atpU/lmoTFtD3+Sp2LTbm3NuQU0WpTmRVu8NBKeBaeF5hJk2+
 6Jo0LM2PfBmtmN51uk4Ci1l5MDA3Xl5CYdmG0zhpw+2tR3Q4ib8X9W2GJ86a7bb+aiBB
 QGqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyArVPe6qKUZKcyY68/v+OhWpjNfb+wk0UgH/DoEJHiFAbqCYGDHN3JcvG4+UIlpWeY8253P0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4bojYYH+M695Z+jeJDmRK1pRWyZzuW/Rt1w/0GVEwpDWLBH+O
 vu20YObKGcT2ZJjkoGfXBPe5ihmeVw7U/vbj41Yp7jXZTfsRn7OKpNWeP/JdrWim6L2KlhULvyU
 Xua8sQrRSpsSx5Xp1ijbppOV0esKhlARwqSp2XQ==
X-Google-Smtp-Source: AGHT+IFOoYGn/nm/i+gO5+VvNaLxK4JFSgUBkvxTULBUwchN5VWMq0zonvC/sq8MGGZm2yAqNIO+/PtjC5XqD+0IBcc=
X-Received: by 2002:a17:90a:bf09:b0:2e0:d1fa:fdd7 with SMTP id
 98e67ed59e1d1-2e2f0d8dd21mr21475396a91.27.1729086036052; Wed, 16 Oct 2024
 06:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241016101739.62408-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241016101739.62408-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 16:39:59 +0300
Message-ID: <CAC_iWjKzAP-1s7=CPfhTgW8CynFboC8_H0FOa-VcJPu6z=j6GA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: avoid #ifdef in efi_setup.c
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
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

On Wed, 16 Oct 2024 at 13:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We prefer `if` over `#ifdef` in our code.
>
> Eliminate #ifdef statements in efi_setup.c.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_setup.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index a610e032d2f..aa59bc7779d 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -86,7 +86,6 @@ out:
>         return ret;
>  }
>
> -#ifdef CONFIG_EFI_SECURE_BOOT
>  /**
>   * efi_init_secure_boot - initialize secure boot state
>   *
> @@ -112,12 +111,6 @@ static efi_status_t efi_init_secure_boot(void)
>
>         return ret;
>  }
> -#else
> -static efi_status_t efi_init_secure_boot(void)
> -{
> -       return EFI_SUCCESS;
> -}
> -#endif /* CONFIG_EFI_SECURE_BOOT */
>
>  /**
>   * efi_init_capsule - initialize capsule update state
> @@ -302,9 +295,11 @@ efi_status_t efi_init_obj_list(void)
>         }
>
>         /* Secure boot */
> -       ret = efi_init_secure_boot();
> -       if (ret != EFI_SUCCESS)
> -               goto out;
> +       if (IS_ENABLED(CONFIG_EFI_SECURE_BOOT)) {
> +               ret = efi_init_secure_boot();
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       }
>
>         /* Indicate supported runtime services */
>         ret = efi_init_runtime_supported();
> @@ -322,11 +317,11 @@ efi_status_t efi_init_obj_list(void)
>                 if (ret != EFI_SUCCESS)
>                         goto out;
>         }
> -#ifdef CONFIG_NETDEVICES
> -       ret = efi_net_register();
> -       if (ret != EFI_SUCCESS)
> -               goto out;
> -#endif
> +       if (IS_ENABLED(CONFIG_NETDEVICES)) {
> +               ret = efi_net_register();
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       }
>         if (IS_ENABLED(CONFIG_ACPI)) {
>                 ret = efi_acpi_register();
>                 if (ret != EFI_SUCCESS)
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
