Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628AD1BDD0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039C9884DB;
	Mon,  4 Nov 2024 18:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZX1k89OM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E8C88DEE; Mon,  4 Nov 2024 18:25:07 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9096884DB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e34a089cd3so3596427a91.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730741102; x=1731345902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwV9396UqPT09cLaTUCnhaYHIh09iPJlBgPGEtAoAzc=;
 b=ZX1k89OMOqn0Dx/29MWPcyZLfEPl9HVjHi0L7wfjk/iJD8SXXgEEX4uGpZlAAzrwVg
 bzaQ3INFg4rZ4u+a2GDX6TEcW38EXEizlMq9TgvPeaOBkVs7qDqMbifYuyQ+Y1dT+/JO
 gn2i0HOQ5bN5PF+2cVKSyURfPlPplEERAPrd8RJltREYpvRwmHasJNDtMTo2jqJD+zo8
 +xOeLXynmy60RcbzyOlIrqSnJ+t07RtY+yAOWqrrFhgDFeeEr639SDKNIO5Y6DWL4foI
 91+W+rjAH+qf8jPCOpNrACA4TjRzDQqkeZIEr/lOHEGKlMj3hW0GBj+P2TELt7sz4/pD
 IlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741102; x=1731345902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwV9396UqPT09cLaTUCnhaYHIh09iPJlBgPGEtAoAzc=;
 b=dMbdzwV3GUB1sQc5qMzkVjvqjdEkDvaHbWvOETwquJP4ySxaw4q9Yodmt94TpZcjoW
 EzUbuSxnT1FIvh8s0U3erA4nXptrKqkN5PLjXtEXSwCNywqzRyvmJ+nNvPMuGwz6KBYD
 upPfAq4Ji2cJHsXGrBGrdVkTg7+zEys/9nsut2+kEnCWRnbyAOGz1dQljJrcdgMOc0pE
 +1ROROIcXNE6A88Qsm8Xk1QEEj96rDK5O2Qm+q6/td8CLq3O3rfo2T7P8zJprBNFCegb
 nPVyQQnMRXM0anD6FZDN/omRWSm/VGgp1cBXQmmE4IOQ8RTc+LpENnVAcAADD+uIXZmA
 HNoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVlG9l10iFOV6Tx9+IAulj5Mwdi1+iY3MzBA+y2OZ4rnDLQJ20Q/PPYYxx9rHmj2UwdysT4gk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8luQ9cF5FAbb9VQLse0MxhgvrSm397SDh+lI96SUgFF0yWjef
 oQ+59E4R9f+bfZrmnia9EX0nGaRRxsk67qwRhqmxbyAHNvXiWhzri62wQMMH8fypNg+Y95K8kyp
 KPkNh3UjGZLEtnOyrNUgoIvFc70c=
X-Google-Smtp-Source: AGHT+IH08jA+cPPjqbtra4V5vTW+Z8ANJ/npHUNY84xDcpgbOeFhefTLoF9Zy35/EajoWl4DOUSrXfSZamnuwvkOZR4=
X-Received: by 2002:a17:90a:38a3:b0:2e9:20d8:4147 with SMTP id
 98e67ed59e1d1-2e920d84387mr26629363a91.33.1730741101917; Mon, 04 Nov 2024
 09:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
 <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
In-Reply-To: <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 4 Nov 2024 11:24:50 -0600
Message-ID: <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com, 
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>
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

On Mon, Nov 4, 2024 at 11:22=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Mon, Nov 4, 2024 at 6:17=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Mon, Nov 4, 2024 at 11:04=E2=80=AFAM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi Adam
> > >
> > > On Mon, Nov 4, 2024 at 6:01=E2=80=AFPM Adam Ford <aford173@gmail.com>=
 wrote:
