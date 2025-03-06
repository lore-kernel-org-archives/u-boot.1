Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22ACC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F67280FE1;
	Thu,  6 Mar 2025 15:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UV8PLg13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F512811C1; Thu,  6 Mar 2025 15:32:57 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D078880756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef7c9e9592so6605327b3.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741271573; x=1741876373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ucrAwheoSiKtrm7MOOganfD7neEdfd72Nd85yU/vpis=;
 b=UV8PLg13/bhmec/e2LgQcZ4ZVKVreDK7ZdsNWicaP07xwjLuitGGAz6QlHnTNwq9VP
 omzYTbnz8ogt6gpJN03/3JVaSe3q9Ta9ZcKMMs4PZNptATGkzBs2ioj6Re3j48Tqo8Vc
 c8HZQJTLx8I4HuiygRGB3ikgwcdEMPap0PGYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741271573; x=1741876373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucrAwheoSiKtrm7MOOganfD7neEdfd72Nd85yU/vpis=;
 b=sJ4OgMMmwfxgUFWjVZpeLNWMIoa1kCsnrmII1jpUeQLivnluA4Ex/DgeMUCr2IGc8R
 s1k2W5dpGE+oSUfDSyEB9RpRovId0MZCd0BpmUjj/uAWJ4gXNGLNpN/PUHFrGo25iP5w
 5LXtP64b409+kjTvulQWEv+mHaFwW7sXX1mhJKRnXpkHl1KwVNraI7r7lrP98yB/vltg
 QE4XHY7f65KomeQ0Q/q76iTnHMYZ0CyDFMRcu/gd2RkNRUjEoDpGNjrl+atLLqnhigv3
 XL/GlJL6p4KuOo5Q0b4cG014bS0MYPnp1G7jgFIa/JyYKkwkbSF47GymmLtEhiZ8OtCS
 FgMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkADbGaDqN5VaSUx3JfailTqnI5Nt9flY4kmjiQ1hgT73Td+WLJ6sXed9BUuVly0gcN843hOo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/73O3MKYWKRbj7wC8nFz8fL5Q+Yz/mRW9ckZ7PcJeM0WavV8E
 k0eThMv9mW0kcDBVFetCR7VQDQdpKXHHFicfqi/WeoOpMTjAYe4ufb6UEtHvpkpNDHFExoG6jnA
 H
X-Gm-Gg: ASbGnctWYk6uUPIhaDHy6MzAa81UKKcEMhS2dgcD3QBlS0aCv7LJmNTUZj2snfTi1ZU
 NO8NaPWIcGEeDB3nCsNydGj3heGriLLYXayjh82CZ/Zy8UvFJqkg0xXWQlm45NIdPBaGXmUetSx
 HBjoQBcf5xAHr/UBqbCnJNC/e7yJdOxCugPxu5TMaVjfIT3ma3/tJSPCeuvPxICa2whJ8KDPhbc
 dz9x5MAIKpyWPeQWM3Xe0nzY1Xg8oVNaQRnHf/ZjrjEeXCXMe/bOqWkuvGc1EtedEzlQzUsC2vt
 mAnWeh2R+JH8UKu9ChzrD6Lj48fAvfRz7VApilLkXLLeUw==
X-Google-Smtp-Source: AGHT+IGl0Gqq0pBTIETfxBuLeAggb2Za9C1q/NqnrcMnISLRUdenYkXIo7URAGT66UxAUMSjiNAkoQ==
X-Received: by 2002:a05:690c:4984:b0:6ef:79d1:2f69 with SMTP id
 00721157ae682-6fda314cf01mr109415667b3.31.1741271572413; 
 Thu, 06 Mar 2025 06:32:52 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a51748sm2774127b3.29.2025.03.06.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:32:51 -0800 (PST)
Date: Thu, 6 Mar 2025 08:32:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: hs@denx.de, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250306143249.GB2640854@bill-the-cat>
References: <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
 <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
 <20250227172001.GH2640854@bill-the-cat>
 <CAFLszTgsT2GKOOYwBp2YjFRsYtvVhkvOST7PtzgtXi3r=3jumA@mail.gmail.com>
 <9bb480f6-95df-10ae-3470-b8ef1aa6a027@denx.de>
 <CAFLszTgRnXRQvm0+AoN=WOBczmy6d1Z7Pscy7Qd1KLA4=x+P5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EElFMuJEQ1WVPX2t"
