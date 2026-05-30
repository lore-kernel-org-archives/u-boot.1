Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCA8CD4F54
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 23:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C276B8405A;
	Sun, 31 May 2026 01:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="KYItPida";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F01840ED; Sun, 31 May 2026 01:17:51 +0200 (CEST)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7608404D
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 01:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780183067; x=1780442267;
 bh=GUyF+0hlzDzp1h1WMRhYWUVeV/v+hv4USv3Z+ksc9XA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=KYItPidavxfgN8hqgFEqBd87jmQ4VKnrD0MvGF2rymZTKd9NE2UUCETcBbh1ZhOKC
 DTyAmhQu1NoQ1OEDfFzx0iORQFBxeNbtFgeiqeA35Z0RwzfPtLRVaRdcSx8nBPHb5P
 lVTkHlhiFqOSi1PABFnVGFZObhzvnfywiFeEx8B4eeREUnrBNUMw4JRoCEUymrlXQ1
 deio2HGtjwJvUbSquDX2Cz1YcLUUYr0gds1xCGsgwa9c6XxNEBTwFQfgYxtCRB9pmB
 i1EMPGWhVy/3t/poa3QCVcR7q47QFBm7YQo2RnoY55/NpdLz/4ntqg6CVlOHp0Tc/a
 FWO8MyRLO4iQA==
Date: Sat, 30 May 2026 23:17:45 +0000
To: Peter Robinson <pbrobinson@gmail.com>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>, Brian Sune <briansune@gmail.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] arch: arm: force 4K page alignment in linker
Message-ID: <zcSwtbT7sl3-5-s5h8aj8fvo60sPtUBMZvT7Zoapeo0bj61KJ5aGQsakCmTyEdFYKBUsmZYPTL30vyIhfijb_Jxcfpb7BKvoGJQe8BOtQQQ=@samcday.com>
In-Reply-To: <CALeDE9PZDe4WdpDxe_3mwWqsobZp6AsBz-OG+5Gp89Bam8FdzQ@mail.gmail.com>
References: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
 <CALeDE9PZDe4WdpDxe_3mwWqsobZp6AsBz-OG+5Gp89Bam8FdzQ@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 6ae2dc52649f9567e2ed636261764929b3592ffb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hey Peter,

On Friday, 29 May 2026 at 8:18 PM, Peter Robinson <pbrobinson@gmail.com> wr=
ote:

> Hi Sam,
>=20
> > Since 5c71f8110, the u-boot.elf produced by dragonboard410c_defconfig n=
o
> > longer fits in the 1MiB aboot partition it is intended for.
> >
> > To be precise, this issue occurs on toolchains that have a linker with =
a
> > COMMONPAGESIZE > 4K. Since u-boot is hardcoded for 4K granules, we
> > ensure that the linker doesn't try to align to anything larger than
> > that, otherwise we're just filling our ELFs with a bunch of useless
> > zeros.
>=20
> Is this just applicable to ELFs or can it be applied more widely?

I'm not completely sure :)

These linker options control ld's constants [1]. COMMONPAGESIZE is used
to align sections in arm32/arm64 linker scripts [2]. Whether this affects
anything else besides that is not fully clear to me.

>=20
> > Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > Signed-off-by: Sam Day <me@samcday.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
>=20
> Tested on a Rock960 where the elf output went from 9498864 to 9437424

This isn't much of a change at all, I wonder what toolchain you're using,
and what its default COMMONPAGESIZE is? You can run the snippet below to
find out.

```sh
echo 'SECTIONS { cps =3D CONSTANT(COMMONPAGESIZE); }' > /tmp/pg.lds &&=20
  echo 'int x;' | aarch64-linux-gnu-gcc -x c - -c -o /tmp/pg.o &&=20
  aarch64-linux-gnu-ld -T /tmp/pg.lds -o /tmp/pg.elf /tmp/pg.o &&=20
  aarch64-linux-gnu-nm /tmp/pg.elf \
  | awk '/cps/{print strtonum("0x"$1), "("$1")"}'
```

[1]: https://sourceware.org/binutils/docs/ld/Symbolic-Constants.html
[2]: https://github.com/search?q=3Drepo%3Au-boot%2Fu-boot%20COMMONPAGESIZE&=
type=3Dcode

Cheers,
-Sam

>=20
> > ---
> >  arch/arm/config.mk | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> > index a7eff84a267..bce9a31e966 100644
> > --- a/arch/arm/config.mk
> > +++ b/arch/arm/config.mk
> > @@ -112,6 +112,14 @@ endif
> >  # needed for relocation
> >  LDFLAGS_u-boot +=3D -pie
> >
> > +ifeq ($(CONFIG_ARM64),y)
> > +# U-Boot uses fixed 4K granules, so we force the linker to match.
> > +# Otherwise, we're subject to toolchain preferences, (e.g Fedora's
> > +# aarch64-linux-none toolchain selects 64K granules) and we end up was=
ting
> > +# a lot of space in ELFs with MMU_PGPROT enabled.
> > +LDFLAGS_u-boot +=3D -z common-page-size=3D0x1000 -z max-page-size=3D0x=
1000
> > +endif
> > +
> >  #
> >  # FIXME: binutils versions < 2.22 have a bug in the assembler where
> >  # branches to weak symbols can be incorrectly optimized in thumb mode
> >
> > ---
> > base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa
> > change-id: 20260528-4k-page-alignment-6cb594a073b0
> >
> > Best regards,
> > --
> > Sam Day <me@samcday.com>
> >
> >
> 
