Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A624C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B14E5807EE;
	Wed, 26 Feb 2025 15:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUKLnRze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E2780F12; Wed, 26 Feb 2025 15:35:49 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09168805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6e1b11859a7so30173056d6.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740580545; x=1741185345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J3a+J913dyOfGIhP6FXf2rfGQzEC9RFayNM1JEcG1EM=;
 b=nUKLnRze/EXiqUywl0hgHZ81NFKOhMPeiGQY5R3VdGk4DPp+aUnRD6jmYR/426hymS
 O6M5cNmazLpmo2+5HggdmO0LPrwCr9zeC/YVznYXApDGM6t19yxwJkzrZDJcalgexyCe
 sVH+QoqKaY15P5uYWE5+vDXEqrW4lTCqNOoHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740580545; x=1741185345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3a+J913dyOfGIhP6FXf2rfGQzEC9RFayNM1JEcG1EM=;
 b=hYKme9m803QAhxf2TtBUbUrgIw8fNua6JC9x2NxXtC6Cfzg9+H8BL68ysQeVf8I/HR
 E2Ld/OAdlYqPffLOwyjF5piO+GdRxy14KftF+pnZ67mgeNMLUmMvNY7c9tSuueJ879SP
 XEwEIj3iy/x2nWYGck+p5qW6//eN+og4YrFgQ6I7I/yNfj+VBNaGwL0kMv8433ubI3Ie
 d17Y3Sfy+I8blBktPZVysnOhDC6JKAh1HaVd+opMNGU3SjuzdAz7VbxnbkvhNF8zkDgC
 DkChxYlfU+jlRLzuP5FREvMu2cFCRIFkM800kdkrdpBMT6UFGjIzpcaAmP/dApoLFtXo
 XeOA==
X-Gm-Message-State: AOJu0YzZM3wdX0/Ck9JO02sNCgHJS6Kr6WptsLCejc+QHgF0VWTcVo67
 c0op2QdxyRGnKrgacCsrtCfSPNDd1F3Ss6y/e4eMIe7gRevCgd5NBzjwhMcl9is=
X-Gm-Gg: ASbGncs6xzCBrBbMMWUMZEWNDjW0worQ7ES/vR6FWZpMUefSiMfdCBzqRYKlYZkZdyn
 GU3PF0iHy78VRZ8i+xmYI48f5mgbT4qKApdwkUG6QF1HBuOmEY1uYTtnbZ72PtEE15Eok/7vUv3
 XysIh3J0RlyujcuIL5uFXkjmQG0r0413BUXhrkLQVXNibYCYjQgmIA/WDvbYbYbksla/zgeFsnW
 iC1dPrMJFUFNUptul0Vs6z4y/YK+vSoPkv8/ma7RCdBdvmNXbxuFcSFmHbUzjc/qJ7n8grK8QHK
 WXTh8ia1iPTvx/sdvMYI/hvi
X-Google-Smtp-Source: AGHT+IG0P+dU9S+gR4ETdNUqRA//xUB+3jE9XHpeHo6bKhjdqxlb7DP3aTf9eWb6Y5DB7ENX5QUrFg==
X-Received: by 2002:a05:6214:262d:b0:6e6:6b03:2b34 with SMTP id
 6a1803df08f44-6e88689ac5dmr50400846d6.27.1740580544611; 
 Wed, 26 Feb 2025 06:35:44 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e88fd92859sm4627456d6.13.2025.02.26.06.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:35:43 -0800 (PST)
Date: Wed, 26 Feb 2025 08:35:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250226143541.GI2640854@bill-the-cat>
References: <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M2Xj4VmlF6Bdhz4w"
Content-Disposition: inline
In-Reply-To: <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
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


--M2Xj4VmlF6Bdhz4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Now that U-Boot can boot this quickly, using kvm,=
 add a test that the
