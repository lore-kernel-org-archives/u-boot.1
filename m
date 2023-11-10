Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 16:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C47987844;
	Fri, 10 Nov 2023 17:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tt3dY25z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366D18782E; Fri, 10 Nov 2023 17:22:04 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A873387863
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 17:21:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-77891f362cfso184925385a.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699633312; x=1700238112; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WlSwetoXLyWD7Y26B55Ky8S+RD6SMTzQT+LOSLZl9Yo=;
 b=tt3dY25z9fTR2F20w6clvyE2jPKwCuC6IIXedCtOXWYuNyu9g1X2C11YioCPsJrpoc
 v79uvVJr3c4rBGut0fXCPIyLjA6iD9c+wcBewx+SE7BtzmQGnbF3f73g8Y1H++iMpc3t
 3v1PITWdd2xC5VGuQhmzp8DhD/nPgMsth5dTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699633312; x=1700238112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlSwetoXLyWD7Y26B55Ky8S+RD6SMTzQT+LOSLZl9Yo=;
 b=BUxYuhVQqJxWfwbzLMN3H4nXczcdq4jyTXlpVcQ22NYPpYytJhnB1pp0rJb3j/2KIv
 Je+TBPrBl92U3NCYUaifWnM0Dyt6AtRYFxHmAadbKknffaijS/d0AKA2EqgbmauaNOQJ
 O/cUzNozOQUkv8Lgh1c/b/2do2b9sRT/aTiXC5zjVODT3wnQgFcGQhy5ZwSLasE/PzD/
 GYt/88jhj4HTvXAPndTPwRNJtt3XO4gsSLiR8QIs9SZKOHzW6RuigDAiwW9dCY1eL0hG
 T0xGoBX4LD+ZdRpKquZ041iTRFhC6V7uzCIYnvsjF2AUyZZHLK+BVT8D2Ta6PE3g1dxC
 gB2Q==
X-Gm-Message-State: AOJu0Yy7SAWv+Y+YySnagl3fyXhv5ZOR6ITnh5ihTomRmkHjeFRVjj/O
 RaFQE7p/9GvB5WzNC6+abmrTyA==
X-Google-Smtp-Source: AGHT+IF+oYkYpXgXGec0A2Tb/U72Bm/Z3bNGrQEhtKGWn/w3V799LSqmucQ83V6LgSuWIWrwdEDZZw==
X-Received: by 2002:a05:620a:1725:b0:773:fa62:39fe with SMTP id
 az37-20020a05620a172500b00773fa6239femr4079454qkb.1.1699633311735; 
 Fri, 10 Nov 2023 08:21:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-046c-8850-3cc9-4453.res6.spectrum.com.
 [2603:6081:7b00:6400:46c:8850:3cc9:4453])
 by smtp.gmail.com with ESMTPSA id
 p15-20020ae9f30f000000b007756d233fbdsm790100qkg.37.2023.11.10.08.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:21:51 -0800 (PST)
Date: Fri, 10 Nov 2023 11:21:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] tree-wide: Replace http:// link with https:// link for
 ti.com
Message-ID: <20231110162149.GA6601@bill-the-cat>
References: <20231101205603.1786870-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ixaK5I0W+oBgXxxP"
Content-Disposition: inline
In-Reply-To: <20231101205603.1786870-1-nm@ti.com>
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


--ixaK5I0W+oBgXxxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 03:56:03PM -0500, Nishanth Menon wrote:

> Replace instances of http://www.ti.com with https://www.ti.com
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ixaK5I0W+oBgXxxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVOWJ0ACgkQFHw5/5Y0
tyweRwv+NctdPsYvQgSDE3GtG/uXZzxH7u1eX9b2aAFu96jWsWzL9Ls1fPkHM+Y0
UMZQhq486TgcoYLVDN9jlzHN1cQGKpDpFgGLcQPyBLdFYqTD7gzfn26m3hFj+lzr
Va4CXovgZ22vjDXyUst92viqHMgZDSXrThAzYLSTTgY8KQ2TB74EKMdmC7Ozk/RJ
ZAjB6JSpuHM5MBlDj7dgV8N8m5pgaVntBitUPlfqqJYSoxIWxKO3X80aFQf9dQ0G
8aDRit8/CE4HFCw7BQiNLgGm8YRnxsHZZLr+OZ2p2D84Gavo1GgDqmcRHjKhBgW2
Dv7i9PDTnConuYH6uDWPimGDxNFxzeNunHb+CX7dpvJY8OlRjkb8QJX0MwgVeSbW
uHQDlsCrHy8GoCTwDT5hiGMGY+tAh5HwOAR8cdvzOn6l3zSCF/QJBqOJV1M6zHJ5
udzVxP+gTdq8q+NvDYnQSCHMTov0eCiGwsDavlsqQaouweyxuuu/Zu/4S8kVosI/
rstik2Z2
=2IFS
-----END PGP SIGNATURE-----

--ixaK5I0W+oBgXxxP--
