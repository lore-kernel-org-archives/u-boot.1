Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8520C282DE
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 15:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09B9803CC;
	Fri,  7 Mar 2025 16:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nbCwoulq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038CA803CC; Fri,  7 Mar 2025 16:35:09 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725E981335
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 16:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so1807223276.3
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 07:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741361700; x=1741966500; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f9CjBqnhqLe/VUsx3dBpsIQDyoDzDR3dIO1ybnaj14I=;
 b=nbCwoulqA6XTXYoAjkss56PkVSfIO0G8vz+7K1+DF+OLpwxhyJHTE5KjXTbDQU82VT
 wtRD/RzAbxHun4Ix/4HFo1kTliZ8pBjb6Stwp2LRmpjQzuLDKtEjYYPscIjcMuvB33T2
 R9twAZ1xYTr0pti+WU0rurLh0VVF/LQNk5n24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741361700; x=1741966500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9CjBqnhqLe/VUsx3dBpsIQDyoDzDR3dIO1ybnaj14I=;
 b=mNsTzGhA5hj4r8cA1sGOSZYVtZdRw6a6uUL/fbeuvdY8ALkprZB9a9UhQ+GajWlvAg
 DHV0jauK5VgQsCX5/+jOGpz5tJ51KHtQyUfrov08ERrNFxjnps54KzEVLbzEyGf6DZ9e
 cKUCfrvpT7MCxurSDtgW94ldP5aG6J+XXLPkVze7Btf7t1anCle7XxAYNncnZ2XZiRtO
 1HUuATNPn71vxpRkns69VlaeDrlayjaKS0tkdSB3u15mfx4faYR3/wUBDfyUV3Nw/O0n
 ociISAdXIIoVwi3hvJu3WQcnCKerL0bqoGULqYnsgAXxdVeECL0v5+YrOFvgolI3gsVc
 BTfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBMEfPoaieSXCPgDWYXLCDjtdYKX0s0dy18lnNM1GK9r9UmyqN70wiX63D2aXLEGmLoW3Zq1Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzLAuQrlc3ft5Y8vHN2kbnVkP5/fu+1wFafiktZzXhZbFjgVXE2
 cDBk8J0iGwv9SLjG8Pq/hKY/X9M3n61i0ycuDUrFJXcGff5ioYM7m3ayWUvfPHM=
X-Gm-Gg: ASbGnctcqSaB/bJR4M6TlESZvAdyGrqUPFtkX4EAkOc4miOxX09VvTz4JWs9BKU0yri
 MqKmkIP7v06dWDEH0MiR6+uwci/SGW+zi44CxVucMde7RXKehFPndT10BWOVxqvcUXlFHmpzHIw
 l9EIiYTM2oAPWYGWq+U6dZo8ky5gDm57f2mBgtAG7ZZMcM7SS7u6IqtndFcaYAFPs1qVsyn4ZIP
 C/WFP5O8+Ptf2CDqoNDWtgF1ugRtzCXQJTl6Mu6iSTZdDhgOPEVp3tfxE860HRG2LO4mtW8tVil
 LHK9PeV4qWw0LIV3oZ64s4odbULQ0FMzZHKgjl8WuP9EDQ==
X-Google-Smtp-Source: AGHT+IFx/fV84wxUhx1uPmSo8KqCJoGol7DRdou7j5Ej4PL7bIMbIBGh9Nbxk44pZGGegowpUzL4oA==
X-Received: by 2002:a05:6902:250b:b0:e5b:3273:a36a with SMTP id
 3f1490d57ef6-e635c144d2emr4778216276.13.1741361698205; 
 Fri, 07 Mar 2025 07:34:58 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b8e8ed8sm872491276.37.2025.03.07.07.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:34:57 -0800 (PST)
