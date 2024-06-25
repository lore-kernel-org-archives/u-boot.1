Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB0EC3064D
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 14:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9529088464;
	Tue, 25 Jun 2024 16:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S/uEgOuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC7788496; Tue, 25 Jun 2024 16:27:11 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679AF88452
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 16:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c1b734383cso2573564eaf.3
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719325628; x=1719930428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i7sB+drHvaQmj+pDzeW/gSauU5Qgxc9C/vUUA0aiGZY=;
 b=S/uEgOuqifIsmkqgnrhahvdlkVObQkNcmdcxNiKrcbFMw8KZMYCAiOuyxZDgGRsaEH
 fQ5am3r2WaVw7b3Toyok/Hlir9y/LoUViX5V/5q+9GLTGxTS3AodT9dZfRZiovBceOpo
 rTU0s/5PmTyehmhVb9yKIYY20hK5ZfbhdIAYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719325628; x=1719930428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7sB+drHvaQmj+pDzeW/gSauU5Qgxc9C/vUUA0aiGZY=;
 b=hgau117FSbilUsOaPqE3GRrTIYFALoW4CWLLJeBEfprL/pTl4TCscIP2GG085iWMX5
 YOguZErqvUYTd+bR9dHW7UdcrAKMx5z4OYVcMDdkvwWZFAY9eBm1QjX24nqzYoof65iz
 3irausEg71DMi+qVfI+uT/K/RKOUKvWHpv8fujqrDbEsvq9pBBsjLdnvgU1kSw5PERd8
 C/bhAF3qxOE4Y/kw6Hl1AyeVXvu785o4TsS7PRCbNEmoNTSNWrBImz4wZJGxBcbQGIPu
 MWhsHFM+g6Jt2mFa/Xlcm7UnpyEnp2CEOjIS9pwONh7ZOhfwNT060GhRn90cy+DHMqA+
 7kQA==
X-Gm-Message-State: AOJu0YxEspd64Vp4jcPI9u8p9lexYChizDFRZbJkTfGOxBiTpxCW9lis
 zj4jtEscH/N99xW7REjHutyZwBNBCyxsA5FryLHwbsaHHFZYs2ututItjNIDir8=
X-Google-Smtp-Source: AGHT+IFsDOb+oTS5OnBfAgGeB4FVMUGRguar/Avc6Qb40h8zo0yG+cx8FV/OUr7NNGslRriUBD0SFQ==
X-Received: by 2002:a4a:8706:0:b0:5bd:c0b4:cf67 with SMTP id
 006d021491bc7-5c1eebfe510mr7947516eaf.1.1719325627880; 
 Tue, 25 Jun 2024 07:27:07 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d58f236fsm1803713eaf.37.2024.06.25.07.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:27:07 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:27:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240625142705.GQ38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-9-sjg@chromium.org>
 <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="atpbtvVhW3aXycn5"
Content-Disposition: inline
In-Reply-To: <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
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


