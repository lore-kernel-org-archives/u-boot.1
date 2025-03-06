Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CD9C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2897F8056A;
	Thu,  6 Mar 2025 17:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rWnUMP5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B05980756; Thu,  6 Mar 2025 17:43:31 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E7E80017
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f679788fd1so6820217b3.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741279406; x=1741884206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w8eaSxBoC4PR6kri2JkxqTwItL4hpKBZmSouiOY/BWA=;
 b=rWnUMP5ZyUl1P8X4am8p5QIM0MSpbkQGQhMwVM0L2tro+SVWhHcxdKnvUr6HZ06Oo8
 h2jgguedamXjPZDsG50sG9cYDhCYoVvRI6LDvVlrJKlZwEAlgWu5ya5R8IW5Trq3SocL
 rzkl8nCdfa/+PgMmkipGSH3CkUwCoFdDBFBPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279406; x=1741884206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8eaSxBoC4PR6kri2JkxqTwItL4hpKBZmSouiOY/BWA=;
 b=uZ+rhbXnDWTGF5MtaHxli64tOeRThQMSvxXlpqjlt+N2RTwxd8gzXPzBGuLxLRIcuQ
 tgQUMCZwKwdPE5EZw+iUuRwthPOoyJgheA4xzC9yymE0Ps52jAR0fPr1+jR0knj4reeS
 1q/VgsEXc8UyV+oqv+KPOPRouqME8HmiJQVVoDuF2eVtkIxyMwfFG0kK7qHtGxb3wp5c
 Jyl/NRfOm/rOIwftF7haum1+5sORkNmXuMft4ffGRdUoIRAgtkdDZ2oJse0QUTxd4u4J
 GsZQWwwpuJvMUrdYyknlK7w64OjWP+AHf13c5YjhDAW6bTw/HEcGlb7vMzR0SXInvDe/
 4EwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt72tvlSq4GqzT/t3h8U9STPlagDiODiBbnmTcW3K1Uj7fRKwGWqbiRuslt0ntXUIHqKAVGGE=@lists.denx.de
X-Gm-Message-State: AOJu0YzAccrDQ3vV23qmtiFAgOJtLNZwSemU8NVQooK33tPvDvKaIpcH
 /lR4MONEKBntBSq9dc52dRzx1sN1XUQbkqPZ6eSLrnDFotzwQCXwlHhoaASNN48=
X-Gm-Gg: ASbGncshrqat1DQK3g5JpfOvHonkdhUaCJpuRLrqOsPd1L26DrLM5oDXHmLKmpNjVow
 sjrNr6H7g8HKImupFoootkbrMC4hlYbWQIsit96ZWRLlitcb8qNRHUGz+vaPfgVG29hFj5fcAoc
 GfIx7zhv4b+hi2UpQZLGu0FK6zSFoJmSflAC1doDl49U4m/TRCwbvcTfc157Ar7PWlDO2Al3Fec
 tSgCTyjpnTTj4x+OA/psd8ocM3eqtGrL831yQCe7FQYaKC/aw3nfrEYBBhh3b4/vHze15eox7WU
 9N6WISGMxRnEq0or/TcI7v0QezCBf/qvC0iCWdlsaD2WWQ==
X-Google-Smtp-Source: AGHT+IGsCQtw741PLYXtxrNHQfWZFNCms09Mpz340TlW00G7NyOCGi0/olEMJGQAAund9zW7B1kyaw==
X-Received: by 2002:a05:690c:6111:b0:6fb:ae6b:a340 with SMTP id
 00721157ae682-6fda311fb5fmr113163457b3.30.1741279406091; 
 Thu, 06 Mar 2025 08:43:26 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b855211sm376290276.27.2025.03.06.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:43:25 -0800 (PST)
Date: Thu, 6 Mar 2025 10:43:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: hs@denx.de, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250306164322.GF2640854@bill-the-cat>
References: <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
 <CAFLszTibwiJrbvrKacAGi-Z+5Hfx1-oUNxVGuUS-ETa+wT_JtQ@mail.gmail.com>
 <20250227172001.GH2640854@bill-the-cat>
 <CAFLszTgsT2GKOOYwBp2YjFRsYtvVhkvOST7PtzgtXi3r=3jumA@mail.gmail.com>
 <9bb480f6-95df-10ae-3470-b8ef1aa6a027@denx.de>
 <CAFLszTgRnXRQvm0+AoN=WOBczmy6d1Z7Pscy7Qd1KLA4=x+P5A@mail.gmail.com>
 <20250306143249.GB2640854@bill-the-cat>
 <CAFLszTivk-j2vZrHYveXAhfxgaXiGpmNf40BR33H80aKodyaFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kPM3MiNy2tju5770"