Date: Fri, 7 Mar 2025 09:34:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: hs@denx.de, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250307153454.GO2640854@bill-the-cat>
References: <20250226143541.GI2640854@bill-the-cat>
 <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
 <20250227172001.GH2640854@bill-the-cat>
 <CAFLszTgsT2GKOOYwBp2YjFRsYtvVhkvOST7PtzgtXi3r=3jumA@mail.gmail.com>
 <9bb480f6-95df-10ae-3470-b8ef1aa6a027@denx.de>
 <CAFLszTgRnXRQvm0+AoN=WOBczmy6d1Z7Pscy7Qd1KLA4=x+P5A@mail.gmail.com>
 <20250306143249.GB2640854@bill-the-cat>
 <CAFLszTivk-j2vZrHYveXAhfxgaXiGpmNf40BR33H80aKodyaFA@mail.gmail.com>
 <20250306164322.GF2640854@bill-the-cat>
 <CAFLszTjCK-+A2=_n4zZxz1=24tVMrCc9ddA=5-yw_V6-Lo+eTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pi2Wj/inCIQD5mKH"
Content-Disposition: inline
In-Reply-To: <CAFLszTjCK-+A2=_n4zZxz1=24tVMrCc9ddA=5-yw_V6-Lo+eTw@mail.gmail.com>
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


--Pi2Wj/inCIQD5mKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 04:31:14PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Mar 2025 at 09:43, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:11:28AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 6 Mar 2025 at 07:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Mar 06, 2025 at 07:16:08AM -0700, Simon Glass wrote:
> > > > > Hi Heiko,
> > > > >
> > > > > On Thu, 27 Feb 2025 at 22:26, Heiko Schocher <hs@denx.de> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On 27.02.25 20:26, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 27 Feb 2025 at 10:20, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > >>
> > > > > > >> On Thu, Feb 27, 2025 at 09:27:33AM -0700, Simon Glass wrote:
> > > > > > >>> Hi Tom,
> > > > > > >>>
> > > > > > >>> On Wed, 26 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > >>>>
> > > > > > >>>> On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrot=
e:
> > > > > > >>>>> Hi Tom,
> > > > > > >>>>>
> > > > > > >>>>> On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > >>>>>>
> > > > > > >>>>>> On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wr=
ote:
> > > > > > >>>>>>> Hi Tom,
> > > > > > >>>>>>>
> > > > > > >>>>>>> On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass =
wrote:
> > > > > > >>>>>>>>> Hi Tom,
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glas=
s wrote:
> > > > > > >>>>>>>>>>> Hi Tom,
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Gl=
ass wrote:
> > > > > > >>>>>>>>>>>>> Hi Tom,
> > > > > > >>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>> On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > >>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon =
Glass wrote:
> > > > > > >>>>>>>>>>>>>>> Hi Tom,
> > > > > > >>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>> On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > > >>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>> On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simo=
n Glass wrote:
> > > > > > >>>>>>>>>>>>>>>>> Now that U-Boot can boot this quickly, using =
kvm, add a test that the
> > > > > > >>>>>>>>>>>>>>>>> installer starts up correctly.
> > > > > > >>>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>> Use the qemu-x86_64 board in the SJG lab.
> > > > > > >>>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >>>>>>>>>>>>>>>>> ---
> > > > > > >>>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>> Changes in v2:
> > > > > > >>>>>>>>>>>>>>>>> - Add more patches to support booting with kvm
> > > > > > >>>>>>>>>>>>>>>>> - Add new patch with a test for booting Ubunt=
u 24.04
> > > > > > >>>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>>   .gitlab-ci.yml               |  5 ++++
> > > > > > >>>>>>>>>>>>>>>>>   test/py/tests/test_distro.py | 53 +++++++++=
+++++++++++++++++++++++++++
> > > > > > >>>>>>>>>>>>>>>>>   2 files changed, 58 insertions(+)
> > > > > > >>>>>>>>>>>>>>>>>   create mode 100644 test/py/tests/test_distr=
o.py
> > > > > > >>>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > >>>>>>>>>>>>>>>>> index 8c49d5b0a79..ec799e97c10 100644
> > > > > > >>>>>>>>>>>>>>>>> --- a/.gitlab-ci.yml
> > > > > > >>>>>>>>>>>>>>>>> +++ b/.gitlab-ci.yml
> > > > > > >>>>>>>>>>>>>>>>> @@ -745,3 +745,8 @@ zybo:
> > > > > > >>>>>>>>>>>>>>>>>     variables:
> > > > > > >>>>>>>>>>>>>>>>>       ROLE: zybo
> > > > > > >>>>>>>>>>>>>>>>>     <<: *lab_dfn
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +qemu-x86_64:
> > > > > > >>>>>>>>>>>>>>>>> +  variables:
> > > > > > >>>>>>>>>>>>>>>>> +    ROLE: qemu-x86_64
> > > > > > >>>>>>>>>>>>>>>>> +  <<: *lab_dfn
> > > > > > >>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>> I'm not sure why this is in your lab stanza, r=
ather than the normal
> > > > > > >>>>>>>>>>>>>>>> test.py QEMU stanza.
> > > > > > >>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>> Are you wanting to add the Ubuntu image into CI=
? It is quite large.
> > > > > > >>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>> If we're going to be able to run it on N platfor=
ms, yes, we need to
> > > > > > >>>>>>>>>>>>>> think of a good way to cache the download. There=
's not a particular
> > > > > > >>>>>>>>>>>>>> reason we can't run the stock Ubuntu RISC-V imag=
e on the two sifive
> > > > > > >>>>>>>>>>>>>> targets and also qemu-riscv64, is there?
> > > > > > >>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>> Yes, we can do that. It is pretty simple to set u=
p in Labgrid and it
> > > > > > >>>>>>>>>>>>> doesn't require all the runners to download a muc=
h larger image, etc.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> I don't quite understand why it's under "labgrid".=
 These are generic CI
