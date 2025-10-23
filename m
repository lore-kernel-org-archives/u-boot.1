Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3C8CCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97918006D;
	Thu, 23 Oct 2025 23:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXkK1vpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EAF807C0; Thu, 23 Oct 2025 23:04:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100A58003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so13451905e9.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761253494; x=1761858294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEw9u6+7wd8kxtSfp2gSzlQkmdIcBQ0M/sxgzy4+a3o=;
 b=FXkK1vpfs+NrKSaDclt77AMAqTzxe1UqNwYhntTrr+x6pUOgX1VajVSzo8YHOC0y6S
 nhowPBPWzY9vOaYe+G+oy2gBX7uChtvl748BgbgYigjk05hQu3rNsheLhCRkE4/372F6
 M0/mkZTMOchr+lU+jyIbI5i7uxoB240BkRDAkUQM4KouamwEQkhnObE6dI79DTbSeFE8
 bx5cShmoA9enAp2oUX2s/K+KyoyXZUtYexBx0bdd+TguoGgZ0nrMWJgzvn5/qo7LXiA7
 wXH8FYo1EPjFU+uWi3NBiDnaQzZF6RGKOKD5twkJkWuNbB5rVvLeQTmToFQ43cAcSS6C
 8aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761253494; x=1761858294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEw9u6+7wd8kxtSfp2gSzlQkmdIcBQ0M/sxgzy4+a3o=;
 b=ORWKj9OcTknOW6kq5HMPMWnROQvTnmoCL1ojOjgiOSsCsXMqU4rQyBnmnPPQOowTNe
 wX9NX9Sv0mltu7VtQ83btm79nfyhcp+18iy3FHK+OmokPOp1dpTUzsfn6K7EzLNq908+
 OIGACqRBnvDUb5lQASMWyuZ+RpCJj2vGzSCKYAf80SO0fNPAxSIwZjsjb46s0Q1pPf24
 6zmZJLoWGH/VxwyiKd5oZQnFAn9VO+GU4zJI96cArXGqg8FiwaxrqbS8jB3WvXDbYrMF
 1HUmge3jskvbb2Hv6mga6k2eIX1HhBKpsCeZE1xrQXO+Kz2+zwtN3Gng0w1NCer0VJLT
 k3fg==
X-Gm-Message-State: AOJu0YyX6wnhk7GvhdFfDRit6x83zGNQI5eVApClNV/EJ5W4KYpBaU/V
 QUsI/uwTnwGktB+WRcpad+MC0gFJniJ9/w07EpPz+7X+GHgD6Kdh7NlG
X-Gm-Gg: ASbGncugztmlJ5dxqmTl0cfAD43ndTBKVA21sZbyOZamYVBzxdV72qzUnZlqAuwm7LD
 6WDNMYwcYB1GdSxdx/AEzR7cbeIWK+IZBBS6aybvAD4yAXoTFVO0BcESfLLavg6q/Rp3hUu8lG/
 rW0lRHseQz3Bvk8npW+edddsEaR801ylL9tStDHGIrVN9IwHcUHQ8LazSPxGU5JiohF/CG/CSTJ
 HwyeOTq/v6nye/1p6oa+hxSVM9z5UXnhxgne3NVFmYH7Lr1Y5JY/xBbxlRX/WJERQK4AB3r61+Q
 1gqSWLGoaRvzn6UXSBDQ5cQ6W+R0kKmvhaWIA8A7yc6yIwJqoi+GMwvMeecrbCFbUkoo0AvJ+K6
 NPm2B/3b2gnJm9XQMcav5MK2YMFAyjDRnLYn9pQ5jyHFpbfPVAczsfr29OpQPBwAg3zGiSFu03O
 nynfI5y5nLIcSwnZRjUm9818Rh9EQptR7mdUiSDuaJ3iFJVXixs/YSNkQN2Q==
