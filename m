Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A654FC021AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2F180646;
	Wed, 19 Feb 2025 01:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gByzZSeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D6880BAE; Wed, 19 Feb 2025 01:55:22 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A06800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2211acda7f6so66302845ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739926518; x=1740531318; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ybJ4UUlcoyE4xpsF2eV2GKUtK3An5LEfah9P6R1kNF4=;
 b=gByzZSeVD6SZ42Zl/tSEype98cWmlxlqQkq4L67Mpo5wGfc2WKouZg23PmlJ0QRLh4
 uxzFtsdRIjgaa1muf3vKZpw9vFFhQad/1/wOTt7jNij/fm7jbt2pDpP3Ml5KK63EFZiH
 Qo2lZPP6SsxQ1I/EAiZdKqIB7ILdCwN49DEUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739926518; x=1740531318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybJ4UUlcoyE4xpsF2eV2GKUtK3An5LEfah9P6R1kNF4=;
 b=r3evrfv8wqovycQiGR7phX1rNOwF9gBUEt4cIsfhPeV2O0gDpntnaEzhsTPMHP8vs3
 Kj6bQzylPyr8lHJy5ToZet8Xr836I/W79H5tEw1hgFeQU/3WFZLKfUAyF9ZWe9MKo/KV
 tMfCJfqFVh9H0gCFCPUYu87+NwlCKksDE5u0HIwx7RdSDOV/WAlEKUr1oy3BqUDt9Fo/
 ln2EpOH72/5nxfBGLBdepEJYKSv3nrlbpLt/YDC3hfZBmiPwy+Qf3kIexKauneE9cwIK
 ZU3CSOOgnGfm7jPC1POtMmALh3aMW/2omQrLgdLKmvbY0Sznp8gnQjroCWyNixBwwFU2
 m0VQ==
X-Gm-Message-State: AOJu0Yzt5l4lZAcAc9jih5UsmT5mthscorsMJuRSxePoM/w1w7o9ZME+
 GdmQNQ2AyW8+2XZ3/QgzVFYwDec0tXZqcVRRIq0vqosRoavECsRzeV94my8SIQo=
X-Gm-Gg: ASbGncuw7c9LGfHYWvnIhSEnpEc3wGICasTYbEcT8P30oU7x6k2xTeoM2/gskgHxOfa
 h1U+VuPlyThQC5T2XACzwduRQI0olgkJ9Ru+EWm+xDQWRgi1CPa3V1tuJnsTl5z7yAhP0gTZI3I
 P5GDuPsDxIByhlFLBmgSZhqCaZnoQk3PuOpXYB1+gcvQMBeERBh0whtkqw4W/wxx9cZhkeK9Vev
 g8wk0eTmRzgv4GsAF7i2u9Ocju3A9unzZinCeoreH61V5JFGcOh4f7lu9N76Q1uJJ/tWslY0X8u
 G4HosKL7mpl6hg==
X-Google-Smtp-Source: AGHT+IFphNz1fCOhWlntfnfIs3XAKAsGdhZKacCdfWtoELs0JSfTDebzPxO5rd2rQ2D0VJt2cFq1LA==
X-Received: by 2002:a17:903:2346:b0:220:d81a:bebf with SMTP id
 d9443c01a7336-2216f43f09bmr25660925ad.0.1739926518273; 
 Tue, 18 Feb 2025 16:55:18 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d473sm94482225ad.166.2025.02.18.16.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 16:55:17 -0800 (PST)
Date: Tue, 18 Feb 2025 18:55:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250219005515.GR1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ivXfGNd75G6oroQs"
Content-Disposition: inline
In-Reply-To: <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
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


--ivXfGNd75G6oroQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > > Now that U-Boot can boot this quickly, using kvm, add a test that=
 the
> > > > > installer starts up correctly.
> > > > >
> > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add more patches to support booting with kvm
> > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > >
> > > > >  .gitlab-ci.yml               |  5 ++++
> > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 58 insertions(+)
> > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > >
> > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > --- a/.gitlab-ci.yml
> > > > > +++ b/.gitlab-ci.yml
> > > > > @@ -745,3 +745,8 @@ zybo:
> > > > >    variables:
> > > > >      ROLE: zybo
> > > > >    <<: *lab_dfn
> > > > > +
> > > > > +qemu-x86_64:
> > > > > +  variables:
> > > > > +    ROLE: qemu-x86_64
> > > > > +  <<: *lab_dfn
> > > >
> > > > I'm not sure why this is in your lab stanza, rather than the normal
> > > > test.py QEMU stanza.
> > >
> > > Are you wanting to add the Ubuntu image into CI? It is quite large.
> >
> > If we're going to be able to run it on N platforms, yes, we need to
> > think of a good way to cache the download. There's not a particular
> > reason we can't run the stock Ubuntu RISC-V image on the two sifive
> > targets and also qemu-riscv64, is there?
>=20
> Yes, we can do that. It is pretty simple to set up in Labgrid and it
> doesn't require all the runners to download a much larger image, etc.

I don't quite understand why it's under "labgrid". These are generic CI
tests. Now maybe we need to, in both Gitlab and Azure, add some logic so
that certain longer or possibly destructive tests are only run on tagged
releases or as requested rather than every time, as it will take longer.
But pretty much every platform under the qemu target list should be able
to Just Boot an off the shelf OS distribution is my point.

> > > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_di=
stro.py
> > > > > new file mode 100644
> > > > > index 00000000000..51eec45cecc
> > > > > --- /dev/null
> > > > > +++ b/test/py/tests/test_distro.py
> > > > > @@ -0,0 +1,53 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > +# Copyright 2025 Canonical Ltd.
> > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > +
> > > > > +import pytest
> > > > > +
> > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > +
> > > > > +# Enable early console so that the test can see if something goe=
s wrong
> > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3Duart8250,io,=
0x3f8'
> > > > > +
> > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > +def test_distro(ubman):
> > > > > +    """Test that of-platdata can be generated and used in sandbo=
x"""
> > > > > +    with ubman.log.section('boot'):
> > > > > +        ubman.run_command('boot', wait_for_prompt=3DFalse)
> > > > > +
> > > > > +    with ubman.log.section('Grub'):
> > > > > +        # Wait for grub to come up and offset a menu
> > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > +
> > > > > +        # Press 'e' to edit the command line
> > > > > +        ubman.run_command('e', wait_for_prompt=3DFalse, send_nl=
=3DFalse)
> > > > > +
> > > > > +        # Wait until we see the editor appear
> > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > +
> > > > > +        # Go down to the 'linux' line
> > > > > +        ubman.send(DOWN * 3)
> > > > > +
> > > > > +        # Go to end of line
> > > > > +        ubman.ctrl('E')
> > > > > +
> > > > > +        # Backspace to remove 'quiet splash'
> > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > +
> > > > > +        # Send our noisy console
> > > > > +        ubman.send(CONSOLE)
> > > > > +
> > > > > +        # Tell grub to boot
> > > > > +        ubman.ctrl('X')
> > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > +
> > > > > +    with ubman.log.section('Linux'):
> > > > > +        # Linux should start immediately
> > > > > +        ubman.p.expect(['Linux version'])
> > > > > +
> > > > > +    with ubman.log.section('Ubuntu'):
> > > > > +        # Shortly later, we should see this banner
> > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > > > > +
> > > > > +    ubman.restart_uboot()
> > > >
> > > > And this seems very inflexible. Please see
> > > > test/py/tests/test_net_boot.py for an example of how to have this be
> > > > configurable and work on arbitrary platforms. What I assume is tric=
ky is
> > > > that the "role" part here is where you have a special disk image be=
ing
> > > > passed. That too could be dealt with in u-boot-test-hooks in a few =
ways,
> > > > and the images pre-fetched to the CI container. And if this was
> > > > configurable similar to the example I noted above, it could check r=
eal
> > > > hardware too.
> > >
> > > That wasn't the reaction I expected.
> > >
> > > Yes, it is inflexible, but it is a starting point. Isn't it better
> > > than what we have today?
> >
> > Is your inflexible boot an OS test better than the flexible boot an OS
> > test that we have today? No, it's not.
>=20
> I didn't even know about it, or perhaps I forgot.

I believe I mentioned it every time you've said we should have an OS
test, so yes, I guess you forgot.

> Perhaps this relates to getting the labgrid config published and
> figuring out how to pass info from Labgrid to tests.
>=20
> >
> > > I would like to generalise this test to work on at least one real
> > > board, preferably one that doesn't use grub.
> >
> > OK. The test we have today does that, if you check for the "Welcome to
> > ..." string instead of the kernel has booted string. It also does
> > netboot rather than run default bootcmd. But that's an easy enough test
> > to write up. The only thing stopping me from doing that right now is I
> > need to find a board in the lab where we installed an OS to eMMC and not
> > SD card (some lab sd-mux issues).
>=20
> OK. Labgrid has a 'features' thing which you can attach to targets, so
> I should be able to use that to indicate that Ubuntu, Debian, Armbian,
> etc. are available.

OK, but that sounds like the opposite direction. These are generic tests
that can run in any / all of the labs, not just your labgrid
configuration. AMD has been contributing tests that run on hardware for
example.

--=20
Tom

--ivXfGNd75G6oroQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1K/MACgkQFHw5/5Y0
tyzLZwv/VusaeL337xT4kF9Mowdb0/v0MSFnugMbkIjo3lWz6Oa/5NIv4dMiQLrw
iMppQX9KFMjiyO1nH+IPRk+h1uZLZp46A3YdPFClzLFeA5M6kPm966fH32gdAOOC
06xbruhGV6HQCylbN0Pj/P+Ksg8UkEukUoeKP02Ag/0xnUPbpAkKBUkB/hrgaEik
UsoGbBJJnL49wvTzG9UfFNWXqT04YrIWXMrS4bNwFm3bOQP9dq7v7FvyNIs2kEpR
N81As1eR7CSmYZplALNrFIWZ25tvXugCU98l4eO6AaHj0Uxj+6aiTxWHzU0xx+mO
raWiFr2pXYQ5a7rCcm5IrX13SFc7MIwHmi9yb/88ANC4Yk/mRaCMpjS4RhdFZfeW
KztJRr56E5yydWwS32Yl7yer5Raj/FS0S/uES28FZPTGjNAaPHQdn8R8CUeYdojJ
nN4XoYq0Gony6LT5aFAttCYkUy3k3dzpY2vYyhUnAr2VG4cMp/cyYusxRiRlhiLh
aNDF7Y6p
=C9D4
-----END PGP SIGNATURE-----

--ivXfGNd75G6oroQs--
