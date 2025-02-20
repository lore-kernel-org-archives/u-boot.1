Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF059C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3C6801BE;
	Thu, 20 Feb 2025 14:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5plwqZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA93806FE; Thu, 20 Feb 2025 14:50:06 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D268007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso197104166b.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740059403; x=1740664203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=32yeu9EAtZGV1fMKMbB/fCWusg+XTknfHJI6N2x3P8s=;
 b=V5plwqZ3UdK3DVEdUPxxGox54Cu/xhQukwCXRvBFjGL/KbGH+89gV3IGPIOT3optPf
 A3zGRCqdaSAxW0hbZv5iKXsPkWFVyr7Khq8SJK4Y5ZmXQPFxPjpFi2JdUHb2WRi1awH5
 NZcH8jtylRzKhnAQ7Al2lvXd5S1BhK/sWDUuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059403; x=1740664203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32yeu9EAtZGV1fMKMbB/fCWusg+XTknfHJI6N2x3P8s=;
 b=QxL1gl3XLLpZDGZOWH2cQUUWTok0//mypnNpeVjA6c7MgSJTifWJXE9wuIIG5yEd2s
 7Nd4wOh5rUdh0SryjACBF/s+sp8d8tZ6uWBFy3KGMSXUvBZ1/i91zwi34gFQs42m4Qle
 7mr5Enu2lJqrNgUbBXRB5T21XhGRmon/tMg0N/pMEKCS5EIo2ITYkvJHdGC3XrkbaWCe
 /QL6AMgC+MNPOGUIzal2Q5Mp6zD1nTlUpzwPyStuPd8SNCHrxM/F+NcZ9hzrNWqmIwoa
 wEA6c8o/XBZcea/Nf1YypeezbzqG0jAiF0PZ4fADkpAM16e6vfnGipaxnPfMQ4YzU/Wx
 kiaw==
X-Gm-Message-State: AOJu0Yw2JeM4KU4sMO/U0GIrXkw2CmlURbK11D4z4sLJHFESYp/141bd
 MEEYEE1LC9yiEHdJpEFGd5V5zWY2jsR8+SZ7fHirnFElBoVOatmH7in/nof5Anmq872BfiMNxkK
 IkR4nx+xPADufIG1rz2O5pYduiA/evNjBGvijOOWqi9Ab7IAFbg==
X-Gm-Gg: ASbGncsxkuz0pUfdMRjOTn+bTz1Irtv+7FpZIYBWl6OH4mwg3AYonSTLfOaFtrNRG4L
 XmhO0rFJNHuQhlnchF8vE0FpuJ2A5diJEGWnXeiU+A1atKrJ9meJYUM4yO+cTstYCqftj4MgK3A
 ==
X-Google-Smtp-Source: AGHT+IGy2QJtGuuZNpxeq1vxAcU6wkKXtPElWEdPGV7Qq0HwRzgsSolopfNbGEm0aIKA1Lcqx5TgP4Piddnz1/kb+PU=
X-Received: by 2002:a17:907:1c9f:b0:ab7:be66:792f with SMTP id
 a640c23a62f3a-abbcd0cf1b1mr886520566b.49.1740059402877; Thu, 20 Feb 2025
 05:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
 <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
 <20250218151145.GD1233568@bill-the-cat>
 <CAFLszTibOj_P4CiSP5wHjGzM+iaOr7e8XnLw-bR5wXpu8xxZrA@mail.gmail.com>
 <20250219005515.GR1233568@bill-the-cat>
In-Reply-To: <20250219005515.GR1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 06:49:49 -0700
X-Gm-Features: AWEUYZkO_c8jZm4DTeYiHmTgWGfOZGGU1hN9B0od2Hc1W0pIph5pKRtOH9RxrIs
Message-ID: <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
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

On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > > > > > Now that U-Boot can boot this quickly, using kvm, add a test that the
> > > > > > installer starts up correctly.
> > > > > >
> > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Add more patches to support booting with kvm
> > > > > > - Add new patch with a test for booting Ubuntu 24.04
> > > > > >
> > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
> > > > > >  2 files changed, 58 insertions(+)
> > > > > >  create mode 100644 test/py/tests/test_distro.py
> > > > > >
> > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > --- a/.gitlab-ci.yml
> > > > > > +++ b/.gitlab-ci.yml
> > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > >    variables:
> > > > > >      ROLE: zybo
> > > > > >    <<: *lab_dfn
> > > > > > +
> > > > > > +qemu-x86_64:
> > > > > > +  variables:
> > > > > > +    ROLE: qemu-x86_64
> > > > > > +  <<: *lab_dfn
> > > > >
> > > > > I'm not sure why this is in your lab stanza, rather than the normal
> > > > > test.py QEMU stanza.
> > > >
> > > > Are you wanting to add the Ubuntu image into CI? It is quite large.
> > >
> > > If we're going to be able to run it on N platforms, yes, we need to
> > > think of a good way to cache the download. There's not a particular
> > > reason we can't run the stock Ubuntu RISC-V image on the two sifive
> > > targets and also qemu-riscv64, is there?
> >
> > Yes, we can do that. It is pretty simple to set up in Labgrid and it
> > doesn't require all the runners to download a much larger image, etc.
>
> I don't quite understand why it's under "labgrid". These are generic CI
> tests. Now maybe we need to, in both Gitlab and Azure, add some logic so
> that certain longer or possibly destructive tests are only run on tagged
> releases or as requested rather than every time, as it will take longer.
> But pretty much every platform under the qemu target list should be able
> to Just Boot an off the shelf OS distribution is my point.

