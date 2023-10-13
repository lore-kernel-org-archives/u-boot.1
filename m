Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE5ACDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3611886E81;
	Fri, 13 Oct 2023 17:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+t6mIzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB9986EE4; Fri, 13 Oct 2023 17:17:35 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA7C86EE0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7eef0b931so27742127b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697210227; x=1697815027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qgIzsv72PVNiTCmxMcuaEIO2DSBfXcphNVFu9q9blrY=;
 b=J+t6mIzFXBIOhLcbGtZmcNc/uAX+2wtRXuM62ur2Ci74AljdOBrJ+aXPz2sA59UBOk
 /w/YzNS9o6Ekjjia+RhGH5BFTCrIv3AhCM0VIKYrBeXjjqwEBLFIfbMd/XfvmD81QZUS
 xwcCXQ4BRlR7vuLrsxx1zbHUjFJRaVHwamKlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210227; x=1697815027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgIzsv72PVNiTCmxMcuaEIO2DSBfXcphNVFu9q9blrY=;
 b=XMa2bs/n2sergkJX7pBDLZQmZjAM4UoK43TE/Fvhl6vWdfgWefkPvoTjJIrpQlRnIA
 FLm8XLMduIE0PSBL0vbxMovS/H76ikirEU9GCrGAyisF1vzeZ+iP/PLX9rButLYUOUu5
 JLZXQkrb4VuijG2T1tK9KMBgtdCP7mo5AeT6oO2yFT+17uvsjPmn3E2MJubTNFQY5iOH
 h6YdpDXOjMhNuiVeAr3yyTSfNPXt4UhNMISw4uHrKORObYrr5qawbpHfasxmsrKbGUL4
 KApVW00QALHI4r9aVjOjPpzPN6Bh/oQKDbyXYwfCKApHP2tD77xD1CnmDFfrxmP+PriV
 PY4g==
X-Gm-Message-State: AOJu0YwGx3jP7aC3T591PEhWZIUu0sXkEoMZwoM1XkIgvrQ5orNfHiGp
 2r/zpCOvt6NAu0/xHbnlzG02FT283QZ8C3QYnhvsnQ==
X-Google-Smtp-Source: AGHT+IE2aulFdcK9iNsFK0NdlwT0q1NGDuav4ms99/5QxYTGLVDCpzMMstvvCCacb4UErJF0FoHMKg==
X-Received: by 2002:a81:4e4a:0:b0:5a7:ca59:82b9 with SMTP id
 c71-20020a814e4a000000b005a7ca5982b9mr11504731ywb.16.1697210227559; 
 Fri, 13 Oct 2023 08:17:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 i123-20020a816d81000000b005a80102fe3bsm757901ywc.13.2023.10.13.08.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:17:07 -0700 (PDT)
Date: Fri, 13 Oct 2023 11:17:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
Message-ID: <20231013151705.GL3119521@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
 <CAPnjgZ1cSJNXZTdRu3LG_Ojo6t_93s+yRfTAoKi+YkJg7_LdFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rl67vFzGFKjXel6r"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1cSJNXZTdRu3LG_Ojo6t_93s+yRfTAoKi+YkJg7_LdFw@mail.gmail.com>
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


--rl67vFzGFKjXel6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 08:14:57AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 12 Oct 2023 at 16:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > We can remove common.h from most cases of the code here, and only a few
> > places need an additional header instead.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > ---
> >  arch/m68k/cpu/mcf523x/cpu.c         | 1 -
> >  arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
> >  arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
> >  arch/m68k/cpu/mcf523x/speed.c       | 1 -
> >  arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
> >  arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
> >  arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
> >  arch/m68k/cpu/mcf52x2/speed.c       | 1 -
> >  arch/m68k/cpu/mcf530x/cpu.c         | 1 -
> >  arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
> >  arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
> >  arch/m68k/cpu/mcf530x/speed.c       | 1 -
> >  arch/m68k/cpu/mcf532x/cpu.c         | 1 -
> >  arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
> >  arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
> >  arch/m68k/cpu/mcf532x/speed.c       | 1 -
> >  arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
> >  arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
> >  arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
> >  arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
> >  arch/m68k/cpu/mcf5445x/speed.c      | 1 -
> >  arch/m68k/cpu/mcf5445x/start.S      | 1 -
> >  arch/m68k/include/asm/immap.h       | 1 +
> >  arch/m68k/include/asm/immap_520x.h  | 1 +
> >  arch/m68k/include/asm/immap_5235.h  | 1 +
> >  arch/m68k/include/asm/immap_5272.h  | 1 +
> >  arch/m68k/include/asm/immap_5275.h  | 1 +
> >  arch/m68k/include/asm/immap_5282.h  | 1 +
> >  arch/m68k/include/asm/immap_5301x.h | 1 +
> >  arch/m68k/include/asm/immap_5307.h  | 2 ++
> >  arch/m68k/include/asm/immap_5329.h  | 1 +
> >  arch/m68k/include/asm/immap_5441x.h | 1 +
> >  arch/m68k/lib/bdinfo.c              | 3 ++-
> >  arch/m68k/lib/bootm.c               | 1 -
> >  arch/m68k/lib/cache.c               | 2 +-
> >  arch/m68k/lib/fec.c                 | 2 +-
> >  arch/m68k/lib/interrupts.c          | 2 +-
> >  arch/m68k/lib/time.c                | 1 -
> >  arch/m68k/lib/traps.c               | 1 -
> >  39 files changed, 17 insertions(+), 30 deletions(-)
>=20
> I just wondered what we do about '#ifdef CFG_...' which presumably is
> not included without common.h ? How does that work?

The first header in common.h is config.h which is where many CFG_...
instances are.

--=20
Tom

--rl67vFzGFKjXel6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpX3EACgkQFHw5/5Y0
tyzyrQv+LZQi1sZj+mJ8p1PjOlJuD23DSYD7jcswiNdCEFLWgsXk5dKzQSdEUQHp
/k0A7oHHH+mHN9TVl4dmkK2OT3349IKVPNLxTWKll5b4CYXNYgULtHzAY0ZbOUdF
pqjrn+Kq0a5Rc8L1SJv2q3Wt9ewbAoIq1H2p4Rwd5Stl2EpjSU62D28bv8hz4Eow
0WoM5GROlzuRd8My0rxoWH6aoAaCLGmKaAVsmS4xrs8v/DJdHKdqfCqCeGRNF2Gy
Jx37+npjZJPbxRa+OhBBkIuwaGf3/r9CyONqZ+cIFIAXR/Mqkc1iTRY3v+bCZ4KS
6z6CvBgYiTtpwkWZWrca4cOco6C1tbY43qSxZ29I9ylTJpc21qvGX+dCXTo6ulKL
v+1CVOcF/PtjX+3DguuD8ioZhKXjD17FBbog7OtB0dEoHN9JxHYG9VNjl9VMAF3F
Z/9O383oczIB+pszkhqRodH3Rjegz+ryO2HKXeBwmy5CDzoXjFecjqWA/0hiuBqP
BLhU7c4/
=JLY6
-----END PGP SIGNATURE-----

--rl67vFzGFKjXel6r--
