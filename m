Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EB0CD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 17:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEAB88AE8;
	Tue,  3 Sep 2024 19:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IOPZ2HID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7079888B49; Tue,  3 Sep 2024 19:44:10 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1BE887EB
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 19:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-45685a3b1d8so45023411cf.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725385447; x=1725990247; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sa9qVM6uasix1YMJBL+DuCWIgfqGLLWwfzSpquJVfOc=;
 b=IOPZ2HIDpmDcE2a0WjOScuDMM6OlZttN2PKy13RgaEg8k5yeoxNbGC92xmc4kPxrOl
 A8uaJxk5NrJK76vJN8HzbZmj7mHGREN8mE9cAAy43HJryZzgdXhr2eyV/PJ3URQH1Rne
 ow56ol1jzEOJA+0SuAhS5wcn1YknBhB3QzdUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725385447; x=1725990247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sa9qVM6uasix1YMJBL+DuCWIgfqGLLWwfzSpquJVfOc=;
 b=j/dI6ElZphoxuWG3ODogVYs9oOsvmRuiq8QH6N1bhYLDCj7nlkfD906GyiiZOKu4kH
 1g5a87bZqJMst7Wgg5abzz1+SilaJabezg26EXtBBvKT+NhRwdHRnzbgvwJDTJzI7002
 Fkn8vRsiON/zLF1tVvoC8aJNr7CCcOK82SPgDtWDLFSg8Cj0IFyiI6VDQWGxZedXkFKT
 h0Vk+ebFBXOA0U6MDZuK9ygbn8EtAwXRzQ6fSx1JQnIXMXBuqrbhN2z8HYpApgZoYhmL
 F3bD5In5s5f2t/JH5+seL54Xh70gIS3i0fEFUSO6qRI6GcOuJgT07CGUORL8CFfOo5Rt
 9IrQ==
X-Gm-Message-State: AOJu0YzzTKqjgtiwcxeY3LH2lbd3b04SLA7tfBCZR8Oxuc/PTzHbK5Zh
 DvlB1CMu0G4Sk1v3raGQ84L7Tf1IibAQgsmK9GAhIeS5ygigUoBCoDsW78skN8KQ8BA4dtMx9lo
 6
X-Google-Smtp-Source: AGHT+IErYnI6NLu1n5ot6HPCmSixD4fSqMWHU3Cze8MkUuJD27pUcmI43LNyxvS7vAUND7bUqzetdA==
X-Received: by 2002:a05:622a:4898:b0:457:e3ee:7c3d with SMTP id
 d75a77b69052e-457e3ee7c8amr86674131cf.1.1725385446896; 
 Tue, 03 Sep 2024 10:44:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d69494sm51528701cf.78.2024.09.03.10.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 10:44:06 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:44:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 0/2] Bump new hush commits and fix old hush test behavior
Message-ID: <20240903174402.GJ2479150@bill-the-cat>
References: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="upXff9inXWBipRYi"
Content-Disposition: inline
In-Reply-To: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
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


--upXff9inXWBipRYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 07:09:41PM +0200, Francis Laniel wrote:

> Hi!
>=20
> With this series, I bumped the new hush to get the latest commits from up=
stream.
>=20
> Also, I added back a reverted commit which goal was to fix a bad behavior=
 in
> old hush test.
> I had to tweak a bit this commit, but everything worked both locally and =
in the
> CI [1].
>=20
> Francis Laniel (1):
>   cli: modern_hush: Add upstream commits up to 13 July 2024
>=20
> Ion Agorria (1):
>   test: hush: dollar: fix bugous behavior
>=20
>  common/cli_hush_modern.c   |   2 +-
>  common/cli_hush_upstream.c | 150 ++++++++++++++++++++++++-------------
>  test/hush/dollar.c         |  31 +++-----
>  3 files changed, 110 insertions(+), 73 deletions(-)

Were you able to look in to the issue that caused us to have to revert
back to using the old hush by default?

--=20
Tom

--upXff9inXWBipRYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXSt8ACgkQFHw5/5Y0
tyzP7wv/Szf16WTzQL7J8Megq6LUisxMI4D8gx55m+Q/kSCK7nhyHiAw5Xh+6mrE
CPjDvmwJc9NUHfJNeWDuMmD4fiK6/xmEmXHfzLt9k7cfGadC91SeOnmF/cYgszBY
Yn0ZFlZMjZbQoQORCcazkk+3aISdvD20qkChwtRRkpB4j8354W7d37R4qcqtvtxC
n9GAwk9rpKNxCaaaAqpihk6+YtkJp+7lbbqGMYzbXKMxmKNiqTdLgE3uSRCm89fT
AkTqQqAKIGTmRYZbK/uvrs4kxObhwAVNmhF8r2MPnh2PIPKhRQAE/acSwEdbBurP
xaUlUmIR8mU729zgeh3V6dkAvcXdUSn4Raak9ha9/7OIwBaEP5dRjPHgl8oUTd17
lV9G56MOits6S4RzUyGHDVAoaQdOiDWoLXVk3fDEeCAapYRG5HeaI8kEL04a2guY
YFNGXSYLtw0HB+9AylnfBrBjMTaZGl7YpcMp/Gyqso4A85XG5l3DlnmiknFxLnYq
0Kg6Scg8
=t1w2
-----END PGP SIGNATURE-----

--upXff9inXWBipRYi--
