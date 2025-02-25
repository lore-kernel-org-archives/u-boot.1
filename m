Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0EC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412C880F92;
	Tue, 25 Feb 2025 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W1rrDHiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF3B80FAA; Tue, 25 Feb 2025 14:59:30 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA746807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4be633cacbbso1460255137.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740491966; x=1741096766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O0judhbHaFNfccWLTCegnqYPipuUIn+7Xc2CdI6GOHI=;
 b=W1rrDHiCTzWIrRPu3Un24XFynUcg1SmlMdZcd3FqhXg+kGWy5AfBFPOsJuMeKcZ0EH
 AVVFi+23gFQISf8OkmaZTNOpwcF3BiaWGlAZEx2Ap696q3nj+6QVY8T7JsrbayPMUR9h
 AtI3l7vDNOGNL8+qF3tN/WT8ODR8vwdu2GbAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740491966; x=1741096766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0judhbHaFNfccWLTCegnqYPipuUIn+7Xc2CdI6GOHI=;
 b=NG7oyIqb99Hh6G/IB+jbNDoS4KGnKka6wtF/M/n9voMUoc4S8KFw9jpdcUe0VvU0Sh
 cpbV4PlZZemJ9TY76qnH+HqEk42d6RbeaXJy/RFvbdt2ka/vDZj60D1PToio8NjyDBz9
 ea3PFPADW2y3OOE7t+5O+VtgFnNhJMhcbT+tvmfLGlPlEd9AxzJaKbp4lUpSTxbQNoSV
 Q8IffXYfwJrG9D+d7oS5JQxE7vuQyCz50U7smm0wc+ARZFZl6S4mI2LRr2mhkO3Hv402
 SVRrdiOBI3Vw0IJCmoJcl7u0i3CzGCfwJ4xUxD+zuFxxIACB1o7Tl2sNXgWCVTRaT+n/
 7qXA==
X-Gm-Message-State: AOJu0YyOvszQrf6ImBYH1aluCP69oHXsA4Oc7v0x3PGB066ROUGNGZYO
 h19ZejLymX64m1PVLxddIJXFXpj9+Hq0YhZg9fag33zvQ6v32RDtNLbmZ00UZXk=
X-Gm-Gg: ASbGncubHeVBbe/gHqED1DLoBZblpF2I8KN7SwCM589ENONqcbHDVJAFvaNHiaIH1au
 IKchZ82Li1tTvWH6vTCG8Z10n1b9oYHYTU54L3bErlnEaxv+OZXo6qs6jn+7g8+pMNggfA/LYye
 p7H+LmbHtAWDMBwSVACX7RIvIEEGm1xN8F6oN++ujXKoHEkBWZci5Ty9jjyMvmtTfJsnKtwgzKM
 UoMSVYCWbfO/srYvktgfY2bMqN3pQU/txXTpR92NkVhelfc4xxHKwgmRgAN80RqMn9o6owiXlMZ
 2ojgpg3B9FV5glaPYPx9da0C
X-Google-Smtp-Source: AGHT+IH6LvPtiYVFFqJmBXK3aeYrYLOHmX1SWny2EUyxpJTj2+joAiNXzlM/jWVi8VNTQK1ewQiYIQ==
X-Received: by 2002:a05:6102:4bce:b0:4ba:eb24:fb02 with SMTP id
 ada2fe7eead31-4bfc0030943mr10543454137.3.1740491966368; 
 Tue, 25 Feb 2025 05:59:26 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ef246a5sm319377241.30.2025.02.25.05.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 05:59:25 -0800 (PST)
Date: Tue, 25 Feb 2025 07:59:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250225135922.GL1233568@bill-the-cat>
References: <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xU5V4O2xoYaEtTkk"
Content-Disposition: inline
In-Reply-To: <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
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


--xU5V4O2xoYaEtTkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Now that U-Boot can boot this quickly, using kvm, add=
 a test that the
