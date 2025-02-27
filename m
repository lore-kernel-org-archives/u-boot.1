Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB7BC197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 20:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7494F811C1;
	Thu, 27 Feb 2025 21:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A91Q30UV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B4281426; Thu, 27 Feb 2025 21:15:32 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B04810F1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 21:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2359340a91.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740687328; x=1741292128; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FpMy+YVQ3ZI9xPPPhkaGcbINuV+z8EePOjuXOHudNAE=;
 b=A91Q30UVhVqpQLfsViOCqejezt4FTEl7WEq9cfFu8mTnu+svKYItAnCgbJeVfhQcUI
 NLdMabzRnoviX8d/+8nQ1IUWGwJc18wNkVF4XeixUtjL7gQ/uOpLC+aOkFKmE7c3I6FO
 EdziK4TpCIF16kt4ffgyrwMBg8kVmGZcU4MlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740687328; x=1741292128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpMy+YVQ3ZI9xPPPhkaGcbINuV+z8EePOjuXOHudNAE=;
 b=nqMojwYyuwRhbxKv8ZUwC0e5CpO67q6xP4Nbchp+hARD1G+4O6yH/0kJD7uvqHdf15
 00pXxHT+ncCF+RZECDr1OoHuujqGVvaXTuccGhxr3x/Y9XxQ/viUfqlq+v+cVz0vGhhY
 MBKNoR/ZdqjGD77nioup53CqXWH7yM5l/t3vq2T9MCi9lyo4jgFlaO5wqug7Lli7006P
 nxgBzYMp8KnNiHcdR7EY82x24ZEgSXsWf8o847F+KF9bil2+vbS3enoiWsqp0znyGwsa
 kmaPAJwh0xBxmMKrYZeQrlfn541FOAi0BJSd/o+VV0fk5Al6pUvfVQVuFvZC+KUesZK4
 LPxA==
X-Gm-Message-State: AOJu0YxueSAwJH+ZyngYL/zHdDoBoktlrRdxIh2mdkKStTUMtTF3ZDgP
 XJFrNTMECyOfJU+vauMDvPL4yFTJqXLpI2DoNvQL7eqQ4/cfvYtReyGQj2g4JzZ8XbSBaE1oQ7C
 ex8M=
X-Gm-Gg: ASbGncsoqidUF4RburMocj+GwRirdN58XJdstFFypFl4gwzlvnktzphrTUjGq61GFQ9
 eZSsAwWmrScI27/25sZpd9DEkvZkgd10MN4FuhfWZjw52LEZEQK0b1BSh2m47ZprLnFKNYBWrK7
 ntQJ+2m6mefKz894rm8WNxAZiM3ogtHFkb8+85evAlOEvPhVI/QPpiFMOaEYAOtsOTMMsKdUuUp
 qpYQY3bw/AloWzA16Ag/5JHpZ8d2bXiKjkesioWY1ARtjXNRibsA8GAXP+VwUcSuo3TixeLSELb
 gFMZ5m/cX8GFAtVI1kzUN+uS
X-Google-Smtp-Source: AGHT+IF55kuMDFSNUxB2fMzbzUwHyBnPtEBMQA7K5jclVvZ4sarswbK7DuvGMXYuJQrqM7379sYwMQ==
X-Received: by 2002:a05:6a00:847:b0:730:9768:ccdf with SMTP id
 d2e1a72fcca58-734ac372170mr939236b3a.14.1740687327598; 
 Thu, 27 Feb 2025 12:15:27 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024c81sm2101763b3a.118.2025.02.27.12.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 12:15:26 -0800 (PST)
Date: Thu, 27 Feb 2025 14:15:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250227201523.GJ2640854@bill-the-cat>
References: <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
 <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
 <20250227172001.GH2640854@bill-the-cat>
 <CAFLszTgsT2GKOOYwBp2YjFRsYtvVhkvOST7PtzgtXi3r=3jumA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="12k1KscCRAMGZadM"
Content-Disposition: inline
In-Reply-To: <CAFLszTgsT2GKOOYwBp2YjFRsYtvVhkvOST7PtzgtXi3r=3jumA@mail.gmail.com>
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