> > > >
> > > > On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarchi
> > > > <michael@amarulasolutions.com> wrote:
> > > > >
> > > > > Hi Adam
> > > > >
> > > > > On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmail.=
com> wrote:
> > > > > >
> > > > > > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > > > > > <michael@amarulasolutions.com> wrote:
> > > > > > >
> > > > > > > The osc_24m is the clock-output-name and not the one that
> > > > > > > is used as internal name reference from the strcmp. The clock
> > > > > > > that use osc_24m, will not be able to reparent it as they sho=
uld.
> > > > > > > We need anyway register the osc_24m clock fixed factor in the=
 clock
> > > > > > > tree.
> > > > > > >
> > > > > > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clock=
s")
> > > > > > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > > > > > Cc: Marek Vasut <marex@denx.de>
> > > > > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.co=
m>
> > > > > > > ---
> > > > > > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > > > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/c=
lk-imx8mn.c
> > > > > > > index ed9e16d7c1..bfd1677520 100644
> > > > > > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > > > > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > > > > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =
=3D {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > > >                                            "sys_pll3_out", "s=
ys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
> > > > > > >
> > > > > > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > > > > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > > > > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m"=
, "sys_pll2_200m", "sys_pll1_40m",
> > > > > > >                                            "sys_pll1_160m", "=
sys_pll1_800m", "sys_pll3_out",
> > > > > > >                                            "sys_pll2_250m", "=
audio_pll2_out", };
> > > > > > >
> > > > > > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > > > > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m"=
, "sys_pll2_200m", "sys_pll1_40m",
> > > > > > >                                            "sys_pll1_160m", "=
sys_pll1_800m", "sys_pll3_out",
> > > > > > >                                            "sys_pll2_250m", "=
audio_pll2_out", };
> > > > > > >
> > > > > > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > > > > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m"=
, "sys_pll2_200m", "sys_pll1_40m",
> > > > > > >                                            "sys_pll1_160m", "=
sys_pll1_800m", "sys_pll3_out",
> > > > > > >                                            "sys_pll2_250m", "=
audio_pll2_out", };
> > > > > > >  #endif
> > > > > > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =
=3D {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", =
"sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > > > > > >                                            "audio_pll2_out", =
"sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > > > > > >
> > > > > > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m",=
 "sys_pll2_500m", "audio_pll1_out",
> > > > > > > +static const char * const imx8mn_nand_sels[] =3D {"clock-osc=
-24m", "sys_pll2_500m", "audio_pll1_out",
> > > > > > >                                                 "sys_pll1_400=
m", "audio_pll2_out", "sys_pll3_out",
> > > > > > >                                                 "sys_pll2_250=
m", "video_pll_out", };
> > > > > > >
> > > > > > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_=
sels[] =3D {"clock-osc-24m", "sys_pll1_10
> > > > > > >
> > > > > > >  static int imx8mn_clk_probe(struct udevice *dev)
> > > > > > >  {
> > > > > > > +       struct clk osc_24m_clk;
> > > > > > >         void __iomem *base;
> > > > > > > +       int ret;
> > > > > > >
> > > > > > >         base =3D (void *)ANATOP_BASE_ADDR;
> > > > > > >
> > > > > > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevi=
ce *dev)
> > > > > > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > > > > > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pl=
l2_out", 1, 1));
> > > > > > >
> > > > > >
> > > > > > I know it's late, but I didn't get around to testing my Nano bo=
ard for
> > > > > > a while.  Sorry for the delayed feedback...
> > > > > >
> > > > > > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk)=
;
> > > > > > > +       if (ret)
> > > > > > > +               return ret;
> > > > > > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.de=
v));
> > > > > > > +
> > > > > >
> > > > > > These four lines appear to have introduced a regression on the
> > > > > > imx8mn-beacon board.  In the SPL phase, I get an error message
> > > > > > indicating it cannot find the i2c clk, then access to the PMIC =
fails.
> > > > > > If I remove these four lines, the error message disappears, and=
 the
> > > > > > PMIC is happy again.
> > > > > >
> > > > > > I have confirmed that CLK, and SPL_CLK are both defined.   I ch=
ecked
> > > > > > the u-boot-spl.dtb and it shows clock-osc-24m with clock-output=
-names
> > > > > > =3D "osc_24m"
> > > > > >
> > > > > > I have also tried to mark the 24m clock as with bootph-pre-ram;=
:
> > > > > > &{/clock-osc-24m} {
> > > > > >   bootph-pre-ram;
> > > > > > };
> > > > > >
> > > > > > Unfortunately, nothing is helping, and I am not sure what else =
to try.
> > > > > > clk_fixed_rate.o is built into my SPL, so I don't think it's a =
config
> > > > > > issue.  I need to the PMIC to increase the voltage since we run=
 the
> > > > > > Nano in overdrive mode to run the LPDDR4 at the highest speed.
> > > > > >
> > > > > > Might anyone have any suggestions?
> > > > > >
> > > > >
> > > > > Not yet. I have a similar setup but I don't set pmic, so I think =
that
> > > > > the symbol is not find
> > > > > in SPL and it just fail clock registration. Is that possible?
> > > >
> > > > It does appear that the clock registration failed.   Since the syst=
em
> > > > does an early return, the I2C clocks among others are also not
> > > > registered which appears to cause the failure.
> > > >
> > > > I changed the registration around a little:
> > > >
> > > > ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > > if (!ret)
> > > >         clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > > >
> > >
> > > Seems that is not in the image spl so it can not find it. Are you sur=
e
> > > that you can inside
> > > the SPL
> >
> > I am not sure I understand what you are asking, but the clock node
> > appears in spl/u-boot-spl.dtb:
> >
> >  clock-osc-24m {
> >                 compatible =3D "fixed-clock";
> >                 #clock-cells =3D <0x00>;
> >                 clock-frequency =3D <0x16e3600>;
> >                 clock-output-names =3D "osc_24m";
> >                 phandle =3D <0x18>;
> >         };
> >
> > Since the clock-output-names is "osc_24m" I wonder if clk_get_by_name
> > is the right function.  Looking at other uses of this function, it
> > looks like it's looking for a 'clock-names' parameter and not
> > clock-output-names.
>
> Yes, it's the right answer. That is strange because it works in uboot
> image. Is the node the same in uboot-dtb?

The U-Boot phase device tree looks like this:

 clock-osc-24m {
                compatible =3D "fixed-clock";
                #clock-cells =3D <0x00>;
                clock-frequency =3D <0x16e3600>;
                clock-output-names =3D "osc_24m";
                bootph-pre-ram;
                bootph-all;
                phandle =3D <0x18>;
        };

>
> Michael
>
> >
> > adam
> > >
> > > Michael
> > >
> > > > This method won't return prematurely, so the I2C and other clocks c=
an
> > > > be registered, and it appears to address the problem.
> > > > Another alternative might be to move this clock registration until
> > > > after all the rest of the clocks are done.
> > > >
> > > > adam
> > > > >
> > > > > If (ret)
> > > > >
> > > > > put here a print
> > > > >
> > > > > Michael
> > > > > > adam
> > > > > >
> > > > > > >         base =3D dev_read_addr_ptr(dev);
> > > > > > >         if (!base)
> > > > > > >                 return -EINVAL;
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Michael Nazzareno Trimarchi
> > > > > Co-Founder & Chief Executive Officer
> > > > > M. +39 347 913 2170
> > > > > michael@amarulasolutions.com
> > > > > __________________________________
> > > > >
> > > > > Amarula Solutions BV
> > > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > > T. +31 (0)85 111 9172
> > > > > info@amarulasolutions.com
> > > > > www.amarulasolutions.com
> > >
> > >
> > >
> > > --
> > > Michael Nazzareno Trimarchi
> > > Co-Founder & Chief Executive Officer
> > > M. +39 347 913 2170
> > > michael@amarulasolutions.com
> > > __________________________________
> > >
> > > Amarula Solutions BV
> > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > T. +31 (0)85 111 9172
> > > info@amarulasolutions.com
> > > www.amarulasolutions.com
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
