Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92FC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 16:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119048853E;
	Sat, 13 Jul 2024 18:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSY0Uw9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93BF887B9; Sat, 13 Jul 2024 18:57:41 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3762987FC7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 18:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-703d5b29e06so1389904a34.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720889858; x=1721494658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LDVNk06QNfNNb1VO0Ewi4GOWmTGQUmSwMIvq08jebq0=;
 b=GSY0Uw9wjISvHKdYYIgiPtpy5Twhqq7qPulqDxUWr+LpR+h6DdbsPfu81NXaoqCtOI
 mEhIDfrvZSlYiHIZ6TAhau56lQYcIv3uLJWTh3W0lmfJXpKgXNtoYXVJNEwsV1hXaiB3
 o0kRkHh4xvOXK6UTpiT1q1i0m7SrmOxMSAoHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720889858; x=1721494658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDVNk06QNfNNb1VO0Ewi4GOWmTGQUmSwMIvq08jebq0=;
 b=QPAlZ6t/KCzIXH2Yh9t/dymMy7It/Ugj4ncnAigVIwF2/wROmScL+wMAt7crv0v0h/
 IoAQnCkodrbh/egsQqW7lsNaFcaT8CoIma7VWxWC/ouGXTA4RzYS2Xw5HNS6dqonZfUR
 VgmybKRsJ5ZfylYdmsFKW6ES5aGHD1thOrgJw32wl8fXy0Ij3U1aardDOAzpxwgxF/4y
 cAV5/jY+C/UOlVH0BZai4SLGcXxPTYimkyoejipY3F69B1rgNpIa+v3gsQTT/01q2Bvt
 mf1oyTXfVbPVbW+oIWWCUrxaS/eAHgx0PwCE03waXVRr79ukIUZHsjvcYj7IFPsWBt2Y
 GWkg==
X-Gm-Message-State: AOJu0Yzi1ksvpxC7ma8bpwYQXOyKiOVXRZ+cBL1MP7ej7rpcs24as9ZK
 TTsb0xhdEqOXTmkSsrBr6ZeUDmnd83O648PYzh7w67qcEgrZRb2wqdzvytGtl0KkG6Mqe0bwuEZ
 +
X-Google-Smtp-Source: AGHT+IGgqJFMQUubC2zmiClQSsDQD6nmV0rrpGIowXfTxyaTWyGevDe+w40j2bItfQnN1S52IaV72g==
X-Received: by 2002:a9d:7995:0:b0:703:63d3:9eef with SMTP id
 46e09a7af769-70375a333e0mr15859638a34.25.1720889857793; 
 Sat, 13 Jul 2024 09:57:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c96964sm332268a34.44.2024.07.13.09.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 09:57:37 -0700 (PDT)
Date: Sat, 13 Jul 2024 10:57:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240713165735.GD38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
 <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
 <20240702231241.GV38804@bill-the-cat>
 <CAFLszTgJpVjeG2-C60tLy3FPabh9awP8vKnYJZZZ-fW_LBFR4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TUfk9rXQjBedOGBe"
Content-Disposition: inline
In-Reply-To: <CAFLszTgJpVjeG2-C60tLy3FPabh9awP8vKnYJZZZ-fW_LBFR4A@mail.gmail.com>
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


--TUfk9rXQjBedOGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 04:13:55PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 3 Jul 2024 at 00:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 27, 2024 at 09:37:18AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > In Labgrid there is the concept of a 'role', which is sim=
ilar to the
> > > > > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > > > > >
> > > > > > > > > The role indicates both the target and information about =
the U-Boot
> > > > > > > > > build to use. It can also provide any amount of other con=
figuration.
> > > > > > > > > The information is obtained using the 'labgrid-client que=
ry' operation.
> > > > > > > > >
> > > > > > > > > Make use of this in tests, so that only the role is requi=
red in gitlab
> > > > > > > > > and other situations. The board type and other things can=
 be queried
