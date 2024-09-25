Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E2ECCF9E8
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDAE88C4A;
	Wed, 25 Sep 2024 19:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O/lubQB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88CD88B6D; Wed, 25 Sep 2024 19:26:35 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F43B88216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5e1cdfe241eso56316eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285184; x=1727889984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6tGT214p/tS34HawlRxqyY2LHFdRtaahMavMe49Uf7s=;
 b=O/lubQB1WNIGtg6/fF2mWhEOl+1/qMLVkBSm1joFU2hS3kpYRlvNUVP3mI1bJS9EqO
 iMIbd5/hYdBlXdPfssnZusDSb7uxZmAMPOyL8iAjcv+HxDkkVTQeBfuXXnhXZItP+6sb
 tcWhC06MObu4Bxn6JutkY8WaXijO0Jgj7vzVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285184; x=1727889984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tGT214p/tS34HawlRxqyY2LHFdRtaahMavMe49Uf7s=;
 b=DN/gj8LqyrH0DN+Hg5Csj+Dk8xzN3sdoQlY+Thbs1aKFJnU72bqafC1P/kmMiiMfqV
 2tZj4euqgRadrnXyEjiY1/Tc+QJvEEHnaJvsUDCujwA+ZV1/cOxp7Uxc2jS1+uTjuXl8
 /CFP8SNF5rSxeGkA3ridmjIw/EKm0IkaUH9zpUa5YYdHxBuUECcQrxjdSYgbFYdgehiD
 WrrpteSaFDseorHTcipVazkzOZ1XviTiz5Njn49UGwBdPAqP/jwSGThr1ASP76+ZsXXG
 fYDoBHrnQDSoF1usdC2jij/oX6DjVXuCnEu+jHBci95dUf3e6Z8I6bNyquPFNHIwiU9S
 XH1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm9245AW+D8jgF+PuhwsHiqIMiovLqFP+ZSALahjp5s4M8y1znpiU5cl3VJoYWdx2uDqAurm0=@lists.denx.de
X-Gm-Message-State: AOJu0YycZ95JAkKArf6KZ0MkuKO3pXMDam0zKxHykyd4eDuYePAqWoKV
 xSOh4u0D1WMRWdCjgY2TIsNLw5MNmwxRbGB40R+5S5Uv0ryppWUPec4lN/yOb+U=
X-Google-Smtp-Source: AGHT+IGz6qaFRk7Tifz+yO1IPrng7Gn63/NH984b22Z4BHTtuvatRw4NUIlejhwAAl/K2aejArAV8Q==
X-Received: by 2002:a05:6358:e488:b0:1bc:7b2a:eb57 with SMTP id
 e5c5f4694b2df-1bea832fe69mr214221255d.0.1727285184058; 
 Wed, 25 Sep 2024 10:26:24 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb25c9997asm5205636d6.63.2024.09.25.10.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:26:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:26:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 13/14] test: efi: boot: Set up an image suitable for
 EFI testing
Message-ID: <20240925172620.GD4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-14-sjg@chromium.org>
 <0d5f0f87-3469-4ad4-9663-b01985117eb6@gmx.de>
 <CAFLszThVnydvrV_vPmsWPPZOV1Dc6wzDbw2jV5ywLj-XA3J5Pg@mail.gmail.com>
 <20240916163453.GH4252@bill-the-cat>
 <CAFLszTjf5RzjbrV5NXanQSQSeBL-RB=cPN+e42GWXF5FioWS2Q@mail.gmail.com>
 <20240917221923.GP4252@bill-the-cat>
 <CAFLszTh9EJkHhpvxwb0knJQ7Bg-SPNYNM1M8u7ZO2Vaq4csstg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TqrL+E6/fRilq93h"