> > > > > > >>>>>>>>>>>> tests. Now maybe we need to, in both Gitlab and Az=
ure, add some logic so
> > > > > > >>>>>>>>>>>> that certain longer or possibly destructive tests =
are only run on tagged
> > > > > > >>>>>>>>>>>> releases or as requested rather than every time, a=
s it will take longer.
> > > > > > >>>>>>>>>>>> But pretty much every platform under the qemu targ=
et list should be able
> > > > > > >>>>>>>>>>>> to Just Boot an off the shelf OS distribution is m=
y point.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> Sure, and I'm not suggesting we shouldn't do that a=
s well.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>>> diff --git a/test/py/tests/test_distro.py b/t=
est/py/tests/test_distro.py
> > > > > > >>>>>>>>>>>>>>>>> new file mode 100644
> > > > > > >>>>>>>>>>>>>>>>> index 00000000000..51eec45cecc
> > > > > > >>>>>>>>>>>>>>>>> --- /dev/null
> > > > > > >>>>>>>>>>>>>>>>> +++ b/test/py/tests/test_distro.py
> > > > > > >>>>>>>>>>>>>>>>> @@ -0,0 +1,53 @@
> > > > > > >>>>>>>>>>>>>>>>> +# SPDX-License-Identifier: GPL-2.0+
> > > > > > >>>>>>>>>>>>>>>>> +# Copyright 2025 Canonical Ltd.
> > > > > > >>>>>>>>>>>>>>>>> +# Written by Simon Glass <simon.glass@canoni=
cal.com>
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +import pytest
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +# Enable early console so that the test can =
see if something goes wrong
> > > > > > >>>>>>>>>>>>>>>>> +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 co=
nsole=3Duart8250,io,0x3f8'
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > >>>>>>>>>>>>>>>>> +@pytest.mark.role('qemu-x86_64')
> > > > > > >>>>>>>>>>>>>>>>> +def test_distro(ubman):
> > > > > > >>>>>>>>>>>>>>>>> +    """Test that of-platdata can be generate=
d and used in sandbox"""
> > > > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('boot'):
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.run_command('boot', wait_for_p=
rompt=3DFalse)
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Grub'):
> > > > > > >>>>>>>>>>>>>>>>> +        # Wait for grub to come up and offse=
t a menu
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Try or Install Ubun=
tu'])
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Press 'e' to edit the command line
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.run_command('e', wait_for_prom=
pt=3DFalse, send_nl=3DFalse)
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Wait until we see the editor appear
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['/casper/initrd'])
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Go down to the 'linux' line
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.send(DOWN * 3)
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Go to end of line
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.ctrl('E')
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Backspace to remove 'quiet splash'
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.send('\b' * len('quiet splash'=
))
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Send our noisy console
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.send(CONSOLE)
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +        # Tell grub to boot
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.ctrl('X')
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Booting a command l=
ist'])
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Linux'):
> > > > > > >>>>>>>>>>>>>>>>> +        # Linux should start immediately
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Linux version'])
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Ubuntu'):
> > > > > > >>>>>>>>>>>>>>>>> +        # Shortly later, we should see this =
banner
> > > > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Welcome to .*Ubuntu=
 24.04.1 LTS.*!'])
