Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F06AC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 16:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF828807C4;
	Fri, 21 Feb 2025 17:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QxTzztgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B73B80F56; Fri, 21 Feb 2025 17:06:36 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5428C806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 17:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220f4dd756eso46818065ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740153992; x=1740758792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vq3b1LdlFfEzuQx5Mc5fesL77fm+9J9SVfX1q2IwX5w=;
 b=QxTzztgZF/sUjId52PpA/AD+IFyfk1v62Xdkt+OO0SmmK7oVnEBbEoKgjPitHP24GW
 1bWRj5Pndl/w67vzKH+LTKxXB1FPBq80xHkuT9s6YxxlYd5ks5CmzjK2JqvnIaMGxoQq
 /V+Tapwrm5QMFbxBDY0hgZqzN7OBv01TYmrAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740153992; x=1740758792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vq3b1LdlFfEzuQx5Mc5fesL77fm+9J9SVfX1q2IwX5w=;
 b=i1xpHW8mELuslV0EPXLA8J/Kq0bgsHDEoXuI7+GTa36t/GAISTR9K6Mv/TpBza+xHT
 V0cO1kGQPDxJXb8bdTB/3ZXcDalV5nPpd8EqhnXFsIrhz+FJZjvd7go+AoAoBXcEBZWP
 L709z87+O5wmgBNxweZIGVV5ZRzl0VXPgoyW1z6UUjXBkFjRGltpRCJi3aavtGvTMWi8
 3OdTRfQ/6dr2yDgBL+KaBp7X4V5/VYw3Fnf+ZsomATknrXkQzSEyCVNRycwux/AK7c+r
 uejO+YImnUAQrcCzG7xNSwaUMXglOzu7IYEE1oQQ2yeODz5xDkMkVTGxyHT79LT/24mZ
 WyjA==
X-Gm-Message-State: AOJu0YzSZeBsMkj+xYx5p0wbOWACqN9FPihSAYDc11HubcikjMVbsK9h
 CeEZ6vyrg8gH7gZ7Nm6GsN+YzoiNhrEUKHjNUesuahQZJSu15zMxrnQZvHyOIIs=
X-Gm-Gg: ASbGnctv5ht7AvIFMmU7RJrpGESHhFp2z71o6P896pH0OgJzylrDFdKdvAvV9miXa7k
 QmeOSdOQPGM2DDGQZEowTuwqMqdIPyPQ4mLLvu7zKd0SPq4v4NZVEzZ+y17foK3NdfjekVmBcRW
 CmE3dRbLFb5ddpSHhy/RQ/bzHQ1ANe8kNXgQloxr8GBY9HhGMmR1x+i2lgSQ4rkYcc6nMsGXF9s
 d9Q/Ilg67lymyTapICVW50ucyNT37O//K2YB/rEM2MV605sOHH7rT3pUdYiKQAW+KUOzeQYjqrT
 JsigOAhjuyOzjttAcWzFdCQS
X-Google-Smtp-Source: AGHT+IFpkismIZeY78AyRBAOFqnBjFe5qDluz9HzzcByLWairDzn07o822iM+mQDdVJKYLzDP2el8w==
X-Received: by 2002:a17:903:2f06:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-2219ffa36d9mr59806445ad.36.1740153991553; 
 Fri, 21 Feb 2025 08:06:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732511dfd9esm14621925b3a.67.2025.02.21.08.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 08:06:30 -0800 (PST)
Date: Fri, 21 Feb 2025 10:06:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250221160628.GJ1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qzgg8gfJpN0QB2QD"
Content-Disposition: inline
In-Reply-To: <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
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


