Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E8AC79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 14:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCEA8399B;
	Mon,  5 Jan 2026 15:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="is0eZ/LI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D372C83A9F; Mon,  5 Jan 2026 15:20:38 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0780838A5
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 15:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45330fe6e1bso8336368b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767622835; x=1768227635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xXkDIiXtBnxXk4yb3VdnfxEk5gRcs10++Ejmm7/QksU=;
 b=is0eZ/LIcmUu/9FZ+6YG5gniaUTYvczxkbcHmcjP0MS4OAVKlUUPIjRurHgu/QXinV
 8p7dYXpp611ZIFbtlno29SF3k91l9eprtdMACi3xJuZ5mGxrE3e8fvUE7DF8CmlOUiOR
 ogPqYHNvFLQzfEBCuLGdWe/B0D6OM3SEDYbLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767622835; x=1768227635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXkDIiXtBnxXk4yb3VdnfxEk5gRcs10++Ejmm7/QksU=;
 b=fo/9E/QTJgatU2e2ySc83rbT0PVpNSVBx89iqe+5kQZrv+blKtrDMwijPItlTjbyhd
 y6c0691/iL8/VY0rzFbkgEgzJnQq1O0nKi7LyTZ6hQg9oTXxwSj9LTMXyW8qzSU/y3Hw
 gtIHlpAMNXc+5SDKAsZCZetF6551QCCbrCujLmEy3xP9FOM8LzONQXaetaTQxwL/eDns
 n5VBLbL5FKTjAS1vhG3TxdBh/ftanUbG1Whcg6LdMluqa7JBUdKdYCNw/CMwYLVQknnz
 c1qJzVOfVpAXhjq+IlwM6bRXhwjbRlyi/CUN5twTEfMquyRb3evS9XvEjSiSxwumlJzm
 xr8w==
X-Gm-Message-State: AOJu0YxHKnN52MfQIAR2eBKOVhqQztBmtRN38UIggBBiCpIGqHzKkmKO
 EfnquITBPf0pOlEqnCgH7epOesAo/miG/3oia8b+h6SwbyEyihHPFB11jw7fmlmZXSg=
X-Gm-Gg: AY/fxX5XchH7Qv+EqhcTCJigiS6Pi8h7no8cCwjDat7TkOSaJyWOznLJXfAw6foZTmk
 2TbsKJ6++Cf1GcnMbLTTGcQPfPjcp68npISKZitiv6gj8FKDpT5FzTncnCWAvmInL5cLz3kh64r
 OZcbJYZQ+YxEF07onUG27VEKGVXcGAjarAb1v2WcFpXJfJubmBe7A0/JL7Wcj8R46PoNYRBo4tp
 iNppHM4aTx0LdHXMY9QpuVZWtGLkq/GMy2n5w4jvTRxSBie+/1TO9MpypHnwmP+Ctq5wMNHb6+Y
 aPhipbbICSmP8WkHXFfGC5cweRfMnAPy9AsrhT+WUg/cVjRG+t8/hIyLtoD1klRbPMD9Z64N9JP
 yyE4lNS2P2NParLCIax68vyjloUmAcF/G1LsKbtaDjFLebch0736oVuXmnuNDabtSpaFHLr8ARa
 cxtRwbsyJ11+JYj7r/oBBpJBDecU63v4lfREs53nfhLwU3nKS/KE9TOfuD3pbeR2bDaKLxlcBNN
 /YQwXv/aUG0Ds2m2vWfJwqew36D0lvy7n4bJko=
X-Google-Smtp-Source: AGHT+IGnFkC0gkKkhhXHr0doybgsf2RFEpvBB88BjaofDWo03HI/2YQzj7lKs5AirbBYpTWS9lPTVw==
X-Received: by 2002:a05:6808:4f5f:b0:450:c9f4:ca18 with SMTP id
 5614622812f47-457b1fc8d64mr22552330b6e.41.1767622835350; 
 Mon, 05 Jan 2026 06:20:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3f1db46sm21325062b6e.21.2026.01.05.06.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 06:20:34 -0800 (PST)
Date: Mon, 5 Jan 2026 08:20:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] lib: crypt: remove dependency on autoboot
Message-ID: <20260105142033.GK6124@bill-the-cat>
References: <4fK.Z}kd.3rlt0vRvdGr.1fMdBZ@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GgKXKCII4GBlxUDh"
Content-Disposition: inline
In-Reply-To: <4fK.Z}kd.3rlt0vRvdGr.1fMdBZ@seznam.cz>
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


--GgKXKCII4GBlxUDh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 04, 2026 at 03:02:11PM +0100, Tomas Paukrt wrote:

> Make crypt_compare() accessible from board-specific code
> by removing its dependency on the autoboot feature.
>=20
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GgKXKCII4GBlxUDh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVvIsAAKCRAr4qD1Cr/k
CgXxAQCrr6dyx2UmPr4NL+yItqB1ORs9Zx6awSk6WFmYmMud2gEA7RL226fFRRlP
AgAfmtMrgumc3ILa7n+Gcj710d9SUg0=
=8aSb
-----END PGP SIGNATURE-----

--GgKXKCII4GBlxUDh--
