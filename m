Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0304801A0;
	Tue, 17 Dec 2024 05:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CGSU/PsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB77A801CF; Tue, 17 Dec 2024 05:00:47 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8675800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso18012456d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408044; x=1735012844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+skJNmE7B3/efk9CYVb5NYa0c99wqNcKu0JVVIlp774=;
 b=CGSU/PsTnTkeorAHG13H0j5K7A9IfRAEtAAHh4167/MX9cEeNn8Lv+x5hYMpbVzESL
 92Yf3hQ6JWopgofJwhQXMWdD04x7+neE/0FFSw3Spxpic2DUrxujCgJ922IOASBjHR+U
 lDnZXN77oqzM8wEaop5h4Y6t3yyk8GmykNU50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408044; x=1735012844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+skJNmE7B3/efk9CYVb5NYa0c99wqNcKu0JVVIlp774=;
 b=U0AMQPpIC45nj9GwH5w38ClyaGfWMzbtz801qwz20FELPvgUEielJPx04sn7hXtMID
 hJNxgvrrJwYk1Nd25U2t46TCuuYGtSRxlxqJGas1AjJF0agQMGgcJsD5NSIbkUy5QXel
 HDx31YXlR4qHXMbDxuJakryeXbQxVb4VsMszvUQtlpC7lB5Dx/OrFZlnd5XYY8SFi2PK
 7PIIwEiLrSIwaaTUwUzZ5dnywLYYORER1YydnJo2bsTW6Sao6mIY9h6iDAMucJlNX1Pi
 t1nDJ9pbv+KeJ9aAx+F7NDtzTGChgaA4EPD7BLgCSGDehRV2kDOnvtSPC6sXtcrlINtf
 YcdA==
X-Gm-Message-State: AOJu0YzuZ/jJxu3Z3HgiuuY7bS8K5IocrKYP+MlTuIz40uSt9uUqFZYx
 7RaVCyBfdw9oVekFTpqAzNOLT2xwixfNG+IQJDCrvj/sKwI3EGmSWbsrxMXb1IE=
X-Gm-Gg: ASbGnctlF5yZxc1j51FJAmeW5vUisG4CZhGCR0GWrPH8nPqbZVbB0s5KWpOXSGqQWRE
 XKqczE3DAlBeQNXhoC/UNCVM2x9gcR7LpmFhKJ3ttlhwy2voh5Y2g9rOYNw3SPi3StA2u0AJiEo
 On0NN7vhGlHq1/YtwtZ7TQEUceJMl4w0rVu7MNkgf3RozqzBS3C+jdJg2Y6/eK6XDiCGx0fqZEc
 Zh3p0nypVq6FlDmfbApbY5LMi65tRA/ibeuf6zAd/vCa3urPq0xrcsV
X-Google-Smtp-Source: AGHT+IFplP3Lvnh9YvA2o9VXBJMZbwtYzA45nvNYdWRcf0s2+u3QJqMepkw7rf5YliMN+FTg9tvN0g==
X-Received: by 2002:a05:6214:caa:b0:6d8:a8e1:b57b with SMTP id
 6a1803df08f44-6dc96850fa1mr294579196d6.36.1734408044463; 
 Mon, 16 Dec 2024 20:00:44 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256b1csm34206096d6.30.2024.12.16.20.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:00:43 -0800 (PST)
Date: Mon, 16 Dec 2024 22:00:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241217040040.GJ1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5gx8YKENFQ++PwAA"
Content-Disposition: inline
In-Reply-To: <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
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


--5gx8YKENFQ++PwAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Introduce an option to control if we expect that a prior stage has
> > > > created a bloblist already and thus it is safe to scan the address.=
 We
