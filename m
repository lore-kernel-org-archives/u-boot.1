Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD19C83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 15:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F1D800D7;
	Sat, 12 Jul 2025 17:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXnMI9xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29207803DF; Sat, 12 Jul 2025 17:48:54 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C782180050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 17:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ef60dbaefbso1909200fac.1
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752335330; x=1752940130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MFJ0PPtI16h4br8wuXo7JKHDkcllQy/vdBd0CYk5VD0=;
 b=XXnMI9xdidKgrf283c4BaZ2XddhLdaD2y092kbjQ2h62iYOy96sSIlY3wx84kSs9NM
 ugSOlmxNI0HN8r9vrt4VmpXdyWFBMjNL/+Ln+GM9W3ACVuGrqlE67YhssSUZVBgieeWv
 xWJDUmjdK0pVkvHdGctcs/GTxmPqI255ZKWiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752335330; x=1752940130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFJ0PPtI16h4br8wuXo7JKHDkcllQy/vdBd0CYk5VD0=;
 b=DGhR1+SDg0h6JvpRltXgPXl5ioMgPoo1wqtd5oIWzqN5VhrkVW0n7VWzs7niQr3qa/
 WZoisVMXZgWK9KJwTPHLFxXzdy4yLOi8N9k/bH6zY0l5dRSC3M9jomfg1tIv44dUijXp
 AWzVghII9toVMROfnZswGflNY6jYe1bwgHYUIdLv+hyB9K5gpdMTTduZtzFoIZHfNTqR
 wgeo+14Dbm+5iGnjtzZZ+bwfkb9RQquk5u/HMaahUEv2K0oZ67KBpSUOMq4+BJH04nYB
 XfD0zFQe2NtqBTo/cNpkLzNx1UYtX2Sjskni0r0n7f0sRt3Tu0EZDp1ND9ju28mTCNnB
 Cr+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvF2smIHqst0/ZcEskSYXwFST9cKo39A4SMTTdZtPQmMWvKfYyl5mbfc/zkJFSYNuz5ypsj7U=@lists.denx.de
X-Gm-Message-State: AOJu0YxyIQnZd7bioooLYVhsJjkw9+bdmJBEmp3CrfQK/cj0WjLDYHes
 SSeNFaZWffPOTepETfbPBTRYKNuGGHdS5c5Wjz8GEFDmbuKjGbbkfTXxObMi7gRHGgw=
X-Gm-Gg: ASbGncvmuyeoDorCYdU0LPc5dL00HkF41rtRz9cLMPAmMX4Cdg4rJX+zxRwSHiyRVYC
 FXYZJ8+s2NikR2JAgZlELi/dmkTYma767tqjv91YMUfRwlJ04GOamBQbVkRfnm82/Z1MIFAsyw0
 lc7QB2zyuLw2tjJZOpTd3sStxcpbBckf7J2LQl1cHBYxswi1DnvujPnBdR2zSbKFBFKzv0bEwjP
 6hz9p34r73xPO/QEmWYophbxmq886aMhJDT4Gjqsd+FzB+B6OBFV5RIuY5y7hqNlLejQAXTvBgD
 Ew4JUosB5PiR1og6uXQDc2Rn6U/Ap6sfxIM1/QbskzqIdIOUHuU/s33A3oL77Xg+PeGQp4FQ2Ft
 mk5addi+8W1iFOHkrdIYoQRCGUDSnw3zQIn1nmpH7rVDpgjMZr52NS4zR
X-Google-Smtp-Source: AGHT+IHoQUImERxlqnV2aWVaH845+7uorKr4CIghEUUCiwQjma2LKC0KvntYfUmUkIY7yeQnqKBb/g==
X-Received: by 2002:a05:6870:2891:b0:2fe:f4f4:8506 with SMTP id
 586e51a60fabf-2ff2676c61amr5101602fac.10.1752335330306; 
 Sat, 12 Jul 2025 08:48:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff111c3776sm1174038fac.8.2025.07.12.08.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jul 2025 08:48:49 -0700 (PDT)
Date: Sat, 12 Jul 2025 09:48:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, u-boot@lists.denx.de,
 josef.holzmayr@northern.tech
Subject: Re: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
Message-ID: <20250712154847.GM6424@bill-the-cat>
References: <20250711185512.2250368-1-trini@konsulko.com>
 <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
 <CAC_iWjJQh8M8KsscLb6JXkFH4t+wr+oi9xX=gko6ztPm2YuQWw@mail.gmail.com>
 <87y0stbssf.fsf@bloch.sibelius.xs4all.nl>
 <87wm8dbp1e.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P9+bhUCVfqUf9Erz"
Content-Disposition: inline
In-Reply-To: <87wm8dbp1e.fsf@bloch.sibelius.xs4all.nl>
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


