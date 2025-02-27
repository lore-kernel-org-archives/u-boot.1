Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB1EC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4B181423;
	Thu, 27 Feb 2025 18:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDl+i0wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB7881426; Thu, 27 Feb 2025 18:20:09 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384BC81420
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22359001f1aso21404395ad.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740676805; x=1741281605; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dTiW0I+akDfeCafADaolxqk9YjgKH+zJVdygVBmsgNc=;
 b=XDl+i0wksjY/SDDd1sPTFyWYcpcPOBtNIHgZvC1SUwCuTxd2NR9CU+HCvvrdzo1WS1
 t3O/atMrica6EQpwr3NMmmENviJAwBAFQonWDvx/h4tQktWeRpWTAe8B1f9JlIT7mm4M
 eQE9KT9jx3JpbVAfq4GaB9f/Aaf1ZOfwuhuSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740676805; x=1741281605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTiW0I+akDfeCafADaolxqk9YjgKH+zJVdygVBmsgNc=;
 b=IbmbqpgAWMmN5aaT06T7AF9oOWRDnEe07cg21HYsrI8A1qSKLx4pf70kqPEPNVqSR7
 aOyFeezDxVMMdKVzCQj2Z8mYagj3CzhRuBvSdj27OiK0XFsfuG2FyXwseHXw3+4Zr0xm
 5PGsNe6UeWa56b1ChGGqY3vni/lQ5qlPh3GVhOYDO/WB/H5DmsSu1Lq9SMukjY5072A3
 ybm3QeQHvqdexUJAw8py9wreiX97owXPdZbzkoiuTUSgMVfxVbt22y4m3B19LovmzcEg
 Hr55vHpHKAZXWWNh8zoAppbrBU3RIys0vcJ5KMOtnLPGEzKd18RCgvWo2KUdEwwzXZfT
 /iyw==
X-Gm-Message-State: AOJu0YzyS42Mqpx93tE0uVVDFg02RMPDFCOf2WjMyZ8R136eZ9I3YQH6
 1/X6grzJtjMTpMDRRV3u1UNmSBIpnS5snmEwD3JCInwwlQPhYNHVpJQ/6bQi+Sqowuz1FBCInhj
 My7c=
X-Gm-Gg: ASbGncu+kmgS4ToZuazmYBUTu5HaSEnqmx3C8fpZ4Mu/5O7z4HBHqsPdvack8tH1FMe
 Z6qdRFMx62ln2pRy/kK2PSgbOkv+JLrlUfTVLGPEO1Uv/FKe6Dg+spj1g+iZpm79dTTROvnTQQl
 WGcOo196DYZdPLh6GlkZpx/wOoQL6CdJN6TeOiLXMcAvKYLTYw+dp4equp6xohP4GwBMK5lEkgM
 gZlPq77Fm6S/U+rTNQjfsV22VZHmXXDWTOGdqTMdiRoqpGK5k5ybEb+HRT7I/wB6eeWYD/dyjns
 ZPgQt6M06moSWnCKkX//+Muh
X-Google-Smtp-Source: AGHT+IHBE2lyMUq6G2SSgKAmpMf4ftdWma223UyN6dGl2JzBLdf2KBnaYSVzAOmAx+M30W1PZPzx1w==
X-Received: by 2002:a17:903:2349:b0:21f:baa:80be with SMTP id
 d9443c01a7336-221a118a866mr439760865ad.46.1740676804348; 
 Thu, 27 Feb 2025 09:20:04 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d3286sm17684385ad.46.2025.02.27.09.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:20:03 -0800 (PST)
Date: Thu, 27 Feb 2025 11:20:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250227172001.GH2640854@bill-the-cat>
References: <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
 <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bEEtfzSFWA3Cj52+"
Content-Disposition: inline
In-Reply-To: <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
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


--bEEtfzSFWA3Cj52+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 09:27:33AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Now that U-Boot can boot this quickly, using =
kvm, add a test that the
> > > > > > > > > > > > > > > installer starts up correctly.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > - Add more patches to support booting with kvm
> > > > > > > > > > > > > > > - Add new patch with a test for booting Ubunt=
u 24.04
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > > > > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++=
++++++++++++++++++++++++++
> > > > > > > > > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > > > > > > > > >  create mode 100644 test/py/tests/test_distro=
=2Epy
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > > > > > > > > >    variables:
> > > > > > > > > > > > > > >      ROLE: zybo
> > > > > > > > > > > > > > >    <<: *lab_dfn
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +qemu-x86_64:
> > > > > > > > > > > > > > > +  variables:
> > > > > > > > > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > > > > > > > > +  <<: *lab_dfn
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'm not sure why this is in your lab stanza, ra=
ther than the normal
> > > > > > > > > > > > > > test.py QEMU stanza.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Are you wanting to add the Ubuntu image into CI? =
It is quite large.
> > > > > > > > > > > >
> > > > > > > > > > > > If we're going to be able to run it on N platforms,=
 yes, we need to