Content-Disposition: inline
In-Reply-To: <CAFLszTh9EJkHhpvxwb0knJQ7Bg-SPNYNM1M8u7ZO2Vaq4csstg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--TqrL+E6/fRilq93h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 04:13:01PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 18 Sept 2024 at 00:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 17, 2024 at 05:52:09AM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 16 Sept 2024 at 18:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Sep 16, 2024 at 05:42:42PM +0200, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Thu, 12 Sept 2024 at 09:09, Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
> > > > > >
> > > > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > > > Create a new disk for use with tests, which contains the new =
'testapp'
> > > > > > > EFI app specifically intended for testing the EFI loader.
> > > > > > >
> > > > > > > Attach it to the USB device, since most testing is currently =
done with
> > > > > > > mmc.
> > > > > > >
> > > > > > > Initially this image will be used to test the EFI bootmeth.
> > > > > > >
> > > > > > > Fix a stale comment in prep_mmc_bootdev() while we are here.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >   arch/sandbox/dts/test.dts           |   2 +-
> > > > > > >   test/boot/bootdev.c                 |  18 +++++++++-
> > > > > > >   test/boot/bootflow.c                |   2 +-
> > > > > > >   test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> > > > > > >   test/py/tests/test_ut.py            |  52 +++++++++++++++++=
+++++++----
> > > > > > >   5 files changed, 65 insertions(+), 9 deletions(-)
> > > > > > >   create mode 100644 test/py/tests/bootstd/flash1.img.xz
> > > > > > >
> > > > > > > diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/tes=
t.dts
> > > > > > > index 5fb5eac862e..a99de6e62ce 100644
> > > > > > > --- a/arch/sandbox/dts/test.dts
> > > > > > > +++ b/arch/sandbox/dts/test.dts
> > > > > > > @@ -1507,7 +1507,7 @@
> > > > > > >                               flash-stick@1 {
> > > > > > >                                       reg =3D <1>;
> > > > > > >                                       compatible =3D "sandbox=
,usb-flash";
> > > > > > > -                                     sandbox,filepath =3D "t=
estflash1.bin";
> > > > > > > +                                     sandbox,filepath =3D "f=
lash1.img";
> > > > > > >                               };
> > > > > > >
> > > > > > >                               flash-stick@2 {
> > > > > > > diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> > > > > > > index c635d06ec25..269bcd693a6 100644
> > > > > > > --- a/test/boot/bootdev.c
> > > > > > > +++ b/test/boot/bootdev.c
> > > > > > > @@ -212,6 +212,10 @@ static int bootdev_test_order(struct uni=
t_test_state *uts)
> > > > > > >       /* Use the environment variable to override it */
> > > > > > >       ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
> > > > > > >       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &=
bflow));
> > > > > > > +
> > > > > > > +     /* get the usb device which has a backing file (flash1.=
img) */
> > > > > > > +     ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> > > > > > > +
> > > > > > >       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> > > > > > >       ut_asserteq(5, iter.num_devs);
> > > > > > >       ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
> > > > > > > @@ -251,7 +255,11 @@ static int bootdev_test_order(struct uni=
t_test_state *uts)
> > > > > > >       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &=
bflow));
> > > > > > >       ut_asserteq(2, iter.num_devs);
> > > > > > >
> > > > > > > -     /* Now scan past mmc1 and make sure that the 3 USB devi=
ces show up */
> > > > > > > +     /*
> > > > > > > +      * Now scan past mmc1 and make sure that the 3 USB devi=
ces show up. The
> > > > > > > +      * first one has a backing file so returns success
> > > > > > > +      */
> > > > > > > +     ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> > > > > > >       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> > > > > > >       ut_asserteq(6, iter.num_devs);
> > > > > > >       ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> > > > > > > @@ -313,6 +321,10 @@ static int bootdev_test_prio(struct unit=
_test_state *uts)
> > > > > > >
> > > > > > >       /* 3 MMC and 3 USB bootdevs: MMC should come before USB=
 */