--12k1KscCRAMGZadM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:26:10PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Feb 2025 at 10:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 27, 2025 at 09:27:33AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 26 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Sun, Feb 16, 2025 at 01:44:13PM -0700, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Now that U-Boot can boot this quickly, us=
ing kvm, add a test that the
> > > > > > > > > > > > > > > > > installer starts up correctly.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Use the qemu-x86_64 board in the SJG lab.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.=
org>
> > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > > > - Add more patches to support booting wit=
h kvm
> > > > > > > > > > > > > > > > > - Add new patch with a test for booting U=
buntu 24.04
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >  .gitlab-ci.yml               |  5 ++++
> > > > > > > > > > > > > > > > >  test/py/tests/test_distro.py | 53 ++++++=
++++++++++++++++++++++++++++++
> > > > > > > > > > > > > > > > >  2 files changed, 58 insertions(+)
> > > > > > > > > > > > > > > > >  create mode 100644 test/py/tests/test_di=
stro.py
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.=
yml
> > > > > > > > > > > > > > > > > index 8c49d5b0a79..ec799e97c10 100644
> > > > > > > > > > > > > > > > > --- a/.gitlab-ci.yml
> > > > > > > > > > > > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > > > > > > > > > > > @@ -745,3 +745,8 @@ zybo:
> > > > > > > > > > > > > > > > >    variables:
> > > > > > > > > > > > > > > > >      ROLE: zybo
> > > > > > > > > > > > > > > > >    <<: *lab_dfn
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +qemu-x86_64:
> > > > > > > > > > > > > > > > > +  variables:
> > > > > > > > > > > > > > > > > +    ROLE: qemu-x86_64
> > > > > > > > > > > > > > > > > +  <<: *lab_dfn
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'm not sure why this is in your lab stanza=
, rather than the normal
> > > > > > > > > > > > > > > > test.py QEMU stanza.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Are you wanting to add the Ubuntu image into =
CI? It is quite large.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If we're going to be able to run it on N platfo=
rms, yes, we need to
> > > > > > > > > > > > > > think of a good way to cache the download. Ther=
e's not a particular
> > > > > > > > > > > > > > reason we can't run the stock Ubuntu RISC-V ima=
ge on the two sifive
> > > > > > > > > > > > > > targets and also qemu-riscv64, is there?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, we can do that. It is pretty simple to set u=
p in Labgrid and it
> > > > > > > > > > > > > doesn't require all the runners to download a muc=
h larger image, etc.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't quite understand why it's under "labgrid". =
These are generic CI
> > > > > > > > > > > > tests. Now maybe we need to, in both Gitlab and Azu=
re, add some logic so
> > > > > > > > > > > > that certain longer or possibly destructive tests a=
re only run on tagged
> > > > > > > > > > > > releases or as requested rather than every time, as=
 it will take longer.
> > > > > > > > > > > > But pretty much every platform under the qemu targe=
t list should be able
> > > > > > > > > > > > to Just Boot an off the shelf OS distribution is my=
 point.
> > > > > > > > > > >
> > > > > > > > > > > Sure, and I'm not suggesting we shouldn't do that as =
well.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > > > > > diff --git a/test/py/tests/test_distro.py=
 b/test/py/tests/test_distro.py
