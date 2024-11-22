Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90788E65D0C
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 06:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FF018979D;
	Fri, 22 Nov 2024 07:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tb5AGQKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4A289775; Fri, 22 Nov 2024 07:42:19 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CD5897A1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 07:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ffa8092e34so2826151fa.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732257737; x=1732862537; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtkXBnrOSiwW5xS0zgL3JsPxXOU8dhYxiKXz5iqDNVc=;
 b=Tb5AGQKr0jtsqiBzJhI/eBJcdbofMwPQiNfTv5YjatkaQBtaUIPAiQNClYpSFypLoC
 MV7chEkrCyEKUYOJ1b0F7Jv6J98Dv6PKZdSJBgsZnDQP669jnN7OLyAy7p5Lsd01+21I
 dO8T01eHLQvog8EeWAd1jKszsEIqUOmTCynnEsiN6yL1OInI7U2IH3AYa4zl1iQUkhnM
 rd8DrjTEcqWvDi/mWyZ36KKJkzS/7gyjzOTTq5WNPnmOfAF1WDUoiSfCiaJuTvnNMydd
 vONKEmol+lXSxcAW/O6OHc13Q+GWyth/hbYLwn95l3hGORuRYoc3bZjk+40cB9cueYdN
 38yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732257737; x=1732862537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtkXBnrOSiwW5xS0zgL3JsPxXOU8dhYxiKXz5iqDNVc=;
 b=TORhOYWoZ41D9VIoEx2Cfg37oNwk/UoO0sozBeEtFntzBzt/9dFEVGIT+wA+RkqLNh
 WjWP46ZogunqNyosNUIl9jiCVdshxRol+yTIL95JsQwGFi/KE79O22Hzkwav1utDPyQX
 GQ2jIXD5wZkj9Pheq7JOnfSxzbqGw9tq1OG3fw1vDD/yKx6FBE1ylU2Td8gVTyDgwEJN
 QkGCSyrKW7jMCQsvsuPCNTPSLMBXH+zxns3gHKUrUuUjlowcJBkcjKyfp8taDtrcJEA2
 +IJg88ONeFNHwr/KUa9dZWevIKUPoXYe4qRVOpNTTHbKo79EJ4WhJ7RCjeg90UAjifR7
 ZcMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx5VbHGJAWt8xqrEsE732FOFcLkR7IbbSaSTWbvI4AbMpkm4h/MxhQzhK+2aUE5ngZs8LDCpc=@lists.denx.de
X-Gm-Message-State: AOJu0YwqvhcV+uw8yl2kmiqkRtgrGwbjh/CtXhkCnfoC4k9F7uWGioK4
 qT92NtWuj+4FrNfpwFp9wlnaxFRcI8amOEcXv/Y/lD8SH30D6ccfoTvtbCynRqJ1bOq73dIJtw7
 +YuAjRBUjXlY/h26UVUSZt5voNRE=
X-Gm-Gg: ASbGnctp6CkhcalsMSx8MqaIAwHJ0YHUkhCmm+vve/GUrAnfF1Ugij3UoxvLJ385PNy
 giQOR5vNdvh70KM8PuvMQZBjP4+s+xikce5/0AKxt7A2YkKx6QYxynGVaMhuSTsXmEA==
X-Google-Smtp-Source: AGHT+IGLHs3BuLhMNUj9n+9ta0Bfnmb8JZdAvtOJ54BcGn8AE03zd2itA+2LMZZjyir8KoW3sephRt0LZEZ0OhqeAv8=
X-Received: by 2002:a2e:979a:0:b0:2ff:a8db:4e7c with SMTP id
 38308e7fff4ca-2ffa8db5135mr1991071fa.4.1732257736646; Thu, 21 Nov 2024
 22:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
In-Reply-To: <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 21 Nov 2024 22:42:05 -0800
Message-ID: <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
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

On Mon, Nov 18, 2024 at 8:06=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi,
>
> On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > Add u-boot features to the U-Boot device tree.
> >
>
> For follow-up work, I would suggest minimizing U-Boot specific DT
> bits. You can either re-use what's available in upstream DT or push
> U-Boot specific changes (eg. bootph-* properties etc.) upstream.
>
> FWIW:
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit

Sumit, with the whole series applied this U-Boot specific DT addition
is confined (with exception of what I comment on below for rx delay
values on VF2 1.3b) to a single include file. Looking at linux-next
there is a bit of re-organization since the Framework / DeepComputing
JH7110 mainboard moved more nodes out of the common file and into
board specific dts. When upstream dts settles again then there will be
some more work to update this anyways. Is it any blocker for you now?

