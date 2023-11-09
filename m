Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8988DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 18:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2F8D8746A;
	Thu,  9 Nov 2023 19:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LsNKbn7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3115F8729D; Thu,  9 Nov 2023 19:51:25 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5240874BD
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 19:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7789577b53fso74206685a.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 10:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699555881; x=1700160681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D8yM6BmpCERLCrfn/0uGkU45aMhHpKrNwkAbgdxnLEE=;
 b=LsNKbn7ppItzK/3OL4gzi6gAqOENLkeCqP+zF4Fsna0vPa4eL8iEaYKXD8qjVazZpD
 rqqQs2VFcwNqSfuCfkiVeNx9MSnAWTrvccj3qU8YgSlpNspKvfzZrxyoYBvl03cZc40s
 5ErgUN1aLUQTJ2oFRGIMK1GMWA9SIrmf2DDbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699555881; x=1700160681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8yM6BmpCERLCrfn/0uGkU45aMhHpKrNwkAbgdxnLEE=;
 b=juQzTpvEh9332ENwCnkgA2duTyLu8enhR5l0yd+A7GygS4Kk1r6HUdBTgN3sHMysOA
 NL5jvt9u00Mp7e389gEcyxtylDicqz1FGUqjqse772FK2bIVsXgilPOavVtGQhYeUMYR
 rSBscxH2bddsOR2yxpATUY4sNRmuV96QvJLx5+zGfP0wXIJCCqHxz7RkBe/TzkOB6Umy
 gLtY5F6TXRMfrG/u/k9fWY8x6kRZo0VxDgIgtb09qGGXbNGewr45Qy37ApueyZl8+kT2
 Ca5V1mwSxsUAc+Pf0KSfKPtluQK9P9nV5JvpLz8PRnOIHWHrfLeRV/879tGH4vXSNuc5
 kyog==
X-Gm-Message-State: AOJu0Yyffcc0+r4Vp1v4fIebCIunyV0z6RYDhl3pULftfPFmPflA6LBT
 3sBipzHhV7BAbgaByoORKz9YOA==
X-Google-Smtp-Source: AGHT+IEJHcFEAKqNIJDFe8OD/0Ou/OIcHTY79uumNSGqP7BBB/TPHJz5IzjIYjXHk9U0aq+OJJRNyg==
X-Received: by 2002:a05:620a:2916:b0:77b:b1d2:955f with SMTP id
 m22-20020a05620a291600b0077bb1d2955fmr5547166qkp.4.1699555881482; 
 Thu, 09 Nov 2023 10:51:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a05620a0ec100b0076f21383b6csm99156qkm.112.2023.11.09.10.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 10:51:21 -0800 (PST)
Date: Thu, 9 Nov 2023 13:51:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>,
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Suman Anna <s-anna@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 1/1] arm: mach-k3: Enable icache on am625 to boot
 faster
Message-ID: <20231109185119.GG6601@bill-the-cat>
References: <20231109140958.1093235-1-joao.goncalves@toradex.com>
 <20231109173741.cuxbq4rtu4nhvath@pagan>
 <e27d44a1-03c2-44cf-857f-947c5f4c4796@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wsCTRntWSxPeoL9/"
Content-Disposition: inline
In-Reply-To: <e27d44a1-03c2-44cf-857f-947c5f4c4796@ti.com>
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


