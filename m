Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FE5D3B9A0
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5F3889691;
	Tue, 26 Nov 2024 16:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvF8P9L5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133A289697; Tue, 26 Nov 2024 16:14:29 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE6C89657
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:14:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso66306391fa.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732634066; x=1733238866; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WE+WW8QHCGEDZ5sX2MP8DAyC4f3MozRL5F+OznyF2Yo=;
 b=EvF8P9L5awRNIaD6mHPbR+nhrD/uQ8eQz1XbfatavLHtcFMBMzutlfoEh1wxA0qjDl
 I9+rp9SzQ88fbZ6kpZQuDn4sigSF3uTf3QCQpftd/wInCR8w/+G1rVOjys4JD03xAgbb
 P9wMlOuJPi1bhrR+oCtt4ecd/vo8zDCY0Xjky5lmXE5blTGX3XJbS3Gva3IwIYJ95KN3
 lE+OUkWLocnOMdIQZZAMJgTSYSHKaHxEXhc2tGtsEHvmsh9kxUPn3by4ceOoOroBgt7H
 X1z8TnpH5F+8JCsFygJvn3opunKpVGTidIjBQ1RQOOph8QM+BBQmOtBMU7HEKnbZS5+Q
 0VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732634066; x=1733238866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WE+WW8QHCGEDZ5sX2MP8DAyC4f3MozRL5F+OznyF2Yo=;
 b=k/4Ffs9xum64ZnrZr9xKJdHNU+IFRNss2yd0xQa/vmjTRT1ROTsELCsNYKHMKGc/xR
 BA757JogQGVNfsSPu4qX19cBfAq6lP+ss+6/ebJcr4RsoFAHlafWogCjKnpvXcDs9fJv
 4+rmpkevnOmUNQ/SKYC8vWLeHuozAZ4OvSHW1pS6VzmPp4lIvGWPAGMcCDC11opVtggD
 TJgyOWgQyT7m2afDfoE33Y191G9FPUxRDCGMmuVr34TZIyefUS8erksxTLTAHS9pvNIX
 Xvbvx+Yq2876QUqEFlQ5zaERGQQ/fW3zbdfMLAi1fRra1UqF+S0cMdWRmoNfkSmQJOxh
 Ff2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJOqSvDbIkdDDRWoHFUbuUf7ApuCUsipaA0vaknj0MGPO0r06VYLoHh9YzPwSrbphzfLf1Vs=@lists.denx.de
X-Gm-Message-State: AOJu0YwyDe9xC1yBdp/rwium3Wmm7Tpg7sdtrUwxmcz7cJR02PBGVw8q
 Vlg8s2SbSI6ehsrAjDcldYMTHwTeSalXEBQauunmtFQ2TK9nDBEe4sETVQkDqQjSdePmDlZs6Lf
 d9TMK3IrOAPfi157XBa6ERHUzo9U=
X-Gm-Gg: ASbGnctEki/uq7jwuSYPU9ubfapOoytqZgWS8z1qzvcgyQFsmr7ZBlKB7qUNqoitjlR
 K9ejeZL07QgLSoGmZpUwZqnWECul38u3je2FtbSpAglRknSpolhjlRx7ct7y+QKbd0Q==
X-Google-Smtp-Source: AGHT+IFkYZQB/9hi4QIlxWO8c20N+BdBPVtS2+6hcdMmdJcPIXBxvhTqUqGupWpttx2dkvOmCEnBZU5YYjV3Y7sqy7I=
X-Received: by 2002:a2e:a916:0:b0:2ff:c67f:5197 with SMTP id
 38308e7fff4ca-2ffc67f54b2mr37031601fa.13.1732634065615; Tue, 26 Nov 2024
 07:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
 <20241125003205.75327-3-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-3-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 07:14:14 -0800
Message-ID: <CANV2PTM8co61g5spb1_Wtt5_+CueOB+EpYX4=uSrGhK=OVMwbw@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] riscv: dts: jh7110: Make u-boot device trees
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

On Sun, Nov 24, 2024 at 4:33=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> Add u-boot features to the U-Boot device tree.
>
> Tested-by: E Shattow <lucent@gmail.com>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 35 ++++++++++++++++---
>  arch/riscv/dts/jh7110-u-boot.dtsi             | 34 ++++++++++++++++++
>  2 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dts=
i b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index 3012466b30..c44553455e 100644
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
> @@ -27,42 +31,62 @@
>
>  &uart0 {
>         bootph-pre-ram;
> +       reg-offset =3D <0>;
> +       current-speed =3D <115200>;
> +       clock-frequency =3D <24000000>;
>  };
>
>  &mmc0 {
>         bootph-pre-ram;
> +       compatible =3D "snps,dw-mshc";
>  };
>
>  &mmc1 {
>         bootph-pre-ram;
> +       compatible =3D "snps,dw-mshc";
>  };
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

> @@ -78,6 +102,9 @@
>         bootph-pre-ram;
>         eeprom@50 {
>                 bootph-pre-ram;
> +               compatible =3D "atmel,24c04";
> +               reg =3D <0x50>;
> +               pagesize =3D <16>;
>         };
>  };

In some configurations with RTC there is a conflict in the addressing
with EEPROM, as in:

https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b2=
5843786012351b3f35519

Okay to keep this for now, a conflict is the exception and not the
normal situation. Refactor this out of U-Boot when EEPROM node is sent
upstream to Linux.

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
>  &aoncrg {
>         bootph-pre-ram;
>  };
> --
> 2.43.2
>

Reviewed-by: E Shattow <lucent@gmail.com>
