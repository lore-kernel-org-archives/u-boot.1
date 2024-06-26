Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE4BC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 14:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F3586EB5;
	Wed, 26 Jun 2024 16:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lCJGJZ3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC2EA88149; Wed, 26 Jun 2024 16:29:49 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468B683989
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 16:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5c1adbcaad3so298938eaf.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719412186; x=1720016986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WtgyJsH/YAkF8kXvp/zdm7fekfmbDcY2tRh1XbdcV2E=;
 b=lCJGJZ3Xc4REvvsSmHw+zuOrNWApBWemxL73mNbmlWEPKTgSWlMiOwF84Cl+PkdFnB
 zfA8mFHe+ku88MZv3vmJsY6/B8ZbzdgrHu1nuv8dLsiObYeOixlsdZffOgSk64Mdt0ow
 oUVXmdjbOAWnsegEVNUogu8ZfB6GA57Cfei00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719412186; x=1720016986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtgyJsH/YAkF8kXvp/zdm7fekfmbDcY2tRh1XbdcV2E=;
 b=hWnHqVahqifgnxmIxdjwoJWghmQmObAxDUugB8996Fn7ZpkTNIAVjnGyqsXT5jnB2V
 4Fm1aFepaKQjQVD/79lT4GKo52cJK/ITFahv7hZXvEOI5wkRlL2LineqRqWFPWmQMj2M
 IzsSyEA1NCkP5Nbqz9jzcsTj4Eki8icCTFbX64DGLNTpyD7X2LcUo3g2v8jQU5c2aawS
 OCWWwTsA4uNJldXWuNXGu50xt6bJ5d8FCp8RU4Yn1WpnwXqp3Nux++NzTF0h6Xac8iDX
 QjIFJGhm9pYw0b6Vuz++CUpd1ADwc0ocqeDp2IXDfNW02dI3JOvn9TFdbHaNYjnnffd9
 oAiA==
X-Gm-Message-State: AOJu0YwNE9Ij+u4hzTzMrwB42bgnjSAjLUOj7K5WnB0qadm+mzd95Jjr
 0PqpatJZ168prIT7QW2p/yp4e/o1aqYi+T8L3TuYfLeAg4pxmYwgbatTbf4bBaqWe5dieZn9X8c
 +DVt27Q==
X-Google-Smtp-Source: AGHT+IFW8utoU8+LR4IoxbciNaSegf4o3pK0B87Moel8e4NQLd7ESZbh1delbpxpLLG4TVQx2ffGKA==
X-Received: by 2002:a4a:6709:0:b0:5c2:246e:bfa7 with SMTP id
 006d021491bc7-5c2246ec022mr533050eaf.9.1719412185785; 
 Wed, 26 Jun 2024 07:29:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d55cd06asm2112753eaf.11.2024.06.26.07.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 07:29:45 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:29:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240626142943.GW38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZFZy1vK1kxQm0uxX"
Content-Disposition: inline
In-Reply-To: <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
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


