Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B3C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89060874BF;
	Fri, 17 Nov 2023 14:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDMareLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830E4874BB; Fri, 17 Nov 2023 14:41:23 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB4186FF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7788ebea620so117227585a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228480; x=1700833280; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=24UCiCQFHcN95lneDQQ3TTZwYe1kFSaQSi1Hp+HWaC0=;
 b=DDMareLBWlIrDcSET1ptWpU6xhxO1AXvMB8NuxR44ENmFcmpYT3/yfDH0udpviyP3n
 bg/uwblLqXF2eDjM7yrBodeScaeXA6stireeoi7gJcyiNqsEdT81UbzIS9VF+I6Vu8L5
 G76wkh5ebJayDcfkvbOXLQHN0LRPdWIyfhHQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228480; x=1700833280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24UCiCQFHcN95lneDQQ3TTZwYe1kFSaQSi1Hp+HWaC0=;
 b=q/unK3WzyT1pD3s75sLrZfRw+xH9JtWHf7LlnsEzyIlRCRiu7YR76C95FzBTz4mHW/
 SaS308fZqJENf0K4lofET3CsZwZnxMURZ9rVDNJggR/hKReYbdEEOEBaoCLKlFkX9PTz
 dzB5w3NeUeOlAMigNf43MGGSPC2nAPN5RqygCA4WfRPvNpPCKVNfhpaNDC++YTI7N3jJ
 LELu/lb33nCQQKgMzytoGJln1TKdUVRlrnYlfYZ9AELDRgJZ4sHWbyaI4BSPG30JDVA2
 a18qHRbv9rb7qY/YxICXg/OvBshrMh3JczPiTtI18+gYN/AuWcGRxLU37Dbn3/HfLvok
 C1TQ==
X-Gm-Message-State: AOJu0YwzdgXPBO2RAom81ZDIMTqu1XMjCMKZG5HVn2dpUKgmc7//vQXl
 G20utNwudEKKT7PgGzT9Qtl/v0AhwlL4s7Qx6vrLAA==
X-Google-Smtp-Source: AGHT+IFn30ImZSRxE4QXCojzfjyLKGWPvsR8nhMC94tqbq3sDIK3BFrvBaposapUQqVOb9OV78xVgg==
X-Received: by 2002:a05:620a:4014:b0:776:fad0:cc3b with SMTP id
 h20-20020a05620a401400b00776fad0cc3bmr13466902qko.1.1700228480290; 
 Fri, 17 Nov 2023 05:41:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 bn2-20020a05620a2ac200b0076cdc3b5beasm600247qkb.86.2023.11.17.05.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:19 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] board: cssi: Remove usage of common.h
Message-ID: <20231117134118.GM170968@bill-the-cat>
References: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
 <76cdb4a9954d8686a0bdf7c165152e4fcbf9bd3c.1699294233.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4aDt5x88JAOtcUkb"
Content-Disposition: inline
In-Reply-To: <76cdb4a9954d8686a0bdf7c165152e4fcbf9bd3c.1699294233.git.christophe.leroy@csgroup.eu>
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


--4aDt5x88JAOtcUkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 07:12:05PM +0100, Christophe Leroy wrote:

> Remove inclusion of common.h and add relevant
> includes when necessary.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to u-boot/next, thanks!

--=20
Tom

--4aDt5x88JAOtcUkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbX4ACgkQFHw5/5Y0
tyxeNAv+NefJVw+WinOMA/jsFmv+rMqLDalrorjDzK2DwSrsl+Gv03EWKwFlI3aZ
wpAMguCYGoujWu69abbBo93Fp17Jp+PVwbyLxEiMMmV4aM3HTQQ4nuLD6JmpPFXZ
3g1O6LPE4QRcRyodPnXUThNBdoohb1u0yuE9bRL36bq1lkwfwTdhF/lQTPJqXz0F
/6mF01jAt1Vp2WK+rdf/gNIHjVvptW2dwkrF4R6RpDHd4HMzgW67TllMZEjMNfIv
ojE8Axip+NcXGYhs3pDIoPZQiR6kSU3uav8hyxHXXUQ/hKqRW/TE+9IV9ENR6d3A
f1PL6xXUv6jeUPiYxQdlpfOoE6IuoBv11R+s8SqpOJVKTRIizsYTFi6qC3Jko66Z
5P5OUq7XVZGjgHJFhXqMLGvfZfEpgSaRRf2DOWQ6VO16PLa4ZQnlaxh9wuitsrg7
81uqA0OpOed7BrfSS9Q7vM0pbZYrZrW1pfnAOODLk9p76QJrPwDHZddVGKGZWrhs
Cc4rqNVS
=rkUU
-----END PGP SIGNATURE-----

--4aDt5x88JAOtcUkb--
