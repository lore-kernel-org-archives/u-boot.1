Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HHbJRyDu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ntEg+ewO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA4F9405FB;
	Thu, 22 Oct 2026 01:46:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFXDoI14F9pn; Thu, 22 Oct 2026 01:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39331405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792633561;
	b=nFHRjMDyRxwiAkb2NIqpGUnzJqeVcf0jp2hUZ9frIxVJq6eO4KPP6zBt1yJhivvSk8pn
	 I0QkfDEpyPxNZAZ170cx2GdPnPIUOB+KniDiMFofwaYm77hBBemg99de+//L+VD6RiLMH
	 LyQwa5qhuHe6SzrtR20vlwnluRfcXkYDOjz7xjbosR/fenYFwLTGrkZiXmNhB81bf7UpP
	 Udl9E49Tfo77+Z9vXQdmzj4iJUugEAjk301pr/XsV8FO+gESG7r4oMAOgj+Ooeb8BoYgT
	 up+IuN11PfmI3CGorMa2ajdjr3OxqFCV+O/LLSEKRqCQPltWy1dUyPVW3ebyx8ypH5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792633561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XmA61W0+aMO5rjqfzNqjM0gtfbskARKgFISGYh4RQIg=;
	b=TugtSUs8ExaZW8jKXw39EIjYDoT+dwAZOVtmc+DFL0Tk+I3RAciNrvF1ozewiHGobeT0
	 G1c4Y7/zvDlvAcDQXoEeEwzjZwvoVYuyxVFMoJ8o5LGtAtaHx97db2n2/sMkzoNP3RbI9
	 oTsK1CKPk8f1Jv+lDKnDP+D9xP1/NkxucLh6+JrwMyKm2ZVBm2USZJZoWL9DRFTLE9144
	 rhLT2M0KgjqYZrRBaatGaJj5E9tASd4T587nbsSxFYLKZo1U2b41NLxwx5Oqn1p5ly4uA
	 yR63QdTMN4ORdEGWs0JFA7mLQ4rPticolGdFGbQdJZnHisTWB2cx3jt/6ees3sW98aw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792633561;
	bh=XmA61W0+aMO5rjqfzNqjM0gtfbskARKgFISGYh4RQIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HHbJRyDu4NIAWezsB2iU8SyxAf12hcnYjKAmxUUl3iAUJxkboEpvRh3Pk4mMqM27z
	 jDkV4Iusxxa/YF+zVnrBTlkWf978d5ic6c+6ck4gbSmxouoTXrVns6nwWmR6Gqof3c
	 xyqiP7JlX+diQfnF09ijyHQhtHcQipMuxF5At2XN5UtwcxqOxFPaGTeUO0dunr4yJR
	 kNYHkvffIPafUnVHv2jDqXWKrI98+kEANUHFk+Ob+zBMYqyJlUyWADilSZydyJN9bQ
	 eyYZdabkew4WP44inJI2wyb1+anbdDv8fQXuzBueokMSin4UPfHDX62dTfFVxoedZh
	 bTy9iL2sdoXZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39331405CF;
	Thu, 22 Oct 2026 01:46:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01232371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAE8D40050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1WV2R5ZqiTW for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:45:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0BD0440042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792633559;
 b=XfOSeE7ZuSqNEtBIezLMoAdWXgcpdZn2VyApZzDYc+rhBWeYrFrUB/BjAwkoIvMCFa4J
 JdelBDI3v0sPYMaS63W63Dk2czq7uR/Q+e9AcFZFmsy4U/hyTyNG+xh+jSTGFWkGR5/nc
 m3vJ9s7XimW1ugVQ0ZokBzp9ynu1ULOWdckPRxqItGGPNL82MF5lc+gFJqj5xJE9uawCA
 U60CFpdWI8HncMusSMYm+y7uVIlzE1pFqqdWnMZGZqPnFGnF7SnmtOkIxvFxBBX6M/7Rg
 kJi/tjmbzl4JLEu5OPTCENFVie49a1YPFCeAwDmj48j6O73ugQyidO3KuNHtsw9vb7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792633559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=XmA61W0+aMO5rjqfzNqjM0gtfbskARKgFISGYh4RQIg=;
 b=GvzeRHoL8QJpRP3QUUiI72MyefGNdQYUZzE9kK1+W2cTjEBH6MqSDFGvmUCO2E//nrbb
 acsvfBO3UtadthjaygQduhcQFIn0am4PrSVLLvlVq66Jsv2xbpOQgbOzfUBQ1PMw39Hz3
 ErIOKWMJb0VsEL2TZZnlevpQrlxka5CcQRdCuU61jK2UBfAjY8X8oKLDjM7iovMDHpvyJ
 oqOZbx0x3yF/9Nk0Z+9LvXUVwIqTRzoYTkTCZo4o2FrSM28FpisRQIYAN+HKWIqYZomLo
 L+dLI9tCoj/tyum5H+u6UDwqI1VrrrCsJ8IEkBDjSuOko2HXT2/sh931g4Zx8Qusccg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ntEg+ewO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ntEg+ewO
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BD0440042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:45:58 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-81ba09a5d23so1317695a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792633557; x=1793238357;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XmA61W0+aMO5rjqfzNqjM0gtfbskARKgFISGYh4RQIg=;
 b=ntEg+ewOb/TatyFa7hlixI8390OchJRo1TMKwDYEr6onAY1JQelgrSf77i8mruCRuZ
 L+g4ePVGQwwEdtApgTSU1hZbzCM+qlCaP9082GOCHiYw95UkaVB6wCJmAynU1GRDaJWh
 puHriWCh15S9nZipzr5fdmIODbAqhRHqlPqxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792633557; x=1793238357;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XmA61W0+aMO5rjqfzNqjM0gtfbskARKgFISGYh4RQIg=;
 b=WU+QNo8aQbgOk4mhizExdLBnPfiqd6h4wOagEzgrPOf+xgDLKviLSImUUoFkZyleCu
 7qu6AG2e+C/+q5ClzWepY+5fgc5ruO6xwxi4hK1Menv8oyn95cQBBn7zAkPerTfzdtIS
 A8o0yA9o8CTF7lOUyHY35dArQ9pVC2RE4C/OEs2GDXzxK6dmBLtXWMtgWFPoQsAiFZf8
 YU62SfJs6nEys2r4POSQnI4gmHfxLjc4csrT9bSVqglx4gYp9IUTDOzcy/MigDJ9/nT7
 C872R9tFRqCI9odU9Ta7v/e8dNMbXT7op3J2RgY5edBJ91MpzP+/NkqVvUvJT8ghPEK5
 0K/A==
