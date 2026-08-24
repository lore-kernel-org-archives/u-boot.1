Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE71C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25A4660680;
	Mon, 24 Aug 2026 19:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODt8hZNmD52t; Mon, 24 Aug 2026 19:31:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787599880;
	bh=FXhOaLaS5S72S+/vIf1et1EFKhZsGB7nBItEVVwJeQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o8/BqB4vPNzxMAKZOjYf+8aScAlVR/fHZSirdNCfeCOMwF3Eb6KjvcKIgJ4VCoG1Y
	 9RMQgTbPl2nrUG80qn6UAdYvS4oQWPwQGzGt51Se+ePpWeTB9QQ6DJstCtu7Z+VPZg
	 bTo4oLApmujwINMs7smpFGlOcJ575siU25pegkvO0OnY25NHcGWnnkt3IgrH15RuoH
	 PxGpsXj7ONO6mWPQjll1/AXt711xDSg865jXZ4Z1H3S/XCvUBfTecQJNaBlpO2NQ2C
	 v8h1J3yh7QCBHG1K5bnNA2cXR5QUNVK/SrIsjA9nbvoNKozl02gagLKdENpEkStxR7
	 lspHIqc+symwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA61E6061D;
	Mon, 24 Aug 2026 19:31:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FDE04B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DD4880CC5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RtQwROCqolOC for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sLchlFUM
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CD6D80CC4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:31:16 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-44cf1835ec3so1653019fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787599876; x=1788204676;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FXhOaLaS5S72S+/vIf1et1EFKhZsGB7nBItEVVwJeQQ=;
 b=sLchlFUMEDKEygFH9NXeh8doM3A+t8rNUQlTvonC93nefuvyfjxsBY7KXGnApOM8i5
 1mJfhnVHAG+URkRBw2VRuM7o+EaHTqi5vR816rI6GaA1she/Z5qjc1Xz7Kq674M6cohn
 N8XsLyjhF8N8l/VGDfk+Q3Pmu8zZMuudAzhd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599876; x=1788204676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FXhOaLaS5S72S+/vIf1et1EFKhZsGB7nBItEVVwJeQQ=;
 b=p6s6APkueJnBna2z/VBEBIwHQQLCAwgZMoVobL+A7CQm0CUcvLq7b+TBDk5TG0Vt9z
 IF2zMDlbdJj1ffq0epCUOa7hkh6xIaeF6k7s5KPp97g15aXhdfnIKywPf+BEgu3OZeOE
 JIDi2w2b5p0Q4xrC0Vz7PqItEeNHsyFd0qWxyj+zTNNefGI37yuPh6w+k2IeeaoYihoH
 H7nbrDXU9dNzdfcQ1eCte4wRaarO0E6q3pR7ZhS3X3sV5JErs0TUs2J55pFCMi+JuAqf
 MpZQyJ8/rleWo/7pBHVxAkYfb2lBrLABiewQEaSYzr2uYQuh3MBuQ/1fWTYpUmJboA4A
 lDEQ==
X-Gm-Message-State: AFuF++mS4GOUmHEI5acVvKOSc4fdJWkQlccpzRJYKns1rVta0NKoBsLk
 /JiX6G9I7AalPEgYW5981I2kAMlLdwjlFntmeJ+aNqVNV4nPdc5E3EpVbP+hBXcqQ9k=
X-Gm-Gg: AR+sD11vcVS33Zo9EmMCpCNUfP8J8CtucQeBZk3KC7Z7AyZDXKnfqLK1BZTYtofQFAD
 QkCJKwwprc2SkhaOh6o16r36dN6AIymyv0en+Y6gcd+7DjqTbjHD4A7kR/WuQtzFvfg9NbyJDu8
 5DQee8KgruIAnVm2/PN1ep1PEAORIh/LVpW9/JifAgevryzq3wOxkmaAgGNMrbLHoKCXeTuMU/6
 pzJySnp8oUM7R0cQRfImayq0k0RoZfTKRrWKWF0TWlVy0a8W09l9Q4Du/9BdRMlzULHkrC0O1RX
 sLCRq209rkei1ueJHAt1euwwUC+m73m5fSQwN+7J5znhreIfVbGieEUumBnECeAm69z7WIMh7nH
 lRKcxV7iUNg6a9F+NNvetSXjhNIBnE2iGVQqTSzegleDg4rAQoRjbAo92IVQmSRmq1HxNmhQiiB
 /sPaP1pPffMnqYG1xokSlPFaWWT+y8jglToqY72KUqZEO+/E77YEBIeXUGMIyTPD8H6Lpxvj1Ys
 b44Y8xfIFDCmKcz4O85ayjM6HBKxU0IwgHih+3TPMbVTP8YqPTsUV1b2K8AZ3m8f5wf+G9Z0ue8
 OJrC60Y9t2xESdPQDpZf
X-Received: by 2002:a05:6820:2216:b0:6b1:51fa:2150 with SMTP id
 006d021491bc7-6b16b4cd3edmr18756821eaf.23.1787599875626; 
 Mon, 24 Aug 2026 12:31:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b17cc2c70dsm4449076eaf.13.2026.08.24.12.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:31:14 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:31:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/6] disk: Fix the GPT layout on media with large logical
 blocks
Message-ID: <20260824193112.GM523975@bill-the-cat>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <CAKTNdwGG1w9qe82UBWjBx3kWK15b2v4vcdKK8NG7vcEuHJocLg@mail.gmail.com>
 <CAKTNdwFM+HegQjasf4jP8iie1_8NA51ypg3WLxBdbVsmYeVdWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bP7tOgX6jtLLnQ1B"