X-Google-Smtp-Source: AGHT+IEqnzJFSiJxfI8VSEACqCfsTrWdSx38TCVnb497YLE0Hl/ZVjjHoElr0xaOc0kG8ZVF+r62vA==
X-Received: by 2002:a05:600c:1d9b:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-471178784c2mr208988935e9.6.1761253494156; 
 Thu, 23 Oct 2025 14:04:54 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net.
 [178.79.73.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474949dd479sm73213055e9.0.2025.10.23.14.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 14:04:53 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Rudi Horn <dyn-git@rudi-horn.de>,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: dram: detect non-power-of-2 sized DRAM chips
Date: Thu, 23 Oct 2025 23:04:52 +0200
Message-ID: <13869618.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20251022213339.2b9cb140@minigeek.lan>
References: <20251021235334.7557-1-andre.przywara@arm.com>
 <12763423.O9o76ZdvQC@jernej-laptop> <20251022213339.2b9cb140@minigeek.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 22. oktober 2025 ob 22:33:39 Srednjeevropski poletni =C4=8Das je=
 Andre Przywara napisal(a):
> On Wed, 22 Oct 2025 17:48:27 +0200
> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
>=20
> Hi Jernej,
>=20
> > Dne sreda, 22. oktober 2025 ob 01:53:34 Srednjeevropski poletni =C4=8Da=
s je Andre Przywara napisal(a):
> > > Some boards feature an "odd" DRAM size, where the total RAM is 1.5GB =
or
> > > 3GB. Our existing DRAM size detection routines can only detect power-=
of-2
> > > sized configuration, and on those boards the DRAM size is overestimat=
ed,
> > > so this typically breaks the boot quite early.
> > >=20
> > > There doesn't seem to be an easy explicit way to detect those odd-siz=
ed
> > > chips, but we can test whether the later part of the memory behaves l=
ike
> > > memory, by verifying that a written pattern can be read back.
> > > Experiments show that there is no aliasing effect here, as all locati=
ons
> > > in the unimplemented range always return some fixed pattern, and cann=
ot
> > > be changed.
> > >=20
> > > Also so far all those boards use a factor of 3 of some lower power-of=
=2D2
> > > number, or 3/4th of some higher number. The size detection routine
> > > discovers the higher number, so we can check for some memory cells be=
yond
> > > 75% of the detected size to be legit.
> > >=20
> > > Add a routine the inverts all bits at a given location in memory, and
> > > reads that back to prove that the new value was stored.
> > > Then test the memory cell at exactly 3/4th of the detected size, and =
cap
> > > the size of the memory to 75% when this test fails.
> > >=20
> > > This enables boards which ship with such odd memory sizes.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > > Hi,
> > >=20
> > > I don't really have a board with such an odd size to test that, thoug=
h the
> > > function worked on a 12GB A733 board. But that's not supporting the S=
PL
> > > or any kind of DRAM init yet, so was tested out of context.
> > > I would be grateful if anyone with a 1.5GB or 3GB board could test th=
is.
> > >=20
> > > Thanks,
> > > Andre
> > >=20
> > >  arch/arm/include/asm/arch-sunxi/dram.h |  1 +
> > >  arch/arm/mach-sunxi/dram_dw_helpers.c  | 16 +++++++++++++++-
> > >  arch/arm/mach-sunxi/dram_helpers.c     | 12 ++++++++++++
> > >  3 files changed, 28 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/includ=
e/asm/arch-sunxi/dram.h
> > > index 0eccb1e6c28..59e2e980bfa 100644
> > > --- a/arch/arm/include/asm/arch-sunxi/dram.h
> > > +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> > > @@ -45,5 +45,6 @@ unsigned long sunxi_dram_init(void);
> > >  void mctl_await_completion(u32 *reg, u32 mask, u32 val);
> > >  bool mctl_mem_matches(u32 offset);
> > >  bool mctl_mem_matches_base(u32 offset, ulong base);
> > > +bool mctl_check_memory(phys_addr_t addr);
> > > =20
> > >  #endif /* _SUNXI_DRAM_H */
> > > diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c b/arch/arm/mach-su=
nxi/dram_dw_helpers.c
> > > index 24767354935..14f6b24c30f 100644
> > > --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> > > @@ -143,8 +143,22 @@ void mctl_auto_detect_dram_size(const struct dra=
m_para *para,
> > > =20
> > >  unsigned long mctl_calc_size(const struct dram_config *config)
> > >  {
> > > +	unsigned long size;
> > >  	u8 width =3D config->bus_full_width ? 4 : 2;
> > > =20
> > >  	/* 8 banks */
> > > -	return (1ULL << (config->cols + config->rows + 3)) * width * config=
=2D>ranks;
> > > +	size =3D (1ULL << (config->cols + config->rows + 3)) * width *
> > > +		config->ranks;
> > > +
> > > +	/*
> > > +	 * There are boards with non-power-of-2 sized DRAM chips, like 1.5GB
> > > +	 * or 3GB. They are detected as the larger power-of-2 (2GB and 4GB),
> > > +	 * so test the last quarter for being able to store values.
> > > +	 */
> > > +	if (!mctl_check_memory(CFG_SYS_SDRAM_BASE + size / 4 * 3)) {
> > > +		size =3D (size / 4) * 3;
> > > +		debug("capping memory at %ld MB\n", size >> 20); =20
> >=20
> > As I already commented in first version of this change, wouldn't it be =
good to
> > add additional check here, just to be sure there is no misconfiguration=
? In such
> > case it would be better to panic than continue with unstable system.
>=20
> Mmmh, but what check would that be? I mean this is mctl_calc_size(),
> which is only called once, just at the end, before we return from
> sunxi_dram_init(). And it just calculates the size, there is no probing
> anymore, this has been done earlier, elsewhere.
> At this point we assume everything is fine and properly setup, so I
> don't understand what additional check we should do here. If we cannot
> read back what we have written, we are in deeper trouble anyway, but we
> would have missed that before anyway here, and it would have crashed
> sooner or later, so I don't see a problem.

My suggestion is to additionally check memory location size / 4 * 3 - 4,
which should be valid in case everything is configured properly.

Best regards,
Jernej

>=20
> Cheers,
> Andre
>=20
>=20
> >=20
> > Best regards,
> > Jernej
> >=20
> > > +	}
> > > +
> > > +	return size;
> > >  }
> > > diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi=
/dram_helpers.c
> > > index 83dbe4ca98f..376b7d14f86 100644
> > > --- a/arch/arm/mach-sunxi/dram_helpers.c
> > > +++ b/arch/arm/mach-sunxi/dram_helpers.c
> > > @@ -62,3 +62,15 @@ bool mctl_mem_matches(u32 offset)
> > >  	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
> > >  }
> > >  #endif
> > > +
> > > +bool mctl_check_memory(phys_addr_t addr)
> > > +{
> > > +	uint32_t orig, val;
> > > +
> > > +	orig =3D readl(addr);
> > > +	writel(~orig, addr);
> > > +	val =3D readl(addr);
> > > +	writel(orig, addr);
> > > +
> > > +	return ~orig =3D=3D val;
> > > +}
> > >  =20
> >=20
> >=20
> >=20
> >=20
> >=20
>=20
>=20




