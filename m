Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C22E66891
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 23:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA8D891F1;
	Sun, 24 Nov 2024 00:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hCeNK5pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A62789416; Sun, 24 Nov 2024 00:14:26 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34E688F12
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 00:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d42b87aceaso39530386d6.0
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 15:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732403663; x=1733008463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf6MjBdZMj9o8K37hjy0ySvmim3YL7Jsvq/DpBODsOE=;
 b=hCeNK5pNAKiwFV92Nx6noDveK7VyyJCS79Mv+iVwUPNaDDizfYU1KRLhAWMmWXTdRf
 pL7Ce9Xfxb6GF4sbYNxmWLu4DYBgFzFfr6ihxpKFCr2KVHTvi4eWzJbbe/dUUPw8yAjo
 fKqk9mW0YlqyYaYvvuLud0bGTqk3Td+9g6PsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732403663; x=1733008463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nf6MjBdZMj9o8K37hjy0ySvmim3YL7Jsvq/DpBODsOE=;
 b=oXdFJ34VEeYptIjwM5mwoniF/NJ/tt1qxz9BsMiXPmtx17Ogm/4TDL3Rop51jXvJkS
 EbqGqHVBUBWpthoZXyGXGmjMawLIKdqdYT3ar9Hfkv8J1LOP/cOLB5zS111fhfIl7H/T
 S9haZMP0NNFU1T1z12YK7Am3JYKSaEixJ8LHCPJ1x3zLxi1+2pFz71YzfVz/B8biNr0y
 9nt5fGCwnwztKBALx6zkgtqSxVC1KfOhyvWOGeCjTp0TUkKkXZxBc3IUWB0FmukJTS8/
 rqCE8VFFBCWi9TeL5Qb3LfZsJgfRUg/0N6CT4ue1nFvi+8Wp62Hf/wJ923TwLrheaskJ
 HS6g==
X-Gm-Message-State: AOJu0YzswLh7pakTK+hIOP7puww2WG+4L7cw39dn/b6a0XPaOwIixXGm
 +4c5VSiLHlzqSD2UeBPq9y3SgwfU45LMQ8Ne2TyJu/7050ZaWaIsShMCe/lbpjcHGGF0OlMqzR9
 uLJc=
X-Gm-Gg: ASbGncu3OZSorraFK29y27T0FJbu4XXTwWXiIU1G4RrvK663zTpZBVNiMS7nzmJSL3l
 LVJhECq4N/ct53XDNx1mFfXf7K7yRvM4DHuKcn+KN6ZvgT+E2DPjXFIvXzbIZ2RKJfKpdqgw1mR
 usZuyr1NlovmmnoyBUMXo+PoQvidQYizvaXvuJFUhFYOHHNkEJCvTrOPKbt3Q9w780Qjz7Dwzgv
 Q2A3z2bmieKNTuXpQrlhi04Y675LiCCBk2gNswefg06OSaopA==
X-Google-Smtp-Source: AGHT+IH/du4hWY4nz541fisjZX0+Ed35YRHqGANvkCckHHCE5Le1UZgJZoKICZfMSdFKTq3a5BgvpQ==
X-Received: by 2002:a05:6214:ac7:b0:6d4:15c5:b119 with SMTP id
 6a1803df08f44-6d4511503d0mr166012086d6.19.1732403662753; 
 Sat, 23 Nov 2024 15:14:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b2509dsm25967526d6.83.2024.11.23.15.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 15:14:21 -0800 (PST)
Date: Sat, 23 Nov 2024 17:14:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] examples: use QEMU compatible LOAD_ADDR on 32-bit ARM
Message-ID: <20241123231418.GB3600562@bill-the-cat>
References: <20241123084853.59252-1-heinrich.schuchardt@canonical.com>
 <20241123152447.GZ3600562@bill-the-cat>
 <CAM=mAO=zNaaBMFzcqyek8OTZfLbD26gw+OMH2eB8dMgYJXfa5g@mail.gmail.com>
 <20241123225541.GA3600562@bill-the-cat>
 <69ff1a82-e887-4950-bd06-c8e16f776f8a@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c6bc0E6ZHKkE/Gnw"
Content-Disposition: inline
In-Reply-To: <69ff1a82-e887-4950-bd06-c8e16f776f8a@canonical.com>
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


