Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889B1CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 14:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEBC807C0;
	Tue, 21 Oct 2025 16:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hzDTIItS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D69829E7; Tue, 21 Oct 2025 16:36:34 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D971800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 16:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c2730d8fb0so3594465a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761057391; x=1761662191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oVtWYAI1Tt4N/76i9BGqHY6Wv8kW7/z18y0SU4NEadM=;
 b=hzDTIItSUCVDuvMqAPGFF2VimKAxsE4VYoSKN13TtkdkAQx/42t3u73kI2op02G5Bg
 XSVStoT3SInmKGxUiQO1mcbXfFT0Nsz68bLV9Ly3uefSnb/ihnkcjbbBNlxWH+xTr8+Z
 TyeCFXNW0ERyLcmc27NS/a3G9UuYOR1giHYyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761057391; x=1761662191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVtWYAI1Tt4N/76i9BGqHY6Wv8kW7/z18y0SU4NEadM=;
 b=vOTU/2OlnAU6FL67UYOPA2SVZ97lGPDn9WljShYb3oxTWfGn2Qz+EoqJN2AgCixB4F
 Q4Hp81Ru6AQhVKZe/nGCKLfP8xXWaZ1/Fg57lpbtcUHUhCt5KeZEds+Ufil8YCybOPCP
 BanmrvCnTix+Siu4q1PJsY3sIeC7yMTPDUdm10EPLS+FKf2qXqTP+bmSoqfIbR44blqU
 ukVJnxfZPqQ/eYlSa2tgUyCX5vjhlmQ8zF52tfEYTR2+1l4Q7hfY5aGdpUvmUetlNPbJ
 3vUqo2nlGI2xcqbAcGAO+ndRlityJ/g4QXMOOkBQb3GlUdE/hMqs4E50rpmVMp4wvr9/
 WTGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5660+qQ5YpmSkztMjWsdtKBX6cYCZUi0q++gmYJt0wyCAuAQK1SJhovFtv7Hw1bo2ip3qcpU=@lists.denx.de
X-Gm-Message-State: AOJu0YwFmXinDNmFuoxJU04BOxlL6hgVwkxz5X04xY8ZYRUycIPaJvur
 DlOEm96vFTL5cHhJWxknm0U3P0oyPtlIEfYsmLoonK7j30HkmxMECJb3uyzaupXwSQY=
X-Gm-Gg: ASbGncvSmiD57dX03jQWtnENsLyhqVPOIH8FcQQctX5In9f5xeJjIzF7cODULw+/l2j
 Xdazp8Cx1dUUUCIrYKierSIr5OVnxJS3cuwEIhroBhtY91CaP1525A4VnoB4KJwULWP03OI2CSe
 rQPkIu6YtNAI1km5dz/jJibFy1i3W6LicCUr3ilpU9P5FzEz7JdvK2PYWl7gZplTGF6mfqpl27p
 CSDGVIgJwtddZkGXIlF56JBpcpHuWy7nAquVMlEkuZ/5pbER6GcdLYljlscfsJvvXHQNjam3ckQ
 s66yRHJQ0pNQ1yAHdysFucWtRewr7z5zS11Hdtj1phWP3t1z5ts3iH5IMCmjiNKHbSj1yiIvlQG
 wgAifDHVdYu/bMhnos6WMpXwUNYu/S0usQhHefA/3kGiYQXSlpaNcynonoZBqGWB0/ITzwFfWQT
 T+dchVB95zRWGwTZsNKu6Vg3j8XGWsA/rEgRmI6x1kHX6uQCeiJg==
X-Google-Smtp-Source: AGHT+IEHzPUkKp+rjbQCSjt374/gzBj2si0HXQVD6PEiX9xGZRiBBM1/7HprEIKnvAeFPiSpvqySAg==
X-Received: by 2002:a05:6830:6585:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7c27cc53e63mr9805203a34.23.1761057390780; 
 Tue, 21 Oct 2025 07:36:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2887b926fsm3744721a34.14.2025.10.21.07.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 07:36:29 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:36:26 -0600
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
Message-ID: <20251021143626.GC6688@bill-the-cat>
References: <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat> <87h5vsbt2t.fsf@kernel.org>
 <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
 <CAFLszTjw+LTvspVNrnxmc+kii+vMPU1qzV=1y3BSwWGXEvoagw@mail.gmail.com>
 <20251021144430.139b754b@kmaincent-XPS-13-7390>
 <20251021134907.GB6688@bill-the-cat>
 <20251021162919.7c0aba19@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z/LNfcEE+MKqR3Jr"
Content-Disposition: inline
In-Reply-To: <20251021162919.7c0aba19@kmaincent-XPS-13-7390>
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