> > > > > > >>>>>>>>>>>>>>>>> +
> > > > > > >>>>>>>>>>>>>>>>> +    ubman.restart_uboot()
> > > > > > >>>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>>> And this seems very inflexible. Please see
> > > > > > >>>>>>>>>>>>>>>> test/py/tests/test_net_boot.py for an example =
of how to have this be
> > > > > > >>>>>>>>>>>>>>>> configurable and work on arbitrary platforms. =
What I assume is tricky is
> > > > > > >>>>>>>>>>>>>>>> that the "role" part here is where you have a =
special disk image being
> > > > > > >>>>>>>>>>>>>>>> passed. That too could be dealt with in u-boot=
-test-hooks in a few ways,
> > > > > > >>>>>>>>>>>>>>>> and the images pre-fetched to the CI container=
=2E And if this was
> > > > > > >>>>>>>>>>>>>>>> configurable similar to the example I noted ab=
ove, it could check real
> > > > > > >>>>>>>>>>>>>>>> hardware too.
> > > > > > >>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>> That wasn't the reaction I expected.
> > > > > > >>>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>> Yes, it is inflexible, but it is a starting poi=
nt. Isn't it better
> > > > > > >>>>>>>>>>>>>>> than what we have today?
> > > > > > >>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>> Is your inflexible boot an OS test better than t=
he flexible boot an OS
> > > > > > >>>>>>>>>>>>>> test that we have today? No, it's not.
> > > > > > >>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>> I didn't even know about it, or perhaps I forgot.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> I believe I mentioned it every time you've said we=
 should have an OS
> > > > > > >>>>>>>>>>>> test, so yes, I guess you forgot.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> Well it was only added in May last year and it reli=
es on board config
> > > > > > >>>>>>>>>>> which I don't have...although I see that you have n=
ow posted yours.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> Yes, it was added not quite a year ago, and is docum=
ented within the
> > > > > > >>>>>>>>>> test, like most tests that rely on the real platform.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> And do we need better documentation for test? Yes.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> +1
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> I'll note that I did my bit!
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>>>>> Perhaps this relates to getting the labgrid confi=
g published and
> > > > > > >>>>>>>>>>>>> figuring out how to pass info from Labgrid to tes=
ts.
> > > > > > >>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>>> I would like to generalise this test to work on=
 at least one real
