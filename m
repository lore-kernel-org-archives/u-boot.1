Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344BAC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA13187D6E;
	Fri, 19 Jan 2024 17:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SV7yhusG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03E887D6E; Fri, 19 Jan 2024 17:10:08 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C749987D89
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-598bcccca79so448466eaf.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680605; x=1706285405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iqj3DaROXwpUqQvApK55LGmQQyzbJcdWS6BbvC1N3JQ=;
 b=SV7yhusGOzZs3u9zGF4PleDveJPxrlomnGoS2FBTO3YOfy0t5d6jBy4M4gVxtNUtI9
 6OOtrGCAHXV33o78lc+wfUF0LQUdpa6fVqBkvWB2XS4vi9d7T9dr+oojvFi5PgRTAGY/
 0GfcSsTwL0Na+mMjpQ/OclBQMen9wLMDNOk8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680605; x=1706285405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqj3DaROXwpUqQvApK55LGmQQyzbJcdWS6BbvC1N3JQ=;
 b=rNEeHNMLf6TaG8aBuFtLuvrIekUPyK06Xe8E5EsH8IW/NeoJi90wR8muFmIaQhBUKe
 vtPQ0SxI2FqSaEETd8O2sHPy91PaFlZGvfxL1CEEAXYXZDjv2nHmWqMQyrfxknqndPPq
 FiYq2S4bdZrUqgqDsoL1SVzCSoUefVgM5um6pg0KE8IaUNo34TlormpqfYlYP8IGGCCy
 5museYHJKjN/EfMZ0f+YJMKL1QxxRVGJ8CR9qRqH+/f6nkcgrXvpKzFJmGi8lAnhcgYq
 FL5B3AWmfNxPDg22k3wMScond/Smd8uEjwYxMw/h3bPACPEk3Juv2+LWGfjqzlahH7Gp
 ZsmA==
X-Gm-Message-State: AOJu0YxBcapP10wsdF65uBppKJZQYCCAtrb8xK+lixceDUifSEx+MlfR
 kwW2WqcByMtCtuc9ZA97VJuElWabVnsz6zjsIi4vV4OAT0ep2tuHvGW8iYfYnLg=
X-Google-Smtp-Source: AGHT+IHW5lcvrqjNTSda+mCAnuj+3ghM7R4FgWYjZAlfWeXU9wGWh9RW2Kb48hdB47MQ3WpB7v559g==
X-Received: by 2002:a05:6358:611b:b0:175:c5b4:1ce0 with SMTP id
 27-20020a056358611b00b00175c5b41ce0mr2606216rws.55.1705680605313; 
 Fri, 19 Jan 2024 08:10:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 m7-20020a817107000000b005ff8bcbe01dsm1218104ywc.16.2024.01.19.08.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:10:04 -0800 (PST)
Date: Fri, 19 Jan 2024 11:10:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>
Cc: sjg@chromium.org, mkorpershoek@baylibre.com, bmeng@tinylab.org,
 takahiro.akashi@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: license: Add CONFIG_GZIP dependency
Message-ID: <20240119161003.GJ12635@bill-the-cat>
References: <20240111125819.1787378-1-ivan.orlov@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SB7coJ5OmRnkUJGt"
Content-Disposition: inline
In-Reply-To: <20240111125819.1787378-1-ivan.orlov@codethink.co.uk>
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


--SB7coJ5OmRnkUJGt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:58:19PM +0000, Ivan Orlov wrote:

> 'License' command processing code could be successfully compiled only
> when CONFIG_GZIP option is enabled, otherwise it can't find the 'gunzip'
> function definition (it is defined in lib/gunzip.c).
>=20
> Add CONFIG_GZIP dependency to 'license' command config option in the
> corresponding Kconfig.
>=20
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>

Applied to u-boot/master, thanks!

--=20
Tom

--SB7coJ5OmRnkUJGt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqntsACgkQFHw5/5Y0
tyyS/Qv/WslPhU4fbXrWoBTbfsaYDjBHwafh4lmpzKQh3+5bNv+mE2BcM49ttHty
GRiY5+XlVuf8krer/BstcH+8CuZfNVd5eCZPFK756jmbMJcVNAcSsP5+Uk6shW/r
I030VMeHxzOz1L/uhYGx6oNQ2d1n4+iOKoHf4uuUU2/TqjTUXuPcmRvF/hYfFdBY
SMnmstiEiD76gP6YDDEJj2+Miho8D9w63HuLa7NXNz8BfieQ+8hZUcAoAVmZxXyN
LdrcSu20JChG5mbxPMYhX/w6MFocCLPkfhG/LxPK9i5bmII4UhgYT5HatULMpngL
nsuORey9/B52Vzxv4XVtg/12XwA2p40v1M1d+W/IBaepC5JI9Oi2A2AFUXFuQUyz
Olvz1mCIYxrdS3ieXx7zWDPM+M3r481E15+GzOoB0FohZYXxPyhkO7x9Bp8G7XUx
b2JCg14gxxO3vKdG4tsPeXuclXz6ljXYCkzyPOsrmPXGS4EdgW/flGjF8jwSwnbt
ZZHWCmuk
=Skvo
-----END PGP SIGNATURE-----

--SB7coJ5OmRnkUJGt--