> > > > > > > > > > > installer starts up correctly.
> > > > > > > > > > >
> > > > > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > ---
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - Add more patches to support booting with kvm
> > > > > > > > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > > > > > > > >
> > > > > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++=
++++++++++++++++++
> > > > > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > > > > >    variables:
> > > > > > > > > > >      ROLE: zybo
> > > > > > > > > > >    <<: *lab_dfn
> > > > > > > > > > > +
> > > > > > > > > > > +qemu-x86_64:
> > > > > > > > > > > +  variables:
> > > > > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > > > > +  <<: *lab_dfn
> > > > > > > > > >
> > > > > > > > > > I'm not sure why this is in your lab stanza, rather tha=
n the normal
> > > > > > > > > > test.py QEMU stanza.
> > > > > > > > >
> > > > > > > > > Are you wanting to add the Ubuntu image into CI? It is qu=
ite large.
> > > > > > > >
> > > > > > > > If we're going to be able to run it on N platforms, yes, we=
 need to
> > > > > > > > think of a good way to cache the download. There's not a pa=
rticular
> > > > > > > > reason we can't run the stock Ubuntu RISC-V image on the tw=
o sifive
> > > > > > > > targets and also qemu-riscv64, is there?
> > > > > > >
> > > > > > > Yes, we can do that. It is pretty simple to set up in Labgrid=
 and it
> > > > > > > doesn't require all the runners to download a much larger ima=
ge, etc.
> > > > > >
> > > > > > I don't quite understand why it's under "labgrid". These are ge=
neric CI
> > > > > > tests. Now maybe we need to, in both Gitlab and Azure, add some=
 logic so
> > > > > > that certain longer or possibly destructive tests are only run =
on tagged
> > > > > > releases or as requested rather than every time, as it will tak=
e longer.
> > > > > > But pretty much every platform under the qemu target list shoul=
d be able
> > > > > > to Just Boot an off the shelf OS distribution is my point.
> > > > >
> > > > > Sure, and I'm not suggesting we shouldn't do that as well.
> > > > >
> > > > > >
> > > > > > > > > > > diff --git a/test/py/tests/test_distro.py b/test/py/t=
ests/test_distro.py
> > > > > > > > > > > new file mode 100644
> > > > > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > > > > --- /dev/null
> > > > > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > > > > > > > +
> > > > > > > > > > > +import pytest
> > > > > > > > > > > +
> > > > > > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > > > > > +
> > > > > > > > > > > +# Enable early console so that the test can see if s=
omething goes wrong
> > > > > > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3D=
uart8250,io,0x3f8'
> > > > > > > > > > > +
> > > > > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > > > > +def test_distro(ubman):
> > > > > > > > > > > +    """Test that of-platdata can be generated and us=
ed in sandbox"""
> > > > > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > > > > +        ubman.run_command('boot', wait_for_prompt=3D=
False)
> > > > > > > > > > > +
> > > > > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > > > > +        # Wait for grub to come up and offset a menu
> > > > > > > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > > > > > > +
> > > > > > > > > > > +        # Press 'e' to edit the command line
> > > > > > > > > > > +        ubman.run_command('e', wait_for_prompt=3DFal=
se, send_nl=3DFalse)
> > > > > > > > > > > +
> > > > > > > > > > > +        # Wait until we see the editor appear
> > > > > > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > > > > > +
> > > > > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > > > > +
> > > > > > > > > > > +        # Go to end of line
> > > > > > > > > > > +        ubman.ctrl('E')
> > > > > > > > > > > +
> > > > > > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > > > > > > +
> > > > > > > > > > > +        # Send our noisy console
> > > > > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > > > > +
> > > > > > > > > > > +        # Tell grub to boot
> > > > > > > > > > > +        ubman.ctrl('X')
> > > > > > > > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > > > > > > > +
> > > > > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > > > > +        # Linux should start immediately
> > > > > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > > > > +
> > > > > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > > > > +        # Shortly later, we should see this banner
> > > > > > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1=
 LTS.*!'])
