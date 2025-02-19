Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FAAC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0167B800B3;
	Wed, 19 Feb 2025 01:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y8K1FMx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1CC80C8F; Wed, 19 Feb 2025 01:01:54 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985BC80077
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5ded46f323fso8022175a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739923312; x=1740528112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/fGwOgqtgetMST0j8RS6EgoWUrQgFXSijOV9yb6ch6M=;
 b=Y8K1FMx6+M6t+XIjrgQF0m2MnLC3KkIyab0dgjr8mDEPX0WMUD0aGFPY4a992BoKgQ
 3x4G1D1d9Luoy7LIvqDIMbBJkTj1QTX6FpAOwWjUIxo32rkyXna1ECWk5Eh5cQ4vnnNj
 NP6+GXOATLPYXeww1q3T0L+nfi0m87n8vIaE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739923312; x=1740528112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fGwOgqtgetMST0j8RS6EgoWUrQgFXSijOV9yb6ch6M=;
 b=nEDHpSRxSZdjPuH9Ea+bP4MwkZNUcwYW2437LDo26oyB911gjWoHWJFQLghDBmOBJ3
 GAMBHroGT/4ZP3GjYy/ptSXyN53qAhfDQFSpU0B3hEUk3MCXh0QNcj59iYdcHPP/rlnI
 HTvunJDoyHFeWXK14NKmQrUVNPE9y7YTL8Jj8+0jweHT37miprEKdmDxYunoe7tYFQwK
 6aSluHqz6JWeuDI5Ax1tlDebpjrAlGQJJoaxBhOSJF2AFHBaukNfPtEX2DTnCxM3v9xC
 lUa893tZc+MeSXJkbT5tDjlfaktNFpWYoVzvUtIH3G9FU8sWLFN0GeGlCesaMELgVmp5
 FPuQ==
X-Gm-Message-State: AOJu0YxPdDgf3db4VXeOuD5ofozrXqN4JWWa6qAMrCwaSxwd0HepTl/O
 DDbGEATqeQmfny5F4sAivt6gViNKfQ5cipILrIdti3eaG7+KbINektQ78yHT++ROVPCcSatp9dm
 5JA3T49/YHiFI8ETNgYbMVj0I2e/59TasRsbI
X-Gm-Gg: ASbGnctDzrlry1BsDkxJdj4xostWSQylmI/ZlfgP/BfCmPPtrnmTcphZW79U9UMeaJZ
 NUzKq9kWafE/YKAkFhgtz2TunLzWGE7jun4qsrX3+TPOZVEPLBZxGXHWCB0x9nclkdalPzqFxZg
 ==
X-Google-Smtp-Source: AGHT+IFVaQ5LKJPId7jFnCpW8DPCjORxy2l4O3NAsjjlXgF+2iD2Pj9/iT4flZGhq9EGqJnHtqWhlaITizTLfLyivJ4=
X-Received: by 2002:a17:907:2dab:b0:ab7:758c:b398 with SMTP id
 a640c23a62f3a-abbcccfa1b6mr120005166b.20.1739923311945; Tue, 18 Feb 2025
 16:01:51 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
In-Reply-To: <20250218151145.GD1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 17:01:40 -0700
X-Gm-Features: AWEUYZnLt0AhnI9FY0jriwpRn-QeIRd0BGb9c_hAmjUAexXOaQGJMVqK55ekKKo
Message-ID: <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
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

On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > Now that U-Boot can boot this quickly, using kvm, add a test that the
> > > > installer starts up correctly.
> > > >
> > > > Use the qemu-x86_64 board in the SJG lab.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add more patches to support booting with kvm
> > > > - Add new patch with a test for booting Ubuntu 24.04
> > > >
> > > >  .gitlab-ci.yml               |  5 ++++
> > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 58 insertions(+)
> > > >  create mode 100644 test/py/tests/test_distro.py
> > > >
> > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > --- a/.gitlab-ci.yml
> > > > +++ b/.gitlab-ci.yml
> > > > @@ -745,3 +745,8 @@ zybo:
> > > >    variables:
> > > >      ROLE: zybo
> > > >    <<: *lab_dfn
> > > > +
> > > > +qemu-x86_64:
> > > > +  variables:
> > > > +    ROLE: qemu-x86_64
> > > > +  <<: *lab_dfn
> > >
> > > I'm not sure why this is in your lab stanza, rather than the normal
> > > test.py QEMU stanza.
> >
> > Are you wanting to add the Ubuntu image into CI? It is quite large.
>
> If we're going to be able to run it on N platforms, yes, we need to
> think of a good way to cache the download. There's not a particular
> reason we can't run the stock Ubuntu RISC-V image on the two sifive
> targets and also qemu-riscv64, is there?

