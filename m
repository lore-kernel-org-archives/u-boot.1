Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F9D1BDCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E1888009;
	Mon,  4 Nov 2024 18:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+LTZRrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351DB88001; Mon,  4 Nov 2024 18:17:14 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA84B88D7E
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e30fb8cb07so3242687a91.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730740630; x=1731345430; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D0XnxtJv114Lf6j4pt+zhasTCyrCR49oAojbW3oP/o=;
 b=W+LTZRrn0Phcr0w/xUvKgVLqtfr2awdPwb0Ajz5QAs7pXJO76t80yaNga6SglfJFBh
 Mzixwc9LhjoErzdKEuOvqa38Vpkp2rkeyCjrNj/ElJ/vhFF1tRleNhTp0exyATtDJtwA
 06dGn3wqXYRfTduBvELGZkwxdP7W8OcTnFVoR+AEUWhpondT/4LBi0kiThoJwc5wi+gT
 xOBfdhVbDArGNR5ujSe9ltR3jTV5p/ZqudqPlWAX/rfOkwg9TAMhb6x/WL9NTbkU9ukl
 Nz1fN2B9EUIiX/vZLxFjkWaH74iRJqg+P6DIjSStGd3R4FBSw7zRZsNAJDgswkxkYo6a
 It8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740630; x=1731345430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6D0XnxtJv114Lf6j4pt+zhasTCyrCR49oAojbW3oP/o=;
 b=FAmYR1G52mT2qZnWU1+6fhUKUpwJ9/QJfhJG6R1k1D8hfOoqmYQJzGiCofLiRXsXSP
 817uwiR2E09kBbwHtre9gZyMfgVC+Mx8IU1fRtLDTU2KU50hGt4UHfFx17lt/O7Ltoth
 dozMT+7VQLizBL1T9MpcE/UpvnqqDvV+cM/Rt5Lm9c7Q5StZAHIA44ilo6HEFksLmYBt
 +xNrKle9K8JEkGGHWt3wTKkBNfNyyrXXpZIeeb5kCOrLY6okwjGMLyVyEI/sy7Zw3dj9
 J3hCRszEtaCnR6g+QuYpMWWYJrRLigmw5djqc1gSUqtB8BcHnTrjqIZ1Nbls5+C8pVAF
 0T+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjRikHjD4YhYgcKOdLlELK3r+WN3zIbCQMAD73FNbJRxyOzGDoFMreCU6Im7bB/XWyauEe7oM=@lists.denx.de
X-Gm-Message-State: AOJu0YwwikmcXt4kMkx3URDEQ+QqtD55y4LT8/+NjoHwe6McCw2Rry/c
 FWko7+NDAbrBH464iT7K5rCjOq0gD++CrRBSNVB2LX6G4fZSD/fehdQ1zprq3BkS7fsLHvq5+60
 kSl9CQAWDlV54Q4mcrYpAmWsXJy0=
X-Google-Smtp-Source: AGHT+IGm5KCq3dBRG4VgsME7RagwMTSk9m4UR5vZKD425FTyonBZ0np062S9Ubuc+C7Np+WndPEPPbMES00CiNNKTdg=
X-Received: by 2002:a17:90a:7c06:b0:2e0:921a:3383 with SMTP id
 98e67ed59e1d1-2e92ce2e140mr25172611a91.1.1730740630042; Mon, 04 Nov 2024
 09:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
In-Reply-To: <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 4 Nov 2024 11:16:57 -0600
Message-ID: <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 11:04=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Adam
>
> On Mon, Nov 4, 2024 at 6:01=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi Adam
> > >
> > > On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmail.com>=
 wrote:
