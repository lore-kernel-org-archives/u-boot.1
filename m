Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760A1C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 01:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901C088B57;
	Wed,  7 Aug 2024 03:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UW7/Re9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F66588B57; Wed,  7 Aug 2024 03:56:32 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578CF88B5F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 03:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3db1657c0fdso807555b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 18:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722995784; x=1723600584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SwBJaq+iBBJy1AQEzc0Vkb4LlLIZqAgjXPzPzn8M6p4=;
 b=UW7/Re9OJIlOtSafQ2cfSs0LsXFM+eiEJhBRxIDnazX+F0zMo2iAFqDG5m8VPkKngC
 nVVUYQ2Nm1CT/FhCfgT8c9c5JK0uY1JDxmKfvQN+UarehIN6/PSxFEPj6kbviT94AqBS
 gK1FY+Q9BukMCHZ7PEv+JjPtU3VlGU38nfWBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722995784; x=1723600584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwBJaq+iBBJy1AQEzc0Vkb4LlLIZqAgjXPzPzn8M6p4=;
 b=AR0vPw3TvoYjmx1i95qRuA6q65ODpIDgS0rkAkt6PoYeRRKwLPCNdWJDa5Wp7HRlbJ
 i+dOjd4b6R2h5RforcAbkIKIzNMEaGzzXmr2OsommlV+LZEdwXRsxa3UpRTtoiwZmUUz
 H54xpuuEAscGPDfZB1YJObbyOD1TKq7/scVovkGDIMTcwq4C4xrQPnsOxlKqsHeJpKa0
 0EYtvO7uzNCq5S4IRYGFtIZRwUHvaAZXrXptxiBW7/cMuRVsCWVvUARvDv+y2pdYEq6R
 ODsvhr1g7zcv+/+PZOYRJjBcwo4CCQUZmzrRbXrieb158F7diu2EqxO/BKncW9SpkmDv
 TtCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFhs4hp343vFyRjcfvH8sXVu7sqI1GGBVgfd0hb7HG4yNo+AIrgn/rstYBdLRG5b1rqTZ7g4jXpvVea/qogjg3daQOZQ==
X-Gm-Message-State: AOJu0Yw/VZyIQI8uKk9rAjaHC9T2Y+NfDa7LWzXz8xUkB5ANGXTKls/s
 xK9dLx+hXxckK4+2WCNNAbJcuT8oWFau0hPueM+370c0xioYgRNkez5N7FlKLrk=
X-Google-Smtp-Source: AGHT+IEJ7mIQX0VHmDdpAvjERLXkmt004n+92453ZxoYfhGeHnBfVOX/1ecQe1FXjj+/Y5gcaN25Rw==
X-Received: by 2002:a05:6808:1694:b0:3da:a0a5:a26a with SMTP id
 5614622812f47-3db55807022mr21484227b6e.20.1722995784469; 
 Tue, 06 Aug 2024 18:56:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a75087dsm4306933a34.50.2024.08.06.18.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 18:56:24 -0700 (PDT)
Date: Tue, 6 Aug 2024 19:56:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de,
 upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org,
 eugeneuriev@gmail.com, bmeng.cn@gmail.com
Subject: Re: [PATCH 3/4] dlmalloc: Fix integer overflow in sbrk()
Message-ID: <20240807015621.GE1626301@bill-the-cat>
References: <20240802100846.16619-1-richard@nod.at>
 <20240802100846.16619-3-richard@nod.at>
 <CAFLszTgcWPed0JP-oN+JSTc914+yMWxHjR3AeUeyZDtZQ8Bntw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nIXxSIRgreyVYJL"
Content-Disposition: inline
In-Reply-To: <CAFLszTgcWPed0JP-oN+JSTc914+yMWxHjR3AeUeyZDtZQ8Bntw@mail.gmail.com>
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


--5nIXxSIRgreyVYJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:50:41PM -0600, Simon Glass wrote:
> On Fri, 2 Aug 2024 at 04:08, Richard Weinberger <richard@nod.at> wrote:
> >
> > Make sure that the new break is within mem_malloc_start
> > and mem_malloc_end before making progress.
> > ulong new =3D old + increment; can overflow for extremely large
> > increment values and memset() can get wrongly called.
> >
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  common/dlmalloc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Should we update dlmalloc to the new version?

A worthy but non-trivial goal, I think.

--=20
Tom

--5nIXxSIRgreyVYJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmay1EUACgkQFHw5/5Y0
tyzfVwv/ZcZMEOjHieKCv3XSTcfgLnDcphZorw43Eu9eiKYAJee3sXA2oo1aRxmA
4xvbStebCJ0520JgWiVDblNpAfgQQYZKz3vQdjcOFMcWdLJtY6N31GPtuIrjc/wu
AiaO6/ExtKN7kcvZbl7LI+NQvJN0BF1veAYLsB2Hv3/qHDiZIG0qUUM/LRLRsMjc
PR3YkzTwV3IDCE9/ojV/roELU/lVVHy1niSyBxPVHCbtd1moLegV43keea+3kuOQ
Vs2pfnWjovuHVrHwipqu5/NPKYMKlGIbD1Yzpb6wzgOv2pC0gADk5/eCn0DkjNre
Mzbk9DmqR4Lx+J0NWksakiWX1FHqLi/TghYoFq6cyzgF+jkBAALAMCGr0vf1Uwdo
1mGjiBw/n1kw5cEVI1ImAe4avHs1lU4ZPnt4wtBtXli/hAwB/3X8agkDy0wjcEh8
bi7tFD5lmJixhwgKsbq3GNnr3nphvwWTf+E15tmuRayX76PTO43PeW9vMZP6Qjtu
XV52WHZL
=BIUB
-----END PGP SIGNATURE-----

--5nIXxSIRgreyVYJL--
