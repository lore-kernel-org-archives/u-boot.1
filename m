Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BECE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 19:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E036D8964E;
	Wed,  4 Dec 2024 20:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="faWm+gYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22194896D2; Wed,  4 Dec 2024 20:07:18 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0678D89468
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 20:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffb5b131d0so369491fa.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 11:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733339235; x=1733944035; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUdhrcrX2rUmwJS/zJ7tFO4ONdRhMJylHysqIuKFdjY=;
 b=faWm+gYtv56HFt23fPurYQI4gyTvke/XFxsNLWDbrCe8UAOKmxzjnpjwom80UdM7iO
 Bm2FRnR9KVGkMK+pM9QNFJ8+zV3h29kMcS72Kv5VLzLC8TZYgbTyHqV1IEKguvS+rRau
 Fl6iUPJzqhLk1lzV3pBjo37y9dCR0YQjiveDRakCGUBWEX6UdXw1nEcT6b1G7OJRI6oz
 6C6hkv7+PGMcoJ0WKp57qUeUIAM38obdPmo/kQIVcbp+7WTOvkMEX0JFLpJE/dqmVuOR
 yV7HkFdfXvCnsy/0K5mX4THZQ1pFOWGFpSm6jHxu7SCZZxpLLbL6ts56/2Rn5AczxWkl
 ffJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339235; x=1733944035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUdhrcrX2rUmwJS/zJ7tFO4ONdRhMJylHysqIuKFdjY=;
 b=Ay0dUYwhwp+7UuZ2xA5Nng/uengavAXOb8ygx5XrJqiuXZouATKvdnjJxL2ZyV2S0Y
 I/iqX7GGedkZ3jP+2tAr/w4Lwq3HoxB3F6XyCpHgC735fL/TMP2JHVFT3GllXtR+Lh96
 1pP6rrtekRI9Sxh67j2pVUhCf0SPnTc9icggm2fLtz+WjVe89BYY9j1EPRIZKR9H19hq
 KuGncDVjb3+Z7hjMXFlkNBkrH3uUKLkQkUcjw6FustCAYvoDDKd/jeANUVqa5aQLmcuB
 kbK1S5Thmo7YwTBfsgLVE2xL84fmFLhZBJIz8XWF22kpkbSTAHCLfCEey7WDLSy5AYX0
 hUVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+4KdbAXI45gI4T8GAIL51x6a2dHmkMqPpinx3OMKUEvAaqBtaQZUPF2K5UaFPUwZJ1ad3l4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx39r8IV9n9PLU2nNpQKgzBj4HIUhkqp2jpyMzU56yV+kE07k8B
 YMDVG84dSimrkx3asswrhxULvnak3EUiurZYdpySl6J/hGCRS5K/8OnLZVe7VMdM5VhVydDr2Ei
 /fpY5EXi8Fo1xbLyOFpXjcgyOGE4=
X-Gm-Gg: ASbGncv1k4JRYEYaNF8FFJik56IFsCykbcrfC9GsEO9ifWdBdZ2ogPHR5erqUP45x9t
 T7qopmEmxb0x548Uz+PnRY0Qm9dR3MS46/xYnsP3x1pLtDVJA0cw//mCTvn/T8DSyeg==
X-Google-Smtp-Source: AGHT+IHudJn/xC7jEKeu1fYYR4D4UNAzanJvH66iftC/QLThxI4BYJ30fc4d+hSWkWbodtPwWz7qdUgRrxIg4dRz7fc=
X-Received: by 2002:a2e:b8c6:0:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-30014e244a3mr19886271fa.22.1733339234921; Wed, 04 Dec 2024
 11:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
 <20241203030430.26089-3-hal.feng@starfivetech.com>
In-Reply-To: <20241203030430.26089-3-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 4 Dec 2024 11:07:03 -0800
Message-ID: <CANV2PTO5HwM6p_Q2mRx+B4n21ZWtrNrdVfmJp357MdDxWAcrQg@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Dec 2024 20:07:31 +0100
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

On Mon, Dec 2, 2024 at 7:05=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com>=
 wrote:
