Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8ECCD1AA
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 13:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8BD80107;
	Tue, 21 Oct 2025 15:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sDgt5gyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA85A802C1; Tue, 21 Oct 2025 15:49:15 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30ADC800D7
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 15:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3c9859913d0so2677594fac.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761054552; x=1761659352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K0g21JA2SQ8X/HIC+pyPmDldAtFndEYevCcr/o8x5NE=;
 b=sDgt5gyroAgpB0k/tuvERSd4kvXKq2Q5xjfNCPy2gcK6t+tcLcS3mbeW/4sqXPYfZc
 TMzzvaxIipOVM1ekEvo4XzWZEKBm8ANS4TA6buWiJ98/YqO7iAwbFJJLfukRaCHu2eMX
 eQSVvdnn8oghffOMiyXcMqA/GaQQGrw3Jng2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761054552; x=1761659352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0g21JA2SQ8X/HIC+pyPmDldAtFndEYevCcr/o8x5NE=;
 b=PF152Mg2gpvvf2kCw0a+AWQE5CMYMBdIy4ucG6Fk6qpQWfpBnAkt5r4rzn9Xm9xzDr
 XrME9G/LdkzWFXjrcfQOruix9d0H5MRYMfmeZBoPopGAvGCK4uieYAgrh75W+qHhnvv3
 Oc0lM6+TzsOBepSND8R3SjPi5FM7F4SNhhvl7iEFFxKfTEUwzMHtGPB9hdwFtHQvI3x5
 ogzaAQrbOcSYaoorsFan5R7fdmskl1wnHDb0EuuWxjlyXsPe5O6mHEGMkfuC6jKkCCO2
 2Atfo+1M0RZBjEzPNQt5oEXoEF1LCrX+3/7iUe4YOKGdLvnpMwTN7mT7LzzSankkiPzS
 weLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7HN1Mc02lbsQxlPmAjCVNb8DS+QbxcSHjC6WPOUAj4F6rMgyzdBcx7ttxtw4exNJhUvbotk=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ1iyIrdZBzN7RHXtYyBkuST4IN7QX9ioShUjEraz4j+/dpAGW
 uXeCmw6aqFfG8+D1N63OjjtoCQzHqPdTJTKxqfP2k/uSMLWDBCXFz7QbB9niEn5MAoU=
X-Gm-Gg: ASbGncuULKXwbg7x0bs6D22NsvJi8DfudzyPigd0k7JLFafXdmlegGth55MMYwfnzYj
 dYWjrZXHT4b+wDhGq4TPm3RQUJvRv2ywZ/CQgQEhNyKuD+FLVf4GzAQ8kx9bKgqt0SAV18IdA0K
 1rP4g6AjffrIzHCn7PBNZ/TCVQl/wBbebUnL2BRrnr5jSrM/KUh1qGPPuiRn2VSb8hxLH2woGbR
 XadWcJ2pSft9tY3alEtOlvEvUyVaoORGnqwr90m/KmncO/ZsSMdmIwnCo2XL87xk4RdyJSfMWM2
 jx9aFCVLtb2dvAxj0RSxD4ATk5/PpUS4IUttg/WUMEHa9Zd5cLKAf2snk3SlL5jvuvk2VGDs+n8
 aE5owcq+rdJv1KcXwdxyNPTTUTZVAVRaZhG8oVDsxfoc/6580A9gw57oZnxxwnfMd9KgyoQNAB/
 4rbFpyQbGwwBWD9/XDhE/QLp341M83Bj9iX/Z7wFS1Wz6s4scYLg==
X-Google-Smtp-Source: AGHT+IG1ZBNvg/EvoOe94oKqh2/yF92eAq+r2Wo04u6+0veo4kAl3MnK4sDEenI5YSaRn8nq8UxiRw==
X-Received: by 2002:a05:6870:959a:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-3c98cf25491mr6890357fac.6.1761054551721; 
 Tue, 21 Oct 2025 06:49:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af31d53bsm3137975fac.12.2025.10.21.06.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 06:49:10 -0700 (PDT)
Date: Tue, 21 Oct 2025 07:49:07 -0600
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
Message-ID: <20251021134907.GB6688@bill-the-cat>
References: <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
 <20251020190854.4b318829@kmaincent-XPS-13-7390>
 <20251020171707.GA6688@bill-the-cat> <87h5vsbt2t.fsf@kernel.org>
 <20251021110225.2d94a13b@kmaincent-XPS-13-7390>
 <CAFLszTjw+LTvspVNrnxmc+kii+vMPU1qzV=1y3BSwWGXEvoagw@mail.gmail.com>
 <20251021144430.139b754b@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EKLHVpO/lVi4bKQk"
