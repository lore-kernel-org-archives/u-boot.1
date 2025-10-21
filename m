Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66E6CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 17:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210F1802C1;
	Tue, 21 Oct 2025 19:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pp37OdIi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5186807C0; Tue, 21 Oct 2025 19:29:38 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB4280107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 19:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-651c521980cso3017115eaf.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761067774; x=1761672574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2BAZJba7A6nBY7yoDhFHzYrb/taVSwwdFow1n8pp6qU=;
 b=pp37OdIiW9AYyrU+eSxEXhSBwPd3CG9xowFilSLKhNmkzlHKGNqtAyEam+Waeuv/+H
 egA1CE3oGtmaLzyl13wkHYZY+9blK9oHBfDqmWtEaVh9anO6afbPbMTC0blPmf8y4Fzt
 bICPjrbeXV3oc79udzU/kH4vtD8/FCR4g5wGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761067774; x=1761672574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BAZJba7A6nBY7yoDhFHzYrb/taVSwwdFow1n8pp6qU=;
 b=U29WjgXC5SXBHW0KaPR2OWmYBZJZ7ojapdO3rVGiM6QwpbeNJAxzgrLkhk4LHtVMTB
 eXLKQFY9RxevaGobftsJGzi50xkkUqAafxkhpKqapkOio99Gv1p8cXB+jUo3QLgqd3wQ
 50g3FZFTnC471dirvGTUD13jIHf1O3ot8XM6lKIPQK2i8QdU9A3BdzFFsK4mV+AB42xy
 7YkfjZK6ncwi2IbBayVTG0nTi1cr6gv+QatLDvjCOd983jbdu1xlKLBaQr39TKRX7GXv
 3fTof60sBAQ0l32pBpoVmPdMoYUadnVdU+EEtEeQb+1K6adg7qhoIaJuMi4ujfgjP0Ta
 M8nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcFtPBvQx3eZV2C0J3A42sS/LLYjGq+LfscVbXHlKeFxNmmYIH29akVBA4197Slm8YRIWz1Js=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8PSdxU/rX0QSlR5Xys7gNgbcbtK9toqq3kewwUvdNaU/xd2gY
 65VjyJBI+swBJ/QV/bgEHFgASprdtx20eiT0X8Bz2Y2pP25Xo7QPKd+PFHEH0oqpF1s=
X-Gm-Gg: ASbGnctg/oZkdsfu942bIrxdLwr93b9AN5SOWqfFBQIt3UzmQEKl6s25Icungs1DZ+0
 JIEhZUsvQfAoJ7zS01ZC68gyqUn6iOV7S2w7VH7QvYNc1GLBP6GIGE7Y9FkVu/Vv0RZc8WZek1n
 /ydIeMJ5ILKYR6d+d4F/6bfee/flgdeDSqHwzqrSo8n8f3uFGVXuiUk4bE5NGYJIGuz2D+zrpvm
 OmsK+8DntvdvK3RDIz1YCJdL/90cwH2dgo8FmsxpSwcILNBbf1bKKSXaj3I+ROi77CGW1UGLk1R
 6J+g/37Z8G37YuK1WVjeO/8Sf01Tc0IKSfywhDsp2eeTZSwndALCuTj5bWU0Zk8O+FHo38phcVb
 OKinVgQVmXgRL+86oBB+WAUXboZhoGpt/Ps7uRmrBUsVA5V8G6T1vdMiGk348B69u7qOhh0Zno8
 331Tn8Y4wjkgMz/A0oQD2d/lW1ZjCF0WAV2vwbJkp67Kn1XBuWWw==
X-Google-Smtp-Source: AGHT+IFpHavv37j4b6DsngYLYt9vTrd2F4J42ElcUTJ5fo6RlhANLEjgGv5C7vo8KYjtI1IOBxQg9Q==
X-Received: by 2002:a05:6808:30a1:b0:43f:5e4b:42ae with SMTP id
 5614622812f47-443a2f1b92dmr8400433b6e.17.1761067774466; 
 Tue, 21 Oct 2025 10:29:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dfb2617bsm2800553b6e.26.2025.10.21.10.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 10:29:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:29:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251021172930.GE6688@bill-the-cat>
