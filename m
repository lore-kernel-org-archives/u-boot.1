Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA84C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8C587015;
	Thu, 25 Jan 2024 15:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bWflbju+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA0487015; Thu, 25 Jan 2024 15:47:54 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F05080245
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7838af983c1so481843285a.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706194071; x=1706798871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rTfrke/WpvGmjEem3BqALlsPOVYBfLC9RJwGXe5X/gw=;
 b=bWflbju+Y7I5dXqHq9r5epY97g7oEMtxc1fWTfsrXY1IwwxuhRSTNpGYOdJNova6y6
 I2L/s5ITWLEbhsWmmE125QtsicjtPoVjaOqv4rNjADjB+h+ZcjR/nWcfW7TXgTrf3C9d
 lBEAqX9iJphqN01eFgrIHS7DFxlsYoYjXXCg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706194071; x=1706798871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTfrke/WpvGmjEem3BqALlsPOVYBfLC9RJwGXe5X/gw=;
 b=MStyg2UnWgGUTtNU6DaB7haLkJNNnBY7nRVL6iFyRuQYfAqnZTAG6FDbNo+jI7pMhs
 QRH2CyijyC4S3g2nLM5CUHEYFTq1FeY4kewMV0eZqI0DF31zt+A2U9xxDCRmN2TY+7Bz
 D7OrZvFFvjogYLYgi0sC383sm6FUJRcSdbEurtGlY17vR7wb1RXeGw+GKgKfd/f11yrc
 91JCQujFlrhfMBvsTeQPlf+6pMypsee+xaHphd5iGo9BKAOMDjkge9GxLg4dbEEuTtEw
 MfzQLcnrl0Cad9m8R9sdtH9daoq/doYvobc/rYwbOZscQEV4N1ancjTfj+OMw1uerGZm
 GMdQ==
X-Gm-Message-State: AOJu0YxwsbQlbD/qfpKHcnI6THsC3xU0EODFNJjPScB8DqdeEBXeNjtp
 F8lcg/D9hEVkd+QAvk9myZthUNYPLeZxEnt9DoKYUF0D0Hgo9g3Q3eRmtuiZL9Q=
X-Google-Smtp-Source: AGHT+IGne/K21wRJG+sbufJcsXHj0EfHvg2zYonDXoB/4skEGBLw51IrJ04578HmyKR4b6y/+hSSOg==
X-Received: by 2002:ae9:e00e:0:b0:783:c579:c246 with SMTP id
 m14-20020ae9e00e000000b00783c579c246mr394948qkk.45.1706194071259; 
 Thu, 25 Jan 2024 06:47:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 cx17-20020a05620a51d100b007833008dae8sm5122123qkb.98.2024.01.25.06.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:47:50 -0800 (PST)
Date: Thu, 25 Jan 2024 09:47:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav <clamor95@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
Message-ID: <20240125144748.GL3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
 <20240125141236.GI3652023@bill-the-cat>
 <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
 <20240125141734.GK3652023@bill-the-cat>
 <F6B6FBCE-59E3-4334-8E24-4BF5C3C4D9B7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TQZ5zpZnOB6WtFe4"
Content-Disposition: inline
In-Reply-To: <F6B6FBCE-59E3-4334-8E24-4BF5C3C4D9B7@gmail.com>
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


--TQZ5zpZnOB6WtFe4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 04:34:41PM +0200, Svyatoslav wrote:
>=20
>=20
> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 16:17:34 GMT+02:00=
, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> >On Thu, Jan 25, 2024 at 04:16:11PM +0200, Svyatoslav wrote:
> >>=20
> >>=20
> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 16:12:36 GMT+02=
:00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> >> >On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
> >> >>=20
> >> >>=20
> >> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 08:29:54 GMT=
+02:00, Dan Carpenter <dan.carpenter@linaro.org> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >> >> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
> >> >> >> Currently, if boot with extlinux.conf and do not set the fdt
> >> >> >> U-Boot will provide its own device tree. This behavior is
> >> >> >> beneficial if the U-Boot device tree is in sync with Linux,
> >> >> >> but it totally halts the booting of pre-dtb kernels (3.4 for
> >> >> >> example) since it uses ATAGs. To fix this, pass `-` in the
> >> >> >> fdt extlinux field as a signal that no tree should be used.
> >> >> >
> >> >> >Passing - doesn't seem like the most intuitive thing...  Is there a
> >> >> >different argument we could use?
> >> >> >
> >> >>=20
> >> >> I agree that `-` is not the most intuitive argument,
> >> >> but this is a way to implement a fix with the least
> >> >> code posssible. To make this less obscure I have
> >> >> adjusted documentation.=20
> >> >
> >> >It's also how historically we do similar things. eg, "bootm
> >> >$kernel_addr_r - $fdt_addr_r". My question is can we re-work this,
> >> >cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase size
> >> >anywhere that doesn't need this legacy case.
> >> >
> >>=20
> >> Which behavior you propose?
> >
> >Well, using the IS_ENABLED macro with the new tests around "-".
> >
>=20
> So using "-" for booting with extlinux with ATAGs is fine for you?
> Guards, sure, I will handle this. Which tests you are interested in?
> Maybe you can point to an example? Thanks.

Sorry, I meant tests in terms of writing the code, not unit tests as no,
we don't have enough unit tests around booting a kernel as it stands and
I don't see how to just add a test for extlinux + legacy kernel.

--=20
Tom

--TQZ5zpZnOB6WtFe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWydJAACgkQFHw5/5Y0
tyzCNgv/WFXwboeB8ofZdqgOz9M4ZcwgtLIuZFkMlsp1fHjyIwW9n827nfZC3rJL
NAv4nvGelPEZOSdfPQNYVekGfGHqxD6rZD3t8u/kSjGA4aY62bHUygBnH210cdlb
nxX1rsijs5bKSNcCgqPwONkKs7ztQ5h1V/8p1wqcrsYXYlgEv4iuibZp594JgzLX
d0C1eb2Z1N3w72FWtmt/w9ZatIEoqbPYWMPlheChXPZ+xe0Dql679wkWNUd1EVKA
JKY+y8sPkjlxS1RnkuACocI/drvAuaQt486RkS9SDJWAz5AD6Ncm+CCWZRHe60FB
To3ee0zyYs0b15CYk+sMxhXV/u5uy3ZGWTOZDUjOy4F6GBjF4W0TODbVzNUulOPa
LPLHaQTeLktGSL7sO5tDIIGwcaQCtXW77qdYQQTWXsIOy1vHOZXJjixjxQy6kw2r
zDb2yIlHNICPJYh1+OnHeZ5P423mnrcRjapXqoWi8VgYQ1avjb7L8Y6d3cOxvJaC
D51VtwwB
=BgYS
-----END PGP SIGNATURE-----

--TQZ5zpZnOB6WtFe4--