Content-Disposition: inline
In-Reply-To: <20251021144430.139b754b@kmaincent-XPS-13-7390>
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


--EKLHVpO/lVi4bKQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 02:44:30PM +0200, Kory Maincent wrote:
> On Tue, 21 Oct 2025 10:52:05 +0100
> Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Kory,
> >=20
> > On Tue, Oct 21, 2025, 10:02 Kory Maincent <kory.maincent@bootlin.com> w=
rote:
> >=20
> > > On Tue, 21 Oct 2025 09:40:58 +0200
> > > Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> > > =20
> > > > On Mon, Oct 20, 2025 at 11:17, Tom Rini <trini@konsulko.com> wrote:
> > > > =20
> > > > > On Mon, Oct 20, 2025 at 07:08:54PM +0200, Kory Maincent wrote: =
=20
> > > > >> On Mon, 20 Oct 2025 10:05:27 -0600
> > > > >> Tom Rini <trini@konsulko.com> wrote:
> > > > >> =20
> > > > >> > On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:=
 =20
> > > > >> > > On Mon, 20 Oct 2025 08:37:29 -0600
> > > > >> > > Tom Rini <trini@konsulko.com> wrote:
> > > > >> > > =20
> > > > >> > > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote: =
=20
> > > > >> > > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent =
wrote:
> > > > >> > > > > =20
> > > > >> > > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > >> > > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > >> > > > > > =20
> > > > >> > > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glas=
s =20
> > > wrote: =20
> > > > >> > > > > > > =20
> > > > >> > > > > > > > Hi Kory,
> > > > >> > > > > > > >
> > > > >> > > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.co=
m)
> > > > >> > > > > > > > <kory.maincent@bootlin.com> wrote: =20
> > > > >> > > > > > > > >
> > > > >> > > > > > > > > This series converts the extension board framewo=
rk to =20
> > > use =20
> > > > >> > > > > > > > > UCLASS as requested by Simon Glass, then adds =
=20
> > > extension =20
> > > > >> > > > > > > > > support to pxe_utils and bootmeth_efi (not teste=
d) to
> > > > >> > > > > > > > > enable extension boards devicetree load in the =
=20
> > > standard =20
> > > > >> > > > > > > > > boot process.
> > > > >> > > > > > > > >
> > > > >> > > > > > > > > I can't test the imx8 extension scan enabled by =
the
> > > > >> > > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have thi=
s =20
> > > board. =20
> > > > >> > > > > > > > > I also can't test the efi bootmeth change as I d=
on't =20
> > > have =20
> > > > >> > > > > > > > > such board. =20
> > > > >> > > > > > > >
> > > > >> > > > > > > > You can test this with sandbox, using one of the =
=20
> > > bootmeth =20
> > > > >> > > > > > > > tests, perhaps. Let me know if you need help with =
this.
> > > > >> > > > > > > > =20
> > > > >> > > > > > >
> > > > >> > > > > > > But the question is, does the real hardware platform=
 work
> > > > >> > > > > > > before/after this, not does the sandbox test still w=
ork
> > > > >> > > > > > > before/after this. =20
> > > > >> > > > > >
> > > > >> > > > > > It seems the bootlflow scan is not working on the sand=
box =20
> > > on next =20
> > > > >> > > > > > branch. Is this issue known? =20
> > > > >> > > > >
> > > > >> > > > > Is it fine on master? The next branch will be out of dat=
e =20
> > > until it =20
> > > > >> > > > > re-opens with -rc2 being released (2 weeks from today). =
=20
> > > > >> > > >
> > > > >> > > > ... out of sync local calendar, 3 weeks from today, not 2.=
 =20
