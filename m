Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C529CE77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 14:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F978007F;
	Sat, 14 Dec 2024 15:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WS6mxLyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0741280092; Sat, 14 Dec 2024 15:23:59 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97257800CF
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 15:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46772a0f85bso24698581cf.3
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734186235; x=1734791035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FoUBUHGkL3Yg9qRTtxSFVszQ516OIVsVoTjPoVoFqE8=;
 b=WS6mxLyZEXtApkEQxMu8AG9UwdLvByVGad50olZdDcLf+tz39clfYHNh3BynoeKPRh
 l9Q3qD/b3GTZYg4eXWPLbwGFxuhquVgaS7cwbm46AdqtAyuAOUT5SZ1Bg/yebCC56uIA
 /54SvqipV8MG0S8NIGD7GqbDNB3wRHge+7OWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734186235; x=1734791035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoUBUHGkL3Yg9qRTtxSFVszQ516OIVsVoTjPoVoFqE8=;
 b=wV0qFJgCowk+86rf/pIYrHG9A7VBB9EgAT+zJIowTJmfmhHRuGIX9tJVysiKaHGHcP
 6paSm+MNPa7okYoD/+btLTMpf7oqzPuSRzgaWmHk6cUSjWjV26O6+Uy2clArJPt+JIIC
 MIu0sB3kVvujMgYL+dj0xwjVzftRmuC70rTX7EmFLIQdy9+0cbTxFwODsm0lo82B19zZ
 TjZ5t5QXrXJKWr0rigm68LPJNmaY//ziut9rd8zwhL9rQ5T1ZjFVBsQ1mqkMimThrx94
 sX/2dPbtWER/g6HgFGwqftmkz5A3L8piiUIGVTWBYDuqO4B317OwZkMrb/3jDrNE8YfI
 wTUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTjPnITy3IMj5kzjeSB5jcGE+xrLB/2fg1vYyPbY+sSoTQnwSf/d7cmR2DZOlx5uSNOfkU9dA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2D6ANJju9p22s2nF+7fJA5M3iHTGTiNX21cCNeYaxydkGTW04
 viKohWX2KvlTwEMfjKN81N7/semiAjDY+e3Hoy8lNoiF8auH9q5OlTemfww+E/c=
X-Gm-Gg: ASbGncsVjpUdGKVpq4QMpyl7SSezcqrf8CteenCHOl7He7QPAQM8xjmFaf59Mp83s0Q
 lIPoStAYMdJAbQVn4oLpMIFoxc3vAYue793wJv218kQvUddN46r3g9J+UxMD4JwcqM/TIRq6ldk
 TRCiFN9rnmIQms8QlPYm/2EHhn9JU576TSGH6LtnXF/Bx0sHsMYWPFVnoPhzqCIQZWs50ExOoOS
 zqyIPWvE1whkPJOdWJOQr6qgrF0le4cyrbze1Fzs0mtAqIXa767A0zv
X-Google-Smtp-Source: AGHT+IEk4Yr/MPyz7s+GyjpFhMdwibkhjpTsAGXPlxiz+fXfRoo/K6ZidErxVY1QDL+9HEbrkjDTAQ==
X-Received: by 2002:ac8:7c48:0:b0:464:af64:a90b with SMTP id
 d75a77b69052e-467a575c57dmr116311451cf.20.1734186235518; 
 Sat, 14 Dec 2024 06:23:55 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047d08a0sm72752385a.33.2024.12.14.06.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 06:23:54 -0800 (PST)
Date: Sat, 14 Dec 2024 08:23:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 emanuele.ghidoli@toradex.com
Subject: Re: [PATCH v3] toradex: tdx-cfg-block: rework modules pid4 handling
Message-ID: <20241214142351.GZ1505244@bill-the-cat>
References: <20241125174911.70723-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nURySScgGz5mgdML"
Content-Disposition: inline
In-Reply-To: <20241125174911.70723-1-ivitro@gmail.com>
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


--nURySScgGz5mgdML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 05:49:10PM +0000, Vitor Soares wrote:

> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> The module pid4 currently corresponds to the index of the toradex_module
> array. If a new pid4 is introduced that does not follow the sequence of
> the previous entries, it will create a gap in the array.
>=20
> To address this, embed pid4 within the toradex_som structure and
> implement a function to retrieve the index corresponding to pid4.
>=20
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/next, thanks!

--=20
Tom

--nURySScgGz5mgdML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmddlPQACgkQFHw5/5Y0
tyyc7wwAo7JOuEIu3tfNIiNldqC0IEjoPHepL4tzt7WKeGGKpCMGHAU6zlcCLOJ2
fF4maRI3RVHmpRMR4c5+k61A3/REzeDcSyf1rHSEALlxsGXb0cxReKWP/5uA6TdS
xUr7L45ExCPQnpAKLXIu/E9DMCSu3xJtDI5i40e5QQaVbpxhT5XU19WOrZipInFw
z1vit58UV2X37j4waNeAJb4zyImllzEOjuSlUO8pefX9C7bRxBryskAn8xU8JmZH
B8at4P1bBEldO/fnyyYyX8ua9RVma8MDC72gxkRvqgA8vnq149P1PhqwrlkJ0Tu8
xEImg3zo7PtVLV5TEZVxyrxlsqS9l72D1EUEkq+qhkxuYYG7QXRB5KUHT1Od0etQ
27Z8wlhi2jmyEwHP7QjUdOI99GM7HEOIbTYIJHkuSA1qfqLTJ65Zj/7pTFSOymO9
2AnSkk+DE8+K42TgItApel1GvS5ssNJnOoWPZuu5Z22Y7971sOimtIk3k41+O8Kg
nV/O9ETZ
=Ecrr
-----END PGP SIGNATURE-----

--nURySScgGz5mgdML--
