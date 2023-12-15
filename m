Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810A9C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABDF8767B;
	Fri, 15 Dec 2023 23:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nDfqKG3E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D944787BB5; Fri, 15 Dec 2023 23:47:56 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B978761C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:47:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67aa0f5855cso6094056d6.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680473; x=1703285273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jtIos0rqjRx/PEuynE5IdYpHXsc8E3JXXVWxSriLZfI=;
 b=nDfqKG3EI65FkvqiQ+AQ4jVfwdg7yJsI4JWYTtVP9ubY43+iG3VX4Xmw17kAumEGxB
 6j+2350GfcIxTDqCE+XcnrN11vkTCQyzAl7+zHC8rLPXrJ6DLgeaH7pSZOgxDwZVpoa2
 kw7Ujy9dRbZ76tbgQwtZng/bKkEl3ydfuKkno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680473; x=1703285273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtIos0rqjRx/PEuynE5IdYpHXsc8E3JXXVWxSriLZfI=;
 b=dDKuetW3W7yagXTWcQMjCtnhXvzsNk7hyJviWqp+GWsiWN7fCVtEwY4bl2+u/Xl/nA
 TGoZjjVKg7XkZroEcucIF3WVhqHFhxQhrEbBXSX2awvO/nTkGEFM0gTj8E9HavyubchN
 FdphzEaHs7+km3LQi1B0KjDL22BoZyYB2xIwJczTBEUt8SExTUdPNsYc+NU0BB1LCIZY
 89DzUiFQ4xgKAj40V6io3g+ZsNZ+3LQIaRbYTJRJTVbtvrjs21Uv34k1kRbUOZJasZ6q
 Og3i7K6p6ywvmbPGHldzSiUWWpe8LFfPeF3ah81LPp7C3oUIIf9SmjpsC1msAixiWwwo
 fTEg==
X-Gm-Message-State: AOJu0YwxzZtr+XIt762qQ4Ao9zK9HzC2BC7RcPEu6gMhcvSRyq6MCCn6
 3WhUjw1il65SCzp6H0fE1TSung==
X-Google-Smtp-Source: AGHT+IEyxHUMZ26iZgu0YYGVOiIsIstmluxiFTp221n7z0ABIfo74iUWdzSOL0ujRw3ZfRFqqQpbAg==
X-Received: by 2002:a05:6214:1d0c:b0:67f:fb4:f970 with SMTP id
 e12-20020a0562141d0c00b0067f0fb4f970mr3887624qvd.43.1702680473327; 
 Fri, 15 Dec 2023 14:47:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a0ce202000000b0067a93291d3dsm7197072qvl.78.2023.12.15.14.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:47:51 -0800 (PST)
Date: Fri, 15 Dec 2023 17:47:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm: mach-k3: Move K3 common schema.yaml out of board
 directory
Message-ID: <20231215224749.GC2513409@bill-the-cat>
References: <20231122213005.680781-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xuksf1E0buEzIM5/"
Content-Disposition: inline
In-Reply-To: <20231122213005.680781-1-afd@ti.com>
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


--Xuksf1E0buEzIM5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:30:05PM -0600, Andrew Davis wrote:

> This file is common for all K3, move it out of board/ directory and
> into mach-k3. As we need to change the path in k3-binman.dtsi let's
> take this opportunity to switch to absolute paths which makes adding
> non-TI boards (like Toradex Verdin) not need to override these paths.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Xuksf1E0buEzIM5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8148ACgkQFHw5/5Y0
tywyHgv/YWW+O3z3TDCzu5XcR6stEKx+iqOSGWhLjkshvW37Hox/Awxj99Mp9WP2
4D0RYAqTiZAy5+jKA4s0//z2cLdqHn8ANPCeAl/iP4PkYpNRqODe/Xhsn2zgWXBi
NKHC6CDiOx+zfyAYMUfbocJFq0MVlKGh49h/aOOWngDMPzPxCvqGuAmLS7EB0+gL
Bsibg/nPfMDN12ln8CeUhUSYCyiJ/4VgtBdwEWshqeokL30YIeW6JJtLUFYO6Xyt
pMw2faPaSJfpg3o15f8m7mlFZv7pDFhKQexZu5Pu3zqcHPuDoo5nFeAml9h7mhb3
vQKumrmMyIf1h/LhM+fpRfUsHhTm0gw/jk0de+1A8EpZuMqDHGy9ILu8I0MkX2ZC
Ib1MMky8o0Jm8DUOLxBPSkNgN1GQYH/+HO9sf6eHNaV/FVmIOiaxIZtJ1DRhtTxu
Uw6gEdC0VuuRKn8K6ocvoZ5wBU2FCvBs3MeEUZU0/saUd7NlaIGSO57RTU74HyUu
3H8SVSAY
=t/Pc
-----END PGP SIGNATURE-----

--Xuksf1E0buEzIM5/--