> > > > > > >>>>>>>>>>>>>>> board, preferably one that doesn't use grub.
> > > > > > >>>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>>> OK. The test we have today does that, if you che=
ck for the "Welcome to
> > > > > > >>>>>>>>>>>>>> ..." string instead of the kernel has booted str=
ing. It also does
> > > > > > >>>>>>>>>>>>>> netboot rather than run default bootcmd. But tha=
t's an easy enough test
> > > > > > >>>>>>>>>>>>>> to write up. The only thing stopping me from doi=
ng that right now is I
> > > > > > >>>>>>>>>>>>>> need to find a board in the lab where we install=
ed an OS to eMMC and not
> > > > > > >>>>>>>>>>>>>> SD card (some lab sd-mux issues).
> > > > > > >>>>>>>>>>>>>
> > > > > > >>>>>>>>>>>>> OK. Labgrid has a 'features' thing which you can =
attach to targets, so
> > > > > > >>>>>>>>>>>>> I should be able to use that to indicate that Ubu=
ntu, Debian, Armbian,
> > > > > > >>>>>>>>>>>>> etc. are available.
> > > > > > >>>>>>>>>>>>
> > > > > > >>>>>>>>>>>> OK, but that sounds like the opposite direction. T=
hese are generic tests
> > > > > > >>>>>>>>>>>> that can run in any / all of the labs, not just yo=
ur labgrid
> > > > > > >>>>>>>>>>>> configuration. AMD has been contributing tests tha=
t run on hardware for
> > > > > > >>>>>>>>>>>> example.
> > > > > > >>>>>>>>>>>
> > > > > > >>>>>>>>>>> That's great, the more tests we have the better. Bu=
t those tests can't
> > > > > > >>>>>>>>>>> and don't run in CI, whereas mine can and do.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> AFAICT they're running on AMD's CI. They run on my C=
I. They don't run on
> > > > > > >>>>>>>>>> *your* lab because you took things, intentionally, i=
n a direction to
> > > > > > >>>>>>>>>> minimize using u-boot-test-hooks and our existing pe=
r-board
> > > > > > >>>>>>>>>> configuration infrastructure.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> When I look at CI all I see is my lab. Which CI are y=
ou referring to
> > > > > > >>>>>>>>> and how can I access it?
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> I'll point you at the notes for the first call we had =
recently:
> > > > > > >>>>>>>> https://lore.kernel.org/u-boot/20250128171923.GQ123356=
8@bill-the-cat/
> > > > > > >>>>>>>> and note that there are many labs doing testing on / w=
ith U-Boot.
> > > > > > >>>>>>>
> > > > > > >>>>>>> That's all good, but it isn't as good as having the lab=
 in gitlab.
> > > > > > >>>>>>
> > > > > > >>>>>> Strongly disagree. Especially since having it in the mai=
nline gitlab
> > > > > > >>>>>> isn't feasible.
> > > > > > >>>>>>
> > > > > > >>>>>>>>> Here I would like to make a case for moving to using =
Labgrid across
> > > > > > >>>>>>>>> the board, but unfortunately the project struggles to=
 review PRs, so
> > > > > > >>>>>>>>> it's probably not a good idea.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> It would also be counter to the feedback from the U-Bo=
ot community about
> > > > > > >>>>>>>> making it easier to contribute testing results from ad=
ditional labs.
> > > > > > >>>>>>>
> > > > > > >>>>>>> I really don't think the test hooks are a good setup, t=
hough. It is
> > > > > > >>>>>>> OK-ish for small labs, but it is so fiddly to use that =
I wrote a tool
> > > > > > >>>>>>> (Labman) to deal with all the confusion.
> > > > > > >>>>>>
> > > > > > >>>>>> Yes, I don't know how hard you evaluated all of the then=
-current lab
> > > > > > >>>>>> management tooling and wrote your own.
> > > > > > >>>>>>
> > > > > > >>>>>>> Labgrid (which you suggested I use for my lab, if you r=
ecall),
> > > > > > >>>>>>
> > > > > > >>>>>> Yes, and I think you forgot the aim was to make it easy =
to show all of
> > > > > > >>>>>> the existing Labgrid based labs that do Linux kernel tes=
ting they could
> > > > > > >>>>>> easily add U-Boot to the mix. I've been trying to get fe=
edback from
> > > > > > >>>>>> other people with existing labgrid setups to look at wha=
t you've done.
> > > > > > >>>>>>
> > > > > > >>>>>>> provides for two yaml configuration files so that every=
thing is in one
> > > > > > >>>>>>> place. Apart from its primitive support for USB hubs, i=
t is much
> > > > > > >>>>>>> easier to maintain that dozens of little files all over=
 the palce.
> > > > > > >>>>>>
> > > > > > >>>>>> I mean, I looked at what you posted and strongly disagre=
e, but I think
> > > > > > >>>>>> both cases here are personal preference and not some sor=
t of objective
> > > > > > >>>>>> and easily evaluated thing.
> > > > > > >>>>>>
> > > > > > >>>>>>>>>>> We need an 'all of the above' strategy here.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> Sure. But I still want to see things as reusable as =
possible. What you
> > > > > > >>>>>>>>>> have above is *extremely* board and OS specific and =
non-configurable.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Yes, agreed.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>>> I
> > > > > > >>>>>>>>>> also don't quite see why it's not a test of autoboot=
 with the
