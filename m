Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DACC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E0680E90;
	Thu, 30 Jan 2025 17:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j6cWFv01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BC880EB1; Thu, 30 Jan 2025 17:03:58 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3A080E90
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-29f7b5fbc9aso295629fac.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738253034; x=1738857834; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dz9v5ByXYNvF2yV9mm/LFIjg++/+F7eHNDbT1hhqQXI=;
 b=j6cWFv01lVdnSy5CCySPGiDxjFo3nqYQbMk9oIeyluevpMuolN9XIMzaEXDShcHWrP
 xoYO5B6mfNKHL7x9/7yjIf01sMoiOiglNFL+bY/btEljbP0VHNRq0ksz3Jd/wu3KntFz
 jdFLuOwHXZiul+JlkVZPS/EwAHR13FRsBPe00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738253034; x=1738857834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dz9v5ByXYNvF2yV9mm/LFIjg++/+F7eHNDbT1hhqQXI=;
 b=er9OWcGtR9lYYRnxaRpIcfKcwW4jlYM/Je5z0RotAku4Z5z+PeLgeHyosyS4JuyE0k
 FHa7X2jL2nVB/kKqrwRzrJcn1NpSW3bSFgKni+1MjPxrsIBGSSgCKdZJ0TFq3fclwJGT
 rjY9d/E5Uml3sq7RaC+oLfieB7pmja04OHztlh57uRPRLhzCJX/WdojKG9BRK1mPejRA
 qY408919MXqPnplwit5PetZvRfbqc7gsQo7GfIQHCpK1DGDiWttYajDnCW9PuHJNgsSe
 3D6PaBRaQAt9f+qVWN6yQeyanwUdjA92thp75FWSeJGEuwS5vqMKbnQS17NsY/9Zmtrx
 z5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDjC9/t6O8jD3hBIdn4dFtR7Pavf9jBM3K6RQiSuL9bhVoGybMVp7c88nSbAC/LCGa0qTyPfw=@lists.denx.de
X-Gm-Message-State: AOJu0YxZDRUe4RJ0e1mh44+2tgPDMwsjJZgKSKpGR0BApJt81AC6/qT/
 5xiqt6ClnuPxw+GNTetuHzNm4yTcn9kDg79P7P22gM7RR75ccSShRIvMaUJjWrA=
X-Gm-Gg: ASbGncvn4amL/+ts4lEhz95Y2MvImm/wskced6BuwEsY0ejcqgia9NGvIKDcySpgvVd
 NRQ/T9kFdd/g12jHHZw+Vrq8cTvbISSocAOdF92dveMu1GLtyLNTNtaqPwX6FPE2mA9a0K2GN7M
 +7+CaqI+fvZtJ59wSft/AgrdXf/YEl68oOoaWPp9u4jMCsYU0Kh+EtLbXOe5M0Lo7WaEPF7EmEx
 EaoFPZF73+DzSsWB2BHr1lAxwXUub61yXwtnxK6ZTzLX+DVjAAToEZcS3XHl0pY463lu6Xoy6UL
 Hq2C7kus711NmQI=
X-Google-Smtp-Source: AGHT+IHBr0+2tsfacCIrgm5BYEoO3+8MDf5jETW4eF3ECe2eyaltHgDKTkzjiBOtZ9PPYl0jvZ63Uw==
X-Received: by 2002:a05:6871:a0ca:b0:29e:3484:ae1d with SMTP id
 586e51a60fabf-2b32f270745mr5004992fac.26.1738253034508; 
 Thu, 30 Jan 2025 08:03:54 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b356650aa1sm463845fac.47.2025.01.30.08.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 08:03:53 -0800 (PST)
Date: Thu, 30 Jan 2025 10:03:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, maz@kernel.org, CFSworks@gmail.com
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
Message-ID: <20250130160350.GB1233568@bill-the-cat>
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
 <bc481af0-64f1-47f4-af19-1aba64c2ae6c@gmx.de>
 <CAC_iWjKSFq-hhwzoxw9XMXj92fpmy1uz_J-kdqvYx0Ju6HcUMg@mail.gmail.com>
 <2fbcb4c8-52d4-48a3-a2bf-f7cd8fb20a30@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="npP35zkSZbDqPVeD"
Content-Disposition: inline
In-Reply-To: <2fbcb4c8-52d4-48a3-a2bf-f7cd8fb20a30@gmx.de>
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


