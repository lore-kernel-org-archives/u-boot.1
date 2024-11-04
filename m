Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F11D1BDCC
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E136A88E1C;
	Mon,  4 Nov 2024 18:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jDymhZSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9968188D4A; Mon,  4 Nov 2024 18:04:04 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852A088DEE
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c7edf2872so42238815ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730739840; x=1731344640;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4v4B9lwovB2wtotkQifdtv9EU1U2mSpYa5pNcVIwK0=;
 b=jDymhZSCGC0IBlL9/ga8APhBlhKHJTJySFVjF6SxjAyhcXeLHWb04/lOjaWDmIceoq
 gYmXjdS8gjVR/hQyXDYMDKec7XTQap8Y0p8UHU3/HGpWIDIncjbC1Bx2dVaJdFrSSr+9
 DjRc0ZEzcRcwkhJqgk/smNlLYW/PN8J35JWH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739840; x=1731344640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4v4B9lwovB2wtotkQifdtv9EU1U2mSpYa5pNcVIwK0=;
 b=bKL/tN8ITZFsM5dJe9Zb9APckZMJczqkSEImRWElmoVzDEqHuE7Glixli4Fc4zqtrM
 H+gFq9ANutT8OGVJv2adVMqRSs05DY/+WaV8kiNtq3jK9BNE1a39WBGZMYdXX20UnwtM
 jeB+JI7UcM9VDM6ZC5fcjxJsWS8+kKq5TgcbEvM4ztVuf6EOmS3ZI6O836FYVgaCfIPw
 /59RGOMkb0jVSAWfi0ZJ+BXAbtMC+yTn+Jj5QjGu9Iy+jP2Vj7QYrnZxl9Z+73liOtxL
 3pwpb5o70nu7VQWOsmGpRft1g8DXcdmjtJz0oOHwiDTaEfNZscvqKvBB6ffIcUzlv/1q
 EO8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURSudpLNrKDhP/LqtpjpYk2KoBGms6qPG8Te2o1/6yfmVkqQyzO5JwX5wiVIMm9yu7bt0QfSU=@lists.denx.de
X-Gm-Message-State: AOJu0YxmI3OGG7j6cXrA6E73NWPgSyFxHOTa/qLObXUA5ieLTv7Agv7P
 TyqLV4/m6aX/wfEo4RnUfVe7KOtV9ZcsOGiqAWRK4Snso/PZFcNS95Xnu7RkjBw1ADbZRTOLCyx
 eJI8sQY5BTkK2uIGNExdN8h5MYXmvoM1GiibyjA==
X-Google-Smtp-Source: AGHT+IHBNUITUCG4rMJilyd7iVbNNE9tHbaMtG5hdR66vrwG7dqCfEGsQUUaO01evi9Rq/rKzFhsZUm99iwAoEBX5R8=
X-Received: by 2002:a17:90a:e7c2:b0:2e2:8ee3:b936 with SMTP id
 98e67ed59e1d1-2e94bcde572mr20408106a91.6.1730739839644; Mon, 04 Nov 2024
 09:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
In-Reply-To: <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Nov 2024 18:03:47 +0100
Message-ID: <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
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

Hi Adam