--Z/LNfcEE+MKqR3Jr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 04:29:19PM +0200, Kory Maincent wrote:
> On Tue, 21 Oct 2025 07:49:07 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Oct 21, 2025 at 02:44:30PM +0200, Kory Maincent wrote:
> > > On Tue, 21 Oct 2025 10:52:05 +0100
> > > Simon Glass <sjg@chromium.org> wrote:
> > >  =20
> > > > Hi Kory,
> > > >=20
> > > > On Tue, Oct 21, 2025, 10:02 Kory Maincent <kory.maincent@bootlin.co=
m>
> > > > wrote:=20
> > > > > On Tue, 21 Oct 2025 09:40:58 +0200
> > > > > Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> > > > >   =20
> > > > > > On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > >   =20
> > > > > > > On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote=
:   =20
> > > > > > >> On Mon, 20 Oct 2025 10:05:27 -0600
> > > > > > >> Tom Rini <trini@konsulko.com> wrote:
> > > > > > >>   =20
> > > > > > >> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wr=
ote:
> > > > > > >> > =20
> > > > > > >> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > > > > > >> > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > >> > >   =20
> > > > > > >> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wro=
te:   =20
> > > > > > >> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Mainc=
ent
> > > > > > >> > > > > wrote:=20
> > > > > > >> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > > > >> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > > > >> > > > > >   =20
> > > > > > >> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon =
Glass
> > > > > > >> > > > > > >  =20
> > > > > wrote:   =20
> > > > > > >> > > > > > >   =20
> > > > > > >> > > > > > > > Hi Kory,
> > > > > > >> > > > > > > >
> > > > > > >> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (T=
I.com)
> > > > > > >> > > > > > > > <kory.maincent@bootlin.com> wrote:   =20
> > > > > > >> > > > > > > > >
> > > > > > >> > > > > > > > > This series converts the extension board fra=
mework
> > > > > > >> > > > > > > > > to   =20
> > > > > use   =20
> > > > > > >> > > > > > > > > UCLASS as requested by Simon Glass, then add=
s   =20
> > > > > extension   =20
> > > > > > >> > > > > > > > > support to pxe_utils and bootmeth_efi (not t=
ested)
> > > > > > >> > > > > > > > > to enable extension boards devicetree load i=
n the
> > > > > > >> > > > > > > > >  =20
> > > > > standard   =20
> > > > > > >> > > > > > > > > boot process.
> > > > > > >> > > > > > > > >
> > > > > > >> > > > > > > > > I can't test the imx8 extension scan enabled=
 by the
> > > > > > >> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have=
 this
> > > > > > >> > > > > > > > >  =20
> > > > > board.   =20
> > > > > > >> > > > > > > > > I also can't test the efi bootmeth change as=
 I
> > > > > > >> > > > > > > > > don't   =20
> > > > > have   =20
> > > > > > >> > > > > > > > > such board.   =20
> > > > > > >> > > > > > > >
> > > > > > >> > > > > > > > You can test this with sandbox, using one of t=
he   =20
> > > > > bootmeth   =20
> > > > > > >> > > > > > > > tests, perhaps. Let me know if you need help w=
ith
> > > > > > >> > > > > > > > this.=20
> > > > > > >> > > > > > >
> > > > > > >> > > > > > > But the question is, does the real hardware plat=
form
> > > > > > >> > > > > > > work before/after this, not does the sandbox test
> > > > > > >> > > > > > > still work before/after this.   =20
> > > > > > >> > > > > >
> > > > > > >> > > > > > It seems the bootlflow scan is not working on the
> > > > > > >> > > > > > sandbox   =20
> > > > > on next   =20
> > > > > > >> > > > > > branch. Is this issue known?   =20
> > > > > > >> > > > >
> > > > > > >> > > > > Is it fine on master? The next branch will be out of=
 date
> > > > > > >> > > > >  =20
> > > > > until it   =20
> > > > > > >> > > > > re-opens with -rc2 being released (2 weeks from toda=
y).   =20
> > > > > > >> > > >
> > > > > > >> > > > ... out of sync local calendar, 3 weeks from today, no=
t 2.
> > > > > > >> > > > =20
> > > > > > >> > >
> > > > > > >> > > bootstd test suit is not working on master with the   =
=20
> > > > > sandbox_defconfig:   =20
> > > > > > >> > > https://termbin.com/un0p
> > > > > > >> > >
> > > > > > >> > > Noticeable things are;
> > > > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0=
), got
> > > > > > >> > > 0xffffffed (-19) Test: bootdev_test_any: bootdev.c (flat=
 tree)
> > > > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0=
), got
> > > > > > >> > > 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> > > > > > >> > >
> > > > > > >> > > And a nice segfault:
> > > > > > >> > > Test: bootflow_set_arg: bootflow.c
> > > > > > >> > > Test: bootflow_system: bootflow.c
> > > > > > >> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
> > > > > > >> > >
> > > > > > >> > > Maybe things are missing to run sandbox_defconfig on my
> > > > > > >> > > computer? With the sandbox64_defconfig there is not core=
 dump