--P9+bhUCVfqUf9Erz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 01:56:45PM +0200, Mark Kettenis wrote:
> > Date: Sat, 12 Jul 2025 12:35:44 +0200
> > From: Mark Kettenis <mark.kettenis@xs4all.nl>
> >=20
> > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Date: Sat, 12 Jul 2025 09:28:07 +0300
> >=20
> > Hi Ilias, Heinrich and Tom,
> >=20
> > As you probably know, OpenBSD/armv7 relies on EFI_LOAD, so disabling
> > EFI_LOADER on a platform means you can't boot OpenBSD on it.  Ilias
> > and I talked about this a while ago.  We talked about telling QEMU to
> > use an older version of the architecture that didn't do this alignment
> > check, but that may have been based on a misunderstanding of the
> > changes in QEMU.
> >=20
> > At the time I didn't look any further into this, but I did now.  And
> > I'm confused because...
> >=20
> > > Hi Heinrich
> > >=20
> > > On Fri, 11 Jul 2025 at 22:35, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > > Am 11. Juli 2025 20:55:12 MESZ schrieb Tom Rini <trini@konsulko.com=
>:
> > > > >As part of upgrading to QEMU 10.0.0 we discovered that the EFI loa=
der
> > > > >tests would no longer pass CI, on this specific platform, while st=
ill
> > > > >passing on real hardware. Upon further investigation it turns out =
that
> > > > >on ARMv7 we rely on some undefined behavior with respect to enabli=
ng
> > > > >unaligned access. And while this is seemingly fine on real hardwar=
e,
> > > > >QEMU is now correct enough in implementation to no longer allow th=
is. In
> > > > >order to not rely on this undefined behavior we would need to impl=
ement
> > > > >some MMU configuration (and then ensure proper tear-down possibly).
> > > > >
> > > > >At the moment, the most reasonable path forward seems to be to doc=
ument
> > > > >this and disable the support here.
> > > >
> > > > Where will we document the issue?
> > >=20
> > > I think we can add it on the EFI documentation? IIRC we only enable
> > > the i-cache not the mmu + d-cache. I can double check and send a
> > > patch.
> >=20
> > There is code in U-Boot to enable the MMU and the D-cache.  The code
> > turns on the MMU gets turned on when we turn on the D-cache, which
> > happens when we call dcache_enable().  That function typically gets
> > called from the board.c file and the one used by vexpress_ca9x4
> > doesn't seem to do that.  But other ARMv7 targets do.  For example in
> > arch/arm/mach-sunxi/board.c we have:
> >=20
> > #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) && defined(CONFIG_CPU_V7A)
> > void enable_caches(void)
> > {
> >         /* Enable D-cache. I-cache is already enabled in start.S */
> >         dcache_enable();
> > }
> > #endif
> >=20
> > Note the CONFIG_CPU_V7A there.  This means that for the Allwinner
> > ARMv7 SoCs, which typically use Cortex-A7 cores that do include the
> > virtualization extensions and therefore should implement the stricter
> > unaligned access checks, we do enable the MMU.
> >=20
> > > >  Does it imply that we should discourage EFI use on all ARMv7 syste=
ms?
> >=20
> > So no, it does *not* imply we should discourage EFI use on all ARMv7
> > systems.
> >=20
> > > The spec says the MMU must be enabled, so I think yes. I thought about
> > > disabling it, but that's too strict.
> > > Perhaps someone that uses v7 and *needs* EFI can look at enabling the
> > > MMU with a simple identity mapping.
> >=20
> > That should be as simple the diff below.  I've not verified if that
> > fixes the QEMU issue, but I strongly suspect it will.  Whether this
> > works on actual vexpress hardware is a different issue though.
>=20
> Fixes the issue with QEMU 9.2.2.  Before it would reset, now it boots
> into the OpenBSD installer just fine.
>=20
> > diff --git a/board/armltd/vexpress/vexpress_common.c b/board/armltd/vex=
press/vexpress_common.c
> > index 6c374e25e32..3833af59b09 100644
> > --- a/board/armltd/vexpress/vexpress_common.c
> > +++ b/board/armltd/vexpress/vexpress_common.c
> > @@ -165,3 +165,11 @@ void smp_set_core_boot_addr(unsigned long addr, in=
t corenr)
> >  	writel(addr, CONFIG_SYSFLAGS_ADDR);
> >  }
> >  #endif
> > +
> > +#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> > +void enable_caches(void)
> > +{
> > +	/* Enable D-cache. I-cache is already enabled in start.S */
> > +	dcache_enable();
> > +}
> > +#endif

Thanks Mark! I was hoping this would spur some further discussion and
perhaps a patch. Please post this formal patch and I'll go reject the
patch I posted now.

--=20
Tom

--P9+bhUCVfqUf9Erz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhyg9sACgkQFHw5/5Y0
tyxlfgwAukQ9yCVpGGV8hd8syNzGm+2uiRTyxgpeA6BA5zlM7ImbJtH4WFTjxcJn
8KE+2WsTKhg5ubzhw25/4CprZTWhBs9Nff9d0aWc1CkEyDqo2TOviJTz+MsXjEOp
IZ+tzcMkjZV9c2SI+EY0RmUm5GoOjq3oS1NoCAE8yGY3KGeOe0YPeKs/O3bErJHZ
9XP5xa61ReGjt1uCApdpASxwlEKNnEyO0Rf3AvNhi9vHqR83sR2aK9jAee3+Huyn
VSjZLylYjIWBmO1quqnFkGMxVFTR0UaYB0n40gdgyrV572AvKzKIupcoIM4kBnnB
8VlbkOBOcIctJk07arLhOzHVl963mP7pchQDx++mEzTNP+kpLpSMGzWQAZljqxan
ZkU718N3NFV8GtYKqZJ07Mdq5kLtns+y0LHRjsAP5CjiLj4jQyA0BQV5vEpq9gN8
ZQ0Vo4b7qjX99eTVrqCllC5bRuHjlRuNnYpMRwc1BZMaYU0o3F7XdOJbiO01Wbv6
VwPIFQKj
=RqSp
-----END PGP SIGNATURE-----

--P9+bhUCVfqUf9Erz--
