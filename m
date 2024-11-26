Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87961D3B9AC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13AEC89C60;
	Tue, 26 Nov 2024 17:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S+xJtYyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB4689C60; Tue, 26 Nov 2024 17:08:24 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C3689723
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6681e92b1so149614385a.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732637301; x=1733242101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1jEkerxJg1LET2M7W6JZTNFkMYJQWvfcDZQoRObM0rY=;
 b=S+xJtYyDXcDNnLozwpqN9oEI2uNGCwJk0DZ3gpYdVOpGERF8uXbsd9QPd4csWeovFa
 Au58ACwXxVb1D5QvTParNqrLIK9gAUGyWfj964uaw6WUl1uM4Bapr6HHGpgDteJ1dPsh
 48ERrX4WthuXXTs75qa3kxoupQawt5gdErXHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637301; x=1733242101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jEkerxJg1LET2M7W6JZTNFkMYJQWvfcDZQoRObM0rY=;
 b=FvfAcV1//V3kIJerkWcljam3ivd6AMynfV/Vo01dRWm69IQufJ17jouHJrWAY/6jgI
 UfwBIxYHBS5K4439Gb9mkNbKQcDKkekgkZBgy6tJ4H2d+ldICT5+8IOrNZ5THRXYnIYq
 bxFPLsd79PSAqxV6KRDclHYp6veWo8AT9RxnsOJWGmIaeh6MYS6yNt/1Q+nY2Q1ve3re
 t1lL40OmA39bgtSappRDzymFFyOi4BALPbdHFSNRXCnLQbyNvdvYL9tFZ87kNGa0AyPv
 R0XQVo2+wrHjaRz+01m5cXfRHhnoJ5PJjDgXQwZhjnRjrPvdzz38/NFVQGwn9cnbh17b
 KcRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX68pfZo++aU/b/0EM72UsyhHDwrASi/l6zDxPVRScpudvhVZIO3YN255bSj+gALX0vzzZ7nyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YybafloaXI/8M/2tarVgM3QZmwHPilQzGp6SYWhaZjnu6UD7eQM
 TumtAktWeBXuaYz9UTCotmD1A6SgECw0MDeSESti5SxnG6xKsFoYnOPug0Zf4fc=
X-Gm-Gg: ASbGncsoonNNUjVycuawqW5mcXq4sDs51WHKMIhvVQh3EvMgriLa7hYF4io4AIimsYN
 9D4pFTazfQxbOvM6przXKaCWDPZoun8WmqNqOyg/q/smiE3YtqggoAREzyMs7Wr9pD2/WSaAx25
 5zIoRO1Kl3mptChvwnh0Gk2wmRTNsB8WKuxj/gZoigH1VpzLb6GwCFVMKpZ40xYTvFHL6Wt7BQ2
 TOZAPoxo0o1r09nnw6XbClb1jYdevbaasQR+NrICxTdk2Q7bQ==
X-Google-Smtp-Source: AGHT+IE3Iep4aZbBLE04bhp4+tpdcXxbF/ckt7RW0oKIxdrLagGmLddkbUUh2GUkR3tWs2h6IshOpQ==
X-Received: by 2002:a05:6214:401:b0:6cb:5605:ffb2 with SMTP id
 6a1803df08f44-6d450eed1e2mr249037666d6.24.1732637301464; 
 Tue, 26 Nov 2024 08:08:21 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a97da8sm56984986d6.46.2024.11.26.08.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:08:20 -0800 (PST)
Date: Tue, 26 Nov 2024 10:08:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/13] efi: Tidy up confusion between pointers and
 addresses
Message-ID: <20241126160817.GS3600562@bill-the-cat>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <a6ba9ebe-9d52-4b2d-bb62-02c4f0ea86fb@gmx.de>
 <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ddroFwvkmAmUA1am"
Content-Disposition: inline
In-Reply-To: <CAFLszThf3aSwi1yhaQP9Ns7wTNjKH8XicAqUU6vy5gej5GP+CQ@mail.gmail.com>
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


--ddroFwvkmAmUA1am
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 08:39:05AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 26 Nov 2024 at 02:10, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 25.11.24 21:44, Simon Glass wrote:
> > > The EFI-loader implementation converts things back and forth between
> > > addresses and pointers, with not much consistency in how this is done.
> > >
> > > Within most of U-Boot a pointer is a void * and an address is a ulong
> >
> > No. It is phys_addr_t that was introduced to handle the sandbox's
> > virtual addresses.
> >
> > And we should keep this sandbox stuff out of the EFI code. They are only
> > needed for the command line interface.
>=20
> No. My statement is correct and long predates sandbox. U-Boot has
> always used ulong. Using an address is generally much easier than a
> pointer, so I believe this design decision was (and remains) a good
> one. I certainly would not support changing it. The phys_addr_t type
> has nothing to do with sandbox.

At the high level, I think parts of the problem are that when U-Boot
went from 32bit architectures to 36bit architectures (assorted PowerPC
Freescale parts) to 64bit architectures that no, we didn't make some
concious and consistent statement that "ulong is for address (except
when it's not). If you look at the linux kernel, phys_addr_t is physical
addresses, ulong is virtual addresses.

And so phys_addr_t was introduced, iirc, for PowerPC where we had a
32bit architecture with 36bit addresses and had to deal with that.

--=20
Tom

--ddroFwvkmAmUA1am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdF8mgACgkQFHw5/5Y0
tyyhEwv8Ct3cT7GeNohN4zJ3p2xSySL0+beL6C++KrOyeoRwwVzIXmrYiOOjlMIH
UlxBq4xtLiLSjoat4n5Hh44ODeZdjGbGwXhDwcwy91NCnZ0yUo1SoFhPiCHOu0hf
uk6gTWn43DdYCxfjHS6/x+Mp9HILIiAwG/S785BhdelVF9XMuk6M4Q2L7IO1454G
P/bCt3rRKCzJUYAzLxvCAnFqZfx8tD/QIdNeWq7lXYDvQ0NF2Q69S+7rbc5SHbja
t+7bIdmt9rnSShXLS4TsqgEs2wiOUR8fxNkFC+GUuz8eKQeeDAe/Ot7QQzxlebML
2c4rZMvwJiRcMelSGeENj4SSCOKREy1M6Stf1au1u0p7KOK2zrOv7BniLYrwJLOI
skvzOBE4aXEY5gaOsB5qDvX1ik8dHlnIBHutW3RlFgrD6wQxopvYGngVuita7S5X
QGu7N6rjBx3Bi+8RIONB7AVvrxFYcB8gC5etuxH9ol1XHjcbCutTYcfaeW0FPt6s
9I7CgG11
=3kHH
-----END PGP SIGNATURE-----

--ddroFwvkmAmUA1am--