Content-Disposition: inline
In-Reply-To: <CAFLszTgRnXRQvm0+AoN=WOBczmy6d1Z7Pscy7Qd1KLA4=x+P5A@mail.gmail.com>
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


--EElFMuJEQ1WVPX2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 07:16:08AM -0700, Simon Glass wrote:
> Hi Heiko,
>=20
> On Thu, 27 Feb 2025 at 22:26, Heiko Schocher <hs@denx.de> wrote:
> >
> > Hi Simon,
> >
> > On 27.02.25 20:26, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 27 Feb 2025 at 10:20, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Thu, Feb 27, 2025 at 09:27:33AM -0700, Simon Glass wrote:
> > >>> Hi Tom,
> > >>>
> > >>> On Wed, 26 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com> wrote:
> > >>>>
> > >>>> On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrote:
> > >>>>> Hi Tom,
> > >>>>>
> > >>>>> On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > >>>>>>
> > >>>>>> On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> > >>>>>>> Hi Tom,
> > >>>>>>>
> > >>>>>>> On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com> wro=
te:
> > >>>>>>>>
> > >>>>>>>> On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> > >>>>>>>>> Hi Tom,
> > >>>>>>>>>
> > >>>>>>>>> On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.com> w=
rote:
> > >>>>>>>>>>
> > >>>>>>>>>> On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wrote:
> > >>>>>>>>>>> Hi Tom,
> > >>>>>>>>>>>
> > >>>>>>>>>>> On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.com>=
 wrote:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass wrot=
e:
> > >>>>>>>>>>>>> Hi Tom,
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulko.co=
m> wrote:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glass wr=
ote:
> > >>>>>>>>>>>>>>> Hi Tom,
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsulko.=
com> wrote:
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Glass =
wrote:
> > >>>>>>>>>>>>>>>>> Now that U-Boot can boot this quickly, using kvm, add=
 a test that the
> > >>>>>>>>>>>>>>>>> installer starts up correctly.
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> Use the qemu-x86_64 board in the SJG lab.
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>>>>>>>>>>>>>>> ---
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> Changes in v2:
> > >>>>>>>>>>>>>>>>> - Add more patches to support booting with kvm
> > >>>>>>>>>>>>>>>>> - Add new patch with a test for booting Ubuntu 24.04
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>>   .gitlab-ci.yml               |  5 ++++
> > >>>>>>>>>>>>>>>>>   test/py/tests/test_distro.py | 53 +++++++++++++++++=
+++++++++++++++++++
> > >>>>>>>>>>>>>>>>>   2 files changed, 58 insertions(+)
> > >>>>>>>>>>>>>>>>>   create mode 100644 test/py/tests/test_distro.py
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > >>>>>>>>>>>>>>>>> index 8c49d5b0a79..ec799e97c10 100644
> > >>>>>>>>>>>>>>>>> --- a/.gitlab-ci.yml
> > >>>>>>>>>>>>>>>>> +++ b/.gitlab-ci.yml
> > >>>>>>>>>>>>>>>>> @@ -745,3 +745,8 @@ zybo:
> > >>>>>>>>>>>>>>>>>     variables:
> > >>>>>>>>>>>>>>>>>       ROLE: zybo
> > >>>>>>>>>>>>>>>>>     <<: *lab_dfn
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +qemu-x86_64:
> > >>>>>>>>>>>>>>>>> +  variables:
> > >>>>>>>>>>>>>>>>> +    ROLE: qemu-x86_64
> > >>>>>>>>>>>>>>>>> +  <<: *lab_dfn
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> I'm not sure why this is in your lab stanza, rather th=
an the normal
> > >>>>>>>>>>>>>>>> test.py QEMU stanza.
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> Are you wanting to add the Ubuntu image into CI? It is =
quite large.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> If we're going to be able to run it on N platforms, yes,=
 we need to
> > >>>>>>>>>>>>>> think of a good way to cache the download. There's not a=
 particular
> > >>>>>>>>>>>>>> reason we can't run the stock Ubuntu RISC-V image on the=
 two sifive
