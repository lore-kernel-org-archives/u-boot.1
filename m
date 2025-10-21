Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF7CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 14:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B9C0807C0;
	Tue, 21 Oct 2025 16:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="N8zLKsb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827D082B20; Tue, 21 Oct 2025 16:29:37 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722B4800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 16:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 175C01A1590;
 Tue, 21 Oct 2025 14:29:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DE44460680;
 Tue, 21 Oct 2025 14:29:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F699102F2410; 
 Tue, 21 Oct 2025 16:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761056972; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fsqzU85iJJzMvzCydcGxn0w7IHY4/zzTKGnJO9r7gVE=;
 b=N8zLKsb6tumAevgI8lxpJPpzHPma0DYEzuarb3bYKtN3E9EXWV63hZhDNGe16GMKfryqMZ
 hzwG7RctHbr0/UNOXEd7DTzjlU8WPYIN3nuvcuF+h7JZdkiOsNP9L/3ZNR2kZfz7MltoFp
 tgo8O7eIk+uZoZHJT5nvbrs6wvMGzlBbDSQ5x5yOgDVCuSnCMyEBn0smrc1daL6qdWUyrR
 KreEtPwW9l5zF2E6OM0/ZvT0eGjkttRZZgXlpAZWuW0+jWqdec1BkcFXF8eNAhx2M+eUnB
 m7lbWd2u/loT4qPeh802RxHvQkOqcZ/fQVk4Ml3F8CArK/BMIms9rE9Gq05zLw==
Date: Tue, 21 Oct 2025 16:29:19 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>, Andre
 Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>,
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, Roger Quadros
 <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251021162919.7c0aba19@kmaincent-XPS-13-7390>
In-Reply-To: <20251021134907.GB6688@bill-the-cat>
References: <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat> <87h5vsbt2t.fsf@kernel.org>
 <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
 <CAFLszTjw+LTvspVNrnxmc+kii+vMPU1qzV=1y3BSwWGXEvoagw@mail.gmail.com>
 <20251021144430.139b754b@kmaincent-XPS-13-7390>
 <20251021134907.GB6688@bill-the-cat>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue, 21 Oct 2025 07:49:07 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Tue, Oct 21, 2025 at 02:44:30PM +0200, Kory Maincent wrote:
> > On Tue, 21 Oct 2025 10:52:05 +0100
> > Simon Glass <sjg@chromium.org> wrote:
> >  =20
> > > Hi Kory,
> > >=20
> > > On Tue, Oct 21, 2025, 10:02 Kory Maincent <kory.maincent@bootlin.com>
> > > wrote:=20
> > > > On Tue, 21 Oct 2025 09:40:58 +0200
> > > > Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> > > >   =20
> > > > > On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > >   =20
> > > > > > On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote: =
  =20
> > > > > >> On Mon, 20 Oct 2025 10:05:27 -0600
> > > > > >> Tom Rini <trini@konsulko.com> wrote:
> > > > > >>   =20
> > > > > >> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrot=
e:
> > > > > >> > =20
> > > > > >> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > > > > >> > > Tom Rini <trini@konsulko.com> wrote:
> > > > > >> > >   =20
> > > > > >> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote=
:   =20
> > > > > >> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent
> > > > > >> > > > > wrote:=20
> > > > > >> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > > >> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > >> > > > > >   =20
> > > > > >> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Gl=
ass
> > > > > >> > > > > > >  =20
> > > > wrote:   =20
> > > > > >> > > > > > >   =20
> > > > > >> > > > > > > > Hi Kory,
> > > > > >> > > > > > > >
> > > > > >> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.=
com)
> > > > > >> > > > > > > > <kory.maincent@bootlin.com> wrote:   =20
> > > > > >> > > > > > > > >
> > > > > >> > > > > > > > > This series converts the extension board frame=
work
> > > > > >> > > > > > > > > to   =20
> > > > use   =20
> > > > > >> > > > > > > > > UCLASS as requested by Simon Glass, then adds =
  =20
> > > > extension   =20
> > > > > >> > > > > > > > > support to pxe_utils and bootmeth_efi (not tes=
ted)
> > > > > >> > > > > > > > > to enable extension boards devicetree load in =
the
> > > > > >> > > > > > > > >  =20
> > > > standard   =20
> > > > > >> > > > > > > > > boot process.
> > > > > >> > > > > > > > >
> > > > > >> > > > > > > > > I can't test the imx8 extension scan enabled b=
y the
> > > > > >> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have t=
his
> > > > > >> > > > > > > > >  =20
> > > > board.   =20
> > > > > >> > > > > > > > > I also can't test the efi bootmeth change as I
> > > > > >> > > > > > > > > don't   =20
> > > > have   =20
> > > > > >> > > > > > > > > such board.   =20
> > > > > >> > > > > > > >
> > > > > >> > > > > > > > You can test this with sandbox, using one of the=
   =20
