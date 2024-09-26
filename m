Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65892CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2B188F57;
	Fri, 27 Sep 2024 00:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kK9jBTHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3964F88F66; Fri, 27 Sep 2024 00:11:04 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0D188F08
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9d2195eso1797191a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727388659; x=1727993459; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nk2Lc4aHnR2kKG9TDt4Egqg6BFCqZ0yyu6evtYpqgm8=;
 b=kK9jBTHIN5uZXgLG+H6hUwDJ2jb6YjN51BF6EFjggxAbYrNzJTFYTFN+RvkhOvP4q/
 dGPZpC25/gdt9h/j/slpWhZ5UvbTxMI+qoU0hrDD1158Ia8Y/zgPRwGzR3jOI0xUb4Cu
 V4Jx8i1/Pp9+rm23vkYSeW5ziBWHkZ2rqWA3Z/eGR4JQkTk9oM2gpL6JM573MTRnKxc8
 IOvwXQ2eHYpvUM1CPIJAvRJK2UiVj/mIGGFrnAulpU+nxDKIwJxX476sdLVMQPUpqj+r
 nPxPHQ2eo3Z1UlY9ejFfnLk8t4CJ8x2Qy6PmLOd7hoteSm1p7VJzco7GTahDr51yIbEy
 WCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388659; x=1727993459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk2Lc4aHnR2kKG9TDt4Egqg6BFCqZ0yyu6evtYpqgm8=;
 b=FjYjE+xS00YdAie67FntpYaX8SKPc+nNfhfjNw+XJh9NJlwa0vWv5dWsCqGl3mLRAO
 Nzr5/iO2mUXsYG5x1leItekIrZBeItbCvFEbLCrZAxLmLtu9TA0pKMGu6iS7TINfA67K
 oTBqWT8SA7NR6dD3L4s6GOhfZu86Ziiz86lrMbhzA82NgahKD/tu6ZXRU3tQlX+vVhX4
 kowIvcuTUcksqTRmvo46+jES2eiC51Vz8qusssDZ8QP/Zk7mJ3I2rSFAhuI9/uSUWJwI
 2CFq+bIdncLX0gPyIZ9+g8pyDZroedUw0Mj+1z5nUc0m+o/IB3wYT0Qd8fkSi//sGIsw
 bPyw==
X-Gm-Message-State: AOJu0YzdIoxBf2j+jrUG4lMnRUQDg2mERPJrGx2EyjmANP2HyigPlaV2
 h14wFTFrV251BkHiOK5kjDtAgmITw1QFzKm4zplblwKqFGZBFAavYQ1Lqxd3aHc4FWi4mNrUeeU
 nR2os1u/CE6dUT7Wt1JacZH/DuVU=
X-Google-Smtp-Source: AGHT+IHumU6Qi2rbqThu06W0oJPs7FoPTMudewoc9j/ZTffobbo8int2IQdfRHmKzU+zeuZcM5oPkYFbZjC/fGtepmA=
X-Received: by 2002:a50:cc03:0:b0:5c8:79fa:2e4f with SMTP id
 4fb4d7f45d1cf-5c8826084cfmr841253a12.32.1727388658763; Thu, 26 Sep 2024
 15:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-18-patrick.rudolph@9elements.com>
In-Reply-To: <20240926080021.148031-18-patrick.rudolph@9elements.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 26 Sep 2024 15:10:46 -0700
Message-ID: <CAJaLiFxN_2=NTq0cSUe2TUXm+8XjZ-o=ga4svihsZAPWiRpfNA@mail.gmail.com>
Subject: Re: [PATCH v5 17/36] drivers: ata: Rename ahci_mvebu
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Dennis Gilmore <dgilmore@redhat.com>, 
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>, 
 Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
 Aaron Williams <awilliams@marvell.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Sep 26, 2024 at 1:02=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Rename 'ahci_mvebu' to 'ahci_generic' and select it by default.
> The AHCI driver contains no SoC specific code and only expects the
> base address to be passed, thus rename it to ahci_generic and add the
> DT compatible string "generic-ahci".
>
> Update existing defconfigs to use the new Kconfig name as well.
>
> TEST: Booted on QEMU sbsa using the generic-ahci node.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Reviewed-by: Stefan Roese <sr@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Stefan Roese <sr@denx.de>

