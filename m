Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7EAC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0476588019;
	Tue, 26 Mar 2024 13:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/VTOANf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29F38806A; Tue, 26 Mar 2024 13:32:33 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D3588019
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ea9a616cc4so1917170b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711456350; x=1712061150; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FwJ58MYA4EcAMl1I9dMxdZNkyXTrXuybLg4dXoDqZFw=;
 b=C/VTOANf33AmJ3FGWQRIhlFkBBG1OuNifx8bb4RZ0AjozoNCuyPha3htUrwqEd/8Ih
 4PFpfvLCtrA1oNwu0Dz302B9tOZZ43DEVbUrR7Qg4AsYhpzoC08Na6+DDmS36S6ZF4V0
 w7/vyy1J8ZNkFWlNHDzE1OwD8NKPgIyrDx5DJvvgmfLzYVrqhxFLI1CY7OfqogC1c/HA
 JiAQmif9NPYahRgr01JGx95AT9eB/9gG16f0h9pTqOGEucs08A1MOBSkYJv4W9fSM+8o
 YNsE1IhBqDEgHs2e68xRE4S8CSr6pKF0/A474cAUZAQOEAgoMwevAF/lfWdPCPVATke3
 wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456350; x=1712061150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwJ58MYA4EcAMl1I9dMxdZNkyXTrXuybLg4dXoDqZFw=;
 b=jO8bTLmAyWDNCmKkXzYhznk7P+FKOCS3b7lyluDu+GXDiNJmvYOk2ZcuhmTxYqHzBy
 c8PYwyMxTjxD3E/PnPpFlalWuHULiFcxL6Vi37NcpqyE0UrAHdAwgKs2tQiz7VvNhcWD
 CXfGmxYlp6YYlBBvamoqL+fUNJS5W3xEu1tyA75Cp9JlT45q2tRwixTKiUES5wL+tJgT
 J+MwsX+UtU2KUyDBmgPxo1R8FqWetUxH5B6QsfF+DDgrugqkPAkq50Jrk8m5oX2C3XI5
 SA3xXc04eEwBctvZpbjpOA3toeRZKge0boRtDmVIz/UIduWx/nETo6e9QnLU/L4dqo6S
 n5kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc8X796/f6g+m4TiTvu0FbWcCxALiop+4l+0H5cbJMZjTpaAPXFn65YKm00gdSCjCCFFzmWlPpi2Hwd+Z9E0YnW+xHZg==
X-Gm-Message-State: AOJu0Yx2pdT343hpfB8bAFXNZqeRQV0c2gsecobPI1sfPhvF3wF+CZCL
 hndEOWu+nVUHNA97m4xJo6wrc/Kk4kRSMolmNc1pFgnp13A2n+C6
X-Google-Smtp-Source: AGHT+IG4PTl93N3XOF+7JEjLg5GccLS4941r8ljuhxaXOO2Zhc6ek9JII9oe4hY+D44dUYkmMQwrRw==
X-Received: by 2002:a05:6a20:9586:b0:1a3:d2e0:f484 with SMTP id
 iu6-20020a056a20958600b001a3d2e0f484mr4374690pzb.39.1711456349912; 
 Tue, 26 Mar 2024 05:32:29 -0700 (PDT)
Received: from frhdebian ([201.82.41.210]) by smtp.gmail.com with ESMTPSA id
 si12-20020a17090b528c00b002a077966136sm2819507pjb.1.2024.03.26.05.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 05:32:29 -0700 (PDT)
Date: Tue, 26 Mar 2024 09:32:26 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, hiago.franco@toradex.com,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] imx8: Add a default reset_cpu() implementation
Message-ID: <20240326123226.ndqj25en2ts4wcky@frhdebian>
References: <20240326121949.1915850-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326121949.1915850-1-festevam@gmail.com>
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

On Tue, Mar 26, 2024 at 09:19:49AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Add a weak default reset_cpu() implementation just like
> it is done on arch/arm/mach-imx/cpu.c.
> 
> This allows the removal of the empty reset_cpu() in several
> board files.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Thanks Fabio!

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Colibri iMX8X

> ---
>  arch/arm/mach-imx/imx8/cpu.c                          |  4 ++++
>  board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c | 11 -----------
>  board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c |  8 --------
>  board/congatec/cgtqmx8/cgtqmx8.c                      |  7 -------
>  board/freescale/imx8qm_mek/imx8qm_mek.c               |  8 --------
>  board/freescale/imx8qxp_mek/imx8qxp_mek.c             |  8 --------
>  board/toradex/apalis-imx8/apalis-imx8.c               |  8 --------
>  board/toradex/colibri-imx8x/colibri-imx8x.c           |  8 --------
>  8 files changed, 4 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
> index 0b91e448a5d..6e643188f40 100644
> --- a/arch/arm/mach-imx/imx8/cpu.c
> +++ b/arch/arm/mach-imx/imx8/cpu.c
> @@ -84,6 +84,10 @@ static char *get_reset_cause(void)
>  	}
>  }
>  
> +__weak void reset_cpu(void)
> +{
> +}
> +
>  int arch_cpu_init(void)
>  {
>  #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
> diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> index 8b4d73052eb..56b7bdb57c9 100644
> --- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> +++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> @@ -136,17 +136,6 @@ void detail_board_ddr_info(void)
>  	puts("\nDDR    ");
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	puts("SCI reboot request");
> -
> -	while (1)
> -		putc('.');
> -}
> -
>  #ifdef CONFIG_OF_BOARD_SETUP
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> index 206ce7d5c13..7f766a688bb 100644
> --- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> +++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> @@ -112,14 +112,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
> -
>  int board_mmc_get_env_dev(int devno)
>  {
>  	return devno;
> diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
> index 26189ff66f5..3b01354bb6b 100644
> --- a/board/congatec/cgtqmx8/cgtqmx8.c
> +++ b/board/congatec/cgtqmx8/cgtqmx8.c
> @@ -371,13 +371,6 @@ void detail_board_ddr_info(void)
>  	puts("\nDDR    ");
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
>  
>  #ifdef CONFIG_OF_BOARD_SETUP
>  int ft_board_setup(void *blob, struct bd_info *bd)
> diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c b/board/freescale/imx8qm_mek/imx8qm_mek.c
> index d96d1d07bb1..2b209c8886f 100644
> --- a/board/freescale/imx8qm_mek/imx8qm_mek.c
> +++ b/board/freescale/imx8qm_mek/imx8qm_mek.c
> @@ -102,14 +102,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
> -
>  #ifdef CONFIG_OF_BOARD_SETUP
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> index 516cefd2f24..833bee55462 100644
> --- a/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> +++ b/board/freescale/imx8qxp_mek/imx8qxp_mek.c
> @@ -126,14 +126,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
> -
>  #ifdef CONFIG_OF_BOARD_SETUP
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
> index 49719f2f553..0f993e644d7 100644
> --- a/board/toradex/apalis-imx8/apalis-imx8.c
> +++ b/board/toradex/apalis-imx8/apalis-imx8.c
> @@ -291,14 +291,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
> -
>  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
> index 6fc8076163c..a507d666c07 100644
> --- a/board/toradex/colibri-imx8x/colibri-imx8x.c
> +++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
> @@ -140,14 +140,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -/*
> - * Board specific reset that is system reset.
> - */
> -void reset_cpu(void)
> -{
> -	/* TODO */
> -}
> -
>  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> -- 
> 2.34.1
> 