> > >>>>>>>>>>>>>> targets and also qemu-riscv64, is there?
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Yes, we can do that. It is pretty simple to set up in Lab=
grid and it
> > >>>>>>>>>>>>> doesn't require all the runners to download a much larger=
 image, etc.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I don't quite understand why it's under "labgrid". These a=
re generic CI
> > >>>>>>>>>>>> tests. Now maybe we need to, in both Gitlab and Azure, add=
 some logic so
> > >>>>>>>>>>>> that certain longer or possibly destructive tests are only=
 run on tagged
> > >>>>>>>>>>>> releases or as requested rather than every time, as it wil=
l take longer.
> > >>>>>>>>>>>> But pretty much every platform under the qemu target list =
should be able
> > >>>>>>>>>>>> to Just Boot an off the shelf OS distribution is my point.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Sure, and I'm not suggesting we shouldn't do that as well.
> > >>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> diff --git a/test/py/tests/test_distro.py b/test/py/t=
ests/test_distro.py
> > >>>>>>>>>>>>>>>>> new file mode 100644
> > >>>>>>>>>>>>>>>>> index 00000000000..51eec45cecc
> > >>>>>>>>>>>>>>>>> --- /dev/null
> > >>>>>>>>>>>>>>>>> +++ b/test/py/tests/test_distro.py
> > >>>>>>>>>>>>>>>>> @@ -0,0 +1,53 @@
> > >>>>>>>>>>>>>>>>> +# SPDX-License-Identifier: GPL-2.0+
> > >>>>>>>>>>>>>>>>> +# Copyright 2025 Canonical Ltd.
> > >>>>>>>>>>>>>>>>> +# Written by Simon Glass <simon.glass@canonical.com>
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +import pytest
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +DOWN =3D '\x1b\x5b\x42\x0d'
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +# Enable early console so that the test can see if s=
omething goes wrong
> > >>>>>>>>>>>>>>>>> +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 console=3D=
uart8250,io,0x3f8'
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +@pytest.mark.boardspec('qemu-x86_64')
> > >>>>>>>>>>>>>>>>> +@pytest.mark.role('qemu-x86_64')
> > >>>>>>>>>>>>>>>>> +def test_distro(ubman):
> > >>>>>>>>>>>>>>>>> +    """Test that of-platdata can be generated and us=
ed in sandbox"""
> > >>>>>>>>>>>>>>>>> +    with ubman.log.section('boot'):
> > >>>>>>>>>>>>>>>>> +        ubman.run_command('boot', wait_for_prompt=3D=
False)
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Grub'):
> > >>>>>>>>>>>>>>>>> +        # Wait for grub to come up and offset a menu
> > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Try or Install Ubuntu'])
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Press 'e' to edit the command line
> > >>>>>>>>>>>>>>>>> +        ubman.run_command('e', wait_for_prompt=3DFal=
se, send_nl=3DFalse)
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Wait until we see the editor appear
> > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['/casper/initrd'])
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Go down to the 'linux' line
> > >>>>>>>>>>>>>>>>> +        ubman.send(DOWN * 3)
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Go to end of line
> > >>>>>>>>>>>>>>>>> +        ubman.ctrl('E')
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Backspace to remove 'quiet splash'
> > >>>>>>>>>>>>>>>>> +        ubman.send('\b' * len('quiet splash'))
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Send our noisy console
> > >>>>>>>>>>>>>>>>> +        ubman.send(CONSOLE)
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +        # Tell grub to boot
> > >>>>>>>>>>>>>>>>> +        ubman.ctrl('X')
> > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Booting a command list'])
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Linux'):
> > >>>>>>>>>>>>>>>>> +        # Linux should start immediately
> > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Linux version'])
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Ubuntu'):
> > >>>>>>>>>>>>>>>>> +        # Shortly later, we should see this banner
> > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Welcome to .*Ubuntu 24.04.1=
 LTS.*!'])
> > >>>>>>>>>>>>>>>>> +
> > >>>>>>>>>>>>>>>>> +    ubman.restart_uboot()
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> And this seems very inflexible. Please see
> > >>>>>>>>>>>>>>>> test/py/tests/test_net_boot.py for an example of how t=
o have this be
> > >>>>>>>>>>>>>>>> configurable and work on arbitrary platforms. What I a=
ssume is tricky is
> > >>>>>>>>>>>>>>>> that the "role" part here is where you have a special =
disk image being
> > >>>>>>>>>>>>>>>> passed. That too could be dealt with in u-boot-test-ho=
oks in a few ways,
> > >>>>>>>>>>>>>>>> and the images pre-fetched to the CI container. And if=
 this was
