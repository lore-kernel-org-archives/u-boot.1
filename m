Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2688C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 01:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59AA9801DE;
	Fri,  7 Feb 2025 02:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nxGJQBzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC40280207; Fri,  7 Feb 2025 02:42:23 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED83801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 02:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f9c3ef6849so2816477a91.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 17:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738892539; x=1739497339; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P1GLan0FleHz/rB1yUPLlS3N6yQG4pOth7oouLwje+4=;
 b=nxGJQBzkti3YnGC8mwXn8xZWgPXFfm+S5WgYAalbUITnFfoffGLYW6JYB8FcgKlMXq
 GsIpsBQhWSup0+vv+yJYZ7N10WzdDzWyacruq3LOZJsE8XkwKTQJ0kep2X6BhJWmyyRh
 +6Sk4SXGHP2F/GQSTPcGSrj6rNxKBIalrXJTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738892539; x=1739497339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1GLan0FleHz/rB1yUPLlS3N6yQG4pOth7oouLwje+4=;
 b=w0lqIiZSiKzEN2O0tWSd9SyUi+2zxAmjfnaK60L8BBkpsnQPsoHxpilibpytTBpXgN
 mKWVxn4YdS+3AuR6ogDGVj0Ui6ZX5hMmRTnAYWby3aBb5qqaq+pl4+OKJFatfZinpUlA
 Km9H454KSR2coo4SrrPuonFzsBlpQjaUNw5TZ+YZEGm2uCwmPZ5fq6STtFMcUQnJ5gYA
 SU/0kQKkJXKcdNV+aHm5V0ZYL4cNzQNtQTiCRuZgb9DLe3lQyJkG1mFhxVLzBvXm4sri
 i5q1dczCPMiAyHFGm9B2l52k2oQcQbasCiSImEtIv2AyLYakFph6iArMpaZd1fwQgPFE
 Jb2Q==
X-Gm-Message-State: AOJu0YyFkAUwx2QBtRe9sb7d/vjgKgdKpMLyK7mbciwEGTYN0EoGESeR
 jpxQsJAoaWE6v9iOabafPyuqG9gEpYnVtB/uWBgrDhZ2VLyXTnNKS0PJXUZJbkM=
X-Gm-Gg: ASbGncvq/f1B3q0ViJGB8BcKg+x3iCu4bURa6n4XMgaWjqjxTVJ22K+9REdSmUmxqVb
 np8DCE3zNmM92agNvhNVk4fkB7e0Ol3fi0Adpco4Q1eU4iN0Cc6qAUcoyFup5AqdJofiCoeNnuA
 zdKVEteWGEwaxBo6+GVIoRVESQ6lWDDAZQmhaDBdTw9JwFiCj8Q+aNfJaFe1+/in0yFrQeKIMJl
 aN3v5Q8Ev8hhy59IJm+eaM9GTK1/sAJnSpxhgBh6+iEahTLvHBaJkFbMsuNXgbcqDItWd197rxH
 mkK15w+ZQI3q47w=
X-Google-Smtp-Source: AGHT+IGPMqJKyrxcZCMkXoFHL+9Kk5qdQVey97OeBSOJVn1prfaDZGZKbWa7Y0e+VmmM28WeoNFlxQ==
X-Received: by 2002:a17:90a:ec86:b0:2fa:13ce:bf16 with SMTP id
 98e67ed59e1d1-2fa24068f50mr2177605a91.11.1738892538807; 
 Thu, 06 Feb 2025 17:42:18 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa099f4d81sm2086973a91.4.2025.02.06.17.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 17:42:18 -0800 (PST)
Date: Thu, 6 Feb 2025 19:42:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
Message-ID: <20250207014215.GV1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
 <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
 <20250206170745.GG1233568@bill-the-cat>
 <CAFLszTiJ_zB4_dCJNjOAbXtfBmM2KxbHXxiw4gpRMMsJdOM2hg@mail.gmail.com>
 <20250206232206.GP1233568@bill-the-cat>
 <CAFLszTjGDidhi+FDfGi36mgLUNbPQ+TskgUyF7znhDC+H7MDzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jo323FSEko9AymgM"
Content-Disposition: inline
In-Reply-To: <CAFLszTjGDidhi+FDfGi36mgLUNbPQ+TskgUyF7znhDC+H7MDzQ@mail.gmail.com>
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


--Jo323FSEko9AymgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 05:49:43PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 6 Feb 2025 at 16:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 02:27:13PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 6 Feb 2025 at 10:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 06, 2025 at 05:33:06AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This code cannot be used since EFI is in charge of managi=
ng exceptions.
> > > > > > > > > Drop it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > Why is SPL on in this case?
> > > > > > >
> > > > > > > SPL is enabled by a specific Kconfig option, which seems to h=
ave
> > > > > > > exceptions but not exception levels. That seemed to match wha=
t the EFI
> > > > > > > app wants, for now.
> > > > > >
> > > > > > OK, so why aren't you turning off SPL? You're not using SPL at =
all,
> > > > > > right?
> > > > >
> > > > > Not using SPL, but using the same code as SPL happens to use.
> > > >
> > > > But is CONFIG_SPL enabled, or not? It shouldn't be if I follow you.
> > >
> > > No, it isn't enabled. But we do want that exceptions.o both for the
> > > EFI app and for whatever boards use SPL.
> >
> > Um. Isn't that the opposite of what your commit message says?
>=20
> Would it be clearer if I said 'exception-level code'?

Since we have exception_level.o and exception.o yes, you should be clear
about the code you're talking about.

>=20
> > And the
> > Makefile snippet today is:
> > ifdef CONFIG_XPL_BUILD
> > obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) +=3D exceptions.o
>=20
> ^^^ this is the line that I want enabled for the EFI app
>=20
> > else
> > obj-y   +=3D exceptions.o
> > obj-y   +=3D exception_level.o
> > endif

Then you should be working in the non-XPL stanza and not enabling an SPL
symbol for your not SPL build. I gather you're trying to not include
exception_level.o because since you can't use --gc-sections you're
having some undefined symbol problem. How about you file an issue for
me to tidy up ARMV8_SPL_EXCEPTION_VECTORS and exception_level.o
handling.

--=20
Tom

--Jo323FSEko9AymgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelZPcACgkQFHw5/5Y0
tyw0owv/X5FSFnWXVb02J0JIda24v9RjEoCNUT65Lm0HMqXvFJvPIMnUUe1gMbYe
dk0nWTDBE7ZVSg5MGUxiOHK4HFegYh5MDn+cnvZVTMxSp5Z27YBw7L2S/w3XfzEE
o+typFsj+gzs7C8xsKJQP5Y3s+l5Q3/zZNUGUPbZMUrQQO8Rwqs3me8ep9QPCDtd
a3vi0r2atoADGc7nPgYlacx1jBvAJ3e5YswLjjXAlZuBZ070KM2GgI7jXOw5LQIr
53CgoZBC7RwlEzc+gnvRj3iSjFgx6SdOnPk18yIWfth2PZAHJ7nm2gyjEZVpgrDr
c1FMevU9QRu5a+GivyKZrDgjBRnYq6kB7NSKQg/6Jyo+b3OQXJNNZ4OyQ1OS6x0u
ZdA8piYH2RiICdHVE9rDVWuvDyYuuMgy7So6X95XX8cU1/dOrJK56owhJgYEr+f/
wh1PIrLWbdADv3eyoVJiF0OxZQNqRBSteYXnMggoiO89TaT2iusbC2GEENcrZlaW
bd5CLibQ
=MbpJ
-----END PGP SIGNATURE-----

--Jo323FSEko9AymgM--
