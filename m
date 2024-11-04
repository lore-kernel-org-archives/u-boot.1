Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46800D1BDC7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6481088D4A;
	Mon,  4 Nov 2024 18:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gbvz4svm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53FBD88CBA; Mon,  4 Nov 2024 18:01:35 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B5C88D4A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso3178313a91.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730739691; x=1731344491; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EDSQKntShHRzQrwhgZ+ZNQRRW11YZDqAY+q201bbFY=;
 b=gbvz4svmpo3Gqtxjlq63pkyFCB3DfZ8qgfSFacKZILNLueheqdup4zXJ33BbJ9pPN4
 BJCB7MaBnVJjF6UCqkkXSPGA3lQBLs7nRrwvGWE7bAgch/sInB9QKIaGvt2k2pstsIsj
 2EzzhH+1HLYPhISXnfsni98ewwBN+dG/V/rbecwcwVNJW2ILpiFtwEzPqVknAwt8pV/M
 qOoNzatsVGBd+81n1gHEJachP2rpKDbrkIitAine2Nk3TwNSc0LC7al1I8creKHy/au6
 Yh0KIIc64MhN7jzU97DGOhji0Kz6ZSrS9wTCrUDeUP1ds32r7duxeMzgWlH1x5UPh4hf
 hoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739691; x=1731344491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EDSQKntShHRzQrwhgZ+ZNQRRW11YZDqAY+q201bbFY=;
 b=ROaN7uh9MgzlI33KntVLom6NhoPJlxkbHjganFWSNq3FdMx2ErKyWTwsQdz2Vqh95x
 8Qm6dMgvjJ0ORVtnJW+HCr8p1bupJIBOwGqiQ67s2BBVo8E0z8qG4FtORvbw2vgn3sLC
 zCTDoq+5YT2txW3c5ZUu6OnWTHj91Zmzx3H7tlmVkYCzMTro4F1cqCtXiH6AXXC6goHh
 z6z1MR9sBDckP9hoJvgFj5THu2S6k+gZ5ANcKjqlIabv2J1G7Rxvo/NdH+aXYZPmmhQ3
 W2aYYnw6vVbXKORqQUaqok5+kf9xLeDYmBHEGGzSTFIcZyNwAAPm653yvlKXa5G1+G+U
 fVMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3LSYj5agZOH6VQrjEPMznDdd7MTEaTgEo9/PYtyDLo/t+Txw+XyewcXlh0kXGo/8VlVd5oU4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0H1WOQKEOPseJiUpf7viwEW0IVI4xchw2OwxrN/lDXTXf/nGJ
 pTM5Hi7U5q4TM9WOf8rpsJZ4+TrvPtG7DHv1O1EnSWu4Lkc3V6nI5oSvPhJPpsVDllaEzLXvQVq
 SCutlIYc7JlTQ8IuPBWJ1t0hFjqlkA2H7
X-Google-Smtp-Source: AGHT+IGvXq8mCoUG10kcUzDyBeEwGnipf027IJyWsF46+QtruvyHKHJo+eTyD+NPjdvwhwgoC8SrPJXyf+J3GY7Zoho=
X-Received: by 2002:a17:90a:7408:b0:2e2:d3a0:4716 with SMTP id
 98e67ed59e1d1-2e8f1086215mr37556016a91.18.1730739691139; Mon, 04 Nov 2024
 09:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
