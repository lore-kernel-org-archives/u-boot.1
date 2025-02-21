Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7100DC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 13:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58AD80F67;
	Fri, 21 Feb 2025 14:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SArgSgde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A5B80F70; Fri, 21 Feb 2025 14:57:49 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1390E806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 14:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abbdc4a0b5aso402451466b.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740146266; x=1740751066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B6hxl2htqYb3Bka+AZLzBcQudaAWg5iGujvw994dynI=;
 b=SArgSgde2MZuhzQQc9asEBhy8qjZLvfvFoo55WiErX8Ghyckjb62nWK4YjR709uU7U
 ca9a7HTl3/H3Kv/esEqQW2KwcCM7de9q9dqOiMZNlP0tkgSjnKETBY11VS+KRUpsWXfq
 Jh/al+6kiBGPN1YL4tDu2Hpr8wUVHAXINpcdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740146266; x=1740751066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6hxl2htqYb3Bka+AZLzBcQudaAWg5iGujvw994dynI=;
 b=SEY/3VyJTgYIUu5Cqserp7+TcRfMHl9ZYMA+cHr0oGaGDGm553I7HvH86Uu7qNNSNF
 TZG5DuBdFmGNSZcitSgAv0la0qvERTxuYyTK9BSWvqLlion/eYnDWsdV8LMEbFLzGti7
 9f4aG8Y65b4/uvFeMls7tIkwlMC2/IMyMewrUD7NMxnv12NVe+wfaogUhWSi4wrUDKDJ
 DobeqkuCFft9oyI3aZqXXR3HVlTLDG6Fq7VX7MBbFYABDXM84N3HW98USce261QVANnM
 QgFwgOuYN0kNb/yy92e1K4683BmqCLtuGMpY4OonhAFzYGoigFAlgGZM9j03ItDj/Cg9
 ih1Q==
X-Gm-Message-State: AOJu0YzoNKGA1DwN0vzNWj5qz2C1+VgzZOIV4ei2wySMdegYj6dk9a+i
 hjo/xdt0XnqBVj2GoRk4jnftAH0kikX2H+0Fh9FN1h1xF+yvSqYhSBtV2HofEoFbUUu4w2lncRA
 R+Q6J0AuHLvsXwJWEmVUAxM9hyKaC20YE4Q/R
X-Gm-Gg: ASbGncuZK3DGOGZUtbYSULUGS50Lv18RlEiT3boY4qdcbO4HWNxFJlPzXMCiHbwrWhQ
 w1z4E02bux22e1eoEGbWLYIBm3f2J3ixAZAudQGRYuit6zGUv+aMy9yP7xzFKcAb31UvZW5qTrS
 XzZ0PqbtPc
X-Google-Smtp-Source: AGHT+IEGUoRKz/6mtvWhU16LMxtoPPkUy4VnNGK1a/4y2DVYFM6+WLCIxbOhBpaqo7I8u7i2fVDkOTU8L8zwp6hXsEk=
X-Received: by 2002:a17:906:f59f:b0:ab7:d1d0:1a84 with SMTP id
 a640c23a62f3a-abc0ae1ab9fmr301742666b.4.1740146266355; Fri, 21 Feb 2025
 05:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
In-Reply-To: <20250220145311.GY1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 06:57:34 -0700
X-Gm-Features: AWEUYZmwwvNPlCMuz7N369fBnhbWhz9LakvnThLpWXn2ZUNO17FznvHP2_JVC8g
Message-ID: <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > > > > > Now that U-Boot can boot this quickly, using kvm, add a test that the
> > > > > > > > installer starts up correctly.
> > > > > > > >
> > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - Add more patches to support booting with kvm
> > > > > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > > > > >
> > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
> > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > > > >
> > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > >    variables:
> > > > > > > >      ROLE: zybo
> > > > > > > >    <<: *lab_dfn
> > > > > > > > +
> > > > > > > > +qemu-x86_64:
> > > > > > > > +  variables:
> > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > +  <<: *lab_dfn
> > > > > > >
> > > > > > > I'm not sure why this is in your lab stanza, rather than the normal
> > > > > > > test.py QEMU stanza.
> > > > > >
> > > > > > Are you wanting to add the Ubuntu image into CI? It is quite large.
> > > > >
> > > > > If we're going to be able to run it on N platforms, yes, we need to
> > > > > think of a good way to cache the download. There's not a particular
> > > > > reason we can't run the stock Ubuntu RISC-V image on the two sifive
> > > > > targets and also qemu-riscv64, is there?
> > > >
> > > > Yes, we can do that. It is pretty simple to set up in Labgrid and it
> > > > doesn't require all the runners to download a much larger image, etc.
> > >
> > > I don't quite understand why it's under "labgrid". These are generic CI
> > > tests. Now maybe we need to, in both Gitlab and Azure, add some logic so
> > > that certain longer or possibly destructive tests are only run on tagged
> > > releases or as requested rather than every time, as it will take longer.
> > > But pretty much every platform under the qemu target list should be able
> > > to Just Boot an off the shelf OS distribution is my point.
> >
> > Sure, and I'm not suggesting we shouldn't do that as well.
> >
> > >
> > > > > > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> > > > > > > > new file mode 100644
> > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > > > > +
> > > > > > > > +import pytest
> > > > > > > > +
> > > > > > > > +DOWN = '\x1b\x5b\x42\x0d'
> > > > > > > > +
> > > > > > > > +# Enable early console so that the test can see if something goes wrong
> > > > > > > > +CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
> > > > > > > > +
> > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > +def test_distro(ubman):
> > > > > > > > +    """Test that of-platdata can be generated and used in sandbox"""
> > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > +        ubman.run_command('boot', wait_for_prompt=False)
> > > > > > > > +
> > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > +        # Wait for grub to come up and offset a menu
> > > > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > > > +
> > > > > > > > +        # Press 'e' to edit the command line
> > > > > > > > +        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
> > > > > > > > +
> > > > > > > > +        # Wait until we see the editor appear
> > > > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > > > +
> > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > +
> > > > > > > > +        # Go to end of line
> > > > > > > > +        ubman.ctrl('E')
> > > > > > > > +
> > > > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > > > +
> > > > > > > > +        # Send our noisy console
> > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > +
> > > > > > > > +        # Tell grub to boot
> > > > > > > > +        ubman.ctrl('X')
> > > > > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > > > > +
> > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > +        # Linux should start immediately
> > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > +
> > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > +        # Shortly later, we should see this banner
> > > > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > > > > > > > +
> > > > > > > > +    ubman.restart_uboot()
> > > > > > >
> > > > > > > And this seems very inflexible. Please see
> > > > > > > test/py/tests/test_net_boot.py for an example of how to have this be
> > > > > > > configurable and work on arbitrary platforms. What I assume is tricky is
> > > > > > > that the "role" part here is where you have a special disk image being
> > > > > > > passed. That too could be dealt with in u-boot-test-hooks in a few ways,
> > > > > > > and the images pre-fetched to the CI container. And if this was
> > > > > > > configurable similar to the example I noted above, it could check real
> > > > > > > hardware too.
> > > > > >
> > > > > > That wasn't the reaction I expected.
> > > > > >
> > > > > > Yes, it is inflexible, but it is a starting point. Isn't it better
> > > > > > than what we have today?
> > > > >
> > > > > Is your inflexible boot an OS test better than the flexible boot an OS
> > > > > test that we have today? No, it's not.
> > > >
> > > > I didn't even know about it, or perhaps I forgot.
> > >
> > > I believe I mentioned it every time you've said we should have an OS
> > > test, so yes, I guess you forgot.
> >
> > Well it was only added in May last year and it relies on board config
> > which I don't have...although I see that you have now posted yours.
>
> Yes, it was added not quite a year ago, and is documented within the
> test, like most tests that rely on the real platform.
>
> And do we need better documentation for test? Yes.