Content-Disposition: inline
In-Reply-To: <CAKTNdwFM+HegQjasf4jP8iie1_8NA51ypg3WLxBdbVsmYeVdWw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--bP7tOgX6jtLLnQ1B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 02:21:11PM +0400, Alexey Charkov wrote:
> On Fri, Jul 31, 2026 at 7:30=E2=80=AFPM Alexey Charkov <alchark@flipper.n=
et> wrote:
> >
> > On Fri, Jul 31, 2026 at 4:40=E2=80=AFPM Alexey Charkov <alchark@flipper=
=2Enet> wrote:
> > >
> > > The GPT partition entry array is sized in bytes by the spec, so the
> > > number of blocks it takes up depends on the block size of the device.
> > > U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
> > > blocks at each end of the disk. On a device with 4096-byte native
> > > sectors, such as UFS flash, the backup entry array ended up 28 blocks
> > > short of the backup GPT header instead of immediately before it, and
> > > roughly 114 KiB was wasted at each end of the disk.
> > >
> > > Patch 1 calculates the count from the block size and makes the four
> > > places that need it share one helper, since they disagreed with each
> > > other in different ways. Note that it also changes the 512-byte layout
> > > for boards that do not use the default entry count:
> > > CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
> > > is set to 64 by a number of Rockchip defconfigs, and on those
> > > first_usable_lba moves from 34 to 16 and 18 respectively. Existing
> > > tables stay readable, since the entry array is always located from the
> > > on-disk partition_entry_lba, and only newly written tables are
> > > affected. Partitions given without an explicit start=3D will be placed
> > > lower, though, and on sunxi first_usable_lba lands exactly on the 8 K=
iB
> > > SPL offset, so sunxi and Rockchip folks may want to look at patch 1
> > > specifically (none of the devices I have override the default).
> > >
> > > Patch 2 is an unrelated big-endian correctness fix in the same file,
> > > noticed while auditing it: a few header fields are read without
> > > converting from little-endian, and one already-converted value is
> > > swapped a second time.
> > >
> > > Patch 3 is another unrelated bug that has to be fixed before any of t=
his
> > > can be tested: part_test_mac() reads one block into a 512-byte on-sta=
ck
> > > buffer, so it corrupts the stack on any device with larger blocks. Si=
nce
> > > it runs during partition probing on every device, sandbox crashes on =
any
> > > access at all to a device bound with a 4096-byte block size.
> > >
> > > Patches 4 and 6 add the tests. The C test sweeps block sizes from 512=
 to
> > > 32768 against gpt_fill_header()/gpt_fill_pte() with a synthetic
> > > descriptor, and the Python test writes a real GPT to a host device wi=
th
> > > 4096-byte blocks and checks the resulting on-disk headers. Both fail
> > > without patch 1.
> > >
> > > Patch 5 is a prerequisite for patch 6: test_gpt_write_part_type() nev=
er
> > > binds its own disk image and has only worked because an earlier test
> > > left host 0 bound, so it breaks as soon as a test binding a different
> > > image is added above it.
> > >
> > > One known gap: test_gpt_write and test_gpt_write_part_type hardcode t=
he
> > > 128-entry 512-byte layout, so they fail if sandbox is configured with=
 a
> > > different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
> > > their expectations instead, and pass at 56 and 64 entries. No sandbox
> > > defconfig upstream uses anything but 128, so I have left the old tests
> > > alone.
> > >
> > > Tested by building sandbox (default, flattree, sandbox64, gcc and
> > > clang), generic-rk3576 (gcc and clang), sonoff-ihost-rv1126 and
> > > A20-OLinuXino_MICRO-eMMC on armv7, and boston32r2 and boston64r2 for
> > > MIPS32/MIPS64 big-endian, which is what patch 2 is there for.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > > Alexey Charkov (6):
> > >       disk: part_efi: Size the partition entry array from the block s=
ize
> > >       disk: part_efi: Add missing endianness conversions
> > >       disk: part_mac: Fix stack corruption on devices with large bloc=
ks
> > >       test: dm: part: Check the GPT layout for large sector sizes
> > >       test: py: gpt: Bind the disk image in test_gpt_write_part_type()
> > >       test: py: gpt: Test the GPT layout on a device with 4096-byte b=
locks
> > >
> > >  disk/part_efi.c           |  55 +++++++++++++++-------
> > >  disk/part_mac.c           |  12 ++---
> > >  test/dm/part.c            | 100 ++++++++++++++++++++++++++++++++++++=
+++
> > >  test/py/tests/test_gpt.py | 116 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 261 insertions(+), 22 deletions(-)
> >
> > NB: the CI passes all green:
> > https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pip=
elines/841
>=20
> Gentle ping regarding this series. All patches got R-b, can this
> please be applied?
>=20
> get_maintainer.pl says these fall under "THE REST" - Tom, can you
> please pick it up?

I assigned this to Heinrich in patchwork as it's adjacent to other areas
he owns and was hoping he'd be able to provide some review.

--=20
Tom

--bP7tOgX6jtLLnQ1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoyb/AAKCRAr4qD1Cr/k
Cr1DAP9toRdYjv+rXma255rbORDXzhLFOpEMiklc5ij2ymI1PQD+MuaaT97+fb/M
49L4NfOJUYTNfvHDkPH2uDex1j0aVgI=
=wDP7
-----END PGP SIGNATURE-----

--bP7tOgX6jtLLnQ1B--
