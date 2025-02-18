Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BA9C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 15:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A53D80ADF;
	Tue, 18 Feb 2025 16:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LdgKL2rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDFA80BAE; Tue, 18 Feb 2025 16:11:53 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF1B80646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so6782899a91.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 07:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739891509; x=1740496309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s2uup/c7Q6u/k5GUv5XwLOctQc12tm9J8PuH1AoZOn0=;
 b=LdgKL2rwUEiCiTdXsbqbGjRZ6tjFHaDy8ViHUrqS3yJvUawjLS0o/81NsuNvuNjDfF
 uo3gExlYhqWRWhuQz5Zemf5pnJFopEyTcIYzoM1aKYLSdwDcfRcq0Ly/XIvkUhyA0ywU
 ngmWdTQ4seZl2dO62ByIdACphjsykxGCv4A2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739891509; x=1740496309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2uup/c7Q6u/k5GUv5XwLOctQc12tm9J8PuH1AoZOn0=;
 b=g68uN76DxPy6qHre0tyckHpLkILY067QY1YokKgX8OLCWalW5vyqI8zkgSa4OcxwmF
 kBRYIGuBgDqsC3fMzzOGoVvkxVRqcIF9WS5b5W/HoneI2zybVCV/oHU2V7qU6BAJ99kH
 i5/HJWgnjkv1YY+z0B31ZZJtEYOj+eB791HCbmtNYLfcwXyynPly8hbJO789lM6kkWgO
 aEPUSFOTaZYYG5Ai97qdErmDlXG05nDtOqgkfkWc1UMpcbQvSQf+e261QNDhD4JY5k8U
 w4/rEs2UrXhvbBtqbdnd5qdE99y1+sQw82BhiFkMMEB0UstAG3RIdr6dflNTLkilGOmY
 zoNw==
X-Gm-Message-State: AOJu0YzKqs7nbAw8J50NeCGVIZbs+cptM5oQCux1dZW3TkI85osyxXlD
 0kYiOSInsGGSYcpbRkhfz/0UdADJdoqqJjoYjppFjSiI9b6nCK9H4zMELGnDHH8=
X-Gm-Gg: ASbGncsR21gFbqMsp2wrIMJifAT3eik2yoaFan8q8QLIHe6J6zVVU1KLbQbhLLS2fAP
 9KkBQ6hj34EeHnZcXqe2cm3+Nr/ob8miSkXWAbNEGTf3GjCfBb2VyXCDaLK6f5XMPWzckdSHmqz
 YjCSK6/c/26YxhV8EAO7tSfS/mvwUOmVuO06awsSAHf32OwONwTbeT3PCLesRNUxPWVn/QWCT8w
 kVibi5jXsJouA/kVPEFn6ztnvZnG/Hx2LlMC1Fg8N7fe6z2dt/lG9Ohgu0IcTCaxT18ygmodIzt
 YRWRnCx7GZxtYw==
X-Google-Smtp-Source: AGHT+IGRxcj4WgU0RAoxI6WB899V4ARC3LxZ4y+6sxk4QjNIZ4UipK1MlhEdTVIA2CTXSr0UH/cMfg==
X-Received: by 2002:a17:90a:ec8d:b0:2f6:f107:fae4 with SMTP id
 98e67ed59e1d1-2fc40f0e822mr20014475a91.8.1739891508975; 
 Tue, 18 Feb 2025 07:11:48 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ab1000sm10183730a91.9.2025.02.18.07.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 07:11:48 -0800 (PST)
Date: Tue, 18 Feb 2025 09:11:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250218151145.GD1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wvw34xT2aTu7MWRE"
Content-Disposition: inline
In-Reply-To: <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
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


--Wvw34xT2aTu7MWRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > Now that U-Boot can boot this quickly, using kvm, add a test that the
> > > installer starts up correctly.
> > >
> > > Use the qemu-x86_64 board in the SJG lab.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Add more patches to support booting with kvm
> > > - Add new patch with a test for booting Ubuntu 24.04
> > >
> > >  .gitlab-ci.yml               |  5 ++++
> > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 58 insertions(+)
> > >  create mode 100644 test/py/tests/test_distro.py
> > >
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index 8c49d5b0a79..ec799e97c10 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -745,3 +745,8 @@ zybo:
> > >    variables:
> > >      ROLE: zybo
> > >    <<: *lab_dfn
> > > +
> > > +qemu-x86_64:
> > > +  variables:
> > > +    ROLE: qemu-x86_64
> > > +  <<: *lab_dfn
> >
> > I'm not sure why this is in your lab stanza, rather than the normal
> > test.py QEMU stanza.
>=20
> Are you wanting to add the Ubuntu image into CI? It is quite large.

If we're going to be able to run it on N platforms, yes, we need to
think of a good way to cache the download. There's not a particular
reason we can't run the stock Ubuntu RISC-V image on the two sifive
targets and also qemu-riscv64, is there?

> > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro=
=2Epy
> > > new file mode 100644
> > > index 00000000000..51eec45cecc
> > > --- /dev/null
> > > +++ b/test/py/tests/test_distro.py
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +# Copyright 2025 Canonical Ltd.
> > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > +
> > > +import pytest
> > > +
> > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > +
> > > +# Enable early console so that the test can see if something goes wr=
ong
> > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3Duart8250,io,0x3f=
8'
> > > +
> > > +@pytest.mark.boardspec('qemu-x86_64')
> > > +@pytest.mark.role('qemu-x86_64')
> > > +def test_distro(ubman):
> > > +    """Test that of-platdata can be generated and used in sandbox"""
> > > +    with ubman.log.section('boot'):
> > > +        ubman.run_command('boot', wait_for_prompt=3DFalse)
> > > +
> > > +    with ubman.log.section('Grub'):
> > > +        # Wait for grub to come up and offset a menu
> > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > +
> > > +        # Press 'e' to edit the command line
> > > +        ubman.run_command('e', wait_for_prompt=3DFalse, send_nl=3DFa=
lse)
> > > +
> > > +        # Wait until we see the editor appear
> > > +        ubman.p.expect(['/casper/initrd'])
> > > +
> > > +        # Go down to the 'linux' line
> > > +        ubman.send(DOWN * 3)
> > > +
> > > +        # Go to end of line
> > > +        ubman.ctrl('E')
> > > +
> > > +        # Backspace to remove 'quiet splash'
> > > +        ubman.send('\b' * len('quiet splash'))
> > > +
> > > +        # Send our noisy console
> > > +        ubman.send(CONSOLE)
> > > +
> > > +        # Tell grub to boot
> > > +        ubman.ctrl('X')
> > > +        ubman.p.expect(['Booting a command list'])
> > > +
> > > +    with ubman.log.section('Linux'):
> > > +        # Linux should start immediately
> > > +        ubman.p.expect(['Linux version'])
> > > +
> > > +    with ubman.log.section('Ubuntu'):
> > > +        # Shortly later, we should see this banner
> > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > > +
> > > +    ubman.restart_uboot()
> >
> > And this seems very inflexible. Please see
> > test/py/tests/test_net_boot.py for an example of how to have this be
> > configurable and work on arbitrary platforms. What I assume is tricky is
> > that the "role" part here is where you have a special disk image being
> > passed. That too could be dealt with in u-boot-test-hooks in a few ways,
> > and the images pre-fetched to the CI container. And if this was
> > configurable similar to the example I noted above, it could check real
> > hardware too.
>=20
> That wasn't the reaction I expected.
>=20
> Yes, it is inflexible, but it is a starting point. Isn't it better
> than what we have today?

Is your inflexible boot an OS test better than the flexible boot an OS
test that we have today? No, it's not.

> I would like to generalise this test to work on at least one real
> board, preferably one that doesn't use grub.

OK. The test we have today does that, if you check for the "Welcome to
=2E.." string instead of the kernel has booted string. It also does
netboot rather than run default bootcmd. But that's an easy enough test
to write up. The only thing stopping me from doing that right now is I
need to find a board in the lab where we installed an OS to eMMC and not
SD card (some lab sd-mux issues).

--=20
Tom

--Wvw34xT2aTu7MWRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme0oyYACgkQFHw5/5Y0
tyytJQv/WRO8LJgn8l7KlpbgkZQFyYrppkbO+lDKg38RvRAvg61k8d1A7C28L1fu
W2BkV3tkNsR4M2SZcz97+S27ord7rEkNFfY7fpuQL4amqbuVrRFAATFWENiOgs5G
WJllGL/f9MbfhFPqG9XDq2XD89upCJ7FUOHhKAUZ8Vxgnx7Q1iYo8MXQTC00xIC6
cSp6CR7tSwiZv6h4U+rotK2niLcnSf+XId2mU1ufQcmMwvDwSndwP0MQ5Awd4YqZ
DvaIIpgMIcm1Fx1ZFkw1esHjYn/v9PIJle1l398UeH85GIpeyAH3qYNj2iK3WY+6
lr20uGA8zwtv0Qrym7viORB5JGXaFoC/VSYFoy3JB02GPsyZtQE4rRz6/teVRUnc
Tj7TYJ6YSmAUcLYVuJKaBl+TZvDNZbXIEVDW/pbJdlKmkJVnLjYW3zGPz/rADl2H
Obwa15bND8lCf2DAeCjUzHjvzGyphE7sB4eFkHdwFMbUEnMtksc2WgdRy5RiqcfT
s6ca87k9
=30Bt
-----END PGP SIGNATURE-----

--Wvw34xT2aTu7MWRE--
