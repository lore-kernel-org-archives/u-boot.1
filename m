Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D5AC282D9
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 19:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4B8805C3;
	Tue,  4 Mar 2025 20:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qBMmH4sA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC20807D9; Tue,  4 Mar 2025 20:41:53 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D589C800C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 20:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fd65f1d262so27070787b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741117257; x=1741722057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=udNmQwSYkRDKZD6OZuo1aLGDNgeEypr2FQX9/OnGCyc=;
 b=qBMmH4sAXYHlS/EUguGC+LARPqnUc7KmlGx6gZX2o0R34lWhrtz0LEhK4FuqVr1loA
 XnoErzeKZK+iBpycwOMSLJ5TegVN0msd7GyFWcoX9Q8JKv1HkGFKen1E1euR9m0oeb3t
 otmhvIjSesfoT0eRhNWedPjlmRwDoO76kvLCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741117257; x=1741722057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udNmQwSYkRDKZD6OZuo1aLGDNgeEypr2FQX9/OnGCyc=;
 b=cuRyTRGO59BzfuGv4ucAbzqGicd89wZXSnQVpw5PkdKK70XAiTB9YO2FopJ3gX05u2
 H3IursWwZOFLWQdX6obZIaVwdlHZn68Rcn27W4+Zd+ytH8K68TemJLCC1n8UQo6AbQlA
 XSuZ7uSSY1tlfpR6o4FPwAJbESauHShEa14E7UlAm65iXl6DqMBp2+a1aTCjI/9VFhWY
 sqi0HAkHLow/mUVKj/as/38FZLZbOwBnTTrHo8uzIK3v44FJ9YbKtZo7nmZN2G+ebFUt
 bH41Pp/FCi4EHgV2oyJCMeGriplFsfBPXBuk2ySJD/eUpZ8+Sj1os9fthocqwRVOYXUO
 IVbQ==
X-Gm-Message-State: AOJu0Yx4KvCNDF3WlnbQayCcTYuZzxwBplH3bu74mc1p/fMxx9yhFiiT
 WDueB7dqV/jNVm/087Y6p1PBeC0eQFtzkIYH+cdovgSOMcthPPiPBEd3rcqRuKkmhZuZ6F34AOP
 x
X-Gm-Gg: ASbGncurm5jLLq0aRTT3hHg1MRNRHGRi5KpTypD9nCinR/Jnfh/9m88oRvRK6WOIGfF
 I5mnLqwZKDLPzo1hPu4jGzrk+6gEh6O+mDVj4vsrlQUfQSHK/tKPzXLWP27rb2BhxQNwN+149Vy
 a5LgR2PwQ+QtY2Cj2OSvCygLAjwjIehApN8M4p833V00hOMn9ktE1a6Zf0mrJxHMKQH3tuasR2x
 8han9CTSw1rg5r5kTO2nID0ChpXmCBoTg5zFddfYMPYBpB0mmooBK3gfCIx+14IWT6bvy+7NnBz
 56rKOmtcKNEAzevzoBDV0ACi1adLfDThBkHCrvVJTdQ=
X-Google-Smtp-Source: AGHT+IEWW3VfpAb2r1n3jrvsWSoYhW3vqiyce7BERn/jcW5J4uYTlJC0uuliEUWDP9JB+9lhgIVa5w==
X-Received: by 2002:a05:690c:a9a:b0:6f7:50b7:8fe0 with SMTP id
 00721157ae682-6fda2fc4d38mr8180007b3.1.1741117257587; 
 Tue, 04 Mar 2025 11:40:57 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb7e28csm26011357b3.73.2025.03.04.11.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 11:40:56 -0800 (PST)
Date: Tue, 4 Mar 2025 13:40:54 -0600
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH] net: dhcp6: Send DHCPv6 using multicast MAC
Message-ID: <20250304194054.GA2780193@bill-the-cat>
References: <20250127220613.11518-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="POswFaBOSIjVNHkI"
Content-Disposition: inline
In-Reply-To: <20250127220613.11518-1-seanedmond@linux.microsoft.com>
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


--POswFaBOSIjVNHkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 02:06:13PM -0800, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> In IPv6, the broadcast MAC address is not used.  Instead, it should use
> the multicast address (see RFC RFC2464).
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  net/dhcpv6.c | 12 ++++++------
>  net/dhcpv6.h |  8 +++++++-
>  2 files changed, 13 insertions(+), 7 deletions(-)

This fails to build on sandbox for example currently, please rebase.
Thanks!

--=20
Tom

--POswFaBOSIjVNHkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHV0MACgkQFHw5/5Y0
tyxM7Av9Ha3U93j4UWcYSE9Rl1Qtf0ghxili/+qKJp8XfCz8g2oqkhGMa4ZP0kNp
DZTu7LM0MAD43GIo2+XWDuyiLjz0V20xIYnOfF/r+B/6IdyP213E5EGeP7cqg7Zy
LZe1tyYMnYd48kYPjs8XSjXtZvr1wqnaTADPNBOIor0AWB4OTWi3hJ0ZD+1wRx/e
6M6BVpzn5gxvLjfsIOEafZMnCkpF/ZbhvhE3GTbAc4SObTwmJYmQIzr06kd4kDWP
BKm40RjtbjwvkgrujEM8eJAcI5WcAkrEMyVoLy3JJFdkKaZ71iuLZCbbyF1H0Exw
rwxHBKA3uulkECd6qhlPPjx7u3aO2BnQ55uhaAJ3AsTMC7y9NxnO8OgGLPPKlmGR
HTidWpyr339c4viS8pD7M2GcaL7BeoDseE2DyD1CIEfkzn+XZLh/F9SGP9nFNyrv
C5NW5hoyRQ3IhOuP4CCRpoZS88Y9dc4BTVTuEKk5jy2M8wCuVxOZzxvF+e7A3oYh
K7XZXIFG
=vkG1
-----END PGP SIGNATURE-----

--POswFaBOSIjVNHkI--