> > > > > > >>>>>>>>>> pre-requisite of an OS being installed.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Ah OK, my test is just for the installer itself. Both=
 are useful, but
> > > > > > >>>>>>>>> I hope eventually to have the installer run to comple=
tion and then
> > > > > > >>>>>>>>> reboot to check all is well.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> In the spirit of "yes, and.."'ing tests, sure. Ilias p=
ointed me at some
> > > > > > >>>>>>>> testing Linaro has going now that automates I believe =
it was current
> > > > > > >>>>>>>> Yocto and current U-Boot (+ the pmb patches that've be=
en posted) doing a
> > > > > > >>>>>>>> full install via network in CI. So yes, a Canonical la=
b might also find
> > > > > > >>>>>>>> it useful to end to end test installing Ubuntu. My own=
 personal dream is
> > > > > > >>>>>>>> that at least some of the existing kernelci labs see t=
he utility in
> > > > > > >>>>>>>> adding "current U-Boot" as one of the matrix variables=
 they test and not
> > > > > > >>>>>>>> just "U-Boot as delivered by vendor" as a static part =
of the testing.
> > > > > > >>>>>>>
> > > > > > >>>>>>> OK.
> > > > > > >>>>>>>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>>>> BTW, having thought about how test/py works a bit, =
instead of the
> > > > > > >>>>>>>>>>> env__net_tftp_bootable_file stuff, we should have c=
ode or data which
> > > > > > >>>>>>>>>>> sets up the required test files (on a suitable serv=
er) before running
> > > > > > >>>>>>>>>>> the test. That way, all the test code is in one Pyt=
hon file and we
> > > > > > >>>>>>>>>>> don't have to spend ages trying to divine what each=
 test needs.
> > > > > > >>>>>>>>>>
> > > > > > >>>>>>>>>> That seems like a lot more work than documenting mor=
e what we have
> > > > > > >>>>>>>>>> today, and I'm not sure of the benefit. Given the co=
ntents of the pxe
> > > > > > >>>>>>>>>> test, yes, just having those files available to 'cp'=
 in place would be
