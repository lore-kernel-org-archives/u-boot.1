Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55E1C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 23:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A35A88712;
	Wed,  3 Jul 2024 01:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hU4nytTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C056388754; Wed,  3 Jul 2024 01:12:48 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477638874D
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 01:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7021f23d699so1019300a34.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719961965; x=1720566765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8PI/C7zCnlkdETVZYWIt/yF5vwijBnGuAw39lZaSXM4=;
 b=hU4nytTT933GyQltl5ySHBkd/9GvXOdPJhU4ldTvlrhHDI1+HTNvoHXUzUENpn0PhP
 3UCXMSZzU+DOJ4Gg6HcZVF1JMC3utpgVztI9rZ9qZJa39Xp/Qx2w/UDrz50j2Fpsxv5O
 Lfz2kkcXznZMJ/sHKIrtM8aA7K07TLi/bd8Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719961965; x=1720566765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PI/C7zCnlkdETVZYWIt/yF5vwijBnGuAw39lZaSXM4=;
 b=AI7pY2s5DrB4Gwes4inH5SOMfGcs7PFGQ7OU1T+N51WWLQ/Lh69QIRwygbvZwwwgJl
 GtDKll7oOIFTAAeTwL43TYpOdzdZfV3gyvCbnY5PhSaSICP/v1OcmQF/7s3gCFrXpih0
 k/SxuaK2gaJfV1+U4bZfji/Rt+QQ2Ui2Ssf8Zc0n1j4HLwm14mOJXqm9YIxILjd4guN5
 kCTIAVqLUFZ7DXbLj2ccuSBx/AbthO+z5QDfVFTEoM11++jhjTXp6+28Kso9Iexo9syt
 SoDa2O6t/ySAx9XmWTyK/8JNJt5AGaVS5PAsqnBQ/KwWyfYDb6ATirNkVWZB9aHxF0fy
 ygmw==
X-Gm-Message-State: AOJu0Yx9YvaSED5dHPwUAPa5cPqWbuqDa/iDMQ+rQdzl+UivQJMyIzSn
 ooito2OGGX90OQST5HLlhkXS4o1mfHPjCIaAam60sAyqxbKR/mrEOCPrgQcKlUvjvEHCkAXElv4
 LNBo=
X-Google-Smtp-Source: AGHT+IGkotwaPy3ILFtSjcUHXd9lNJfoIHO4wxNAewe7yIGeIASbl/MnacrXFq8FNHXw1c0L40oI5A==
X-Received: by 2002:a05:6830:1bfb:b0:701:ffc8:c1ac with SMTP id
 46e09a7af769-702076d0713mr13442557a34.30.1719961964686; 
 Tue, 02 Jul 2024 16:12:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab1abcsm1827728a34.26.2024.07.02.16.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:12:44 -0700 (PDT)
Date: Tue, 2 Jul 2024 17:12:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240702231241.GV38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
 <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YKR67V6LtvUyH69t"
Content-Disposition: inline
In-Reply-To: <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
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


--YKR67V6LtvUyH69t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:37:18AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > In Labgrid there is the concept of a 'role', which is similar=
 to the
> > > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > > >
> > > > > > > The role indicates both the target and information about the =
U-Boot
> > > > > > > build to use. It can also provide any amount of other configu=
ration.
> > > > > > > The information is obtained using the 'labgrid-client query' =
operation.
> > > > > > >
> > > > > > > Make use of this in tests, so that only the role is required =
in gitlab
> > > > > > > and other situations. The board type and other things can be =
queried
> > > > > > > as needed.
> > > > > > >
> > > > > > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > > > > > information.
> > > > > > >
> > > > > > > With this it is possible to run lab tests in gitlab with just=
 a single