>
> Add u-boot features to the U-Boot device tree.
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: E Shattow <lucent@gmail.com>
> Reviewed-by: E Shattow <lucent@gmail.com>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 33 +++++++++++++++---
>  arch/riscv/dts/jh7110-u-boot.dtsi             | 34 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dts=
i b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index 3012466b30..7953459e67 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -6,6 +6,10 @@
>  #include "binman.dtsi"
>  #include "jh7110-u-boot.dtsi"
>  / {
> +       aliases {
> +               spi0 =3D &qspi;
> +       };
> +
>         chosen {
>                 bootph-pre-ram;
>         };
> @@ -27,6 +31,9 @@
>
>  &uart0 {
>         bootph-pre-ram;
> +       reg-offset =3D <0>;
> +       current-speed =3D <115200>;
> +       clock-frequency =3D <24000000>;
>  };
>
>  &mmc0 {
> @@ -39,30 +46,45 @@
>
>  &qspi {
>         bootph-pre-ram;
> +       spi-max-frequency =3D <250000000>;
>
> -       nor-flash@0 {
> +       flash@0 {
>                 bootph-pre-ram;
> +               /delete-property/ cdns,read-delay;
> +               spi-max-frequency =3D <100000000>;
>         };
>  };
>
> +&syscrg {
> +       assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_QSPI_REF>;
> +       assigned-clock-parents =3D <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> +       assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> +};
> +
>  &sysgpio {
>         bootph-pre-ram;
>  };
>
>  &mmc0_pins {
>         bootph-pre-ram;
> -       mmc0-pins-rest {
> +       rst-pins {
>                 bootph-pre-ram;
>         };
>  };
>
>  &mmc1_pins {
>         bootph-pre-ram;
> -       mmc1-pins0 {
> +       clk-pins {
>                 bootph-pre-ram;
>         };
>
> -       mmc1-pins1 {
> +       mmc-pins {
>                 bootph-pre-ram;
>         };
>  };
> @@ -78,6 +100,9 @@
>         bootph-pre-ram;
>         eeprom@50 {
>                 bootph-pre-ram;
> +               compatible =3D "atmel,24c04";
> +               reg =3D <0x50>;
> +               pagesize =3D <16>;
>         };
>  };
>
> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-=
boot.dtsi
> index 52c1d60859..21a2ab1789 100644
> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> @@ -46,6 +46,15 @@
>                 };
>         };
>
> +       timer {
> +               compatible =3D "riscv,timer";
> +               interrupts-extended =3D <&cpu0_intc 5>,
> +                                     <&cpu1_intc 5>,
> +                                     <&cpu2_intc 5>,
> +                                     <&cpu3_intc 5>,
> +                                     <&cpu4_intc 5>;
> +       };
> +
>         soc {
>                 bootph-pre-ram;
>
> @@ -73,10 +82,35 @@
>         bootph-pre-ram;
>  };
>
> +&gmac0_rgmii_rxin {
> +       bootph-pre-ram;
> +};
> +
>  &gmac0_rmii_refin {
>         bootph-pre-ram;
>  };
>
> +&gmac1_rgmii_rxin {
> +       bootph-pre-ram;
> +};
> +
> +&gmac1_rmii_refin {
> +       bootph-pre-ram;
> +};
> +

> +&stmmac_axi_setup {
> +       snps,wr_osr_lmt =3D <4>;
> +       snps,rd_osr_lmt =3D <4>;
> +};
> +
> +&gmac0 {
> +       snps,perfect-filter-entries =3D <8>;
> +};
> +
> +&gmac1 {
> +       snps,perfect-filter-entries =3D <8>;
> +};
> +

Redundant &stmmac_axi_setup &gmac0 &gmac1 property overrides (upstream
has all these). Drop.

>  &aoncrg {
>         bootph-pre-ram;
>  };
> --
> 2.43.2
>

There's also a redundant &S7_0 { status =3D "okay"; }; which can be
dropped, it is no-op since that alias is already set to be
status=3D"okay".

I tested on Star64 network function and cold boot, is fine. What
remains are the liberal use of bootph-pre-ram properties, the DRAM
Memory Controller dmc which does not appear yet in Linux, the timer {}
node; elsewhere the eeprom and uart of which the eeprom and
bootph-pre-ram properties can probably get upstream easily enough
later on.

Your choice if you want to trim these redundant properties here or if
it should be done as a later clean-up patch, as upstream does not have
the same values for these properties all.

-E