--qzgg8gfJpN0QB2QD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > > > > > > Now that U-Boot can boot this quickly, using kvm, add a t=
est that the
> > > > > > > > > installer starts up correctly.
> > > > > > > > >
> > > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Add more patches to support booting with kvm
> > > > > > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > > > > > >
> > > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > > > > >
> > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > > >    variables:
> > > > > > > > >      ROLE: zybo
> > > > > > > > >    <<: *lab_dfn
> > > > > > > > > +
> > > > > > > > > +qemu-x86_64:
> > > > > > > > > +  variables:
> > > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > > +  <<: *lab_dfn
> > > > > > > >
> > > > > > > > I'm not sure why this is in your lab stanza, rather than th=
e normal
> > > > > > > > test.py QEMU stanza.
> > > > > > >
> > > > > > > Are you wanting to add the Ubuntu image into CI? It is quite =
large.
> > > > > >
> > > > > > If we're going to be able to run it on N platforms, yes, we nee=
d to
> > > > > > think of a good way to cache the download. There's not a partic=
ular
> > > > > > reason we can't run the stock Ubuntu RISC-V image on the two si=
five
> > > > > > targets and also qemu-riscv64, is there?
> > > > >
> > > > > Yes, we can do that. It is pretty simple to set up in Labgrid and=
 it
> > > > > doesn't require all the runners to download a much larger image, =
etc.
> > > >
> > > > I don't quite understand why it's under "labgrid". These are generi=
c CI
> > > > tests. Now maybe we need to, in both Gitlab and Azure, add some log=
ic so
> > > > that certain longer or possibly destructive tests are only run on t=
agged
> > > > releases or as requested rather than every time, as it will take lo=
nger.
> > > > But pretty much every platform under the qemu target list should be=
 able
> > > > to Just Boot an off the shelf OS distribution is my point.
> > >
> > > Sure, and I'm not suggesting we shouldn't do that as well.
> > >
> > > >
> > > > > > > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests=
/test_distro.py
> > > > > > > > > new file mode 100644
> > > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > > > > > +
> > > > > > > > > +import pytest
> > > > > > > > > +
> > > > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > > > +
> > > > > > > > > +# Enable early console so that the test can see if somet=
hing goes wrong
> > > > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3Duart=
8250,io,0x3f8'
> > > > > > > > > +
> > > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > > +def test_distro(ubman):
> > > > > > > > > +    """Test that of-platdata can be generated and used i=
n sandbox"""
> > > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > > +        ubman.run_command('boot', wait_for_prompt=3DFals=
e)
> > > > > > > > > +
> > > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > > +        # Wait for grub to come up and offset a menu
> > > > > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > > > > +
> > > > > > > > > +        # Press 'e' to edit the command line
> > > > > > > > > +        ubman.run_command('e', wait_for_prompt=3DFalse, =
send_nl=3DFalse)
> > > > > > > > > +
> > > > > > > > > +        # Wait until we see the editor appear
> > > > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > > > +
> > > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > > +
> > > > > > > > > +        # Go to end of line
> > > > > > > > > +        ubman.ctrl('E')
> > > > > > > > > +
> > > > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > > > > +
> > > > > > > > > +        # Send our noisy console
> > > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > > +
> > > > > > > > > +        # Tell grub to boot
> > > > > > > > > +        ubman.ctrl('X')
> > > > > > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > > > > > +
> > > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > > +        # Linux should start immediately
> > > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > > +
> > > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > > +        # Shortly later, we should see this banner
> > > > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS=
=2E*!'])
> > > > > > > > > +
> > > > > > > > > +    ubman.restart_uboot()
> > > > > > > >
> > > > > > > > And this seems very inflexible. Please see
> > > > > > > > test/py/tests/test_net_boot.py for an example of how to hav=
e this be
> > > > > > > > configurable and work on arbitrary platforms. What I assume=
 is tricky is
> > > > > > > > that the "role" part here is where you have a special disk =
image being
> > > > > > > > passed. That too could be dealt with in u-boot-test-hooks i=
n a few ways,
> > > > > > > > and the images pre-fetched to the CI container. And if this=
 was
> > > > > > > > configurable similar to the example I noted above, it could=
 check real