> > > > > > >       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &=
bflow));
> > > > > > > +
> > > > > > > +     /* get the usb device which has a backing file (flash1.=
img) */
> > > > > > > +     ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> > > > > > > +
> > > > > > >       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> > > > > > >       ut_asserteq(6, iter.num_devs);
> > > > > > >       ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
> > > > > > > @@ -330,6 +342,10 @@ static int bootdev_test_prio(struct unit=
_test_state *uts)
> > > > > > >       bootflow_iter_uninit(&iter);
> > > > > > >       ut_assertok(bootflow_scan_first(NULL, NULL, &iter, BOOT=
FLOWIF_HUNT,
> > > > > > >                                       &bflow));
> > > > > > > +
> > > > > > > +     /* get the usb device which has a backing file (flash1.=
img) */
> > > > > > > +     ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
> > > > > > > +
> > > > > > >       ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
> > > > > > >       ut_asserteq(7, iter.num_devs);
> > > > > > >       ut_asserteq_str("usb_mass_storage.lun0.bootdev",
> > > > > > > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > > > > > > index da55d5cfe69..37884dbd441 100644
> > > > > > > --- a/test/boot/bootflow.c
> > > > > > > +++ b/test/boot/bootflow.c
> > > > > > > @@ -525,7 +525,7 @@ static int prep_mmc_bootdev(struct unit_t=
est_state *uts, const char *mmc_dev,
> > > > > > >
> > > > > > >       order[2] =3D mmc_dev;
> > > > > > >
> > > > > > > -     /* Enable the mmc4 node since we need a second bootflow=
 */
> > > > > > > +     /* Enable the requested mmc node since we need a second=
 bootflow */
> > > > > > >       root =3D oftree_root(oftree_default());
> > > > > > >       node =3D ofnode_find_subnode(root, mmc_dev);
> > > > > > >       ut_assert(ofnode_valid(node));
> > > > > > > diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/te=
sts/bootstd/flash1.img.xz
> > > > > > > new file mode 100644
> > > > > > > index 0000000000000000000000000000000000000000..9148b91a20c1f=
0acb54449b124d1408961e92507
> > > > > > > GIT binary patch
> > > > > > > literal 5016
> > > > > > > zcmeI0cTf{r8pRVz9+4n5AV?_EgQ1BO;n5K(kx-;pUwkwL0tBUqlz=3D=3DyF=
+ikBDAExL
> > > > > > > zQWT{~2Sq?y06~gW5eP+U$nMPkwKMCEzInSlv*Z7F=3DFa`i`OZ1tr78#8*Z}=
|x3nSGR
> > > > > > > z=3D>Wn&ZU6ufAUmH=3DqlqxW9033y>XG5m*pL}cy$rvQVYbMeTPGAi$9qqfM=
nd47Jp+<S
> > > > > > > zIxLcX-gdy?;z*~}QgHUO>b8@aTLW9^ZgBe#gV-u~nri0|VMr5lA6KhSV}ds3=
x_d!R
> > > > > > > zK70s*W-GN^=3D;}ze2DKy`8Bp8a3s-y^i!J>$OdpXOt?{Uc-H+4p?j<BRmf`=
kr@RkOb
> > > > > > > z#nr%a+fVcMj7<BT<4=3Dwb&7}i+1?+`%_9rcV-IGFt)xzJvuYasj+h}W$aV}=
-mF#cWV
> > > > > > > z0q02?Tk;;}mhB#MFO491k+tL~bm}lePR6P^F?uU1qWM~zn8n@>UP+#@pmNRU=
wJ*{D
> > > > > > > zGJt0<ec}SEe@BuyWsjlSn3!f77C4m?PYr2;FS!1eCM{1>cjopJaH2B8t_BV*=
T|(V?
> > > > > > > zQE{)kaF4zAwh?({NItl!v80%xP5j+-km~m0FjHOI&3eSrr0=3Dy}ILxn<Dj+=
V+FtA;?
> > > > > > > zkfwXZQuFzB-RUPwyo#9fJZ3vFLqjRnRXx{Cjj$``T7)LJeniuGCW|XG2Di@R=
TK-7v
> > > > > > > z%@LmQG%VY9Q*iQk{IX5!h|sU6x5>&A^gJ=3D{@<k08%TNsA;LO8|NDKjWvI9=
|*L4$MB
> > > > > > > z+7n%gV=3DMx1tAg1*_I$;8%e5KZC}1lz<@sfc9Rl028JFGGi3IeoQhBA1Rw!=
e4KbgZ>
> > > > > > > zcWW%yKY}Nl<I~z}t_$|PJU0<-g!)ivhK&n#A9YhnK-3N*Q`%=3DWA+6TycBy=
`{rYBep
> > > > > > > zuUe97ouG<2ucIu+XU;2LR8g8yklNz3;<k<<Au8XakMkm_=3DcM5gt`}-7tJ^=
bCnR7tn
> > > > > > > zBe3b$z#jhsLv05PN&NHU+npZ4f?Y<fTmv;LxJ0w1oHl!Nb^<(FgZXuRy)xXY=
p~*LD
> > > > > > > z3L*PG^Lc*574Eh7oi!F-PcV5j<eaGzxJ8`ao#8ImP6c^lrB7Shz+u!o#+lun=
*$NN4
> > > > > > > ze+u>1tu^^*#UCxf;bJ&NSo@TX5>5e+pT?chViS8Qddj*v2(zyvvS5|tWhS65=
&b1s#
> > > > > > > ztq%uj(ECDcNKU@WQlPgiVOeS{T^}+v^G!^rLMD_i<okVaaHNxvN%DKEC_OJj=
tJ`fy
> > > > > > > zKFE0k6@0_k?{_0d-|8&uGq1;2=3DW4>2e;x1$aOEia;LV&Z930_1Thek8ad0=
!1k*%M3
> > > > > > > z_Q0A`8vzaWYYX7vQ=3D^y;COH>9zmbcNam0;YlMB3IVMi><k<II&(g=3D3_U=
BMw^HCFC+
> > > > > > > z@)H?uigXDBXA74rM>ftHk8xY%(%}{iymL<`3XMZW+f8a2?SETgT0;aAgL=3D=
a#3!1KX
> > > > > > > z^cLebMqp!W-R{zh?QA#i^JT<kvfv0(8ry`yg<(qzh1_zt_{3BP*1~C5OmS7q=
)YTXx
> > > > > > > zPX4FbYU!lv4)?BM&@_$q$I|V>ju!<g<X?nd#FT-)ZWn*qLX7tafjq@`!P?D{=
S5IGJ
> > > > > > > zuvsiPZc%MJ!b8(+vK$@C`6S1;#b%n~3cgfSaXr-V3RSy1Czll1NJTo9Lb$}O=
7Z-C-
> > > > > > > zx?3&7@!8q&vQI%h9&~esojd+AF!$PiZ2Gn^%Tq%h_1PQ80p&ToqgoX4NUYYm=
H|n;P
> > > > > > > ztuS}UI)h4dAc_9_X4%0uX8Ct>o5tn8#754Z(}^I`q<{*5Rey^jYGXyHJRh;{=
p1ikj
> > > > > > > zc9Dqls^pvK0YX|_7#zPTf!*b82Bk?#z3fQBiu4q*qMiE6{UF>)MUAS7qBGw*=
k4&SI
> > > > > > > zpAJ7@{r3j-*FNfpyz$Rntz!RCiAZAuN`Ei6|5Fa%9ZzPgnpH&FE1=3Dr9f!*=
ynU>LRk
> > > > > > > zs^i2fv8m7Ts$<41M5$$$O!aU5TsIe9FH*b*iXYp#Gs1FO^Y+cMC@x{|f&W>e=
{yEir
> > > > > > > zH?4mW<^(Pg@=3DwM6Kq2~v;(m_kcZ=3D>Pupg}4KY{%zU`U3zZ->A?w~ha5Y=
7#LChpCq#
> > > > > > > zjLs}(gwV(qHKH0PIq=3D=3DG%UE&4)cV#zQp!hu3P)N#5~J*rP#)Mrnf2FEJ=
B=3D>p2`NB0
> > > > > > > zxrbCGW-cOk>(@E=3D<>XoI^r+-qsU_Hbj=3D2C;jaT42`)4Nl?$<AeJrorX|=
6Ggdh?op?
> > > > > > > zoEJg?^i<Tb`^gBPlWi0Ad}h<6eb;Olmg82pe%EB`<o%Hrcp--3u;QdeNlf1~=
)~}X+
> > > > > > > z2_`kvu^$BMA*_~WOoBRm2Y2qwq_--k{wDL%<F=3D&7bN=3DH4xn;G>A9Ao50=
2gVwPUdyH
> > > > > > > zk|c8N(S#6;Vbf5B1-#i5rvvuH#*!j4W%J!DHrzLL7Y}2FiA;&kE{gOSUX)eQ=
M58e%
> > > > > > > zxzCf&=3DqNe#7eNq+P!z(uHeIWDRQiY=3DvVq^N5#m=3DJF!q>=3Dl3~T}x`=
dQCQkTnB7Jyp9
> > > > > > > z9<Ke9SBS3!ukGU#4CI-@!yY10$Hu`~TkU;%B9<w_?}51x8UCnvkWast$>!$S=
*si%Y
> > > > > > > z#K@3yE)2HKtuQf<(p%-MP;{u#ln=3DwpQ1YA#gF=3DREU4Ysw)eE4nJR61Dj=
5RfBZ~dM*
> > > > > > > zSMp96hovw!v!`3u@q#5n+3D*c)52Q{z19NhVU|dnO=3D-{cW*eIX_2Q97jaK=
23vWBG7
> > > > > > > z@m-4+V3|8nS|8n5(7fuqxU~m1hiT=3D)sP4+=3DFIXUT1|kn%EzpMCxRuaG>=
(_h94n9E@
> > > > > > > z^-0~gvKr&93iu$m=3DJxNvH`Z>5eVq0gWqPV|6Dd^9zrpc%XLqFfRKYs#OhX=
;3>Jm;b
> > > > > > > zh)!B^-RF<)Tr}SWQrPsyLGNqxRRqOIG#PiTgwEoM7^!y@5qBOR-Cf%U)jHUm=
7=3Dx1n
> > > > > > > zabX0NS!nxd?gq)JryA$B@Ibw^qlg)E=3DDN@e$6aC^s8+O<N*T+sZtE3VJS6=
CHR;Hfb
> > > > > > > zj6!OYV>_{x@AiR~<_W*A<j@8rZy})!cUSg4dNp5pXk>_j#gJdl-^e|Hn)_#5=
WHWmA
> > > > > > > z*>1210pl<x|1SJEm1hL6rCToRBa2%(;ktp6=3D{I?DPoB?_h#?1Y%pMU_Pnn=
5X#zFHB
> > > > > > > zkD8>k_~Sa)Oa|ASTX<>*J$=3DfQh1r%Sk4yV+%E8c2*ol{zZAGEORz}_=3Dp=
JYbILT?~9
> > > > > > > zx@Ww_ZY!Phs9}DZ;|(-K7u0?|<x*!^Q((Pp0U@L0j5%*kym>tedsc3u1!ajp=
lM14D
> > > > > > > z?)FvVYF1EAD}VwEmh!>y)l!<B_<wT8$jHNU{OnXe*r~#qv;d5N2DZJiLI6N8=
ou4Vd
> > > > > > > g!6FL)+!7BD4?iLFVyT<d=3D5|Q;_y0ElgRR})0MlW=3DWB>pF
> > > > > > >
> > > > > > > literal 0
> > > > > > > HcmV?d00001
> > > > > >
> > > > > > This reminds me of the xy hack. We should not add binary files.=
 Please,