>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 43 +++++++++++++++++--
> >  arch/riscv/dts/jh7110-u-boot.dtsi             | 34 +++++++++++++++
> >  2 files changed, 73 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.d=
tsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> > index 3012466b30..fac9e16fb1 100644
> > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> > @@ -6,6 +6,10 @@
> >  #include "binman.dtsi"
> >  #include "jh7110-u-boot.dtsi"
> >  / {
> > +       aliases {
> > +               spi0 =3D &qspi;
> > +       };
> > +
> >         chosen {
> >                 bootph-pre-ram;
> >         };
> > @@ -27,42 +31,70 @@
> >
> >  &uart0 {
> >         bootph-pre-ram;
> > +       reg-offset =3D <0>;
> > +       current-speed =3D <115200>;
> > +       clock-frequency =3D <24000000>;
> >  };
> >
> >  &mmc0 {
> >         bootph-pre-ram;
> > +       compatible =3D "snps,dw-mshc";
> >  };
> >
> >  &mmc1 {
> >         bootph-pre-ram;
> > +       compatible =3D "snps,dw-mshc";
> > +};

> > +
> > +&phy0 {
> > +       rx-internal-delay-ps =3D <1900>;
> > +};
> > +
> > +&phy1 {
> > +       rx-internal-delay-ps =3D <0>;
> >  };

Hal, please drop the override of rx-internal-delay-ps on phy0 and phy1
and simply note in the cover letter that rx delay values for
VisionFive2 1.3b network phy0 and phy1 now follow the upstream dts.
The effort to keep things the same as existing U-Boot is appreciated,
however, I think it will cause a problem here.

> >
> >  &qspi {
> >         bootph-pre-ram;
> > +       spi-max-frequency =3D <250000000>;
> >
> > -       nor-flash@0 {
> > +       flash@0 {
> >                 bootph-pre-ram;
> > +               /delete-property/ cdns,read-delay;
> > +               spi-max-frequency =3D <100000000>;
> >         };
> >  };
> >
> > +&syscrg {
> > +       assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> > +                         <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> > +                         <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> > +                         <&syscrg JH7110_SYSCLK_QSPI_REF>;
> > +       assigned-clock-parents =3D <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> > +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> > +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> > +                                <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> > +       assigned-clock-rates =3D <0>, <0>, <0>, <0>;
> > +};
> > +
> >  &sysgpio {
> >         bootph-pre-ram;
> >  };
> >
> >  &mmc0_pins {
> >         bootph-pre-ram;
> > -       mmc0-pins-rest {
> > +       rst-pins {
> >                 bootph-pre-ram;
> >         };
> >  };
> >
> >  &mmc1_pins {
> >         bootph-pre-ram;
> > -       mmc1-pins0 {
> > +       clk-pins {
> >                 bootph-pre-ram;
> >         };
> >
> > -       mmc1-pins1 {
> > +       mmc-pins {
> >                 bootph-pre-ram;
> >         };
> >  };
> > @@ -78,6 +110,9 @@
> >         bootph-pre-ram;
> >         eeprom@50 {
> >                 bootph-pre-ram;
> > +               compatible =3D "atmel,24c04";
> > +               reg =3D <0x50>;
> > +               pagesize =3D <16>;
> >         };
> >  };
> >
> > diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-=
u-boot.dtsi
> > index 52c1d60859..21a2ab1789 100644
> > --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> > +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> > @@ -46,6 +46,15 @@
> >                 };
> >         };
> >
> > +       timer {
> > +               compatible =3D "riscv,timer";
> > +               interrupts-extended =3D <&cpu0_intc 5>,
> > +                                     <&cpu1_intc 5>,
> > +                                     <&cpu2_intc 5>,
> > +                                     <&cpu3_intc 5>,
> > +                                     <&cpu4_intc 5>;
> > +       };
> > +
> >         soc {
> >                 bootph-pre-ram;
> >
> > @@ -73,10 +82,35 @@
> >         bootph-pre-ram;
> >  };
> >
> > +&gmac0_rgmii_rxin {
> > +       bootph-pre-ram;
> > +};
> > +
> >  &gmac0_rmii_refin {
> >         bootph-pre-ram;
> >  };
> >
> > +&gmac1_rgmii_rxin {
> > +       bootph-pre-ram;
> > +};
> > +
> > +&gmac1_rmii_refin {
> > +       bootph-pre-ram;
> > +};
> > +
> > +&stmmac_axi_setup {
> > +       snps,wr_osr_lmt =3D <4>;
> > +       snps,rd_osr_lmt =3D <4>;
> > +};
> > +
> > +&gmac0 {
> > +       snps,perfect-filter-entries =3D <8>;
> > +};
> > +
> > +&gmac1 {
> > +       snps,perfect-filter-entries =3D <8>;
> > +};
> > +
> >  &aoncrg {
> >         bootph-pre-ram;
> >  };
> > --
> > 2.43.2
> >

-E