Yes, we can do that. It is pretty simple to set up in Labgrid and it
doesn't require all the runners to download a much larger image, etc.

>
> > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> > > > new file mode 100644
> > > > index 00000000000..51eec45cecc
> > > > --- /dev/null
> > > > +++ b/test/py/tests/test_distro.py
> > > > @@ -0,0 +1,53 @@
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +# Copyright 2025 Canonical Ltd.
> > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > +
> > > > +import pytest
> > > > +
> > > > +DOWN = '\x1b\x5b\x42\x0d'
> > > > +
> > > > +# Enable early console so that the test can see if something goes wrong
> > > > +CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
> > > > +
> > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > +@pytest.mark.role('qemu-x86_64')
> > > > +def test_distro(ubman):
> > > > +    """Test that of-platdata can be generated and used in sandbox"""
> > > > +    with ubman.log.section('boot'):
> > > > +        ubman.run_command('boot', wait_for_prompt=False)
> > > > +
> > > > +    with ubman.log.section('Grub'):
> > > > +        # Wait for grub to come up and offset a menu
> > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > +
> > > > +        # Press 'e' to edit the command line
> > > > +        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
> > > > +
> > > > +        # Wait until we see the editor appear
> > > > +        ubman.p.expect(['/casper/initrd'])
> > > > +
> > > > +        # Go down to the 'linux' line
> > > > +        ubman.send(DOWN * 3)
> > > > +
> > > > +        # Go to end of line
> > > > +        ubman.ctrl('E')
> > > > +
> > > > +        # Backspace to remove 'quiet splash'
> > > > +        ubman.send('\b' * len('quiet splash'))
> > > > +
> > > > +        # Send our noisy console
> > > > +        ubman.send(CONSOLE)
> > > > +
> > > > +        # Tell grub to boot
> > > > +        ubman.ctrl('X')
> > > > +        ubman.p.expect(['Booting a command list'])
> > > > +
> > > > +    with ubman.log.section('Linux'):
> > > > +        # Linux should start immediately
> > > > +        ubman.p.expect(['Linux version'])
> > > > +
> > > > +    with ubman.log.section('Ubuntu'):
> > > > +        # Shortly later, we should see this banner
> > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > > > +
> > > > +    ubman.restart_uboot()
> > >
> > > And this seems very inflexible. Please see
> > > test/py/tests/test_net_boot.py for an example of how to have this be
> > > configurable and work on arbitrary platforms. What I assume is tricky is
> > > that the "role" part here is where you have a special disk image being
> > > passed. That too could be dealt with in u-boot-test-hooks in a few ways,
> > > and the images pre-fetched to the CI container. And if this was
> > > configurable similar to the example I noted above, it could check real
> > > hardware too.
> >
> > That wasn't the reaction I expected.
> >
> > Yes, it is inflexible, but it is a starting point. Isn't it better
> > than what we have today?
>
> Is your inflexible boot an OS test better than the flexible boot an OS
> test that we have today? No, it's not.

I didn't even know about it, or perhaps I forgot.

Perhaps this relates to getting the labgrid config published and
figuring out how to pass info from Labgrid to tests.

>
> > I would like to generalise this test to work on at least one real
> > board, preferably one that doesn't use grub.
>
> OK. The test we have today does that, if you check for the "Welcome to
> ..." string instead of the kernel has booted string. It also does
> netboot rather than run default bootcmd. But that's an easy enough test
> to write up. The only thing stopping me from doing that right now is I
> need to find a board in the lab where we installed an OS to eMMC and not
> SD card (some lab sd-mux issues).

OK. Labgrid has a 'features' thing which you can attach to targets, so
I should be able to use that to indicate that Ubuntu, Debian, Armbian,
etc. are available.

Regards,
Simon
