Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD1AC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 17:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8CB8854B;
	Wed, 29 May 2024 19:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uxD9lMPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6971388611; Wed, 29 May 2024 19:22:15 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E7F88544
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 19:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-794cbdc2314so382285a.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717003332; x=1717608132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qbLIyneqUsuudiCAb/yYdLY86zGpWBmGkGsSwCWVavE=;
 b=uxD9lMPcKQd3Ee6XbwuQgZ2ltBCoPXxKyPg5i0UcoUfOEy2DrpEVBeo1mMYTI5Gid2
 sTaYZTYL8hf0EZTT62lqq8QkH26N4laSSkYDCHzKqBkaEy92QvqC984oZa68+KOi4OAi
 EVB9g4i/ltF4PSy160JEoslD4KRJls0iu0wPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717003332; x=1717608132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbLIyneqUsuudiCAb/yYdLY86zGpWBmGkGsSwCWVavE=;
 b=jpoBo3xT07a87XgNMOY/W+qUsw+52mUHWXsd27zA5b5NCl62GkspI+H33ArMHaQtwU
 l/RCnpfvT6o7gCBwjdsQ/ETzP5fpaD3UcvY/W0FeRmkEDp1BOna5xXW7ZLNAI3bfrgSU
 Am4TgjMThfVtfkb1WKVK8ZsZjNvbZlztA7z8ZzHCuxn0BEX4qnCtFTB0aO24j1FsTQS+
 Rb4kqRyU2Y+yF+c8+UVnt2jnFXRDsiYO7UEmolghrCVzkBjUgL8OCKXtumAfdeqYjSui
 9IyDC4jlxiiDo14YX4t245ztPZlQq6YxVFtIn7wqR5NsAuJAOXD8Dyp8szjUtDZoUpcx
 Eilg==
X-Gm-Message-State: AOJu0YxK/HkgmA92WEnltTv4qJ/oIqEjwXIDgfjM1dzKqJXzx5MRaxi8
 +7lKwQAZkEJcuRIwcInm17H7YkiPJA1zHy0hNA+mESp8Qj5w4RQYarwjORhMyMJf+3oLtLk/R4J
 C
X-Google-Smtp-Source: AGHT+IHjf9CGRQaN2GXUydnllfiAH8cB8vUPHSszW/MZp3LYpo3bLgX5gdnws8R1OxfDfdOehvnXNg==
X-Received: by 2002:a05:620a:1023:b0:793:fab:b503 with SMTP id
 af79cd13be357-794ab135bbdmr1650600985a.64.1717003326764; 
 Wed, 29 May 2024 10:22:06 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abca8ae4sm488793385a.16.2024.05.29.10.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 10:22:06 -0700 (PDT)
Date: Wed, 29 May 2024 11:22:03 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] doc/sphinx, test/py: Update requests module to 2.32.0
Message-ID: <20240529172203.GA3714513@bill-the-cat>
References: <20240521223253.1858188-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8amuuryiGbuqBW+6"
Content-Disposition: inline
In-Reply-To: <20240521223253.1858188-1-trini@konsulko.com>
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


--8amuuryiGbuqBW+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 04:32:53PM -0600, Tom Rini wrote:

> The issue described in https://github.com/psf/requests/pull/6655 has
> been assigned as a security issue. While unlikely to be exploited in our
> usage, update to the current release to fix it.
>=20
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>

I'm NAK'ing this version of the patch as upstream has now "yanked"
2.23.0 and 2.23.1, and 2.23.2 was released on May 21st and 2.23.3 today.
I'll revisit this issue later once things seem to have settled down.

--=20
Tom

--8amuuryiGbuqBW+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXZDgACgkQFHw5/5Y0
tyx2Zgv+Px5QFwrCzeaHFbSBG5jPMqI2jAmxPTKjSPbk3VmmC7Uvf9Xg1KMn13ud
jyPodhKkaL6hQqZAnio2PucxhVzqDOBCT3Wajmva8SEu2/zu0hMVDNjVsU+mpnqq
BMMOo9TCTxFgBdHz0/fq/1PKrbHxna1ConBDwJLEoAFtxQfyIPjkcuPj805lef5e
ID09Rt1BkwXga0fM9k8f+3EUbqnuQelb8YjBde1fWZX3a/dxtEdrtsKYGzGw4vC8
6hR1mECTb8XfUHzwGQCEHknGbtr3teXn0LmCf0G5acoRWTNXBy7exGXHKRb44dfY
qvWYucxDBGfjf34d/oqzI2NplvAEnJ0RFu0n+c4yc9WDVIYLTHXV59x/aEyDC5LP
KafdyeUTfAl+uDTO2430v0knDF8ExrKw1/0uf6+rM8Z1OHCfecFvEgbI7lEP0pLy
5cGKlnhnmLbeXCbCmgDCD9FxAjF5lBdxeR80HqBbf6eH6ccsh0zIU9XapwFcSyAc
3i9BxwA4
=oOyl
-----END PGP SIGNATURE-----

--8amuuryiGbuqBW+6--