X-Gm-Message-State: AFq9FYJOHXBqhWJGsK9FFbDTdYJsPRqcGBF7AsO+B3YssKDbJRDZk1TS
 j3MMkw8cBB+As9I0T4gXGxN4R6ri6OPiUHTVZGZFqcyk//avjMYzJXC2JON9fRKQgqrBDbqav5n
 D4cnoFEkJlUW/
X-Gm-Gg: AYBFou2sBykcded4XrclYoovXy9RSNUwRQp1E8EI/KS5mpkpnTzVSjHvxmm5Dzb9wKu
 L248s84WF/Ady/SxpX4biLWZsv2Yu6a0FTca743QMXewsO9/EfndtGlKqG8WOBf7GAgek4Y2km5
 tvt5DwN4o44aSravtSkTXEN6bEjRZb1JqgvF9w2nWEbhneg9LP5anT/dFG90UhFHdFUmzFgb5T2
 ur7nGw8KC36U7yBNmgMJWekPxPMaKk7IoEyOqCjR3v1B+WvAOkxXcBxztv5W7vLzZIKAidiq3L7
 l40AgQCNWTJJD36cQKGWNUOu/dtWxU0NJYXmoqBC/a+KHpCieFRYlhTUDe2GicdLZ4XYbvqIv/o
 P/E3Mg43RVTR8NW2eZ9gOOhEZAyDOq3IidvW/j8S+ndcx7hSftn+XMrGhVe7wirzvjUnvPgFHhM
 Cpn/fZpyTTKrRFsejLQKEK8U1lAS8CvKht51evEywddMHD5U1tFIGaXdsuZxUgculQ98XFpVhFv
 hPvP1/oSQDAapHxY/D/PAI0qyQ0NZ22wleXh3XPQW9fiOg9OfgI3VbhQQT5ZyETjeYzk6xlFKwr
 2Q6hglEvLY3c4k3eDw6ccHCWAoLRSlKih7E+si76PJmtL87C+bRxrAbbxGLeiozaips/Mf/rdLc
 2
