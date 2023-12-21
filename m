Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09948C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667398767C;
	Thu, 21 Dec 2023 22:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4GRns9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C4B869B6; Thu, 21 Dec 2023 22:07:31 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70CF877CB
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-425cbee636fso8459551cf.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192848; x=1703797648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tYgBR+DLRMLuHgloKpFK9je8tsjY68srHEvv3bsdh8Y=;
 b=L4GRns9kHue3xvSqlacuxxXPI/dTew0YKxmaX+Z1/l2O6HTFgYhWDq5mbSLI+h6gjy
 yfmtIhMDl5bPezt/wABqbf+r9DycR2WYz6/21LoI1maHtfr8usxCPUDJUmvSv67oA/eM
 mHJ6Q+gG6SopweKeRp8BjYNM5mUNDeCpYhbPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192848; x=1703797648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYgBR+DLRMLuHgloKpFK9je8tsjY68srHEvv3bsdh8Y=;
 b=rW03Z10WDJT4LBa3ctv5VDshUAtKoINC5hRguiqEyk6n10gsy3RrPhZkxSBFwv4Ck0
 J0yZRlxbinbbiioVsF1LBbb2PFQVPlR2oQ1gZxokMQQmTNX4RG3aY55cw6LmyIJP9+F6
 fU6BfC759CVcDq7vBXDEFDax6JAa6RLvNuz0SSr9lKoU3ofXIgHf6bkm1jBHQwRxh0ZV
 jgG+jmNv2NOuc2cLj7D5/bMiPUDumlGZWjCAwnWk3qgBrZV0DrCfyL59F4rmdjOxWrc0
 jf2tGSj/5MMcjYHzsi93YjGBRP80edld/Be1OME+Iv7Nqw9jn357jzdmpvdTYbYHvvWU
 DLlA==
X-Gm-Message-State: AOJu0YzcepXXoo1iGY7wMo+yZmaIE6sOdN+dIBKUyxpeBdYumcHRxty+
 giaE8icn2mCsKZVpl3iUzoDSb5i6SZWIGZMACFMRqIkrNSA=
X-Google-Smtp-Source: AGHT+IEPmvtz92TO2nCaoF5HBcMHVWPZjnzFmfXsO74N7wMkeJpwqeD0WWOjrqanIpslpVom+UtnnA==
X-Received: by 2002:a05:6214:d47:b0:67f:8f14:cbda with SMTP id
 7-20020a0562140d4700b0067f8f14cbdamr439636qvr.16.1703192847821; 
 Thu, 21 Dec 2023 13:07:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 z8-20020ad44148000000b0067f7e41de80sm858631qvp.46.2023.12.21.13.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:27 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: u-boot@lists.denx.de, lusus@denx.de,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH] board/keymile/kmcent2: fix update-nor indentation
Message-ID: <20231221210725.GU2513409@bill-the-cat>
References: <20231212143927.1401784-1-tomas.alvarez-vanoli@hitachienergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pT1XcTwmZ3wRYMji"
Content-Disposition: inline
In-Reply-To: <20231212143927.1401784-1-tomas.alvarez-vanoli@hitachienergy.com>
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


--pT1XcTwmZ3wRYMji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 03:39:27PM +0100, Tomas Alvarez Vanoli wrote:

> variable was indented as part of the value of the previous variable.
>=20
> Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

Applied to u-boot/next, thanks!

--=20
Tom

--pT1XcTwmZ3wRYMji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqQ0ACgkQFHw5/5Y0
tyxZeAwAq6k6D6fbDHe7/9oxyLKyqr/WLiZs0JKaXyc6TJxiKIaR/J58jqhGCitK
txaSqfSIBPxPWZRwQVA6USahDkTW/9saMmkz0TSiQhVGxC1wXL0FKXXc78SWn1LO
wyiihqCvQt2cWcsTGK8qr8E44idN9jmGY6uZ78GfXbNv1aSzrnWfcD/bfj8CY/GN
KrT6jBTsz44x/tC3bX5KWNxZ7G37XQYBLxzASqiXo56wFGL3p2JcUX9u3plGZaYQ
A6HAtHkeuP0oif2nKEFZybPiFo9MBUJu6wLijcia1eQWsCPZ3jMGSJAG75Gt3qR+
Yntmr9MuDHJkw57GmNjaQjuSvGoS2jYOVtdAxoYcelXsVzW9v/dcqIAMbJjisP6K
F0adVaRe+FqBcnbd3nWycMKjBwZeybG2qog4QCxIkSWwNFOrFppkJgDNYU3ONvi3
nHcEfQb1mLjx9TEUZCsnDb4gPekToC9rvgLHfydwtcr1siJxsUi0U4UIa1DNigKc
/ssagl0j
=NBQE
-----END PGP SIGNATURE-----

--pT1XcTwmZ3wRYMji--