> > > > need to have this be configurable because we do not (and cannot) kn=
ow
> if
> > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some spec=
ial
> > > > on-chip memory and so it may or may not be safe to read from this
> > > > address this early.
> > > >
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > >  lib/fdtdec.c   | 11 +++--------
> > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > >
> > >
> > > Since this is the essentially the same as my OF_BLOBLIST patch, which
> > > was rejected:
> > >
> > > NAK
> > >
> > > The issue is not whether some 'previous stage' set up a bloblist. For
> > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably means
> > > that TPL set it up. But it doesn't mean that TPL put the FDT in there.
> >
> > This is wrong. The root problem is saying that the bloblist is in
> > possibly uninitialized memory. The code is quite happy to NOT find the
> > device tree in the bloblist and continue searching other paths.
>=20
> But until the bloblist is set up, it doesn't exist.

An almost philosophical statement, yes. How should the generic code know
if it exists, or does not exist? That is the question.

> We should not be
> looking for a bloblist that we know is not there yet. The bloblist is set
> up by bloblist_init(). You seem to be imputing your own semantics for
> bloblist.

We don't know if the bloblist exists or not. That's the problem. It
could already exist. That's the whole reason we're in this particular
argument.

> In SPL, init happens in board_init_r(), i.e. after RAM is set up. So don't
> look in the bloblist until it is set up! It doesn't exist.

Unless of course it was setup before. We don't know if it was setup
before or not until we look. A big part of the problem is that for prior
to U-Boot bloblist we don't need to use main DRAM, the bloblist is tiny
and we have some other persistent memory available. Unfortunately, x86
does not.

> In U-Boot proper, we look for it before relocation, so we can relocate and
> expand it for use with ACPI tables, etc.

I'm not sure that's relevant. This means we've taken what we were passed
at a fixed address and allocated more space for it and are using it
somewhere else.

> Take a look at this patch, too:
>=20
> 3d6531803e1 bloblist: Support initing from multiple places

I'm not sure it's relevant. It does show we have a problem of not
knowing if the bloblist exists, or not. And I don't think we're solving
that right today (nor does v1 of my patch).

> > An alternative here would be to better document the requirements of
> > BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> > someone is inclined to move DDR init in to TPL, or someone finds a
> > non-main-memory address to use for BLOBLIST_ADDR or switches to using
> > BLOBLIST_ALLOC.
>=20
> Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It cann=
ot
> do DDR init in TPL because the DDR blob is large (160KB?) and there is a
> ton of setup to do first, in any case. When CAR goes away, its memory
> vanishes, so you need to have copied the bloblist somewhere else (the
> bloblist holds the MRC data which needs to be written to SPI flash later
> on, when possible). This all works perfectly and there is really no need =
to
> change anything.

Ah, so there's some of the details finally. And oh goodness, we're
writing to the SPI flash on each boot? That's not good for longevity...

> Again, you seem to be imputing semantics to bloblist which don't exist.

Unfortunately some things were missed along the way, and are still
missing.

--=20
Tom

--5gx8YKENFQ++PwAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdg92gACgkQFHw5/5Y0
tyxSawv6AzyXzxMLmR43cJiWkKx4/P+koMeawbysTHioZ/rjqlL3kEkAYXvKvzqc
OKULsdDm0JzOmyuLImuiplhJypEmKPuXs8dMjry8VnOoLk5Et3trf0zul6VCdqb+
1uaC91fKeE0TK3Ln8H/ihft6rHB+5jRGVv3K5Zwjign32K9P7//pLiG7jpA1vUFH
8+MLsQQTGRFq6vTJ2pIzGFwmI1VWGy3MQyZZlhwIMdfSnYriI6j32wP9pOlNSEoa
OGiIQ8+BqDIFoTG+ycBEAgSTtx2/YatMW2eaCFcm6iVUsbUK5QX6mvVP+Fk6kzyi
fyndwghUIGwH5HYnou0YwrX0aki/Iw//ctNp2bxsnXrKWZqYx46NWoYPeYJfgc+w
x8H0syE7x7GXvWL9kRXAFESGDMHafgkIdnNUxMLvhMnjo9nRyZ1rVMdrfQx95Gcn
B5BZFQiAD3g7d6gvTyA9AOxpHTZtpWELQqFThoYbuIqqXg37MqloCNiv1CIp0YdI
cd6yZpj4
=+oSo
-----END PGP SIGNATURE-----

--5gx8YKENFQ++PwAA--
