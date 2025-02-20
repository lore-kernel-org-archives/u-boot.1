Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B0C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8186F801BE;
	Thu, 20 Feb 2025 15:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FGnU78ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F312806FE; Thu, 20 Feb 2025 15:53:20 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B54F88007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso1688736a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740063196; x=1740667996; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UkA1rFEXOZdjqEQV6NuZaBeDFmvwrPs/ypgYwIMRzik=;
 b=FGnU78axmfMIwjAWKUzylwNV4qmNH+6xrQ4GxT/v2kG6DC0pEGxZm3BPuFx34W5zB6
 Y+fojWGQGdCGLxmbPUx3XWFDloCc+p/1cPAFujc+anIbewtesyhEovJc7VmqLZs4S6V4
 dptD4CaQ8kuvbuDZNBBgOtCOYlwf8k7VJYofk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740063196; x=1740667996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkA1rFEXOZdjqEQV6NuZaBeDFmvwrPs/ypgYwIMRzik=;
 b=arS8nKLGuUcJZ0bEAWpdUu3JAVoTUe9KnuIYhaBtA4/3OzizcYJE+8Y5UStqlpCDhH
 rTSaWXcFeTEAIfiZUT+PZacPd1hYueVHTLdMXZULJwf57pLnPrmH7AntEnYXhPbkNwFN
 mcOBYIWbb/yXbVNv3bD12P/tlZebC8zcdrqwPnuQfU/zvluBsIBfnNW2TSIEzQWjgxvK
 TL6nRya5AHBNZBEhOfYZCObM3qdxJtq/5N1PVCPklAfiWb7JYZW3FEy6Q6Eq4jdSlC6T
 jrc5S4LynHpLj/NDK/F9bG7blJ67BQFYh+/LD6BwP9GX6oSFy7ge9ncX3UTWN9J3RgGl
 PJ3Q==
X-Gm-Message-State: AOJu0Yzq/7HpvnBXvAjyaH1r/FJ+8MG6x6bmrdSGRn7Zm0FNG2IuJJG4
 vW2XRBAt9LYG8y4gBRvG2C4Ue7ZHBrqlQf0jm6fDUo/0lPA4tkoT+O4JajBl7XY=
X-Gm-Gg: ASbGncukypZmTFC5n8IeoMxv+wFNMMS+FOo3WR8phFlibs6PnP0uZ7SwaLq5VWfN271
 t2wR/zlIGKkHVacYZg8tMNDQAlxoaUw3fx5AtlbkAeG+2uyw3R5vEiYIwig7xkdu+d0zpWBEtoW
 Kdkr6siakcdL+IHTpB+mkbssrtH/JIC3wlDM/fGS/ss5UnxwmHt6hHaxn498VheH2o3WthvIZD5
 Zd54cmcHnwnxBOA89eVSYWfp0k4jMlNhNXqEhm9MFVN4NS0VYUvXzacyiAdkas40L4ssZU+UTKa
 NWaxmRZbd6NJAQ==
X-Google-Smtp-Source: AGHT+IGdboiXsR6a37GwA8xljHt+AnBZLvfGavc4ImKHzBwMoT0qBB1RDAMXjYaGg1GUGLeCUAZ5hw==
X-Received: by 2002:a17:90b:2e46:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2fc40f0f46dmr32591381a91.8.1740063195040; 
 Thu, 20 Feb 2025 06:53:15 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fcb93407a4sm3402159a91.16.2025.02.20.06.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:53:14 -0800 (PST)
Date: Thu, 20 Feb 2025 08:53:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250220145311.GY1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LpW7u3Ev21887OVt"
Content-Disposition: inline
In-Reply-To: <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
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