> > > > > > >> > > anymore but   =20
> > > > > there   =20
> > > > > > >> > > is still the failed line:
> > > > > > >> > > Test 'bootdev_test_bootable' failed 2 times
> > > > > > >> > >
> > > > > > >> > > And the uboot is reboot infinitely during the bootflow t=
est:
> > > > > > >> > > ./u-boot -T -c "ut bootstd"
> > > > > > >> > > https://termbin.com/alu5   =20
> > > > > > >> >
> > > > > > >> > I see the same thing you do when running them outside of p=
ytest,
> > > > > > >> > but they're also fine within pytest.
> > > > > > >> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html
> > > > > > >> > should   =20
> > > > > help   =20
> > > > > > >> > get you started, and you can just run all of the ut tests =
under
> > > > > > >> >  =20
> > > > > that.   =20
> > > > > > >>
> > > > > > >> Weird I got errors also within pytest.
> > > > > > >> See the html test log attached generated by the following co=
mmand:
> > > > > > >> ./test/py/test.py --bd sandbox -k bootstd   =20
> > > > > > >
> > > > > > > Same. There's some implicit dependencies around I believe. Do=
ing
> > > > > > > "-k   =20
> > > > > ut"   =20
> > > > > > > should work, as I tried that (via my wrapper around all this)=
 as
> > > > > > > well   =20
> > > > > as   =20
> > > > > > > just running all the tests (which is longer).   =20
> > > > > >
> > > > > > That's my understanding as well
> > > > > >
> > > > > > In Kory's log we see:
> > > > > >
> > > > > >         MMC:   Can't map file 'mmc1.img': Invalid argument
> > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.i=
mg'
> > > > > >         Can't map file 'mmc1.img': Invalid argument
> > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.i=
mg'
> > > > > >                    mmc_probe() mmc1 - probe failed: -1
> > > > > >         mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
> > > > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.i=
mg'
> > > > > >         , mmc0: 0 (SD)
> > > > > >
> > > > > > These mmc1.img are needed for the bootstd tests to run properly.
> > > > > >
> > > > > > These mmc*.img are generated in test_ut.py (see setup_cros_imag=
e() for
> > > > > > example)
> > > > > >
> > > > > > So, In order to only run the bootstd tests, I think we need to =
to run:
> > > > > >
> > > > > >     $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd
> > > > > >
> > > > > > Then we can just call:
> > > > > >
> > > > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd   =20
> > > > >
> > > > > Ok after installing missing dependencies and running test_ut test=
s I
> > > > > have less
> > > > > errors but there are still bootflow errors. See the test-log atta=
ched.
> > > > > I suppose all the tests should pass, right?
> > > > >   =20
> > > >=20
> > > > How are you running the tests? This is described in the docs. Searc=
h for
> > > > 'tests'.
> > > >=20
> > > > https://docs.u-boot.org/en/latest/develop/tests_sandbox.html#runnin=
g-sandbox-tests-directly
> > > > =20
> > >=20
> > > As discussed in the email thread running test directly does not work =
and
> > > segfault for the bootflow command.
> > > We have to run it under the test.py command to makes it work.
> > >=20
> > > The log I sent was for the following command:
> > > $ ./test/py/test.py --bd sandbox --build -k test_ut
> > >=20
> > > The two errors on bootflow on master are:
> > > Test: bootflow_cmd_menu: bootflow.c
> > > test/boot/bootflow.c:673, bootflow_cmd_menu(): 0 =3D=3D run_command("=
bootflow
> > > menu", 0): Expected 0x0 (0), got 0x1 (1)
> > >=20
> > > test/boot/bootflow.c:718, bootflow_scan_menu(): console:=20
> > > Expected 'Selected: Armbian',
> > >      got '<no-more-output>'
> > >=20
> > > Tom do you face the same errors? If that's the case we should fix the=
se. =20
> >=20
> > No, I can do:
> > $ git clean -dfx
> > $ ./test/py/test.py --bd sandbox --build -k test_ut
> > And the result is:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 872 passed, 1 skipped, 60=
8 deselected, 13398 warnings in
> > 55.73s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > And this is on top of tree master right now.
>=20
> Oh ok weird, I just tried again on my side but still got 6 tests that fai=
led.
> These tests are not related to my series so lets ignore these.
>=20
> Anyway, I don't see how I can test the extension support in bootmeth efi =
with
> sandbox, and it would be better to test it on a real board. Or at least t=
hat it
> does not break bootmeth efi for the current hardware platform.

Do you have other changes for v3? If not, I'll apply that soon and we
can add more tests in a follow-up, if Simon can explain his thinking on
how it would work. If you do have changes for v4, same comments about
testing apply but I'll move v3 to superseded in patchwork so I don't
forget.

--=20
Tom

--Z/LNfcEE+MKqR3Jr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPeaYgAKCRAr4qD1Cr/k
Cl21AQDBSpPdJ7NCrkg/+IAn+FaCt0ldITRPNo6wwggNF+FzEgEAkNcCjY6rXvid
WABuvmzkIosTU3pBNGcJqNr/EauL/gA=
=Njxx
-----END PGP SIGNATURE-----

--Z/LNfcEE+MKqR3Jr--
