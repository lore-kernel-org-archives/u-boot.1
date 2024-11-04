Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA2FD1BDD0
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAA6884DB;
	Mon,  4 Nov 2024 18:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bcJk8WwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A778826E; Mon,  4 Nov 2024 18:22:53 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B848E88DEE
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21145812538so12792715ad.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730740969; x=1731345769;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poWlkURTyrLsQK02jof2HaYHjw+aoShQBV8Ci9tOq6A=;
 b=bcJk8WwCfeRjwj9ZdcQ/h60kfGbBHEzGYZFjkbcR5ptbtOh/iI4z8yPH5PdKxfqaev
 Ia+p7SidCm5KEwBYtnA4iqdx7KjSZSek0o1N8YzhJzPhOcJDlWcgKvqNkaw8S3cy5TYe
 jRuYt7JPyLAaVbGSLwMVf9xfP38UceiLpThQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740969; x=1731345769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poWlkURTyrLsQK02jof2HaYHjw+aoShQBV8Ci9tOq6A=;
 b=UQlN1AywE9kYvIr00/SO/+AO35iebypTVXzo/DbCkjzt7z+MhFmh1RckcXbRVmSK14
 iQ+D5wxECNwmgTtaSgsBVYU6dLlXd5zCxLUza/BHAjHOU/IGZrQGqGbm2nbXD50toSiA
 znxG2DTzBCK53PBC3b/7eFMj0R3PwR7/94iSPz1W9601EqkzxJ4QVLCpfg2+VDadkX1i
 icyUkbFG7jfpG43eb49aD+yVxeyEomrnPVXGzrUkCGrtMySrOGlvkIfzFf0C6WF63dfs
 bx4eRHOSOBuzsZAkUy/K3jg4+iZ0wu3PU2f3MPVlflNL1IWexXeTNq9hFgUHjIufREAW
 WgTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcnIW0Mez3uq6KX0i/EM8FCgQC2tcTQxiZKnalst9SLaITiuQ4+hXlTSzDDe9Eo1jruvxdA3I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+Kqz5nu3H3x5Y+lWwKXEzzzdw90GOHg7hmvdPbfTDeWHhHTA6
 +OUu2CVhDkbIZRVLhX+LeuB4l4HAu3Y+glo6rgUdC3+ab5gxlLXOSSUy3OLcuJP/4JLobMyC930
 mwaWPw4EACY3mE8il+/SLomSDfQob2d+yqkiiLw==
X-Google-Smtp-Source: AGHT+IETNn6pzXnk8KyNDxfQQU8Sal0HokbzZHqGcobZEjpTU3ixCaB/CsD09Hu1BEDa5f6ucZU4cW99NfJGSb7BxR8=
X-Received: by 2002:a17:902:e5d1:b0:20b:ab74:f567 with SMTP id
 d9443c01a7336-210c6b01b9amr421594755ad.27.1730740969130; Mon, 04 Nov 2024
 09:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
In-Reply-To: <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Nov 2024 18:22:37 +0100
Message-ID: <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Adam Ford <aford173@gmail.com>
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

Hi