> > >>>>>>>>>>>>>>>> configurable similar to the example I noted above, it =
could check real
> > >>>>>>>>>>>>>>>> hardware too.
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> That wasn't the reaction I expected.
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> Yes, it is inflexible, but it is a starting point. Isn'=
t it better
> > >>>>>>>>>>>>>>> than what we have today?
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Is your inflexible boot an OS test better than the flexi=
ble boot an OS
> > >>>>>>>>>>>>>> test that we have today? No, it's not.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> I didn't even know about it, or perhaps I forgot.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I believe I mentioned it every time you've said we should =
have an OS
> > >>>>>>>>>>>> test, so yes, I guess you forgot.
> > >>>>>>>>>>>
> > >>>>>>>>>>> Well it was only added in May last year and it relies on bo=
ard config
> > >>>>>>>>>>> which I don't have...although I see that you have now poste=
d yours.
> > >>>>>>>>>>
> > >>>>>>>>>> Yes, it was added not quite a year ago, and is documented wi=
thin the
> > >>>>>>>>>> test, like most tests that rely on the real platform.
> > >>>>>>>>>>
> > >>>>>>>>>> And do we need better documentation for test? Yes.
> > >>>>>>>>>
> > >>>>>>>>> +1
> > >>>>>>>>>
> > >>>>>>>>> I'll note that I did my bit!
> > >>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>>>>> Perhaps this relates to getting the labgrid config publis=
hed and
> > >>>>>>>>>>>>> figuring out how to pass info from Labgrid to tests.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> I would like to generalise this test to work on at leas=
t one real
> > >>>>>>>>>>>>>>> board, preferably one that doesn't use grub.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> OK. The test we have today does that, if you check for t=
he "Welcome to
> > >>>>>>>>>>>>>> ..." string instead of the kernel has booted string. It =
also does
> > >>>>>>>>>>>>>> netboot rather than run default bootcmd. But that's an e=
asy enough test
> > >>>>>>>>>>>>>> to write up. The only thing stopping me from doing that =
right now is I
> > >>>>>>>>>>>>>> need to find a board in the lab where we installed an OS=
 to eMMC and not
> > >>>>>>>>>>>>>> SD card (some lab sd-mux issues).
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> OK. Labgrid has a 'features' thing which you can attach t=
o targets, so
> > >>>>>>>>>>>>> I should be able to use that to indicate that Ubuntu, Deb=
ian, Armbian,
> > >>>>>>>>>>>>> etc. are available.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> OK, but that sounds like the opposite direction. These are=
 generic tests
> > >>>>>>>>>>>> that can run in any / all of the labs, not just your labgr=
id
> > >>>>>>>>>>>> configuration. AMD has been contributing tests that run on=
 hardware for
> > >>>>>>>>>>>> example.
> > >>>>>>>>>>>
> > >>>>>>>>>>> That's great, the more tests we have the better. But those =
tests can't
> > >>>>>>>>>>> and don't run in CI, whereas mine can and do.
> > >>>>>>>>>>
> > >>>>>>>>>> AFAICT they're running on AMD's CI. They run on my CI. They =
don't run on
> > >>>>>>>>>> *your* lab because you took things, intentionally, in a dire=
ction to
> > >>>>>>>>>> minimize using u-boot-test-hooks and our existing per-board
> > >>>>>>>>>> configuration infrastructure.
> > >>>>>>>>>
> > >>>>>>>>> When I look at CI all I see is my lab. Which CI are you refer=
ring to
> > >>>>>>>>> and how can I access it?
> > >>>>>>>>
> > >>>>>>>> I'll point you at the notes for the first call we had recently:
> > >>>>>>>> https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-t=
he-cat/
> > >>>>>>>> and note that there are many labs doing testing on / with U-Bo=
ot.
> > >>>>>>>
> > >>>>>>> That's all good, but it isn't as good as having the lab in gitl=
ab.
> > >>>>>>
> > >>>>>> Strongly disagree. Especially since having it in the mainline gi=
tlab
> > >>>>>> isn't feasible.
> > >>>>>>
> > >>>>>>>>> Here I would like to make a case for moving to using Labgrid =
across
> > >>>>>>>>> the board, but unfortunately the project struggles to review =
PRs, so
> > >>>>>>>>> it's probably not a good idea.
> > >>>>>>>>
> > >>>>>>>> It would also be counter to the feedback from the U-Boot commu=
nity about
> > >>>>>>>> making it easier to contribute testing results from additional=
 labs.