--atpbtvVhW3aXycn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass wrote:
> >
> > > In Labgrid there is the concept of a 'role', which is similar to the
> > > U-Boot board ID in U-Boot's pytest subsystem.
> > >
> > > The role indicates both the target and information about the U-Boot
> > > build to use. It can also provide any amount of other configuration.
> > > The information is obtained using the 'labgrid-client query' operatio=
n.
> > >
> > > Make use of this in tests, so that only the role is required in gitlab
> > > and other situations. The board type and other things can be queried
> > > as needed.
> > >
> > > Use a new 'u-boot-test-getrole' script to obtain the requested
> > > information.
> > >
> > > With this it is possible to run lab tests in gitlab with just a single
> > > 'ROLE' variable for each board.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++----
> > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > index 6547c6922c6..5de8d7b0e23 100644
> > > --- a/test/py/conftest.py
> > > +++ b/test/py/conftest.py
> > > @@ -23,6 +23,7 @@ from pathlib import Path
> > >  import pytest
> > >  import re
> > >  from _pytest.runner import runtestprotocol
> > > +import subprocess
> > >  import sys
> > >
> > >  # Globals: The HTML log file, and the connection to the U-Boot conso=
le.
> > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > >      parser.addoption('--gdbserver', default=3DNone,
> > >          help=3D'Run sandbox under gdbserver. The argument is the cha=
nnel '+
> > >          'over which gdbserver should communicate, e.g. localhost:123=
4')
> > > +    parser.addoption('--role', help=3D'U-Boot board role (for Labgri=
d)')
> > >      parser.addoption('--no-prompt-wait', default=3DFalse, action=3D'=
store_true',
> > >          help=3D"Assume that U-Boot is ready and don't wait for a pro=
mpt")
> > >
> > > @@ -130,12 +132,33 @@ def get_details(config):
> > >              str: Build directory
> > >              str: Source directory
> > >      """
> > > -    board_type =3D config.getoption('board_type')
> > > -    board_identity =3D config.getoption('board_identity')
> > > +    role =3D config.getoption('role')
> > >      build_dir =3D config.getoption('build_dir')
> > > +    if role:
> > > +        board_identity =3D role
> > > +        cmd =3D ['u-boot-test-getrole', role, '--configure']
> > > +        env =3D os.environ.copy()
> > > +        if build_dir:
> > > +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> > > +        proc =3D subprocess.run(cmd, capture_output=3DTrue, encoding=
=3D'utf-8',
> > > +                              env=3Denv)
> > > +        if proc.returncode:
> > > +            raise ValueError(proc.stderr)
> > > +        print('conftest: lab:', proc.stdout)
> > > +        vals =3D {}
> > > +        for line in proc.stdout.splitlines():
> > > +            item, value =3D line.split(' ', maxsplit=3D1)
> > > +            k =3D item.split(':')[-1]
> > > +            vals[k] =3D value
> > > +        print('conftest: lab info:', vals)
> > > +        board_type, default_build_dir, source_dir =3D (vals['board'],
> > > +            vals['build_dir'], vals['source_dir'])
> > > +    else:
> > > +        board_type =3D config.getoption('board_type')
> > > +        board_identity =3D config.getoption('board_identity')
> > >
> > > -    source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > -    default_build_dir =3D source_dir + '/build-' + board_type
> > > +        source_dir =3D os.path.dirname(os.path.dirname(TEST_PY_DIR))
> > > +        default_build_dir =3D source_dir + '/build-' + board_type
> > >      if not build_dir:
> > >          build_dir =3D default_build_dir
> >
> > I'm a little confused here. Why can't we construct "role" from
> > board_type+board_identity and then we have the board
> > conf.${board_type}_${board_identity} file set whatever needs setting to
> > be "labgrid" ?
>=20
> The role is equivalent to the board identity, not the combination of
> the U-Boot board type and the board identity. I went this way to avoid
> having to type long and complicated roles when connecting to boards.
> It is similar to how things work today, except that the board type is
> implied by the 'role'.
>=20
> For boards which have multiple identities (e.g. can support two
> different board types), Labgrid handles acquiring and releasing the
> shares resources, to avoid any problems.

I guess I have two sets of questions. First, if it's basically the
board identity why can't we just use that as the role name, in your
setup?

But second, I'm not sure why we need this. The labgrid support we worked
up here (but, sigh, it's not really clean enough to post) has:
$ cat bin/lootbox/conf.rpi_4_na
console_impl=3Dlabgrid
reset_impl=3Dlabgrid
flash_impl=3Dlabgrid.rpi_4
flash_writer=3Dlabgrid.rpi_4

For example and:
$ cat bin/writer.labgrid.rpi_4
set -e

build=3D${U_BOOT_BUILD_DIR}

$LG_CLIENT write-files -T ${build}/u-boot.bin kernel8.img

So I don't know what the "role" part you have is for. And yes, there end
up being multiple writer.labgrid.FOO scripts because for TI K3 platforms
(such as beagleplay) we have:
$ cat bin/writer.labgrid.ti-k3
set -e
build=3D${U_BOOT_BUILD_DIR}

if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
    echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
    echo "per the board documentation."
    exit 1
fi
echo "Writing build at ${build}"
$LG_CLIENT write-files -T ${build}/${tispl} tispl.bin
$LG_CLIENT write-files -T ${build}/${uboot} u-boot.img
$LG_CLIENT write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
echo "Done writing build"

In all cases we first build U-Boot and then pass the build directory to
test.py, in something like:
export LG_PLACE=3Drpi4
=2E/test/py/test.py -ra --bd rpi_4 --build-dir .../build-rpi4 \
  --results-dir .../results-rpi4 --persistent-data-dir .../pd-rpi4 \
  --exitfirst

The only U-Boot side changes I needed to make were for counting the SPL
banner instances, and that was regardless of framework (a particularly
fun platform will show it 3 times).

--=20
Tom

--atpbtvVhW3aXycn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ607IACgkQFHw5/5Y0
tyxLrQwAmeHLYrlQjATqGx6miQETVZI61oxx4IH4k5XO3IS0OM+zVhFVSG2PiVyM
BnrHGhNkV1v1G5VNPudPrRYaPmHEieboenPyMJn9NTaK7U17tf/TfnUX/KjLYTnO
KoxvYQ7J/Q3ziYr70aMsWuGVX0vhZhHXVneBZZfLEvDQTbmmHhIHOfA1XF7oVjrn
IlT1YlqStqcXIfESR6i3ElbCIPKfXTQ7AYqDpfyKJdqRZttrVNv1k6wlymXAmAxR
WonKmIrOVdtLJSVs/+4XJQ3+lh/SWGkVKXykkR+Vf8qB7JWrw2SHmUA3nMoeJJGx
86yKypZ0vmDYpUeyueVlolb+tnfbgYyOAdhxpXftVVrQ+Z4o2ETZuUiATSKEAl7/
dTys+1vgzZBBr0XjvmsTgEfU4wd2ddatY/b2y3LRY6KtSYHSFLnZGLH7mWIQQk35
Sb6CL+cj2SHVyYAkopVhRyPkxM0ciY158OoS3PIvFxQcd8culeRZcmKpG1OxL7Ag
yAWbHQui
=7MxS
-----END PGP SIGNATURE-----

--atpbtvVhW3aXycn5--