Sure, and I'm not suggesting we shouldn't do that as well.

>
> > > > > > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> > > > > > new file mode 100644
> > > > > > index 00000000000..51eec45cecc
> > > > > > --- /dev/null
> > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > @@ -0,0 +1,53 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > +# Written by Simon Glass <simon.glass@canonical.com>
> > > > > > +
> > > > > > +import pytest
> > > > > > +
> > > > > > +DOWN = '\x1b\x5b\x42\x0d'
> > > > > > +
> > > > > > +# Enable early console so that the test can see if something goes wrong
> > > > > > +CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
> > > > > > +
> > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > +def test_distro(ubman):
> > > > > > +    """Test that of-platdata can be generated and used in sandbox"""
> > > > > > +    with ubman.log.section('boot'):
> > > > > > +        ubman.run_command('boot', wait_for_prompt=False)
> > > > > > +
> > > > > > +    with ubman.log.section('Grub'):
> > > > > > +        # Wait for grub to come up and offset a menu
> > > > > > +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > > > +
> > > > > > +        # Press 'e' to edit the command line
> > > > > > +        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
> > > > > > +
> > > > > > +        # Wait until we see the editor appear
> > > > > > +        ubman.p.expect(['/casper/initrd'])
> > > > > > +
> > > > > > +        # Go down to the 'linux' line
> > > > > > +        ubman.send(DOWN * 3)
> > > > > > +
> > > > > > +        # Go to end of line
> > > > > > +        ubman.ctrl('E')
> > > > > > +
> > > > > > +        # Backspace to remove 'quiet splash'
> > > > > > +        ubman.send('\b' * len('quiet splash'))
> > > > > > +
> > > > > > +        # Send our noisy console
> > > > > > +        ubman.send(CONSOLE)
> > > > > > +
> > > > > > +        # Tell grub to boot
> > > > > > +        ubman.ctrl('X')
> > > > > > +        ubman.p.expect(['Booting a command list'])
> > > > > > +
> > > > > > +    with ubman.log.section('Linux'):
> > > > > > +        # Linux should start immediately
> > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > +
> > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > +        # Shortly later, we should see this banner
> > > > > > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > > > > > +
> > > > > > +    ubman.restart_uboot()
> > > > >
> > > > > And this seems very inflexible. Please see
> > > > > test/py/tests/test_net_boot.py for an example of how to have this be
> > > > > configurable and work on arbitrary platforms. What I assume is tricky is
> > > > > that the "role" part here is where you have a special disk image being
> > > > > passed. That too could be dealt with in u-boot-test-hooks in a few ways,
> > > > > and the images pre-fetched to the CI container. And if this was
> > > > > configurable similar to the example I noted above, it could check real
> > > > > hardware too.
> > > >
> > > > That wasn't the reaction I expected.
> > > >
> > > > Yes, it is inflexible, but it is a starting point. Isn't it better
> > > > than what we have today?
> > >
> > > Is your inflexible boot an OS test better than the flexible boot an OS
> > > test that we have today? No, it's not.
> >
> > I didn't even know about it, or perhaps I forgot.
>
> I believe I mentioned it every time you've said we should have an OS
> test, so yes, I guess you forgot.

Well it was only added in May last year and it relies on board config
which I don't have...although I see that you have now posted yours.

>
> > Perhaps this relates to getting the labgrid config published and
> > figuring out how to pass info from Labgrid to tests.
> >
> > >
> > > > I would like to generalise this test to work on at least one real
> > > > board, preferably one that doesn't use grub.
> > >
> > > OK. The test we have today does that, if you check for the "Welcome to
> > > ..." string instead of the kernel has booted string. It also does
> > > netboot rather than run default bootcmd. But that's an easy enough test
> > > to write up. The only thing stopping me from doing that right now is I
> > > need to find a board in the lab where we installed an OS to eMMC and not
> > > SD card (some lab sd-mux issues).
> >
> > OK. Labgrid has a 'features' thing which you can attach to targets, so
> > I should be able to use that to indicate that Ubuntu, Debian, Armbian,
> > etc. are available.
>
> OK, but that sounds like the opposite direction. These are generic tests
> that can run in any / all of the labs, not just your labgrid
> configuration. AMD has been contributing tests that run on hardware for
> example.

That's great, the more tests we have the better. But those tests can't
and don't run in CI, whereas mine can and do.

We need an 'all of the above' strategy here.

BTW, having thought about how test/py works a bit, instead of the
env__net_tftp_bootable_file stuff, we should have code or data which
sets up the required test files (on a suitable server) before running
the test. That way, all the test code is in one Python file and we
don't have to spend ages trying to divine what each test needs.

Regards,
Simon