> > >>>>>>>
> > >>>>>>> I really don't think the test hooks are a good setup, though. I=
t is
> > >>>>>>> OK-ish for small labs, but it is so fiddly to use that I wrote =
a tool
> > >>>>>>> (Labman) to deal with all the confusion.
> > >>>>>>
> > >>>>>> Yes, I don't know how hard you evaluated all of the then-current=
 lab
> > >>>>>> management tooling and wrote your own.
> > >>>>>>
> > >>>>>>> Labgrid (which you suggested I use for my lab, if you recall),
> > >>>>>>
> > >>>>>> Yes, and I think you forgot the aim was to make it easy to show =
all of
> > >>>>>> the existing Labgrid based labs that do Linux kernel testing the=
y could
> > >>>>>> easily add U-Boot to the mix. I've been trying to get feedback f=
rom
> > >>>>>> other people with existing labgrid setups to look at what you've=
 done.
> > >>>>>>
> > >>>>>>> provides for two yaml configuration files so that everything is=
 in one
> > >>>>>>> place. Apart from its primitive support for USB hubs, it is much
> > >>>>>>> easier to maintain that dozens of little files all over the pal=
ce.
> > >>>>>>
> > >>>>>> I mean, I looked at what you posted and strongly disagree, but I=
 think
> > >>>>>> both cases here are personal preference and not some sort of obj=
ective
> > >>>>>> and easily evaluated thing.
> > >>>>>>
> > >>>>>>>>>>> We need an 'all of the above' strategy here.
> > >>>>>>>>>>
> > >>>>>>>>>> Sure. But I still want to see things as reusable as possible=
=2E What you
> > >>>>>>>>>> have above is *extremely* board and OS specific and non-conf=
igurable.
> > >>>>>>>>>
> > >>>>>>>>> Yes, agreed.
> > >>>>>>>>>
> > >>>>>>>>>> I
> > >>>>>>>>>> also don't quite see why it's not a test of autoboot with the
> > >>>>>>>>>> pre-requisite of an OS being installed.
> > >>>>>>>>>
> > >>>>>>>>> Ah OK, my test is just for the installer itself. Both are use=
ful, but
> > >>>>>>>>> I hope eventually to have the installer run to completion and=
 then
> > >>>>>>>>> reboot to check all is well.
> > >>>>>>>>
> > >>>>>>>> In the spirit of "yes, and.."'ing tests, sure. Ilias pointed m=
e at some
> > >>>>>>>> testing Linaro has going now that automates I believe it was c=
urrent
> > >>>>>>>> Yocto and current U-Boot (+ the pmb patches that've been poste=
d) doing a
> > >>>>>>>> full install via network in CI. So yes, a Canonical lab might =
also find
> > >>>>>>>> it useful to end to end test installing Ubuntu. My own persona=
l dream is
> > >>>>>>>> that at least some of the existing kernelci labs see the utili=
ty in
> > >>>>>>>> adding "current U-Boot" as one of the matrix variables they te=
st and not
> > >>>>>>>> just "U-Boot as delivered by vendor" as a static part of the t=
esting.
> > >>>>>>>
> > >>>>>>> OK.
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>>>> BTW, having thought about how test/py works a bit, instead =
of the
> > >>>>>>>>>>> env__net_tftp_bootable_file stuff, we should have code or d=
ata which
> > >>>>>>>>>>> sets up the required test files (on a suitable server) befo=
re running
> > >>>>>>>>>>> the test. That way, all the test code is in one Python file=
 and we