On Mon, Nov 4, 2024 at 6:17=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Mon, Nov 4, 2024 at 11:04=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Adam
> >
> > On Mon, Nov 4, 2024 at 6:01=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarchi
> > > <michael@amarulasolutions.com> wrote:
> > > >
> > > > Hi Adam
> > > >
> > > > On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmail.co=
m> wrote:
> > > > >
> > > > > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > > > > <michael@amarulasolutions.com> wrote:
> > > > > >
> > > > > > The osc_24m is the clock-output-name and not the one that
> > > > > > is used as internal name reference from the strcmp. The clock
> > > > > > that use osc_24m, will not be able to reparent it as they shoul=
d.
> > > > > > We need anyway register the osc_24m clock fixed factor in the c=
lock
> > > > > > tree.
> > > > > >
> > > > > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks"=
)
> > > > > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > > > > Cc: Marek Vasut <marex@denx.de>
> > > > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > > > ---
> > > > > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk=
-imx8mn.c
> > > > > > index ed9e16d7c1..bfd1677520 100644
> > > > > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > > > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > > > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =3D=
 {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > >                                            "sys_pll3_out", "sys=
_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
> > > > > >
> > > > > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > > > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > > > > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", =
"sys_pll2_200m", "sys_pll1_40m",
> > > > > >                                            "sys_pll1_160m", "sy=
s_pll1_800m", "sys_pll3_out",
> > > > > >                                            "sys_pll2_250m", "au=
dio_pll2_out", };
> > > > > >
> > > > > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > > > > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m", =
"sys_pll2_200m", "sys_pll1_40m",
> > > > > >                                            "sys_pll1_160m", "sy=
s_pll1_800m", "sys_pll3_out",
> > > > > >                                            "sys_pll2_250m", "au=
dio_pll2_out", };
> > > > > >
> > > > > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > > > > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m", =
"sys_pll2_200m", "sys_pll1_40m",
> > > > > >                                            "sys_pll1_160m", "sy=
s_pll1_800m", "sys_pll3_out",
> > > > > >                                            "sys_pll2_250m", "au=
dio_pll2_out", };
> > > > > >  #endif
> > > > > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =3D=
 {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", "s=
ys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > > > > >                                            "audio_pll2_out", "s=
ys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > > > > >
> > > > > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m", "=
sys_pll2_500m", "audio_pll1_out",
> > > > > > +static const char * const imx8mn_nand_sels[] =3D {"clock-osc-2=
4m", "sys_pll2_500m", "audio_pll1_out",
> > > > > >                                                 "sys_pll1_400m"=
, "audio_pll2_out", "sys_pll3_out",
> > > > > >                                                 "sys_pll2_250m"=
, "video_pll_out", };
> > > > > >
> > > > > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_se=
ls[] =3D {"clock-osc-24m", "sys_pll1_10
> > > > > >
> > > > > >  static int imx8mn_clk_probe(struct udevice *dev)
> > > > > >  {
> > > > > > +       struct clk osc_24m_clk;
> > > > > >         void __iomem *base;
> > > > > > +       int ret;
> > > > > >
> > > > > >         base =3D (void *)ANATOP_BASE_ADDR;
> > > > > >
> > > > > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice=
 *dev)
> > > > > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > > > > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2=
_out", 1, 1));
> > > > > >
> > > > >
> > > > > I know it's late, but I didn't get around to testing my Nano boar=
d for
> > > > > a while.  Sorry for the delayed feedback...
> > > > >
> > > > > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > > > > +       if (ret)
> > > > > > +               return ret;
> > > > > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev)=
);
> > > > > > +
> > > > >
> > > > > These four lines appear to have introduced a regression on the
> > > > > imx8mn-beacon board.  In the SPL phase, I get an error message
> > > > > indicating it cannot find the i2c clk, then access to the PMIC fa=
ils.
> > > > > If I remove these four lines, the error message disappears, and t=
he
> > > > > PMIC is happy again.
> > > > >
> > > > > I have confirmed that CLK, and SPL_CLK are both defined.   I chec=
ked
> > > > > the u-boot-spl.dtb and it shows clock-osc-24m with clock-output-n=
ames
> > > > > =3D "osc_24m"
> > > > >
> > > > > I have also tried to mark the 24m clock as with bootph-pre-ram;:
> > > > > &{/clock-osc-24m} {
> > > > >   bootph-pre-ram;
> > > > > };
> > > > >
> > > > > Unfortunately, nothing is helping, and I am not sure what else to=
 try.
> > > > > clk_fixed_rate.o is built into my SPL, so I don't think it's a co=
nfig
> > > > > issue.  I need to the PMIC to increase the voltage since we run t=
he
> > > > > Nano in overdrive mode to run the LPDDR4 at the highest speed.
> > > > >
> > > > > Might anyone have any suggestions?
> > > > >
> > > >
> > > > Not yet. I have a similar setup but I don't set pmic, so I think th=
at
> > > > the symbol is not find
> > > > in SPL and it just fail clock registration. Is that possible?
> > >
> > > It does appear that the clock registration failed.   Since the system
> > > does an early return, the I2C clocks among others are also not
> > > registered which appears to cause the failure.
> > >
> > > I changed the registration around a little:
> > >
> > > ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > if (!ret)
> > >         clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > >
> >
> > Seems that is not in the image spl so it can not find it. Are you sure
> > that you can inside
> > the SPL
>
> I am not sure I understand what you are asking, but the clock node
> appears in spl/u-boot-spl.dtb:
>
>  clock-osc-24m {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0x00>;
>                 clock-frequency =3D <0x16e3600>;
>                 clock-output-names =3D "osc_24m";
>                 phandle =3D <0x18>;
>         };
>
> Since the clock-output-names is "osc_24m" I wonder if clk_get_by_name
> is the right function.  Looking at other uses of this function, it
> looks like it's looking for a 'clock-names' parameter and not
> clock-output-names.

Yes, it's the right answer. That is strange because it works in uboot
image. Is the node the same in uboot-dtb?

Michael

>
> adam
> >
> > Michael
> >
> > > This method won't return prematurely, so the I2C and other clocks can
> > > be registered, and it appears to address the problem.
> > > Another alternative might be to move this clock registration until
> > > after all the rest of the clocks are done.
> > >
> > > adam
> > > >
> > > > If (ret)
> > > >
> > > > put here a print
> > > >
> > > > Michael
> > > > > adam
> > > > >
> > > > > >         base =3D dev_read_addr_ptr(dev);
> > > > > >         if (!base)
> > > > > >                 return -EINVAL;
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Michael Nazzareno Trimarchi
> > > > Co-Founder & Chief Executive Officer
> > > > M. +39 347 913 2170
> > > > michael@amarulasolutions.com
> > > > __________________________________
> > > >
> > > > Amarula Solutions BV
> > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > T. +31 (0)85 111 9172
> > > > info@amarulasolutions.com
> > > > www.amarulasolutions.com
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