--wsCTRntWSxPeoL9/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 12:44:56PM -0600, Andrew Davis wrote:
> On 11/9/23 11:37 AM, Nishanth Menon wrote:
> > On 11:09-20231109, Joao Paulo Goncalves wrote:
> > > Enable the am625 instruction cache on SPL and U-boot earlier for the =
A53
> > > to execute code a bit faster. For normal boot flow, it was possible to
> > > gain about 2 seconds on boot time.
> > >=20
> > > Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > > ---
> > > Hello all,
> > >=20
> > > We are trying to optimize boot time on our AM62 devices and on TI com=
munity
> > > forum [1] someone advised to enable ICACHE for am625. We enabled it, =
tested and got
> > > around 2 seconds faster boot on storage media and about 5 seconds wit=
h DFU
> > > for downloading images from A53 SPL. However, we don't know if this i=
s the correct
> > > solution and want more comments on this or why the ICACHE was not ena=
bled by TI in
> > > the first place.
> > >=20
> > > [1] https://e2e.ti.com/support/processors-group/processors/f/processo=
rs-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot
> > >=20
> > > Regards,
> > > Joao Paulo Goncalves
> > >=20
> > >   arch/arm/mach-k3/am625_init.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_i=
nit.c
> > > index 8fa36f7b91..d665d07b0b 100644
> > > --- a/arch/arm/mach-k3/am625_init.c
> > > +++ b/arch/arm/mach-k3/am625_init.c
> > > @@ -210,6 +210,9 @@ void board_init_f(ulong dummy)
> > >   			panic("DRAM init failed: %d\n", ret);
> > >   	}
> > >   	spl_enable_dcache();
> > > +
> > > +	if (!IS_ENABLED(CONFIG_CPU_V7R) && !IS_ENABLED(CONFIG_SYS_ICACHE_OF=
F))
> > > +		icache_enable();
> > >   }
> > >   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> > > --=20
> > > 2.34.1
> >=20
> > Just noticed that icache_enable was missed for all of k3 as well - I
> > suspect this is a miss rather than anything consciously done. btw
> > icache_enable is already wrapped correctly under CONFIG_SYS_ICACHE_OFF =
in
> > cache_v8.c
> >=20
>=20
> For U-Boot proper, both I/D caches are enabled early in board_init_r().
> Oddly the SPL version of this function does not do that. Some boards seem
> to work around this by adding it manually, others must have missed this.
> Maybe due to armv7/start.S doing this for us already, but not armv8/start=
=2ES..
>=20
> We enable Icache in SPL for our CPU_V7R case inside setup_mpu_regions()(?=
?)
> We also enable Dcache in spl_enable_dcache(), maybe this should be
> renamed spl_enable_cache() and it call enable_caches() which enables
> both. Just be careful to invalidate the icache when enabling after
> relocation.
>=20
> This would be temporary, better solution would be to add it to the
> SPL common board_init_r() to match the U-Boot one, that way all these
> platforms wouldn't need to do it in their current inconsistent ways.

I will say that part of the reason we don't have a more high-level
"enable all the caches in SPL on ARMv7" is that I never could figure out
why on earth it locked up my am335x GP EVM, I believe. So yes, I'd be
quite happy to see the mach-k3 case cleaned up and made generic to
enable (and then disable/flush/enable in full). But we can't easily make
it higher-level than that.

--=20
Tom

--wsCTRntWSxPeoL9/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNKiMACgkQFHw5/5Y0
tyxQkAv/cmL32pW9UG5ZNpGve6PRIGdOSGqVMM87mRgCjm0lgBeY1sSHq3NLA9+z
ioBGsh0QyDr1dp9vhiv/f4QWGAG0Ue97wliPHo3pFjv7VdT1FlzoqliDIXKthHsm
ib0dMjAPf7GRRn1ciuHSOTbHYC4ckoRaoYzGUNrjPfLyGknYJNyMwYGvDCOLQGEL
ko0DH2kWwNTqYNr9eMwUr3/vIfglJN7QAtKO0kadHyBlcTLVnhkSlDlnNan9Vhdj
tuf0ET7aeO1FVlvU5PR9nGpKaU0qpgjFmschnD9awWPsMwn810W+2QDugJwD3XG7
XE4iKtwjRnjGreQhWIedEP/JYZVDhEdp+32SigMtNcUkb480qIXkicH1jBoQYiqk
Wu5VRK3WuKR542I+jrxH9HpsTSjJOHFX/jLS8OCDB/vZGTM+HhxtSD7Jb+8HE9NC
Qbu32sLAKdOdMv6IAR4cIn30uabsp1BjgcNDaSe8EfVJb5+WcmpOjD/qkFG4jpF4
1Jtszf2M
=lmVv
-----END PGP SIGNATURE-----

--wsCTRntWSxPeoL9/--
