Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D583FC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6941281F0D;
	Tue,  1 Apr 2025 17:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYvtvA5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB39C81F6B; Tue,  1 Apr 2025 17:46:51 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804B781DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so51809845e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743522409; x=1744127209; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jmw8/ZQiniMB1keFk3IVYRjGU4dQbXAWcI0xsd9A7w=;
 b=DYvtvA5Nf0W030y+uO29S56p4QzTmoGcMOhXv5HFRpkzoAifNTgdtdNhnFbcEcHowF
 BJzEKs4Sn/zE8uVIBEjLUqjV02Yx6yUrQ/JCOe7L/DSEjzymaksyxgT67MoVY+DA5JkY
 mro7JoUL6Ezb2kcra4ZnJsyje5zunqrkAfCSGobCXxHv/yTttAedNWoFz4cisqmU7Iuk
 4SQMzTCkDg6vg/K7Tiqa/Nj/6cpnDwz5lUOC+CRpIA6+g9LRLYj3tzIfOSzVfgwtI33U
 5gy4QGte2w+PBlg8wCXknimHfrurT7z5CWckSHMpQTWBysL0D1sPDCeKzx98PCpq2Prh
 g7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522409; x=1744127209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jmw8/ZQiniMB1keFk3IVYRjGU4dQbXAWcI0xsd9A7w=;
 b=X+ypXL6nLV+dbspSBO6Px0s5uEkzlrZLhtWYsWZq5dz8lP5fPG0LXkc34kggBAaXf/
 CkVcaN6pIwDOhVTzS1r4IedUcowN4Y3KDlT0KUck7XCTZc+GD+HX2c/i65Ixf3fuQIXy
 cz4BWQj8nJWpd0G7ygXreVB2GCDCzExz+GQL3FqPqDUdKe97wsjEZLC008jeijiiXfdG
 ja5zVBetaKyDYjXww7SiGm+Yhw99RbjmLnH0IYoW3axDMkIC745WLK9H0rG7h3CZ82ur
 7PqBIzCUXWwEbhH4iWP6lCFkENIJaGQ7XWViZxcrhtACBGzEjfRxjOHAbMGDd1xE+MRU
 Iazw==
X-Gm-Message-State: AOJu0Yxoz0B5c+aEpoKRGsRskZ87oZBiHUL/edQjSMb2G4UAnalXyqxb
 u0ag16wTO8rUIlK5KOY5DWaRwKNITkqdgsUosZQEALtgBT50l4Yf1G72vKO3hjk3RXdQIMVuWMl
 3TmAdF3bZGlbKoSo5rkmZP9IF+uY=
X-Gm-Gg: ASbGncvpkohbfAc0DRuHVwAPobTNHqvPqm89b0yMzHgaicUHWvf7npSaGq9RvMpe/xe
 iS6sYGWcJBnBNIDXkll9EjiSPrBzSo485pIrCeU4LkKkDYu0DKgAs6ivCVkpT5Ao3VRN7lFR0mC
 d3TXf35i5VLsUsrdFmprigMctbbto=
X-Google-Smtp-Source: AGHT+IEuBmaip8snBgVmaGcrvmTMYWAv59UK4uykpII89nzAe38RbMvE/3bWAsLdjEahiTb1qmVNBJdsueGFjEdAHTs=
X-Received: by 2002:a5d:5848:0:b0:39a:c9d9:8f95 with SMTP id
 ffacd0b85a97d-39c1211de82mr9568347f8f.52.1743522408661; Tue, 01 Apr 2025
 08:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250401153758.40088-1-clamor95@gmail.com>
 <20250401153758.40088-2-clamor95@gmail.com>
In-Reply-To: <20250401153758.40088-2-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 1 Apr 2025 18:46:35 +0300
X-Gm-Features: AQ5f1JpN_LRqeeKX58uISvTw7JlWJmvXZFI4vNITGnbmjrK2l-iTEBYdjdXbTnE
Message-ID: <CAPVz0n0bn52VTguRevJaBzd8OiS8aDtgWz09fGHPzQ6Ts2P2Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sysreset: diverge GPIO reset and poweroff configs
 per-phase
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>, 
 "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
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

=D0=B2=D1=82, 1 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:38=
 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> GPIO reset and power-off functionality depends on device tree data, which