> > > > > > > > > > > > think of a good way to cache the download. There's =
not a particular
> > > > > > > > > > > > reason we can't run the stock Ubuntu RISC-V image o=
n the two sifive
> > > > > > > > > > > > targets and also qemu-riscv64, is there?
> > > > > > > > > > >
> > > > > > > > > > > Yes, we can do that. It is pretty simple to set up in=
 Labgrid and it
> > > > > > > > > > > doesn't require all the runners to download a much la=
rger image, etc.
> > > > > > > > > >
> > > > > > > > > > I don't quite understand why it's under "labgrid". Thes=
e are generic CI
> > > > > > > > > > tests. Now maybe we need to, in both Gitlab and Azure, =
add some logic so
> > > > > > > > > > that certain longer or possibly destructive tests are o=
nly run on tagged
> > > > > > > > > > releases or as requested rather than every time, as it =
will take longer.
> > > > > > > > > > But pretty much every platform under the qemu target li=
st should be able
> > > > > > > > > > to Just Boot an off the shelf OS distribution is my poi=
nt.
> > > > > > > > >
> > > > > > > > > Sure, and I'm not suggesting we shouldn't do that as well.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/test/py/tests/test_distro.py b/t=
est/py/tests/test_distro.py
> > > > > > > > > > > > > > > new file mode 100644
> > > > > > > > > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > > > > > > > > +# Written by Simon Glass <simon.glass@canoni=
cal.com>
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +import pytest
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +# Enable early console so that the test can =
see if something goes wrong
> > > > > > > > > > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 co=
nsole=3Duart8250,io,0x3f8'
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > > > > > > > > +def test_distro(ubman):
> > > > > > > > > > > > > > > +    """Test that of-platdata can be generate=
d and used in sandbox"""
> > > > > > > > > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > > > > > > > > +        ubman.run_command('boot', wait_for_p=
rompt=3DFalse)
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > > > > > > > > +        # Wait for grub to come up and offse=
t a menu
> > > > > > > > > > > > > > > +        ubman.p.expect(['Try or Install Ubun=
tu'])
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Press 'e' to edit the command line
> > > > > > > > > > > > > > > +        ubman.run_command('e', wait_for_prom=
pt=3DFalse, send_nl=3DFalse)
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Wait until we see the editor appear
> > > > > > > > > > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Go to end of line
> > > > > > > > > > > > > > > +        ubman.ctrl('E')
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > > > > > > > > > +        ubman.send('\b' * len('quiet splash'=
))
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Send our noisy console
> > > > > > > > > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        # Tell grub to boot
> > > > > > > > > > > > > > > +        ubman.ctrl('X')
> > > > > > > > > > > > > > > +        ubman.p.expect(['Booting a command l=
ist'])
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > > > > > > > > +        # Linux should start immediately
> > > > > > > > > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > > > > > > > > +        # Shortly later, we should see this =
banner
> > > > > > > > > > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu=
 24.04.1 LTS.*!'])
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    ubman.restart_uboot()
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > And this seems very inflexible. Please see
> > > > > > > > > > > > > > test/py/tests/test_net_boot.py for an example o=
f how to have this be
> > > > > > > > > > > > > > configurable and work on arbitrary platforms. W=
hat I assume is tricky is
> > > > > > > > > > > > > > that the "role" part here is where you have a s=
pecial disk image being
> > > > > > > > > > > > > > passed. That too could be dealt with in u-boot-=
test-hooks in a few ways,
> > > > > > > > > > > > > > and the images pre-fetched to the CI container.=
 And if this was
> > > > > > > > > > > > > > configurable similar to the example I noted abo=
ve, it could check real
> > > > > > > > > > > > > > hardware too.
> > > > > > > > > > > > >
> > > > > > > > > > > > > That wasn't the reaction I expected.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, it is inflexible, but it is a starting point=
=2E Isn't it better
> > > > > > > > > > > > > than what we have today?
> > > > > > > > > > > >
> > > > > > > > > > > > Is your inflexible boot an OS test better than the =
flexible boot an OS
> > > > > > > > > > > > test that we have today? No, it's not.
> > > > > > > > > > >
> > > > > > > > > > > I didn't even know about it, or perhaps I forgot.
> > > > > > > > > >
> > > > > > > > > > I believe I mentioned it every time you've said we shou=
ld have an OS
> > > > > > > > > > test, so yes, I guess you forgot.
> > > > > > > > >
> > > > > > > > > Well it was only added in May last year and it relies on =
board config
> > > > > > > > > which I don't have...although I see that you have now pos=
ted yours.
> > > > > > > >
> > > > > > > > Yes, it was added not quite a year ago, and is documented w=
ithin the
> > > > > > > > test, like most tests that rely on the real platform.
> > > > > > > >
> > > > > > > > And do we need better documentation for test? Yes.
> > > > > > >
> > > > > > > +1
> > > > > > >
> > > > > > > I'll note that I did my bit!
> > > > > > >
> > > > > > > >
> > > > > > > > > > > Perhaps this relates to getting the labgrid config pu=
blished and
> > > > > > > > > > > figuring out how to pass info from Labgrid to tests.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > I would like to generalise this test to work on a=
t least one real
> > > > > > > > > > > > > board, preferably one that doesn't use grub.
> > > > > > > > > > > >
> > > > > > > > > > > > OK. The test we have today does that, if you check =
for the "Welcome to
> > > > > > > > > > > > ..." string instead of the kernel has booted string=
=2E It also does
> > > > > > > > > > > > netboot rather than run default bootcmd. But that's=
 an easy enough test
> > > > > > > > > > > > to write up. The only thing stopping me from doing =
that right now is I
> > > > > > > > > > > > need to find a board in the lab where we installed =
an OS to eMMC and not
> > > > > > > > > > > > SD card (some lab sd-mux issues).
> > > > > > > > > > >
> > > > > > > > > > > OK. Labgrid has a 'features' thing which you can atta=
ch to targets, so
> > > > > > > > > > > I should be able to use that to indicate that Ubuntu,=
 Debian, Armbian,
> > > > > > > > > > > etc. are available.
> > > > > > > > > >
> > > > > > > > > > OK, but that sounds like the opposite direction. These =
are generic tests
> > > > > > > > > > that can run in any / all of the labs, not just your la=
bgrid
> > > > > > > > > > configuration. AMD has been contributing tests that run=
 on hardware for
> > > > > > > > > > example.
> > > > > > > > >
> > > > > > > > > That's great, the more tests we have the better. But thos=
e tests can't
> > > > > > > > > and don't run in CI, whereas mine can and do.
> > > > > > > >
> > > > > > > > AFAICT they're running on AMD's CI. They run on my CI. They=
 don't run on
> > > > > > > > *your* lab because you took things, intentionally, in a dir=
ection to
> > > > > > > > minimize using u-boot-test-hooks and our existing per-board
> > > > > > > > configuration infrastructure.
> > > > > > >
> > > > > > > When I look at CI all I see is my lab. Which CI are you refer=
ring to
> > > > > > > and how can I access it?
> > > > > >
> > > > > > I'll point you at the notes for the first call we had recently:
> > > > > > https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-th=
e-cat/
> > > > > > and note that there are many labs doing testing on / with U-Boo=
t.
> > > > >
> > > > > That's all good, but it isn't as good as having the lab in gitlab.
> > > >
> > > > Strongly disagree. Especially since having it in the mainline gitlab
> > > > isn't feasible.
> > > >
> > > > > > > Here I would like to make a case for moving to using Labgrid =
across
> > > > > > > the board, but unfortunately the project struggles to review =
PRs, so
> > > > > > > it's probably not a good idea.
> > > > > >
> > > > > > It would also be counter to the feedback from the U-Boot commun=
ity about
> > > > > > making it easier to contribute testing results from additional =
labs.
> > > > >
> > > > > I really don't think the test hooks are a good setup, though. It =
is
> > > > > OK-ish for small labs, but it is so fiddly to use that I wrote a =
tool
> > > > > (Labman) to deal with all the confusion.
> > > >
> > > > Yes, I don't know how hard you evaluated all of the then-current lab
> > > > management tooling and wrote your own.
> > > >
> > > > > Labgrid (which you suggested I use for my lab, if you recall),
> > > >
> > > > Yes, and I think you forgot the aim was to make it easy to show all=
 of
> > > > the existing Labgrid based labs that do Linux kernel testing they c=
ould
> > > > easily add U-Boot to the mix. I've been trying to get feedback from
> > > > other people with existing labgrid setups to look at what you've do=
ne.
> > > >
> > > > > provides for two yaml configuration files so that everything is i=
n one
> > > > > place. Apart from its primitive support for USB hubs, it is much
> > > > > easier to maintain that dozens of little files all over the palce.
> > > >
> > > > I mean, I looked at what you posted and strongly disagree, but I th=
ink
> > > > both cases here are personal preference and not some sort of object=
ive
> > > > and easily evaluated thing.
> > > >
> > > > > > > > > We need an 'all of the above' strategy here.
> > > > > > > >
> > > > > > > > Sure. But I still want to see things as reusable as possibl=
e. What you
> > > > > > > > have above is *extremely* board and OS specific and non-con=
figurable.
> > > > > > >
> > > > > > > Yes, agreed.
> > > > > > >
> > > > > > > > I
> > > > > > > > also don't quite see why it's not a test of autoboot with t=
he
> > > > > > > > pre-requisite of an OS being installed.
> > > > > > >
> > > > > > > Ah OK, my test is just for the installer itself. Both are use=
ful, but
> > > > > > > I hope eventually to have the installer run to completion and=
 then
> > > > > > > reboot to check all is well.
> > > > > >
> > > > > > In the spirit of "yes, and.."'ing tests, sure. Ilias pointed me=
 at some
> > > > > > testing Linaro has going now that automates I believe it was cu=
rrent
> > > > > > Yocto and current U-Boot (+ the pmb patches that've been posted=
) doing a
> > > > > > full install via network in CI. So yes, a Canonical lab might a=
lso find
> > > > > > it useful to end to end test installing Ubuntu. My own personal=
 dream is
> > > > > > that at least some of the existing kernelci labs see the utilit=
y in
> > > > > > adding "current U-Boot" as one of the matrix variables they tes=
t and not
> > > > > > just "U-Boot as delivered by vendor" as a static part of the te=
sting.
> > > > >
> > > > > OK.
> > > > >
> > > > > >
> > > > > > > > > BTW, having thought about how test/py works a bit, instea=
d of the
> > > > > > > > > env__net_tftp_bootable_file stuff, we should have code or=
 data which
> > > > > > > > > sets up the required test files (on a suitable server) be=
fore running
> > > > > > > > > the test. That way, all the test code is in one Python fi=
le and we
> > > > > > > > > don't have to spend ages trying to divine what each test =
needs.
> > > > > > > >
> > > > > > > > That seems like a lot more work than documenting more what =
we have
> > > > > > > > today, and I'm not sure of the benefit. Given the contents =
of the pxe
> > > > > > > > test, yes, just having those files available to 'cp' in pla=
ce would be
> > > > > > > > helpful. But that's not the case for booting a kernel (the =
FIT match
> > > > > > > > stuff doesn't work on the TI platforms atm). And if you loo=
k at the
> > > > > > > > config I posted it also includes bootstage configuration. I=
t also won't
> > > > > > > > work well for the SPI tests, which I'm talking with Love ab=
out in
> > > > > > > > another thread.
> > > > > > >
> > > > > > > Yes, perhaps, but having self-contained tests would be a win.
> > > > > >
> > > > > > With it's own set of technical and legal challenges / obligatio=
ns and
> > > > > > difficulties depending on what you even mean by "self contained=
". And
> > > > > > how often what's run where, and all sorts of other challenges t=
oo.
> > > > > >
> > > > > > Given the extreme depth that testing can go to, this is why I'm=
 of the
> > > > > > position that we need to document things more and worry less ab=
out
> > > > > > prepackaged things. For example, making the documentation for t=
he
> > > > > > current net based OS boot means that for bringing up a new boar=
d the
> > > > > > developer can just drop something in. Whereas if the tests expe=
ct a
> > > > > > functional OS image that has to also be messed with and is its =
own
> > > > > > challenge.
> > > > >
> > > > > Yes
> > > > >
> > > > > >
> > > > > > > > In other words, the majority of py/<host>/u_boot_boardenv_ =
content is
> > > > > > > > configuration details, specific to both the platform / SoC =
first, some
> > > > > > > > lab specific details second and drop-in existing 3rd party =
files a
> > > > > > > > distant third.
> > > > > > >
> > > > > > > I think the u-boot-test-hooks was an amazing solution 9 years=
 ago, but
> > > > > > > we have outgrown it. We want people to be able to connect the=
ir lab to
> > > > > > > CI (meaning gitlab), so testing is more automated.
> > > > > >
> > > > > > More and more public testing would be great. The notes I linked=
 above
> > > > > > explain one of the first problems there being that most compani=
es will
> > > > > > not or can not hook a lab to a public CI instance.
> > > > >
> > > > > Well corporate IT is what it is.
> > > > >
> > > > > That means that their boards will not be testing in CI, unless th=
ey do
> > > > > it themselves, right?
> > > >
> > > > I'm not sure what you mean here. It's a solved problem for them (mo=
nitor
> > > > tree at URL) and something that's been being done since the beginni=
ng
> > > > even for U-Boot (it's how the original nvidia lab worked).
> > > >
> > > > > > The next problem, as
> > > > > > both of our personal labs show, is that just maintaining the ph=
ysical
> > > > > > lab takes time and resources. I've added Heiko here because I'v=
e been
> > > > > > talking with him off-list about expanding tbot coverage and plu=
mbing
> > > > > > that in to gitlab.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > We should move away from relying on maintainers getting aroun=
d to
> > > > > > > testing patches months after they are sent, when they have ti=
me, but
> > > > > > > they don't. Things need to be more automated and I'd encourag=
e you to
> > > > > > > push this as well.
> > > > > >
> > > > > > I have been, and the results I've gotten are that companies are=
 testing
> > > > > > things internally but there's not any good way to publish resul=
ts, and
> > > > > > that's the kind of framework we're entirely missing.
> > > > >
> > > > > If you like, but from my side, I like to see the results in gitla=
b.
> > > >
> > > > Depends on what you mean by gitlab. I assume you mean "triggered by=
 a
> > > > push and visible in the main pipeline". Which isn't possible. It's =
not
> > > > going to happen. External collection is how it's handled for the li=
nux
> > > > kernel and that community has far more sway than we do. If we ride =
their
> > > > coattails here so to speak, we can get results. If we push for some=
thing
> > > > completely different we aren't likely to have success.
> > > >
> > > > > > Which is another part of why I keep pushing against having U-Bo=
ot
> > > > > > configuration stuff inside of Labgrid as it makes it harder for=
 any lab
> > > > > > that's not using labgrid to see how to configure things.
> > > > >
> > > > > Well, as you requested, I looked at Labgrid and now my lab uses i=
t. I
> > > > > am happy to publish the config[1], but I still hold my view that =
all
> > > > > the shell scripts in u-boot-test-hooks are limiting and painful to
> > > > > work with.
> > > >
> > > > Yes, and as I've shown, you can also use labgrid without going down=
 the
> > > > same path you took, and we can also support other lab management me=
thods
> > > > too, which is important to get as much testing as possible without
> > > > needing to centralize everything.
> > >
> > > In summary, I suppose we just have different visions and ideas, which
> > > should be a good thing.
> >
> > So long as the project can speak with one voice, yes. Which all circles
> > back to why I do not think what you're doing with u-boot.org is at all
> > helpful.
>=20
> I do need a relief valve for when my efforts are blocked.

And I do not see how using the project domain is appropriate. Stop doing
this. If you can't stop I'm going to reach my own limit here.

--=20
Tom

--bEEtfzSFWA3Cj52+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAnsEACgkQFHw5/5Y0
tyyJzwv/ftpZ13Nglngiw25lup1h1Aeh6NZRVPELunT1exGGDOKIlkZRzA5th2U0
RI0z1oMpbPPeUgrXrgtwkhpte5V2DmvPhh+6VD6pSKSIRg5CuAEREUDQCKbWjQCU
a/nGS9votq7KNd3So9XJVHIpGLHoBd4o8hwDxJRhA35KlVVkZsxTsB+9GYKtxnr0
cPH58ftLVtV3HK2pEbt2i6rtpIu6xrbrapWqBzqvz30+yZOZXOhPTiZVscKYs5p7
bht48PRTJJLVHUWJUoAE2gTu60fQp6IPvNHDTuSI5CIx3bGJ8rrgEa7gUfirlT3+
6vxxfAuc6FUBjec/vfwvoM+fW+FI+oGX9jLH2qAwWHS+xuI+7PAdUnItomsOvLLD
PvpLhFN4aHy7fmQmblt2q6brr2k9T6EPMkNwLE1cIr/mi5nrJnYDqrI7O54DxUam
a1+jrfAEiuWk0GmZYNvSPFs2OgE1Y80bqcQEmmdb/5haSNrXmIY/SRonOqBwDKMV
0CvbCFpS
=npPl
-----END PGP SIGNATURE-----

--bEEtfzSFWA3Cj52+--