> > > > bootmeth   =20
> > > > > >> > > > > > > > tests, perhaps. Let me know if you need help with
> > > > > >> > > > > > > > this.=20
> > > > > >> > > > > > >
> > > > > >> > > > > > > But the question is, does the real hardware platfo=
rm
> > > > > >> > > > > > > work before/after this, not does the sandbox test
> > > > > >> > > > > > > still work before/after this.   =20
> > > > > >> > > > > >
> > > > > >> > > > > > It seems the bootlflow scan is not working on the
> > > > > >> > > > > > sandbox   =20
> > > > on next   =20
> > > > > >> > > > > > branch. Is this issue known?   =20
> > > > > >> > > > >
> > > > > >> > > > > Is it fine on master? The next branch will be out of d=
ate
> > > > > >> > > > >  =20
> > > > until it   =20
> > > > > >> > > > > re-opens with -rc2 being released (2 weeks from today)=
.   =20
> > > > > >> > > >
> > > > > >> > > > ... out of sync local calendar, 3 weeks from today, not =
2.
> > > > > >> > > > =20
> > > > > >> > >
> > > > > >> > > bootstd test suit is not working on master with the   =20
> > > > sandbox_defconfig:   =20
> > > > > >> > > https://termbin.com/un0p
> > > > > >> > >
> > > > > >> > > Noticeable things are;
> > > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0),=
 got
> > > > > >> > > 0xffffffed (-19) Test: bootdev_test_any: bootdev.c (flat t=
ree)
> > > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0),=
 got
> > > > > >> > > 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> > > > > >> > >
> > > > > >> > > And a nice segfault:
> > > > > >> > > Test: bootflow_set_arg: bootflow.c
> > > > > >> > > Test: bootflow_system: bootflow.c
> > > > > >> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
> > > > > >> > >
> > > > > >> > > Maybe things are missing to run sandbox_defconfig on my
> > > > > >> > > computer? With the sandbox64_defconfig there is not core d=
ump
> > > > > >> > > anymore but   =20
> > > > there   =20
> > > > > >> > > is still the failed line:
> > > > > >> > > Test 'bootdev_test_bootable' failed 2 times
> > > > > >> > >
> > > > > >> > > And the uboot is reboot infinitely during the bootflow tes=
t:
> > > > > >> > > ./u-boot -T -c "ut bootstd"
> > > > > >> > > https://termbin.com/alu5   =20
> > > > > >> >
> > > > > >> > I see the same thing you do when running them outside of pyt=
est,
> > > > > >> > but they're also fine within pytest.
> > > > > >> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html
> > > > > >> > should   =20
> > > > help   =20
> > > > > >> > get you started, and you can just run all of the ut tests un=
der
> > > > > >> >  =20
> > > > that.   =20
> > > > > >>
> > > > > >> Weird I got errors also within pytest.
> > > > > >> See the html test log attached generated by the following comm=
and:
> > > > > >> ./test/py/test.py --bd sandbox -k bootstd   =20
> > > > > >
> > > > > > Same. There's some implicit dependencies around I believe. Doing
> > > > > > "-k   =20
> > > > ut"   =20
> > > > > > should work, as I tried that (via my wrapper around all this) as
> > > > > > well   =20
> > > > as   =20
> > > > > > just running all the tests (which is longer).   =20
> > > > >
> > > > > That's my understanding as well
> > > > >
> > > > > In Kory's log we see:
> > > > >
> > > > >         MMC:   Can't map file 'mmc1.img': Invalid argument
> > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > > >         Can't map file 'mmc1.img': Invalid argument
> > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > > >                    mmc_probe() mmc1 - probe failed: -1
> > > > >         mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
> > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > > >         , mmc0: 0 (SD)
> > > > >
> > > > > These mmc1.img are needed for the bootstd tests to run properly.
> > > > >
> > > > > These mmc*.img are generated in test_ut.py (see setup_cros_image(=
) for
> > > > > example)
> > > > >
> > > > > So, In order to only run the bootstd tests, I think we need to to=
 run:
> > > > >
> > > > >     $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd
> > > > >
> > > > > Then we can just call:
> > > > >
> > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd   =20
> > > >
> > > > Ok after installing missing dependencies and running test_ut tests I
> > > > have less
> > > > errors but there are still bootflow errors. See the test-log attach=
ed.
> > > > I suppose all the tests should pass, right?
> > > >   =20
> > >=20
> > > How are you running the tests? This is described in the docs. Search =
for
> > > 'tests'.
> > >=20
> > > https://docs.u-boot.org/en/latest/develop/tests_sandbox.html#running-=
sandbox-tests-directly
> > > =20
> >=20
> > As discussed in the email thread running test directly does not work and
> > segfault for the bootflow command.
> > We have to run it under the test.py command to makes it work.
> >=20
> > The log I sent was for the following command:
> > $ ./test/py/test.py --bd sandbox --build -k test_ut
> >=20
> > The two errors on bootflow on master are:
> > Test: bootflow_cmd_menu: bootflow.c
> > test/boot/bootflow.c:673, bootflow_cmd_menu(): 0 =3D=3D run_command("bo=
otflow
> > menu", 0): Expected 0x0 (0), got 0x1 (1)
> >=20
> > test/boot/bootflow.c:718, bootflow_scan_menu(): console:=20
> > Expected 'Selected: Armbian',
> >      got '<no-more-output>'
> >=20
> > Tom do you face the same errors? If that's the case we should fix these=
. =20
>=20
> No, I can do:
> $ git clean -dfx
> $ ./test/py/test.py --bd sandbox --build -k test_ut
> And the result is:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 872 passed, 1 skipped, 608 =
deselected, 13398 warnings in
> 55.73s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> And this is on top of tree master right now.

Oh ok weird, I just tried again on my side but still got 6 tests that faile=
d.
These tests are not related to my series so lets ignore these.

Anyway, I don't see how I can test the extension support in bootmeth efi wi=
th
sandbox, and it would be better to test it on a real board. Or at least tha=
t it
does not break bootmeth efi for the current hardware platform.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