> > > > > > > > hardware too.
> > > > > > >
> > > > > > > That wasn't the reaction I expected.
> > > > > > >
> > > > > > > Yes, it is inflexible, but it is a starting point. Isn't it b=
etter
> > > > > > > than what we have today?
> > > > > >
> > > > > > Is your inflexible boot an OS test better than the flexible boo=
t an OS
> > > > > > test that we have today? No, it's not.
> > > > >
> > > > > I didn't even know about it, or perhaps I forgot.
> > > >
> > > > I believe I mentioned it every time you've said we should have an OS
> > > > test, so yes, I guess you forgot.
> > >
> > > Well it was only added in May last year and it relies on board config
> > > which I don't have...although I see that you have now posted yours.
> >
> > Yes, it was added not quite a year ago, and is documented within the
> > test, like most tests that rely on the real platform.
> >
> > And do we need better documentation for test? Yes.
>=20
> +1
>=20
> I'll note that I did my bit!
>=20
> >
> > > > > Perhaps this relates to getting the labgrid config published and
> > > > > figuring out how to pass info from Labgrid to tests.
> > > > >
> > > > > >
> > > > > > > I would like to generalise this test to work on at least one =
real
> > > > > > > board, preferably one that doesn't use grub.
> > > > > >
> > > > > > OK. The test we have today does that, if you check for the "Wel=
come to
> > > > > > ..." string instead of the kernel has booted string. It also do=
es
> > > > > > netboot rather than run default bootcmd. But that's an easy eno=
ugh test
> > > > > > to write up. The only thing stopping me from doing that right n=
ow is I
> > > > > > need to find a board in the lab where we installed an OS to eMM=
C and not
> > > > > > SD card (some lab sd-mux issues).
> > > > >
> > > > > OK. Labgrid has a 'features' thing which you can attach to target=
s, so
> > > > > I should be able to use that to indicate that Ubuntu, Debian, Arm=
bian,
> > > > > etc. are available.
> > > >
> > > > OK, but that sounds like the opposite direction. These are generic =
tests
> > > > that can run in any / all of the labs, not just your labgrid
> > > > configuration. AMD has been contributing tests that run on hardware=
 for
> > > > example.
> > >
> > > That's great, the more tests we have the better. But those tests can't
> > > and don't run in CI, whereas mine can and do.
> >
> > AFAICT they're running on AMD's CI. They run on my CI. They don't run on
> > *your* lab because you took things, intentionally, in a direction to
> > minimize using u-boot-test-hooks and our existing per-board
> > configuration infrastructure.
>=20
> When I look at CI all I see is my lab. Which CI are you referring to
> and how can I access it?

I'll point you at the notes for the first call we had recently:
https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-cat/
and note that there are many labs doing testing on / with U-Boot.

> Here I would like to make a case for moving to using Labgrid across
> the board, but unfortunately the project struggles to review PRs, so
> it's probably not a good idea.

It would also be counter to the feedback from the U-Boot community about
making it easier to contribute testing results from additional labs.

> > > We need an 'all of the above' strategy here.
> >
> > Sure. But I still want to see things as reusable as possible. What you
> > have above is *extremely* board and OS specific and non-configurable.
>=20
> Yes, agreed.
>=20
> > I
> > also don't quite see why it's not a test of autoboot with the
> > pre-requisite of an OS being installed.
>=20
> Ah OK, my test is just for the installer itself. Both are useful, but
> I hope eventually to have the installer run to completion and then
> reboot to check all is well.