Content-Disposition: inline
In-Reply-To: <CAFLszTivk-j2vZrHYveXAhfxgaXiGpmNf40BR33H80aKodyaFA@mail.gmail.com>
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


--kPM3MiNy2tju5770
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:11:28AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Mar 2025 at 07:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 07:16:08AM -0700, Simon Glass wrote:
> > > Hi Heiko,
> > >
> > > On Thu, 27 Feb 2025 at 22:26, Heiko Schocher <hs@denx.de> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 27.02.25 20:26, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 27 Feb 2025 at 10:20, Tom Rini <trini@konsulko.com> wrote:
> > > > >>
> > > > >> On Thu, Feb 27, 2025 at 09:27:33AM -0700, Simon Glass wrote:
> > > > >>> Hi Tom,
> > > > >>>
> > > > >>> On Wed, 26 Feb 2025 at 07:35, Tom Rini <trini@konsulko.com> wro=
te:
> > > > >>>>
> > > > >>>> On Tue, Feb 25, 2025 at 07:56:03PM -0700, Simon Glass wrote:
> > > > >>>>> Hi Tom,
> > > > >>>>>
> > > > >>>>> On Tue, 25 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> w=
rote:
> > > > >>>>>>
> > > > >>>>>> On Mon, Feb 24, 2025 at 10:54:13AM -0700, Simon Glass wrote:
> > > > >>>>>>> Hi Tom,
> > > > >>>>>>>
> > > > >>>>>>> On Fri, 21 Feb 2025 at 09:06, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > >>>>>>>>
> > > > >>>>>>>> On Fri, Feb 21, 2025 at 06:57:34AM -0700, Simon Glass wrot=
e:
> > > > >>>>>>>>> Hi Tom,
> > > > >>>>>>>>>
> > > > >>>>>>>>> On Thu, 20 Feb 2025 at 07:53, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> On Thu, Feb 20, 2025 at 06:49:49AM -0700, Simon Glass wr=
ote:
> > > > >>>>>>>>>>> Hi Tom,
> > > > >>>>>>>>>>>
> > > > >>>>>>>>>>> On Tue, 18 Feb 2025 at 17:55, Tom Rini <trini@konsulko.=
com> wrote:
> > > > >>>>>>>>>>>>
> > > > >>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:01:40PM -0700, Simon Glass =
wrote:
> > > > >>>>>>>>>>>>> Hi Tom,
> > > > >>>>>>>>>>>>>
> > > > >>>>>>>>>>>>> On Tue, 18 Feb 2025 at 08:11, Tom Rini <trini@konsulk=
o.com> wrote:
> > > > >>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>> On Tue, Feb 18, 2025 at 05:09:23AM -0700, Simon Glas=
s wrote:
> > > > >>>>>>>>>>>>>>> Hi Tom,
> > > > >>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>> On Mon, 17 Feb 2025 at 10:52, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > >>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>> On Sun, Feb 16, 2025 at 01:44:13PM -0700, Simon Gl=
ass wrote:
> > > > >>>>>>>>>>>>>>>>> Now that U-Boot can boot this quickly, using kvm,=
 add a test that the
