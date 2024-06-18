Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F36C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 16:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FE88839C;
	Tue, 18 Jun 2024 18:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GEStYEDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23496880F5; Tue, 18 Jun 2024 18:22:37 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D47688315
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 18:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5bafe063f35so2771358eaf.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718727754; x=1719332554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X9MHDEXea+7Ij+gMcc0mkdTP1CNSzzctXeZyRbdYZF4=;
 b=GEStYEDbbNmSGIZ2VykX3NUn18cKJZCdvYxuswPUnyGoTdiJsqhuwcN+xYcAaVjm8t
 GJvuh3ZHjr+mGATp40pEohnblHAYQ6QEj/G3FkIbcpsa9GfnhmBIegMr9GFAhsqdGNIe
 n26LjcDdT8mnf58Xm0Awd/ln8q/n20pNFNrvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718727754; x=1719332554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9MHDEXea+7Ij+gMcc0mkdTP1CNSzzctXeZyRbdYZF4=;
 b=CRbhSC/5fBgulbtTLSNpEUMciYEjUqq/NCw7D7pTw5y8G4r/yOrPV/YuPB9SGXrKLB
 HdwhZgJhgO2Grw9q+EQ+4nZXfpuoPqJxM17wGVepsno/fE92PUd64mxMJQpc79fjnXde
 1ZlRzLVoU18zHT7DIiFMoRhfvjjARzB2BM9wpC7BIl4p0ACCIzYEdz+WKADuezkrKUnX
 Q6tTN0+YD5zX/tfbjyCFFzRQZsfnY88pJfTbQqqare7yfcRNeJ66L8S1xp9vIgpMoZIU
 c8QYL1VjXE2jCePZ/lD6uo9P5Be6D1rHbYDUS2Ytf8+ovJvskFMHiG9p7Msr5h8OcBuI
 r5SQ==
X-Gm-Message-State: AOJu0YwkBAvzmfqVRaaSOgFMqjaxoyBQWD6rWmzPiq5vR3S2AA9j/c/q
 RcKVJ6i2OKC3j1PiSCoRnkazD2nh9po3ghDyZT3zcmUl1pSUvGHT0c6H339EMBY=
X-Google-Smtp-Source: AGHT+IE9K6OXpywy76pdvPy+SvAD1HnOTnlxCQ9YkT665OqZ5bQfnQ6+LxKwPSORYkdCM9npXwhVKA==
X-Received: by 2002:a05:6870:7b4f:b0:258:37d6:52d6 with SMTP id
 586e51a60fabf-25c94108569mr143301fac.23.1718727753678; 
 Tue, 18 Jun 2024 09:22:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567aa7b3dfsm3236384fac.31.2024.06.18.09.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 09:22:33 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:22:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20240618162231.GT68077@bill-the-cat>
References: <ea3c974b-83a9-416f-8b6f-cab6cf68fb30@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1euyVpjOXWxYFMsO"
Content-Disposition: inline
In-Reply-To: <ea3c974b-83a9-416f-8b6f-cab6cf68fb30@denx.de>
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


--1euyVpjOXWxYFMsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 04:03:50PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following cyclic related change to fix the
> CI build issue here:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1euyVpjOXWxYFMsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZxtEcACgkQFHw5/5Y0
tyxqqQv+NdrN6OhQBN37qEswDnBuq0QzVSttMge1DaSH5ZrcO35yMjv6AC0TA5VF
hXlhfAstAxIeSqBZNmpqeIae7Vo2hxtim5pEXriW7hEwnTM9yQ1mTung0BC+wvhT
Ws7Fpvzm5u329fNu5d4vAzrF+dmNJRCLiU8GnJiPAKrd/vS7soJphBqibPksYzYM
D/aD8miPtq9kKZroGCwNXvF+/NUkaW1Upb6r+CEAclRnkqYYe4Fsz9GJpapnjYvn
K17ykqJCrtMr0kP67ZtSssCJYyKQMGRv56Z7erLvhS03Ndar3llMg4kHAx4zRjmJ
gEPbMce4KJcr+F7K72HC1cIrgLpqk05iZv3mA6Ox9W/vuOxLHrcze3tod9zUyOZT
a3etwAnkEKqgEgMaKaeJ3U+Vz03kuNvB1n7BrtMVlQ69Qb1+TgH/DejBQxDLj9+X
d/cdO34WCTCWrLKY1yNIkAtiKz5Np5Ib5uK9fHgBDB4/qU5UNYHShxkZVwp4kgVt
vrAXD9Rf
=0mwh
-----END PGP SIGNATURE-----

--1euyVpjOXWxYFMsO--