> > > > > > > > > > > > > > > > > new file mode 100644
> > > > > > > > > > > > > > > > > index 00000000000..51eec45cecc
> > > > > > > > > > > > > > > > > --- /dev/null
> > > > > > > > > > > > > > > > > +++ b/test/py/tests/test_distro.py
> > > > > > > > > > > > > > > > > @@ -0,0 +1,53 @@
> > > > > > > > > > > > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > > > > > > > > > > > +# Copyright 2025 Canonical Ltd.
> > > > > > > > > > > > > > > > > +# Written by Simon Glass <simon.glass@ca=
nonical.com>
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +import pytest
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +# Enable early console so that the test =
can see if something goes wrong
> > > > > > > > > > > > > > > > > +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f=
8 console=3Duart8250,io,0x3f8'
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +@pytest.mark.boardspec('qemu-x86_64')
> > > > > > > > > > > > > > > > > +@pytest.mark.role('qemu-x86_64')
> > > > > > > > > > > > > > > > > +def test_distro(ubman):
> > > > > > > > > > > > > > > > > +    """Test that of-platdata can be gene=
rated and used in sandbox"""
> > > > > > > > > > > > > > > > > +    with ubman.log.section('boot'):
> > > > > > > > > > > > > > > > > +        ubman.run_command('boot', wait_f=
or_prompt=3DFalse)
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +    with ubman.log.section('Grub'):
> > > > > > > > > > > > > > > > > +        # Wait for grub to come up and o=
ffset a menu
> > > > > > > > > > > > > > > > > +        ubman.p.expect(['Try or Install =
Ubuntu'])
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Press 'e' to edit the command =
line
> > > > > > > > > > > > > > > > > +        ubman.run_command('e', wait_for_=
prompt=3DFalse, send_nl=3DFalse)
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Wait until we see the editor a=
ppear
> > > > > > > > > > > > > > > > > +        ubman.p.expect(['/casper/initrd'=
])
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Go down to the 'linux' line
> > > > > > > > > > > > > > > > > +        ubman.send(DOWN * 3)
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Go to end of line
> > > > > > > > > > > > > > > > > +        ubman.ctrl('E')
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Backspace to remove 'quiet spl=
ash'
> > > > > > > > > > > > > > > > > +        ubman.send('\b' * len('quiet spl=
ash'))
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Send our noisy console
> > > > > > > > > > > > > > > > > +        ubman.send(CONSOLE)
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +        # Tell grub to boot
> > > > > > > > > > > > > > > > > +        ubman.ctrl('X')
> > > > > > > > > > > > > > > > > +        ubman.p.expect(['Booting a comma=
nd list'])
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +    with ubman.log.section('Linux'):
> > > > > > > > > > > > > > > > > +        # Linux should start immediately
> > > > > > > > > > > > > > > > > +        ubman.p.expect(['Linux version'])
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +    with ubman.log.section('Ubuntu'):
> > > > > > > > > > > > > > > > > +        # Shortly later, we should see t=
his banner
> > > > > > > > > > > > > > > > > +        ubman.p.expect(['Welcome to .*Ub=
untu 24.04.1 LTS.*!'])
> > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > +    ubman.restart_uboot()
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > And this seems very inflexible. Please see
> > > > > > > > > > > > > > > > test/py/tests/test_net_boot.py for an examp=
le of how to have this be
> > > > > > > > > > > > > > > > configurable and work on arbitrary platform=
s. What I assume is tricky is
> > > > > > > > > > > > > > > > that the "role" part here is where you have=
 a special disk image being
> > > > > > > > > > > > > > > > passed. That too could be dealt with in u-b=
oot-test-hooks in a few ways,
> > > > > > > > > > > > > > > > and the images pre-fetched to the CI contai=
ner. And if this was
> > > > > > > > > > > > > > > > configurable similar to the example I noted=
 above, it could check real
> > > > > > > > > > > > > > > > hardware too.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > That wasn't the reaction I expected.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, it is inflexible, but it is a starting p=
oint. Isn't it better
> > > > > > > > > > > > > > > than what we have today?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Is your inflexible boot an OS test better than =
the flexible boot an OS
> > > > > > > > > > > > > > test that we have today? No, it's not.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I didn't even know about it, or perhaps I forgot.
> > > > > > > > > > > >
> > > > > > > > > > > > I believe I mentioned it every time you've said we =
should have an OS
> > > > > > > > > > > > test, so yes, I guess you forgot.
> > > > > > > > > > >
> > > > > > > > > > > Well it was only added in May last year and it relies=
 on board config
> > > > > > > > > > > which I don't have...although I see that you have now=
 posted yours.
> > > > > > > > > >
> > > > > > > > > > Yes, it was added not quite a year ago, and is document=
ed within the
> > > > > > > > > > test, like most tests that rely on the real platform.
> > > > > > > > > >
> > > > > > > > > > And do we need better documentation for test? Yes.
> > > > > > > > >
> > > > > > > > > +1
> > > > > > > > >
> > > > > > > > > I'll note that I did my bit!
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > > Perhaps this relates to getting the labgrid confi=
g published and
> > > > > > > > > > > > > figuring out how to pass info from Labgrid to tes=
ts.
> > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I would like to generalise this test to work =
on at least one real
> > > > > > > > > > > > > > > board, preferably one that doesn't use grub.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > OK. The test we have today does that, if you ch=
eck for the "Welcome to
> > > > > > > > > > > > > > ..." string instead of the kernel has booted st=
ring. It also does
> > > > > > > > > > > > > > netboot rather than run default bootcmd. But th=
at's an easy enough test
> > > > > > > > > > > > > > to write up. The only thing stopping me from do=
ing that right now is I
> > > > > > > > > > > > > > need to find a board in the lab where we instal=
led an OS to eMMC and not
> > > > > > > > > > > > > > SD card (some lab sd-mux issues).
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK. Labgrid has a 'features' thing which you can =
attach to targets, so
> > > > > > > > > > > > > I should be able to use that to indicate that Ubu=
ntu, Debian, Armbian,
> > > > > > > > > > > > > etc. are available.
> > > > > > > > > > > >
> > > > > > > > > > > > OK, but that sounds like the opposite direction. Th=
ese are generic tests
> > > > > > > > > > > > that can run in any / all of the labs, not just you=
r labgrid
> > > > > > > > > > > > configuration. AMD has been contributing tests that=
 run on hardware for
> > > > > > > > > > > > example.
> > > > > > > > > > >
> > > > > > > > > > > That's great, the more tests we have the better. But =
those tests can't
> > > > > > > > > > > and don't run in CI, whereas mine can and do.
> > > > > > > > > >
> > > > > > > > > > AFAICT they're running on AMD's CI. They run on my CI. =
They don't run on
> > > > > > > > > > *your* lab because you took things, intentionally, in a=
 direction to
> > > > > > > > > > minimize using u-boot-test-hooks and our existing per-b=
oard
> > > > > > > > > > configuration infrastructure.
> > > > > > > > >
> > > > > > > > > When I look at CI all I see is my lab. Which CI are you r=
eferring to
> > > > > > > > > and how can I access it?
> > > > > > > >
> > > > > > > > I'll point you at the notes for the first call we had recen=
tly:
> > > > > > > > https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bil=
l-the-cat/
> > > > > > > > and note that there are many labs doing testing on / with U=
-Boot.
> > > > > > >
> > > > > > > That's all good, but it isn't as good as having the lab in gi=
tlab.
> > > > > >
> > > > > > Strongly disagree. Especially since having it in the mainline g=
itlab
> > > > > > isn't feasible.
> > > > > >
> > > > > > > > > Here I would like to make a case for moving to using Labg=
rid across
> > > > > > > > > the board, but unfortunately the project struggles to rev=
iew PRs, so
> > > > > > > > > it's probably not a good idea.
> > > > > > > >
> > > > > > > > It would also be counter to the feedback from the U-Boot co=
mmunity about
> > > > > > > > making it easier to contribute testing results from additio=
nal labs.
> > > > > > >
> > > > > > > I really don't think the test hooks are a good setup, though.=
 It is
> > > > > > > OK-ish for small labs, but it is so fiddly to use that I wrot=
e a tool
> > > > > > > (Labman) to deal with all the confusion.
> > > > > >
> > > > > > Yes, I don't know how hard you evaluated all of the then-curren=
t lab
> > > > > > management tooling and wrote your own.
> > > > > >
> > > > > > > Labgrid (which you suggested I use for my lab, if you recall),
> > > > > >
> > > > > > Yes, and I think you forgot the aim was to make it easy to show=
 all of
> > > > > > the existing Labgrid based labs that do Linux kernel testing th=
ey could
> > > > > > easily add U-Boot to the mix. I've been trying to get feedback =
=66rom
> > > > > > other people with existing labgrid setups to look at what you'v=
e done.
> > > > > >
> > > > > > > provides for two yaml configuration files so that everything =
is in one
> > > > > > > place. Apart from its primitive support for USB hubs, it is m=
uch
> > > > > > > easier to maintain that dozens of little files all over the p=
alce.
> > > > > >
> > > > > > I mean, I looked at what you posted and strongly disagree, but =
I think
> > > > > > both cases here are personal preference and not some sort of ob=
jective
> > > > > > and easily evaluated thing.
> > > > > >
> > > > > > > > > > > We need an 'all of the above' strategy here.
> > > > > > > > > >
> > > > > > > > > > Sure. But I still want to see things as reusable as pos=
sible. What you
> > > > > > > > > > have above is *extremely* board and OS specific and non=
-configurable.
> > > > > > > > >
> > > > > > > > > Yes, agreed.
> > > > > > > > >
> > > > > > > > > > I
> > > > > > > > > > also don't quite see why it's not a test of autoboot wi=
th the
> > > > > > > > > > pre-requisite of an OS being installed.
> > > > > > > > >
> > > > > > > > > Ah OK, my test is just for the installer itself. Both are=
 useful, but
> > > > > > > > > I hope eventually to have the installer run to completion=
 and then
> > > > > > > > > reboot to check all is well.
> > > > > > > >
> > > > > > > > In the spirit of "yes, and.."'ing tests, sure. Ilias pointe=
d me at some
> > > > > > > > testing Linaro has going now that automates I believe it wa=
s current
> > > > > > > > Yocto and current U-Boot (+ the pmb patches that've been po=
sted) doing a
> > > > > > > > full install via network in CI. So yes, a Canonical lab mig=
ht also find
> > > > > > > > it useful to end to end test installing Ubuntu. My own pers=
onal dream is
> > > > > > > > that at least some of the existing kernelci labs see the ut=
ility in
> > > > > > > > adding "current U-Boot" as one of the matrix variables they=
 test and not
> > > > > > > > just "U-Boot as delivered by vendor" as a static part of th=
e testing.
> > > > > > >
> > > > > > > OK.
> > > > > > >
> > > > > > > >
> > > > > > > > > > > BTW, having thought about how test/py works a bit, in=
stead of the
> > > > > > > > > > > env__net_tftp_bootable_file stuff, we should have cod=
e or data which
> > > > > > > > > > > sets up the required test files (on a suitable server=
) before running
> > > > > > > > > > > the test. That way, all the test code is in one Pytho=
n file and we
> > > > > > > > > > > don't have to spend ages trying to divine what each t=
est needs.
> > > > > > > > > >
> > > > > > > > > > That seems like a lot more work than documenting more w=
hat we have
> > > > > > > > > > today, and I'm not sure of the benefit. Given the conte=
nts of the pxe
> > > > > > > > > > test, yes, just having those files available to 'cp' in=
 place would be
> > > > > > > > > > helpful. But that's not the case for booting a kernel (=
the FIT match
> > > > > > > > > > stuff doesn't work on the TI platforms atm). And if you=
 look at the
> > > > > > > > > > config I posted it also includes bootstage configuratio=
n. It also won't
> > > > > > > > > > work well for the SPI tests, which I'm talking with Lov=
e about in
> > > > > > > > > > another thread.
> > > > > > > > >
> > > > > > > > > Yes, perhaps, but having self-contained tests would be a =
win.
> > > > > > > >
> > > > > > > > With it's own set of technical and legal challenges / oblig=
ations and
> > > > > > > > difficulties depending on what you even mean by "self conta=
ined". And
> > > > > > > > how often what's run where, and all sorts of other challeng=
es too.
> > > > > > > >
> > > > > > > > Given the extreme depth that testing can go to, this is why=
 I'm of the
> > > > > > > > position that we need to document things more and worry les=
s about
> > > > > > > > prepackaged things. For example, making the documentation f=
or the
> > > > > > > > current net based OS boot means that for bringing up a new =
board the
> > > > > > > > developer can just drop something in. Whereas if the tests =
expect a
> > > > > > > > functional OS image that has to also be messed with and is =
its own
> > > > > > > > challenge.
> > > > > > >
> > > > > > > Yes
> > > > > > >
> > > > > > > >
> > > > > > > > > > In other words, the majority of py/<host>/u_boot_boarde=
nv_ content is
> > > > > > > > > > configuration details, specific to both the platform / =
SoC first, some
> > > > > > > > > > lab specific details second and drop-in existing 3rd pa=
rty files a
> > > > > > > > > > distant third.
> > > > > > > > >
> > > > > > > > > I think the u-boot-test-hooks was an amazing solution 9 y=
ears ago, but
> > > > > > > > > we have outgrown it. We want people to be able to connect=
 their lab to
> > > > > > > > > CI (meaning gitlab), so testing is more automated.
> > > > > > > >
> > > > > > > > More and more public testing would be great. The notes I li=
nked above
> > > > > > > > explain one of the first problems there being that most com=
panies will
> > > > > > > > not or can not hook a lab to a public CI instance.
> > > > > > >
> > > > > > > Well corporate IT is what it is.
> > > > > > >
> > > > > > > That means that their boards will not be testing in CI, unles=
s they do
> > > > > > > it themselves, right?
> > > > > >
> > > > > > I'm not sure what you mean here. It's a solved problem for them=
 (monitor
> > > > > > tree at URL) and something that's been being done since the beg=
inning
> > > > > > even for U-Boot (it's how the original nvidia lab worked).
> > > > > >
> > > > > > > > The next problem, as
> > > > > > > > both of our personal labs show, is that just maintaining th=
e physical
> > > > > > > > lab takes time and resources. I've added Heiko here because=
 I've been
> > > > > > > > talking with him off-list about expanding tbot coverage and=
 plumbing
> > > > > > > > that in to gitlab.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > We should move away from relying on maintainers getting a=
round to
> > > > > > > > > testing patches months after they are sent, when they hav=
e time, but
> > > > > > > > > they don't. Things need to be more automated and I'd enco=
urage you to
> > > > > > > > > push this as well.
> > > > > > > >
> > > > > > > > I have been, and the results I've gotten are that companies=
 are testing
> > > > > > > > things internally but there's not any good way to publish r=
esults, and
> > > > > > > > that's the kind of framework we're entirely missing.
> > > > > > >
> > > > > > > If you like, but from my side, I like to see the results in g=
itlab.
> > > > > >
> > > > > > Depends on what you mean by gitlab. I assume you mean "triggere=
d by a
> > > > > > push and visible in the main pipeline". Which isn't possible. I=
t's not
> > > > > > going to happen. External collection is how it's handled for th=
e linux
> > > > > > kernel and that community has far more sway than we do. If we r=
ide their
> > > > > > coattails here so to speak, we can get results. If we push for =
something
> > > > > > completely different we aren't likely to have success.
> > > > > >
> > > > > > > > Which is another part of why I keep pushing against having =
U-Boot
> > > > > > > > configuration stuff inside of Labgrid as it makes it harder=
 for any lab
> > > > > > > > that's not using labgrid to see how to configure things.
> > > > > > >
> > > > > > > Well, as you requested, I looked at Labgrid and now my lab us=
es it. I
> > > > > > > am happy to publish the config[1], but I still hold my view t=
hat all
> > > > > > > the shell scripts in u-boot-test-hooks are limiting and painf=
ul to
> > > > > > > work with.
> > > > > >
> > > > > > Yes, and as I've shown, you can also use labgrid without going =
down the
> > > > > > same path you took, and we can also support other lab managemen=
t methods
> > > > > > too, which is important to get as much testing as possible with=
out
> > > > > > needing to centralize everything.
> > > > >
> > > > > In summary, I suppose we just have different visions and ideas, w=
hich
> > > > > should be a good thing.
> > > >
> > > > So long as the project can speak with one voice, yes. Which all cir=
cles
> > > > back to why I do not think what you're doing with u-boot.org is at =
all
> > > > helpful.
> > >
> > > I do need a relief valve for when my efforts are blocked.
> >
> > And I do not see how using the project domain is appropriate. Stop doing
> > this. If you can't stop I'm going to reach my own limit here.
>=20
> I'm happy to have source.u-boot.org or similar point to Denx, but I do
> need my own tree while my work is blocked from submission. I suggest
> we discuss it on a call and try to figure out a compromise while we
> are in this state.

If you'll remove ci.u-boot.org and just have sjg.u-boot.org I'll stop
feeling like you're holding the domain hostage over your rejected
changes, and we can talk.

--=20
Tom

--12k1KscCRAMGZadM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAx9cACgkQFHw5/5Y0
tywZiAv/VI5RyGmycMHKUznpAOrg2bfQnJcu8akothJwkkmiO1H7JhVH8/fCaxQq
c+BGD0rP37f1u+teAe6zY3/G9UuCWiQIedspmvvIQfU5XAG63+rQTGRYtJxMFshn
7JrvHoDzmAM/MbNvIeEuqxghPDONLecGq9lGxJ4sejyRqb8/MkKRQZx3ELXdKYuS
yhuo8qMYF5DK6KYCZ1J8WMMIEUc55rwbs0NbYe4TMASC/A/stYw8MNkCqmab4CLh
hAv3YPys4+dIefFaPXaG6S9DLfAviIf3CZ4vFgcD0REIn3uOGsUA2Bo4LNt43zh5
wejE7nYbUiuQ6WKMkDk9+X907I5EC0d3swFzBljisr1z2o3t7lIn6h8yekJQRLn5
4BSU0YrLEHZvMxROGgXCaKZYcSIlwC1f30D3D4I9XWY6EgKW3xgeQbUaNLWA3r7a
O0fM2yF1J708Mh9+oO0OKGIMrYtV6lJ1vK0R/TLGv9cnWkQKEkqlWDIqTNDdBCw4
9P1lyNuf
=FvZf
-----END PGP SIGNATURE-----

--12k1KscCRAMGZadM--