--c6bc0E6ZHKkE/Gnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:59:36PM +0100, Heinrich Schuchardt wrote:
> On 11/23/24 23:55, Tom Rini wrote:
> > On Sat, Nov 23, 2024 at 07:23:35PM +0100, Heinrich Schuchardt wrote:
> > > Tom Rini <trini@konsulko.com> schrieb am Sa., 23. Nov. 2024, 16:24:
> > >=20
> > > > On Sat, Nov 23, 2024 at 09:48:53AM +0100, Heinrich Schuchardt wrote:
> > > > > On many 32-bit ARM boards including QEMU memory starts at 0x40000=
000.
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical=
=2Ecom>
> > > > > ---
> > > > >   examples/api/Makefile | 4 ----
> > > > >   1 file changed, 4 deletions(-)
> > > > >=20
> > > > > diff --git a/examples/api/Makefile b/examples/api/Makefile
> > > > > index 722c7e45904..f0f107562f1 100644
> > > > > --- a/examples/api/Makefile
> > > > > +++ b/examples/api/Makefile
> > > > > @@ -9,11 +9,7 @@ ifeq ($(ARCH),powerpc)
> > > > >   LOAD_ADDR =3D 0x40000
> > > > >   endif
> > > > >   ifeq ($(ARCH),arm)
> > > > > -ifdef CONFIG_64BIT
> > > > >   LOAD_ADDR =3D 0x40400000
> > > > > -else
> > > > > -LOAD_ADDR =3D 0x1000000
> > > > > -endif
> > > > >   endif
> > > > >   ifeq ($(ARCH),mips)
> > > > >   ifdef CONFIG_64BIT
> > > >=20
> > > > If we're going to start cleaning this area up and expecting it to w=
ork
> > > > more broadly, is there a reason we can't use CONFIG_SYS_LOAD_ADDR or
> > > > CONFIG_STANDALONE_LOAD_ADDR here?
> > > >=20
> > >=20
> > > loadaddr =3D=3D CONFIG_SYS_LOAD_ADDR on RISC-V QEMU. Command bootelf =
did not
> > > work for me, if the ELF binary had been loaded to its LOAD_ADDR.
> > >=20
> > > I did not investigate yet why bootelf fails in this case.
> >=20
> > The examples, broadly speaking, do not run out of the box since they
> > assume an address to be loaded in to memory at and run from, rather than
> > a Kconfig entry. The next problem for RISC-V is that, well, there's no
> > api/api_platform-riscv.c file (and forever ago I steered people away
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20241123084754.59182-2-h=
einrich.schuchardt@canonical.com/
>=20
> provides api_platform.c for RISC-V. This patch is only about ARM.

Yeah. For everyone we need to move this to Kconfig and it should likely
be STANDALONE_LOAD_ADDR being re-used and not a new symbol. Hard coded
might-work addresses are a leftover of pre-Kconfig days.

--=20
Tom

--c6bc0E6ZHKkE/Gnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdCYccACgkQFHw5/5Y0
tyyIOgv/diL48RPO4A2C+GBhIC48W0dlsn/ZmIhE1yrrexjlRJSkKlWQNuOLOFUZ
KBfrdcNZbDDRKFtlgEwaujFsEHWwvKL08vswHCfMIn7esdddjZNFjWcUZXBfE2AE
ctuJk256DcyfzygUAsGJJyS6iyQmY4cpriCZNnjWK/Esn9RT3lZG+fQB3ULdPAjX
0ELf4Cf1fUBYn+PmlkAPtAu4eluoAOtOP8T2p7xvNV7qRbfdSkPzLaaa7cfWTI72
RowyGzEUVspJZyOtQ0WuDQ2PdAMov1ryVIOSdQKu1lotaK22ZQu8erEeUEvwMJ96
P0CE1b5o0mdQ9HPsbrKvL0S/UrblGGtXFTYCO5lp9S4yQ/KbINiBgmyhWN5Aga7C
KB7BB98yZjZbMdbfFbKYtR1amjPhiJMOr8Bndtc0df9x7xxPl7jOGxQa5dgyzEKc
5+bWwTCeWQ00OFkSmH5v4kw3vCKfc8JPp6oSq7njoQ3nrU4b4vz4x26Jreeh0vHN
9rQlmi7i
=t7fg
-----END PGP SIGNATURE-----

--c6bc0E6ZHKkE/Gnw--