> > > > >>>>>>>>>>>>>>>>> installer starts up correctly.
> > > > >>>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>> Use the qemu-x86_64 board in the SJG lab.
> > > > >>>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >>>>>>>>>>>>>>>>> ---
> > > > >>>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>> Changes in v2:
> > > > >>>>>>>>>>>>>>>>> - Add more patches to support booting with kvm
> > > > >>>>>>>>>>>>>>>>> - Add new patch with a test for booting Ubuntu 24=
=2E04
> > > > >>>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>>   .gitlab-ci.yml               |  5 ++++
> > > > >>>>>>>>>>>>>>>>>   test/py/tests/test_distro.py | 53 +++++++++++++=
+++++++++++++++++++++++
> > > > >>>>>>>>>>>>>>>>>   2 files changed, 58 insertions(+)
> > > > >>>>>>>>>>>>>>>>>   create mode 100644 test/py/tests/test_distro.py
> > > > >>>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > >>>>>>>>>>>>>>>>> index 8c49d5b0a79..ec799e97c10 100644
> > > > >>>>>>>>>>>>>>>>> --- a/.gitlab-ci.yml
> > > > >>>>>>>>>>>>>>>>> +++ b/.gitlab-ci.yml
> > > > >>>>>>>>>>>>>>>>> @@ -745,3 +745,8 @@ zybo:
> > > > >>>>>>>>>>>>>>>>>     variables:
> > > > >>>>>>>>>>>>>>>>>       ROLE: zybo
> > > > >>>>>>>>>>>>>>>>>     <<: *lab_dfn
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +qemu-x86_64:
> > > > >>>>>>>>>>>>>>>>> +  variables:
> > > > >>>>>>>>>>>>>>>>> +    ROLE: qemu-x86_64
> > > > >>>>>>>>>>>>>>>>> +  <<: *lab_dfn
> > > > >>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>> I'm not sure why this is in your lab stanza, rathe=
r than the normal
> > > > >>>>>>>>>>>>>>>> test.py QEMU stanza.
> > > > >>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>> Are you wanting to add the Ubuntu image into CI? It=
 is quite large.
> > > > >>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>> If we're going to be able to run it on N platforms, =
yes, we need to
> > > > >>>>>>>>>>>>>> think of a good way to cache the download. There's n=
ot a particular
> > > > >>>>>>>>>>>>>> reason we can't run the stock Ubuntu RISC-V image on=
 the two sifive
> > > > >>>>>>>>>>>>>> targets and also qemu-riscv64, is there?
> > > > >>>>>>>>>>>>>
> > > > >>>>>>>>>>>>> Yes, we can do that. It is pretty simple to set up in=
 Labgrid and it
> > > > >>>>>>>>>>>>> doesn't require all the runners to download a much la=
rger image, etc.
> > > > >>>>>>>>>>>>
> > > > >>>>>>>>>>>> I don't quite understand why it's under "labgrid". The=
se are generic CI
> > > > >>>>>>>>>>>> tests. Now maybe we need to, in both Gitlab and Azure,=
 add some logic so
> > > > >>>>>>>>>>>> that certain longer or possibly destructive tests are =
only run on tagged
> > > > >>>>>>>>>>>> releases or as requested rather than every time, as it=
 will take longer.