--npP35zkSZbDqPVeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 02:36:40PM +0100, Heinrich Schuchardt wrote:
> On 1/30/25 10:35, Ilias Apalodimas wrote:
> > HI Heinrich
> >=20
> > On Thu, 30 Jan 2025 at 12:01, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >=20
> > > On 1/30/25 07:20, Ilias Apalodimas wrote:
> > > > Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> > > > Fix the meminfo command to display them properly
> > > >=20
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >    arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
> > > >    arch/arm/include/asm/armv8/mmu.h |  2 ++
> > > >    cmd/meminfo.c                    |  5 +++++
> > > >    3 files changed, 24 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cac=
he_v8.c
> > > > index 5d6953ffedd1..a4ca56c8ed42 100644
> > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > @@ -421,7 +421,7 @@ static int count_ranges(void)
> > > >        return count;
> > > >    }
> > > >=20
> > > > -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> > > > +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
> > > >    #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) =3D=3D PTE_TY=
PE_TABLE && (level) < 3)
> > > >=20
> > > >    enum walker_state {
> > > > @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
> > > >    static void pretty_print_block_attrs(u64 pte)
> > > >    {
> > > >        u64 attrs =3D pte & PMD_ATTRINDX_MASK;
> > > > +     u64 perm_attrs =3D pte & PMD_ATTRMASK;
> > >=20
> > > The variable perm_attrs is not needed. You could use pte directly.
> > >=20
> > > > +
> > > > +     if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_U=
XN) &&
> > > > +         perm_attrs & PTE_BLOCK_RO)
> > > > +             printf("%-5s", " | RO");
> > > > +     else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BL=
OCK_UXN))
> > > > +             printf("%-5s", " | RW");
> > > > +     else if (perm_attrs & PTE_BLOCK_RO)
> > > > +             printf("%-5s", " | RX");
> > > > +     else
> > > > +             printf("%-5s", " | RWX");
> > >=20
> > > The string has 6 characters. "%-5s" does not match!
> >=20
> > Ah thanks! That's the misalignment i was chasing
> >=20
> > > As the string length is known using a length identifier is superfluou=
s.
> > >=20
> > > It would be helpful to add descriptions to the flags in
> > > arch/arm/include/asm/armv8/mmu.h.
> > >=20
> > > https://documentation-service.arm.com/static/5efa1d23dbdee951c1ccdec5
> > > describes:
> > >=20
> > > "The Unprivileged Execute Never (UXN) and Privileged Execute Never (P=
XN)
> > > attributes can be set separately. This is used to prevent, for exampl=
e,
> > > application code running with kernel privilege, or attempts to execute
> > > kernel code while in an unprivileged state."
> > >=20
> > > Shouldn't we show the values of UXN and PXN separately?
> >=20
> > I had that on my initial patches. But then I decided it's too Arm
> > specific to print it.
> > I was hoping more archs would fix that so I preferred RO, RW, RX since
> > it's arch agnosticI don't mind re-adding it.
>=20
> This code in arch/arm/cpu/armv8/cache_v8.c is architecture specific.
>=20
> RISC-V has flags R, W, X, U where U controls access by user mode.
>=20
> When printing the flags I guess we should use an architecture specific
> notation.

=2E.. and update doc/usage/cmd/meminfo.rst to note that it's printing
arch-specific flags here, perhaps with an arm64 subsection explaining
any shorthand and links to appropriate documentation ?

--=20
Tom

--npP35zkSZbDqPVeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebot8ACgkQFHw5/5Y0
tywIZwv/fUIaF+YsgOHUPY6ZstRQz2e/6wIuxGvfHudj3Vn4TdBVxu5k0wDMGxYl
h9KPpPzBWI3RVwNC6ON9Rgrj9rGSWmjnvP7Lxy2dGHc0Oqi1OSiGIfyw46K9Io0e
qasMPbH96d97pFgMmNkfrDLb+nYhRik43e4CJ8TPYVabmUz6D8Tn31SuV8Xz3A1V
DYga/EkNNGLop7PoBQ6sXBXbMjJZYNhJiS7QYhwFtkX1YwILWaesbCww15SgQbLw
OlFefu4t614M6IVbf4nWkHK4R62jcncYJROaFy+kXeoQ00z2Jo1tFrjPfJ6qQPGa
Dvmgn+1f+tn6SbmnIkh3ReBSVdWxOhaqsaLBzjLKjQcZe9w9TRyJibIH2UrMgvDx
ucV9E0h/pp6cTsOMHsawtf4kG3ynfCpcUKbpDmTSTqjNlcXuqdjyd2RqPMHatqi5
1hUKy4ty7yEnkRNUnF50dDMeH/7KQ1qTKNqLf6yZiZPTbz6mTrvtSzSY1Swjtceg
7cSeBwMk
=s7io
-----END PGP SIGNATURE-----

--npP35zkSZbDqPVeD--
