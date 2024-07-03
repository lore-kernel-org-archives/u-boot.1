Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2615C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 16:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8498871D;
	Wed,  3 Jul 2024 18:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IzwbyK+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23E188846; Wed,  3 Jul 2024 18:38:45 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D1C8871D
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 18:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5c427f3695cso2855804eaf.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720024722; x=1720629522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cHv8Z/ny7cTgptWGU9ZSK3iAqkEBsFG1cFSRY64nF5Y=;
 b=IzwbyK+2eOd+PZg6JK0uFWwPmyFObpds0vhqTz0+Y9lT92Za9WJGMUGObXJl0pgELv
 hbQDwcqdGdjtlB6HYp1cY8RGFsErYeB9vlP5pIpFnoW6UMnc4jgHUeO+M9AySh8s0s7H
 wqQ41hGrgER6eQ/pOHJG0eLJKm/uts/xediZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720024722; x=1720629522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHv8Z/ny7cTgptWGU9ZSK3iAqkEBsFG1cFSRY64nF5Y=;
 b=n0J5fexMTS3+k+vrlLRNaVziMtmf+vofyM+54RxfJHmO3WaywDKZCFpXJvSDpmTV3J
 8HV6E3uKWx9Cu9Q6LS38GZ0r3Ch2onG1Sw3YgSi7eLpkFoYS2MzLDcRKPdFHd0ozIdzF
 xVxt4DaxiymVDUo0ELC6bTWVdzmHOvouHL6133BL0kJW0alSdGfKCzYsBvbPT73s8RHt
 7j+w7H/sVc2AFT9W+fPo+eJ+0aj5iUWuY8oBqtTVx6/EzYF6fNlyiMIZ2ibtUp8sRIjU
 Yh39n8XcT+/t4dz2lGuuag7kLrgsyfXWvIPQMEyC1Qhl5d58PzIZkVhaww/uOjG4V/mt
 UPtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgbGIFqpnKc2fbhRDuwtH/M97UCeTlOpHjiiK8QzGzzfA4OcyX3ulLJv/ykbQxVb4R2o9OKkmDjGXsSirxIx8k+XXLRw==
X-Gm-Message-State: AOJu0YyLFFEjBqezMfcqQyLmGXPjSBNwcaM2bGnyVnQTtNpxvD21dC6a
 sHP/ilRCwD/3mL7KQQ26v0POtQdvsKMHSaTUgYI9D2GlMQag/EcgtqZVcST0oYw=
X-Google-Smtp-Source: AGHT+IGyRZJ0+2X186aeQIwrdXJG00t+563tWDyMYuIqlDBlbtCslOyD3Ybfk1wNGYXINBlcTONeDQ==
X-Received: by 2002:a05:6870:2246:b0:254:c512:88c6 with SMTP id
 586e51a60fabf-25db35db53amr10845480fac.51.1720024721749; 
 Wed, 03 Jul 2024 09:38:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e214892a1sm47545fac.32.2024.07.03.09.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 09:38:41 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:38:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/12] net/httpd: add httpd common code
Message-ID: <20240703163838.GZ38804@bill-the-cat>
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113939.100620-8-mikhail.kshevetskiy@iopsys.eu>
 <CALeDE9NZFy_XFaWj=LOFw6BvqhcC=hs8QCwKg3VRfbCzcJFZkQ@mail.gmail.com>
 <9228e420-86fb-45e8-baf7-8e19e9b0cbe6@genexis.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CRI/pKmxQ00ftffO"
Content-Disposition: inline
In-Reply-To: <9228e420-86fb-45e8-baf7-8e19e9b0cbe6@genexis.eu>
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


--CRI/pKmxQ00ftffO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 06:06:52AM +0400, Mikhail Kshevetskiy wrote:
>=20
> On 7/1/24 19:54, Peter Robinson wrote:
> > Hi Mikhail,
> >
> >> This patch adds HTTP/1.1 compatible web-server that can be used
> >> by other. Server supports GET, POST, and HEAD requests. On client
> >> request it will call user specified GET/POST callback. Then results
> >> will be transmitted to client.
> > Why are we adding a HTTP server? I don't see a cover letter explaining
> > overall what you're attempting to achieve with this patch set so
> > please add that. Also I suggest you look at the LWIP patch set [1] as
> > that may make what you wish to achieve more straight forward.
> >
> > Peter
> >
> > [1] https://lists.denx.de/pipermail/u-boot/2024-June/556526.html
>=20
> This patch series consist of
> * TCP fixes. Current U-Boot implementation of TCP is bad. It is
> especially bad for uploading. This patch series fixes TCP support. I
> know about attempts to add LWIP to u-Boot, but it's not in U-Boot yet.

To be clear, baring some unforseen difficulty, lwIP will be merged. Is
it ready today? No. But I would ask that if people have both networking
background and desire to do U-Boot development they look in that
direction rather than enhancing (rather than bugfixing) the legacy stack
further.

--=20
Tom

--CRI/pKmxQ00ftffO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFfosACgkQFHw5/5Y0
tyxW3Av/cYGJ+MMA5WLc2bEhjm4EuXsL5e4JYQzyLTvzGPpus7ZThV/KfD2+T3Sw
STbjGPLskYzjSp/L0173WBSkr5VG0bDz40t3X/wvXdeDWoRKN/fLm16cTX0l7qM4
cFuaShmZJOeInbtiooNo/9YLHt1qRzEKb6yb5q61ZkKvRy7AyaDJZSm1+arTq8Ns
0u4uun3CT8zb9FNBa61ws8RsS4evesGrXOtOX4oogCdm+b1JXQ0MgIMypyzu/4CL
5Dgp1/63hyQlkjVZ4QAGau6/qy3JltLt8W+c0PqJd00/tIPQDGT/GzLsny6yxmrc
VnWVWK1CA28AmvbGIobTmzcOmWpguJw5G9OhaHDkc05PHfeOCBgsjE1er9PKGXAx
ZFH9mJRfp3kWdHaPf8wmZR2BFkv2rq8icPe5yqTjRWxKHm+Os8P75vWTyxqcC4s9
pe0DaSeoEIKlTGYUS9l8CCoxiiMDj/6RZOY3yNEOAGJnVKkS/QkGlqIEUJchpJwe
OfDyA6UR
=TsFV
-----END PGP SIGNATURE-----

--CRI/pKmxQ00ftffO--
