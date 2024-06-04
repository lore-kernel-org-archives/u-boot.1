Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726A1C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 00:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656E7883C9;
	Tue,  4 Jun 2024 02:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SzheSBxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DACF883C9; Tue,  4 Jun 2024 02:35:44 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B81587D33
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 02:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b9a35a0901so1799503eaf.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717461341; x=1718066141; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RKngSLCiNmUzqZUcMvR/ClTFjWznMJMv2MFPxDSk0fg=;
 b=SzheSBxVbBWtME9xfnzazTk+XA0/SBy1aGKsMykjj+m4MKfc8uAN++pGzElhSxfhg8
 5bHDacxUNNdIX0oj9DhV1eKnREA56r3YtBNyLGoIAcRgYWatIi7aLed3QONs/y641FnY
 ggaMYPG/RpX6fQOyMwzCsdJYvWPWgV/BImU0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461341; x=1718066141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKngSLCiNmUzqZUcMvR/ClTFjWznMJMv2MFPxDSk0fg=;
 b=f3ba8RrCQ6oRSw6nkGZ6DBZZQBMGQF96Ms5O02v6ma/F9mZFPyWrsg4FUN2lOhvC5F
 SMxDryJ0jCZJGRFCiOHjsOZdpl1qRmhXbBsIYJ7BjTkymgs05dwB5ZNR9pbdBxEVxkvs
 GoJoxGbOYG4Ty2Bms0uu8fK0KfTVI9rfWIyfFPWTqFFJCsyMrKUEMT7CVS2BHrHZ6L9m
 bxb0HPzH3QWBBbryDBwBgSgAREr45QCeNug0016V0dMPbLr3Vg7Pykur46UC5QrNUHF1
 VCye0r10BWuysaoBrBARP7a9VN/xaL9coDG8edQtNYylgOzRzlSDSAmxAhV14c+9uz6D
 WoLQ==
X-Gm-Message-State: AOJu0Yy4G1lE9rDf3ruZvpCYAXt13VlnaETikqR/efcXr9jNvqns0Xjd
 0qd4aOaCw2SAGG9vS8ABpj58GdMfnEewxaPaN1NOfHxyA4zto75N4LSzfxNNcp4=
X-Google-Smtp-Source: AGHT+IH1eAsDr23WxJqYgvV/fjehmZd0SL7n7IXUhZP1cwO4ktQgIG3SI4PsfOTViiESD9oQE18qzQ==
X-Received: by 2002:a05:6870:5e0a:b0:24c:678c:4282 with SMTP id
 586e51a60fabf-2508bcb4144mr12352967fac.44.1717461340723; 
 Mon, 03 Jun 2024 17:35:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9105a9243sm1711297a34.75.2024.06.03.17.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 17:35:39 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:35:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next-cleanup
Message-ID: <20240604003536.GG68077@bill-the-cat>
References: <20240602125146.12460-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wtrfp9ya7J/TxVbP"
Content-Disposition: inline
In-Reply-To: <20240602125146.12460-1-marek.vasut+renesas@mailbox.org>
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


--wtrfp9ya7J/TxVbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 02:51:15PM +0200, Marek Vasut wrote:

> The following changes since commit 7e52d6ccfb76e2afc2d183b357abe2a2e2f948=
cf:
>=20
>   Merge patch series "FWU: Add support for FWU metadata version 2" (2024-=
05-24 13:42:07 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next-cleanup
>=20
> for you to fetch changes up to 63da3a795e86dcf0906beb99865e3d4139114872:
>=20
>   ARM: dts: renesas: Drop R8A779H0 V4M DTs with OF_UPSTREAM counterparts =
(2024-06-02 02:30:13 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--wtrfp9ya7J/TxVbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeYVgACgkQFHw5/5Y0
tyyniwwArNlQjgkchfDodk28vd687rTlnV5MGvwpY9hXWsutxlEkq1c9ukDXk1H3
1O+QvN59wN2BvN8fKIxIyjN84jf26E1BWOOLblTWdOZjwjfj6Mtwkv7vXvkH9HEY
g70zS4g/EM0BCDxle1vDOlOzcGTKbantRJ4QNReboELbB0cEgd+frymTCbgZSN/8
Y0BqkMwa/h8KlYpcBajgnv1vwIFCkNs6rzirCwNSBk3vLQ/8idjgbdufstUbVjCF
kQtI+ADPxZNHb57A/dtSSFu0i1KzleI+mvj19AX4FFTAUKXMWwMA2yjp1gCTNtBq
haS/wbupiaY/v70OF8pU8WgDpN13z2o7ZF7wKgpCS/EPCaiBMp7wBAZT56to2rBs
Rj5nY/ul55x7VAxZKw7TreqTyYMVURos+bSrrAWiEgbmZ/eW7U0/9T4Z309A3qeG
6kKB8JROPHFzGjPkXExZGV6w/i9tnJe/Tqh0mMGKW6y6bigsek2Hv9VS3YqWYNjT
uTEylV/D
=737S
-----END PGP SIGNATURE-----

--wtrfp9ya7J/TxVbP--
