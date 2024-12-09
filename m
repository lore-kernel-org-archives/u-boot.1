Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A7E77181
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E07896D8;
	Mon,  9 Dec 2024 20:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="he1jaCFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BEAD89723; Mon,  9 Dec 2024 20:01:33 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDED895E9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46772a0f85bso4284961cf.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770889; x=1734375689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yfqf2BSllBarPTbSE7GkGCec/Q/SzJMQd06kTTTrpYE=;
 b=he1jaCFDtoZjYajhgkMJMWSNyNrXxSeIiWpJDCrk4nkywlmHcOHbac87nFfoGL4J6R
 4oatHdCHQPNKm8+cuCknZxJFNF2eLnTdFdDxgDHdur9uV9QbR3IYFoQ8XYyv2W7KfZHG
 7eHDJ02BPBJX15FXgKFBpALRKExAKlBz2Ujwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770889; x=1734375689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfqf2BSllBarPTbSE7GkGCec/Q/SzJMQd06kTTTrpYE=;
 b=JZ16L1fPeAiOuu66FZLHizeaAKw0LhDlkbCCAZjv7axf/XzdQvzQOWrop775SbkR5P
 +ggiUYpTxmSXBrICRvXnxRQJLatzgNmb1LdcfQJXsc9geHHiFwrubwIbEmlQ1HdeRNkO
 5/j4q0hQyuoOortAe8FkX87TRX+NhJEpTOwXV4VbPdpjBkJojku6Ivc9XTvQt2p/eVIr
 wz2Ha04mRm80ySGkJ9qKCtvF0kUtIeGh1EUNnhDGJKuf2mJGoxvORO6hLcyco6VqnDKG
 ECeA3lunwrTPTJfihH4SgKGfn8eXNf25zeo2vX+WzK4qPL94YCqrfKUfRZKEN4qhWdoG
 06tQ==
X-Gm-Message-State: AOJu0Yz1eZQP48EPY17Dwu/aDNucGRjvSWrn1AlzAWGVDS4KPJ1Esyyd
 saHAxD+nLhL1AwDSDxiad1Ecvehw0wFDJmoX9Zh8dLijpoVLY989nq2nVy6AU1w=
X-Gm-Gg: ASbGnctf8mq9Dvdse5m7DyLVTUu56UkCT7p4O06qhKnE40WMW7YXuXz4+eFU0XsiMnB
 h74Q0e2QKLVjLYSiVq8Pj9aoCUoLYqeTvnWnBKBFyTIgxGUV8AnwT1zXm8OTrcvttVUTn2Vr+Ab
 3zFKzXLdpJBtwT+yhspNuvFqXt62GUE9O08t8njDZCw24ozkQRQ8utktc0YlDLRW8nA8+/jk76c
 T0BqXvdk26jAbulAGIbDAotR9+6oaTwddDMT5bixdKKaJaZxlI=
X-Google-Smtp-Source: AGHT+IGYnbLDbRUJ8GSIGjtliwzvFozCfCetLfHfR1B0XWoW5tEQGh779AH0H/8QKjgULuHvgjekHQ==
X-Received: by 2002:a05:622a:189d:b0:467:5c9f:f8ef with SMTP id
 d75a77b69052e-4675c9ffb7cmr103194331cf.6.1733770889489; 
 Mon, 09 Dec 2024 11:01:29 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4674ee720d2sm26951641cf.40.2024.12.09.11.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:01:28 -0800 (PST)
Date: Mon, 9 Dec 2024 13:01:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241209190125.GP2457179@bill-the-cat>
References: <20241208235334.208595-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PM7vBZkJqkP5loQi"
Content-Disposition: inline
In-Reply-To: <20241208235334.208595-1-marek.vasut+renesas@mailbox.org>
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


--PM7vBZkJqkP5loQi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 12:53:02AM +0100, Marek Vasut wrote:

> The following changes since commit 45f05f681224d88d1b170063001b59edc8fc24=
cf:
>=20
>   mbedtls: remove MBEDTLS_HAVE_TIME (2024-12-06 17:47:23 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 455e66bc598935c01621e77709866eb54a6fbd5f:
>=20
>   arm64: renesas: Disable AVB1 and AVB2 on R8A779G0 V4H White Hawk board =
(2024-12-08 23:07:34 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PM7vBZkJqkP5loQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXPoIACgkQFHw5/5Y0
tyySzAv+O7Qli6P4SEk0MOo4LLjvPVkQW+TLlJtK8jCwqudFLSrdXdL+ttyy2VNo
znWcppXdRPolNqjqxki7B202v4EsbWG/uPGNbRHNuLw5johrnipoQO5puzFeKy/H
U88HU6IkhyEvGiF/wfdMJ6f1n1O03oJB9uwgtRVMqTEu08ql00qxfLrGLjpe6RQc
xrVI8t9fuclJLYHI05V1+eobm9jzxgRBsTvCJ7UbzW6b5Qalt9onN1wQPuOvnxtM
YrPpEatSb1/LWI0NoOZ/6sqXIMhHwcUsw7/aStCq2k/rNg4bovay/2SrWlxUpI5j
DsL6m4bJPAPnDN2tSfPtcsi+GAomF9IUpP4hiwFC/sCcWosc4I7K6XUAuNGD+kV9
8qhkK5uCjj6AqeIWtHZ5oyhZNUACqB9AOVYC/HG7o66cmQLgkGB28qO7QImdcjwe
l6EeI0ol3CR4Mx5PkyA0fRFIWuWQYNa7m9RbCYZC/yduIWql6hmWkeDzkw6sHG/V
pNm5Jhpz
=UwwG
-----END PGP SIGNATURE-----

--PM7vBZkJqkP5loQi--