> > >>>>>>>>>>> don't have to spend ages trying to divine what each test ne=
eds.
> > >>>>>>>>>>
> > >>>>>>>>>> That seems like a lot more work than documenting more what w=
e have
> > >>>>>>>>>> today, and I'm not sure of the benefit. Given the contents o=
f the pxe
> > >>>>>>>>>> test, yes, just having those files available to 'cp' in plac=
e would be
> > >>>>>>>>>> helpful. But that's not the case for booting a kernel (the F=
IT match
> > >>>>>>>>>> stuff doesn't work on the TI platforms atm). And if you look=
 at the
> > >>>>>>>>>> config I posted it also includes bootstage configuration. It=
 also won't
> > >>>>>>>>>> work well for the SPI tests, which I'm talking with Love abo=
ut in
> > >>>>>>>>>> another thread.
> > >>>>>>>>>
> > >>>>>>>>> Yes, perhaps, but having self-contained tests would be a win.
> > >>>>>>>>
> > >>>>>>>> With it's own set of technical and legal challenges / obligati=
ons and
> > >>>>>>>> difficulties depending on what you even mean by "self containe=
d". And
> > >>>>>>>> how often what's run where, and all sorts of other challenges =
too.
> > >>>>>>>>
> > >>>>>>>> Given the extreme depth that testing can go to, this is why I'=
m of the
> > >>>>>>>> position that we need to document things more and worry less a=
bout
> > >>>>>>>> prepackaged things. For example, making the documentation for =
the
> > >>>>>>>> current net based OS boot means that for bringing up a new boa=
rd the
> > >>>>>>>> developer can just drop something in. Whereas if the tests exp=
ect a
> > >>>>>>>> functional OS image that has to also be messed with and is its=
 own
> > >>>>>>>> challenge.
> > >>>>>>>
> > >>>>>>> Yes
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>>> In other words, the majority of py/<host>/u_boot_boardenv_ c=
ontent is
> > >>>>>>>>>> configuration details, specific to both the platform / SoC f=
irst, some
> > >>>>>>>>>> lab specific details second and drop-in existing 3rd party f=
iles a
> > >>>>>>>>>> distant third.
> > >>>>>>>>>
> > >>>>>>>>> I think the u-boot-test-hooks was an amazing solution 9 years=
 ago, but
