Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282D0C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD16680F18;
	Tue, 18 Feb 2025 13:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iidPikTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3117880BA8; Tue, 18 Feb 2025 13:09:37 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F01E80F67
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abb8045c3f3so339393066b.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739880574; x=1740485374; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bhS1Mjl8BqfcLJ0PQbQVJ1QCSpQZQUPbuud3HwiZ/Mg=;
 b=iidPikTHBJzWFuQQaj3u7l8GsZ5zUzqw9RcDgcEKJtw+zTVGfgDXaPKsJORuly/3+i
 oF7ucCE+uqwnj7BFBVoQV9vCAXcf0/vYRBK/JIIDQELP462fU9gAg25En5hG8EfulfC7
 JMcRX0IBAzDcKwrkCplquhxpga6cHBvufmKUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739880574; x=1740485374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhS1Mjl8BqfcLJ0PQbQVJ1QCSpQZQUPbuud3HwiZ/Mg=;
 b=Qab4s0zFa7S5o+hrgciFIFWPStYfr0oSN1fm0MskD+2AWdlvMxsmn75SQIj9r1/lhF
 9gHNR6OwkTDVRISrIKdDdZPhZqftDBNPua+mLjZ0warxXdgmhsJ7BLDLPs+TIvhkT9XH
 rMfYFA6y2WMiXpon0wnBqNA0/AW0ooU1uViItGy2Ccz5TFGal0yMD2RUpTND2uJf5gBF
 EK3AetI/7SbkV08/XU7SeN/wD0LJ6mqrvV9hNHrhMZewVSQt+ahbtxW9eanAUEljMixI
 2B5/iIBXsL2BGDMrp7BoZPENUFNXxRDwVl3Qxu90XslpZnlL5wDBon/AFtgN7XCKb6az
 Yi2A==
X-Gm-Message-State: AOJu0YzL90mHyxGuR6J6gvBP3AHLS/sHknoMFwyOrLi1GfIPOR7D3A+L
 4h82eMlZcmJ4tRa7D3x6mkcRmp5B5NuFpmMRuE/sI6xoIBfBNvDtim8Gqemls5PbI4iHD9XfXOe
 1W75kna/1o8SoRSBX3PGjMpJpQ90b4TOIByYhZBLexm3vPwfrww==
X-Gm-Gg: ASbGncsAdy1RL6eaCqXDiT9TEtkyjSrYuY6v66YAchQ6dpDJczCZmZF4KuYK47anhxX
 N0OTU54wT7lstNwVF8lCEucta2RXhIXH2leFm6oww14H4lQTwwNkVhhAUBN6itJum69IPyz3jLQ
 ==
X-Google-Smtp-Source: AGHT+IGGdxQlwEVWQr5vDxiR5rYM+AORnYtjbdw4N9FJ2/foPOBFJv0syR2KMTe/PiYkYZDUh3/2FDrjxoKItndbS9Q=
X-Received: by 2002:a17:906:a44b:b0:abb:b294:6a2d with SMTP id
 a640c23a62f3a-abbb2946c67mr368458066b.53.1739880574531; Tue, 18 Feb 2025
 04:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-29-sjg@chromium.org>
 <20250217175210.GR1233568@bill-the-cat>
In-Reply-To: <20250217175210.GR1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 05:09:23 -0700
X-Gm-Features: AWEUYZnXfcGkL3xoluBsTpGE7KaafZMLdOpNEglzQoNWFg1ROYclbVYCgk4hg4g
Message-ID: <CAFLszThPi2PuEP0osj895nRANNAUrCF+C-k6B319phs0Jf7xMg@mail.gmail.com>
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

On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass wrote:
> > Now that U-Boot can boot this quickly, using kvm, add a test that the
> > installer starts up correctly.
> >
> > Use the qemu-x86_64 board in the SJG lab.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add more patches to support booting with kvm
> > - Add new patch with a test for booting Ubuntu 24.04
> >
> >  .gitlab-ci.yml               |  5 ++++
> >  test/py/tests/test_distro.py | 53 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> >  create mode 100644 test/py/tests/test_distro.py
> >
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 8c49d5b0a79..ec799e97c10 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -745,3 +745,8 @@ zybo:
> >    variables:
> >      ROLE: zybo
> >    <<: *lab_dfn
> > +
> > +qemu-x86_64:
> > +  variables:
> > +    ROLE: qemu-x86_64
> > +  <<: *lab_dfn
>
> I'm not sure why this is in your lab stanza, rather than the normal
> test.py QEMU stanza.

Are you wanting to add the Ubuntu image into CI? It is quite large.

>
> > diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> > new file mode 100644
> > index 00000000000..51eec45cecc
> > --- /dev/null
> > +++ b/test/py/tests/test_distro.py
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright 2025 Canonical Ltd.
> > +# Written by Simon Glass <simon.glass@canonical.com>
> > +
> > +import pytest
> > +
> > +DOWN = '\x1b\x5b\x42\x0d'
> > +
> > +# Enable early console so that the test can see if something goes wrong
> > +CONSOLE = 'earlycon=uart8250,io,0x3f8 console=uart8250,io,0x3f8'
> > +
> > +@pytest.mark.boardspec('qemu-x86_64')
> > +@pytest.mark.role('qemu-x86_64')
> > +def test_distro(ubman):
> > +    """Test that of-platdata can be generated and used in sandbox"""
> > +    with ubman.log.section('boot'):
> > +        ubman.run_command('boot', wait_for_prompt=False)
> > +
> > +    with ubman.log.section('Grub'):
> > +        # Wait for grub to come up and offset a menu
> > +        ubman.p.expect(['Try or Install Ubuntu'])
> > +
> > +        # Press 'e' to edit the command line
> > +        ubman.run_command('e', wait_for_prompt=False, send_nl=False)
> > +
> > +        # Wait until we see the editor appear
> > +        ubman.p.expect(['/casper/initrd'])
> > +
> > +        # Go down to the 'linux' line
> > +        ubman.send(DOWN * 3)
> > +
> > +        # Go to end of line
> > +        ubman.ctrl('E')
> > +
> > +        # Backspace to remove 'quiet splash'
> > +        ubman.send('\b' * len('quiet splash'))
> > +
> > +        # Send our noisy console
> > +        ubman.send(CONSOLE)
> > +
> > +        # Tell grub to boot
> > +        ubman.ctrl('X')
> > +        ubman.p.expect(['Booting a command list'])
> > +
> > +    with ubman.log.section('Linux'):
> > +        # Linux should start immediately
> > +        ubman.p.expect(['Linux version'])
> > +
> > +    with ubman.log.section('Ubuntu'):
> > +        # Shortly later, we should see this banner
> > +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1 LTS.*!'])
> > +
> > +    ubman.restart_uboot()
>
> And this seems very inflexible. Please see
> test/py/tests/test_net_boot.py for an example of how to have this be
> configurable and work on arbitrary platforms. What I assume is tricky is
> that the "role" part here is where you have a special disk image being
> passed. That too could be dealt with in u-boot-test-hooks in a few ways,
> and the images pre-fetched to the CI container. And if this was
> configurable similar to the example I noted above, it could check real
> hardware too.

That wasn't the reaction I expected.

Yes, it is inflexible, but it is a starting point. Isn't it better
than what we have today?

I would like to generalise this test to work on at least one real
board, preferably one that doesn't use grub.

Regards,
Simon
