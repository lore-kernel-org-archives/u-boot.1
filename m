Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705A4C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 14:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88A182B97;
	Fri, 30 May 2025 16:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pwj6u/ps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB38682BAA; Fri, 30 May 2025 16:06:56 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C5682B70
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 16:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-401f6513cb2so1747081b6e.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748614013; x=1749218813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5tzObDKQZMDzUItWtEc+PUMVLxm8hRPoKtuTiwbxWbc=;
 b=pwj6u/psJ/+9YIqwP83Ef66o4s2TH6zRhth/SUnCJU2O6JxaK17EI4722/zkMY5gv/
 mVE6LuWW/DTLCm3Pq4xEsHpjJeNygP+57sK+qz9bC3JWn8m9T4ICjp+haHBVdE0R260E
 36iVRkhb6Z8rpweT28/dhx6YbFKjLSsfG5tXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748614013; x=1749218813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tzObDKQZMDzUItWtEc+PUMVLxm8hRPoKtuTiwbxWbc=;
 b=ppLwJBvwYuTF3tW2xNteuVm1hKCxQSmR6nITispeGfADgh5Ol82T0o1P6ESc6lCZ1M
 1wVUJ50rrKOnJHpXTqUFM1zzhCMqLR3/3kZvPn/+bYni8rKQvvs9h+90dj+CnyCn97X8
 L6lJZBIUPxueFepbtkDiiL6cexjw7xxyL+bcLNNdhUvGd4Q2BQuFMhuNak5xgfQGZwXE
 cni4g+RJ/ATrS5Z1sKgPNa8DCHr8sx1PI7FKuwtFv5n0nY2+f3ROzgnIO2/w3n9JqvV/
 ejAhBSHT5c55gfzrYfSkBhaV+5OgVBn4q2r751BSy8LcM0EZKyBxSUJe8XOd8qt4RsKK
 QA4g==
X-Gm-Message-State: AOJu0YxqQAXM5QdUxu9c4euQpKcRzImDRZzRrUEDnYrXwF2YPj/KtV1X
 GWupxGIjJiM0mTtuFLJH36Kph2laHV96RkjsoLRZ+Q9x3fOeV75sojBNhjvTczg47Ag=
X-Gm-Gg: ASbGncuKSt76dzkirSawQwawPKwhjCwadULvJHVqiIy8Cov0wqyUe3wpbI9WkkLJsMP
 dhQ30dRx1CyIqh/mJYIL0uGfIaulX7F1AzDWSVhV051digkvP1V8eDJI/D70kIgIEanSXAtBbMx
 vZvmi9WhVM7mnEyKECaA309ZYM9bZA+UIiQIkob4rltQ4hy/mjucF0PiY0DSsJjWcpGxk8lR6Cy
 7Mpl2+Rj4YgFcMG/mSvc3/zpJ+ruoNB/LyV3gsZ+5Yy4c/t87OEglnVeWctpFzI8XSWgBtwah1s
 D3LvKpRxRGO1pltDSuq3SedUp5j82PUQHm04YTt7WqaotOvPxnhH8gI4MhWZHOZ4sgrVUuQdJ12
 RY2p7eR3VJEgc
X-Google-Smtp-Source: AGHT+IH05f+EryqrXbiNRhHEBu9dLAR53ZwZusXkltwRqDl5iwTQZBC/FXoBiWZ3qtoflomvbnyBmw==
X-Received: by 2002:a05:6808:2f11:b0:400:e771:ab80 with SMTP id
 5614622812f47-40679c0c283mr1882321b6e.0.1748614013282; 
 Fri, 30 May 2025 07:06:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce83e1sm398978b6e.33.2025.05.30.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:06:52 -0700 (PDT)
Date: Fri, 30 May 2025 08:06:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Azure runners
Message-ID: <20250530140650.GT100073@bill-the-cat>
References: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9FDg30ZAgFD/18g3"
Content-Disposition: inline
In-Reply-To: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
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


--9FDg30ZAgFD/18g3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 02:31:13PM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> I have always found the azure pipeline to be slow, but I found that it
> actually does support having your own runners / agents. I set up 8 of
> them on ruru:

I had not seen that before, can you please send a link to the
documentation you're working from? Thanks.

--=20
Tom

--9FDg30ZAgFD/18g3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg5u3oACgkQFHw5/5Y0
tyyOvQv/SgRax5bWmtui1jnho4B8wvBE0+bV0vayihsLUWtgiiYVH2CppEOVYqLv
thcxtgp8+5So06wszR0JueBmYnN7x7CPFwezLNOiCbAfX+0mYtGEQpAtct2U9c48
7twEKl9trtZAxw4lri+q4MQBIUI4u1pfr4Zf3OAY4BCFDC15/6UwnZF/5gA1D7Qg
wQepFad1lo9voIi87oHCg4vgSmVOnef/WbuiF6qdDn9B3gl9nWiJQX25EihRXDwi
4Mn/9wZpespB/DF3yTm1lKYj6mKo75LNe4qAk9MvDilFEZSVDxLovtwycYUU1XzK
oBBg7roW+ns84YFN//gl2GjjqPfEsVLz+YRoiQbhJRgp90cyk5DWg8Kmkz8F9PR8
suuEADdRShFbxyfSIHXT8JXB4z+te8atlfraI4EFrNQftZ0Ac51qfAtOMLpNngAQ
a117/GjfQmux11aUdVsnISOS5/nC8abafWRtqixcehVkOf4psE3AJ7twOhw9dnzv
lc/lEeB+
=c3Ze
-----END PGP SIGNATURE-----

--9FDg30ZAgFD/18g3--
