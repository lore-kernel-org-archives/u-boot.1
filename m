Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF06C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6054E82ABA;
	Tue, 29 Apr 2025 19:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7407A82A7B; Tue, 29 Apr 2025 19:42:57 +0200 (CEST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC22F829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wens213@gmail.com
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-54e7967cf67so6648600e87.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745948569; x=1746553369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyIVp0NR4LgxbTW0cOVVe0R3nWHYou2tSFJ31wSexQc=;
 b=vp1RdHff7FJzywzPl03OUOX3dH7nF077kaumlveQDcP4PAliBcCM4ScImn7FG+Ougd
 p2EMEHn/X+JXXc0L2TXjaZnTa3OD1RgxZsriZwsPiMwHFKdtrstmG/GctVnTI1zZVkk+
 ON7802hre0MrNTxe+7YkSk3B2pP2mMxD9ULpdegY+6vQ6wB3sLG6cWETW1YBX77gSA3b
 KgzCPWSQx8FLitKFUaslg6LE5N5ypZJHFxwJV8OB8LKgQpP+7Yp738g9+2ECX+Cr4sUj
 v14OKJA7Uq5XQDkdYtAcBhzAB/du3Tt2cQeIfzZZ58XnSjVO8LJ2G8j4KUsBEXBvGcPC
 cFIw==
X-Gm-Message-State: AOJu0YwqbconuAOZbov+DCWo5YJ8IAxc+fBo1UgrZc6HGhGW00XrLb9K
 bUz7mZFDx8LYPRrGGEmypbe/+2d+7rgaMRAf+OnmG/rITPAqlRTlCY0HS7g3SvE=
X-Gm-Gg: ASbGncvgfJ7cdEMojP/mDmdAYQeZQP+1SLUMkfwwy5oRVueNeaQr5kfszj+wnU1Y8t5
 HpQ/3almsvsREgiX1YIFHdacOL/gvATVaUSWtXpIFiundp5xd3CIn8GoJvDEFPhREuNNgUB3fqM
 35CjxAkbGhe23Lh4fxEePrJ2UeH3GG1JQu6ueGZ3yVhWJ34qcRZHpY8hrgu+isLrh+X0oW7c7/t
 PWP8PihWGjoFNNtQxKh1ivHqY27G8aX7iRtrTyY452nHTMSzf3qoS/Ihn5/hVtYR5qWuYjHh1Ot
 DcTLgI2570n+ddAcoEGw3EyCMtTUWtr+cs7LdiC95qxaXzg1+AHMu5FeRkNJPdTGh786X4Dl/w=
 =
X-Google-Smtp-Source: AGHT+IEy7EvcRdzZaR9lJkwd1I2sPBSu8oEVUqP601YNGG5Y5OlBuiL5OSR4AD5grheG+EleFo8WFQ==
X-Received: by 2002:a05:6512:ac4:b0:54d:662b:c8a9 with SMTP id
 2adb3069b0e04-54ea336f40cmr17297e87.25.1745948568856; 
 Tue, 29 Apr 2025 10:42:48 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54e7ccb8055sm1894287e87.234.2025.04.29.10.42.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:42:48 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3105ef2a08dso59427901fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 10:42:47 -0700 (PDT)
X-Received: by 2002:a05:651c:b14:b0:30d:e104:9ad3 with SMTP id
 38308e7fff4ca-31e6bb7a8f2mr168281fa.40.1745948566804; Tue, 29 Apr 2025
 10:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250429174125.2194499-1-wens@kernel.org>
In-Reply-To: <20250429174125.2194499-1-wens@kernel.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 30 Apr 2025 01:42:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65juY8iC6y_dgMJ6HzrFX5A+7pvDyZSvasjEu9c0o37dg@mail.gmail.com>
X-Gm-Features: ATxdqUE-vabw961PGNhIfXNjqpzG4Lw8TYqOIm1aYVJRWJm3_KsczeEJCHv7Xw4
Message-ID: <CAGb2v65juY8iC6y_dgMJ6HzrFX5A+7pvDyZSvasjEu9c0o37dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all
 supported SoCs
To: u-boot@lists.denx.de
Cc: Andy Yan <andyshrk@163.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Maksim Kiselev <bigunclemax@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:44:02 +0200
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
Reply-To: wens@csie.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Please ignore this. I accidentally sent out the patches with incorrect
patman tags.


ChenYu

On Wed, Apr 30, 2025 at 1:41=E2=80=AFAM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
> SoCs. This controller is used for the SD card on all SoCs and eMMC on
> older SoCs. Almost all defconfigs for Rockchip platforms have this
> enabled.
>
> Enable it by default for all supported Rockchip SoCs. Disable it
> explicitly in defconfigs that previously didn't have it enabled. Of
> these, only the Cool Pi GenBook w/ CM5 doesn't actually use the
> controller. The other two, the Geekbox and the RV1108 EVB, both have
> MMC enabled in their device trees. With this patch, they will gain
> support for MMC automatically.
>
> Also limit the driver to Rockchip platforms only, like what is done for
> the other dw_mmc platform glue drivers.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> Changes in v2:
> - Made CONFIG_MMC_DW_ROCKCHIP depend on ARCH_ROCKCHIP
>
>  configs/coolpi-cm5-genbook-rk3588_defconfig | 1 +
>  drivers/mmc/Kconfig                         | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi=
-cm5-genbook-rk3588_defconfig
> index 3eb5dc968af6..92676ebb984a 100644
> --- a/configs/coolpi-cm5-genbook-rk3588_defconfig
> +++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
> @@ -65,6 +65,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=3Dy
>  CONFIG_SPL_MMC_HS400_ES_SUPPORT=3Dy
>  CONFIG_MMC_HS400_SUPPORT=3Dy
>  CONFIG_SPL_MMC_HS400_SUPPORT=3Dy
> +# CONFIG_MMC_DW is not set
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_SDMA=3Dy
>  CONFIG_MMC_SDHCI_ROCKCHIP=3Dy
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 6740591a6533..ec9e9d51fbf9 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -251,6 +251,7 @@ config MMC_DAVINCI
>  config MMC_DW
>         bool "Synopsys DesignWare Memory Card Interface"
>         select BOUNCE_BUFFER
> +       default y if ARCH_ROCKCHIP
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage=
 IP
>           block, this provides host support for SD and MMC interfaces, in=
 both
> @@ -286,6 +287,8 @@ config MMC_DW_ROCKCHIP
>         bool "Rockchip SD/MMC controller support"
>         depends on OF_CONTROL
>         depends on MMC_DW
> +       depends on ARCH_ROCKCHIP
> +       default y
>         help
>           This enables support for the Rockchip SD/MMM controller, which =
is
>           based on Designware IP. The device is compatible with at least
> --
> 2.39.5
>