> > > > > > > > > > > > > installer starts up correctly.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > - Add more patches to support booting with kvm
> > > > > > > > > > > > > - Add new patch with a test for booting Ubuntu 24=
=2E04
> > > > > > > > > > > > >
> > > > > > > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++=
++++++++++++++++++++++
> > > > > > > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > > > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > > > > > > >    variables:
> > > > > > > > > > > > >      ROLE: zybo
> > > > > > > > > > > > >    <<: *lab_dfn
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +qemu-x86_64:
> > > > > > > > > > > > > +  variables:
> > > > > > > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > > > > > > +  <<: *lab_dfn
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not sure why this is in your lab stanza, rather=
 than the normal
> > > > > > > > > > > > test.py QEMU stanza.
> > > > > > > > > > >
> > > > > > > > > > > Are you wanting to add the Ubuntu image into CI? It i=
s quite large.
> > > > > > > > > >
> > > > > > > > > > If we're going to be able to run it on N platforms, yes=
, we need to
> > > > > > > > > > think of a good way to cache the download. There's not =
a particular
> > > > > > > > > > reason we can't run the stock Ubuntu RISC-V image on th=
e two sifive
> > > > > > > > > > targets and also qemu-riscv64, is there?
> > > > > > > > >
> > > > > > > > > Yes, we can do that. It is pretty simple to set up in Lab=
grid and it
> > > > > > > > > doesn't require all the runners to download a much larger=
 image, etc.
> > > > > > > >
> > > > > > > > I don't quite understand why it's under "labgrid". These ar=
e generic CI
> > > > > > > > tests. Now maybe we need to, in both Gitlab and Azure, add =
some logic so
> > > > > > > > that certain longer or possibly destructive tests are only =
run on tagged
> > > > > > > > releases or as requested rather than every time, as it will=
 take longer.
> > > > > > > > But pretty much every platform under the qemu target list s=
hould be able
> > > > > > > > to Just Boot an off the shelf OS distribution is my point.
> > > > > > >
> > > > > > > Sure, and I'm not suggesting we shouldn't do that as well.
> > > > > > >
> > > > > > > >
> > > > > > > > > > > > > diff --git a/test/py/tests/test_distro.py b/test/=
py/tests/test_distro.py
> > > > > > > > > > > > > new file mode 100644
> > > > > > > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > > > > > > +# Written by Simon Glass <simon.glass@canonical.=
com>
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +import pytest
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +# Enable early console so that the test can see =
if something goes wrong
> > > > > > > > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 consol=
e=3Duart8250,io,0x3f8'
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > > > > > > +def test_distro(ubman):
> > > > > > > > > > > > > +    """Test that of-platdata can be generated an=
d used in sandbox"""
> > > > > > > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > > > > > > +        ubman.run_command('boot', wait_for_promp=
t=3DFalse)
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > > > > > > +        # Wait for grub to come up and offset a =
menu
> > > > > > > > > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Press 'e' to edit the command line
> > > > > > > > > > > > > +        ubman.run_command('e', wait_for_prompt=
=3DFalse, send_nl=3DFalse)
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Wait until we see the editor appear
> > > > > > > > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Go to end of line
> > > > > > > > > > > > > +        ubman.ctrl('E')
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > > > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Send our noisy console
> > > > > > > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        # Tell grub to boot
> > > > > > > > > > > > > +        ubman.ctrl('X')
> > > > > > > > > > > > > +        ubman.p.expect(['Booting a command list'=
])
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > > > > > > +        # Linux should start immediately
> > > > > > > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > > > > > > +        # Shortly later, we should see this bann=
er
> > > > > > > > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.=
04.1 LTS.*!'])
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    ubman.restart_uboot()
> > > > > > > > > > > >
> > > > > > > > > > > > And this seems very inflexible. Please see
> > > > > > > > > > > > test/py/tests/test_net_boot.py for an example of ho=
w to have this be
> > > > > > > > > > > > configurable and work on arbitrary platforms. What =
I assume is tricky is
> > > > > > > > > > > > that the "role" part here is where you have a speci=
al disk image being
> > > > > > > > > > > > passed. That too could be dealt with in u-boot-test=
-hooks in a few ways,
> > > > > > > > > > > > and the images pre-fetched to the CI container. And=
 if this was