> > > > > > create it on the fly.
> > > > >
> > > > > All the other tests work the same way.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut=
=2Epy
> > > > > > > index 39aa1035e34..f647e2f0af2 100644
> > > > > > > --- a/test/py/tests/test_ut.py
> > > > > > > +++ b/test/py/tests/test_ut.py
> > > > > > > @@ -28,21 +28,22 @@ def mkdir_cond(dirname):
> > > > > > >       if not os.path.exists(dirname):
> > > > > > >           os.mkdir(dirname)
> > > > > > >
> > > > > > > -def setup_image(cons, mmc_dev, part_type, second_part=3DFals=
e):
> > > > > > > +def setup_image(cons, devnum, part_type, second_part=3DFalse=
, basename=3D'mmc'):
> > > > > > >       """Create a 20MB disk image with a single partition
> > > > > > >
> > > > > > >       Args:
> > > > > > >           cons (ConsoleBase): Console to use
> > > > > > > -        mmc_dev (int): MMC device number to use, e.g. 1
> > > > > > > +        devnum (int): Device number to use, e.g. 1
> > > > > > >           part_type (int): Partition type, e.g. 0xc for FAT32
> > > > > > >           second_part (bool): True to contain a small second =
partition
> > > > > > > +        basename (str): Base name to use in the filename, e.=
g. 'mmc'
> > > > > > >
> > > > > > >       Returns:
> > > > > > >           tuple:
> > > > > > >               str: Filename of MMC image
> > > > > > >               str: Directory name of 'mnt' directory
> > > > > > >       """
> > > > > > > -    fname =3D os.path.join(cons.config.source_dir, f'mmc{mmc=
_dev}.img')
> > > > > > > +    fname =3D os.path.join(cons.config.source_dir, f'{basena=
me}{devnum}.img')
> > > > > > >       mnt =3D os.path.join(cons.config.persistent_data_dir, '=
mnt')
> > > > > > >       mkdir_cond(mnt)
> > > > > > >
> > > > > > > @@ -78,16 +79,17 @@ def mount_image(cons, fname, mnt, fstype):
> > > > > > >       u_boot_utils.run_and_log(cons, f'sudo chown {getpass.ge=
tuser()} {mnt}')
> > > > > >
> > > > > > Please, do not use sudo in tests.
> > > > >
> > > > > All the other test setup uses sudo, as do the fs-tests
> > > >
> > > > We're actively removing the use of sudo in the fs-tests, as noted in
> > > > previous iterations of this series (I believe it was this series) a=
nd
> > > > asked that you rebase this part at least on top of that series or w=
ait
> > > > for it to be merged.
> > >
> > > Well I don't believe there is actually an updated patch for this. So I
> > > don't believe it can be merged?
> > >
> > > If I missed it, please can you send the patchwork link?
> > >
> > > If and when it is merged, it is a trivial patch to update this to
> > > conform, as I noted before when this was raised.
> >
> > I've followed up, today. But on the other hand the problems were:
> > - Minor pylint problems
> > - Need one other change to go in first due to how terribly the try/catch
> >   stuff has left things.
> >
> > And would prefer (a) waiting or (b) you pick it up and finish the last
> > 5% and mark it as a pre-req to (c) we add yet another sudo based test
> > that isn't run as often as the others. Sorry.
>=20
> How about as a compromise we bring this test in and I send a follow-up
> series to tidy up the no-sudo patch?

At this point, this series needs to be re-spun either way so, whichever
order you want to handle cleaning up the other series is fine, in the
end. Thanks.

--=20
Tom

--TqrL+E6/fRilq93h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R7wACgkQFHw5/5Y0
tyzj2Av/TPOaM737jwjwlf9pXPzWG296GGafUBoe+cP1NOrSZd9XsOsuWn6JSmNF
vp2zn7Drdogt6b+jurFcHrw4CeNjnGuitR4Tu5uTHDT97XUJUj234yj6v1ZfYzP0
nkAo5U2AQMf/8QH0O/QZEJd8OA/ZzVESUm72+ca0V/MhpHXTQzRaq3HPY+rcs3L6
uBKVXIVcZMbwsMYiWb2ws9pkfhSlxsYQ8ImqTeEfNQMhSX7D+qGdG+IVyVPT94fx
+qGMCuYdHa4BO0WA7aAh6OkmR4ZqUfYhaXlWr1kF9zhi6z604BVUYGxkAiQWvugw
q0HLUIYg0PZxK9KeHxP3Kfwnx0FZ2z1Pu+FMiFsIx78+ZLClqrYrVjif2VpkJlOD
Bfk3Nesi8hvr0UhjAeYA/msmWk9je6bdVgv8+4IkpELkUVdENYatgDm/XaNLwGkY
LZRiah5c/hpCKB+JCrwwdzIAHWmFIl800jBPwF+WHbfXcxYWOqprXvpC1jN7Wk52
SB/trjD5
=wkSM
-----END PGP SIGNATURE-----

--TqrL+E6/fRilq93h--