In-Reply-To: <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 4 Nov 2024 11:01:19 -0600
Message-ID: <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Adam
>
> On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > The osc_24m is the clock-output-name and not the one that
> > > is used as internal name reference from the strcmp. The clock
> > > that use osc_24m, will not be able to reparent it as they should.
> > > We need anyway register the osc_24m clock fixed factor in the clock
> > > tree.
> > >
> > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks")
> > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > Cc: Marek Vasut <marex@denx.de>
> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8m=
n.c
> > > index ed9e16d7c1..bfd1677520 100644
> > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =3D {"clo=
ck-osc-24m", "sys_pll1_400m", "sy
> > >                                            "sys_pll3_out", "sys_pll1_=
266m", "audio_pll2_out", "sys_pll1_100m", };
> > >
> > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll2_20=
0m", "sys_pll1_40m",
> > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > >                                            "sys_pll1_160m", "sys_pll1=
_800m", "sys_pll3_out",
> > >                                            "sys_pll2_250m", "audio_pl=
l2_out", };
> > >
> > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys_pll2_20=
0m", "sys_pll1_40m",
> > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > >                                            "sys_pll1_160m", "sys_pll1=
_800m", "sys_pll3_out",
> > >                                            "sys_pll2_250m", "audio_pl=
l2_out", };
> > >
> > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys_pll2_20=
0m", "sys_pll1_40m",
> > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m", "sys_p=
ll2_200m", "sys_pll1_40m",
> > >                                            "sys_pll1_160m", "sys_pll1=
_800m", "sys_pll3_out",
> > >                                            "sys_pll2_250m", "audio_pl=
l2_out", };
> > >  #endif
> > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =3D {"clo=
ck-osc-24m", "sys_pll1_400m", "sy
> > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", "sys_pll=
1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > >                                            "audio_pll2_out", "sys_pll=
1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > >
> > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m", "sys_pl=
l2_500m", "audio_pll1_out",
> > > +static const char * const imx8mn_nand_sels[] =3D {"clock-osc-24m", "=
sys_pll2_500m", "audio_pll1_out",
> > >                                                 "sys_pll1_400m", "aud=
io_pll2_out", "sys_pll3_out",
> > >                                                 "sys_pll2_250m", "vid=
eo_pll_out", };
> > >
> > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_sels[] =
=3D {"clock-osc-24m", "sys_pll1_10
> > >
> > >  static int imx8mn_clk_probe(struct udevice *dev)
> > >  {
> > > +       struct clk osc_24m_clk;
> > >         void __iomem *base;
> > > +       int ret;
> > >
> > >         base =3D (void *)ANATOP_BASE_ADDR;
> > >
> > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
> > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out",=
 1, 1));
> > >
> >
> > I know it's late, but I didn't get around to testing my Nano board for
> > a while.  Sorry for the delayed feedback...
> >
> > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > +       if (ret)
> > > +               return ret;
> > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > > +
> >
> > These four lines appear to have introduced a regression on the
> > imx8mn-beacon board.  In the SPL phase, I get an error message
> > indicating it cannot find the i2c clk, then access to the PMIC fails.
> > If I remove these four lines, the error message disappears, and the
> > PMIC is happy again.
> >
> > I have confirmed that CLK, and SPL_CLK are both defined.   I checked
> > the u-boot-spl.dtb and it shows clock-osc-24m with clock-output-names
> > =3D "osc_24m"
> >
> > I have also tried to mark the 24m clock as with bootph-pre-ram;:
> > &{/clock-osc-24m} {
> >   bootph-pre-ram;
> > };
> >
> > Unfortunately, nothing is helping, and I am not sure what else to try.
> > clk_fixed_rate.o is built into my SPL, so I don't think it's a config
> > issue.  I need to the PMIC to increase the voltage since we run the
> > Nano in overdrive mode to run the LPDDR4 at the highest speed.
> >
> > Might anyone have any suggestions?
> >
>
> Not yet. I have a similar setup but I don't set pmic, so I think that
> the symbol is not find
> in SPL and it just fail clock registration. Is that possible?

It does appear that the clock registration failed.   Since the system
does an early return, the I2C clocks among others are also not
registered which appears to cause the failure.

I changed the registration around a little:

ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
if (!ret)
        clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));

This method won't return prematurely, so the I2C and other clocks can
be registered, and it appears to address the problem.
Another alternative might be to move this clock registration until
after all the rest of the clocks are done.

adam
>
> If (ret)
>
> put here a print
>
> Michael
> > adam
> >
> > >         base =3D dev_read_addr_ptr(dev);
> > >         if (!base)
> > >                 return -EINVAL;
> > > --
> > > 2.43.0
> > >
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