On Mon, Nov 4, 2024 at 6:01=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Adam
> >
> > On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > > <michael@amarulasolutions.com> wrote:
> > > >
> > > > The osc_24m is the clock-output-name and not the one that
> > > > is used as internal name reference from the strcmp. The clock
> > > > that use osc_24m, will not be able to reparent it as they should.
> > > > We need anyway register the osc_24m clock fixed factor in the clock
> > > > tree.
> > > >
> > > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks")
> > > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > > Cc: Marek Vasut <marex@denx.de>
> > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > ---
> > > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx=
8mn.c
> > > > index ed9e16d7c1..bfd1677520 100644
> > > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =3D {"c=
lock-osc-24m", "sys_pll1_400m", "sy
> > > >                                            "sys_pll3_out", "sys_pll=
1_266m", "audio_pll2_out", "sys_pll1_100m", };
> > > >
> > > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll2_=
200m", "sys_pll1_40m",
> > > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > >                                            "sys_pll1_160m", "sys_pl=
l1_800m", "sys_pll3_out",
> > > >                                            "sys_pll2_250m", "audio_=
pll2_out", };
> > > >
> > > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys_pll2_=
200m", "sys_pll1_40m",
> > > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > >                                            "sys_pll1_160m", "sys_pl=
l1_800m", "sys_pll3_out",
> > > >                                            "sys_pll2_250m", "audio_=
pll2_out", };
> > > >
> > > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys_pll2_=
200m", "sys_pll1_40m",
> > > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m", "sys=
_pll2_200m", "sys_pll1_40m",
> > > >                                            "sys_pll1_160m", "sys_pl=
l1_800m", "sys_pll3_out",
> > > >                                            "sys_pll2_250m", "audio_=
pll2_out", };
> > > >  #endif
> > > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =3D {"c=
lock-osc-24m", "sys_pll1_400m", "sy
> > > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", "sys_p=
ll1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > > >                                            "audio_pll2_out", "sys_p=
ll1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > > >
> > > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m", "sys_=
pll2_500m", "audio_pll1_out",
> > > > +static const char * const imx8mn_nand_sels[] =3D {"clock-osc-24m",=
 "sys_pll2_500m", "audio_pll1_out",
> > > >                                                 "sys_pll1_400m", "a=
udio_pll2_out", "sys_pll3_out",
> > > >                                                 "sys_pll2_250m", "v=
ideo_pll_out", };
> > > >
> > > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_sels[]=
 =3D {"clock-osc-24m", "sys_pll1_10
> > > >
> > > >  static int imx8mn_clk_probe(struct udevice *dev)
> > > >  {
> > > > +       struct clk osc_24m_clk;
> > > >         void __iomem *base;
> > > > +       int ret;
> > > >
> > > >         base =3D (void *)ANATOP_BASE_ADDR;
> > > >
> > > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice *de=
v)
> > > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out=
", 1, 1));
> > > >
> > >
> > > I know it's late, but I didn't get around to testing my Nano board fo=
r
> > > a while.  Sorry for the delayed feedback...
> > >
> > > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > > > +
> > >
> > > These four lines appear to have introduced a regression on the
> > > imx8mn-beacon board.  In the SPL phase, I get an error message
> > > indicating it cannot find the i2c clk, then access to the PMIC fails.
> > > If I remove these four lines, the error message disappears, and the
> > > PMIC is happy again.
> > >
> > > I have confirmed that CLK, and SPL_CLK are both defined.   I checked
> > > the u-boot-spl.dtb and it shows clock-osc-24m with clock-output-names
> > > =3D "osc_24m"
> > >
> > > I have also tried to mark the 24m clock as with bootph-pre-ram;:
> > > &{/clock-osc-24m} {
> > >   bootph-pre-ram;
> > > };
> > >
> > > Unfortunately, nothing is helping, and I am not sure what else to try=
.
> > > clk_fixed_rate.o is built into my SPL, so I don't think it's a config
> > > issue.  I need to the PMIC to increase the voltage since we run the
> > > Nano in overdrive mode to run the LPDDR4 at the highest speed.
> > >
> > > Might anyone have any suggestions?
> > >
> >
> > Not yet. I have a similar setup but I don't set pmic, so I think that
> > the symbol is not find
> > in SPL and it just fail clock registration. Is that possible?
>
> It does appear that the clock registration failed.   Since the system
> does an early return, the I2C clocks among others are also not
> registered which appears to cause the failure.
>
> I changed the registration around a little:
>
> ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> if (!ret)
>         clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
>

Seems that is not in the image spl so it can not find it. Are you sure
that you can inside
the SPL

Michael

> This method won't return prematurely, so the I2C and other clocks can
> be registered, and it appears to address the problem.
> Another alternative might be to move this clock registration until
> after all the rest of the clocks are done.
>
> adam
> >
> > If (ret)
> >
> > put here a print
> >
> > Michael
> > > adam
> > >
> > > >         base =3D dev_read_addr_ptr(dev);
> > > >         if (!base)
> > > >                 return -EINVAL;
> > > > --
> > > > 2.43.0
> > > >
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