> > > > >> > >
> > > > >> > > bootstd test suit is not working on master with the =20
> > > sandbox_defconfig: =20
> > > > >> > > https://termbin.com/un0p
> > > > >> > >
> > > > >> > > Noticeable things are;
> > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0), g=
ot
> > > > >> > > 0xffffffed (-19) Test: bootdev_test_any: bootdev.c (flat tre=
e)
> > > > >> > > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D
> > > > >> > > bootdev_find_by_any(seq, &dev, &mflags): Expected 0x0 (0), g=
ot
> > > > >> > > 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> > > > >> > >
> > > > >> > > And a nice segfault:
> > > > >> > > Test: bootflow_set_arg: bootflow.c
> > > > >> > > Test: bootflow_system: bootflow.c
> > > > >> > > [3]    569337 segmentation fault (core dumped)  ./u-boot
> > > > >> > >
> > > > >> > > Maybe things are missing to run sandbox_defconfig on my comp=
uter?
> > > > >> > > With the sandbox64_defconfig there is not core dump anymore =
but =20
> > > there =20
> > > > >> > > is still the failed line:
> > > > >> > > Test 'bootdev_test_bootable' failed 2 times
> > > > >> > >
> > > > >> > > And the uboot is reboot infinitely during the bootflow test:
> > > > >> > > ./u-boot -T -c "ut bootstd"
> > > > >> > > https://termbin.com/alu5 =20
> > > > >> >
> > > > >> > I see the same thing you do when running them outside of pytes=
t, but
> > > > >> > they're also fine within pytest.
> > > > >> > https://docs.u-boot.org/en/latest/develop/pytest/usage.html sh=
ould =20
> > > help =20
> > > > >> > get you started, and you can just run all of the ut tests unde=
r =20
> > > that. =20
> > > > >>
> > > > >> Weird I got errors also within pytest.
> > > > >> See the html test log attached generated by the following comman=
d:
> > > > >> ./test/py/test.py --bd sandbox -k bootstd =20
> > > > >
> > > > > Same. There's some implicit dependencies around I believe. Doing =
"-k =20
> > > ut" =20
> > > > > should work, as I tried that (via my wrapper around all this) as =
well =20
> > > as =20
> > > > > just running all the tests (which is longer). =20
> > > >
> > > > That's my understanding as well
> > > >
> > > > In Kory's log we see:
> > > >
> > > >         MMC:   Can't map file 'mmc1.img': Invalid argument
> > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > >         Can't map file 'mmc1.img': Invalid argument
> > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > >                    mmc_probe() mmc1 - probe failed: -1
> > > >         mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
> > > >            sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> > > >         , mmc0: 0 (SD)
> > > >
> > > > These mmc1.img are needed for the bootstd tests to run properly.
> > > >
> > > > These mmc*.img are generated in test_ut.py (see setup_cros_image() =
for
> > > > example)
> > > >
> > > > So, In order to only run the bootstd tests, I think we need to to r=
un:
> > > >
> > > >     $ ./test/py/test.py --bd sandbox --build -k test_ut
> > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd
> > > >
> > > > Then we can just call:
> > > >
> > > >     $ ./test/py/test.py --bd sandbox --build -k bootstd =20
> > >
> > > Ok after installing missing dependencies and running test_ut tests I =
have
> > > less
> > > errors but there are still bootflow errors. See the test-log attached.
> > > I suppose all the tests should pass, right?
> > > =20
> >=20
> > How are you running the tests? This is described in the docs. Search for
> > 'tests'.
> >=20
> > https://docs.u-boot.org/en/latest/develop/tests_sandbox.html#running-sa=
ndbox-tests-directly
>=20
> As discussed in the email thread running test directly does not work and
> segfault for the bootflow command.
> We have to run it under the test.py command to makes it work.
>=20
> The log I sent was for the following command:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
>=20
> The two errors on bootflow on master are:
> Test: bootflow_cmd_menu: bootflow.c
> test/boot/bootflow.c:673, bootflow_cmd_menu(): 0 =3D=3D run_command("boot=
flow menu", 0): Expected 0x0 (0), got 0x1 (1)
>=20
> test/boot/bootflow.c:718, bootflow_scan_menu(): console:=20
> Expected 'Selected: Armbian',
>      got '<no-more-output>'
>=20
> Tom do you face the same errors? If that's the case we should fix these.

No, I can do:
$ git clean -dfx
$ ./test/py/test.py --bd sandbox --build -k test_ut
And the result is:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 872 passed, 1 skipped, 608 de=
selected, 13398 warnings in 55.73s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

And this is on top of tree master right now.

--=20
Tom

--EKLHVpO/lVi4bKQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPePUAAKCRAr4qD1Cr/k
CufoAQCgEdhbX72OsMJsJaT5cTqFbWfNGzzj5xvvZaHewP7mPgD+IM+pzon2vT/6
l75kKs8He94wJk88sDn15OiPu4HRkwE=
=B/x2
-----END PGP SIGNATURE-----

--EKLHVpO/lVi4bKQk--