--LpW7u3Ev21887OVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > > > > Now that U-Boot can boot this quickly, using kvm, add a test =
that the
> > > > > > > installer starts up correctly.
> > > > > > >
> > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add more patches to support booting with kvm
> > > > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > > > >
> > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++=
++++++++++
> > > > > > >  2 files changed, 58 insertions(+)
> > > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > > >
> > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > --- a/.gitlab-ci.yml
> > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > >    variables:
> > > > > > >      ROLE: zybo
> > > > > > >    <<: *lab_dfn
> > > > > > > +
> > > > > > > +qemu-x86_64:
> > > > > > > +  variables:
> > > > > > > +    ROLE: qemu-x86_64
> > > > > > > +  <<: *lab_dfn
> > > > > >
> > > > > > I'm not sure why this is in your lab stanza, rather than the no=
rmal
> > > > > > test.py QEMU stanza.
> > > > >
> > > > > Are you wanting to add the Ubuntu image into CI? It is quite larg=
e.
> > > >
> > > > If we're going to be able to run it on N platforms, yes, we need to
> > > > think of a good way to cache the download. There's not a particular
> > > > reason we can't run the stock Ubuntu RISC-V image on the two sifive
> > > > targets and also qemu-riscv64, is there?
> > >
> > > Yes, we can do that. It is pretty simple to set up in Labgrid and it
> > > doesn't require all the runners to download a much larger image, etc.
> >
> > I don't quite understand why it's under "labgrid". These are generic CI
> > tests. Now maybe we need to, in both Gitlab and Azure, add some logic so
> > that certain longer or possibly destructive tests are only run on tagged
> > releases or as requested rather than every time, as it will take longer.
> > But pretty much every platform under the qemu target list should be able
> > to Just Boot an off the shelf OS distribution is my point.
>=20
> Sure, and I'm not suggesting we shouldn't do that as well.
>=20
> >
> > > > > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/tes=
t_distro.py
> > > > > > > new file mode 100644
> > > > > > > index 00000000000..51eec45cecc
> > > > > > > --- /dev/null
> > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > @@ -0,0 +1,53 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > > > +
> > > > > > > +import pytest
> > > > > > > +
> > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > +
> > > > > > > +# Enable early console so that the test can see if something=
 goes wrong
> > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3Duart8250=
,io,0x3f8'
> > > > > > > +
> > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > +def test_distro(ubman):
> > > > > > > +    """Test that of-platdata can be generated and used in sa=
ndbox"""
> > > > > > > +    with ubman.log.section('boot'):
> > > > > > > +        ubman.run_command('boot', wait_for_prompt=3DFalse)
> > > > > > > +
> > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > +        # Wait for grub to come up and offset a menu
> > > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > > +
> > > > > > > +        # Press 'e' to edit the command line
> > > > > > > +        ubman.run_command('e', wait_for_prompt=3DFalse, send=
_nl=3DFalse)
> > > > > > > +
> > > > > > > +        # Wait until we see the editor appear
> > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > +
> > > > > > > +        # Go down to the 'linux' line
> > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > +
> > > > > > > +        # Go to end of line
> > > > > > > +        ubman.ctrl('E')
> > > > > > > +
> > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > > +
> > > > > > > +        # Send our noisy console
> > > > > > > +        ubman.send(CONSOLE)
> > > > > > > +
> > > > > > > +        # Tell grub to boot
> > > > > > > +        ubman.ctrl('X')
> > > > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > > > +
> > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > +        # Linux should start immediately
> > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > +
> > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > +        # Shortly later, we should see this banner
> > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'=
])
> > > > > > > +
> > > > > > > +    ubman.restart_uboot()
> > > > > >
> > > > > > And this seems very inflexible. Please see
> > > > > > test/py/tests/test_net_boot.py for an example of how to have th=
is be
> > > > > > configurable and work on arbitrary platforms. What I assume is =
tricky is
> > > > > > that the "role" part here is where you have a special disk imag=
e being
> > > > > > passed. That too could be dealt with in u-boot-test-hooks in a =
few ways,
> > > > > > and the images pre-fetched to the CI container. And if this was
> > > > > > configurable similar to the example I noted above, it could che=
ck real
> > > > > > hardware too.
> > > > >
> > > > > That wasn't the reaction I expected.
> > > > >
> > > > > Yes, it is inflexible, but it is a starting point. Isn't it better
> > > > > than what we have today?
> > > >
> > > > Is your inflexible boot an OS test better than the flexible boot an=
 OS
> > > > test that we have today? No, it's not.
> > >
> > > I didn't even know about it, or perhaps I forgot.
> >
> > I believe I mentioned it every time you've said we should have an OS
> > test, so yes, I guess you forgot.
>=20
> Well it was only added in May last year and it relies on board config
> which I don't have...although I see that you have now posted yours.

