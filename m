Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F59C36002
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3B381E02;
	Sun, 23 Mar 2025 13:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wjl9qcK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D878381DF6; Sun, 23 Mar 2025 13:18:21 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41AA80548
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso24810195e9.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732299; x=1743337099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PB5ftIl8JH7BZPerq9sF1WFx6KIJVUF9CRkiQt5JH+o=;
 b=Wjl9qcK0tQLUXr4uQQWHcOCziG0tX7egJg1Gq40yi+NJgy2qSxVC06DaAJ4s0SbNGT
 yGrV4bJ0hwnsutwYQOBB81aqPUqTzo3jhXbHJc8A44I6PJdJGzyzz1Sk41Wxa85Btz73
 LTPVgjQkucjM0rEAJ0kwUcRNHX+C3mHMp7dJqT6i0p0XcXp7MAtwtXJD3tqnNGVNcgWi
 XKSq9r5F2DRsfa6eJMB3i+Z6pKCXD4t/RwF1s1EAFY4jfbf60O6fRzplxBgzRNuZy5/i
 LAY36oB84VVbOdRx0z4sF8w9c2f7eynw46gwJl0UsjKimcxlWnBYGh443GEfPzyusHOf
 GvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732299; x=1743337099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PB5ftIl8JH7BZPerq9sF1WFx6KIJVUF9CRkiQt5JH+o=;
 b=pmZteJLGtES/Z8kk++CXJ6aAKhpM/wL4DcR+nrJM99noDL8eaQV8Q9ZwdpTyqimtCk
 UW0jHm58iRrnove3yZBcqCke560jUVlxVbajnXnz/SErs0JUA0plA5hwNjim3JTdu5Kc
 0M4ROScgOmDbX7UfUSv4aYJuBPyVU9JAy3qE8b2hiiI3AWLs0V119knB6o0oI88z180L
 hKnuMh5+O8vCowiVWmgYbUxdutfQRb0e11VHMfHXP9KsM1r+ZAv58gnuXKHBfsZaCGxi
 hAB3tDnLXZbNyvy9SNUpcUI0IrWPKFaxr84Gv+2iKZ0tToyFMM3n8pwVfrxWBguFBdZF
 7/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVW2xgcNaNOElEBGXlyMwqYlhS2vFuWNdMXrQcbulYTkJIZisOaW6efjp/d8EAZAoLSdDo5H4=@lists.denx.de
X-Gm-Message-State: AOJu0YzrgvlINAeIzIccqysvWE1o/w3agOQZ1MRkuCCbgxi3k1J0mp1a
 W2wwkTg4GVXpZYv7SKC1GbGXG/JDxZnv9q/v5ctiVqPLqAWGmT4z
X-Gm-Gg: ASbGnctRMxJkwhPluAFUz9ta71V5nEWVIrvobVikHTFUUmydsb1mQcMhih3N0A13FML
 dsRJH8hG2lPmDxv5nZNjTXDbP8L9erIbPTSgUY5SFrkfKGjGpkI1B3LN8ZETgI0ORu90LaVTjzv
 WGymuF9ZO7FhMwCDBw4WZh4ut/G1wyjYONNCyHq0wb+sgkuCNfghyGotMBD0ftC9sQoRum6JuO/
 2jqfbSMsBVMrRH1lo8oXYtUAHQdvQehrYCdwWW1j2SNZ5leLMER7wFc5fA5iJexizLq6RX+C2mA
 KMibzHxzyrNDJzls5Gk0TFI5Qcfek7q782q57Yg1hpFRrU6nqnLjITpb6je0V8rLabTcR0vaki/
 ExfpreH7Af+ldQqVMvUbC
X-Google-Smtp-Source: AGHT+IH1nKK9o5E85nbDxFZyBZpavOLlOx+jrxur6spNirvhYnlDlZminsbULzEz1rLMHUOgZEwG5A==
X-Received: by 2002:a05:600c:3109:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43d509efa3bmr82770505e9.8.1742732298767; 
 Sun, 23 Mar 2025 05:18:18 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c3dsm135978805e9.23.2025.03.23.05.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:18:18 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 16/34] clk: sunxi: Add support for the A523 -R CCU