> > > > > > > > > > > > configurable similar to the example I noted above, =
it could check real
> > > > > > > > > > > > hardware too.
> > > > > > > > > > >
> > > > > > > > > > > That wasn't the reaction I expected.
> > > > > > > > > > >
> > > > > > > > > > > Yes, it is inflexible, but it is a starting point. Is=
n't it better
> > > > > > > > > > > than what we have today?
> > > > > > > > > >
> > > > > > > > > > Is your inflexible boot an OS test better than the flex=
ible boot an OS
> > > > > > > > > > test that we have today? No, it's not.
> > > > > > > > >
> > > > > > > > > I didn't even know about it, or perhaps I forgot.
> > > > > > > >
> > > > > > > > I believe I mentioned it every time you've said we should h=
ave an OS
> > > > > > > > test, so yes, I guess you forgot.
> > > > > > >
> > > > > > > Well it was only added in May last year and it relies on boar=
d config
> > > > > > > which I don't have...although I see that you have now posted =
yours.
> > > > > >
> > > > > > Yes, it was added not quite a year ago, and is documented withi=
n the
> > > > > > test, like most tests that rely on the real platform.
> > > > > >
> > > > > > And do we need better documentation for test? Yes.
> > > > >
> > > > > +1
> > > > >
> > > > > I'll note that I did my bit!
> > > > >
> > > > > >
> > > > > > > > > Perhaps this relates to getting the labgrid config publis=
hed and
> > > > > > > > > figuring out how to pass info from Labgrid to tests.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > I would like to generalise this test to work on at le=
ast one real
> > > > > > > > > > > board, preferably one that doesn't use grub.
> > > > > > > > > >
> > > > > > > > > > OK. The test we have today does that, if you check for =
the "Welcome to
> > > > > > > > > > ..." string instead of the kernel has booted string. It=
 also does
> > > > > > > > > > netboot rather than run default bootcmd. But that's an =
easy enough test
> > > > > > > > > > to write up. The only thing stopping me from doing that=
 right now is I
> > > > > > > > > > need to find a board in the lab where we installed an O=
S to eMMC and not
> > > > > > > > > > SD card (some lab sd-mux issues).
> > > > > > > > >
> > > > > > > > > OK. Labgrid has a 'features' thing which you can attach t=
o targets, so
> > > > > > > > > I should be able to use that to indicate that Ubuntu, Deb=
ian, Armbian,
> > > > > > > > > etc. are available.
> > > > > > > >
> > > > > > > > OK, but that sounds like the opposite direction. These are =
generic tests
> > > > > > > > that can run in any / all of the labs, not just your labgrid
> > > > > > > > configuration. AMD has been contributing tests that run on =
hardware for
> > > > > > > > example.
> > > > > > >
> > > > > > > That's great, the more tests we have the better. But those te=
sts can't
> > > > > > > and don't run in CI, whereas mine can and do.
> > > > > >
> > > > > > AFAICT they're running on AMD's CI. They run on my CI. They don=
't run on
> > > > > > *your* lab because you took things, intentionally, in a directi=
on to
> > > > > > minimize using u-boot-test-hooks and our existing per-board
> > > > > > configuration infrastructure.
> > > > >
> > > > > When I look at CI all I see is my lab. Which CI are you referring=
 to
> > > > > and how can I access it?
> > > >
> > > > I'll point you at the notes for the first call we had recently:
> > > > https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-ca=
t/
> > > > and note that there are many labs doing testing on / with U-Boot.
> > >
> > > That's all good, but it isn't as good as having the lab in gitlab.
> >
> > Strongly disagree. Especially since having it in the mainline gitlab
> > isn't feasible.
> >
> > > > > Here I would like to make a case for moving to using Labgrid acro=
ss
> > > > > the board, but unfortunately the project struggles to review PRs,=
 so