References: <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat> <87h5vsbt2t.fsf@kernel.org>
 <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
 <CAFLszTjw+LTvspVNrnxmc+kii+vMPU1qzV=1y3BSwWGXEvoagw@mail.gmail.com>
 <20251021144430.139b754b@kmaincent-XPS-13-7390>
 <20251021134907.GB6688@bill-the-cat>
 <20251021162919.7c0aba19@kmaincent-XPS-13-7390>
 <20251021143626.GC6688@bill-the-cat>
 <20251021185427.49c2f445@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hYjyaL76YbYlS1fn"
Content-Disposition: inline
In-Reply-To: <20251021185427.49c2f445@kmaincent-XPS-13-7390>
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


--hYjyaL76YbYlS1fn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 06:54:27PM +0200, Kory Maincent wrote:
> On Tue, 21 Oct 2025 08:36:26 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Oct 21, 2025 at 04:29:19PM +0200, Kory Maincent wrote:
> > > On Tue, 21 Oct 2025 07:49:07 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
> > > > On Tue, Oct 21, 2025 at 02:44:30PM +0200, Kory Maincent wrote: =20
> > > > > On Tue, 21 Oct 2025 10:52:05 +0100
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >    =20
> > > > > > Hi Kory,
> > > > > >=20
> > > > > > On Tue, Oct 21, 2025, 10:02 Kory Maincent <kory.maincent@bootli=
n.com>
> > > > > > wrote:  =20
> > > > > > > On Tue, 21 Oct 2025 09:40:58 +0200
> > > > > > > Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> > > > > > >     =20
> > > > > > > > On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com>
> > > > > > > > wrote:=20
> > > > > > > > > On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent w=
rote:
> > > > > > > > >    =20
> > > > > > > > >> On Mon, 20 Oct 2025 10:05:27 -0600
> > > > > > > > >> Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >>     =20
> > > > > > > > >> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent
> > > > > > > > >> > wrote:=20
> > > > > > > > >> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > > > > > > > >> > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >> > >     =20
> > > > > > > > >> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini
> > > > > > > > >> > > > wrote:     =20
> > > > > > > > >> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory M=
aincent
> > > > > > > > >> > > > > wrote:  =20
> > > > > > > > >> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > > > > > >> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >> > > > > >     =20
> > > > > > > > >> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Si=
mon
> > > > > > > > >> > > > > > > Glass=20
> > > > > > > wrote:     =20
> > > > > > > > >> > > > > > >     =20
> > > > > > > > >> > > > > > > > Hi Kory,
> > > > > > > > >> > > > > > > >
> > > > > > > > >> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent
> > > > > > > > >> > > > > > > > (TI.com) <kory.maincent@bootlin.com> wrote=
:     =20
> > > > > > > > >> > > > > > > > >
> > > > > > > > >> > > > > > > > > This series converts the extension board
> > > > > > > > >> > > > > > > > > framework to     =20
> > > > > > > use     =20
> > > > > > > > >> > > > > > > > > UCLASS as requested by Simon Glass, then=
 adds
> > > > > > > > >> > > > > > > > >    =20
> > > > > > > extension     =20
> > > > > > > > >> > > > > > > > > support to pxe_utils and bootmeth_efi (n=
ot
> > > > > > > > >> > > > > > > > > tested) to enable extension boards devic=
etree
> > > > > > > > >> > > > > > > > > load in the=20
> > > > > > > standard     =20
> > > > > > > > >> > > > > > > > > boot process.
> > > > > > > > >> > > > > > > > >
> > > > > > > > >> > > > > > > > > I can't test the imx8 extension scan ena=
bled
> > > > > > > > >> > > > > > > > > by the imx8mm-cl-iot-gate_defconfig as I=
 don't
> > > > > > > > >> > > > > > > > > have this=20
> > > > > > > board.     =20
> > > > > > > > >> > > > > > > > > I also can't test the efi bootmeth chang=
e as I
> > > > > > > > >> > > > > > > > > don't     =20
> > > > > > > have     =20
> > > > > > > > >> > > > > > > > > such board.     =20
> > > > > > > > >> > > > > > > >
> > > > > > > > >> > > > > > > > You can test this with sandbox, using one =
of the
> > > > > > > > >> > > > > > > >     =20
> > > > > > > bootmeth     =20
> > > > > > > > >> > > > > > > > tests, perhaps. Let me know if you need he=
lp with
> > > > > > > > >> > > > > > > > this.  =20
> > > > > > > > >> > > > > > >
> > > > > > > > >> > > > > > > But the question is, does the real hardware
> > > > > > > > >> > > > > > > platform work before/after this, not does the
> > > > > > > > >> > > > > > > sandbox test still work before/after this.  =
   =20
