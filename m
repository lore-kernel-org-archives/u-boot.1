Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B85C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2338841E;
	Mon, 24 Jun 2024 17:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TV8nsnDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BF2883E7; Mon, 24 Jun 2024 17:49:21 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4BA883DA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5bad217c51aso2399324eaf.1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719244158; x=1719848958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=20L15XuX0oFs4Q1IZ+WkboDgcebgjFTNCJnsC+VPEhg=;
 b=TV8nsnDtCE+ZumY8FKuJ2lqjYNTjXn0Wt4sxtcebuqgrmHqtY9aO3ESK5OrWJUXO9f
 c6IQGDl0a2t5jhawyEZhm5GIV7eVCseXl5ERsnKQEYHXGx2tUPuw8lt/gHf5CzWoaxtd
 P+/hUGRTcWY+F0PPQKZeAucl5PqVFdosvIVHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719244158; x=1719848958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20L15XuX0oFs4Q1IZ+WkboDgcebgjFTNCJnsC+VPEhg=;
 b=fpUcnJQvLlbcvpsSNzvIt457ZXfdRMzmd+/tNNwSWQzBWGg8/19mNZrl1czNDTpF2e
 ll2SmAAFsSi+ypDUIA7POSyc68mP5IGIiWjij/Zy+G2aoPLNeV7zW5t4vPWLaOUFVkjn
 qX8ngPEQo456Cpw+BXk9HfAtEkGqefhYMNZEzvdemyEQJ4uIbB/nTEowcggxMyUJ5N19
 vZDo0clnZWXK+maA3OlsBtyPgC5T9s7rUY+CFRhvXljCNxbD1MEZzpQqE+dsld3cV/0r
 tqWOtkiqpKxYT6490s/1HnqZEHtCwAhR3U+D2z6h0Mt1JyJ1zDlwH71TjP2r6whE39jb
 B/Hg==
X-Gm-Message-State: AOJu0YyMyBHhJyEd452kxsHNIh6LWCXPM9gbmOMvfaM6XVv/jZ7fWGce
 eBCVIXhCDIImWXF9dPDq901F6eLQtIxXK/RO6MT372kTtJPtMRHqzMQK+ioBUrU=
X-Google-Smtp-Source: AGHT+IFO94fXt3tXJO0jBAqnKii9oG1MDIsWpE1kZRfYKB0jzvPpxMAfohClNB5I0nlMB436RopZgg==
X-Received: by 2002:a4a:9281:0:b0:5bd:c2b0:f599 with SMTP id
 006d021491bc7-5c1eee06be6mr4772633eaf.9.1719244158400; 
 Mon, 24 Jun 2024 08:49:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d54c2d4fsm1381950eaf.6.2024.06.24.08.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 08:49:18 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:49:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 6/6] CI: Run code-coverage test for Binman
Message-ID: <20240624154916.GD38804@bill-the-cat>
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="miDg7Ww9OSDK/meQ"
Content-Disposition: inline
In-Reply-To: <20240623175622.1468600-7-sjg@chromium.org>
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


--miDg7Ww9OSDK/meQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:56:22AM -0600, Simon Glass wrote:

> Binman includes a good set of tests covering all of its functionality.
> This includes a code-coverage test.
>=20
> However to date the code-coverage test has not been checked
> automatically by CI, relying on people to run 'binman test -T'
> themselves.
>=20
> Plug the gap to avoid bugs creeping in future.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--miDg7Ww9OSDK/meQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5lXsACgkQFHw5/5Y0
tyxzRgwAtoT4ZrA9tjvWsv9utPluU4TuwiDW+XC/eCFCepIVPUgr7hjKayIS3+uV
ZbjTb4PDbCtRf+EujN8MDQBA43Ymvcuz1CjDxn0+ycBahNi/7opwl9awQODQnTAI
oLPULEq7tzCBlAawqnw7dfNQwrf/vYiRnLmwtVLkMETyjR91tDay2n5cuxe3fzwl
zZsHdHu1Geag4GtWTWNelp/wGrFe+DbVjxW3+j6Qrw+KFP7Uo/rOw75ZIsxD4J6k
9nrAaXrPV6Ii/xbUmomLkNIxOPXEZqs/43Bz7ItwfR5EIZSB/9JLItM8WK5k1z/6
qWseWD1iSI/GLFNjke/Esj0C1xgXXAdbUm/KiLhz4xzsWbyMJAeQjjWxt5tADlrW
dQEfybDP7XCRlqIHYeyWKLiY3c2exH2fbLpoMau5alhuxC9qNwiJTvAJ1Zh+7oZ4
y7iCAUQqUrE5ayid+jqlUzRGBu3TnTj4I/yg6+5NX8HAJCn0ARy5f1MftdkhCqAv
GB8BoyCH
=jVgY
-----END PGP SIGNATURE-----

--miDg7Ww9OSDK/meQ--