> > > > > it's probably not a good idea.
> > > >
> > > > It would also be counter to the feedback from the U-Boot community =
about
> > > > making it easier to contribute testing results from additional labs.
> > >
> > > I really don't think the test hooks are a good setup, though. It is
> > > OK-ish for small labs, but it is so fiddly to use that I wrote a tool
> > > (Labman) to deal with all the confusion.
> >
> > Yes, I don't know how hard you evaluated all of the then-current lab
> > management tooling and wrote your own.
> >
> > > Labgrid (which you suggested I use for my lab, if you recall),
> >
> > Yes, and I think you forgot the aim was to make it easy to show all of
> > the existing Labgrid based labs that do Linux kernel testing they could
> > easily add U-Boot to the mix. I've been trying to get feedback from
> > other people with existing labgrid setups to look at what you've done.
> >
> > > provides for two yaml configuration files so that everything is in one
> > > place. Apart from its primitive support for USB hubs, it is much
> > > easier to maintain that dozens of little files all over the palce.
> >
> > I mean, I looked at what you posted and strongly disagree, but I think
> > both cases here are personal preference and not some sort of objective
> > and easily evaluated thing.
> >
> > > > > > > We need an 'all of the above' strategy here.
> > > > > >
> > > > > > Sure. But I still want to see things as reusable as possible. W=
hat you
> > > > > > have above is *extremely* board and OS specific and non-configu=
rable.
> > > > >
> > > > > Yes, agreed.
> > > > >
> > > > > > I
> > > > > > also don't quite see why it's not a test of autoboot with the
> > > > > > pre-requisite of an OS being installed.
> > > > >
> > > > > Ah OK, my test is just for the installer itself. Both are useful,=
 but