X-Received: by 2002:a05:6830:438b:b0:843:cc20:9d03 with SMTP id
 46e09a7af769-84d0840637bmr3140075a34.6.1792633557438; 
 Wed, 21 Oct 2026 18:45:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd7d4431sm4094171a34.19.2026.10.21.18.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:45:56 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:45:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>, Sinan Akman <sinan@writeme.com>
Cc: u-boot@lists.u-boot-project.org, Mario Six <mario.six@gdsys.cc>
Subject: Re: [PATCH v3 02/26] board: powerpc: Remove MPC837XERDB support
Message-ID: <20261022014554.GN3275858@bill-the-cat>
References: <20261021160145.10430-1-brads@mainlining.org>
 <20261021160145.10430-3-brads@mainlining.org>
 <20261021180946.GG3275858@bill-the-cat>
 <9c11fc28-0397-4667-8e9e-823838781a63@writeme.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KN533rszJ+4IKfAU"
Content-Disposition: inline
In-Reply-To: <9c11fc28-0397-4667-8e9e-823838781a63@writeme.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--KN533rszJ+4IKfAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:25:18PM -0400, Sinan Akman wrote:

> Hi Tom
>=20
> On 2026-10-21 14:09, Tom Rini wrote:
> > On Wed, Oct 21, 2026 at 04:00:58PM +0000, Bradley Morgan wrote:
> >=20
> > > The MPC837XERDB board is unmaintained and lacks active community
> > > testing. Drop this target and its board files.
> > >=20
> > > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > > ---
> > >   arch/powerpc/cpu/mpc83xx/Kconfig    |   7 -
> > >   arch/powerpc/dts/Makefile           |   1 -
> > >   arch/powerpc/dts/mpc8379erdb.dts    | 153 ------------------
> > >   board/nxp/mpc837xerdb/Kconfig       |  15 --
> > >   board/nxp/mpc837xerdb/MAINTAINERS   |   6 -
> > >   board/nxp/mpc837xerdb/Makefile      |   6 -
> > >   board/nxp/mpc837xerdb/README        |  97 -----------
> > >   board/nxp/mpc837xerdb/mpc837xerdb.c | 242 -------------------------=
---
> > >   configs/MPC837XERDB_defconfig       | 193 ----------------------
> > >   include/configs/MPC837XERDB.h       | 218 -------------------------
> > >   10 files changed, 938 deletions(-)
> > As we had talked on IRC the other day, you still care about this
> > platform, right Sinan?
> >=20
>=20
> Yes, I would like to keep it for now especially if there are other powerpc
> boards that are staying.

Thanks. Bradley, lets wait at least the rest of the week to see if any
other listed board maintainers want to speak up. A lot of these
platforms fall in to the category of "they still work, they don't need
touching for recency".

--=20
Tom

--KN533rszJ+4IKfAU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatlq0gAKCRAr4qD1Cr/k
Cp9GAQC74bBlDSfOaaZO7dxGEBpeeG36Y/fUAGHBVqp9bR/REQD+JRUnkSVdQS8I
OomxJTpIb7XCdva0daeM32x3FEczCgQ=
=AEgf
-----END PGP SIGNATURE-----

--KN533rszJ+4IKfAU--