> > >>>>>>>>> we have outgrown it. We want people to be able to connect the=
ir lab to
> > >>>>>>>>> CI (meaning gitlab), so testing is more automated.
> > >>>>>>>>
> > >>>>>>>> More and more public testing would be great. The notes I linke=
d above
> > >>>>>>>> explain one of the first problems there being that most compan=
ies will
> > >>>>>>>> not or can not hook a lab to a public CI instance.
> > >>>>>>>
> > >>>>>>> Well corporate IT is what it is.
> > >>>>>>>
> > >>>>>>> That means that their boards will not be testing in CI, unless =
they do
> > >>>>>>> it themselves, right?
> > >>>>>>
> > >>>>>> I'm not sure what you mean here. It's a solved problem for them =
(monitor
> > >>>>>> tree at URL) and something that's been being done since the begi=
nning
> > >>>>>> even for U-Boot (it's how the original nvidia lab worked).
> > >>>>>>
> > >>>>>>>> The next problem, as
> > >>>>>>>> both of our personal labs show, is that just maintaining the p=
hysical
> > >>>>>>>> lab takes time and resources. I've added Heiko here because I'=
ve been
> > >>>>>>>> talking with him off-list about expanding tbot coverage and pl=
umbing
> > >>>>>>>> that in to gitlab.
> > >>>>>>>
> > >>>>>>> OK
> > >>>>>>>
> > >>>>>>>>
> > >>>>>>>>> We should move away from relying on maintainers getting aroun=
d to
> > >>>>>>>>> testing patches months after they are sent, when they have ti=
me, but
> > >>>>>>>>> they don't. Things need to be more automated and I'd encourag=
e you to
> > >>>>>>>>> push this as well.
> > >>>>>>>>
> > >>>>>>>> I have been, and the results I've gotten are that companies ar=
e testing
> > >>>>>>>> things internally but there's not any good way to publish resu=
lts, and
> > >>>>>>>> that's the kind of framework we're entirely missing.
> > >>>>>>>
> > >>>>>>> If you like, but from my side, I like to see the results in git=
lab.
> > >>>>>>
> > >>>>>> Depends on what you mean by gitlab. I assume you mean "triggered=
 by a
> > >>>>>> push and visible in the main pipeline". Which isn't possible. It=
's not
> > >>>>>> going to happen. External collection is how it's handled for the=
 linux
> > >>>>>> kernel and that community has far more sway than we do. If we ri=
de their
> > >>>>>> coattails here so to speak, we can get results. If we push for s=
omething
> > >>>>>> completely different we aren't likely to have success.
> > >>>>>>
> > >>>>>>>> Which is another part of why I keep pushing against having U-B=
oot
> > >>>>>>>> configuration stuff inside of Labgrid as it makes it harder fo=
r any lab
> > >>>>>>>> that's not using labgrid to see how to configure things.
> > >>>>>>>
> > >>>>>>> Well, as you requested, I looked at Labgrid and now my lab uses=
 it. I
> > >>>>>>> am happy to publish the config[1], but I still hold my view tha=
t all
> > >>>>>>> the shell scripts in u-boot-test-hooks are limiting and painful=
 to
> > >>>>>>> work with.
> > >>>>>>
> > >>>>>> Yes, and as I've shown, you can also use labgrid without going d=
own the
> > >>>>>> same path you took, and we can also support other lab management=
 methods
> > >>>>>> too, which is important to get as much testing as possible witho=
ut
> > >>>>>> needing to centralize everything.
> > >>>>>
> > >>>>> In summary, I suppose we just have different visions and ideas, w=
hich
> > >>>>> should be a good thing.
> > >>>>
> > >>>> So long as the project can speak with one voice, yes. Which all ci=
rcles
> > >>>> back to why I do not think what you're doing with u-boot.org is at=
 all
> > >>>> helpful.
> > >>>
> > >>> I do need a relief valve for when my efforts are blocked.
> > >>
> > >> And I do not see how using the project domain is appropriate. Stop d=
oing
> > >> this. If you can't stop I'm going to reach my own limit here.
> > >
> > > I'm happy to have source.u-boot.org or similar point to Denx, but I do
> > > need my own tree while my work is blocked from submission. I suggest
> > > we discuss it on a call and try to figure out a compromise while we
> > > are in this state.
> >
> > Isn;t it possible to add a repo at source.denx.de ? Like u-boot-sjg ?
> >
> > or u-boot-ci ?
>=20
> I don't have permission to do that. With my tree I am able to have CI
> running in half the time, use my full lab (not just the subset Tom's
> tree has), push patches and ideas that others have blocked, point
> people to my work, etc. It is a much better environment for me to
> continue (what I see as) necessary innovation.
>=20
> That said, if you wish to add a top-level project for me, then I would
> push things to it, yes.

To be clear, you can have
https://source.denx.de/u-boot/contributors/sjg/ but you can't host your
downstream fork on source.denx.de itself and I wish you wouldn't abuse
the project domain for it either.

--=20
Tom

--EElFMuJEQ1WVPX2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJshEACgkQFHw5/5Y0
tywzUAv/aheXCDzC9Pp3/0bca4nZzkEYF+bnmHAFY5sqmUKzBxFU0Vqe8bmPHIji
UsEr8HMs2VPAtxRmBQRQIdpIK9T0wIaPx28WTCmuI+LHEQklaBFtOZN4gwY8jmjz
oVZ5hSHQDxMBr0ex3UizbRUINjJvMOUaeE2InbDSM3xPF2a2wbcv7HR4mqJuBO6F
hES5xysWmbSiJShCCI8HCTu0K+n6YGu7hRXs0XIbkJ9pHMOOCMRSUUnUQfmsGn3L
8uTii7znqO0nnU3lteBQpZ0N1yCGVzI7Sm0+7Trwbl1d9pqeQwQzTirDOjyQ2lcz
luomoxtAj+Kko6X1FixhENXhKOlSPdTdDyROon5dxoR8MsaHnfJBHpKazF+l/9ru
4kpheAvf15vE8sbjrgiIm8BUyHGS/AIT3CiIvskv1cVeBE900NGMAaKeZI6/U1pz
xfXdIh5V0dZPxZRIVH7qk/fbtbFn9t2BGt3Spyhv69KwuDNlTx+wTYcIWXKDm0kB
0ALtctJL
=O2qm
-----END PGP SIGNATURE-----

--EElFMuJEQ1WVPX2t--