> > > > > I hope eventually to have the installer run to completion and then
> > > > > reboot to check all is well.
> > > >
> > > > In the spirit of "yes, and.."'ing tests, sure. Ilias pointed me at =
some
> > > > testing Linaro has going now that automates I believe it was current
> > > > Yocto and current U-Boot (+ the pmb patches that've been posted) do=
ing a
> > > > full install via network in CI. So yes, a Canonical lab might also =
find
> > > > it useful to end to end test installing Ubuntu. My own personal dre=
am is
> > > > that at least some of the existing kernelci labs see the utility in
> > > > adding "current U-Boot" as one of the matrix variables they test an=
d not
> > > > just "U-Boot as delivered by vendor" as a static part of the testin=
g.
> > >
> > > OK.
> > >
> > > >
> > > > > > > BTW, having thought about how test/py works a bit, instead of=
 the
> > > > > > > env__net_tftp_bootable_file stuff, we should have code or dat=
a which
> > > > > > > sets up the required test files (on a suitable server) before=
 running
> > > > > > > the test. That way, all the test code is in one Python file a=
nd we
> > > > > > > don't have to spend ages trying to divine what each test need=
s.
> > > > > >
> > > > > > That seems like a lot more work than documenting more what we h=
ave
> > > > > > today, and I'm not sure of the benefit. Given the contents of t=
he pxe
> > > > > > test, yes, just having those files available to 'cp' in place w=
ould be
> > > > > > helpful. But that's not the case for booting a kernel (the FIT =
match
> > > > > > stuff doesn't work on the TI platforms atm). And if you look at=
 the
> > > > > > config I posted it also includes bootstage configuration. It al=
so won't
> > > > > > work well for the SPI tests, which I'm talking with Love about =
in
> > > > > > another thread.
> > > > >
> > > > > Yes, perhaps, but having self-contained tests would be a win.
> > > >
> > > > With it's own set of technical and legal challenges / obligations a=
nd
> > > > difficulties depending on what you even mean by "self contained". A=
nd
> > > > how often what's run where, and all sorts of other challenges too.
> > > >
> > > > Given the extreme depth that testing can go to, this is why I'm of =
the
> > > > position that we need to document things more and worry less about
> > > > prepackaged things. For example, making the documentation for the
> > > > current net based OS boot means that for bringing up a new board the
> > > > developer can just drop something in. Whereas if the tests expect a
> > > > functional OS image that has to also be messed with and is its own
> > > > challenge.
> > >
> > > Yes
> > >
> > > >
> > > > > > In other words, the majority of py/<host>/u_boot_boardenv_ cont=
ent is
> > > > > > configuration details, specific to both the platform / SoC firs=
t, some
> > > > > > lab specific details second and drop-in existing 3rd party file=
s a
> > > > > > distant third.
> > > > >
> > > > > I think the u-boot-test-hooks was an amazing solution 9 years ago=
, but
> > > > > we have outgrown it. We want people to be able to connect their l=
ab to
> > > > > CI (meaning gitlab), so testing is more automated.
> > > >
> > > > More and more public testing would be great. The notes I linked abo=
ve
> > > > explain one of the first problems there being that most companies w=
ill
> > > > not or can not hook a lab to a public CI instance.
> > >
> > > Well corporate IT is what it is.
> > >
> > > That means that their boards will not be testing in CI, unless they do
> > > it themselves, right?
> >
> > I'm not sure what you mean here. It's a solved problem for them (monitor
> > tree at URL) and something that's been being done since the beginning
> > even for U-Boot (it's how the original nvidia lab worked).
> >
> > > > The next problem, as
> > > > both of our personal labs show, is that just maintaining the physic=
al
> > > > lab takes time and resources. I've added Heiko here because I've be=
en
> > > > talking with him off-list about expanding tbot coverage and plumbing
> > > > that in to gitlab.
> > >
> > > OK
> > >
> > > >
> > > > > We should move away from relying on maintainers getting around to
> > > > > testing patches months after they are sent, when they have time, =
but
> > > > > they don't. Things need to be more automated and I'd encourage yo=
u to
> > > > > push this as well.
> > > >
> > > > I have been, and the results I've gotten are that companies are tes=
ting
> > > > things internally but there's not any good way to publish results, =
and
> > > > that's the kind of framework we're entirely missing.
> > >
> > > If you like, but from my side, I like to see the results in gitlab.
> >
> > Depends on what you mean by gitlab. I assume you mean "triggered by a
> > push and visible in the main pipeline". Which isn't possible. It's not
> > going to happen. External collection is how it's handled for the linux
> > kernel and that community has far more sway than we do. If we ride their
> > coattails here so to speak, we can get results. If we push for something
> > completely different we aren't likely to have success.
> >
> > > > Which is another part of why I keep pushing against having U-Boot
> > > > configuration stuff inside of Labgrid as it makes it harder for any=
 lab
> > > > that's not using labgrid to see how to configure things.
> > >
> > > Well, as you requested, I looked at Labgrid and now my lab uses it. I
> > > am happy to publish the config[1], but I still hold my view that all
> > > the shell scripts in u-boot-test-hooks are limiting and painful to
> > > work with.
> >
> > Yes, and as I've shown, you can also use labgrid without going down the
> > same path you took, and we can also support other lab management methods
> > too, which is important to get as much testing as possible without
> > needing to centralize everything.
>=20
> In summary, I suppose we just have different visions and ideas, which
> should be a good thing.

So long as the project can speak with one voice, yes. Which all circles
back to why I do not think what you're doing with u-boot.org is at all
helpful.

--=20
Tom

--M2Xj4VmlF6Bdhz4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/JrEACgkQFHw5/5Y0
tywvVQwAgexu88DFDr2xlwt2HEdzTgB7jsMR1HfP1yVZ+2jB6rXdhU8K6is1SGhY
MovKAly2K1MWG3aPUlTb+MoLHh0Xy1o/SsdJjXu+dDw7rAPYr3nIRaBofZhwqfmp
EaFe7TtSPm/J6cC57cYe9FuAZuhUz+QmKVcnj65HhMQO2UEY4HaKmxYQDqhYdYhy
51XDA3rGa932jY/FTw/xArovm4FK7sJAqA2e6uzh2jUyEcvcoFF7BCxAEG9EjvJn
ZuF5z2X7eSIKoLaaH58ufd53rJQS3f1Ki1gspBl16op6NwNBscEWOkZnoTS9Ehl5
LdyVBVSq/ugeQrdlFeYu9i9w0buVlVyaBEE37H0FBDsFdyS1+sX6CNRTe7iOEhWZ
BESKc8FUB8hh4Hf491W9YYPKTm66PUSAc5K5cZbB1TWTUgakKtnhitYXjSMle2wH
wv14kLokRUT8hUUPvtKZ7tmBjHdJEmY0sePNcV9yhRBrqSZU0nuXzPrDsR2kPZjh
qss844hK
=LMMz
-----END PGP SIGNATURE-----

--M2Xj4VmlF6Bdhz4w--