> > > > > > > 'ROLE' variable for each board.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > > --- a/test/py/conftest.py
> > > > > > > +++ b/test/py/conftest.py
> > > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > > >  import pytest
> > > > > > >  import re
> > > > > > >  from _pytest.runner import runtestprotocol
> > > > > > > +import subprocess
> > > > > > >  import sys
> > > > > > >
> > > > > > >  # Globals: The HTML log file, and the connection to the U-Bo=
ot console.
> > > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > > >      parser.addoption('--gdbserver', default=3DNone,
> > > > > > >          help=3D'Run sandbox under gdbserver. The argument is=
 the channel '+
> > > > > > >          'over which gdbserver should communicate, e.g. local=
host:1234')
> > > > > > > +    parser.addoption('--role', help=3D'U-Boot board role (fo=
r Labgrid)')
> > > > > > >      parser.addoption('--no-prompt-wait', default=3DFalse, ac=
tion=3D'store_true',
> > > > > > >          help=3D"Assume that U-Boot is ready and don't wait f=
or a prompt")
> > > > > > >
> > > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > > >              str: Build directory
> > > > > > >              str: Source directory
> > > > > > >      """
> > > > > > > -    board_type =3D config.getoption('board_type')
> > > > > > > -    board_identity =3D config.getoption('board_identity')
> > > > > > > +    role =3D config.getoption('role')
> > > > > > >      build_dir =3D config.getoption('build_dir')
> > > > > > > +    if role:
> > > > > > > +        board_identity =3D role
> > > > > > > +        cmd =3D ['u-boot-test-getrole', role, '--configure']
> > > > > > > +        env =3D os.environ.copy()
> > > > > > > +        if build_dir:
> > > > > > > +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> > > > > > > +        proc =3D subprocess.run(cmd, capture_output=3DTrue, =
encoding=3D'utf-8',
> > > > > > > +                              env=3Denv)
> > > > > > > +        if proc.returncode:
> > > > > > > +            raise ValueError(proc.stderr)
> > > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > > +        vals =3D {}
> > > > > > > +        for line in proc.stdout.splitlines():
> > > > > > > +            item, value =3D line.split(' ', maxsplit=3D1)
> > > > > > > +            k =3D item.split(':')[-1]
> > > > > > > +            vals[k] =3D value
> > > > > > > +        print('conftest: lab info:', vals)
> > > > > > > +        board_type, default_build_dir, source_dir =3D (vals[=
'board'],
> > > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > > +    else:
> > > > > > > +        board_type =3D config.getoption('board_type')
> > > > > > > +        board_identity =3D config.getoption('board_identity')
> > > > > > >
> > > > > > > -    source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_D=
IR))
> > > > > > > -    default_build_dir =3D source_dir + '/build-' + board_type
> > > > > > > +        source_dir =3D os.path.dirname(os.path.dirname(TEST_=
PY_DIR))
> > > > > > > +        default_build_dir =3D source_dir + '/build-' + board=
_type
> > > > > > >      if not build_dir:
> > > > > > >          build_dir =3D default_build_dir
> > > > > >
> > > > > > I'm a little confused here. Why can't we construct "role" from
> > > > > > board_type+board_identity and then we have the board
> > > > > > conf.${board_type}_${board_identity} file set whatever needs se=
tting to
> > > > > > be "labgrid" ?
> > > > >
> > > > > The role is equivalent to the board identity, not the combination=
 of
> > > > > the U-Boot board type and the board identity. I went this way to =
avoid
> > > > > having to type long and complicated roles when connecting to boar=
ds.
> > > > > It is similar to how things work today, except that the board typ=
e is
> > > > > implied by the 'role'.
> > > > >
> > > > > For boards which have multiple identities (e.g. can support two
> > > > > different board types), Labgrid handles acquiring and releasing t=
he
> > > > > shares resources, to avoid any problems.
> > > >
> > > > I guess I have two sets of questions. First, if it's basically the
> > > > board identity why can't we just use that as the role name, in your
> > > > setup?
> > >
> > > Yes, that's what I am doing. If you look in console.labgrid you can
> > > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.
> >
> > Then why do we need this?
>=20
> We need to pass a role to Labgrid, since it determines the board
> identity to use. It also (indirectly) determines the U-Boot build to
> use, since each board identity / role is a particular board with a
> particular build.

Oh, I get where you're coming from now at least. But this still sounds
like a detail to put in to the conf.${board}_${board_type} file and not
a thing to set here?

> For example:
> role / identify =3D samus   - uses 'samus' board with build chromebook_sa=
mus
> role / identify =3D samus_tpl   - uses 'samus' board with build
> chromebook_samus_tpl

Yes, or using one physical Pi 4 to test rpi_4_defconfig and
rpi_arm64_defconfig (and if labgrid supported a way to remove files from
the FAT partition, rpi_4_32b_defconfig).

> Basically, as I understand it, the 'role' is the thing we want.
>=20
> Labgrid environment:
>=20
>   samus:
>     resources:
>       RemotePlace:
>         name: samus
> ...
>       UBootProviderDriver:
>         board: chromebook_samus
>         binman_indir: /vid/software/devel/samus/bin
>=20
>   samus_tpl:
>     resources:
>       RemotePlace:
>         name: samus
>       UBootProviderDriver:
>         board: chromebook_samus_tpl
>         binman_indir: /vid/software/devel/samus/bin

I guess the problem here is that from my point of view, this can live in
the u-boot-test-hooks/bin/<host>/conf.<machine> file since we're never
going to worry about building U-Boot (even if blobs aren't a problem, we
want to enable more features to test more things on HW) but from your
point of view, buildman must provide test.py with the correct build so
we need to know things prior.

> > > > But second, I'm not sure why we need this. The labgrid support we w=
orked
> > > > up here (but, sigh, it's not really clean enough to post) has:
> > > > $ cat bin/lootbox/conf.rpi_4_na
> > > > console_impl=3Dlabgrid
> > > > reset_impl=3Dlabgrid
> > > > flash_impl=3Dlabgrid.rpi_4
> > > > flash_writer=3Dlabgrid.rpi_4
> > > >
> > > > For example and:
> > > > $ cat bin/writer.labgrid.rpi_4
> > > > set -e
> > > >
> > > > build=3D${U_BOOT_BUILD_DIR}
> > > >
> > > > $LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img
> > > >
> > > > So I don't know what the "role" part you have is for. And yes, ther=
e end
> > > > up being multiple writer.labgrid.FOO scripts because for TI K3 plat=
forms
> > > > (such as beagleplay) we have:
> > > > $ cat bin/writer.labgrid.ti-k3
> > > > set -e
> > > > build=3D${U_BOOT_BUILD_DIR}
> > > >
> > > > if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
> > > >     echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
> > > >     echo "per the board documentation."
> > > >     exit 1
> > > > fi
> > > > echo "Writing build at ${build}"
> > > > $LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
> > > > $LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
> > > > $LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
> > > > echo "Done writing build"
> > > >
> > > > In all cases we first build U-Boot and then pass the build director=
y to
> > > > test.py, in something like:
> > > > export LG_PLACE=3Drpi4
> > > > ./test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
> > > >   --results-dir .../results-rpi4 --persistent-data-dir .../pd-rpi4 \
> > > >   --exitfirst
> > > >
> > > > The only U-Boot side changes I needed to make were for counting the=
 SPL
> > > > banner instances, and that was regardless of framework (a particula=
rly
> > > > fun platform will show it 3 times).
> > >
> > > Yes it is possible to build U-Boot separately. Of course that involved
> > > various blobs and so on, so every board is different. The approach I
> > > have taken here is to have Labgrid call buildman to build what is
> > > needed, with the blobs defined in the environment.
> > >
> > > You can use the -B flag to use a pre-built U-Boot, with the scripts
> > > I've included.
> >
> > OK. I personally think pre-built (or outside of buildman built) U-Boot
> > will be an important case, since everything needs more options enabled
> > to test more features, but on real hardware. For example,
> > CONFIG_UNIT_TEST should be on for everyone, in testing, once the build
> > issues are resolved. And I need to add CONFIG_FIT to some platforms so
> > that I can then use the kernel test. And some platforms I end up
> > enabling CONFIG_CMD_BOOTEFI_HELLO on (but others disabling
> > CONFIG_CMD_BOOTEFI_SELFTEST as that fails and that's just A Thing).
>=20
> Yes that all sounds good. I have figured out how to add QEMU into this
> Labgrid integration, but I cannot Debian to boot all the way to a
> prompt with -nographic unless I pass something special on the Linux
> commandline. So for now I parked that.

Putting QEMU in to labgrid too could be interesting, yes. But I lost how
it's related? To be clear, today we can test boot a Linux kernel on
hardware. Somewhere on my TODO list is cycling over what kernel images
to grab and shove in to the docker container so that our existing QEMU
tests can do that too, for some platforms at least.

--=20
Tom

--YKR67V6LtvUyH69t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEiWYACgkQFHw5/5Y0
tyzUZAv9GnQpAW7mQ/RmPPCcEqA94/0sktKfNQt3fHk6Kqn3Stf0BD+zYyULkM1l
IdUC8QwhhP7yx3y5W+xFWR7Zm/5n4kXRcoJ3jnPdyQtENdKb8J3byzd9HpuG6Mg5
tVCLHseSlOQopuYq8ShutVOahqzhsBQ5MHyiYXrHi2AQneiML9IWEVxMqXTqVYs/
1gktvKTfE5IUZoq5+RQOvACqCnXNIuEU9KE+j0p0h5+swctbxrVtcmgV19JxmwwE
2paqWTzGHw6LFROE4rAloEJF6uQlRFP7v5CufNiWxSZWf1cKtlh5xAusdarq64zj
5UN2gqOcTemk1mF7eX+KieYT3IGvalrlXm6twjr6jnQijdEVxVkFKOLOyWMCvmEe
5FG6ag8hSdh6b0OGPLVHCi8xNBptl0EPBg61FXvSSbZiSF3YhZU2vRJZ5ogNPJWB
7g60NkIe/qn7sDOUwVR1OZXYCi53AqRDH8P38gB8lShLOjFlqYhQIQoRpq3Bc8QL
IJotqB4F
=r6Qq
-----END PGP SIGNATURE-----

--YKR67V6LtvUyH69t--
