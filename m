Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB361C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 16:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5529387EF4;
	Mon, 18 Mar 2024 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZY060iQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1D7287EF4; Mon, 18 Mar 2024 17:14:36 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BD687B2A
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dee27acf7aso28642785ad.2
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710778472; x=1711383272; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rPlsPewhQT8qPhwr3DGiV/MrN7LBwECYJOvL9NcBew=;
 b=FZY060iQ9tdvez3+doNckT65F9wBPQ86DCMAKDe79hzIWa/Il4jY34DRbN0itkqamn
 aQvnXC64TdIiWvCVm0z/uav+wvuV0P5Zei8Km8OUIpGjTPQVnIjzrI4pHqxMzzw1rXxS
 lWwfVz8dY/mSDfPlI5LCRB2CwWp4WMMEMewc0k3NntJHiKqlqc8zpiGE3D80H2OwBBtw
 7ij+2U19NnvQUSGM2aj4NmNg3R90KfQxm9SkwdfZervhH1/F75qa8tauW9js59WkEIjA
 FZ+qL4pK84wdumU4L1OoSfgKYiyTp7lSoRarjXQVKzu3Jc4EwR20NIYZHwLT1RNClqwP
 DxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778472; x=1711383272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rPlsPewhQT8qPhwr3DGiV/MrN7LBwECYJOvL9NcBew=;
 b=GGThYsTuWnmAek5hPftI5MokBEjjPBP0FkYXM94lx/Flpgg8MUaUBlG55seDq/NFSn
 8xDXp1DVqiENIFl7qUXuspUmO2gm/sh0xnLEdFMrmuXvAeqAHtZLlLGXzEpfA0TLmkAW
 94wDIPeAn7zCw7AGgLzlOXLgWW05hEuuWQqc4C9Euax3sC5Nb+6hehsvdJ4wrnCCGMpi
 mf3n6INBbZIbRWl3w9uqcZBhZh+qoijTS9x9BI7TMZyfs0vzcP3dvCwUAa7p5eqmOpN6
 lQk+o8sMF0NujT7jPOrQRu0Fka9W1TTEzb1qfxRS4fQKnldQzXs5uUo8tia92kGf4ICC
 gM/Q==
X-Gm-Message-State: AOJu0YyMcvECemtT9J59ZwnZXfp8qrIT2sBgXq7ROZdNR7WEsMDuxW5f
 MrWrvbT2X2JLoeZzKNedrrmIwLsXYRvUPcY0FM0BbreEYYElYeTln4llRB1p4xT6SksVhYnXWRB
 2DghcGHchZKZTUsviJxeSMNB9KAg=
X-Google-Smtp-Source: AGHT+IEoD4A6BLjGtt14XEKuQy0axy5ggpP04Dd2KPuwguqLePExX8RzN8UOb2zdGKQQJT5mD7rtel2YmvODmRBabMg=
X-Received: by 2002:a17:90a:aa02:b0:29d:f554:4509 with SMTP id
 k2-20020a17090aaa0200b0029df5544509mr9308482pjq.0.1710778472198; Mon, 18 Mar
 2024 09:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
 <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 18 Mar 2024 11:14:20 -0500
Message-ID: <CAHCN7x+b1XZKhQzOcLm9bj+sAbB_JVU8_c7MYxKb7CRKpPau4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: renesas: Switch to using upstream DT on
 64bit Renesas SoCs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Mon, Mar 18, 2024 at 10:00=E2=80=AFAM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
> DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
> dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
> directory.
>
> The configuration update has been done using the following script:
> ```
> sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@=3D"@&renesas/@' `git grep -li re=
nesas configs`
> sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas config=
s`
> ```
>
> There are SoCs which are not included in this patch. The 32bit SoCs
> require further infrastructure work. R8A779H0 is coming during the
> next upstream DT synchronization cycle as it is not included in
> current upstream DTs yet.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

LTGM!  Thanks for doing that.  I was going to do that after the April
release was done, but you beat me to it.

Reviewed-by:  Adam Ford <aford173@gmail.com> # Beacon boards

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-renesas/Kconfig         | 1 +
>  configs/hihope_rzg2_defconfig         | 4 ++--
>  configs/r8a77970_eagle_defconfig      | 2 +-
>  configs/r8a77970_v3msk_defconfig      | 2 +-
>  configs/r8a77980_condor_defconfig     | 2 +-
>  configs/r8a77980_v3hsk_defconfig      | 2 +-
>  configs/r8a77990_ebisu_defconfig      | 2 +-
>  configs/r8a77995_draak_defconfig      | 2 +-
>  configs/r8a779a0_falcon_defconfig     | 2 +-
>  configs/r8a779f0_spider_defconfig     | 2 +-
>  configs/r8a779g0_whitehawk_defconfig  | 2 +-
>  configs/r8a779h0_grayhawk_defconfig   | 1 +
>  configs/rcar3_salvator-x_defconfig    | 4 ++--
>  configs/rcar3_ulcb_defconfig          | 4 ++--
>  configs/renesas_rzg2l_smarc_defconfig | 2 +-
>  configs/rzg2_beacon_defconfig         | 4 ++--
>  configs/silinux_ek874_defconfig       | 2 +-
>  17 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfi=
g
> index 2ac867612bf..aeb55da609b 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -14,6 +14,7 @@ config RCAR_64
>         imply CMD_GPT
>         imply CMD_MMC_SWRITE if MMC
>         imply CMD_UUID
> +       imply OF_UPSTREAM
>         imply SUPPORT_EMMC_RPMB if MMC
>
>  choice
> diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfi=
g
> index 88c7ed1b98f..149ce0bac0d 100644
> --- a/configs/hihope_rzg2_defconfig
> +++ b/configs/hihope_rzg2_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774a1-hihope-rzg2m"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a774a1-hihope-rzg2m"
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_HIHOPE_RZG2=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> @@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a774a1-hihope-rzg2m r8a774b1-hihope-rzg2n r8a774e1-h=
ihope-rzg2h"
> +CONFIG_OF_LIST=3D"renesas/r8a774a1-hihope-rzg2m renesas/r8a774b1-hihope-=
rzg2n renesas/r8a774e1-hihope-rzg2h"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_de=
fconfig
> index a3f695e4238..fc39412f65c 100644
> --- a/configs/r8a77970_eagle_defconfig
> +++ b/configs/r8a77970_eagle_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-eagle"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77970-eagle"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_EAGLE=3Dy
> diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_de=
fconfig
> index 05c8d0e3868..bcd70b768ee 100644
> --- a/configs/r8a77970_v3msk_defconfig
> +++ b/configs/r8a77970_v3msk_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-v3msk"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77970-v3msk"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_R8A77970=3Dy
> diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_=
defconfig
> index 9e11c1b27ee..65eb563a712 100644
> --- a/configs/r8a77980_condor_defconfig
> +++ b/configs/r8a77980_condor_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-condor"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77980-condor"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_CONDOR=3Dy
> diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_de=
fconfig
> index f61574dd02d..38f9da445dd 100644
> --- a/configs/r8a77980_v3hsk_defconfig
> +++ b/configs/r8a77980_v3hsk_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-v3hsk"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77980-v3hsk"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_R8A77980=3Dy
> diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_de=
fconfig
> index fe4134226ac..f3cf2f8835d 100644
> --- a/configs/r8a77990_ebisu_defconfig
> +++ b/configs/r8a77990_ebisu_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77990-ebisu"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77990-ebisu"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_EBISU=3Dy
> diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_de=
fconfig
> index a964d4ea51e..ae722724e27 100644
> --- a/configs/r8a77995_draak_defconfig
> +++ b/configs/r8a77995_draak_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77995-draak"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77995-draak"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_DRAAK=3Dy
> diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_=
defconfig
> index 6681cb0088f..40097f9dc34 100644
> --- a/configs/r8a779a0_falcon_defconfig
> +++ b/configs/r8a779a0_falcon_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC00000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779a0-falcon"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a779a0-falcon"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_FALCON=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_=
defconfig
> index 942e0184412..9ab46a4d5e0 100644
> --- a/configs/r8a779f0_spider_defconfig
> +++ b/configs/r8a779f0_spider_defconfig
> @@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xD00000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779f0-spider"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a779f0-spider"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_SPIDER=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whit=
ehawk_defconfig
> index 4cc6203e54d..abc9a3ba611 100644
> --- a/configs/r8a779g0_whitehawk_defconfig
> +++ b/configs/r8a779g0_whitehawk_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779g0-white-hawk"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a779g0-white-hawk"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_WHITEHAWK=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayh=
awk_defconfig
> index 7368708195d..ff317e7c4bc 100644
> --- a/configs/r8a779h0_grayhawk_defconfig
> +++ b/configs/r8a779h0_grayhawk_defconfig
> @@ -72,3 +72,4 @@ CONFIG_SCIF_CONSOLE=3Dy
>  CONFIG_SPI=3Dy
>  CONFIG_DM_SPI=3Dy
>  CONFIG_RENESAS_RPC_SPI=3Dy
> +# CONFIG_OF_UPSTREAM is not set
> diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-=
x_defconfig
> index 22d649296e1..3200e3933b0 100644
> --- a/configs/rcar3_salvator-x_defconfig
> +++ b/configs/rcar3_salvator-x_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77951-salvator-x"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77951-salvator-x"
>  CONFIG_SPL_TEXT_BASE=3D0xe6338000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_SALVATOR_X=3Dy
> @@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a77951-salvator-x r8a77960-salvator-x r8a77965-salva=
tor-x"
> +CONFIG_OF_LIST=3D"renesas/r8a77951-salvator-x renesas/r8a77960-salvator-=
x renesas/r8a77965-salvator-x"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_OF_DTB_PROPS_REMOVE=3Dy
> diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
> index 8349f070ba4..c5cce826efd 100644
> --- a/configs/rcar3_ulcb_defconfig
> +++ b/configs/rcar3_ulcb_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77951-ulcb"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a77951-ulcb"
>  CONFIG_SPL_TEXT_BASE=3D0xe6338000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_ULCB=3Dy
> @@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a77951-ulcb r8a77960-ulcb r8a77965-ulcb"
> +CONFIG_OF_LIST=3D"renesas/r8a77951-ulcb renesas/r8a77960-ulcb renesas/r8=
a77965-ulcb"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_OF_DTB_PROPS_REMOVE=3Dy
> diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2=
l_smarc_defconfig
> index e4e597f995a..7a1224b3f07 100644
> --- a/configs/renesas_rzg2l_smarc_defconfig
> +++ b/configs/renesas_rzg2l_smarc_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x80000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r9a07g044l2-smarc"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r9a07g044l2-smarc"
>  CONFIG_RZG2L=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
>  CONFIG_SYS_LOAD_ADDR=3D0x58000000
> diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfi=
g
> index f4b63adb41e..4aabb1fe03e 100644
> --- a/configs/rzg2_beacon_defconfig
> +++ b/configs/rzg2_beacon_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_OFFSET=3D0x0
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774a1-beacon-rzg2m-kit"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a774a1-beacon-rzg2m-kit"
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_BEACON_RZG2M=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> @@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a774a1-beacon-rzg2m-kit r8a774b1-beacon-rzg2n-kit r8=
a774e1-beacon-rzg2h-kit"
> +CONFIG_OF_LIST=3D"renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-bea=
con-rzg2n-kit renesas/r8a774e1-beacon-rzg2h-kit"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defc=
onfig
> index 93902e009b2..4c94d016454 100644
> --- a/configs/silinux_ek874_defconfig
> +++ b/configs/silinux_ek874_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x10000
>  CONFIG_ENV_OFFSET=3D0x3F0000
>  CONFIG_ENV_SECT_SIZE=3D0x10000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774c0-ek874"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"renesas/r8a774c0-ek874"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_SILINUX_EK874=3Dy
> --
> 2.43.0
>