> > > >
> > > > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > > > <michael@amarulasolutions.com> wrote:
> > > > >
> > > > > The osc_24m is the clock-output-name and not the one that
> > > > > is used as internal name reference from the strcmp. The clock
> > > > > that use osc_24m, will not be able to reparent it as they should.
> > > > > We need anyway register the osc_24m clock fixed factor in the clo=
ck
> > > > > tree.
> > > > >
> > > > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clocks")
> > > > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > > > Cc: Marek Vasut <marex@denx.de>
> > > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > > ---
> > > > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-i=
mx8mn.c
> > > > > index ed9e16d7c1..bfd1677520 100644
> > > > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[] =3D {=
"clock-osc-24m", "sys_pll1_400m", "sy
> > > > >                                            "sys_pll3_out", "sys_p=
ll1_266m", "audio_pll2_out", "sys_pll1_100m", };
> > > > >
> > > > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "sys_pll=
2_200m", "sys_pll1_40m",
> > > > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > >                                            "sys_pll1_160m", "sys_=
pll1_800m", "sys_pll3_out",
> > > > >                                            "sys_pll2_250m", "audi=
o_pll2_out", };
> > > > >
> > > > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "sys_pll=
2_200m", "sys_pll1_40m",
> > > > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > >                                            "sys_pll1_160m", "sys_=
pll1_800m", "sys_pll3_out",
> > > > >                                            "sys_pll2_250m", "audi=
o_pll2_out", };
> > > > >
> > > > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "sys_pll=
2_200m", "sys_pll1_40m",
> > > > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > >                                            "sys_pll1_160m", "sys_=
pll1_800m", "sys_pll3_out",
> > > > >                                            "sys_pll2_250m", "audi=
o_pll2_out", };
> > > > >  #endif
> > > > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[] =3D {=
"clock-osc-24m", "sys_pll1_400m", "sy
> > > > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m", "sys=
_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > > > >                                            "audio_pll2_out", "sys=
_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > > > >
> > > > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m", "sy=
s_pll2_500m", "audio_pll1_out",
> > > > > +static const char * const imx8mn_nand_sels[] =3D {"clock-osc-24m=
", "sys_pll2_500m", "audio_pll1_out",
> > > > >                                                 "sys_pll1_400m", =
"audio_pll2_out", "sys_pll3_out",
> > > > >                                                 "sys_pll2_250m", =
"video_pll_out", };
> > > > >
> > > > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_phy_sels=
[] =3D {"clock-osc-24m", "sys_pll1_10
> > > > >
> > > > >  static int imx8mn_clk_probe(struct udevice *dev)
> > > > >  {
> > > > > +       struct clk osc_24m_clk;
> > > > >         void __iomem *base;
> > > > > +       int ret;
> > > > >
> > > > >         base =3D (void *)ANATOP_BASE_ADDR;
> > > > >
> > > > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct udevice *=
dev)
> > > > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > > > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_o=
ut", 1, 1));
> > > > >
> > > >
> > > > I know it's late, but I didn't get around to testing my Nano board =
for
> > > > a while.  Sorry for the delayed feedback...
> > > >
> > > > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > > > > +
> > > >
> > > > These four lines appear to have introduced a regression on the
> > > > imx8mn-beacon board.  In the SPL phase, I get an error message
> > > > indicating it cannot find the i2c clk, then access to the PMIC fail=
s.
> > > > If I remove these four lines, the error message disappears, and the
> > > > PMIC is happy again.
> > > >
> > > > I have confirmed that CLK, and SPL_CLK are both defined.   I checke=
d
> > > > the u-boot-spl.dtb and it shows clock-osc-24m with clock-output-nam=
es
> > > > =3D "osc_24m"
> > > >
> > > > I have also tried to mark the 24m clock as with bootph-pre-ram;:
> > > > &{/clock-osc-24m} {
> > > >   bootph-pre-ram;
> > > > };
> > > >
> > > > Unfortunately, nothing is helping, and I am not sure what else to t=
ry.
> > > > clk_fixed_rate.o is built into my SPL, so I don't think it's a conf=
ig
> > > > issue.  I need to the PMIC to increase the voltage since we run the
> > > > Nano in overdrive mode to run the LPDDR4 at the highest speed.
> > > >
> > > > Might anyone have any suggestions?
> > > >
> > >
> > > Not yet. I have a similar setup but I don't set pmic, so I think that
> > > the symbol is not find
> > > in SPL and it just fail clock registration. Is that possible?
> >
> > It does appear that the clock registration failed.   Since the system
> > does an early return, the I2C clocks among others are also not
> > registered which appears to cause the failure.
> >
> > I changed the registration around a little:
> >
> > ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > if (!ret)
> >         clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> >
>
> Seems that is not in the image spl so it can not find it. Are you sure
> that you can inside
> the SPL

I am not sure I understand what you are asking, but the clock node
appears in spl/u-boot-spl.dtb:

 clock-osc-24m {
                compatible =3D "fixed-clock";
                #clock-cells =3D <0x00>;
                clock-frequency =3D <0x16e3600>;
                clock-output-names =3D "osc_24m";
                phandle =3D <0x18>;
        };

Since the clock-output-names is "osc_24m" I wonder if clk_get_by_name
is the right function.  Looking at other uses of this function, it
looks like it's looking for a 'clock-names' parameter and not
clock-output-names.

adam
>
> Michael
>
> > This method won't return prematurely, so the I2C and other clocks can
> > be registered, and it appears to address the problem.
> > Another alternative might be to move this clock registration until
> > after all the rest of the clocks are done.
> >
> > adam
> > >
> > > If (ret)
> > >
> > > put here a print
> > >
> > > Michael
> > > > adam
> > > >
> > > > >         base =3D dev_read_addr_ptr(dev);
> > > > >         if (!base)
> > > > >                 return -EINVAL;
> > > > > --
> > > > > 2.43.0
> > > > >
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
