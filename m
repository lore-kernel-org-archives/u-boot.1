Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD1CC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2562187D05;
	Fri, 19 Jan 2024 17:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KaTNAE73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB55B87D05; Fri, 19 Jan 2024 17:08:32 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E2887D03
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5e54d40cca2so7454147b3.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680509; x=1706285309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xc+255M1lLZXP+C5bbdQObvkiZLBJew64LnyoFaoJ5g=;
 b=KaTNAE73MRacCkBPu9JtrKnwidxSdSS2yHKQ8RHYXy7AgKoMb7am5XNIw4ae3xIn5g
 ROjDqdG9TsDFF4SkRzNgZBySsAe1TL3n8LR8gPGR5SjtDpyIB5n+XWSdUsICr/SSg4EU
 uCOzZAdl1WUl7oZU3syNiBed/rLWCcKT8swHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680509; x=1706285309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc+255M1lLZXP+C5bbdQObvkiZLBJew64LnyoFaoJ5g=;
 b=PNWAhW1IStJXWxNCF+Co8XKOJpQfjM4U6011t6VoNp5MJN+gYma+64p/5+xv5JIxzX
 1QPJfeR1W+cVPOeqafsvppr3dYQxp3CsiNDK08wuaV7+nzC/WgJ2pXlZtoTIB9aGxHZa
 I5lkybgSWXA2qJSxRVlP8QrrF9cdX7Vmz6Wen/GajqqIvakg7u8YVMubFqrRtOFuZLuH
 FtVJ1UkClQR0ARwtiEnjxQhfwApODkU4nVV29gwvcBuuXsiZ7oqInfJaw3q/fR8BwlJK
 wW5wHUjSaMPog2TRrnK+RqOZ9iOPE9DV6Pz9vaE+by5U0513yW0NKI9fgeskW/iNmSDS
 2LKA==
X-Gm-Message-State: AOJu0YxMz/iDs6ri6VIIA1D1kJqtfHQi2nrSskixQhIouvQl8ISvnGfq
 Achuw6lPkoPxsMoRhy+7EbCedFr87UEz2CfRdnzOss2RLC+tu4xN21Tk/XQKXYs=
X-Google-Smtp-Source: AGHT+IFyKGhAgnBnHs2hY1QQ9D6Hr5R8t82L/sW4dp1PjHuHovLXyokm9tr4CqVJBZYnHfc5trQXAA==
X-Received: by 2002:a81:4785:0:b0:5ff:5ad3:72c3 with SMTP id
 u127-20020a814785000000b005ff5ad372c3mr97008ywa.94.1705680509619; 
 Fri, 19 Jan 2024 08:08:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 y78-20020a81a151000000b005ff62066830sm2561763ywg.107.2024.01.19.08.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:08:29 -0800 (PST)
Date: Fri, 19 Jan 2024 11:08:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: remove dead code in bootflow_check()
Message-ID: <20240119160827.GM12635@bill-the-cat>
References: <20240107084340.59954-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wJjuOQyt46MbER3P"
Content-Disposition: inline
In-Reply-To: <20240107084340.59954-1-heinrich.schuchardt@canonical.com>
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


--wJjuOQyt46MbER3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 09:43:40AM +0100, Heinrich Schuchardt wrote:

> The 'return 0;' statement is not reachable. Remove it.
> 'else' is superfluous after an if statement with return.
>=20
> Addresses-Coverity-ID: 352451 ("Logically dead code")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--wJjuOQyt46MbER3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnnsACgkQFHw5/5Y0
tyzNigv/Tm5iJ/oKF9IkvkwxV3BjP4o9SqYytOt51gh1en6sVg6MToLGbiz4kubn
0IQGinji1fHmg2DRNEzUh2N28vc13Juj2oWLFw6tDqcCC/Va4qpFPcDsPowRAQhn
TLFD4/q6GBdeLch/qhb/iqz2yOgJ2WgIjjZANTffp4NWA66yGtpHCRIo1wGSz4XS
APRzMWJrLwoOZCGmv88pWVi4iXsxH52CLrSVb1dVqh7Q+ravX8KeU/fD1LEidI9k
s8nO61RUo9W6HsbQ6z+k9033JGN7iUNlD/SSDPzZKgOEEYwnVi4Kkz1xnLHXGppc
CCwLRgciW66fQxlbyFu7j0sDuUc4L7QgNV+3XgrObDFrY7jfXupUVMxxWH6Kbp1n
xP9x1g6ZulPRBXbzJZVWxDyzhu+EU18DkEwZ67q2plbt3uagReg0A5LdBEfi7SJa
zjjIPqzhrfZsZIPJWS+HCWRJUjmsoLXIqkQXDRIlrmkmmJ+rrV3dzTepDddKmMAT
+XH4aAq9
=bBdX
-----END PGP SIGNATURE-----

--wJjuOQyt46MbER3P--