> > > > > > > > > as needed.
> > > > > > > > >
> > > > > > > > > Use a new 'u-boot-test-getrole' script to obtain the requ=
ested
> > > > > > > > > information.
> > > > > > > > >
> > > > > > > > > With this it is possible to run lab tests in gitlab with =
just a single
> > > > > > > > > 'ROLE' variable for each board.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > (no changes since v1)
> > > > > > > > >
> > > > > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > > > > --- a/test/py/conftest.py
> > > > > > > > > +++ b/test/py/conftest.py
> > > > > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > > > > >  import pytest
> > > > > > > > >  import re
> > > > > > > > >  from _pytest.runner import runtestprotocol
> > > > > > > > > +import subprocess
> > > > > > > > >  import sys
> > > > > > > > >
> > > > > > > > >  # Globals: The HTML log file, and the connection to the =
U-Boot console.
> > > > > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > > > > >      parser.addoption('--gdbserver', default=3DNone,
> > > > > > > > >          help=3D'Run sandbox under gdbserver. The argumen=
t is the channel '+
> > > > > > > > >          'over which gdbserver should communicate, e.g. l=
ocalhost:1234')
> > > > > > > > > +    parser.addoption('--role', help=3D'U-Boot board role=
 (for Labgrid)')
> > > > > > > > >      parser.addoption('--no-prompt-wait', default=3DFalse=
, action=3D'store_true',
> > > > > > > > >          help=3D"Assume that U-Boot is ready and don't wa=
it for a prompt")
> > > > > > > > >
> > > > > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > > > > >              str: Build directory
> > > > > > > > >              str: Source directory
> > > > > > > > >      """
> > > > > > > > > -    board_type =3D config.getoption('board_type')
> > > > > > > > > -    board_identity =3D config.getoption('board_identity')
> > > > > > > > > +    role =3D config.getoption('role')
> > > > > > > > >      build_dir =3D config.getoption('build_dir')
> > > > > > > > > +    if role:
> > > > > > > > > +        board_identity =3D role
> > > > > > > > > +        cmd =3D ['u-boot-test-getrole', role, '--configu=
re']
> > > > > > > > > +        env =3D os.environ.copy()
> > > > > > > > > +        if build_dir:
> > > > > > > > > +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> > > > > > > > > +        proc =3D subprocess.run(cmd, capture_output=3DTr=
ue, encoding=3D'utf-8',
> > > > > > > > > +                              env=3Denv)
> > > > > > > > > +        if proc.returncode:
> > > > > > > > > +            raise ValueError(proc.stderr)
> > > > > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > > > > +        vals =3D {}
> > > > > > > > > +        for line in proc.stdout.splitlines():
> > > > > > > > > +            item, value =3D line.split(' ', maxsplit=3D1)
> > > > > > > > > +            k =3D item.split(':')[-1]
> > > > > > > > > +            vals[k] =3D value
> > > > > > > > > +        print('conftest: lab info:', vals)
> > > > > > > > > +        board_type, default_build_dir, source_dir =3D (v=
als['board'],
> > > > > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > > > > +    else:
> > > > > > > > > +        board_type =3D config.getoption('board_type')
> > > > > > > > > +        board_identity =3D config.getoption('board_ident=
ity')
> > > > > > > > >
> > > > > > > > > -    source_dir =3D os.path.dirname(os.path.dirname(TEST_=
PY_DIR))
> > > > > > > > > -    default_build_dir =3D source_dir + '/build-' + board=
_type
> > > > > > > > > +        source_dir =3D os.path.dirname(os.path.dirname(T=
EST_PY_DIR))
> > > > > > > > > +        default_build_dir =3D source_dir + '/build-' + b=
oard_type
> > > > > > > > >      if not build_dir:
> > > > > > > > >          build_dir =3D default_build_dir
> > > > > > > >
> > > > > > > > I'm a little confused here. Why can't we construct "role" f=
rom
> > > > > > > > board_type+board_identity and then we have the board
> > > > > > > > conf.${board_type}_${board_identity} file set whatever need=
s setting to
> > > > > > > > be "labgrid" ?
> > > > > > >
> > > > > > > The role is equivalent to the board identity, not the combina=
tion of
> > > > > > > the U-Boot board type and the board identity. I went this way=
 to avoid
> > > > > > > having to type long and complicated roles when connecting to =
boards.
> > > > > > > It is similar to how things work today, except that the board=
 type is
> > > > > > > implied by the 'role'.
> > > > > > >
> > > > > > > For boards which have multiple identities (e.g. can support t=
wo
> > > > > > > different board types), Labgrid handles acquiring and releasi=
ng the
> > > > > > > shares resources, to avoid any problems.
> > > > > >
> > > > > > I guess I have two sets of questions. First, if it's basically =
the
> > > > > > board identity why can't we just use that as the role name, in =
your
> > > > > > setup?
> > > > >
> > > > > Yes, that's what I am doing. If you look in console.labgrid you c=
an
> > > > > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.
> > > >
> > > > Then why do we need this?
> > >
> > > We need to pass a role to Labgrid, since it determines the board
> > > identity to use. It also (indirectly) determines the U-Boot build to
> > > use, since each board identity / role is a particular board with a
> > > particular build.
> >
> > Oh, I get where you're coming from now at least. But this still sounds
> > like a detail to put in to the conf.${board}_${board_type} file and not
> > a thing to set here?
>=20
> There are no such files with the Labgrid integration so far. They are
> not needed.

They're needed in my case since I do not (cannot) use buildman to then
kick off the tests.

[snip]
> > > Basically, as I understand it, the 'role' is the thing we want.
> > >
> > > Labgrid environment:
> > >
> > >   samus:
> > >     resources:
> > >       RemotePlace:
> > >         name: samus
> > > ...
> > >       UBootProviderDriver:
> > >         board: chromebook_samus
> > >         binman_indir: /vid/software/devel/samus/bin
> > >
> > >   samus_tpl:
> > >     resources:
> > >       RemotePlace:
> > >         name: samus
> > >       UBootProviderDriver:
> > >         board: chromebook_samus_tpl
> > >         binman_indir: /vid/software/devel/samus/bin
> >
> > I guess the problem here is that from my point of view, this can live in
> > the u-boot-test-hooks/bin/<host>/conf.<machine> file since we're never
> > going to worry about building U-Boot (even if blobs aren't a problem, we
> > want to enable more features to test more things on HW) but from your
> > point of view, buildman must provide test.py with the correct build so
> > we need to know things prior.
>=20
> Well, either you already have a build to test, iwc it is fine, or if
> you don't you can pass --build to force a build, or rely on Labgrid to
> initiate the build.

No, neither buildman nor labgrid can initiate a functional build. Have
you integrated the beagleplay in to your lab? That I believe
demonstrates one of the problems (you need to build both
am62x_beagleplay_a53 and am62x_beagleplay_r5 and write files from both,
to test a given rev on the platform).

> But in your case, the build must be done before running test.py since
> it needs the .config file.

Yes, I build first and pass test.py the build directory.

> > > > > > But second, I'm not sure why we need this. The labgrid support =
we worked
> > > > > > up here (but, sigh, it's not really clean enough to post) has:
> > > > > > $ cat bin/lootbox/conf.rpi_4_na
> > > > > > console_impl=3Dlabgrid
> > > > > > reset_impl=3Dlabgrid
> > > > > > flash_impl=3Dlabgrid.rpi_4
> > > > > > flash_writer=3Dlabgrid.rpi_4
> > > > > >
> > > > > > For example and:
> > > > > > $ cat bin/writer.labgrid.rpi_4
> > > > > > set -e
> > > > > >
> > > > > > build=3D${U_BOOT_BUILD_DIR}
> > > > > >
> > > > > > $LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img
> > > > > >
> > > > > > So I don't know what the "role" part you have is for. And yes, =
there end
> > > > > > up being multiple writer.labgrid.FOO scripts because for TI K3 =
platforms
> > > > > > (such as beagleplay) we have:
> > > > > > $ cat bin/writer.labgrid.ti-k3
> > > > > > set -e
> > > > > > build=3D${U_BOOT_BUILD_DIR}
> > > > > >
> > > > > > if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
> > > > > >     echo "Must configure tispl, uboot, tiboot3 and optionally s=
ysfw"
> > > > > >     echo "per the board documentation."
> > > > > >     exit 1
> > > > > > fi
> > > > > > echo "Writing build at ${build}"
> > > > > > $LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
> > > > > > $LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
> > > > > > $LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.=
bin
> > > > > > echo "Done writing build"
> > > > > >
> > > > > > In all cases we first build U-Boot and then pass the build dire=
ctory to
> > > > > > test.py, in something like:
> > > > > > export LG_PLACE=3Drpi4
> > > > > > ./test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
> > > > > >   --results-dir .../results-rpi4 --persistent-data-dir .../pd-r=
pi4 \
> > > > > >   --exitfirst
> > > > > >
> > > > > > The only U-Boot side changes I needed to make were for counting=
 the SPL
> > > > > > banner instances, and that was regardless of framework (a parti=
cularly
> > > > > > fun platform will show it 3 times).
> > > > >
> > > > > Yes it is possible to build U-Boot separately. Of course that inv=
olved
> > > > > various blobs and so on, so every board is different. The approac=
h I
> > > > > have taken here is to have Labgrid call buildman to build what is
> > > > > needed, with the blobs defined in the environment.
> > > > >
> > > > > You can use the -B flag to use a pre-built U-Boot, with the scrip=
ts
> > > > > I've included.
> > > >
> > > > OK. I personally think pre-built (or outside of buildman built) U-B=
oot
> > > > will be an important case, since everything needs more options enab=
led
> > > > to test more features, but on real hardware. For example,
> > > > CONFIG_UNIT_TEST should be on for everyone, in testing, once the bu=
ild
> > > > issues are resolved. And I need to add CONFIG_FIT to some platforms=
 so
> > > > that I can then use the kernel test. And some platforms I end up
> > > > enabling CONFIG_CMD_BOOTEFI_HELLO on (but others disabling
> > > > CONFIG_CMD_BOOTEFI_SELFTEST as that fails and that's just A Thing).
> > >
> > > Yes that all sounds good. I have figured out how to add QEMU into this
> > > Labgrid integration, but I cannot Debian to boot all the way to a
> > > prompt with -nographic unless I pass something special on the Linux
> > > commandline. So for now I parked that.
> >
> > Putting QEMU in to labgrid too could be interesting, yes. But I lost how
> > it's related? To be clear, today we can test boot a Linux kernel on
> > hardware. Somewhere on my TODO list is cycling over what kernel images
> > to grab and shove in to the docker container so that our existing QEMU
> > tests can do that too, for some platforms at least.
>=20
> It's just a nice way of allowing 'ub-int qemu-x86' and getting to a
> U-Boot prompt. Yes there are other ways to do it, and in fact it works
> today if you set up your conf files for the machine you are on.

Yes, I've locally included qemu hosts as needed. I guess this was just
as an aside? Because yes, it would be good to run the net_boot tests on
more platforms, automatically, including/especially QEMU.

--=20
Tom

--TUfk9rXQjBedOGBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaSsf8ACgkQFHw5/5Y0
tyxiRQv+PKq/XKE3wWYKRsO+hWjFjkCuzTw5SzcgarX8l+JrSWh64OwDGgtxi/jj
VO1hLRmcYYwQtJ+Sy5BM1pEDdJwcY44TKgy5Uyaf+kXqI+X9wqRHJXJgcQPpf3Je
kaLs3VcjOQKD2Bu7P2Q0jcyzTd3IXxYBPWaVouucCQ17N3bEjTeboZCyKu5gryEd
XjhHWU8y3e4d+WKlCcrcgbX35k/9CCSe31OOwMp8QGaKsw8XoJlAmESlhYFYJrZs
VdmlJAjZ52xYm8fe2r+fGcHOXfppgsBpTO0zqiD5Y6JDnwVl3JtjvuD0JmE6O5Kw
1haN7t/EMzpahkIPwSpXjzTBZdjWb9YT5qVKf7dIMcso8LUGRrIkXQswp+KVKCuh
nhKSfqu81/LWZrZn9wPhQGHEfvMdfL8zEWB4xS5UrcwNms/MXOOVQFRe4nLnUmZ4
Io+ywE2wG0khXJ3YcuPfzqvL7Eaw37T7xDa2B/idT7yt6IwjHuODfUz3PUS2hHJR
5pvvGmMC
=4Aqr
-----END PGP SIGNATURE-----

--TUfk9rXQjBedOGBe--