> > > > > > > > >> > > > > >
> > > > > > > > >> > > > > > It seems the bootlflow scan is not working on =
the
> > > > > > > > >> > > > > > sandbox     =20
> > > > > > > on next     =20
> > > > > > > > >> > > > > > branch. Is this issue known?     =20
> > > > > > > > >> > > > >
> > > > > > > > >> > > > > Is it fine on master? The next branch will be ou=
t of
> > > > > > > > >> > > > > date=20
> > > > > > > until it     =20
> > > > > > > > >> > > > > re-opens with -rc2 being released (2 weeks from
> > > > > > > > >> > > > > today).     =20
> > > > > > > > >> > > >
> > > > > > > > >> > > > ... out of sync local calendar, 3 weeks from today=
, not
> > > > > > > > >> > > > 2.=20
> > > > > > > > >> > >
> > > > > > > > >> > > bootstd test suit is not working on master with the =
    =20
> > > > > > > sandbox_defconfig:     =20
> > > > > > > > >> > > https://termbin.com/un0p
> > > > > > > > >> > >
> > > > > > > > >> > > Noticeable things are;
> > > > > > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > > > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x=
0 (0),
> > > > > > > > >> > > got 0xffffffed (-19) Test: bootdev_test_any: bootdev=
=2Ec
> > > > > > > > >> > > (flat tree) test/boot/bootdev.c:160, bootdev_test_an=
y(): 0
> > > > > > > > >> > > =3D=3D bootdev_find_by_any(seq, &dev, &mflags): Expe=
cted 0x0
> > > > > > > > >> > > (0), got 0xffffffed (-19) Test 'bootdev_test_any' fa=
iled 2
> > > > > > > > >> > > times
> > > > > > > > >> > >
> > > > > > > > >> > > And a nice segfault:
> > > > > > > > >> > > Test: bootflow_set_arg: bootflow.c
> > > > > > > > >> > > Test: bootflow_system: bootflow.c
> > > > > > > > >> > > [3]    569337 segmentation fault (core dumped)  ./u-=
boot
> > > > > > > > >> > >
> > > > > > > > >> > > Maybe things are missing to run sandbox_defconfig on=
 my
> > > > > > > > >> > > computer? With the sandbox64_defconfig there is not =
core
> > > > > > > > >> > > dump anymore but     =20
> > > > > > > there     =20
> > > > > > > > >> > > is still the failed line:
> > > > > > > > >> > > Test 'bootdev_test_bootable' failed 2 times
> > > > > > > > >> > >
> > > > > > > > >> > > And the uboot is reboot infinitely during the bootfl=
ow
> > > > > > > > >> > > test: ./u-boot -T -c "ut bootstd"
> > > > > > > > >> > > https://termbin.com/alu5     =20
> > > > > > > > >> >
> > > > > > > > >> > I see the same thing you do when running them outside =
of
> > > > > > > > >> > pytest, but they're also fine within pytest.
> > > > > > > > >> > https://docs.u-boot.org/en/latest/develop/pytest/usage=
=2Ehtml
> > > > > > > > >> > should     =20
> > > > > > > help     =20
> > > > > > > > >> > get you started, and you can just run all of the ut te=
sts
> > > > > > > > >> > under=20
> > > > > > > that.     =20
> > > > > > > > >>
> > > > > > > > >> Weird I got errors also within pytest.
> > > > > > > > >> See the html test log attached generated by the following
> > > > > > > > >> command: ./test/py/test.py --bd sandbox -k bootstd     =
=20
> > > > > > > > >
> > > > > > > > > Same. There's some implicit dependencies around I believe=
=2E Doing
> > > > > > > > > "-k     =20
> > > > > > > ut"     =20
> > > > > > > > > should work, as I tried that (via my wrapper around all t=
his) as
> > > > > > > > > well     =20
> > > > > > > as     =20
> > > > > > > > > just running all the tests (which is longer).     =20
> > > > > > > >
> > > > > > > > That's my understanding as well
> > > > > > > >
> > > > > > > > In Kory's log we see:
> > > > > > > >
> > > > > > > >         MMC:   Can't map file 'mmc1.img': Invalid argument
> > > > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mm=
c1.img'
> > > > > > > >         Can't map file 'mmc1.img': Invalid argument
> > > > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mm=
c1.img'
> > > > > > > >                    mmc_probe() mmc1 - probe failed: -1
> > > > > > > >         mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argu=
ment
> > > > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mm=
c1.img'
> > > > > > > >         , mmc0: 0 (SD)
> > > > > > > >
> > > > > > > > These mmc1.img are needed for the bootstd tests to run prop=
erly.
> > > > > > > >
> > > > > > > > These mmc*.img are generated in test_ut.py (see
> > > > > > > > setup_cros_image() for example)
> > > > > > > >
> > > > > > > > So, In order to only run the bootstd tests, I think we need=
 to to
