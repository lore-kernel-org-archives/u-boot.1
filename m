Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE1FD5E389
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 23:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E71B892E8;
	Sun, 10 Nov 2024 00:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nfrJH3uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D058689235; Sun, 10 Nov 2024 00:23:58 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C17892E8
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 00:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c805a0753so33273455ad.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 15:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731194634; x=1731799434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvduu6prLx+Vl4lXyxjb7ACkvxXKVoOE4qwoHjV976U=;
 b=nfrJH3ucpZZnhfyPh7NyOF+M89WceQsv9w5erChLTLNBlINlG15aoY53nCUrEe97sR
 pvHo54rgdMfl1JdGUUrxljLQt30uSw28JhOsJG2d2omhUG09f+3qn7p+R5DHAL60Na/O
 HsqY92XlcV3IwsvZ7OwWapUOc/tDavKeMHpQ7253JXWhyjKw/oe04i41ufzsooV1PLpr
 5m6Wz9zq+A1Fgm/QWy5JHUvVBB/3hgijnFfhpUge//hgGh0jUUHTGCBkPmLPEo/AnJ0W
 s5FL73kGG8al43nD7nLasxWkTTdENJVIZUmTxMKPEBGKvnzhtCwXKN1fIc+FSCTSwBAR
 /+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731194634; x=1731799434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvduu6prLx+Vl4lXyxjb7ACkvxXKVoOE4qwoHjV976U=;
 b=Zgi0F9KqjIQ8HCdYTuIwconeXdLaeBuqG6WizSfoJmpmapuOkYTvowmXXWpFUZx97Y
 Uqq7uh9XAJErZjlWqeB96g6lU38mnYsGuj08k/HGDaGVwldKCvlj+c/m9SCNFgom3bpB
 U8g/RRIiGJYdMS+m8COl8xFMIpfDlilXtudizwO99Qw1XNVm2BBEKOsCHqhZufMVfsKz
 EVKxkFui/P24n2Be0ywdRmxY0E3g+wf7ut3kn7O5DfU6nY9RtkyVT2aRnN18itIYkDcB
 K6BXZA8tn0LJaySDN9uCBKeqn/aGTWqE4ere8H7XZ6dm+JCqgR5KqVKHs1dQnusGbrDB
 I4og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhCA99xbjzzhFeyn5A7uqXWHqaVa1JGx+pNyJOPVQmgNr1VNyskynHvq2hYZvqMEWzDLltklc=@lists.denx.de
X-Gm-Message-State: AOJu0YyR3Em2vReKiFA+zc9xiXFBiqqw+lzL0Arn90Hw96qhOVbe07V4
 31afmj3XZ+GzHIVLB0Twn6VH1MShvHxM3u3OaSVa5Jqqq5D7GCrAllZPVz7UroEIk5sVvuk1s3n
 53y8UDGsXK9jytwRlcX+vkWZXzio=
X-Google-Smtp-Source: AGHT+IE7X88SffMwohxlYFHTQlgpJUiXlDoqzTG4IrY0hdhlOsVKraZOQMFvauQA6OCcql4zWAmWHtM0BQcAK24jSXQ=
X-Received: by 2002:a17:902:ce92:b0:20c:f648:e3a7 with SMTP id
 d9443c01a7336-21183e40826mr107529365ad.50.1731194633479; Sat, 09 Nov 2024
 15:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
 <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
 <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