Yes, it was added not quite a year ago, and is documented within the
test, like most tests that rely on the real platform.

And do we need better documentation for test? Yes.

> > > Perhaps this relates to getting the labgrid config published and
> > > figuring out how to pass info from Labgrid to tests.
> > >
> > > >
> > > > > I would like to generalise this test to work on at least one real
> > > > > board, preferably one that doesn't use grub.
> > > >
> > > > OK. The test we have today does that, if you check for the "Welcome=
 to
> > > > ..." string instead of the kernel has booted string. It also does
> > > > netboot rather than run default bootcmd. But that's an easy enough =
test
> > > > to write up. The only thing stopping me from doing that right now i=
s I
> > > > need to find a board in the lab where we installed an OS to eMMC an=
d not
> > > > SD card (some lab sd-mux issues).
> > >
> > > OK. Labgrid has a 'features' thing which you can attach to targets, so
> > > I should be able to use that to indicate that Ubuntu, Debian, Armbian,
> > > etc. are available.
> >
> > OK, but that sounds like the opposite direction. These are generic tests
> > that can run in any / all of the labs, not just your labgrid
> > configuration. AMD has been contributing tests that run on hardware for
> > example.
>=20
> That's great, the more tests we have the better. But those tests can't
> and don't run in CI, whereas mine can and do.

AFAICT they're running on AMD's CI. They run on my CI. They don't run on
*your* lab because you took things, intentionally, in a direction to
minimize using u-boot-test-hooks and our existing per-board
configuration infrastructure.

> We need an 'all of the above' strategy here.

Sure. But I still want to see things as reusable as possible. What you
have above is *extremely* board and OS specific and non-configurable. I
also don't quite see why it's not a test of autoboot with the
pre-requisite of an OS being installed.

> BTW, having thought about how test/py works a bit, instead of the
> env__net_tftp_bootable_file stuff, we should have code or data which
> sets up the required test files (on a suitable server) before running
> the test. That way, all the test code is in one Python file and we
> don't have to spend ages trying to divine what each test needs.

That seems like a lot more work than documenting more what we have
today, and I'm not sure of the benefit. Given the contents of the pxe
test, yes, just having those files available to 'cp' in place would be
helpful. But that's not the case for booting a kernel (the FIT match
stuff doesn't work on the TI platforms atm). And if you look at the
config I posted it also includes bootstage configuration. It also won't
work well for the SPI tests, which I'm talking with Love about in
another thread.

In other words, the majority of py/<host>/u_boot_boardenv_ content is
configuration details, specific to both the platform / SoC first, some
lab specific details second and drop-in existing 3rd party files a
distant third.

--=20
Tom

--LpW7u3Ev21887OVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme3Qc8ACgkQFHw5/5Y0
tyztswv/bfxKBNKkkHWdYpDFZIcb8A6rNU73jumn5oSizyuk7CvSMFxc/NTnvCga
NQemtjdgl+zr1g7ufPVD6ULwb46bu74rb739pJ/xi/9bHUBGqU+yzS4O4GtnVXP2
dysVPCO4SiBjPQlmm+0lDUYYg6SEGulKDxIwAR/18UeHN3dScefb5UIGZC24U0No
VSL3HpPkE3fMjkJC2fp4SCv68lZJoYaXcbYUWO2HAh7voKcK6QJQCrsQqlMKCbc9
/H4atjKim4fjkAZz+LCqH2d67JRyCmCX5aQtr23moTiPpQAKFu6qpgM//0f10Z5o
EGxFa8niWz/AMJXrBs3+lsuD7Yuey6pGXuEfpuXKFCeJHQFLQA2KkLK82HdJlDq6
5gOEQ71CCXd4jDZByOOHMyDVidtgrMAz9WtrQB9Az40q19AqW3kprUEnZYBlooRv
q9zfQ0VKwqVxrSnkKBaaPmjPY9qnlT6ztsC5FFIQbtQqVdkT8bobtJb0DpxRH4Hj
wQktfHEd
=TDNM
-----END PGP SIGNATURE-----

--LpW7u3Ev21887OVt--