In the spirit of "yes, and.."'ing tests, sure. Ilias pointed me at some
testing Linaro has going now that automates I believe it was current
Yocto and current U-Boot (+ the pmb patches that've been posted) doing a
full install via network in CI. So yes, a Canonical lab might also find
it useful to end to end test installing Ubuntu. My own personal dream is
that at least some of the existing kernelci labs see the utility in
adding "current U-Boot" as one of the matrix variables they test and not
just "U-Boot as delivered by vendor" as a static part of the testing.

> > > BTW, having thought about how test/py works a bit, instead of the
> > > env__net_tftp_bootable_file stuff, we should have code or data which
> > > sets up the required test files (on a suitable server) before running
> > > the test. That way, all the test code is in one Python file and we
> > > don't have to spend ages trying to divine what each test needs.
> >
> > That seems like a lot more work than documenting more what we have
> > today, and I'm not sure of the benefit. Given the contents of the pxe
> > test, yes, just having those files available to 'cp' in place would be
> > helpful. But that's not the case for booting a kernel (the FIT match
> > stuff doesn't work on the TI platforms atm). And if you look at the
> > config I posted it also includes bootstage configuration. It also won't
> > work well for the SPI tests, which I'm talking with Love about in
> > another thread.
>=20
> Yes, perhaps, but having self-contained tests would be a win.

With it's own set of technical and legal challenges / obligations and
difficulties depending on what you even mean by "self contained". And
how often what's run where, and all sorts of other challenges too.

Given the extreme depth that testing can go to, this is why I'm of the
position that we need to document things more and worry less about
prepackaged things. For example, making the documentation for the
current net based OS boot means that for bringing up a new board the
developer can just drop something in. Whereas if the tests expect a
functional OS image that has to also be messed with and is its own
challenge.

> > In other words, the majority of py/<host>/u_boot_boardenv_ content is
> > configuration details, specific to both the platform / SoC first, some
> > lab specific details second and drop-in existing 3rd party files a
> > distant third.
>=20
> I think the u-boot-test-hooks was an amazing solution 9 years ago, but
> we have outgrown it. We want people to be able to connect their lab to
> CI (meaning gitlab), so testing is more automated.

More and more public testing would be great. The notes I linked above
explain one of the first problems there being that most companies will
not or can not hook a lab to a public CI instance. The next problem, as
both of our personal labs show, is that just maintaining the physical
lab takes time and resources. I've added Heiko here because I've been
talking with him off-list about expanding tbot coverage and plumbing
that in to gitlab.

> We should move away from relying on maintainers getting around to
> testing patches months after they are sent, when they have time, but
> they don't. Things need to be more automated and I'd encourage you to
> push this as well.

I have been, and the results I've gotten are that companies are testing
things internally but there's not any good way to publish results, and
that's the kind of framework we're entirely missing.

Which is another part of why I keep pushing against having U-Boot
configuration stuff inside of Labgrid as it makes it harder for any lab
that's not using labgrid to see how to configure things.

--=20
Tom

--qzgg8gfJpN0QB2QD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4pIQACgkQFHw5/5Y0
tyxTPAwArUCJjiWzHLfFqvBCeVaG+K4keecM64lyKLHhRawFJ8ISGWoHxSyJ0gih
HrRsMGmWFjYxc59QXE8PBJYOylmC0pfDiCRZRKt1sVffpEUUX3Mz8vIt8ZPqRpwN
mT/3DPiezZBs7FsIdbGOj4YEOP2TNWSdMl5AwoNc+X67xz7Lrz/tcvnpiHeVI4KE
79a01FUeso3KDyFMGduiKaC9lsIWo70hin/C0TuozZZMF9uZ6w+FiqgrVpOToHiL
GxTn4gk03QnrvYKRD8sc2qtKBMVhN1481quqHnowou9w946UmP0VdM46AO6YddNc
84QEMFFLyV9QnZGh1Q6UDrXArqtuffvIQfXd/CHh4jKY/HIVefdalSdz1UjD9q8u
iyOzTUPCNIcC8i1/VQPf2yRhJyUSdrCW55/oMI0S+4pI2nhDUWyXFibGM+UV2+pu
uhkwRpkp5f/q/tSFVIkA/XivTruWSv9LTojGv9A9Kbb3wucEd4sPYTulvSwJ2VqK
sBSu6Xjm
=8S8K
-----END PGP SIGNATURE-----

--qzgg8gfJpN0QB2QD--
