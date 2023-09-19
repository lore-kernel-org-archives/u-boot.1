Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22B9CD5BD4
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FBE86A33;
	Tue, 19 Sep 2023 17:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mWeXNl93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E591B86A33; Tue, 19 Sep 2023 17:14:44 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0AA7864A7
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c0b5f984aso46847767b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136481; x=1695741281; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pqgYQW43ORR9VYhoE1xhEkHE+LeqiBeMmQkw7/lEWRs=;
 b=mWeXNl93URtowgpqs5tRZuxCPsClu8ruJB3ICAw2RZXByCpOJPxBR0YE7y4FHC8OIR
 iJcUyRz0C24GdLah6insRkg2z+ryhiNT/aeYDOGB7+SWh1We7rxOE3uP7nDYr2n/fPcv
 vbe0+ZX8YPM/WBO8L85806uHxWEaA4GiWy0gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136481; x=1695741281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqgYQW43ORR9VYhoE1xhEkHE+LeqiBeMmQkw7/lEWRs=;
 b=kW+9xuWrlc++mf/eH9VOEa5z7mEGohS5XrMamo4BOBOW9qfzsls6rj75Q4jkNFhjLs
 UO9/0gtOkciUb3DV+4ezNjG96VH7eU5EfdS9GIEfZ2Ar0K+LpA4Jul7BnDEXSlfI84DX
 LyaDDvLtiRdhus1AHOCUidDsfg+ztxQVE1ZEBjquiUieTgSFHkKsA6maTpiPaDfgh8Br
 P5r3fkBOQ8JIEjO25MrMZOIqdvEPndiQCfYsVm/9bmmAuhezWUtu1QPNnj4xeuf/1jUo
 a2XzsLZhMZD9U4xJAzie9SEiRGY7BsAeJIFOEUYvC40qHIJmXUw8C7E3AbHwdVx/gzX1
 06KA==
X-Gm-Message-State: AOJu0YxeEI16YX1jPGWXofsf/OunYoJpqHBoaIxas3M2MoLIWdDA/1Qj
 bNIhehVe6eBuooGcq5sHluVDQg==
X-Google-Smtp-Source: AGHT+IEMd+EYe1wWccDEtZ8lSdm48ydIsHHC3UwjmfZLsMO3LvBuNFxo9bpjTeIibb9Sf+OSPHX8Og==
X-Received: by 2002:a81:8302:0:b0:599:da80:e1e4 with SMTP id
 t2-20020a818302000000b00599da80e1e4mr12526627ywf.30.1695136481703; 
 Tue, 19 Sep 2023 08:14:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 c197-20020a814ece000000b005928d602f44sm3240012ywb.31.2023.09.19.08.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:41 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-pinctrl: Sync with kernel v6.6-rc1
Message-ID: <20230919151439.GI305624@bill-the-cat>
References: <20230911140256.945074-1-nm@ti.com>
 <20230911140256.945074-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gJndmWFH1L7OOW6C"
Content-Disposition: inline
In-Reply-To: <20230911140256.945074-2-nm@ti.com>
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


--gJndmWFH1L7OOW6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 09:02:55AM -0500, Nishanth Menon wrote:

> Sync pinctrl header with v6.6-rc1
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--gJndmWFH1L7OOW6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJut8ACgkQFHw5/5Y0
tyzmZQv+KzRAPCwWi51MUmHZiailXlu1hr53L7ToagfnU8Q/SeFDLklPTQJPFWV0
OCKEY5UuZz7BzNP8ead05dEy5sBUY9A3cJlANb14NbdK2GsluSh+Y++v4n+8ViLf
VWqlAEqUgKGaIsfqnUL1MHb3J60oa50B8mc1BBAcfc7XaN3aHtMJ30wkwlfr7uz5
4lEM9gl2sPOeoeFN+aYpYUoGZGwCDQeHvfMjWemq6vf3tp33XgsIWLz0HrEJIuc2
C7dEZB8jJnpqQAnxVrCb8npqZdrVFbcORExm8prIynlJfA2b2ieFz2uQQYc8w2uF
JWpS3JBb5NNV3bTF9nLGzqtcPx1pWlacOaS0O24ZTwq06fKKJfxrv6ScVR17lYHj
g9Zw40rLG+phGoG5qPK4LcAyitu7OV372ioXPFqChXszMkqPdn46HocaUe/McG+L
BFWWU9T1mwhwk6pcuVN+dDua36GU0MjhOt1ScVALik4QKmU4qHaJlW7W4szgtLQU
PRw214Q4
=V5Q3
-----END PGP SIGNATURE-----

--gJndmWFH1L7OOW6C--