In-Reply-To: <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 9 Nov 2024 17:23:42 -0600
Message-ID: <CAHCN7xKCEjwyhfnCi3un94ssONdJjApMVo3FCRAydGd8Co34Uw@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 11:24=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Nov 4, 2024 at 11:22=E2=80=AFAM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > On Mon, Nov 4, 2024 at 6:17=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> > >
> > > On Mon, Nov 4, 2024 at 11:04=E2=80=AFAM Michael Nazzareno Trimarchi
> > > <michael@amarulasolutions.com> wrote:
> > > >
> > > > Hi Adam
> > > >
> > > > On Mon, Nov 4, 2024 at 6:01=E2=80=AFPM Adam Ford <aford173@gmail.co=
m> wrote:
> > > > >
> > > > > On Mon, Nov 4, 2024 at 10:29=E2=80=AFAM Michael Nazzareno Trimarc=
hi
> > > > > <michael@amarulasolutions.com> wrote:
> > > > > >
> > > > > > Hi Adam
> > > > > >
> > > > > > On Mon, Nov 4, 2024 at 5:11=E2=80=AFPM Adam Ford <aford173@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > On Sun, Jul 7, 2024 at 3:45=E2=80=AFAM Michael Trimarchi
> > > > > > > <michael@amarulasolutions.com> wrote:
> > > > > > > >
> > > > > > > > The osc_24m is the clock-output-name and not the one that
> > > > > > > > is used as internal name reference from the strcmp. The clo=
ck
> > > > > > > > that use osc_24m, will not be able to reparent it as they s=
hould.
> > > > > > > > We need anyway register the osc_24m clock fixed factor in t=
he clock
> > > > > > > > tree.
> > > > > > > >
> > > > > > > > Fixes: 710c4ffb890 ("clk: imx: clk-imx8mn add gpmi nand clo=
cks")
> > > > > > > > Fixes: 85b1c11989c ("clk: imx: Add ECSPI to iMX8MN")
> > > > > > > > Cc: Marek Vasut <marex@denx.de>
> > > > > > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.=
com>
> > > > > > > > ---
> > > > > > > >  drivers/clk/imx/clk-imx8mn.c | 15 +++++++++++----
> > > > > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx=
/clk-imx8mn.c
> > > > > > > > index ed9e16d7c1..bfd1677520 100644
> > > > > > > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > > > > > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > > > > > > @@ -57,15 +57,15 @@ static const char *imx8mn_usdhc2_sels[]=
 =3D {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > > > >                                            "sys_pll3_out", =
"sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
> > > > > > > >
> > > > > > > >  #if CONFIG_IS_ENABLED(DM_SPI)
> > > > > > > > -static const char *imx8mn_ecspi1_sels[] =3D {"osc_24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > > > > > +static const char *imx8mn_ecspi1_sels[] =3D {"clock-osc-24=
m", "sys_pll2_200m", "sys_pll1_40m",
> > > > > > > >                                            "sys_pll1_160m",=
 "sys_pll1_800m", "sys_pll3_out",
> > > > > > > >                                            "sys_pll2_250m",=
 "audio_pll2_out", };
> > > > > > > >
> > > > > > > > -static const char *imx8mn_ecspi2_sels[] =3D {"osc_24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > > > > > +static const char *imx8mn_ecspi2_sels[] =3D {"clock-osc-24=
m", "sys_pll2_200m", "sys_pll1_40m",
> > > > > > > >                                            "sys_pll1_160m",=
 "sys_pll1_800m", "sys_pll3_out",
> > > > > > > >                                            "sys_pll2_250m",=
 "audio_pll2_out", };
> > > > > > > >
> > > > > > > > -static const char *imx8mn_ecspi3_sels[] =3D {"osc_24m", "s=
ys_pll2_200m", "sys_pll1_40m",
> > > > > > > > +static const char *imx8mn_ecspi3_sels[] =3D {"clock-osc-24=
m", "sys_pll2_200m", "sys_pll1_40m",
> > > > > > > >                                            "sys_pll1_160m",=
 "sys_pll1_800m", "sys_pll3_out",
> > > > > > > >                                            "sys_pll2_250m",=
 "audio_pll2_out", };
> > > > > > > >  #endif
> > > > > > > > @@ -105,7 +105,7 @@ static const char *imx8mn_usdhc3_sels[]=
 =3D {"clock-osc-24m", "sys_pll1_400m", "sy
> > > > > > > >  static const char *imx8mn_qspi_sels[] =3D {"clock-osc-24m"=
, "sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
> > > > > > > >                                            "audio_pll2_out"=
, "sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
> > > > > > > >
> > > > > > > > -static const char * const imx8mn_nand_sels[] =3D {"osc_24m=
", "sys_pll2_500m", "audio_pll1_out",
> > > > > > > > +static const char * const imx8mn_nand_sels[] =3D {"clock-o=
sc-24m", "sys_pll2_500m", "audio_pll1_out",
> > > > > > > >                                                 "sys_pll1_4=
00m", "audio_pll2_out", "sys_pll3_out",
> > > > > > > >                                                 "sys_pll2_2=
50m", "video_pll_out", };
> > > > > > > >
> > > > > > > > @@ -119,7 +119,9 @@ static const char * const imx8mn_usb_ph=
y_sels[] =3D {"clock-osc-24m", "sys_pll1_10
> > > > > > > >
> > > > > > > >  static int imx8mn_clk_probe(struct udevice *dev)
> > > > > > > >  {
> > > > > > > > +       struct clk osc_24m_clk;
> > > > > > > >         void __iomem *base;
> > > > > > > > +       int ret;
> > > > > > > >
> > > > > > > >         base =3D (void *)ANATOP_BASE_ADDR;
> > > > > > > >
> > > > > > > > @@ -238,6 +240,11 @@ static int imx8mn_clk_probe(struct ude=
vice *dev)
> > > > > > > >         clk_dm(IMX8MN_SYS_PLL2_1000M,
> > > > > > > >                imx_clk_fixed_factor("sys_pll2_1000m", "sys_=
pll2_out", 1, 1));
> > > > > > > >
> > > > > > >
> > > > > > > I know it's late, but I didn't get around to testing my Nano =
board for
> > > > > > > a while.  Sorry for the delayed feedback...
> > > > > > >
> > > > > > > > +       ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_cl=
k);
> > > > > > > > +       if (ret)
> > > > > > > > +               return ret;
> > > > > > > > +       clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.=
dev));
> > > > > > > > +
> > > > > > >
> > > > > > > These four lines appear to have introduced a regression on th=
e
> > > > > > > imx8mn-beacon board.  In the SPL phase, I get an error messag=
e
> > > > > > > indicating it cannot find the i2c clk, then access to the PMI=
C fails.
> > > > > > > If I remove these four lines, the error message disappears, a=
nd the
> > > > > > > PMIC is happy again.
> > > > > > >
> > > > > > > I have confirmed that CLK, and SPL_CLK are both defined.   I =
checked
> > > > > > > the u-boot-spl.dtb and it shows clock-osc-24m with clock-outp=
ut-names
> > > > > > > =3D "osc_24m"
> > > > > > >
> > > > > > > I have also tried to mark the 24m clock as with bootph-pre-ra=
m;:
> > > > > > > &{/clock-osc-24m} {
> > > > > > >   bootph-pre-ram;
> > > > > > > };
> > > > > > >
> > > > > > > Unfortunately, nothing is helping, and I am not sure what els=
e to try.
> > > > > > > clk_fixed_rate.o is built into my SPL, so I don't think it's =
a config
> > > > > > > issue.  I need to the PMIC to increase the voltage since we r=
un the
> > > > > > > Nano in overdrive mode to run the LPDDR4 at the highest speed=
.
> > > > > > >
> > > > > > > Might anyone have any suggestions?
> > > > > > >
> > > > > >
> > > > > > Not yet. I have a similar setup but I don't set pmic, so I thin=
k that
> > > > > > the symbol is not find
> > > > > > in SPL and it just fail clock registration. Is that possible?
> > > > >
> > > > > It does appear that the clock registration failed.   Since the sy=
stem
> > > > > does an early return, the I2C clocks among others are also not
> > > > > registered which appears to cause the failure.
> > > > >
> > > > > I changed the registration around a little:
> > > > >
> > > > > ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
> > > > > if (!ret)
> > > > >         clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));
> > > > >
> > > >
> > > > Seems that is not in the image spl so it can not find it. Are you s=
ure
> > > > that you can inside
> > > > the SPL
> > >
> > > I am not sure I understand what you are asking, but the clock node
> > > appears in spl/u-boot-spl.dtb:
> > >
> > >  clock-osc-24m {
> > >                 compatible =3D "fixed-clock";
> > >                 #clock-cells =3D <0x00>;
> > >                 clock-frequency =3D <0x16e3600>;
> > >                 clock-output-names =3D "osc_24m";
> > >                 phandle =3D <0x18>;
> > >         };
> > >
> > > Since the clock-output-names is "osc_24m" I wonder if clk_get_by_name
> > > is the right function.  Looking at other uses of this function, it
> > > looks like it's looking for a 'clock-names' parameter and not
> > > clock-output-names.
> >
> > Yes, it's the right answer. That is strange because it works in uboot
> > image. Is the node the same in uboot-dtb?
>
> The U-Boot phase device tree looks like this:
>
>  clock-osc-24m {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0x00>;
>                 clock-frequency =3D <0x16e3600>;
>                 clock-output-names =3D "osc_24m";
>                 bootph-pre-ram;
>                 bootph-all;
>                 phandle =3D <0x18>;
>         };
>

I did some more investigating, and  with the device tree debugging
turned on, I get the following:

U-Boot SPL 2025.01-rc1-00172-g14c2ad85629c-dirty (Nov 09 2024 - 17:10:26 -0=
600)
clk_set_defaults(i2c1grp)
clk_set_default_parents: could not read assigned-clock-parents for 970690
clk_set_defaults(i2c@30a20000)
clk_set_default_parents: could not read assigned-clock-parents for 970f30
clk_set_defaults(clock-controller@30380000)
clk_set_default_parents: could not read assigned-clock-parents for 970ab8
clk_set_defaults(clock-osc-24m)
clk_set_default_parents: could not read assigned-clock-parents for 9700f8
clk_set_defaults(clock-osc-24m)
clk_set_default_parents: could not read assigned-clock-parents for 9700f8
clk_get_by_name_nodev(node=3D92a30c, name=3Dosc_24m, clk=3D96fca8)
clk_get_by_index_tail: Node 'clock-controller@30380000', property
'clocks', failed to request CLK index 1: -22
clk_get_by_index_tail: uclass_get_device_by_of_offset failed: err=3D-22
Failed to get i2c clk
clk_set_defaults(wdoggrp)
clk_set_default_parents: could not read assigned-clock-parents for 970858
clk_set_defaults(watchdog@30280000)
clk_set_default_parents: could not read assigned-clock-parents for 970500
WDT:   Not starting watchdog@30280000
clk_set_defaults(clock-controller@30380000)
clk_set_default_parents: could not read assigned-clock-parents for 970ab8
clk_get_by_name_nodev(node=3D92a30c, name=3Dosc_24m, clk=3D96fd38)
clk_get_by_index_tail: Node 'clock-controller@30380000', property
'clocks', failed to request CLK index 1: -22
Failed to find clock node. Check device tree
Trying to boot from BOOTROM
Boot Stage: Recovery boot

-------

If I modify the code so that it doesn't return early and just skips
the clock registration phase like:
ret =3D clk_get_by_name(dev, "osc_24m", &osc_24m_clk);
if (!ret)
  clk_dm(IMX8MN_CLK_24M, dev_get_clk_ptr(osc_24m_clk.dev));

------


The above work-around appears to work, and the i2c appears to enable
the clock-osc-24m clock.:

U-Boot SPL 2025.01-rc1-00172-g14c2ad85629c-dirty (Nov 09 2024 - 17:16:06 -0=
600)
clk_set_defaults(i2c1grp)
clk_set_default_parents: could not read assigned-clock-parents for 970690
clk_set_defaults(i2c@30a20000)
clk_set_default_parents: could not read assigned-clock-parents for 970f30
clk_set_defaults(clock-controller@30380000)
clk_set_default_parents: could not read assigned-clock-parents for 970ab8
clk_set_defaults(clock-osc-24m)
clk_set_default_parents: could not read assigned-clock-parents for 9700f8
clk_set_defaults(clock-osc-24m)
clk_set_default_parents: could not read assigned-clock-parents for 9700f8
clk_get_by_name_nodev(node=3D92a2fc, name=3Dosc_24m, clk=3D96fca8)
clk_get_by_index_tail: Node 'clock-controller@30380000', property
'clocks', failed to request CLK index 1: -22
clk_set_defaults(clock-controller@30380000)
clk_set_default_parents: could not read assigned-clock-parents for 970ab8
clk_of_xlate_default(clk=3D9712a8)
clk_request(dev=3D970ab8, clk=3D9712a8)
clk_enable(clk=3D9712a8 name=3Dclock-controller@30380000)
clk_enable(clk=3D975180 name=3Di2c1)
clk_enable(clk=3D970190 name=3Dclock-osc-24m)

I am not sure what the difference is between osc_24m and clock-osc-24m.

clk_get_rate(clk=3D9712a8)
clk_get_rate(clk=3D976980)
clk_get_parent_rate(clk=3D976980)
clk_get_parent(clk=3D976980)
clk_get_rate(clk=3D975180)
clk_get_parent_rate(clk=3D975180)
clk_get_parent(clk=3D975180)
clk_get_rate(clk=3D970190)
clk_set_defaults(pmicirqgrp)
clk_set_default_parents: could not read assigned-clock-parents for 970728
clk_set_defaults(pmic@4b)
clk_set_default_parents: could not read assigned-clock-parents for 970ff8
clk_set_defaults(wdoggrp)
clk_set_default_parents: could not read assigned-clock-parents for 970858
clk_set_defaults(watchdog@30280000)
clk_set_default_parents: could not read assigned-clock-parents for 970500
WDT:   Not starting watchdog@30280000
Trying to boot from BOOTROM

I am not really sure why, and / I was hoping someone might have an
idea.  If not, I might send a patch for this because without it, the
imx8mn_beacon board doesn't run at the proper voltage for the LPDDR4
controller.


adam
> >
> > Michael
> >
> > >
> > > adam
> > > >
> > > > Michael
> > > >
> > > > > This method won't return prematurely, so the I2C and other clocks=
 can
> > > > > be registered, and it appears to address the problem.
> > > > > Another alternative might be to move this clock registration unti=
l
> > > > > after all the rest of the clocks are done.
> > > > >
> > > > > adam
> > > > > >
> > > > > > If (ret)
> > > > > >
> > > > > > put here a print
> > > > > >
> > > > > > Michael
> > > > > > > adam
> > > > > > >
> > > > > > > >         base =3D dev_read_addr_ptr(dev);
> > > > > > > >         if (!base)
> > > > > > > >                 return -EINVAL;
> > > > > > > > --
> > > > > > > > 2.43.0
> > > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Michael Nazzareno Trimarchi
> > > > > > Co-Founder & Chief Executive Officer
> > > > > > M. +39 347 913 2170
> > > > > > michael@amarulasolutions.com
> > > > > > __________________________________
> > > > > >
> > > > > > Amarula Solutions BV
> > > > > > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > > > > > T. +31 (0)85 111 9172
> > > > > > info@amarulasolutions.com
> > > > > > www.amarulasolutions.com
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