--ZFZy1vK1kxQm0uxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> > > >
> > > > > In Labgrid there is the concept of a 'role', which is similar to =
the
> > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > >
> > > > > The role indicates both the target and information about the U-Bo=
ot
> > > > > build to use. It can also provide any amount of other configurati=
on.
> > > > > The information is obtained using the 'labgrid-client query' oper=
ation.
> > > > >
> > > > > Make use of this in tests, so that only the role is required in g=
itlab
> > > > > and other situations. The board type and other things can be quer=
ied
> > > > > as needed.
> > > > >
> > > > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > > > information.
> > > > >
> > > > > With this it is possible to run lab tests in gitlab with just a s=
ingle
> > > > > 'ROLE' variable for each board.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > --- a/test/py/conftest.py
> > > > > +++ b/test/py/conftest.py
> > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > >  import pytest
> > > > >  import re
> > > > >  from _pytest.runner import runtestprotocol
> > > > > +import subprocess
> > > > >  import sys
> > > > >
> > > > >  # Globals: The HTML log file, and the connection to the U-Boot c=
onsole.
> > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > >      parser.addoption('--gdbserver', default=3DNone,
> > > > >          help=3D'Run sandbox under gdbserver. The argument is the=
 channel '+
> > > > >          'over which gdbserver should communicate, e.g. localhost=
:1234')
> > > > > +    parser.addoption('--role', help=3D'U-Boot board role (for La=
bgrid)')
> > > > >      parser.addoption('--no-prompt-wait', default=3DFalse, action=
=3D'store_true',
> > > > >          help=3D"Assume that U-Boot is ready and don't wait for a=
 prompt")
> > > > >
> > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > >              str: Build directory
> > > > >              str: Source directory
> > > > >      """
> > > > > -    board_type =3D config.getoption('board_type')
> > > > > -    board_identity =3D config.getoption('board_identity')
> > > > > +    role =3D config.getoption('role')
> > > > >      build_dir =3D config.getoption('build_dir')
> > > > > +    if role:
> > > > > +        board_identity =3D role
> > > > > +        cmd =3D ['u-boot-test-getrole', role, '--configure']
> > > > > +        env =3D os.environ.copy()
> > > > > +        if build_dir:
> > > > > +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> > > > > +        proc =3D subprocess.run(cmd, capture_output=3DTrue, enco=
ding=3D'utf-8',
> > > > > +                              env=3Denv)
> > > > > +        if proc.returncode:
> > > > > +            raise ValueError(proc.stderr)
> > > > > +        print('conftest: lab:', proc.stdout)
> > > > > +        vals =3D {}
> > > > > +        for line in proc.stdout.splitlines():
> > > > > +            item, value =3D line.split(' ', maxsplit=3D1)
> > > > > +            k =3D item.split(':')[-1]
> > > > > +            vals[k] =3D value
> > > > > +        print('conftest: lab info:', vals)
> > > > > +        board_type, default_build_dir, source_dir =3D (vals['boa=
rd'],
> > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > +    else:
> > > > > +        board_type =3D config.getoption('board_type')
> > > > > +        board_identity =3D config.getoption('board_identity')
> > > > >
> > > > > -    source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > > > -    default_build_dir =3D source_dir + '/build-' + board_type
> > > > > +        source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_D=
IR))
> > > > > +        default_build_dir =3D source_dir + '/build-' + board_type
> > > > >      if not build_dir:
> > > > >          build_dir =3D default_build_dir
> > > >
> > > > I'm a little confused here. Why can't we construct "role" from
> > > > board_type+board_identity and then we have the board
> > > > conf.${board_type}_${board_identity} file set whatever needs settin=
g to
> > > > be "labgrid" ?
> > >
> > > The role is equivalent to the board identity, not the combination of
> > > the U-Boot board type and the board identity. I went this way to avoid
> > > having to type long and complicated roles when connecting to boards.
> > > It is similar to how things work today, except that the board type is
> > > implied by the 'role'.
> > >
> > > For boards which have multiple identities (e.g. can support two
> > > different board types), Labgrid handles acquiring and releasing the
> > > shares resources, to avoid any problems.
> >
> > I guess I have two sets of questions. First, if it's basically the
> > board identity why can't we just use that as the role name, in your
> > setup?
>=20
> Yes, that's what I am doing. If you look in console.labgrid you can
> see that it is passing U_BOOT_BOARD_IDENTITY as the -r argument.

Then why do we need this?

> > But second, I'm not sure why we need this. The labgrid support we worked
> > up here (but, sigh, it's not really clean enough to post) has:
> > $ cat bin/lootbox/conf.rpi_4_na
> > console_impl=3Dlabgrid
> > reset_impl=3Dlabgrid
> > flash_impl=3Dlabgrid.rpi_4
> > flash_writer=3Dlabgrid.rpi_4
> >
> > For example and:
> > $ cat bin/writer.labgrid.rpi_4
> > set -e
> >
> > build=3D${U_BOOT_BUILD_DIR}
> >
> > $LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img
> >
> > So I don't know what the "role" part you have is for. And yes, there end
> > up being multiple writer.labgrid.FOO scripts because for TI K3 platforms
> > (such as beagleplay) we have:
> > $ cat bin/writer.labgrid.ti-k3
> > set -e
> > build=3D${U_BOOT_BUILD_DIR}
> >
> > if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
> >     echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
> >     echo "per the board documentation."
> >     exit 1
> > fi
> > echo "Writing build at ${build}"
> > $LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
> > $LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
> > $LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
> > echo "Done writing build"
> >
> > In all cases we first build U-Boot and then pass the build directory to
> > test.py, in something like:
> > export LG_PLACE=3Drpi4
> > ./test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
> >   --results-dir .../results-rpi4 --persistent-data-dir .../pd-rpi4 \
> >   --exitfirst
> >
> > The only U-Boot side changes I needed to make were for counting the SPL
> > banner instances, and that was regardless of framework (a particularly
> > fun platform will show it 3 times).
>=20
> Yes it is possible to build U-Boot separately. Of course that involved
> various blobs and so on, so every board is different. The approach I
> have taken here is to have Labgrid call buildman to build what is
> needed, with the blobs defined in the environment.
>=20
> You can use the -B flag to use a pre-built U-Boot, with the scripts
> I've included.

OK. I personally think pre-built (or outside of buildman built) U-Boot
will be an important case, since everything needs more options enabled
to test more features, but on real hardware. For example,
CONFIG_UNIT_TEST should be on for everyone, in testing, once the build
issues are resolved. And I need to add CONFIG_FIT to some platforms so
that I can then use the kernel test. And some platforms I end up
enabling CONFIG_CMD_BOOTEFI_HELLO on (but others disabling
CONFIG_CMD_BOOTEFI_SELFTEST as that fails and that's just A Thing).

--=20
Tom

--ZFZy1vK1kxQm0uxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8JdMACgkQFHw5/5Y0
tyx6WQwAkyKLKC8x4gbvbQ/izuhoXKFC7MI7pfP30zrDGCogARFg42wbtwl2je6z
nZHBdU6ppYOkn+fRFlVP9KdJLADbKrsMsW5HRKEXepc5kb9y3noheztWfVSEmais
BhNH9LaIbpbsf6WVpUJsykiGJaPB33o8f2PR0vY9ol+NT36AJrcHkaF3/F9xjb7M
Lsd6tYh7v4TiIHJoU0AnNnvydHKuJ/fypFasj9dh4NAL1F9rTH2r98ZykJy5WuEf
yw1c4TCYZOAywaocuBmxvsOj121wxZJf5H3Lrpx/JnDB6I/XaK6UvJuQiYt8r0xE
lh7eOa8ToiOADj0AIoNe+HosCk4zhcdevufyrDJLcZUk0ofWdqtkPArQZOKUVytV
8NcgKZqLdg86uOPG8AV1XBzbLXlOi+2OActWbUqzlf52VpFT5gmB0HQBzNvJh0Ya
ppt9WyeFdVJ2hLYlUfCoyE92t+Np2s+ReXvCaCeK2YKUk7k4cdkfTaKr3Sgakfhm
xpEid65b
=Df6g
-----END PGP SIGNATURE-----

--ZFZy1vK1kxQm0uxX--