For Synology ds116 and Thecus n2350 boards,
Acked-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  MAINTAINERS                                     |  2 +-
>  configs/clearfog_defconfig                      |  2 +-
>  configs/clearfog_gt_8k_defconfig                |  2 +-
>  configs/clearfog_sata_defconfig                 |  2 +-
>  configs/clearfog_spi_defconfig                  |  2 +-
>  configs/db-88f6820-gp_defconfig                 |  2 +-
>  configs/ds116_defconfig                         |  2 +-
>  configs/helios4_defconfig                       |  2 +-
>  configs/mvebu_crb_cn9130_defconfig              |  2 +-
>  configs/mvebu_db-88f3720_defconfig              |  2 +-
>  configs/mvebu_db_armada8k_defconfig             |  2 +-
>  configs/mvebu_db_cn9130_defconfig               |  2 +-
>  configs/mvebu_espressobin-88f3720_defconfig     |  2 +-
>  .../mvebu_espressobin_ultra-88f3720_defconfig   |  2 +-
>  configs/mvebu_mcbin-88f8040_defconfig           |  2 +-
>  configs/mvebu_puzzle-m801-88f8040_defconfig     |  2 +-
>  configs/n2350_defconfig                         |  2 +-
>  configs/octeon_nic23_defconfig                  |  2 +-
>  configs/turris_omnia_defconfig                  |  2 +-
>  drivers/ata/Kconfig                             | 12 +++++++-----
>  drivers/ata/Makefile                            |  2 +-
>  drivers/ata/{ahci_mvebu.c =3D> ahci_generic.c}    | 17 +++++++++--------
>  22 files changed, 36 insertions(+), 33 deletions(-)
>  rename drivers/ata/{ahci_mvebu.c =3D> ahci_generic.c} (71%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2050ae24df..d3a0469ca1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -356,7 +356,7 @@ S:  Maintained
>  T:     git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
>  F:     arch/arm/mach-kirkwood/
>  F:     arch/arm/mach-mvebu/
> -F:     drivers/ata/ahci_mvebu.c
> +F:     drivers/ata/ahci_generic.c
>  F:     drivers/clk/mvebu/
>  F:     drivers/ddr/marvell/
>  F:     drivers/gpio/mvebu_gpio.c
> diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
> index 62dbf2aa48..9cb4753685 100644
> --- a/configs/clearfog_defconfig
> +++ b/configs/clearfog_defconfig
> @@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_DM_PCA953X=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/clearfog_gt_8k_defconfig b/configs/clearfog_gt_8k_de=
fconfig
> index df7e04a75b..66eb5e2407 100644
> --- a/configs/clearfog_gt_8k_defconfig
> +++ b/configs/clearfog_gt_8k_defconfig
> @@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defc=
onfig
> index 41382f995d..b1e1fc75dd 100644
> --- a/configs/clearfog_sata_defconfig
> +++ b/configs/clearfog_sata_defconfig
> @@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_DM_PCA953X=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defcon=
fig
> index f345b12e6c..64f862d298 100644
> --- a/configs/clearfog_spi_defconfig
> +++ b/configs/clearfog_spi_defconfig
> @@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_DM_PCA953X=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/db-88f6820-gp_defconfig b/configs/db-88f6820-gp_defc=
onfig
> index ee8cb8ae66..16417a4e12 100644
> --- a/configs/db-88f6820-gp_defconfig
> +++ b/configs/db-88f6820-gp_defconfig
> @@ -58,7 +58,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_SYS_I2C_LEGACY=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/ds116_defconfig b/configs/ds116_defconfig
> index 1173e3a0f6..d687be2d5b 100644
> --- a/configs/ds116_defconfig
> +++ b/configs/ds116_defconfig
> @@ -65,7 +65,7 @@ CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_NETCONSOLE=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
> index 29b6230e90..c0ae1de264 100644
> --- a/configs/helios4_defconfig
> +++ b/configs/helios4_defconfig
> @@ -52,7 +52,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_DM_PCA953X=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
> diff --git a/configs/mvebu_crb_cn9130_defconfig b/configs/mvebu_crb_cn913=
0_defconfig
> index 4d5f575b03..d253fe88d6 100644
> --- a/configs/mvebu_crb_cn9130_defconfig
> +++ b/configs/mvebu_crb_cn9130_defconfig
> @@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f372=
0_defconfig
> index b955abb31e..1e9332c845 100644
> --- a/configs/mvebu_db-88f3720_defconfig
> +++ b/configs/mvebu_db-88f3720_defconfig
> @@ -43,7 +43,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_CLK=3Dy
> diff --git a/configs/mvebu_db_armada8k_defconfig b/configs/mvebu_db_armad=
a8k_defconfig
> index 6913796c01..a9b76a3843 100644
> --- a/configs/mvebu_db_armada8k_defconfig
> +++ b/configs/mvebu_db_armada8k_defconfig
> @@ -42,7 +42,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/mvebu_db_cn9130_defconfig b/configs/mvebu_db_cn9130_=
defconfig
> index 9133e25b24..2c345f7436 100644
> --- a/configs/mvebu_db_cn9130_defconfig
> +++ b/configs/mvebu_db_cn9130_defconfig
> @@ -47,7 +47,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_SYS_MMC_ENV_DEV=3D1
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_GPIO_LOOKUP_LABEL=3Dy
> diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_=
espressobin-88f3720_defconfig
> index 7ecf5ab0d6..c7015c9b13 100644
> --- a/configs/mvebu_espressobin-88f3720_defconfig
> +++ b/configs/mvebu_espressobin-88f3720_defconfig
> @@ -54,7 +54,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_AHCI_PCI=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_CLK=3Dy
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/=
mvebu_espressobin_ultra-88f3720_defconfig
> index 974b6df165..0a4329d786 100644
> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -53,7 +53,7 @@ CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_AHCI_PCI=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_CLK=3Dy
> diff --git a/configs/mvebu_mcbin-88f8040_defconfig b/configs/mvebu_mcbin-=
88f8040_defconfig
> index eef612a261..8bb26bd3d6 100644
> --- a/configs/mvebu_mcbin-88f8040_defconfig
> +++ b/configs/mvebu_mcbin-88f8040_defconfig
> @@ -46,7 +46,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/mvebu_puzzle-m801-88f8040_defconfig b/configs/mvebu_=
puzzle-m801-88f8040_defconfig
> index b00e92908b..db7881c3fc 100644
> --- a/configs/mvebu_puzzle-m801-88f8040_defconfig
> +++ b/configs/mvebu_puzzle-m801-88f8040_defconfig
> @@ -49,7 +49,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_ARP_TIMEOUT=3D200
>  CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_PCA953X=3Dy
> diff --git a/configs/n2350_defconfig b/configs/n2350_defconfig
> index e7d7deabfe..b6fc333906 100644
> --- a/configs/n2350_defconfig
> +++ b/configs/n2350_defconfig
> @@ -65,7 +65,7 @@ CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NET_RANDOM_ETHADDR=3Dy
>  CONFIG_NETCONSOLE=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_DM_I2C=3Dy
> diff --git a/configs/octeon_nic23_defconfig b/configs/octeon_nic23_defcon=
fig
> index 5a8db5a087..d19d459555 100644
> --- a/configs/octeon_nic23_defconfig
> +++ b/configs/octeon_nic23_defconfig
> @@ -46,7 +46,7 @@ CONFIG_EFI_PARTITION=3Dy
>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>  CONFIG_TFTP_TSIZE=3Dy
>  CONFIG_SATA=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_LBA48=3Dy
>  CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_CLK=3Dy
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defcon=
fig
> index 93f0bc53f9..85c71f2eef 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -90,7 +90,7 @@ CONFIG_NET_RETRY_COUNT=3D50
>  CONFIG_NETCONSOLE=3Dy
>  CONFIG_SPL_OF_TRANSLATE=3Dy
>  CONFIG_AHCI_PCI=3Dy
> -CONFIG_AHCI_MVEBU=3Dy
> +CONFIG_AHCI_GENERIC=3Dy
>  CONFIG_DM_PCA953X=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_MV=3Dy
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6cca561f97..4fbb63a148 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -78,14 +78,16 @@ config MTK_AHCI
>           Enable this driver to support Sata devices through
>           Mediatek AHCI controller (e.g. MT7622).
>
> -config AHCI_MVEBU
> -       bool "Marvell EBU AHCI SATA support"
> -       depends on ARCH_MVEBU || ARCH_OCTEON
> +config AHCI_GENERIC
> +       bool "Generic AHCI SATA support"
> +       depends on OF_CONTROL
>         select SCSI_AHCI
>         select SCSI
>         help
> -         This option enables support for the Marvell EBU SoC's
> -         onboard AHCI SATA.
> +         This option enables support for generic onboard AHCI SATA contr=
oller
> +         that do not need platform specific quirks, like emulated device=
s,
> +         Marvell EBU SoC's onboard AHCI SATA controllers or Cavium's Oct=
eon
> +         7130 AHCI controllers.
>
>           If unsure, say N.
>
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index af6f0bf278..507bf84c14 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -14,6 +14,6 @@ obj-$(CONFIG_SATA) +=3D sata.o sata_bootdev.o
>  obj-$(CONFIG_SATA_CEVA) +=3D sata_ceva.o
>  obj-$(CONFIG_SATA_MV) +=3D sata_mv.o
>  obj-$(CONFIG_SATA_SIL) +=3D sata_sil.o
> -obj-$(CONFIG_AHCI_MVEBU) +=3D ahci_mvebu.o
> +obj-$(CONFIG_AHCI_GENERIC) +=3D ahci_generic.o
>  obj-$(CONFIG_SUNXI_AHCI) +=3D ahci_sunxi.o
>  obj-$(CONFIG_MTK_AHCI) +=3D mtk_ahci.o
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_generic.c
> similarity index 71%
> rename from drivers/ata/ahci_mvebu.c
> rename to drivers/ata/ahci_generic.c
> index f6e2d6bee4..6e5a6cbafd 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_generic.c
> @@ -16,7 +16,7 @@ __weak int board_ahci_enable(void)
>         return 0;
>  }
>
> -static int mvebu_ahci_bind(struct udevice *dev)
> +static int generic_ahci_bind(struct udevice *dev)
>  {
>         struct udevice *scsi_dev;
>         int ret;
> @@ -30,7 +30,7 @@ static int mvebu_ahci_bind(struct udevice *dev)
>         return 0;
>  }
>
> -static int mvebu_ahci_probe(struct udevice *dev)
> +static int generic_ahci_probe(struct udevice *dev)
>  {
>         /*
>          * Board specific SATA / AHCI enable code, e.g. enable the
> @@ -43,18 +43,19 @@ static int mvebu_ahci_probe(struct udevice *dev)
>         return 0;
>  }
>
> -static const struct udevice_id mvebu_ahci_ids[] =3D {
> +static const struct udevice_id generic_ahci_ids[] =3D {
>         { .compatible =3D "marvell,armada-380-ahci" },
>         { .compatible =3D "marvell,armada-3700-ahci" },
>         { .compatible =3D "marvell,armada-8k-ahci" },
>         { .compatible =3D "cavium,octeon-7130-ahci" },
> +       { .compatible =3D "generic-ahci" },
>         { }
>  };
>
> -U_BOOT_DRIVER(ahci_mvebu_drv) =3D {
> -       .name           =3D "ahci_mvebu",
> +U_BOOT_DRIVER(ahci_generic_drv) =3D {
> +       .name           =3D "ahci_generic",
>         .id             =3D UCLASS_AHCI,
> -       .of_match       =3D mvebu_ahci_ids,
> -       .bind           =3D mvebu_ahci_bind,
> -       .probe          =3D mvebu_ahci_probe,
> +       .of_match       =3D generic_ahci_ids,
> +       .bind           =3D generic_ahci_bind,
> +       .probe          =3D generic_ahci_probe,
>  };
> --
> 2.46.0
>