> > > > > > > > > > > +
> > > > > > > > > > > +    ubman.restart_uboot()
> > > > > > > > > >
> > > > > > > > > > And this seems very inflexible. Please see
> > > > > > > > > > test/py/tests/test_net_boot.py for an example of how to=
 have this be
> > > > > > > > > > configurable and work on arbitrary platforms. What I as=
sume is tricky is
> > > > > > > > > > that the "role" part here is where you have a special d=
isk image being
> > > > > > > > > > passed. That too could be dealt with in u-boot-test-hoo=
ks in a few ways,
> > > > > > > > > > and the images pre-fetched to the CI container. And if =
this was
> > > > > > > > > > configurable similar to the example I noted above, it c=
ould check real
> > > > > > > > > > hardware too.
> > > > > > > > >
> > > > > > > > > That wasn't the reaction I expected.
> > > > > > > > >
> > > > > > > > > Yes, it is inflexible, but it is a starting point. Isn't =
it better
> > > > > > > > > than what we have today?
> > > > > > > >
> > > > > > > > Is your inflexible boot an OS test better than the flexible=
 boot an OS
> > > > > > > > test that we have today? No, it's not.
> > > > > > >
> > > > > > > I didn't even know about it, or perhaps I forgot.
> > > > > >
> > > > > > I believe I mentioned it every time you've said we should have =
an OS
> > > > > > test, so yes, I guess you forgot.
> > > > >
> > > > > Well it was only added in May last year and it relies on board co=
nfig
> > > > > which I don't have...although I see that you have now posted your=
s.
> > > >
> > > > Yes, it was added not quite a year ago, and is documented within the
> > > > test, like most tests that rely on the real platform.
> > > >
> > > > And do we need better documentation for test? Yes.
> > >
> > > +1
> > >
> > > I'll note that I did my bit!
> > >
> > > >
> > > > > > > Perhaps this relates to getting the labgrid config published =
and
> > > > > > > figuring out how to pass info from Labgrid to tests.
> > > > > > >
> > > > > > > >
> > > > > > > > > I would like to generalise this test to work on at least =
one real
> > > > > > > > > board, preferably one that doesn't use grub.
> > > > > > > >
> > > > > > > > OK. The test we have today does that, if you check for the =
"Welcome to
> > > > > > > > ..." string instead of the kernel has booted string. It als=
o does
> > > > > > > > netboot rather than run default bootcmd. But that's an easy=
 enough test
> > > > > > > > to write up. The only thing stopping me from doing that rig=
ht now is I
> > > > > > > > need to find a board in the lab where we installed an OS to=
 eMMC and not
> > > > > > > > SD card (some lab sd-mux issues).
> > > > > > >
> > > > > > > OK. Labgrid has a 'features' thing which you can attach to ta=
rgets, so
> > > > > > > I should be able to use that to indicate that Ubuntu, Debian,=
 Armbian,
> > > > > > > etc. are available.
> > > > > >
> > > > > > OK, but that sounds like the opposite direction. These are gene=
ric tests
> > > > > > that can run in any / all of the labs, not just your labgrid
> > > > > > configuration. AMD has been contributing tests that run on hard=
ware for
> > > > > > example.
> > > > >
> > > > > That's great, the more tests we have the better. But those tests =
can't
> > > > > and don't run in CI, whereas mine can and do.
> > > >
> > > > AFAICT they're running on AMD's CI. They run on my CI. They don't r=
un on
> > > > *your* lab because you took things, intentionally, in a direction to
> > > > minimize using u-boot-test-hooks and our existing per-board
> > > > configuration infrastructure.
> > >
> > > When I look at CI all I see is my lab. Which CI are you referring to
> > > and how can I access it?
> >
> > I'll point you at the notes for the first call we had recently:
> > https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-cat/
> > and note that there are many labs doing testing on / with U-Boot.
>=20
> That's all good, but it isn't as good as having the lab in gitlab.