> > > > >>>>>>>>>>>> But pretty much every platform under the qemu target l=
ist should be able
> > > > >>>>>>>>>>>> to Just Boot an off the shelf OS distribution is my po=
int.
> > > > >>>>>>>>>>>
> > > > >>>>>>>>>>> Sure, and I'm not suggesting we shouldn't do that as we=
ll.
> > > > >>>>>>>>>>>
> > > > >>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>>> diff --git a/test/py/tests/test_distro.py b/test/=
py/tests/test_distro.py
> > > > >>>>>>>>>>>>>>>>> new file mode 100644
> > > > >>>>>>>>>>>>>>>>> index 00000000000..51eec45cecc
> > > > >>>>>>>>>>>>>>>>> --- /dev/null
> > > > >>>>>>>>>>>>>>>>> +++ b/test/py/tests/test_distro.py
> > > > >>>>>>>>>>>>>>>>> @@ -0,0 +1,53 @@
> > > > >>>>>>>>>>>>>>>>> +# SPDX-License-Identifier: GPL-2.0+
> > > > >>>>>>>>>>>>>>>>> +# Copyright 2025 Canonical Ltd.
> > > > >>>>>>>>>>>>>>>>> +# Written by Simon Glass <simon.glass@canonical.=
com>
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +import pytest
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +DOWN =3D '\x1b\x5b\x42\x0d'
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +# Enable early console so that the test can see =
if something goes wrong
> > > > >>>>>>>>>>>>>>>>> +CONSOLE =3D 'earlycon=3Duart8250,io,0x3f8 consol=
e=3Duart8250,io,0x3f8'
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +@pytest.mark.boardspec('qemu-x86_64')
> > > > >>>>>>>>>>>>>>>>> +@pytest.mark.role('qemu-x86_64')
> > > > >>>>>>>>>>>>>>>>> +def test_distro(ubman):
> > > > >>>>>>>>>>>>>>>>> +    """Test that of-platdata can be generated an=
d used in sandbox"""
> > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('boot'):
> > > > >>>>>>>>>>>>>>>>> +        ubman.run_command('boot', wait_for_promp=
t=3DFalse)
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Grub'):
> > > > >>>>>>>>>>>>>>>>> +        # Wait for grub to come up and offset a =
menu
> > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Try or Install Ubuntu'])
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Press 'e' to edit the command line
> > > > >>>>>>>>>>>>>>>>> +        ubman.run_command('e', wait_for_prompt=
=3DFalse, send_nl=3DFalse)
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Wait until we see the editor appear
> > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['/casper/initrd'])
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Go down to the 'linux' line
> > > > >>>>>>>>>>>>>>>>> +        ubman.send(DOWN * 3)
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Go to end of line
> > > > >>>>>>>>>>>>>>>>> +        ubman.ctrl('E')
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Backspace to remove 'quiet splash'
> > > > >>>>>>>>>>>>>>>>> +        ubman.send('\b' * len('quiet splash'))
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Send our noisy console
> > > > >>>>>>>>>>>>>>>>> +        ubman.send(CONSOLE)
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +        # Tell grub to boot
> > > > >>>>>>>>>>>>>>>>> +        ubman.ctrl('X')
> > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Booting a command list'=
])
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Linux'):
> > > > >>>>>>>>>>>>>>>>> +        # Linux should start immediately
> > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Linux version'])
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +    with ubman.log.section('Ubuntu'):
> > > > >>>>>>>>>>>>>>>>> +        # Shortly later, we should see this bann=
er
> > > > >>>>>>>>>>>>>>>>> +        ubman.p.expect(['Welcome to .*Ubuntu 24.=
04.1 LTS.*!'])
> > > > >>>>>>>>>>>>>>>>> +
> > > > >>>>>>>>>>>>>>>>> +    ubman.restart_uboot()
> > > > >>>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>>> And this seems very inflexible. Please see
> > > > >>>>>>>>>>>>>>>> test/py/tests/test_net_boot.py for an example of h=
ow to have this be
> > > > >>>>>>>>>>>>>>>> configurable and work on arbitrary platforms. What=
 I assume is tricky is
> > > > >>>>>>>>>>>>>>>> that the "role" part here is where you have a spec=
ial disk image being
> > > > >>>>>>>>>>>>>>>> passed. That too could be dealt with in u-boot-tes=
t-hooks in a few ways,
> > > > >>>>>>>>>>>>>>>> and the images pre-fetched to the CI container. An=
d if this was
> > > > >>>>>>>>>>>>>>>> configurable similar to the example I noted above,=
 it could check real
> > > > >>>>>>>>>>>>>>>> hardware too.
> > > > >>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>> That wasn't the reaction I expected.
> > > > >>>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>> Yes, it is inflexible, but it is a starting point. =
Isn't it better
> > > > >>>>>>>>>>>>>>> than what we have today?
> > > > >>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>> Is your inflexible boot an OS test better than the f=
lexible boot an OS
> > > > >>>>>>>>>>>>>> test that we have today? No, it's not.
> > > > >>>>>>>>>>>>>
> > > > >>>>>>>>>>>>> I didn't even know about it, or perhaps I forgot.
> > > > >>>>>>>>>>>>
> > > > >>>>>>>>>>>> I believe I mentioned it every time you've said we sho=
uld have an OS
> > > > >>>>>>>>>>>> test, so yes, I guess you forgot.
> > > > >>>>>>>>>>>
> > > > >>>>>>>>>>> Well it was only added in May last year and it relies o=
n board config
> > > > >>>>>>>>>>> which I don't have...although I see that you have now p=
osted yours.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> Yes, it was added not quite a year ago, and is documente=
d within the
> > > > >>>>>>>>>> test, like most tests that rely on the real platform.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> And do we need better documentation for test? Yes.
> > > > >>>>>>>>>
> > > > >>>>>>>>> +1
> > > > >>>>>>>>>
> > > > >>>>>>>>> I'll note that I did my bit!
> > > > >>>>>>>>>
> > > > >>>>>>>>>>
> > > > >>>>>>>>>>>>> Perhaps this relates to getting the labgrid config pu=
blished and
> > > > >>>>>>>>>>>>> figuring out how to pass info from Labgrid to tests.
> > > > >>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>>> I would like to generalise this test to work on at =
least one real
> > > > >>>>>>>>>>>>>>> board, preferably one that doesn't use grub.
> > > > >>>>>>>>>>>>>>
> > > > >>>>>>>>>>>>>> OK. The test we have today does that, if you check f=
or the "Welcome to
> > > > >>>>>>>>>>>>>> ..." string instead of the kernel has booted string.=
 It also does
> > > > >>>>>>>>>>>>>> netboot rather than run default bootcmd. But that's =
an easy enough test
> > > > >>>>>>>>>>>>>> to write up. The only thing stopping me from doing t=
hat right now is I
> > > > >>>>>>>>>>>>>> need to find a board in the lab where we installed a=
n OS to eMMC and not
> > > > >>>>>>>>>>>>>> SD card (some lab sd-mux issues).
> > > > >>>>>>>>>>>>>
> > > > >>>>>>>>>>>>> OK. Labgrid has a 'features' thing which you can atta=
ch to targets, so
> > > > >>>>>>>>>>>>> I should be able to use that to indicate that Ubuntu,=
 Debian, Armbian,
> > > > >>>>>>>>>>>>> etc. are available.
> > > > >>>>>>>>>>>>
> > > > >>>>>>>>>>>> OK, but that sounds like the opposite direction. These=
 are generic tests
> > > > >>>>>>>>>>>> that can run in any / all of the labs, not just your l=
abgrid
> > > > >>>>>>>>>>>> configuration. AMD has been contributing tests that ru=
n on hardware for
> > > > >>>>>>>>>>>> example.
> > > > >>>>>>>>>>>
> > > > >>>>>>>>>>> That's great, the more tests we have the better. But th=
ose tests can't
> > > > >>>>>>>>>>> and don't run in CI, whereas mine can and do.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> AFAICT they're running on AMD's CI. They run on my CI. T=
hey don't run on
> > > > >>>>>>>>>> *your* lab because you took things, intentionally, in a =
direction to
> > > > >>>>>>>>>> minimize using u-boot-test-hooks and our existing per-bo=
ard
> > > > >>>>>>>>>> configuration infrastructure.
> > > > >>>>>>>>>
> > > > >>>>>>>>> When I look at CI all I see is my lab. Which CI are you r=
eferring to
> > > > >>>>>>>>> and how can I access it?
> > > > >>>>>>>>
> > > > >>>>>>>> I'll point you at the notes for the first call we had rece=
ntly:
> > > > >>>>>>>> https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bi=
ll-the-cat/
> > > > >>>>>>>> and note that there are many labs doing testing on / with =
U-Boot.
> > > > >>>>>>>
> > > > >>>>>>> That's all good, but it isn't as good as having the lab in =
gitlab.
> > > > >>>>>>
> > > > >>>>>> Strongly disagree. Especially since having it in the mainlin=
e gitlab
> > > > >>>>>> isn't feasible.
> > > > >>>>>>
> > > > >>>>>>>>> Here I would like to make a case for moving to using Labg=
rid across
> > > > >>>>>>>>> the board, but unfortunately the project struggles to rev=
iew PRs, so
> > > > >>>>>>>>> it's probably not a good idea.
> > > > >>>>>>>>
> > > > >>>>>>>> It would also be counter to the feedback from the U-Boot c=
ommunity about
> > > > >>>>>>>> making it easier to contribute testing results from additi=
onal labs.
> > > > >>>>>>>
> > > > >>>>>>> I really don't think the test hooks are a good setup, thoug=
h. It is
> > > > >>>>>>> OK-ish for small labs, but it is so fiddly to use that I wr=
ote a tool
> > > > >>>>>>> (Labman) to deal with all the confusion.
> > > > >>>>>>
> > > > >>>>>> Yes, I don't know how hard you evaluated all of the then-cur=
rent lab
> > > > >>>>>> management tooling and wrote your own.
> > > > >>>>>>
> > > > >>>>>>> Labgrid (which you suggested I use for my lab, if you recal=
l),
> > > > >>>>>>
> > > > >>>>>> Yes, and I think you forgot the aim was to make it easy to s=
how all of
> > > > >>>>>> the existing Labgrid based labs that do Linux kernel testing=
 they could
> > > > >>>>>> easily add U-Boot to the mix. I've been trying to get feedba=
ck from
> > > > >>>>>> other people with existing labgrid setups to look at what yo=
u've done.
> > > > >>>>>>
> > > > >>>>>>> provides for two yaml configuration files so that everythin=
g is in one
> > > > >>>>>>> place. Apart from its primitive support for USB hubs, it is=
 much
> > > > >>>>>>> easier to maintain that dozens of little files all over the=
 palce.
> > > > >>>>>>
> > > > >>>>>> I mean, I looked at what you posted and strongly disagree, b=
ut I think
> > > > >>>>>> both cases here are personal preference and not some sort of=
 objective
> > > > >>>>>> and easily evaluated thing.
> > > > >>>>>>
> > > > >>>>>>>>>>> We need an 'all of the above' strategy here.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> Sure. But I still want to see things as reusable as poss=
ible. What you
> > > > >>>>>>>>>> have above is *extremely* board and OS specific and non-=
configurable.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Yes, agreed.
> > > > >>>>>>>>>
> > > > >>>>>>>>>> I
> > > > >>>>>>>>>> also don't quite see why it's not a test of autoboot wit=
h the
> > > > >>>>>>>>>> pre-requisite of an OS being installed.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Ah OK, my test is just for the installer itself. Both are=
 useful, but
> > > > >>>>>>>>> I hope eventually to have the installer run to completion=
 and then
> > > > >>>>>>>>> reboot to check all is well.
> > > > >>>>>>>>
> > > > >>>>>>>> In the spirit of "yes, and.."'ing tests, sure. Ilias point=
ed me at some
> > > > >>>>>>>> testing Linaro has going now that automates I believe it w=
as current
> > > > >>>>>>>> Yocto and current U-Boot (+ the pmb patches that've been p=
osted) doing a
> > > > >>>>>>>> full install via network in CI. So yes, a Canonical lab mi=
ght also find
> > > > >>>>>>>> it useful to end to end test installing Ubuntu. My own per=
sonal dream is
> > > > >>>>>>>> that at least some of the existing kernelci labs see the u=
tility in
> > > > >>>>>>>> adding "current U-Boot" as one of the matrix variables the=
y test and not
> > > > >>>>>>>> just "U-Boot as delivered by vendor" as a static part of t=
he testing.
> > > > >>>>>>>
> > > > >>>>>>> OK.
> > > > >>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>>>>> BTW, having thought about how test/py works a bit, inst=
ead of the
> > > > >>>>>>>>>>> env__net_tftp_bootable_file stuff, we should have code =
or data which
> > > > >>>>>>>>>>> sets up the required test files (on a suitable server) =
before running
> > > > >>>>>>>>>>> the test. That way, all the test code is in one Python =
file and we
> > > > >>>>>>>>>>> don't have to spend ages trying to divine what each tes=
t needs.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> That seems like a lot more work than documenting more wh=
at we have
> > > > >>>>>>>>>> today, and I'm not sure of the benefit. Given the conten=
ts of the pxe
> > > > >>>>>>>>>> test, yes, just having those files available to 'cp' in =
place would be
> > > > >>>>>>>>>> helpful. But that's not the case for booting a kernel (t=
he FIT match
> > > > >>>>>>>>>> stuff doesn't work on the TI platforms atm). And if you =
look at the
> > > > >>>>>>>>>> config I posted it also includes bootstage configuration=
=2E It also won't
> > > > >>>>>>>>>> work well for the SPI tests, which I'm talking with Love=
 about in
> > > > >>>>>>>>>> another thread.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Yes, perhaps, but having self-contained tests would be a =
win.
> > > > >>>>>>>>
> > > > >>>>>>>> With it's own set of technical and legal challenges / obli=
gations and
> > > > >>>>>>>> difficulties depending on what you even mean by "self cont=
ained". And
> > > > >>>>>>>> how often what's run where, and all sorts of other challen=
ges too.
> > > > >>>>>>>>
> > > > >>>>>>>> Given the extreme depth that testing can go to, this is wh=
y I'm of the
> > > > >>>>>>>> position that we need to document things more and worry le=
ss about
> > > > >>>>>>>> prepackaged things. For example, making the documentation =
for the
> > > > >>>>>>>> current net based OS boot means that for bringing up a new=
 board the
> > > > >>>>>>>> developer can just drop something in. Whereas if the tests=
 expect a
> > > > >>>>>>>> functional OS image that has to also be messed with and is=
 its own
> > > > >>>>>>>> challenge.
> > > > >>>>>>>
> > > > >>>>>>> Yes
> > > > >>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>>>> In other words, the majority of py/<host>/u_boot_boarden=
v_ content is
> > > > >>>>>>>>>> configuration details, specific to both the platform / S=
oC first, some
> > > > >>>>>>>>>> lab specific details second and drop-in existing 3rd par=
ty files a
> > > > >>>>>>>>>> distant third.
> > > > >>>>>>>>>
> > > > >>>>>>>>> I think the u-boot-test-hooks was an amazing solution 9 y=
ears ago, but
> > > > >>>>>>>>> we have outgrown it. We want people to be able to connect=
 their lab to
> > > > >>>>>>>>> CI (meaning gitlab), so testing is more automated.
> > > > >>>>>>>>
> > > > >>>>>>>> More and more public testing would be great. The notes I l=
inked above
> > > > >>>>>>>> explain one of the first problems there being that most co=
mpanies will
> > > > >>>>>>>> not or can not hook a lab to a public CI instance.
> > > > >>>>>>>
> > > > >>>>>>> Well corporate IT is what it is.
> > > > >>>>>>>
> > > > >>>>>>> That means that their boards will not be testing in CI, unl=
ess they do
> > > > >>>>>>> it themselves, right?
> > > > >>>>>>
> > > > >>>>>> I'm not sure what you mean here. It's a solved problem for t=
hem (monitor
> > > > >>>>>> tree at URL) and something that's been being done since the =
beginning
> > > > >>>>>> even for U-Boot (it's how the original nvidia lab worked).
> > > > >>>>>>
> > > > >>>>>>>> The next problem, as
> > > > >>>>>>>> both of our personal labs show, is that just maintaining t=
he physical
> > > > >>>>>>>> lab takes time and resources. I've added Heiko here becaus=
e I've been
> > > > >>>>>>>> talking with him off-list about expanding tbot coverage an=
d plumbing
> > > > >>>>>>>> that in to gitlab.
> > > > >>>>>>>
> > > > >>>>>>> OK
> > > > >>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>>> We should move away from relying on maintainers getting a=
round to
> > > > >>>>>>>>> testing patches months after they are sent, when they hav=
e time, but
> > > > >>>>>>>>> they don't. Things need to be more automated and I'd enco=
urage you to
> > > > >>>>>>>>> push this as well.
> > > > >>>>>>>>
> > > > >>>>>>>> I have been, and the results I've gotten are that companie=
s are testing
> > > > >>>>>>>> things internally but there's not any good way to publish =
results, and
> > > > >>>>>>>> that's the kind of framework we're entirely missing.
> > > > >>>>>>>
> > > > >>>>>>> If you like, but from my side, I like to see the results in=
 gitlab.
> > > > >>>>>>
> > > > >>>>>> Depends on what you mean by gitlab. I assume you mean "trigg=
ered by a
> > > > >>>>>> push and visible in the main pipeline". Which isn't possible=
=2E It's not
> > > > >>>>>> going to happen. External collection is how it's handled for=
 the linux
> > > > >>>>>> kernel and that community has far more sway than we do. If w=
e ride their
> > > > >>>>>> coattails here so to speak, we can get results. If we push f=
or something
> > > > >>>>>> completely different we aren't likely to have success.
> > > > >>>>>>
> > > > >>>>>>>> Which is another part of why I keep pushing against having=
 U-Boot
> > > > >>>>>>>> configuration stuff inside of Labgrid as it makes it harde=
r for any lab
> > > > >>>>>>>> that's not using labgrid to see how to configure things.
> > > > >>>>>>>
> > > > >>>>>>> Well, as you requested, I looked at Labgrid and now my lab =
uses it. I
> > > > >>>>>>> am happy to publish the config[1], but I still hold my view=
 that all
> > > > >>>>>>> the shell scripts in u-boot-test-hooks are limiting and pai=
nful to
> > > > >>>>>>> work with.
> > > > >>>>>>
> > > > >>>>>> Yes, and as I've shown, you can also use labgrid without goi=
ng down the
> > > > >>>>>> same path you took, and we can also support other lab manage=
ment methods
> > > > >>>>>> too, which is important to get as much testing as possible w=
ithout
> > > > >>>>>> needing to centralize everything.
> > > > >>>>>
> > > > >>>>> In summary, I suppose we just have different visions and idea=
s, which
> > > > >>>>> should be a good thing.
> > > > >>>>
> > > > >>>> So long as the project can speak with one voice, yes. Which al=
l circles
> > > > >>>> back to why I do not think what you're doing with u-boot.org i=
s at all
> > > > >>>> helpful.
> > > > >>>
> > > > >>> I do need a relief valve for when my efforts are blocked.
> > > > >>
> > > > >> And I do not see how using the project domain is appropriate. St=
op doing
> > > > >> this. If you can't stop I'm going to reach my own limit here.
> > > > >
> > > > > I'm happy to have source.u-boot.org or similar point to Denx, but=
 I do
> > > > > need my own tree while my work is blocked from submission. I sugg=
est
> > > > > we discuss it on a call and try to figure out a compromise while =
we
> > > > > are in this state.
> > > >
> > > > Isn;t it possible to add a repo at source.denx.de ? Like u-boot-sjg=
 ?
> > > >
> > > > or u-boot-ci ?
> > >
> > > I don't have permission to do that. With my tree I am able to have CI
> > > running in half the time, use my full lab (not just the subset Tom's
> > > tree has), push patches and ideas that others have blocked, point
> > > people to my work, etc. It is a much better environment for me to
> > > continue (what I see as) necessary innovation.
> > >
> > > That said, if you wish to add a top-level project for me, then I would
> > > push things to it, yes.
> >
> > To be clear, you can have
> > https://source.denx.de/u-boot/contributors/sjg/ but you can't host your
> > downstream fork on source.denx.de itself and I wish you wouldn't abuse
> > the project domain for it either.
>=20
> By calling my efforts a 'downstream fork', it seems to me you are
> strengthening the current situation. I wish you would change your
> terminology here.
>=20
> Also, I have explained why I feel I must have my own tree for now. If
> you are looking at making any changes to accomodate my concerns in the
> short term, then perhaps we should refrain from discussing this topic
> so often? It may just be wasting space on the mailing list if there is
> no room for movement.

We probably should keep discussion of what you see as your role in
U-Boot to another thread, yes. But I don't know what to call your
personal not mainline tree if not a fork.

--=20
Tom

--kPM3MiNy2tju5770
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJ0KcACgkQFHw5/5Y0
tyxVkQv/U0D7XiV5elIR/BiUhC3k9YOuiXzOa+Hd7Mju2yk597j+b8oMl8ubd02/
zn4QK9Bhfj5eFZJ/6P99fkdqtnmksKa/vhWEeq2yBYf/Med54Tdx//0kXOESFwLT
0gIASHmW6jJ88SUq7/1S5LPhAGAozfCTfGy66COJlEOm9RMUiIZIsSVzuYWZnJKp
i6wVhAp86q9agaeS15VY5Qgp6I0e1EqpGVsWJHvxqgg1ZzA7Knx/dRNZKeib7Xy2
N3Kndlo8i3ZlnWQf8BZIwC7CBOPe9XGDO2o/aKcrbBK9CawdPu/koCTc12AXURha
O9NSG36v4rcYxg17b7zmAZIG1m1K1Cny7wvw9fOauMQ+QXDA54lUAMEI9A+SZvoo
6eQdHOBO8+bVpLDjx/wm9axw3HCTdELKmq4gPEYkU9vBtMrLKSKPa4OmP4VEy+jp
7ksbSsROgIl9M5DZm0LrjLLTXLuQn+LICLv3wiK03PgMvTDDiYacf+HMEqR1wN1p
oDnoif3g
=TukL
-----END PGP SIGNATURE-----

--kPM3MiNy2tju5770--
