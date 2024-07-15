Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065ACC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 21:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7453687FC8;
	Mon, 15 Jul 2024 23:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DoOnawPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C1E87FC8; Mon, 15 Jul 2024 23:03:20 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF10A88360
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-704466b19c4so2502374a34.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721077396; x=1721682196; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=byBmYJ+mAn7dZsJKEl4n65U2JlThLZNT+dU8ZU5ReAg=;
 b=DoOnawPWQo1epkiF0vkAw1ibRpiOBRnl8ty2Z6oF/UdhrNFztjD8uqwDRz5hA7iSff
 PUf7yZCdSpYz/DsnzP5oA2w47GtNR7FeDgkAcKBA3qWX5aSjRznCbhmymLlrUWn/Ylck
 CgnyuWv2Dj9z7ZB14rqb3ZvXqWaR7sXU0XK40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721077396; x=1721682196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byBmYJ+mAn7dZsJKEl4n65U2JlThLZNT+dU8ZU5ReAg=;
 b=aEYT0L6KS8uEME1TR/5B8gLWFb5X16dKn6yBxDU4Uurdy8Z6b/ebHnDZZClDKn3JXy
 AAjZIn0qZHMJwpReHse5C7dZ7H+P/H18Ibs4h2RnHQK2RZsl53dkTv8fBfZ7NfV2i88A
 erwFqkxVeZJdmUxU9hwzCJPxQFbxpKYuCeYYsH2BeoXfBQWFus+huaXxCVtuU0lFVqgN
 jWk6MBk7hfJtxnQVBBN4xS0TZZ80SVzqtX+iEs3QkWWlW3m/f9Dg07+jHWLy/H/oQ2Wy
 nhke5ixUP8vgtQIoyI/27Tr/MXdY1gNB8mS4F8Bdmtu8Cg48KQLRYnd1EA4sBNzHv/Z5
 z2Fw==
X-Gm-Message-State: AOJu0YwY/e7sA/Seh/9Mp9oIOMpipDOv9jKOHAdjF81YKdjZTcbrdyh7
 xjNzFYKEkjaX3HDodHijaFf/p5TUywEHdEp1hPgFtL58aCsaJFhsTvvi48F5oLQ=
X-Google-Smtp-Source: AGHT+IE4rGiKmXe0uWrsXs8rgsGFtapLFAM6hSkh52nK48UL4GsgVIo3+/yHblRkSf4AP0d3ZlQOYA==
X-Received: by 2002:a05:6830:490c:b0:704:b58d:377a with SMTP id
 46e09a7af769-708d9980be6mr285761a34.19.1721077396265; 
 Mon, 15 Jul 2024 14:03:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d0165bsm1076647a34.58.2024.07.15.14.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 14:03:15 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:03:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 08/19] test: Introduce the concept of a role
Message-ID: <20240715210313.GD561963@bill-the-cat>
References: <20240624181303.GH38804@bill-the-cat>
 <CAFLszThRfe9vkSdooS-tiX5ffSHxBKF359m9nov_MAJ7B4bmtQ@mail.gmail.com>
 <20240625142705.GQ38804@bill-the-cat>
 <CAFLszTip6hbX0yM6T7wAPOqLMavPLpTfemvjN9RPh9C4MmV8Uw@mail.gmail.com>
 <20240626142943.GW38804@bill-the-cat>
 <CAFLszTh5s9J18EpgL6Y7qWOH2o6jJzOv1j4C7yte7mPpUrZyBw@mail.gmail.com>
 <20240702231241.GV38804@bill-the-cat>
 <CAFLszTgJpVjeG2-C60tLy3FPabh9awP8vKnYJZZZ-fW_LBFR4A@mail.gmail.com>
 <20240713165735.GD38804@bill-the-cat>
 <CAFLszThRKB2bw7DOkN9XbrBTgbgwojNNYkuVK4vdOoS=7OOmnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UOvJan6W+ApfpQkS"
Content-Disposition: inline
In-Reply-To: <CAFLszThRKB2bw7DOkN9XbrBTgbgwojNNYkuVK4vdOoS=7OOmnQ@mail.gmail.com>
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