+1

I'll note that I did my bit!

>
> > > > Perhaps this relates to getting the labgrid config published and
> > > > figuring out how to pass info from Labgrid to tests.
> > > >
> > > > >
> > > > > > I would like to generalise this test to work on at least one real
> > > > > > board, preferably one that doesn't use grub.
> > > > >
> > > > > OK. The test we have today does that, if you check for the "Welcome to
> > > > > ..." string instead of the kernel has booted string. It also does
> > > > > netboot rather than run default bootcmd. But that's an easy enough test
> > > > > to write up. The only thing stopping me from doing that right now is I
> > > > > need to find a board in the lab where we installed an OS to eMMC and not
> > > > > SD card (some lab sd-mux issues).
> > > >
> > > > OK. Labgrid has a 'features' thing which you can attach to targets, so
> > > > I should be able to use that to indicate that Ubuntu, Debian, Armbian,
> > > > etc. are available.
> > >
> > > OK, but that sounds like the opposite direction. These are generic tests
> > > that can run in any / all of the labs, not just your labgrid
> > > configuration. AMD has been contributing tests that run on hardware for
> > > example.
> >
> > That's great, the more tests we have the better. But those tests can't
> > and don't run in CI, whereas mine can and do.
>
> AFAICT they're running on AMD's CI. They run on my CI. They don't run on
> *your* lab because you took things, intentionally, in a direction to
> minimize using u-boot-test-hooks and our existing per-board
> configuration infrastructure.

When I look at CI all I see is my lab. Which CI are you referring to
and how can I access it?

Here I would like to make a case for moving to using Labgrid across
the board, but unfortunately the project struggles to review PRs, so
it's probably not a good idea.

>
> > We need an 'all of the above' strategy here.
>
> Sure. But I still want to see things as reusable as possible. What you
> have above is *extremely* board and OS specific and non-configurable.

Yes, agreed.

> I
> also don't quite see why it's not a test of autoboot with the
> pre-requisite of an OS being installed.

Ah OK, my test is just for the installer itself. Both are useful, but
I hope eventually to have the installer run to completion and then
reboot to check all is well.

>
> > BTW, having thought about how test/py works a bit, instead of the
> > env__net_tftp_bootable_file stuff, we should have code or data which
> > sets up the required test files (on a suitable server) before running
> > the test. That way, all the test code is in one Python file and we
> > don't have to spend ages trying to divine what each test needs.
>
> That seems like a lot more work than documenting more what we have
> today, and I'm not sure of the benefit. Given the contents of the pxe
> test, yes, just having those files available to 'cp' in place would be
> helpful. But that's not the case for booting a kernel (the FIT match
> stuff doesn't work on the TI platforms atm). And if you look at the
> config I posted it also includes bootstage configuration. It also won't
> work well for the SPI tests, which I'm talking with Love about in
> another thread.

Yes, perhaps, but having self-contained tests would be a win.

>
> In other words, the majority of py/<host>/u_boot_boardenv_ content is
> configuration details, specific to both the platform / SoC first, some
> lab specific details second and drop-in existing 3rd party files a
> distant third.

I think the u-boot-test-hooks was an amazing solution 9 years ago, but
we have outgrown it. We want people to be able to connect their lab to
CI (meaning gitlab), so testing is more automated.

We should move away from relying on maintainers getting around to
testing patches months after they are sent, when they have time, but
they don't. Things need to be more automated and I'd encourage you to
push this as well.

Regards,
Simon