> > > > > > >>>>>>>>>> helpful. But that's not the case for booting a kerne=
l (the FIT match
> > > > > > >>>>>>>>>> stuff doesn't work on the TI platforms atm). And if =
you look at the
> > > > > > >>>>>>>>>> config I posted it also includes bootstage configura=
tion. It also won't
> > > > > > >>>>>>>>>> work well for the SPI tests, which I'm talking with =
Love about in
> > > > > > >>>>>>>>>> another thread.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> Yes, perhaps, but having self-contained tests would b=
e a win.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> With it's own set of technical and legal challenges / =
obligations and
> > > > > > >>>>>>>> difficulties depending on what you even mean by "self =
contained". And
> > > > > > >>>>>>>> how often what's run where, and all sorts of other cha=
llenges too.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> Given the extreme depth that testing can go to, this i=
s why I'm of the
> > > > > > >>>>>>>> position that we need to document things more and worr=
y less about
> > > > > > >>>>>>>> prepackaged things. For example, making the documentat=
ion for the
> > > > > > >>>>>>>> current net based OS boot means that for bringing up a=
 new board the
> > > > > > >>>>>>>> developer can just drop something in. Whereas if the t=
ests expect a
> > > > > > >>>>>>>> functional OS image that has to also be messed with an=
d is its own
> > > > > > >>>>>>>> challenge.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Yes
> > > > > > >>>>>>>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>>> In other words, the majority of py/<host>/u_boot_boa=
rdenv_ content is
> > > > > > >>>>>>>>>> configuration details, specific to both the platform=
 / SoC first, some
> > > > > > >>>>>>>>>> lab specific details second and drop-in existing 3rd=
 party files a
> > > > > > >>>>>>>>>> distant third.
> > > > > > >>>>>>>>>
> > > > > > >>>>>>>>> I think the u-boot-test-hooks was an amazing solution=
 9 years ago, but
> > > > > > >>>>>>>>> we have outgrown it. We want people to be able to con=
nect their lab to
> > > > > > >>>>>>>>> CI (meaning gitlab), so testing is more automated.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> More and more public testing would be great. The notes=
 I linked above
> > > > > > >>>>>>>> explain one of the first problems there being that mos=
t companies will
> > > > > > >>>>>>>> not or can not hook a lab to a public CI instance.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Well corporate IT is what it is.
> > > > > > >>>>>>>
> > > > > > >>>>>>> That means that their boards will not be testing in CI,=
 unless they do
> > > > > > >>>>>>> it themselves, right?
> > > > > > >>>>>>
> > > > > > >>>>>> I'm not sure what you mean here. It's a solved problem f=
or them (monitor
> > > > > > >>>>>> tree at URL) and something that's been being done since =
the beginning
> > > > > > >>>>>> even for U-Boot (it's how the original nvidia lab worked=
).
> > > > > > >>>>>>
> > > > > > >>>>>>>> The next problem, as
> > > > > > >>>>>>>> both of our personal labs show, is that just maintaini=
ng the physical
> > > > > > >>>>>>>> lab takes time and resources. I've added Heiko here be=
cause I've been
> > > > > > >>>>>>>> talking with him off-list about expanding tbot coverag=
e and plumbing
> > > > > > >>>>>>>> that in to gitlab.
> > > > > > >>>>>>>
> > > > > > >>>>>>> OK
> > > > > > >>>>>>>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>>> We should move away from relying on maintainers getti=
ng around to
> > > > > > >>>>>>>>> testing patches months after they are sent, when they=
 have time, but
> > > > > > >>>>>>>>> they don't. Things need to be more automated and I'd =
encourage you to
> > > > > > >>>>>>>>> push this as well.
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> I have been, and the results I've gotten are that comp=
anies are testing
> > > > > > >>>>>>>> things internally but there's not any good way to publ=
ish results, and
> > > > > > >>>>>>>> that's the kind of framework we're entirely missing.
> > > > > > >>>>>>>
> > > > > > >>>>>>> If you like, but from my side, I like to see the result=
s in gitlab.
> > > > > > >>>>>>
> > > > > > >>>>>> Depends on what you mean by gitlab. I assume you mean "t=
riggered by a
> > > > > > >>>>>> push and visible in the main pipeline". Which isn't poss=
ible. It's not
> > > > > > >>>>>> going to happen. External collection is how it's handled=
 for the linux
> > > > > > >>>>>> kernel and that community has far more sway than we do. =
If we ride their
> > > > > > >>>>>> coattails here so to speak, we can get results. If we pu=
sh for something
> > > > > > >>>>>> completely different we aren't likely to have success.
> > > > > > >>>>>>
> > > > > > >>>>>>>> Which is another part of why I keep pushing against ha=
ving U-Boot
> > > > > > >>>>>>>> configuration stuff inside of Labgrid as it makes it h=
arder for any lab
> > > > > > >>>>>>>> that's not using labgrid to see how to configure thing=
s.
> > > > > > >>>>>>>
> > > > > > >>>>>>> Well, as you requested, I looked at Labgrid and now my =
lab uses it. I
> > > > > > >>>>>>> am happy to publish the config[1], but I still hold my =
view that all
> > > > > > >>>>>>> the shell scripts in u-boot-test-hooks are limiting and=
 painful to
> > > > > > >>>>>>> work with.
> > > > > > >>>>>>
> > > > > > >>>>>> Yes, and as I've shown, you can also use labgrid without=
 going down the
> > > > > > >>>>>> same path you took, and we can also support other lab ma=
nagement methods
> > > > > > >>>>>> too, which is important to get as much testing as possib=
le without
> > > > > > >>>>>> needing to centralize everything.
> > > > > > >>>>>
> > > > > > >>>>> In summary, I suppose we just have different visions and =
ideas, which
> > > > > > >>>>> should be a good thing.
> > > > > > >>>>
> > > > > > >>>> So long as the project can speak with one voice, yes. Whic=
h all circles
> > > > > > >>>> back to why I do not think what you're doing with u-boot.o=
rg is at all
> > > > > > >>>> helpful.
> > > > > > >>>
> > > > > > >>> I do need a relief valve for when my efforts are blocked.
> > > > > > >>
> > > > > > >> And I do not see how using the project domain is appropriate=
=2E Stop doing
> > > > > > >> this. If you can't stop I'm going to reach my own limit here.
> > > > > > >
> > > > > > > I'm happy to have source.u-boot.org or similar point to Denx,=
 but I do
> > > > > > > need my own tree while my work is blocked from submission. I =
suggest
> > > > > > > we discuss it on a call and try to figure out a compromise wh=
ile we
> > > > > > > are in this state.
> > > > > >
> > > > > > Isn;t it possible to add a repo at source.denx.de ? Like u-boot=
-sjg ?
> > > > > >
> > > > > > or u-boot-ci ?
> > > > >
> > > > > I don't have permission to do that. With my tree I am able to hav=
e CI
> > > > > running in half the time, use my full lab (not just the subset To=
m's
> > > > > tree has), push patches and ideas that others have blocked, point
> > > > > people to my work, etc. It is a much better environment for me to
> > > > > continue (what I see as) necessary innovation.
> > > > >
> > > > > That said, if you wish to add a top-level project for me, then I =
would
> > > > > push things to it, yes.
> > > >
> > > > To be clear, you can have
> > > > https://source.denx.de/u-boot/contributors/sjg/ but you can't host =
your
> > > > downstream fork on source.denx.de itself and I wish you wouldn't ab=
use
> > > > the project domain for it either.
> > >
> > > By calling my efforts a 'downstream fork', it seems to me you are
> > > strengthening the current situation. I wish you would change your
> > > terminology here.
> > >
> > > Also, I have explained why I feel I must have my own tree for now. If
> > > you are looking at making any changes to accomodate my concerns in the
> > > short term, then perhaps we should refrain from discussing this topic
> > > so often? It may just be wasting space on the mailing list if there is
> > > no room for movement.
> >
> > We probably should keep discussion of what you see as your role in
> > U-Boot to another thread, yes. But I don't know what to call your
> > personal not mainline tree if not a fork.
>=20
> OK good.
>=20
> You could perhaps just call it 'Simon's tree'. After all, the extent
> to which it becomes a fork is under your control, not mine.

To borrow a phrase, it takes two to tango.

--=20
Tom

--Pi2Wj/inCIQD5mKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLEhsACgkQFHw5/5Y0
tyyaRgv6AqWJj8KdGI+neFNiCcTr6BLZzxvI7h/prpDNTe5jcU2D/ncKPy/Mlbns
RgK4l1y6BNFQ/uILtRTTlj2/jjChyvE+TyKbOFZ+1yrRfT3ehQcuZK2Q7bP8OuAM
ii4+Q4FlX/x5eQG8duXY4fkqj9pbIrL+Ts7q75PR0mFbfn53ltFr6FjvM0SLJyKm
HvSP0tjQlKq/svES7SaNRrQoNitJ0a/L8P0xeG3gWr74SwG6Pm/y5mYB4EDjimOF
5eQqmrjnAkcMppANF0dQSlcCnQGEm0xCPsx0K03c2bE1wbDBohaucIkeSJHHPYJY
NhszVS5kcIeOIxGOdrRFMhUP9mYuCAIqWX7VD00UM/WMjd7FiVWSzQtGUHRiMpua
qIul42q7iuGEL6Q84e+I4Eemw7h+nyJ5y+SxdXJEA1pFWe/eo6jCl8IjXFZdV/YI
muiIuAYsUZ5OYui/67PGer5kNcSJijbwuCDSFY/uHk2VVp3TsViG7lH8l3Sk6TvQ
97pEc+G5
=qUhH
-----END PGP SIGNATURE-----

--Pi2Wj/inCIQD5mKH--