--UOvJan6W+ApfpQkS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 08:11:28AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 13 Jul 2024 at 17:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jul 13, 2024 at 04:13:55PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 3 Jul 2024 at 00:12, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jun 27, 2024 at 09:37:18AM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 26 Jun 2024 at 15:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 26, 2024 at 09:00:33AM +0100, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 25 Jun 2024 at 15:27, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Jun 25, 2024 at 01:38:08PM +0100, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 24 Jun 2024 at 19:13, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Jun 23, 2024 at 02:32:02PM -0600, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > In Labgrid there is the concept of a 'role', which is=
 similar to the
> > > > > > > > > > > U-Boot board ID in U-Boot's pytest subsystem.
> > > > > > > > > > >
> > > > > > > > > > > The role indicates both the target and information ab=
out the U-Boot
> > > > > > > > > > > build to use. It can also provide any amount of other=
 configuration.
> > > > > > > > > > > The information is obtained using the 'labgrid-client=
 query' operation.
> > > > > > > > > > >
> > > > > > > > > > > Make use of this in tests, so that only the role is r=
equired in gitlab
> > > > > > > > > > > and other situations. The board type and other things=
 can be queried
> > > > > > > > > > > as needed.
> > > > > > > > > > >
> > > > > > > > > > > Use a new 'u-boot-test-getrole' script to obtain the =
requested
> > > > > > > > > > > information.
> > > > > > > > > > >
> > > > > > > > > > > With this it is possible to run lab tests in gitlab w=
ith just a single
> > > > > > > > > > > 'ROLE' variable for each board.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > (no changes since v1)
> > > > > > > > > > >
> > > > > > > > > > >  test/py/conftest.py | 31 +++++++++++++++++++++++++++=
----
> > > > > > > > > > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > > > > > > > > index 6547c6922c6..5de8d7b0e23 100644
> > > > > > > > > > > --- a/test/py/conftest.py
> > > > > > > > > > > +++ b/test/py/conftest.py
> > > > > > > > > > > @@ -23,6 +23,7 @@ from pathlib import Path
> > > > > > > > > > >  import pytest
> > > > > > > > > > >  import re
> > > > > > > > > > >  from _pytest.runner import runtestprotocol
> > > > > > > > > > > +import subprocess
> > > > > > > > > > >  import sys
> > > > > > > > > > >
> > > > > > > > > > >  # Globals: The HTML log file, and the connection to =
the U-Boot console.
> > > > > > > > > > > @@ -79,6 +80,7 @@ def pytest_addoption(parser):
> > > > > > > > > > >      parser.addoption('--gdbserver', default=3DNone,
> > > > > > > > > > >          help=3D'Run sandbox under gdbserver. The arg=
ument is the channel '+
> > > > > > > > > > >          'over which gdbserver should communicate, e.=
g. localhost:1234')
> > > > > > > > > > > +    parser.addoption('--role', help=3D'U-Boot board =
role (for Labgrid)')
> > > > > > > > > > >      parser.addoption('--no-prompt-wait', default=3DF=
alse, action=3D'store_true',
> > > > > > > > > > >          help=3D"Assume that U-Boot is ready and don'=
t wait for a prompt")
> > > > > > > > > > >
> > > > > > > > > > > @@ -130,12 +132,33 @@ def get_details(config):
> > > > > > > > > > >              str: Build directory
> > > > > > > > > > >              str: Source directory
> > > > > > > > > > >      """
> > > > > > > > > > > -    board_type =3D config.getoption('board_type')
> > > > > > > > > > > -    board_identity =3D config.getoption('board_ident=
ity')
> > > > > > > > > > > +    role =3D config.getoption('role')
> > > > > > > > > > >      build_dir =3D config.getoption('build_dir')
> > > > > > > > > > > +    if role:
> > > > > > > > > > > +        board_identity =3D role
> > > > > > > > > > > +        cmd =3D ['u-boot-test-getrole', role, '--con=
figure']
> > > > > > > > > > > +        env =3D os.environ.copy()
> > > > > > > > > > > +        if build_dir:
> > > > > > > > > > > +            env['U_BOOT_BUILD_DIR'] =3D build_dir
> > > > > > > > > > > +        proc =3D subprocess.run(cmd, capture_output=
=3DTrue, encoding=3D'utf-8',
> > > > > > > > > > > +                              env=3Denv)
> > > > > > > > > > > +        if proc.returncode:
> > > > > > > > > > > +            raise ValueError(proc.stderr)
> > > > > > > > > > > +        print('conftest: lab:', proc.stdout)
> > > > > > > > > > > +        vals =3D {}
> > > > > > > > > > > +        for line in proc.stdout.splitlines():
> > > > > > > > > > > +            item, value =3D line.split(' ', maxsplit=
=3D1)
> > > > > > > > > > > +            k =3D item.split(':')[-1]
> > > > > > > > > > > +            vals[k] =3D value
> > > > > > > > > > > +        print('conftest: lab info:', vals)
> > > > > > > > > > > +        board_type, default_build_dir, source_dir =
=3D (vals['board'],
> > > > > > > > > > > +            vals['build_dir'], vals['source_dir'])
> > > > > > > > > > > +    else:
> > > > > > > > > > > +        board_type =3D config.getoption('board_type')
> > > > > > > > > > > +        board_identity =3D config.getoption('board_i=
dentity')
> > > > > > > > > > >
> > > > > > > > > > > -    source_dir =3D os.path.dirname(os.path.dirname(T=
EST_PY_DIR))
> > > > > > > > > > > -    default_build_dir =3D source_dir + '/build-' + b=
oard_type
> > > > > > > > > > > +        source_dir =3D os.path.dirname(os.path.dirna=
me(TEST_PY_DIR))
> > > > > > > > > > > +        default_build_dir =3D source_dir + '/build-'=
 + board_type
> > > > > > > > > > >      if not build_dir:
> > > > > > > > > > >          build_dir =3D default_build_dir
> > > > > > > > > >
> > > > > > > > > > I'm a little confused here. Why can't we construct "rol=
e" from
> > > > > > > > > > board_type+board_identity and then we have the board
> > > > > > > > > > conf.${board_type}_${board_identity} file set whatever =
needs setting to
> > > > > > > > > > be "labgrid" ?
> > > > > > > > >
> > > > > > > > > The role is equivalent to the board identity, not the com=
bination of
> > > > > > > > > the U-Boot board type and the board identity. I went this=
 way to avoid
> > > > > > > > > having to type long and complicated roles when connecting=
 to boards.
> > > > > > > > > It is similar to how things work today, except that the b=
oard type is
> > > > > > > > > implied by the 'role'.
> > > > > > > > >
> > > > > > > > > For boards which have multiple identities (e.g. can suppo=
rt two
> > > > > > > > > different board types), Labgrid handles acquiring and rel=
easing the
> > > > > > > > > shares resources, to avoid any problems.
> > > > > > > >
> > > > > > > > I guess I have two sets of questions. First, if it's basica=
lly the
> > > > > > > > board identity why can't we just use that as the role name,=
 in your
> > > > > > > > setup?
> > > > > > >
> > > > > > > Yes, that's what I am doing. If you look in console.labgrid y=
ou can
> > > > > > > see that it is passing U_BOOT_BOARD_IDENTITY as the -r argume=
nt.
> > > > > >
> > > > > > Then why do we need this?
> > > > >
> > > > > We need to pass a role to Labgrid, since it determines the board
> > > > > identity to use. It also (indirectly) determines the U-Boot build=
 to
> > > > > use, since each board identity / role is a particular board with a
> > > > > particular build.
> > > >
> > > > Oh, I get where you're coming from now at least. But this still sou=
nds
> > > > like a detail to put in to the conf.${board}_${board_type} file and=
 not
> > > > a thing to set here?
> > >
> > > There are no such files with the Labgrid integration so far. They are
> > > not needed.
> >
> > They're needed in my case since I do not (cannot) use buildman to then
> > kick off the tests.
>=20
> OK...is your environment upstream so I can compare with mine?

The engineer here that was working on it is unfortunately leaving
shortly and I forget if he got everything labgrid related posted. The
other half of the environment is that none of my tests treat the hooks
repository any different than before. And note that when I say cannot
above I mean that because:
1) All of the TI platforms that require an Cortex-R and Cortex-A builds.
You can (nominally) stick with only upgrading one part at a time, and so
just test an even smaller subset on the R core, and once that passes,
test the subset of tests that run on HW on the A core.
2) Enable further options. I enable CMD_BOOTMENU, CMD_LOG globally,
CMD_TFTPPUT and FIT+FIT_SIGNATURE globally and BOOTSTAGE (+ stash) on
Pi, and I'm going to cover TI K3 platforms next (since they too can
easily share a stash addr).

The latter could be solved if buildman had some native config-fragment
support and we didn't have the #include games we have today. No, I don't
have a good idea on solving that either, only noting that today I use
scripts/kconfig/merge_config.sh to combine defconfig + the above.


> > [snip]
> > > > > Basically, as I understand it, the 'role' is the thing we want.
> > > > >
> > > > > Labgrid environment:
> > > > >
> > > > >   samus:
> > > > >     resources:
> > > > >       RemotePlace:
> > > > >         name: samus
> > > > > ...
> > > > >       UBootProviderDriver:
> > > > >         board: chromebook_samus
> > > > >         binman_indir: /vid/software/devel/samus/bin
> > > > >
> > > > >   samus_tpl:
> > > > >     resources:
> > > > >       RemotePlace:
> > > > >         name: samus
> > > > >       UBootProviderDriver:
> > > > >         board: chromebook_samus_tpl
> > > > >         binman_indir: /vid/software/devel/samus/bin
> > > >
> > > > I guess the problem here is that from my point of view, this can li=
ve in
> > > > the u-boot-test-hooks/bin/<host>/conf.<machine> file since we're ne=
ver
> > > > going to worry about building U-Boot (even if blobs aren't a proble=
m, we
> > > > want to enable more features to test more things on HW) but from yo=
ur
> > > > point of view, buildman must provide test.py with the correct build=
 so
> > > > we need to know things prior.
> > >
> > > Well, either you already have a build to test, iwc it is fine, or if
> > > you don't you can pass --build to force a build, or rely on Labgrid to
> > > initiate the build.
> >
> > No, neither buildman nor labgrid can initiate a functional build. Have
> > you integrated the beagleplay in to your lab? That I believe
> > demonstrates one of the problems (you need to build both
> > am62x_beagleplay_a53 and am62x_beagleplay_r5 and write files from both,
> > to test a given rev on the platform).
>=20
> Actually I was about to do that. Will get back to it in a few weeks.
> Labgrid can initiate two builds and copy files from both.

I'm very interested in what this all looks like once that works too.

--=20
Tom

--UOvJan6W+ApfpQkS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVjo4ACgkQFHw5/5Y0
tywe3Av+PoMi66owkFIdi4dnzvFjDi2ZCjTQ0a/WWYosUCL35RZu02/4YaPg4Eo7
1M782p+Lrq6AjV4PPQPMAWMpSgnlRZ7a6zrRtRWzVPdIMw+OHaNjH++JEPubSA5m
iUDmVEzoaO+KhMd0wEPHyO2n99RvxXYswHWfNWO4JWvrAdssv8Y44NvPw07qbveQ
Mj8Kkl8Md7yB0CgGio284HemuAOy4ojkE7YxE9FM2M3P76jglLGLCzZzW9Av06xi
UVsGyks9YHy+hGn2UokPC0GFIfr5sanLRijwoW7mgHCDCVWOS77QCVtcRjp1E6e7
d54/u9oL5tes1HAt7PAxQ368u90LYFcLio8vszWifU/9mjHO4KUDMzBTAUOrwPzX
E7AhrkiypifyDOEFL7V93M2zrgeevcpflFZ2Lko8dNWf55hIQKEtGMe02Fh3KVLQ
UckGQFqKa8nvYL2QcqYv9xPLV+3XFcGorAEVLXUFUZqVV7Z+omThkvYHj3a1VpoJ
g9DjIIbq
=tF02
-----END PGP SIGNATURE-----

--UOvJan6W+ApfpQkS--
