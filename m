Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8235AC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 22:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B9182A76;
	Sat,  5 Jul 2025 00:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="en3XzZgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C57182AF6; Sat,  5 Jul 2025 00:10:40 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A382682063
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 00:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73afbe1497bso653026a34.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751667036; x=1752271836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zaVqH3rVSkaTUPgB9XwtfWNpAKceV4nx3lZckhaxcRY=;
 b=en3XzZgolAvvTkMyxTMME+6sU/hjtyPlwTDpiBxIUPi0FvhGFq6xKfPsBZRSBYECCH
 TQgyS6ZzehW9rwk8i/9K7cH3mIgOFeP8e7gMJC1SXUS20wxOdt2CQr7TbgvncnpBaKko
 SHirbYq+GPIIjwAb5Ga69TqXYmMGSN2CpFwLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751667036; x=1752271836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaVqH3rVSkaTUPgB9XwtfWNpAKceV4nx3lZckhaxcRY=;
 b=gp6dK9GYen3YjCtiVTMcs6yVDkfpquUBwwR5FwZvYfvkPjW1tHgLqgmfX6oeCbne99
 VPm17Mnol5mNzK2VUqsVv65wIYVG18jR+wX1uvp5IypA8M0HaAtpi3fR4cl7MvYYXYUN
 cQZh+fszMHYsSo9kfz3KhRsTjdDprP022b4qZD4jD5EIYBhK3VsG1S/WXaVV2HQMLUil
 u7C1l0F1AqbUnUte/K8F5rAjn0HnCzDsNEIavtwMLs4F0mWH/habA1uIWugM3MyY1Nkw
 nd7YcznXvDdL8oKbES7RO2EzYM42gnonAZxJDnL5GxxLLYhn1I3+lez8VpcMYWwtbf1j
 RcSg==
X-Gm-Message-State: AOJu0YwZ8ZMYDaSJbMPpgXdYRAR8gL8Pf/pVZ4lKNkBkVHNkRWBcRGsb
 Bwehc0vXoZO6TtSeP5OdXJOmNh36RPAJXBSDeDPgP3Kbg8U31D73jj64CuX7ReJ0uu6yDJVGJaF
 fu/Vnyo8=
X-Gm-Gg: ASbGnctTkNlO5KrfWr4kr78LShhDn80SQpR8BzarZldRV07SsIRACmio31XSLxAdnmn
 5u3TM/wNhXEz2SdmDtmCc6Yfb0VKlLKJowZccdu1eWBscytH2emsax3/2iBwZaddSHLxKBi7Xkl
 JOWuNjjNfLo3uCNNpgMpbAP1tmbNyUd7PPmviK9AaE6DSb3b1ZtXBxqjt/4anIqzJsihYSDCP+T
 d9Kq27nP1nELcgkyWDhtFgl7SAoHa/q2l2NzZ3j4oBSWKWo2pwe+EyRQK2y6Upipo3cOfFYcR6Y
 6YVo90tR907+k4qQ7KrjykcNOWzSdd/WHFM0B7N/qSx5Tx+vPn5NWBRIR2dn+5HOleu8j0KaRsI
 Xobs3HsU+cGlj3irXAF68
X-Google-Smtp-Source: AGHT+IEdCaNIIOPgJMi2vgog5fmpoQBleEwOoNzpfaAyaOlpZVERwMH3aogwNCBeDchtaDQ8NQxlSQ==
X-Received: by 2002:a05:6830:2a08:b0:73b:1efa:5f40 with SMTP id
 46e09a7af769-73cb44965f5mr329115a34.10.1751667036234; 
 Fri, 04 Jul 2025 15:10:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f753ee3sm535761a34.24.2025.07.04.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:10:35 -0700 (PDT)
Date: Fri, 4 Jul 2025 16:10:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] integer limit macro consolidation
Message-ID: <20250704221033.GN6424@bill-the-cat>
References: <20250703113730.531225-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G7DLdvflF3CJ3BYf"
Content-Disposition: inline
In-Reply-To: <20250703113730.531225-1-ravi@prevas.dk>
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


--G7DLdvflF3CJ3BYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 01:37:27PM +0200, Rasmus Villemoes wrote:

> I was bitten by our limit macros not being usable in #if conditionals
> when building a standalone app. It turns out that the work to fix that
> had already been started by the inclusion of the mbedtls library, so
> it's something that people do hit.
>=20
> Let's finish the job by providing suitable limit macros for all three fam=
ilies:
>=20
> - Standard C types, char, short, ...
> - Kernel-style fixed-width types s8, u64, ...
> - POSIX/C99 fixed-width types int16_t, uint32_t, ...
>=20
> Please note that a naive approach like spelling out the full decimal
> value for the constants doesn't really work, as there is no such thing
> as a "negative integer constant". That is, doing
>=20
> #define LLONG_MIN -9223372036854775808LL
>=20
> would lead to the compiler complaining
>=20
>   warning: integer constant is so large that it is unsigned
>=20
> and the type of that LLONG_MIN would actually be "unsigned long long", so=
 e.g.
>=20
> #if LLONG_MIN >=3D 0
> #warning "LLONG_MIN is not negative?"
> #endif
>=20
> would fire.

Thanks for doing this. I assume you put this through CI? My only real
concern there is with host tools on macOS/Windows.

--=20
Tom

--G7DLdvflF3CJ3BYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoUVUACgkQFHw5/5Y0
tyzJTwwAmYJjb2T0czuJVcXnuPFu+9TeFZNS3rop1TU8Wpxo6IN10wM8ILbJrTS1
cnQTwUq96UiYd14mmTkuf6fOKpHBwr5nlwa+7STjd9QAYwwgOt7phDTSOVrz0OdQ
BwRfvoCKerlAZw3MkCmV/cnPkfQQHHVHXQcyDB2G6dVkeUwJ7pX8sBnjn77bxsMx
cP68LsZzPg0lQ8OZMvrQPof4HvDGnMttAuIR9OuUIpi9TAdNOWlDPal3wJVUepJp
Y8Sk3fPEV4nWrimtAzIko/H0TRS5pf7fOTpBSJ9dkV3XtnRCF9H6uGwK1hSl9vIx
Jjmvnyjz0Pk+zqrn48flfTU7qchkXhA5rGSmIFa5zXtuc277/FAzweFnqZpkEntk
1np/LCSxcrv7Fpu4eIQ5uD+tyMdFxvQ6jzG3wp5J696kYi7l4rHbXRVH6/XV6A+H
ukwBTaZnzHMbt7mxoSP4arvsK6SCHDMt9o/RxZ2s+1IolJO9PEs4b8YslTf37mwV
D8tWM2nH
=+yWe
-----END PGP SIGNATURE-----

--G7DLdvflF3CJ3BYf--
