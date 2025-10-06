Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF6BCAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5F483DC7;
	Mon,  6 Oct 2025 17:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qzeWTg7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71A183DCA; Mon,  6 Oct 2025 17:47:45 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1593B83D18
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-428551be643so41262885ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759765662; x=1760370462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EPiTarA5CdGyvOL/JS3/3gdO7Of4c0VB1xIymhnz9mk=;
 b=qzeWTg7olmk6MQzGdEUhyDE2n89R6+hUyKBBEJkCDsNk9obq+DbbFM6mLqHuxMU2Lo
 azf+HTsbHPzp6vp1UuJYxYLau/Z0a7Zn1XVWP2Tz+6/wPS0EYhEzYWodIZBYRxOYIz7q
 SJN60wTwTHFuhjPegY1GA1AQ32j/SxOrYdz4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759765662; x=1760370462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPiTarA5CdGyvOL/JS3/3gdO7Of4c0VB1xIymhnz9mk=;
 b=nQYJQ1utbZKgLBLN8Iy1h/SiarbxkoigFC8/tO8BZSsne3zRckzNYo3ARhehzygKM/
 BUj2GhIbJFcKS6lCXe7mN4tjs7mhponaunIiacDPEBHvHzhVGjcxpKFrb/JLLXMVcyAP
 NjGRGO8DNAdb82WXszvSP3xKSlETsYQeUB11hyA+eRrdQ85etG8XTETNIxmfLedCy+ce
 GwMxh15dvIipqjFJb5UUVvTTSdmMZk9Gp+Ph1mRlQwjqILZTfJ6MKT9RydV3cCaAv7IR
 UaObJvoIE0h/qbxK/7ctya9xPSC/Va7DJStKJOjkLYl3wWiuHkT9o60R2OM2gMgmQi9L
 a4Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfz3E2xXP6YKsoaBtXCs3JTXdv2ocqpk15+tGN3sZhzdLUSAzYdbXv060sGVq4CdnUbkR26RQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzV5I5yLd6I0IdzuP1MTJkkpJrvZEfg7ifDfMGr0Z7n/bHVnVWy
 5rXO6Rq5l8kWB3E8pB7qI/P+y2lMnKBcMInO2oGXymZee/goJ81TsGtkaUldaOTp4x4=
X-Gm-Gg: ASbGncvxbuGzqH3zCEYP3TEYriUVtZJmRnmZCIsrTXDShpYhUymT5xZbY/+CXOFKjjp
 9uWgm/D6FKZAIKKDauaeiSzerH+5Us0p4d71lTiau0btvxj0qQ1MKk05O5iP3q6yUBvNqu7rzjm
 0AIuCuIs3O/PTuzeABYLBEZrf3kbkwp7cqWqBSPtr7DVeD+bbP1UILIYNOX8MEduRkQfa1eY0Oj
 sEMUe2g3Emeygo/jC2pTbHPuqOFpfmJH3150r9Vll9XheT8hsfWOXjqQEcqY18l3ntfbWe0tUdp
 +VRbjrHi0LxB8x2tcbI84XE3GpbLdW6Ghtb/btZ8uVJaVf4GpssQWfoET1gT6zyr4pZqaeHnZCo
 QVOMZadVv0RZZfySbrMoJbvM6lq2oZQR69+uFh+cJdG8gpnS+576CmD22zcobWACCSijLZfH18K
 u8VfwK0oy9yNozMAiEvFSL
X-Google-Smtp-Source: AGHT+IG2e95cR/nBzAI7URNVHHHQV1VIV3ddUAEZB2JHOazSAZyee0CQPcUx6tNyfbys9HDmKhp0Mw==
X-Received: by 2002:a05:6e02:b28:b0:423:f9d1:e913 with SMTP id
 e9e14a558f8ab-42e7ad9abedmr178032815ab.31.1759765661641; 
 Mon, 06 Oct 2025 08:47:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ebc8433sm5046869173.41.2025.10.06.08.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:47:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:47:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Wadim Egorov <w.egorov@phytec.de>, Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/7] doc: make pdfdocs: Ensure SVG files are converted
 to PDF before the compilation of *.tex files
Message-ID: <20251006154737.GD6303@bill-the-cat>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-5-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UEm83z3Zw8A93F8Q"
Content-Disposition: inline
In-Reply-To: <20251005221057.255029-5-adrianocarvalho.pt@gmail.com>
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


--UEm83z3Zw8A93F8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2025 at 11:10:11PM +0100, Adriano Carvalho wrote:

> SVG files are not handled directly in the *.tex files. This commit
> replaces all instances of ".. image::" with ".. kernel-figure::". With
> this, the kfigure sphinx extension (already present) ensures that SVG
> files are converted to PDF before the compilation of *.tex files.
>=20
> If I don't do this, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> [...]
> xelatex  'android.tex'
> [...]
> Output written on android.pdf (28 pages).
> [...]
> xelatex  'api.tex'
> [...]
> Output written on api.pdf (431 pages).
> [...]
> xelatex  'arch.tex'
> [...]
> Output written on arch.pdf (62 pages).
> [...]
> xelatex  'board.tex'
> [...]
>=20
> [152]
> Chapter 14.
>=20
> ! LaTeX Error: Cannot determine size of graphic in boot_diagram_am62.svg =
(no Bo
> undingBox).
>=20
> See the LaTeX manual or LaTeX Companion for explanation.
> Type  H <return>  for immediate help.
>  ...
>=20
> l.11422 ...ncludegraphics{{boot_diagram_am62}.svg}
>=20
> ?
> ! Emergency stop.
>  ...
>=20
> [...]
>=20
> Output written on board.pdf (156 pages).
> Transcript written on board.log.
> make[2]: *** [Makefile:29: board.pdf] Error 1
> make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
> make: *** [Makefile:2687: pdfdocs] Error 2
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UEm83z3Zw8A93F8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOPkmQAKCRAr4qD1Cr/k
CoYTAP9fQkGJbveZ2tJb2nTmKFalPXAz0QESr+Zlsn0eI62JFgD/Si9XwJpeKAFO
RulJW8kGBzU7JjcHDFPcnhluYn7v9Q8=
=IGXP
-----END PGP SIGNATURE-----

--UEm83z3Zw8A93F8Q--