> is often absent in SPL or TPL. To address this, incorporate PHASE_ into t=
he
> config and add Kconfig option for each phase.
>
> Adjust SYSRESET_GPIO and POWEROFF_GPIO uses to address possible
> regressions.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  board/sifive/unleashed/Kconfig       |  1 +
>  board/sifive/unmatched/Kconfig       |  1 +
>  configs/ge_b1x5v2_defconfig          |  1 +
>  configs/microblaze-generic_defconfig |  1 +
>  drivers/sysreset/Kconfig             | 45 ++++++++++++++++++++++++++++
>  drivers/sysreset/Makefile            |  4 +--
>  6 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/board/sifive/unleashed/Kconfig b/board/sifive/unleashed/Kcon=
fig
> index 5d842c36cfc..bf4a00d6f7f 100644
> --- a/board/sifive/unleashed/Kconfig
> +++ b/board/sifive/unleashed/Kconfig
> @@ -49,6 +49,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply SPI_FLASH_ISSI
>         imply SYSRESET
>         imply SYSRESET_GPIO
> +       imply SPL_SYSRESET_GPIO if SPL
>         imply CMD_I2C
>
>  endif
> diff --git a/board/sifive/unmatched/Kconfig b/board/sifive/unmatched/Kcon=
fig
> index bc1f33bde30..991dd23f1d4 100644
> --- a/board/sifive/unmatched/Kconfig
> +++ b/board/sifive/unmatched/Kconfig
> @@ -48,6 +48,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply PHY_MSCC
>         imply SYSRESET
>         imply SYSRESET_GPIO
> +       imply SPL_SYSRESET_GPIO if SPL
>         imply CMD_I2C
>
>  endif
> diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
> index fec4b67aee2..b8cca3c74df 100644
> --- a/configs/ge_b1x5v2_defconfig
> +++ b/configs/ge_b1x5v2_defconfig
> @@ -116,6 +116,7 @@ CONFIG_MXC_SPI=3Dy
>  CONFIG_SYSRESET=3Dy
>  CONFIG_SYSRESET_CMD_POWEROFF=3Dy
>  CONFIG_POWEROFF_GPIO=3Dy
> +CONFIG_SPL_POWEROFF_GPIO=3Dy
>  CONFIG_SYSRESET_WATCHDOG=3Dy
>  CONFIG_IMX_THERMAL=3Dy
>  CONFIG_USB=3Dy
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-ge=
neric_defconfig
> index 08f8bdb4240..7497d20ee64 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -97,6 +97,7 @@ CONFIG_SYS_NS16550=3Dy
>  CONFIG_XILINX_UARTLITE=3Dy
>  CONFIG_XILINX_SPI=3Dy
>  CONFIG_SYSRESET_GPIO=3Dy
> +CONFIG_SPL_SYSRESET_GPIO=3Dy
>  CONFIG_SYSRESET_MICROBLAZE=3Dy
>  CONFIG_WDT=3Dy
>  CONFIG_XILINX_TB_WATCHDOG=3Dy
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 475540ffac7..4972905482a 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -71,6 +71,27 @@ config POWEROFF_GPIO
>           Support for system poweroff using a GPIO pin. This can be used
>           for systems having a single GPIO to trigger a system poweroff.
>
> +config SPL_POWEROFF_GPIO
> +       bool "Enable support for GPIO poweroff driver in SPL"
> +       depends on DM_GPIO && SPL
> +       help
> +         Support for system poweroff using a GPIO pin in SPL. This can b=
e used
> +         for systems having a single GPIO to trigger a system poweroff.
> +
> +config TPL_POWEROFF_GPIO
> +       bool "Enable support for GPIO poweroff driver in TPL"
> +       depends on DM_GPIO && TPL
> +       help
> +         Support for system poweroff using a GPIO pin in TPL. This can b=
e used
> +         for systems having a single GPIO to trigger a system poweroff.
> +
> +config VPL_POWEROFF_GPIO
> +       bool "Enable support for GPIO poweroff driver in VPL"
> +       depends on DM_GPIO && VPL
> +       help
> +         Support for system poweroff using a GPIO pin in VPL. This can b=
e used
> +         for systems having a single GPIO to trigger a system poweroff.
> +
>  config SYSRESET_GPIO
>         bool "Enable support for GPIO reset driver"
>         depends on DM_GPIO
> @@ -79,6 +100,30 @@ config SYSRESET_GPIO
>           example on Microblaze where reset logic can be controlled via G=
PIO
>           pin which triggers cpu reset.
>
> +config SPL_SYSRESET_GPIO
> +       bool "Enable support for GPIO reset driver in SPL"
> +       depends on DM_GPIO && SPL
> +       help
> +         Reset support via GPIO pin connected reset logic in SPL. This i=
s used
> +         for example on Microblaze where reset logic can be controlled v=
ia
> +         GPIO pin which triggers cpu reset.
> +
> +config TPL_SYSRESET_GPIO
> +       bool "Enable support for GPIO reset driver in TPL"
> +       depends on DM_GPIO && TPL
> +       help
> +         Reset support via GPIO pin connected reset logic in TPL. This i=
s used
> +         for example on Microblaze where reset logic can be controlled v=
ia
> +         GPIO pin which triggers cpu reset.
> +
> +config VPL_SYSRESET_GPIO
> +       bool "Enable support for GPIO reset driver in VPL"
> +       depends on DM_GPIO && VPL
> +       help
> +         Reset support via GPIO pin connected reset logic in VPL. This i=
s used
> +         for example on Microblaze where reset logic can be controlled v=
ia
> +         GPIO pin which triggers cpu reset.
> +
>  config SYSRESET_MAX77663
>         bool "Enable support for MAX77663 PMIC System Reset"
>         depends on DM_PMIC_MAX77663
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index 796fc9effa5..ded91a4d325 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) +=3D sysreset_rockchip.o
>  obj-$(CONFIG_ARCH_STI) +=3D sysreset_sti.o
>  obj-$(CONFIG_SANDBOX) +=3D sysreset_sandbox.o
>  obj-$(CONFIG_SYSRESET_CV1800B) +=3D sysreset_cv1800b.o
> -obj-$(CONFIG_POWEROFF_GPIO) +=3D poweroff_gpio.o
> -obj-$(CONFIG_SYSRESET_GPIO) +=3D sysreset_gpio.o
> +obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) +=3D poweroff_gpio.o
> +obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) +=3D sysreset_gpio.o
>  obj-$(CONFIG_$(PHASE_)SYSRESET_MAX77663) +=3D sysreset_max77663.o
>  obj-$(CONFIG_SYSRESET_MPC83XX) +=3D sysreset_mpc83xx.o
>  obj-$(CONFIG_SYSRESET_MICROBLAZE) +=3D sysreset_microblaze.o
> --
> 2.43.0
>

I forgot to include maintainers of boards which are affected by this
patch. This expands the mailing list and v3 (if there will be one)
will correct this.