Date: Sun, 23 Mar 2025 13:18:17 +0100
Message-ID: <3340159.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20250323113544.7933-17-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-17-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:26 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add a clock driver for the PRCM clock controller on the Allwinner A523
> family of SoCs, often also used with an "r" prefix or suffix.
> This just describes the clock gates and reset lines for the few devices
> that we would need, most prominently the R_I2C device for the PMIC.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi/Kconfig      |  7 ++++++
>  drivers/clk/sunxi/Makefile     |  1 +
>  drivers/clk/sunxi/clk_a523_r.c | 44 ++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi/clk_sunxi.c  |  5 ++++
>  4 files changed, 57 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk_a523_r.c
>=20
> diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
> index 74e89b86301..1c1cc82719c 100644
> --- a/drivers/clk/sunxi/Kconfig
> +++ b/drivers/clk/sunxi/Kconfig
> @@ -136,4 +136,11 @@ config CLK_SUN55I_A523
>  	  This enables common clock driver support for platforms based
>  	  on Allwinner A523/T527 SoC.
> =20
> +config CLK_SUN55I_A523_R
> +	bool "Clock driver for Allwinner A523 generation PRCM"
> +	default MACH_SUN55I_A523
> +	help
> +	  This enables common clock driver support for the PRCM
> +	  in Allwinner A523/T527 SoCs.
> +
>  endif # CLK_SUNXI
> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
> index dd33eabe2ed..93b542cebcd 100644
> --- a/drivers/clk/sunxi/Makefile
> +++ b/drivers/clk/sunxi/Makefile
> @@ -26,3 +26,4 @@ obj-$(CONFIG_CLK_SUN50I_H616) +=3D clk_h616.o
>  obj-$(CONFIG_CLK_SUN50I_A64) +=3D clk_a64.o
>  obj-$(CONFIG_CLK_SUN50I_A100) +=3D clk_a100.o
>  obj-$(CONFIG_CLK_SUN55I_A523) +=3D clk_a523.o
> +obj-$(CONFIG_CLK_SUN55I_A523_R) +=3D clk_a523_r.o
> diff --git a/drivers/clk/sunxi/clk_a523_r.c b/drivers/clk/sunxi/clk_a523_=
r.c
> new file mode 100644
> index 00000000000..e864ce16199
> --- /dev/null
> +++ b/drivers/clk/sunxi/clk_a523_r.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <clk/sunxi.h>
> +#include <dt-bindings/clock/sun55i-a523-r-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> +#include <linux/bitops.h>
> +
> +static struct ccu_clk_gate a523_r_gates[] =3D {
> +	[CLK_R_AHB]             =3D GATE_DUMMY,
> +	[CLK_R_APB0]            =3D GATE_DUMMY,
> +	[CLK_R_APB1]            =3D GATE_DUMMY,
> +	[CLK_BUS_R_TWD]         =3D GATE(0x12c, BIT(0)),
> +	[CLK_BUS_R_I2C0]        =3D GATE(0x19c, BIT(0)),
> +	[CLK_BUS_R_I2C1]        =3D GATE(0x19c, BIT(1)),
> +	[CLK_BUS_R_I2C2]        =3D GATE(0x19c, BIT(2)),
> +	[CLK_BUS_R_RTC]         =3D GATE(0x20c, BIT(0)),
> +};
> +
> +static struct ccu_reset a523_r_resets[] =3D {
> +//	[RST_BUS_R_TIMER]       =3D RESET(0x11c, BIT(16)),
> +	[RST_BUS_R_TWD]         =3D RESET(0x12c, BIT(16)),
> +//	[RST_BUS_R_PWMCTRL]     =3D RESET(0x13c, BIT(16)),
> +//	[RST_BUS_R_SPI]         =3D RESET(0x15c, BIT(16)),
> +//	[RST_BUS_R_UART0]       =3D RESET(0x18c, BIT(16)),
> +//	[RST_BUS_R_UART1]       =3D RESET(0x18c, BIT(17)),
> +	[RST_BUS_R_I2C0]        =3D RESET(0x19c, BIT(16)),
> +	[RST_BUS_R_I2C1]        =3D RESET(0x19c, BIT(17)),
> +	[RST_BUS_R_I2C2]        =3D RESET(0x19c, BIT(18)),
> +//	[RST_BUS_R_PPU1]        =3D RESET(0x1ac, BIT(17)),
> +	[RST_BUS_R_RTC]         =3D RESET(0x20c, BIT(16)),
> +//	[RST_BUS_R_CPUCFG]      =3D RESET(0x22c, BIT(16)),

Any specific reason that you commented out some reset lines?

Best regards,
Jernej

> +};
> +
> +const struct ccu_desc a523_r_ccu_desc =3D {
> +	.gates =3D a523_r_gates,
> +	.resets =3D a523_r_resets,
> +	.num_gates =3D ARRAY_SIZE(a523_r_gates),
> +	.num_resets =3D ARRAY_SIZE(a523_r_resets),
> +};
> diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
> index 30baabaafcd..842a0541bd6 100644
> --- a/drivers/clk/sunxi/clk_sunxi.c
> +++ b/drivers/clk/sunxi/clk_sunxi.c
> @@ -127,6 +127,7 @@ extern const struct ccu_desc h6_r_ccu_desc;
>  extern const struct ccu_desc r40_ccu_desc;
>  extern const struct ccu_desc v3s_ccu_desc;
>  extern const struct ccu_desc a523_ccu_desc;
> +extern const struct ccu_desc a523_r_ccu_desc;
> =20
>  static const struct udevice_id sunxi_clk_ids[] =3D {
>  #ifdef CONFIG_CLK_SUN4I_A10
> @@ -228,6 +229,10 @@ static const struct udevice_id sunxi_clk_ids[] =3D {
>  #ifdef CONFIG_CLK_SUN55I_A523
>  	{ .compatible =3D "allwinner,sun55i-a523-ccu",
>  	  .data =3D (ulong)&a523_ccu_desc },
> +#endif
> +#ifdef CONFIG_CLK_SUN55I_A523_R
> +	{ .compatible =3D "allwinner,sun55i-a523-r-ccu",
> +	  .data =3D (ulong)&a523_r_ccu_desc },
>  #endif
>  	{ }
>  };
>=20