Strongly disagree. Especially since having it in the mainline gitlab
isn't feasible.

> > > Here I would like to make a case for moving to using Labgrid across
> > > the board, but unfortunately the project struggles to review PRs, so
> > > it's probably not a good idea.
> >
> > It would also be counter to the feedback from the U-Boot community about
> > making it easier to contribute testing results from additional labs.
>=20
> I really don't think the test hooks are a good setup, though. It is
> OK-ish for small labs, but it is so fiddly to use that I wrote a tool
> (Labman) to deal with all the confusion.

Yes, I don't know how hard you evaluated all of the then-current lab
management tooling and wrote your own.

> Labgrid (which you suggested I use for my lab, if you recall),

Yes, and I think you forgot the aim was to make it easy to show all of
the existing Labgrid based labs that do Linux kernel testing they could
easily add U-Boot to the mix. I've been trying to get feedback from
other people with existing labgrid setups to look at what you've done.

> provides for two yaml configuration files so that everything is in one
> place. Apart from its primitive support for USB hubs, it is much
> easier to maintain that dozens of little files all over the palce.

I mean, I looked at what you posted and strongly disagree, but I think
both cases here are personal preference and not some sort of objective
and easily evaluated thing.

> > > > > We need an 'all of the above' strategy here.
> > > >
> > > > Sure. But I still want to see things as reusable as possible. What =
you
> > > > have above is *extremely* board and OS specific and non-configurabl=
e.
> > >
> > > Yes, agreed.
> > >
> > > > I
> > > > also don't quite see why it's not a test of autoboot with the
> > > > pre-requisite of an OS being installed.
> > >
> > > Ah OK, my test is just for the installer itself. Both are useful, but
> > > I hope eventually to have the installer run to completion and then
> > > reboot to check all is well.
> >
> > In the spirit of "yes, and.."'ing tests, sure. Ilias pointed me at some
> > testing Linaro has going now that automates I believe it was current
> > Yocto and current U-Boot (+ the pmb patches that've been posted) doing a
> > full install via network in CI. So yes, a Canonical lab might also find
> > it useful to end to end test installing Ubuntu. My own personal dream is
> > that at least some of the existing kernelci labs see the utility in
> > adding "current U-Boot" as one of the matrix variables they test and not
> > just "U-Boot as delivered by vendor" as a static part of the testing.
>=20
> OK.
>=20
> >
> > > > > BTW, having thought about how test/py works a bit, instead of the
> > > > > env__net_tftp_bootable_file stuff, we should have code or data wh=
ich
> > > > > sets up the required test files (on a suitable server) before run=
ning
> > > > > the test. That way, all the test code is in one Python file and we
> > > > > don't have to spend ages trying to divine what each test needs.
> > > >
> > > > That seems like a lot more work than documenting more what we have
> > > > today, and I'm not sure of the benefit. Given the contents of the p=
xe
> > > > test, yes, just having those files available to 'cp' in place would=
 be
> > > > helpful. But that's not the case for booting a kernel (the FIT match
> > > > stuff doesn't work on the TI platforms atm). And if you look at the
> > > > config I posted it also includes bootstage configuration. It also w=
on't
> > > > work well for the SPI tests, which I'm talking with Love about in
> > > > another thread.
> > >
> > > Yes, perhaps, but having self-contained tests would be a win.
> >
> > With it's own set of technical and legal challenges / obligations and
> > difficulties depending on what you even mean by "self contained". And
> > how often what's run where, and all sorts of other challenges too.
> >
> > Given the extreme depth that testing can go to, this is why I'm of the
> > position that we need to document things more and worry less about
> > prepackaged things. For example, making the documentation for the
> > current net based OS boot means that for bringing up a new board the
> > developer can just drop something in. Whereas if the tests expect a
> > functional OS image that has to also be messed with and is its own
> > challenge.
>=20
> Yes
>=20
> >
> > > > In other words, the majority of py/<host>/u_boot_boardenv_ content =
is
> > > > configuration details, specific to both the platform / SoC first, s=
ome
> > > > lab specific details second and drop-in existing 3rd party files a
> > > > distant third.
> > >
> > > I think the u-boot-test-hooks was an amazing solution 9 years ago, but
> > > we have outgrown it. We want people to be able to connect their lab to
> > > CI (meaning gitlab), so testing is more automated.
> >
> > More and more public testing would be great. The notes I linked above
> > explain one of the first problems there being that most companies will
> > not or can not hook a lab to a public CI instance.
>=20
> Well corporate IT is what it is.
>=20
> That means that their boards will not be testing in CI, unless they do
> it themselves, right?

I'm not sure what you mean here. It's a solved problem for them (monitor
tree at URL) and something that's been being done since the beginning
even for U-Boot (it's how the original nvidia lab worked).

> > The next problem, as
> > both of our personal labs show, is that just maintaining the physical
> > lab takes time and resources. I've added Heiko here because I've been
> > talking with him off-list about expanding tbot coverage and plumbing
> > that in to gitlab.
>=20
> OK
>=20
> >
> > > We should move away from relying on maintainers getting around to
> > > testing patches months after they are sent, when they have time, but
> > > they don't. Things need to be more automated and I'd encourage you to
> > > push this as well.
> >
> > I have been, and the results I've gotten are that companies are testing
> > things internally but there's not any good way to publish results, and
> > that's the kind of framework we're entirely missing.
>=20
> If you like, but from my side, I like to see the results in gitlab.

Depends on what you mean by gitlab. I assume you mean "triggered by a
push and visible in the main pipeline". Which isn't possible. It's not
going to happen. External collection is how it's handled for the linux
kernel and that community has far more sway than we do. If we ride their
coattails here so to speak, we can get results. If we push for something
completely different we aren't likely to have success.

> > Which is another part of why I keep pushing against having U-Boot
> > configuration stuff inside of Labgrid as it makes it harder for any lab
> > that's not using labgrid to see how to configure things.
>=20
> Well, as you requested, I looked at Labgrid and now my lab uses it. I
> am happy to publish the config[1], but I still hold my view that all
> the shell scripts in u-boot-test-hooks are limiting and painful to
> work with.

Yes, and as I've shown, you can also use labgrid without going down the
same path you took, and we can also support other lab management methods
too, which is important to get as much testing as possible without
needing to centralize everything.

> Anyway, back to this patch, I believe it is a useful test.

It's just a shame it's so specifically written.

--=20
Tom

--xU5V4O2xoYaEtTkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme9zLYACgkQFHw5/5Y0
tyyGdAv+OlhArRTUkwDuZv2xknGk6vaoSLpBd4PCmX+MCiaZ7hx7gXkyWR0kYsam
xGq48YNS7BzeGJkKvFGAbJEXkvllr4N6HCQ5mKIGPMNBpa7eZh1SyP++VZ29SJPk
FrtqnemB+3BZ4V2Vt8YjO3aJv0mQUWjk2PiJlo1z9LUchI9EL+cO5CLx4kEtOMvH
2+ydTRS9687zLAWFCiMpMVlPoGDqll3rHDjBi6/OgjkOmQUNB17fm+UKhcbAFr9X
wM2dEbA3+wobMCX9CEB4nqnxMWZFEdfFy5RSsCB/+c8E6BqC6gTqnHKrqePNvHt6
GupuiOgqzw/t4FlEkZXseD1gXmoxlTGudwbyD9r9zUo/AtPxpGAhp7MdRe45ATid
c7VsriiKj6rV4xMUMujKzz8eW41g+ElMAI7Vd1lAx3hLUsjSx29WuQGfI/ljxCvn
5cFc962ToSBWbjCD0XRKaFk86L7uU7blLiKOgs+Q4kaE/HnW5dQk2AV8B6qVrWDL
L1SnUwuh
=1aZW
-----END PGP SIGNATURE-----

--xU5V4O2xoYaEtTkk--