> > > > > > > > run:
> > > > > > > >
> > > > > > > >     $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > > > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd
> > > > > > > >
> > > > > > > > Then we can just call:
> > > > > > > >
> > > > > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd    =
 =20
> > > > > > >
> > > > > > > Ok after installing missing dependencies and running test_ut =
tests I
> > > > > > > have less
> > > > > > > errors but there are still bootflow errors. See the test-log
> > > > > > > attached. I suppose all the tests should pass, right?
> > > > > > >     =20
> > > > > >=20
> > > > > > How are you running the tests? This is described in the docs. S=
earch
> > > > > > for 'tests'.
> > > > > >=20
> > > > > > https://docs.u-boot.org/en/latest/develop/tests_sandbox.html#ru=
nning-sandbox-tests-directly
> > > > > >   =20
> > > > >=20
> > > > > As discussed in the email thread running test directly does not w=
ork and
> > > > > segfault for the bootflow command.
> > > > > We have to run it under the test.py command to makes it work.
> > > > >=20
> > > > > The log I sent was for the following command:
> > > > > $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > > >=20
> > > > > The two errors on bootflow on master are:
> > > > > Test: bootflow_cmd_menu: bootflow.c
> > > > > test/boot/bootflow.c:673, bootflow_cmd_menu(): 0 =3D=3D
> > > > > run_command("bootflow menu", 0): Expected 0x0 (0), got 0x1 (1)
> > > > >=20
> > > > > test/boot/bootflow.c:718, bootflow_scan_menu(): console:=20
> > > > > Expected 'Selected: Armbian',
> > > > >      got '<no-more-output>'
> > > > >=20
> > > > > Tom do you face the same errors? If that's the case we should fix
> > > > > these.   =20
> > > >=20
> > > > No, I can do:
> > > > $ git clean -dfx
> > > > $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > > And the result is:
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 872 passed, 1 skipped=
, 608 deselected, 13398 warnings in
> > > > 55.73s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > > And this is on top of tree master right now. =20
> > >=20
> > > Oh ok weird, I just tried again on my side but still got 6 tests that
> > > failed. These tests are not related to my series so lets ignore these.
> > >=20
> > > Anyway, I don't see how I can test the extension support in bootmeth =
efi
> > > with sandbox, and it would be better to test it on a real board. Or at
> > > least that it does not break bootmeth efi for the current hardware
> > > platform. =20
> >=20
> > Do you have other changes for v3? If not, I'll apply that soon and we
> > can add more tests in a follow-up, if Simon can explain his thinking on
> > how it would work. If you do have changes for v4, same comments about
> > testing apply but I'll move v3 to superseded in patchwork so I don't
> > forget.
> =20
> As I said: "I saw that as I removed the extension hunter in this series it
> brings new test errors that need to be fixed."
> I think it is better avoid these CI build test errors and send a v4.

Thanks for clarifying, yes, I missed that at some point in this long
thread. :(

--=20
Tom

--hYjyaL76YbYlS1fn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPfC9wAKCRAr4qD1Cr/k
ClGSAPsEaL/ckPHazjF9Thu7GKXcdtw0tnPHko1q1RYcUH4cRgEArwgv4rtnUM9F
Z9iCvNPjjZbtKnUcNwNaSAcT6QU57QA=
=N7Ai
-----END PGP SIGNATURE-----

--hYjyaL76YbYlS1fn--
